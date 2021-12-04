Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7B468744
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Dec 2021 20:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348573AbhLDTzL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Dec 2021 14:55:11 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:57661 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351256AbhLDTzG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Dec 2021 14:55:06 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id tb4Lm77Ovozlitb4Lmvzx5; Sat, 04 Dec 2021 20:51:38 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 04 Dec 2021 20:51:38 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/irdma: Fix the type used to declare a bitmap
Date:   Sat,  4 Dec 2021 20:51:34 +0100
Message-Id: <574b773fe7ced0cc87f1e1832350b38374815bd4.1638647428.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'bitmapbuf' is really used as a bitmap, so it should be defined as a
'unsigned long *' to be more consistent with the bitmap API.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/irdma/pble.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/pble.h b/drivers/infiniband/hw/irdma/pble.h
index e1b3b8118a2c..faf71c99e12e 100644
--- a/drivers/infiniband/hw/irdma/pble.h
+++ b/drivers/infiniband/hw/irdma/pble.h
@@ -69,7 +69,7 @@ struct irdma_add_page_info {
 struct irdma_chunk {
 	struct list_head list;
 	struct irdma_dma_info dmainfo;
-	void *bitmapbuf;
+	unsigned long *bitmapbuf;
 
 	u32 sizeofbitmap;
 	u64 size;
-- 
2.30.2

