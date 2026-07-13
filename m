Return-Path: <linux-rdma+bounces-23119-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BUckLRvJVGrrSwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23119-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:16:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCC74A3D9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=XE3A2kTa;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=jJ59w7Lp;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23119-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23119-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4267E3035164
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1FC388382;
	Mon, 13 Jul 2026 11:16:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A624384CE8;
	Mon, 13 Jul 2026 11:15:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941360; cv=fail; b=MxLxlUCNZ9Tsn3ZMJkywwa9SprI11ooIgQYpdbX6B6sTcOqdoQ3h4DuNQTdq+fLjM64stAxGeLdULqDRgvGFFNmXIXwjVkfiaAi63KzpE6XmIJEHlrGUaNnr9+vhm0AQ6jRQLp0o/2/3D4mjsDjzicFEWBgQ/03OEKMDb2L2ed4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941360; c=relaxed/simple;
	bh=VfJl3ksgOG4oUY/L15R8Iu/e13omoWpL9oB0N/O6lPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+tV0adseonoRgVWH0QUX9KxgV+pMfSOiBTwYc1lTNEEAvD/PaJNav5Jo+F2UYjg/umC0/prue/3LGDjh+UcwoKXDjF15ExdxzDow4ROa3UEp9yZjVqEnWDGSAHfbTYrmdJWhkZNjRvIIvlCJSjaTNozM0XAlJGLsQkEg6mOOkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XE3A2kTa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jJ59w7Lp; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D0nfiG227053;
	Mon, 13 Jul 2026 11:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DjM5BiY1ChbKXGscyD9ZKy/rcHS83XaiMBAKGOxHF6I=; b=
	XE3A2kTad/JBZ/0pYH3O+V7mrOeEHlrZG138258SKLuu++nm2UTqC0H3MzK00Cft
	SIRk+3dsz60pY2103XtTPJz9taRFBBUV5F1habKwPgNNuNOZP0fTtyuJ8OAJtRdR
	aHo9DOsHnA58V5zsyx7Zh5RxeFv8M90QkPN6KKAAZymflyRitst5GGWCLhQwJw49
	GFgmVlW0NB3jvAVsRnjraO0vw8bcYqXlzHmlczSbCuTniyJIvpFbjAJai2o/VtaY
	qqPztxf4zQdt/UMtjwszIWwsW1fZkNtnZcV37Ikx+B6mUNcRGD1JCh6+ewqX9lfn
	tkLRTiF2hPg8HmlD3/CfHg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed81yax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:15:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBDg5j011959;
	Mon, 13 Jul 2026 11:15:53 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9q63ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:15:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8BNH4DpVY6jiSD5CYTL6GvVOajqRc/rhA/M3RUB/GENt9zq0OROXauOPO5tA6sQYXsyO0A3itMfab3oxJN0PLv0MEabruTbDmR7uUe5t9M/yRj1yEoj9JIDiq/iyzEaSyBo3wUshMsIFASdph99LedjcmlNygICTgFqH9UHWVoGM/iKylC7V0Ao9qRg5Or0Ks0rKcI79KBM6ys/M4vGqBRIQmBynyb3udWC1v1Ox0VCffzDFi622Kd7jGi1TbsHq3J8Nl79MAlfJpS1QtzP0rUJairq0B8xhElD0NitZGoCcoJUKNVOsxV/sGcq24dJ12h2H4AdM8A4R2Aeek2SZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjM5BiY1ChbKXGscyD9ZKy/rcHS83XaiMBAKGOxHF6I=;
 b=gtDapPh6+Z6/RFBQv+5KZ+4zRL2aYWFLsjC0ICNspsVWwY/NZsiqH+7gzu0BPmZxeGtP2lSi+HCOus5n4qzBVlOfZrSn7BeNTodrou9rgcThMPrgw47eo+GWCs4LBvxgQbu7DpB6pXdNYzSdkSGfUhLD+S/2tv2h5nR1RXimQZU62//e4J0kK0mFmeuKqP4L4ptKwAKaaonfwmQ2Eq1171eixflG8ty7ASbsMMwAU8isZ70LFYNRqaPSwwDJH/GWt3f4SbSczQiaWyzxJ3w33RyLaIq9YhPmR9/6d2cHsg/LF+N32jTg7srYEUuscSevyNAly0juSDjBVUJxpKy27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjM5BiY1ChbKXGscyD9ZKy/rcHS83XaiMBAKGOxHF6I=;
 b=jJ59w7Lplz2kuKvdIyV8GPKjW3I+1w/77A5Tbs4eLRxTgdE0hsFSxS8EztwdMt/owy6+hN9qjUtQkqCgRtaVGNUNHuWwp2SyUggZIjOeIhIePq3CJpwbnz0vtACCretmITbe+oFbMtV/XvuitZMGLHet/I9tSTauKtfsjXYNAz4=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 11:15:50 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 11:15:50 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Leon Romanovsky <leon@kernel.org>,
        "yishaih@nvidia.com"
	<yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Manjunath Patil <manjunath.b.patil@oracle.com>,
        Anand Khoje
	<anand.a.khoje@oracle.com>
