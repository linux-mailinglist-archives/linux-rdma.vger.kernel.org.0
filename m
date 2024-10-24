Return-Path: <linux-rdma+bounces-5509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113419AECA2
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 18:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C871A281EBE
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57B1F819E;
	Thu, 24 Oct 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHWw6Tyr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAC167DAC;
	Thu, 24 Oct 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788690; cv=none; b=BHHb30onB3GZqK87huJmPq3rDDdJ/QAvmAJGYfjRfoWdy4/nraE76+iOyMKG6B91eD6TPyMcawxjpCH/lmE0929/y+W3VUOzNCkb29k4zdkk36wzRO4KVwIwt6doNhwDgfshw8WYRYidGxHI9tNq7YewG8Xr4pLPtbJCMLGo+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788690; c=relaxed/simple;
	bh=4A786CPjDvqACnuzx/J9DqOF5YWtyQ0b8FJojeoO3S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCbb6cMzV8Fym3S5mFWX0Y9e85RzHrhZueffogE+FgG8XK1MuMvufVrtFCf+/2cNc2TX0mt494eQqQl5yuk71jLoFdNh8YGUJHJHgsXHM0zJgWnrPbwQGNGvn4cAtbEj6EaUMrishH+1yBHbTj5awi6dCVmcTJEkY4kjhbNGNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHWw6Tyr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so896955f8f.3;
        Thu, 24 Oct 2024 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788686; x=1730393486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0S65iBcIJZZEOd9D4XzJaH7aFYD4CGJUi+zHz0Iw5Y=;
        b=jHWw6Tyrm97G4A0W9uqN2XwCle4izECZcIxTPRjVAZsnku8EYzMiD8trRWNEzK2/hy
         6clWJb3HEfdpaABr7E/YAyBshq4ktEdx9ZeagH7SyUiuzviKj8ktG9yqg8fOBu2qSyJB
         8uMFhj4CdqglLYJUX9xapyvhJ1zXPd4FXmLIlBo7oUs0gxKvjpZXMWEkXU/dvAeanZeZ
         phl5P8lw7lmRkxVJ7KUwgik5Vfpx+57tu7eQtb+bxtcYblNczvNLt7smPukRYsznk4jV
         nuFxSdgAw1cBe1B5dbcrx6y1aLE8pbXxIQfDEF8GcZ/fZvzupGjrqeRKq8zAfXKan/vD
         NSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788686; x=1730393486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0S65iBcIJZZEOd9D4XzJaH7aFYD4CGJUi+zHz0Iw5Y=;
        b=vShGpMksW+YnYn8HRYI+rOnNbKv4kfzbXwj6xLYSYbZdaP1ONhFFRMzMefTtMgSzrA
         MdxEbevzbYF61Uw5MbM6kTdBq4A/TdJuaPCbfdOEjxXjS81r8c0dm2LVrukIHu3xD+Dq
         C0zfb3mS0hlhoul/wpE+AbPbg96Um47FOSFm3aDOderWbbvf/eH13hpO3/P/fjYhliKL
         DLFETeb4nYO3ZZyWv4n+WA61FPgBViGvBktLY/xQxeAUc59oh17GFxQUBSxi0u9CXc0i
         txMVw8ICkShWO7Fz/meJlnttKdauKq89uXvhd0Qc/xrtqjmTDwsf/QyUNjEd8PYmfSMI
         IDNg==
X-Forwarded-Encrypted: i=1; AJvYcCW4vzVND/Y9NWFkL3ipIccaQbZi4SpAlfaZ1LjmXMlhHff3ZiwFMnM8TsTgjuZeandHwAlfW1bZI11t0NY=@vger.kernel.org, AJvYcCW6JAahmDdpMGClQeghc55/oNxHivahrWg+RJkqG88Lct+q6cX7nz8JhgdNGdprEDT0mb8yua5V73BcjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pQtZJll/ijsAybNgR+kPE6eaGYxqM6WjBeZZCkVvD32E/Zw3
	0EHw1yEnxRmfqdjBZ2zFrYnQQd0hmKO+PVCWjVnjWIkDCTxiG3cC
X-Google-Smtp-Source: AGHT+IHwrCxLSJOjJMV5Ts1Ngu/tZbfdEooa8kHhZMTgRc2L6Jfblh8rgsO24jf2Bsh8xTQO7V5z2w==
X-Received: by 2002:a5d:5609:0:b0:37d:4e74:67c with SMTP id ffacd0b85a97d-37efcf73d4emr4234806f8f.39.1729788686111;
        Thu, 24 Oct 2024 09:51:26 -0700 (PDT)
Received: from [172.27.21.144] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9405asm11751487f8f.87.2024.10.24.09.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:51:25 -0700 (PDT)
Message-ID: <5db365eb-2da3-4b5b-9ff7-58cd4af6d20e@gmail.com>
Date: Thu, 24 Oct 2024 19:51:22 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mlx5: fix typo in "mlx5_cqwq_get_cqe_enahnced_comp"
To: Caleb Sander Mateos <csander@purestorage.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241023164840.140535-1-csander@purestorage.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241023164840.140535-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2024 19:48, Caleb Sander Mateos wrote:
> "enahnced" looks to be a misspelling of "enhanced".

Indeed.

> Rename "mlx5_cqwq_get_cqe_enahnced_comp" to
> "mlx5_cqwq_get_cqe_enhanced_comp".
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.



