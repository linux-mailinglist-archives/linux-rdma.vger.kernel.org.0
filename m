Return-Path: <linux-rdma+bounces-13435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C825BB7F5BF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2430F3AA1C4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D52DC33F;
	Wed, 17 Sep 2025 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gqm4B8E4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C82BE051;
	Wed, 17 Sep 2025 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092933; cv=fail; b=qSltT2kmPuGdkb4GjQhuxOzkflAUX4M01tLkKGtAgjLrdkXUZW37zxIas0CqjJVHh+2i39LHHKc03GZ6jyDtCAtZB9+bN06mveSeP+HQHJmdmTIDLp7eqAP+EqbL+aSJkV50xAS9SfI3EybKFnDjsz7N0fi7R+vovXHfIC6U2WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092933; c=relaxed/simple;
	bh=v/mvP396TOsMv+0/LlsAMokFZQCNtmLe1iHBh6yWuEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oWDt4/ZZW1BQEQT728xL8PKhOqOHBYxY/hUPzVwQnjcLxW5GsRCnNULLM/m7qL4wlrMP9zPjAosNYzBuF5UUe+WjTDE74XC6zd7NWnbZ7FagwNKbUPWeQkZEb8c0M91YtUYdTVwuQTimrOjivngpVUTYNluuRUTVRzfXrFP9HNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gqm4B8E4; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKXrc1/xLEwnd3Xk6khhil9EKWErHcE55uooJJwFrPAR8quO+Tjt+4EJ8Q36OMzUe/Q/ZT5jULV0jZw/bRitXxcgwu7K4l57ML5xB1m9I+f1KYE0AEHgiV9SeuRAmhWjaE2Sw+gWJ5zgoR4IPIIIkv1HYnA7qciFi3uBS12tremb9fXbJnfdBLs5JzvZe4jICk5dmHoHBOgp3NHXwivb2Xz/8hjG1nwu+/+HDsTq4jnVZJN//PfW3cY0+Oaqc/vWDes1nU1/8BUGRlZegVsezXfo56gm5KyCn9s1tGbhPspzytacjyeyThkyoF7epQsJ1BNibah0Z1qoxdKVs+NmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmYhOr50p+qWyLeJ680eY8LQh7S3BgY0TcNo/NpeclY=;
 b=VoDosOL61L9kYkAahGezu1Iw2GD/nq4qdju/Q4YG9Qa1tT9HppLY2u7u59MYgEp3luVIh0cOiQYBfYBLr6AriHWnUbP81vytVBGKpzA5CWLVdp6USytJPDmF3JdZFXy8xVX9/I8mGefPRvGiPKXEsS3sOrLumGGWO01LlU4utLBeEc3GeSrrWBiN72zWLmGWguYSByhDxULrPf5Y533gHilF8sSw2GTJmZpgbTVmtpj5Uretsmkd2OhFRWY8fmk+I9iahIPWTRtjJDh7ZX9qnQhrbt4CJJgAolOxWd+aserYs02vvfoitoNoWKP4RIHJ7rt6LZeD3iFW4YqjvXoU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmYhOr50p+qWyLeJ680eY8LQh7S3BgY0TcNo/NpeclY=;
 b=gqm4B8E4WVZ0qPDMM8dy8gNEYLYnFzykO1wEc+MUlK8PQwItiy8RhgEy04LOPY9qqlpVZ6jWI/KH6+nYfIPXA3hPbxXCIot9fC5bqtEQ05QNzD/29B6d6YZdzqVrZM5EPH/BlplFhtj0T9qwpta/2yzbl67waOiM/Gbu8rg4v1khQm99ioFj03/UuWdS1nB0+Ix/I0eBLn4mhVTuB3jN+RpO9NPm6Zcwi8L2M4odag3bq+oCwlSqQD/BbZAhMtlSqt1vmEpN4HrlBbSZXJHUvdVWmhMicoI18/ktzF74QFS4kLvPMTWEUXhazQlPAJHiwu/eQnrZOAJk9vd6B/GyYg==
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:08:48 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::26) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Wed,
 17 Sep 2025 07:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Wed, 17 Sep 2025 07:08:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 00:08:33 -0700
