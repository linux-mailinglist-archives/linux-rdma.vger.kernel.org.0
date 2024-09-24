Return-Path: <linux-rdma+bounces-5068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF3598486E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7181282F95
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2754BD4;
	Tue, 24 Sep 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e5GEOOHF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qs+mlt1H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EB14012;
	Tue, 24 Sep 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191058; cv=fail; b=CYfJBH4zOUrWmk/JvjET4JjbkfAuhy5uX8371umc72x6MOOe1jrUV1mUCjP/NgY5ama4STq4jTk1XQKItndcZ7ayce47JlC2+X0XQ9azPvEKWQBsg8AvumXOVTbw5GEAFybvQCsCw6HQ3yveSz732wSzxiAygMc8ha8MBh8JONM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191058; c=relaxed/simple;
	bh=Gcgf4yOUTtJaSdMr7jIPUkqfvjmRdhUIDekXHztJpfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+yAf4l6XP23sxfBmP/6ny2K5nUC/FG1jk+LLMWH5zo7qEXMDBztD7oihwWHj1qLs+S/dPOtFlCcIJw/jQT4NTYlCVRVIJQ6Qey3uL4G3aQlfl2PIaEdpPuIbHnkCbd165qYfBoXa6PpVAkOLxIGxELzvilUQfv4oE69lJMJui0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e5GEOOHF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qs+mlt1H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQXKB007281;
	Tue, 24 Sep 2024 15:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Gcgf4yOUTtJaSdMr7jIPUkqfvjmRdhUIDekXHztJp
	fY=; b=e5GEOOHFaiYMMpVUsCn67tMpCe5XtsretqsLUY/hOMW/BhhM0iikY8WbD
	v32yYSETirEz99JwiU9lX6NBjj4zgEwVMPhKdoDaxRVoB+TISt4WwCagY3E4xfBX
	6/ySecgZfIdnwLPiOtqzhd97FxXkqakO86OVmN736VZqnKgFrvloHT2cBI/ErTdY
	txMFtt3hsgDnoDpNn5k/GMf5YKU9XXx0LVpSaGTRSKFj7/FlV+8ejK4PUcUalyQB
	Fq2ZMLEQZxviL0Pij80RZw9k6koPtwp1aeUUPlYbZSjDH5tv+ljIS3f5qvCmqCH/
	ndI1SoBa9m4ECg4ORP4HVz5KONj6g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1afqgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:17:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OElmM4004820;
	Tue, 24 Sep 2024 15:17:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9d9t8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t55NQE0XYS6mIsGLqdVZjeMOoCLulMcdAlFIEv7L1hRPWMOwCpfNm6/ja7Z6T6ZnHttH8WmtXOJx1aPAqqDVTiLLmQ2qRSolpCH+rKYNd7VMU8Ee8aqNt+ifTsv/pggCg9Kt90e7Kx8ingEdjN50+tk26peX+1Lk0ORmDxXY5PDvi1Y8/QB4xnYB+7yB85CQaIJrt9Y0QMWlpXzTq5Rard3ldxtIEFkdEsR4e+RotSTXChfY7ubO9zHqo960rJrer/CZEbOVLDg9MwT/8x6aLmghC6Drwnp7EOYx/7cIPBCehn8djabsqa7b3C5fyn6+wISh4tG+31rftQFto2BErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gcgf4yOUTtJaSdMr7jIPUkqfvjmRdhUIDekXHztJpfY=;
 b=Azi+LXmzqNcQ6XVnoyVTNKF1WhjNyDAsMzk2O0TQbyr0ytKVNHg5bqvtYaDK8eu2jcJPhhVn7B5cBxoSAYX0d7skHjutGhPM1kSAE+Cd9p2hP5jZRVe35fV/jAX50ai/FK/M/+9AeyjznwTIV3rmexLmMQMkxFypZHgQwECTYpAwnhEO4qBEV9Dz095l2ReLr4sN4bszlw7hmHyOl6xz39xJ4SXx+PC6VcJZft3+v1WGBINqytpVzzodwQFV26Tbc/TlvdWlm23ZArx3DOL1sloJDrs8WH2yLjeLAQXq7ytIjVpsQ0q2UQT08SjVPj1TL0lSBmXm5UW471ycVXiuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gcgf4yOUTtJaSdMr7jIPUkqfvjmRdhUIDekXHztJpfY=;
 b=qs+mlt1HQjBNRo4VTTF9pH3O6ViHrA1rAn+lmzY2gBnm/TYwwqlwvKzrIODM/7eXh6PMtPVpPDV5VOmI1OcAyijg5pdR023gXyDPQbnUSQz5q/6qyd4rytgBqfhnR5jgFuIT/syr09Se9nnvhvAEM0fTvOWwY8Qng61LdxZ7z70=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by BLAPR10MB4818.namprd10.prod.outlook.com (2603:10b6:208:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14; Tue, 24 Sep
 2024 15:16:56 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%4]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 15:16:56 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Allison Henderson
	<allison.henderson@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Topic: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
