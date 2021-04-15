Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D366360870
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 13:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhDOLoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Apr 2021 07:44:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43952 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOLoR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Apr 2021 07:44:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FBeBKq015464;
        Thu, 15 Apr 2021 11:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2AxVFwog0e97YSVlWCiLMLRYovxMu3swGz0p7atWqqU=;
 b=T9XBtnod22Fwd5LrOHeos05zj21nlPJAglWdDz+kAap0ycnd3n6Up/vLE/mnirHB6sMQ
 prTPkuzxQO3W4svTBau6pUSDAdzTIaoKmKxcsVxvCkfiX6FYj2jWBElMLbkO4G2zM6Uf
 U+VsZgjc5uUkg/bTcfBFzsWPBtXvitA5gGJD1u6WfX4owxekjEFmYE5DiD49hPV8KYNQ
 NiaY5hsWUyjgapcXcwJ6nFBIShYfz28g625k0VZaPcm3D6IbKDaOD7dui6OUPY9HeMtb
 nkvwi/oTNOliaFMIuD/yfKV9GlYtAvVMYhHdc/Z+gVmeHvXCalj4sVs7JE8I+e4lqgLR vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hbnnhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 11:43:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FBeb0X044487;
        Thu, 15 Apr 2021 11:43:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 37unksfnsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 11:43:52 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13FBhpjB026280;
        Thu, 15 Apr 2021 11:43:51 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Apr 2021 04:43:51 -0700
From:   Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jack Morgenstein <jackm@nvidia.com>
Subject: [PATCH] net/mlx4: Treat VFs fair when handling comm_channel_events
Date:   Thu, 15 Apr 2021 13:43:42 +0200
Message-Id: <1618487022-15770-1-git-send-email-hans.westgaard.ry@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150078
X-Proofpoint-GUID: J4f8wR8S3Uu3QNiyZmPUakPu0bmeezUq
X-Proofpoint-ORIG-GUID: J4f8wR8S3Uu3QNiyZmPUakPu0bmeezUq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Handling comm_channel_event in mlx4_master_comm_channel uses a double
loop to determine which slaves have requested work. The search is
always started at lowest slave. This leads to unfairness; lower VFs
tends to be prioritized over higher VFs.

The patch uses find_next_bit to determine which slaves to handle.
Fairness is implemented by always starting at the next to the last
start.

An MPI program has been used to measure improvements. It runs 500
ibv_reg_mr, synchronizes with all other instances and then runs 500
ibv_dereg_mr.

The results running 500 processes, time reported is for running 500
calls:

ibv_reg_mr:
             Mod.   Org.
mlx4_1    403.356ms 424.674ms
mlx4_2    403.355ms 424.674ms
mlx4_3    403.354ms 424.674ms
mlx4_4    403.355ms 424.674ms
mlx4_5    403.357ms 424.677ms
mlx4_6    403.354ms 424.676ms
mlx4_7    403.357ms 424.675ms
mlx4_8    403.355ms 424.675ms

ibv_dereg_mr:
             Mod.   Org.
mlx4_1    116.408ms 142.818ms
mlx4_2    116.434ms 142.793ms
mlx4_3    116.488ms 143.247ms
mlx4_4    116.679ms 143.230ms
mlx4_5    112.017ms 107.204ms
mlx4_6    112.032ms 107.516ms
mlx4_7    112.083ms 184.195ms
mlx4_8    115.089ms 190.618ms

Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx4/cmd.c  | 75 +++++++++++++++++--------------
 drivers/net/ethernet/mellanox/mlx4/mlx4.h |  1 +
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index c678344d22a2..24989e96ab9d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -51,7 +51,6 @@
 #include "fw.h"
 #include "fw_qos.h"
 #include "mlx4_stats.h"
-
 #define CMD_POLL_TOKEN 0xffff
 #define INBOX_MASK	0xffffffffffffff00ULL
 
@@ -2241,48 +2240,58 @@ void mlx4_master_comm_channel(struct work_struct *work)
 	struct mlx4_priv *priv =
 		container_of(mfunc, struct mlx4_priv, mfunc);
 	struct mlx4_dev *dev = &priv->dev;
