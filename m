Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4682A5786
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfIBNQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 09:16:25 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:7336 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729672AbfIBNQZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 09:16:25 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82DGHGM030789;
        Mon, 2 Sep 2019 06:16:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=37Wu5aY+dOkFLUX+hm0ULU0iLRRXI38hHMUlneSzUeg=;
 b=ofx/aFnxlgBNBdRym/auYFFHjtAHDVDpN57evegh6A3bTbK7d/g45FnZ+Y3kHpWfP/5H
 TzOyUEVCzrE5T4OTbCy+I1nWVDCO6Ltng7xuh924g/tTeUd46SnJh3Lc0Va9ij33AScW
 p+ekED7p7QeWpWWdkzbxvwlqjte4uj6JNiKM3euq6o5yVBP1D7Ue3ytqoHae8hmXopIm
 TXV0fFsheu9Do47ja1CY9aOERIY9aw9UEKN5RlpJePE1NtQjJ8DceMmTxg1apAz3EBMO
 JoBc6uzJoILuukN+2/NiLp1PzzV8DrqJ/xwBDbA9aqoJkguaQdszppfAL1fgoe7D0PJI 7Q== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm63yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 06:16:17 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 06:16:14 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 2 Sep 2019 06:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7xwojuvoIOaOB6PfCNQpxVrWprLbZEkIYjPFPA3qAx6cwj+tijia8/rKW31MCHneFRDEdEiWjX+r9jGRP/KWFJKNjWMZm6WwqAEn+Gl4LCRirRfkMnOgTggZBYNhB7qeUk+KIzIC4PziGiXFfponzknOTCbA4m93a7gdjffb4/IrHmJAPUyi2btnFgHaIB6i6b6ayXSR4ODtpT284536jXcRLdAF2D1l7coYCua0gw7ugrnJ4Pzcg6KfHCl16mCG3YRLK530hn26MR4OKPeCYbDhp09DJv9qRcjrq/b0SD2SdY70afkfBM8qVNX/6qyfxT61ZFhPlZfH4mHj1e7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Wu5aY+dOkFLUX+hm0ULU0iLRRXI38hHMUlneSzUeg=;
 b=kaAQZXWa8fyvwAJVIH0BXy2/+hcBnMm4cCb2Tciv6nar64rURq9RrCrvloLsd0O8VznV6z21tvxfde3gAX47Z3hH+IvvjSQ72LUYGpxalYqIlX/hKZem7a1h6TxAbcgaSz24jW4+liRV0zT2uePcaOJYjXiKBjBcWZwT9k0DRYwJUKEIxx7xu0l46QpUhnIvbO33LWcnn8xzTWWkWmDYLQO95co31nKOBaI43faa39FMh3bc69UJ1juVW6XP8kl0YF20v4+yOzAyZC6RYxfIgPm695gcJ6MRyHagemH6m2vD0C29tMmpL1Je2nyFtVWehdy3EE9jtVG1l/wqIhlrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Wu5aY+dOkFLUX+hm0ULU0iLRRXI38hHMUlneSzUeg=;
 b=HQGKnLixk1WaGSePVLQkR+bYMMf2FQtfE3lQkBHq3HtHGuLyRiI8qA4D1Av9QF3/YQ1b03BeeGZWh63GWCdbGtAC4pvLVXCThEiL5wRpYyygc1nZetJwYY5owuyjVZE9A+ovFBH55M2Fb6d0Kb/Q2XISYOUJmTn924uhfDUHMTM=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3376.namprd18.prod.outlook.com (10.255.238.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Mon, 2 Sep 2019 13:16:12 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 13:16:12 +0000
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
Thread-Index: AQHVXNvBsBWJLPJoZk2QlZBxyqYUlacTnV+AgAAHP4CAAAzGAIAEXNwAgAA4U4CAACC4kA==
Date:   Mon, 2 Sep 2019 13:16:11 +0000
Message-ID: <MN2PR18MB3182D298F0F29DBD4144AAD8A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <MN2PR18MB31820E898CC0C39E7A347B62A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>,<MN2PR18MB318291264841FC40885F4B42A1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>,<20190827132846.9142-5-michal.kalderon@marvell.com>,<20190827132846.9142-1-michal.kalderon@marvell.com>
 <OFED447099.CC1C35E8-ON00258466.003FD3A8-00258466.0042A33D@notes.na.collabserv.com>
 <OFDCD94E77.5EF5EBC2-ON00258466.0048FF97-00258466.00493280@notes.na.collabserv.com>
 <OF7D03AEB5.CF6450C1-ON00258469.003DDB8B-00258469.003E1DF8@notes.na.collabserv.com>
In-Reply-To: <OF7D03AEB5.CF6450C1-ON00258469.003DDB8B-00258469.003E1DF8@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5530e9df-7a3a-435e-b20b-08d72fa7ba00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3376;
x-ms-traffictypediagnostic: MN2PR18MB3376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB337668C22A64EFB2D4F3306AA1BE0@MN2PR18MB3376.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(39850400004)(396003)(136003)(189003)(199004)(305945005)(3846002)(6116002)(256004)(229853002)(76116006)(66946007)(64756008)(2906002)(316002)(8936002)(81156014)(81166006)(5660300002)(66556008)(66476007)(14454004)(66446008)(7696005)(71190400001)(71200400001)(55016002)(486006)(86362001)(476003)(9686003)(6916009)(54906003)(6246003)(6436002)(53936002)(102836004)(99286004)(52536014)(478600001)(33656002)(446003)(11346002)(26005)(186003)(25786009)(4326008)(74316002)(7736002)(66066001)(6506007)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3376;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cT6oHQynkI4dkLiebS9a/CCITpOYoY9Td05OKaqZfkBeXusl4WVg4jgCR4JURYzQryloFcrnoEMCm1XjGTNm20z4n9oK/f8kxhoSkt3E1Jdx9QWUxZQcmtyUmTkbEn/JvjF2cC2AvIYblPA6r/yEPkPS6XDyFceuV3eoLLpYkmMSfcm6PF2pz7hHDiAm5FYd25j64z8PlrTwrBKsIZvcZhi2LqOqTK81ZSEh4mlQDKUAesLHBMKs7GVbIxaPkY1TjRo1o08Sy7gU0QukaZBb4jSIQBAH3RGJ1a92Ho3PmUJLEXNwE21Api5mARifj1vlvf8QTuHvNSjd75MjrZ6PEfFkJO4iR11vX6wFJQIjQ8B+xpakx3I1UoSO6X8u5QxwlzNijpAi6DfjMkDD8Q4X+NsKAOgtqDLT8EJFj86CAWs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5530e9df-7a3a-435e-b20b-08d72fa7ba00
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 13:16:12.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIw1a7EcVn70DaDl8EnMtQTgKy31fp7mxc366dJto/iveIRlCAqv4pE5j7TYyhhDsWb8yS+OpP24G+hr8M2igg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3376
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_05:2019-08-29,2019-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgQmVybmFyZCBNZXR6bGVyDQo+IA0K
PiAtLS0tLSJNaWNoYWwgS2FsZGVyb24iIDxta2FsZGVyb25AbWFydmVsbC5jb20+IHdyb3RlOiAt
LS0tLQ0KPiANCj4gPlRvOiAiQmVybmFyZCBNZXR6bGVyIiA8Qk1UQHp1cmljaC5pYm0uY29tPg0K
PiA+RnJvbTogIk1pY2hhbCBLYWxkZXJvbiIgPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4NCj4gPkRh
dGU6IDA5LzAyLzIwMTkgMTA6MDFBTQ0KPiA+Q2M6ICJBcmllbCBFbGlvciIgPGFlbGlvckBtYXJ2
ZWxsLmNvbT4sICJqZ2dAemllcGUuY2EiDQo+ID48amdnQHppZXBlLmNhPiwgImRsZWRmb3JkQHJl
ZGhhdC5jb20iIDxkbGVkZm9yZEByZWRoYXQuY29tPiwNCj4gPiJnYWxwcmVzc0BhbWF6b24uY29t
IiA8Z2FscHJlc3NAYW1hem9uLmNvbT4sDQo+ICJzbGV5Ym9AYW1hem9uLmNvbSINCj4gPjxzbGV5
Ym9AYW1hem9uLmNvbT4sICJsZW9uQGtlcm5lbC5vcmciIDxsZW9uQGtlcm5lbC5vcmc+LA0KPiA+
ImxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnIiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+
DQo+ID5TdWJqZWN0OiBbRVhURVJOQUxdIFJFOiBSRTogW0VYVF0gUmU6IFtQQVRDSCB2OCByZG1h
LW5leHQgNC83XQ0KPiA+UkRNQS9zaXc6IFVzZSB0aGUgY29tbW9uIG1tYXBfeGEgaGVscGVycw0K
PiA+DQo+ID4+IEZyb206IGxpbnV4LXJkbWEtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1y
ZG1hLQ0KPiA+PiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBCZXJuYXJkIE1l
dHpsZXINCj4gPj4NCj4gPj4gLS0tLS0iTWljaGFsIEthbGRlcm9uIiA8bWthbGRlcm9uQG1hcnZl
bGwuY29tPiB3cm90ZTogLS0tLS0NCj4gPj4NCj4gPj4gPlRvOiAiQmVybmFyZCBNZXR6bGVyIiA8
Qk1UQHp1cmljaC5pYm0uY29tPg0KPiA+PiA+RnJvbTogIk1pY2hhbCBLYWxkZXJvbiIgPG1rYWxk
ZXJvbkBtYXJ2ZWxsLmNvbT4NCj4gPj4gPkRhdGU6IDA4LzMwLzIwMTkgMDI6NDJQTQ0KPiA+PiA+
Q2M6ICJBcmllbCBFbGlvciIgPGFlbGlvckBtYXJ2ZWxsLmNvbT4sICJqZ2dAemllcGUuY2EiDQo+
ID4+ID48amdnQHppZXBlLmNhPiwgImRsZWRmb3JkQHJlZGhhdC5jb20iIDxkbGVkZm9yZEByZWRo
YXQuY29tPiwNCj4gPj4gPiJnYWxwcmVzc0BhbWF6b24uY29tIiA8Z2FscHJlc3NAYW1hem9uLmNv
bT4sDQo+ID4+ICJzbGV5Ym9AYW1hem9uLmNvbSINCj4gPj4gPjxzbGV5Ym9AYW1hem9uLmNvbT4s
ICJsZW9uQGtlcm5lbC5vcmciIDxsZW9uQGtlcm5lbC5vcmc+LA0KPiA+PiA+ImxpbnV4LXJkbWFA
dmdlci5rZXJuZWwub3JnIiA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+LCAiQXJpZWwNCj4g
Pj4gPkVsaW9yIiA8YWVsaW9yQG1hcnZlbGwuY29tPg0KPiA+PiA+U3ViamVjdDogW0VYVEVSTkFM
XSBSRTogW0VYVF0gUmU6IFtQQVRDSCB2OCByZG1hLW5leHQgNC83XQ0KPiA+UkRNQS9zaXc6DQo+
ID4+ID5Vc2UgdGhlIGNvbW1vbiBtbWFwX3hhIGhlbHBlcnMNCj4gPj4gPg0KPiA+PiA+PiBGcm9t
OiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gPj4gPj4gU2VudDogRnJp
ZGF5LCBBdWd1c3QgMzAsIDIwMTkgMzowOCBQTQ0KPiA+PiA+Pg0KPiA+PiA+PiBFeHRlcm5hbCBF
bWFpbA0KPiA+PiA+Pg0KPiA+PiA+Pg0KPiA+Pg0KPiA+Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4tDQo+ID4+
ID4tDQo+ID4+ID4+IC0tLS0tIk1pY2hhbCBLYWxkZXJvbiIgPG1pY2hhbC5rYWxkZXJvbkBtYXJ2
ZWxsLmNvbT4gd3JvdGU6DQo+ID4tLS0tLQ0KPiA+PiA+Pg0KPiA+PiA+PiBIaSBNaWNoYWVsLA0K
PiA+PiA+Pg0KPiA+PiA+PiBJIHRyaWVkIHRoaXMgcGF0Y2guIEl0IHVuZm9ydHVuYXRlbHkgcGFu
aWNzIGltbWVkaWF0ZWx5IHdoZW4gc2l3DQo+ID4+ID5nZXRzIHVzZWQuIEknbGwNCj4gPj4gPj4g
aW52ZXN0aWdhdGUgZnVydGhlci4gU29tZSBjb21tZW50cyBpbiBsaW5lLg0KPiA+PiA+VGhhbmtz
IGZvciB0ZXN0aW5nLA0KPiA+PiA+DQo+ID4+ID4+DQo+ID4+ID4+IFRoYW5rcw0KPiA+PiA+PiBC
ZXJuYXJkLg0KPiA+PiA+Pg0KPiA+PiA+PiA+VG86IDxta2FsZGVyb25AbWFydmVsbC5jb20+LCA8
YWVsaW9yQG1hcnZlbGwuY29tPiwNCj4gPj4gPGpnZ0B6aWVwZS5jYT4sDQo+ID4+ID4+ID48ZGxl
ZGZvcmRAcmVkaGF0LmNvbT4sIDxibXRAenVyaWNoLmlibS5jb20+LA0KPiA+PiA+PiA8Z2FscHJl
c3NAYW1hem9uLmNvbT4sDQo+ID4+ID4+ID48c2xleWJvQGFtYXpvbi5jb20+LCA8bGVvbkBrZXJu
ZWwub3JnPg0KPiA+PiA+PiA+RnJvbTogIk1pY2hhbCBLYWxkZXJvbiIgPG1pY2hhbC5rYWxkZXJv
bkBtYXJ2ZWxsLmNvbT4NCj4gPj4gPj4gPkRhdGU6IDA4LzI3LzIwMTkgMDM6MzFQTQ0KPiA+PiA+
PiA+Q2M6IDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz4sICJNaWNoYWwgS2FsZGVyb24iDQo+
ID4+ID4+ID48bWljaGFsLmthbGRlcm9uQG1hcnZlbGwuY29tPiwgIkFyaWVsIEVsaW9yIg0KPiA+
PiA+PiA+PGFyaWVsLmVsaW9yQG1hcnZlbGwuY29tPg0KPiA+PiA+PiA+U3ViamVjdDogW0VYVEVS
TkFMXSBbUEFUQ0ggdjggcmRtYS1uZXh0IDQvN10gUkRNQS9zaXc6IFVzZSB0aGUNCj4gPj4gPj4g
Y29tbW9uDQo+ID4+ID4+ID5tbWFwX3hhIGhlbHBlcnMNCj4gPj4gPj4gPg0KPiA+PiA+PiA+UmVt
b3ZlIHRoZSBmdW5jdGlvbnMgcmVsYXRlZCB0byBtYW5hZ2luZyB0aGUgbW1hcF94YSBkYXRhYmFz
ZS4NCj4gPj4gPj4gPlRoaXMgY29kZSBpcyBub3cgY29tbW9uIGluIGliX2NvcmUuIFVzZSB0aGUg
Y29tbW9uIEFQSSdzDQo+ID5pbnN0ZWFkLg0KPiA+PiA+PiA+DQo+ID4+ID4+ID5TaWduZWQtb2Zm
LWJ5OiBBcmllbCBFbGlvciA8YXJpZWwuZWxpb3JAbWFydmVsbC5jb20+DQo+ID4+ID4+ID5TaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1pY2hhbC5rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4N
Cj4gPj4gPj4gPi0tLQ0KPiA+PiA+PiA+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3Lmgg
ICAgICAgfCAgMjAgKystDQo+ID4+ID4+ID4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
bWFpbi5jICB8ICAgMSArDQo+ID4+ID4+ID4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
dmVyYnMuYyB8IDIyMw0KPiA+PiA+PiA+KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LQ0KPiA+PiA+PiA+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmggfCAgIDEg
Kw0KPiA+PiA+PiA+IDQgZmlsZXMgY2hhbmdlZCwgMTQ0IGluc2VydGlvbnMoKyksIDEwMSBkZWxl
dGlvbnMoLSkNCj4gPj4gPj4gPg0KPiA+PiA+PiA+KwkJCS8qIElmIGVudHJ5IHdhcyBpbnNlcnRl
ZCBzdWNjZXNzZnVsbHksIHFwLQ0KPiA+c2VuZHENCj4gPj4gPj4gPisJCQkgKiB3aWxsIGJlIGZy
ZWVkIGJ5IHNpd19tbWFwX2ZyZWUNCj4gPj4gPj4gPisJCQkgKi8NCj4gPj4gPj4gPisJCQlxcC0+
c2VuZHEgPSBOVUxMOw0KPiA+PiA+Pg0KPiA+PiA+PiBxcC0+c2VuZHEgcG9pbnRzIHRvIHRoZSBT
USBhcnJheS4gWmVyb2luZyB0aGlzIHBvaW50ZXIgd2lsbA0KPiA+bGVhdmUNCj4gPj4gPj4gc2l3
IHdpdGggbm8gaWRlYSB3aGVyZSB0aGUgV1FFJ3MgYXJlLiBJdCB3aWxsIHBhbmljDQo+ID5kZS1y
ZWZlcmVuY2luZw0KPiA+PiA+W05VTEwgKw0KPiA+PiA+PiBjdXJyZW50IHBvc2l0aW9uIGluIHJp
bmcgYnVmZmVyXS4gU2FtZSBmb3IgUlEsIFNSUSBhbmQgQ1EuDQo+ID4+ID5RcC0+c2VuZHEgaXMg
b25seSB1c2VkIGluIGtlcm5lbCBtb2RlLCBhbmQgb25seSBzZXQgdG8gTlVMTCBpcw0KPiA+PiA+
dXNlci1zcGFjZSBtb2RlDQo+ID4+ID5XaGVyZSBpdCBpcyBhbGxvY2F0ZWQgYW5kIG1hcHBlZCBp
biB1c2VyLCBzbyB0aGUgdXNlciB3aWxsIGJlIHRoZQ0KPiA+b25lDQo+ID4+ID5hY2Nlc3Npbmcg
dGhlIHJpbmdzIEFuZCBub3Qga2VybmVsLCB1bmxlc3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nLg0K
PiA+Pg0KPiA+PiBUaGVzZSBwb2ludGVycyBhcmUgcG9pbnRpbmcgdG8gdGhlIGFsbG9jYXRlZCB3
b3JrIHF1ZXVlcy4NCj4gPj4gVGhlc2UgcXVldWVzL2FycmF5cyBhcmUgaG9sZGluZyB0aGUgYWN0
dWFsIHNlbmQvcmVjdi9jb21wbGV0ZS9zcnENCj4gPndvcmsNCj4gPj4gcXVldWUgZWxlbWVudHMu
IEl0IGlzIGEgc2hhcmVkIGFycmF5LiBUaGF0IGlzIHdoeSB3ZSBuZWVkIG1tYXAgYXQNCj4gPmFs
bC4NCj4gPj4NCj4gPj4gZS5nLiwNCj4gPj4NCj4gPj4gc3RydWN0IHNpd19zcWUgKnNxZSA9ICZx
cC0+c2VuZHFbcXAtPnNxX2dldCAlIHFwLT5hdHRycy5zcV9zaXplXTsNCj4gPj4NCj4gPj4NCj4g
Pk9rIGdvdCBpdCwgSSdtIEhXIG9yaWVudGVkLi4uIHNvIHVzZXIgY2hhaW5zIGFuZCBrZXJuZWwg
YXJlIHRvdGFsbHkNCj4gPnNlcGFyYXRlZC4NCj4gPldpbGwgYWRkIGEgZmxhZyB3aGV0aGVyIHRv
IGZyZWUgb3Igbm90IGFuZCByZW1vdmUgc2V0dGluZyB0byBOVUxMLg0KPiANCj4gRm9yZ2V0IG15
IGxhc3QgcmVwbHkuIEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoZSBSRE1BIGNvcmUgbW1h
cF94YQ0KPiBoZWxwZXIgc3R1ZmYgd291bGQgZnJlZSB0aGUgcmVzb3VyY2UuIFNvcnJ5IGFib3V0
IHRoYXQuIFNvIGp1c3QgZG8gbm90IGZyZWUNCj4gdGhlIHJlc291cmNlIGluIHNpd19tbWFwX2Zy
ZWUoKS4NCk9LLCB3aWxsIGxlYXZlIHRoZSBsb2dpYyBleGFjdGx5IGFzIGl0IHdhcyBiZWZvcmUs
IGp1c3QgdXNlIHRoZSBjb21tb24gbW1hcCBoZWxwZXINCkZ1bmN0aW9ucy4gDQp0aGFua3MNCg0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEJlcm5hcmQuDQoNCg==
