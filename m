Return-Path: <linux-rdma+bounces-4473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B895A484
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B214B21305
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B61B5316;
	Wed, 21 Aug 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yev/ma9Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299241B530C;
	Wed, 21 Aug 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263883; cv=fail; b=ppq0RTyuR+8D2l06623joGcuNDZXY180bnMRZxf/8AnSq5vV6VOGSlIqlkuakgWEVs+/N4XbuDfM0/2higfLoodNtXm3GfOkJGRnvd6WOwwyvJnOQVVRPGemQv7wBZE03lB0z1VhDBAQ1HFrEpSZmr3y6RmpDndD7swsFtfsJfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263883; c=relaxed/simple;
	bh=QyiUVwjJAnL6Q7xr01o1e0IPrQXuUv/I0ubyuoQUkFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wjh5s8Rm+xDsXkAfOaT8qICzBeeJDxeFk/DWx+SpjoiRo7PGRcMZhD/lyijHdYFuWXmJZuQrYWW5Nxf4Uizxef7lew3MNgY9G4HFlN0tN7GONo6CyaTkTAYqHcKEFnVnJSH3NPx7l2QIkV9iN1HjlOOWrn8xS5nN9B0LMuz9+rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yev/ma9Z; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOAz2bQ7jwysK12loXn7bC5Bu+a8KIfVodPfn6kJqYS71NqTD/ulYzV4R+0w4vgMHnwNOVB704iWgD7A5DX67NQwBva/SwTH4kwvTu6WysTkhAsGzEpZoBu0vO8fZ7osNlhpFk84zDc4nC556kM7HI5cBloS1OV6VxrH9OLihsPO/IObtup/OhDonjzTdSweyte3wzdCtpsAyeDR2zWSAXQ6b9GKV5l4Dw5TXM6uBVn2VHuezgjrhW/MCVAZidBoYjn5Jxerx1Uola6aMJfTKiSbGzoZknzmKwsll63Ft2Wb7Hm0a7NqgvClDNfRx93Qlmo9uWiC4KYMzxuwDAHa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccu1BePe4n7FR5e0XtDFHuAqyUiEnRDk1VnpHCSlUlY=;
 b=QPVYm8H1vcj4nxwl7gTGohHqXqWa1VzBDSl6YJAi6BrgNmfslp0pJRZEkR1f0I+QKQRb26IInZAbFYpzxFMPUO44LM1IZdwgCllE/qF28AL0g3Ajq1f9kqQyZ+yIJXyDSjPV+2+uht2PTfPPh6vhm+ZhoUN+zEyWY4panQ7Kc4296+alYniLWRP3qw4h51EV7vNCyT4imzSKYFAil3Axicz9OK9Tc2tWr9+X8UM9ewLCQiyNHrfAGkC64QZRu3h5k8uZizpBVcTLnKb3pAeczEF5uhdcD+RNpYZI1HpgyB14KN/gd5aGgh2HN23uw0RLQZIlCKtsxJzaH5SOHrpH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccu1BePe4n7FR5e0XtDFHuAqyUiEnRDk1VnpHCSlUlY=;
 b=Yev/ma9ZnKHjO10vJ/LbwFfoiegoMuTE4Qh/IDSh0FmLPp6MsAVFcZ3prwf70D7d9+uQWX34qBUyNbWYLB6BhvA9Ah6SZD85iDFjFAVclu+aLfMRnnXbYr4iLqIbNHPD3Ni88FlrA3B8STdpNyFJayTNuSmIEBrFwtgRgkhFrB/Ct350Ktm/7yYnHYT+/uQCAQURMK5Pl5qxuKqTsoqiLo2j7AbeObXYgmgRyAJEcuvlwedOUZQAM1Qvv06Y3WnQ5Kyc+LrhlNBgNGNzncqGI6r9aE7KGw+R4zGhBauVwzBnHq9AWGUoaa4lWGojZdDuEgVkTfgONMAQpz/MXxdEsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:09 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH v3 05/10] fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
