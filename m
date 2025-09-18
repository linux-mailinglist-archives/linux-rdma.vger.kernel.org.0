Return-Path: <linux-rdma+bounces-13481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D7B8442D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8167B4CE0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7E12FFF8C;
	Thu, 18 Sep 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CfHikSwa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C123ABA0;
	Thu, 18 Sep 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193531; cv=none; b=Z5lWT+qPS1Dca+6U8CG1a312+nQjJd+Hzq/kA3B0/Xsvx4UPFTq0zxOitHUJ4EtPJB2FBk9GTIRG64g8GABPvCFCjnyY0OtmQQnZ3Ct5J2Ep0PxVcLuOgpLNjasidR0OQJUgO0S96+kRgYgNfEOLOu0dcl9zIo5gyBl9mDbWryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193531; c=relaxed/simple;
	bh=XeXOgsB9z8VFQL57bwtvkARsahg83cA/h7WLDtVdIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iywHg8XTv5VN3NrF6flHHfeSG6O/HvMicrwgXhteZNvX6zALwYgJpv8ZpdnIoGVmMt58fI1nMPXbxDy20LRfN6hPbPwJ+MMpb5j67zfBIoU11E+9ZBO4jlgNc9/ZkkvOF2LYcsEjzWYnMpOaAZyqpy4NYItydxuEjnYEZLFoYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CfHikSwa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6h8ic023772;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YJw2LDP6WLC0PWO69
	uISrJ0Xv1tX49/lxPz6cIBZFmw=; b=CfHikSwaJgxmk+QMTQyRuBf3xhPB8DxK5
	vKr2un3K85EsMPMBX9TW62m4pKzQSDIQcKM9T0KjV5zC7AkHNOjLF/ZWZFdQOjZB
	1YHIJ6jLsq+uJT2QEVHSvvc86oJi0hRym+VGSlgJdfXxK2s+E1TaVkW8SeXarfUc
	ezmXxgMX2K+gkhyjjNEx28C63a6cB/Vv2ly7lxKhtfaDt80EFrkrN2l+FZ/AWsPU
	1dszzxAXfCpUc2qsWOFoX2bjSwvtfJ00RH34yxa6wMATacunHyRkbiIJ1EKVxLxg
	KAO66UAehtAuGqY5bcJ+pIqBDO7AiceyiPQEe6QgRLyMhwp9ek4vg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB2QAg024055;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7V7xf018620;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mp31y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51t234013658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45BDF2004F;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 215EB20043;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id CBCAFE156F; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Konstantin Shkolnyy <kshk@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shannon Nelson <sln@onemain.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH net-next v3 12/14] dibs: Move query_remote_gid() to dibs_dev_ops
Date: Thu, 18 Sep 2025 13:04:58 +0200
Message-ID: <20250918110500.1731261-13-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250918110500.1731261-1-wintera@linux.ibm.com>
References: <20250918110500.1731261-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _HQf8UtuKucVf3zpJ8p_N81p39OhLjCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1Vgoi/vCx/aT
 L8BvPoOykrhsQ2Rh6WW14rBbXTiko1V2TV63gZwbiDiqaT746M7xzUsVEwLXO0YMGh8ZyVZ1ZTT
 TPnhBnG35FaZO7uJ36BvHsrZFfgdzt4dXxKb5O9cMl/PWhEHfwQZid0l5eEt5ANH4FMg1MYKo3d
 Z/wpBQ+r9nuiE+Z4ZfyPvIPnRyRsYJRjEATOBmJ+qt8qUAu1GA2k5PX36dflMzUj4Id/4D2GcdB
 kBpBBEG3MpMVTSDX/b2SvyumTQRMy2p/h1pFSK8vciBV3SMgsF2L2kDgtuLvO9PNDOo6Q9+zLhd
 a58i8c07NH8ws+tpbH/3CXmpA+FbQx1Ft8NOfmMb5CYl8U+/BWpinCEC8GvG3l52fvHzLsoS0s6
 kb48zQf4
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cbe762 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=--91sv9dLteaDJql628A:9
X-Proofpoint-GUID: Loei-NkDL3t4Plk0Zg8z5t8n2DxqAasG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

Provide the dibs_dev_ops->query_remote_gid() in ism and dibs_loopback
dibs_devices. And call it in smc dibs_client.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_loopback.c | 10 +++++++++
 drivers/s390/net/ism_drv.c   | 41 ++++++++++++++++--------------------
 include/linux/dibs.h         | 14 ++++++++++++
 include/net/smc.h            |  2 --
 net/smc/smc_ism.c            |  8 +++++--
 net/smc/smc_loopback.c       | 13 ------------
 6 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index d7e6fa5e90f3..6b53e626a6d1 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -24,8 +24,18 @@ static u16 dibs_lo_get_fabric_id(struct dibs_dev *dibs)
 	return DIBS_LOOPBACK_FABRIC;
 }
 
