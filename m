Return-Path: <linux-rdma+bounces-16758-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCK2H+18jGkcpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16758-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6891249B0
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC9B030185B4
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6336BCD7;
	Wed, 11 Feb 2026 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M0171kWH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059B36B040
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814696; cv=none; b=IZCJlDB7+75QBGmfTIED+6jk/DOJgU2eA0vTqoNLcdf4h/WS84napFWqzculgklu9iinBAXayrgIamH1fbqML6rjpA8/1qCG6l/vrzG8uM2UjJIXYiIOSUNwJRw9AlYn2C3q9aK2av9liyV9KTQ9BB+JI0XjTHS+dIT6kdDYi4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814696; c=relaxed/simple;
	bh=1I8BNIe19OgXhF5jA5cD7X+wVx+NvkAnYnk4fpBghT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXfcxAS84XDOmbHRvpSRACtMRIR+wObEbofudrtkFtZZaiXatQkrcRkI+5iarwm8+lljjVTGStAiQYfDgq8SvmwvXAY0GZo6zlN7UPdzx49pgMLMrf34UXy8CpMUgwQ6JswBW58MlHtKJl32dfIV/UwJKBSmMUJWCAUa/f852UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M0171kWH; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5fdf6ad2517so5777137.2
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814693; x=1771419493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCf4FtfvGypVXjYUwiJfc/VfrttB5iL2hkBxnBP/X/A=;
        b=UysvAj9YBBsi6qM8VazuN4bL0hchUwFKUWV4LMto35oladOYWwaWrnjedX7gXLapRu
         kKZuWfvZE96F2f8Hbi+PVlljvdsEBCYEK/GbgrAG5UHdN6FOMnWX+QqV84uySIQ6OQN9
         T6WfvpakAcOL1vuYJTw/SzEK5EOP3126fc0fkHXEGtl0a21sFWku3XxcP0v811M6sdLN
         1Uw28PEmNFf0amcovCg1MVlGkTirb7cdsKJ59L55Sw+2Ej7cAr2fNOobJGsUvjLBiBR3
         3ffgK9Wrp2MAXT6mJnN8Fcei+uLga2gA86SYwfaqVQs6WOkyCR82dunN+DLYwN0fvcBP
         IOXg==
X-Gm-Message-State: AOJu0Yw1mDxc1uJQdDPdcCsw/5eZc47MDKmJ0IJ0ppVgVXdU4rLi+nsI
	Knj7Dh/J3so823oycQ0m0j5CjgD57t8565BLKO896mAJj7NNBTVZ4HNFjDPOsLfdoOjnn12tZHk
	C9SBA0VYJ+cZ6x86EWY73BVUlxyoX38nHaFDW8oLSjKhCFLS0L0J6ykLOGieWctfs0hp46kkWN4
	AGQ8aqaJYi04yRenDu0MjDecHZpGq3qyGLq+c2wOcQMbyldIkk2FS1NssO/cPYsHwmLEg9yiWQZ
	ide/W9UBv2ddJ/g0xUEcqrc3QBi
X-Gm-Gg: AZuq6aJJxN3Dnv5hT338SS23/TqArj311PYr7rePlavx/QiwOpURI52bpeLOWjeW/XH
	07RsN2avCiVXur/dXbcXE972jkU3y3Bk2juJia9Q5flZpNAlEgUC2ir8aodn2fBq5FQ60cBBu0W
	JcsL+3lrK7ll0+WkvpdVAYA+Bnh93ufWwm1qAF78lBvnv1PSzp0M6Iklk7tpg3tQsMMvfB/yJrm
	gCs6obY5eezrNJi+36+cmRrq/DtNnuboZeenrDsMljwcvGTm6aSOpdFjSENwPGq3a15vYlw2rdl
	B+4NdaWMcrAG6Tz4vBPEURW1XUOX7whu1TbA9dSM/Xh7Bkb2dFKbukrXXhdmE8jYb8F/PuIpNdg
	yudT1F6d0ehaSFor7dv1Gx7GMWvxGeo/hM431/6YRvsV3tCXKh5/HsTFBVPZWmzwpdDSUVpwBuH
	7WupyToyCNrierxAwVt5K5rv2RIA9PSB05n2nCnUBwr88yNImZVvmSrduuGMhYPKH+rUiB84A=
