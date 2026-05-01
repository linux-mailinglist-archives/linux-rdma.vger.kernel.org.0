Return-Path: <linux-rdma+bounces-19814-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KKkC53682mY9QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19814-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:58:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5B4A96A7
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 598083028B29
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F8E284693;
	Fri,  1 May 2026 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL9KNxZS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03238267B07;
	Fri,  1 May 2026 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597047; cv=none; b=JD4c2rLDfWlXOcZWPdJkHcZu4jkl5w4HdRaNj1qZ18HiMmtWs8Svaxq7g/Sbnmt2a6LImacj5AgR6oKbI4AOJwoy7Sapo6yuKoEhDAU6LH2V2f+B0RxshBxG7+dSnvsWA92wAoslc9GB7XM1yKjxmDJzuB4MGFqTN/O68vlRXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597047; c=relaxed/simple;
	bh=bs05aRDwfyaoPAgx838AnsLYLubyaA3dlIOPWod+1Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLmm3ir5XRclqCfupRLzDEd4cnzhBVPA2Y2KpCxHHus4AeLFa/5VvNuPP6Xd3h7Q8sObOursrlz/so4w+A1Il4sBmb9MgxxUI0KRH4oCxQlSjak2muob9TMmKm5FKNZ+fGv80VA7L5JrG1/PFzXpnzNI6JHrOowNX02eOf1sRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL9KNxZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8953EC2BCB3;
	Fri,  1 May 2026 00:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597046;
	bh=bs05aRDwfyaoPAgx838AnsLYLubyaA3dlIOPWod+1Y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oL9KNxZS0ZtiRkjef9sVKNyf4iisFfLGGPVRLgjI3Ykn73Pdz6xvS6dfrqE2ygcPv
	 bLIhEmQlxG6faHCYchb2dVOEEbX2LVpLbw830jUWwcs4x7X4HK1YlF/UNau/t7Kiq9
	 HTVWjnsq/e4P8gbPCMVmLn2jIV+uA3swtV3M614QO67pxQOA+D6i53AmjBBQva4p0u
	 QIt/71GKKjQHAlr+KuHvT8UMZ+GA2GLOXPFJIqK/Fsb9ZqGmOzZPlOvvWvb5i6EUFk
	 l4FNG9tyPtC9zWfX3R0lBpW5ppy26FZTo/1ANIyvRCoosEh2jitBofEiME7/UEziyj
	 U0yKPeDSEfB4A==
Date: Thu, 30 Apr 2026 17:57:24 -0700
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
Subject: Re: [PATCH net-next 07/11] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <20260430175724.0c134a0d@kernel.org>
In-Reply-To: <20260428-tcp-dm-netkit-v1-7-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
	<20260428-tcp-dm-netkit-v1-7-719280eba4d2@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8B5B4A96A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19814-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 15:42:04 -0700 Bobby Eshleman wrote:
>  	shinfo = skb_shinfo(skb);
> +	if (shinfo->nr_frags == 0)
> +		goto out;

Feels tempting to cover the NETMEM_TX_NO_DMA / NETMEM_TX_NONE
cases here before we even look at the frags?

> -	if (shinfo->nr_frags > 0) {
> -		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> -		if (net_is_devmem_iov(niov) &&
> -		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
> +	niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> +	if (!net_is_devmem_iov(niov))
> +		goto out;
> +
> +	binding = net_devmem_iov_binding(niov);
> +
> +	switch (dev->netmem_tx) {
> +	case NETMEM_TX_DMA:
> +		if (READ_ONCE(binding->dev) != dev)
>  			goto out_free;
> +		break;
> +	case NETMEM_TX_NO_DMA:
> +		break;
> +	default: /* NETMEM_TX_NONE */
> +		goto out_free;
>  	}

