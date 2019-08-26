Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B79CBD0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfHZIl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 04:41:56 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49978 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730444AbfHZIlx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 04:41:53 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7Q8f324031361;
        Mon, 26 Aug 2019 01:41:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=CMD8ua/y6Qc9ehBwCq6NARMc9hKBiA9wyub4w67dseA=;
 b=Sd+oiCBDqv6nEeY01kRwRzy1N26i/QJEh1Haw6oYbMWDR8KPQmTnVUN4+MWxh4eH6zGk
 jV0+lQT4O/uXnkUd1sjEwi8vUO9CtabwMIKIzw3RpYKm5Qycisb+wF5IsGoO5vsXQP7f
 +Z6mBEhYy0gBwDHA2kUWscK4Rn0oNJ+c+1kJ6zRIiwUS0NWkyS9BwHmFjSQ3L6aG8QYG
 3n3tX+2aGLIKoNu1UzKCMveS+BaqlmXhFXkRoyEqgaYNa1BfS0mk5e9dGWzH7qYZM7tg
 6ivqqoT8jj1ygXlHTuDPIfotNy8OqWWaGXFwkpp6yC2nGg76uVOq3xIIMsBc0dRHxBxi Jw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkdx1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 01:41:49 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 26 Aug
 2019 01:41:47 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 01:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0AXVfB0Lc7zlHJzP4P8MfwNvKgU3POuVlDCArHd8T1FTiDxGPgL5lobv0Gd6TAtwnat1No1ZXyVO9zmRYH/pjqUDpi0UOHL12EEqRrUYZLtmqz+ZjXdIiX+7O6585oOggQS6YTMJMi+Am7HKA/VFl6G5Q22lxPEhhLxXc3H0j42ARK1S63bnpf5o4wEQ718qBjr1eVaHxX4ny+KWLElUJ/Y24r0fVJhr7M5q4c0ch37qUNZXB2RYChM8R0H4R2E320LB7S47M1NzVWsNbFYxTnFlKYjQnzT5l0O4u+i6LeGQH/vZwB3vh6kVOAkZ6lER6m1st1S0G3FITbygNuIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMD8ua/y6Qc9ehBwCq6NARMc9hKBiA9wyub4w67dseA=;
 b=W4DrXiWNyGXHqCyTESsKVXiz4I2GpStsKClWYCEJjT7/ys6GvYV4/gT4huwdU8sGHxDZJp5xeuZbT7jbfUj0ssQSr5NVHzKmED4KsevBAHvHWt0/cGe6RPxaDK3NAgTjCAIoUm2VLnCP8fqFjuy+kuZvMT6Y2llunM3P9X88LMtZZxc1BxHnhFcdXDg5tVllEw5tPs3jOtW5iNXPZQFZ2RdXPrwE1AvvzWgJrCQf4T0/O4s+miNzgr8U25LPkF833QUj3SU472PjHaeem7OAvQZAwiQsoWkGNNPqSVKAsFi6GaPIqpv54urbi4GkoyHaHQ3f/6m4MXUg+dADUQS6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMD8ua/y6Qc9ehBwCq6NARMc9hKBiA9wyub4w67dseA=;
 b=UtdRYWIqfBcFe9M5rlEso24iLU3LmFWfFbWJohT4J7MT7zMhhuaX9YiY5aiR7pB8r60TFbaJXfRpB1FJNzg8WfwL+2dlSYlZELEPMfVElstt1OKCwY8pFt1qIiisoPfRGuo5YCM9NoJcT+A2DLsAE3WbyaDa8CwDbORaMKLs6cY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3294.namprd18.prod.outlook.com (10.255.237.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 08:41:42 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2199.020; Mon, 26 Aug 2019
 08:41:42 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Thread-Topic: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Thread-Index: AQHVV1GzaBcLwMoagEypYNTXoU3KUacG2nQAgAS1rDCAACQPAIABcOKw
Date:   Mon, 26 Aug 2019 08:41:42 +0000
Message-ID: <MN2PR18MB31827E71327561187B74F615A1A10@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <3b297196-1ef6-c046-d0b2-c68648a50913@amazon.com>
 <MN2PR18MB31820859BDBA0B87D0830935A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
 <10dc3958-7968-a3dc-3ab5-a64a270bdfdb@amazon.com>
In-Reply-To: <10dc3958-7968-a3dc-3ab5-a64a270bdfdb@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c69f9fa2-40c6-4d82-3802-08d72a013889
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3294;
x-ms-traffictypediagnostic: MN2PR18MB3294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB329483D15E7A294CFF155C61A1A10@MN2PR18MB3294.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(199004)(189003)(6506007)(6916009)(6246003)(11346002)(76176011)(6436002)(25786009)(52536014)(4326008)(5660300002)(446003)(86362001)(486006)(33656002)(99286004)(71190400001)(55016002)(476003)(2906002)(53936002)(9686003)(7696005)(256004)(14444005)(66066001)(8936002)(8676002)(81156014)(81166006)(54906003)(71200400001)(76116006)(26005)(66446008)(64756008)(66556008)(66476007)(74316002)(7736002)(6116002)(305945005)(3846002)(14454004)(53546011)(102836004)(478600001)(186003)(229853002)(66946007)(316002)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3294;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IqpYBkihH+Mby8vj7kVR+0KM84CoVbvXbq8bAQZ+Wx2P6HxGd8hFHSmkDQ/icGVRfodygJSnkTvUDy+1QKD29CzpFINzdvyfWKPkE6Fz5HxF+Ns6fS4gItx6U5/O9S7sSsN2Wi4jgOL3uv3xmz3MzXqFdW5khIn654kcrBhaUKluVsVrR7VGAM7ICUwj+Yb4K8r4E1Dk6S24q4r4wwqi5SrvB1YuCB94osPLcFxIVj9ofMnwpf44KAMH4KQCfFxf1r7ELuUXMqCtqQK0ajNHRijmpUKAMQype63QHfUj8LJC287cs1oNifDVAFpjzpVLypSAO82nWO9DcjPs+Lk/m2oQnIhvuuljlbEBSG4CCIXRcybeYir8pinwx+0KRvl7Gw7arxsYegxtElDgakBTvsm8rUzbNbWcK40WqEQf73k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c69f9fa2-40c6-4d82-3802-08d72a013889
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 08:41:42.6686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSzaL7C46+ZbdmZOKOIGOSffSntjMDXioeQmGwTQ9ZJbS6jDR5laZh05yluXx21jBJ8/FbxWkrcXeOHB16GA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3294
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_05:2019-08-23,2019-08-26 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFN1bmRh
eSwgQXVndXN0IDI1LCAyMDE5IDE6NDAgUE0NCj4gDQo+IE9uIDI1LzA4LzIwMTkgMTE6MzYsIE1p
Y2hhbCBLYWxkZXJvbiB3cm90ZToNCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvY29yZS9yZG1hX2NvcmUuYw0KPiA+Pj4gYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9yZG1h
X2NvcmUuYw0KPiA+Pj4gaW5kZXggY2NmNGQwNjljMjVjLi43MTY2NzQxODM0YzggMTAwNjQ0DQo+
ID4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9yZG1hX2NvcmUuYw0KPiA+Pj4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvcmRtYV9jb3JlLmMNCj4gPj4+IEBAIC04MTcsNiAr
ODE3LDcgQEAgc3RhdGljIHZvaWQgdWZpbGVfZGVzdHJveV91Y29udGV4dChzdHJ1Y3QNCj4gPj4g
aWJfdXZlcmJzX2ZpbGUgKnVmaWxlLA0KPiA+Pj4gIAlyZG1hX3Jlc3RyYWNrX2RlbCgmdWNvbnRl
eHQtPnJlcyk7DQo+ID4+Pg0KPiA+Pj4gIAlpYl9kZXYtPm9wcy5kZWFsbG9jX3Vjb250ZXh0KHVj
b250ZXh0KTsNCj4gPj4+ICsJcmRtYV91c2VyX21tYXBfZW50cmllc19yZW1vdmVfZnJlZSh1Y29u
dGV4dCk7DQo+ID4+DQo+ID4+IFdoeSBkaWQgeW91IHN3aXRjaCB0aGUgb3JkZXIgYWdhaW4/DQo+
ID4gVG8gZW5hYmxlIGRyaXZlcnMgdG8gcmVtb3ZlIHRoZSBlbnRyaWVzIGZyb20gdGhlIG1tYXBf
eGEgb3RoZXJ3aXNlDQo+ID4gZW50aXJlc19yZW1vdmVfZnJlZSBXaWxsIHJ1biBpbnRvIGEgbW1h
cF94YSB0aGF0IGlzIG5vdCBlbXB0eS4gSSBzaG91bGQNCj4gaGF2ZSBtZW50aW9uZWQgdGhpcyBp
biB0aGUgY292ZXIgbGV0dGVyLg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kLg0KPiBEbyB5b3Ug
ZXhwZWN0IGRyaXZlcnMgdG8gZXhwbGljaXRseSBkcmFpbiB0aGUgbW1hcCB4YXJyYXkgZHVyaW5n
DQo+IGRlYWxsb2NfdWNvbnRleHQ/IEkgZGlkbid0IHNlZSB0aGF0IGluIHRoZSBFRkEgcGF0Y2gu
DQo+IA0KPiBJIHN0aWxsIHRoaW5rIHRoZSB4YXJyYXkgc2hvdWxkIGJlIGNsZWFyZWQgcHJpb3Ig
dG8gY2FsbGluZyB0aGUgZHJpdmVyJ3MNCj4gZGVhbGxvY191Y29udGV4dC4NCg0KRHJpdmVycyBk
b24ndCBuZWVkIHRvIGV4cGxpY2l0bHkgZHJhaW4gdGhlIHhhcnJheSwgYnV0IGluIHFlZHIgdGhl
IGRyaXZlciBpbnNlcnRzDQpBbiBlbnRyeSBkdXJpbmcgYWxsb2NfdWNvbnRleHQsIGFuZCB0aGVy
ZWZvcmUgc2hvdWxkIHJlbW92ZSB0aGUgZW50cnkgb24gZGVhbGxvYw0KVWNvbnRleHQuIFdlIHdh
bnQgdG8gcmVhY2MgdGhlIHJlbW92ZV9mcmVlIGZ1bmN0aW9uIHdpdGggbm8gZW50cmllcy4gV2hl
biBnb2luZw0KT3ZlciB0aGlzIGNvZGUgYWdhaW4gSSB0aGluayBJIGNhbiBjb21wbGV0ZWx5IHJl
bW92ZSB0aGUgZnVuY3Rpb24gYW5kIGp1c3QgYWRkIGEgDQpXQVJOX09OIG9uIHRoZSBkZWFsbG9j
X3Vjb250ZXh0IGZ1bmN0aW9uLiBIYXZpbmcgYW4gZW50cnkgYXQgdGhpcyBwb2ludCBtZWFucyB0
aGVyZQ0KSXMgYSBsZWFrLiANCg0K
