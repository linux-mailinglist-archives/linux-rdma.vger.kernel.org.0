Return-Path: <linux-rdma+bounces-6560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8D9F431E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 06:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A50188CA8B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 05:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F6C15533F;
	Tue, 17 Dec 2024 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7pTmSaI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE61361;
	Tue, 17 Dec 2024 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414261; cv=fail; b=LCBmjECmqCJB9dbWrcIQCeV9NRotuo3YN1lbyylvyDlCU6LBJwOIYANAOfw7Zspv13YymD+r+vfwueQg1/iJaEHyP4Va2hrsic+olxEFZQDhx9TOftnDiECFVKXrMd3lWrmuSzB5V50J5fKbb3e5xt4Wp3eP8t3P7HiRDcfsMKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414261; c=relaxed/simple;
	bh=bD1sG4egAvmot6jbj1M+8YL5SrlCJfvpgIUiFRBTIhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ibk+8U1MaJyLQjuRaiD9bjrng4lvOaGcVLa+HcWvdA7kZBFB2lD4vRXxAKHWeJe8xLLjhUwpdZnYS88sNoEBa+IhieRgij+Bx3kcfZzPfQ3ONsjlrAqnEgmn6JdYS4O5uFMTok2e2SR2vOAQwf6LkeHMgUg60PVM8YVbuetDjzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7pTmSaI; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wht+CH4lsEyFKrw9QgKqX6Q2qmZWIJCyma8Yz6yRgAjMF+yTZ0Fvsw1aRR+yE8oxXYV/NzHK8DuJFj1H0zff/leIb3g+RCNHFh7uBN7kUE9i1O4maxVm/7a31jG4pASTdMuYKcQ00P0QnfTXMv5woxukHz5TJnCBBSeF4SJRDimR54ZN5rb9h8RBTULgwGBqFjZAmQumYZ+ZQOFlq8RRK26aMlCm4Udtn6nbPBl2TScqbwCfKfvgEyb5DPc1pUKMrYOIsRRjyTfxwKEvzcUBLWcewsTDKGU9y9eOfRaC6kt7StxV0vS8At5AFxsm2Lr6e/V+PCKI5xBWBFJYqoVgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pd0zcpnobNGHXh/6EwycyvAxWYyS+mr6QUU0JNZh5A=;
 b=I93sgF5wgSdsnOukKtogfPjkMlH7q8NDRFsrUBjTkNEhgzqvHBLQi4Tm+ua+p2nKlDF2ywq93Oen7LntudlzTXdQRFtxTbWtSNQqPqRzHx0yr4a+/hFdVUpRqbPiPw6TNK7V9mnHxK6GItbAvAFUmWF9CqxzkPI7Yk1L9ARaDJbZfh5F7NoSPLrBOoxHrdCadTrjNYspuDjrsPZ6WT3ucRzPDe/k1yB3jx/G2u+i5PBnExDCm69xkuOHYEDgzKWmS5XhYxkZZj/45fCinJEmVNkxWG5Dcy7m7+teVjhAfmcYyEf/HhDje+UN84B4oPz6EAQIkDD4B0BQagBgkLH58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pd0zcpnobNGHXh/6EwycyvAxWYyS+mr6QUU0JNZh5A=;
 b=G7pTmSaIFJ4KYRltAHZMZxwbao6+CB4d4HAKFMjBWud9IoKH96zZcC99ej10zFFzJ6Wm5forAxwrh6bnqrAvKrp9tPEn9GkgR6uuEqE9RCf5GtwMdoGVFAt6JVta+rmH6AIJ+LRUlRrZLt4er2C4i+PUBUnRbVhKN2W9qnsiKyJAzRcwVDHcipX+hCigQaBh+SCPYCd8bfDk53O4+mfOJCX1ien2r3VeeWsGyY4MATFvU2Tj8jKdaesY8HDJIH9AAa8lHOy9unvcasxsaBXKdeBM6wT416kopabtln2gg+IZuE6N1dECHxWCd8720iUDs/8B+A38RIiCkoodhTzoFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 05:44:16 +0000
