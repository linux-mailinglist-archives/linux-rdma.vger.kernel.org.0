Return-Path: <linux-rdma+bounces-19987-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEzrOpCM+Wkc9wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19987-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 08:22:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B944C72F5
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 08:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A3D23021D1B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA83B7B98;
	Tue,  5 May 2026 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASRjA/4A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9E3C3430;
	Tue,  5 May 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962118; cv=fail; b=VwPdSUSKZ4YmsCtDgCwVGfDkND0UkljqXVB/WMIgEiEfEq/lpDX/5Yj4F4taRS1AixKHlK+c7Q75qFhedwj+AYjgLLEKV4hJf5dqORFWdOl45i30HITH4NMIcphPFTch2CLTnVhyjfExVj/+f90BRORnt4AuLzd+Nj0/V1PtObQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962118; c=relaxed/simple;
	bh=CBecGgL3u8CdOK1UW3h5Hs0bawXBC7bf+0mJBy0DkvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAKzAL7Ws3Eln5wUzB/ugl9aVC0XOH5qYtbYUjcm2+DmRoHfebzsIRbFE7LK03hM2Tmc56bGpQEs9U3xG6P+HTJ3h2s9LSKtFkfofrMu7ZlqNOD72vq/5+ZUXPyay15tToNm5mvmqxpz0lWcrKFkYjRT4rJ3kNSn81CliLaJby4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASRjA/4A; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNzznHorRyv1C9dBv9fxR7UWoKTLNimrHgI2CmRlkCNsRq5Vz6ne5uEmZUuidFnCOMraChz3qKVriUeLVvVf3cgWdkqMr/Szrlt9UWM99K6Qyk5C4qaaECkpvYWjpb6A3FRMjakxitQe14hnN/SozaYSBrFw0AVP8XKI4Awp6RpHVWo9V8fAByiG9KWbmcbfajFtXsoMnqcvaHe6OO8aYuhAicxxYV/3KszHEX6qrOECz7rT6s28oXee9BigkzbA2EGWfwmn1LhCECS9jT8Cl0gktsVKK2HxhAYkoqwl4kzywIHlLC69X8ajfAzQuYkvM7LYJn5GX+vYhy6y2NX0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5p57+glsY9MSocEJuUHzMb4Z3+cE1asqTdc7qXN/oA=;
 b=kzyTBXCAsY4gvM830lMMKwkpDrZb030nmZMTLW1TQeP5s1iIJfYQchGBpxST2LBG4r6CLsGcwLsclvEUfUAhA4lK2qgpMHhA/KQXe81xKuUgexyB3k0RScENluuxq7GrmX7YiSXd4m83kN6zzlgrepjdbJdr0cXq1hYBI4bo2MKuhEl13l4WOC2CMrxaX2MPPTnretcPpZ41afcEiEY6SZdqiWrFtj6fDgo8aGA0nSYL8EDeG7xITr2gFhgrw7MBlKekeMJnNrAhnU/i2JFoBO5bWIncgiVB68aIHRTHKdTAccrgyu/Ml+YfEXGWfgM5/m3FyushfAl8DFesF0K+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5p57+glsY9MSocEJuUHzMb4Z3+cE1asqTdc7qXN/oA=;
 b=ASRjA/4A4hZRccRAuL470dsy5zIqduOhbj0zsG4qniX72RHBBbLWKAEduzRjdnldP1Kb6HNZq6jOCihpJsmRDdbPQH4Rqol1OGF8vgnx0uTCxGGOKbjZowKFAdu8tE4zjMAH0yzC572zIhqes9CFwoiHLzs5LPYJ1R7LKwbw93Y5xbTC0wbx3dICoWGgs0JTx8IRjARxP00Rog8RhlUP2To60VL9J5phrxFHNmvT4961nl88GmGSmpMalc0TxLWxKmuBdyJHX3Yp1uVGEZIu1TkLmG+Yl7tiiCLSDB+C7TevWhvZvHa/Gi0cMagAwnFE7iOHCcJdci4zCIXF4koSAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:21:50 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 06:21:49 +0000
Message-ID: <c2258e70-4c2e-4999-8876-ad98f4259eda@nvidia.com>
Date: Tue, 5 May 2026 09:21:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Add MLX5_VXLAN config option
To: Jakub Kicinski <kuba@kernel.org>, Marc Harvey <marcharvey@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>
References: <20260428-mlx5_vxlan-v1-1-cf666d042618@google.com>
 <20260428184631.40f1f1b7@kernel.org>
 <CANkEMgkBnuRfurKcFEUAZcJcX1XYSnHbBozZGP8DpnKq--tWbw@mail.gmail.com>
 <20260429190150.417b0302@kernel.org>
 <CANkEMg=Xc9jN8McZmLerK_ffOwRFfX+yO=4Ha6+umVogbkBj3A@mail.gmail.com>
 <20260504181022.60ee2a1a@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260504181022.60ee2a1a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5db6c3-4aa2-44db-de3c-08deaa6e9746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	76z/VQfaBiJdjT+hW3W0ewAwonKOu0SsoyaL/9JFZn+WDhSq4gP4OGvhHsPC9CGVeMslF2gWprW83ebWZOT32Id06cQC3ksgbkmxxT8jWFo3KbI2T+sKdhwCsv6sEXxbxyophPWTB7MO7DzMKkru3s/9UJuCA9Vpz2N7hjVgj7UGCNgHLFbvJhXq+apXXkK5g4C991oeaHLX0B20TcpBwpW6ySYBhZxzcuDpYGbH8Dqo1qqR7f4sTgcUYzze1TBC4PQkSI2ziZIgmUK7qRiDX+6wCWSNoGIdKOl/kfGdoEp73VHuZHlQZa1pohCdG0AwN+PV7Axi15ZVWYLa4fvxAr3evP2sWkd+mKHXHlFbjugGyyftyTlsPJQA3WG/JcHZRM6ci4GSUik8knH7iocJVUI/QkBH3j6WeGNIFtLyPaMn/iLUliH52WU4CXtj0G4Ho+SybdEn8lw+emuegCfWEV/AK3En3OpfZey/GnVzP0o66SKLgZ7Bp6d3a2wNWqSZhiK0uYeDvM6yzhhlvyDcs5fhEKYKAJ0sAQ3d0mfUJoQkrM+SoIPnUBpz9WpRVuebbMze2dWDAjeAjRXP7On6Q0voFQU/elh8/33vBBDQqsLA/kBA4QvHi2PFDVPQMeubqTEHXVFxfOR5HUGbjlAQukVDlDQCFprppYMHZQrrYtAGgTZY4ruF9PbSU7Nm0h89
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzNtWXZia0hmYmZGWCtINkxGOHVmQWxnWVVYQnR5U3gxM3QzYndCYkJ3VlQ1?=
 =?utf-8?B?NXlTVVhhajdWUlZ6dnBWQTZ1NG1PTVZuNjJ2b2hMYWhxNXNvRGZpNVRxcmQ2?=
 =?utf-8?B?WDM0c0QwcEdEOEZWRXB4WGM5RXMvdExvRVI3OEZjWGhuZUg1alVWeEJvUks0?=
 =?utf-8?B?elRrWWVjakd1L0VHQW5IblJTdnNxMVhTbEFjS1Fla05BYlpFOW9KMEw5eEZv?=
 =?utf-8?B?d2dIbCtkc2ZLQlEzOHYxUHcvVktJaFpKSkx1dUIyNWtLcFk2N1ZiWlNyQ1Zh?=
 =?utf-8?B?UFU4d0F1R3crYWM0L1NRSXBFTG1OM21hbkw3ZVhGdHJ2dFEwVUUyWElrVFky?=
 =?utf-8?B?NDFVOUV3eVU0bzBiajVTNmY1VHgvcUNGVHZ6SFJkQ3R0ZFAxWkVpTE9GSUZG?=
 =?utf-8?B?UUtjaHh2RlFWTDAvNStuemlsOStsbVd2RUhrNFpKcTdoK1IvM2dWWmd3UnhK?=
 =?utf-8?B?aUdCdUx6M01EZEZxbnpYbzRDeUthanJpWGtxdmpocmdpQWhzZDNpbFYxZWpT?=
 =?utf-8?B?VWozeDRuOWppMWZZZUtoQUhNckUrWmYwSTc3MHBPZVJaQ3A5YThFTkhHU1RK?=
 =?utf-8?B?VHhTZlBILzhCcit6Ly91MEdVc0N1cDRpRnZtQ1BoMktoZGhvZkJjcml1a1cr?=
 =?utf-8?B?Nzk4bU1NeU56SVJHV1c0bjRMc3Q0NE4xT0ljdzRKYVFYZy9qTmZITlpLNkNQ?=
 =?utf-8?B?Z25PazRGMEYxYm9lTkhDcHVFSmZKaXNlblA3Rm8ycTJPQ2s2bnprbzY4Y3ZH?=
 =?utf-8?B?NGhVU0VkRkdKZUhmNlkxNTFmd2FpREt1TXE2VGJ3d28wK2VXQjc5ajE3K0xw?=
 =?utf-8?B?bmpRL3RDYmxibDhCNnlkakoxb2dldHluTzBrQVhESTlqK3FXTmI3QWk1TDBi?=
 =?utf-8?B?WFptTE81YlVsLy9Pb05KSmFPM1Z0WC9rNTFCM3duTWh0bkoxSW83aXB3U0ll?=
 =?utf-8?B?RzE1VkdacnlEVGdWMnkrcC8vQmVqZkdjWXgyTElmNXM0ZGV3andtSWhrOFRs?=
 =?utf-8?B?WksyRXpZczhGVWhaWFR1UlZMS1kxMW5mNTdMMUdYT2NHaldHL1hwbDB1TXFC?=
 =?utf-8?B?L0lPaUhnTFlnNjVYL202T3NVNUNGaGNuNmdscTdaK0VReHlOcHBFY2Fpcm9V?=
 =?utf-8?B?K2NiZyswNkZmWTNLa24zdVJPZ3Nma3Nadkl5UjFMdXpMZnA2RnpVNlBYYkdj?=
 =?utf-8?B?elUwR2swc1lLbk9td043a0tkQmNoWVJiTkNJTitaTEUyakRJN0ppMmdHTW50?=
 =?utf-8?B?dVo5NklvZTV4NU4xMDQ0VEJ4MEk2Vy9aRHovUytCZGpsdW5hT05KM2JDMkZu?=
 =?utf-8?B?V3ZOUGxiMDJpS2JWR2JUMFZpOGczS0F5NWlwd3VZR2ZucnZDUEJYMGpPY1FU?=
 =?utf-8?B?WVJRT0VRR3NKZTZYU081SmdwOXV6L3VUN1BER3NqbGkxNzNmZit1TzBQd3pq?=
 =?utf-8?B?clZybTZtWmRQOEdYUjZ4dUlGSVNtMTU2ZlF4UXNHV25jNVZVYjlidVpYcTVM?=
 =?utf-8?B?N0Zpb1RibC96TWpiZExSQ0VtUk1SQnkwTXdrazMvSTZhUHRlZmpCdUJ1S0FQ?=
 =?utf-8?B?L29kWW54bys4aWlSVC9BN2FqK2hoSXQ4R2svU3phNFFkOUVMclltWlN1NXpp?=
 =?utf-8?B?SFdFa2FBbW56dlRkWHE2aGdOMVJjb0NhdHdjb0ZRUHAwY0lwQzA3dTNtNDBw?=
 =?utf-8?B?M2dRZFVOSlJ4UWl5M3pqYnorN1V5TG1HU00xTTFFeFhCaHFBeVcxeGpIdjZj?=
 =?utf-8?B?WlQ4OHkxUk0rNXI0Zm9WK0tacm5tUEdmMk9GOTlUUjdTSDRjcUd2cUVHZ1JS?=
 =?utf-8?B?WnRDam44TDBSZXRScjRYWXM0NXFBNTF3dzNlUlQrQUUvSEpxdmMxSTZWUzFW?=
 =?utf-8?B?WW9PMlQwRHNHL0tHSVFSQjM2N3pCaWl0N3JUQWVXRHE2UlVEU0dHZDhCaGhj?=
 =?utf-8?B?aDJWQjZ5cG9DaGZ5ZTZyQnh3amU0L3ZueldJWTRrb2tqeCs2alZtbVdzTnFB?=
 =?utf-8?B?VnlTQjNqcCtueXlMZjdhVkkzNFdZWmxidGZjb1RublpEa0ZSMVNuUHdRME5l?=
 =?utf-8?B?QmNOYlEwQTcxNlVrcEI3VE52ZzM1N0lXRWpienhCR0dCSHhwWUUwVjBUZFpM?=
 =?utf-8?B?UWxKSGhUZW14clAwbXJWMTBhbjAzMlduK1NjQ3ZsKzhacE5XMlN6MTk4QW9X?=
 =?utf-8?B?V0FZUU1rQTROZHZWZkR6dFNpblhRYnB3MlpFb0RhaFUyRW5MQnIyUDhuN3Yz?=
 =?utf-8?B?V1J1RFhyRG91OWJRS3ltTUlUTzQzL29pSG9yaUl5d3oybkhvNVVHTmJDWWxF?=
 =?utf-8?Q?bLK6znkJSfJpKXNn+0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5db6c3-4aa2-44db-de3c-08deaa6e9746
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 06:21:49.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+7CevzAlc+btRWWbULX5OZclB20TpV8uouNL5MtOG99b1QPKBxCvKlv769d1ZSJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
X-Rspamd-Queue-Id: 82B944C72F5
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-19987-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]

