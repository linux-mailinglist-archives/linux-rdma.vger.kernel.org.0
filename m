Return-Path: <linux-rdma+bounces-22554-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rPq1DftRQmr94gkAu9opvQ
	(envelope-from <linux-rdma+bounces-22554-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 13:07:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD66D9302
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 13:07:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rcoll3WY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22554-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22554-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F3C304F20D
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D48836827E;
	Mon, 29 Jun 2026 11:05:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB427364943;
	Mon, 29 Jun 2026 11:05:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731106; cv=fail; b=ebMga8Uv+ETnD5qfQQnwPWPORjOQ/j80ZMKxgTM6m2cazwHAzosXzL3l1KJFroX09nUsR/coJ9bJK/wjS2QagAeI+ATNstnWoBwjMFbzRE46TDxcNk6uR/VxgjmUNt39Fd69AntxIg+kV11ksMNTAkgvein9OXvIjtKsy+FNqnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731106; c=relaxed/simple;
	bh=YIfaRTXwMmFyUaUoAGtcdXnYG8IQrQEcgNuuhK5EOS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYwFFSVWSjauPJs1xXaYDrgPkSHPfgn3to1eQOO3RZWMYfiWihH/QwSy8rrGB7jASYUt5WsBwsLJkexCg+y6yPmUMMNHGGW3+pBcKsgCjX+LAJRI5J3P5IPylYwX12LZT82QSdkqEmq37BbRPukx5RozWtZShq3Wg1TpkWtMTts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcoll3WY; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGTpX79/admW/7mv1pmFI31mM9LUWx+BfVfSLIyRv1qReKJr6INTdnX+gd7OSwHnsJjpk/SEecKG+taf6K3vei8NMsz6FKrLhDtj+sIQs0NA7Gsf+8dA1LTgQIcwDLH+E7rRzcsv2owJrUxbxG3UPZeOGmNcDL1QgC7jURx7O8IeanQ+p/aSsaKh76bsfozoCDcG9Egjt0mUc5HexKB/myklaHAYQ7jhZUblwycOUzgM9I53BQMJChhs9iB+FYqBoCv08v/8gK+i3hchROCsgyM9Dp9ism65upj1TAgLMDR4os0MSoeYiV/ZavJB6tu1FHMBl2p1JW/y3+nETfoPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1kFCaE+6DQU/OpO5CtSfM6oDDKSwH/lJfwL2zGrWwM=;
 b=DUAx0ZD+pxK6XtJlpmxR0FmoUBB5tS0GwmJGyt2QBrQq5W1IRzLB1ToTWeknHI9oniBiIZafd7rWGfYX+dz5kRQuNmKNVLSP74yt8dGU0rgBNfZmI5N/608sR1Kk6RSbrr2sSyo8ecPh2BuadTLz7QpjFmG+uvQqnGPpp6dVCQrVo3CviUOXO+c5MITOvYfmkA6Jdo55r82wvLrlqpI/V3mpiv5iveI5vVvt0tUMi9IxhurZoIY1Jxadj/nJMFuxtrerrSOYZ3akRUy/rb3m5s02wRb/3vmE3m+O6BKoSbEUh84uyn1f8bF4TOp4Dinvco5LUD4by6yReDyLlp5vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1kFCaE+6DQU/OpO5CtSfM6oDDKSwH/lJfwL2zGrWwM=;
 b=rcoll3WYM0KjfcuZDTMzneEdwW2N0tHcKU4uviDaFzCbEHzZEeGMTedPIe2KryvML6YMGfbHlqIv0F4xpN/wSkEi07oE8w/IHP7lzoxVi5ck3v2CNFX6rfsO1IOgEKa0WIhVV0E87IoAXTlMtaEEuxchmeMT7Jiyq+fufM6G9sEA6N7DuO7/DBGoI6h5vh8S5wd16hHi08ZPWBEjwzbzo0iFdMSrSIYlmgYnhtwizx8pUvFhGo56Nr+6cj5OpxEKKmFshW43IFQlttRWuTeNco8LKzma06DD6QYjWDm4WFz8VYJ82iGlYcWt+CmSqR9jsaSXYCf4zlQlAOxLvVv8LQ==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 29 Jun
 2026 11:05:02 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:05:02 +0000
Message-ID: <b979e01b-fe90-477c-ae3f-cbe1d29506ee@nvidia.com>
Date: Mon, 29 Jun 2026 14:04:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net/mlx5e: macsec: fix use-after-free of
 metadata_dst on RX SC delete
To: Doruk Tan Ozturk <doruk@0sec.ai>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, sd@queasysnail.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, borisp@nvidia.com, raeds@nvidia.com, ehakim@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260627223059.29917-1-doruk@0sec.ai>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260627223059.29917-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: e701c414-e5a5-4cd7-08f6-08ded5ce441e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4G8g6eyDFRcIio6GtubaRAST0r3uG4iRq9dvyK8oBKhK5hoJZ9JgWZw7Hk2OcvnuaUZIstkYuIZxGPj4RAhc0AhKbU4L8HSLEqTpDOOc/R0BgKPfIMhb2BmFxprmm7K7KNUWtVgh7cJJdtHvSuTEsGL+3snD8emYz3HApW7kWxJkX9hzA/RZz6H6ZSrbFdgNfyb3A9xyug97n5T85Fsq98BOftM/2+87LMJ8statlIOPg6vR7h/3nqpm8Dm3LASDEuFVMyWcu25gBBh9jPcNTKP/tEYlCgy/s63ItUZyv7ei7yBQhMWAFmyj87onecZOeiFQ6O+2Xbxju9zO4SBAJkWUNAlkm8tPtVW9ufEfALMEhVuHg2X7ndtJJK8um25j25/NDaMjTIjJG6TTunZ9uSYrItIvl0qsjRbhhqSVUmDk0TRUNz8mzHNwqNzQRmy15pVU72TExh+wMoyKAfLX7kVC7tg3Jgs+4L9BL6e3Er929hqBPZCLSOqK4nPOyBSfwFSljFd5ijGUbxrvkGIlBbhHEUGw/QIi3AZ9gxPVz/VM8b6Y446QRBx1TeoXbBDLBGOvbfNSZONbjRa0di3sTwcK1R1yypJWY5QWRLho2+qkE/MbGqQkkKyoATouQ2EwYRPx3XV8L0wuTzGWAUY2N4b9jeVoNqJjeiDWeE6q9Wzwk1jILU30itBAZpM3ipknrYpEFUkJVyJ3vEDtgGq4bg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3JUb3VicWtHbzhiTkIwYWhUOTlra3VuQmdTK2lZazd2ZGdEYTArN0RXVElm?=
 =?utf-8?B?MnA4ZXh6T3MzRDE1R1h4TGIzZEZ2K1hlUGRmQktiNzliSjd0OG5naHNOUFIv?=
 =?utf-8?B?cnhBU0lIaFI1alZBRVdWa2JqMTI3RWNhd0k4bmhTb1g4bmpneE1UQU5STENk?=
 =?utf-8?B?amFabE1JdDA4TnpiUUQxYk8rK3lsTFRESHpYWE16b1B6aEFxRVZFQ0JoYUhB?=
 =?utf-8?B?Q2NQL0lDRllLeU93eEo0YVE2SXlOWnNFQlpIZTZXOXdIQy9jQzZkVmRzVjAx?=
 =?utf-8?B?UDNPa2U2R0FMKzA2dCtJNmt3cEV0eDlaTEhUUHBqN0puVDhEWDNYV3ZFMlRZ?=
 =?utf-8?B?dm5BU09qKzBybGU3alJnZ0pnMEdlSTVJNHNsblJYUkh2YnBvRVpuUVZ4NEM5?=
 =?utf-8?B?OER3V25yVVN4RjcyWEZqTmR6T2liR3NmUWFuMDM3MHBBYjJPMFJrZ1YxdXZN?=
 =?utf-8?B?RHdmRDAycy9nRGxWbE4rUVd1Q0xSSHMvNEpoOE4wSTVJdDhFVkpaZE8rYXVS?=
 =?utf-8?B?L1djejF6L0Y5SE9NWmIrMHdhdjlCNk9WVWFEK1NtdWMydUhwM1FnazROdlpK?=
 =?utf-8?B?TzNnUXhkY2RoRmo0WEdCRVQxSXFKUjZQd0VlSUhsa05RU1ZYd1JDczJNaHV0?=
 =?utf-8?B?dWdZUjVpbDRKYXQvbnpqUDg5ZS9MSE9pbFArU0piaWdSdFZBcVZSU05wSXhC?=
 =?utf-8?B?MmlNNm0zQ3VocW9LUWpmV1crQ0FFbDZxU054WU1FYW5XYmNjNEdRLzU5aHRy?=
 =?utf-8?B?ZWgzUnFnZncxU0wwVU9SY0JNRU9LUE5TdkpvN2plY1dFL3JRNHZlMldKUXds?=
 =?utf-8?B?Si81TDRMVlZ2WG9raGRxZ1Y3SFIxT0pUWFVhaEtVY1NBQWVxZ2xvbmhBMmpL?=
 =?utf-8?B?ZVRJTUYyKytPZFFIemtqU2wzYVA3LzBFQlp6SWNyZkVTQngxWDFsbEFpS0lW?=
 =?utf-8?B?TU9Id1BmcjBoV1RXTVpXVnlERUIwWmlTSXpSaCtGZ3EvVWc4d0NkTDUrclBM?=
 =?utf-8?B?ZHlVcC9OdzgyNzYrWXFEZEJVei9uOG9rYjFCYUpmOGVvNGxnSG5kOEJnay9W?=
 =?utf-8?B?TitzWGZ2aDZTVzNNUDE4OXhmdVBtdytoa1hUaXR2aDdneU45Mi9RZGxZcy9P?=
 =?utf-8?B?KzEzR1dkVk83ekFPczMxbzlhYkJkdlgwZFcrSHp0STlPaFg0YzNQbUFETXBQ?=
 =?utf-8?B?WW1ZNThvREVZS29SZDhrL3NXQzNVcVJmZXg4WU0xUEkxRzBhc0NIaDlwVTNj?=
 =?utf-8?B?YzF1RGk2OEh6Q3RkWXNFK1ZRdnlvQU1GUEtLQjIvYjJ2UE5UWG5OQXdNZXRH?=
 =?utf-8?B?aFBLOWkzamxVY2tiUnVmSWRvWm9QOGt2eXlYQ2xLVGFVQXduOGgwSVFJT2c3?=
 =?utf-8?B?bENIaU5QNFh3Q2pmd3E5OWRXcm5LTzdqQXp0akd0TlJXZFZISWNuTHA0Vmtq?=
 =?utf-8?B?OEFKWXZSeUtzV055T0NUQ2tTWWJMdkpuNlRpL0g5ZG1CTlNiMHdaTXlxelIz?=
 =?utf-8?B?STRvWW14b2tVUWNBZ205NW1YUG5HbWVnelNNN1RsSlh3elhQSzFCLzRSV2Fl?=
 =?utf-8?B?WDF4TUdmY2tYUGlhT0hGcnRuUmd1b2NQODFKa3FITS9LYmQ1NG1uZnB1SGJB?=
 =?utf-8?B?RjhQNHpwS1BHQjFOS2FobTVDV2N5UjNJNHA4VkRWcnpKYzh3WU5yeSsyUUFS?=
 =?utf-8?B?RmpJMFJwSVhubG9pWFlGR3BCMkQ0eURNdTBWOThYck4vcWFpVHQ2K3ZKVzJZ?=
 =?utf-8?B?YzU2dkFLVHF4WWhYRnk1N25WWW8xNFNWNzNsMDlmcGFJUTdwR1Q3OWJnRFM5?=
 =?utf-8?B?VzRpb1VCUVV5QWdhQkV6U2VxYy9ZQzBCSWdYQXArM0xwbUk4bllZNC9US1hn?=
 =?utf-8?B?QjlZUE5FVGE1dHBqU3IxSk5saHJsRjBwS3R3dDVZTElEWXlzaExMUzUrNWYy?=
 =?utf-8?B?QzBweFdOaWVDM2xRVnhuZWlMY1pzcStCOTVZTjY4ekp6UlRxUXRlK2hac2Iz?=
 =?utf-8?B?aHI3T2xVbzlTV0w3Z0lTWkx6alRLbHF5NXFrRTVOZDF1aWt3NUxQZE5YaDRY?=
 =?utf-8?B?NkV6S1gzam4zU0FTVzFPZUNWQWV4aWo5ZVFYcXdpc0src09sTXVBeE5vcHFw?=
 =?utf-8?B?U3kyeE1TOFMxV0drUXV5ZkphZVRqd29sRzRoQ2tnSE5URHVGb3E5OFZpcVZ2?=
 =?utf-8?B?dzFBS1gwN2ltVnF0WUdaZEtnSmEzREVHYXJTVEhmaVFYeS9QajROTkI1NWdz?=
 =?utf-8?B?QnhQWkxwa0RrOUdkL3FVMGZ3Y0c1ODFIdkJIak5Pb3IybXBpTHgvdEdNMWtO?=
 =?utf-8?Q?QUJb+koBRPXR/G6o7n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e701c414-e5a5-4cd7-08f6-08ded5ce441e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:05:01.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUNunGSrhZuJYL4vWjcvwPJlI0jyE3JwqaB+2qKyQDI7YiiHq1wi02hkfU/sjFs1n0gHYzTJoOleHx5POeW29w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22554-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:borisp@nvidia.com,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,Nvidia.com:dkim,0sec.ai:url,0sec.ai:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EAD66D9302



On 28/06/2026 1:30, Doruk Tan Ozturk wrote:
> When an offloaded MACsec RX SC is deleted, macsec_del_rxsc_ctx() freed
> the per-SC metadata_dst with metadata_dst_free(), which kfree()s the
> object unconditionally and ignores the dst reference count. The RX
> datapath in mlx5e_macsec_offload_handle_rx_skb() looks up the SC under
> rcu_read_lock() via xa_load(), takes a reference with dst_hold() and
> attaches the dst to the skb with skb_dst_set(). A reader that already
> obtained the rx_sc pointer can race with the delete path and operate on
> freed memory.
> 
> Fix the owner side by dropping the reference with dst_release() instead
> of freeing unconditionally, and convert the RX datapath to
> dst_hold_safe() so a reader racing the SC delete cannot attach a dst
> whose last reference was just dropped; only attach it when a reference
> was actually taken.
> 
> mlx5e_macsec_add_rxsc() also published sc_xarray_element via xa_alloc()
> before rx_sc->md_dst was allocated and initialised, so a datapath reader
> that looked the SC up by fs_id could observe rx_sc with md_dst still
> NULL or, on weakly-ordered architectures, a non-NULL md_dst pointer
> whose contents were not yet visible. NULL-check the xa_load() result and
> md_dst on the datapath, and reorder add_rxsc() so the xa_alloc() publish
> happens only after md_dst is fully initialised; the xarray RCU publish
> then pairs with the rcu_read_lock()/xa_load() in the datapath.
> 
> Note: macsec_del_rxsc_ctx() also kfree()s rx_sc->sc_xarray_element
> without an RCU grace period while the same datapath reads it under
> rcu_read_lock(); that is a separate pre-existing issue left to a
> follow-up patch.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

