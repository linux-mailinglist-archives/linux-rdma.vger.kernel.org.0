Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9139C856
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Jun 2021 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFENFy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Jun 2021 09:05:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48402 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFENFy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Jun 2021 09:05:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lpVy5-0000U5-Gx; Sat, 05 Jun 2021 13:04:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/irdma: remove extraneous indentation on a statement
Date:   Sat,  5 Jun 2021 14:04:00 +0100
Message-Id: <20210605130400.25987-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A single statement is indented one level too deeply, clean up the
code by removing the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 294155293243..65cb58cb32e1 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3442,7 +3442,7 @@ static void irdma_process_cqe(struct ib_wc *entry,
 		entry->src_qp = cq_poll_info->qp_id;
 	}
 
-		entry->byte_len = cq_poll_info->bytes_xfered;
+	entry->byte_len = cq_poll_info->bytes_xfered;
 }
 
 /**
-- 
2.31.1

