Return-Path: <linux-rdma+bounces-17667-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHbCDXmrq2l8fQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17667-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 05:37:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B022A10F
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Mar 2026 05:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E5D230219D2
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Mar 2026 04:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46933B6EC;
	Sat,  7 Mar 2026 04:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YLWggLHQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A5198E91
	for <linux-rdma@vger.kernel.org>; Sat,  7 Mar 2026 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858228; cv=none; b=oOCOIyqgW2joOTaSry+LvGOhDUgwy05Lr9/E27+Oz8e0ExTh4cB0w0TlrUFDnQPSXVMTuyRW+hOQz6BNA5L2PcjaHX06kE1hYi6LlTMfX/CVB0XzDD6piiPmsEb53HK9zYYRVsWckwWqxUdCXvyijs5+iMuI32sXqAEzbYKPvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858228; c=relaxed/simple;
	bh=uuDHxErMeCKwdYdeJW+GoC4H/Sitq8KG8hvdqVi3/+U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=cutT6qlOE8NhLVrK5zHG1O6E2fUeLPaRlSP5VZ3WvaGQfnjDTZXMu8kc7wsEIT40kCHdFyvz8n69Ld/KWi41tW77849ylIZtIMMDVzXcJRTpr6KHhWgnHKJ5e6IXOHteF38u8EPL69dSeYVPuyh04n5rPQWmpvpWB5C5avGbCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YLWggLHQ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772858214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft4IWUebvg0aCr/ykUgTkpQu0ujjA41RQl8tOtocRMI=;
	b=YLWggLHQTBmSROfmUBS2t1Xavf8tbd5M4bGrxEpZrZUEQjY+CN+CfSAenlVmOwBLTIuprT
	0MpNgMwN6TxMHQuiC8phvDkU42RyVqLjnZcEqd8fuI3ChHqI6I0IaUxnQ6KRy0x0yOdPVx
	u/FVGcDgs+ZS1RY4IDjHgy1TJSuujFY=
Date: Sat, 07 Mar 2026 04:36:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <8f8b43cb3b8d5b855ffd51f74340214a0b780124@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] net/smc: fix NULL dereference and UAF in
 smc_tcp_syn_recv_sock()
To: "Eric Dumazet" <edumazet@google.com>
Cc: netdev@vger.kernel.org,
 syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com, "D. Wythe"
 <alibuda@linux.alibaba.com>, "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>, "Wenjia Zhang"
 <wenjia@linux.ibm.com>, "Mahanta Jambigi" <mjambigi@linux.ibm.com>, "Tony
 Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CANn89iJ0V6un1un7zjG-J9d4EJQOjTO37s3EQUKTodwPWsXhFQ@mail.gmail.com>
References: <20260307032158.372165-1-jiayuan.chen@linux.dev>
 <CANn89iJ0V6un1un7zjG-J9d4EJQOjTO37s3EQUKTodwPWsXhFQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D24B022A10F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17667-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

March 7, 2026 at 11:56, "Eric Dumazet" <edumazet@google.com mailto:edumaz=
et@google.com?to=3D%22Eric%20Dumazet%22%20%3Cedumazet%40google.com%3E > w=
rote:


>=20
>=20On Sat, Mar 7, 2026 at 4:22 AM Jiayuan Chen <jiayuan.chen@linux.dev> =
wrote:
>=20
[...]
>=20>  diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >  index d0119afcc6a1..21218b9b0f9a 100644
> >  --- a/net/smc/af_smc.c
> >  +++ b/net/smc/af_smc.c
> >  @@ -131,7 +131,14 @@ static struct sock *smc_tcp_syn_recv_sock(const=
 struct sock *sk,
> >  struct smc_sock *smc;
> >  struct sock *child;
> >=20
>=20>  + read_lock_bh(&((struct sock *)sk)->sk_callback_lock);
> >=20
>=20This will not survive a SYN flood attack.
>=20
>=20Please use RCU instead.
>=20
>=20>=20
>=20> smc =3D smc_clcsock_user_data(sk);
> >  + if (!smc) {
> >  + read_unlock_bh(&((struct sock *)sk)->sk_callback_lock);
> >  + return NULL;
> >  + }
> >  + sock_hold(&smc->sk);
> >=20
>=20If you must take a refcount, use
>=20
>=20if (!refcount_inc_not_zero(&smc->sk->sk_refcnt)) {
>  rcu_read_unlock();
>  return NULL;
> }

Thanks for the review.

Will try rcu_read_lock() + refcount_inc_not_zero()
and set SOCK_RCU_FREE on the listen socket.

