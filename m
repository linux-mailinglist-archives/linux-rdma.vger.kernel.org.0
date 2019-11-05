Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5234F009D
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfKEPCO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 10:02:14 -0500
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:17294
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731053AbfKEPCN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 10:02:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crX6/WMTjHmvCOZ/u9FAhpQb6q1UyMpPoPyvYwV2ZMksS62AJxuB/pSBIP09RTyj7gDTn7MZfPS5F0MhebPq1BrrwCcgBBavEaRIZIn+wJvmKz8Mzek19inkVg0uEDixXEbabMZdbXN7sk8hMzVRJ/QusF4ZoTfe0SCLXV3TZtoSuedXgFDGAigLv/dr7y/PdofEbM5hLtuK+kzk/4yxleosiJOTF/ypwisdedN3+NeM4dKGruh5K5qWSFOZXAxHHhRnsuD8AErTeOpUnfhn8GQBeUKNSuPJQIX1CvUjow1AZOIJc6ZtpQrMty+8SIacCiO0t9LkS/AsikGS+fL3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WhruIpxp9D0M+PtCsOL7rHFrjq8zaqRe+uyKuv2rwo=;
 b=lL1K3TU2AxYuNjlcez/sryyhCgVFRi3HgZCFGfmINkv0STD9HYX3SVeAmRCYyCDLAApP2D+3MWKFXDB3ZMkii/ejK++CP8RikprI/CA/2OmujjbwqWuKo3LglzMkbNVH77Kug2v5UFFc+g1drrLopy6iAnzzhOCenXVextU0CAoAvr/HMwkhRTjyUFHguz6ZIH0p+Wg/31vuFSQdZSi06q7KY1L55J3zpbELMbJNhT9LslncUWyVIZ9k30KXHA2jCxxcoMTx30VrlLKUHmn7xv608OivDn93iwo/4ozmG9iQJE/eC9juiLfSYRWppinbpMOVwDNrrRrdHOVLCOj3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WhruIpxp9D0M+PtCsOL7rHFrjq8zaqRe+uyKuv2rwo=;
 b=DmcozlmVknp34xsDxRdGjr9I9E1DXePka6dZhxoj5pIud0atrZ4pW7+Rh/RFI0LGsK84TtohBcIkUWp2e0qV9fkYDFZYFHId54TfgTJYOIaT0bEMGSwdXVNu/shVfhaKJ2ncGB1iUypXOO8wkjex7HjlHJOVAvbGP1M97IFtNYQ=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4401.eurprd05.prod.outlook.com (52.134.124.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 15:02:09 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4%7]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 15:02:09 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
Thread-Topic: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
Thread-Index: AQHVk4vMK3Mc37DJKkWCrxmn97AfOqd79C5AgABBfACAAHanAA==
Date:   Tue, 5 Nov 2019 15:02:08 +0000
Message-ID: <AM0PR05MB48667BDE7D8E4A74958F0FA0D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1572925690-7336-1-git-send-email-liuyixian@huawei.com>
 <AM0PR05MB4866B3612F0AE576136EED94D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <a0053ce9-7b16-2d10-0f5c-37ee4771a1ea@huawei.com>
