Return-Path: <linux-rdma+bounces-7495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A7A2B706
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C421889802
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA322AF1E;
	Fri,  7 Feb 2025 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwSQUXHN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C626179A3;
	Fri,  7 Feb 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887230; cv=fail; b=pzNXXIrr+eUyKLYi6Mdxj65TeywKa3SbiUbZau1nTnLWCDRr/rLlDZa/ZTcdTrlAY/8o7BzmeXR6PhXXd5VI6jgMcFHAnrLwa4yelHrPkoYDtNpUiqSyKxil6gPvL8a/I79Hn9d43siSSGLEuHKhbPPPIFSvaozn/fhdpJc+2S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887230; c=relaxed/simple;
	bh=DaxHf2nCiCNDIqZjebadvmsS0LVcJRCGdMU09aiWCmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sP+g3/3+An6NubZosZYdAAgak6XxygMT43wddL2p9IMb2Xub82im3Qch06MpJ3T4PFcYkGPN7gYP1kdcgoj8/yzBytrwRZ1yviUxgIiZX5LzjbsodI48wL9RG7boCuJo/T2ByCeRknwtFIXowurQD+6p9pRIHjSk9cjO6oSIUps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwSQUXHN; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St8uovWRXAyxRPyaL+MTaWhUFvfbRtjWI+4G2Vx/vNn/rfNAT5zURV5gx5EOeyLxmTS87UpXhldeKyJSG/jhjlqj99DnbEPLCtog3IBvtZq5D9xcugX55mjZw6NcXZX6qAffh4lgnAUMO2ci6k6CZVsjiukMJt6aoiiShRTf0J1diRGl71cU3kq1KNDq70yTg45DmR1FLesJay2AwscjZ3Tki6TIDcW58d95nZyy/ahM/oW9cRxwbWj56AybsTqa7R22QBKsb1kQ9yiDExX1TFdr5+IQHbsONGREd24sUAcfxlfbluP8pnLL3QDjJYfGGGt6iS053wF9rg5l6dDylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWC/NsWtM4wqA0n86q+1Y31aWCQ0WZnylXlyEg6FnX0=;
 b=H+4Pahe7lb89kKzkMnUudhQjrx1+pfQWJozWfLlFWcyVbSlXJDivLTvf+xmhKWUjPke0wdY3tFYwDFBy2neFrCusiDKXBcgVisCtuDVT0rtN7LN9w7oeS86ZYwmGmkXlmNtLw8s4uh3hMXIfJhNCpl3d5pCQKhwocn3hN9tMHT/UVw4hEVkd6KJ9uPy4tC6EzWgpmGctT8jdPpyqkfsZA2XhaVuU/vzE7ci1xbl+Lp/S32wn6sHDWfNzgRC2GrBrBL0C11/XWNt9xyX05nb56tmnZmz9IRFTFUXdPIozot3g1AM3dBehcLCRZwQLEH/cLIZid4+F/wUPTYRqTDYNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWC/NsWtM4wqA0n86q+1Y31aWCQ0WZnylXlyEg6FnX0=;
 b=hwSQUXHN87rMJ4yCF3Tal4MFzWFQhg/bxdfKJ1bHh7hITeUNoxu/l110bxhDvQpOiT+7NNQ1qpTLqW40TMrn5JOjmwlu5IZzuWhGr31glzTlS4NOgqSSLgh6ihVvNI9MTBrliZHScYn/0n69t8NtnhREKPjENStJvg24REZO26tYHOwaqPemiBnJBAl31km8Fj/lBr9C0eybGdDoSHiyYYQnG1FsGmVjgwvxfreJiva1DjbyPqA91k882Pf3087RLM4AIpgovnT2aLhdYAS50lixLf6Rnj7NiJzffTmbfHxac7KW2q6nYfP1WTHrzEzlflEbSj5y5S1z05x4XuxqqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:37 +0000
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
Subject: [PATCH v4 05/10] fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
Date: Thu,  6 Feb 2025 20:13:27 -0400
Message-ID: <5-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6bfce8-4179-447a-51e4-08dd470c4312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XDD0pvJ54sADdrUgTMdsf0IhYO28uYc6dSS5bvf/y/rhzy2Gr+03OgL5pKhi?=
 =?us-ascii?Q?Dt3vKpiX0XIAPqpB9xV19H8mldj1I2cHCHOZaa8bBpF/2fQEVcSMSSZ8Stjj?=
 =?us-ascii?Q?zltAC8IFl0khrjMMPRqudPaju5txFfXh9SevSL/4PUiAjB++bB8jucUmpvOj?=
 =?us-ascii?Q?xCLisT98wzZEDaeRtwAPe8GrElfGuGnTedVtMv/1A9imW6lkzIDIhTl3sd/Q?=
 =?us-ascii?Q?lppX44o0H29scJJg8HtTz5q5C4ZX1pdrM5i/RKZS8kutcTYLTKugKzORJRGh?=
 =?us-ascii?Q?8rvBEkSw/JuZwn5hS+gx8GPR7L7K6VsmYyf6IaWEj/PsVSIO5owg/GDPesNm?=
 =?us-ascii?Q?JEQR2E0Rj6pGRmiGd0PHDvQFdhgfUGHSkON8AJo9bHux5Zj5me8ITyt098qq?=
 =?us-ascii?Q?wgJqhdMMDDV+i9acthPuPadJ8S8Hwafz2+si7M3V4uTrM8nhfmaG8VZf1EQ8?=
 =?us-ascii?Q?EeLINsTgGG/0XXRjNPP4jbp1DCiGcQezAv3vV7Fu3AzclFY1W/nhtKuQdaUj?=
 =?us-ascii?Q?DBxaHh03b1Jg4YDUYaYXWmOSzHuxL7pnGJwJmwim2cfmM+IuwksgX91bYYHF?=
 =?us-ascii?Q?XoNxStOGUA1fHFuBRzRY6V41z1acVw3aMsFTmZbf8k0tvd99r3QrxUjmPoUV?=
 =?us-ascii?Q?UtlfhyNCgu8GFE7BUwfj/7MHAHHl6zCV0M2aT0Kr7UJuu9MRIShEuj1H/cfL?=
 =?us-ascii?Q?o7lZwtGSlmNWQ334lOzBg7kveJOf+hyvk5biER6tUkA01g4siIl/upevFxY8?=
 =?us-ascii?Q?1v0cuJ/qP6eGc9KxrAZnMCRJ0KNRLH4X8UwfVd4/hDNiXTBHH9o7r8L4EWzj?=
 =?us-ascii?Q?wL1rPdD1QXC82fstTRb0j52KW27I6+cELoTwpeLEsgiVrCwp2QDgLWJmW4Xw?=
 =?us-ascii?Q?kbLfmP0XwYm2P1MgIyDhdHXdXa/YwfzUUdWniTTJiPAAaemnnYTCFXZfqLB3?=
 =?us-ascii?Q?orG7aTCQKkUiIvNPCP/FSaBHy0T51nhLiVSyA5S9rrSB1TUgL6GJgu+kU9U7?=
 =?us-ascii?Q?vY/0l5+wQBWCjWYRhE7hUNNtHz3uy7oMiaQGmbWqjaQbveYcBpgsVdbhRsdO?=
 =?us-ascii?Q?nAOuizGJbF47OOzpDVov/aRmJRE5JjfzmuL1As45KtYqENOPO8dBDlzCtbOu?=
 =?us-ascii?Q?bgZotWdT10t0XmOq1I5dKMtmwSJ3SERDokz1KwnGlcwVMz6EgaZDJGUGZxQD?=
 =?us-ascii?Q?K3iC9CIe5WSxR3W2n+QVXexaRdIOWVjMnTkjiqIVZp6N7WiwnpFZzuh/avO6?=
 =?us-ascii?Q?gWQapQNPuusCfBWWzFG/GAGDIZAQbtysMB1yNWPlQNzoiyuTV4VjSXO7UzdC?=
 =?us-ascii?Q?dmZMO9Iw5XffieVpD3KRp87hAD2L4Q0unRBHZojWaieF3KfA1gCc3qHQcGTp?=
 =?us-ascii?Q?9UxZMDBA2+Kj1UbgutX+13pxzyQY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJCgkkFvKxj571i0h1wv7dQhPxq+20sUF95+2UGULPeojHS/xy/QJQca5ks5?=
 =?us-ascii?Q?7KQD5AwsdaFvIiaBJnQa6vnkOR3TGn8u/P4puSaIt8N6dgNGC1BN6nWujSAs?=
 =?us-ascii?Q?/qRz5tEDxlBZ/2mS/UXXD4Nx4Zs7mAM41skVPavnrdOu1LFWM1YeySe0hUGK?=
 =?us-ascii?Q?7kyXLeC8SENekgtxcavIVpUomKZAo1czo1DT5xXxt1PtOU/HRIe6jlrgl3KB?=
 =?us-ascii?Q?I5fiXFRAwmddsm/Edhm8AJsQhKc92iuBIJqiexV6XALeDz+2Cxq5Erj0N4ed?=
 =?us-ascii?Q?E1rx2AZbk4pGdTXQgpJWPl9wVM/FA6gKq7VnNhJ/n4F8kMZsf2M4wg0CdDCh?=
 =?us-ascii?Q?YSwGD+y21hruRpYfSm4cXAIHMAgBZoH1nUQYVqZBDcnYPumF8E3wJldIyAl6?=
 =?us-ascii?Q?B7+xwKeEj/PUsicEs4P4EgbDaFk791Svy0oMxDiP4uwt/kYyZL2xDkMrya26?=
 =?us-ascii?Q?AjBXW+WBtFZ/XKZ4ZyS+qAilcGalAzGG6ks6vC27sNj5qSTP8RCMB/5qrYFx?=
 =?us-ascii?Q?ZXxjTdRULQGbkTdS+wbJpVUbeYvphpLVHX9tzRJrA1r/777RDjEG7qLJGBrK?=
 =?us-ascii?Q?Og+SxoGs+JuTnu2gBrsb1RxnqOoNcy2EImW1NKi1BKfsRNH+qyU98DsD9SQ+?=
 =?us-ascii?Q?nYwgjQRln4tE+v49Lil+xMdEJsYvs6kEYOr2ywrCoa3iDSxQwRJYzEgjwi25?=
 =?us-ascii?Q?gkbVV3IgCQKeGAKZ3iquc1E3LyNyseOr0eraUxs40YarGnqCqi6ZghzLGGwX?=
 =?us-ascii?Q?9K0TlDBWpWGkK2rAwEbq5rmjRrX1yRWEIspeVT5KaGmun9P3ov2/QovwlbNC?=
 =?us-ascii?Q?PF30nPlbASbr/fI1Al9F56nh12vjAxvbvq1UVrZQFvkWZ7KFdQtSPAX5kseh?=
 =?us-ascii?Q?l79Y/e0MjbPIsV/hRRrkJ59XT7nEno2kJWQ4CuSAbDb73UtYNUSRH4A1Bxro?=
 =?us-ascii?Q?3SO6ASw36MQ/Z9f3saTDhc4m8Y+8lt0Oaj52ZxRe4Osfbu1e9p9k118fkwsd?=
 =?us-ascii?Q?NcKrZ2wFXutKu5+6ur253zX5doquGI2/x2nmiWFMY40uc6HaPeuDdUijrxZs?=
 =?us-ascii?Q?4phhpMwDwIafPNf05kNrWEIw7p9OAnnH/gXwbSeckFjF0dQ5Lv3MW+K9L8Up?=
 =?us-ascii?Q?32sxpW3EeK7ojCZhMNrG57cBQLROJ2RObc93opawAEj+wjZa479cHw6GBVab?=
 =?us-ascii?Q?HIHyJ1/68OiasOwfbjkyUo6OIGmbJmGewt1SpaFrny64Wyg8P1bGAu9LfKzu?=
 =?us-ascii?Q?Ek5mSu6tr2Q+NBfHmmmNw3nWRoP1o9AHBQ3mss8TqVrIGXhwB4xmvvVAGu68?=
 =?us-ascii?Q?82jpQdy4KJVm3FlSJAUMahcF1IPqkPsjQK1XhQV+CAYXYMzzGNoVbXvNASuk?=
 =?us-ascii?Q?nOi60ol1onn143VzPG8FkTH8sMMzPkG7MTjaF2F40UXZuIqEF6E6uM2Al+hE?=
 =?us-ascii?Q?Gkoax4KtHaiGxc711ZW+py35QOwLKta9xgz/736Zqt9kann1yctN1T3BxsA4?=
 =?us-ascii?Q?RnawzddQMyXDWyvTbclhK/5adU+xWZm5Bxiv5EZv9UFytMFWiXwUEkWoUQKV?=
 =?us-ascii?Q?LhiUtjLZ1p7QNhF5ml/jVI0ikzAfk27f2vqQI+gu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6bfce8-4179-447a-51e4-08dd470c4312
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:34.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1Icv+eDJ9+rBLPv6A97stplIYWrTutnHYTt+4Eu1xjo3L58PS7sFp11nutr1c/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

Add the FWCTL_RPC ioctl which allows a request/response RPC call to device
firmware. Drivers implementing this call must follow the security
guidelines under Documentation/userspace-api/fwctl.rst

The core code provides some memory management helpers to get the messages
copied from and back to userspace. The driver is responsible for
allocating the output message memory and delivering the message to the
device.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 60 +++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      |  8 +++++
 include/uapi/fwctl/fwctl.h | 68 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 4b6792f2031e86..a5e26944b830b5 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -8,17 +8,20 @@
 #include <linux/container_of.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include <uapi/fwctl/fwctl.h>
 
 enum {
 	FWCTL_MAX_DEVICES = 4096,
+	MAX_RPC_LEN = SZ_2M,
 };
 static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
 
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
+static unsigned long fwctl_tainted;
 
 struct fwctl_ucmd {
 	struct fwctl_uctx *uctx;
@@ -76,9 +79,65 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
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
@@ -99,6 +158,7 @@ struct fwctl_ioctl_op {
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
 	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
+	IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 9b6cc8ae1aa0ca..c2fcaa17a2bcd5 100644
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
index ac66853200a5a8..7a21f2f011917a 100644
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
2.43.0


