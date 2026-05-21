Return-Path: <linux-rdma+bounces-21093-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kj/BW/oDmqmDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21093-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:11:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE45A3C8D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E41D3050A59
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB61E3B2D0F;
	Thu, 21 May 2026 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nMIicF/Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9493A9DA5;
	Thu, 21 May 2026 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361162; cv=fail; b=h2Sx7sTtxdIicrOIpKPu8ODSaItvY5/YpIs/yNE54XoeYhYXIKG2DSk1dLQn/USNvdhcE+P3VUXSCPeHqWrOnAa7S45dPHZcudZe8BtwN7hwERGLUY1xsit/JXkder3400cAy9ftctVE8AtHXgY3fKA0oBIST8H36iXkcHU3w/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361162; c=relaxed/simple;
	bh=FlPPFSk1mJjkg3sJdPoQW9Yo7Z4xfWLZiV2MkGOE9yg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dKXzl+I/1zi5nhal0t9jx5Nwd/PCGjU9pqTJvfGXtZeCgpIZt8dIKanxs6OvjK00hYdZfBqNuEe8RwefMr9rliBmppPo6uR8K9OxJ9oBJzixWdEIwdUoPQ4k6kIwVf9DdrmQ3NYMEMx2bB/MG9OrtAftVd5AVusA4zZhSJo4bLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nMIicF/Y; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNEL/bFLM0ULKgHq181M2IKFv7E3udozWPx8qXc0oTzRd21+BqDRbeeXQX2InP5EA7Hb6/rHXxv9uTtEWlbCIEsY7MA/3OVKTLjnCN8npLo+sX+kJy+01KDrg2DqOgvkt24Sb6uxJOi4QE6rV3PJB7kJsgcBdT0xKUbyxSfyjbc44sKzb3v/Gtf7booWOD8Dj8g+7ODuzFR+kg5acaoCtcM1o90h5IHahYmkPMXZk4FWIuKzZjqzLznUUnF11wbsV3RPpuXnAmLHWteHp7V2aXR83cymCtT62+xsfWQY5qE27Uv3be6AtBy3vrQUjEjjE2QTxpg+33iUJqiqz4hYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Mz3Zh8ziovK7PQLLMawQZmH9qmjlzksU5+SAAU7uTQ=;
 b=FAkM3qtLKAkL1U5mpqtyHXsfTZ77pXunparraFyZfxlHWDEda2o0Vs81mVDyMnMbymFAttIUWlI6IBDY85oDsuKteAoraeeZZZy6iFT3k8roryDRjoVn3JbZ5JoKUrj83zGmdFNCed0xSiydjR64EGC8I7tuXcXvNcPRZOoDt6foSfsqzh70ojp4T9+0dqtbJj5qz3LrksuWZEKQdzzYhzyq8rpu7QvJv/rr4iVhSUQd+FkS2s3atg/hF5Maj88k3Yj+c7NEKA6eMAzQYZWytrBzJ+2unGyqqLU9ZY6fQ8KO2F6drdEwns6AZszAfwkjcTw3GJvSKj5J1Bjnfx8pNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Mz3Zh8ziovK7PQLLMawQZmH9qmjlzksU5+SAAU7uTQ=;
 b=nMIicF/Y0yZEf79kjSX1pO1Sdp9xRmQjgCDPDI6DDfTOd6rh49aC47fsgcahdPZfu16hQa2rMBUbU80/3uaWaSIQlva2M9wGghyoUcu6+mFYEd7NCKI7eqIDHhqIdG+9GBrpP2FsYsuNra9l+OmIwEVUMVa4aVMqy1yfCUpemPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 10:59:16 +0000
