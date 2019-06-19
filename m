Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E55C4BC9E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfFSPQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 11:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFSPQV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 11:16:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10C5790916
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 15:16:21 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 850065C225;
        Wed, 19 Jun 2019 15:16:20 +0000 (UTC)
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>
Subject: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink attributes
Date:   Wed, 19 Jun 2019 11:16:12 -0400
Message-Id: <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
In-Reply-To: <cover.1560957168.git.dledford@redhat.com>
References: <cover.1560957168.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 19 Jun 2019 15:16:21 +0000 (UTC)
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

Also while there, make sure the existing entries that are valid have the
correct policy, if not, correct the policy.  Remove unnecessary checks
for nla_strlcpy() overflow once the policy has been set correctly.

Signed-off-by: Doug Ledford <dledford@redhat.com>
---
 drivers/infiniband/core/nldev.c  | 24 +++++++++++-------------
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 12 insertions(+), 13 deletions(-)

v0->v1: Remove all whitespace change noise from this patch, this patch
is now all functional changes

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 6006d23d0410..291d13642fcf 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -49,29 +49,29 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_CHARDEV]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_CHARDEV_ABI]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_CHARDEV_NAME]		= { .type = NLA_NUL_STRING,
-					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type = NLA_NUL_STRING,
-					.len = 128 },
+					.len = IB_DEVICE_NAME_MAX },
 	[RDMA_NLDEV_ATTR_DEV_INDEX]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_DEV_NAME]		= { .type = NLA_NUL_STRING,
-					.len = IB_DEVICE_NAME_MAX - 1},
+					.len = IB_DEVICE_NAME_MAX },
 	[RDMA_NLDEV_ATTR_DEV_NODE_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type = NLA_NUL_STRING,
-					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_DRIVER]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_DRIVER_ENTRY]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_DRIVER_PRINT_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DRIVER_STRING]		= { .type = NLA_NUL_STRING,
-					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_DRIVER_S32]		= { .type = NLA_S32 },
 	[RDMA_NLDEV_ATTR_DRIVER_S64]		= { .type = NLA_S64 },
 	[RDMA_NLDEV_ATTR_DRIVER_U32]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_DRIVER_U64]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FW_VERSION]		= { .type = NLA_NUL_STRING,
-					.len = IB_FW_VERSION_NAME_MAX - 1},
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_LID]			= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_LINK_TYPE]		= { .type = NLA_NUL_STRING,
-					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
+					.len = IFNAMSIZ },
 	[RDMA_NLDEV_ATTR_LMC]			= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_NDEV_INDEX]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_NDEV_NAME]		= { .type = NLA_NUL_STRING,
@@ -92,7 +92,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 			.len = sizeof(struct __kernel_sockaddr_storage) },
 	[RDMA_NLDEV_ATTR_RES_IOVA]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_RES_KERN_NAME]		= { .type = NLA_NUL_STRING,
-					.len = TASK_COMM_LEN },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_RES_LKEY]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_LQPN]		= { .type = NLA_U32 },
@@ -120,7 +120,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY]	= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_NAME]= { .type = NLA_NUL_STRING,
-					.len = 16 },
+					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_RES_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY]= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_USECNT]		= { .type = NLA_U64 },
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

