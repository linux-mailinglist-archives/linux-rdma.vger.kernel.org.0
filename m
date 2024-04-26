Return-Path: <linux-rdma+bounces-2096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCB8B36E9
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58017284342
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16F1145B30;
	Fri, 26 Apr 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="Ee8l6YFJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35014534B;
	Fri, 26 Apr 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133434; cv=none; b=BscJAKSYOrRPU8Nbp4YBtlKThjyGjIDu/910362iJmMcZjOpSwlSBqUm5iORid4sqcnAv7yNA+50ynNlXcZ195cqlrpX5gPq+KUL6yVDzKNfTov0RKfCfioqbUmg+jd+rPbv+5jp/zqSufrye+b17YjiB9l7en49S3LP8hBqi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133434; c=relaxed/simple;
	bh=sk3F8kQlklKnamzgzVwKQ00rlNEpTKcd9WWMXq8UVps=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=atDnJvBvQaCpA8aIfLOVMoIyYeD7M4LxF4NM4+CaFIRHFSABwCwTV7nvASndQBgekkMJbym7CkpUL4fqyt8Y76wna3cTVEWokR5Uj2BUGinkh9dFUHO5RbtrQqfm3jq4Z7c6JjOoQE7M1MY7DyJypW31i4B8DHp1iKuPgEBdoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=Ee8l6YFJ; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 6674A201AD;
	Fri, 26 Apr 2024 15:10:29 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS;
	Fri, 26 Apr 2024 15:10:28 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id C3D63900281;
	Fri, 26 Apr 2024 15:09:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1714133398; bh=sk3F8kQlklKnamzgzVwKQ00rlNEpTKcd9WWMXq8UVps=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Ee8l6YFJS7RZ24aWwUO+TQ58uAlvKg44da8bN2aXoBnCDabYnu1QZRbWM/YCvMCtm
	 KCb/TDE1mSM/2m6jLtLrvv6haBRhIsD746J+S3tEsYMKzO87OwtlGyaijhx9Z6novF
	 rNPRpgWaQyfc0DLkHErLzQp3U+PMcMndbKLDFZiA=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 43QC9jvI068943;
	Fri, 26 Apr 2024 15:09:47 +0300
Date: Fri, 26 Apr 2024 15:09:45 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Joel Granados <j.granados@samsung.com>
cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Ahern <dsahern@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Remi Denis-Courmont <courmisch@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Simon Horman <horms@verge.net.au>, Joerg Reuter <jreuter@yaina.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
        linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
        linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux.dev,
        lvs-devel@vger.kernel.org
Subject: Re: [PATCH v5 6/8] netfilter: Remove the now superfluous sentinel
 elements from ctl_table array
In-Reply-To: <20240426-jag-sysctl_remset_net-v5-6-e3b12f6111a6@samsung.com>
Message-ID: <d78c6353-99b9-41f8-0c54-19eb86e1fce3@ssi.bg>
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com> <20240426-jag-sysctl_remset_net-v5-6-e3b12f6111a6@samsung.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Fri, 26 Apr 2024, Joel Granados via B4 Relay wrote:

> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which will
> reduce the overall build time size of the kernel and run time memory
> bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> * Remove sentinel elements from ctl_table structs
> * Remove instances where an array element is zeroed out to make it look
>   like a sentinel. This is not longer needed and is safe after commit
>   c899710fe7f9 ("networking: Update to register_net_sysctl_sz") added
>   the array size to the ctl_table registration
> * Remove the need for having __NF_SYSCTL_CT_LAST_SYSCTL as the
>   sysctl array size is now in NF_SYSCTL_CT_LAST_SYSCTL
> * Remove extra element in ctl_table arrays declarations
> 
> Acked-by: Kees Cook <keescook@chromium.org> # loadpin & yama
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  net/bridge/br_netfilter_hooks.c         | 1 -
>  net/ipv6/netfilter/nf_conntrack_reasm.c | 1 -
>  net/netfilter/ipvs/ip_vs_ctl.c          | 5 +----
>  net/netfilter/ipvs/ip_vs_lblc.c         | 5 +----
>  net/netfilter/ipvs/ip_vs_lblcr.c        | 5 +----
>  net/netfilter/nf_conntrack_standalone.c | 6 +-----
>  net/netfilter/nf_log.c                  | 3 +--
>  7 files changed, 5 insertions(+), 21 deletions(-)

...

> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 143a341bbc0a..50b5dbe40eb8 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c

...

> @@ -4286,10 +4285,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  			return -ENOMEM;
>  
>  		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns) {
> -			tbl[0].procname = NULL;
> +		if (net->user_ns != &init_user_ns)
>  			ctl_table_size = 0;
> -		}
>  	} else
>  		tbl = vs_vars;
>  	/* Initialize sysctl defaults */

	We are in process of changing this code (not in trees yet):

https://marc.info/?t=171345219600002&r=1&w=2

	As I'm not sure which patch will win, the end result should
be this single if-block/hunk to be removed.

Regards

--
Julian Anastasov <ja@ssi.bg>


