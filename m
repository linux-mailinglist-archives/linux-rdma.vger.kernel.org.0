Return-Path: <linux-rdma+bounces-9736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC0A98D9A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 16:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE5E4459D8
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7D280A50;
	Wed, 23 Apr 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kGz/tTvL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0FA280A4F;
	Wed, 23 Apr 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419618; cv=fail; b=PP8eAFBR63zGt4jCTNM2Bw1k6OAuM+IPZwaQOWDMVbfVgqiw5/NTW26DH7IJQKOl7m9TzrXOgfzLhcgLaRq7Sq8oy46wGDGWmhGgsZuBps6rpn6XXNNlmNe5t2cT4QVufFZMybq1LNAJVMqQ8lFwyDqUZ6GBiaXM68m8oja2Upo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419618; c=relaxed/simple;
	bh=UM1K1jp950Gt4VRaST74yYkSVy8s6a3fS9XjM6HqREc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8LLnv5A9NQn5rc6i8z1Jw+teGbRrVr9DiDMZ13w23br11BzyDfkTAPHz3gU26uLOZ8OJbZ8jNA6yWronW5QSqwxCyQLcm7QO4VZEIz2o5OaH9KxNrNsi8PVzKndVH00RRRYnt8/g4Dp3pzcg5RqMESiAt5LaVyuwVDUJ0HwYeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGz/tTvL; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6HJjhVGqQ1WynNQi0w480Lvi7RKHTl3DpC5uRZ6kavcneI3jOIplTi4d4pblWvRaKwdPCrHdyR3HcIJMX96QeErmz2+Et2MKPbO1IJ22sh3+ObH8X6DXak4G1fwno7rPsM39zbzvBDuFu8RHrpDcWs7kAaehH3OdpaOjqOAX9mqgVYjOft80XQULgnKvmau/jZ7XREdp7bWyrDraJo/rlQwkHgMyai4BvzdwmoS5XC3qp4zdCtK3Gb7a60WgqYu6oQP9544riViqdqsOQjau4oef1cBokOL3AtPfbMRzK/mbjHCuYrwxhQkaAYI7A7NPSbTwUyWMB69z8fLz8HwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdRVXrZKzblKxs/7/9+yvL5QHxfVgkFg/EWZW6ApDzM=;
 b=I4LAuoCEtVpLo8YgsXq6cNvwUhK/13rGoHJnTKwVCXIOBWRsFlvsz1kX8JhuysRaG1by7Glcq/zKRKbc4eoOoWgDeGQQw/DT3d2ZldcjdiuG9XYu5FgN01rZaOjql+IpwvskBcYSp8kw4Zu6dIP/WqPnhQjkVBQdu4bVjkxFvNcVHB1q23RYx4o5rWCBHtRTZhmG17UdrDpSs+BNHnnXLQ5IKxOcsDScBv4m2zQbfDgbjgy2uwreWechEqDjbfSc+kbG/wrdSsJAHuDlKhoSQBXxN1VhZWqDegXpuWoOEHqwDgr/5N6/5kSb5KdhoGlKZajmDi70b1rskrbCwyB9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdRVXrZKzblKxs/7/9+yvL5QHxfVgkFg/EWZW6ApDzM=;
 b=kGz/tTvLNE1b3NQCgPweTrgGMY5QMRxXEoE6EG1gWDZoaoLhYvcEYyjIh5kde36DdqoQuIQprHRAUDmiPtsaiqOdOBMn3jR7oSAhFswfs2mdOxtkEdLPZsloIlrwuadLm2+0VC1YznspstCKQGqMTjl4th52IfA/EVDtfcRPss47nmqSdiffxaBrwLaTnWqx4uVRTVaUMMnhUoMcK1NRKZklIzOwHHOMFBHZ4X4wrH7BmBcrO0n7+e9j4D5y5eQlHfd5JzgnXmk3uuHOAwmNPMizfWESvUs+Ibkyb5lwUFW2e619SfI2fXL6CE3qKQO/a1tVpOFRgxhKC8qO7lxaqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 14:46:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 14:46:51 +0000
