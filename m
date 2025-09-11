Return-Path: <linux-rdma+bounces-13273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796DB52A79
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 09:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AD57BC557
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 07:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68229BDB9;
	Thu, 11 Sep 2025 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iRWM3KRj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949929B781;
	Thu, 11 Sep 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576989; cv=fail; b=hk1GkFUKZJPfeyJdX9VIdXjUiGQXF8hzHlw7OA41tOOLTFVxEgre84ycsxuDXKF3s4Gt19SHfMJiH7cZkTzu5cVv1rI2v2PlbApXAinqkSUGZKMmtsZDXabptBiU55vZag9b0HrHl04MqFl2hHnnSMm2V6MqZT59Y9+Kzg7k3a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576989; c=relaxed/simple;
	bh=VIlkfzfY03kVlr5Fjd56tH1tuHAIKK/0LQC2iEl0we8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rYEJ1SEOopaQm0Vb0aCqdHR4fQECg8qRfZZRCL8uxigTWb2gMPHKvlFxHFhmXyaxVurj22573OZKDl2h5Emn+pHm2LQVaOtoSQN0Fl2xa/rDFdW8DdBpn67xSxBodqN3Sdw+TzR6KmCD7z1pQizLxvQYlYZaJAm5fKIqQCZglSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iRWM3KRj; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qi6HNcw29MdIXvrT5xQqgqav28S59zx7/9SPAjkQu0r/tftmEXjX1VHXddS4RtJJZ0QitjvGyhYIK7jx/3OKb2oEOXk5lDfCl6ccWiL6mv9S0H/VePqxfkwzbyWzzwSbi/0iaMf2RAmpGGZOf88XXzy/VANfDrhWEjxj7p0wMwRxKJbEs2HZnaXQWSvfA6Nr4q92kd0HU8xbT5jKECZqISpQv3nroF55Rgs3CvMsjNOsok/pk13dVIT8PpqWTN5VTBoQPvlilNOY3syJjk1V8kkY34Ys2h+7/W0VEY1lhtJgpca30PZnEvEOFbHopfhDt6cZg/7q0LQa2+Zno7bZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZDqkvKBLlfLKgIlhymOi70OFSbkwZHK61D7bJbWirc=;
 b=YSmX5cT2Kfx+xcLeVDomWqYMfvGazpoQkw2Oui52sAtJs41WKY+orYyi8ibD/bK6H3aT57/n2R0ssBF0PtkU7PIk3tGflUbKEGhrxD3949ab5xWfSqxLgFrIRuc10V4R9K2s/4GW1e8HcZN4MBrxNgLaRJ4A49XgCrnXJN1K5rlCtWYxUQ2s9D/Ch4mocii9hrGnPKL31yoCka2UJIui3y5u4mgIcl8uuJwtL8ZxvJbQO3A68DJanltm0MnHlnwZJ1tWyGpmaEMBVMcKeP68OkpEMlyH7nzercnzkLjMe+zospB5jTJRLJSxnMSnnWDhovZuHzCM9HVDNOEeO6ILRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZDqkvKBLlfLKgIlhymOi70OFSbkwZHK61D7bJbWirc=;
 b=iRWM3KRjEOldf+zQWd+Tpo0eisTlATZQTnIz1lMLpOpRIEy8TiqzPbVXk89PfJ0XlVUr+aF0Z4g+AO7n8j6E/KNZe1y3nwiStuKrPQ163RbSG/kdqc3C4Uo7XX+ZLtgMcF/6NBD/QdP0PiOZ5wBTIWf0f4XpL4mpUoXLEm+Xe5BnN/GwsRmH6Gk/EAtot8sM8lFy3QKbMyQEvd0JJkt1vMwvG/DUHx/s9zOPMrKXma5SKYRWBg7Cfna5yqRSPVEc+VLnZyB7zY+UrjuUlEyBuexc9oFmEi0Dxz0EvinMxByAViD4GiQE8GI4gntFdc+UHY1JKiFz2+MyMfbgKwjd/A==
