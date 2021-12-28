Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB89480909
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 13:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhL1MSE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 07:18:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24304 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230378AbhL1MSE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Dec 2021 07:18:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BSADvOk028957;
        Tue, 28 Dec 2021 12:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d2Oisyp4d4ZP+5laWPxxSwh7AxupVYAOtjx2TCUxI4w=;
 b=PenKiX3d9p2I5WSEIIELThrif8TSogdlSvAE38IrEs3jkjMH9jpTnV6qXI1LzwCnPFiF
 M+MI7pq7OugT+pJ0a0Q0ZUnCd6qe4LXmXKNmgKC4A/w41tJqo+OQdarDKqWJQFdT8m/T
 BbRHcLfc/yAg9Xy6Z4eGhHcyq7wilPAscD9B36Vt6vHM+JEErLMm+p+dyQuhniaw1LHP
 klOV8/97pO9/g4MKvFmismrHq3eJJLcc/Kov0q2Wxte5LkwFI0wuM/To9v45ArO4pxPZ
 jlk2hsytbv+xwRQ3gqPdn0XCqlaqXYD15f/yTefN0uTWhb+Fz1B9xn5VgaY8i7wiiJws Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d7ggx1d17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 12:17:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BSCBKxJ068215;
        Tue, 28 Dec 2021 12:17:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by userp3030.oracle.com with ESMTP id 3d5rdwcrec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 12:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyUyMptJya8jI/oz6UTBWfLlbU+Vq87LuNYRIgMwBcnNIfm+tT7CtpRmJaaJa3TAcPmbt0lzaWLJ9zzPCRsq0+JAWOUh1lOZmxMmnJRxdUWIlhd23rToMfDKaRohaiH5MQxScj64ZNy3axZDLaqgJnEgk4x5Nf2Khe5myEOQcEu40Lhe6e3t+uUWfuZ4hF21vDRqlaOLldOGRQiic24X2m7iXQaLyWTiimPESAf0E6o3Q92faeI8m2OzkF5NPSrUzH9evyMi7xmkLEcrh1vqCOTXjrLxh0iSKMlRbq15XPl3VWJxko53k8oAIsYcWeoGRSMY4B77FuWdzG4X9YaDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2Oisyp4d4ZP+5laWPxxSwh7AxupVYAOtjx2TCUxI4w=;
 b=gh6it8qcyXHQ0Kh+o1x31he6JyID9Bbrdb2x8o/2XDdUyigOob6Jssaxnpig5L9oRfI2FGio+lZbVx6tTaiu+A3WeAI9yyJTrBB1Iqr47Kq17DDDVghvuQsr8dG0pBsCpPnFmufHINZ4qW7rCZ8iCw1jl1Bk5DSOgfQlXdUOzpIgxa0yFKW8VjwO7lmBg4NH0p99fBuTcwnP7/2xia9SKrkGZAmrHkzNvTEbQO1DfwHmsg9IE39OseYt6DlfSlvYFodkr3q/Gom2J8NwOmz3L9wBTgaT+SM1cVMJW52+HXf02p49XYQ+7KzcXqF/yhYwd6HiesIw6dN4mEQHHCi0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2Oisyp4d4ZP+5laWPxxSwh7AxupVYAOtjx2TCUxI4w=;
 b=lsEFxm1A2L4DtZ+Ki4TAT5Ugks+CNjaMJ8xEu7ZKorf4ShkgnXKKmjiJF7nlItz2QbikTBvaayYGdr2ZSvHK6EeIwhZcv7EN01gsOKVysTwMHEMzApFmgm/xPJBn/C0QyiMr4g6x05xsyfbnDs0LqMsZNPSgPoM0TNpEhJFQqhg=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Tue, 28 Dec
 2021 12:17:46 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::eca2:ec30:e72f:93ee%9]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 12:17:45 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>
Subject: RE: [External] : Re: [PATCH rdma-core 2/5] RDMA-CORE/erdma: Add
 userspace verbs implementation
Thread-Topic: [External] : Re: [PATCH rdma-core 2/5] RDMA-CORE/erdma: Add
 userspace verbs implementation
Thread-Index: AQHX+JM/1KpJ5/yNK0q8nMehgQ91GKxF4HyAgAAdrYCAAdbKEA==
Date:   Tue, 28 Dec 2021 12:17:45 +0000
Message-ID: <CO6PR10MB5635BF8D6B6585897DB1DD1BDD439@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20211224065522.29734-1-chengyou@linux.alibaba.com>
 <20211224065522.29734-3-chengyou@linux.alibaba.com>
 <CO6PR10MB5635B8902D89993CF61EA989DD429@CO6PR10MB5635.namprd10.prod.outlook.com>
 <2f95fdfc-8c3d-924d-27da-b4b05f935c00@linux.alibaba.com>