Received: from DM6PR12MB2860.namprd12.prod.outlook.com
 ([fe80::b2e7:252a:a896:8a19]) by DM6PR12MB2860.namprd12.prod.outlook.com
 ([fe80::b2e7:252a:a896:8a19%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 10:59:16 +0000
Message-ID: <4c3aafd7-128b-a32d-d1b7-53372d530c24@amd.com>
Date: Thu, 21 May 2026 16:29:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/3] RDMA/ionic: Support QP transport mode selection in
 create and modify
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
 <20260430123931.3256130-4-abhijit.gangurde@amd.com>
 <20260511125028.GJ15586@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20260511125028.GJ15586@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::13) To BYAPR12MB2855.namprd12.prod.outlook.com
 (2603:10b6:a03:12c::24)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 286e6405-ba54-4bbb-65f1-08deb727ff5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	XhyEJaGpZ4oP6t22MTpT7gznfAvSpMthIX0tiou0U0FIwNjU2XgijPOubvFT6hWrsavliJXen6LpOOMJ50WLhTtED5oELOHy3Xd9pl3DcnDWNhdhBHj3VPNjTT4ut2H9RnTxz+cWEJX7VmP2XfAmpDiV3UAGC3MR2od+HLrQeM+Kg3qfZoKrgNIA8hEPF0Vfmof5lQdKg2eVaRwqV7US1H1K8Phb26JKtpZrlTbhGC4zs78fpt6AJ+i4/1JISp1sFBFo6nt508Lh8dkzFZULc8kYIJKrJ/DshyHbHrRiSbxys3o2u0lF6YR3RFItlPLJrS05OGNI96DiN1CHK4+du1zrvxTSDP+9kReuLT670vgwkGzgR1aPyiFvf5pn0qNSN06pzJxUjSohoyWI57D7JxT+9FfWL3zKdwhbBjfPRXtPWXJXo7GKTfm1R0T3ubPbouVFpDuN0NsN7yJATvhiS9YwIzsDn3koUUmLVEj/eHaT/DhC8QtATJ8s+bSYRVuWfYegcGYz6AmnfeBTWbC2v2DQ2qpjOxdfZ06x3JmZAbfJRPbWZh3FHv5NDwmkbMPgR5eieMhhnksush6p2sBJJeOU68Pbaflq3vQfWn0Uc+z9c9pP0K+d2dxHoaq7NlYMalh2vx1/rSsi5d9+BMhW2HkpHFmlUKUdiJIGpbwIu/YGjimlfEqVfopo3We0Tf0F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2860.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHBSVm9DNk94eXVKc2JBbFJvbDRlNFUxNzJoOEs0UTl5V3QwTkxUYm81bDFy?=
 =?utf-8?B?UHFLT05zdnlGTWNBdU1Dd051UmFnUENYdHVUbjBud1NPVDdjejBlSm1mVmln?=
 =?utf-8?B?aVdySjFWSkY4K0ZzRjFFeUdGTSsyTkJWQmc1dVc3Y0U5c2U2ZGIvYThSMlFx?=
 =?utf-8?B?L0oxeURCV3BpeERtaWQzMWpBOTRGbnJaS2JvRFNwNjdlMG1WMHRoMnA2ZXFN?=
 =?utf-8?B?YTFHQ1ZNaE9JdDZKTUFyVFE2UVlTTm5MaGNMazR4dWdMbjAzakgwdlpUb1Ft?=
 =?utf-8?B?VCtpa0hXbEtUcU5nTkhMeVUvRmdYODFSL3JkdzZJSTNXek5KaWs5Rkx5MjhO?=
 =?utf-8?B?aVpjNHhiSXRjWW1UUWcvL2JqZ2dzeUJXaVdtSytMK3BxaTY3aE9nOW9iRXUy?=
 =?utf-8?B?a210cHBldGVaYWN0eW5HNzRuL3JHNjVBS2hFMHpwVEVsVDUyandhUjF0bzc2?=
 =?utf-8?B?QzZGdEwyaUd3K3ZKWHBBdTdHSEt4NVcwZ2pSZjRjelRzSzdrWkdibDFBUnFo?=
 =?utf-8?B?elQvalVZcTJ4QS9nWUY3dE9QQ2ZwTkk5dWxOZ0l0ZERaTjNvbTllUXVrNVVk?=
 =?utf-8?B?UnVhY20vV1Q0Nk5lY1hYUURDZEJjSzJ0MFplWVA4dGhnUUhVVVptaGgyRE5T?=
 =?utf-8?B?dHFvTzY3MWh1NmdFZ29PcWJVcDlUOGFjQ0RzOGF5VGM0NHNMUXpya2QzV2Ns?=
 =?utf-8?B?VjdRL25vNHJrV21VT2lxSWEwNnJwYXFpV0hOTUNScGp3cXI2Z2tvaWpoenIy?=
 =?utf-8?B?UnZ2aS9KTUhVZi9RSzR6QW5DbkdzREVHTks5WFRzMjRZcHVKa1plcTFVVEFm?=
 =?utf-8?B?dlRKTVUwQUN4MVdwZWJRWlJPNndsZzIxL0hLTzA0NE1FeVUrNVN3V3Z3WlRN?=
 =?utf-8?B?UERUOTFEMkJnbGlGUHNOZlg5WU9JSldROEdlenZPbFZPd3gvLy9scjlHOHpm?=
 =?utf-8?B?clRranROUUtrb05ydHY0M01jU0piQlEzR2hpbTNVak10ZjRaQVZFZ1lqeW0y?=
 =?utf-8?B?QW1MWkNNSGVzRDVIK2ZnQXJpalJCQm9DVVJiTHU4RW53TXJhaFVvMkN3d29B?=
 =?utf-8?B?T1RrQ1JQTC9wYTg4R3RGSjR4V1JNRW5haGw4cVU5RXpRL2dpd1podzBtdDVq?=
 =?utf-8?B?MnpndVFxOWs2Qm50djd1bThBUkZzc1BZSHFRbkZwaWRPY3hYODcvWmpLM1M2?=
 =?utf-8?B?MktNY3FaaysxeWplNFJXTmFYOW5mWjJYb25sNkpTTittd1k1elQxQlJqeGtM?=
 =?utf-8?B?TTg5ZHpzdHpBVWtQUTZzUkpoSUc5SlR2UFJMUHJ3c1ZLanAvT1JIODhzcHVH?=
 =?utf-8?B?YnQwZmlKVXVSeHJ6alUrMmdwazdZTE1ETlZsdTF4ZmhPNXBnWXUrMmN2dS90?=
 =?utf-8?B?cmdEUXdDTUhISmpoSk5pSXIrYmU2TEhzODJ4WUhZRjdQTWFBQUw5L0dZNFMw?=
 =?utf-8?B?Y1hLU2poOG12eTJ6QVRQSTlYK00rZjNyQzdqTyt3VGFwWW5YSytjcTd5Sldk?=
 =?utf-8?B?MlZ6RTVIQVJhR0VacmJabVhVYm5zUWNhN3NSMWc3aTczY3I3WWFIQTFybHl4?=
 =?utf-8?B?T0tTRDUzbTQvU0poakRFWTd4S0FvN1BmVzRCSWVpT0hlenFYaWRlM1hHTWVG?=
 =?utf-8?B?VlNkK2E5MmU2c1pjMWdhMEYyQ2xtd1lnczlJcE5RdThBdC9vaUxscEg4WVI3?=
 =?utf-8?B?TDI5aUlVeWNMcDNXU3RxUktyYUV3TzJlYkd4eTF0NVk0SG5lTFpJSlJEVHVs?=
 =?utf-8?B?LzRwSUNaaEI5L3lvTkV3SnVrY2VsTlQ4Wnc0bzR1Wm0wWm5DUnU3V1ExUnNq?=
 =?utf-8?B?cmFRRHJUQU9vaGllQlBGZUlMMVBjOWJ0K29kczJxNFhqYzgvanlsK05kOG9F?=
 =?utf-8?B?RDQ0TjJYdTE3RXVTNkw5SGhPTFNtOVdwbGxlSkJLci9ya2l4b01aSFUwemwv?=
 =?utf-8?B?WlU3b2FYVGV2QktpZkpGK0JQUHh0bkI5V0piNXZvWEhic0VrczJwNUZ0TDlZ?=
 =?utf-8?B?VnZrM1VmdVJkTFhacU1GaGVOQmlwMVJaT1dTWlNpQVR2SkY1ajlnbmFLMTQx?=
 =?utf-8?B?djBjRnJKa0NxaEp4UG1iV3NlZ2RoTlVSSXFldTBpcktrZ0lDaWxuOE1nVmVv?=
 =?utf-8?B?QkNNMUlyS1ZKdWlIdk9EdDBNM3QrSDMxa2pkSm1VdmVkYkcxajRHUWpDMEZK?=
 =?utf-8?B?U25EWk1nUEh5d3F0REdGWG9SaDI3TWdYMjk5Q0RXSXV5ZlQ4R3RDYkV3clZT?=
 =?utf-8?B?YzgveFpQNW5ac3BQaURlajh4MDNYR042WjI0TVErWURkM1dEd1IvN2dTV0FU?=
 =?utf-8?B?aFJMSTVZaDBrT1FBbDd2QmpyNXhqMm1nbDgvTGpaNExkRVFrZW5ZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286e6405-ba54-4bbb-65f1-08deb727ff5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2855.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 10:59:16.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KZoaddWGfu4Nif135QYU9Xek2jTaCamdgQefIq/5PAprz8P3Ud9ZctYizagkqCP1fLvdDmyRkrvwoVJx+BIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21093-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 6FEE45A3C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/11/26 18:20, Leon Romanovsky wrote:
