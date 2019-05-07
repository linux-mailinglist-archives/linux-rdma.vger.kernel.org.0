Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC5158D8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 07:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfEGFRv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 01:17:51 -0400
Received: from mail-eopbgr760049.outbound.protection.outlook.com ([40.107.76.49]:45488
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbfEGFRv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 01:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuGJ8uavJ/PT9hHqbHv5rxWTGixXoa1FBnB/mFUUjX0=;
 b=nTaEm1JGn+aYrvwyweXD2Kp+wX4PEweuFhSkJ4/6uKnOSFrk7fWRHfJO4PcHw1NUlK6xjbI6SOtYzqInLGtsF/MOfB5bj+xWvwkl7dBh1aP+DABS11H2qWtFodMIMcoqaBDfW+VqOrxtiiZIhXHGVRpY+mMu06wG5RRz0jwIZpQ=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4182.namprd05.prod.outlook.com (52.135.200.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.19; Tue, 7 May 2019 05:17:46 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f0e2:4d9d:b09b:def5%7]) with mapi id 15.20.1878.019; Tue, 7 May 2019
 05:17:46 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@mellanox.com" <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Topic: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Index: AQHVBJQ03rON3H5UMUmK3O/KPKwCrg==
Date:   Tue, 7 May 2019 05:17:45 +0000
Message-ID: <20190507051537.2161-1-aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57a8de1f-958c-43ca-f216-08d6d2ab56c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB4182;
x-ms-traffictypediagnostic: BYAPR05MB4182:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB41824D2DBB40BA8E9A4F3F49C5310@BYAPR05MB4182.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(50226002)(14454004)(966005)(305945005)(8936002)(5660300002)(14444005)(25786009)(66066001)(71190400001)(256004)(8676002)(386003)(2501003)(6506007)(81166006)(7736002)(64756008)(66446008)(66556008)(66476007)(66946007)(478600001)(107886003)(4326008)(102836004)(73956011)(81156014)(53936002)(1076003)(316002)(6116002)(3846002)(99286004)(2906002)(26005)(52116002)(71200400001)(110136005)(68736007)(486006)(6486002)(86362001)(2616005)(36756003)(2201001)(6512007)(6436002)(476003)(186003)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4182;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ByJhciBxISAqRJCcAgIBHXK7JxO2Pue31b6K8X3NPm5yXpjSqVS+PYn6NBlIpKdVLN3pydluFXPwKnyz75ZJlIgAMnoJA6aZZB3sprQKIHqYPoYHiLM3qF3TcM1p6tZCwPLm5+xK07OfuFpuQgAdfInYZMvspDfruG/WwTzBkFMPvx0VxGpLd1EWhosYoWgIlHqeGrJmPH7RlHYhHyXKwb1jbUTJF8pfTLyO5afZ2j4EU7HjQX3fl0fq83kbjyh0BkZ/Vv1BrcTU5hOGg+AmV0qOhESLWh+ldESb+rt3JC8YK9gp/d60ODrC33uGMyS5UCTR+QUZ9BmRVP85UgBEBllQcOgmUSjdzwJQ4aMmKuSKf/REwgTF/BtxLd96h/wPk65xFCZehTM9DDtAiveEhQdSPQo7Qb0qM+WPfzJcznI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a8de1f-958c-43ca-f216-08d6d2ab56c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 05:17:45.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4182
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhpcyBhbGxvd3MgdGhlIG5laWdoYm9yIHRpbWVvdXQgdG8gYmUgY29uZmlndXJlZCB3aGlsZSBi
dWlsZGluZw0KcmRtYS1jb3JlIHVzaW5nIHRoZSBleHRyYSBjbWFrZSBmbGFncy4NCg0KUmV2aWV3
ZWQtYnk6IEpvcmdlbiBIYW5zZW4gPGpoYW5zZW5Adm13YXJlLmNvbT4NClJldmlld2VkLWJ5OiBW
aXNobnUgRGFzYSA8dmRhc2FAdm13YXJlLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFkaXQgUmFuYWRp
dmUgPGFkaXRyQHZtd2FyZS5jb20+DQotLS0NCiBDTWFrZUxpc3RzLnR4dCAgICAgICB8IDYgKysr
KysrDQogYnVpbGRsaWIvY29uZmlnLmguaW4gfCAyICsrDQogbGliaWJ2ZXJicy92ZXJicy5jICAg
fCAxIC0NCiAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
LS0tDQoNCkhlcmUgaXMgdGhlIFBSOg0KaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXJkbWEvcmRt
YS1jb3JlL3B1bGwvNTI0DQoNCi0tLQ0KZGlmZiAtLWdpdCBhL0NNYWtlTGlzdHMudHh0IGIvQ01h
a2VMaXN0cy50eHQNCmluZGV4IGJlYjhmNGVjMTIzOC4uOGRiZGQyYjgwN2Y0IDEwMDY0NA0KLS0t
IGEvQ01ha2VMaXN0cy50eHQNCisrKyBiL0NNYWtlTGlzdHMudHh0DQpAQCAtNDUsNiArNDUsOCBA
QA0KICMgICAtRE5PX1BZVkVSQlM9MSAoZGVmYXVsdCwgYnVpbGQgcHl2ZXJicykNCiAjICAgICAg
SW52b2tlIGN5dGhvbiB0byBidWlsZCBweXZlcmJzLiBVc3VhbGx5IHlvdSB3aWxsIHJ1biB3aXRo
IHRoaXMgb3B0aW9uDQogIyAgICAgIGlzIHNldCwgYnV0IGl0IHdpbGwgYmUgZGlzYWJsZWQgZm9y
IHRyYXZpcyBydW5zLg0KKyMgICAtRE5FSUdIX0dFVF9ERUZBVUxUX1RJTUVPVVRfTVM9MzAwMCAo
ZGVmYXVsdCkNCisjICAgICAgU2V0IHRoZSBkZWZhdWx0IHRpbWVvdXQgZm9yIGxvb2t1cCBvZiBu
ZWlnaGJvciBmb3IgbWFjIGFkZHJlc3MuDQogDQogY21ha2VfbWluaW11bV9yZXF1aXJlZChWRVJT
SU9OIDIuOC4xMSBGQVRBTF9FUlJPUikNCiBwcm9qZWN0KHJkbWEtY29yZSBDKQ0KQEAgLTg0LDYg
Kzg2LDEwIEBAIGlmIChJTl9QTEFDRSkNCiAgIHNldChDTUFLRV9JTlNUQUxMX0lOQ0xVREVESVIg
ImluY2x1ZGUiKQ0KIGVuZGlmKCkNCiANCitpZiAoIiR7TkVJR0hfR0VUX0RFRkFVTFRfVElNRU9V
VF9NU30iIFNUUkVRVUFMICIiKQ0KKyAgc2V0KE5FSUdIX0dFVF9ERUZBVUxUX1RJTUVPVVRfTVMg
MzAwMCkNCitlbmRpZigpDQorDQogaW5jbHVkZShHTlVJbnN0YWxsRGlycykNCiAjIEMgaW5jbHVk
ZSByb290DQogc2V0KEJVSUxEX0lOQ0xVREUgJHtDTUFLRV9CSU5BUllfRElSfS9pbmNsdWRlKQ0K
ZGlmZiAtLWdpdCBhL2J1aWxkbGliL2NvbmZpZy5oLmluIGIvYnVpbGRsaWIvY29uZmlnLmguaW4N
CmluZGV4IDA3NTRkMjQ5NDIzNC4uNTkwZTcwMTYyZDFlIDEwMDY0NA0KLS0tIGEvYnVpbGRsaWIv
Y29uZmlnLmguaW4NCisrKyBiL2J1aWxkbGliL2NvbmZpZy5oLmluDQpAQCAtNjEsNiArNjEsOCBA
QA0KICMgZGVmaW5lIFZFUkJTX1dSSVRFX09OTFkgMA0KICNlbmRpZg0KIA0KKyMgZGVmaW5lIE5F
SUdIX0dFVF9ERUZBVUxUX1RJTUVPVVRfTVMgQE5FSUdIX0dFVF9ERUZBVUxUX1RJTUVPVVRfTVNA
DQorDQogLy8gQ29uZmlndXJhdGlvbiBkZWZhdWx0cw0KIA0KICNkZWZpbmUgSUJBQ01fU0VSVkVS
X01PREVfVU5JWCAwDQpkaWZmIC0tZ2l0IGEvbGliaWJ2ZXJicy92ZXJicy5jIGIvbGliaWJ2ZXJi
cy92ZXJicy5jDQppbmRleCAxNzY2YjlmNTJkMzEuLjJjYWI4NjE4NGUzMiAxMDA2NDQNCi0tLSBh
L2xpYmlidmVyYnMvdmVyYnMuYw0KKysrIGIvbGliaWJ2ZXJicy92ZXJicy5jDQpAQCAtOTY3LDcg
Kzk2Nyw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNyZWF0ZV9wZWVyX2Zyb21fZ2lkKGludCBmYW1p
bHksIHZvaWQgKnJhd19naWQsDQogCXJldHVybiAwOw0KIH0NCiANCi0jZGVmaW5lIE5FSUdIX0dF
VF9ERUZBVUxUX1RJTUVPVVRfTVMgMzAwMA0KIGludCBpYnZfcmVzb2x2ZV9ldGhfbDJfZnJvbV9n
aWQoc3RydWN0IGlidl9jb250ZXh0ICpjb250ZXh0LA0KIAkJCQlzdHJ1Y3QgaWJ2X2FoX2F0dHIg
KmF0dHIsDQogCQkJCXVpbnQ4X3QgZXRoX21hY1tFVEhFUk5FVF9MTF9TSVpFXSwNCi0tIA0KMi4x
Ny4xDQoNCg==
