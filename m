Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780386A541E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Feb 2023 09:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjB1IJH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 03:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjB1IJF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 03:09:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40295166EA;
        Tue, 28 Feb 2023 00:08:56 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PQqhb1nrLz9tBj;
        Tue, 28 Feb 2023 16:06:55 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Feb
 2023 16:08:36 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>
Subject: [PATCH 4.19 v3 0/6] Backport handling -ESTALE policy update failure to 4.19
Date:   Tue, 28 Feb 2023 16:06:24 +0800
Message-ID: <20230228080630.52370-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
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

This series backports patches in order to resolve the issue discussed here:
https://lore.kernel.org/selinux/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.com/

This required backporting the non-blocking LSM policy update mechanism
prerequisite patches. As well as bugfixes that follows:

c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
42df744c4166 ("LSM: switch to blocking policy update notifiers")
b16942455193 ("ima: use the lsm policy update notifier")
483ec26eed42 ("ima: ima/lsm policy rule loading logic bug fixes")
e144d6b26541 ("ima: Evaluate error in init_ima()")
c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")

c66f67414c1f ("IB/core: Don't register each MAD agent for LSM notifier")
is merged as the prerequisite of 42df744c4166 ("LSM: switch to blocking
policy update notifiers"). e144d6b26541 ("ima: Evaluate error in
init_ima()"), 483ec26eed42 ("ima: ima/lsm policy rule loading logic bug
fixes") and 9ff8a616dfab ("ima: Have the LSM free its audit rule") are
merged as a follow up bugfix for b16942455193 ("ima: use the lsm policy
update notifier").

I've tested the patches against said issue and can confirm that the
issue is fixed.

Link to the original maillist discussion:
https://lore.kernel.org/all/389334fe-6e12-96b2-6ce9-9f0e8fcb85bf@huawei.com/

Change log:
  v2: Fixed build issue and backport bugfix commits for backported
patches.

Daniel Jurgens (1):
  IB/core: Don't register each MAD agent for LSM notifier

GUO Zihua (1):
  ima: Handle -ESTALE returned by ima_filter_rule_match()

Janne Karhunen (3):
  LSM: switch to blocking policy update notifiers
  ima: use the lsm policy update notifier
  ima: ima/lsm policy rule loading logic bug fixes

Roberto Sassu (1):
  ima: Evaluate error in init_ima()

 drivers/infiniband/core/core_priv.h |   5 +
 drivers/infiniband/core/device.c    |   5 +-
 drivers/infiniband/core/security.c  |  51 +++++----
 include/linux/security.h            |  12 +-
 include/rdma/ib_mad.h               |   3 +-
 security/integrity/ima/ima.h        |   2 +
 security/integrity/ima/ima_main.c   |  11 ++
 security/integrity/ima/ima_policy.c | 172 ++++++++++++++++++++++------
 security/security.c                 |  23 ++--
 security/selinux/hooks.c            |   2 +-
 security/selinux/selinuxfs.c        |   2 +-
 11 files changed, 208 insertions(+), 80 deletions(-)

-- 
2.17.1

