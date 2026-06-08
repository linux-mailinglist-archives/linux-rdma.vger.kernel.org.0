Return-Path: <linux-rdma+bounces-21954-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ObjHI8a1JmqDbgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21954-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 14:29:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 465986562CF
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 14:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=kANrIDE2;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=xsmCqBFn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21954-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21954-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10A2A30297B1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 12:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B863783D1;
	Mon,  8 Jun 2026 12:21:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87C329396;
	Mon,  8 Jun 2026 12:21:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921299; cv=fail; b=Hb7twX5TBlD9noOAZdWVlFazfTDbEUVSn42P3hTjoxEMHrF7UpBX2cpuYpxlJlFizqbnOanjOrr0ZREUyDu7ctURYbyXq6f7R+WssD68u5Ap9ooNP1CxnZccBfD2D+ldBu5TLShIJg7lhXaaxIZNnZ86mZnnfalo1UyhCt895BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921299; c=relaxed/simple;
	bh=t19OzBqZD1E+JLCCnn+gxAPUn7Ojj5FUINKW1KCOJx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BB2RpFl6JnXBQGTFI6qffpEiTQNRiOWu2bQR3TSma7/Xdtoy2BGgxApZITtXwQcXm3155dEEYYIuR7wHMyFWADnuR+JKjDgD+dg3sYUD/qfa0TjXsTZA/zoBMDpks3M+975iVsB1FJuGq5OqOkV5GrujqQWjdRwYEeErdSTJiXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kANrIDE2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xsmCqBFn; arc=fail smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588NDxt035175;
	Mon, 8 Jun 2026 12:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t19OzBqZD1E+JLCCnn+gxAPUn7Ojj5FUINKW1KCOJx4=; b=
	kANrIDE2aFXMMZTLUS31zAGru/+dan9/ifOXcvAq3p/oqaqVDLwKx/63M6ibVgsa
	Wju5Yw8b26B3z6/PhXzAPAOso7lROZyp80wGMjT+VqaZkX9vyhCdtU9gfGhamude
	UqpkOCtTzMPq79/d1Nlb2EsCfV0wGk2omwsH9CSR0Sxm+SxyBGt8/REluqs908BK
	QxeekdthwGE1/A3KpjNozlxqDRUv/5azZPOIL2Wt+XXKfPyjP+ZbujXdv3mQEoVd
	vf4QR1OpOU2S2i86ShIYIFCFTWWrKze3Yc4UjLoNYmIeAtDwyrkGJSLSaaQD5Jf+
	oryDpovj1JKw/RYJqGXcmQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emaf92bwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 12:21:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 658CDXd6031515;
	Mon, 8 Jun 2026 12:21:33 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0nr4mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 12:21:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ftpi0bFQtj23Zq0NxbJRFbg7+gzUGeczIJHzwQwf5K5dAT8O3Kehgyh83IJ4ORjyuGoxaYyPU2wSipwZr6X+5dyX63dd5wJ7wdvxow1yM+CbLG47yJ3RftO9DEsMjAAQrR4QeWlqTH/FZiW9qQCq/HpdNnUx4/mygkfArvTJAN8OgIYWBqiM4dMHxi4w7WwQjOUsZIolNy9gPFclHsfz1L9asWsz0Sp1fkpVBiN85Mg0BxM36Iqvb3mWUK/7iMMaN4esxZby0Uj0wBf9Z6T/wpzipDXx9PD8fqPVAcKBvnHXeYAj46cm8uTu6UQPjVsI0hCa2xKgVN3GyyZ4qbiJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t19OzBqZD1E+JLCCnn+gxAPUn7Ojj5FUINKW1KCOJx4=;
 b=SMBXxA+WFBoBC1CTQHWmcLOZBT0b2BOUjxdMSGmivLy9XKLh9kL8ms6mpajLTgWHxGShpJaZhlMnZ6KJcqdOQMa4jSNyePDmTPg9QRD7JCVGUlc+13o4mO4tZrSch0d6uUW4gETKejlakEMjXaK7t7XLQAKe7XUU3WnKmo/U/FRmRn7Ttbf0TWJsMOOL7BtTtGomnYE4D8IXDChVMZrsUuWEsa4yST2ZwQZVhmnl5WAj8QsFamauhy7UeBCyjKVydYaZ0AVly/NnJ9tEfoUjx2HXM2hYWDvfUvVbP/QTizT+taqtpXCS1NEMXdT8db8z9IUaClB/7nYfQkuw+4d1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t19OzBqZD1E+JLCCnn+gxAPUn7Ojj5FUINKW1KCOJx4=;
 b=xsmCqBFn1veyUjZ55Dem6xzdt+lZuwspWZCcTqZSfUlv8G9hwS0x8qNKAQJlfUl41oYxiy8hJDXdt2N33hhJ0UDfhn+h4aVvGL8xcp53HwAjaRZD0y+g8SB8pyQXaPT5zUaBo7dySQWIsrlFbI5AP6H0IQbVmujUfRJKVT24mJI=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by SA1PR10MB997739.namprd10.prod.outlook.com (2603:10b6:806:4bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 12:21:30 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 12:21:29 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "leon@kernel.org"
	<leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anand Khoje
	<anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: RE: [PATCH] IB/mlx4: delete allocated id_map_entry while sending REJ
Thread-Topic: [PATCH] IB/mlx4: delete allocated id_map_entry while sending REJ
Thread-Index: AQHc3TfomMZpIpF0xUu1l8BvfgDSAbYry5EAgAj8XpA=
Date: Mon, 8 Jun 2026 12:21:28 +0000
Message-ID:
 <BL0PR10MB2820DF49DB4C58029FE82BB58C1C2@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260506090824.359239-1-praveen.kannoju@oracle.com>
 <20260602190706.GA1054315@nvidia.com>
In-Reply-To: <20260602190706.GA1054315@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-06-08T12:20:25.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|SA1PR10MB997739:EE_
x-ms-office365-filtering-correlation-id: 7f0c0e37-9511-46bb-327e-08dec55877c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4143699003|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 iazrtWm95npEBUXbcW1BXSeyuuNMFoTxDvM/RS7lYfSVV0CATgCkN/GgzbtNM+Pbr6pmrZZSR8HaaSZJhxwUamXikiohNG2yIUMNJdLOWypMzi8E4+VEfvP4P6tLj6yuuZGGcKqU8DLj9/qsKG9x5VjUQ6gRhjiJFmG6xWV4CTbkbeKkCOzaHmfAlYP5JBDSuUdU7ZGdRQ3a6xDT/DcpWwR03SllzzmT9t5RjMFIEun+g3JmSsgsCZmoECMBshVATjjRJ3kL1tMvMXgHQbky4SMBYODgHOT7IwAYboOtdBE2wzOHxOszsw8Lne9EgOFmW/zdDz6VIg1dBBLCtokccpaB4E2QKlULF7W13RpASatpzPnR8vJepM/35PsFHW9BWuggjwLhMD5005ZdZhtH/VMkABgAGPxixDOg1qg3Eq9UM2XKSXw7v1Kr5FbJeuZO5M7PycVehtB61v7gM08YhVGn9a4H489yQo+FEl/b8Q4zZEJhMJ5o5goQnRQyq8/8oyISp8LFxG4NL0cJza0Tte5fSCj3/pjBPPZpDMCkt6/k58VokWzYwOsekGfpPTyOOKLLqbBXpB+j2moRLqW8kyuAOoiVZkHiSzx8Thb2IPzMR/TXE4btdhrVFBiYfvnmoTGMb3hnLPrFBuBkCTkn+1xX+VLh+0iqjcRihbHF7Pp8o0qPqBudL/kJim77o+TiPhbGaXF7V22s/S0ldbScD94BPuC9b/8yyKsB/E4RYA/YAwdhqNneqWN+YNH7qRHx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWtjN1lNTjE0MjZMUG9LUEFtbis1RWJkVVlPNldPbjFFZTJVOE5zMUl1VkFa?=
 =?utf-8?B?K0R1U3dHV2FHQzRndDI1a0lLUmJDWHlET1RMb3hNKzFjNjlJRTdzTGNZK04y?=
 =?utf-8?B?MWhsVG5nUW1vUlY0R1hyOGpadE5lUFpkSzd3ZmZGVFE2SE9SZDNHb2dNNnpH?=
 =?utf-8?B?dGZqNzBiWE95NklkVHdGOHVvbUNEMjFhMlQxU05Fc21YYjFhZlNJL3p6ditC?=
 =?utf-8?B?TUV0S01oOUhiVHJkK3hVc1I4ZitpRTZXZ0doekc4QzU4cm5pYnNIdU5xQXUr?=
 =?utf-8?B?ZHR6OTQzNHhXbjRiTlpkaGFJb3JGMkdibjh5MEk2RjhyeTd5YS9NWXg2Qjc5?=
 =?utf-8?B?OUdJNDZaYVZ2T0E0N2FKR0hxb0VZTDI4anNzWEpQdDJ5ZjJCeTJyVDVia2xh?=
 =?utf-8?B?ZndyaUVPNnFFWHlJUDBtNEJlaE5zcGF4SGFUcFh4NmpKb3RJK0RpMGlZT3Jo?=
 =?utf-8?B?bzFJeGlaZGpaaS9jY3RHY1c1NHF4REhIOUtVMlpzdEM3WjgzU3FMNzRXcU5M?=
 =?utf-8?B?T242aENCZUgvbFJVY2NjcEQ4aE0vcTIyb25nUUNzWWJlbWFEb0ZCMFltMzBR?=
 =?utf-8?B?ZUlQL2s5alZERGNQdDNvbGdod2pZSE1ZZWNhdExZRFFRTVpHMFk3dHRNamQx?=
 =?utf-8?B?bnBtc1Z4Z0NXREc5YTBlWXdNYnJ4OUNHSkVabFZZWWFXOGxiVmZmWDdlQk05?=
 =?utf-8?B?ek9Hak5WNUY3VmFyYjdQQnJjSWZrdEZVVE80ZTRyT0h5eXR3d0VqYmNva2tu?=
 =?utf-8?B?ZlB3b1phOGRwL3RUWG5YNkRlRitISWdDVUhGVmtVRTF3ODNqZXZoOW9ML2dn?=
 =?utf-8?B?ejRwdVdGYWZ4aDFYK1MvaW0zQU5oVlg3c2t4Z1laZDlYUmJaRWlicVdXUHN4?=
 =?utf-8?B?SFBvRTFBd3Nob3VTWWJkRGgrbFg4eEgyNnd4dVd5Uk5nT0RiY3FEYnQvNVlz?=
 =?utf-8?B?V2hEdWFqT1BIbFBzVC92TWxneVYrTW5KZnB6WDRhSjlMcXI4cVEvRnIwSXJi?=
 =?utf-8?B?TC92RmR1akRJNU56Z3VhdzBuQWhLSnd6dHhDSHAzTjQ3ZlFJOCttVTN4K3gy?=
 =?utf-8?B?SGZhd2J3dHI3QVhGN1Z0aTVKL2Nqc3VIZnJMaG5xYmFyRm9pKzhSMWZSTnor?=
 =?utf-8?B?d0N4WXNtbEdPR1MrbitxcXRkcE1IeEJXdmI0bzF2QSt3dEs3WVJYY3FQYWVR?=
 =?utf-8?B?cGpEVXV4WjB2UWJNZVIxNkliR1FsK2w2NDd0RkVLNmpXT3VYU3VRZzVySy9Y?=
 =?utf-8?B?QXJndFEwQ2VhOUJsSnV0OS96bGREOWpNejNkWE5pc3ZMV0Zkb3VHbXZRdy9p?=
 =?utf-8?B?QU9xYUtWUW1DL0U0R09OTksxM0ZVMzhIWXZJVnNySGh2U1dsU05nYVFGaW4r?=
 =?utf-8?B?SUs1VlpFcmhSNTJBWUxoeHFOdDRaeXVWS05IMU16YlBqMktCb2g4RllGSnZ2?=
 =?utf-8?B?UFN4TzJ1VnBUM0pzS2xpOU1Fd0hsR0kxN1plclh0NjdEM0czWFp2YW9VcW9Q?=
 =?utf-8?B?UFdXcTkxS05TYVh4eUJ6QVh1cDRqb1JDb1M0OXBaQWFpRnhvUWlPWjVVcjho?=
 =?utf-8?B?bW5Ka2VvVnFkTjU2ZVVpTWhqbUJyNGNjOXlEMisxWFdWbXBuclpzeG5iM3Qz?=
 =?utf-8?B?TDVhRjEycHZtQ3NYbXFkRTFwcXdsT3NURUdESk94bmdVSkhkcFM2ZDN3bm85?=
 =?utf-8?B?QllCRTVFd3dHUXdkb2N1OVdpVEQyUFFiWXh1Ykd1ZjdhVWxmSGpaWlVOa2xt?=
 =?utf-8?B?R21vRnF4Z2luY0FmcUkwL2J5QzkrR3ZiYk92WS84eWdVSWtJcHdXZzNBVHU0?=
 =?utf-8?B?MDZDU1pwYWo4czBia2FpL3Y1cWVURlltbCtMZUVaZTVwbGxTMmRZV1FwZjJo?=
 =?utf-8?B?S2pFYjFxYnc1NUs3NnpWbFJla041ZG95b0hCdThiWUJuU0QvSUdCWk1hWWk4?=
 =?utf-8?B?c0EzejN1Ym5WaEVnd0diSFFYRGpST1RWOEd0cUp3UnNiZTl2eFhJU200T1Qy?=
 =?utf-8?B?UXpwcy82ZU8zTTdERGppK2lZRmRaWWFJZ2V6WFMzN2RuRDBYak0rUHVINU5t?=
 =?utf-8?B?SUtycWF2QlVhekczSWFlYkplbFFnUEQ5WjdqUW40RjFWRHBCb2ZkT0Y1R3R4?=
 =?utf-8?B?RkdQYTRqcXRVb0FlSklnNVovUndqd2F2TEg1eUhIU2hweG5nV1NBbFc4RVZY?=
 =?utf-8?B?VTg0b1A4WFYzNkV3THVpNStXVWZtMmdEaHdTelZzRzVvZTlYczR2VE5NU1dY?=
 =?utf-8?B?ZXpJMVliSElYMWs5K0RZcGMxb0xzQnNQNnNqcmw5cjM5L25VM1FBaTV1NHlJ?=
 =?utf-8?B?SWtKM1o5YU1Id3hzWGxPeVVxSnNnWmJxNER2SEY5bTlZN1FRaVpwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RZxktcwhAJ5Wt4gG4WyRt3Ar49h42rISwVHwhKmuVRXZkGvE1VPecNMTI4IdDqxQYO7RKc3AYM3nUAXogcZol8NAh/RxuB/emuFfCO6EezB7Z74/IvSlM659pOxBHXG6uxbZm7Ge8v97/b/8tyjKRGbkAqPk3SiWuwI5W1onBeXm2g1y3mC7m2KEEHJ6K8SpvqHuEfCCBq9N7oAZ7zEGUA3Ss/qmkRMoBFEITGzESPDznQXW39mGBVHDtmPGzFdgwtnMvk5H4I08gU27KEqSuPUcSfbuLOKGZWvQD2pMlOig05K+WizeLpuZVPsC5PAcI6jkYL0xCdK3TtSiKEn7Sw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jyupaHO8v4E4JSDvcjt2pG389vFQftr0UMep0/WIPAVsTqJyAGolNWSdQslrrKQ78b6iU5EnIr3j6bKPo4kNhsK3gwLtFOfUCnfljOOUuTvSJmHCuizJT8ya7EmbW9SeKBP8+r+/HNQPk6ngpSY3jdE2oAhQG26QG5wH3DcLvhK2EwDaVOnP/XJ4NQkySy3MOLe0mhAmVE13NQZscyqAT1jMs949nraOhDsc/d2xw95G+MqkG6DWKC0s1QZ4T3e6QOHjScPS7zJVduWd0Xzwbz3ZYnqRWCsg9iURDF2fsDBjPnOT+khRVBAM5T62EDHKXOkLusoQTZa6WAglTR6ZbIfap8x6CvthxRBoCke38iymX5HpHbtvuxHFhmCzOJA7jjDW3kcEpyiXCtbibYmyVZbcHJ8VRExOzh4KFirtOoJbge3UGfhmuhHNOuWOGCgpXZ19m2E0urzvXDUwy7/4dsCKHooYBXCK1DzEwyCqREDTGXadrsNyu9wEKRObQHGZtrzSnr2IBtRytM6GXAOXwuk1y7fVacDZmqivZ7kYxY/CEX5vv08+brP16zpbeZnVq5Jj7pBrQTLlxpRYVOjD6FCGxZsk8OiNa7SYYtuzj/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0c0e37-9511-46bb-327e-08dec55877c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 12:21:28.9939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7VXxke54R3yTMtudo+ZdXzCTy5mrdSLnT+I4qXPLUpn7qrj5NIfycQMqN4E2dT6nqnRnlp3KcUgn8oH9rn8cwOd7mirE5SUu9SPy3qeSy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080115
X-Proofpoint-GUID: gWP87tWjU75lI_66otzYq0bAqnwFyzJA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExNiBTYWx0ZWRfX1WdbfJcmWb+I
 e8ifQZo+yrsCpJJKOa2fFpIocVj+Id9jvHapW9TMEvvoKs9s5SZHqWQpWCJU7ARJ6yYM4bFnXCE
 XC2PvBp0H6blDqKcurcm9kvZGUUpTQ97voU4QT4J1VrlJ473lL92eRBb29WFPebZHXfI9gibXVy
 9AqMMGkXJp/Ryy3HxTWkKp8Q2R+KfIVuJavo+GnX8tHgYyZxTdqqAg3Nx0zdI6cCwKZIou29lqF
 ZQIJZtgRDBajEv+ptFh/2o+qTlj7tmloitd9MtvttKFKN+KsySUfiS85W2BUJa+NP+4s4M/etSD
 0AQ/oKchwr0pQ+WVyyHDFS70W/pKXvwUtOcKfCi0cW23M+FsSmi1UQgHlAVfX2hLAhy6Bjqsx4V
 dvmK3FOMcGhyj8U2l/V0xfbLhn84qed/k9mudIRSwoPrhPnsMQ6bXyZ3HHsJBRCbTzQNSz2sVOC
 YzHasN8c2NHFpkBHl2LdsuZIeUupWgY0wFmFdl6s=
X-Proofpoint-ORIG-GUID: gWP87tWjU75lI_66otzYq0bAqnwFyzJA
X-Authority-Analysis: v=2.4 cv=OYeoyBTY c=1 sm=1 tr=0 ts=6a26b3ce b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22
 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=1xRrPmHF1uPTaLBBBpAA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12313
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21954-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:yishaih@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anand.a.khoje@oracle.com,m:manjunath.b.patil@oracle.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:from_mime,oracle.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 465986562CF

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNClRoYW5rIHlvdSwgSmFzb24uDQoNClllcywgaWRlYWxseSB0aGUgUkVKIHBhdGgg
c2hvdWxkIG5vdCBiZSBhbGxvY2F0aW5nIG1lbW9yeSBhdCBhbGwuIEkgcGxhbiB0byBmaXggdGhl
IGFsbG9jYXRpb24gaW4gdGhlIGVhcmxpZXIgc3RhbnphIGFzIHdlbGwuDQoNCkkgaGF2ZSBub3Qg
eWV0IGNhcHR1cmVkIGEga21lbWxlYWsgcmVwb3J0LCB3aGljaCBMZW9uIGFsc28gcmVxdWVzdGVk
LiBJJ2xsIGdhdGhlciB0aGF0IGRhdGEsIHVwZGF0ZSB0aGUgcGF0Y2ggYWNjb3JkaW5nbHksIGFu
ZCBzZW5kIGEgcmV2aXNlZCB2ZXJzaW9uIHdpdGggYSBtb3JlIHByZWNpc2UgY29tbWl0IG1lc3Nh
Z2UgdGhhdCBiZXR0ZXIgZXhwbGFpbnMgdGhlIGlzc3VlIGFuZCB0aGUgb2JqZWN0IGxpZmV0aW1l
Lg0KDQpSZWdhcmRpbmcgU0lEUiwgSSB3b3VsZCBwcmVmZXIgdG8gaGFuZGxlIGl0IHNlcGFyYXRl
bHkgb25jZSBJIGhhdmUgYSBjbGVhcmVyIHVuZGVyc3RhbmRpbmcgb2YgdGhlIGV4cGVjdGVkIGZs
b3cgdGhlcmUuDQoNCi0NClByYXZlZW4uDQoNCg0KQ29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3Ry
aWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNpcGllbnRzDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgSnVuZSAzLCAyMDI2IDEyOjM3IEFNDQo+IFRvOiBQcmF2ZWVuIEthbm5v
anUgPHByYXZlZW4ua2Fubm9qdUBvcmFjbGUuY29tPg0KPiBDYzogeWlzaGFpaEBudmlkaWEuY29t
OyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5hbmQgS2hvamUgPGFuYW5kLmEua2hvamVAb3JhY2xl
LmNvbT47DQo+IE1hbmp1bmF0aCBQYXRpbCA8bWFuanVuYXRoLmIucGF0aWxAb3JhY2xlLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gSUIvbWx4NDogZGVsZXRlIGFsbG9jYXRlZCBpZF9tYXBf
ZW50cnkgd2hpbGUgc2VuZGluZyBSRUoNCj4NCj4gT24gV2VkLCBNYXkgMDYsIDIwMjYgYXQgMDk6
MDg6MjRBTSArMDAwMCwgUHJhdmVlbiBLdW1hciBLYW5ub2p1DQo+IHdyb3RlOg0KPiA+IER1cmlu
ZyBzY2VuYXJpb3Mgd2hlcmUgYSBSRUogaXMgc2VudCBhZnRlciBhIFJFUSBvciBSRVAsIHRoZSBh
bGxvY2F0ZWQNCj4gPiBpc19tYXBfZW50cnkgcmVtYWlucyBpbiBtZW1vcnksIHJlc3VsdGluZyBp
biBhIG1lbW9yeSBsZWFrLiBTY2hlZHVsaW5nDQo+ID4gdGhlIGVudHJ5IGZvciBkZWxldGlvbiBk
dXJpbmcgUkVKIGhhbmRsaW5nLCBpZiBpdCBpcyBub3QgTlVMTCwNCj4gPiByZXNvbHZlcyB0aGUg
aXNzdWUuDQo+DQo+IFdlbGwsIHRoZSBsZWFrIHNlZW1zIHF1aXRlIGxpa2VseSwgYnV0IEknbSBu
b3Qgc3VyZSBhYm91dCB0aGlzIGZpeC4NCj4NCj4gVGhpcyBjb2RlIGxvb2tzIHF1aXRlIG9kZCBh
bmQgaXQgc2VlbXMgdG8gaGF2ZSBvdGhlciByYWNlcyBhcyB3ZWxsLCBzbyBJREsuLg0KPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFByYXZlZW4gS3VtYXIgS2Fubm9qdSA8cHJhdmVlbi5rYW5ub2p1QG9y
YWNsZS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L2NtLmMg
fCA4ICsrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21s
eDQvY20uYw0KPiA+IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvY20uYyBpbmRleCA2M2E4
NjhhMzgyMmYuLjIxZjJmNDAxZWQ2MQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tbHg0L2NtLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4
NC9jbS5jDQo+ID4gQEAgLTMyMSwxMCArMzIxLDkgQEAgaW50IG1seDRfaWJfbXVsdGlwbGV4X2Nt
X2hhbmRsZXIoc3RydWN0DQo+IGliX2RldmljZSAqaWJkZXYsIGludCBwb3J0LCBpbnQgc2xhdmVf
aWQNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIHNsYXZlX2lkLCBz
bF9jbV9pZCk7DQo+ID4gICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihpZCk7DQo+
ID4gICAgICAgICAgICAgfQ0KPiA+IC0gICB9IGVsc2UgaWYgKG1hZC0+bWFkX2hkci5hdHRyX2lk
ID09IENNX1JFSl9BVFRSX0lEIHx8DQo+ID4gLSAgICAgICAgICAgICAgbWFkLT5tYWRfaGRyLmF0
dHJfaWQgPT0gQ01fU0lEUl9SRVBfQVRUUl9JRCkgew0KPiA+ICsgICB9IGVsc2UgaWYgKG1hZC0+
bWFkX2hkci5hdHRyX2lkID09IENNX1NJRFJfUkVQX0FUVFJfSUQpDQo+ID4gICAgICAgICAgICAg
cmV0dXJuIDA7DQo+ID4gLSAgIH0gZWxzZSB7DQo+ID4gKyAgIGVsc2Ugew0KPiA+ICAgICAgICAg
ICAgIHNsX2NtX2lkID0gZ2V0X2xvY2FsX2NvbW1faWQobWFkKTsNCj4gPiAgICAgICAgICAgICBp
ZCA9IGlkX21hcF9nZXQoaWJkZXYsICZwdl9jbV9pZCwgc2xhdmVfaWQsIHNsX2NtX2lkKTsNCj4g
PiAgICAgfQ0KPg0KPiBXaGF0IGlzIHRoaXMgY2hhbmdlIGZvcj8NCj4NCj4gSXQgZG9lcyBsb29r
IGxpa2UgaWdub3JpbmcgdGhlIHJlaiBpc24ndCByaWdodCwgYnV0IHRoZW4gYWxzbyB3aHkgZG9l
cyB0aGlzIHJlaiBqdXN0DQo+IHNlYXJjaCBhbmQgZnJlZSBidXQgdGhlIHJlaiBpbiB0aGUgcHJp
b3Igc3RhbnphIGlzIGFsbG9jYXRpbmcgdG9vPw0KPg0KPiA+IEBAIC0zMzgsNyArMzM3LDggQEAg
aW50IG1seDRfaWJfbXVsdGlwbGV4X2NtX2hhbmRsZXIoc3RydWN0IGliX2RldmljZQ0KPiA+ICpp
YmRldiwgaW50IHBvcnQsIGludCBzbGF2ZV9pZA0KPiA+ICBjb250Og0KPiA+ICAgICBzZXRfbG9j
YWxfY29tbV9pZChtYWQsIGlkLT5wdl9jbV9pZCk7DQo+ID4NCj4gPiAtICAgaWYgKG1hZC0+bWFk
X2hkci5hdHRyX2lkID09IENNX0RSRVFfQVRUUl9JRCkNCj4gPiArICAgaWYgKG1hZC0+bWFkX2hk
ci5hdHRyX2lkID09IENNX0RSRVFfQVRUUl9JRCB8fA0KPiA+ICsgICAgICAgbWFkLT5tYWRfaGRy
LmF0dHJfaWQgPT0gQ01fUkVKX0FUVFJfSUQpDQo+ID4gICAgICAgICAgICAgc2NoZWR1bGVfZGVs
YXllZChpYmRldiwgaWQpOw0KPiA+ICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPg0KPiBTSURSIHNl
ZW1zIHRyb3VibGVkIGFzIHdlbGwuDQo+DQo+IEFJIHBvaW50ZWQgb3V0IHRoZSB1c2Ugb2YgaWQg
bGlrZSB0aGlzIGlzIHJhY2V5IHRvby4NCj4NCj4gQnV0IGJyb2FkbHkgdGhpcyBzZWVtcyBsaWtl
IGl0IG1pZ2h0IGJlIHRoZSByaWdodCBkaXJlY3Rpb24sIGJ1dCB0aGUgY29tbWl0DQo+IG1lc3Nh
Z2Ugc2hvdWxkIGV4cGxhaW4gd2hhdCB0aGlzIGxvZ2ljIGlzIGFsb3QgYmV0dGVyDQo+DQo+IEph
c29uDQo=

