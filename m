Return-Path: <linux-rdma+bounces-9498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E005A91118
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 03:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626DD44719E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE24188587;
	Thu, 17 Apr 2025 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQwfz3Dw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E613DB9F;
	Thu, 17 Apr 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852987; cv=fail; b=T4OvCIZz6pYtFE6aM5IKOBvoch2UceWSvo36FFNDupSKasBkNu9l6oSbfokAmkRzR78ck+IYsV970DIrumOwtJrYYuffza1mk59zWGwP/n2EFuW3kQTWJ+ZOrcr2XYQZ3y5Ynzq1+ELdd6x23uMKpWjrl8ujkzP4O8w2ZHTrf/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852987; c=relaxed/simple;
	bh=d8ClzDVpkx7PAOV7DmFlVjX0170E5NIGg6qPdZWv13s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwolGUdyGKFrrzeOhuTVsxwtdTQGNQ7H8BqSjhLpveW45P3pV87YylXPafcqHT2zkzUHPqovITfuy0IbhYIVs+Il1o695E4VLZD9xvc64PLrZ2nmg/UR85gyYxaNJxpf+b/2VAJhjDSp91IhyUYH1g4xa06PHpjBzn7tO4oWqyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQwfz3Dw; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOqvkYRuj8J2UCLaFD1WO1q/9Uvj9ds6gyTlBI3oEOUCiQKMmdsjYPRD7Uhcu53/SdGE75sd+TCOrwTIfm2D/mv4EHEVPXe4aOAVkahw8kb/rgJdwmCwXuM/fizGDExfxMKeKWnXoprxymMePw3rq3CpAeJL8z67Scqf64J2mAov+gIL2bVd/+Yv/+/tjEbc0PGh+5zLF4WKwQ7BlscVXB3Xf7PxUqBPe8XFLglGKhkixeNO1WOgUdk+lJK7H4ak2/Vx4zy5MQQl/zK1gYDxPx48herg0yH3rmxEFQhJp5bYTbgpZmwwDsXEgjWOCCy/uuvL7jhC7kKi5bIZ5IsSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGlbGhociCFikb6qLDkIT0P3lRHRsYjoJDfLQY9gzLo=;
 b=TXAqMKuMCioy+BdK4XDmCxOB6cdToJWfment7CVI+hFSiSDmf5yBVEbVSjwfVjKCGpyVbyZ8o+uHJapClsSgqUUXCDwDe2RssFUxPko/K7/Ien8FwqdbTCLKQ5/RfHWBKbS0Ru7n4/oXysolOLZf8pgeVw1zOamsL7rrpnl4LPpDBwCx/fYBrrR+pHgOfKnLKj+hDOFvhb0MX8SLZMaAIg0Hco29Ro5prwzE0uB+Lbi0oV2iv+snvViHN0gqoPBitqodtI6moX3S3iWfbY2WgewKqMotOBlJn2P4qHV9oMaQ7ldntp4VmXpXOLxmjg2wl8nne4IGBLlFxgP77+24eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGlbGhociCFikb6qLDkIT0P3lRHRsYjoJDfLQY9gzLo=;
 b=CQwfz3Dwk729Q08eYBrVqaCq+RkpoQFwHUBO8p9J24fx3DBjYqU/hNh6nQRvDEArpFzFdDvMzziezRtFg9kt3d+RUOW4Ea0Vv5ETtmrge+a27sUyvP59vkpIQzhK8bs8kfyegiNxrHYNu/X7xZeG76dnCoHxO0m4L/c3+klnrqqeGNI8ggmpHhlTG904UmhGfjFYVIeZtZZgdU4Bg+I3h5qEcQPwyWRdGof3/RNI1P75wBh0ht1sooIiaXtYSJSJybE5N4n8d+jVoh9+INLF/2Dktv5k8Vq7vJJn9Q0Cl+PIzflZyHtR6oYy045U80IVyfBi2xT43eBzaJeBuO/ZKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 01:23:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 01:23:01 +0000
