Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE093024D3
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 13:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbhAYMQP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 07:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbhAYMPo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 07:15:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA17322EBD;
        Mon, 25 Jan 2021 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611576829;
        bh=/CON2hpVqugKBbxpJZSqqt+63JfgaQJTc7ojkGR9PFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cA0Ji3V+ngyjlJ8GtwHJnPK8cDM/NdgWbFihaMXPsZKV8EXKSlx0S4oa3wmGPrW8A
         2WZLaac+BxtYB61PefbQocEL34IckgV5+WKEURxSMA8uxL/owYLt3lYUSs1QSOz/HX
         3zxs3Cm1qtn3yOFfDvSnVuMv2kHpKon8zSFMrEOjx1VDbgcPdXDdHIEskmVfT+PTnt
         SaRWIKk453tXxVQ6HUeaLCuARgT513qZpJlMaeTDUOQJHskpSa+CYYVmddz+n0UcvU
         FSnEjYk0KqRgSEJ4Bvh4bKQ3fyZvWEpCyCNsKbUexWKg1iB2/CgId5mLSzyWzSlTtq
         YXg36D7hGIMUg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/2] IB/umad: Return EIO in case of when device disassociated
Date:   Mon, 25 Jan 2021 14:13:38 +0200
Message-Id: <20210125121339.837518-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125121339.837518-1-leon@kernel.org>
References: <20210125121339.837518-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

MAD message received by the user has EINVAL error in all flows
including when the device is disassociated. That makes it impossible
for the applications to treat such flow differently.

Change it to return EIO, so the applications will be able to perform
disassociation recovery.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/user_mad.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 19104a675691..7ec1918431f7 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -379,6 +379,11 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 
 	mutex_lock(&file->mutex);
 
+	if (file->agents_dead) {
+		mutex_unlock(&file->mutex);
+		return -EIO;
+	}
+
 	while (list_empty(&file->recv_list)) {
 		mutex_unlock(&file->mutex);
 
@@ -524,7 +529,7 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 
 	agent = __get_agent(file, packet->mad.hdr.id);
 	if (!agent) {
-		ret = -EINVAL;
+		ret = -EIO;
 		goto err_up;
 	}
 
-- 
2.29.2

