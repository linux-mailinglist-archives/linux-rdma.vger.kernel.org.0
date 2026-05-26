Return-Path: <linux-rdma+bounces-21323-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEo+JMzKFWqQbgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21323-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 18:31:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C75D9B96
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33027316CC95
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E2B37757F;
	Tue, 26 May 2026 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDYm46ve"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795C371D0E;
	Tue, 26 May 2026 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810032; cv=fail; b=Lb1o5uFfAAcuNYS1Vje36YMb90DT3Zu54oNOodlSQqLIuEIGgcFVNzQRumGiReLas8JmkftXeaQTPWIy2sXPlnpNhoOjqjRtFOMbTwNG4kxinwx6l9LyKDTjk9fm50DGGPq6bJtWl7sT3vbN+R+xjoUl6CcIKVz2VT7bxo7yGMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810032; c=relaxed/simple;
	bh=yy5+q4BJ0yrnkI4AlXWChtZzbEddlnznI25eFBLEUxg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Kc7Rs8KwLUzmqd6xrOeMVJAsjmpfgXVq9flya+7p0SL12rnRnUNxhHtLAUEHoWdjapR9nce+Ohmxv/iEIcE1JiTTcmVr9OV2han8MVQNcW+1oJTrBfVx2Jn0yEv6P2TdHSlyfj+NQnJYhesWm9qcWWbWxWdYVH9U4Tug7XJcuMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDYm46ve; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1dPlwwKVtLckzzdeVZK8cmgwVmLTVXg2lKwckPLTobq12HS3TftRLeOodGB/juPnHvOTdbFGlBKRl6u+ksIWv2Z1pci5Q5Y8jjzBUJMjO5py3si8xhOd3JCTuqhpp2G0GooHDFU5NwJ4vfPWwWnXiz+IzF8/GKPf8PhPF38GBHmSvim6xGXGSRNTaW0hWInz38peWga9hGy/DQSaKlp7RBdvfUpfihc9aMKNu23L44spA09rLqp8XiZw28jiaQh0P36K9smXsqvaHlt7Dque+vKw8Y6PSA5+Pvqx24LippG65s4rAzz/mtq79w6aWaGDyShmqJcbLnyCOFgtEdHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87h0aTQKqql0JooG7movUH/PSuvqIBDUWzQkvgWEfuk=;
 b=dhZvR009ey179yh92QIp7OC4C2E5FA7DEUnOXK1uSN/FtdHQj/qbsByq+tAYJlBd7snPFFuB/4ugfbXjY8tPnA8yfo2M0oyM3klL16X4W69Ucfkz+l2dM/iTg5TakE4HcNLOZLQ408wtYMiFdE3iiBZD4WgP95W+3UaVTheuUjf5UlMx8UYJO6BDPgDnCEV6LPNZMQRcC0l6o5RxQKSrDrkWh58VjeRUG+HzWmSlnbn9NlsWWl/z2rOsYtm1yAz0vlHpmnHey0Hnnb7lbzeQ8Vp+NnoVyt+bbYweii2gXjCMRDLcrDJsLmCSIU5SEsicnpKvUBtSw6AbrKJvpef3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87h0aTQKqql0JooG7movUH/PSuvqIBDUWzQkvgWEfuk=;
 b=IDYm46vePEOQwssnA1oXTKs6S//L2tMKaKKudVt62DUu5b0AXSDHw1NN5Xt89E4xTqQZ4hpa87S9R68e8uyuGob3HDqUjmjA5uqC60wR2TiE+czgreFWJ9mFyVZlMgHkgMGdaeKUEPGyPt8G8I2bEfPxEL2NvbnSSXYf04EJRzZxUq4h78FXPXY+e7ZwLZ2p/KDaJLhdGeiMSdJNNblZFFxPEx8fnEOMSBBiXGmU0vI0NkwWc+0vlWDSfidXKxfKp1sQn/5Jl1omsi/8g5onbocMZeuEKYsVDyL4hYTHylE/bmc22owNYZ0k4eJgCPg9JOsmTfTNH+NII4ca2ZNdYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 15:40:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 15:40:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux-rdma@vger.kernel.org
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rc] RDMA/core: Validate the passed in fops for ib_get_ucaps()
Date: Tue, 26 May 2026 12:40:25 -0300
Message-ID: <0-v1-fd9482545e37+1e25-ib_ucaps_fd_ops_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0477.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f57dd2-0b85-472a-b2ff-08debb3d1bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	1bEBuXROZU2Xkz9v4t6DT45XH1HhxgdMpyo3q2OjCa1ohlbPXXhG2Zwu7/90NwjgCB27BlgBmI4scS94VUcsQQmpfjk7CJvOXp7kUsf+MDYArpeawaS1ELIWCG4UyojljttJ7Rw3brAHAq3qGhLL/jaq3MvIYxr8ubCycfv3QPDSWxYYKJr6v0UPVhtK6/Wf03q+7JYWvdApQy7isaek+cRvJms94Uhv/SRxL0esO6BrpTDfdtkjzBpqTP2anEEt+hSoAxkcUKxQ0H3DDCl3PYw/BgRlye5X6aKvmah6XbtMh1av6wWGrpDv9o6TtiDZygN6Hq+DxQN/83Cg+9WNe2Me5dVh/wH2n9wSxp8C3wPmVmTxzj16tSGW4fo5X+jgYWt6Qub5eWHTVwHWUniEPLMDKqSS9O5CrA11tFttctai+iVPcnOSM9liIhmom3FAwbZI1oVGetsUlF9SUNK/yoZGGGP5RGEdehb51CePatPDQOxvPZ4XadDB7zjgvGoH5UzLBPOCVpw77vWOYUPePj1V2Yn06G0CwL450HtDHWX+367vsz8AEP7+XqMTb5isvWr/VZeO8+Pe+UNC7YnMW0fpC0iN1GZISbthG1/coz/r3qM06zJ7Ozrpl0JvVt2AXgrBRhU12q5+QzOy7L82LyBMefuTl/n/WFPbxBTxginx5rwW+eD6w2QweQk61APR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zru2uJwsVdFXKkbXVU5Xvk1FkOWADlVkUAWNDuT0sgZEDCNAOAYw4ROA6QLt?=
 =?us-ascii?Q?GsJaEkKkBPTeQxL3q+MTIGNybH8KYHRQo2qBjVUnRZrpamkCULOhQDdJArp0?=
 =?us-ascii?Q?c8dh/R/pu0gQTYreiyGyBQWnChZ5phdrqul8PevjhYbUuzCa4W6kGUYmBgCW?=
 =?us-ascii?Q?pSl1qwiJiJEVnRacDDn6JEoPDiKpRvrxMznz3boAPZk6DYy/1zhqphJmJJjB?=
 =?us-ascii?Q?SY1uumSPqfavO0SriSIaNV3/1qKjX0YCnKQU5klHNRxJsMPi1f20ga8jNKjh?=
 =?us-ascii?Q?oaz/EPD8V0L2Hblgx2pI3OGBv7Zr/t2wv6LUvthjr68D8EOKxL1sbxYjWABN?=
 =?us-ascii?Q?jyt6E9p7VEkTJddfTclucqww3nrJMz93r2EFrA4DiBLkRjmeSPTFHJTa/Y6+?=
 =?us-ascii?Q?5w3JOWP7Mj63R76zzi1L24rL6S6OUgiHjwvoGye4f6+NCKuZPnVh11C9PByS?=
 =?us-ascii?Q?UT21Vqloe1BmMRXX+lV14SaZJ4mQXDFuqrrufiSGmcc1WTDVn4t5opa7ahFY?=
 =?us-ascii?Q?2+OuYklHcOogJr8qtvZ3krU5vsGOQ5GNW6KxFORV6mrtYyd9Z+Xdgy/YVzqu?=
 =?us-ascii?Q?roILtktvwWg+L6yiPdUzo+iA5LsO+Dh3k5XZJ/pFYc7P1aFO1I6qG4CRz9Q4?=
 =?us-ascii?Q?H5Yn8kpJNOsw+/XE4pKcbR0HBrSOjz7HLfezNd+nbz6yHZB/Cj07CsK8mo2q?=
 =?us-ascii?Q?Q7MJ1ApzGnhjsYNDTtkzK+NmUJ4Or2tdpMWFv9Sgo2oVtsXaRb/75pJvs1so?=
 =?us-ascii?Q?khiI7O/Rse0Tt7sytNACQmID9kxJBfU9A13G3u59yxGea/+8n9z0nO8tIs1z?=
 =?us-ascii?Q?Xhp0Dv6b44/bLgCkomumujLtZp+TUPH4jFJciY6rKnaY3sQueang7DMTHjDB?=
 =?us-ascii?Q?A7bTn5YD8ZVSwIlQ7Qxs/o3dxglncz9g/WfT1CflzV2LEajT8Ut6mVlDSw9u?=
 =?us-ascii?Q?rIANIVjpnxCO1mDKV5eKEwZ8/cC7neSrlO0WOCvnZtEvBUhY/aquDJHz08Ek?=
 =?us-ascii?Q?GahTkmlm57fugHXrTh/FsyTcVjbMvigCYIb8hJp5SGKB3UgrD25d4PUF65Ng?=
 =?us-ascii?Q?Pf72wCLI/nLi2oEaxhbS9AhjCEaUzys0PwzLFuQXt9JCpRfwJm88/pBH9CHi?=
 =?us-ascii?Q?MNeygabM3hV4cSOoBG25od7pUiDLAaUwJQjZjc30uyqnIhNmqvVUv+iuo37M?=
 =?us-ascii?Q?EVKRZKkou0O5IusUaSiKNxjXITTFsxyfDs8Yg+fhidchaojSKfMDqj8LGSCO?=
 =?us-ascii?Q?7cny+zjUq2mw0CzBUZG1yvUxXA5sUTAbUsUkPI2l33WgPfQ/tVoIhQGltEtx?=
 =?us-ascii?Q?GaoJ5fLMxMD/PSFwT2koUM1S93RzkihIvZX35SqUoE7uxNq1vuFN/VtqV8nY?=
 =?us-ascii?Q?4PaV9lm+s1n9G7StQejkSjhnWHgDqGO6U85Ih3f6o0StkOahB5guMHyjuO+U?=
 =?us-ascii?Q?vQDThqb0xY0j8U2lGTIsTfjWAJgO8S4jxoO/bS68oBMPBIHWJefm1+/v6d+X?=
 =?us-ascii?Q?okYd4HmyHDtK+Vgp4qW+Rey9I6c6fOAf3eWnkD097SCFec6puCsxLHPMODFV?=
 =?us-ascii?Q?7koDJ7Gu/hXxm2l40W7+VNKdVZ4STYLS7b9NsntaI0T+skiRQM1iE9CXFVAe?=
 =?us-ascii?Q?OkEVFTGS8K1+U70uNNCVR1V9PbT41HfNfg3PaYzac+OvbC172EvhciF+AoUr?=
 =?us-ascii?Q?FVgbSGyTxt2iDkvGxOHoBs7pxISOQrLhZRnkd1PiQvEatbjn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f57dd2-0b85-472a-b2ff-08debb3d1bdd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 15:40:27.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmzclVdOQl1q+VjdhidlaYQcf4tcQdL4RBBEdxAtYizy7z+HMB1PlkWvnQdrVB9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21323-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: EB1C75D9B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko pointed out it is not safe to rely only on the devt because
char/block alias so if the user finds a block device with the same dev_t
it can masquerade as a ucap cdev fd.

Test the f_ops to only accept authentic cdevs.

Cc: stable@vger.kernel.org
Fixes: 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities) API")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/ucaps.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
index c5721d3b0d33c0..03c78ade028963 100644
--- a/drivers/infiniband/core/ucaps.c
+++ b/drivers/infiniband/core/ucaps.c
@@ -77,14 +77,12 @@ static int get_ucap_from_devt(dev_t devt, u64 *idx_mask)
 
 static int get_devt_from_fd(unsigned int fd, dev_t *ret_dev)
 {
-	struct file *file;
+	CLASS(fd, f)(fd);
 
-	file = fget(fd);
-	if (!file)
+	if (fd_empty(f) || fd_file(f)->f_op != &ucaps_cdev_fops)
 		return -EBADF;
 
-	*ret_dev = file_inode(file)->i_rdev;
-	fput(file);
+	*ret_dev = file_inode(fd_file(f))->i_rdev;
 	return 0;
 }
 

base-commit: 9733e9f580fdda2e8c1cd349caddd93f026ab6f5
-- 
2.43.0


