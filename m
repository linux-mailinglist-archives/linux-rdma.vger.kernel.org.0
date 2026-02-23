Return-Path: <linux-rdma+bounces-17054-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDjMGPNDnGk7CgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17054-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 13:11:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A84175EED
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 13:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE25305BAAC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85BC364EB7;
	Mon, 23 Feb 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WBFztR0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A935CB8C;
	Mon, 23 Feb 2026 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848478; cv=fail; b=djtO29unuffQA2P/lOLQmXhKydXyE33pyyBOWv+gz3/w4bhvCgZ1s9HTRzNHUt58lPJigPjgdnkdIp+d9b9ySeP2mAfY5Aq0WAXRn89a8sRLhxYfk0+sJKPA+kPKDMM6QRKzPI4EL0SDwMmvDcVl7l01Ip6Q+jusB39nru/IFhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848478; c=relaxed/simple;
	bh=//higwwKl1edAfwVU3hNQ3ydXfyHBmUDIsQq1mMlSsQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qUJQ35ZFLs2zV5oWOjQh9SM1XkgGrJlmejVI7hIGX4ILlguqqDZ99X6XpUZVdNtTOBuRIWm30gAirbvOk4QktjL9wqO5XdY29OOaYM6Ufmr04lhMrZTPuUA42xy03oInQKvQ8TQCnJ89gUtSZ3C/wGoLfFvkBUSWC6YXuWF2U1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WBFztR0x; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyDIGrjx4YilFq/ibBR6/pytWduLh7Jm4nSZQiapu1ubWXtfDD9ZbdkunrpQw95WjHHFjlXRiiK6nQljcyC9EmDTTVt8b+CNZJom5NtDjjpw8VqPP4Z50bVOCFJO/p/CiK0FSx+hNzwVLGfVWFtzx/kBz2ZxypKa399Ta+UY+/srnU0cFfdwgwurpbn9APhSQ7Gu4P2Mxht/dID5gYD1L8F47TMCAC/2DIiuckiH1dmzXr6XQGdE0BBcNisAsA6kAAHVWOs5VtFkpTzX0ETxD3WnKe+vY9XnnHNVx7rsx3pCSIT99uFtju7QqPwuRhEWQa7e5ETQ25zfG+xIDJrTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW1phrt9LazKc/W+sX7Yu5k9I9VcsBzq9oUaUgMTJdI=;
 b=ta+72x6kQaYJDLRe7cPDGC8z6xdkDP8HOneiKBZAmZFQNBL9GLGBo34VO8XotaBuEGHHPOD4mUApG8g9B3zyWpTPF7p5NKpsCPQVOQfTE27HrsdHrEdcPnb1hgkiR8Ug21FB3dEiLMV4oWGz8GKVXX8KKXE2z8o+GaCxBEklac2fLS7DlFEh2OSJBQb+XiOT8zg0DDHYG/uuiSmJ8KRCWz2oCKy/znHnD8r6fShOhdlQnAWvSALPG+aJYj8TQtC7DwgorF3jAUAszBoa50/jFRZMuaSrwpWFRIwvw7UtagG3rvmLc+7s5WSPDXC5OIa0ElDFErbdMv62o1qNRIt2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW1phrt9LazKc/W+sX7Yu5k9I9VcsBzq9oUaUgMTJdI=;
 b=WBFztR0xl65kEsJbVvSkZ2viDwV84xwyhHfbLZsk6s9o7MKQeTqQxCbeamTnCSZvLAp4u2AwMi+Efe6eYFUFUY/LBorvmvnQwtUDJ3UDnTpeRaXwGWK+3R2GdGNE1yOmXELwwYCFZTMTBmds9f3vQAAeErcpWpiMT34O9bqKZQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Mon, 23 Feb
 2026 12:07:54 +0000