Date: Wed, 23 Apr 2025 11:46:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250423144649.GA1743270@nvidia.com>
References: <20250421031320.GA579226@mail.hallyn.com>
 <CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421130024.GA582222@mail.hallyn.com>
 <CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250421172236.GA583385@mail.hallyn.com>
 <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
 <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:408:ec::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: cc780371-7a55-4c64-36ea-08dd8275ae93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5pgl4QcaalZl5XqOl+ueX+H5sMcdPpJ2yKUb00NIu5+Bw50XgjHA34lVDfm6?=
 =?us-ascii?Q?KQE4QXV/jKPc+XpS0oDZM1dzuUMY2MTPqRnG7HfehzFpe5TxMajGZng6s6c5?=
 =?us-ascii?Q?/TnAepuLxJge261BwOSaLYRd6VPTvIjhWRYqwIaP6CZoAW3qLJ0HhDsImftr?=
 =?us-ascii?Q?HV2MbH7U/H3BwLp1r0JC4Wu9fXytG+Cy4kuZgVqAMs/wr4+lopoDAgn4oPHT?=
 =?us-ascii?Q?aO/GeDT2tex7YmBD6kWU03aqb4/SIM04UryF0albWO7DSk+SNh4OYUfPsrW3?=
 =?us-ascii?Q?MVINP95gc4mtW2qoVuhW1TnQ3O3WlJlFaFro9znxKVGA7CS1ToJgjUpsHL6I?=
 =?us-ascii?Q?aylyuRu8LHhseqk2REdJWYLWhzR9SRvWcN1I6IWx0A4/rUSOu5zUYUeCeAop?=
 =?us-ascii?Q?QUHJ+5MpDoujref6T6HH9JMlhZ1eI+RIykp/yl4uS/Jo337+PDaJrORPNiFa?=
 =?us-ascii?Q?BHUDaGDG6mWOafNrpWTmF0GTCtI284w5sNC/Z+NNEqIwmVEJ6rKRNniAk5FP?=
 =?us-ascii?Q?y8n3YBkXw1YV+FVJ9v2jjF0OGkZCoRHb8QvvSEM6Bb2s6Nt+pVfTOJMUQdri?=
 =?us-ascii?Q?Wr5bMKOqB/8es1oeBXbW42uzdt3BZqKoU+9jG9SWwtcISrWCX6taeXGO7xWN?=
 =?us-ascii?Q?hBpDFdkYWnNaIARC1ngoxMS17qBh1j2wLBkv7iFydGd8ewJ4lDlDT7UxoU/y?=
 =?us-ascii?Q?opQ77z3DI3Nl1+9xfH055SzOpSyePoml4yFg17LC9BGx5JdO7q0jH/8J9Lae?=
 =?us-ascii?Q?4zElIHjRmDfEL86WKCQiAdMx5JY0GdIQx7mNkfVreOqsfjLlD7zv5UzIJs8H?=
 =?us-ascii?Q?gm/wINa+Lp/GenZS6GCYdXTtLovxpSpkaXioawnQTXBcsoIqgskCygwE7kQH?=
 =?us-ascii?Q?DpEH/TGdrmT6p2AmTDsF6cHYc18bQgCH+ZyQGpfCB+oACLpj3ksrFl1a4Pko?=
 =?us-ascii?Q?s19znq8iS8h5TZZ3P9d50trUmvvc/KcfFJtPC9/du1+/rAZQImOSCIctg1dR?=
 =?us-ascii?Q?I1ZOqeTB0KsQJHRCl8BUrUaowbUjKgkYaLhRJVXgnEXoNAqVP8yO52Ox0wiw?=
 =?us-ascii?Q?bdaOkgJvrUIPkp8lxkX7hpxg7wCiT3lp42vA9bUIp5ViT1WjxfFT7SQ1b06L?=
 =?us-ascii?Q?dBgwJy8kapAB/kqQEv3iB7wynKPe356eEQGZTegwCsTqBW928dVrSpsuBwoo?=
 =?us-ascii?Q?Fz4Z47vGPoLvfcUjSRclXWbDvVYk+n3TS4A2jMBLBfpz49B6A0WSO6Ev7Ebz?=
 =?us-ascii?Q?39GW0uSxBgggYSKSM/xqAK1QEQwMmLh+t+G5uhy8nm3PwdkW8iWT3ReCUetL?=
 =?us-ascii?Q?tN0d0Zx1aHUZW16Ct+TzDJnLfHpWatdV8AbMVEHSPoyoN0GCEkDfDJRhH5wO?=
 =?us-ascii?Q?H/tVBp2NypY9fd/8iyoWv/vQRQvPqBEplE78Gl1mFw1nnkPX0lNlqb7SSCHV?=
 =?us-ascii?Q?5Wexa+yLq7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jy3LiWuMW2gX8nYm+U8a3r8ihDvYOFHKFBf179/X4hm1/fjqOO4HjWeXuU44?=
 =?us-ascii?Q?sCaQ5HZ+4d7gMZqhHRk5Cd58YoJpBygYyELMsXwjH7UxnlE9YxSSuKCERrBy?=
 =?us-ascii?Q?uySCgYdLUByuWHK1lt0KTK8FHTlGesIaHh2+o1kMtflYdoK1sYpAfKM+y3lE?=
 =?us-ascii?Q?yoJ8CZraHuIH8L2bLAyhC9/qLNGU7TyG2O/fHdqyi71P5MsMm3VxAMI4Jabi?=
 =?us-ascii?Q?4K5yGbRzHUXC2g9okCJI5h5kYT4DMsTJ1ge+0lvML3YGBaHb8To6ikdHu3Fm?=
 =?us-ascii?Q?3oznssmAQPNFvBd0uJMLQMrPFNZYhNkgNPdREoiem2uAD88YaJnMRIVLKKqK?=
 =?us-ascii?Q?F9uqrcAwHE2VaLQJpt6UGHbPm0xgX5hQ9oBzBSOCl/XoL8XjuxTgO/Mi9LhS?=
 =?us-ascii?Q?4zmJLhID6EwG19/NLd1t8vQ2QzeWd8gp7U/UbLXcB/ITE19YC4ZRWJvd2c+m?=
 =?us-ascii?Q?tOfrLlFmn8VwpdiCwl2DuKyyy501NeADUawV8ff2x2uDxWSzKNwEBnI7BHko?=
 =?us-ascii?Q?nXul0Zni4KBGmG2DOn0WXpHsqCCH+Vmvb0TR3QBeH70yavFOvsRHPubVsHUy?=
 =?us-ascii?Q?oDqVHgOE9R7YAXgyLpGVFlSJHYAQMPIXhqdD5K84LQsU1Byg0EupwMPkXteA?=
 =?us-ascii?Q?cogMIB5LHwKMLHHe4t0JSIhotx97B6Ig/Gn45oNSshE62Qw4BLBUSoX1ODMh?=
 =?us-ascii?Q?Jw93mU7LKRr+BpNiz1SubTaVoPlmCKzPIU8D+Ch8P1IyNKZSxZ907vv40eKU?=
 =?us-ascii?Q?DMf7c8Rr+rRWHDhGSEmsa4BdGbHbIAGe1QPECh5txPQJBDOGv2wCg8cfayez?=
 =?us-ascii?Q?NSEUIFp+GdWrLV4dgwK27KTiMDEKhuDYVzxLFVVYPDPnud4bvN3g2nFLlWQm?=
 =?us-ascii?Q?mil8AC+7q+7eggVSOQlYyYc50vytxiZ1+5cI0dCSTMzWlJGluhCkY1LuGKTS?=
 =?us-ascii?Q?EFxo4dcWod8nMoxUr2J/NnON3NPfwM+S6rtoFMDExSc2fQhkZy1NoWrVS2mk?=
 =?us-ascii?Q?ojWk5i8Q/M3RZYM9CocYrrX0ktPjzNjyGa3GlCFaNyviuBOncZzQo3RVbZ+z?=
 =?us-ascii?Q?EstV6ZGsevCYtwdAoaW9RfWtenfq+hL5SyjgeHxS/r05lJuoT/aPkUcjxNuL?=
 =?us-ascii?Q?Wn3qlc5pUUlUw0iaBAmpKfHdsnU/NzYhVfR1TNbftXS7PiOdxGyzRy5rddmn?=
 =?us-ascii?Q?lz7zmG1fd4q6rdT3ax+gmJsk1BZhro14V6WfywXV4sKOavdYPNyUN4UlFw7Q?=
 =?us-ascii?Q?BjFvvwZXv8QlVhkiJXKeWQC/HuETw1x05NI6st+CbEtfy43a4tER0fK1DrPL?=
 =?us-ascii?Q?nqPmC31rKLdy7MBp2XCLHQdgYe8WFZHu1Ul7krj57ZjO1kj20DbW934i8QXG?=
 =?us-ascii?Q?JdsYGEV40BuZ6dVhBPmGzbCM0OY1RHzh+BN2Xmp2e/VXnscrOvk5k9Yeh11+?=
 =?us-ascii?Q?OP4yic0/WzS1viRl7G7RCvHIh6TPf1urLM74RD/WmYmLyUw89fC6/kOm1BFQ?=
 =?us-ascii?Q?agMnNjo7L7GN3X0j+DL5T9uA/d7tVSxaj/L1hHU1rSPh7FUCEE3cLyPdpTJr?=
 =?us-ascii?Q?ptUPyF9svqLDh2LYYW1EZWHE/QeGgC7dry3nzw1Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc780371-7a55-4c64-36ea-08dd8275ae93
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:46:50.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLpqxfISAaimlE6NLztv4m6pADUb75twlmWN5en2IX9xbfrV4XkcoSSGmCMbjUcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

