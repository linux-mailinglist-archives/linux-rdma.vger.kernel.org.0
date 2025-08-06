Return-Path: <linux-rdma+bounces-12614-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98ABB1C915
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3438772421F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B532BD586;
	Wed,  6 Aug 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C4/YfDAg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4329C32C;
	Wed,  6 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494906; cv=none; b=dSShSxgxLIvKn9RwaLnV4AynS6PiK8YyKam9dr56eXSLTyuR+xsqLkUvGxCLMpEhDlwK2NaHab5iio0yh54Xj/biBEtDLHGunRt0fqbHFOibaaFjqNdrfFXY2Eqk8RdtvlQtNEk73eP/btbSzQVk+c25UX3r4fnsd+djyAkMtU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494906; c=relaxed/simple;
	bh=hX5Qn9/dDQE13OBz7KnZoUpEvKwaB2L8Q3TdBx4qJWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LALIqaIf+yVdq0heMnWEWSkZbRplwKZKhoM+eofjv2JOab/I0vqdDJmgcqVlRdOqIyycGuwfdi+gshB1OopVRNjEFl2BZHJBVrqGAiI+WfNwf8XgzPwkTxV4HgD96fLLaRAgQFvpHa0LQTmOZ7SnfwK6m3Q11xhGCrO3Ge08FGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C4/YfDAg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5767MkQN012350;
	Wed, 6 Aug 2025 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aQrIFW5yVENga/iU+
	cH7dsLvCxiHNtRiZ/cGgTPrRLA=; b=C4/YfDAgOq2J0LGeW1K6ejhqgziPi1ebI
	8fTntDOvuW8UYjI/xkYNJ70j7wrkBKtFdiXdD8lL9JxCkjelmlL/G9bEfccRRkMz
	ny9pZ0hXWQE/ng0edpjqHkcKBwCEPdAI4bIbWzO4NDwzQW5Bc9zrwFHxQF4zo0yE
	+c/HKgxEkbVAZQ8HdsWkGVo5YaMyzs6Bt25JKy+ER0g8hFGwMpgEG26eOiw2+rLK
	rTkjijtI0SI/y0Pdo2Q1ueD0DQBmUi8OCq31DejERMzJT42tDL5rsgalpVR33JlV
	M5aYPpB3KIziDDi0bbRu2FfTMafemANwSlCdh9GWbJG6XFUscWecA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63n22y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FcxfS014826;
	Wed, 6 Aug 2025 15:41:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63n22q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CgJI0025899;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn4942-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNwF48169428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3554D2005A;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04E5920049;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id AC1C1E12A9; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 10/17] net/dibs: Define dibs_client_ops and dibs_dev_ops
Date: Wed,  6 Aug 2025 17:41:15 +0200
Message-ID: <20250806154122.3413330-11-wintera@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX2Rz98QWrf+UU
 0WwwVdZxusARhUGcyyh6vS1CqF1n3PPaHw2RaEwjSERoEZZZc+54DVQybmJbwaQSmhXiqeFzWSj
 PkijrTEKQc4kdaQNw7zr2dUpgKzy8vTGfrIZLK0vz7WN9h43lpXeeaFRhU2uYKRBM88hqYQI5Xg
 Y6cin6ruScPYsh3Ff7adUZz5/xeP6DMr9wrt45I0dMj4D23MN0YCKVwvNPqk6X4out8Ah4xv+C9
 CR07h21gK5KxVhrLm+UlMWt5ADOu57+msSUHWuQSc2kk6n/Nhpr/UHBmct5bo/7uB2PVpAXqXgT
 p7RVWu6aR2X5SlZL+Jsz30j+ASTeWIa/U8Vu/YXUe4RZboq2eee/yRFyp1tx+svSDC1+iuYVUi4
 xvE+2BovakhsEg78VGn8chhQ87i/EST/KpgPHxLCnli7SQ3YkscFmGw2LXkyYLSnSol7TWWZ
X-Proofpoint-ORIG-GUID: -ndTHUpFjb6AXfO2bRRHHz9akbKt_7l5
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=o92sZZXIlIST2RNVCQQA:9
X-Proofpoint-GUID: Pg_NHLIjBdEYHFUCY4JVU5o-TUPi9Iet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

Move the device add() and remove() functions from ism_client to
dibs_client_ops and call add_dev()/del_dev() for ism devices and
dibs_loopback devices. dibs_client_ops->add_dev() = smcd_register_dev() for
the smc_dibs_client. This is the first step to handle ism and loopback
devices alike (as dibs devices) in the smc dibs client.

Define dibs_dev->ops and move smcd_ops->get_chid to
dibs_dev_ops->get_fabric_id() for ism and loopback devices. See below for
why this needs to be in the same patch as dibs_client_ops->add_dev().

The following changes contain intermediate steps, that will be obsoleted by
follow-on patches, once more functionality has been moved to dibs:

