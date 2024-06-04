Return-Path: <linux-rdma+bounces-2855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3938FBAF0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FC91F21CA0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27F149DFF;
	Tue,  4 Jun 2024 17:52:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA083CDC;
	Tue,  4 Jun 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523524; cv=fail; b=MjuTZYiQsvDOLTqMZDKNSkscaDaKe8PG4FW3/yYfUX4j1agxZ3omtDtJlFIA+bMtZg09U4wi8QVojbib0IkSjPeWiBq2TnhHs1KsjCip5xHjs6FrXgupuk494R4NJ175dJCl2oRqxTkW5j6gcFFtEoKDOigvHvCisORMB6VGeYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523524; c=relaxed/simple;
	bh=NhHG2Rc6xVChDI7rIZ1UYKokR1moVPYtuHLu+OVmpQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KvhMgG8ZEECdx7hfjR2gUQHzoTxSOyv03um+NCHm38iD8/irWHXNjWcYx47PyPiHXCgAoqPUaAeGDNzN/WK0o8vdiZWXKaJb/b+TIcvcDcLVq1kd11gDf629gDKYVdN/paMZe3WSTUsDOKh4lGj/Z0YH45YcJ9uVZIwvOzgqOsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bn0C2032321;
	Tue, 4 Jun 2024 17:51:55 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DNhHG2Rc6xVChDI7rIZ1UYKokR1moVPYtuHLu+O?=
 =?UTF-8?Q?VmpQU=3D;_b=3DO1MEXOHyDjVo2n4oWQxtv7R7n8e//dT/aby8nV777JvcYvZut?=
 =?UTF-8?Q?qQFNlEqp0Jk8F/1j3ul_ALzKRPS3OgNuCoD33CI1wq8tTlSqcZ5ctbIWrqhHqTs?=
 =?UTF-8?Q?aqAlX6IoXPLvuY/x2fm8sLFiM_yNH5t1Yf37qUd0JrlbWhkS3SUyp4kLmnrYRiJ?=
 =?UTF-8?Q?kWWHmaaPkNfPm/c04gQA7NUi77DVQTM_7PeibnAfyKv14+G08+xoMzEvdf5Ebtk?=
 =?UTF-8?Q?Kru0zFd5XMXoxsVJBg5Ht5up7zrTu0QmKxm6m_4sPng4pfYJxKg6yYJr9Cp3kGT?=
 =?UTF-8?Q?XOfxgiDs8ToBbRVkTiP7n8VgUPsGp1txcm1TP81lKgZ_7w=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuyu5jqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:51:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HbgTm024001;
	Tue, 4 Jun 2024 17:51:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqx6m4s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:51:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azRm3rLK4ly5Z1X4Wv/RbgF0d5XT/MgKFzpnfjKvKpK9npMqRfdLtqYZFecOFu1Nl28iEKo3B8iEHLe/UpksgIF/VDhkCrrEtioIy+UMjkvv4RaqaerRhpFrySKSSJBaIr7RLgCXE5Ro4E5JA0MKmSmcf6mm0bciGGr/WqmxSvSL5+JLoOPpe5eVcr/cYbpmrXTMYRHxc+R/8ynHBfjZduzRpuIZZhb4shrVttqnxqUp5LBXc3NosbOfczbLbeljMxKm6x1dAvqlmES0ZglshUo81WhNav6WPsf/nJHarhO+nsGHM5jIPtRiiD/+kuQ72YE1Tw2bOdfAL4OmH4Ncow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhHG2Rc6xVChDI7rIZ1UYKokR1moVPYtuHLu+OVmpQU=;
 b=NFriHZd3AvGaQUf6y/QolJf/Qh7gV3QvtbyXCnjutpP/HpirN2lksT9J9t1WG/ZctmJv0YXKwl+M9VkJONiTWD/OPqjJFqf1hTAhfWTnFU0p4VMmqsPKnqqAIZ/eBxAadBh0yr/KAsPs8dCqIO4BT8aOYZPAOr9X04TKuwj76hMlIt7AtVcqo869jJa0r9rPg2GQhKmBDpkeSZ5FLG2nTFALVboiNLkiys/NbkRN1traxAhyzGIUXb68h2VbLqJUZhBKC3H2QQssl1+3YJ334f8RykTouwQbLj9CMZCWQSlKHF6qfHRkimzeI9SZeqnj6BNfLSLFatVzgg2xobZqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhHG2Rc6xVChDI7rIZ1UYKokR1moVPYtuHLu+OVmpQU=;
 b=Zc2cRhAEc33MHOYLYE/XvY2zIyoJ6VIb2ckwlCjcQHsng3B51g03NWE52tctCzfveim19QITeD767EiXFT53U5peTQbquDvDtdAJw25qUL+DJoDGF2YLHA9/J5Vw0X6DJ/7pHzrMxJO0rPXHgyiB/HG5mFFos6Tryzm3xO0hFqc=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by DM6PR10MB4188.namprd10.prod.outlook.com (2603:10b6:5:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 17:51:50 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:51:48 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "edumazet@google.com" <edumazet@google.com>,
        "linux@treblig.org"
	<linux@treblig.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Thread-Topic: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Thread-Index: AQHas7LpDuUuMTLMGkK4N/XjWcCJW7G36FeA
Date: Tue, 4 Jun 2024 17:51:48 +0000
Message-ID: <2442cae88ee4a5f7ba46bb0158735634fa82a305.camel@oracle.com>
References: <20240531233307.302571-1-linux@treblig.org>
In-Reply-To: <20240531233307.302571-1-linux@treblig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|DM6PR10MB4188:EE_
x-ms-office365-filtering-correlation-id: fd466872-6a98-41ee-e165-08dc84bf01df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T0hvWDVCaDF2THcyNFJvVXZrN1NIaWRzSTRzb1hQNEFkQ20xSkZoREZwWlVC?=
 =?utf-8?B?R3dKY3RGK09INUk1Wm9ZTW1DR3lwUDMrUVR0TFBxOUlFR1VsTjE5cklwZHlN?=
 =?utf-8?B?OEZHU0JRWWhsOE1ma09KUlNobHpNdlpCdHVwWFo4Vm9RTjRlMDdqbldueEt5?=
 =?utf-8?B?cmhjZE9pdUg5Yk1TSXJGUW9GMXhqOGdoVHBMTnVvRytVV1ZPZ29XaUFQayti?=
 =?utf-8?B?WTdXb0hvcWJjbldtdG5hbEU4N093Z0hTeGk4SVRjemlyWkFsWHdlQzZUWStl?=
 =?utf-8?B?NHhWUzh2bjFhK1pKLzVXallJRDdDUlN0dXdPdG95K0V6UWpvTVc2TU95NVE2?=
 =?utf-8?B?QjhpdENhTkQ2cHEwVE01cXgzLzdINmFCZ3FNTXNXQ0sxOHNmRnJibzlFa1Vm?=
 =?utf-8?B?aHMvMjlXVEhFQzU2V3RZMUQ3WGFZcXpoOWRhU3RGaFJUNmRpRXdIVmMvbDZM?=
 =?utf-8?B?REVrTHA0RzhoTmRxMjVmQWhIM053dG9udjUyVDhCRHN1UDhMMDh3QUJVcVkv?=
 =?utf-8?B?NnNhYjJic0VCZDl2bkViMHRRc0J4cmRCMUxDaElDdDlnNWdWYzJ3Z2hpVS83?=
 =?utf-8?B?c1FlUFNVMlJtVjVvU01hc3c3cTQzZzVIUElpOTdzU3lNeE9aMy9MSVkvR05R?=
 =?utf-8?B?RGZ3V0drTmdaa2F1bkhkTjN5MkFvdWJTaHoxbUR2M3JwWk10QU93L3U3QVph?=
 =?utf-8?B?VmtwNndDUmVmMzBFWi9YTjI5Q3o2MVNMMDR3eVhzNXc0NklJdUJKZEk0VGsr?=
 =?utf-8?B?UkF3NHdybVQyR283Z09KQnJ4UlVaNnJVMXVyeW5FRXdFL3FyV1pIUFpoZ1Bh?=
 =?utf-8?B?SUZHdFlJMmI1ajQzZ2hjM1VIZ2ZOVjBGN2xpTjIyYUdLZWQwUTNVV2dHTGJu?=
 =?utf-8?B?VnVLbVJ6RVNPYXF4Wm1nWXdFMVRZaTFwSDNnYkZJSk1PNDFVVVFxRi91WVpt?=
 =?utf-8?B?MDl3T0NHYVlFTHlLTGZHWlNpUWxLbWEyakN3TS9vQWFGbmt3enkwRlp0TVd6?=
 =?utf-8?B?eUtTSzFib1o1dmJXNjBRM0N3M0RXV1o5eE5ab2k0akJCV0tMWEhMZUJuSkRp?=
 =?utf-8?B?ZzV4bmR6dm5UemZUQXJ6eFVYeEJML29vT0xENjVGK0lqaENwbDAwbWt4T0tS?=
 =?utf-8?B?blRUN1NqNGxqVnc3TmJUOHFFcmhHTTNZTjNMeFVLalBYTHdSdDB3QU1ZUFNi?=
 =?utf-8?B?ZnhQbFBwd2VYQnFWdERjVjBDTVd3dkFtV2hORFArWldicnY5ZUsyTEhkNnZk?=
 =?utf-8?B?ZjFjS2RpYjd0Y2Q5dHh6U2RTdEhrUDJ1emtHbTFzblZVTVVaTlZZSUtsZHRB?=
 =?utf-8?B?N2FVbnFhNUNvZ1Y3WkUwQ3BTU25KTWhiQXl6MU1lcWhsTjZmTHU1UHZWNkNU?=
 =?utf-8?B?aXVYdTJwKytpZDRoNXRpWU5LejcxQUl3L3BPYTZxMk9Zb3RqdzdLUVpmNUR6?=
 =?utf-8?B?NXFoQlEvOGRFNDFQL3pZRjJVZEdVeEZmTHBIemZocWpBYTRqUjd6OE0rRTdW?=
 =?utf-8?B?QjF3eXptR3dHaWxldkxlT1k0Qmx5VWF0dWlpRGNqWEhzenFMNXV4UU5ERTVt?=
 =?utf-8?B?M2p4WGRiVzlYZGxKL25XMjZNdUxmNklqUVdRM2Q3RE5ndVJ0WXlvMG1RRStn?=
 =?utf-8?B?UCtBb292SjBEUmNaVWRrZ0JBNDFpNWxabk9CTFBlTzYySmZvUGhteUE0SVhu?=
 =?utf-8?B?MURib1NoK1pBa09sdjB6RU1USnZmT04wZ3EyYVhJMm5LQ3VCVTJmMFQ3VTJS?=
 =?utf-8?B?ZTRHWTZWR2pwVkkrQVRJZFo3M0pRYnpjcmdINDhEVzlsQ2RWQ043WEt5RENt?=
 =?utf-8?B?TVJwZmM2aUY5L0lWUjE1Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Uk1OQ2RZS3hJb0oxUHV4YjJLZUVkZDFzc05OU2dsUWhtY3FqMFhnM3Q1dkJV?=
 =?utf-8?B?SmczVE9ERFVQNnVUcFprbHI4dExqcW0rRFJSMmZSalVqaUFneTBiOERxSW4v?=
 =?utf-8?B?SmhkS3ZiWmRXai9QWUkvbUNuWXRsVy9oVkhjcldsSUZ4VmR0RHVkc1NCa3d2?=
 =?utf-8?B?bUU4ZVhkbzlHd3I1VnMrU212eUhPb0FRRXlEbVIwMTNpUmVEeWFHbDJaMm0y?=
 =?utf-8?B?R0dDcENER25sWTZRTzd3QS94VkpKSXdpb2J3SUFBUXVnMFBKL21Hb0paR0Jl?=
 =?utf-8?B?NlpDNElCYVE2Mmh5cEcya0d6RVd3S2dyNW1acnE0N2JsQlNrbHFhSkZWbjJy?=
 =?utf-8?B?RDVza090N3NBT0FwM212akE0R1NtSXBsTlM1aS9IMTdMN3ZPbk50N3RzTU52?=
 =?utf-8?B?dWVlVlRYYW83b01ycmhvR2ZmQ2psSVJ5SHpDZmtQUUxPSkZRa2RIU1RoZ3p0?=
 =?utf-8?B?RHZDSFZua1VuTTFUajUyNmhpS2Y0OWlzVXN6YnZmTEhxbGVLdHplVUxGMU1u?=
 =?utf-8?B?SndtZUhPYVR6cjZBVkdzVHlJQkZJRVI3cFNTbVZNQ2ZuRzRVMEs5WDVCN1du?=
 =?utf-8?B?YS90enBUMXA0ZGwzUXd1V2pzM0lkRUV0eXkwUnZ2bW1lTFdueSszS2dWSnRr?=
 =?utf-8?B?SkdxdXZyMmNva1pOVXlNVHUzdkN5emlPdUo1QmNuSkVLWU9tVGJXTTIxN0Uy?=
 =?utf-8?B?ODZ4Rlh0TXNVeDVCcGlqcDBPa0JLSERBWVZKdkx5dyt2YkQ5dmJKY1plWHM0?=
 =?utf-8?B?bFRubXpYS09Yd3ZueWc2M0duWHFrS0MyYzVUZVJLUWwwLzVGUTU3VjJCZ3g1?=
 =?utf-8?B?dEdBUEFVSHBrckZyQm9INWlwclRHZG9EOGpmUzEvZTh5ZWtjNzlqeDBvYWVr?=
 =?utf-8?B?Mkx4MGpDSGFSZDJlRm5iSldSRkhSRGpDMWxRcWwwbkxpelVoS3ovL25KWERO?=
 =?utf-8?B?ZWtWcVZYWGVhWVZmSkJQL0svc1U1SllBazNzOWZ5RlFlMndkUHlqWVVoSEVr?=
 =?utf-8?B?YlhXUHZ2dGlBeUNhZ1YxSERHQnk5aGNqWHJOdnZSbHV5V2xJM2tEalZYeDR1?=
 =?utf-8?B?VGpyUHNFR1I2cHdDcldKdGM2NTE4bStYMno4c0NueUUrTmZoZWhmcFZUOVdl?=
 =?utf-8?B?Q0piMmkrcU5vWFZETE1jSFhuRU1Ib2JPbDZDR1Vsa215TUo1Z2s2Ym9UbEh6?=
 =?utf-8?B?Tm9NczNST1llMzhWS2h0V2xEUUV1RE5wL0VpcU9Eb2FtbEt3WFp4OHd0cDdl?=
 =?utf-8?B?N0F0QnRHMlpVdDNDRnR6RFNJZ1dCZHZlS0k0cXdYUHVCaUFHZ3BESWV0eURL?=
 =?utf-8?B?a0dQK2oxUkRKZlNuZlRXU2VxSlVEMGVUblh2VWxyb2ZKa3ZLcmlUZE16YW03?=
 =?utf-8?B?TE45Z0lNTHJRR0h5N3llNzMxU3pUeS9jVVNzblI3R2tNdzM0R2RLQndWQ1dG?=
 =?utf-8?B?eEpETzA1eFp4TFRKU2U5V2FSVGE3ZzUzQVRzT3EwRkxhQ1BoTngxcm1qN3hp?=
 =?utf-8?B?T0tvZVRORDFqcFh4ZUlpWHRDTnlZNEg2WGpFSk1rV3Rwa3cvWW1oTzNKVDJD?=
 =?utf-8?B?SmRZWEl6UlcxQlRpbXlkeVhQWDRSSG5iOWRMTkF0UFJ6WVZDbVgvSUsva01G?=
 =?utf-8?B?cTdGdkJLS0NNS0hqQi9wSzgzclhjQ1VOeVdRMjhVc3JQREZUbktqbFJWSCtz?=
 =?utf-8?B?cFpxQWlHR2F0ZFZkaUlDMUlPUkJKNnc0Zis0ZzF3SjhmZWVrMXYvUUE1SDRs?=
 =?utf-8?B?cjNLU0l6clJTNkVpSmR3NUkvWmpsSTRxcW4zeXVpY3h3N092TnBSemttZEJG?=
 =?utf-8?B?WkZqaFhTQlB6Q2N0aTc2eXFRWVprZy9uYWtGcTgrbTBiSE5ZNm9oNFlZL0Iw?=
 =?utf-8?B?b0RDTjc4dDhqK0ppampUMVJKaUh5bW9SNXlmaEZIYWExcFhvakFMVXN3aE8x?=
 =?utf-8?B?SmpsaVU3RFRxUmxtS0JZZ0RKbGNyRWJGdDY5SElDSEtwSitncm53clBINWR0?=
 =?utf-8?B?dTIvd2FWd0l4MExrc3Y4UzNiYWQ4RncxdHUraG5VcEFEM2VoT2RaOUFmMlJr?=
 =?utf-8?B?QnBwZTU5TkhoM1ZYY1IxeXp5TGd2SU0rTTYxVnBJOFR2eWFjUFYrbGxDb2w1?=
 =?utf-8?B?NnhEWHlSZnA5WGxlakl3SERsd2xQZHNza29JZFk5b2x0UkNlNEZoZExTdDJL?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E39E059D9A52C442997EB4722417B96C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hUJXS+71hKyQ+ASMHMf7gS0WRTkVWWtMDWTFoL4BRenhNT5QIWB5SfPkgZ0jTzoGc+oGWaCOlB1WNUtkI/RBgjl4q5aXrkBQhNmlka8R1lCIr6dsTX/rfD8xuNVjKuUTzYBL/x9m+CHaF6mDydX1kaFpduIILaHeLbgK8+QOuysiC3sZoZhO5oVRIQLfom+PxHFLi24l5Fj8qDRJ6guOy4fkenzXLQon+yZWsZ/bFu81gTAQzCB51KlSZGWlavvBdmMOpLWcIuddjrsiSMLuCQ7//QYP2QS4naiymSHH8HFpWzyb8jeNMfTkSKyk4fmCyVwZAeufaNQlyVvEJzlkwBgwmVtPqhgRiLgsGWbQMwsW+r+uToG3WJIVzmRrq2AjGVjw1rKNjTHEhHcB1LFmRJOLa7UpffnnuSSY6txhlGoMcgtLdTmEBHiFx2W0E59S+hEiCfL7w0NcU4HmKBKuT9Ei1/AgTwfg7615lgzJeZtMPYZcn8/Z2x+UmMDUHWw5nJvhGrgkiVoEzKtsLfD2WASotjXhoibEn6x4Dm9G/qwQXj/iDu1dC3V/yZ6SMm05YOkmnaiTJ/3J+YdIY2igU1vRNno5OrqPfuItQmQgBTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd466872-6a98-41ee-e165-08dc84bf01df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 17:51:48.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhPByI9AtE8ELB5cVrdZQ5NjX7SHc951Rk+mRHWLr58ujS5vMVpTg/I5AXvZTG0RQ+4SWuk96eV/oqNnH5xLt8HvMv0sEMn6jQ/TLxJOpu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040143
X-Proofpoint-GUID: M8hFoNKtHa0Ik9ZlF4kwMQ12ohN0_5xm
X-Proofpoint-ORIG-GUID: M8hFoNKtHa0Ik9ZlF4kwMQ12ohN0_5xm

T24gU2F0LCAyMDI0LTA2LTAxIGF0IDAwOjMzICswMTAwLCBsaW51eEB0cmVibGlnLm9yZyB3cm90
ZToNCj4gRnJvbTogIkRyLiBEYXZpZCBBbGFuIEdpbGJlcnQiIDxsaW51eEB0cmVibGlnLm9yZz4N
Cj4gDQo+ICdyZHNfaWJfZGVyZWdfb2RwX21yJyBoYXMgYmVlbiB1bnVzZWQgc2luY2UgdGhlIG9y
aWdpbmFsDQo+IGNvbW1pdCAyZWFmYTE3NDZmMTcgKCJuZXQvcmRzOiBIYW5kbGUgT0RQIG1yDQo+
IHJlZ2lzdHJhdGlvbi91bnJlZ2lzdHJhdGlvbiIpLg0KPiANCj4gUmVtb3ZlIGl0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRHIuIERhdmlkIEFsYW4gR2lsYmVydCA8bGludXhAdHJlYmxpZy5vcmc+
DQoNClRoaXMgcGF0Y2ggbG9va3MgZmluZSB0byBtZSwgdGhlIHN0cnVjdCBpcyBpbmRlZWQgdW51
c2VkIGF0IHRoaXMgcG9pbnQuDQpUaGFua3MgZm9yIHRoZSBjbGVhbiB1cCENCg0KUmV2aWV3ZWQt
Ynk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KPiAt
LS0NCj4gwqBuZXQvcmRzL2liX3JkbWEuYyB8IDQgLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvaWJfcmRtYS5jIGIvbmV0
L3Jkcy9pYl9yZG1hLmMNCj4gaW5kZXggOGYwNzBlZTdlNzQyLi5kMWNmY2VlZmYxMzMgMTAwNjQ0
DQo+IC0tLSBhL25ldC9yZHMvaWJfcmRtYS5jDQo+ICsrKyBiL25ldC9yZHMvaWJfcmRtYS5jDQo+
IEBAIC00MCwxMCArNDAsNiBAQA0KPiDCoCNpbmNsdWRlICJyZHMuaCINCj4gwqANCj4gwqBzdHJ1
Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqcmRzX2liX21yX3dxOw0KPiAtc3RydWN0IHJkc19pYl9kZXJl
Z19vZHBfbXIgew0KPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgd29ya19zdHJ1Y3Qgd29yazsNCj4g
LcKgwqDCoMKgwqDCoMKgc3RydWN0IGliX21yICptcjsNCj4gLX07DQo+IMKgDQo+IMKgc3RhdGlj
IHZvaWQgcmRzX2liX29kcF9tcl93b3JrZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsNCj4g
wqANCg0K

