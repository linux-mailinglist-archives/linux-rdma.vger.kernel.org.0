Return-Path: <linux-rdma+bounces-4608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76539622FB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D171C21F3D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362C15A87B;
	Wed, 28 Aug 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y1MQ5KNC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851B158543
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836086; cv=none; b=qD8GX6VvHi/bxfhq47k3NZHewCgQzqHSImN/k4hARCR3scTM+wwXBCBqUrDhH/1pUE8OmudTH13usMth7WbSuHzmrW1K12ZfjRGPGH9i8zs/8M1FpABlif70u2ynWYmh//6WsWGqKPTET/W5mx368HwjHvEMOEsRl6i/xYr5z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836086; c=relaxed/simple;
	bh=yQ81tQkbalyIglTbg8R6nyKp/acgwIJeHlAqVCfiubw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mY+EIVo7hYpjz01HWWHxphY4j886232mhoU1uIRM39L4A8YLgr/28EfPV2hh29zaP1RIEkMeTesa3qJVvswgM5TWLaFlZ4ibnXXbllSiVaNJH/CcFh/Lvb28I+eVTvdNpMG2DK6+s+6HtrIkXKoHeINuL7ioZ7OI8xZ5cqxBSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y1MQ5KNC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201fbd0d7c2so53782205ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724836084; x=1725440884; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10OHoNG68SXU9rV3TemHjbm/ccgfAAiHoAdx+wtfzAI=;
        b=Y1MQ5KNCk3OR4nvxHDdCxMrrzVZWqhsejtJ3axGPI9GXpe7FaTsA+a0iP+qrqM478B
         kMQfikjNNNO9snw498lDJt5KXr4C03ZhL34QrNlw4rX3608J0pZuUj4pmNlJ4oX57qho
         P0XKjj6TKklVmEE5KfVjW+Bjgai9KklDTPywI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724836084; x=1725440884;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10OHoNG68SXU9rV3TemHjbm/ccgfAAiHoAdx+wtfzAI=;
        b=wh/5Jfsls6CrGl7sK6UCqZxNq7lx/X3tePzMQ2VmbVrlZdK7C6fL7Sm96OK3GASvbn
         4Cw5yCs1jJRaOa3KtxchmkoIwYjoiUpbLL9UBqkJ0Gz1FqbA4ievnELpFRNcm6dA3yDk
         6gGFHkcEhT8Yqtub6VqLfeGlumcMK/oAvM6SMwgtBy3jjadXY/pKXjXf91OXLCMRD6Wz
         22oS2mI+G2wHc1maeAMhDfvupvW2qyaA0SasvhxL6o4/s3O2mLLvX7qFDS9+6KsaLGPM
         wxUppnKEMAJl0kiTSPqev8/plge6yWrcyQbtvpz52lWWH2eaSRp2GIJMauzYmeXiC1M7
         KeVg==
X-Gm-Message-State: AOJu0Yy48YnCcBgT9TfZ+XHPC1Go2nDEzJDLqtFZP2vLL6xluqjOQvZk
	fJ9UG6DIhk/tWCOSiw5FX9aFWVDvE3czlzl4RleFYhEFGVQ6kTHuHyEQ7AnhllykojUIDpKUkkk
	=
X-Google-Smtp-Source: AGHT+IG4wDsUevh5EKGyjLiNLj91aDp5VHLVEAMrSXTtuAwb5tlFd9jFJSTXWOrPyzhIKc/8F9pgmg==
X-Received: by 2002:a17:902:f541:b0:1fc:6901:9c35 with SMTP id d9443c01a7336-204f9b744d2mr17350695ad.20.1724836084443;
        Wed, 28 Aug 2024 02:08:04 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm94735955ad.196.2024.08.28.02.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 02:08:03 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/3] RDMA/bnxt_re: Get the toggle bits from SRQ events
Date: Wed, 28 Aug 2024 01:47:10 -0700
Message-Id: <1724834832-10600-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
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