Received: from [172.29.246.187] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 00:08:27 -0700
Message-ID: <a720eef5-a01c-4449-8ea0-7cd0d05df25b@nvidia.com>
Date: Wed, 17 Sep 2025 15:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/3] net/mlx5e: Prevent entering switchdev mode
 with inconsistent netns
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
References: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
 <1757939074-617281-3-git-send-email-tariqt@nvidia.com>
 <20250916172106.593683a8@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20250916172106.593683a8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 54162d9b-568b-4e84-500f-08ddf5b90c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmVZOGZWaFpNYWpyanhSMms2RSsrdEw0M3pjWWE1cGRwbmp3WFFiUVRBYVhy?=
 =?utf-8?B?YlBjcmZQSzV2L25jUlRiTjliVlZRSjFKKzdGVmh0YzFpWk9oa0RzQkNiYk5Y?=
 =?utf-8?B?bGRocXdvM1FIQjYzVTZnVEFFemdlY2xvL0hJaG0xQjNDK0dHcjVFam16eTha?=
 =?utf-8?B?czFzN2tnZXdDV0VYNlo2OWY3aUFHYS8xTzdRdFBvZzNFUVJ0SkVXOGN5TDV2?=
 =?utf-8?B?ZUVjcGlmK09DUHdyd1RmY1Y0aTZTTXAzWlZsU3lSQUd6TXRwOUxDQUZxNzBl?=
 =?utf-8?B?QkVWZzBYUTZRdmVUZkNsT3U3OHdwdXF2ZWo2a0V5UVlydDNkSldMMzZkRFp4?=
 =?utf-8?B?VFlMWU14OEZWUWh5dWRRZS8wbWVaRTVhT3pUUERhNk1EVHRFU0FvaWRLOFFD?=
 =?utf-8?B?b3o0anJXMU9ZYzM3SnhCNzIvbVp1dUFWRDhJKzFoajF4aTB4U04xT0N0RHdy?=
 =?utf-8?B?QlZodkhQMU9TS3MzNU5uOE81TXhrSTVqZ25XV3I2T0VWT3I1aERWcUNrSy9Q?=
 =?utf-8?B?VjBDaDNQTzhKdWphbXBjS05xVlRNb0svcVloZDRwYTFiM05PUEJ5UDQrSzVa?=
 =?utf-8?B?b2Q3RG5Oa09RdkVxNGVTTElESUVUWC8xZDh1ZndwL2VuaGdqSEJ3bXFvRkQw?=
 =?utf-8?B?aFlqekVXbUF6cVM2RjBxS1ZUTlJRUEh1Z2lXWXYybWpYRkQ2S0N1c2h0bHRw?=
 =?utf-8?B?ZTl3WFlGSkZ3NHo5ajU5VWdiVm9ub0ttVzNweFRUd3JReFpKT1RkNU1NRWZQ?=
 =?utf-8?B?RkJMQnV1K0gzV0cycnhBZXkyZjJha3FHM0EzY3BHeUJqREZWcTRTVjdRaXdM?=
 =?utf-8?B?M3prYXd6bHVNTW1jdzU0M0RiTldRcUlnREcyVkhTUEJBb3VIQ1N1bk5RWExq?=
 =?utf-8?B?RU9oQWtoeFFrdEV0bVIyMFBkTThmRFBvamV1TDQzL2NTVG5mL3VXaTE1Unhs?=
 =?utf-8?B?TlZPTGk2Y2xla3BPUHFiMkVpZGRqNXNEVWhBRm9ZOHNTSjhsYmlxd2lxK1ha?=
 =?utf-8?B?SE9XYWVSenJNWkp1VW9wanNBTDJMMFY2ZUFHYVErK2lMVCtXMlNmZlVEZE9v?=
 =?utf-8?B?N3Zvc3owZ01rNDRzSk9UZjdEV3Y5cHVLUGtRcFpxVnNwdktuQWR6ZUxaTlI3?=
 =?utf-8?B?cnhhSWZ1bHVaWXBaS0diMFB5cDBBTGJ0TDdNV0s1VndrTGxNaHV6RGlnUStz?=
 =?utf-8?B?UzduNG1QSlduSHgvdzk2dkhOSjNuTXRkMUJXMzZvbW9qYUdmVDBCL21CV0U2?=
 =?utf-8?B?RlYzOGJVSGg1enFqVUt2QzJVN2l6dUJrSExrTERuSVZKc1EzRXdnaFQ2U2w0?=
 =?utf-8?B?RmFMUmtMTXpZQWk3WElKa002dlQwdGgzMWpaeXMyaVVJOW51NWU2QjhZUnJO?=
 =?utf-8?B?MVl6bmhkZHkxbmV6MnFwVFlZdVdKSEh2dG9CcnJTVXc5VFkxbWxJMkMyYjMz?=
 =?utf-8?B?UFFwUXZPVGdEZzZNMUZCZUtkNVpmU2ZCbTdIMGtodllQQ0YycGFvMDRML0FD?=
 =?utf-8?B?ZFVpMENBN2JuWENEWW9pd2N5bjlrUWlUNEFjd3JEV3JjZVBLQzJWRjIyckcv?=
 =?utf-8?B?MGJFeWRrVXZJeGhwZWxNQ2wyM3FkbzJpSko1ZUo1d2MxTURTeEhmanI2RXB4?=
 =?utf-8?B?YnF0d1pJRFVCM0o4R0lQNnQxemVRc3ZVbHhIS29LNzFjSW9JSjZ0TW0zd20z?=
 =?utf-8?B?WC9jdExVMlgvQU4xdHROYkdSZUFaczZwYkFjTnZTSzEwc1RuZVJRL0loZG1k?=
 =?utf-8?B?MDNQVzdUcnJyNHBVQWVnMlBHWk5NenZTQU5XenFZNWpwYUQ4TndUZ3c0ei9s?=
 =?utf-8?B?RHRMZllLUkZEY3huUkJCNkxMVktvNFVqb0FqNDZhSjNFdGZER2pQc3pQUU4w?=
 =?utf-8?B?b1RkeEV0ZkhRZDVpYmVjaTdjTjYzcTYzeUx4dE1qMlZ2bC96OVpoUEhRUjZj?=
 =?utf-8?B?OE5jZHQwY2JrNWN2bllxWlFSanpPQ0E4S1VyTWhpQ1lHcW9hUmNSL0F6TzlW?=
 =?utf-8?B?cWduTnJsNk5OckdBaGgyQklSZUJhZHcrcHhCWVdVeWRJSUtBUTQ0emNSSUxh?=
 =?utf-8?Q?+KALPF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:08:48.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54162d9b-568b-4e84-500f-08ddf5b90c70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087



On 9/17/2025 8:21 AM, Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 15:24:33 +0300 Tariq Toukan wrote:
>> If the PF's netns has been moved and differs from the devlink's netns,
>> enabling switchdev mode would create a state where the OVS control
>> plane (ovs-vsctl) cannot manage the switch because the PF uplink
>> representor and the other representors are split across different
>> namespaces.
> 
> I appreciate the extra paragraph of explanation but it's still not
> a fix.

Ack.


