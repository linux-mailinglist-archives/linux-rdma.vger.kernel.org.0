Return-Path: <linux-rdma+bounces-23120-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3efVLD/KVGpuTgAAu9opvQ
	(envelope-from <linux-rdma+bounces-23120-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:21:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 094FA74A4BC
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:21:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=UjPKYaeB;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=bCMG8nti;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23120-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23120-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90A563023F8C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47538CFE4;
	Mon, 13 Jul 2026 11:18:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDA384CD6;
	Mon, 13 Jul 2026 11:18:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941501; cv=fail; b=G4ABFW3pWwYevf86+pT6FamLOrKVjSvRX/Xkin52/B8Qm8wWQj6R+z8EdwvtX4p90ZeU3wfIJeXK2BnukAQTjhBXo55qDX0Bi9p6TtAu11H1mpnM9AsiS3psYj9qWzIcW+6i4CUa+l58TZojE6BUqmfrsB0pjmLWF/PvM2S34WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941501; c=relaxed/simple;
	bh=ltTtNSmML9bJoGjjecbpgAHLJOtOkH5/vi6wECsIWD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JmP5pFUbp9/yb6bkpgZ0T0Q2ErTTHZwoBsvwkmI+ilctlbPvwhZZfksVMG0JxNYJl1GgYOIUnoivS0+jO+WZd/yOTjXSu2o13N//d6Th8Iu+hFWzBE7ovdZ8OQrbf+D/hDl2/q8n6Jc3wC7dFW2vxfMMGysaImUCYjrBZCUBevg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UjPKYaeB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bCMG8nti; arc=fail smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CNxANc144768;
	Mon, 13 Jul 2026 11:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yKH3gopfwEDZE317Te3pVnWpYwMis/vfGdifLpD4bkc=; b=
	UjPKYaeBh78MPu7s3clPgbS05UivvkT4yfVZ3Q4yv8t1jcJtTQFDqQcnAuuBNybP
	46OmXexk6NOI20x6jATNaNRgUZx7VaYKV3NM2p+kq73OcGF6+xWZDtoDzr5KMJQk
	0eTYnB6qpl5elyHsficQ8pOOF+vQ0DbmFucJ5x/SQ+HznqamonR728YnMFLhQytE
	fWjxL9hkAGMp+Cq7wOVIuKXwpT7CTXCXkXoQs41cWCrGuC6yZyY/wHe3pU4ALvZt
	LC3PNNO5q2EsE0DdOO4Zbk+qxAQQ97wAikQZzkIY6Z67mktG7i+txLONZo8zSFg1
	vPXwI9bObP7bZtut5Av18A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbepn1ynu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:18:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBIENw026735;
	Mon, 13 Jul 2026 11:18:15 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9cxau0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 11:18:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKBTtTNCUnHxf+qSnJQF6DD+ShIbK+T1H6eUTi6iTGWRl7WbTrtOq7oVolgbl290qackGpXzLt6jHOSM+3nRU4kkkpY717hMysKdfXQmdy3UFgGOJRX8wCLZAcd7S2thDPXANa12dzB8jFUs4HCiuGoaZUj6BKx+Fc1ZK7tkotQ+0fxR1Ap04VHdrE3ZbGGPK7CgpBqcGI0ywQJm3yd9MdeJMywnz7FzxwdY2keEZAL7Hy/KQFxlNGx2dhVHEgXHI3g4xm9brlaS4lk56PsKfMDpyWTUXeEXbqwYXncq0vJQiAzcjyvbLl8So81/QV1GempHZ0i8jw8hN0j6NmRLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKH3gopfwEDZE317Te3pVnWpYwMis/vfGdifLpD4bkc=;
 b=fOtgWUOA6zz/ImFYBYC3x3Lcl5k5As2K1uzr1lj9eOknnIyRN/a+Udl/1zTLawwanEjx085I7V8AUzoPDwApFgJ02bDc9HJVj6xWKvIIhNRRgjccz7fauaQD0P65J8ex9rCHe6JJyZLlk2ToeRneZvwidC1SFUIE3swWyrpiuCkHcY3SgMK7LdiBwOvV0zBQgisUU2rPkMCP4/OQPbe6wOg1PbSFRQLdutI+8MMGQ9+b10j5bYl8gmCAjvclu2ieA2kFD+oP9DmR6qTBLogKRhs9OLgEaPz7Sv/NGRreFzB90ZEeR9qlNFsZzaImQmvLVX8IqBZndLzD+xqdzA0XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKH3gopfwEDZE317Te3pVnWpYwMis/vfGdifLpD4bkc=;
 b=bCMG8ntiw7EWsIL1XmapJooPBtzbYh+mzkbl0s0p9NZq/0BMoKHm4Slv2SlOFNgCYqwwOWZSDz4Hz4iYHzQ3njq1zVWDpTSOX9EHtmta0xF6iIWtwnGgEd2y7NBX1Ewz34RaqN53MPAhqvtBTaVXX1bw6VKu1Q3u1fUmf4zMksE=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 11:17:52 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 11:17:52 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "yishaih@nvidia.com" <yishaih@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Thread-Topic: [PATCH v2] IB/mlx4: Fix stale CM id_map entries when RTU is
 never received
Thread-Index: AQHdDT902skfy2xlik+nmHUM+X9tALZrKskAgAAsvOA=
Date: Mon, 13 Jul 2026 11:17:52 +0000
Message-ID:
 <BL0PR10MB2820E17EA20A80BC499CC2048CFA2@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260706120255.639985-1-praveen.kannoju@oracle.com>
 <20260713083604.GI33197@unreal>
In-Reply-To: <20260713083604.GI33197@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-07-13T11:16:10.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|IA3PR10MB8164:EE_
x-ms-office365-filtering-correlation-id: 2592a948-83a4-4ae2-3b0d-08dee0d0614c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|5023799004|4143699003|56012099006|18002099003|6133799003|22082099003|38070700021|13003099007;
x-microsoft-antispam-message-info:
 gazoR2Grn8fIEenkOlZbNRHsYNqlnKFov/jzAam65Fst9b9WP1gRxMZzjRqmjF0Etj6q5yY9MLguUj8BtkfEJe4AYThuFas0LXE9W04ON9dp+NHbOv2hEjMcxp7l3OqrEH+DGBeQ13uEAIISVZhSMg4qG5Lc0NfSc3mxc3clpy7hz+gXX/VYtCzKekWTUB0wBy5RoI19mVBcSVoBbIsclPIWzIWsamCUVAmhU4P8sv3aZmoLExnJhDNoxDxr7MfUyvwOVjYApD88UsqoR/9jmfjSbHCGdE7WXXk9sX3RHuGmnX0TPK8gHMS6OE9HIFyoCxpNxwsyY86V8b5QdBeAnNC1IvzJJJwWtxHCNI5o17kLTf7tVLpurpgG4QIgczGvAvRJQPgiAleaEnz/k2K6MCjFZa/edxGBtgMMpKd+5GoZY8RtLoq0fjF7H2GqnjxCkVVGW+469O7IyXN/I/N0KaHxO05mZV3HXUQktt4MZnj9ObMLGZqPdvZbA1T//ARhxf7W6g1O0F4JTZIXHtHwkfqHlKpiLjD7az9Cy0Taq2q+GYtpEUPgOp3e6JLhHmJQcCe7xtQHZs4Dk2FZd6W8cQI9QXfWTkMPDP5H6laOiHy+lR++mmzI2O/6qUtQCo/9jcA4zQjU2bk/G3vG0C5hJZOfryL3mturMtxExCIY3O8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(5023799004)(4143699003)(56012099006)(18002099003)(6133799003)(22082099003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?YnhnLzV4SXk0WVd0QTR6SmQyei9zeDk5bjVlaWlHUmgyZTdaaGx6cFVkTkYz?=
 =?utf-7?B?UmpkNW5TclAxeHJ0bW4yWE5JcTJnSEpDazVCSnN1cU5sWmFuVkNtTGNLYjFX?=
 =?utf-7?B?MnVOVzdMeElraEtXWCstNmZJZ0dybHR2UDBZa0dIOWNZTmx3b0xXYXk0bTA1?=
 =?utf-7?B?WVZHTisteDlXRjVYT2wvSmU1Q3B4TVcwbDQxU3J6WkNJdUQ1ams0d2VLekxC?=
 =?utf-7?B?ZHV0c0xKLzdNTlNwTCstVDZubXFkcVhRckhnNEsySS9sdUwzQVZRTWY2a1NJ?=
 =?utf-7?B?MDlINnYyU1h5aXR2TER0QTFhWWdIL3piWi9HWUZwdHA5TExCcFpsb3h0bjlZ?=
 =?utf-7?B?Sjh1QVNWamxsaWlBVWxCRmswYlNtTlZEU3ZuNVpkR0pSb0EycnVucktjNldv?=
 =?utf-7?B?UHZvNW9QbFRMb01CQlVEVlhwN2hZcllTKy1lWnZoSnRleVd3U2UxRldVcCst?=
 =?utf-7?B?MlhXT2d4WnN1cVlPSHhnRHdCT1B6YistTW9wOVB6REdTc0xIY2c4VVJWV001?=
 =?utf-7?B?VGtDTXVuOGtIbk5JSHcrLWZYVzRRMDdzd3dXbystWE9rblVJdnhIUHgrLXdK?=
 =?utf-7?B?L0FjL3J5UWdyRUdTaHNTeVFZWistNkFoaExBTHdxZ3BqNWQxTHdYSlAzTXNK?=
 =?utf-7?B?WkR1Q1JLQ28rLWk4UDMvdSstZnlhUEZ6RGN0QldxdnVpUWhDNVVvREpEMWpx?=
 =?utf-7?B?ZFJTYUN0eistMzh0TUdFVmRmMHg2a1hlSVgya05wY0RuRXhpN3JWajZDVlJp?=
 =?utf-7?B?cEtWL0pnV0x5dGI0UjZMb0lMMGIwZzNnR1VCZGhYM3crLWdxdncwQ2VYS1Vm?=
 =?utf-7?B?VlJ1NTRtR1c1U0dGUHZrOCstZWFvSklWSmJVbFJMVlpRdGZhUGZMR3BoaXUy?=
 =?utf-7?B?Z1pVaDVZZXMxQlpkQW1RZ3h2MzFVNUdHZkRJUVBybSstTUdOS2VibmZFTDBP?=
 =?utf-7?B?TmQ0Q09wZ0pLWkQ1d24zNkJmZGNlc25DUExYZW9ZNUdOSThPenZDNXFJQUJK?=
 =?utf-7?B?LzgxRUFrc2dkNm9BOWxBSkt1alU4dnl3V3ZoTHNoRHhMenVyL3E3RDQvVTVm?=
 =?utf-7?B?cWpheWFxUUl5cjRXNnNRbW1mYjZVUEE5MDBiWVdhQ01uS1JZS1FJb2pieEYw?=
 =?utf-7?B?S2cydVZwOGdHc1hJYWdaa1BFYlkrLUhHd2lHMFNDeUZNSlpvZUVtcS9GbTFH?=
 =?utf-7?B?YW55NmZBR0FRR0dYT3FsZEZCcTBnTkpvcm1RTlVvVHVBN1c5b2h3VHl1dnpN?=
 =?utf-7?B?aXdWQnBLejFwcG1mdTFsazNXYjVtZmtLbXlXV3BQcGZ0cFVySzVRckdHcEFk?=
 =?utf-7?B?QVFlTmpyeVlwUEMyYlc0WHRpbUZ5MHU0aDMrLWh6M0gwMThlN1lnUzRVUXFi?=
 =?utf-7?B?bTRLVU5OTkpxRmdXZystblBRNE4yZ2NoWDhSNllzdjRON2ZuZW8vYzdrcXl1?=
 =?utf-7?B?ZnFkNE5qKy1Rb2dMdlBzdjZ1amRHZmJJdUhFcW1GUVVOMktuRUY5Vlc1VmJ4?=
 =?utf-7?B?TEwxaWUrLUx0b25IYjRZUmptbXI0MVhnMDlHVistM21oSFNEVDVRanhXSjY=?=
 =?utf-7?B?Ky1oSEdoUFY4VXh1QWkwam5uR3ZSSk9pUlBoWmszcW1TWWxvTWRPNzVWc053?=
 =?utf-7?B?dUlWNXNiSnNWT1dQa0FyV09ydnNlNVdVN2JlRTVhVm80MzdaejIzbUVKeVAy?=
 =?utf-7?B?MHVwS2NMTkRWeDBZbXFSTWdFeDRoVDU1bFNDUVpzeDYxcXlFS08zbHlCRnJ3?=
 =?utf-7?B?MGttdnhlZ0Q0TXU4cHZMYmVNb2MzemZ3L0Z4eVI1RHZxTkpQb3FpRFlmYWFF?=
 =?utf-7?B?c2l6USstVUc0dzRaMVdYSmg4bFI1Ky1sSUF6RElRRThEazJqMzU0akJaQTZS?=
 =?utf-7?B?V3YwZVBFKy11MjZMZHdmYWU3bFdiWmZ0UUZLc1VURDNEbHdjZFc1TkI2Snpu?=
 =?utf-7?B?L21YUFVuN1R0a3RZcm50bVpZcU9qZjNoWThzRkVxU2NlbG1XNXYrLU9Gc3dJ?=
 =?utf-7?B?VXVKb3JtU1FETzlVSUdoUzRKV2hMZU1UTDlxV1ptZ2RMdEN4MmpSZml2WFpK?=
 =?utf-7?B?Ky1VZFJ2UE16QWNIa2JiOE5tZ0NRT1BqaXpTMmd0N3BBMU9QcCstRGV0eGo1?=
 =?utf-7?B?dzZacy9peDVWWEE5T0Y1L1FtRDg2d0ZZa05NWFFGVno0azAxUXJmOFhrenVq?=
 =?utf-7?B?djJyKy1BQ1lIN0JuMEYyN3MrLU83R2tFZmNkZWI0WW90OU9rVDdLKy1DSkpN?=
 =?utf-7?B?N1dlZ1l4dHEwa2pvandWWFVkMkVldGlHV0lVVEdyNU5MZ0JESmozSlA3M0lu?=
 =?utf-7?B?UXFnS3pOTnlOcElmblBIM2xadistU2U4SEFIN2lNaGRrYzFyZ1pQYUs4UmdN?=
 =?utf-7?B?aVlKUCstMTYyOGh5anZFQk4wenJtd3dCb05IbFJRK0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fTBQqAN2tm3QYxNuelgzrQWMHh1zZLkcpGyKA7bTWUFM7b4PaidcxSDA60EoTm6lHIjnXXySn6Py/mVEFGUFuiuwRC9beFUXTl8L17lKv3SVaiBusRdViMH8b1TqG3QONSYaLxXBDDgZbtsEpWYh7WGDTz+WVP24CJ0F93Ul6A2m+6cW5Jb68DqLvWJ6kgLro8iJuBlRo9prmpnrdmiFk8PYVDUPTfJLBq53Uj60knIATiQ/mxocnecMu3Udnti1loOjMpyBSPw7AsHSFxmEb/mmVP6IeSoYX5mZxi+B9+cjgv35MEN3jx8ujn124rYQ6PKGKz63k7khq+0ic7ReNQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7wEJYTbjpkxqXm7SI7i/AcH5e97ABO9nyQFTMpA7IWCGYlQOLab3Ys7YTVI+WEhr+22dlW/O5/zm1NrlxdHE6c9Ka4Pspn/zT8PnG3waCUbi9RayxMJ3yzeJ7NGT+npNVlC5P/sxfBXWY7hv8xF+qhigYWZqYXx6wEE3poyAIfxBIl+0sCavIQjHYQ1+g2ssJkC2lC7n5tT8RcdSzeI/XikwRj07K3/JZxGlpcUKI+QJCogTlHkv8ohcJEXFo2nPS4n8kTNN5UISyTL++G/e7+HjX8gUCqI0tefjBd9hN9vz5p0MuZzla8X9krMK4a68rnziKttBzjZPx/NfIYozmcvOQePmUAeedObAAYUSuor8SCLn/AC4gSpOiyzj2yrcXUfAmbqe8mKH5z1OVog3KGMgHeMpp8ETMbJhyqQUFJNVg2HVwLoDjVIiY1m8MDzB+CO5uGw7T4Fh4Me78Ovx4U0tOiOHOSE69d1yLlZQOKcgacQwcXP3yTopkXnJ8IEuj6+VUeCLF4GnRXzSaRYkJNBLRRSn4crZDFFOC9cBx5zPr+LYhJ9vj/c0b6KIKlCYRs7HYja3Ktk6w2ueNqWZ9bhn5VgfWSV3TUoUYgUYYI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2592a948-83a4-4ae2-3b0d-08dee0d0614c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 11:17:52.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYhWkcqGkmYv6EN/G12N1kadiXtLTOBNX0w2QDucgf33VBT3g6rGuT148lfc9mlGNqomlkolkCYfg3Q5d8RwLamos7zSTNMx27+qqEY27YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607130118
X-Proofpoint-GUID: iqW6FlEsXiUDc-Ah-igAcNhypHUvoZ4O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfXx3E2ytbbwEK9
 IeUpz35VBRCqg1X+ctqvejqOsIIU6lPQVg+bTk1Psq0an7RxXY2A8PieCrl3GSxpSLby5PJcKDm
 n8MQVbQYaOdx1iUo6Mk157qgm78q/F3WQh4SoNbGz2XAMa7yuURCjGs6/c6PqYsJVNuRjdEpvtc
 Rg2c/2/BT2KZGYYcA6hilxV1/fbGsykXWEAHypqm/HYaVYAn0zJ1loXHX1dpETs3V1vLojZVSoU
 N55r619Lu7YYbqtNAAAqgK/h85qmtEbZZi6zauyFOvDVGAb3FGpaoAA528WzzgENjvh/RrLd1mp
 7eIgHkVhmarQKELJS9R8hZlg7y1MbYrjVkgnzCDdpbZuN5qOEBl6d1V4vwyI3q7446Jzw2RyWn2
 2vT5mld8B9AuvCOaMYgDFbP4zY40FATkMzXxhzJIDw5tifG4r9E0ptQd4qCQF+LJH4U6m8+6PqW
 aw9tZ4hUyKbfNoM317Q==
X-Authority-Analysis: v=2.4 cv=bJom5v+Z c=1 sm=1 tr=0 ts=6a54c978 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=mQvHCebiAAAA:8 a=yPCof4ZbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=c1PdSmG1AAAA:8 a=BXszkKfDAAAA:8
 a=Fofg-9D3AAAA:8 a=DIz_F7iy1GwiMmLO9u0A:9 a=avxi3fN6y70A:10
 a=wsrb8zZI_WQ3QAEBCXTy:22 a=ZE6KLimJVUuLrTuGpvhn:22 a=4iM0TfZbaBQr0p37pvCp:22
 a=duu7wrcty9prphiCz_fF:22 a=Xbaoi9ZUBzzYp91LqZJF:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX/wBm20BahLpz
 TuE2ydhcGagkzjMHt/v5Rc7s/QI/pyrB4daN5OTBa6ujhiWpY3P2DepgK2elM+yywvQ7DOhRKE/
 gQNaR/f2BEI5fC+40r1+m/FuLv4ZsjoYzc/AqYUXpPZVnVLNmJs/
X-Proofpoint-ORIG-GUID: iqW6FlEsXiUDc-Ah-igAcNhypHUvoZ4O
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
	TAGGED_FROM(0.00)[bounces-23120-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,oracle.com:from_mime,oracle.com:email,oracle.com:dkim,vger.kernel.org:from_smtp,ziepe.ca:email,oracle.onmicrosoft.com:dkim,BL0PR10MB2820.namprd10.prod.outlook.com:mid];
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
X-Rspamd-Queue-Id: 094FA74A4BC

Oracle Confidential

Thank you very much for the review, Leon.
Have addressed your comment and submitted the v3.
https://lore.kernel.org/linux-rdma/20260713111142.1206710-1-praveen.kannoju=
+AEA-oracle.com/T/+ACM-u

Request you to review it.

-
Praveen.


Oracle Confidential
+AD4- -----Original Message-----
+AD4- From: Leon Romanovsky +ADw-leon+AEA-kernel.org+AD4-
+AD4- Sent: Monday, July 13, 2026 2:06 PM
+AD4- To: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Cc: yishaih+AEA-nvidia.com+ADs- jgg+AEA-ziepe.ca+ADs- linux-rdma+AEA-=
vger.kernel.org+ADs- linux-
+AD4- kernel+AEA-vger.kernel.org
+AD4- Subject: Re: +AFs-PATCH v2+AF0- IB/mlx4: Fix stale CM id+AF8-map entr=
ies when RTU is
+AD4- never received
+AD4-
+AD4- On Mon, Jul 06, 2026 at 12:02:55PM +-0000, Praveen Kumar Kannoju wrot=
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
+AD4- +AD4-  drivers/infiniband/hw/mlx4/cm.c +AHw- 101
+AD4- +AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----=
-------
+AD4- +AD4-  1 file changed, 76 insertions(+-), 25 deletions(-)
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
+AD4- +AD4- +AEAAQA- -261,48 +-274,46 +AEAAQA- id+AF8-map+AF8-alloc(struct =
ib+AF8-device +ACo-ibdev, int
+AD4- slave+AF8-id, u32 sl+AF8-cm+AF8-id)
+AD4- +AD4-     return ERR+AF8-PTR(-ENOMEM)+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4-
+AD4- +AD4- +-/+ACo- Lock should be taken before called +ACo-/
+AD4-
+AD4- /+ACo- Lock should be taken before called +ACo-/ sentence needs to be=
 replaced by
+AD4- lockdep+AF8-held(+ACY-sriov-+AD4-id+AF8-map+AF8-lock)+ADs-
+AD4-
+AD4- Thanks

