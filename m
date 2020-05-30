Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5E1E91E3
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2020 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgE3OCl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 May 2020 10:02:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3OCl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 May 2020 10:02:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04UE1kFu146241;
        Sat, 30 May 2020 14:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=V8yazQPPEqrysZhHOR5eNcapwEO0/RJUcpi03dO6X8k=;
 b=DOfruvn0J7EwgnkbteKgA+p1PePoVCaHTdJzjcVuxLgWvUdZNIXPN3LP8poTm3gUOGRH
 wjEScBTcRVoVOMQ4Pf0Blh8URxYCE27J9+BODLWwbT1B/enz2Qvru+1i5Wggblvl5Lw7
 slqbws+B1fwGOfUlYnCZDCKaT6gDfNlN0XK/HSX+wtsBt31vCZrfkWJDwOVpZP08Zwcw
 c2cmLNwhrBO2mpiflYst5tOeEeEBbeuDx0+Y1/sFc47cgko7kDas2MZNAanWEs02V6df
 3LuknPtmHCFYkSojUSwtJQsePvbF3rcJe2EGCrDgVODCGL/MuXAiLCFKWAfMt1SEvorE SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31bewqh60b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 May 2020 14:02:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04UDwCLC175474;
        Sat, 30 May 2020 14:02:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31bethak85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 May 2020 14:02:33 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04UE2VxR000962;
        Sat, 30 May 2020 14:02:31 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 30 May 2020 07:02:30 -0700
Date:   Sat, 30 May 2020 17:02:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] IB/hfi1: Fix hfi1_netdev_rx_init() error handling
Message-ID: <20200530140224.GA1330098@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB3958CF61BB1F59A6F6B5234D868F0@BY5PR11MB3958.namprd11.prod.outlook.com>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005300109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005300109
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The hfi1_vnic_up() function doesn't check whether hfi1_netdev_rx_init()
returns errors.  In hfi1_vnic_init() we need to change the code to
preserve the error code instead of returning success.

Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface Controller (VNIC) HW support")
Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Add error handling in hfi1_vnic_up() and add second fixes tag

 drivers/infiniband/hw/hfi1/vnic_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index b183c56b7b6a4..03f8be8e9488e 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -457,13 +457,19 @@ static int hfi1_vnic_up(struct hfi1_vnic_vport_info *vinfo)
 	if (rc < 0)
 		return rc;
 
-	hfi1_netdev_rx_init(dd);
+	rc = hfi1_netdev_rx_init(dd);
+	if (rc < 0)
+		goto err_remove;
 
 	netif_carrier_on(netdev);
 	netif_tx_start_all_queues(netdev);
 	set_bit(HFI1_VNIC_UP, &vinfo->flags);
 
 	return 0;
+
+err_remove:
+	hfi1_netdev_remove_data(dd, VNIC_ID(vinfo->vesw_id));
+	return rc;
 }
 
 static void hfi1_vnic_down(struct hfi1_vnic_vport_info *vinfo)
@@ -512,7 +518,8 @@ static int hfi1_vnic_init(struct hfi1_vnic_vport_info *vinfo)
 			goto txreq_fail;
 	}
 
-	if (hfi1_netdev_rx_init(dd)) {
+	rc = hfi1_netdev_rx_init(dd);
+	if (rc) {
 		dd_dev_err(dd, "Unable to initialize netdev contexts\n");
 		goto alloc_fail;
 	}
-- 
2.26.2

