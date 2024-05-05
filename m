Return-Path: <linux-rdma+bounces-2266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933EF8BBFDF
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25626281C00
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F763D0;
	Sun,  5 May 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mRQA4Ir7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC36FB6
	for <linux-rdma@vger.kernel.org>; Sun,  5 May 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714899528; cv=fail; b=T/30rTHkMCUyEM/Vfh3NLhzWpVBuMMaxw7+WMYj+EhDVsIGJrhi2ldO0aRp+TX+4my+dUrhFXEJUro7qtCdH5q7c9IbWtGTmvnuSmAygCIgwyEGB9pLruuWQcEwHTZI3c9yOUQ6jghfBWy2mCuDnXwBLKXKptwxodYNapwDBKA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714899528; c=relaxed/simple;
	bh=glmHHIKXc+QKiHNtOZNDUMcAbAOjEVhkqp3LnZuS8o0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mG1guX7XvG35RtpKRNEkNRUgas7H/6Utg8OULZu5FOQYly50TiEn1hSpqJRoQWtyRRdDltwGp275q/HY3J2fIWpdw2V14xMed53tBniukoSyZUOhxBJ9x4QugYWA2GhsxYyy/5i3YCkkmuR6h/FgVO6kK0Uo0fVCXEutB02/mNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRQA4Ir7; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4oOsyYrq5H2FmWcbBhxKUDAi7ovopKGDRyDsYRCsrfl2c+7NesVE91Qq+hGiGAYgQ9WUjXVIVz5iHUAkRNYTfbGll0LKyc11hM4e4EEWvqbesiKdIxy/Xbp6v8qQ2HERNa680bpnB+eWW/W8bPaw4HRSjE2RXWCqMtU80HCGVPMAVekUt81RAoz9pnqXw5sOt5qS0vnEqz36+FeUghwkXpiu7ums8ux2SA4tBKUY5v8hVmtRR2l4gg3II2AwJvzFqRf0LRqvui/5GQ9Smp6Nj31004d2W0iHvB1JpYkSkMtDDoxaWMhtTQndYdEaLEyEI8fEK+RD8p+hnXBJ0E/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I479cU25cWbdLmPwXUuxXveyPrGeIUwKkNCbl8jRSyo=;
 b=K2FbldqQQSNMBDCzDlJy9fUApfiA/y8axoGeOOjZi9wO0Mf4jODjDTHsSyjl9M5+xJwLflaTUM7LTc4fJ4pHqBHNUp2pp5GQGgkGVsy5sTH4Z6d/FqFILXcK8rA3Fjz2bsKAmQfKJ89YQFTDvqpO8hiJmne5g+cVudDo6J37NHBGSoxXO8BFTTKHQvM9iuuVP9OpN6zrAOkV02KVM9XNzvmNhkWjy/1kxhdE61S7gsordHObM6PNaKiWglPCbOdcxyo7UZVmKOUY7ZtJrFLqzg3n/tUbV+7ljjKhP+9NzUexUXqHIkGpA4RZTLlKwJqh3DRG0G98KbYkjyAV8AV+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I479cU25cWbdLmPwXUuxXveyPrGeIUwKkNCbl8jRSyo=;
 b=mRQA4Ir7Mek4mGr/qXU7B9WeHlX+vCImhVUPi9DMz952qf6LX4ZHebwwe3GbIAYU1XD/SgYUprZUj9x0xlf/gPbb7bMmQFs6dvx5/r9W+FNhVL9QquzoieQwOiRDlsEp3UerMGRS31mFTWJog1oma3BOrC1YDUtf53jU1AJzO+wwHfAwoxKZjZ9u1DguSTKSSPyTFtLu03gmmLTNP1APKaT4qcfngOnkxTkOowPEk1g89gJgwBUe/G1uaNyMprhQcx+ExCb37GERNBhGAxcfKi8j60PQFboBY3u7+7oOnKttvOSs9awSem2QqgUhRNShDpUX3/RD/l2teyoXBmbI2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) by
 DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.39; Sun, 5 May 2024 08:58:43 +0000
