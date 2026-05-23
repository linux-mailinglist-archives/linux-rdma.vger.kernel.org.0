Return-Path: <linux-rdma+bounces-21199-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKmFHRT9EWrjtAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21199-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 21:16:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A275C06C1
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E8F3016536
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE73334C1F;
	Sat, 23 May 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O3QEdCpb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81126327C09;
	Sat, 23 May 2026 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779563787; cv=fail; b=KZgSC1gCpIWuTRe5T+Ha2zEYRFd/muAAzWFj6Z+z9xhefCj0sI+Wf3Zl9gjJirdzr00lntomfZzH9u5IhaTvug6gyCgus5gvj6NO8kH56CZzpUXCbkrPEdjuLPCcML5hjyOza8/YzYpsQG10nPWIqwAA4UN7OhD57jki0t6GLxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779563787; c=relaxed/simple;
	bh=s8ClcPCpb30O0xaK/c5T/iZorOlzBUuNEDhcKcPn/0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fKvpB1nGHUTwuXMyXYHrD48VeO9r0KjTc+rK2LdcOewTzpZ7cY0FFHnC9PLrkKZ3MqonYnm3cOVSfpsbN8IXk91XERGLm8jq3qsFTuDgadvMTfUJwEAyTZWUH8lcaqNl1rbFfqaLNNs3NWVYi8FcpUAJSat/mztXry3/M7hBPds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O3QEdCpb; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRc7QdkcW2a5ZtDjNQz8hsoPhRC03vNmV+dmm6ANNV8WyX4hLo8dLNhqYRdTXCoLdOmlBlM+qhfmdXygVjJAnbQDn/1hwtl+3f6PSDqX65bXslZkP52Vyazdm7XDZcZk/XjlqM8iox2HV8NvvUxOzt9ruoZ78ts1DC7oRPbP9r88VNozwHYs4zcXD0YJaC7gTQuGLqFAW5Ik6ocoe70eW3KItQ2D1u4Io5HnjD5elbrCfYWJn0JJ+MNprx50N5vCvC2equ9VsvWAxio5VqsvCzCWgyA9Xc5OwL3nLfL6tetqDgr0UkChO/m9yEAAijsRXXT23oM8Kqt3nx+e8HqSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnjwDrs6lA/2vf2+gkmczwjoS9xoUztMig+VrT9kocg=;
 b=lr1dujvEF+JWs3u0UuYT+0XgJ/bMzz3ajmRe8oX5UVjJY0pS+gr5Xr7u6cnnh7vJNXV2NiVFwpcC0cNlRGaNb0bnMciCFiBX9D9ybapjYb8kZT2Xf2TNXAI2p4T/ClbtYfoEIuD75QIV/wfXqtzOZFMeEedj3SNjwAInFRVdIVzuLGvxLAa1q6F853uHzezoNW3w4IO+WZCpU/WLn2/89+ANtVC3rU9MadT9oRtJ9KBmTxZ1VWqQTNWqiTPKlH9P6yiU9w2ahQvcxRTgLMjqVnsyQWHs3IRCAzYpIn3IxdV0y1kFd0FWFY62bXuK5WLecSnJeeP3mhL1VnL/Pndv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnjwDrs6lA/2vf2+gkmczwjoS9xoUztMig+VrT9kocg=;
 b=O3QEdCpblu3XmKcgd+KeMqSdDhOa5YMXEIkoAXCki0jPWBnkdkWN7nnKsexCbrYbsT2ISMiM2JJ2l2fhiYSvsACVCplXIkPGMORjhwRoczG5BWXVRGs6VD8cmoPJsjQziKibJe4/YV7DcTnSWNCcXG6DTo7/fcHOH4LAPqa+vcJhmunz2GNf2HlwpEQ8ID3fb9dwhXmQsxXjtRLWF4eQ6lawSkVFUi/sVWRU544Ikvwjm9ZDly/BaOuSFan/ZyzEPa6k5zeQmkZGTNZLcvjZ1AvT1JqZ3Qs7GL+ZmuICe5xUThRo+7zcU5qEb/kaVuW/2c3og48rww1Aj5QlZYzQsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 19:16:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 19:16:20 +0000
