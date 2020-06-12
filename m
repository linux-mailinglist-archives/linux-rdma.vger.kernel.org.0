Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F11F7DB7
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 21:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFLTl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jun 2020 15:41:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41762 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jun 2020 15:41:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CJdrGj017722;
        Fri, 12 Jun 2020 19:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=SCP5ZVqb8S94hNxCjiZ28A5hvOtl6mmUnaIVoAgXd7g=;
 b=UGnhLo4qk+io9M6/kdi8S2bSBLXFLV1zjOlWVVRvHlSBhNKOYLaf9yxttrnM1TwAgo4h
 ec1BQb8att9rCqAt0uASW8w+CyKg8oHKU0XL/bdem90g1+3WDVpVefHdOcvATBBJ/Cw1
 NHZX0SaYBtZ2/d4+0/Lc6dN7lxRRChko87RxQWiPeDqaeZmJCnRt8gf+xXCk6lGIlSFF
 fFPobq6yRKEwJTXnAvitm3k1hpJGEUjaggHvNKRCOvwUmWtlNEhInuRXmbojtuSEBljR
 Li8MghxIIYKHEshY02fS0Qc/tuDWDkYiQH15hEBkExJV/CkKrglfxkkPEuirvtaWHSNe 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3sneh8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 19:41:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CJeQ2V029572;
        Fri, 12 Jun 2020 19:41:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31mg2q810u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 19:41:20 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CJfICW009003;
        Fri, 12 Jun 2020 19:41:18 GMT
Received: from ib0.gerd.us.oracle.com (/10.211.52.79)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 12:41:17 -0700
From:   Gerd Rausch <gerd.rausch@oracle.com>
Subject: [PATCH 2.6.26-4.14] IB/ipoib: Arm "send_cq" to process completions in
 due time
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        linux-rdma@vger.kernel.org
Message-ID: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
Date:   Fri, 12 Jun 2020 12:41:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120142
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This issue appears to only exist in Linux versions
2.6.26 through 4.14 inclusively:

With the introduction of commit
f56bcd8013566 ("IPoIB: Use separate CQ for UD send completions")

work completions are only processed once there are
more than 17 outstanding TX work requests.

Unfortunately, that also delays the processing of the
completion handler and holds on to references
held by the "skb" since "dev_kfree_skb_any"
won't be called for a very long time.

E.g. we've observed "nf_conntrack_cleanup_net_list" spin
     around for hours until "net->ct.count" goes down to zero
     on a sufficiently idle interface.

This fix arms the TX CQ after those "poll_tx" loops,
in order for "ipoib_send_comp_handler" to do its thing:

While it's obvious that processing completions one-by-one
is more costly than doing so in bulk,
holding on to "skb" resources for a potentially unlimited
amount of time appears to be a less favorable trade-off.

This issue appears to no longer exist in Linux-4.15
and younger, because the following commit does
call "ib_req_notify_cq" on "send_cq":
8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")

Fixes: f56bcd8013566 ("IPoIB: Use separate CQ for UD send completions")

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ib.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 18f732aa15101..b26b31b9e455e 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -491,8 +491,13 @@ static void drain_tx_cq(struct net_device *dev)
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 
 	netif_tx_lock(dev);
-	while (poll_tx(priv))
-		; /* nothing */
+
+	do {
+		while (poll_tx(priv))
+			; /* nothing */
+	} while (ib_req_notify_cq(priv->send_cq,
+				  IB_CQ_NEXT_COMP |
+				  IB_CQ_REPORT_MISSED_EVENTS) > 0);
 
 	if (netif_queue_stopped(dev))
 		mod_timer(&priv->poll_timer, jiffies + 1);
@@ -628,9 +633,14 @@ void ipoib_send(struct net_device *dev, struct sk_buff *skb,
 		++priv->tx_head;
 	}
 
-	if (unlikely(priv->tx_outstanding > MAX_SEND_CQE))
-		while (poll_tx(priv))
-			; /* nothing */
+	if (unlikely(priv->tx_outstanding > MAX_SEND_CQE)) {
+		do {
+			while (poll_tx(priv))
+				; /* nothing */
+		} while (ib_req_notify_cq(priv->send_cq,
+					  IB_CQ_NEXT_COMP |
+					  IB_CQ_REPORT_MISSED_EVENTS) > 0);
+	}
 }
 
 static void __ipoib_reap_ah(struct net_device *dev)
-- 
2.24.1

