Return-Path: <linux-rdma+bounces-16938-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJqrN5nbk2k89QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16938-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A7148981
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9653011591
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 03:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EE248F64;
	Tue, 17 Feb 2026 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XiE5r4c9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBC1F12E9
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771297679; cv=none; b=B4kTVl2uYY2agZTjXC/E2UN2uUcAQ5eIMXhuutt0+dnuc8xaUD1CZrsF+ee31qE8OKpPLlLJcIXfvgFILI89FcoOOWdWTlKDMnUJMDQmLSOw4DwVhKzg9DaJOjpT4Ph5HOTPyjSwMavV9eazqd2Ngt2vX+igPb2l/1SllO7jJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771297679; c=relaxed/simple;
	bh=1I8BNIe19OgXhF5jA5cD7X+wVx+NvkAnYnk4fpBghT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWk8SJyaXehi0ph8lOCrv2wm67jxtXirE+Re4wqGboZJVNasD7dc096fJ9dhw83TUdSnQn+r98S42uUvtRwHyKtFqikD/k6kiDDRr26F2mFt+Z957NYlHS/MY4vVgO5nETWZ8v/pTYUsCQ9CqjOzHK1uhaAFoiFiFsjBKZxKLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XiE5r4c9; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3562e98d533so2406258a91.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771297678; x=1771902478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCf4FtfvGypVXjYUwiJfc/VfrttB5iL2hkBxnBP/X/A=;
        b=T2boQnoot2H4LIhDrVfXt3Cu2BV94/kcWZQs2EFfKuWNkGuFNDpohzOWP2ZhJOmbN6
         9y1FXeJFSwSAh6sPsiTEP6RaDnfiaBfhFRKMgcUPaJh6w1nlNJ1tpLAdfpXiPG9+Nwwi
         lRr4u1neL2xf+j7124+S7NYk5ZX4xEm8eU6t5XDd6VwPUtqV+bw7jZfl0ohBi+k6MDZK
         i+PqmBqVRw2KAhQKop2IVy1/mkY9aNJ8vLDjk6fW4ALpujVNw/JQYPWNV7MzLvqa6pUr
         7t6/nHnwRnWnEbMIaVs/fzhOE0Hblwnd2250eHdMmTzia6ybxoaBfa7HZCLN06v7G1mw
         VZ9Q==
X-Gm-Message-State: AOJu0YxavcXhm0oFAJ6L6MptEuLkQXzW5U6UJU9vya3B3SNz6LTfZ2/A
	sD9N2DSjj+V31hHhONvLy4aOZvtMHbmTkKeL930Oq4fZpLyxAfv9jrDe6c8sBA5TgxHEMebD+P2
	Ly+EYPQYDT1umYEFKpHWTHSbC0yFPi8sDEyatLl5slRV5YXRbeSEf6pa5u7pJtpXMQQG1Oxs7So
	OhCLeYbD5jQ1pou/HkM8bS/oKZjqNaD4V1Qus6lBtrWeK6Ke2hu3B6vDMUR51DCjjh+BP0V0cAK
	QyXxl2KrDtYBZNOmafRoNGDeGcS
X-Gm-Gg: AZuq6aIoMY4i3fq9Fk6QTr0yh6Bao7xJ9d6EWWKY5HOdCk/dJab0k8vw/3NVVir5kno
	6rT0M07+mdVesMT5k4an83aVkfrIZ8r/aKtKFGG6g1h78NAOCR+pNo4GS2zeTFXPWV7ZZED/qw8
	DnemPYRMXAq0R1ncxnl6+40XoKfmPMm5kMi1zIByMFQ3oI/REHtXaefWqih+oIhQ0kKp4VJH2Qc
	nJw4rEViSYpBhPj+BxIp5Smlb5EZ9YliypOaj1JupndxktVQPZFySbyc2OGk5ORkpj4yIohdtNx
	MtqobGlh26NeOTBK1E8paW6HEJvYAUvPZ+dbCzciAWuDjZVI/KwcYIbTR9RDMaHcBQi/Ck4htXV
	nnBTkBI54fiCo0nVC0dLQUzgzmYGuNy/S5zs0PGPspKCa7vBiXPLf0LLTmH69etxgoZ3IzKJvAN
	zTi9DFmfXsCmzgdn7Aa2TexbWBoNHOm4gCPYtvAuzaPCLDmpd5zreNnmRNn0NpJuEgaNfLLcE=
X-Received: by 2002:a17:90b:5384:b0:356:268e:ffa7 with SMTP id 98e67ed59e1d1-356a7660a64mr11665146a91.7.1771297678079;
        Mon, 16 Feb 2026 19:07:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3567eb8c138sm2407111a91.5.2026.02.16.19.07.57
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 19:07:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad60525deso194069675ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771297676; x=1771902476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCf4FtfvGypVXjYUwiJfc/VfrttB5iL2hkBxnBP/X/A=;
        b=XiE5r4c9axi9GGDmCirMV2CfG9bcjWTImAaEud6nVUPnLm9N/3DFmxE/dgVKl1o9pP
         43ruPoljs5+8vUhOJvF/lgWrgp+/FTsvSf3BnQoVDDJpE/N1Y5aVni7mSN7T0n5atlyP
         z0YTbf6MG/RK0uNjTwi9ajdK7zdZaXHypIFf8=
X-Received: by 2002:a17:903:1a07:b0:2aa:e39a:a7c4 with SMTP id d9443c01a7336-2ab4cf4f7f6mr116523115ad.1.1771297676214;
        Mon, 16 Feb 2026 19:07:56 -0800 (PST)
X-Received: by 2002:a17:903:1a07:b0:2aa:e39a:a7c4 with SMTP id d9443c01a7336-2ab4cf4f7f6mr116522915ad.1.1771297675750;
        Mon, 16 Feb 2026 19:07:55 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e537desm20688167a91.4.2026.02.16.19.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 19:07:55 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v13 4/6] RDMA/bnxt_re: Refactor bnxt_re_create_cq()
Date: Tue, 17 Feb 2026 08:29:08 +0530
Message-ID: <20260217025910.15865-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
References: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16938-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 888A7148981
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


