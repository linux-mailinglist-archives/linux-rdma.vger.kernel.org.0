Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F36B4D3CA
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfFTQaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:30:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfFTQaf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:30:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AF1781DF6;
        Thu, 20 Jun 2019 16:30:29 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CDC460A97;
        Thu, 20 Jun 2019 16:30:28 +0000 (UTC)
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, jgg@ziepe.ca, leon@kernel.org
Subject: [PATCH v2 2/2] RDMA/netlink: Audit policy settings for netlink attributes
Date:   Thu, 20 Jun 2019 12:30:17 -0400
Message-Id: <b77fa93a0a34dc0ae40bdbac83ea419a0d8879ff.1561048044.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 16:30:34 +0000 (UTC)
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
 drivers/infiniband/core/nldev.c  | 37 ++++++++++++++++++--------------
 include/rdma/rdma_netlink.h      |  5 +++++
 include/uapi/rdma/rdma_netlink.h |  4 ----
 3 files changed, 26 insertions(+), 20 deletions(-)

v0->v1: Remove all whitespace change noise from this patch, this patch
is now all functional changes
v1->v2: Instead of ignoring string overruns, return -EINVAL on string
buffer overruns (JGunthorpe requested behavior)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 6006d23d0410..68eb7e05104f 100644
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
@@ -700,8 +700,9 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
 		char name[IB_DEVICE_NAME_MAX] = {};
 
-		nla_strlcpy(name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
-			    IB_DEVICE_NAME_MAX);
+		if (nla_strlcpy(name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
+				sizeof(name)) >= sizeof(name))
+			return -EINVAL;
 		err = ib_device_rename(device, name);
 		goto done;
 	}
@@ -1300,14 +1301,18 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	    !tb[RDMA_NLDEV_ATTR_LINK_TYPE] || !tb[RDMA_NLDEV_ATTR_NDEV_NAME])
 		return -EINVAL;
 
-	nla_strlcpy(ibdev_name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
-		    sizeof(ibdev_name));
+	if (nla_strlcpy(ibdev_name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
+			sizeof(ibdev_name)) >= sizeof(ibdev_name))
+		return -EINVAL;
 	if (strchr(ibdev_name, '%'))
 		return -EINVAL;
 
-	nla_strlcpy(type, tb[RDMA_NLDEV_ATTR_LINK_TYPE], sizeof(type));
-	nla_strlcpy(ndev_name, tb[RDMA_NLDEV_ATTR_NDEV_NAME],
-		    sizeof(ndev_name));
+	if (nla_strlcpy(type, tb[RDMA_NLDEV_ATTR_LINK_TYPE],
+			sizeof(type)) >= sizeof(type))
+		return -EINVAL;
+	if (nla_strlcpy(ndev_name, tb[RDMA_NLDEV_ATTR_NDEV_NAME],
+			sizeof(ndev_name)) >= sizeof(ndev_name))
+		return -EINVAL;
 
 	ndev = dev_get_by_name(&init_net, ndev_name);
 	if (!ndev)
diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
index c7acbe083428..2cac22e2f34a 100644
--- a/include/rdma/rdma_netlink.h
+++ b/include/rdma/rdma_netlink.h
@@ -6,6 +6,11 @@
 #include <linux/netlink.h>
 #include <uapi/rdma/rdma_netlink.h>
 
+enum {
+	RDMA_NLDEV_ATTR_EMPTY_STRING = 1,
+	RDMA_NLDEV_ATTR_ENTRY_STRLEN = 16,
+};
+
 struct rdma_nl_cbs {
 	int (*doit)(struct sk_buff *skb, struct nlmsghdr *nlh,
 		    struct netlink_ext_ack *extack);
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index b27c02185dcc..650cee8c4bf1 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -284,10 +284,6 @@ enum rdma_nldev_command {
 	RDMA_NLDEV_NUM_OPS
 };
 
-enum {
-	RDMA_NLDEV_ATTR_ENTRY_STRLEN = 16,
-};
-
 enum rdma_nldev_print_type {
 	RDMA_NLDEV_PRINT_TYPE_UNSPEC,
 	RDMA_NLDEV_PRINT_TYPE_HEX,
-- 
2.21.0

