Return-Path: <linux-rdma+bounces-4739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6596B862
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEDB1F22187
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BAC1CF7AD;
	Wed,  4 Sep 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UwxGzKvG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A61CF5E5
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445510; cv=none; b=JS3QG1xjdPl4rPeMBEItEVWISHyEFjqs1csvH5am92jlA5SxQWYnQJ0v6Rc/eWsEK5mgqEGztaxOpNih7tBZTbWE4u+/QcHyk7rlwKGPgJVBPxvn6XmBLqaenfjBGzgVmCbKvEEAvEniv5CQqeskrwXqd2jEZbF+ii6TdOUBHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445510; c=relaxed/simple;
	bh=wbR3kWCFuyOAXzBr+BVQwezJ+0prMPvggye9qdWYW5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SL62FYfAj39eeqgT93oUvKg+f9feTP8qmkEPV/otElkv8JUVVfbdbSXE0sfGUsCLANtZ1X1/tvmIWfloGdKZ3jDkq4e35NxLBKcMCHVbo4hr3qTBcRP3WWc88JSbU8iMVnszBKGm4BxMlRh80hbw8sTwFb5/Lnp+B1ddEmeUcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UwxGzKvG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20551e2f1f8so33651135ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Sep 2024 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725445508; x=1726050308; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHx0eSEPI3EHaxD8Itf7ZDZhU7537hHK2H03Z3YqiUU=;
        b=UwxGzKvGXS+iqOVSYVYZa2ma+lwRg45Omp0xvd6fCC8F+q31lyCvnLCE31FBr1TCo5
         WHzi3qDnxUHAdQSf8t5tHsg3nwoVxQc8i+iNRUX/ui39fLIH24sfQ2IbCrZIl7SDZwEr
         PrmhyynKYArgaX4R8Jnvlo67vg8sJW4F+yW28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445508; x=1726050308;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHx0eSEPI3EHaxD8Itf7ZDZhU7537hHK2H03Z3YqiUU=;
        b=HHzU9ol+DQbQq/uawqzOQmUmtNjUuQ5GPBk+ci15r75LIU0D6n4FU1zriQ9qQksSqt
         zKJRPzRB6B8FtrPLr6AcmoXiwI02rK3HGUKCvZ2WyR2E9qQGELc5NKwziSMc4RBGVo/S
         yO77iDg1e4UMP59AP2a0t/g1nl4wuirA4ZH3UF6nrktvmX5ax00xpft4AMzZvylg6ACJ
         PNT1CPsGxJGH2yr5gfgrRcyrMduuRjTywypenPwjEMqdoQ9dz3EQuuP6fzZrrqwXxUdr
         An68s54F9g0xTaxUOfAQZB3SgEUG8fBlO6MjFzGfFK1kobbaTxKCgIfBJIDGxeCsVfby
         +BYQ==
X-Gm-Message-State: AOJu0YxtMgt5Icryiu76dUZqlx/bHYXDqmZydWvKs0TqsVo8IGV9HPUa
	5mxgxN1YCc0yBTcP/dbNVV2nlHU6NoOkRfa37a8VrdSCBLphTLjWGGZXCfJdbg==
X-Google-Smtp-Source: AGHT+IGQmAMJLNJeUckHR7smayacI/Nf96kTy8b4I3uaOe6Osr/p1wFJJLkeOTtzrDxoHNN1gfDCFQ==
X-Received: by 2002:a17:902:e80b:b0:202:2d:c87 with SMTP id d9443c01a7336-2058417b35emr102794635ad.12.1725445508164;
        Wed, 04 Sep 2024 03:25:08 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea383aasm10940265ad.136.2024.09.04.03.25.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2024 03:25:07 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 2/2] RDMA/bnxt_re: Fix the max WQE size for static WQE support
Date: Wed,  4 Sep 2024 03:04:13 -0700
Message-Id: <1725444253-13221-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725444253-13221-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725444253-13221-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

When variable size WQE is supported, max_qp_sges reported
is more than 6. For devices that supports variable size WQE,
the Send WQE size calculation is wrong when an an older library
that doesn't support variable size WQE is used.

Set the WQE size to 128 when static WQE is supported.

Fixes: de1d364c3815 ("RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  2 ++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ecee691..89f6578 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1006,23 +1006,23 @@ static int bnxt_re_setup_swqe_size(struct bnxt_re_qp *qp,
 	align = sizeof(struct sq_send_hdr);
 	ilsize = ALIGN(init_attr->cap.max_inline_data, align);
 
-	sq->wqe_size = bnxt_re_get_wqe_size(ilsize, sq->max_sge);
-	if (sq->wqe_size > bnxt_re_get_swqe_size(dev_attr->max_qp_sges))
-		return -EINVAL;
-	/* For gen p4 and gen p5 backward compatibility mode
-	 * wqe size is fixed to 128 bytes
+	/* For gen p4 and gen p5 fixed wqe compatibility mode
+	 * wqe size is fixed to 128 bytes - ie 6 SGEs
 	 */
-	if (sq->wqe_size < bnxt_re_get_swqe_size(dev_attr->max_qp_sges) &&
-			qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-		sq->wqe_size = bnxt_re_get_swqe_size(dev_attr->max_qp_sges);
+	if (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) {
+		sq->wqe_size = bnxt_re_get_swqe_size(BNXT_STATIC_MAX_SGE);
+		sq->max_sge = BNXT_STATIC_MAX_SGE;
+	} else {
+
+		sq->wqe_size = bnxt_re_get_wqe_size(ilsize, sq->max_sge);
+		if (sq->wqe_size > bnxt_re_get_swqe_size(dev_attr->max_qp_sges))
+			return -EINVAL;
+	}
 
 	if (init_attr->cap.max_inline_data) {
 		qplqp->max_inline_data = sq->wqe_size -
 			sizeof(struct sq_send_hdr);
 		init_attr->cap.max_inline_data = qplqp->max_inline_data;
-		if (qplqp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-			sq->max_sge = qplqp->max_inline_data /
-				sizeof(struct sq_sge);
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 4ce44aa..acd9c14 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -358,4 +358,6 @@ int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 #define BNXT_VAR_MAX_SGE        13
 #define BNXT_RE_MAX_RQ_WQES     65536
 
+#define BNXT_STATIC_MAX_SGE	6
+
 #endif /* __BNXT_QPLIB_SP_H__*/
-- 
2.5.5


