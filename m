Return-Path: <linux-rdma+bounces-7488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB4A2B6F8
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD6B1889344
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7481E;
	Fri,  7 Feb 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdFc7OyO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601BE7E1;
	Fri,  7 Feb 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887222; cv=fail; b=eYby06Y7US0/jv6yWd4WTuxQA2t0wR4e4O9FP+AG4D98TsgfPR3ShPsBIngFbxLx9sF/q7VUZaNWv+fuZ+aHju1RvzXMMvTHtcA1CTod80y9yKeE/ox7QymTjWPlYTAxNj3IcwZI49WNEdLcu3/C7zPLOHnZuuFnlB+BbvYs4d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887222; c=relaxed/simple;
	bh=kFWwKN2a31IpSOZzhB3Xx/RHgKuQXnwlHqSWoEMcokg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9JAG9wJGOeX5IJBXwiuIR8oMBhx6JmPNtu8T95hZgzlXqI4LrUXakdoRZoGun2RU2Csi9I49/vzM8+YxA/pRhuITDsdNyyTIjTFFHMQvSSfTr9CaW+tZVVFqxZ7gJFlbAAOW0FKvzmN+J1is5LI02zbGeKusf4d9yXDTar9tF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdFc7OyO; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz9nYY29yIBpCmLbVL/sReBj8PNJB66wdJpr1nF3K8jJn8FNKt3RqZ09daOREvCpSsAp/5B9Efqh9Me2K5dyBwF3WukaHcviLY4k7e7rWUcnw704pFAqs0UKfUHcWOhmJualxtIgF/xrjovbhrFR6ULdJnZap6xYhguNrF/BJEpRnVMZqJ/IsO2W8U1gRjvYFYDFtw+a0s0+ww9CHoKcfkeGL6pegYlOiQ8ZqEK+wNRSHdq7iWu59Db/E42+cScVUVbaMaKQmtyT51+QlxV1ZB2OI9JgjU3GL5xMSbCYtTMAs+1c6w2ZbSYhy+S1b6RFgfdM9KwgQzM9MKxNiy6+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJP4O92zwVekjKWNGJ+pCivhdJA5kJyiRfrHLsYfbTg=;
 b=PzRSpMpJyR1mt3C18XHGeT9sDDKVWZ/WLkxVHw3g1RkqFgDzRhrZATxS5SPjnb9CtJ5AOZeb41U/i+lZMCNUOA1Vkjib92kSYmrjouMDpaw++nkqDYz/TlBpSLe2Deau6zBcmkqqamkwMRvxq2djhh7aCKnX8RH3EjpJZ0hZudEKLUwDiUD7weWnx5ll46JXEWBvgFz8TwKf7pswhHamYr3x7esnjPEtRdLrBYynoIFm8cZjdpiJZ24uHzK/6rvpyENJZGypDfew44GXeJQ8mQTEQbjGc/kgkZT2UIJVAkYRMoV84qv9GZZkLg7xTIAJrlPH5/BgYusRqlTnyM79bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJP4O92zwVekjKWNGJ+pCivhdJA5kJyiRfrHLsYfbTg=;
 b=ZdFc7OyONoBK7Js2Q01fKEdZIpqq2iRljPxILeKuVXnuBo64vQYSsYF3/IlYazCybb83AHTNsmrjN+RGy04+IV179nnDV+EwmiiEJP3h/G3xJ41ulF2PSxuDOlwe/8/Yg+sqhWapchxglEGM+bNdgIB1LdMVsKJzdzF1phW/gD6mH6GnzfrW4K8tjqH+zNPnqSpXBkzV+WXSpcZNwfsQmIhUX9lffePnf5bkboQpP/zA0Xj1emu24F5aWK4rwnmelo+0nxYeuQ33MN6k1nzY16Udje47L57iBARNWb80g/6n6/Pgz+p4V/u03O4IbeHts0FvdGkD+B0hrAB/VJ+nhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:34 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Date: Thu,  6 Feb 2025 20:13:32 -0400
