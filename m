Return-Path: <linux-rdma+bounces-21133-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIWkDphgD2ojJwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21133-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 21:44:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209365AB85F
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 21:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AA213008C87
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7CF3839AC;
	Thu, 21 May 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WER0l7bH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E53537C8
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392656; cv=none; b=YrJKN1RBilBvyR//z1QIKdxgVcln9EJ4ee5WVK/3+mY2QemeF8Q4v2fg9UE7MacDDkatisptn4Qfd3PVyH8WXAb4mByCFssRea//0OzJlCb55QMdNqPThVcNfaeyiW5Qs5N0ol4rmXyCKCJE7l5IfEqHLg3WvmKskCkYcCnmvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392656; c=relaxed/simple;
	bh=S0zD82UOtyNbYArboFpgOM3W7EIL7Ds9nxaDoT4GrDk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dV2fmFN63bVr+z3heU5L8p4LocUR+T+0qLZFSgH7lgPDmmWnxxqAG+Deqg8/4EmFDmVFYENgJxCoU7IWNTpYCCJ7oS0QV9OjxYmepUkOsfF5bhIG4Dbbhpjo/2Ik2wk9eWoTASJ0fDOwDlNdxoKPc22HZytWk19pajjiLXPPG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WER0l7bH; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2nedo43tvncnvoqtvrn25i3k4e.protonmail; t=1779392651; x=1779651851;
	bh=iM7i+o9/Pw51wLNo8UkLfCANA1lvdkwy3KKbApvfauk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WER0l7bHQ/6atfj9BHoBIb7SjJOGg1OfRdTS/Cza9pvf2Fa12d1EY9O+B1j0xfg1o
	 ohfkMpewl/Ur3FwvH4QEBDuu4rK3reicqaALUww9QC9J6x6Dj7H6gNFQMIQPHs7Zii
	 Q+ergCxqfHSKFUBou/R6IXOgW6xg+396xDHlahLj1y+H/dp2/otS9rjrZQv9cqAvhc
	 RPiRybMYB4QfgIHy3Rr54LRfrWq+2zXuQHjsmi+LkasZwUow5BwjnZTmEWgFiOBCCe
	 ExJRdE8n7yuPR4EWS+fjoNZZolSEV2DMNokmp4n74E8VcyZHXrqH8dtJWLIy7mjwgl
	 Ptz7xNcgOWYtg==
Date: Thu, 21 May 2026 19:44:05 +0000
To: linux-rdma@vger.kernel.org
From: Tymbark7372 <tymbark7372@proton.me>
Cc: zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com, stable@vger.kernel.org, Tymbark7372 <tymbark7372@proton.me>
Subject: [PATCH 0/4] RDMA/rxe: Fix u64 iova-overflow family in MR/ODP/RESP/MW paths
Message-ID: <20260521194402.811-1-tymbark7372@proton.me>
Feedback-ID: 184352754:user:proton
X-Pm-Message-ID: 1feda32e6a092f4983e23dbe1b709f0b96c717e9
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[proton.me:s=2nedo43tvncnvoqtvrn25i3k4e.protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,proton.me];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21133-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tymbark7372@proton.me,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 209365AB85F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset fixes a family of u64 overflow bugs in the rxe Soft-RoCE
driver.  All four sites share one root cause: addition of an
attacker-influenced iova/addr (u64) with an attacker-influenced
length/resid (size_t/u32/int promoted to u64), without overflow
check, leading to an OOB read/write primitive in the rxe responder
workqueue.

I originally reported these to security@kernel.org.  Jason Gunthorpe
confirmed that rxe and siw are development-only drivers without
embargo handling and asked me to send patches publicly, so I'm
posting here per his direction.  security@kernel.org is intentionally
not in Cc per Jason's instruction.

This is a resend of the patches I sent earlier today as attachments.
Zhu Yanjun pointed out attachments aren't the convention and asked
for inline format via git send-email.

Patches:

  1/4: rxe_mr.c mr_check_range
       The USER/MEM_REG case computes iova + length and compares to
       mr->ibmr.iova + mr->ibmr.length.  Both additions wrap in u64.
       Use check_add_overflow() for both ends.

  2/4: rxe_odp.c rxe_check_pagefault
       Loop condition addr < iova + length wraps when iova is near
       U64_MAX and length is positive.  Compute iova_end with
       check_add_overflow() once and use it in the loop condition.

  3/4: rxe_resp.c duplicate_request
       Third clause iova + resid > res->read.va_org + res->read.length
       has u64 wrap on both sides.  Use check_add_overflow() for both
       ends.  (Site A in check_rkey, also in rxe_resp.c, calls into
       mr_check_range and is closed by patch 1.)

  4/4: rxe_mw.c rxe_check_bind_mw
       Same wrap class as patch 1.  Found by sibling-site grep; not on
       the OOB-write path of the three primary bugs but a
       structurally-identical u64 wrap that would let an attacker bind
       a memory window outside its parent MR's range.

Verification:

Each of the three primary sibling triggers (patches 1, 2, 3) has been
exercised on v7.1.0-rc3 + KASAN in QEMU as the OOB-write case.
Patches 1 and 3 produce a single-page-fault Oops in rxe_mr_copy after
the wrap.  Patch 2 produces a single-page-fault Oops in
rxe_odp_mr_copy.  All three are triggered by a single ibv_post_send
from an unprivileged local user with /dev/infiniband/uverbs0 open.
A working LPE exploit demonstrated end-to-end privilege escalation
via the rxe_odp path under the verification config (KASAN dev-build,
selinux=3D0, nokaslr).  Full PoC and writeup were attached to the
original security@kernel.org submission.

After applying all four patches, the same triggers no longer fire;
the wrap checks correctly reject the attacker iova.  Re-tested in the
same QEMU+KASAN configuration.

The trigger PoCs are simple libibverbs programs (one per sibling)
that I am happy to provide on request.

Fixes / stable:

  1/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
  2/4: Fixes 2fae67ab63db ("RDMA/rxe: Add support for Send/Recv/Write/Read =
with ODP"), v6.15+
  3/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
  4/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+

Pre-f04d5b3d916c LTS branches carry the older wrap form
  iova > mr->ibmr.iova + mr->ibmr.length - length
instead of the current `iova + length > ...` shape.  Patches 1, 3, 4
will need a backport variant for those branches; I can provide on
request.

Tymbark7372 (4):
  RDMA/rxe: Fix u64 iova+length overflow in mr_check_range
  RDMA/rxe: Fix u64 iova+length overflow in rxe_check_pagefault
  RDMA/rxe: Fix u64 iova+resid overflow in duplicate_request
  RDMA/rxe: Fix u64 addr+length overflow in rxe_check_bind_mw

 drivers/infiniband/sw/rxe/rxe_mr.c   | 12 +++++++++---
 drivers/infiniband/sw/rxe/rxe_odp.c  | 10 ++++++++--
 drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++---
 drivers/infiniband/sw/rxe/rxe_mw.c   | 11 ++++++++---
 4 files changed, 33 insertions(+), 11 deletions(-)

--
2.43.0


