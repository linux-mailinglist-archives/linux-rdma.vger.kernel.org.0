Return-Path: <linux-rdma+bounces-21351-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFLGKTbrFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21351-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:01:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8535E48C3
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B46533016832
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF353FF8B5;
	Wed, 27 May 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F4Zty1IE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABA211A14;
	Wed, 27 May 2026 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886403; cv=fail; b=JdLDMIDOftKyqeUUIN8CSAhB5DJdplvyUzBWIeLg77iw3WYrIwswi5U4B1901hU/t2Sf4wjduxJy4Uolduu19fLbid7Eiw0VXe0AG4/DBwUdj2jgnJ2amurUYDFYBGnY0BQ701+Wc9IZyLoT4J3EnnFMyanBZwsi+b4CGf4BQyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886403; c=relaxed/simple;
	bh=JkRHH0CaZrjqB/7aHpNeaq4bfeVkGjdlw5BbS5gerzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTWWwsShYeOJG95GjjWUZ6OLuB524MZd4GcqGspM9VLA6a+Mz9jJ/qxxQkHQqaLV8KEwaLU1WkPyS5Aykia/woVdTIvLyUf/VLqRxAugsENXoVObwaz4wzosfwpmzB3AqCkJJZZer2tPnXhpvmPH+wkG4mzdBWPWO4n/L89K4i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F4Zty1IE; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPDQ2yWvA9FkzRFo8TrknKJTlFREXrz6sp9XLcIsMlGOdidhEwsN1DQtkGiSlBuVsSTkTANfku0OmFiw/a4/1GtHCeKpkziLet/g3XwHmZ/etoCnOkX8qgG+Z8bglzKXZz5yydmkEZ1eg6+taGVDNjwfJsxlbRo0UB77DFKXOOly6m4G3smN/fw5Ax/Ds6oggyp6epxjcZhaLzT+U1Ams7mv6wj08/15kLPW/1HCBes2w+/pkAE/490YQxUSoE/TYyStx1E3WuRqZogkC2W1pal3aFUZhLvu+nq1eOl3QvSQsCDD6+/fxgIrrm0IHORtVXXAMM6i8ZSS1WaU4EbUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4PI9faZbQMsAAW94xXtUjPhnmS/lLjslthFk6i/eB4=;
 b=JgVYCfmMIsv2apWPAb5y2N8i+w0ZB7msMaINM0GHCrsWipWVIqrti+CIq3FQ7ZgCkBkxh6xVmhccMB8VA4ojm3A/STRLsMTz5j/iq2onJtu0xUObLJNv78LN6gDadZ5wNUMYxxnltbbGGCFrpJQVw6kW5Dr6AG3c2jub31CGK+zfFJpkGo9i51OMLNk/VC3iCEFYzFa5X2PVsVjFOqr+tcKFGRVs04gjbH169Q9ILK2a4YYP5vuqhXwpHO/s5LDlXD2oub1pdJyunqCkUeH+l+MIJkAbg5ODKZFyX/82Ku3GfhcJt+TPvf+p29rQw1LjRT/TOASLr3u6IhJL7H8CHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4PI9faZbQMsAAW94xXtUjPhnmS/lLjslthFk6i/eB4=;
 b=F4Zty1IERg0YCpDNh3ut4pQlnFdYY819I0812A8zF+mkIDCerV62XjGeQT+fDez5pb5F5ShuUg3L+8mkOyqgcpNHlhsPRnkhxuWQ2PaFlvrUXT+EXin+5xeZYwdJA/AacnV+NgSAnpaxuRGWxcBqWx4pZg0WYCoAr1IH4mTgc3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 12:53:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 12:53:12 +0000
