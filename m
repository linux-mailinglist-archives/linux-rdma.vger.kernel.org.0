Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3129A54B4
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 13:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfIBLVY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 07:21:24 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47446 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730162AbfIBLVX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 07:21:23 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82BJg2U023743;
        Mon, 2 Sep 2019 04:21:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=2DZMN9RhzR88znWXFV+bZY80OXgR3xazKMMj3D6AjYc=;
 b=f8W3B7jG7HQSeoMTSJRZhfhyvWgp2zRxkOv6Zwf+EgpDUKmXxmcjACtScipT6/T6tfy5
 YfnMDqzKV4DKUK6Ce9l5zQJ/8Q9zQ9+d9kEVBEHV+ihnBieBY6kwCKFr7waJsQ8TBHds
 qvhUfd3UvPd03SLIrWTrlaKsgMGjXZgMgxD6m0Gt6iAbRoRTnkcIHEvYGlLAmq02v9LF
 1M3WsSOA99nTY7EFC8SvZ3jzObK1ESvbYMv9aY4R/imxj6ifLDfsSgxecxeVw+SbyfK6
 f8rxAJGTMeYDXmK1JgLxsR5yfN9Ol/4ufuogloOYrqiBr+d7PrAuyT/R8wFvjBfwQrNi wg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uqp8p6cqd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 04:21:18 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 04:21:17 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 04:21:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmfuTgbqdSZKh+S6CfutLL0RuvfzrSPpX1Z2KAyZTZy7mBk4Orbz49DRvRoYSeB57GAuaEZvERanyB5XLbfjAJg0WQv171PjEWGu+fX0jXNeKnNy4vOy9VKsrdvsSyVnhsXWJCnTQdnTQsrFba5SDTtx34n7k361nlJZAe6Gz2RwTm+pp++Nd+EKEq6Tlmd7IJgDTdSZtDp/DD2eoZRSDjsLCFPm4nJQ9iYdkj6jb+rYeWHIzFxb+ZmM1C2ZuIUpvp+tDDYAE2QhjJI0M39N5WuEUj9CRYL3cRkemdAijs8b6e11JmLfmIx9ErItUVo77nT74xT8T6yRHc+NaFUZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DZMN9RhzR88znWXFV+bZY80OXgR3xazKMMj3D6AjYc=;
 b=GJh1g2dAkwvca4/fLVPxAcoX6BOadh/lGeM0Uap95fjVtT60x6TxjBTnlTYkSNXPGgLP4eDQ+ONbTB7tUZOYLWV2lWAOokLk+PbzkH8c5ylCCFVWJe/Z4x82ILSEXODNVhWCuJox+H6MkqIW54EQu2ieTTHrwK04drUpib+pfto/2pS/F9g+WznOwgKoAcJyMvwegPsR28eqv9/ZXAW1GYsPCjzdRrs/n8AQB1Tjdke/1y9zsEEMF4ShIic2ktHOWfjMFCZ5HnH6PZD8LW23RSovuFHqJ8Hc/1sK/OjVnaFoL+LofL3RhUEuKQLX0CqeOihrLgH4LTTnBsqsqeAdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DZMN9RhzR88znWXFV+bZY80OXgR3xazKMMj3D6AjYc=;
 b=ZHqh3irDt+E/HZ2CfkihBUSPlylaxwX1sqjhBEei5/ctOVio3ZFufSSHDzg1hwFN/VnG8nS1VVSfd3ANboCeyS+LfM7B8vd9Q5kLvmbS2JgLOvDk14CT61cuIu6ahZO4fdkT20Tr64X6AR0IVqMN2n696FAtgY465FEOL0lEUkE=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2847.namprd18.prod.outlook.com (20.179.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Mon, 2 Sep 2019 11:21:14 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 11:21:14 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: RE: RE: [EXT] Re: [PATCH v8 rdma-next 4/7] RDMA/siw: Use the
 common mmap_xa helpers
Thread-Topic: RE: RE: [EXT] Re: [PATCH v8 rdma-next 4/7] RDMA/siw: Use the
 common mmap_xa helpers
Thread-Index: AQHVXNvBsBWJLPJoZk2QlZBxyqYUlacTnV+AgAAHP4CAAAzGAIAEXNwAgAAxwwCAAAUyQA==
Date:   Mon, 2 Sep 2019 11:21:14 +0000
Message-ID: <MN2PR18MB31822C46B6F5CB7FAB03DC15A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <MN2PR18MB31820E898CC0C39E7A347B62A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>,<MN2PR18MB318291264841FC40885F4B42A1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>,<20190827132846.9142-5-michal.kalderon@marvell.com>,<20190827132846.9142-1-michal.kalderon@marvell.com>
 <OFED447099.CC1C35E8-ON00258466.003FD3A8-00258466.0042A33D@notes.na.collabserv.com>
 <OFDCD94E77.5EF5EBC2-ON00258466.0048FF97-00258466.00493280@notes.na.collabserv.com>
 <OFEAE262CD.F8E217E7-ON00258469.0031FA1F-00258469.003BF7C9@notes.na.collabserv.com>
In-Reply-To: <OFEAE262CD.F8E217E7-ON00258469.0031FA1F-00258469.003BF7C9@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e8823c4-3b14-4f0a-c2e0-08d72f97aab3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2847;
x-ms-traffictypediagnostic: MN2PR18MB2847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB28472461335AD3A769D75F9EA1BE0@MN2PR18MB2847.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(366004)(39850400004)(199004)(189003)(52536014)(3846002)(186003)(26005)(5660300002)(66066001)(66946007)(64756008)(66556008)(7736002)(66446008)(76116006)(33656002)(256004)(6116002)(66476007)(305945005)(74316002)(6916009)(76176011)(99286004)(7696005)(8936002)(6506007)(2906002)(316002)(102836004)(54906003)(478600001)(55016002)(71200400001)(71190400001)(476003)(81156014)(81166006)(486006)(446003)(11346002)(229853002)(6436002)(6246003)(86362001)(9686003)(25786009)(14454004)(8676002)(53936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2847;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hGCEi6E7Nbg4dn+jVJAMzJS87vVEDfzdUNh79aOEhjy9wjFrjqV5sadYHTEQ7YP6QJ0hECbhL9huGy20BEDGbj3PHGuTrrdBrf8vZHR534iv481nMDf7PT1qKdmI4d19b4QH/BbtlJ2Hd3BcsZl0KONVuT1wRqagVHZznF5l7OQh/n3QUsDyjuqwWK5+9B1N7vv3qqvL1/Vsdj6s8M3uKIFiZxYehQaRb1G7vb/LLoB5iJqDwZbn8yRu743Abp+n7QBIV9dr9mZHKZo/S/xXFcgvQ22fy6lGAkZLT+Hnhd5H+vnzVIgDPlQIM8ZCwTDYA5BD0v0vRtU4esabOiYzV8XCKf1EQu8GXbo1IIcREwTlbqqTqXNgDqYLFQ5UkRZgtWi8y0FH+8valx451sqggSNhNWG+JFS2rlVpM6aXnGk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8823c4-3b14-4f0a-c2e0-08d72f97aab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 11:21:14.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQmUEG0TAREbtoP/YIHcidALeGRDQZiAhXYWO7a9+WzMvnpo06Fc/LhwM4eKNSWUkHXHnrFt/J8m4El13yAhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2847
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_04:2019-08-29,2019-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBTZXB0ZW1iZXIgMiwgMjAxOSAxOjU1IFBNDQo+IA0KPiAtLS0tLSJNaWNoYWwgS2FsZGVy
b24iIDxta2FsZGVyb25AbWFydmVsbC5jb20+IHdyb3RlOiAtLS0tLQ0KPiANCj4gPlRvOiAiQmVy
bmFyZCBNZXR6bGVyIiA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiA+RnJvbTogIk1pY2hhbCBLYWxk
ZXJvbiIgPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4NCj4gPkRhdGU6IDA5LzAyLzIwMTkgMTA6MDFB
TQ0KPiA+Q2M6ICJBcmllbCBFbGlvciIgPGFlbGlvckBtYXJ2ZWxsLmNvbT4sICJqZ2dAemllcGUu
Y2EiDQo+ID48amdnQHppZXBlLmNhPiwgImRsZWRmb3JkQHJlZGhhdC5jb20iIDxkbGVkZm9yZEBy
ZWRoYXQuY29tPiwNCj4gPiJnYWxwcmVzc0BhbWF6b24uY29tIiA8Z2FscHJlc3NAYW1hem9uLmNv
bT4sDQo+ICJzbGV5Ym9AYW1hem9uLmNvbSINCj4gPjxzbGV5Ym9AYW1hem9uLmNvbT4sICJsZW9u
QGtlcm5lbC5vcmciIDxsZW9uQGtlcm5lbC5vcmc+LA0KPiA+ImxpbnV4LXJkbWFAdmdlci5rZXJu
ZWwub3JnIiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+DQo+ID5TdWJqZWN0OiBbRVhURVJO
QUxdIFJFOiBSRTogW0VYVF0gUmU6IFtQQVRDSCB2OCByZG1hLW5leHQgNC83XQ0KPiA+UkRNQS9z
aXc6IFVzZSB0aGUgY29tbW9uIG1tYXBfeGEgaGVscGVycw0KPiA+DQo+ID4+IEZyb206IGxpbnV4
LXJkbWEtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1yZG1hLQ0KPiA+PiBvd25lckB2Z2Vy
Lmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBCZXJuYXJkIE1ldHpsZXINCj4gPj4NCj4gPj4gLS0t
LS0iTWljaGFsIEthbGRlcm9uIiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPiB3cm90ZTogLS0tLS0N
Cj4gPj4NCj4gPj4gPlRvOiAiQmVybmFyZCBNZXR6bGVyIiA8Qk1UQHp1cmljaC5pYm0uY29tPg0K
PiA+PiA+RnJvbTogIk1pY2hhbCBLYWxkZXJvbiIgPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4NCj4g
Pj4gPkRhdGU6IDA4LzMwLzIwMTkgMDI6NDJQTQ0KPiA+PiA+Q2M6ICJBcmllbCBFbGlvciIgPGFl
bGlvckBtYXJ2ZWxsLmNvbT4sICJqZ2dAemllcGUuY2EiDQo+ID4+ID48amdnQHppZXBlLmNhPiwg
ImRsZWRmb3JkQHJlZGhhdC5jb20iIDxkbGVkZm9yZEByZWRoYXQuY29tPiwNCj4gPj4gPiJnYWxw
cmVzc0BhbWF6b24uY29tIiA8Z2FscHJlc3NAYW1hem9uLmNvbT4sDQo+ID4+ICJzbGV5Ym9AYW1h
em9uLmNvbSINCj4gPj4gPjxzbGV5Ym9AYW1hem9uLmNvbT4sICJsZW9uQGtlcm5lbC5vcmciIDxs
ZW9uQGtlcm5lbC5vcmc+LA0KPiA+PiA+ImxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnIiA8bGlu
dXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+LCAiQXJpZWwNCj4gPj4gPkVsaW9yIiA8YWVsaW9yQG1h
cnZlbGwuY29tPg0KPiA+PiA+U3ViamVjdDogW0VYVEVSTkFMXSBSRTogW0VYVF0gUmU6IFtQQVRD
SCB2OCByZG1hLW5leHQgNC83XQ0KPiA+UkRNQS9zaXc6DQo+ID4+ID5Vc2UgdGhlIGNvbW1vbiBt
bWFwX3hhIGhlbHBlcnMNCj4gPj4gPg0KPiA+PiA+PiBGcm9tOiBCZXJuYXJkIE1ldHpsZXIgPEJN
VEB6dXJpY2guaWJtLmNvbT4NCj4gPj4gPj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMzAsIDIwMTkg
MzowOCBQTQ0KPiA+PiA+Pg0KPiA+PiA+PiBFeHRlcm5hbCBFbWFpbA0KPiA+PiA+Pg0KPiA+PiA+
Pg0KPiA+Pg0KPiA+Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4tDQo+ID4+ID4tDQo+ID4+ID4+IC0tLS0tIk1p
Y2hhbCBLYWxkZXJvbiIgPG1pY2hhbC5rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4gd3JvdGU6DQo+ID4t
LS0tLQ0KPiA+PiA+Pg0KPiA+PiA+PiBIaSBNaWNoYWVsLA0KPiA+PiA+Pg0KPiA+PiA+PiBJIHRy
aWVkIHRoaXMgcGF0Y2guIEl0IHVuZm9ydHVuYXRlbHkgcGFuaWNzIGltbWVkaWF0ZWx5IHdoZW4g
c2l3DQo+ID4+ID5nZXRzIHVzZWQuIEknbGwNCj4gPj4gPj4gaW52ZXN0aWdhdGUgZnVydGhlci4g
U29tZSBjb21tZW50cyBpbiBsaW5lLg0KPiA+PiA+VGhhbmtzIGZvciB0ZXN0aW5nLA0KPiA+PiA+
DQo+ID4+ID4+DQo+ID4+ID4+IFRoYW5rcw0KPiA+PiA+PiBCZXJuYXJkLg0KPiA+PiA+Pg0KPiA+
PiA+PiA+VG86IDxta2FsZGVyb25AbWFydmVsbC5jb20+LCA8YWVsaW9yQG1hcnZlbGwuY29tPiwN
Cj4gPj4gPGpnZ0B6aWVwZS5jYT4sDQo+ID4+ID4+ID48ZGxlZGZvcmRAcmVkaGF0LmNvbT4sIDxi
bXRAenVyaWNoLmlibS5jb20+LA0KPiA+PiA+PiA8Z2FscHJlc3NAYW1hem9uLmNvbT4sDQo+ID4+
ID4+ID48c2xleWJvQGFtYXpvbi5jb20+LCA8bGVvbkBrZXJuZWwub3JnPg0KPiA+PiA+PiA+RnJv
bTogIk1pY2hhbCBLYWxkZXJvbiIgPG1pY2hhbC5rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4NCj4gPj4g
Pj4gPkRhdGU6IDA4LzI3LzIwMTkgMDM6MzFQTQ0KPiA+PiA+PiA+Q2M6IDxsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZz4sICJNaWNoYWwgS2FsZGVyb24iDQo+ID4+ID4+ID48bWljaGFsLmthbGRl
cm9uQG1hcnZlbGwuY29tPiwgIkFyaWVsIEVsaW9yIg0KPiA+PiA+PiA+PGFyaWVsLmVsaW9yQG1h
cnZlbGwuY29tPg0KPiA+PiA+PiA+U3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0ggdjggcmRtYS1u
ZXh0IDQvN10gUkRNQS9zaXc6IFVzZSB0aGUNCj4gPj4gPj4gY29tbW9uDQo+ID4+ID4+ID5tbWFw
X3hhIGhlbHBlcnMNCj4gPj4gPj4gPg0KPiA+PiA+PiA+UmVtb3ZlIHRoZSBmdW5jdGlvbnMgcmVs
YXRlZCB0byBtYW5hZ2luZyB0aGUgbW1hcF94YSBkYXRhYmFzZS4NCj4gPj4gPj4gPlRoaXMgY29k
ZSBpcyBub3cgY29tbW9uIGluIGliX2NvcmUuIFVzZSB0aGUgY29tbW9uIEFQSSdzDQo+ID5pbnN0
ZWFkLg0KPiA+PiA+PiA+DQo+ID4+ID4+ID5TaWduZWQtb2ZmLWJ5OiBBcmllbCBFbGlvciA8YXJp
ZWwuZWxpb3JAbWFydmVsbC5jb20+DQo+ID4+ID4+ID5TaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2Fs
ZGVyb24gPG1pY2hhbC5rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4NCj4gPj4gPj4gPi0tLQ0KPiA+PiA+
PiA+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmggICAgICAgfCAgMjAgKystDQo+ID4+
ID4+ID4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jICB8ICAgMSArDQo+ID4+
ID4+ID4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYyB8IDIyMw0KPiA+PiA+
PiA+KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiA+PiA+PiA+IGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmggfCAgIDEgKw0KPiA+PiA+PiA+IDQgZmlsZXMg
Y2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKyksIDEwMSBkZWxldGlvbnMoLSkNCj4gPj4gPj4gPg0K
PiA+PiA+PiA+KwkJCS8qIElmIGVudHJ5IHdhcyBpbnNlcnRlZCBzdWNjZXNzZnVsbHksIHFwLQ0K
PiA+c2VuZHENCj4gPj4gPj4gPisJCQkgKiB3aWxsIGJlIGZyZWVkIGJ5IHNpd19tbWFwX2ZyZWUN
Cj4gPj4gPj4gPisJCQkgKi8NCj4gPj4gPj4gPisJCQlxcC0+c2VuZHEgPSBOVUxMOw0KPiA+PiA+
Pg0KPiA+PiA+PiBxcC0+c2VuZHEgcG9pbnRzIHRvIHRoZSBTUSBhcnJheS4gWmVyb2luZyB0aGlz
IHBvaW50ZXIgd2lsbA0KPiA+bGVhdmUNCj4gPj4gPj4gc2l3IHdpdGggbm8gaWRlYSB3aGVyZSB0
aGUgV1FFJ3MgYXJlLiBJdCB3aWxsIHBhbmljDQo+ID5kZS1yZWZlcmVuY2luZw0KPiA+PiA+W05V
TEwgKw0KPiA+PiA+PiBjdXJyZW50IHBvc2l0aW9uIGluIHJpbmcgYnVmZmVyXS4gU2FtZSBmb3Ig
UlEsIFNSUSBhbmQgQ1EuDQo+ID4+ID5RcC0+c2VuZHEgaXMgb25seSB1c2VkIGluIGtlcm5lbCBt
b2RlLCBhbmQgb25seSBzZXQgdG8gTlVMTCBpcw0KPiA+PiA+dXNlci1zcGFjZSBtb2RlDQo+ID4+
ID5XaGVyZSBpdCBpcyBhbGxvY2F0ZWQgYW5kIG1hcHBlZCBpbiB1c2VyLCBzbyB0aGUgdXNlciB3
aWxsIGJlIHRoZQ0KPiA+b25lDQo+ID4+ID5hY2Nlc3NpbmcgdGhlIHJpbmdzIEFuZCBub3Qga2Vy
bmVsLCB1bmxlc3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiA+Pg0KPiA+PiBUaGVzZSBwb2lu
dGVycyBhcmUgcG9pbnRpbmcgdG8gdGhlIGFsbG9jYXRlZCB3b3JrIHF1ZXVlcy4NCj4gPj4gVGhl
c2UgcXVldWVzL2FycmF5cyBhcmUgaG9sZGluZyB0aGUgYWN0dWFsIHNlbmQvcmVjdi9jb21wbGV0
ZS9zcnENCj4gPndvcmsNCj4gPj4gcXVldWUgZWxlbWVudHMuIEl0IGlzIGEgc2hhcmVkIGFycmF5
LiBUaGF0IGlzIHdoeSB3ZSBuZWVkIG1tYXAgYXQNCj4gPmFsbC4NCj4gPj4NCj4gPj4gZS5nLiwN
Cj4gPj4NCj4gPj4gc3RydWN0IHNpd19zcWUgKnNxZSA9ICZxcC0+c2VuZHFbcXAtPnNxX2dldCAl
IHFwLT5hdHRycy5zcV9zaXplXTsNCj4gPj4NCj4gPj4NCj4gPk9rIGdvdCBpdCwgSSdtIEhXIG9y
aWVudGVkLi4uIHNvIHVzZXIgY2hhaW5zIGFuZCBrZXJuZWwgYXJlIHRvdGFsbHkNCj4gPnNlcGFy
YXRlZC4NCj4gPldpbGwgYWRkIGEgZmxhZyB3aGV0aGVyIHRvIGZyZWUgb3Igbm90IGFuZCByZW1v
dmUgc2V0dGluZyB0byBOVUxMLg0KPiA+VGhhbmtzLA0KPiA+TWljaGFsDQo+ID4NCj4gTWljaGFl
bCwNCk1pY2hhbCAgKG5vdCBNaWNoYWVsKSB0aGFua3Mg8J+YiiANCg0KPiBJIGV2ZW4gdGhpbmsg
dGhlcmUgaXMgYW4gdW5kZXJseWluZyBkZXNpZ24gZGVjaXNpb24gSSBhbSBxdWVzdGlvbmluZy4g
VGhlDQo+IHByb3ZpZGVyIGFsbG9jYXRlcyB0aGUgcmVzb3VyY2UgdG8gYmUgbW1hcHBlZCwgYW5k
IHRoZXJlIGlzIG5vIHJlYXNvbiB0bw0KPiBoYXZlIHRoZSBtbWFwcGluZyBzZXJ2aWNlIGZyZWVp
bmcgdGhhdCByZXNvdXJjZSBhdCBhbnkgcG9pbnQgaW4gdGltZS4gSQ0KPiBzaW1wbHkgZG9uJ3Qg
dW5kZXJzdGFuZCB3aHkgdGhlIG1tYXAgc2VydmljZSB3YW50cyB0byBmcmVlIHRoZSBtbWFwcGVk
DQo+IHJlc291cmNlIGF0IGFsbCwgaWYgaXQgZGlkIG5vdCBhbGxvY2F0ZSBpdC4gVGhlIGFpbSBv
ZiB0aGUgc2VydmljZSBzaG91bGQgYmUgbGltaXRlZA0KPiB0byBwcm92aWRlIG1tYXBwaW5nIGJv
b2trZWVwaW5nLg0KPiANCj4gVGhlIG5ldyBtbWFwIGhlbHBlciBmcmFtZXdvcmsgYWxyZWFkeSBk
ZWZpbmVzIGEgY2FsbGJhY2sgZm9yIHVubWFwcGluZy4NCj4gVGhlIHByb3ZpZGVyIG1heSB1c2Ug
aXQgdG8gZnJlZSB0aGUgcmVzb3VyY2UsIGlmIGFwcHJvcHJpYXRlLiBFLmcuLCBzaXcgd2lsbCBu
b3QNCj4gZGVzdHJveSBhIGN1cnJlbnRseSB1c2VkIENRLCBvbmx5IGJlY2F1c2UgdGhlIHVzZXIg
bGFuZCBhcHBsaWNhdGlvbiBjYWxscw0KPiBtdW5tYXAgb24gaXQuDQoNClRoZSBmdW5jdGlvbiB0
aGF0IGZyZWVzIHRoZSBtZW1vcnkgaXMgdGhlIHNpd19tbWFwX2ZyZWUgaW4gdGhlIHByb3ZpZGVy
ICwgbm90IHRoZSANCk1hcHBpbmcgc2VydmljZS4gDQpUaGlzIGlzIGNhbGxlZCB3aGVuIHByb3Zp
ZGVyIGNhbGxzIG1tYXBfcmVtb3ZlIGFuZCBBTEwgbWFwcyB0byB0aGUgYWRkcmVzcyB3ZXJlIHVu
bWFwcGVkIG9yIA0KWmFwcGVkLCB3ZSBkb24ndCB3YW50IHRvIGZyZWUgdGhlIG1lbW9yeSBiZWZv
cmUgdGhlIG1hcHBpbmcgd2FzIHJlbW92ZWQuIA0KT25jZSB0aGUgcHJvdmlkZXIgY2FsbHMgbW1h
cF9lbnRyeV9pbnNlcnQgdGhlIHJlZmNudCBpcyBzZXQgdG8gJzEnIGFuZCBjYW4NCk9ubHkgcmVh
Y2ggemVybyBhZnRlciBwcm92aWRlciBjYWxscyBtbWFwX2VudHJ5X3JlbW92ZS4gDQoNClRoYW5r
cywNCk1pY2hhbA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEJlcm5hcmQuDQoNCg==
