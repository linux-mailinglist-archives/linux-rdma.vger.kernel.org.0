Return-Path: <linux-rdma+bounces-4069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CED93F76E
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 16:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D421C218F7
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267D153BE4;
	Mon, 29 Jul 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLlkvSFA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F961E4A2;
	Mon, 29 Jul 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262814; cv=fail; b=LRELay1pgLjtw1piDqijB3/76I8auZGLC7sr6c9rAcgzwk8zKXeJX8vNycDGvMry/O83YbLgT7GDcOAh/FFOQ75trtTQg3Imv2rgzjo08+nCACtQtavkzn3rRs0WlpGDiFUG+rIqvuXEh0Sv5Q8+qBVJkf0Bup1OmdQb8s7ngzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262814; c=relaxed/simple;
	bh=fWx3zvAO/F/x8Kmzfx+fqg7knmJhVZJcleWYXuYiMPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qt9J/BrNgwYE36eD8wMzej7AIetiJDkoomnzBHHOzZmHeDrmNlqdVSLlZPLk79uZRNdaeXqmX68WQ0rIaNyyaiJXkVIZUaT3K+V92qNkapfsTkOwrzsSlim8/T6j7AxBHZJ/yQLV2x/stJevn8BiufYghH5zXylebsAbwzj7tQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SLlkvSFA; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3zebbY+1bWYlj+ZpxpUfb5D/43y6i7urSAyTui7IPGd8dYADrG9nnjRpwkKVLLrrUs4WTK7Fmi0cJeWKVv2Y9XJODCt1eZA1srxbId4RUKeX4T5I5gU2e1kZgf/DiE0QMQRVa65QFL7kCLDDl+GElciw43R8ChCHtARvtBpCXNqPwA+lCie9EPxCC8sQBKKxKK3wyrjVvuivrXOnJ4U4NBOmdwHABclHFpdo4MU/kyfdB31aVWQ/sfwJ5sj+6g1S1u0EWHNb2Jzds9jNvQb4lpbNCzq6sIodIEQbnhYhBqrsPnWmBt32e8vatd8XKfllWteApoUzXbIX1jhVpOV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWx3zvAO/F/x8Kmzfx+fqg7knmJhVZJcleWYXuYiMPw=;
 b=eplSpmo7aQJQMmNsXV+n2Oa/0erTswAZaqCoWbHABLhznAVR7ZpZCOMayyiC1jrfW1OxRaihICZZsj+Bik/tswx29shdzrUO2q495HfuYkOvfJFobrIhazn6Kxkz7UGIse3GZawgG3EgVkF4ubWUc7yagDIoy2V7UN7uYHX0qzny9YF3D1JK7ELADT2bpEr89yBJepw8J7lzmSyqhizJ9EsxzglVv5HBtN2aoypgMYkVnXXNQDnMbYBKcxmQO6QG5x2hQohOSQM2E5+StCAnsNojeJ2OBmPJzSKbwH/F2T+FSOn0hDrbwjOY+/WROi1akVmZCCRnBlyVJhKfL4qNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWx3zvAO/F/x8Kmzfx+fqg7knmJhVZJcleWYXuYiMPw=;
 b=SLlkvSFAwu6DltHXfrh0ddSol/yjQ1OJD+gabbNEpMs2AMhSb0mdeRBGRqyAAkkFg0huseH8bW6qxFODeCQslsx+SauOtw3RaAsiR61pWUGTxCbqzGVuGVkcOsa0bXehIvZ7l1OLM9IG//3vjhO1MfIyLxdlMmn6vIkFW9YOicFtIuRYeJxMIxFWJvEJCHfgWXcP3DrIURWokvrL/ucCi8365D3ylXieShvXsuqM+67UwtPW/5j6ZScX/OoEIJ8FYQkIcAFVmM5khr4Oxo+1KFDLlCrBmGNwlm2/5TmcqTUi5GI37KmBRL2bXS63RQ/M6163IfzRiPpM/hhArfEohQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 14:20:10 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:20:10 +0000
