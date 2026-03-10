Return-Path: <linux-rdma+bounces-17915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHmqFqaNsGkukgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:31:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C122584FF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 22:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905EF3262FF6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 21:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE0C3EF0B4;
	Tue, 10 Mar 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxgimxWb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3A3AD525
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177891; cv=none; b=OXLHtuJ6q7c9ljQyc9aOf7yv6+Z4nVjA26gy54LsF2njrZx0F9VqQOF5t6b4pQhZwQxupUOCv5JUn7nsdpDXCWsbBlBQookW194esy4m7/mo9rSsj+0oDX4CNMME9agx+HrUZAsPWtRv1M7pI/CoXuRDRXWsL1t0ueq4/vgPRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177891; c=relaxed/simple;
	bh=b3ECRG/jGXO0JjA9PRWRoU331B+bXCQriTzpMDbovU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZdabg3bKFByQySCNOLi0GxJxSWQ6DLsy39jMK5dCmrOX2dL81Zpz5gpKJ0n27FNAF2JsMK3rs6YsmMIX4P+xVyqTJ6+WI/9k6y8pnKr+tru/Ayu8f/uK3eaQl/d3aBF6bxh/4crk6g+ChAeEUHNAQ4mTYYEJdL/pJmW6IyGcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxgimxWb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c944bb62so4942436f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773177882; x=1773782682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+2joFWWQHIXoC1xyoVatQK7FtmRRXNESbtQ+rrIghw=;
        b=CxgimxWb47KKGAlB4ha/SWnxwBst2hZX9Vauy0z4DLnbS+qF2eiYvClUNzLHoInAy2
         LoFwxEmafLtCR3BXbIPxGlO+fS1LAIPZbjDLUfIP+Y36YxHUtlfIJBqfLo54R5aCQrm4
         lrKUSfEXYax36BlPy8r8frGccr7x55cMwf7RVBfPwHtRyDV56R/eSbKav0Rfv3fijp//
         ITcaSVRedEIbmWmF9M5TyMNDkYQhKOVOZ6sVvumnALYRQMUkn+OXWs24lwdA4RYkdD9O
         z6KKAbI+doKurCYHtcoJSa/ixlTZUG+5Xt64ia8+SVG0PvoOz8SIazewTMlxMB6Dqf1L
         kolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177882; x=1773782682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W+2joFWWQHIXoC1xyoVatQK7FtmRRXNESbtQ+rrIghw=;
        b=jdfQNh+2kVZuQTejUkoHvB2/ZNO++jcRz1sbt6k7+bn8csVOENqnHZ6zZ7nbY6eaPQ
         GUZy/kFeR4zfFNgpFuMrnuAABprmzH1kC7rV7e7PslAYN0+PGJ7zU70NnSEysGQMr28P
         0MUMh4+gaNEkxrnMASV44My4xLDk7uvcBMVk6A7F9AtN3s0u7jxc41kMb7ZNY6lB32B4
         TGrECk02ejHl0mC/G98JPK50kksskx16+JT1pvyn9jaVBiAAhkkB75Lwh4w7EyufCgTI
         5uOXqJD0FmkeeFG50h2iJmHxH7qKX9LQKqclgQ77iEgQV0riB4oPixb27gVkyqt6TRJ3
         BKEw==
X-Forwarded-Encrypted: i=1; AJvYcCXhBx1GAlAngtX0AsmJBELPoZB2qZTcs2jIFjqdeuYw0aOj5RtDMv76/neO4cDwMRjMWGJOQpaoxE6j@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWf6xSjM3OiyPGUlF8gYK3WABuGMqls4IqWlQtDayDtPPS0pL
	GcFElUsfG5InTedWb7uVRGAnaLrVb1tIqGtJBTgDLTN+2cZP1R+ZZesK
X-Gm-Gg: ATEYQzz8Ewdfn/k8aEjvFTEMO0kKjzXyOtn+3JrpEoW0vKqdVpUYl2/CHnz9Cxa+mAR
	slZ27Hn1KmA/XF8Jv7mW4XpnBSTXWEAZhm8jOkZTwgYQecbpQTIiM/u1mjXsIbRsEmm7VNYiKgf
	0AcfUjM4kzib3jya5rqvijFpa2dxDvBXLexq9ZBsN2BEXQHgQkaNH+2uD+E3PRYgkUTPxdGqTGk
	C9oxuYNyLdaE/IyhyyfUz+a+Cv9AbGwxGRCGk/3eE0fR3LZBdA80b1OJgl9kcqoKXu8PxZckWLI
	kDzFZ6Pg1zleHBqyN/h8fqJNRYzbwLiNdBopIVDRcybgND2yQoiGKxddzDEx4TedSW6yJajMael
	nMFCZIaPI7HWfwkRSpz4FY/peey2icrDiv01U+kY+UvTG8YEVyO6zbnBkLBwFxiGAk+REEz8m4j
	QeTsy6WhEigqJ92MJY+vsGR1CPu5n+c2Sk2m3XBmv6ErHLPXwMksYsiZZiwjqiZk/N
X-Received: by 2002:a05:6000:2913:b0:439:b3d2:3768 with SMTP id ffacd0b85a97d-439f81c8cc0mr815295f8f.21.1773177882141;
        Tue, 10 Mar 2026 14:24:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f821e32csm948153f8f.35.2026.03.10.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:24:41 -0700 (PDT)
Date: Tue, 10 Mar 2026 21:24:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use clamp() in _mlx5r_umr_zap_mkey()
Message-ID: <20260310212440.0df8180c@pumpkin>
In-Reply-To: <20260310145727.236094-3-thorsten.blum@linux.dev>
References: <20260310145727.236094-3-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D6C122584FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17915-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 15:57:28 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Replace min(max()) with clamp(). No functional change.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/infiniband/hw/mlx5/umr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> index 4e562e0dd9e1..1a6b0ac5c24d 100644
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -1013,7 +1013,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
>  		 MLX5_IB_UPD_XLT_ATOMIC;
>  	max_log_size = get_max_log_entity_size_cap(dev, access_mode);
>  	max_page_shift = order_base_2(mr->ibmr.length);
> -	max_page_shift = min(max(max_page_shift, page_shift), max_log_size);
> +	max_page_shift = clamp(max_page_shift, page_shift, max_log_size);

Is page_shift absolutely guaranteed to be less than (or equal to)
max_log_size?
clamp() doesn't guarantee the order of the comparisons.
If I read the code correctly it changed a few years back - on a commit
that said it didn't change it!
I think clamp() currently uses the other order, I looked at proposing to
swap it so that clamp(int_var, 0, unsigned_limit) could be valid (returning
0 for negative values).

	David


>  	/* Count blocks in units of max_page_shift, we will zap exactly this
>  	 * many to make the whole MR non-present.
>  	 * Block size must be aligned to MLX5_UMR_FLEX_ALIGNMENT since it may
> 


