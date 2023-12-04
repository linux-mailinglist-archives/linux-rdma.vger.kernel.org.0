Return-Path: <linux-rdma+bounces-199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1A80372E
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 15:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E35B20B99
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E423774;
	Mon,  4 Dec 2023 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/B0o2S9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A8C1
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 06:43:25 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4DlPuh005813;
	Mon, 4 Dec 2023 14:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=u8APGF8wiuLUKp9CA3NH5nmkBA7oYou3PGfXQglwtAw=;
 b=T/B0o2S9aBE2p9qrL13+C3TkALOpjfGr5lCv5Z4J6vOsMd3P3JuVeP//neJ+1kgsEss1
 kN/CTxG7Q8AlY6jKytPvN78lX+T4MR4jicJCpUa5IF+YjmsIrhcC7ENgze2ro+eYXy33
 GVg2xp7reSVIQsGpWS2I7VodQA6qec9iPu2/bmUJlJt8DCPiwC4UQdfuuc9ekbglUtvW
 JzSk3hVNlquSWmE0x4SV6gpN1IYtQQhvhHX5akyC1ZAvY3kAHtZKq27oQ52/PZ4u9WAK
 74sQ/iP67O3msp4eENk6Prv2VP3fuyQxy/lV8lS30MZiCdKcM4YxvBM006VPAcSmHJav lw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usfy3syf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 14:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZaYqJGpmEg0zwNJQTzMQal37L9oDN9TqCQZSZrsSXxGZLXqAZ6QH449DGhvvucrS0CXA3vx9RCEqlyOHaU7e0p5a/5Jk48p3lSeZ25vtQmAd6MbGjbrFomNmzbtiQ+vM8aqJWyuzmGpJeDt4cFOxUPk+ke+MnHwm3Tp0KdqmMy2Bb+HUYdey2mxB7T/bbxDFiLUOqY/fHcgfbRFkes0EhlbthmssPTzu7b5bC1zFHVDOuxJCQ1tmJOdK/YZtMjMBNsVsCzpEgX+KDZmstI5CHlj2JaBbV9FFqRt66tw6yOXdpPEAf+OZ29UZC5cAksAPR0xq3hwyeCWwRESS+uSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8APGF8wiuLUKp9CA3NH5nmkBA7oYou3PGfXQglwtAw=;
 b=cuw01Cp430atM1P/H99pJn8HhVAkJacZuVv8AoEN/pDwU1jPr9j1l1pBRDrnKLKz4ssQxqdtMBfm9X9lngMdxUae1smEehtfrfbfoUdopbQEOI6xHQNga5YXsBURcRrRulJH8nWMqkK+pCJa0W6djdH+dQJEF7i2HLELlWpq7vHBtgzgOi4awJuLmdQC7kno2PepXU2r0GE/lra0Ei9ekNX2Dd7yg9gwtIltd0cvrn++zJCJlVspgHDdaFt5sXLms8is1kAtjZZhS9BcSRRVRazFVccd9KfxDdIfB0n1aiIWsLfPb16YGOvK/0SpvOYLl7wxNK8pdMGsfvGUHfvgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 14:43:10 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 14:43:10 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 3/4] RDMA/siw: Set qp_state in siw_query_qp
Thread-Topic: [PATCH V2 3/4] RDMA/siw: Set qp_state in siw_query_qp
Thread-Index: AQHaJsAzaYAzgcW8KESgbvMv+0ViMQ==
Date: Mon, 4 Dec 2023 14:43:09 +0000
Message-ID: 
 <BY5PR15MB36025DB353BE26A418EBE5379986A@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20231203092655.28102-1-guoqing.jiang@linux.dev>
 <20231203092655.28102-4-guoqing.jiang@linux.dev>
