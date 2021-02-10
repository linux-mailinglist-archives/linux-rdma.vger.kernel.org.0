Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11CC315F52
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 07:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhBJGU0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 01:20:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3936 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhBJGUY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 01:20:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6023796c0000>; Tue, 09 Feb 2021 22:13:00 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 06:12:59 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 10 Feb 2021 06:12:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H400jMI6ubxboOF8iFjBJV90oD3LmpZzCujXoN/bijTB5C9Gt71OfWmVY2xu9YCsTfcWwySIwzTXfLqhc3J+r/jtt4exv9i07EwMQBxXJ++34Cl7DNWqoM1oYROqY63U52o0z4w31pIFh+QVkACgzXf0LemgUo39IFJfYDikwYTdTuvPi0Zhdhyo7cX4rxXMZkkP/AGtmMaxqmX5aWNTWjYirKezLOjDf4maO1S4ZAXQcMdQuX2G7kO5/EtmO4H2OzDONxHgpmnbiU6fa+TeRpzW83tzYHtUsQ1XpB850cqua62YZbY2miBhNOqeTArbg4JLzz+1HNqUf4Zrl0uYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wztzylBZWptFTR3EC1PkH/7HBctqUgiPNc9PjivGpD8=;
 b=dOCVmQE27M64d0NliWPYcwmUAYDiF44EjRuCcIRiOsd3xyb6JJhL0aD7FhPr82CR4jJP8kfdPnV8JeY1myAlN3xUNQJhyGlKmDvIglyOmaYV0LGZyF4JGRdNrdph5zvn+vSMSdJDxJVf8oJJ+KjQ1TCWAf83gBRHcMgxmv/ZDmpJ9R68PHa/TzCz7ob7dW1+E6ZVfn1AmkiM0v74xVSMV1lVLK8/c/LKSHxL9+t01fROhF3/u7V/+WHHIuuULHuLNkhQSsIICOmncyWtim9iJMk2ejCEtf/nrYoone8yVdmUGn5EgfEIND1qd0y5lRDcHkKIAeUdxd8iw1tbXnJ2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 06:12:58 +0000
