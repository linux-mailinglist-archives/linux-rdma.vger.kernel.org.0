Return-Path: <linux-rdma+bounces-6092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C69939D8CE6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 20:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD5BB23918
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6341B87FF;
	Mon, 25 Nov 2024 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TH1kkUSq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8216DEB3;
	Mon, 25 Nov 2024 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563547; cv=fail; b=YWPQgZ9Hgrvzuxz5GW/IE6mNSG4y4E+tN9r1fe7rhkQgHeg48N2UgD/BRpDdS7mcDWop632G2mzCSIH2cMpD/hN/1SpZhYssNPxkgDoGojmnHlxaxDH2mpZL+yZvxblw6SQ+hQaLOROl5bUY5xwytqNeeIZH2SwR+/y9jQD+6YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563547; c=relaxed/simple;
	bh=Of+olXGy+hRQBjvaVoBB4ss+ic5ZK5kr/6f0bS8wZ5A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSOG4W60fEmU3cQXD65FIKwp5yoP9jU4LQaDU2+s/9Ze/+IE3S2yc43vk4Oc1sJdaWp8v5fmRIq4oIZMlWSVVylC92E2/f+w9vYFdntNW11vTb2zIXhWXw3mD8mYjLFkwoflZdkSYvaRzi6cp0XovcfJ/qixdLsu25bKzybbyVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TH1kkUSq reason="signature verification failed"; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVPzQf8DXqOQUci57p2h8tYrzkK6QGHfpWgQygdL62CEkqgCfJ8h1mXp38BK6gv49iPNPailwICFUb5IIIiO99GOIBa+KH3OxcYBXFqTyVkPcy/p5xEhn01pCiJLubpb4DmAgtE1ERhwrtKVh2Dbe8a8N7DmcO1PUiPVb4cBe/JEd2V9esuiJcrnOmvBLMJAlmHwmCqw1tKuHjZ7ShVI2Pj/+0aJTDbnqWamLpbT9i/G8+clVV8TIQm4H8AGGRMU3GM0P8pchHJ84+2f4dzCera4i08RMUII7UV8Q57CbBnRrbbUUa34szL+pTMKC1NirRkJG0f743QYpjom256Tsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI7yhkMMD8AsOt8qzAvlc8UqkRw+PBXA6Ynx8lea0fM=;
 b=R9dYYkzRXrZL6ckUFMdXr+llDjeivcvBVNTC7w98SDv5KBeVJiR2sEXwHQVRGcOcTBIIXHcY+0ESp+QWrbF2W+ZmvC5DaNc9b/jX0pYreScdxHSXYjD7gRL7uOCYDmoLoy4Ujq6Wu9NYcsFf6HUkaPUaefHIawTV9hBO0aIog+Z02RftSEbT7XxDIKhPsMlORGWvNidFr5Csu9DozpX9Ik4vZshZ+CM1ua2pXsx0ansmbHYfnnolZX4geZcP3ynbaNNQ8878uw0kMfhN1yZ9jbW2GBwxhTWe75cHYNoGFwxfU7u2L79rR0e5sqi7C+m5uJcgb5QGAJcci/blVviVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=paranoici.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI7yhkMMD8AsOt8qzAvlc8UqkRw+PBXA6Ynx8lea0fM=;
 b=TH1kkUSqRMbRD0SRIKTq5eS5arMNbPVkOVZIHjK63lxuZnupI4eAWZePFvux4wItimizVxgEdFB4bPr04PNKX0V9ocnShZVgdq6GCsA7FL3FCB1vmHkU833bTZTmPJFfEDcYUsyc2Ey7sXUhJTo70mbueld2mLF6/ifzdbcnWCtrf9XKD5/L2qbxJ/CMvB8Tg25uOy+Zy66bh3LpwNXzTQhvAkwhUcxf9vRupwnilMzDknHytFYuBTn9UaXOKr52ekzqOTy4aqneGpaN3N/JGdw9Epqoi1dSU8V3jm9OMMl012qHbiosEIS9iTHJK+AfzFRac4a9U3rm+h/SN/FVwQ==
