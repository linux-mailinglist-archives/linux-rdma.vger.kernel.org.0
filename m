Return-Path: <linux-rdma+bounces-16560-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIbdAUJKhGk/2QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16560-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 08:44:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AEEF8A0
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 08:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09243014C2A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7C35DD03;
	Thu,  5 Feb 2026 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dFz6GdHi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF635D617;
	Thu,  5 Feb 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277430; cv=fail; b=peJquxI3uKKQGpURUqhhx3sgkmA8Q704fCQVDhOeGCbjYjJDsKhIBoPYewtMVgjagtKofyVBdAhXcBuUk7PFCC8EtTOtwmCSNF+ezxI2rjBoMd7GVN1zEbZK6D70jYweCgZD4MBXAn4Gn5MbBJFV9Zw8yzPlfh2pBPAHUxVlrhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277430; c=relaxed/simple;
	bh=J6D9bt8XfJqUNMGvJvsV2gLwNV4l+YLXug16zbhfwDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r/jHFxLzXl3gyvk7HS7IkATCTsKq2xFaymI+zAqYbc+PGsbwZ1Wul+nNDcKZd8rOamPnlFF2D40Tv0nXY6YaPcTMxtVJ+EojV83A9NcpPyzZerh3Bpfp2s98RDEsprMb6WppeIa8qyz1YGruU3BSmGzaVWNhDiP4wT6q8xkcSOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dFz6GdHi; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq3zRm+m4UdRMalP0uMu8bRzaAaSBEZ69VuB7SQXlHUoDxDuGAemr2vEFDVNMvIoWIaMuOUST6TE/OtnqFTmLmpxJxYOOKXZOmWhmTf3coIV0OuPo2vKSYlripYUqDYPiPp20P1eHvwZzRuSuAbf9Gid9TthI2jPqgeYF1mMEiVGMZhQ89+6TATAVA4JV0FyJ/6zh9ZZmVW2Exoa5b463P8mXtTm6bNqyTZkPEYd9flCZCNEo8h6FbHWqpUYFitQ53S2SHz9LiNENMOGQxvrIl51AzzQzRCNSa8IKGGEXUnFBENWavg/Iozik9wWzktAp5FtKtbGa4CzAeABUrxNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmSbDkKUK3etPOXdpxD6R3kvhCK7u2zCKJ0METAU5lg=;
 b=LnKqXPZRHeQzxsrzLk7OOpXiohlrYnsencnrS01w0QkNx96sc4ooPmXqzlRsezQqscN7kQo3m06FjF+1du9BIn7zq7gVARj5Uj2PqA7FjI0gW00x5MImgjuEMtZNenNuGN1dI9zj+pjbSwnIks+9rQMOfT+BmjhS+/H2q1wc+f/ImwvnBNbu9Lpf/WUJpoUyVs3ch+MW3aiTtGT6bIfvfV17dffAIEfCJSZQdTDMyozbltiT4VmUY/Uz06UEI5f/WkCWJqxTWqL6Q4srSc3bxSsNVKnWEvlhQNpcQBLR1NDFcn3qtEA5x1hUJNJBjSF9L6yjqnqvThY12WGDspjTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmSbDkKUK3etPOXdpxD6R3kvhCK7u2zCKJ0METAU5lg=;
 b=dFz6GdHiDTV1E5ZP6NEbKTV/C21ahgnlPTBF5yducDwbiwvgszVDz5Sfo5FGxLPENSDJGH0dg6J/jYSAEUntk5XCBvm4Zni69KnpyNfZLIHYgN3Kkp9c6QYIH+qgWZBSoi5yi9lRnfzuOxqIIxcMeBejjw7bm9QK5upqX12ZSQ6qDKaKNKWD9YOAjAHcGMIY+X0ToeZSiZ2kZ87YGQsSX/UX9xl+oKoWTBAxJBaW9WdOxFu7m2eRzCmDzazvJNpA0BZ66SvpJdxT2V17Vj5ghaRmCZFtqf3qfpE9PURFFaWHMtvJQlJZrH6bOHuBWIXVUyCmx0QRd6/WYOVYLz8bwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 07:43:46 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 07:43:46 +0000
