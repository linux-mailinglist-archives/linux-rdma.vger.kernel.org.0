Return-Path: <linux-rdma+bounces-16887-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJcqJP/mkGnudgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16887-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 22:19:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324013D4A8
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 22:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEE230226B8
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Feb 2026 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D425F994;
	Sat, 14 Feb 2026 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="smbBVmzK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F415687D;
	Sat, 14 Feb 2026 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771103993; cv=fail; b=IKzClf4FhBNPu9v78PxBUCZ/L5qpNIKCJ/UVTqh02FlcuzuMzgIo2DKyKooI7rGgY3HAvh+uQh5uVRFmXkti4KfOxrm/Zv09n6a706bvbiRiFKzWoF7Pd4W5k+9NQdIOQcrjmYMB97LeeYzo828IpAu5m9vPHeSsca4/4qzntwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771103993; c=relaxed/simple;
	bh=TlkGfwz8xBplsvovZmrgiMUcevBDWopQ1UVF7Vn3gIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SkUr8h3EXkOQbIyb1qqr6Tr7zPyjDG9YnQ1JO3XAf7VQepxbmSUy/YGR0RA3Qn7kBJuQ7HDG8NIHwj94QO7/LJst35P1CeKaunKhFepfd7AdfYW4E1We38dJYWA12T/iRYRRKlXppleuuxoWf8bVzgjKrJ9mYpWNaWaWcKrVd34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=smbBVmzK; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzqHICju/c7OPFkSXzOc7duSsNzlOBuq01S57hvjqxjKl8ScjfSQst7GsdFlspunT5WrwPJe2wXVazhe/3uYjvI7sMUlxqo0HJx8ZuJWC+MtZ8hjLf7MOi8bamlZ/fSrp1HIsgIH8besSGtnm00dEWi1ZjFxMk/Nv0pxTco4JBiU4X1sRsPrH+fEQk4DQK+PgxqgZrjgqnxRCVPya9RdDSHZulqfhiTjzXlvrrZUEDWSFNJjxcRF+PFPNPWJmBh196UXKB4N3MEhAzsZC3f/ofetqXECM7zKwX6KrhlZ2XD08gbS//UUka7aRsRvjv5IJkdwvBqy2dxPnWGYBxylIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlkGfwz8xBplsvovZmrgiMUcevBDWopQ1UVF7Vn3gIo=;
 b=GTgEjeUfTNF9CEvA6PJuKV4Sj6kbp+DyAraCqyEq6lJexXIlVCzJwHO3gQznXFb2FKFI02NTgUrkSux8Az/VRtyjNJMreFdtrtPNoj4G8ksS59i6g+4Et621V10jRDGDg1Zv0g0/3QtRP9POoh/N8bJdAekOgZjyr0ZkZz/fvLMZoSqi6lEwHA+IwFQuUPcDPtuGMduUwaPppYD4zB06/v2//5K1Hb52y0bMBXy9iFCPnnDhg+55nHUqOKcMXmyjyA5uv2oB4TRrkSbYaah1pgG7zAS2QRmvdF7qnYZeKWEtxUjSLCljIfvaS9GkfRcMy4IPCht5YTyPsTzeBBqTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlkGfwz8xBplsvovZmrgiMUcevBDWopQ1UVF7Vn3gIo=;
 b=smbBVmzK1gvBcObbI7vrYzIJgKBfwEIZEUHe+/+IqaJsUWtBaKnjx1sAA4Rq7YfXPRcXc/ENXoZlQABn8t/C3MLN+9UpRtI+BvnW+NgGdQ1MieKsee36LmNSp0zvNi+11KRpookh0eGIz9wERUfBJibr89AczK1zeDSQ95/+ppaOwNVHCwpWIt/PwI4FlpUihc13AtxlyTnm/lACkudYkN7yK4H//Pop3GjQj4zJPFfLMtrrCeFCovDjgFe5yjez1SJJi5ZN+Xgr9reetpLDnJnDvQRPd8cVRbEhs/Z9nR1UfEHaGz1dR2p7yUDDyow45Kyv5HIC4WuTodoAthfztA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sat, 14 Feb
 2026 21:19:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 21:19:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.19 kernel
Thread-Topic: blktests failures with v6.19 kernel
Thread-Index: AQHcnL546UP/dHCUV0i3P4Kt4vejdLWAZHmAgAJRVIA=
Date: Sat, 14 Feb 2026 21:19:47 +0000
Message-ID: <f26001d6-062e-402b-8acd-46a737523e23@nvidia.com>
References: <aY7ZBfMjVIhe_wh3@shinmob>
 <6ad314f7-f3d2-495a-b1ef-a81a06498952@flourine.local>
