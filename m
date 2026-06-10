Return-Path: <linux-rdma+bounces-22072-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oeLkNw0lKWrQRQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22072-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 10:49:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B9667659
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 10:49:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=6rcxnpf2zzez7flpf4ltxxhqgq.protonmail header.b=KoEf9LrZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22072-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22072-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2680F30144D4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5143A4F58;
	Wed, 10 Jun 2026 08:48:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E83AFAED;
	Wed, 10 Jun 2026 08:48:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081313; cv=none; b=NL6DaTkc5rrEvt8xsDs4ZYshCx9bQSn5JzxdXfQ51dwqL2Oja0wbpgYMAgVUHNmoQSTEwBwjWt17b51MNZ7yhjo6v7PAFXIrNEixDKbsWbepvZKNZP31UNAEsLnPkrrPw60E34jMNxgXBJFtElp4rXaOpct8/prDyViFN/umQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081313; c=relaxed/simple;
	bh=oSb3BjOGDrpzBuRwag4cIOkHeHtiFcIdTetZsHm+c4U=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MobmP8ozhsGNUbA7K61B3udOy7zZQc7ToJMv4TwN8pjTALKsWSf/SUQb4HE78T3JOxkvUJ7OAs9VQNE4mEo2e6iIrwO4u5Iw6mDilvzDT/+J0voaDzykY6VnWg2eNNdHDVSAWWPKHwKE+SDVuCTOLEgl+hZVZFl1NLybNWCstHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KoEf9LrZ; arc=none smtp.client-ip=109.224.244.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6rcxnpf2zzez7flpf4ltxxhqgq.protonmail; t=1781081301; x=1781340501;
	bh=CfVcEwBABCtgdPyDkYpsAiOBarZuyehRLdSudPytfdA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KoEf9LrZG6P6QnULGuMWCDZDfnxz6S50E14JtxRJYRIFKjbqWEhTjddsCgn91lvte
	 28OPmDtR/cyls6a214m+18xcaM5uotWFlfTjHOGTMabhqaaxO6pbUYeeeytuxcemAm
	 G/5ke57UcF4IUN8hGgfnSQEeqL8lOO666CEk5oaBGYQkVEfEn7fL/c3Xd0IYF5/t8a
	 aql8pJ8tW8LbwKY8bEcQmcy25Hd8rQDRgXErBsFQBS5Uf3EmLLBcZy6lokvPqMf14O
	 refda6lWpHrTRgMBQaClpwTPwXZSZSvPNfjVlYr1wA68Ko9DNE2PRgMlJGQCJR79fq
	 dotmaQ98e4rPQ==
