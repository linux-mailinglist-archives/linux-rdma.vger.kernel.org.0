Return-Path: <linux-rdma+bounces-18227-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +El0Eul4uGn5dgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18227-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:40:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD43C2A117D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F5633026591
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304F36404D;
	Mon, 16 Mar 2026 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lc70p7SY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01836604B;
	Mon, 16 Mar 2026 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697081; cv=fail; b=LtgKBcLOjnY95joBl3aE5hT+WDtBlK46wmAcYFxMcIDoG2l6cLc5S6O4IJpRW9H+Oka3iJiUH3qOFp7/3gZ9hBfv5tPyiCO1BmTKehKyP3I9HOzlLOO6e/+XwhB9RiOcfhxpK9Ee99sFFwahmHkudCaQI8gUiYQAJsPf/GjYMNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697081; c=relaxed/simple;
	bh=0NR4Mo1dIs1PMdK8YxU8CKTEkfAbJ+VKA4uzs7UKrM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oGm4EDgJ6zsSKiYuMu/mUPgLzHSTpzRgi+wSTnLmo/4UvOsYZ1nL98KZKQkfZoPOYiOtfmoqyHDUMWtuRoK0Bush9AaNNp/60p3Q2UhkMQalDYhftmVssjtV1e4Da+RH9oVvDvHNTYKyQBRZbvY1DDcETqys/WWzbDrLTHLzLMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lc70p7SY; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkMLj5apoC3Ir5O/O0ZFrN8fxZ/xbqlAY6Vq0u6YJeDd+suqvP3f2+sTEFi+EMadtrrackuiW5LWWKJDqRK0r9bLMLeceSeOiJsv1jBdFPoxqlUxtsbHLMt/E3o8v7Xsi/sDq7F7N4zhPJSctlRHfN6nYwgezDSB0/zH4LlaQr/qhhhVs0ghej+Bf0IrXwa6jmTiclWjqUL54FmOdByV1nn8g7LZzKKJ6jqEJz2VkowrY5T3VZdYe8Exl9bZ3C6wAGd6vWXqAxnS4ILdsq4h3V19kaRacrfh3DsTQizUvvpcfx/w7mEyN47t0V9L8iahu/o8rXDmeMLBGayr2opS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REJptSqJwNP2b6yjFMjui6PL9b+RJW5OObAG8sxpCG8=;
 b=rE6Kc+qaLka/PF1FyBGj9Au7StQ29MY3Cn409CyEJvC/6f0Wjy6FsGflD0/+7lq9TgjQ7TrnQKRF0AqsgLxZ326TabTHWvTe9e3NIYf1z4DHi3hRsO+H4BaEn/CRZU336NsAkM/NqU674c4guSHBAVeSJDdxNjjQfkeNaW69Sa0LnNCRXay4whFcmqfIAxd6krKzYLUzzaotOLZgJ4SXXefJ8ssaXpmAEC5yAH5CUm4v58C8PZh+DFBojL7Md31IBLHe2hSCIuGQ21TSgUJlf7iYrqONtBBKlAZUSOa68GQEg8ExpLL5eVEEc/K4XTTZGYwNfuAvdHyKVt04CUFigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REJptSqJwNP2b6yjFMjui6PL9b+RJW5OObAG8sxpCG8=;
 b=lc70p7SYLraIeOVZqyYlksy93fhDN6XZ+g02yUlQ0XdSHpehSdF7WKjv1y3jOdkCIqabgShAQQPIC9oqdZJdAbZGuxOeit7NszmAPHxkrAUhrovsI3AHNHEJrV8+a7xPPi7Iig6pCVi7J1jInaIfgdYHUFvlkvhE2+vwlw7WM9TtCB175y1L6wa1suIUmhoQIaJOtPVRtd6yRaRCmmwpuPOsEPlnkhpkv6GXdlfBLbBsyA25zmw3/pKVZ6sLn/coY/WUdVmLCfthEeAgzn8N+kDg6O/MXBH+OVlU0qbT8/XkqfafAiunDmL3whPkhKeQq1yo56sj8FI9m0uR3fGClA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 21:37:55 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 21:37:55 +0000
