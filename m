Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D5225E71
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGTMXL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 08:23:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgGTMXK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 08:23:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCGdXX078638;
        Mon, 20 Jul 2020 12:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nZcl9due6SXDftRrpW7audVJQifbeyXbsWQp/G7Dbio=;
 b=EXXnmC5hX+tjzraRuDUXx7HTlqhYH3W9qwkFEdZTyRercIs4U1tt5/o0XD2xZQi2Hj8C
 Ci6i86bPb7H6x82Sc9IakrZj+vfZKinEkIGrkvltsphAe6YBqOg92n6CnyC0MgA1UfH+
 4rD/hlqlFpGv+UuUKhiZye7o9YPhnyzG/EnQGw5sIxN+usF6TKh8ZYTGpdCmFu1BMstK
 fY2R95v/fh2FF34VG5PSAwajv0bV3+Bt1aMk6YrlVYH153yaLX14tTXAIl0Qa/Fn5uet
 z/xb2vYjTNq4I6NBG6YD0Z97O7afZaw6+qMjbaD4FWqES33co8rYkzrrvJICCNyod8xB ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32brgr6ks2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 12:23:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCDvtr027482;
        Mon, 20 Jul 2020 12:23:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32d8m01uhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 12:23:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KCN3Fg007145;
        Mon, 20 Jul 2020 12:23:03 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 05:23:03 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>
Subject: [PATCH for-rc 2/5] IB/mlx4: Add support for MRA
Date:   Mon, 20 Jul 2020 14:22:46 +0200
Message-Id: <20200720122249.487086-3-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720122249.487086-1-haakon.bugge@oracle.com>
References: <20200720122249.487086-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=993
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200085
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using CX-3 in virtualized mode, MAD packets are proxied through the PF
driver. However, the handling lacks support of the MRA (Message
Receipt Acknowledgment) packet. When having dynamic debug enabled, we
see tons of:

mlx4_ib_multiplex_cm_handler: id{slave: 7, sl_cm_id: 0x8fcb45a0} is NULL! attr_id: 0x11

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

