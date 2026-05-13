Return-Path: <linux-rdma+bounces-20547-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MSrCeMRBGoMDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20547-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:53:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE852DCE6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 690CA3030BB9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333153AEF47;
	Wed, 13 May 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+Qnn0/O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26630674C;
	Wed, 13 May 2026 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651603; cv=fail; b=kEYf/dcq/3umy0dRUPbdgzFuWYuVVGr2hBylHxdOx5e/OSEO8QUQa7DCq71orM+u306DPQngm+nRhQ7+qpybd6oUoohklJLc7osI+yqXIbW+KRZwSdfVxuhnyNUyKSj3nDRG2WGWNM+y4gKtRTqSLd0UPQIDoyuQ+FLJpNjDbCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651603; c=relaxed/simple;
	bh=c4l7vgsCiPlwjDlojixYZ8BNCfKDCHUK130X6DBEVF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XjG91rQuE8Ggh2rHP0qdt3TFyCPWnaPhDF3r+/oZSvcEfDot/DFKdpAN+rxfq7NAcvnESTO95Gs+bNODoPGn2vK1es+jDmv338j0spucOMhoHzlprCqV9PcY6FZXieTE4wZKvKC+i3tTuYyGUk5vlNF7CvupJVKQDqQbTarNg6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+Qnn0/O; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fio4+Q0PSh6nEc1seZu43HnFwgTR2bjJU1EU5Tr6ccZ9Umj5/gfKu8ULma4RyPdcLXBvrHOJUbWDpQAgqMoAQk4mjQNJyPcAu+ATcHc4HXIUUErCGhxn1eOpCtvbo5Y6Z7d1Hb93YhH0CNQCkskuvBbOXqPzMyeISwFaYIguEiES19A8R+x1SMP2AT9iBDZhYZKjM2Z6xNNxusExsUIq49eJ1WosbZ7q/TAk3NVsM5vQnI96IFBu0YSXEqrNuZolkr1IRULutFc397bvDLMt7CBV8OEg3hmy/DjaHWMDpdajaGu+AVJE9fBzUWXjWuhU9jQwmsfyxpbmgge5XAU0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsAksY8tKgJAL5UqMjvC8UuFH5j3UO2xnpntrtBDrwY=;
 b=CeVZe/VVqEyRPeLgxMDHdlw0VW0PlhFtbU0PhU0eVPbIq40F9FfQHe94jE133hV4buKgZDh/7u517DmKzc70/U1Mzy8KN/bFAwbtGGoV7wTrmc0oUQ2vtcrJyiIjayFdOLqGnJIEgerjAPE89pW/X7Rn+nKJaFospsFViwcWnYWZkVdpsswnYZeRZGpxR7FpdF6ICj3cqQ6t8BifrsoANJcMhvCOOP1iIBNu4Z/OTkEnKCF+yE+3jdtLp/pkcP3/ElGbEbb6b40IxM78/GzGn0un+F5Tke/+a8cLleOi4mW/yEuYLKjJurnolqpGlZ8hix+45FeP6yPbKuFq6Hl/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsAksY8tKgJAL5UqMjvC8UuFH5j3UO2xnpntrtBDrwY=;
 b=Z+Qnn0/OHE8OVqfSo+VyFKFkVpzCNswaw61WmKltlXqZtUoh79wGdkqYdJ1iaXr2wurUwJP2si5IZAcX9+ANMGAkwn90YMXJdEk5pyT2qE1bCQJec1OApUQLrhNtYYG82zbSIgDyPQ1OYsbNfSHoWzy4+fPPZVMA9m7LQyn+69rftC3qRjhECmgsRB3XelrhO8VAAzaXxgASwrqrEBstqdbk5SpgqLTXOCKEt/u9NkDrqfIce2nvdCQyJrFnNOdpY0QiKN2DiQxakKZqT7g4EKI7DdJy3I7vn7aN7o5jP0EBg8HgrMKfwGmaxT/W/ijBSDiUA77/70godMRaZ+gdTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:53:13 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:53:13 +0000
