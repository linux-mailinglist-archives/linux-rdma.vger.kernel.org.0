Return-Path: <linux-rdma+bounces-22604-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UBWEIdPrQ2pjlgoAu9opvQ
	(envelope-from <linux-rdma+bounces-22604-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 18:16:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1836E657C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 18:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b="MQs3/uSb";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22604-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22604-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30CC2300AD7D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC8477993;
	Tue, 30 Jun 2026 16:15:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021139.outbound.protection.outlook.com [40.107.208.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024DE477998
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 16:15:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836146; cv=fail; b=n9B0CKMLSFkZeBr3TjARyTLWsMmvVm7N5ztZDPA++UmzXx2MELNK/Xjjz7HmvbON0xuqRpsx2hAjqxDqdDNiJcZHJAjSDCnKMwQGrzNk44rPunyVNpmRNLKbqBcLezatgKxtW+h9Jmct9C7pYQ8ki9hmyi9s6q1qiX+qTm/dfxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836146; c=relaxed/simple;
	bh=1O3fCTswERpigOKJXoFHePAVtJ452Fc0BxyP0ziUfqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAAd+oDibKiAnMxaPc122D0QczqrczaMHsH6gj7h4Xd8YcKE3UT1drM02uT2hHzRMfacJXJ8+Po6znfjEu0CdEdPhViZlFjFbGgKNMrWQC7fugz2JHGdA1L9xIM5UyGE2Nql34SqF3Go9oMtFjVST314PHtqraCrJhJmIAJAP4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=MQs3/uSb; arc=fail smtp.client-ip=40.107.208.139
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G14WSNp730gVRi5Ijh7CjRAcbuNisDjlo7Re188EPkdKh7NgSa3nSfYqCFHwSg/pdpW+yr1yN0kWFmANzJ/cYXqKR8MWBLmdoIHhF7SNf1MJjHMtB6DqHAqIl3U3M8TqQA1vcDG7u6oTJAHZrIUyQuHSIjMfUQf1lODga4BGmkOMnDtM8aObU0sf+R3pouzZExM1nGf7U6Gl62znWGeIg9cae+UaAZoUa4mRn9D3OtwVJ4z3IJcvREXfWSo9vzyHy+gSYK1yguQlAaGLpPZ8ScwXkAsqoOHXDwxix4YNpCI1N2K0tuA2GC29T3THB9GAs2e/dCA8p8Xyw4zSEk1zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efsrNrj08mch25uoVRJ7rOhpAs/iO02ljnkLB1bd82M=;
 b=VFn1vJ9eVYAf1wr9e+C+W2KuPYX16PQLtQUkMCftdH4kCESz9TTOiHdy1IYsT7rMV1bE3bXfusyvu6GNYB3XqzSW5lGIdQC9hJBZvz6neXKbeRl9MN61XnTIlvOGieghFj/euUXY6hg8CbEwmLGKvPN1xWgJ9+06Cs5UrtdQFw8ODD6lT1nHoaj8g0OWmWDanXrahQMbgWli5eI67BuNXZVCRO/nF2ndOreDOR/69K1ihHg9gqnXRHLbiaAIyX/pberXxVgnXL+vmuYn0bFyByZhLvnzM3bQWpl4NcnMlTK9WZ/GrxOJ3f/iYQFS35ZC1cLXJrGI26P6FGRGlNy0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efsrNrj08mch25uoVRJ7rOhpAs/iO02ljnkLB1bd82M=;
 b=MQs3/uSba4xez/jr942BJHGlJHqiojuHYnXedUbZpqk4tBG1ykVWk3hBGDrnLhfZmSw3XLcRLm8NA4pOGt7RCJXrpHB7IE5FJxEkd+c2Fcmeo8v73GkA89wKXxjO9F3aL/Erb0kTg8gg5Xwbp22g7Fcg4eNG1N9teVSOJVDXPZuc0PXXs6I34wHApqOKaUszkqEVv2pQYTD0PTW8b64A4ne33U81hL+V+PPkFOZ3Hn2Nj0zHreEYMmmVR/awXstuR2kYN/ltgy/B3QIpBdSYPn9inQbyh7S/2ChW8vMuiXmlPMe4OStsVmuxTCADFANsOVLf3dH7odgSgdam7WWgZg==
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 SA1PR01MB6783.prod.exchangelabs.com (2603:10b6:806:187::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.12; Tue, 30 Jun 2026 16:15:34 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.21.0159.012; Tue, 30 Jun 2026
 16:15:34 +0000
Message-ID: <f425cb1a-609c-4795-a3fc-e874b15f0f7e@cornelisnetworks.com>
Date: Tue, 30 Jun 2026 12:15:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-next 00/24] Migrate to hfi2 driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Douglas Miller <doug.miller@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
 <20260629175847.GA7525@ziepe.ca>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260629175847.GA7525@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::17) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|SA1PR01MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1f2488-f7b9-4d67-b24c-08ded6c2d068
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|55112099003|6133799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	MS5zzM+7MmLSoQtIgujEQXzy8DkLNcmBjE/8rXSoDiP/tfD9seh0u8lDSte9/tOxPSCR1UTb1bIc7R5pknDSfMPN8CNAZGKNXHYkw5F8oRTvgQQ+IAl92DUkxFAW80R+l0+L1/A9/uW9z7g8n2vRLq5yRV04OBnyNmqZSKy0Z2VvTgCeF24fK8Y5k6z+Ub5rVWRF/YVwf+rZAbW+wdOLXT2U0xmLoqYjXzGU0znIgidkBVVdROzacecGTJ6lawfQcD+TR7Fm+pWDAxdH/GRWREmeehNS+DnuX6zrGzU8Pe9CkSokTQCFZEbEAJItqiHTnXucNvGGWnaCrbiviuNOvPYSKBSFpc07jfXNyBdxJgwcLqvY7McIlc2ZNgesd2bzDTcmoKEjSH0kctsxSVvzeT7ORDObVtO/XMC0krOmZ912QR9NgBUcunnDK/ePAor64cw+gXJXNr0fAC/TxPaRtSD8aMszKq8oTvLYt6JWIVzi70OvSGJqBf7Cp0DX2fuA1mtHPc0IpgXD13MEmVAINnOcZIcfM/O9q0fQ8e5tNFz/u9yovFhkaoclfzX2pWaent+oo+WjYkedGxBf03opZkQe5cZBRlNjtK6QaHS1pbE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(55112099003)(6133799003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDIxenFKOS9HRXBpWTBDU2tmRVlrd3BqL3EwaTVyVmlQQjFjbXJvVzdBT2VL?=
 =?utf-8?B?VE9HQjY5citFdnc4WFdzT3J5TjlnZndCdjNILzJsTFVOKzVUUkg1d0ppd0Rm?=
 =?utf-8?B?VXpERno1SUhjZ2Y3VERwR25oTmNQWEdsMlV3V0tMbFNTM081anQ3TVdVeHlm?=
 =?utf-8?B?djgvZk1reVREczU0NGVjMXZFRjczS3U5d3prOUFFamRUTFVlazk0a3BPMC9v?=
 =?utf-8?B?SjNjWWZXbm1EaVlBSXRiU3pZNlU3Tml0Y3pkUnJhUDNmZlhqRGZYNk9DYVNq?=
 =?utf-8?B?SDBRWFZLb3dDVHE4WFk2TFZ3STJGR2xjT2w2alFBWVBZdlFEVW0rN1ZvVjRw?=
 =?utf-8?B?c25jZmpKdE5GWnYyNXFrOHIxUkdMS3hlaG53OXpwKzVzSlZ6c00vSS9FNGQ1?=
 =?utf-8?B?S3lpeHgxdy9uZjNXeWZKbk9aNTRtYVVPbllveW1TcHFhOS8wU1FRc21SK0Rh?=
 =?utf-8?B?VkJjN1V0b2NlK0RSbERFOHY3a3ZYd2FpUm5RYnRzb20vaVZGZ1gvRHJPWExL?=
 =?utf-8?B?VWtuUm5sSExpNDk5SUpGZnpGOFpsK21jaytrallidDBjR0FmR2N0MkRCOE91?=
 =?utf-8?B?WXdjckZBWVM4ZXk0WHNYRGI2R2F6TGVtSElPNEpiQ2l4L2toUTlRT01CMUdU?=
 =?utf-8?B?dHlxRitmV21PR0tFaXhoTzN1TGh1eHZPRFlXVHBibXJhZkt6am5pYys4Q0xn?=
 =?utf-8?B?RmFQS0NOUzJmZ1BRTDBKYjZWWnJTSS8wL2c3SWppT0VZTW1kMHFKa0xjaGxE?=
 =?utf-8?B?bytYN3hOcUVpOW5HTkJPa3NpZzVkMzVZQUJVSVkvWUJYd2xhNmNJZHNtbjM1?=
 =?utf-8?B?N3NDM0VqeklRZHFha0RhQjB0a0ZBeGxWL0w3azV0UUhsV256ekd0Z1FyN0sw?=
 =?utf-8?B?bEpWSGRLR1g5OENxOEdvR2lacS8wcFVqUWFRSmRwUXZvZUxTcE1uOVFHYUZl?=
 =?utf-8?B?Z0Rsdmpwd1M1Wjc4NjZhSFFIU1RQdjVickd5MUxFVWMyRzVQejF2SERsMGd3?=
 =?utf-8?B?Vm9uS1VkVVNjcmw4UkRBY0hSczkyWlJXRmZOSnBhcFh1YlRtQUpTckxlNFNw?=
 =?utf-8?B?R0padG9RL0tRdVFwY1RiTXpXVVFQNUlNZjJtWGZmbTVHSyszWjUzWmJVMWts?=
 =?utf-8?B?OVVlNjVrcndZNmlhMVRESm9SMCtMMXZkYmRxWTJlWTdnVER1MVpsVmUyckhJ?=
 =?utf-8?B?Z1RWak1IT1J1bVJWOGVUNUpWMDRjYTZzbjZXYktVU21XQnhSZFYzUW5uTFZS?=
 =?utf-8?B?OXFLeVMra0FnR0hSNkdyWW93VVNiK0JjTVB0Vk8xRW81ZDdnem96ZEYxbStI?=
 =?utf-8?B?RThPeUJwRWMwNzdWMlk3ZnNXMGt6QUNTTWpWcmdvdFVwcEF1akxrekg1cW4z?=
 =?utf-8?B?NnRPY2RPYldsdUZ6YXk4bEtCcUYyTkZuc25VRzVPTld2L0ozOXluZVg4TEFD?=
 =?utf-8?B?dGlSSUpnQnVQY1B2YmhwOE4vR0ZqNXdtajhsLzlrYjlzYUFJTGVQV0NiWEpn?=
 =?utf-8?B?MTdHRm1uL3JQNG8rQ20vaURlYm1hQTh1cTFNSWxQdjE2SE5QMzN2SWtHbC9Z?=
 =?utf-8?B?bkNaamYyeEwwQ2lpbWJtL1p6UzNxWGczTTR3aUxqdVZuanJYZmUxNlpSampJ?=
 =?utf-8?B?ajRyUHBJZFhOWjRuYWtGWVJ5SmdBV1YvNWExd241Smd0N3hjNlVTdkNwRlZS?=
 =?utf-8?B?eGNxOHQ5QXhVZVZVWkJkVzdrRTVCajltZC8zSDJHdHhMUitJZ0QxYTBoakUz?=
 =?utf-8?B?T2JMM29hZ3FteFdPZVhsOFYxVC9wQ25yVnhTT3BIQ3ozdkFPUzN4cGZLK1k5?=
 =?utf-8?B?K20zSjl4Y0h4T1BBTjNTRUtHS0IydHNNK0Vja0M3aWI5eVI5aFk4RUtQTTVm?=
 =?utf-8?B?VFJSR1ZMMlNQWWVmWS9YNGN4OFFQVWJwcllRZFhmamRBcmk5MUNyYkZXZGZL?=
 =?utf-8?B?a3lhV1Noc0hPdkpQcytQcjBIMUMvQXJMNG5NWEJyR3NLckpHK01jNFhKVXVz?=
 =?utf-8?B?WmdZMllvS3Rpc1hXSWRtbUZTbmx2SEI2cUpyNzNjTDRiay91ZmthM1dNQjFP?=
 =?utf-8?B?d0xkcFI5Y0JYVzc5aXo1ekVXT210VTFBSmc4NXNZNVdmNks0NkkvQXpWcGd6?=
 =?utf-8?B?TjZVbGhSMW1IQlpIMEVmbEFHUzdudVRkRGUvd1hkV2llaVFnWmdtV2FxL3V6?=
 =?utf-8?B?bExLVml4N1BkUVBIaTZWY2tXQXJUSnNmR21LcmQ5R3hjU0tSdTcwd2c1UGUz?=
 =?utf-8?B?ZWs5WUd5R09FNnVEMkNOYXFicHhxMDFZcVBkSmI3L3c1QllleWJJZjhxME9C?=
 =?utf-8?B?ekFkNmZRRDZsejJQODNCSjFHeEJ2TFZhQ1RtV2gxYUJHL0M1QW0zbXNFQVZv?=
 =?utf-8?Q?FSl3uxscnPubyUvb++y4RA7hfbGk9Yo/jlyQY?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1f2488-f7b9-4d67-b24c-08ded6c2d068
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:15:34.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVJvI7M79fh9lUzNa3ekI/zQZkvJbyxEJ9QLDgW84iFO3t9ZdHdJTUVui3xYduTdMLsRbFp+ujkPz7OSLwHI3PUQ3w48el9K/IIg87N6pC8L4dzA5TVpRIHLWibyvyLO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6783
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22604-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:arnd@arndb.de,m:doug.miller@cornelisnetworks.com,m:brendan.cunningham@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D1836E657C

On 6/29/26 1:58 PM, Jason Gunthorpe wrote:
> On Sat, Jun 27, 2026 at 12:24:54PM -0400, Dennis Dalessandro wrote:
>> While sharing similar bones, the chip for the Cornelis Networks next
>> generation fabric technology has some fundamental differences that
>> resulted in a near complete re-write of the driver. It also does not
>> use the private cdev interface that the hfi1 driver exposes. After
>> discussing this with the RDMA maintainers we have decided to go with
>> the approach of moving to a new driver and declaring hfi1 obsolete.
>>
>> It is desirable to keep hfi1 around temporarily to let user APIs
>> catch up to support access through the uverbs device rather than the
>> private hfi1 cdev.
>>
>> This driver is designed to support future products as well.
>>
>> This series applies on top of the rdma/for-next branch.
>>
>> This series will be followed up to pick up any remaining changes from
>> hfi1 that were not yet incorporated in our internal development tree.
>>
>> Changelogs in individual patches but the highligths are as follows…
> 
> You are going to have to go through a fix the relavent sashiko
> things. There sure are alot :\
> 
> https://sashiko.dev/#/patchset/178257721001.371918.6610421101075283586.stgit%40awdrv-04
Working on that.

-Denny

