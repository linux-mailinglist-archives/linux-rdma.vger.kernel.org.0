Return-Path: <linux-rdma+bounces-21329-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKIxBQjZFWpYdAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21329-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 19:31:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB405DAB51
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5386D319A8BA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2FE427A14;
	Tue, 26 May 2026 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dfn3qcyD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE49425CD1;
	Tue, 26 May 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815645; cv=fail; b=pVE/iVQe4NyhVEKjMDQWZe5NSA47wYL1lPsEeSkTuyXLX55n7PgKhntOuix1pjvIkzDvqPl5FrQ7OSaXrIXD5EWOsvocUz00F8EUuQ0iEay4Ju4dOg68CO0KnMdoM17sapQPLlsgQTukWhZIeBGLWmRP7E7Rr2LEl1pquox9sjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815645; c=relaxed/simple;
	bh=g4CJKfw9qmRdsavaEeo/AUtYbp7hHKWYJMca4pjjX/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R15W5sUAoT/VBZ/rd6kCqDGeZVnwErGCS0vIUbKvzHyb3YvzbUTme7aaq0wPN/0jxlxS1gKto/Q/e5nLueMrzgwSbosXi6n1kqtzvZH1tmWhwYJ9CHfvYxAkYCa3lU6LHXKCyWkZTS7a838DBaj9ykk6WjzdaePPYgT4fW+D01U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dfn3qcyD; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcXDsEp5RUVSArdW5F9vAfeob6sRoRC1061kt/dieytjboPKmBBKBqk/HwSfa4lJa+691KnR+Jph/+astTUbTkIieDLVrkh5rqZ+BjBYy0MGTv0FFSFlpkzxdusuphWQ23h5BbZxLTyZTZSWOGztHy+WhKIloVeaitrinDNlwDXk+e48jGdD8KWmJLY+wefzKgAVHc0acFyvxmUCCeIYl9QOWyFZwDPIzGvq5p6bmNKa8Sz+c3iaxdvrm3VT3LGdilA4JH/3Xa77roS2ijGP+C3UjJudbOI39ImA0+zwJ6tUitRA1du35aQ1f0+stqWW4uf40hoC2dZP+W6r9VfzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpXN+saxTBfv5EZATeSop9p4uxbhoIlYP3XZsurmmBc=;
 b=NNNeeYgMBQ20rlbPor+AggXdRykNRO994LnbSb3pJWInjpujCUb1vuxgtViPvgC9ds9ZPJH8w8NluA3ogtU18mqjvFDfz/d6RdJRRJiD1KBkix7z46kEcOqFFHP7GJiAhmq8wiwnT3+gIuRrdr35hm0Gh+ebE8VCICZf2CGEiD+hVlL86e6jzFFiEwGmvOMUPhxtfy07PRYtrPFuGARFQxiJ42/2ecw7jl6T/TzmWsHOsdPj9bKPJLLu5Ti//hppp5utLmn1fJaNpK5JMaqt7GdUFRrV9AdmhA6g4PatV92+1YXUVQzaHKNP2zymkfIriALV+F4w/+J7rg2PL5JvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpXN+saxTBfv5EZATeSop9p4uxbhoIlYP3XZsurmmBc=;
 b=dfn3qcyDUWeXEeNd2S2JxQkTZQC1PBtqIhne8fIDO2m+9YkRFsR29QZluGWmy2c/wv1f7p4mut/AHWTBHmAHMcod1j1FYDjnWna9xmz5wX+Dhz78Vz+GmyEhrBELQoaL/LG0cVUm/Y14s9XArhFX5NJb23M5ORx+b1Zs5BkPKcTUNIAWMZRmqymsqiy1o/9XIITs/X99FTzr2/yhKkxNLGirtSqep2KIAYEkJyhruh5AQm3pbffseHiLLgWDpbg9nfRqFxo9wJeb1T6dU054LDAGY6oodpdLrG1IT9KrzAjwsRH48Yo4mJFulHz0i2jU3B7n2ag3Qg0lOb91BYqcJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 17:13:53 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 17:13:52 +0000
Message-ID: <b9105eb7-de56-496e-998f-7c49c660b880@nvidia.com>
Date: Tue, 26 May 2026 20:13:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Apply devlink default eswitch mode
 during init
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Feng Tang
 <feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Li RongQing <lirongqing@baidu.com>,
 Eric Biggers <ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
 <20260521072434.362624-4-tariqt@nvidia.com> <ahVPASuh4BZGOfx0@FV6GYCPJ69>
 <8c8df8da-62a9-49e8-84eb-572d54cfeb1f@nvidia.com>
 <ahWm4NXph9gdazV_@FV6GYCPJ69>
 <9aa7c295-35cb-428b-9031-13a2f507ae4b@nvidia.com>
 <ahXF2aQZNOwHdCG_@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ahXF2aQZNOwHdCG_@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8f9f3b-8f1a-4afb-c5ab-08debb4a28dc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099006|18002099003|22082099003|11062099010|6133799003|11063799006|4143699003|7136999003;
X-Microsoft-Antispam-Message-Info:
	Q6EKov6qqJJ65wOXxYvbN62jLgWaHW2m/NDZjO8AqdQyqMLEUE/zmuIwZM60rFR1aF9Edg5BbiRhI7W8U5Flw1sqfWfMPo3xio56ukB2AaaczAmICOAx7Xb/xbXBYJhNHkviR6a9KvCU50PS8H+88AUBKjEZxmmpGF4R0vjJAXZqfCfKOTjzxrHO0JVuCFGP9hy8yDn0hUtokVusiAHNhEdR+EdZ2UMjuPQRHsEnkB3x2ysrdyMGETFNHSGKDIhyt9x6MQMvy4qG3D1xq90kQSenUP6KAvkSEFEM++2vYURfDE1We0qXaqPlO86rvo8ymydTzM0xS+rGluObI3dsPJ0RwqLtvaYxu2HKulHNG6poKfGKYJ4Bc6ZO587Q/MtKdXygvqg9AHpKgexuqu9PTWFa/aYZYj9J4rPrIt/bKkZrSH0awPy0b3KbmfXu48zthvUvfNGc3tlhQt1a9bG8Q+avEcdhAy2Bg9IBYwGc+GaSKE7ccRHIoE45Zvp0KsFGPMGFsUVcSHretTYkgxRxts4escRuChkDv5txgpqtpaGqqnUXoo8zlRsJeIcdDlBzL0nuO1gu71KGIeCmzpqsDrtGvxISLPx+YnrD4JolebMgdJWU/NG9Bw88SsZpTT1tSWBT/SA+686WxSi3iUbR1TxGpkmFTZK8z9wTpEDMkat1tIQG01MNNEvXRMYnylbp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099006)(18002099003)(22082099003)(11062099010)(6133799003)(11063799006)(4143699003)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEEyUXNPQlFzQVNyYUtDS2FXc2lXSUx1QkZWc0FWemZLOUFkUDZ0ZzVCcTho?=
 =?utf-8?B?aGRnWmhzNWFTUmxVK3M3VmxjN1kydE5BMVVaN1BQM0ZNR2JEQ1NmN3F6Q24x?=
 =?utf-8?B?OGs1Y2Y1eFU4MVZIZXRYT045RE1laXFEcmljM3lGRjc4OHF6UStaTWMwb0Ir?=
 =?utf-8?B?dm4yWWw1bUxpakR6R0QwVk5Zajl6RFRSVGJHWElBSnVmWjUvbUlWamZRV0Yy?=
 =?utf-8?B?eU5kM04xQVFWNVFKZ0pPb1gwV2xubzB4ZWVjWEVuT2E2SDhISG5NQW1KOE9u?=
 =?utf-8?B?MThZa3BacE9zYXBsVTMzNHE3bmhRUXRWUkQzZUhsdy95NDk4ME5tT1FjUGFS?=
 =?utf-8?B?S3dDS1VZZVVzOG96bWVSMG41UnFMYXk0dVpmWGgzdWp1ajhUa1IxcEhHWFBn?=
 =?utf-8?B?bjFZZmJjWXJVOWRoRmxqb0x6bm1iZzVWZ28ya3ovayt4d3lZell1enpuV2Fj?=
 =?utf-8?B?L1g4MDNpN3dPbkMrcmt3cEhRdkJZNkFGc3pIdFZPWXZGaklFSm5PQURHVUU2?=
 =?utf-8?B?bzBSTjFFTDN0aTJFQUg2Sno1ZlNqQ3Z4Z05iUG9xa3BvY09RWGFFV3E1dVly?=
 =?utf-8?B?aHFUd2JqSW5NN1VqdzhkMUQ5R3ZhUFg5bjdPTGFaajVQTnNCZ1RUNnU2UTJa?=
 =?utf-8?B?ZWdCV1RWZFZvWUFOR2dscG8wMmZSMW95amdYN2JVRlJ5OGFqckVjcEkyMlhj?=
 =?utf-8?B?UkU3WmcxalRXSjdjbzVsaThFNGEyU1ZKWWFNcjk5anpDU1dXMWY3WVAzMDlT?=
 =?utf-8?B?ZGpsczNjZGFPYkR6dXdEa1MzOHJyQ2F6TmdMQVl1QjcwTkQ2Ui85aWR5eWUz?=
 =?utf-8?B?TnlnLzBPMktYWmRIYVVZSlZsZHBVVk41czVVWmZnVmswaUlnZGRUbXRNN2Ez?=
 =?utf-8?B?TkpFT1NrZzB2dUp1MVpDUFRHaUVpR0xBMXNOUGg5WHdkQ0doeWhNbDdWYUM0?=
 =?utf-8?B?YWVNdWFhckNEaXNCMnNXWnhLL3ZDVjNkT2Joa0V6TGZBcW03K05GcittSkZ2?=
 =?utf-8?B?RGlDUk1NdnpBY1V1ZkVZRXJQTFRZdGV5MWxEa3kxeTJaejBCdDRXd1Fsc0Nq?=
 =?utf-8?B?V0ZLc2k4dVNyaGxwbk42VGlQYi83dXJmeTdDOHFEZFpsbGQzZnBWeFFYVjVw?=
 =?utf-8?B?dkxzUDYyeElmNlJSM2pzY0NlKytMTHVqWG5oaWlLUzI5REcxN25xYW53dTQ3?=
 =?utf-8?B?YjUyb2puR05Hbk9FQXVhRVFqMDU4S2VTVFd6dHUyTDl2R2Fzd29DcmRvV1VQ?=
 =?utf-8?B?dmVYS0VWV2VXVi9JeDRoamJ5OHF3VlFnQ0ZDNGZuUDZhR2N2bXlwQ2ExL2Ur?=
 =?utf-8?B?VGhiVnhqaXpDM0hXL0h1dGpXMHRCb3RBclBIZXMxT2xsc2p2bkdxYkFjWDZa?=
 =?utf-8?B?WERqYklRQkFzR3lqV0t5ZFZLZjU0bUVSWXFPaTIzTzAyQTcrdENHVXBLZnRp?=
 =?utf-8?B?VklIYkRobU8xd296SjR6VzljOGtWSGlRek81QWJzN2FQa0ZYR0pkdTdNakFw?=
 =?utf-8?B?S0I0TGUyQlVCSHJuL2dQNWZsWjIwNVdaVFRhNzlrN1lSR1dmaG9PZkROODhh?=
 =?utf-8?B?UlFoUGp3dkU4N1Y4YUxoUGdPNXU3eU0vTHcySVRJVzRIYmdOSmhHRWFMaGgy?=
 =?utf-8?B?UG9MbWtxYXMybzhQMTNaZlpoUUxocnpVaUdrVjVvcnZPS0hWcXR6dHBrbW51?=
 =?utf-8?B?cmYxUExrWFE5RitWeEIwNVp4N3ZoK3dpQ2hyMmpQYkNSZk5uclREbW9BdVQw?=
 =?utf-8?B?T3R3aHpJUDM1My9peExsajFtSkR2VlFFTHpEZjZGZE1CODFydThYeUw3RVdJ?=
 =?utf-8?B?QWYzUTNkbnpITjlwZ2JqRjJVWElaQTNaWVBoejI2NFRzOEpEVVRpV3RBU3BL?=
 =?utf-8?B?MEs4UC9MSGhzZEp6ZDkxTE5mNUhqM0pmQWxBL2xuSjZiUEJ5ZTJSemJjZmF5?=
 =?utf-8?B?L1ArZEhFY2M5TTBUZGNld1dyYWdNTG1JdGlsd3NSNTUxMFE1S2hmN3QwR0hD?=
 =?utf-8?B?T3ZielFlT1FPM2tRVzBBZkIzVW1VN0NOSHgwQXMrOENWRGRkaUthTmVoWkp4?=
 =?utf-8?B?b0NOVG9vODR4dG9DZE10SnBlb0JreENKYy8wV1Bza2thSHlSWm9UdFFlMTJU?=
 =?utf-8?B?U05RVS9pTVAranZBS21lSDBIc3NIQlRmL0NKQ3hlQlI4WjFOeG5ta1M4TnRk?=
 =?utf-8?B?cGVLVWdaaGE5VlFwYjBBTU9KaTc2UkV0Z093aS82K2hRMFR3TVRtblN6Y25W?=
 =?utf-8?B?Uzd3NWxDL1JjcXZSTXJET3pja2c4bDJ4bHpQTXFLMk9NM05mYTc4Q1NsSXBp?=
 =?utf-8?B?dHU3UTc2UVh2cmYvVkJ0K1NRcWFOQW1zNHpoeGFvb3EvVzh0dStOQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8f9f3b-8f1a-4afb-c5ab-08debb4a28dc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 17:13:52.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrK5IYEIoNauK/d4HdSq9+3bsaAvJ42T6/HhQoOCzy3fJu48nM0fWYrbT7GMy7nDRmhGKf6AwWJpt0PRRMHmtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	TAGGED_FROM(0.00)[bounces-21329-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6DB405DAB51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 26/05/2026 19:23, Jiri Pirko wrote:
> Tue, May 26, 2026 at 05:03:57PM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 26/05/2026 17:07, Jiri Pirko wrote:
>>> Tue, May 26, 2026 at 11:44:46AM +0200, mbloch@nvidia.com wrote:
>>>>
>>>>
>>>> On 26/05/2026 10:44, Jiri Pirko wrote:
>>>>> Thu, May 21, 2026 at 09:24:34AM +0200, tariqt@nvidia.com wrote:
>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>
>>>>>> Apply devlink default eswitch mode for mlx5 devices after successful
>>>>>> device initialization while holding the devlink instance lock.
>>>>>>
>>>>>> At this point the devlink instance is registered and the mlx5 devlink
>>>>>> operations are available, so the default eswitch mode can be applied to
>>>>>> the matching PCI devlink handle.
>>>>>>
>>>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>>>> Reviewed-by: Shay Drori <shayd@nvidia.com>
>>>>>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>>>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>>>> ---
>>>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 17 +++++++++++++++++
>>>>>> 1 file changed, 17 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>> index 0c6e4efe38c8..4528097f3d84 100644
>>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>>> @@ -1391,6 +1391,21 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>>>> }
>>>>>>
>>>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>>>> +{
>>>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>>>> +	int err;
>>>>>> +
>>>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>>>> +		return;
>>>>>> +
>>>>>> +	devl_assert_locked(devlink);
>>>>>> +	err = devl_apply_default_esw_mode(devlink);
>>>>>> +	if (err)
>>>>>> +		mlx5_core_warn(dev, "Couldn't apply default eswitch mode, err %d\n",
>>>>>> +			       err);
>>>>>> +}
>>>>>> +
>>>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>> {
>>>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>>>> @@ -1437,6 +1452,7 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>>>> 		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>>>>>>
>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>
>>>>> I wonder how we can make this work for all. I mean, other driver would
>>>>> silently ignore this command like arg, right? Any idea how to make all
>>>>> drivers follow the arg from very beginning?
>>>>>
>>>>
>>>> I have a follow-up series that adds the call to all drivers which support
>>>> setting eswitch mode. When going over the other drivers, what I found is
>>>> that the right point to apply the default is driver specific, drivers
>>>> I have patch for:
>>>>
>>>> 46e16c6d9836 net: Apply devlink esw mode defaults
>>>> ab4f54102ba9 bnxt_en: Apply devlink default eswitch mode during init
>>>> b48cce1607bb liquidio: Apply devlink default eswitch mode during init
>>>> 4ea54b0fe04a ice: Apply devlink default eswitch mode during init
>>>> b7faddaa1c90 octeontx2-af: Apply devlink default eswitch mode during init
>>>> 74b0c22c47b9 octeontx2-pf: Apply devlink default eswitch mode during init
>>>> 5000e4c3d768 nfp: Apply devlink default eswitch mode during init
>>>> 97a218e95e41 netdevsim: Apply devlink default eswitch mode during init
>>>>
>>>> I don't think doing this generically from devlink is realistic. devlink
>>>> doesn't really know when a given driver is ready to change eswitch mode.
>>>> Some drivers need SR-IOV state, representor setup, or other init pieces to
>>>> be ready first, and the locking is not identical across drivers either.
>>>
>>>
>>> Low hanging fruit would be just to call ops->eswitch_mode_set at the end
>>> of register. Multiple reasons:
>>>
>>> 1) end of devl_register is exactly the point userspace is free to issue
>>>    the eswitch mode set. Driver should be ready to handle it.
>>> 2) all drivers would transparently get this functionality, without
>>>    actually knowing this kernel command line arg ever existed, without
>>>    odd wiring call of related exported function. I prefer that stongly.
>>> 3) you should add a there warning for the case this arg is passed yet
>>>    the driver does not implement eswitch_mode_set. User should
>>>    get a feedback like this, not silent ignore.
>>>
>>> The only loose end is see it the void return of devl_register().
>>> Multiple ways to handle the possibly failed eswitch_mode_set(). I would
>>> probably just go for pr_warn, seems to be the most correct.
>>>
>>> Make sense?
>>
>> I see the point, but I don't think devl_register() (at least not the only place)
>> is the right place.
>>
>> There is a small but important difference between userspace doing
>> "devlink eswitch set" after register is done, and devlink core calling
>> eswitch_mode_set() from inside the register flow.
>>
>> Some drivers call devlink_register() while holding the device lock.
>> liquidio is one example. If devlink core calls ops->eswitch_mode_set() from
>> there, we may start the full eswitch mode change while holding that lock.
>> That mode change can create representors, register netdevs, take rtnl,
>> allocate resources, etc. I don't think we want this to become an implicit
>> side effect of devlink registration.
> 
> I believe your AI may untagle liquidio locking :)

