Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7697739
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 12:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfHUKcc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 06:32:32 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28982 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbfHUKcc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 06:32:32 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7LAVGMw024704;
        Wed, 21 Aug 2019 03:32:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=pfpt0818; bh=FhTm5X06EH28Ea1rQ1QqgHjHb5nDBC/95XGNXnoMvDc=;
 b=M/PTlYJ4sl57RjSdAKIF4UDkZ1JEjF7oPHVdTJa3jQPMWl3AjWXPrfsUDv/SWEc9V5hf
 G7wfSlnwdyJO+EBzuuJK0XDotlypBn3YqKLE590zoebV/kQpJxLpbs/dLJfPFhZkxS4b
 DdjWaCl9eZkOTk5ew30sz792UFpaCD3X8K8ZiPLdgn9TX1Ppf9BA/Pr76FHJK/hgUFO6
 v+URVOWAGcSwp7gmG+28lKy4TkTDVrV1LoQxYqkZ92DPiJWYwDwmOpoUKtDZlhtZTmeu
 9CPBwAP6TuQUxSBn42gXI5/HV87w/wehTodzm0MRF5Rb2a3UGiCboZAjnOT9OFXXxJJ5 jg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ugu7fhv8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 03:32:28 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 21 Aug
 2019 03:32:27 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 21 Aug 2019 03:32:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij8TfJdxnlRQykvFMLqe55V8yDa3KFAzyiRkqBaEkdlWonEVoxRWTAjJ5SzgHErCRm84HpOCkZBBlk3/3+icQY6aYZCgOvWXHvAbX3swAIjAdWYUYaaXb/OLXweT7gV0+tksV5yteYTJoSlMnRDcIj1Gp+lN2hsOrX4HKIKcjd/Ev439LP0vce+zWd1J9oi3z+xbtKoXi7RRqx3v1WJafRpLlfyBBk1O2LtFT27Pd7/ms61Qv1eGOUDS0dtw0Aybt9OSlU39fU1LYTpWeHm/OR3v7YaoK/9cpj81l4Gd5vM2S0owL7Ozm0zPOnqlUssBz966cywMx3FPzfbkCrPPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Aobkaj9bRkmrjcrIqFTngIEX256qPRJvrp2boZrg44=;
 b=bG4QIr/9hisz6k/q/AVcQgIUahu7pu4mWipGUt4f+KDTKqpwrhlXIkM5GN+IjuKYMOT5QoeHMHReYH0Bps1kH80YyKDR8WZtIaKiRmPIiRtsDINDO1ydu9z4USGe5RJHMTvLkguU/5TBxzskf4R+S0uC3g3lQ4dUsLLhJpc9bwqoSm/d+aHy6SH2HuNn8tIXlxUG57nsk7jRF0Ula4SD27XLiQ/mO77T/IrdOIaZSP+heLnIV/m4Egkahx+++21zzoYy7S52E1dprn4a0DbbmJm7Pev3c8UikIMt3T2fGP3a5voQPpwc4kjqRVbbp0rGeWjAgnEOnKHACTzAK4xVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Aobkaj9bRkmrjcrIqFTngIEX256qPRJvrp2boZrg44=;
 b=suB9tL4KGsvtkiQGMCCvIQU4Eaj/S6eqCQcds1Nxa6y7+Lo+iKD3v170WI4SPtDWASsXuCqaoxaz0sidCN3332MYpyXFzpZ1ZQtrOH/d+BHYQLkaKpySv5PvLE3zLVPyY7NtcAr7JgTRL5qLtXYTwP6MwIVj3TjnOy3wfXILMqY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3103.namprd18.prod.outlook.com (10.255.86.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 10:32:25 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 10:32:25 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Topic: [PATCH v7 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
Thread-Index: AQHVV1GtVvd83t9SYU+cDjHdgZGzk6cEXE6AgADg6bCAACbRAIAABB0g
Date:   Wed, 21 Aug 2019 10:32:25 +0000
Message-ID: <MN2PR18MB318297E219BB657ED716C3A3A1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <aca72068-1155-6755-4494-0436a5d5a31f@amazon.com>
 <MN2PR18MB31827364A5B64323681D1B4BA1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <cee52133-ae69-3709-6f3c-187382af054f@amazon.com>
In-Reply-To: <cee52133-ae69-3709-6f3c-187382af054f@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3bf97db-393f-404b-e898-08d72622dbf8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(49563074)(7193020);SRVR:MN2PR18MB3103;
x-ms-traffictypediagnostic: MN2PR18MB3103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3103CD063E10847EDEBEFF1BA1AA0@MN2PR18MB3103.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(51914003)(189003)(199004)(13464003)(5024004)(14454004)(71190400001)(86362001)(256004)(71200400001)(11346002)(26005)(476003)(76176011)(446003)(55016002)(486006)(7696005)(52536014)(25786009)(9686003)(3846002)(6116002)(99286004)(186003)(8936002)(4326008)(305945005)(66066001)(53936002)(316002)(478600001)(33656002)(53546011)(6506007)(74316002)(6436002)(102836004)(81166006)(99936001)(7736002)(81156014)(66616009)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(5660300002)(8676002)(2906002)(54906003)(229853002)(6246003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3103;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MATdMzL91Vu4q8M+opip8SqOGQ68NphZMrLzqXmtMFMghXCefa1tku8F9IMEqK23AzCucstf6vYvNd1KJxEe3FXmd774b0Hd2La4ZaUS57xTJDbVZciWgNqPvabalum9sIO6LUwzdlEizb2PttBg7abR3awIDLSdjRD1iQlBP+LWlmov6lc4KKjhLF/WlitbTSHLf8T+s4dIAK+lRQdKzBVX7UqfBqxtC/KduhyMi822VgWQcHD8Ep2ITg4jIeW+6hx3+chJ0ZS+ComZrBTlrQU4raIcNbhDBW3FaOtJb4hs7Z/HZothjRwqhOJIGMCWN6NnDGz57UJ1ZutH3J7mAe0eUrBxnbCD7mcDtxwd36eVZSnW8MnRplGEhplJQd9+U7cnyB+CULInTyK9A6uH1T64iHxmCSkBkJG/ABCvjoQ=
Content-Type: multipart/mixed;
        boundary="_002_MN2PR18MB318297E219BB657ED716C3A3A1AA0MN2PR18MB3182namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bf97db-393f-404b-e898-08d72622dbf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 10:32:25.5611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjR8py+oFUKHyuI1vzIQM98Jv/HrLBNpq9zg4Taqh4/myd5Te+aTXlGWXMlDd5am7pc48cNzHYoVBmZ1N/xCjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3103
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-21_03:2019-08-19,2019-08-21 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--_002_MN2PR18MB318297E219BB657ED716C3A3A1AA0MN2PR18MB3182namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhhbmtzIEdhbCwgDQoNCkkgdGhpbmsgSSBmb3VuZCB0aGUgcHJvYmxlbSBmb3IgdGhlIGlzc3Vl
IGJlbG93LCBhdHRhY2hlZCBhIHBhdGNoIHRoYXQgc2hvdWxkIGJlIGFwcGxpZWQgb24gdG9wIG9m
IHRoZSBzZXJpZXMuIA0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoaXMgZml4ZWQgdGhlIGlzc3Vl
cyB5b3UgYXJlIHNlZWluZy4gDQpJbiBxZWRyIHdlIHdvcmsgd2l0aCBvbmx5IHNpbmdsZSBwYWdl
cywgYW5kIHRoaXMgaXNzdWUgd2lsbCBvbmx5IG9jY3VyIHdpdGggbXVsdGlwbGUgcGFnZXMuIA0K
DQpUaGFua3MsDQpNaWNoYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBHYWwgUHJlc3NtYW4gPGdhbHByZXNzQGFtYXpvbi5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
QXVndXN0IDIxLCAyMDE5IDE6MTUgUE0NCj4gVG86IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9u
QG1hcnZlbGwuY29tPg0KPiBDYzogamdnQHppZXBlLmNhOyBkbGVkZm9yZEByZWRoYXQuY29tOyBB
cmllbCBFbGlvciA8YWVsaW9yQG1hcnZlbGwuY29tPjsNCj4gYm10QHp1cmljaC5pYm0uY29tOyBz
bGV5Ym9AYW1hem9uLmNvbTsgbGVvbkBrZXJuZWwub3JnOyBsaW51eC0NCj4gcmRtYUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyByZG1hLW5leHQgMC83XSBSRE1BL3Fl
ZHI6IFVzZSB0aGUgZG9vcmJlbGwNCj4gb3ZlcmZsb3cgcmVjb3ZlcnkgbWVjaGFuaXNtIGZvciBS
RE1BDQo+IA0KPiBPbiAyMS8wOC8yMDE5IDExOjAzLCBNaWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+
ID4gSGkgR2FsLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcXVpY2sgdGVzdGluZyBhbmQgZmVl
ZGJhY2shDQo+ID4NCj4gPiBDYW4geW91IHNoYXJlIHNvbWUgbW9yZSBpbmZvcm1hdGlvbiBvbiB0
aGUgc2NlbmFyaW8geW91J3JlIHJ1bm5pbmcgPw0KPiANCj4gSXQgaGFwcGVucyBvbiBtb3N0IG9m
IG91ciBhdXRvbWF0ZWQgdGVzdHMuDQo+IEkgcmVwcm9kdWNlIGl0IG1hbnVhbGx5IGJ5IHJ1bm5p
bmcgaWJfc2VuZF97YncsbGF0fSBvdmVyIFNSRC4NCj4gDQo+ID4gRG9lcyB0aGlzIGhhcHBlbiBl
YWNoIHRpbWUgb3IgaW50ZXJtaXR0ZW50bHkgPw0KPiANCj4gSGFwcGVucyBvbiBtb3N0IG9mIHRo
ZSBydW5zLg0KPiANCj4gPiBDYW4geW91IHNlbmQgbWUgeW91ciAuY29uZmlnID8NCj4gDQo+IEF0
dGFjaGVkLg0KPiANCj4gPiBhcmUgeW91IHJ1bm5pbmcgYWdhaW5zIHJkbWEtbmV4dCB0cmVlID8N
Cj4gDQo+IFllcywgY29tbWl0IDc3OTA1Mzc5ZTliMiAoIlJETUEvaG5zOiBSZW1vdmUgdW51c2Vm
dWwgbWVtYmVyIikgd2l0aA0KPiB0aGlzIHNlcmllcyBhcHBsaWVkIG9uIHRvcC4NCj4gDQo+ID4g
Q2FuICB5b3UgcmVwcm9kdWNlIHdpdGggZW5hYmxpbmcgaWJfY29yZSBtb2R1bGUgZHluYW1pYyBk
ZWJ1ZyBvbiA/DQo+IA0KPiBBdHRhY2hlZCBhIGxvZyBvZiBpYl9zZW5kX2J3IHJ1bm5pbmcgd2l0
aCBpYl9jb3JlIGFuZCBpYl91dmVyYnMgZHluYW1pYw0KPiBkZWJ1ZyBlbmFibGVkLg0KPiANCj4g
TGV0IG1lIGtub3cgaWYgdGhlcmUncyBhbnl0aGluZyBlbHNlIEkgY2FuIGRvLg0K

--_002_MN2PR18MB318297E219BB657ED716C3A3A1AA0MN2PR18MB3182namp_
Content-Type: application/octet-stream;
	name="0001-Fix-bad-page-state-output-when-run-with-efa-driver.patch"
Content-Description: 0001-Fix-bad-page-state-output-when-run-with-efa-driver.patch
Content-Disposition: attachment;
	filename="0001-Fix-bad-page-state-output-when-run-with-efa-driver.patch";
	size=940; creation-date="Wed, 21 Aug 2019 10:31:09 GMT";
	modification-date="Wed, 21 Aug 2019 10:27:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzYTA1OTM4ZWFiNGNjY2VjY2U1OGEzODYxOGU5NjIzYzQyNTFhMWJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWwgS2FsZGVyb24gPG1pY2hhbC5rYWxkZXJvbkBtYXJ2
ZWxsLmNvbT4KRGF0ZTogV2VkLCAyMSBBdWcgMjAxOSAxMzoyNjo0MyArMDMwMApTdWJqZWN0OiBb
UEFUQ0hdIEZpeCBiYWQgcGFnZSBzdGF0ZSBvdXRwdXQgd2hlbiBydW4gd2l0aCBlZmEgZHJpdmVy
CgotLS0KIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2liX2NvcmVfdXZlcmJzLmMgfCA1ICsrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2liX2NvcmVfdXZlcmJzLmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9pYl9jb3JlX3V2ZXJicy5jCmluZGV4IGNjZTIwMTcyY2Q3MS4uMzBi
MzZiN2MzMzBjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9pYl9jb3JlX3V2
ZXJicy5jCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2liX2NvcmVfdXZlcmJzLmMKQEAg
LTIyMiw5ICsyMjIsMTAgQEAgdm9pZCByZG1hX3VzZXJfbW1hcF9lbnRyeV9mcmVlKHN0cnVjdCBr
cmVmICprcmVmKQogCQkJICBlbnRyeS0+b2JqLCByZG1hX3VzZXJfbW1hcF9nZXRfa2V5KGVudHJ5
KSwKIAkJCSAgZW50cnktPmFkZHJlc3MsIGVudHJ5LT5sZW5ndGgsIG5wYWdlcyk7CiAKLQkJaWYg
KHVjb250ZXh0LT5kZXZpY2UtPm9wcy5tbWFwX2ZyZWUpCi0JCQl1Y29udGV4dC0+ZGV2aWNlLT5v
cHMubW1hcF9mcmVlKGVudHJ5KTsKIAl9CisJaWYgKHVjb250ZXh0LT5kZXZpY2UtPm9wcy5tbWFw
X2ZyZWUpCisJCXVjb250ZXh0LT5kZXZpY2UtPm9wcy5tbWFwX2ZyZWUoZW50cnkpOworCiAJa2Zy
ZWUoZW50cnkpOwogfQogCi0tIAoyLjE0LjUKCg==

--_002_MN2PR18MB318297E219BB657ED716C3A3A1AA0MN2PR18MB3182namp_--
