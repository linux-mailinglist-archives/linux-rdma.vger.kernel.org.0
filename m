Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C583E1C6D56
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgEFJmD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:42:03 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55214 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729193AbgEFJmD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:42:03 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469g07D015441;
        Wed, 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0Gk024587;
        Wed, 6 May 2020 12:42:00 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469g07J024586;
        Wed, 6 May 2020 12:42:00 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 2/8] verbs: Extend CQ KABI to get an async FD
Date:   Wed,  6 May 2020 12:41:03 +0300
Message-Id: <1588758069-24464-3-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend CQ KABI to get an async FD for the given CQ.
For now this attribute is optional, down the road this may become
mandatory in few cases. (e.g. secondary process).

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/cmd_cq.c       | 7 +++++--
 libibverbs/cmd_fallback.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/libibverbs/cmd_cq.c b/libibverbs/cmd_cq.c
index 542daa7..65293f6 100644
--- a/libibverbs/cmd_cq.c
+++ b/libibverbs/cmd_cq.c
@@ -31,14 +31,14 @@
  */
 
 #include <infiniband/cmd_write.h>
-
 static int ibv_icmd_create_cq(struct ibv_context *context, int cqe,
 			      struct ibv_comp_channel *channel, int comp_vector,
 			      uint32_t flags, struct ibv_cq *cq,
 			      struct ibv_command_buffer *link)
 {
-	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_CQ, UVERBS_METHOD_CQ_CREATE, 7, link);
+	DECLARE_FBCMD_BUFFER(cmdb, UVERBS_OBJECT_CQ, UVERBS_METHOD_CQ_CREATE, 8, link);
 	struct ib_uverbs_attr *handle;
+	struct ib_uverbs_attr *async_fd_attr;
 	uint32_t resp_cqe;
 	int ret;
 
@@ -52,6 +52,9 @@ static int ibv_icmd_create_cq(struct ibv_context *context, int cqe,
 	if (channel)
 		fill_attr_in_fd(cmdb, UVERBS_ATTR_CREATE_CQ_COMP_CHANNEL, channel->fd);
 	fill_attr_in_uint32(cmdb, UVERBS_ATTR_CREATE_CQ_COMP_VECTOR, comp_vector);
+	async_fd_attr = fill_attr_in_fd(cmdb, UVERBS_ATTR_CREATE_CQ_EVENT_FD, context->async_fd);
+	/* Prevent fallback to the 'write' mode if kernel doesn't support it */
+	attr_optional(async_fd_attr);
 
 	if (flags) {
 		fallback_require_ex(cmdb);
diff --git a/libibverbs/cmd_fallback.c b/libibverbs/cmd_fallback.c
index 46c09f3..ee18217 100644
--- a/libibverbs/cmd_fallback.c
+++ b/libibverbs/cmd_fallback.c
@@ -104,7 +104,7 @@ enum write_fallback _execute_ioctl_fallback(struct ibv_context *ctx,
 	if (*ret == EPROTONOSUPPORT) {
 		/*
 		 * EPROTONOSUPPORT means we have the ioctl framework but this
-		 * specific method is not supported
+		 * specific method or a mandatory attribute is not supported
 		 */
 		bitmap_set_bit(priv->unsupported_ioctls, cmd_bit);
 		return _check_legacy(cmdb, ret);
-- 
1.8.3.1