Message-ID: <2d4385d6-c89d-4295-b67b-3e18b6fee65e@nvidia.com>
Date: Thu, 5 Feb 2026 09:43:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net/mlx5e: Report hw_gro_packets and
 hw_gro_bytes netdev stats
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260204193315.1722983-1-tariqt@nvidia.com>
 <20260204193315.1722983-3-tariqt@nvidia.com>
 <20260204212334.72b392af@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260204212334.72b392af@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 930c843e-5168-401c-f4f2-08de648a4aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2I1TFp3cU9zdVlsUjdrNzg5TW1DN1RxV1FFVEkxVzkrNHFNbmt1VWVOYzJt?=
 =?utf-8?B?WFVhYUlJbWgvUlhyVit3aFlWWjJadG96TFEvejVnTXJUS2JrZUNGSU8xU0Z2?=
 =?utf-8?B?NXljTFQ1MzdIOVo5WWhMMXZmbW9Fc1lZRGdoT0doV1dkelNPRlRUNDJmT3NP?=
 =?utf-8?B?cjdsOUdqVE41TzdNT0gzemNXYTFib1dtS2F0bHhMWitoWVFSN1pGZVpHWkM5?=
 =?utf-8?B?d3NCcG9Oa0pMWDJjL29DVkJ2ZjdMTVJzblhYMGJWNktKTk9naWNIbnY0NzFN?=
 =?utf-8?B?MFU1dFdoQ1BLTWx1OVZCT09UTENRNWdFdW9FUEt3ZGlNRkNHSU9aVzhaNE9p?=
 =?utf-8?B?RGdDckgzdzh5NkpoNXdJNzBMTHRaekNEQ3lQWjIzS3Q5OHh4V2RrVysvemE2?=
 =?utf-8?B?cTZpSzJpbkxHWTJkbW5Ub1FvcEM4OU54c3lXMjkwbGNodXRKQ2w1clhDYytv?=
 =?utf-8?B?WnZkOThlNmxxeHRvNjA1MGMzaWF3NCtPTWRmVUhSLzNhQTJqbnBkdE43MWpJ?=
 =?utf-8?B?YURPQUw4c1R6V1F6QmJXRUY1dU8wZXF6ZnFrS1BFenkyK2c0emIrRGMvaWU3?=
 =?utf-8?B?YlBhVjhNZWIyQUprbWlhaWFkcUpzalVwVUJGUnpPRjJFc29RM1l0NEZLMlhX?=
 =?utf-8?B?NTBrbXJ2VkJzb1VaK3FZamUvZ21Kem4rR052dnVxY3RlUndXejhmWUtNL2V3?=
 =?utf-8?B?UDFkZEo0dSs0NFI0em9yOFF4OTlpb1pZRlBUdW53ODUzQ2hPdmRlOW9ZQjNG?=
 =?utf-8?B?cjhuMzZOc1QrVGVhYnhvN2cvZGZkNDZGZlJOeHlBR2ZOTzJGRUpUOWVUODA0?=
 =?utf-8?B?cWpGSFFxZHZtZ3h1SkZNQXpZMUhIT1hzTlFYYTZwZXZNQzFXTUlFZ2Y3M1VF?=
 =?utf-8?B?ZnNaNjlQdVNrTTk0QmJHb2pjVXppZDZQY1JkUEJ4QkNJZFhSc2hJQnNPcGhY?=
 =?utf-8?B?NXBaVGx1SnRiMjFhOUVldnd1T2JDL0F0b2pKdHNlY1ZMeFdUbFhhdU1Nak1B?=
 =?utf-8?B?QTl1d3FxMHB6QU1vekZYWlR0SE4xOXFPa1lRVDRKWk9hRUlCdDY0a3JjVCtk?=
 =?utf-8?B?Y21vL0pQZXBTZUNDeHZYanhwa0trcTFBWCtpT1hGM1R3Z2RBTWM5QktscGpF?=
 =?utf-8?B?MFBobEZ5Z3FKZnIxeEdMdTNQQzh4VlVXNjhTVUxmUWEvb05NWUlJeW1qQ2hZ?=
 =?utf-8?B?Vnp0Q01nTWltU1l5eng5R3V2U0FDTEF5ZERPYnlTSzdzZDd6Z2RNSUZocjV6?=
 =?utf-8?B?dUk0ME1QOWoxbU9tTmtTUU9vSG56Q1Blb1IrckVZZER2Tlh6Y2haOVE3L3Zv?=
 =?utf-8?B?QWV2NEMvSTFSc0xiSWlGVnhsQ25HTE9WTkdtbCtQaXVRRkp5alF1RW85SHdG?=
 =?utf-8?B?ZDVBT2gwZy9vOWNzcUNtWUtvMEpRbHpsc0FnR1NpNjdNaTVhVXQ2UUprbEpL?=
 =?utf-8?B?bFY0Y0h1OWZFb2xrUFdueDFheHVKMFg3OUlEY3JwQWUrRDRFNnkzUzFPNFMv?=
 =?utf-8?B?RUU1dU91RVRERTZkVWtvejMzT2pTaWV6OHlRWUExWkMrMmlCU3JrcDhPd1ZB?=
 =?utf-8?B?NkowUG8rTkU4UWxWS3FhUzZnYUhWZUY4MkxyL2R6ZjU2RHVYQzl4RGFPY2hl?=
 =?utf-8?B?cnJqTVozV0lrdEtpTU95WnM4c1pDOHB1YU8xYXBrZitCQjhENzRZa3o5dzZT?=
 =?utf-8?B?b2Nza3lkQW4wRTM3V3BqN21mcXI5MEg1RlZJYnJVWjhVbjhvYVphTUZjNFls?=
 =?utf-8?B?VkEvSHZndFdnMEpCc0tyaHpzbHQ5cmV6TkxyM3ZHbCtVazVRV3BOUGg4dDVs?=
 =?utf-8?B?SWdyd2UycXBGaTc5OGdtYVozTWpvbVphejNGWVROUUlNcHBzQ3NXald4Q0Jv?=
 =?utf-8?B?SDdHUnEzVlNVd1ZJWUlYNTJKK1NCcFRZN2Q0YXNUTDRpY1lYd1NQWEN1TG50?=
 =?utf-8?B?THRsSHFVQmVoZnpVa29nSFZ6bUhDUE83WEVpSGI2VUJiL2dqQmJtMEJoYnFP?=
 =?utf-8?B?L3NDYk5tL2ZtWGt2RmdiTXA0UzlFRmZxQUZmQXRmQW94RTZXZWRNTS9XTDg2?=
 =?utf-8?B?QUx1dzQzdkdvajl2eWFVMzVqN2VYSVFNYWFxbUdzV05RdEw2RE1kV09XUVN6?=
 =?utf-8?Q?uqb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEFZMUswUmZZcE5mZDA0dTZQNHVmcDYvazJQbTFFQnpBUE9vcEZZdXZ5M0o5?=
 =?utf-8?B?ajR2ZWxQYlRVNmJYbzFuYlgxbFFRZEhXOStZS3ZQVUhZTGUrelRaaW5EWXNE?=
 =?utf-8?B?NUVvOHJFUDVOdU96WWxuRWRxODI1aFJBVFJTZkNkSkMrYzFITFpqOHhTdjB5?=
 =?utf-8?B?Y251MVA3YkY5elYxMkxzam9vZG03NnVad0FMQzgvRjYvcXhheUh1cjRTdnU4?=
 =?utf-8?B?ZjBwaDF5ZkprMWhvVEhtTFlZT0c4NDFFWVd2blJDZGxkalRXcFlKOUh2a0VB?=
 =?utf-8?B?c0cwc0lwNVZoUHkzeVpSTmR6bWowSG9rN0ZZcmFSQ0dVUWRjVDhSOTliYTU3?=
 =?utf-8?B?eTBBRjdteW9SckdoMGovU2ZzbFgyZVNVVzJ4V3I2d25ESVdUT1UrWEx6bk95?=
 =?utf-8?B?NUlCbENxbjIzc09nTEp3NmtaLytVc3pTNHNzTXpBaHZUSjBzL3VteFdQSG9Y?=
 =?utf-8?B?OSs1L20xdlNnNFhudzI2STBvYlh2S1B5QWlheDRDNEdJNmlTbTc5TlErMy8y?=
 =?utf-8?B?MDF5c3NqMENWVTFKUHI0dUxOYmN2RCs4cVF3R0FQWDBtdDFIZmZLd3FST3BQ?=
 =?utf-8?B?bmdCVGR4OTdjaFZDMmQ0MVlNdHRLMEFLV1N2OUs5a1NQOTZ0V1R6dm5lZm9r?=
 =?utf-8?B?U0xKTGdwUkMxT0NzdDFCeDZVY0MrazZqTzNNR2U1L21obHliNWdmQVdOS0d2?=
 =?utf-8?B?REdtc1FQVW8zSjdzeHVnMy92UVNJZHEzN056NDRxV09wZGw1ZTFYdTlSYURi?=
 =?utf-8?B?R05HamNLZ093RzNmbTFKeEFObGpBZ29ycGg2TGV4MWVVUUJ5NjVsMG1BNW5Y?=
 =?utf-8?B?UE84Y1FlN25oVGYzeVRTYlhNTVFGRlc1UUFZM3d0ZEEwd0gxTnFqSm1RYUhE?=
 =?utf-8?B?YnROZHRoaWlRdWdPbHlMWGJlUU1oZ2NSVmoxZEthZjZqd1RzNWhWb2NzRVNM?=
 =?utf-8?B?Vlo3VmZnZStuenJLQ092bFUyYjhFQWtOaHVRUWJ4d2xUUXJzeTUyTzAybDhK?=
 =?utf-8?B?STNQdTFKcFJuMjk3bWxzb05xT3VlajdUVnNPSWIzc1ZMWGMyZHVGTERqb0Ex?=
 =?utf-8?B?dlhQQjV4Mm9HWTM5Y0N4VkUvamVuZGwwZkZvMWdpdHJwbXB0QnpmcWZ2Qy9K?=
 =?utf-8?B?L0J3VHhvWkk1OWJ1N0ZycjB2aG5zTVFGM0VJU0ZtbnBRRUhlb2ViL2Q2Vk51?=
 =?utf-8?B?eTJmQ2wzamJxNWZ5ajN0RSsvcm9XNlpBa3RueUpvbXFlZmVvREswYVVLYjRr?=
 =?utf-8?B?bzJDdktaRUN6Ym9GUW9jUXF6QlpPOEs4eGxWM1UzUVdycERScDQrNU5aU3ho?=
 =?utf-8?B?OWVpU05zUktwVXlrRWtKMm1VQ1ZEWUFqSk16V2tKNlgzaHFkaFp5SUg5VzlB?=
 =?utf-8?B?Tk5ieDNYREYvcFBsa1hSVlFTSnNpSWVyQkgrNmwxV2RDMUZmSlNMcWhnZ0xW?=
 =?utf-8?B?eVRzaERweHVuU0tsWVBzK0F6cGRpbWI2RUJLOTF5YlhFK0dWWFNkWlhaT0tI?=
 =?utf-8?B?YWlIaTIvREExb3c3T3hhQUtGQkN6V0ZvQTZJdTZLUlduSFFLOXFFSHBjQ1hq?=
 =?utf-8?B?aXIyaUY0SnZ3eEdVcmxERmN5RU04Q2lFek9EZXdDZUNTYkxRc2lCR1pTT1Ji?=
 =?utf-8?B?K0RVZ3hheEFKMHM5ZXNBeHF5S09OMmZrTEhUeEJaTVpvUEg1bE1iMHB5cm0y?=
 =?utf-8?B?RUw0OEh6Y01ISEdTNmhGMFllVHNsM1VOTlBLR085b05GZW5oeFV6VjZRYUls?=
 =?utf-8?B?WTJBNEpzQklTaEN5UU9kdDhwQXhpaW1DZTNLTFhYTzlBZm4wNzhFS3NxcTFh?=
 =?utf-8?B?TklaS1dBSWVoeXliK3IxSGc1eDhCb1hYbHBQL1QrNmJhTjExalJDeFhJNGc3?=
 =?utf-8?B?UE0ycG9Cdmg0YU11OUR5bjljVThxM2VQUVhISUU2QUVjcWhTMzRRa2RpcGY0?=
 =?utf-8?B?U3Vmd3EyYzhrb2Q4TGdQNVE5VnFISFBKdFBHNStDQndWRDNMVjcxNWFzSTdh?=
 =?utf-8?B?M0ozWG1CU2hUQzBDSFIrbFpyZUxQN1dkM2Q5S0loYkRSWG5CZzBBYTdMQ0s4?=
 =?utf-8?B?UkdackF5c0FoL2J3cWpMdnF1T29VTHdQdTN3a3AwclFwc3B2OWo2ZENrbUpQ?=
 =?utf-8?B?NVpTSlE2TFpQMWc2RVo0OWpYaG92MWtXRXR2SDI2bVBNczBiazYvczRNZ0dS?=
 =?utf-8?B?S21INWJjbjM3TVdPOGJFQkFDV2h6UjUxdjFHblFBeGkvV1poc1lmYTArbFhJ?=
 =?utf-8?B?QWJiOFBVczNhTGMvVDNFNStETjQ1Q1Bobld2UHVWVWUrSFczZEZyVUdNNWpw?=
 =?utf-8?Q?PFq98ovxA1pdLuk5rU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930c843e-5168-401c-f4f2-08de648a4aef
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:43:46.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNkT1HYnvzNMWltSpo1JmHsSOYt1iW5QwB/W+oHjos7dI1c4wwe8wpdJz5RTYEmY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-16560-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D2AEEF8A0
X-Rspamd-Action: no action

