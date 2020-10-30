Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B062A05CE
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 13:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ3Mvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 08:51:52 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:17364 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgJ3Mvv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 08:51:51 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c0afd0000>; Fri, 30 Oct 2020 20:45:49 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 12:45:49 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 12:45:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEDm3qWRvl8sOWtve7etCgfRlzLUST4aGshBPOArrK8PlSmNYX8qTTly1NVZs4DqxvR1yYCtB2C9jrVV44crVcRTV0DZQX6hmryobYGmqKu7TqD9u3aWE1J37YzvVIxqAfGBuGlezuiooVmwdmFmeifSOtc65kSakN5AYdTtIZ7dfwQggDlN5/aiLwxiN1SRyyB8iHmdaVA02cPeiFxiHogbf+oOCpywEphm+ADHHSPm2nDrpHlPwyBIX+XiMqHjrwhr5VtlptMOFcjpVyAzp2pqTe1nfGkUoGg8sTjzyqJjvf4ibQ5Al4hHy7EsrSsS1VFLtAGsBt+RyHmHXh4AfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EhxMnDQqLNYqarr0OljSHaxmm1ftTtHB7xWbLppKUQ=;
 b=D3fqbe0pZiK1Zd7NNpmXzuGm2FQzvlopA2ilHctEs2sDvkbuDY7+47XaBqKiWCIFa98N3Z3zwpuQGaw/kYZNdaQHrPR6vhA2X4BO/wVbbO+I/FO4LXWkSoNcDE0facjOrNnlpWt2fIgTRMI95gDcHbS1qg6IV05dftRysq+6rPo0Y5KcXeWbte3G4Pi1YC3bqkA700/w8LyqXwUEjvkwG28VUA4xnV11WNeGDG723Ubbr2mTSHVYNKF6GGnPEmWhlDHnbfbvU/If2d9jEEX8zSXtITGPMUNde81giWeBZkwexTzCM3vUsaT2zHQCEu01oE0EUemcnywmnD7oK2UwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3906.namprd12.prod.outlook.com (2603:10b6:a03:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 30 Oct
 2020 12:45:45 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%5]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 12:45:45 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "mike.marciniszyn@cornelisnetworks.com" 
        <mike.marciniszyn@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Yanjun Zhu <yanjunz@nvidia.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com" 
        <syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com>
Subject: RE: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
Thread-Topic: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
Thread-Index: AQHWrqBx4YCOFZzfVECVfqa+5862T6mwEAaAgAAArQCAAAX/kA==
Date:   Fri, 30 Oct 2020 12:45:45 +0000
Message-ID: <BY5PR12MB43221AFDF37580F944C13967DC150@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201030093803.278830-1-parav@nvidia.com>
 <20201030121731.GA36674@ziepe.ca>
 <71c2013a-e9af-470c-9fae-30fc0cf78ee3@cornelisnetworks.com>