Received: from DM6PR12MB2860.namprd12.prod.outlook.com
 ([fe80::b2e7:252a:a896:8a19]) by DM6PR12MB2860.namprd12.prod.outlook.com
 ([fe80::b2e7:252a:a896:8a19%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 12:07:54 +0000
Message-ID: <abdf4f89-90a7-84c7-af7c-f070073b399d@amd.com>
Date: Mon, 23 Feb 2026 17:37:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH rc 4/4] RDMA/ionic: Fix kernel stack leak in
 ionic_create_cq()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Allen Hubbe <allen.hubbe@amd.com>, Andrew Boyer <andrew.boyer@amd.com>,
 Gal Pressman <galpress@amazon.com>, Mustafa Ismail
 <mustafa.ismail@intel.com>, patches@lists.linux.dev,
 Roland Dreier <rolandd@cisco.com>, Shiraz Saleem <shiraz.saleem@intel.com>,
 stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
 Gal Pressman <gal.pressman@linux.dev>,
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 Michael Margolin <mrgolin@amazon.com>, Yossi Leybovich <sleybo@amazon.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
References: <4-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <4-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::6) To DM6PR12MB2860.namprd12.prod.outlook.com
 (2603:10b6:5:186::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c11a17-823b-4a5d-c50e-08de72d42c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlNVb2FWd0xlMHZXMmVleHF3K0ZuMnovaGQ5WnEzSEVUSm1GTlc5WElTNVB1?=
 =?utf-8?B?VTIxVnh2OU9McXN2ZWhPSjltcDhHeUgvdXF3S1Z0VFpibWxTT1crOWhSZy9X?=
 =?utf-8?B?TlY5ZGQvZ3l2ZitKcmZENCs3QUxHazVIOEFFVXg1eXRFRVhpMFpIUnlxNWwr?=
 =?utf-8?B?aUlmckZ3VlMwN3BUTG0vMWZjQWhXbnNlL2Zmd05xKzF3OGI4bTBvYXNpL05a?=
 =?utf-8?B?YklDNjNKT2RYNG5jVGFUUVRaU1NLNUl1QU5xaWswb3g1ZWhLM2Zua0dKbmlE?=
 =?utf-8?B?NkNhMnpYQmxqNHllRUYvWi9nMmgxb2lXQjZ6Tit1N2s1WHB0UVhadURpV2Jy?=
 =?utf-8?B?WmRxQTJZL2JpU3g1NmJJbTFqL1NSdXdITnZ5WmxUNUtZUm9lNG9FK2w4aGM1?=
 =?utf-8?B?eWVtZE9mdUJYWlYwREhUMnVaQ1pPZGpDc29laVA0SGV4VTlBZTVaSkxTR2xG?=
 =?utf-8?B?eEFicHJjZ1dCSk02MmplK3R5V0Q5RDRMSmt5U3hMdEVqbUtvdFJ4YlBYZXpu?=
 =?utf-8?B?cmNsazk0YUFKZUdOMnNTSzVjMGZVTnZUVHA3YjNmb2hPZGJ3V01ZaHFvbGhL?=
 =?utf-8?B?YWdMRzJJOVJ6UW4yYUpNb2Y4eUJMdmpQYXhpbnIwZWFWQmdPemRISXpaR1BP?=
 =?utf-8?B?ZkR0Y293cEk0cEJmaFJRRUpqdE05ZWhSVkl2UlRNampmcGQ5NE9lNjhqZVgw?=
 =?utf-8?B?amhEKythYUFacWpFSmJPK1k0WksxbFNZcUhOOUJnUzJRbEVGUnhsYkVHaUY5?=
 =?utf-8?B?VVFKVnAvUlFWUU00bG1ETWg2cWFFWUxZSmsrdkpUZjNxRm5RZ3N1K09xVmxl?=
 =?utf-8?B?amhidXRIQU85cDluenZ0TzNYeVVkUDZqQzFiaEdhNC9yaTBWeEQ2bXQyYWsy?=
 =?utf-8?B?OFhjL0pyekNkY1VGem5Ud28wemxmTTJjcUo1ZkpMa0lwV0gzREo4cEFaT0Yw?=
 =?utf-8?B?cHlKdVRGUFBDKzFKY25FUHMvaVVMRFZXVXVRa3RuK1BkWFU1Y0ZiVEV6Yk9t?=
 =?utf-8?B?cHhyMFgzWFF1d1dsWVUxUGt2SVlYT3NzOHVkTTlGMmx3ZUFVb2VBTit3WU4y?=
 =?utf-8?B?cEZ6ZW9rc3Nhemc2eXFvZkw2VW9STjVTa2kwbmZDeWVqVkUvTWVHODNOOG5s?=
 =?utf-8?B?MDZtLy9OQXBycldvS0VWNURxcG85WVp1Z3FZaTRHNXpidkJRMFdMZE5PRHpP?=
 =?utf-8?B?RmNBRUlTa0wyU0JYbkduaGE4cFM0NjV4NmNPVlpKeWlnc1BPakNuWjBqNjVH?=
 =?utf-8?B?M205TkxvbkZycERuQSt4WTRvM2lNV1pIQU1iSnl1NUlJbnBuaGdDYUs1cHdN?=
 =?utf-8?B?VWtmSTFBdlZNRkg5N3pITXJBMk1MbjBOU3NxVHdaSnZNYVBFS2dhOXVrVHhP?=
 =?utf-8?B?TXVXZHl1VGZsVXo0ZkN1WGNpRXlCVnJOREZETnM1c2JwT2sxdUZ2SW5QUzUw?=
 =?utf-8?B?NkRKb0tBeXA1anpyblJOM3lDaThQYUFEdlRiM0dUZlhQWGptUkQwU2NaSU1t?=
 =?utf-8?B?R0E5VlJmZ3MvTmxFR1c0aURDTFFqUk5RQU1ycEcvcFE3V3puSUdadU5xbXNw?=
 =?utf-8?B?a2U2QWhKYXQwQURSTDNPcUdrWnRwd1ptYXVqOUFVMDloWlYweThJTmNOVGZk?=
 =?utf-8?B?allaallnaXpZZDB3R2RNZmpNajBQMjc4dGFYMG9OM1Nqc3FmQk5xUDRUYmtG?=
 =?utf-8?B?QXZsaHlUTTAraW5ZTEdNVVZwY212dzBNeE81R0dyZURGa3dUeG1jckFNZXZj?=
 =?utf-8?B?L0tVQjNObVRQbEs5RzRRa0FTRGRLZlhlVFNGM28xWVNqS3ZPYk1qVlJTcjds?=
 =?utf-8?B?djl1aUhjQ3BaTUN5Y2Z0WDg1d2FPU3o3OWhmSHlqN3RZM2FBZ1JYQ0hSeGxh?=
 =?utf-8?B?TzM2SGVQS1dYZzloR3Q3dkU2UzFORWlYSjN4UkpnVUxhQ1hmbWJsdFMxTzds?=
 =?utf-8?B?TkEya0N4S0tnckZVOWdOendqNVlTNDNrTUlMVkNkYmkrRmt0Qm5hcDhqdGdz?=
 =?utf-8?B?VU5obXdlUTdqMG04eFJPbTNzZXluT2F0ZEdzN2ZHWldvckZkaFBMYk8vUW5Y?=
 =?utf-8?B?TlpRY1JUcmNKMWttTGpmRVFMR3dSd1doVVBEZURwNFpGTWszckk2MTg3cVNz?=
 =?utf-8?Q?WyuY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2860.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHBPVlo2azArYWQ3MUQ4WUFRZGxLekptY0hpRzUzejdrUzU0TmFFVEJyZ05v?=
 =?utf-8?B?ZU1OdmZsc212QzVWbHdsV21PTWFJc1J0cFhIRjI5Q0RzSk4xdHE0eXViSHhi?=
 =?utf-8?B?aFFZdEg5YUc2WDZnc2RobDYrdi9oMC9MTWlxMnB3b3JDTm5qTndiOFpHZjRw?=
 =?utf-8?B?S1Y5L0RWNGhYYmh2aHNXRFlxaklWN296YW1YYm53NHArODJIdnhRY21yY2g4?=
 =?utf-8?B?YXdzNHNqTUhWY0FDSkRNUFg1UVlmTnZUU3ZRZWFSK0dGWFFvV2N1NDNPbTZw?=
 =?utf-8?B?cHpGOFFhdzFQUFBpQUJZT0tSWGhUQmoxemhiL0FiSG1aQWZwbTNkMUROWGR1?=
 =?utf-8?B?bGt3RktZd0NnYmFiZW5odXBwYlhqeTVZdExNYlltQzNOMEtZeEYrMzZ1M3Ry?=
 =?utf-8?B?a0QvdnRJQ1BVVXZZZHUwbUlRd21nc0hxa2x3akZyMCt5T0R0ZCtYeEZ0MUtw?=
 =?utf-8?B?UVlZbVc5LzJzSFpnbThtQWNJSnMwV2hoL1Q1cW1tL3AwNHIrVWUyTGt5TjBp?=
 =?utf-8?B?S25yODEza0Jhd2RobDluNXpoYWJkZXltZjNjUDRueFVMeUN5bnN6MHRzbEd5?=
 =?utf-8?B?dUV3R3J0NjhIWFBER2x6bmo3dmtxak10WmNjUzZtaUd4UENvOGRpdVY4TU9H?=
 =?utf-8?B?cW92VzZCTHUzWUU1NE5oRW13OHRGTnFVOU9neGZSZkdLZTJydVZEOHlWK2dE?=
 =?utf-8?B?bUIvWERub0M3YlJ2Ym9rMFJaOTlkV0Z1OWQ4ZndXdERFaVBuNktRRDNoNC9Q?=
 =?utf-8?B?Z08wNnpReFdOYTNCcDZYZEJjb0NMMWRlVEVOdXJ6WkM3Vm9JTXNjaG9iQTJl?=
 =?utf-8?B?azV0VFJiaThsNnBGZnhWaitjaEpGeGJ3QkZNSC9meFowWGxrQnI4TVN5SXV3?=
 =?utf-8?B?N2FUUFdQc2ZWRXJTWnc2OVVWZzd1elBMTzQzUnJacmY4bWZWTnphTTRtSXdR?=
 =?utf-8?B?dzFxOXlRTjRwVlZBUElxOWlSZUl3cGZUZU81dXhUTzg4VFBrTTQ1UW1aUTBD?=
 =?utf-8?B?Z3Z1L3ZIMlZFU0FSN1JEQmhncmVDZW5TQ0Ftc2Ruekl3M2NlYVBNbjI3LzlK?=
 =?utf-8?B?amlhQkFOK1Fla3RUS1BORUtzM1JBaUVJZU5BQkpWdFpUVUZjMjNqcU9Bc01t?=
 =?utf-8?B?aTMvdkQ4MWh4V2VybjZQUHRwa1VtUWs5Q2xNWXc1NnExVkwwczl1SXdVbGMx?=
 =?utf-8?B?cW1tYlBxWVhDd1BjM3dSVVovOUhmYXZRVmZVQnUwM2VMb003eWFocVdUU1lM?=
 =?utf-8?B?QkRTNnc0bTdXd3NocUZIc1YzUlZ4aDNrTWgzMGJ6Mlp6UVk1NTZqcG1KOWtl?=
 =?utf-8?B?Y2dCQWRFZGdHclQ0Y040S01ZVmpoa0ZFR2VhaG9yWVRYRUs5VE5tYThHMWE4?=
 =?utf-8?B?RjkwajdCK0tRK0g2MlVlSEpHSVZYcG5TWUE5TmpjWktURnptL3lqZkxyZnNr?=
 =?utf-8?B?TDNyNjFUdHRCWFE2V3NyMktqUTVQajc0aHZYaXhodm5DZnZpRDZHVUc4ZDNr?=
 =?utf-8?B?dGk0a3lPZlVyc0tuWDV2YTYxbU5WelRmVk9ka0xWZlluekYwQ24yaGNmNEI2?=
 =?utf-8?B?V1JXbXFNeXJKT1FSTmdWeTNKandWNEhqU2pWT3o1bVpZM0s0WDQ1cnFFMkMz?=
 =?utf-8?B?K21CcjVYSnJPcTJQWXJCVEpCT2U3OHFRNkdKOEpJcm0xUmRVNGdscUxsUUx5?=
 =?utf-8?B?dFVoVGovaG5FVXhRNzBjNGlZdFBVR3BkTThVSkF2Y0lOZzJmMGRKSXpub1FQ?=
 =?utf-8?B?cnBsMGdDTDZhaUgwcTIwWUxIdEN3TCsxVU1yYzNOaXA2bGJZeURVRGZCaWFN?=
 =?utf-8?B?Z0FlS2U5NXhXd1RMaEV2Smc5bXBJdjM0blhaZzFxUTVxME9FMDRhM2Vrekgw?=
 =?utf-8?B?THN2VnR1bHIyUGd0bTV4Y3hOMk12Rmozb1FWZk91ZUtDTkRGZ1dmaVMyR0d2?=
 =?utf-8?B?VEc1VUlSUFFtcFdpNXVsbEFNbTJMK0NyZjVDV3NwY29MVDRtY2hMT2E2QXp2?=
 =?utf-8?B?bGJQeDQ4Y1hHS0pCZDZSQXhXRzkvWXVNZmwrS0hpSXMxaytUREtxcHBMOU1s?=
 =?utf-8?B?UE1aY2FZamw1RzFLNExpcC9YMGF1TG9RT2ZucjZZUy9teEhSUkRqT0xra051?=
 =?utf-8?B?MEU5b3ZRK1JQdGdTV2xUSWsxbXpML2RHL1VWM2hFU0RPbE45enUwbFZ6MUVY?=
 =?utf-8?B?Wk8vTFE0elJ4R0hOcjIyYWQySTB4Sk9zQnFCaVNaMWRBM0FXWUxJSFNYQWdv?=
 =?utf-8?B?cjJ1OGJtYWNZeWFmYStzN3ByQXF5Z0Q0aHJGNkdPOXVnYWVEblNUbVlac0Zr?=
 =?utf-8?B?SS96N2lkdDN5U1hYTjg0cEc4ZFRSUFl6L0t3OGNIR1JoOXZCeUxhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c11a17-823b-4a5d-c50e-08de72d42c5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2860.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 12:07:54.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28od2/5o1zWRlBMZ6y3u6nGyXdUKfajJ17m9aoNsJ+o5K2Dus9hFPUosJ/ZI4nLyAiN/fOoTXwxofX/+YN5ItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17054-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: B6A84175EED
X-Rspamd-Action: no action

Thanks!

Acked-by: Abhijit Gangurde <abhijit.gangurde@amd.com>

On 2/16/26 20:32, Jason Gunthorpe wrote:
> struct ionic_cq_resp resp {
>      __u32 cqid[2];         // offset 0 - PARTIALLY SET (see below)
>      __u8  udma_mask;       // offset 8 - SET (resp.udma_mask = vcq->udma_mask)
>      __u8  rsvd[7];         // offset 9 - NEVER SET <- LEAK
> };
>
> rsvd[7]: 7 bytes of stack memory leaked unconditionally.
>
> cqid[2]: The loop at line 1256 iterates over udma_idx but skips indices
> where !(vcq->udma_mask & BIT(udma_idx)). The array has 2 entries but
> udma_count could be 1, meaning cqid[1] might never be written via
> ionic_create_cq_common(). If udma_mask only has bit 0 set, cqid[1] (4
> bytes) is also leaked. So potentially 11 bytes leaked.
>
> Cc: stable@vger.kernel.org
> Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/hw/ionic/ionic_controlpath.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
> index ea12d9b8e125fe..83573721af2c08 100644
> --- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
> +++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
> @@ -1218,7 +1218,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		rdma_udata_to_drv_context(udata, struct ionic_ctx, ibctx);
>   	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
>   	struct ionic_tbl_buf buf = {};
> -	struct ionic_cq_resp resp;
> +	struct ionic_cq_resp resp = {};
>   	struct ionic_cq_req req;
>   	int udma_idx = 0, rc;
>   

