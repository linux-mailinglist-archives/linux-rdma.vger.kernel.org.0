Return-Path: <linux-rdma+bounces-4885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE45997593E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 19:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C4B285C50
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3A1B0131;
	Wed, 11 Sep 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="CaazzHFA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FFD4D8B9;
	Wed, 11 Sep 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075455; cv=fail; b=EGm7p45DEH32DmGxCTnYlZUqWgg3RfabWcer9c0Wkl9Owp2hByiWuhF7tJxjoQGQouitqiu5XAi3w77WPj2Tvr1udBe/kfiD5Yv0P5i0xIkqb07VdJYBOMAmheiL2ZYYThsp1vDPY32v9t9NX9d+ZSLRXfZTIjmc5p65TqOVHc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075455; c=relaxed/simple;
	bh=VBeCavTIAlN3kWRafOAbMbKmUD6ODOktpJfzDOGVF+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EG7fPaqpTBoLKRIaHaMR8UApqtYxeGoBAtmXU1nPMxh4/6dzW6lzAqLmr0PhW7DGlrmQDq6lduewhnyBbheaozBPfuahrsHe9ofLRCCUD/VhcbkslHVD24yJpoYC8h2UMjQfwmAJCrvFWGFvvzfPLqyhGqgUmBd3i4M+v8uXejw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=CaazzHFA; arc=fail smtp.client-ip=40.107.220.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRjV3DR16kNdVyL8BmgxFcS+U86WOJa0NXSH4g9YIAXal4KEMTS4+I36/6Z+Wt9sKvszfd5pMXkQEgNiumWM4E5cEQAEUH/G/mgauMYxIXIfwnAwmLmeOua70i1oDLbym6Ds2/ClPfJi/ckqqRb8BVvrEtlfYUDb9MSWJvKvsYVZO4N2zdI8dFaiStYm9WmcHmSlQ0DhbJ5OKq3MbowEgZs4On+ug+aCWCORCcc+/dzYp0MlinCzXMQ0so49gBPbPtBUcOMfyI9x+7H5JwrOC6+JZt/R98KxMX1eWEKoN3NJ8KIp2Of/cyfohhqkjodXE8mUmvyCw5fYO8kxs0DrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+SkWg1tthivm2n+HU0P7dubczBvG1n/JeeAwOiOKT4=;
 b=c2akwBn6g/sPzEjxDQLnJQRkyuRxNCEAUiQUqEhcae7PXCnA0s3Snrk2yq2C4ULdqWdz61qM1hGyBKs+X/jR0+p8MrOtjEowUUfx7s7ZajyNo46svPFImVN+vPOr2/dz35fRCaAKX0VVUsV7tvlpgkCRNJH6lu4NitovtEL183SsjMMQr6FGjflQKbbnA7SBrd2cqhceoGgx/HIoJvaCT7ayN7Jpb8gzexz0v3MNvJ6R+4phq4w13OQTdzNqQvrX+ZkDuOuzJvTTDAzBO4lH/QRsk0wmIrJm6qVzUXlLkRD8kGfpJIBqvKgFHAddYXV3rW7wFVrtqWoDFBEYYp4JGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+SkWg1tthivm2n+HU0P7dubczBvG1n/JeeAwOiOKT4=;
 b=CaazzHFAojsXEGm3eZplDSscmWxIuTppeMM3zXtQ84o38vGpXHVbL69yLNn3w9Pidm0xd21NSf3Nl3kwgyBhZISnbZ6yt0VhpKdwieX8lQy/rsdEfaGVN9TgNfM/qVnXRRQV7g+6pC4ASsNZJfKqGzVdmseTpEtGtOvK55hLZ9eCnxrTjet79O20iuP0IkeReZHMVXaKM22klF2zJd6kN4LmAeG7XQ0p/2oeXy5VQ3rraH6kyJEN6EOkOqWNYhDXB1xVMmvUuDliDg6fJwpTcpCZQ1yN6JNP1dnL1B4NGBrjTx6HAkkga1HWUL50YMp6P0wKcTVVNLD3rOvrTWmbmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SJ0PR01MB8141.prod.exchangelabs.com (2603:10b6:a03:4d6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.22; Wed, 11 Sep 2024 17:24:10 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 17:24:10 +0000
Message-ID: <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
Date: Wed, 11 Sep 2024 12:24:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
 <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:610:33::13) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SJ0PR01MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5dbe06-08e5-43c2-dc36-08dcd2868c45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHk4Tk0wZW8ydXdIOG1rL0pIKzNIdDlhaXpvZ29zYnhoTGt1eDU2RWt3Q25k?=
 =?utf-8?B?Vm9xUWp6SFlkNEhhZHdpY1Y3MFRSYXA0SzZONW8rcFhIeWF6UEZFdlgxSldE?=
 =?utf-8?B?T08zM3MweW13ajllRmhrbUZVNkJrTTAwMC96eWxnR1RtTlhvOERxZnAwL3p2?=
 =?utf-8?B?NTUwSkc5aEVVREQ0RW9TT3hnMFMxQ21nUWhhMVJ5RVBTam0zWFh3eThzL3lt?=
 =?utf-8?B?SWdNN2RKVGttTHEzRnZlUlIyRlpFUjYrOEZ5elZGRUViNTNObzN6d3hsNExE?=
 =?utf-8?B?TFBNWDBVN0I2QlNWdzVPaHgwSzlJOXFZSXYzb1dKL3JOellONStlTzc5UTF4?=
 =?utf-8?B?Q2RsaEtIck42NzRPamhjRDZ0SUpOWHY0OUVueE56RHZCR0VWUmVJV3YyVUd4?=
 =?utf-8?B?UTg0d3NKTUx6TFROd2Nndnh5YzZxK2p3ejEyNVRtTlpROE5oalNNVHJXVWE0?=
 =?utf-8?B?cTVsZ29vVEJyVE1kL2hBU05jaFhIVVY0L3EvM2ZJaWNGNjI4b3U2bUI3QU1P?=
 =?utf-8?B?bnFTRDVTK1Z0eGN3eHdWZHJZdjFpRW9LdStxdGVCcTFjNy9lL3F2VUZubnVV?=
 =?utf-8?B?RFU0WUNoUGk1M3c2THZKdHlMQnVEYjJkcWFPK2tzd1hUcDJFOXZHZUc2akFk?=
 =?utf-8?B?c1B2Vmx1Vy8wcExvVTlVNWVKSXhMSjl0V1crcUk4YitHZVhQZmZ0eUZnSDhI?=
 =?utf-8?B?bkNvL3RDaUs2dnlhUzllRS9sdDBEVHdmNFVyOUhQenduN1M2THZ3OXpjbi9V?=
 =?utf-8?B?SUpXUkpYREtSQzI4Rk5BVDlxZ1UxaTJxYXh3KzFxeDM1eTA0SXhXdnE5K0s2?=
 =?utf-8?B?SEhLSGhGKytGTWJ5NjgwMU9YaHoyQWt4TnloOUZ1SCtyUG12dWwwUjFnaEc5?=
 =?utf-8?B?aHJlNlV2YlU2OXR4RU1FQzRweDRVYThGV2Zyb2NaUUFQbnlRTTVOLzF4cGRO?=
 =?utf-8?B?T09zSnJUQ1ZPYzRyR3NOTktFUE1HVlZNd0ZXK0cwUGhFczZiUHFFOXlIcWxu?=
 =?utf-8?B?ZmIwdHgzUGJRWjAyVFMvM2ZXNmcrem1YWXBPN3VaTGhMRkhMYi9Cc2JFVGQ1?=
 =?utf-8?B?UXY2VDlnNnp2QjlKd01JVkhiMWsyYm9aMDY5L2tvejRwaU5wRG9RQU9Ga1Yy?=
 =?utf-8?B?aFp4bzdoNUw0SDJkSWJDTU5zeTJhT0VaSnVaWGZvS3dyUUdEL0tVNEtVUlV5?=
 =?utf-8?B?MzRsK2ZJbkt0RTJJSGpRZ1U2VytCMTVoL0VmM0JIdGM3MHVWdFJIMlA2V1A0?=
 =?utf-8?B?R1pLaGJsc1R0eEtvUWthdTZ4UmwrQk1SQXA0bnM2bHlyclNHTEhlNzR5QVpt?=
 =?utf-8?B?WkpFSG5zZ1p0YXRzeEFKNGl2SklBWUpXKzdYVFVVOWwrYjFJRFYwcHl6Y1Bl?=
 =?utf-8?B?TFYvZ2NKc3hQZlBqRDZRdFVjMGFESXkyNHMrS3A1ZVNqaERUZWtTQU1sb3lU?=
 =?utf-8?B?SWh0S1Z4Y3VxeE5FdC9FcStDTHZvcWFSVHMxQ0djUzl3dTVSUjZkWk5mbEk4?=
 =?utf-8?B?cEFCOWNpT2hNN1NJcVkwaW8zV2ExczI2WU1UTTdFRysrTURIREU4WWxHbGdq?=
 =?utf-8?B?L3R2QVNoK3NHQWtJeFBLRmJyT1pETGJWZmRzcGxQWDg3M3g3OGFmV2dOYnlK?=
 =?utf-8?B?NitPZFpLamRmaUZNY0VmV0ZIZ1ZnU2c1eTd6ZHhsMVVDVG83bWpyVzM5dWp4?=
 =?utf-8?B?R01ackZuVGNLRzhHelNIdU5FMWRuZjNkNlV1b0x2SGgyNzdoejBKRWhEWXRU?=
 =?utf-8?B?NTRYUWVmUFdHbVdhanM4WlllZTlkbjIwVnBzaG9vUU1PMnFCelBHbjVrYWhr?=
 =?utf-8?B?VENYK3dWK1phTkhYYUQrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3E1eWdoR3FuUm1ra0lHTm9aem00Ykd1ZkpzY1VBa3IrbUR0SG9maURhSHJs?=
 =?utf-8?B?ZVpJeEdGaW42ZW00OXN3TnRGbnZXZCtPRVZTLzlaQ2JDallUL1hiaWtyNGdB?=
 =?utf-8?B?VmRjZHNySWQ5M2diblRWYUpNbjZDVHI0VFFmdEY0cDlOdndoaERWZHZuQmVS?=
 =?utf-8?B?blpEaTlLaU5TMlovTnQySUZxb1dLNEliM2NZYStBQmpmNFBkQmJ1blBaUFhu?=
 =?utf-8?B?NHZjQm1GMXVRbncrWGVkakc3UXV2am1DSXE1TXRmY3Q1ZDJxZjYwblB6RHIv?=
 =?utf-8?B?aHAzWllFU0NOTFBSUzUvK1kzbDJGNjRWbnJYczJvSkhOdlBVZEVPS2FYeC9h?=
 =?utf-8?B?YktMaEFIaytId3Y1dy9EZ3NWR0UxcTQvL0M1dFZUZnZQYmVKV1p4NHFDa2Iv?=
 =?utf-8?B?Zm1oaHp3d0Q2d0JyVHM4czU2eldCSjFHUmRaTVh4b0NCbUtXSGZSWjcybEJm?=
 =?utf-8?B?UXdoWjVpbGMybmNCMC9KL3hydkh3TFpqaVFJVHlVS3Y3TmFmUEs2VTlSVnkz?=
 =?utf-8?B?SnFITDUxZEw3VUpSMTlZRnRHVGVCcWZxNmg1Zk11L2VUQ2ZYNTlnTHRrczRD?=
 =?utf-8?B?Q1FucVNENTVTa0hwdjVJU2VHTWlOdnMvb2xvSno3bkRhRTQzYk5UbFk0eGsx?=
 =?utf-8?B?REZiejJ4QjVCcXNZcWd6aVZoc3RXYTR2WStZRUlQdXJwbE8vQjYvSHZBN000?=
 =?utf-8?B?YTkzZVhiMTBjSzMyYzM4eU1uMUl5M2lSZ3g5Y0lPMGpveFIvdWxiUUhKQWgz?=
 =?utf-8?B?WVVVU3l0N2pWMWs5N2d1UktSU3cwUmRpUUxZNURyUzJxMTFRTGZEQXJ4akZ3?=
 =?utf-8?B?N1U1TFVJWXdLOUZDYlZSTFJxdzl0ZUQ0Y3YzaENEUUZOZWV4bDE2Z054cnlI?=
 =?utf-8?B?QXJsWUt6cktRVGhzdTJnRnR4OWwweVBUQ2ZIUGJqVjluTk1YRE9wUlVBby9h?=
 =?utf-8?B?bThTM3NZVTNEaFQxNHp0a3BueEx1elZ2bTRFMWVQNGwraTVZdnBXM2xuN3dB?=
 =?utf-8?B?L20yb2ZWSTV0OXlUdG83SGdkV3IwRXd3dVJMOXJHMzd0cUhneGtKanpjU1Ba?=
 =?utf-8?B?U2VDTjA5RXpONWNQWmZTNmtxRElHWjZ4VVJ2WEtTdU9iaUIrVWV1SGZHM3Fl?=
 =?utf-8?B?UE1HWnJMWUFGTFI5MGhMSkFMYXVSaFZwb093VDVhY1FOSXBqVUM2SU1lS0Rp?=
 =?utf-8?B?L2xNMGVCYXdYaEw5SE9MN1JaNkZlUTdLbCs5QmpMVEVYWXF2K09SeGl6bUJ2?=
 =?utf-8?B?SDJab21hbFJhbnpZV2d1cVpjVDNJUHYwMGlkbXdFeGJPak4yRnpVbTZ5OEVO?=
 =?utf-8?B?SkxZSHlSL3JscVI2ZU9ua0dHamVvUlVObGtFZGxlK2tYVkFqNE13TjdBSmpx?=
 =?utf-8?B?NmxYTmpab3VMcDFoNkMxUDFKVTRMOHdJak84Ti91VExqRzlZRFQ4SE1YWTVL?=
 =?utf-8?B?UndBdFZRNG9hVndUdW81R3I2VjNiMXM1Q0pRVHVSbk5zb01PS01oeWhYYUtH?=
 =?utf-8?B?cFpkMVR4N3l1c3RNMS81VmhIWXAwNld1UThOcGRPU3N5c2ppRG9Sd0FWRzBu?=
 =?utf-8?B?RHc1bVV3dzhGVFFEY0lmTEFnMitOeUsvaVpNNDh0RWhOdDBidFkwRHYySjJm?=
 =?utf-8?B?YXRMa2ZSaVBXKzZBVFlkVTR0TVFzM0huWFY5RG00SkhDUGt6bEpReXhpOWpB?=
 =?utf-8?B?b1k5bHBCZWVrMm5tanJrbUR6WDZjT0Z0Z3c5UFExbjQ0MkdGTmo0QUU0d0ln?=
 =?utf-8?B?QkFTWU9HRitKT01mY0o2Y1NQSEM2eEkrbnAydjdqU0VUczN4bjVCaXlBLzdD?=
 =?utf-8?B?OFByTjA5OW1TR3RTRUZhRkdwWWVKWUlPU2JZanFPNmZTTktvWStMY0ZXOEUx?=
 =?utf-8?B?QVd5TUJWUVBCSko5WGtJeERCTVl6Q2pxdWNUNzlBSlhSZjlab1hVRWVxYjlP?=
 =?utf-8?B?OURuUTVCQWRTclJYcmxqRE5helhWUG5TT2RGdDRwYW1yQU1BMVVhU3BTR3dk?=
 =?utf-8?B?K2lranBSTHRPTm45UHBSZFFiUHlQeDA5UWh1S1ZubjRlWnFWZ1k1K0J4YjJo?=
 =?utf-8?B?M1dDZUg2UUgzdk55bVVTaVNnMy8xV0lsRzcrWW12dWhEV1Nid1hoQy9pUWZz?=
 =?utf-8?B?VUFYbUxzNElSR1dzeFo0OU0vU0RIM0I2ZW13bmpuUGk1NUdIeEd5eGZKN2pq?=
 =?utf-8?Q?O442ugQ5BsiSoZ+DVrs5d1U=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5dbe06-08e5-43c2-dc36-08dcd2868c45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 17:24:10.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ai9VtEinGt9jMa6R2zWsutQ4stZdvkIU8vLX6e75kXvgHvKn+rwc7kqXVHMG+3YNsfBBgaWiGAozSS2Sm8uICw1y4FkETXYFoRlx2jore59pIVjIlBufjX99u6KKccr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8141

