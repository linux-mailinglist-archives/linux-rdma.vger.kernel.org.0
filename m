Return-Path: <linux-rdma+bounces-12914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746ADB34A1A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312351692AC
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378CC2F28F2;
	Mon, 25 Aug 2025 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gtJd049h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064430AAD2;
	Mon, 25 Aug 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145975; cv=fail; b=NxNNbVXiSgCRtrOcbZVKO4kFlI9XwdKznaxQYqJ9Z4MTG7uPFB5Nal/rKZh9zSid/SYQm+J0w0UOHuXuMhC0k0OsRzUbK6sFuOWGv+L8w7mbhK2Ex4vGWRN5qzfk1ejwdd9Ij970r91sLI38/febUSQTbQh3iHKFefyhYRlS8e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145975; c=relaxed/simple;
	bh=kK8PYdfHMaVzUeo2tA5cQJ1PIPyoZP//ijK6i5V6xWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWIBiiqtHETHL8UPWm7yl1DTBye49oqzzkfNUcdzQXvkeW5BjWUyu7qz95ldNoGWsLwpuIEZhOkuhbClAlGP6PaHpAoxndIZRhyRU+8isxzySRmmzwT0uqF7oiBiFiXcMhmDvQ2e4D4Ntb0l2MPsfHNZKX+1kgzQ89xmIATtVR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gtJd049h; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCSpVjaHhMEyk+WEeeZ6nRun9jScMb23thfj7LJvXwqnq4i0qhIX3KavJ/W22txCaE8wCK4Po1Kg+bWteLidhSl9+mvisJdaIDVJlMC6YFsCPgpVJeg1+DwdTO9EJt8MRnPFBJT1gRorx7glzF/CxlXjaQlQpvOTB28ijPsQmZ3l2ZGAHEJ9TwKgRUpudZt7Xo1rVMiBKheFg7I8Wrh5vbX8tQW6HDxwRZwlhvUA/rA1OYCWcdvulaEV+EZuthi1LI7OTzadb8hlj32fCyuowMsAcGucsPOmHiOZhK05lsI/9bG31vsxjZxRrL3XojrB/Fy6YHp9NqUs7tCnZiPwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR2mwterbF85rODRYkfFLdATSAFn4fPc3sdXCcIPXFU=;
 b=nLnWj8yAsZOXkZt/4bu5D3iOv+FPjyU2bIayQXMSH8N5QhU2TrgTBUFkGg0sb+Ov8wbVpP59sbc989Ghv8k8QUzJklNkKsoU8t2YoTRxarQGs0iZb5IvKEC0849LvRFb3KQnwQiEGnNUKwJujuRJceYQHBDfe5t4PWCJKzVezL8XbTes57C++trpfD9FQ+FREYal5x1Se4KiQJ/Pwkrfw3a38LlQTBx6220VAxMqKHGPDP91xaB971VuErRiiyoyOQ2fWBeGF3221heat62uf39ZxjU1sZMv3KKUAb+UiZED7aJwKLwswoWHQr5wRTngSTQalEMnN87cFfqW+XEhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR2mwterbF85rODRYkfFLdATSAFn4fPc3sdXCcIPXFU=;
 b=gtJd049h/RMrQyQpnMhggJCLurVOgIkEAwt2v3Ycfe4QGsIdG5mNvCUD0WaJpqzfmgmVoznZVW1KGWGZxbQ23vjLMCP5Icrfm3qtSNDWBvaV3RPjMhxN1FDiJ3zKCLwgRN89ppdzLheNcu4vnWbf0gUXXCa+aixo5ALIAj51H0XmT2WQgJF8NAzQ4Wa7TVST2zOi/3aRLIZg9oSxuvQYxUNI2/t/ixccde/xRFGkQce/Zzy1xj2sdPueffCOkpflElDsxza8q+TXKLJIIVs9wRtZGG52cau1EdT6esjjE1sGOS4ae5J7A1pmM7mfxoXtkIQKxEav81DjxzyH/PWqRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 25 Aug
 2025 18:19:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 18:19:30 +0000
