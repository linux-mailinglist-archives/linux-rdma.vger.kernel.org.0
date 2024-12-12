Return-Path: <linux-rdma+bounces-6479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8689EEB66
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 16:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4510716A528
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FB21770A;
	Thu, 12 Dec 2024 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JatNnDLa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4482AF0E;
	Thu, 12 Dec 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016747; cv=none; b=RTSdpSmoeM76vD8iiJMm73x8CN0r1CMMKZr6FJsay3uO8DcHYT2zdfU0A9eOI9sJ/lPYy02GPQ2RdRJP2X8kr1XlCb+M+RH7dYpJAVqyHBbMtGSMJvJ3PaAh5tCwpLeJxAhu0GSt3kh9yqLeoGeVijA1eyu3yAOCd1PD1AlL7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016747; c=relaxed/simple;
	bh=r2LktiNkD8WEBU8FLvfMcmjRPqKA9k0uCt3gWJe8HeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t9QR+NTf0y42MKZSev4amx4jHVsw7qhrAzX0TgEoANcuNBIM3ea4SCE7ILfwZRulHXI+RqcJ//pri3iL3HMCmheBs6Qhnok3TscIabtxx0SHb2NTs4v3gNfEhjkXpV5A8alDo3bVduZnrGruMXJ8i6hHvI36YXSklZQtoTLhmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JatNnDLa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC8VBFm012082;
	Thu, 12 Dec 2024 15:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cREK0nPxH7C8uX7fronRRJFeJwmVQzeFql/frkJtQ
	bw=; b=JatNnDLaUCoXJRbri6YMCV4hV86Z8kaDt7gnuOo9K4tAo6UGySoa5kMx+
	dImWWnr5rIHB6Ix0WEZaGSGzvwnmrCBSJ6/CJl3w/csXzghwkMuAETEiobPJpb+1
	JG9ocrFJ16Gylemke4aK1slay7KxzIGf46kE55129/5cJpyduP8RtXADBf2PQEBx
	bstY1fcOP5JUuTrsumyh30DZeAXJ5sXLXX8uNgOvYaJcWasCGx3thQr+w8eNImnL
	PM6APtZSPXm4Fk8o8E6MRmw0e3UOJLbYSe6OJ22A+ArcUNqJ2pigriOK9YhdH/tP
	Zx0rrxwla2oEqdmFBiBuduFiv2syg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3957dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:18:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCFIsra018180;
	Thu, 12 Dec 2024 15:18:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3957dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:18:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCxrgm016952;
	Thu, 12 Dec 2024 15:18:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yhbdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:18:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCFIpxB38535540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 15:18:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48FBF2004D;
	Thu, 12 Dec 2024 15:18:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D1620040;
	Thu, 12 Dec 2024 15:18:51 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.68.72])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 15:18:50 +0000 (GMT)
From: Bernard Metzler <bmt@zurich.ibm.com>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        zyjzyj2000@gmail.com, Bernard Metzler <bmt@zurich.ibm.com>,
        syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: [PATCH RESEND v2] RDMA/siw: Remove direct link to net_device
Date: Thu, 12 Dec 2024 16:18:48 +0100
Message-Id: <20241212151848.564872-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yoVOvvpsbcTKSPMXxiE---VT7BloBMW_
X-Proofpoint-ORIG-GUID: 0LFDxco8dwGsV7LwoVnqTIvn1Z8ct-9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120108

Do not manage a per device direct link to net_device. Rely
on associated ib_devices net_device management, not doubling
the effort locally. A badly managed local link to net_device
was causing a 'KASAN: slab-use-after-free' exception during
siw_query_port() call.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  7 +++---
 drivers/infiniband/sw/siw/siw_cm.c    | 31 +++++++++++++++++++-----
 drivers/infiniband/sw/siw/siw_main.c  | 15 +-----------
 drivers/infiniband/sw/siw/siw_verbs.c | 35 ++++++++++++++++++---------
 4 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 86d4d6a2170e..ea5eee50dc39 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -46,6 +46,9 @@
  */
 #define SIW_IRQ_MAXBURST_SQ_ACTIVE 4
 
+/* There is always only a port 1 per siw device */
+#define SIW_PORT 1
+
 struct siw_dev_cap {
 	int max_qp;
 	int max_qp_wr;
@@ -69,16 +72,12 @@ struct siw_pd {
 
 struct siw_device {
 	struct ib_device base_dev;
-	struct net_device *netdev;
 	struct siw_dev_cap attrs;
 
 	u32 vendor_part_id;
 	int numa_node;
 	char raw_gid[ETH_ALEN];
 
-	/* physical port state (only one port per device) */
-	enum ib_port_state state;
-
 	spinlock_t lock;
 
 	struct xarray qp_xa;
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 86323918a570..b157bd01e70b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1759,6 +1759,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 {
 	struct socket *s;
 	struct siw_cep *cep = NULL;
+	struct net_device *ndev = NULL;
 	struct siw_device *sdev = to_siw_dev(id->device);
 	int addr_family = id->local_addr.ss_family;
 	int rv = 0;
@@ -1779,9 +1780,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		struct sockaddr_in *laddr = &to_sockaddr_in(id->local_addr);
 
 		/* For wildcard addr, limit binding to current device only */
-		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
-			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
-
+		if (ipv4_is_zeronet(laddr->sin_addr.s_addr)) {
+			ndev = ib_device_get_netdev(id->device, SIW_PORT);
+			if (ndev) {
+				s->sk->sk_bound_dev_if = ndev->ifindex;
+			} else {
+				rv = -ENODEV;
+				goto error;
+			}
+		}
 		rv = s->ops->bind(s, (struct sockaddr *)laddr,
 				  sizeof(struct sockaddr_in));
 	} else {
@@ -1797,9 +1804,15 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		}
 
 		/* For wildcard addr, limit binding to current device only */
-		if (ipv6_addr_any(&laddr->sin6_addr))
-			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
-
+		if (ipv6_addr_any(&laddr->sin6_addr)) {
+			ndev = ib_device_get_netdev(id->device, SIW_PORT);
+			if (ndev) {
+				s->sk->sk_bound_dev_if = ndev->ifindex;
+			} else {
+				rv = -ENODEV;
+				goto error;
+			}
+		}
 		rv = s->ops->bind(s, (struct sockaddr *)laddr,
 				  sizeof(struct sockaddr_in6));
 	}
@@ -1861,6 +1874,9 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	list_add_tail(&cep->listenq, (struct list_head *)id->provider_data);
 	cep->state = SIW_EPSTATE_LISTENING;
 
+	if (ndev)
+		dev_put(ndev);
+
 	siw_dbg(id->device, "Listen at laddr %pISp\n", &id->local_addr);
 
 	return 0;
@@ -1880,6 +1896,9 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	}
 	sock_release(s);
 
+	if (ndev)
+		dev_put(ndev);
+
 	return rv;
 }
 
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 17abef48abcd..14d3103aee6f 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 		return NULL;
 
 	base_dev = &sdev->base_dev;