In-Reply-To: <20231203092655.28102-4-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|SA0PR15MB4016:EE_
x-ms-office365-filtering-correlation-id: fe2b1075-af0e-4472-3f3e-08dbf4d755fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uuRLUU4kEnEvZpRqE0TRTg1zlV9AQ/j53n/E5Pin7HbNTbvWTpwYCyIehwcYgeSsuEF9nt/JvDRNTklbWLYs4V3ZXM67Haua1lb8msTeaR3w34M6D2Tr60b6a/fCYOG5feUrYOWjNia6hgE86/tFLDe6hKmHXTWNNsptOzxDJtSuBkHYkmKNC2CZVsJFcWnwDn1sE+EmkCQjcpxgUGqaDUh9toZNVIE4B70BgLp+jz6cma6Xypj5kKo7HahWTwJ9mOUG79UwwSuwlELNy+vKl9076V90IlLIsoaomkKsWiSUqfiuQ2VlWztewKR1QIWmMW7ri2/viJc568sjtiHzj6cAnq5ZULhULKt1Y4P/MyWNeQeLcRg5BdqpRjMXy0QBPW31bwluxbkXHyJ9tgetd7TET9/mHy3cydDKs4mzwjF5k5JIMrj+dYS9kK2Cn8jiJkR9/SAx0bP/aO/6Q096mHX8KN6k4A5F/sdN1ocx5qVrlOmIkT9uVS8qlgkf1RK3GV/nnESDjomDCt/1hKCc5EuSc8CKM7baYGh98X3Jflro7hgTnaDbPhZLtE7HKR7BQhzlDuNOCpZlJzBTDhlGnecChlcSsZEx3pd+K27wWF8LV/SzdLub0rmSn/d/M4PyUyiU9KCi8oWGHodcBT0fLA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(122000001)(53546011)(9686003)(8936002)(8676002)(66446008)(66946007)(66476007)(66556008)(316002)(76116006)(64756008)(4326008)(38100700002)(52536014)(110136005)(7696005)(6506007)(55016003)(478600001)(71200400001)(83380400001)(86362001)(5660300002)(2906002)(41300700001)(38070700009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZExEcXgwWkNUTGxPZ3dtcEduVnovYjM5a2dpMVpPejNtS2V5UDk5LytuNlZW?=
 =?utf-8?B?ZytzMGxFSThYbkkxOEsza0VwR3kxN0k5WDFldVRJVDZQVmEzZjd0UWoyK3hp?=
 =?utf-8?B?dWtteG9jbjgwZHB1V0cvMUI2N3l2K0FUeWlqZEdKdGxRL3NacUFqMjZtdVdK?=
 =?utf-8?B?bWNlem5yVG9ENllKUEo0RUV6UTMwNUw3TlFzaEgzYmJKbTI1V283K1BRZGx4?=
 =?utf-8?B?clYyYndvM2hJbzFteTNmKzRGV1VXb3owZlFxK2c4dHpXaFN3QkFpOVBNT2p6?=
 =?utf-8?B?QnNQdEExWWV1QWQvUlhQcTIyMGNzWW1pNVZYZ1BCclc2WnZmc2lTR3dPMjZT?=
 =?utf-8?B?aTFmRmV0YTRVRCtuTHFzZndWQlZma0wxdTcraU5YaHphYUVLbkdSWVdHTEZl?=
 =?utf-8?B?UUpGbmhyMGxWL0RPVmUrRlM1OXMzQktaakhzSmFhL3pwZWpxTWVrWkxZQ0pP?=
 =?utf-8?B?ZStXY1U0eWlWUUpOVEx2NEovTWhCOXpUWnRWdlJJSHpENTlVQnZhUlZ2NzVs?=
 =?utf-8?B?VVNRYjFoOEYzallPT2YrVG5Kcm81TnhVQmRqeFAyOGNqc21JUnF0YlpXNGk4?=
 =?utf-8?B?bDFMRndPbzdvREhyeHRtY2E5dngwd0N4Q09MV0pUWWlyc3JlU1EzSS9xUlJI?=
 =?utf-8?B?NmtYUExLUHlBQ091QmwwcHI2VVJQZW1oVFVlUHdYV2pIbm1DSXBuTnpPU2do?=
 =?utf-8?B?UEw5MUNJcHg2dU00MmcwcmdSTnhTemxCb1dsaUF5QUxoNGRNcTdGNlFUZmNJ?=
 =?utf-8?B?SkVoTlRCa2EvYW1acStyaEhraXpISkgxN0NsQ0orejd1dUJZSzNNZTdhMnRX?=
 =?utf-8?B?cTRPemFIL1lwWUlYQ3VVUjgyOVZsVlZ5eGg4bFdkMG1tSEdxRTJCNW5CY2lK?=
 =?utf-8?B?dE9YZlFycVdLUjRzajl5UGlLL3JleXN5cUpHSHpzNVB2RGpqTTNBUVcrbGJ0?=
 =?utf-8?B?QWUvbDVRNXYvbkVjdDlRSnNpTURiamZ6TzlRR1FtVGp1STFQU2NzUk01cGdC?=
 =?utf-8?B?NTQrNlFVc0ZDNmRsbGFOZDBpN0ZQeEQ1UTMyUUJYUmQrR0NzOTBoU2dRL0ZF?=
 =?utf-8?B?OCtRbkNmcDRQSE5RS1hXUDdwazYzcjhrNERrVXpjbWxrY00yeTVwVW1vNUZ3?=
 =?utf-8?B?NGthV0dSTnlFaWdMeXh5RkJXRHUzU0xySUFLalRZQmt4NEROZVFSL0c2ZndI?=
 =?utf-8?B?QmJhTDBjMzB0Qkt2MkhXYUIyVkMvYzdpWHF3R1Jra2luOFBqcXBxYzJuZWY4?=
 =?utf-8?B?WEhQQ0grSFlzc2h2aDExQkhwcVZRU2grellmeTN2WVVPUG9xd0RibXhNQ2pB?=
 =?utf-8?B?R2MybkVHU2JMV3hrYzB0Vlc1QWloWTBhM0Nmc2hwWDNMb0N0WXkxZUNweEZP?=
 =?utf-8?B?aDJuMDlwMDBXN2lsSko2NDBUUTV1bDM2RFpsQWNnWXQrNVYwKzVYQlErNVJl?=
 =?utf-8?B?aDZ2dEdnbXJvSDBvMS9pZ281dEpsVTY0ckdpYVpsMmowMVFacFRieHl0em9W?=
 =?utf-8?B?L2F2WFRJN2wwNGVlQUpQVU4vWmxSWlVLQ1B2ZUJERVp5M3hWbmt4dEJ4Nkw4?=
 =?utf-8?B?Q2RaajdibmNSaXptVmRxdEV6MnNyamQ3UTFYUUc0dVJQdDdySTl0akdDd0xS?=
 =?utf-8?B?VTBNdDRCVGVWcHc3RERtSWtlUHpLYS9PUldGYWtCRXpkMEVYVHVQWEdDbHZ5?=
 =?utf-8?B?L3VkSGVuSnpnYnd3NzZkZlB4ekc0RDRUaVArd2VvV0JnZWlPa1Qzais1ZVRT?=
 =?utf-8?B?ZmY2Yi9kVy9ON3o1V1VNVGtaV1NRRXh3NlhPMGMzc0xCemQyVGF2MURLMFZq?=
 =?utf-8?B?VlBJWnhoWU4ySUk5aFZvTU5FUHFaMjNucHZJV1JBdWU5eWcva2pvbDZHUjh4?=
 =?utf-8?B?dTNzemlyeHJyM2RGVmRnNk85ZDBQbVVzL1VOM0N2NVkwRlgzYWxrSjdHUkQy?=
 =?utf-8?B?VXN5c3YvR1k3aTh5T0ZTT3JtbnhUdlF6WGRNMWhidTBCR3VDR1Y3K1BqaFZK?=
 =?utf-8?B?czFrQmpDSGdMS21sRmdka0YzOXU0MFl2b2xjb2dvU0dFbUtkWkc3b1NieTdT?=
 =?utf-8?B?c29ZSWRkbWFsVVgvRkVLVTFpZ01mVUJVTU9QajFoNTkrK0Ziemxpc2tidC92?=
 =?utf-8?B?MkFaZXlwMGxtbnFBSXB2c2FDZ1VjT3VydmJtU1dybXZYRjRkQXdTSWEvNXJs?=
 =?utf-8?Q?DR1rEMH3wB/QGZFmfJ42Y4U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3602.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b1075-af0e-4472-3f3e-08dbf4d755fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 14:43:10.0599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7YM+Tyl4HM3FLoCRY3/8pQmD6dSO0tsnuNAEe0ino86G1mH/skuk2KPI4CAid6IBqQfKh4bQuAmaDlys80cvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-Proofpoint-GUID: PiYxEj2HWlboFEhoE8Cr5lU_dMTSA4_c
X-Proofpoint-ORIG-GUID: PiYxEj2HWlboFEhoE8Cr5lU_dMTSA4_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040110

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgMywgMjAy
MyAxMDoyNyBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBq
Z2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9yZw0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5l
bC5vcmc7IGd1b3FpbmcuamlhbmdAbGludXguZGV2DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BB
VENIIFYyIDMvNF0gUkRNQS9zaXc6IFNldCBxcF9zdGF0ZSBpbiBzaXdfcXVlcnlfcXANCj4gDQo+
IFJ1biB0ZXN0X3F1ZXJ5X3JjX3FwIGFnYWluc3Qgc2l3IGZhaWxlZCBzaW5jZSBzaXcgZGlkbid0
IHNldCBxcF9zdGF0ZQ0KPiBhY2NvcmRpbmdseS4gVG8gYWRkcmVzcyBpdCwgaW50cm9kdWNlIHNp
d19xcF9zdGF0ZV90b19pYl9xcF9zdGF0ZQ0KPiB3aGljaCBjb252ZXJ0IFNJV19RUF9TVEFURV9J
RExFIHRvIElCX1FQU19JTklUIHdoaWNoIGlzIHNpbWlsYXIgYXMNCj4gaW4gY3hnYjQuDQo+IA0K
PiByZG1hLWNvcmUjIC4vYnVpbGQvYmluL3J1bl90ZXN0cy5weSAtLWRldiBzaXcwDQo+IHRlc3Rz
LnRlc3RfcXAuUVBUZXN0LnRlc3RfcXVlcnlfcmNfcXAgLXYNCj4gdGVzdF9xdWVyeV9yY19xcCAo
dGVzdHMudGVzdF9xcC5RUFRlc3QpDQo+IFF1ZXJpZXMgYW4gUkMgUVAgYWZ0ZXIgY3JlYXRpb24u
IFZlcmlmaWVzIHRoYXQgaXRzIHByb3BlcnRpZXMgYXJlIGFzIC4uLg0KPiBGQUlMDQo+IA0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+IEZBSUw6IHRlc3RfcXVlcnlfcmNfcXAgKHRlc3RzLnRlc3RfcXAuUVBU
ZXN0KQ0KPiBRdWVyaWVzIGFuIFJDIFFQIGFmdGVyIGNyZWF0aW9uLiBWZXJpZmllcyB0aGF0IGl0
cyBwcm9wZXJ0aWVzIGFyZSBhcw0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToNCj4gICBGaWxlICIvaG9tZS9namlhbmcvcmRtYS1jb3JlL3Rlc3Rz
L3Rlc3RfcXAucHkiLCBsaW5lIDI4NCwgaW4NCj4gdGVzdF9xdWVyeV9yY19xcA0KPiAgICAgc2Vs
Zi5xdWVyeV9xcF9jb21tb25fdGVzdChlLklCVl9RUFRfUkMpDQo+ICAgRmlsZSAiL2hvbWUvZ2pp
YW5nL3JkbWEtY29yZS90ZXN0cy90ZXN0X3FwLnB5IiwgbGluZSAyNjUsIGluDQo+IHF1ZXJ5X3Fw
X2NvbW1vbl90ZXN0DQo+ICAgICBzZWxmLnZlcmlmeV9xcF9hdHRycyhjYXBzLCBlLklCVl9RUFNf
SU5JVCwgcXBfaW5pdF9hdHRyLCBxcF9hdHRyKQ0KPiAgIEZpbGUgIi9ob21lL2dqaWFuZy9yZG1h
LWNvcmUvdGVzdHMvdGVzdF9xcC5weSIsIGxpbmUgMjM5LCBpbg0KPiB2ZXJpZnlfcXBfYXR0cnMN
Cj4gICAgIHNlbGYuYXNzZXJ0RXF1YWwoc3RhdGUsIGF0dHIucXBfc3RhdGUpDQo+IEFzc2VydGlv
bkVycm9yOiA8aWJ2X3FwX3N0YXRlLklCVl9RUFNfSU5JVDogMT4gIT0gMA0KPiANCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBSYW4gMSB0ZXN0IGluIDAuMDU3cw0KPiANCj4gRkFJTEVEIChmYWlsdXJlcz0x
KQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51
eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYyB8
IDEwICsrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMNCj4gaW5kZXggZGNhNmExNTU1
MjNkLi5lY2YwNDQ0NjY2YjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X3ZlcmJzLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVy
YnMuYw0KPiBAQCAtMTksNiArMTksMTUgQEANCj4gICNpbmNsdWRlICJzaXdfdmVyYnMuaCINCj4g
ICNpbmNsdWRlICJzaXdfbWVtLmgiDQo+IA0KPiArc3RhdGljIGludCBzaXdfcXBfc3RhdGVfdG9f
aWJfcXBfc3RhdGVbU0lXX1FQX1NUQVRFX0NPVU5UXSA9IHsNCj4gKwlbU0lXX1FQX1NUQVRFX0lE
TEVdID0gSUJfUVBTX0lOSVQsDQo+ICsJW1NJV19RUF9TVEFURV9SVFJdID0gSUJfUVBTX1JUUiwN
Cj4gKwlbU0lXX1FQX1NUQVRFX1JUU10gPSBJQl9RUFNfUlRTLA0KPiArCVtTSVdfUVBfU1RBVEVf
Q0xPU0lOR10gPSBJQl9RUFNfU1FELA0KPiArCVtTSVdfUVBfU1RBVEVfVEVSTUlOQVRFXSA9IElC
X1FQU19TUUUsDQo+ICsJW1NJV19RUF9TVEFURV9FUlJPUl0gPSBJQl9RUFNfRVJSDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgaW50IGliX3FwX3N0YXRlX3RvX3Npd19xcF9zdGF0ZVtJQl9RUFNfRVJS
ICsgMV0gPSB7DQo+ICAJW0lCX1FQU19SRVNFVF0gPSBTSVdfUVBfU1RBVEVfSURMRSwNCj4gIAlb
SUJfUVBTX0lOSVRdID0gU0lXX1FQX1NUQVRFX0lETEUsDQo+IEBAIC01MDQsNiArNTEzLDcgQEAg
aW50IHNpd19xdWVyeV9xcChzdHJ1Y3QgaWJfcXAgKmJhc2VfcXAsIHN0cnVjdA0KPiBpYl9xcF9h
dHRyICpxcF9hdHRyLA0KPiAgCX0gZWxzZSB7DQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgCX0N
Cj4gKwlxcF9hdHRyLT5xcF9zdGF0ZSA9IHNpd19xcF9zdGF0ZV90b19pYl9xcF9zdGF0ZVtxcC0+
YXR0cnMuc3RhdGVdOw0KPiAgCXFwX2F0dHItPmNhcC5tYXhfaW5saW5lX2RhdGEgPSBTSVdfTUFY
X0lOTElORTsNCj4gIAlxcF9hdHRyLT5jYXAubWF4X3NlbmRfd3IgPSBxcC0+YXR0cnMuc3Ffc2l6
ZTsNCj4gIAlxcF9hdHRyLT5jYXAubWF4X3NlbmRfc2dlID0gcXAtPmF0dHJzLnNxX21heF9zZ2Vz
Ow0KPiAtLQ0KPiAyLjM1LjMNCg0KTG9va3MgZ29vZC4NCg0KQWNrZWQtYnk6IEJlcm5hcmQgTWV0
emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0K