-	__be32 *bit_vec;
 	u32 comm_cmd;
-	u32 vec;
-	int i, j, slave;
+	int i, slave;
 	int toggle;
 	int served = 0;
 	int reported = 0;
 	u32 slt;
-
-	bit_vec = master->comm_arm_bit_vector;
-	for (i = 0; i < COMM_CHANNEL_BIT_ARRAY_SIZE; i++) {
-		vec = be32_to_cpu(bit_vec[i]);
-		for (j = 0; j < 32; j++) {
-			if (!(vec & (1 << j)))
-				continue;
-			++reported;
-			slave = (i * 32) + j;
-			comm_cmd = swab32(readl(
-					  &mfunc->comm[slave].slave_write));
-			slt = swab32(readl(&mfunc->comm[slave].slave_read))
-				     >> 31;
-			toggle = comm_cmd >> 31;
-			if (toggle != slt) {
-				if (master->slave_state[slave].comm_toggle
-				    != slt) {
-					pr_info("slave %d out of sync. read toggle %d, state toggle %d. Resynching.\n",
-						slave, slt,
-						master->slave_state[slave].comm_toggle);
-					master->slave_state[slave].comm_toggle =
-						slt;
-				}
-				mlx4_master_do_cmd(dev, slave,
-						   comm_cmd >> 16 & 0xff,
-						   comm_cmd & 0xffff, toggle);
-				++served;
+	u32 lbit_vec[COMM_CHANNEL_BIT_ARRAY_SIZE];
+	u32 nmbr_bits;
+	u32 prev_slave;
+	bool first = true;
+
+	for (i = 0; i < COMM_CHANNEL_BIT_ARRAY_SIZE; i++)
+		lbit_vec[i] = be32_to_cpu(master->comm_arm_bit_vector[i]);
+	nmbr_bits = dev->persist->num_vfs + 1;
+	if (++priv->next_slave >= nmbr_bits)
+		priv->next_slave = 0;
+	slave = priv->next_slave;
+	while (true) {
+		slave = find_next_bit((const unsigned long *)&lbit_vec, nmbr_bits, slave);
+		if  (!first && slave >= priv->next_slave) {
+			break;
+		} else if (slave == nmbr_bits) {
+			if (!first)
+				break;
+			first = false;
+			slave = 0;
+			continue;
+		}
+		++reported;
+		comm_cmd = swab32(readl(&mfunc->comm[slave].slave_write));
+		slt = swab32(readl(&mfunc->comm[slave].slave_read)) >> 31;
+		toggle = comm_cmd >> 31;
+		if (toggle != slt) {
+			if (master->slave_state[slave].comm_toggle
+			    != slt) {
+				pr_info("slave %d out of sync. read toggle %d, state toggle %d. Resynching.\n",
+					slave, slt,
+					master->slave_state[slave].comm_toggle);
+				master->slave_state[slave].comm_toggle =
+					slt;
 			}
+			mlx4_master_do_cmd(dev, slave,
+					   comm_cmd >> 16 & 0xff,
+					   comm_cmd & 0xffff, toggle);
+			++served;
 		}
+		prev_slave = slave++;
 	}
 
 	if (reported && reported != served)
-		mlx4_warn(dev, "Got command event with bitmask from %d slaves but %d were served\n",
-			  reported, served);
+		mlx4_warn(dev, "Got command event with bitmask from %d slaves but %d were served %x %d\n",
+			  reported, served, lbit_vec[0], priv->next_slave);
 
 	if (mlx4_ARM_COMM_CHANNEL(dev))
 		mlx4_warn(dev, "Failed to arm comm channel events\n");
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index 64bed7ac3836..cd6ba80f4c90 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -924,6 +924,7 @@ struct mlx4_priv {
 
 	atomic_t		opreq_count;
 	struct work_struct	opreq_task;
+	u32			next_slave; /* mlx4_master_comm_channel */
 };
 
 static inline struct mlx4_priv *mlx4_priv(struct mlx4_dev *dev)
-- 
1.8.3.1

