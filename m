Return-Path: <linux-rdma+bounces-11591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B196AAE6B3B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E71E3ACD32
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF126CE35;
	Tue, 24 Jun 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fp54gqoU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B726CE08;
	Tue, 24 Jun 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778769; cv=fail; b=kpR9LwrNZwSx40HiA9h/sKr/swgcgYhI88vyzZDokUtLMVjHu3mJa0eA+4KwVEYXg2fEtINFz9s5wc4Qv29QZlzJXFJbfkCniWr5jpE7K6QCZeqFqvofo+eeypEF8LxLfUeKE5VQoNPvC+zi+PNswGU4G5zrSFpgt3uNNvlOi3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778769; c=relaxed/simple;
	bh=QXOHBGGWquhLMp6hDo5qRdX6IiLVHbuAnOF6VcJ9Ya4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wdyi+ZxQPlW2AUOpqs0CgqWUyWIbeRqAk6AJpLsAOTwyUpACfeI+dBWvK4RiAYUNlFxpOKUagJryVyI+JVvKVbD3qZ8BWI0HwCRyj10+fLRl/DmqUtPNLFJ9RRZhH+jZ66fTNpss5/6flwA7/EJHR0qULcNPzv9ZjwiF6RoirrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fp54gqoU; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xey0zhyP6CGGclpUYpBNdsxi/buTkZMNCk3DF9O76VgQ7qQvlk4XgaOOifeXxhs36fvdkJAb/yC/LjlbgtvXRX7XVbuWPKpBpSfhTVp/3jwBMMbexnShfgIzLgKdPLN6GhW4oLCyFa1kW3vHii6NoIrvCwwhfuEVOhxukKicjdSfPvfT4pK3sv0x6W/7zweGyhDAycmRc2Xgs8p1H98Vcq4exWWxsWz7mQ0M1bvq9EYDzh5Sf31oXRxnhVNmDE+Y02AFPn98BOi0jKMe4YjKR+/anBu0z/vWM6Vf6/Zkd2z8y5pdtaZd4wehyyJtuDvnHJlsWYIqM+1aY51o88yphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubGHUcKxMhct5fQfeDWFAsbft37YDJKOiL76WtOKUgw=;
 b=o5qQ8y8OA4ec/FAcq8pN1QA68VeoiJm/bVuMu8/WHs4gRB0UrCZETBr+nLd4TaCQ30EuL5voJLOpgor7BXXhF7mQWTfgKGduivZO+oksLHWSZC6yqAtkiRTfb1w1tLU/s/pUsVKERPNxMnwO8bfBr1pj81XI51trBezdEkuqBXKacE940LEW5JoV8DM2e4cDmJ5NVzXK5fMXOY5jpiHE3v6nRLA6HQVuRKsMTGvLHf8qbEZMeqRVjY/KL0UJfG3E8BOr64lgDPMIi6JHAgTLmqYuG6LoZpL+hGvcKk/cjyf2P03OYdIszyPRrrZdlVdj86pcg94SMG/L5jvsv3eyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubGHUcKxMhct5fQfeDWFAsbft37YDJKOiL76WtOKUgw=;
 b=Fp54gqoUQ2CQuarPnbu+IfpBeWhtFVFyhLoRjLXc6wg1E917kH6PJMnhKa/jXE20ZQ/trZ6DpGhnAj/DMgBTZciE3DJKGVFTYHnOUO8oPQzu7oCNh5u8Y0yAPzgqstaVm7dQn6xFr7VcBcDcbxo7j0olgUuwRSu7iCbXTMAFQrVTdKZYELtU0Y+igdta6fGHVl8yfqyMQ4PXfyMQyUNaOSeiUoszIp2lUWVAWirNXY7uWncOgVYh0rrEb4uKqxV/RNF3klp1m89+os+URdsZVgNBYwjTbmMazcppwIqVrWYUKm2ruaoug/vE7U4IV+kn3vbPB1YgXp+8xOnt7REL9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 15:26:05 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.027; Tue, 24 Jun 2025
 15:26:05 +0000
Date: Tue, 24 Jun 2025 15:25:54 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Fushuai Wang <wangfushuai@baidu.com>, saeedm@nvidia.com, 
	tariqt@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: Fix error handling in RQ memory
 model registration
