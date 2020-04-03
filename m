Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3063119DE2B
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2020 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgDCSnr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Apr 2020 14:43:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58448 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCSnr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Apr 2020 14:43:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033IdwWV012453;
        Fri, 3 Apr 2020 18:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YDnHoIt7Lgnq2Ealo8xWvE/QpCSGTfKIUfaTD62LcMA=;
 b=uEkblMatx3xgHATbhTlyebuj6MwVmvdaifHL0sO57sGAYXIJtDp6whDKJzE9QXG4wYl0
 MTCY7rvc/+8R28pA7mixV7/GhjOwBKVn94WQ4TJWXTaqLxA1xZD6Apg3FruXPuXNKb//
 c32A38IAFLMVT2bKM31Nn2N4E15vTsHC2ohRfTPLtW4xZGaNFT7THM9b63z3ITFS5nsv
 P5yxa0AgDewfqIhtagLBl91k8WA79+MF4ApsGCIlGdZ4GFZYU4lg+u6mwyHNkq65jo3y
 O/RBqOOqoVb3Lk8yMarMX5yQJRHnS5Pl/42OAF0M5Z5sbrvRmv3k3FsG4C3dJ/cJnDRV 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303cevjntf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 18:43:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033IbKOX044970;
        Fri, 3 Apr 2020 18:43:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 304sjtkqc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 18:43:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033Ihcig014243;
        Fri, 3 Apr 2020 18:43:38 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 11:43:38 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, george.kennedy@oracle.com
Subject: [PATCH for-rc] RDMA/cma: fix race between addr_handler and resolve_route
Date:   Fri,  3 Apr 2020 20:43:28 +0200
Message-Id: <20200403184328.1154929-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030151
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A syzkaller test hits a NULL pointer dereference in
rdma_resolve_route():

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
Modules linked in:
CPU: 0 PID: 7185 Comm: syz-executor670 Not tainted 4.14.147 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
task: ffff8880a7c4c0c0 task.stack: ffff888084398000
RIP: 0010:rdma_cap_ib_sa include/rdma/ib_verbs.h:2682 [inline]
RIP: 0010:rdma_resolve_route+0x11f/0x2bf0 drivers/infiniband/core/cma.c:2678
RSP: 0018:ffff88808439fa20 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000029 RSI: 0000000000000001 RDI: 0000000000000148
RBP: ffff88808439fbc0 R08: ffff8880a7c4c0c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88809f540dc0
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88809f540f78
FS:  00007f03a8778700(0000) GS:ffff8880aee00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f03a8777e78 CR3: 000000008afd9000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ucma_resolve_route+0xab/0x100 drivers/infiniband/core/ucma.c:740
  ucma_write+0x231/0x310 drivers/infiniband/core/ucma.c:1672
  __vfs_write+0x105/0x6b0 fs/read_write.c:480
  vfs_write+0x198/0x500 fs/read_write.c:544
  SYSC_write fs/read_write.c:590 [inline]
  SyS_write+0xfd/0x230 fs/read_write.c:582
  do_syscall_64+0x1e8/0x640 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x446a49
RSP: 002b:00007f03a8777db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dbc48 RCX: 0000000000446a49
RDX: 0000000000000010 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00000000006dbc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
R13: 00007ffea0dde3ef R14: 00007f03a87789c0 R15: 0000000000000000
Code: 00 48 c1 ea 03 80 3c 02 00 0f 85 ea 24 00 00 48 b8 00 00 00 00 00 fc
ff df 4d 8b 34 24 49 8d be 48 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00
0f 85 d1 24 00 00 48 b8 00 00 00 00 00 fc ff df 41
RIP: rdma_cap_ib_sa include/rdma/ib_verbs.h:2682 [inline] RSP:
ffff88808439fa20
RIP: rdma_resolve_route+0x11f/0x2bf0 drivers/infiniband/core/cma.c:2678
RSP: ffff88808439fa20

The crash is caused by a race between the CM state updates in
addr_handler() and rdma_resolve_route().

The syzkaller program executes following sequence:

1. rdma_create_id()
2. rdma_resolve_ip()
3. rdma_resolve_route()

Please note the lack of rdma_get_cm_event() between 2 and 3 above. The
following happens:

Thread 1                      CM_ID state                    Thread 2
rdma_create_id()                     IDLE
rdma_resolve_ip()              ADDR_QUERY
                                                       addr_handler()
                            ADDR_RESOLVED                 (set state)
rdma_resolve_route()
  (check state and set to)    ROUTE_QUERY
                                           --> cma_cm_event_handler()
                               DESTROYING             (returns error)
                                                --> rdma_destroy_id()
--> rdma_cap_ib_sa()
(but cm_id has been destroyed)

I see two solutions; a) let addr_handler() only change the state once,
to one of ADDR_RESOLVED, ADDR_BOUND, or DESTROYING or b) add mutex
locking to rdma_resolve_addr(). b) requires addr_handler() to
relinquish the lock when calling the event handler, as the event
handler typically will call rdma_resolve_route() before returning.

The b) solution is implemented herein.

Reported-by: syzbot+69226cc89d87fd4f8f40@syzkaller.appspotmail.com
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Cc: stable@vger.kernel.org
---
 drivers/infiniband/core/cma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2dec3a02ab9f..45f26bc0fbfe 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2979,8 +2979,11 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 	int ret;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED, RDMA_CM_ROUTE_QUERY))
+	mutex_lock(&id_priv->handler_mutex);
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED, RDMA_CM_ROUTE_QUERY)) {
+		mutex_unlock(&id_priv->handler_mutex);
 		return -EINVAL;
+	}
 
 	atomic_inc(&id_priv->refcount);
 	if (rdma_cap_ib_sa(id->device, id->port_num))
@@ -2995,9 +2998,12 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 	if (ret)
 		goto err;
 
+	mutex_unlock(&id_priv->handler_mutex);
 	return 0;
 err:
 	cma_comp_exch(id_priv, RDMA_CM_ROUTE_QUERY, RDMA_CM_ADDR_RESOLVED);
+	mutex_unlock(&id_priv->handler_mutex);
+
 	cma_deref_id(id_priv);
 	return ret;
 }
@@ -3085,6 +3091,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 	struct rdma_cm_event event = {};
 	struct sockaddr *addr;
 	struct sockaddr_storage old_addr;
+	int ret;
 
 	mutex_lock(&id_priv->handler_mutex);
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY,
@@ -3119,7 +3126,11 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 	} else
 		event.event = RDMA_CM_EVENT_ADDR_RESOLVED;
 
-	if (cma_cm_event_handler(id_priv, &event)) {
+	mutex_unlock(&id_priv->handler_mutex);
+	ret = cma_cm_event_handler(id_priv, &event);
+	mutex_lock(&id_priv->handler_mutex);
+
+	if (ret) {
 		cma_exch(id_priv, RDMA_CM_DESTROYING);
 		mutex_unlock(&id_priv->handler_mutex);
 		rdma_destroy_id(&id_priv->id);
-- 
2.20.1

