Return-Path: <linux-rdma+bounces-23257-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a3NiOxxBV2qzIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-23257-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:13:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9F75BC41
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:13:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=aBRUbO5p;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=adz0AquG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23257-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23257-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C71673013D64
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F63C8C43;
	Wed, 15 Jul 2026 08:11:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D53C9880;
	Wed, 15 Jul 2026 08:11:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103113; cv=fail; b=Xc74YIHbEHU4B2nfgQQA/6HTJa572oVh4t2HzbVg7AcJFfTpO843nJAfnpSczaKt+HDBIN6lMzBxgenLYsYYmDOcyBqRLUqrVQX7TxEqreXj4DnSTn8Yq8lSxM8syJo+/stZ38hkxNgvsGMaaHDzBXydmpWQKF5CdyM/9w2YD9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103113; c=relaxed/simple;
	bh=7hXeAPp90CwrXRm3MxL3VKKU0PTiTmvf3dxTzjhkpEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+rBcED0lFdR8fgYws8HXlKiFNRRT7z9Q7uU6MH8/ce7YWNCWdcCIvGUICIeob4hiv30Luk8PMKchHOKWPXQBPGGMiyHWHeC2s9pi4bBzRpzjNu1/G0crYbV2QD1HsC7seVhSnqO8xNdfrSiWEmaN4LqmDm8C4ADqL7AiS+C6mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aBRUbO5p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=adz0AquG; arc=fail smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ENKP2j231225;
	Wed, 15 Jul 2026 08:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oOyr+ZvfXu3TaIMCYa8/Bk9YUCVLbqPtTst/E8gTiLc=; b=
	aBRUbO5pJGiKVV9/q/DUcHEJzpqLlEFZf20mXKZQMYeXaNa1IZkytRKe6uUm9kQM
	P2nV91EqH6SJjbc+S55buI34t74A3erYlnMU7X05rrFVT3+k/bo2h+JgxkSDsxXT
	YJHSA1XO07t9K/2OTTs+O92LqcrPJJwD8epY80U2ZAWDrQmibnj/ExHNkDGiBJXS
	T17ipqYSv36f86FuDae6GDkse4LUEtyLulD5IutlXXBbKTu3U94zXMunsnsc0OUy
	n0aEDfkjHtBoVWpvPPfetu34LI+Dh1AyZv6iPly049I/EzYcrgKj18rd2XbHJzRn
	9tWQc7OE0T25FAs1yeXV8A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed2ec9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 08:11:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66F83A8u029872;
	Wed, 15 Jul 2026 08:11:44 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9f51e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 08:11:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/FGyHWOE0Ft6+PwJy2EyLvRg9+zaLs5FqF8cazB+Z5dLXB/STO5WL83qC0xkztbJnbrdCm0wxrprDTn2mWkUO4CkhOiGe21vrVJ+N7w6bwdBlPj4Ogdxez6OCIRmR4SNkFEAbah7LIPhv4feCpfVlQLZ17ZS/WR772HmJAPiOtLS8GozzgzKuZbWYnsD3lFp0ByquwK3R1uoL3Vtk9Mnmf3bL46W+2wvHP1mgi+crTmM7oyXiKztEeu8kwyYv8yTZ8IfYDeGIoPCHsrKji2j2JGBfzVGBCBIjTvKfev7adh/6KGR0myr0g6M8A3fn2LW8jaSfZWs7G6T4xGQr6O4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOyr+ZvfXu3TaIMCYa8/Bk9YUCVLbqPtTst/E8gTiLc=;
 b=S+ujAEeefsJmyObxoqgmjc/p2dWkFLr77t6ql9XzMOYpmIG7UtQr6czQ/G5tggtvp4b0TcEg88jQYkhE1UVJthypv0P2uPHVf5B4DRXs/uoEMa6MPjHaJ/Ho80al8DkeL56SVyIGwnc5PyFgzWulj9L+XoyVwbBxCyLxOTDg1MiUyKJbOEBPApgYHSqhw5M+kpUXvtNa1JA3lJjy+jDrN7izvdghcupAoFnrT4MJM0gw8v4fsjqq707NdOLu52zJrcIcwmw/cT+dSBnLBmxk0RlRCvfQUTY96kpJznz/YTtzn1uTx0PCaC+zME0GNdkvOKfLD1ZhJfus0pjFiy8EJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOyr+ZvfXu3TaIMCYa8/Bk9YUCVLbqPtTst/E8gTiLc=;
 b=adz0AquG4es/L/tzyOdY2bZwOoPyswOfk4DqMZ5QHuOvLRqbMPUHpJeJQIKZGSMxZ05SC1oZPGgHrXMkfS2h5aPN9jo0rj94508zud6rwHMQGMC1rXhwupgRYoR5LCdrr4olE5rm8VoOIEuhfTN+PPV1znGBgal16e0ejRwOisM=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by DS4PPF717557185.namprd10.prod.outlook.com (2603:10b6:f:fc00::d29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 08:11:37 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 08:11:37 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "yishaih@nvidia.com" <yishaih@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Thread-Topic: [PATCH v3] IB/mlx4: Fix stale CM id_map entries when RTU is
 never received
Thread-Index: AQHdErhpMjYjgPvz5EKfhf1djXv577ZuKz8AgAARouA=
Date: Wed, 15 Jul 2026 08:11:37 +0000
Message-ID:
 <BL0PR10MB28202BB8E62E5F6D976F94328CF82@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260713111142.1206710-1-praveen.kannoju@oracle.com>
 <20260715070540.GB21348@unreal>
In-Reply-To: <20260715070540.GB21348@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-07-15T08:08:46.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|DS4PPF717557185:EE_
x-ms-office365-filtering-correlation-id: 92faf4db-ebda-4b5d-f05f-08dee248b14f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|13003099007|38070700021|6133799003|4143699003|18002099003|22082099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 xJChxeifQjVqBjPkmlUBgRLhOm0SyO3PGVivVJIh9I6twLE9q7es6NrhzkoBUVM264bg2BHVdRLY+1T0PusaNbl+VUvfX0V0VyYp0qzP8+CrufRAe2S96rlKfe1eFwIRHsIMjcizjz+58mMGyccVYkCQ5dv1ZNrxzAtAZLjymkw//e2r1rjyIGvlaJHMquhj4zBILJlH994EB8mVILHLlTvxeQv3SJLewqlBf6wgrMcC8fA5YEt9yFuUEulm+K5rnsHzaYr2xs2Rb32/EqVSsGj7kd3twibZ1/0Iok/QZJxlHQhABXmMAnZvVlj9vIH1z84zgfevW8hsfsUcuyTS1LkEakSWwN9FECLZGiieXBnqG3TgZxRMs/3neunG2FQ6vcA7x6Jr2AfCJZkX8jA9kL0sfG9wRtkI4LrRgGkjcGyxlfrq/Pv5HkUZO6wYji9I3UY9ZecGPMKrpbbF/mnoZQq9As4FaXlAoccRF2JfIutcH1VqpBZyLbO5DutIEIDe5LSwaVKY2677gK6ozhK42Z8yoMh5pXTPJnndirCEoLQLa8uK8yyztjw89euv9TDy+qNdSmtkyomjBhCkxjquCCXAFrwK/PKPuxB+T/dI/lxy665RBsg6pd3datABJQ3Mif0PkEz1aqgfhblMLhRK9jMcNlPLF5/lNSwO8stKFeU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(13003099007)(38070700021)(6133799003)(4143699003)(18002099003)(22082099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?bVNjaGsvUWxOTjlsaXdMRCstdmpLYnR6bFdJNW5ReFVGcjd3YnpoaW1HdVFx?=
 =?utf-7?B?ZistZm45cFd2RGJtV2xYRGJlc2d5Yzdtb3dBNHNnWXZ5YkY2eDdBQjAzMVN1?=
 =?utf-7?B?S2Ftd3BKMFZWaXFmY2JnR1NpSVZ2N2N4R3VJZzV2SGRqbFF4MnBTTEhyMk1u?=
 =?utf-7?B?QkJwYXJnYUlCWEhOdTRSWnNOYXZsSU50VDVXVkFNTUliV3BrcFVSaVFjcldq?=
 =?utf-7?B?VGgxcXBPQk45ZWxxOW9nRkN2bWNkelRlamRNbWNweXhXTndia3ptbFBJTWJo?=
 =?utf-7?B?TjZFZWU2L1VyUndsV2RNNzBFSXVQVG1ReWFmY1E1aDNQdjFsQ3pjajlGQ1Rx?=
 =?utf-7?B?eGU0QW1XTTVrS3l4S2FUL1BQcjZ5ZVg1MVpvU290YmhUZHlWNjdVOS9hbEtp?=
 =?utf-7?B?OUtzM0lQeTVLKy1td1FUVHZWRXgzTkpVUWVaMndxaVZjeEJZTmNYVW9WS1Bj?=
 =?utf-7?B?OXp1c1pibTZMVll6VzdVazcyRENjSFBSakJXaVZ4clJ6ZEwvNCstVmEzYm9P?=
 =?utf-7?B?TExlNDZMd1B3RkMzSTN6eHRiUjc3WjNBVlJOYjFkNWU5WEhybXhTS2lsZEpD?=
 =?utf-7?B?NHo2SzRKL21VV3ZWQTliL1FLRkNJNDY1RnpTWDczb1pabHdDU3dURnRqY3pT?=
 =?utf-7?B?eU11NEl5Sy9ZMmM5MktRTGRuRjNCN1pLTFJzdktGUHoyR0J2dS9WRXNiaGtk?=
 =?utf-7?B?RU92WHUyZ1JOb0JtbTI3N1FhYk5VZXZhdloxQy9pTTRqdGQvejJaVEs2dnJN?=
 =?utf-7?B?UHpFRnZWNjRzd1lkamZYSnB4Qy9mVE5CRDBaL2dBOFM0RmZzZHNxUlFIdk9R?=
 =?utf-7?B?eHFsYmplMTE5R1pqM0dwR1IwZ0xscGo5d29UVUlFTmJCcFErLXl1ZVNicUM0?=
 =?utf-7?B?S2hVZUs0Ty9mVVI4eGpUcWcwa0MxbDRlZXlVa3BnVGdheVVsQmZxVGVrZU5a?=
 =?utf-7?B?TWJaTXZxUjNWdXE1NTY1Ky0wc0xGVHhEL3NxMGg2ckhUT3VCNU1BNjdkeVBD?=
 =?utf-7?B?SUhyUzRxMFcydXl1SHpPNTY2bTYzSERPZWIxN3cxTFNJTS9oOWFYQnlBbWVP?=
 =?utf-7?B?OHE4S21KdkQydE1pUVJydGc1T3VjUEdLRUVOazdhQ0xyQUpqQVgxeDNYSmk1?=
 =?utf-7?B?eUhxdWc2cUV2aFhPa3NDUGdCYWNnY1c2S2c3TmJMM1FkdXBmQXdQYXRqZzNp?=
 =?utf-7?B?NDlCSTBmcUUxem81TmQvRnZoTDhJZXFFbmhuZ1BZZXpzaFh6QjlpN3Y4Unlj?=
 =?utf-7?B?Ky1TZlFGQnl6distcEVMYnFMR0d3NXYzKy1SSTM4cWlVNlpXSzVwYjU1YWV1?=
 =?utf-7?B?TVNHMWhRZUdUKy1tWkRDWHQ5L0RLdnpYMFY1V3lKS0hzZUhON1ZsblF3bzF6?=
 =?utf-7?B?UHU4Sm9ua0pTS0ZabVhVQlJjVFpIb2YzTDhvZ2VuM3J1ZGdiZ1N0Nk03MkJm?=
 =?utf-7?B?c0UyUkVuTGxHZmRMRVNyV3VsUldUamZ1RWcrLVk2dDNqcUprKy16SWQvZHBv?=
 =?utf-7?B?RFBoN2g2bmdOb1ZncGE5L2RrNystRWZLVXRkU3hLMzU1a2hZKy1TZUpPRzBR?=
 =?utf-7?B?cFFVSUlrNExnOWpDWHNFR2tKVkI0TElMQ3JWckpSZHlvMVZNYW9uajY2cEtO?=
 =?utf-7?B?MmpuVlJkR2RDZlA5cEdJT0xpR1VRMHM0SVJjdzBDZnZMaTVuMklxR0pCSkhq?=
 =?utf-7?B?cW9Uc2REMGxBTFR5N3VBM21DTjFCZXc2QnBxWlF0N3JFRzdsMGZoSDlqQ2Zu?=
 =?utf-7?B?SWkzQWRZT2NOWmNiLzFtWXdHSVpwTUpQeGk1QzVWUjJiclA5OC94T1prZWw=?=
 =?utf-7?B?Ky1kdkVTYm0zcDRmcmp5dnVYWXVRWFVqbE5EQU1uSmRvVVFKU3FPRUxGZXBy?=
 =?utf-7?B?N3ZiNWhSMG9Ec0ZTbUlBOWc2NXZBQkdCcHF1Z0RPY3VidlBzSWdqV05WaEFI?=
 =?utf-7?B?Q0o0a1BZdmE1RVVjUWFJZThHVmw4TXpuRG9KZDJLRmRXYnRwUDJFTnIrLVFm?=
 =?utf-7?B?OVQ3VkI2U0RCUDBCS25iSUI1UVY2TTgyWmV0aTdRWXRBSkd2d0hsSlhGRUp1?=
 =?utf-7?B?eDdvWEdmbXN6M2svaW0rLWpsbTFRTjQxSUVTRWY5VURlTHJYbUJCSHAyQkdk?=
 =?utf-7?B?QXRiU2NZWm42QXdSY0s2dENaNFFmTlNORXA1d2cvUkE3YUNwai9oVlVOQW9W?=
 =?utf-7?B?dEdlU0RIMzVGY05TTWZUQmtyQWozaHoxQjlJbGlSb1c1SkU3MjJrbTdoOXBG?=
 =?utf-7?B?MHlTUjFpYjRBbHRMNG5DTG5SWkJhVXM5a3A2L3A3OWpOdkY3SWQ4Z3lmTUww?=
 =?utf-7?B?ZWcxOG1POVEvVGFyYk4rLXBnQTVsamdxTzV4d2xPaThEa05mLzdpNDdSUmtB?=
 =?utf-7?B?WkNSbnVDQTdJODZVZEErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pLw56xS2fqptpO/aRInzHCQnRCUXo+TsSdHpkGgxJI0TH/kUSDPaPnx063+WBplcbWXTts3EImdohZFbFk3twKkIcSxf6tBFh6x2+N/bzfb/S6Oxj7jCS4GzWwbWeWklT1rxwZUfgViysWJlFl/ERkpEwzIGTwkd8v7KAT0Yqj0NpF+y6FcoTMnPlSG8Qu0oUHLxahFix2vjJ9xPivfk9spCxF/a8+E30VYJpuDPAUMEGIkErX7xsv9uOU5EL9gtqUyNOtD8pyy2d81rY7wsy8zMj3ZAvd0ynpbvOr78xKUVYLeH+/i6TwlQQKVgPLIpVfWTaLgnckJFeHb2Im3WCw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0t81EAUo+439ruG7cWvUoLGHXG8hvFUOeEgg71pSNzjzib46/ef5ME1j+esUoJoKf3rh07B6tdMd05vvUS40IHfBVzdlqfcsmqsjtf+2eQqZ2hrw63yMBMNqioVEqYyA+ZyJxTORNLM4LBOgvcoi7cEOq2GtxnVvTVx6cSFCwiYXSNonnZ7ZBK91Ogi1Oh8OKTmvrwJD3kvi5sBXGI3MuqXiUT1CVIlkeXE06zPbMtj4qJYxon2co7nZY4ckUNkRduMgAwk7+CLHW+ifaOXwqc0YpLF/2c5kMvciqPNC3BONzTC5xj64nIw6vwolu9z6dkbrzAwQMADJP5CFGT3bVOaG7xCZGXuQwdU3JYjueykCJ4vsTpnwnx4GqnRi2+Oc3r9yntv+bjz/t/0jlFEPlwMI6R9Ey+4dsTlXD0hH0S+r7tfdppUsGNfrnOcm3rPT4u91u5UT3olS2USYwx72W617MEbn1VKHMUYmWIMoIvhLSsLmtqqNcAxL6/EPgi2UR4vOpZLb9c6jheAXUk7EGx6qfzXK0/QCzAxTAH+SG2SUyCBx2zOyzO/MXKbWyUCgYrgfJQy8KGQ+PqJuWxruJNptyD5zloM4eWbS65Zd01s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92faf4db-ebda-4b5d-f05f-08dee248b14f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 08:11:37.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2PBaH+IE7xnMJO834cFD6pJR2d53BPuDerhulvTFISqep+ThtMVd4ryRi8PAv64f816VtxBKeaCeboadYodQboFrTcBwhvGp0V3wFZrRWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF717557185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607150077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3NyBTYWx0ZWRfXzPOJmHRUssnX
 cfrPzofnHUiDBscquDvQgSSaSHetfNCRoN7O2ancIvDs3Sx3iQ3m/6nJweqaaVaohm+2cUBsbp8
 1h3G/7l+rwrqhttfxzgvvKSAqqb9S17cUNr64WNUCdnb98gelKXTMiGKwm5zb6kZ1WWYXn+r4bD
 buwWPddvNFTrkL93rlNV1jG4b3KkHPdi4nYC7mcNd8jBESue6qyKLp2suzaWS1irX/fEtDUwdZ7
 MJoOPeOn2gzXMdbXXSv6Dm38Rl6Lak5o1Nq2Fq9khUQTv8lpwvLXXJI0MtKNSqXBjwx2ND8suNM
 XDNJIjQlGeiEhATBx8k7zjPsdL3lI8mUgcVF7XwTBzVXwK5KwwB6x+PC7IEKQDAqkg8qY24LHEK
 LZekAVdOyTZGdTtJa2DrjxWsIxa6Wskrqipf+e3ocsmzM7tUleSArMiBIS0eg4Uk1252XnEnwU6
 2BD59LGnOukUS5TxjwA==
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=6a5740c1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=mQvHCebiAAAA:8 a=yPCof4ZbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=UqCG9HQmAAAA:8 a=c1PdSmG1AAAA:8
 a=BXszkKfDAAAA:8 a=Fofg-9D3AAAA:8 a=iO2DuEkO6B8mhreNsLEA:9 a=avxi3fN6y70A:10
 a=wsrb8zZI_WQ3QAEBCXTy:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=4iM0TfZbaBQr0p37pvCp:22
 a=duu7wrcty9prphiCz_fF:22 a=Xbaoi9ZUBzzYp91LqZJF:22
X-Proofpoint-GUID: BCiTWyQapLzzwOt8yAu-Js_FFWkOt_4m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3NyBTYWx0ZWRfX6ct7I+YTcQDw
 +qhc0QQHdQ9+3lnl+zUMUPN4TXHCkhskTHiKrEZ7KZgao1YEEGEMbAyVRTd/LKQu4uV+5T7KJMO
 MpYuhVnoxhKH2fqiy5NWg1CGPggZPS1M07Xj4zEYJUAbk5cyzmDH
X-Proofpoint-ORIG-GUID: BCiTWyQapLzzwOt8yAu-Js_FFWkOt_4m
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23257-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:email,BL0PR10MB2820.namprd10.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7E9F75BC41

Oracle Confidential

I missed rebasing this, Leon.

The conflict was with my earlier patch, +ACI-IB/mlx4: delete allocated id+A=
F8-map+AF8-entry while sending REJ+ACI-, which is already in rdma-next. I h=
ave rebased the fix on top of it and sent v4:
https://lore.kernel.org/linux-rdma/20260715080738.1357072-1-praveen.kannoju=
+AEA-oracle.com/T/+ACM-u

-
Praveen.


Oracle Confidential
+AD4- -----Original Message-----
+AD4- From: Leon Romanovsky +ADw-leon+AEA-kernel.org+AD4-
+AD4- Sent: Wednesday, July 15, 2026 12:36 PM
+AD4- To: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Cc: yishaih+AEA-nvidia.com+ADs- jgg+AEA-ziepe.ca+ADs- linux-rdma+AEA-=
vger.kernel.org+ADs- linux-
+AD4- kernel+AEA-vger.kernel.org
+AD4- Subject: Re: +AFs-PATCH v3+AF0- IB/mlx4: Fix stale CM id+AF8-map entr=
ies when RTU is
+AD4- never received
+AD4-
+AD4- On Mon, Jul 13, 2026 at 11:11:42AM +-0000, Praveen Kumar Kannoju wrot=
e:
+AD4- +AD4- mlx4+AF8-ib+AF8-multiplex+AF8-cm+AF8-handler() allocates an id+=
AF8-map+AF8-entry for CM
+AD4- +AD4- transactions, but the entry is normally released only on DREQ o=
r REJ
+AD4- +AD4- flows.
+AD4- +AD4-
+AD4- +AD4- In the duplicate REP handling scenario, cm+AF8-dup+AF8-rep+AF8-=
handler() may be
+AD4- +AD4- invoked when the remote side receives a REP for which no matchi=
ng
+AD4- +AD4- cm+AF8-id+AF8-priv exists. In such cases the CM handshake never=
 reaches RTU,
+AD4- +AD4- and the sender side may never receive either DREQ or REJ cleanu=
p events.
+AD4- +AD4-
+AD4- +AD4- As a result, the allocated id+AF8-map+AF8-entry remains indefin=
itely,
+AD4- +AD4- resulting in a stale mapping leak.
+AD4- +AD4-
+AD4- +AD4- Fix this by arming an RTU-abandon cleanup timeout when the
+AD4- +AD4- id+AF8-map+AF8-entry is allocated. The timeout uses the mlx4 CM=
 workqueue and
+AD4- +AD4- the existing
+AD4- +AD4- schedule+AF8-delayed() path, so later DREQ/REJ cleanup can shor=
ten the
+AD4- +AD4- pending timeout with mod+AF8-delayed+AF8-work().
+AD4- +AD4-
+AD4- +AD4- Track whether a pending cleanup timeout is still waiting for RT=
U. RTU
+AD4- +AD4- cancels only that initial timeout+ADs- if DREQ/REJ has already =
converted
+AD4- +AD4- it to normal teardown cleanup, a late or duplicate RTU does not=
 cancel
+AD4- +AD4- the teardown timer. If the RTU timeout callback has already sta=
rted,
+AD4- +AD4- leave the entry on the timeout path and make the RTU packet los=
e that race.
+AD4- +AD4-
+AD4- +AD4- Hold id+AF8-map+AF8-lock while looking up the entry, canceling =
the RTU
+AD4- +AD4- timeout, scheduling teardown cleanup, and copying the id values=
 needed
+AD4- +AD4- by the CM handlers. The delayed-work callback rechecks
+AD4- +AD4- scheduled+AF8-delete under the same lock before removing and fr=
eeing the
+AD4- +AD4- entry, avoiding use-after-free when RTU races with timeout exec=
ution.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Praveen Kumar Kannoju +ADw-praveen.kannoju+AEA-o=
racle.com+AD4-
+AD4- +AD4- ---
+AD4- +AD4- v1:
+AD4- +AD4- https://lore.kernel.org/linux-rdma/20260507154755.452008-1-
+AD4- praveen.kan
+AD4- +AD4- noju+AEA-oracle.com/T/+ACM-u
+AD4- +AD4- v2:
+AD4- +AD4- https://lore.kernel.org/linux-
+AD4- rdma/BL0PR10MB282074FA0D571F5072DFCB4B8C
+AD4- +AD4- F12+AEA-BL0PR10MB2820.namprd10.prod.outlook.com/T/+ACM-t
+AD4- +AD4-
+AD4- +AD4- Changes in v3:
+AD4- +AD4- - Replace +ACI-Lock should be taken before called+ACI- comments=
 with
+AD4- +AD4-   lockdep+AF8-assert+AF8-held(+ACY-sriov-+AD4-id+AF8-map+AF8-lo=
ck).
+AD4- +AD4-
+AD4- +AD4- Changes in v2:
+AD4- +AD4- - Queue the RTU-abandon timeout on the mlx4 CM workqueue throug=
h
+AD4- +AD4-   schedule+AF8-delayed() and use mod+AF8-delayed+AF8-work() so =
DREQ/REJ cleanup
+AD4- can
+AD4- +AD4-   shorten a pending RTU timeout.
+AD4- +AD4- - Track RTU-abandon cleanup separately from normal DREQ/REJ cle=
anup so
+AD4- a
+AD4- +AD4-   late or duplicate RTU does not cancel a teardown timer.
+AD4- +AD4- - Hold id+AF8-map+AF8-lock while looking up id+AF8-map entries,=
 canceling or updating
+AD4- +AD4-   delayed work, and copying CM IDs needed by the handlers.
+AD4- +AD4- - Make RTU lose the race when the timeout callback has already =
started.
+AD4- +AD4-
+AD4- +AD4-  drivers/infiniband/hw/mlx4/cm.c +AHw- 98
+AD4- +AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----=
------
+AD4- +AD4-  1 file changed, 75 insertions(+-), 23 deletions(-)
+AD4-
+AD4- I wanted to apply this patch, but it has merge conflicts. Please reba=
se it onto
+AD4- the latest rdma-next.
+AD4-
+AD4- As you are probably the only person using this device in that mode, I=
 will take
+AD4- it as-is after the rebase. Strictly speaking, however, the lock aroun=
d
+AD4- id+AF8-map+AF8-get() does not make much sense. There is no reference =
counting on
+AD4- the returned ID, so it can disappear immediately after the lock is re=
leased.
+AD4-
+AD4- Thanks.
+AD4-
+AD4- +AD4-
+AD4- +AD4- diff --git a/drivers/infiniband/hw/mlx4/cm.c
+AD4- +AD4- b/drivers/infiniband/hw/mlx4/cm.c index 63a868a..f7905df 100644
+AD4- +AD4- --- a/drivers/infiniband/hw/mlx4/cm.c
+AD4- +AD4- +-+-+- b/drivers/infiniband/hw/mlx4/cm.c
+AD4- +AD4- +AEAAQA- -40,6 +-40,7 +AEAAQA-
+AD4- +AD4-  +ACM-include +ACI-mlx4+AF8-ib.h+ACI-
+AD4- +AD4-
+AD4- +AD4-  +ACM-define CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT  (30 +ACo- HZ=
)
+AD4- +AD4- +-+ACM-define CM+AF8-RTU+AF8-TIMEOUT               (60 +ACo- HZ=
)
+AD4- +AD4-
+AD4- +AD4-  struct id+AF8-map+AF8-entry +AHs-
+AD4- +AD4-     struct rb+AF8-node node+ADs-
+AD4- +AD4- +AEAAQA- -48,6 +-49,7 +AEAAQA- struct id+AF8-map+AF8-entry +AHs=
-
+AD4- +AD4-     u32 pv+AF8-cm+AF8-id+ADs-
+AD4- +AD4-     int slave+AF8-id+ADs-
+AD4- +AD4-     int scheduled+AF8-delete+ADs-
+AD4- +AD4- +-   bool rtu+AF8-timeout+ADs-
+AD4- +AD4-     struct mlx4+AF8-ib+AF8-dev +ACo-dev+ADs-
+AD4- +AD4-
+AD4- +AD4-     struct list+AF8-head list+ADs-
+AD4- +AD4- +AEAAQA- -184,6 +-186,10 +AEAAQA- static void id+AF8-map+AF8-en=
t+AF8-timeout(struct
+AD4- work+AF8-struct +ACo-work)
+AD4- +AD4-     struct rb+AF8-root +ACo-sl+AF8-id+AF8-map +AD0- +ACY-sriov-=
+AD4-sl+AF8-id+AF8-map+ADs-
+AD4- +AD4-
+AD4- +AD4-     spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +AD4- +-   if (+ACE-ent-+AD4-scheduled+AF8-delete) +AHs-
+AD4- +AD4- +-           spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-loc=
k)+ADs-
+AD4- +AD4- +-           return+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4-     if (+ACE-xa+AF8-erase(+ACY-sriov-+AD4-pv+AF8-id+AF8-table, =
ent-+AD4-pv+AF8-cm+AF8-id))
+AD4- +AD4-             goto out+ADs-
+AD4- +AD4-     found+AF8-ent +AD0- id+AF8-map+AF8-find+AF8-by+AF8-sl+AF8-i=
d(+ACY-dev-+AD4-ib+AF8-dev, ent-+AD4-slave+AF8-id,
+AD4- +AD4- ent-+AD4-sl+AF8-cm+AF8-id)+ADs- +AEAAQA- -228,8 +-234,12 +AEAAQ=
A- static void sl+AF8-id+AF8-map+AF8-add(struct
+AD4- ib+AF8-device +ACo-ibdev, struct id+AF8-map+AF8-entry +ACo-new)
+AD4- +AD4-     rb+AF8-insert+AF8-color(+ACY-new-+AD4-node, sl+AF8-id+AF8-m=
ap)+ADs-  +AH0-
+AD4- +AD4-
+AD4- +AD4- +-static void schedule+AF8-delayed(struct ib+AF8-device +ACo-ib=
dev, struct id+AF8-map+AF8-entry
+AD4- +ACo-id,
+AD4- +AD4- +-                        unsigned long timeout, bool rtu+AF8-t=
imeout)+ADs-
+AD4- +AD4- +-
+AD4- +AD4-  static struct id+AF8-map+AF8-entry +ACo-
+AD4- +AD4- -id+AF8-map+AF8-alloc(struct ib+AF8-device +ACo-ibdev, int slav=
e+AF8-id, u32 sl+AF8-cm+AF8-id)
+AD4- +AD4- +-id+AF8-map+AF8-alloc(struct ib+AF8-device +ACo-ibdev, int sla=
ve+AF8-id, u32 sl+AF8-cm+AF8-id,
+AD4- +AD4- +-        u32 +ACo-pv+AF8-cm+AF8-id)
+AD4- +AD4-  +AHs-
+AD4- +AD4-     int ret+ADs-
+AD4- +AD4-     struct id+AF8-map+AF8-entry +ACo-ent+ADs-
+AD4- +AD4- +AEAAQA- -242,6 +-252,7 +AEAAQA- id+AF8-map+AF8-alloc(struct ib=
+AF8-device +ACo-ibdev, int slave+AF8-id,
+AD4- u32 sl+AF8-cm+AF8-id)
+AD4- +AD4-     ent-+AD4-sl+AF8-cm+AF8-id +AD0- sl+AF8-cm+AF8-id+ADs-
+AD4- +AD4-     ent-+AD4-slave+AF8-id +AD0- slave+AF8-id+ADs-
+AD4- +AD4-     ent-+AD4-scheduled+AF8-delete +AD0- 0+ADs-
+AD4- +AD4- +-   ent-+AD4-rtu+AF8-timeout +AD0- false+ADs-
+AD4- +AD4-     ent-+AD4-dev +AD0- to+AF8-mdev(ibdev)+ADs-
+AD4- +AD4-     INIT+AF8-DELAYED+AF8-WORK(+ACY-ent-+AD4-timeout, id+AF8-map=
+AF8-ent+AF8-timeout)+ADs-
+AD4- +AD4-
+AD4- +AD4- +AEAAQA- -251,6 +-262,8 +AEAAQA- id+AF8-map+AF8-alloc(struct ib=
+AF8-device +ACo-ibdev, int slave+AF8-id,
+AD4- u32 sl+AF8-cm+AF8-id)
+AD4- +AD4-             spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+=
ADs-
+AD4- +AD4-             sl+AF8-id+AF8-map+AF8-add(ibdev, ent)+ADs-
+AD4- +AD4-             list+AF8-add+AF8-tail(+ACY-ent-+AD4-list, +ACY-srio=
v-+AD4-cm+AF8-list)+ADs-
+AD4- +AD4- +-           +ACo-pv+AF8-cm+AF8-id +AD0- ent-+AD4-pv+AF8-cm+AF8=
-id+ADs-
+AD4- +AD4- +-           schedule+AF8-delayed(ibdev, ent, CM+AF8-RTU+AF8-TI=
MEOUT, true)+ADs-
+AD4- +AD4-             spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock=
)+ADs-
+AD4- +AD4-             return ent+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4- +AEAAQA- -261,48 +-274,47 +AEAAQA- id+AF8-map+AF8-alloc(struct =
ib+AF8-device +ACo-ibdev, int
+AD4- slave+AF8-id, u32 sl+AF8-cm+AF8-id)
+AD4- +AD4-     return ERR+AF8-PTR(-ENOMEM)+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4-  static struct id+AF8-map+AF8-entry +ACo-
+AD4- +AD4-  id+AF8-map+AF8-get(struct ib+AF8-device +ACo-ibdev, int +ACo-p=
v+AF8-cm+AF8-id, int slave+AF8-id, int
+AD4- +AD4- sl+AF8-cm+AF8-id)  +AHs-
+AD4- +AD4-     struct id+AF8-map+AF8-entry +ACo-ent+ADs-
+AD4- +AD4-     struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-m=
dev(ibdev)-+AD4-sriov+ADs-
+AD4- +AD4-
+AD4- +AD4- -   spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +AD4- +-   lockdep+AF8-assert+AF8-held(+ACY-sriov-+AD4-id+AF8-map+AF8=
-lock)+ADs-
+AD4- +AD4-     if (+ACo-pv+AF8-cm+AF8-id +AD0APQ- -1) +AHs-
+AD4- +AD4-             ent +AD0- id+AF8-map+AF8-find+AF8-by+AF8-sl+AF8-id(=
ibdev, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4-             if (ent)
+AD4- +AD4-                     +ACo-pv+AF8-cm+AF8-id +AD0- (int) ent-+AD4-=
pv+AF8-cm+AF8-id+ADs-
+AD4- +AD4-     +AH0- else
+AD4- +AD4-             ent +AD0- xa+AF8-load(+ACY-sriov-+AD4-pv+AF8-id+AF8=
-table, +ACo-pv+AF8-cm+AF8-id)+ADs-
+AD4- +AD4- -   spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +AD4-
+AD4- +AD4-     return ent+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4- -static void schedule+AF8-delayed(struct ib+AF8-device +ACo-ibd=
ev, struct
+AD4- +AD4- id+AF8-map+AF8-entry +ACo-id)
+AD4- +AD4- +-static void schedule+AF8-delayed(struct ib+AF8-device +ACo-ib=
dev, struct id+AF8-map+AF8-entry
+AD4- +ACo-id,
+AD4- +AD4- +-                        unsigned long timeout, bool rtu+AF8-t=
imeout)
+AD4- +AD4-  +AHs-
+AD4- +AD4-     struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-m=
dev(ibdev)-+AD4-sriov+ADs-
+AD4- +AD4-     unsigned long flags+ADs-
+AD4- +AD4-
+AD4- +AD4- -   spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +AD4- +-   lockdep+AF8-assert+AF8-held(+ACY-sriov-+AD4-id+AF8-map+AF8=
-lock)+ADs-
+AD4- +AD4-     spin+AF8-lock+AF8-irqsave(+ACY-sriov-+AD4-going+AF8-down+AF=
8-lock, flags)+ADs-
+AD4- +AD4-     /+ACo-make sure that there is no schedule inside the schedu=
led work.+ACo-/
+AD4- +AD4- -   if (+ACE-sriov-+AD4-is+AF8-going+AF8-down +ACYAJg- +ACE-id-=
+AD4-scheduled+AF8-delete) +AHs-
+AD4- +AD4- +-   if (+ACE-sriov-+AD4-is+AF8-going+AF8-down +AHwAfA- id-+AD4=
-scheduled+AF8-delete) +AHs-
+AD4- +AD4-             id-+AD4-scheduled+AF8-delete +AD0- 1+ADs-
+AD4- +AD4- -           queue+AF8-delayed+AF8-work(cm+AF8-wq, +ACY-id-+AD4-=
timeout,
+AD4- CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT)+ADs-
+AD4- +AD4- -   +AH0- else if (id-+AD4-scheduled+AF8-delete) +AHs-
+AD4- +AD4- -           /+ACo- Adjust timeout if already scheduled +ACo-/
+AD4- +AD4- -           mod+AF8-delayed+AF8-work(cm+AF8-wq, +ACY-id-+AD4-ti=
meout,
+AD4- CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT)+ADs-
+AD4- +AD4- +-           id-+AD4-rtu+AF8-timeout +AD0- rtu+AF8-timeout+ADs-
+AD4- +AD4- +-           mod+AF8-delayed+AF8-work(cm+AF8-wq, +ACY-id-+AD4-t=
imeout, timeout)+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-     spin+AF8-unlock+AF8-irqrestore(+ACY-sriov-+AD4-going+AF8-do=
wn+AF8-lock, flags)+ADs-
+AD4- +AD4- -   spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4-  +ACM-define REJ+AF8-REASON(m) be16+AF8-to+AF8-cpu(((struct cm+=
AF8-generic+AF8-msg
+AD4- +AD4- +ACo-)(m))-+AD4-rej+AF8-reason)  int mlx4+AF8-ib+AF8-multiplex+=
AF8-cm+AF8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int slave+AF8-id,
+AD4- +AD4-             struct ib+AF8-mad +ACo-mad)
+AD4- +AD4-  +AHs-
+AD4- +AD4- +-   struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-=
mdev(ibdev)-+AD4-sriov+ADs-
+AD4- +AD4-     struct id+AF8-map+AF8-entry +ACo-id+ADs-
+AD4- +AD4- +-   u32 pv+AF8-cm+AF8-id+AF8-to+AF8-set +AD0- 0+ADs-
+AD4- +AD4-     u32 sl+AF8-cm+AF8-id+ADs-
+AD4- +AD4-     int pv+AF8-cm+AF8-id +AD0- -1+ADs-
+AD4- +AD4-
+AD4- +AD4- +AEAAQA- -312,10 +-323,15 +AEAAQA- int mlx4+AF8-ib+AF8-multiple=
x+AF8-cm+AF8-handler(struct
+AD4- ib+AF8-device +ACo-ibdev, int port, int slave+AF8-id
+AD4- +AD4-         mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-SIDR+A=
F8-REQ+AF8-ATTR+AF8-ID +AHwAfA-
+AD4- +AD4-         (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-REJ+A=
F8-ATTR+AF8-ID +ACYAJg- REJ+AF8-REASON(mad)
+AD4- +AD0APQ- IB+AF8-CM+AF8-REJ+AF8-TIMEOUT)) +AHs-
+AD4- +AD4-             sl+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+AF8-i=
d(mad)+ADs-
+AD4- +AD4- +-           spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)=
+ADs-
+AD4- +AD4-             id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-cm+A=
F8-id, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4- +-           if (id)
+AD4- +AD4- +-                   pv+AF8-cm+AF8-id+AF8-to+AF8-set +AD0- id-+=
AD4-pv+AF8-cm+AF8-id+ADs-
+AD4- +AD4- +-           spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-loc=
k)+ADs-
+AD4- +AD4-             if (id)
+AD4- +AD4-                     goto cont+ADs-
+AD4- +AD4- -           id +AD0- id+AF8-map+AF8-alloc(ibdev, slave+AF8-id, =
sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4- +-           id +AD0- id+AF8-map+AF8-alloc(ibdev, slave+AF8-id,=
 sl+AF8-cm+AF8-id,
+AD4- +AD4- +-                             +ACY-pv+AF8-cm+AF8-id+AF8-to+AF8=
-set)+ADs-
+AD4- +AD4-             if (IS+AF8-ERR(id)) +AHs-
+AD4- +AD4-                     mlx4+AF8-ib+AF8-warn(ibdev, +ACIAJQ-s: id+A=
Hs-slave: +ACU-d, sl+AF8-cm+AF8-id:
+AD4- 0x+ACU-x+AH0- Failed to id+AF8-map+AF8-alloc+AFw-n+ACI-,
+AD4- +AD4-                             +AF8AXw-func+AF8AXw-, slave+AF8-id,=
 sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4- +AEAAQA- -326,7 +-342,25 +AEAAQA- int mlx4+AF8-ib+AF8-multiplex=
+AF8-cm+AF8-handler(struct
+AD4- ib+AF8-device +ACo-ibdev, int port, int slave+AF8-id
+AD4- +AD4-             return 0+ADs-
+AD4- +AD4-     +AH0- else +AHs-
+AD4- +AD4-             sl+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+AF8-i=
d(mad)+ADs-
+AD4- +AD4- +-           spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)=
+ADs-
+AD4- +AD4-             id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-cm+A=
F8-id, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4- +-           if (id) +AHs-
+AD4- +AD4- +-                   if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0A=
PQ- CM+AF8-RTU+AF8-ATTR+AF8-ID +ACYAJg-
+AD4- +AD4- +-                       id-+AD4-rtu+AF8-timeout) +AHs-
+AD4- +AD4- +-                           id-+AD4-rtu+AF8-timeout +AD0- fals=
e+ADs-
+AD4- +AD4- +-                           if (cancel+AF8-delayed+AF8-work(+A=
CY-id-+AD4-timeout))
+AD4- +AD4- +-                                   id-+AD4-scheduled+AF8-dele=
te +AD0- 0+ADs-
+AD4- +AD4- +-                           else
+AD4- +AD4- +-                                   id +AD0- NULL+ADs-
+AD4- +AD4- +-                   +AH0-
+AD4- +AD4- +-                   if (id)
+AD4- +AD4- +-                           pv+AF8-cm+AF8-id+AF8-to+AF8-set +A=
D0- id-+AD4-pv+AF8-cm+AF8-id+ADs-
+AD4- +AD4- +-                   if (id +ACYAJg- mad-+AD4-mad+AF8-hdr.attr+=
AF8-id +AD0APQ-
+AD4- CM+AF8-DREQ+AF8-ATTR+AF8-ID)
+AD4- +AD4- +-                           schedule+AF8-delayed(ibdev, id,
+AD4- +AD4- +-
+AD4- CM+AF8-CLEANUP+AF8-CACHE+AF8-TIMEOUT,
+AD4- +AD4- +-                                            false)+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-           spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-loc=
k)+ADs-
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     if (+ACE-id) +AHs-
+AD4- +AD4- +AEAAQA- -336,10 +-370,7 +AEAAQA- int mlx4+AF8-ib+AF8-multiplex=
+AF8-cm+AF8-handler(struct
+AD4- ib+AF8-device +ACo-ibdev, int port, int slave+AF8-id
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-  cont:
+AD4- +AD4- -   set+AF8-local+AF8-comm+AF8-id(mad, id-+AD4-pv+AF8-cm+AF8-id=
)+ADs-
+AD4- +AD4- -
+AD4- +AD4- -   if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-DREQ+A=
F8-ATTR+AF8-ID)
+AD4- +AD4- -           schedule+AF8-delayed(ibdev, id)+ADs-
+AD4- +AD4- +-   set+AF8-local+AF8-comm+AF8-id(mad, pv+AF8-cm+AF8-id+AF8-to=
+AF8-set)+ADs-
+AD4- +AD4-     return 0+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4- +AEAAQA- -429,7 +-460,10 +AEAAQA- int mlx4+AF8-ib+AF8-demux+AF8=
-cm+AF8-handler(struct ib+AF8-device
+AD4- +ACo-ibdev, int port, int +ACo-slave,
+AD4- +AD4-     struct mlx4+AF8-ib+AF8-sriov +ACo-sriov +AD0- +ACY-to+AF8-m=
dev(ibdev)-+AD4-sriov+ADs-
+AD4- +AD4-     u32 rem+AF8-pv+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+A=
F8-id(mad)+ADs-
+AD4- +AD4-     u32 pv+AF8-cm+AF8-id+ADs-
+AD4- +AD4- +-   u32 sl+AF8-cm+AF8-id +AD0- 0+ADs-
+AD4- +AD4-     struct id+AF8-map+AF8-entry +ACo-id+ADs-
+AD4- +AD4- +-   int pv+AF8-cm+AF8-id+AF8-int+ADs-
+AD4- +AD4- +-   int slave+AF8-id +AD0- 0+ADs-
+AD4- +AD4-     int sts+ADs-
+AD4- +AD4-
+AD4- +AD4-     if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-REQ+AF=
8-ATTR+AF8-ID +AHwAfA- +AEAAQA- -457,7
+AD4- +-491,28 +AEAAQA-
+AD4- +AD4- int mlx4+AF8-ib+AF8-demux+AF8-cm+AF8-handler(struct ib+AF8-devi=
ce +ACo-ibdev, int port, int +ACo-slave,
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     pv+AF8-cm+AF8-id +AD0- get+AF8-remote+AF8-comm+AF8-id(mad)+=
ADs-
+AD4- +AD4- -   id +AD0- id+AF8-map+AF8-get(ibdev, (int +ACo-)+ACY-pv+AF8-c=
m+AF8-id, -1, -1)+ADs-
+AD4- +AD4- +-   pv+AF8-cm+AF8-id+AF8-int +AD0- pv+AF8-cm+AF8-id+ADs-
+AD4- +AD4- +-   spin+AF8-lock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +AD4- +-   id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-cm+AF8-id+A=
F8-int, -1, -1)+ADs-
+AD4- +AD4- +-   if (id) +AHs-
+AD4- +AD4- +-           if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+A=
F8-RTU+AF8-ATTR+AF8-ID +ACYAJg-
+AD4- +AD4- +-               id-+AD4-rtu+AF8-timeout) +AHs-
+AD4- +AD4- +-                   id-+AD4-rtu+AF8-timeout +AD0- false+ADs-
+AD4- +AD4- +-                   if (cancel+AF8-delayed+AF8-work(+ACY-id-+A=
D4-timeout))
+AD4- +AD4- +-                           id-+AD4-scheduled+AF8-delete +AD0-=
 0+ADs-
