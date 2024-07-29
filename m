Return-Path: <linux-rdma+bounces-4068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A59C93F758
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C80F1C20BFB
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79C914F9E9;
	Mon, 29 Jul 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPMMQbhU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4114A4F5;
	Mon, 29 Jul 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262266; cv=fail; b=qZK4QXUPcffcBWITO7H8LdpNBYpupBSkxYlW6+gsqhFaNxYG8DzafRiAtUOlLC9FQpJ4SqdoLOHSylpliHmLBUiSqoiqCu6sCnnZGcHFUeaU/u2GFDwVeKbWrchyYgKiatmReYym9hVagR62Z2oHUa/7+aB+YJcyZoBXsT3/1e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262266; c=relaxed/simple;
	bh=3uuIBWMwgMSoBc5cpu6Su8i7MdItvY4Ns21GcztuLCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZsSqe2IbNbAVR+KyZ2QLYxjcdyL/0KuljjRQ/P9GILEXohgjCX6cWoVXAOsPXp/XF7SmVMPh5it1F8VyRL9KeWt8MYscAtatC9la5xUUrwf9accqGLkbIr5loOIeiYCrbomCiy/L0IVaqthKUN2VjhUUJexK+qRt8IBnqiJwFns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPMMQbhU; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWG/P5WV1VjLrX57RpmA4X/hpFYRFWLlDfGa2mjiMmBQqRySExc1s48KrRAbVKID4b0A+mGArEMZS/RB79tA0BrdJFMscESc5/1F3M9fxFa0DrhAKpCjzylGqomavuv+Qidt3uJ3KQ/ylSK3F/Kh3BjfWLNCRJteJeVuSc3GIGjKhUwPXoLPfsAECOV3V+eiLb2Q46DDi222+h0P7sn4YSWz0SBXaAV2c6lLt64JbFcjaaA1SzhJe+2I2lq9PB4Sa1gEKAeTrDp5uwr4AfCyXDI8nVa4OCP5R3lxa/r43lDGIQpcM4h/WMUC7tLfEE8ye/rYZtRtEvRZFN+2fmyaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uuIBWMwgMSoBc5cpu6Su8i7MdItvY4Ns21GcztuLCc=;
 b=hvgI9vel8SkOgX2FBEFXprU30iViGKALGaDRlYQ9GeCeaM430oAKSz5lOymAk/mYDGyP8rLnTJDJXk9dwix1qtz/L+Gk5bV+cx2FjAP2VpfU0RchVewc4WEtWfzm6uZTCUWVq/Us3RMZTZ7zNJjPa3VZ6ra44A41Lus5PUEtlRMkUHqaZ7AxudFyluA5KPJiaUzxcMqA3GPRwjrjtB+aUugkxOdDFh0BvX21IbTFlkAtChhsjx+Edb0ysFkX1rDbXMnx4mSTlaoyF1ZMYmM3Sq0OiOZMMBztfClpUnkeOBDf1RepefvQxu0Rhw7t/o6J34t3/OXN+vUSyBrLGPATRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uuIBWMwgMSoBc5cpu6Su8i7MdItvY4Ns21GcztuLCc=;
 b=pPMMQbhUXvErMXFLq6sJPZFT3OwSTGYkpEpxsPv6qsza/bCUiZPMMy6xZ5OKRH6xDJwULEiVTJ/zLeZkVEe4YxAk+1ScV9zI60FqrVVasIaDKDpUzFJLQrGj9kOfdWo2lssqylnDn4kSPoN4xAsqJaStGI2oNYYhYQN/WZydJCGFDnt74Yzt38TsOQ1IENLN/jlTC8meS0n2YtLtDQ2GEeeFN8jDFKLig+q2b63lf7SLi1I1c+rmuDtsLdmVgcl7OT+JFYxeKgQLPXf6cf0cfWqNeqP55FHQsV6KiMGOl/j35f+GqCMFffvS616AdkShrNqun8W8XBDTZUSyMWafDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:10:57 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:10:56 +0000
Date: Mon, 29 Jul 2024 11:10:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729141055.GB3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <ZqPd7i22_oyPB2UN@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqPd7i22_oyPB2UN@phenom.ffwll.local>
X-ClientProxiedBy: BL0PR02CA0082.namprd02.prod.outlook.com
 (2603:10b6:208:51::23) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: a932e2c0-f603-4f2f-f4db-08dcafd843dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/eykKzjozyopm6aBgu5C7lDyxORom4OZulBD19ecNlLCxIMuG68LKYlsEyQ?=
 =?us-ascii?Q?DKOeaAVnwLDrdreyOI+3MK/U/ARfB+gZ1uxAOOaDWvijJx+J5IcKS3S+t2Ey?=
 =?us-ascii?Q?MY/jrzm9kZ1mqSH8uMATtZ5XpKvCrk5X+IjjWOy41veqt+E5TV5AnnsjCJYB?=
 =?us-ascii?Q?QD7ygpe4vjK4wg7vj9k4tsj4edqIXcru2B1eFBLYANb3Cck5/LYT7JbUfVBM?=
 =?us-ascii?Q?Hb2kOHRquvBmtTQ58eSF3Hqs5UviPjy5GqUAknnhC+AQBxiaOjlWgd5MnhJa?=
 =?us-ascii?Q?hDvqeHlTE1iT9j5u74jhZhwyirTx5QLz9/MvqKvKe/OvDlHkOiuLKIxiKlwr?=
 =?us-ascii?Q?ssNkPt4f2LLjGfvqwDEsWlFPAp7RFx9CTdyLEmIpSl8wlODWVbOOUn87W4zk?=
 =?us-ascii?Q?eG3k9Zg3+tAyWkEgx5JVT8K5aF2dJCUYpSsfjXBfOIrp7dHgFJty7NGx+4Jn?=
 =?us-ascii?Q?iZMnpdEZOSHGlVzLAXG9gjaWl2Zzj2K8kL64D7Kk7bQz536CPxOYM5MPwbxB?=
 =?us-ascii?Q?DcB06KwxV9RADrGwwFz8Bdtiliz+xSsZltcF9m59akIYL/I9iVpdxXmudJFQ?=
 =?us-ascii?Q?/SZ95bGGez4Qq9crxZLhF1Q++N5gAM+csEy3cPxfcBL5FEYh8dR58XKcLNt7?=
 =?us-ascii?Q?0LuoRjXLEevEFvhXJ2M8fU+Sd518QcXC4OnCZFMTILfaiNbpbYPKybW+2nDH?=
 =?us-ascii?Q?VVt3dVtSXxucctQbyxAPYU55i9nlT1IUfUsb6LU9MWtEuCg2ex3ygub8MCg/?=
 =?us-ascii?Q?PiYHRYR0pY6RLx2a3M7XRwgLpQp4MGngS92edgD6rqhMFpQbyw/aGf9FpOLt?=
 =?us-ascii?Q?vcgxhJB0jxOLQ8TGR03oPaEFM/nKhCMOS4xO/4wQYxCQdAHfSLl9UtydgSC3?=
 =?us-ascii?Q?UrDrE8z9+Xm9pl0vrBlDPjgeRY5X2QcvJTazeXOpYf1LMq9K/5cHh6S/KmYA?=
 =?us-ascii?Q?qgVnuKm4oJZ8TPDN8fsf8SNxgonp2/e8YtCMNmy16P891Xh0K5gYoJsm6N1x?=
 =?us-ascii?Q?ikWs+Z9od3T0o6xQgByDv7HF4bU0AgririikL48vHwc6cPQY0prfhdPTkybn?=
 =?us-ascii?Q?bBP5r9OeCYgUzjP5wM3IXiI+vq6Ov6lXefJSWgEF/ehgH9qsDErlxiJJtj4R?=
 =?us-ascii?Q?1DevgEGZ4abLY3+W6o6LOE+RFnnmgtoXcDDiiDcZh7wQnl6UaTVzy4oWresW?=
 =?us-ascii?Q?js7Z5rtbXnhLnw5lEDZOvV7iVboKQiCWWt/jT/R86nsJKtI7Tefo7PD7CiOI?=
 =?us-ascii?Q?tJtHsbFxZAVS6RV2Mn9El8BLvn0hC7iR6gjPh+D9zNNAoKH81l7FE9b5dvF5?=
 =?us-ascii?Q?P7aofF1h42gvMupZrwydA2AQGFBkMXm8aWh47AEFJbRwNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9grbgIKE1y2WTLnuTovzufZCZhUl7H/dma4QQzwi3yMU2L/XvW/Hfb+H79KZ?=
 =?us-ascii?Q?caB0nSo6fgHhqmPv9Wdk/4psEpXRlvQ/Ls8aui/X9g+GfBpYQyiYxXdyMBIi?=
 =?us-ascii?Q?Nv84nm/X6DZ4oODEuxIADLW1M6GYqcmPDORKykXEXeBE7KiN703Y0Y4wxFTo?=
 =?us-ascii?Q?qbpMDkZxcbEeSLsEXuAxtP1tFM9I0mwMB46KGYtE7Z8Ll3CEewVOIHVk97rp?=
 =?us-ascii?Q?WqPyv5Gq6HdTAeZ6naVovTrLkKCdCOrDg/p4Nqk0+6pbZp4w+r942nz1zRbv?=
 =?us-ascii?Q?EePnh5YIegqfWqfz5KoNbIZkfgdSGokH57zOUPb/L7o6vpcrNmK4Fgmkpm06?=
 =?us-ascii?Q?QfwXnVRw7OmGanYEf15SWFj9nL57E1Mt+s9ywJDjJBW84LpWoaXWsxPh0fTG?=
 =?us-ascii?Q?QEW1tdT/vt19TNgsEUe/ISWkUTRz9ZzRnMIrLLlV1H6nB62IKX1V2y46z7cD?=
 =?us-ascii?Q?t5oHmhE1giJu3rYVzAV33LJoXWQy/u+EOwkM6GyEDPbm3mqdNmc1I6Z5+RDX?=
 =?us-ascii?Q?e9OBY52yHnVVF8fF+PXYq2sef71aqEvE11IAtwy77hInvGZJV6xBliltKbri?=
 =?us-ascii?Q?dxLOmfhDXMPnlX+LRnpfhnKuus23T0U3bIjpT4HRyeZ90X/pDmFof3IYckFE?=
 =?us-ascii?Q?HDuKMYiWrPFlVudUKlw1ePURrW2HBTwUeIONcF2vG1Op+WhYciUmeHxrdON1?=
 =?us-ascii?Q?EtNbny0cZOZls2fgWkeU/MKWhEZ9TUW8nU+B8fqrP1P6+ZGx/fzgqc6wWxGK?=
 =?us-ascii?Q?z3e8lySRqFsOKR8KM//l+bWxSwgqAZ2VgZgA171qbYWKKYOlWJjaNksRuXs+?=
 =?us-ascii?Q?jOx48f40M8J5D4EMyYeufGXdULsiJ0Ru4kmxCH1ewUgLgWakzVikMdBV1MxA?=
 =?us-ascii?Q?S6Y6uugQ5BVg6BHIvaDU3x5oSQYsZDOXiX2mKapNYuZ1OBFSxuAEvJFfnH2U?=
 =?us-ascii?Q?gztTBjSJnxlw9hULyjyfXOmBXtCW9Ev8jYYiQ59wIGA0ytT2KAtrxa9nzkS6?=
 =?us-ascii?Q?xROPasXxF0AA2jV1mVdjUACceMM1H2quXxb0GyOoSmV7hhqxUh4Pdt3k50ga?=
 =?us-ascii?Q?5m6gEGdWnunhRLoshrhuZT/5oZjxXk1ZJNIRwS+edCROm42gacUUQnuN41eb?=
 =?us-ascii?Q?cdwQyyFA9iwvgczydjOcufLgEqoiw/X66OKavKUL8Q0TAwvdYp+YP/atrLis?=
 =?us-ascii?Q?aEZzB+5CYDa+cwdT+h9hP3Cg0HQIZ5/Km9idYFul4BYItEMXczx+fthRVLvI?=
 =?us-ascii?Q?YkrZdY4T33ReNlnf0bSCVfclX4U2L6//QOXxoyZoqEWi3+/wTJR2sdEz3zHz?=
 =?us-ascii?Q?MUhG+WitTISAcdZL/rpN7alQH79KaDXFJMVZiioYS9uufCVDV75C8LA40Nkl?=
 =?us-ascii?Q?oqNfcNk7+HBRrtxGmgG2t1OlKSbGAFn+jQsMWUvi+ZC27cFieN7T8nIZCBeB?=
 =?us-ascii?Q?hjpvDmSrjsZBgIO4gq3Aw92bwQp85lTOkhWNM/SxNnC6rgMGEk6fvXELn9f4?=
 =?us-ascii?Q?23JlIPj24D/n40rDHe38wWBRfFszni+7JJErnBK7KeVD+1p57BMgiSVB4xyk?=
 =?us-ascii?Q?DBwmxMjmF8KqmGoVpPjaPxWKSEcW82m8UvljEpBI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a932e2c0-f603-4f2f-f4db-08dcafd843dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 14:10:56.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmWbuCIKyMnF/iWi+6PzeQVdyJ67X6W6YwEwQ8VoN093YbLllYcGrzncqn2gX9mz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

On Fri, Jul 26, 2024 at 07:33:34PM +0200, Daniel Vetter wrote:

> What gets vendors involved is a successful project that drives revenue,
> where they have a clear need for a seat at the table to make sure the good
> times for them continue. Clear rules what it takes to get that seat is in
> my experience really the driving force for private discussions with
> vendors, and from that pov the most important thing I've ever done for the
> open gpu stack is this little documentation section:

Yeah, +1 on this, we can't forget the important role of the end
customer. In my view a successful project drving revenue is one that
has customer pull attached to it. If the market isn't also pushing for
open in the same direction the chances of success drop dramatically.

Jason