Received: from SJ0PR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:332::11)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 19:39:01 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::ef) by SJ0PR05CA0066.outlook.office365.com
 (2603:10b6:a03:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.11 via Frontend Transport; Mon,
 25 Nov 2024 19:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 19:38:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Nov
 2024 11:38:42 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Nov
 2024 11:38:41 -0800
Date: Mon, 25 Nov 2024 21:38:37 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Francesco Poli <invernomuto@paranoici.org>
CC: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	<1086520@bugs.debian.org>, Mark Zhang <markzhang@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
Message-ID: <20241125193837.GH160612@unreal>
References: <173040083268.16618.7451145398661885923.reportbug@crunch>
 <jaw7557rpn2eln3dtb2xbv2gvzkzde6mfful7d2mf5mgc3wql7@wikm2a7a3kcv>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
 <3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
 <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
 <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 10079afd-17a2-43aa-981d-08dd0d88cf3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?b8DDoez24HB2NW+v+HIiAwDFWVJq41RosCF+sjbN1smxS7ydUSdbTMYQuz?=
 =?iso-8859-1?Q?OvxQQ1msNOMY2pAnwOtkvleSUCbme/4yNsMcuod+oLhm+XgkVHHcNQAYAF?=
 =?iso-8859-1?Q?btstroW+xaCpDiczCjiKeT2nXcnOex9RSVtx+E+4pR3cQOFj8GQoJAlEUQ?=
 =?iso-8859-1?Q?mZ9jtwpVCxLxrkIWPF7fHApAF90KKv8iKhzH1k2zAhAj8/o1Ar6gjj69cw?=
 =?iso-8859-1?Q?7a4nVj+LEycpLL5jExBrlRhNKIBPJwIAlzkYGeCVRnloyfhya8a3xTIPzV?=
 =?iso-8859-1?Q?Gen1/UoZ8lWDCykkiG3fRW0RXkbVo1oB/v9aiz5Q919bhhZtKbM0+CHrDA?=
 =?iso-8859-1?Q?CfeWK0Hefh3jHiE7OSRuAM0Ce1hmSsXVMUsvRdXPeHl6RZh/G2wW5uLc9/?=
 =?iso-8859-1?Q?SDngiobD9A617Nasx0H2Av0nJMKHtC8AWyPiQ5kbQPQgjRdGwTQo/XJaEt?=
 =?iso-8859-1?Q?8y0cXm9gM5/byvsCeBb5DkFHhzjxPzJY4K0CIzFeuEBJdJwtfuPOYJ/rgT?=
 =?iso-8859-1?Q?Kf9YO7xYIS5FL/vBHeLF1Q8fmXOFAfrc74CHs2pgirn55THnOrrhmU3ax0?=
 =?iso-8859-1?Q?Qgi28kcR1fKl/GcXrmjiJy8oMcBi92VcU7n655FDn2k/5/o1gHxeQEYmhK?=
 =?iso-8859-1?Q?kEk9jdyXtxLpPXmck2wDxQimdVyqjRRb/9VJCiESu+1QH16gPsD0H4LKpd?=
 =?iso-8859-1?Q?/9fkDCQ+0h7Vpg2ZYR50Lscxza4SWHMGe8Z/iNHc41q9ReYJuqwKbIilFo?=
 =?iso-8859-1?Q?pxNq/l3u7XJs6y2cvd+mpK7ZIvSqJLN/NkRgEBQjaeLZJXMTDH/hw82q8K?=
 =?iso-8859-1?Q?eJxuNF5KeJidyzoCe7n+Mll2XHJJCnYtk/qyv6l0YJZzARczUapEgdSq4F?=
 =?iso-8859-1?Q?kigT+2SnFr2ngWi7UJEL/V4A31Ctc2sJFTQKgdJ5lLt7M9e1smtRM67Nn/?=
 =?iso-8859-1?Q?V/2q6LF6TcXm1fQAdOckMWvTvQ+opvAQSXN3lukUZykzft1KBJe4hrBOWp?=
 =?iso-8859-1?Q?yCxuBWqjw69Ly/zLYffBwwTYAws9e4LM1vZB6KaEHKNj7RnD5VplV+B9/2?=
 =?iso-8859-1?Q?Ys6CRwZE7xyCNTQgfKEzXndgqM3Z+qv2A+lG/COrCLn8XfogNVhlzg8WGE?=
 =?iso-8859-1?Q?Iy6Wc17tqse4WxViNL8ZzAlOqgnPHS4+hDh3fAu1tH0oaw+0/doAWlgb2a?=
 =?iso-8859-1?Q?a9cEdWsbfhzFrG3kniEvScCGqb2jgmTZnO/lUwfhm/TqHtPWs4efHr+T5J?=
 =?iso-8859-1?Q?2TqnNb2jwWt5hMHjXwGTJNlnF6VI7NyPVlYUR9xMjibKsdUQJgtKhTPVQq?=
 =?iso-8859-1?Q?nr3LW/2SxUi7BYhyYZ251ZkV2V0G6kjiHyVLltI9b1IYlhnQHqVLRJIKf7?=
 =?iso-8859-1?Q?p8GqmHNYusBsZZs9EXMHpbg5Z2/Q1DqZ5D7QnBRP6W6xOeKYJZWot+ZacF?=
 =?iso-8859-1?Q?M08CUtAzgM+2WjZCS9Kw2kHkdz5pI9NTMpXlKtX1YLOhQzqe55N2QMU/cR?=
 =?iso-8859-1?Q?/uOgxNMSLqZAXbK33WuB4i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:38:59.7899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10079afd-17a2-43aa-981d-08dd0d88cf3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316

On Mon, Nov 25, 2024 at 07:54:43PM +0100, Francesco Poli wrote:
> On Thu, 21 Nov 2024 11:04:13 +0100 Uwe Kleine-König wrote:
> 
> [...]
> > It looks like the commit that is biting you is
> > 
> > https://git.kernel.org/linus/50660c5197f52b8137e223dc3ba8d43661179a1d
> > 
> > So if you bisect, try 50660c5197f52b8137e223dc3ba8d43661179a1d and its
> > parent 24943dcdc156cf294d97a36bf5c51168bf574c22 first.
> 
> I started to bisect.
> 
> The first surprise is that 50660c5197f52b8137e223dc3ba8d43661179a1d is
> good...   :-o

It is good news, as I looked on it all that time from the day Uwe
reported it.

> 

<...>

> I will try to continue to bisect by testing the resulting kernels on a
> compute node: there's no OpenSM there and it cannot run anyway, if
> there's another OpenSM on the same InfiniBand network.
> However, I can check whether those issm* symlinks are created in
> /sys/class/infiniband_mad/ 
> I really hope that this is enough to pinpoint the first bad
> commit...

Yes, these symlinks should be there. Your test scenario is correct one.

> 
> Any better ideas?

I think that commit: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane device and port")
is the one which is causing to troubles, which leads me to suspect FW.

Thanks

> 
> 
> -- 
>  http://www.inventati.org/frx/
>  There's not a second to spare! To the laboratory!
> ..................................................... Francesco Poli .
>  GnuPG key fpr == CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE



