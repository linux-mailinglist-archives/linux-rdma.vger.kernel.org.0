Return-Path: <linux-rdma+bounces-7658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF91A319D9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 00:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529811687F5
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4626B962;
	Tue, 11 Feb 2025 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sArK4E0h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0326B95A;
	Tue, 11 Feb 2025 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317760; cv=fail; b=FW6JqDASrBGlINYfvFa76Rw0zwUqvsWzEN9SEcAWoZWwiO6vM7LGJ0y1K/HM11mjJ7AogQh0xl8N8N5XqUlPYonmCM8L9oN/jKGylR5+ljNJGMrTJ0gAMASyBzjQNohdLZrOIru8VfF1MT+mmlL+znITio+IJ6KLQqY5a9+riAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317760; c=relaxed/simple;
	bh=S8exCzioc7cpuO5g71UwG4sHifhiRTTCcvPAnhwZLFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOYQZeCIz51QzLGMwpeNbXdm2vETWIqX4anje5fFmn9KrSzr+VCM1+wBpqXyQbIhZdJi/p+BSa/mqL7npWnRheCOM2Ozkw2omwnvEZ6PYa+7csYvrazJR/BNuc++Lt7HSgnCrewMoBiPoJo7X4EG0x0ZVqHxzTXzD9QffCq0Vp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sArK4E0h; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCguYg1HCbsFwjRUcP8Q1edS48Aroepa+XL96fGXFYUHk1pqS1ubi3db2CA19OC5u2czQckn0pS9WYf/y4jQyxkVlhxxtyVrQlWlcjCyq+2I5Ve70/z3HB4yRbePJIE7VIH5n1RCLsTJMqKrRk2nUdzYA0wQM6Ei9S90OQ07ighQTz49agZthRZKKwV5OsMXFL7ndG3IPgXiefQhRqqmuwjNR2P3eHtiVUApgw3wTFNd686hYkb1Ic6OQwzWN0WRGvLS3vbkQs2JeejCmasyBtQ86GaagbBWqInZM+j+iwLqR0rBLnPFK+aHXSRMEvlfF3WUW8W8ibmJSTc48xSbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2km61AXBXj/yWn0ImNA7+bAyPS3CEynSOmvh57uc68=;
 b=at95s5s4kuEbjSDNLaN3mjWR36e9coI+2sAD6vzGvCZKYLCvY8W2lU6+JR7yD4NRLmoSEpfBI1NHbjqzkugJ6mXBPTXVPij0E953fI9oGKvkoI/MnZXoU9EqzScn7mDe4gPYd8c3T26gPDZkJx+akVjeFcUkLAkUMWZq+oNak7htn4KlZFgosOM2Urx7FrviqBOIpugMtVUp7w1bU5TGqNu52Zo7v0rxuOGHEW+pV2aPmwpYBraXBLv/NcuznIAPHautcAGVh3fDTwxUTk1pSmuCV58m85aUWbTHZ1yYh+Vy/P8wq3s4ItvBDOAUNQ4w7Mvm+oBQqXGEMmr/vHkDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2km61AXBXj/yWn0ImNA7+bAyPS3CEynSOmvh57uc68=;
 b=sArK4E0hnjxhu3LJXjlr3wfT4gnRgGwCzu1m2s/yfqEIyEw9mYY7ByEXYkFGGNddgO5i8iuDy4OBaVayYUTNeNvmrOGMAs4FrQlmlx38wtJ66X9UPGc74x+THg8K5Zs+H1hnqJ0Ylfu+9Pbf846ujyzH/VrCanRpgsoy3KryEYs=
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 23:49:14 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::2b) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 23:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 23:49:13 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 17:49:11 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <saeedm@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [RFC PATCH fwctl 1/5] pds_core: specify auxiliary_device to be created
Date: Tue, 11 Feb 2025 15:48:50 -0800
Message-ID: <20250211234854.52277-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211234854.52277-1-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: ba941b81-a796-4233-0560-08dd4af6b07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sr8xKW6oUpIV6rson+NkCfT/Mvm8tOJnvG9WAPlQ1c6FiyUDmw1bp9/ERBxv?=
 =?us-ascii?Q?ApDkTS/XqnG6YNudEDnBORhvnDrDlubpcqcb0IqsRmxJrYyK8+TjxsQtZiso?=
 =?us-ascii?Q?c+rw/Kw2J6FtQkBBq6rwRvDulcNX5Wx6Ft/eZWrwktgNWfOUmor6yFzq8/fQ?=
 =?us-ascii?Q?FJuoJsjk9JcS02ATnz1tP+fWuFyTI6qiyJL5mUwMXicFLlQlbnZXW9qmmaN2?=
 =?us-ascii?Q?vCLvZjn7XVYcIatLl8sRgZopWKH8sLeDX0KrELXuBEQY4cw4gaxCrBRZ7tZX?=
 =?us-ascii?Q?1G9JK+kesjGzqmHFp1L1cw/3Q6gWVKj9gC8GUsgg197iQMS0o0RxfxWu2CrW?=
 =?us-ascii?Q?t2HLroROgwdPKd2W97MfYa8lD0wMR/2hWnxUpIM0utZaUG3gs107Ewk+qpP1?=
 =?us-ascii?Q?Wu2nYWQKyy2Le2vMG4B4m2WplTiO0dXVRVaPDW+lDolaelVJkP4d3kSlb5SB?=
 =?us-ascii?Q?d0kzqTxUkwU19xUp+RKEsXI5J5bZ2yGgFQX/o2w+ANLCtLxCAyCKRClwuToH?=
 =?us-ascii?Q?v3KR8mWQLt2C/ZJq5tF+joi6Ck2uR0dI6QgrPVsX0t1JdfIAPXuv7bsujtMV?=
 =?us-ascii?Q?+NHLmkEaL3Cc+Ehv6k1BqU9TRdASylLPLCSZ2tA0li6ZPzkJGXSToZ43qQyY?=
 =?us-ascii?Q?DIb9s+IfftrdSaAscVT+f6T85OjFkdBtWxSF+UMfTc1Ugbh4rTgr7w1KhvFJ?=
 =?us-ascii?Q?pqoRjBtK16CWCpwIhjN4+DkpcLuM85rNaCLIbOuBiupb/2K2i/R1wPto4ZjS?=
 =?us-ascii?Q?ENgCmBMJTgdR0TXLRn1Dms7lUdELK1o2Wv9Tq7SOBm7SYoglqi5gtSKH569j?=
 =?us-ascii?Q?UIF60b166lOVFgBMeREWml8tcANRGkz4+42PoEBVUIiXUDCvElvrxuErHm08?=
 =?us-ascii?Q?TyFl/UxWTOEDea1jjl5fnr2/2/5pIVbK6y8GV2B0FoFb0UYtpVm9gJR/JQrW?=
 =?us-ascii?Q?bOV/SHi0n46OI4cv275/2mohh/o1aGfQpMcb3TCLY9cetHcYnzj2+/9qYBKn?=
 =?us-ascii?Q?GjHqlW9haCT7irUYZAG2YU/y5q4fzeI5apZAHeUvuhHeR+XeGtBlvtq/bEeo?=
 =?us-ascii?Q?DGgma5rIu8ykBEtbcj/FKXuhxSxgpg/JJi2dNLNxK7lbnMJ6wTMkGYxcICrH?=
 =?us-ascii?Q?X0pKDr3XgV7tXWvaqGP6q7tttTUl5WvNYvwilJ1kvyA5dQkfpCtfzlqpn0og?=
 =?us-ascii?Q?QLPqwFM7azLEgBxTr0quXYbM9ZrRt1pe1vipB+PUAxGTeNylbI4/ABMV8f/j?=
 =?us-ascii?Q?NBDs3sxmRiCusderW1mJ4SvJrBdv/nWWJFjtVtLkkTx6Pio7Qmw6tzyURbcu?=
 =?us-ascii?Q?oSQvgrcUhIyKl+XP5ZYnRxIeKw/cYwCkBXZuAFaWwQIRudBJsRufvLlj3mK6?=
 =?us-ascii?Q?FopsJgOlpSHvQOUrJJ020kxMYLPGIQgoaO8Huk1pliKFJKk216rbwk08HYjb?=
 =?us-ascii?Q?/VzGk8yniuG8tuNQ+8b6+QzHR0VZiUfj5zFgqkVs9FQyV0NXp4ohSshSQfcW?=
 =?us-ascii?Q?W1OJ1koWqZFAMHI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:49:13.8022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba941b81-a796-4233-0560-08dd4af6b07b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

