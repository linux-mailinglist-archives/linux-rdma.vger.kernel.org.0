Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B5225E73
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgGTMXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 08:23:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54332 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgGTMXL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 08:23:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCI7Me188528;
        Mon, 20 Jul 2020 12:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Sf16veaXJvuJsaU+dsBZop2gDYFIdtGYUf4PJiX/RQk=;
 b=a0UdCh4NywUd3HQls30h/uKjBMgMTBR6uDWAbN7KDM0xH1Zz4CL4Br9ONgYu4ZnWKNXl
 APdB8rMgbkeeVYbCXpniI71bkGaP9qt6dLrt7uM/I0b1P50iDkIZ7ABRg3zub57vB8qe
 MnJfjOd7UZ/dOtcGphXmRCswIAW6g5axY8snTHhq/BDIJTszfWAkLoKrAfmFhQZSyrkO
 08H9x8STtJfsmFrVlJzj4rt8e0Q1e5M6AiWBAOtLfUoyvmZI5fMfv0VURFZxj3AVuxhr
 MQLWX6ApZQUCVKisIDRzZHlj9PT4232WmFlxTVIUFX8X+G6okXy2YCUoDWiTMnB8dDAC +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 32bpkaxtej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 12:23:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCDuMl027184;
        Mon, 20 Jul 2020 12:23:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32d8kyqmgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 12:23:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KCN2kc013820;
        Mon, 20 Jul 2020 12:23:02 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 05:23:01 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>
Subject: [PATCH for-rc 1/5] IB/mlx4: Add and improve logging
Date:   Mon, 20 Jul 2020 14:22:45 +0200
Message-Id: <20200720122249.487086-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720122249.487086-1-haakon.bugge@oracle.com>
References: <20200720122249.487086-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200085
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add missing check for success after call to mlx4_ib_send_to_wire() in
mlx4_ib_multiplex_mad().

Amended the existing pr_debug() in mlx4_ib_multiplex_cm_handler() and
mlx4_ib_demux_cm_handler() with attr_id during a lookup failure.

Removed two noisy pr_debug() in mad.c

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c  |  7 +++---
 drivers/infiniband/hw/mlx4/mad.c | 43 +++++++++-----------------------
 2 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index b591861934b3..302ea7ec2008 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -314,8 +314,8 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 	}
 
 	if (!id) {
-		pr_debug("id{slave: %d, sl_cm_id: 0x%x} is NULL!\n",
-			 slave_id, sl_cm_id);
+		pr_debug("id{slave: %d, sl_cm_id: 0x%x} is NULL! attr_id: 0x%x\n",
+			 slave_id, sl_cm_id, be16_to_cpu(mad->mad_hdr.attr_id));
 		return -EINVAL;
 	}
 
@@ -354,7 +354,8 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 	id = id_map_get(ibdev, (int *)&pv_cm_id, -1, -1);
 
 	if (!id) {
-		pr_debug("Couldn't find an entry for pv_cm_id 0x%x\n", pv_cm_id);
+		pr_debug("Couldn't find an entry for pv_cm_id 0x%x, attr_id 0x%x\n",
+			 pv_cm_id, be16_to_cpu(mad->mad_hdr.attr_id));
 		return -ENOENT;
 	}
 
diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index abe68708d6d6..04316ba55a8c 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -807,27 +807,6 @@ static int ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	int err;
 	struct ib_port_attr pattr;
 
-	if (in_wc && in_wc->qp) {
-		pr_debug("received MAD: port:%d slid:%d sqpn:%d "
-			 "dlid_bits:%d dqpn:%d wc_flags:0x%x tid:%016llx cls:%x mtd:%x atr:%x\n",
-			 port_num,
-			 in_wc->slid, in_wc->src_qp,
-			 in_wc->dlid_path_bits,
-			 in_wc->qp->qp_num,
-			 in_wc->wc_flags,
-			 be64_to_cpu(in_mad->mad_hdr.tid),
-			 in_mad->mad_hdr.mgmt_class, in_mad->mad_hdr.method,
-			 be16_to_cpu(in_mad->mad_hdr.attr_id));
-		if (in_wc->wc_flags & IB_WC_GRH) {
-			pr_debug("sgid_hi:0x%016llx sgid_lo:0x%016llx\n",
-				 be64_to_cpu(in_grh->sgid.global.subnet_prefix),
-				 be64_to_cpu(in_grh->sgid.global.interface_id));
-			pr_debug("dgid_hi:0x%016llx dgid_lo:0x%016llx\n",
-				 be64_to_cpu(in_grh->dgid.global.subnet_prefix),
-				 be64_to_cpu(in_grh->dgid.global.interface_id));
-		}
-	}
-
 	slid = in_wc ? ib_lid_cpu16(in_wc->slid) : be16_to_cpu(IB_LID_PERMISSIVE);
 
 	if (in_mad->mad_hdr.method == IB_MGMT_METHOD_TRAP && slid == 0) {
@@ -1484,6 +1463,7 @@ static void mlx4_ib_multiplex_mad(struct mlx4_ib_demux_pv_ctx *ctx, struct ib_wc
 	u16 vlan_id;
 	u8 qos;
 	u8 *dmac;
+	int sts;
 
 	/* Get slave that sent this packet */
 	if (wc->src_qp < dev->dev->phys_caps.base_proxy_sqpn ||
@@ -1580,13 +1560,17 @@ static void mlx4_ib_multiplex_mad(struct mlx4_ib_demux_pv_ctx *ctx, struct ib_wc
 					&vlan_id, &qos))
 		rdma_ah_set_sl(&ah_attr, qos);
 
-	mlx4_ib_send_to_wire(dev, slave, ctx->port,
-			     is_proxy_qp0(dev, wc->src_qp, slave) ?
-			     IB_QPT_SMI : IB_QPT_GSI,
-			     be16_to_cpu(tunnel->hdr.pkey_index),
-			     be32_to_cpu(tunnel->hdr.remote_qpn),
-			     be32_to_cpu(tunnel->hdr.qkey),
-			     &ah_attr, wc->smac, vlan_id, &tunnel->mad);
+	sts = mlx4_ib_send_to_wire(dev, slave, ctx->port,
+				   is_proxy_qp0(dev, wc->src_qp, slave) ?
+				   IB_QPT_SMI : IB_QPT_GSI,
+				   be16_to_cpu(tunnel->hdr.pkey_index),
+				   be32_to_cpu(tunnel->hdr.remote_qpn),
+				   be32_to_cpu(tunnel->hdr.qkey),
+				   &ah_attr, wc->smac, vlan_id, &tunnel->mad);
+	if (sts)
+		pr_debug("failed sending %s to wire on behalf of slave %d (%d)\n",
+			 is_proxy_qp0(dev, wc->src_qp, slave) ? "SMI" : "GSI",
+			 slave, sts);
 }
 
 static int mlx4_ib_alloc_pv_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
@@ -1744,9 +1728,6 @@ static void mlx4_ib_tunnel_comp_worker(struct work_struct *work)
 					       "buf:%lld\n", wc.wr_id);
 				break;
 			case IB_WC_SEND:
-				pr_debug("received tunnel send completion:"
-					 "wrid=0x%llx, status=0x%x\n",
-					 wc.wr_id, wc.status);
 				rdma_destroy_ah(tun_qp->tx_ring[wc.wr_id &
 					      (MLX4_NUM_TUNNEL_BUFS - 1)].ah, 0);
 				tun_qp->tx_ring[wc.wr_id & (MLX4_NUM_TUNNEL_BUFS - 1)].ah
-- 
2.20.1

