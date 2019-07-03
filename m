Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245E35E2A2
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 13:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfGCLMV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 07:12:21 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:53660 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbfGCLMU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 07:12:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63BAnsb022347;
        Wed, 3 Jul 2019 04:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=neBo9uS7RJT8Uv3HK6Gq+owHbS0fi54vFomQ3n6SQ8A=;
 b=rJ/Pv+q7rv/2Bs1Y11KP7OdnJIYaQc/zxDNQEoQZB/6HxO/bNqvuro5xIHiOpbDG7NWL
 u2+T/wCiN8Hd8hp6R/Wpm+d00ZhADmXMmwUzsY7Vdx2WFoz1CSE3gVmgQU2S5gty/+Lk
 +rNCGXiHBxKU89x33arYWZ1nI9rsaX8ljRS8x6Thm3QW42tRf00lbeS8cUz7LkUUBKoS
 Bef3YIveGjUeSbGwEHg4cE5bX197dTOzuets8o2foJqD9Ngo3ZMC0UrY4Oru16PnQj1K
 +g/i7mFK8PUeE5w8RA71q4Qf2V4FjFN9MehThpVMItat465rvg8y+WyummOH1HMNyXAq PA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tgrv18j9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 04:12:00 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 3 Jul
 2019 04:11:59 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 3 Jul 2019 04:11:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neBo9uS7RJT8Uv3HK6Gq+owHbS0fi54vFomQ3n6SQ8A=;
 b=hZEnXvZOwyJWsifW6TF0ceJOAtIyKgWfyKAD4zKUpO7kPyHVPBJnsBtv10xh6KRf+booy0CMi+qUFfWgP3i01u8o3x6YhMx6HBewv3Nmc35mLKmow2U8OiNU6ufTJUueGHoE6Jly0IqvzQHVzt/Km18N8/412aYQhGBuExoKIFI=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3357.namprd18.prod.outlook.com (10.255.238.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 11:11:57 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 11:11:57 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Index: AQHVMXgY2ufVwbsMjkGRdCnidkmBy6a4kGXggAApCwCAAAMc4A==
Date:   Wed, 3 Jul 2019 11:11:57 +0000
Message-ID: <MN2PR18MB3182163108E34FC3076F2298A1FB0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <MN2PR18MB318246C85617FD32F4F54526A1FB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <26eb18f7-2e64-53a3-bbcb-277dea13a112@amazon.com>
In-Reply-To: <26eb18f7-2e64-53a3-bbcb-277dea13a112@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e43a958-dce2-4f97-9805-08d6ffa74359
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3357;
x-ms-traffictypediagnostic: MN2PR18MB3357:
x-microsoft-antispam-prvs: <MN2PR18MB335751477FB71D3250D65FF1A1FB0@MN2PR18MB3357.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(76116006)(3846002)(6116002)(66946007)(52536014)(446003)(73956011)(66476007)(2906002)(54906003)(14454004)(476003)(478600001)(64756008)(66066001)(316002)(486006)(4326008)(66446008)(11346002)(110136005)(33656002)(71200400001)(55016002)(7736002)(66556008)(53936002)(74316002)(14444005)(53546011)(6246003)(76176011)(8936002)(7696005)(6436002)(305945005)(86362001)(9686003)(68736007)(6506007)(71190400001)(8676002)(25786009)(102836004)(229853002)(81156014)(81166006)(186003)(26005)(99286004)(5660300002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3357;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GJ98BEAdI3QoWkn1rmzGAeJhzff1felhz4uTocEisKqL661+91yjNhIW+78mixl8b7OI0Dic5/ubb/2TSgiJAnpuRHQne3SiaYpp2SD50uiQflC+Gd/hTktLdwthOUszpNfsDC+1onfkYOpa7CkX1VxIyEqeTuM9X+a0Hmkjb92vDaT649XDGJz4WfkdEKlORtDvODUl3Q5OcycOVxYJxnLPKd/lwzfBgZHuSlPjbzp8E/VUEWz7TqzMY5wH7jJ+ArkNMHUdSJ9/mMfeOPs2BLv/d4b6gDQ7EKCgC1aJARr5z9GumlO7Ggw1hXMLEEBYzHgzzGUlLMvWdveCQID2nqY9b+RakZ6UvQX/UzZdU3K6pdrYXXw9c6VJ7jzzzuq+/5Wr/ccf25H+I9AJdPsHwXC3Zt+BjLfO4kuX4qdrq74=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e43a958-dce2-4f97-9805-08d6ffa74359
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 11:11:57.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3357
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+IFNlbnQ6
IFdlZG5lc2RheSwgSnVseSAzLCAyMDE5IDE6NTggUE0NCj4gVG86IE1pY2hhbCBLYWxkZXJvbiA8
bWthbGRlcm9uQG1hcnZlbGwuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAemllcGUuY2E+
DQo+IENjOiBkbGVkZm9yZEByZWRoYXQuY29tOyBsZW9uQGtlcm5lbC5vcmc7IHNsZXlib0BhbWF6
b24uY29tOyBBcmllbCBFbGlvcg0KPiA8YWVsaW9yQG1hcnZlbGwuY29tPjsgbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgcmRtYSAxLzNdIFJETUEvY29yZTog
Q3JlYXRlIGEgY29tbW9uIG1tYXAgZnVuY3Rpb24NCj4gDQo+IE9uIDAzLzA3LzIwMTkgMTE6NTMs
IE1pY2hhbCBLYWxkZXJvbiB3cm90ZToNCj4gPj4gRnJvbTogR2FsIFByZXNzbWFuIDxnYWxwcmVz
c0BhbWF6b24uY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMywgMjAxOSAxMToyMCBB
TQ0KPiA+Pg0KPiA+PiBPbiAwMy8wNy8yMDE5IDE6MzEsIEphc29uIEd1bnRob3JwZSB3cm90ZToN
Cj4gPj4+PiBTZWVtcyBleGNlcHQgTWVsbGFub3ggKyBobnMgdGhlIG1tYXAgZmxhZ3MgYXJlbid0
IEFCSS4NCj4gPj4+PiBBbHNvLCBjdXJyZW50IE1lbGxhbm94IGNvZGUgc2VlbXMgbGlrZSBpdCB3
b24ndCBiZW5lZml0IGZyb20gbW1hcA0KPiA+Pj4+IGNvb2tpZSBoZWxwZXIgZnVuY3Rpb25zIGlu
IGFueSBjYXNlIGFzIHRoZSBtbWFwIGZ1bmN0aW9uIGlzIHZlcnkNCj4gPj4+PiBzcGVjaWZpYyBh
bmQgdGhlIGZsYWdzIHVzZWQgaW5kaWNhdGUgdGhlIGFkZHJlc3MgYW5kIG5vdCBqdXN0IGhvdw0K
PiA+Pj4+IHRvIG1hcA0KPiA+PiBpdC4NCj4gPj4+DQo+ID4+PiBJTUhPLCBtbHg1IGhhcyBhIGdv
b2Z5IGltcGxlbWVudGFpdG9uIGhlcmUgYXMgaXQgY29kZXMgYWxsIG9mIHRoZQ0KPiA+Pj4gb2Jq
ZWN0IHR5cGUsIGhhbmRsZSBhbmQgY2FjaGFiaWxpdHkgZmxhZ3MgaW4gb25lIHRoaW5nLg0KPiA+
Pg0KPiA+PiBEbyB3ZSBuZWVkIG9iamVjdCB0eXBlIGZsYWdzIGFzIHdlbGwgaW4gdGhlIGdlbmVy
aWMgbW1hcCBjb2RlPw0KPiA+Pg0KPiA+Pj4NCj4gPj4+PiBGb3IgbW9zdCBkcml2ZXJzIChlZmEs
IHFlZHIsIHNpdywgY3hnYjMvNCwgb2NyZG1hKSBtbWFwIGlzIGNhbGxlZA0KPiA+Pj4+IG9uIGFk
ZHJlc3MgcmVjZWl2ZWQgYnkga2VybmVsIGluIHNvbWUgcmVzcG9uc2UuIE1lYW5pbmcgZHJpdmVy
IGNhbg0KPiA+Pj4+IHdyaXRlIGFueXRoaW5nIGluIHRoZSByZXNwb25zZSB0aGF0IHdpbGwgc2Vy
dmUgYXMgdGhlIGtleSAvIGZsYWcuDQo+ID4+Pj4gT3RoZXIgZHJpdmVycyAoIGk0MGl3ICkgaGF2
ZSBhIHNpbXBsZSBtbWFwIGZ1bmN0aW9uIHRoYXQgZG9lc24ndA0KPiA+Pj4+IHJlcXVpcmUgYSBt
bWFwIGRhdGFiYXNlIGF0IGFsbC4NCj4gPj4+DQo+ID4+PiBBcmUgeW91IHN1cmU/IEkgdGhvdWdo
dCB0aGUgcmVhc29uIHRvIGhhdmUgdG8gZmxhZ3MgYXQgYWxsIHdhcyBzbw0KPiA+Pj4gdGhhdCB1
c2Vyc3BhY2UgY291bGQgc3BlY2lmeSBkaWZmZXJlbnQgY2FjaGFiaWxpdHkuLg0KPiA+Pj4NCj4g
Pj4+IE90aGVyd2lzZSB0aGUgb2Zmc2V0IHNob3VsZCBqdXN0IGJlIGFuIG9wYXF1ZSBjb29raWUg
YW5kIGludGVybmFsIHhhDQo+ID4+PiBzaG91bGQgc3BlY2lmeSB0aGUgY2FjaGFiaWxpdHkgbW9k
ZS4uDQo+ID4+DQo+ID4+IFRoYXQgd2FzIG15IGludGVudGlvbiBhcyB3ZWxsLiBUaGUgZHJpdmVy
IHJldHVybnMgYSAiaGludCIgZmxhZyB0bw0KPiA+PiB0aGUgdXNlciwgYnV0IHRoZSB1c2Vyc3Bh
Y2UgbGlicmFyeSBjYW4gb3ZlcnJpZGUgaXQgd2l0aCBpdHMgb3duIGNhY2hhYmlsaXR5DQo+IGZs
YWdzLg0KPiA+PiBIb3dldmVyLCBJIG5vdyBub3RpY2UgRUZBIGxvc3QgdGhhdCBmdW5jdGlvbmFs
aXR5IHdoZW4gaXQgd2FzIG1lcmdlZA0KPiA+PiBhcyB0aGUgbW1hcCBmdW5jdGlvbiBsb29rcyBh
dCAnZW50cnktPm1tYXBfZmxhZycgKGhpbnQpIGluc3RlYWQgb2YNCj4gPj4gdGhlIGdpdmVuIG9m
ZnNldA0KPiA+PiBmbGFnOg0KPiA+Pg0KPiA+PiBzdGF0aWMgaW50IF9fZWZhX21tYXAoc3RydWN0
IGVmYV9kZXYgKmRldiwgc3RydWN0IGVmYV91Y29udGV4dA0KPiAqdWNvbnRleHQsDQo+ID4+IAkJ
ICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHU2NCBrZXksIHU2NCBsZW5ndGgpIHsN
Cj4gPj4gCXN0cnVjdCBlZmFfbW1hcF9lbnRyeSAqZW50cnk7DQo+ID4+IAl1bnNpZ25lZCBsb25n
IHZhOw0KPiA+PiAJdTY0IHBmbjsNCj4gPj4gCWludCBlcnI7DQo+ID4+DQo+ID4+IAllbnRyeSA9
IG1tYXBfZW50cnlfZ2V0KGRldiwgdWNvbnRleHQsIGtleSwgbGVuZ3RoKTsNCj4gPj4gCWlmICgh
ZW50cnkpIHsNCj4gPj4gCQlpYmRldl9kYmcoJmRldi0+aWJkZXYsICJrZXlbJSNsbHhdIGRvZXMg
bm90IGhhdmUgdmFsaWQNCj4gZW50cnlcbiIsDQo+ID4+IAkJCSAga2V5KTsNCj4gPj4gCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPj4gCX0NCj4gPj4NCj4gPj4gCWliZGV2X2RiZygmZGV2LT5pYmRldiwN
Cj4gPj4gCQkgICJNYXBwaW5nIGFkZHJlc3NbJSNsbHhdLCBsZW5ndGhbJSNsbHhdLA0KPiBtbWFw
X2ZsYWdbJWRdXG4iLA0KPiA+PiAJCSAgZW50cnktPmFkZHJlc3MsIGxlbmd0aCwgZW50cnktPm1t
YXBfZmxhZyk7DQo+ID4+DQo+ID4+IAlwZm4gPSBlbnRyeS0+YWRkcmVzcyA+PiBQQUdFX1NISUZU
Ow0KPiA+PiAJc3dpdGNoIChlbnRyeS0+bW1hcF9mbGFnKSB7DQo+ID4+ICAgICAgICAgXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXg0KPiA+Pg0KPiA+PiAJY2FzZSBFRkFfTU1BUF9JT19OQzoNCj4g
Pj4gCQllcnIgPSByZG1hX3VzZXJfbW1hcF9pbygmdWNvbnRleHQtPmlidWNvbnRleHQsIHZtYSwN
Cj4gcGZuLCBsZW5ndGgsDQo+ID4+IAkJCQkJcGdwcm90X25vbmNhY2hlZCh2bWEtDQo+ID4+PiB2
bV9wYWdlX3Byb3QpKTsNCj4gPj4gCQlicmVhazsNCj4gPj4gCWNhc2UgRUZBX01NQVBfSU9fV0M6
DQo+ID4+IAkJZXJyID0gcmRtYV91c2VyX21tYXBfaW8oJnVjb250ZXh0LT5pYnVjb250ZXh0LCB2
bWEsDQo+IHBmbiwgbGVuZ3RoLA0KPiA+PiAJCQkJCXBncHJvdF93cml0ZWNvbWJpbmUodm1hLQ0K
PiA+Pj4gdm1fcGFnZV9wcm90KSk7DQo+ID4+IAkJYnJlYWs7DQo+ID4+IAljYXNlIEVGQV9NTUFQ
X0RNQV9QQUdFOg0KPiA+PiAJCWZvciAodmEgPSB2bWEtPnZtX3N0YXJ0OyB2YSA8IHZtYS0+dm1f
ZW5kOw0KPiA+PiAJCSAgICAgdmEgKz0gUEFHRV9TSVpFLCBwZm4rKykgew0KPiA+PiAJCQllcnIg
PSB2bV9pbnNlcnRfcGFnZSh2bWEsIHZhLCBwZm5fdG9fcGFnZShwZm4pKTsNCj4gPj4gCQkJaWYg
KGVycikNCj4gPj4gCQkJCWJyZWFrOw0KPiA+PiAJCX0NCj4gPj4gCQlicmVhazsNCj4gPj4gCWRl
ZmF1bHQ6DQo+ID4+IAkJZXJyID0gLUVJTlZBTDsNCj4gPj4gCX0NCj4gPj4NCj4gPj4gCWlmIChl
cnIpIHsNCj4gPj4gCQlpYmRldl9kYmcoDQo+ID4+IAkJCSZkZXYtPmliZGV2LA0KPiA+PiAJCQki
Q291bGRuJ3QgbW1hcCBhZGRyZXNzWyUjbGx4XSBsZW5ndGhbJSNsbHhdDQo+IG1tYXBfZmxhZ1sl
ZF0NCj4gPj4gZXJyWyVkXVxuIiwNCj4gPj4gCQkJZW50cnktPmFkZHJlc3MsIGxlbmd0aCwgZW50
cnktPm1tYXBfZmxhZywgZXJyKTsNCj4gPj4gCQlyZXR1cm4gZXJyOw0KPiA+PiAJfQ0KPiA+Pg0K
PiA+PiAJcmV0dXJuIDA7DQo+ID4+IH0NCj4gPj4NCj4gPj4gQW5vdGhlciBpc3N1ZSBpcyB0aGF0
IHRoZXNlIGZsYWdzIGFyZW4ndCBleHBvc2VkIGluIGFuIEFCSSBmaWxlLCBzbyBhDQo+ID4+IHVz
ZXJzcGFjZSBsaWJyYXJ5IGNhbid0IHJlYWxseSBtYWtlIHVzZSBvZiBpdCBpbiBjdXJyZW50IHN0
YXRlLg0KPiA+DQo+ID4gQ2FuIHlvdSBnaXZlIGFuIGV4YW1wbGUgb2YgYSB1c2UtY2FzZSB3aGVy
ZSB0aGUgdXNlciB3b3VsZCB3YW50IHRvDQo+IG92ZXJyaWRlIHRoZSBrZXJuZWwgaGludCA/DQo+
ID4gRG8geW91IHBsYW4gb24gY2hhbmdpbmcgdGhpcyBhbmQgZXhwb3NpbmcgdGhlIGZsYWdzIHRv
IEFCST8NCj4gDQo+IEkgZG9uJ3QgaGF2ZSBhbiBleGFtcGxlIG9mIHN1Y2ggdXNlIGNhc2UgY3Vy
cmVudGx5LCBJIHRob3VnaHQgaXQncyBnb29kIHRvDQo+IGhhdmUgc3VjaCBjYXBhYmlsaXR5Lg0K
PiANCj4gUmVnYXJkaW5nIHRoZSBBQkksIEkgZ3Vlc3MgaXQgZGVwZW5kcyBvbiBob3cgdGhpcyBS
RkMgaXMgZ29pbmcgdG8gZW5kIHVwLg0KDQpPSywgdGhhbmtzLiBJIHRoaW5rIGFzIGEgc3RhcnQs
IEknbGwgc2VuZCBhIHBhdGNoIHNlcmllcyB3aXRoIGp1c3QgdGhlIGhlbHBlciBmdW5jdGlvbnMN
CmZvciBoYW5kbGluZyB0aGUgbW1hcF94YS4NCkknbGwgc2VuZCB0aGUgcGF0Y2ggc2VyaWVzIGFz
IGEgYmFzZSBmb3IgdGhlIHFlZHIgZG9vcmJlbGwgcmVjb3ZlcnkgcGF0Y2guIA0KQW5kIEknbGwg
YmUgaGFwcHkgdG8gY29udGludWUgZGlzY3Vzc2lvbiBvbiB3aGV0aGVyIHdlIHdhbnQgdGhlIGVu
dGlyZSBtbWFwDQpUbyBiZSBnZW5lcmljIG9yIG5vdC4gDQpUaGFua3MsDQpNaWNoYWwNCg0KDQoN
Cg==
