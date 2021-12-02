Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD05A466491
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346875AbhLBNkN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 08:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346862AbhLBNkM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 08:40:12 -0500
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450F3C06174A
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 05:36:50 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id B5522B00D87; Thu,  2 Dec 2021 14:36:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id B3F0EB00227;
        Thu,  2 Dec 2021 14:36:48 +0100 (CET)
Date:   Thu, 2 Dec 2021 14:36:48 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Leon Romanovsky <leon@kernel.org>
cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: rdma-core: Add support for multicast loopback prevention to mckey 
Message-ID: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rdma_create_qp createflags option IBV_QP_CREATE_BLOCK_SELF_MCAST_LB
should prevent multicast loopback. However, this feature seems to be
broken on a lot of RDMA NICs and there is no way to test this with the
existing RDMA tools. So add an option to mckey in order to allow to send
multicast messages without loopback. mckey's default has been and will
continue to be to loopback all multicast messages.

Loopback of multicast messages can have surprising effects because all
messages sent out also have to be processed locally by all members of
the multicast group. This usually also includes the sender.

In order to test multicast loop execute the following in two windows
on a host connected to an RDMA fabric.

First session (Receiver)

	mckey -b <RDMA IP address> -m239.1.2.1

Second session (Sender)

	mckey -b <RDMA IP address> -m239.1.2.2 -s -l


The sender will send 10 messages and the receiver will terminate
after 10 messages have been received.

If loopback prevention would work then the receiver should only
terminate on its own when the -l option has not been specified.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: rdma-core/librdmacm/examples/mckey.c
===================================================================
--- rdma-core.orig/librdmacm/examples/mckey.c	2021-12-02 11:02:37.686942517 +0100
+++ rdma-core/librdmacm/examples/mckey.c	2021-12-02 13:23:35.189703027 +0100
@@ -80,6 +80,7 @@ static int message_size = 100;
 static int message_count = 10;
 static int is_sender;
 static int send_only;
+static int loopback = 1;
 static int unmapped_addr;
 static char *dst_addr;
 static char *src_addr;
@@ -132,7 +133,7 @@ static int verify_test_params(struct cma

 static int init_node(struct cmatest_node *node)
 {
-	struct ibv_qp_init_attr init_qp_attr;
+	struct ibv_qp_init_attr_ex init_qp_attr_ex;
 	int cqe, ret;

 	node->pd = ibv_alloc_pd(node->cma_id->verbs);
@@ -150,17 +151,23 @@ static int init_node(struct cmatest_node
 		goto out;
 	}

-	memset(&init_qp_attr, 0, sizeof init_qp_attr);
-	init_qp_attr.cap.max_send_wr = message_count ? message_count : 1;
-	init_qp_attr.cap.max_recv_wr = message_count ? message_count : 1;
-	init_qp_attr.cap.max_send_sge = 1;
-	init_qp_attr.cap.max_recv_sge = 1;
-	init_qp_attr.qp_context = node;
-	init_qp_attr.sq_sig_all = 0;
-	init_qp_attr.qp_type = IBV_QPT_UD;
-	init_qp_attr.send_cq = node->cq;
-	init_qp_attr.recv_cq = node->cq;
-	ret = rdma_create_qp(node->cma_id, node->pd, &init_qp_attr);
+	memset(&init_qp_attr_ex, 0, sizeof init_qp_attr_ex);
+	init_qp_attr_ex.cap.max_send_wr = message_count ? message_count : 1;
+	init_qp_attr_ex.cap.max_recv_wr = message_count ? message_count : 1;
+	init_qp_attr_ex.cap.max_send_sge = 1;
+	init_qp_attr_ex.cap.max_recv_sge = 1;
+	init_qp_attr_ex.qp_context = node;
+	init_qp_attr_ex.sq_sig_all = 0;
+	init_qp_attr_ex.qp_type = IBV_QPT_UD;
+	init_qp_attr_ex.send_cq = node->cq;
+	init_qp_attr_ex.recv_cq = node->cq;
+
+	init_qp_attr_ex.comp_mask = IBV_QP_INIT_ATTR_CREATE_FLAGS|IBV_QP_INIT_ATTR_PD;
+	init_qp_attr_ex.pd = node->pd;
+	if (!loopback)
+		init_qp_attr_ex.create_flags = IBV_QP_CREATE_BLOCK_SELF_MCAST_LB;
+
+	ret = rdma_create_qp_ex(node->cma_id, &init_qp_attr_ex);
 	if (ret) {
 		perror("mckey: unable to create QP");
 		goto out;
@@ -566,7 +573,7 @@ int main(int argc, char **argv)
 {
 	int op, ret;

-	while ((op = getopt(argc, argv, "m:M:sb:c:C:S:p:o")) != -1) {
+	while ((op = getopt(argc, argv, "m:M:sb:c:C:S:p:ol")) != -1) {
 		switch (op) {
 		case 'm':
 			dst_addr = optarg;
@@ -597,6 +604,9 @@ int main(int argc, char **argv)
 		case 'o':
 			send_only = 1;
 			break;
+		case 'l':
+			loopback = 0;
+			break;

 		default:
 			printf("usage: %s\n", argv[0]);
@@ -611,6 +621,7 @@ int main(int argc, char **argv)
 			printf("\t[-p port_space - %#x for UDP (default), "
 			       "%#x for IPOIB]\n", RDMA_PS_UDP, RDMA_PS_IPOIB);
 			printf("\t[-o join as a send-only full-member]\n");
+			printf("\t[-l join without multicast loopback]\n");
 			exit(1);
 		}
 	}
Index: rdma-core/librdmacm/man/mckey.1
===================================================================
--- rdma-core.orig/librdmacm/man/mckey.1	2021-12-02 11:02:37.686942517 +0100
+++ rdma-core/librdmacm/man/mckey.1	2021-12-02 11:02:37.682942580 +0100
@@ -45,6 +45,12 @@ than the MTU of the underlying RDMA tran
 Join the multicast group as a send-only full-member. Otherwise the group is
 joined as a full-member.
 .TP
+.TP
+\-l
+Prevent multicast message loopback. Other receivers on the local system will not receive
+the multicast messages. Otherwise all multicast messages are also send to the host they
+originated from and local listeners (and probably the sending process itself) will receive
+the messages.
 \-p port_space
 The port space of the datagram communication.  May be either the RDMA
 UDP (0x0111) or IPoIB (0x0002) port space.  (default RDMA_PS_UDP)
