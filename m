Return-Path: <linux-rdma+bounces-20035-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCpxET1q+mlbOwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20035-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 00:07:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31924D4363
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 00:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5D33055DE3
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9005495509;
	Tue,  5 May 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg3nCWru"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713D37B014;
	Tue,  5 May 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018871; cv=none; b=XAjrfzHq4vcDLu+oEh/+kmUJr4Yd86rscvmY2nUh7Xpgp9jj/e8rpBQJtJL9F7oCqT98IVcrKL+O0tE8QabJtFAitSes4/I0DqVmp3KKDr3TMVkueEuOc8kmrB1NWC8LimdMTjReeEWkzoEFY6zbZFanfJNv3ixeSwKqCSWz9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018871; c=relaxed/simple;
	bh=HYFrf2XVUeRGPtbiX4eupzO4ACHb6Q9+T+fuglGzx54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFfRlJIpAGtN/XUu6afYUeCCE+tlbBEja4AWvNQtd02FhDrjUj4zhaBH0yO2aWGvjqU2sXCAGWWIM93D/mC3kamT6wXrjsC8hiF9d/hhP97oCNsbLzEjYZBbw8tO1M+YMavMvGcO1vD4UmWKYiJ/zzy5hBn0lkJESohHXqoqg6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg3nCWru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3968C2BCB4;
	Tue,  5 May 2026 22:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778018871;
	bh=HYFrf2XVUeRGPtbiX4eupzO4ACHb6Q9+T+fuglGzx54=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Hg3nCWruspfVvq9+YntHfwLzxvmUoDcGLZhw5nMzQg2iW6u77oZ8sZExXUCN0zXa8
	 gTd9pBZjl583aS7kwGKROyOLPtMPWS503lnFb7YtnUHaN9tlmldtQX9ecbXBasze/C
	 Fw2Ga+K76kmFfemhE4kePlo7EMUyQXslPpJO7vLA159SvxqKsjzCM7g4uNnuHFQvHH
	 iy8BV3iD7qJrDwn12fZBuUtTQVXQvUiMQHrZduMJXKim5VBCgHH14/3hT+oUKgKnqB
	 jFbhorzdZJ4adeCx2YTOnJ+xmK/0/ZFxoR53i7CbkMosC1rXHAWnOyR/Dtq9xzFyuo
	 u4XWplWJEyoHg==
Message-ID: <2962d0cbd5313ab482ece5543bafa0d2f0c32cc3.camel@kernel.org>
Subject: Re: rds: possible cross netns leak via RDS_INFO_* getsockopt
From: Allison Henderson <achender@kernel.org>
To: Xie Maoyi <maoyi.xie@ntu.edu.sg>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-rdma@vger.kernel.org"
	 <linux-rdma@vger.kernel.org>, "rds-devel@oss.oracle.com"
	 <rds-devel@oss.oracle.com>
Date: Tue, 05 May 2026 15:07:49 -0700
In-Reply-To: <TYZPR01MB6758F43459242F22946A8192DC3E2@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
References: 
	<TYZPR01MB6758F43459242F22946A8192DC3E2@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E31924D4363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20035-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 2026-05-05 at 08:37 +0000, Xie Maoyi wrote:
> Hi all,
>=20
> We are not sure whether what we observed is a real bug or
> intended behaviour. We would appreciate your view.
>=20
> In net/rds/info.c, rds_info_getsockopt() dispatches to handlers
> registered in rds_info_funcs[]. Each handler reads a global list
> that is not pernet:
>=20
>   rds_sock_info / rds6_sock_info        -> rds_sock_list
>   rds_tcp_tc_info / rds6_tcp_tc_info    -> rds_tcp_tc_list
>   rds_conn_info / rds6_conn_info        -> rds_conn_hash[]
>=20
> None of those filter by the caller's netns. rds_info_getsockopt()
> also has no netns or capable() check. rds_create() has no
> capable() check either. So AF_RDS is reachable from an
> unprivileged user namespace.
>=20
> Our reading is that an unprivileged caller in a fresh user_ns
> plus netns can read RDS state from init_net. We see this in
> practice on the latest net tree.
>=20
> The fields that come back include:
>=20
>   RDS_INFO_SOCKETS:     bound addr, port, sock inode of every
>                         RDS socket on the host
>   RDS_INFO_TCP_SOCKETS: peer addr, port, last_sent_nxt,
>                         last_expected_una, last_seen_una of
>                         every rds-tcp connection on the host
>   RDS_INFO_CONNECTIONS: peer addr, port, cp_next_tx_seq,
>                         cp_next_rx_seq of every RDS connection
>=20
> A small reproducer is attached as poc_rds_info.c. With rds and
> rds_tcp loaded, the steps are:
>=20
>   modprobe rds
>   modprobe rds_tcp
>   ./poc_rds_info
>=20
> The PoC binds an AF_RDS socket in init_net to 127.0.0.1:4242 as
> root. It then enters a fresh user_ns plus netns and opens AF_RDS
> there. The attacker side reads RDS_INFO_SOCKETS and sees the
> init_net socket. A run log is attached as poc_verification.log.
>=20
> We are not sure if this counts as a bug or is by design. The
> RDS_INFO_* interface looks diagnostic. It may be expected to be
> host wide. On the other hand, AF_RDS is reachable from an
> unprivileged user namespace, which is what surprised us.
>=20
> Could you let us know whether you consider this worth fixing? If
> yes, we have a draft patch that gates rds_info_getsockopt() to
> init_net. We can send it once you confirm the direction.
>=20
> Thanks for your time.
>=20
> Maoyi Xie and Praveen Kakkolangara
>=20
> Maoyi Xie
> Nanyang Technological University
> https://maoyixie.com/


Hi Xie,

Thanks for looking into this.  I think your findings are valid, diagnostic =
or debug tools shouldn't allow callers
visibility into another netns.  Note though that while the ib transport is =
limited to init_net the tcp transport is not
(see rds_set_transport()).  So one gate in rds_info_getsockopt would incorr=
ectly filter netns that a tcp connection
might have legitimate visibility to. So the fix would need a filter in each=
 of the three handlers you've identified,
where we can compare the netns of the socket to the netns of the entry (or =
c_net for connection paths), and only copy
info for relevant sockets instead of every entry in the respective global l=
ist/hash.

Allison

> ________________________________
>=20
> CONFIDENTIALITY: This email is intended solely for the person(s) named an=
d may be confidential and/or privileged. If you are not the intended recipi=
ent, please delete it, notify us and do not copy, use, or disclose its cont=
ents.
> Towards a sustainable earth: Print only when necessary. Thank you.


