Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC39A502A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfIBHrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 03:47:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44242 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729382AbfIBHrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 03:47:22 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x827jSre022743;
        Mon, 2 Sep 2019 00:47:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=m0oeVrd7hvlh6G2GPzpskJ8+RiOcaguxeK7lUu9NUsQ=;
 b=K0+soo9T0cd0PenDDfvxtAjY6Abg5SE9GFVxNmALcS7ZvaloYFZqVQxbRvzc1HbY/jPf
 VsaZHg4xc/ORB9xFvhQ5YowB03TccHfi/wXCyuUlJBCIKs9eR+eX4bwpjGl4uYVXzJ0F
 rKixzGc9uSfcwC2c/lAEa7bJb2vY/klHn0sdnimn5/EHLYX9Vap+Idq4vXz+xJqQtYap
 unc5wREzRhb/Ump5B6viA6fjS/Pn0a89gwyjFCj5i1I2w2oay9JC1CrmedmqaLdXdNW3
 pawMS0ufXx6tsDpZbYRFcK2gU2Vr/CjEQ9iKD1c1x+wLUdo8jiDbGhKQLnLECGYbhrXa Tg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p5ujr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 00:47:19 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 00:47:17 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.56) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 00:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdXjQ90L+Dk8ICC9F/NpR0LGTUmV0mGUM1/6Az2JaIeB+417pLMKj5o3vbKgyMmWyQrEJgPaK4GuIftSAcN+al+MPOnON+oh8fDcDdZDaGXBoQOt9ETTcMILdqla3/cl8WYJEsXtreue8moNYue4+cBrJnln8vSrUwolD/bsFMa3Sd1dUEWWzY6pNTi5uVC0Vpk3wszISpUzdFDSFQRDkRony3Pl5oBygPoMbGc78QCgsWMadjgogAU7/lOq4NIO8gKQcxOu3Rd+GtkB9e384GMyfvRVYxFtrqXN0243PJ7bZ9xOIu+//UJPSzlz5MCfrJD32Mhmf2UPT1SZcgfAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0oeVrd7hvlh6G2GPzpskJ8+RiOcaguxeK7lUu9NUsQ=;
 b=IW1hNs6Yu6yxb8PxZWpU2DxnL3H4spvSKjF+TeQHAuwbotW2qX3pCz/zVbFAre4wi6nhZuZHBhGleo3lOQsPyBcPYOkPsvJV58xbJ93o9G+q0zdAbRDTp4kb1Pdxu512Ric9GzPMCWQDjVfGodJce30I3bgMb77Bu3/qU2EplLlNp1pTwTIpEo34VYO/ClUvIXATahWfDchiHlic7LxnfzAnH2WRNSTUL/sMlD/yRBy0srLi5uqjQSyZFuIS3ToCJ93Leey52gSBNdYPmQPvunoawybLEcG4sUVFia9BADZ7Us73wK8/OwojO4/vJDk7q+wn3f6sbSl2+wa9hsPHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0oeVrd7hvlh6G2GPzpskJ8+RiOcaguxeK7lUu9NUsQ=;
 b=NKmqVNgoRggkH5ikpQ/YFmZBwSm8629VvbldhwOIZM7PcX2ZsOywfW3aDbx9ftXKXK0ZOOaOXftmWUFRKS3pQDJw8oUL8bDLcRe5FeletFeuU27tyY5nOTWqlMrKAfI7uV2+TrvsFrg2l6tklm4hDjgjuYvhvmCaiagbAm8WwN0=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2400.namprd18.prod.outlook.com (20.179.80.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Mon, 2 Sep 2019 07:47:15 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 07:47:15 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v8 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
Thread-Topic: [PATCH v8 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Index: AQHVXNvAQlW4iqZlJUiw9MFzRQDrCacSMDaAgAEJoTCAAzFWAIABoBOA
Date:   Mon, 2 Sep 2019 07:47:15 +0000
Message-ID: <MN2PR18MB3182B51522E026568561AB53A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
 <20190827132846.9142-4-michal.kalderon@marvell.com>
 <c8781373-53ec-649e-1f1d-56cc17c229f9@amazon.com>
 <MN2PR18MB31820C96A5906F9054AE23D6A1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <61cf039c-793e-e9e6-60e0-cd93b6da4815@amazon.com>
In-Reply-To: <61cf039c-793e-e9e6-60e0-cd93b6da4815@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ebdf32d-8696-40c8-c32d-08d72f79c607
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2400;
x-ms-traffictypediagnostic: MN2PR18MB2400:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB24005291EAD0DC9175167C27A1BE0@MN2PR18MB2400.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39850400004)(346002)(199004)(189003)(305945005)(6436002)(74316002)(55016002)(53546011)(53936002)(14444005)(7696005)(256004)(9686003)(76116006)(316002)(7736002)(102836004)(5660300002)(71200400001)(71190400001)(66066001)(229853002)(26005)(186003)(4326008)(25786009)(99286004)(33656002)(6506007)(54906003)(52536014)(14454004)(76176011)(8936002)(2906002)(81166006)(81156014)(11346002)(478600001)(446003)(6916009)(66446008)(64756008)(66556008)(66476007)(8676002)(66946007)(3846002)(6116002)(476003)(6246003)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nq00Ck9I1MaGTy3od/tRmQqpgrQ11I6s0W8n54mOmfk3Dgoh3KTX1mIZCc4TTuzVxFCe1Krqb7+egLP0+AgVIhLqbXF3jsJUok1NfbygNI7uXwDHQc/yd9LBL91kQwc8EpIk5mRffcb6pZxmrfOfSVTSpL0bYnB3/Nz9k6k+1cYzcGvUrgoEi/37sGYBLpCJIvr67ngfYoHMqEMG9+zdJ707c/D3s7Sc/blFvoyv+FGzTKdObErUs/v2mpSoGbBc7CAikN55fcZh6uqQuzQeJReK2YEkYo9STP2goa0ZPw8x2NvMmaiUCykPdsm1JaSOrkpSHQJBshVsMHHEzzsuosGCHhf+YR8zbwlLlRLAMuU4T6wMm5UkblZn8wIZxi0/iaFbrgZIxx6syJjJHKT1UqVP4TpLUXKAJDUnlMIz1Zs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebdf32d-8696-40c8-c32d-08d72f79c607
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 07:47:15.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkL/CIPS9VpnyaJl37RSIbp/++wj8kxe+aQCEkxqItLmIfFmSy1DojuxhiBbHdVbagYR0f/bJNuFPY+lL/LcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_02:2019-08-29,2019-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFN1bmRh
eSwgU2VwdGVtYmVyIDEsIDIwMTkgOTo1NyBBTQ0KPiANCj4gT24gMzAvMDgvMjAxOSA5OjE1LCBN
aWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4+IEZyb206IEdhbCBQcmVzc21hbiA8Z2FscHJlc3NA
YW1hem9uLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyOSwgMjAxOSA1OjIxIFBN
DQo+ID4+DQo+ID4+IE9uIDI3LzA4LzIwMTkgMTY6MjgsIE1pY2hhbCBLYWxkZXJvbiB3cm90ZToN
Cj4gPj4+ICtzdGF0aWMgdm9pZCBlZmFfcXBfdXNlcl9tbWFwX2VudHJpZXNfcmVtb3ZlKHN0cnVj
dCBlZmFfdWNvbnRleHQNCj4gPj4gKnVjb250ZXh0LA0KPiA+Pj4gKwkJCQkJICAgIHN0cnVjdCBl
ZmFfcXAgKnFwKQ0KPiA+Pj4gK3sNCj4gPj4+ICsJcmRtYV91c2VyX21tYXBfZW50cnlfcmVtb3Zl
KCZ1Y29udGV4dC0+aWJ1Y29udGV4dCwgcXAtDQo+ID4+PiBzcV9kYl9tbWFwX2tleSk7DQo+ID4+
PiArCXJkbWFfdXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmdWNvbnRleHQtPmlidWNvbnRleHQsDQo+
ID4+PiArCQkJCSAgICBxcC0+bGxxX2Rlc2NfbW1hcF9rZXkpOw0KPiA+Pj4gKwlyZG1hX3VzZXJf
bW1hcF9lbnRyeV9yZW1vdmUoJnVjb250ZXh0LT5pYnVjb250ZXh0LCBxcC0NCj4gPj4+IHJxX21t
YXBfa2V5KTsNCj4gPj4+ICsJcmRtYV91c2VyX21tYXBfZW50cnlfcmVtb3ZlKCZ1Y29udGV4dC0+
aWJ1Y29udGV4dCwNCj4gPj4+ICtxcC0+cnFfZGJfbW1hcF9rZXkpOw0KPiA+Pg0KPiA+PiBQbGVh
c2UgcmVtb3ZlIHRoZSBlbnRyaWVzIGluIHJldmVyc2UgaW5zZXJ0aW9uIG9yZGVyLg0KPiA+IEkg
ZG9uJ3QgbWluZCBmaXhpbmcsIGJ1dCB3aHkgPw0KPiANCj4gU28gdGhlIGZsb3dzIHdpbGwgYmUg
c3ltbWV0cmljLg0KPiANCj4gPj4NCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiBAQCAtNzY3LDE1
ICs3MjYsMTcgQEAgc3RydWN0IGliX3FwICplZmFfY3JlYXRlX3FwKHN0cnVjdCBpYl9wZA0KPiA+
Pj4gKmlicGQsDQo+ID4+Pg0KPiA+Pj4gIAlyZXR1cm4gJnFwLT5pYnFwOw0KPiA+Pj4NCj4gPj4+
ICtlcnJfcmVtb3ZlX21tYXBfZW50cmllczoNCj4gPj4+ICsJZWZhX3FwX3VzZXJfbW1hcF9lbnRy
aWVzX3JlbW92ZSh1Y29udGV4dCwgcXApOw0KPiA+Pj4gIGVycl9kZXN0cm95X3FwOg0KPiA+Pj4g
IAllZmFfZGVzdHJveV9xcF9oYW5kbGUoZGV2LCBjcmVhdGVfcXBfcmVzcC5xcF9oYW5kbGUpOw0K
PiA+Pj4gIGVycl9mcmVlX21hcHBlZDoNCj4gPj4+IC0JaWYgKHFwLT5ycV9zaXplKSB7DQo+ID4+
PiArCWlmIChxcC0+cnFfZG1hX2FkZHIpDQo+ID4+DQo+ID4+IFdoYXQncyB0aGUgZGlmZmVyZW5j
ZT8NCj4gPiBTZWVtZWQgYSBiZXR0ZXIgcXVlcnkgc2luY2UgaXQgbm93IG9ubHkgY292ZXJzIHRo
ZSBycV9kbWFfYWRkcg0KPiB1bm1hcHBpbmcuDQo+ID4NCj4gPj4NCj4gPj4+ICAJCWRtYV91bm1h
cF9zaW5nbGUoJmRldi0+cGRldi0+ZGV2LCBxcC0+cnFfZG1hX2FkZHIsDQo+ID4+IHFwLT5ycV9z
aXplLA0KPiA+Pj4gIAkJCQkgRE1BX1RPX0RFVklDRSk7DQo+ID4+PiAtCQlpZiAoIXJxX2VudHJ5
X2luc2VydGVkKQ0KPiA+Pj4gLQkJCWZyZWVfcGFnZXNfZXhhY3QocXAtPnJxX2NwdV9hZGRyLCBx
cC0+cnFfc2l6ZSk7DQo+ID4+PiAtCX0NCj4gPj4+ICsNCj4gPj4+ICsJaWYgKHFwLT5ycV9tbWFw
X2tleSA9PSBSRE1BX1VTRVJfTU1BUF9JTlZBTElEKQ0KPiA+Pj4gKwkJZnJlZV9wYWdlc19leGFj
dChxcC0+cnFfY3B1X2FkZHIsIHFwLT5ycV9zaXplKTsNCj4gPj4NCj4gPj4gVGhpcyBzaG91bGQg
YmUgaW5zaWRlIHRoZSBwcmV2aW91cyBpZiBzdGF0ZW1lbnQsIG90aGVyd2lzZSBpdCBtaWdodA0K
PiA+PiB0cnkgdG8gZnJlZSBwYWdlcyB0aGF0IHdlcmVuJ3QgYWxsb2NhdGVkLg0KPiA+IElmIHRo
ZXkgd2VyZW4ndCBhbGxvY2F0ZWQgdGhlIGtleSB3aWxsIGJlIElOVkFMSUQgYW5kIHRoZXkgd29u
J3QgYmUgZnJlZWQuDQo+IA0KPiBJZiB0aGUga2V5IGlzIElOVkFMSUQgeW91IGNhbGwgZnJlZV9w
YWdlc19leGFjdCwgYnV0IHJxX2NwdV9hZGRyIG1pZ2h0IGhhdmUNCj4gbmV2ZXIgYmVlbiBhbGxv
Y2F0ZWQgKGlmIFJRIGlzIG9mIHNpemUgemVybykuDQpSaWdodCwgdGhhbmtzDQo+IA0KPiA+DQo+
ID4+DQo+ID4+PiAgZXJyX2ZyZWVfcXA6DQo+ID4+PiAgCWtmcmVlKHFwKTsNCj4gPj4+ICBlcnJf
b3V0Og0KPiA+Pj4gQEAgLTg4Nyw2ICs4NDgsNyBAQCBzdGF0aWMgaW50IGVmYV9kZXN0cm95X2Nx
X2lkeChzdHJ1Y3QgZWZhX2Rldg0KPiA+Pj4gKmRldiwgaW50IGNxX2lkeCkNCj4gPj4+DQo+ID4+
PiAgdm9pZCBlZmFfZGVzdHJveV9jcShzdHJ1Y3QgaWJfY3EgKmliY3EsIHN0cnVjdCBpYl91ZGF0
YSAqdWRhdGEpICB7DQo+ID4+PiArCXN0cnVjdCBlZmFfdWNvbnRleHQgKnVjb250ZXh0Ow0KPiA+
Pg0KPiA+PiBSZXZlcnNlIHhtYXMgdHJlZS4NCj4gPiBvaw0KPiA+Pg0KPiA+Pj4gIAlzdHJ1Y3Qg
ZWZhX2RldiAqZGV2ID0gdG9fZWRldihpYmNxLT5kZXZpY2UpOw0KPiA+Pj4gIAlzdHJ1Y3QgZWZh
X2NxICpjcSA9IHRvX2VjcShpYmNxKTsNCj4gPj4+DQo+ID4+PiBAQCAtODk0LDIwICs4NTYsMzMg
QEAgdm9pZCBlZmFfZGVzdHJveV9jcShzdHJ1Y3QgaWJfY3EgKmliY3EsIHN0cnVjdA0KPiA+PiBp
Yl91ZGF0YSAqdWRhdGEpDQo+ID4+PiAgCQkgICJEZXN0cm95IGNxWyVkXSB2aXJ0WzB4JXBdIGZy
ZWVkOiBzaXplWyVsdV0sIGRtYVslcGFkXVxuIiwNCj4gPj4+ICAJCSAgY3EtPmNxX2lkeCwgY3Et
PmNwdV9hZGRyLCBjcS0+c2l6ZSwgJmNxLT5kbWFfYWRkcik7DQo+ID4+Pg0KPiA+Pj4gKwl1Y29u
dGV4dCA9IHJkbWFfdWRhdGFfdG9fZHJ2X2NvbnRleHQodWRhdGEsIHN0cnVjdCBlZmFfdWNvbnRl
eHQsDQo+ID4+PiArCQkJCQkgICAgIGlidWNvbnRleHQpOw0KPiA+Pj4gIAllZmFfZGVzdHJveV9j
cV9pZHgoZGV2LCBjcS0+Y3FfaWR4KTsNCj4gPj4+ICAJZG1hX3VubWFwX3NpbmdsZSgmZGV2LT5w
ZGV2LT5kZXYsIGNxLT5kbWFfYWRkciwgY3EtPnNpemUsDQo+ID4+PiAgCQkJIERNQV9GUk9NX0RF
VklDRSk7DQo+ID4+PiArCXJkbWFfdXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmdWNvbnRleHQtPmli
dWNvbnRleHQsDQo+ID4+PiArCQkJCSAgICBjcS0+bW1hcF9rZXkpOw0KPiA+Pg0KPiA+PiBFbnRy
eSByZW1vdmFsIHNob3VsZCBiZSBmaXJzdC4NCj4gPiBXaHkgPyByZW1vdmluZyBjYW4gbGVhZCB0
byBmcmVlaW5nLCB3aHkgd291bGQgd2Ugd2FudCB0aGF0IGJlZm9yZQ0KPiB1bm1hcHBpbmcgPw0K
PiANCj4gTWFrZXMgc2Vuc2UsIHRoYW5rcy4NCj4gDQo+ID4+DQo+ID4+PiAgfQ0KPiA+Pj4NCg==
