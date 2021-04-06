Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A9F355100
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhDFKha (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 06:37:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhDFKh3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 06:37:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136ATPNo152971;
        Tue, 6 Apr 2021 10:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=j/BfPO9zdGo2Jh/EhedN7uoaLBeHjRjKH99pPY8a6E8=;
 b=LO4/CxwMHx85oYyv4ohCUwmQz8zUgm1y7oQ+hvDhWM6hN/ZhkBws6A+HFOZQ59QyEVs/
 WUiOiunrnm2w5YBWdsIfOm7Tr6PtUs4/fF4PUS+nO77KmNCtzIry8LZR3JE7ajWf2i/q
 sKUwO55HgIU6u5NlJ2hu4T9vuNj+9KecQd3qLkrhTNPLBX7dmSWGO7A/XLRxk51W3O71
 dTM7veIbTAO7e1unxCo5V99kN6+yHZExRAlvZJ/21rI8v40zW135cXqxYGcrSl+m/gjH
 Qv6qrK1u9740D6wM2uGi0ta8mHLmAVsMbDLnWsv1Hp6iuvK+M69xZZxQ45dIK93DFuPE HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37qfuxcber-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 10:37:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136AZ14x068807;
        Tue, 6 Apr 2021 10:37:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37q2pu3tst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 10:37:17 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 136AbFDe009173;
        Tue, 6 Apr 2021 10:37:15 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Apr 2021 03:37:14 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH for-next] RDMA/core: Unify RoCE check and re-factor code
Date:   Tue,  6 Apr 2021 12:37:03 +0200
Message-Id: <1617705423-15570-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060072
X-Proofpoint-GUID: lg-2IitPsEhNwbhT6yBrdoYtgqNynfZE
X-Proofpoint-ORIG-GUID: lg-2IitPsEhNwbhT6yBrdoYtgqNynfZE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In cm_req_handler(), unify the check for RoCE and re-factor to avoid
one test.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: 8f9748602491 ("IB/cm: Reduce dependency on gid attribute ndev check")
Fixes: 194f64a3cad3 ("RDMA/core: Fix corrupted SL on passive side")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 32c836b..074faff 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2138,21 +2138,17 @@ static int cm_req_handler(struct cm_work *work)
 		goto destroy;
 	}
 
-	if (cm_id_priv->av.ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE)
-		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
-
 	memset(&work->path[0], 0, sizeof(work->path[0]));
 	if (cm_req_has_alt_path(req_msg))
 		memset(&work->path[1], 0, sizeof(work->path[1]));
 	grh = rdma_ah_read_grh(&cm_id_priv->av.ah_attr);
 	gid_attr = grh->sgid_attr;
 
-	if (gid_attr &&
-	    rdma_protocol_roce(work->port->cm_dev->ib_device,
-			       work->port->port_num)) {
+	if (gid_attr && cm_id_priv->av.ah_attr.type == RDMA_AH_ATTR_TYPE_ROCE) {
 		work->path[0].rec_type =
 			sa_conv_gid_to_pathrec_type(gid_attr->gid_type);
 	} else {
+		cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
 		cm_path_set_rec_type(
 			work->port->cm_dev->ib_device, work->port->port_num,
 			&work->path[0],
-- 
1.8.3.1

