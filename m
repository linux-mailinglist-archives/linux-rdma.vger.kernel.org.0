Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440593024D4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 13:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhAYMRI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 07:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbhAYMPo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 07:15:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5751C22EBF;
        Mon, 25 Jan 2021 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611576833;
        bh=fIT/cGDkPJWKgNOy2uz747AA+nrVR8fdt0NCaNA/1Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POhbaPn86OsFrxH/t1JFIb1JFDXkK6ZBS7TiBiQ995RyIxFZNbWwdHWXa80gZiVdJ
         jw4soCrRE9KL8RhkID8DIa43bJBukqWXGW8+P2aZWiza3NJVADFCJKRzeAHnHgmpIN
         /FnThjRsmC0ik+wi23RWQVfDXljbG/H+JQIIKiiMwS/QrOHBKCWZ6J8f3+9PF06za7
         jC6GpzW5D/yrrVCV9xqaB/i3YbWSvc4PoYeV7GgftC/gSmy0QRFDLIGp6GALM0N51/
         TF3T8qapVDpuQ9ZwbA0MQI6MBXWvqNgPEHkYUt/oRtWV8ovlNjZewvFxfjFHBZrWCt
         W7dhLi0gcamXw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/2] IB/umad: Return EPOLLERR in case of when device disassociated
Date:   Mon, 25 Jan 2021 14:13:39 +0200
Message-Id: <20210125121339.837518-3-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125121339.837518-1-leon@kernel.org>
References: <20210125121339.837518-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

Currently, polling a umad device will always works, even if the device
was disassociated. A disassociated device should immediately return
EPOLLERR from poll(). Otherwise userspace is endlessly hung on poll()
with no idea that the device has been removed from the system.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/user_mad.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 7ec1918431f7..dd7f3b437c6b 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -397,6 +397,11 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 		mutex_lock(&file->mutex);
 	}
 
+	if (file->agents_dead) {
+		mutex_unlock(&file->mutex);
+		return -EIO;
+	}
+
 	packet = list_entry(file->recv_list.next, struct ib_umad_packet, list);
 	list_del(&packet->list);
 
@@ -658,10 +663,14 @@ static __poll_t ib_umad_poll(struct file *filp, struct poll_table_struct *wait)
 	/* we will always be able to post a MAD send */
 	__poll_t mask = EPOLLOUT | EPOLLWRNORM;
 
+	mutex_lock(&file->mutex);
 	poll_wait(filp, &file->recv_wait, wait);
 
 	if (!list_empty(&file->recv_list))
 		mask |= EPOLLIN | EPOLLRDNORM;
+	if (file->agents_dead)
+		mask = EPOLLERR;
+	mutex_unlock(&file->mutex);
 
 	return mask;
 }
@@ -1341,6 +1350,7 @@ static void ib_umad_kill_port(struct ib_umad_port *port)
 	list_for_each_entry(file, &port->file_list, port_list) {
 		mutex_lock(&file->mutex);
 		file->agents_dead = 1;
+		wake_up_interruptible(&file->recv_wait);
 		mutex_unlock(&file->mutex);
 
 		for (id = 0; id < IB_UMAD_MAX_AGENTS; ++id)
-- 
2.29.2

