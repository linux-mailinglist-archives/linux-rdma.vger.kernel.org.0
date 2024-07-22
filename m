Return-Path: <linux-rdma+bounces-3931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BCB9390E0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7821F21D4E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E716DC18;
	Mon, 22 Jul 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tM+eF69i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732B16D339;
	Mon, 22 Jul 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659436; cv=fail; b=B5q0sQ8RISp0sF/orAa3I4IjfhDz/vW1FSOjc98xY32RFhYVO/zJPALKNRqSQQcmBFmBqUvaKExByrOP5n6iBdl9ODMHn2o6iCPpmuIMUmKFNOdW9lKc60x/UkikdhSKthXBpHxcO7vUSNNhz7xY5kAgtTDMNfzaXajuFjYm4D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659436; c=relaxed/simple;
	bh=n3rIsbIzl1g5AhFtKy77+whLaFZ7D1Vz4MSMSFm+Cz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lbykLYvWPJZIpYN1RVyJwvmggvbMFMZQkunGfrV6G724WlanMhADykT34PFyYYWjbc5kF3/l/wu12utPAoB155EUo9huTt59Ha1SMyfY3k3C7LhtuiI2s6I3nTrs05vDU3d0Oi+UMIUf0toVwZ4PPW/HcdX4sw7JUeLMZ9xUeZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tM+eF69i; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rp2FXmujC4OuKZOPzR83IgJxxO8oAJ8WN3hrDf/0R7jYuAT2iWn/Dtn4OtiQHA9q5z6mA/l6NUiB+GDw0QsR/HPln6Af84V3nb73YNZjdneiqyElog5lvWoqnj78rgEkenKgR5C+1u5sBpivjfvStXQD3h/09aSjLDiWYB0+0n4WAdRsac5goFW2wT0666P+D7ioWW65ahiSc5Ae3znRx3JH6W+0x+1vvpqQi8CfJcjJ0Q6Y1fMD07s9LANQLUj4uw1XSLyTmifwUnu0tclQ8JNOPxxY93PtiIAWzy/xjIdlcknkXCMkvMnFyNFwxXLMMl4wVogh8CuI3NetbtIraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62EYVZhcknio6n21LqyMCeiNFAARtHWxLNYwFAhpFE8=;
 b=EZh0zk7Eb2W59hzCDhuh/Bc35bovjOwCejtTq9b6iNmt/RhdjftqHWsLMe91Qo6NSfTCKvbHJWJ3lQxcVl+UA8CYrnYkxuQ0trkfXx4dVPOgrelc1fLJe+wEEzKVMX7/QzrcweXeR22slnrsiDLLBgF5q1H73F20QWmGIsvvWDkAF/LeZ4n601vO00NLP9TTG7CeZyRcrfRLx6QuyqKeY5bTZ0G/ZBq2qunaKODr7evBs/aMQ0bftE811yBpzNLoaW9G7t/4JJnqUxL7X8VELF1Yoty2NGjmAB/p9O56HjnIXZSCSI9lsyaN04JpMalKX2D7vvarccCHSWfFsLedwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62EYVZhcknio6n21LqyMCeiNFAARtHWxLNYwFAhpFE8=;
 b=tM+eF69iS2oYW8HamCPhWQgJLGztQD5HvuHWyaSRVAIU2UuKlHz+VMF8S8duIrGqL+I3MJ290oAeQiCT7h8uxl6inWh7LIRC61YMj63h4+59/iD/kqVE/gyxyQX4CficH1Kq32r4Jy/kEx/zyO86qSe8vc0olZaieOUny42HZoAX1h+8JLJCdA8V3WpLd3HaEm9qlOGdC3pwJKag8zKlIgEHnW/hG5iozC3inYSnsTSuurcABbRqMBfyDlyupyq26AgAEKBCVGeYm+5toLW1VNS1u6Fw3lH2sXdQ+NM2DexOThEOfdHe2eMvDRhpc5hPGUvhlrSoOmUqiaVHvOT1AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 14:43:45 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 14:43:44 +0000
Date: Mon, 22 Jul 2024 11:43:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240722144343.GB3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240721192530.GD23783@pendragon.ideasonboard.com>
 <20240722073119.GA4252@unreal>
 <20240722085317.GA31279@pendragon.ideasonboard.com>
 <20240722104407.GB4252@unreal>
 <20240722111004.GB13497@pendragon.ideasonboard.com>
 <20240722132828.GC4252@unreal>
 <20240722141343.GH13497@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722141343.GH13497@pendragon.ideasonboard.com>
