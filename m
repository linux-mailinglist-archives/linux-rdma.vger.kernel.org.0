Return-Path: <linux-rdma+bounces-17808-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kONaLAkYr2kiNwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17808-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:57:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5644D23EFEA
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E85D307B543
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C843ED5AF;
	Mon,  9 Mar 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C65waag9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697B3ED13A;
	Mon,  9 Mar 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082459; cv=none; b=V5O6dbJtFZ0G3Z1hnm1dV1EboAajYLjWWqhhOsj4zlsAHpAMSoMVDCXMEypO7T7COzDEP49iyEBbgP/c/HsXHjLw1asZK0Eq6ReWRsvKKWI0H8ycdE4PmqYEww2KPaeQrwBmFADNrmy28QF9hUQ/odltWH/RMNtDY+PWiHQcW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082459; c=relaxed/simple;
	bh=2m9mzh9Bz7F9YuzwEd07E0r/xjEZyJBV0/k4lAS1Pw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UCCq1p+FWz3ukGqq1EKT31RvFF9rUe0SOL4sA8NdSkOF83tej9AKTdiYq71/RG6Fqahg0qvdfBRD1eXnnIXkiyK0YegSdwcGaQMP2Pbpbc6XLs7eKcZf4ECfQ+1KKEFMbce91w8te1B3R/zfzmJbqWEo85BLoS720BIgy3NvqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C65waag9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BE8C2BC87;
	Mon,  9 Mar 2026 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773082459;
	bh=2m9mzh9Bz7F9YuzwEd07E0r/xjEZyJBV0/k4lAS1Pw0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=C65waag9cqTQZs3AK0KZWR3tLpGjfDvlCxkkhEZgETMfpcPYRmzP7Ryi0L2vVdd73
	 MwbXULv5rEYjiC9i1ZI98Qe1ZCxP1tx8YiVlzDE94IXl3IEjogsYVQ2vfCRCWjokXc
	 Dg+Y2O0qiUDLQHhBTFfDmBrA6qnTPJIohzmEWbgsNOzpRZzjr6KAewox22YuQetkQO
	 6u9UouNAxl4ydWkZHCRsP/wmYRVANi0P1cH+/JHcoeOxBlyxae0oN/eDNQFYEG/5YK
	 cnpe5nB6UdbsIyKZSIbVq4WjDeSLy7Fs8RyvFk85ADxOFEU8jdevEluzmaRGzjDZzn
	 rFn59d7yMTR8w==
Message-ID: <a91c6ed2-2eb2-4e7c-9213-5cc977abc660@kernel.org>
Date: Mon, 9 Mar 2026 12:54:18 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] RDMA/rxe: Support RDMA link creation and
 destruction per net namespace
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260308233540.13382-1-yanjun.zhu@linux.dev>
 <20260308233540.13382-4-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260308233540.13382-4-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5644D23EFEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17808-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/8/26 5:35 PM, Zhu Yanjun wrote:
> @@ -101,20 +100,20 @@ static inline void rxe_reclassify_recv_socket(struct socket *sock)
>  }
>  
>  static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
> +					 struct net *net,
>  					 struct net_device *ndev,
>  					 struct in_addr *saddr,
>  					 struct in_addr *daddr)
>  {
>  	struct rtable *rt;
> -	struct flowi4 fl = { { 0 } };
> +	struct flowi4 fl = {};
>  
> -	memset(&fl, 0, sizeof(fl));

changing init of fl here and fl6 in the next function are not relevant
to this patch. It should be a different one after this set.

>  	fl.flowi4_oif = ndev->ifindex;
>  	memcpy(&fl.saddr, saddr, sizeof(*saddr));
>  	memcpy(&fl.daddr, daddr, sizeof(*daddr));
>  	fl.flowi4_proto = IPPROTO_UDP;
>  
> -	rt = ip_route_output_key(&init_net, &fl);
> +	rt = ip_route_output_key(net, &fl);
>  	if (IS_ERR(rt)) {
>  		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
>  		return NULL;
> @@ -125,21 +124,21 @@ static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>  
>  #if IS_ENABLED(CONFIG_IPV6)
>  static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
> +					 struct net *net,
>  					 struct net_device *ndev,
>  					 struct in6_addr *saddr,
>  					 struct in6_addr *daddr)
>  {
>  	struct dst_entry *ndst;
> -	struct flowi6 fl6 = { { 0 } };
> +	struct flowi6 fl6 = {};
>  
> -	memset(&fl6, 0, sizeof(fl6));
>  	fl6.flowi6_oif = ndev->ifindex;
>  	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
>  	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>  	fl6.flowi6_proto = IPPROTO_UDP;
>  
> -	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
> -					       recv_sockets.sk6->sk, &fl6,
> +	ndst = ipv6_stub->ipv6_dst_lookup_flow(net,
> +					       rxe_ns_pernet_sk6(dev_net(ndev)), &fl6,

why dev_net(ndev) here?


>  					       NULL);
>  	if (IS_ERR(ndst)) {
>  		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);


