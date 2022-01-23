Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC57649740F
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiAWSDR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiAWSDQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A91C06173B;
        Sun, 23 Jan 2022 10:03:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A992C60FD1;
        Sun, 23 Jan 2022 18:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D05C340E2;
        Sun, 23 Jan 2022 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642960995;
        bh=86POtQeJX0ykzFw6y5QfLxucOrXxGBGP/egs8OMW4g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9dAXoYSnqiD9iYxIoaHAOojQdA3po1ZZHK05uIbfgO+gi8nmSgbYmtRP0N6xTeLp
         UhCoYObfPhdtnsWAf9CWqeK0BLbuI5rKq3I/DCWMtJABRLJwYqxKFELgefiXUwDCDv
         Kdlnm/M1tIOQGprq/JkUyXPe0X1xUyUtkSQSzfpmdIxVjy9UzJFInZRJ1gEIkSRy5v
         q3cUxD4oYi4KRDzd+/g8zepNjqkEpBNoxSmlcgRLc5NgTj8tQ8/K5EPWBbWU5mIFlB
         Bhh0292UOfNZHb3MPqsV5sisixcAFNrC+4xIL61PUBE4921EKm4qf5uINWd7EHA+lu
         xLi1BOYmq8PJA==
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
Subject: [PATCH rdma-next 03/11] RDMA/hfi1: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:52 +0200
Message-Id: <c53a257079bc93dac036155b793073939d17ddba.1642960861.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/hfi1/affinity.c | 1 -
 drivers/infiniband/hw/hfi1/debugfs.c  | 1 -
 drivers/infiniband/hw/hfi1/device.c   | 1 -
 drivers/infiniband/hw/hfi1/fault.c    | 1 -
 drivers/infiniband/hw/hfi1/firmware.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 98c813ba4304..706b3b659713 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -5,7 +5,6 @@
 
 #include <linux/topology.h>
 #include <linux/cpumask.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/numa.h>
 
diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index 22a3cdb940be..80ba1e53c068 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -7,7 +7,6 @@
 #include <linux/seq_file.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
-#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ratelimit.h>
diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index 68a184c39941..8ceff7141baf 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/cdev.h>
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index e2e4f9f6fae2..3af77a0840ab 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -6,7 +6,6 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/bitmap.h>
 
diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
index 31e63e245ea9..aa15a5cc7cf3 100644
--- a/drivers/infiniband/hw/hfi1/firmware.c
+++ b/drivers/infiniband/hw/hfi1/firmware.c
@@ -5,7 +5,6 @@
 
 #include <linux/firmware.h>
 #include <linux/mutex.h>
-#include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/crc32.h>
 
-- 
2.34.1

