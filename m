Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A885E8DA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 18:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCQ1t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 12:27:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37084 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCQ1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 12:27:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so1520802plb.4;
        Wed, 03 Jul 2019 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i806vjTPab+S1IW/T0fDaHWxtMiFfg783wFw+mYhfTg=;
        b=u2IC40lD2iWRDsl0qkacPje1ZsmhEoaXEJW/7RCMyaT51GhNlvrA5DGLye0Vw26t1r
         LrpxgpwK+YPAoTawhtHIxc29m7VzkKBJiSRbpjRiAcOtyGLmRd4CAeiuJBJi/jAoZ/LF
         XL13Dfjon1vnhzQv/CTXuEEGohMJRV5rkZlH2Ktnoc93cPSmXlysJMYGJnPEPZiU4x8m
         t5vFRo6BzkNjvfSMRrIz3CKS7dUVpiL+CmlDwD5uNElqhmJJtqXpQkg5gD5eJoICIURY
         wTwoOpCqO3Ev6Y+boF/rYXjemfKajMAF/Ns03Ij2zPeJQg1TdO9rt3kqwxtmRHuW/2lb
         72Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i806vjTPab+S1IW/T0fDaHWxtMiFfg783wFw+mYhfTg=;
        b=ZWajGiYOu0Bua388NsSecg89z7cLB65wEUP0G5GAriT3dSPfDciR+3Kp9YzKIKTW/a
         KBu5P3NdjmINujHKkRKqb7PQATL3GphJltCYhvFh277h+T5WSWnI/QDypfZbVuKXfy4p
         4Fkpj+AcvNPzOmqr+967aOQ8eS7MdTv8HPiHmdSYfgPzlfQRhHrkwBW4DLyahPyuZxQ8
         fwNIAfGMcC7PkFOz4zenQmCVG12m0xuZZrxcG30R/VNKMbNHCzfBUyrtTHIFeE/i1Nq7
         TMwtYThod8/jKfEfXHIOxPtHUuVEyX1QilWI1fdi1t5gTkH30p69E2criobpi8GJOggN
         EAAQ==
X-Gm-Message-State: APjAAAUcStf9+5y30V3Dg7ulRk/mX7Frma8M2GTjVFdjqViMy5aXp/uo
        esrmRi4WNxggxIxpHJDMAJo=
X-Google-Smtp-Source: APXvYqxm13u/JNmjt8siHF2rlzRa/6WlAd+F/Usyk97ToBj2tGUSL7hP0XRiIXjyg5ueq7YiukHYIQ==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22mr22871987pll.39.1562171268989;
        Wed, 03 Jul 2019 09:27:48 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t26sm2453818pgu.43.2019.07.03.09.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:27:48 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 09/35] infiniband: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:27:42 +0800
Message-Id: <20190703162742.32276-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

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

