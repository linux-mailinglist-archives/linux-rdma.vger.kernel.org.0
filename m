Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C3439A17B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 14:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFCMw3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 08:52:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51270 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFCMw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 08:52:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153CoLwe186428;
        Thu, 3 Jun 2021 12:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9u/4BUyYplFdiIybrgGou76J4EPEfuWqZRhN4UcG5D4=;
 b=eZ0y/YNsFX3TjDcCwxDd+kP9GO4Kk6VKQMsm3nR94sM1NhdHWXCSVqP4bWZNQFU1OaEl
 R/II8DKAjt3mLuvdEC0NVuzRX8RpP/Z0+ufmhzVj0K0eye3LJqIEeICiL3AV/t3OrLWi
 krW4CUcl7Sjha3yo0xTnPZwA+ucldn+KEK+YHzJdPUt8NbAtEIP1sqxA8Z6UOf1STXxW
 dCuaoJ/YUqvH1JRSMLAovCUCzuQTyUhFlh00Pq1mqo5e02abHHlsIn4yJ/uXDdmS0IJg
 7vb3Gp2hfN2DYIBTHbs9nQsHrPYxRlWf7grAxLk9EFU9ZAur00H/HevJvxLi8bTHlZql GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ue8pk88w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 12:50:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 153CjTlj010664;
        Thu, 3 Jun 2021 12:50:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 38udeeww4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 12:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi/ZD7IKGHjCj2oZ5ExXq3PxdqvaYJENcpWU6iUnhWWeiAaILoaXp2OoLPI82ZM1dGRuz7kdLTLB1xecQ5X0fT6+xC2GpH1sp2yox50QF3AFH3BWjklYmgUxyXQq3+uPx91Xg5qVbXIi6d7FC6LqO+aTGLfeq+Dm9QbP3krwotalCJVo3iHYKJyV+F+ZsGv6LMr98x0aAl3+9HdJheZCKHeD8tTgpXzkIp5BRKJAzK87AUl8wwlbHLIlbHQnqA1d9UfQNnoMWtWalwskJ1Z+XyqGx1bWP/TM0K2Gdm8KJkZ6CISYo9Rxq6ShHhqjewyeo28JG+EvKJgF+p88Qr7+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u/4BUyYplFdiIybrgGou76J4EPEfuWqZRhN4UcG5D4=;
 b=KYBA2PPsYuoxAmEQIn4Zzu8PCUwa5qO6vcYENOesfTWjgsnvEoopf1GALFFgquIbgx112Ipb8SR/u4JMGMcoAkE+7UHvdf5mSMrq0V8gS3ZnQ6VJAHHbvlKDFmBHU7QZpp+/6mdWXJw/okmGFIHgpRq8o7U7OGvQ/EnJG82XJrQs7D4zp3w+Vx0eeoeNoSVChE19UyKts7PiDvp6PR22JAjmwcsMnuaVmlzqe2RSJp8EqLqIRm8bNFctHdh30kAgDd6nZ3Kd4d7d3AXsUtv3YVj3OMS0uU+dMLQsd+NNj6K2KhMoWwLTMMc1rC602S2SRZL3mXVq4TGAvgTaqfF9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u/4BUyYplFdiIybrgGou76J4EPEfuWqZRhN4UcG5D4=;
 b=J463GePj5461ST1pSRrUKVIHRHSkUtUsqzEVATX6PvE6Us8kDhd8KUgUAA+ft9B9ygkGXx9h4m/kMRvSlUQUK6UT6b9AQB765t5JZWbqzIbWxmX7hGuCBJPawNGV2/17f7waGUp+J/DaDSvEGBZROsh1nrkkxgxxoQ6hhLoQCec=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1430.namprd10.prod.outlook.com (2603:10b6:903:26::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Thu, 3 Jun
 2021 12:50:36 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 12:50:36 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Mark Zhang <markzhang@nvidia.com>
CC:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Thread-Topic: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Thread-Index: AQHXWETJKd1twDrD1UCPHUswQ9RvnasCMmCAgAALLYA=
Date:   Thu, 3 Jun 2021 12:50:36 +0000
Message-ID: <9441568B-DBB7-4C4A-B6E7-5D19912C209E@oracle.com>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-4-anand.a.khoje@oracle.com>
 <1e7ec500-223b-2cf5-9cf4-651e31d7b072@nvidia.com>
In-Reply-To: <1e7ec500-223b-2cf5-9cf4-651e31d7b072@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cda8721-d1b8-4bd9-6a23-08d9268e2f0e
x-ms-traffictypediagnostic: CY4PR10MB1430:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1430101BA07A4E8ADB073254FD3C9@CY4PR10MB1430.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmvRXcpH6kGho7c6bJ/DYabxzKzNx8uBuE4pFNAFLxZmDdyvaNXmTavgaA1OpGnEYgU0vRQHLI3qJFggQaRlc+nbjezw4GnWEEg89p6LCj4U7lUiqZj5eiKGZ5NgaBvQ0XGfxqvm6/dStaTTfVIjqDUbvi2GQoDavC7KmYMfa33L1/j1CxEnOSBSErY6VBduOzWkLrjsmWFyGH7kO3cv7J9bNeMWzLRcbyi2rIb1wyJXz3ge5RIkIxZ4OeGUkXys0r1oAeNeSP5PZAYxXMSJS5ieJo/ZsZ5eM6klLzLsNyjCpNkGctYGX3ySxKd7t3KJ4oPVMKo6cEaVBMVTp3nk1aCxcTznIps5QjfPJhyjsLTNcaa11WAQW2/NN1Q7V6mUDx4yJ8ZSmoyWhd8epHyZKbP/sU/1BhqgNfKicoBTvArFWBncuKAInizTshGfowl2phS9uRt7Vh9HhWvKuGkvL3tEu7VQV0+kwvfg95gvm+2LGJeD2i2YVh1Uy3cenEUpiJynlLwbou17OhVD5/XzaXTcz7TBjh9tEA9JtpPzV0nlkTCcDYcWvH9jNh8wxz6QmpnGNBwyJMfBZZjsLVPCptXGgBWo9mtT9BuHg+9K5TrjybBPhMO5WcuXS2MP06drbdBIMNw/6GCriOiZvjpFIwvIvHS5YkadCVdtqq/UgD8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(186003)(6916009)(6506007)(26005)(4326008)(86362001)(316002)(33656002)(53546011)(6486002)(66574015)(8676002)(36756003)(8936002)(54906003)(83380400001)(478600001)(6512007)(5660300002)(38100700002)(122000001)(66946007)(71200400001)(66556008)(2906002)(66446008)(91956017)(76116006)(66476007)(64756008)(44832011)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wJ6vQaMbc1brLzhvIAgrKxjgqS1DXQE/0NPBE7UDYnmtlntNY8dYUhe9tWwfM4lYXDz4iaX3CJBRuWXP/xtK8ZVJoXnI3Eg3Dyffy+ZpLHmYC4iPBGplcctcJ/22bnQPXPes+tdd3D9W8SU7z+E9qKlL6EKjwofZYbV30hVlafHCNvU3XrI0FUFc7V0o876InxSrkbZKETJDjMqovITXaKxdoA1OkgBHRDqiYVxvwAM1g4tUA1J/FAe3oejxYwAJk9FekFQT4qSakbrD67+byCMOsLPe/mh/CDpaXyM8Xs64Zx2wCrEBEqLzGKaTHe9eqi/4BXLNHsS5KFCmcg6RMNrrpQkK89Ir+Ux/kxSAt2vo1cNL9TPNOYBUHIdTUjnIiHyRrs7FEi4UD2RDUOsRufIo5j2e9TlqKA+mlH2r2JyUPK4dNQSoU7FSA/sEfQtLNeX0g7qkM5BtnTq5c8P11zdCSRf8zPS611b2AM1S2AecF3GTTca6CjQhE+BTxuc1Tt1moNbEJtmw01gdBKRGYBDH86cdwEvbsTkUK5DCTd0SWWdb93LeCO9oAAyo2p/c9qhn4ecvPc+MkgOf4nCgYN3aD24uAtpNAm8WHm0cY2Xc22rDuA9CPGrOWgm4a0thCMV40PKIl4CX39cuZNCs8QUbSJ5n2tmyWpgJFiJKYc3qur4o7l7jVRMrZtBFFrT1k7mx6i+1qmB3IgY5jwkpZ1YFJErtGYGmymihBtix+8HOUZArGgSCbzVkDfQyLrZ7
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E1BD2062C291F4F88D527D74C0EF3FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cda8721-d1b8-4bd9-6a23-08d9268e2f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 12:50:36.5381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmYSuy68bzoI1xeTjkHRqRXfDR67+bAfTXksKG+W/YyD8x6dsiL4OE1Xlq7IxRlDe5tqvunTQ/qirEKLoHNACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1430
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030087
X-Proofpoint-GUID: xAoU5c8VWOFv25XpAXammIr8HNus8tj0
X-Proofpoint-ORIG-GUID: xAoU5c8VWOFv25XpAXammIr8HNus8tj0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030087
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMyBKdW4gMjAyMSwgYXQgMTQ6MTAsIE1hcmsgWmhhbmcgPG1hcmt6aGFuZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIDYvMy8yMDIxIDI6NTAgUE0sIEFuYW5kIEtob2plIHdy
b3RlOg0KPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0
YWNobWVudHMNCj4+IGliX3F1ZXJ5X3BvcnQoKSBjYWxscyBkZXZpY2UtPm9wcy5xdWVyeV9wb3J0
KCkgdG8gZ2V0IHRoZSBwb3J0DQo+PiBhdHRyaWJ1dGVzLiBUaGUgbWV0aG9kIG9mIHF1ZXJ5aW5n
IGlzIGRldmljZSBkcml2ZXIgc3BlY2lmaWMuDQo+PiBUaGUgc2FtZSBmdW5jdGlvbiBjYWxscyBk
ZXZpY2UtPm9wcy5xdWVyeV9naWQoKSB0byBnZXQgdGhlIEdJRCBhbmQNCj4+IGV4dHJhY3QgdGhl
IHN1Ym5ldF9wcmVmaXggKGdpZF9wcmVmaXgpLg0KPj4gVGhlIEdJRCBhbmQgc3VibmV0X3ByZWZp
eCBhcmUgc3RvcmVkIGluIGEgY2FjaGUuIEJ1dCB0aGV5IGRvIG5vdCBnZXQNCj4+IHJlYWQgZnJv
bSB0aGUgY2FjaGUgaWYgdGhlIGRldmljZSBpcyBhbiBJbmZpbmliYW5kIGRldmljZS4gVGhlDQo+
PiBmb2xsb3dpbmcgY2hhbmdlIHRha2VzIGFkdmFudGFnZSBvZiB0aGUgY2FjaGVkIHN1Ym5ldF9w
cmVmaXguDQo+PiBUZXN0aW5nIHdpdGggUkRCTVMgaGFzIHNob3duIGEgc2lnbmlmaWNhbnQgaW1w
cm92ZW1lbnQgaW4gcGVyZm9ybWFuY2UNCj4+IHdpdGggdGhpcyBjaGFuZ2UuDQo+PiBUaGUgZnVu
Y3Rpb24gaWJfY2FjaGVfaXNfaW5pdGlhbGlzZWQoKSBpcyBpbnRyb2R1Y2VkIGJlY2F1c2UNCj4+
IGliX3F1ZXJ5X3BvcnQoKSBnZXRzIGNhbGxlZCBlYXJseSBpbiB0aGUgc3RhZ2Ugd2hlbiB0aGUg
Y2FjaGUgaXMgbm90DQo+PiBidWlsdCB3aGlsZSByZWFkaW5nIHBvcnQgaW1tdXRhYmxlIHByb3Bl
cnR5Lg0KPj4gSW4gdGhhdCBjYXNlLCB0aGUgZGVmYXVsdCBHSUQgc3RpbGwgZ2V0cyByZWFkIGZy
b20gSENBIGZvciBJQiBsaW5rLQ0KPj4gbGF5ZXIgZGV2aWNlcy4NCj4+IEZpeGVzOiBmYWQ2MWFk
ICgiSUIvY29yZTogQWRkIHN1Ym5ldCBwcmVmaXggdG8gcG9ydCBpbmZvIikNCj4+IFNpZ25lZC1v
ZmYtYnk6IEFuYW5kIEtob2plIDxhbmFuZC5hLmtob2plQG9yYWNsZS5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4gLS0tDQo+
PiAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYyAgfCA3ICsrKysrKy0NCj4+ICBkcml2
ZXJzL2luZmluaWJhbmQvY29yZS9kZXZpY2UuYyB8IDkgKysrKysrKysrDQo+PiAgaW5jbHVkZS9y
ZG1hL2liX2NhY2hlLmggICAgICAgICAgfCA2ICsrKysrKw0KPj4gIGluY2x1ZGUvcmRtYS9pYl92
ZXJicy5oICAgICAgICAgIHwgNiArKysrKysNCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvY29yZS9jYWNoZS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYw0KPj4gaW5k
ZXggYjY3MDBhZC4uNzI0YWMwZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9j
b3JlL2NhY2hlLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4+
IEBAIC0xNjI0LDYgKzE2MjQsOCBAQCBpbnQgaWJfY2FjaGVfc2V0dXBfb25lKHN0cnVjdCBpYl9k
ZXZpY2UgKmRldmljZSkNCj4+ICAgICAgICAgICAgICAgICBlcnIgPSBpYl9jYWNoZV91cGRhdGUo
ZGV2aWNlLCBwLCB0cnVlKTsNCj4+ICAgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+ICsgICAgICAgICAgICAgICBzZXRfYml0
KElCX1BPUlRfQ0FDSEVfSU5JVElBTElaRUQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAm
ZGV2aWNlLT5wb3J0X2RhdGFbcF0uZmxhZ3MpOw0KPj4gICAgICAgICB9DQo+PiAgICAgICAgIHJl
dHVybiAwOw0KPj4gQEAgLTE2MzksOCArMTY0MSwxMSBAQCB2b2lkIGliX2NhY2hlX3JlbGVhc2Vf
b25lKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSkNCj4+ICAgICAgICAgICogYWxsIHRoZSBkZXZp
Y2UncyByZXNvdXJjZXMgd2hlbiB0aGUgY2FjaGUgY291bGQgbm8NCj4+ICAgICAgICAgICogbG9u
Z2VyIGJlIGFjY2Vzc2VkLg0KPj4gICAgICAgICAgKi8NCj4+IC0gICAgICAgcmRtYV9mb3JfZWFj
aF9wb3J0IChkZXZpY2UsIHApDQo+PiArICAgICAgIHJkbWFfZm9yX2VhY2hfcG9ydCAoZGV2aWNl
LCBwKSB7DQo+PiArICAgICAgICAgICAgICAgY2xlYXJfYml0KElCX1BPUlRfQ0FDSEVfSU5JVElB
TElaRUQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgJmRldmljZS0+cG9ydF9kYXRhW3Bd
LmZsYWdzKTsNCj4+ICAgICAgICAgICAgICAgICBrZnJlZShkZXZpY2UtPnBvcnRfZGF0YVtwXS5j
YWNoZS5wa2V5KTsNCj4+ICsgICAgICAgfQ0KPj4gICAgICAgICBnaWRfdGFibGVfcmVsZWFzZV9v
bmUoZGV2aWNlKTsNCj4+ICB9DQo+IA0KPiBEbyB3ZSBuZWVkIHRvIGNsZWFyIGl0IGluIGdpZF90
YWJsZV9jbGVhbnVwX29uZSgpPw0KDQpHb29kIHBvaW50LiBJcyBpdCBmZWFzaWJsZSB0aGF0IGli
X3F1ZXJ5X3BvcnQoKSBjYW4gYmUgY2FsbGVkIG9uIGEgZGV2aWNlIHRoYXQgaGFzIGJlZW4gcmVt
b3ZlZD8gSWYgeWVzLCB3ZSBuZWVkIGl0IGluIGdpZF90YWJsZV9jbGVhbnVwX29uZSgpIGFzIHdl
bGwuDQoNCg0KVGh4cywgSMOla29uDQoNCg0K
