Return-Path: <linux-rdma+bounces-2886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E538D8FCAD8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EEC28A4FD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9814D447;
	Wed,  5 Jun 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utxQFb6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D427459
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588084; cv=fail; b=iG+9VlBAEDBmCh0zwg5+c0B3CTDbLfJLLXeySGBWHaqLT/A8NqRGSGqxULEuSLtIb5Y1PtSqKWe/FtfxZCCKLR3ltqVlpuhPkhKbEuA0MeadMtwEe3WHP3yUuIXsdi0OJbhX96oAJOaqUAX3q1WtqoMiKZMR9kD+QKDN7gPMslU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588084; c=relaxed/simple;
	bh=fsD3TgfPHC+7zNcZlUtrfbCZfR7nNeLilLzDocTpTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QlESuug9a0eQYAj5Q+4KYZd1ss/NMAVJ6XR6N/anB3JUP9Wvjl/ufL0NJg1nU2HQmSN8HwjmOldjW2lEan3b2fznkbMG6yYxpafX50wlOgYO/wUbr4w1yBzdmkMA+0mvs9zLLX1yX/rLx+utTFWG+vO0fKCEeYyESpMcJ7o8SUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utxQFb6/; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fkzm9u++5+szt2J1jnISkoHXPDXPBIgvnGPVfvO/14ftw0CzgTPDSSkv5oxi86yMA47zpb8duAOO5xfBVbv1rrZ+J92IxtEfZSqOEVuzlALm+rlRCrDebisX8mz03PDG3auffAryKuaowrRoR/r/NlwLqaPt7tjEuOb/CZtHc6QRxpcrfkiRXkwmYjS5sY53zbCKiGw5kY5HuBvmiuU+u1vIVAtqY1tiYPwHHiTdI+xaVPszp5CtcT8B0pHptMLhIwk6JhgIE9PNhqy0vrcTBDf/8NEaTWpQHSrHkFimpyqBZDQndq33Y3hkaxzkujhsRQq34CSpYouLiN/NM7NJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPTOZJr8irPmyWqH+cXrAA9IjUNEtdFACH7pgyOH6ZY=;
 b=HFqPvMReXXPD3ItaYMCzPUHVNJ3ld9MlO3DyeO9mJRf9jALtzpvCXA3W1bkJDv3tL/2JDutaw+eV7EW++sI1IUaZmTEB2FtkCM0wTYDFtRtAa9JyQxl/eIeNDAQc0rSXtixxNDNmywul1dISLSOParF3fPGIRTVBrnB/K9YdqgxRFJVdgeTtLmmamLRniFk/b5FEwN3ZhrtC7ONH94/50QuYyUVFmZSqJlHpaSOZkkGfLIOaxleuEWiKWmCPVj4pPp9vYGEFsx1cjF6ZERiimxh+xulF18wEFgFKi1jIE7iRnWBDUJcXjEoy8srKOjRDIF467wXUZmryAuR72UyezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPTOZJr8irPmyWqH+cXrAA9IjUNEtdFACH7pgyOH6ZY=;
 b=utxQFb6/ja7yD07xZqRNFgtaaNlyEHwT38dCpPrwBThGFHHj2YOrdCmRvxc7gOVoXH/GPKIkMu+Na6VXozYdzIZJWCA3KmG1V3+53vjCYZPz/BeFSWKwHlkBIhhXCzqUSkhg/JKDTV4nOQe9cOXK2GRCS6byOr9FiF+t00EHFY+0vew3AzE7TZw27Yjmy3rniyoW9+CCmcZEo8FBrQyZculdqTKKt1A6sY28Fd1MvJGyAPlsvvBlzLmgPcz3qNEOdsINAwdBA5WxPG/HSAHHef5teVaKt7yNYeb3J7OL4UYPygDmlMzMkWGJmEYWZQ9lcuiVtKBhJcch9SdadxkRBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 11:47:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:47:56 +0000
Date: Wed, 5 Jun 2024 08:47:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc 1/6] RDMA/cache: Release GID table even if leak
 is detected
Message-ID: <20240605114755.GR19897@nvidia.com>
References: <cover.1716900410.git.leon@kernel.org>
 <a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org>
 <20240604163636.GK19897@nvidia.com>
 <20240605094456.GA19021@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605094456.GA19021@unreal>