X-ClientProxiedBy: BL1PR13CA0414.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::29) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d537dc8-2333-4801-e81c-08dcaa5cb01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJMnc7w7JVkwOkEKRgewr40EL5slp2t9z/n+35KQlsq8Wfwr1xqBnJqOeSkJ?=
 =?us-ascii?Q?x78G8338fBZEUC0HInf2wh1MCJ3K7xUG9+QlbiK49OT840VbZGYD8cxpNFn4?=
 =?us-ascii?Q?4N+ajhh8+8qkw79quJsOC65Zw5bhB6YlGLkXIw30C/BuBo+ZYa89svfDc9If?=
 =?us-ascii?Q?Ak7NqfCJJfl6z1sizvdvlvb5ESW/2/OMFilx6g4hHSCk48YPK96joXOZrG3N?=
 =?us-ascii?Q?f6KYWhE9Z7qou8cHGUCYVGDg4o0+8dlHXSLbUzwnrWtryPDVU0uTtyIcFv7n?=
 =?us-ascii?Q?1di4+2ee+Zs1JrmFHti1szknucIdVXne7IOV4y/yGQMcz6IxbINnUfEyMosa?=
 =?us-ascii?Q?cOsG8ObGUDx7PO2lmVKrWgdgYEYhc4gQxsegNHlazi0+6IJQ0hya5Ye1piXl?=
 =?us-ascii?Q?KF4AJG3Xaq6l0ZRdGRRNZ88OByU/1RaJ46ZMQT79n00F5lFEZf/n2UR31Ug4?=
 =?us-ascii?Q?1cXD1tsq6KYfmMsyICmNgSQxcCsNgMtAzxSfEEvyD7FCyTXJldmECmeuSqfi?=
 =?us-ascii?Q?WahYuLTjyksgV+DEvguJc7sj6bfy6nq3UQDXM1q3J1JGBVYaRDQcYakOwCUz?=
 =?us-ascii?Q?mXxd79VlNAzgZTw24osQMbAreUquo1J/tIhoVLwAjxZ2WvmmPoafiKrMwF7q?=
 =?us-ascii?Q?/euR7Cyus2ZNTs8HTPMoU+ccBSlcG9WDhAhtD/KramXmrw28abggoq8yidE1?=
 =?us-ascii?Q?+Bo+CoJ7Mx2pWdp3MbTzZU1RQ128IfZ2FOellyiLd5rCvHOENXc9tGQrWAcO?=
 =?us-ascii?Q?Asf7mtKMRDwUzee0l//iFHtou8NnNhjSxY2t8IiKahdDkAu0Vtq5Y4WLhgpR?=
 =?us-ascii?Q?pbAfEDhJEK33XDLtcmBgcZBWXY1PPczRmqeOT+v9Rl5W1MZ+BMknkJoKjo9p?=
 =?us-ascii?Q?JtIGLNSi4pUYeF6onJPIpgPnBBap4EZZnM0UTjdxT4B74e4aPNQx9Tygy7ch?=
 =?us-ascii?Q?/IZXw3Lm+IUKgR+cwN6uw314fzVHJh4rpn4yzSkN8Rb3J1a/DwDseBd7f67L?=
 =?us-ascii?Q?5uCzg2omGJLUiODM7gXwWaF3X/+VO8PP86KM2dIaIiTaGcSMaxomQWYDNYXq?=
 =?us-ascii?Q?q1rc3RkHIqLzVbTscwqhSWrm/RzN1pDk01X62DW+X6ECIfBPrETEy5LAOQBn?=
 =?us-ascii?Q?9gWVB28ZLWxX4MJ9K1gouX7RJZ0e71tQ/PcCuzz51qD5Wm7r7TxwNu8os3kd?=
 =?us-ascii?Q?VV4hReHVF/6uwnze5DaQsszCtFGMCediuy5gfT5wed1m9cfe0Yr6PfLmwwEH?=
 =?us-ascii?Q?/pO/0UqAmjPtEnAlKRWa8TVMYDanUNcIQjkmLIKqG/CxnWr03Py/2GXuRxn5?=
 =?us-ascii?Q?K21/i6TFwf5B26cu6jtjWNfK8UutnR2Bmbx2tN5Or7MPQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gAPAN/g2Cv3nzXYgsTDowSYYUE4elE081xQOBXIJv0Owfk75y3lDcda93rQ2?=
 =?us-ascii?Q?8puOxJdFhJoyBnIaQ3wOHSRigWKqv9OUTmQxgdjf67HaIvO6JZrlimnh2Hij?=
 =?us-ascii?Q?NBXVo6nrVy/0z78wTaFjOTUWtD9PlwxSVZxzU27H+laZAgJy+qDh2DQ8hRjH?=
 =?us-ascii?Q?J7EcOieW1xm6E05yh9HPqW4BLk5+qkP3WecneVmSdS60MvCbUI0HNe1NIf6m?=
 =?us-ascii?Q?7i+Jj2N3hsxPWuQJxa2SeUd1rprVI1rOfaeHU6gASB9IS6B/ZNkYlEXPRIeX?=
 =?us-ascii?Q?5P8i9FBEnOTjW5HYEr6whwU4B0Nls7XUzRu9wLSAGodzObi1OV9hgISVIx0B?=
 =?us-ascii?Q?7GwGMEhM6QQqzo82ny49RCg1/AKM/3W5EdyW2ZgfjW8NPOfRlMhwba8JTXa/?=
 =?us-ascii?Q?ay+ezWsiHbdCG996A6/EZX1Y4cKx7Nbp0/QyKi7Hvn6Fx8+3gl4/DdEwnd3S?=
 =?us-ascii?Q?z2UA9uukBQX4QF6S9wDxCL0Wu7xqvaELu2auWFdxK54n5K43tWujT9ZHYYCN?=
 =?us-ascii?Q?TQyonbFwYw23nrQLodPH9NWJ+aFUnOo4p8Bvqol1B67rj20iWvSse+Yvhdyf?=
 =?us-ascii?Q?ukqCjbGQf3K+g5ZTNOdohL5De59e73XEnBU91paZ2hqsXToLz9hGbwlX6OVo?=
 =?us-ascii?Q?LFe8bVDrY6/zGptzK8+kWUaYW6w6S3sHHIkEopnxWnOeCFsOF1REaAnrarI5?=
 =?us-ascii?Q?pkLXzrMawwAjUji83i/KjtQ93FNhb5V87Cg4vcA0XA1RYFi/+psEPxwnoc90?=
 =?us-ascii?Q?VUWwtwjgjY+a1YFd+FZZne+Y0EI3vc6/0CGXG4AKeANlPZnOGedhfOv/33/2?=
 =?us-ascii?Q?x/RymZF3wSS/OibrM8kHSXSHazWOg9yEFBL+12DV83WppKG9P0L3B6Dneycd?=
 =?us-ascii?Q?hl+ZmwHau8Jpf3/uZW0BCZm8jOrYjVgYpR+qbMUJJf1v6td6if5lKOpIvNWX?=
 =?us-ascii?Q?h6p+/29SwRGuMx8GstH1oooXYuoK8K7dokv0Jd8qqPckSe2aOTrJPWpb2nLF?=
 =?us-ascii?Q?LpFOjX/NR3N5Lpvv3og10ajkf3XR0IST5MgYpm8SFkvRwC+R5sZousCrAhOM?=
 =?us-ascii?Q?9hu7ZBzxkxDyuYVXFnPMPltqL8Z9NA8jodA0f6zUOP1AVWdLUWjeMVIj/Uxa?=
 =?us-ascii?Q?2GqVu5np8hCvtdwbRIoT/Lg4T0TnrXBv0eXxUk40tbL1+Ys8TUv2DCB5pEOg?=
 =?us-ascii?Q?71Zp9Rpi+VjeEe1an1ZAoCn0nZFUgfAv34vJmfVHU9CJpd27ewwx8H+j9jit?=
 =?us-ascii?Q?64G6qrUl5UU7xgi5xNi0yxESD8jUfwNrJQE8bGYEYuFYBByM+xAiGu8UuvJ8?=
 =?us-ascii?Q?o2aGKCopFVoVir3cguzdgnIcDQQE869Y5bEcAQfrPwgJmd59jWhwK03rnQB2?=
 =?us-ascii?Q?uA04moyZgGtcBQovwtI3GYb/pmT4Uxc6oa7wqVYlKz4T3aOCYz6mVotA61Qe?=
 =?us-ascii?Q?OKZMpwtYJQMy918pF0t7RmFRijBBcyfQx81Ie0C/EBHzU387mDZkM00gjdiw?=
 =?us-ascii?Q?onutTxaZ6lZAZ2iRBnh66r+Y36c1zKmnQcV7IISahECvkaHO19xxoVBHYQCQ?=
 =?us-ascii?Q?GOLo4MkKf0DG29cNWpc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d537dc8-2333-4801-e81c-08dcaa5cb01a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:43:44.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcOABK1g41xT0+AiUrEkbHEkraXhBmJ5dCpR+BDY9m3nHvTYPAoIgSS3NQbtVfd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610

