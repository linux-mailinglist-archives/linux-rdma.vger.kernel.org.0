Return-Path: <linux-rdma+bounces-20304-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKLXOFd7AGqaJQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20304-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 14:34:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86E503F39
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA90D3038D01
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E060382F1C;
	Sun, 10 May 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JUP+rDTv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974F38229A;
	Sun, 10 May 2026 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416312; cv=fail; b=ol0NiDEN3AiDtzFh4/D91Jc17p9F6iihEbHH4VZsk4yA9w/vEbev7l7pNywFTLC7w2RQ+K2+8hWN5wNmcCOTGwzI3siX8ESs40m4JhfIgnOVS2BDcwNlk+lolBZqHZZX396lQuFmMQZOJ4Vnu/OX0PmmvgoKEQWeqF19kPqFd/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416312; c=relaxed/simple;
	bh=XtG7FhFNF3Ei/0LWWbJVYH+degE6UHzMN1wVUNf8EZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BGWbtc/xO6N+DPKwXzvvQrVmUjUAId1YemXgWV35wk3CNvFJrebvex++c0DnIDQ6qrJ1znBmeRE/SFqAQJlrwG59nko+XKhkGng/So4Nl6H0uFYlF22xI66YqS0ROvhWr+ai0V3HG4Rsr5C5DoJdKygLIxRBddBikVbw0THnztI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JUP+rDTv; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pm1pO/qZPme0ds0vWLGT5W5+NGIM+lCbj/9UOpVhUHjr6OnAJxP14VGHVY2HyeH8rVLRHvRSnhPh/mlMiTarmlBX8qPrlkb1C7zfWTT4SGzjrj8P8H9SVIYR1MJM/q+Q5MkLffMibHI+BiRZ2thWFwH/6m10xa40GHvT17al5PLxoct9QPgirvlWZbrZXlGriCSvm16rA/+x5aL91R0NhTHDYwCdDhDs7/wIvTLFH5Y8WDlACSKy8lljwicdpI3TH2E1EnpsT4/zpFWdf1cBXhNBtT1xIHiTe9xR/r4yVmXYPXbnYIBbyMI5/8XnBNnIS17fzvLUYBjC/0+N4aJzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQMZIIG5o/rNoszFZ0WO4sWBJZD8Flgcx26ApdlNVqs=;
 b=esuTfMN8L2XN1kLgk6+sIepv/MwZrcc5Xe3P3Wcx9QH6PqNPQcdz7gdAap7jr2OtkexqctyTpUVYq+1jF5POckaOhD5BRfiZvkv7ZJ8Jb+NPFA8m/az0rGFJT6vOX1yMdRtd6MHYZMKx4m4hbzeCbEmJ1feY0DBsoHU6n6T6v1uHdM6w0gM6+MRUyO/tv9I4Ewjgj1XyPEAfJXcfCbDFMuYbo91XB2zuMVdj3XcpASYz85QpcXr50a6VJRLexUJBrzyeAR2AHCqVpPa7jLBY7EUyfsYfeiRTwEaWd7EsD+JDjrfm77aounWFBg1iFbA/qTf0qBU9yxC4ys4YfurVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQMZIIG5o/rNoszFZ0WO4sWBJZD8Flgcx26ApdlNVqs=;
 b=JUP+rDTvtynBgTEj5lpqf4kNysyedgabD7d0LAJ5zbqyzUGs9pUfuyu9MdXKjsDWyFm+NsKOP+jw7v1VP5wGFTJ2v18sQrM5aSVqjpMrfa0Jhifu8qUSx1TBe1UC3AP1xfY7aTdY2IyvMRgnsYX5/dnqWTk8pJlvqCmPzRIii1X7IwWjdbvQxJZQ+VxMnpIPnCC3+xnqND+Q2eeLgzBYo9pvAyq/G+8Mf9+QNIFzTHXE8ao2sW3sThwU/xWaQvN36fggDguzwN4q/tJ9IxynIpulzt50NWtrNDWPqYZ7eeJresjE3FQyddIfd3jk5PyitOZGaGdVI9tPHlFG91nBlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 12:31:43 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.020; Sun, 10 May 2026
 12:31:43 +0000