On 9/11/2024 11:12 AM, Mathieu Poirier wrote:
> On Tue, 10 Sept 2024 at 09:43, Doug Miller
> <doug.miller@cornelisnetworks.com> wrote:
>> On 9/10/2024 10:13 AM, Mathieu Poirier wrote:
>>> On Tue, Sep 10, 2024 at 08:12:07AM -0500, Doug Miller wrote:
>>>> On 9/3/2024 10:52 AM, Doug Miller wrote:
>>>>> I am trying to learn how to create an RPMSG-over-VIRTIO device
>>>>> (service) in order to perform communication between a host driver and
>>>>> a guest driver. The RPMSG-over-VIRTIO driver (client) side is fairly
>>>>> well documented and there is a good example (starting point, at least=
)
>>>>> in samples/rpmsg/rpmsg_client_sample.c.
>>>>>
>>>>> I see that I can create an endpoint (struct rpmsg_endpoint) using
>>>>> rpmsg_create_ept(), and from there I can use rpmsg_send() et al. and
>>>>> the rpmsg_rx_cb_t cb to perform the communications. However, this
>>>>> requires a struct rpmsg_device and it is not clear just how to get on=
e
>>>>> that is suitable for this purpose.
>>>>>
>>>>> It appears that one or both of rpmsg_create_channel() and
>>>>> rpmsg_register_device() are needed in order to obtain a device for th=
e
>>>>> specific host-guest communications channel. At some point, a "root"
>>>>> device is needed that will use virtio (VIRTIO_ID_RPMSG) such that new
>>>>> subdevices can be created for each host-guest pair.
>>>>>
>>>>> In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRTIO=
,
>>>>> and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, seems
>>>>> to get things setup but that does not result in creation of any "root=
"
>>>>> rpmsg-over-virtio device. Presumably, any such device would have to b=
e
>>>>> setup to use a specific range of addresses and also be tied to
>>>>> virtio_rpmsg_bus to ensure that virtio is used.
>>>>>
>>>>> It is also not clear if/how register_rpmsg_driver() will be required
>>>>> on the rpmsg driver side, even though the sample code does not use it=
.
>>>>>
>>>>> So, first questions are:
>>>>>
>>>>> * Am I looking at the correct interfaces in order to create the host
>>>>> rpmsg device side?
>>>>> * What needs to be done to get a "root" rpmsg-over-virtio device
>>>>> created (if required)?
>>>>> * How is a rpmsg-over-virtio device created for each host-guest drive=
r
>>>>> pair, for use with rpmsg_create_ept()?
>>>>> * Does the guest side (rpmsg driver) require any special handling to
>>>>> plug-in to the host driver (rpmsg device) side? Aside from using the
>>>>> correct addresses to match device side.
>>>> It looks to me as though the virtio_rpmsg_bus module can create a
>>>> "rpmsg_ctl" device, which could be used to create channels from which
>>>> endpoints could be created. However, when I load the virtio_rpmsg_bus,
>>>> rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device create=
d
>>>> (this is running in the host OS, before any VMs are created/run).
>>>>
>>> At this time the modules stated above are all used when a main processo=
r is
>>> controlling a remote processor, i.e via the remoteproc subsystem.  I do=
 not know
