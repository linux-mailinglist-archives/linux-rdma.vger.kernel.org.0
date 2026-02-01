Return-Path: <linux-rdma+bounces-16304-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9xRfDiQdf2mukAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16304-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 10:30:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262EC5564
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 10:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA9C300FED2
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Feb 2026 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BF2DFF1D;
	Sun,  1 Feb 2026 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pL0tvwBT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FE217733
	for <linux-rdma@vger.kernel.org>; Sun,  1 Feb 2026 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769938207; cv=fail; b=lWAI4lfUD5eecPhyoI/nBsgU6iw1IDbN9BDLMl+T5anq4573zwg46ArXFOLp/uyRnNOEJE+oONApOpUiNrx5WMS2gYzbWfcsJpUad59rThprbDEp2m9huywdPJq9mG/QPxqR9uL1aqQUTbh+Vp2Yy+a15RA1F3isNkSo+LMo3Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769938207; c=relaxed/simple;
	bh=IkNa/Q5O+e0ahiZDyVoLFE8wBVX8zbmUphfjH/Lh700=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ehMbxztEFmbi99rJxBURfC/uiRyEAOeOQ+b/8REmc0mwow70Y0XtFNctMu8icitHy44h3wP+x1XDtLLXc37861cN+pKi+BNLce7YrIUwcC/Qbs8vSplSAOYAJnB0Rmwtz8yzhmmKY5b/E5f4DsK6y8vuV2fwl/FRawS2RHvXosU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pL0tvwBT; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/eGVvjF7pdS4eJP5oWhMxkVFNgPR50Lotu/ULqapXb3w4KKNGFYLOKqw5U9ufFaao4+BApNj6i0USR0tWvWLS+T1bt9EPufg1PXceS31ZLxpBkJyd/TcEaIPIs7NBmxFabveYvhG/KENH7WGcMjz3Ri1wz0L0bRtNSTetovCf+vr82RNZb2t8DoZKdLC2JETiUodYVB+jPelFIdTGZAfH3C5oMmweCoqEesy4rO5YRlDqhowXfCq+IVU86JrS47KmhJZhcMUISeJWZkRblfVqLGytXkXfqDk670n8JZXiVivtjjvTLPWVTdk4rBdsg/4bkexukL05+DocB2g9OqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOF8Tu9SBD0WT5y8ssb0TymPBlSVN7DeZYBUj5DE/Zs=;
 b=hrk0btfSCf93QWr3KAh0dQduY1KAwpl3vHRdS405Eu56GU+QadMCY4x3ihyvc11Wss68PrRKr8XJyQuS3/HG+yG3lRfovxX9UhuJ9OvUUzexT5ZO0qWaFIe/BxQ4HBr0vOjL+Jc88gIEYwQonLcjmx7xRib3aMKIX0xncP1K19lPIz7vEM2sZarLqRFJWTKiQPlFpxTqDNcXRMQ5sGlLgnUVvN/YRzuYAhMGrkptmqV5VG1Hwvs6vIWAU5bNV3jCfV2BgwWRUKz5dekhjgDP37t+B/kebAPIv/vvz8/xFD8HnJTX05IMszZO6LtY5S5OJVlafUF3KC94SBevFuwS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOF8Tu9SBD0WT5y8ssb0TymPBlSVN7DeZYBUj5DE/Zs=;
 b=pL0tvwBTwriTpULCNA9mxtKu5E/8RGBdHBVZSf+dG60vH+1v+F3KwkyLtE8gG4U/rfWUJk7SY78w+Spp7RsaARB3jirCxCP43PFXT/W8sHyV0ot8UUHZ94bEX325tlQdYgo6qE5Q7pf2W3BEm4buFxUvVD9RknAMrvF+YUW5jUqvJQvVQi4hWFjItWIy8aFeRX0+U7jfglsXDqU1WZhhRnSA8nfG8fQFGyZrlQ88116SO/qf+RGXovMnOkW8gAnkMVckx5PT5Ag8e6OEJTz3RrvQvKtpKStnjteGCElseEPTVVh7LewYStD2RVJmxnod4cF6+tKnk4J6EftuYCLBUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by BN7PPF7B4E3DFF8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Sun, 1 Feb
 2026 09:30:02 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%4]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 09:30:02 +0000
