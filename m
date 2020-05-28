Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0716F1E5DE2
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgE1LHP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 07:07:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48173 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388164AbgE1LHP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 May 2020 07:07:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jeGNR-0007aR-UW; Thu, 28 May 2020 11:07:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] IB/hfi1: fix spelling mistake "enought" -> "enough"
Date:   Thu, 28 May 2020 12:07:09 +0100
Message-Id: <20200528110709.400935-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 7f35b9ea158b..15f9c635f292 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14559,7 +14559,7 @@ static bool hfi1_netdev_update_rmt(struct hfi1_devdata *dd)
 	}
 
 	if (hfi1_is_rmt_full(rmt_start, NUM_NETDEV_MAP_ENTRIES)) {
-		dd_dev_err(dd, "Not enought RMT entries used = %d\n",
+		dd_dev_err(dd, "Not enough RMT entries used = %d\n",
 			   rmt_start);
 		return false;
 	}
-- 
2.25.1