I didn't try to solve that one with ai. Most drivers were fairly simple 
so I didn't use ai at all. bnxt was the one where I needed a bit of help :)

> 
> 
>>
>> For mlx5, the placement after intf_state_mutex is also intentional:
>>
>> mutex_unlock(&dev->intf_state_mutex);
>> mlx5_devl_apply_default_esw_mode(dev);
>>
>> We can't call it while holding intf_state_mutex because the mode set path
>> takes it internally, and switchdev mode may also create IB representors.
>>
>> Also, devl_register() only covers the first registration. The mlx5 call in
>> mlx5_load_one_devl_locked() is for reload/fw reset recovery kind of flows.
>> In those flows devlink is already registered, so devl_register() is not
>> called again, but the driver state was rebuilt and we may need to apply the
>> default again.
> 
> Call it from reload too, right?

Yes, that was my first thought: apply it from devl_register() for the first
registration and from devlink_reload() after a successful DRIVER_REINIT.

That covers the clean devlink reload path but....(see bellow)

> 
> 
>>
>> Same for reload, fw reset and pci recovery in general. If the driver tears
>> down and rebuilds eswitch related state, the place to apply the default is
>> in that driver's reinit flow, not in devl_register().
>>
>> When I went over the other drivers, the right place was not always the same
>> as devlink registration. I'm not an expert in any of them, so I hope I got
>> the details right, but for example octeontx2 AF needs sr-iov and the
>> representor switch state to be initialized first. nfp can do it after
>> app/vNIC init while the devlink lock is already held. liquidio should do it
>> only after dropping the PCI device lock.
> 
> Idk, perhaps do it from devlink_post_register_work of some kind? That
> would allow you to have the same locking ordering as a userspace cal
l.

