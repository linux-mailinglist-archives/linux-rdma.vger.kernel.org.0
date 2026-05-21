Return-Path: <linux-rdma+bounces-21129-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKu2Nto7D2rQIAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21129-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 19:07:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6514D5A9E2D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B51C7370F8C0
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C71DED4C;
	Thu, 21 May 2026 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gAd9iPA6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D3199931
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377964; cv=none; b=RlLF3Mxa+hJIomWMCJBigxKeyKXI1BwPkCWwSYz4XB5G8ER4IrIChaYV2VEuhYekcFOxjJhD+BdLpVr3QNR5U6kg8e/H9kShce5BmWvnMoFMQUi0LL7bWHUDTwcXnzfTE3oymfTit+vyA+jQ86xD/e75v6UOi+k9SrVBKgUFKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377964; c=relaxed/simple;
	bh=/tKXtVDRYRj0gZZOvfT8oxH9j1Y+UjoLH91fPj6xKjM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rK66mCwm3D5yKR5NRDnD0iWBVtNSwROcDUEFu/icOSJemcrJuTjKTycV7i/K+4C/eXoTBbhbVdsTdzxHWi5CQraXrpZdL0IbvI/eoRExANCxqox0nCAZg8pUIYfNo39JAX3cFhvAt9dc1HqbsULeF+1hYFDKmACgMjArTZwjy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gAd9iPA6; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7thsii2zyvddpfuyeuctt54tma.protonmail; t=1779377953; x=1779637153;
	bh=xHOX/3aL7lQjxDLwyOmFgfhykbzYjBqLi1VjjqrJrEU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gAd9iPA6LAH2ymutpwd6p4zDdpo4MtknINmiXrUzo/t7tOLzJrjqVrBw8IH9GZ2zo
	 opW3ntFjCj9upTOfP7HpAnQuXlflR38UePO3Gslsl3u2yEMeeT9jinV+HeBJ1GbSJS
	 yVVf596oH4O0RfVHZnHQVnE+DCFO5o8fESFCo3kINsvECwBnwKctRU5tkQ9tpWlyE4
	 PC9dnqlpnY1sH2f9/34HPDipbKoIcCoO2cz0Qlz5ydiz2Yc+R4c4FsBx7w+PkxJDcL
	 mAxhkszSWQpSh+ucndoaHKmeDeol8Zo7JHos5B4FDcu5mDZ09ofkweI/UE/yehO4pE
	 PiiW6N2oOu5mw==
Date: Thu, 21 May 2026 15:39:07 +0000
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From: Tymbark7372 <tymbark7372@proton.me>
Cc: "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "leonro@nvidia.com" <leonro@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 0/4] RDMA/rxe: Fix u64 iova-overflow family in MR/ODP/RESP/MW paths
Message-ID: <GmtGfyiQI2c4YxeWS7woOgXgSEajslDC8awnuf_4qoOJJqg9XR_fzYq1AbkS9jp10kWIArTMsMRAu7rg9lgK3nKuWILBpSaJhFV7i_0-yXo=@proton.me>
Feedback-ID: 184352754:user:proton
X-Pm-Message-ID: f0415bfff3e0983116b661da69ded249ece82172
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_pnutIBOvCqFI97cAdMN8vn1stR9KF4pHnE7stAM60Q"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=7thsii2zyvddpfuyeuctt54tma.protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21129-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~,3:~,4:~,5:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tymbark7372@proton.me,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6514D5A9E2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--b1=_pnutIBOvCqFI97cAdMN8vn1stR9KF4pHnE7stAM60Q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes a family of u64 overflow bugs in the rxe Soft-RoCE
driver.  All four sites share one root cause: addition of an
attacker-influenced iova/addr (u64) with an attacker-influenced
length/resid (size_t/u32/int promoted to u64), without overflow
check, leading to an OOB read/write primitive in the rxe responder
workqueue.

I originally reported these to security@kernel.org.  Jason Gunthorpe
confirmed that rxe and siw are development-only drivers without
embargo handling and asked me to send patches publicly, so this
series follows that direction.  security@kernel.org is intentionally
not in Cc per Jason's instruction.

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
Tymbark7372 <tymbark7372@proton.me>
--b1=_pnutIBOvCqFI97cAdMN8vn1stR9KF4pHnE7stAM60Q
Content-Type: application/octet-stream; name=0003-RDMA-rxe-Fix-u64-iova-resid-overflow-in-duplicate_request.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0003-RDMA-rxe-Fix-u64-iova-resid-overflow-in-duplicate_request.patch

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUeW1iYXJrNzM3MiA8dHltYmFyazczNzJAcHJvdG9uLm1lPgpE
YXRlOiBXZWQsIDIwIE1heSAyMDI2IDE5OjM0OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSCAzLzRd
IFJETUEvcnhlOiBGaXggdTY0IGlvdmErcmVzaWQgb3ZlcmZsb3cgaW4gZHVwbGljYXRlX3JlcXVl
c3QKCkluIHRoZSBkdXBsaWNhdGUtUkVBRCBoYW5kbGluZyBvZiBkdXBsaWNhdGVfcmVxdWVzdCgp
LCB0aGUgdGhpcmQKY2xhdXNlIG9mIHRoZSBib3VuZCBjaGVjayBjb21wdXRlcyAoaW92YSArIHJl
c2lkKSBhbmQgY29tcGFyZXMgaXQKd2l0aCAocmVzLT5yZWFkLnZhX29yZyArIHJlcy0+cmVhZC5s
ZW5ndGgpLiAgaW92YSBpcyB1NjQsIHJlc2lkIGlzCnUzMiBwcm9tb3RlZCB0byB1NjQ7IHRoZSBh
ZGRpdGlvbiB3cmFwcyBtb2R1bG8gMl42NC4gIEFuIGF0dGFja2VyCnNldHRpbmcgcmV0aF92YSA9
IDB4RkZGRkZGRkZGRkZGRkMwMCBhbmQgcmV0aF9sZW4gPSAweDQwMCBjYXVzZXMgdGhlCmxlZnQt
aGFuZCBzdW0gdG8gd3JhcCB0byAwIHdoaWxlIHRoZSByaWdodC1oYW5kIHN1bSBzdGF5cyBzbWFs
bCwgc28KdGhlIGNoZWNrIHBhc3NlcyBhbmQgcmVzLT5yZWFkLnZhIGlzIGxhdGVyIHNldCB0byB0
aGUgd3JhcCBhZGRyZXNzIG9uCnJlcGxheS4KCkRvd25zdHJlYW0gb2YgZWl0aGVyIGJvdW5kIGNo
ZWNrIHNpdGUgaW4gcnhlX3Jlc3AuYywgcmVhZF9yZXBseQpjYWxscyByeGVfbXJfY29weSgpIHdp
dGggdGhlIHdyYXAgaW92YSwgd2hpY2ggcmUtdHJhdmVyc2VzCm1yX2NoZWNrX3JhbmdlKCkgYW5k
IHJ4ZV9tcl9pb3ZhX3RvX2luZGV4KCksIGFuZCByeGVfbXJfY29weV94YXJyYXkoKQpPT0ItZGVy
ZWZzIHBhZ2VfaW5mb1todWdlX2lkeF0uICBUaGUgcHJpbWl0aXZlIGlzIHRoZSBzYW1lIGFzIHBh
dGNoCjEgb2YgdGhpcyBzZXJpZXMsIHJlYWNoZWQgdmlhIHRoZSBSRE1BX1JFQUQgcGF0aCBvbiBh
IGR1cGxpY2F0ZQoocmV0cmFuc21pdHRlZCkgcmVxdWVzdC4KClVzZSBjaGVja19hZGRfb3ZlcmZs
b3coKSBvbiBib3RoIHNpZGVzIG9mIHRoZSBjb21wYXJpc29uLgoKUmVwcm9kdWNlZCBvbiB2Ny4x
LjAtcmMzICsgS0FTQU4gd2l0aCBhIHNpbmdsZQppYnZfcG9zdF9zZW5kKElCVl9XUl9SRE1BX1JF
QUQpIGZvbGxvd2VkIGJ5IGEgcmV0cmFuc21pdCBvZiB0aGUKaWRlbnRpY2FsIHBhY2tldCwgd2l0
aCB0aGUgd3JhcCBpb3ZhIGFib3ZlLiAgV0FSTiBhdApyeGVfbXJfaW92YV90b19pbmRleCsweDEz
NSBmb2xsb3dlZCBieSBwYWdlLWZhdWx0IE9vcHMgaW4KcnhlX21yX2NvcHkrMHgyMGQgb24gdGhl
IFJFQUQgcGF0aCAocnhlX3JlY2VpdmVyKzB4M2M3MCwgZGlzdGluY3QKZnJvbSB0aGUgV1JJVEUg
b2Zmc2V0IHJ4ZV9yZWNlaXZlcisweDZhYTggdGhhdCB0aGUgcGF0Y2ggMSB0cmlnZ2VyCnJlYWNo
ZXMpLgoKRml4ZXM6IDg3MDBlM2U3YzQ4NSAoIlNvZnQgUm9DRSBkcml2ZXIiKQpDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZyAjIHY0LjgrClJlcG9ydGVkLWJ5OiBUeW1iYXJrNzM3MiA8dHltYmFy
azczNzJAcHJvdG9uLm1lPgpTaWduZWQtb2ZmLWJ5OiBUeW1iYXJrNzM3MiA8dHltYmFyazczNzJA
cHJvdG9uLm1lPgpBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQtNwotLS0KIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDExICsrKysrKysrLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3Jlc3AuYwotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNw
LmMKKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jCkBAIC0xMzU2LDEx
ICsxMzU2LDE2IEBAIHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGR1cGxpY2F0ZV9yZXF1ZXN0KHN0
cnVjdCByeGVfcXAgKnFwLAogCQkJICovCiAJCQl1NjQgaW92YSA9IHJldGhfdmEocGt0KTsKIAkJ
CXUzMiByZXNpZCA9IHJldGhfbGVuKHBrdCk7CisJCQl1NjQgdmFfZW5kX29yaWcsIHZhX2VuZF9u
ZXc7CgotCQkJaWYgKGlvdmEgPCByZXMtPnJlYWQudmFfb3JnIHx8CisJCQlpZiAoY2hlY2tfYWRk
X292ZXJmbG93KHJlcy0+cmVhZC52YV9vcmcsCisJCQkJCSAgICAgICAodTY0KXJlcy0+cmVhZC5s
ZW5ndGgsCisJCQkJCSAgICAgICAmdmFfZW5kX29yaWcpIHx8CisJCQkgICAgY2hlY2tfYWRkX292
ZXJmbG93KGlvdmEsICh1NjQpcmVzaWQsCisJCQkJCSAgICAgICAmdmFfZW5kX25ldykgfHwKKwkJ
CSAgICBpb3ZhIDwgcmVzLT5yZWFkLnZhX29yZyB8fAogCQkJICAgIHJlc2lkID4gcmVzLT5yZWFk
Lmxlbmd0aCB8fAotCQkJICAgIChpb3ZhICsgcmVzaWQpID4gKHJlcy0+cmVhZC52YV9vcmcgKwot
CQkJCQkgICAgICByZXMtPnJlYWQubGVuZ3RoKSkgeworCQkJICAgIHZhX2VuZF9uZXcgPiB2YV9l
bmRfb3JpZykgewogCQkJCXJjID0gUkVTUFNUX0NMRUFOVVA7CiAJCQkJZ290byBvdXQ7CiAJCQl9
Ci0tCjIuNDMuMAo=

--b1=_pnutIBOvCqFI97cAdMN8vn1stR9KF4pHnE7stAM60Q
Content-Type: application/octet-stream; name=0004-RDMA-rxe-Fix-u64-addr-length-overflow-in-rxe_check_bind_mw.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0004-RDMA-rxe-Fix-u64-addr-length-overflow-in-rxe_check_bind_mw.patch

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUeW1iYXJrNzM3MiA8dHltYmFyazczNzJAcHJvdG9uLm1lPgpE
YXRlOiBXZWQsIDIwIE1heSAyMDI2IDE5OjM0OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSCA0LzRd
IFJETUEvcnhlOiBGaXggdTY0IGFkZHIrbGVuZ3RoIG92ZXJmbG93IGluIHJ4ZV9jaGVja19iaW5k
X213CgpyeGVfY2hlY2tfYmluZF9tdygpIHZhbGlkYXRlcyB0aGF0IGEgVHlwZSAyIG1lbW9yeSB3
aW5kb3cncyByYW5nZQpbYWRkciwgYWRkciArIGxlbmd0aCkgaXMgY29udGFpbmVkIHdpdGhpbiBp
dHMgcGFyZW50IE1SJ3MgcmFuZ2UKW21yLT5pYm1yLmlvdmEsIG1yLT5pYm1yLmlvdmEgKyBtci0+
aWJtci5sZW5ndGgpLiAgQm90aCBlbmQtYWRkaXRpb24Kc3VtcyB3cmFwIG1vZHVsbyAyXjY0LiAg
QW4gYXR0YWNrZXIgY2FuIGJpbmQgYSBtZW1vcnkgd2luZG93IHdob3NlCm5vbWluYWwgcmFuZ2Ug
ZXhjZWVkcyB0aGUgcGFyZW50IE1SIGJ5IHdyYXBwaW5nIHRoZSBjb21wYXJpc29uIHN1bQp0byBh
IHZhbHVlIGJlbG93IHRoZSBwYXJlbnQncyBpb3ZhLgoKVGhpcyBpcyB0aGUgc2FtZSB3cmFwIGNs
YXNzIGFzIHBhdGNoIDEgb2YgdGhpcyBzZXJpZXM7IGl0IHdhcyBmb3VuZApieSBzaWJsaW5nLXNp
dGUgZ3JlcCBhZ2FpbnN0IHRoZSBvdGhlciByeGUgaW92YSBjaGVja3MgYW5kIGlzIG5vdCBvbgp0
aGUgT09CLXdyaXRlIHBhdGggb2YgdGhlIHRocmVlIHByaW1hcnkgYnVncy4gIEkgaGF2ZSBub3QK
ZGVtb25zdHJhdGVkIGEgZG93bnN0cmVhbSBPT0IgcHJpbWl0aXZlIHRoYXQgdXNlcyB0aGlzIHNw
ZWNpZmljCmVzY2FwZSwgc28gaXQgaXMgZmlsZWQgaGVyZSBhcyBhIGRlZmVuc2l2ZSBzaWJsaW5n
IGZpeCByYXRoZXIgdGhhbiBhcwphIHNlcGFyYXRlIGV4cGxvaXRhYmxlIGJ1Zy4gIEZvbGRpbmcg
aXQgaW50byB0aGUgc2FtZSBzZXJpZXMga2VlcHMKdGhlIHdyYXAtY2xhc3MgZml4ZXMgdG9nZXRo
ZXIuCgpVc2UgY2hlY2tfYWRkX292ZXJmbG93KCkgb24gYm90aCBlbmRzLgoKRml4ZXM6IDg3MDBl
M2U3YzQ4NSAoIlNvZnQgUm9DRSBkcml2ZXIiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAj
IHY0LjgrClJlcG9ydGVkLWJ5OiBUeW1iYXJrNzM3MiA8dHltYmFyazczNzJAcHJvdG9uLm1lPgpT
aWduZWQtb2ZmLWJ5OiBUeW1iYXJrNzM3MiA8dHltYmFyazczNzJAcHJvdG9uLm1lPgpBc3Npc3Rl
ZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQtNwotLS0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX213LmMgfCAxMSArKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9tdy5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXcuYwotLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tdy5jCisrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX213LmMKQEAgLTEyMCw5ICsxMjAsMTQgQEAKIAkJCXJldHVybiAtRUlOVkFM
OwogCQl9CiAJfSBlbHNlIHsKLQkJaWYgKHVubGlrZWx5KCh3cWUtPndyLndyLm13LmFkZHIgPCBt
ci0+aWJtci5pb3ZhKSB8fAotCQkJICAgICAoKHdxZS0+d3Iud3IubXcuYWRkciArIHdxZS0+d3Iu
d3IubXcubGVuZ3RoKSA+Ci0JCQkgICAgICAobXItPmlibXIuaW92YSArIG1yLT5pYm1yLmxlbmd0
aCkpKSkgeworCQl1NjQgbXdfZW5kLCBtcl9lbmQ7CisKKwkJaWYgKHVubGlrZWx5KGNoZWNrX2Fk
ZF9vdmVyZmxvdyh3cWUtPndyLndyLm13LmFkZHIsCisJCQkJCQl3cWUtPndyLndyLm13Lmxlbmd0
aCwgJm13X2VuZCkgfHwKKwkJCSAgICAgY2hlY2tfYWRkX292ZXJmbG93KG1yLT5pYm1yLmlvdmEs
CisJCQkJCQltci0+aWJtci5sZW5ndGgsICZtcl9lbmQpIHx8CisJCQkgICAgIHdxZS0+d3Iud3Iu
bXcuYWRkciA8IG1yLT5pYm1yLmlvdmEgfHwKKwkJCSAgICAgbXdfZW5kID4gbXJfZW5kKSkgewog
CQkJcnhlX2RiZ19tdyhtdywKIAkJCQkiYXR0ZW1wdCB0byBiaW5kIGEgVkEgTVcgb3V0c2lkZSBv
ZiB0aGUgTVJcbiIpOwogCQkJcmV0dXJuIC1FSU5WQUw7Ci0tCjIuNDMuMAo=

--b1=_pnutIBOvCqFI97cAdMN8vn1stR9KF4pHnE7stAM60Q
Content-Type: application/octet-stream; name=0002-RDMA-rxe-Fix-u64-iova-length-overflow-in-rxe_check_pagefault.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0002-RDMA-rxe-Fix-u64-iova-length-overflow-in-rxe_check_pagefault.patch

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUeW1iYXJrNzM3MiA8dHltYmFyazczNzJAcHJvdG9uLm1lPgpE
YXRlOiBXZWQsIDIwIE1heSAyMDI2IDE5OjM0OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzRd
IFJETUEvcnhlOiBGaXggdTY0IGlvdmErbGVuZ3RoIG92ZXJmbG93IGluIHJ4ZV9jaGVja19wYWdl
ZmF1bHQKCnJ4ZV9jaGVja19wYWdlZmF1bHQoKSBsb29wcyB3aXRoIHRoZSBjb25kaXRpb24KImFk
ZHIgPCBpb3ZhICsgbGVuZ3RoIiB3aGVyZSBpb3ZhIGlzIHU2NCBhbmQgbGVuZ3RoIGlzIGludC4g
IFRoZQphZGRpdGlvbiBpcyBwcm9tb3RlZCB0byB1NjQgYW5kIHdyYXBzIG1vZHVsbyAyXjY0IHdo
ZW4gaW92YSBpcyBuZWFyClU2NF9NQVguICBXaXRoIGlvdmEgPSAweEZGRkZGRkZGRkZGRkZDMDAg
YW5kIGxlbmd0aCA9IDB4NDAwIHRoZSBzdW0KaXMgMDsgdGhlIGxvb3AgYm9keSBuZXZlciBleGVj
dXRlczsgdGhlIGZ1bmN0aW9uIHJldHVybnMKbmVlZF9mYXVsdCA9IGZhbHNlOyBhbmQgdGhlIHBy
ZWZldGNoLWZhdWx0IGNoZWNrIGlzIGJ5cGFzc2VkLgoKQ29udHJvbCB0aGVuIGVudGVycyBfX3J4
ZV9vZHBfbXJfY29weSgpLCB3aGljaCBjYWxscwpyeGVfb2RwX2lvdmFfdG9faW5kZXgoKSBvbiB0
aGUgd3JhcCBpb3ZhIHRvIG9idGFpbiBhIGh1Z2UgaW5kZXgsIGFuZApkZXJlZmVyZW5jZXMgdW1l
bV9vZHAtPm1hcC5wZm5fbGlzdFtodWdlX2lkeF0sIGFuIGF0dGFja2VyLWNvbnRyb2xsZWQKb3V0
LW9mLWJvdW5kcyBzbG90LiAgaG1tX3Bmbl90b19wYWdlKCkgcmVzb2x2ZXMgdGhlIHJlYWQgdmFs
dWUgdG8gYW4KYXR0YWNrZXItY2hvc2VuIHN0cnVjdCBwYWdlLCBhZnRlciB3aGljaCBtZW1jcHkg
bGFuZHMgYXQKa21hcF9sb2NhbF9wYWdlKHRoYXRfcGFnZSkgKyBvZmZzZXQsIHlpZWxkaW5nIGFy
Yml0cmFyeSBrZXJuZWwgd3JpdGUuCgpSZWplY3QgYW55IGlvdmEvbGVuZ3RoIHBhaXIgdGhhdCBv
dmVyZmxvd3MgYnkgY29tcHV0aW5nIGlvdmFfZW5kIHdpdGgKY2hlY2tfYWRkX292ZXJmbG93KCkg
b25jZSBiZWZvcmUgdGhlIGxvb3AgYW5kIHVzaW5nIGl0IGFzIHRoZSBsb29wCmJvdW5kLiAgQSBu
ZWdhdGl2ZSBsZW5ndGggaXMgYWxzbyByZWplY3RlZCB0byBhdm9pZCB1NjQgcHJvbW90aW9uCm1h
c2tpbmcgdGhlIGNhc2UuCgpSZXByb2R1Y2VkIG9uIHY3LjEuMC1yYzMgKyBLQVNBTiB3aXRoIGEg
c2luZ2xlIFJETUFfV1JJVEUgYWdhaW5zdCBhbgpPRFAtZmxhZ2dlZCBNUjsgdGhlIGtlcm5lbCBv
b3BzZXMgaW4gcnhlX29kcF9tcl9jb3B5KzB4MjA1IHdpdGgKUlNJPTB4ZmZmZmZmZmZmZmZmZmMw
MCAodGhlIHdyYXAgaW92YSkgYW5kIFIxMyBob2xkaW5nIHRoZSByZXNvbHZlZAp3cmFwcGVkIGlu
ZGV4LiAgQSB3b3JraW5nIExQRSBjaGFpbiB0aGF0IHVzZXMgdGhpcyBPT0IgcHJpbWl0aXZlIHRv
Cm92ZXJ3cml0ZSBjcmVkX2phciBzbGFiIHBhZ2VzIHdhcyBkZW1vbnN0cmF0ZWQgZW5kLXRvLWVu
ZCBvbiB0aGUgc2FtZQp2ZXJpZmljYXRpb24ga2VybmVsLgoKRml4ZXM6IDJmYWU2N2FiNjNkYiAo
IlJETUEvcnhlOiBBZGQgc3VwcG9ydCBmb3IgU2VuZC9SZWN2L1dyaXRlL1JlYWQgd2l0aCBPRFAi
KQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjE1KwpSZXBvcnRlZC1ieTogVHltYmFy
azczNzIgPHR5bWJhcms3MzcyQHByb3Rvbi5tZT4KU2lnbmVkLW9mZi1ieTogVHltYmFyazczNzIg
PHR5bWJhcms3MzcyQHByb3Rvbi5tZT4KQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy00
LTcKLS0tCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vZHAuYyB8IDEwICsrKysrKysr
LS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb2RwLmMgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9vZHAuYwotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9vZHAuYworKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9vZHAuYwpAQCAt
MTI3LDEzICsxMjcsMTkgQEAgc3RhdGljIGlubGluZSBib29sIHJ4ZV9jaGVja19wYWdlZmF1bHQo
c3RydWN0IGliX3VtZW1fb2RwICp1bWVtX29kcCwgdTY0IGlvdmEsCiAJCQkJICAgICAgIGludCBs
ZW5ndGgpCiB7CiAJYm9vbCBuZWVkX2ZhdWx0ID0gZmFsc2U7Ci0JdTY0IGFkZHI7CisJdTY0IGFk
ZHIsIGlvdmFfZW5kOwogCWludCBpZHg7CgorCWlmIChsZW5ndGggPCAwIHx8CisJICAgIGNoZWNr
X2FkZF9vdmVyZmxvdyhpb3ZhLCAodTY0KWxlbmd0aCwgJmlvdmFfZW5kKSkgeworCQkvKiBsZXQg
dGhlIHBhZ2VmYXVsdCBwYXRoIHJlamVjdCBhIGJvZ3VzIGlvdmEvbGVuZ3RoICovCisJCXJldHVy
biB0cnVlOworCX0KKwogCWFkZHIgPSBpb3ZhICYgKH4oQklUKHVtZW1fb2RwLT5wYWdlX3NoaWZ0
KSAtIDEpKTsKCiAJLyogU2tpbSB0aHJvdWdoIGFsbCBwYWdlcyB0aGF0IGFyZSB0byBiZSBhY2Nl
c3NlZC4gKi8KLQl3aGlsZSAoYWRkciA8IGlvdmEgKyBsZW5ndGgpIHsKKwl3aGlsZSAoYWRkciA8
IGlvdmFfZW5kKSB7CiAJCWlkeCA9IChhZGRyIC0gaWJfdW1lbV9zdGFydCh1bWVtX29kcCkpID4+
IHVtZW1fb2RwLT5wYWdlX3NoaWZ0OwoKIAkJaWYgKCEodW1lbV9vZHAtPm1hcC5wZm5fbGlzdFtp
ZHhdICYgSE1NX1BGTl9WQUxJRCkpIHsKLS0KMi40My4wCg==

