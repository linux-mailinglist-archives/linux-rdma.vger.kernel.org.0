Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E493D3BA0
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhGWN2g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 09:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235349AbhGWN2g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 09:28:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E47CC60EB1;
        Fri, 23 Jul 2021 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627049349;
        bh=68zAcAPjkp0DE2gBWfd0Jw0YCwzjmxhE7P4xOWuCnPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R38BqQnJVyWk+dbmo1hcqNTW0XPWEYJMmNO2r0zxZYkPw7x6ubPSRn6kaDtiXZ0+4
         rPyhTxnWmSyADM6Gy+lU/9lTFinUj2FQ93fMMv0A3nHxwcSsibZ3mkDf4Fw4p+jXCK
         LCC7+e6XpFdEbnNGJYRkWzOvaoob4vgTGMX4I6AtWWiQAA63mxXrL2NkFdHnCTLHXL
         fhtox2BkgYuMH2f46SVDJ/HcicZQVnx3SJ7qgRtQLci7gk3ezDYPgo44h9294eTzeK
         FXv8bt8co0+WYD5KKvpXApClLs2p8fnrSqulYjM/woEazjy4Xj/Ux5M+w76LAes5j2
         j2I0j6FvMt09A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        "Tatyana E. Nikolova" <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 3/3] RDMA/iwpm: Rely on the upper to ensure that requests are valid
Date:   Fri, 23 Jul 2021 17:08:57 +0300
Message-Id: <a9f05a78f9996bf6ea47099b5e02671bf742f5ab.1627048781.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627048781.git.leonro@nvidia.com>
References: <cover.1627048781.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The iwpw has only one netlink client, which is iw_cm. That client
is registered when the iw_cm module is loaded. The module load is
triggered before any use of EXPORT_SYMBOL or netlink operation and
it ensures that the iwpm is valid.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/iwpm_msg.c  | 34 +----------------------------
 drivers/infiniband/core/iwpm_util.c | 18 ---------------
 drivers/infiniband/core/iwpm_util.h | 17 ---------------
 3 files changed, 1 insertion(+), 68 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 12a9816fc0e2..3c9a9869212b 100644
--- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -69,10 +69,6 @@ int iwpm_register_pid(struct iwpm_dev_data *pm_msg, u8 nl_client)
 	const char *err_str = "";
 	int ret = -EINVAL;
 
-	if (!iwpm_valid_client(nl_client)) {
-		err_str = "Invalid port mapper client";
-		goto pid_query_error;
-	}
 	if (iwpm_check_registration(nl_client, IWPM_REG_VALID) ||
 			iwpm_user_pid == IWPM_PID_UNAVAILABLE)
 		return 0;
@@ -153,10 +149,6 @@ int iwpm_add_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 	const char *err_str = "";
 	int ret = -EINVAL;
 
-	if (!iwpm_valid_client(nl_client)) {
-		err_str = "Invalid port mapper client";
-		goto add_mapping_error;
-	}
 	if (!iwpm_valid_pid())
 		return 0;
 	if (!iwpm_check_registration(nl_client, IWPM_REG_VALID)) {
@@ -240,10 +232,6 @@ int iwpm_add_and_query_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 	const char *err_str = "";
 	int ret = -EINVAL;
 
-	if (!iwpm_valid_client(nl_client)) {
-		err_str = "Invalid port mapper client";
-		goto query_mapping_error;
-	}
 	if (!iwpm_valid_pid())
 		return 0;
 	if (!iwpm_check_registration(nl_client, IWPM_REG_VALID)) {
@@ -331,10 +319,6 @@ int iwpm_remove_mapping(struct sockaddr_storage *local_addr, u8 nl_client)
 	const char *err_str = "";
 	int ret = -EINVAL;
 
-	if (!iwpm_valid_client(nl_client)) {
-		err_str = "Invalid port mapper client";
-		goto remove_mapping_error;
-	}
 	if (!iwpm_valid_pid())
 		return 0;
 	if (iwpm_check_registration(nl_client, IWPM_REG_UNDEF)) {
@@ -444,8 +428,7 @@ int iwpm_register_pid_cb(struct sk_buff *skb, struct netlink_callback *cb)
 	atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
 	pr_debug("%s: iWarp Port Mapper (pid = %d) is available!\n",
 			__func__, iwpm_user_pid);
-	if (iwpm_valid_client(nl_client))
-		iwpm_set_registration(nl_client, IWPM_REG_VALID);
+	iwpm_set_registration(nl_client, IWPM_REG_VALID);
 register_pid_response_exit:
 	nlmsg_request->request_done = 1;
 	/* always for found nlmsg_request */
@@ -649,11 +632,6 @@ int iwpm_remote_info_cb(struct sk_buff *skb, struct netlink_callback *cb)
 		return ret;
 
 	nl_client = RDMA_NL_GET_CLIENT(cb->nlh->nlmsg_type);
-	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid port mapper client = %u\n",
-				__func__, nl_client);
-		return ret;
-	}
 	atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
 
 	local_sockaddr = (struct sockaddr_storage *)
@@ -736,11 +714,6 @@ int iwpm_mapping_info_cb(struct sk_buff *skb, struct netlink_callback *cb)
 		return ret;
 	}
 	nl_client = RDMA_NL_GET_CLIENT(cb->nlh->nlmsg_type);
