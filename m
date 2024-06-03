Return-Path: <linux-rdma+bounces-2786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F28D8685
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79515B217D0
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CCA132127;
	Mon,  3 Jun 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0a1JyPk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E892576F;
	Mon,  3 Jun 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430014; cv=fail; b=LIQMOKihFfH9Key2q7dM3Vw7O2tsPahv8ztXcc12gXM/wUnnkU/JVjb5SoKmkXeSlBlYOJuyb8oHszqRO5ItNmUGap1CKiz32COLfO2GzlGSwbrt7jvMhgaDPIpOSf9nV3kCws10OgD6P15wOxxtq3RvE/4EtIKWmwg4AzvDPEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430014; c=relaxed/simple;
	bh=AEYCTJ65gy0+wqFPeTtMg5SoCFWMgKAi9rCsp2EmSAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMPmR8+1Ftt/yWQgeWoM8mHBzzs7fJbHTHl35rwt5itD9Vq+u59nPY2Ky3zvIAH9CNOwxn2M2PElNj77hg4+IfBBOtyeXsmQBbmNs4dXXF9NPxW4S3O/2szPmOq42ek4jASRxwiLUd3xlpDXhWm/0EXe7Ky/tA4COIMBTK/yUiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0a1JyPk; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYZ0BC338H3J+9jZsXWLYSasdixwGKeeXV4SigvRTJ9jlgilrdabVmxGkRizPyEe81uHLWo01zbmR0AQyseEgdC3zBj/M4ceCp9IgPqctRsQ/b+pRTc/lIQ56b4K0d/rLazwkaWCv2422AhZjkXdhti2Yc6qEc967FDn/CXbEt7iGH4S5FYLsk9zIe9esTM2PTeUN+nyxyWf9HFHevGLjwDT20Y7gTGo/IfMpMzOOMYPiLTb7O5JC9LUc9x5d8hk5ZiybTsPvm12pieqBBfERLQCcXusAID3n4vIk9RfbIDZ+xPMB1yPO7Cve7y8+DI3Ry/gFCHzAlTx7niQ15mkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a66Ch5a6DnRuLMQiJuqgluaOzuZl4aSIf4u2RZsEhw=;
 b=D0V9qMtPTyxfar+9ix2tHg/jJ/7XY1XS+o/uDC8YNE7+UMu/CaJ7Fb9FDYONkZVkzwM/LH2Y4YDG8g8JHdsTqjSwhxmtHUru/K05C+YUaPfu//63W9akanhtVdp0wJzraCbimZ3qG0WJhAf+/yn2OlArzgVcmfUwGsqcV5cRKE2QZkIevx+ewriM0AEBmAFwGM0Ge8EogmQ8mTfW6MghHawqiqBisxp99kqVwgXmu/O7OC2KA9q3r3JD+bzjyVwXaVslbTKQIkqiYJ5tMgEqOGfNua5DGrD2q0+FsvOxrWSh1p1i8Ukbx3TZi3oViNkeg8d3JwbXq3eEyp3gh3O1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a66Ch5a6DnRuLMQiJuqgluaOzuZl4aSIf4u2RZsEhw=;
 b=Z0a1JyPk4JNK+U4FldqMbgn9B8PWuk3uzx/l/R22G8UAphkex1IhFDSeBDViyzmwCj7FK+/I4bjtC0Ca5vYt2EonC2dZHi37f5fmsUX5cWIunyAsuNYd/p1c9ATjXyrTKTR9AvlgjeOsD2dvH/uHwbnpiTPhpjCcljaTxHyKtrkXDguQ2LV+QSViBMkVFjBVZX5wc7Zlbs3WzM6NlHOrOoc8bb3QGgjOCfB0uTfsbthfHDeubhZQPHKNOdnJLXQmQBmn++vjJjw3JChyhCy9W7kFpztkhkU0PYBrRV9RaaeAcNTTndvY6DxCk/Bpz3PuYIeMCmm0v8t5GnPxZlhiGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 3/8] fwctl: FWCTL_INFO to return basic information about the device
