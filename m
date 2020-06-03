Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441D11ED0F2
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgFCNfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 09:35:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53236 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFCNfp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 09:35:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053DWUs4103221
        for <linux-rdma@vger.kernel.org>; Wed, 3 Jun 2020 13:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=xYoFnHnvClOci2PtFpL4SoSPiEq3QPGnXmz0v1ujty0=;
 b=U/EUw749g24y8TgcAz8bSrfwSb/v6sxxAU47n4lwdlpuKQ5gT6rczB1g7OJu1nUe+nFX
 OjK8SfFoi7PQJ1EFq9/WVUCcnyyNijjzkVBYWqUFdoR5EhYANnl8otRC59tw20Y3xecC
 65liQ5NEZTqBydYfg53UhRq2xlWiP0n/u/h9bcdV5VYsmC9Q+xSMXhMKPKTwt3z58VJk
 gK7ea8e8IjqQqo+rKCL7mdZ7e8rF3+MdfmcRfFX/8ru23cnM6eQHP2pIr+ZNOXb8NSdi
 qGZugxVX1trpt8ie0yyUQBVYwGDGQvwJDSSqrKmijBrRHzYo1XGYAjVogUzhXITldT/c TA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfem98uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 13:35:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053DO15L082672
        for <linux-rdma@vger.kernel.org>; Wed, 3 Jun 2020 13:33:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31c25s54sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 13:33:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053DXgYS025761
        for <linux-rdma@vger.kernel.org>; Wed, 3 Jun 2020 13:33:42 GMT
Received: from ca-dev40.us.oracle.com (/10.129.135.27)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 06:33:42 -0700
From:   Ka-Cheong Poon <ka-cheong.poon@oracle.com>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/cm: Spurious WARNING triggered in cm_destroy_id()
Date:   Wed,  3 Jun 2020 06:33:38 -0700
Message-Id: <1591191218-9446-1-git-send-email-ka-cheong.poon@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030107
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Suppose the cm_id state is IB_CM_REP_SENT when cm_destroy_id() is
called.  Then it calls cm_send_rej_locked().  In cm_send_rej_locked(),
it calls cm_enter_timewait() and the state is changed to
IB_CM_TIMEWAIT.  Now back to cm_destroy_id(), it breaks from the
switch statement.  And the next call is WARN_ON(cm_id->state !=
IB_CM_IDLE).  This triggers a spurious warning.  Instead, the code
should goto retest after returning from cm_send_rej_locked().

Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
---
 drivers/infiniband/core/cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 17f14e0..1c2bf18 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1076,7 +1076,9 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-		/* Fall through */
+		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
+				   0, NULL, 0);
+		goto retest;
 	case IB_CM_MRA_REQ_SENT:
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
-- 
1.8.3.1

