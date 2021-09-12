Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515B2407F34
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 20:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhILSRB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 14:17:01 -0400
Received: from saphodev.broadcom.com ([192.19.11.229]:34504 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235166AbhILSRB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 14:17:01 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6BD457DBA;
        Sun, 12 Sep 2021 11:15:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6BD457DBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631470546;
        bh=Gq8Z96QvVaIbEPrqWBB/pxFL/d0PWYtBVYChn17q4zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KS3V+L/U4e5Xbm5Pxi8rFWVKbOSSR7JxSEEHW0BKlAmLSUH6Rhrfef/IbE2DFtqFW
         X2WFLW/JkerRu+VPENyWgfGHpVNRot4hAEJ/eo6Elg4WAw1aRKrUPIQZGtyBbfW+qU
         fDCEtme8wdgw0+DbBctE3XudAjQ1g8DnS8CA8vgA=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 10/12] RDMA/bnxt_re: Correct FRMR size calculation
Date:   Sun, 12 Sep 2021 11:15:24 -0700
Message-Id: <1631470526-22228-11-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

FRMR WQE requires to provide the log2 value of the
PBL and page size.
Use the standard ilog2 to calculate the log2 value

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

