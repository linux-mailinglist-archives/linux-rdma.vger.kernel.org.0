Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4601A7944
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438985AbgDNLRp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 07:17:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgDNLRi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Apr 2020 07:17:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EBE5OV183588;
        Tue, 14 Apr 2020 11:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=U1DYInaWF9r6JLCqRiQSfxpvGShrnJsJYzNtQlYMsPA=;
 b=jAekoehyp68H0g1hHvBT0ect0LfjCX/eYzIBZfxwMAYnBA8eQiIOywlMQbiioF1YRz+c
 Ydw50WmRwaEyXeV3U+j1YCzyDfvzDB36KQ8Nm5xiF2sKWsvoWPvtEUxFy9AcKSKx+mji
 j2jEgakAGZkagBk9D+W3GNchB6Zh4Zc9P0kutW1SPoHhLpTRBDxBeqacOKxMjVBoml9L
 p8JK7sEirMaRU/ZgdvYm+SBRSNsrWqQ6SMHAIMDKr6jgV+gcXkKY4cxQNKKnz01W2mPN
 Srk+BsTj4z8zsHeBUEIS35JTE33tV2iWlYMuB9fl+mlZLtmOZ6cLqDfEhnnF4RLwosLE WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30b5um3w47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 11:17:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EBBwd1058337;
        Tue, 14 Apr 2020 11:17:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30bqpg37xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 11:17:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EBHVNA019599;
        Tue, 14 Apr 2020 11:17:31 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 04:17:30 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, ted.h.kim@oracle.com,
        william.taylor@oracle.com
Subject: [PATCH for-rc] RDMA/cm: Do not send REJ when remote_id is unknown
Date:   Tue, 14 Apr 2020 13:17:20 +0200
Message-Id: <20200414111720.1789168-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In cm_destroy_id(), when the cm_id state is IB_CM_REQ_SENT or
IB_CM_MRA_REQ_RCVD, an attempt is made to send a REJ with
IB_CM_REJ_TIMEOUT as the reject reason.

However, in said states, we have no remote_id. For the REQ_SENT case,
we simply haven't received anything from our peer, for the
MRA_REQ_RCVD case, the cm_rma_handler() doesn't pick up the remote_id.

Therefore, it is no reason to send this REJ, since it simply will be
tossed at the peer's CM layer (if it reaches it). If running in CX-3
virtualized and having the pr_debug enabled in the mlx4_ib driver, we
will see:

mlx4_ib_demux_cm_handler: Couldn't find an entry for pv_cm_id 0x0

because the proxy de-muxer is unable to determine which slave this MAD
packet should be sent to.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4794113ecd59..ed80e5b56e2b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1058,10 +1058,6 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_TIMEOUT,
-				   &cm_id_priv->id.device->node_guid,
-				   sizeof(cm_id_priv->id.device->node_guid),
-				   NULL, 0);
 		break;
 	case IB_CM_REQ_RCVD:
 		if (err == -ENOMEM) {
-- 
2.20.1

