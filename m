Return-Path: <linux-rdma+bounces-22073-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ht0eHY8tKWoYSAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22073-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 11:25:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8F667CFE
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 11:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=BQaeTVJ9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22073-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22073-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9342A30000AF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBD93B7742;
	Wed, 10 Jun 2026 09:09:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7103B95FA;
	Wed, 10 Jun 2026 09:09:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082594; cv=none; b=fGH0zqGNUleYbDZBHxPqnj+d2r91AkqENlZh/cu7m1ZiTjdvfdSySLqIJ9Tx9NBeZYex97iQFU1A0GnsWdJazvjQ8TL2GXbOe5YliT4Rp4rFm77aGZj3E/HycnYXVzx2aMkTc+RK2TNUZEPYnTix3VtcW3eYDOA7tw+4VpkTAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082594; c=relaxed/simple;
	bh=Q3c0YkQ00Dg2+6RvLhcCD5TdYu6CuiF/GpPRUubdqnc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mpo1FZSHNzOHex76oBIFIoGRgSrRYWzTj2jH12F1/ghY4vjR6KXMnPsBKW4lmjGtU+nBT2pJgQ32jBwKJnZ/fOjjNjBAyk6QgAydytsFDZvaY6qWcY/iysVwvelB24/MYkeZtA2B6YXe2ug388owIbObKlWfz7rRgXu+9dfzcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BQaeTVJ9; arc=none smtp.client-ip=185.70.43.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781082581; x=1781341781;
	bh=fzpIdMYjk1mOVwb0koV+o6fWh0wxCF1fK7xFHu0BzR0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BQaeTVJ9jWeeb5d/3JeUV/n4qPYIpqXSZ/RBvD7kGdGJ9zge+ZxHDv5UKiouq/0ID
	 TxwMpXnGPhOmcphfdSsKzNnwwosPhGsZG13UYwASSxEeNMd+0U38nhnbBg8OTGfAly
	 DPP5a75nui99/Z2PuQPrLl1Y9n88xgvuwjej5ps9HmvkgKp5lskFKtgZpYwd0g9OYD
	 XeucitQvziLXBFDKz1gj0fSljfal8WEX4F3ViY/zzFpNDjcAHnmETVEPR03uWxl1wg
	 odamJsSRfOArlQwDzLbLgpf4CVYGmNxSf0gxDOip2urExcqTh3saPkrtevOVEQ4CSt
	 2mkToif4B/u0Q==
Date: Wed, 10 Jun 2026 09:09:36 +0000
To: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/smc: bound sndbuf_space on the SMC-D DMB-merge receive path
Message-ID: <20260610090928.192177-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 803145bfb8bf62d5bbca7acd9daaed6e63526b1b
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22073-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,proton.me:dkim,proton.me:email,proton.me:mid,proton.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69C8F667CFE

When the SMC-D send buffer is merged with the peer's DMB (the nocopy
DMB-merge path), smc_cdc_msg_recv_action() advances the local send-buffer
free space from the peer's consumer cursor:

=09diff_tx =3D smc_curs_diff(conn->sndbuf_desc->len,
=09=09=09=09&conn->tx_curs_fin,
=09=09=09=09&conn->local_rx_ctrl.cons);
=09atomic_add(diff_tx, &conn->sndbuf_space);

conn->local_rx_ctrl.cons is the peer's consumer cursor, copied verbatim
from the wire by smcd_cdc_msg_to_host() with no validation.
smc_curs_diff()'s differing-wrap branch returns
(size - old.count) + new.count, which exceeds size for a forged cursor,
so a malicious peer can drive sndbuf_space past sndbuf_desc->len. The
"guarantee 0 <=3D sndbuf_space <=3D sndbuf_desc->len" comment on the
atomic_add() is not enforced.

smc_tx_sendmsg() then reads the inflated sndbuf_space as the available
write space and copies that many user bytes into the send buffer; its
two-chunk wrap-around copy bounds only the first chunk to
sndbuf_desc->len, so the second chunk (copylen - first_chunk, written at
offset 0) runs past the send buffer -- a heap out-of-bounds write of
attacker-influenced length with user-controlled content.

Enforce the documented invariant after the cursor-driven atomic_add(), as
the SMC-D receive path already does for bytes_to_rcv.

Fixes: cc0ab806fc52 ("net/smc: adapt cursor update when sndbuf and peer DMB=
 are merged")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
The out-of-bounds write was reproduced under KASAN by driving
smc_tx_sendmsg()'s two-chunk send-ring copy with an inflated sndbuf_space
(slab-out-of-bounds Write); with the clamp the same input keeps the copy
within sndbuf_desc->len. The DMB-merge/nocopy path that lets a peer
consumer cursor inflate sndbuf_space is reachable with the in-kernel
loopback-ism (CONFIG_SMC_LO), which advertises dmb_nocopy, on commodity
x86 -- no special hardware is required to exercise it.

 net/smc/smc_cdc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 619b3bab3824..cf8d65407ea5 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -365,6 +365,10 @@ static void smc_cdc_msg_recv_action(struct smc_sock *s=
mc,
 =09=09=09smp_mb__before_atomic();
 =09=09=09atomic_add(diff_tx, &conn->sndbuf_space);
 =09=09=09/* guarantee 0 <=3D sndbuf_space <=3D sndbuf_desc->len */
+=09=09=09if (atomic_read(&conn->sndbuf_space) >
+=09=09=09    conn->sndbuf_desc->len)
+=09=09=09=09atomic_set(&conn->sndbuf_space,
+=09=09=09=09=09   conn->sndbuf_desc->len);
 =09=09=09smp_mb__after_atomic();
 =09=09=09smc_curs_copy(&conn->tx_curs_fin,
 =09=09=09=09      &conn->local_rx_ctrl.cons, conn);
--=20
2.43.0



