Return-Path: <linux-rdma+bounces-21085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OHaFHjdDmoVCwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:24:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 749685A33DE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A944320E1C2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6BC37F8CC;
	Thu, 21 May 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Dy4iL4Q5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA42EDD69;
	Thu, 21 May 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357255; cv=none; b=qbwujoaQw+0lJt9AsGuyttcvIECrZ/eEX+kIgTvv2fARpqO2yAZTpLD7QZB7Zp04EXD3Ij7HTgJsfw1V6/7fhR9PzLdV4TfLGJ7UK25rX51NMoaFEJjfsULQXtKQIGcyFfuyxAhmFQQTNxOuAUydD9XWxGPtAA4bGtQQicXWIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357255; c=relaxed/simple;
	bh=SfpGM/Cp8XliWvZ1hnlqeOrzGpnn7n+Jxi8bBk2vmSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8qMeKthTnSJkqM1+z87I++4/pi6BwD5kfzJmuv9ai+wOsTRP/OP7qqFluYwHBPDK77myQDfYbBhLD3z7TtU0V9z4Gg5Ed+MEcLTkaqq6FCLlTqoQtngG760F7zJJvEMl6O70TFMuUFuHmxgOmu275mJRIOaYj/wyL2LW8onA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Dy4iL4Q5; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L17g412256088;
	Thu, 21 May 2026 02:53:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	LUmerpdkbXy4nockH7MDnr5cB3b68nzRdSTqBvvuIA=; b=Dy4iL4Q5tMrReyUZc
	4RErB6GfZtkI8qimJSZstqRcoXv0hs0vJcT+O9alPDQLzte4+VbQG/4GYE/wdSUk
	WH72TmonuPc2hPPOt3v+p6+AI5zMxZuYK3kJMcalFTgM+/NVitQ2El+rEG8yCCQj
	DwyP8dcUWcPMiUlR+Wz5zgKufvTTODjoeG+qkEJy9gWx7E7lUUaFM1BXvA95W4WC
	++Qsz5wfXye+YV3cc9tkbyXFjpw2c3eyiOm+9+3yNld7FjXY+62v31w1uK8ZgllF
	AUg+vi/mH0TstjGlGowR26ijN3lldrAujM2EqwRm0b70rqh7kXiuiJ/z11cHrc6s
	HkhSA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e94eummxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:53:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 21 May 2026 02:53:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 21 May 2026 02:53:45 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 74C273F7063;
	Thu, 21 May 2026 02:53:35 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v16 net-next 3/9] devlink: pass param values by pointer
Date: Thu, 21 May 2026 15:22:57 +0530
Message-ID: <20260521095303.2395584-4-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521095303.2395584-1-rkannoth@marvell.com>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA5OCBTYWx0ZWRfX3mALz01mrkHR
 GTB7dUpQT6eBJGgpAakmd0rNmLwK6p9Qt4GHKI2SE0KJxC7f8IQv1KWVipyzqy7znOKcU+3lYN5
 EIfDFfDO0CTvWSf/Z6gZdCOK4AIQt7v6WWFvQS71HfSnEzyvRzT9FU0HDrFARlVwcVdh2ZoPdE/
 tTXkFZ2m5i9u1WaArUR98UnKUgprFD7FpWcJSGeQqSRPU2EVMitAJ05lqMOSB2/af+kL2UTQWl9
 3NfrH5SVFtyLzN2NREbAQ91CXr7pnPoItF61hCh3amY9DFh6JI41/loD0qexYjagOTOjHEKujWd
 hdXS0Yk0J7gLqCSiQGCZJjJW2lj2ecU0dyQ0jocFlALVed5Y2e8b5ZF0m+YVzMNV1iymGlcc4o7
 6Eq3J08SS55l8uylIUUTxakrc6Yf53BZO7zwgM9T05jDg8lkrh/L5wijgNUN4JXM9ptPaR9l/S5
 XxMQ6wjf8N8Pp8eF7Ew==
X-Proofpoint-ORIG-GUID: y5rPURhMRoI3zfvupP3_izJuJJAAJEu1
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a0ed62a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=Ikd4Dj_1AAAA:8 a=QyXUC8HyAAAA:8 a=vggBfdFIAAAA:8
 a=M5GUcnROAAAA:8 a=8elGb79likIP2RDsjREA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: y5rPURhMRoI3zfvupP3_izJuJJAAJEu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21085-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:mid,marvell.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 749685A33DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

union devlink_param_value grows substantially once U64 array
parameters are added to devlink (from 32 bytes to over 264 bytes).
devlink_nl_param_value_fill_one() and devlink_nl_param_value_put()
copy the union by value in several places. Passing two instances as
value arguments alone consumes over 528 bytes of stack; combined with
deeper call chains the parameter stack can approach 800 bytes and trip
CONFIG_FRAME_WARN more easily.