Date: Wed, 16 Apr 2025 22:23:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: "Ziemba, Ian" <ian.ziemba@hpe.com>,
	Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250417012300.GC823903@nvidia.com>
References: <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
 <DM6PR12MB4313339425CB8921299AB9CCBDBD2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4313339425CB8921299AB9CCBDBD2@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR19CA0022.namprd19.prod.outlook.com
 (2603:10b6:208:178::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad908b7-be49-4721-489c-08dd7d4e6550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3lJjGIM0d7FLjPnaIfdWTzmeY36YQTy8WZskvFmV3lCBgUcrwId8zGDxbO4I?=
 =?us-ascii?Q?/Rjxlh78FGEZTKrIxtM4lYQQ1MkuKipdcAZVQmQUNUb1ZvxIeFPb1a2ZATY7?=
 =?us-ascii?Q?98dy/ygDQNPcQY7HvtzdoksT5tyga6vlnGmSIvCRCzQo+7u2vl7SG1F5JaUi?=
 =?us-ascii?Q?TSPiF3YPFgpUcKYpXCGDAWBwAuMA2NG9Is2+8pO0nThJF/NOWlxYZJ0U2lun?=
 =?us-ascii?Q?eYps2URtwLvlJL86qdQsZBqGBF5sfnerMS0krfVD0EX2u+b2gJhr61IBaKvk?=
 =?us-ascii?Q?igeobomrCAjqcVo+aUH6RUt+70/aog3m8W8BSzzUMOKyWjVYRlRpdiSZsYcr?=
 =?us-ascii?Q?KzVu2FRFoWSPw990DfHmfzI7oeK24a6uhdHsLLB81epwVDZpLqtM5Q84xFCW?=
 =?us-ascii?Q?bL6FCKDaIZyQ86IihA6O8JGajQEvz664yWlJ4ruB1SUaNXlYuxQqY/drSAnn?=
 =?us-ascii?Q?MizXjrbNyBRhsdoBqJGCg0I2TZ7zfkSBqQarVj8JNybPQfh/YtzwpdJFkyeG?=
 =?us-ascii?Q?WltnMHb1zuJ4HvODTwM3eYiZj2+MGT+ncxV4iPLfV8bC8iFNimBxk2xuXYo7?=
 =?us-ascii?Q?s2ZhsxmvpfmvMzzG02gbXodegOUaY/Y8cGSkmIbDgwuqvupocGG9m2/tV6OS?=
 =?us-ascii?Q?sn9rCiBmfo7j3JF81VQgD/MS6Mk3qdJ/uGUNkasmO6PYjW2//49OMah2FEzh?=
 =?us-ascii?Q?IAaB8P0tAA4NqCPKrhTTnW0Tc32vx2Y55NgyEE7Bb9Ql5/sOhEhXLJY+QD+s?=
 =?us-ascii?Q?DV60VhHnwwdS+T4PHAqPDPWVWa7To7gDjG8/bd+qMFQW3NfxRW9MGxrR9YMN?=
 =?us-ascii?Q?njXXiKXki/Rejsy0CExtMGX1tFfL7zIW2gM7QKRA2oqkrru0PtH4VCvG9i/f?=
 =?us-ascii?Q?5ZJADOaC60JA20ROtvhMRCE3TBn8KcvT4mNJ6oyX6KldIi4C1I+L5ZEB7DM3?=
 =?us-ascii?Q?APj2bVbF09k4tvkBoqWV4rEo2JXHqaTMUfhVPpnKnv2NQKpLUt6o05NWs2Od?=
 =?us-ascii?Q?6uuClc2lT8e11Xkgy/R1ROWEzsCkJJZ2O6oQPs/s8ygF2+wZG1t/ai1F+Nsi?=
 =?us-ascii?Q?OaOdfefgxcAfq42JscN/STUL7OhdTLfTps9w/tLv6vIFQO6qiUgw+aHlacpU?=
 =?us-ascii?Q?uDyK8835PijMRcfKCWz758ztHTmncZmgQ03sMpiJQ7BJZHUNGMgnD30tqNhe?=
 =?us-ascii?Q?exXEHeYv52CPvqzcZyqOiotewNv0CLL1VwLoWniEkhf5PbwIBN8024IY0f5M?=
 =?us-ascii?Q?Nl86RjUHTBP5hsp3ypD8r+5o71IUtbAOCeZa4CtsSgEPRjx+r7cnusgEOI3r?=
 =?us-ascii?Q?P+yXCiQqapobhHOF2t/N06Dg3b5HRwjtxiLoUydESwqjI0xuSI8AbcX7Dyb/?=
 =?us-ascii?Q?JucwjbOF0GLsMYb/qvzNuK2GhsHk1xKdDQ0or9u7h4qib0Df8UWQjD7HAuzG?=
 =?us-ascii?Q?wenmeezbIaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcfzXK4mZTRP+TRAfb0IEVyT49IBCO4yPd+CB3VWHKezRgb3Ek6cY2sbEG7b?=
 =?us-ascii?Q?23K+hu70aHFc5i08UBhdl2LfHnKly4kHbAUbeiXeBnWzdV57N/YBcHUdiMDY?=
 =?us-ascii?Q?icDSHenAvX1C9Yv3OjTynshn/QS7XTJ96f+qbdnP0J4WZeN/M+zHoEL1S8+1?=
 =?us-ascii?Q?4Rlre2uSW08m30dx9MtBgSZF72GHvBdHwjKxlF4+DYO/1eus8wlNats/9kbo?=
 =?us-ascii?Q?5fsfgCP57ixfbnSf1103ilsHiN69BQ5OA5mgC3xVibH5gva187Fj2pdzYbVM?=
 =?us-ascii?Q?Sok31cBxVNd0IzU/hIu8hqwA12IhsGJmFmf1Zqg77ePjaaDAlO+4HJaCORIH?=
 =?us-ascii?Q?z1j5Ikl8STTawa54spyUaWa4WFz1seEFgODOgHcIQhhgdXi9s5xMg+YeqFjH?=
 =?us-ascii?Q?I9+yUWCgmCGVKRW3K6KU654ISbqHYR8WS4oWsux/US6GOJdOTwJiSFaRh3ve?=
 =?us-ascii?Q?x1eWF7d7SPl5olsE0YNXirj+4Dfbhp1WUbpxUAgf6VetwH4kSI9dTnkDsRYa?=
 =?us-ascii?Q?ijJqen7qP2DL7x1TGhp8Xns6EFBOpdyaGMRe0cgpyojKNeBxMRgCGAl8eW6c?=
 =?us-ascii?Q?/l1ALvcutLdDQK0maviwmn8kuM5TkCBVl0iQG2n0075tIV/eyE8Bk/z0R+rw?=
 =?us-ascii?Q?pnUmWgUbz5WWjDeQBrelvHgzST5rt2kuAB8pmdmMGNlFb+VGDj+go3IHW1WW?=
 =?us-ascii?Q?/zH9EYh6hxWP5mpMzg2SghmKN5J+n9GmD4a8A0lUDOkaYHChGvVTyQyFmyO4?=
 =?us-ascii?Q?NdqJmwP6yKzdza+agO289YqikqH9WyFKfSm78cugEjz2PrEUyHN+qBHKGrxi?=
 =?us-ascii?Q?C1yr9UM/5/1tU4HwAhV8Sh4YoU+pRDUG2dGUHqVQuS4vOqOuEWiJ+Xu+yc+n?=
 =?us-ascii?Q?bwMXCkC/LEGLbCDxo7wCLChDsNB8cIh5t9jh3sQ3Yyn+bqKQYsVQSPxA0s92?=
 =?us-ascii?Q?RjbvFq8sQ1LE98/HPVesa+Rdaf7hmjztLrQXMf2zNCQ7s4XF6qwosBp7y6v9?=
 =?us-ascii?Q?pkX1/Ll1tGwDn92/goFqCyfxm0Llwd908bkh+rMCW4oW/Sf10FJJhX9PpaT5?=
 =?us-ascii?Q?7ubzX6uzqwFiZdTkSogzsgEre3GwtsqdnPpkTb4LrqYHZxKSxoL/fZG6Gd93?=
 =?us-ascii?Q?sI63alZwgcVT98f0szX0Aua7UGjohx7ukR5kQ+GvAh/C9OPnpV7ILXNymUJ+?=
 =?us-ascii?Q?65N3d/rm/0cQe5G9lUTJXu8LPgBdJI6S1c+k60KXP0Vl8PzulIh4AShqct/I?=
 =?us-ascii?Q?kSn28s8QjJ8425CAflCeJ4i7pdJkwdd52KtxbEoWkLwWnfZQzR955vkYXlSc?=
 =?us-ascii?Q?oicSaWdj0cu9XORT7Nn0aDH5YN5w099ah4bJyPRlMzZSyz1K4ahvRVWtn+ym?=
 =?us-ascii?Q?BCbca2AebqRy5ak8z+iVoPQlohWHFvpg3o5WIZqrgEhgfA0u+wPjlwEkT7Pr?=
 =?us-ascii?Q?m/H6t6GizfpJQ1ToMQ23mqbQPh4LezatZddhRZw5IbEqnhMPXY1a7MuadAGW?=
 =?us-ascii?Q?XHDeynpWmdAGvFwpLe3us/DwbFnZMR/6z8fUq/ZGYyZHuDeQZSZP/hzMsjYg?=
 =?us-ascii?Q?t3ZBmHsaSEdI0vGuwHtvOEyXtxDczKHLcRtU7C9c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad908b7-be49-4721-489c-08dd7d4e6550
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 01:23:01.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+8NDWUuFNUXARhVocb76jGzjpMNMGdKU6owg4d3dTftoipqd8peVGakLF5OYwpk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

On Wed, Apr 16, 2025 at 11:58:45PM +0000, Sean Hefty wrote:
> > > There's discussion on defining this relationship:
> > >
> > > Job <- 0..n --- 1 -> PD
> > >
> > > I can't think of a technical reason why that's needed.
> > 
> > From my UE perspective, I agree. UE needs to share job IDs across processes
> > while still having inter-process isolation for things like local memory
> > registrations.
> 
> We seem stuck on this.  Here's a specific proposal that I'm considering:

I still think it is hard to have this discussion without information
flowing from UET..

I think the "Relative Addressing" Ian described is just a PD pointing
to a single job and all MRs within the PD linked to a single job. Is
there more than that?

"Absolute Addressing" seems confusing from a OS perspective. You can
receive packets on any Job ID but the OS prevents you from sending on
unauthorized Job IDs. Implying authorization happens dynamically.  So
if you Rx a packet, how does an unpriv process go about getting OS
permission to use the Rx'd Job ID as a Tx? How does it NAK the Rx that
it isn't permitted? Why would you want to create an entire special
security mechanism just to partition MRs in this funny mode?

How does receive buffer job key partitioning work? UET will HW match
receive buffers to specific packets?

> 1. Define a device level 'security key'.  The skey encapsulates encryption attributes.
>     The skey may be shared between processes.
> 2. Define a device level 'job', or maybe more generic 'communication domain'*.
>     A job object is associated with a transport protocol and these optional attributes:
>     address, job id (required for UET), and security key.
>     The job object may be shared between processes.
> 3. Define a PD level 'job key'.  The job key references a single job object.
>     Multiple job keys may be created under a single PD, if each references a separate job.
> 4. Support creating MRs that reference job keys.

This seems reasonable as a starting framework to me. I have wondered
if the 'security key' is really addressing information though. Sharing
IP's/MAC's/Encryption/etc across all job users seems appealing for MPI
type workloads.

But is one job key under a MR sufficient or does UET expect this to be
a list of job keys?

Jason

