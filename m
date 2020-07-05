Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18038214B1E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgGEIUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33113 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgGEIUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:11 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5qW001670;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5Vw009273;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K5d6009272;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 02/13] verbs: Close async_fd only when it was previously created
Date:   Sun,  5 Jul 2020 11:19:38 +0300
Message-Id: <1593937189-8744-3-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Close async_fd only when it was previously created, otherwise the call
will fail and errno from previous failure (if exists) will be
overwritten.

Fixes: 1111cf9895bb ("verbs: Always allocate a verbs_context")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libibverbs/device.c b/libibverbs/device.c
index 4629bbf..629832e 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -378,7 +378,8 @@ void verbs_uninit_context(struct verbs_context *context_ex)
 {
 	free(context_ex->priv);
 	close(context_ex->context.cmd_fd);
-	close(context_ex->context.async_fd);
+	if (context_ex->context.async_fd != -1)
+		close(context_ex->context.async_fd);
 	ibverbs_device_put(context_ex->context.device);
 }
 
-- 
1.8.3.1

