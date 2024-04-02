Return-Path: <linux-rdma+bounces-1729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D910F894F0F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E16CB215A0
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6358ABB;
	Tue,  2 Apr 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaDhEned"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0858113
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051429; cv=none; b=aP+CNgImxE3sMwZ/jxnU4N+BstkTtDsoJmCeQGJHXHuIbeGtmokCSsQYPAK5iCibRd6hQQgDgH4mm2QezrGOuk9j0xCvhuy/pMYy1UGX4500QRQE3oxbNnzGHV5eYM9TIbWSPxWxxdwx60r+fjqVZMlmp5w2URGWPrsRYBZ8Ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051429; c=relaxed/simple;
	bh=+9Ispjx9JQU5UQkS/C33YmSHtSiVA5GJgb+N0JNBP90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7Yg1o4fhIOi8UBz5Gy0xjKlgoWW1xGY2Cl4RzzCUKdXE5YF2pbPQZywODKdq/vTmU88/MA6lGSDp0XHKEZoeESKChsMqVUDzLv15eX5vAACnyrxsbRPxON2FiaSP5ce9cyPniHS+NNfne7FDCqmZjqA5Wi51wq/gFcjRtu/TsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaDhEned; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7362C433F1;
	Tue,  2 Apr 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712051429;
	bh=+9Ispjx9JQU5UQkS/C33YmSHtSiVA5GJgb+N0JNBP90=;
	h=From:To:Cc:Subject:Date:From;
	b=NaDhEnedQvSViDLWgT0L3BRypJ3AUhKJ1l4Fnm5oZXEqQsPe9au/kpNcfkCaS/Ez1
	 jYMhB8neuYELtEqeYTcgOm6dbWq/WBy0hs9XCtKdcfN2a/Z+CXelBIKLH4GfJhUwYE
	 TwZbIEgeRV1nogEOYkL46F+TaaMz6XihCFi9qzyYWJjqZUzMbXNtlbfRyekgwAdcpB
	 byQ/LppELQYGAznueAhy3gb6porTqLBsci83ySAyUn1XxTUiIZn1+zUvhCssnAMJyC
	 3MItQR2mOA7PFWHYDx9GcK6+Wp5f2MRH/nFYfKbVpNrspXFoWmKykDtqGHEHYlz1hb
	 UShFDkAFDnYOw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] IB/core: Add option to limit user mad receive list
Date: Tue,  2 Apr 2024 12:50:21 +0300
Message-ID: <70029b5f256fbad6efbb98458deb9c46baa2c4b3.1712051390.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

ib_umad is keeping the received MAD packets in a list that is not
limited in size. As the extraction of packets from this list is done
from user-space application, there is no way to guarantee the extraction
rate to be faster than the rate of incoming packets. This can cause to
the list to grow uncontrollably.

As a solution, let's add new ysfs control knob for the users to limit
the number of received MAD packets in the list.

Packets received when the list is full would be dropped. Sent packets
that are queued on the receive list for whatever reason, like timed out
sends, are not dropped even when the list is full.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../ABI/stable/sysfs-class-infiniband         | 12 ++++
 drivers/infiniband/core/user_mad.c            | 63 ++++++++++++++++++-
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
index 694f23a03a28..0ea9d590ab0e 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -275,6 +275,18 @@ Description:
 		=============== ===========================================
 
 
