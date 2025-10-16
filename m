Return-Path: <linux-rdma+bounces-13900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3ABE3BB6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F781A64A35
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3132549D;
	Thu, 16 Oct 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQVVlQgx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81061A9FB8;
	Thu, 16 Oct 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621744; cv=none; b=ZOtpHvebjfU4ZBbS6OentjMPSydcOvjOXr/ayFmJ29FsgTfASnLcJYPDV6+D/MJrrMbCeKUGhvCaKDAaqqw0pnhVyEl9aGEMLwnHr9KBMcNFd6vhGDdOq5Hzhpc80XYhm2jmUomOXTMS84FW9JGvPUqCyk+Uo/QoVDGDwDvdajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621744; c=relaxed/simple;
	bh=uVLfA/RBOmQsVeqL02JYX9sISssQUPD4hxqKMzdK9M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X68BIBZ70t6qgELKLkz5WAcB7MPtmlLgHP4EEv0u2kRHDkFj5kOrfrm3kVoh8YZXXQdLeK1yxJfaiiMjMU7mZz5GQeUNJFVahHOsnGj9ymFZjZdKUZ7Gr5dgA/QJpRMvIq146TP8dyB/YQOHp4g3kfoYxpIVN8oUS+EYFG9t2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQVVlQgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0288C4CEF1;
	Thu, 16 Oct 2025 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760621744;
	bh=uVLfA/RBOmQsVeqL02JYX9sISssQUPD4hxqKMzdK9M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQVVlQgxUIPx3WLdYZ5giKoSRi26akxuVGXZdZBq/Axa0qzIttqHh2a4h1ikKPn9S
	 5W2Bn6eRg2IslmGJmignqA7IoN9S1kkAazagPN1A8W9WYlPwYqEjx51NUT98AjK4KC
	 YWi/5WDvGOdd1V0jpHSk/T9TrYMJ/QbCC8HTXGBOgtFAvOqoeT3zJzXJITri/8aXZA
	 xO4WWmfALpoZRdif3yNael94cPvuDx3rCt8BZwL3WbS1cGVb00irkAPgU1LNtkGL3W
	 LS1tBXTYhtL+njctSeml5LnukOE5mjNE25DYr77Gjq7nWgf/12KspdCNg9svNW5MQ1
	 Zjv9dcmJ5ccog==
Date: Thu, 16 Oct 2025 14:35:39 +0100
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: mjambigi@linux.ibm.com, wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Subject: Re: [PATCH net-next] net/smc: add full IPv6 support for SMC
Message-ID: <aPD0qwDoYNoTTaur@horms.kernel.org>
References: <20251016054541.692-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251016054541.692-1-alibuda@linux.alibaba.com>

On Thu, Oct 16, 2025 at 01:45:41PM +0800, D. Wythe wrote:
> The current SMC implementation is IPv4-centric. While it contains a
> workaround for IPv4-mapped IPv6 addresses, it lacks a functional path
> for native IPv6, preventing its use in modern dual-stack or IPv6-only
> networks.
> 
> This patch introduces full, native IPv6 support by refactoring the
> address handling mechanism to be IP-version agnostic, which is
> achieved by:
> 
> - Introducing a generic `struct smc_ipaddr` to abstract IP addresses.
> - Implementing an IPv6-specific route lookup function.
> - Extend GID matching logic for both IPv4 and IPv6 addresses
> 
> With these changes, SMC can now discover RDMA devices and establish
> connections over both native IPv4 and IPv6 networks.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/smc/af_smc.c   |  35 +++++++----
>  net/smc/smc_core.h |  40 ++++++++++++-
>  net/smc/smc_ib.c   | 143 ++++++++++++++++++++++++++++++++++++++-------
>  net/smc/smc_ib.h   |   9 +++
>  net/smc/smc_llc.c  |   6 +-
>  5 files changed, 193 insertions(+), 40 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 77b99e8ef35a..cbff0b29ad5b 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1132,12 +1132,9 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
>  
>  	/* check if there is an rdma v2 device available */
>  	ini->check_smcrv2 = true;
> -	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
> +
> +	smc_ipaddr_from(&ini->smcrv2.saddr, smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);

Hi,

Unfortunately this introduces a compilation error when CONFIG_IPV6=n.

In file included from smc_wr.h:20,
                 from smc_llc.h:16,
                 from af_smc.c:47:
af_smc.c: In function ‘smc_find_proposal_devices’:
/home/horms/projects/linux/linux/include/net/sock.h:388:37: error: ‘struct sock_common’ has no member named ‘skc_v6_rcv_saddr’; did you mean ‘skc_rcv_saddr’?
  388 | #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
      |                                     ^~~~~~~~~~~~~~~~
smc_core.h:639:51: note: in definition of macro ‘smc_ipaddr_from’
  639 |                         __ipaddr->addr_v6 = __sk->_v6_member;   \
      |                                                   ^~~~~~~~~~
af_smc.c:1136:77: note: in expansion of macro ‘sk_v6_rcv_saddr’
 1136 |         smc_ipaddr_from(&ini->smcrv2.saddr, smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);
      |                                                                             ^~~~~~~~~~~~~~~

>  	if (!(ini->smcr_version & SMC_V2) ||
> -#if IS_ENABLED(CONFIG_IPV6)
> -	    (smc->clcsock->sk->sk_family == AF_INET6 &&
> -	     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
> -#endif
>  	    !smc_clc_ueid_count() ||
>  	    smc_find_rdma_device(smc, ini))
>  		ini->smcr_version &= ~SMC_V2;

...

> @@ -2307,8 +2316,10 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
>  	memcpy(ini->peer_mac, pclc->lcl.mac, ETH_ALEN);
>  	ini->check_smcrv2 = true;
>  	ini->smcrv2.clc_sk = new_smc->clcsock->sk;
> -	ini->smcrv2.saddr = new_smc->clcsock->sk->sk_rcv_saddr;
> -	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
> +
> +	smc_ipaddr_from(&ini->smcrv2.saddr, new_smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);
> +	smc_ipaddr_from_gid(&ini->smcrv2.daddr, smc_v2_ext->roce);
> +
>  	rc = smc_find_rdma_device(new_smc, ini);
>  	if (rc) {
>  		smc_find_ism_store_rc(rc, ini);

> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h

...

> @@ -618,4 +626,30 @@ static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
>  {
>  	return link->lgr;
>  }
> +
> +#define smc_ipaddr_from(_ipaddr, _sk, _v4_member, _v6_member)	\
> +	do {							\
> +		struct smc_ipaddr *__ipaddr = (_ipaddr);	\
> +		struct sock *__sk = (_sk);			\
> +		int __family = __sk->sk_family;			\
> +		__ipaddr->family = __family;			\
> +		if (__family == AF_INET)			\
> +			__ipaddr->addr = __sk->_v4_member;	\
> +		else						\
> +			__ipaddr->addr_v6 = __sk->_v6_member;	\
> +	} while (0)
> +

...

-- 
pw-bot: changes-requested

