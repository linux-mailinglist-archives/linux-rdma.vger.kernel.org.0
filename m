Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56F131225
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 13:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAFM12 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 07:27:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFM12 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jan 2020 07:27:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006COZvV116476;
        Mon, 6 Jan 2020 12:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=OYKfq0k6Ks9eAeCE15LWFnvtSlX1pgubpu3mHithe9E=;
 b=lw+3ECwfdKeUHinSMgoNpXiOvc6uL0q/Ip2gsVOx8yOX6pQGyFNBpcIiLfDZV6y7LrB+
 7NqAxHccdM6iuo4oTlOZN8bXRLeG/8HAt0fl8DSJOgshsQffIHCobMpGgc5euXvFEx3B
 uSgJU2Burqoh0TovUvc9FGktulYersf3rB2Hnk5aG1PTnqbSVp91tr8/a7GAPqJPG9j0
 iqeP8z/1fH3VvA+QWiQ9Bzbd2fuvGDd7SOQhzgnYsTTnjamVxiiXJaa84HDkUJzBvfD8
 ysP9ZF9hjVZbfb/jtmWSAIC6whHxmMDq7II1hAUE9J5mZQs0Ees/7cYb12T81BWMnKhf Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnppvmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 12:27:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006COOEx070376;
        Mon, 6 Jan 2020 12:27:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xb4v0v8d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 12:27:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 006CRKgS030830;
        Mon, 6 Jan 2020 12:27:20 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 04:27:20 -0800
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RDMA/uverbs] RDMA/uverbs: Protect list_empty() by lock
Date:   Mon,  6 Jan 2020 13:27:11 +0100
Message-Id: <20200106122711.217198-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060114
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In ib_uverbs_event_read(), events are waited for, then pulled off the
kernel's event queue, and finally returned to user space.

There is an explicit check to see if the device is gone, and if so and
the there are no events pending, an -EIO is returned.

However, said test does not check for queue empty whilst holding the
lock, so there is a race where the existing code perceives the queue
to be empty, when it in fact isn't. Fixed by acquiring the lock ahead
of the list_empty() test.

Fixes: 036b10635739 ("IB/uverbs: Enable device removal when there are active user space applications")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/uverbs_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 970d8e31dd65..7165e51790ed 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -245,12 +245,14 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 					     !uverbs_file->device->ib_dev)))
 			return -ERESTARTSYS;
 
+		spin_lock_irq(&ev_queue->lock);
+
 		/* If device was disassociated and no event exists set an error */
 		if (list_empty(&ev_queue->event_list) &&
-		    !uverbs_file->device->ib_dev)
+		    !uverbs_file->device->ib_dev) {
+			spin_unlock_irq(&ev_queue->lock);
 			return -EIO;
-
-		spin_lock_irq(&ev_queue->lock);
+		}
 	}
 
 	event = list_entry(ev_queue->event_list.next, struct ib_uverbs_event, list);
-- 
2.20.1

