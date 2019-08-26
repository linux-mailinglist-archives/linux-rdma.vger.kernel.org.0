Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9889CBD3
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfHZImZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 04:42:25 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:64940 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfHZImZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 04:42:25 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7Q8ekxt031271;
        Mon, 26 Aug 2019 01:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fyn4aRJgk8FstC5C6CochxGv9Bj2yOktob7V4S8+Slg=;
 b=nmEoU4lYMIe4p0TBAYA33sWY9xfxA9Le0cVnuKS4UilfZiYkwiGtOpIjBBY2Sr73QzCZ
 SFWGBKRKaadDYKgXziiBH+TneQ4uXPCzoy26G0XUkB8m9yu+9Dhdbq5q3nJ86UPTnnCj
 wtMSsxbQPveCMBl61nOhWs2vJCjU8JyD0DOAqMyjlNEQI1z6IrJKhdFC842GYR2Xv8f4
 p2KI3CsapXiipRt+pe0lunMb66bXmkZfBsAWKDn4ExSA2o7LuJacjfl9wR4qYgaQOPZh
 t6HS4RStPpue82fXBEXm8UII9geQXwLdxpNu3XDcPOFECBjNiWPXRHsGI8AVoC/AwbUk Yg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkdx2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 01:42:20 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 26 Aug
 2019 01:42:17 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 01:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfcgKkMjpAPc8iLBbWCSBfMmGqsw7+rovTguffN8e20BKfCN+S8ZGGcA4E+tyn5zLHfsuc9WGtVIuVPUz0YC/CHxh483WWi7EucTRW95DU79E1B+Z7eN1F0zBuM4ekrTl9Z85J6vlCVti1yAIOYS9dD83KnThkCRil5dfkBkL2tJ2fVEY72QGJ8aTC1aNffz+GRBxzydCKapNOD8fTrkAvjhp592WA/HiSPG9zII8aby3becRunSvIrEisFhNYbhcL9v9TKEP4Hh3QD2YKGpeWw4dT57FTKBv4kEO89hhPsyp4bfRooYRT3ZEvkc12HvF1tmbC2s+6Wuxv69kqMsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyn4aRJgk8FstC5C6CochxGv9Bj2yOktob7V4S8+Slg=;
 b=YACfCQ30mhTcp9C6EjibYrtBNS4Q3iNNMFPuHxo/d8DKdOmfa5Mg1ZdRzsKNQuRt8Z/t2KE8JqTijJOAAL7Omkv8fgGrT4arb2XJy8stxFYevz3UmZQj0FSYzGyDjw3TPfboIjvPwAWGdLt+jzFt70A6YqsEj2g6Np3j+xIP55ZJhpxtMlwSC9IGSEU6eePKxL50IxXLpH1aR/eOD+vxSCZe6iO/cByRxWkqg30Fk7HhxYO3sZn5fbwS6/cvpbFNZ0XL1J2PL5el20F+ciLg4JK5YKEOnyRYihCvL5tMs8QjgASz1kkeF0hox/hL++WNUOUfTiKiwx9tlf1iQbCgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyn4aRJgk8FstC5C6CochxGv9Bj2yOktob7V4S8+Slg=;
 b=v1ILP6RmET12dkbTwWx6Nye0ezEL0DnzU9DB45lMHNhMOaxIouNz6YK5dFy4hty/cQKdoiRrXgH46LVhyxW5y2cFUp9ahJdHIImQEfcjSSgx9zcWNuZzZUpkSmOWwS/IzgkkSsg/IsCPNoRbT6WqC/8a6V7MjtbvjolOYlj3YQE=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3294.namprd18.prod.outlook.com (10.255.237.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 08:42:16 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2199.020; Mon, 26 Aug 2019
 08:42:16 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v7 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
Thread-Topic: [PATCH v7 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Index: AQHVV1G0UqvJfIfy/UuL/2jQOdB1iacHKZyAgARoUsCAACPVgIABb+Fw
Date:   Mon, 26 Aug 2019 08:42:16 +0000
Message-ID: <MN2PR18MB318282142201FDFC9E318398A1A10@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-4-michal.kalderon@marvell.com>
 <6f524e9e-b866-d538-3dc9-322aa4e30b5f@amazon.com>
 <MN2PR18MB3182C05D896D4FCA5CC86019A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
 <942f87b9-53dd-88ff-9045-2f3de7cc719c@amazon.com>
In-Reply-To: <942f87b9-53dd-88ff-9045-2f3de7cc719c@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab270176-85c7-41e6-c794-08d72a014cbd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3294;
x-ms-traffictypediagnostic: MN2PR18MB3294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB329440B4EECD7E357576515AA1A10@MN2PR18MB3294.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(51444003)(199004)(189003)(6506007)(6916009)(6246003)(11346002)(76176011)(6436002)(25786009)(52536014)(4326008)(5660300002)(446003)(86362001)(486006)(33656002)(99286004)(71190400001)(55016002)(476003)(2906002)(53936002)(9686003)(7696005)(256004)(66066001)(8936002)(8676002)(81156014)(81166006)(54906003)(71200400001)(76116006)(26005)(66446008)(64756008)(66556008)(66476007)(74316002)(7736002)(6116002)(305945005)(3846002)(14454004)(53546011)(102836004)(478600001)(186003)(229853002)(66946007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3294;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SE4f8gB/o0+dbU2w7QsjAvJPP+xh+ob4vyXW6flhrbBQS4DdC3JoHgsyescHwCAT5OTQmqKpDd0PEFrLhKKkXq/EeFurRJQi6NNV9Xk6lUm1Po5bARozg8mL1SHseX5B2FtYe3XOpmdbHTPpTqP/QDhlLBkFqX937CVlijV9Vi0lzLhKFy4JRx18TiU89lyREZG2TIOSu/Xcu3ERR76ZhBsa8NyGhoMnPJWTQWEqnh7msKEJUD0WUxGYgwW0dX/b7tBpIW1YcxEZvP8sicgMJLmZeh/fYGKQNN42bpT/Xj8g3dsm/HfqnspMRtAu9WnVFIDlyvPsZxuS1u1cBKg6RlRqZeVzeTCvSuk1dnhZ6LQrOlYFuPM84G3u4sgP2PgWri290M7WgntS/XFtVS3k1moLYEAnmRBhAsD8Fi1TU7M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab270176-85c7-41e6-c794-08d72a014cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 08:42:16.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4z+PzmevlkmOLExDHOdxL9n3CiqWmapIF4X7g6TFUMQ5P3ZSORZnGrWse0ItozOwmrNiMeQBA4fE+ixvZ4xbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3294
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_05:2019-08-23,2019-08-26 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFN1bmRh
eSwgQXVndXN0IDI1LCAyMDE5IDE6NDUgUE0NCj4gDQo+IE9uIDI1LzA4LzIwMTkgMTE6NDEsIE1p
Y2hhbCBLYWxkZXJvbiB3cm90ZToNCj4gPj4+IEBAIC01MTUsNDYgKzQwOCw1NSBAQCBzdGF0aWMg
aW50IHFwX21tYXBfZW50cmllc19zZXR1cChzdHJ1Y3QNCj4gZWZhX3FwDQo+ID4+ICpxcCwNCj4g
Pj4+ICAJCQkJIHN0cnVjdCBlZmFfY29tX2NyZWF0ZV9xcF9wYXJhbXMNCj4gPj4gKnBhcmFtcywN
Cj4gPj4+ICAJCQkJIHN0cnVjdCBlZmFfaWJ2X2NyZWF0ZV9xcF9yZXNwICpyZXNwKSAgew0KPiA+
Pj4gKwl1NjQgYWRkcmVzczsNCj4gPj4+ICsJdTY0IGxlbmd0aDsNCj4gPj4+ICsNCj4gPj4+ICAJ
LyoNCj4gPj4+ICAJICogT25jZSBhbiBlbnRyeSBpcyBpbnNlcnRlZCBpdCBtaWdodCBiZSBtbWFw
cGVkLCBoZW5jZSBjYW5ub3QgYmUNCj4gPj4+ICAJICogY2xlYW5lZCB1cCB1bnRpbCBkZWFsbG9j
X3Vjb250ZXh0Lg0KPiA+Pj4gIAkgKi8NCj4gPj4+ICAJcmVzcC0+c3FfZGJfbW1hcF9rZXkgPQ0K
PiA+Pg0KPiA+PiBOb3QgYSBiaWcgZGVhbCwgYnV0IG5vdyBpdCBtYWtlcyBtb3JlIHNlbnNlIHRv
IGFzc2lnbiBxcC0NCj4gPj4+IHNxX2RiX21tYXBfa2V5IGFuZCBhc3NpZ24gdGhlIHJlc3BvbnNl
IGxhdGVyIG9uLg0KPiA+IG9rDQo+ID4+DQo+ID4+PiAtCQltbWFwX2VudHJ5X2luc2VydChkZXYs
IHVjb250ZXh0LCBxcCwNCj4gPj4+IC0JCQkJICBkZXYtPmRiX2Jhcl9hZGRyICsgcmVzcC0+c3Ff
ZGJfb2Zmc2V0LA0KPiA+Pj4gLQkJCQkgIFBBR0VfU0laRSwgRUZBX01NQVBfSU9fTkMpOw0KPiA+
Pj4gLQlpZiAocmVzcC0+c3FfZGJfbW1hcF9rZXkgPT0gRUZBX01NQVBfSU5WQUxJRCkNCj4gPj4+
ICsJCXJkbWFfdXNlcl9tbWFwX2VudHJ5X2luc2VydCgmdWNvbnRleHQtPmlidWNvbnRleHQsIHFw
LA0KPiA+Pj4gKwkJCQkJICAgIGRldi0+ZGJfYmFyX2FkZHIgKw0KPiA+Pj4gKwkJCQkJICAgIHJl
c3AtPnNxX2RiX29mZnNldCwNCj4gPj4+ICsJCQkJCSAgICBQQUdFX1NJWkUsIEVGQV9NTUFQX0lP
X05DKTsNCj4gPj4+ICsJaWYgKHJlc3AtPnNxX2RiX21tYXBfa2V5ID09IFJETUFfVVNFUl9NTUFQ
X0lOVkFMSUQpDQo+ID4+PiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPj4+IC0NCj4gPj4+ICsJcXAt
PnNxX2RiX21tYXBfa2V5ID0gcmVzcC0+c3FfZGJfbW1hcF9rZXk7DQo+ID4+PiAgCXJlc3AtPnNx
X2RiX29mZnNldCAmPSB+UEFHRV9NQVNLOw0KPiA+Pj4NCj4gPj4+ICsJYWRkcmVzcyA9IGRldi0+
bWVtX2Jhcl9hZGRyICsgcmVzcC0+bGxxX2Rlc2Nfb2Zmc2V0Ow0KPiA+Pj4gKwlsZW5ndGggPSBQ
QUdFX0FMSUdOKHBhcmFtcy0+c3FfcmluZ19zaXplX2luX2J5dGVzICsNCj4gPj4+ICsJCQkgICAg
KHJlc3AtPmxscV9kZXNjX29mZnNldCAmIH5QQUdFX01BU0spKTsNCj4gPj4+ICAJcmVzcC0+bGxx
X2Rlc2NfbW1hcF9rZXkgPQ0KPiA+Pj4gLQkJbW1hcF9lbnRyeV9pbnNlcnQoZGV2LCB1Y29udGV4
dCwgcXAsDQo+ID4+PiAtCQkJCSAgZGV2LT5tZW1fYmFyX2FkZHIgKyByZXNwLQ0KPiA+Pj4gbGxx
X2Rlc2Nfb2Zmc2V0LA0KPiA+Pj4gLQkJCQkgIFBBR0VfQUxJR04ocGFyYW1zLQ0KPiA+Pj4gc3Ff
cmluZ19zaXplX2luX2J5dGVzICsNCj4gPj4+IC0JCQkJCSAgICAgKHJlc3AtPmxscV9kZXNjX29m
ZnNldCAmDQo+ID4+IH5QQUdFX01BU0spKSwNCj4gPj4+IC0JCQkJICBFRkFfTU1BUF9JT19XQyk7
DQo+ID4+PiAtCWlmIChyZXNwLT5sbHFfZGVzY19tbWFwX2tleSA9PSBFRkFfTU1BUF9JTlZBTElE
KQ0KPiA+Pj4gKwkJcmRtYV91c2VyX21tYXBfZW50cnlfaW5zZXJ0KCZ1Y29udGV4dC0+aWJ1Y29u
dGV4dCwgcXAsDQo+ID4+PiArCQkJCQkgICAgYWRkcmVzcywNCj4gPj4+ICsJCQkJCSAgICBsZW5n
dGgsDQo+ID4+PiArCQkJCQkgICAgRUZBX01NQVBfSU9fV0MpOw0KPiA+Pj4gKwlpZiAocmVzcC0+
bGxxX2Rlc2NfbW1hcF9rZXkgPT0gUkRNQV9VU0VSX01NQVBfSU5WQUxJRCkNCj4gPj4+ICAJCXJl
dHVybiAtRU5PTUVNOw0KPiA+Pj4gLQ0KPiA+Pj4gKwlxcC0+bGxxX2Rlc2NfbW1hcF9rZXkgPSBy
ZXNwLT5sbHFfZGVzY19tbWFwX2tleTsNCj4gPj4+ICAJcmVzcC0+bGxxX2Rlc2Nfb2Zmc2V0ICY9
IH5QQUdFX01BU0s7DQo+ID4+Pg0KPiA+Pj4gIAlpZiAocXAtPnJxX3NpemUpIHsNCj4gPj4+ICsJ
CWFkZHJlc3MgPSBkZXYtPmRiX2Jhcl9hZGRyICsgcmVzcC0+cnFfZGJfb2Zmc2V0Ow0KPiA+Pj4g
IAkJcmVzcC0+cnFfZGJfbW1hcF9rZXkgPQ0KPiA+Pj4gLQkJCW1tYXBfZW50cnlfaW5zZXJ0KGRl
diwgdWNvbnRleHQsIHFwLA0KPiA+Pj4gLQkJCQkJICBkZXYtPmRiX2Jhcl9hZGRyICsgcmVzcC0N
Cj4gPj4+IHJxX2RiX29mZnNldCwNCj4gPj4+IC0JCQkJCSAgUEFHRV9TSVpFLCBFRkFfTU1BUF9J
T19OQyk7DQo+ID4+PiAtCQlpZiAocmVzcC0+cnFfZGJfbW1hcF9rZXkgPT0gRUZBX01NQVBfSU5W
QUxJRCkNCj4gPj4+ICsJCQlyZG1hX3VzZXJfbW1hcF9lbnRyeV9pbnNlcnQoJnVjb250ZXh0LQ0K
PiA+Pj4gaWJ1Y29udGV4dCwgcXAsDQo+ID4+PiArCQkJCQkJICAgIGFkZHJlc3MsIFBBR0VfU0la
RSwNCj4gPj4+ICsJCQkJCQkgICAgRUZBX01NQVBfSU9fTkMpOw0KPiA+Pj4gKwkJaWYgKHJlc3At
PnJxX2RiX21tYXBfa2V5ID09DQo+ID4+IFJETUFfVVNFUl9NTUFQX0lOVkFMSUQpDQo+ID4+PiAg
CQkJcmV0dXJuIC1FTk9NRU07DQo+ID4+PiAtDQo+ID4+PiArCQlxcC0+cnFfZGJfbW1hcF9rZXkg
PSByZXNwLT5ycV9kYl9tbWFwX2tleTsNCj4gPj4+ICAJCXJlc3AtPnJxX2RiX29mZnNldCAmPSB+
UEFHRV9NQVNLOw0KPiA+Pj4NCj4gPj4+ICsJCWFkZHJlc3MgPSB2aXJ0X3RvX3BoeXMocXAtPnJx
X2NwdV9hZGRyKTsNCj4gPj4+ICAJCXJlc3AtPnJxX21tYXBfa2V5ID0NCj4gPj4+IC0JCQltbWFw
X2VudHJ5X2luc2VydChkZXYsIHVjb250ZXh0LCBxcCwNCj4gPj4+IC0JCQkJCSAgdmlydF90b19w
aHlzKHFwLT5ycV9jcHVfYWRkciksDQo+ID4+PiAtCQkJCQkgIHFwLT5ycV9zaXplLA0KPiA+PiBF
RkFfTU1BUF9ETUFfUEFHRSk7DQo+ID4+PiAtCQlpZiAocmVzcC0+cnFfbW1hcF9rZXkgPT0gRUZB
X01NQVBfSU5WQUxJRCkNCj4gPj4+ICsJCQlyZG1hX3VzZXJfbW1hcF9lbnRyeV9pbnNlcnQoJnVj
b250ZXh0LQ0KPiA+Pj4gaWJ1Y29udGV4dCwgcXAsDQo+ID4+PiArCQkJCQkJICAgIGFkZHJlc3Ms
IHFwLT5ycV9zaXplLA0KPiA+Pj4gKwkJCQkJCSAgICBFRkFfTU1BUF9ETUFfUEFHRSk7DQo+ID4+
PiArCQlpZiAocmVzcC0+cnFfbW1hcF9rZXkgPT0gUkRNQV9VU0VSX01NQVBfSU5WQUxJRCkNCj4g
Pj4+ICAJCQlyZXR1cm4gLUVOT01FTTsNCj4gPj4+ICsJCXFwLT5ycV9tbWFwX2tleSA9IHJlc3At
PnJxX21tYXBfa2V5Ow0KPiA+Pj4NCj4gPj4+ICAJCXJlc3AtPnJxX21tYXBfc2l6ZSA9IHFwLT5y
cV9zaXplOw0KPiA+Pj4gIAl9DQo+ID4+PiBAQCAtNzc1LDYgKzY3Nyw5IEBAIHN0cnVjdCBpYl9x
cCAqZWZhX2NyZWF0ZV9xcChzdHJ1Y3QgaWJfcGQgKmlicGQsDQo+ID4+PiAgCQkJCSBETUFfVE9f
REVWSUNFKTsNCj4gPj4+ICAJCWlmICghcnFfZW50cnlfaW5zZXJ0ZWQpDQo+ID4+DQo+ID4+IE5v
dyB0aGF0IHdlIHN0b3JlIHRoZSBrZXlzIG9uIHRoZSBRUCBvYmplY3Qgd2UgY2FuIHJlbW92ZSB0
aGUNCj4gPj4gcnFfZW50cnlfaW5zZXJ0ZWQgdmFyaWFibGUgYW5kIHRlc3QgZm9yICFxcC0+cnFf
bW1hcF9rZXkuDQo+ID4gb2sNCj4gPj4NCj4gPj4+ICAJCQlmcmVlX3BhZ2VzX2V4YWN0KHFwLT5y
cV9jcHVfYWRkciwgcXAtPnJxX3NpemUpOw0KPiA+Pj4gKwkJZWxzZQ0KPiA+Pj4gKwkJCXJkbWFf
dXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmdWNvbnRleHQtDQo+ID4+PiBpYnVjb250ZXh0LA0KPiA+
Pj4gKwkJCQkJCSAgICBxcC0+cnFfbW1hcF9rZXkpOw0KPiA+Pg0KPiA+PiBPdGhlciBlbnRyaWVz
IG5lZWQgdG8gYmUgcmVtb3ZlZCBhcyB3ZWxsLCBvdGhlcndpc2UgdGhlIHJlZmNvdW50DQo+ID4+
IHdvbid0IHJlYWNoIHplcm8uIFRoaXMgZXJyb3IgZmxvdyBzaG91bGQgbm93IGJlIHNpbWlsYXIg
dG8NCj4gPj4gZWZhX2Rlc3Ryb3lfcXAuIEkgdGhpbmsgdGhhdCBtZWFucyBsb3NpbmcgdGhlIGZy
ZWVfcGFnZXNfZXhhY3QgdG9vLg0KPiA+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCwgaG93IGNhbiB3
ZSBsb29zZSB0aGUgZnJlZV9wYWdlc19leGFjdCA/IGlmIHRoZQ0KPiA+IGVudHJ5IHdhc27igJl0
IEluc2VydGVkIGludG8gdGhlIG1tYXBfeGEgd2hhdCBmbG93IHdpbGwgZnJlZSB0aGUgcGFnZXMg
Pw0KPiANCj4gWW91J3JlIHJpZ2h0Lg0KPiBTdGlsbCBuZWVkIHRvIHJlbW92ZSBvdGhlciBlbnRy
aWVzIHRob3VnaC4NCnN1cmUsIHRoYW5rcw0K
