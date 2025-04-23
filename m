Return-Path: <linux-rdma+bounces-9732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881FEA9885E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D491885EFA
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658226D4FB;
	Wed, 23 Apr 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EWyQXFfr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108126D4D7;
	Wed, 23 Apr 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407267; cv=fail; b=rxPXxLBF8c/AyQMqSD7A6J/pGS8Gs2SGDMXwZngwZGZKtnp/k9xHaRJeR9EBRbhfjighkBprSABH8AzABu/7QrVeefuvUN25h9IVo0ES4LsvtSaqtUk93TLWQHcTva3QpqN+fCOMs3idnheRdjWD3eyD2Ys7PyWci7/vTX46SN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407267; c=relaxed/simple;
	bh=0xGExUS6WbLy/k51gEFMNpsz1Gom8xehnQo3Ko4OWuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UNwBgE4oV7BkFnV1OrhKCGR9ansUd1f3Deq52n9wNRyCF6DaUA//7D1EukKwqqXgp2B2XzvAgaOGMrvaiD/P18VOPHAuc1Tl9IZdtXwRIGcL9J79KLsU2WR7ofXjC0/a+Xklfv7My3fAhvn3QXdfg5Dt2jFP/8onhJBf6tQSN5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EWyQXFfr; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5GLg5KdMAD6ix4pxVrcMbfceUD0mcK0+631IdUtsHbTYk9DODHQ8htFzN/ck6KwBwEQma5aGqVlcj+O4W7Q+anw28laT+SSydM3G9hdlrs4jJ0NeXL8TlgmJ4kqYHZ8qa3QXgXp7Xn3NarbPd73D5YT4ED0pXttblATcnQixVnZjNPlhZiQy95qySTUUBeEwv7e2zN5aw2ADq/hK7eELYIVyx4b0YBvlr7pDWQoakCNPExqt9xCQ1gEtn7yIt7B7GSY6bJZkuluQeA4Kc7qK5OLuM8MwzttfMJwHWSf3HRmTznFj4U43JdH9IlFjlKxtROtzGFidI1MEB1fmX+rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH08CzEXx225chYmEywmRw8+zuRfUQhFD7yR2UdOaiw=;
 b=zJ8DfGurJkeolaIlXipnEoGXZZ6SaRa4IzlwbJVakw8ioSAq5H2t/GJ6hWHW2G+RMSwBaVD/bD3B0nxgn9xfyYKfo75CqL2lK1A0+JtbyH6bQsiwcnPOIKaWG6shWA8aS37yyUMcEUpqa5ICN/mXDh3k6AvDYJ7wzfmx83pxb7fj6YrbQVuB7kQ9d6ytWmQ+gHzV42mOVt5m1P8ULBLUEPOIW6kzPb7IHPzbu62Wvy/kAD5hWFVUgrOtyx3MN27+3b7O05SdaRq38Luc8sEh5eE1ponbNOxIO55DrYnrJ2BsIjbTBmaoVyf2J8+E/nKTLvKhFVyMQeZGBYBwXZN18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH08CzEXx225chYmEywmRw8+zuRfUQhFD7yR2UdOaiw=;
 b=EWyQXFfreoUHsneoKYMKfRBdfUW+8Pnqrcdoow2lrdqIIS0Hs4a0HkiPrJoXZxS9ZmVDw+yi2KypbgQtZfo8tzc/2UuhCQA272wOYWR0Vs+HMVCaa4OsaRAyJOi8zexa9dwzIFJugQyS5FF26mCRyDATNQE9/OxvHd3SL9FI+BIiVOf0RGHiIFZ3z6oqVF551ao5Qibn1qhSho/7Zc7Yg+fxsUzlfDCxSBLqnGry18R+8bK6xWarQF+BYwSRZpbJAvYnJIp/HwH55VObhD40klS8QhE5dtsJjNjBGOos59fZbaDXq5mgGbCy3nbpI9MZI5rZGijdR2yok/vaxDlPgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 11:21:01 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 11:21:01 +0000
