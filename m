Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057FF17D21D
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2020 07:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgCHGyw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Mar 2020 01:54:52 -0500
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:17013 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726213AbgCHGyw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Mar 2020 01:54:52 -0500
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d75 with ME
        id Biul220010scBcy03iulFb; Sun, 08 Mar 2020 07:54:48 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Mar 2020 07:54:48 +0100
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/bnxt_re: Remove a redundant 'memset'
Date:   Sun,  8 Mar 2020 07:54:42 +0100
Message-Id: <20200308065442.5415-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'wqe' is already zeroed at the top of the 'while' loop, just a few lines
below, and is not used outside of the loop.
So there is no need to zero it here as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ad3e524187e3..15494ca33092 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2475,7 +2475,6 @@ static int bnxt_re_post_send_shadow_qp(struct bnxt_re_dev *rdev,
 	unsigned long flags;
 
 	spin_lock_irqsave(&qp->sq_lock, flags);
-	memset(&wqe, 0, sizeof(wqe));
 	while (wr) {
 		/* House keeping */
 		memset(&wqe, 0, sizeof(wqe));
-- 
2.20.1

