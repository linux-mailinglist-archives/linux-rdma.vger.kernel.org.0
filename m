Return-Path: <linux-rdma+bounces-16124-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAonAtnVeWntzwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16124-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 10:24:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18C9EC3F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F5B030158AA
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489733F38C;
	Wed, 28 Jan 2026 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ru header.i=@cloud.ru header.b="XKBQq/d0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx02.cloud.ru (mx02.cloud.ru [37.18.109.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5433D51F
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.109.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591673; cv=none; b=bYcFZi3mXIWFKJ1pXxlKjnWTqNr9vIqfmHfZQqyPsxOHJwDaDj6BjfTOu59bWhXQTNZZIbwQXGMOOojK7+EllWBnsveQKvnQipEbjz0m0I8BFORMDLsQwr0Ysvb3NKV3bu0gTVQPH9JGAwPbRYHHboKXTZGUJy+kyxjyF4OCDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591673; c=relaxed/simple;
	bh=CZkvlW1bj/OoUfpK10ZsRfctWXd3Oa9kACtGmpSWz8o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HHtgo/ey+swGlwQ/3C3rnWMQE2PzXQ0szVNZTmcfpXAn1Rel63MCMMAal47crGHrzW1GKkanUoWBfbqYu/Q2cpeus6vawUdqHx4ASOpH03llK7ReSXN3l6QyE7QGUNgnLEnRsjIt5Wi+J3oo1vXVUU7Ow3uFqwMp9nA9Yr2WHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloud.ru; spf=pass smtp.mailfrom=cloud.ru; dkim=pass (2048-bit key) header.d=cloud.ru header.i=@cloud.ru header.b=XKBQq/d0; arc=none smtp.client-ip=37.18.109.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.ru
Received: from mx02.cloud.ru (localhost [127.0.0.1])
	by mx02.cloud.ru (Postfix) with ESMTP id C7B7D180037
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 12:14:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx02.cloud.ru C7B7D180037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cloud.ru; s=mail;
	t=1769591669; bh=JciuqMD6Pc6t38KINVPA0quVBzwLZjOwoUxkViNNaLI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=XKBQq/d0pn9AzohAL41pNoFvvG/KseuIwl/P4BrZaQMNRpMAZPbA/ej/f7Hx+VRvZ
	 aIcHE/UsOGabLucuHh+TWFWRW+XiWtE8c7ST7JOScoYSQ68T+HXOH/SvCQ5NZyDVnX
	 iGFqSybveSD8NCJZDJYYcqtuBUi4UrwopXAA1ZDz0Oz9JJgY/PWGHP+mXd86YMg14V
	 N92koNzd0QynBkzOO3WLlUJjalyoUDlR/7xoiTnhAstGFsX9tUPIChmR+G5m2Nnh4c
	 2hqGQD58ESLEomNtEEmpYcowfxipVUD76OpcvIf3WgKHYGOlGer1++V54YumfM6l1P
	 l0urZOEskQz7g==