Subject: RE: [PATCH v2] IB/mlx4: delete allocated id_map_entry while sending
 REJ
Thread-Topic: [PATCH v2] IB/mlx4: delete allocated id_map_entry while sending
 REJ
Thread-Index: AQHc/Or+sVRbKCED7U6IIX175NZmL7ZrS4AAgAAsdrA=
Date: Mon, 13 Jul 2026 11:15:50 +0000
Message-ID:
 <BL0PR10MB2820AFD5AC16705565CCDBE58CFA2@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260615171759.557425-1-praveen.kannoju@oracle.com>
 <178393177689.1679084.4077224530208522909.b4-ty@kernel.org>
In-Reply-To: <178393177689.1679084.4077224530208522909.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-07-13T11:15:23.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|IA3PR10MB8164:EE_
x-ms-office365-filtering-correlation-id: 3a0d8814-9b18-4899-f8a0-08dee0d018b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 w/Sf3sdkQVx8YruwdmpTiR8cdQpk5zsLZbbysQbcXYXv2j6w0WaFFeA5cZ5IiwANPuLjqG2rM7OawZ4K9ncctk9v0GuHU0CncJFaF6IIQbPcnzltLiiG2EVhhi8BM30kq7l/ryO2zzzBmFudSLcffbj4ztV85LLOJHjMDh3Ujg4TUM9Z+G3oJaTQHRw9Bw5LjZ6sXBff2RM29ymfUOQ5HoRXYXmzap4wm1TzdrNKGSXluCNgOp5F3DtZ5BnIiaKkhMuSbh9nuhPkD47dhgUMd+fM09MlaMN2MwVvqT/73UI1KDZ9JfpjyCzOuMfjWJRI1PoNVa1jW4dFLlxdehRd0wMIIrz/0KfVZLLDsXq6pNWwe8fojlRr4Npbq/MYoJhY1QTZLob7P3AxWoHkLmk1YWBUQqlZwnjI+XhhXX1ppM13VxpbWSR7aJYoXz2ibd4Co5yq/ViXOo3X+c2RYhL9GyJ1rQf6Oz00FPgCL5mAbZgBEehYFvAuGbRJwGrCmprFstSzqb0zYo4Xdll8YWizs1JdlIW1CL/4ADiUAFGaW4TRv44tTI/+7C/njfpyR38K3IsXy1VVrHOf/qBvtS+ulL8zZhTh7GO5ka9WVrvXSYTVjbE/ZX02QgrZA9b18VUyceep+sSbHO96dQvAM7Vr3ckET5KEoi/mzz0pZ7Cp2SDd3IKwdBVuAOQwo4zyKtUrT+HquchxjJoxSCznzSBWgmeKapIUsCXB8TZFmYCI2C0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?MGQveHlRdWcxdW4xMkVkVmxOZzZzZWdVWkJVcmZEUzFBeTBrNEFmMXEwMUhH?=
 =?utf-7?B?OVIxbnd1Sk0rLTdqVHcyZG9vRXpIRGhjS0hnRjNtRmVCOGZweUpUTFhYc1pI?=
 =?utf-7?B?NUFxNW9PRzR4aUhCN21abnhkalFaaWRJa0YwU0N4T2VIVDBycjdyKy1PVTRw?=
 =?utf-7?B?QUNGeWJTQ1FwamVPL2cvUnVDVmx3SklGWkVpSk0zREY5a1RLKy1xOGpzVllj?=
 =?utf-7?B?V1Y5NVpxemVRMHpxMTlNYnpHYmJFWHk5VlduUWdoWDRSNkdCdnlwYS8xRGkz?=
 =?utf-7?B?VzRLVGhCdG5lVG5hakRMVzZGZUdkeGVkQmZJTVAwNEhkcVJQeXQrLU0zQist?=
 =?utf-7?B?cFJiUHhsMFc0ZmZKRGgvUFNseUVxSk1GWistUzE2T29IZSstSFBuVEFTcDBo?=
 =?utf-7?B?SHM0UXdHNDQxZkFkclQyei90RmV6bEsvUnlIUkw1UXRlOVhaZTBYTlJOZEpV?=
 =?utf-7?B?ZEJnWDFMS3AwVE00TSstZVNZMTdUbXQ4M1VWbzB6SjJkbEpCZ1NiM2lpT05R?=
 =?utf-7?B?clViQWhWRkl0cllFKy1oMkpLbmsxSENPaER4Ky00bXNmQnZsZmFDUXpYVzJF?=
 =?utf-7?B?UUZtOTRPNzljRUZJSDNOOWFFaGFkbDZ1cU10NjdPZnRqdWFkNHc0TzlhcE1N?=
 =?utf-7?B?c1dpQVRVYk5ZWlZZbGo1dmlBaHlHZFFKc0xCNDkxTXR3SzBBOUsxc3dSdlJj?=
 =?utf-7?B?aHJlN3U4M0ZQTTZFMk9Pei8rLWxPclgxbERJaG5JT0tsZXJDY0lqTmsxdmJR?=
 =?utf-7?B?UW5rcTEya2dYeHNwbDgrLWpBalNVTmthWVRVdUV1bXNJZWNNcE1oMXdmb0I4?=
 =?utf-7?B?MFN2UkEvNmY5bCstdU8xcWhkY2s4THhNb0dOSEF3VWFFZjNmS0IwSistZUV4?=
 =?utf-7?B?TlkxQ2ErLWsyTEt5bkpySlNHNmFMTHk3c0dKdDA0QjR0eVFaVHBnMmVKeHZB?=
 =?utf-7?B?MVVia1AxVGFuQmFLYzRINnBqeW1PZ0k2bURjcDA2U21mTlpkcGxneGxNVzJ5?=
 =?utf-7?B?VXNRWEM2QjE5SmVBSzZZNSstMS9xZDByWnJzbUZROEwvV3JCNDEwTUwvdlhl?=
 =?utf-7?B?Vk9lNXBLSldzdmpnVURNWFBIdE1SWkdzdVdERWJRek5pM2VrbkFldHpuNU9N?=
 =?utf-7?B?Tm9xVURncC9qWSstenVDTnNNeFN0RnZDNW5UUmE5ZTNsQVdqNnE2ekMyYUdW?=
 =?utf-7?B?MEZsY3ltZnBPYkkvcmUyRzZwd3B6YVc0OGhvdUdJeVVTSSstUy9XL1VpZE1m?=
 =?utf-7?B?Ymk1NmxKVjRRdFhKVld1b3N3bmtqaGU5bXhPNmFnRm9WcERmR1JEMkdyWnZX?=
 =?utf-7?B?bjUvL1ZvcE8rLWUyUWE1S0lteWJkTVZuUHFkeFNycVk4Ky1lZGoyQlBaQ25s?=
 =?utf-7?B?SEw2UWx1RVp6SlZiNnh6MHVvb3drbHRnN2c5eFAwUWdldHliUXdCWmRtTnda?=
 =?utf-7?B?UzgwR0FwNmlaSTlIclVQVkROSWovRCstNDE2OHRrZTUyU01xTVdBeFZDdC9X?=
 =?utf-7?B?RnpNL2NzWm90SExHQkMxSGlsczBuVksyekxGaTFiMlQrLSstMGtBOHZJUHIx?=
 =?utf-7?B?TnpjS1haYmZMa1lZS1UxRkVFWUxjL0M2anNZd2RJYUxCMXFEOVZUa1JCUDRZ?=
 =?utf-7?B?aGw1eEV2L3VxT3ZKTG9VdmJXQXcwMWhoUTczWTRZV1JQRFRVZGlIbW5xWWJB?=
 =?utf-7?B?YVhMamRVbG9pS1ZNM2lxYTlaTWE1ZEdEc29SWHRlY2RjTGdDYmxQcDRpYWFH?=
 =?utf-7?B?V3A3alNvT3EvKy0zV0paVkx0UHBoaXhZbG9DczRrUUpTMlBzNkhEMFNxOUk5?=
 =?utf-7?B?SzlBOFdCZ1NXcTdSaEdQN1p6RGNndjN5Q1k3ajBhdUc2Vlc5SFlvVHJQUEZH?=
 =?utf-7?B?Y3ZodlBGMC9VcTNHWVIyUkNqRDc3a3g4UnR4NC9MZ1BrQjVPOEd4WjFTWktL?=
 =?utf-7?B?bGJuWUgydHdTQzg5NDdBNDF1QmplbmZKWFJZb0pwNGRkRUVEMzlzTzkwYU96?=
 =?utf-7?B?aEx3dDRsR01JVk9Ubng3S2kvR21MdWRpUFZVQ3FsU05wWlZ6ZFppYlJqeC9T?=
 =?utf-7?B?L2VTWm96NklRKy04MmpBV2tCa01yR1o5ajBxNUk3QmFyZkN1OVRsNzNzKy1C?=
 =?utf-7?B?QTl3eGtycG9OSFBOd0loeWVQY2FJZUNteUdzUUdMbVNxMlNXcjFNNUgvKy1v?=
 =?utf-7?B?SGJJNC8zUkZtVWwrLVcyekhjTkh5SERRUzRKYlVtd3FocElkQW1UT09PeHVm?=
 =?utf-7?B?MlJjT1ZZbE5zL0JNQkhxVkZqdFFjeXZ2MnFHcFFFTG95bm9WbEpYQTk3OW9G?=
 =?utf-7?B?QjhwUHkyVWxNVndzT05FUzF2TGtJVEpaN2ZTaWYxWEUza1V5YXFPa0M1bDhI?=
 =?utf-7?B?U2ZIQ2Nkd0drRXduWXl1THlKZHgwbVErQUQwQVBRLQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nXV/5QCexHg4UzJ36Tt/dvEelDCSDtErfoUPhF1fDIPIlCK0+tJqfg/kQ1WuFwudu3D+fhzmeNqGxXsF6XWDmCOhsiedRsrLlBV/Hq/0nezDp9hN01oXSilbeSv5C5hYOS4id4w4UEqySlkf5pK3lWRHdTbTWIMq/9+r8aWglwCnFHZaRLZesqrJ0bCnWehhB5TqwYlJC3P57jBr6OfrXQbdu3ue9rc276hX0VPj2bOowmaqLOUmrvnjuxan8n/zs5/W9ujChAkQvXj5cTDlZonOybEsn3jBmFepLTIBX9PaAUvsRi2qjS50idqacmVfdaXxAhsM9siYy56RYsrrag==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uw2F9n1ygp2UT4ekkqrO+EDOqvskN+zUVJaVNWT9wotiokeenGcjtMxtMpF8du3hSQ0TGPUlz7FjFddZydflXDSIAS6pWtZFvLkLt720d8diJttEibfLo/VHLc164/6SpLCcifMNJq9Obm+lShFleY9FLHZDe/xocLhktDjXTvEvoaLuiKD7dEoMERFppSiaauVZcIA0luZCZHw5ZO6b+M1HGYudUhDD5xy7qAU/ypJw6OGYatWEPtrG2hi0sVtl65tqmEUGdRJ86P2kRfHyCaiqqQ+m91sjFxVLWzysjl3WabCrNcGZIiHtxtGb0atlvX5OmcqltN/gQEn08o/faE9cIlQywnu2q6mzs61ULgYgUpj2iYbeJIILDio1w+fuO3aNQAWxvdW5xWiM8eHHsAtQNaGF9ZV7SV0ecmNS+uGph50TLAQpQrv3PZcl8vSKI0Q50l5RVndtGwKgyS6ZjaEHHz8KbljfJWNvrVt7MBQXa/swwihivuWcxU92rfGlTEENo20/EPLFfwOXeu61wM8jKzYs9fwK9h2rb8sKJDrCubRneoHTSG3ejGnk1o5pn8gMp+BKXnZfx9dD8vi2Bo+4u9nvyWopDjjijuf6Byc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0d8814-9b18-4899-f8a0-08dee0d018b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 11:15:50.5576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaRJM1fii703yHiQAsh1qRehlAPE3TX2B3YcFqYhAEYSUMok3M1x/HrQ5SY3VKzR0I+AOY4GPhtgscVZMNZ+eVP90WtTBfHr4ZHdEBks5+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607130117
