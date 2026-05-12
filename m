Return-Path: <linux-rdma+bounces-20501-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIOGLEdIA2pU2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20501-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:33:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D10523B3F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA29530479F2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E63BB66E;
	Tue, 12 May 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MmEeMgqR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F733BB680;
	Tue, 12 May 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600003; cv=fail; b=mMs4/livRnvLo6pYbC/+UPdJJsuP0a7YyS+57HzeHz6me8bXubDYSgzTH7ZEe1mWnls2cl83VjMszbX+8/atJiONoIyE0lOs0s71AoubJsxz9RJqCaE4IB7Yp5hdmz0trjh/yLQ6UC90Qswn3L4RJA/rw7v+8sVY6pB13n8TcAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600003; c=relaxed/simple;
	bh=7/M8qMhfAOkDQ+CC0wfVd3k5RWFevUW7kORBbugOj64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/vAjncsgyCZMIPY1a8BmruWIfWlMi+cU7YqrsQwAQZRIC0xvcid4fn5XYctGblHp5bfZKwhwb9XSZMTIN63e2UxD7Vel/58P1Qz+cKoKZEeuDnCCsBwr/7K4NKiwY6yE9Hwf1a70iXq1EfIDroIWryTJBVs+EYgnRdvVODXsRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MmEeMgqR; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6F0kzEWCFlXFcGx/AeCmR9SaoHhFkW+x7A66jDuzCPoOt1aFaC0w9Br+T03N+AQ8U+wp0t4Ke3CbQHJD0gcwxy++bIS0Zje3YrwbNZyaWnu8SQyBkYpIEjij7wCBfE74H6AMbarwOqR+yhSHLD+1Jj9q45ZZnP9gLCYkoShfg4yGOjDVrMYoJb42iEatO2zq2KfYVbM8M6dtX4dmNYAGvNElJG0u1PqFU5NE/G4ZoFcEYAMDpdoqix2/RCqRXT80/RRQuqoSeuFtAOvExEBvBg+TWII3qeqxfpQQRiicsOX5q2nt1jxhUmV1EIR8/4QnUXcke3GJ0qx61l2YQo0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SJG4Ubv6q03zfFZH4HtpuHypnCw6yKySKwps04g6pM=;
 b=wGap+6EuWfIsf6qGZAs+qsGn5jGG4x6NRa9Uwn8q29DCz2VepSg9+0RDF1qKcfi9UpR6kPASJfpdBM3Ey2aG+geI262+lOghgnXCjZ0F9jrBs99+8gwjMof+q+gWLVb0n5NEnXH90yaKHQeS01G/26SmDaasuTV/baPT+pCQ0zTpQNwDBvAOzrifF7073FSEq40bOY9Ob5H5+rAruvZ449Ku47wowbc1K9p4MZdF+OvYoXNn9aYzgt6rjcTKmp9Gm2DkWQZI7yB/QGhJ5+HcLnZTSmG/2P/g/abv4+1SIDQE8oAUboz0KGwmcw/dPP2TeSpT+YyGHzzPKslGVk8Rgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SJG4Ubv6q03zfFZH4HtpuHypnCw6yKySKwps04g6pM=;
 b=MmEeMgqRzrWK8J/ByUgx4OeFsvcNDgrqp3I1fzTXesQdtFgr53syhJxuJ9Pwk22XGKGANAnA6bNNFewWFt259bBpg9Xu2AbnuXmqPLHgLzjemj8YQr8klTt79VyyIcI2c9jlCwccFPD+luoC4ENjrp1VIJYf/ApB4NNyk86u5qlPViSsPFIbWXTy8sws3a5bw7TRw16ecH1jz+UwkU2p6cgPAvSEZjpXISnN/1DuW2LY4WuGm6Ri63sRVcwSb2BWjNhxhNjjM8JfLVzGqU39OaDlsO0FQ615Hwt8K3+TQC5D6FAEPzrGlmb35o91/KhEFd8GgnvjrEsS6lJsGukQTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 15:33:14 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 15:33:14 +0000
