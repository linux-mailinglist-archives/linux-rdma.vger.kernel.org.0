Return-Path: <linux-rdma+bounces-12610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD3B1C909
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B043AD89D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1D29E0E5;
	Wed,  6 Aug 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n4sihakd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFB292B54;
	Wed,  6 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494904; cv=none; b=EvFE9BbVVN39mJ5OuoRncWgB3bF1ImeeXS43y8lp/6OjhjBOaWf6IKHE9OoF+3JUmQydbfwZ8LPZYGrQBrhcvvFelx48pNUE/kBjsO1lPJlobVXpgMDlwCDa2om1bhOjBtp5PxjVJ3bIhxZCzN2Bm0nDB7j9ytrZvSnSk3zfbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494904; c=relaxed/simple;
	bh=DoWJSA43noy7vp98KmvXViBX2VHHsRNtNh5it2MnreA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5IUTv4DxCvcD5ZeRgtol52F245CDxDzQRytkkkASH39C4pOZe0sDOwxeoxLqnB8L9F0+xc/vOjJCkyZklhvr8ekgheeJC7qZy6BVAczS4S89K7w3uMHzGzT2bflTGsEBIlc+Uc+qMYLjVOEghQSv3siFXbnAmtiu4afvEQKdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n4sihakd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768omrO012309;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0axp4KP/oCqA6wk4L
	UOIpJe1osNGEntkf73QLYBQYYE=; b=n4sihakdXZYXMRlX6wzl3IsMBLTQ2uVaV
	fu+aniD3X3uObA09Q79w5ABowTuAjUmO+ZV3zTnFfVw2UWusU4FyLCi3PDkcmlJ6
	X/4nyL8cvlJytHtpbnv3A4Yt7b3RiEm2XIX1PMhYJDPohVL48X7xVTonwrttHyM0
	nj9OQzx9Saj2aHw5Dr+IxyLsiXAJxGL9YwtibwtUHNptosSn1bKUWErg0jsVqJ/0
	8M5IYEE6BoZdLTK8IH8PEhtpOUB8F5JI9tWZb08eKuxfqhQC0KwWREfIP37fBB8u
	j2cVmklT0JdB2VbpaQ+F5AddmryLQRI+FckM0NrMorImAYWyjVNbQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63n22v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FeGkS019798;
	Wed, 6 Aug 2025 15:41:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63n22p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CgJHx025899;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn4940-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNPO54133130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50D4F2004B;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318AD2004D;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id BB96EE12CD; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
Subject: [RFC net-next 15/17] net/dibs: Move query_remote_gid() to dibs_dev_ops
Date: Wed,  6 Aug 2025 17:41:20 +0200
Message-ID: <20250806154122.3413330-16-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806154122.3413330-1-wintera@linux.ibm.com>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX6t92vI9QAUo8
 sQRizceodfWiQWNrP30d+e5xFgSywSyXVR+YJEz2ix2Z6XAQl9mfBUFg7I+jI9dbwEaOvU14hak
 bGt2AqXWD5xRQgTcO9rHVGAUWUlFFWIgFiZ3EzarffPZRJpIXC2bpK9UR0F/MuVTbhrr/Fp7Z4o
 ZF2XihPWzxDZxaQuyE4AY19f0iAttP3GvCi3FzrHrZVNq/tD2bSufSQ6dQJBD5/aZxsfokGBQrN
 +zP6UE8U1KtaR8eQ3h/n5D+iK07WkGQRGHWKcMAMSMHWm7PmyS6/v5zkI0daHN5Jls8+oz9rQP4
 EspLX01eqpX2eIp3K58kTqGofvXVXzZCDH6q4exSIImqU3+HBI/WrhINPtXBj0/cq7IttNzTqnq
 PY6/Ij3PX7BxkHdwj1y/rKth/pHOCuBSd35K5mHfhvRKF3AKAIy5ss6sifJ5bXryloh3ylox
X-Proofpoint-ORIG-GUID: hSD9N5XnGa-8WF42FnuQ1w-8MTvjWbbp
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=--91sv9dLteaDJql628A:9
X-Proofpoint-GUID: h5V5t69nAkp_faF7uOKWixneJN2gzsPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

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
index 636594b2fab2..6a30178b1b06 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -291,6 +291,23 @@ static int ism_read_local_gid(struct dibs_dev *dibs)
 	return ret;
 }
 
+static int ism_query_rgid(struct dibs_dev *dibs, uuid_t *rgid, u32 vid_valid,
+			  u32 vid)
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
@@ -753,28 +771,6 @@ module_exit(ism_exit);
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
@@ -818,7 +814,6 @@ static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
 }
 
 static const struct smcd_ops ism_smcd_ops = {
-	.query_remote_gid = smcd_query_rgid,
 	.register_dmb = smcd_register_dmb,
 	.unregister_dmb = smcd_unregister_dmb,
 	.signal_event = smcd_signal_ieq,
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 10be10ae4660..d940411aa179 100644
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
+	int (*query_remote_gid)(struct dibs_dev *dev, uuid_t *rgid,
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
index d3800264fbba..b56579d0dfe7 100644
--- a/net/dibs/dibs_loopback.c
+++ b/net/dibs/dibs_loopback.c
@@ -23,8 +23,18 @@ static u16 dibs_lo_get_fabric_id(struct dibs_dev *dibs)
 	return DIBS_LOOPBACK_FABRIC;
 }
 
+static int dibs_lo_query_rgid(struct dibs_dev *dibs, uuid_t *rgid,
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
index ce9d2195e14a..265c8b383b71 100644
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


