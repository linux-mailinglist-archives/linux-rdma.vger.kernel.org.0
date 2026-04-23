Return-Path: <linux-rdma+bounces-19519-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC82BHN96mmqzwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19519-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 22:13:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8872457318
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 22:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B84C730087C6
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B303039A075;
	Thu, 23 Apr 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F5tm+BdP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291636402E;
	Thu, 23 Apr 2026 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975213; cv=fail; b=Qu/vR2Iy74Gx27jzg67cIZcIwfggo5V1tgBP3hw5fUTYe/6xKu19woptOMny0pVpNPRi+5HalYu2DVZY12qyfpOJbiKF556I9++8pCGZMkOZzRCdYk6SxKKTM76XuK2cKt1ASNagqu+cqeRmoI/vsz0k+IF9G6kAz1cUt+9q2QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975213; c=relaxed/simple;
	bh=QKUxWY2ACdijEdClx14qL1J5Ol1VEEmHQl7p8PI154o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=As+qk7rRlaOGBa95DU15IUFhepn5/DVyx6Vg2a4mb1xpmeN0/DyzP/3NOwKBvFPpQn/tMqwVf2hUWt/oAOLVJyEUJu6ik0eT9obTdA3hOJvE3s7jh7EM55yAc8Jm1zntgPB0yZ4MKb8OIQrKf1QQnfnLz5paEYm0d5/y3rho89U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F5tm+BdP; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7hC7aO6OUcFPIkK/8MeS/18kWNaCkwZJZ3oGMQltMKA+G05OdH9mf3sr2jTCRtAPNkA8KzwACF3K6hzdnLa55CdcuYjPEva1WZ80O/GkHKWbxMIYsuZevjywP3uIUv86I69cr2mJmNTGXJMXf1AaTiftGNg6Pykl520j3v43Yo+1ac4OAk7y3/H6SmPjGxtW4DAGqmkY0pvbIr/gHYo+2Z9Sd8+bhUNJuTBEa/2UydfjDGAvNK+PXlF9vnNdBI8qFsOCwG6XyeTe1Qj0avEaP2kAjiEjPDyrF3ijoAu1/KGsZlryn/EHe44yr3Pehz68R2gPxYd6GkHQPO8QQtkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef2QxR3QV3EcgdBq2ov6TNjsV3H8jDapVCGcB1d8J00=;
 b=dMyWlMJm01oesmUpwP8mel6oVEmCmntOOOM2nOiGlwtt/hgQDXoQO3V17IOfvb47PTDtCJL652i5b/TNyz+Rn86CBli8PHMt6TK5J1GHWMLrRz14HNcxs0jVjbF9eR8GGUspasqUYKYO4OtTcFwWA7UGBXUAN6uP2CohNQetxhPfwlWkmRlKwsS2+XXT+hm/4HAuMIITSUwVjZpky2ewGtle6gWVU9+IOPdRY6qS1r9P/UtY19Ct50mfbh/QGPzQ/hS2mergsMVpVv/9eRLVPE7+E3g84XPHr0OhHkLckrDOduJsO4qwo5z5ugpmT/yvkyd7PslHc2BkBjndScnqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef2QxR3QV3EcgdBq2ov6TNjsV3H8jDapVCGcB1d8J00=;
 b=F5tm+BdP9IVcmE513/574DwsOzvakRwICsjsQ0GAj0o7G+z0rMkGnDM8Zvf8sZOJvQ1KiWXidgrdCaFCG27l4rNWx22hW7ojbbaupS0QEgP8rGh+b0UUXzy1spbrYWE3Qbd0iD+gzJN/SwNWnAgqa60y6NjkcopUz2pCtfFURgVQ34KmQFtVzkRPiLEfubA3dtUdn1ZgaksYKe9adKi99gAumUlh/q8KpNs8n1wqcUUMgdnQiO413PQnZoRScTXgz4Sq3a7LqD38nVuG4c046GGmHinuew7G5ORtvnSo9KwCM1iq7AjvKCXzUWAuUZMhyRftztrjp5/gExl6KRoo+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 20:13:21 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 20:13:21 +0000
