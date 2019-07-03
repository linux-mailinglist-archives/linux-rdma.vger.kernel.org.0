Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0B5E042
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGCIxz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 04:53:55 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1654 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbfGCIxz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 04:53:55 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x638mCRX026065;
        Wed, 3 Jul 2019 01:53:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=+IQix9Wew4PMbXnZWscNS/CpubBgJC3O/83z8othJcI=;
 b=Vnrnf0ptlmqdZlhQh9cBNe8lcfuFhTQFNjuNAhuSauWDC6BdhbQuYG279///Tojv4mrR
 mX1/roKlIcyD0H2t1DuW1rBc7fQ2Ul06TECci4/F8N0cSqY8/iGcHMezx7z1z9Dn+ygy
 742Z8qBY8hj/Zogl5ER8HWI4nilCZXNmv0MBGwnHjMCEpuB+lDSWBkgWL2YY2eEyguWV
 MjwfG/vJXwjbq2hfSIShqSb3ZTrorJMO581aW5E9CFh2AzbpAXwVkzmomLEWr9fGclXf
 GoN0Axf/fPfS63+CFKv+6IFMPNebSmmaNwEv3N5O9h9wBwPIEFbpwT2OsdZDnt7W3raq 0w== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tg5734kur-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 01:53:14 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 3 Jul
 2019 01:53:10 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 3 Jul 2019 01:53:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IQix9Wew4PMbXnZWscNS/CpubBgJC3O/83z8othJcI=;
 b=ss9ed802HVLXOtRi5teHwE+HrkmWDU4cRPG4ZUhVvisbqGiRufvjZIlJTmTTbppovOGYrf5B3CmjhYxM8GE434VPzsYwiCxTAj3orfzt5tDdLwLjfy4hayHhIT6dsMfXWVAdII+fdso9V386H16HfngZwRM873NTNTPP2i/qzX4=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3376.namprd18.prod.outlook.com (10.255.238.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 08:53:05 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 08:53:05 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Index: AQHVMXgY2ufVwbsMjkGRdCnidkmBy6a4kGXg
Date:   Wed, 3 Jul 2019 08:53:05 +0000
Message-ID: <MN2PR18MB318246C85617FD32F4F54526A1FB0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
In-Reply-To: <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc937a8-dcf5-47d1-836f-08d6ff93dd0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3376;
x-ms-traffictypediagnostic: MN2PR18MB3376:
x-microsoft-antispam-prvs: <MN2PR18MB33762AD8128E2E0B7395217EA1FB0@MN2PR18MB3376.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(14454004)(110136005)(66946007)(54906003)(476003)(316002)(68736007)(486006)(71190400001)(25786009)(66446008)(64756008)(66556008)(66476007)(4326008)(66066001)(71200400001)(73956011)(99286004)(5660300002)(52536014)(478600001)(76116006)(6116002)(102836004)(8936002)(76176011)(7736002)(9686003)(2906002)(6506007)(14444005)(33656002)(81156014)(81166006)(256004)(53936002)(7696005)(74316002)(3846002)(8676002)(53546011)(26005)(305945005)(6246003)(186003)(6436002)(229853002)(55016002)(446003)(86362001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3376;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: capnEBnRTUrxFNXioK+x8bL0X2oiqjRGFknZVutKwLKVYT12uid5lk03wt/24JdnjbYmZITZbFWdy4HxyLRYPZI2orNloDZwiEwPTFiVKmiS9WyDRvoAkw3bn6FOqzTyGH+7BN7g3NAAQOpH8Vk8QQxK6w0jBM3Trj7p3v9LmDSD2lWnUaxR1kRQwFW3vVKMQi1EpIihEpCfYm8iUIQt44YGUf9aVyrqQGFPjs9fjpiEugZrj/Jwf8phTseMnBmb+jutN9E/qUZwc2BmIUSJTQDr5mpNVdVpnUqDhcUgGpgTfLkkY0phk27BrTe7kbTWAHygLD3anB0AV+/P5gejWaJwygpPCMPHPHz4myG3peq4q76GPmZv3Uob9dKlaYKWgUS/ZtA9TRWWy02mJUazHkiiTLoBjsOFvJUQUzbfJnM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc937a8-dcf5-47d1-836f-08d6ff93dd0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 08:53:05.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3376
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSnVseSAzLCAyMDE5IDExOjIwIEFNDQo+IA0KPiBPbiAwMy8wNy8yMDE5IDE6MzEsIEph
c29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4gU2VlbXMgZXhjZXB0IE1lbGxhbm94ICsgaG5zIHRo
ZSBtbWFwIGZsYWdzIGFyZW4ndCBBQkkuDQo+ID4+IEFsc28sIGN1cnJlbnQgTWVsbGFub3ggY29k
ZSBzZWVtcyBsaWtlIGl0IHdvbid0IGJlbmVmaXQgZnJvbSBtbWFwDQo+ID4+IGNvb2tpZSBoZWxw
ZXIgZnVuY3Rpb25zIGluIGFueSBjYXNlIGFzIHRoZSBtbWFwIGZ1bmN0aW9uIGlzIHZlcnkNCj4g
Pj4gc3BlY2lmaWMgYW5kIHRoZSBmbGFncyB1c2VkIGluZGljYXRlIHRoZSBhZGRyZXNzIGFuZCBu
b3QganVzdCBob3cgdG8gbWFwDQo+IGl0Lg0KPiA+DQo+ID4gSU1ITywgbWx4NSBoYXMgYSBnb29m
eSBpbXBsZW1lbnRhaXRvbiBoZXJlIGFzIGl0IGNvZGVzIGFsbCBvZiB0aGUNCj4gPiBvYmplY3Qg
dHlwZSwgaGFuZGxlIGFuZCBjYWNoYWJpbGl0eSBmbGFncyBpbiBvbmUgdGhpbmcuDQo+IA0KPiBE
byB3ZSBuZWVkIG9iamVjdCB0eXBlIGZsYWdzIGFzIHdlbGwgaW4gdGhlIGdlbmVyaWMgbW1hcCBj
b2RlPw0KPiANCj4gPg0KPiA+PiBGb3IgbW9zdCBkcml2ZXJzIChlZmEsIHFlZHIsIHNpdywgY3hn
YjMvNCwgb2NyZG1hKSBtbWFwIGlzIGNhbGxlZCBvbg0KPiA+PiBhZGRyZXNzIHJlY2VpdmVkIGJ5
IGtlcm5lbCBpbiBzb21lIHJlc3BvbnNlLiBNZWFuaW5nIGRyaXZlciBjYW4gd3JpdGUNCj4gPj4g
YW55dGhpbmcgaW4gdGhlIHJlc3BvbnNlIHRoYXQgd2lsbCBzZXJ2ZSBhcyB0aGUga2V5IC8gZmxh
Zy4NCj4gPj4gT3RoZXIgZHJpdmVycyAoIGk0MGl3ICkgaGF2ZSBhIHNpbXBsZSBtbWFwIGZ1bmN0
aW9uIHRoYXQgZG9lc24ndA0KPiA+PiByZXF1aXJlIGEgbW1hcCBkYXRhYmFzZSBhdCBhbGwuDQo+
ID4NCj4gPiBBcmUgeW91IHN1cmU/IEkgdGhvdWdodCB0aGUgcmVhc29uIHRvIGhhdmUgdG8gZmxh
Z3MgYXQgYWxsIHdhcyBzbyB0aGF0DQo+ID4gdXNlcnNwYWNlIGNvdWxkIHNwZWNpZnkgZGlmZmVy
ZW50IGNhY2hhYmlsaXR5Li4NCj4gPg0KPiA+IE90aGVyd2lzZSB0aGUgb2Zmc2V0IHNob3VsZCBq
dXN0IGJlIGFuIG9wYXF1ZSBjb29raWUgYW5kIGludGVybmFsIHhhDQo+ID4gc2hvdWxkIHNwZWNp
ZnkgdGhlIGNhY2hhYmlsaXR5IG1vZGUuLg0KPiANCj4gVGhhdCB3YXMgbXkgaW50ZW50aW9uIGFz
IHdlbGwuIFRoZSBkcml2ZXIgcmV0dXJucyBhICJoaW50IiBmbGFnIHRvIHRoZSB1c2VyLCBidXQN
Cj4gdGhlIHVzZXJzcGFjZSBsaWJyYXJ5IGNhbiBvdmVycmlkZSBpdCB3aXRoIGl0cyBvd24gY2Fj
aGFiaWxpdHkgZmxhZ3MuDQo+IEhvd2V2ZXIsIEkgbm93IG5vdGljZSBFRkEgbG9zdCB0aGF0IGZ1
bmN0aW9uYWxpdHkgd2hlbiBpdCB3YXMgbWVyZ2VkIGFzIHRoZQ0KPiBtbWFwIGZ1bmN0aW9uIGxv
b2tzIGF0ICdlbnRyeS0+bW1hcF9mbGFnJyAoaGludCkgaW5zdGVhZCBvZiB0aGUgZ2l2ZW4gb2Zm
c2V0DQo+IGZsYWc6DQo+IA0KPiBzdGF0aWMgaW50IF9fZWZhX21tYXAoc3RydWN0IGVmYV9kZXYg
KmRldiwgc3RydWN0IGVmYV91Y29udGV4dCAqdWNvbnRleHQsDQo+IAkJICAgICAgc3RydWN0IHZt
X2FyZWFfc3RydWN0ICp2bWEsIHU2NCBrZXksIHU2NCBsZW5ndGgpIHsNCj4gCXN0cnVjdCBlZmFf
bW1hcF9lbnRyeSAqZW50cnk7DQo+IAl1bnNpZ25lZCBsb25nIHZhOw0KPiAJdTY0IHBmbjsNCj4g
CWludCBlcnI7DQo+IA0KPiAJZW50cnkgPSBtbWFwX2VudHJ5X2dldChkZXYsIHVjb250ZXh0LCBr
ZXksIGxlbmd0aCk7DQo+IAlpZiAoIWVudHJ5KSB7DQo+IAkJaWJkZXZfZGJnKCZkZXYtPmliZGV2
LCAia2V5WyUjbGx4XSBkb2VzIG5vdCBoYXZlIHZhbGlkDQo+IGVudHJ5XG4iLA0KPiAJCQkgIGtl
eSk7DQo+IAkJcmV0dXJuIC1FSU5WQUw7DQo+IAl9DQo+IA0KPiAJaWJkZXZfZGJnKCZkZXYtPmli
ZGV2LA0KPiAJCSAgIk1hcHBpbmcgYWRkcmVzc1slI2xseF0sIGxlbmd0aFslI2xseF0sDQo+IG1t
YXBfZmxhZ1slZF1cbiIsDQo+IAkJICBlbnRyeS0+YWRkcmVzcywgbGVuZ3RoLCBlbnRyeS0+bW1h
cF9mbGFnKTsNCj4gDQo+IAlwZm4gPSBlbnRyeS0+YWRkcmVzcyA+PiBQQUdFX1NISUZUOw0KPiAJ
c3dpdGNoIChlbnRyeS0+bW1hcF9mbGFnKSB7DQo+ICAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXg0KPiANCj4gCWNhc2UgRUZBX01NQVBfSU9fTkM6DQo+IAkJZXJyID0gcmRtYV91c2Vy
X21tYXBfaW8oJnVjb250ZXh0LT5pYnVjb250ZXh0LCB2bWEsDQo+IHBmbiwgbGVuZ3RoLA0KPiAJ
CQkJCXBncHJvdF9ub25jYWNoZWQodm1hLQ0KPiA+dm1fcGFnZV9wcm90KSk7DQo+IAkJYnJlYWs7
DQo+IAljYXNlIEVGQV9NTUFQX0lPX1dDOg0KPiAJCWVyciA9IHJkbWFfdXNlcl9tbWFwX2lvKCZ1
Y29udGV4dC0+aWJ1Y29udGV4dCwgdm1hLA0KPiBwZm4sIGxlbmd0aCwNCj4gCQkJCQlwZ3Byb3Rf
d3JpdGVjb21iaW5lKHZtYS0NCj4gPnZtX3BhZ2VfcHJvdCkpOw0KPiAJCWJyZWFrOw0KPiAJY2Fz
ZSBFRkFfTU1BUF9ETUFfUEFHRToNCj4gCQlmb3IgKHZhID0gdm1hLT52bV9zdGFydDsgdmEgPCB2
bWEtPnZtX2VuZDsNCj4gCQkgICAgIHZhICs9IFBBR0VfU0laRSwgcGZuKyspIHsNCj4gCQkJZXJy
ID0gdm1faW5zZXJ0X3BhZ2Uodm1hLCB2YSwgcGZuX3RvX3BhZ2UocGZuKSk7DQo+IAkJCWlmIChl
cnIpDQo+IAkJCQlicmVhazsNCj4gCQl9DQo+IAkJYnJlYWs7DQo+IAlkZWZhdWx0Og0KPiAJCWVy
ciA9IC1FSU5WQUw7DQo+IAl9DQo+IA0KPiAJaWYgKGVycikgew0KPiAJCWliZGV2X2RiZygNCj4g
CQkJJmRldi0+aWJkZXYsDQo+IAkJCSJDb3VsZG4ndCBtbWFwIGFkZHJlc3NbJSNsbHhdIGxlbmd0
aFslI2xseF0NCj4gbW1hcF9mbGFnWyVkXSBlcnJbJWRdXG4iLA0KPiAJCQllbnRyeS0+YWRkcmVz
cywgbGVuZ3RoLCBlbnRyeS0+bW1hcF9mbGFnLCBlcnIpOw0KPiAJCXJldHVybiBlcnI7DQo+IAl9
DQo+IA0KPiAJcmV0dXJuIDA7DQo+IH0NCj4gDQo+IEFub3RoZXIgaXNzdWUgaXMgdGhhdCB0aGVz
ZSBmbGFncyBhcmVuJ3QgZXhwb3NlZCBpbiBhbiBBQkkgZmlsZSwgc28gYSB1c2Vyc3BhY2UNCj4g
bGlicmFyeSBjYW4ndCByZWFsbHkgbWFrZSB1c2Ugb2YgaXQgaW4gY3VycmVudCBzdGF0ZS4NCg0K
Q2FuIHlvdSBnaXZlIGFuIGV4YW1wbGUgb2YgYSB1c2UtY2FzZSB3aGVyZSB0aGUgdXNlciB3b3Vs
ZCB3YW50IHRvIG92ZXJyaWRlIHRoZSBrZXJuZWwgaGludCA/IA0KRG8geW91IHBsYW4gb24gY2hh
bmdpbmcgdGhpcyBhbmQgZXhwb3NpbmcgdGhlIGZsYWdzIHRvIEFCST8gDQogDQoNCg==
