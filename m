Return-Path: <linux-rdma+bounces-22382-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dbVBG/m/NWrT3wYAu9opvQ
	(envelope-from <linux-rdma+bounces-22382-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 00:17:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077366A7E65
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2026 00:17:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=Bt9PL8sl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22382-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22382-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4680304F231
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 22:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE753537C7;
	Fri, 19 Jun 2026 22:17:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD66313E21;
	Fri, 19 Jun 2026 22:17:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781907442; cv=none; b=Ts3bk10CqpG5j3GuNZqUszIXrCcUnRvbMg9BH7RXOfoJc38F9yAuzbGG75QuqS8rjMe0x/zukwS1J47hd1vxwB9tgo763iK3mfy+b1injZU8Qrm7UQEpLOfDclBmAO0uTJndSloWAZT6B0BC5egk/q6b6g48rU+s6pGVdwFhEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781907442; c=relaxed/simple;
	bh=j2c0IxMiFReviB5vLMVBslvgMK+ny6MI6LdQm5bfSvA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7EN5epo9095TxVquo/ZyLNAOWXErpMJiiKKhz0USBMRqfwrsE9aoIwBYxVrVbfPqG/4XOet1JL4JAVuSUCilD83jaEvEPGVea0a5USWmfHhSrz7oGco8gCcNEyRWfJ3sG0I0FTTycajOCyFTYiNJwI/pHQjsYt0C0ulHYu2Q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Bt9PL8sl; arc=none smtp.client-ip=79.135.106.118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781907430; x=1782166630;
	bh=omSAXEDPBpL+hdOmk3W9RC/tv0AZX4Q/MqWzlQn06zI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bt9PL8slXTyk3KKuSD2+RRfhZW1i5aHA9fNlzIiqqm2Ce53EF28gFIwlKnLDKKMIH
	 OcOlUiLOXKAVRf0CM9/u9GVvnBcGhg/4DmA5g4a8qva6qulUrL6wCiAj1eL0VJPiJl
	 WwCS3hdD4sCVUBhS3kHdl8wJK9gQFKfOPhgah+37X3ujqozpL9c38vsnF3gCHd+wbD
	 lVwZ9Tt48hAENxVahsmHKTWQRAWQi6JQWjMlxZ22bJCa15Slezk4vT5Lvtv5GoM871
	 Jk76G2zBRm2WwMqtrTROhMXYSvaYrl+xlIEPgc+HVu8KBc2diMihYaXFdPnQ2GttZf
	 E3a8vA/gG7vWw==
Date: Fri, 19 Jun 2026 22:17:05 +0000
To: Dust Li <dust.li@linux.alibaba.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, "D . Wythe" <alibuda@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] net/smc: bound the receive length to the RMB in smc_rx_recvmsg()
Message-ID: <20260619221656.568510-1-hexlabsecurity@proton.me>
In-Reply-To: <ajS4BgnyzRsa7HVm@linux.alibaba.com>
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me> <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me> <ajQWxQZXzM2J8kaZ@linux.alibaba.com> <20260618221106.236699-1-hexlabsecurity@proton.me> <ajS4BgnyzRsa7HVm@linux.alibaba.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 1a91e35b3cd3701ded8a0776683ec236139347e5
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:tonylu@linux.alibaba.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22382-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 077366A7E65

On Fri, 19 Jun 2026 11:31:18 +0800, Dust Li wrote:
> I think we can decide after we see the real issue.

Here it is, as a truth table over the real smc_curs_diff. cons is fixed (th=
e app
isn't reading), bytes_to_rcv is the running sum of per-CDC smc_curs_diff(pr=
od_old,
prod_new), len =3D 65504:

  scenario                     b2r       count>=3Dlen  diff>len  occ>len  O=
OB no-clamp  OOB clamp
  honest steady / full / wrap  <=3D len    no          no        no       n=
o            no
  attack single big diff       131007    no          yes       yes      yes=
           no
  attack count=3Dlen-1 wrapflip  327519    no          yes       yes      y=
es           no
  attack wrap++ count=3D0        327520    no          no        no       y=
es           no

Every attack row has count < len, so an input count check accepts it. The l=
ast
row is the one that matters: a peer that just increments prod.wrap with cou=
nt=3D0
adds len to bytes_to_rcv every CDC, unbounded, and no cursor-level check se=
es it.
The per-CDC diff is exactly len, and smc_curs_diff(cons, prod) stays at len
because it can't see the wrap accumulation. The only thing that bounds it i=
s
clamping bytes_to_rcv at the consumer. So #2 isn't subsumed by validating c=
ursors
at the input -- the cursor view can't see the accumulator.

> should we also abort the connection like what we did in patch #1 ?

Yes for net-next. Two caveats: First, the detection
has to be on bytes_to_rcv itself, not on a cursor recompute -- the wrap++ r=
ow
walks past every cursor check, so an occupancy gate at the input wouldn't c=
atch
it. Second, the abort supplements the clamp, it doesn't replace it: the cla=
mp is
synchronous, the abort via queue_work isn't. The producer add runs in the t=
asklet
under bh_lock_sock, the consumer sub runs in smc_recvmsg under lock_sock wh=
ich
drops the spinlock, so they race; between queue_work and abort_work running
smc_conn_kill, smc_recvmsg can read the inflated bytes_to_rcv and copy past=
 the
RMB. The clamp at the consumer is what closes that window.

So v4: -stable keeps the consumer-side clamp on #2, and the same shape on #=
3 for
sndbuf_space and peer_rmbe_space -- no control-flow change. net-next keeps =
the
clamp and, when bytes_to_rcv goes over len (which an honest peer never does=
),
queues the abort the way patch #1 does. Patch #1 keeps its count-based abor=
t for
the urgent index.

Bryam

The table above is this program (gcc -O2 -Wall -Wextra -fwrapv; self-checks=
, exit 0):

  #include <stdio.h>
  #include <stdint.h>
  typedef uint16_t u16; typedef uint32_t u32;
  union hc { struct { u16 reserved; u16 wrap; u32 count; }; };

  /* verbatim net/smc/smc_cdc.h:149-158 */
  static int smc_curs_diff(unsigned int size, const union hc *old, const un=
ion hc *new)
  {
          if (old->wrap !=3D new->wrap) {
                  int v =3D (int)((size - old->count) + new->count);
                  return v > 0 ? v : 0;
          }
          { int v =3D (int)(new->count - old->count); return v > 0 ? v : 0;=
 }
  }

  #define LEN 65504
  struct cur { u16 w; u32 c; };

  /* prod[]/cons[]: cursor positions after each CDC. honest=3Dapp drains so
   * occupancy stays <=3D len; attack=3Dcons stuck. */
  static int run(const char *name, int honest, int n,
                 const struct cur *prod, const struct cur *cons)
  {
          union hc po =3D {0}, co =3D {0};
          long b2r =3D 0; int i, cnt_rej =3D 0, raw_rej =3D 0, occ_rej =3D =
0, fail =3D 0;
          for (i =3D 0; i < n; i++) {
                  union hc p =3D { .wrap =3D prod[i].w, .count =3D prod[i].=
c };
                  union hc c =3D { .wrap =3D cons[i].w, .count =3D cons[i].=
c };
                  int dp =3D smc_curs_diff(LEN, &po, &p);
                  if (prod[i].c >=3D (u32)LEN) cnt_rej =3D 1;
                  if (dp > LEN) raw_rej =3D 1;
                  if (smc_curs_diff(LEN, &c, &p) > LEN) occ_rej =3D 1;
                  b2r +=3D dp; b2r -=3D smc_curs_diff(LEN, &co, &c);
                  po =3D p; co =3D c;
          }
          int oob_noclamp =3D b2r > LEN;
          int oob_clamp   =3D (b2r > LEN ? LEN : b2r) > LEN;   /* always 0 =
*/
          printf("  %-30s b2r=3D%-8ld cnt_rej=3D%d raw_rej=3D%d occ_rej=3D%=
d oob_noclamp=3D%d oob_clamp=3D%d\n",
                 name, b2r, cnt_rej, raw_rej, occ_rej, oob_noclamp, oob_cla=
mp);
          if (honest) fail =3D (cnt_rej || raw_rej || occ_rej || oob_noclam=
p);
          else        fail =3D (oob_clamp || !oob_noclamp);
          return fail;
  }

  int main(void)
  {
          struct cur ps[][5] =3D {
                  {{0,5000}}, {{1,0}}, {{0,30000},{0,60000},{1,10000}},
                  {{1,LEN-1}},
                  {{1,LEN-1},{0,LEN-1},{1,LEN-1},{0,LEN-1}},
                  {{1,0},{2,0},{3,0},{4,0},{5,0}},
          };
          struct cur cs[][5] =3D {
                  {{0,4000}}, {{0,0}}, {{0,0},{0,30000},{0,50000}},
                  {{0,0}},
                  {{0,0},{0,0},{0,0},{0,0}},
                  {{0,0},{0,0},{0,0},{0,0},{0,0}},
          };
          const char *nm[] =3D { "honest: steady", "honest: full ring",
                  "honest: wrapping", "attack: single big diff",
                  "attack: count=3Dlen-1 wrapflip", "attack: wrap++ count=
=3D0" };
          int hon[] =3D { 1,1,1,0,0,0 };
          int nc[]  =3D { 1,1,3,1,4,5 };
          int i, fails =3D 0;
          for (i =3D 0; i < 6; i++)
                  fails +=3D run(nm[i], hon[i], nc[i], ps[i], cs[i]);
          printf("RESULT: %s\n", fails ? "FAIL" : "PASS");
          return fails ? 1 : 0;
  }

(In-kernel KASAN confirming the over-read at count=3D65503 is available on =
request;
a small out-of-tree module driving the same smc_curs_diff over a real
rmb_desc->len allocation -- bytes_to_rcv 131007 -> 327519, slab-out-of-boun=
ds in
the recv copy, clean with the clamp.)


