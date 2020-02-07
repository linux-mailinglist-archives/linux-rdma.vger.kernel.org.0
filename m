Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E95155732
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 12:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGLwU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 06:52:20 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:38122 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBGLwU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Feb 2020 06:52:20 -0500
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 017BqDRr006648;
        Fri, 7 Feb 2020 03:52:15 -0800
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     jgg@ziepe.ca, dledford@redhat.com, bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishna2@chelsio.com
Subject: [PATCH for-review/for-rc/for-rc] RDMA/siw: Remove unwanted WARN_ON in siw_cm_llp_data_ready()
Date:   Fri,  7 Feb 2020 17:22:09 +0530
Message-Id: <20200207115209.25933-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Warnings like below can fill up the dmesg while disconnecting RDMA
connections.
Hence, removing the unwanted WARN_ON.

[72103.557612] WARNING: CPU: 6 PID: 0 at
drivers/infiniband/sw/siw/siw_cm.c:1229 siw_cm_llp_data_ready+0xc1/0xd0
[siw]
[72103.557677] RIP: 0010:siw_cm_llp_data_ready+0xc1/0xd0 [siw]
[72103.557693] Call Trace:
[72103.557711]  tcp_data_queue+0x226/0xb40
[72103.557714]  tcp_rcv_established+0x220/0x620
[72103.557720]  tcp_v4_do_rcv+0x12a/0x1e0
[72103.557722]  tcp_v4_rcv+0xb05/0xc00
[72103.557728]  ip_local_deliver_finish+0x69/0x210
[72103.557730]  ip_local_deliver+0x6b/0xe0
[72103.557735]  ip_rcv+0x273/0x362
[72103.557740]  __netif_receive_skb_core+0xb35/0xc30
[72103.557752]  netif_receive_skb_internal+0x3d/0xb0
[72103.557754]  napi_gro_frags+0x13b/0x200
[72103.557788]  t4_ethrx_handler+0x433/0x7d0 [cxgb4]
[72103.557800]  process_responses+0x318/0x580 [cxgb4]
[72103.557820]  napi_rx_handler+0x14/0x100 [cxgb4]
[72103.557822]  net_rx_action+0x149/0x3b0
[72103.557826]  __do_softirq+0xe3/0x30a
[72103.557831]  irq_exit+0x100/0x110
[72103.557834]  do_IRQ+0x7f/0xe0
[72103.557837]  common_interrupt+0xf/0xf

Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 3bccfef40e7e..bcbc54998ace 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1226,7 +1226,6 @@ static void siw_cm_llp_data_ready(struct sock *sk)
 
 	cep = sk_to_cep(sk);
 	if (!cep) {
-		WARN_ON(1);
 		goto out;
 	}
 	siw_dbg_cep(cep, "state: %d\n", cep->state);
-- 
2.23.0.rc0