-	sdev->netdev = netdev;
 
 	if (netdev->addr_len) {
 		memcpy(sdev->raw_gid, netdev->dev_addr,
@@ -381,12 +380,10 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case NETDEV_UP:
-		sdev->state = IB_PORT_ACTIVE;
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
 		break;
 
 	case NETDEV_DOWN:
-		sdev->state = IB_PORT_DOWN;
 		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
 		break;
 
@@ -407,12 +404,8 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 		siw_port_event(sdev, 1, IB_EVENT_LID_CHANGE);
 		break;
 	/*
-	 * Todo: Below netdev events are currently not handled.
+	 * All other events are not handled
 	 */
-	case NETDEV_CHANGEMTU:
-	case NETDEV_CHANGE:
-		break;
-
 	default:
 		break;
 	}
@@ -442,12 +435,6 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
 	sdev = siw_device_create(netdev);
 	if (sdev) {
 		dev_dbg(&netdev->dev, "siw: new device\n");
-
-		if (netif_running(netdev) && netif_carrier_ok(netdev))
-			sdev->state = IB_PORT_ACTIVE;
-		else
-			sdev->state = IB_PORT_DOWN;
-
 		ib_mark_name_assigned_by_user(&sdev->base_dev);
 		rv = siw_device_register(sdev, basedev_name);
 		if (rv)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 986666c19378..7ca0297d68a4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -171,21 +171,29 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 int siw_query_port(struct ib_device *base_dev, u32 port,
 		   struct ib_port_attr *attr)
 {
-	struct siw_device *sdev = to_siw_dev(base_dev);
+	struct net_device *ndev;
 	int rv;
 
 	memset(attr, 0, sizeof(*attr));
 
 	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
 			 &attr->active_width);
+	if (rv)
+		return rv;
+
+	ndev = ib_device_get_netdev(base_dev, SIW_PORT);
+	if (!ndev)
+		return -ENODEV;
+
 	attr->gid_tbl_len = 1;
 	attr->max_msg_sz = -1;
-	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
+	attr->max_mtu = ib_mtu_int_to_enum(ndev->max_mtu);
+	attr->active_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
+	attr->phys_state = (netif_running(ndev) && netif_carrier_ok(ndev)) ?
 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
+	attr->state = attr->phys_state == IB_PORT_PHYS_STATE_LINK_UP ?
+		IB_PORT_ACTIVE : IB_PORT_DOWN;
 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
-	attr->state = sdev->state;
 	/*
 	 * All zero
 	 *
@@ -199,6 +207,7 @@ int siw_query_port(struct ib_device *base_dev, u32 port,
 	 * attr->subnet_timeout = 0;
 	 * attr->init_type_repy = 0;
 	 */
+	dev_put(ndev);
 	return rv;
 }
 
@@ -505,21 +514,24 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
 		 int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
 {
 	struct siw_qp *qp;
-	struct siw_device *sdev;
+	struct net_device *ndev;
 
-	if (base_qp && qp_attr && qp_init_attr) {
+	if (base_qp && qp_attr && qp_init_attr)
 		qp = to_siw_qp(base_qp);
-		sdev = to_siw_dev(base_qp->device);
-	} else {
+	else
 		return -EINVAL;
-	}
+
+	ndev = ib_device_get_netdev(base_qp->device, SIW_PORT);
+	if (!ndev)
+		return -ENODEV;
+
 	qp_attr->qp_state = siw_qp_state_to_ib_qp_state[qp->attrs.state];
 	qp_attr->cap.max_inline_data = SIW_MAX_INLINE;
 	qp_attr->cap.max_send_wr = qp->attrs.sq_size;
 	qp_attr->cap.max_send_sge = qp->attrs.sq_max_sges;
 	qp_attr->cap.max_recv_wr = qp->attrs.rq_size;
 	qp_attr->cap.max_recv_sge = qp->attrs.rq_max_sges;
-	qp_attr->path_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
+	qp_attr->path_mtu = ib_mtu_int_to_enum(READ_ONCE(ndev->mtu));
 	qp_attr->max_rd_atomic = qp->attrs.irq_size;
 	qp_attr->max_dest_rd_atomic = qp->attrs.orq_size;
 
@@ -534,6 +546,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct ib_qp_attr *qp_attr,
 
 	qp_init_attr->cap = qp_attr->cap;
 
+	dev_put(ndev);
 	return 0;
 }
 
-- 
2.38.1


