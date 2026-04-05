Return-Path: <linux-rdma+bounces-19000-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI3+BIuz0ml/ZwcAu9opvQ
	(envelope-from <linux-rdma+bounces-19000-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 21:10:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81E39F568
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 21:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12BAC3005678
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8652ED846;
	Sun,  5 Apr 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMNRw4/G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E21EFF8D;
	Sun,  5 Apr 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775416199; cv=none; b=WbHm7AiLftQ0NJrk6svd3H+OR2g9fPphRMNdHoJR4BPmhyl3D8mMIBGtDHBJSzbq9LS8zAkQPXCXITDiEzeUhRzAsBy0az2wtkqwxc+NJbvU3KlKQCg4q+ZAwfnhn1qm6Zw0/g8UL6cX3hz9tiF9ZgonaNdx0iVsXPdr637ZJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775416199; c=relaxed/simple;
	bh=pZsvqn/xapk03wpgrCiOjNHlIdWklWZuoB52UOp3JrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWkoxBkaRIYf6n5YTJ4Y7bsLhb4sbkctDL6mXqCz5Wx4B+7PnhLBjW+KgGy0YJXb9gowF4ujzX5ni/WOI0t646TxRW+rmslJTJDPjoNexbnzXJGao5bckAEZ3HwBZFDDp25lMmwKaEp0iw7gB7Xy3xBGthGcsp4AtpMVnd4WtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMNRw4/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF62CC116C6;
	Sun,  5 Apr 2026 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775416199;
	bh=pZsvqn/xapk03wpgrCiOjNHlIdWklWZuoB52UOp3JrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMNRw4/GckF78ik0U47TTHYImepIQJ0KyWLTazU1nIrfxWtQfJLGgdSgAWc+ERmeO
	 0RaHicgMhYgYoV+lgdOceQkGliUjuxPRC8u1AhZ2IWgvUcJYRTqlPbNDSgnce2n+R5
	 Pc8dSD194bw6aLCv/zyTG4duMRuegdobZwVbop0hjOAW7Tb8I/E6+A9biWYI1YupjZ
	 C/bTu9hAZarAV5vy3smS1386A8mEJpoU+taJwm2XC/rWdrY1QZiPxhqCgz0aRP8dRk
	 rBluFbxoeF9zIyxz0y5EPujEMBmufu8VYJIAwHxtBx7VzZr3eb7fBGGEh1gPKw1L4k
	 PMEDXA4zJrEJg==
Date: Sun, 5 Apr 2026 22:09:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: zhenwei pi <zhenwei.pi@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	zyjzyj2000@gmail.com, jgg@ziepe.ca
Subject: Re: [PATCH v3 1/3] RDMA/rxe: use RXE_PORT instead of magic number 1
Message-ID: <20260405190954.GA86584@unreal>
References: <20260329054156.125362-1-zhenwei.pi@linux.dev>
 <20260329054156.125362-2-zhenwei.pi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329054156.125362-2-zhenwei.pi@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19000-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ziepe.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E81E39F568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 01:41:54PM +0800, zhenwei pi wrote:
> Align with the existing code:
> static ... rxe_ib_device_get_netdev(struct ib_device *dev)
> {
>         return ib_device_get_netdev(dev, RXE_PORT);
> }

Please submit the inverse patch that removes the rxe_ib_device_get_netdev()
wrapper and the RXE_PORT definition. These additions do not improve readability,
and RXE has always had only a single port.

Thanks

> 
> Use *RXE_PORT* instead of magic number 1 for all.
> 
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c   | 6 +++---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0bd0902b11f7..20338cb8e3c2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -234,7 +234,7 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>  
>  	udph = udp_hdr(skb);
>  	pkt->rxe = rxe;
> -	pkt->port_num = 1;
> +	pkt->port_num = RXE_PORT;
>  	pkt->hdr = (u8 *)(udph + 1);
>  	pkt->mask = RXE_GRH_MASK;
>  	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
> @@ -535,7 +535,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>  	struct sk_buff *skb = NULL;
>  	struct net_device *ndev;
>  	const struct ib_gid_attr *attr;
> -	const int port_num = 1;
> +	const int port_num = RXE_PORT;
>  
>  	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
>  	if (IS_ERR(attr))
> @@ -630,7 +630,7 @@ static void rxe_port_event(struct rxe_dev *rxe,
>  	struct ib_event ev;
>  
>  	ev.device = &rxe->ib_dev;
> -	ev.element.port_num = 1;
> +	ev.element.port_num = RXE_PORT;
>  	ev.event = event;
>  
>  	ib_dispatch_event(&ev);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index fe41362c5144..bcd486e8668b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -44,7 +44,7 @@ static int rxe_query_port(struct ib_device *ibdev,
>  	struct net_device *ndev;
>  	int err, ret;
>  
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>  		err = -EINVAL;
>  		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>  		goto err_out;
> @@ -147,7 +147,7 @@ static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
>  	struct rxe_port *port;
>  	int err;
>  
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>  		err = -EINVAL;
>  		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>  		goto err_out;
> @@ -180,7 +180,7 @@ static enum rdma_link_layer rxe_get_link_layer(struct ib_device *ibdev,
>  	struct rxe_dev *rxe = to_rdev(ibdev);
>  	int err;
>  
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>  		err = -EINVAL;
>  		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>  		goto err_out;
> @@ -200,7 +200,7 @@ static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
>  	struct ib_port_attr attr = {};
>  	int err;
>  
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>  		err = -EINVAL;
>  		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>  		goto err_out;
> -- 
> 2.43.0
> 
> 

