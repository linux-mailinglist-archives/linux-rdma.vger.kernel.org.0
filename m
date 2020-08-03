Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4D4239F90
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgHCGUC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:20:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHCGUB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 02:20:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736HvGP020825;
        Mon, 3 Aug 2020 06:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZNpM8pMFp4bbk9sRI33AZ+uxxs2765hl6RpmmGnAPuk=;
 b=Dz1f5oZlLZ9jqqGwfFB5uKZuceFF3Oe7tmrzQhNxd9oH09UwwzhKgw0SndVa/cvpOhDe
 zxdU1MKUDBJDTGi0O25nQtJWKwgdIhGWWkrHhp4dmnErea+sRK7MUc0fXENqWZxcUgNJ
 gP+/+kjrivZHllcXXIr9SViSbdzNclumCoe2V1BvgzUDYVtjyrnomrEo/0VUaPtSTkLO
 UHUk7xe+lxz62fRPZRcNTRJME7CReUgX7epi/tjB2gpEqjuuqJHyoh7n9c+Ye8T9DFxX
 8yctK7hibw1HL7m13bsBN4SrPlYAncfEXJZ4HfYygATlbmimsn+QrJCboD5B2PcIVmcV Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32n11mvh6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 06:19:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736J01G162817;
        Mon, 3 Aug 2020 06:19:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32p5gqambj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 06:19:54 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0736Jr6p010071;
        Mon, 3 Aug 2020 06:19:53 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2020 23:19:53 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, yishaih@mellanox.com,
        jackm@dev.mellanox.co.il, ranro@mellanox.com
Subject: [PATCH for-rc v2 1/6] IB/mlx4: Add and improve logging
Date:   Mon,  3 Aug 2020 08:19:36 +0200
Message-Id: <20200803061941.1139994-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803061941.1139994-1-haakon.bugge@oracle.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add missing check for success after call to mlx4_ib_send_to_wire() in
mlx4_ib_multiplex_mad().

Amended the existing pr_debug() in mlx4_ib_multiplex_cm_handler() and
mlx4_ib_demux_cm_handler() with attr_id during a lookup failure.

Removed two noisy pr_debug() in mad.c

Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

    v1->v2:
	* Added pr_debug for -EINVAL returns in mlx4_ib_send_to_slave()
	* Amended "Cannot send to"... with MAD type
---
 drivers/infiniband/hw/mlx4/cm.c  |  7 +--
 drivers/infiniband/hw/mlx4/mad.c | 80 ++++++++++++++------------------
 2 files changed, 40 insertions(+), 47 deletions(-)

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
index abe68708d6d6..932786b0689e 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -500,6 +500,13 @@ static int get_gids_from_l3_hdr(struct ib_grh *grh, union ib_gid *sgid,
 					 sgid, dgid);
 }
 
+static int is_proxy_qp0(struct mlx4_ib_dev *dev, int qpn, int slave)
+{
+	int proxy_start = dev->dev->phys_caps.base_proxy_sqpn + 8 * slave;
+
+	return (qpn >= proxy_start && qpn <= proxy_start + 1);
+}
+
 int mlx4_ib_send_to_slave(struct mlx4_ib_dev *dev, int slave, u8 port,
 			  enum ib_qp_type dest_qpt, struct ib_wc *wc,
 			  struct ib_grh *grh, struct ib_mad *mad)
