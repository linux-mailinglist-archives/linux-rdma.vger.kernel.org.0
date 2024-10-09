Return-Path: <linux-rdma+bounces-5337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3152D996DCD
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6316B1C2292B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAE126BF1;
	Wed,  9 Oct 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IRQR2Fhb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF818EAD
	for <linux-rdma@vger.kernel.org>; Wed,  9 Oct 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484209; cv=none; b=VAK58DfCKqS+Bfm2x6XB4+Maz9cSEuJIDD6nDap8i+5cXKEq2ddqqUHpfPkRb0VE6rugbqPKAlwtRhZVi0bJE2A0U/NTxVNx2KPNFqHYTMO6OkeUpegBVawE3fLTZC6TwOHI3K9pgtM1cVsxNPhsDmh/BR02fILKTTGN3X/3jAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484209; c=relaxed/simple;
	bh=6DUxtqFeYCk0yVNMLdhvhgUM+KP6wb51Y9BDmTKikvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRiMESzKLeM6jcsWvXgYEqILf30YalI7CcAo39hOG3V5NC8fF0OpD0gKQAkU4vG9ZvvtnhLanJ8I8ZeoGCpwdUXkUGyR/ik5fK2GjkMRTpuaC+A/GXotRHuXIG7PJEvi725qCu3j2j9C4HcEqBwL9pYn0iHBcZmsu0Gz0lT8nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IRQR2Fhb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so7139015e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2024 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728484206; x=1729089006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYe0UDJwZywf5zVofsmCoLxxt4WBBMPiUob9KTaisSA=;
        b=IRQR2FhbuT2JRHCcfVHueSiaLI35s7TST7fzhbTXTnrt4DfIw/41rvrWR5pVfzqqu9
         4bgfmiqgbbS4UWBvk35I52/Su5IOwKyd5FpsXZlb83ZkW0GO1mQuGjc6Yq5yx0RrA3eb
         UzqU9RvUNL48/UEg7SCVuPB8gz3i+5rX3DNx9mjKo4zGNjNAAKt3ceMbjgvRJD3fTA4U
         3l0Bm0wALwpeTVFUiIz52AxPpRglIm8DW4rBBvDjc46aWyPkNZJh90r1btF0rjCOe1nu
         hG1MLb4j0b7XPKWCssuZlakanunrfZbnoP9djcJHJvRTSYZVBY3lYMYd7jwvojb91G0U
         I+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484206; x=1729089006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYe0UDJwZywf5zVofsmCoLxxt4WBBMPiUob9KTaisSA=;
        b=BVI1q24CdZ+UM+6cMabm2Xb/NZ//HMRlTMoc2pPUunH34SF6AZihXbmF+w2UGq4+Bw
         Og8TDidQjb3aEOkh7p3fh+r5+244JLBMBP/Ard5fiW6oImWrXW3wQocPJe31zmAiO9Qy
         dWzMt2iy44JoQuWfj5pROU349yUMiLppED2EWBZCZvFoG5FYXGoTGA6QZXkXGBUkxq+A
         A902UAMjJbNDWGW8m4ZdgTNjIhQALYaaEFuqvCPeRiLaZ+bkNwPEf9Z91j7F1yMqaX5b
         cv6Td4+beohmnKNCrpJv1NcGbf36EcYwpA97N3RBsYNvVWxcGS7gLDdf+B+2YoDpYwhp
         i+sw==
X-Forwarded-Encrypted: i=1; AJvYcCWnOLTzP6xvT2O2ONx63ZE6bOa+tybS6LzyFDPx6RCoKW2C6Ns5LFT1JD8YFpDzonC/JPG8aObeY9G9@vger.kernel.org
X-Gm-Message-State: AOJu0YyyW0kkv6ZWk3BI7v8l9k8aSXPNlgirOSOGOlH5Yml6Ddfnoyl4
	glM2ZsQCwuGJv9LbOl4C4SoPn/N5/os+n+KQ0Gq3wQ4oHNJ0qNFx/CllcKWvFXc=
X-Google-Smtp-Source: AGHT+IGlS2o4g/GZdl5D/67AlFAU0IALKSNCiQ5PhERwo+PloE/WKbeKZuNI0nFK8YJ1ev0hhpW/4A==
X-Received: by 2002:a05:600c:1d09:b0:42f:68e8:d874 with SMTP id 5b1f17b1804b1-430d70b3e15mr19146415e9.31.1728484206301;
        Wed, 09 Oct 2024 07:30:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf4f7aesm22176065e9.12.2024.10.09.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:30:05 -0700 (PDT)
Date: Wed, 9 Oct 2024 17:30:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/nldev: Fix NULL pointer dereferences issue in
 rdma_nl_notify_event
Message-ID: <a84a2fc3-33b6-46da-a1bd-3343fa07eaf9@stanley.mountain>
References: <20240926143402.70354-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926143402.70354-1-qianqiang.liu@163.com>

On Thu, Sep 26, 2024 at 10:34:03PM +0800, Qianqiang Liu wrote:
> nlmsg_put() may return a NULL pointer assigned to nlh, which will later
> be dereferenced in nlmsg_end().
> 
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  drivers/infiniband/core/nldev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 39f89a4b8649..7dc8e2ec62cc 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -2816,6 +2816,8 @@ int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
>  	nlh = nlmsg_put(skb, 0, 0,
>  			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_MONITOR),
>  			0, 0);
> +	if (!nlh)
> +		goto err_free;

Need to set the error code before the goto.  "ret = -EMSGSIZE;"

regards,
dan carpenter


