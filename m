Return-Path: <linux-rdma+bounces-20720-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO4xDewEBmrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20720-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:22:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF825452DB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2488B3095BE1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D6338AC79;
	Thu, 14 May 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gaoU+3Z4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB63F4133;
	Thu, 14 May 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779170; cv=fail; b=XTuayoXP9ZlRg2dSExwOkdMOE9RnqTWe0OFy4zF6Nd4gHgoBal2yp43Bd5wfMn+cMDfE0BEkA8cO+NoixGwR+FAnREoftOVD9ppgxWRkrW8uROv+QmaoeM2bKlEI7m2iPeVPtthyaMie5ZbHAGwWzN1LUpg82MwG9pHA0P5Iklw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779170; c=relaxed/simple;
	bh=MiifoYgnewQDipQZgpF6hJ56ZDCeR0d1BsQ+C7Metyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GDnd/03/ChHiJj5Kwt75nCFZCZOAn0RZtGtd7oxJmeZ8GkhJIq+C6G9CMjjBCuB69XFJrQ0UpSCE0rLMvtPf3eJz/Q8WWxHVC540TLWA/1wMx2eWCVWWUdP+7vHLrbltvIQUm8F4c+jbM4PwUmpXLar/qogxrjekk0jUsgY3cks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gaoU+3Z4; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFQvOPqB+LXtn0xvdC/0kS1gDzC6PnVJ07fFA5KU3Q2I9nhCL+WJD8/pq8negATqZZQGcd9fN0YZiXwdNBzpkN6/NjS2Wg4GLebn/5PS5nfnMlctRmBgscj1Oq/yH7vSBMJR+Wsg26pRWKz5OrW1SzgGfTy8avd8lTC8lEy+aGOOjdZHz8g4KYSKrH1Gg8/SiLWRXP77zoaeIf7RCMScQOXgBZ+DMoXnNqu2Uye76/FeG2dFTh94j0LRmZ4Hf+pRFqNPj2CFYQdv/+wIH5qChY2uwb6/Yxe6+fWLqYy65yXVVXVrmyswXqqh1B9EoQsFA91opIfkdiDiRJGa6Hd3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goGZpoBweR8E3emFtVHa3AwOPfjm5i2btmI+gHsQxyc=;
 b=cuKFM/8pxnE9nfcu7GcspCpRsit5yydKEgzRp1yWOCtYP3xgvRvTGnlPutOgpRgPXB/FFYJKFb3enCEVPsXkN0P78eJSGMggKVMfR1OcVe8YJ/0vW9eY7jAEznJgwlGAFcaC8bCq2wuzsLpUO+9Fnv93gPBvc6UgopxnbheE0P4EI4TXCSVLDgTsEoEibUiRk39h/3G6isyavbmi/ruA6RTCPEaU5SoecqCbay7EErPDaN4N/wETHMQ2w97kcD6QBHHpET4hwQ/EM9YvhWFwNZoevOj3fdpTr/XWjtufXjUjWLvlTRaAveP+2Nze0lXIojAK12BOKRQhRPOuvMlkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goGZpoBweR8E3emFtVHa3AwOPfjm5i2btmI+gHsQxyc=;
 b=gaoU+3Z4/bkRNfpnC1bTCXmmmJf0Y/lzKiXZfIxLU6CrsujvWEZRmJJLIRBCRRzviHXjczggDInHcpzgEUP05qItNnvZ6x15HbEuIDPOnxdDDPfm1ddMlqZJeQ1wdM1MyKu656Qazd/qUxmCS6nXv1i5Lt6u0kKwSGo7Q9yS2DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 17:19:26 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27%6]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 17:19:26 +0000