On Mon, Jul 22, 2024 at 05:13:43PM +0300, Laurent Pinchart wrote:

> > Unfortunately, the reason for this topic proposed for Maintainer's summit
> > is that the maintainer and core developers are disagree and there is no way
> > to resolve it, because it is not technical difference, but a philosophical one.
> 
> Having been involved in a similar disagreement, I'm not sure
> "philosophical" is the right term. I can't talk about the fwctl issue in
> particular as I have only vaguely followed the saga, and I will
> therefore not take a side there, but in general I tend to use
> "political" instead of "philosophical". The issues of market control,
> competition and vendor lock-in vs. empowerment also play important
> roles. This makes it even more difficult to discuss the disagreements
> openly.

I've prefered philosophical in this case because I don't view any ill
will on any side here, while I would tend to think the word political
carries a more negative tone.

There isn't really any lock in discussion here, there is some
philosophical disagreement on how much "generalism" should be enforced
by the kernel in some topics and a fear that if things are more
permissive through the kernel then some will loose power to force
their views.

As we don't even agree on how much generalism the kernel should be
enforcing, and what value that even brings to the ecosystem, it is
very much philosophical.

This is a little different than the open shader compiler sorts of
arguments where GPU compilers really underpin a lot of value in the
software stack. We are talking about configuring flash on a device,
and debugging the FW running on the device. There is minimal value to
open source communities with these activities in the first place.

Jason