Message-ID: <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0307.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4250b2-7b83-4974-9c5b-08dd470c4287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVLWNH2uJVbBWb6mrA1CtARKpICO1YtQHLrj+BeR8xhSe3ww98ldRZhKPlxG?=
 =?us-ascii?Q?u2WP7MtePW2IOK6nNojNNyfDATQioNz40M/HJFQ8JH6Wj+Lsp2Nb/2dxhobR?=
 =?us-ascii?Q?X8Ltr2c7mNO7nbhV+SGmj30WOk0Cfe/xf84Sg3QuAsZDFcnbp8tNV4KiXpA6?=
 =?us-ascii?Q?7r1gn2rNS/sNifzuS3FW/oLKvatFgjlXoE4AWuRVeGOjMOb+agkWRHRJ0Hp3?=
 =?us-ascii?Q?hEc+N0TQEnPAJGKvdQMiAcTL+VkyzE30xOUjL8Istt32NXwc0/1QC7nYI69v?=
 =?us-ascii?Q?iftQQJ77foCRJAD6b0YEpmHU/DUQQeZOJZapBXfNVXWnqU+jlhqrThak6WAz?=
 =?us-ascii?Q?ZGPFSdO1kNr1ABUnTVqAdOAwF/gzAtUq4I1B3VpvEa86zswGgdBhtmN0oZEo?=
 =?us-ascii?Q?UiTHkiPPsqbO8cF5zPDQvdAJB1vOcH5IBnN9RCvj8a1onUC3qwO+6p7wgoZj?=
 =?us-ascii?Q?Ipuqugh80FTMwjjbwB/Zne+noS05rLgy4gqmfUnpoIeVDih4DY+IcoPsN3yG?=
 =?us-ascii?Q?K0ytRajhq2np6S3WnCE1VJI3s0If9Mslnwb5bTbswxIkdd1NebLwXXbILG9z?=
 =?us-ascii?Q?sSinBRhpZvCpM3ssgPN+FLxt7kcd970eGEK6MSB0WJtJ8GqR66hzEJxSXG+E?=
 =?us-ascii?Q?9nacJX6Ea8hHITN3HLFj0aOyemmmWEi//EsF46hRYGvAgS173P+TfBP0kl/r?=
 =?us-ascii?Q?5HDjWBXZqAOvZgK+SHPuTMRtjTHddXwTOEm6+YZlFHCMlxI2iObBQk3SOKZF?=
 =?us-ascii?Q?UBcj9PGAbodBo9ONpUbG77NeK13oxWrw5TLn79hBvHdTes+9WJmZQczkIf+/?=
 =?us-ascii?Q?BXrgxChrAgNMQBP4QD+M8rUQjcAMc6KJnMZ2E7GUj0ZtbpDh+WgJtc0CDMR+?=
 =?us-ascii?Q?XhZOJhMEPjzPwRfffZTGXKEO1+h+n8rE8LO+y4x8qulHMcwCijrRX1J9llzm?=
 =?us-ascii?Q?SIdQc9OjhE2z4kvHlj2DaD2stVZdYhSF4rTejrCJVxtI5lbyzpJUnj2SQqnG?=
 =?us-ascii?Q?58j/OqA6RF9IW6iRQm0qPsQEw1vWbifDJyeunYjb8RYpqZfOnl/ksVJ2/3/d?=
 =?us-ascii?Q?Oy922TEgiDRy6Ewt/URwo67QJWAtmBy0oDrFk5Lkxv+HJa6vGXWF1oUUDx8d?=
 =?us-ascii?Q?rkrf7cJBukwuN7yoEpHuxZkt6UOjc1WVRcLWl4aqa0ycZzM2/O4L+kWosM0g?=
 =?us-ascii?Q?61xBlyTNf4Ru17Wp+5Dexb6PNf4FdN8Xw2mBzR0JK4JybWPtvKMWsOj1vpMn?=
 =?us-ascii?Q?Y6o1FpBu14GSVcViuBtK0fiSDc/MLuQ9gFVDs88KwszIidr0E+1ZLWpG0u/e?=
 =?us-ascii?Q?LMJF2nGUpMrLY+zg1nm/JlLjsSKSWNKiJzvy25sYdT7sNz8yTAH29YwBd68l?=
 =?us-ascii?Q?XpSoNCmSMQnmVnvR3guCMufxdrte?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nWhB3eHrh6W25VACc4AncL/7azgb+DOC6jc75oV12s2CJ6pXblSnRr/3S59m?=
 =?us-ascii?Q?havIF3dsU6NCGFD0FqVSmtI5KDwuD82osG/7UkE7yRm5E4MAoiAU9eouNsMz?=
 =?us-ascii?Q?hvH+4OJyz5qu0LrGs1UHswd0Z5rvLT+2WWiDaUQ5KaoQonjG/X5729EDz1Se?=
 =?us-ascii?Q?qcec0jNrV/wMGXbwRmueegBQ47gGlW0SGFj95CAhGDwaGlamqxXc2rMXeUt4?=
 =?us-ascii?Q?Qxlx4UBJf/dClDERV4M2in2Bsyfa0PLDW4sJSQd7YHugGR4oN7H8IMaz8aj0?=
 =?us-ascii?Q?ukhmA5uVYvm7Won6VNr1HARxMcuu8ZdJhpBzy/agQN6dyMlAkZTdJNcVN+Uu?=
 =?us-ascii?Q?l0bGGP+jvwWcmmdr+smJLyVexpfJrEAxxR9VpURY31SqUjdT3sYKWbRnz9FR?=
 =?us-ascii?Q?z9on1e1xDjIuU1VyRb1R4F4URUzlUICLva6aWZ6xTbsPs/hO3HsFQCrkLX6G?=
 =?us-ascii?Q?KCNQmqLixcy20Oo44Y/O5oilXxcW6W+BUnxK46sY8Leb+AeWg7WO91eqx7Z9?=
 =?us-ascii?Q?0uhlp6MxCTW0kaB6gOBhTJBIjjz5qDUwec15BM//VFbbycVvvkhsi+QlrFKF?=
 =?us-ascii?Q?kSBJ/CMJqPx60mYjnA0C8bUrEtydMhuTHdVEm2R4XcoPD8pvY3rSh8gEVyAn?=
 =?us-ascii?Q?g9vSHLNTAwrlPd60egpGHCytwWt3ffD2ru5aLExXHoUt0DOWmbCAf5ch9bvJ?=
 =?us-ascii?Q?scRmSYdUs7Sl0/pXfHuc5SaDJK8xpU1B+ONL5BK8IVCBTWWp/ZFBfmlL+SCd?=
 =?us-ascii?Q?uQEFckC+Povc49s7VUjFoGaKf8V/fH4X4nDLwfiok6NVDB76xc82QvKeYDTZ?=
 =?us-ascii?Q?wjd3MkWfBhH0KZoYyAa180FOWFbVvE5/xNIG7LobVVKrX/pSd8c69zQoInwj?=
 =?us-ascii?Q?l4yoppeugZDcCDw5vLyjJWVJ7rZ83se9CssPUClqizqC8bGabZV8nBWORFMT?=
 =?us-ascii?Q?E2OleZA9t+akvO8vlH/869+lL8pTrMkaLHm/5+KtQI3axme3vV7p2uN1j/i2?=
 =?us-ascii?Q?Apswi49g8i1FmLYFpz8d8Usy+UIIoyp53Ad/s2+SYq4nDK1xTO9d6Zc1L6eL?=
 =?us-ascii?Q?1UwFUbXFShvfEmf7rTuiBomDLsdfPN2vp9RLx/cJITQrVyJQuhf5841V5SXN?=
 =?us-ascii?Q?WZbzMs3hkgWxvS8ijngckuTgpVFpEUI9w2TB401jP+kf3jc9GnDW+8fsFY9Z?=
 =?us-ascii?Q?H4jM2icejWtoh9bOzBJ+1/wASY+/60qtuLvxTsJfvNwQem/AuOSCICaBAh8a?=
 =?us-ascii?Q?kXdnbjI1hGSTH46XQKbiETfZr+PrVDIS6OV5bCAurrNOwP6GCQ2VVoHWr8cV?=
 =?us-ascii?Q?UdwluS7lLMGQ5/OW4TT1Olm0jlh+4U7iO2j57aoaVcfPjaBnjomAZw52XmSt?=
 =?us-ascii?Q?giTxpHEMx1HB5xzAyUb03c0AXm54hI9o+k40qdwZ8NLTk4ksPTh59M43ZXbh?=
 =?us-ascii?Q?TeZjvVIcsGlwmXxloBAiXmHgVxaRyEsUCzSOVj5XxLIFNKq+bqvDM7gWq6vu?=
 =?us-ascii?Q?UbhU71PFzW2dFJE45R3COJbNkYvXnbd/aUgoNDL/CDG64xu9J0jg3Q3f7Ss9?=
 =?us-ascii?Q?0bMWQ0tIDAsQN6eNz/MuXytTcEz4Rs2fWNI+yo8N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4250b2-7b83-4974-9c5b-08dd470c4287
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:34.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXyOBfyQSL9UT7N8Wfsfwwzab9EkJOt8KKsVT8/bf04yxwsKqHUVvCfUI4qLoHt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