Message-ID: <695c2fe7-0a30-408f-b699-b1726e201bdd@amd.com>
Date: Thu, 14 May 2026 10:19:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] RDMA/net/ionic: Misc updates
To: Leon Romanovsky <leon@kernel.org>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Allen Hubbe <allen.hubbe@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Eric Joyner <eric.joyner@amd.com>
References: <20260506041935.1061-1-eric.joyner@amd.com>
 <20260506155954.17e984c6@kernel.org>
 <4dc23648-7ec1-b68c-0e1b-282e014e534c@amd.com>
 <20260514164029.GU15586@unreal>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260514164029.GU15586@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::19) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 959f5adb-2699-4327-19a8-08deb1dcf2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799003|22082099003|4143699003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4sXC94eGoYrwtAQxbkdTmtqXX6jkUfGoeio4UW/qXKkXCTuTOX2W+TwtSCLBYp+/0vhsZnkNn1+8GzWBJ+GCfhWS04rVtKsoiOhIB7iM2o6glD6m1WtQ7Gvgf7MQNUZxn4NDjFFX6vQDfeHPgg/YdDiqQtgu7GETru1uEsl00CexxdfkJxatY3oUdms1TA1lU/tm8o7jifsqqfrPSKKcArmPxSHOh0zxdAK30xk6fOH3sIvR5upZyCaerC/aAwzFpDzAdcl7MWNYZNloc0ruqbJIpnpdxHV68eqV3pljDBFgLCvNSVhM6OXRZ8NFt4gmhoGDBNWFtrn+2YiSqu5lFZOWkEC84qvotz953smTleACW8LnhpCl8bvPvjn9YrmWEp/992moDVJV+gNEamMgP8jTpnO1PsJk4EtAHkV47QkwPfeXw2oG8WYEAgFxJCgLJtgPyj/8Y/67KiHlLB7u0Uq0act12wnOwGm9P2anMWjKx1jmc0MxYZ2ycDh7ZJvsqViZLBXJLZ5JdJZs2xAzCefQc//PQWdgVfia2pTUdK45ufOxicxA3pjAld50YGOc5+WB7r44WijccTdwr5d6gLkXOJirOJdoNor4xN+/2HrZz4Fm+JLi7EUADhLDFQL0Qoj9vrVVZO5OLt8UPuzUZgXfxzoBnSYoqIk6TxTvY1+ROD1fDrpAMN6uEm1XIrUP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(22082099003)(4143699003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3JSbEJCUk0rODJQdkJETDMvUnRTd1h0RXVITU5STFNQVG8zOUtkMi9FOWVE?=
 =?utf-8?B?QnZCWmRSVUNqc29WUmQ0SjFaQWJFeHNXaElOQ1JqWjhFc2dqUk4rUUhiTmlm?=
 =?utf-8?B?QTRlZnVSOVpua1lEOHJjN3hZbEtFVHZITFE2SGtkdTZLMWJwU0NsQ3VYV09V?=
 =?utf-8?B?SjUybHoyOEhxNlRzazBha3FwYStTOUlkUWdOU3VSdXZyR3pkY0Z3VWgwOWN2?=
 =?utf-8?B?UFE3MkJPQ1hFZ0k2OVJxRnQxQXdrWS9QMlI2OTFjTjdubXRSRGhRT0grV2lF?=
 =?utf-8?B?V09TZGhRSHBxWC92b0pGYWpNNHhwT1VmWEhhWDF1MWxVM2R1VzlOWFJ2YWJv?=
 =?utf-8?B?bE9kN1U5dWZjOVdSSjFNdVdrbTBmMjNFZzYzSFRrKzZjQnV3TVVpcmJjNXVI?=
 =?utf-8?B?WFk2S0NUaDgrc3FMNHhpWEFLRWhRejM3UWZsdzRaR1BsWTZQaGJTZTZkWEVQ?=
 =?utf-8?B?OW40WnN5SGRQcGo0Z1p4Vk1pWTZHcGl1aWJSN0tXZGphbktuYzBScUVEanBI?=
 =?utf-8?B?Vzg4UEFGZXRDczBvb0UrLzZtdzN4L09XNE9HU2hyUVpnZW4zZExpUDNLT3F2?=
 =?utf-8?B?bUx6Y01hRllRSDk5RlgwOW5zOWlIRU1WTEJ0NWlGTUU0TmIyNlBmQXI0TnR5?=
 =?utf-8?B?aHE2THZHVm53Zkt0RHl3NkdDMndYQ0tXYTJsMmpKOE1za2VSNE4rMEFBSFcy?=
 =?utf-8?B?TlExQWlWSHV1RFgyTE44Q05NaHp0L05UZ090eCt0Y0VmaXEzcng0VWo2RTNv?=
 =?utf-8?B?N3d4dzJNblZBUW02S2thN3ZQYm9GajVXT3BVTEVaNEFYTkx0T3pRWWFpZDZx?=
 =?utf-8?B?STExSkZpeGxveEg1TGNWaUlKSlRIdXp2NmszbGdIT0lMTnNZOExjcElKOWF0?=
 =?utf-8?B?SkU2NDB5cTdsVlZFcFQzT016T2JMNHp1ZXB2WTgxOWJsYzFrVzZ1Uk5HNmxi?=
 =?utf-8?B?L0o4RmxIeGU0U0lJcERrMVArUDFJTWNpNzhyK1FNanhxTmJCWnhsdStyM0Zw?=
 =?utf-8?B?NHRJWUM1eGtlYWl2MmVNMUdSQ3RIRDNaQVlQSkNXNXVGaEVaRC9tNHJPSFRO?=
 =?utf-8?B?eko5MnZkSTNRb1ZYU0NHdzJtaVNDZmVXVzZkQ1dWa1BtRTV0b09SR1pLYjBP?=
 =?utf-8?B?eVlzc1JNclZSTmduQ3B0M2FhaGs2MFMxQTVBQm13QnZFdHd3YWYyVDlQNk5O?=
 =?utf-8?B?TDczQjU1dytpcUtZZDFXQzNrbHo2ZFJpajMzcGNBTWtEQUt1d2FpNEN6OWcz?=
 =?utf-8?B?ZmptaTByemJlbFVSYUg0OTF4Z2tHYWVWSUVNUm43SlVYem5OZG1wOXB1dTNX?=
 =?utf-8?B?NE1KbUNZdVY0QWNxWTNybndGWmI2MlhYa2gwYk90bTdRNVdqRzdNOHhJM2VX?=
 =?utf-8?B?eitrVzZNcmpOaGF6THFqVjBncFJUbTNTclZGVnVOV0R0M05GTFRjWUVYdGpo?=
 =?utf-8?B?eGwyZ0V2cjdGK2NlUFVZRFhFU0k3UUV2aytPNVgxa0Mwd2M1Y3lmVW4yOGpo?=
 =?utf-8?B?TmVTcXFmZWpzV0VUY3VpTHJ3U0JKcHFlN2h0RG01ZnR6U3BjU3J0T1lGV3hl?=
 =?utf-8?B?bHFKVlE1TFNQdWJaZTlFMExiUUFNcFdadSt3TG51dlBjb2ZiN1F0eUpNQ2dW?=
 =?utf-8?B?bk9IdEg2blJkeU1DN2V0cmpjRmZuZk9FbG9BS2dRdmtSQmtncHAzVWJWVjJF?=
 =?utf-8?B?RW1zR1FTQ3N5UjJJdXNOYzFEdU5HTkJHUiszdHh5WCtwRTZtOWwreGl6Kzdu?=
 =?utf-8?B?QzVrWTF1bGhmSElDeGtISFo5TnFydVlMTkpKbTR2eUVzNjJmQzk3SWYvY0lN?=
 =?utf-8?B?Q0lGYVRZQUN0TGxBd2Qya1RLcCtBZlQ5ZTYyc0NxNDhUTDV1bWRlYmRTeXk2?=
 =?utf-8?B?Z044ZDdrQ1ZRdndIY21GMnNJVDRBUHo3QTM2dCtBd0tJVDU5dWsrTUh0c29h?=
 =?utf-8?B?eTdzVmdyZUdSR09xQnk4VUxXRndLUkVUNExzZ1hFcy8vSW10MkNocG1vVHl3?=
 =?utf-8?B?aVNoODhVTnZEVFczSGdqOEtqQzZSdjZMMitnNXk3L2hiWjA2RFZEMjQ0UTBL?=
 =?utf-8?B?NDB5c2VqVStWR0lHK05LL09mQzB1VFFWaUdqUUI4enozbkJRL1MySVBZMU1X?=
 =?utf-8?B?Qy9aekdDclpyR3RaK244ZlZHZE91end6Q05ySlF1d3BvdEU0RmNUejFPSmZR?=
 =?utf-8?B?azkzNFNHR0dublRIT0dGa2p2QkExTThKWmthRkFxYVIwdkQ5ZUFTWFZNZElX?=
 =?utf-8?B?OWJaS1paLzBhb1d5RC9Qa2xFTmpQSk92N3U2ZXlqbUxiSWFlRXJLTHBaYjBN?=
 =?utf-8?B?YVZQS01ESGtMUzNnZ0JTYTJCVjFObnRPUXd2WVFyYkxqM0diUmpKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959f5adb-2699-4327-19a8-08deb1dcf2d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:19:26.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHAiuSIJc2JomrMGDkqZgpgIxJAtr+a5bsrGqz4eB0cGC4w9gbIaC06LIEHaAkiGsSo62VX77dzW1q5ZyeXsUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
