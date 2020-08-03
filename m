Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A6E239F9B
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHCGWK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:22:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46200 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHCGWJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 02:22:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736I6L3004725;
        Mon, 3 Aug 2020 06:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9kHmTUxS2oTs2MX/+qufxIbvaKWua2Gcvu+ftpSkVb8=;
 b=hbwlDYbvn0X/nyHezj2L4eCryysQYShjIaXi4otjAn7DTVdaW1BE72pM3oPwSBMgaQds
 iSkQ+SYGbE/W76azafNCiaDwtXJ8uHMH69PSsxIKhaeAcsgqIOVCEm7fWBl6V1CPDw4H
 36/0xYOwuM4l//7kKvJa1b3gOYPwGbyfz1/vp8UEmEqwUoioNFwoXYN/U/R22pQZwl0x
 lWM1LoqIBA21E8G1Ho3aTB4+deLG0KSxHhjEglxUUJm5y1chT/TMkx6eXxJ+tNH2xtXy
 +2q62A2dS1pEh1JNs8WpAfWa22vw7rSBmyL0/tBfvg1J+LJVrew++Cbqzz/GQ4uz64f3 Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32nc9yb719-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 06:22:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736IpxV163944;
        Mon, 3 Aug 2020 06:20:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32nj5phvtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 06:20:04 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0736K2ME006340;
        Mon, 3 Aug 2020 06:20:03 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2020 23:20:02 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, yishaih@mellanox.com,
        jackm@dev.mellanox.co.il, ranro@mellanox.com
Subject: [PATCH for-rc v2 6/6] IB/mlx4: Adjust delayed work when a dup is observed
Date:   Mon,  3 Aug 2020 08:19:41 +0200
Message-Id: <20200803061941.1139994-7-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803061941.1139994-1-haakon.bugge@oracle.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When scheduling delayed work to clean up the cache, if the entry
already has been scheduled for deletion, we adjust the delay.

Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index b10737f74449..0ce4b5a3ffa7 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -291,6 +291,9 @@ static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
 	if (!sriov->is_going_down && !id->scheduled_delete) {
 		id->scheduled_delete = 1;
 		schedule_delayed_work(&id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+	} else if (id->scheduled_delete) {
+		/* Adjust timeout if already scheduled */
+		mod_delayed_work(system_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 	}
 	spin_unlock_irqrestore(&sriov->going_down_lock, flags);
 	spin_unlock(&sriov->id_map_lock);
-- 
2.20.1

