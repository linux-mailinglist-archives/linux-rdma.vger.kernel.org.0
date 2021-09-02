Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4C3FEE5D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbhIBNJH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhIBNJH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 09:09:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD7C061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 06:08:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e1so1137001plt.11
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcVnJQEhgtcOxINMlj+i4YpyBZo/hQgIS6EKROvLd1Q=;
        b=JTNEABJwi7PZEx0z3/poMSdlNLxtNbh+iR5h20eqUYOzqueYfnt4PG1NWoRArNjWwQ
         R2o+n43Fl0fn5PqMCJyTu26mBKGLipO72tl7uAbOH0vDm3CEg9iJ5lFKS9m8WdWM4CCM
         kJXbk+OJpe+8h0i6hvUj28hE2dZ9+k0MjpVZqnPx2ParuGB7T5YgYKSFCJ0cOeFyyQ5e
         fW0tCSJpR3H4R7IG60bBME7uXGiPGqD8qMRg1AY3jihY/9JGQr4WIviQyDoZuzHeoqpb
         fVbRwmhkSzsAdcADx5FV/8N6mbuA9kPZajJi5Nkxxjz3z5ET0la7JI2v03vYYmtG6dHS
         i2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcVnJQEhgtcOxINMlj+i4YpyBZo/hQgIS6EKROvLd1Q=;
        b=p2TXdDk5gachLp4Agz/g3qxKAZwtE93D/FF4eGIk093oy0takgJoDjmBVxhCD/+8sV
         PQHmPUdalCytZrG3yB+z1S86PUFIi4XVoz0xCXrkF0esapHh5vddUJImDaqzVCmQR4t2
         A6mV7w6z2HIDsdgLIvPeR6RRmtjAZ7ujkiLWKpkNSRmT1nyB6JoLyNrGQpSaQkN0c7XH
         47iyZMCTyGJq1HlziRTyTA2xCqXPGsE4aXdTZA7BGk1nMmQ8TXwG2d8J19g1VJl8aENN
         xhfaeqakVEQtQ35W318dztEYsZSv52h873rpUcEhL/mF7A9ydL/BunNRldCFNlnjL93o
         OhPw==
X-Gm-Message-State: AOAM532dsJzedUq+bSkkEfpSrU95CyOzzibNzkgDBvdLF1Yw3lijweyo
        JVFrBSN2QQBrwIwUS7DHbvMPjQ==
X-Google-Smtp-Source: ABdhPJyOa8c/fisZvhGLKr6cJ+Z9Gq1L8p8QU4yJI1LbZ3QlsbzL7rLS2qxGOLhnro5Yb4pTJowjyA==
X-Received: by 2002:a17:90a:3ec4:: with SMTP id k62mr3901890pjc.32.1630588087548;
        Thu, 02 Sep 2021 06:08:07 -0700 (PDT)
Received: from C02FR1DUMD6V.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id d6sm2307415pfa.135.2021.09.02.06.08.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:08:07 -0700 (PDT)
From:   Junji Wei <weijunji@bytedance.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com,
        jasowang@redhat.com, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de
Cc:     xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        weijunji@bytedance.com, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC 3/5] RDMA/virtio-rdma: VirtIO RDMA test module
Date:   Thu,  2 Sep 2021 21:06:23 +0800
Message-Id: <20210902130625.25277-4-weijunji@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210902130625.25277-1-weijunji@bytedance.com>
References: <20210902130625.25277-1-weijunji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a test module for virtio-rdma, it can
work with rc_pingpong server included in rdma-core.

Signed-off-by: Junji Wei <weijunji@bytedance.com>
---
 drivers/infiniband/hw/virtio/Makefile              |   1 +
 .../hw/virtio/virtio_rdma_rc_pingpong_client.c     | 477 +++++++++++++++++++++
 2 files changed, 478 insertions(+)
 create mode 100644 drivers/infiniband/hw/virtio/virtio_rdma_rc_pingpong_client.c