Message-ID: <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
Date: Sun, 10 May 2026 15:31:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Randy Dunlap
 <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
 Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69> <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::8) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DM4PR12MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 5759ea09-a5d3-4dde-32c8-08deae9017ae
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	+JlEJATG5VHZGKp29QZ7Bzql8+cSk6mGQ/I5Zp9ODymIlqzP0+xZupqJB9NxXhobqVWQ8TAMznhxLsO7JFj1Hkq2SX6DVU/CpJWIVy3oNK133RdUsCR7l27oid+13eSXL9UBkYh8olCFJdq91SyT+hSq3VYI1d3Wuhx9LySw/vci4O8eXfFkN4DNsRH9xTpjySxG9uetfHuqGnIZONTcBP5I8YEr3ZGHrfUawpdfsS/1QD5xs2Ut8/bki2HZGSVoOo2psuUb1Mxk9FlAOaI+RGGprhoV4moeMY8I7wvsUjQNxqmZDBr6Jzymmq6igLCLcHnu0QqVYud8SKd0uxYgQrSWvwCpo7aebWNSD/RF41bDzIQ/uzgnibv/AwmIE4VO+wl1xI7FqM6h28aBpk0WiC8N9y67bSb/hpLG5Yml25R475w/TfrpP7OhwPSe1NHDReh4YxrWWUVIA1Fw0TS6xb4wUCOdNyap2lmJiMfyDOcfVNVr+afFaZdvy4uVypW2QbhPJBgEuGGea5CUzbW112eHRSUZwyqRe4pTWKmLuEx7lrrNIZ9zF5gpn4vZGvPwDnvvp2P3d0RVmaWFkWRH2pMgcRkd/YtyaCPyZuiE0wApaBPYrznB+hHx+j/h2zEWFqIcLnLNBo/7Ekbivep5ZIY33ffNxpW7FdC/iPMGKW5GyuaWx56G6xiN/oCNj3oV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amx6S1ByaXVQMEVQYTdrb0RHMkpBSEFvN2FocE1sSEtaTk4rYjJQQnhibFNy?=
 =?utf-8?B?SGE1ci9PUUFVZXAyT2twQmxYZmtYR1hlNldYV2ZCWDhSaFZ3eVhNR28xZWFz?=
 =?utf-8?B?b1NiK0ZRZVBBM0Q5NWloNzFSUHk1UFNwVjJyUmwyWTlQc3Nuam5ZMXBXbnZO?=
 =?utf-8?B?dHdwUGFFUERva0ZvUC9leEoxYnVvNUFzMkxxaXF1dWt2REplYlhSRUIwQm1F?=
 =?utf-8?B?Q1VVTS81VGp6c2c3dk9LNG05dHU0QW03dVk5b0prWFVSS0dLUkhYSjIzNWdy?=
 =?utf-8?B?Sk5pWFBkYUw0RG0yT2FROVQrREdsSjRGT1N2b0Mxckp0ZUtRTXJXT2VVQ2hT?=
 =?utf-8?B?YnBJaWgxTGx5V0FWcysrMG9OaDkxYVdNMWxkeXAvTHN5QTdDT21iVmwrZitV?=
 =?utf-8?B?V2s1Zlpia25vQVZoNnhPV1B5MlpDek0zSURvcS9UMTl0MEZjK3FVSk1rSHl3?=
 =?utf-8?B?dWJDSmw3eHFhb2s5Vm1UbVViNFRXQUdwaTZMQkJwdVhNd3FZZ1VWUTJNWnBG?=
 =?utf-8?B?MGJlbiswdVlpTEdVQmxBc0EzZGs2S0RYWTU3azJpUHRicytYZFI0eXFma3BT?=
 =?utf-8?B?dUoyOFFlTXc3YSt4dHZvYmpTbklrd0NjWnlNVk4yTDN3MkQ4SFl4MHR0M3Zr?=
 =?utf-8?B?dDQxTGRaN1NTQ0dXaVZBNHVrb0hrSVFibCttQTYyb20wR0tCa1BCcFBZRU9M?=
 =?utf-8?B?UTRvbDJObHZJWEVGclQvK0t5eEtibHhPM1pMdGF0RzNZWTdDTm9FaUdWK2ZD?=
 =?utf-8?B?RzlTZ3MxRFlmcHpvR08yVFRQRzhnMGU2ZklqbHdGem1PZEFIU3BseUNBcEtQ?=
 =?utf-8?B?cWRhazRrSFZhdnNmK1NSQitqUzBBVGcrVlVtekJ6WHQ1K2QvclljdklPNFEw?=
 =?utf-8?B?Uk9jNk9rSHU1U3VvT2pRYUIxQXltWDBjVmJNUjlWaTR2VXFWMSsvMXdhYXFz?=
 =?utf-8?B?ZVkwUTJiM3laSW1IWmgyWm80dEEyT2pzRENwUXNLU3lKTmt0ektiVkdKK0FV?=
 =?utf-8?B?ckEzN1FpaFdoajZJRFlYQVplTXpUQmFHRzZVbWlsMXpMOTJ5L2YyZGJFZGQ5?=
 =?utf-8?B?K084SlJZQlhEb3llTUJ6YWZZM2pGa0Y1OTcrai9QQUxRRDdIWE8vK3grOUNQ?=
 =?utf-8?B?R0wxbTQvbEtBVGtVU2Jtemc2SER3SjVlMU5xTThpQUVxM3hwVU5RQnUxK2Nz?=
 =?utf-8?B?ZVlFa01YYytETTBDR3hzVWJrVFMyU0krMzhtUnlTQUFoK3FPZEltM2xrRUFk?=
 =?utf-8?B?VDJuaXJxSnJ3V0FYV2NRSmVQeE9hSFJUaVFyZUx0T1V3RTRLK0tSQjA5aSs1?=
 =?utf-8?B?ZEM3ZGI4TkJaS2Vjcm9UV1g1bUNhcUd4bXhyaDl0NlZzMjdCZFFTZ05lYUhm?=
 =?utf-8?B?VEE0QmhXQlFnTXFNZzF0YUFESXM2aFE1dFVlN0ZwaDhPZjZyQi81SUx4a0p0?=
 =?utf-8?B?bGFKaFQrNWtuQ2Zxc0IyQVRmR0JCT2pJM1JKVmV6ZkZFZk1YRVd3SWlQalZq?=
 =?utf-8?B?eDhrZk9VNEV0TEs1S29DdndnQldOQzRiNXBINlRGeEJCQmtvU1lNUTBvRHZl?=
 =?utf-8?B?Rk1OSEFTSXV5TU5rd2pwTVB3RFE1NytENWNjMEd2cENlZzBUdmVnRG81Vy9v?=
 =?utf-8?B?TUpHMWU1aWJWZFVaNitJRklHdGgrNGZIZ3UwUUtsYTMzNkNkTWV4R0twNHNQ?=
 =?utf-8?B?OU02NXBSa0c3RlRnWGlaVWxwVnNvNzM2RnBkQVphQXRrb1dHUHN6cTN3YWtu?=
 =?utf-8?B?Rm40YncydzBiSHQrVUgvaHlPYkR1RW42NGhZeCtWQ0RYZEhJSE9nUmV5NmQz?=
 =?utf-8?B?OHVVdXB1NWlaUWM0V05IdnNxbHdpSE1STWZSMmEvQVg1SGxBUVhZeTRSOW9J?=
 =?utf-8?B?YkUyVGtONms5SEJUOFYvZUM1cXA0V0o4UWx6K2lweGhRRkpiZlNYUE40anRJ?=
 =?utf-8?B?WnozaGJoVG42bFl1bk5ZVDFkZkFLUjdITmxtY0dhcDhwenQ3ZlFWMzNhbmtO?=
 =?utf-8?B?WUtrb1lhZ2hGbFNIc0tucFVxQ3JvT0pDZVlob2dvUG5zdTJSSEN5UllmQ1ZR?=
 =?utf-8?B?ZFFWaEZwRlR2STJTYTFuLzBqNzVESDBsazEzeXpUcWpHaEU1Q1NxVUlSaDB0?=
 =?utf-8?B?cTdzTVhqeWlyZ1NMRjJuZGd2bUJTeGZBUGN5WHFGK0lJSWw0UEN0aHVYSU1E?=
 =?utf-8?B?RTlFb0JwL0I4b2xWUDlXUkU0akd4N1d3UVB0VG0wNm1TSDdkUkc4ZVBSUUJm?=
 =?utf-8?B?bVNxSFBZbWkxOHFvRzZjeHlwRUhJcW1XY2MwdWVkSzFGV1dKdG5TQUhxUjVy?=
 =?utf-8?B?ODExVDZxVVErZ3d2SXZwU3VJRFBZNC9URWZodXVLMHFnNldxeGlqQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5759ea09-a5d3-4dde-32c8-08deae9017ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 12:31:43.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtOhZ0brZMAW/zrohztu23rgBh1gbyq2F2XMtoWf1+qSlNJ47g0D2RzKeWTlKg/SbFTe1zdQEgivc8Lf398rLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Rspamd-Queue-Id: 9D86E503F39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-20304-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action



