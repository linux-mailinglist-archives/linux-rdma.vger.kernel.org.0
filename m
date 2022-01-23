Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6043497418
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiAWSDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiAWSDe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB6C06173D;
        Sun, 23 Jan 2022 10:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56306102E;
        Sun, 23 Jan 2022 18:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D4C340E2;
        Sun, 23 Jan 2022 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961013;
        bh=FMuYNuowONsnIt2W6ZV3gvRRCcozA1FrcnvwFn66ruA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZf28lJxxFT4zybB/O37c9GQ45NfNrlFMCJd0J3lGjUSek/AqpMG4UsxUlUMxxZR5
         ZXhajFhvQdRjFnjkwRIcGgARBfJjsswpKV3NBnGWSkpxCsjfeWLjOG6K6mPiXFnGkR
         s0B4Cmw/oQtZv//MYCxePkf9P1OXt5QwyMgyWySUIKPSou/VEQ/tBqDYAh2NZEPYo2
         PE5yAXBeTTxyro3BPjIC+vw92SdQqXneclSfHX7VzIn78kJ54HxlEBhZPsZCUH7N6a
         kgro1U0f1uyNjkyLuCX3OxMg4mtkQqHWqGtW/TPHhT3Vx8L2wbc0M3/xkAX83akADr
         sAH7O3G5ieG/g==
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
Subject: [PATCH rdma-next 04/11] RDMA/mlx4: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:53 +0200
Message-Id: <fa91416f41e195f072fcdb8ad0ea085cee006502.1642960861.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/mlx4/alias_GUID.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index e2e1f5daddc4..111fa88a3be4 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -38,7 +38,6 @@
 #include <rdma/ib_sa.h>
 #include <rdma/ib_pack.h>
 #include <linux/mlx4/cmd.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <rdma/ib_user_verbs.h>
-- 
2.34.1

