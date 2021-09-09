Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DDB405E34
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 22:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbhIIUri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345692AbhIIUrg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 16:47:36 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E277C061762
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 13:46:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y128so4281207oie.4
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPoJTfPdHp/LeXcgMLIb9FBaUbIGu0QL53pSwedsxQU=;
        b=oNWFCla1zLtQosn75qeObcldMeg3xP3x2SYDmQD63sGbb6sYdYt/Hs/ijV/Sd2L/rW
         eaPOQ66LEc/ZXQRvFm3VoCv0uQkyc7kjd9UzxDAcA+oHnd9xdX2bw7WS1X10Q14pocat
         vQrLB850jiVHEPt/EHongwZjwWe4j2CBND49HuNp73gVLS2T0VZ4t2ArWan19cyrbAoq
         XUv/nrMEibvffMc35i2Fkg0j6Z0mJiMtKQpdraS0tOAFWhrs9FmEm2iZzIIgcqfBBrho
         wD0xVFShVuQG8lRfORKlcWNtwhkANy3X3LE9BT7/jaZ9JmYMIs2rvPfph/0F30GkdkpE
         8FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPoJTfPdHp/LeXcgMLIb9FBaUbIGu0QL53pSwedsxQU=;
        b=gTErsH4N2egEmrUPvZUBswHebcRwZFNLUqJTjcyLONvYc/2Q9XA2T+mhxOOczSsaBx
         mh2vAV4VhA31Yx/pqkAR49SOk16D/XsA8hUi1Zm11T3kBWwg+g64cXqnp2ppZrQ6v38C
         /XHLwVmth/pI5PJmuwbXx3trSX+qwUN+TMngfnFonmfjikeIN2NRdQm5B8StWuSWCo3R
         W98HE2xCMwtzNPGFec8gffbIaa3S5/WwENG7iNrBd6Oonkqf0MeuMCMx8m+5aJy2Gmp2
         0n0Kv6zk6ES/JBArs/CWGYipQnxBKdPMNqIUmCMW+oOKDXPe/HMod4YDMidXKv8dCKyB
         Eb9Q==
X-Gm-Message-State: AOAM533bxo5yCHBYqdrs8V/VBq3VGuPGVyl4DhYRB0JXgkS02Fhjzs6a
        LV3MW04UnD8dAuE2C7Ztl9o=
X-Google-Smtp-Source: ABdhPJzWtEjUBDWkhJTY+RON5dIwbdHr1Rvde3UUTfiEErJyro0Gtk714KYhqkyGiAm/MQqKSxo1BQ==
X-Received: by 2002:a05:6808:657:: with SMTP id z23mr1511574oih.113.1631220384783;
        Thu, 09 Sep 2021 13:46:24 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-a0a5-b98f-837d-887f.res6.spectrum.com. [2603:8081:140c:1a00:a0a5:b98f:837d:887f])
        by smtp.gmail.com with ESMTPSA id i9sm719892otp.18.2021.09.09.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:46:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        mie@igel.co.jp, bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v3 6/6] RDMA/rxe: Only allow invalidate for appropriate MRs
Date:   Thu,  9 Sep 2021 15:44:57 -0500
Message-Id: <20210909204456.7476-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909204456.7476-1-rpearsonhpe@gmail.com>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Local and remote invalidate operations are not allowed by IBA for
MRs created by (re)register memory verbs. This patch checks the
MR type in rxe_invalidate_mr().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 8d658d42abed..53271df10e47 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -605,6 +605,12 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 		goto err_drop_ref;
 	}
 
+	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
+		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
 	mr->state = RXE_MR_STATE_FREE;
 	ret = 0;
 
-- 
2.30.2

