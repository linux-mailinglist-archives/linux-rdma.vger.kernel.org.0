Return-Path: <linux-rdma+bounces-8062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05EFA43627
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 08:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CDD3A7BA0
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8925A648;
	Tue, 25 Feb 2025 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EXuXFZ0K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616CF1624D7
	for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2025 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468470; cv=none; b=pfoNn0VbtwdxiQdwz6utcv+1iNBUfYDSdEwv6TuJlrszXKtKbpJe0JiTfYFh2IyinkA2TcmiubO5fmwndyXuq+XPb0jnRZZQ+zNTD11FmXm66apkgl6HZo4D3uLdRqpezhvXksJUMze/kn7RNV6Xs7bLniNSCr4WwPPXisVyr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468470; c=relaxed/simple;
	bh=dSA9kDqBgegy0SMgQYRWpEx6KSfbEU2AfXKqMCg6nQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkGM1mNT5be0Hit5ut9gHUusHhP0vJIo8iFF8q0G9YX8SdgDBP9VNYvvCRwsZ3zsBBsu8PXIMBY4I88eJjKpWB/iDWUmTE4kpsZyX8mVyFp6MW6fvu+Rk+ilRmtgiFg0+OyYTBAmVe5veaEYNOhqoHQ635L/Qijkb6Zmrfr/fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EXuXFZ0K; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c219d7ab-53c0-4993-b077-263aa25029e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740468456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fock6seyadwHEiAoaiFNeUEwiG+JiOu14JVNSTCajBQ=;
	b=EXuXFZ0K323ixf6ygjA2wxtX+ztNPfiRP3Z8uM5VdYI1dEBydhduToUvgo+nTt9ISdM6dn
	AgGsDZIjOzUJ4Ty2dovACTA+Llgn00D5sfYkB9H288JfO97Pu6M9qd0g8kM+O09uEXcWY9
	tQMw/nVePE4sAFConms5be54S/kb288=
Date: Tue, 25 Feb 2025 08:27:30 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] sysctl/infiniband: Fixes infiniband sysctl bounds
To: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Joel Granados <j.granados@samsung.com>, Clemens Ladisch
 <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jan Harkes <jaharkes@cs.cmu.edu>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/2/24 10:58, nicolas.bouchinet@clip-os.org 写道:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Bound infiniband iwcm and ucma sysctl writings between SYSCTL_ZERO
> and SYSCTL_INT_MAX.
>
> The proc_handler has thus been updated to proc_dointvec_minmax.

In this commit, the minimum and maximum are added to the proc_handler.

It seems that this will not introduce any risk.

I am fine with it.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,

Zhu Yanjun

>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>   drivers/infiniband/core/iwcm.c | 4 +++-
>   drivers/infiniband/core/ucma.c | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index 7e3a55349e107..f4486cbd8f45a 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -109,7 +109,9 @@ static struct ctl_table iwcm_ctl_table[] = {
>   		.data		= &default_backlog,
>   		.maxlen		= sizeof(default_backlog),
>   		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
>   	},
>   };
>   
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 02f1666f3cbab..6e700b9740331 100644
> --- a/drivers/infiniband/core/ucma.c
> +++ b/drivers/infiniband/core/ucma.c
> @@ -69,7 +69,9 @@ static struct ctl_table ucma_ctl_table[] = {
>   		.data		= &max_backlog,
>   		.maxlen		= sizeof max_backlog,
>   		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
>   	},
>   };
>   

-- 
Best Regards,
Yanjun.Zhu