Message-ID: <kxjh7zvrcjmjndklgbu6bgtapry2ztf3ldocygmgdfy6fmcuwu@lo2jnytzluty>
References: <20250624140730.67150-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624140730.67150-1-wangfushuai@baidu.com>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: d142a540-82ff-47f8-25cc-08ddb3336f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7+ZXSDG2l2ic/NaWiho2h96lHqEMCawiFrlG0yHDqmTsqcBD5Ps0CgvugDh5?=
 =?us-ascii?Q?0MdffqVPqk2I2MZxZpA7YC7FSlm7pP4ePLxbxU0vSgAYl/c4qCv09WfyquBk?=
 =?us-ascii?Q?SI1XMzlbCyncAkYQGz7Q1qQ2JXM1isHQw/Gg0m3kyMNzgwgZDIxZAKTcIoht?=
 =?us-ascii?Q?USOXDSGbiYWLkBx8ElO0ZUJBWWNXziuBOrqjMtPDpRXleYQUXuG8KLJzcgCW?=
 =?us-ascii?Q?dRYEX+hhyYhpIzSBMzhblDPBPNR3safAF8CUV4yvS839SZCEqw5lS9y27Mzz?=
 =?us-ascii?Q?xhsiHp5EI4vAwm/uQbWkQ5+wxyJpl4m5yWx0BS7+2mRmloSjGHMuhxs5E2V6?=
 =?us-ascii?Q?bo6bNOjorDKVQrslNOfIgqulwJVvJuG7nHNSvAQjcFdQaydM8cymhWF/VN0+?=
 =?us-ascii?Q?ls1+aWpS9+myBCvuRdw9NjbQ6jO3KND6tZolQblBI/d81+4hAPrD0erzoKZZ?=
 =?us-ascii?Q?h+iGGr9lo+CzdN+Lnvi0tR2AyFzijTamxA4RmojzQqebrzp1E7L65HdX5i9W?=
 =?us-ascii?Q?q4e9l/HpI8mlo0PGNdpWBmzE6N+E0fm34q3fTZMYObKOMAwBNp9Z3lkt76Is?=
 =?us-ascii?Q?kEjGWUV/r9SZGJ4mqdZJyi85k9NxAUne5TTJTm9OuV9X0LAYhBRN4pXfd/G9?=
 =?us-ascii?Q?aWuSnuQLg06AXBBV/6LwkaoR5Rfeew7L4YWOpHQHDsGsElO0PL7HMsuiPBrV?=
 =?us-ascii?Q?VZCXac6SjETVscYPgbAosaRm5fWYpLeXWPhw2JbebakoHD7yaYj4VN2bW64g?=
 =?us-ascii?Q?+Mk5GtFTgdxkezfXNSmt0C9wJj/EGVwawiUGPrggrnKFzK3uVMV9lcjLdEtK?=
 =?us-ascii?Q?lZE0Ae5LyYadv8sW6zBssYcPlUlO5eQDM5Tli6ysVNiqzlDOAy1RY2oM7r44?=
 =?us-ascii?Q?StyVGZdo8DK1vQOXMKsaWCROhtG3nt/s1o1TE67zit4O00imwGmNvsszClfL?=
 =?us-ascii?Q?J7zr/urwk+LQngFbrTBQdUOZ9nOwkOUhLcXUVbKjFFzl7dYVJTBQJhUvvoOA?=
 =?us-ascii?Q?wEHllGFO6VrixbyQ7GShcr1GIHJt/xIEDM0bEVvdJQowp6vkPDXYWXWB0Fdh?=
 =?us-ascii?Q?x8N5JmS5fuLYGU66tERPGy+ftH7eqSj7+n4s1OIT9mji8YIN70m1+eJvqpCz?=
 =?us-ascii?Q?w4+KtMGtkpOxuMvYGy/UaRarOhS5O+G91qYML5TKk/yWDTG7h7vcmxf4tkXF?=
 =?us-ascii?Q?EWNbb7BIZCeVL788nC3xMRZrtA3BSSE2XSqGghu3bWtMqhVdG3i/F/PEfUX6?=
 =?us-ascii?Q?BYe7D162zHGpc02OzDX/jDiaB+RWXypOYnV5NufGM9bu6x8EtTwjj8V7jkWf?=
 =?us-ascii?Q?mpjcz8RhY+5fbRJVZFDwU/4c90iuyHS4wC4gN0PNEQR2Y6a7lyb9BS1Z6hJr?=
 =?us-ascii?Q?7tsBkRf2N8uEWZVQ3SIuOx4evzAJDoZH9A1xY//anz6NPCuPP6KmRfOBp/Xu?=
 =?us-ascii?Q?CEPHabRpW+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAX1KXw3JKGRjhpR13B/5XQg6uo6io5Jz7IQAStilF5Yd1/6U1yIXJQNALJv?=
 =?us-ascii?Q?YDtdw20BLjcD4D7LIA6xoDzJKeKQl72cSU8OcPHcqMuzivcAL4h71S5yJ/lR?=
 =?us-ascii?Q?k4KLUUo18dWLO98uhOdJWx0FJGU5QCiRDRn+hgWUGkOEh4CM2LuiPSLuujj4?=
 =?us-ascii?Q?u9ukNBjvkHP09lwJD86dSBpp2QQuT42CLsX4HYnUzqeLCoVwl3IbSvOO2h4f?=
 =?us-ascii?Q?QtR7LqKn6ZrOrbX22v5kLQNDEq5CeTwWnYQO4zIdxVDuTZRfzmCOYsZ5XZzl?=
 =?us-ascii?Q?X5PSuBVDof29f8k75pqivkhJEm+HrpqLvzAzmrUFj6ysQfT4VHtvHe+m0v6h?=
 =?us-ascii?Q?86Hs4wp7BDehClYHzrL8kJ4xZfSDtdOlGoStuJjXfnWcX6chGdcNODH2oyir?=
 =?us-ascii?Q?G/qd7zk7FHGzkwpwcjVNhQNnNXbShZnOoMWaQvRdCo9gJM8p9yMcWpNvsXkb?=
 =?us-ascii?Q?e50uuABNo+Ns7S3FZ2/iDh+hAT6Y4oqq7aWPpTduSV5GYCrOXPIniB/L5eo5?=
 =?us-ascii?Q?4CL78To32hmySOf0nGWYtjctP9CDKsE84r3RIfmHeZ8Ap3zvYxQQpmtBLn84?=
 =?us-ascii?Q?VySHrsFhO5UqS4EdmV0gCRyaW7C8mW9qy++JhTo3A3xAQafIl0fxqy5iHCSx?=
 =?us-ascii?Q?8QS0SXijVMVDn5yhcKEmSywnRTQWNl5vPdJaOpISC8rqtWSgjXjwm1oDPb5k?=
 =?us-ascii?Q?RPscYgum8o//uzZqavC6u3xOggIk5K5RakCg/oleF7F2SPrY8AMTI0xUxxWE?=
 =?us-ascii?Q?Odj+ojmW3yiPTYHk9nlYjSTmjTKfBtJdm8da1nErL/tnFolWCq3qtd/tsqvs?=
 =?us-ascii?Q?aYBAPE3uRRjKSTIJRHZ0abrVXR7K0zs3KXy8ruwsxI6Rw86AYa32X9J3LQ0N?=
 =?us-ascii?Q?2qo32jRMq7K4WgX4JU383rTuxdKQ+IQp9f20BSjYUM87kPLWZU4SnhgKjRiD?=
 =?us-ascii?Q?9fbFhbEOGeDBSpem30jamG4Pji8tZZXyrALtlPk9NXYzBt7PmzYQehQFzfZ8?=
 =?us-ascii?Q?iPoAKMdeWU1PZ6koTIIRQJvOjoargq83wfzAs3bvOXd7Ot7i7dHzZ13fDnIu?=
 =?us-ascii?Q?4z7xwmWc2ZwhJ9GgPIU648aMiWqbOpNqcB7TLmAUgl7WBRKRlPWNb9GCHH4k?=
 =?us-ascii?Q?KKbA2feU16tgarpSsDt/PG3qU5QwUGwrgG6/n7qrwHWa3fhMI2PcW1IuUu+q?=
 =?us-ascii?Q?mENbDCMHPgDKXgsgWtFx4GE7VyDZVZlTbJXn4zdphaRydgpOG1gx9nDpzxi8?=
 =?us-ascii?Q?5Pjx8kEqzxmhy58gHFCo+YtHcB3500N6bYE45Cy0JGCkGLb5rr2a1R8wjuxf?=
 =?us-ascii?Q?SbMlr6WQHBXF3Hrs0+WVvvnbxT3C3WnckB+333A4VWta7/CViIGY9eCt1cJ3?=
 =?us-ascii?Q?OVwQEaGfAP/mgnmPEAXFlLUKGlR+Di1+ZVWen2vdHa0u4jxCXUI5jPETVji8?=
 =?us-ascii?Q?PTGmG+9Bsn+Q99Tb4HwUksKC0cx8ptmoDAHb3mpDa/lZqm8SD7Loox6KzO0D?=
 =?us-ascii?Q?s048vGLudcp3cwD7+2UKLAOAQWCYuryZh5L9dTaFG4xvgTfRHTiPvIjcfXxm?=
 =?us-ascii?Q?0FOYGqaFFjsI6qjqTWpvExoozx+9WMuBbmht4RRv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d142a540-82ff-47f8-25cc-08ddb3336f68
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:26:05.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lx4tp0MaCivN+iYv6Wjseu/+yaZk/607LbxTOhG2zKLmEfrE9s6HEYnwtPibXuTIMFbpEQ18+oIAz0ELT2WGtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

On Tue, Jun 24, 2025 at 10:07:30PM +0800, Fushuai Wang wrote:
> Currently when xdp_rxq_info_reg_mem_model() fails in the XSK path, the
> error handling incorrectly jumps to err_destroy_page_pool. While this
> may not cause errors, we should make it jump to the correct location.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Acked-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

