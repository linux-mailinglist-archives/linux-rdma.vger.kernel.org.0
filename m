Return-Path: <linux-rdma+bounces-12762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EBAB2645C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950A95A77B2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C123AB94;
	Thu, 14 Aug 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zb5CNwji"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F912F60A6;
	Thu, 14 Aug 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171226; cv=fail; b=ZiDScTHY56Ghjxc5EyPdnfi2w7ASbioWssh3zWmh4o49gJ2neNzLZZ67xjk/QoHwCv5PMd/QfTZelEw5JOSzvELqo+fjQ4Lk60OnzPhkUJTGkC3e3m9ivYysS8sXKqVqDuMG7pqzUqza5IKRS1Tq/lZT5/2OU6XDSLJcsNVxY+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171226; c=relaxed/simple;
	bh=knG1Jup4zJSS9dvFFLt6f/1pIGpZTzTRQbS6KGoHbUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RYh/0xpnky5GG/r+RXqBRQg4g0c7xp3HVMjOF9SN862YDSYOXYQ098/bEq+qCCrO6JDReZ6zi47jKzLdV8zJBr3iSCVOXwDYYmE94QUaUvuY07eclkD2FeerTGUq0rZ00pXqLhOrvIg+qzQnrIwcYV4oBER+HVTZm8Z9FVXBE6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zb5CNwji; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crjzzBzZSgZhp0yUbbIkzTL1hL5Sb3/P5qj9IlXR3/iO2m98yrF2iHm4hyedLaoLQbRFpyqfZVixRXQhZpxroC85W2oqCfOE75yuco3XZ6qIBBUql6B0hB4X//aeEyPQ4V040rXnxro+BDj3zEaDZlVnYLZtfeuEl93Na7MItAbjsWTdXjjS45CP39nULH/K1eLlQzCZcpqbH4yqjvJqlY74qHhQ9ehT/4V1F3JCHXGQQI0sFknbTSIgTLgG/j2oeDb6IOETvl/GLO0p646ydk1g3hdGgD2wUJ2QWJSolwbjvhoXHSZY3I99mBwwt/Ulc7usH2kTZUpX9RldWdWWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANJRFT/hbyvlt8RkcV6hoiCa5OrGCFkISQoYc6reCdg=;
 b=DRAsI0cFoANVCdzrLRdaHwkiG3r1GbAAhw6spBkVRmXoqwdvigT0DQtADua3qSgb1K9cuQdo/oFXCXwzP1LaNXNeBc0o9sp3SS+TvxE08r18dQIDIcJ5XOxKevyDC5pn/Q6Zy0m2zcyPxbX+sIRQIrG/hmx35x+KlUfchjOmbAFK2oLpn/T9KnKYQKRisfvNHH6dApctQJaAcN/J1Kx/l6zwtoSEtVNQt1oCeAYQCKRpF9Q/EL7CGNgxFeMIRcsMNdkX58e14C7V6xIHwb7rGDw4n8L3xop8mPVBRl3Nfzfq7K5HlVZ5EtpbxUbWjjnAUDuww2O/quDfY3AmOsq9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANJRFT/hbyvlt8RkcV6hoiCa5OrGCFkISQoYc6reCdg=;
 b=Zb5CNwjihFefurO0ileVO5sybuj+3TvtOFizO2yhfk1Or4SVPSh25d+64xULKh+ABho4QWG8UfGQjiFgAOvqoF3YXrgHnnL7hbU6eZhFtd+Mp+jm3fIIGRf/2Hvx8pjtgNSDHiwuQYVddYjaujUCyYyAjAOurNnJrIPEFE5Z4wiZdm8JebugzLN6mQNc0dYAOwhq0c5uDPkjgg88z2EepyMfpBM/1ZT3bka61X9ZCrOM7Q2xScvmGXaYR+xkY5KLMNIW3a9cDbngECcAYZm39uiIQy97ZtMjd5S9qWA99bw9zQenMmJFJRmD6sWpS2qKlQuWmxt8sM9DkQrE71WaZg==