X-Rspamd-Queue-Id: 2CF825452DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-20720-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Action: no action



On 5/14/2026 9:40 AM, Leon Romanovsky wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, May 14, 2026 at 08:03:09PM +0530, Abhijit Gangurde wrote:
>> On 5/7/26 04:29, Jakub Kicinski wrote:
>>> On Tue, 5 May 2026 21:19:31 -0700 Eric Joyner wrote:
>>>> Other smaller additions add a devlink parameter to the ionic ethernet
>>>> driver for enabling and disabling RDMA,
>>> My understanding is that the devlink param was expected to change
>>> the configuration of the device. IOW user can enable/disable RDMA
>>> to save internal device resources. You seem to be purely preventing
>>> the auxbus device to be added. So there's nothing gained here compared
>>> to simply not loading the RDMA driver. What am I missing?
>> You're right that the current implementation controls only the auxiliary bus
>> device registration and doesn't reconfigure firmware resource allocation.
>> The intent behind this devlink param is to provide per-device granularity
>> for enabling/disabling RDMA. In a system with multiple ionic NICs, an
>> administrator may want RDMA active on some devices but not others.
>> That said, if this per-device control justification is sufficient on its
>> own, or if firmware-side changes are a hard requirement for this to be
>> acceptable?
> I'm confident that the administrator can vibe code an appropriate udev
> rule and disable autoprobing for this case.
>
> The real advantage of a devlink knob here is the ability to control the
> firmware.
>
> Thanks

Based on the documentation in devlink-params.rst, the devlink knob for 
enable_rdma indicates that when enabled the driver will instantiate RDMA 
specific auxiliary device of the devlink device. The documentation 
doesn't state what to do when enable_rdma is disabled, but it seemed 
like removing the auxiliary device provided the opposite behavior of 
enabled.

If that's not the case, does the documentation need to be updated 
accordingly?

Thanks,

Brett


>
>> Thanks,
>> Abhijit


