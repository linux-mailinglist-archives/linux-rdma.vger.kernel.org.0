Return-Path: <linux-rdma+bounces-13272-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD85B529A3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 09:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4401E1C27F7E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A7A26CE26;
	Thu, 11 Sep 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WdC+ytfo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6B26CE02;
	Thu, 11 Sep 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574683; cv=fail; b=Q3Q+6OJAX10D+42OW3sslWUmJ9EKBV25hBEnyGTu1bvQ7nULHlujV0ntKJ3CYZQQKgJjFamwFfN2lK9/JE+bBFiwlRqmJvMRpw6XzgL3NEl+0XC/15Ji57UGJ/ZEyH3gf0tlvTm3mOZkDgldbcH5O2tz5n2iL3jsuENX2lljW10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574683; c=relaxed/simple;
	bh=+ZEc9SUbDDHmjWpW/BT8kYOPC+/Wo+APGmhblCZwNeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gZJtE4bTnuXPJa6J//i7ZaIFpCv+maej7OcRZsTpHk5VaCRMWEJO+TgQARcNLH6J43/2S5qB5w33Y19kPfJ9o6ZlxRdj0G6/ObazEC8LQAG1Bb3V/XHSy0eD7S4JZxMsyiKyYNtiYMx4KdOe7TnNlgZn/OaM23FclDANffQHBkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WdC+ytfo; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3KByfPrBxxBBC3Jo2tKhxK9eo3OPSrkp1USZJC0jvIhW7lVri8qWf08F648MuGkWCVurr8qP68nweBOoqBkaCk/8TdHx0q4p3OSWWjL/ekVgHtCs0/jmhp39hoZ6Mjp8zRVVvLZBhHaA7ZWrY+6/1o7vLJRGJd0qGXIvPQEKqdgCAZtHdnP4JbmSdcSRpitf9BfDJLl8iVjSd/4kc9yl31xskOuwDZdMqqhShhGHmvOr+MO5HZiviWm2T6Fa0AVpktEqSPYQFYmQKkOMWgCC5Xvp1E/UQdBPutQTY49NjrPHW6yuWg2bCje6WFA493jqSM4u69qsGPBPWAxXnMnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YflXILLrcrQ6c906lvfkheL7lQaIZbVWweP7PoUgE4g=;
 b=VGHV6RqePxy1gnAx6XBu1Zfca+2SaQLFfa1Fc/PiNbStx+KQa83wxom5ogz0sW+Vz0Q/yDzHm/PhdzXdE0bNVy0f97OajAP6HAEoYS+mCOGL7DXhNKdIOrJOOd4sfdv1sYAgX+xqgDeT5Oj/rgRggCpudQAbF26uMTO5nVf/Xv8VKzyh41wn7g7WZJ9IECJ82fzxtIsGrBZo9PtrwVtAxl69a0wKOyLXKAySVkHxA2IelGzwZ9do45fFnqQMHMTrTph5lhkiwEHBd1y9kA9TGCxmMbuTj0WekicR30jEhBcxhk35EA7AjDvZZ1rrGuAyyVgD9HobY0/UkeJYnn5clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YflXILLrcrQ6c906lvfkheL7lQaIZbVWweP7PoUgE4g=;
 b=WdC+ytfohqvAk93Q7EFVVNhonQC72WzISG/mX766wVx9kSOT0ENlFROU2kqMUj/ajKqHs/KjK9apHYnG/oA1395emQ+16gq9IcQBRATrO2W96i/bdzNI4DSt/q5A5j53rrmCIQ3IuNzBR5QvJQ7H7Soo46OMegS8K44500e2tzpAXw1q7lip5fgKXCGr7z80vTKeF3AmHtWvVfU8ymETXMlFVQ3tKJv6XCKjez9FJIPVWJMbuAtEATHeRcyYTQGJHpBZ/nQJVRbJKVFQw9ZtXKg5Jjq+ZL5p1bXCm10dHi7qRAvXqn5lQPo8dXyVkjdqPiZOg0S+da3G97GrpEmggQ==
