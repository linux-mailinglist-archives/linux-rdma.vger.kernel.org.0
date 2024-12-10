Return-Path: <linux-rdma+bounces-6387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF69EB1A2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 14:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8936281A10
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB5E1A76DE;
	Tue, 10 Dec 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dWkW/IJ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C31A0B15;
	Tue, 10 Dec 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835932; cv=none; b=giUJ7reU0qZX+AJ8R3bv/fAu1hjPd4tXn/+G/VQVyDYi/X/nsfWeOn6+7eF3Xd+gJpefUhnr5gX8qoxc3q8icJysu2h0G4MyN2RJl6vTVaAkVTiJzo1zwWNe2t0zHcEn38OGjCUW8HRS1KfOmW/V/C7xyNAQHityikNEA2zrqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835932; c=relaxed/simple;
	bh=ObIvv4aBHq42R6izYAIFAgUT2lfTA0MWQNtfEld2CnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gHhwV91dnqQVIXZPAbTaodLBFNb1+w67iHz/0fv/IUJtbgs136GZb7SwK61L57x0C1SchOHjLWgbcjOEe8FjQjPCDnm1l4tiIhp2GeEI/F0muhjCv6/3CDbuT5pwZfCR/0KiqrSZUPzIE+coO0lylFymJcYTKtY7Yy39BRQq5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dWkW/IJ0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA2SDY6032428;
	Tue, 10 Dec 2024 13:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Tmqk0ezcuIeoWDq63ykmLje//L3X4RDn77qpjUnro
	VQ=; b=dWkW/IJ0sCNEJ1+7OwXVJr76H95F7ofKb/s2blW3AIW9TPjQYBlviZaxg
	fENyUx3Nfd5jVXBn1W/X8nsLiv4+gqnfoj33FVkz14JB+n4VjHtyZDocphkXtwqj
	NGjiYvcUAWB6a4IaDs5XdMCMzjwV8whFu8T6tbGaa7aLnsjJ7DYr77SNgtEMZupX
	likRDK4Hj8AwuL4WzvKC2i4mhF2sDcCDLaw2NwUl9FjCgjjcxxQ07rZPIDJ+frhZ
	AAAQuFRuXWYG/+yw2QYUIhcgRGSYeXq80W1045vEnolqZt0ruXuVzeFo1oiKRHo6
	5hSQL1dvyyUJ3xW3ZoFRhbLB4tbFQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq6dkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:05:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BAD5Mhl001327;
	Tue, 10 Dec 2024 13:05:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq6dke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:05:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAQDZb032727;
	Tue, 10 Dec 2024 13:05:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psbwnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:05:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAD5JLv50790864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 13:05:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D061220043;
	Tue, 10 Dec 2024 13:05:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F63120040;
	Tue, 10 Dec 2024 13:05:19 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.68.72])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 13:05:19 +0000 (GMT)
From: Bernard Metzler <bmt@zurich.ibm.com>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com, Bernard Metzler <bmt@zurich.ibm.com>,
        syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/siw: Remove direct link to net_device
Date: Tue, 10 Dec 2024 14:03:51 +0100
Message-Id: <20241210130351.406603-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jGLhd_i-PGUraM-d4GchWu6iJHnGFpdE
X-Proofpoint-GUID: yW7HGGi5IYCoqZzpE0Gni0e6AkiodKsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=934 adultscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100097

