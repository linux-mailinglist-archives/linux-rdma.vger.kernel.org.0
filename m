Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974B610752C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 16:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVPsU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 10:48:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33873 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKVPsU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 10:48:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iYBAN-0001CC-6r; Fri, 22 Nov 2019 15:48:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/hfi1: remove redundant assignment to variable ret
Date:   Fri, 22 Nov 2019 15:48:14 +0000
Message-Id: <20191122154814.87257-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/hfi1/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/platform.c b/drivers/infiniband/hw/hfi1/platform.c
index cbf7faa5038c..36593f2efe26 100644
--- a/drivers/infiniband/hw/hfi1/platform.c
+++ b/drivers/infiniband/hw/hfi1/platform.c
@@ -634,7 +634,7 @@ static void apply_tx_lanes(struct hfi1_pportdata *ppd, u8 field_id,
 			   u32 config_data, const char *message)
 {
 	u8 i;
-	int ret = HCMD_SUCCESS;
+	int ret;
 
 	for (i = 0; i < 4; i++) {
 		ret = load_8051_config(ppd->dd, field_id, i, config_data);
-- 
2.24.0

