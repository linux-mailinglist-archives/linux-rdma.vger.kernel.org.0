Return-Path: <linux-rdma+bounces-20111-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC7nOU35+2kRJgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20111-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 04:30:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBCD4E254D
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC3A2302306B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364A52BDC23;
	Thu,  7 May 2026 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6gnKpLn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C81E0DE8;
	Thu,  7 May 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778121028; cv=none; b=WHtniuMuJ6cE9S3+ODO/yacuzIXKj9CS7X/2ZyUhvL9Dp5Z9a1hsZPN4/BeJdRnKKvnymKdaHJnoPUv8MyUkN2Cof0bXzFwzXYlSJL0mM2CSLKzE1AJA6LidcZBNZ1SUY0x6KgNTkkCt0UKHmq7gSOqj0Sdr7eHfPv0jLlX7Bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778121028; c=relaxed/simple;
	bh=Xu/sb4xohkh/2ZBNeaA7TkCiXvEecSSvF061dFMhZ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD4/le96UPw0manTEbeFUbzHr1xr7i3iPwoDkv9IZMJP6HsoR+7BWAIbHtsNeoqJpvdapQMXWt13Unmq5gocOxqJaGAkbvMheJ79+9y2kGSMuzwjf/8/BCBxk0e8BOFI2G2FwBmVTPzQuNA+CHKIl9WoPhfbZRQdxPS1PTACuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6gnKpLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD0AC2BCB0;
	Thu,  7 May 2026 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778121027;
	bh=Xu/sb4xohkh/2ZBNeaA7TkCiXvEecSSvF061dFMhZ6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6gnKpLnM83cot+e2MIZ2NJ7IIQ0P+PmkNIXeUa2HYJm7mpxazwzgBOyQ6BwvtBCA
	 hllGczx763fUwS9Ns0aqgU0/yw9/fw7nbVNQxHgQZULMm58PKKyivX3gY3RP9fDjYA
	 vlXel1bQ5kBo1v1ztqdQNCOU/s9n/hfiOGJluDwU9rPPlEAIXKUydoGZmZeaPFparl
	 Hd2fn8n/Xyz3O8MN6WdYUHKhdWw+UOk53akDJuMwiCJo5M8FQnxOBEHBi7siI3zSTm
	 qaUzrB1c9iQtvpld2cOF/0JL7jU74QgV8OVfLIM7uEmhJ2a196D7U6X+RdgjENgE4s
	 96L+Re1iVpqkw==
Date: Wed, 6 May 2026 19:30:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu
 <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Daniel Borkmann
 <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah
 Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Stanislav Fomichev
 <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 1/6] net: add netmem_tx modes that indicate
 dma capability
Message-ID: <20260506193025.78aba2dc@kernel.org>
In-Reply-To: <20260504-tcp-dm-netkit-v2-1-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
	<20260504-tcp-dm-netkit-v2-1-56d52ac72fd4@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AFBCD4E254D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20111-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 04 May 2026 17:27:48 -0700 Bobby Eshleman wrote:
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -466,6 +466,7 @@ static void netkit_setup(struct net_device *dev)
>  	dev->priv_flags |= IFF_NO_QUEUE;
>  	dev->priv_flags |= IFF_DISABLE_NETPOLL;
>  	dev->lltx = true;
> +	dev->netmem_tx = NETMEM_TX_NO_DMA;
>  
>  	dev->netdev_ops     = &netkit_netdev_ops;
>  	dev->ethtool_ops    = &netkit_ethtool_ops;
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0e1e581efc5a..11d68e75eb4f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1788,6 +1788,12 @@ enum netdev_stat_type {
>  	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
>  };
>  
> +enum netmem_tx_mode {
> +	NETMEM_TX_NONE,		/* no netmem TX support */
> +	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
> +	NETMEM_TX_NO_DMA,	/* no DMA, e.g. passthrough for virtual devs */

Now there's a little too much here, let's move the NO_DMA changes to
another patch. Just convert the netmem_tx to an enum and change the
existing drivers in patch 1.

Next patch has:

> @@ -1164,16 +1197,30 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto err_unlock_netdev;
>  	}
>  
> -	if (!netdev->netmem_tx) {
> +	if (netdev->netmem_tx == NETMEM_TX_NONE) {
>  		err = -EOPNOTSUPP;
>  		NL_SET_ERR_MSG(info->extack,
>  			       "Driver does not support netmem TX");
>  		goto err_unlock_netdev;
>  	}

which also should have been in patch 1.

