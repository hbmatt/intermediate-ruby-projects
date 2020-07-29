def fibs(n, result = [])
  i = 1
  until i > n
    if i == 1
      result.push(0)
    elsif i == 2
      result.push(1)
    else
      result.push(result[i - 2] + result[i - 3])
    end
    i += 1
  end
  result
end

def fibs_rec(n)
  return [0] if n == 1
  return [0, 1] if n == 2

  fibs_rec(n - 1).push(fibs_rec(n - 1)[-1] + fibs_rec(n - 1)[-2])
end