Message-ID: <29868c1b-5751-421a-9f2b-2ac0f3324904@nvidia.com>
Date: Wed, 13 May 2026 08:53:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
To: Jiri Pirko <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
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
 "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69> <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
 <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agNy3RF9WCHBPev5@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <agNy3RF9WCHBPev5@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1fae0d-1b73-4d3a-2dcf-08deb0b3eb82
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fP9mLpNjb2tLF42igPqA0H59RwqB5ZlikmkKfxB/1e5t4FSncl0mpOCHSm8eTtpx+/7lnWuKEUNRBjatFmOxYOyBLxDP9haDQ76hGpn+7ZhBQPw/R9jm58NLZyzL4AMmJa7/PiQvetrYyjXpJD84M05gUDVKB1+4JetFZxsSnvONvNN4l9Ifzx7/8/x//p6xdlXviBokRwIaZ44jk6LoFKqV68tqQkf7+ne6C0A8pdGH/R/htL1vrB8s/jucbw8rhIepr7/KEZMYqWomw330/7lmVLGheYhGNFjSr4Dnyoa18xA5bqQXr1yZHdccwN3NWa4Mng1a+u5pm5jYBnLiuriuYo8ZWYa+Q9NiCqHIt9B7t0jxkPXwSA1A1pAX6XsIOTHmIDo+gEjTmijepNbbWlrZmIo+adou+jT3BwSGlMIQc/r+hwVzUiexJDvbLG33qN4OU+GnsyxE7IQfvew1UHVj+Mmvr6IPABqkSjznfc4tvwNrEhDMSgWs5t3ch04NNHptpeSqxHe5PiSF3WjlF1IjxGJ3jXZuR2glqQz4gCnjTVr4EtJ0OPu2ZVyGzULBpD/XDfOSGIsXh5f9EzF6DUhGZt4VydVAzQ4T37sF2MXcujh5mSoanXkS0gppWJWCnw0vhmWrcgQC3Bwh1pY8YJVjWtilb6/hI8sarHk7dVt6/VgksJz8W2T6poDM9OTm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkx5MG1hQ3JBaGFHem1NUVJycGVYODBKbVg0VU5CcEE5aHNzT3NyUWNOSGti?=
 =?utf-8?B?M20wNnJpemZReDhWQnEycUgrRHNNT2RXZzRwdCtzOUgwTHNydWxqakNNWmFR?=
 =?utf-8?B?K1NaZ1RjUyswaFgwdTRpRThpanVUMHRjTU1NNnJWemtHWitTUHFDZUt4b2Rp?=
 =?utf-8?B?Z2h1QkdkVEhVOFgrR2RCR053SWZiTXN6cjlSUURWK3lwYmNjeG83MTBRTS9i?=
 =?utf-8?B?aFFmUnFySS9PdVBVMXI0a0ZMUzB3dkc4TEVFcmgzNXdyUUZrOWROMjFVYkVZ?=
 =?utf-8?B?VVFyRUdSTWJaUnNud3hxWnIzOWxERGFISzdORmhuVGNMQk92U3IrZGFoYzZy?=
 =?utf-8?B?YjNYbFhvQXl3dmhmMzJMRnJuK0REWlEvL2xmbThTQ0h2NWJXb2w0UWFVVStH?=
 =?utf-8?B?bU1PdmczNlZSeFI2SVEwYlBQSXU2VGo0Y3dwMEZUSklTSzllbWdBdHY4V1hM?=
 =?utf-8?B?ZXY0TTVBQm85R040c0JBcU9JNldFbFZmT3BycXNHZ2dHKy83czVtcE1XRGNn?=
 =?utf-8?B?Q0owK0JvbEliZzhIYnEwSU5xRW1XVUlNSHQwdTF1MEVKczdycnpGMUNZYmkz?=
 =?utf-8?B?NzFEZ3A1YjNVOVJMb2VRNUJKS0NvdFNNc21lZEpJVVR0UVZEWFdIVVZlQXI2?=
 =?utf-8?B?bDZvei9qcXpWNTdWSmFSVjdjcCtadjFzbnI4SjVKV21nNVRyY2ZNNXphNzkv?=
 =?utf-8?B?TEY0b0doU2RyckFEUGJ5ek1aTExpeUM1enhjQmM1OXZGb0FYMjY0ZE1jOFNC?=
 =?utf-8?B?a3pwSXhzWkdWdlVhcWZ1SXdQWWozdGN5Wk1BVE83N0wrcGVpTUFucFdTVHh4?=
 =?utf-8?B?Q0VNK1R0MVVuQVA5SWxIUSthaHFMbW0yOGJxT0ZFNWhQdXVSTTNDR1h3YmE0?=
 =?utf-8?B?U1dFYnR3NjNhSGZpQy9qWm5EWnhra1plZ1pkYkptOXljSjZFMEpNa04yN3RE?=
 =?utf-8?B?czR5cnF6WHZleUt4aWx5SEVVV09jNVR1NDZ5dkVBTnJPT1NYOGs3WVZjS1Uz?=
 =?utf-8?B?THlWdVlzR3ZvRmp5QkswNTNvOFVuVlB1VlJIbG93aFY0WGZEVXJDRE5Fb3Iz?=
 =?utf-8?B?Z05yQXhXaEJEd3d1SlUya1BNdWtXT0xzOVdKNXlVVUZ1THpsbVd5b3dUanhW?=
 =?utf-8?B?THhxdEpVRWtUeS9WcTBTa2pXMWJnV3ZDT1FKTnpqOWROQ0F0TmVQK2drUDk5?=
 =?utf-8?B?WExZcUxpeXlBc2dlVzVISlg2VnZHZGdHdkY5eE1aMWt0R3lnRVZMcm1XcU9y?=
 =?utf-8?B?STJycXJ1eVpDQlYwOWFaSTRod25sTS9IUkhkZ29abHVKTmwzWmFJbjZ6U2Vy?=
 =?utf-8?B?ajlOanNwL0RtZ1k5ZTRnNUJyWkxFblR0KzRWWUhlODN1WExvbTcveTVNeWdU?=
 =?utf-8?B?b09VN1ppYUt3NTlvUnRKQjhqb1I1a2tBVWh3VzcvZzIvaDlZV3lLUXlOUTZ1?=
 =?utf-8?B?SUxuWTJEYytwanhGWjBhcmh5TENOMVdTcTNTZTdUNC9jRWR1RzFLa0I3eERJ?=
 =?utf-8?B?ZHgzeWhDRlBsc0dGNnNOa1VEV1NJdzdVTVJJYTdQK2p5UFBERUJKZnJXalFH?=
 =?utf-8?B?SWlSdncxVE96QWEvNE5zQlpqVUtERDJGOU5mWTE1MWRSUVdTTm0zNjRrdXdC?=
 =?utf-8?B?MFBlRk1WQ2hpVTBkUnlEa05EZGZJSStiYTJKd3dwVzArQ1NuSnAzcmo4bE0x?=
 =?utf-8?B?b3hIZ0orN3NyN0dZVWI1QURzSm5FcHNBdzFMV3BwQk9Jem84R04zTGo2Q2ti?=
 =?utf-8?B?ZThjUFdKMU9BVFNLL1hIMjRpZzVmbjdmNU0yYVI1U1dTR05rcm1lUHhNVGFV?=
 =?utf-8?B?L1ZmTStpOTBqQlVOWW5Vb1NjTDcrZ1kyRm9TTGttYXJzSThGdzB5cDVIaHBj?=
 =?utf-8?B?ZUprcEY3QVd2ZTYvS284MitMUWs5TFgzeU5iOGRLRDRjeHlUZEZjUlhub3BJ?=
 =?utf-8?B?NDBxMk5NUkJadG1Ed084RCtRbVlBTlBzZFdVMmFWQ0FYWFgwb0RhNWlIbHZn?=
 =?utf-8?B?YjNtNWlwNmxOdGFDMnNKTElXcE5pQUhVVTdrWXRVK0R1L3VzTTBFWE91T0du?=
 =?utf-8?B?TDZYdEdTMHB1c2VkY3NEVW9VZUtTbE1YMHorN29rMGJvMUdnY3R0cVJXUWtJ?=
 =?utf-8?B?ak5jdTE0b0huMFUyTmVvT2orOUt0MWphZW9Cd2JkOHlETkN1OXZsblQvN1ds?=
 =?utf-8?B?a1A5bjJSMzlVT2M0RVk3QWhCZjhxV2RuU1JrSWcvTlJ5RnBCb3hFd1lmTGFO?=
 =?utf-8?B?dnNlZUo2dXdoalgzNUF6cEJQQnNKUUdESFhLb2dCemp2ZmFVUnZsTVB1VHpv?=
 =?utf-8?B?RHlrQXVmZktIMjRvSmkxUEpHOVEwOVJWVzhRL0wxNzZuTVp1d2oxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1fae0d-1b73-4d3a-2dcf-08deb0b3eb82
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:53:13.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cx5awP+9XrVhLnkAziBSI/YrSSDU3mpSa2nUmo/iboJiXwIqdwCu2T28vY6r6M348q61/lZrToJgvbNm0hVLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
X-Rspamd-Queue-Id: 3FBE852DCE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20547-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,resnulli.us:email]
X-Rspamd-Action: no action