In preparation for adding a new auxiliary_device for the
PF, make the vif type an argument to pdsc_auxbus_dev_add().
We also now pass in the address to where we'll keep the new
padev pointer so that the caller can specify where to save it
but we can still change it under the mutex and keep the mutex
usage within the function.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c  | 41 ++++++++++-----------
 drivers/net/ethernet/amd/pds_core/core.h    |  7 +++-
 drivers/net/ethernet/amd/pds_core/devlink.c |  6 ++-
 drivers/net/ethernet/amd/pds_core/main.c    | 11 ++++--
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 2babea110991..0a3035adda52 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -175,34 +175,37 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	return padev;
 }
 
-int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
+int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
+			struct pds_auxiliary_dev **pd_ptr)
 {
 	struct pds_auxiliary_dev *padev;
-	int err = 0;
 
 	if (!cf)
 		return -ENODEV;
 
+	if (!*pd_ptr)
+		return 0;
+
 	mutex_lock(&pf->config_lock);
 
-	padev = pf->vfs[cf->vf_id].padev;
-	if (padev) {
-		pds_client_unregister(pf, padev->client_id);
-		auxiliary_device_delete(&padev->aux_dev);
-		auxiliary_device_uninit(&padev->aux_dev);
-		padev->client_id = 0;
-	}
-	pf->vfs[cf->vf_id].padev = NULL;
+	padev = *pd_ptr;
+	pds_client_unregister(pf, padev->client_id);
+	auxiliary_device_delete(&padev->aux_dev);
+	auxiliary_device_uninit(&padev->aux_dev);
+	padev->client_id = 0;
+	*pd_ptr = NULL;
 
 	mutex_unlock(&pf->config_lock);
-	return err;
+
+	return 0;
 }
 
