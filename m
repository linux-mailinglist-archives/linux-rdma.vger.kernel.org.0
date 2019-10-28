Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5AE794C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfJ1ThR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 15:37:17 -0400
Received: from mail-eopbgr730084.outbound.protection.outlook.com ([40.107.73.84]:6304
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731026AbfJ1ThR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 15:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7psEoJURH1QEZpnhb/XRs2R42Hg9YScf0+Ev307QlLxMAif2igONxaxmyM29z6E7B5vOBmT25ZH2BYJSix9KGvaqLn4O6W2Om7K1iKwZ1vqIqF7ed5lgpOcKp4QOlwZG3U24JQXeurM8WRQTelJ6MMo2J0xOGIXfwMX1c3uIZdLGDTjJIDnspsDA7n+N3Mh4vLemSS5HD3xu7KakuvUochpbcQJX6Bu8J/Kwl+SIvcJ6OIjeAR8F+0HEEt3nzAeWYCuXu9J5Sc9jU2ONykUOxgZJ0KuwMBhi4MwTfLyMJQfCy2qQD5Axjri8bDX2p+TN7a7vBFOcXtafDkQfoak6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTfuAPwA6XA7WfAlPhCbQ0nSQJPwp1WzaJ38BO5cdG8=;
 b=K1hLl8j4hPdqxZGspyzfdjxg9RMMdVTFVYkahPkFXfUwmESaUzkK8m97JsGqn6GBo9QWwDhMcQmTOcZj8keaWb0vk8wj1W87Szgsf4LD2qH8Ssrb9VcPbnMHOKMx51YodS/ssioXFGUNponVZ0kNzOK4D8f1lhzxQzAV0Ham+5dDmWRWU/+GJ37uYBYGxPwCtt+Zcdd4miZ9XpnufOFZ54do5Nqy8y4+sijpxQf8WBA9gout9+QVY68sq5eW3fIPPiK0d5q+uEMXKVgYXIETNVDcbGq7FyCrXTNH+hOIVcob2mrxNF+dRsicNygEbzWi/+djsBJqH5084a0OPxriSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTfuAPwA6XA7WfAlPhCbQ0nSQJPwp1WzaJ38BO5cdG8=;
 b=EfyKLx93UcAPmAZhVJyr4sXGGAQSdu1C7uEoAHUX1aANWAPgXgEx6ND5i52e8Ot/IrRuVOWn3a/vJA74nXL6k1rMKLHa2XBTu7lrwrYuIqLH5lB8Gns/f7tjUHpGLx7HlmAVi4ynFwFsPk567J3xRgAjUSYyyZ1fyVaoP4v+4DE=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4968.namprd05.prod.outlook.com (20.177.230.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.15; Mon, 28 Oct 2019 19:37:13 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::f149:5b68:407b:e494%3]) with mapi id 15.20.2408.012; Mon, 28 Oct 2019
 19:37:13 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH v3 for-next] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Topic: [PATCH v3 for-next] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHVjbuXeycPE9XXtU+zc/m6Wa7saqdwarqAgAAH0QA=
Date:   Mon, 28 Oct 2019 19:37:13 +0000
Message-ID: <186ed369-a029-30c5-e983-8de96b579389@vmware.com>
References: <20191028181444.19448-1-aditr@vmware.com>
 <20191028190835.GZ22766@mellanox.com>