Received: from DM4PR12MB6662.namprd12.prod.outlook.com
 ([fe80::ad3d:9a4d:2a29:13a4]) by DM4PR12MB6662.namprd12.prod.outlook.com
 ([fe80::ad3d:9a4d:2a29:13a4%4]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 08:58:43 +0000
Message-ID: <e99d2f40-ece3-4938-bbbe-ef4e107b6dd3@nvidia.com>
Date: Sun, 5 May 2024 11:58:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5 attr.max_sge checks
To: listdansp <listdansp@mail.ru>, Leon Romanovsky <leon@kernel.org>
Cc: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 msanalla@nvidia.com
References: <c78ab477-5b54-82b5-1d5f-8b0022195f78@mail.ru>
 <20231220080729.GB136797@unreal>
 <82ba679e-cef5-bd0b-2084-ae601681cdec@mail.ru>
 <20240317083558.GE12921@unreal>
 <5203883b-f83f-b6ff-cfcf-346689f0bfe8@mail.ru>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <5203883b-f83f-b6ff-cfcf-346689f0bfe8@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To DM4PR12MB6662.namprd12.prod.outlook.com
 (2603:10b6:8:b5::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6662:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7730dd9c-2dc4-4880-cf01-08dc6ce19062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nnc0U0lWV3FoWURtYjIrN1prbEw3YUFYTTk1UExMNEFJQ1VOSVp6QmtHZGlC?=
 =?utf-8?B?UHhVZVZGRjdPTlhFQU9PamdXeWZ1U1orYXpxVkRkUUR6cStETFBZNER2Mko4?=
 =?utf-8?B?SW1CWUFCbVhrdWFpam1hVWtzbkxSYjhEU0o1c2FnUE9CbytQdXdKbHlCbVRQ?=
 =?utf-8?B?bUo3Z1JCMFQzYkRVWjVxQmU4M2lPVkVtMjgxOEkzMDdCYmgvb0dwQkRZUzZF?=
 =?utf-8?B?QVVzOUdobmJEeWdsQVdPbHNHUnprUVA1QU1aVllGVitVZmFHL243b3ZXR292?=
 =?utf-8?B?UGtmMFBheFBlbDBJQWFwaU1aVTg1cGxEVDJ3VCtqTDAxemJFZHVPV3M0S1NG?=
 =?utf-8?B?Snk2bzVDcnRiUEx6K3ZNRVM2M1c4S1lsVm8yZG16UDdrUm1QRUh1UnFlYjVY?=
 =?utf-8?B?MFZlTmJMZTNjejhxVWpsTlAzWmhzWVAzbjlDeWQvcTg5MGNYWUhTVG9oVHRh?=
 =?utf-8?B?L2VLSHJ2bkNyc2hSREFFVjRodjVHWm1uK0pXMENDTUNpVnBrWFI0R29MS2RB?=
 =?utf-8?B?MnJkcWpQVDRkOTdvOEpGSWJxNU1TeFNlMW5ZM0xZZEtBVmkzL1VrcWo4eEF1?=
 =?utf-8?B?YzJ6TDhYLzFVeEtTTFVlZG5CWUhEWmc1OFJHWTlOQm9US01qR2FIbzNpV1ZS?=
 =?utf-8?B?Ni8rNmZJcmMzZjF0TEFKQy9yQktWV2hubmRBZU5tbWNBV1Z4SHBBMmFDM2JS?=
 =?utf-8?B?YjBvbkJMNjBNVy9CMnJQd09yMThOYXM0QmJFT09kRGtCandoVjJ4QlNXc2x5?=
 =?utf-8?B?NGc0MUNZNk1MUTNpM0hYUy9Gc0FnRFpQV29Zamo1VGk1WjM5WUhNM05mQU9a?=
 =?utf-8?B?cU1hYnhINklMODlVZS8xVlU5aUJ2eHdNbmFPVXI5QklBZzl0ekNKa0hvY3Fw?=
 =?utf-8?B?RFpZMlo2REtPaDhUTHVwYTRoanZkMGZlaURFaFFXR25kQ0ZaR2k2U1VRWThM?=
 =?utf-8?B?empwZEpKdDV2d0dLV0E1dmdXa0ZqNHNvK1NmWXgvc2s5OXhXOU5hNlRLaGgr?=
 =?utf-8?B?a20vYkhWampjVW1yUTE5RlNGVnZwcjlCek1HMUJlMWdKZ1k0bHJ4VlVBNlJN?=
 =?utf-8?B?eXJBVzNrUXZPUlZhUjA4SWxiLzlzUlhscW5HSUNYRUdGbFRQUTJvYWRvRmk3?=
 =?utf-8?B?Ni9qUTIzc0d2bTladTl6TzNLZi9OdFlpVG5sV0dPRitmc05QWE0xQ1dSSzVy?=
 =?utf-8?B?c1R2UHVqMFZheGprRHMrejRQWkZFMmVjdEZJZjF4TDdzbTBUdWZhSTZtMTlh?=
 =?utf-8?B?MVVsSEtwWUZPRm5qWnh2d2FBZll2NU1kd2FuUmRrZEVWK3BsZTZtU1lUQU5X?=
 =?utf-8?B?eE5oazM3OGlENE8va2diVzUyVzgzdE9CUU5UVjRWTnpTM3lESE5FZWpUQWdJ?=
 =?utf-8?B?YTJUWXM3NEozWVJsZHYxMG1TdzVPdmxyWkpHNmRndmxrckRNYTBPamVreWh6?=
 =?utf-8?B?WUpsVGdUUCtNbXcvS3I5bnEvY1liajF0czBXVjdYb3UyMWdoUG1yNloxTC9Y?=
 =?utf-8?B?YW5ydkFkalJkOVE5c3NNN0kzVExrejkwbHBtM3pLZk5pa0ZYdUJYUEcrS0t3?=
 =?utf-8?B?cUZjSElwQ2k1NzE5TFhUTWFLb0trbDdZZW5sbEM1K29pTERjM3UzY1JQUEVy?=
 =?utf-8?B?c250dzRaNndvRDBrWXF1eStOTUE3Q25jM0g5MksxS1RrL0g2VER5UndscllU?=
 =?utf-8?B?bEEveGJJd2NucmhKZ3VIejZwVnh3UEU4UjFjK1ZVcUlzV2hKbStjaEdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6662.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q05lL0cxcmhEcE95TlMwNGZHNDdQVDNpeHZPMFIxVEZwNC9zSmsxcy8wd0xJ?=
 =?utf-8?B?YlZFWGI2OXE3YTEzd0xKRW9kaFk1TUw0Y2djRGxUQ1oveERNc1B2Y3JiMm5U?=
 =?utf-8?B?TVUrTjRoN3BlSmMraXR3UlN0NTRyVGJUTUZHL2wySHBPR3ZoY2pKcmZUbTBO?=
 =?utf-8?B?QnZPUjliNEdEaWY0Rkhwd0RCcnVnVEpST2Y1RDd2V3FDZmhFVStjQThCbXBL?=
 =?utf-8?B?NGUxcTN2WHJiT0dYczBNUGJsVE5hbUJiU01vZHYwVzRCRkdvT1pHYmQzcWpM?=
 =?utf-8?B?djZPRGR0ZUN3dmpTWE02Mnh3OHNBSUhLejMzNDh6NTNMNFBTbWlSWHJaMFlj?=
 =?utf-8?B?UnNIYmZwYjRnWDd3MmNzZ0Z0RXJ1UHFuL3k2cmErcnBLNHN1VWFYaWJGUm42?=
 =?utf-8?B?TnhlU2tiWXlWS1duKzA1aVNzd1NNSGZrT3dxTExhaEJHanR6RWRBOVpDUXVo?=
 =?utf-8?B?TmR1QkwvRzlOSUlKT3NBMVArVXVabkRxNk1WZmNpOG9zSVhNWk1JVHdjejl4?=
 =?utf-8?B?MG43UXpreDVtaTFMdm04cW1HcUNhdkwrNkNONkRKRjA4UzVpcy9CdzN5UXc0?=
 =?utf-8?B?bTByVWMwazV3NTU5RHdrK3laOHd5cjd3eEdMb21sYURxUWMwckM1MnBrSHdp?=
 =?utf-8?B?UEQwZjF4elBVeDUvN3g4ZC9tM1E5OVo3QXpibkNNRE9uemhMRTF2endYdDdy?=
 =?utf-8?B?VnRZcExCRytkK0V3YjFsL1pDYWg0NFRsZ3NnZlorZnc1SVBwVTJCYWJYSXF3?=
 =?utf-8?B?NkU2RDJ6Sk9kSlp4bEZVSXFrRG5LRG9KQ2pZK2tZcjE5aGpyRGM4WTdmTktI?=
 =?utf-8?B?M1lLeEYvOFVUZ1NVc2JsUU5semQxWExNbHNhNjR5b1g4cDk3ZXdVOUR5NURK?=
 =?utf-8?B?bGpMR2M1T29ZWHFZdXBLVUlXMC9JVVA4bmR6TkxBcy9jcWIyRkNiMFoyNE5q?=
 =?utf-8?B?UE5ndEJIdG8zenhQOTM3dTM3RkNXM0hiZmVCSm9iZ24yUjJrall5L0VDeTdH?=
 =?utf-8?B?bXpCdXMxWW9QUk1pWFgxTERheHZ3RHR2SExoWUE4TEVtRHpxOHVPMDNzV3VH?=
 =?utf-8?B?Y2FpQ3RhMnBXUGx6SEh0ZEphbWowQVVzeENabXIxMHJMbDdkM0lKTE9jOVh5?=
 =?utf-8?B?WTErYk0xZkdxWmR0UTRYeGlyZ0JsNkk2OHlpMVBGa2U2dkdOWS80WnRTQXAx?=
 =?utf-8?B?V0w3Mkp1NmQ1d1pLWndybGozR1FFTDY3R1J2bW5RNTZSY0VQalVsa2NVUVh4?=
 =?utf-8?B?d2ZPTEtCVVZ5UVVWVlZiTzN3bE91WXpwTGpHaVJkK1puMU1pM3dFR1ZMb05o?=
 =?utf-8?B?T1VEcCtSeEVNZHAyWGxEL0VTVll6TmNNRkIyaUlnOGNFaWg3VE9kazNCYnBj?=
 =?utf-8?B?TU1rNDkrN09LYUtQUDg2VENmWW5qSmgyMUJVWk8zdEFjMTRzVlluV0d6SWRy?=
 =?utf-8?B?ZzNKdUxrcExRaXdpWEFmSzJsUlE0bTFvQjRHRUNuSk5ramJHdGo0L29wUWx1?=
 =?utf-8?B?K3NLNFpMdUFSVTdlMGdmNjgvMFBBUTgvb0JvOXdOQ2wyUnVZU0YzN3Q4emVx?=
 =?utf-8?B?YWk3UXZOQXR2bURHM2prMGlaQ2JYbWFmMXJNR3hraGo4elhOTkZadDFrNWNF?=
 =?utf-8?B?ZW9GRnJTUU9SVGlUZ0dpWWM5d24vSElGVVA4TTBiWll4Zm85dXJpM04zTHRi?=
 =?utf-8?B?cHNWdTJrTlZsZDh5Tm1KYkxncFVwenJFWEZlM250akV2OHNqTm9HK29YV1BV?=
 =?utf-8?B?M2E1UTgxSWF1WHk4QTRpYW9LMTk4WFpCdis1UVA3d2JBbi9uaTdERFVFREp5?=
 =?utf-8?B?TTdLb05oU0pVcjJBZGRRRWs0aXdzVWUrN1pHaTduUUVVS20rS0cydTBEdE1k?=
 =?utf-8?B?SFhndDdDWTZJTGtkQlp6WWVSRldLVy8yaXZHT2t1MHpWU0xvdDZ3amRidFRs?=
 =?utf-8?B?aitrOXBKdlNJNW1wRTE1ejFzV1hXQVZhQUltZFhYVFZKLzZHSytsQzE2SVR5?=
 =?utf-8?B?Ujlac3h0Yi9BNmNVMkIvbmNocGNtYk5zRnpmZ3ZFcWNhcDlSN05hbU9pZmEw?=
 =?utf-8?B?TERJc0x5UEJWMjNtVjVYWlR0TEdTcytTQWJwaUdTNUYrOWdmQ1dENHNRcFRs?=
 =?utf-8?Q?xlU6ro2cQn++wDT6OkPuY806G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7730dd9c-2dc4-4880-cf01-08dc6ce19062
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6662.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 08:58:42.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXKinqEMI6Hwk6ZPiUcC6raNFBjgtch2KnHjcNA4NxDfSCCxS/VvnCm+nxgUv2iC3X4QX8rJbLr1evWHAHpojA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069


On 4/3/2024 3:28 PM, listdansp wrote:
> External email: Use caution opening links or attachments
>
>
> -------- Original Message  --------
> Subject: Re: mlx5 attr.max_sge checks
> From: Leon Romanovsky <leon@kernel.org>
> To: listdansp <listdansp@mail.ru>
> Date: 17.03.2024
>
>> On Thu, Mar 14, 2024 at 11:29:49PM +0300, listdansp wrote:
>>> -------- Original Message  --------
>>> Subject: Re: mlx5 attr.max_sge checks
>>> From: Leon Romanovsky <leon@kernel.org>
>>> To: listdansp <listdansp@mail.ru>
>>> Date: 20.12.2023
>>>
>>>> On Tue, Dec 19, 2023 at 09:56:01PM +0300, listdansp wrote:
>>>>> Hi,
>>>>>
>>>>> While investigating the one report of the static analyzer 
>>>>> (svacer), it was
>>>>> discovered that attr.max_sge was not checked for the maximum value 
>>>>> in the
>>>>> mlx5_ib_create_srq function. However, this check is present in
>>>>> https://github.com/linux-rdma/rdma-core. Also, checks are present 
>>>>> in most
>>>>> other infiniband Linux Kernel drivers. This may lead to incorrect 
>>>>> driver
>>>>> operation for example
>>>>> int mlx5_ib_read_wqe_srq(struct mlx5_ib_srq *srq, int wqe_index, void
>>>>> *buffer, size_tbuflen, size_t*bc)
>>>>> {
>>>>> structib_umem*umem= srq->umem;
>>>>> size_twqe_size= 1 << srq->msrq.wqe_shift; // integeroverflowhere
>>>>> if(buflen< wqe_size)
>>>>> return-EINVAL;
>>>>> In my opinion, the only possible solution to this problem may be 
>>>>> to add a
>>>>> check to mlx5_ib_create_srq similar to
>>>>> https://github.com/linux-rdma/rdma-core
>>>>> <https://github.com/linux-rdma/rdma-core> like
>>>>> u32 max_sge= MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq) /
>>>>> sizeof(structmlx5_wqe_data_seg);
>>>>> if (attr->attr.max_sge > max_sge) {
>>>>> mlx5_ib_dbg
>>>>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/mlx5_ib_dbg>(dev,
>>>>> "max_sge%d, cap %d\n", init_attr
>>>>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/init_attr>->attr.max_ 
>>>>>
>>>>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/max_wr>sge, 
>>>>> max_sge);
>>>>> return -EINVAL 
>>>>> <https://elixir.bootlin.com/linux/v5.10.169/C/ident/EINVAL>;
>>>>> }
>>>>>
>>>>> I would appreciate your suggestions and comments.
>>>>
>>>> Can you please provide an example of such values?
>>>>
>>>> At least in the presented case, the values are supplied by FW and are
>>>> supposed to be right without any overflows.
>>>>
>>>> Thanks
>>>>
>>>>>
>>>>> Best regards,
>>>>> Danila
>>>>>
>>>>>
>>>
>>> Hi,
>>>
>>> In the mlx5_ib_create_srq function, the variable srq->msrq.wqe_shift =
>>> ilog2(desc_size).
>>> Value of  desc_size is result of desc_size = sizeof(struct
>>> mlx5_wqe_srq_next_seg) + srq->msrq.max_gs * sizeof(struct
>>> mlx5_wqe_data_seg);.
>>> The init_attr->attr.max_sge parameter can be set to any 4-byte unsigned
>>> number.
>>> There is overflow checking
>>> if (desc_size == 0 || srq->msrq.max_gs > desc_size)
>>> return -EINVAL;
>>> but it works correctly only for 32-bit platforms because size_t 
>>> desc_size;
>>> and for 64 bits platforms sizeof(size_t) is 8.
>>> So, result of srq->msrq.wqe_shift = ilog2(desc_size) may be greater 
>>> than 31
>>> and will cause overflow in size_t wqe_size = 1 << srq->msrq.wqe_shift;
>>
>> Let me repeat my question.
>> Can you please provide an example of such values?
>
> Hi,
>
> I have not any HCA and can’t reproduce this case on practice but in my 
> estimation, any user space  call such as
>
> struct ibv_pd *pd;
> struct ibv_srq *srq;
> struct ibv_srq_init_attr srq_init_attr;
> srq_init_attr.attr.max_wr  = 1;
> srq_init_attr.attr.max_sge = 0x0FFFFFFF; // any value greater than 
> 0x0FFFFFFE will cause overflow
> srq = ibv_create_srq(pd, &srq_init_attr);
Hey Danila,
This won't cause an over-flow since it is protected by 
userspace(rdma-core) meaning this max_sge wouldn't even reach the kernel 
to cause an over-flow since it would fail inside the rdma-core , the 
example you gave for instance would fail inside=> mlx5_create_srq : "if 
(attr->attr.max_sge > max_sge)".

And as even pointed out earlier in this mail, most checks are done 
inside rdma-core , which guarantees that kernel is safe to operate when 
called, and can avoid redundant checks.

So I think this is actually a false positive since it doesn't take 
rdma-core checks into account.

Please feel free to share if you have any other examples that you think 
can actually cause a problem.

Thanks, Patrisious.
>
> will cause overflow on 64 bits platforms.
>
> Best regards,
> Danila
>>
>> Thanks
>>
>>>
>>> Best regards,
>>> Danila
>>>
>
>
>
>