Date: Sat, 23 May 2026 16:16:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] RDMA/ionic: Support QP transport mode selection in
 create and modify
Message-ID: <20260523191619.GA1605401@nvidia.com>
References: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
 <20260430123931.3256130-4-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430123931.3256130-4-abhijit.gangurde@amd.com>
X-ClientProxiedBy: BL1P223CA0034.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc0c3c4-1670-478c-c1cc-08deb8ffc56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|4143699003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	QgMDwU406kMYhoy0Jp+tMQN1AoR4FuL01+WHvGVBYQSG2JYU6bZdi7dtLAik2oYZBL2QWtZDIGJToSid3ZDvK5NSi8Hmc6OkhanbDVYHUjw8PlpuUlbcA79lK9HvuY15OfL4d+xZsXNt3N4JoGiWl/tD+gGZ22nr+EovkdWEhWoquSkryumvSh8EG8Z/BRjJtgSctRbr/Bqb8HNDsE7rRWo9l6F3pGNfMLwMQusNNVa3ulOmwhMKmyIUqYkcuO9tUxlOR6Qz0wSbwxN9St+IBuQvWrem6eB1spChRmA6qbLDi071Px8k5dICIhWDHacx1HMJxkcVyN3/ilfgT5SbcNtK3lX/zTmTyWI1MYpgh6+nc4WPFtRQkGODbYX2dPIMLuj2H6NuYVcrT65HXnlNI9yQA9Ei0lZFTTAs7MK8G5RXJF4SngoKPHb+CIajaG/IvG+CiYLQf1Me5AYz99YTSHdIibE1fut2WDoy7AH1Au3mxlPwEmtTt5ojqKaWjWvXi9qOf798Q2QBs0fNFfOoA9OVHVOYs7zvuDfMqpg6Dd3PpTrbRL9zlxTkORhbeY9/msyAxZeM8dTQxmF+bKg/CoFJikv+iT3NavakRc/0bb8E5Ck6fq66b67GTozYLGQ5HkIrIH0hZJ+SJctdbWGFu4tjWa1YBRrmiZw68C156TMTinV2C5zv/6y7T1E4SE23
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WtdHDwQi5ARkaxWuoGWvaPCGH+X9BrXOO9OkwsAMNo8ksvqk6JNE3awiNow7?=
 =?us-ascii?Q?f4ZPJwtG9bsFEQdWSKqB7cKW021pxzl5rmhoIJhqn8qPWUYr1Cy1RNkX/+Dc?=
 =?us-ascii?Q?M3YcE+PI08MuzTaVPv6L+SlRxPnWul4qxMii24u62c8sMMzlk1od6BblrgnM?=
 =?us-ascii?Q?ffR/hATSTK3HzetmlUCDAy/ZRfEWWXTIWfzGuW1a0BuZUs9ty301bkKCb3k6?=
 =?us-ascii?Q?9RmU+KV9nocDb7Hv8jggE9rfCNPbiFh9QP4efq34Sly/7Q5dZ7UztpMriNgC?=
 =?us-ascii?Q?IrttPaFefd2u5rDD0NPGQyOgAMTcL6rwZ5oxJlBqzS7BezxStH1fdWu7Pqak?=
 =?us-ascii?Q?TKAtysqH/t8u9B9Jmuamj+xBdV0UnBRvOszhc0TXcdNLi4tvq9y0Cbz4Q6ur?=
 =?us-ascii?Q?2qe7ZZMVaN0d4wM2rvu7gFIDDhiF5vmSjLckr2iS4OqF6G1hK7m0iz3AO/QN?=
 =?us-ascii?Q?EgzDMgDF3LqX/bnm1Pmmadf8wZmg38tQC5grJHgwB+qldQIqyh8aMOd/WjYX?=
 =?us-ascii?Q?AHCarXOSerV2nO5sKeo4XAPXZ+i7wU4hsytyOI8X1aagXlxmyvGuaqDJNBb7?=
 =?us-ascii?Q?t2osR3bd9fLaBUAcV0coCkPTZgCHMENktya4o8LuV/6jQ8Ysfu9tGzmFXol8?=
 =?us-ascii?Q?EVFh+iwQTz79wu+zUc1ghOAxxFaLKp2t8cGqZOrFN22EQy7cFbFucPo2B9I/?=
 =?us-ascii?Q?i21/DPuT+DMaH4WIBeb4UDz+HoQxvTU02s+/mcqry+mk7Y3VWttlYJ0pekyZ?=
 =?us-ascii?Q?yZGp+RRvCc+uVLGEhOE57LIKhWes8s6pdHccj62iuaTNdI5YPHN5BFdL7JXG?=
 =?us-ascii?Q?acyW6qDKIOPcjbyj5v1pOOE33DklgUDrl3aO1CvdRAvxqA3FRQJyRSFKAhKl?=
 =?us-ascii?Q?w3liAF6P0IPIgv8Xww72/jgBbmLNkA53KfjBUBq7LA0jQXh0s0SN9MGpVxLi?=
 =?us-ascii?Q?naGgjp47wziE7o2rHSb4Qygncye8LjJ96MRS2fnTkRXee/DkVtiTFjuo9i6m?=
 =?us-ascii?Q?8HipHsXUaCf3LCoHxxf91sRiTanvz4Gza2Zgxpp/96V7WRUwMq6ouHJRn1x0?=
 =?us-ascii?Q?3AaDCW6tMUsMtUJQZCcPWsOeEteQDStMt0Te8IVU8ufRGID47jX1zFn6QBUO?=
 =?us-ascii?Q?yWrqvqISqoFtbj2OiVmLGbUAq8QIIouvNNgjy8083Mu1kbwOWnlwVuVarTKS?=
 =?us-ascii?Q?5Cexbk1yCRt5Wo7KmYXcVsJk8U4Xj/5cXE/kt1N5zm7c6CntEh1M98hBC8en?=
 =?us-ascii?Q?MumXO+UIRSrftoBBZ5l+sGWVHNg3/75FXIM6m0NuO6GCPcGWeoY9m89jehSO?=
 =?us-ascii?Q?SerQLRqdzw8OHDTyGnYUnmj8VJurOUGgLak3mp4nXYCfTCJKC4/fr1rUDmfS?=
 =?us-ascii?Q?iEg0RHlEvBBKqB4NqUzX77lNzFIyWqA9eBmaUMKhwONToC7WSYJDiMEkSsHM?=
 =?us-ascii?Q?8DNwfVB3WizvmVBG6WwCGiJM3xMul8zrwW1VPz01JqoXaSw9mSuF0Yocq9nc?=
 =?us-ascii?Q?kxyCgbVZtm9DckT3mFFchfhq0RkbQjlmi/k5/aKEM0s9py5cJ5gPr74kB17F?=
 =?us-ascii?Q?vvhu69awj19SR+v5h3m5HpNo/PsGIOK+Hj29O0iuOV3zUF8Rx3lUbDkZzj9H?=
 =?us-ascii?Q?0WV9rezpYR4Vs/Xdca4tRxf4pa3QRSeu7rHPt6ePdA9h5z51u3AWSkOg5SuU?=
 =?us-ascii?Q?OK+l+FfW42oCYqHmtyRQ0LOISVP9Mz28lK96Z0lXCI02rbSk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc0c3c4-1670-478c-c1cc-08deb8ffc56a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 19:16:20.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69+nWGLbYmXFmnuilAZ82DAGyOkuTEUyFmFfoczUGRkutAv8wKFgCGQaS5aCHYZ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21199-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: F3A275C06C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 30, 2026 at 06:09:31PM +0530, Abhijit Gangurde wrote:
> +enum ionic_qp_transport_mode {
> +	IONIC_QPT_TRANSPORT_ROCE_V2 = BIT(0),
> +	IONIC_QPT_TRANSPORT_MRC = BIT(1),
> +};

I'm pretty sure you published this a few weeks too early :\

Anyhow now that MRC is public and a real official multi-vendor spec I
would like to see MRC be implemented in first class ways, not as
driver hacks on the side please

Jason

