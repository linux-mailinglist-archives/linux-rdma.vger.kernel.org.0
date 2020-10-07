Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69C285B86
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgJGJEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 05:04:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44676 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgJGJEB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 05:04:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09793uK0177663
        for <linux-rdma@vger.kernel.org>; Wed, 7 Oct 2020 09:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=zObixSnlrbpWIfqGosP8Kxxfe2DRqKgar5bcHVY7jY4=;
 b=EnYapbX4sDVL7ZkAEwJ4qs9bHn5o2lPK64Kh48xsfDVCfWqY6NVurVUOhPxRvh/2INw6
 B5l3Bho6aAISJ6KiTNEcVI02RgR2nhfLDxXh3QlHaWk+CB9UlSxAXcEyzjHTwPKm64XN
 pcWo8GOYi+OGuiqDr53LzEDBhKfFufoGmJ0W+plPMXeBDep/RrkyCV+2tv6qM5oKqg9L
 2LsxHGUoBTXxdabuyt2fn0t+UVJPnBWSipkRiUPg0rvA7URq4FXL/ISfewq269IjEBVb
 O+P0q54aURV74pUi+FDz6mP0DqDg23GYV/qfAqsDfyHusxJEEu9RmTVz2H4+w3YiJvBe qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33ym34nphb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-rdma@vger.kernel.org>; Wed, 07 Oct 2020 09:04:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09790AwU121250
        for <linux-rdma@vger.kernel.org>; Wed, 7 Oct 2020 09:03:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33y37y9y1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 07 Oct 2020 09:03:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09793xH3023059
        for <linux-rdma@vger.kernel.org>; Wed, 7 Oct 2020 09:03:59 GMT
Received: from ca-dev142.us.oracle.com (/10.129.135.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 02:03:58 -0700
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Add rdma_dev_to_netns()
Date:   Wed,  7 Oct 2020 02:03:55 -0700
Message-Id: <20201007090355.1101408-1-ka-cheong.poon@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=1 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070063
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function returns the namespace of a struct ib_device if the RDMA
subsystem is in exclusive network namespace mode.  If the subsystem is
in shared namespace mode, this function returns NULL.

Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
---
 drivers/infiniband/core/device.c | 16 ++++++++++++++++
 include/rdma/ib_verbs.h          |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c36b4d2b61e0..a3dd95bf3050 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -144,6 +144,22 @@ bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
 }
 EXPORT_SYMBOL(rdma_dev_access_netns);
 
+/**
+ * rdma_dev_to_netns() - Return the net namespace of a given device if the
+ *			 RDMA subsystem is in exclusive network namespace
+ *			 mode.  If it is in shared namespace mode, this
+ *			 function returns NULL.  Caller can use it to
+ *			 differentiate the two modes of the RDMA subsystem.
+ *
+ * @device: Pointer to rdma device to get the namespace
+ */
+struct net *rdma_dev_to_netns(const struct ib_device *device)
+{
+	return ib_devices_shared_netns ? NULL :
+		read_pnet(&device->coredev.rdma_net);
+}
+EXPORT_SYMBOL(rdma_dev_to_netns);
+
 /*
  * xarray has this behavior where it won't iterate over NULL values stored in
  * allocated arrays.  So we need our own iterator to see all values stored in
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c0b2fa7e9b95..aeced1a3324f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4715,6 +4715,7 @@ static inline struct ib_device *rdma_device_to_ibdev(struct device *device)
 
 bool rdma_dev_access_netns(const struct ib_device *device,
 			   const struct net *net);
+struct net *rdma_dev_to_netns(const struct ib_device *device);
 
 #define IB_ROCE_UDP_ENCAP_VALID_PORT_MIN (0xC000)
 #define IB_GRH_FLOWLABEL_MASK (0x000FFFFF)
-- 
2.18.4

