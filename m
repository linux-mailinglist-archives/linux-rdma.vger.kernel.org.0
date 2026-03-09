Return-Path: <linux-rdma+bounces-17807-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OXgKgIYr2nHNgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17807-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:57:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B1323EF92
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF06C3074120
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5EE3CE4B3;
	Mon,  9 Mar 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffqRyeeT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BF27467F;
	Mon,  9 Mar 2026 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082459; cv=none; b=gvlPaVrMOO4hQeTf53JgKC6BG2z45mcWwem+vTNSlFDkHO/fLaCVpqAgeUrgdxb0kedUUhedlssPd2jzJFY8acEXdzG2b8uD7UJuR0LscKce3HC1ZtVtG0EeOVmTDMBHs4Dp51wYkWQMau0F+1QU8mjiftnc+KAkF34R3HekCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082459; c=relaxed/simple;
	bh=guTG2qPIAjdxBAfBoOvzfTole8fBmr7ooBBs/3AJxSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UHPjd/klIcbiE2LpQhpgBEYKgqVk4saSF03BnjV+etcQMJdYzq97uvjtd5DuXsgMp7sNFVy/MsFNCv3z+jQdWbLXmJA06VSCO/Qz6QLemfxBBAbLDBDiMoeXACjRJU5VfeQnA5rkqxZaj3QlWCyFLGZqqEuOj9D6HLS4BlCeYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffqRyeeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E78C4CEF7;
	Mon,  9 Mar 2026 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773082458;
	bh=guTG2qPIAjdxBAfBoOvzfTole8fBmr7ooBBs/3AJxSg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ffqRyeeTMTu/FJfydYUe8pHZwvvSGauUhNhP1no9DMCagIBVeOlrgkyMOQd7HAM/E
	 Z9brtY/IUubJq8ABAeZf60mX8m2qzbZphF442ybY9RmZJpumLmsDXLN/Zkgo7zKQM+
	 9hkRH+nI18tnTd8SRCrmMOurdMM6yK4twBL6d91KjWYhgwJ4AQAxqi0W8EyPe/HjP4
	 H8pxaWgC4ghAH54R5yXNYenVlfWZCKrzoWu+fRHsXxE7/sQVVP+YGQ5xM54YMCnbCB
	 0VYd59TL4PtIDI6vza+rgRIvnqLoljWejvlnXIkMvXRHuTo5Pc2Kcj5naQY3E8OQ7k
	 vHwO2NtJ9JUxw==
Message-ID: <f8315319-3dda-4ab2-97b1-7645c3995d3d@kernel.org>
Date: Mon, 9 Mar 2026 12:54:17 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] RDMA/rxe: Add net namespace support for IPv4/IPv6
 sockets
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260308233540.13382-1-yanjun.zhu@linux.dev>
 <20260308233540.13382-3-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260308233540.13382-3-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45B1323EF92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17807-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
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
> diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
> new file mode 100644
> index 000000000000..6fe056c81ef3
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_ns.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
> + * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.

neither of those copyrights are relevant here.



> +static void rxe_ns_exit(struct net *net)
> +{
> +	/* called when the network namespace is removed
> +	 */
> +	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
> +	struct sock *sk;
> +
> +	sk = rcu_dereference(ns_sk->rxe_sk4);

[  323.527911] =============================
[  323.527915] WARNING: suspicious RCU usage
[  323.527918] 7.0.0-rc1-debug+ #3 Tainted: G        W
[  323.527922] -----------------------------
[  323.527925] drivers/infiniband/sw/rxe/rxe_ns.c:49 suspicious
rcu_dereference_check() usage!
[  323.527929]

> +	if (sk) {
> +		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
> +		udp_tunnel_sock_release(sk->sk_socket);
> +	}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	sk = rcu_dereference(ns_sk->rxe_sk6);

[  323.528243] =============================
[  323.528245] WARNING: suspicious RCU usage
[  323.528248] 7.0.0-rc1-debug+ #3 Tainted: G        W
[  323.528251] -----------------------------
[  323.528253] drivers/infiniband/sw/rxe/rxe_ns.c:56 suspicious
rcu_dereference_check() usage!


you should always run tests with a debug kernel that has kmemleak and
lock debugging enabled.


> +#else /* IPV6 */
> +
> +struct sock *rxe_ns_pernet_sk6(struct net *net)
> +{
> +	return NULL;
> +}
> +
> +void rxe_ns_pernet_set_sk6(struct net *net, struct sock *sk)
> +{
> +}

This branch is typically done as an inline in the header file.



