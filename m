Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76FB40C555
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhIOMeX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:34:23 -0400
Received: from relay.smtp-ext.broadcom.com ([192.19.166.228]:46880 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236893AbhIOMeW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:34:22 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6E39F2432C;
        Wed, 15 Sep 2021 05:33:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6E39F2432C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631709183;
        bh=UpRYOQ+5E/KwNO55Ax0lhlqlFjoDW4BxvBeb0Xgj4MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7vvvaiwTxMef8+CQp3pEUee43blwuxrK8+RV5z7sFIXRdTd1I8RoaslVS31ndvwl
         7BroelUyVCQEgJqqwYoM4BW5yMWovZUHmREcfJty/3WwJpllIl3nsgdyX7npb57XCx
         C/7S5QXa8zlIhnyt+Q2dl/cg9Ub3wo6NDzNTJ9co=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2 10/12] RDMA/bnxt_re: Correct FRMR size calculation
Date:   Wed, 15 Sep 2021 05:32:41 -0700
Message-Id: <1631709163-2287-11-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

FRMR WQE requires to provide the log2 value of the
PBL and page size.
Use the standard ilog2 to calculate the log2 value

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c4d7a9e..1cbc7e1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2487,7 +2487,8 @@ static int bnxt_re_build_reg_wqe(const struct ib_reg_wr *wr,
 
 	wqe->frmr.l_key = wr->key;
 	wqe->frmr.length = wr->mr->length;
-	wqe->frmr.pbl_pg_sz_log = (wr->mr->page_size >> PAGE_SHIFT_4K) - 1;
+	wqe->frmr.pbl_pg_sz_log = ilog2(PAGE_SIZE >> PAGE_SHIFT_4K);
+	wqe->frmr.pg_sz_log = ilog2(wr->mr->page_size >> PAGE_SHIFT_4K);
 	wqe->frmr.va = wr->mr->iova;
 	return 0;
 }
-- 
2.5.5