From: Andy Gospodarek <gospo@broadcom.com>

Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 126 +++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   4 +
 4 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bbe8..bf33e7f26b1fd2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16291,6 +16291,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_init_ring_params(bp);
 	bnxt_set_ring_params(bp);
 	bnxt_rdma_aux_device_init(bp);
+	bnxt_fwctl_aux_device_init(bp);
+
 	rc = bnxt_set_dflt_rings(bp, true);
 	if (rc) {
 		if (BNXT_VF(bp) && rc == -ENODEV) {
@@ -16353,6 +16355,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bnxt_dl_fw_reporters_create(bp);
 
 	bnxt_rdma_aux_device_add(bp);
+	bnxt_fwctl_aux_device_add(bp);
 
 	bnxt_print_device_info(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2373f423a523ec..1951fdda8820d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -30,6 +30,7 @@
 #include <net/xdp.h>
 #include <linux/dim.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include "bnxt_hsi.h"
 #ifdef CONFIG_TEE_BNXT_FW
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 #endif
@@ -2326,7 +2327,9 @@ struct bnxt {
 	(BNXT_CHIP_P3(bp) || BNXT_CHIP_P4(bp) || BNXT_CHIP_P5(bp))
 
 	struct bnxt_aux_priv	*aux_priv;
+	struct bnxt_aux_priv	*aux_priv_fwctl;
 	struct bnxt_en_dev	*edev;
+	struct bnxt_en_dev	*edev_fwctl;
 
 	struct bnxt_napi	**bnapi;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index e4a7f37036edba..7e39d9695af339 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -26,7 +26,8 @@
 #include "bnxt_hwrm.h"
 #include "bnxt_ulp.h"
 
-static DEFINE_IDA(bnxt_aux_dev_ids);
+static DEFINE_IDA(bnxt_rdma_aux_dev_ids);
+static DEFINE_IDA(bnxt_fwctl_aux_dev_ids);
 
 static void bnxt_fill_msix_vecs(struct bnxt *bp, struct bnxt_msix_entry *ent)
 {
@@ -413,7 +414,7 @@ static void bnxt_aux_dev_release(struct device *dev)
 		container_of(dev, struct bnxt_aux_priv, aux_dev.dev);
 	struct bnxt *bp = netdev_priv(aux_priv->edev->net);
 
-	ida_free(&bnxt_aux_dev_ids, aux_priv->id);
+	ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
 	kfree(aux_priv->edev->ulp_tbl);
 	bp->edev = NULL;
 	kfree(aux_priv->edev);
@@ -488,7 +489,7 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 	if (!aux_priv)
 		goto exit;
 
-	aux_priv->id = ida_alloc(&bnxt_aux_dev_ids, GFP_KERNEL);
+	aux_priv->id = ida_alloc(&bnxt_rdma_aux_dev_ids, GFP_KERNEL);
 	if (aux_priv->id < 0) {
 		netdev_warn(bp->dev,
 			    "ida alloc failed for ROCE auxiliary device\n");
@@ -504,7 +505,7 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 
 	rc = auxiliary_device_init(aux_dev);
 	if (rc) {
-		ida_free(&bnxt_aux_dev_ids, aux_priv->id);
+		ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
 		kfree(aux_priv);
 		goto exit;
 	}
@@ -536,3 +537,120 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 exit:
 	bp->flags &= ~BNXT_FLAG_ROCE_CAP;
 }
+
+void bnxt_fwctl_aux_device_uninit(struct bnxt *bp)
+{
+	struct bnxt_aux_priv *aux_priv;
+	struct auxiliary_device *adev;
+
+	/* Skip if no auxiliary device init was done. */
+	if (!bp->aux_priv_fwctl)
+		return;
+
+	aux_priv = bp->aux_priv_fwctl;
+	adev = &aux_priv->aux_dev;
+	auxiliary_device_uninit(adev);
+}
+
+
+void bnxt_fwctl_aux_device_del(struct bnxt *bp)
+{
+	if (!bp->edev_fwctl)
+		return;
+
+	auxiliary_device_delete(&bp->aux_priv_fwctl->aux_dev);
+}
+
+void bnxt_fwctl_aux_device_add(struct bnxt *bp)
+{
+	struct auxiliary_device *aux_dev;
+	int rc;
+
+	if (!bp->edev_fwctl) {
+		printk(KERN_CRIT "edev_fwctl is NULL %s\n", __func__);
+		return;
+	}
+
+	aux_dev = &bp->aux_priv_fwctl->aux_dev;
+	rc = auxiliary_device_add(aux_dev);
+	if (rc) {
+		netdev_warn(bp->dev, "Failed to add auxiliary device for FWCTL\n");
+		auxiliary_device_uninit(aux_dev);
+		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+	} else {
+		netdev_warn(bp->dev, "Added auxiliary device for FWCTL!!!\n");
+	}
+}
+
+static void bnxt_fwctl_aux_dev_release(struct device *dev)
+{
+	struct bnxt_aux_priv *aux_priv =
+		container_of(dev, struct bnxt_aux_priv, aux_dev.dev);
+	struct bnxt *bp = netdev_priv(aux_priv->edev->net);
+
+	ida_free(&bnxt_fwctl_aux_dev_ids, aux_priv->id);
+	kfree(aux_priv->edev);
+	bp->edev_fwctl = NULL;
+	kfree(bp->aux_priv_fwctl);
+	bp->aux_priv_fwctl = NULL;
+}
+
+
+void bnxt_fwctl_aux_device_init(struct bnxt *bp)
+{
+	struct auxiliary_device *aux_dev;
+	struct bnxt_aux_priv *aux_priv;
+	struct bnxt_en_dev *edev;
+	struct bnxt_ulp *ulp;
+	int rc;
+
+	aux_priv = kzalloc(sizeof(*bp->aux_priv), GFP_KERNEL);
+	if (!aux_priv)
+		return;
+
+	aux_priv->id = ida_alloc(&bnxt_fwctl_aux_dev_ids, GFP_KERNEL);
+	if (aux_priv->id < 0) {
+		netdev_warn(bp->dev,
+			    "ida alloc failed for FWCTL auxiliary device\n");
+		kfree(aux_priv);
+		return;
+	}
+
+	aux_dev = &aux_priv->aux_dev;
+	aux_dev->id = aux_priv->id;
+	aux_dev->name = "fwctl";
+	aux_dev->dev.parent = &bp->pdev->dev;
+	aux_dev->dev.release = bnxt_fwctl_aux_dev_release;
+
+	rc = auxiliary_device_init(aux_dev);
+	if (rc) {
+		ida_free(&bnxt_fwctl_aux_dev_ids, aux_priv->id);
+		kfree(aux_priv);
+		return;
+	}
+	bp->aux_priv_fwctl = aux_priv;
+
+	/* From this point, all cleanup will happen via the .release callback &
+	 * any error unwinding will need to include a call to
+	 * auxiliary_device_uninit.
+	 */
+	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	if (!edev)
+		goto aux_dev_uninit;
+
+	aux_priv->edev = edev;
+
+	ulp = kzalloc(sizeof(*ulp), GFP_KERNEL);
+	if (!ulp)
+		goto aux_dev_uninit;
+
+	edev->ulp_tbl = ulp;
+	bp->edev_fwctl = edev;
+	bnxt_set_edev_info(edev, bp);
+	/* bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp); */
+	printk(KERN_CRIT "Made it %s\n", __func__);
+	return;
+
+aux_dev_uninit:
+	auxiliary_device_uninit(aux_dev);
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 7fa3b8d1ebd288..148e3eb32be001 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -124,6 +124,10 @@ void bnxt_rdma_aux_device_uninit(struct bnxt *bp);
 void bnxt_rdma_aux_device_del(struct bnxt *bp);
 void bnxt_rdma_aux_device_add(struct bnxt *bp);
 void bnxt_rdma_aux_device_init(struct bnxt *bp);
+void bnxt_fwctl_aux_device_uninit(struct bnxt *bp);
+void bnxt_fwctl_aux_device_del(struct bnxt *bp);
+void bnxt_fwctl_aux_device_add(struct bnxt *bp);
+void bnxt_fwctl_aux_device_init(struct bnxt *bp);
 int bnxt_register_dev(struct bnxt_en_dev *edev, struct bnxt_ulp_ops *ulp_ops,
 		      void *handle);
 void bnxt_unregister_dev(struct bnxt_en_dev *edev);
-- 
2.43.0