Message-ID: <47630ed4-3028-4716-816e-d4f803423b37@nvidia.com>
Date: Tue, 12 May 2026 17:33:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>
References: <20260507095330.318892-1-tariqt@nvidia.com>
 <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
 <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
 <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
 <70d0b319-178f-4233-b0da-9618489a1dd6@nvidia.com>
 <CAMB2axPdqBUORn7Qy35Xccqbn+8aArZ-weegZyz=j0STh+iPNA@mail.gmail.com>
 <6b7998e7-b2c1-4650-9564-679d647146cf@nvidia.com>
 <ef926d49-81d6-4d26-8d74-440d4a6bb8b1@nvidia.com>
 <CAMB2axN6USwsGaUQWkL52G=9V=kSe2La_gE-ppOFLWbPCnaVKQ@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAMB2axN6USwsGaUQWkL52G=9V=kSe2La_gE-ppOFLWbPCnaVKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1e9ea0-5f79-4d86-66b5-08deb03bc851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Hx94CPdz98AjU3nWGYVIUl0n7MZlYo6RkNCRG6cPHmL0AA6wQojgLEZc3q8a3HXcUSonYAghRJZwPIAh79yl6i6iCynWzsxCYBDjmLuP2q29CqXWne3x84UEkX0YwlnDToy3Z7Ka9emqRc7yyEtUBv31XkqJ3Djbr73o6YhfexTRSqjer8eEQShbSsW4wZKhyhT+FHzjfhyn3hRbEljG7Yo0X+btHsieprX1Z4i0DlPFuu9fGDhELd1LMjdWoD9EqP/sOGu+ILqdViJHL0MHjxEMNS9nYNJYFXH77/rIdMH0nBIJardwUKD1kfQi0+yK9lMzhLD+Nem1We/ApkaMvd8JQnchix6RVfd6GKoFsw2SWc9n6pAn0sIHwzTQ4LN7OuAhnKwIGDDvcPxTZ+ALknoOSXZiWDFxZG4IOytlA2DsEyAuCpEeLnTcCjNaxXh05uv01xtBxLDSMUt7AnUPpsLIXF9aOoFz2hxBOPyOG4OkPRE7u4ivu6djGAsCRmCpg5lhP9HxaJdHhyKaHfsMsPuPFlIf1TkvILRJ+8S9s/Mtd0NE46my/3xAZstjnZr/HYPaE42fsknPGquwfDyY6pXfP6yGrIWeIxtg+YAhucIe15g+twou3dXTOr0s5qKSWfwvyfBWw+EP6OWwYrAvvXNzrE0UmwvTue5E7e1E5HFsU2N0sVo8Bq3BVlTwLYEZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(11063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG9KMHhSUHh3SjV5ekJGMkppLzZOZXlEL0xmZEJpZ2ZTK1B4SXFEU3ZKTTRk?=
 =?utf-8?B?c3NFVGhISHBqaXowNWNBUG9iaHY5OXdzWTJoU2JBanRjNTMxdUVscnRkWVl6?=
 =?utf-8?B?dGhhdzEzMWNvNFJiL2g0YU5nRWFXM2F1ZWN6UVJaSmI5bEZNUFI4bUpFeTFr?=
 =?utf-8?B?aUc3UzRhZXFoZ0c4WERQcnZoTThnL2VpWnFWajg3eSs3TENSUGM2MHlvRktR?=
 =?utf-8?B?Nyt1SlRYSTlROXdSaHVGdlREcFI0NlNSQlpyYldoNTRKNWpEekNoL1JFd1lO?=
 =?utf-8?B?Q0ViblE4R3pHajJwV25vYStPVDNaTkRlYVd1UGt2em5hY09HWHdGTW1UR01z?=
 =?utf-8?B?aFV5SVFzRWd3OEJPenZnK2F3TDR0TTJyN3UwYnJlNncwWVlFcDQ3UzRIeXl1?=
 =?utf-8?B?YWZsSnhyYTQ5YWNjOGpTWlhkQ2xsYzdmY3hXVGduWXZma3NPNDgzNWZVbHJy?=
 =?utf-8?B?djRXMXdydW1NZFlEVGJCaFR4MVp6dWlqa2ozK0g0Nnp1UW9kVXBzY2dQSGRW?=
 =?utf-8?B?Q3EybXhwTXRDRWFIOE5NeE9KNGF5aEZrU2poZlNPWXRzeTYyVEtkbEZNVXdk?=
 =?utf-8?B?WFVOanVmMXR1cGdtemY0M01qbm8xOVNxRERqZTdMOXkzSUtEZldEQThmVjNP?=
 =?utf-8?B?b1h5eVh2VFFtRzhEek90RFhiajYxeFRNbEkvRmphT3RHRmpaM2Y0OE5ld0xV?=
 =?utf-8?B?T0xONmhUT2Fick8rVVd5Ulh6cnh5bU0vVEZRVHdLWHVYVWxjbUQ0OERJaURa?=
 =?utf-8?B?cldXTWEzayt0TVdkdGdHVnh0c1hkZk1McEovNzFzMEROQmFWSnBtR3BCaXJ6?=
 =?utf-8?B?bnpmVTRyck1WZXcyWW9uS0NsUm9sSlAyazNIQkZPK2dZSm9lSlpMYUlGV1B4?=
 =?utf-8?B?anlmRElCdzdXWFpCTmFDK3RKWjNKSDhmMlg4anQ2ZXhJODY3dTZvU3N1T0d1?=
 =?utf-8?B?eUhjWXFObTRvTkwyQWtVRU1qRlhWdVpyQVA3QllzSXRvdVZDRC9HWGNuMDIx?=
 =?utf-8?B?MGswQXdYdTlITEtPYnlFTHhneGtRY2RXcnk4ZE40eiszSUwzSWNpSHFFNHRQ?=
 =?utf-8?B?SWt3THM0WFBid3J1dGVWdVMxNGU2SGNiVW5vUWxlQkZPQWJKbTEzbkhEZmhh?=
 =?utf-8?B?ZDgzcEloeGZhblZmc3VhVXZQR2NDMDl3eHlmTDZYYzNLMjR3akh1VzdNbVEz?=
 =?utf-8?B?NjB1WCtwVTM4ZXVPVUZtVDdaMEp5V1JxNjMzcWtPVXRMRERjZnhVbm54VktL?=
 =?utf-8?B?bWFLZzllaFh1QjVFUWVjdDgwcnB2SmRIOFNETWFoV2s1bERWdm9hTjZZV1ZB?=
 =?utf-8?B?TjhSbC95WCtSbmFSZFN0ZUlXTXNubVZER2tqZ3lMYXlzdE1aRkwwRHVoT0Jm?=
 =?utf-8?B?MVRTaDNZcVpHUER3cW4vY1ArWkhkMVhvWHFCSjNUMDBWUC9wRUE1S3hXTSt4?=
 =?utf-8?B?NGxXWEZyUHhwOGRPbTh4bGRnZm5WOFJWWTYvWjdBM0w1SFNNSEZxby9Kbldk?=
 =?utf-8?B?Q3Y2MWkrRVpUdW9XMTBYell5MktzQU9oaTVPdnVPMjFlUVlneGh5aVNLdWtL?=
 =?utf-8?B?emtIM3ZscXkwTFZmZ1c3TUxGRTM0eklUeXh5ZmlseWZwTXVhUTdObzdYSXoz?=
 =?utf-8?B?aC9CeG54em5iS0JuWlBleVpCTkFLVWt2VU5rVmo1RlpBUlpXdFc4alBPSW81?=
 =?utf-8?B?YWNYMU9SR1FuVHZiTG9mRzdHckJXV01HcVBiTWNTKzdZTXJnRW9KbWFhWFBC?=
 =?utf-8?B?Q09oeDVNWDREWjZoTjhSUWdoQUdiZXFqS2hCYUpicG5iUzNSYjQwZnFRVE1P?=
 =?utf-8?B?M3A3TlcxNUJXeE9ybUx3NmJnbm1JU2txV1JRTXdsTUFScC9CWi8zMkxyeUZl?=
 =?utf-8?B?bC8xTldycWZpWDB4aWZwelpWOWJ0VFdMeDc4VUJXNUxINEZKRlJmMDB5dm5Y?=
 =?utf-8?B?WkRoYU03MXZkUlo4Zk8zUVVJOGlDWlo0M1lRM1YzK1hkcC9FQUV4a3BLd0pE?=
 =?utf-8?B?TjR2Um1mYStwSDdHdzdPOHltTTdLSDc4bzJvSHpXU1ROTnczQXJBQU1EZmZu?=
 =?utf-8?B?KzZ6K1ZPSFg0SzdGaVhic0UzSldYc09mMmVjU2tFRG1VVmNjbSt1SmVvM3Fz?=
 =?utf-8?B?VE1YRUEreCtoTFl2QkZzVjZpaU1pVFh6ZW54TldsT0ExZVQyb0VLb1djSUFm?=
 =?utf-8?B?SU02WWVLdURPRXNmVVc4Ujk0a2c5WndZdytWaWNpRU95TTZ2eitkeUdFWnBa?=
 =?utf-8?B?ZlhXYkdCWllReGgwaFRnb3lIM1RESkRZMWZ5SVgvT0oycjFXODFEK2JxVVRv?=
 =?utf-8?B?SHhJUEJYdEpiRW0waVliUlVTZ0VuVStCaldrNXVoZnZJTXlhVjUvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1e9ea0-5f79-4d86-66b5-08deb03bc851
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:33:14.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHWPsVDXy/yRIZj/IOQO3So9twhBM7+a4hZ4XVZ+CKJKh04kJpac6BOXry/B+pNiGkSuQJgrzbAz2xJHzda6sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
X-Rspamd-Queue-Id: 62D10523B3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20501-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action



On 12.05.26 01:08, Amery Hung wrote:
> On Sat, May 9, 2026 at 11:51 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>>
>>
>> On 08.05.26 20:42, Dragos Tatulea wrote:
>>>
>>>
>>> On 08.05.26 19:44, Amery Hung wrote:
>>>> On Fri, May 8, 2026 at 2:15 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 07.05.26 22:50, Amery Hung wrote:
>>>>>> On Thu, May 7, 2026 at 4:50 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> Hi Amery,
>>>>>>>
>>>>>>> On 07.05.26 15:53, Amery Hung wrote:
>>>>>>>> [...]
>>>>>>>> Am I understanding correctly that the better performance comes with
>>>>>>>> the assumption that the XDP does not change headers?
>>>>>>>>
>>>>>>>> headlen is determined before the XDP program runs. If it push/pop
>>>>>>>> headers, there could be headers in frags or data in the linear region
>>>>>>>> after __pskb_pull_tail().
>>>>>>>>
>>>>>>> That's right.
>>>>>>>
>>>>>>>>>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
>>>>>>>>>                                 struct mlx5e_frag_page *pfp;
>>>>>>>>> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>>>>>>>>>                                 pagep->frags++;
>>>>>>>>>                         while (++pagep < frag_page);
>>>>>>>>>
>>>>>>>>> -                       headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
>>>>>>>>> -                                       skb->data_len);
>>>>>>>>> +                       headlen = min_t(u16, headlen - len, skb->data_len);
>>>>>>>>
>>>>>>>> headlen - len can underflow but will be capped by skb->data_len, so
>>>>>>>> this should be okay, right?
>>>>>>> It is safe. But it might trigger an extra allocation in the pull when
>>>>>>> len > headlen. We could also skip the pull in that case. Or do a
>>>>>>> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?
>>>>>>
>>>>>> Make sense, but this line took me a bit to understand. Maybe consider
>>>>>> checking len < headlen first?
>>>>>>
>>>>>> if (len < headlen) {
>>>>>>         headlen = min_t(u32, headlen - len, skb->data_len);
>>>>>>         __pskb_pull_tail(skb, headlen);
>>>>>> }
>>>>>>
>>>>> Yes, that's what I had in mind when skipping the pull. I would also
>>>>> tag this as likely.
>>>>>
>>>>>> Another clarifying question. So this patch will improve the
>>>>>> performance when the XDP programs don't change header length. For
>>>>>> those that encap/decap, they should precisely pull only headers into
>>>>>> the linear area for optimal performance. Is it correct?
>>>>>>
>>>>> Right for encap, but for decap not quite:
>>>>>
>>>>> Let's say that the XDP program pulls 64B header into the linear part
>>>>> and snips 4B of the encap out. This would result in a pull of an
>>>>> additional 4B (headlen (64B) - len (60B) = 4B) which are now
>>>>> data bytes => sub-optimal layout.
>>>>>
>>>>> I don't see how we can improve this corner case though.
>>>>
>>>> I see. Thanks for the clarification.
>>>>
>>>> I think the "if (len < headlen)" makes too many assumptions about what
>>>> the XDP program did.
>>>>
>>>> How about this policy instead: If the XDP program did not create/pull
>>>> data into the linear area, pull the parsed headers; otherwise, assume
>>>> the XDP program owns the geometry. min() is still needed since the
>>>> program can shrink the packet.
>>>>
>>>> if (!len) {
>>>>         headlen = min(headlen, skb->data_len);
>>>>         __pskb_pull_tail(skb, headen);
>>>> }
>>>>
>>>> This preserves the optimization for the default no-modification case,
>>>> and most importantly allow XDP program to get the optimal performance
>>>> if it gets the final geometry right.
>>>>
>>> I like this. It will also save us some neurons next time we need to
>>> touch these lines.
>>>
>> Sashiko disagrees:
>>
>> """
>> If an XDP program changes the packet geometry by prepending data, len will
>> be greater than 0, which skips the __pskb_pull_tail() call entirely.
>> The resulting SKB's linear part will only contain the prepended data, with
>> the Ethernet headers remaining in the fragments.
>> When the network stack later calls eth_type_trans(), it unconditionally
>> pulls ETH_HLEN:
>> net/ethernet/eth.c:eth_type_trans() {
>>     ...
>>     skb_pull_inline(skb, ETH_HLEN);
>>     ...
>> }
>> Could pulling 14 bytes from a smaller linear area cause skb->len to drop
>> below skb->data_len and trigger a BUG() in __skb_pull()?
>> """
>>
>> So I think we need an else where we preserve the old behavior:
>>   if (!len)
>>           headlen = min(headlen, skb->data_len);
>>   else
>>           headlen = min(MLX5E_RX_MAX_HEAD - len, skb->data_len);
>>
>>   __pskb_pull_tail(skb, headlen);
> 
> I see. I am okay with the fallback.
> 
> One last question: if the fallback is mainly to preserve the minimum
> linear head needed by eth_type_trans(), can we make that explicit
> instead?
> 
> unsigned int pull_len = 0;
> 
> if (!len)
>         pull_len = headlen;
> else if (len < ETH_HLEN)
>         pull_len = ETH_HLEN - len;
> 
> if (pull_len)
>         __pskb_pull_tail(skb, min(pull_len, skb->data_len));
> 
> This keeps the parsed-header pull for the fully nonlinear case, but once
> XDP leaves some linear data, the driver only pulls enough to satisfy the
> Ethernet header invariant and otherwise leaves the final geometry to XDP.
>
That would work, but maybe with one less conditional:

if (!len)
        __pskb_pull_tail(skb, min(headlen, skb->data_len);
else if (len < ETH_HLEN)
        __pskb_pull_tail(skb, min(ETH_LEN - len, skb->data_len));

Tariq suggested to make sure that we have an xdp selftest for this.
Will take it as a follow-up after this series.

Thanks,
Dragos