--b1=_pnutIBOvCqFI97cAdMN8vn1stR9KF4pHnE7stAM60Q
Content-Type: application/octet-stream; name=0001-RDMA-rxe-Fix-u64-iova-length-overflow-in-mr_check_range.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-RDMA-rxe-Fix-u64-iova-length-overflow-in-mr_check_range.patch

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUeW1iYXJrNzM3MiA8dHltYmFyazczNzJAcHJvdG9uLm1lPgpE
YXRlOiBXZWQsIDIwIE1heSAyMDI2IDE5OjM0OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzRd
IFJETUEvcnhlOiBGaXggdTY0IGlvdmErbGVuZ3RoIG92ZXJmbG93IGluIG1yX2NoZWNrX3Jhbmdl
CgpJbiBtcl9jaGVja19yYW5nZSgpLCB0aGUgSUJfTVJfVFlQRV9VU0VSIGFuZCBJQl9NUl9UWVBF
X01FTV9SRUcgY2FzZQpjb21wdXRlcyBib3RoIGlvdmEgKyBsZW5ndGggYW5kIG1yLT5pYm1yLmlv
dmEgKyBtci0+aWJtci5sZW5ndGggd2l0aG91dApvdmVyZmxvdyBjaGVjay4gIEJvdGggaW92YSAo
dTY0KSBhbmQgbGVuZ3RoIChzaXplX3QpIGFyZSA2NC1iaXQgb24KNjQtYml0IHBsYXRmb3Jtcy4g
IEFuIGF0dGFja2VyIHNldHRpbmcgaW92YSA9IDB4RkZGRkZGRkZGRkZGRkMwMCBhbmQKbGVuZ3Ro
ID0gMHg0MDAgd3JhcHMgdGhlIHN1bSB0byAwLCBzbyB0aGUgYm91bmQgY2hlY2sKImlvdmEgKyBs
ZW5ndGggPiBtci0+aWJtci5pb3ZhICsgbXItPmlibXIubGVuZ3RoIiBwYXNzZXMuCgpBZnRlciB0
aGUgYnlwYXNzLCByeGVfbXJfaW92YV90b19pbmRleCgpIGNvbXB1dGVzIGEgaHVnZSBpbmRleCB2
YWx1ZTsKV0FSTl9PTihpZHggPj0gbXItPm5idWYpIGZpcmVzIGJ1dCBkb2VzIG5vdCBhYm9ydCwg
YW5kCnJ4ZV9tcl9jb3B5X3hhcnJheSgpIHRoZW4gZGVyZWZlcmVuY2VzIHBhZ2VfaW5mb1todWdl
X2lkeF0sIGFuCmF0dGFja2VyLWNvbnRyb2xsZWQgb3V0LW9mLWJvdW5kcyBzbG90LiAgSW4gdGhl
IFJYRV9UT19NUl9PQkoKZGlyZWN0aW9uIHRoaXMgYmVjb21lcyBhbiBPT0Igd3JpdGUgb2YgYXR0
YWNrZXIgcGF5bG9hZCBieXRlcyB0aHJvdWdoCmluZm8tPnBhZ2UgKyBpbmZvLT5vZmZzZXQuCgpV
c2UgY2hlY2tfYWRkX292ZXJmbG93KCkgb24gYm90aCBlbmRzIHRvIHJlamVjdCBhbnkgaW92YS9s
ZW5ndGggcGFpcgp0aGF0IHdyYXBzLiAgQWxzbyBleHBsaWNpdGx5IHNjb3BlIHRoZSBsb2NhbCBk
ZWNsYXJhdGlvbnMgaW50cm9kdWNlZApieSB0aGUgaGVscGVyIHZhcmlhYmxlcy4KClJlYWNoYWJs
ZSBmcm9tIGFueSB1bnByaXZpbGVnZWQgbG9jYWwgcHJvY2VzcyB3aXRoCi9kZXYvaW5maW5pYmFu
ZC91dmVyYnMwIG9wZW4gKHdvcmxkLXJ3IG9uIGRpc3Ryb3MgdGhhdCBzaGlwIHRoZQpyZG1hLWNv
cmUgdWRldiBydWxlcykgYW5kIGZyb20gYW4gdW5hdXRoZW50aWNhdGVkIHJlbW90ZSBwZWVyIG92
ZXIKVURQLzQ3OTEgKFJvQ0V2Mikgd2hlbiB0aGUgdGFyZ2V0IHJrZXkvUVBOIGFyZSBrbm93bi4g
IFJlcHJvZHVjZWQgb24KdjcuMS4wLXJjMyArIEtBU0FOIHdpdGggYSBzaW5nbGUgaWJ2X3Bvc3Rf
c2VuZChJQlZfV1JfUkRNQV9XUklURSkgYW5kCnRoZSB3cmFwIGlvdmEgYWJvdmU7IHRoZSBrZXJu
ZWwgb29wc2VzIGluIHJ4ZV9tcl9jb3B5KzB4MjBkIGFmdGVyCldBUk4gYXQgcnhlX21yX2lvdmFf
dG9faW5kZXgrMHgxMzUuCgpTaXRlIEEgaW4gcnhlX3Jlc3AuYyAoY2hlY2tfcmtleSgpKSByZWFj
aGVzIG1yX2NoZWNrX3JhbmdlKCkgd2l0aAphdHRhY2tlciBpb3ZhIGFzIHdlbGwsIHNvIHRoaXMg
cGF0Y2ggYWxzbyBjbG9zZXMgdGhhdCBwYXRoOyBTaXRlIEIKKGR1cGxpY2F0ZV9yZXF1ZXN0LCBh
bHNvIGluIHJ4ZV9yZXNwLmMpIGhhcyBhbiBpbmRlcGVuZGVudCBpbmxpbmUKY2hlY2sgdGhhdCB3
cmFwcyBhbmQgaXMgZml4ZWQgaW4gcGF0Y2ggMyBvZiB0aGlzIHNlcmllcy4KCkZpeGVzOiA4NzAw
ZTNlN2M0ODUgKCJTb2Z0IFJvQ0UgZHJpdmVyIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcg
IyB2NC44KwpSZXBvcnRlZC1ieTogVHltYmFyazczNzIgPHR5bWJhcms3MzcyQHByb3Rvbi5tZT4K
U2lnbmVkLW9mZi1ieTogVHltYmFyazczNzIgPHR5bWJhcms3MzcyQHByb3Rvbi5tZT4KQXNzaXN0
ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy00LTcKLS0tCiBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9tci5jIHwgMTIgKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jCi0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMKKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfbXIuYwpAQCAtMzAsMTMgKzMwLDE5IEBAIGludCBtcl9jaGVja19yYW5n
ZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHNpemVfdCBsZW5ndGgpCiAJCXJldHVybiAw
OwoKIAljYXNlIElCX01SX1RZUEVfVVNFUjoKLQljYXNlIElCX01SX1RZUEVfTUVNX1JFRzoKLQkJ
aWYgKGlvdmEgPCBtci0+aWJtci5pb3ZhIHx8Ci0JCSAgICBpb3ZhICsgbGVuZ3RoID4gbXItPmli
bXIuaW92YSArIG1yLT5pYm1yLmxlbmd0aCkgeworCWNhc2UgSUJfTVJfVFlQRV9NRU1fUkVHOiB7
CisJCXU2NCBpb3ZhX2VuZCwgbXJfZW5kOworCisJCWlmIChjaGVja19hZGRfb3ZlcmZsb3coaW92
YSwgbGVuZ3RoLCAmaW92YV9lbmQpIHx8CisJCSAgICBjaGVja19hZGRfb3ZlcmZsb3cobXItPmli
bXIuaW92YSwgbXItPmlibXIubGVuZ3RoLAorCQkJCSAgICAgICAmbXJfZW5kKSB8fAorCQkgICAg
aW92YSA8IG1yLT5pYm1yLmlvdmEgfHwKKwkJICAgIGlvdmFfZW5kID4gbXJfZW5kKSB7CiAJCQly
eGVfZGJnX21yKG1yLCAiaW92YS9sZW5ndGggb3V0IG9mIHJhbmdlXG4iKTsKIAkJCXJldHVybiAt
RUlOVkFMOwogCQl9CiAJCXJldHVybiAwOworCX0KCiAJZGVmYXVsdDoKIAkJcnhlX2RiZ19tciht
ciwgIm1yIHR5cGUgbm90IHN1cHBvcnRlZFxuIik7Ci0tCjIuNDMuMAo=

--b1=_pnutIBOvCqFI97cAdMN8vn1stR9KF4pHnE7stAM60Q--


