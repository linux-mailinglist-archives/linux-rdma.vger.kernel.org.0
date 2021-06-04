Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3042539C3B5
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Jun 2021 01:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFDXKi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 19:10:38 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45693 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFDXKi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 19:10:38 -0400
Received: by mail-oi1-f177.google.com with SMTP id w127so11297460oig.12
        for <linux-rdma@vger.kernel.org>; Fri, 04 Jun 2021 16:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+1jdOQbnDoEUvi8uvl5HpLXOMImTf+jfewPWN4mJ/g=;
        b=ty6pxMofdlMD5zfKASdqo4atCPUXP4ub9dQp2VMznrCfyJ5Lp/suANqhXyn+3PGm4W
         39dJ4kGFCfc8B87nIw4Mzz7bR+0ly9vR6WnHbgnmcshuxyqiv64Cvx7AUGjyi5H0xj4q
         sTYRYJnaBxCdezaBzlVCgoJWHRp8NLYZLQpWCjfKpnXuguqdlLxCBzHDaowEXYPGFkXO
         F42Kyi8RPjhZIWLbxT2rPOlEX7shRp81MCFkUJ30iUjXZ40wt7TyKXQzLeNrekYFd2tU
         IXXuJc9Ut55jNkBfLq+8kg/Gi/cNxbjFdTotqcpq1ZUX6Dhwc491q70CEW5YiOapo8tB
         5LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+1jdOQbnDoEUvi8uvl5HpLXOMImTf+jfewPWN4mJ/g=;
        b=F2xjUxuRMdfzZ7vu0r6q8EANbUZvDDKexCv5smUsFw69nnKWZEGUtvebfRso3CcB7Q
         55RdInVghL35SqoAty2fYRS1fVgPIRv8MY7hPJdbJu2AoI2s0gg2/7z2H9Z5xuOZwqSG
         9t+aUujYnsC95ZONhzySP9z3+a/0ywNbO1LO04AX9q5EN9+FiRNUWFHoLREur6nyaXhw
         D3yGLWZ5nvcPDcAHvmoErYiToHXsaiScDVMebWi8oIgWzmkUmulE0Nzk8ZI3V6Gi3CLe
         LgMGZVhqO8+J2+aESaIURxtr7IQz/6wDyoy63UoK3ewZhTBMWCiR6JlbE0ns4sHv5iZN
         lztQ==
X-Gm-Message-State: AOAM532eN1q6Wvm+88OJm62Ftt25Ry277sUAHp2tROhpEVfIiZR/ogB/
        LYnfw9YkD6fFusbUUcpghYrEi72ILvE=
X-Google-Smtp-Source: ABdhPJx2YbaDoXsoiZBqkl1dEDsJOKyDW3CcSJHHEybPS7ERrK2evGbKdLVKFgGpyizv0IrwCRMldQ==
X-Received: by 2002:aca:400b:: with SMTP id n11mr4421676oia.111.1622848057998;
        Fri, 04 Jun 2021 16:07:37 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-c04b-c76e-4a4f-9612.res6.spectrum.com. [2603:8081:140c:1a00:c04b:c76e:4a4f:9612])
        by smtp.gmail.com with ESMTPSA id t23sm745010oij.21.2021.06.04.16.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 16:07:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic ops
Date:   Fri,  4 Jun 2021 18:05:59 -0500
Message-Id: <20210604230558.4812-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver attempts to protect atomic responder
resources by taking a reference to the qp which is only freed when the
resource is recycled for a new read or atomic operation. This means that
in normal circumstances there is almost always an extra qp reference
once an atomic operation has been executed which prevents cleaning up
the qp and associated pd and cqs when the qp is destroyed.

This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
destroyed while a peer is retrying an atomic op it will cause the
operation to fail which is acceptable.

Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 1 -
 drivers/infiniband/sw/rxe/rxe_resp.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 34ae957a315c..b6d83d82e4f9 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -136,7 +136,6 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
 	if (res->type == RXE_ATOMIC_MASK) {
-		rxe_drop_ref(qp);
 		kfree_skb(res->atomic.skb);
 	} else if (res->type == RXE_READ_MASK) {
 		if (res->read.mr)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 2b220659bddb..39dc39be586e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -966,8 +966,6 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		goto out;
 	}
 
-	rxe_add_ref(qp);
-
 	res = &qp->resp.resources[qp->resp.res_head];
 	free_rd_atomic_resource(qp, res);
 	rxe_advance_resp_resource(qp);
-- 
2.30.2

