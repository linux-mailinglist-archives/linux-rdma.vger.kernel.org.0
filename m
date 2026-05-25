Return-Path: <linux-rdma+bounces-21229-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PwRCjEwFGqUKgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21229-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 13:19:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 976395C9E18
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 13:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FA71301CC5E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 11:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C9737BE8C;
	Mon, 25 May 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AeaLa4vV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2A2DC321
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707761; cv=none; b=DSkAS72rhY1vhoXJLMRYaKkUda1Tw8RnVR2DmBb9J697wX9ZQYz35KyJ+MMnRVBW8wnhC6FZek4ph9Po8L+DhlpSGJhOTG9+KWqoRo+fSVD+Pvlakr0Tr8DAx4hR5Zk6qXJnBBcqcy5rWvenvIBEuwKtJRZvz0Wj/ZNAaOK8kM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707761; c=relaxed/simple;
	bh=mtDRWt7WFuKgQ5kCYYELPzGR3CNhlna90MjvE80jGjo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrixQ+8U3LTQy1HhyV34M9X2DPAJCsiKLRpmqfrNrBQ3fyBq/O/Z/hm/hJbWTNsD//LhI/MZSHVkpsRjn7RrPnlUqfvQiq0JxTO5Jhsnm77JWyIrmJvylKIMdBzUw46mYGv5oBugFS+QdsMmrH7LcjOCZSk2gyFQmirQdC4ZGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AeaLa4vV; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779707748; x=1779966948;
	bh=X2c/vTb/90QJIn0reoVa0ShqnmDCBlBEb0LbZ+n1BsQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AeaLa4vVnsersRE/svboMkqofjI+/K4YSEpnm32TJLNV096FQXUZhGirh7WHOU2ah
	 58MiPNRnJxkpSbc/zyySJAmRoI0pPDoVAnr/8k3Txu3hSlrpJCsSLWjo2kYTYQo8NX
	 ophzm9UQxRsNqSlnhNwpkgbv3Ma5PoZHRexg3FE2MpCQZ6Yt2H6qNr6w7/EMaj469Y
	 uT0Rz4PNSSl1dbZjaNXeTCmNPTFB6cIcoZKY7FesRffwLg/YDMQlfn0P2cpfuaPjqm
	 AkkhxEXREIFCtriLTQqTRWjab55Fnl991bj+HPPLzpMTEhSi93gfK1amtxkoBWxqMi
	 /v5hpdDbd+3Gg==
Date: Mon, 25 May 2026 11:15:43 +0000
To: Zhu Yanjun <yanjun.zhu@linux.dev>
From: Tymbark7372 <tymbark7372@proton.me>
Cc: linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH 0/4] RDMA/rxe: Fix u64 iova-overflow family in MR/ODP/RESP/MW paths
Message-ID: <QuzKB10MggFmGWmfyd7fR6r_cI8exwmdYrXemdK6h2MFg-lN9-iRPtdKuL7aGu5GGEODHzOvsj4yFKWL7trcCiIxoT8-FVbKaZyolnO8tOA=@proton.me>
In-Reply-To: <55f7f791-d573-4009-a3ec-68b7e54483d9@linux.dev>
References: <20260521194402.811-1-tymbark7372@proton.me> <55f7f791-d573-4009-a3ec-68b7e54483d9@linux.dev>
Feedback-ID: 184352754:user:proton
X-Pm-Message-ID: 83accba741af51151887c780849182e80b5cc610
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,proton.me:server fail,linux.dev:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21229-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nvidia.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tymbark7372@proton.me,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 976395C9E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zhu,

Thanks for the reply.  The iova on USER MRs is fully attacker-controlled
at three entry points; cited file:line so it's verifiable:

1. Registration via /dev/infiniband/uverbs0:
   drivers/infiniband/core/uverbs_cmd.c:746 does
   `mr->iova =3D cmd.hca_va`.  `cmd.hca_va` comes straight from the
   user's `struct ib_uverbs_reg_mr` over the UAPI.  The only check
   (line 714) is that the low PAGE_SHIFT bits of cmd.hca_va match
   cmd.start -- high bits are not constrained.  Line 731 passes
   `cmd.hca_va` as the `iova` argument to
   `pd->device->ops.reg_user_mr()`, which in rxe is
   `rxe_reg_user_mr()`.  No subsystem rewriting on this path.

2. Work-request posting via ibv_post_send():
   drivers/infiniband/sw/rxe/rxe_verbs.c:822 copies the user's
   `ibwr->sg_list` directly into the WQE; `sge->addr` is the iova
   that subsequently flows to `mr_check_range()` on SEND/RDMA-WRITE.
   User chooses any u64.

3. Network path (RoCEv2):
   drivers/infiniband/sw/rxe/rxe_resp.c:409 reads
   `qp->resp.va =3D reth_va(pkt)` directly from the RETH wire header
   on inbound RDMA-WRITE/READ/ATOMIC.  Line 1357 does the same in
   duplicate_request.  A peer on UDP/4791 with a known QPN/rkey
   controls iova directly.

PoC is a small libibverbs program: register a destination MR with
hca_va =3D 0xFFFFFFFFFFFFFC00, then post a single ibv_post_send()
with IBV_WR_RDMA_WRITE pointing at that MR's rkey, sge.length =3D 0x400.
On v7.1.0-rc3 + KASAN this hits:

  WARNING ... at rxe_mr_iova_to_index+0x135/0x180
  ...
  BUG: unable to handle page fault for address: ffff887b3ba27250
  RIP: 0010:rxe_mr_copy+0x20d/0x5e0

