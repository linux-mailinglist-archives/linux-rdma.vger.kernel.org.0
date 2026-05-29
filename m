Return-Path: <linux-rdma+bounces-21518-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBd2JMetGWpyyQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21518-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 17:16:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF86F6046F5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC0143167BC4
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5B34040D;
	Fri, 29 May 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ljXfoEAI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F18401495
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066966; cv=none; b=hlozXXzmDdqzwwxfa3SMDHQzMnDI7hC22+uL5uMfViNoW7LoAEJ2oI2xncgfR95DtqG/bYcf08M9J57Vraq/0LYr2q3HEnNSboVXIZdbvRvKBtBEMIE+B9Lb68zp7WsRTOIw0s9m7lIUbVSJRHd9Uv04Qx90xg4bS3beXWJ+qks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066966; c=relaxed/simple;
	bh=EMPtP9btgWlTLlI58OWh0bxipBCl6lhHJOHJiOaYjaU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cs0dNP06n1Fc85WRLxkVSNhWdDfu9vG1y8ziITdzk5mTrME8ZR0GK1YMjOg6w7lgOGSzAFhR/ZMnkzzom1Wa6+lwdwKXRJ8sUjx8URSwUAF7CD0PcTmcK6TFXvZNbM+hpRQwdT7MFKa1mNkVAkc+FI47BdVHrUmpM/YHtuOcX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ljXfoEAI; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780066958; x=1780326158;
	bh=BQvNer+ofG/FReA2INIhPudwMOlb+NHoKchhtRUrawk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ljXfoEAIqCLKO0BatgjjwGL5lLj2zETEiu4g+0Q03i9SGEEl+iVZNDNjI0w/9XHLW
	 VO4N4oyBZQZvRtE4UO3MqLyflqzBRNwHgZRFeGsaN8RPcnXWv2lAsVRYTbv2KEYeUn
	 kKagDZ0EApSnLr4sHV21gwy0osqVfKpRC8rTX+BOE/hAquNp9qyAJbmWVfY+g75bHL
	 nrQ5EwqKT+nNezdEivsDR6fvuP73omDQwuFKa8qASDI5Zz29fsxEzR1HKLa6M5RMOD
	 DrT+4f68LIbLJ7sf/sfNC7LtUGAb2yw9FlErw/3i8fxlrvlKIQ1D75TnfYGyXqQHQc
	 BSgVA2MxZFKPQ==
