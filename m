Return-Path: <linux-rdma+bounces-8197-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E5A48D3A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752013AB792
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEC61E4B2;
	Fri, 28 Feb 2025 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkQJka7C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DE8C0B;
	Fri, 28 Feb 2025 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702408; cv=fail; b=KbKCeqrD/tGEOu4S4TmqvPWm2htSXydrUiQV+OMSFIifLLmvqF3qqEQ3ZfC8wLBxlYK15P63kz5/k+k8MOZwvAxM8ATwTiTwMG+ciK0TmbyI8PZHaCGHhW0qFT0PSqcASiI4l9VuY2G5NOj2FaXh0JCw61NN2pi0DjIhMzeJHnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702408; c=relaxed/simple;
	bh=PAo+MgiEZLP0JaK4cpS5mQpR3w7qdsSMIL1Eap5Pmb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWKHUYvjVMOpwG4dKfSr6gpl15/PYMHgu0kXY1CbhTDIvSsYJKrbp+am+f8+TKg9Jh6sKs8hKcKYqxi/F+wZuNZ7Wc3UFEsEdiwFX6pfQeoSJ7f5gtGe/6jTKOGYx7xaG88saTj+O0Ue+d/87u0leAlEKibl4LMJsGyKC6JAnV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkQJka7C; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJie2dgVg1963F6y8X7Gg9GReGvCwolqkolez2p90v3sZHKFpJxOuIwOt8vvIVNlNAGYSgg5SVvgse9sJTKPe7+ZppnW9yFVRFb7f0Ygy7s3Io1lYflkEoib9TYwgAmAcbhR5b3jDdxB96bw8bMOEaqGI26Ah+bXHqYI/IfXvQwqkm/uuX9bxY+xXHUm+GrWJQauxJt7Km2eKb5wlIeicuyDkd2z2iwGBPmUVozNxtiBwWIkPn+tCm17sJeTFqYkkTrNiS2OnS6Rm/dsetsDvqStpAGKrTLMBBuShqtI1uVKaokgJnvZsTpMV6wb/fJal/189GRdeYj4waCoIDvzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JWGwhM4o5mqk9uoh31zMNFm0UJUKHIzMp8gryDHSJI=;
 b=R7PjcrFSk8r8Hju0r1MtIJ2w8UzrCnfS0lISY+GrijuoxBNf5AIicNMM0zYtBTyhBVWVpHFiyoBIMV/S+4XSYscuP0p6iAWty4U9W+AfMpUxZICGNdLXZX0J2pMtfp0vTqw7AACnJI5I1YMBWMje9of7d4IkAZP0wfgRDXGQiMwMZash1vTBtE4tXXKJfq5aYNwwIX6UUlo7ZpVGUb6fuTCv50RY3wOsbJbIUQFMZn+dAPmZ3M7PRpc/pDIEdFEB3XLunh5ceaQpBmma0p7ohxPeYL0fULsjrpCDil0ZVR2Z2JVl43mHpovbv6eSXKO492ew1ZxWCGK4GIn9Jr/Acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JWGwhM4o5mqk9uoh31zMNFm0UJUKHIzMp8gryDHSJI=;
 b=fkQJka7CV9wdszHzwaGm3XACzF+KLAuUlXkVAktlPUWT/GNANM8iNl3V+iIV3EY2O2Y6KIdazq7PJlVnCR5vo0fUESylRbtIj2KEB8kctBeYbZRvYqReyPEaUr0SQKcf8jYNKlYoJbMGq7u+lBNRpU/J9STq0HuU6WJgO3d95uuh8KFXWZjclQy8G/vWtzoKRaFIW2ZIF+YChkt4MGTvXxHLvM2exP+mfmW9ckB44xVf3lTY20W73HTLV88Hq5B1d5FMSbjMi8CoNcHsjd5HYx/tf7J+1e0sbePCHipfEDGbpyq1WIxAQIZtCLCSrMt7yJWLjoNcLkdAiCQQErTkZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 00:26:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:38 +0000
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v5 3/8] fwctl: FWCTL_INFO to return basic information about the device
Date: Thu, 27 Feb 2025 20:26:31 -0400
Message-ID: <3-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:208:15e::46) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be25464-bbc5-4b84-0f90-08dd578e903c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8EKV4/HqDzS+LjDNnl6NVw8hZKu8BJP7Q1MsuSd702tv4Spqg0ki1nd95D2d?=
 =?us-ascii?Q?OVYFaMmsiPe9vZ6leLJbtsOW54BGHYM9fsm5Zb3zIDmLKCbY897l9vdfeZVx?=
 =?us-ascii?Q?FoNHRFpFWCcT851b/PSVHus3SD2BDkoQ6QNXrb6rCFW1zRnDi826I6bSjlY1?=
 =?us-ascii?Q?C/jX6T/oiSqajTV/0YTYouf6dF0mKDEdVLC0c/xRR6ph15/aHnuNwVNhx8F/?=
 =?us-ascii?Q?p1mHJItBWurgpFNFexiV4jJ5x0zMtdq53FdoIO2A6DGxQU3ePJnJD7EKBVtH?=
 =?us-ascii?Q?2J++jN456gxipDW20zuCCJG7AlzfNlS6kpXV4ismDZNV7iBsZainvuuLMUg2?=
 =?us-ascii?Q?LXXOwLAHwNeAUQQTR5Oo5ZX/0zT9ipD2vyXXEOmeWL/KopM0JQ7zMe0enVrb?=
 =?us-ascii?Q?DQX0ti/cx1CA+qNOhUMC7QGM1i8mDH0EZ4WYlvenceaGbohKSTb9e6Zuo107?=
 =?us-ascii?Q?Dq70ZdmZa+yJ48vzSPz4SW7+rgDpPYE5roM00sY5ZJa/LEirmkIt2FZRKelP?=
 =?us-ascii?Q?N/hjiDcmLqhhoI/xU8jfNqVLeT0AQOvfZIg3ast9pJyLlAeebCG7VF05a5kB?=
 =?us-ascii?Q?cB2FrmO//X+t3P8SyVYzjSJMLue2+WVqMfqqkNdYkr2yswUw6/gbcFvZhD7e?=
 =?us-ascii?Q?SAdmaHh7ydu5/iXfWlb6CCRTy7Cib/Mx/ztG5s3xrUjafaEnNZ/fPmjhxd4z?=
 =?us-ascii?Q?1zJBhcmg/r+ZgPVbnfUDpSK1bBQeU0Vir6N4EvKmJnOAQQz8IVHGTzDUadXj?=
 =?us-ascii?Q?DM7L9odu0W9mytXYe8ktfMeLOkcBIF22+LeT/Vr6Lmi5RuwOBmWnwNq++MRO?=
 =?us-ascii?Q?pt7NZsbK5gDlOfK79G4w3sz5SzM4TpNLOzTQK2mCDJjF1NIQWZK8lb2TWw8Q?=
 =?us-ascii?Q?BG4E22elSouPy08rgoZhxHbHdg9xwpPOBjDXETZE1F9kFA1xChvz1fsajbsU?=
 =?us-ascii?Q?uhYdaN+WZ8g9yPs+rWvpDVMhXjA+nfNmv7WkwpKG54CvpoG5EffbC0HphliP?=
 =?us-ascii?Q?UhFn01RuqWaFTqmOHercv6mhhjj+ALucCE8GQyQJALCj2lmDY0flEcbVF+8/?=
 =?us-ascii?Q?ZIj46gL+Ra+8bYRD1PAwa/IIUREPGRJqwIfSoNiGGnH3r4plm8ddPus0TEFm?=
 =?us-ascii?Q?RpcVMlzm9haGBnfP4tBppwhuQwcL9VP+SMRPOUdAQgYJpkhf/TckqwZF4BDQ?=
 =?us-ascii?Q?F3930nz8kF3FexgCXW0gPU8bIkiLQL4FklVSNhgOqop6268aQr4N7u0cNK7K?=
 =?us-ascii?Q?4pZf+2ZTd2b+sVXgdkMHL314FnAnR1pEtLMMeETWyXWtyUqc1B0OM+M3N4AF?=
 =?us-ascii?Q?rebZnPp8y9Zt/Tt0t8Gcch4yXRBg3zmLwAcMAD7tGV0llW7itZgL4c2R1uam?=
 =?us-ascii?Q?4Egd6VWWxiTRJGRgVwtSBsmNFD4O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Vh/a86OsX2sNyoOcAu4HnIRhJTZ1my2k2uvj75xsdzJ759oQac39BzqryGz?=
 =?us-ascii?Q?ipGoEzZx0tQiXIvj3SzoK6QQmj/SJCJ4jwTlgYAbIGjNUJMKOwOiPcuWwKkP?=
 =?us-ascii?Q?dpTvqXeIYkbSA5S4ED2cH11DdyEEp1ypC21djsM7RvGbxXudgpZh4TJAwx0K?=
 =?us-ascii?Q?nPHdYCc+NqkT2EaJjSjNTvISx8D8VYk4jUeCgh8H7+T/ksM441sjl6MeJt/1?=
 =?us-ascii?Q?qQlp24EACejPJGVA9doctCddXTxahjqjAyq/vL4fR4EV81MI7VEzH1+tJm9Y?=
 =?us-ascii?Q?sgsDni2VZsMAhSPfWGzRT5NF9i1RIA6o2BxdGl3A8lURGP7/Rh9zkqlAxrEf?=
 =?us-ascii?Q?rtL1VZoS0iRvuIvrh2F5WydZ8UNnGEJ9/IA4a+hBs/FoPQMVtxkj0k/hpDeL?=
 =?us-ascii?Q?crSTVA8Zao5ZcPSaFkipGDY3ftOfEqw3ACxGjjirJAkg+bCSj4MVc2RLXukm?=
 =?us-ascii?Q?C7Z0ja4EsXOFaSmFmP0/ezKW7eL9xXcqRnF/cFrtkCvBNdUV31miTp2t+oU1?=
 =?us-ascii?Q?AlnzM4TLA4JpNw/L9fv/PIIZKtF1SXdlqpfq3YAa/7YRpFZyxT85jJKSvnBw?=
 =?us-ascii?Q?7XEZ/1OL5iGoKIVDZ7Gcq7SFZYKGEH1rHV0HodWDmqGtpHyNookAbWdV9xEJ?=
 =?us-ascii?Q?xI7ny1Y1su0/pGkDGUNAR0unrHRLzjYE8Hzyw1PDu7NF/+3JcWA5PMdRXqwY?=
 =?us-ascii?Q?5apoV/oU4mbaLgox7OEBtuNn62vby/ZL5pnMLk+7e4ZdXIHcUfvAxReIuMND?=
 =?us-ascii?Q?UjJHG4z5PxOZrJl0pv/5rOe0PYvvpKw39PzGzibIawv/dR5oNfup9y9VpOxJ?=
 =?us-ascii?Q?xCE9jzTKlJvcbMTySf5+N3YbSl1vDaniU5CWjTG57Y7LXL9tUmHNpgMDeCqN?=
 =?us-ascii?Q?+ORbeIgKTCmj5JD56sqTIQZBXrbBRMnWeqpvR8MzEGsgRYAfQsQD5IeyH4b3?=
 =?us-ascii?Q?KdXpC25YjsPBId6E67orqWio3/FoQea9/w242r11i8W6t8dqmjYqEc9E73Xs?=
 =?us-ascii?Q?Uf6kVGE/LWR77VRNEmNO0AdomYkTReSIqd+bMtekx5U42uXNktZxMNKfa+xR?=
 =?us-ascii?Q?47+zi5k0gsMNxePQvDAm2SsKqqlF9I3bcsEgyTw2ze5tBsFHcZVSwW0gxiqj?=
 =?us-ascii?Q?+QGR/l7mVJIBCI044pC2wmkGcpGpqAO253Hs+Hk0aAWZqGlq8tFoNz9YO4eg?=
 =?us-ascii?Q?SIUpBMlHweUrXDEDwey2kZwZcXpfebeWqTMacP60HftpQLVrEIgIN7/NuG4B?=
 =?us-ascii?Q?qSonkda5hSVbQ5j1Ru/8Pdv57pxSygpvH/qtP9ohiN8AtPPhutZRxfBXxBUT?=
 =?us-ascii?Q?32Q83ReFIuh1C36MYUqQUpjfnIuXnfnGBhtmUuhjzr/GZdNfmHbsLQEYabex?=
 =?us-ascii?Q?HrIE9/fV2qoclKJsozlwwgyEQEuW2eDQbiW/TR73PKDghEsIgFgU43+EPAhU?=
 =?us-ascii?Q?ft0H7AkppEF8fOowptHPgNVo5VavKO4BF0U1Q5xziyI3P9PT2MNPT36iJ+J4?=
 =?us-ascii?Q?suWelN8OabcViVz78vXo8TUN4CCpIZL5hO2wJVGwBYwP9ku4193n4Y5Kju6d?=
 =?us-ascii?Q?7mocF87j/M22bWDNp7CLqQRPdB1XKYuE/g9qDpMP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be25464-bbc5-4b84-0f90-08dd578e903c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:37.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zjex/YbpZQW1AM7BNgtGxfX1aBzZtzWMocqLjh90e+nrP/9BwgtjQUqf4i8qc4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433

