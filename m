Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CAA887C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfIDOJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 10:09:31 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57764 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730552AbfIDOJb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 10:09:31 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x84DxaCQ019533;
        Wed, 4 Sep 2019 07:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NGoAxA6EspSO5g97eqy9rLCKqRSLHx4WUV8DVnXmXv4=;
 b=pVarx3Wk9Gxx/Y0PEByGk45SgvTO4EvddGDIN2WA+aU/umFo/r2ryU/6Y8OOn5ey6zeZ
 LDZz8NeB0pDepUveiI0PFVsvaQe/udWzIU8I02rHv90zIsCwpomdo0AMO61cjTkBamTj
 oz4zcCV970oqoEFuMKKUryB+ajk/G83Og3HVsMCnBUGfcFno+DUk8Ypgq+XCa6zJfgIa
 CyKuSkwaT5QMEBqFuB5MoCztEaldfeXI0UmgGBOmJ1WxdJncWk84EEybvzqxxTKtcs/z
 RAq0VeaoO59puHTEOFIOnaNALpnMNbV5hCiHL9pNSzodc7Jj2WkhI3VvcDcMMcGlet3m wg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdme41c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 07:09:24 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 4 Sep
 2019 07:09:22 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 4 Sep 2019 07:09:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beUglQBE9spZELxdwSYODjZ5iAT6L7vHatkdEquRmsLExBZkMZQ3m8VhSL9ZaEQqN3pQteID9ZH4FJfVrUadITRDzSXmqh1gykdJ8u3lEpXdHn7D2RbHY7nkEl48TtWB6PfC+Dwn8BEfwry2FXWASROZ8HG3IHg6GgJ7RDkn/I7gVcstk4WljHCB6Gp+smIg97PYsUw7eDoM0rIZQSACYvWGj/iFrAcbz1OaQgQ3Vh+RDvxzsyHmECQfCbYXGSyzaWzUstjEMLs93rdEiuzb7/hAI1RLY+nB3cxlBDg91SwG+nTM/IMBk23LVTherkW7OR0FEBzoqXldE4O0Th0NFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGoAxA6EspSO5g97eqy9rLCKqRSLHx4WUV8DVnXmXv4=;
 b=MsJ0H7+uoe4dMeN3LBNkcyJyEGsQuvBuGH/ZHMupQbOvbVBmVeZ7U5+mxAhgNEOJd1k/mfzl6z2SGvM53nYjee0qPWX8ODFZadxHm2zIYbG4lYTDqrdPJxQMS/wjys7RUAMMKzjwFJmiq/RI6KWCbUocW8x06KLcmCXVSyYn8dzBWGPZxhAVW8N2Xr8/IHEUUy1dC7dDrsjWJ10sZoPxXZt4xK3og3AenBRBnH2HDZtWzvCRvd8VGGtm/GuDz3r5MkXyoh9RuCHF+OPwd+4uF5snQXutafBAXoZxBoOjgAmGnaOmOr/YjoUa4hqcA3600cFRJCo6A7fmfjIVXamLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGoAxA6EspSO5g97eqy9rLCKqRSLHx4WUV8DVnXmXv4=;
 b=AbkYK/bXup0vyczhtlaGB/iWANx8ASoyHxLYpakOVr4FdNCKJpmzonIoVoTGMY3EbnO4SjDKgYui3wXWF8O5q9TPU3i84AccoFOZzne7ROKIsC+OT/aWTU82dg7g0MDUhe61kONvFapNko6st+hWo2W6/FGlx3wBJJANv0D7274=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3328.namprd18.prod.outlook.com (10.255.238.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Wed, 4 Sep 2019 14:09:19 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 14:09:19 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v10 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Topic: [PATCH v10 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Index: AQHVYvDPgWqW+QOk/Uau4vPgxrtri6cbgkSAgAAI9WA=
Date:   Wed, 4 Sep 2019 14:09:18 +0000
Message-ID: <MN2PR18MB318225B7C3799584D2C7CF28A1B80@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190904071507.8232-1-michal.kalderon@marvell.com>
 <20190904071507.8232-4-michal.kalderon@marvell.com>
 <d6e4d513-556f-d2a4-f5c6-42a54c0ae7f1@amazon.com>
In-Reply-To: <d6e4d513-556f-d2a4-f5c6-42a54c0ae7f1@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1da285c-1acb-42cf-d888-08d731417a5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3328;
x-ms-traffictypediagnostic: MN2PR18MB3328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3328539930F25360C5D04B91A1B80@MN2PR18MB3328.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(33656002)(71200400001)(71190400001)(64756008)(66446008)(66556008)(5660300002)(14454004)(66476007)(478600001)(256004)(8936002)(8676002)(446003)(81156014)(81166006)(476003)(486006)(7736002)(3846002)(6116002)(2906002)(11346002)(86362001)(66066001)(76176011)(53936002)(9686003)(229853002)(74316002)(53546011)(305945005)(6506007)(26005)(186003)(6916009)(102836004)(6436002)(52536014)(55016002)(66946007)(76116006)(7696005)(6246003)(25786009)(107886003)(4326008)(99286004)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3328;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: alAvjc0g1uxmreKDSYh8VmNEzmTnvKKRYJBhHeP3xu6DOu2+/9hVxj4mvrqlW9E4owg/sViWCn3Dfreq6bBSKqjLg6Gcm3tcflaUlggPjjbQAVDBXgAmtnNVdyT6nNA/HyPkDSYEyM9LI6+fGAfGU1m26ds3WIzzSzFLxzf0Jg0i9SIa/I1kXnnKkZdFEnu20CIcMER5vIqoAvC3eOGoO+OM4xcJ7of0IvWW23EMZP1CBO2RGK9qa4baceJhJSBnZH5fLbDvqhN/X4JUIZCmWrvyvj5SmCeUcR4gSWNIQI7YuZBd235i2uICyZ1rMDq5EhFX1liebsf6TrVky7qRUBJfvdeyEpkNEnPiq+uXn1sWVlVNQtAjCs32zCOX/eAQdZ5abkLl0t9i8PTvqAEpqdqihInO8rQHd8go5EUS9Kw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a1da285c-1acb-42cf-d888-08d731417a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 14:09:19.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoeZ2o1I73VJ1ir3VnMpsKdmDR2rl5Gp+p4NX+uk9GWjlHYvLcWiyGlalD+4rgllD7mBcgiiKMRNdsLc4wRH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3328
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_04:2019-09-04,2019-09-04 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgU2VwdGVtYmVyIDQsIDIwMTkgNDoyNCBQTQ0KPiANCj4gT24gMDQvMDkvMjAxOSAxMDox
NSwgTWljaGFsIEthbGRlcm9uIHdyb3RlOg0KPiA+ICBzdGF0aWMgaW50IF9fZWZhX21tYXAoc3Ry
dWN0IGVmYV9kZXYgKmRldiwgc3RydWN0IGVmYV91Y29udGV4dA0KPiAqdWNvbnRleHQsDQo+ID4g
LQkJICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHU2NCBrZXksIHU2NCBsZW5ndGgp
DQo+ID4gKwkJICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHU2NCBrZXksIHNpemVf
dCBsZW5ndGgpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBlZmFfbW1hcF9lbnRyeSAqZW50cnk7DQo+
ID4gKwlzdHJ1Y3QgcmRtYV91c2VyX21tYXBfZW50cnkgKnJkbWFfZW50cnk7DQo+ID4gKwlzdHJ1
Y3QgZWZhX3VzZXJfbW1hcF9lbnRyeSAqZW50cnk7DQo+ID4gIAl1bnNpZ25lZCBsb25nIHZhOw0K
PiA+ICAJdTY0IHBmbjsNCj4gPiAgCWludCBlcnI7DQo+ID4NCj4gPiAtCWVudHJ5ID0gbW1hcF9l
bnRyeV9nZXQoZGV2LCB1Y29udGV4dCwga2V5LCBsZW5ndGgpOw0KPiA+IC0JaWYgKCFlbnRyeSkg
ew0KPiA+ICsJcmRtYV9lbnRyeSA9IHJkbWFfdXNlcl9tbWFwX2VudHJ5X2dldCgmdWNvbnRleHQt
DQo+ID5pYnVjb250ZXh0LCBrZXksDQo+ID4gKwkJCQkJICAgICAgbGVuZ3RoLCB2bWEpOw0KPiA+
ICsJaWYgKCFyZG1hX2VudHJ5KSB7DQo+ID4gIAkJaWJkZXZfZGJnKCZkZXYtPmliZGV2LCAia2V5
WyUjbGx4XSBkb2VzIG5vdCBoYXZlIHZhbGlkDQo+IGVudHJ5XG4iLA0KPiA+ICAJCQkgIGtleSk7
DQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIAl9DQo+ID4gKwllbnRyeSA9IHRvX2VtbWFw
KHJkbWFfZW50cnkpOw0KPiA+ICsJaWYgKGVudHJ5LT5sZW5ndGggIT0gbGVuZ3RoKSB7DQo+ID4g
KwkJaWJkZXZfZGJnKCZkZXYtPmliZGV2LA0KPiA+ICsJCQkgICJrZXlbJSNsbHhdIGRvZXMgbm90
IGhhdmUgdmFsaWQgbGVuZ3RoWyUjenhdDQo+IGV4cGVjdGVkWyUjenhdXG4iLA0KPiA+ICsJCQkg
IGtleSwgbGVuZ3RoLCBlbnRyeS0+bGVuZ3RoKTsNCj4gPiArCQllcnIgPSAtRUlOVkFMOw0KPiA+
ICsJCWdvdG8gZXJyOw0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlpYmRldl9kYmcoJmRldi0+aWJkZXYs
DQo+ID4gLQkJICAiTWFwcGluZyBhZGRyZXNzWyUjbGx4XSwgbGVuZ3RoWyUjbGx4XSwNCj4gbW1h
cF9mbGFnWyVkXVxuIiwNCj4gPiAtCQkgIGVudHJ5LT5hZGRyZXNzLCBsZW5ndGgsIGVudHJ5LT5t
bWFwX2ZsYWcpOw0KPiA+ICsJCSAgIk1hcHBpbmcgYWRkcmVzc1slI2xseF0sIGxlbmd0aFslI3p4
XSwNCj4gbW1hcF9mbGFnWyVkXVxuIiwNCj4gPiArCQkgIGVudHJ5LT5hZGRyZXNzLCBlbnRyeS0+
bGVuZ3RoLCBlbnRyeS0+bW1hcF9mbGFnKTsNCj4gPg0KPiA+ICAJcGZuID0gZW50cnktPmFkZHJl
c3MgPj4gUEFHRV9TSElGVDsNCj4gPiAgCXN3aXRjaCAoZW50cnktPm1tYXBfZmxhZykgew0KPiA+
IEBAIC0xNjMwLDE1ICsxNjIzLDE2IEBAIHN0YXRpYyBpbnQgX19lZmFfbW1hcChzdHJ1Y3QgZWZh
X2RldiAqZGV2LA0KPiBzdHJ1Y3QgZWZhX3Vjb250ZXh0ICp1Y29udGV4dCwNCj4gPiAgCQllcnIg
PSAtRUlOVkFMOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQlpZiAoZXJyKSB7DQo+ID4gLQkJaWJkZXZf
ZGJnKA0KPiA+IC0JCQkmZGV2LT5pYmRldiwNCj4gPiAtCQkJIkNvdWxkbid0IG1tYXAgYWRkcmVz
c1slI2xseF0gbGVuZ3RoWyUjbGx4XQ0KPiBtbWFwX2ZsYWdbJWRdIGVyclslZF1cbiIsDQo+ID4g
LQkJCWVudHJ5LT5hZGRyZXNzLCBsZW5ndGgsIGVudHJ5LT5tbWFwX2ZsYWcsIGVycik7DQo+ID4g
LQkJcmV0dXJuIGVycjsNCj4gPiAtCX0NCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJZ290byBlcnI7
DQo+IA0KPiBUaGFua3MgTWljaGFsLA0KPiBBY2tlZC1ieTogR2FsIFByZXNzbWFuIDxnYWxwcmVz
c0BhbWF6b24uY29tPg0KdGhhbmtzDQo+IA0KPiBJZiB5b3UncmUgcGxhbm5pbmcgb24gZG9pbmcg
YW5vdGhlciBjeWNsZSwgdGhpcyBlcnJvciBwYXRoIG5vdyBwcmludHMgbm90aGluZywgSQ0KPiBt
ZWFudCBtb3ZlIHRoZSBwcmludCBmcm9tIHRoZSBnb3RvIGluc2lkZSB0aGlzIGlmIChiZWZvcmUg
Z290byBlcnIpLg0KWWVzLCBJJ2xsIG5lZWQgdG8gc2VuZCBhIHYxMSBiZWNhdXNlIG9mIGEgc2l3
IGlzc3VlLiBJJ2xsIHNlbmQgeW91IHRoZSBwYXRjaCBiZWZvcmUgSSBzZW5kIGl0IG91dCBmb3Ig
cmV2aWV3IGJlZm9yZSBJIHNlbmQgdjExLg0KVGhhbmtzLA0KTWljaGFsDQoNCj4gDQo+ID4NCj4g
PiAgCXJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJyOg0KPiA+ICsJcmRtYV91c2VyX21tYXBfZW50
cnlfcHV0KCZ1Y29udGV4dC0+aWJ1Y29udGV4dCwNCj4gPiArCQkJCSByZG1hX2VudHJ5KTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICB9DQo=
