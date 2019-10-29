Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBBE8051
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 07:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbfJ2G2b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 02:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfJ2G2b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 02:28:31 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D101C20862;
        Tue, 29 Oct 2019 06:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572330510;
        bh=ph83667Xh8P3Dow7aoRaWmgEwvW+/ouZSKvqdl7ynVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00ZSEN9AtOzdM50CFCMDJj9N50rXGJiXBAoEaBF3AiTpSU8R0yVtOCubGWI+K0U4E
         MYHdVE2n/F62F8nIjV4iXLHZeT0RYhEicpaurrmeo4Lp+pf3X55gckpW6Rz++uOhLV
         vrTTXN1pHg+kma6oHZcnZrq8dr3N3sFmXOnRG7YI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: [PATCH rdma-next 06/16] RDMA/qib: Delete redundant memset for MAD output buffer
Date:   Tue, 29 Oct 2019 08:27:35 +0200
Message-Id: <20191029062745.7932-7-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is no need to clear MAD output buffer, because all
callers are calling process_mad() with cleared output buffer.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/qib/qib_mad.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index f92faf5ec369..5a1e6371ea57 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2098,8 +2098,6 @@ static int cc_get_classportinfo(struct ib_cc_mad *ccp,
 	struct ib_cc_classportinfo_attr *p =
 		(struct ib_cc_classportinfo_attr *)ccp->mgmt_data;
 
-	memset(ccp->mgmt_data, 0, sizeof(ccp->mgmt_data));
-
 	p->base_version = 1;
 	p->class_version = 1;
 	p->cap_mask = 0;
@@ -2120,8 +2118,6 @@ static int cc_get_congestion_info(struct ib_cc_mad *ccp,
 	struct qib_ibport *ibp = to_iport(ibdev, port);
 	struct qib_pportdata *ppd = ppd_from_ibp(ibp);
 
-	memset(ccp->mgmt_data, 0, sizeof(ccp->mgmt_data));
-
 	p->congestion_info = 0;
 	p->control_table_cap = ppd->cc_max_table_entries;
 
@@ -2138,8 +2134,6 @@ static int cc_get_congestion_setting(struct ib_cc_mad *ccp,
 	struct qib_pportdata *ppd = ppd_from_ibp(ibp);
 	struct ib_cc_congestion_entry_shadow *entries;
 
-	memset(ccp->mgmt_data, 0, sizeof(ccp->mgmt_data));
-
 	spin_lock(&ppd->cc_shadow_lock);
 
 	entries = ppd->congestion_entries_shadow->entries;
@@ -2176,8 +2170,6 @@ static int cc_get_congestion_control_table(struct ib_cc_mad *ccp,
 	if (cct_block_index > IB_CC_TABLE_CAP_DEFAULT - 1)
 		goto bail;
 
-	memset(ccp->mgmt_data, 0, sizeof(ccp->mgmt_data));
-
 	spin_lock(&ppd->cc_shadow_lock);
 
 	max_cct_block =
@@ -2296,12 +2288,6 @@ static int cc_set_congestion_control_table(struct ib_cc_mad *ccp,
 	return reply_failure((struct ib_smp *) ccp);
 }
 
-static int check_cc_key(struct qib_ibport *ibp,
-			struct ib_cc_mad *ccp, int mad_flags)
-{
-	return 0;
-}
-
 static int process_cc(struct ib_device *ibdev, int mad_flags,
 			u8 port, const struct ib_mad *in_mad,
 			struct ib_mad *out_mad)
@@ -2318,10 +2304,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 		goto bail;
 	}
 
-	ret = check_cc_key(ibp, ccp, mad_flags);
-	if (ret)
-		goto bail;
-
 	switch (ccp->method) {
 	case IB_MGMT_METHOD_GET:
 		switch (ccp->attr_id) {
-- 
2.20.1

