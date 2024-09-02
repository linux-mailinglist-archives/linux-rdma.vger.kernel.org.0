Return-Path: <linux-rdma+bounces-4686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9C967F32
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 08:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78FA1C2122C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241BF1AACA;
	Mon,  2 Sep 2024 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LsdpTg1m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C009154C00
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257614; cv=none; b=F9vv2bADjY0eC1qvneQ9L+gTJbhYkdT5Oy3JE292ND75fUrHTHmgNNrEGF0XDHwuXPh725TPeUjqOtuzDjKM0iuGyW6aGe5VyySxEfu7JOEv8kqTxdnL8iRHKp/DS9j3D3VJUiSypwVYJIGcHIsO3w3OwIRMXU3qKw1XX1xzAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257614; c=relaxed/simple;
	bh=cOyciZmrtJ50Kt8IZMalAG2P3Xqu7Fn9kGjUo7vuE4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uxMPY3bKUm8EXu0dTKFt1Cf73HnqLuE1wi5UtkobFcq69WU+xbmyIwG1rQ2+bnPnWLlOpO6S9wg/tEphuXd0m+OgRbgniqM/W/hpNx7jpZl15WZ+nB/yX8S6kxkk9fjl7bbf7DkZAaUq0EIeR0aFxdFU7DtbCbeP/7YlgbuBqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LsdpTg1m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2055a3f80a4so6076995ad.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Sep 2024 23:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725257611; x=1725862411; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z2KugG7I1eBzOpFBMSKxsiL2Kwnc/YnNno1Vj2AryAo=;
        b=LsdpTg1m0OA85BqIldWs1p63A3U50xL2drdq5ZEKAWL8BrxDr+y+/zJLqdoijUKXz/
         Nq2q5/tyz6Xj8XYwL9kPUZpaggWmWmUb2NfkzEIRLdM2KDurPi3bmmDsTwOE0a1sIeJq
         wRG3AuykEG0BJwt9DZF41BG3+6NG8Lb6LU93A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725257611; x=1725862411;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2KugG7I1eBzOpFBMSKxsiL2Kwnc/YnNno1Vj2AryAo=;
        b=r4F16656Szf7mx8fK3crcOKkcglwaqMi+YaWBFzp0uIyEI1tXKqunLTMVTxZ2AOa8G
         qzPBvsO7+RSeNUy6+t3lOsaxLNiCAXlLRESgsUhTQjqCgQPv8WyoHbmgU6WX6MvTqK3u
         uG+RSvfKDzTfSL1lMQfCFek0XvuZSwR+3UKkqplfKcWCUXo3RycSN4D756puOJVq5YTK
         gW2JJwORRSIvI9fknIlF4FKYCQtho5v0/+i/ZXzxMAknlOsbzBroS3D9XnoMEg+hXdM3
         bzWSq4vyUtgLM6g+JQTebQFeVecJPogPI5xdEhmuhiiDgbYFRpZIghrvP12D1PpnNkHb
         xO4Q==
X-Gm-Message-State: AOJu0YzENb53dvdM7VitAEeVvqJg0LFc/a+s/I3xKZQYsAh7+NtLYNcu
	jmsi+OHsi2loH2TwPwQhCGDxBLONpzgdPPca9Wq3gcZalY6HxUd2qcRJNMU5Iw==
X-Google-Smtp-Source: AGHT+IHlsNtE8ZbLvq2OVn4EMi+RPGnoUuig4XLLTt7qsVIiugEJ2StQEk+OOhrFY4/WQCnF975kvQ==
X-Received: by 2002:a17:903:230c:b0:205:5155:c05 with SMTP id d9443c01a7336-20551550d58mr40109365ad.60.1725257610563;
        Sun, 01 Sep 2024 23:13:30 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054a2629c3sm28907955ad.105.2024.09.01.23.13.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2024 23:13:29 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 4/4] RDMA/bnxt_re: Add support for MR Relaxed Ordering
Date: Sun,  1 Sep 2024 22:52:31 -0700
Message-Id: <1725256351-12751-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725256351-12751-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Some of the adapters support Relaxed Ordering for the MRs.
Driver queries support for Memory region relax ordering  support from
firmware and  set relax ordering bit in REGISTER_MR request, if the users
request for the support. Also, this is supported only if the PCIe device
has enabled relaxed ordering attribute.

Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Vijay Kumar Mandadapu <vijaykumar.mandadapu@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 14 ++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 50cf3ec..a081580 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -115,6 +115,14 @@ static enum ib_access_flags __to_ib_access_flags(int qflags)
 	return iflags;
 };
 
+static void bnxt_re_check_and_set_relaxed_ordering(struct bnxt_re_dev *rdev,
+						   struct bnxt_qplib_mrw *qplib_mr)
+{
+	if (_is_relaxed_ordering_supported(rdev->dev_attr.dev_cap_flags2) &&
+	    pcie_relaxed_ordering_enabled(rdev->en_dev->pdev))
+		qplib_mr->flags |= CMDQ_REGISTER_MR_FLAGS_ENABLE_RO;
+}
+
 static int bnxt_re_build_sgl(struct ib_sge *ib_sg_list,
 			     struct bnxt_qplib_sge *sg_list, int num)
 {
@@ -3875,6 +3883,9 @@ struct ib_mr *bnxt_re_get_dma_mr(struct ib_pd *ib_pd, int mr_access_flags)
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
 
+	if (mr_access_flags & IB_ACCESS_RELAXED_ORDERING)
+		bnxt_re_check_and_set_relaxed_ordering(rdev, &mr->qplib_mr);
+
 	/* Allocate and register 0 as the address */
 	rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 	if (rc)
@@ -4108,6 +4119,9 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 	mr->qplib_mr.va = virt_addr;
 	mr->qplib_mr.total_size = length;
 
+	if (mr_access_flags & IB_ACCESS_RELAXED_ORDERING)
+		bnxt_re_check_and_set_relaxed_ordering(rdev, &mr->qplib_mr);
+
 	umem_pgs = ib_umem_num_dma_blocks(umem, page_size);
 	rc = bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, umem,
 			       umem_pgs, page_size);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index b452b2f..049805a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -570,4 +570,9 @@ static inline bool _is_alloc_mr_unified(u16 dev_cap_flags)
 	return dev_cap_flags & CREQ_QUERY_FUNC_RESP_SB_MR_REGISTER_ALLOC;
 }
 
+static inline bool _is_relaxed_ordering_supported(u16 dev_cap_ext_flags2)
+{
+	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_MEMORY_REGION_RO_SUPPORTED;
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
-- 
2.5.5