Date: Wed, 21 Aug 2024 15:10:57 -0300
Message-ID: <5-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:408:fb::14) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: b831aaf7-b8b9-4ab9-04be-08dcc20c9f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVLYkACETtAmLGokE9a5PMZ9dsfAsgQRqtKDBbJy2vDpJ9lqDjzTT/MTMUZm?=
 =?us-ascii?Q?vcEalFLvwRGnJOko+8q8zrvWAlUqJaNgqe9Uoa3xhwQRF3gKAG98fIG5TkNF?=
 =?us-ascii?Q?RJez7V9JXymMY4rils3A3860LKnvOdpltj1PL0GOUI4ItTypOKaNMtSa0MlE?=
 =?us-ascii?Q?9ongEqU8u18bYtzmvoKUIEw0PGAVXy4MEF2A1YhEFUEjPmISz2hrgPth6XWk?=
 =?us-ascii?Q?vDwa5+lrT8wnjip1Mh3bfnGTsi8VnsnjD0C8SLrNr/Ijjiageq71OhzFCmxs?=
 =?us-ascii?Q?G0Uj+l+6TuneplWzKMIqAuuUqWOUGWo5/B7BsPsp4WZGiY54m9fukOncgVrN?=
 =?us-ascii?Q?AaaS8mpS95zuljHUXfQPsYJcCqrfKefmKkg1qQu133dByJAxmI6h763aeYUS?=
 =?us-ascii?Q?Vj4MFKtuCubDKXbFhGDtwXXlJ3suVXL9Rkf2TuEF5hHPSrmb5xobRCNuFNbO?=
 =?us-ascii?Q?eL8oPN4cIhd8PnyIAc3nuC9sYs6HyREBYmkefo0lrgao0VzDpM3JfLsgbLAW?=
 =?us-ascii?Q?JN+FHlvaYFjCdFLnPuzkRmDf/P8QPaRG+213NgUiZ/hZklKAP7o6dz2mA5+k?=
 =?us-ascii?Q?pXi8mck11GFQ4xyhePZDegrW/tCWQHSIXFWmlw+cAErDjFYLlGwuJN+p6ON2?=
 =?us-ascii?Q?RwnmtxWrj4m1YxY1XdeQQwMOqxyS1VWpn8FueY4w27dP5LhHXdZNg6L0xBkn?=
 =?us-ascii?Q?io4Et2GNqUDrCtrfHhBfwbOAYCzS+bPCfmgacbBRFdsC+5LLYpN0m9i+2bGm?=
 =?us-ascii?Q?vCWW/kIM+NncaqajFMMribMDyAYgwD6gLIGmMjqZKOXcUE/aiBmQZYbgm8YX?=
 =?us-ascii?Q?l/rtvy8E9cSG1mIIVVjaZyER+4vk9MAP5QbW9g+p6ArKib9/sktve4xK0j5b?=
 =?us-ascii?Q?t4/XH2cseXPfc3ChyTTpfjjUeI/1q1LkXnisB+MKNkkY30R//pyikxNE8PNk?=
 =?us-ascii?Q?wl2vZESVLI2FxjaJRd3vlPi8+h9NUfpPe2RlXp/n6LAo9oOkaXe2i/LyvmpI?=
 =?us-ascii?Q?Ic2FM5IykVBOr2pOlI0MZFbSL3h+ZR2AQWfxGyF/oo8uzjrJ08FWiyw6iBsZ?=
 =?us-ascii?Q?1y4cyZugfzZdNuZ+K7VYZySHZHFwqCgr1sy/QTt5Lg2F0hVL3PPw9GA3NZdA?=
 =?us-ascii?Q?m9fyk99+otaompD93QDEeWgxEd/nVeqk3v1d9s16rnE1tZQWK4jPmWgNMCXw?=
 =?us-ascii?Q?KG5fx228CPAGRj7ycft7K1Q21RYeSiaT/IRLIFG7PKxRRzR0APpP12N5s+LQ?=
 =?us-ascii?Q?nRdyZXMcKokkIFgbp8z4Vj/O0Ou34NdI1u6sQQaj0ic3YHymHCAXXKjUMudG?=
 =?us-ascii?Q?xLD9i7//0mkREwW4B9/ao5zSiP8ldTarI5i2T5oYgluysQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIA6sIS4/vXbLqDM889fbpa4B4wx5fX7BpJ3xW5JCtGjqbQwxn7SRVlaTimT?=
 =?us-ascii?Q?ig54it6ctCA/d94bvj2Egp9ltC1rBoZyX7Si+g7LVrvFlWe77dCbei7ePRrg?=
 =?us-ascii?Q?w8ekTiQa9TmQqeN37flGfdtwUiE5eQDf50WOOrnGU04F6nSAoSruBzPyI6fm?=
 =?us-ascii?Q?b4uoAnM9DUov+Rf1j7GwkXK7vm5nh8O7L2s5JYh1f+Z4r27tBCjyoayXuyY0?=
 =?us-ascii?Q?jH7d5S4SC+Ru78XQWhWhTr+dwlhwQp5aXNTYGv1GQmdGSSq1r5zkEv+pxNs3?=
 =?us-ascii?Q?AHP1R1+cd/sM5A8xfdBcxA93LuA/MlOJ3icBTXgNFtgD9KYS9/xwBwBu4le4?=
 =?us-ascii?Q?RRKlHkV4p9gUdA6Xjb5P4cnyGCJn6t74Tsx4joBQQf2mWFoitzdf9fTnj2pc?=
 =?us-ascii?Q?6eM9dWGI868R2PZ5bj5Kh3TKe6Maaou6ZxysrEcWRYaTSWqZ5k718dKcGOWl?=
 =?us-ascii?Q?I0Cxv/LLR1MCrkXn0W1q3Ug43T5NZZB8cy998JUL4gzLghsLbvPv2ro736e2?=
 =?us-ascii?Q?sny46kK2HugG96zCrGAxlO6In1y0Rpip1dINFTP9NFQUVGOYN+nWCXSJWae4?=
 =?us-ascii?Q?AbB3jGjfSSEupMRvk1sTLC5C6NdgmD3AaCkrf7ZsryL2jPZpNfNdngPJLNhL?=
 =?us-ascii?Q?yeo+bOYrmJKEM1RuK4qZjv9sAZABirGpOCUzJ1fHOngaTKd0W8FBIZ4JIqze?=
 =?us-ascii?Q?7jfg2LS+kRi7D5xJ4a2LBVIQqS4yDRnSi+OgT5YNithqtzIDjxn1Vc282ETx?=
 =?us-ascii?Q?VIZ7BEfUdjl7QIPMzJOGx/qHkHRC7QJsYgcuPaRtOw3heFI5gm1tLmZnFyxG?=
 =?us-ascii?Q?VdvBSCMMhk0llp/12fTPETYZj/zTN5kSGRdFB++4+u4VmJOtTxthgO2zJjGc?=
 =?us-ascii?Q?rCu9Eo4FPhq5u4Y0bZk6KHaCPoQTSaWNToGsDIEW29ftBIvjIL+yU75JAV0O?=
 =?us-ascii?Q?aSzIbmsRvkUItY7tFXnWCDtLEQzOIZR5KS4axRIxfr2AjtcZosaOX7uSR4j3?=
 =?us-ascii?Q?W7iws93A6T9nq6uCgLnR0iMPBXX5wldr1H50DvPCIdyDsKkibh7XtRumeCRq?=
 =?us-ascii?Q?ILPwFfMJUmZwofQGwZl1c2a/7hDF6+TOhu+yT96qPRIi6d7vKH/TkruKAPnA?=
 =?us-ascii?Q?zTB6h9V4Dyrq7uDQ0PCAMM87A6S8ittA19DD9riFfG3wxAxxgdsHvG05qKLU?=
 =?us-ascii?Q?G/Lk8xNmq3UkfOZZtEb8hP1DJIXR1sn8YkLcbeEjeeQ23XB4as50huxUF0dG?=
 =?us-ascii?Q?6kE92D2OiDp8zvb4YLmlYyag3CpEI5yyP3TG8/nYdEZm1V7oplqYtx2rY4i2?=
 =?us-ascii?Q?uu32QRLZqE+pp+w774vSKAQ0luGxpZHmMM26WAIoZlyE5UOa7B/yoIQz05WF?=
 =?us-ascii?Q?pfNjzkglwu7zo3TD85r+006Qpu5c2B4nsdpqTSX6TKIa5AtEXrCBAn7sddL/?=
 =?us-ascii?Q?yYsrvBeze67EQ+0AV7pimoDo19H2s+2B2GQT6izjFGIMYWhnqonzEHo6WeXD?=
 =?us-ascii?Q?DoHVWWxByYWa8z3PdIizPOzd5k2NBXKjTWkqubJRMHEBK18ZIaEDBwMEARpP?=
 =?us-ascii?Q?yUv2EJMiw79Z67VP0WSzV5CiZSuRRuwpKI+TkNpC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b831aaf7-b8b9-4ab9-04be-08dcc20c9f2d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:04.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAHQiuuSHZxQMDYB832QHgYG+F9/fxLS4mZO+e38i/Kez2h7yj4XCUOpnTyTonR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