+static int dibs_lo_query_rgid(struct dibs_dev *dibs, const uuid_t *rgid,
+			      u32 vid_valid, u32 vid)
+{
+	/* rgid should be the same as lgid */
+	if (!uuid_equal(rgid, &dibs->gid))
+		return -ENETUNREACH;
+	return 0;
+}
+
 static const struct dibs_dev_ops dibs_lo_ops = {
 	.get_fabric_id = dibs_lo_get_fabric_id,
+	.query_remote_gid = dibs_lo_query_rgid,
 };
 
 static int dibs_lo_dev_probe(void)
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index ed4c28ca355b..121b3a2be760 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -291,6 +291,23 @@ static int ism_read_local_gid(struct dibs_dev *dibs)
 	return ret;
 }
 
+static int ism_query_rgid(struct dibs_dev *dibs, const uuid_t *rgid,
+			  u32 vid_valid, u32 vid)
+{
+	struct ism_dev *ism = dibs->drv_priv;
+	union ism_query_rgid cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_QUERY_RGID;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	memcpy(&cmd.request.rgid, rgid, sizeof(cmd.request.rgid));
+	cmd.request.vlan_valid = vid_valid;
+	cmd.request.vlan_id = vid;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
@@ -537,6 +554,7 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 
 static const struct dibs_dev_ops ism_ops = {
 	.get_fabric_id = ism_get_chid,
+	.query_remote_gid = ism_query_rgid,
 	.add_vlan_id = ism_add_vlan_id,
 	.del_vlan_id = ism_del_vlan_id,
 };
@@ -748,28 +766,6 @@ module_exit(ism_exit);
 /*************************** SMC-D Implementation *****************************/
 
 #if IS_ENABLED(CONFIG_SMC)
-static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
-			  u32 vid)
-{
-	union ism_query_rgid cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.request.hdr.cmd = ISM_QUERY_RGID;
-	cmd.request.hdr.len = sizeof(cmd.request);
-
-	cmd.request.rgid = rgid;
-	cmd.request.vlan_valid = vid_valid;
-	cmd.request.vlan_id = vid;
-
-	return ism_cmd(ism, &cmd);
-}
-
-static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			   u32 vid_valid, u32 vid)
-{
-	return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
-}
-
 static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 			     void *client)
 {
@@ -813,7 +809,6 @@ static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
 }
 
 static const struct smcd_ops ism_smcd_ops = {
-	.query_remote_gid = smcd_query_rgid,
 	.register_dmb = smcd_register_dmb,
 	.unregister_dmb = smcd_unregister_dmb,
 	.signal_event = smcd_signal_ieq,
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 166148fb8d76..c75a40fe3039 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -133,6 +133,20 @@ struct dibs_dev_ops {
 	 * Return: 2 byte dibs fabric id
 	 */
 	u16 (*get_fabric_id)(struct dibs_dev *dev);
+	/**
+	 * query_remote_gid()
+	 * @dev: local dibs device
+	 * @rgid: gid of remote dibs device
+	 * @vid_valid: if zero, vid will be ignored;
+	 *	       deprecated, ignored if device does not support vlan
+	 * @vid: VLAN id; deprecated, ignored if device does not support vlan
+	 *
+	 * Query whether a remote dibs device is reachable via this local device
+	 * and this vlan id.
+	 * Return: 0 if remote gid is reachable.
+	 */
+	int (*query_remote_gid)(struct dibs_dev *dev, const uuid_t *rgid,
+				u32 vid_valid, u32 vid);
 	/**
 	 * add_vlan_id() - add dibs device to vlan (optional, deprecated)
 	 * @dev: dibs device
diff --git a/include/net/smc.h b/include/net/smc.h
index 51b4aefc106a..5bd135fb4d49 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -53,8 +53,6 @@ struct smcd_gid {
 };
 
 struct smcd_ops {
-	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
-				u32 vid_valid, u32 vid);
 	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
 			    void *client);
 	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 5118441bed18..d20d00b46825 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -77,8 +77,12 @@ static void smc_ism_create_system_eid(void)
 int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
 		    struct smcd_dev *smcd)
 {
-	return smcd->ops->query_remote_gid(smcd, peer_gid, vlan_id ? 1 : 0,
-					   vlan_id);
+	struct dibs_dev *dibs = smcd->dibs;
+	uuid_t ism_rgid;
+
+	copy_to_dibsgid(&ism_rgid, peer_gid);
+	return dibs->ops->query_remote_gid(dibs, &ism_rgid, vlan_id ? 1 : 0,
+					  vlan_id);
 }
 
 void smc_ism_get_system_eid(u8 **eid)
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 982a19430313..52cba01cb209 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -25,18 +25,6 @@
 
 static struct smc_lo_dev *lo_dev;
 
-static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			     u32 vid_valid, u32 vid)
-{
-	uuid_t temp;
-
-	copy_to_dibsgid(&temp, rgid);
-	/* rgid should be the same as lgid */
-	if (!uuid_equal(&temp, &smcd->dibs->gid))
-		return -ENETUNREACH;
-	return 0;
-}
-
 static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 			       void *client_priv)
 {
@@ -235,7 +223,6 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 }
 
 static const struct smcd_ops lo_ops = {
-	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb = smc_lo_register_dmb,
 	.unregister_dmb = smc_lo_unregister_dmb,
 	.support_dmb_nocopy = smc_lo_support_dmb_nocopy,
-- 
2.48.1


