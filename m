Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10073B4424
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 15:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFYNNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 09:13:35 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:1306
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231524AbhFYNNf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 09:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJDab12yjraR1OgqdCNDFHk6uxtdzOrfD76NyZsNVyMz4PV8EiQN+ujxdyYGlHUZnM+cJB36y6Ao8iD/mgIy9tTOFdlPtkbDaemB/czN7RzMKe6orhqOLEv1HuEkDcvSENykPWEHJ9E25qQ0TN5Nf3z3dF0PcV3U3/hbHX3pmkMnu+zIOQKHnqIkbZ6m2JLwaT5hWV7PU+/4SGSSMTvYWPZu4d8iLQLbfJrr3PKeB6gfZd8lVpSCD4FRr3HxQ3l6dFPYGLS/qMYbZyKFl8zV1cuWfA6POWpgpbzmVSkMAASFLCSHY/oDhIoB1ODlCLaXgsKQgmwZ4SwpkafOa1EP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPAdAPH5Q5RfyOtYbASNOV8FVBNi0l/zH84naQ0ZPj4=;
 b=f3uDS/md18pc0lIFnGixAUlvgBrSIaAHLFnwIxw871Wiyy0+sEDUz8d9ZihcspEEtq1BhSmA/LT4Xg1w15u3yuUhL3N2988vrJ2lGm+GDEWYGXmd9wQ0gwaoLR9Ai8HR2JubIf48UBerL0KG2XEa2dfoIftIDGQM/bCS4+AC4Qksnnj7SeXLW6QJuzcYVfzrp7WMcJohdRp9V4eH6/fyLxgX8sqHAXFWwZdPu91/wd5qeogudh4SsV+HpCrFiBqzoTAqETrDwi2fmSVpHAaB+P3siVWEm1U4rBAy9U7yv0U+xz6MSxfe9i2HFDECmrHP3JEpUYx+4gConFbYw5B4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPAdAPH5Q5RfyOtYbASNOV8FVBNi0l/zH84naQ0ZPj4=;
 b=O6zzXcKSvjqjnSA6pLMLaGytGLQOqfozpAFPWREh8m6mtNuhxMva4NUakb9OBZNsXNMuq9Zj08nRDz005OOwyR6LWiO0JZ4S+Lx/5iUwjVItyEOkuLqCxeLJ/muedhIAXDgdI8MxwEu3YzC98O3W9oUs73V9FLXS6oA2T9STcf8H5ZA1ZGHvAVrf2zuYo3HJrxeuA1GSb1t8Y+QT7zwkKQJRC2BxtNm3o9cV1sDt0aVReYwaU+vV8ZTCtzf9rCiAVsmaQhbDKQxzDe70rn+rc3YxZN3lU0f+wvnvy0v75iLs5CCSfaXyMhLSOD/rkldxdsWMLJcagksgsgCLmTDlBw==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 13:11:13 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::35e8:a169:31aa:5f49]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::35e8:a169:31aa:5f49%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 13:11:13 +0000