Date: Mon, 25 Aug 2025 15:19:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v2] RDMA/erdma: Use vcalloc() instead of vzalloc()
Message-ID: <20250825181929.GA2088087@nvidia.com>
References: <20250821072209.510348-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821072209.510348-1-rongqianfeng@vivo.com>
X-ClientProxiedBy: YT4PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a0dc81-fd9f-48fb-44ef-08dde403ef1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWtEY6YX14i4Du8tJeiQm+QD6PWe5VRaUW33OgdGDEqcKkhsxg6Iad1C2gWW?=
 =?us-ascii?Q?qdJ3QQmOld2NSoz4HEHYIneFKTMvi3Ze2DdqnIZrcHW/sfj3LSptwAy92NTQ?=
 =?us-ascii?Q?yTxBsbWM3P8HJ/NJSDdbXT/SziN/kfVtFM3z6e3+liEGKTlvoKyfwKStmybS?=
 =?us-ascii?Q?OEcKUxabapSxLp8LWr6NgEfX/Zv/cy9Xu5IS+oe90Thn4eSVqy5Jd0INNy3Y?=
 =?us-ascii?Q?wwQtWXC5e6e2K1cQg6I8+bXQ5FBTWcq7aqjhkgL//P27vAb5VFiGDX+w/b1b?=
 =?us-ascii?Q?A1fUuYigLiEfMcmjuqpSH2/Qai7ICfbGZ+VldxOtRvpEwnBNr+PEys7FYLNK?=
 =?us-ascii?Q?m63U7EyYlaNnh+z9tD8orKaLmqFHwGAtvCe6NLRE0BE/qWRoGfR6O5e2zK8s?=
 =?us-ascii?Q?QNFCEWD3CQNeM9twxCKsq4QeZT95bNQqgC+FU1OPKsAF4cplTniZjOJItHFq?=
 =?us-ascii?Q?8XwTiX2lnoFL6rSdaBxDmNtgY5LCUbF2/mtXqZIgSrIfX4o//WAtmC5WsdLF?=
 =?us-ascii?Q?FJVfuU58mtsTz+wfdbtBbNCUduvxFlLA3TIMuE2nm2a9+ECp0JoT198JNVmy?=
 =?us-ascii?Q?sCIxLDMidIJ7GtfaCNTzUDKJYEJBCeiv1eJdz0FSk7UvrGMr/cm23vMLlaA/?=
 =?us-ascii?Q?qM/KN20y8hPLNvTPPnkW5sNp0uvI1X+14yArDjz6fCHOfQWprGphS9XaK0uf?=
 =?us-ascii?Q?OnBuAemxox8+5XuyQuYN60765UhNrsH5AHKXxZm9s9t002FHBVTxUURoHYEG?=
 =?us-ascii?Q?M43x4xbm8ngEno5DZf45BYD9p+mZWX1jXYAei4+0yX3twAg0Fc0RrobGjIx2?=
 =?us-ascii?Q?Ycg0lh0xK0JhJF+LGGvxi30qqw8rPYIeL15RZp1sYG4FJxQqCgBswTuVweNg?=
 =?us-ascii?Q?bWAwqk8Ztk1AmdFTNMQBLJ8Ni0Pe+IgZHvpj1xPx9qDwExL8KMV8rTQpXwFB?=
 =?us-ascii?Q?BZS4N2xr2c11gzKop3iaN+Q9asjyoP40twNKHEmXtlNfnKVhYHd1SaAY2zKQ?=
 =?us-ascii?Q?/BHNkDJpB1NP5GwK5MsqsZgDPpVaCYLeyUIBwwV9YpI/ykhDcYtynSUx8IC5?=
 =?us-ascii?Q?Tmn0/VmA1tC0IKCXSBkItX9FNrpiNc09kJUcjPLzkDV69OOJnyjIf8sjjo24?=
 =?us-ascii?Q?J2O1GyZT7O8nmQOBF31Kzfu+ev6KL9zctDdi5ZlFPZdLfoEwk+Q6UlimWNf3?=
 =?us-ascii?Q?TSuzh/iRLUTpWsld40wlHby55lIygxRCkgtp1HRb4pg26fmDOYYjq6Wnn0wn?=
 =?us-ascii?Q?j6WRNCuHmLXDAQAJ4RUYY8eYYRpgRbhfOugjlm/KAQZLqMSJ/E0C3hxQ6EJ/?=
 =?us-ascii?Q?dwX1QVLcI///aiqsQdiuGKyhUA+Ykj3o3N5YoiKELVgUVMkW9WAJo+PhXrw0?=
 =?us-ascii?Q?ONgeC7UT87tGQe1Qsr+oRkzPydb2sE9C87BCFG1HaMqtFM6X7bdH2iFphOEz?=
 =?us-ascii?Q?QlJSiNcWezE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERInK/XJUOb5GBRHjDNLR0uQnylU/bgskR86/Vo4Q2Ua7sZFuJzp5+8JNLrs?=
 =?us-ascii?Q?dm7lbV9fNwDzRuIp/lQtFG1irqCG7HnxA/jubdx+BP2xYuj+J8WwkLNDdRfA?=
 =?us-ascii?Q?YgECwrOE1rUGbCbUCFu3bxoAj/lJxg8d9vn05WkEowKuryBJwjVYz8zwzOZI?=
 =?us-ascii?Q?nIs8f2rkGOrbCVQXNtcMRH2fqRnd0ZK688WrNkHB5gb4da7VkSyczq1s6eDy?=
 =?us-ascii?Q?OCbkK3KoagUG1iYcJlEa5Lst2bfidedZlvagbNW5Hp+2oIazJU9p+Noi8DkQ?=
 =?us-ascii?Q?RmCecIcEVnlsVbSpIQZ3LEZ9DfcTp5/WCOfY7jXB/oTLp1pXBY3epYSyev+g?=
 =?us-ascii?Q?97+vt0yakhY2MBFqvMWFkEtitT2ahHV+k0bQIpym5VD5iksVOgSgxhnwF664?=
 =?us-ascii?Q?YWayjf/IpwNbSflHAGeY3kIVYz5LAPiTjKmyDqWetdJ3dmIVxYmFJN9+ob3U?=
 =?us-ascii?Q?yhBOMfQ0puCX8SOEtAeuFWQeich2LD/gOddGAfOhoc7iThl9HfnqCdIvRx3K?=
 =?us-ascii?Q?wXCwe9lovkAbYOs1ET5mxica9gH0AnlLx6rqpOnpnZ3z0alGnCZOT4/mrbr8?=
 =?us-ascii?Q?074BSnXtSzIdTvAUDnxhm0wXvq72HdKeL/5ho8QzPsGWiTwOhvfrI77WJsoj?=
 =?us-ascii?Q?tL2V1g+UceGXmCf24W3E99yhXd34wceAI84ysU4J2X7BIpxzpVnc8gkGkISy?=
 =?us-ascii?Q?JVjmi5mugs3ZqP4QMfwSV2IU2BRKVgoG/E6Qscnuxq18URaYZ9wu3I8HCYQt?=
 =?us-ascii?Q?vVeGVkTe9ZRdPWZuc+5K68z5jM3vUKv9NS+IQweVUQhm7i1huvv/cjuPIidO?=
 =?us-ascii?Q?KBfOe+l9j2rsnHtuAXskf56WewJ4xoUyrHYcYnU2KJ7KXrWaAK7HhnHQt5/K?=
 =?us-ascii?Q?CdymwblES8qdILqwGC5HBYNdTvEJXMQfMDk/ciemFCsUa+6L3P8oXZT4AyhZ?=
 =?us-ascii?Q?hG1IfncCiF4yvYu+FNIQnlt919dsLVo5rKaGre1hKV6SNenKgiOY7DQN25IB?=
 =?us-ascii?Q?EmfEulwanAzm8W3xZRfG0ua05Imo3/zHnPfqA1C1dlT+ugNQtHT064hxjn2P?=
 =?us-ascii?Q?KyG/v3/1BWVLXF/DARA5qmM7zFKkhmZbkkoVrUZ4X5lUc4cePQ97NbEQsc+H?=
 =?us-ascii?Q?Y248azEIW3tFtffM9idHE8MZ6IeiVDg85NHHX3rBzDyisv2NJXwKar7JHkra?=
 =?us-ascii?Q?myVEz9Tl/3kWJm0YZRrMlCPcmQG8DhrTf6tz8xFt8FG7GLxXtkLW73AgNNZf?=
 =?us-ascii?Q?t1vOq035U2mANF7DA4Fl7Jm9ZAnLDb0c/xcokS3k7FEARysG+deVofE7M0Cj?=
 =?us-ascii?Q?f7WneYNQvMGcxgeK3/4WpvSF1YucQirgLsXnM+ED/7XZmxUimlkNTcGMULcS?=
 =?us-ascii?Q?CsL0y9d53GuNEYCZKldg42QVuY9TwynP+Gng0LAV6eD4XQIbAphI33XQ6ozn?=
 =?us-ascii?Q?bDmEXbLHbaK4x4KbHn1Krrp0jKEHhrINY6vYA6RMPb4cWHUyFE+ZJYVlzKGb?=
 =?us-ascii?Q?yHyvVKUQVUbmKSSQs3zRNKbblkblyi6rHqyd47SQK+6AEskcYKwlp4v4tUB8?=
 =?us-ascii?Q?UvOhL9SnnCNmHYxmdYI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a0dc81-fd9f-48fb-44ef-08dde403ef1b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:19:30.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSMRG+gAZz3yXcBtRS6jOSOCC3kuOeddXipUcGvaN0nwft3Ocs3SkaTM3RjUreaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316

On Thu, Aug 21, 2025 at 03:22:09PM +0800, Qianfeng Rong wrote:
> Replace vzalloc() with vcalloc() in vmalloc_to_dma_addrs().  As noted
> in the kernel documentation [1], open-coded multiplication in allocator
> arguments is discouraged because it can lead to integer overflow.
> 
> Use vcalloc() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication.
> 
> [1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
> v2: change sizeof(dma_addr_t) to sizeof(*pg_dma) to improve code
>     robustness as suggested by Markus.
> ---
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason

