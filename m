Return-Path: <linux-rdma+bounces-19208-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AeOKSD42GmGkQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19208-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 15:16:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3EE3D808A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 15:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A644930387D1
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB452344DB4;
	Fri, 10 Apr 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H4kB73IN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701062C15B0;
	Fri, 10 Apr 2026 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826615; cv=fail; b=bpFiZ64jJqoF1E17LadiiWI6tQK27wcg70ilCToGHMELcrmXB8rsb0eFKk/GwtL1AolOXqCPaV715mRtxMGwOpbaVx7afF/+gr096Wy7NChD0gyF09pxmrLBVApSUK5+23loyKc1i/f7HPil9EDBnKfMHmmMcO788hfncjwMEbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826615; c=relaxed/simple;
	bh=z2Zkz6JhRFijrPs3jXS+Pd7AW9aAYLviKlAyb3KJbiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LxRWVUCrydldxBZEMinCDckFbkRcFTPzJAr5UCZqanNEgr5lkUq4kSnfPU4VFRFL31X6IizneytIz6Ac/0YJhmbTt5i8KphIvKlIgoiHK5II89YzBXXIQEH1/pSqRafYNWdM5xp68pc1ipxtF8gadzMNDB5kL2Og1B+lFBygWU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H4kB73IN; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnrbKJ8/aTzRUTuCA36y+wS9vLdITjjKWC9QKCf7Is8tDM9GVlMj+3GzxAvTlqGGvVLwq6Rx4stalmaM+wSQ4BZmSoUaiu8kIMm9S4e1EOYfBBO69gCimlvlSli9AZwIcXL0jYqWKdZyKDID6CVKYg01ya3aMhNknKQ9UgSp1UHZjvwxRovwbNYN6n9rZCwlJmq7EMjPsy1vfF1cYyjHrWsEOsPpq6ffJ7tIEaxYrEzQYTJxHo6QUFdJB8VOnRYBfa2S3QkTrObmTgLdWKnzn1WtaEnumwC1NiTPTKnoNHKI7mtPP2jglgGRQgnCmhFJBbDiUZA3MP/KSqSZiyL3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMWOTXUZ9U8D5zmD0Be70qmD5GoQWCfD3Y9GggFp7EA=;
 b=i5IqlWNfd0aNJO3yeMk7atxh3ect8nRB+EH8dIbN295YpVOze+8KwgqT3AiUC3i6dwfyI6jERwThii1arxOnr9y9D4yNJHSpo8bcZdzzSKoetgfC+GBXna3PsvyxHEFGZ4XFaiBaD/IKVeIK7ukms90I39bYxwSlmM7JVsiFQWgHHQtvEk2/vciBjrvNM5fNfebC0I044+F18/NP8b7mk1ZxUI786oJfCp72Qv/T7bQ4WUarMu/oa9/O+M1BnDaippXvVY/Xiz9vmc7Y/3JAx+KHDE2h944x2tj38JigZbcQrO94TE32oLVT1bH9Cdds9L+v3sOCyPSDzxpLE8uavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMWOTXUZ9U8D5zmD0Be70qmD5GoQWCfD3Y9GggFp7EA=;
 b=H4kB73INHkLajeilEx+7VW7GPphw5jSLiWijDqUGHzfvUGRuI34JB7PWUQ1SunEL5HGimOiMgoWpbWH1swJWJr6I5DpQYR+2iWjMFn7olkdo/F3xW5UBsmKXEv3YMgqD+5KmuzCpM1LpsW0MNAF0aNHPdbsywp+v82SoKze7K5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2797.namprd12.prod.outlook.com (2603:10b6:805:6e::22)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 13:10:12 +0000
Received: from SN6PR12MB2797.namprd12.prod.outlook.com
 ([fe80::1ef0:99a5:313e:a60b]) by SN6PR12MB2797.namprd12.prod.outlook.com
 ([fe80::1ef0:99a5:313e:a60b%7]) with mapi id 15.20.9769.014; Fri, 10 Apr 2026
 13:10:11 +0000
Message-ID: <52cee89f-50e2-4569-a622-b03e711ab26b@amd.com>
Date: Fri, 10 Apr 2026 09:10:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] net: ionic: Add PHC state page for user space access
To: Jakub Kicinski <kuba@kernel.org>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: jgg@ziepe.ca, leon@kernel.org, brett.creeley@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
 <20260401102501.3395305-3-abhijit.gangurde@amd.com>
 <20260401170600.312a23d1@kernel.org>
Content-Language: en-US
From: Allen Hubbe <allen.hubbe@amd.com>
In-Reply-To: <20260401170600.312a23d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:223::22) To SN6PR12MB2797.namprd12.prod.outlook.com
 (2603:10b6:805:6e::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2797:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: ba955f44-7448-4c26-b7d4-08de97027f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	y8f258NnnP1FruH22EnpWJgaC0TLe+dp6SL43PjeGpwa/AfAGS1c4KYa88CvmC47zK7036v7I0WGaUy52j2DmOiKxQxm9BD5d8TtQGmqrKE3iN3+mnTZqjUq/6b/0LQtaMepKAto5uNcptSZkpdKfLD+1ZfJjfrSybSGXLI9gYZEFelhKH1XRL2hZSLyevdaT28PGIkkySRCslSQdFXUuvHVOsXe0PzHRgA7ab/q2WyhucpMi1mc7Nf/ftf5W2gUrOjb1WCZ1RIpX1p2V+CG2MlLPc8MRiVyFcn5zPHWsXcoXMrfXXe/LZHChvpw6pNbfc/1pTgyw3ttulWXfQGQf2CcHuJYCPgKCp9G13bbdigik9eBt96m33+rd3lyX+A5DSsfqreWYcIyGpFytKDukGRYnZRN7Wk7M3c8mfUvfEsSfImSdrPwm5B84S8Jz7fKekg6ltqtcBvRTgvvhR8eglKsoWRXkslxdp2W0CZLDuIPBy8XRPJDEyYxLxmcvlC8TKLrObeqkcEgKhG05GVMga1w22+6o00/LHRpX77m1E90xjtll4u1yOmeEJKaZcvjQUEIvOQRXvSDSoE9UyFMQcdfn+7pHzNAVOJD5WmWUoisuwoKYdIQz3Uhrd+/2jBvicDKXbVU0OLv1NaRI3uiCs0MFXdw3eI28gwIhxr7NfKDweLPd1t+a9a8j4L47ScyZE9WloIS4SVwVoUi1DQAZpupc+p9S+h2+CX2qVuOhEo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2797.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVhdkQzWlB4eEI5SmNmQUR6TUZJbTAxOXFkSjM4b0kyU2tvUklzLzZtSXVQ?=
 =?utf-8?B?bFpQUTJscGpPYmkva1lVZWk0Y252ZWlVRGZCT0w3YkxJMnBsRGladS9JVG9r?=
 =?utf-8?B?WFZ4ZmNVUitOL3lyeTRjQjFNN0JET3prM3JSYnJUOHdGY3pqcTVmbmFGeUcx?=
 =?utf-8?B?RjlyT3VSaEdVT3Z6UFV0czlKQU9SOUl4NzBORGgxS3JtdEw0Mm9DZ0pJc0x6?=
 =?utf-8?B?cWV0ejVoUGNnQlJ6S0hWaVZlNTlBUERuUm1NSVJ4M0ZpMFRXQWRZN2k0bFpP?=
 =?utf-8?B?Z2R4dStlejBicG05WmVSaWhrVUxrMGxucTdtbkhyOGdtV1JVUDV3WWcxRUNx?=
 =?utf-8?B?UXJOa3dhQjF4aWdxQnVMVWtBNVBOK1hDdGpEendjSC91LzFyRjAyWDM4bDF1?=
 =?utf-8?B?cVZkYmdYK3Y0aWdwQ1E3R0dsL1B4aTYxZjdmaEhZME42SGs2cHZjcFAwUU1K?=
 =?utf-8?B?NCtCMitOOUFSTVhnbDZsOTI3cjBjZnhrR0NuMXIvOTJUQUh0NnpMNGR3QUpH?=
 =?utf-8?B?OXQya1M2d2pPOElRTU91ZDNrMjdDQW55Y1V4U1c2SzNrVXNobDk5bVZsK2hs?=
 =?utf-8?B?L2tPNlM2Nnc1T1QrcTRHWkpJQm1TL0FzS1dqaDJ3NEdzL2JUb3NiRTJjMDBM?=
 =?utf-8?B?bUhTYlJqZU0zRVBHc01mSklIZ0s0TFgwSENQZUNKdXowZGRvL3BLMGNTWXdn?=
 =?utf-8?B?RVVadHN1RWlxU2hTTlh6czE0dWxXV1Ywek0zMDVGaWp2cE13Tlc1MnIyajVQ?=
 =?utf-8?B?and6VHVqY3k4QlJ2N1dpQlFMNnNFRi9DSkNjQTVEa1pnejlqV3ZWTDZkajRY?=
 =?utf-8?B?QUxUWHdWdUdtNmpaL3JUb2RtK0x3dTQ3TndsTHJ5N0Fzc2g0QlpQWW56ZjRr?=
 =?utf-8?B?aVB0R0RZdG9TR0x6YnFaaWJjcUUrb2Jmdjg3TzRwZHJEL0JLTW4zQ2I5SktS?=
 =?utf-8?B?YTY4eGlqTEdNRzM3dTZnZmdIUXdaaDNNa2o0K3NJL3Fuc0ZGdkFmVnR0WHc2?=
 =?utf-8?B?RE9DM2diMWprWUxnOEE0U0tvWlp6djR5M3lFL2FYUmg0N0wxQk9jVmNYTG56?=
 =?utf-8?B?Z0w3TEt2ekZmVXNwVk1OSjdpOHhBNFBtd2w1allITTdyUWplbVU3eWdlRGNO?=
 =?utf-8?B?TUZlWm5YYSs1UFZMNjU5WTVGeDhWZ2Y2NGVHT3Bsa1dyUjc3RE9HZGpwNmY0?=
 =?utf-8?B?bW9qS1o2SmNITnFUS0NuYXNHc0krbXRDMFBERWpLQkNtTFhIdHl6N1ZxY2Fp?=
 =?utf-8?B?WjFsR2IxNnZlazcrOXhUWlphSzd2dXhoVDFMb3RWRzYxRi9QUzRhTkVSWEZU?=
 =?utf-8?B?MEhtdGk1MWdOSEJacFVwT3I5YTA3VjVSZ0JBQjY5WmdyT2dCRTh5ZG42a01K?=
 =?utf-8?B?RXVucC9BdW94TVAzYVMrZ3pydUxldkJOcVgrQnlabmhEWkZKZGxTQ0UrYnpK?=
 =?utf-8?B?VlRPcE5XUlp5V2FhOXkwaC9wNXBBVjBpRUwyNGxmZmxuTmUwTlE2aGZSOHFQ?=
 =?utf-8?B?TWExakYySUtlWmgzUzhhZGJIQUNHckcvNEFUbjd6Y2pxUElFelgzREl1NHhw?=
 =?utf-8?B?OVU2Tm4zUUFyNFZBZHpOd24vUGZFWndmdWZhWlYxdEFsWEF2bDMzUGdEUlZJ?=
 =?utf-8?B?VXNVL0VucmpJdmRudW5lQ2NZRDFibG1wYStjcElZWFp1Z0ZrSER1SWhaalpD?=
 =?utf-8?B?YWpvcUFEMmFqS2xBY0lvdDRzeFdyTGhpQy91QjdQc0pQMWNHL3lrL1A0WFFJ?=
 =?utf-8?B?a1VWR3JybEpsUFAvSXZYcE9tMnMvbDZEL0o5UEtYSWNCVmZXSFhtL0M5eDl4?=
 =?utf-8?B?b3NFNGpPWVhmMGhDUUtodCtIbERFTitQSlBETHMvTFFLZXkyeHBLaFJkbGxO?=
 =?utf-8?B?V2Zuc2o0MkRKWmI2Z1VZYVk4aWdRU3RIaXJCK3E0VXZzRk1GVEk1QUp1bEhw?=
 =?utf-8?B?endWNkpBczhMSnJWSlhJdU9JdDlibmo1ME8xUVo2Zm5ZNTRERVFmbThoeGdy?=
 =?utf-8?B?ME1POGhVcWkzeHlUcHhqOWQvKysrSXFXd1k4WHZ6QUJ2Q090QWZ1cm1KSmZo?=
 =?utf-8?B?ZTdlRGFJb1I1TGo1ZkZ1Ui9nSzc3K0UrQTdHZ1lXTWpPeXorcHpjTFFLbWNR?=
 =?utf-8?B?MktmQVVCRzJLSVF5NVBOV2ZmbmpTV3hYT2pVaU9xeXBrdi8xaFhuelVLdm8v?=
 =?utf-8?B?T0MyKzRCNkxLT1pWNkZPSXZkNnVHdVpac3drbHZ3bnVONy9LRVF6ZFlRYUNh?=
 =?utf-8?B?ZDZDTlI3T2Jrdjh4WElHMlN5OStwU3RrZnRDN3U1RUdRWFZMRmVaM253VHZR?=
 =?utf-8?Q?EWMLYwsil0imUd6yLt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba955f44-7448-4c26-b7d4-08de97027f6a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2797.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 13:10:11.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDRc2bTm5HIgi5hPsWkmW+hi8mCxIQ6WPTP4o2h9Zoca9zmD/YzCn7U/n0GXj548
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19208-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allen.hubbe@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0B3EE3D808A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/2026 8:06 PM, Jakub Kicinski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, 1 Apr 2026 15:54:59 +0530 Abhijit Gangurde wrote:
>> diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
>> index 7b589d3e9728..97f695510380 100644
>> --- a/include/uapi/rdma/ionic-abi.h
>> +++ b/include/uapi/rdma/ionic-abi.h
>> @@ -112,4 +112,15 @@ struct ionic_srq_resp {
>>        __aligned_u64 rq_cmb_offset;
>>   };
>>
>> +struct ionic_phc_state {
>> +     __u32 seq;
>> +     __u32 rsvd;
>> +     __aligned_u64 mask;
>> +     __aligned_u64 tick;
>> +     __aligned_u64 nsec;
>> +     __aligned_u64 frac;
>> +     __u32 mult;
>> +     __u32 shift;
>> +};
> 
> You're just exposing kernel timecounter internals.
> Why is this ionic uAPI and not something reusable by other drivers?

The simple answer is just following the same approach as an existing 
implementation.  See struct mlx5_ib_clock_info and 
mlx5_update_clock_info_page().

Making this common might risk presuming that other implementations will 
be a similar design.  Compare these to the sfc driver.  The clock is 
quite different from ionic and mlx5, not using timecounter, because 
instead of a free-running cycle counter the hardware itself provides an 
adjustable clock for timestamping.