Thread-Index:
 AQHbCp7A0vkWwunDUUiiivGPdE4MvbJgbooAgABEjgCAANOkAIADxSWAgADpWwCAAFK9AIAAdtsAgAAVd4A=
Date: Tue, 24 Sep 2024 15:16:56 +0000
Message-ID: <66A7418F-4989-4765-AC0F-1D23342C6950@oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
 <ZvFY_4mCGq2upmFl@infradead.org>
 <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
 <ZvJiKGtuX62jkIwY@infradead.org>
 <1ad540cb-bf1b-456b-be2d-6c35999bdaa8@linux.dev>
In-Reply-To: <1ad540cb-bf1b-456b-be2d-6c35999bdaa8@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|BLAPR10MB4818:EE_
x-ms-office365-filtering-correlation-id: a469389d-2396-478c-b842-08dcdcabed9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEtLL2hpdFlOMTBDSjFMRk5EMkpMYWFqQitDUUdTdXpJVVhib0FSMy9keHhS?=
 =?utf-8?B?N0x2WjlLQXZWeWF4L0Fja01zbVR4MnFmQUtpYnpBQy92MXc4c3pzM2JIYk0y?=
 =?utf-8?B?cm8vWncrVjVZVGFMbmEvOWgreXorSGo1MGgrVWYyWmZ5a1dYRkM0K1JodlBs?=
 =?utf-8?B?Tno5MThUd2oxZG9lK1dhM1drNWVSRjloZDVVNTFyNGNScWZQOFV1WWRtYkNI?=
 =?utf-8?B?K3JlRlcra2VqMkJrSDkzYzF6OS9KOFJ6L0VqdFovV1A1cHRuUlNLUlVSZWFH?=
 =?utf-8?B?NmhBV1RwQWJSWTBnc2tFRGR0N3Y1U2xMaWFHTkpBVnhqOTd4TFFLTjJuTU16?=
 =?utf-8?B?WDhqRWZPMWw3N3Q0ZGJKZ3c0VThxd1I4QnlBbjF3TGJpQ3BRM3l6amlLdFJL?=
 =?utf-8?B?ZEpPdE9VemxJclZ1K21KUHJhTkFDWDJLTlUxd3dMLzAyRTRiU1I2SVFZUnpV?=
 =?utf-8?B?RUVZcFFJQkJtZm5VRDZxcGpudmRKUVpXMHR2L3RFbllOZ2sxQjdIY1hYbEVt?=
 =?utf-8?B?TXBLNHlsNXRRR1hmNzB1dFJOZ292M0JoRzBxL1J5M2hDdWw2bERmZVZzN1lq?=
 =?utf-8?B?N0ZyNzhlU2hLdC81S0xOMVBFb1h5TTFoUXcyUFQrT3dYRDFmWFNQMXpJRjlF?=
 =?utf-8?B?OFNWSkQ4NGtiZkYybklSTUtSbUVpakVjL04yMGZSY1o1MGdicFhGNU9SNUdu?=
 =?utf-8?B?aFZyTVlERkkwVDl3NE11Ym45cVh5SW5lbkRTd0hTMEw4RUUzN1JNQ3EyK0Ns?=
 =?utf-8?B?Qjg3TllBY2ltalZ2YTFaRzE3blptaU9LTDBXZTZMZG44QzQ2SCt1cFZoc2RP?=
 =?utf-8?B?WkpRR3ZSeGFrZVE4dHI2S3pnUlY1Z0MweHdySDJkOTh0c3FVYWlvaTMyRWht?=
 =?utf-8?B?LzZpQjNkVkhGdGc5V0VSZWEyRGlMTUIzVmhIcGUxZVZIRTU2ZU5wYThLbHZB?=
 =?utf-8?B?djU1RWxaTUVHamVrcGc3djBUeUttbmI3NDdUTGRwRG90RHBCS1FzdnNhSTBw?=
 =?utf-8?B?MnFuOThqR3hnNHFsenluSXlCSHQxN29TcVY1VHBxalF4b21MVFlWUzB0WUVk?=
 =?utf-8?B?KzlHNnF2N0pSbDk3ay9zcnhUWS9XY0NGZjJkOGlzZ1FGQzNZVFNpeUtLRFY1?=
 =?utf-8?B?bzFDUU13TXlNcTR6MWRIdDZMY243U0w3dVZWTERoQ1IzNlJjNVJHRnlBcFpC?=
 =?utf-8?B?SWZBOEZpZ0F4anhPdE5CZGI3dzFURzI2a215RDg1MzNxTnRHelRTKzBhY0d6?=
 =?utf-8?B?dTVacHJXNUFKY2l0c3JRQk9JbEo0WlQ2Zkt0THl1OS9QK3NxRFVFWUtKYjRs?=
 =?utf-8?B?ZFcwRXcyUTI5T3RaK2FqNlRQcWlnRDlNOEZlZ1RCTkRFNnlvbGJ2aCt3VGky?=
 =?utf-8?B?N1piY0RkSVRTVTRFWmdYSUZUeTNkdk9CSmtpWjRQNWN6QjU1TG9DOHNEWnIv?=
 =?utf-8?B?SitJUnVKallUWGtRZ1JsZWVTR094QjFoQjJ2NFNKcWt5N245dTd1dVF3MGVY?=
 =?utf-8?B?QVRyZ2J6RDNEc0hXQ01FSEkybHhzME95R3Rnc2xIZ2JzdUJkR3ZsTlRUNlNs?=
 =?utf-8?B?eE9EZDlxd2hqTzhpc0x6ZmRyY1JxenVLbzZadE1iTmlKcU1QNDZ4bTVkUVMz?=
 =?utf-8?B?a2tJQVh3WkJ5dlEwU09JanRUWEt4M1pSNjZEZ1lRMTh4Vm5GVTBFYThSTEdI?=
 =?utf-8?B?S21tNC96WVg5clljYldSWUZFMjRocit2Y1lmaS9HalV5NkJMMWJtUmFaK2F6?=
 =?utf-8?B?WXJTbGRsTnlFUUJENHNFbS92SWMxWjZXWmZJV2N6UXdRQkV1VmNJcmIwVmVH?=
 =?utf-8?B?Z1RJc0w4YnRtajBNTDV6dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUI1dERPZll0WTd5anVqKzVKQ2JUc3VQd2wzc3AzdEppL2QwcDJFN2twaGEr?=
 =?utf-8?B?ZnBmR3RENG15Zk91ak01YUM1SHQvckl0aitsVUt0Q3RoM0RUcVN3dElqUVdy?=
 =?utf-8?B?cDNMWmxFa3JySzhlQXZzQjUwVjY4dDlqUkRQSDdHa3NMb1hxNlV3VU5ZRjUy?=
 =?utf-8?B?REpGc0pNSmxEUHhKbitiQXlNbEdCdGc3dE02cmZoenZRblNjKzhERjY4ZWl4?=
 =?utf-8?B?MVQ3aTlnWE5BS3JiL2svT1RjeVpXZE5oamIydFlEMWRxUEc0UmVzenhGWlpH?=
 =?utf-8?B?K3l3dnk3dWZKUzhFVWdYK09vU20zaFFXRnc4MTAxRlhwcDNTQ0JRdWwzYjY4?=
 =?utf-8?B?RFRQcDBES3E2MEJNeHJXYTJYVmpHN0tQRWkxUklnZmpxbXBuTDFjTHdodHZN?=
 =?utf-8?B?Uy9CYzJUd2kvWGVOSG9EWm9OUzh6TlZWM2JkNkQwSTV1WjZzNWRpQUFhc0xR?=
 =?utf-8?B?ZmNOZzVoVGhTUkFodG9Vcyt5VjdaY1JVQTJ6WURtaU5QRnhXL3pkTDNMRHdG?=
 =?utf-8?B?UlZGMG9UaHhpOUxIMk0xcFZUZWh0cW53eVB0SW52VlZ5NEhSUC8wS1N4bzZr?=
 =?utf-8?B?SWhucWRDVFhyOUZ3S3lsSlAzLzMrcmYwZ3dIMEdsMG9UUW1uU2RCcnJRaWVU?=
 =?utf-8?B?RmVOdGxjVWlDSlhpaXJrZ2VXNk5naXRWQ1hadU96UDUvMjRqWUF3dUVjcGJ2?=
 =?utf-8?B?Wk9xalhLU0NSTlZrRC92YW8rMVM5NTZRdStvK3BYRUlXaVNYWkVMNTNsNnFG?=
 =?utf-8?B?aEcrY2hjZXBjZjZGWk9pc2lTYW1DNCtjMHBUV1NsSnUwdnUyM1JtdlEwZkkz?=
 =?utf-8?B?S3dhQVpTYlN6Q1ZNTTJWUGNYY2xMVUtUakJJVm9kY2M3TlRIR2o2aHJtOWpF?=
 =?utf-8?B?WUU1WVdKUDdSRFdlTUhUNnpQNUdFK2xMNFBCTHJocmx3a3BGQWYxZStZbnMy?=
 =?utf-8?B?OXN3M1B6ZWY5RnJtTmZoMHdvWllDMWxiempjTTBJdG84VnVwRlZnTmk1Z2dr?=
 =?utf-8?B?QWh1ZlBwT2NSczlxZTBOMXFyVU1aSXNJeWM3d1dXVlZ6MnpMb2d6Z3pLY3A0?=
 =?utf-8?B?RFpoL0RBb1BtbjU1UUJKWW5WSFBCZ3BIUnY1cWwrLzFIaU96SnVDN1hmSnVq?=
 =?utf-8?B?UW9WZ3h2RGdaLzFidWw0ZlFBVEYzS21hRDhKODJmNjhnNFRINXgzNlB6WkIx?=
 =?utf-8?B?UUZ2dzViZTY5dUN1QSs0TnhKdU9RNlFjcmZGaksyYXZvQXZpZkJXQmxnQlpV?=
 =?utf-8?B?WDJzRjhnQVcxaExmMUR4eDFqRHFhL3g2bnlYbURpZXVmZlJDNmFjQ05yZzcy?=
 =?utf-8?B?VS83VTJGdThiaUx5WDN5OWoyeVo1QWs0WFNyRmZRRUdpZERON1k3N2dmRjl5?=
 =?utf-8?B?aVNoZXpyMml0SlBiVG9xN1h4ODZ4Z2R0Sy84YXVxYkpCSG1DUi9QQ2lyMEZ4?=
 =?utf-8?B?TDI3RTdBNi8rUVYvRFB2blI5NXoxRWJMOFd4TVRFSk5PVXRXaFlYb2ZBTUtD?=
 =?utf-8?B?MmFyaWpTblB6MllZV0R0eWFiY0x6eFpBSUc1WHFOa3QzRkFIaGw3bmJmRVNI?=
 =?utf-8?B?K3lyS3ZIWHVZSWU3anlLY3VjVkp5TWFPWU0yNVZGdkxOcTRKWWVCdUZlVmdU?=
 =?utf-8?B?WVNETDJXTmJpajZwT2FZcE9kdFdpYXNNSWxxYmRUcGM1cVdvbFF2UldnY0tM?=
 =?utf-8?B?VG9RK0o5cGVXeWZoTTB2Z3RveFVZVHIrWXNMeFZmeUhpbFg2Q24yMUVYdjBS?=
 =?utf-8?B?czM2S2ltR2tZRUdDZHYvRVlCaWQrY29LeUcwbVI3KytNaXZWNVVERTNHNGRN?=
 =?utf-8?B?N3VEU01GY3MzV2dQdTFXOHZ3UHB0SDZKVFhocURMOVN2V0xFblo0OHRzUTAw?=
 =?utf-8?B?SWQ4bDgvTTBUK2xrZm9KMlo4dkRUQ0E1akhNRnE5dVQ5QS9jejRBRVJUZEhV?=
 =?utf-8?B?bkwxTGYrMDNPQmFrVWFkR0kyQUhtYW9SREZOeHJJenBqbGE5YVdkVkFnS29w?=
 =?utf-8?B?ZjNKOUdlbi9oU0JRRStqUFdtMS9PVW8wbUYzNEN0QkxWRm0rL21XZXlMazZR?=
 =?utf-8?B?dlBEajhSRVJqZ3pHSFpaT1lIZ293a1FMU3A0YVRtNlhJTUdUV3l5blBaK01V?=
 =?utf-8?B?UEpoZU1KRDhrZUlMd2JFbGgvRm1WaXR1Z1VCQS9jclAzaUsydDV4UC9EY1FC?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9884E5487907794A8C7DD6B1A0DE19FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xopk9BfypQuFtjTBPMj5djWmwKLdyTeN/z+zEuKO+hz+q4IidE/zLpPPhdfXK+9l69oQ6r72M6lQkIHcPlTQata4COpVV/34MpSriIlzW5Bt4gb24MDuPg+x4I/Jg24xi6XyjduIY3bxK8zcmSic9RbKoX2C+IBEHo5wk0WV0xLk+N81h4k6xzml6rhyI3r21lncyvXIrdsRaF8ZCjPSoyeNLr3D1NdN7MnN02LQPHX5m0c+oUXno4eHla3iGlzX0rRMS9Kt6qVPlV4/tbn2BJqqFlvFeHjrEpwwpLQhkGKBee7QdGePx1OQNwgUznTIWcLMznq+xILiMwxXhY/d0/+xq7RymjEKVnJq0nMl+60At9mDF7HgQsvaoaiAYZPQlJqEgQhahH1GZQEPDgs+pE2BEbWiNxtfmdzgBVlU7yluh7JvwhHE6RFlJC/ax0/4QHFdnIDr0Y+kBCj8wXgkfRs/5Pa7jDnp8uWZC3xvdpIp8JO/6d09pGb8LQgeUe2USDilFb77RCz9JNnKTFR2PU3SZ1c/EsIzYh0ur3mLcMmoDITVDV/stqqixL0gBE8iC7SDsyaMNKqdmwNnwPEJ1kMV663R9UCP1staoIXJ0fI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a469389d-2396-478c-b842-08dcdcabed9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 15:16:56.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6tVB3cwtnUa2rU88WOwNl0MnrGVsyg9gpH99YWArhbzIw6XVWRBV4d4exSAq3qZ7djFR6bp/Pm9W4tCCMzLFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=990
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240109
X-Proofpoint-ORIG-GUID: Mo29Tz7XQfua_tsrhAQjsouIY5qnOJ0r
X-Proofpoint-GUID: Mo29Tz7XQfua_tsrhAQjsouIY5qnOJ0r