Received: from CH0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::7) by
 PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 11 Sep
 2025 07:11:16 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::40) by CH0P220CA0028.outlook.office365.com
 (2603:10b6:610:ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 07:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:11:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:11:05 -0700
Received: from [172.29.248.20] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:11:01 -0700
Message-ID: <9bbac284-48b8-4377-85f9-9dd3c60410cf@nvidia.com>
Date: Thu, 11 Sep 2025 15:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net/mlx5e: Harden uplink netdev access against
 device unbind
To: Jakub Kicinski <kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
 <1757326026-536849-2-git-send-email-tariqt@nvidia.com>
 <20250909182350.3ab98b64@kernel.org>
 <cc776b20-7fc0-4889-be27-29d6fcb3d3ad@nvidia.com>
 <20250910174519.2ec85ac2@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20250910174519.2ec85ac2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 596c9d80-4687-4265-f5db-08ddf102660a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHdiR3NYTXZqZytCRlBxcEVUR00ySk02R1p2b0t5M1htdkVFYjM5NEdObDZj?=
 =?utf-8?B?T1RCQ3FIVkhUd2thT1NGd1lQNlpWWlhHbDcwL0xpclVGdWhOZDJaeXhTTVdH?=
 =?utf-8?B?a2dhODFtc2IyWWlJYmE3a1NlU3BoL0R3NXpnblBkT3JsQVBheElOcmJUdWlH?=
 =?utf-8?B?bHcwQnlmbFhrSi9PZlJKUG5Uc2I0eHdQV25YTlpWMkNGdW0xQXZEUVZpOFlQ?=
 =?utf-8?B?Z3RzNHNMS05KUVg2cklBWlQ4MFFsV1I0OWVqaStQNGFGZ1JhUFRIZ0d6U0Ez?=
 =?utf-8?B?RkEyVlpTOVMwcmwxdDJ4U0l6VGU4eGdraUxqRFh3ZEZpbDM3dEQrSDYzRHpH?=
 =?utf-8?B?OTQ2S25hc1F6OEZvUHN3dTUvQUNGTUd6UVI3bjhZbG5ZNityYXZnSktXTWJE?=
 =?utf-8?B?ckNKRnpFZklPZTJLWE9Sc2txUnBqZFYyRnVZUEFhSFFpZ2RoQ2xNdWRpQVJu?=
 =?utf-8?B?Snp4M0kzVmNKTzdrN2o4Nmo5UVBUOWpyTjRsV2FCeTZMVTNLSkpyRU5ZU1F6?=
 =?utf-8?B?QW9wU1VBNllRNzdVYmp0N0w2MXpzYXFKZVJWMDdRWjNucEVxUCsrV1doZllT?=
 =?utf-8?B?TzdIUk5zVGFTZW5XQVhoaWlRVTl6TWMvMVVkM2xSVjUwQTkwY3hnSktMN1Jy?=
 =?utf-8?B?R2pLODhqR3hZMTFEdnNadkduK2R0TW9GZnZlN0dSSnZ5VHVCMW5KaGtOZVk0?=
 =?utf-8?B?VFVYMHhGcUFYa1pYNHpYeHVyWC9sYVlzUFI4dDZMNXBNcnIrNXpzOU5PRHNP?=
 =?utf-8?B?WlBzL2ZtUCtmZDBqSWc1VkVLa3pLTFpvN2M5V2U1K0R0UUFMN0U1OUxYTUlK?=
 =?utf-8?B?MStRaUxLUlJORE9OZytwL2l2c3kvMWozZUdCbUdlZXRTNW05RytrWmxCRlZq?=
 =?utf-8?B?Mks4V0lmU0hYVEgyNjJOQlA0bHUzN09RT0FZMmk5K3Uva2t6L1ZDY1hmUXFC?=
 =?utf-8?B?RXNPc0hFZlhzYjRMZ1RuMXphSEl1UjJzNnhXaFFDRGhWRlMyS25RRjk3MHI0?=
 =?utf-8?B?eUtFWDlnQUw1UW00bStoeG0yb2c1cTNlRDVjbTZsZ2Vrd2hKYXhTZnJ4Nko2?=
 =?utf-8?B?NmR5MlNMVGtOVUpkTS9pWGJMcnFFa0JJcXdlTXdoK0RLVnhYcFFOVDZRV2pZ?=
 =?utf-8?B?VnZ3WEZjZHM4R2N0aVFGTzgwRGpwL2VhL1ZsbFI0TUZJUkw4RGE4TkZCM0Qz?=
 =?utf-8?B?ZkRZcC9xUUZrMHByd2pySjQ5M0dGWWNjZHdNeXoyK1prQm9rR216cGphazFv?=
 =?utf-8?B?N1hWYVI5R0RmaVpHdis4Y1RSbmphWkFTc3hJTURwQlRTaW4wdm1XR25SZ3JK?=
 =?utf-8?B?Y3dGcEJXWFk2VGJaZklNMVVleWgzazE2NnMvaDM2VFg4ZmMvTzhXRFh4MHpi?=
 =?utf-8?B?UEFNYlhtZlE2QkdaSzFvSENqaS93VFJ1UUtTVjd4UTRtZXovdkFxR0NjeFlx?=
 =?utf-8?B?TzhxanRwWUJlM1JoK1JPWW1lb3c0dkFjRmdqaGlsMElIdjNDZ2RZaGQ3bUNi?=
 =?utf-8?B?ZEl2M1p2UHJsTHg1RlJ6TmdqL1ZkK3ptWG5rWWlMTFdha1BxbWpQM280SE93?=
 =?utf-8?B?V3hzNXVNNXJGTDJQelRTa2lWaFpaQlBQdVZYdVNQY0hNeGlsUitRWlJKZFdG?=
 =?utf-8?B?eE81ZERVYjBhd21WSGZkb094MFZ6ZjRrS3FOUU9aSlNLLzRjWmRabDdiUlRw?=
 =?utf-8?B?RlN6bkRkZXVXTStlTWpDbi8wU29WaWNOdlcvbUwxd0E2cmNYQlVoUE9DLzQ2?=
 =?utf-8?B?c2R2bjc4bHBTY3ZDU1ZtRmxZQzZlRklyTHdCbEM5QmJiQ3BtWDJsalY1QjFi?=
 =?utf-8?B?d1o0WUxWMGEzMGlzQ2J3K2kraE9JYWJLL3NGeVFwZnVlS2RiZys4S3VrNDJl?=
 =?utf-8?B?T1IwRjBubjN0OGdLeVA4WHFuZmZ5SnNETnJvRG45aW1oZTltVmkrRnVSQmxy?=
 =?utf-8?B?bnJDeHVzb3g2a2h1U29ET0w1STd6NCtvSTFOaTNycXVVcHIvUURQY2cweTVD?=
 =?utf-8?B?OGh6Z1ZrbjhwM2tCVDVIbmtNSUMxTHZJbm1QaHNDNE1sRU5HZC9LbUU3VmM4?=
 =?utf-8?Q?LPBV/C?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:11:15.8945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596c9d80-4687-4265-f5db-08ddf102660a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329



On 9/11/2025 8:45 AM, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 11:23:09 +0800 Jianbo Liu wrote:
>> On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
>>> On Mon, 8 Sep 2025 13:07:04 +0300 Tariq Toukan wrote:
>>>> +	struct net_device *netdev = mlx5_uplink_netdev_get(dev);
>>>> +	struct mlx5e_priv *priv;
>>>> +	int err;
>>>> +
>>>> +	if (!netdev)
>>>> +		return 0;
>>>
>>> Please don't call in variable init functions which require cleanup
>>> or error checking.
>>
>> But in this function, a NULL return from mlx5_uplink_netdev_get is a
>> valid condition where it should simply return 0. No cleanup or error
>> check is needed.
> 
> You have to check if it succeeded, and if so, you need to clean up
> later. Do no hide meaningful code in variable init.

My focus was on the NULL case, but I see now that the real issue is 
ensuring the corresponding cleanup (_put) happens on the successful 
path. Hiding the _get call in the initializer makes that less clear.

I will refactor the code to follow the correct pattern, like this:

struct net_device *netdev;

netdev = mlx5_uplink_netdev_get(dev);
if (!netdev)
	return 0;

Thank you for the explanation.

