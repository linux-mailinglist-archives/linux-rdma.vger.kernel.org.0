Return-Path: <linux-rdma+bounces-22241-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3oEONjs2MGoqQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22241-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:28:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BFA688DD7
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:28:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=ba+qfyeU;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=pLyZvghL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22241-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22241-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 205F93147537
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6A41325C;
	Mon, 15 Jun 2026 17:22:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A0413221;
	Mon, 15 Jun 2026 17:22:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544125; cv=fail; b=YnSAEms6igHO9TsyH2yTj9ym/y1qtdY9gSlsujmvKIM21TJ5l6tqRXcO6DFvFLd1LG4Fp/GJsx1qqHzyFvQRva/ELSi4xsLfUYRkbdUAgE3nXAed1VXoZAyv1XfSwmHeoWpQfLtsi0Q9d6Gn/J7mryUzH4/lqBPObaeyLJrrW3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544125; c=relaxed/simple;
	bh=KlWmaGpuAn+4A6/10dWEALCwQwSKauGmwxRWqExXQL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OATee4ARB98lIeWUtxPEeePdLqq/x7o5KCElGn14600ejZ8QSszQgWARthrTWH6JpEJJEo8tDgQd0Nfzh90ybKLdG19u3Dh20lel/CLBLDqR+BL0giT5vBjH4iBafWGCmOdXYwnEmVjahH0hQPo+Eq820Qao1TrtJYsXnfG8K1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ba+qfyeU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pLyZvghL; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCKSBN1392641;
	Mon, 15 Jun 2026 17:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KlWmaGpuAn+4A6/10dWEALCwQwSKauGmwxRWqExXQL4=; b=
	ba+qfyeUdgSyABodNmQ6uI2rfha0VNO5wSjfryVXZmXN/OPnrf8A9URv2l7wNRpK
	Yqv4CXW3KWPqkCaFMbdE411KvclOVytV6EiMsCM7/jryBoIPWJxWDdwzeSq5g5mz
	nuMcZFgFLMvuTffkhpvL9k4XQxVdLBHmquyxLMQ6/bUkEdkH2hCUQnCpaGgdRzbo
	A5gwFMhwDQj6Wk0A09BQaVXB7N7/V2iv6ibGaOYKCfnS6kGHuA75M2lcWqQBXbXE
	tB3/JNp5t5+TgOwF+ozdoqrzUwyOEKvNiQUnCUmxGdjZ2HL5DDw0L6U0oPEvKudf
	T9ulLKVdwvOVUo1Eo6zYoQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es182ayvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:21:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65FHI9Bl006986;
	Mon, 15 Jun 2026 17:21:57 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4etg725pvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:21:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyQr7RtEFP1kwSzb/eECLhan2i28+eHuXj3mco4XbWC5ogz27+Vl7OzwTSkk1IwJMvgtDhnSa4/xxwvFcS3uEbgGP7VP9ZYFV6oPWtHQYMPOEVyUoeNzaaKF7t5ZG9BkQmInOyjEpqaf0ry9dm8XkwKIBGZIiJIQVn4nWamh2z5bYXlBePIYT0FgThxLYCVVs/pwwBp38WdgYZji+9Dc0McZpI24DBmnEafJK2B3nQT0qoWEehlkwWlzFDvKexTXOl15HlQ1EVfDurN0qERKG4oEJ9Roho6E/5R/7RCjO201gvlofc67ZnD16CKNXTRONSHDh3mFKahrk6b636clDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlWmaGpuAn+4A6/10dWEALCwQwSKauGmwxRWqExXQL4=;
 b=RLkY6Fq6y0u94G1VeQ/6t57rGjhC26+hjhECC+yid2ZnI7GOxYTqnPqc8C2lbStYtzeexZSfcCI5OvzmfJOGNmqnTTrJESipDKRDAxiQdJvpKlUnORBDYrWFpLzwA5buH9qWVylx/lXCsaGPmC6b/IDLhwB7+jl2o3jKVLBPCg/NpbrfBG7zL7AcSiDJIvISGLARTs/siT47zc3COUWB382zJPD4wyrbWc7ZaAO9IuyRZhh+HptlLu/9q5M0ONJ1CL5g/kCW1HYIEwMcYquGp8lyr0afqb8bhyjynSZsTDv4ci16qZlXI6ga2xjoYBQITpSNCTsofAP9KVTn2VcCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlWmaGpuAn+4A6/10dWEALCwQwSKauGmwxRWqExXQL4=;
 b=pLyZvghLHj6FYizsMeBZaqQqtWbWgfiJmO9FldV50UP/S5cfyQT6CBbl3YEfg/CgmVeqj5UC75AnHzopWgUJvj0uYNV3VbwGxHMnGGaVc7is6p+zmtiVaOXFU/0sZIVLSgIIgYS5+FT9ZEPCmmciLPwrQQLwedEmmjjeS9W7Tqg=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by DS5PR10MB997706.namprd10.prod.outlook.com (2603:10b6:8:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:21:54 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:21:54 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Praveen Kannoju <praveen.kannoju@oracle.com>,
        "yishaih@nvidia.com"
	<yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Manjunath Patil <manjunath.b.patil@oracle.com>,
        Anand Khoje
	<anand.a.khoje@oracle.com>
Subject: RE: [PATCH v2] IB/mlx4: delete allocated id_map_entry while sending
 REJ
Thread-Topic: [PATCH v2] IB/mlx4: delete allocated id_map_entry while sending
 REJ
Thread-Index: AQHc/Or+sVRbKCED7U6IIX175NZmL7Y/3G+g
Date: Mon, 15 Jun 2026 17:21:54 +0000
Message-ID:
 <BL0PR10MB2820A3798CC50DD9E0B85FCA8CE62@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260615171759.557425-1-praveen.kannoju@oracle.com>
In-Reply-To: <20260615171759.557425-1-praveen.kannoju@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-06-15T17:19:34.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|DS5PR10MB997706:EE_
x-ms-office365-filtering-correlation-id: 0eb71d7f-c071-49ae-a6b3-08decb029896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|22082099003|18002099003|3023799007|56012099006;
x-microsoft-antispam-message-info:
 W3/cVtWwOtvlaBSmw22WXAT+RA0PxiD2HYjnubCGVb4l1rFMWp/aIF7q3Rr4r63EoUyFBAuADOcEXY++7XmoxcfJV7Tg24RE0EGxzZ4zlMCNz4sLAOS4kqOF1AyZhu8ZfHFjbt2dg+ZDkZ7t1wm997tTYWCwwKZTt8COpCDmRK6RUQEDS5fYFS344NRgAxbrFnPuSPaD1L21u13CGahqCGPRiaQUZT5Ez+HsgkOgkbl8nwCq9Fn2VhasMxKcValyJaM/iYyEf2KkgMoQOp/of7gZiMb6a/4d480W/BnsWFnrdBzd9C7UNNreNlHirpA7qJHhHF8lPce9Xly/jG3xAuaXYx53OXUXvk1VXkcYu+g15ItFrSAko7CwhwqX1QT7kwKufOS2z9UD6jXW2KMKnmgpeoUJZjKOGjeQMP22bdxrfArJIxP0v8ighdRvHK84yKBnMDL0mmGbKJeGFM6a6d/KFL8D4S01vRkCW3eArdOu24OECrfSl/xb9iRN2GS6V68C2NzdUtfb+1c77+q3gTv4DV79z15aRPzqv+ghDCdfFLZfakBo9M2Wh1LDfitMK9sZVKcGhN9NIa1NXObSj7H74TmVB0xPxLY6PUg2OE/QPSOUjnCsTc67h4c2ReYjcW14QRBNSXEobLpoCRBqZN6tdrD0ZAS/agICfET0AZlBs8HGFgkh9xvsyEPAWXH1RM6VrfI/c7ocKCoyP8KnhucSpvUajAyR3vVBCOujDcYPUzc8uWPY4znIhtJ/gG72
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eE1oc1dBQWlMbVBKdkgzUnlCMFVkbU5iSWVrUWlrcTdpNVVKaGI2OTJNQUdF?=
 =?utf-8?B?Nm40RHZ1NUYreVNRc2dZVjZ1cVN4U2M3Vmd1NGV3cEExOHlkWnZHVmtVOHlC?=
 =?utf-8?B?KzZicTJQdHlESGM4ODMzVldCczBjQXE5Z0pMdUFDWmFPZUpuc0lTZFE4TFRo?=
 =?utf-8?B?ZDJWVWRHVWVYdDdaVEpaUWJ1Yk40MzhLaU1qT3o4TkUwMVZsZVJSVW83R25x?=
 =?utf-8?B?clRoTjUyQU8rYVZWUjRrK3pwd3R6Sm9oZ3p6UU44bXBEZGY3MXVUUlVUTTBM?=
 =?utf-8?B?ZEh5THlhazZDMURyUjFtU2pCYkhSUUFYZkZOcGZVTTVIKzJiaUlPL0UxeGE2?=
 =?utf-8?B?MkRxK2pLTVhpbkJ6eVB1S29kZUFOTExBa2xVOW5ySml3NzFWTUpIUlNsMGhn?=
 =?utf-8?B?cjM1OFRDN3REb0RJc3QwR29Jaks1YlVGL3B5dTBreVdQbUVuTnVzNDl3YnBG?=
 =?utf-8?B?SFBNdklsL2dJNTZQZnFubWNLNlFxRW5xNjVtMFQ1K01hVEwzRUhmS3laQm9N?=
 =?utf-8?B?UEliWmhheDFnMXh2Ri9jeUVWb0ZJa2t1Zi9oRW50Zlp0M2xobHpjaEtHT1l2?=
 =?utf-8?B?VEprUTU0ZmNlUzMrSDkvL1ZoMitYL1ZhS1dSVjlvTHRGdUJ6aGgxK3lHNUxk?=
 =?utf-8?B?SFBSbzlwUlBvUWUwbGRkMStVM0xwU3doa3ZOVkpxNG0yMEEvZnhOVVRDREo4?=
 =?utf-8?B?Q0gxdDZHcXg5Yk9KaVI5MCt6QUQxTUFRWC91K3NKMlZrOVpUZVR3UXVidTZE?=
 =?utf-8?B?VmNNNUtwV0xRZWdNZlkxTmhCN05LQ0pCZ3pURi9BdmFURnlMWVUweXhqT2ND?=
 =?utf-8?B?dnM0SVB4WUFmUk9CTE03RWlYMWFiKy9NbWFML2txSXk3bHpRYzNyM0JXMGtF?=
 =?utf-8?B?b1AyYUx2OU1jQWtiL2F0Qm1ra0RKN0VMOUx5VTdIeFRwaFNGZDlaeFRiL3dZ?=
 =?utf-8?B?ZVk5Z2FheHVEQXd6VEFUVGlBcTJ4YU9KckdXMmxqR1RGUTVaNnZJTkgzMkdG?=
 =?utf-8?B?aTVSWEpYdmtsVEpPZnZMald2KytYRW50ZWsvTWdGUDBxOUozb2Vja0MzMXp4?=
 =?utf-8?B?SWNvbXluZkw1VFpwdndyM1Exb3VvL2Nsb1J3Nm1Bd1JONXR5SFNTbkFrWUNX?=
 =?utf-8?B?OFdBdVdOSHE5Nnk2MC9DbTJBUmJKcVlCTzZIZTJPRXpkZi9DVFpXOTZKMFFW?=
 =?utf-8?B?aTREY0F2bmhNSTFsdlNaMVR2YzZGVXVtbVpzaE1ZU09TUTBiOE1nUGpEbTVS?=
 =?utf-8?B?bkhwNk1lU3FoeHFZckxSVDczZzc5Zm9jK3gxNldRa3QxbThsY3IzK1h2RFZ2?=
 =?utf-8?B?dnpCdUVnbkhQVFIxaVAzNjhKZ2lqOG1SK3NyR1dYbVJUeEsrSHBiTkpCY1dy?=
 =?utf-8?B?WUppUWc3KzJKaFpBYUwwTnJXSDFaeStFR0YwaWNKNjNrTXhYR1JQSzNEM3Fk?=
 =?utf-8?B?Q3ZnM0R0QUt0T0I2ZXpNdzBEbm40ak1vSXA4Z1lFWCsrK1daM2tnanc2KzN1?=
 =?utf-8?B?YU12RGd6YzY5blJyUWI1TE9iUFJ1bHlwTEhHM1p5RFl2WTBESEZkNG5Ub0wx?=
 =?utf-8?B?RGVjcHcrdHhlTk1vZ2ZXeldrYVZ6NkJIdU8rcXN6bUFMcml1ck5UTVB2RUN0?=
 =?utf-8?B?V2V3UDgwVVhEa0pzVlllSlhqaURjM1JXVGhTYUdEL1EveE03OEcvVmFId1gw?=
 =?utf-8?B?THl2YkluUHJPUjROUFJGbk54V29xZjNSbEtia2VKeFpLRDFiZ1FDSDFEWUk3?=
 =?utf-8?B?ZEQ1YVQzYUdET1N6T3NZSVpkenY1OEtYMTJvUTNkZFpxQnBDOHZuTEYwaHZZ?=
 =?utf-8?B?Y01tTXZSUThRakJPWmtRSERMMFZGU25Xa0NXSVdjRE5hdGF0VWhhRmFTZ2xB?=
 =?utf-8?B?S0FxcE1kQ3dDbHJzaGd2NkhKS0Q1U1NBVzdaSnc1clpidnhSTHExTHkxTkV3?=
 =?utf-8?B?TFNlSTlTUUVhajJjenVWTVFUaURnQmZPNWpjV2tMdzI0V3F4Zm90ZkhaRm04?=
 =?utf-8?B?SXNvMWRMb0pvdVY5UjQ4allPZ3F6QUtmYnRpL3BoVUxIWURoZW1MU3hyUTBE?=
 =?utf-8?B?NWhjYXc0L0MzVE5ld3BaeEtCT05xRGJ3THlCMkhnVDFYSW8zNFQwVjB2bEZL?=
 =?utf-8?B?T2YrdzN6OGFaaTE5YnpUNHhXM2Z4UTlydWxvMlhJM2hFSkFOVHFISlVCRTVM?=
 =?utf-8?B?WDFpSDBlOHNGdUhXRnRDMXFTQ2UrdjZZdG04bk5vMG04V0xvWjA2Y2xNM0lN?=
 =?utf-8?B?SEQ5VW5YQVJQK2FvY1p6d2d1dkRMYVE3QXBQS3p2amxzRmVwLzlkaUoxajN5?=
 =?utf-8?B?V2NEa1BYZmpJZEQ2bEM0YW1sTzRKQWRwTThUS0hWaXh3OEFCRXFZZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fwO3+Or7U/hlBow0iiMFVo1/q/8IY7zjekSVR4BnsBMO1KeiUrXXGuH370VRx+LmBbNnUJipishpsDF7kFtJj8R9kE4qGwvo/yPeCujnoBOk2kipLpF7NbqRGdPqBcltknyEsnwCnlHWeniZE70hzWChPK8pUBo2AaarPDwRnXo6Iip3ZcfOa1Zc4PlKHdd2C0DjfVQljcK2ptYcsFPo4UWRtQHY4FIFkiKOhKTqXOTe5DpIumChGSsrFiw3pGoekuNBysHfAVsVKU6CaaXoa7LXCarAr8tFYup+TiGCnZvzHSsiI8IGe4AUlDxwNpwxklsZlrd0dquKZpA9KFuEUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xcl2IovKU+hftoFhKCWRtochOsZeSu0D6hrmfGW5GNRErY4mNH/+Nie2JFKo8rcS2VCFpotgBxnekrjJJQfr8TeonABLf+qwnbMFHHZAMblHztCcS9zCiKSyh/lqISj3cu0P6ShZtOwWEg/BbpWQWl96rJKRUuR5Ac9E0nFA2porNhphjlCGskMDS18BcgPIg6OuPTOKKBGgE4iEcD90OGCN6Hz0F078Be9kSPrWQlPPVRtoK3BeIWHeMODnCY9iiKOd0rmRhgw4DVZw1AlFCqFqHrbM8GfPnLqI2koaRiWBi0xc63RtHxl+3iiUO1AwxS+6KNvWlQV4hG7nvHRxrYsxpR+32VqrIDtJ54AzCr7g0josd8gpm0aBWeiRBa3XX3AltZ70NyyLcjnfxU9iGnY5Qm3OogmnG9xosWOna6C827lrHpobjMcBRAFj0Jm+1oKo0d6hPp1+3uMSsTBO8xl8z30T75QebUD2RIhWRLIB7GFK9chY51eZ6nFyndD1JDb7gvmTDSGz07cYybT69QAn3hwsCpAhqo6fbSNFw3o6DnJ+JskvWbDEzWWDk1fP0KF82DSeusKTPNcyj/o3K5sZ5P2aRFw0xVd5l+7W+WE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb71d7f-c071-49ae-a6b3-08decb029896
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 17:21:54.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPHKZRvGCBeWypBotl0ESDXU828YB3J9ro5HrFlm1NTCO3/nXgNuLpUASLnP6UU0wdjtvCwUDn3SQaBNLxOhEKLZv4WqF0XgZY4cYeZkuhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606150183
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4MyBTYWx0ZWRfX2wYTUCMZGXot
 0OB/O+dgeJz2crcOnWefjkux2t3JGX9SUFEq3FM/jlnzYxMkqkdZYCmI75HLlfD8UCIb7cC0AHX
 ib/sew1TFwZe9Ol8UlfUYfBd/UNFtBGugr12BNsvmwlg65YuvgV8
X-Proofpoint-GUID: l3nZQj7_gZISTe1rg7pIXuUWPW52XOFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4MyBTYWx0ZWRfX/rgIpMqgn7Lo
 Xed5ldur2day2YvTcio0L7scGegz04qXiZKt/xdjbsCJCB6MNMwwnvotetmvzCQAr2/yK9ybMUE
 w7i2yZYRZu4lkIPkHlKwA3VNP4wNY9bRcRO5aK2+mmPKKZq6GNnfXzuwwzkoUaAfY9hduUNQhIt
 6cjV/Bs0QZVw7GV1/PT27I7uTwYSEaNdlzivrzn0j4bGvPz9xnodniWCsjW31UTGua4Tpqr5SUg
 YNOrfaBStMeZH2IgfFVVMZQxYOdBuRGm48MAJaEA1NLexLE99u2ZFe7SELFwCC/iVTwHJjPwukE
 enEOsrzlBZ1q3jza7vMuWej0SssmCm8wle6LNCti4SNM8O6ihjcAc1FERiMjMCYSkbagL26YXpr
 V9kwEZ2A1rKk/4MoTA+FMJv+FdbW9F2iFAgbKuVwpegj+eHSHcF4/K7gLc2Vqo0KTPU2sUGQGyv
 uer1G8tM/29EhyxUujg==
X-Proofpoint-ORIG-GUID: l3nZQj7_gZISTe1rg7pIXuUWPW52XOFP
X-Authority-Analysis: v=2.4 cv=Rr/16imK c=1 sm=1 tr=0 ts=6a3034b6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=VwQbUJbxAAAA:8
 a=sLnoallk-Bl9_LEm9_QA:9 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.06 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22241-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:praveen.kannoju@oracle.com,m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:anand.a.khoje@oracle.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:email,oracle.com:from_mime,ziepe.ca:email,BL0PR10MB2820.namprd10.prod.outlook.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36BFA688DD7

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNCkhpIExlb24sDQoNCllvdSBoYWQgZWFybGllciBhc2tlZCBmb3IgdGhlIGttZW1s
ZWFrIG91dHB1dCBmb3IgdjEgb2YgdGhpcyBwYXRjaC4NCg0KVGhpcyBpcyBub3QgZXhwZWN0ZWQg
dG8gc2hvdyB1cCBpbiBrbWVtbGVhayBvdXRwdXQuIFRoZSBsZWFrZWQgYGlkX21hcF9lbnRyeWAg
aXMgbm90IG9ycGhhbmVkIGZyb20gdGhlIGtlcm5lbCBvYmplY3QgZ3JhcGg6IGFmdGVyIGFsbG9j
YXRpb24sIGl0IHJlbWFpbnMgbGlua2VkIGZyb20gYHNyaW92LT5jbV9saXN0YCBhbmQgaXMgYWxz
byBpbmRleGVkIGJ5IHRoZSBkcml2ZXLigJlzIGlkLW1hcCBkYXRhIHN0cnVjdHVyZXMuIEttZW1s
ZWFrIHJlcG9ydHMgYWxsb2NhdGlvbnMgdGhhdCBiZWNvbWUgdW5yZWFjaGFibGUgZnJvbSBzY2Fu
bmVkIHJvb3RzLiBBcyBsb25nIGFzIHRoZSBkcml2ZXIgcmV0YWlucyBhIHJlZmVyZW5jZSB0byBh
biBgaWRfbWFwX2VudHJ5YCBpbiB0aG9zZSBsaXZlIGNvbnRhaW5lcnMsIGttZW1sZWFrIHdpbGwg
dHJlYXQgdGhlIG9iamVjdCBhcyByZWFjaGFibGUsIGV2ZW4gaWYgdGhlIENNIHByb3RvY29sIGxp
ZmV0aW1lIGluZGljYXRlcyB0aGF0IHRoZSBlbnRyeSBzaG91bGQgaGF2ZSBiZWVuIGRlbGV0ZWQg
d2hlbiBSRUogd2FzIHNlbnQuDQoNCi0NClByYXZlZW4uDQoNCg0KDQpDb25maWRlbnRpYWwgLSBP
cmFjbGUgUmVzdHJpY3RlZCBcSW5jbHVkaW5nIEV4dGVybmFsIFJlY2lwaWVudHMNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHJhdmVlbiBLdW1hciBLYW5ub2p1IDxwcmF2
ZWVuLmthbm5vanVAb3JhY2xlLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDE1LCAyMDI2IDEw
OjQ4IFBNDQo+IFRvOiB5aXNoYWloQG52aWRpYS5jb207IGpnZ0B6aWVwZS5jYTsgbGVvbkBrZXJu
ZWwub3JnOyBsaW51eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IE1hbmp1bmF0aCBQYXRpbCA8bWFuanVuYXRoLmIucGF0aWxAb3Jh
Y2xlLmNvbT47IEFuYW5kIEtob2plDQo+IDxhbmFuZC5hLmtob2plQG9yYWNsZS5jb20+OyBQcmF2
ZWVuIEthbm5vanUNCj4gPHByYXZlZW4ua2Fubm9qdUBvcmFjbGUuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjJdIElCL21seDQ6IGRlbGV0ZSBhbGxvY2F0ZWQgaWRfbWFwX2VudHJ5IHdoaWxlIHNl
bmRpbmcgUkVKDQo+DQo+IFRoZSBtbHg0IENNIHBhcmF2aXJ0dWFsaXphdGlvbiBsYXllciByZXdy
aXRlcyBhIFZGJ3MgbG9jYWwgY29tbXVuaWNhdGlvbiBJRCB0bw0KPiBhIFBGLXZpc2libGUgSUQg
d2hlbiBDTSBNQURzIGFyZSBzZW50IGZyb20gdGhlIFZGLg0KPiBGb3IgbWVzc2FnZXMgdGhhdCBz
dGFydCBvciBhZHZhbmNlIGEgY29ubmVjdGlvbiBmcm9tIHRoZSBWRiBzaWRlLCBzdWNoIGFzDQo+
IFJFUSwgUkVQLCBNUkEgYW5kIFNJRFJfUkVRLCBtbHg0X2liX211bHRpcGxleF9jbV9oYW5kbGVy
KCkgYWxsb2NhdGVzIGFuDQo+IGlkX21hcF9lbnRyeSB3aGVuIG5vIGV4aXN0aW5nIG1hcHBpbmcg
aXMgZm91bmQuDQo+DQo+IEEgUkVKIGlzIGRpZmZlcmVudCBiZWNhdXNlIGl0IGlzIGEgdGVybWlu
YWwgcmVzcG9uc2UgdG8gYW4gYWxyZWFkeSBrbm93bg0KPiBleGNoYW5nZS4gSXQgc2hvdWxkIGVp
dGhlciBmaW5kIGFuIGV4aXN0aW5nIGlkX21hcF9lbnRyeSwgcmV3cml0ZSB0aGUgbG9jYWwNCj4g
Y29tbXVuaWNhdGlvbiBJRCwgYW5kIHNjaGVkdWxlIHRoYXQgZW50cnkgZm9yIGRlbGV0aW9uLCBv
ciBpdCBzaG91bGQgcGFzcw0KPiB0aHJvdWdoIHVuY2hhbmdlZCB3aGVuIG5vIG1hcHBpbmcgZXhp
c3RzLg0KPg0KPiBTb21lIFJFSiBtZXNzYWdlcywgc3VjaCBhcyByZWplY3RzIGZvciBhbiBpbmJv
dW5kIFJFUSBiZWZvcmUgYW4gTVJBIG9yIFJFUA0KPiB3YXMgc2VudCwgZG8gbm90IGhhdmUgYW4g
aWRfbWFwX2VudHJ5IGJlY2F1c2UgdGhlaXIgbG9jYWxfY29tbV9pZCBpcyB6ZXJvLg0KPiBUaW1l
b3V0IFJFSiBtZXNzYWdlcyBhcmUgaGFuZGxlZCBpbiB0aGUgaW5pdGlhbCBsb29rdXAgYnJhbmNo
LCBidXQgYSBsb29rdXANCj4gbWlzcyB0aGVyZSBtdXN0IG5vdCBmYWxsIHRocm91Z2ggdG8gaWRf
bWFwX2FsbG9jKCk7IHN1Y2ggYSBtaXNzIG1lYW5zIHRoZXJlIGlzDQo+IG5vIGV4aXN0aW5nIG1h
cHBpbmcgdG8gdHJhbnNsYXRlIG9yIGRlbGV0ZSBmb3IgdGhlIFJFSi4NCj4NCj4gQ29tbWl0IDIy
N2EwZTE0MmUzNyAoIklCL21seDQ6IEFkZCBzdXBwb3J0IGZvciBSRUogZHVlIHRvIHRpbWVvdXQi
KQ0KPiBhZGRlZCB0aGUgdGltZW91dCBSRUogY2FzZSB0byB0aGUgaW5pdGlhbCBicmFuY2ggc28g
YW4gb3V0Z29pbmcgdGltZW91dCBSRUoNCj4gY291bGQgcmV1c2UgdGhlIGlkX21hcF9lbnRyeSB0
aGF0IHdhcyBjcmVhdGVkIHdoZW4gdGhlIFZGJ3MgUkVRIHdhcw0KPiBtdWx0aXBsZXhlZC4gUmV1
c2luZyB0aGF0IGVudHJ5IGlzIHRoZSB1c2VmdWwgcGFydDogaXQgcmV3cml0ZXMgdGhlIHRpbWVv
dXQgUkVKDQo+IGxvY2FsX2NvbW1faWQgdG8gdGhlIHNhbWUgUEYtdmlzaWJsZSBJRCB0aGF0IHdh
cyBzZW50IGluIHRoZSBSRVEuIElmIHRoZQ0KPiBsb29rdXAgbWlzc2VzLCBhbGxvY2F0aW5nIGEg
bmV3IGlkX21hcF9lbnRyeSBkb2VzIG5vdCBoZWxwIGJlY2F1c2UgdGhlIHBlZXINCj4gaGFzIG5l
dmVyIHNlZW4gdGhhdCBuZXcgUEYtdmlzaWJsZSBJRCwgYW5kIFJFSiBpcyBub3Qgc3RhcnRpbmcg
YSBuZXcgZXhjaGFuZ2UuDQo+DQo+IEtlZXAgdGltZW91dCBSRUogaGFuZGxpbmcgaW4gdGhlIGlu
aXRpYWwgbG9va3VwIGJyYW5jaCwgYnV0IHJldHVybiBiZWZvcmUNCj4gYWxsb2NhdGlvbiBpZiBu
byBtYXBwaW5nIGlzIGZvdW5kLiBIYW5kbGUgdGhlIG90aGVyIFJFSiBjYXNlcyB3aXRoIHRoZSBz
YW1lDQo+IGxvb2t1cC1vbmx5IGJlaGF2aW9yLiBXaGVuIGEgbWFwcGluZyBpcyBmb3VuZCwgdHJh
bnNsYXRlIHRoZSBsb2NhbA0KPiBjb21tdW5pY2F0aW9uIElEIGFuZCBzY2hlZHVsZSBkZWxheWVk
IGRlbGV0aW9uLCBhcyBpcyBhbHJlYWR5IGRvbmUgZm9yIERSRVENCj4gYW5kIGZvciByZWNlaXZl
ZCBSRUogaW4gdGhlIGRlbXV4IHBhdGguIFdoZW4gbm8gbWFwcGluZyBpcyBmb3VuZCwga2VlcCB0
aGUNCj4gZXhpc3RpbmcgcGFzcy10aHJvdWdoIGJlaGF2aW9yLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQcmF2ZWVuIEt1bWFyIEthbm5vanUgPHByYXZlZW4ua2Fubm9qdUBvcmFjbGUuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L2NtLmMgfCAxMyArKysrKysrKysrLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L2NtLmMNCj4gYi9kcml2
ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9jbS5jIGluZGV4IDYzYTg2OGEzODIyZi4uMjAyZmQ1MzY1
ZTM1DQo+IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9jbS5jDQo+
ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L2NtLmMNCj4gQEAgLTMxNSwxNCArMzE1
LDIwIEBAIGludCBtbHg0X2liX211bHRpcGxleF9jbV9oYW5kbGVyKHN0cnVjdCBpYl9kZXZpY2UN
Cj4gKmliZGV2LCBpbnQgcG9ydCwgaW50IHNsYXZlX2lkDQo+ICAgICAgICAgICAgICAgaWQgPSBp
ZF9tYXBfZ2V0KGliZGV2LCAmcHZfY21faWQsIHNsYXZlX2lkLCBzbF9jbV9pZCk7DQo+ICAgICAg
ICAgICAgICAgaWYgKGlkKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBjb250Ow0KPiAr
ICAgICAgICAgICAgIGlmIChtYWQtPm1hZF9oZHIuYXR0cl9pZCA9PSBDTV9SRUpfQVRUUl9JRCkN
Cj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgICAgICAgICAgIGlkID0g
aWRfbWFwX2FsbG9jKGliZGV2LCBzbGF2ZV9pZCwgc2xfY21faWQpOw0KPiAgICAgICAgICAgICAg
IGlmIChJU19FUlIoaWQpKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICBtbHg0X2liX3dhcm4o
aWJkZXYsICIlczogaWR7c2xhdmU6ICVkLCBzbF9jbV9pZDoNCj4gMHgleH0gRmFpbGVkIHRvIGlk
X21hcF9hbGxvY1xuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18s
IHNsYXZlX2lkLCBzbF9jbV9pZCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRS
X0VSUihpZCk7DQo+ICAgICAgICAgICAgICAgfQ0KPiAtICAgICB9IGVsc2UgaWYgKG1hZC0+bWFk
X2hkci5hdHRyX2lkID09IENNX1JFSl9BVFRSX0lEIHx8DQo+IC0gICAgICAgICAgICAgICAgbWFk
LT5tYWRfaGRyLmF0dHJfaWQgPT0gQ01fU0lEUl9SRVBfQVRUUl9JRCkgew0KPiArICAgICB9IGVs
c2UgaWYgKG1hZC0+bWFkX2hkci5hdHRyX2lkID09IENNX1JFSl9BVFRSX0lEKSB7DQo+ICsgICAg
ICAgICAgICAgc2xfY21faWQgPSBnZXRfbG9jYWxfY29tbV9pZChtYWQpOw0KPiArICAgICAgICAg
ICAgIGlkID0gaWRfbWFwX2dldChpYmRldiwgJnB2X2NtX2lkLCBzbGF2ZV9pZCwgc2xfY21faWQp
Ow0KPiArICAgICAgICAgICAgIGlmICghaWQpDQo+ICsgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gKyAgICAgfSBlbHNlIGlmIChtYWQtPm1hZF9oZHIuYXR0cl9pZCA9PSBDTV9TSURS
X1JFUF9BVFRSX0lEKSB7DQo+ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgIH0gZWxz
ZSB7DQo+ICAgICAgICAgICAgICAgc2xfY21faWQgPSBnZXRfbG9jYWxfY29tbV9pZChtYWQpOw0K
PiBAQCAtMzM4LDcgKzM0Miw4IEBAIGludCBtbHg0X2liX211bHRpcGxleF9jbV9oYW5kbGVyKHN0
cnVjdCBpYl9kZXZpY2UNCj4gKmliZGV2LCBpbnQgcG9ydCwgaW50IHNsYXZlX2lkDQo+ICBjb250
Og0KPiAgICAgICBzZXRfbG9jYWxfY29tbV9pZChtYWQsIGlkLT5wdl9jbV9pZCk7DQo+DQo+IC0g
ICAgIGlmIChtYWQtPm1hZF9oZHIuYXR0cl9pZCA9PSBDTV9EUkVRX0FUVFJfSUQpDQo+ICsgICAg
IGlmIChtYWQtPm1hZF9oZHIuYXR0cl9pZCA9PSBDTV9EUkVRX0FUVFJfSUQgfHwNCj4gKyAgICAg
ICAgIG1hZC0+bWFkX2hkci5hdHRyX2lkID09IENNX1JFSl9BVFRSX0lEKQ0KPiAgICAgICAgICAg
ICAgIHNjaGVkdWxlX2RlbGF5ZWQoaWJkZXYsIGlkKTsNCj4gICAgICAgcmV0dXJuIDA7DQo+ICB9
DQo+IC0tDQo+IDIuNDMuNw0K

