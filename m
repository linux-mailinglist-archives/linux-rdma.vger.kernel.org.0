Return-Path: <linux-rdma+bounces-22449-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ds0VHGfuO2o7fggAu9opvQ
	(envelope-from <linux-rdma+bounces-22449-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 16:49:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B96BF4B1
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 16:49:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=itb.spb.ru header.s=mail header.b="P/1r03dX";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22449-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22449-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32790300398B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4E3B6349;
	Wed, 24 Jun 2026 14:49:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E02BDC2F;
	Wed, 24 Jun 2026 14:49:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312547; cv=none; b=k87faDKIfKRfei+sOkQbNmNDocICheAeOpTCHXfWYaIDUNnCm9NrtbzdA4jLu01I5e5EL0i3i/6/lOtNbYQj94BUm8Jd2XXwFQno92I4fh9368qKhl+1frdKSN8GAXzo2dkrBDfbZ4BO/Do6+th1P6Tbs3OyxdkR114EeeTueRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312547; c=relaxed/simple;
	bh=i00klzCP9CwLXMYKZNmuASfnbmTqXSmjU6VkBZEQ2LE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XXg3GxZ9VsZyb6H93A1An2w7WuEPe805xkrkxR5yCLxsqQRg96H8EmVbV2D7RUA7PIZvwNu6Q3u47e3YX7X70D19olwbA4A+yy2d/U/msSpUZqEUnRzc+JHjPN0kNUtgLq+jTLNGvfoLbM5BlwueDKc0BT9CR4bsaB7CkuNIZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=P/1r03dX; arc=none smtp.client-ip=178.154.239.211
Received: from mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:ea2:0:640:ef77:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 0D388C0101;
	Wed, 24 Jun 2026 17:48:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (smtp) with ESMTPSA id kmZg0cNgGGk0-HRq8mJA1;
	Wed, 24 Jun 2026 17:48:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1782312531; bh=Gz3lOv/CI79YjE1aN0wfylGlI3Iny8zFySyBDdhs1Tw=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=P/1r03dXoV5pEzF7MbonCIfV35Odh6IwmwDb0HcRgqDx5T6JGUQoo0NG01DpqmHz7
	 b6k5qOzAYpuf/Cba9OYTReLtsCeQGO96/8p9ufBXglknhXNDk9RuhCS6/E6GRIE8Ge
	 cfArRzqBQyH489aNaXwGAwjP1YILJH0NsQkLeSws=
From: Aleksandrova Alyona <aga@itb.spb.ru>
To: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] RDMA/irdma: Prevent overflows in memory contiguity checks
Date: Wed, 24 Jun 2026 17:48:46 +0300
Message-Id: <20260624144846.61242-1-aga@itb.spb.ru>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[itb.spb.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22449-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzysztof.czurylo@intel.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:mustafa.ismail@intel.com,m:shiraz.saleem@intel.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aga@itb.spb.ru,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[itb.spb.ru];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[itb.spb.ru:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[aga@itb.spb.ru,linux-rdma@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA9B96BF4B1

irdma_check_mem_contiguous() and irdma_check_mr_contiguous() verify that
PBL entries describe physically contiguous memory ranges.

Both functions calculate byte offsets using 32-bit operands. For example,
with 4 KiB pages, pg_size * pg_idx overflows 32-bit arithmetic when
pg_idx reaches 1048576. In the level-2 check, PBLE_PER_PAGE is 512, so
i * pg_size * PBLE_PER_PAGE overflows when i reaches 2048.

These values are reachable in the driver. For MRs, palloc->total_cnt
comes from iwmr->page_cnt, which is calculated by
ib_umem_num_dma_blocks(). The MR size is limited by IRDMA_MAX_MR_SIZE,
so a 4 GiB MR with 4 KiB pages can reach page_cnt of 1048576. PBLE
resources do not exclude this value either: for gen3, the limit is based
on avail_sds * MAX_PBLE_PER_SD, and MAX_PBLE_PER_SD is 0x40000, so 4 SDs
are enough for 1048576 PBLEs.

Cast one operand to u64 before the multiplications so that the offset
calculations are performed in 64-bit arithmetic.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Aleksandrova Alyona <aga@itb.spb.ru>
---
 drivers/infiniband/hw/irdma/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 17086048d2d7..ab55f674cb63 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2819,7 +2819,7 @@ static bool irdma_check_mem_contiguous(u64 *arr, u32 npages, u32 pg_size)
 	u32 pg_idx;
 
 	for (pg_idx = 0; pg_idx < npages; pg_idx++) {
-		if ((*arr + (pg_size * pg_idx)) != arr[pg_idx])
+		if ((*arr + ((u64)pg_size * pg_idx)) != arr[pg_idx])
 			return false;
 	}
 
@@ -2852,7 +2852,7 @@ static bool irdma_check_mr_contiguous(struct irdma_pble_alloc *palloc,
 
 	for (i = 0; i < lvl2->leaf_cnt; i++, leaf++) {
 		arr = leaf->addr;
-		if ((*start_addr + (i * pg_size * PBLE_PER_PAGE)) != *arr)
+		if ((*start_addr + ((u64)i * pg_size * PBLE_PER_PAGE)) != *arr)
 			return false;
 		ret = irdma_check_mem_contiguous(arr, leaf->cnt, pg_size);
 		if (!ret)
-- 
2.26.2