On 12/05/2026 21:35, Jiri Pirko wrote:
> Tue, May 12, 2026 at 05:25:21PM CEST, parav@nvidia.com wrote:
>>
>>
>>> From: Jiri Pirko <jiri@resnulli.us>
>>> Sent: 12 May 2026 07:37 PM
>>>
>>> Tue, May 12, 2026 at 03:48:32PM CEST, parav@nvidia.com wrote:
>>>>
>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>> Sent: 12 May 2026 02:16 PM
>>>>>
>>>>> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
>>>>>>
>>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>> Sent: 10 May 2026 06:02 PM
>>>>>>>
>>>>>>
>>>>>> [..]
>>>>>>
>>>>>>>> I look at it from the perspective that from some CX generation,
>>>>>>>> switchdev mode should be default. So that is a device-based decision.
>>>>>>>> I believe as such it can optionally be permanenty configured (nv config)
>>>>>>>> on older device. Why not?
>>>>>>>
>>>>>> Because sometimes switchdev_inactive is needed and sometimes not.
>>>>>> Such knob is not device decision.
>>>>>
>>>>> That is what I would call corner case. In that, user can use userspace
>>>>> configuration to change the mode in runtime.
>>>>>
>>>> Corner vs common depends on users one talks to. :)
>>>> If fw has switchdev(active) as default, and then
>>>> And user needs to run switchdev_inactive, it will actually break their switching applications.
>>>
>>> Can you describe the actutal breakage please?
>>>
>> Driver default was switchdev so all the traffic is forwarded to the switch,
>> and user didn't have chance to setup the fdb rules.
>> So packets are dropped but user didn't expect the traffic to be forwarded.
> 
> User may switch mode to switchdev_inactive early on, before any of the
> representors are created. What's the issue then?