In-Reply-To: <6ad314f7-f3d2-495a-b1ef-a81a06498952@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYXPR12MB9388:EE_
x-ms-office365-filtering-correlation-id: 833f4e5c-1138-449c-53ab-08de6c0ec82f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXMvODdGaldieTlTcXRuSDhyRERSQmx4RW9QOUVsc2QvckR3S2h0U09zNkJT?=
 =?utf-8?B?c0xvQXI2VnlJcERKUWhTOTEzQVZEOUJKai8yOUxjSmhUK0FxV0FuMmZ2MTdR?=
 =?utf-8?B?WTVyQmpaRER2UWVkeGZsbWFnTHJvU3hpTWVyNHY3K2Z4M0ZXOGYwNHNPdlJ5?=
 =?utf-8?B?Rks3aGF3K3lBZDY1SDM2KzhKY2FDRHBFY0lpZkc2em53bEhxdnY5bnRwSk1k?=
 =?utf-8?B?Wkp3SzV3bFdsQjR1cUVBWUQweWZIV3UrWDhXTWJVMHBsTGRqWWhvbjQwdlRa?=
 =?utf-8?B?ZkE4NDVkbXFMZk5RSFpzc29sZVVlMWhxK3IvamdCS2NsUTEySGU5aTVVL0lr?=
 =?utf-8?B?elhpRDE2ZU9rSGg5UHN4dlpnLzhvbzJob2VwYVhFVS9XS3BjdktvZVd6L1g1?=
 =?utf-8?B?b3VhaytPeXB3cE0rNytOV3lmU041SFl3TEFCUFJwQlplV0NXaDc4aW1VUUR1?=
 =?utf-8?B?cm93Qnh3cytscEp6ZjRFejZqZmJnQUcveUgwOWl0ejhZajVIRzBHV2JGa1ZR?=
 =?utf-8?B?Sm5UQjI1d0VuSFI0MDNQZlNUWXpkUVkzTlBuQk83eDYxenJ2QmNOcFQ5WlZs?=
 =?utf-8?B?WnpueDZEUkxUaGl4ZWZ1K2tGZWZJUmlaMjdIbFUwSXBnS1lBbWRsejRHY3hM?=
 =?utf-8?B?L0gxZFAxSTMxVnFxV1lpUmp1SzRoYVd3a0lDbGJkejhJcGFFV295M3RuRm9O?=
 =?utf-8?B?NDZTUmRjUUZ1cGZGYmhITWJtN21LWXlzS1hJN2kxN0F5dnk3cEw2TmRFUzBy?=
 =?utf-8?B?NDNkMHNvbVl6WmhXcGhLNzBlY3hURDlmWWZmOEh0cG1XelJPWkR3R1I1amNj?=
 =?utf-8?B?VEFCRFBzSitPd0EzbW9wRUJIbW13T1FzNkswZUoyVzl2bkNTa2tCK1plU0xa?=
 =?utf-8?B?eWpmUTFrWFhMMzZ4SGlyRlE1VUVnM1RXV1NFeFVXZ0M0VE9ramVsTmJrQUJq?=
 =?utf-8?B?ekVsOUhXQ1A5UVl4ZXY2OXVuQUhpQ29nSWRVMy9mZ1Y2emhwL1htT3hHaEZu?=
 =?utf-8?B?anhVQlIyOUZVcHUxYjFZL2JISEZYbnk4Q1lnOGRDOGh2VmhmMVU1eDJ3K0JU?=
 =?utf-8?B?SjJ5YndVbEZodUhzNkVZWjBoQnhNYm1kNWVrOUtrdDR6VlFkaWlvcGxlcnE0?=
 =?utf-8?B?WUFiT2k1L1ZYOXZvZUtURmxWdlRjbzl1UmRTZlRQa1IvaWVxMmxrelZ2UTBY?=
 =?utf-8?B?Vk5VMEljSzZjdGlRaGU1V3R4a2dRSUJYSitQMy9pdUZyYjNzOGNubXNvZFA0?=
 =?utf-8?B?cUh2MGVneUl4RzU2K1NqOUlMZlpJdEpxRmNXMnlTL05pUG01SGJhWllFUWZY?=
 =?utf-8?B?TldSWHNoYXN1cjdqWFBpaUI3aUJJOHR1SG4yRVFYVm1NbzRoblZFV0FaWXFK?=
 =?utf-8?B?d0ZielZ0ZGpYRWJVQlE1QmZieWNoMjdCckdaVXpaaGFzTUFEUXVzN3E1cXNl?=
 =?utf-8?B?TXhLck9LY0hIN2F5ckV5WGV2cERZOG5Oa0MvSkhjdTVSVXpZd05xR2RtNVJR?=
 =?utf-8?B?VlFxVitNWk1xb240ZDduaEZQVkxkazJnTnhBNm0wOEZ5Mk9uQzFpdzY3aHZq?=
 =?utf-8?B?YW9Vc2xPTm1zQVZEMnAxUnVBYy9ObU1mbHVHekhOVmg5MVdLVTA3bllyd2VE?=
 =?utf-8?B?dm9LRjl6ejNIMTdBdDh3bkFLa3M2azlwczR3RjZrUmR4bS9paU1OaDBtdm82?=
 =?utf-8?B?dnV4dHZBRHJNMzRhOW5qdjZqOVI4TFNhY3JobVpaQ0h1MkZ2Yjc1Ly9LV1VF?=
 =?utf-8?B?OUZRcWU5cDFtbkNEU2hPWFBnOWpIOGFrbWdKY040cWJRRTdwMjFheW45dVBp?=
 =?utf-8?B?dkl1MWZoTEFYTStMaDM1Y0JidjVPRU94c0dzUDZscVR1S0ZCZGpGMjZMVXFQ?=
 =?utf-8?B?U043L2hTN2d6MTVmKzZPMnJYSzBpZkFqMWRob3d2ZWlHR2lXREFmM2VYeFFD?=
 =?utf-8?B?Z2hDcTlLWGcvaWxzZThqSHFvM1BRa0t2ZHUwSHBNL054bmErYVkwcnA1RlNt?=
 =?utf-8?B?YXlMUFBWNktJVFJFSE43YTU5eXY2US8zdWRIeFZiRlhiaks1SzFKRFBvY3hv?=
 =?utf-8?B?SjZjTFI2S3RXMGpSQ3ZRaFNSeXpMZDRQbE9LZDlSMDhZcjZOVTRRZVMyZldu?=
 =?utf-8?B?NXFSVUZUWHhhK3lVWFNjZWZjV3dmdXo3OE52Qy9BWmNpNnl1alFMaXd5VllO?=
 =?utf-8?Q?/owVBvMGR+ac1RQihJxb1wQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MktuT0dJbno1eWhCVGJlckliVS9salg2dENWVjdjQVFJZTloMW9jSGVqK3d2?=
 =?utf-8?B?QUwrZSt2VWFaM28xVk9mcW5sb2N5dFhhNlhwRGRWbnJSTmVLZEFFNGdZVHRo?=
 =?utf-8?B?ZXZhMExTb1lTY3gwUEpqZU9yLzE2ei9qVUFvejJHbHNHM0w3eXhjT3dVbnQy?=
 =?utf-8?B?MzlMaWxsUURvMDVXVFJrWm8xTXFtZGVseGQyWEs1NjJkMzRzNXJjR2VKbUs2?=
 =?utf-8?B?TDc1aitJYURURUxkNU5kd2JQUFAySU0vNGZkRnZqb1Vldjd0THQ1NldlNjRF?=
 =?utf-8?B?Zm5yYUFKL2lESUxac0MwUlBzdDJScDRjaHlwbWNoQmtBRnJsWFY3MEkrcEJz?=
 =?utf-8?B?bWpkY1BFNVpoUm5naEJqcnhkVEVLRmhoUXMwS1ZqOVlpOE9hcVFnQzIyMFh6?=
 =?utf-8?B?UUwvR3ZmWGFPU0RkU1RwNXk4RllQK3A4MWhQVHJHMjNPK05udHlITUUvNjVj?=
 =?utf-8?B?MGNHcGcvVmtMNnFQd1RybmdVc1pGbGxpVEp0V2xrSWN6TEl6eXN2T3M4bVNV?=
 =?utf-8?B?UzVJOC9XaDZyUCtSdTkyZlF6Tm00aFFwejJWUWlkc2k1ejI1ZVNjZmIrUS9J?=
 =?utf-8?B?QUxRNTBCZjVYL0xUcStJNldhZzF2eVN1RS9DZUZEMUc2enZza0JoTkdvN2lV?=
 =?utf-8?B?eHVTUUJpSHdBNlROMldJQXY2Z0dRZU1aek9jWGI1Z1B1YXV2dGRUY3RUTU1m?=
 =?utf-8?B?Mm1jb3A3Q2tBRlhLcWRaZngvSFBRYU9WemxPY0QrMndXMzhiU1lGa01ra2Ji?=
 =?utf-8?B?dk1SQmNHc1RRZmJsdU1rKzI5MW8rRnplUGJrTlk2eHpRY2RJL1p0OGEwYnR6?=
 =?utf-8?B?VkJEWndKM2lHbUVCK3diQ2hvdTlCYlVpdU5rVzltT2s1SVBGOEMxTnVHQTM3?=
 =?utf-8?B?L1NJdjhaV0pYd1ZkeitDTG5DME0zYkRrVCtWdXZBU2djS28wRUdiZzhNSzVR?=
 =?utf-8?B?S05GYk9mcWF0Y29YVXY5TEZaSGlIenBTVVR5VWY3bGF6THpDajdFbFkyMkpY?=
 =?utf-8?B?MXIxeWF4dVFqZDNzWFBSank1OVZUNTVxWWE0Y1U4dWdrSWYySUZGZU1uOUE3?=
 =?utf-8?B?d0loWFhaL2YwY3BuLzZvcUhGMWlGR20xak1wd0k2V1U3bytRbWxYalpRRE5t?=
 =?utf-8?B?OS9PODFhaVJlRWQ4M1MrQTJDNnRuTldVY3ZVNW5pTXFzQzlVRE5YNjBrenQr?=
 =?utf-8?B?RGlEMnBTWUt1S0hVSTA4ZG5WZ0Z1TTVsRVpSZ29FcHNXbElIb0hLWHJlMzJV?=
 =?utf-8?B?anFkRWxSYjNndjQveFdONjJQRlZaK0ZqZ0wxMW1oTkNPZ2dhaTRSZ0lSMm5C?=
 =?utf-8?B?cEllNEI2Smk0THMyczRqT2VNY2pYQVVBYU91UDFrRkszaHhoUWRpV0piaE1P?=
 =?utf-8?B?TlNUcWRMM0NXKzlwNUJoWGhrQ1IxdmpMQ2YrRGRINGNocjB3SExnUGEraHND?=
 =?utf-8?B?VnpvQnM5NllKdXdIYTI0bGFtTlJSNHdpdkZZMWlyRlN2RzF3Q2ozKytTb2NK?=
 =?utf-8?B?STgxN0FNSDZKZll2cjl3ZFpEYjgyQWxtTnNvTjdZUGovN05ObWxydkJ6cEdI?=
 =?utf-8?B?S2QrRWJCRmVmeFhPa2VjcCtNL3diYngzUGdQMXpuNHFtbmgrZjAxckNHQWpj?=
 =?utf-8?B?VE1kNVNPdFcxWTJ1Rit2UC9ZeFlIUjViVTN2SStZNzZlYWVPZnczbmlEWWxT?=
 =?utf-8?B?azE4d3ZmNlRVdXZIanhnY211L1JYTDA4TXRxNEVIcVJXTEc3UWlnVS9Ja256?=
 =?utf-8?B?UWFqZGpySW1zOEYreUJkVy94aDk5c3JpQThCZjFZMTJ2NzVIWi9WVzBHZjQv?=
 =?utf-8?B?aGg2aTV3M0pYL21pZzF0U0R4UnkxN0dnbnVKZHdDd0p4Wkhxd202ajVwVElx?=
 =?utf-8?B?VVRxNTdNaVIyL2pnclUxOWk1QzhMRVhyQjl4T3AxdTdmWC9Fbjdlc1pvelpJ?=
 =?utf-8?B?a2lNcjFFL2xoTVVSa2xpZ2JQbW9McnAxS0FLZ0puOUwrOU92S0E5VkVCKzdE?=
 =?utf-8?B?VFVaS1pxOVcwRTVXYk5kOUl5ZENVTlByckhVWkdYNS9EbFIwOXlqdWtMSXZ2?=
 =?utf-8?B?bC82V0VqbE1zdmpmQ3NacmdWU0hHS0o3MjJJTkdpQUp3bkxucnlTTGhJekNX?=
 =?utf-8?B?NlREOGp5eDNjTlZLc2x6UU1jMXd5L3FhcFNWQ3NZdyt5NjdHUUpDaFpDdHJI?=
 =?utf-8?B?N1k5aVpMeWp0S1BYaDRuVzg4a2ZDalJ1a0tTT25LVHg4Y1hsck44aUFlMlRy?=
 =?utf-8?B?MWxiMG9KSnNsakM2NU1vcklMMFRaWmdDd3hUeDZhaXB4VjZobSthRUZNRkhk?=
 =?utf-8?B?YmRJMVFZQUFqODlpdkUrZENaM0MzN1pqWW1FRU16L0g5b3J6OE5hNG03aVVw?=
 =?utf-8?Q?6FzFavmw2J+DUU9wb2x7k2jzoKvtr26ERzpMZU11mVriO?=