Switch internal helpers and exported driver APIs to pass pointers to
union devlink_param_value rather than passing the union by value.

Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com> #for ena
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/dpll/zl3073x/devlink.c                |  6 +-
 drivers/net/ethernet/amazon/ena/ena_devlink.c |  8 +--
 drivers/net/ethernet/amd/pds_core/core.h      |  2 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  6 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  | 30 ++++----
 .../marvell/octeontx2/af/rvu_devlink.c        | 22 +++---
 .../marvell/octeontx2/nic/otx2_devlink.c      |  4 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     | 14 ++--
 .../net/ethernet/mellanox/mlx5/core/devlink.c | 72 +++++++++----------
 .../mellanox/mlx5/core/eswitch_offloads.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  4 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 12 ++--
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  8 +--
 .../ethernet/netronome/nfp/devlink_param.c    |  6 +-
 drivers/net/netdevsim/dev.c                   |  4 +-
 include/net/devlink.h                         |  4 +-
 net/devlink/param.c                           | 32 ++++-----
 18 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index ccc22332b346..218b08fd8a30 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -315,10 +315,10 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
 
 static int
 zl3073x_devlink_param_clock_id_validate(struct devlink *devlink, u32 id,
-					union devlink_param_value val,
+					union devlink_param_value *val,
 					struct netlink_ext_ack *extack)
 {
-	if (!val.vu64) {
+	if (!val->vu64) {
 		NL_SET_ERR_MSG_MOD(extack, "'clock_id' must be non-zero");
 		return -EINVAL;
 	}
@@ -377,7 +377,7 @@ int zl3073x_devlink_register(struct zl3073x_dev *zldev)
 	value.vu64 = zldev->clock_id;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
-					value);
+					&value);
 
 	/* Register devlink instance */
 	devl_register(devlink);
diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c b/drivers/net/ethernet/amazon/ena/ena_devlink.c
index 4772185e669d..5ea9fef149aa 100644
--- a/drivers/net/ethernet/amazon/ena/ena_devlink.c
+++ b/drivers/net/ethernet/amazon/ena/ena_devlink.c
@@ -8,12 +8,12 @@
 #include "ena_phc.h"
 
 static int ena_devlink_enable_phc_validate(struct devlink *devlink, u32 id,
-					   union devlink_param_value val,
+					   union devlink_param_value *val,
 					   struct netlink_ext_ack *extack)
 {
 	struct ena_adapter *adapter = ENA_DEVLINK_PRIV(devlink);
 
-	if (!val.vbool)
+	if (!val->vbool)
 		return 0;
 
 	if (!ena_com_phc_supported(adapter->ena_dev)) {
@@ -57,7 +57,7 @@ void ena_devlink_disable_phc_param(struct devlink *devlink)
 	value.vbool = false;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
-					value);
+					&value);
 	devl_unlock(devlink);
 }
 
@@ -151,7 +151,7 @@ static int ena_devlink_configure_params(struct devlink *devlink)
 	value.vbool = ena_phc_is_enabled(adapter);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