Hi Marc,

On 05/05/2026 4:10, Jakub Kicinski wrote:
> On Mon, 4 May 2026 15:44:26 -0700 Marc Harvey wrote:
>>> Are you aware of NETIF_F_RX_UDP_TUNNEL_PORT ?
>>> I haven't checked it does exactly what we need, but I recall there was
>>> a ethtool feature for this..  
>>
>> Thanks, I didn't know about that feature and mlx5 uses it. However,
>> mlx5 unconditionally sets the `UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN`
>> flag, which excludes port 4789 from the entire UDP tunnel core offload
>> management (see `__udp_tunnel_nic_add_port()`).
>>
>> So using ethtool to disable `NETIF_F_RX_UDP_TUNNEL_PORT` will not
>> disable vxlan offload for port 4789.
>>
>> I think a better approach would be to just remove this static
>> automatic offloading for port 4789, mlx5 is the only driver using
>> `UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN` anyway. However, there might
>> be a reason for this, such as some supported hardware offloading vxlan
>> on port 4789 by default even without commands from the driver.
>>
>> If mlx5 continues to use the `UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN`
>> flag, then some change is required to fully disable vxlan offloading.
> 
> Sorry, I don't know mlx5 very well. Sounds like you have to talk 
> to nVidia or/and run some experiments. The current patch is a no-go.
> 

The hardware offloads 4789 by default, hence the
UDP_TUNNEL_NIC_INFO_STATIC_IANA_VXLAN, you cannot simply remove it.

Have you tried disabling tx-udp_tnl-segmentation through ethtool?