Date: Mon, 29 Jul 2024 11:20:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729142008.GC3371438@nvidia.com>
References: <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com>
 <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com>
 <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>
 <20240726124949.GI32300@pendragon.ideasonboard.com>
 <20240726131106.GW3371438@nvidia.com>
 <20240726142217.GF28621@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726142217.GF28621@pendragon.ideasonboard.com>
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 306df15a-42d5-4bbe-d357-08dcafd98da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdL6dzkOmVVZL52UKtd0H2z10i2Pt0kpKGykFbglq2R0gGI55O092gCvyRqA?=
 =?us-ascii?Q?RE8AlFKytURvSWF/efthV5ehnNA/zbTDuJxzDEAbS+HBkOvjKzrT2l9eRRjU?=
 =?us-ascii?Q?c5hqd7E/AfKtGmNZd1XNsZrsudbXbRjGPh0g2Dmm99L7Dk31eV51MSltrYrb?=
 =?us-ascii?Q?GPHfSM1ttNITBZF2zxNTiSMnI9VB7LhTTmNZWWsS5YE3EOcqyldabrBDfw62?=
 =?us-ascii?Q?YLmASAUGt6oLPBs95nZJL4lPMCGsmfcJHXffZF1sFV/5cpb5qWv/B9Z9DGAR?=
 =?us-ascii?Q?PV/Uek3qWJTZIrLV20U9XVn0JfGT329fFMgni+wYwyac4tHPcXUybUS8Z9F3?=
 =?us-ascii?Q?BNUdA+pwcRB1WDOLZAPyDRHuzhKnLVSnHbKP9OJoFovTd/1OH73QwmPn5Tmh?=
 =?us-ascii?Q?KVzga3r6J1u2ryC0foG6d8hWOSW9zC0tcCdoDMZJRPSyB3fXI0v47gys3pL6?=
 =?us-ascii?Q?zPLidfQtVseKtOousl0E5Q2Kg6JF1lLC8XE5j1rwyD8a/GBOu2I9NGzZz9v3?=
 =?us-ascii?Q?wVxFwz4Wkk8912eI4gyJXYi2CmpLdk5fj4hi/8fADk7YSv8M4bxU9Z15cbcc?=
 =?us-ascii?Q?85FCJEEJbtfcRRHevIdcPmSlDZLc0rDHu1Vbqt3Ovj9+IShajTvXCseb1iI5?=
 =?us-ascii?Q?2/6ydkKeuFSfg8Jj12OY6ut4UCVhUmZg749eqD6GF6Gi4C+RqpWs98CAoFPX?=
 =?us-ascii?Q?SOknm26ZnXmm55nt0wIVA8HTN/brv1UZORcnZRZjxK/KEeKnNTL8sgJGbA6q?=
 =?us-ascii?Q?tsmt9VEP2YpIhf6XI3udc+TrmAk4P6uZQ/173qXrdU37JNNpd2nkB2Q8aldW?=
 =?us-ascii?Q?ildgYQWtM1jXW8xpk1UdG69fS2wwWX7MJEVIZImS3+aOhTBnYsZaTYwJ5AhQ?=
 =?us-ascii?Q?H30CJEXWb9p8d4x9Yb5ZX1X2mXlnzCOHkgcnu6PyQZSp8FnSFFDT1Z5KLdfP?=
 =?us-ascii?Q?8LJZbBYfDhpzKXE4miHh899ApAKOkDL5Fg2OB7qZ+KPr9ZBG0oA4gyG8cn6t?=
 =?us-ascii?Q?aLSw0se24XEQtetT8Oh3yjwN/RIMyXKwLFO0x67+sXOhisCpuGHztEwaUDUH?=
 =?us-ascii?Q?c3cq9NgUbC1BcOZuzOjzbOmGxpXSfuI6o0cwncXlKYFZvRezRbRayf+dVaZU?=
 =?us-ascii?Q?wF2AqP598ETSlDAxNrm3BFCd0qVb4/aOab6OKn2pPiwHxIFolJciYPDQoPlX?=
 =?us-ascii?Q?HEdyoLtodZ+kWTEaJLVt29BjoQVxxJzFVjnBPTf6vhE5uVhs0ze4JpT4UixS?=
 =?us-ascii?Q?o9YfJ36TNxoZAVuhpmX33vUFt/jshp8QDlARnVmY2+C1Z85VV3wOpWDyFARb?=
 =?us-ascii?Q?2rGn8wMKFwkTOQdfyYpxelirIe49AzecCC6O2WM/R/1TVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Abvvz1eSpzd/LKckVwhKZjX96aoRAeBh2BE/tjeE4PHClg4EIRMgb5THmXZz?=
 =?us-ascii?Q?Wojmy2+RjeRxj4dkNSOAhrpR7E/bnhJgTeniTe0dd+oFN6cDZHpJ6ij04Uux?=
 =?us-ascii?Q?fUTTctzS3gd8DjfrtOEBQyspgaI7pB0ErTlJ25Ux8wDoBQBMVibP9LartgYD?=
 =?us-ascii?Q?ZBt3T1UTEkluFXEZ9QkTaPo4Xi1O43k3W1etzPxnZ5viJkruT4DE1Q0YDNGJ?=
 =?us-ascii?Q?v1ctPetthN/dEiffgoZ7ucHn/BrpuDtiin3tEMU9wireCezimNTh+ku3Gc/x?=
 =?us-ascii?Q?NGkZgEs+eBFJClzxqyW4na8vc79pUjFNrRWBCvxWGHAjcFMkaS3cC/6Z+zO/?=
 =?us-ascii?Q?ZT+GL7zciFgD4tTSMVlYjcYqndRKiT98rueLyexIVUiCc+YIpwnMteEtvplJ?=
 =?us-ascii?Q?dUUj+fN/EpyGl1+hkXKIGL5M9kVpXibt/mUB9DSybw8QaszbXQfDYoh3FopY?=
 =?us-ascii?Q?tH66YTSJh/93QmWR7pDYGPrrbVAxktE4JqfQGsskAkMQ47I5z7oFXF4OQ5QM?=
 =?us-ascii?Q?Q5r7LDxjc2Vi+vl2G7GkGGaNqKCt0lCzLkF3uEfgZVagFMDpWQFe5WC4ln4z?=
 =?us-ascii?Q?cHtFtw4jG61Q47vn7woVp+n8kUD66ggMhDrv5CPpuKqWcB/83pzd/wFvkZ/H?=
 =?us-ascii?Q?HWRogZqTqAdSb4O1t4k0xO6BS10M6m/XorTXjBPxRJ7SNJGTJp8NO3pvSYhp?=
 =?us-ascii?Q?SowLbbphID99+ZSBcK+c8zbubC+/L8jFTt/eQ+D80JZu8jm0ZJ7p/+7ypXdC?=
 =?us-ascii?Q?ic4RXVAzclKs7cxqRpcUc/W5FUWRsDanOBO7ijoBSZsUbUBqoJXcT1qV8/Hu?=
 =?us-ascii?Q?6kqpidbYet3ScG8CoeKil0adKYNcsbmPdZPE3F0Ct06v3igz+LkQYzOq8YQe?=
 =?us-ascii?Q?th6VaBRnGrbi3uEtzeX+CY5Q1f8fzbdNUTCua2j1SZ5WCkTd36yuWLr6+Rr2?=
 =?us-ascii?Q?wXWoa3fk8fLsQ8qgunEri1tSaYU9rQXNVG1PPvHbKDtJZr/rBUPWJjSrGg85?=
 =?us-ascii?Q?XSI0isAtoQH5sI2ikpL/RDDGl30jvGYogDqKpDhg8A6i/+P1kjcDXTwCqEhv?=
 =?us-ascii?Q?lBd8QZhPBEnuT6EqrPH+/qAZzFe+bWvvEFwlw00wcJELCy+p5YWXPsgSXWyF?=
 =?us-ascii?Q?VEnuYRpqRWwJL+Sm4YRNMBnVNs3Y9fGE/m+mGE1VFyaetbVbnXw7U58Rmb51?=
 =?us-ascii?Q?nOL054P0mVE49UNzJz7FRccUqMy8a1lHHhnq1JghFeVmyKBFwNA10bVUCfHn?=
 =?us-ascii?Q?hYXCiO8kedGr8UVoiQ6AKGMH2OjXLy3VZAlFzrBcfK3HRUrJ48ExS4qY5LlJ?=
 =?us-ascii?Q?yFjf208OZ6nx4cOViRFyjXPHNI/SeKbxIQ4S8WHnL4K2oGMIlYDH3g7mVfot?=
 =?us-ascii?Q?eWQR2e8I02N6G+y71M6z1VKXZxTDz7GMOxM60FoT3vNVpDGdVhpxfNWTAH1c?=
 =?us-ascii?Q?5UAWxKcjfebsHyKHF/x2qJkBVbfShrvWMZinzbdpFgrpT6o+rMfy5XUtk2ae?=
 =?us-ascii?Q?rDIIxoAtsGTZ8YJ0oCLnv4vkTtWlKzjGAXjgIuw1fpVE7YgUeJaaCJGBRHPE?=
 =?us-ascii?Q?hMh954hSAFXspnxrTsw4MuxikrHHvmI7AdE1Cxoz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306df15a-42d5-4bbe-d357-08dcafd98da5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 14:20:09.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qU+S7x8Ao7Lr76DdksM4/peGzeQDUZJBBPEn212mee/0IIgqgmOU2GtIW7Gc9GTi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992