Date: Fri, 29 May 2026 06:52:13 +0000
To: "security@kernel.org" <security@kernel.org>
From: hexlabsecurity@proton.me
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, "kch@nvidia.com" <kch@nvidia.com>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [REPORT] nvmet-rdma: integer overflow in inline-data SGL bounds check -> pre-auth kernel-memory read + remote crash (candidate patch inline)
Message-ID: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 8f4d61be0a109faf1f15bde7791fe49436b287f1
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
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	TAGGED_FROM(0.00)[bounces-21518-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: EF86F6046F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I would like to report an integer-overflow vulnerability in the NVMe-oF
RDMA target (drivers/nvme/target/rdma.c).  The inline-data SGL bounds
check in nvmet_rdma_map_sgl_inline() is computed in u64 over two
host-controlled values and wraps, which a remote fabric peer can use
both to read kernel memory back over the fabric and to crash the target.

=3D=3D Affected =3D=3D

  drivers/nvme/target/rdma.c, nvmet_rdma_map_sgl_inline()

  Verified present on the current mainline tree (commit 27fa82620cba,
  ~v7.1-rc5), at the bounds check:

    static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
    {
        struct nvme_sgl_desc *sgl =3D &rsp->req.cmd->common.dptr.sgl;
        u64 off =3D le64_to_cpu(sgl->addr);     /* host-controlled, 64-bit =
*/
        u32 len =3D le32_to_cpu(sgl->length);   /* host-controlled, 32-bit =
*/
        ...
        if (off + len > rsp->queue->dev->inline_data_size) {   /* u64 wrap =
*/
            pr_err("invalid inline data offset!\n");
            return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
        }
        ...
        nvmet_rdma_use_inline_sg(rsp, len, off);
    }

  "off + len" is evaluated in u64 and wraps modulo 2^64.  For example
  addr =3D 0xfffffffffffffe00, length =3D 0x1000 makes the sum wrap to
  0xe00, which is <=3D inline_data_size (default PAGE_SIZE), so the check
  passes.  The current check form (against the per-port inline_data_size)
  and the fixed-size inline_sg[NVMET_RDMA_MAX_INLINE_SGE] array with the
  num_pages(len) loop were introduced together by commit 0d5ee2b2ab4f
  ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data"), which is the
  Fixes: I used.  Note: the single-page inline path that predates that
  commit may have an analogous u64-overflow read in a different code
  shape; I would appreciate the maintainers' judgement on whether the
  stable backport scope should reach before that commit.

=3D=3D Two consequences of the bypass =3D=3D

  1. Kernel-memory read (information disclosure).
     nvmet_rdma_use_inline_sg() does "sg->offset =3D off", truncating the
     64-bit offset to scatterlist::offset (unsigned int).  The block
     layer then accesses page_to_phys(inline_page) + (off & 0xffffffff),
     so the target reads up to inline_data_size bytes of kernel memory
     per write command and returns them to the host on read-back, or
     faults the in-kernel copy if the offset lands on unmapped memory.

  2. Kernel-memory corruption -> remote crash (denial of service).
     A large length makes "sg_count =3D num_pages(len)" in
     nvmet_rdma_use_inline_sg() exceed NVMET_RDMA_MAX_INLINE_SGE (4), so
     the loop writes scatterlist entries past the fixed-size inline_sg[]
     array, corrupting the surrounding command object.

=3D=3D Reachability =3D=3D

  The path is reached by any write command carrying an inline SGL, i.e.
  after a Fabrics Connect.  On a subsystem configured with
  attr_allow_any_host=3D1 it is reachable WITHOUT authentication by any
  RDMA peer (RoCE/iWARP/IB) that can reach the target's listener.  With
  DH-CHAP configured, or attr_allow_any_host=3D0 with an unknown host NQN,
  a valid/known host NQN is required first.

=3D=3D Empirical reproduction =3D=3D

  Reproduced against a stock nvmet-rdma target over a soft-iWARP (siw)
  fabric on a Linux 6.12.90 build with KASAN (KASAN_INLINE):

  - Read: a single write command with addr =3D 0xfffffffffffffe00,
    length =3D 0x1000 produced a KASAN out-of-bounds read and returned
    ~4 KiB of kernel memory (including kernel .text) into the
    attacker-readable namespace.

  - Crash: a write command with addr =3D 0xffffffffffff0500,
    length =3D 0x10000 (sum wraps to 0x500 <=3D inline_data_size, but
    num_pages(0x10000) =3D 16 writes 16 scatterlist entries into the
    4-entry inline_sg[], 12 past its end) deterministically corrupted
    the command object and oopsed the target:

      Oops: general protection fault [...] KASAN: null-ptr-deref
      RIP: nvmet_rdma_post_recv+0x... [nvmet_rdma]
        nvmet_rdma_post_recv <- nvmet_rdma_queue_response
        <- __nvmet_req_complete <- nvmet_check_transfer_len
        <- nvmet_rdma_handle_command <- ib_cq_poll_work

    Every reconnect re-triggers it (persistent remote DoS).  The
    nvmet_rdma_cmd objects are carved from one contiguous kcalloc'd
    array, so the over-long entry write stays within that allocation and
    KASAN flags the downstream dereference of the corrupted command in
    nvmet_rdma_post_recv rather than the store itself.  The out-of-bounds
    content is not attacker-controlled, so this is a crash/corruption
    primitive, not a controlled write; I do not see a path to remote code
    execution from this bug.

  Severity estimate.  The two consequences arise from different inline-SGL
  capsules (small vs large length) and are scored as separate single-capsul=
e
  outcomes, not one combined vector:

    OOB read  (info-disclosure):  CVSS 7.5 HIGH
        CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N
    OOB write (corruption/DoS):   CVSS 8.2 HIGH
        CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:L/A:H

  Headline 8.2 HIGH (both reachable pre-auth with attr_allow_any_host=3D1).
  With attr_allow_any_host=3D0 a valid host NQN is required first (PR:L),
  lowering these to 6.5 and 7.1.

=3D=3D Suggested fix =3D=3D

  Validate the offset with check_add_overflow() before comparing against
  inline_data_size.  A passing check then guarantees
  off + len <=3D inline_data_size <=3D NVMET_RDMA_MAX_INLINE_DATA_SIZE, whi=
ch
  bounds both the truncated scatterlist::offset and
  num_pages(len) <=3D NVMET_RDMA_MAX_INLINE_SGE, closing the read and the
  inline_sg[] overflow together.  Candidate patch inline below (applies
  to current mainline).

=3D=3D Embargo =3D=3D

  I am happy to follow the standard process.  Proposing a 7-day embargo;
  the fix is small and I can adjust as the maintainers prefer.  I have
  not notified linux-distros and will hold that until a public patch
  lands, per the usual guidance.

I am an independent security researcher; please credit
"Bryam Vargas <hexlabsecurity@proton.me>" (Reported-by already in the
patch).  Affiliation: HEXLAB SAS (registration pending) -- Cali,
Colombia.  Happy to provide the full reproduction harness on request.

Thank you,
Bryam Vargas

----- candidate patch (inline, plain text) -----

From 448c122c744430c1c2926d635855a3894370ee33 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 28 May 2026 21:23:52 -0500
Subject: [PATCH] nvmet-rdma: fix integer overflow in inline data SGL bounds
 check

nvmet_rdma_map_sgl_inline() bounds-checks the inline data descriptor
with both operands host-controlled and the sum evaluated in u64:

=09u64 off =3D le64_to_cpu(sgl->addr);
=09u32 len =3D le32_to_cpu(sgl->length);
=09...
=09if (off + len > rsp->queue->dev->inline_data_size)
=09=09return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;

"off + len" therefore wraps modulo 2^64.  A descriptor with, for
example, addr =3D 0xfffffffffffffe00 and length =3D 0x1000 makes the sum
wrap to 0xe00, which passes the inline_data_size check.  An inline-SGL
write command reaches this path after a Fabrics Connect; on a subsystem
with attr_allow_any_host set it is reachable without authentication by
any peer that can reach the target.

Two distinct out-of-bounds accesses follow from the bypass:

 - nvmet_rdma_use_inline_sg() stores the 64-bit offset into
   scatterlist::offset, which is unsigned int, committing the truncated
   attacker offset to the inline page.  The block layer then accesses
   page_to_phys(inline_page) + (off & 0xffffffff), reading up to
   inline_data_size bytes of kernel memory per command back to the host
   (or faulting the target if the offset lands on unmapped memory).

 - A large len makes sg_count =3D num_pages(len) in
   nvmet_rdma_use_inline_sg() exceed NVMET_RDMA_MAX_INLINE_SGE, so the
   loop writes scatterlist entries past the fixed-size inline_sg[]
   array, corrupting the surrounding command object and oopsing the
   target on the next use of that command.

Validate the offset with check_add_overflow() before comparing against
inline_data_size.  A passing check then guarantees
off + len <=3D inline_data_size <=3D NVMET_RDMA_MAX_INLINE_DATA_SIZE, which
bounds both the truncated scatterlist::offset and
num_pages(len) <=3D NVMET_RDMA_MAX_INLINE_SGE, closing the out-of-bounds
read and the inline_sg[] overflow together.

Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data"=
)
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Review context (not for the commit log):