In-Reply-To: <20191028190835.GZ22766@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d81e3ed6-8ec2-4830-a0b7-08d75bde3b33
x-ms-traffictypediagnostic: BYAPR05MB4968:|BYAPR05MB4968:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4968F79BB3C7E6D4D7023AFFC5660@BYAPR05MB4968.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(189003)(199004)(81166006)(6246003)(8936002)(81156014)(7736002)(31686004)(6916009)(86362001)(305945005)(8676002)(54906003)(14454004)(107886003)(71190400001)(102836004)(256004)(4326008)(316002)(36756003)(25786009)(478600001)(486006)(3846002)(52116002)(6116002)(6486002)(5660300002)(229853002)(6436002)(26005)(4744005)(99286004)(76176011)(2906002)(66066001)(31696002)(66476007)(66556008)(64756008)(66446008)(66946007)(386003)(53546011)(11346002)(186003)(6506007)(2616005)(476003)(6512007)(446003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4968;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rhKEWQc5SB0x33mlMRsmOrg0keV4kOIFD36W67vHtoTeXkjfjQidREWQzPYQZ188q73JW0KBEpMpAXZ8YiXcZReFiAwyBXxq6QwXVMK/bNbiKfSA4XnrbTWNO/uISXJwZJ9U8VkBlbK3h1wAX82JRyfulQmle7U/gAlE575WgF65j5yS4vFmvBb9M7PQsuSYpiNPfBBZKzGMYjn66R8AF5IEVxRa2RPWLqJWBarI0tiH5WGMS5GcYLQkU69kGP6Pydc/8NUViJzYTt9eve7z9Xd/YzSY4KRYq8s1lO1KuphTTKPDRG0oRP0d8YFNmtJ9r8AHZftCVmAmyb90xlc31qxvvyKjPNejLaX9qVM2uDdCK+hVYctyFhh97x02xsK7Slgk+yH0sX2/1EI9r2g3jvrOUc6WdDpVeFtbyQBHx9zgUWLEAxJXJKvrZ2Lgd9vb
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7C25DC122CB664097BF3723D629FE45@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81e3ed6-8ec2-4830-a0b7-08d75bde3b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 19:37:13.4028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7PSMad8CXlz0IaACFyWrlG27Fl+BP4tEMPd8zPVL5FSkQXPOzrq9BunWt1V5s7b9AMvqksMZ2IIE4J+tRl2yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4968
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTAvMjgvMTkgMTI6MDggUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gTW9uLCBP
Y3QgMjgsIDIwMTkgYXQgMDY6MTQ6NTJQTSArMDAwMCwgQWRpdCBSYW5hZGl2ZSB3cm90ZToNCj4+
ICANCj4+ICsJaWYgKCFxcC0+aXNfa2VybmVsKSB7DQo+PiArCQlpZiAodWRhdGEtPm91dGxlbiA+
PSBzaXplb2YocXBfcmVzcCkpIHsNCj4+ICsJCQlxcF9yZXNwLnFwbiA9IHFwLT5pYnFwLnFwX251
bTsNCj4+ICsJCQlxcF9yZXNwLnFwX2hhbmRsZSA9IHFwLT5xcF9oYW5kbGU7DQo+PiArDQo+PiAr
CQkJaWYgKGliX2NvcHlfdG9fdWRhdGEodWRhdGEsICZxcF9yZXNwLA0KPj4gKwkJCQkJICAgICBt
aW4odWRhdGEtPm91dGxlbiwNCj4+ICsJCQkJCQkgc2l6ZW9mKHFwX3Jlc3ApKSkpIHsNCj4+ICsJ
CQkJZGV2X3dhcm4oJmRldi0+cGRldi0+ZGV2LA0KPj4gKwkJCQkJICJmYWlsZWQgdG8gY29weSBi
YWNrIHVkYXRhXG4iKTsNCj4+ICsJCQkJX19wdnJkbWFfZGVzdHJveV9xcChkZXYsIHFwKTsNCj4+
ICsJCQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+PiArCQkJfQ0KPj4gKwkJfQ0KPj4gKwl9
DQo+IA0KPiBUaGlzIGlzIGp1c3Qgc3VwcG9zZWQgdG8gYmUgbGlrZSB0aGlzOg0KPiANCj4gKyAg
ICAgICBpZiAodWRhdGEpIHsNCj4gKyAgICAgICAgICAgICAgIHFwX3Jlc3AucXBuID0gcXAtPmli
cXAucXBfbnVtOw0KPiArICAgICAgICAgICAgICAgcXBfcmVzcC5xcF9oYW5kbGUgPSBxcC0+cXBf
aGFuZGxlOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoaWJfY29weV90b191ZGF0YSh1ZGF0
YSwgJnFwX3Jlc3AsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtaW4o
dWRhdGEtPm91dGxlbiwgc2l6ZW9mKHFwX3Jlc3ApKSkpIHsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZGV2X3dhcm4oJmRldi0+cGRldi0+ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAiZmFpbGVkIHRvIGNvcHkgYmFjayB1ZGF0YVxuIik7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIF9fcHZyZG1hX2Rlc3Ryb3lfcXAoZGV2LCBxcCk7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiANCj4gDQo+IEkgZml4ZWQg
aXQNCj4gDQo+IEFwcGxpZWQgdG8gZm9yLW5leHQNCj4gDQoNCk1ha2VzIHNlbnNlLiBUaGFua3Mh
DQoNCj4gVGhhbmtzLA0KPiBKYXNvbg0KPiANCg0K