Received: from ksmg.sbercloud.ru (dc01-mail-02.corp.sbercloud.ru [172.23.0.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx02.cloud.ru (Postfix) with ESMTPS
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 12:14:29 +0300 (MSK)
From: =?koi8-r?B?58HMwdPYIPPF0sfFyg==?= <ssgalas@cloud.ru>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RDMA/mlx5: Impact of mlx5_roce::last_port_state initial value on
 ibv_async_event port state change notifications
Thread-Topic: RDMA/mlx5: Impact of mlx5_roce::last_port_state initial value on
 ibv_async_event port state change notifications
Thread-Index: AdyQNmxWl2kBOv3VSPiHv97g/SeDEw==
Date: Wed, 28 Jan 2026 09:14:28 +0000
Message-ID: <e84b5bf1a4e74b0eaa80385b6054e7b5@cloud.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/01/28 07:01:00 #28158508
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	RSPAMD_URIBL(4.50)[cloud.ru:dkim];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-16124-lists,linux-rdma=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[cloud.ru,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloud.ru:+];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[cloud.ru:s=mail];
	RCPT_COUNT_ONE(0.00)[1];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssgalas@cloud.ru,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloud.ru:mid,cloud.ru:dkim]
X-Rspamd-Queue-Id: 6D18C9EC3F
X-Rspamd-Action: no action

Hi everyone,

Kernel version: 5.14.0-570.23.1.el9_6.

Reproducible scenario: Load mlx5_ib module, then execute "ip link set dev <=
active mlx5 device> down" - the InfiniBand subsystem doesn't
send the expected IBV_EVENT_PORT_ERR event. Subsequent "ip link set dev up/=
down" operations on the same device correctly generate
ibv_async_event port state change events.
Investigation revealed that the driver initializes the last_port_state fiel=
d for all mlx5 devices to IB_PORT_DOWN value. Then, the
comparison between last_port_state and actual device status inside mlx5_net=
dev_event after the first "down" operation concludes that the
status hasn't changed, and doesn't generate an event.

So far I haven't found anyone else reporting this issue.

I would like to ask:
1. The last_port_state is used only to prevent sending redundant port state=
 change events. What is the reason for choosing IB_PORT_DOWN as
the initial value? It seems that choosing IB_PORT_NOP would be just as good=
, but would prevent incorrect interpretation of the first device
state event.
2. Is there any additional acceptable way provided by the InfiniBand subsys=
tem to detect the first mlx5 device down event, in addition to
processing ibv_async_event events?
        =F5=F7=E5=E4=EF=ED=EC=E5=EE=E9=E5=EF=EB=EF=EE=E6=E9=E4=E5=EE=E3=E9=
=E1=EC=F8=EE=EF=F3=F4=E9:=FC=D4=CF=DC=CC=C5=CB=D4=D2=CF=CE=CE=CF=C5=D3=CF=
=CF=C2=DD=C5=CE=C9=C5=C9=CC=C0=C2=D9=C5=C4=CF=CB=D5=CD=C5=CE=D4=D9,=D0=D2=
=C9=CC=CF=D6=C5=CE=CE=D9=C5=CB=CE=C5=CD=D5,=D3=CF=C4=C5=D2=D6=C1=D4=CB=CF=
=CE=C6=C9=C4=C5=CE=C3=C9=C1=CC=D8=CE=D5=C0=C9=CE=C6=CF=D2=CD=C1=C3=C9=C0.=
=EE=C1=D3=D4=CF=D1=DD=C9=CD=D5=D7=C5=C4=CF=CD=CC=D1=C5=CD=F7=C1=D3=CF=D4=CF=
=CD,=DE=D4=CF=C5=D3=CC=C9=DC=D4=CF=D3=CF=CF=C2=DD=C5=CE=C9=C5=CE=C5=D0=D2=
=C5=C4=CE=C1=DA=CE=C1=DE=C5=CE=CF=F7=C1=CD,=C9=D3=D0=CF=CC=D8=DA=CF=D7=C1=
=CE=C9=C5,=CB=CF=D0=C9=D2=CF=D7=C1=CE=C9=C5,=D2=C1=D3=D0=D2=CF=D3=D4=D2=C1=
=CE=C5=CE=C9=C5=C9=CE=C6=CF=D2=CD=C1=C3=C9=C9,=D3=CF=C4=C5=D2=D6=C1=DD=C5=
=CA=D3=D1=D7=CE=C1=D3=D4=CF=D1=DD=C5=CD=D3=CF=CF=C2=DD=C5=CE=C9=C9,=C1=D4=
=C1=CB=D6=C5=CF=D3=D5=DD=C5=D3=D4=D7=CC=C5=CE=C9=C5=CC=C0=C2=D9=C8=C4=C5=CA=
=D3=D4=D7=C9=CA=CE=C1=CF=D3=CE=CF=D7=C5=DC=D4=CF=CA=C9=CE=C6=CF=D2=CD=C1=C3=
=C9=C9,=D3=D4=D2=CF=C7=CF=DA=C1=D0=D2=C5=DD=C5=CE=CF.=E5=D3=CC=C9=F7=D9=D0=
=CF=CC=D5=DE=C9=CC=C9=DC=D4=CF=D3=CF=CF=C2=DD=C5=CE=C9=C5=D0=CF=CF=DB=C9=C2=
=CB=C5,=D0=CF=D6=C1=CC=D5=CA=D3=D4=C1,=D3=CF=CF=C2=DD=C9=D4=C5=CF=C2=DC=D4=
=CF=CD=CF=D4=D0=D2=C1=D7=C9=D4=C5=CC=C0=D0=CF=DC=CC=C5=CB=D4=D2=CF=CE=CE=CF=
=CA=D0=CF=DE=D4=C5=C9=D5=C4=C1=CC=C9=D4=C5=DC=D4=CF=D3=CF=CF=C2=DD=C5=CE=C9=
=C5.
CONFIDENTIALITY NOTICE: This email and any files attached to it are confide=
ntial. If you are not the intended recipient you are notified that using, c=
opying, distributing or taking any action in reliance on the contents of th=
is information is strictly prohibited. If you have received this email in e=
rror please notify the sender and delete this email.