X-Received: by 2002:a05:6102:38c7:b0:5ee:9f7e:b3c7 with SMTP id ada2fe7eead31-5fde417a8b7mr703054137.13.1770814693553;
        Wed, 11 Feb 2026 04:58:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94afd148e44sm194796241.2.2026.02.11.04.58.12
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:58:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so37033945ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770814692; x=1771419492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCf4FtfvGypVXjYUwiJfc/VfrttB5iL2hkBxnBP/X/A=;
        b=M0171kWH/+6CYr6A+DyYWXc32Udod9m+h2yHeuTKpyCfUQpK7ujql0Qo1ofmGlxFa7
         oNrDKPePcFkjcpaDWgS4NJ/R55u3GwNXp5lUN3l5NyKeLwn4hXpOKoNnHSY9f8rD53+d
         46QvQN7BIB6bqMR0tJyj8tTABsULPsuM4+/lY=
X-Received: by 2002:a17:903:2342:b0:2aa:f5b4:9a28 with SMTP id d9443c01a7336-2ab27f37322mr25663055ad.42.1770814691761;
        Wed, 11 Feb 2026 04:58:11 -0800 (PST)
X-Received: by 2002:a17:903:2342:b0:2aa:f5b4:9a28 with SMTP id d9443c01a7336-2ab27f37322mr25662875ad.42.1770814691428;
        Wed, 11 Feb 2026 04:58:11 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab299983d0sm22206515ad.79.2026.02.11.04.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:58:10 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v12 4/6] RDMA/bnxt_re: Refactor bnxt_re_create_cq()
Date: Wed, 11 Feb 2026 18:19:25 +0530
Message-ID: <20260211124927.57617-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16758-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB6891249B0
X-Rspamd-Action: no action

Some applications may allocate dmabuf based memory for CQs. To support
this, update the existing code to use SZ_4K to specify supported HW
page size for CQs, as we support only 4K pages for now.
Call ib_umem_find_best_pgsz() to ensure umem supports this requested
page size. A helper function includes these changes.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 29 +++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index feb364e45e14..9fa89f330c5a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3348,6 +3348,26 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	return 0;
 }
 
+static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
+				struct ib_umem *umem,
+				struct bnxt_qplib_sg_info *sginfo)
+{
+	unsigned long page_size;
+
+	if (!umem)
+		return -EINVAL;
+
+	page_size = ib_umem_find_best_pgsz(umem, SZ_4K, 0);
+	if (!page_size || page_size != SZ_4K)
+		return -EINVAL;
+
+	sginfo->umem = umem;
+	sginfo->npages = ib_umem_num_dma_blocks(umem, page_size);
+	sginfo->pgsize = page_size;
+	sginfo->pgshft = __builtin_ctz(page_size);
+	return 0;
+}
+
 int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs)
 {
@@ -3379,8 +3399,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
-	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
 
@@ -3395,7 +3413,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			rc = PTR_ERR(cq->umem);
 			goto fail;
 		}
-		cq->qplib_cq.sg_info.umem = cq->umem;
+		rc = bnxt_re_setup_sginfo(rdev, cq->umem, &cq->qplib_cq.sg_info);
+		if (rc)
+			goto fail;
+
 		cq->qplib_cq.dpi = &uctx->dpi;
 	} else {
 		cq->max_cql = min_t(u32, entries, MAX_CQL_PER_POLL);
@@ -3406,6 +3427,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			goto fail;
 		}
 
+		cq->qplib_cq.sg_info.pgsize = SZ_4K;
+		cq->qplib_cq.sg_info.pgshft = __builtin_ctz(SZ_4K);
 		cq->qplib_cq.dpi = &rdev->dpi_privileged;
 	}
 	cq->qplib_cq.max_wqe = entries;
-- 
2.51.2.636.ga99f379adf