@@ -520,8 +527,10 @@ int mlx4_ib_send_to_slave(struct mlx4_ib_dev *dev, int slave, u8 port,
 	u16 cached_pkey;
 	u8 is_eth = dev->dev->caps.port_type[port] == MLX4_PORT_TYPE_ETH;
 
-	if (dest_qpt > IB_QPT_GSI)
+	if (dest_qpt > IB_QPT_GSI) {
+		pr_debug("dest_qpt (%d) > IB_QPT_GSI\n", dest_qpt);
 		return -EINVAL;
+	}
 
 	tun_ctx = dev->sriov.demux[port-1].tun[slave];
 
@@ -538,12 +547,20 @@ int mlx4_ib_send_to_slave(struct mlx4_ib_dev *dev, int slave, u8 port,
 	if (dest_qpt) {
 		u16 pkey_ix;
 		ret = ib_get_cached_pkey(&dev->ib_dev, port, wc->pkey_index, &cached_pkey);
-		if (ret)
+		if (ret) {
+			pr_debug("unable to get %s cached pkey for index %d, ret %d\n",
+				 is_proxy_qp0(dev, wc->src_qp, slave) ? "SMI" : "GSI",
+				 wc->pkey_index, ret);
 			return -EINVAL;
+		}
 
 		ret = find_slave_port_pkey_ix(dev, slave, port, cached_pkey, &pkey_ix);
-		if (ret)
+		if (ret) {
+			pr_debug("unable to get %s pkey ix for pkey 0x%x, ret %d\n",
+				 is_proxy_qp0(dev, wc->src_qp, slave) ? "SMI" : "GSI",
+				 cached_pkey, ret);
 			return -EINVAL;
+		}
 		tun_pkey_ix = pkey_ix;
 	} else
 		tun_pkey_ix = dev->pkeys.virt2phys_pkey[slave][port - 1][0];
@@ -715,7 +732,8 @@ static int mlx4_ib_demux_mad(struct ib_device *ibdev, u8 port,
 
 		err = mlx4_ib_send_to_slave(dev, slave, port, wc->qp->qp_type, wc, grh, mad);
 		if (err)
-			pr_debug("failed sending to slave %d via tunnel qp (%d)\n",
+			pr_debug("failed sending %s to slave %d via tunnel qp (%d)\n",
+				 is_proxy_qp0(dev, wc->src_qp, slave) ? "SMI" : "GSI",
 				 slave, err);
 		return 0;
 	}
@@ -794,7 +812,8 @@ static int mlx4_ib_demux_mad(struct ib_device *ibdev, u8 port,
 
 	err = mlx4_ib_send_to_slave(dev, slave, port, wc->qp->qp_type, wc, grh, mad);
 	if (err)
-		pr_debug("failed sending to slave %d via tunnel qp (%d)\n",
+		pr_debug("failed sending %s to slave %d via tunnel qp (%d)\n",
+			 is_proxy_qp0(dev, wc->src_qp, slave) ? "SMI" : "GSI",
 			 slave, err);
 	return 0;
 }
@@ -807,27 +826,6 @@ static int ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
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
@@ -1341,14 +1339,6 @@ static int mlx4_ib_multiplex_sa_handler(struct ib_device *ibdev, int port,
 	return ret;
 }
 
-static int is_proxy_qp0(struct mlx4_ib_dev *dev, int qpn, int slave)
-{
-	int proxy_start = dev->dev->phys_caps.base_proxy_sqpn + 8 * slave;
-
-	return (qpn >= proxy_start && qpn <= proxy_start + 1);
-}
-
-
 int mlx4_ib_send_to_wire(struct mlx4_ib_dev *dev, int slave, u8 port,
 			 enum ib_qp_type dest_qpt, u16 pkey_index,
 			 u32 remote_qpn, u32 qkey, struct rdma_ah_attr *attr,
@@ -1484,6 +1474,7 @@ static void mlx4_ib_multiplex_mad(struct mlx4_ib_demux_pv_ctx *ctx, struct ib_wc
 	u16 vlan_id;
 	u8 qos;
 	u8 *dmac;
+	int sts;
 
 	/* Get slave that sent this packet */
 	if (wc->src_qp < dev->dev->phys_caps.base_proxy_sqpn ||
@@ -1580,13 +1571,17 @@ static void mlx4_ib_multiplex_mad(struct mlx4_ib_demux_pv_ctx *ctx, struct ib_wc
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
@@ -1744,9 +1739,6 @@ static void mlx4_ib_tunnel_comp_worker(struct work_struct *work)
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

