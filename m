Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1587A6539
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfICJbt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 05:31:49 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:4438 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbfICJbr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 05:31:47 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x839ToMV006652;
        Tue, 3 Sep 2019 02:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=aACiXf8Kg++ReAyAMtQ0aJcqMXJErnZmlG2VOGG1Oro=;
 b=YRsZ/n5Gb4p6offnpx7Vt9YXFVDKKOAslpTm0xwc0jeDRbE0y7TdNyiOTP3ne8RmJZrL
 yFFrDWOAvhmdv6OAwr5keBb7+7qNdYtK+7HhCObcMArLUBzYAjl5NKrrkLGVJvjzUov7
 Ksz+nfalbVJCdiQEG7jJqSf1L2MhmYRq+zSOrxF+EpDxd77H7aM+7j0Zgrh25Y4td/K1
 xJZ7ZNWy1ZBkqAR029JU6yyItRn607m+BXPOYz4bBg7rCDR8wfkVGp6A3qNpWugnIqYA
 pQSaYe6EB+tol13PbBXQPJogRUOKdh+hYM9eMWh5XzA/hOhDOXOWe4fowvaUB9cb4XYz ZQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p9jd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 02:31:43 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 3 Sep
 2019 02:31:41 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Sep 2019 02:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxO0k4b4d8W2BHeiz9MixSrdLZ1Or6Cb74eCa8nLBm9FPxKbhtjHna6esmZRQj0fbGuyjQi+PgkxYc+m+vs41JlZYYPnnfoZkXnx2h4Sr9MtsL7/hGNOSglbcl0ARLqm6NtUFjOKKRoc0B6GcRjFa7q9Yh11w8t4SZsYsVr2xSA6ifQuS4OibK1u1KXgTM5tNQcJvc4tg77nzjdrvAy2PibylcUCwIQVJV+VZgvAKDfLAksbgfu2wPYKv0Q5hxGTpEVXq4b23XOx58cyBuPrB2RvCifPka+O+Qoj3jaDPMxJgzEf9Kuf0d4DNSty9v6x9TykYzU7iwj/cq+yIjEuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aACiXf8Kg++ReAyAMtQ0aJcqMXJErnZmlG2VOGG1Oro=;
 b=UXHqIs0nP7NFjwkPPRm1/G0TrBjBsomlKAkH6bpZYYBOEH8IcYEK9uBkpOut/P0cXymQC1W+D417tPtrfBgT3MjWNAzY/3RsSLg+tZccBJIrjS81Cv0rW+hEUePVM5jNFMt3Df4qM8GgTL2JxpfjviPrpr9twg6xDyML60ipkn9OD+Y9/U5XWnuB51IT4JlVJKXO4qZpWZ0Gv2Ea+tLytiRw5RjwCSk2BOb8I/i4/E+YKmMo/kyV9WME4DxJ9oB1axTcGTcGAvb8hYZPtyeZRR4d9B5KWvFu3Yw4ANx6HT9nJdVtnjHpkBhNuLH6jgTn6+baMmzs4YfNPyMZOpZkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aACiXf8Kg++ReAyAMtQ0aJcqMXJErnZmlG2VOGG1Oro=;
 b=RSWy+2S0Pp1ZnuI3X53xy3Erh5BlngVqPAFyKHW8xuAfOjedA0QnTPpl5YJWgywCH4H9EVhkyA49c+JplcurF5lrgHVt25qx43HaZnFSbDMXQuZMhkCoHFkj9GK/56QhA8zHKxBJ6gPMAA8dfI3Fq4BeMo3m9BZbeMVjoWHUzro=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3103.namprd18.prod.outlook.com (10.255.86.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 3 Sep 2019 09:31:19 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 09:31:19 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v9 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
Thread-Topic: [PATCH v9 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Index: AQHVYasE9IckMm8hhkyxDQ4T8KGJo6cZpSsAgAALhHA=
Date:   Tue, 3 Sep 2019 09:31:18 +0000
Message-ID: <MN2PR18MB31827812160980AA00992B92A1B90@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190902162314.17508-1-michal.kalderon@marvell.com>
 <20190902162314.17508-4-michal.kalderon@marvell.com>
 <c6a758ce-3b9e-5e95-5a44-d8add311d976@amazon.com>
In-Reply-To: <c6a758ce-3b9e-5e95-5a44-d8add311d976@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.177.63.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36f1506a-51b4-42fb-a07a-08d7305179db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3103;
x-ms-traffictypediagnostic: MN2PR18MB3103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31032D38452E0CA0F6F7E870A1B90@MN2PR18MB3103.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(199004)(189003)(66946007)(486006)(7736002)(8936002)(81166006)(81156014)(446003)(229853002)(53936002)(86362001)(2906002)(186003)(305945005)(53546011)(11346002)(74316002)(9686003)(64756008)(14454004)(4326008)(52536014)(316002)(6916009)(256004)(76176011)(102836004)(71190400001)(71200400001)(7696005)(54906003)(33656002)(6436002)(107886003)(476003)(66066001)(26005)(6246003)(3846002)(6116002)(8676002)(25786009)(5660300002)(478600001)(76116006)(66446008)(6506007)(99286004)(55016002)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3103;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PkIuDO7j9C4WEq3MxGvHmdYoWB9EaPwEb5eYrlfyFY74Fu+yHjxGKVUufCtjmsBTASYbsOcj6pk4u59J29Gp/oeiamPCLc1ehsR9vbozS1TX1oALRa29zgMwF+nNKRyJSacNrpvx/CEEzFz58xOlyXq8TOHXLhLk2QzeyhC9Y4BMidzcPxD6ks2/i2MPy3FqO/GzMQ9xnuqdFhnLo9ZL4v9lw65Rvzoqf6S+n0qu4P8eaFl4QXTNsI8y3ZKsozJib4S54b0dfkgeENUM0JQPowlSCxl3I833A/zL9VR5LH5r/qVEtjtv+6lDFrcpkVLjyEK/PmcKGzq4whrJl/JkiSvg4xq2BYRIOi/DR71mfTJ6vQidQQrG6DneqIC0YWdNKRfXITEcq2QuJ/SD3jZogPCTB2ViVWIuejtuQuaC1TM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f1506a-51b4-42fb-a07a-08d7305179db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 09:31:18.9316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96wFzZpTf5ULHAOkJF/jLjOaFHUiUPkgnXg0eCC+KuNC7neHa7kp0lvp1yPUuzw2tDIydzcspQ9H8BzDyfjYNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3103
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+IA0KPiBP
biAwMi8wOS8yMDE5IDE5OjIzLCBNaWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4gIGludCBlZmFf
ZGVzdHJveV9xcChzdHJ1Y3QgaWJfcXAgKmlicXAsIHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEpICB7
DQo+ID4gKwlzdHJ1Y3QgZWZhX3Vjb250ZXh0ICp1Y29udGV4dCA9DQo+IHJkbWFfdWRhdGFfdG9f
ZHJ2X2NvbnRleHQodWRhdGEsDQo+ID4gKwkJc3RydWN0IGVmYV91Y29udGV4dCwgaWJ1Y29udGV4
dCk7DQo+ID4gIAlzdHJ1Y3QgZWZhX2RldiAqZGV2ID0gdG9fZWRldihpYnFwLT5wZC0+ZGV2aWNl
KTsNCj4gPiAgCXN0cnVjdCBlZmFfcXAgKnFwID0gdG9fZXFwKGlicXApOw0KPiA+ICAJaW50IGVy
cjsNCj4gPg0KPiA+ICAJaWJkZXZfZGJnKCZkZXYtPmliZGV2LCAiRGVzdHJveSBxcFsldV1cbiIs
IGlicXAtPnFwX251bSk7DQo+ID4gKw0KPiA+ICsJZWZhX3FwX3VzZXJfbW1hcF9lbnRyaWVzX3Jl
bW92ZSh1Y29udGV4dCwgcXApOw0KPiA+ICsNCj4gPiAgCWVyciA9IGVmYV9kZXN0cm95X3FwX2hh
bmRsZShkZXYsIHFwLT5xcF9oYW5kbGUpOw0KPiA+ICAJaWYgKGVycikNCj4gPiAgCQlyZXR1cm4g
ZXJyOw0KPiA+IEBAIC01MDksNTcgKzQxMiwxMTQgQEAgaW50IGVmYV9kZXN0cm95X3FwKHN0cnVj
dCBpYl9xcCAqaWJxcCwgc3RydWN0DQo+IGliX3VkYXRhICp1ZGF0YSkNCj4gPiAgCXJldHVybiAw
Ow0KPiA+ICB9DQo+ID4NCj4gPiAgdm9pZCBlZmFfZGVzdHJveV9jcShzdHJ1Y3QgaWJfY3EgKmli
Y3EsIHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEpICB7DQo+ID4gKwlzdHJ1Y3QgZWZhX3Vjb250ZXh0
ICp1Y29udGV4dCA9DQo+IHJkbWFfdWRhdGFfdG9fZHJ2X2NvbnRleHQodWRhdGEsDQo+ID4gKwkJ
CXN0cnVjdCBlZmFfdWNvbnRleHQsIGlidWNvbnRleHQpOw0KPiA+ICsNCj4gPiAgCXN0cnVjdCBl
ZmFfZGV2ICpkZXYgPSB0b19lZGV2KGliY3EtPmRldmljZSk7DQo+ID4gIAlzdHJ1Y3QgZWZhX2Nx
ICpjcSA9IHRvX2VjcShpYmNxKTsNCj4gPg0KPiA+IEBAIC04OTcsMTcgKzg2MiwyOCBAQCB2b2lk
IGVmYV9kZXN0cm95X2NxKHN0cnVjdCBpYl9jcSAqaWJjcSwgc3RydWN0DQo+IGliX3VkYXRhICp1
ZGF0YSkNCj4gPiAgCWVmYV9kZXN0cm95X2NxX2lkeChkZXYsIGNxLT5jcV9pZHgpOw0KPiA+ICAJ
ZG1hX3VubWFwX3NpbmdsZSgmZGV2LT5wZGV2LT5kZXYsIGNxLT5kbWFfYWRkciwgY3EtPnNpemUs
DQo+ID4gIAkJCSBETUFfRlJPTV9ERVZJQ0UpOw0KPiA+ICsJcmRtYV91c2VyX21tYXBfZW50cnlf
cmVtb3ZlKCZ1Y29udGV4dC0+aWJ1Y29udGV4dCwNCj4gPiArCQkJCSAgICBjcS0+bW1hcF9rZXkp
Ow0KPiANCj4gSG93IGNvbWUgaW4gZGVzdHJveV9xcCB3ZSBkbyBlbnRyeSByZW1vdmFsIGZpcnN0
LCBidXQgaW4gZGVzdHJveV9jcSBpdCdzDQo+IGxhc3Q/DQo+IFNob3VsZG4ndCBpdCBiZSB0aGUg
c2FtZT8NClllcywgeW91J3JlIHJpZ2h0LCBpdCBzaG91bGQgYmUgZG9uZSBhZnRlciBtZW1vcnkg
aXMgdW5tYXBwZWQsIEknbGwgbW92ZSBpdCBkb3duDQpJbiB0aGUgZGVzdHJveSBxcCBmbG93LiBJ
cyB0aGlzIHRoZSBvbmx5IGNvbW1lbnQgb24gdGhpcyBzZXJpZXMgPyANClRoYW5rcywNCk1pY2hh
bCANCg0KDQo=