Reproducer -- unprivileged remote RDMA peer against a target with
attr_allow_any_host=3D1, a single inline-SGL WRITE capsule:
  * OOB read:  sgl->addr=3D0xfffffffffffffe00, sgl->length=3D0x1000
               (off+len wraps to 0xe00 <=3D inline_data_size; sg->offset
               truncates to 0xfffffe00) -> ~4 KiB of kernel memory is
               read back from the namespace.
  * OOB write: sgl->addr=3D0xffffffffffff0500, sgl->length=3D0x10000
               (num_pages(0x10000)=3D16 overruns the 4-entry inline_sg[])
               -> target memory corruption / crash.

A/B-tested on a 6.12.90 KASAN lab kernel (same .config, only this hunk
differs): pre-fix the OOB-read capsule trips "KASAN: use-after-free in
copy_page_from_iter_atomic" via nvmet_file_execute_io; post-fix both
capsules are rejected with "invalid inline data offset!"
(NVME_SC_SGL_INVALID_OFFSET), benign inline writes still succeed, and no
KASAN/oops fires. The fix decides identically in 32- and 64-bit builds
(check_add_overflow operates on u64).

 drivers/nvme/target/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e6e2c3f9afdf..a5bbf9d41c3b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/nvme.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/wait.h>
@@ -847,6 +848,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_=
rsp *rsp)
 =09struct nvme_sgl_desc *sgl =3D &rsp->req.cmd->common.dptr.sgl;
 =09u64 off =3D le64_to_cpu(sgl->addr);
 =09u32 len =3D le32_to_cpu(sgl->length);
+=09u64 bound;

 =09if (!nvme_is_write(rsp->req.cmd)) {
 =09=09rsp->req.error_loc =3D
@@ -854,7 +856,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_=
rsp *rsp)
 =09=09return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 =09}

-=09if (off + len > rsp->queue->dev->inline_data_size) {
+=09if (check_add_overflow(off, (u64)len, &bound) ||
+=09    bound > rsp->queue->dev->inline_data_size) {
 =09=09pr_err("invalid inline data offset!\n");
 =09=09return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 =09}
--=20
2.43.0

