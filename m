Return-Path: <linux-rdma+bounces-21804-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V30VC2TVIWqbPQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21804-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:43:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91827642FDC
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:43:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=pidt2ukzyrggdauwg4b2q6m3ty.protonmail header.b=gO6rlClG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21804-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21804-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E0F4306DACF
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532A3BD22E;
	Thu,  4 Jun 2026 19:37:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7C3B9927
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 19:37:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601837; cv=none; b=N2m/W5bEJkQhJqgewlsYDJm2a3OwlXXNFEyMZSp7kxvJyHmnTf32HTemFqGJC2LJsOrAApxknUQyGowHFmjY9OmSxTCWaqXT+q/xCYLj9ouPq4glGJnYR83agkeL6Hn1hCfOu3XndCoOjxpDgEsQ6PrP0ukDdbIyqZ48jzR8qKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601837; c=relaxed/simple;
	bh=oS7NxEacAgL0HYtv5WvCgJkETMPNe0vdRBVK6cP564w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUvMvvzMPVwdufYM+Brh5tbAa+O7Np7j9DwlaCyplq1GMghCCR61KSJ3HEL+Jp9Wie9rXrikOxGyySUG/z4jnKeFsQRxUk0LQdmZs7ouzBreYO4xCrELw/EZ4nV1gYGwqjXiRp6lfN7QY5mt2OrvCD6jF2uJsdzoj+fYLn1+eOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gO6rlClG; arc=none smtp.client-ip=79.135.106.118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=pidt2ukzyrggdauwg4b2q6m3ty.protonmail; t=1780601819; x=1780861019;
	bh=ujDKy6SWWWi8FQFzqh264wUeyQqzjQjB5x1dbv93N9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gO6rlClGX2rUj1P/zjADI2XSlrzTs/Z8DIcwM6+vGcKbbPTHF944ed7AHU/svnDAB
	 lKZdpDbDXFiErt27KaRWARK7g37jnGakUYP7SKuatzc9d0/q6F5fX9mbTOgUVyJJTg
	 gtxameNyvkRyftqodHv98Tg6ahoZgSu03F8XjQC3OIXEo4EwWSDA2l04HKKxrhNl5n
	 6STdQgx4i9RvHBTJ1vZCaZmMX95BR9wgLKc8OichtUO1J0CntObHzHt44mnZdWi0DD
	 76zOssE3t82y4aGjHPGsrN+xhu4EGdGtlYd4O81cIQ26+01LiJeay2tg0pnjRJdfII
	 G5BSGnLCnUQdw==
Date: Thu, 04 Jun 2026 19:36:54 +0000
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v2] nvmet-rdma: handle inline data with a nonzero offset
Message-ID: <20260604193645.178350-1-hexlabsecurity@proton.me>
In-Reply-To: <aiFR81yE9_BIsNbM@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me> <ahm6Ksr3rfGdnOsN@kbusch-mbp> <20260604084624.120032-1-hexlabsecurity@proton.me> <aiFR81yE9_BIsNbM@kbusch-mbp>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: e669ea10f8438003e78f5e4cf1408c764e65c494
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=pidt2ukzyrggdauwg4b2q6m3ty.protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21804-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:sagi@grimberg.me,m:kbusch@kernel.org,m:kch@nvidia.com,m:linux-nvme@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:mid,proton.me:dkim,proton.me:from_mime,proton.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91827642FDC

nvmet_rdma_use_inline_sg() maps the host-controlled inline data offset
into the per-command inline scatterlist.  The bounds check admits any
offset with off + len <=3D inline_data_size, but the mapping still assumes
the data begins in the first inline page:

=09sg->offset =3D off;
=09sg->length =3D min_t(int, len, PAGE_SIZE - off);

When a port is configured with inline_data_size > PAGE_SIZE (settable up
to max(SZ_16K, PAGE_SIZE)), an offset in (PAGE_SIZE, inline_data_size]
makes "PAGE_SIZE - off" underflow, so sg->length is set to ~4 GiB and
the block backend reads far past the first inline page.  num_pages(len)
also ignores the offset, so an in-bounds offset whose [off, off+len)
span crosses a page boundary under-counts the scatterlist.

