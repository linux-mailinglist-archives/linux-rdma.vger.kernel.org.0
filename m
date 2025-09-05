Return-Path: <linux-rdma+bounces-13128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C7B45B30
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E333B9DB3
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C6F306B03;
	Fri,  5 Sep 2025 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jx553kPc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B47393DE0;
	Fri,  5 Sep 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084091; cv=none; b=oXg6+omXjfKeKKjGPnknhZT/ia2gjJskJGLzDYA0niQdXJtoHrRZpkcREhDpnkJhwj0etbYzMZRs/cJPnGC0OXdgqsRF+Lm1LqjoBSgCdM7H99ALUmdGvY7nLecL2OQWI6bN44JOidXDykrk3GlVdq8jYMXcugvK2k1ECL67MJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084091; c=relaxed/simple;
	bh=maxOe0WRcsaENo4bT9FOMJtWjceRUuEI2izeUeUZwHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwKk1/mLSZadonaxc2ZG/j33He/fULUl8czLmbrN6UimvjChCidR2TXWGcAivcmOF2IN95XwS/4mjJ/52C5m35GrSqOfkLM3R79O+Uzd6nRmXdFKVY2K3eKzo8/IIynx4bOzeqt+ecuWwpfibpUHWmHThGG7QuHYscaJUrZHKA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jx553kPc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585BCBHB014520;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KauGYf0Yd3QsLgu5x
	f5iLWl9EICMQHQ64keyTBbW1PA=; b=jx553kPcbSDSd77F69zdGNPfxX7HTZXXp
	463GYL0gLyRZLSciyNwwY2+owbxIvE2DMAwC/0yLUS6rMdJ+SYPxBbwyB2dX/2dI
	XcBrBBxexRfzMN111THRTOscCww0E9AUo3aM/ixbxi8RJLBIXFR/68lgz/OQ7LpV
	d75+/ndQ2n4xmsYz+FDEi6VV9WaEUPspJWn/bV+hZglGoz8iLoD7jIqLxlm1t1ma
	5V4muSVQJWA0/bDwkd5lTjP5qPWB3mJ/qgZHyjNHmC2du0MsJnUgy0Kj8sbKd/sf
	25DQ++P4wquJ54aKff453JtMUBBuuxwja2qidcdKubonnPn3JPsyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3h8q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EqDAf031379;
	Fri, 5 Sep 2025 14:54:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3h8q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585DFYC5009015;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumssbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSDp52953498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE55920040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C4120043;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 4495BE1188; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
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
Subject: [PATCH net-next 14/14] net/dibs: Move event handling to dibs layer
Date: Fri,  5 Sep 2025 16:54:27 +0200
Message-ID: <20250905145428.1962105-15-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hw52JVCm_XYBoKRita0CS7UovQbTBR6d
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68baf9aa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=vHqs-Pa0AAAA:8
 a=GISX7e9OAAAA:8 a=_UGc_VUiAAAA:8 a=t7m2geA0-EshZtX51MUA:9
 a=iA2nNOD-wZm-3X-XiBKu:22 a=trjoHNCrjGc44O9AaKLZ:22 a=x1x7-7IuMbAoE1UvoNSZ:22
X-Proofpoint-GUID: Rx5LBcQQZMxLb5Ee1v-e1bO-V_9a4RLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX/MBJ4wUNlAG/
 LfSgssrf0Y4luNpHfimA2PZqjsdfE4HkVcScx9UMirXa/RY66Mh70qsFySPxu5HwwmG6rKo+cRl
 xwTA6eCU0TVQlsAeFOUT4n93Km2/STzs4Rk/pSHHM95YkyI95wSjRt9NlEeUiOuqPkYUIZCxxfH
 q5tHwd4Th9GSJlVx9vowUfRVUTCccBYwsKDrTQrYjFBtcFl60j4o7r/HE5a8IIB+O/NbVhNXMey
 v+LlZc183NpOxQ5PSfRPASdE9pxRdbaCjyCFVGRGGnkjSlX+NdZ2kYbPwKJ6nme5Uhkfr3hTeRk
 yETnMIdJTncnQadt1m0RgdWlkQPaCnmS0EIBVbV6m+wqpLjF6w7MFxSk4zS+e7TjfWTgHXf0lXU
 iN3pyKR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

From: Julian Ruess <julianr@linux.ibm.com>

Add defines for all event types and subtypes an ism device is known to
produce as it can be helpful for debugging purposes.

Introduces a generic 'struct dibs_event' and adopt ism device driver
and smc-d client accordingly. Tolerate and ignore other type and subtype
values to enable future device extensions.

SMC-D and ISM are now independent.
struct ism_dev can be moved to drivers/s390/net/ism.h.

Note that in smc, the term 'ism' is still used. Future patches could
replace that with 'dibs' or 'smc-d' as appropriate.

Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
Co-developed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 MAINTAINERS                       |   2 -
 arch/s390/configs/debug_defconfig |   1 +
 arch/s390/configs/defconfig       |   1 +
 drivers/s390/net/Kconfig          |   1 -
 drivers/s390/net/ism.h            |  42 +++++-
 drivers/s390/net/ism_drv.c        | 221 ++++++++++--------------------
 include/linux/dibs.h              |  62 +++++++++
 include/net/smc.h                 |  15 --
 net/dibs/dibs_main.c              |   2 +-
 net/smc/Kconfig                   |   1 -
 net/smc/smc_ism.c                 |  97 +++++--------
 11 files changed, 208 insertions(+), 237 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c621ed92eb0e..05818bda4262 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17577,7 +17577,6 @@ F:	include/linux/fddidevice.h
 F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
-F:	include/linux/ism.h
 F:	include/linux/netdev*
 F:	include/linux/platform_data/wiznet.h
 F:	include/uapi/linux/cn_proc.h
@@ -22234,7 +22233,6 @@ L:	linux-s390@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/s390/net/
-F:	include/linux/ism.h
 
 S390 PCI SUBSYSTEM
 M:	Niklas Schnelle <schnelle@linux.ibm.com>
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index a97c8d19f643..fdde8ee0d7bd 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -122,6 +122,7 @@ CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
+CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 7f7b52d9a33c..bf9e7dbd4a89 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -113,6 +113,7 @@ CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
 CONFIG_DIBS=y
 CONFIG_DIBS_LO=y
+CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 92985f595d59..0fd700c5745a 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -82,7 +82,6 @@ config CCWGROUP
 config ISM
 	tristate "Support for ISM vPCI Adapter"
 	depends on PCI && DIBS
-	imply SMC
 	default n
 	help
 	  Select this option if you want to use the Internal Shared Memory
diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 1b9fa14da20c..08d17956cb36 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -6,13 +6,13 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/dibs.h>
-#include <linux/ism.h>
-#include <net/smc.h>
 #include <asm/pci_insn.h>
 
 #define UTIL_STR_LEN	16
 #define ISM_ERROR	0xFFFF
 
+#define ISM_NR_DMBS	1920
+
 /*
  * Do not use the first word of the DMB bits to ensure 8 byte aligned access.
  */
@@ -34,6 +34,23 @@
 #define ISM_UNREG_SBA	0x11
 #define ISM_UNREG_IEQ	0x12
 