On Fri, Jul 26, 2024 at 05:22:17PM +0300, Laurent Pinchart wrote:

> I believe the latter can't be solved technically. At the end of the day
> it's a matter of trust, and the only option I can see is to build that
> trust with the vendors, and to make it clear that breaches of trust will
> have consequences. A vendor that deliberately lies would end up on my
> personal backlist for as long as they don't implement structural
> solutions to be a better player in the ecosystem.

FWIW this is largely my thinking with fwctl as well.

> As for the first issue, I think it's a difficult one as it is very
> difficult to quantify the features covered by open implementations, as
> well as their importance. You could have a 99% open command set where
> the 1% would impact open implementations extremely negatively, the same
> way you could have a 50% open command set where the other 50% isn't of
> any use to anyone but the vendor (for instance used to debug the
> firmware implementation).

I think it is likely cameras, there are lots and lots of use cases and
scenarios. If you focus on a specific use case you need everything for
that case. Another view would be how many scenarios and users does the
open stack cover.

> I'm sorry that this discussion is turning into something very
> camera-centric, but that's the relevant area I know best. I hope that
> discussing problems related to device pass-through in different areas in
> the open will help build a wider shared understanding of the problems,
> and hopefully help designing solutions by better taking into account the
> various aspects of the issues.

To be clear I wouldn't imagine fwctl as relating much to cameras,
maybe you'd use fwctl to get diagnostics out of the camera fw or
something, but it shouldn't touch the image path topics here.

Jason

