Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AE417F34A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCJJRB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgCJJRB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:17:01 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49899208E4;
        Tue, 10 Mar 2020 09:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583831820;
        bh=yrXUJnsVHH/HE0/p9h6u7VIhO+sBG7cR3x6BPXno/Os=;
        h=From:To:Cc:Subject:Date:From;
        b=ZeKkpDw1vc2CAWTmbpq4ojgMQjq07MyLxGjmIPspddI1h6ugSJZcTW/y/XVHRnxNr
         Zf85beuMZODkAl/VHXgtI/Ub4gZ0jC/j6zfNXBtoyvexWLZ/seikTWEq8m2SquWZJS
         HCdljHk7D6qBv+x5L5K01s5+d0ZYOrhj7lI84jV0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Remove the duplicate header file
Date:   Tue, 10 Mar 2020 11:16:56 +0200
Message-Id: <20200310091656.249696-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjunz@mellanox.com>

The header file rdma_core.h is duplicate, so let's remove it.

Fixes: 622db5b6439a ("RDMA/core: Add trace points to follow MR allocation")
Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 1d94c3894b55..f4d18c18cb0c 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -55,8 +55,6 @@
 #include "core_priv.h"
 #include <trace/events/rdma_core.h>

-#include <trace/events/rdma_core.h>
-
 static int ib_resolve_eth_dmac(struct ib_device *device,
 			       struct rdma_ah_attr *ah_attr);

--
2.24.1