+What:		/sys/class/infiniband_mad/umad<N>/max_recv_list_size
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-rdma@vger.kernel.org
+Description:
+		(RW) Limit the size of the list of MAD packets waiting to be
+		     read by the user-space agent.
+		     The default value is 0, which means unlimited list size.
+		     Packets received when the list is full will be silently
+		     dropped.
+
+
 What:		/sys/class/infiniband_verbs/abi_version
 Date:		Sep, 2005
 KernelVersion:	v2.6.14
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index f5feca7fa9b9..96fe54cd4c8a 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -102,6 +102,7 @@ struct ib_umad_port {
 	struct ib_umad_device *umad_dev;
 	int                    dev_num;
 	u32                     port_num;
+	int			max_recv_list_size;
 };
 
 struct ib_umad_device {
@@ -113,6 +114,7 @@ struct ib_umad_file {
 	struct mutex		mutex;
 	struct ib_umad_port    *port;
 	struct list_head	recv_list;
+	atomic_t		recv_list_size;
 	struct list_head	send_list;
 	struct list_head	port_list;
 	spinlock_t		send_lock;
@@ -180,9 +182,27 @@ static struct ib_mad_agent *__get_agent(struct ib_umad_file *file, int id)
 	return file->agents_dead ? NULL : file->agent[id];
 }
 
+static inline bool should_drop_packet(struct ib_umad_file *file,
+				      struct ib_umad_packet *packet,
+				      bool is_send_mad)
+{
+	if (is_send_mad)
+		return false;
+
+	if (!file->port->max_recv_list_size)
+		return false;
+
+	if (atomic_read(&file->recv_list_size) <
+	    file->port->max_recv_list_size)
+		return false;
+
+	return true;
+}
+
 static int queue_packet(struct ib_umad_file *file,
 			struct ib_mad_agent *agent,
-			struct ib_umad_packet *packet)
+			struct ib_umad_packet *packet,
+			bool is_send_mad)
 {
 	int ret = 1;
 
@@ -192,7 +212,10 @@ static int queue_packet(struct ib_umad_file *file,
 	     packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
 	     packet->mad.hdr.id++)
 		if (agent == __get_agent(file, packet->mad.hdr.id)) {
+			if (should_drop_packet(file, packet, is_send_mad))
+				break;
 			list_add_tail(&packet->list, &file->recv_list);
+			atomic_inc(&file->recv_list_size);
 			wake_up_interruptible(&file->recv_wait);
 			ret = 0;
 			break;
@@ -224,7 +247,7 @@ static void send_handler(struct ib_mad_agent *agent,
 	if (send_wc->status == IB_WC_RESP_TIMEOUT_ERR) {
 		packet->length = IB_MGMT_MAD_HDR;
 		packet->mad.hdr.status = ETIMEDOUT;
-		if (!queue_packet(file, agent, packet))
+		if (!queue_packet(file, agent, packet, true))
 			return;
 	}
 	kfree(packet);
@@ -284,7 +307,7 @@ static void recv_handler(struct ib_mad_agent *agent,
 		rdma_destroy_ah_attr(&ah_attr);
 	}
 
-	if (queue_packet(file, agent, packet))
+	if (queue_packet(file, agent, packet, false))
 		goto err2;
 	return;
 
@@ -409,6 +432,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 
 	packet = list_entry(file->recv_list.next, struct ib_umad_packet, list);
 	list_del(&packet->list);
+	atomic_dec(&file->recv_list_size);
 
 	mutex_unlock(&file->mutex);
 
@@ -421,6 +445,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 		/* Requeue packet */
 		mutex_lock(&file->mutex);
 		list_add(&packet->list, &file->recv_list);
+		atomic_inc(&file->recv_list_size);
 		mutex_unlock(&file->mutex);
 	} else {
 		if (packet->recv_wc)
@@ -1222,9 +1247,41 @@ static ssize_t port_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(port);
 
+static ssize_t max_recv_list_size_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct ib_umad_port *port = dev_get_drvdata(dev);
+	int val, ret;
+
+	if (!port)
+		return -ENODEV;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	port->max_recv_list_size = val;
+
+	return count;
+}
+
+static ssize_t max_recv_list_size_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct ib_umad_port *port = dev_get_drvdata(dev);
+
+	if (!port)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%d\n", port->max_recv_list_size);
+}
+static DEVICE_ATTR_RW(max_recv_list_size);
+
 static struct attribute *umad_class_dev_attrs[] = {
 	&dev_attr_ibdev.attr,
 	&dev_attr_port.attr,
+	&dev_attr_max_recv_list_size.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(umad_class_dev);
-- 
2.44.0


