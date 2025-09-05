Return-Path: <linux-rdma+bounces-13123-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9896B45B1F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CB85C6C33
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320CE393DDA;
	Fri,  5 Sep 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Co/dgHRG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F73728AC;
	Fri,  5 Sep 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084087; cv=none; b=Pp7AdYVCfBNdhgy+MENFlhZIZOtq9DHMCQTUUcQxPNfvnGf0aFUZ0P3mIdqH+EGyYZJYhdVDQ1rLV/h0OFpkQqYBwcBuZm6CHj7BXm/inOUDcwLDIw42FARUeW1unQoEOODwUzLGhA2hmnKQWFf+3amcWEEDCTex2sSycN6s+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084087; c=relaxed/simple;
	bh=KwohYQlQPPn+tC47RUwSTMHEshsdW78x4INW5eQKoW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/7wV/RY5vt5VPLuJt4ZJLEuM0lnGR+YVPs2Xav+7PdRxbmn9WXTBfUsvlVKk0MEs1yrutXJ7rNn0CYK0hIjLg6YB1IYXzkuwDfe9c7L4ELHt/Wj4FMALDtVMbmSMzawhOWKCRw/BvZRxNbDG2mGCdO6JfFRBcimSf0DVMiMmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Co/dgHRG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5859sNgN021917;
	Fri, 5 Sep 2025 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lKlTJz8HpyUSQQFRL
	fhhjamGIaBu1HRzFEoyEIcnyOc=; b=Co/dgHRGvxd4brRokgsoiN0Pkc23CyNVa
	xlW2DX4ee+w+I2NyhTf31iQ5XMEUjkdZcRZFY/OM1JvgUn0oC0Mn6jnbXhmVcx8b
	Is37M6r4ClFz7Wkwt9XxNXaBu1+J9OnPdwhXhoSB4nbzujcS3oCBRH3RfTLnSRV6
	m3Q8IPbhJ8OuXGfS9Sn4FFKCewu/KGeqUI1CUQhtoPfBrpLy6xhCoWwaiWIZSG0J
	6so1WK9M9Ae9BU6cb79hS94GALYV73cZSN7HsJXR4Zjh4T8EFvfQAMpxbidKrmiS
	FikUXGfCDSM4B742jXh5+WfB5zJBuiJ0GxKr/e9GJjNYQ0iqIkbhA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurh7dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EsYff026711;
	Fri, 5 Sep 2025 14:54:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurh7db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585CIlCK017222;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc1122su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSOR52953474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B387B20040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95CAA20043;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 3D699E1185; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
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
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 12/14] net/dibs: Move query_remote_gid() to dibs_dev_ops
Date: Fri,  5 Sep 2025 16:54:25 +0200
Message-ID: <20250905145428.1962105-13-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905145428.1962105-1-wintera@linux.ibm.com>
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX93HqaajbPafw
 2oltkKDe3xvBJhFPOB91f3fU6Asr19Kf6W55JJJkTwC2qiIv/SfBeymVG2K4CVKRJ1QgSDLeNpt
 8YrmZLsBSU9pxKmv80yq8OfkrvjBxbF/F8wLO0wDDoM6YUBXOFhdKNAAum9rhlhZchqMf5cefWh
 0OhTKW+fzpQJlehMseMmj5/v2op+faRna3YmyP+SArlLK9AVud7oUwEpQBddPN2FZVrdXgK/Irm
 d/HVwG1pWJk/yOP+Py5WUAptPY3G2gzg+EVR/tIRDvX7N49kLkvEz27N9V527ym7WCv3vHecVXF
 phCbek6AU/exvI96kgqDyz+QRKURo+IfIxSxSYoZ/rdGf+c9eyQ+IHiizk7FYtAbzKLUzclcK3i
 puvEa+bs
X-Proofpoint-GUID: Pn1UmiKho6ZicPe5KsnnXKNPleOnP5wC
X-Proofpoint-ORIG-GUID: yaeQBJe7LCrZBAd1SULHBqkTGwNIQTej
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68baf9aa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=--91sv9dLteaDJql628A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

Provide the dibs_dev_ops->query_remote_gid() in ism and dibs_loopback
dibs_devices. And call it in smc dibs_client.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 41 +++++++++++++++++---------------------
 include/linux/dibs.h       | 14 +++++++++++++
 include/net/smc.h          |  2 --
 net/dibs/dibs_loopback.c   | 10 ++++++++++
 net/smc/smc_ism.c          |  8 ++++++--
 net/smc/smc_loopback.c     | 13 ------------
 6 files changed, 48 insertions(+), 40 deletions(-)

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
diff --git a/net/dibs/dibs_loopback.c b/net/dibs/dibs_loopback.c
index d7e6fa5e90f3..6b53e626a6d1 100644
--- a/net/dibs/dibs_loopback.c
+++ b/net/dibs/dibs_loopback.c
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
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 435e28364885..c17988531bd8 100644
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


