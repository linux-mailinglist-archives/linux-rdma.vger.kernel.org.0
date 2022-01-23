Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D75497417
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiAWSDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52074 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiAWSDb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2249DB80DDA;
        Sun, 23 Jan 2022 18:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187E9C340E2;
        Sun, 23 Jan 2022 18:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961008;
        bh=lI838FmR2f2k3MXZiAIFxOgYeQ/mOXEfaXB5OZtWxhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcR155l6KBbxqqAvMjnCA+D1twzvQgpm4+Qh3q3LPyvcPbrjl5Ny5+R3k0KsqBlTP
         3Tc/Oypdsk/jTZAfSnZEFihbrw/36v28AD6tyndPINKdYvtG/oTT093DmZVs6zbsid
         rvDXEebQVgk8VxwXZ5CxIoxXTrOQ5XRJAmuHHjt7CwROgb0aXLAOSaSy42kjMTD+HH
         JY0gH8CdraqGndNNe6QXqHuHe6E86m+Bc/9M8tq+XDY2jAPAIn8oZ5QNLHaTQDJhTQ
         l02diF5qq/bgHWhGRLFAwb8NAc1XwZVjhBX85s8zOOWmWnvJhTaNKeDM6Up6xNDrQp
         Q//9PLpgMoDWQ==
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
Subject: [PATCH rdma-next 06/11] RDMA/qib: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:55 +0200
Message-Id: <72ab68466d1d22846f47ac058e332bbe27ce188b.1642960861.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/qib/qib_fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index a0c5f3bdc324..a973905afd13 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -32,7 +32,6 @@
  * SOFTWARE.
  */
 
-#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/mount.h>
-- 
2.34.1