diff --git a/drivers/infiniband/hw/virtio/Makefile b/drivers/infiniband/hw/virtio/Makefile
index fb637e467167..eb72a0aa48f3 100644
--- a/drivers/infiniband/hw/virtio/Makefile
+++ b/drivers/infiniband/hw/virtio/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_INFINIBAND_VIRTIO_RDMA) += virtio_rdma.o
+obj-m := virtio_rdma_rc_pingpong_client.o
 
 virtio_rdma-y := virtio_rdma_main.o virtio_rdma_device.o virtio_rdma_ib.o \
 		 virtio_rdma_netdev.o
diff --git a/drivers/infiniband/hw/virtio/virtio_rdma_rc_pingpong_client.c b/drivers/infiniband/hw/virtio/virtio_rdma_rc_pingpong_client.c
new file mode 100644
index 000000000000..d1a38fe8f8cd
--- /dev/null
+++ b/drivers/infiniband/hw/virtio/virtio_rdma_rc_pingpong_client.c
@@ -0,0 +1,477 @@
+/*
+ * Virtio RDMA device: Test client
+ *
+ * Copyright (C) 2021 Junji Wei Bytedance Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include<linux/in.h>
+#include<linux/inet.h>
+#include<linux/socket.h>
+#include<net/sock.h>
+
+#include <asm/dma.h>
+
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_cache.h>
+#include "../../core/uverbs.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Junji Wei");
+MODULE_DESCRIPTION("Virtio rdma test module");
+MODULE_VERSION("0.01");
+
+#define SERVER_ADDR "10.131.251.125"
+#define SERVER_PORT 18515
+
+#define RX_DEPTH 500
+#define ITER 500
+#define PAGES 5
+
+struct pingpong_dest {
+    int 				lid;
+    int 				out_reads;
+    int 				qpn;
+    int 				psn;
+    unsigned			rkey;
+    unsigned long long		vaddr;
+    union ib_gid			gid;
+    unsigned			srqn;
+    int				gid_index;
+};
+
+static struct ib_device* open_dev(char* path)
+{
+	struct ib_device *ib_dev;
+    struct ib_uverbs_file *file;
+    struct file* filp;
+    struct ib_port_attr port_attr;
+    int rc;
+
+    filp = filp_open(path, O_RDWR | O_CLOEXEC, 0);
+    if (!filp)
+        pr_err("Open failed\n");
+
+    file = filp->private_data;
+    ib_dev = file->device->ib_dev;
+    if (!ib_dev)
+        pr_err("Get ib_dev failed\n");
+
+    pr_info("Open ib_device %s\n", ib_dev->node_desc);
+
+    /* test query_port */
+    rc = ib_query_port(ib_dev, 1, &port_attr);
+    if (rc)
+        pr_err("Query port failed\n");
+    pr_info("Port gid_tbl_len %d\n", port_attr.gid_tbl_len);
+
+	return ib_dev;
+}
+
+static struct socket* ethernet_client_connect(void)
+{
+	struct socket *sock;
+    struct sockaddr_in s_addr;
+    int ret;
+
+    memset(&s_addr,0,sizeof(s_addr));
+    s_addr.sin_family=AF_INET;
+    s_addr.sin_port=htons(SERVER_PORT);
+    
+    s_addr.sin_addr.s_addr = in_aton(SERVER_ADDR);
+    sock = (struct socket *)kmalloc(sizeof(struct socket), GFP_KERNEL);
+
+    /*create a socket*/
+    ret = sock_create_kern(&init_net, AF_INET, SOCK_STREAM, 0, &sock);
+    if (ret < 0) {
+        pr_err("client: socket create error\n");
+    }
+    pr_info("client: socket create ok\n");
+
+    /*connect server*/
+    ret = sock->ops->connect(sock, (struct sockaddr *)&s_addr, sizeof(s_addr), 0);
+    if (ret) {
+        pr_err("client: connect error\n");
+        return NULL;
+    }
+    pr_info("client: connect ok\n");
+
+    return sock;
+}
+
+static int ethernet_read_data(struct socket *sock, char* buf, int size) {
+    struct kvec vec;
+    struct msghdr msg;
+    int ret;
+
+    memset(&vec,0,sizeof(vec));
+    memset(&msg,0,sizeof(msg));
+    vec.iov_base = buf;
+    vec.iov_len = size;
+
+    ret = kernel_recvmsg(sock, &msg, &vec, 1, size, 0);
+    if (ret < 0) {
+        pr_err("read failed\n");
+        return ret;
+    }
+    return ret;
+}
+
+static int ethernet_write_data(struct socket *sock, char* buf, int size) {  
+    struct kvec vec;
+    struct msghdr msg;
+    int ret;
+
+    vec.iov_base = buf;
+    vec.iov_len = size;
+
+    memset(&msg,0,sizeof(msg));
+
+    ret = kernel_sendmsg(sock, &msg, &vec, 1, size);
+    if (ret < 0) {
+        pr_err("kernel_sendmsg error\n");
+        return ret;
+    }else if(ret != size){
+        pr_info("write ret != size");
+    }
+
+    pr_info("send success\n");
+    return ret;
+}
+
+static void gid_to_wire_gid(const union ib_gid *gid, char wgid[])
+{
+	uint32_t tmp_gid[4];
+	int i;
+
+	memcpy(tmp_gid, gid, sizeof(tmp_gid));
+	for (i = 0; i < 4; ++i)
+		sprintf(&wgid[i * 8], "%08x", cpu_to_be32(tmp_gid[i]));
+}
+
+void wire_gid_to_gid(const char *wgid, union ib_gid *gid)
+{
+	char tmp[9];
+	__be32 v32;
+	int i;
+	uint32_t tmp_gid[4];
+
+	for (tmp[8] = 0, i = 0; i < 4; ++i) {
+		memcpy(tmp, wgid + i * 8, 8);
+		sscanf(tmp, "%x", &v32);
+		tmp_gid[i] = be32_to_cpu(v32);
+	}
+	memcpy(gid, tmp_gid, sizeof(*gid));
+}
+
+static struct pingpong_dest *pp_client_exch_dest(const struct pingpong_dest *my_dest)
+{
+    struct socket* sock;
+	char msg[sizeof "0000:000000:000000:00000000000000000000000000000000"];
+	struct pingpong_dest *rem_dest = NULL;
+	char gid[33];
+
+    sock = ethernet_client_connect();
+    if (!sock) {
+        return NULL;
+    }
+
+	gid_to_wire_gid(&my_dest->gid, gid);
+	sprintf(msg, "%04x:%06x:%06x:%s", my_dest->lid, my_dest->qpn,
+							my_dest->psn, gid);
+    pr_info("Local %s\n", msg);
+	if (ethernet_write_data(sock, msg, sizeof msg) != sizeof msg) {
+		pr_err("Couldn't send local address\n");
+		goto out;
+	}
+
+	if (ethernet_read_data(sock, msg, sizeof msg) != sizeof msg ||
+	    ethernet_write_data(sock, "done", sizeof "done") != sizeof "done") {
+		pr_err("Couldn't read/write remote address\n");
+		goto out;
+	}
+
+	rem_dest = kmalloc(sizeof *rem_dest, GFP_KERNEL);
+	if (!rem_dest)
+		goto out;
+
+    pr_info("Remote %s\n", msg);
+	sscanf(msg, "%x:%x:%x:%s", &rem_dest->lid, &rem_dest->qpn,
+						&rem_dest->psn, gid);
+	wire_gid_to_gid(gid, &rem_dest->gid);
+
+out:
+	return rem_dest;
+}
+
+static int __init rdma_test_init(void) {
+    struct ib_device* ib_dev;
+    struct ib_pd* pd;
+    struct ib_mr *mr, *mr_recv;
+    uint64_t dma_addr, dma_addr_recv;
+    struct scatterlist sg;
+    struct scatterlist sgr;
+    const struct ib_cq_init_attr cq_attr = { 64, 0, 0 };
+    struct ib_cq *cq;
+    struct ib_qp *qp;
+    struct ib_qp_init_attr qp_init_attr = {
+        .event_handler = NULL,
+        .qp_context = NULL,
+        .srq = NULL,
+        .xrcd = NULL,
+        .cap = {
+            RX_DEPTH, RX_DEPTH, 1, 1, -1, 0
+        },
+        .sq_sig_type = IB_SIGNAL_ALL_WR,
+        .qp_type = IB_QPT_RC,
+        .create_flags = 0,
+        .port_num = 0,
+        .rwq_ind_tbl = NULL,
+        .source_qpn = 0
+    };
+    struct ib_qp_attr qp_attr = {};
+    struct ib_port_attr port_attr;
+    struct pingpong_dest my_dest;
+    struct pingpong_dest *rem_dest;
+    int mask, rand_num, iter;
+    struct ib_rdma_wr swr;
+    const struct ib_send_wr *bad_swr;
+    struct ib_recv_wr rwr;
+    const struct ib_recv_wr *bad_rwr;
+    struct ib_sge wsge[1], rsge[1];
+    uint64_t *addr_send, *addr_recv;
+    int i, wc_got;
+    struct ib_wc wc[2];
+    struct ib_reg_wr reg_wr;
+
+    ktime_t t0;
+    uint64_t rt;
+    int wc_total = 0;
+
+    pr_info("Start rdma test\n");
+    pr_info("Normal address: 0x%lu -- 0x%px\n", MAX_DMA_ADDRESS, high_memory);
+    
+    ib_dev = open_dev("/dev/infiniband/uverbs0");
+
+    pd = ib_alloc_pd(ib_dev, 0);
+    if (!pd) {
+        pr_err("alloc_pd failed\n");
+        return -ENOMEM;
+    }
+
+    mr = ib_alloc_mr(pd, IB_MR_TYPE_MEM_REG, PAGES);
+    mr_recv = ib_alloc_mr(pd, IB_MR_TYPE_MEM_REG, PAGES);
+    if (!mr || !mr_recv) {
+        pr_err("alloc_mr failed\n");
+        return -EIO;
+    }
+
+    addr_send = ib_dma_alloc_coherent(ib_dev, PAGE_SIZE * PAGES, &dma_addr, GFP_KERNEL);
+    memset((char*)addr_send, '?', 4096 * PAGES);
+    sg_dma_address(&sg) = dma_addr;
+	sg_dma_len(&sg) = PAGE_SIZE * PAGES;
+    ib_map_mr_sg(mr, &sg, 1, NULL, PAGE_SIZE);
+
+    addr_recv = ib_dma_alloc_coherent(ib_dev, PAGE_SIZE * PAGES, &dma_addr_recv, GFP_KERNEL);
+    sg_dma_address(&sgr) = dma_addr_recv;
+	sg_dma_len(&sgr) = PAGE_SIZE * PAGES;
+    ib_map_mr_sg(mr_recv, &sgr, 1, NULL, PAGE_SIZE);
+
+    memset((char*)addr_recv, 'x', 4096 * PAGES);
+    strcpy((char*)addr_recv, "hello world");
+    pr_info("Before %s\n", (char*)addr_send);
+    pr_info("Before %s\n", (char*)addr_recv);
+
+    cq = ib_create_cq(ib_dev, NULL, NULL, NULL, &cq_attr);
+    if (!cq) {
+        pr_err("create_cq failed\n");
+    }
+
+    qp_init_attr.send_cq = cq;
+    qp_init_attr.recv_cq = cq;
+    pr_info("qp type: %d\n", qp_init_attr.qp_type);
+    qp = ib_create_qp(pd, &qp_init_attr);
+    if (!qp) {
+        pr_err("create_qp failed\n");
+    }
+
+    // modify to init
+    memset(&qp_attr, 0, sizeof(qp_attr));
+    mask = IB_QP_STATE | IB_QP_ACCESS_FLAGS | IB_QP_PKEY_INDEX | IB_QP_PORT;
+    qp_attr.qp_state = IB_QPS_INIT;
+    qp_attr.port_num = 1;
+    qp_attr.pkey_index = 0;
+    qp_attr.qp_access_flags = 0;
+    ib_modify_qp(qp, &qp_attr, mask);
+
+    memset(&reg_wr, 0, sizeof(reg_wr));
+	reg_wr.wr.opcode = IB_WR_REG_MR;
+	reg_wr.wr.num_sge = 0;
+	reg_wr.mr = mr;
+	reg_wr.key = mr->lkey;
+	reg_wr.access = IB_ACCESS_LOCAL_WRITE;
+    ib_post_send(qp, &reg_wr.wr, &bad_swr);
+
+    memset(&reg_wr, 0, sizeof(reg_wr));
+	reg_wr.wr.opcode = IB_WR_REG_MR;
+	reg_wr.wr.num_sge = 0;
+	reg_wr.mr = mr_recv;
+	reg_wr.key = mr_recv->lkey;
+	reg_wr.access = IB_ACCESS_LOCAL_WRITE;
+    ib_post_send(qp, &reg_wr.wr, &bad_swr);
+
+    // post recv
+    rsge[0].addr = dma_addr_recv;
+    rsge[0].length = 4096 * PAGES;
+    rsge[0].lkey = mr_recv->lkey;
+
+    rwr.next = NULL;
+    rwr.wr_id = 1;
+    rwr.sg_list = rsge;
+    rwr.num_sge = 1;
+    for (i = 0; i < ITER; i++) {
+        if (ib_post_recv(qp, &rwr, &bad_rwr)) {
+            pr_err("post recv failed\n");
+            return -EIO;
+        }
+    }
+
+    // exchange info
+	if (ib_query_port(ib_dev, 1, &port_attr))
+		pr_err("query port failed");
+    my_dest.lid = port_attr.lid;
+
+    // TODO: fix rdma_query_gid
+    if (rdma_query_gid(ib_dev, 1, 1, &my_dest.gid))
+        pr_err("query gid failed");
+
+    get_random_bytes(&rand_num, sizeof(rand_num));
+    my_dest.gid_index = 1;
+    my_dest.qpn = qp->qp_num;
+    my_dest.psn = rand_num & 0xffffff;
+
+    pr_info("  local address:  LID 0x%04x, QPN 0x%06x, PSN 0x%06x, GID %pI6\n",
+	         my_dest.lid, my_dest.qpn, my_dest.psn, &my_dest.gid);
+
+    rem_dest = pp_client_exch_dest(&my_dest);
+    if (!rem_dest) {
+        return -EIO;
+    }
+
+    pr_info("  remote address: LID 0x%04x, QPN 0x%06x, PSN 0x%06x, GID %pI6\n",
+	       rem_dest->lid, rem_dest->qpn, rem_dest->psn, &rem_dest->gid);
+
+    my_dest.rkey = mr->rkey;
+    my_dest.out_reads = 1;
+    my_dest.vaddr = dma_addr;
+    my_dest.srqn = 0;
+
+    // modify to rtr
+    memset(&qp_attr, 0, sizeof(qp_attr));
+    mask = IB_QP_STATE | IB_QP_AV | IB_QP_PATH_MTU | IB_QP_DEST_QPN | IB_QP_RQ_PSN | IB_QP_MIN_RNR_TIMER | IB_QP_MAX_DEST_RD_ATOMIC;
+	qp_attr.qp_state		= IB_QPS_RTR;
+	qp_attr.path_mtu		= IB_MTU_1024;
+	qp_attr.dest_qp_num		= rem_dest->qpn;
+	qp_attr.rq_psn			= rem_dest->psn;
+	qp_attr.max_dest_rd_atomic	= 1;
+	qp_attr.min_rnr_timer		= 12;
+    qp_attr.ah_attr.ah_flags = IB_AH_GRH;
+	qp_attr.ah_attr.ib.dlid = rem_dest->lid; // is_global  lid
+    qp_attr.ah_attr.ib.src_path_bits = 0;
+	qp_attr.ah_attr.sl		= 0;
+	qp_attr.ah_attr.port_num	= 1;
+
+	if (rem_dest->gid.global.interface_id) {
+		qp_attr.ah_attr.grh.hop_limit = 1;
+		qp_attr.ah_attr.grh.dgid = rem_dest->gid;
+		qp_attr.ah_attr.grh.sgid_index = my_dest.gid_index;
+	}
+
+    if (ib_modify_qp(qp, &qp_attr, mask)) {
+        pr_info("Failed to modify to RTR\n");
+        return -EIO;
+    }
+
+    // modify to rts
+    memset(&qp_attr, 0, sizeof(qp_attr));
+    mask = IB_QP_STATE | IB_QP_SQ_PSN | IB_QP_TIMEOUT | IB_QP_RETRY_CNT | IB_QP_RNR_RETRY | IB_QP_MAX_QP_RD_ATOMIC;
+    qp_attr.qp_state = IB_QPS_RTS;
+	qp_attr.sq_psn = my_dest.psn;
+    qp_attr.timeout   = 14;
+    qp_attr.retry_cnt = 7;
+    qp_attr.rnr_retry = 7;
+    qp_attr.max_rd_atomic  = 1;
+    if (ib_modify_qp(qp, &qp_attr, mask)) {
+        pr_info("Failed to modify to RTS\n");
+    }
+
+    wsge[0].addr = dma_addr;
+    wsge[0].length = 4096 * PAGES;
+    wsge[0].lkey = mr->lkey;
+
+    swr.wr.next = NULL;
+    swr.wr.wr_id = 2;
+    swr.wr.sg_list = wsge;
+    swr.wr.num_sge = 1;
+    swr.wr.opcode = IB_WR_SEND;
+    swr.wr.send_flags = IB_SEND_SIGNALED;
+    swr.remote_addr = rem_dest->vaddr;
+    swr.rkey = rem_dest->rkey;
+
+    t0 = ktime_get();
+
+    for (iter = 0; iter < ITER; iter++) {
+        if (ib_post_send(qp, &swr.wr, &bad_swr)) {
+            pr_err("post send failed\n");
+            return -EIO;
+        }
+
+        do {
+            wc_got = ib_poll_cq(cq, 2, wc);
+        } while(wc_got < 1);
+        wc_total += wc_got;
+    }
+
+    pr_info("Total wc %d\n", wc_total);
+    do {
+        wc_total += ib_poll_cq(cq, 2, wc);
+    }while(wc_total < ITER * 2);
+
+    rt = ktime_to_us(ktime_sub(ktime_get(), t0));
+    pr_info("%d iters in %lld us = %lld usec/iter\n", ITER, rt, rt / ITER);
+    pr_info("%d bytes in %lld us = %lld Mbit/sec\n", ITER * 4096 * 2, rt, (uint64_t)ITER * 62500 / rt);
+
+    pr_info("After %s\n", (char*)addr_send);
+    pr_info("After %s\n", (char*)addr_recv);
+
+    ib_destroy_qp(qp);
+    ib_destroy_cq(cq);
+    ib_dereg_mr(mr);
+    ib_dereg_mr(mr_recv);
+    ib_dealloc_pd(pd);
+    return 0;
+}
+
+static void __exit rdma_test_exit(void) {
+    pr_info("Exit rdma test\n");
+}
+
+module_init(rdma_test_init);
+module_exit(rdma_test_exit);
-- 
2.11.0

