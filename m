Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7A6A5425
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Feb 2023 09:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjB1IJK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 03:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjB1IJF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 03:09:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178117CD9;
        Tue, 28 Feb 2023 00:08:56 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PQqhc1ZVvz9tCN;
        Tue, 28 Feb 2023 16:06:56 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Feb
 2023 16:08:40 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
Subject: [PATCH 4.19 v3 4/6] ima: ima/lsm policy rule loading logic bug fixes
Date:   Tue, 28 Feb 2023 16:06:28 +0800
Message-ID: <20230228080630.52370-5-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230228080630.52370-1-guozihua@huawei.com>
References: <20230228080630.52370-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Janne Karhunen <janne.karhunen@gmail.com>

[ Upstream commit 483ec26eed42bf050931d9a5c5f9f0b5f2ad5f3b ]

Keep the ima policy rules around from the beginning even if they appear
invalid at the time of loading, as they may become active after an lsm
policy load.  However, loading a custom IMA policy with unknown LSM
labels is only safe after we have transitioned from the "built-in"
policy rules to a custom IMA policy.

Patch also fixes the rule re-use during the lsm policy reload and makes
some prints a bit more human readable.

Changelog:
v4:
- Do not allow the initial policy load refer to non-existing lsm rules.
v3:
- Fix too wide policy rule matching for non-initialized LSMs
v2:
- Fix log prints

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Cc: Casey Schaufler <casey@schaufler-ca.com>
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_policy.c | 46 +++++++++++++++++------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5a15524bca4c..5256ff008f11 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -264,7 +264,7 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 {
 	struct ima_rule_entry *nentry;
-	int i, result;
+	int i;
 
 	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
 	if (!nentry)
@@ -278,7 +278,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	memset(nentry->lsm, 0, FIELD_SIZEOF(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-		if (!entry->lsm[i].rule)
+		if (!entry->lsm[i].args_p)
 			continue;
 
 		nentry->lsm[i].type = entry->lsm[i].type;
@@ -287,13 +287,13 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 		if (!nentry->lsm[i].args_p)
 			goto out_err;
 
-		result = security_filter_rule_init(nentry->lsm[i].type,
-						   Audit_equal,
-						   nentry->lsm[i].args_p,
-						   &nentry->lsm[i].rule);
-		if (result == -EINVAL)
-			pr_warn("ima: rule for LSM \'%d\' is undefined\n",
-				entry->lsm[i].type);
+		security_filter_rule_init(nentry->lsm[i].type,
+					  Audit_equal,
+					  nentry->lsm[i].args_p,
+					  &nentry->lsm[i].rule);
+		if (!nentry->lsm[i].rule)
+			pr_warn("rule for LSM \'%s\' is undefined\n",
+				(char *)entry->lsm[i].args_p);
 	}
 	return nentry;
 
@@ -332,7 +332,7 @@ static void ima_lsm_update_rules(void)
 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
 		needs_update = 0;
 		for (i = 0; i < MAX_LSM_RULES; i++) {
-			if (entry->lsm[i].rule) {
+			if (entry->lsm[i].args_p) {
 				needs_update = 1;
 				break;
 			}
@@ -342,8 +342,7 @@ static void ima_lsm_update_rules(void)
 
 		result = ima_lsm_update_rule(entry);
 		if (result) {
-			pr_err("ima: lsm rule update error %d\n",
-				result);
+			pr_err("lsm rule update error %d\n", result);
 			return;
 		}
 	}
@@ -360,7 +359,7 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 }
 
 /**
- * ima_match_rules - determine whether an inode matches the measure rule.
+ * ima_match_rules - determine whether an inode matches the policy rule.
  * @rule: a pointer to a rule
  * @inode: a pointer to an inode
  * @cred: a pointer to a credentials structure for user validation
@@ -413,9 +412,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		int rc = 0;
 		u32 osid;
 
-		if (!rule->lsm[i].rule)
-			continue;
-
+		if (!rule->lsm[i].rule) {
+			if (!rule->lsm[i].args_p)
+				continue;
+			else
+				return false;
+		}
 		switch (i) {
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
@@ -733,9 +735,15 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 					   entry->lsm[lsm_rule].args_p,
 					   &entry->lsm[lsm_rule].rule);
 	if (!entry->lsm[lsm_rule].rule) {
-		kfree(entry->lsm[lsm_rule].args_p);
-		entry->lsm[lsm_rule].args_p = NULL;
-		return -EINVAL;
+		pr_warn("rule for LSM \'%s\' is undefined\n",
+			(char *)entry->lsm[lsm_rule].args_p);
+
+		if (ima_rules == &ima_default_rules) {
+			kfree(entry->lsm[lsm_rule].args_p);
+			entry->lsm[lsm_rule].args_p = NULL;
+			result = -EINVAL;
+		} else
+			result = 0;
 	}
 
 	return result;
-- 
2.17.1

