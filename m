Return-Path: <linux-rdma+bounces-18765-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOllBUjOyGnDqwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18765-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 09:01:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF60350F75
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 09:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CCDD3011780
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 07:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED119CD0A;
	Sun, 29 Mar 2026 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A50e6Qqb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6F26AC3
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774767683; cv=none; b=dqNizavlAaoTsqJmHj6C8+uhqyGaRNN6ZB78tHVgw43OlXWCzJoWHFNG6J4ST9nkjxyTBHPUwz5jJ/NHlo823UtJU+hkG2gmkfoFO8RLfVMeehvD+ML4uHQAkuYCfFaSnmQEPNPaRbXWra2P8aLW4wiu0JS+hDEo9d2m3Qh3IC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774767683; c=relaxed/simple;
	bh=n9Qm6y8KP7soqOfppGiWXNtSwvLPLwOYQHnQ+oyvN+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3XuFC9ZfA5qwRj/Di/aETHiK+gVR/jcM42xl4WinsGYtL5RLm9nE3KI9Sss/iCFJm4294BclJAeNu1zXV9w1QhDxvGv6Kiqy5wreKZG76nXrHnPXmuG4+1pLgblndSDnJjuO/+bQEzebTflL2z0pvW27z/7x+ivuxyfn+LVMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A50e6Qqb; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a3ca349-5677-40f3-b688-3aa4e9a41c04@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774767669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ID0maKlPiMJKdHlY4MtMigCMbppGvNtJwIdiv6HJXs=;
	b=A50e6QqbQG41UPI62am/3Gr1m4ac0U0fe73R9iaUKuHY5mVHW+x1WvmmnrcagZUMg7FmoQ
	78XndiK7AMXLbjf2acRNsaD88Z/XwG/dsEFGUfkRCMycHcO2y+ywkAUt/a0hVqxfz6WOZQ
	4vt0RVwsyHmA+UiIZ6h4VbGAXK+aY4k=
Date: Sun, 29 Mar 2026 00:01:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] RDMA/rxe: use RXE_PORT instead of magic number 1
To: zhenwei pi <zhenwei.pi@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
References: <20260329054156.125362-1-zhenwei.pi@linux.dev>
 <20260329054156.125362-2-zhenwei.pi@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260329054156.125362-2-zhenwei.pi@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18765-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DF60350F75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/3/28 22:41, zhenwei pi 写道:
> Align with the existing code:
> static ... rxe_ib_device_get_netdev(struct ib_device *dev)
> {
>          return ib_device_get_netdev(dev, RXE_PORT);
> }
> 
> Use *RXE_PORT* instead of magic number 1 for all.
> 

Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/rxe_net.c   | 6 +++---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 8 ++++----
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 0bd0902b11f7..20338cb8e3c2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -234,7 +234,7 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>   
>   	udph = udp_hdr(skb);
>   	pkt->rxe = rxe;
> -	pkt->port_num = 1;
> +	pkt->port_num = RXE_PORT;
>   	pkt->hdr = (u8 *)(udph + 1);
>   	pkt->mask = RXE_GRH_MASK;
>   	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
> @@ -535,7 +535,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>   	struct sk_buff *skb = NULL;
>   	struct net_device *ndev;
>   	const struct ib_gid_attr *attr;
> -	const int port_num = 1;
> +	const int port_num = RXE_PORT;
>   
>   	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
>   	if (IS_ERR(attr))
> @@ -630,7 +630,7 @@ static void rxe_port_event(struct rxe_dev *rxe,
>   	struct ib_event ev;
>   
>   	ev.device = &rxe->ib_dev;
> -	ev.element.port_num = 1;
> +	ev.element.port_num = RXE_PORT;
>   	ev.event = event;
>   
>   	ib_dispatch_event(&ev);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index fe41362c5144..bcd486e8668b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -44,7 +44,7 @@ static int rxe_query_port(struct ib_device *ibdev,
>   	struct net_device *ndev;
>   	int err, ret;
>   
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>   		err = -EINVAL;
>   		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;
> @@ -147,7 +147,7 @@ static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
>   	struct rxe_port *port;
>   	int err;
>   
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>   		err = -EINVAL;
>   		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;
> @@ -180,7 +180,7 @@ static enum rdma_link_layer rxe_get_link_layer(struct ib_device *ibdev,
>   	struct rxe_dev *rxe = to_rdev(ibdev);
>   	int err;
>   
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>   		err = -EINVAL;
>   		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;
> @@ -200,7 +200,7 @@ static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
>   	struct ib_port_attr attr = {};
>   	int err;
>   
> -	if (port_num != 1) {
> +	if (port_num != RXE_PORT) {
>   		err = -EINVAL;
>   		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;


