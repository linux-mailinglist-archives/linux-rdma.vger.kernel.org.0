Return-Path: <linux-rdma+bounces-3993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDCC93C8DD
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 21:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE89C281B4B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F457C8E;
	Thu, 25 Jul 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dd8h0okB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889805C8FC;
	Thu, 25 Jul 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936601; cv=fail; b=M5c3WMuR4AC2D1Au/xQ/rEj5SjjLQBWBqhWJwjboZNy3A6qZN7t8igRcVA5fwWXCYjVJibugI5Z7y+F0MBiVH1y+m+znZynRmhnkZdpZRQAxGjZvHJZoa9Jw0/xVIU/1WPi2a7nLyIriHBWkf3ve46F8QhCsez8CI908b7d/Q3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936601; c=relaxed/simple;
	bh=pYJ5vBEbM4lPJJpth6hmdOzPkmrwMAout5/CGpWFFKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLUaqjHmbhZTFKcxJXsiFBaVnVdRu8h7HdLQIbJ+/Be5oEZkBLppdeWDfbFQ9Sfk2c9HVhknxhPSYGqbJhu9E8nHV9M1x4evYN9eCDjXAuMxpvOKsTfELvva91JM/fl90t/Cab43wYLc+kr4rilcjc3EqCIlmJoSWxduK6wW4uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dd8h0okB; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bxrlg/4UPV/yhgliuA77JqBsN5UvHDiiWbk2gTcFRDPdhV6kWJTpqj/u2lUB7MB/hz+S91Ca1cpV//Rfx7lXwJVNQd4xDbDSpXAQpGQm/+kQ9kkXDUo0Jj5ipaAA0pkta0N0Rpz6Mv0CGmVualPCe8O3INp/6YjxE/SBopqTKcrsE1PTWoiSzc3xfYmLKurAsr24WvpY79M+IYjJr2+WinCiCYDKGTUPSDVjGFS9IeSDFx+Kv8NNO4VBcdpzzaiSNETADwTT/w879Tp3dCR6THmYLvXXzb+6OPxLPRxOTNb/hAUQkFzc+jy9kWmfHw9YErZrFRClNiS5r1gyAupVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYJ5vBEbM4lPJJpth6hmdOzPkmrwMAout5/CGpWFFKc=;
 b=Nd7iQ+cwzkfG2wRQaN8O1pq0MYVGGas+pqhU7G3tIZhcGZejZgXfcT0JHP6R3B8LWQjq44PwJpxUxUzRvDOHjzuc9GJOHYSbz7ssqJCAvr1wzD0JnC+SBBAPVtkmpbrrSCRLiJBanyxh4fLjY7bReuQy3aojXJOxpkcnV6jeoAESh59w/yy4FVAFwdnT1iUHqNK1+fy77uTKZi3QqRLw5Ak75xqitW7NM+OdZYJ7iQ12S3no78EH5JqSm2GvM/U2WYiQvCzuhLZq+eERTCv1E3LMbrAT1YYZtJBafUZ4mdzeP/d5C+Ti2kY/nXdkdz2vJTbrYI6tJmU+TQyZpXhpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYJ5vBEbM4lPJJpth6hmdOzPkmrwMAout5/CGpWFFKc=;
 b=dd8h0okBkxzRYefp82vJFZQ+4VXQRUM27QnFhzjoF+RcHndC/VOML8q/Zxoh0DKgA3PdTVrrsmtUv+fd/8e4COIG+krPGWlgywe+Umv26B/DE0Ql7cPlL7NG8Wa+ciU1B0sSW4+dhcZh7xeUxCVLXb4yptOcwFn+GWSkckwmsvbBETKqjS0UvTxwD4ObWOTsudanyjcYXHNQnXqvF7F7+gaetOs7HY7hUf8d3YbjxflDfHqt4qykd6gX/P2io/K/HPoYyU6bY1bNv4TIEOluhRlMA6kuJ5TiM7hPoTwi6FHh8D/jdx/nyzNtGhw9rn5N/OsT3C1D5gZiXCdwt/l6DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 19:43:16 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 19:43:16 +0000