Received: from BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::e16c:ea19:c2a6:d8b8]) by BY5PR12MB4209.namprd12.prod.outlook.com
 ([fe80::e16c:ea19:c2a6:d8b8%5]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 06:12:58 +0000
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Roi Dayan <roid@nvidia.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        Feras Daoud <ferasda@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] net/mxl5e: Add change profile method
Thread-Topic: [bug report] net/mxl5e: Add change profile method
Thread-Index: AQHW+7zlE8Rm/BjG+EOLmP6igggBSapQ8BOA
Date:   Wed, 10 Feb 2021 06:12:58 +0000
Message-ID: <82d9b9b7b0b063aaab358041906baf3ac48ec4a9.camel@nvidia.com>
References: <YBz2CSKUBlUCRxsZ@mwanda>
In-Reply-To: <YBz2CSKUBlUCRxsZ@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3 (3.38.3-1.fc33) 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [24.6.56.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 247a3f06-469d-4e49-fe97-08d8cd8ae9bc
x-ms-traffictypediagnostic: BYAPR12MB3527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3527DE3AE5F66122234C90EDB38D9@BYAPR12MB3527.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60gIkMUcEoBg87xus7I9XxTeyghy+gAxzFFiR+aQBjFw8UAreTpXlyrm2a+DAVkBDbKLy/gpZ5wrT6O0Y8PBhieSWOLImT7IZawNlHEFzVdZHaaqDvOPCWJs5WiRNxWtjyFfQk9d/dwXKheoDMcAlgb6kG3ojulm6IEEI1jVa7cHSAwn/MD9Q9u241DTP7vRfxZ3IUwXlIrthJEC9Aa0EhkRQBaK1S9ekijgNuGXJyqrdg9wb5LwfXR9BKXjezK96InBmLzN1kJuDZfpBoRmr5b5DQzBBrhSHLCF1dP+5SLYqgvHO/yxcy3LvcUANY9DQYuiTBVliC+I5K38gKK1Hzp6JkMXPQYeiRw2pCLLa+/AJz6TtUjwXDepe84xCPDFP3qEj3WbB7+JFGkF0NiHhJX60o/9p8PHUC1SaKmaD7vRGacEmCedAG0ZoL8VMeontW+XAUMB7aQF186lmLGdqGalEMNUM9PRgIHSIx1mrLICCbUjTofCjiWPM02KDUvctBV2VmrnjjttHOQjtOaAkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4209.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(26005)(6506007)(6636002)(5660300002)(478600001)(2906002)(66446008)(86362001)(6486002)(4326008)(2616005)(36756003)(8676002)(66946007)(6512007)(110136005)(66556008)(8936002)(64756008)(71200400001)(186003)(316002)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UDFsN1lUMnJkWTlqWjRIaFI3TUd6T0ZzbDVYY3BaZ2x6L1h3VTN0cWk4Mmxa?=
 =?utf-8?B?UXJQaFgzbm5zWWpFTnRBZWRqeC9QOGlwSGUyWmxNQVRwVnZpbjJJUU1UcEVs?=
 =?utf-8?B?QnhjeUUyVnBMSkpoQzAxM0M2MlkwK3BiVFNxL053d1Vka3RXdkFBanJKc3c5?=
 =?utf-8?B?VWhlR1pQTDI1alJFK1JlL0V4NnlNb2ZsdHhneGdRU3Q4SityTURHR2pxRTJI?=
 =?utf-8?B?T2lrc3BlZjQwalBrMER1bzhGUXcwSWpjNmk1UlhiZ1ZOUGpCSjdhMjcyK3NU?=
 =?utf-8?B?RWFDSThKbzdVQXg0NmRKa1JJM0ZPY0RJaFpTc1UvSmprMHZ0UEhSSlIwb3Fw?=
 =?utf-8?B?WTAzQ2FBR3JEWnRqanN3aVZoOUhvV2I1bTc4Y2tYZW5nS2Y2ODhlbEo3VDd3?=
 =?utf-8?B?VnYxZDRaK0ljS2phOWNPWlpMTC9aQk1sOXB0RHBmNjRkR2RWeElUdXErVTBB?=
 =?utf-8?B?eU5XcWJndXF4ZEJPQ3JDZ3BIWlJvTE13NkNrZTVrZHdDenhxODg4UTJpWjNt?=
 =?utf-8?B?ajR1bXlsRUw1RlpISE81V3ljVSttVW5mZXhXdk9DVHIwUlBlTjhXZG1meWpj?=
 =?utf-8?B?OE1SaGxVSWNIajEraXh2UkJ2cnJhSHludDBsYkR5c21iRlA1RU9JRzFmaUVS?=
 =?utf-8?B?dUxLODkxaWZvak9uZTBDUW1HK2pEWDNHdmhvdkhwRmMvSkoxdklQdG5vcms1?=
 =?utf-8?B?ckRRV0hjZ0p0ZnBxa0NzaFF4NW5qVGpoMENLQnN4QXVPa213b01CZnA5ZFZo?=
 =?utf-8?B?Y1JKWmxheXJVNDFUeWp5WURDU2FvRDZyZzgwUUUvYWkzeWQxbFRjczJTL0pW?=
 =?utf-8?B?NytCL2xkWEd2REhGbFh0am1jL2JiUmZHaXpTaERGK2hoSiswWGROWXBmOGth?=
 =?utf-8?B?QUExanZ1bFh5ZGJhSERqK2RsTEozOXB6emducDhzc0d6UktWMmdybnR4V1BP?=
 =?utf-8?B?aXFNdHptOFVBMEtZTUhHb0VCSGYzZWpyYi9WTEpraXlEQ0tWSUk3Y0dUc21D?=
 =?utf-8?B?emxUVGl4Y3RPR2xtRXk2OHpxdEE3NFVrSmxUOVRPNTFFMVJjTjFST3IzNkVS?=
 =?utf-8?B?L3pxaTB4QXQxOTV2MUh1eDNycFNEdUJZYVZvOC9XLzcrb2JHdkFHZmtwMGIv?=
 =?utf-8?B?SFBHd09mait4elYya3h1Zkp5Z2RyakVrdHF2bENKMnRaOE5GOU4wTGVNem1V?=
 =?utf-8?B?MkRIbm9KbmhHZUVFTUJKYjJNS1MzYzJ2S0dwMm9NbUNPdXpObGpsVWxlNUR6?=
 =?utf-8?B?d280c2FtK0hKSURkeENZL01tNnBTeHdHY01LbmUwN21FRXF3cE55NldFT2NY?=
 =?utf-8?B?L204ZVI5VVpSMUxWaGF6cjlhL2NYMlJTT2s2N2lVc1VHUmFuS2gwbWhYdjVR?=
 =?utf-8?B?cnZCQ0hzTmJqUnNIS1kwN2RyS0poRE9HTFpKNW1kMFIwa2ZQRFA4Y3pqbHFI?=
 =?utf-8?B?ZmpjVTZwcWkxL2xyditPVndoRFU0dVdQK2xaQStyaFpISmc4RGNrbjVSMk4v?=
 =?utf-8?B?ZUNhcE9Ka05veEdXeVpYdVhqb3BKdGdCMUhPaHRnV0hja0oxQ0xYRzNTNXVL?=
 =?utf-8?B?WmVZdzY4SkcvSFR2WkdCYWdBRU5pYlVReUpmVEt4QlEra3M0cGFHTlBsUDRm?=
 =?utf-8?B?NmFVSHAvaFo2OGFhVnB6d2NLZ3YrWVJhVnBkV0NPZTMwa0tPbmd1TDUzSkhq?=
 =?utf-8?B?Q2VvRGQ3cVAyNXl1a25mNVZUMEJJUW1qd0F0SUt3cGtzUHJzVmtldXJZM29V?=
 =?utf-8?Q?NmYk6T5gZRrMZnwJ71XgIoEzkPPmqwbhwuY+8zW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B3AF1CF233D847AD4FFCC019803A6A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4209.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247a3f06-469d-4e49-fe97-08d8cd8ae9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 06:12:58.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S91TW7aYcagkKHtafMICSEOyiYHGJ58yLx2JAfwO39hjQ+Udf18xSBAKRQ0yNBleRgBOxuAe9By+S00VyOFvrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612937580; bh=wztzylBZWptFTR3EC1PkH/7HBctqUgiPNc9PjivGpD8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:user-agent:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:x-header:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         Content-Type:Content-ID:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=FDvSgM++AnvLmMh02bs/aHRONB4J43x0FOzomce7QXgRXbeDSiuU00R7Zsw2/2CcJ
         gwHzIgE2uK8nq23oXPw1oOTXH/PiNlp6U5bW5+r8FVG/ov6x68VHDX4iMqd97jzGGt
         R6dpKf5+h8WOrZZON59cxpynv/ssCYslnNF56t1KXvqeqrfRiOejLyXhsREnnc38RI
         QFRD9yGKGiczFkozQ6JXr3JPXtPiL4OAe4aPNiE6EtrGwg5DOivA2Omp93YG1/vMwp
         7Pvlf081TmeDOY3kLOkIh+4s9y51ZF9ps1KZ6Fo/59h8XCYfwPTM/HAdqcRH9M48xE
         WQH3drUaQgv5Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCAyMDIxLTAyLTA1IGF0IDE1OjQ1ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBIZWxsbyBTYWVlZCBNYWhhbWVlZCBhbmQgRmVyYXMgRGFvdWQsDQo+IA0KDQpIaSBEYW4sIHRo
YW5rcyBmb3IgdGhlIHJlcG9ydCwgYWRkaW5nIFJvaSB0aGUgb3duZXIgb2YgdGhpcyBjaGFuZ2Uu
DQoNCj4gSSdtIG5vdCBleGFjdGx5IHN1cmUgaWYgSSBzaG91bGQgYmxhbWUgY29tbWl0IGM0ZDdl
YjU3Njg3ZjoNCj4gIm5ldC9teGw1ZToNCj4gQWRkIGNoYW5nZSBwcm9maWxlIG1ldGhvZCIgZm9t
ciBNYXIgMjIsIDIwMjAgb3IgY29tbWl0IDE4MjU3MGIyNjIyMw0KPiAoIm5ldC9tbHg1ZTogR2F0
aGVyIGNvbW1vbiBuZXRkZXYgaW5pdC9jbGVhbnVwIGZ1bmN0aW9uYWxpdHkgaW4gb25lDQo+IHBs
YWNlIikgZnJvbSBPY3QgMiwgMjAxOC4NCj4gDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxh
bm94L21seDUvY29yZS9lbl9tYWluLmM6NTY1OA0KPiBtbHg1ZV9uZXRkZXZfY2hhbmdlX3Byb2Zp
bGUoKSB3YXJuOiAncHJpdi0+aHRiLnFvc19zcV9zdGF0cycgZG91YmxlDQo+IGZyZWVkDQo+IGRy
aXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9tYWluLmM6NTY1OA0KPiBt
bHg1ZV9uZXRkZXZfY2hhbmdlX3Byb2ZpbGUoKSB3YXJuOiAncHJpdi0+c2NyYXRjaHBhZC5jcHVt
YXNrJyBkb3VibGUNCj4gZnJlZWQNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL2VuX21haW4uYzo1Nzg5IG1seDVlX3Byb2JlKCkNCj4gd2FybjogJ3ByaXYtPmh0Yi5x
b3Nfc3Ffc3RhdHMnIGRvdWJsZSBmcmVlZA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5v
eC9tbHg1L2NvcmUvZW5fbWFpbi5jOjU3ODkgbWx4NWVfcHJvYmUoKQ0KPiB3YXJuOiAncHJpdi0+
c2NyYXRjaHBhZC5jcHVtYXNrJyBkb3VibGUgZnJlZWQNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYzo1ODAyIG1seDVlX3JlbW92ZSgpDQo+IHdhcm46
ICdwcml2LT5odGIucW9zX3NxX3N0YXRzJyBkb3VibGUgZnJlZWQNCj4gZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYzo1ODAyIG1seDVlX3JlbW92ZSgpDQo+
IHdhcm46ICdwcml2LT5zY3JhdGNocGFkLmNwdW1hc2snIGRvdWJsZSBmcmVlZA0KPiBkcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcmVwLmM6MTMxNw0KPiBtbHg1ZV92
cG9ydF9yZXBfdW5sb2FkKCkgd2FybjogJ3ByaXYtPmh0Yi5xb3Nfc3Ffc3RhdHMnIGRvdWJsZSBm
cmVlZA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcmVwLmM6
MTMxNw0KPiBtbHg1ZV92cG9ydF9yZXBfdW5sb2FkKCkgd2FybjogJ3ByaXYtPnNjcmF0Y2hwYWQu
Y3B1bWFzaycgZG91YmxlDQo+IGZyZWVkDQoNCklmIEkgbWF5IGFzaywNCldoYXQgaXMgdGhpcyBy
ZXBvcnQgPyBDb3Zlcml0eSA/IHN0YXRpYyBjaGVja2VyID8gb3IgcnVudGltZSBjaGVja3MgPw0K
DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fbWFpbi5j
DQo+IMKgIDU2MznCoCBpbnQgbWx4NWVfbmV0ZGV2X2NoYW5nZV9wcm9maWxlKHN0cnVjdCBtbHg1
ZV9wcml2ICpwcml2LA0KPiDCoCA1NjQwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBtbHg1ZV9wcm9m
aWxlDQo+ICpuZXdfcHJvZmlsZSwgdm9pZCAqbmV3X3Bwcml2KQ0KPiDCoCA1NjQxwqAgew0KPiDC
oCA1NjQywqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBuZXdfbWF4X25jaCA9IG1seDVl
X2NhbGNfbWF4X25jaChwcml2LA0KPiBuZXdfcHJvZmlsZSk7DQo+IMKgIDU2NDPCoMKgwqDCoMKg
wqDCoMKgwqAgY29uc3Qgc3RydWN0IG1seDVlX3Byb2ZpbGUgKm9yaWdfcHJvZmlsZSA9IHByaXYt
DQo+ID5wcm9maWxlOw0KPiDCoCA1NjQ0wqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKm9yaWdfcHBy
aXYgPSBwcml2LT5wcHJpdjsNCj4gwqAgNTY0NcKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgZXJyLCBy
b2xsYmFja19lcnI7DQo+IMKgIDU2NDbCoCANCj4gwqAgNTY0N8KgwqDCoMKgwqDCoMKgwqDCoCAv
KiBzYW5pdHkgKi8NCj4gwqAgNTY0OMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobmV3X21heF9uY2gg
IT0gcHJpdi0+bWF4X25jaCkgew0KPiDCoCA1NjQ5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBuZXRkZXZfd2Fybihwcml2LT5uZXRkZXYsDQo+IMKgIDU2NTDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIlczogUmVwbGFj
aW5nIHByb2ZpbGUgd2l0aA0KPiBkaWZmZXJlbnQgbWF4IGNoYW5ubGVzXG4iLA0KPiDCoCA1NjUx
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBfX2Z1bmNfXyk7DQo+IMKgIDU2NTLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRUlOVkFMOw0KPiDCoCA1NjUzwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gwqAgNTY1
NMKgIA0KPiDCoCA1NjU1wqDCoMKgwqDCoMKgwqDCoMKgIC8qIGNsZWFudXAgb2xkIHByb2ZpbGUg
Ki8NCj4gwqAgNTY1NsKgwqDCoMKgwqDCoMKgwqDCoCBtbHg1ZV9kZXRhY2hfbmV0ZGV2KHByaXYp
Ow0KPiDCoCA1NjU3wqDCoMKgwqDCoMKgwqDCoMKgIHByaXYtPnByb2ZpbGUtPmNsZWFudXAocHJp
dik7DQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IG1seDVpX3BrZXlfY2xlYW51cCgpIGNhbGxz
IG1seDVlX3ByaXZfY2xlYW51cCgpLg0KPiANCj4gwqAgNTY1OMKgwqDCoMKgwqDCoMKgwqDCoCBt
bHg1ZV9wcml2X2NsZWFudXAocHJpdik7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4NCj4gQW5kIHRoZW4gaXQgZ2V0cyBjYWxsZWQgYWdh
aW4gaGVyZS4NCg0KaW1wb3NzaWJsZSwgbWx4NWkgd291bGQgbmV2ZXIgY2FsbCBtbHg1ZV9uZXRk
ZXZfY2hhbmdlX3Byb2ZpbGUsIGJ1dA0KYW55d2F5IGkgc2VlIHRoZSBpc3N1ZSB3aXRoIHRoZSBl
cnJvciBmbG93IGlmIHRoaXMgZnVuY3Rpb24gZmFpbCBhZnRlcg0KbWx4NWVfcHJpdl9jbGVhbnVw
LCB0aGVuIHdlIHJlbW92ZSB0aGUgZHJpdmVyLCB3ZSB3aWxsIGFjdHVhbGx5IGVuZCB1cA0Kd2l0
aCBkb3VibGUgZnJlZSwgc2luY2UgdGhpcyBmdW5jdGlvbiBpcyBub3Qgc3VwcG9zZWQgdG8gZnJl
ZSBwcml2LQ0KPmZpZWxkcyBhbmQgdGhlbiBqdXN0IGFib3J0Li4gDQoNCnRoaXMgZnVuY3Rpb24g
bXVzdCBndWFyYW50ZWUgdGhhdCB0aGUgcHJpdiBpcyBzdGlsbCBpbnRhY3QgYWZ0ZXIgaXQNCnJl
dHVybnMuICBXZSB3aWxsIGhhbmRsZS4gDQo=