That is the ordering problem I am trying to solve.

On a DPU, the host PF cannot finish loading until the ECPF moves the eswitch to
switchdev/switchdev_inactive. So we need to do that transition during ECPF
driver init, as early as possible. Waiting for userspace means the host PF stays
blocked until userspace is up and has the right logic.

That is not always true in practice, the driver may be built in, loaded from an
initramfs, or the initramfs may simply not contain the devlink policy we need.

Also, after talking with Parav, my understanding is that we need to support both
switchdev and switchdev_inactive, since different customers want different boot
behavior. Once we do the transition, the host PF can load and may start sending
packets. At that point the initial mode already matters: in switchdev_inactive
packets are dropped until userspace programs the pipeline; in switchdev they may
reach the FDB before the pipeline is ready.

So I do not think an early userspace transition is equivalent here. The initial
mode needs to be known by the kernel before userspace runs, which is why I am
proposing the devlink= command line default.

Mark

> 
> 
>>
>> With this RFC, the device would start in the switchdev_inactive.
>> And user's goal is achieved.
>>
>>>>
>>>> So, one needs to invent switchdev_inactive in the FW.
>>>>
>>>> Jakub's suggestion in this RFC is covering both the scenarios uniformly without above problems.
>>>> Single uapi for all the cases, so looks good to me.
>>>>
>>>> Moreover, do not understand how alternative solves such problems.
>>>> i.e. user is unable to configure the fw because driver is not yet loaded/up.
>>>
>>> See my other reply in this thread. I don't think there is a need to
>>> configure anything in FW. If we fix the behaviour in switchdev mode for
>>> non-sriov user and change the default, no fw knob needed. What am I
>>> missing?
>>>
>> If I understood your suggestion right, is it the devlinkd based solution?
> 
> The suggestion is to use "switchdev" as default with user configuration
> no matter if it is devlinkd or something else.
> 
> 
>>
>> If yes, then Mark explained that it has the issue of all drivers to be loaded, followed by user space to start.