From:   Majd Dibbiny <majd@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: missing unlock on error in get_srq_wqe()
Thread-Topic: [PATCH] RDMA/rxe: missing unlock on error in get_srq_wqe()
Thread-Index: AQHXacJ7diGFcmjlzkKyOhVjzuyRe6sks6Bj
Date:   Fri, 25 Jun 2021 13:11:13 +0000
Message-ID: <7C487162-97A6-426E-99CD-C8742782414C@nvidia.com>
References: <YNXUCmnPsSkPyhkm@mwanda>
In-Reply-To: <YNXUCmnPsSkPyhkm@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2.53.137.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b1cc91b-076b-416f-d854-08d937dab559
x-ms-traffictypediagnostic: PH0PR12MB5451:
x-microsoft-antispam-prvs: <PH0PR12MB5451B505D7358625A6039B79AA069@PH0PR12MB5451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amkBzmoKa5VReFbPYW3jE79KGl0DhcBpf8guJhLJMGhFqPtxod/qsJg07UAme0Yywv9LtQzMyV17KLcCqBo11jNlVIEk8UXW45rm+hOuJh1dgp0KvJWfj4xPnYPNvsVbA/E8U2diBOPgI+mMnfZ72t8rFImNkdt+Z0KUo7dChBdkS4w7QMKVX1weFh3wBuQi2wloiKrp4R6CUYksBxJrWHnXrOQ+0xoMzspKWULyu0pE25RqNkKtoy+9LguoOAEcxWPHnEjpL5lXkSYBMWqi3FLbxEKMb2WGh74f6jV2qE0i2Iz/4g5sWLPNqhftOdnlgEtKenXabxAwO1x3S/K6fXMV3zKdgordHTM1K+vacOb52W6p4RKImT+B2megfys4XAgfdp2z9naTebNkYQGC/oC+pdgRGqgTPj+Rff3mg6jBnaCsY9oas2OCiGxQlQ7rSmfD9K2VYA9iSCKklJviOhhP3bubO27YbKuYKuDDqIKxuSKBOMaTgBYVrqDx6RUJFGk3Qr6lo4a4NgvRaGAKqmuL1sgk9ngU0DxBD2X/IsUWPrIS6NgYLXdO1eIvH/uZXsTciqtkTDSKuf3zrZE8b/zav6pkEnmtGaM2hqrr9bxzSz0ut317L85uWXgkGE95khIXdbTnYVLzG3N66MkAWlQccKbVakFaN5otkDAhbw3LPPvpFtVctfYtFwXxpjtGqc2mDS2XEFoxU3McSqEiQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(83380400001)(4744005)(2616005)(122000001)(38100700002)(5660300002)(71200400001)(86362001)(4326008)(33656002)(2906002)(6486002)(91956017)(76116006)(6512007)(53546011)(6506007)(26005)(66446008)(64756008)(66556008)(8936002)(478600001)(66946007)(186003)(36756003)(6916009)(8676002)(54906003)(66476007)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3BuNCtxWGxtempJdVV2bThyTkpLWXp3TTI1KzJPZlk0aXpkQ3hXdGExYW9m?=
 =?utf-8?B?SzVMUnRWWmI2REc5UCs5R0ZhMHZZaTVGMTF0QnNJWG1TTlVUcWhZUDFFdG1w?=
 =?utf-8?B?SkpoamhqS0RoRG1WYmhzdjNMZGx4QzdWYmVqVXVodUh5RitwRnY4d01tM25I?=
 =?utf-8?B?L2owak9uZCt6eXdLWENDdko4UW03YlBRLy9XTy8rZ0daZ1BPNldVU3Nudno2?=
 =?utf-8?B?SFlPOVNTRm9lbDNDVWpSYkRKaG43TlpWL1dlOHNGNS96UTU0MC8zeEFVYjdQ?=
 =?utf-8?B?Z0h2azJSS2ZxZlpyUjlaOGE1VGxXT2xkSUNqVTFWQm9uQ1d0VGlONDFWTzBm?=
 =?utf-8?B?eXJDbUFRUld3U0FoYy80cXRoZzV4SGtkbnRzdTZyNGJLUENNOTdxK3hjd2Mw?=
 =?utf-8?B?WmNTcTVQZTZPcVdXRHF5dFVwRnBnWnUrTzhqeXArcW4xMExXa3hGVGUzanli?=
 =?utf-8?B?RzdGVy9zeUxwNThSYURVZnNrRFE4UUNyeWhFdlBLb3B2TFNsQXdSVGpGQUhN?=
 =?utf-8?B?RkJOSENXdTlEUDVhT09Wb0JUUmxPeXR1eWpmVTBRVUQxUklRTldvQ09RWjdF?=
 =?utf-8?B?M0lTS1VzVkVQNEttaVNWT1k0WDZsOVQxUDEvTjl6bW9HWFVSV3JJcS9JS2FU?=
 =?utf-8?B?UmxCVDVxTitkVzhGNVdCYkVmaWJyREIxM1llcFlBa2FRbjVITEpDSmpSK3Vj?=
 =?utf-8?B?WG9wSXZGOUxGZjJlbktjd2Zvalc5c09HR1dCcmFXR1FuVmREd240TkpMbVF2?=
 =?utf-8?B?Q1JpS2svcTdaZHRuWEV6V2RacUtGRVNNVFYzZXBadVc1QkptQzNVY1JxTTYz?=
 =?utf-8?B?RDBKM0VoaTBmSzN3K3d4MkdHc0psZXE2Tmo2NFZTRWxYeWJiN3Mwb2tZQXB6?=
 =?utf-8?B?OTEvaGM3UXc4ajVKY1pRVVNtdFhNOXBiU1NhZll1b3BFeDJKL2M0YjMrTEI2?=
 =?utf-8?B?akh1b3ZWcW1pSDY3OVpvL2FpVFowaTY2aytVVjVwWW9kb0RvY1dEa201bVZj?=
 =?utf-8?B?cVpuaWNyRHVSdGxabnBPMzJaakpFeVU2cmhnU3lNYXE2WFF5V2U0NHBvc2JW?=
 =?utf-8?B?ejVRTzNnbnpmRDlPZDJQbG0zQmVLeDlKcFYvTUVzWllBNmpuZmlqbnlyZGcz?=
 =?utf-8?B?SGFPMC9PRnE2eUxOQzZ5R0hBQzdLNDNQTDlaVGFpV2dXS05RZGdBczdMV3kr?=
 =?utf-8?B?OHQ0ZHRuaXh2QXJoVitjbEVEWTVFa1E1clUwa24reHhCV3paaWxVSEVPZUVr?=
 =?utf-8?B?ZG1QTGR0VGY4UGtoNDYzNk55dWFzZkkwQmtIVVRseWFCTGZLOE5JSUdnUGc3?=
 =?utf-8?B?QWk1bG1uOVY5NnI4WFV2b2xjWGVCb1hNUzlYNjMwVkJhV0JVTWRoMXFySGJl?=
 =?utf-8?B?clB0eUlSK2I5Tkc3RlI5UERVaTZQc0hQeFVTVkdXcGVyMHdHKzBydy9SeFJp?=
 =?utf-8?B?NTBKemdnOU4yN0NVdDFSUnhkamdlaHRKcEhLR3lCVkh5TUFuc0I2bXdXSHJ6?=
 =?utf-8?B?T1JLL21HZ0ZPc3o3TXdyYm1LRWtPck02SUVXOUNzWHJESU4zSVV3U0crUkJp?=
 =?utf-8?B?NzU1NTZodis5ZkpXRmd6dzA3YWJQL0dyU0I3UFhLc2hIR1E1TDlQOGQwZ2xm?=
 =?utf-8?B?ajNYVnkxbnhOWDNQZ2ZtdDA4bkhuQ2NORk9DT2RYUFg1SFdCcUFXNlR3NFhL?=
 =?utf-8?B?YkhZM3pSRElCVDRPWVVjcUs0dExKbHU3blpIeGJHR3J0bE5BK0x3NEMrQVNV?=
 =?utf-8?Q?IXan7KRE9ozBUyELP86xsFWin2jzf7XH1JrKnNk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1cc91b-076b-416f-d854-08d937dab559
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 13:11:13.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GK4T16m2PFFYnVK6Cj2EzN6/wXAj0jzfeLnzjgbB0HcazimloUmg8/sagbiQDOX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IE9uIEp1biAyNSwgMjAyMSwgYXQgNDowMyBQTSwgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBl
bnRlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IO+7v1RoaXMgZXJyb3IgcGF0aCBuZWVkcyB0
byB1bmxvY2sgYmVmb3JlIHJldHVybmluZy4NCj4gDQo+IEZpeGVzOiBlYzBmYTI0NDVjMTggKCJS
RE1BL3J4ZTogRml4IG92ZXIgY29weWluZyBpbiBnZXRfc3JxX3dxZSIpDQo+IFNpZ25lZC1vZmYt
Ynk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NClJldmlld2VkLWJ5
OiBNYWpkIERpYmJpbnkgPG1hamRAbnZpZGlhLmNvbT4NCj4gLS0tDQo+IEknbSBzb3J0IG9mIHN1
cnByaXNlZCB0aGlzIG9uZSB3YXNuJ3QgY2F1Z2h0IGluIHRlc3RpbmcuLi4NCj4gDQo+IGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDEgKw0KPiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9yZXNwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMNCj4g
aW5kZXggNzJjZGIxNzBiNjdiLi4zNzQzZGMzOWI2MGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9yZXNwLmMNCj4gQEAgLTMxNCw2ICszMTQsNyBAQCBzdGF0aWMgZW51bSByZXNw
X3N0YXRlcyBnZXRfc3JxX3dxZShzdHJ1Y3QgcnhlX3FwICpxcCkNCj4gDQo+ICAgLyogZG9uJ3Qg
dHJ1c3QgdXNlciBzcGFjZSBkYXRhICovDQo+ICAgaWYgKHVubGlrZWx5KHdxZS0+ZG1hLm51bV9z
Z2UgPiBzcnEtPnJxLm1heF9zZ2UpKSB7DQo+ICsgICAgICAgIHNwaW5fdW5sb2NrX2JoKCZzcnEt
PnJxLmNvbnN1bWVyX2xvY2spOw0KPiAgICAgICBwcl93YXJuKCIlczogaW52YWxpZCBudW1fc2dl
IGluIFNSUSBlbnRyeVxuIiwgX19mdW5jX18pOw0KPiAgICAgICByZXR1cm4gUkVTUFNUX0VSUl9N
QUxGT1JNRURfV1FFOw0KPiAgIH0NCj4gLS0gDQo+IDIuMzAuMg0K