Date: Mon,  3 Jun 2024 12:53:19 -0300
Message-ID: <3-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: c0280e73-9959-4ffb-d015-08dc83e54e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nIghvLiuVPhYq/o4sOz9W1WPwHsxoMHp7L7KtI70mavoXU39bGC/f6nbItxd?=
 =?us-ascii?Q?VGZgmVoEO1jNN6q/XcLqcami5hbKOoCb89SjPW59rVAZj+EyQeGJ2xAUpOES?=
 =?us-ascii?Q?hMylTfRSjfVjm5xHeYpmfUJZTled4BWlq8+xjqWOsv++nOu2O/IbHSIvx3L2?=
 =?us-ascii?Q?3keeSY1UbzAnSzrfsls4iHtnGEVq9dBcAFXRRYyIVJ4HpnwLm1G4bPtqmtDR?=
 =?us-ascii?Q?JhgSVvNDBL40efVqIWVDyxuQsBkUl/LRLLVBZVcHX/sYlvVRC04KmyWYxt2P?=
 =?us-ascii?Q?cRMd/pY9vEF2AUBTTIRPPdzDpldF6vLvXMeA2Bq4wgWfiro2oafrpfvKk8F+?=
 =?us-ascii?Q?oSUILQPEhqTUjATCqaBNQIazb5jTax3/f/kh+L0xsLE62xSMH4TkOpBce95H?=
 =?us-ascii?Q?rOIKItMIZ+zMRDIZFzK219DviDlxi28wiOu8CZ+Izuegjle5igXqxQj1umhD?=
 =?us-ascii?Q?9tc8T6x8+E4Z6eQXb82o04NW8nVFBDXEZgsdJY9LqxvN/+S3vUQRMGsukI1P?=
 =?us-ascii?Q?sWr0Xf54MXg5Qkz4/80gJlLbfdWibQ2JxA6brPpAveXOAc3nwjV99RwgSdzI?=
 =?us-ascii?Q?4HSrscWi0g2jYSSzig+r+44jJ7KuRU5CqA2ZQ/TOmr+nn1yERmT733NgHUG6?=
 =?us-ascii?Q?r4GL6rlO2/yTWGJ4EgWMuMa1E6h+QGmI1PFcJVfBNYdlsDrZgAw5z8Z0fBQv?=
 =?us-ascii?Q?5gMZfgY3pW2RaW83t7pA/9nIuBHWiYddLvPJHfc7pQa8XeWPloR0RA1wFwWh?=
 =?us-ascii?Q?hDJnhr3zZ2ukBB0TP/hDto2tBrQUgMZ356SFSQcdKd/xbQVbbozvG+/fYGcr?=
 =?us-ascii?Q?iT+XK39a0L7chKujGBpvl8Q8sdXEZsMLHsHvZBhNvKXAJVKcv+ggsGpg6t5d?=
 =?us-ascii?Q?C+Hm/0PfLEOyPUEp0ilfQ2NcK7PtRu6L6JSR8fYe3BH2LIRh3y16NWtdqc+8?=
 =?us-ascii?Q?YAnIBbgn72ZpEjfN/jwVTzPhjeK8DMi3/INHXLHlKHMgXYD4Kddp8kMPXxIV?=
 =?us-ascii?Q?eOTyRW85q5Cwm0A3OE8bICYlocoyaxTJdGo2Q93QxOHrLfpXqgFL4C9UXvCp?=
 =?us-ascii?Q?McvEHq7xvRjtiaG2V3VyMUP9uhPd727AwP3r11gPrvl5cjy1B/YcZuwdS2U3?=
 =?us-ascii?Q?UhNI0knjDkN+LHMtJMR7rsNdwbEa1ABP+nPjoILf9VbYDoqPH/bU1qwPV+gx?=
 =?us-ascii?Q?EHtcvHgxI5X5asGuATbzpCnzVMHoHAcFzcF8PhC5jjSbXf70QDSB8913kvVq?=
 =?us-ascii?Q?db66lgHdUo53KPew7Doj0LU6OAcHM8X9JUimpjp79xWE+5tXpHHUS81gyjIm?=
 =?us-ascii?Q?Kc7mCNQYCik+nHtRBbMgSlAo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hknLPk9z35a6QPTymck7wWebUmeybQhztn+AWMzGd9+IkKHtC2t5CQvCZ90b?=
 =?us-ascii?Q?ppxIAzj0YdbYazvTx0LfZYo1TLBBJCsDCof4Hygh86QMzo5HULpnzPgmTdax?=
 =?us-ascii?Q?rnaZQmCaeZgdXzyX7cMrKyAri/ZDNOKIHVfdigiJOAL1b64/Z39jIhVbBWmZ?=
 =?us-ascii?Q?5NK47cDqXxrEdC1jk4siijMI2eeg4Y5tUnp9DlavBhiqVcGZKT+Rt7oQ+EIt?=
 =?us-ascii?Q?ndn2HhGSFUycLBhsNtkgvn2dZMq7HAubEGLfiKNdaabsYvQDD2AxipePFluR?=
 =?us-ascii?Q?YgrmerSDJWSupjLdZNLaMeCKyizwrKJThzgSz5SRDLO/dS5wLltsZidF3REm?=
 =?us-ascii?Q?71RVTUivlXpW0SYRMcP3s23lJoUoXdAw6a08RfvCNF0Dadi1lktXypKjibRa?=
 =?us-ascii?Q?G1AQkJRBUMKwIFmZH9H8EErZBINmtTvSlVOaOcV9PNyp8a96m3FqwxXcBvDM?=
 =?us-ascii?Q?aI9VYesGMbk1h/mUaEjoTO3lh83UxFsBmvHJA1Dz8+pOQnRUDX/LS6wmu5/K?=
 =?us-ascii?Q?QV6p/lJKhGVcsbFtyvEX3NS9R9bHO3tYFxBhSXm5fKFrj0yGMEXZYnLo+40r?=
 =?us-ascii?Q?H65+wMOy+TbDc4lcgysd3QOFkS3LPtc7Vmxy37leS3h3qYtuvIuaGVEOTaMu?=
 =?us-ascii?Q?r7LDTYiRERntlRQ9Gl2dw3KTG1PHib/Hq3/XkBWwuXXpXq0Y0zn74XMa6cha?=
 =?us-ascii?Q?VIUuvILjhJjzxBW5ZqeaV9yvxV/azO1ITWH8ytUdK0tZPHLouUTCWIdoPXh6?=
 =?us-ascii?Q?LJUra+UVoZIndycZspS+xMvx4ALQTRgfOwyZJXGRx0/E7kbvZoUT5cm42A8b?=
 =?us-ascii?Q?ptelKsi1EuO7NV4O0i6Ug6ZfXd9guiAWZcGE4HFnZtz8yw+oH1eTno10/UzV?=
 =?us-ascii?Q?nYl7COQMW4n/xbFBReVNalofqDbS1d/0PN33fMThw9EgaVrV6dpNaajGw+TI?=
 =?us-ascii?Q?XOro7RGHUK8Q8VZu01m+2TRTO5pmJm+qsq7u7Ad6Q7DqWDxWI8K74G3eOEKy?=
 =?us-ascii?Q?F4iDvtWL8kRbFHwifY68YySk8ei02hP2AUAl7HYAFPs0aWz73oW99Nj3WMYh?=
 =?us-ascii?Q?IvpLqc+QAzLaj3mn+rqVpXEGlVrNQLfGjh3gkwL+JOTyrNt0OuUh7DEQHLfc?=
 =?us-ascii?Q?RuhSane1nw3saaX7J+n1E3Fmkfx6tqeCsxG1dOmS+4QiqWsuxbkNOe8dZQlz?=
 =?us-ascii?Q?NGmu9o7aa3N3OE8nFsG9bZvefXJG6VE2BLde05Y0d7w4BO71iSkt21ad1Moz?=
 =?us-ascii?Q?vhlusxg8qXLCIPx4xdYiLLsjRVD5ZiwJ67dTKx1Af4tCriC7fH16Fyf3v3Kl?=
 =?us-ascii?Q?ARUauCLpNwJMWLKty1bA4iMMPcskpe/6xhFERFPMJF0frGVB+2a5mQgP0CRO?=
 =?us-ascii?Q?OgBH0+dy7m/Hg8m4HfDPrzjm1APEo7iG152YbN4omkvRJpxnqI2h+V0s5pP9?=
 =?us-ascii?Q?ErKWPAX214DBxGwOtNoA+5Xpc++qF3NGcdY1pQWI30stjF1UsAn4JY19B0pv?=
 =?us-ascii?Q?2IkqvwFkz2dfKiv1+ss0jFQolqyJtRL8x6hPOxTlvTzgLMpOHSzQ9twxab6S?=
 =?us-ascii?Q?fG+ZJgJLCOpKniCvEK2KC/wBQsRw4bU/+8v64wN6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0280e73-9959-4ffb-d015-08dc83e54e17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:26.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+hksErZcJH0PrWJ8hqTyvQ2+xh5UswJNkFY4PIb6Hn6JAWmduKecTbgMaeujcAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