Received: from CH0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:b0::31)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 11:33:39 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::85) by CH0PR03CA0026.outlook.office365.com
 (2603:10b6:610:b0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 11:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 11:33:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 04:33:28 -0700
Received: from [172.27.19.149] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 04:33:19 -0700
Message-ID: <7e214d52-88a2-4413-bf3e-41dbbd93594c@nvidia.com>
Date: Thu, 14 Aug 2025 14:32:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] RDMA/ionic: Register device ops for
 miscellaneous functionality
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, <brett.creeley@amd.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Boyer
	<andrew.boyer@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250814053900.1452408-13-abhijit.gangurde@amd.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20250814053900.1452408-13-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e596d4f-88b5-488a-75ff-08dddb266a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhNZTUzczJPT245TElmVFhuTm1mWm5qcmZHMDZkOXVwR2V4QTRJOFl0cG9I?=
 =?utf-8?B?Yy9Nc0J6c1hOdnhDQ2pwaGJGTnpOZk9sWkZLYnpqMDNXeTB3aCs3ZUxhTFZ5?=
 =?utf-8?B?TE9SRktQWVg1Z2tSRnpGOXV5NGkwRlNQamJoOWY5NGRMSVhtRHB4V0RmdjFM?=
 =?utf-8?B?WnZMb1B5WEpZZmhSVGhhTGZHQmVQYWtDQUhPT3A2YlYwbzV5QzY4ZlVlTkJO?=
 =?utf-8?B?bGpaUEhra2RQaFRidnlJcE1VTUZWclpWNW5sL01xSjhzSEwyOUl5SUx5aU4r?=
 =?utf-8?B?L01KS2JEUllpaHU2VHRIUzNobCtrb1RLZEZYOGMyd1ZjbXowZzdsMzNvcld3?=
 =?utf-8?B?RnlWbHJoQkc0ampYV3hBQlJlQ0dtelBCbUxTbVNCZnc5TStCUEZYNWxRRlNj?=
 =?utf-8?B?V1p1VWgrTUJ5QWNRZm1QNHJyWHB6NVVCT2dYM3IwRTBCMldtNmhNeHVKT21l?=
 =?utf-8?B?cmE2VE81M3V5elFWVDFLOGkxUjg5eUJhdUVaZ2NXRzJPUm9DNEpaRkZweGlX?=
 =?utf-8?B?cTFGdnlnR0k2SVNlT3VyMzZnT1BwK0dNQm5tb1BZNkFsMkhzRXBYSURuRXcx?=
 =?utf-8?B?UTY5Mm1yZS9UalB0OWQweng2b3dSR09ZT0RaMk1IbkhadUJMd3doS3Z2WFpm?=
 =?utf-8?B?K0dBMG1QMWhXSVdOS1BDdkhuMWU3YWxZcEVOUWRRYWo0ZmozR3hJQXRWUm9v?=
 =?utf-8?B?VndOVmwrQlp2MWxqWE9qd2k1UE9CL0RDbWhuRk1xY3pFUGVsTGtUUVlIVHcz?=
 =?utf-8?B?SjdNQnFvRVZEMnFqaW1SMGlDMzJBeWZmUkFxa1NMVUtkL2ZoOWpnVHBzbWNu?=
 =?utf-8?B?dGxQRTJ5RVYzK3ZKK0wwVXV3TnFVRGVUWEhrMXUxNHF5UVRpNHhSWS9RT3B4?=
 =?utf-8?B?TU01NDlyUnNWamNZeEJxSnJaU2EycnJzbGl1c2hJUlpkMUx5dVdqUXp2YmNL?=
 =?utf-8?B?aUtmR2hHbHpJVGN5MmlnMnEvNEJvL1NwQ0JMSUY0YkpPbEI4U0U4ejBDRkVn?=
 =?utf-8?B?N1QwNlpmWHdvTFBJSXAvSUNwOGpsYTFxRXVUQzg2bHUwbXc3bG9VYTNPVmZx?=
 =?utf-8?B?RGE5VDkvY25vdlNMWDBnZFV5dWk4cy9TVVR4TEMvdVRpQ2JTelhuVFloMG1E?=
 =?utf-8?B?bDNhV0ZRdng3N0FtS290ZVBHMSsvTEs0ZGF3UVFURW0wNS9WMWd4LytqNEVH?=
 =?utf-8?B?RG1DaGlZeFdrWjJMeWtGV1pESWQyTE5tdHNobUVwZW5WUStlbncvTjdkcHJx?=
 =?utf-8?B?WmZMelRjUFNPTEgySEUvZlR2L3V1anRNQWVLZXZGR2lvbGFUWkllOXNQTHFF?=
 =?utf-8?B?MVRGU1NYbmMzVE1Ua3EyWFRtMklRTGFERndvTGVUWlF2RU11aFdScHZwMTZQ?=
 =?utf-8?B?NVBzZitLT08rSDVoUkxGay92VmpxVzh5SDNqQ3pTdUpwcFo4dGUxMk5YN1VK?=
 =?utf-8?B?RGZTQ3F6d1NHcXRGeHpoVDh2Rm5IOEJIR3lMQzkrS3o4RzNaajRkSE1kNzFE?=
 =?utf-8?B?Q3p3ZXRUZWorTDZiSVF2dS93RitIRzkyVGlGWHVHMnJqRm5NS0FIMUowMHNp?=
 =?utf-8?B?UDZVYm1SQ3JpamM0OHlhRUF6L0dQQ1FMdURXWldSQnV5ZXFES2lRQ0NldzlI?=
 =?utf-8?B?MW5rcExILzdTcUd4Z1N5aUlmaHRJVFNmMkVLTUVXOG9RYmFtSWM2bC9LZURx?=
 =?utf-8?B?T3ppdmkyZTBhRlMxeDdWN3JMRFpoVFFyNGlVcjZFdExvSXZoSFUySUNEQ3Jz?=
 =?utf-8?B?SjFFeUUzeGU1OXhsYVIwS3dDTGsrNGpvemVkNFZXUXlmSysxdmc4VXFkcmZn?=
 =?utf-8?B?aWRvNTVUV0hWWmZCRDdnWURtMlFvanVvN2lkYy8wTE9lWXRLdU9HWmtEYnVa?=
 =?utf-8?B?ZkhQeGtHL1ZGdUpjaXV5MDJVaE5kYU1waWV2Z3B2VEs4UU5ZQVdROVVzNHo2?=
 =?utf-8?B?L2k0UWlqRTVjNmROd1RsNXZSR21EelE4bHJCVS9pQzdkdmVEYkhqVFRXckZo?=
 =?utf-8?B?YjhSRGhhdG42cDlwclE3S2k1eU9YZUQrMTkvRWp3b2QybjArT21BWTFIK0Ja?=
 =?utf-8?B?eUNYSXd6Szh3UGFyQmZ4QlgrcVowV3R2UGRpQT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 11:33:39.3086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e596d4f-88b5-488a-75ff-08dddb266a45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278