I thought about a workqueue too, it was actually my first idea.

The problem is that then we race with userspace. In the mlx5 version here the
default is applied while the devlink lock is still held, before userspace can
come in and issue its own eswitch set. If we defer it to post-register work,
the devlink instance is already visible and userspace can get there first
and then we might change the user configuration.

Also, the bigger issue for mlx5 is not only initial registration or devlink
reload. Some recovery paths, pci resume, and fw reset flows rebuild the driver
state without going through devlink at all. I did not find a clean way for
devlink core to infer all those points by itself.

To handle that from devlink I would still need to add some api for the driver
to tell devlink "I just reinitialized, apply the default now". but nce I had
that driver call , it felt simpler and clearer to let the driver call
the helper directly at the points where it knows eswitch mode is safe.

I agree that handling all of this inside devlink would be the better option.
I just couldn't make it work in a clean way.

Mark

> 
>>
>> Mark
>>
>>>
>>>
>>>>
>>>> Also, since this knob is only about eswitch mode, I don't think we need to
>>>> touch every devlink driver. Drivers that don't implement eswitch_mode_set()
>>>> would just ignore it anyway. The follow-up only wires the default into
>>>> drivers that actually support changing eswitch mode.
>>>>
>>>> Mark
>>>>
>>>>>
>>>>>> 	return 0;
>>>>>>
>>>>>> err_register:
>>>>>> @@ -1538,6 +1554,7 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>>>>>> 		goto err_attach;
>>>>>>
>>>>>> 	mutex_unlock(&dev->intf_state_mutex);
>>>>>> +	mlx5_devl_apply_default_esw_mode(dev);
>>>>>> 	return 0;
>>>>>>
>>>>>> err_attach:
>>>>>> -- 
>>>>>> 2.44.0
>>>>>>
>>>>
>>


