Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD196B7E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfHTVcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 17:32:19 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33884 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730501AbfHTVcT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 17:32:19 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KLTnqT017685;
        Tue, 20 Aug 2019 14:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=GHsZhsb9bF2MCwQviAA0prsOgwio65a0K/o1MiY4HOw=;
 b=TCAMW1L+/N0J/tDMf8J4zZyqAGoI35fwZT2KnkQRDbkZyBIIf8wHGhUhGNGlNxdJxPd/
 6R0iU/lrEUnGRF8lcNz3rl5IuywJYqhwFDrMYcxr33NjoUBfFCYUvZQA0VFxXsFoSQRT
 iLH7U+oKnRCf1jl6Ak8HRSMlxbnUqJ6By9zDfDdyQ23ZV5nKVRTHjmlmIl4zU30s+BLW
 0WykygOhw7w3R9DE75jr53HhULPoESynwZKKD0CU70i1vzRORV9u7OPwokDfJZne34jH
 Hzgt4cl1bQgaZ316MtNVNvfwfPHnS4azCn6vT2f/mdxbXRZOfOcUkPomqL2eqVjvL+x6 PA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ug8a9byat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 14:32:15 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 14:32:14 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 20 Aug 2019 14:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIvELQ0DRX/7A2Jmrn06fxWbsXRG2ZXd/R9+bEY6coor5KjffH7CkxyWQ9O39OE9k0/qRxfNgcBMlRA+CcpwUfRkPPgVwaLJ2ccmZHr0UPYVuLihDbCwYsd8XlWqvD27NsQO+I8uUGL1LhxF/gvKwaHioyupuLaYPl98UBugsylPGavACaCAGEY5F91GlPqqgC5NN3gaGcZKmLJAs+5XK0g/tCHTshAUIUoqZqitvpCpOEjSGiJyVSJVcI17Uu7Ksldrmd8L/zZu7S/BjTN145SY4lcMEr7d87/Y893y3u8LehHsdGIl9vDDYF3OYjAaaLilUbC7JxVIDTyP3l416g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHsZhsb9bF2MCwQviAA0prsOgwio65a0K/o1MiY4HOw=;
 b=Vjjlf5lsyf/Nu1cnchwn4OI2ov7C2gIJJf4be9JI2KIBDHgYvvN0yhzlLJBVi3g66Dnr/1OGhh/xIb6AhVpiesWAgxD0h1M5ByuRQSFp27ziLXRrYs5JjbN2OOsH95IqG2KKgM7ECnlY1QFQCMNAE3pnfk9sZo75vyZ4ZmrFv8HE9YyNh/6t8fnZpDKpKb0Tsbzbo/GQiO/GJ/wZn82ALp0/aAEQWFgTrpmanShMudYeARoD15lAQvGwqF4MZcQsmj3z/4DTrFdOp4UF2tZQK7RlgiL9d2S2JrX4Yn0sG50p5Ea7qRlDn7LTkPN9lueudaNKE+xi6q8CihHjyG7ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHsZhsb9bF2MCwQviAA0prsOgwio65a0K/o1MiY4HOw=;
 b=ZPJpgg/PSxY6CJyivDsRwQUfwRfpVyTIMkfi3Vd24KSYOBFJbqzO9Wh41blNoZsT1UsPqr8fejAEXA728AeK8j5LUkB1Q6dyNCaTYiUd9kzgE0oGWI2US3DpA9lnyhAHcOB9Fi+cd6KYMMQU3NoHA3/KkXFlnRlROI990DK1C9M=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2800.namprd18.prod.outlook.com (20.179.20.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 21:32:07 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 21:32:07 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Topic: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Index: AQHVV1GwGCRn/XfymEKuSvdhB7Bdf6cEErgAgAB7zEA=
Date:   Tue, 20 Aug 2019 21:32:07 +0000
Message-ID: <MN2PR18MB3182BE00A39C1A933C584737A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-2-michal.kalderon@marvell.com>
 <0f6f1dd6-e4b3-5261-7480-0735f29bac63@amazon.com>
In-Reply-To: <0f6f1dd6-e4b3-5261-7480-0735f29bac63@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.37.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4468571-8ea7-4fa4-615e-08d725b5da5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2800;
x-ms-traffictypediagnostic: MN2PR18MB2800:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2800B900A4F749116A9DD13DA1AB0@MN2PR18MB2800.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(396003)(39850400004)(189003)(199004)(478600001)(5660300002)(6116002)(99286004)(102836004)(8936002)(2906002)(256004)(14444005)(3846002)(81166006)(9686003)(81156014)(6246003)(229853002)(66066001)(7736002)(2201001)(305945005)(446003)(86362001)(76176011)(7696005)(186003)(52536014)(486006)(74316002)(26005)(8676002)(76116006)(25786009)(6436002)(64756008)(66556008)(71200400001)(66946007)(71190400001)(66476007)(11346002)(476003)(6506007)(53546011)(66446008)(53936002)(316002)(2501003)(110136005)(4326008)(14454004)(54906003)(107886003)(55016002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2800;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b05gCpJn7hevFTaFcWTW6f6+AJph35XXTw633TPZuuP6ZYNZxUDzdnCayCLWGDJOhsmOezzyb70pMrVW+pq50h3zFIoht1AUDesG2S8mj8CbRl8tNc6g9UcJpB5wifykrWqjNivTQnhPTFz//n0GVnXEx2hxwLqQAKc2MNi4jomWUNsuJ991urSNmvoVK9d0Yu1krd/XGz/6t+Nsn7mr3jLanAF3o6c5Sl2m/dCHQhsKHUR7CHd1Wi+cHdFlzfGU9V+xsAzBe6xGWvGAV6DBbymgxww1z6bQvo58dFkEWVr2KnANIwpqRlAxfRJCGhyE0S3KTEFsCuyvr2dqalo9IPu1TxWKCs228Fz+F4Rz1x+4xpyq8qcy8hikK5xGmTKmHcYmzStnGAYp6dVX1eIwuOSlSEuFFiX3GdH1y+KGjyM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4468571-8ea7-4fa4-615e-08d725b5da5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 21:32:07.7209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bx5ZV2OndgPp7Qqp04PPIITI5D+j2+PB/0dExsO79lrTOEHPQ2+H+CJRLX8/smWcw0O8QIIEr0E6lSXRJr+Akw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2800
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-20_10:2019-08-19,2019-08-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCAyMCwgMjAxOSA1OjA4IFBNDQo+IA0KPiBPbiAyMC8wOC8yMDE5IDE1OjE4LCBN
aWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9jb3JlL2liX2NvcmVfdXZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pYl9j
b3JlX3V2ZXJicy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmNhYjdkYzkyMmNmMA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9pYl9jb3JlX3V2ZXJicy5jDQo+ID4gQEAgLTAsMCArMSwxMDAgQEAN
Cj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgT1IgTGludXgtT3BlbklC
DQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAwNSBNZWxsYW5veCBUZWNobm9sb2dp
ZXMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+ID4gKyAqIENvcHlyaWdodCAyMDE4LTIwMTkgQW1h
em9uLmNvbSwgSW5jLiBvciBpdHMgYWZmaWxpYXRlcy4gQWxsIHJpZ2h0cw0KPiByZXNlcnZlZC4N
Cj4gPiArICogQ29weXJpZ2h0IDIwMTkgTWFydmVsbC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4g
PiArICoNCj4gPiArICogVGhpcyBzb2Z0d2FyZSBpcyBhdmFpbGFibGUgdG8geW91IHVuZGVyIGEg
Y2hvaWNlIG9mIG9uZSBvZiB0d28NCj4gPiArICogbGljZW5zZXMuICBZb3UgbWF5IGNob29zZSB0
byBiZSBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVQ0KPiA+ICsgKiBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIChHUEwpIFZlcnNpb24gMiwgYXZhaWxhYmxlIGZyb20gdGhlIGZpbGUN
Cj4gPiArICogQ09QWUlORyBpbiB0aGUgbWFpbiBkaXJlY3Rvcnkgb2YgdGhpcyBzb3VyY2UgdHJl
ZSwgb3IgdGhlDQo+ID4gKyAqIE9wZW5JQi5vcmcgQlNEIGxpY2Vuc2UgYmVsb3c6DQo+ID4gKyAq
DQo+ID4gKyAqICAgICBSZWRpc3RyaWJ1dGlvbiBhbmQgdXNlIGluIHNvdXJjZSBhbmQgYmluYXJ5
IGZvcm1zLCB3aXRoIG9yDQo+ID4gKyAqICAgICB3aXRob3V0IG1vZGlmaWNhdGlvbiwgYXJlIHBl
cm1pdHRlZCBwcm92aWRlZCB0aGF0IHRoZSBmb2xsb3dpbmcNCj4gPiArICogICAgIGNvbmRpdGlv
bnMgYXJlIG1ldDoNCj4gPiArICoNCj4gPiArICogICAgICAtIFJlZGlzdHJpYnV0aW9ucyBvZiBz
b3VyY2UgY29kZSBtdXN0IHJldGFpbiB0aGUgYWJvdmUNCj4gPiArICogICAgICAgIGNvcHlyaWdo
dCBub3RpY2UsIHRoaXMgbGlzdCBvZiBjb25kaXRpb25zIGFuZCB0aGUgZm9sbG93aW5nDQo+ID4g
KyAqICAgICAgICBkaXNjbGFpbWVyLg0KPiA+ICsgKg0KPiA+ICsgKiAgICAgIC0gUmVkaXN0cmli
dXRpb25zIGluIGJpbmFyeSBmb3JtIG11c3QgcmVwcm9kdWNlIHRoZSBhYm92ZQ0KPiA+ICsgKiAg
ICAgICAgY29weXJpZ2h0IG5vdGljZSwgdGhpcyBsaXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBm
b2xsb3dpbmcNCj4gPiArICogICAgICAgIGRpc2NsYWltZXIgaW4gdGhlIGRvY3VtZW50YXRpb24g
YW5kL29yIG90aGVyIG1hdGVyaWFscw0KPiA+ICsgKiAgICAgICAgcHJvdmlkZWQgd2l0aCB0aGUg
ZGlzdHJpYnV0aW9uLg0KPiA+ICsgKg0KPiA+ICsgKiBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQg
IkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkNCj4gS0lORCwNCj4gPiArICogRVhQUkVT
UyBPUiBJTVBMSUVELCBJTkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRQ0KPiBXQVJSQU5U
SUVTIE9GDQo+ID4gKyAqIE1FUkNIQU5UQUJJTElUWSwgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFS
IFBVUlBPU0UgQU5EDQo+ID4gKyAqIE5PTklORlJJTkdFTUVOVC4gSU4gTk8gRVZFTlQgU0hBTEwg
VEhFIEFVVEhPUlMgT1INCj4gQ09QWVJJR0hUIEhPTERFUlMNCj4gPiArICogQkUgTElBQkxFIEZP
UiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElODQo+IEFO
DQo+ID4gKyAqIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsIEFSSVNJTkcg
RlJPTSwgT1VUIE9GDQo+IE9SIElODQo+ID4gKyAqIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdB
UkUgT1IgVEhFIFVTRSBPUiBPVEhFUiBERUFMSU5HUw0KPiBJTiBUSEUNCj4gPiArICogU09GVFdB
UkUuDQo+ID4gKyAqLw0KPiANCj4gSXMgdGhlIGZ1bGwgbGljZW5zZSBuZWVkZWQgaW4gYWRkaXRp
b24gdG8gdGhlIFNQRFg/DQpUaGUgZmlsZSBjb250YWlucyBjb2RlIHRoYXQgd2FzIHBsYWNlZCBp
biBhIGRpZmZlcmVudCBmaWxlIGFuZCBjb3B5cmlnaHRlZCwgc28gSSBjb3BpZWQNClRoZSBjb3B5
cmlnaHRzIGZyb20gdGhlIG9yaWdpbmFsIGZpbGVzIGJhc2VkIG9uIHRoZSBnaXQgaGlzdG9yeSBv
ZiB0aGUgY29kZSBsaW5lcyBJIGNvcGllZC4NClRoYW5rcywNCk1pY2hhbA0K
