Return-Path: <linux-rdma+bounces-22791-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zXL6CcxlS2ruQgEAu9opvQ
	(envelope-from <linux-rdma+bounces-22791-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 10:22:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B317770E0A9
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 10:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=R8r23Uac;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=Ab1jE+Si;
	dmarc=pass (policy=reject) header.from=oracle.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22791-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22791-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37F4132601B4
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225637C113;
	Mon,  6 Jul 2026 07:37:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CD39C65F;
	Mon,  6 Jul 2026 07:37:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323432; cv=fail; b=UWZqdk06jc0yjepmtd2sAEZKwUsp3u9eiso7nzB3sSqPfn/NV3YGMJL0UiGrlq/qg/J53ef/sFaqxtQ1O49y98t4c7cm41VpM96RtaIHbiw6tQFOEsg9td1M5kB5iOm8WaMD4SifaZZfRebKaTbi4PqXE3dz5XiVcp1qPqM94SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323432; c=relaxed/simple;
	bh=2vePNq7hvzLZ4h1xSNIjAdOSLVwcZHh07B3Co5d6DKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ksEUknE+qxyjAMjxKq6VvrYffzi69Nbpe3f3ptuMYZaAv9bd1a3r+t8KHDE41XoUacqFwo5AD72XXBUxUMPOutKFMf0JWEm+h64ucbswTiNPy3GbPw5dFM2Yo6wbrJJo9QquBKAweHUpw2GZaXg6Iv2T92PdhZMmXVNcBaIbRrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R8r23Uac; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ab1jE+Si; arc=fail smtp.client-ip=205.220.177.32
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665NK1r41009311;
	Mon, 6 Jul 2026 07:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B0//sxb1UnUo/mtsLYqvBaPsQT1OEBDOBA/2W12KNog=; b=
	R8r23Uacf/JpMWDgFQbNdHaegLXoE7HNls6UfomqoRcv8j51GNSvzv+oGwb53N2T
	6e9/D9AQcJMgpUKollIrxBv2KHMB0X3NeAJXlfV5Hvf/G9/xwZUYnigKWJ84JZSZ
	RqTA23SrVKwxn1Ab1vHc07s6uY7rEDrIx/f+htzs/K+FSe0sC9MpMvzm1Qyy3OF7
	rKeTNMepcgDgGN0pDZ1kbzA2geKFOT4lii6m6UEsvX9khniWWMUEE3sOr5dffqAC
	WHBQgu9dEo6c8TaKKPX00v87al8wzGOVIELXMd1+pQ/kwekDS08hJj0yStXQnYTx
	MB7i2UClYo6Zfu4J16aoYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6rkbb8u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 07:36:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6667X9lp028728;
	Mon, 6 Jul 2026 07:36:47 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f6twgasnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 07:36:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlEl008vDAw8ECvSynPYS8YJEHyEXiABkY3TLASAnJwtY9xS6hidyOeojFyGQULOM5FW2vOZEffx2HYvZyf1SESZEElmwfofHTFLfV0nC9uF+14XpNAax898B/v1JJgA5XjZ4o7/vvr4Sp4Bx0vs5mEVZhxx/Siso+sYuJVXEj63FN/RiCm0n/DTmqyO6/D0N89uoiyAQlHbi90CZBHihz0x4fWVXc9ZlAq6v/OrBgKrnEBWa2jmV2Pi+ZGADujlbee8RUvEHFgv9DAe4qYHNBfZNQFPWpxT7tXXK+i5JNGLbl5WcU08bPukUQRslkyO9Z2Me5E7K6PNAQ1DisfkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0//sxb1UnUo/mtsLYqvBaPsQT1OEBDOBA/2W12KNog=;
 b=rXsN/tEF3rljEeoF1usaAMSdJCProRytVx1EqmKRRTs8FNt6yy8FVK+iIBETjQf6Dk6oPZ7Cyj2RW+p+zDComPYEir4n1/nWVy5DgNWQv8gSHUISrq3AOPvKoh/8/+qISLQNfXPiKYmWyXA15JcuHsWSjwy7Xmc+FtC0V9uGShqId7vidYNLzJv5jUBgPYiK8Ob4DVELr7oxTbrB9kx4nkjp7fTD7L864JXr0FE6gVKGu5FLUZX+m/VkL7Niw3B6CyGsx9EebVhScOj6TbWbNTw/zoHgoq0iYt+diDyHLIZhNeToZC++qj85xPw+u3e9JgPAj6vEts66hhQ/dHAkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0//sxb1UnUo/mtsLYqvBaPsQT1OEBDOBA/2W12KNog=;
 b=Ab1jE+SiG1v6+0Ihbqh41h71RnFNsgNDpQaLJK6KwMZ0cgFZXaRVEA2kJeohJgBI/LtGnEUYJ+rHBTw0pxd8JsbVuKBo4umpmKq4tbLQ3jgXEwyBMbKOeVNMoriERuvDUVvdx/yw0cSLYRRWcPKi6TqOpb7xpKKV8f8PzT0jmVw=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by SJ5PPFA8FAAE4F4.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 07:36:44 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:36:43 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: "yishaih@nvidia.com" <yishaih@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Manjunath Patil <manjunath.b.patil@oracle.com>,
        Anand Khoje
	<anand.a.khoje@oracle.com>
Subject: RE: [PATCH v2] IB/mlx4: delete allocated id_map_entry while sending
 REJ
Thread-Topic: [PATCH v2] IB/mlx4: delete allocated id_map_entry while sending
 REJ
Thread-Index: AQHc/Or+sVRbKCED7U6IIX175NZmL7Y/3G+ggCBd99A=
Date: Mon, 6 Jul 2026 07:36:43 +0000
Message-ID:
 <BL0PR10MB28201DF90697BE5D585CAC9B8CF12@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260615171759.557425-1-praveen.kannoju@oracle.com>
 <BL0PR10MB2820A3798CC50DD9E0B85FCA8CE62@BL0PR10MB2820.namprd10.prod.outlook.com>
In-Reply-To:
 <BL0PR10MB2820A3798CC50DD9E0B85FCA8CE62@BL0PR10MB2820.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-06-15T17:19:34.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|SJ5PPFA8FAAE4F4:EE_
x-ms-office365-filtering-correlation-id: 9a270dc2-228d-4572-7f55-08dedb3153b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|3023799007|4143699003|56012099006;
x-microsoft-antispam-message-info:
 0fQ7HCNB7LpJMasIBW4nIg4FJMu982RzxpAdlzBZxyaab41ma40rn4rJO/ntUdb7GQtV2NxR9/V/evKyDE53bXvTEot+mkpR2f531Mbyk4sWXFsSQ5y+KUgGqZs4+X4qeeNp9O/YnM9KLvK11c0Shrw1hU6ScBgjqPLcQwGmOfnw+EGMNwrsBp1JNr8LCHWT2pYq2eeLk9dKeUUc0tGP+mj+GHoF9cnRACHcYJek8reMrV21eJ+Bvn5x9brNsZmX9JmsAqQo2JpzvJQG9LMW2HrHlKK0D110oIS4f+n+doKMf3z5QrlZvSZNZjU3HR2OArH80xxYWZ9K65nrCEkI+XEYRt6MTLnu6cuPB45XSaHnBe1niA3DhX8jamYm8/DjvJ51PUQ6kZSSV12kaBMLysgm7Pg1LEjZfZsG8DmQPAReUaPUsceTTOF+FfrrcjmRge44eEEPu5ySo3af1wiKWNjdTXbO+PVlJ1l9c2Md6syJD/P5YaKUp2cBzKOm6c1MOqCjvqLPS9jmfknPkwDH9+y8a1A10LsJFHsvol2KnKQ9JN5AFAheZPtckHTn0qeVQaJEBjton8VlmCHCtTfKWOqSXNbA+Kg6S0pHcVJxWgjPodlAnTazz7Vckd+0T9VZbdDMV5GelnRTeGbjjhVKi9RrUJnK8F+k+RYQeclbEEz1qeuUPkPSLKGJjk8hPpuk1Db3/sSubxp4w9rHtP7lzbL+LOmvCw4Bs3Ye+nQI/xw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?UjB6UXhBWVhwa1p5dVM4QmlOSkZaaWRUMTZCNDZ0dXZPVlcyNlRYTTIwNXYx?=
 =?utf-7?B?N0pRc0VvQ2YwR3lFLzY2bUdJY29uY0ZYRDZPeEJ1cistSXVwMVRvNS9kcldB?=
 =?utf-7?B?YXc4RkovSmEyN2NqRlhMOUZRSkhvamhBb3EzUmJNN0VqeTdOeWVWdkJWNEZh?=
 =?utf-7?B?TmZsM1NQenk3NUp5cnJuTFBMUzk1bDVReGMxelBoWGllS0F2dEVKTklkZXNC?=
 =?utf-7?B?MDhHWklUVHdiZUlLVnNoWUhPalFzTmp1Mm90RnZUM01VTystSHVrNkZQOW9w?=
 =?utf-7?B?WmU0dE1HVEpWV3BKKy14ZWFZYnBneGROSGM5RjkzYU41SjdDMXk2elRvNVFD?=
 =?utf-7?B?L0N0MEFET1JRZVpOKy1NV3B6S2xVRkVWZ1hRTlo5dVdmM3Bhaml5a0dVazg2?=
 =?utf-7?B?cUxSbUgzaU5VbHJsd20vVUFaMHRUQy9waEpOVFpBQUZibE9VakRwcnpIYURG?=
 =?utf-7?B?MXBlZnlHUWY3Z2xYcUVvaU5SSystMldTV0ZrMngwdystSistMlRpYkpJMEZm?=
 =?utf-7?B?OGJXUEZtOUpJWFUzRElXemJjL1JSekpKMEwvMVBzYUFDeUpjTXprOGNkNC9S?=
 =?utf-7?B?eFQ4V2d6MGZ1aFlEKy1KajhRZnJtTEZSRkNubk12bEpkaTFCMUo3bkpIM1I3?=
 =?utf-7?B?RFo3V09lQWZhUGhsdjh4S0hVWGZPWFF4ZEhvalQrLXFhMXpyRUpobTZIWmZt?=
 =?utf-7?B?Z25wMFcwRGJYcEptY0c1cHh0UmdDM2lmb1NhUFhReDRoSzR5SDFJWmFHZnlp?=
 =?utf-7?B?UkNodmx0YzZBdmNpZEZmZTNpKy1ia092NVV4Vjh5S3NwTGgzMUNMNWlKZkxG?=
 =?utf-7?B?blQ4R0N0WFo1N2hXc2NYbE01Y05GNzlOS2VhODZ5dmxPTllacVRtT2xubDlj?=
 =?utf-7?B?djF4bjgxSzZ3Y0ZweTNGU1VVRURKNWdJN2c1MDV0Y0FIOHZCNUR4NTltT1Zi?=
 =?utf-7?B?WmhWRUxsSEF1d1pUeDh3a2tJSk9lcjF3Z1JnUXFLQUpiaUdSa1F4U2pMWTlv?=
 =?utf-7?B?cWlmSHF6WVMxeHVOSWVXQWdzNnJ3aVlvWmVXMmtOS1V2b3Q1cE5yNVFFd1pI?=
 =?utf-7?B?dE9xcUVPSnRPUlptdW5MelZrWnY2Tk9uam14TFE1QS9SYlZXa1NLYVhHZUgz?=
 =?utf-7?B?Ky1nS2VsRUN1UVFja2ZEQjNVT3VwVEs2bWk4Ky10c3ZvbkJYSzZkZGpNTHJi?=
 =?utf-7?B?RW9qWnVjY1hrc1QzeTFrSXZGMmQzZjVwRVFmVEpxVTJ2a1NVYzl3Wnd4MXhN?=
 =?utf-7?B?M0F5QXJJU2VQZGM2MC9oOGIvbDlzS1lyeWo1MG5jZ2Izc1NaUistNVdBL2d4?=
 =?utf-7?B?RDRaS2VLQWtaVmJlUystWDZhd1FhNGtOUXNHQ08zSDFnMmdzbnEvenpBemxG?=
 =?utf-7?B?TWxFRistZ05pTDVDdDE1NEtyUjVZdm40NFcrLXlKRWx6ejBwcTNaQ281NlJN?=
 =?utf-7?B?c2QwMnM5Y3Fxc3ZZV0FUcjE4SnQxMG15N25lb2luejh6NW5ybHJ5Nmh5OXVC?=
 =?utf-7?B?Qm1hNFRRUHdFT2I3S1Y0eFVYcTBtbXRPdUthMjFlekdhNystWVlBZms3V1k2?=
 =?utf-7?B?M3Y5VUs4aVpKTURQN3BSMzBqKy1NRnBJTGNQSXJjaElDbnBMaXdJV0RvRzQ3?=
 =?utf-7?B?dDU1NGtOZVpnKy0rLVNyZXpTOEZTQUdIR1hlZENXT2VvdDRuL2lKaCstQ3F1?=
 =?utf-7?B?ZUxNakFhZDgzbDR6U2RQZSstV3RLKy1kZmRzOE9sVDdTZzFPU1pDajZmS1h0?=
 =?utf-7?B?elZ4dmFsc3lDZlNlWGN0eTBtSE9ra29tNGxIeEVXeEk1bWJkcEZ1clFXS3dx?=
 =?utf-7?B?STlhT3c1NEJJUlBYTHhDR0tldGxRclJnUzkwOVorLXR1QkZ1Q2Joc2ZoSVlO?=
 =?utf-7?B?bGRieS9lUkJQQ2JXOFZiUXNzcHRmOXhtbWxpU2lXZTVjSGdYYmpDbkdRTUth?=
 =?utf-7?B?aC8ySTlDeENxSUozcHlwNDlxTGZhTmM4N1I5bzlLR0gzMjlaQ292eEZrNzFu?=
 =?utf-7?B?ZEsyVFVYa2E2UlZDbEJKdVJUeistWm0xQmNYcWJ5QjFBSUxZSWdBb21ML2VM?=
 =?utf-7?B?NkhtbVIzcE51NHViYkl6T3pCRW1DSFpHVzFJTlhDbU14TlI1Ky1qU3luS3ll?=
 =?utf-7?B?M0JEaUJrTW0ydDBJMlB3U0lZKy1jU29IdEplSGtPT1NJZkVTQ2pPTjBkM2tl?=
 =?utf-7?B?U09nU3NITEtCNU1OMjVFbjd2NkdZT1N6YVFEWTNmb1N1Q2dZV04yWW9rRnE=?=
 =?utf-7?B?Ky1uaDdlWDRlTW4wNERtbGx4cHltTzN2dlZraVUzZGgzeExMS1RsQWJiZjNp?=
 =?utf-7?B?cWJObDJWTU9KQ3ZsWXdnSzZlQjhNMG1ML09nbzlWRXBMM203cm01UHpBUTBk?=
 =?utf-7?B?ZndLMlJSbkFKdnVqazh1dlZjb2RSV1JRK0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FIl0aEfYS1Y3ESZq41vghl9bLPGi2Bo45zKdyOhxYl/KWibh/hY1ECvySjm3R0q2UA1prCaJkvFra4IuvqL6/uZZKzcHkf8TGy3/C1YBIw3AEgtvZd44M+oheUpKetPJFfDQlORn9WuYr6uMOY0UmzrcK9SV4gWxIzYaF6YVKYl+1C5xqPinal1iO453vVR8jSnpNnsUDAvs0rDWuzOnnYm1APIi4St60TAtQQ4FDtvrqh7lXSYFl8mbAG9E83+Z4ZD5axiH0RRQJUBb3pxstoZvWnk6rWtBX1WsrXoV1CaDD64GS42nnW7FXqWThr08ON3+x2xd4p162Gbvh1L1yA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s4/6uwBE7Ual2L7Rago4zUziiWH5iKQD/HvbcYk0dbD6TYv5bDkYtAp1r477/qvzRm88cd5KHjBMM0A57eo/WtW2wQYfKs3uOpOHpUV+5KH2encbDuPDYPlIs0Em8Cuundrg95n5Z/NFuP/2UCsjbNLB3cfbocdNu7tIN4RGCqp+/XAghJEi7Nj1haOTmRfTJSydtbCtBdFlA9nOJa13Gjpb0nTrLS1I+5+V4RqZXwBKqAH0D7ul/GvOXYJxzPdLxlWNTqsfmdoiXD185quPZ9kQxt9YQ3KROltsbLGA/5BqNxTftJByKNDEPuPLoAjCDI5rNU7PT2CgMsb7k7jT5wItTeLkA/FHloPJyoxWQjXO1CpGPbKk9YqaTvsG5wvvqTI2OJeEGEQxtO1PlaiOvITmShyJXsOHk8lzEhNOeHkV2fpBsrjIBTdTX2QoZsVUtEAEMqynvAvMgLfDTqzRfis2hijs9jV9lnDGGLNwQvYIspOkt4J/+oYYG7+rUpEwoYVDYhJ4fdri2fwJbuaXNLfvimvdFlmVGPjOzTsrCNdwOQom1avbJHGxDjqPAToeXbf4TNsw0pFMVpFEMtOdrJM+PwuZW2i9GuvRgR4jdsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a270dc2-228d-4572-7f55-08dedb3153b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 07:36:43.7212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6XgDvcIIzdiXJLlq/161Wz3Obt2Wom0S6LrmORRz9Y6pSiIENp3ynUL879UlWLNODiGfv849/ZnfNWx7IsiZ20zD2KR56zpjdSrketwNGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA8FAAE4F4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607060074
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3NSBTYWx0ZWRfX+zsNL3gIid9t
 y+KKr7g81UxQm2/8SDeLL9xC08zs/4g6sLGSXG5Xb+Z5M5yIZOeKPmKNUcvqMnmm96U9JQWL2bk
 cxxPztxFFe/ykg2cFg5JcjRZohvZPgO1KZcVpKFsrwOgmYFHh6x4
X-Authority-Analysis: v=2.4 cv=QP1YgALL c=1 sm=1 tr=0 ts=6a4b5b10 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8
 a=VwQbUJbxAAAA:8 a=mQvHCebiAAAA:8 a=BXszkKfDAAAA:8 a=Fofg-9D3AAAA:8
 a=c1PdSmG1AAAA:8 a=irpPve9U0GsHez92EVoA:9 a=avxi3fN6y70A:10
 a=ZE6KLimJVUuLrTuGpvhn:22 a=wsrb8zZI_WQ3QAEBCXTy:22 a=duu7wrcty9prphiCz_fF:22
 a=Xbaoi9ZUBzzYp91LqZJF:22 a=4iM0TfZbaBQr0p37pvCp:22
X-Proofpoint-GUID: yPglGI_QeGXV___NyV1xhaV6jJ_9D-p2
X-Proofpoint-ORIG-GUID: yPglGI_QeGXV___NyV1xhaV6jJ_9D-p2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3NSBTYWx0ZWRfX0JS0YXzyKr99
 HZZLfHX7tyoZVdWj2Ay0XmFJftsTNTFlWzGhG3xKvAHLCCj2a1rtXGpFpifXgOnsHQpEtWdflRv
 FbG52BkyE7wfQVWBTVW11KhBVlJR8exlhzfCgfBK+9Yf37xX/Kwy7msU/4zwubN/JvtIe2ig24K
 U4I03IXQ3khEXW80XUAsKHWXJa6xnBu6XHT0SbW8VPsq/tRn3ZfUSnclZIcTpZZX2wFyAmJ6Uoe
 zVm5v0sVz13IPJwyMbv+lzcyaScgs/8+95nACt6clsFTKJ3cC86bOU6nxR4tyxmpQTjD1XYD8SH
 tFvvdfP/7OCIgiD9FzdhDs9wtNWbXusyAQhe0L4nHhTPBk3QxFJoZbdBFPrRknorm+GowKIf726
 Gf6yW5XESllECSQsNSl9FKJAVQYogFjivut1iOpWLnwfJSc6hARD0Sq4P3ETnZ0F3ZxdB6VHun2
 Hlor1GnfLDHnTNfPggQ==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22791-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:manjunath.b.patil@oracle.com,m:anand.a.khoje@oracle.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B317770E0A9

Oracle Confidential

Gentle reminder for reviewing the updated patch.

-
Praveen.


Oracle Confidential
+AD4- -----Original Message-----
+AD4- From: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Sent: Monday, June 15, 2026 10:52 PM
+AD4- To: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4AOw- yisha=
ih+AEA-nvidia.com+ADs-
+AD4- jgg+AEA-ziepe.ca+ADs- leon+AEA-kernel.org+ADs- linux-rdma+AEA-vger.ke=
rnel.org+ADs- linux-
+AD4- kernel+AEA-vger.kernel.org
+AD4- Cc: Manjunath Patil +ADw-manjunath.b.patil+AEA-oracle.com+AD4AOw- Ana=
nd Khoje
+AD4- +ADw-anand.a.khoje+AEA-oracle.com+AD4-
+AD4- Subject: RE: +AFs-PATCH v2+AF0- IB/mlx4: delete allocated id+AF8-map+=
AF8-entry while sending
+AD4- REJ
+AD4-
+AD4- Confidential - Oracle Restricted +AFw-Including External Recipients
+AD4-
+AD4- Hi Leon,
+AD4-
+AD4- You had earlier asked for the kmemleak output for v1 of this patch.
+AD4-
+AD4- This is not expected to show up in kmemleak output. The leaked
+AD4- +AGA-id+AF8-map+AF8-entry+AGA- is not orphaned from the kernel object=
 graph: after allocation,
+AD4- it remains linked from +AGA-sriov-+AD4-cm+AF8-list+AGA- and is also i=
ndexed by the driver+IBk-s id-
+AD4- map data structures. Kmemleak reports allocations that become unreach=
able
+AD4- from scanned roots. As long as the driver retains a reference to an
+AD4- +AGA-id+AF8-map+AF8-entry+AGA- in those live containers, kmemleak wil=
l treat the object as
+AD4- reachable, even if the CM protocol lifetime indicates that the entry =
should
+AD4- have been deleted when REJ was sent.
+AD4-
+AD4- -
+AD4- Praveen.
+AD4-
+AD4-
+AD4-
+AD4- Confidential - Oracle Restricted +AFw-Including External Recipients
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Praveen Kumar Kannoju +ADw-praveen.kannoju+AEA-oracle.com=
+AD4-
+AD4- +AD4- Sent: Monday, June 15, 2026 10:48 PM
+AD4- +AD4- To: yishaih+AEA-nvidia.com+ADs- jgg+AEA-ziepe.ca+ADs- leon+AEA-=
kernel.org+ADs- linux-
+AD4- +AD4- rdma+AEA-vger.kernel.org+ADs- linux-kernel+AEA-vger.kernel.org
+AD4- +AD4- Cc: Manjunath Patil +ADw-manjunath.b.patil+AEA-oracle.com+AD4AO=
w- Anand Khoje
+AD4- +AD4- +ADw-anand.a.khoje+AEA-oracle.com+AD4AOw- Praveen Kannoju
+AD4- +AD4- +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- +AD4- Subject: +AFs-PATCH v2+AF0- IB/mlx4: delete allocated id+AF8-ma=
p+AF8-entry while
+AD4- +AD4- sending REJ
+AD4- +AD4-
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
+AD4- +AD4- Some REJ messages, such as rejects for an inbound REQ before an=
 MRA or
+AD4- +AD4- REP was sent, do not have an id+AF8-map+AF8-entry because their=
 local+AF8-comm+AF8-id is
+AD4- zero.
+AD4- +AD4- Timeout REJ messages are handled in the initial lookup branch, =
but a
+AD4- +AD4- lookup miss there must not fall through to id+AF8-map+AF8-alloc=
()+ADs- such a miss
+AD4- +AD4- means there is no existing mapping to translate or delete for t=
he REJ.
+AD4- +AD4-
+AD4- +AD4- Commit 227a0e142e37 (+ACI-IB/mlx4: Add support for REJ due to t=
imeout+ACI-)
+AD4- +AD4- added the timeout REJ case to the initial branch so an outgoing
+AD4- +AD4- timeout REJ could reuse the id+AF8-map+AF8-entry that was creat=
ed when the
+AD4- +AD4- VF's REQ was multiplexed. Reusing that entry is the useful part=
: it
+AD4- +AD4- rewrites the timeout REJ local+AF8-comm+AF8-id to the same PF-v=
isible ID that
+AD4- +AD4- was sent in the REQ. If the lookup misses, allocating a new
+AD4- +AD4- id+AF8-map+AF8-entry does not help because the peer has never s=
een that new PF-
+AD4- visible ID, and REJ is not starting a new exchange.
+AD4- +AD4-
+AD4- +AD4- Keep timeout REJ handling in the initial lookup branch, but ret=
urn
+AD4- +AD4- before allocation if no mapping is found. Handle the other REJ =
cases
+AD4- +AD4- with the same lookup-only behavior. When a mapping is found, tr=
anslate
+AD4- +AD4- the local communication ID and schedule delayed deletion, as is
+AD4- +AD4- already done for DREQ and for received REJ in the demux path. W=
hen no
+AD4- +AD4- mapping is found, keep the existing pass-through behavior.
+AD4- +AD4-
+AD4- +AD4- Signed-off-by: Praveen Kumar Kannoju +ADw-praveen.kannoju+AEA-o=
racle.com+AD4-
+AD4- +AD4- ---
+AD4- +AD4-  drivers/infiniband/hw/mlx4/cm.c +AHw- 13 +-+-+-+-+-+-+-+-+-+--=
--
+AD4- +AD4-  1 file changed, 10 insertions(+-), 3 deletions(-)
+AD4- +AD4-
+AD4- +AD4- diff --git a/drivers/infiniband/hw/mlx4/cm.c
+AD4- +AD4- b/drivers/infiniband/hw/mlx4/cm.c index 63a868a3822f..202fd5365=
e35
+AD4- +AD4- 100644
+AD4- +AD4- --- a/drivers/infiniband/hw/mlx4/cm.c
+AD4- +AD4- +-+-+- b/drivers/infiniband/hw/mlx4/cm.c
+AD4- +AD4- +AEAAQA- -315,14 +-315,20 +AEAAQA- int mlx4+AF8-ib+AF8-multiple=
x+AF8-cm+AF8-handler(struct
+AD4- +AD4- ib+AF8-device +ACo-ibdev, int port, int slave+AF8-id
+AD4- +AD4-               id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-cm=
+AF8-id, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4-               if (id)
+AD4- +AD4-                       goto cont+ADs-
+AD4- +AD4- +-             if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM=
+AF8-REJ+AF8-ATTR+AF8-ID)
+AD4- +AD4- +-                     return 0+ADs-
+AD4- +AD4-               id +AD0- id+AF8-map+AF8-alloc(ibdev, slave+AF8-id=
, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4-               if (IS+AF8-ERR(id)) +AHs-
+AD4- +AD4-                       mlx4+AF8-ib+AF8-warn(ibdev, +ACIAJQ-s: id=
+AHs-slave: +ACU-d, sl+AF8-cm+AF8-id:
+AD4- +AD4- 0x+ACU-x+AH0- Failed to id+AF8-map+AF8-alloc+AFw-n+ACI-,
+AD4- +AD4-                               +AF8AXw-func+AF8AXw-, slave+AF8-i=
d, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4-                       return PTR+AF8-ERR(id)+ADs-
+AD4- +AD4-               +AH0-
+AD4- +AD4- -     +AH0- else if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- =
CM+AF8-REJ+AF8-ATTR+AF8-ID +AHwAfA-
+AD4- +AD4- -                mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+A=
F8-SIDR+AF8-REP+AF8-ATTR+AF8-ID) +AHs-
+AD4- +AD4- +-     +AH0- else if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ-=
 CM+AF8-REJ+AF8-ATTR+AF8-ID) +AHs-
+AD4- +AD4- +-             sl+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+AF=
8-id(mad)+ADs-
+AD4- +AD4- +-             id +AD0- id+AF8-map+AF8-get(ibdev, +ACY-pv+AF8-c=
m+AF8-id, slave+AF8-id, sl+AF8-cm+AF8-id)+ADs-
+AD4- +AD4- +-             if (+ACE-id)
+AD4- +AD4- +-                     return 0+ADs-
+AD4- +AD4- +-     +AH0- else if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ-=
 CM+AF8-SIDR+AF8-REP+AF8-ATTR+AF8-ID) +AHs-