On Wed, Apr 23, 2025 at 12:41:26PM +0000, Parav Pandit wrote:
> 
> > From: Serge E. Hallyn <serge@hallyn.com>
> > Sent: Tuesday, April 22, 2025 10:00 PM
> > 
> > On Tue, Apr 22, 2025 at 01:11:27PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 22, 2025 at 08:14:33AM -0500, Serge E. Hallyn wrote:
> > > > Hi Jason,
> > > >
> > > > On Tue, Apr 22, 2025 at 09:46:40AM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrote:
> > > > > > > > 1. the create should check
> > > > > > > > ns_capable(current->nsproxy->net->user_ns,
> > > > > > > > CAP_NET_RAW)
> > > > > > > I believe this is sufficient as this create call happens through the
> > ioctl().
> > > > > > > But more question on #3.
> > > > >
> > > > > I think this is the right one to use everywhere.
> > > >
> > > > It's the right one to use when creating resources, but when later
> > > > using them, since below you say that the resource should in fact be
> > > > tied to the creator's network namespace, that means that checking
> > > > current->nsproxy->net->user_ns would have nothing to do with the
> > > > resource being used, right?
> > >
> > > Yes, in that case you'd check something stored in the uobject.
> > 
> > Perfect, that's exactly the kind of thing I was looking for.  Thanks.
> >
> It means uboject create path will refcount and store user_ns, 
> 
> uobject->user_ns = get_user_ns(current->nsproxy->net->user_ns);
> 
> And uobject destroy will do,
> 	put_user_ns(uobject->user_ns).
> 
> This will ensure that in below flow we won't have use_after_free.
> 1. process_A created object in user_ns_A
> 2. process_A shared fd with process_B in user_ns_B
> 3. process_A is killed and
> 4. user_ns_A is free is attempted (free is skipped, until uobject is destroyed by process_B).

We only need to do that if something is legimitately doing capable
from a uobject outside of creation? Did you find that?

And I wonder if using the uobjects affiliated netdev's namespace is
OK?

Jason