Date: Thu, 25 Jul 2024 16:43:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240725194314.GS3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725193125.GD14252@pendragon.ideasonboard.com>
X-ClientProxiedBy: BN0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:408:e6::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a46f2a-0589-4e75-f49b-08dcace20758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rkHtipEM51qHMguqa/b3IL5XIwUJuAIcuhsxPCqpzkaYVzORFYlyZuJqWhkO?=
 =?us-ascii?Q?rb05tgzuOteFox3Z4lYq7vEBANGBF8JGeb7OXZTQNbP1/M3dFBoLBAgmgoQZ?=
 =?us-ascii?Q?GLqb7kFxq9i40gl5Q8xT3nYyHzMnSYFD75e6o2TGsltNcwHN16KrQllGGeM6?=
 =?us-ascii?Q?5kOstzZaxHK3Q6A0RIQMpFB3aWQoZYkje+GKsq2+f/DVT7ZWF/6PnaEs8Y49?=
 =?us-ascii?Q?CdttThNHoNLY5tqXFuwIcEAm9dkNWc8yfR9GhjciTyfeyQJ6SxEIlK3HENfZ?=
 =?us-ascii?Q?sCihNkAD0r9LAXz3g+h87QRcvqN/eQos6ZJHbfzZeJ6+NEBlEW21M7CRCE/o?=
 =?us-ascii?Q?TZvSGqPm1pXeM5ap0oKOA/pxDwIGNfbKHCs8ZuJJZf6eumU8+eBaOoiCMq8W?=
 =?us-ascii?Q?PdBo2rCxOadW7zk447diiP9/EGYO4D6PMmjNFVv0in8vKdkvHjFl6GdHF0U1?=
 =?us-ascii?Q?QP1mTkpt4ZHkDMuxW0f2imJf+FcWIsDmMWOAb2VmPRPKwMCvzpxAA78dPQNn?=
 =?us-ascii?Q?/C/tCbgHMH9kMOX8aeRIoG5fwKEUd/go9QxSIR0Hxw0bQGvfrC0gPPBgVDFS?=
 =?us-ascii?Q?DUtJgVczA7W1pbSPs03CBkfM7DdtegvnCXYRdn5+pUtzGdCcFJpbZCiUo4lc?=
 =?us-ascii?Q?Rp7+8mT0cmvxlkKXyfGtd0U9LKu9IlkeJCqUC5ROuOmkOvKCv4h/hcAAHVe+?=
 =?us-ascii?Q?aSQjD02nSQ762m5v9kJ2pyFy4vGaBZZj/6L4UTNFEDg6mwLWQaPOfBEq79mo?=
 =?us-ascii?Q?+Zqhowu3qzuqhgwKV38JyvrgLzAQ1SDdD9OZ4JTw5ua1/DrFZT6o4pxxejGN?=
 =?us-ascii?Q?mMTXUjR5xiYxqpUKTxvgxgzn/tGydVFhaSXeMeIuNzS/1AhojsC5LDUD3FK8?=
 =?us-ascii?Q?K4OQc+aIY6nOJkh/sEjO1g4xUFHA0c2BrTlVTXMKEXV4GrftNGeFrVLCnqEo?=
 =?us-ascii?Q?A+Cn8RqpABLIVNOGRdaZPE34nBgyf0mqTGGGfs6NKHbw9rEY/8DQ1I51VzTu?=
 =?us-ascii?Q?wxzsLr6gUunrnPrXL+Oa9L8KFtAqQ/J0EyNM2SbibqSQDU7AtTgfOpLbaiu/?=
 =?us-ascii?Q?AxP89fQ+Zm+6wEJVHPsuOaxiEfP19fQh5pssKCmngYi+cXHZ60gtJmusMDSN?=
 =?us-ascii?Q?Xiecs5vJ9ultBAYy/ggrnjhsBFFh0FHv/yD+hEamS54W3Yy6wmWzaVqHg0eX?=
 =?us-ascii?Q?lm3dPWSSYG2U4yBvYM+bUr/5q5pYtIbed9TKjRIeJUI9PVfoYx33Rn4J4+lB?=
 =?us-ascii?Q?lTwQWXq7Iy02PsvfD+F2X9sGfzn1KaY2OzKQmuxseUYO8KfTI76MBWMwVNtO?=
 =?us-ascii?Q?NnEgxvvQ0UunhLs15CX6Nq3ZqnLB8lyjTSFZlMGyKp9Tog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YoC3gavtHxLWreP+znscVl0q1oaDc6HvEDWMXgvzTmDXWiY99EsiErGoks53?=
 =?us-ascii?Q?ELvPMHwLNVCbDrVx1LVn6MqN1N+vWSAal5eAUj6fPN3ouN6nANZ9fLWjM34O?=
 =?us-ascii?Q?M5TxmXKhBcOUOC7C5lsxRguL/TwtAkuQETBVyClLF4BVNH6tVvS+7+kUSlCH?=
 =?us-ascii?Q?xRI08Md8cyV4H7XoGN+ib2TvcbtVKFgK7QbQ4OdPUi5K1xbRC4QrEI7YOe2S?=
 =?us-ascii?Q?5naqgudEfGSoJsHZKAA6v89Ogl0Z6VWBV1rEAlzKgtdOpyvNfxnhpgHulNRV?=
 =?us-ascii?Q?RmvRdv9MCoj1GhRxPCCkmUMnqrVQpbg0HdFMzMgdxlhh4snYmlyNHFTyuqHV?=
 =?us-ascii?Q?T/Lyc+dYg7zsFY0sGLWhAbUxFM9vEBMhm5jGj4QOSFgtF59NjED5t24sqeu8?=
 =?us-ascii?Q?oKklm7Nh20dNtf3ZY7BY7Hv8V9HqS8Y2yDGGJ4Tpg/JfBV1UvJmIaIExBA+z?=
 =?us-ascii?Q?gJpRjIEia5bQ55M/nZ2Jf2xjif+bnZ35zJmstq5wM5YaCX8iDoZgr7P4T7n2?=
 =?us-ascii?Q?gT4tIwn0Ns244U9gJIc7avFriFCXBL1iQYqZORWMaFrMVJ2ufRLno5Cb8fs4?=
 =?us-ascii?Q?TdkpmRUcLQ1FFXE89W2sxOyHtD4aRw4qztWCFfnmxX46hawKzqON2RiRj6Et?=
 =?us-ascii?Q?8cj1QYXqUy5UD1WA0I8UftTbeWOhZSh+mgQK9/+sJeTNxE07UaAUYFq/iF65?=
 =?us-ascii?Q?vw9UuFouNLUSQjI0I6kI7jNJ3SFRc/3PbC6Rb0GyS+qRNpBBDfTrV2tb8Mov?=
 =?us-ascii?Q?phTW3bcsebg4jWu0M5ROFxuk00dKlL/0LaQL13FTxocgPBFfYNSps85foRQv?=
 =?us-ascii?Q?q+l0dAYM1MnAYrtPhjvfNNjNzypVT8ihExrY2gTMWVHp+AjmMondjJjIywT3?=
 =?us-ascii?Q?BORo3KIWUua2lBDt3WFDepYVOOIfqwSA36LevROcEeY067dpm3ud/lXffsvY?=
 =?us-ascii?Q?RNeUXJL6D/Xa2iXCEuVKucWwncEJ/up6/drqV7itTF0aRGPhKy6BQRf8xeZo?=
 =?us-ascii?Q?qRYS6uRw2QbKfX+Wxn0+fD3QQ/ZLDH3Y8t0zU86Mvii7/0JPSUTr71dFOfzg?=
 =?us-ascii?Q?drydCzkTKn1HUkBdf9XyrKTX7MiqbJgxK0AtTfXR1b+cX7c/kpG/pCiKdvdo?=
 =?us-ascii?Q?ETJJiz6HOt3VNMythVDk8Vr3dhu4lPAk1FWFNYISUiZd7DN23YqDgmQagoIh?=
 =?us-ascii?Q?Dx4BSlZzqdxqmjfTSfNGP5IiPhCsxywo9uBGi316lh4bi8IU7AJFHv1AnyvP?=
 =?us-ascii?Q?3GViAnmTIJgF+Yh18y8QGoYp9cKmj0DojBkLmGCeZ0eZRiQ5Qe1wbdf2ci6f?=
 =?us-ascii?Q?0+t8CsLqN/MTW5NGHFBM/WMdjYAILjYCrEKKY+DpqI/RPvo5UwiBMk4fvNdx?=
 =?us-ascii?Q?RL0rNXoUWlI4svW7fk7aR/EZ8YVYxNWBGWfS02QvTWR8U0EpbrKHMt7oyrzN?=
 =?us-ascii?Q?mehuIy/lVxympbQ0OL1TFP/SOf/3OHakJAT94Pr4iPW+PHid3NfnbuaN7JMv?=
 =?us-ascii?Q?y2+9bwH25JQJibfTKpZOgVUOYO/W3GatLsNwldmjGdfhdLC1SS0H8AEn6kqR?=
 =?us-ascii?Q?plUevIS1GYwHjuwFNj0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a46f2a-0589-4e75-f49b-08dcace20758
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 19:43:16.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7eR68TCFydEoc/zxglosBQN/HWavsFTgoD/FSPKXs3RSSbACsGMJ8pG/21hvCLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

On Thu, Jul 25, 2024 at 10:31:25PM +0300, Laurent Pinchart wrote:

> I don't think those are necessarily relevant examples, as far as device
> pass-through goes. Vendors have many times reverted to proprietary ways,
> and they still do, at least in the areas of the kernel I'm most active
> in. I've seen first hand a large SoC vendor very close to opening a
> significant part of their camera stack and changing their mind at the
> last minute when they heard they could possibly merge their code through
> a different subsystem with a pass-through blank cheque.

If someone came with a fully open source framework for (say) some
camera, with a passthrough kernel driver design, would you reject it
soley because it is passthrough based and you are scared that
something else will use it to do something not open source?

I wouldn't agree with that position, I think denying users useful open
source solutions out of fear is not what Linux should be doing.

Jason