Maintain needed network interface information locally, but
remove a direct link to net_device which can become stale.
Accessing a stale net_device link was causing a 'KASAN:
slab-use-after-free' exception during siw_query_port()
call.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       | 11 +++++++----
 drivers/infiniband/sw/siw/siw_cm.c    |  4 ++--
 drivers/infiniband/sw/siw/siw_main.c  | 18 ++++++++++++------
 drivers/infiniband/sw/siw/siw_verbs.c | 11 ++++++-----
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 86d4d6a2170e..c8f75527b513 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -69,16 +69,19 @@ struct siw_pd {
 
 struct siw_device {
 	struct ib_device base_dev;
-	struct net_device *netdev;
 	struct siw_dev_cap attrs;
 
 	u32 vendor_part_id;
+	struct {
+		int ifindex;
+		enum ib_port_state state;
+		enum ib_mtu mtu;
+		enum ib_mtu max_mtu;
+	} ifinfo;
+
 	int numa_node;
 	char raw_gid[ETH_ALEN];
 
-	/* physical port state (only one port per device) */
-	enum ib_port_state state;
-
 	spinlock_t lock;
 
 	struct xarray qp_xa;
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 86323918a570..451b50d92f7f 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1780,7 +1780,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 
 		/* For wildcard addr, limit binding to current device only */
 		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
-			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
+			s->sk->sk_bound_dev_if = sdev->ifinfo.ifindex;
 
 		rv = s->ops->bind(s, (struct sockaddr *)laddr,
 				  sizeof(struct sockaddr_in));
@@ -1798,7 +1798,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 
 		/* For wildcard addr, limit binding to current device only */
 		if (ipv6_addr_any(&laddr->sin6_addr))
-			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
+			s->sk->sk_bound_dev_if = sdev->ifinfo.ifindex;
 
 		rv = s->ops->bind(s, (struct sockaddr *)laddr,
 				  sizeof(struct sockaddr_in6));
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 17abef48abcd..4db10bdfb515 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 		return NULL;
 
 	base_dev = &sdev->base_dev;
-	sdev->netdev = netdev;
 
 	if (netdev->addr_len) {
 		memcpy(sdev->raw_gid, netdev->dev_addr,
@@ -354,6 +353,10 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	atomic_set(&sdev->num_mr, 0);
 	atomic_set(&sdev->num_pd, 0);
 
+	sdev->ifinfo.max_mtu = ib_mtu_int_to_enum(netdev->max_mtu);
+	sdev->ifinfo.mtu = ib_mtu_int_to_enum(READ_ONCE(netdev->mtu));
+	sdev->ifinfo.ifindex = netdev->ifindex;
+
 	sdev->numa_node = dev_to_node(&netdev->dev);
 	spin_lock_init(&sdev->lock);
 
@@ -381,12 +384,12 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case NETDEV_UP:
-		sdev->state = IB_PORT_ACTIVE;
+		sdev->ifinfo.state = IB_PORT_ACTIVE;
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
 		break;
 
 	case NETDEV_DOWN:
-		sdev->state = IB_PORT_DOWN;
+		sdev->ifinfo.state = IB_PORT_DOWN;
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
 		break;
 
@@ -406,10 +409,13 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 	case NETDEV_CHANGEADDR:
 		siw_port_event(sdev, 1, IB_EVENT_LID_CHANGE);
 		break;
+
+	case NETDEV_CHANGEMTU:
+		sdev->ifinfo.mtu = ib_mtu_int_to_enum(READ_ONCE(netdev->mtu));
+		break;
 	/*
 	 * Todo: Below netdev events are currently not handled.
 	 */
-	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGE:
 		break;
 
@@ -444,9 +450,9 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
 		dev_dbg(&netdev->dev, "siw: new device\n");
 
 		if (netif_running(netdev) && netif_carrier_ok(netdev))
-			sdev->state = IB_PORT_ACTIVE;
+			sdev->ifinfo.state = IB_PORT_ACTIVE;
 		else
-			sdev->state = IB_PORT_DOWN;
+			sdev->ifinfo.state = IB_PORT_DOWN;
 
 		ib_mark_name_assigned_by_user(&sdev->base_dev);
 		rv = siw_device_register(sdev, basedev_name);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 986666c19378..3ab9c5170637 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -178,14 +178,15 @@ int siw_query_port(struct ib_device *base_dev, u32 port,
 
 	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
 			 &attr->active_width);
+
 	attr->gid_tbl_len = 1;
 	attr->max_msg_sz = -1;
-	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
+	attr->max_mtu = sdev->ifinfo.max_mtu;
+	attr->active_mtu = sdev->ifinfo.mtu;
+	attr->phys_state = sdev->ifinfo.state == IB_PORT_ACTIVE ?
 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
-	attr->state = sdev->state;
+	attr->state = sdev->ifinfo.state;
 	/*
 	 * All zero
 	 *
@@ -519,7 +520,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
 	qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
 	qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
 	qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
-	qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
+	qp_attr->path_mtu = sdev->ifinfo.mtu;
 	qp_attr->max_rd_atomic = qp->attrs.irq_size;
 	qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
 
-- 
2.38.1