+AD4- +AD4- +-                   else
+AD4- +AD4- +-                           id +AD0- NULL+ADs-
+AD4- +AD4- +-           +AH0-
+AD4- +AD4- +-           if (id +ACYAJg- slave)
+AD4- +AD4- +-                   slave+AF8-id +AD0- id-+AD4-slave+AF8-id+AD=
s-
+AD4- +AD4- +-           if (id)
+AD4- +AD4- +-                   sl+AF8-cm+AF8-id +AD0- id-+AD4-sl+AF8-cm+A=
F8-id+ADs-
+AD4- +AD4- +-           if (id +ACYAJg- (mad-+AD4-mad+AF8-hdr.attr+AF8-id =
+AD0APQ- CM+AF8-DREQ+AF8-ATTR+AF8-ID +AHwAfA-
+AD4- +AD4- +-                      mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0AP=
Q- CM+AF8-REJ+AF8-ATTR+AF8-ID))
+AD4- +AD4- +-                   schedule+AF8-delayed(ibdev, id,
+AD4- +AD4- +-                                    CM+AF8-CLEANUP+AF8-CACHE+=
AF8-TIMEOUT,
+AD4- false)+ADs-
+AD4- +AD4- +-   +AH0-
+AD4- +AD4- +-   spin+AF8-unlock(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4- +AD4-
+AD4- +AD4-     if (+ACE-id) +AHs-
+AD4- +AD4-             if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF=
8-REJ+AF8-ATTR+AF8-ID +ACYAJg- +AEAAQA- -
+AD4- 472,12 +-527,8 +AEAAQA-
+AD4- +AD4- int mlx4+AF8-ib+AF8-demux+AF8-cm+AF8-handler(struct ib+AF8-devi=
ce +ACo-ibdev, int port, int +ACo-slave,
+AD4- +AD4-     +AH0-
+AD4- +AD4-
+AD4- +AD4-     if (slave)
+AD4- +AD4- -           +ACo-slave +AD0- id-+AD4-slave+AF8-id+ADs-
+AD4- +AD4- -   set+AF8-remote+AF8-comm+AF8-id(mad, id-+AD4-sl+AF8-cm+AF8-i=
d)+ADs-
+AD4- +AD4- -
+AD4- +AD4- -   if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-DREQ+A=
F8-ATTR+AF8-ID +AHwAfA-
+AD4- +AD4- -       mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-REJ+AF=
8-ATTR+AF8-ID)
+AD4- +AD4- -           schedule+AF8-delayed(ibdev, id)+ADs-
+AD4- +AD4- +-           +ACo-slave +AD0- slave+AF8-id+ADs-
+AD4- +AD4- +-   set+AF8-remote+AF8-comm+AF8-id(mad, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4-
+AD4- +AD4-     return 0+ADs-
+AD4- +AD4-  +AH0-