Userspace will need to know some details about the fwctl interface being
used to locate the correct userspace code to communicate with the
kernel. Provide a simple device_type enum indicating what the kernel
driver is.

Allow the device to provide a device specific info struct that contains
any additional information that the driver may need to provide to
userspace.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 55 ++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      | 12 +++++++++
 include/uapi/fwctl/fwctl.h | 31 +++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 4bba6109712e42..bd84c4e5b3b92e 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -27,8 +27,62 @@ struct fwctl_ucmd {
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
+	if (!fwctl->ops->info && cmd->device_data_len) {
+		if (clear_user(u64_to_user_ptr(cmd->out_device_data),
+			       cmd->device_data_len))
+			return -EFAULT;
+	} else if (cmd->device_data_len) {
+		void *driver_info __free(kfree) =
+			fwctl->ops->info(ucmd->uctx, &driver_info_len);
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
 union fwctl_ucmd_buffer {
+	struct fwctl_info info;
 };
 
 struct fwctl_ioctl_op {
@@ -48,6 +102,7 @@ struct fwctl_ioctl_op {
 		.execute = _fn,                                             \
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index faa4b2c780e0c6..700a5be940e365 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
+#include <uapi/fwctl/fwctl.h>
 
 struct fwctl_device;
 struct fwctl_uctx;
@@ -19,6 +20,10 @@ struct fwctl_uctx;
  * it will block device hot unplug and module unloading.
  */
 struct fwctl_ops {
+	/**
+	 * @device_type: The drivers assigned device_type number. This is uABI.
+	 */
+	enum fwctl_device_type device_type;
 	/**
 	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
 	 * bytes of this memory will be a fwctl_uctx. The driver can use the
@@ -35,6 +40,13 @@ struct fwctl_ops {
 	 * is closed.
 	 */
 	void (*close_uctx)(struct fwctl_uctx *uctx);
+	/**
+	 * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied
+	 * to out_device_data. On input length indicates the size of the user
+	 * buffer on output it indicates the size of the memory. The driver can
+	 * ignore length on input, the core code will handle everything.
+	 */
+	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 8f5fe821cf286e..4052df63f66dc6 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -4,6 +4,9 @@
 #ifndef _UAPI_FWCTL_H
 #define _UAPI_FWCTL_H
 
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
 #define FWCTL_TYPE 0x9A
 
 /**
@@ -33,6 +36,34 @@
  */
 enum {
 	FWCTL_CMD_BASE = 0,
+	FWCTL_CMD_INFO = 0,
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
2.43.0


