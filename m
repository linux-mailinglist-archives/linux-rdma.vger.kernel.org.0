Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8D614B7
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2019 13:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGGLaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jul 2019 07:30:35 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33714 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbfGGLaf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Jul 2019 07:30:35 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x67BUVwh028141;
        Sun, 7 Jul 2019 04:30:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Jy5IAn2J7n+1yvV515MfEFA+erqe4K8IiSaqRmgX/NY=;
 b=H8b44JkOySFmrcF4V10Ru7v8NNVJV0WkgZdYLkpcBu8z0atzUmAb+4FlEOSwIllOT7G9
 E8kwgbQfEYQhNJdmlB7WxJ+Ua9d7ks2vFPZkfJBSvcGAtgYyG3H+jtkIbLmQJpdj9EFF
 aApqVy9ERNR6m8bbVvLVKuwdh1RbBqd8fwBlaa7WQLzc8LLGRF0vB8Yz6cVjdSab+ERE
 HxMc3XBUcNbDqjaKAl7xc+PJGBT7ZYU9AXgkNKtwU0XsUCnxWqFxotFNKCgsJ1wyeV1d
 oefRenOBENjhZtEkX7KwEXAEwI+EzKi24OD9L/eaqrwqzTyHvbTvUp/uRy3t8aNj4sTx 9A== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tjs0nun3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 07 Jul 2019 04:30:30 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 7 Jul
 2019 04:30:29 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 7 Jul 2019 04:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy5IAn2J7n+1yvV515MfEFA+erqe4K8IiSaqRmgX/NY=;
 b=aJh8sFkiQGG94mEdXnQ9cXl8dE9Zm9y3MoS6NdDdO2jrUy8GXRjOYZoeQpF0gYtAT9vimVR4l0J/r4zbfonQKWec3dfmNKf6I0BIxmCpXsKFcLGSbFY4dLbD6aIgldt439DEfQggznJZsMl7Xa3UbPANbBmhZADx5Ql7Nyhgqxs=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2398.namprd18.prod.outlook.com (20.179.81.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Sun, 7 Jul 2019 11:30:28 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2052.020; Sun, 7 Jul 2019
 11:30:27 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap
 function
Thread-Index: AQHVMXgY2ufVwbsMjkGRdCnidkmBy6a6ZueAgAHB8bCAAAIEAIAAHUlwgAAFGICAAm2+gIAAUA6Q
Date:   Sun, 7 Jul 2019 11:30:27 +0000
Message-ID: <MN2PR18MB3182F0CAD6ACCAEE5BA71A69A1F70@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <20190704123511.GA3447@ziepe.ca>
 <MN2PR18MB318240185BE80841F1265D2FA1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190705153248.GB31543@ziepe.ca>
 <MN2PR18MB3182F4496DA01CA2B113DF04A1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190705173551.GC31543@ziepe.ca>
 <4d8c8c9e-df8a-6555-c11a-b53a5dd274fe@amazon.com>
In-Reply-To: <4d8c8c9e-df8a-6555-c11a-b53a5dd274fe@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12c599b9-dced-44db-d4c0-08d702ce82eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2398;
x-ms-traffictypediagnostic: MN2PR18MB2398:
x-microsoft-antispam-prvs: <MN2PR18MB2398ADED1DE7FC1D700184D4A1F70@MN2PR18MB2398.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0091C8F1EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(199004)(189003)(52536014)(76116006)(66946007)(6436002)(68736007)(256004)(73956011)(14454004)(66446008)(64756008)(66556008)(2906002)(4326008)(66476007)(81166006)(81156014)(55016002)(6246003)(8676002)(9686003)(33656002)(53936002)(8936002)(110136005)(5660300002)(54906003)(316002)(74316002)(478600001)(99286004)(26005)(186003)(86362001)(71200400001)(71190400001)(7696005)(76176011)(102836004)(7736002)(25786009)(6506007)(53546011)(486006)(66066001)(446003)(476003)(11346002)(305945005)(229853002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2398;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oJe3AYzbMbRGkkZrC4p4bbyA9G+D7FqJzEZ7VbKSCDz1+4N7+Yy5vngdjktwGI9mIFCsHjE5jD5p4JibjnhW+aW6fSAjOwRm7db3Hyq4brI6HJHBZAlt5OD3X5LK4GjYGsnsAlnUpzzAbLNxCDaft8HM8XlA9TcCoEYutsCNp4zVMotwcZ/W04AcqJ9mureOHTi+MeIRNMxgiB1oj+26nAznvqz4WIxwRolHINP91i38P6grab9sHVLhiPydlQm7xBLbOXQFUlubtCjD2xiR7aknh6MDjyEtXo7yQxtLDZEKRrE+TYOBHpbCxCjOxu0Z8ItC33hJnt60LylSPfO3fIS5wFm8vwalf9znz7NpOarsKCx5I/Vgogl/rHNxEDhg6t/p9MXrWhPsvmgAQHUvkZZpeLg9EgWhskqpP7V5hbo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c599b9-dced-44db-d4c0-08d702ce82eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2019 11:30:27.6787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2398
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-07_04:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFN1bmRh
eSwgSnVseSA3LCAyMDE5IDk6NDEgQU0NCj4gDQo+IE9uIDA1LzA3LzIwMTkgMjA6MzUsIEphc29u
IEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBGcmksIEp1bCAwNSwgMjAxOSBhdCAwNToyNDoxOFBN
ICswMDAwLCBNaWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4+PiBGcm9tOiBKYXNvbiBHdW50aG9y
cGUgPGpnZ0B6aWVwZS5jYT4NCj4gPj4+IFNlbnQ6IEZyaWRheSwgSnVseSA1LCAyMDE5IDY6MzMg
UE0NCj4gPj4+DQo+ID4+PiBPbiBGcmksIEp1bCAwNSwgMjAxOSBhdCAwMzoyOTowM1BNICswMDAw
LCBNaWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4+Pj4+IEZyb206IEphc29uIEd1bnRob3JwZSA8
amdnQHppZXBlLmNhPg0KPiA+Pj4+PiBTZW50OiBUaHVyc2RheSwgSnVseSA0LCAyMDE5IDM6MzUg
UE0NCj4gPj4+Pj4NCj4gPj4+Pj4gRXh0ZXJuYWwgRW1haWwNCj4gPj4+Pj4NCj4gPj4+Pj4gT24g
V2VkLCBKdWwgMDMsIDIwMTkgYXQgMTE6MTk6MzRBTSArMDMwMCwgR2FsIFByZXNzbWFuIHdyb3Rl
Og0KPiA+Pj4+Pj4gT24gMDMvMDcvMjAxOSAxOjMxLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+
ID4+Pj4+Pj4+IFNlZW1zIGV4Y2VwdCBNZWxsYW5veCArIGhucyB0aGUgbW1hcCBmbGFncyBhcmVu
J3QgQUJJLg0KPiA+Pj4+Pj4+PiBBbHNvLCBjdXJyZW50IE1lbGxhbm94IGNvZGUgc2VlbXMgbGlr
ZSBpdCB3b24ndCBiZW5lZml0IGZyb20NCj4gPj4+Pj4+Pj4gbW1hcCBjb29raWUgaGVscGVyIGZ1
bmN0aW9ucyBpbiBhbnkgY2FzZSBhcyB0aGUgbW1hcCBmdW5jdGlvbg0KPiA+Pj4+Pj4+PiBpcyB2
ZXJ5IHNwZWNpZmljIGFuZCB0aGUgZmxhZ3MgdXNlZCBpbmRpY2F0ZSB0aGUgYWRkcmVzcyBhbmQN
Cj4gPj4+Pj4+Pj4gbm90IGp1c3QgaG93IHRvIG1hcA0KPiA+Pj4+PiBpdC4NCj4gPj4+Pj4+Pg0K
PiA+Pj4+Pj4+IElNSE8sIG1seDUgaGFzIGEgZ29vZnkgaW1wbGVtZW50YWl0b24gaGVyZSBhcyBp
dCBjb2RlcyBhbGwgb2YNCj4gPj4+Pj4+PiB0aGUgb2JqZWN0IHR5cGUsIGhhbmRsZSBhbmQgY2Fj
aGFiaWxpdHkgZmxhZ3MgaW4gb25lIHRoaW5nLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IERvIHdlIG5l
ZWQgb2JqZWN0IHR5cGUgZmxhZ3MgYXMgd2VsbCBpbiB0aGUgZ2VuZXJpYyBtbWFwIGNvZGU/DQo+
ID4+Pj4+DQo+ID4+Pj4+IEF0IHRoZSBlbmQgb2YgdGhlIGRheSB0aGUgZHJpdmVyIG5lZWRzIHRv
IGtub3cgd2hhdCBwYWdlIHRvIG1hcA0KPiA+Pj4+PiBkdXJpbmcgdGhlIG1tYXAgc3lzY2FsbC4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gbWx4NSBkb2VzIHRoaXMgYnkgZW5jb2RpbmcgdGhlIHBhZ2UgdHlw
ZSBpbiB0aGUgYWRkcmVzcywgYW5kIHRoZW4NCj4gPj4+Pj4gbWFueSB0eXBlcyBoYXZlIHNlcGVy
YXRlIGxvb2t1cHMgYmFzZWQgb250aGUgb2Zmc2V0IGZvciB0aGUgYWN0dWFsDQo+ID4+PiBwYWdl
Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJTUhPIHRoZSBzaW5nbGUgbG9va3VwIGFuZCBvcGFxdWUgb2Zm
c2V0IGlzIGdlbmVyYWxseSBiZXR0ZXIuLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaW5jZSB0aGUgbWx4
NSBzY2hlbWUgaXMgQUJJIGl0IGNhbid0IGJlIGNoYW5nZWQgdW5mb3J0dW5hdGVseS4NCj4gPj4+
Pj4NCj4gPj4+Pj4gSWYgeW91IHdhbnQgdG8gZG8gdXNlciBjb250cm9sbGVkIGNhY2hhYmlsaXR5
IGZsYWdzLCBvciBub3QsIGlzIGENCj4gPj4+Pj4gZmFpciBxdWVzdGlvbiwgYnV0IHRoZXkgc3Rp
bGwgYmVjb21lIEFCSS4uDQo+ID4+Pj4+DQo+ID4+Pj4+IEknbSB3b25kZXJpbmcgaWYgaXQgcmVh
bGx5IG1ha2VzIHNlbnNlIHRvIGRvIHRoYXQgZHVyaW5nIHRoZSBtbWFwLA0KPiA+Pj4+PiBvciBp
ZiB0aGUgY2FjaGFiaWxpdHkgc2hvdWxkIGJlIHNldCBhcyBwYXJ0IG9mIGNyZWF0aW5nIHRoZSBj
b29raWU/DQo+ID4+Pj4+DQo+ID4+Pj4+PiBBbm90aGVyIGlzc3VlIGlzIHRoYXQgdGhlc2UgZmxh
Z3MgYXJlbid0IGV4cG9zZWQgaW4gYW4gQUJJIGZpbGUsDQo+ID4+Pj4+PiBzbyBhIHVzZXJzcGFj
ZSBsaWJyYXJ5IGNhbid0IHJlYWxseSBtYWtlIHVzZSBvZiBpdCBpbiBjdXJyZW50IHN0YXRlLg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBXb29wcy4NCj4gPj4+Pj4NCj4gPj4+Pj4gQWgsIHRoaXMgaXMgYWxs
IEFCSSBzbyB5b3UgbmVlZCB0byBkaWcgb3V0IG9mIHRoaXMgaG9sZSBBU0FQIDopDQo+ID4+Pj4+
DQo+ID4+Pj4gSmFzb24sIEkgZGlkbid0IGZvbGxvdyAtIHdoYXQgaXMgYWxsIEFCST8NCj4gPj4+
PiBjdXJyZW50bHkgRUZBIGltcGxlbWVudGF0aW9uIGVuY29kZXMgdGhlIGNhY2hhYmlsaXR5IGlu
c2lkZSB0aGUNCj4gPj4+PiBrZXksIEl0J3Mgbm90IGV4cG9zZWQgaW4gQUJJIGZpbGUgYW5kIGlz
IG9wYXF1ZSB0byB1c2VyLXNwYWNlLiBUaGUNCj4gPj4+PiBrZXJuZWwgZGVjaWRlcyBvbiB0aGUg
Y2FjaGFiaWxpdHkgQW5kIGdldCdzIGl0IGJhY2sgaW4gdGhlIGtleSB3aGVuDQo+ID4+Pj4gbW1h
cCBpcyBjYWxsZWQuIEl0IHNlZW1zIGdvb2QgZW5vdWdoIGZvciB0aGUgY3VycmVudCBjYXNlcy4N
Cj4gPj4+DQo+ID4+PiBUaGVuIHRoZSBrZXkgJ29mZnNldCcgc2hvdWxkIG5vdCBpbmNsdWRlIGNh
Y2hhYmlsaXR5IGluZm9ybWF0aW9uIGF0IGFsbC4NCj4gPj4+DQo+ID4+IEZhaXIgZW5vdWdoLCBz
byBhcyB5b3Ugc3RhdGVkIGFib3ZlIHRoZSBjYWNoYWJpbGl5IGNhbiBiZSBzZXQgaW4gdGhlDQo+
IGNvb2tpZS4NCj4gPj4gV291bGQgd2Ugc3RpbGwgbGlrZSB0byBsZWF2ZSBzb21lIGJpdHMgZm9y
IGZ1dHVyZSBBQkkgZW5oYW5jZW1lbnRzLA0KPiByZXF1ZXN0cywgZnJvbSB1c2VyID8NCj4gPj4g
U2ltaWxhciB0byBhIHBhZ2UgdHlwZSB0aGF0IG1seCBoYXMgPw0KPiA+DQo+ID4gRG9lc24ndCBt
YWtlIHNlbnNlIHRvIG1peCBhbmQgbWF0Y2gsIHRoZSBwYWdlX3R5cGUgd2FzIGp1c3Qgc29tZSB3
YXkNCj4gPiB0byBhdm9pZCB0cmFja2luZyBjb29raWVzIGluIHNvbWUgY2FzZXMuIElmIHdlIGFy
ZSBhbHdheXMgaGF2aW5nIGENCj4gPiBjb29raWUgdGhlbiB0aGUgY29va2llIHNob3VsZCBpbmRp
Y2F0ZSB0aGUgdHlwZSBiYXNlZCBvbiBob3cgaXQgd2FzDQo+ID4gY3JlYXRlZC4gVG90YWxseSBv
cGFxdWUNCj4gDQo+IEknbSBmaW5lIHdpdGggcmVtb3ZpbmcgdGhlIGNhY2hhYmlsaXR5IGZsYWdz
IGZyb20gdGhlIEFCSSwgYnV0IEkgZG9uJ3Qgc2VlIGhvdw0KPiB0aGUgcGFnZSB0eXBlcyBjYW4g
YmUgYWRkZWQgd2l0aG91dCBleHBvc2luZyB0aGVtIGluIHRoZSBrZXkuDQo+IA0KPiBJZiB3ZSB3
YW50IHRvIG1tYXAgc29tZXRoaW5nIHRoYXQncyBub3QgYSBRUC9DUS8uLi4gaG93IGNhbiB3ZSBk
byB0aGF0PyBJDQo+IGd1ZXNzIG9ubHkgYnkgcmV0dXJuaW5nIHNvbWUga2V5IGluIGFsbG9jX3Vj
b250ZXh0Pw0KDQpSaWdodC4gRXZlcnkgY2FsbCB0byBtbWFwIHNob3VsZCBiZSBiYWNrZWQgdXAg
YnkgYSBjb29raWUgaW4gdGhlIGRyaXZlci4NCg==