In-Reply-To: <71c2013a-e9af-470c-9fae-30fc0cf78ee3@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
x-originating-ip: [49.207.200.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25cae3db-dbf6-4cf2-a88f-08d87cd1b82e
x-ms-traffictypediagnostic: BY5PR12MB3906:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB39065012C58D99A1663CD4EDDC150@BY5PR12MB3906.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HGbTApFvgcrPsDqvdK2TRbAg2npd2aGkLqb/+DvxQX9JZVCXE3StHDWXO7X2VsbyJ3b1lHgdKTxfU2bDNKKYbQ1WpwTj8JR8q06TgUFeAyRo6qUx5GpFmPJN2rczljW2XQ6kSn/oYrxiXiI68QJki6JEeRiF4Ah1624K2rH9++ptuUPFWjToRu1bul+25UQZZ9dEdUgXfx06+2MnIDw3+bMug8G2GcnGz4hF19KA7wJY+e6RiArMKXuKqNSmDR1nDD0h6iBPb4CQQz5LKeBsK25IiZb+26ValzffAKF1ILe9PCq5P+Dc7guVidfBdTh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(186003)(66946007)(76116006)(478600001)(55236004)(4326008)(6506007)(53546011)(2906002)(8676002)(26005)(7696005)(9686003)(33656002)(8936002)(86362001)(316002)(66446008)(64756008)(66556008)(66476007)(5660300002)(110136005)(54906003)(71200400001)(55016002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: v8LRtxd+d4g0ZkEvpQfGhtZsiR/RVleyhwikhTYfe9PkiEOSB5dZmjFnZXICUhdxiWx+CkMMTHqLM/oeea5bz7YR4X6ulGZ/FZWjad6vyAAZ3MdkphjNEozee7XKlyTs5ZYpRocHZ5X2sU9RVB/q3mqDPl1vPc/ZwpydnFfcujpXPztuk6Fc6P/ofT8gMU4MO8DiyQAeng5ihIbU0nkxMmVlY8MYDdnHKgk38g1EQO/w9f502y0IVm832XORQdO9ysgTDwU1BR7fn0MCrsWv0kzx3xpxwW6kJdY+163QiCVR3R5j0VPyIPhx5OXa0D1KOalnQC5tsj55jg2jgMbTEOGnNlYCJihYyY/H/fsV8BX0G9H/v71Wk39iNsOVFL4q8j9Cw0Gmn6CtoHlo5KtB0uG+vAwZ0uQ83ukV5+KGpebD8vVfuRgUqEEiyyUOuhTKgnMEzCRkoRmtL5Ai5nLiQo6hdEiabhL2glwRQqTiRVJf6t4+8v0LHQv4pCTCrUvsOsmh586ldMQAzHu4F7CJrYiQ63PBvyTIZpcZDrQ8454Q/QWv8ycG3yKXcxdGFLrT5r59dYF9els6VSiG0SUMNkTRZUlheEQ2dy1+9zB9L06X9sa3A0sJLw860/QJzsdRbbYml7BNq9OgCCdN7vO/wQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cae3db-dbf6-4cf2-a88f-08d87cd1b82e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 12:45:45.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3tzPNvvyUZw1uwcRS4eFyGao6EENQuKDI5dln0gW8SrpG+S3TliC5S7rwiE04JzmwwG+7vCLY8lnkL0s77qy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3906
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604061949; bh=0EhxMnDQqLNYqarr0OljSHaxmm1ftTtHB7xWbLppKUQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=QenYE3pz3UBrztdmMOQviQfaWN5BFK7CS87Z5iMcdh8dRQlrso/jMVEBH0eHvbIEY
         I/iRjQ9snbvBegqYhKQYdSbuGCUedYlvt2oipEnQufY0dYDvIz9A0A8/07QeYQy2NB
         S2VaXrzxJkCqlwHjhOSx85Q3SJnp8EW67fGLjlMQCjSZ3vz2x4MVkBY8jx4SIGyFyP
         n1xrPnkpu7KBqe8k36nwm24yMlzmveN7iE84quZwON6VkAPJUo+Q7Hx8dzoHoKhQbM
         sLCKzFN6PwV+luV9LNP371zoWrK0gB84VRQ7TPrImucu4pizC/wO71QZol9y/Cc3YA
         AjeyRMxHm4NyQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogRGVubmlzIERhbGVzc2FuZHJvIDxkZW5uaXMuZGFsZXNzYW5kcm9AY29ybmVs
aXNuZXR3b3Jrcy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAzMCwgMjAyMCA1OjUwIFBN
DQo+IA0KPiBPbiAxMC8zMC8yMDIwIDg6MTcgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4g
PiBPbiBGcmksIE9jdCAzMCwgMjAyMCBhdCAxMTozODowM0FNICswMjAwLCBQYXJhdiBQYW5kaXQg
d3JvdGU6DQo+ID4+IEBAIC0xMTQwLDcgKzExNDEsMTAgQEAgaW50IHJ4ZV9yZWdpc3Rlcl9kZXZp
Y2Uoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwNCj4gY29uc3QgY2hhciAqaWJkZXZfbmFtZSkNCj4gPj4g
ICAJCQkgICAgcnhlLT5uZGV2LT5kZXZfYWRkcik7DQo+ID4+ICAgCWRldi0+ZGV2LmRtYV9wYXJt
cyA9ICZyeGUtPmRtYV9wYXJtczsNCj4gPj4gICAJZG1hX3NldF9tYXhfc2VnX3NpemUoJmRldi0+
ZGV2LCBVSU5UX01BWCk7DQo+ID4+IC0JZG1hX3NldF9jb2hlcmVudF9tYXNrKCZkZXYtPmRldiwN
Cj4gZG1hX2dldF9yZXF1aXJlZF9tYXNrKCZkZXYtPmRldikpOw0KPiA+PiArCWRtYV9tYXNrID0g
SVNfRU5BQkxFRChDT05GSUdfNjRCSVQpID8gRE1BX0JJVF9NQVNLKDY0KSA6DQo+IERNQV9CSVRf
TUFTSygzMik7DQo+ID4+ICsJZXJyID0gZG1hX2NvZXJjZV9tYXNrX2FuZF9jb2hlcmVudCgmZGV2
LT5kZXYsIGRtYV9tYXNrKTsNCj4gPg0KPiA+IFNpbmNlIHRoaXMgbWFzayBkb2Vzbid0IGFjdHVh
bGx5IGRvIGFueXRoaW5nLCB3aGF0IGlzIHRoZSByZWFzb24gdG8NCj4gPiBoYXZlIHRoZSA2NC8z
Mj8NCj4gDQpDaHJpc3RvcGggZGlkIHNheSA2NC1iaXQgZ29vZCBlbm91Z2gsIGJ1dCBoZSBtZW50
aW9uZWQgdGhhdCBpdCBpcyBub3QgY29ycmVjdCBvbiAzMi1iaXQgcGxhdGZvcm1zLg0KU28gaXQg
aXMgb25seSBmb3IgdGhlb3JldGljYWwgY29ycmVjdG5lc3MuDQoNCj4gVGVjaG5pY2FsbHkgdGhl
cmUgaXNuJ3QuIFdlIGFyZSBhbHJlYWR5IGRlcGVuZGVudCBvbiA2NGJpdCBjb25maWcgYW55d2F5
Lg0KPiBNaWtlIE0ganVzdCBicm91Z2h0IHRoaXMgdXAgaW4gYSBzaWRlIGJhciBjb252ZXJzYXRp
b24gYWN0dWFsbHkuDQpGb3IgcnZ0IGRyaXZlciwgSSBzaG91bGQgZHJvcCB0aGUgY2hlY2sgYW5k
IGFsd2F5cyBzZXQgdG8gNjQtYml0Lg0K
