Return-Path: <linux-rdma+bounces-18461-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJj0CsBivWlh9gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18461-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:07:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDF2DC52E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 363243058183
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702A3C554D;
	Fri, 20 Mar 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npAuLPbv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300C279DA6;
	Fri, 20 Mar 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018043; cv=fail; b=sBx//zNTnK1o3qzJdY/eZIQ64r1L5whc/cw8qaxe0+ejHriDFBE7s3AzM/TPriYimsd2OgWannOS451Rm8s5lfTwVcPXQvLRNrLtaN46yzkz8RZyx6zKQRGDE92JczD19XMhmtvDNhG3qfLSbUGGFZ1BhVKAhMEoy9Xt49ZvOyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018043; c=relaxed/simple;
	bh=vJ3ayqgvEFvjfX0g8S7Y2rqpm8xFa1+eC569uA306Oo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhvoY+YUmijCDdoP8gam7jMNqDH4/5pII+5ReQGzm8wQaOygmitvyU0u4NmgZDghDszgEzdQtbrrCPHd6FyVYjFybpNypyP2GuxTMPE8ovPda6LY2oeVyFJplKf9w+d3eYI0yZ79PoW8vZoXG+CCDci4235Az7hqawtozXbOnzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npAuLPbv; arc=fail smtp.client-ip=52.101.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFR057f2tcJKquNrKGTrrzMKiWuZnGiIAbBE28Xg3b2nBXijwbk0aZs6/Yl5QEUiO9Cx5u+7igyb74gdCyGVjmq6pJk/8eSvJMZCqXVoBVa2MOyYAFUd6Qe3WsNtpaBzjKh+JgRMLoaZBvEwpI0+PlR4lrvZ73YTyjkfDweTAkXD1EHX9rDrYmLvDbkApjJD6y0UHc0SL9JpkjQTY86+tDOVyxIR9t8X7z/r0WEZP+LkWKPbIqLDl7Lecne3fYqKFPhZ8aY+IiHVwlaDjECd4swmTsYXzllGPRkzVljdW8L8xJydNSfgBlVQRHcGquLIzzjPFrWhQ+MSR+AYswjW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ3ayqgvEFvjfX0g8S7Y2rqpm8xFa1+eC569uA306Oo=;
 b=uMdcQyOdSHHRp/KF4WVgW5Q1xGx2QFYO/E5DJR4u0qZk40IkmMjuHICZJ9WadFYa1Rxz5Fr4WZguS+16Z5aibzchsv7Vtr7AuVOtjNmRMGkvfEC51hMUlU1JHLzkRmGBDFUnqLxqorxMwyrwsQxqlOMmsuTRuYR9MIKOZBjWsTF6NrPx7ZBeWVDFvh+9x0sIlh7iD1BkEfo5CFxg5PE/rIOmPROfdL6t6MMyU2hMwIhlh2ULDZSSwox3RLfYe/1Ybs/aGo1h6rtkZlBkQYMf95NsahvyVUbueGG5jOaTLWZLDf/BLNQtgbDlEeGAwhFYF1Tdw+JjUSsE0GkgwnvDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ3ayqgvEFvjfX0g8S7Y2rqpm8xFa1+eC569uA306Oo=;
 b=npAuLPbvEHrTMfJVpWOvRAoPm+JpHK4YgPjTLT19YGFQRWp2+xXKrHHhFUMM+HpHs+vjqwI/7crpH7zgSZ+FhWW2FqFL/+kHnDkgGn02cW0qUKwbA9JU+wyeLpFZtDrKUROnUIF64Rtic9RNBt1o6LhF+elzlRY6qcoGbOQrS4LXSHK2rNFar8S48oMEt/JTk2AAKsvBg90SH9/rUf7rhKiKVjS5XGP4uJFBlXuBmd+7FeFVZ5krfzCSBxD3Eg3rZjAhUh8jxfiGM4lyB29mKjHl3OdegxBUyp6pYYdYSRs8HXf76cZyMafil58s6ziYTvdJ/ILhpK/50Lj+vjD6uA==
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) by BY5PR12MB4195.namprd12.prod.outlook.com
 (2603:10b6:a03:200::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 14:47:13 +0000
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::473:4cdf:9d66:c8f5]) by CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::473:4cdf:9d66:c8f5%7]) with mapi id 15.20.9723.008; Fri, 20 Mar 2026
 14:47:12 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "przemyslaw.kitszel@intel.com"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"willemb@google.com" <willemb@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "skhawaja@google.com" <skhawaja@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, "kees@kernel.org" <kees@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>, "alexanderduyck@fb.com"
	<alexanderduyck@fb.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, Mark Bloch <mbloch@nvidia.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>, Tariq Toukan <tariqt@nvidia.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "aleksandr.loktionov@intel.com"
	<aleksandr.loktionov@intel.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next v3 06/13] mlx5: convert to ndo_set_rx_mode_async