Message-ID: <237390f5-0164-47d1-bf07-8dfd6da50fdc@nvidia.com>
Date: Mon, 16 Mar 2026 23:37:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/4] Introduce FRMR pools
To: David Ahern <dsahern@gmail.com>, Chiara Meiohas <cmeiohas@nvidia.com>,
 leon@kernel.org, stephen@networkplumber.org
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
 <2a638f50-6d22-4abe-9f20-74367a0f3295@gmail.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <2a638f50-6d22-4abe-9f20-74367a0f3295@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 093b27ee-2189-4b47-4969-08de83a448b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lKHu7Qec8BicBkJGbYmvkX2Gr+ba5QoYodFBJPC9gPGDYmgPBm484Pyxm7ng7ubkh6jeRhWyGnubg7LKBOl5bB/q83Qv+jHFUvizLeDEYdbXf6OEjPw0wRw5sm7AqQBwi6vIbETaFdnxNEE12gTwGiJ+8F+HE9qNfMExbNs6+GT+F5GKhS9VcXaCjB2aLxXCNyMdGhmLHyiUCtwSMwcbcH7T3H9UMcxRqAIiYV4L/gp6Ksl0SRLERczqgsF4owwFWWQK8CRUDXfsxy6qv1gg7KKP0UgQrwqd36qS4gpqYV+bs0EZLkICrTCjiJmX24C1AiEzwSyMiv2GM487r3pJz7i2JK/mYa7zGGcjTXvCgGLj7rtIHQT2ALjcjkyR0WfCcZi9Be06R4oRdY/0H8Aphs0OdvDkBLllLj1wo7O5CPCfau7/KjDxejrBy1w3aolkuco5Uwx8w/hqz88Ai6pILqlZv4WwQdx/GjKx3Trr68jNcX+akW/xP6ZW3vxiXseXM+slBmfjpbWS/8Nes5JaFH9R/H7o5/ZawUBbLm+fAW6nSeMpxl7sLtO0pq19S12vfPkPTG97Gspfu5s8r5VWUng79qBWIB8cJ8bWE3UNVU/ofVunaPcMyecC/K6AvyijRvOQFMq6ThBMp/T8m+vUio3xAKev1t8f2Hclbq1KH9Zglc1PY9wN7Hk1PKxEusp2+QZhFkK/GpB3fKis7NuDCFuEunbpUVEBRzVFvNCWAso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0NrUUpBcTh4R2ViTEl0elgzb1NkWVBZSGlUc2RFS29uUUFQRlZ6NDBmeEgz?=
 =?utf-8?B?TFNlTks5SmV0Wk5nWVpTSjdIcmN2RUczbU9Udm9Pamo0M0FDRkVLZXFodGtQ?=
 =?utf-8?B?Nkg3bUNoUDJ2NzMrRWxsNU4zWjRucEJSOXJPbk5YcUZpYjgza081Z3hRWkRk?=
 =?utf-8?B?U2g4eWxkSTRlMHprUjhzcGxUV21pK1Ryckg0SkY2NUpRZUFHOWVCSFJPR0h2?=
 =?utf-8?B?RmJTZmNDZnAvK2dEdW52T1g4N0hZQWVXcWlBNkwzNWNYalZmbXJYcTRWMEpa?=
 =?utf-8?B?Yzd0U2tjYzcwODRrVWtyYnhHcWFxRnZPSTBDUi9PT0dHYXJrdlR6WTJudGFx?=
 =?utf-8?B?aFNxU2VlUThBWWw1REZCM1k0MGNOdTVJblFaMXVkZUNxS0NFU0tPRUNMZUt1?=
 =?utf-8?B?eGFISmZyc2Z5K0JTRGErR0ZOU2RiVEVQSmRtQWtjVkhTOFVSZkxmVEMwclZI?=
 =?utf-8?B?VitBSXFoUXVLTWl1ZW4zR015V2loOWYvaWV5NmNtRGk2UjUrNmt3MDVBNDE5?=
 =?utf-8?B?R3hPTVpWSEFYc0NVVTZpVXBlWFIwY3U3anl2TmwwTk9ZanJNdDhXSkNXcmVI?=
 =?utf-8?B?OWJrMERNOEpvY3FQT1NYWisxbEZ1djhuenNSTGlWVzBzQXJGQk5ZVzkvQ2xB?=
 =?utf-8?B?bEFyOGlJcW9SM1c4UG5xYW01eGhYUEViREhNdERSS0UyUWpUSEp4NVlJUUtr?=
 =?utf-8?B?Zk5MTXgyemNvT29hTlBxTUFjZlFzN3NBUDhvMExYRWN5MElYUjBrTjZNSU9X?=
 =?utf-8?B?aFdZRW11QWJ3ak5DaVZvSmtScStnUE9WbitkeU9oU2hTbitCZE1UdHVEUlhX?=
 =?utf-8?B?SDY4ZVl3S3RSNzYwY1B0cWdSTFMwRXlJc0t3UFdZcnEzRjNvME43Q2RPMnJG?=
 =?utf-8?B?MUZuSEhNMktOTkFiOVR0VXdRekpmUEQ5RTZJZS9UTzhxamZOWllMcURWTHNn?=
 =?utf-8?B?V0txYXE3TGpRSC9LbW0zTlFiNkgzdnNiS0RhUmt2U1FZOThxcFFwWlRrUnB6?=
 =?utf-8?B?TmhwQmVPY2hKR0hEdmJhd1FCaG9GdVg4SnBTb0YxWjVJWlROVFA5S1R6UlYy?=
 =?utf-8?B?Z3AxYnUwNDN1d0xFTjlVcTJQTG1JeHlVSElwWlVXV01FSjM2WUdKTTlzZHVx?=
 =?utf-8?B?REdnamJUazRUZklmYXBIQi9kN0gvL0ljWDJOMUpjcUJ6RHYxR01iem5CeGdR?=
 =?utf-8?B?Z2k0ZlNtVFFKMUtoa2xPZzZjVXdPZzVQMHBnWmZpZzY3U3cyZ2FkWHBYRmJK?=
 =?utf-8?B?Z1RMVFE5RHJ6ZVlSakZWN3pONUdpQTk2OGp1cVhYZHg4NVdYSWhxTVdJVjdX?=
 =?utf-8?B?UUtLYldENTk5THV2WnE3ZGhqbmlZKzV1WUZySlFVUFFwYi9rWE1TbXJHejVT?=
 =?utf-8?B?amw2ODFzd2ZsL1RPYXN2TDhsNysrdC9LaTdzWnM2TGtNbGMzNDRnVDdJNGV3?=
 =?utf-8?B?akNCY1doWFN4LzRWYlFrSTVZSW9aZkVHV0RuT1E0VG44RHNDVDFMVzJVTFJN?=
 =?utf-8?B?Nng2b0hDTzZqeXh3dXI3QmV0R09HRXJmNzlhWDJTRWF3K015L1p4RUxQckVD?=
 =?utf-8?B?S0ZYRCtoaDNSOXJ6b2VjTEhqMC96VWVkRUdlYWdGZ25JNlYrc3p2WlY2K05P?=
 =?utf-8?B?TzlLZHcyK2wzendHT0c3RDU3NUFZWU1ZZEwrUE9lVjNTSGFlclJsKzlHcXB2?=
 =?utf-8?B?RTIxRGRJYjZsUXozVytpWkpOTjZmUjMwcUFGUEtwNjY4RDVIdWNXRzlETEk0?=
 =?utf-8?B?M25LSFBNK3ordThEb2lYZjllaERsSHlWQUlXMDNzMGF3TnNsUXBWMmdPbUtK?=
 =?utf-8?B?SWdxUHBjK1MrWU1rWGRicUpITlFOcFQyTFlXRW0zT3RCbjNiRmo3U0ozYjJQ?=
 =?utf-8?B?RVBLTWw3SXdneFFXUmE4alRmdDZUWlRmckRkUWxlUXd2aGRjZ0grK3Q4NTR4?=
 =?utf-8?B?RW1NZU50eW1GR0dDSWFjOEhITTJ4QnBRRHYycm9aNnFlems2ZTBRaGs2bnlQ?=
 =?utf-8?B?UUNJMXM0WDZSWVFtUHFDTXdlSG9jME15Si9yRENnZ0tFT0hTaHIyOHNPNFEy?=
 =?utf-8?B?RTFySVJhUmttdXF6aEVETUV1MmlaN3lhNXdjKzdqVzlnOWljOEV2U1o2Mmsz?=
 =?utf-8?B?bzBBeWFkQnYwbkJ0empmSlVQL3kxdVEyUXNUZ1NsNHo5MldQOTRUd0RXYS8v?=
 =?utf-8?B?QkVUNWxmTE1nWHN3V3FuanhGbTh4TWgvTjJDSkJZWWFUYm9GSy9CRWxFbXdo?=
 =?utf-8?B?dEdENVJRY2JmMlE5bTI1RmtCMWZraWtRNTNCRHpQNlkzQWo0aGNiT0ZKUk9S?=
 =?utf-8?B?OHMyZ2V1ekFDUitaWGJMK1VZOUpvSGJhRW9KWWs0a0RCR1k5YnlFQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093b27ee-2189-4b47-4969-08de83a448b2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 21:37:55.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EqJjXEpWJu5w7cpNFA3tB6KwD+EvkwKMmMrMoLBNWlwnGgU3JbA5or6pBjLmleNLNp342gwcbiMvuhwXZuHuNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org,networkplumber.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18227-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AD43C2A117D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/7/2026 3:45 AM, David Ahern wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/2/26 8:51 AM, Chiara Meiohas wrote:
>>  From Michael:
>>
>> This series adds support for managing Fast Registration Memory Region
>> (FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
>> pool behavior.
>>
> Claude has some quibbles with the patches:
>
>
> 1. Type mismatch: RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD
>
>
> 2. Type mismatch: RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED
>
Ack, wrong types in the header comments.
> 3. Declared but unimplemented: res_frmr_pools_idx_parse_cb

Ack, this could use a stub definition. Similar to res_no_args.

Thanks