On 14/08/2025 8:38, Abhijit Gangurde wrote:
> @@ -50,6 +251,17 @@ static const struct ib_device_ops ionic_dev_ops = {
>   	.poll_cq = ionic_poll_cq,
>   	.req_notify_cq = ionic_req_notify_cq,
>   
> +	.query_device = ionic_query_device,
> +	.query_port = ionic_query_port,
> +	.get_link_layer = ionic_get_link_layer,
> +	.query_pkey = ionic_query_pkey,
> +	.modify_device = ionic_modify_device,
> +	.get_port_immutable = ionic_get_port_immutable,
> +	.get_dev_fw_str = ionic_get_dev_fw_str,
> +	.get_vector_affinity = ionic_get_vector_affinity,

I see there is no usage of get_vector_affinity(). It is called from
ib_get_vector_affinity() and no one is calling ib_get_vector_affinity().

So, in case you re-spin the series, can you drop it?

Thanks
Shay

> +	.device_group = &ionic_rdma_attr_group,
> +	.disassociate_ucontext = ionic_disassociate_ucontext,
> +
>   	INIT_RDMA_OBJ_SIZE(ib_ucontext, ionic_ctx, ibctx),
>   	INIT_RDMA_OBJ_SIZE(ib_pd, ionic_pd, ibpd),
>   	INIT_RDMA_OBJ_SIZE(ib_ah, ionic_ah, ibah),