+AD4- +AD4-               return 0+ADs-
+AD4- +AD4-       +AH0- else +AHs-
+AD4- +AD4-               sl+AF8-cm+AF8-id +AD0- get+AF8-local+AF8-comm+AF8=
-id(mad)+ADs- +AEAAQA- -338,7 +-342,8 +AEAAQA-
+AD4- +AD4- int mlx4+AF8-ib+AF8-multiplex+AF8-cm+AF8-handler(struct ib+AF8-=
device +ACo-ibdev, int port,
+AD4- +AD4- int slave+AF8-id
+AD4- +AD4-  cont:
+AD4- +AD4-       set+AF8-local+AF8-comm+AF8-id(mad, id-+AD4-pv+AF8-cm+AF8-=
id)+ADs-
+AD4- +AD4-
+AD4- +AD4- -     if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-DREQ=
+AF8-ATTR+AF8-ID)
+AD4- +AD4- +-     if (mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-DRE=
Q+AF8-ATTR+AF8-ID +AHwAfA-
+AD4- +AD4- +-         mad-+AD4-mad+AF8-hdr.attr+AF8-id +AD0APQ- CM+AF8-REJ=
+AF8-ATTR+AF8-ID)
+AD4- +AD4-               schedule+AF8-delayed(ibdev, id)+ADs-
+AD4- +AD4-       return 0+ADs-
+AD4- +AD4-  +AH0-
+AD4- +AD4- --
+AD4- +AD4- 2.43.7


