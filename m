Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769555E508
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfGCNOv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 09:14:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38693 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNOv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 09:14:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so1274351pfn.5;
        Wed, 03 Jul 2019 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7faKXePTyX9n7u3+IU0GS1cl0KAQg9+jhqGEuRLn7kA=;
        b=GbvmdOd+++eI6Q7G46/xc4bKU366V6payNkNotvKIk7nQtQbecCNr2EstIvfonu2/z
         ODEt+3XlLPyvad8+C8tDgJDzqOpOzWXQWKIKbSQEBYOsJtC7MFtwfwXCKRRjTjJgj2CJ
         WJ45z2bWWtFAkXMvdvcyWPOV2R6W8rjiD5AEl5oS2nO+3/TQx71TP5jwjdiu8iHQKbut
         dS+C8HLDFMr5XcSZIoYL6jJE3Mks67JpTLq9Yw8ce8eyxax8n6yIuTDVHS/ziLzC+w6g
         X2JzUvDNn2Cc0A7SiLzuUxydCKI908pP0Wl0FQ8tfmtPO99oD+NUxsQR1RJnXSxLdjGF
         XTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7faKXePTyX9n7u3+IU0GS1cl0KAQg9+jhqGEuRLn7kA=;
        b=All/+f4ap1Qa0P+L6bzyDqjutTH0QrUM+j76zFwMAHjsrAIgv+HDclTipitMYsmhvi
         jMxZKcow70o6jSzlQ7FVU4fP35MBIPQFQJKT2jSvxn7bHkwPPYzOCOp0wJoqWlG5c5zY
         J1dNQtpT6aCZ9Krd6ecgCVFQ1P20Rjgp07HxZtPT5fzOamgug6MET+NHcISfyh9+xsnt
         T0/gOQMG+7+ZmP/rV2HGJxVZ29Oe4XCvmwSEwsp86SDn9zPyGhEAzBvLiC7sQms27ykM
         ydIFY3mTXOkfWfL4ZEw8CRr2P3OlHgl0ivNzclA6NgVSKGgT9y7l0/FyDgontjM+l4lO
         yeHg==
X-Gm-Message-State: APjAAAUBpD3kPY3OOJVmox1e7jsryN7Zjz99MEqplPFefM6TNCWkAaU2
        x3MnD9gocO+Tm7JPxZm+Cnw=
X-Google-Smtp-Source: APXvYqxXzEHgAyHBLMfeVoha3TG9Tp77D1Mm4j03yDmWFRWbVqTHD9Cfdw4S2zcHlhqWXefzHkD/Gg==
X-Received: by 2002:a17:90a:3310:: with SMTP id m16mr12581160pjb.7.1562159690476;
        Wed, 03 Jul 2019 06:14:50 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 64sm4121445pfe.128.2019.07.03.06.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:14:50 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 08/30] infiniband: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:14:40 +0800
Message-Id: <20190703131440.25039-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 8233f5a4e623..84b3ff2687fb 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -4276,11 +4276,11 @@ static void i40iw_qhash_ctrl(struct i40iw_device *iwdev,
 	/* if not found then add a child listener if interface is going up */
 	if (!ifup)
 		return;
-	child_listen_node = kzalloc(sizeof(*child_listen_node), GFP_ATOMIC);
+	child_listen_node = kmemdup(parent_listen_node,
+			sizeof(*child_listen_node), GFP_ATOMIC);
 	if (!child_listen_node)
 		return;
 	node_allocated = true;
-	memcpy(child_listen_node, parent_listen_node, sizeof(*child_listen_node));
 
 	memcpy(child_listen_node->loc_addr, ipaddr,  ipv4 ? 4 : 16);
 
-- 
2.11.0

