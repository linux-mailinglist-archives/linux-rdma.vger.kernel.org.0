Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D216994A8
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 13:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBPMoz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 07:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjBPMow (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 07:44:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718D1712;
        Thu, 16 Feb 2023 04:44:50 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHZNb17HVzGpTj;
        Thu, 16 Feb 2023 20:42:55 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Feb
 2023 20:44:43 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
Subject: [PATCH 4.19 v2 1/5] IB/core: Don't register each MAD agent for LSM notifier
Date:   Thu, 16 Feb 2023 20:42:23 +0800
Message-ID: <20230216124227.44058-2-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230216124227.44058-1-guozihua@huawei.com>
References: <20230216124227.44058-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Daniel Jurgens <danielj@mellanox.com>

[ Upstream commit c66f67414c1f88554485bb2a0abf8b5c0d741de7 ]

When creating many MAD agents in a short period of time, receive packet
processing can be delayed long enough to cause timeouts while new agents
are being added to the atomic notifier chain with IRQs disabled.  Notifier
chain registration and unregstration is an O(n) operation. With large
numbers of MAD agents being created and destroyed simultaneously the CPUs
spend too much time with interrupts disabled.

Instead of each MAD agent registering for it's own LSM notification,
maintain a list of agents internally and register once, this registration
already existed for handling the PKeys. This list is write mostly, so a
normal spin lock is used vs a read/write lock. All MAD agents must be
checked, so a single list is used instead of breaking them down per
device.

Notifier calls are done under rcu_read_lock, so there isn't a risk of
similar packet timeouts while checking the MAD agents security settings
when notified.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 drivers/infiniband/core/core_priv.h |  5 +++
 drivers/infiniband/core/device.c    |  1 +
 drivers/infiniband/core/security.c  | 51 ++++++++++++++++-------------
 include/rdma/ib_mad.h               |  3 +-
 4 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 77c7005c396c..8fd8a822d9b6 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -227,6 +227,7 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 				enum ib_qp_type qp_type);
 void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent);
 int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index);
+void ib_mad_agent_security_change(void);
 #else
 static inline void ib_security_destroy_port_pkey_list(struct ib_device *device)
 {
@@ -292,6 +293,10 @@ static inline int ib_mad_enforce_security(struct ib_mad_agent_private *map,
 {
 	return 0;
 }
+
+static inline void ib_mad_agent_security_change(void)
+{
+}
 #endif
 
 struct ib_device *ib_device_get_by_index(u32 ifindex);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ffd0f43e2129..9740614a108d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -417,6 +417,7 @@ static int ib_security_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	schedule_work(&ib_policy_change_work);
+	ib_mad_agent_security_change();
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 6df6cc55fd16..166a4ef9dce0 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -39,6 +39,10 @@
 #include "core_priv.h"
 #include "mad_priv.h"
 
+static LIST_HEAD(mad_agent_list);
+/* Lock to protect mad_agent_list */
+static DEFINE_SPINLOCK(mad_agent_list_lock);
+
 static struct pkey_index_qp_list *get_pkey_idx_qp_list(struct ib_port_pkey *pp)
 {
 	struct pkey_index_qp_list *pkey = NULL;
@@ -669,20 +673,18 @@ static int ib_security_pkey_access(struct ib_device *dev,
 	return security_ib_pkey_access(sec, subnet_prefix, pkey);
 }
 
-static int ib_mad_agent_security_change(struct notifier_block *nb,
-					unsigned long event,
-					void *data)
+void ib_mad_agent_security_change(void)
 {
-	struct ib_mad_agent *ag = container_of(nb, struct ib_mad_agent, lsm_nb);
-
-	if (event != LSM_POLICY_CHANGE)
-		return NOTIFY_DONE;
-
-	ag->smp_allowed = !security_ib_endport_manage_subnet(ag->security,
-							     ag->device->name,
-							     ag->port_num);
-
-	return NOTIFY_OK;
+	struct ib_mad_agent *ag;
+
+	spin_lock(&mad_agent_list_lock);
+	list_for_each_entry(ag,
+			    &mad_agent_list,
+			    mad_agent_sec_list)
+		WRITE_ONCE(ag->smp_allowed,
+			   !security_ib_endport_manage_subnet(ag->security,
+				ag->device->name, ag->port_num));
+	spin_unlock(&mad_agent_list_lock);
 }
 
 int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
@@ -693,6 +695,8 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (!rdma_protocol_ib(agent->device, agent->port_num))
 		return 0;
 
+	INIT_LIST_HEAD(&agent->mad_agent_sec_list);
+
 	ret = security_ib_alloc_security(&agent->security);
 	if (ret)
 		return ret;
@@ -700,22 +704,20 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (qp_type != IB_QPT_SMI)
 		return 0;
 
+	spin_lock(&mad_agent_list_lock);
 	ret = security_ib_endport_manage_subnet(agent->security,
 						agent->device->name,
 						agent->port_num);
 	if (ret)
 		goto free_security;
 
-	agent->lsm_nb.notifier_call = ib_mad_agent_security_change;
-	ret = register_lsm_notifier(&agent->lsm_nb);
-	if (ret)
-		goto free_security;
-
-	agent->smp_allowed = true;
-	agent->lsm_nb_reg = true;
+	WRITE_ONCE(agent->smp_allowed, true);
+	list_add(&agent->mad_agent_sec_list, &mad_agent_list);
+	spin_unlock(&mad_agent_list_lock);
 	return 0;
 
 free_security:
+	spin_unlock(&mad_agent_list_lock);
 	security_ib_free_security(agent->security);
 	return ret;
 }
@@ -725,8 +727,11 @@ void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
 	if (!rdma_protocol_ib(agent->device, agent->port_num))
 		return;
 
-	if (agent->lsm_nb_reg)
-		unregister_lsm_notifier(&agent->lsm_nb);
+	if (agent->qp->qp_type == IB_QPT_SMI) {
+		spin_lock(&mad_agent_list_lock);
+		list_del(&agent->mad_agent_sec_list);
+		spin_unlock(&mad_agent_list_lock);
+	}
 
 	security_ib_free_security(agent->security);
 }
@@ -737,7 +742,7 @@ int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
 		return 0;
 
 	if (map->agent.qp->qp_type == IB_QPT_SMI) {
-		if (!map->agent.smp_allowed)
+		if (!READ_ONCE(map->agent.smp_allowed))
 			return -EACCES;
 		return 0;
 	}
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index f6ba366051c7..69b838afe2cf 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -610,8 +610,7 @@ struct ib_mad_agent {
 	u8			rmpp_version;
 	void			*security;
 	bool			smp_allowed;
-	bool			lsm_nb_reg;
-	struct notifier_block   lsm_nb;
+	struct list_head	mad_agent_sec_list;
 };
 
 /**
-- 
2.17.1

