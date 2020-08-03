Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE5239F91
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHCGUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:20:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34104 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgHCGUC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 02:20:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736H6tm142427;
        Mon, 3 Aug 2020 06:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=i4BjTiOPDjXoKFbB/Wktn2APh9g9oOhr6lfl0zI3ico=;
 b=gSPPGx1poL3/pf5WBgs+ahSwYyWpZo5ciUeMTxQ34Nm7qaX+ASGkECUbonq07oxPA1hE
 J1fLuxCwam0djEv/kWCvIwENDUQi1598IEVSXlAXrEi99M9gxdfrb1szBFUiuYIo9Ze4
 kt9ZnDZetPNEm07TDpvPpqLAVXDvOshepb9QvIiMom6JXSdlPa9dso2JtasrKe6ligYp
 hsSiKKkZPZ7gl5VmRiWz5m4E74ZWsT+B34+TwcfOEo/eSZzYs/bpxbktjdrHs9ar1JBR
 UqcqKERxiHxUpTP2sCQkwZNCFAak5H7DYCAMAJhER2o9M0cHGEkTJsBGNzS78VpruYvJ jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32mytqvp90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 06:19:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736HdfL168534;
        Mon, 3 Aug 2020 06:19:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32njaugb5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 06:19:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0736Jt9M023623;
        Mon, 3 Aug 2020 06:19:55 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2020 23:19:54 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, yishaih@mellanox.com,
        jackm@dev.mellanox.co.il, ranro@mellanox.com
Subject: [PATCH for-rc v2 2/6] IB/mlx4: Add support for MRA
Date:   Mon,  3 Aug 2020 08:19:37 +0200
Message-Id: <20200803061941.1139994-3-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803061941.1139994-1-haakon.bugge@oracle.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=856 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=867 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using CX-3 in virtualized mode, MAD packets are proxied through the PF
driver. However, the handling lacks support of the MRA (Message
Receipt Acknowledgment) packet. When having dynamic debug enabled, we
see tons of:

mlx4_ib_multiplex_cm_handler: id{slave: 7, sl_cm_id: 0x8fcb45a0} is NULL! attr_id: 0x11

Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 302ea7ec2008..6f0ffd0906e6 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -293,8 +293,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 	int pv_cm_id = -1;
 
 	if (mad->mad_hdr.attr_id == CM_REQ_ATTR_ID ||
-			mad->mad_hdr.attr_id == CM_REP_ATTR_ID ||
-			mad->mad_hdr.attr_id == CM_SIDR_REQ_ATTR_ID) {
+	    mad->mad_hdr.attr_id == CM_REP_ATTR_ID ||
+	    mad->mad_hdr.attr_id == CM_MRA_ATTR_ID ||
+	    mad->mad_hdr.attr_id == CM_SIDR_REQ_ATTR_ID) {
 		sl_cm_id = get_local_comm_id(mad);
 		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
 		if (id)
-- 
2.20.1

