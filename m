Return-Path: <linux-rdma+bounces-21285-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCM+A1FxFWpbVAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21285-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 12:09:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C75D3F47
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 12:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 793EE3025C49
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203CB3DB655;
	Tue, 26 May 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTxvaGzt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1633D649A
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790151; cv=none; b=F1IW9dCER9q4JgoOUZd11iYFcLiPcXZGzjkAWzGlmwXCMIujpIrPGx19K4NIuTBdaLlgsdrI0pm7SpxZWRqyU+rmbAiHHhKqRXyaer6aEs8W1chxsZa+tl1voJsdyPEFIft0lkc9aWLwos46T28UL77XQOWd7S9DN3s+qFi4zM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790151; c=relaxed/simple;
	bh=BJ+37IuAjAouSblZo44lXPzZcdtzmRe5yJctpqEfmVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJlkKzy2owYAXJGcPS1tJWIviSiUAKSKw11N2Uw8N2vDYCmH9BjUWtVum/VDSh9GS7+DoGymq+mAJOzruXYjXEHK1juhhxr2wG4tt96gNNiJa/726YpQPzfjcJ+aWbJiiIA0dhe8vzqa5zwX7oSB03l6VnIcej8HASbnFaha6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTxvaGzt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44e1860558fso6633714f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790149; x=1780394949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz28OK+5uRErvSO52GxHA4GJ7xySuYdInquAfmtjKwA=;
        b=MTxvaGztoMb/Kk+QGhfNldzNfZejvaHY16o5/BTonUXNvj4vySSPlu1I6ZSpaEOzl/
         BAM+n3sj9gYSImpbXgTwbpDREtCNLhZY5Wam09Bu0xY83ud5jCDdQT0ibn8fK9uC45Ke
         Ff/WxM+qR9LbIAtWTYmWJHHlOuW22eGOGn5HeCTamLfXYz8jKc/8mbti30U3/Cwk4iTE
         wh0uvdyAD7pOfB76U8u0jPFBapm3jsnGGpVzYqpt4dzcK/Xt36SWQhH74A1pTaTAAkA+
         dFlgL68M7IKr8doXtA3M4l+K5FIX5r1pHs9IFSsX0xYcJwfkiSMEJlKZBEWZTY0ymcQF
         34Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790149; x=1780394949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rz28OK+5uRErvSO52GxHA4GJ7xySuYdInquAfmtjKwA=;
        b=qM19GTt4UZA+XrniuU1wH/p2QVBreSPfnFLXYpmDImSpFJYJB8obEfMFEduhPN3mFu
         TNNUms088KjCTyJ/9ZtalpNIWrg0c/s5DuvAL3FM4ZStNSlHr8d6aRcZ4XzcLuk3pQ7U
         ofHUZgzBJqf34Vj0brIKFbgyjK8KphnytEItPSrWJoAoDWFfOb2Ip5WlexEP6guQMyvX
         Twkk5+tCTYvT2crfVPP6bUEEFau69wwf9Z8/NMAuY8kWlqAjX+TWf6mm+YhleMccKTvb
         oOcUW/PkWrBwrJCaR0ZvEt5Zjvf0/3o8Oni7841FngqBZDzKGyAEz8NPUMXeZ4ZS/emh
         9rNA==
X-Forwarded-Encrypted: i=1; AFNElJ8XGdYKRBLjNXwhschpaXHo78QZAfgmBEPyFOHuAMY0hUzeR4o4hRisiEUHagOEPA1wegA6NeKbmS/e@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqwI+aCfxtL661NUkA5hAC/Popa2AnMD6woKh/OD4WKqZ22M2
	yj6OIel+CcbTjFhJYGLUSOUnbUDFh3Bf5EkdPUIq9IRKDYoJsXeW9gYZkN+pdbb5
X-Gm-Gg: Acq92OEYRs/A9rVmGg0hwEKiV9nRJh/8Rg7TQ7m2Qwxo0Mmus0r/sq49RK51g9mDOTM
	XBvH9TC/4YFwaaB4DzX4gPJniScyXiCuHFE6+VXin0m0cqowC4t3TApzgg0PbODSZ6p039VkC1X
	wpylkHyga4PZ6Mjr+BwuI8cmYxmsxikdSHSsJ/UcH0w2SDeq0H4ueEGKOnFF9y/xrifezlR0fx/
	PiYnQlvjTqj1EE4Eg/KGRT8LqVDx4vGh3xAn49NuVIuGZynEcD+b44sTWJ2TSxQd/fG49vfslWw
	/r+ZAYL2I8HWe2dvuc8oZG7qYE/MGfP9f1oA3h6ymFIPXJyBtb0endb6ctGjn/hhemdmk5DPv8z
	RcS/tJRiTAUCzWDR3Ib1AhA+nuSU3rGkbIcCjPBzAduitEKgyrINTubuaPreqbbmuHMG/34Fh27
	aX6dd5VsDe79E+ps1K0EyBxBmIUrAQNsw1Yx4ph6KxdT2o+b7rwP5tSSZ7TI5YMjIK
X-Received: by 2002:a05:6000:25e3:b0:45e:739c:f187 with SMTP id ffacd0b85a97d-45eb38c5329mr28176468f8f.22.1779790148603;
        Tue, 26 May 2026 03:09:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f58dsm33661340f8f.5.2026.05.26.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:09:08 -0700 (PDT)
Date: Tue, 26 May 2026 11:09:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/mlx4: avoid GCC 10 __bad_copy_from() false
 positive
Message-ID: <20260526110907.2e9c1fe9@pumpkin>
In-Reply-To: <20260520102130.423044-1-sangyao@kylinos.cn>
References: <20260520102130.423044-1-sangyao@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21285-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 796C75D3F47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 18:21:30 +0800
Yao Sang <sangyao@kylinos.cn> wrote:

> mlx4_init_user_cqes() allocates a single PAGE_SIZE buffer and fills it
> with the CQE initialization pattern. When entries_per_copy >= entries,
> the function copies array_size(entries, cqe_size) bytes from that buffer
> to userspace.
> 
> That copy is actually bounded by PAGE_SIZE in the else branch because
> entries_per_copy >= entries implies entries * cqe_size <= PAGE_SIZE.
> However, GCC 10 does not derive that constraint and falsely triggers
> __bad_copy_from() in mlx4_init_user_cqes().
> 
> Cap the single copy_to_user() length to PAGE_SIZE to make that bound
> explicit and avoid the GCC 10 false positive.

Why not just calculate 'entries * cqe_size' and then do a memset_user() loop
for that many bytes.
(There might even be a memset_user() function, a quick search didn't find it,
but I didn't find a memzero_user() either - and I'm pretty sure that
will exist.)

-- David

> 
> Fixes: f69bf5dee7ef ("net/mlx4: Use array_size() helper in copy_to_user()")
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
>  drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> index e130e7259275..7b024a5e13c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> @@ -314,8 +314,11 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>  			buf += PAGE_SIZE;
>  		}
>  	} else {
> +		size_t copy_bytes = min_t(size_t, array_size(entries, cqe_size),
> +					 PAGE_SIZE);
> +
>  		err = copy_to_user((void __user *)buf, init_ents,
> -				   array_size(entries, cqe_size)) ?
> +				   copy_bytes) ?
>  			-EFAULT : 0;
>  	}
>  