-					value);
+					&value);
 	devl_unlock(devlink);
 
 	return 0;
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 4a6b35c84dab..b7fe9ad73349 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -261,7 +261,7 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
 		       struct devlink_param_gset_ctx *ctx,
 		       struct netlink_ext_ack *extack);
 int pdsc_dl_enable_validate(struct devlink *dl, u32 id,
-			    union devlink_param_value val,
+			    union devlink_param_value *val,
 			    struct netlink_ext_ack *extack);
 
 void __iomem *pdsc_map_dbpage(struct pdsc *pdsc, int page_num);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index b576be626a29..fe0595d31683 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -68,7 +68,7 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
 }
 
 int pdsc_dl_enable_validate(struct devlink *dl, u32 id,
-			    union devlink_param_value val,
+			    union devlink_param_value *val,
 			    struct netlink_ext_ack *extack)
 {
 	struct pdsc *pdsc = devlink_priv(dl);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 835f2b413931..eb17a3454b4c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -1123,7 +1123,7 @@ static int bnxt_dl_nvm_param_set(struct devlink *dl, u32 id,
 }
 
 static int bnxt_dl_roce_validate(struct devlink *dl, u32 id,
-				 union devlink_param_value val,
+				 union devlink_param_value *val,
 				 struct netlink_ext_ack *extack)
 {
 	const struct bnxt_dl_nvm_param nvm_roce_cap = {0, NVM_OFF_RDMA_CAPABLE,
@@ -1149,7 +1149,7 @@ static int bnxt_dl_roce_validate(struct devlink *dl, u32 id,
 }
 
 static int bnxt_dl_msix_validate(struct devlink *dl, u32 id,
-				 union devlink_param_value val,
+				 union devlink_param_value *val,
 				 struct netlink_ext_ack *extack)
 {
 	int max_val = -1;
@@ -1160,7 +1160,7 @@ static int bnxt_dl_msix_validate(struct devlink *dl, u32 id,
 	if (id == DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN)
 		max_val = BNXT_MSIX_VEC_MIN_MAX;
 
-	if (val.vu32 > max_val) {
+	if (val->vu32 > max_val) {
 		NL_SET_ERR_MSG_MOD(extack, "MSIX value is exceeding the range");
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 641d6e289d5c..22b7d8e6bd9e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -671,10 +671,10 @@ static int ice_devlink_tx_sched_layers_set(struct devlink *devlink, u32 id,
  * error.
  */
 static int ice_devlink_tx_sched_layers_validate(struct devlink *devlink, u32 id,
-						union devlink_param_value val,
+						union devlink_param_value *val,
 						struct netlink_ext_ack *extack)
 {
-	if (val.vu8 != ICE_SCHED_5_LAYERS && val.vu8 != ICE_SCHED_9_LAYERS) {
+	if (val->vu8 != ICE_SCHED_5_LAYERS && val->vu8 != ICE_SCHED_9_LAYERS) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Wrong number of tx scheduler layers provided.");
 		return -EINVAL;
@@ -1398,7 +1398,7 @@ static int ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
 
 static int
 ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
-				 union devlink_param_value val,
+				 union devlink_param_value *val,
 				 struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
@@ -1465,7 +1465,7 @@ static int ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
 
 static int
 ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
-			       union devlink_param_value val,
+			       union devlink_param_value *val,
 			       struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
@@ -1591,10 +1591,10 @@ static int ice_devlink_local_fwd_set(struct devlink *devlink, u32 id,
  * error.
  */
 static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
-					  union devlink_param_value val,
+					  union devlink_param_value *val,
 					  struct netlink_ext_ack *extack)
 {
-	if (ice_devlink_local_fwd_str_to_mode(val.vstr) < 0) {
+	if (ice_devlink_local_fwd_str_to_mode(val->vstr) < 0) {
 		NL_SET_ERR_MSG_MOD(extack, "Error: Requested value is not supported.");
 		return -EINVAL;
 	}
@@ -1604,12 +1604,12 @@ static int ice_devlink_local_fwd_validate(struct devlink *devlink, u32 id,
 
 static int
 ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
-				 union devlink_param_value val,
+				 union devlink_param_value *val,
 				 struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 
-	if (val.vu32 > pf->hw.func_caps.common_cap.num_msix_vectors)
+	if (val->vu32 > pf->hw.func_caps.common_cap.num_msix_vectors)
 		return -EINVAL;
 
 	return 0;
@@ -1617,21 +1617,21 @@ ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
 
 static int
 ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
-				 union devlink_param_value val,
+				 union devlink_param_value *val,
 				 struct netlink_ext_ack *extack)
 {
-	if (val.vu32 < ICE_MIN_MSIX)
+	if (val->vu32 < ICE_MIN_MSIX)
 		return -EINVAL;
 
 	return 0;
 }
 
 static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
-					    union devlink_param_value val,
+					    union devlink_param_value *val,
 					    struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
-	bool new_state = val.vbool;
+	bool new_state = val->vbool;
 
 	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
 		return -EOPNOTSUPP;
@@ -1791,16 +1791,16 @@ int ice_devlink_register_params(struct ice_pf *pf)
 	value.vu32 = pf->msix.max;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MAX,
-					value);
+					&value);
 	value.vu32 = pf->msix.min;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_MSIX_VEC_PER_PF_MIN,
-					value);
+					&value);
 
 	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
-					value);
+					&value);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 6494a9ee2f0d..a42404e6db7c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1180,12 +1180,12 @@ static void rvu_health_reporters_destroy(struct rvu *rvu)
 
 /* Devlink Params APIs */
 static int rvu_af_dl_dwrr_mtu_validate(struct devlink *devlink, u32 id,
-				       union devlink_param_value val,
+				       union devlink_param_value *val,
 				       struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
-	int dwrr_mtu = val.vu32;
+	int dwrr_mtu = val->vu32;
 	struct nix_txsch *txsch;
 	struct nix_hw *nix_hw;
 
@@ -1295,14 +1295,14 @@ static int rvu_af_npc_defrag(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_npc_defrag_feature_validate(struct devlink *devlink, u32 id,
-					      union devlink_param_value val,
+					      union devlink_param_value *val,
 					      struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
 	u64 enable;
 
-	if (kstrtoull(val.vstr, 10, &enable)) {
+	if (kstrtoull(val->vstr, 10, &enable)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Only 1 value is supported");
 		return -EINVAL;
@@ -1351,14 +1351,14 @@ static int rvu_af_npc_exact_feature_disable(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_npc_exact_feature_validate(struct devlink *devlink, u32 id,
-					     union devlink_param_value val,
+					     union devlink_param_value *val,
 					     struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
 	u64 enable;
 
-	if (kstrtoull(val.vstr, 10, &enable)) {
+	if (kstrtoull(val->vstr, 10, &enable)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Only 1 value is supported");
 		return -EINVAL;
@@ -1414,7 +1414,7 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_set(struct devlink *devlink, u32
 }
 
 static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink, u32 id,
-							 union devlink_param_value val,
+							 union devlink_param_value *val,
 							 struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
@@ -1422,7 +1422,7 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink
 	struct npc_mcam *mcam;
 
 	/* The percent of high prio zone must range from 12% to 100% of unreserved mcam space */
-	if (val.vu8 < 12 || val.vu8 > 100) {
+	if (val->vu8 < 12 || val->vu8 > 100) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "mcam high zone percent must be between 12% to 100%");
 		return -EINVAL;
@@ -1504,7 +1504,7 @@ static int rvu_af_dl_nix_maxlf_set(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
-					union devlink_param_value val,
+					union devlink_param_value *val,
 					struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
@@ -1528,13 +1528,13 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
 		return -EPERM;
 	}
 
-	if (max_nix0_lf && val.vu16 > max_nix0_lf) {
+	if (max_nix0_lf && val->vu16 > max_nix0_lf) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "requested nixlf is greater than the max supported nix0_lf");
 		return -EPERM;
 	}
 
-	if (max_nix1_lf && val.vu16 > max_nix1_lf) {
+	if (max_nix1_lf && val->vu16 > max_nix1_lf) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "requested nixlf is greater than the max supported nix1_lf");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index a72694219df4..4a5ce0e67dda 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -8,7 +8,7 @@
 
 /* Devlink Params APIs */
 static int otx2_dl_mcam_count_validate(struct devlink *devlink, u32 id,
-				       union devlink_param_value val,
+				       union devlink_param_value *val,
 				       struct netlink_ext_ack *extack)
 {
 	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
@@ -97,7 +97,7 @@ static int otx2_dl_ucast_flt_cnt_get(struct devlink *devlink, u32 id,
 }
 
 static int otx2_dl_ucast_flt_cnt_validate(struct devlink *devlink, u32 id,
-					  union devlink_param_value val,
+					  union devlink_param_value *val,
 					  struct netlink_ext_ack *extack)
 {
 	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 4fe6dbf0942f..c851daa5da9f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -213,10 +213,10 @@ static int mlx4_devlink_crdump_snapshot_set(struct devlink *devlink, u32 id,
 
 static int
 mlx4_devlink_max_macs_validate(struct devlink *devlink, u32 id,
-			       union devlink_param_value val,
+			       union devlink_param_value *val,
 			       struct netlink_ext_ack *extack)
 {
-	u32 value = val.vu32;
+	u32 value = val->vu32;
 
 	if (value < 1 || value > 128)
 		return -ERANGE;
@@ -266,27 +266,27 @@ static void mlx4_devlink_set_params_init_values(struct devlink *devlink)
 	value.vbool = !!mlx4_internal_err_reset;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_INT_ERR_RESET,
-					value);
+					&value);
 
 	value.vu32 = 1UL << log_num_mac;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_MAX_MACS,
-					value);
+					&value);
 
 	value.vbool = enable_64b_cqe_eqe;
 	devl_param_driverinit_value_set(devlink,
 					MLX4_DEVLINK_PARAM_ID_ENABLE_64B_CQE_EQE,
-					value);
+					&value);
 
 	value.vbool = enable_4k_uar;
 	devl_param_driverinit_value_set(devlink,
 					MLX4_DEVLINK_PARAM_ID_ENABLE_4K_UAR,
-					value);
+					&value);
 
 	value.vbool = false;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_REGION_SNAPSHOT,
-					value);
+					&value);
 }
 
 static inline void mlx4_set_num_reserved_uars(struct mlx4_dev *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 73cf0321bb86..c31e05529fc4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -459,11 +459,11 @@ void mlx5_devlink_free(struct devlink *devlink)
 }
 
 static int mlx5_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
-					     union devlink_param_value val,
+					     union devlink_param_value *val,
 					     struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
-	bool new_state = val.vbool;
+	bool new_state = val->vbool;
 
 	if (new_state && !MLX5_CAP_GEN(dev, roce) &&
 	    !(MLX5_CAP_GEN(dev, roce_rw_supported) && MLX5_CAP_GEN_MAX(dev, roce))) {
@@ -480,10 +480,10 @@ static int mlx5_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
 
 #ifdef CONFIG_MLX5_ESWITCH
 static int mlx5_devlink_large_group_num_validate(struct devlink *devlink, u32 id,
-						 union devlink_param_value val,
+						 union devlink_param_value *val,
 						 struct netlink_ext_ack *extack)
 {
-	int group_num = val.vu32;
+	int group_num = val->vu32;
 
 	if (group_num < 1 || group_num > 1024) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -496,27 +496,27 @@ static int mlx5_devlink_large_group_num_validate(struct devlink *devlink, u32 id
 #endif
 
 static int mlx5_devlink_eq_depth_validate(struct devlink *devlink, u32 id,
-					  union devlink_param_value val,
+					  union devlink_param_value *val,
 					  struct netlink_ext_ack *extack)
 {
-	return (val.vu32 >= 64 && val.vu32 <= 4096) ? 0 : -EINVAL;
+	return (val->vu32 >= 64 && val->vu32 <= 4096) ? 0 : -EINVAL;
 }
 
 static int
 mlx5_devlink_hairpin_num_queues_validate(struct devlink *devlink, u32 id,
-					 union devlink_param_value val,
+					 union devlink_param_value *val,
 					 struct netlink_ext_ack *extack)
 {
-	return val.vu32 ? 0 : -EINVAL;
+	return val->vu32 ? 0 : -EINVAL;
 }
 
 static int
 mlx5_devlink_hairpin_queue_size_validate(struct devlink *devlink, u32 id,
-					 union devlink_param_value val,
+					 union devlink_param_value *val,
 					 struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
-	u32 val32 = val.vu32;
+	u32 val32 = val->vu32;
 
 	if (!is_power_of_2(val32)) {
 		NL_SET_ERR_MSG_MOD(extack, "Value is not power of two");
@@ -534,11 +534,11 @@ mlx5_devlink_hairpin_queue_size_validate(struct devlink *devlink, u32 id,
 }
 
 static int mlx5_devlink_num_doorbells_validate(struct devlink *devlink, u32 id,
-					       union devlink_param_value val,
+					       union devlink_param_value *val,
 					       struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *mdev = devlink_priv(devlink);
-	u32 val32 = val.vu32;
+	u32 val32 = val->vu32;
 	u32 max_num_channels;
 
 	max_num_channels = mlx5e_get_max_num_channels(mdev);
@@ -567,13 +567,13 @@ static void mlx5_devlink_hairpin_params_init_values(struct devlink *devlink)
 
 	value.vu32 = link_speed64;
 	devl_param_driverinit_value_set(
-		devlink, MLX5_DEVLINK_PARAM_ID_HAIRPIN_NUM_QUEUES, value);
+		devlink, MLX5_DEVLINK_PARAM_ID_HAIRPIN_NUM_QUEUES, &value);
 
 	value.vu32 =
 		BIT(min_t(u32, 16 - MLX5_MPWRQ_MIN_LOG_STRIDE_SZ(dev),
 			  MLX5_CAP_GEN(dev, log_max_hairpin_num_packets)));
 	devl_param_driverinit_value_set(
-		devlink, MLX5_DEVLINK_PARAM_ID_HAIRPIN_QUEUE_SIZE, value);
+		devlink, MLX5_DEVLINK_PARAM_ID_HAIRPIN_QUEUE_SIZE, &value);
 }
 
 static const struct devlink_param mlx5_devlink_params[] = {
@@ -600,24 +600,24 @@ static void mlx5_devlink_set_params_init_values(struct devlink *devlink)
 	value.vbool = MLX5_CAP_GEN(dev, roce) && !mlx5_dev_is_lightweight(dev);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_ROCE,
-					value);
+					&value);
 
 #ifdef CONFIG_MLX5_ESWITCH
 	value.vu32 = ESW_OFFLOADS_DEFAULT_NUM_GROUPS;
 	devl_param_driverinit_value_set(devlink,
 					MLX5_DEVLINK_PARAM_ID_ESW_LARGE_GROUP_NUM,
-					value);
+					&value);
 #endif
 
 	value.vu32 = MLX5_COMP_EQ_SIZE;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
-					value);
+					&value);
 
 	value.vu32 = MLX5_NUM_ASYNC_EQE;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
-					value);
+					&value);
 }
 
 static const struct devlink_param mlx5_devlink_eth_params[] = {
@@ -653,14 +653,14 @@ static int mlx5_devlink_eth_params_register(struct devlink *devlink)
 	value.vbool = !mlx5_dev_is_lightweight(dev);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_ETH,
-					value);
+					&value);
 
 	mlx5_devlink_hairpin_params_init_values(devlink);
 
 	value.vu32 = MLX5_DEFAULT_NUM_DOORBELLS;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
-					value);
+					&value);
 	return 0;
 }
 
@@ -681,12 +681,12 @@ static void mlx5_devlink_eth_params_unregister(struct devlink *devlink)
 
 static int
 mlx5_devlink_pcie_cong_thresh_validate(struct devlink *devl, u32 id,
-				       union devlink_param_value val,
+				       union devlink_param_value *val,
 				       struct netlink_ext_ack *extack)
 {
-	if (val.vu16 > MLX5_PCIE_CONG_THRESH_MAX) {
+	if (val->vu16 > MLX5_PCIE_CONG_THRESH_MAX) {
 		NL_SET_ERR_MSG_FMT_MOD(extack, "Value %u > max supported (%u)",
-				       val.vu16, MLX5_PCIE_CONG_THRESH_MAX);
+				       val->vu16, MLX5_PCIE_CONG_THRESH_MAX);
 
 		return -EINVAL;
 	}
@@ -711,19 +711,19 @@ static void mlx5_devlink_pcie_cong_init_values(struct devlink *devlink)
 
 	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_LOW;
 	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW;
-	devl_param_driverinit_value_set(devlink, id, value);
+	devl_param_driverinit_value_set(devlink, id, &value);
 
 	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_HIGH;
 	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH;
-	devl_param_driverinit_value_set(devlink, id, value);
+	devl_param_driverinit_value_set(devlink, id, &value);
 
 	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_LOW;
 	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW;
-	devl_param_driverinit_value_set(devlink, id, value);
+	devl_param_driverinit_value_set(devlink, id, &value);
 
 	value.vu16 = MLX5_PCIE_CONG_THRESH_DEF_HIGH;
 	id = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH;
-	devl_param_driverinit_value_set(devlink, id, value);
+	devl_param_driverinit_value_set(devlink, id, &value);
 }
 
 static const struct devlink_param mlx5_devlink_pcie_cong_params[] = {
@@ -775,11 +775,11 @@ static void mlx5_devlink_pcie_cong_params_unregister(struct devlink *devlink)
 }
 
 static int mlx5_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
-					     union devlink_param_value val,
+					     union devlink_param_value *val,
 					     struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
-	bool new_state = val.vbool;
+	bool new_state = val->vbool;
 
 	if (new_state && !mlx5_rdma_supported(dev))
 		return -EOPNOTSUPP;
@@ -808,7 +808,7 @@ static int mlx5_devlink_rdma_params_register(struct devlink *devlink)
 	value.vbool = !mlx5_dev_is_lightweight(dev);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
-					value);
+					&value);
 	return 0;
 }
 