Received: from BY3PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:217::8)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:49:43 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::fc) by BY3PR04CA0003.outlook.office365.com
 (2603:10b6:a03:217::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 07:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:49:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:49:36 -0700
Received: from [172.29.248.20] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:49:32 -0700
Message-ID: <5fa69070-59e8-4eba-877e-f0728088fd48@nvidia.com>
Date: Thu, 11 Sep 2025 15:48:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/mlx5e: Prevent entering switchdev mode with
 inconsistent netns
To: Jakub Kicinski <kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
 <1757326026-536849-3-git-send-email-tariqt@nvidia.com>
 <20250909182319.6bfa8511@kernel.org>
 <05a83eb7-7fb1-46ae-b7ba-bd366446b5f5@nvidia.com>
 <20250910174842.6c82fb0c@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20250910174842.6c82fb0c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1dbeb9-9a5a-4677-561b-08ddf107c51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFQ1bnE5VXVmSlhsc0M5b05ZUURucGh1cnl4a2RzVXJUbW42M1E4a1YxRWtZ?=
 =?utf-8?B?QXJobEpzd3JmN3hUQlpRT1VWL25TN3BMSWtaVVBWNTVWL0hsL1I3dkxBZHoz?=
 =?utf-8?B?ZEhEOUpkU0p3UFJrZUZBeEswVS9NdGZEZ0JKbGJRZ0JYb1FZSmQ3R2NvbHgr?=
 =?utf-8?B?S1Y4UlNtUlgyMUkvKzhXV3dOR3AyZ3Z2bXBpb1BYZXlxc3pQakYxUVB4OUo2?=
 =?utf-8?B?c01iWDNHYkRVUWJwSWt2VHNjdkdLcTk2TFNmRHR6TDlETDFWN0Vqc25lWkll?=
 =?utf-8?B?UUJLdjZlWW9ZSjdWVm1WWE5LbGp3ZEd0Y2p4NTV6aDJqNEVyak05UTBEdTJh?=
 =?utf-8?B?OExjdWZIbFBLWnU3WGszS3lwdTVKNUJGQm12M1gveVdqY3VrTXkzVWhUeFlW?=
 =?utf-8?B?b3dUS3Nvdkx0cTl2MnJZcnhlUVM1OXFnMElKeGVaSWhxL09Mc2hCQUR1TFZI?=
 =?utf-8?B?c2hXS0cyS1FNdHVOK0NzUWM5RUVSeUFOT0tYOTlSRXVkTWowMHp3dDFiYjd2?=
 =?utf-8?B?SG9HQ2p6MlpTV2c3STJOU1hKenlmNmV1VHhyV3dreU1BSmRjMFJ2dW0veHVV?=
 =?utf-8?B?QjQ4QTNlVkxsUmNtVzlmaHVvMTRlS3Q4a2R4L0paTEtFREVKd3NMRkNvTDBw?=
 =?utf-8?B?REtNTk9STHhMSVhSQVJwS0tqYTJUZFhLbzY0YXlBS0FoSzBCMW1vUTYyc1Bw?=
 =?utf-8?B?QU5Ca1hxaHZSVDhGeWNiMGpFN3FYTXc1Zm5MOUJMditldXM5V2tQS2RiY21l?=
 =?utf-8?B?S3NwVndqT0FCa2IxclVWdHNsT3ViVXROSWhaWUpmR05iYjYzMmU2WU9nTHVS?=
 =?utf-8?B?N2RvdkgzSGcrY2pJMitlanY0YnV1ZUFSemtaZkNRUHJTcXFRWFg3OERySkRQ?=
 =?utf-8?B?WjYwMDNPVnR3b3pZb2I1YjZNbENWTXR3dDRhT3pEZy96aVp3ekU1KzNpVGND?=
 =?utf-8?B?R0ZPcVdzcnlQVEQzN2pQMmN2bkxWRTVIUXZwM2h0QS9GYWZnWEdQZkZhYXoz?=
 =?utf-8?B?cW5OQnlIL20zL1dkMTFQSnIyN2ZXV2hGR0JjeEljWUZLNUxpbGNqOTU5U3NV?=
 =?utf-8?B?TnpFWkdJaVNsOVJFd0d5YkVkNmliSlFDdmhjbHBRbHBFOXc1b3RMS2pBVGpy?=
 =?utf-8?B?eEM0QUZERmZoTjdEbzJsVjdTb3R1dmFtTW16NDFmZkVESXE1ZjF5OFRLVEZl?=
 =?utf-8?B?U1dPbWk1NTFnakRzZDdYeCtpYUQ2eXlTREIvaU42WkxmcjlQUW0rTllmUURZ?=
 =?utf-8?B?WktyQU55NzhBcmJpVVRLOHhjcDdLRUIrb2RZS2xrd1JWZlhIYThENHRLVlJH?=
 =?utf-8?B?WnE4dkp0N1VnL1hlM09vMHRlVDlRTFhYNFI2UE1tUm50WjlWdEFVSUhQVlAw?=
 =?utf-8?B?NWkwL2ZaZUI4enpBbVhnNEE5eHQva2hUcWhqL29GMGV3Mi9BdS9Jc3E2OVBh?=
 =?utf-8?B?MUF5ZTlTa0RqYjJHYkRKWHZqUWc3T2pQQ1p0Um1XQjg3SVNVbnlCcDBYQzFW?=
 =?utf-8?B?V243aHRFZmMvL3ZlcDdEMDZBQkZicnVWKzZqWm1nTkJIYWtidXVRTzNLbVhE?=
 =?utf-8?B?SUxTMzBxanJQTDE0VitEVFVqemYraUhkcDJ4L3NQMFJVc3hUTjgrUnoxbUx0?=
 =?utf-8?B?ckpnaEo3WTBCQnJZdTdFZzhOZkJrSEhOdXdQdExLZXRuckJ2NFUvYUN4M3JX?=
 =?utf-8?B?NXZGU0Z2MGF3MkFSVzJYSnJxOHVBR1UwNVVTaWg2N3NScGNvM0plby9BQk5q?=
 =?utf-8?B?TWxMY0p6MnlSRGhIb2lUaUtMTUNkT09VNm5VSXZXYTRLeWdlQ2h1Ums5VUsv?=
 =?utf-8?B?dE52MzVkWmJ1dmZFeUtEY3U2dnY5K3owNytWVlZjM2Z4cG9odmhGWFR3Rlhk?=
 =?utf-8?B?TzMxZTVibTk4TnpUUDBFbENOb1ZEODFCUDhxQk1HMTRlWHk1bDZxa1lTZ3k0?=
 =?utf-8?B?ZlJ3b2RDcVhIM0xZQ3lmY1JHQ0NFR05mQXM2N3hqYUNueG4wclRITHVHNkY1?=
 =?utf-8?B?Mnl6UzBEM0ZnUGF1ekk3MkM0Y1lEUW8xY2R0VlJLOEFUemZvNHBaekQrZmg1?=
 =?utf-8?Q?1gnIIR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:49:42.9567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1dbeb9-9a5a-4677-561b-08ddf107c51a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773



On 9/11/2025 8:48 AM, Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 11:01:18 +0800 Jianbo Liu wrote:
>> On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
>>> On Mon, 8 Sep 2025 13:07:05 +0300 Tariq Toukan wrote:
>>>> If the PF's netns has been moved and differs from the devlink's netns,
>>>> enabling switchdev mode would create an invalid state where
>>>> representors and PF exist in different namespaces.
>>>>
>>>> To prevent this inconsistent configuration,
>>>
>>> Could you explain clearly what is the problem with having different
>>> netdevs in different namespaces? From networking perspective it really
>>> doesn't matter.
>>
>> There is a requirement from customer who wants to manage openvswitch in
>> a container. But he can't complete the steps (changing eswitch and
>> configuring OVS) in the container if the netns are different.
> 
> You're preventing a configuration which you think is "bad" (for a
> reason unknown). How is _rejecting_ a config enabling you to fulfill
> some "customer requirement" which sounds like having all interfaces
> in a separate ns?
> 

My apologies, I wasn't clear. The problem is specific to the OVS control 
plane. ovs-vsctl cannot manage the switch if the PF uplink and VF 
representors are in different namespaces. When the PF is in a container 
while the devlink instance is bound to the host, enabling switchdev 
creates this exact split: the PF uplink stays in the container, while 
the VF representors are created on the host.

Our patch prevents this broken state by requiring the devlink namespace 
to be set to the container's namespace before switchdev can be enabled.

>> Besides, ibdev is dependent on netdev, there is refcnt issue if netdev
>> is moved to other netns but devlink netns is not changed by "devlink dev
>> reload netns" command.
> 
> shrug