Reproduced as unprivileged uid with /dev/infiniband/uverbs0 open.
Happy to send the four PoC sources (one per sibling) inline if you'd
like to reproduce.

Tymbark7372



On Friday, May 22nd, 2026 at 4:54 AM, Zhu Yanjun <yanjun.zhu@linux.dev> wro=
te:

> =E5=9C=A8 2026/5/21 12:44, Tymbark7372 =E5=86=99=E9=81=93:
> > This patchset fixes a family of u64 overflow bugs in the rxe Soft-RoCE
> > driver.  All four sites share one root cause: addition of an
> > attacker-influenced iova/addr (u64) with an attacker-influenced
> > length/resid (size_t/u32/int promoted to u64), without overflow
> > check, leading to an OOB read/write primitive in the rxe responder
> > workqueue.
>=20
> The core premise of these commits is that a user-space program can
> arbitrarily set the IOVA via /dev/infiniband/uverbs0. I am still
> skeptical about this, as my understanding was that the IOVA is managed
> by the subsystem and difficult for a user to modify. If it is indeed
> possible for a user to control or change this IOVA, then I am completely
> fine with this patchset.
>=20
> Thanks a lot.
> Zhu Yanjun
>=20
> >
> > I originally reported these to security@kernel.org.  Jason Gunthorpe
> > confirmed that rxe and siw are development-only drivers without
> > embargo handling and asked me to send patches publicly, so I'm
> > posting here per his direction.  security@kernel.org is intentionally
> > not in Cc per Jason's instruction.
> >
> > This is a resend of the patches I sent earlier today as attachments.
> > Zhu Yanjun pointed out attachments aren't the convention and asked
> > for inline format via git send-email.
> >
> > Patches:
> >
> >    1/4: rxe_mr.c mr_check_range
> >         The USER/MEM_REG case computes iova + length and compares to
> >         mr->ibmr.iova + mr->ibmr.length.  Both additions wrap in u64.
> >         Use check_add_overflow() for both ends.
> >
> >    2/4: rxe_odp.c rxe_check_pagefault
> >         Loop condition addr < iova + length wraps when iova is near
> >         U64_MAX and length is positive.  Compute iova_end with
> >         check_add_overflow() once and use it in the loop condition.
> >
> >    3/4: rxe_resp.c duplicate_request
> >         Third clause iova + resid > res->read.va_org + res->read.length
> >         has u64 wrap on both sides.  Use check_add_overflow() for both
> >         ends.  (Site A in check_rkey, also in rxe_resp.c, calls into
> >         mr_check_range and is closed by patch 1.)
> >
> >    4/4: rxe_mw.c rxe_check_bind_mw
> >         Same wrap class as patch 1.  Found by sibling-site grep; not on
> >         the OOB-write path of the three primary bugs but a
> >         structurally-identical u64 wrap that would let an attacker bind
> >         a memory window outside its parent MR's range.
> >
> > Verification:
> >
> > Each of the three primary sibling triggers (patches 1, 2, 3) has been
> > exercised on v7.1.0-rc3 + KASAN in QEMU as the OOB-write case.
> > Patches 1 and 3 produce a single-page-fault Oops in rxe_mr_copy after
> > the wrap.  Patch 2 produces a single-page-fault Oops in
> > rxe_odp_mr_copy.  All three are triggered by a single ibv_post_send
> > from an unprivileged local user with /dev/infiniband/uverbs0 open.
> > A working LPE exploit demonstrated end-to-end privilege escalation
> > via the rxe_odp path under the verification config (KASAN dev-build,
> > selinux=3D0, nokaslr).  Full PoC and writeup were attached to the
> > original security@kernel.org submission.
> >
> > After applying all four patches, the same triggers no longer fire;
> > the wrap checks correctly reject the attacker iova.  Re-tested in the
> > same QEMU+KASAN configuration.
> >
> > The trigger PoCs are simple libibverbs programs (one per sibling)
> > that I am happy to provide on request.
> >
> > Fixes / stable:
> >
> >    1/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
> >    2/4: Fixes 2fae67ab63db ("RDMA/rxe: Add support for Send/Recv/Write/=
Read with ODP"), v6.15+
> >    3/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
> >    4/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
> >
> > Pre-f04d5b3d916c LTS branches carry the older wrap form
> >    iova > mr->ibmr.iova + mr->ibmr.length - length
> > instead of the current `iova + length > ...` shape.  Patches 1, 3, 4
> > will need a backport variant for those branches; I can provide on
> > request.
> >
> > Tymbark7372 (4):
> >    RDMA/rxe: Fix u64 iova+length overflow in mr_check_range
> >    RDMA/rxe: Fix u64 iova+length overflow in rxe_check_pagefault
> >    RDMA/rxe: Fix u64 iova+resid overflow in duplicate_request
> >    RDMA/rxe: Fix u64 addr+length overflow in rxe_check_bind_mw
> >
> >   drivers/infiniband/sw/rxe/rxe_mr.c   | 12 +++++++++---
> >   drivers/infiniband/sw/rxe/rxe_odp.c  | 10 ++++++++--
> >   drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++---
> >   drivers/infiniband/sw/rxe/rxe_mw.c   | 11 ++++++++---
> >   4 files changed, 33 insertions(+), 11 deletions(-)
> >
> > --
> > 2.43.0
> >
>=20
> 

