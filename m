Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB27EBC4E1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395175AbfIXJb6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 05:31:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61938 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395147AbfIXJb6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 05:31:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8O9TpJr023421;
        Tue, 24 Sep 2019 02:31:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=eS2vFloYbMA7wwBvfZ1fzd9yCBgQ2lsGkTlqEzzbe5o=;
 b=e68MwbpKZ+AxxygJL6dZUK+n09R4Om10hH1uCkZV3GsGR91eDdMxfuZsD1pvGVRZCdNR
 l+SQsWxPcvNWi+JkFSc3jKe65tjRrn7UbICSL4pZwwBmacX43AX/LyOd/n5F1xkf4nZA
 Y/jXuaDDzn2DBadQjQ6kFOs02njmruDTSDlrymfC9saxnkq9dQbyf2C/p/n0+AaTJJ3N
 MOd+Mw+O1NCJw1KHkYRL/Bq9p0NeLQGWkWvmTjpNWAABuhxuFZiWHKYTyD/0iLzcZed+
 Rotszq/YNCYpw8kNdZcorxuHU41xCZ8JBnYT4dVON5juAPJhDkxLya3ggtYIeHdSwvuj bw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v5kcks64k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 02:31:51 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 24 Sep
 2019 02:31:48 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 24 Sep 2019 02:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNe8eBBhCOvNbBWLvL3qIL76CeawQlsNVAesLMIhp81dNiR0n1/ATbNnhpC8D0ywB+28FyFavF6/gCeXHdfCPdz5MkAS+cadrNiY9I4tH7GDmF3AYRAc1keCemzpDG/SWVqjXY+TBqDOu0bGlvwmtZQg/sbSQde5UX3RMnB1WRRkP7JkKKcAykiO+2AxWqdaKmLYuUNN71rCaoaLsd4Voi0IIjy7stbJpLzJQVlzvscb/PGkGFQUAjMLalkuFMKZrNYYPK6Au8XpKdKBp77ztPNwg9KpfA1kYaKWmxK1Bos084CPg70nklfGhWEW0vSHb1SYVXlFBnLrvGpoLgUGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS2vFloYbMA7wwBvfZ1fzd9yCBgQ2lsGkTlqEzzbe5o=;
 b=i0wRXEA1EWP2BOpB0jhnb6FYEnapOm5UlKqyhMGjIzIiDXkJlsG4sFlrqQi4ikeYxR6brxtFCJfUV38jbfq5zWnBDWO8ORKmxbN/1AAla0c5MEsYLLT2Oc3sWeP7oAOyTXypOki9i3BgslmVz0LXsE67yOUX6aNKi1rWSnylL4fN5WSguom0FC0kufcdvLxgq2I/ryq2UFMWFcuEY4geBEISLJFHrcTH6+ANq/IMrG7ZbA74cX/sCjuBKfzdipzRV8NqqN2g404FM1q4p4KD6oEARsuWR+6i8JfJg/7VOtamd9W8Bx5KB6TC53QkMg/GXk/N1vG2omVqUc5TRH1XZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS2vFloYbMA7wwBvfZ1fzd9yCBgQ2lsGkTlqEzzbe5o=;
 b=qraovMU/QfG1WYWI8OOjZDSjy2AFJ+I0uEwVBdBPkd3QQc/wv2DS1R9X2OZ/q5gmia7muhspSpeOHUtcIYrO8x4a5ICDAZ2M/rFvxMFDz1XmnuOzKDS/0QRENAuWtx8ffMCd/e+Gxnb82mrweivV5hli8Z4PZX394YT0WRX8ZJg=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2864.namprd18.prod.outlook.com (20.179.20.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 09:31:47 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 09:31:47 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     "Pressman, Gal" <galpress@amazon.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Thread-Topic: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Thread-Index: AQHVb7ju3H5srlnZKEWQePz8q/pg2ac4//HggAGKtICAAAkV0A==
Date:   Tue, 24 Sep 2019 09:31:47 +0000
Message-ID: <MN2PR18MB3182999F3ACFC93455B887C8A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
In-Reply-To: <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb7a0aa9-d221-4e56-4f43-08d740d2055f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2864;
x-ms-traffictypediagnostic: MN2PR18MB2864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB28648E1DAE46FDA2CB47E233A1840@MN2PR18MB2864.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(486006)(478600001)(76116006)(256004)(3846002)(5660300002)(71200400001)(71190400001)(2906002)(54906003)(14454004)(86362001)(66066001)(81156014)(52536014)(6916009)(6116002)(8676002)(8936002)(305945005)(33656002)(316002)(7696005)(99286004)(81166006)(6506007)(53546011)(4326008)(186003)(7736002)(6246003)(9686003)(102836004)(476003)(26005)(64756008)(76176011)(55016002)(66476007)(66446008)(66556008)(66946007)(229853002)(25786009)(74316002)(6436002)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2864;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +B2F1SF+kJMCQBwBNLeLjZ38q8r9Et4vcHgBF+i9hd5AV6kEOVXPIcKpfNxw0lHojYat3VwK0uWsNomP7eIk0VOpvlhV/eRDZtbxvFQSPgXsL6ExwqCV4g/lSOGmcQcR/F+GqOcnugsIjjpsBZBcqKMyN9OkPNIx8GJFzhKdOBSp2x3p73mIUOsGElFr3hK8RIBxT+8ULq8U/DslJpe3zbWnZkrcQT29zOciH2ZvvrggFDIQGs7gEoCT+RTzjP8L0lh4UiJ+DTkSN4/4gP2r85F/MNZacX/djLdvFLGNoINwtEDC3Gx8McudzGIMwx481jiO0yGPygN+bll3uTFCOzZzBt5yFIAEzFnpJ6DT3UP+MbRo9wBLtsOMel6qffUFZD2azLcoBXKAN/sMOry2B7eNZEMkIWmmUWWkvDCPNf0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7a0aa9-d221-4e56-4f43-08d740d2055f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 09:31:47.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkqhM94jSu1GPQTg7aIh9BT9VV6Dmq2xV1RYya1gLiQ7FSPH+Mq8LVOVPkcCrNZ4kZwkv4ZoRT3+HkExXm3ySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2864
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_04:2019-09-23,2019-09-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBQcmVzc21hbiwgR2FsIDxnYWxwcmVzc0BhbWF6b24uY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMTkgMTE6NTAgQU0NCj4gDQo+IA0KPiA+IE9uIDIzIFNlcCAy
MDE5LCBhdCAxODoyMiwgTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gDQo+ID4+DQo+ID4+IEZyb206IGxpbnV4LXJkbWEtb3duZXJAdmdl
ci5rZXJuZWwub3JnIDxsaW51eC1yZG1hLQ0KPiA+PiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9u
IEJlaGFsZiBPZiBHYWwgUHJlc3NtYW4NCj4gPj4NCj4gPj4+IE9uIDE5LzA5LzIwMTkgMjA6NTUs
IEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+IEh1aC4gSWYgeW91IHJlY2FsbCB3ZSBkaWQg
YWxsIHRoaXMgd29yayB3aXRoIHRoZSBYQSBhbmQgdGhlIGZyZWUNCj4gPj4+IGNhbGxiYWNrIGJl
Y2F1c2UgeW91IHNhaWQgcWVkciB3YXMgbW1hcGluZyBCQVIgcGFnZXMgdGhhdCBoYWQgc29tZQ0K
PiA+Pj4gSFcgbGlmZXRpbWUgYXNzb2NpYXRlZCB3aXRoIHRoZW0sIGFuZCB0aGUgSFcgcmVzb3Vy
Y2Ugd2FzIG5vdCB0byBiZQ0KPiA+Pj4gcmVhbGxvY2F0ZWQgdW50aWwgYWxsIHVzZXJzIHdlcmUg
Z29uZS4NCj4gPj4+DQo+ID4+PiBJIHRoaW5rIGl0IHdvdWxkIGJlIGEgYmV0dGVyIGV4YW1wbGUg
b2YgdGhpcyBBUEkgaWYgeW91IHB1bGxlZCB0aGUNCj4gPj4+DQo+ID4+PiAgICBkZXYtPm9wcy0+
cmRtYV9yZW1vdmVfdXNlcihkZXYtPnJkbWFfY3R4LCBjdHgtPmRwaSk7DQo+ID4+Pg0KPiA+Pj4g
SW50byBxZWRyX21tYXBfZnJlZSgpLg0KPiA+Pj4NCj4gPj4+IFRoZW4gdGhlIHJkbWFfdXNlcl9t
bWFwX2VudHJ5X3JlbW92ZSgpIHdpbGwgY2FsbCBpdCBuYXR1cmFsbHkgYXMgaXQNCj4gPj4+IGRv
ZXMgZW50cnlfcHV0KCkgYW5kIGlmIHdlIGFyZSBkZXN0cm95aW5nIHRoZSB1Y29udGV4dCB3ZSBh
bHJlYWR5DQo+ID4+PiBrbm93IHRoZSBtbWFwcyBhcmUgZGVzdHJveWVkLg0KPiA+Pj4NCj4gPj4+
IE1heWJlIHRoZSBzYW1lIGJhc2ljIGNvbW1lbnQgZm9yIEVGQSwgbm90IHN1cmUuIEdhbD8NCj4g
Pj4NCj4gPj4gVGhhdCdzIHdoYXQgRUZBIGFscmVhZHkgZG9lcyBpbiB0aGlzIHNlcmllcywgbm8/
DQo+ID4+IFdlIG5vIGxvbmdlciByZW1vdmUgZW50cmllcyBvbiBkZWFsbG9jX3Vjb250ZXh0LCBv
bmx5IHdoZW4gdGhlIGVudHJ5DQo+ID4+IGlzIGZyZWVkLg0KPiA+DQo+ID4gQWN0dWFsbHksIEkg
dGhpbmsgbW9zdCBvZiB0aGUgZGlzY3Vzc2lvbnMgeW91IGhhZCBvbiB0aGUgdG9waWMgd2VyZQ0K
PiA+IHdpdGggR2FsLCBidXQgU29tZSBhcHBseSB0byBxZWRyIGFzIHdlbGwsIGhvd2V2ZXIsIGZv
ciBxZWRyLCB0aGUgb25seQ0KPiA+IGh3IHJlc291cmNlIHdlIGFsbG9jYXRlIChiYXIpIGlzIG9u
IGFsbG9jX3Vjb250ZXh0ICwgdGhlcmVmb3JlIHdlIHdlcmUNCj4gPiBzYWZlIHRvIGZyZWUgaXQg
b24gZGVhbGxvY191Y29udGV4dCBhcyBhbGwgbWFwcGluZ3Mgd2VyZSBhbHJlYWR5DQo+ID4gemFw
cGVkLiBNYWtpbmcgdGhlIG1tYXBfZnJlZSBhIGJpdCByZWR1bmRhbnQgZm9yIHFlZHIgZXhjZXB0
IGZvciB0aGUNCj4gbmVlZCB0byBmcmVlIHRoZSBlbnRyeS4NCj4gPg0KPiA+IEZvciBFRkEsIGl0
IHNlZW1lZCB0aGUgb25seSBvcGVyYXRpb24gZGVsYXllZCB3YXMgZnJlZWluZyBtZW1vcnkgLSBJ
DQo+ID4gZGlkbid0IHNlZSBodyByZXNvdXJjZXMgYmVpbmcgZnJlZWQuLi4gR2FsPw0KPiANCj4g
V2hhdCBkbyB5b3UgbWVhbiBieSBodyByZXNvdXJjZXMgYmVpbmcgZnJlZWQ/IFRoZSBCQVIgbWFw
cGluZ3MgYXJlDQo+IHVuZGVyIHRoZSBkZXZpY2XigJlzIGNvbnRyb2wgYW5kIGFyZSBhc3NvY2lh
dGVkIHRvIHRoZSBsaWZldGltZSBvZiB0aGUgVUFSLg0KVGhlIGJhciBvZmZzZXQgeW91IGdldCBp
cyBmcm9tIHRoZSBkZXZpY2UgLT4gZG9uJ3QgeW91IHJlbGVhc2UgaXQgYmFjayB0byB0aGUgZGV2
aWNlDQpTbyBpdCBjYW4gYmUgYWxsb2NhdGVkIHRvIGEgZGlmZmVyZW50IGFwcGxpY2F0aW9uID8g
DQpJbiBlZmFfY29tX2NyZWF0ZV9xcCAtPiB5b3UgZ2V0IG9mZnNldHMgZnJvbSB0aGUgZGV2aWNl
IHRoYXQgeW91IHVzZSBmb3IgbWFwcGluZw0KVGhlIGJhciAtPiBhcmUgdGhlc2UgdW5pcXVlIGZv
ciBldmVyeSBjYWxsID8gYXJlIHRoZXkgcmVsZWFzZWQgZHVyaW5nIGRlc3Ryb3lfcXAgPyANCkJl
Zm9yZSB0aGlzIHBhdGNoIHNlcmllcyBtbWFwX2VudHJpZXNfcmVtb3ZlX2ZyZWUgb25seSBmcmVl
ZCB0aGUgRE1BIHBhZ2VzLCBidXQNCkZvbGxvd2luZyB0aGlzIHRocmVhZCwgaXQgc2VlbWVkIHRo
ZSBpbml0aWFsIGludGVudGlvbiB3YXMgdGhhdCBvbmx5IHRoZSBodyByZXNvdXJjZXMgd291bGQN
CkJlIGRlbGF5ZWQgYXMgdGhlIERNQSBwYWdlcyBhcmUgcmVmIGNvdW50ZWQgYW55d2F5LiAgSSBk
aWRuJ3Qgc2VlIGFueSBkZWxheSB0byByZXR1cm5pbmcNClRoZSBiYXIgb2Zmc2V0cyB0byB0aGUg
ZGV2aWNlLiBUaGFua3MuDQoNCg==
