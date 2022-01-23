Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B78497414
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbiAWSDa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiAWSDZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109AC061744;
        Sun, 23 Jan 2022 10:03:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D2F26102C;
        Sun, 23 Jan 2022 18:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D62C340E2;
        Sun, 23 Jan 2022 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961004;
        bh=AAE/ABHEa3gNRJmMyXtjKDEup3ZSg1dcASJxtQPxzgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaXKF4Ut9brJ4VlG5cY0N1yGlB4doymqF80SRmzB4CRkwdKkGvBsQV+48ubG221l8
         MdH+3pHFuHx9y7qV1UJh2U+cgzSe3mXCWI+eJZE1OL+eObY4phqsbW8Bw5bWh5m3w4
         KAWD7H1AQY7dD/MLpOVuuBMAH9QLv6BjHoworcmBISi87SR6VCqVs0QvZMVfGVIXJ/
         wVYC9AosQg97viTSW6klczf8HyqDswXQUVMB1a9krAcQQygdNt7BzpAhVi/6i+daIm
         nJcHenQFD6fcO5fAB4gCpicSLYBvnyv9MJny7aiF4idNaOVW6hemLnwP0DuvA8m+U1
         s9r143VeffVKg==
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
Subject: [PATCH rdma-next 05/11] RDMA/mthca: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:54 +0200
Message-Id: <ab856f40804d67905a655bc85e480d96ff66e46e.1642960861.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642960861.git.leonro@nvidia.com>
References: <cover.1642960861.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in include of module.h in the following file.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mthca/mthca_profile.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_profile.c b/drivers/infiniband/hw/mthca/mthca_profile.c
index 7ea970774839..69af65f1b332 100644
--- a/drivers/infiniband/hw/mthca/mthca_profile.c
+++ b/drivers/infiniband/hw/mthca/mthca_profile.c
@@ -31,8 +31,6 @@
  * SOFTWARE.
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
-- 
2.34.1

