Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7534BB23
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFSOSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 10:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54925 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfFSOSr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 10:18:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27F218831C
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 14:18:47 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B0A35D71A;
        Wed, 19 Jun 2019 14:18:46 +0000 (UTC)
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>
Subject: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink attributes
Date:   Wed, 19 Jun 2019 10:18:28 -0400
Message-Id: <d834b82171ab30864fe2de8d022bcf5ed864b163.1560953757.git.dledford@redhat.com>
In-Reply-To: <cover.1560953757.git.dledford@redhat.com>
References: <cover.1560953757.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Jun 2019 14:18:47 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For all string attributes for which we don't currently accept the
element as input, we only use it as output, set the string length to
RDMA_NLDEV_ATTR_EMPTY_STRING which is defined as 1.  That way we will
only accept a null string for that element.  This will prevent someone
from writing a new input routine that uses the element without also
updating the policy to have a valid value.

While we are there, clean up whitespace in the array.

Also while there, make sure the existing entries that are valid have the
correct policy, if not, correct the policy.  Remove unnecessary checks
for nla_strlcpy() overflow once the policy has been set correctly.

Signed-off-by: Doug Ledford <dledford@redhat.com>
---
 drivers/infiniband/core/nldev.c  | 60 +++++++++++++++-----------------
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e1f46fcfce98..c0a0037bd636 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -49,37 +49,37 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_CHARDEV]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_CHARDEV_ABI]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_CHARDEV_NAME]		= { .type = NLA_NUL_STRING,
-				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type = NLA_NUL_STRING,
-				    .len = 128 },
-	[RDMA_NLDEV_ATTR_DEV_INDEX]     = { .type = NLA_U32 },
-	[RDMA_NLDEV_ATTR_DEV_NAME]	= { .type = NLA_NUL_STRING,
-					    .len = IB_DEVICE_NAME_MAX - 1},
-	[RDMA_NLDEV_ATTR_DEV_NODE_TYPE] = { .type = NLA_U8 },
+					.len = IB_DEVICE_NAME_MAX },
+	[RDMA_NLDEV_ATTR_DEV_INDEX]     	= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_DEV_NAME]		= { .type = NLA_NUL_STRING,
+					.len = IB_DEVICE_NAME_MAX },
+	[RDMA_NLDEV_ATTR_DEV_NODE_TYPE] 	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type = NLA_NUL_STRING,
-				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_DRIVER]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_DRIVER_ENTRY]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_DRIVER_PRINT_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DRIVER_STRING]		= { .type = NLA_NUL_STRING,
-				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_DRIVER_S32]		= { .type = NLA_S32 },
 	[RDMA_NLDEV_ATTR_DRIVER_S64]		= { .type = NLA_S64 },
 	[RDMA_NLDEV_ATTR_DRIVER_U32]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_DRIVER_U64]		= { .type = NLA_U64 },
-	[RDMA_NLDEV_ATTR_FW_VERSION]	= { .type = NLA_NUL_STRING,
-					    .len = IB_FW_VERSION_NAME_MAX - 1},
-	[RDMA_NLDEV_ATTR_LID]		= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FW_VERSION]		= { .type = NLA_NUL_STRING,
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
+	[RDMA_NLDEV_ATTR_LID]			= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_LINK_TYPE]		= { .type = NLA_NUL_STRING,
-				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
-	[RDMA_NLDEV_ATTR_LMC]		= { .type = NLA_U8 },
+					.len = IFNAMSIZ },
+	[RDMA_NLDEV_ATTR_LMC]			= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_NDEV_INDEX]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_NDEV_NAME]		= { .type = NLA_NUL_STRING,
-						    .len = IFNAMSIZ },
-	[RDMA_NLDEV_ATTR_NODE_GUID]	= { .type = NLA_U64 },
-	[RDMA_NLDEV_ATTR_PORT_INDEX]	= { .type = NLA_U32 },
-	[RDMA_NLDEV_ATTR_PORT_PHYS_STATE] = { .type = NLA_U8 },
-	[RDMA_NLDEV_ATTR_PORT_STATE]	= { .type = NLA_U8 },
+					.len = IFNAMSIZ },
+	[RDMA_NLDEV_ATTR_NODE_GUID]		= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_PORT_INDEX]		= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_PORT_PHYS_STATE] 	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_PORT_STATE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_RES_CM_ID]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_CM_IDN]            = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_CM_ID_ENTRY]	= { .type = NLA_NESTED },
@@ -88,11 +88,11 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_CQN]               = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_CQ_ENTRY]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_CTXN]              = { .type = NLA_U32 },
-	[RDMA_NLDEV_ATTR_RES_DST_ADDR]	= {
+	[RDMA_NLDEV_ATTR_RES_DST_ADDR]		= {
 			.len = sizeof(struct __kernel_sockaddr_storage) },
 	[RDMA_NLDEV_ATTR_RES_IOVA]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_RES_KERN_NAME]		= { .type = NLA_NUL_STRING,
-						    .len = TASK_COMM_LEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_RES_LKEY]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_LQPN]		= { .type = NLA_U32 },
@@ -100,7 +100,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_MRLEN]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_RES_MRN]               = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_MR_ENTRY]		= { .type = NLA_NESTED },
-	[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE] = { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_RES_PD]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_PDN]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_PD_ENTRY]		= { .type = NLA_NESTED },
@@ -113,20 +113,20 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_RQPN]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_RQ_PSN]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_SQ_PSN]		= { .type = NLA_U32 },
-	[RDMA_NLDEV_ATTR_RES_SRC_ADDR]	= {
+	[RDMA_NLDEV_ATTR_RES_SRC_ADDR]		= {
 			.len = sizeof(struct __kernel_sockaddr_storage) },
 	[RDMA_NLDEV_ATTR_RES_STATE]		= { .type = NLA_U8 },
-	[RDMA_NLDEV_ATTR_RES_SUMMARY]	= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_RES_SUMMARY]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY]	= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR] = { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_NAME] = { .type = NLA_NUL_STRING,
-					     .len = 16 },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_RES_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_USECNT]		= { .type = NLA_U64 },
-	[RDMA_NLDEV_ATTR_SM_LID]	= { .type = NLA_U32 },
-	[RDMA_NLDEV_ATTR_SUBNET_PREFIX]	= { .type = NLA_U64 },
-	[RDMA_NLDEV_ATTR_SYS_IMAGE_GUID] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_SM_LID]		= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_SUBNET_PREFIX]		= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_SYS_IMAGE_GUID] 	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
 	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
@@ -1372,10 +1372,8 @@ static int nldev_get_chardev(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  extack);
 	if (err || !tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE])
 		return -EINVAL;
-
-	if (nla_strlcpy(client_name, tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
-			sizeof(client_name)) >= sizeof(client_name))
-		return -EINVAL;
+	nla_strlcpy(client_name, tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
+		    sizeof(client_name));
 
 	if (tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
 		index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index b27c02185dcc..24ff4ffa30dd 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -285,6 +285,7 @@ enum rdma_nldev_command {
 };
 
 enum {
+	RDMA_NLDEV_ATTR_EMPTY_STRING = 1,
 	RDMA_NLDEV_ATTR_ENTRY_STRLEN = 16,
 };
 
-- 
2.21.0

