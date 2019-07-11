Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA6F76503C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 04:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfGKCka (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 22:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfGKCk3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 22:40:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C30432F8BDC;
        Thu, 11 Jul 2019 02:40:29 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25FB352FC9;
        Thu, 11 Jul 2019 02:40:28 +0000 (UTC)
From:   Honggang Li <honli@redhat.com>
To:     bvanassche@acm.org
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [rdma-core patch] srp_daemon: improve the debug message for is_enabled_by_rules_file
Date:   Wed, 10 Jul 2019 22:40:01 -0400
Message-Id: <20190711024001.14648-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 11 Jul 2019 02:40:29 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Honggang Li <honli@redhat.com>
---
 srp_daemon/srp_daemon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index a004f6a4..f27dd569 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -349,10 +349,11 @@ static int is_enabled_by_rules_file(struct target_details *target)
 	int rule;
 	struct config_t *conf = config;
 
-	if (NULL == conf->rules)
+	if (NULL == conf->rules) {
+		pr_debug("SRP target with id_ext %s allowed by rules file\n", target->id_ext);
 		return 1;
+	}
 
-	pr_debug("Found an SRP target with id_ext %s - check if it allowed by rules file\n", target->id_ext);
 	rule = -1;
 	do {
 		rule++;
@@ -392,6 +393,9 @@ static int is_enabled_by_rules_file(struct target_details *target)
 
 		target->options = conf->rules[rule].options;
 
+		pr_debug("SRP target with id_ext %s %s by rules file\n",
+				target->id_ext,
+				conf->rules[rule].allow == 1 ? "allowed" : "disallowed");
 		return conf->rules[rule].allow;
 
 	} while (1);
-- 
2.20.1

