Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE034497422
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiAWSEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:04:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52340 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiAWSD5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D87B7B80DDA;
        Sun, 23 Jan 2022 18:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEAFC340E2;
        Sun, 23 Jan 2022 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961034;
        bh=1mu/4vMrjjiNbR8uteEGMLqjUpw2L4LTHZ4rvDVw40s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNMOjhPWkg1Ns+6HokQK6Cxn5ziWgQ08MGNO1d/obDF3NQX+a3mD7GNHmXcYOrj/g
         qJMMsz5+rfqGipdYrTrruibHDyCGAziq/1WiiOA4zxQ1YO2iZhpHnDfaAX4WmtCuK0
         iQZEp0saZh37C8LQQInHRiVVT9KsugzwM1KG4efxo+hBT4teN6OTcr04XQf8ELwViW
         3Ft+HWhdYp4PhsN6lJ5rL6dPzlDSeHPurEuvhhPz9PmWtaeLygfFJeLWLJwwOLlORR
         BekG4wQuJG5nmO4AXWwPKqJifJ1wc36e0tyFqb3w4ROStejhC37fK6c0ABFKHe4+Xz
         wpVQpUOpp+u9w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 10/11] RDMA/iser: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:59 +0200
Message-Id: <bdbf940ca5edbbc649153fa15737b779c073c498.1642960861.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642960861.git.leonro@nvidia.com>
References: <cover.1642960861.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in include of module.h in the following files.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_memory.c | 1 -
 drivers/infiniband/ulp/iser/iser_verbs.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 660982625488..f1fd05d8609d 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -30,7 +30,6 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  */
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 8bf87b073d9b..8893bc27d8f5 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -32,7 +32,6 @@
  * SOFTWARE.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 
-- 
2.34.1