Map the offset properly: split it into a page index and an in-page
offset, start the scatterlist at that page, and size the page count from
page_off + len.  Because the request scatterlist may now start at
inline_sg[page_idx] rather than inline_sg[0], generalize the inline-SGL
identity test in nvmet_rdma_release_rsp() to a range test; otherwise the
persistent inline scatterlist is mistaken for an allocated one and
nvmet_req_free_sgls() frees an inline page (and warns in
free_large_kmalloc()).

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data"=
)
Cc: stable@vger.kernel.org
Suggested-by: Keith Busch <kbusch@kernel.org>
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v1 rejected a nonzero offset; per Keith's note a nonzero in-capsule SGL
offset is legitimate (it is the per-command SGL Offset field, distinct
from the controller ICDOFF attribute that nvme_rdma_setup_ctrl() refuses
when nonzero), so v2 handles it instead, using Keith's suggested
page_idx/page_off form for nvmet_rdma_use_inline_sg().

Review context (not for the commit log):

Bound safety: with off + len <=3D inline_data_size the highest inline_sg[]
index touched is page_idx + sg_count - 1 =3D floor((off + len - 1) /
PAGE_SIZE) <=3D num_pages(inline_data_size) - 1 =3D inline_page_count - 1
(<=3D NVMET_RDMA_MAX_INLINE_SGE - 1), and page_off < PAGE_SIZE so
PAGE_SIZE - page_off cannot underflow.  The release_rsp range test is a
strict generalization of the old "!=3D inline_sg" test: inline_sg[0] is in
range (unchanged: not freed), allocated/keyed SGLs are outside it (still
freed), and only the new inline_sg[1..] starts are additionally treated
as inline.

Decides identically on 32- and 64-bit builds: off is u64, so the offset
arithmetic and PAGE_SIZE - page_off are evaluated in 64-bit on both ABIs;
num_pages() sees page_off + len <=3D 16384 (positive, int-safe on both);
the release_rsp comparison is a pointer comparison, identical semantics
on ILP32 and LP64.  (-m32/-m64 model output identical.)

A/B on a KASAN build (inline_data_size =3D 16384) over an rdma_rxe
loopback nvmet-rdma target with a block backend, inline write:
  - offset 0: succeeds, clean (control + no regression).
  - offset 8192: before this patch the block backend reads out of bounds
      BUG: KASAN: slab-out-of-bounds in copy_folio_from_iter_atomic
      (sg->length =3D 0xfffff000); with this patch it is served from the
      correct inline page, in bounds, no KASAN and no free_large_kmalloc
      warning.
  - the use_inline_sg() rework alone (without the release_rsp change)
      trips on offset 8192:
      WARNING: ... free_large_kmalloc ... Not a kmalloc allocation
        nvmet_req_free_sgls <- nvmet_rdma_release_rsp <- nvmet_rdma_send_do=
ne

 drivers/nvme/target/rdma.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 565183a20007..eb975fbd74a1 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -666,7 +666,8 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rs=
p *rsp)
 =09if (rsp->n_rdma)
 =09=09nvmet_rdma_rw_ctx_destroy(rsp);

-=09if (rsp->req.sg !=3D rsp->cmd->inline_sg)
+=09if (rsp->req.sg < rsp->cmd->inline_sg ||
+=09    rsp->req.sg >=3D rsp->cmd->inline_sg + queue->dev->inline_page_coun=
t)
 =09=09nvmet_req_free_sgls(&rsp->req);

 =09if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
@@ -821,24 +822,25 @@ static void nvmet_rdma_write_data_done(struct ib_cq *=
cq, struct ib_wc *wc)
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
 =09=09u64 off)
 {
-=09int sg_count =3D num_pages(len);
+=09u64 page_off =3D off % PAGE_SIZE;
+=09u64 page_idx =3D off / PAGE_SIZE;
+=09int sg_count =3D num_pages(page_off + len);
 =09struct scatterlist *sg;
 =09int i;

-=09sg =3D rsp->cmd->inline_sg;
+=09sg =3D &rsp->cmd->inline_sg[page_idx];
 =09for (i =3D 0; i < sg_count; i++, sg++) {
 =09=09if (i < sg_count - 1)
 =09=09=09sg_unmark_end(sg);
 =09=09else
 =09=09=09sg_mark_end(sg);
-=09=09sg->offset =3D off;
-=09=09sg->length =3D min_t(int, len, PAGE_SIZE - off);
+=09=09sg->offset =3D page_off;
+=09=09sg->length =3D min_t(u64, len, PAGE_SIZE - page_off);
 =09=09len -=3D sg->length;
-=09=09if (!i)
-=09=09=09off =3D 0;
+=09=09page_off =3D 0;
 =09}

-=09rsp->req.sg =3D rsp->cmd->inline_sg;
+=09rsp->req.sg =3D &rsp->cmd->inline_sg[page_idx];
 =09rsp->req.sg_cnt =3D sg_count;
 }

--
2.43.0