-int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
+int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
+			enum pds_core_vif_types vt,
+			struct pds_auxiliary_dev **pd_ptr)
 {
 	struct pds_auxiliary_dev *padev;
 	char devname[PDS_DEVNAME_LEN];
-	enum pds_core_vif_types vt;
 	unsigned long mask;
 	u16 vt_support;
 	int client_id;
@@ -211,6 +214,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 	if (!cf)
 		return -ENODEV;
 
+	if (vt >= PDS_DEV_TYPE_MAX)
+		return -EINVAL;
+
 	mutex_lock(&pf->config_lock);
 
 	mask = BIT_ULL(PDSC_S_FW_DEAD) |
@@ -222,17 +228,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 		goto out_unlock;
 	}
 
-	/* We only support vDPA so far, so it is the only one to
-	 * be verified that it is available in the Core device and
-	 * enabled in the devlink param.  In the future this might
-	 * become a loop for several VIF types.
-	 */
-
 	/* Verify that the type is supported and enabled.  It is not
 	 * an error if there is no auxbus device support for this
 	 * VF, it just means something else needs to happen with it.
 	 */
-	vt = PDS_DEV_TYPE_VDPA;
 	vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
 	if (!(vt_support &&
 	      pf->viftype_status[vt].supported &&
@@ -258,7 +257,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 		err = PTR_ERR(padev);
 		goto out_unlock;
 	}
-	pf->vfs[cf->vf_id].padev = padev;
+	*pd_ptr = padev;
 
 out_unlock:
 	mutex_unlock(&pf->config_lock);
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 14522d6d5f86..065031dd5af6 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -303,8 +303,11 @@ void pdsc_health_thread(struct work_struct *work);
 int pdsc_register_notify(struct notifier_block *nb);
 void pdsc_unregister_notify(struct notifier_block *nb);
 void pdsc_notify(unsigned long event, void *data);
-int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
-int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
+int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
+			enum pds_core_vif_types vt,
+			struct pds_auxiliary_dev **pd_ptr);
+int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
+			struct pds_auxiliary_dev **pd_ptr);
 
 void pdsc_process_adminq(struct pdsc_qcq *qcq);
 void pdsc_work_thread(struct work_struct *work);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 44971e71991f..c2f380f18f21 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -56,8 +56,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
 	for (vf_id = 0; vf_id < pdsc->num_vfs; vf_id++) {
 		struct pdsc *vf = pdsc->vfs[vf_id].vf;
 
-		err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc) :
-				       pdsc_auxbus_dev_del(vf, pdsc);
+		err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc, vt_entry->vif_id,
+							   &pdsc->vfs[vf_id].padev) :
+				       pdsc_auxbus_dev_del(vf, pdsc,
+						           &pdsc->vfs[vf_id].padev);
 	}
 
 	return err;
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 660268ff9562..a3a68889137b 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -190,7 +190,8 @@ static int pdsc_init_vf(struct pdsc *vf)
 	devl_unlock(dl);
 
 	pf->vfs[vf->vf_id].vf = vf;
-	err = pdsc_auxbus_dev_add(vf, pf);
+	err = pdsc_auxbus_dev_add(vf, pf, PDS_DEV_TYPE_VDPA,
+				  &pf->vfs[vf->vf_id].padev);
 	if (err) {
 		devl_lock(dl);
 		devl_unregister(dl);
@@ -417,7 +418,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf)) {
-			pdsc_auxbus_dev_del(pdsc, pf);
+			pdsc_auxbus_dev_del(pdsc, pf, &pf->vfs[pdsc->vf_id].padev);
 			pf->vfs[pdsc->vf_id].vf = NULL;
 		}
 	} else {
@@ -482,7 +483,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf))
-			pdsc_auxbus_dev_del(pdsc, pf);
+			pdsc_auxbus_dev_del(pdsc, pf,
+					    &pf->vfs[pdsc->vf_id].padev);
 	}
 
 	pdsc_unmap_bars(pdsc);
@@ -527,7 +529,8 @@ static void pdsc_reset_done(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf))
-			pdsc_auxbus_dev_add(pdsc, pf);
+			pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
+					    &pf->vfs[pdsc->vf_id].padev);
 	}
 }
 
-- 
2.17.1


