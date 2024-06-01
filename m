Return-Path: <linux-rdma+bounces-2747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F888D6FE2
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A9D1C2148A
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jun 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B31509A1;
	Sat,  1 Jun 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C745STl5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65E14E2E4;
	Sat,  1 Jun 2024 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247194; cv=none; b=iskFkcM7zSJMeKFCU5Q9yvMhd26qlIeZGE8R/RFFGDD+3eDFk9so9RmtsqMqDCEav4RpnphKbmdSNOuBTpeBNahALBQXKvC779U5++DqM8J8wb8MfjgAFgXOYIaHL+5Gyx5fE8h6mIEfyQSpnivbuU/oB9AU0KAXaCITahCDH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247194; c=relaxed/simple;
	bh=pUHMnLaHbw8fQVrrxom6RhMVZBz2hDqPwbP8h+otBQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d382zeuIbUPXFdC1wBjzEl7dZa/VRtvN5I7s8pdTtfCwOGok3EoffuwD5TTm67KMkBQgGU//gA27le1sJA2sJ0uoo8v3Lv8RLijaU7nXTzeliryCJO4bPFkOHi0fNB35i4oER/gWyO9HbhmxsnrUzSAy0EHOqgHgujiuaAckl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C745STl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93421C116B1;
	Sat,  1 Jun 2024 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717247193;
	bh=pUHMnLaHbw8fQVrrxom6RhMVZBz2hDqPwbP8h+otBQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C745STl5epF6aTYeO8Z9UCteuLF1VypR0q76OamDulIddu6EGywENXKWxFO5qZnpT
	 eTxA0XIwAzafejYUfk6H1h3Jp82Fzs70gMQ5dioQQfCc9vGwQ8y4lKJKphX+Gzt4go
	 aLChAKfyBMF0x0p/SuJg94gp7o23i43qfgCTUfj921SwUPtO6Ve/KnWyfzHxq1yiuY
	 KDcoaXHMd+5ST36ksBFPO7l+EfJ37gioTffV9r91MOBdFYRiDFDhnS3DuljU3HqMhL
	 XZzDnzcZ3jkvV+3JF7zsC65K62/uDTrUSTBI4r09K4QPapIjbw2StSnbrE44YzKdVl
	 eTnCesujt/SXQ==
Date: Sat, 1 Jun 2024 14:06:28 +0100
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v4 3/3] net/smc: Introduce IPPROTO_SMC
Message-ID: <20240601130628.GK491852@kernel.org>
References: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
 <1716955147-88923-4-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716955147-88923-4-git-send-email-alibuda@linux.alibaba.com>

On Wed, May 29, 2024 at 11:59:07AM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
> 
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> 
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> 
> There are several reasons why we believe it is appropriate here:
> 
> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
> address. There is no AF_SMC address at all.
> 
> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
> Otherwise, smc have to implement it again in AF_SMC path.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

...

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c

...

> @@ -3594,9 +3595,31 @@ static int __init smc_init(void)
>  		goto out_lo;
>  	}
>  
> +	rc = proto_register(&smc_inet_prot, 1);
> +	if (rc) {
> +		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);

Hi,

FWIIW, my feeling is that if a log message includes __func__ then it should
be a debug level message, and even then I'm dubious about the value of
__func__: we do have many tools including dynamic tracing or pinpointing
problems.

So I would suggest rephrasing this message and dropping __func__.
Or maybe removing it entirely.
Or if not, lowering the priority of this message to debug.

If for some reason __func__ remains, please do consider wrapping
the line to 80c columns or less, which can be trivially done here
(please don't split the format string in any case).

Flagged by checkpatch.pl --max-line-length=80

> +		goto out_ulp;
> +	}
> +	inet_register_protosw(&smc_inet_protosw);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	rc = proto_register(&smc_inet6_prot, 1);
> +	if (rc) {
> +		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);

Here too.

> +		goto out_inet_prot;
> +	}
> +	inet6_register_protosw(&smc_inet6_protosw);
> +#endif

...