x-ms-exchange-antispam-messagedata-1: M+0E2fYmZkb4/Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AFF0D05CC60894185D02EDADCEF91A0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833f4e5c-1138-449c-53ab-08de6c0ec82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 21:19:47.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPBqoB1KdbdYloiuj+v+L6HKxvZm4fzNFzoqsyeSeie8BjnNV1dJ7o4LK8NgHEnVRS2vp5cB3DBBVZNrgu5imw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16887-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanyak@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 3324013D4A8
X-Rspamd-Action: no action

T24gMi8xMy8yNiAwMTo1NiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gbnZtZXRfZmNfdGFyZ2V0
X2Fzc29jX2ZyZWUgcnVucyBpbiB0aGUgbnZtZXRfd3EgY29udGV4dCBhbmQgY2FsbHMNCj4NCj4g
ICAgbnZtZXRfZmNfZGVsZXRlX3RhcmdldF9xdWV1ZQ0KPiAgICAgIG52bWV0X2NxX3B1dA0KPiAg
ICAgICAgbnZtZXRfY3FfZGVzdHJveQ0KPiAgICAgICAgICBudm1ldF9jdHJsX3B1dA0KPiAgICAg
ICAgICAgbnZtZXRfY3RybF9mcmVlDQo+ICAgICAgICAgICAgIGZsdXNoX3dvcmsoJmN0cmwtPmFz
eW5jX2V2ZW50X3dvcmspOw0KPiAgICAgICAgICAgICBjYW5jZWxfd29ya19zeW5jKCZjdHJsLT5m
YXRhbF9lcnJfd29yayk7DQo+ICAgDQo+IFRoZSBhc3luY19ldmVudF93b3JrIGNvdWxkIGJlIHJ1
bm5pbmcgb24gbnZtZXRfd3EuIFNvIHRoaXMgZGVhZGxvY2sgaXMNCj4gcmVhbC4gTm8gaWRlYSBo
b3cgdG8gZml4IGl0IHlldC4NCj4NCg0KQ2FuIGZvbGxvd2luZyBwYXRjaCBiZSB0aGUgcG90ZW50
aWFsIGZpeCBmb3IgYWJvdmUgaXNzdWUgYXMgd2VsbCA/DQp0b3RhbGx5IHVudGVzdGVkIC4uLg0K
DQogRnJvbSBhZDU4ZTk3OWFiOWEyZDRhN2NjNjIzNGQyOGYyZDkwYzE3NGU0ZGY5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCkRhdGU6IFRodSwgNSBGZWIgMjAyNiAxNzowNToyNyAtMDgwMA0KU3ViamVjdDogW0lOVEVS
TkFMIFBBVENIXSBudm1ldDogbW92ZSBhc3luYyBldmVudCB3b3JrIG9mZiBudm1ldC13cQ0KDQpG
b3IgdGFyZ2V0IG52bWV0X2N0cmxfZnJlZSgpIGZsdXNoZXMgY3RybC0+YXN5bmNfZXZlbnRfd29y
ay4NCklmIG52bWV0X2N0cmxfZnJlZSgpIHJ1bnMgb24gbnZtZXQtd3EsIHRoZSBmbHVzaCByZS1l
bnRlcnMgd29ya3F1ZXVlDQpjb21wbGV0aW9uIGZvciB0aGUgc2FtZSB3b3JrZXI6LQ0KDQpBLiBB
c3luYyBldmVudCB3b3JrIHF1ZXVlZCBvbiBudm1ldC13cSAocHJpb3IgdG8gZGlzY29ubmVjdCk6
DQogICBudm1ldF9leGVjdXRlX2FzeW5jX2V2ZW50KCkNCiAgICAgIHF1ZXVlX3dvcmsobnZtZXRf
d3EsICZjdHJsLT5hc3luY19ldmVudF93b3JrKQ0KDQogICBudm1ldF9hZGRfYXN5bmNfZXZlbnQo
KQ0KICAgICAgcXVldWVfd29yayhudm1ldF93cSwgJmN0cmwtPmFzeW5jX2V2ZW50X3dvcmspDQoN
CkIuIEZ1bGwgcHJlLXdvcmsgY2hhaW4gKFJETUEgQ00gcGF0aCk6DQogICBudm1ldF9yZG1hX2Nt
X2hhbmRsZXIoKQ0KICAgICAgbnZtZXRfcmRtYV9xdWV1ZV9kaXNjb25uZWN0KCkNCiAgICAgICAg
X19udm1ldF9yZG1hX3F1ZXVlX2Rpc2Nvbm5lY3QoKQ0KICAgICAgICAgIHF1ZXVlX3dvcmsobnZt
ZXRfd3EsICZxdWV1ZS0+cmVsZWFzZV93b3JrKQ0KICAgICAgICAgICAgcHJvY2Vzc19vbmVfd29y
aygpDQogICAgICAgICAgICAgIGxvY2soKHdxX2NvbXBsZXRpb24pbnZtZXQtd3EpICA8LS0tLS0t
LS0tIDFzdA0KICAgICAgICAgICAgICBudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29yaygpDQoN
CkMuIFJlY3Vyc2l2ZSBwYXRoIChzYW1lIHdvcmtlcik6DQogICBudm1ldF9yZG1hX3JlbGVhc2Vf
cXVldWVfd29yaygpDQogICAgICBudm1ldF9yZG1hX2ZyZWVfcXVldWUoKQ0KICAgICAgICBudm1l
dF9zcV9kZXN0cm95KCkNCiAgICAgICAgICBudm1ldF9jdHJsX3B1dCgpDQogICAgICAgICAgICBu
dm1ldF9jdHJsX2ZyZWUoKQ0KICAgICAgICAgICAgICBmbHVzaF93b3JrKCZjdHJsLT5hc3luY19l
dmVudF93b3JrKQ0KICAgICAgICAgICAgICAgIF9fZmx1c2hfd29yaygpDQogICAgICAgICAgICAg
ICAgICB0b3VjaF93cV9sb2NrZGVwX21hcCgpDQogICAgICAgICAgICAgICAgICBsb2NrKCh3cV9j
b21wbGV0aW9uKW52bWV0LXdxKWkgPC0tLS0tLS0tLSAybmQNCg0KTG9ja2RlcCBzcGxhdDoNCg0K
ICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgIFdBUk5J
Tkc6IHBvc3NpYmxlIHJlY3Vyc2l2ZSBsb2NraW5nIGRldGVjdGVkDQogICA2LjE5LjAtcmMzbnZt
ZSsgIzE0IFRhaW50ZWQ6IEcgICAgICAgICAgICAgICAgIE4NCiAgIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICBrd29ya2VyL3UxOTI6NDIvNDQ5MzMgaXMg
dHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoNCiAgIGZmZmY4ODgxMThhMDA5NDggKCh3cV9jb21wbGV0
aW9uKW52bWV0LXdxKXsrLisufS17MDowfSwgYXQ6IHRvdWNoX3dxX2xvY2tkZXBfbWFwKzB4MjYv
MHg5MA0KDQogICBidXQgdGFzayBpcyBhbHJlYWR5IGhvbGRpbmcgbG9jazoNCiAgIGZmZmY4ODgx
MThhMDA5NDggKCh3cV9jb21wbGV0aW9uKW52bWV0LXdxKXsrLisufS17MDowfSwgYXQ6IHByb2Nl
c3Nfb25lX3dvcmsrMHg1M2UvMHg2NjANCg0KICAgMyBsb2NrcyBoZWxkIGJ5IGt3b3JrZXIvdTE5
Mjo0Mi80NDkzMzoNCiAgICAjMDogZmZmZjg4ODExOGEwMDk0OCAoKHdxX2NvbXBsZXRpb24pbnZt
ZXQtd3EpeysuKy59LXswOjB9LCBhdDogcHJvY2Vzc19vbmVfd29yaysweDUzZS8weDY2MA0KICAg
ICMxOiBmZmZmYzkwMDBlNmNiZTI4ICgod29ya19jb21wbGV0aW9uKSgmcXVldWUtPnJlbGVhc2Vf
d29yaykpeysuKy59LXswOjB9LCBhdDogcHJvY2Vzc19vbmVfd29yaysweDFjNS8weDY2MA0KICAg
ICMyOiBmZmZmZmZmZjgyZDRkYjYwIChyY3VfcmVhZF9sb2NrKXsuLi4ufS17MTozfSwgYXQ6IF9f
Zmx1c2hfd29yaysweDYyLzB4NTMwDQoNCiAgIFdvcmtxdWV1ZTogbnZtZXQtd3EgbnZtZXRfcmRt
YV9yZWxlYXNlX3F1ZXVlX3dvcmsgW252bWV0X3JkbWFdDQogICBDYWxsIFRyYWNlOg0KICAgIF9f
Zmx1c2hfd29yaysweDI2OC8weDUzMA0KICAgIG52bWV0X2N0cmxfZnJlZSsweDE0MC8weDMxMCBb
bnZtZXRdDQogICAgbnZtZXRfY3FfcHV0KzB4NzQvMHg5MCBbbnZtZXRdDQogICAgbnZtZXRfcmRt
YV9mcmVlX3F1ZXVlKzB4MjMvMHhlMCBbbnZtZXRfcmRtYV0NCiAgICBudm1ldF9yZG1hX3JlbGVh
c2VfcXVldWVfd29yaysweDE5LzB4NTAgW252bWV0X3JkbWFdDQogICAgcHJvY2Vzc19vbmVfd29y
aysweDIwNi8weDY2MA0KICAgIHdvcmtlcl90aHJlYWQrMHgxODQvMHgzMjANCiAgICBrdGhyZWFk
KzB4MTBjLzB4MjQwDQogICAgcmV0X2Zyb21fZm9yaysweDMxOS8weDM5MA0KDQpNb3ZlIGFzeW5j
IGV2ZW50IHdvcmsgdG8gYSBkZWRpY2F0ZWQgbnZtZXQtYWVuLXdxIHRvIGF2b2lkIHJlZW50cmFu
dA0KZmx1c2ggb24gbnZtZXQtd3EuDQoNClNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQotLS0NCiAgZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQu
YyB8ICAyICstDQogIGRyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jICAgICAgfCAxMyArKysrKysr
KysrKy0tDQogIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaCAgICAgfCAgMSArDQogIDMgZmls
ZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0
L2FkbWluLWNtZC5jDQppbmRleCAzZGEzMWJiMTE4M2UuLjEwMGQxNDY2ZmY4NCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMNCisrKyBiL2RyaXZlcnMvbnZtZS90
YXJnZXQvYWRtaW4tY21kLmMNCkBAIC0xNTg2LDcgKzE1ODYsNyBAQCB2b2lkIG52bWV0X2V4ZWN1
dGVfYXN5bmNfZXZlbnQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KICAJY3RybC0+YXN5bmNfZXZl
bnRfY21kc1tjdHJsLT5ucl9hc3luY19ldmVudF9jbWRzKytdID0gcmVxOw0KICAJbXV0ZXhfdW5s
b2NrKCZjdHJsLT5sb2NrKTsNCiAgDQotCXF1ZXVlX3dvcmsobnZtZXRfd3EsICZjdHJsLT5hc3lu
Y19ldmVudF93b3JrKTsNCisJcXVldWVfd29yayhudm1ldF9hZW5fd3EsICZjdHJsLT5hc3luY19l
dmVudF93b3JrKTsNCiAgfQ0KICANCiAgdm9pZCBudm1ldF9leGVjdXRlX2tlZXBfYWxpdmUoc3Ry
dWN0IG52bWV0X3JlcSAqcmVxKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29y
ZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCmluZGV4IGNjODhlNWEyOGM4YS4uYjA4
ODNjN2ZkYjhmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMNCisrKyBi
L2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jDQpAQCAtMjYsNiArMjYsNyBAQCBzdGF0aWMgREVG
SU5FX0lEQShjbnRsaWRfaWRhKTsNCiAgDQogIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpudm1l
dF93cTsNCiAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZXRfd3EpOw0KK3N0cnVjdCB3b3JrcXVldWVf
c3RydWN0ICpudm1ldF9hZW5fd3E7DQogIA0KICAvKg0KICAgKiBUaGlzIHJlYWQvd3JpdGUgc2Vt
YXBob3JlIGlzIHVzZWQgdG8gc3luY2hyb25pemUgYWNjZXNzIHRvIGNvbmZpZ3VyYXRpb24NCkBA
IC0yMDUsNyArMjA2LDcgQEAgdm9pZCBudm1ldF9hZGRfYXN5bmNfZXZlbnQoc3RydWN0IG52bWV0
X2N0cmwgKmN0cmwsIHU4IGV2ZW50X3R5cGUsDQogIAlsaXN0X2FkZF90YWlsKCZhZW4tPmVudHJ5
LCAmY3RybC0+YXN5bmNfZXZlbnRzKTsNCiAgCW11dGV4X3VubG9jaygmY3RybC0+bG9jayk7DQog
IA0KLQlxdWV1ZV93b3JrKG52bWV0X3dxLCAmY3RybC0+YXN5bmNfZXZlbnRfd29yayk7DQorCXF1
ZXVlX3dvcmsobnZtZXRfYWVuX3dxLCAmY3RybC0+YXN5bmNfZXZlbnRfd29yayk7DQogIH0NCiAg
DQogIHN0YXRpYyB2b2lkIG52bWV0X2FkZF90b19jaGFuZ2VkX25zX2xvZyhzdHJ1Y3QgbnZtZXRf
Y3RybCAqY3RybCwgX19sZTMyIG5zaWQpDQpAQCAtMTk1OCw5ICsxOTU5LDE0IEBAIHN0YXRpYyBp
bnQgX19pbml0IG52bWV0X2luaXQodm9pZCkNCiAgCWlmICghbnZtZXRfd3EpDQogIAkJZ290byBv
dXRfZnJlZV9idWZmZXJlZF93b3JrX3F1ZXVlOw0KICANCisJbnZtZXRfYWVuX3dxID0gYWxsb2Nf
d29ya3F1ZXVlKCJudm1ldC1hZW4td3EiLA0KKwkJCVdRX01FTV9SRUNMQUlNIHwgV1FfVU5CT1VO
RCwgMCk7DQorCWlmICghbnZtZXRfYWVuX3dxKQ0KKwkJZ290byBvdXRfZnJlZV9udm1ldF93b3Jr
X3F1ZXVlOw0KKw0KICAJZXJyb3IgPSBudm1ldF9pbml0X2RlYnVnZnMoKTsNCiAgCWlmIChlcnJv
cikNCi0JCWdvdG8gb3V0X2ZyZWVfbnZtZXRfd29ya19xdWV1ZTsNCisJCWdvdG8gb3V0X2ZyZWVf
bnZtZXRfYWVuX3dvcmtfcXVldWU7DQogIA0KICAJZXJyb3IgPSBudm1ldF9pbml0X2Rpc2NvdmVy
eSgpOw0KICAJaWYgKGVycm9yKQ0KQEAgLTE5NzYsNiArMTk4Miw4IEBAIHN0YXRpYyBpbnQgX19p
bml0IG52bWV0X2luaXQodm9pZCkNCiAgCW52bWV0X2V4aXRfZGlzY292ZXJ5KCk7DQogIG91dF9l
eGl0X2RlYnVnZnM6DQogIAludm1ldF9leGl0X2RlYnVnZnMoKTsNCitvdXRfZnJlZV9udm1ldF9h
ZW5fd29ya19xdWV1ZToNCisJZGVzdHJveV93b3JrcXVldWUobnZtZXRfYWVuX3dxKTsNCiAgb3V0
X2ZyZWVfbnZtZXRfd29ya19xdWV1ZToNCiAgCWRlc3Ryb3lfd29ya3F1ZXVlKG52bWV0X3dxKTsN
CiAgb3V0X2ZyZWVfYnVmZmVyZWRfd29ya19xdWV1ZToNCkBAIC0xOTkzLDYgKzIwMDEsNyBAQCBz
dGF0aWMgdm9pZCBfX2V4aXQgbnZtZXRfZXhpdCh2b2lkKQ0KICAJbnZtZXRfZXhpdF9kaXNjb3Zl
cnkoKTsNCiAgCW52bWV0X2V4aXRfZGVidWdmcygpOw0KICAJaWRhX2Rlc3Ryb3koJmNudGxpZF9p
ZGEpOw0KKwlkZXN0cm95X3dvcmtxdWV1ZShudm1ldF9hZW5fd3EpOw0KICAJZGVzdHJveV93b3Jr
cXVldWUobnZtZXRfd3EpOw0KICAJZGVzdHJveV93b3JrcXVldWUoYnVmZmVyZWRfaW9fd3EpOw0K
ICAJZGVzdHJveV93b3JrcXVldWUoemJkX3dxKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
dGFyZ2V0L252bWV0LmggYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgNCmluZGV4IGI2NjRi
NTg0ZmRjOC4uMzE5ZDZhNWU5Y2YwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9u
dm1ldC5oDQorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgNCkBAIC01MDEsNiArNTAx
LDcgQEAgZXh0ZXJuIHN0cnVjdCBrbWVtX2NhY2hlICpudm1ldF9idmVjX2NhY2hlOw0KICBleHRl
cm4gc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmJ1ZmZlcmVkX2lvX3dxOw0KICBleHRlcm4gc3Ry
dWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKnpiZF93cTsNCiAgZXh0ZXJuIHN0cnVjdCB3b3JrcXVldWVf
c3RydWN0ICpudm1ldF93cTsNCitleHRlcm4gc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKm52bWV0
X2Flbl93cTsNCiAgDQogIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1ldF9zZXRfcmVzdWx0KHN0cnVj
dCBudm1ldF9yZXEgKnJlcSwgdTMyIHJlc3VsdCkNCiAgew0KLS0gDQoyLjM5LjUNCg0KDQotY2sN
Cg0KDQoNCg0K