@@ -843,7 +843,7 @@ static int mlx5_devlink_vnet_params_register(struct devlink *devlink)
 	value.vbool = !mlx5_dev_is_lightweight(dev);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_ENABLE_VNET,
-					value);
+					&value);
 	return 0;
 }
 
@@ -890,22 +890,22 @@ static void mlx5_devlink_auxdev_params_unregister(struct devlink *devlink)
 }
 
 static int mlx5_devlink_max_uc_list_validate(struct devlink *devlink, u32 id,
-					     union devlink_param_value val,
+					     union devlink_param_value *val,
 					     struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
-	if (val.vu32 == 0) {
+	if (val->vu32 == 0) {
 		NL_SET_ERR_MSG_MOD(extack, "max_macs value must be greater than 0");
 		return -EINVAL;
 	}
 
-	if (!is_power_of_2(val.vu32)) {
+	if (!is_power_of_2(val->vu32)) {
 		NL_SET_ERR_MSG_MOD(extack, "Only power of 2 values are supported for max_macs");
 		return -EINVAL;
 	}
 
-	if (ilog2(val.vu32) >
+	if (ilog2(val->vu32) >
 	    MLX5_CAP_GEN_MAX(dev, log_max_current_uc_list)) {
 		NL_SET_ERR_MSG_MOD(extack, "max_macs value is out of the supported range");
 		return -EINVAL;
@@ -936,7 +936,7 @@ static int mlx5_devlink_max_uc_list_params_register(struct devlink *devlink)
 	value.vu32 = 1 << MLX5_CAP_GEN(dev, log_max_current_uc_list);
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_MAX_MACS,
-					value);
+					&value);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d95af87a4f5f..21f752531b71 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2728,7 +2728,7 @@ static int esw_port_metadata_get(struct devlink *devlink, u32 id,
 }
 
 static int esw_port_metadata_validate(struct devlink *devlink, u32 id,
-				      union devlink_param_value val,
+				      union devlink_param_value *val,
 				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 61a6ba1e49dd..c8f6adae6f51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3765,11 +3765,11 @@ static int init_egress_root_ns(struct mlx5_flow_steering *steering)
 }
 
 static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
-				 union devlink_param_value val,
+				 union devlink_param_value *val,
 				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
-	char *value = val.vstr;
+	char *value = val->vstr;
 	u8 eswitch_mode;
 
 	eswitch_mode = mlx5_eswitch_mode(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 19bb620b7436..4a7275e8b62e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -270,13 +270,13 @@ mlx5_nv_param_devlink_cqe_compress_get(struct devlink *devlink, u32 id,
 
 static int
 mlx5_nv_param_devlink_cqe_compress_validate(struct devlink *devlink, u32 id,
-					    union devlink_param_value val,
+					    union devlink_param_value *val,
 					    struct netlink_ext_ack *extack)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(cqe_compress_str); i++) {
-		if (!strcmp(val.vstr, cqe_compress_str[i]))
+		if (!strcmp(val->vstr, cqe_compress_str[i]))
 			return 0;
 	}
 
@@ -374,7 +374,7 @@ mlx5_devlink_swp_l4_csum_mode_get(struct devlink *devlink, u32 id,
 
 static int
 mlx5_devlink_swp_l4_csum_mode_validate(struct devlink *devlink, u32 id,
-				       union devlink_param_value val,
+				       union devlink_param_value *val,
 				       struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
@@ -383,7 +383,7 @@ mlx5_devlink_swp_l4_csum_mode_validate(struct devlink *devlink, u32 id,
 	int err, i;
 
 	for (i = 0; i < ARRAY_SIZE(swp_l4_csum_mode_str); i++) {
-		if (!strcmp(val.vstr, swp_l4_csum_mode_str[i]))
+		if (!strcmp(val->vstr, swp_l4_csum_mode_str[i]))
 			break;
 	}
 
@@ -727,7 +727,7 @@ static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
 }
 
 static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
-					   union devlink_param_value val,
+					   union devlink_param_value *val,
 					   struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
@@ -746,7 +746,7 @@ static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
 		return 0; /* optimistic, but set might fail later */
 
 	max = MLX5_GET(nv_global_pci_cap, data, max_vfs_per_pf);
-	if (val.vu16 > max) {
+	if (val->vu16 > max) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
 				       "Max allowed by device is %u", max);
 		return -EINVAL;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index d76246301f67..308d8a94865f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1306,11 +1306,11 @@ static int mlxsw_core_fw_flash_update(struct mlxsw_core *mlxsw_core,
 }
 
 static int mlxsw_core_devlink_param_fw_load_policy_validate(struct devlink *devlink, u32 id,
-							    union devlink_param_value val,
+							    union devlink_param_value *val,
 							    struct netlink_ext_ack *extack)
 {
-	if (val.vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_DRIVER &&
-	    val.vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_FLASH) {
+	if (val->vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_DRIVER &&
+	    val->vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_FLASH) {
 		NL_SET_ERR_MSG_MOD(extack, "'fw_load_policy' must be 'driver' or 'flash'");
 		return -EINVAL;
 	}
@@ -1337,7 +1337,7 @@ static int mlxsw_core_fw_params_register(struct mlxsw_core *mlxsw_core)
 	value.vu8 = DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_DRIVER;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_FW_LOAD_POLICY,
-					value);
+					&value);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/devlink_param.c b/drivers/net/ethernet/netronome/nfp/devlink_param.c
index 85e3b19e6165..826527992e4a 100644
--- a/drivers/net/ethernet/netronome/nfp/devlink_param.c
+++ b/drivers/net/ethernet/netronome/nfp/devlink_param.c
@@ -170,7 +170,7 @@ nfp_devlink_param_u8_set(struct devlink *devlink, u32 id,
 
 static int
 nfp_devlink_param_u8_validate(struct devlink *devlink, u32 id,
-			      union devlink_param_value val,
+			      union devlink_param_value *val,
 			      struct netlink_ext_ack *extack)
 {
 	const struct nfp_devlink_param_u8_arg *arg;
@@ -180,12 +180,12 @@ nfp_devlink_param_u8_validate(struct devlink *devlink, u32 id,
 
 	arg = &nfp_devlink_u8_args[id];
 
-	if (val.vu8 > arg->max_dl_val) {
+	if (val->vu8 > arg->max_dl_val) {
 		NL_SET_ERR_MSG_MOD(extack, "parameter out of range");
 		return -EINVAL;
 	}
 
-	if (val.vu8 == arg->invalid_dl_val) {
+	if (val->vu8 == arg->invalid_dl_val) {
 		NL_SET_ERR_MSG_MOD(extack, "unknown/invalid value specified");
 		return -EINVAL;
 	}
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index f00fc2f9ebde..aed9ad5f1b43 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -597,11 +597,11 @@ static void nsim_devlink_set_params_init_values(struct nsim_dev *nsim_dev,
 	value.vu32 = nsim_dev->max_macs;
 	devl_param_driverinit_value_set(devlink,
 					DEVLINK_PARAM_GENERIC_ID_MAX_MACS,
-					value);
+					&value);
 	value.vbool = nsim_dev->test1;
 	devl_param_driverinit_value_set(devlink,
 					NSIM_DEVLINK_PARAM_ID_TEST1,
-					value);
+					&value);
 }
 
 static void nsim_devlink_param_load_driverinit_values(struct devlink *devlink)
diff --git a/include/net/devlink.h b/include/net/devlink.h
index bcd31de1f890..5f4083dc4345 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -501,7 +501,7 @@ struct devlink_param {
 		   struct devlink_param_gset_ctx *ctx,
 		   struct netlink_ext_ack *extack);
 	int (*validate)(struct devlink *devlink, u32 id,
-			union devlink_param_value val,
+			union devlink_param_value *val,
 			struct netlink_ext_ack *extack);
 	int (*get_default)(struct devlink *devlink, u32 id,
 			   struct devlink_param_gset_ctx *ctx,
@@ -1923,7 +1923,7 @@ void devlink_params_unregister(struct devlink *devlink,
 int devl_param_driverinit_value_get(struct devlink *devlink, u32 param_id,
 				    union devlink_param_value *val);
 void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
-				     union devlink_param_value init_val);
+				     union devlink_param_value *init_val);
 void devl_param_value_changed(struct devlink *devlink, u32 param_id);
 struct devlink_region *devl_region_create(struct devlink *devlink,
 					  const struct devlink_region_ops *ops,
diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..1a196d3a843d 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -216,28 +216,28 @@ static int devlink_param_reset_default(struct devlink *devlink,
 
 static int
 devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
-			   int nla_type, union devlink_param_value val,
+			   int nla_type, union devlink_param_value *val,
 			   bool flag_as_u8)
 {
 	switch (type) {
 	case DEVLINK_PARAM_TYPE_U8:
-		if (nla_put_u8(msg, nla_type, val.vu8))
+		if (nla_put_u8(msg, nla_type, val->vu8))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U16:
-		if (nla_put_u16(msg, nla_type, val.vu16))
+		if (nla_put_u16(msg, nla_type, val->vu16))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U32:
-		if (nla_put_u32(msg, nla_type, val.vu32))
+		if (nla_put_u32(msg, nla_type, val->vu32))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_U64:
-		if (devlink_nl_put_u64(msg, nla_type, val.vu64))
+		if (devlink_nl_put_u64(msg, nla_type, val->vu64))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_STRING:
-		if (nla_put_string(msg, nla_type, val.vstr))
+		if (nla_put_string(msg, nla_type, val->vstr))
 			return -EMSGSIZE;
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
@@ -245,10 +245,10 @@ devlink_nl_param_value_put(struct sk_buff *msg, enum devlink_param_type type,
 		 * false can be distinguished from not present
 		 */
 		if (flag_as_u8) {
-			if (nla_put_u8(msg, nla_type, val.vbool))
+			if (nla_put_u8(msg, nla_type, val->vbool))
 				return -EMSGSIZE;
 		} else {
-			if (val.vbool && nla_put_flag(msg, nla_type))
+			if (val->vbool && nla_put_flag(msg, nla_type))
 				return -EMSGSIZE;
 		}
 		break;
@@ -260,8 +260,8 @@ static int
 devlink_nl_param_value_fill_one(struct sk_buff *msg,
 				enum devlink_param_type type,
 				enum devlink_param_cmode cmode,
-				union devlink_param_value val,
-				union devlink_param_value default_val,
+				union devlink_param_value *val,
+				union devlink_param_value *default_val,
 				bool has_default)
 {
 	struct nlattr *param_value_attr;
@@ -383,8 +383,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 		if (!param_value_set[i])
 			continue;
 		err = devlink_nl_param_value_fill_one(msg, param->type,
-						      i, param_value[i],
-						      default_value[i],
+						      i, &param_value[i],
+						      &default_value[i],
 						      default_value_set[i]);
 		if (err)
 			goto values_list_nest_cancel;
@@ -621,7 +621,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 		if (err)
 			return err;
 		if (param->validate) {
-			err = param->validate(devlink, param->id, value,
+			err = param->validate(devlink, param->id, &value,
 					      info->extack);
 			if (err)
 				return err;
@@ -888,7 +888,7 @@ EXPORT_SYMBOL_GPL(devl_param_driverinit_value_get);
  *	configuration mode default value.
  */
 void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
-				     union devlink_param_value init_val)
+				     union devlink_param_value *init_val)
 {
 	struct devlink_param_item *param_item;
 
@@ -902,9 +902,9 @@ void devl_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
 						      DEVLINK_PARAM_CMODE_DRIVERINIT)))
 		return;
 
-	param_item->driverinit_value = init_val;
+	param_item->driverinit_value = *init_val;
 	param_item->driverinit_value_valid = true;
-	param_item->driverinit_default = init_val;
+	param_item->driverinit_default = *init_val;
 
 	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
 }
-- 
2.43.0


