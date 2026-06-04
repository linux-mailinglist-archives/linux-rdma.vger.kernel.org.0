Return-Path: <linux-rdma+bounces-21739-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7egeAbw+IWplBwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21739-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 11:00:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA663E441
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 11:00:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=FutPsjt6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21739-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21739-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 350AB318BC98
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7190A3D5254;
	Thu,  4 Jun 2026 08:46:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2873AFAE6
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 08:46:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562811; cv=none; b=i0Lhzes7My/NwYTmcDeoJ+hCdZhdFy8ItsZRTqTNh7M1sSsn6VdfuwIUoCkEWV7MXRGFdIelV1k7pICgK6ss9QAqOGqZMtg1ntpnzQaU/zo9ufU3Uj+eVKy6jJ64jxhD3SmEuq0O8xfQsAa/dDTkK00FP0bgg/BMCkvWZL5diVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562811; c=relaxed/simple;
	bh=LkTVa6Mrd5wcDW88pb6hCQTL1717kz7S2mTiZEgeiSg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1S1DIVWxwAjYSAaajjeeoXgMwFKKtJRQ+I+pk63VFe19KAUaZLua2Ip1EDysBP5nk7ZKU8XcPge0YSS2VgNLRMKEZ2FiOrHncQ0QcDNMqVhXKs5It+PgNb2+LTdnOVPs260GJ7QzGrQh8HonXDe/Pz6my/lcIHc41aDN/T9S58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FutPsjt6; arc=none smtp.client-ip=79.135.106.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780562801; x=1780822001;
	bh=dI9hVL01c71ih5HvIFpqlh4uVw1MCRSvG/NKiWvcWLQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FutPsjt6ixwu6+7P7T7PGrHGeO39WDWshmwGRwgTwRbsLMmKPbrHYmFG4mOCLQvsL
	 Sjj3+ESf+ngf1Tt1Q46V5uw/8qmc775mEU/AyTgh0pjEIcjlZ5/B98oFzwKtVydQV2
	 JXWA9SgYjV8x+WS7dyN4+WYLNhPYCR1a2ZrTfzWwYBu3OeOEb0DcK/WWraoowefi0l
	 R8I0AD1l7dMY/cRVuzDuZmUU519gfQnFXvHrnyjMUELrcI7zB8X1/cO6JJ1NRfiY83
	 nRB7FntcL2ztrHGTRyo/tSn8BQUYF4kJKQufyl5b+W/Qcn5Lg0j6K5NL5LiXs9Fxtm
	 QYjP6OEXPf0fw==
Date: Thu, 04 Jun 2026 08:46:33 +0000
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] nvmet-rdma: reject inline data with a nonzero offset
Message-ID: <20260604084624.120032-1-hexlabsecurity@proton.me>
In-Reply-To: <ahm6Ksr3rfGdnOsN@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me> <ahm6Ksr3rfGdnOsN@kbusch-mbp>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 30d429d49ffc879a29fff9a077634f43f6f5c5dc
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
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21739-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:mid,proton.me:dkim,proton.me:from_mime,proton.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61BA663E441

nvmet_rdma_map_sgl_inline() takes a host-controlled offset and length
from the inline SGL descriptor and bounds-checks them against the
per-port inline_data_size:

=09u64 off =3D le64_to_cpu(sgl->addr);
=09u32 len =3D le32_to_cpu(sgl->length);
=09...
=09if (off + len > rsp->queue->dev->inline_data_size)
=09=09return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;

This is unsound whenever the offset is nonzero:

 - "off + len" is evaluated in u64 and wraps modulo 2^64.  A descriptor
   with addr =3D 0xfffffffffffffe00 and length =3D 0x1000 wraps the sum to
   0xe00 and passes the check.  nvmet_rdma_use_inline_sg() then stores
   the offset into scatterlist::offset (unsigned int) and the block
   layer reads out of bounds of the inline page; a large len also makes
   num_pages(len) exceed NVMET_RDMA_MAX_INLINE_SGE and overruns the
   fixed-size inline_sg[] array.

 - Even computed without wrapping, inline_data_size is configurable up
   to max(SZ_16K, PAGE_SIZE).  An offset in (PAGE_SIZE, inline_data_size]
   passes the bound and then "PAGE_SIZE - off" in
   nvmet_rdma_use_inline_sg() underflows, leaving scatterlist::length at
   ~4 GiB and the offset pointing past the first inline page.

A nonzero inline offset is never legitimate here.  nvmet advertises
icdoff =3D 0, nvme_rdma_setup_ctrl() refuses to use a controller that
reports a nonzero icdoff ("icdoff is not supported!"), and
nvme_rdma_map_sg_inline() sets the inline descriptor addr to icdoff, so
a compliant initiator always sends offset 0.  nvmet_rdma_use_inline_sg()
likewise assumes the inline data begins at the start of the first inline
page (the RNIC DMAs it to page offset 0); any nonzero offset also
mis-describes the scatterlist even when it is in bounds.

Reject a nonzero offset directly.  This closes the u64 overflow, the
inline_sg[] overrun and the PAGE_SIZE - off underflow together, and is
simpler than bounding the offset.

Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data"=
)
Cc: stable@vger.kernel.org
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Keith, thanks for the suggested form

=09if (off > rsp->queue->dev->inline_data_size ||
=09    len > rsp->queue->dev->inline_data_size - off)

It does stop the u64 overflow, but while testing it I found it is still
incomplete when a port is configured with inline_data_size > PAGE_SIZE
(it is settable up to max(SZ_16K, PAGE_SIZE)): an offset in
(PAGE_SIZE, inline_data_size] passes that bound and then "PAGE_SIZE - off"
in nvmet_rdma_use_inline_sg() underflows, leaving scatterlist::length at
~4 GiB pointing past the first inline page. The block backend then
executes the out-of-bounds read (KASAN trace below). Since a compliant
initiator never sends a nonzero inline offset (nvmet advertises
icdoff =3D 0 and nvme_rdma_setup_ctrl() refuses a nonzero icdoff),
rejecting off !=3D 0 closes that case too and is even simpler, so this
formal patch uses that instead of bounding the offset.

Verified on a KASAN build (inline_data_size =3D 16384) over an rdma_rxe
soft-RoCE loopback nvmet-rdma target with a block backend:
  - offset 0, 4 KiB inline write: succeeds, clean (control).
  - offset 8192, len 4096: without this patch the bounds check passes
    and the block backend executes the out-of-bounds read
      BUG: KASAN: slab-out-of-bounds in copy_folio_from_iter_atomic
      Read of size 4096 ...
    with this patch it is rejected ("invalid inline data offset!").
  - offset 4095 (< PAGE_SIZE): without this patch it is in bounds but
    mis-describes the SGL (NVME_SC_SGL_INVALID_DATA, no OOB); with this
    patch it is rejected up front.
  - offset 0 keeps working (no regression for compliant initiators).

 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -854,7 +854,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_=
rsp *rsp)
 =09=09return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 =09}

-=09if (off + len > rsp->queue->dev->inline_data_size) {
+=09if (off || len > rsp->queue->dev->inline_data_size) {
 =09=09pr_err("invalid inline data offset!\n");
 =09=09return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 =09}
--
2.43.0