Date: Wed, 10 Jun 2026 08:48:13 +0000
To: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/smc: bound the peer producer cursor on SMC-D and SMC-R CDC receive
Message-ID: <20260610084803.186516-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: cc44dd5c1ee3ddfe483529e80be1c51ed93bd6d2
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
	R_DKIM_ALLOW(-0.20)[proton.me:s=6rcxnpf2zzez7flpf4ltxxhqgq.protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:raspl@linux.ibm.com,m:ubraun@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22072-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:dkim,proton.me:email,proton.me:mid,proton.me:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D5B9667659

The SMC CDC receive path copies the peer's producer cursor -- a
wire-controlled value -- into the local connection cursor with no upper
bound against the receive buffer (RMB). A malicious peer can advertise a
producer cursor past rmb_desc->len, which is then used out of bounds:

 - the urgent path uses the cursor count as a raw index:
   smc_cdc_handle_urg_data_arrival() dereferences
   *(rmb_desc->cpu_addr + rx_off + urg_curs.count - 1);

 - the receive path turns the cursor into a length:
   smc_cdc_msg_recv_action() feeds it to smc_curs_diff() and
   atomic_add()s the result into conn->bytes_to_rcv. The differing-wrap
   branch returns (len - old.count) + new.count, which exceeds len for a
   forged cursor and accumulates across CDCs, so bytes_to_rcv grows past
   rmb_desc->len even when the cursor count itself is bounded;
   smc_rx_recvmsg() then copies the wrap-around second chunk past the RMB.

The RMB is a kernel allocation, so the reads disclose adjacent kernel
memory, and a cursor pointing at an unmapped offset faults in the receive
tasklet (softirq). Both transports are affected: SMC-D converts the
cursor in smcd_cdc_msg_to_host() and SMC-R in smc_cdc_cursor_to_host(),
and neither bounds the count.

Bound the producer cursor count to the RMB at both conversion boundaries
(this closes the urgent index on SMC-D and SMC-R) and enforce the
documented "0 <=3D bytes_to_rcv <=3D rmb_desc->len" invariant in
smc_cdc_msg_recv_action() (this closes the receive length, which the
cursor-count clamp alone cannot because of the differing-wrap diff and
the cumulative atomic_add).

Fixes: de8474eb9d50 ("net/smc: urgent data support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproduced under KASAN on 6.12.y. A forged producer cursor with
prod.count =3D rmb_desc->len + 1 and prod_flags.urg_data_present set produc=
es
a 1-byte out-of-bounds read in smc_cdc_handle_urg_data_arrival()
(slab-out-of-bounds Read of size 1); the cursor-count clamp makes the same
input in-bounds. A wrap-flipped cursor drives bytes_to_rcv past
rmb_desc->len across several CDCs so smc_rx_recvmsg() over-reads; the
bytes_to_rcv invariant keeps it bounded. SMC-D was exercised over the
in-kernel loopback-ism and the SMC-R converter (smc_cdc_cursor_to_host)
over an emulated RDMA loopback. Clamping prod.count alone does not bound
the recv length, hence the separate bytes_to_rcv hunk.

 net/smc/smc_cdc.c |  2 ++
 net/smc/smc_cdc.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 619b3bab3824..738c45fd5cd0 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -382,6 +382,8 @@ static void smc_cdc_msg_recv_action(struct smc_sock *sm=
c,
 =09=09smp_mb__before_atomic();
 =09=09atomic_add(diff_prod, &conn->bytes_to_rcv);
 =09=09/* guarantee 0 <=3D bytes_to_rcv <=3D rmb_desc->len */
+=09=09if (atomic_read(&conn->bytes_to_rcv) > conn->rmb_desc->len)
+=09=09=09atomic_set(&conn->bytes_to_rcv, conn->rmb_desc->len);
 =09=09smp_mb__after_atomic();
 =09=09smc->sk.sk_data_ready(&smc->sk);
 =09} else {
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 696cc11f2303..7fa6e0d3817f 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -230,6 +230,12 @@ static inline void smc_cdc_cursor_to_host(union smc_ho=
st_cursor *local,
 =09smc_curs_copy_net(&net, peer, conn);
 =09temp.count =3D ntohl(net.count);
 =09temp.wrap =3D ntohs(net.wrap);
+=09/* the peer producer cursor is wire-controlled; bound the SMC-R count t=
o
+=09 * our RMB before it is used as a raw index by the urgent path, mirrori=
ng
+=09 * the SMC-D conversion in smcd_cdc_msg_to_host().
+=09 */
+=09if (temp.count > conn->rmb_desc->len)
+=09=09temp.count =3D conn->rmb_desc->len;
 =09if ((old.wrap > temp.wrap) && temp.wrap)
 =09=09return;
 =09if ((old.wrap =3D=3D temp.wrap) &&
@@ -260,6 +266,12 @@ static inline void smcd_cdc_msg_to_host(struct smc_hos=
t_cdc_msg *local,
=20
 =09temp.wrap =3D peer->prod.wrap;
 =09temp.count =3D peer->prod.count;
+=09/* the peer producer cursor is wire-controlled; a count past our RMB is
+=09 * used as a raw index by the urgent path (smc_cdc_handle_urg_data_arri=
val)
+=09 * and as a length by the recv path.  Bound it to the RMB.
+=09 */
+=09if (temp.count > conn->rmb_desc->len)
+=09=09temp.count =3D conn->rmb_desc->len;
 =09smc_curs_copy(&local->prod, &temp, conn);
=20
 =09temp.wrap =3D peer->cons.wrap;
--=20
2.43.0



