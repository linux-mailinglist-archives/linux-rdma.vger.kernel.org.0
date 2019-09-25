Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CDBDE2F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 14:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfIYMlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 08:41:20 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:25566 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfIYMlU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 08:41:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PCeGSJ012653;
        Wed, 25 Sep 2019 05:41:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=ZPG80p6CCXPJRwOo2P2x9+3Re1I8zG6Kq6fTaBdVOCQ=;
 b=l18X91sJrKCxNsvssMe9g+H/1L54QSXdM9dmxF/q201t14McJeEbnlx8EO8J2FhrbpRl
 DqTpSdoxqLotXnkW0ig5glsbmWkl75JD9JmpcjP6XOfitv5B+gwVdkOPhCsP5A3gqkSo
 l5POBI/OcAcCWIVK3b8/NGRVyV8SQkgR4lA9t63KKG5bO60xrksEeVzv/mDHV5sADj4Z
 j6+2Vs10i3uneIWfZH8Vj6lsk/7eYCrwKtvBS1wdZscdE7lWxoXN2CNePQ2oyxUHB/9C
 OjYUlXYM+l2WGajUk7R3mJgeO0hDF6I8J4fjJ4nbJ1s/JrQ0SxplfKHgMgBTKkMEPb3J hQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v887gg207-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 05:41:13 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 25 Sep
 2019 05:35:46 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 25 Sep 2019 05:35:46 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 963103F703F;
        Wed, 25 Sep 2019 05:35:44 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <kamalheib1@gmail.com>,
        <michal.kalderon@marvell.com>, <aelior@marvell.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] RDMA/core: Fix use after free and refcnt leak on ndev in_device in iwarp_query_port
Date:   Wed, 25 Sep 2019 15:33:32 +0300
Message-ID: <20190925123332.10746-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_05:2019-09-23,2019-09-25 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If an iWARP driver is probed and removed while there are no ips
set for the device, it will lead to a reference count leak on
the inet device of the netdevice.

In addition, the netdevice was accessed after already calling
netdev_put, which could lead to using the netdev after already
freed.

Fixes: 4929116bdf72 ("RDMA/core: Add common iWARP query port")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/core/device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 99c4a55545cf..2dd2cfe9b561 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1987,8 +1987,6 @@ static int iw_query_port(struct ib_device *device,
 	if (!netdev)
 		return -ENODEV;
 
-	dev_put(netdev);
-
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
 
@@ -1996,19 +1994,22 @@ static int iw_query_port(struct ib_device *device,
 		port_attr->state = IB_PORT_DOWN;
 		port_attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	} else {
-		inetdev = in_dev_get(netdev);
+		rcu_read_lock();
+		inetdev = __in_dev_get_rcu(netdev);
 
 		if (inetdev && inetdev->ifa_list) {
 			port_attr->state = IB_PORT_ACTIVE;
 			port_attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
-			in_dev_put(inetdev);
 		} else {
 			port_attr->state = IB_PORT_INIT;
 			port_attr->phys_state =
 				IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
 		}
+
+		rcu_read_unlock();
 	}
 
+	dev_put(netdev);
 	err = device->ops.query_port(device, port_num, port_attr);
 	if (err)
 		return err;
-- 
2.20.1