> On Thu, Apr 30, 2026 at 06:09:31PM +0530, Abhijit Gangurde wrote:
>> Allow userspace to specify the QP transport mode and number of
>> reorder completion queue paths during QP creation and modification.
>>
>> Extend ionic_qp_req with transport_mode, num_rcq_paths, and
>> ionic_flags fields. The transport mode selects the firmware QP type,
>> ionic_flags are forwarded in the upper bits of priv_flags during
>> QP creation, and num_rcq_paths is passed to firmware during QP
>> modify.
>>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>>   .../infiniband/hw/ionic/ionic_controlpath.c    | 16 +++++++++++-----
>>   drivers/infiniband/hw/ionic/ionic_fw.h         | 18 +++++++++++++++---
>>   drivers/infiniband/hw/ionic/ionic_ibdev.h      |  1 +
>>   include/uapi/rdma/ionic-abi.h                  |  5 ++++-
>>   4 files changed, 31 insertions(+), 9 deletions(-)
> <...>
>
>> +enum ionic_qp_transport_mode {
>> +	IONIC_QPT_TRANSPORT_ROCE_V2 = BIT(0),
>> +	IONIC_QPT_TRANSPORT_MRC = BIT(1),
>> +};
>> +
>>   /* admin queue qp type */
>>   enum ionic_qp_type {
>>   	IONIC_QPT_RC,
>> @@ -228,16 +235,21 @@ enum ionic_qp_type {
>>   	IONIC_QPT_XRC_INI,
>>   	IONIC_QPT_XRC_TGT,
>>   	IONIC_QPT_XRC_SRQ,
>> +	IONIC_QPT_MRC,
>>   };
>>   
>> -static inline int to_ionic_qp_type(enum ib_qp_type type)
>> +static inline int to_ionic_qp_type(enum ib_qp_type type,
>> +				   enum ionic_qp_transport_mode tm)
>>   {
>>   	switch (type) {
>>   	case IB_QPT_GSI:
>>   	case IB_QPT_UD:
>>   		return IONIC_QPT_UD;
>>   	case IB_QPT_RC:
>> -		return IONIC_QPT_RC;
>> +		if (tm == IONIC_QPT_TRANSPORT_MRC)
>> +			return IONIC_QPT_MRC;
>> +		else
>> +			return IONIC_QPT_RC;
> We have historically treated vendor-specific QP types as special cases and
> routed them through IB_QPT_DRIVER.
>
> IB_QPT_RC represents a standard RC QP and is expected to follow the
> specification.
>
> Thanks

Thank you for the feedback.

I agree that IB_QPT_RC should represent a standard RC QP and follow the 
specification. The reorder completion queue in our firmware is 
essentially an extension of the RC transport -- it follows the same 
state machine and connection semantics as RC.

Instead of distinguishing it as a separate QP type at the IB level, I 
can rework this so that the QP is created as a regular IB_QPT_RC and the 
use of a reorder completion queue with the given QP is conveyed to the 
firmware as a flag in the create QP command. This way, the IB core 
continues to treat it as a standard RC QP, and all the existing state 
machine validation and DMAC resolution in the core path work as expected 
without any special casing.

Thanks

