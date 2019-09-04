Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D312A7BF9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 08:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfIDGsV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 02:48:21 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:58124 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728145AbfIDGsV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 02:48:21 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x846jmOn026991;
        Tue, 3 Sep 2019 23:48:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=pKMiC3+Qv/TZsjNzXfhYBhl7+nF42K8I70MWrE1qm2Y=;
 b=OOhBAJnSMeBvTB6bYq7MzfRfgTn2LhJCdUx6ZPcpBNb+edcmWFMNgzwMkdGWIeEMxSI2
 38AN8jgCAiU5GX5nRajKN7bga0cREXXck5OprxEGpv7oBN29Sz9Y/pIW0A/RyNk6NPQr
 r0ydb7kNHTYzfobtukvpd35RPNuM8UT7zqgFQQS3yXssFnx+42sB3wY6O6MWhOWDvR3j
 1hZUbPUArZwoi660Ub7//UUhjX2jbvoteVnrywIya5dRN7/i2KWnUBzDO03p7492DBla
 SRWxZgGng2bKhQoVrq2dDLE89YdkUaOpI8qOEzCqAgbYync6Ruow3131uf2/7TS74fVB TQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8pdj7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 23:48:16 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 3 Sep
 2019 23:48:14 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.56) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Sep 2019 23:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoYOnXcm5fiO9oY3FL9TsoaVBbC+56TqHTMZnQ1uNAOYib1LQ+t7GXbltk8UXf7ayjJMFbe4ADjElaPUCG1tH4baBotM0itfZaoOL2JyVLZI+yZktZ8lppeBJjwWVU2rKfMofWqfmVcDa2kRB5aJ08UJKeY/23JX4M9JlF+70NAueirpfOu2IKMGoUQcxyW8jj7km6K1gziS/Y1BFWEMMEgWcto9U7tpO55Bah6OtqdKHkZ11Y2zGCmOzs3/E+ms9IrJC5ncaTCo92+N625wD0e2o9Yza5zHTz37ieDLiF3+OBWmFabIdP5qxDgSUogulhQ7v9XAwoWVzpDB1IGbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKMiC3+Qv/TZsjNzXfhYBhl7+nF42K8I70MWrE1qm2Y=;
 b=NHBrstTDBS0pI2aprlQmYoF+MtkCjg3FaJWUMFayEnJztK7ECn/Hj9C/Fe7w8RTeqQFQDdVxOAR+b5j50Kff29SYxPemTOdltclq6tP8ho2eLnUU0owALGlI6YwnwPCnyKwW8kLu18uCkuGx0k/byAJ4v5wSgWRheVURdddn4MW9TU7gY+qafEh2CoCb8udq1kMoDUJPrWn+3iexMp0Y++7M6mZHw+0cbujFuZcin5xwIBwMgztkvyjH8TYu2HEEoxhcYLh/bv9eAtyQcQTlAEBuSA+wn1B0og/c5wNh0czxBCaWscSiTYmPGUwDKqs56tgAGzr8Mn+s+2ra2Ytpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKMiC3+Qv/TZsjNzXfhYBhl7+nF42K8I70MWrE1qm2Y=;
 b=pPn++DxDx8oGtSfGFrpXAp0h6bfgG85fkOVOowIKz/ROHIrVNC7fcQ2X9Pq1IlsVDP/CZZMDIpVz0dKu7xElo9lAGw/HrHpkKK/2XL644bse9kjJccLqGNjc20pTsnXm98JMrYvvIoDFodIu71refVy8TWUpEuQ1ynKzPHKOPzY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2525.namprd18.prod.outlook.com (20.179.82.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 06:48:13 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 06:48:13 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v9 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
Thread-Topic: [PATCH v9 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Index: AQHVYasE9IckMm8hhkyxDQ4T8KGJo6cZpSsAgAALhHCAAF6NAIABBmrQ
Date:   Wed, 4 Sep 2019 06:48:12 +0000
Message-ID: <MN2PR18MB3182F29E8F63A963BD088A3CA1B80@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190902162314.17508-1-michal.kalderon@marvell.com>
 <20190902162314.17508-4-michal.kalderon@marvell.com>
 <c6a758ce-3b9e-5e95-5a44-d8add311d976@amazon.com>
 <MN2PR18MB31827812160980AA00992B92A1B90@MN2PR18MB3182.namprd18.prod.outlook.com>
 <47b5d22f-e208-0ed2-19d3-b1beb22cf806@amazon.com>
In-Reply-To: <47b5d22f-e208-0ed2-19d3-b1beb22cf806@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c83783e9-db5c-483a-0265-08d73103db53
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2525;
x-ms-traffictypediagnostic: MN2PR18MB2525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2525D049B0B9CAD1584993C5A1B80@MN2PR18MB2525.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(76176011)(14454004)(53936002)(6436002)(11346002)(8676002)(7696005)(81166006)(478600001)(81156014)(33656002)(6916009)(8936002)(3846002)(476003)(6116002)(7736002)(9686003)(305945005)(6506007)(102836004)(26005)(4326008)(2906002)(53546011)(55016002)(74316002)(229853002)(86362001)(446003)(6246003)(186003)(486006)(71200400001)(54906003)(316002)(71190400001)(66446008)(66946007)(64756008)(66476007)(66556008)(52536014)(76116006)(14444005)(99286004)(66066001)(5660300002)(25786009)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2525;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ouykZAslC0ssNYGqU9SIvtXfiqqTYZqWaCgZ3dI1CQp2/igVJYFdsfEszjuPBY42HSC29IXU4zeMcp9X15ji3zlK5gUx1tZAIFqW5rvGaWcuXqBdL0MHBXG04jZYbHQUJ+B4YDPO4itozCjeZ6iSZdwfjkYuHw6zteM1tZU3M1GKq1p4tNk1ko2aMW96wGH8F8vXNj9OOqHSJdXkya0eqB9ofcqnTggMaguSZes64ShV4vUGZ3lokYgf0F+MpZnhXzN2NSQJ371fQHCZQLK7Hj2hkUAVGCKvwEo8N2iobHer4dqEHY0CXwOptMVXCVGoexul3w78d2DHIogMm5prQl3LT7MarmdZB1BwEW7Cbcfb4nBP2pK93Kd/tlltJyILHQHNSMpC3AnAX4OEddjzT8Bc1AszfRxDic8+X8nWDhU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c83783e9-db5c-483a-0265-08d73103db53
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 06:48:12.8339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRFASdsgA07xUc17cvfJvA2JBNrQv2GIlLr5ltNBd03XKNRMH/YbDjoL7sHWPpN0Y4wZ3dQveD8Brxlxd0SpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2525
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_01:2019-09-03,2019-09-04 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIFNlcHRlbWJlciAzLCAyMDE5IDY6MDcgUE0NCj4gDQo+IE9uIDAzLzA5LzIwMTkgMTI6MzEs
IE1pY2hhbCBLYWxkZXJvbiB3cm90ZToNCj4gPj4gRnJvbTogbGludXgtcmRtYS1vd25lckB2Z2Vy
Lmtlcm5lbC5vcmcgPGxpbnV4LXJkbWEtDQo+ID4+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24g
QmVoYWxmIE9mIEdhbCBQcmVzc21hbg0KPiA+Pg0KPiA+PiBPbiAwMi8wOS8yMDE5IDE5OjIzLCBN
aWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4+PiAgaW50IGVmYV9kZXN0cm95X3FwKHN0cnVjdCBp
Yl9xcCAqaWJxcCwgc3RydWN0IGliX3VkYXRhICp1ZGF0YSkgIHsNCj4gPj4+ICsJc3RydWN0IGVm
YV91Y29udGV4dCAqdWNvbnRleHQgPQ0KPiA+PiByZG1hX3VkYXRhX3RvX2Rydl9jb250ZXh0KHVk
YXRhLA0KPiA+Pj4gKwkJc3RydWN0IGVmYV91Y29udGV4dCwgaWJ1Y29udGV4dCk7DQo+ID4+PiAg
CXN0cnVjdCBlZmFfZGV2ICpkZXYgPSB0b19lZGV2KGlicXAtPnBkLT5kZXZpY2UpOw0KPiA+Pj4g
IAlzdHJ1Y3QgZWZhX3FwICpxcCA9IHRvX2VxcChpYnFwKTsNCj4gPj4+ICAJaW50IGVycjsNCj4g
Pj4+DQo+ID4+PiAgCWliZGV2X2RiZygmZGV2LT5pYmRldiwgIkRlc3Ryb3kgcXBbJXVdXG4iLCBp
YnFwLT5xcF9udW0pOw0KPiA+Pj4gKw0KPiA+Pj4gKwllZmFfcXBfdXNlcl9tbWFwX2VudHJpZXNf
cmVtb3ZlKHVjb250ZXh0LCBxcCk7DQo+ID4+PiArDQo+ID4+PiAgCWVyciA9IGVmYV9kZXN0cm95
X3FwX2hhbmRsZShkZXYsIHFwLT5xcF9oYW5kbGUpOw0KPiA+Pj4gIAlpZiAoZXJyKQ0KPiA+Pj4g
IAkJcmV0dXJuIGVycjsNCj4gPj4+IEBAIC01MDksNTcgKzQxMiwxMTQgQEAgaW50IGVmYV9kZXN0
cm95X3FwKHN0cnVjdCBpYl9xcCAqaWJxcCwgc3RydWN0DQo+ID4+IGliX3VkYXRhICp1ZGF0YSkN
Cj4gPj4+ICAJcmV0dXJuIDA7DQo+ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+ICB2b2lkIGVmYV9kZXN0
cm95X2NxKHN0cnVjdCBpYl9jcSAqaWJjcSwgc3RydWN0IGliX3VkYXRhICp1ZGF0YSkgIHsNCj4g
Pj4+ICsJc3RydWN0IGVmYV91Y29udGV4dCAqdWNvbnRleHQgPQ0KPiA+PiByZG1hX3VkYXRhX3Rv
X2Rydl9jb250ZXh0KHVkYXRhLA0KPiA+Pj4gKwkJCXN0cnVjdCBlZmFfdWNvbnRleHQsIGlidWNv
bnRleHQpOw0KPiA+Pj4gKw0KPiA+Pj4gIAlzdHJ1Y3QgZWZhX2RldiAqZGV2ID0gdG9fZWRldihp
YmNxLT5kZXZpY2UpOw0KPiA+Pj4gIAlzdHJ1Y3QgZWZhX2NxICpjcSA9IHRvX2VjcShpYmNxKTsN
Cj4gPj4+DQo+ID4+PiBAQCAtODk3LDE3ICs4NjIsMjggQEAgdm9pZCBlZmFfZGVzdHJveV9jcShz
dHJ1Y3QgaWJfY3EgKmliY3EsIHN0cnVjdA0KPiA+PiBpYl91ZGF0YSAqdWRhdGEpDQo+ID4+PiAg
CWVmYV9kZXN0cm95X2NxX2lkeChkZXYsIGNxLT5jcV9pZHgpOw0KPiA+Pj4gIAlkbWFfdW5tYXBf
c2luZ2xlKCZkZXYtPnBkZXYtPmRldiwgY3EtPmRtYV9hZGRyLCBjcS0+c2l6ZSwNCj4gPj4+ICAJ
CQkgRE1BX0ZST01fREVWSUNFKTsNCj4gPj4+ICsJcmRtYV91c2VyX21tYXBfZW50cnlfcmVtb3Zl
KCZ1Y29udGV4dC0+aWJ1Y29udGV4dCwNCj4gPj4+ICsJCQkJICAgIGNxLT5tbWFwX2tleSk7DQo+
ID4+DQo+ID4+IEhvdyBjb21lIGluIGRlc3Ryb3lfcXAgd2UgZG8gZW50cnkgcmVtb3ZhbCBmaXJz
dCwgYnV0IGluIGRlc3Ryb3lfY3ENCj4gPj4gaXQncyBsYXN0Pw0KPiA+PiBTaG91bGRuJ3QgaXQg
YmUgdGhlIHNhbWU/DQo+ID4gWWVzLCB5b3UncmUgcmlnaHQsIGl0IHNob3VsZCBiZSBkb25lIGFm
dGVyIG1lbW9yeSBpcyB1bm1hcHBlZCwgSSdsbA0KPiA+IG1vdmUgaXQgZG93biBJbiB0aGUgZGVz
dHJveSBxcCBmbG93LiBJcyB0aGlzIHRoZSBvbmx5IGNvbW1lbnQgb24gdGhpcw0KPiBzZXJpZXMg
Pw0KPiANCj4gT3RoZXIgdGhhbiB0aGF0IHRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1lLA0KPiBB
Y2tlZC1ieTogR2FsIFByZXNzbWFuIDxnYWxwcmVzc0BhbWF6b24uY29tPg0KPiANCj4gQSBmZXcg
bml0cyAoZmVlbCBmcmVlIHRvIGlnbm9yZSk6DQo+ICogVGhlIHJkbWFfdXNlcl9tbWFwX2VudHJ5
IGlzIGFsd2F5cyByZWZlcnJlZCB0byBhcyByZG1hX2VudHJ5IGV4Y2VwdCBpbg0KPiBlZmFfbW1h
cF9mcmVlIGRlY2xhcmF0aW9uIGFuZCB0b19lbW1hcC4NCj4gKiBlZmFfcXBfdXNlcl9tbWFwX2Vu
dHJpZXNfcmVtb3ZlIGlzbid0IHJlYWxseSBpbiByZXZlcnNlIGluc2VydGlvbiBvcmRlcg0KPiBi
dXQgT0sgOikuDQo+ICogSW4gY2FzZSBvZiBsZW5ndGggbWlzbWF0Y2ggaW4gX19lZmFfbW1hcCB0
d28gZXJyb3IgbWVzc2FnZXMgYXJlDQo+IHByaW50ZWQsIGNvbnNpZGVyIGtlZXBpbmcgdGhlICJD
b3VsZG4ndCBtbWFwIGFkZHJlc3MgLi4uIiBwcmludCBpbiB0aGUgaWYgKG5vdA0KPiBwYXJ0IG9m
IHRoZSBnb3RvIGxhYmVsKS4NCj4gDQpUaGFua3MsIGFzIEknbSBhbHJlYWR5IHNlbmRpbmcgYW5v
dGhlciBzZXJpZXMgSSdsbCBmaXggdGhlIG5pdHMg8J+YiiANCg0KPiBUaGFua3MgZm9yIGRvaW5n
IHRoaXMhDQo=
