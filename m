Return-Path: <linux-rdma+bounces-4525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D910595D083
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1845F1C226DB
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F11C680;
	Fri, 23 Aug 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cPcDbeHS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C3186615
	for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425161; cv=fail; b=AmGq2+U5XOd/hf6RcCrOv9m2/I/BrEZYGz3b6pdVuWAp3zBXndz08YuhWJp66vshD0TRswq23pxiy5zPnvCBJ6xqk7k59/RKm4kTnyPJwkSX8IKhKaACDMLQf+/5G2QfT9qPAXlctJQW0QmvUV0Dhz903hNX5VCOyhthbQBxDpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425161; c=relaxed/simple;
	bh=Rs0qMfBFRtWlhmnpAD69R4ldDbsVpv4c7CMPhbsvFiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rBpe2JNahaYjSugdwom3lpc/RxdNR2H0KN3d2GRYgKsDBxqJPa2rpspFPf1N8uaBUyQ04InxeXXs9v5prF+sBFXMDqPmOF2bPSJRKo7MvQlxKj8wJtwryIk/cvzPZMnfKmFbM2doynDRC38xBGduabkKsPE7C31roYYx8zai0yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cPcDbeHS; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8/Aksf8sK+Yp/bXAOm5QWEx5AQrp+DNCJAcgEmrXgqRd6mMyAC8sEEIhYeTVS2iIbZKFTul3To/9h/MC05Cp4W6lwMSyAETASEF407FA8+2T/38LM6uoEZBBawSdHHuxV+ri/Uy5QR+vQC8CN79nNkFntN7oEqyfNLPsK8LQeP37wasU188cwFrl/8ZkHJNg1DVHV/DR9QBHIpCAyx96CthEZpLTJF33AhRKt+dhk++asWDFUQK6UeQXzt1up/4vJ6Vk9HNyDuMOEp9+GsSprjynSgNGNefNAruhlmQmfoPdo639eu2ZQVgCbpdmA69UDIQrlOq0Z6s56ZFRHjlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdJQYOSW+aAxE+XwbvOxrIzn7VCR6TDFDfkGpzaVdTM=;
 b=Rj8Q+qOkfe29gnqqMSn1q7Oxl2veqW0iUALtE7UxJT1VAmzksqzg+mEzpUeRgFj1qLSdvtgBy7BCsAhHirApsxiUxKMwAjbvKvRjEPCocbtAxpfy2zweI2nu6OPJ4VCZDkvFCxY2wdIoGYAOMthXyqzhse4o4HTygpuDxOmBnPAuiOwaVA0ZM2tfhM1A+RR1UMT9cC58UCY2KBAdxQiw1dxPtajjd8D8Hx2wg2nh26H9ZkHIlon3zkp2QkPhA6w32sugdHm5VwR9HQP6R7xac/6kGB9WAMOhFKv4yk2At+ZAXdsDOzy9m9RJa3TY1lkPTzTziO3sOi/xNW3XYE2MCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdJQYOSW+aAxE+XwbvOxrIzn7VCR6TDFDfkGpzaVdTM=;
 b=cPcDbeHS2M4P8TxA0iu3AqXcQoLfkLpfVX+z66pfgog6v9VO/SURUN0QsX/eUgknFcNJgLCio9NphcwyrMcpSFN3v/CwPj3RomUW3JBKzowipfIpkZfuFaCrpf8fbNeelILoNXpEDlg8da0SQuRmpfd62h3gMB6nFx8N5/IZQVHgp61k3OTK55IQUr/ZSr2xiaUWy+/5a+4gx2RgfUqgBqz9HAVRiCfcxKWoR9yP7qztDoF8zxx86zEaiuxP0LARnwbSedQ1zjLajGuLQ8xDT7J0wFMtSUFwKJ0pvx2l/gnLlvuiQFcZoV0dwqHJOZikVKUiNAQdmrMTc7/IgDqYng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:59:16 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 14:59:16 +0000