X-ClientProxiedBy: BL1PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dba5691-e121-4ee9-bc12-08dc85555775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ki+VN0ennYLNAeHQjxdL2FnwRFMJgGPsm18TuW+agbQHvX+To0jnf+dsDW69?=
 =?us-ascii?Q?jKVvT0iYhOu+TJ75rs1KFggela021Qu8wKN8cZWd4oR6wPKjDlX6gwZlTuhp?=
 =?us-ascii?Q?5bPDZMB5fBtLEhTQlAHDfc5PC5abU4MenARCsGOXK2yWVlC1gRCMElDzchZ3?=
 =?us-ascii?Q?jZYbHhtcQV/lyGljxqvbNM/3pZaw6TR1cJh1nYpDtKTxPF1xkaJLx6+co2D/?=
 =?us-ascii?Q?QrKSxgYCNmCUgJDY5/jrDjlx29cnQ/QAbrE0reJPt/0A/wVBmvdM5/6ofmlz?=
 =?us-ascii?Q?XG0tvF4aY9ljvyN1lxj7uKeuWwbwLdf6oHxX0yXWJ9vVY9YZI6EIOH0bZxyv?=
 =?us-ascii?Q?DJDLuCfdnwsdbWIqDQVUu29rUCRAduWpcMyVpsDFWlEVWKhcrI2iLO3Y7cM/?=
 =?us-ascii?Q?G+JUdzYme8GH5F/yEBlU/ESnvgIr4vvTAel0EgUw6ES8Cx+DPBToRzlcC6hp?=
 =?us-ascii?Q?/1W5Qe/z2DNpbKewOn9tvBCCMMEmlAyL4gXPTYnNyRYt8BQ6xIl8b+zVmHKi?=
 =?us-ascii?Q?dlVRjvFa82pv+UfTC0PtosqBWWgLVe1m12/VD5yZPVkn8CFWdWyjyOz3nwiR?=
 =?us-ascii?Q?NHnj5P3y0XXUOksOEcpKl90qUzw75itKL80zf+ywfLJW6BH02hF8zsPa0UG6?=
 =?us-ascii?Q?wVXSx20K6AhDg5euK0PXYbmvMINTU/OOIKSqLClM1j8u3xLnYD8ZQ8OqO1sN?=
 =?us-ascii?Q?CH1myDWChlEC3fcPnewmdW+qEx2VtN+PEF67wbtHBo3nU2HpfIC+i+K2zyw0?=
 =?us-ascii?Q?4SyOTKZU67nnI+Gzx0T6WAN4vzP6EC6cf7AKgt/QPkrP+kWoV8NXi2cwwdpZ?=
 =?us-ascii?Q?PlJskn0sD2T1jjd66p+mmo8QKI9kQLjCof1naXaVND7cEqgxKGs7befUueKL?=
 =?us-ascii?Q?sEK7U2KeaE1vqmwtJmrvyt9GMWFeT2FpTALQveuCi7bv86iUyGoDzqM4SrM3?=
 =?us-ascii?Q?nUnsUxMUOWoGXiZ+8CGw4+iijc/c1gTD6H9Rs30bcwPDPflwcZRkKzTv3uu1?=
 =?us-ascii?Q?jyBs3nsCrjRvcDqS8lnBpMAvzoQFSu/gvi2peWOM67awm8bJ2rW8bW20yY1L?=
 =?us-ascii?Q?Eyw8KfaZbctQlzWhQs5ECre/aEDvnyzBYKv+/MjsJaa4nzkc4RcPrDhs5dGM?=
 =?us-ascii?Q?E28jD+r6zxVPae9+q5leW4rcRiZPkXmLmOs9ADbXwpb/vXCOeXzRFkqJPuf9?=
 =?us-ascii?Q?2AOeOylCynyvAm/WeKLypuFI0XzLKtWOiR0eFgpVEhC33AUsXVU2yfTTHyB3?=
 =?us-ascii?Q?1Epe6Jb4JAFXtaBNgk/klQZJiNMz7F9+8zklK6PA4+OHtEkaOSVr8RMEW/BU?=
 =?us-ascii?Q?1r5ZLeNNAw23sVdi8YTNloxp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQgvUNz9Feh+SCTPQHvmxbjFsDWkyDM1VydvHS4RTZ7wSk+a3iqVhELQLweS?=
 =?us-ascii?Q?Y/NoFEXABJZR8xaRwZ7xHVpAXUI21nW32TLV8z7xax1npm7bY2Hg8UUfjc+x?=
 =?us-ascii?Q?YbeA3IGD/km9nXWucoI6vClPbrm7a3JZmb8fEBVnNmSq96q+xuaD5Nf1mjwe?=
 =?us-ascii?Q?JriUfkSBQC7XQhmETGyoUhcQEz2AoFr7xit+MV5hcfiu0tKeEg2NHe3P26qZ?=
 =?us-ascii?Q?liPMhovGC/BiPKO7qsZmF1foGOkgjrUo4zspjDyLkdpYZ4GfUu2q20FkLb2X?=
 =?us-ascii?Q?jf1FsrXpLuKV7tPgp5AIGb8COhFxIM0nUiGEbmWCGfBc5d4vVqEwqVZoQWwl?=
 =?us-ascii?Q?2sWsdkXdmfSSRCMCEAoz73TPEo73CFV58ipkySyLa/uWE/N6PVcZp3w/Wcri?=
 =?us-ascii?Q?U+vHh6jLq6tMITpK4qdle+UUOeJ5BzspG35aqOdV8AxConTi9ueAx4+gNTaV?=
 =?us-ascii?Q?VIoI+hfrxNd47c8WariZZ51WqQmOV5zmuYG0qEW5SuHMOMv0oL4FfnaP42nR?=
 =?us-ascii?Q?kLIBggk7sDnnvebaw20ZG7Er20uXCDtDsPAwbV0T55sP6D99X8s08+KaxKm5?=
 =?us-ascii?Q?kP1ee5zRIVv5tCXYcZf521W4U6H2TiBTf7ClRowLw97doc4Rq6rSsqpxBF+t?=
 =?us-ascii?Q?aMUXLPJs4o1AGf1AdosE8nJfI+gQjMqWlOuPXmePLos+/VzCmOFEQKGMQtqd?=
 =?us-ascii?Q?gutX0X1+2mtlRhplSHzjaGEzBPGggJRlNpNFMufEX8A4AK8LGckBQt1RLxWZ?=
 =?us-ascii?Q?fQhsp9HoML+Cy7qDr+njzTpJrpSAhx5IHIwNWzZ5tb6FCYGCXSy76mNfbTg1?=
 =?us-ascii?Q?JlObVClRZ4fDN+c3pxcKEJr6qUesiGH5gjXhly1+pAz0HsaTgngICXA6uAys?=
 =?us-ascii?Q?PmKzMm4NDowvSIniPrRIRpslC3iUgj+KuLPKMiHvRN5OggT3OFIDmhp3TCHl?=
 =?us-ascii?Q?Is6igm+H5cYcoeGyX0yVHCBSlGkLEdHMQx1I0EpkSQIZAWBJSX8PBZbx4+Mp?=
 =?us-ascii?Q?d3cT4M+pTLn3RE9MQzc3dV5FB6Rf5xpmFc1IfP2w6PYqT/EO+QqGus1M+7Hh?=
 =?us-ascii?Q?J22+Ko662/AhokNRtDLjfEnu8n/pcooy/wKHeA1VGqbaVjlMKpV2rtcPPO8+?=
 =?us-ascii?Q?+OUaWFHq32qp5gAlkhVFaxplPv4cJUc74NiFdXzq1LJJPSIey7tqwIdunhyg?=
 =?us-ascii?Q?RmdAFEMZkZCLWdBL/H8hP2LJbz9nXtZFp0YkQc2KKJ+0kIKGcVFy/tlvMd1g?=
 =?us-ascii?Q?46tFO32g4WiPtNidLLw+HZ2iMuQWZ1/okjIfhDplomPdDNE17LrsCVvwXP+K?=
 =?us-ascii?Q?A4KAiWkt8s7T2G7GeSHQp1qNsCwAYWnyimHluOwf9s8Yd0D7NPBKTP8I7rZj?=
 =?us-ascii?Q?rAA+aRBEMdVBbmmKcw7e86OvWuLr5GyHU2x84E9a//OLthpueNx+W+0OgJlB?=
 =?us-ascii?Q?/q97R27Nu1p8lIdIoqEpp/y5jhmUXphR+Y8PMd+X1Rh/pQWTMRRjBeJbMI5P?=
 =?us-ascii?Q?3aMhfEKbBkn1qYaBWeXS51nWvEq4kuewuKE1UbaXTbH6z8T5YwMPvECjtyTi?=
 =?us-ascii?Q?+odZDOXorpeBtq1+nE5PkZMRN1QUCRAOc+0MX6tY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dba5691-e121-4ee9-bc12-08dc85555775
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 11:47:56.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BlBQjLJZsow7ckFsj9e+GBaY+LMlX5VC1PvHtXaWzR73foFne8V5P5OCYzTswds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337

On Wed, Jun 05, 2024 at 12:44:56PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 04, 2024 at 01:36:36PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 28, 2024 at 03:52:51PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > When the table is released, we nullify pointer to GID table, it means
> > > that in case GID entry leak is detected, we will leak table too.
> > > 
> > > Delete code that prevents table destruction.
> > 
> > This converts a memory leak into a UAF, it doesn't seem like a good direction??
> 
> Maybe we should convert dev_err() to be WARN_ON(). I didn't see any
> complains about GID entry leaks. It is debug print.

Yes WARN_ON is better

Jason

