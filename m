Return-Path: <linux-rdma+bounces-17377-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AJKMf5vpWlXAgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17377-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9B81D73DB
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEA3430358A5
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048E35FF5B;
	Mon,  2 Mar 2026 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vic4Hu/y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932735AC38
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449776; cv=none; b=VuRp6ZCrjDPfE8ZG4UDbKCSUb2iEMK6ocK6OC53IYSX8SeUhjliM/DEKug18F5bxLn4scmurn0stU0zJjJXr8dPjIc6k+56MyjrZxSLP10WjsvYm0YwO1MRKMZZpDr0dp5cmz0cGZ81qi6BYu9qFJE75fIVoUiEoVVv6TMkEJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449776; c=relaxed/simple;
	bh=ZBxS8A3wyydBdPMuA7FqOt9OYUcxp8ReCXogkK9QVKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9W+rxsGbZlAAehJp7HE06TUpOfigOC1Ai35snTy2Pmfq+JWC9TBDsA0G4EU4JNxSftyonD5sC2jghABUZqUEPOY2NYoxkMhA58NayE04+d0Kq2JD+QuD3LLoA9M00WtvzdF9f+gbrNyzlmvg07V7vjYw5EdcRow4+LDXzUJqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vic4Hu/y; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso2204008b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449774; x=1773054574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQidfz1FxrllWxakQZt7Dg6Cpa+UFeSKmj27vPoyLBI=;
        b=a6h5C5/mJptexHX2/oUdkAV2NxElGo7bG9WRZEuEPI7hum8zMjcZJfC0NTdt4JMMfa
         ADiPns3hzd78cRAyqCG+QeCI7J4lpetcSgTb5TmLpg04+7akNIsALWiXW2zHkBum93mB
         SSq++YEy7zIRMiQu3TDJM0GWUqVMMSb1zMibBFJMAcauSCXISPnLSLngfWBOpiP69eWl
         A3UiAoQXlVlat7wG0sySe8J1eS3EX9Wp8lOKI2UQEToexY1+069yYIs/NDERfUQpWXiS
         PVnVykNEKc85eRH93yepmqLJu3TTV4mSpAHAg5CL1IHD0HaVDVCPROq+1Y4Rt6pEL+bj
         nB5w==
X-Gm-Message-State: AOJu0YzEeIkYDS/N9pSRx9YUKz3r7/YGOKaxB3banejKucv2GDHt9RoV
	cL9rZfp/0yQFFa0p9dQ/L6AcQyNcN1SDO0dG9gAr7QMqOJZDckZu8gbQOQxSaj8QgCaAMyx/xQZ
	x7iZivcXDvXlvr0zAT1LbD6kV5wejVvELqUotRJ6FlCTkHCU07fn34bwRb1kSWyk3hr5oX2wj9H
	FUZ9XnHRiXQOFX1Q2oPn3JCzON3DajxOA6GPvlvi5BZytQGYzLSWTXfOr3TUxNQw9KHaW1V5i7K
	dv5EjzV53RTmJkOfMozleoVJuxi
X-Gm-Gg: ATEYQzzhe+TaCS8OT3f30Rb/svZlib/OQBtN7QXodgM/pesik0pH26FHXWQ08irqkoZ
	dg0oHPbwNClanHByHz+hej/6uZqOGX5Acz3tfQ4f3agvfmCwf6TruelvhEviXYV70JXDH/d+j84
	FrZIQqQIooTPdoMuBX1GTSj8/qOmAOV+lNQE1HfVNoiSI+UdD9FHItgMnzR/XpKeY4sKoiKNGZ8
	QRTYy0FgPWfB3yKEzPOjWDep4ebClikDCMqWduUTeY6F78towKv6kV6OcBHzXjRPoCNCX4gH5tO
	v9ZBi5SfFV9L2JT683F/zhoDh05uxWbX8cCw3jUPH/K52UHaxCv6HJIBaC48zskaQxvixj6zFuW
	VC83lFQHA6X9ccFi3BV7qrcQws4azwlvWbhzoF2I+NGuu4H/WBWbeBhrwOIVZFwL23bFbHmBqxl
	YIpWcDqYQH00bpj1/DW3fxM2tKDkYxuXisKNDG5WW//MJ68Rv1dOdZ6IEjFMenlO3E2JTGfHk=
X-Received: by 2002:a05:6a00:882:b0:827:397f:795d with SMTP id d2e1a72fcca58-8274da0b7d6mr10027403b3a.46.1772449774400;
        Mon, 02 Mar 2026 03:09:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82739e73eb7sm1458040b3a.6.2026.03.02.03.09.33
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 03:09:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae415b68b1so19213515ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 03:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772449772; x=1773054572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQidfz1FxrllWxakQZt7Dg6Cpa+UFeSKmj27vPoyLBI=;
        b=Vic4Hu/yr1hm42470VKJEHkdizy3fGYoppn3XBqUghWEcV0tfIsua9FmO80oNqyVQq
         creXaJTct6F5V3XolXGNN5xr9gc1/MuZ6ngtnAK4xQUzcVPaNh/wo9UMQunGJQhSZLNu
         YMAboVYL89lrNnQN3Lr4+i7sLlwKtZalS/Szs=
X-Received: by 2002:a17:902:fc4f:b0:2ae:467f:11d8 with SMTP id d9443c01a7336-2ae467f12b1mr65383445ad.30.1772449772495;
        Mon, 02 Mar 2026 03:09:32 -0800 (PST)
X-Received: by 2002:a17:902:fc4f:b0:2ae:467f:11d8 with SMTP id d9443c01a7336-2ae467f12b1mr65383205ad.30.1772449771987;
        Mon, 02 Mar 2026 03:09:31 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm58391755ad.44.2026.03.02.03.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:09:31 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v14 4/6] RDMA/bnxt_re: Refactor bnxt_re_create_cq()
Date: Mon,  2 Mar 2026 16:30:34 +0530
Message-ID: <20260302110036.36387-5-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
References: <20260302110036.36387-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17377-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E9B81D73DB
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
index 45087be01548..c073729a6d2d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3349,6 +3349,26 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	return ib_respond_empty_udata(udata);
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
@@ -3380,8 +3400,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
-	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
 
@@ -3396,7 +3414,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
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