Message-ID: <19aa2e0b-f486-428c-be32-fa3f728eaf94@nvidia.com>
Date: Sun, 1 Feb 2026 11:30:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/umad: Reject negative data_len in ib_umad_write
To: YunJe Shin <yjshin0438@gmail.com>
Cc: ioerts@kookmin.ac.kr, jgg@ziepe.ca, joonkyoj@yonsei.ac.kr,
 leon@kernel.org, linux-rdma@vger.kernel.org
References: <CAMX6_QHrodOD1KD6qtK2A=tHOocrpSWJh7VTSYR+fMiHRgsktQ@mail.gmail.com>
 <20260131140954.89165-1-ioerts@kookmin.ac.kr>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260131140954.89165-1-ioerts@kookmin.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|BN7PPF7B4E3DFF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 308e8f8b-59e1-4578-592c-08de617479ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTVUcFVmeUY1TitVdXZNK2VSRHZJSjVIcmR3V25VK2lma1pvZzNpRU9RWGRn?=
 =?utf-8?B?VTRSc1dPZlArTEZSWUNjeHFjcEpWZGRLNkJkTmRnR3B3V2gwQ3FWWVk3QVFS?=
 =?utf-8?B?YlRYMG8wNmxmUHJDcmdUWXFYbDZQNUNHdC9ldkhmNjJtbE9YOThVNiszckYv?=
 =?utf-8?B?VWo3NGZQWTNmUVZ4M0pTZ1ovRmZPZzNMdUxUWS9xRElrZWJDYkhlaXduVERY?=
 =?utf-8?B?cDVrTTBuZGQ1cXR2VUJrQyt3T2orOTE1dllaOUdIenZxU2srQWlkaXFON0JU?=
 =?utf-8?B?UzBEVDRKUXptVWxWLzNFYVE4dFl4ZG1LZlhqSHQvWE1ud3NvbGFoTUZ2Yk1I?=
 =?utf-8?B?S3lOQXNEcEdPS0VXVE50bFZQQmFEUS9zMlZjcjZUU1Vwc2tHWHdNR3lhTmJx?=
 =?utf-8?B?RFQ2VGp3L3JFUXZYM1YvaTAwNDFobStmQ3QwaFFTcnV1UWkyRkppNVR0TG1h?=
 =?utf-8?B?YS9BUzJydHcza2R0R3hDODI2QU0wQkpUem11MUZ5M2ZzdTNxTGNJeWdYSTZh?=
 =?utf-8?B?dEVwVEZYSENOM2wyZzlVOXNEOU5Vd0xoczBmN3VIbDVBOHptbklna01EUVZH?=
 =?utf-8?B?bUVMSGZqN0srK3pJUmJjQTVDcDBLZld5cHBDVHFkWlo1MGM0L3BQOExCVHpx?=
 =?utf-8?B?WEhGcTBGcE94UmwxcFMyRUkvalJZVUVXYkNNaGpwZS9Gb1Q4YTIvZHU5UEk4?=
 =?utf-8?B?VUV1L0l1WTFDa2xvbWtrODFBNDZzMzhNWVZONHI2Y05NQXNqREdnSmFMdU1Y?=
 =?utf-8?B?eC9nVHpFem54RmlZZnpIWUdIcWNzeWd2ZStjTS9sNE82RGxhVEo2OUI5ZHRw?=
 =?utf-8?B?YlgyL1VoNWdEM1JlUzU1UkJnL0Z0aklYbG9JcnNERC9tdnRWY2NqNUtra0Mz?=
 =?utf-8?B?TjFNMytETnNmZUhzMW1qZngvUDBJa29JMzRBRnlEVU1nV3hURmlhbndHaXo5?=
 =?utf-8?B?REhYdFNQdUtWMGF3eW0wM296RkZTVFlZQW1yQlgvalo5c2lLK083d0hPNWVr?=
 =?utf-8?B?T3o0R0FSaTZ4amtVYUt3cE1yMnhlNTBwL1kwb21LUWdqci9iL3kzemUwM3pn?=
 =?utf-8?B?bW9nTE85UDNhU0xnUEwxcXI0NVB1VXNtVVFITE1TVmYyZldFN1hVRnNqM2lz?=
 =?utf-8?B?NDYxWFdwbklOVUFueWNVZnRpT0d0Z3lrRmdWNHVmdnBCdm5LWXZiTzdVQytN?=
 =?utf-8?B?dVQrakxnMHdXKzhiTStDMFBsdml1K1N6dHA5dWV6WHk0OUtnd3lrTjRWMmI1?=
 =?utf-8?B?ZVpDNFkxSmtNWFZod3dwSS9NWmtwV0hEYVBuN1JxNnJTSGJ5MDkvWW1IZjFm?=
 =?utf-8?B?eFhXRXRUeE5rc1QzeURtVVNqWjk1Q0V1Mk1YY1F0cEhGYVpHNGQxVlJNNkIz?=
 =?utf-8?B?cXpBRHBKRCtxRGZsZXp3cjFSaXY3K1NyUGJVL0tyVHg4ZDd2NEVhQUNpWlZO?=
 =?utf-8?B?eFhaT0JORFNDZkoyQnc3ZlByNTRCS25RNkp3ZXN0UkVFMmZsbzAzTERVdUVI?=
 =?utf-8?B?SDQwc1JjM2QreDFkckt1dDZWNHBMMzEvV0tHbW1SZFM1a1RGZUZTaUNtRjNO?=
 =?utf-8?B?U29nMzVVTmd4TE4xTEcrTTB1S0NLVWFxRk1jUS9sR0llUWR5UERPZXN0eWw1?=
 =?utf-8?B?K3VDTGtWVHFNa3FmMDNsczR3WmZDVUFzZW9DbkpSdnMwSGEwcTlGVWUydFZN?=
 =?utf-8?B?MjgzUnBWTEEvWUhFTmUzSUZTNXl0TTY2TmhMUXFiYVE1WWpGa1hpaW01aEly?=
 =?utf-8?B?NVRKSElNVjYyOUVZR1FheGxxbUw4T2JXMW9XU0hnUFE3ejlqN1RWMHlGekc4?=
 =?utf-8?B?ejBRczVVbU9iWHgwbVl1emcxSUx5azl2ZngyNFkyancvN2liaHVXNC9aSm5S?=
 =?utf-8?B?cEs0SGJKNTRPQ2tUZzQvTTkxTHUweFlOSFNHeW9OYWFqQTh2MU5BcXk4YVBa?=
 =?utf-8?B?a2xReFQ0M3YvM3lCVFlBRjBVSW82L0FWMkFSd3ZReE5FS0hIQ1hVYUt4R1hq?=
 =?utf-8?B?WTcyU21MNXNxVCsxRjRNSE1wanlSazRBTEhmelV6cVdqNUhPNENINWh6TTFS?=
 =?utf-8?B?bm01OXVkQlFmYTlkVzM0L1R6REZFcWFHRll4TmNzaDE5MzhYMDJLNzBWQVlM?=
 =?utf-8?Q?Qjdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWFHd3hNWGpoQ3ZaK1pzbWU2cmxaajVaY1FDbTcvdE10WXU1ZmFCbkwvdlpi?=
 =?utf-8?B?ZTlXMWhReUJmUmx3bjVnSS8wanpISEhjT0JyTDNtL1NmKzIzUkZzL1ZldEpS?=
 =?utf-8?B?RDQzTDFSaFZOMCtlMFp2Zy9pc2loTUtJV25FVlRIdzV3Zkl6WDdTYWtkd1dJ?=
 =?utf-8?B?N08rZTh6M04rK051dmZQaXJBK1RVVWNhTStRN240b2JVUFR6ek5VRElkcWZ6?=
 =?utf-8?B?algva0h6UkVkR2ZIdTZOTFpYbnV5WmxFU0Rpc085cGRrVzRpaTIycy9WdzBH?=
 =?utf-8?B?V2xibWsxSjRxQ1lGamhaRVpuVGR6OWtOUy9zY1hqcFBDMlRsajhmTW1sajIz?=
 =?utf-8?B?MEYrMk1IYnk5ZFl1clJsV0d3SzN5RkxjZE9lWllWWWNXK3kzWHdyMnpoUytO?=
 =?utf-8?B?UEUrdDBrZGw4dERyZGZOc2dkam1xWkdYUytDQ2xFRUpVK1hPWkQyRnBNQlBO?=
 =?utf-8?B?cjllVEdOZEFLRjVkamx1T05ud21TVEJyNEVVTEdLLzJxTCtVVE5WUHRUbUlr?=
 =?utf-8?B?akxkR0dkUnFGMFFwaG4rVEJhM2cxR3lJb3RuWjJFQ0N0OVB2NGJHdkdpdFVx?=
 =?utf-8?B?ME1wSzVxVmIyK0VYS2hTMTBsUVoxeGxYVVdQM2thTW9kRENqdnRZK0IxK3Bk?=
 =?utf-8?B?ZlhYb2xaTnZGN3JLOVJlSTBjZG5xeThRNk00WlZueVA4Y2x3VG85QWVFU3Z3?=
 =?utf-8?B?WXI0TXNYYmZodDBvT05xNDJRcGZWaEg4RU90d0ZCN08wbm5ieDc3dklIbEIz?=
 =?utf-8?B?bjZ4K0txbUVDck8xWlFaUWNlalFyOHN0SnY1Q2FHcU95UzZJUVBtNWpQZTJ6?=
 =?utf-8?B?N3pLbnFOR3gwVkxrbzFGK2xMbHZtd3IyeW9ycENFbGdZenZDS0FHWXVWeUVG?=
 =?utf-8?B?T3lmckVYT0JsNktiVVlFZ09RSCt6MlZualVGbXdDY0NZSzlyUk5BZU1nZnR6?=
 =?utf-8?B?MU9BUHRkeUFmUDVEWTVBTms5LzFxK1Awakg5cHN0TjZvcWsrM200WDhaNVM3?=
 =?utf-8?B?S0RUendaSmlsSmVyVysraE95cGdLNEgwYVNuWmlQYTlCWXBIcXk5MUxGcmNl?=
 =?utf-8?B?NGZkMVdkU3RoU29MUHg1YUI5WnpQZjhQT3RVVzRQbm9NcWNObWNURWhCUEdZ?=
 =?utf-8?B?d00zMUdiNUIvQ2cxWjB6RHNYNXh0K2hyS3RqWkRoNkRsUnBIem1jMmJSZFRI?=
 =?utf-8?B?RjVuMXZ2TnprMTAvbnVnNTczLzlxc1VkWTh4akZHc3I4Q2h5N3Z3VnowNmVw?=
 =?utf-8?B?ajhMYWQwNHRHUG56UC9Yb3EzazZERUdEbE44dTZmeEc1cXBBS0NRUW1Ua2RK?=
 =?utf-8?B?WGdwY0JhMHczRU1vbjNuQjRPRjU4TVEyWHJKT285RXo3YVF0dXNEcG9zWHRr?=
 =?utf-8?B?WVV6ejN1Q0NhQnpTWHN0WE1TRVBOTHNHS0YyNlJvNk1Oa3VQR1YxalZRNUxx?=
 =?utf-8?B?S0UxSWYvL0MrU1MvZUVjL1lUbEZvZDlVUHpmUzF0cnNUY0hwUk1tS2FaYU5K?=
 =?utf-8?B?QVFFNHBJVXFNbUh1Q1l3dHcvQUI5NWhoaWNlSTUxZ1hub0xrU1Z3b2JSYzdi?=
 =?utf-8?B?WUFRK1B6UFF2YVNKVkIxY1JsNjl3R3ZIU1pJbVRod3NGeEZ6dGpiaXJHeVFR?=
 =?utf-8?B?VzZub29zNFpDTU41TlFaczl4Wmw2ZzIzcGVMUWJHSUkzQ1NaRUxJMEpIYmNw?=
 =?utf-8?B?YnBYK2doYmU4dWV6RFVqeHJiQWU3RXd3ejV3N095UHpueVg2OVpmVE5QblN4?=
 =?utf-8?B?aGtNM3Yza2thQnIyd0hpK0tUdVNQSWlvMjV4a0syQlVlcVoxMXR2QTFSZS9C?=
 =?utf-8?B?WkUyVW5LalhsWnVicWhNMHlWUjVDbHVqTkJDMGszSldDUTAxeUdCWXg1bTVP?=
 =?utf-8?B?UVd2Tm1KT1NLbFhMaVhhNzJMMFdjWmplL3lDWmd2UTRkWFROM3pLVVRLU2Zh?=
 =?utf-8?B?cGdWQXV0S2p1MDRHb0VlV0R3WGZCczB4amFhaVJTMTdFdVJ4Znl2dGM3QTc4?=
 =?utf-8?B?MjZrc2o0S09SdDlQMlBVYlRnK2hNRWxQK2JuQ2I2OG5JeUtKdGdWT1Jlak9o?=
 =?utf-8?B?aVEwS3hsTG50eHpRTk5SNFpPU2VnTUJQMmNNb3MrQ3ZMNTZNa3I0ZVNucDY3?=
 =?utf-8?B?aE9qZ2l1bXU5SEx4L1YyaGo4Ym1nY2ZuTnpzNXU4WlhRVG1PQUZhSjdzcHpF?=
 =?utf-8?B?Y0dLeENXMUErY2hHLzMzNmVLdzJOa0o0VE01RnpRbFFXTEV5a3U3N0E5M2tP?=
 =?utf-8?B?K1laaG9DVTZla3FVYmxLV01qRDIzelJ3dTgwem1lcDVYUlNORnlYT09ORSt4?=
 =?utf-8?B?MC9sY3ZxVUtoRXlEdk54dDZoSXV5bGFMamMrOE9aZzBFTU9FNk82UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308e8f8b-59e1-4578-592c-08de617479ac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 09:30:01.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUpbjut9Z4yXWMCigOQdrgWUs1kbapXOvH2KgYuI+uj8YWqD4lSFi78GAI4r9qje1JXiH4WljtVYx/9mhAfAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16304-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 8262EC5564
X-Rspamd-Action: no action


On 1/31/2026 4:09 PM, YunJe Shin wrote:
> @@ -588,7 +588,15 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
>   	}
>   
>   	base_version = ((struct ib_mad_hdr *)&packet->mad.data)->base_version;
> +	if (count < hdr_size(file) + hdr_len) {
> +		ret = -EINVAL;
> +		goto err_ah;
> +	}
>   	data_len = count - hdr_size(file) - hdr_len;
> +	if (data_len < 0) {
> +		ret = -EINVAL;
> +		goto err_ah;
> +	}

The second check is redundant.
The first already ensures data_len >= 0.

>   	packet->msg = ib_create_send_mad(agent,
>   					 be32_to_cpu(packet->mad.hdr.qpn),
>   					 packet->mad.hdr.pkey_index, rmpp_active,