X-Proofpoint-GUID: agHkpw7Ktmxc_7k8a-LiMArh49oteGSf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX+LYA03U73QlQ
 5ENWdcCd2R7EGpJW8l9Ry/98eeccFYZ6QgWw3tOy92uM+VMvEy0vFNT0djTyIjfhKmfvtCYzvmK
 B2ztnzCqrRXCM4UjF9U589TA3IoTlmOa4pmajiKa3Ubk4dHHAKVw
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a54c8e9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8
 a=yPCof4ZbAAAA:8 a=c1PdSmG1AAAA:8 a=BXszkKfDAAAA:8 a=Fofg-9D3AAAA:8
 a=mQvHCebiAAAA:8 a=A31vkoZkQLcKvY8RMIMA:9 a=avxi3fN6y70A:10
 a=ZE6KLimJVUuLrTuGpvhn:22 a=4iM0TfZbaBQr0p37pvCp:22 a=duu7wrcty9prphiCz_fF:22
 a=Xbaoi9ZUBzzYp91LqZJF:22 a=wsrb8zZI_WQ3QAEBCXTy:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12222
X-Proofpoint-ORIG-GUID: agHkpw7Ktmxc_7k8a-LiMArh49oteGSf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX3F915NTPpabE
 3sR0UbObAz37EAnqVzUvCId7GDKol0OxK9SVIUGnQ9RvcOUhaVo/m9vNn2JpGqu1th+MwYzgAJq
 hFcjtHNZsjTsoNDaEx2PIKBDnF4yo+TNGl1C8vZMWbtBPaLRoUT/5fzU+pMUx2jcLkwuwwrVEZ9
 7L71cvgTBoQjpzOVQGglL/+Mxlj+SE/FjP1/sM8axP+DXwmdb8sJ79DpCIE5rovzj98D4KU/hdr
 wTCdqVycpdMe8Krsh33sBaZWxU63wAEDB+da+fnJ5UjZwGhvE/nUP7Qj4NGv7cwtOdNvz6c+TZy
 WGElh5tq8uSotLgG9E1Zn5wjLK5khEL+BgNI+ouAv+hf3ClvUoOgJLA4lDqEE0UdD4fqZNRHzUR
 vBhxcJDmN/u//P5CilPvnobsGeGu+PCGuMp9FYhSPXf0mqSZfcYkXTXVN57B129cea2/cG/MKUj
 KNXSSBx5KVXOAowGijl8gSNP7voViRvhs3LFoiUw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23119-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:from_mime,oracle.com:email,oracle.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.onmicrosoft.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:anand.a.khoje@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20CCC74A3D9