Message-ID: <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
Date: Wed, 27 May 2026 14:53:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527123634.GK2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: cc980e0a-877c-45e0-f0b7-08debbeee966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	9gIrTufGTRsUQRMddbWwbdmQF6qw7zE+dBa/zi+prmab2Bu6Xzw291wUsBq6M79XQDjLvIw9rFg5mjXnSN4IyGwtqUImmNBg5tLMjE9kSy4N4RM+dCAC074JZg3qFGtu/Q1r5xcxaVLZ8pNzt7AsLnBmRGokLeOegWR+mN6O9D4OA7FPY4Q4NX9uOqdgEwrYLIGV8owoZxwd34fFjJvaOf46mJuVBDMLb6Yh52OzIalpzD3gakCKt3JfEqhsANlwv4ekd1sndrcsjNVaDnyWeJ8Rx5BQdRSGjdpvWGHfkEEPBS+uhJuf5Z5q9pL+EUSY6pMabGmEhfe9EFRpzKIzVFWnd4AkyxEPEeaY0b3+fuw24r6kCQLfXtnjra7m1sUiNrUZMjW9LJJP4pPLOHhvDy8mGGDbg7Dh+An9J0UTBzEdmEIugqoEAjqobgrt09DINmZR/LgxDojW/76VtuqLDAshCeTQMjzLykM2ugoNf4oK9qqk0+eiUrFnJ/WmHk2+VO9fZVvB4CRabStxZampkdJvmkCY/laCAaLEbUiMKRbsS1eJLlM8caxmiyWuuWwak6B37JxenSCU///3iShJPo512dsDaBJhvlqNFkUYxdIHunq04brTsrXKpQjSldIGCV3h2DcXxv8/HxANu5GXEll8ViFVsEKvi6h/gsR0MNq/HuUr3Aqh7MMNuUE3er6R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3dlUWVEbkpGaGpQeEZzd1BOTXpPbHlsWSsyZVppQldpZnp5Y3cvd2xwZTZi?=
 =?utf-8?B?cjFMb0ZyMWJGbUl3b0NvOVdkN05TTTZVMG85UGlLbUJuNlB0c0U2YUpKd0Mz?=
 =?utf-8?B?QXlRa052c1lTT3Y0K1VzY3VSWmdKdllxUkswTUc1TTJkdnQ2TEZOZG9hd3dL?=
 =?utf-8?B?c1ZuQUlnNW9YL1laRFhBb3JwMGh0ZTFSdGQxS0RzV2h1UHk0d2dBRGE5a3dz?=
 =?utf-8?B?SHcwYlNna2g3MC9sb3h6a2xPUm9DUUd0bzF5RENhd0FEVk5Xc3Q5SGJ5cGtt?=
 =?utf-8?B?MjhwN2R3amJVT1kwTkIzY1NiSDNjdlh5c2wxRXhQRHQreEZSOXJHQjdXaDJW?=
 =?utf-8?B?bEczdnlXTE96emdwZjJWVDdhdkliMzdzcXN2ZE5uZklLT1NYVjUrQ1ZVNndO?=
 =?utf-8?B?WDJyeHEzQm9qQ0lKVTdBNGE5aHFOcUF6bXFycUxOeFN2dEhoU2dZVEl5QWk1?=
 =?utf-8?B?aWFqSUNOVjFaM2NRcGtlN0FvcFZvU05WeXVmbCtoeFcyeUtlYnNoSGlvWENn?=
 =?utf-8?B?dmw3aFBZdXcrZ0xSRVo0WGI5eG9FcHphdkRCZ2ZPMzhKYXRhclVPWEIrWnRi?=
 =?utf-8?B?a01vK0g2cXRKQzAwbTN4OXc5NlhRa051alpyV1BubE9mVExDaTJKR1hSNG1K?=
 =?utf-8?B?eTVqK1d6V2JPeDRLYkhlYUYrVjRLdjczTjdlVWsxeDJHNW04SU00OHNBemY1?=
 =?utf-8?B?TEg5d1ovUG1EaE40Y0h6VlFoSkNqbFlSc3BQdktiZ09ZWXVUa3haZi9sT2FG?=
 =?utf-8?B?MmVTeTFYUFozaEZlNEY4VWprdkZvQnVVTFRvdGxacWJFY1YwUUQzcUFndnZD?=
 =?utf-8?B?bVFXYjVCeDRRNThrS2JBam9IanJDZm52VDNXTUpWdDFqd1YvZVpBai9oNC92?=
 =?utf-8?B?TDdRbzF2RG1YMVpBbTlIQWhra0w0Yk1BbGpqSUgvZXlDUGY3WFdIUElXWG1p?=
 =?utf-8?B?Q0JPeW1MOTlIa3JrSDJyZmZLNnlBRHRIUi9qaDdWSGxjVUdub2FqRElpMkJ0?=
 =?utf-8?B?bUJ4U0Z4cWU3RDQ5RldrcFY0M2w5N0FLaTRrR21QaVJURTFLN3EwOVVjWGdl?=
 =?utf-8?B?VWx6Z25iSno2RlVzMmhHK3kvZW9JeFlFeDJZYWFabzN4d1FrVmtud2t6OU9k?=
 =?utf-8?B?TXcwQ01pR25OdUtkSm1HSTNRaXlZUTJTbHlSblJFN1I2TGh4SFU0bFEvUmIw?=
 =?utf-8?B?UEp2MmJsd2FqMjY4OVZBSDdVeVdqOVFQYkQ3eFNwTkhrVHk1dlV6K2s1NzlF?=
 =?utf-8?B?S0dSSitnR2xNWlZxaVZWTFFKN094eG1RRzJzNnhxMFRQbVZmSVRJNmJ1M3Ni?=
 =?utf-8?B?RjN0djZwd0xmMHBFckp2Rzh0MmUxcThFRDQ5OEw2azBOYXBHVmlab245TFBB?=
 =?utf-8?B?Zmk5ZTVycW0zd0cyOHN6NnlGMmp2QU5Mek9YUXRZMzdYWEFMU0wwcWxKOS9F?=
 =?utf-8?B?MUxiRTdSb0ZnNW9vYmlnRGxkVDEyZE5VM3ZWVTRSbTFjcDJ5RENQL1NkbS8v?=
 =?utf-8?B?TkIrQ1hVS2lZLzhsdjZIWjQxMTZ0bTl2MzZxbUp1N0YzelJLVVR6RU5YUStF?=
 =?utf-8?B?N3EzVDg5UWFsVURUSzE1Qk4ydS80bFVRN0Q3VTZWR0FpYm5qTityK3Z2M1V3?=
 =?utf-8?B?TXNCWEJwV2l6U1plU0diN0pOWHNHVHhvc2pNNjF1TS9Xa3Z0ZnBTKzg2OGpK?=
 =?utf-8?B?aXFSUkQwMUYzWXVsVEwyZEFwYzZ0dzlKRjIzenNBd1U0R3poZUxwV29WSE12?=
 =?utf-8?B?eEpQZ1JYdUJycVNVVE9HSWxRU2RUN1MvRk9kdFZnQ3RTMjBSdVkvckNwYzgw?=
 =?utf-8?B?NjZOK1U5ZHd1T0t1OTFzanU5THpBUkxuTTdwKzJnZGJ5eVVsOEtvcnlTQnZU?=
 =?utf-8?B?TlUrZ0JycXRSTVhpOVdrQmd3dWpXbVBqTXR4dUtoWGpXazNpdGc4K0hJVDJx?=
 =?utf-8?B?Uk5RSURDNlpNWHlMVnQ4M3VXZmNyeitDYzFIbkMyYTRocXVGWkg3ajhYbTJC?=
 =?utf-8?B?Qit5MEo0aWJSZ0VFMTNqV2ZPR0NtZWEvT0d4OTNQbE9vRys2MEJRc0NQZlZN?=
 =?utf-8?B?akczLzdGZ3RJYlN6UFYzTERNN0dzV0RoNVVRamxOWUZBUnJMLytCTlNKbzZ1?=
 =?utf-8?B?S1J1Ump1WWpjS0JkK1JDY1hYbGtuNFk5ZVJzQ1p3Ukk0SDVCMWJDeGdMZUdv?=
 =?utf-8?B?VGtESTREam5vMWtEYzJRTmZYUldxT2Y1c2R6OU5LZWZOT3NFSjl1WjlnS2FV?=
 =?utf-8?B?SnhOcTBlR3lEazdCeDBuT2JBN2doTDRoKzZzZXhXVEZteG9TL05KQm9acUtE?=
 =?utf-8?Q?MucUb6SGV3RRm5Bwbn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc980e0a-877c-45e0-f0b7-08debbeee966
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:53:12.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UtfwVixnj3JCExTufRllquSL7s/2Z1j9a6+fBDuZ/I52IrCF0D0VixRR6XkCg2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21351-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: DA8535E48C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 14:36, Jason Gunthorpe wrote:
> On Wed, May 27, 2026 at 02:23:46PM +0200, Christian König wrote:
> 
>> Yeah that's a good point, I should probably rephrase the question.
>>
>> I'm aware of how TPH works by adding the extra ST to the TLP.
>>
>> But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?
> 
> TBH I've never heard Meta explain what their device is doing with
> it. At least it seems to be super important to their device..

Yeah I think at least a brief description of what is going on here would be necessary for the review.

Otherwise we have only the info that the exporter wants to give an opaque ST for the importer to use and no technical description what that is good for, how to test it etc...

Regards,
Christian.

> 
> Jason


