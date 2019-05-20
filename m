Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A0F22C5B
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfETGy4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETGy4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:54:56 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF3220856;
        Mon, 20 May 2019 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335295;
        bh=t/rqyWQx710Fxa/L6K0db7/aV9sHl3yWeftyJ0dHmB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgTFlRMPPrISgdCFOjUQC9+lmqjrhfx1iNid95AAk/QGcbE5Z2fpjwWNaeuTbSmKn
         5LewHGrLAzuyMK4BxKK9VlBSisZ+rabJfIJUinL7QstAshRaEfsuKHrTKnApuNTHDO
         F6BH9UEoGbBEIljV4FLZetLWd1VlnrMmNDeabtow=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 05/15] RDMA/nes: Remove useless NULL checks
Date:   Mon, 20 May 2019 09:54:23 +0300
Message-Id: <20190520065433.8734-6-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The destroy functions are always called with relevant structs,
there is no need to check their existence.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/nes/nes_verbs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index ad2b8322cc3f..fb2d0762c7c8 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -1646,9 +1646,6 @@ static int nes_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 	u32 opcode = 0;
 	int ret;
 
-	if (ib_cq == NULL)
-		return 0;
-
 	nescq = to_nescq(ib_cq);
 	nesvnic = to_nesvnic(ib_cq->device);
 	nesdev = nesvnic->nesdev;
@@ -3708,9 +3705,6 @@ void  nes_port_ibevent(struct nes_vnic *nesvnic)
  */
 void nes_destroy_ofa_device(struct nes_ib_device *nesibdev)
 {
-	if (nesibdev == NULL)
-		return;
-
 	nes_unregister_ofa_device(nesibdev);
 
 	ib_dealloc_device(&nesibdev->ibdev);
-- 
2.20.1