Oracle Confidential

Thank you very much, Leon.

-
Praveen.


Oracle Confidential
+AD4- -----Original Message-----
+AD4- From: Leon Romanovsky +ADw-leon+AEA-kernel.org+AD4-
+AD4- Sent: Monday, July 13, 2026 2:06 PM
+AD4- To: yishaih+AEA-nvidia.com+ADs- jgg+AEA-ziepe.ca+ADs- linux-rdma+AEA-=
vger.kernel.org+ADs- linux-
+AD4- kernel+AEA-vger.kernel.org+ADs- Praveen Kannoju +ADw-praveen.kannoju+=
AEA-oracle.com+AD4-
+AD4- Cc: Manjunath Patil +ADw-manjunath.b.patil+AEA-oracle.com+AD4AOw- Ana=
nd Khoje
+AD4- +ADw-anand.a.khoje+AEA-oracle.com+AD4-
+AD4- Subject: Re: +AFs-PATCH v2+AF0- IB/mlx4: delete allocated id+AF8-map+=
AF8-entry while sending
+AD4- REJ
+AD4-
+AD4-
+AD4- On Mon, 15 Jun 2026 17:17:59 +-0000, Praveen Kumar Kannoju wrote:
+AD4- +AD4- The mlx4 CM paravirtualization layer rewrites a VF's local
+AD4- +AD4- communication ID to a PF-visible ID when CM MADs are sent from =
the VF.
+AD4- +AD4- For messages that start or advance a connection from the VF sid=
e, such
+AD4- +AD4- as REQ, REP, MRA and SIDR+AF8-REQ, mlx4+AF8-ib+AF8-multiplex+AF=
8-cm+AF8-handler()
+AD4- +AD4- allocates an id+AF8-map+AF8-entry when no existing mapping is f=
ound.
+AD4- +AD4-
+AD4- +AD4- A REJ is different because it is a terminal response to an alre=
ady
+AD4- +AD4- known exchange. It should either find an existing id+AF8-map+AF=
8-entry,
+AD4- +AD4- rewrite the local communication ID, and schedule that entry for
+AD4- +AD4- deletion, or it should pass through unchanged when no mapping e=
xists.
+AD4- +AD4-
+AD4- +AD4- +AFs-...+AF0-
+AD4-
+AD4- Applied, thanks+ACE-
+AD4-
+AD4- +AFs-1/1+AF0- IB/mlx4: delete allocated id+AF8-map+AF8-entry while se=
nding REJ
+AD4-       https://git.kernel.org/rdma/rdma/c/9539e619660471
+AD4-
+AD4- Best regards,
+AD4- --
+AD4- Leon Romanovsky +ADw-leon+AEA-kernel.org+AD4-


