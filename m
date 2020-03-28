Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A119642A
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 08:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgC1Has (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 03:30:48 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:25901 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgC1Has (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 03:30:48 -0400
Received: from localhost.localdomain ([90.126.162.40])
        by mwinf5d37 with ME
        id KjWj2200B0scBcy03jWj1E; Sat, 28 Mar 2020 08:30:46 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 28 Mar 2020 08:30:46 +0100
X-ME-IP: 90.126.162.40
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        colin.king@canonical.com, roland@purestorage.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Date:   Sat, 28 Mar 2020 08:30:40 +0100
Message-Id: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is an off-by-one issue when checking if there is enough space in the
output buffer, because we must keep some place for a final '\0'.

While at it:
   - Use 'scnprintf' instead of 'snprintf' in order to avoid a superfluous
    'strlen'
   - avoid some useless initializations
   - avoida hard coded buffer size that can be computed at built time.

Fixes: a51f06e1679e ("RDMA/ocrdma: Query controller information")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The '\0' comes from memset(..., 0, ...) in all callers.
This could be also avoided if needed.
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index 5f831e3bdbad..614a449e6b87 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -49,13 +49,12 @@ static struct dentry *ocrdma_dbgfs_dir;
 static int ocrdma_add_stat(char *start, char *pcur,
 				char *name, u64 count)
 {
-	char buff[128] = {0};
-	int cpy_len = 0;
+	char buff[128];
+	int cpy_len;
 
-	snprintf(buff, 128, "%s: %llu\n", name, count);
-	cpy_len = strlen(buff);
+	cpy_len = scnprintf(buff, sizeof(buff), "%s: %llu\n", name, count);
 
-	if (pcur + cpy_len > start + OCRDMA_MAX_DBGFS_MEM) {
+	if (pcur + cpy_len >= start + OCRDMA_MAX_DBGFS_MEM) {
 		pr_err("%s: No space in stats buff\n", __func__);
 		return 0;
 	}
-- 
2.20.1