Date: Fri, 23 Aug 2024 11:59:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yehuda Yitschak <yehuday@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add support for node guid
Message-ID: <20240823145915.GA2311751@nvidia.com>
References: <20240822171143.2800-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822171143.2800-1-mrgolin@amazon.com>
X-ClientProxiedBy: IA1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::8) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 464555d9-3bfd-4411-1a13-08dcc3842857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4alFQArHV4HIfgtGNCRQoFVswEFog8eRREOiCPvCfHUXBfzmvJAf7a6tGafN?=
 =?us-ascii?Q?ZPxYs2vfo+qZ53Whcs6rGWinHVkbkWrB5/f/r/jXiuc0T1mgqO4ly5UbPmkF?=
 =?us-ascii?Q?SsSLAGlMHqSIpYuHWkoVnpogS3TUPHq5YmSXVHddFHlPRY8e2haEro0uYrEI?=
 =?us-ascii?Q?icDyJl5vPuxXGAuN8Nw6F6Q4yOJCoyPCtHy/nGVtHuqlgYXzbdGhscdn4LlQ?=
 =?us-ascii?Q?L8vmN4X4J1CAAeAqQB3fStJk8TuraJ5a9cYmgL4NqQzi9NOrmtLGoH48JAmm?=
 =?us-ascii?Q?/NVcmgPp8140Ny23/E9nCf0qYwp/0iZtJeRJw6lOKJAeBt80Eil7VXufOG24?=
 =?us-ascii?Q?FWXXOJIwr70+/8Nby1RejJmEmCS+6UGeiYz53RnAWGSDBIaAwavrYoueQ3QU?=
 =?us-ascii?Q?d5/GGMGYR0mamq5a7r8F3CMEMHHm9VhiV5WHEy7UVs1w0VoHOa2JicWq7yuy?=
 =?us-ascii?Q?iEcU2BpqLcRADwdUNYTYNr3iceBOuZCCqfcmJ591O16iBttM8Y6Nh67o+Zyt?=
 =?us-ascii?Q?DhHmWacddggl6nxRVoOogore9dxVCK4v3qXiY32DFZXCkLPkvo0IEaZji4gd?=
 =?us-ascii?Q?qjISLkWIbHqr+FB8kOpT9tl9m/QfrOVOKKN2XAm+j/4HWXhOmTqeYcTDy7gF?=
 =?us-ascii?Q?Ftwbmh+grHR/awRlFZh0ZnSaf5jyI8siLzN5uk6rAWS+08No3gKI+o35NMJ9?=
 =?us-ascii?Q?5YbOosLGwoa9PHBKdINCq0XXUID37vkfAbcXr9cYobD/FQF3v8gx6DqS4hP0?=
 =?us-ascii?Q?NvgE+mc9ICoHgnwZ9eRoCdOHJ7NO4YX73BtfNcPeavScRSCgQCSsSq6e1N3F?=
 =?us-ascii?Q?NdaApy63OIHjJIBlImaXgUQZCyC8DNe+HiD8pEJscJ7e4WGV3H54ZK39S5nh?=
 =?us-ascii?Q?EnHqOYmpnj5WFlqC3gvNxTON2BzIb4iMRxCCI180f29xmDClRpabppyh1efV?=
 =?us-ascii?Q?G3CUUNRxiwumxldLrS4hd4H/6GtnS31Cjzics2N9E+qWcxDiFRMU/qpyYcXO?=
 =?us-ascii?Q?RA3HtRDRTFctzbPqHnExn+F73Fora7/zPNpvP/41I+4eLHoCJyx/XePaSa8j?=
 =?us-ascii?Q?WHSIIjC2/O0vTdJdf7LGdFczuUByaf26oAjkDQvZs25Cdn2v75dgjPwtHlS4?=
 =?us-ascii?Q?B+HF4T42QQHVpOJP0ooOJ+NHMWWraGRcvDvZr2fSPlZ5MrBXvomp1otgtBsY?=
 =?us-ascii?Q?3+cBfMI0uoDEk9YAeZ6X74WTeYsFdiXm9mfQwIXUMJS34hLN+tzOuGsJuGUN?=
 =?us-ascii?Q?8vUfY8THoi9iKAC/VIuXkqBl8SrbabrOz0QvAOEmU1WJ+HW2zSFX6nIMPwTe?=
 =?us-ascii?Q?ncwEDJseOs/lvZ90pJCZJ/JZKAtRk0+njpkrKzQuQkTPuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ix8Zlur0dD6Enc5bPE+omhZw4o9w8qCDAIYqvUkNRmrRsy2jEBsufI1r4JKj?=
 =?us-ascii?Q?pg6FxrcPYD44QXB5mUIE046QLu/VJ5yExdBWPiyD+rdFzzB7eyqqcqRCRzg7?=
 =?us-ascii?Q?HiAiKy5cfxhAxUlonrsUO3S6SWQ/B4LjT0yL/QA/L9mjPOyEvEk7J6IMyiMT?=
 =?us-ascii?Q?WZ7+PXAnZWhZCJuPvo9hwzRvXu7LBuv03GQ5FM003wCfhi5dzY2q41YkdWIe?=
 =?us-ascii?Q?2isCJ8pvNvbgMraKLTCrhR8/gr0a/PtjncskfIeG5rI0FshklVAumHf7cbS2?=
 =?us-ascii?Q?di6edFSz5FVOEiVOJoNSvIDXfHEkWxh6wKMJuQQmB5OIEevAa5FEin1jOAKh?=
 =?us-ascii?Q?gpHyhGOtHb03JcEN5YWdjMGcrB0szARl48sIQs2gyNJiDiZANLIZjYXJKWXZ?=
 =?us-ascii?Q?IzbgMTIpWTBvARhEHmcWhKFg4pjRGquUKf7pZgKrt7oi4Hz1h6jzkA+WbMGf?=
 =?us-ascii?Q?a0ZC64FC+wppK8g7zm76LIHHmWejR6B5O3EIpbE/SQ6RomP33tnmGnX9dHh4?=
 =?us-ascii?Q?5P0ai3bHP70PTjHGQAFq66nBRzKR7pbvHWQSMmjIdSOS1HMOb4x5xd6xkbIc?=
 =?us-ascii?Q?FK5oiAblrDuiYAxRutifX/708cw8fWZWUjZ3hMxKYpkvECp4tTIF1ZN7D7zl?=
 =?us-ascii?Q?y26ZFkSG4X2J8YrRMFkNmVDt1mdixDUR3k110HLNU004mgA2hBqADDPgKx1A?=
 =?us-ascii?Q?fyhUDmzH8ZBmfXGRD4Mr14Zc7cAU914CJpt44ALig/VALGzDS8jUfJKdFEvh?=
 =?us-ascii?Q?gk/ynWgmwxLrcNOW73sgkqULo7OB4dnBcbyq512NlbsLCLbP5RlMnWG0pTE5?=
 =?us-ascii?Q?iPhyk8IjFimjcCdEoB3hK9iZy2Sh4w7C2+VVZAkyoN36QEWiBVRDla+xlOXe?=
 =?us-ascii?Q?rnDXZtaZKwCv8aPSV+ykffTjWO5l2ZfbcQ62lnLeDwlRdujHG1TxmTbIAYtY?=
 =?us-ascii?Q?sGjMrI/hrZuFvBvWuDdGCLLx5s4ShnUIsEyiH9C1QxdqqywedGUN7eOVthjK?=
 =?us-ascii?Q?h8+hnjl+/vkAflxbST+nmvZlPLIV+E5AKL4j4bcLYc2sGXamvLBoZwFrhO9s?=
 =?us-ascii?Q?WKbgUhjVDC46mTpj/qPLlY/PgtowtgFYa5oeIP6pMAFCdBIK+RdNYMdsjdIH?=
 =?us-ascii?Q?Zn0abCRJFQ4tWc6M57hWImResFV1ILtXBRQVwlAUYTJ5GCxjEA0X2FVv8oew?=
 =?us-ascii?Q?PSiwv1eKOLmjwj+VAkBVuyNcpLNU8Yk4fMVnzoLNM/s2Xc7o+7CA0WfgghqI?=
 =?us-ascii?Q?VYkgNYtQWn9JlVQ2b2bfMYCzuGyZgUBskR2H9xtnZJGvFhds4ytPJ0EnD16X?=
 =?us-ascii?Q?ve/dmVBzixVHtW2cU4Gi7zr/jJ/sIoE0hLUCXg3xY2mFS69M0A4lR25J5pai?=
 =?us-ascii?Q?e6kihcuE95253vAK/RqSnvVAx4awTRMt7fgokP8phsbWc/woCAmL+LLI5HsJ?=
 =?us-ascii?Q?blEJQKiJwAXp5ByrIZoTrP8KSo9lFQQ48I8C8POCKaiYh6gTdbrluxmglHuQ?=
 =?us-ascii?Q?CPu87bXF3Ogjh64qU3sDRPdoYPPwpilIsVSE1dX30pVSXUH1aDXCqpP6cSFE?=
 =?us-ascii?Q?MtyBliWkHSjqa+CQUkmD7aymgL19bnPLGx9Xekph?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464555d9-3bfd-4411-1a13-08dcc3842857
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:59:16.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drXKL4yYlmbGraPdcO9lUCZDWUDxzm02gnOpyUu5kiGVFYPDz4q9ddBlDRDq7niG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

On Thu, Aug 22, 2024 at 05:11:43PM +0000, Michael Margolin wrote:
> From: Yehuda Yitschak <yehuday@amazon.com>
> 
> Propagate the unique, per device, ID in the device attributes to the
> standard node_guid value in IB device.
> 
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Yehuda Yitschak <yehuday@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 3 +++
>  drivers/infiniband/hw/efa/efa_com_cmd.c         | 1 +
>  drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
>  drivers/infiniband/hw/efa/efa_main.c            | 1 +
>  4 files changed, 6 insertions(+)

Applied to for-next, thanks

Jason

