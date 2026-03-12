Return-Path: <linux-rdma+bounces-18111-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLJXH7HFsmmvPAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18111-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:54:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB620272F8E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4365A306FEB3
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE034C981;
	Thu, 12 Mar 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vbza1ZoZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6B175A87;
	Thu, 12 Mar 2026 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323338; cv=none; b=Pglhx5RwzrdM7b/amvZ3DoI/GpkC4aR1WWDyzLO2eCtrb1x6i/Md0V7ns7yHrPs0dTARdkYdWMZwUHItM1QFYgA+Ez0BZtfMutEAu2mDhKnSotz8i3WFKq+ykTYSaqRp+4uUn26xKTlDpJcQXwTEfvmlUU2rlQsOp10fWZP1qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323338; c=relaxed/simple;
	bh=n6Wi8+Wf3bcqnQdzJvITeSyaVeWgTfVDYqyrAlHIfO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMXUWNoQRFVwzH2zJAZTGtgViy6bChn27ZKp5L/GG1qJC/zt4XWpVcTKc6iQAIoyH1FvE/tdi8PkJLGrbornc71jJlvnW5LeUghpQGVOmupre1ol48atBy1RGm+lTAZVLQiAjL/0eV4duPDVRpbQOLmI5gOSxVo+jaHYSYiyPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Vbza1ZoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1211C4CEF7;
	Thu, 12 Mar 2026 13:48:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vbza1ZoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1773323333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cGQoGI0iD9IPU4MUwC9OugDLG8y8kJybLkuwslOCZHA=;
	b=Vbza1ZoZ3MQ4b2ykXY2DyqS4C6Ur7UHx9qiWIc/vFh778HfoElPE2RxbHwwtYDWBWz5kTd
	GgqrRtZHwWKcuZxBSTueiwWRWvj2d75BQlYdE8HJs5S7vd9FutLk/Ei4er761vtUbva2iY
	m5uliyiKx+1wocBBtZVjNBVv6c6GbN0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 780e6e40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 13:48:53 +0000 (UTC)
Date: Thu, 12 Mar 2026 14:48:48 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, rbm@suse.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Oliver Neukum <oliver@neukum.org>, David Ahern <dsahern@kernel.org>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kees Cook <kees@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Guillaume Nault <gnault@redhat.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Alexandre Cassen <acassen@corp.free.fr>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
	"open list:SFC NETWORK DRIVER" <linux-net-drivers@amd.com>,
	"open list:GTP (GPRS Tunneling Protocol)" <osmocom-net-gprs@lists.osmocom.org>,
	"open list:USB CDC ETHERNET DRIVER" <linux-usb@vger.kernel.org>,
	"open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>,
	"open list:INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWOR..." <linux-wireless@vger.kernel.org>,
	"open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>
Subject: Re: [PATCH 05/10 net-next v2] drivers: net: drop ipv6_stub usage and
 use direct function calls
Message-ID: <abLEQMx6mPM4vL4t@zx2c4.com>
References: <20260310153506.5181-1-fmancera@suse.de>
 <20260310153506.5181-6-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310153506.5181-6-fmancera@suse.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,ziepe.ca,kernel.org,gmail.com,nvidia.com,lunn.ch,davemloft.net,google.com,redhat.com,netfilter.org,gnumonks.org,openvpn.net,queasysnail.net,neukum.org,blackwall.org,corp.free.fr,fomichev.me,corigine.com,amd.com,lists.osmocom.org,lists.zx2c4.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-18111-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zx2c4.com:dkim,zx2c4.com:email,zx2c4.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB620272F8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 04:34:28PM +0100, Fernando Fernandez Mancera wrote:
> diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
> index 253488f8c00f..c362c78d908e 100644
> --- a/drivers/net/wireguard/socket.c
> +++ b/drivers/net/wireguard/socket.c
> @@ -136,8 +136,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
>  			if (cache)
>  				dst_cache_reset(cache);
>  		}
> -		dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sock), sock, &fl,
> -						      NULL);
> +		dst = ip6_dst_lookup_flow(sock_net(sock), sock, &fl, NULL);
>  		if (IS_ERR(dst)) {
>  			ret = PTR_ERR(dst);
>  			net_dbg_ratelimited("%s: No route to %pISpfsc, error %d\n",

Rest in peace, stub.

For the WireGuard part,

    Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

