Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAEE49ED82
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbiA0ViL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbiA0ViK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:10 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69893C061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:10 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so3889622oth.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsZTG23E7hU2lbuZGfhkrrJO4k1jAwTbw+oM1vC5OO8=;
        b=q4RESmuSw0i7BtNsL2smCyi5PrQyC3g4Ud+zbxRk1/mmtVchuGjuGIVu2zOpuwX6g/
         OTARGVM3dWIgIb9evzHrXTpymPmMFl6wS2T4zUbPDmMqkJLsaxtPuOwxavMcn7v5NJY3
         PUGBDke9RPD4ug+7gGnebux93TvhEWQw8u8NqeiO+vJBeymbGkhAOme55tJEQ/EuQILb
         1Lki0+gkKGSOuNQmBRnXIG1P/mIHy6SI3IwYZ7i98Pc79xBu7XpbOe3ypdofhhQ6b4Dv
         sfk489ZIsxkVLdJ/tu6m0TcUMGFRNyzdjU6z6NGqddzViBcEoWQbMFcZMOhZjKpF7kcg
         u+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsZTG23E7hU2lbuZGfhkrrJO4k1jAwTbw+oM1vC5OO8=;
        b=xAkc4SUR6D3SxFWbKFvRqj7KuMy+4AlLY6rypgTi6qULEYaFSm9xoMXOrO4UnIuQej
         IUDJhkmSvyBgdekD55RMwpJMxL3+svC07WTMy2GuDC7ARIRfHCnPLJM9QSk0s5viqfEJ
         FsvWOogrVSeYsBTYn335obCJ8pV1ZsDcRm3LcdHB8kWMD8Zx6swF1h4vPuWB6yvvKoLD
         GTfVo/DL7aWcl3nFkXfx9urZzEpxKJDVnNQVfa7DiKDZAQdx14FBzieX8wZKjFR48TRo
         E85oFO4BwlhrAajl5/3iLjaddhXbCyijqXzQamsUnzKRQit9EtH7INCAmFwQIIzEY4fo
         lVXw==
X-Gm-Message-State: AOAM533JmlDs/WrJITScW1CiaoMSTj0yHPaJyIiABBX0u0LfNrrPRPgu
        /BUODBsJAij5hkeznZvGJn5bvTABpjk=
X-Google-Smtp-Source: ABdhPJwufLMybNoGb/Wwm40toayyEvNwtNhdalp5osqPcoyLJugDrw6Y5IIHUuSJ8+d5n1leH1zbbg==
X-Received: by 2002:a9d:6c13:: with SMTP id f19mr3253073otq.87.1643319489398;
        Thu, 27 Jan 2022 13:38:09 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:09 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 05/26] RDMA/rxe: Remove rxe_drop_all_macst_groups
Date:   Thu, 27 Jan 2022 15:37:34 -0600
Message-Id: <20220127213755.31697-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With o10-2.2.3 enforced rxe_drop_all_mcast_groups is completely
unnecessary. Remove it and references to it.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 -
 drivers/infiniband/sw/rxe/rxe_mcast.c | 26 --------------------------
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 --
 3 files changed, 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 052beaaacf43..af40e3c212fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,7 +40,6 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
 void rxe_mc_cleanup(struct rxe_pool_elem *arg);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 34e3c52f0b72..39a41daa7a6b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -162,32 +162,6 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return -EINVAL;
 }
 
-void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
-{
-	struct rxe_mcg *grp;
-	struct rxe_mca *elem;
-
-	while (1) {
-		spin_lock_bh(&qp->grp_lock);
-		if (list_empty(&qp->grp_list)) {
-			spin_unlock_bh(&qp->grp_lock);
-			break;
-		}
-		elem = list_first_entry(&qp->grp_list, struct rxe_mca,
-					grp_list);
-		list_del(&elem->grp_list);
-		spin_unlock_bh(&qp->grp_lock);
-
-		grp = elem->grp;
-		spin_lock_bh(&grp->mcg_lock);
-		list_del(&elem->qp_list);
-		grp->num_qp--;
-		spin_unlock_bh(&grp->mcg_lock);
-		rxe_drop_ref(grp);
-		rxe_drop_ref(elem);
-	}
-}
-
 void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mcg *grp = container_of(elem, typeof(*grp), elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 2af19b79dd23..087126550caf 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -812,8 +812,6 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 {
 	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
 
-	rxe_drop_all_mcast_groups(qp);
-
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
 
-- 
2.32.0

