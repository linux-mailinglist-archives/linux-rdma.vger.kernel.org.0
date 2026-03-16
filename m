Return-Path: <linux-rdma+bounces-18225-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INhOBHZ3uGn5dgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18225-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:34:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E0B2A1028
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D3093043717
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2736607A;
	Mon, 16 Mar 2026 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="mSJHV6Ci"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020111.outbound.protection.outlook.com [52.101.85.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C33659E0
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696707; cv=fail; b=q2xAJTtwLEVpIybnebN6W7EauE3RawDB67OPG4oV0YU9AFXnAx9mKd7lSqKnuf460OCFcgUGXN8EKkLcUriqZFKfQ2Bssjz5ePZ5Cv2a92huysOKmxjoXSe7yGAZQbLGbpxZPNBWuzzHHwnM62UV9j8W3VGlQ6qndkmORdY6a84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696707; c=relaxed/simple;
	bh=sP0D+XaI66bp4Yy+gNxLO/SntEmGVMD+g9I/BuLna4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mo8SeoanSqh7OtaLfp3oXtiv1+u6eG/qyb5zEEj8JeOinrV3+WyWwzaG5jqShJnQKky88ZgVfzmO4BMA4R7RFCEy6zkpfSt9fRsRzPuR7cP/IGh0aAPL8IRTCeHpntCMUpbUNio9eqkPXK4iTN0sikuMW4g5qU/gxnFV6zrhmc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=mSJHV6Ci; arc=fail smtp.client-ip=52.101.85.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTdTn12GBdpzVaLJ5CeYpxOIDGyLFPuxpfHqKQfYfzkOV/mCXx5/0FpOZuWQMRpSzZPg4RIetGVG2RMc3V/3K9R2XVHu5sqvLphDpNNgnwIcGYb5kENm4Xd6Zi55RzuZRCVuZIjGK5B9p76vhv3XtPTxTeZBKZvt8DSuxAl5TfChJilxlJKPythLmbywlERt+MJhalY3LUn2yzoo93S6NS0A+QVBU6JxzR5NYMH2w7LtEfjdfcI1eWBfmHytC4ewHXC6ux+8IFa13f/sOSc6HCirz+ontYVRONU/3BMblv5rggTQaW/cj4YAF+yLXK6kN0wERCo5GVXPHJ/eXdQl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAsUv8qkgClqGaRB3wAZx0skG28umibxnGxkaeriFlE=;
 b=SSz+tBZkfgJa92mpGWDH3LufA8yQAKbP7WBbKUVn52x+BGevYmuVFjbVR01Rn7UUeBBAAu1WxjpzlK6SG1AbWfu/hQpTNHvFyg8I75vDhdMb9tg+P7pbKXG5D3jo8t3xCtKbY/aEYJT2e5XmBHk9kW4Deu4WDmKMHAzEeh1SFjUSHQrZfO6fbJll/bzJD5JDHR+94zU91ApnO3VAJBMK2jizngRYXBIXtWp1fh7UZCjrr+qCF3MODPzkfPFzHsroF0HZNPVBolqWrbjW2m3GeEQjtiiwfrP1WcA6CDuP+bpUCEC3i651n5+FHqLmzOJ+A86lFusI/rCtUpA/6A+HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAsUv8qkgClqGaRB3wAZx0skG28umibxnGxkaeriFlE=;
 b=mSJHV6Ci+Qz6vAG1A6gqcuZ/S9Y8GLR8ve6LFfhjjCSNGjgshNCaW/ML0yZmH+H2OqE+35jIMq8qSV1JfYABYMeZUR4VuSZKuMzRWf/98dXcYN6QRiLViUN/RMafkHWgUHHsGtlvzWQkoNEfmbI+gPrRd5RoOpY2UMhr8Q2oYfUNwsvS4N54R1UsP9yLVcZ2b4DBm/54UYO1YQ/o63yatdRpgkbFyomXjWfAtJWxlgM0H2JMp7wj34xN6/AusofYX0h+WElWGQnt3LYUME/k/yV9Ay+douwNeOLlQ7a/+Cm3dKCRczdZBlm7kP7sclP1T97KIc3yRFGwCytqQtX+ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 SA1PR01MB6606.prod.exchangelabs.com (2603:10b6:806:1ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Mon, 16 Mar 2026 21:31:19 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 21:31:44 +0000
Message-ID: <2ce72f8e-3a7d-46c6-9b1e-68f99c91a6d2@cornelisnetworks.com>
Date: Mon, 16 Mar 2026 17:31:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next] RDMA/hfi2: Consolidate ABI files and setup
 uverbs access
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
References: <177325043749.53056.7110333022279342594.stgit@awdrv-04.cornelisnetworks.com>
 <20260316142738.GB61385@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260316142738.GB61385@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:610:4d::35) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|SA1PR01MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d072b0d-0003-4096-8a08-08de83a36c03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	bP3cuM+q+zMe4Pkccaw1n4lo2bc35P1Xt7C0gfqIBSAIrXoZ9FKEkcPacRdW92NBPRAqSd2hHER+QkzgtBxXvWc31KZ70O6zO2nVX8bhH9nHHUM7DROEGoNRMIDq3q4YBzIyxbvExDGD0mar1xMhID1vxKrtLyQyrWjiV1TgLsNpOnXoA+2wd1FkiYvcUfg9Aqjezvi5GzmKQfBjVs+iNsY8NqQ/sg7yFB2vX71StUB/iohk4hH2nD96+5W+jJPuPolJzIXmaGNKVIXexRCYcdlLSe4xOqZkpi03G7YnBxtQR3t8yzBYqCKuPd3h5xh68fpuZ7pQeePvpWLrUnMKTkL7IYb5La73P7koR7gLG3VZtlEk6ZxBTDP7TonQzqYcU/D4rzJlt0wd1e0s20IqzRJOCp03Hgn3iYTRHohMaF1Hx6HW83DBWCikVzj6vTAd2wpLSN9Zc279f4i6v1oa+yFasnHA50srj4wdRBq6PS/ZlGygIDfO1YPkYaMc1eUV1uAP5zVccCzNjnb0TAFoItnBNIS+YWR9S9ILjs5GZ6wHnj6ct1Bkb9KikjnE9IEyJbzDX5lRqAvbx253LZ3ArfrdRwspCPVplF6cemIzQ3/GHF+30KXb+14NQcSkEaaeGEVfAZibgHzvTV4US4BTRkbbFd1G638TlIzsmfpFdumgc7D2FAeHQU9PkRSzcluJHXJJ/ERNmvqv7mGkaWX6LwWVMGx85bH/kEfXcTPPRGk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1FTTFU3b2xKVTNTYm1lcXZaMVdnNnJBSC9ya0ZwSFBoK3NzbkxGbHNsRWZW?=
 =?utf-8?B?SURqV1Y3VWR2UHpSQ2ZBK3ZtdGNrYlpXZGpUYkdFd2lCdEhqZmphM1o1VHNM?=
 =?utf-8?B?NnFqZFpUWktzMmVxTW9PZGVSQkNnVkwyc2VFQy9YUTVkdGJIbk9vRWRsak15?=
 =?utf-8?B?ZTB2RmM3d0pDVUFzTHh5eVpNeWlTL2FRQTJFcjl4eWZ1aVdxVThNR0xWdUUr?=
 =?utf-8?B?YXJSanA3c29IRXlxQnE2cDZSc0REdlJZVGs5elRmbTI2M2ZISy9KUzRMNFNz?=
 =?utf-8?B?NTRMc0xkdmdaMmluZ2xxeFo3YXltOUJ3clE5NG9lSjU0eU1mMUhFbDNna0gr?=
 =?utf-8?B?OFF4d1VVQTBmV1lPQW9sMUxaNkpNYW9Ua2xkUVRSSEtydTZicDRrT3R2c0JM?=
 =?utf-8?B?K2lzY3pWTU5lZmc0dzZBTkI5UXQ2V0Z2dGdudGxKOWFVdWlmTUFsdnRhNW52?=
 =?utf-8?B?TDlGMERjM0JySUxXY0xFa293VHMwRXhocUtHNTdKcW8rMmZ2RFh3dHdTV3Q3?=
 =?utf-8?B?NkM0aW9nTUhDREU2c0ZQSE1EanlOMG1uRzVCZnUxM1U4blM2T1N3YStwWGkr?=
 =?utf-8?B?QldFamhPTkFBN0xqZjdIQTh6Um5GM2hyUGU2VWNuVThVWVc0Q0lPcWxyeEs3?=
 =?utf-8?B?b3J2czN1d2RvdjJkNTNoS09KUW02RTZaQWs5akpRMk9zUHhnZlVyMGVnb0lH?=
 =?utf-8?B?ZmdwaEhhRit5ckM0TnRNY3FkYWdRN3RycFljcUhKZFkvaUVrVTlJN1JRbmRv?=
 =?utf-8?B?aXdMUDVWNCtadEUxQ294ZWRsUGtwdTVKQ204NUovN1JTdjlrZjFIdkxMQWVu?=
 =?utf-8?B?NWZHTTM0Y0ZRNDkvdmRVbTMzc1QwVGtTS3dSampyUTZXelpFbnVVakM5VUF4?=
 =?utf-8?B?ZG1HdkJ1b1VCTC9TYTRKSW8rVU9vbFFNN0V5a0VIdUF2cTRnQzRFMkJpNVBw?=
 =?utf-8?B?T09DZEFZSmFtbFZIUlBGY1lLWmpNNTc2WFBRM0tvNWRkQlNadTUxYldmbHRW?=
 =?utf-8?B?OWxQbUI0a2Ywb0llcStseGQrdkNLMU8wUEtEK0JjalVxaGJodzE3Z3kxYVpD?=
 =?utf-8?B?Y3pIWXlEaUVPeE1qRUdKK01zV29PbjBhWXZiSDUyZVd6QVJJVlpKdndPSk4y?=
 =?utf-8?B?d1hXcnpiL0RiZzlYc0xvaTNHekVIUDlzcXZ2NHhIc0xKbVBOeWtPcFZLZXd5?=
 =?utf-8?B?Y2lsRWRqa0dkeGhrVzBoMFlxWWliMVBhMnNpV2FTZmJ1WGhQZWQzVHlDem5H?=
 =?utf-8?B?VTVSZ1R6NUplS2dvdUNGcjJQeVpJZmJ5Z2RXWmpScW5SNzM0V0xnbXh2enVr?=
 =?utf-8?B?TW9qZElqN2Vaby84eGQ5Sk5Jb1BwamVTVHoyYkxkQldCc0VKSldDQmFjSGxE?=
 =?utf-8?B?TG5DTCtHL3k5N3Nyc2tLcGtUbWJvN0pubFJXSGh4MFpUaXJFaWxGbVFUQWJk?=
 =?utf-8?B?WURLd2QyUUxzVXhpQzR1dFdpWkVxb0k2MUE0YVovREhXSnlaQmRTemMxRnRy?=
 =?utf-8?B?dEMrcmFtdVpLN0RLV0FLVDVPeGVCM0RUNldkZW1hYm10WVBRUlYyWldVVHN3?=
 =?utf-8?B?YkdmRXRjMkltZzZOVHJJQjh5YzJqZVhPcHJLcFFSdmNLZzVlT1N5WmdDRUVu?=
 =?utf-8?B?V0Fra1RYYk1EbFBhRWNDVGVqNTZIN0w4UGcrb3liaWRCaVlSdXdtTHFhbGR0?=
 =?utf-8?B?QkJ5RUY3QjlKb3VadzdPYUN0TXlEMzJsQ1BRaHlJdmg5dnhUdFJiZm1RczI5?=
 =?utf-8?B?Y2R2cjkvaVpWWGxFK1dTVThyTXoyc0ViMFlGdUx4NG84S3c4MVd5VnJGL0xx?=
 =?utf-8?B?OTVselpWZTNvOHMza0ZFWVp4SktvUDZQWURzZlpNcU5hODhjMm1NME8zbzBu?=
 =?utf-8?B?VVBEZjA4WGdLL3pqcVl1SnB4VzM2RTFRNkU1NzZFazA2TTFmRTltcURTejdB?=
 =?utf-8?B?UXpORmo0V2RZcTN3THEzeEJnQVlYR2o4WGlJNy9BYkNjcFhJNUhOWEczS05u?=
 =?utf-8?B?NFhjQXJESHlJSXlKYTBxa2JubTZBTnNja2lsZlE5NlUrclVseXJvVUxkb0NN?=
 =?utf-8?B?eFdtVEdiYnBqWXQ1YmtHcytoMlNIRmQ0T3Z2MEx5ZVlLc3dsUHdTYnVsa2pr?=
 =?utf-8?B?R0pOaFMwUFVoV0N4dXplVXRvQ2VkYWEyZUlzMDFKeW9MdnFKQUtlb2xqNkxo?=
 =?utf-8?B?M3hyNHZFdjBHS0hhOHQvSHZCaGFIRk1VbUNiVXJNMktjazVLT0c2Z2tYVTNz?=
 =?utf-8?B?SmM2TFBaMFFXWDNqMkF1Q04yRDB0VWppS0ZyY3BNeWx4bFpDd1l0Yi9OeE10?=
 =?utf-8?B?WVFmWEQ2Zi8wRk1aMVpmQUZva2k5eGVlbmo0RXZiNUJPQXVFWkcvMUxQQ0Nl?=
 =?utf-8?Q?HeimhAPwLohE5aDVZtUx1EevHk4fZRlYjKUnb?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d072b0d-0003-4096-8a08-08de83a36c03
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 21:31:44.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMx5abo+V4M96t11Jv74W9nkgNnyfvB4g/zd04QZp9wFryOdSlUug5JJLXU044mbk6Fh2FS5SVE8ZRKWm23rC3zFRGkU7WOAXzTsa0vku1gCNeLBcAZEiDygM6RsCweZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6606
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-18225-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+]
X-Rspamd-Queue-Id: 14E0B2A1028
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 10:27 AM, Leon Romanovsky wrote:
> On Wed, Mar 11, 2026 at 01:33:57PM -0400, Dennis Dalessandro wrote:
>> hfi1 driver is being replaced eventually with an hfi2 driver. Until that
>> happens rather than have all the duplicated code in header files, make hfi1
>> use hfi2 variants where it can. When compatibility breaks we'll keep a
>> separate hfi1 version.
>>
>> This is the case for the <dev>_status struture. The hfi1 varaint is single
>> port and uses a freezemsg char array while the new hfi2 chip provides
>> multiple ports and thus needs and array of ports.
>>
>> Likewise the tid info struct is expanded for hfi2 so we include both an
>> hfi1 and hfi2 vaiant.
>>
>> There is a naming conflict with the trace_hfi1_ctxt_info() call. It has been
>> renamed to remove the 1 from the function name to keep the code readable
>> but allow it to compile due to the #define in hfi1_ioctl.h.
>>
>> The big departure from hfi1 is that we are no longer supporting access from
>> users through a private character device. Instead we define two custom
>> verbs ojects. dv0/1, which proivdes methods for what in hfi1 are individual
>> IOCTLs. We have added an additional method to get stats related to page
>> pinning done by the driver.
>>
>> The reason we are not removing the hfi1_ioctl.h and hfi1_user.h header
>> files is user application compatibility. User apps depend on having these
>> files available. Once user apps have converted and hfi1 is removed these
>> files will be deleted as well.
> 
> What are the applications that use include/uapi/rdma/hfi/hfi1_* directly?
> I have hard time to find any application on github which includes them.
> 

rdma-core (submitted PR but have some checkpatch type stuff to fix that 
was missed), psm2, and libfabric (opx) all use these.

-Denny


