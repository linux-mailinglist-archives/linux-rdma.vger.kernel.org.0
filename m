Return-Path: <linux-rdma+bounces-4641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FA964AB7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 17:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18811C249E7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30ED1B3B08;
	Thu, 29 Aug 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RzwlzFhy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327241B1D7F
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946907; cv=none; b=UVksboxckY1tDh/vCv92y9XAl8MM/88EDk3c12OQ3ax/HxSftED1Pupm8qRnDtNm1n8sIjBorA9qW9NtY1cu8mtERLw7RPxGuhR7dm19S9xXqwBIDzgtTUL3OhTuJqEoytFc5t9ir45eb5kXJTJQPIP3ev/An0oRP6n2VuppIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946907; c=relaxed/simple;
	bh=yQ81tQkbalyIglTbg8R6nyKp/acgwIJeHlAqVCfiubw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SFP0kdr0soIdbEZunSGwqT0s5e4RH57tftXD1pt8BUTj7uz2ZZ1SJj+oqMXhgl9h67AjftjTU2UgS89sKOsxRBMssM+IIdMJ01tDjKQ1Zr3LQzSE6MAD74fi2vcf01XDQH2byG5Ld94UjczGPg0Grakr/CS5Kbfr+hwTvc+0RVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RzwlzFhy; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70cb1b959a6so493782a34.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724946905; x=1725551705; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10OHoNG68SXU9rV3TemHjbm/ccgfAAiHoAdx+wtfzAI=;
        b=RzwlzFhymWb6C0jvzA2bxwCapDIkOTk7Ka4zaEdPDbv4EaCDmKpGst7wLnjCLmh86z
         wAwIUjqPAAPHFfJFLuBXZ5KrBcAMccFqvJi6HsOjVCM+VHz2hHbgs1S/awhqQFxmmXRm
         JJ6B4Qe476EpNScD5+kVtB++a8G52h0M6PtCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946905; x=1725551705;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10OHoNG68SXU9rV3TemHjbm/ccgfAAiHoAdx+wtfzAI=;
        b=ev+khW0CjGlTQ9MZAjSvGsMDjI+UJcnQNmtCzwTX4p0+fFD+PWSyqNH31kE++haFuG
         N6PIXKpaaPIVldaIJH+7zhCqAbctjnZoLXMi6rN2EUGP6oEYJaYLiGNOipGdN6F5AV7O
         NslkmXLI92pwy8FiqqhAajAH+k/J7rqiNZehLeBUiNF7neltPBZrfibHxltvJFK5yeJV
         QsNw7eMWVn3zgRd7WNXZo2zZIu134sWZ0Sbird3H3RQrfcWidQtJxNMJ/zRlAyqNBQi5
         +sPfucfcQ7AytV/+vXHpqmcoZrfnu+XQnOneg9Q6D3yHT/3x4QPY1wZxknFMmZCjiB/n
         6tZA==
X-Gm-Message-State: AOJu0Yy2fIOduemt/LII/cY8r33QdmHvaUPdVILgFNIadqbWhL+/QBn6
	4CwSCSEA5VpRFej8L5dI+rv2vRg8SoQ97AdHxCAl8O0KMMuW2dip4D3+Xpgkzw==
X-Google-Smtp-Source: AGHT+IF8b/XFLPqgiPd5r5OG5+4LBLbCbkb6+EzQMWAAaH6OPgThPrOjYIt+lJJ39dD7t28o/fq0TA==
X-Received: by 2002:a05:6358:910d:b0:1af:1b40:5357 with SMTP id e5c5f4694b2df-1b603cb5ab7mr451894855d.24.1724946905189;
        Thu, 29 Aug 2024 08:55:05 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be627sm1396735a12.57.2024.08.29.08.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:55:04 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 1/3] RDMA/bnxt_re: Get the toggle bits from SRQ events
Date: Thu, 29 Aug 2024 08:34:03 -0700
Message-Id: <1724945645-14989-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Hongguang Gao <hongguang.gao@broadcom.com>

SRQ arming requires the toggle bits received from hardware.
Get the toggle bits from SRQ notification for the
gen p7 adapters. This value will be zero for the older adapters.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 11 +++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 3ddeda3..4e113b9 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -77,6 +77,7 @@ struct bnxt_re_srq {
 	struct bnxt_qplib_srq	qplib_srq;
 	struct ib_umem		*umem;
 	spinlock_t		lock;		/* protect srq */
+	void			*uctx_srq_page;
 };
 
 struct bnxt_re_qp {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 49e4a4a..19bb453 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -54,6 +54,10 @@
 #include "qplib_rcfw.h"
 #include "qplib_sp.h"
 #include "qplib_fp.h"
+#include <rdma/ib_addr.h>
+#include "bnxt_ulp.h"
+#include "bnxt_re.h"
+#include "ib_verbs.h"
 
 static void __clean_cq(struct bnxt_qplib_cq *cq, u64 qp);
 
@@ -347,6 +351,7 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 		case NQ_BASE_TYPE_SRQ_EVENT:
 		{
 			struct bnxt_qplib_srq *srq;
+			struct bnxt_re_srq *srq_p;
 			struct nq_srq_event *nqsrqe =
 						(struct nq_srq_event *)nqe;
 
@@ -354,6 +359,12 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 			q_handle |= (u64)le32_to_cpu(nqsrqe->srq_handle_high)
 				     << 32;
 			srq = (struct bnxt_qplib_srq *)q_handle;
+			srq->toggle = (le16_to_cpu(nqe->info10_type) & NQ_CN_TOGGLE_MASK)
+				      >> NQ_CN_TOGGLE_SFT;
+			srq->dbinfo.toggle = srq->toggle;
+			srq_p = container_of(srq, struct bnxt_re_srq, qplib_srq);
+			if (srq_p->uctx_srq_page)
+				*((u32 *)srq_p->uctx_srq_page) = srq->toggle;
 			bnxt_qplib_armen_db(&srq->dbinfo,
 					    DBC_DBC_TYPE_SRQ_ARMENA);
 			if (nq->srqn_handler(nq,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 56538b9..e714caa 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -105,6 +105,7 @@ struct bnxt_qplib_srq {
 	struct bnxt_qplib_sg_info	sg_info;
 	u16				eventq_hw_ring_id;
 	spinlock_t			lock; /* protect SRQE link list */
+	u8				toggle;
 };
 
 struct bnxt_qplib_sge {
-- 
2.5.5


