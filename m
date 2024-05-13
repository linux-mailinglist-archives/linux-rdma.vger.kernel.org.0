Return-Path: <linux-rdma+bounces-2465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2648C46BC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 20:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6791F21978
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30424364D2;
	Mon, 13 May 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuTpDKT+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093B2E647;
	Mon, 13 May 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715624071; cv=none; b=KWAW7umYiG/ItkHwr1eqCCIDmLi3FVM4vSeTDJ9TDwEKAW/x5uVCOIj7DFN+qbnDJPrxyUGkWiNVdUg8FrRP3EZkzThhSb+Frsfj5RCwu/5FxHNIRydktUh1G/+ncCOlU2/Xp2yVw79sSSsR4bWmGeVvQR15+0/UuDb3SsjJc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715624071; c=relaxed/simple;
	bh=+rxemvwnzoV10RvCe8M2I4H331E50lxDd6UYYKgz8B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhRyVDenyDZBlZmDInYSS561kBsVdU044XBVkskFDi+kqd11rT9kur0C2L/WSkVvY7ReZcfwKGuLHHlu1mRgPpdshgCeRM5jcriRZZ/itmx/r4O/E+fI18LePezoKmzTPtymgtI8H7E+ovs9wBhtBNFnI9dNvmHjMWFX50/IA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuTpDKT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DCBC2BD11;
	Mon, 13 May 2024 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715624071;
	bh=+rxemvwnzoV10RvCe8M2I4H331E50lxDd6UYYKgz8B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uuTpDKT+/dgLfyi7mquP/3z1x4NV6xq9HH36oJx82FLiTJ/nczLjRHS7koxzmyf79
	 zAz57mdFGzjA2l9bKnQky64bxUqvPZcJQx3hMPg1R7bnTTiNudR4eLzmAy/TWbEnuO
	 /qGd4DC4VnhyWhvD5wkF/ju8+RVwMZprkWrbtBsfxCjllnzferND6i1zz575R5k6/z
	 bTlHLpcKSy+9zFxlcmvb8r5a38SMZXbOTg80cTuBfXjSpJUyfhmrmIso7OlPmGtIf5
	 +H+FrB32gal4ZCzPCA/mGGXTk0KpYPvh6QXW4EvxidOkct1EW+BpLAQpxY2wk1SkRp
	 tUbNS9J+d1/LQ==
Date: Mon, 13 May 2024 19:14:24 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 2/6] rds: Brute force GFP_NOIO
Message-ID: <20240513181424.GU2787@kernel.org>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <20240513125346.764076-3-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513125346.764076-3-haakon.bugge@oracle.com>

On Mon, May 13, 2024 at 02:53:42PM +0200, Håkon Bugge wrote:
> For most entry points to RDS, we call memalloc_noio_{save,restore} in
> a parenthetic fashion when enabled by the module parameter force_noio.
> 
> We skip the calls to memalloc_noio_{save,restore} in rds_ioctl(), as
> no memory allocations are executed in this function or its callees.
> 
> The reason we execute memalloc_noio_{save,restore} in rds_poll(), is
> due to the following call chain:
> 
> rds_poll()
>         poll_wait()
>                 __pollwait()
>                         poll_get_entry()
>                                 __get_free_page(GFP_KERNEL)
> 
> The function rds_setsockopt() allocates memory in its callee's
> rds_get_mr() and rds_get_mr_for_dest(). Hence, we need
> memalloc_noio_{save,restore} in rds_setsockopt().
> 
> In rds_getsockopt(), we have rds_info_getsockopt() that allocates
> memory. Hence, we need memalloc_noio_{save,restore} in
> rds_getsockopt().
> 
> All the above, in order to conditionally enable RDS to become a block I/O
> device.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

Hi Håkon,

Some minor feedback from my side.

> ---
>  net/rds/af_rds.c | 60 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 8435a20968ef5..a89d192aabc0b 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -37,10 +37,16 @@                                                           >  #include <linux/in.h>
>  #include <linux/ipv6.h>
>  #include <linux/poll.h>
> +#include <linux/sched/mm.h>
>  #include <net/sock.h>
>
>  #include "rds.h"
>
> +bool rds_force_noio;
> +EXPORT_SYMBOL(rds_force_noio);

rds_force_noio seems to be only used within this file.
I wonder if it should it be static and not EXPORTed?

Flagged by Sparse.

> +module_param_named(force_noio, rds_force_noio, bool, 0444);
> +MODULE_PARM_DESC(force_noio, "Force the use of GFP_NOIO (Y/N)");
> +
>  /* this is just used for stats gathering :/ */
>  static DEFINE_SPINLOCK(rds_sock_lock);
>  static unsigned long rds_sock_count;
> @@ -60,6 +66,10 @@ static int rds_release(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;
>  	struct rds_sock *rs;
> +	unsigned int noio_flags;

Please consider using reverse xmas tree order - longest line to shortest -
for local variable declarations in Networking code.

This tool can be of assistance: https://github.com/ecree-solarflare/xmastree

> +
> +	if (rds_force_noio)
> +		noio_flags = memalloc_noio_save();
>  
>  	if (!sk)
>  		goto out;

...

> @@ -324,6 +346,8 @@ static int rds_cancel_sent_to(struct rds_sock *rs, sockptr_t optval, int len)
>  
>  	rds_send_drop_to(rs, &sin6);
>  out:
> +	if (rds_force_noio)
> +		noio_flags = memalloc_noio_save();

noio_flags appears to be set but otherwise unused in this function.

Flagged by W=1 builds.

>  	return ret;
>  }
>  

...