-	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid port mapper client = %u\n",
-				__func__, nl_client);
-		return ret;
-	}
 	iwpm_set_registration(nl_client, IWPM_REG_INCOMPL);
 	atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
 	iwpm_user_pid = cb->nlh->nlmsg_pid;
@@ -863,11 +836,6 @@ int iwpm_hello_cb(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	abi_version = nla_get_u16(nltb[IWPM_NLA_HELLO_ABI_VERSION]);
 	nl_client = RDMA_NL_GET_CLIENT(cb->nlh->nlmsg_type);
-	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid port mapper client = %u\n",
-				__func__, nl_client);
-		return ret;
-	}
 	iwpm_set_registration(nl_client, IWPM_REG_INCOMPL);
 	atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
 	iwpm_ulib_version = min_t(u16, IWPM_UABI_VERSION, abi_version);
diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 45e9aa503a44..54f4feb604d8 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -70,7 +70,6 @@ int iwpm_init(u8 nl_client)
 		return -ENOMEM;
 	}
 
-	iwpm_set_valid(nl_client, 1);
 	iwpm_set_registration(nl_client, IWPM_REG_UNDEF);
 	pr_debug("%s: Mapinfo and reminfo tables are created\n", __func__);
 	return 0;
@@ -90,7 +89,6 @@ int iwpm_exit(u8 nl_client)
 	free_hash_bucket();
 	free_reminfo_bucket();
 	pr_debug("%s: Resources are destroyed\n", __func__);
-	iwpm_set_valid(nl_client, 0);
 	iwpm_set_registration(nl_client, IWPM_REG_UNDEF);
 	return 0;
 }
@@ -115,8 +113,6 @@ int iwpm_create_mapinfo(struct sockaddr_storage *local_sockaddr,
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (!iwpm_valid_client(nl_client))
-		return ret;
 	map_info = kzalloc(sizeof(struct iwpm_mapping_info), GFP_KERNEL);
 	if (!map_info)
 		return -ENOMEM;
@@ -276,10 +272,6 @@ int iwpm_get_remote_info(struct sockaddr_storage *mapped_loc_addr,
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (!iwpm_valid_client(nl_client)) {
-		pr_info("%s: Invalid client = %u\n", __func__, nl_client);
-		return ret;
-	}
 	spin_lock_irqsave(&iwpm_reminfo_lock, flags);
 	if (iwpm_reminfo_bucket) {
 		hash_bucket_head = get_reminfo_hash_bucket(
@@ -394,16 +386,6 @@ int iwpm_get_nlmsg_seq(void)
 	return atomic_inc_return(&iwpm_admin.nlmsg_seq);
 }
 
-int iwpm_valid_client(u8 nl_client)
-{
-	return iwpm_admin.client_list[nl_client];
-}
-
-void iwpm_set_valid(u8 nl_client, int valid)
-{
-	iwpm_admin.client_list[nl_client] = valid;
-}
-
 /* valid client */
 u32 iwpm_get_registration(u8 nl_client)
 {
diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index e2eacc017078..3a42ad43056e 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -91,7 +91,6 @@ struct iwpm_remote_info {
 
 struct iwpm_admin_data {
 	atomic_t nlmsg_seq;
-	int      client_list[RDMA_NL_NUM_CLIENTS];
 	u32      reg_list[RDMA_NL_NUM_CLIENTS];
 };
 
@@ -146,22 +145,6 @@ int iwpm_get_nlmsg_seq(void);
  */
 void iwpm_add_remote_info(struct iwpm_remote_info *reminfo);
 
-/**
- * iwpm_valid_client - Check if the port mapper client is valid
- * @nl_client: The index of the netlink client
- *
- * Valid clients need to call iwpm_init() before using
- * the port mapper
- */
-int iwpm_valid_client(u8 nl_client);
-
-/**
- * iwpm_set_valid - Set the port mapper client to valid or not
- * @nl_client: The index of the netlink client
- * @valid: 1 if valid or 0 if invalid
- */
-void iwpm_set_valid(u8 nl_client, int valid);
-
 /**
  * iwpm_check_registration - Check if the client registration
  *			      matches the given one
-- 
2.31.1