In-Reply-To: <2f95fdfc-8c3d-924d-27da-b4b05f935c00@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f1e2f0b-52d7-4d11-4867-08d9c9fc0e58
x-ms-traffictypediagnostic: CO6PR10MB5537:EE_
x-microsoft-antispam-prvs: <CO6PR10MB55370D00397C45B744B98522DD439@CO6PR10MB5537.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4rAzpRmDIxVnqj3wS/C6koCgzMspUYSCmt42JgYVZ/UWeOuErzYaKxmhJHPVnYJXVY8ZRUOgG/UpjnaFQJ24TIrgrViC57j336S/ZyZkBjGBVqRoWyLn/SWoGX9yqRaB62PzeRWZCjkvCuWo6tJ5TCDNVIa5r+b9Y3dlmyBnmK4BOUtX2+53ek3z0R5bYf1xXeE1DpHSU1nU8WrqT1wwS9728dDU6mBuNg4kX7wAixsi7o3/ypBtfBM+Jn0w9Q9cdVBv2IaUeDUWUY9OI7lts9nby+brDVlrEn2neY32v6MOZeJE/Mh5H2++io5/O+zAp0m6UoLA4XWZ6rsWEzgwHc2hza5cN5v5ip4dSK0wXe73ip+oC/Vet52zEQ/bhsXUuKQZgSMEyvEdZr8yifVFpPjdIvcNH2SYAIatCfg7iQ2ivGTXv1KPrKGsImkj7dnGEk5ci47ByS0RRKNwu9wHo+tcdlymtZnOzTl4kzlEw1QKl+lFi0sy4SO+DPluVUJA75jotPBfOyGPDffZCOPIH2jDtsn4RsvHlUimoOx3JkBQRPZlzUkmQULMCiQu9n50BYupBkFxTt5LujDUSgFgbeW1VrFM6isF6/VEGbSI+c/CyH+rcqSnHuIhCYodhTO8NmjE9CIuWvfuVTPgRo8pqZSnmR3sB6V6EcOwpgj8I713UNb9bF2sPzHgn4gHDWGGQ8xkyQZsKItz3x8lCZmBaI5R3cR5a5YeuB9T/Ci9z0s7gFVciCmiO/fUmTVtes1qDldvC4CZxmkmoWtg85saz6DzM0gROj1Ca6hu1fYr7Hc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(55016003)(4326008)(5660300002)(55236004)(8676002)(38070700005)(966005)(26005)(6506007)(38100700002)(7696005)(8936002)(83380400001)(508600001)(86362001)(54906003)(9686003)(122000001)(316002)(66556008)(76116006)(71200400001)(66476007)(66446008)(64756008)(33656002)(186003)(110136005)(2906002)(52536014)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHAvY3VBRG5FdGk0SkNmeXVFY3hVTFA4SjRwVTFIUW9zdmNJTitQeUVEZUtp?=
 =?utf-8?B?a0dPeC9LZWtuNUViZlFudVN3N2pLMWk0MCtFbW5xZEVQVzBvYWQrSFNZRnZZ?=
 =?utf-8?B?MGlvY1U1RkFhTEh2K1JhRU4zenUzM3JtbUpvVFFpVk5vNkdzeXVESUN2dU0y?=
 =?utf-8?B?aDY3OTlmZGE3ZlMzOTFvc3FyNkE4TW9OOU5QcGtPZ3N2aDAvd0pXNSsrUW4x?=
 =?utf-8?B?QTdEUE8wWVFxV2FFSmVCWUp3TlQwMGRwOXoyOVYvTngvRllnMHVLUDhFVWRP?=
 =?utf-8?B?ZkRBWld2Z2VRVCtXR3RJZnpHOG1kN3V1aDFua0crMGJtNWozYjE4WUtMY2Fr?=
 =?utf-8?B?V0lIUUMwV1lYSEM4ZFhtNk1Zc1JUcEdYYVFXWFJYVXpUc1g5QWtMQ055aGEx?=
 =?utf-8?B?bVU2eHBVTllIRklhRUVlNVpiWHQ1NThtR0hVTmNSbitRN3FoKzJ3SDI4WmFP?=
 =?utf-8?B?VXpZODcxRVYzMUgxanNKSElCZE43em1hYXlBaFhZZ1ZrWTh6VlZNL283Szdo?=
 =?utf-8?B?TWxmaEtzL29ITjkvN3hqellLdjNndDNoalJ0bzJQM0lRK3hPVnRsR1VPM21k?=
 =?utf-8?B?SXZaalcvcWExdEdMc2xFaTRrdUVORzFzREVQS1VmRUJhNlhCdUVxUWljYUFn?=
 =?utf-8?B?SC9GOVZOSVQ0RFlJWjFQaXN3YnNaOEU0Y3F1MXU3cnFuWHUzWXdpWVh5N2JX?=
 =?utf-8?B?aTVueWZ6aldPQ0JtaFpJZjRnWXVEQW5FdGE1b3hDR1VENXNwS3NWeit0a0pF?=
 =?utf-8?B?VDlEdVk5QmxoMTN2K2xiUUdTRGFSUitSYnVZa2d5eTZrTVVKOHNXcWtrakZE?=
 =?utf-8?B?dXZNU1RjK2tSUlpzdURXUGhiYTBiS3BaY1BmczVSWDJXdC8vdzhTZHNaRWZt?=
 =?utf-8?B?WHVqT2UyZ1ljQ0ExdFNjbnlocE4weGRqZ09vcm0vSjZhUnBkelFXUkRrQ29q?=
 =?utf-8?B?TCtkaTZsOXB2RVhZclVtZXRycmxjZFlJbDRSL1pWR0FvWUY3cDVidFhrYnV2?=
 =?utf-8?B?TXRQVFZNT3VJRjNiUHg4M1JiZDRjak1tN3hMMkRxSHpCZEVmcWpHRXpwWXlr?=
 =?utf-8?B?RW1acm16Vnc1OXhOZFgxREVDZFhVczBWZHVia0I1SE4xaW9EYkZXb3JVR3Iv?=
 =?utf-8?B?VFRFNUNGOEwwSWlQdXZlNnc0S0JpVW9HUGtPRHZyZUVlbm1OMVk0ZkNoN2o2?=
 =?utf-8?B?VE5rREpXR3N4VXdMZ2U4OGE5cTBudUNNNDR5eFl6WXZYMTRPMGtvcWx1ZXdF?=
 =?utf-8?B?aWZpQ3FYZi9zUHQ4dlprTnpSc1Q1MExYdGdXMnZ0RnkwNlp3bmprMkJqR0JM?=
 =?utf-8?B?S2Vtb2M3VkpQbUhUQkJESnEvcGNGRFV6WUtFR1JnNkp4WWVjQnhKd1p3Tzln?=
 =?utf-8?B?VnhzMkhyZVJScGtKUUo3VzBVUTVwYk05dzJleWlmTENPdnhNYWhadXRFY21X?=
 =?utf-8?B?ZTNDY3RNN01nZnBrYklTbmdGODNtZ2tIMkIzT0RlZVpzdzlIUHZaYy9za0Ez?=
 =?utf-8?B?Z1FLUVJSWVYwT3F4RWUrY2dDYklVT1o1bm9iT0RPYU9GTEtZZTQ3OTd1c2JP?=
 =?utf-8?B?Mmt4TVdwbDFUdkdYbFZyMkxTYldYczBmZUtmS2dtZWIwdXhZc3JOODRqcGVT?=
 =?utf-8?B?azlWZyswWUhka2JIL2NoaGg4c3p3ZTk1aXRmRVcvUzFBWS9LalhrdHJZVk84?=
 =?utf-8?B?QnVGMmlQR0dDTGZRRTdyY2JyVW1tQ0JGdmp6K3lRUHhsQUhkT2NYUk50OEZC?=
 =?utf-8?B?dEh5ZmZORGNoQ3hXUHVDZGZhVDVVK1ZFWlRkQUZCZmZQNVhxUlpJZ28rMWZW?=
 =?utf-8?B?eVBiT3huaTNkWHZzVFFBclRHMkIvN2VPTjdTU2JIbEdnWXFnTkU3ZlUvaUk3?=
 =?utf-8?B?dytyMWJmMG5nOGdUNUlSRGx2SVV0Zm9JOS9Cd1FpTmVyczVDTTRZYzZ0bTVB?=
 =?utf-8?B?TXlHZGpPT0ptNVZ3STJXbHBzRmVsRkxHYTBIQjh6TnBDQys5N1VTbXc4SnM0?=
 =?utf-8?B?RCtvZVJlSE5hdUprekhWbUFVUWo1enZGYTI4RkVBSkU5WkwrSHQxc055NnV1?=
 =?utf-8?B?emdobC9iTVVmUlkxZVNuOTJxZXNqMW1kVjZuNkJkd1lSMDF5UXlCQlp6RSty?=
 =?utf-8?B?QjBFMW1CcUx5ZWFGaUJXMXY1ekdiMVdpWmRvMVN0L0ZyZGJYbGhuR2YwcUdK?=
 =?utf-8?B?RkN1bWdwWjhudUl4ZmFnamVqTWxDMUZ0bDg3TWFtaXNpTnpWY0hTMk1Ud3N0?=
 =?utf-8?B?RnIraU9UbUtJV2EyU3p1RXRGVjV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1e2f0b-52d7-4d11-4867-08d9c9fc0e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2021 12:17:45.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcUXEFiq/jobcT8CSyA6CXAm9vDuqMdEBBN765QM4rPCP+f4nxVyTAa4UCl+NMrltpbbGSS3JWEL/tFtpdDou2lPZYAk64jnj0pLUgyOHoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5537
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10210 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280056
X-Proofpoint-GUID: KWG59w9GlMdYr4-pSXy9tRU1_0TwqPl4
X-Proofpoint-ORIG-GUID: KWG59w9GlMdYr4-pSXy9tRU1_0TwqPl4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbmcgWHUgPGNoZW5n
eW91QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDI3LCAyMDIx
IDE6MjkgUE0NCj4gVG86IERldmVzaCBTaGFybWEgPGRldmVzaC5zLnNoYXJtYUBvcmFjbGUuY29t
PjsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBkbGVkZm9yZEByZWRoYXQuY29tOyBqZ2dAbWVsbGFu
b3guY29tOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsNCj4gS2FpU2hlbkBsaW51eC5hbGli
YWJhLmNvbQ0KPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIDogUmU6IFtQQVRDSCByZG1hLWNvcmUgMi81
XSBSRE1BLUNPUkUvZXJkbWE6IEFkZA0KPiB1c2Vyc3BhY2UgdmVyYnMgaW1wbGVtZW50YXRpb24N
Cj4gDQo+IA0KPiANCj4gT24gMTIvMjcvMjEgMjoyOSBQTSwgRGV2ZXNoIFNoYXJtYSB3cm90ZToN
Cj4gPg0KPiA+DQo+IA0KPiA8Li4uPg0KPiANCj4gPj4gKwkrK3BhZ2UtPnVzZWQ7DQo+ID4+ICsN
Cj4gPj4gKwlmb3IgKGkgPSAwOyAhcGFnZS0+ZnJlZVtpXTsgKytpKQ0KPiA+PiArCQk7Lyogbm90
aGluZyAqLw0KPiA+IFdoeT8NCj4gDQo+IHBhZ2UtPmZyZWVbaV0gaXMgYSA2NGJpdHMgYml0bWFw
LCBhbGwgemVyb3MgbWVhbnMgdGhlIGNvcmVzcG9kaW5nDQo+IGVudHJpZXMgYXJlIGFsbCB1c2Vk
LCB0aGVuIHdlIG5lZWQgdG8gdHJhdmVyc2UgbmV4dC4gSWYgc3RvcHBlZCwgdGhlbiB3ZSBnZXQg
YQ0KPiB2YWxpZCBlbnRyeSB0byB1c2UuDQpUaGUgbG9vcCBjb3VsZCBiZSBhIGNhbmRpZGF0ZSBm
b3IgY29tcGlsZXIgb3B0aW1pemF0aW9uPw0KPiANCj4gPj4gKw0KPiA+PiArCWogPSBmZnNsKHBh
Z2UtPmZyZWVbaV0pIC0gMTsNCj4gPj4gKwlwYWdlLT5mcmVlW2ldICY9IH4oMVVMIDw8IGopOw0K
PiA+PiArDQo+ID4+ICsJZGJfcmVjb3JkcyA9IHBhZ2UtPnBhZ2VfYnVmICsgKGkgKiBiaXRzX3Bl
cmxvbmcgKyBqKSAqDQo+ID4+ICtFUkRNQV9EQlJFQ09SRFNfU0laRTsNCj4gPj4gKw0KPiA+PiAr
b3V0Og0KPiA+PiArCXB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZjdHgtPmRicmVjb3JkX3BhZ2VzX211
dGV4KTsNCj4gPj4gKw0KPiA+PiArCXJldHVybiBkYl9yZWNvcmRzOw0KPiA+PiArfQ0KPiA+PiAr
DQo+ID4+ICt2b2lkIGVyZG1hX2RlYWxsb2NfZGJyZWNvcmRzKHN0cnVjdCBlcmRtYV9jb250ZXh0
ICpjdHgsIHVpbnQ2NF90DQo+ID4+ICsqZGJyZWNvcmRzKSB7DQo+ID4+ICsJc3RydWN0IGVyZG1h
X2RicmVjb3JkX3BhZ2UgKnBhZ2U7DQo+ID4+ICsJaW50IHBhZ2VfbWFzayA9IH4oY3R4LT5wYWdl
X3NpemUgLSAxKTsNCj4gPj4gKwlpbnQgaWR4Ow0KPiA+PiArDQo+ID4+ICsJcHRocmVhZF9tdXRl
eF9sb2NrKCZjdHgtPmRicmVjb3JkX3BhZ2VzX211dGV4KTsNCj4gPj4gKwlmb3IgKHBhZ2UgPSBj
dHgtPmRicmVjb3JkX3BhZ2VzOyBwYWdlOyBwYWdlID0gcGFnZS0+bmV4dCkNCj4gPj4gKwkJaWYg
KCgodWludHB0cl90KWRicmVjb3JkcyAmIHBhZ2VfbWFzaykgPT0gKHVpbnRwdHJfdClwYWdlLQ0K
PiA+Pj4gcGFnZV9idWYpDQo+ID4+ICsJCQlicmVhazsNCj4gPj4gKw0KPiA+PiArCWlmICghcGFn
ZSkNCj4gPj4gKwkJZ290byBvdXQ7DQo+ID4+ICsNCj4gPj4gKwlpZHggPSAoKHZvaWQgKilkYnJl
Y29yZHMgLSBwYWdlLT5wYWdlX2J1ZikgLw0KPiA+PiBFUkRNQV9EQlJFQ09SRFNfU0laRTsNCj4g
Pj4gKwlwYWdlLT5mcmVlW2lkeCAvICg4ICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKV0gfD0NCj4g
Pj4gKwkJMVVMIDw8IChpZHggJSAoOCAqIHNpemVvZih1bnNpZ25lZCBsb25nKSkpOw0KPiA+PiAr
DQo+ID4+ICsJaWYgKCEtLXBhZ2UtPnVzZWQpIHsNCj4gPj4gKwkJaWYgKHBhZ2UtPnByZXYpDQo+
ID4+ICsJCQlwYWdlLT5wcmV2LT5uZXh0ID0gcGFnZS0+bmV4dDsNCj4gPj4gKwkJZWxzZQ0KPiA+
PiArCQkJY3R4LT5kYnJlY29yZF9wYWdlcyA9IHBhZ2UtPm5leHQ7DQo+ID4+ICsJCWlmIChwYWdl
LT5uZXh0KQ0KPiA+PiArCQkJcGFnZS0+bmV4dC0+cHJldiA9IHBhZ2UtPnByZXY7DQo+ID4+ICsN
Cj4gPj4gKwkJZnJlZShwYWdlLT5wYWdlX2J1Zik7DQo+ID4+ICsJCWZyZWUocGFnZSk7DQo+ID4+
ICsJfQ0KPiA+PiArDQo+ID4+ICtvdXQ6DQo+ID4+ICsJcHRocmVhZF9tdXRleF91bmxvY2soJmN0
eC0+ZGJyZWNvcmRfcGFnZXNfbXV0ZXgpOw0KPiA+PiArfQ0KPiANCj4gPC4uLj4NCj4gDQo+ID4+
ICtzdGF0aWMgdm9pZCBfX2VyZG1hX2FsbG9jX2RicyhzdHJ1Y3QgZXJkbWFfcXAgKnFwLCBzdHJ1
Y3QNCj4gPj4gK2VyZG1hX2NvbnRleHQNCj4gPj4gKypjdHgpIHsNCj4gPj4gKwl1aW50MzJfdCBx
cG4gPSBxcC0+aWQ7DQo+ID4+ICsNCj4gPj4gKwlpZiAoY3R4LT5zZGJfdHlwZSA9PSBFUkRNQV9T
REJfUEFHRSkgew0KPiA+PiArCQkvKiBxcG5bNDowXSBhcyB0aGUgaW5kZXggaW4gdGhpcyBkYiBw
YWdlLiAqLw0KPiA+PiArCQlxcC0+c3EuZGIgPSBjdHgtPnNkYiArIChxcG4gJiAzMSkgKiBFUkRN
QV9TUURCX1NJWkU7DQo+ID4+ICsJfSBlbHNlIGlmIChjdHgtPnNkYl90eXBlID09IEVSRE1BX1NE
Ql9FTlRSWSkgew0KPiA+PiArCQkvKiBmb3IgdHlwZSAnRVJETUFfU0RCX0VOVFJZJywgZWFjaCB1
Y3R4IGhhcyAyIGR3cWUsDQo+ID4+IHRvdGFsbHkgdGFrZXMgMjU2Qnl0ZXMuICovDQo+ID4+ICsJ
CXFwLT5zcS5kYiA9IGN0eC0+c2RiICsgY3R4LT5zZGJfb2Zmc2V0ICogMjU2Ow0KPiA+IEdlbmVy
YWxseSB3ZSB1c2UgbWFjcm9zIHRvIGRlZmluZSBoYXJkLWNvZGVkIGludGVnZXJzLiBFLmcgMjU2
IHNob3VsZCB1c2UNCj4gYSBtYWNyby4NCj4gDQo+IE9LLCB3aWxsIGZpeC4NCj4gDQo+ID4+ICsJ
fSBlbHNlIHsNCj4gPj4gKwkJLyogcXBuWzQ6MF0gYXMgdGhlIGluZGV4IGluIHRoaXMgZGIgcGFn
ZS4gKi8NCj4gPj4gKwkJcXAtPnNxLmRiID0gY3R4LT5zZGIgKyAocXBuICYgMzEpICogRVJETUFf
U1FEQl9TSVpFOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCS8qIHFwbls2OjBdIGFzIHRoZSBp
bmRleCBpbiB0aGlzIHJxIGRiIHBhZ2UuICovDQo+ID4+ICsJcXAtPnJxLmRiID0gY3R4LT5yZGIg
KyAocXBuICYgMTI3KSAqIEVSRE1BX1JRREJfU1BBQ0VfU0laRTsgfQ0KPiA+PiArDQo+ID4+ICtz
dHJ1Y3QgaWJ2X3FwICplcmRtYV9jcmVhdGVfcXAoc3RydWN0IGlidl9wZCAqcGQsIHN0cnVjdA0K
PiA+PiAraWJ2X3FwX2luaXRfYXR0ciAqYXR0cikgew0KPiA+PiArCXN0cnVjdCBlcmRtYV9jbWRf
Y3JlYXRlX3FwIGNtZCA9IHt9Ow0KPiA+PiArCXN0cnVjdCBlcmRtYV9jbWRfY3JlYXRlX3FwX3Jl
c3AgcmVzcCA9IHt9Ow0KPiA+PiArCXN0cnVjdCBlcmRtYV9xcCAqcXA7DQo+ID4+ICsJc3RydWN0
IGlidl9jb250ZXh0ICpiYXNlX2N0eCA9IHBkLT5jb250ZXh0Ow0KPiA+PiArCXN0cnVjdCBlcmRt
YV9jb250ZXh0ICpjdHggPSB0b19lY3R4KGJhc2VfY3R4KTsNCj4gPj4gKwl1aW50NjRfdCAqZGJf
cmVjb3JkcyAgPSBOVUxMOw0KPiA+PiArCWludCBydiwgdGJsX2lkeCwgdGJsX29mZjsNCj4gPj4g
KwlpbnQgc3Ffc2l6ZSA9IDAsIHJxX3NpemUgPSAwLCB0b3RhbF9idWZzaXplID0gMDsNCj4gPj4g
Kw0KPiA+PiArCW1lbXNldCgmY21kLCAwLCBzaXplb2YoY21kKSk7DQo+ID4+ICsJbWVtc2V0KCZy
ZXNwLCAwLCBzaXplb2YocmVzcCkpOw0KPiA+IE5vIG5lZWQgb2YgbWVtc2V0IGR1ZSB0byBkZWNs
YXJhdGlvbiBzdGVwLg0KPiANCj4gT0ssIHdpbGwgZml4Lg0KPiANCj4gPj4gKw0KPiA+PiArCXFw
ID0gY2FsbG9jKDEsIHNpemVvZigqcXApKTsNCj4gPj4gKwlpZiAoIXFwKQ0KPiA+PiArCQlyZXR1
cm4gTlVMTDsNCj4gPj4gKw0KPiA+PiArCXNxX3NpemUgPSByb3VuZHVwX3Bvd19vZl90d28oYXR0
ci0+Y2FwLm1heF9zZW5kX3dyICoNCj4gPj4gTUFYX1dRRUJCX1BFUl9TUUUpIDw8IFNRRUJCX1NI
SUZUOw0KPiA+PiArCXNxX3NpemUgPSBhbGlnbihzcV9zaXplLCBjdHgtPnBhZ2Vfc2l6ZSk7DQo+
ID4+ICsJcnFfc2l6ZSA9IGFsaWduKHJvdW5kdXBfcG93X29mX3R3byhhdHRyLT5jYXAubWF4X3Jl
Y3Zfd3IpIDw8DQo+ID4+IFJRRV9TSElGVCwgY3R4LT5wYWdlX3NpemUpOw0KPiA+PiArCXRvdGFs
X2J1ZnNpemUgPSBzcV9zaXplICsgcnFfc2l6ZTsNCj4gPj4gKwlydiA9IHBvc2l4X21lbWFsaWdu
KCZxcC0+cWJ1ZiwgY3R4LT5wYWdlX3NpemUsIHRvdGFsX2J1ZnNpemUpOw0KPiA+PiArCWlmIChy
diB8fCAhcXAtPnFidWYpIHsNCj4gPj4gKwkJZXJybm8gPSBFTk9NRU07DQo+ID4+ICsJCWdvdG8g
ZXJyb3JfYWxsb2M7DQo+ID4+ICsJfQ0KPiANCj4gPC4uLj4NCj4gDQo+ID4+ICsNCj4gPj4gK2lu
dCBlcmRtYV9kZXN0cm95X3FwKHN0cnVjdCBpYnZfcXAgKmJhc2VfcXApIHsNCj4gPj4gKwlzdHJ1
Y3QgZXJkbWFfcXAgKnFwID0gdG9fZXFwKGJhc2VfcXApOw0KPiA+PiArCXN0cnVjdCBpYnZfY29u
dGV4dCAqYmFzZV9jdHggPSBiYXNlX3FwLT5wZC0+Y29udGV4dDsNCj4gPj4gKwlzdHJ1Y3QgZXJk
bWFfY29udGV4dCAqY3R4ID0gdG9fZWN0eChiYXNlX2N0eCk7DQo+ID4+ICsJaW50IHJ2LCB0Ymxf
aWR4LCB0Ymxfb2ZmOw0KPiA+PiArDQo+ID4+ICsJcHRocmVhZF9zcGluX2xvY2soJnFwLT5zcV9s
b2NrKTsNCj4gPj4gKwlwdGhyZWFkX3NwaW5fbG9jaygmcXAtPnJxX2xvY2spOw0KPiA+IFdoeSB0
byBob2xkIHRoZXNlPw0KPiANCj4gSGVyZSwgd2UgYXJlIGRlc3Ryb3lpbmcgdGhlIHFwIHJlc291
cmNlcywgc3VjaCBhcyB0aGUgcXVldWUgYnVmZmVycy4NCj4gd2Ugd2FudCB0byBhdm9pZCByYWNl
IGNvbmRpdGlvbiB3aXRoIHBvc3Rfc2VuZCBhbmQgcG9zdF9yZWN2Lg0KQXBwbGljYXRpb24gc2hv
dWxkIG1ha2Ugc3VyZSBubyBvbmUgaXMgYWNjZXNzaW5nIHRoZSBRUCB3aGVuIHFwLWRlc3Ryb3kg
aXMgY2FsbGVkLiBQcm9iYWJseSB5b3UgY2FuIGJlIGVhc3kgb24gdGhlc2UgbG9ja3MuDQo+IA0K
PiA+PiArDQo+ID4+ICsJcHRocmVhZF9tdXRleF9sb2NrKCZjdHgtPnFwX3RhYmxlX211dGV4KTsN
Cj4gPj4gKwl0YmxfaWR4ID0gcXAtPmlkID4+IEVSRE1BX1FQX1RBQkxFX1NISUZUOw0KPiA+PiAr
CXRibF9vZmYgPSBxcC0+aWQgJiBFUkRNQV9RUF9UQUJMRV9NQVNLOw0KPiA+PiArDQo+ID4+ICsJ
Y3R4LT5xcF90YWJsZVt0YmxfaWR4XS50YWJsZVt0Ymxfb2ZmXSA9IE5VTEw7DQo+ID4+ICsJY3R4
LT5xcF90YWJsZVt0YmxfaWR4XS5yZWZjbnQtLTsNCj4gPj4gKw0KPiA+PiArCWlmIChjdHgtPnFw
X3RhYmxlW3RibF9pZHhdLnJlZmNudCA9PSAwKSB7DQo+ID4+ICsJCWZyZWUoY3R4LT5xcF90YWJs
ZVt0YmxfaWR4XS50YWJsZSk7DQo+ID4+ICsJCWN0eC0+cXBfdGFibGVbdGJsX2lkeF0udGFibGUg
PSBOVUxMOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCXB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZj
dHgtPnFwX3RhYmxlX211dGV4KTsNCj4gPj4gKw0KPiA+PiArCXJ2ID0gaWJ2X2NtZF9kZXN0cm95
X3FwKGJhc2VfcXApOw0KPiA+PiArCWlmIChydikgew0KPiA+PiArCQlwdGhyZWFkX3NwaW5fdW5s
b2NrKCZxcC0+cnFfbG9jayk7DQo+ID4+ICsJCXB0aHJlYWRfc3Bpbl91bmxvY2soJnFwLT5zcV9s
b2NrKTsNCj4gPj4gKwkJcmV0dXJuIHJ2Ow0KPiA+PiArCX0NCj4gPj4gKwlwdGhyZWFkX3NwaW5f
ZGVzdHJveSgmcXAtPnJxX2xvY2spOw0KPiA+PiArCXB0aHJlYWRfc3Bpbl9kZXN0cm95KCZxcC0+
c3FfbG9jayk7DQo+ID4+ICsNCj4gPj4gKwlpZiAocXAtPmRiX3JlY29yZHMpDQo+ID4+ICsJCWVy
ZG1hX2RlYWxsb2NfZGJyZWNvcmRzKGN0eCwgcXAtPmRiX3JlY29yZHMpOw0KPiA+PiArDQo+ID4+
ICsJaWYgKHFwLT5xYnVmKQ0KPiA+PiArCQlmcmVlKHFwLT5xYnVmKTsNCj4gPj4gKw0KPiA+PiAr
CWZyZWUocXApOw0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+ID4+ICsNCj4g
DQo+IDwuLi4+DQo+IA0KPiA+PiArDQo+ID4+ICtpbnQgZXJkbWFfcG9zdF9zZW5kKHN0cnVjdCBp
YnZfcXAgKmJhc2VfcXAsIHN0cnVjdCBpYnZfc2VuZF93ciAqd3IsDQo+ID4+ICtzdHJ1Y3QgaWJ2
X3NlbmRfd3IgKipiYWRfd3IpIHsNCj4gPj4gKwlzdHJ1Y3QgZXJkbWFfcXAgKnFwID0gdG9fZXFw
KGJhc2VfcXApOw0KPiA+PiArCXVpbnQxNl90IHNxX3BpOw0KPiA+PiArCWludCBuZXdfc3FlID0g
MCwgcnYgPSAwOw0KPiA+PiArDQo+ID4+ICsJKmJhZF93ciA9IE5VTEw7DQo+ID4+ICsNCj4gPj4g
KwlpZiAoYmFzZV9xcC0+c3RhdGUgPT0gSUJWX1FQU19FUlIpIHsNCj4gPiBQb3N0X3NlbmQgaXMg
YWxsb3dlZCBpbiBFcnJvciBzdGF0ZS4gVGh1cyB0aGUgY2hlY2sgaXMgcmVkdW5kYW50Lg0KPiAN
Cj4gRG9lcyB0aGlzIGhhdmUgc3BlY2lmaWNhdGlvbj8gV2UgZGlkbid0IGZpbmQgdGhlIGRlc2Ny
aXB0aW9uIGluIElCDQo+IHNwZWNpZmljYXRpb24uDQo+IEVSRE1BIHVzZXMgaVdhcnAsIGFuZCBp
biB0aGlzIHNwZWNpZmljYXRpb24gKGxpbms6IFsxXSksIGl0IHNheXMgdGhhdCB0d28gYWN0aW9u
cw0KPiBzaG91bGQgYmUgdGFrZW46ICJwb3N0IHdxZSwgYW5kIHRoZW4gZmx1c2ggaXQiIG9yICJy
ZXR1cm4gYW4gaW1tZWRpYXRlDQo+IGVycm9yIiB3aGVuIHBvc3QgV1IgaW4gRVJST1Igc3RhdGUu
IEFmdGVyIG1vZGlmeSBxcCB0byBlcnIsIG91ciBoYXJkd2FyZQ0KPiB3aWxsIGZsdXNoIGFsbCB0
aGUgd3FlcywgdGh1cyBmb3IgdGhlIG5ld2x5IHBvc3RlZCB3ciwgd2UgcmV0dXJuIGFuIGVycm9y
DQo+IGltbWVkaWF0ZWx5Lg0KPiBBbHNvLCBJIHJldmlldyBvdGhlciBwcm92aWRlcnMnIGltcGxl
bWVudGF0aW9uLCBvY3JkbWEvZWZhL2JueHRfcmUgYWxzbw0KPiBkb24ndCBhbGxvdyBwb3N0X3Nl
bmQgaW4gRVJST1Igc3RhdGUuIERvZXMgdGhpcyBjYW4gaGF2ZSBhIGxpdHRsZSBkaWZmZXJlbmNl
DQo+IGRlcGVuZGVkIG9uIGRpZmZlcmVudCBIQ0FzPw0KV2VsbCBpdHMgaW5kZWVkLiBZb3UgY2Fu
IG9taXQgaXQgZm9yIG5vdy4NCj4gDQo+IFRoYW5rcywNCj4gQ2hlbmcgWHUNCj4gDQo+IFsxXQ0K
PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9y
Zy9kb2MvaHRtbC9kcmFmdC0NCj4gaGlsbGFuZC1yZGRwLXZlcmJzLTAwKnNlY3Rpb24tDQo+IDYu
Mi40X187SXchIUFDV1Y1TjlNMlJWOTloUSFmY0ZGMk9XeTJuNm1pVHY5VXdQcFhzMXkxUmJPNHB4
WXMNCj4gWE9DYzU5aFRBTDBaNG5hZ1V0MFoyQWFodDhqWDBhbEVfVFUkDQo+IA0KPiANCj4gDQo+
ID4+ICsJCSpiYWRfd3IgPSB3cjsNCj4gPj4gKwkJcmV0dXJuIC1FSU87DQo+ID4+ICsJfQ0KPiA+
PiArDQo+ID4+ICsJcHRocmVhZF9zcGluX2xvY2soJnFwLT5zcV9sb2NrKTsNCj4gPj4gKw0KPiA+
PiArCXNxX3BpID0gcXAtPnNxLnBpOw0KPiA+PiArDQo+ID4+ICsJd2hpbGUgKHdyKSB7DQo+ID4+
ICsJCWlmICgodWludDE2X3QpKHNxX3BpIC0gcXAtPnNxLmNpKSA+PSBxcC0+c3EuZGVwdGgpIHsN
Cj4gPj4gKwkJCXJ2ID0gLUVOT01FTTsNCj4gPj4gKwkJCSpiYWRfd3IgPSB3cjsNCj4gPj4gKwkJ
CWJyZWFrOw0KPiA+PiArCQl9DQo+ID4+ICsNCj4gDQo+IDwuLi4+DQo+IA0KPiA+PiAtLQ0KPiA+
PiAyLjI3LjANCg==