Add the FWCTL_RPC ioctl which allows a request/response RPC call to device
firmware. Drivers implementing this call must follow the security
guidelines under Documentation/userspace-api/fwctl.rst

The core code provides some memory management helpers to get the messages
copied from and back to userspace. The driver is responsible for
allocating the output message memory and delivering the message to the
device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 60 +++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      |  8 +++++
 include/uapi/fwctl/fwctl.h | 68 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index b281ccc52b4e57..54a7356e586cda 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -8,15 +8,18 @@
 #include <linux/container_of.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include <uapi/fwctl/fwctl.h>
 
 enum {
 	FWCTL_MAX_DEVICES = 256,
+	MAX_RPC_LEN = SZ_2M,
 };
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
+static unsigned long fwctl_tainted;
 
 struct fwctl_ucmd {
 	struct fwctl_uctx *uctx;
@@ -74,9 +77,65 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
 	return ucmd_respond(ucmd, sizeof(*cmd));
 }
 
+static int fwctl_cmd_rpc(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_rpc *cmd = ucmd->cmd;
+	size_t out_len;
+
+	if (cmd->in_len > MAX_RPC_LEN || cmd->out_len > MAX_RPC_LEN)
+		return -EMSGSIZE;
+
+	switch (cmd->scope) {
+	case FWCTL_RPC_CONFIGURATION:
+	case FWCTL_RPC_DEBUG_READ_ONLY:
+		break;
+
+	case FWCTL_RPC_DEBUG_WRITE_FULL:
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
+		fallthrough;
+	case FWCTL_RPC_DEBUG_WRITE:
+		if (!test_and_set_bit(0, &fwctl_tainted)) {
+			dev_warn(
+				&fwctl->dev,
+				"%s(%d): has requested full access to the physical device device",
+				current->comm, task_pid_nr(current));
+			add_taint(TAINT_FWCTL, LOCKDEP_STILL_OK);
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	void *inbuf __free(kvfree) = kvzalloc(cmd->in_len, GFP_KERNEL_ACCOUNT);
+	if (!inbuf)
+		return -ENOMEM;
+	if (copy_from_user(inbuf, u64_to_user_ptr(cmd->in), cmd->in_len))
+		return -EFAULT;
+
+	out_len = cmd->out_len;
+	void *outbuf __free(kvfree) = fwctl->ops->fw_rpc(
+		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
+	if (IS_ERR(outbuf))
+		return PTR_ERR(outbuf);
+	if (outbuf == inbuf) {
+		/* The driver can re-use inbuf as outbuf */
+		inbuf = NULL;
+	}
+
+	if (copy_to_user(u64_to_user_ptr(cmd->out), outbuf,
+			 min(cmd->out_len, out_len)))
+		return -EFAULT;
+
+	cmd->out_len = out_len;
+	return ucmd_respond(ucmd, sizeof(*cmd));
+}
+
 /* On stack memory for the ioctl structs */
 union ucmd_buffer {
 	struct fwctl_info info;
+	struct fwctl_rpc rpc;
 };
 
 struct fwctl_ioctl_op {
@@ -97,6 +156,7 @@ struct fwctl_ioctl_op {
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
 	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
+	IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 6b596931a55169..6eac9497ff1afc 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -47,6 +47,14 @@ struct fwctl_ops {
 	 * ignore length on input, the core code will handle everything.
 	 */
 	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
+	/**
+	 * @fw_rpc: Implement FWCTL_RPC. Deliver rpc_in/in_len to the FW and
+	 * return the response and set out_len. rpc_in can be returned as the
+	 * response pointer. Otherwise the returned pointer is freed with
+	 * kvfree().
+	 */
+	void *(*fw_rpc)(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			void *rpc_in, size_t in_len, size_t *out_len);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 39db9f09f8068e..3af9f9eb9b1878 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -67,4 +67,72 @@ struct fwctl_info {
 };
 #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
 
+/**
+ * enum fwctl_rpc_scope - Scope of access for the RPC
+ *
+ * Refer to fwctl.rst for a more detailed discussion of these scopes.
+ */
+enum fwctl_rpc_scope {
+	/**
+	 * @FWCTL_RPC_CONFIGURATION: Device configuration access scope
+	 *
+	 * Read/write access to device configuration. When configuration
+	 * is written to the device it remains in a fully supported state.
+	 */
+	FWCTL_RPC_CONFIGURATION = 0,
+	/**
+	 * @FWCTL_RPC_DEBUG_READ_ONLY: Read only access to debug information
+	 *
+	 * Readable debug information. Debug information is compatible with
+	 * kernel lockdown, and does not disclose any sensitive information. For
+	 * instance exposing any encryption secrets from this information is
+	 * forbidden.
+	 */
+	FWCTL_RPC_DEBUG_READ_ONLY = 1,
+	/**
+	 * @FWCTL_RPC_DEBUG_WRITE: Writable access to lockdown compatible debug information
+	 *
+	 * Allows write access to data in the device which may leave a fully
+	 * supported state. This is intended to permit intensive and possibly
+	 * invasive debugging. This scope will taint the kernel.
+	 */
+	FWCTL_RPC_DEBUG_WRITE = 2,
+	/**
+	 * @FWCTL_RPC_DEBUG_WRITE_FULL: Write access to all debug information
+	 *
+	 * Allows read/write access to everything. Requires CAP_SYS_RAW_IO, so
+	 * it is not required to follow lockdown principals. If in doubt
+	 * debugging should be placed in this scope. This scope will taint the
+	 * kernel.
+	 */
+	FWCTL_RPC_DEBUG_WRITE_FULL = 3,
+};
+
+/**
+ * struct fwctl_rpc - ioctl(FWCTL_RPC)
+ * @size: sizeof(struct fwctl_rpc)
+ * @scope: One of enum fwctl_rpc_scope, required scope for the RPC
+ * @in_len: Length of the in memory
+ * @out_len: Length of the out memory
+ * @in: Request message in device specific format
+ * @out: Response message in device specific format
+ *
+ * Deliver a Remote Procedure Call to the device FW and return the response. The
+ * call's parameters and return are marshaled into linear buffers of memory. Any
+ * errno indicates that delivery of the RPC to the device failed. Return status
+ * originating in the device during a successful delivery must be encoded into
+ * out.
+ *
+ * The format of the buffers matches the out_device_type from FWCTL_INFO.
+ */
+struct fwctl_rpc {
+	__u32 size;
+	__u32 scope;
+	__u32 in_len;
+	__u32 out_len;
+	__aligned_u64 in;
+	__aligned_u64 out;
+};
+#define FWCTL_RPC _IO(FWCTL_TYPE, FWCTL_CMD_RPC)
+
 #endif
-- 
2.46.0