Thread-Topic: [PATCH net-next v3 06/13] mlx5: convert to ndo_set_rx_mode_async
Thread-Index: AQHcuAhrskQMx0Y23EKnpC9kCZYKrLW3gMyA
Date: Fri, 20 Mar 2026 14:47:12 +0000
Message-ID: <c0915086dc876f59e3c69886a8629efa3540d737.camel@nvidia.com>
References: <20260320012501.2033548-1-sdf@fomichev.me>
	 <20260320012501.2033548-7-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-7-sdf@fomichev.me>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF189669351:EE_|BY5PR12MB4195:EE_
x-ms-office365-filtering-correlation-id: 2e85d261-c870-449d-af00-08de868f9268
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 KOSUeD0LNgI4bU1N1WWKbek+wYXYukW7RH2p62rx1Me2yWWcclizT9CWNOAVPOUQGsfexq+kxJvQWZgtHFrSIzXM4jqPGYA7bpxDHQsJ06+DeCBzS/vuyBEA6KcvkjUwctAXBSUpv8Qfv8dsqzWHAs8eTfyCRnQKPaTEsxTtC7Ky/5TOn3VyIL/zk+ilITjfmpvwAe96xoFZMPj/p0NS4eFCUrM5g6fsTNlNfkrnk8ggVzFMSbbUurTQh5tCpPSKwzHIPGb2sITGA7rfgfszZsSkhQJxBheR2MNATAMKcCQ36WwCE9AL4jdTXBVQqQC6OFcpZW6JoBmY25KgBVj2vCNVtHofjYPW7nR2bc/3yFX85MZ/bWOnr7u+KIG5UItfJNkytvAhF9a2YG22x0fErVvMnoupIIT0GWYatfbPigb1N+lehhy2ShURzjkaqdW5zEe/je7Vh2J/jxCCE4HdXGDJedeu0+HFciPcLtgZUKOxJ04wH+VzmeGFJEaaJf/EwKFGqt+l4iPnrVrcqUlK7Jxa1ZFtC7dUtNqJmwazX/YZBAn/kqQBEqTQIPcfIn+wGrv932yZIK07SOSjMSnkAng4+y6aF/g4lyea9oe9WDTr63tHm80ZbzvzRA3gRIvmU/p+ioG3tItjwGhqCYTUoVmeU+dKf3wH1k3NIKkKpl5dRio0olvV5JfwPVH1DK5Rr6RJNvgp4sgbbmwReqOylenRYYt6lJtF7XDD7oZ9Qpq6mbKVaQOkzl/gf3ZIZhANdeTgY9Ej/IbnI5e1vjNqTJ0TXJ6OEOpudqSO3c7hY/w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPF189669351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEZ1WTRLSVlBaEQzTUhscEk5cUgwQWRZQS9MR3d0UmQvUzdRYVcwV2Zqb2tK?=
 =?utf-8?B?T0VOVkZ2S1ZxTG80U01PVUZKOFA4YzZvM2Q5ZGJieGEzS3VLdmIyQmtJeXRC?=
 =?utf-8?B?d3hUWDVSK3U4aExMTzlBQi9wV1IxR0IrZ3pLKzdZQ2xheFV4UzJXUEg4Ri9h?=
 =?utf-8?B?WS9ValBaczFmVmRDdndLNmUycWR1K2poUFRYUHRGRk5vMG9GWG4xbzJzbkFX?=
 =?utf-8?B?aVJrQXJHaGgxMEpRV0NQZVl3bVdBTWY5ZWlRTmdXWVRCYVBxRTh1N1I1UlJV?=
 =?utf-8?B?K3Q0Qzk5YmZBT2ovdGdaSWgwcy9Wem03clhJVkdsNnEzblVHTy9mQkw0WjdZ?=
 =?utf-8?B?S0IyUVlhVHV6Q2RJR0FTazMwZWFhTVdsWXQ5eXZ1MUEwRnpsYk10dHphZFIx?=
 =?utf-8?B?OUVSay9hTndBcFJEUm5ha293Vi90b2FJSDdNRFRubDQrVlg2RTBaL1ZnN2pp?=
 =?utf-8?B?eG1tVkVab0V0QTd5am1DSktNRHcvbkwxZVpBaElGNGtvVFhSc25UVmkwZWs5?=
 =?utf-8?B?NHZQYmUzYUxPSXdXVG1qSTZZU243Rm9UZVNBRFVKMjRXYlUxV2llc0p5c0o4?=
 =?utf-8?B?TzNtNGUzWSsvc2dPbm5MOU1jZDRSTm1NdUhxeFBIemh1akQyU3h4aVlKWlBI?=
 =?utf-8?B?SCtvNG9oM1dCcjFoZWp2b05BOHExS2hzS253dTQ5cENjWEhpK3NZMjdLNEhN?=
 =?utf-8?B?ZndGNWljQ1NwTm5Hd1lQcWMvVUxBbWs1VWJXelBlNzlmNXJ1dXNINUcrQVcx?=
 =?utf-8?B?aWhyZmN0RlBzK0hCaFg3cGFqblV5VDRuVjE0RDFpVUZsTVpBOWMwVjB0cUFW?=
 =?utf-8?B?TVorTmFRTUxnRlQzUzBwYUJoeHRudlRaRVE0K3Yrdk5QTHZPVDhLZEsraytR?=
 =?utf-8?B?M3R4SHlZY3RyMzhQdSt4N1ZXYUNnK1VvTjhnYndVUzJnY0RydjNFazEwQUZE?=
 =?utf-8?B?SUxrQ3REL0cxZWlzdkJvYmdYL3dtTll5T255NHBVWmo4TEk0RmVkcW9RejdY?=
 =?utf-8?B?bkk5SXFobUdxVkU4R2VjSnpWMTVKeElLd3hpbU5WMmt0WXlRdWYvbkl1QzNL?=
 =?utf-8?B?THl2QTVkYi9YRCswWmx3aGhWTHZIcHltMFVnRGpXazFMbHpoN2tSOGZNQ3Yw?=
 =?utf-8?B?ZlpDdkczUFZEODVXVmZzdVRFQ2hXWkNnQkM1WjFBZzF6ZDBvd3JDd2pkWmw0?=
 =?utf-8?B?ejU5NG5HcVV0b1VKSElIRjhXUGkvdlpPL01FRWhVM2hSNk1tbU9Nc1l2ditq?=
 =?utf-8?B?TWJXK0Z6bVhPQkdKak9qR2x2RWpqN0szS0lCNjNKMUdXM0tvLzFVZW9kU2VM?=
 =?utf-8?B?d0p6OFVhOUROYmxVenN1TWpYSGhHSFptWVA4WGxDaEZQNUVidVBwSTJiYWto?=
 =?utf-8?B?SDhIT2Zpd1ZsdmtuL05DQ3RiZDdIVXlzU3ZyWnVuanRMNEFFcEV5RHEyZEJw?=
 =?utf-8?B?MGY5MFJ2a2h0K0FMcDByRVNWQkQvTm1pK0tCYjFSL050NkI4THNQc09USnZa?=
 =?utf-8?B?bmZUUkZWVjQ5ZlpQQzRSWmpEcDFaK3MxN25SNFk3TXhKOEFIclZLV1JZazhO?=
 =?utf-8?B?RjFUUWljV1RGbEdKZWQ4NEM3L2ZWaEtnanJEb1lrK2FZSVlUVzBqaEt0RW1P?=
 =?utf-8?B?enBOQWZzQklyRDZNR0t4SENXMGVpclpQalZnd0N5bTVQVWkrcXBqcExjanV6?=
 =?utf-8?B?b3lzQTFTNVBzTVArTHIzZTUxRUdrRnVIQkZiNUFtWEtVT2I1RkMyMWlIbnNI?=
 =?utf-8?B?WERGUC9ERUhQN0ptM1lHbis5VFZRaEpCa3FTQWJHYWFicnFrZVpMOHNpMDJi?=
 =?utf-8?B?Z1hWaXBJVXVScno2Qy9KNjQwaCtMbUtTRytEamFJb1FiNXQwR2p1T3piYVFC?=
 =?utf-8?B?aFlFZUtIVDJlV0hWa3ZDVmU0ZnZISmxQaWVQWEgzWFRhOTRiR21JRHFZaTI1?=
 =?utf-8?B?U0F4WEVvTDlRdkRma1ZxUW5KYWE1Y3oyQ2g3VnJyWkVkL1paWGd3YlFhMDRz?=
 =?utf-8?B?MDlNR3pUWUN2REpYd0JzL1piSGZsQ2RQTjB0TUNDTHBFRkMxQXpmNC9ZQ0Y3?=
 =?utf-8?B?RE9mUzJyU3BDZWdjQUt5MU5UQ2htNTUvZmI2bTVCWk80bG4xQ2E3ZDliYmxy?=
 =?utf-8?B?YU5qeEYvd1pkeTVZV1loWDl3NitaOVlmbW5Lc3pNNTBpQ2tzb1lqV0toM3oz?=
 =?utf-8?B?SStEWVJXa3VlcWhnMThvaGVOc3hKamxvV3RQVnFJWVZIb0dDVEJldXhzazEy?=
 =?utf-8?B?MmdyWTl1bDdybHpXYU9zUlhvZnlWQVB5QXVDQXp3Y3BpNnpLb2FmWGRMc2c0?=
 =?utf-8?B?cCtqby9nUmU0S29CcXlnSWh4SkJneEdQcFJXR0Z2NzdqSEZnTDBxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B72DD22FE97F745A44CB703FD1F8303@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PPF189669351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e85d261-c870-449d-af00-08de868f9268
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 14:47:12.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X8BW7Nzqc2qsKXro8zKTZm3YL97L2FjAuy4NMKk4rpWc0N23HWtxIMns/3csxsX5zIdksrSvlMHqyh65KQGdSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,gmail.com,meta.com,intel.com,davemloft.net,redhat.com,kernel.org,lwn.net,google.com,vger.kernel.org,nvidia.com,fb.com,lunn.ch,broadcom.com,queasysnail.net,linuxfoundation.org,sipsolutions.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18461-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:replyto,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.788];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 18EDF2DC52E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDE4OjI0IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IENvbnZlcnQgbWx4NSBmcm9tIG5kb19zZXRfcnhfbW9kZSB0byBuZG9fc2V0X3J4X21v
ZGVfYXN5bmMuIFRoZQ0KPiBkcml2ZXIncyBtbHg1ZV9zZXRfcnhfbW9kZSBub3cgcmVjZWl2ZXMg
dWMvbWMgc25hcHNob3RzIGFuZCBjYWxscw0KPiBtbHg1ZV9mc19zZXRfcnhfbW9kZV93b3JrIGRp
cmVjdGx5IGluc3RlYWQgb2YgcXVldWVpbmcgd29yay4NCj4gDQo+IG1seDVlX3N5bmNfbmV0ZGV2
X2FkZHIgYW5kIG1seDVlX2hhbmRsZV9uZXRkZXZfYWRkciBub3cgdGFrZQ0KPiBleHBsaWNpdCB1
Yy9tYyBsaXN0IHBhcmFtZXRlcnMgYW5kIGl0ZXJhdGUgd2l0aA0KPiBuZXRkZXZfaHdfYWRkcl9s
aXN0X2Zvcl9lYWNoIGluc3RlYWQgb2YgbmV0ZGV2X2Zvcl9lYWNoX3t1YyxtY31fYWRkci4NCj4g
DQo+IEZhbGxiYWNrIHRvIG5ldGRldidzIHVjL21jIGluIGEgZmV3IHBsYWNlcyBhbmQgZ3JhYiBh
ZGRyIGxvY2suDQo+IA0KPiBDYzogU2FlZWQgTWFoYW1lZWQgPHNhZWVkbUBudmlkaWEuY29tPg0K
PiBDYzogVGFyaXEgVG91a2FuIDx0YXJpcXRAbnZpZGlhLmNvbT4NCj4gQ2M6IENvc21pbiBSYXRp
dSA8Y3JhdGl1QG52aWRpYS5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92
IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Rhbmlz
bGF2IEZvbWljaGV2IDxzZGZAZm9taWNoZXYubWU+DQo+IC0tLQ0KPiDCoC4uLi9uZXQvZXRoZXJu
ZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL2ZzLmjCoMKgIHzCoCA1ICsrKy0NCj4gwqAuLi4vbmV0
L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9mcy5jwqDCoCB8IDMwICsrKysrKysrKysr
Ky0tLS0tDQo+IC0tDQo+IMKgLi4uL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5f
bWFpbi5jIHwgMTYgKysrKysrKy0tLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuL2ZzLmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZW4vZnMuaA0KPiBpbmRleCBjMzQwOGIzZjcwMTAuLjA5MWI4
MGE2NzE4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL2VuL2ZzLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL2VuL2ZzLmgNCj4gQEAgLTIwMSw3ICsyMDEsMTAgQEAgaW50IG1seDVlX2FkZF92bGFu
X3RyYXAoc3RydWN0DQo+IG1seDVlX2Zsb3dfc3RlZXJpbmcgKmZzLCBpbnTCoCB0cmFwX2lkLCBp
bnQgdGlyX251DQo+IMKgdm9pZCBtbHg1ZV9yZW1vdmVfdmxhbl90cmFwKHN0cnVjdCBtbHg1ZV9m
bG93X3N0ZWVyaW5nICpmcyk7DQo+IMKgaW50IG1seDVlX2FkZF9tYWNfdHJhcChzdHJ1Y3QgbWx4
NWVfZmxvd19zdGVlcmluZyAqZnMsIGludMKgIHRyYXBfaWQsDQo+IGludCB0aXJfbnVtKTsNCj4g
wqB2b2lkIG1seDVlX3JlbW92ZV9tYWNfdHJhcChzdHJ1Y3QgbWx4NWVfZmxvd19zdGVlcmluZyAq
ZnMpOw0KPiAtdm9pZCBtbHg1ZV9mc19zZXRfcnhfbW9kZV93b3JrKHN0cnVjdCBtbHg1ZV9mbG93
X3N0ZWVyaW5nICpmcywNCj4gc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldik7DQo+ICt2b2lkIG1s
eDVlX2ZzX3NldF9yeF9tb2RlX3dvcmsoc3RydWN0IG1seDVlX2Zsb3dfc3RlZXJpbmcgKmZzLA0K
PiArCQkJwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsDQo+ICsJCQnCoMKg
wqDCoMKgwqAgc3RydWN0IG5ldGRldl9od19hZGRyX2xpc3QgKnVjLA0KPiArCQkJwqDCoMKgwqDC
oMKgIHN0cnVjdCBuZXRkZXZfaHdfYWRkcl9saXN0ICptYyk7DQo+IMKgaW50IG1seDVlX2ZzX3Zs
YW5fcnhfYWRkX3ZpZChzdHJ1Y3QgbWx4NWVfZmxvd19zdGVlcmluZyAqZnMsDQo+IMKgCQkJwqDC
oMKgwqAgc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwNCj4gwqAJCQnCoMKgwqDCoCBfX2JlMTYg
cHJvdG8sIHUxNiB2aWQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVs
bGFub3gvbWx4NS9jb3JlL2VuX2ZzLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5v
eC9tbHg1L2NvcmUvZW5fZnMuYw0KPiBpbmRleCA1NTI1NWZlNmU0MTUuLmE5ZGFlZmJkOGY4ZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vu
X2ZzLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vu
X2ZzLmMNCj4gQEAgLTYwOSwyMCArNjA5LDI2IEBAIHN0YXRpYyB2b2lkIG1seDVlX2V4ZWN1dGVf
bDJfYWN0aW9uKHN0cnVjdA0KPiBtbHg1ZV9mbG93X3N0ZWVyaW5nICpmcywNCj4gwqB9DQo+IMKg
DQo+IMKgc3RhdGljIHZvaWQgbWx4NWVfc3luY19uZXRkZXZfYWRkcihzdHJ1Y3QgbWx4NWVfZmxv
d19zdGVlcmluZyAqZnMsDQo+IC0JCQkJwqDCoCBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0K
PiArCQkJCcKgwqAgc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwNCj4gKwkJCQnCoMKgIHN0cnVj
dCBuZXRkZXZfaHdfYWRkcl9saXN0ICp1YywNCj4gKwkJCQnCoMKgIHN0cnVjdCBuZXRkZXZfaHdf
YWRkcl9saXN0ICptYykNCj4gwqB7DQo+IMKgCXN0cnVjdCBuZXRkZXZfaHdfYWRkciAqaGE7DQo+
IMKgDQo+IC0JbmV0aWZfYWRkcl9sb2NrX2JoKG5ldGRldik7DQo+ICsJaWYgKCF1YyB8fCAhbWMp
IHsNCj4gKwkJbmV0aWZfYWRkcl9sb2NrX2JoKG5ldGRldik7DQo+ICsJCW1seDVlX3N5bmNfbmV0
ZGV2X2FkZHIoZnMsIG5ldGRldiwgJm5ldGRldi0+dWMsDQo+ICZuZXRkZXYtPm1jKTsNCj4gKwkJ
bmV0aWZfYWRkcl91bmxvY2tfYmgobmV0ZGV2KTsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gwqAN
Cj4gwqAJbWx4NWVfYWRkX2wyX3RvX2hhc2goZnMtPmwyLm5ldGRldl91YywgbmV0ZGV2LT5kZXZf
YWRkcik7DQo+IC0JbmV0ZGV2X2Zvcl9lYWNoX3VjX2FkZHIoaGEsIG5ldGRldikNCj4gKw0KPiAr
CW5ldGRldl9od19hZGRyX2xpc3RfZm9yX2VhY2goaGEsIHVjKQ0KPiDCoAkJbWx4NWVfYWRkX2wy
X3RvX2hhc2goZnMtPmwyLm5ldGRldl91YywgaGEtPmFkZHIpOw0KPiDCoA0KPiAtCW5ldGRldl9m
b3JfZWFjaF9tY19hZGRyKGhhLCBuZXRkZXYpDQo+ICsJbmV0ZGV2X2h3X2FkZHJfbGlzdF9mb3Jf
ZWFjaChoYSwgbWMpDQo+IMKgCQltbHg1ZV9hZGRfbDJfdG9faGFzaChmcy0+bDIubmV0ZGV2X21j
LCBoYS0+YWRkcik7DQo+IC0NCj4gLQluZXRpZl9hZGRyX3VubG9ja19iaChuZXRkZXYpOw0KPiDC
oH0NCj4gwqANCj4gwqBzdGF0aWMgdm9pZCBtbHg1ZV9maWxsX2FkZHJfYXJyYXkoc3RydWN0IG1s
eDVlX2Zsb3dfc3RlZXJpbmcgKmZzLA0KPiBpbnQgbGlzdF90eXBlLA0KPiBAQCAtNzI0LDcgKzcz
MCw5IEBAIHN0YXRpYyB2b2lkIG1seDVlX2FwcGx5X25ldGRldl9hZGRyKHN0cnVjdA0KPiBtbHg1
ZV9mbG93X3N0ZWVyaW5nICpmcykNCj4gwqB9DQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgbWx4NWVf
aGFuZGxlX25ldGRldl9hZGRyKHN0cnVjdCBtbHg1ZV9mbG93X3N0ZWVyaW5nICpmcywNCj4gLQkJ
CQnCoMKgwqDCoCBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPiArCQkJCcKgwqDCoMKgIHN0
cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsDQo+ICsJCQkJwqDCoMKgwqAgc3RydWN0IG5ldGRldl9o
d19hZGRyX2xpc3QgKnVjLA0KPiArCQkJCcKgwqDCoMKgIHN0cnVjdCBuZXRkZXZfaHdfYWRkcl9s
aXN0ICptYykNCj4gwqB7DQo+IMKgCXN0cnVjdCBtbHg1ZV9sMl9oYXNoX25vZGUgKmhuOw0KPiDC
oAlzdHJ1Y3QgaGxpc3Rfbm9kZSAqdG1wOw0KPiBAQCAtNzM2LDcgKzc0NCw3IEBAIHN0YXRpYyB2
b2lkIG1seDVlX2hhbmRsZV9uZXRkZXZfYWRkcihzdHJ1Y3QNCj4gbWx4NWVfZmxvd19zdGVlcmlu
ZyAqZnMsDQo+IMKgCQlobi0+YWN0aW9uID0gTUxYNUVfQUNUSU9OX0RFTDsNCj4gwqANCj4gwqAJ
aWYgKGZzLT5zdGF0ZV9kZXN0cm95KQ0KPiAtCQltbHg1ZV9zeW5jX25ldGRldl9hZGRyKGZzLCBu
ZXRkZXYpOw0KPiArCQltbHg1ZV9zeW5jX25ldGRldl9hZGRyKGZzLCBuZXRkZXYsIHVjLCBtYyk7
DQo+IMKgDQo+IMKgCW1seDVlX2FwcGx5X25ldGRldl9hZGRyKGZzKTsNCj4gwqB9DQo+IEBAIC04
MjAsNyArODI4LDkgQEAgc3RhdGljIHZvaWQgbWx4NWVfZGVzdHJveV9wcm9taXNjX3RhYmxlKHN0
cnVjdA0KPiBtbHg1ZV9mbG93X3N0ZWVyaW5nICpmcykNCj4gwqB9DQo+IMKgDQo+IMKgdm9pZCBt
bHg1ZV9mc19zZXRfcnhfbW9kZV93b3JrKHN0cnVjdCBtbHg1ZV9mbG93X3N0ZWVyaW5nICpmcywN
Cj4gLQkJCcKgwqDCoMKgwqDCoCBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPiArCQkJwqDC
oMKgwqDCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsDQo+ICsJCQnCoMKgwqDCoMKgwqAg
c3RydWN0IG5ldGRldl9od19hZGRyX2xpc3QgKnVjLA0KPiArCQkJwqDCoMKgwqDCoMKgIHN0cnVj
dCBuZXRkZXZfaHdfYWRkcl9saXN0ICptYykNCj4gwqB7DQo+IMKgCXN0cnVjdCBtbHg1ZV9sMl90
YWJsZSAqZWEgPSAmZnMtPmwyOw0KPiDCoA0KPiBAQCAtODUwLDcgKzg2MCw3IEBAIHZvaWQgbWx4
NWVfZnNfc2V0X3J4X21vZGVfd29yayhzdHJ1Y3QNCj4gbWx4NWVfZmxvd19zdGVlcmluZyAqZnMs
DQo+IMKgCWlmIChlbmFibGVfYnJvYWRjYXN0KQ0KPiDCoAkJbWx4NWVfYWRkX2wyX2Zsb3dfcnVs
ZShmcywgJmVhLT5icm9hZGNhc3QsDQo+IE1MWDVFX0ZVTExNQVRDSCk7DQo+IMKgDQo+IC0JbWx4
NWVfaGFuZGxlX25ldGRldl9hZGRyKGZzLCBuZXRkZXYpOw0KPiArCW1seDVlX2hhbmRsZV9uZXRk
ZXZfYWRkcihmcywgbmV0ZGV2LCB1YywgbWMpOw0KPiDCoA0KPiDCoAlpZiAoZGlzYWJsZV9icm9h
ZGNhc3QpDQo+IMKgCQltbHg1ZV9kZWxfbDJfZmxvd19ydWxlKGZzLCAmZWEtPmJyb2FkY2FzdCk7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUv
ZW5fbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vu
X21haW4uYw0KPiBpbmRleCBmNzAwOWRhOTRmMGIuLmU4NmNmMWVlMTA4ZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5jDQo+
IEBAIC00MTA4LDExICs0MTA4LDE2IEBAIHN0YXRpYyB2b2lkIG1seDVlX25pY19zZXRfcnhfbW9k
ZShzdHJ1Y3QNCj4gbWx4NWVfcHJpdiAqcHJpdikNCj4gwqAJcXVldWVfd29yayhwcml2LT53cSwg
JnByaXYtPnNldF9yeF9tb2RlX3dvcmspOw0KPiDCoH0NCj4gwqANCj4gLXN0YXRpYyB2b2lkIG1s
eDVlX3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ICtzdGF0aWMgdm9pZCBt
bHg1ZV9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiArCQkJwqDCoMKgwqDC
oCBzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHJfbGlzdCAqdWMsDQo+ICsJCQnCoMKgwqDCoMKgIHN0cnVj
dCBuZXRkZXZfaHdfYWRkcl9saXN0ICptYykNCj4gwqB7DQo+IMKgCXN0cnVjdCBtbHg1ZV9wcml2
ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gwqANCj4gLQltbHg1ZV9uaWNfc2V0X3J4X21v
ZGUocHJpdik7DQo+ICsJaWYgKG1seDVlX2lzX3VwbGlua19yZXAocHJpdikpDQo+ICsJCXJldHVy
bjsgLyogbm8gcnggbW9kZSBmb3IgdXBsaW5rIHJlcCAqLw0KPiArDQo+ICsJbWx4NWVfZnNfc2V0
X3J4X21vZGVfd29yayhwcml2LT5mcywgZGV2LCB1YywgbWMpOw0KDQpXaGlsZSB0aGlzIGNodW5r
IGlzIGNvcnJlY3QsIEkgdGhpbmsgdGhlcmUncyBhIGxvZ2ljYWwgY29uZmxpY3Qgd2FpdGluZw0K
dG8gaGFwcGVuIHdpdGggU2FlZWQncyBwZW5kaW5nIHBhdGNoIHRvdWNoaW5nIHRoaXMgYXJlYSAo
WzFdKS4NCg0KWW91IGhhdmUgaW5saW5lZCBtbHg1ZV9uaWNfc2V0X3J4X21vZGUgaGVyZSwgYnV0
IGFmdGVyIFNhZWVkJ3MgcGF0Y2gNCnRoZSBtbHg1ZV9pc191cGxpbmtfcmVwIGNvbmRpdGlvbiBh
ZGRlZCBoZXJlIHNob3VsZCBiZSBkcm9wcGVkLg0KDQpOb3Qgc3VyZSB0aGUgYXV0b21hdGljIG1l
cmdlIHdpbGwgZG8gdGhhdC4NCg0KWzFdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
MjAyNjAzMTkwMDU0NTYuODI3NDUtMS1zYWVlZEBrZXJuZWwub3JnL1QvI3UNCg0KDQo+IMKgfQ0K
PiDCoA0KPiDCoHN0YXRpYyBpbnQgbWx4NWVfc2V0X21hYyhzdHJ1Y3QgbmV0X2RldmljZSAqbmV0
ZGV2LCB2b2lkICphZGRyKQ0KPiBAQCAtNTI4Nyw3ICs1MjkyLDcgQEAgY29uc3Qgc3RydWN0IG5l
dF9kZXZpY2Vfb3BzIG1seDVlX25ldGRldl9vcHMgPQ0KPiB7DQo+IMKgCS5uZG9fc2V0dXBfdGPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gbWx4NWVfc2V0dXBfdGMsDQo+IMKgCS5uZG9fc2VsZWN0
X3F1ZXVlwqDCoMKgwqDCoMKgwqAgPSBtbHg1ZV9zZWxlY3RfcXVldWUsDQo+IMKgCS5uZG9fZ2V0
X3N0YXRzNjTCoMKgwqDCoMKgwqDCoMKgID0gbWx4NWVfZ2V0X3N0YXRzLA0KPiAtCS5uZG9fc2V0
X3J4X21vZGXCoMKgwqDCoMKgwqDCoMKgID0gbWx4NWVfc2V0X3J4X21vZGUsDQo+ICsJLm5kb19z
ZXRfcnhfbW9kZV9hc3luY8KgwqAgPSBtbHg1ZV9zZXRfcnhfbW9kZSwNCj4gwqAJLm5kb19zZXRf
bWFjX2FkZHJlc3PCoMKgwqDCoCA9IG1seDVlX3NldF9tYWMsDQo+IMKgCS5uZG9fdmxhbl9yeF9h
ZGRfdmlkwqDCoMKgwqAgPSBtbHg1ZV92bGFuX3J4X2FkZF92aWQsDQo+IMKgCS5uZG9fdmxhbl9y
eF9raWxsX3ZpZMKgwqDCoCA9IG1seDVlX3ZsYW5fcnhfa2lsbF92aWQsDQo+IEBAIC02MjcyLDgg
KzYyNzcsMTEgQEAgdm9pZCBtbHg1ZV9zZXRfcnhfbW9kZV93b3JrKHN0cnVjdCB3b3JrX3N0cnVj
dA0KPiAqd29yaykNCj4gwqB7DQo+IMKgCXN0cnVjdCBtbHg1ZV9wcml2ICpwcml2ID0gY29udGFp
bmVyX29mKHdvcmssIHN0cnVjdA0KPiBtbHg1ZV9wcml2LA0KPiDCoAkJCQkJwqDCoMKgwqDCoMKg
IHNldF9yeF9tb2RlX3dvcmspOw0KPiArCXN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSBwcml2LT5u
ZXRkZXY7DQo+IMKgDQo+IC0JcmV0dXJuIG1seDVlX2ZzX3NldF9yeF9tb2RlX3dvcmsocHJpdi0+
ZnMsIHByaXYtPm5ldGRldik7DQo+ICsJbmV0ZGV2X2xvY2tfb3BzKGRldik7DQo+ICsJbWx4NWVf
ZnNfc2V0X3J4X21vZGVfd29yayhwcml2LT5mcywgZGV2LCBOVUxMLCBOVUxMKTsNCj4gKwluZXRk
ZXZfdW5sb2NrX29wcyhkZXYpOw0KPiDCoH0NCj4gwqANCj4gwqAvKiBtbHg1ZSBnZW5lcmljIG5l
dGRldiBtYW5hZ2VtZW50IEFQSSAobW92ZSB0byBlbl9jb21tb24uYykgKi8NCg0K

