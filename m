Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5574C7BD8E4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbjJIKoI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 06:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbjJIKoH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 06:44:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986659C
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 03:44:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF26C433C8;
        Mon,  9 Oct 2023 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696848245;
        bh=nB9+lN5LiUiBtg5NCgculClFjahKEsBw9fSdq0VElxM=;
        h=From:To:Cc:Subject:Date:From;
        b=tnT7eBAjyGzL5yZzwdkgTv70UtnLK1kT1dWCxvVMIebTMM7z+i1Cvu3FTGIk6erPS
         EwXdhkRarIHZRu23lTqNuc8LmlS5vpo7zo+KntF+IAtIPajtDUxhg8YUDYr7igQlTg
         0rvARxANEpbPDfrKUhuwD8m4SHaGwV8wf3vq+bl2A14Hn1VzNefOoIukqpxSNPKeKM
         Tiujrns4RBiNvaRG7muo/HT8d+OrfwrgFIkRcZmVhANbKLDAMW2U6QurHzJlhyMJw/
         FXAQUnCLmE0gXDf2ll3cv6WVYl0QTh+O+UMBMg69gBn2TGyaJTX8Gtylz2jsqWLC1m
         ZmN1jCM2ThWJA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Add support to set privileged QKEY parameter
Date:   Mon,  9 Oct 2023 13:43:58 +0300
Message-ID: <90398be70a9d23d2aa9d0f9fd11d2c264c1be534.1696848201.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Add netlink command that enables/disables privileged QKEY by default.

It is disabled by default, since according to IB spec only privileged
users are allowed to use privileged QKEY.
According to the IB specification rel-1.6, section 3.5.3:
"QKEYs with the most significant bit set are considered controlled
QKEYs, and a HCA does not allow a consumer to arbitrarily specify a
controlled QKEY."

Using rdma tool,
$rdma system set privileged-qkey on

When enabled non-privileged users would be able to use
controlled QKEYs which are considered privileged.

Using rdma tool,
$rdma system set privileged-qkey off

When disabled only privileged users would be able to use
controlled QKEYs.

You can also use the command below to check the parameter state:
$rdma system show
netns shared privileged-qkey off copy-on-fork on

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h  |  1 +
 drivers/infiniband/core/nldev.c      | 63 ++++++++++++++++++++++++----
 drivers/infiniband/core/uverbs_cmd.c |  3 +-
 include/uapi/rdma/rdma_netlink.h     |  2 +
 4 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index f66f48d860ec..dd7715ba9fd1 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -373,4 +373,5 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 
 void ib_cq_pool_cleanup(struct ib_device *dev);
 
+bool rdma_nl_get_privileged_qkey(void);
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 456545007c14..5c805fa6187f 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -43,6 +43,13 @@
 #include "restrack.h"
 #include "uverbs.h"
 
+/*
+ * This determines whether a non-privileged user is allowed to specify a
+ * controlled QKEY or not, when true non-privileged user is allowed to specify
+ * a controlled QKEY.
+ */
+static bool privileged_qkey;
+
 typedef int (*res_fill_func_t)(struct sk_buff*, bool,
 			       struct rdma_restrack_entry*, uint32_t);
 
@@ -156,6 +163,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX]	= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC] = { .type = NLA_U8 },
+	[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE] = { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -237,6 +245,12 @@ int rdma_nl_put_driver_u64_hex(struct sk_buff *msg, const char *name, u64 value)
 }
 EXPORT_SYMBOL(rdma_nl_put_driver_u64_hex);
 
+bool rdma_nl_get_privileged_qkey(void)
+{
+	return privileged_qkey || capable(CAP_NET_RAW);
+}
+EXPORT_SYMBOL(rdma_nl_get_privileged_qkey);
+
 static int fill_nldev_handle(struct sk_buff *msg, struct ib_device *device)
 {
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_DEV_INDEX, device->index))
@@ -1901,6 +1915,12 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return err;
 	}
 
+	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE,
+			 (u8)privileged_qkey);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
 	/*
 	 * Copy-on-fork is supported.
 	 * See commits:
@@ -1917,18 +1937,11 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
 }
 
-static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
-				  struct netlink_ext_ack *extack)
+static int nldev_set_sys_set_netns_doit(struct nlattr *tb[])
 {
-	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	u8 enable;
 	int err;
 
-	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
-			  nldev_policy, extack);
-	if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
-		return -EINVAL;
-
 	enable = nla_get_u8(tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]);
 	/* Only 0 and 1 are supported */
 	if (enable > 1)
@@ -1938,6 +1951,40 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
+static int nldev_set_sys_set_pqkey_doit(struct nlattr *tb[])
+{
+	u8 enable;
+
+	enable = nla_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
+	/* Only 0 and 1 are supported */
+	if (enable > 1)
+		return -EINVAL;
+
+	privileged_qkey = enable;
+	return 0;
+}
+
+static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
+				  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	int err;
+
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			  nldev_policy, extack);
+	if (err)
+		return -EINVAL;
+
+	if (tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
+		return nldev_set_sys_set_netns_doit(tb);
+
+	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE])
+		return nldev_set_sys_set_pqkey_doit(tb);
+
+	return -EINVAL;
+}
+
+
 static int nldev_stat_set_mode_doit(struct sk_buff *msg,
 				    struct netlink_ext_ack *extack,
 				    struct nlattr *tb[],
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index e836c9c477f6..6de05ade2ba9 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1851,7 +1851,8 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 	if (cmd->base.attr_mask & IB_QP_PATH_MIG_STATE)
 		attr->path_mig_state = cmd->base.path_mig_state;
 	if (cmd->base.attr_mask & IB_QP_QKEY) {
-		if (cmd->base.qkey & IB_QP_SET_QKEY && !capable(CAP_NET_RAW)) {
+		if (cmd->base.qkey & IB_QP_SET_QKEY &&
+		    !rdma_nl_get_privileged_qkey()) {
 			ret = -EPERM;
 			goto release_qp;
 		}
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 2830695c3556..723bbb0f7042 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -556,6 +556,8 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX,	/* u32 */
 	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC, /* u8 */
 
+	RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE, /* u8 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.41.0

