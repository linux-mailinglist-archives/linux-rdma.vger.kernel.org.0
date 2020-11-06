Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73002AA0A9
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgKFXDg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgKFXDf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:03:35 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE3C0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:03:35 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z16so2830343otq.6
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKpAnJFY88Hlwwv2HotB92g4wCr2j+2rZg7iI2TItn4=;
        b=JF9IVd8vDrk5yeojzcKQiTvKGjksxjz1EqnIfzDzpsPVEQphHvthz/Hkzl3Cv6hEWY
         DHhiQQvdq4Wl4f4p4XpD6hFSgIHF71tASwff9Qp0WtLJ2Mp4WxwZwwhH1lj9q/4p5OM+
         TZxI7Y0dmlhtgDGoE2OAmD+xUoEkpBLvF+WwR7Inj2tVQYPoUKV2Ld0c0l9WSOwlRr9y
         98xoM2N4vcXNq4x8sq2AkXfbd01Eq3hR58FBlqfhpFubqX90U8nPuoSgz8cnhTrWeU95
         3o8Zxcrqouf9iq3aXS3/v0MONhXGDoVIIchUibL53nxb7yN42a2Lh9FlRAoZYr4bV/40
         83Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKpAnJFY88Hlwwv2HotB92g4wCr2j+2rZg7iI2TItn4=;
        b=RTnArQmjyF9DdeMhBGK0GFZYyQEf6d0LQP6zsqoqnMaPFks1VPr44up1b4zr/bMDKi
         qYYcPmrBX3cU0mhPsRetZ4UHfSrkP3kmMnm3643lYqVDmpwYp1yg+/yZBrOVfxTNSADm
         im0eIDFNQ4YoUiX3zEALMwdkUnHTugyE81I26CQo6a5FkyvLSDQZiERMMLsjoQPCWEw5
         LnxfheVU46LyzE6ylxu/K7x9q9xwv+EiaBm5zPiGHEKywugK86WrqJM7CeR+yiWDezTQ
         4K4PcKUxVPLm8LUhNowzNc17tCQPHXx1Qh6mb2g23CGw0XAftkDbN3IoR2bjA+4sNf1w
         OtCw==
X-Gm-Message-State: AOAM5320sW1yJsjVC8thhb+QCKhzzDqhbA1OvLIzl8dnejGt9dT8I5f8
        KBTXQO5lP8uEaedjTZcn1/g=
X-Google-Smtp-Source: ABdhPJxz7QEIDdCE53ttyRnLLgp/Clp2jOWdwG177U6q/sMzr7ffjoDvQRhihWRVfrDRcofdsXXJWg==
X-Received: by 2002:a9d:4e8e:: with SMTP id v14mr2647953otk.3.1604703815108;
        Fri, 06 Nov 2020 15:03:35 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id h28sm660017ooc.42.2020.11.06.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:03:34 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 1/2] RDMA/rxe: Exchange capabilities with provider
Date:   Fri,  6 Nov 2020 17:03:18 -0600
Message-Id: <20201106230319.17477-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201106230319.17477-1-rpearson@hpe.com>
References: <20201106230319.17477-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Exchange provider and driver capabilities during
alloc_ucontext verb. Default is none. Will allow
more flexibility in ABI extensions without breaking
compatibility.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 ++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 23 +++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 +++
 include/uapi/rdma/rdma_user_rxe.h     | 12 ++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 95f0de0c8b49..dbd84347e7df 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -73,6 +73,8 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
+
+	rxe->driver_cap				= RXE_CAP_NONE;
 }
 
 /* initialize port attributes */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8af2bb968f6d..070f050b9793 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -110,6 +110,29 @@ static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 {
 	struct rxe_dev *rxe = to_rdev(uctx->device);
 	struct rxe_ucontext *uc = to_ruc(uctx);
+	struct rxe_alloc_context_cmd cmd = {};
+	struct rxe_alloc_context_resp __user *resp = NULL;
+	int err;
+
+	if (udata) {
+		if (udata->inlen >= sizeof(cmd)) {
+			err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
+			if (err)
+				return err;
+		}
+
+		if (udata->outlen >= sizeof(resp))
+			resp = udata->outbuf;
+	}
+
+	uc->provider_cap = cmd.provider_cap;
+
+	if (resp) {
+		err = copy_to_user(&resp->driver_cap, &rxe->driver_cap,
+				   sizeof(resp->driver_cap));
+		if (err)
+			return err;
+	}
 
 	return rxe_add_to_pool(&rxe->uc_pool, &uc->pelem);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 57967fc39c04..bc021f15ef06 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -36,6 +36,7 @@ static inline int psn_compare(u32 psn_a, u32 psn_b)
 struct rxe_ucontext {
 	struct ib_ucontext ibuc;
 	struct rxe_pool_entry	pelem;
+	u64			provider_cap;
 };
 
 struct rxe_pd {
@@ -358,6 +359,8 @@ struct rxe_dev {
 
 	struct net_device	*ndev;
 
+	u64			driver_cap;
+
 	int			xmit_errors;
 
 	struct rxe_pool		uc_pool;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index e591d8c1f3cf..70ac031e0a88 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -158,6 +158,18 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+enum rxe_capabilities {
+	RXE_CAP_NONE		= 0,
+};
+
+struct rxe_alloc_context_cmd {
+	__aligned_u64		provider_cap;
+};
+
+struct rxe_alloc_context_resp {
+	__aligned_u64		driver_cap;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.27.0