+enum ism_event_type {
+	ISM_EVENT_BUF = 0x00,
+	ISM_EVENT_DEV = 0x01,
+	ISM_EVENT_SWR = 0x02
+};
+
+enum ism_event_code {
+	ISM_BUF_DMB_UNREGISTERED = 0x04,
+	ISM_BUF_USING_ISM_DEV_DISABLED = 0x08,
+	ISM_BUF_OWNING_ISM_DEV_IN_ERR_STATE = 0x02,
+	ISM_BUF_USING_ISM_DEV_IN_ERR_STATE = 0x03,
+	ISM_BUF_VLAN_MISMATCH_WITH_OWNER = 0x05,
+	ISM_BUF_VLAN_MISMATCH_WITH_USER = 0x06,
+	ISM_DEV_GID_DISABLED = 0x07,
+	ISM_DEV_GID_ERR_STATE = 0x01
+};
+
 struct ism_req_hdr {
 	u32 cmd;
 	u16 : 16;
@@ -185,6 +202,14 @@ struct ism_eq_header {
 	u64 : 64;
 };
 
+struct ism_event {
+	u32 type;
+	u32 code;
+	u64 tok;
+	u64 time;
+	u64 info;
+};
+
 struct ism_eq {
 	struct ism_eq_header header;
 	struct ism_event entry[15];
@@ -199,6 +224,19 @@ struct ism_sba {
 	u16 dmbe_mask[ISM_NR_DMBS];
 };
 
+struct ism_dev {
+	spinlock_t cmd_lock; /* serializes cmds */
+	struct dibs_dev *dibs;
+	struct pci_dev *pdev;
+	struct ism_sba *sba;
+	dma_addr_t sba_dma_addr;
+	DECLARE_BITMAP(sba_bitmap, ISM_NR_DMBS);
+
+	struct ism_eq *ieq;
+	dma_addr_t ieq_dma_addr;
+	int ieq_idx;
+};
+
 #define ISM_CREATE_REQ(dmb, idx, sf, offset)		\
 	((dmb) | (idx) << 24 | (sf) << 23 | (offset))
 
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 346d1ea8650b..f84aa2e676e9 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -31,86 +31,6 @@ MODULE_DEVICE_TABLE(pci, ism_device_table);
 
 static debug_info_t *ism_debug_info;
 
-#define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
-static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
-						/* a list for fast mapping  */
-static u8 max_client;
-static DEFINE_MUTEX(clients_lock);
-struct ism_dev_list {
-	struct list_head list;
-	struct mutex mutex; /* protects ism device list */
-};
-
-static struct ism_dev_list ism_dev_list = {
-	.list = LIST_HEAD_INIT(ism_dev_list.list),
-	.mutex = __MUTEX_INITIALIZER(ism_dev_list.mutex),
-};
-
-static void ism_setup_forwarding(struct ism_client *client, struct ism_dev *ism)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ism->lock, flags);
-	ism->subs[client->id] = client;
-	spin_unlock_irqrestore(&ism->lock, flags);
-}
-
-int ism_register_client(struct ism_client *client)
-{
-	struct ism_dev *ism;
-	int i, rc = -ENOSPC;
-
-	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	for (i = 0; i < MAX_CLIENTS; ++i) {
-		if (!clients[i]) {
-			clients[i] = client;
-			client->id = i;
-			if (i == max_client)
-				max_client++;
-			rc = 0;
-			break;
-		}
-	}
-	mutex_unlock(&clients_lock);
-
-	if (i < MAX_CLIENTS) {
-		/* initialize with all devices that we got so far */
-		list_for_each_entry(ism, &ism_dev_list.list, list) {
-			ism->priv[i] = NULL;
-			ism_setup_forwarding(client, ism);
-		}
-	}
-	mutex_unlock(&ism_dev_list.mutex);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(ism_register_client);
-
-int ism_unregister_client(struct ism_client *client)
-{
-	struct ism_dev *ism;
-	unsigned long flags;
-	int rc = 0;
-
-	mutex_lock(&ism_dev_list.mutex);
-	list_for_each_entry(ism, &ism_dev_list.list, list) {
-		spin_lock_irqsave(&ism->lock, flags);
-		/* Stop forwarding IRQs and events */
-		ism->subs[client->id] = NULL;
-		spin_unlock_irqrestore(&ism->lock, flags);
-	}
-	mutex_unlock(&ism_dev_list.mutex);
-
-	mutex_lock(&clients_lock);
-	clients[client->id] = NULL;
-	if (client->id + 1 == max_client)
-		max_client--;
-	mutex_unlock(&clients_lock);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(ism_unregister_client);
-
 static int ism_cmd(struct ism_dev *ism, void *cmd)
 {
 	struct ism_req_hdr *req = cmd;
@@ -445,6 +365,24 @@ static int ism_del_vlan_id(struct dibs_dev *dibs, u64 vlan_id)
 	return ism_cmd(ism, &cmd);
 }
 
+static int ism_signal_ieq(struct dibs_dev *dibs, const uuid_t *rgid,
+			  u32 trigger_irq, u32 event_code, u64 info)
+{
+	struct ism_dev *ism = dibs->drv_priv;
+	union ism_sig_ieq cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	memcpy(&cmd.request.rgid, rgid, sizeof(cmd.request.rgid));
+	cmd.request.trigger_irq = trigger_irq;
+	cmd.request.event_code = event_code;
+	cmd.request.info = info;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static unsigned int max_bytes(unsigned int start, unsigned int len,
 			      unsigned int boundary)
 {
@@ -487,22 +425,68 @@ static u16 ism_get_chid(struct dibs_dev *dibs)
 	return to_zpci(ism->pdev)->pchid;
 }
 
+static int ism_match_event_type(u32 s390_event_type)
+{
+	switch (s390_event_type) {
+	case ISM_EVENT_BUF:
+		return DIBS_BUF_EVENT;
+	case ISM_EVENT_DEV:
+		return DIBS_DEV_EVENT;
+	case ISM_EVENT_SWR:
+		return DIBS_SW_EVENT;
+	default:
+		return DIBS_OTHER_TYPE;
+	}
+}
+
+static int ism_match_event_subtype(u32 s390_event_subtype)
+{
+	switch (s390_event_subtype) {
+	case ISM_BUF_DMB_UNREGISTERED:
+		return DIBS_BUF_UNREGISTERED;
+	case ISM_DEV_GID_DISABLED:
+		return DIBS_DEV_DISABLED;
+	case ISM_DEV_GID_ERR_STATE:
+		return DIBS_DEV_ERR_STATE;
+	default:
+		return DIBS_OTHER_SUBTYPE;
+	}
+}
+
 static void ism_handle_event(struct ism_dev *ism)
 {
+	struct dibs_dev *dibs = ism->dibs;
+	struct dibs_event event;
 	struct ism_event *entry;
-	struct ism_client *clt;
+	struct dibs_client *clt;
 	int i;
 
 	while ((ism->ieq_idx + 1) != READ_ONCE(ism->ieq->header.idx)) {
-		if (++(ism->ieq_idx) == ARRAY_SIZE(ism->ieq->entry))
+		if (++ism->ieq_idx == ARRAY_SIZE(ism->ieq->entry))
 			ism->ieq_idx = 0;
 
 		entry = &ism->ieq->entry[ism->ieq_idx];
 		debug_event(ism_debug_info, 2, entry, sizeof(*entry));
-		for (i = 0; i < max_client; ++i) {
-			clt = ism->subs[i];
+		__memset(&event, 0, sizeof(event));
+		event.type = ism_match_event_type(entry->type);
+		if (event.type == DIBS_SW_EVENT)
+			event.subtype = entry->code;
+		else
+			event.subtype = ism_match_event_subtype(entry->code);
+		event.time = entry->time;
+		event.data = entry->info;
+		switch (event.type) {
+		case DIBS_BUF_EVENT:
+			event.buffer_tok = entry->tok;
+			break;
+		case DIBS_DEV_EVENT:
+		case DIBS_SW_EVENT:
+			memcpy(&event.gid, &entry->tok, sizeof(u64));
+		}
+		for (i = 0; i < MAX_DIBS_CLIENTS; ++i) {
+			clt = dibs->subs[i];
 			if (clt)
-				clt->handle_event(ism, entry);
+				clt->ops->handle_event(dibs, &event);
 		}
 	}
 }
@@ -560,12 +544,13 @@ static const struct dibs_dev_ops ism_ops = {
 	.move_data = ism_move,
 	.add_vlan_id = ism_add_vlan_id,
 	.del_vlan_id = ism_del_vlan_id,
+	.signal_event = ism_signal_ieq,
 };
 
 static int ism_dev_init(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
-	int i, ret;
+	int ret;
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
 	if (ret <= 0)
@@ -584,18 +569,6 @@ static int ism_dev_init(struct ism_dev *ism)
 	if (ret)
 		goto unreg_sba;
 
-	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	for (i = 0; i < max_client; ++i) {
-		if (clients[i]) {
-			ism_setup_forwarding(clients[i], ism);
-		}
-	}
-	mutex_unlock(&clients_lock);
-
-	list_add(&ism->list, &ism_dev_list.list);
-	mutex_unlock(&ism_dev_list.mutex);
-
 	query_info(ism);
 	return 0;
 
@@ -612,22 +585,11 @@ static int ism_dev_init(struct ism_dev *ism)
 static void ism_dev_exit(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&ism->lock, flags);
-	for (i = 0; i < max_client; ++i)
-		ism->subs[i] = NULL;
-	spin_unlock_irqrestore(&ism->lock, flags);
-
-	mutex_lock(&ism_dev_list.mutex);
 
 	unregister_ieq(ism);
 	unregister_sba(ism);
 	free_irq(pci_irq_vector(pdev, 0), ism);
 	pci_free_irq_vectors(pdev);
-	list_del_init(&ism->list);
-	mutex_unlock(&ism_dev_list.mutex);
 }
 
 static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -641,7 +603,6 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!ism)
 		return -ENOMEM;
 
-	spin_lock_init(&ism->lock);
 	spin_lock_init(&ism->cmd_lock);
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
@@ -742,8 +703,6 @@ static int __init ism_init(void)
 	if (!ism_debug_info)
 		return -ENODEV;
 
-	memset(clients, 0, sizeof(clients));
-	max_client = 0;
 	debug_register_view(ism_debug_info, &debug_hex_ascii_view);
 	ret = pci_register_driver(&ism_driver);
 	if (ret)
@@ -760,41 +719,3 @@ static void __exit ism_exit(void)
 
 module_init(ism_init);
 module_exit(ism_exit);
-
-/*************************** SMC-D Implementation *****************************/
-
-#if IS_ENABLED(CONFIG_SMC)
-static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
-			  u32 event_code, u64 info)
-{
-	union ism_sig_ieq cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
-	cmd.request.hdr.len = sizeof(cmd.request);
-
-	cmd.request.rgid = rgid;
-	cmd.request.trigger_irq = trigger_irq;
-	cmd.request.event_code = event_code;
-	cmd.request.info = info;
-
-	return ism_cmd(ism, &cmd);
-}
-
-static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			   u32 trigger_irq, u32 event_code, u64 info)
-{
-	return ism_signal_ieq(smcd->priv, rgid->gid,
-			      trigger_irq, event_code, info);
-}
-
-static const struct smcd_ops ism_smcd_ops = {
-	.signal_event = smcd_signal_ieq,
-};
-
-const struct smcd_ops *ism_get_smcd_ops(void)
-{
-	return &ism_smcd_ops;
-}
-EXPORT_SYMBOL_GPL(ism_get_smcd_ops);
-#endif
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index be009c614205..c75607f8a5cf 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -67,6 +67,41 @@ struct dibs_dmb {
 	dma_addr_t dma_addr;
 };
 
+/* DIBS events
+ * -----------
+ * Dibs devices can optionally notify dibs clients about events that happened
+ * in the fabric or at the remote device or remote dmb.
+ */
+enum dibs_event_type {
+	/* Buffer event, e.g. a remote dmb was unregistered */
+	DIBS_BUF_EVENT,
+	/* Device event, e.g. a remote dibs device was disabled */
+	DIBS_DEV_EVENT,
+	/* Software event, a dibs client can send an event signal to a
+	 * remote dibs device.
+	 */
+	DIBS_SW_EVENT,
+	DIBS_OTHER_TYPE };
+
+enum dibs_event_subtype {
+	DIBS_BUF_UNREGISTERED,
+	DIBS_DEV_DISABLED,
+	DIBS_DEV_ERR_STATE,
+	DIBS_OTHER_SUBTYPE
+};
+
+struct dibs_event {
+	u32 type;
+	u32 subtype;
+	/* uuid_null if invalid */
+	uuid_t gid;
+	/* zero if invalid */
+	u64 buffer_tok;
+	u64 time;
+	/* additional data or zero */
+	u64 data;
+};
+
 struct dibs_dev;
 
 /* DIBS client
@@ -117,6 +152,15 @@ struct dibs_client_ops {
 	 */
 	void (*handle_irq)(struct dibs_dev *dev, unsigned int idx,
 			   u16 dmbemask);
+	/**
+	 * handle_event() - Handle control information sent by device
+	 * @dev: device reporting the event
+	 * @event: ism event structure
+	 *
+	 * * Context: Called in IRQ context by dibs device driver
+	 */
+	void (*handle_event)(struct dibs_dev *dev,
+			     const struct dibs_event *event);
 };
 
 struct dibs_client {
@@ -285,6 +329,24 @@ struct dibs_dev_ops {
 	 * Return: zero on success
 	 */
 	int (*del_vlan_id)(struct dibs_dev *dev, u64 vlan_id);
+	/**
+	 * signal_event() - trigger an event at a remote dibs device (optional)
+	 * @dev: local dibs device
+	 * @rgid: gid of remote dibs device
+	 * trigger_irq: zero: notification may be coalesced with other events
+	 *		non-zero: notify immediately
+	 * @subtype: 4 byte event code, meaning is defined by dibs client
+	 * @data: 8 bytes of additional information,
+	 *	  meaning is defined by dibs client
+	 *
+	 * dibs devices can offer support for sending a control event of type
+	 * EVENT_SWR to a remote dibs device.
+	 * NOTE: handle_event() will be called for all registered dibs clients
+	 * at the remote device.
+	 * Return: zero on success
+	 */
+	int (*signal_event)(struct dibs_dev *dev, const uuid_t *rgid,
+			    u32 trigger_irq, u32 event_code, u64 info);
 	/**
 	 * support_mmapped_rdmb() - can this device provide memory mapped
 	 *			    remote dmbs? (optional)
diff --git a/include/net/smc.h b/include/net/smc.h
index 8e3debcf7db5..08bee529ed8d 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -16,7 +16,6 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/dibs.h>
-#include "linux/ism.h"
 
 struct sock;
 
@@ -28,28 +27,14 @@ struct smc_hashinfo {
 };
 
 /* SMCD/ISM device driver interface */
-#define ISM_EVENT_DMB	0
-#define ISM_EVENT_GID	1
-#define ISM_EVENT_SWR	2
-
 #define ISM_RESERVED_VLANID	0x1FFF
 
-struct smcd_dev;
-
 struct smcd_gid {
 	u64	gid;
 	u64	gid_ext;
 };
 
-struct smcd_ops {
-	/* optional operations */
-	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
-			    u32 trigger_irq, u32 event_code, u64 info);
-};
-
 struct smcd_dev {
-	const struct smcd_ops *ops;
-	void *priv;
 	struct dibs_dev *dibs;
 	struct list_head list;
 	spinlock_t lock;
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index aacb3ea7825a..5425238d5a42 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -98,7 +98,7 @@ int dibs_unregister_client(struct dibs_client *client)
 				goto err_reg_dmb;
 			}
 		}
