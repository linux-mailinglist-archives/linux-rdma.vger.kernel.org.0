Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92EA508B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfIBIAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 04:00:15 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:31372 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbfIBIAP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 04:00:15 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82806rx025148;
        Mon, 2 Sep 2019 01:00:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=vaKr9UiqGDQwdhtrsQdmgFpPaQIABToScKshkgYmpUc=;
 b=PqYive20Yz2vukQ1iws4V6eFHwmVOL7kgm83hgSq1oLBi/YDyPxiDJxyfH6RF40DPwSj
 ImrMg192Gs5wZa8xkTirxiufjeYKKW6nk5qShUe0qxvP80yjSEW/gfz42m57SDZH+SgC
 CchpLaC1al8oYRHvtwCKqT6ZPtaqp59xwMT/lyL35Viv1Il1izRVFiR1+MlfG+D64dVz
 aNvfD3hzQi5mhd7szeOHJe7c5uJCIu1r/JMIRqpET4Or9PgcBh7PHN8/B6fibsThdjiS
 vy0GM2Kig4Vu6azPK84VuXRpq/CzKH5h5aq0wVLUxWplp2jLoudzEn/r1AkuUOBI4mPG Aw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm5b5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 01:00:06 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 01:00:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 01:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHfudN+QglfmS417d2nYzeNuFMP5E42RJXUvwYXf5vg7BzTBIi8fHzJPlP4EJI/l1Qqr06+xhhO+2zDeqVE5m54bRk6s5PHNWxMOrBhGyxOlWRTlgDOfmhQ8VL7CvzCdMkPwvE2gYTNp+vYXhg6o7FpXpl2tFDsJF7OjYiBjP3lz1GVHAUHfCEYWyuhB7QPtFnOGCpfLcxas0HYF07sTccTdKVNYi6uIaiNYE/G46+3G1+IohqvGv7UCru9Af73PqTxf4zZQRxKo1KD3tQ/nIvnQ0opJgS3i5vVV5qGIUlYXLoQ3aG/pfVqLjE0mMbzmUo+Zzz4e+4JQ41psiI6NQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaKr9UiqGDQwdhtrsQdmgFpPaQIABToScKshkgYmpUc=;
 b=hA1iWe/Bjeq4nQf794b0ZvZz5lXJwOLQqQ95EVg9v4RMMwcYwGLmCkJtTy5TDdQhKNljuBDato0atJElyofSQKxxaETaJwdeGX0eCf2V0WjJnDMLhEc4R9N0tKaIysFIjdUVAIJjL1he0+DA3+vd1GtVLxxOc2AGvOaOjBMMrHYJz2tvprRc4nv/Ib1tvP4m0lFBgl/n11YQQdF2l1501te59INZqoXkKwtiS2Ii82WAaJzKPAbJ2fmAOwq4SaaZmFsduvT+pyiAgPBdLszTiSRz9lVw8wvLPEvn3rzIPcNEZLygJF5rC2UbRwWSbT2GmRllLSgL48Vh4mqxZIZRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaKr9UiqGDQwdhtrsQdmgFpPaQIABToScKshkgYmpUc=;
 b=SLaYB9KL7VYVXrX9u5jnCnkuV5VUAXVnIqG+wPnGpeXUrKVtFLmRUNKwPfoiX+f4cQLqLNoPC1i+I7/2ZucWVSLHzzzaIMxLWgmcZtHk/JD6+/oVehzJ1MAyh6gXCh/Ax7tr46b4rXMTILC+svpBbxXGPIVeeB6WxHK0VnvFRlE=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3295.namprd18.prod.outlook.com (10.255.237.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 2 Sep 2019 08:00:02 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 08:00:02 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: RE: [EXT] Re: [PATCH v8 rdma-next 4/7] RDMA/siw: Use the common
 mmap_xa helpers
Thread-Topic: RE: [EXT] Re: [PATCH v8 rdma-next 4/7] RDMA/siw: Use the common
 mmap_xa helpers
Thread-Index: AQHVXNvBsBWJLPJoZk2QlZBxyqYUlacTnV+AgAAHP4CAAAzGAIAEXNwA
Date:   Mon, 2 Sep 2019 08:00:02 +0000
Message-ID: <MN2PR18MB31820E898CC0C39E7A347B62A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <MN2PR18MB318291264841FC40885F4B42A1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>,<20190827132846.9142-5-michal.kalderon@marvell.com>,<20190827132846.9142-1-michal.kalderon@marvell.com>
 <OFED447099.CC1C35E8-ON00258466.003FD3A8-00258466.0042A33D@notes.na.collabserv.com>
 <OFDCD94E77.5EF5EBC2-ON00258466.0048FF97-00258466.00493280@notes.na.collabserv.com>
In-Reply-To: <OFDCD94E77.5EF5EBC2-ON00258466.0048FF97-00258466.00493280@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27e9c5a1-9c38-4953-df3b-08d72f7b8f21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3295;
x-ms-traffictypediagnostic: MN2PR18MB3295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3295ACB047A23AFF2B27C2C7A1BE0@MN2PR18MB3295.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(189003)(199004)(4326008)(186003)(26005)(7696005)(478600001)(8936002)(7736002)(305945005)(71190400001)(71200400001)(55016002)(9686003)(14454004)(6436002)(81166006)(81156014)(256004)(8676002)(53936002)(316002)(102836004)(6246003)(33656002)(74316002)(76176011)(2906002)(54906003)(5660300002)(6506007)(86362001)(3846002)(6116002)(52536014)(476003)(99286004)(486006)(76116006)(66476007)(66946007)(66446008)(66066001)(11346002)(66556008)(64756008)(229853002)(446003)(6916009)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3295;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nUu/X8isDNPQedegc170GLR387uT5kNTkhmN47flr7TBV2RmhP7tPCVpZoJxxiCI9bv0MbTY/+VuqNHzwT8EegC0IIemmMPzZQNHlaDEknu5i87rLGXmKL/WUH0A8sreIz11maXpZNe9PQzddwNOS9XTA3atSs5pWuoEIXcElbbHU5S6Ux+r9uzhm6Dv0hxHx0LjBNgt8WGCB4I4m7unwuSmXrsrOwzg5/D/e+BmSQM73J5ycRpPn15kPePfkuS+mmUTDOE/YpmueQX371twcuuhoj6Yh4tU/8aQaeiWSSv20RYvZUVbC9UwpSQqH/iCKC0DblLRWtdcCKf8c1IFlGgSH7h1C2cpkLtQqIcGT7+dpVNDTvoWWxcNputsmkpCMzavrmtet3aITX69e8LaXJFrvW1RDUtkOUc8NYy6uC4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e9c5a1-9c38-4953-df3b-08d72f7b8f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 08:00:02.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNNqId/1KmnbFyGpLWUmerUUiqqeTgT4Z7m7ZpY7ezvl3ESQZpYe4c/WGHreoXoUmMdFNggu2iRijjWvL9bKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3295
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_02:2019-08-29,2019-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgQmVybmFyZCBNZXR6bGVyDQo+IA0K
PiAtLS0tLSJNaWNoYWwgS2FsZGVyb24iIDxta2FsZGVyb25AbWFydmVsbC5jb20+IHdyb3RlOiAt
LS0tLQ0KPiANCj4gPlRvOiAiQmVybmFyZCBNZXR6bGVyIiA8Qk1UQHp1cmljaC5pYm0uY29tPg0K
PiA+RnJvbTogIk1pY2hhbCBLYWxkZXJvbiIgPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4NCj4gPkRh
dGU6IDA4LzMwLzIwMTkgMDI6NDJQTQ0KPiA+Q2M6ICJBcmllbCBFbGlvciIgPGFlbGlvckBtYXJ2
ZWxsLmNvbT4sICJqZ2dAemllcGUuY2EiDQo+ID48amdnQHppZXBlLmNhPiwgImRsZWRmb3JkQHJl
ZGhhdC5jb20iIDxkbGVkZm9yZEByZWRoYXQuY29tPiwNCj4gPiJnYWxwcmVzc0BhbWF6b24uY29t
IiA8Z2FscHJlc3NAYW1hem9uLmNvbT4sDQo+ICJzbGV5Ym9AYW1hem9uLmNvbSINCj4gPjxzbGV5
Ym9AYW1hem9uLmNvbT4sICJsZW9uQGtlcm5lbC5vcmciIDxsZW9uQGtlcm5lbC5vcmc+LA0KPiA+
ImxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnIiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+
LCAiQXJpZWwNCj4gPkVsaW9yIiA8YWVsaW9yQG1hcnZlbGwuY29tPg0KPiA+U3ViamVjdDogW0VY
VEVSTkFMXSBSRTogW0VYVF0gUmU6IFtQQVRDSCB2OCByZG1hLW5leHQgNC83XSBSRE1BL3NpdzoN
Cj4gPlVzZSB0aGUgY29tbW9uIG1tYXBfeGEgaGVscGVycw0KPiA+DQo+ID4+IEZyb206IEJlcm5h
cmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIEF1Z3Vz
dCAzMCwgMjAxOSAzOjA4IFBNDQo+ID4+DQo+ID4+IEV4dGVybmFsIEVtYWlsDQo+ID4+DQo+ID4+
DQo+ID4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPi0NCj4gPj4gLS0tLS0iTWljaGFsIEthbGRlcm9uIiA8bWlj
aGFsLmthbGRlcm9uQG1hcnZlbGwuY29tPiB3cm90ZTogLS0tLS0NCj4gPj4NCj4gPj4gSGkgTWlj
aGFlbCwNCj4gPj4NCj4gPj4gSSB0cmllZCB0aGlzIHBhdGNoLiBJdCB1bmZvcnR1bmF0ZWx5IHBh
bmljcyBpbW1lZGlhdGVseSB3aGVuIHNpdw0KPiA+Z2V0cyB1c2VkLiBJJ2xsDQo+ID4+IGludmVz
dGlnYXRlIGZ1cnRoZXIuIFNvbWUgY29tbWVudHMgaW4gbGluZS4NCj4gPlRoYW5rcyBmb3IgdGVz
dGluZywNCj4gPg0KPiA+Pg0KPiA+PiBUaGFua3MNCj4gPj4gQmVybmFyZC4NCj4gPj4NCj4gPj4g
PlRvOiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPiwgPGFlbGlvckBtYXJ2ZWxsLmNvbT4sDQo+IDxq
Z2dAemllcGUuY2E+LA0KPiA+PiA+PGRsZWRmb3JkQHJlZGhhdC5jb20+LCA8Ym10QHp1cmljaC5p
Ym0uY29tPiwNCj4gPj4gPGdhbHByZXNzQGFtYXpvbi5jb20+LA0KPiA+PiA+PHNsZXlib0BhbWF6
b24uY29tPiwgPGxlb25Aa2VybmVsLm9yZz4NCj4gPj4gPkZyb206ICJNaWNoYWwgS2FsZGVyb24i
IDxtaWNoYWwua2FsZGVyb25AbWFydmVsbC5jb20+DQo+ID4+ID5EYXRlOiAwOC8yNy8yMDE5IDAz
OjMxUE0NCj4gPj4gPkNjOiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+LCAiTWljaGFsIEth
bGRlcm9uIg0KPiA+PiA+PG1pY2hhbC5rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4sICJBcmllbCBFbGlv
ciINCj4gPj4gPjxhcmllbC5lbGlvckBtYXJ2ZWxsLmNvbT4NCj4gPj4gPlN1YmplY3Q6IFtFWFRF
Uk5BTF0gW1BBVENIIHY4IHJkbWEtbmV4dCA0LzddIFJETUEvc2l3OiBVc2UgdGhlDQo+ID4+IGNv
bW1vbg0KPiA+PiA+bW1hcF94YSBoZWxwZXJzDQo+ID4+ID4NCj4gPj4gPlJlbW92ZSB0aGUgZnVu
Y3Rpb25zIHJlbGF0ZWQgdG8gbWFuYWdpbmcgdGhlIG1tYXBfeGEgZGF0YWJhc2UuDQo+ID4+ID5U
aGlzIGNvZGUgaXMgbm93IGNvbW1vbiBpbiBpYl9jb3JlLiBVc2UgdGhlIGNvbW1vbiBBUEkncyBp
bnN0ZWFkLg0KPiA+PiA+DQo+ID4+ID5TaWduZWQtb2ZmLWJ5OiBBcmllbCBFbGlvciA8YXJpZWwu
ZWxpb3JAbWFydmVsbC5jb20+DQo+ID4+ID5TaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24g
PG1pY2hhbC5rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4NCj4gPj4gPi0tLQ0KPiA+PiA+IGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3LmggICAgICAgfCAgMjAgKystDQo+ID4+ID4gZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jICB8ICAgMSArDQo+ID4+ID4gZHJpdmVycy9pbmZp
bmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYyB8IDIyMw0KPiA+PiA+KysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLQ0KPiA+PiA+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3Zl
cmJzLmggfCAgIDEgKw0KPiA+PiA+IDQgZmlsZXMgY2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKyks
IDEwMSBkZWxldGlvbnMoLSkNCj4gPj4gPg0KPiA+PiA+KwkJCS8qIElmIGVudHJ5IHdhcyBpbnNl
cnRlZCBzdWNjZXNzZnVsbHksIHFwLT5zZW5kcQ0KPiA+PiA+KwkJCSAqIHdpbGwgYmUgZnJlZWQg
Ynkgc2l3X21tYXBfZnJlZQ0KPiA+PiA+KwkJCSAqLw0KPiA+PiA+KwkJCXFwLT5zZW5kcSA9IE5V
TEw7DQo+ID4+DQo+ID4+IHFwLT5zZW5kcSBwb2ludHMgdG8gdGhlIFNRIGFycmF5LiBaZXJvaW5n
IHRoaXMgcG9pbnRlciB3aWxsIGxlYXZlDQo+ID4+IHNpdyB3aXRoIG5vIGlkZWEgd2hlcmUgdGhl
IFdRRSdzIGFyZS4gSXQgd2lsbCBwYW5pYyBkZS1yZWZlcmVuY2luZw0KPiA+W05VTEwgKw0KPiA+
PiBjdXJyZW50IHBvc2l0aW9uIGluIHJpbmcgYnVmZmVyXS4gU2FtZSBmb3IgUlEsIFNSUSBhbmQg
Q1EuDQo+ID5RcC0+c2VuZHEgaXMgb25seSB1c2VkIGluIGtlcm5lbCBtb2RlLCBhbmQgb25seSBz
ZXQgdG8gTlVMTCBpcw0KPiA+dXNlci1zcGFjZSBtb2RlDQo+ID5XaGVyZSBpdCBpcyBhbGxvY2F0
ZWQgYW5kIG1hcHBlZCBpbiB1c2VyLCBzbyB0aGUgdXNlciB3aWxsIGJlIHRoZSBvbmUNCj4gPmFj
Y2Vzc2luZyB0aGUgcmluZ3MgQW5kIG5vdCBrZXJuZWwsIHVubGVzcyBJJ20gbWlzc2luZyBzb21l
dGhpbmcuDQo+IA0KPiBUaGVzZSBwb2ludGVycyBhcmUgcG9pbnRpbmcgdG8gdGhlIGFsbG9jYXRl
ZCB3b3JrIHF1ZXVlcy4NCj4gVGhlc2UgcXVldWVzL2FycmF5cyBhcmUgaG9sZGluZyB0aGUgYWN0
dWFsIHNlbmQvcmVjdi9jb21wbGV0ZS9zcnEgd29yaw0KPiBxdWV1ZSBlbGVtZW50cy4gSXQgaXMg
YSBzaGFyZWQgYXJyYXkuIFRoYXQgaXMgd2h5IHdlIG5lZWQgbW1hcCBhdCBhbGwuDQo+IA0KPiBl
LmcuLA0KPiANCj4gc3RydWN0IHNpd19zcWUgKnNxZSA9ICZxcC0+c2VuZHFbcXAtPnNxX2dldCAl
IHFwLT5hdHRycy5zcV9zaXplXTsNCj4gDQo+IA0KT2sgZ290IGl0LCBJJ20gSFcgb3JpZW50ZWQu
Li4gc28gdXNlciBjaGFpbnMgYW5kIGtlcm5lbCBhcmUgdG90YWxseSBzZXBhcmF0ZWQuIA0KV2ls
bCBhZGQgYSBmbGFnIHdoZXRoZXIgdG8gZnJlZSBvciBub3QgYW5kIHJlbW92ZSBzZXR0aW5nIHRv
IE5VTEwuIA0KVGhhbmtzLA0KTWljaGFsDQoNCg0K
