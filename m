Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DCF44E455
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Nov 2021 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhKLKJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Nov 2021 05:09:29 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53737 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhKLKJ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Nov 2021 05:09:29 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id lTS6mEc9TFGqtlTS7miLID; Fri, 12 Nov 2021 11:06:36 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 12 Nov 2021 11:06:36 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mei: Remove some dead code
Date:   Fri, 12 Nov 2021 11:06:33 +0100
Message-Id: <3f904c291f3eed06223dd8d494028e0d49df6f10.1636711522.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'generated' is known to be true here, so "true || whatever" will still be
true.

So, remove some dead code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is also likely that a bug is lurking here.

Maybe, the following was expected:
-	generated = generated ||
+	generated =
		(hisr & HISR_INT_STS_MSK) ||
		(ipc_isr & SEC_IPC_HOST_INT_STATUS_PENDING);

?
---
 drivers/misc/mei/hw-txe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index a4e854b9b9e6..00652c137cc7 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -994,11 +994,7 @@ static bool mei_txe_check_and_ack_intrs(struct mei_device *dev, bool do_ack)
 		hhisr &= ~IPC_HHIER_SEC;
 	}
 
-	generated = generated ||
-		(hisr & HISR_INT_STS_MSK) ||
-		(ipc_isr & SEC_IPC_HOST_INT_STATUS_PENDING);
-
-	if (generated && do_ack) {
+	if (do_ack) {
 		/* Save the interrupt causes */
 		hw->intr_cause |= hisr & HISR_INT_STS_MSK;
 		if (ipc_isr & SEC_IPC_HOST_INT_STATUS_IN_RDY)
-- 
2.30.2