DQoNCj4gT24gMjQgU2VwIDIwMjQsIGF0IDE1OjU5LCBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxp
bnV4LmRldj4gd3JvdGU6DQo+IA0KPiDlnKggMjAyNC85LzI0IDE0OjU0LCBDaHJpc3RvcGggSGVs
bHdpZyDlhpnpgZM6DQo+PiBPbiBUdWUsIFNlcCAyNCwgMjAyNCBhdCAwOTo1ODoyNEFNICswODAw
LCBaaHUgWWFuanVuIHdyb3RlOg0KPj4+IFRoZSB1c2VycyB0aGF0IEkgbWVudGlvbmVkIGlzIG5v
dCBpbiB0aGUga2VybmVsIHRyZWUuDQo+PiBBbmQgd2h5IGRvIHlvdSB0aGluayB0aGF0IHdvdWxk
IG1hdHRlciB0aGUgc2xpZ2h0ZXN0Pw0KPiANCj4gSSBub3RpY2VkIHRoYXQgdGhlIHNhbWUgY3Eg
ZnVuY3Rpb25zIGFyZSB1c2VkLiBBbmQgSSBhbHNvIG1hZGUgdGVzdHMgd2l0aCB0aGlzIHBhdGNo
IHNlcmllcy4gV2l0aG91dCB0aGlzIHBhdGNoIHNlcmllcywgZGltIG1lY2hhbmlzbSB3aWxsIG5v
dCBiZSBpbnZva2VkLg0KDQpDaHJpc3RvcGggYWxsdWRlZCB0byBzYXk6IERvIG5vdCBtb2RpZnkg
dGhlIG9sZCBjcV9jcmVhdGVfY3EoKSBjb2RlIGluIG9yZGVyIHRvIHN1cHBvcnQgRElNLCBpdCBp
cyBiZXR0ZXIgdG8gY2hhbmdlIHRoZSBVTFAgdG8gdXNlIGliX2FsbG9jX2NxKCksIGFuZCBnZXQg
RElNIGVuYWJsZWQgdGhhdCB3YXkuDQoNCg0KVGh4cywgSMOla29uDQoNCg==