Message-ID: <8b610e49-ff64-497e-8712-588b2228df02@nvidia.com>
Date: Thu, 23 Apr 2026 22:13:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net 2/3] net: mlx5e: fix CWR handling in drivers to
 preserve ACE signal
To: Paolo Abeni <pabeni@redhat.com>, chia-yu.chang@nokia-bell-labs.com,
 linyunsheng@huawei.com, andrew+netdev@lunn.ch, parav@nvidia.com,
 jasowang@redhat.com, mst@redhat.com, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leonro@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260417152642.71674-1-chia-yu.chang@nokia-bell-labs.com>
 <20260417152642.71674-3-chia-yu.chang@nokia-bell-labs.com>
 <69750ae3-3b0f-41c7-9731-6d49f5f6d319@redhat.com>
 <e5d03a71-cfcd-417b-a3b3-94dbd6600f9d@nvidia.com>
 <e6aa13f1-4284-4ae0-9dda-1a506e729156@redhat.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <e6aa13f1-4284-4ae0-9dda-1a506e729156@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::7) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a842b2-3f47-4634-5d14-08dea174c3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R5HCpgAsL/t4EiC4BLMttTVy7Tx0g35VUQSmd5twBlPsaGmgYBnvWyl2wFGPez8L7ldwUppMcF1VY03NVbasvwNdZ4h53Gn0GKZ3OvqzE5EYyE5lNXA2IcuHuuIeDFY8/TMVmiFrgYDq7Lfx6oW4b6hrzbOeFSixwCWBYz9PPni6FHcKKJSxZAApj8dku6pXxNjhzfOVOzqtMlvEJeyKWfKU/XaKWJSXPGq/RhOtonM/SFaoUxsgr5ARTgLE1lLhQuj4ephvfFwuZqh15oypgAV61LfYy7r3XQTxzALTk7aRH61IUg4rE7kp+4PYvOxqwA8fcqNcFdWQxuUvaiCE+lRqHKlqQobf/V30Dg2ibjPzqTcAlQ5XlZn8PCYecX5ZrBZaViB91DiFwLFVYTU7EBNl9jVmkLhmKG0djE/T0Z8NLNNKevLDlR2skKkroxQt0yEQ6zgXTLVlvvT85KEYB9hbkhU+wCYSrLh8un/3D8HSxZ3JykEc6WMFFT8M8kirjFGEROozkgXmWYvjRQQaXG/dl7w02s9icLiysNXmP710IuhC3CGq1h6FBFTIqfhqbAKtKsS4gy8OWOP2G235mscrZbVp2UXkPRvcdPjSsnK2Hd431n/GaHjcVW7rbTFRrsGvGq5lrE2kj8Xsr5OZiVPHOfQsgK7niLhjeW91h/JHCBWIHr03Oiqo+Lp3N9Tx2XAsWJfuX/JtpLD+OM/ryDedBenU50b/OGNAvVRhBZVYI4dY3S8ryi3GcxDAE2iBuwoYWVuR40iCgH2r7xtR9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm9jUDVpRGFhcnByRzhjR3ZLdDM1djk0ckIxNFhkREEvNjRUa09mMTRUMHUv?=
 =?utf-8?B?SFEwQkFnakZPb0NENzJVdzBxVG9iVHMzVGNvK2trQ0dzSWhBR3pyUm9rOENs?=
 =?utf-8?B?encrTkJyd25kbnBGY1BhWkRwa0NSUi9WYXlHaVpqTllsRSs1S1Z3Tzh4NWRr?=
 =?utf-8?B?c04ya3FYZDNDZFhaajJGZUdrNTZOdkdqeDIxdCt4czNTTlZMbXdHQ3ZxcW9S?=
 =?utf-8?B?dEZocTBLRWpBMDBSc1RTMlgzay9oOFZ6RTExRUNFZ0VScDdFbTRqZHYwYW9h?=
 =?utf-8?B?aDhWdE1GekZRQVpTKzNyck5iY01ycUpRTEppWCswdUd0M1ZqcWI1eGU1VGlt?=
 =?utf-8?B?R29nU3JONVUyTTYvUXZuYkkxMWNWdW1XTktKSExBTEdOY2pibHBnamFtWTBI?=
 =?utf-8?B?ZEU0cGFESTJ4MGxORzBRVW1JRGhyOHpNeEtwVUZKeHcxajM1bVhHdkI4c1JQ?=
 =?utf-8?B?V1c5Y0Q2TDVnSm4yRnM4eW5nZzg3cXJZQnVpYnZXM3lBZTl6K2pWMEZCSElk?=
 =?utf-8?B?TGVMbFBuTnZxV1dUTmNQNCttWjhqblkzQWRzb1hpNmhtVjRGdkt6YzVWQmd5?=
 =?utf-8?B?Q1A5VGNNQnhNY3pYNndvQStCQTBKZ1dVVFE0UFVZM0lrVkRFS2RwbHA0NFNC?=
 =?utf-8?B?SHEyZkcwSjIvV0VVanRtTkRwNExTRFdYKzdKNE45d0gxYmQ3QUFoeXNaUmVh?=
 =?utf-8?B?blZ0QzE0UlQ2TDNIUHpRZzFhM091OGZnTUFTbWZXZG9JckROYXlPVkhqR3h0?=
 =?utf-8?B?MG5FUWN6Tzc0VkRQNFZJMXhpZ0t2dzRvb3NNakhMSmJRK3czcEhnWnR5VVFh?=
 =?utf-8?B?ZVdyckdhbnZENStWcngxQ3Q2S1FIVzZabTNrVENvb2Z4T0JuZzVKZG13d1E2?=
 =?utf-8?B?NUtsaytSSEdkVzRGMTUvYTY5V25lcGQxa0FCQjhTRnowbVJ0YU0vMEpxKzJt?=
 =?utf-8?B?T0VoTTVEeGt4QmhGeC8zUnhIQlpMb3ZBUFFhMWxzTUZmbG9UWWJMejZhVDE1?=
 =?utf-8?B?bEdUaHlhSUdVQWQ0M05Ld055bU5TNUY5T1BrWEs1R0pzVmtUL0hHdzJMbjBY?=
 =?utf-8?B?MEhOUHRTY09vNG5VUXg5ckliRkNsczZxWlN5Zjc1VzFrMVBZSDR1YnBqUlRC?=
 =?utf-8?B?K2FUVmxKdm4zU0taYkdSekZ0Yy9McnZLMW4xVmRKTURWcHB2dDJLaHNxSnRs?=
 =?utf-8?B?NGxVaHZVM054ekhHaUFMWjF6eUUzc3BlMmhrdEtTRmVONDJnWWlJSXhHeHJP?=
 =?utf-8?B?TW1yZnpPZXIzZSs0dGVhUHZodWtNcGtyVEt6V202bk1FU2s2ajJxc3lZOGxG?=
 =?utf-8?B?M2MrVGFaajcvVzFvK1NEUmFrZ3llU2JqV1NEaGsvejJyU0Q3ZlNTZ1dsQkdO?=
 =?utf-8?B?RUJlb2hSSGxUdXYxTUdJOFBuK280dzNqcnJXc0Exb3FiMmhwakRtSFNWUUlJ?=
 =?utf-8?B?akxXeUVGYzVkOTNMaGdNbmZNQUw3Q0w0ZUdENUVndmZ4UGZzcEpZQ3ZWR3Jn?=
 =?utf-8?B?TVpvN0lZeEdzNHVLLzJwTWVPanBYa05KT3NWZVNYQ1g3UjJsUEtLcjRuNml6?=
 =?utf-8?B?Y0JCenFhd1pUWHZWdXJ6ZW9zblFTcE5hL2FpTzFKS09RWFpmcEMvU3g5eVBu?=
 =?utf-8?B?NC95Vk9ibElCeUMvRzVCbmR4NHlrTnUvbElhTmZlUzdxVFE1Q0VjbUNOck5E?=
 =?utf-8?B?UG1HOVlJTmMyZ084MFI2M2JnNE1FZ1NJSCsxRFNhbG9HSGp6aitXZFVSZ3ZE?=
 =?utf-8?B?N1AvWWpRdEgyL21ROEQyOGg0WGkwVk4rYVY4ZUNkYzQvRm8rdk5Ybk1YTjRv?=
 =?utf-8?B?UjhYZ0N5bG9iM0VPWDVSNzVPcUJJd0J4QnY2cnp4NHRDZFpTVTFWWGQzTHZ6?=
 =?utf-8?B?dU5VSkJhMHVpV054MkxxM1Zpdm5oQmt4RHJLbzVpRG5uVUtYVStNMnNOVUhW?=
 =?utf-8?B?VjVzODRmZUx6SzlrUWh3RU9ZNVNudGZzT0ozWktQY0FSLy9vT0VDZWNuWUk1?=
 =?utf-8?B?emJuYTkxVzFNNkVscGVkazJqc21BSjYxUG5aR21yZzhJSGVtWjFpSUdvbXZl?=
 =?utf-8?B?Y1RzbTRWMnpGOUNvcnNJRXF5dEZVM3k2R2ZicEEyMFdJSHZSdzhoTUVvd0lh?=
 =?utf-8?B?Qlo1WHUzeWJ6TGlDWDZGc2xGSEdHbjJmb0gxaUtneTgzRmQ0VVlpeElZQVRK?=
 =?utf-8?B?b014Z01TbVp3akwyYk9lazFPOEFlbnFTOEFaWFpYeU0zQStNYzFBcEwzQlVJ?=
 =?utf-8?B?S3hZTUh3bE9zYUE3amFkSGZmcEpZMlhYaGV5QjkyeWNwY1BmZE5LWUlSVlVY?=
 =?utf-8?B?aWIrTGViall4Sy9VMXRHTzlaSW5mVzE5VmpzbE1nMG5yL0dUeGI0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a842b2-3f47-4634-5d14-08dea174c3c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 20:13:20.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK88J8c8AccXN3gUo0CiQPQc4FCLLz+aKt1dGv25tT79+R8A6h4Yny9hvAJMRAD9+Ai4Levcfw1+U5Dq9cTcPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19519-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A8872457318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 23.04.26 19:40, Paolo Abeni wrote:
> On 4/23/26 4:19 PM, Dragos Tatulea wrote:
>> On 23.04.26 09:30, Paolo Abeni wrote:
>> [...]
>>>> ---
>>>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>> index 5b60aa47c75b..9b1c80079532 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>>>> @@ -1180,7 +1180,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>>>>  	skb->csum_offset = offsetof(struct tcphdr, check);
>>>>  
>>>>  	if (tcp->cwr)
>>>> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
>>>> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>>>
>>> Here there is an open question for nVidia:
>>>
>> Sorry for missing this question in v3.
>>
>>> Is the above enough or will later segmentation lead to the wrong
>>> results? I think/guess the firmware is (still) aggregating the wire
>>> frames using the ECN schema, i.e. the first wire packet has CWR == 1,
>>> the later CWR==0.
>>>
>> For mlx5 HW-GRO a packet with the CWR flag will flush the previous GRO session
>> and will not start a GRO session for this packet (napi_gro_receive() will be
>> called on this single segment skb).
>>
>> So this change won't impact the current GRO behavior from the mlx5 driver/hw side.
> 
> OK, thanks!
> 
> For my education: doesn't the above also means that mlx5 will never
> build GSO packets with CWR set (and so the above statement should never
> be reached)?
> 
It does look like it... Thanks for pointing it out! Will be addressed in a patch.

Thanks,
Dragos