Userspace will need to know some details about the fwctl interface being
used to locate the correct userspace code to communicate with the
kernel. Provide a simple device_type enum indicating what the kernel
driver is.

Allow the device to provide a device specific info struct that contains
any additional information that the driver may need to provide to
userspace.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 54 ++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      |  8 ++++++
 include/uapi/fwctl/fwctl.h | 29 ++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 7ecdabdd9dcb1e..10e3f504893892 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -17,6 +17,8 @@ enum {
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
 
+DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
+
 struct fwctl_ucmd {
 	struct fwctl_uctx *uctx;
 	void __user *ubuffer;
@@ -24,8 +26,59 @@ struct fwctl_ucmd {
 	u32 user_size;
 };
 
+static int ucmd_respond(struct fwctl_ucmd *ucmd, size_t cmd_len)
+{
+	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
+			 min_t(size_t, ucmd->user_size, cmd_len)))
+		return -EFAULT;
+	return 0;
+}
+
+static int copy_to_user_zero_pad(void __user *to, const void *from,
+				 size_t from_len, size_t user_len)
+{
+	size_t copy_len;
+
+	copy_len = min(from_len, user_len);
+	if (copy_to_user(to, from, copy_len))
+		return -EFAULT;
+	if (copy_len < user_len) {
+		if (clear_user(to + copy_len, user_len - copy_len))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_info *cmd = ucmd->cmd;
+	size_t driver_info_len = 0;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	if (cmd->device_data_len) {
+		void *driver_info __free(kfree_errptr) = NULL;
+
+		driver_info = fwctl->ops->info(ucmd->uctx, &driver_info_len);
+		if (IS_ERR(driver_info))
+			return PTR_ERR(driver_info);
+
+		if (copy_to_user_zero_pad(u64_to_user_ptr(cmd->out_device_data),
+					  driver_info, driver_info_len,
+					  cmd->device_data_len))
+			return -EFAULT;
+	}
+
+	cmd->out_device_type = fwctl->ops->device_type;
+	cmd->device_data_len = driver_info_len;
+	return ucmd_respond(ucmd, sizeof(*cmd));
+}
+
 /* On stack memory for the ioctl structs */
 union ucmd_buffer {
+	struct fwctl_info info;
 };
 
 struct fwctl_ioctl_op {
@@ -45,6 +98,7 @@ struct fwctl_ioctl_op {
 		.execute = _fn,                                       \
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 1d9651de92fc19..9a906b861acf3a 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -7,12 +7,14 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
+#include <uapi/fwctl/fwctl.h>
 
 struct fwctl_device;
 struct fwctl_uctx;
 
 /**
  * struct fwctl_ops - Driver provided operations
+ * @device_type: The drivers assigned device_type number. This is uABI
  * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
  *	bytes of this memory will be a fwctl_uctx. The driver can use the
  *	remaining bytes as its private memory.
@@ -20,11 +22,17 @@ struct fwctl_uctx;
  *	used.
  * @close_uctx: Called when the uctx is destroyed, usually when the FD is
  *	closed.
+ * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied to
+ *	out_device_data. On input length indicates the size of the user buffer
+ *	on output it indicates the size of the memory. The driver can ignore
+ *	length on input, the core code will handle everything.
  */
 struct fwctl_ops {
+	enum fwctl_device_type device_type;
 	size_t uctx_size;
 	int (*open_uctx)(struct fwctl_uctx *uctx);
 	void (*close_uctx)(struct fwctl_uctx *uctx);
+	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 0bdce95b6d69d9..39db9f09f8068e 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -36,6 +36,35 @@
  */
 enum {
 	FWCTL_CMD_BASE = 0,
+	FWCTL_CMD_INFO = 0,
+	FWCTL_CMD_RPC = 1,
 };
 
+enum fwctl_device_type {
+	FWCTL_DEVICE_TYPE_ERROR = 0,
+};
+
+/**
+ * struct fwctl_info - ioctl(FWCTL_INFO)
+ * @size: sizeof(struct fwctl_info)
+ * @flags: Must be 0
+ * @out_device_type: Returns the type of the device from enum fwctl_device_type
+ * @device_data_len: On input the length of the out_device_data memory. On
+ *	output the size of the kernel's device_data which may be larger or
+ *	smaller than the input. Maybe 0 on input.
+ * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
+ *	fill the entire memory, zeroing as required.
+ *
+ * Returns basic information about this fwctl instance, particularly what driver
+ * is being used to define the device_data format.
+ */
+struct fwctl_info {
+	__u32 size;
+	__u32 flags;
+	__u32 out_device_type;
+	__u32 device_data_len;
+	__aligned_u64 out_device_data;
+};
+#define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
+
 #endif
-- 
2.45.2