Received: from DS0PR12MB8443.namprd12.prod.outlook.com
 ([fe80::f2f9:e6e:f9c8:4b8]) by DS0PR12MB8443.namprd12.prod.outlook.com
 ([fe80::f2f9:e6e:f9c8:4b8%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:44:16 +0000
Message-ID: <981b2b0f-9c35-4968-a5e8-dd0d36ebec05@nvidia.com>
Date: Tue, 17 Dec 2024 13:44:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/12] net/mlx5: LAG, Refactor lag logic
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-3-tariqt@nvidia.com>
 <93a38917-954c-48bb-a637-011533649ed1@intel.com>
From: rongwei liu <rongweil@nvidia.com>
In-Reply-To: <93a38917-954c-48bb-a637-011533649ed1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To DS0PR12MB8443.namprd12.prod.outlook.com
 (2603:10b6:8:126::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8443:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a789700-85f1-4b92-e022-08dd1e5dd79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjEzMHRRWHhwWGVyL0FGc3pUdGc2OFZOcGl1R1BFMElHVVlhSExpdHgzakkw?=
 =?utf-8?B?b29OSmhFcjhQc2RKMXAxcUU5dTJnRHBVRllGdnBMZ0lOZGticzhmM0N6T3pk?=
 =?utf-8?B?SXdDYlZJTzJlRHFSanhJMDhYM1NmcC9Wb044ZHhPd0dtRjdzeC9MVnpUUGF3?=
 =?utf-8?B?RTMrTkpPZWZleTRSaTJTZmFEZGtkdDF2UlFmdEdMa3lsUTNFdDZXTDhmSSt0?=
 =?utf-8?B?NVFUS0EzblZGOU84VTNNV3JqcklBWk53ZGNPZHFhcGFqM1Fob280ckNFTSt0?=
 =?utf-8?B?c25IL3JCRWxidzFvMG1KT0tDWjVmQUJLc0hCcGt5Q1hQYjY4YUxJV0duV1RH?=
 =?utf-8?B?OTdwVHczQ3ZmZ2pLVHEzMUZUYmprYlYzbnhvN0hoK2UrZ3hiSzVwSWI1eGJ2?=
 =?utf-8?B?ZSsxb1Jvbnd2SUxmVzMrQWR5SWFpWjdBY1FaUjBrVHJ5cklqVTAvVVU5eVZM?=
 =?utf-8?B?eGxGNWJJbkFoV3pwWUVtZ2pybHEzQ2dpN1pWSkRqUmNJeUpCUXZRKytFOGs1?=
 =?utf-8?B?TTJKOWpsUVlOTjFBSnMzN0c5K3ZPWDgvNU92bWRZV0JkSi9zcEYrYng2V2xI?=
 =?utf-8?B?U0dOYTdFdXFiZUV5bXU1d0p6eDE3K2pBNXJHQkkrT2I0YngyelhOS2RsUjFY?=
 =?utf-8?B?cnNXSWFPeEhma1dRbW9yUWJQTG56VlJ5aGlzWXFSekU1eTVLamFuMElPS1hp?=
 =?utf-8?B?eHhQQUNmWENTLzUrNmtJbFdMN0xqRTJtbzBnT3ArUmhaL2FDZ3oycDg1YXAr?=
 =?utf-8?B?ZGlHSzlHdWVMZnFyZFRZSTI5d0pFN1lJUXhvK3gveFIwNjFKWkNLS0tXd0lO?=
 =?utf-8?B?Q2xiMGE5bTVCZVN4RnNxaVl4NGx1S2JvZGQwTXFsTElaZVVGbm5lRkpIaG9m?=
 =?utf-8?B?Z2JOUFFxYnptc3FFYVR5ajFBMWNwRjBKVmR6QjBLWGU0ODc1NU9vNjNldjM3?=
 =?utf-8?B?bENSVHl5RXlLMHpobXdkT1pEK1NCVHRBVVVST08rK2dVSWRRTCtKSE45aW9D?=
 =?utf-8?B?REllRWwvM05JTTJraThubVBYQ0NJRXdudlQyVmZLTjk0eTByTzRhMEpSVTgz?=
 =?utf-8?B?TjZCOThFNFJ4N0d5REpGQzMxTVNmdVY3Rlg0VjR4ck5VK2srT2szWmx4TkhQ?=
 =?utf-8?B?YjI0cVEyVXVDaHpoN2NBbnprbElIekRqZGtabWlDMk5Ic2NZRXU0K2Qvd1c5?=
 =?utf-8?B?cUYvR29PZFpaUTdLVW9NNm81Mk5yK1lnclJ0aDRDcGpJc0VhNUs1cjZDOGNY?=
 =?utf-8?B?ZWJhUDZKQmVWY2pjZGhqNDZMZEordzJTckhZQXN6OHFxU2JHTHNaTmJyaE1V?=
 =?utf-8?B?YUkrSzdDTGh3WUhITVVWMk1zbkVvcEsyQ3dsZFVoYnNEM2Y5aTBKU0oxUlA4?=
 =?utf-8?B?dE9kN0grd3BOZWhVemVyUTROa3M4KzFJT3FmVmtNNWFPZVdoTnVlNXc2S0hD?=
 =?utf-8?B?bXI0bk5Sc1d1LzY2UUtic3djRk44V3VmWUkzTUhZWWhhWi9qbnp4NTNObjNp?=
 =?utf-8?B?Z2JEMnNRcnpCYTc1eUhmVVRuZjJyTUlBMU90bXFZVW4yMXUzYS9kamplUGVS?=
 =?utf-8?B?eWl3MWg2K3FjTEw1N21MMEVGU0JDZmZ1N1hQNk9Hc1pDQXVmaWhMQUFGUW1s?=
 =?utf-8?B?Um4yb3ZHWC94SVkyWUNpOVo3ejcvL0s5c3FPNFdubnNVVEg3b0FBQ1ZZUjRJ?=
 =?utf-8?B?b000MzRPV2NKb09qMWVsVXNMdFhzUEhHazY0czdOR2dmYzFWWjVpbmZKSnNP?=
 =?utf-8?B?dFNEY3JJQ0E0QmxwMVdjM2lFL1lDVnB4QWdDVzcvVmpUN1h1bnhSQkZzR0NI?=
 =?utf-8?B?UWlPQU5lY3FoN29zU3d0UDZHK0ErZ3ZLaG1GUVUzSWt3MWhyU1kwNXpqcWEv?=
 =?utf-8?Q?kUcyg5iB8jeBz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8443.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3g3VHB5MWRKWFZyTzBRUk5TeXY3U2FxWXM0dERrUVh6aGl6VmJSOHdzVEFI?=
 =?utf-8?B?U1YrOFZ0TWlKMHVpRGtpbW5kbStQTnFqZHkwbnVQUjd0bFZiZm12VU9obGJZ?=
 =?utf-8?B?MmFUVU5XdUZpQ1pOZWJNQkhQOTduUWNiZGhrbW1aY080SXNNaUV0TzJTakZC?=
 =?utf-8?B?MkhCVEVTRFA1STJGYXFaVGRJSUNUK2lBY2hzcXdjcVZ4LzZORWJLU3I4Z1Bm?=
 =?utf-8?B?aVhXeDVRZElkVXRwTUgwekdaQmFhNmtlenMrNmxTdXVCd2syUUVPTVplNTNl?=
 =?utf-8?B?VzFyU2pRb3BIVjJHdkI5T29TZ2pXQnBWK2pVVytUQ3VsRG9PamVNRVZHaXZr?=
 =?utf-8?B?RUduRHVETXJrcWZ1cWRJYmZDV0dLN09LamtXbjZIaG53Um9CblR1SWZudU1F?=
 =?utf-8?B?b1hlZCswL2xXZ1haa2ZLNjIwUVFlcmZJODN6ZmRFSU9VM3dybmhhSEVvS1dV?=
 =?utf-8?B?TFdyazk2cVFCKytBM1RBc05kZk1WOHlsVDVVZVk1WFBiSlpjZGdUTWUwS1Zk?=
 =?utf-8?B?NW80MnNWdTFnZ1NwNlB6cWdoL0Vobnl3V1BzY2UzQUI0VUJ3TmhER0drWjRy?=
 =?utf-8?B?RE9NTmdFQXZmOTlTbHdoQk9LQ2dJWENUM3hZaVYxWUExTU5kcWkzOWhSWStY?=
 =?utf-8?B?TzVDVDRPQXNYN0t0MU9XZVVISUQzLzdVbnR3NEJ2OHVUWVVnM0kxcG1HTzBo?=
 =?utf-8?B?L1BaMWFhUFBESzVjakZBd1R6RHB1VjJyTWtwam8vQlh0aVAvdXNIbUcyb2I0?=
 =?utf-8?B?MFNReVRVbWpVdm5HT3hrMzNGbzhHdDVTU3drV3RRTFR5cGYrT0xBZ0U2dlRX?=
 =?utf-8?B?cndqU2d1Uk1pUlNMQ21vdVNyNzhSRU51ZHIwMG11N3dFUmdDTFhmdWF0MlBD?=
 =?utf-8?B?dlZDRlpydEV4RmJzbllDT1JsTGpNRHdkSTZnay9WL0lYM2hWeEpZSHlIYVBT?=
 =?utf-8?B?aU5yRVJmQzEzWjZoblZVTWF4TmpvUE9lNDBrdTAzcno4V1VkMkRqMGtIVmE2?=
 =?utf-8?B?OXpPL2NVMFBZNi9IRkhkcVE0eTRZYmxyV2tRNlpSMy9OYk53K0RRQzFpM2Jt?=
 =?utf-8?B?VWdxTU14NkYrVkwwYWYza09hSy83eXBPVXRyOVRYc0tBTGxmRkJHNmxxZ2pG?=
 =?utf-8?B?MkxEczJ5VTZVa2hBWUdEWlVndmVhZXNEYlpjWHdBaEJseTNMT3g4NkZjQU9N?=
 =?utf-8?B?bkZrL29Jb1ZJVm94R2Y3NDBiRmdTT3h5dmZPZ2ZLdzV1YTdJd3ZmNkFnZUhz?=
 =?utf-8?B?RnNHOGVGbHcvaitKQ1lPbEpRUHAxWjMxak83d0krSmM1Uy9GSnZkSE1mSHlT?=
 =?utf-8?B?Wkp5dVdaSXJqU1N0Q2Y1dGduelphZnphUEo3Z1k4bzVzM1pQck9sTHlZZUc0?=
 =?utf-8?B?QmdhUnlvNU0rVHgwUVlMWjlFVDdacVIybE1BdUlUaGd6SGJoUzIxR0FRZEYw?=
 =?utf-8?B?bU9ybkpMNktvQXlxUTJhVHRFdGxZWWpaQ0pnTkx0K3JCZ0lwVGlvQWo4OVM5?=
 =?utf-8?B?aTZ2bldBSkFHQkR3YjZsUmpHUmVrVzhtTUpPYndkaThVQ0Uxc0VQVzlFV3gw?=
 =?utf-8?B?RnFCVjNpTEJEdGJDeW1iVUExOTVxdzdvZUpIbGZ1b3NZbDdFR0t0TnUyNmFa?=
 =?utf-8?B?by9MK3Q5WTZWZU5lTG4yUTVzNGFibGYwaEJ6OFRFemd1eE9ROUw0YXNLNURj?=
 =?utf-8?B?WWYvdGRKSVl2NFAzZERJN1JLK1BTdVhlbFlrV3N0MTI0bTUvYXgxZ1FSTC9i?=
 =?utf-8?B?Uit2TFl6WHNrOE50TitDTk9XS292K1J4TzR2WjFxbFNQem5wbCtaeEg2NW1E?=
 =?utf-8?B?UGNJUzhXYTRLSy96azhDbHZPMXJXZW5qZTVGWHNQUHJka3gvN3VZZC9wOU82?=
 =?utf-8?B?RDg4Zm1TWmwxWjM4Z0J3SjJkekJWQklWMjF1SzZSZHBQZXpITk4vckJLbVJV?=
 =?utf-8?B?c1RxVUtNZ3FPdlpNdG1JQ1lxZjgyZVoyaVc2d28xTnZnUVJmeGthRDBTNlFP?=
 =?utf-8?B?QXYrMk9MaVBWOFlIZldxQXkvVzdhQnloOEpCZDNFa25tMHlKR1Q0dXBQRDlO?=
 =?utf-8?B?QVg3V21MQ3VnOC9nM1JESHZUMit0cEIwdXdvdGFUZEJPZnplbnN0YUtENmdq?=
 =?utf-8?Q?XYxWR0VvVtIrdnBgDF0ktncpy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a789700-85f1-4b92-e022-08dd1e5dd79b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8443.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:44:15.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIhLiWt1GwiRI0wWaHsgPIJWuK1UByCRejfKszGIRNk1EkgXNBQZ47UB7oiaMiuc4GZmEoqCQ6BVZajJJgq75Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865



On 2024/12/17 01:55, Alexander Lobakin wrote:
> From: Tariq Toukan <tariqt@nvidia.com>
> Date: Wed, 11 Dec 2024 15:42:13 +0200
> 
>> From: Rongwei Liu <rongweil@nvidia.com>
>>
>> Wrap the lag pf access into two new macros:
>> 1. ldev_for_each()
>> 2. ldev_for_each_reverse()
>> The maximum number of lag ports and the index to `natvie_port_num`
>> mapping will be handled by the two new macros.
>> Users shouldn't use the for loop anymore.
> 
> [...]
> 
>> @@ -1417,6 +1398,26 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
>>  	mlx5_queue_bond_work(ldev, 0);
>>  }
>>  
>> +int get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx)
>> +{
>> +	int i;
>> +
>> +	for (i = start_idx; i >= end_idx; i--)
>> +		if (ldev->pf[i].dev)
>> +			return i;
>> +	return -1;
>> +}
>> +
>> +int get_next_ldev_func(struct mlx5_lag *ldev, int start_idx)
>> +{
>> +	int i;
>> +
>> +	for (i = start_idx; i < MLX5_MAX_PORTS; i++)
>> +		if (ldev->pf[i].dev)
>> +			return i;
>> +	return MLX5_MAX_PORTS;
>> +}
> 
> Why aren't these two prefixed with mlx5?
> We can have. No mlx5 prefix aligns with "ldev_for_each/ldev_for_each_reverse()", simple, short and meaningful.
>> +
>>  bool mlx5_lag_is_roce(struct mlx5_core_dev *dev)
>>  {
>>  	struct mlx5_lag *ldev;
> 
> [...]
> 
>>  
>> +#define ldev_for_each(i, start_index, ldev) \
>> +	for (int tmp = start_index; tmp = get_next_ldev_func(ldev, tmp), \
>> +	     i = tmp, tmp < MLX5_MAX_PORTS; tmp++)
>> +
>> +#define ldev_for_each_reverse(i, start_index, end_index, ldev)      \
>> +	for (int tmp = start_index, tmp1 = end_index; \
>> +	     tmp = get_pre_ldev_func(ldev, tmp, tmp1), \
>> +	     i = tmp, tmp >= tmp1; tmp--)
> 
> Same?
Reverse is used to the error handling. Add end index is more convenient.
Of course, we can remove the end_index. 
But all the logic need to add:
	if (i < end_index)
		break;
If no strong comments, I would like to keep as now.
> 
> Thanks,
> Olek


