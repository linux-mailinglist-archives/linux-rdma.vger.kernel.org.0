Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E743F0D0B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhHRU6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 16:58:20 -0400
Received: from relay.smtp-ext.broadcom.com ([192.19.11.229]:41468 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233798AbhHRU6T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 16:58:19 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 09A7C89A3;
        Wed, 18 Aug 2021 13:57:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 09A7C89A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1629320264;
        bh=MDUa583p1LyQlRKHFB/ppvO/e+RnChJuBpIZiy3FxzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scbVLS1biCRI+5fsvVWLSFTuwSlCP/7RcOr54w2qgG9U92s9skOmDZV5pd6mpMtbV
         L1Hrnz0gyAe33+wrQkySuJrCqBmRU4O8qyJsA2virCCQc6KJARxGAnAi36n5AaVXgH
         gwzqif3f5Qj2pr/o/O6DsUGp+x8/tnFiNfzbpxCU=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 2/3] RDMA/bnxt_re: Add missing spin lock initialization
Date:   Wed, 18 Aug 2021 13:57:35 -0700
Message-Id: <1629320256-4034-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1629320256-4034-1-git-send-email-selvin.xavier@broadcom.com>
References: <1629320256-4034-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>

Add the missing initialization of srq lock.

Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 283b6b8..ea0054c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1681,6 +1681,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	if (nq)
 		nq->budget++;
 	atomic_inc(&rdev->srq_count);
+	spin_lock_init(&srq->lock);
 
 	return 0;
 
-- 
2.5.5