Message-ID: <77df78bb-8bcf-42e8-b307-cc8bbe97254c@nvidia.com>
Date: Wed, 23 Apr 2025 14:20:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] net/mlx5: E-Switch, Initialize MAC Address for
 Default GID
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maor Gottlieb <maorg@nvidia.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
 <20250423083611.324567-3-mbloch@nvidia.com>
 <aAjBk5gX27FtnE3f@mev-dev.igk.intel.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <aAjBk5gX27FtnE3f@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff94353-852c-48d5-d84b-08dd8258edac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejdMeFdaZ2FpS3pURmp3c0NpRnoxTmxkUjhvWW1IOHNHbW8wTzFyZHRRUHFj?=
 =?utf-8?B?SkU2aEhPVTg3czRoaWJEbTI5MlFOQ1hEdG0xbGJlYWYwRzNzTnRtZ0owTEdv?=
 =?utf-8?B?blNhZWh1Umo0V0dmcTdubGphcFdUNVZGdGtnbHNrT3Fxc1JaeTNkZStCclhs?=
 =?utf-8?B?dDhMM1IxNDEzRGlpUG1QeTV4YWl2RGdibElwVnJPNlRyaEtDckdiTis0SDYr?=
 =?utf-8?B?NGpQUkp2UXBzWWtUUllwL0xkY2JkdmVzd1M3R1hObUZIZlNMbldmQW9CL1Jl?=
 =?utf-8?B?ekZXUHJLRUdFbkxJcWNBRG9Wb0tuUmY1S3VjcnMzTnBjc3VFM2pKWXJnS09H?=
 =?utf-8?B?cENpTmtLTTBxRUFvc3c4a1RtRm9Bd2ZvTnhQcjZSeW5NRFNCcFJsc2x3VkVi?=
 =?utf-8?B?WHhINktqc3A1dVJRc0JneG1OaEs2eCtPT1hWOXJKT21jMTlVVURsYnV5ajBn?=
 =?utf-8?B?Rm1FaXByUDlNdHQ2S3hGRFB0VjNuZTNPYWovOTF0Ri9XdDJXVVpVNGpCSDIz?=
 =?utf-8?B?cTZKYkdsWjYxRG82aHJBcU82N1UrU1pJN1gxUmNLbzJSejBtVTl1WWczczVG?=
 =?utf-8?B?aWIzb3N2NXlOOXdpWk1BWXhPUEZYV3dHdk1GY0pqUE8rbyttTXlkVmdGWERu?=
 =?utf-8?B?b1BldGhGMEdMaWRFa0NqOGVQZkpGUkc0VHZDVjNzOGJqZTUxanpSbnVLNTk1?=
 =?utf-8?B?cFl4SCtiblYzT0dYQTI2OEJWQTZFK3ZoZ056MllqV1lEbW1KTGIzeDJ5bk9N?=
 =?utf-8?B?TVhwRFg1U2VzbnhXQjhYQ3p1YzJaZDl5TkczQ3U5TGZqdERwWkFXT2FRVnlk?=
 =?utf-8?B?TjR0R05TcWlKQnpzOWQyNVpQQ2Fyc2FvSlVRQ0ZkYVpMNHJRMnpTbEcrK2lR?=
 =?utf-8?B?Nzg4aGE1OUZQaU8wR1F4L29OU3J4TlNHeVRUMzY5TFRITHJIb0NtYWE1aCs3?=
 =?utf-8?B?MFhYUVU5RE5rNkdXM0xQRjVLQktwZ0RHWkhHZlgxZysxN2JTSWhtZzZQVmVi?=
 =?utf-8?B?R0MvczNDOC9JeHBBSDVyWjhOckovNkJzWjJxQkNab2hOU2ZWeFdrTmREWHVV?=
 =?utf-8?B?bkJIc1o3QTEzR1NTaDVzY3ZaWC9ERXBxNjczMlhGc2p5dTZkUEorc0NXZVdl?=
 =?utf-8?B?UlYyMXR2SERvU2R6SkY5QnQyUnI3U3dWMmtjc1FaQ3U5azhlUzRxSXk4MlV2?=
 =?utf-8?B?Y241dHJSa3dJWHBUNU1LS2VzWjlyTG9jbk9UY0xzUEc1cHZiL3luZ2I5OFhV?=
 =?utf-8?B?anhuRTF0aU1vQ0hvN3lFVy92NTUxRVRydi84UnV2S2RDKy94NTVaTlYvZU15?=
 =?utf-8?B?cEpnZWhmOUF0SnNuYlhyQ2FpQzduV1N0NGtiVTFrTkhNUkV0UTJ0WnFkZHpH?=
 =?utf-8?B?V1V4TWRmY3l6U1lqek9qU1VIMUErWjFnK2phRkhqRGNHSGhwVmkxTUV2a0ZV?=
 =?utf-8?B?SWtabjJXQ3NLZUsxdEt4SjhHcVlraHhibzZJVUd3SHBYMjh3d0xlVHQ3YWdY?=
 =?utf-8?B?czB3VjgyeHBxL2JkSW5nUEpsbzBiRitpbzVndG9VL3d6SUZ5S0xtYmYwLzZJ?=
 =?utf-8?B?N0pCcXpmOTJ6eVlPcjg4WEowNEk3Rkh0TnRybWhJVVEwUHFLS3JjZnZLQ1NC?=
 =?utf-8?B?MGtHOGxVai9mT256b1g5SWw3dDkvQldJRTh0WVFrTWRJSTloUDE1bjhpTXM4?=
 =?utf-8?B?MzJuaDNJTVlQbU9wR0VaM1B0UFovLzFjaWRFb1pZVEc2Qkhvc3lSS3l1TW9s?=
 =?utf-8?B?UU9tV2J6ZXM3OXAvVGxkRldGemI5Z3VxL2l5Y215eGR2dVRSWWpJdFpyTVdG?=
 =?utf-8?B?WTR0eVN0aUkwZkE5MXNPV1ZqZ0dnUmMyaWdNYzFKNlh3U25PSFJQVXptM3Iz?=
 =?utf-8?B?UGN6c3grMHI1R2MzaXl6Yzc2eUlaVEl3ZS9EY1dFZVczYmszMmU1TUZLU1Jw?=
 =?utf-8?Q?ua44CuEzEUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCtoZ2QyTExrNmltRlRablA2Ukx5ay95OS9CejEzMlNqL3ZTWGRleWRXcGND?=
 =?utf-8?B?d0xlc1k4SmdLT1IyZGNnZnFidUV3bk8xUityRXppT21rcENBd2c5VEZBY3VD?=
 =?utf-8?B?MGVCVER4U0NlOVcwNjE0aTNoZm1OOXk4NnZQVFFrRHR3cDlUem92UVNxZTds?=
 =?utf-8?B?YXZuUlZLNlhBYnRaR3hJUWdESGd5TEg4d0FQVmJJaDVmU0YzamdMazRXYmVv?=
 =?utf-8?B?UTRCVHN6QUIxK2xTN3hlTUhuN2lmd2w2N0l3dVczamREendqZy9aam9pcGlj?=
 =?utf-8?B?d0dJMEtscm40U2lHR3ZDRTB0R0E5dXBXbHU2VTIwWTh2SmIySVU1UndTSCtK?=
 =?utf-8?B?L3NVSlowNzA0bk5nOEN4cWJueGFGakVnS2JWQ1liUU9icjBuck5uNmhEbW5v?=
 =?utf-8?B?VVp1NFdHbFBrSE5LOFlKWXoxMWNsV3A3UDd5NEVjUEVabHduT29kSjhSemhM?=
 =?utf-8?B?TE5YZFEzbUVNOTdhT0J5QVA2Y1haakw2N0RVcFlmcXUxTXRWVXRpRDJ0NlVH?=
 =?utf-8?B?RFc3a3ZYWmU1TlF6K2JiVFNmREIxYlRGcWFneHZpemNtMlJiKzVlNDU1Z3dm?=
 =?utf-8?B?QmxGalVRNWRFK201eFR1YS82OHpkWDdXcXcyOGh4Z0dpTXN6U0N6dVBhV3FB?=
 =?utf-8?B?RFBhV0ZWMzdPSGJIWHpxV1JCT2F6TFFTTUJZWXZRWXRqQ05JZkZ2UVcwSEh1?=
 =?utf-8?B?SVFlRG5tcnlQL2tYNVBXWjZWakhQd2xNbTFxS1gxY0tEd24xLzdSS2hqOHhP?=
 =?utf-8?B?UGRNNG9qcHo0TXQ2dFA2cm5uL0lwNldCSiszMU52TENuWjlscURMM0RjZ2dn?=
 =?utf-8?B?SUlRV2FBKzlRVVk1VWJuM0I5R2pBNWVCV3RCbU9pdGZ0cCtkS1pBVFdPVTJ4?=
 =?utf-8?B?WDkzTFFvWlBjVVdZZ3NqWnA5VE90K1I1VG5Pd1kvbmZLcDgzclduWm1rT3hu?=
 =?utf-8?B?SFJudXdubjlSaEV0cTYvM2tBeHBhYTdCa1JEZGEwN1BZNVkyUnd4T0dYd2dh?=
 =?utf-8?B?MkNBbmhETFVZNmJKT1NWeVUyL05xcjdodGdod21zSkI4Z2pDMCsxUk5FVFNV?=
 =?utf-8?B?czUrSkRqK1VhdHRkdXlDTXFTMmpWdDczZVA4dXF6Wm9oakgxZGN6NTZjY0Fm?=
 =?utf-8?B?RWREblNNREF2dXEydm1SRFVidERJaitBOHdRYTdQVThXMzVBMFg0dnJYZ05D?=
 =?utf-8?B?MWxLb25NQ2JUa09FWlEzRW1nbndQb0MzeURaK0U0cVBwZjJqY1lpVDBtUjNm?=
 =?utf-8?B?QzFVSXc0ZHJKY3dpWWdra0JRdy84ekowanhiL2dTNWNYc3R0eG1mSTQ4SFFE?=
 =?utf-8?B?aGJPSlNMaHVpOWpUcGNjUE5MRTJoODEwejJzQnNJd2cxRGYyb1hWaHkxVWRK?=
 =?utf-8?B?NXNWTVNSc005aWpaelVIQ0h0eEszOVpsSm04d1dRa0djME00eUNnTTFoNEE4?=
 =?utf-8?B?b1lCWWhpdEZtaHNqM3E0WHM4SG5VS2NZaUZDazNuZTZycERNNzdzRy9GLzJ3?=
 =?utf-8?B?TFl0Z29pU0k5R1pQRTdvZWF4Y2puTXVETFBadEMwRjNwRUFZYkZjVUFMbkxH?=
 =?utf-8?B?VS9ycmJ3cUwreGpFYkh4K3hIRGJFZEYvcFRiZVVzMk5KTzRJQmVIM0ppOVBr?=
 =?utf-8?B?RjhkWGF5WEdJVHlHM0lQcDY3YVI4MlRIbTVVRkVEQTJUVHJSOGNwZFVuYkQx?=
 =?utf-8?B?RmdhYndFOWk2YjZLZGlhZ1g3dnlNNm9HV0xhRDJIeTR3bnVUVEcyRElmV0F3?=
 =?utf-8?B?MG1vdzI4R3NzNE9iaXkydjdQdjFDa1d0T3hLcGlnYmxWa04rQjZESURJZnND?=
 =?utf-8?B?THBGNTlBQmxsWG16TkRTVmJVMHZZdUVrVldLdFZ2RU9HNm8xakpFQmcrUlhY?=
 =?utf-8?B?U2hHYVYwR25NRUhXNWdUTWJzN2ExSWRvRDcybENabkpQNE05VklWajFkb2lB?=
 =?utf-8?B?b3RHSlBtTWJ4M2FaUThuazM5NzFidENCVnNEOTc5UGx4L3ErcllYOXliZ0Jz?=
 =?utf-8?B?ckoxdG1LeEJiMnRGNG9DRnF6YkdWeHNIVk4vWVVGRjRJRFhlcDhQQTRqdnpp?=
 =?utf-8?B?T3YweDV4WmgwdkxNY2ZleEtxTjJwT1lOSlBoQWo3WGVJWmwyY0lSeUN4Sk84?=
 =?utf-8?Q?dtYsJ9OWp623if9SEkbdGl0zB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff94353-852c-48d5-d84b-08dd8258edac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 11:21:01.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bltIMlc6rT/jaFqloW40kiOk8e+DPYFNT7b+3FuPVtw4KMBZM+7WyZsMh0VWWzLqLZxabLQsU7SRIdVgkp7SrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019