On 09/05/2026 10:01, Jiri Pirko wrote:
> Sat, May 09, 2026 at 02:52:13AM +0200, kuba@kernel.org wrote:
>> On Fri, 8 May 2026 20:07:44 +0200 Jiri Pirko wrote:
>>>> I don't think switchdev by default should mean CX4+ in general. If we get
>>>> there, I would expect it to be limited to the DPU/BlueField/ECPF case, where
>>>> the host PF probe path can depend on the ECPF reaching switchdev. Changing the
>>>> default for regular host NIC deployments feels like a much larger compatibility
>>>> change.  
>>>
>>> We can't travel throught time, but if from CX5 onwards the default would
>>> be switchdev, nobody would feel broken in terms of compatibility. That
>>> is my point. Having "legacy" as default is simply wrong for never NIC
>>> generations. That is why it is called "legacy" and it should have been
>>> rotten through and out since CX4 times.
>>
>> legacy vs switchdev only describes the eswitch configuration.
>> As a non-SR-IOV user I really don't want to see the extra representors
>> hanging around my systems, confusing all daemons. IIRC mlx5 had some
>> limitations around the uplink representor. Maybe that's the disconnect.
>> But for a real, fully featured switchdev eswitches having the
>> PHY and PF representors on boot, always, will not make sense.
> 
> As "a non-SR-IOV user", what extra representors you talk about? When you
> have pfs only, you don't have anything extra. Just 1 netdev per-pf, one
> devlink port per-pf. What's extra about it? When you don't have VFs/SFs.
> Everyhing is the same:

The netdev list looking similar is a bit misleading. What matters here is
not only how many netdevs show up, but what that netdev actually is.

In legacy mode, a PF only user can just use the PF netdev as a regular NIC
and use ROCE on it directly.

In switchdev mode, even if there are no VFs or SFs yet, the PF is moved into
the switchdev model and the visible netdev is the uplink representor. That is
not the same thing from a user point of view. The uplink representor is not a
ROCE capable endpoint. So a user who used to boot the machine and use ROCE on
the PF now has to create a VF or SF, use that as the roce endpoint, and also
set up the switchdev forwarding path with tc, bridge or OVS so traffic from
that function actually reaches the wire.

That is why I don't think this is only a card generation question. It changes
the deployment model. It may be the right default for BlueField/ECPF style
systems, where the host is expected to sit behind a switchdev control plane,
but it is not a safe default for every regular host NIC setup.

> 
> c-220-136-220-218:~$ sudo devlink dev eswitch show pci/0000:08:00.0
> pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic
> c-220-136-220-218:~$ sudo devlink dev eswitch show pci/0000:08:00.1
> pci/0000:08:00.1: mode legacy inline-mode none encap-mode basic
> c-220-136-220-218:~$ devlink dev
> pci/0000:08:00.0: index 0
>   nested_devlink:
>     auxiliary/mlx5_core.eth.0
> devlink_index/1: index 1
>   nested_devlink:
>     pci/0000:08:00.0
>     pci/0000:08:00.1
> auxiliary/mlx5_core.eth.0: index 2
> pci/0000:08:00.1: index 3
>   nested_devlink:
>     auxiliary/mlx5_core.eth.1
> auxiliary/mlx5_core.eth.1: index 4
> c-220-136-220-218:~$ devlink port
> auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
> auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false
> c-220-136-220-218:~$ ip link
> ...
> 4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether b8:e9:24:f2:b7:6c brd ff:ff:ff:ff:ff:ff
>     altname enp8s0f0np0
> 5: eth3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether b8:e9:24:f2:b7:6d brd ff:ff:ff:ff:ff:ff
>     altname enp8s0f1np1
> 
> 
>>
>> IOW it's not a question of the generation of the card but of
>> the deployment type / use case.
> 
> I don't think so, not in the case of mlx5. The difference is only when
> you work with sr-iov, you either use legacy way (ip vf) or the new one.
> Same usecase.
> 
> 
>>
>>>> For the ASIC/NV bit: maybe technically possible, but it feels like the wrong
>>>> layer. This is boot/deployment policy, not a persistent hardware property, and
>>>> storing it in NV memory would make the state persist across kernels/hosts in a
>>>> surprising way.  
>>>
>>> Well, as any other nv config, it persists across kernels/hosts. Think
>>> about it as "unbreak-my-not-legacy-device" bit.
>>
>> For most devices the switchdev mode does not change anything
>> substantial about the device. It's purely a kernel / driver config. 
>> It changes what objects and default rules kernel / driver installs. 
>> So I don't get why it would make sense to flash into the device
>> nvmem a Linux SW stack specific config.
> 
> I look at it from the perspective that from some CX generation,
> switchdev mode should be default. So that is a device-based decision.
> I believe as such it can optionally be permanenty configured (nv config)
> on older device. Why not?

This is a deployment policy decision, not a permanent property of the card.
The same adapter can be used in a regular host/RDMA setup or in a
switchdev/offload setup. If we store this in NVM, that Linux switchdev policy
follows the device across hosts, kernels and use cases, and can surprise the
next deployment that just expects a normal NIC.

I'll send another RFC v2 with support limited to:
devlink=[...]:esw:mode:{ switchdev | switchdev_inactive | legacy }
and let's see where we land with that.

I still think a small kernel command line knob is the cleanest way to get to
"switchdev by default" without making the interface too broad. For more
complex boot-time configuration, I agree that a devlinkd or similar userspace
path is probably the better direction.

The "pause probing until userspace configures devlink" idea feels less clear
to me. It is not quite the simple boot policy knob, and not quite the full
userspace policy manager either. It would add a new probe state and require
early userspace orchestration before the device is fully materialized. At
least for now, I would prefer either the small cmdline option for the simple
global/default case, or a proper devlinkd-like solution for more complex
policy. Between those, I still prefer the cmdline option for this specific
early eswitch mode default.

Mark

> 
> [...]