In-Reply-To: <a0053ce9-7b16-2d10-0f5c-37ee4771a1ea@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:7198:5d2b:7ff1:d0d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ff5cb19-98e2-4ea2-f4aa-08d762012160
x-ms-traffictypediagnostic: AM0PR05MB4401:
x-microsoft-antispam-prvs: <AM0PR05MB44010138CAA1B04BB7D23B1BD17E0@AM0PR05MB4401.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(51914003)(199004)(189003)(13464003)(446003)(229853002)(6436002)(52536014)(53546011)(71190400001)(486006)(186003)(86362001)(71200400001)(9686003)(2501003)(7696005)(66556008)(76116006)(66476007)(99286004)(66446008)(64756008)(66946007)(14454004)(55016002)(8936002)(316002)(8676002)(81156014)(81166006)(11346002)(102836004)(5660300002)(476003)(76176011)(33656002)(54906003)(2201001)(110136005)(46003)(478600001)(25786009)(2906002)(7736002)(305945005)(74316002)(6116002)(4326008)(256004)(14444005)(6246003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4401;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeCJ96oHLMZMatF1/LnShFeu6y0CX8XveV9t/+WG1aEgYzUJZjS2H17Afd0VKDGz0PcGhIeHL6rikD7ZEwmgzN73Pf1qiY/Hg4Ga8XBCQQ4ODHO82tE76mtskINuDbXTT52y8iStS073ko5uCv92mE5OqHXRtlwSZK9Q6kw6niT45RZbVMuheXG0NWd8yKjt0rG+hMpCU3y0G2Hco8bqNr6H0MwArkPFy2WGXMB6lfcmLlXTFEsvioXZcGdNxPfdTDd1Us5InJ3GKIgY9qSmuDv0HLpPLS/Vympm4li/ocNDVcf/GRaLfJMbBeWWY10LyVD+hozgRHjoxFQJZ3zhm5woZh9AyQmb7zRZcO8nEaUpzpV6HK/G9CeuvC95cb7VQ4TLcKvOwEOlafDdyHj5UBiWcztv0Jf5OvtKTocN8AjZz9sAkidSYgBRi0PDsw/E
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff5cb19-98e2-4ea2-f4aa-08d762012160
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 15:02:08.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpMosJF6lYAR9MZvyJ9VnA2xOJzyXNdI3J+o/ksH5cGrlelWr2PI0FHkKnls3G8J15+0NoVfdsjQhvZDh4WuZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4401
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGl1eWl4aWFuIChFYXNv
bikgPGxpdXlpeGlhbkBodWF3ZWkuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA1LCAy
MDE5IDE6NTUgQU0NCj4gVG86IFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPjsgZGxl
ZGZvcmRAcmVkaGF0LmNvbTsNCj4gamdnQHppZXBlLmNhDQo+IENjOiBsZW9uQGtlcm5lbC5vcmc7
IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eGFybUBodWF3ZWkuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggcmRtYS1uZXh0XSBSRE1BL2NvcmU6IFVzZSBwcl93YXJuX3JhdGVsaW1p
dGVkDQo+IA0KPiANCj4gDQo+IE9uIDIwMTkvMTEvNSAxMjowOSwgUGFyYXYgUGFuZGl0IHdyb3Rl
Og0KPiA+IEhpIFlpeGlhbiBMaXUsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4gRnJvbTogbGludXgtcmRtYS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LXJk
bWEtDQo+ID4+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIFlpeGlhbiBMaXUN
Cj4gPj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciA0LCAyMDE5IDk6NDggUE0NCj4gPj4gVG86IGRs
ZWRmb3JkQHJlZGhhdC5jb207IGpnZ0B6aWVwZS5jYQ0KPiA+PiBDYzogUGFyYXYgUGFuZGl0IDxw
YXJhdkBtZWxsYW5veC5jb20+OyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+PiByZG1hQHZn
ZXIua2VybmVsLm9yZzsgbGludXhhcm1AaHVhd2VpLmNvbQ0KPiA+PiBTdWJqZWN0OiBbUEFUQ0gg
cmRtYS1uZXh0XSBSRE1BL2NvcmU6IFVzZSBwcl93YXJuX3JhdGVsaW1pdGVkDQo+ID4+DQo+ID4+
IFRoaXMgd2FybmluZyBjYW4gYmUgdHJpZ2dlcmVkIGVhc2lseSB3aGVuIGFkZGluZyBhIGxhcmdl
IG51bWJlciBvZg0KPiA+PiBWTEFOcyB3aGlsZSB0aGUgY2FwYWNpdHkgb2YgR0lEIHRhYmxlIGlz
IHNtYWxsLg0KPiA+Pg0KPiA+PiBGaXhlczogNTk4ZmY2YmFlNjg5ICgiSUIvY29yZTogUmVmYWN0
b3IgR0lEIG1vZGlmeSBjb2RlIGZvciBSb0NFIikNCj4gPj4gU2lnbmVkLW9mZi1ieTogWWl4aWFu
IExpdSA8bGl1eWl4aWFuQGh1YXdlaS5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9pbmZp
bmliYW5kL2NvcmUvY2FjaGUuYyB8IDQgKystLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPiBUaGFua3MgZm9yIHRoZSBwYXRj
aC4gSG93ZXZlciwgdmxhbiBuZXRkZXZpY2UgYWRkaXRpb24gaXMgYW4NCj4gYWRtaW5pc3RyYXRp
dmUgb3BlcmF0aW9uIGFsbG93ZWQgdG8gcHJvY2VzcyB3aGljaCBoYXMgQ0FQX05FVF9BRE1JTg0K
PiBwcml2aWxlZ2UuDQo+ID4gU28gbGFyZ2UgbnVtYmVyIG9mIFZMQU4gYWRkaXRpb24gYnkgYSB1
c2VyIGZvciBhIFJvQ0UgZGV2aWNlIHdob3NlIEdJRA0KPiBjYXBhY2l0eSBpcyBzbWFsbCBpcyBj
b25zdHJhaW5lZCBvcGVyYXRpb24uDQo+IA0KPiBIb3cgY2FuIHdlIGNvbnN0cmFpbiB0aGlzIG9w
ZXJhdGlvbiBmcm9tIGFuIGFkbWluaXN0cmF0b3I/DQo+IA0KQWRtaW5pc3RyYXRvciBrbm93cyB0
aGUgR0lEIHRhYmxlIHNpemUgb2YgdGhlIFJvQ0UgZGV2aWNlIGhlIGlzIG1hbmFnaW5nLg0KDQo+
ID4gVGhlcmVmb3JlLCB3ZSBzaG91bGRuJ3QgYmUgcmF0ZSBsaW1pdGluZyBpdC4NCj4gPiBCeSBy
YXRlIGxpbWl0aW5nIHdlIG1pc3MgdGhlIGluZm9ybWF0aW9uIGFib3V0IGFueSBidWdzIGluIEdJ
RCBjYWNoZQ0KPiBtYW5hZ2VtZW50Lg0KPiANCj4gcHJfd2Fybl9yYXRlbGltaXRlZCBvbmx5IHBy
ZXZlbnQgZnJvbSBwcmludGluZyAqKnRoZSBzYW1lIG1lc3NhZ2VzKioNCj4gZnJlcXVlbnRseSwg
d2h5IGluZm9ybWF0aW9uIHdpbGwgYmUgbG9zdD8NCj4NClNhbWUgbWVzc2FnZSB0aGF0IG1heSBo
YXZlIGRpZmZlcmVudCBHSUQgdmFsdWUgYW5kIHJldHVybiBjb2RlLg0KU28gaW5mb3JtYXRpb24g
aXMgbG9zdCBvbiB3aHkgR0lEIGVudHJ5IHdhcyBub3QgYWJsZSB0byBhZGQgKGVycm9yIGJ5IHZl
bmRvciBkcml2ZXIsIG5vIHNwYWNlIGluIHRhYmxlLCBzb21ldGhpbmcgZWxzZSBldGMpLg0KDQog
DQo+ID4gQXQgYmVzdCB3ZSBjYW4gY29udmVydCBpdCB0byBkZXZfZGJnKCkgc28gdGhhdCB3ZSBz
dGlsbCBnZXQgdGhlIG5lY2Vzc2FyeQ0KPiBkZWJ1ZyBpbmZvcm1hdGlvbiB3aGVuIG5lZWRlZC4N
Cj4gPiBJIHdhbnRlZCB0byBjb252ZXJ0IHRoZW0gdHJhY2UgZnVuY3Rpb25zIHdoaWNoIHdpbGwg
YWxsb3cgdXMgdG8gbW9yZQ0KPiBkZWJ1ZyBsZXZlbCBwcmludHMgc3VjaCBhcyBuZXRkZXYgbmFt
ZSwgdmxhbiBldGMuDQo+ID4gSSB0aGluayBJIHJlbWVtYmVyIGNvbW1lbnQgZnJvbSBMZW9uIHRv
byB3aGlsZSB3b3JraW5nIG9uIGl0LCBidXQgaXQgd2FzDQo+IGxvbmcgaGF1bCB0aGF0IHRpbWUu
DQo+ID4NCj4gPiBJdHMgYmFzZSBpbmZyYXN0cnVjdHVyZSBpcyBqdXN0IGdvdCByZWFkeSB3aXRo
IENodWNrIExldmVyJ3MgcGF0Y2guDQo+ID4gU28gYXJvdW5kIDUuNSwgSSBzaG91bGQgY29udmVy
dCB0byB0cmFjZSBjYWxscy4NCj4gDQo+IE9rYXksIHdoYXRldmVyLCB0aGUgc2l0dWF0aW9uIGRl
c2NyaWJlZCBpbiBjb21taXQgbWVzc2FnZSBtYXkgYmUNCj4gb2NjdXJyZWQsIHBsZWFzZSBjb25z
aWRlciBpdC4NCj4NClllcy4gc3VyZS4gQWRkZWQgdG8gbXkgdG9kbyBsaXN0Lg0KIA0KPiA+DQo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5jDQo+ID4+IGIv
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYyBpbmRleCAwMGZiM2VhLi4yOTkwMDc1IDEw
MDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5jDQo+ID4+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMNCj4gPj4gQEAgLTU3OSw4ICs1Nzks
OCBAQCBzdGF0aWMgaW50IF9faWJfY2FjaGVfZ2lkX2FkZChzdHJ1Y3QgaWJfZGV2aWNlDQo+ID4+
ICppYl9kZXYsIHU4IHBvcnQsDQo+ID4+ICBvdXRfdW5sb2NrOg0KPiA+PiAgCW11dGV4X3VubG9j
aygmdGFibGUtPmxvY2spOw0KPiA+PiAgCWlmIChyZXQpDQo+ID4+IC0JCXByX3dhcm4oIiVzOiB1
bmFibGUgdG8gYWRkIGdpZCAlcEk2IGVycm9yPSVkXG4iLA0KPiA+PiAtCQkJX19mdW5jX18sIGdp
ZC0+cmF3LCByZXQpOw0KPiA+PiArCQlwcl93YXJuX3JhdGVsaW1pdGVkKCIlczogdW5hYmxlIHRv
IGFkZCBnaWQgJXBJNg0KPiA+PiBlcnJvcj0lZFxuIiwNCj4gPj4gKwkJCQkgICAgX19mdW5jX18s
IGdpZC0+cmF3LCByZXQpOw0KPiA+PiAgCXJldHVybiByZXQ7DQo+ID4+ICB9DQo+ID4+DQo+ID4+
IC0tDQo+ID4+IDIuNy40DQo+ID4NCj4gPg0KPiA+DQoNCg==