On 23/04/2025 13:31, Michal Swiatkowski wrote:
> On Wed, Apr 23, 2025 at 11:36:08AM +0300, Mark Bloch wrote:
>> From: Maor Gottlieb <maorg@nvidia.com>
>>
>> Initialize the source MAC address when creating the default GID entry.
>> Since this entry is used only for loopback traffic, it only needs to
>> be a unicast address. A zeroed-out MAC address is sufficient for this
>> purpose.
>> Without this fix, random bits would be assigned as the source address.
>> If these bits formed a multicast address, the firmware would return an
>> error, preventing the user from switching to switchdev mode:
>>
>> Error: mlx5_core: Failed setting eswitch to offloads.
>> kernel answers: Invalid argument
>>
>> Fixes: 80f09dfc237f ("net/mlx5: Eswitch, enable RoCE loopback traffic")
>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/rdma.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
>> index a42f6cd99b74..f585ef5a3424 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
>> @@ -118,8 +118,8 @@ static void mlx5_rdma_make_default_gid(struct mlx5_core_dev *dev, union ib_gid *
>>  
>>  static int mlx5_rdma_add_roce_addr(struct mlx5_core_dev *dev)
>>  {
>> +	u8 mac[ETH_ALEN] = {};
> 
> Won't it be helpful to add comment that it needs to be unicast and 0 is
> a valid MAC?

That's why the commit message has: "it only needs to
be a unicast address. A zeroed-out MAC address is sufficient for this
purpose."

I feel this is good enough.

> 
> Anyway,
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks!

> 
> hw_id in mlx5_rdma_make_default_gid() is also used without assigining.
> Is it fine to have random bits there?

We pass hw_id to mlx5_query_mac_address() which fills it.
However, there's a separate issue where mlx5_query_mac_address()
might fail, this is unlikely, but still possible.
We'll address that in a follow-up patch.

Thanks for the review! 

Mark

> 
> Thanks
> 
>>  	union ib_gid gid;
>> -	u8 mac[ETH_ALEN];
>>  
>>  	mlx5_rdma_make_default_gid(dev, &gid);
>>  	return mlx5_core_roce_gid_set(dev, 0,
>> -- 
>> 2.34.1