Use different smcd_ops and max_dmbs for ism and loopback. Follow-on patches
will change SMC-D to directly use dibs_ops instead of smcd_ops.

In smcd_register_dev() it is now necessary to identify a dibs_loopback
device before smcd_dev and smcd_ops->get_chid() are available. So provide
dibs_dev_ops->get_fabric_id() in this patch and evaluate it in
smc_ism_is_loopback().

Call smc_loopback_init() in smcd_register_dev() and call
smc_loopback_exit() in smcd_unregister_dev() to handle the functionality
that is still in smc_loopback. Follow-on patches will move all smc_loopback
code to dibs_loopback.

In smcd_unregister_dev() use only ism device name, this will be replaced by
dibs device name by a follow-on patch.

End of changes with intermediate parts.

Allocate an smcd event workqueue for all dibs devices, although
dibs_loopback does not generate events.

Use kernel memory instead of devres memory for smcd_dev and smcd->conn.
Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM") an ism
device and its driver can have a longer lifetime than the smc module, so
smc should not rely on devres to free its resources [1]. It is now the
responsibility of the smc client to free smcd and smcd->conn for all dibs
devices, ism devices as well as loopback. Call client->ops->del_dev() for
all existing dibs devices in dibs_unregister_client(), so all device
related structures can be freed in the client.

When dibs_unregister_client() is called in the context of smc_exit() or
smc_core_reboot_event(), these functions have already called
smc_lgrs_shutdown() which calls smc_smcd_terminate_all(smcd) and sets
going_away. This is done a second time in smcd_unregister_dev(). This is
analogous to how smcr is handled in these functions, by calling first
smc_lgrs_shutdown() and then smc_ib_unregister_client() >
smc_ib_remove_dev(), so leave it that way. It may be worth investigating,
whether smc_lgrs_shutdown() is still required or useful.

Remove CONFIG_SMC_LO. CONFIG_DIBS_LO now controls whether a dibs loopback
device exists or not.

Link: https://www.kernel.org/doc/Documentation/driver-model/devres.txt [1]
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c |  43 +++++++---------
 include/linux/dibs.h       |  90 +++++++++++++++++++++++++++++++-
 include/linux/ism.h        |   2 -
 include/net/smc.h          |   3 +-
 net/dibs/dibs_loopback.c   |  11 ++++
 net/dibs/dibs_main.c       |  37 +++++++++++++
 net/smc/Kconfig            |  13 -----
 net/smc/Makefile           |   2 +-
 net/smc/af_smc.c           |  12 +----
 net/smc/smc_ism.c          | 103 ++++++++++++++++++++++++++-----------
 net/smc/smc_ism.h          |   7 +--
 net/smc/smc_loopback.c     |  94 +++++----------------------------
 net/smc/smc_loopback.h     |  17 ++----
 13 files changed, 254 insertions(+), 180 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 7948334f8d30..84a6e9ae2e64 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -79,7 +79,6 @@ int ism_register_client(struct ism_client *client)
 		/* initialize with all devices that we got so far */
 		list_for_each_entry(ism, &ism_dev_list.list, list) {
 			ism->priv[i] = NULL;
-			client->add(ism);
 			ism_setup_forwarding(client, ism);
 		}
 	}
@@ -465,6 +464,16 @@ int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx, bool sf,
 }
 EXPORT_SYMBOL_GPL(ism_move);
 
+static u16 ism_get_chid(struct dibs_dev *dibs)
+{
+	struct ism_dev *ism = dibs->drv_priv;
+
+	if (!ism || !ism->pdev)
+		return 0;
+
+	return to_zpci(ism->pdev)->pchid;
+}
+
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
@@ -523,6 +532,10 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct dibs_dev_ops ism_ops = {
+	.get_fabric_id = ism_get_chid,
+};
+
 static int ism_dev_init(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
@@ -564,7 +577,6 @@ static int ism_dev_init(struct ism_dev *ism)
 	mutex_lock(&clients_lock);
 	for (i = 0; i < max_client; ++i) {
 		if (clients[i]) {
-			clients[i]->add(ism);
 			ism_setup_forwarding(clients[i], ism);
 		}
 	}
@@ -611,12 +623,6 @@ static void ism_dev_exit(struct ism_dev *ism)
 	spin_unlock_irqrestore(&ism->lock, flags);
 
 	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	for (i = 0; i < max_client; ++i) {
-		if (clients[i])
-			clients[i]->remove(ism);
-	}
-	mutex_unlock(&clients_lock);
 
 	if (ism_v2_capable)
 		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
@@ -672,7 +678,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto err_resource;
 	}
+	/* set this up before we enable interrupts */
 	ism->dibs = dibs;
+	dibs->drv_priv = ism;
+	dibs->ops = &ism_ops;
 
 	ret = ism_dev_init(ism);
 	if (ret)