On 05/02/2026 7:23, Jakub Kicinski wrote:
> On Wed, 4 Feb 2026 21:33:12 +0200 Tariq Toukan wrote:
>> +	stats->hw_gro_packets =
>> +		rq_stats->gro_packets + xskrq_stats->gro_packets;
>> +	stats->hw_gro_bytes = rq_stats->gro_bytes + xskrq_stats->gro_bytes;
> 
> Doesn't look right.. 
> 
> mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match) 
> {                                                                               
>         struct sk_buff *skb = rq->hw_gro_data->skb;                             
>         struct mlx5e_rq_stats *stats = rq->stats;                               
>         u16 gro_count = NAPI_GRO_CB(skb)->count;                                
>                                                                                 
>         if (likely(skb_shinfo(skb)->nr_frags))                                  
>                 mlx5e_shampo_align_fragment(skb, rq->mpwqe.log_stride_sz);      
>         if (gro_count > 1) {                                                    
>                 stats->gro_skbs++;                                              
>                 stats->gro_packets += gro_count;       
> 
> And:
>       -
>         name: rx-hw-gro-packets
>         doc: |
>           Number of packets that were coalesced from smaller packets by the
>           device. Counts only packets coalesced with the HW-GRO netdevice
>           feature, LRO-coalesced packets are not counted.
> 
>       -
>         name: rx-hw-gro-wire-packets
>         doc: |
>           Number of packets that were coalesced to bigger packetss with the
>           HW-GRO netdevice feature. LRO-coalesced packets are not counted.
>         type: uint
> 
> Your gro_packets are "gro-wire-packets" and "gro-packets" are your
> gro_skbs.

You're absolutely right, thanks Jakub!

> 
> I really wish the AI was clever enough to catch uAPI mis-reading :(