-		/* Stop forwarding IRQs */
+		/* Stop forwarding IRQs and events */
 		dibs->subs[client->id] = NULL;
 		spin_unlock_irqrestore(&dibs->lock, flags);
 		clients[client->id]->ops->del_dev(dibs);
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 9535d88c2acb..99ecd59d1f4b 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -2,7 +2,6 @@
 config SMC
 	tristate "SMC socket protocol family"
 	depends on INET && INFINIBAND && DIBS
-	depends on m || ISM != m
 	help
 	  SMC-R provides a "sockets over RDMA" solution making use of
 	  RDMA over Converged Ethernet (RoCE) technology to upgrade
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index f4a3e7e56034..7b228ca2f96a 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -17,7 +17,6 @@
 #include "smc_ism.h"
 #include "smc_pnet.h"
 #include "smc_netlink.h"
-#include "linux/ism.h"
 #include "linux/dibs.h"
 
 struct smcd_dev_list smcd_dev_list = {
@@ -30,20 +29,15 @@ static u8 smc_ism_v2_system_eid[SMC_MAX_EID_LEN];
 
 static void smcd_register_dev(struct dibs_dev *dibs);
 static void smcd_unregister_dev(struct dibs_dev *dibs);
-#if IS_ENABLED(CONFIG_ISM)
-static void smcd_handle_event(struct ism_dev *ism, struct ism_event *event);
-
-static struct ism_client smc_ism_client = {
-	.name = "SMC-D",
-	.handle_event = smcd_handle_event,
-};
-#endif
+static void smcd_handle_event(struct dibs_dev *dibs,
+			      const struct dibs_event *event);
 static void smcd_handle_irq(struct dibs_dev *dibs, unsigned int dmbno,
 			    u16 dmbemask);
 
 static struct dibs_client_ops smc_client_ops = {
 	.add_dev = smcd_register_dev,
 	.del_dev = smcd_unregister_dev,
+	.handle_event = smcd_handle_event,
 	.handle_irq = smcd_handle_irq,
 };
 
@@ -399,11 +393,10 @@ int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
-#if IS_ENABLED(CONFIG_ISM)
 struct smc_ism_event_work {
 	struct work_struct work;
 	struct smcd_dev *smcd;
-	struct ism_event event;
+	struct dibs_event event;
 };
 
 #define ISM_EVENT_REQUEST		0x0001
@@ -423,25 +416,27 @@ union smcd_sw_event_info {
 
 static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
 {
-	struct smcd_gid peer_gid = { .gid = wrk->event.tok,
-				     .gid_ext = 0 };
+	struct dibs_dev *dibs = wrk->smcd->dibs;
 	union smcd_sw_event_info ev_info;
+	struct smcd_gid peer_gid;
+	uuid_t ism_rgid;
 
-	ev_info.info = wrk->event.info;
-	switch (wrk->event.code) {
+	copy_to_smcdgid(&peer_gid, &wrk->event.gid);
+	ev_info.info = wrk->event.data;
+	switch (wrk->event.subtype) {
 	case ISM_EVENT_CODE_SHUTDOWN:	/* Peer shut down DMBs */
 		smc_smcd_terminate(wrk->smcd, &peer_gid, ev_info.vlan_id);
 		break;
 	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
 		if (ev_info.code == ISM_EVENT_REQUEST &&
-		    wrk->smcd->ops->signal_event) {
+		    dibs->ops->signal_event) {
 			ev_info.code = ISM_EVENT_RESPONSE;
-			wrk->smcd->ops->signal_event(wrk->smcd,
-						     &peer_gid,
-						     ISM_EVENT_REQUEST_IR,
-						     ISM_EVENT_CODE_TESTLINK,
-						     ev_info.info);
-			}
+			copy_to_dibsgid(&ism_rgid, &peer_gid);
+			dibs->ops->signal_event(dibs, &ism_rgid,
+					       ISM_EVENT_REQUEST_IR,
+					       ISM_EVENT_CODE_TESTLINK,
+					       ev_info.info);
+		}
 		break;
 	}
 }
@@ -451,26 +446,24 @@ static void smc_ism_event_work(struct work_struct *work)
 {
 	struct smc_ism_event_work *wrk =
 		container_of(work, struct smc_ism_event_work, work);
-	struct smcd_gid smcd_gid = { .gid = wrk->event.tok,
-				     .gid_ext = 0 };
+	struct smcd_gid smcd_gid;
+
+	copy_to_smcdgid(&smcd_gid, &wrk->event.gid);
 
 	switch (wrk->event.type) {
-	case ISM_EVENT_GID:	/* GID event, token is peer GID */
+	case DIBS_DEV_EVENT: /* GID event, token is peer GID */
 		smc_smcd_terminate(wrk->smcd, &smcd_gid, VLAN_VID_MASK);
 		break;
-	case ISM_EVENT_DMB:
+	case DIBS_BUF_EVENT:
 		break;
-	case ISM_EVENT_SWR:	/* Software defined event */
+	case DIBS_SW_EVENT: /* Software defined event */
 		smcd_handle_sw_event(wrk);
 		break;
 	}
 	kfree(wrk);
 }
-#endif
 
-static struct smcd_dev *smcd_alloc_dev(const char *name,
-				       const struct smcd_ops *ops,
-				       int max_dmbs)
+static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
 {
 	struct smcd_dev *smcd;
 
@@ -487,8 +480,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *name,
 	if (!smcd->event_wq)
 		goto free_conn;
 
-	smcd->ops = ops;
-
 	spin_lock_init(&smcd->lock);
 	spin_lock_init(&smcd->lgr_lock);
 	INIT_LIST_HEAD(&smcd->vlan);
@@ -506,34 +497,17 @@ static struct smcd_dev *smcd_alloc_dev(const char *name,
 static void smcd_register_dev(struct dibs_dev *dibs)
 {
 	struct smcd_dev *smcd, *fentry;
-	const struct smcd_ops *ops;
-	struct ism_dev *ism;
 	int max_dmbs;
 
 	max_dmbs = dibs->ops->max_dmbs();
 
-	if (smc_ism_is_loopback(dibs)) {
-		ops = NULL;
-	} else {
-		ism = dibs->drv_priv;
-		ops = ism_get_smcd_ops();
-	}
-	smcd = smcd_alloc_dev(dev_name(&dibs->dev), ops, max_dmbs);
+	smcd = smcd_alloc_dev(dev_name(&dibs->dev), max_dmbs);
 	if (!smcd)
 		return;
 
 	smcd->dibs = dibs;
 	dibs_set_priv(dibs, &smc_dibs_client, smcd);
 
-	if (smc_ism_is_loopback(dibs)) {
-		smcd->priv = NULL;
-	} else {
-		smcd->priv = ism;
-#if IS_ENABLED(CONFIG_ISM)
-		ism_set_priv(ism, &smc_ism_client, smcd);
-#endif
-	}
-
 	if (smc_pnetid_by_dev_port(dibs->dev.parent, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
@@ -588,7 +562,6 @@ static void smcd_unregister_dev(struct dibs_dev *dibs)
 	kfree(smcd);
 }
 
-#if IS_ENABLED(CONFIG_ISM)
 /* SMCD Device event handler. Called from ISM device interrupt handler.
  * Parameters are ism device pointer,
  * - event->type (0 --> DMB, 1 --> GID),
@@ -600,9 +573,10 @@ static void smcd_unregister_dev(struct dibs_dev *dibs)
  * Context:
  * - Function called in IRQ context from ISM device driver event handler.
  */
-static void smcd_handle_event(struct ism_dev *ism, struct ism_event *event)
+static void smcd_handle_event(struct dibs_dev *dibs,
+			      const struct dibs_event *event)
 {
-	struct smcd_dev *smcd = ism_get_priv(ism, &smc_ism_client);
+	struct smcd_dev *smcd = dibs_get_priv(dibs, &smc_dibs_client);
 	struct smc_ism_event_work *wrk;
 
 	if (smcd->going_away)
@@ -637,27 +611,26 @@ static void smcd_handle_irq(struct dibs_dev *dibs, unsigned int dmbno,
 		tasklet_schedule(&conn->rx_tsklet);
 	spin_unlock_irqrestore(&smcd->lock, flags);
 }
-#endif
 
 int smc_ism_signal_shutdown(struct smc_link_group *lgr)
 {
 	int rc = 0;
-#if IS_ENABLED(CONFIG_ISM)
 	union smcd_sw_event_info ev_info;
+	uuid_t ism_rgid;
 
 	if (lgr->peer_shutdown)
 		return 0;
-	if (!lgr->smcd->ops->signal_event)
+	if (!lgr->smcd->dibs->ops->signal_event)
 		return 0;
 
 	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
 	ev_info.vlan_id = lgr->vlan_id;
 	ev_info.code = ISM_EVENT_REQUEST;
-	rc = lgr->smcd->ops->signal_event(lgr->smcd, &lgr->peer_gid,
+	copy_to_dibsgid(&ism_rgid, &lgr->peer_gid);
+	rc = lgr->smcd->dibs->ops->signal_event(lgr->smcd->dibs, &ism_rgid,
 					  ISM_EVENT_REQUEST_IR,
 					  ISM_EVENT_CODE_SHUTDOWN,
 					  ev_info.info);
-#endif
 	return rc;
 }
 
@@ -668,9 +641,6 @@ int smc_ism_init(void)
 	smc_ism_v2_capable = false;
 	smc_ism_create_system_eid();
 
-#if IS_ENABLED(CONFIG_ISM)
-	rc = ism_register_client(&smc_ism_client);
-#endif
 	rc = dibs_register_client(&smc_dibs_client);
 	return rc;
 }
@@ -678,7 +648,4 @@ int smc_ism_init(void)
 void smc_ism_exit(void)
 {
 	dibs_unregister_client(&smc_dibs_client);
-#if IS_ENABLED(CONFIG_ISM)
-	ism_unregister_client(&smc_ism_client);
-#endif
 }
-- 
2.48.1