@@ -862,19 +871,6 @@ static void smcd_get_local_gid(struct smcd_dev *smcd,
 	smcd_gid->gid_ext = 0;
 }
 
-static u16 ism_get_chid(struct ism_dev *ism)
-{
-	if (!ism || !ism->pdev)
-		return 0;
-
-	return to_zpci(ism->pdev)->pchid;
-}
-
-static u16 smcd_get_chid(struct smcd_dev *smcd)
-{
-	return ism_get_chid(smcd->priv);
-}
-
 static inline struct device *smcd_get_dev(struct smcd_dev *dev)
 {
 	struct ism_dev *ism = dev->priv;
@@ -882,7 +878,7 @@ static inline struct device *smcd_get_dev(struct smcd_dev *dev)
 	return &ism->dev;
 }
 
-static const struct smcd_ops ism_ops = {
+static const struct smcd_ops ism_smcd_ops = {
 	.query_remote_gid = smcd_query_rgid,
 	.register_dmb = smcd_register_dmb,
 	.unregister_dmb = smcd_unregister_dmb,
@@ -894,13 +890,12 @@ static const struct smcd_ops ism_ops = {
 	.move_data = smcd_move,
 	.supports_v2 = smcd_supports_v2,
 	.get_local_gid = smcd_get_local_gid,
-	.get_chid = smcd_get_chid,
 	.get_dev = smcd_get_dev,
 };
 
 const struct smcd_ops *ism_get_smcd_ops(void)
 {
-	return &ism_ops;
+	return &ism_smcd_ops;
 }
 EXPORT_SYMBOL_GPL(ism_get_smcd_ops);
 #endif
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index e9a66cc7f25d..805ab33271b5 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -34,13 +34,45 @@
  * clients.
  */
 
+struct dibs_dev;
+
 /* DIBS client
  * -----------
  */
 #define MAX_DIBS_CLIENTS	8
+/* All dibs clients have access to all dibs devices.
+ * A dibs client provides the following functions to be called by dibs layer or
+ * dibs device drivers:
+ */
+struct dibs_client_ops {
+	/**
+	 *  add_dev() - add a dibs device
+	 *  @dev: device that was added
+	 *
+	 * Will be called during dibs_register_client() for all existing
+	 * dibs devices and whenever a new dibs device is registered.
+	 * dev is usable until dibs_client.remove() is called.
+	 * *dev is protected by device refcounting.
+	 */
+	void (*add_dev)(struct dibs_dev *dev);
+	/**
+	 * del_dev() - remove a dibs device
+	 * @dev: device to be removed
+	 *
+	 * Will be called whenever a dibs device is removed.
+	 * Will be called during dibs_unregister_client() for all existing
+	 * dibs devices and whenever a dibs device is unregistered.
+	 * The device has already stopped initiative for this client:
+	 * No new handlers will be started.
+	 * The device is no longer usable by this client after this call.
+	 */
+	void (*del_dev)(struct dibs_dev *dev);
+};
+
 struct dibs_client {
 	/* client name for logging and debugging purposes */
 	const char *name;
+	const struct dibs_client_ops *ops;
 	/* client index - provided and used by dibs layer */
 	u8 id;
 };
@@ -51,6 +83,7 @@ struct dibs_client {
  * dibs_register_client() - register a client with dibs layer
  * @client: this client
  *
+ * Will call client->ops->add_dev() for all existing dibs devices.
  * Return: zero on success.
  */
 int dibs_register_client(struct dibs_client *client);
@@ -58,21 +91,74 @@ int dibs_register_client(struct dibs_client *client);
  * dibs_unregister_client() - unregister a client with dibs layer
  * @client: this client
  *
+ * Will call client->ops->del_dev() for all existing dibs devices.
  * Return: zero on success.
  */
 int dibs_unregister_client(struct dibs_client *client);
 
+/* dibs clients can call dibs device ops. */
+
 /* DIBS devices
  * ------------
  */
+
+/* Defined fabric id / CHID for all loopback devices:
+ * All dibs loopback devices report this fabric id. In this case devices with
+ * the same fabric id can NOT communicate via dibs. Only loopback devices with
+ * the same dibs device gid can communicate (=same device with itself).
+ */
+#define DIBS_LOOPBACK_FABRIC	0xFFFF
+
+/* A dibs device provides the following functions to be called by dibs clients.
+ * They are mandatory, unless marked 'optional'.
+ */
+struct dibs_dev_ops {
+	/**
+	 * get_fabric_id()
+	 * @dev: local dibs device
+	 *
+	 * Only devices on the same dibs fabric can communicate. Fabric_id is
+	 * unique inside the same HW system. Use fabric_id for fast negative
+	 * checks, but only query_remote_gid() can give a reliable positive
+	 * answer:
+	 * Different fabric_id: dibs is not possible
+	 * Same fabric_id: dibs may be possible or not
+	 *		   (e.g. different HW systems)
+	 * EXCEPTION: DIBS_LOOPBACK_FABRIC denotes an ism_loopback device
+	 *	      that can only communicate with itself. Use dibs_dev.gid
+	 *	      or query_remote_gid()to determine whether sender and
+	 *	      receiver use the same ism_loopback device.
+	 * Return: 2 byte dibs fabric id
+	 */
+	u16 (*get_fabric_id)(struct dibs_dev *dev);
+};
+
 struct dibs_dev {
 	struct list_head list;
+	/* To be filled by device driver, before calling dibs_dev_add(): */
+	const struct dibs_dev_ops *ops;
+	/* priv pointer for device driver */
+	void *drv_priv;
+
+	/* priv pointer per client; for client usage only */
+	void *priv[MAX_DIBS_CLIENTS];
 };
 
+static inline void dibs_set_priv(struct dibs_dev *dev,
+				 struct dibs_client *client, void *priv)
+{
+	dev->priv[client->id] = priv;
+}
+
+static inline void *dibs_get_priv(struct dibs_dev *dev,
+				  struct dibs_client *client)
+{
+	return dev->priv[client->id];
+}
+
 /* ------- End of client-only functions ----------- */
 
-/*
- * Functions to be called by dibs device drivers:
+/* Functions to be called by dibs device drivers:
  */
 /**
  * dibs_dev_alloc() - allocate and reference device structure
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 9a53d3c48c16..c818a25996db 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -59,8 +59,6 @@ struct ism_event {
 
 struct ism_client {
 	const char *name;
-	void (*add)(struct ism_dev *dev);
-	void (*remove)(struct ism_dev *dev);
 	void (*handle_event)(struct ism_dev *dev, struct ism_event *event);
 	/* Parameter dmbemask contains a bit vector with updated DMBEs, if sent
 	 * via ism_move_data(). Callback function must handle all active bits
diff --git a/include/net/smc.h b/include/net/smc.h
index a9c023dd1380..e271891b85e6 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/dibs.h>
 #include "linux/ism.h"
 
 struct sock;
@@ -62,7 +63,6 @@ struct smcd_ops {
 			 unsigned int size);
 	int (*supports_v2)(void);
 	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
-	u16 (*get_chid)(struct smcd_dev *dev);
 	struct device* (*get_dev)(struct smcd_dev *dev);
 
 	/* optional operations */
@@ -81,6 +81,7 @@ struct smcd_dev {
 	const struct smcd_ops *ops;
 	void *priv;
 	void *client;
+	struct dibs_dev *dibs;
 	struct list_head list;
 	spinlock_t lock;
 	struct smc_connection **conn;
diff --git a/net/dibs/dibs_loopback.c b/net/dibs/dibs_loopback.c
index c221b55d24a2..1d9d3081c020 100644
--- a/net/dibs/dibs_loopback.c
+++ b/net/dibs/dibs_loopback.c
@@ -17,6 +17,15 @@
 /* global loopback device */
 static struct dibs_lo_dev *lo_dev;
 
+static u16 dibs_lo_get_fabric_id(struct dibs_dev *dibs)
+{
+	return DIBS_LOOPBACK_FABRIC;
+}
+
+static const struct dibs_dev_ops dibs_lo_ops = {
+	.get_fabric_id = dibs_lo_get_fabric_id,
+};
+
 static void dibs_lo_dev_exit(struct dibs_lo_dev *ldev)
 {
 	dibs_dev_del(ldev->dibs);
@@ -39,6 +48,8 @@ static int dibs_lo_dev_probe(void)
 	}
 
 	ldev->dibs = dibs;
+	dibs->drv_priv = ldev;
+	dibs->ops = &dibs_lo_ops;
 
 	ret = dibs_dev_add(dibs);
 	if (ret)
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index 2c213e1f8f93..d8fa4a0b5935 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -35,8 +35,10 @@ static struct dibs_dev_list dibs_dev_list = {
 
 int dibs_register_client(struct dibs_client *client)
 {
+	struct dibs_dev *dibs;
 	int i, rc = -ENOSPC;
 
+	mutex_lock(&dibs_dev_list.mutex);
 	mutex_lock(&clients_lock);
 	for (i = 0; i < MAX_DIBS_CLIENTS; ++i) {
 		if (!clients[i]) {
@@ -50,19 +52,37 @@ int dibs_register_client(struct dibs_client *client)
 	}
 	mutex_unlock(&clients_lock);
 
+	if (i < MAX_DIBS_CLIENTS) {
+		/* initialize with all devices that we got so far */
+		list_for_each_entry(dibs, &dibs_dev_list.list, list) {
+			dibs->priv[i] = NULL;
+			client->ops->add_dev(dibs);
+		}
+	}
+	mutex_unlock(&dibs_dev_list.mutex);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(dibs_register_client);
 
 int dibs_unregister_client(struct dibs_client *client)
 {
+	struct dibs_dev *dibs;
 	int rc = 0;
 
+	mutex_lock(&dibs_dev_list.mutex);
+	list_for_each_entry(dibs, &dibs_dev_list.list, list) {
+		clients[client->id]->ops->del_dev(dibs);
+		dibs->priv[client->id] = NULL;
+	}
+
 	mutex_lock(&clients_lock);
 	clients[client->id] = NULL;
 	if (client->id + 1 == max_client)
 		max_client--;
 	mutex_unlock(&clients_lock);
+
+	mutex_unlock(&dibs_dev_list.mutex);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(dibs_unregister_client);
@@ -72,13 +92,22 @@ struct dibs_dev *dibs_dev_alloc(void)
 	struct dibs_dev *dibs;
 
 	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);
+
 	return dibs;
 }
 EXPORT_SYMBOL_GPL(dibs_dev_alloc);
 
 int dibs_dev_add(struct dibs_dev *dibs)
 {
+	int i;
+
 	mutex_lock(&dibs_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < max_client; ++i) {
+		if (clients[i])
+			clients[i]->ops->add_dev(dibs);
+	}
+	mutex_unlock(&clients_lock);
 	list_add(&dibs->list, &dibs_dev_list.list);
 	mutex_unlock(&dibs_dev_list.mutex);
 
@@ -88,7 +117,15 @@ EXPORT_SYMBOL_GPL(dibs_dev_add);
 
 void dibs_dev_del(struct dibs_dev *dibs)
 {
+	int i;
+
 	mutex_lock(&dibs_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < max_client; ++i) {
+		if (clients[i])
+			clients[i]->ops->del_dev(dibs);
+	}
+	mutex_unlock(&clients_lock);
 	list_del_init(&dibs->list);
 	mutex_unlock(&dibs_dev_list.mutex);
 }
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 40dd60c1d23f..9535d88c2acb 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -20,16 +20,3 @@ config SMC_DIAG
 	  smcss.
 
 	  if unsure, say Y.
-
-config SMC_LO
-	bool "SMC intra-OS shortcut with loopback-ism"
-	depends on SMC
-	default n
-	help
-	  SMC_LO enables the creation of an Emulated-ISM device named
-	  loopback-ism in SMC and makes use of it for transferring data
-	  when communication occurs within the same OS. This helps in
-	  convenient testing of SMC-D since loopback-ism is independent
-	  of architecture or hardware.
-
-	  if unsure, say N.
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 60f1c87d5212..96ccfdf246df 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -6,4 +6,4 @@ smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
 smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
 smc-y += smc_tracepoint.o smc_inet.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
-smc-$(CONFIG_SMC_LO) += smc_loopback.o
+smc-y += smc_loopback.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9311c38f7abe..a5f95db7928c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -57,7 +57,6 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
-#include "smc_loopback.h"
 #include "smc_inet.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
@@ -3592,16 +3591,10 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
 
-	rc = smc_loopback_init();
-	if (rc) {
-		pr_err("%s: smc_loopback_init fails with %d\n", __func__, rc);
-		goto out_ib;
-	}
-
 	rc = tcp_register_ulp(&smc_ulp_ops);
 	if (rc) {
 		pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
-		goto out_lo;
+		goto out_ib;
 	}
 	rc = smc_inet_init();
 	if (rc) {
@@ -3612,8 +3605,6 @@ static int __init smc_init(void)
 	return 0;
 out_ulp:
 	tcp_unregister_ulp(&smc_ulp_ops);
-out_lo:
-	smc_loopback_exit();
 out_ib:
 	smc_ib_unregister_client();
 out_sock:
@@ -3652,7 +3643,6 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
-	smc_loopback_exit();
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index a7a965e3c0ce..0943e7d4cd2a 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -15,6 +15,7 @@
 #include "smc.h"
 #include "smc_core.h"
 #include "smc_ism.h"
+#include "smc_loopback.h"
 #include "smc_pnet.h"
 #include "smc_netlink.h"
 #include "linux/ism.h"
@@ -28,23 +29,27 @@ struct smcd_dev_list smcd_dev_list = {
 static bool smc_ism_v2_capable;
 static u8 smc_ism_v2_system_eid[SMC_MAX_EID_LEN];
 
+static void smcd_register_dev(struct dibs_dev *dibs);
+static void smcd_unregister_dev(struct dibs_dev *dibs);
 #if IS_ENABLED(CONFIG_ISM)
-static void smcd_register_dev(struct ism_dev *ism);
-static void smcd_unregister_dev(struct ism_dev *ism);
 static void smcd_handle_event(struct ism_dev *ism, struct ism_event *event);
 static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
 			    u16 dmbemask);
 
 static struct ism_client smc_ism_client = {
 	.name = "SMC-D",
-	.add = smcd_register_dev,
-	.remove = smcd_unregister_dev,
 	.handle_event = smcd_handle_event,
 	.handle_irq = smcd_handle_irq,
 };
 #endif
+static struct dibs_client_ops smc_client_ops = {
+	.add_dev = smcd_register_dev,
+	.del_dev = smcd_unregister_dev,
+};
+
 static struct dibs_client smc_dibs_client = {
 	.name = "SMC-D",
+	.ops = &smc_client_ops,
 };
 
 static void smc_ism_create_system_eid(void)
@@ -86,7 +91,7 @@ void smc_ism_get_system_eid(u8 **eid)
 
 u16 smc_ism_get_chid(struct smcd_dev *smcd)
 {
-	return smcd->ops->get_chid(smcd);
+	return smcd->dibs->ops->get_fabric_id(smcd->dibs);
 }
 
 /* HW supports ISM V2 and thus System EID is defined */
@@ -318,7 +323,7 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
 		goto errattr;
 	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
-	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
+	smc_set_pci_values(ism->pdev, &smc_pci_dev);
 	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
 		goto errattr;
 	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
@@ -368,7 +373,7 @@ static void smc_nl_prep_smcd_dev(struct smcd_dev_list *dev_list,
 	list_for_each_entry(smcd, &dev_list->list, list) {
 		if (num < snum)
 			goto next;
-		if (smc_ism_is_loopback(smcd))
+		if (smc_ism_is_loopback(smcd->dibs))
 			goto next;
 		if (smc_nl_handle_smcd_dev(smcd, skb, cb))
 			goto errout;
@@ -453,24 +458,26 @@ static void smc_ism_event_work(struct work_struct *work)
 	}
 	kfree(wrk);
 }
+#endif
 
-static struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
-				       const struct smcd_ops *ops, int max_dmbs)
+static struct smcd_dev *smcd_alloc_dev(const char *name,
+				       const struct smcd_ops *ops,
+				       int max_dmbs)
 {
 	struct smcd_dev *smcd;
 
-	smcd = devm_kzalloc(parent, sizeof(*smcd), GFP_KERNEL);
+	smcd = kzalloc(sizeof(*smcd), GFP_KERNEL);
 	if (!smcd)
 		return NULL;
-	smcd->conn = devm_kcalloc(parent, max_dmbs,
-				  sizeof(struct smc_connection *), GFP_KERNEL);
+	smcd->conn = kcalloc(max_dmbs, sizeof(struct smc_connection *),
+			     GFP_KERNEL);
 	if (!smcd->conn)
-		return NULL;
+		goto free_smcd;
 
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
 	if (!smcd->event_wq)
-		return NULL;
+		goto free_conn;
 
 	smcd->ops = ops;
 
@@ -480,25 +487,53 @@ static struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	INIT_LIST_HEAD(&smcd->lgr_list);
 	init_waitqueue_head(&smcd->lgrs_deleted);
 	return smcd;
+
+free_conn:
+	kfree(smcd->conn);
+free_smcd:
+	kfree(smcd);
+	return NULL;
 }
 
-static void smcd_register_dev(struct ism_dev *ism)
+static void smcd_register_dev(struct dibs_dev *dibs)
 {
-	const struct smcd_ops *ops = ism_get_smcd_ops();
 	struct smcd_dev *smcd, *fentry;
+	const struct smcd_ops *ops;
+	struct smc_lo_dev *smc_lo;
+	struct ism_dev *ism;
 
-	if (!ops)
-		return;
+	if (smc_ism_is_loopback(dibs)) {
+		if (smc_loopback_init(&smc_lo))
+			return;
+	}
 
-	smcd = smcd_alloc_dev(&ism->pdev->dev, dev_name(&ism->pdev->dev), ops,
-			      ISM_NR_DMBS);
+	if (smc_ism_is_loopback(dibs)) {
+		ops = smc_lo_get_smcd_ops();
+		smcd = smcd_alloc_dev(dev_name(&smc_lo->dev), ops,
+				      SMC_LO_MAX_DMBS);
+	} else {
+		ism = dibs->drv_priv;
+		ops = ism_get_smcd_ops();
+		smcd = smcd_alloc_dev(dev_name(&ism->pdev->dev), ops,
+				      ISM_NR_DMBS);
+	}
 	if (!smcd)
 		return;
-	smcd->priv = ism;
+
+	smcd->dibs = dibs;
+	dibs_set_priv(dibs, &smc_dibs_client, smcd);
+
+	if (smc_ism_is_loopback(dibs)) {
+		smcd->priv = smc_lo;
+		smc_lo->smcd = smcd;
+	} else {
+		smcd->priv = ism;
+		ism_set_priv(ism, &smc_ism_client, smcd);
+		if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
+			smc_pnetid_by_table_smcd(smcd);
+	}
+
 	smcd->client = &smc_ism_client;
-	ism_set_priv(ism, &smc_ism_client, smcd);
-	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
-		smc_pnetid_by_table_smcd(smcd);
 
 	if (smcd->ops->supports_v2())
 		smc_ism_set_v2_capable();
@@ -510,7 +545,7 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (!smcd->pnetid[0]) {
 		fentry = list_first_entry_or_null(&smcd_dev_list.list,
 						  struct smcd_dev, list);
-		if (fentry && smc_ism_is_loopback(fentry))
+		if (fentry && smc_ism_is_loopback(fentry->dibs))
 			list_add(&smcd->list, &fentry->list);
 		else
 			list_add(&smcd->list, &smcd_dev_list.list);
@@ -531,20 +566,30 @@ static void smcd_register_dev(struct ism_dev *ism)
 	return;
 }
 
-static void smcd_unregister_dev(struct ism_dev *ism)
+static void smcd_unregister_dev(struct dibs_dev *dibs)
 {
-	struct smcd_dev *smcd = ism_get_priv(ism, &smc_ism_client);
+	struct smcd_dev *smcd = dibs_get_priv(dibs, &smc_dibs_client);
+	struct ism_dev *ism = dibs->drv_priv;
 
-	pr_warn_ratelimited("smc: removing smcd device %s\n",
-			    dev_name(&ism->dev));
+	if (smc_ism_is_loopback(dibs)) {
+		pr_warn_ratelimited("smc: removing smcd loopback device\n");
+	} else {
+		pr_warn_ratelimited("smc: removing smcd device %s\n",
+				    dev_name(&ism->dev));
+	}
 	smcd->going_away = 1;
 	smc_smcd_terminate_all(smcd);
 	mutex_lock(&smcd_dev_list.mutex);
 	list_del_init(&smcd->list);
 	mutex_unlock(&smcd_dev_list.mutex);
 	destroy_workqueue(smcd->event_wq);
+	if (smc_ism_is_loopback(dibs))
+		smc_loopback_exit();
+	kfree(smcd->conn);
+	kfree(smcd);
 }
 
+#if IS_ENABLED(CONFIG_ISM)
 /* SMCD Device event handler. Called from ISM device interrupt handler.
  * Parameters are ism device pointer,
  * - event->type (0 --> DMB, 1 --> GID),
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 765aa8fae6fa..04699951d03f 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -12,6 +12,7 @@
 #include <linux/uio.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/dibs.h>
 
 #include "smc.h"
 
@@ -85,14 +86,14 @@ static inline bool __smc_ism_is_emulated(u16 chid)
 
 static inline bool smc_ism_is_emulated(struct smcd_dev *smcd)
 {
-	u16 chid = smcd->ops->get_chid(smcd);
+	u16 chid = smcd->dibs->ops->get_fabric_id(smcd->dibs);
 
 	return __smc_ism_is_emulated(chid);
 }
 
-static inline bool smc_ism_is_loopback(struct smcd_dev *smcd)
+static inline bool smc_ism_is_loopback(struct dibs_dev *dibs)
 {
-	return (smcd->ops->get_chid(smcd) == 0xFFFF);
+	return (dibs->ops->get_fabric_id(dibs) == DIBS_LOOPBACK_FABRIC);
 }
 
 #endif
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 1853c26fbbbb..37d8366419f7 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -35,8 +35,6 @@ static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
 	memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
 	memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
 	       sizeof(lgid->gid_ext));
-
-	ldev->chid = SMC_LO_RESERVED_CHID;
 }
 
 static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
@@ -257,11 +255,6 @@ static void smc_lo_get_local_gid(struct smcd_dev *smcd,
 	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
 }
 
-static u16 smc_lo_get_chid(struct smcd_dev *smcd)
-{
-	return ((struct smc_lo_dev *)smcd->priv)->chid;
-}
-
 static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
 {
 	return &((struct smc_lo_dev *)smcd->priv)->dev;
@@ -281,72 +274,15 @@ static const struct smcd_ops lo_ops = {
 	.signal_event		= NULL,
 	.move_data = smc_lo_move_data,
 	.get_local_gid = smc_lo_get_local_gid,
-	.get_chid = smc_lo_get_chid,
 	.get_dev = smc_lo_get_dev,
 };
 
-static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
-					  int max_dmbs)
-{
-	struct smcd_dev *smcd;
-
-	smcd = kzalloc(sizeof(*smcd), GFP_KERNEL);
-	if (!smcd)
-		return NULL;
-
-	smcd->conn = kcalloc(max_dmbs, sizeof(struct smc_connection *),
-			     GFP_KERNEL);
-	if (!smcd->conn)
-		goto out_smcd;
-
-	smcd->ops = ops;
-
-	spin_lock_init(&smcd->lock);
-	spin_lock_init(&smcd->lgr_lock);
-	INIT_LIST_HEAD(&smcd->vlan);
-	INIT_LIST_HEAD(&smcd->lgr_list);
-	init_waitqueue_head(&smcd->lgrs_deleted);
-	return smcd;
-
-out_smcd:
-	kfree(smcd);
-	return NULL;
-}
-
-static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
-{
-	struct smcd_dev *smcd;
-
-	smcd = smcd_lo_alloc_dev(&lo_ops, SMC_LO_MAX_DMBS);
-	if (!smcd)
-		return -ENOMEM;
-	ldev->smcd = smcd;
-	smcd->priv = ldev;
-	smc_ism_set_v2_capable();
-	mutex_lock(&smcd_dev_list.mutex);
-	list_add(&smcd->list, &smcd_dev_list.list);
-	mutex_unlock(&smcd_dev_list.mutex);
-	pr_warn_ratelimited("smc: adding smcd device %s\n",
-			    dev_name(&ldev->dev));
-	return 0;
-}
-
-static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
+const struct smcd_ops *smc_lo_get_smcd_ops(void)
 {
-	struct smcd_dev *smcd = ldev->smcd;
-
-	pr_warn_ratelimited("smc: removing smcd device %s\n",
-			    dev_name(&ldev->dev));
-	smcd->going_away = 1;
-	smc_smcd_terminate_all(smcd);
-	mutex_lock(&smcd_dev_list.mutex);
-	list_del_init(&smcd->list);
-	mutex_unlock(&smcd_dev_list.mutex);
-	kfree(smcd->conn);
-	kfree(smcd);
+	return &lo_ops;
 }
 
-static int smc_lo_dev_init(struct smc_lo_dev *ldev)
+static void smc_lo_dev_init(struct smc_lo_dev *ldev)
 {
 	smc_lo_generate_ids(ldev);
 	rwlock_init(&ldev->dmb_ht_lock);
@@ -354,12 +290,11 @@ static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 	atomic_set(&ldev->dmb_cnt, 0);
 	init_waitqueue_head(&ldev->ldev_release);
 
-	return smcd_lo_register_dev(ldev);
+	return;
 }
 
 static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
 {
-	smcd_lo_unregister_dev(ldev);
 	if (atomic_read(&ldev->dmb_cnt))
 		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
 }
@@ -375,7 +310,6 @@ static void smc_lo_dev_release(struct device *dev)
 static int smc_lo_dev_probe(void)
 {
 	struct smc_lo_dev *ldev;
-	int ret;
 
 	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
 	if (!ldev)
@@ -385,17 +319,11 @@ static int smc_lo_dev_probe(void)
 	ldev->dev.release = smc_lo_dev_release;
 	device_initialize(&ldev->dev);
 	dev_set_name(&ldev->dev, smc_lo_dev_name);
-
-	ret = smc_lo_dev_init(ldev);
-	if (ret)
-		goto free_dev;
+	smc_lo_dev_init(ldev);
 
 	lo_dev = ldev; /* global loopback device */
-	return 0;
 
-free_dev:
-	put_device(&ldev->dev);
-	return ret;
+	return 0;
 }
 
 static void smc_lo_dev_remove(void)
@@ -405,11 +333,17 @@ static void smc_lo_dev_remove(void)
 
 	smc_lo_dev_exit(lo_dev);
 	put_device(&lo_dev->dev); /* device_initialize in smc_lo_dev_probe */
+	lo_dev = NULL;
 }
 
-int smc_loopback_init(void)
+int smc_loopback_init(struct smc_lo_dev **smc_lb)
 {
-	return smc_lo_dev_probe();
+	int ret;
+
+	ret = smc_lo_dev_probe();
+	if (!ret)
+		*smc_lb = lo_dev;
+	return ret;
 }
 
 void smc_loopback_exit(void)
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 04dc6808d2e1..76c62526e2e5 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -17,10 +17,8 @@
 #include <linux/device.h>
 #include <net/smc.h>
 
-#if IS_ENABLED(CONFIG_SMC_LO)
 #define SMC_LO_MAX_DMBS		5000
 #define SMC_LO_DMBS_HASH_BITS	12
-#define SMC_LO_RESERVED_CHID	0xFFFF
 
 struct smc_lo_dmb_node {
 	struct hlist_node list;
@@ -35,7 +33,6 @@ struct smc_lo_dmb_node {
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
-	u16 chid;
 	struct smcd_gid local_gid;
 	atomic_t dmb_cnt;
 	rwlock_t dmb_ht_lock;
@@ -44,17 +41,9 @@ struct smc_lo_dev {
 	wait_queue_head_t ldev_release;
 };
 
-int smc_loopback_init(void);
+const struct smcd_ops *smc_lo_get_smcd_ops(void);
+
+int smc_loopback_init(struct smc_lo_dev **smc_lb);
 void smc_loopback_exit(void);
-#else
-static inline int smc_loopback_init(void)
-{
-	return 0;
-}
-
-static inline void smc_loopback_exit(void)
-{
-}
-#endif
 
 #endif /* _SMC_LOOPBACK_H */
-- 
2.48.1