>>> of an implementation where VIRTIO_ID_RPMSG is used in the context of a
>>> host/guest scenario.  As such you will find yourself in uncharted terri=
tory.
>>>
>>> At some point there were discussion via the OpenAMP body to standardize=
 the
>>> remoteproc's subsystem establishment of virtqueues to conform to a host=
/guest
>>> scenario but was abandonned.  That would have been a step in the right =
direction
>>> for what you are trying to do.
>> I was looking at some existing rpmsg code, at it appeared to me that
>> some adapters, like the "qcom", are creating an rpmsg device that
>> provides specialized methods for talking to the remote processor(s). I
>> have assumed this is because that hardware does not allow for running
>> something remotely that can utilize the virtio queues directly, and so
>> these rpmsg devices provide code to do the communication with their
>> hardware. What's not clear is whether these devices are using
>> rpmsg-over-virtio or if they are creating their own rpmsg facility (and
>> whether they even support guest-host communication).
>>
> The QC implementation is different and does not use virtio - there is
> a special HW interface between the main and the remote processors.
> That configuration is valid since RPMSG can be implemented over
> anything.
>
>> What I'm also wondering is what needs to be done differently for virtio
>> when communicating guest-host vs local CPU to remote processor. I was
>  From a kernel/guest perspective, not much should be needed.  That said
> the VMM will need to be supplemented with extra configuration
> capabilities to instantiate the virtio-rpmsg device.  But that is just
> off the top of my head without seriously looking at the use case.
>  From a virtio-bus perspective, there might be an issue if a platform
> is using remote processors _and_ also instantiating VMs that
> configures a virtio-rpmsg device.  Again, that is just off the top of
> my head but needs to be taken into account.
I am new to rpmsg and virtio, and so my understanding of internals is
still very limited. Is there someone I can work with to determine what
needs to be done here? I am guessing that virtio either automatically
adapts to guest-host or rproc-host - in which case no changes may be
required - or else it requires a different setup and rpmsg will need to
be extended to allow for that. If there are changes to rpmsg required,
we'll want to get those submitted as soon as possible. One complication
for submitting our driver changes is that it is part of a much larger
effort to support new hardware, and it may not be possible to submit
them together with rpmsg changes.
>
>> hoping that RPMSG-over-VIRTIO would be easily adapted to what we need.
>> If we have to create a new virtio device (that is nearly identical to
>> rpmsg), that is going to push-out SR-IOV support a great deal, plus
>> requiring cloning of a lot of existing code for a new purpose.
> Duplication of code would not be a viable way forward.
> Reusing/enhancing/fixing what is currently available is definitely a
> better option.
>
>> Our only other alternative is to do something to allow guest-host
>> communication to use the fabric loopback, which is not at all desirable
>> and has many issues of its own.
>>
>>>> Is this the correct way to use RPMSG-over-VIRTIO? If so, what actions
>>>> need to be taken to cause a "rpmsg_ctl" device to be created? What
>>>> method would be used (in a kernel driver) to get a pointer to the
>>>> "rpmsg_ctl" device, for use with rpmsg_create_channel()?
>>>>
>>>>> Thanks,
>>>>> Doug
>>>>>
>>>> External recipient
>>
>> External recipient


External recipient

