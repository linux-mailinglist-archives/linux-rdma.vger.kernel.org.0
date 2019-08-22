Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5B998FF
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfHVQTJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 12:19:09 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:5585
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729718AbfHVQTJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 12:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJiEADejcyVn02YwKKP3Fhqcq0NnUw4d5o0gfyWwSWlW5NhGzz/iifXdTFT+sZvlFIGTYHwss7BnPqc79t4NxBy8nQduyjg9bwDeqxCrZ6K9PrF7MIUX1l1HESWCWPs+ezOL92BWWyjlJ5/VoIQWKH1UwchbTBAtcjpLpabWwRx4FhqqQ8PqzF1V6YKeH112KbhUoVwGXIGfBGSkfTtx+GtIjdDP96WfAj/NMmq2mvXg7Lj359aHZaJK9z6h72Aj6HxdBGr4nOnwmS/WdurkNTiwJVdGqRZdFV/56UIppYunApWTc/PUeCu7Towsivnn/B6sbwRxWCoVYNBly9puQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72PhvSIVm5LCjroFkuvNrRqg0CJPNEaysnKu5sv6yu4=;
 b=MmjUO/kSUbqq3VvXr8IZDg390CotQ2y4/LiZVi2Hc60/ZeJGfmUhqDr7jrgArol6iQYviPU1p3rv5SAZm0fOGuNvRD0HbSq8vPfVpe6sMFHzD7wDBfbLRGSr3PyV3tHmDYI/RXd6LJBBgJF1MThKrIW/skMcPZE0GZyfzIDHPjPRfDXC2bjBS3hmPnvIsk667HcfoEgcgZ1xt3Qaoo5p9gtD8zaqjUC8+UpCrXDTxNxps96Lr9aVM4X8lW9pTPD9SufVarcZctblDZOfaAiNBoQpL2SNbNeRp9np/hIKB/z1kxM89/czqb+OtkGHoKTh2Z24TfVGBPFWGwPsNs/A9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72PhvSIVm5LCjroFkuvNrRqg0CJPNEaysnKu5sv6yu4=;
 b=TJoWOkQ9/vZ161tUNq9N8IcYTL4BgSvhvGYE+EldOYrTk/BHMr+imfiHJq7cklQPYP4yixLKaVTg4FeXSKNSL7JEWga6n7iXn21gAXoBllz/ppDAwbXKcBnf+OwbTbzWVJOYIBo/5aeYGxmjCI0VNdHqprjqmleNheXDb3IA7ew=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3220.eurprd05.prod.outlook.com (10.171.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 16:18:24 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e826:7a52:5488:2b6f%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 16:18:24 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Noa Osherovich <noaos@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKJrnh28/IoUO3a7bpLCEySg==
Date:   Thu, 22 Aug 2019 16:18:24 +0000
Message-ID: <20190822161813.GI29433@mtr-leonro.mtl.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
In-Reply-To: <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [184.188.36.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 658d93a1-838b-4ef5-2086-08d7271c5b38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR05MB3220;
x-ms-traffictypediagnostic: AM4PR05MB3220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB32209D690F011EEEFC8FB0E3B0A50@AM4PR05MB3220.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(26005)(86362001)(64756008)(229853002)(66446008)(66556008)(102836004)(8676002)(66946007)(6506007)(33656002)(4326008)(386003)(9686003)(53546011)(6512007)(25786009)(6862004)(66476007)(81156014)(81166006)(6486002)(6116002)(71190400001)(71200400001)(5660300002)(1076003)(6436002)(3846002)(2906002)(52116002)(446003)(478600001)(99286004)(486006)(53936002)(14454004)(186003)(76176011)(8936002)(476003)(6636002)(305945005)(6246003)(54906003)(11346002)(66066001)(256004)(7736002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3220;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ey08pwiHhKHVIHVxQdisHDJHUMnJ52uRRhj9Wlst427ofaq09qgOmSD9V07EiQypVeD/3A7egJ5iDhehXnDATrVecDqCpetpNKCj/S9zLnac1uiVYw8C2hYALYRxcCFgpOZwGZ33YfmtlBPQUTqNJhOnjLxzno4x6/pgLVDTCn7vDRTywxtAGOZwajSUhuog50HWbdEXvEgPnT2DqtrWjxprW1bhdfkblhMlbjIZ9g+QxfR42V0ldL7Y0e7zLo9QAosfXuhXzqkdzKvi2H23YJWLaHwr3ESKyFztzP5TJlkbeutdfKC4AWuRMyd9Xs2gbEsQDijl8juLzIS8EA16Jha3yM48rpJ9NWUjBNOxJ6Y1r6d+e7ucuYoIuyFWKRm2pWG0pOlqRJ2bX7wo30w9vAe+qcbiCoETpPOJ1EZ0m0k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68B301B1D5178D478A545552976C97C0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658d93a1-838b-4ef5-2086-08d7271c5b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 16:18:24.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sex1thYFqfQftJZd1dURBLnfCnQ4+sMdTD8WEYFKJ3dGiBUwmGSwpoMa8OM79aV0/pyuLDmTnfDmw52Sna0Xyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3220
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBBdWcgMjAsIDIwMTkgYXQgMDE6MDA6NDdQTSArMDAwMCwgTm9hIE9zaGVyb3ZpY2gg
d3JvdGU6DQo+IE9uIDgvMTkvMjAxOSA0OjUwIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+
DQo+ID4gSSdkIHByZWZlciBydW5fdGVzdHMgdG8gYmUgaW4gdGhlIHRlc3RzIGRpcmVjdG9yeS4u
DQo+ID4NCj4gPiBKYXNvbg0KPg0KPiBQUiB3YXMgdXBkYXRlZA0KDQoxLg0KSU1ITywgcnVuX3Rl
c3RzLnB5IHNob3VsZCBiZSBwbGFjZWQgaW5zaWRlIHRlc3RzIGRpcmVjdG9yeSB0b28gYW5kIG5v
dA0Kb25seSBpbnN0YWxsZWQgaW50byB0ZXN0cy8uDQoNCuKenCAgcmRtYS1jb3JlIGdpdDoobm9h
b3MtcHItdGVzdHMpIOKclyBwd2QNCi9pbWFnZXMvbGVvbnJvL3NyYy9yZG1hLWNvcmUNCuKenCAg
cmRtYS1jb3JlIGdpdDoobm9hb3MtcHItdGVzdHMpIOKclyBscyAtYWwgfCBncmVwICBydW5fdGVz
dHMucHkNCi1ydy1ydy1yLS0uICAxIGxlb25ybyBsZW9ucm8gICA1NDkgQXVnIDIyIDE4OjU5IHJ1
bl90ZXN0cy5weQ0KDQpFeHBlY3RlZA0K4p6cICByZG1hLWNvcmUgZ2l0Oihub2Fvcy1wci10ZXN0
cykg4pyXIGxzIC1hbCB0ZXN0cy8gfCBncmVwICBydW5fdGVzdHMucHkNCi1ydy1ydy1yLS0uICAx
IGxlb25ybyBsZW9ucm8gICA1NDkgQXVnIDIyIDE4OjU5IHJ1bl90ZXN0cy5weQ0KDQoyLg0KRXhl
Y3V0aW9uIG9mIHJ1bl90ZXN0cy5weSBwcm9kdWNlcyBhIGxvdCBvZiB1bnRyYWNrZWQgZmlsZWQN
CuKenCAgcmRtYS1jb3JlIGdpdDoobm9hb3MtcHItdGVzdHMpIOKclyBnaXQgc3QNCk9uIGJyYW5j
aCBub2Fvcy1wci10ZXN0cw0KVW50cmFja2VkIGZpbGVzOg0KICAodXNlICJnaXQgYWRkIDxmaWxl
Pi4uLiIgdG8gaW5jbHVkZSBpbiB3aGF0IHdpbGwgYmUgY29tbWl0dGVkKQ0KDQoJcHl2ZXJicy9f
X2luaXRfXy5weWMNCglweXZlcmJzL3B5dmVyYnNfZXJyb3IucHljDQoJdGVzdHMvX19pbml0X18u
cHljDQoJdGVzdHMvYmFzZS5weWMNCgl0ZXN0cy90ZXN0X2FkZHIucHljDQoJdGVzdHMvdGVzdF9j
cS5weWMNCgl0ZXN0cy90ZXN0X2RldmljZS5weWMNCgl0ZXN0cy90ZXN0X21yLnB5Yw0KCXRlc3Rz
L3Rlc3Rfb2RwLnB5Yw0KCXRlc3RzL3Rlc3RfcGQucHljDQoJdGVzdHMvdGVzdF9xcC5weWMNCg0K
My4gcnVuX3Rlc3RzLnB5IGxhY2tzIG9mIHB5dGhvbjMgc2hlYmFuZw0KNC4gQXR0ZW1wdCB0byBy
dW4gb24gc3lzdGVtIHdpdGhvdXQgaWIqIG1vZHVsZXMgY2F1c2VzIHRvIGF3ZnVsIHNwbGF0Lg0K
SXMgaXQgZXhwZWN0ZWQ/DQp0Oihub2Fvcy1wci10ZXN0cykgcHl0aG9uIC4vcnVuX3Rlc3RzLnB5
DQpFRUVFRUVFDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQpFUlJPUjogdGVzdF9tciAodW5pdHRlc3QubG9hZGVy
Lk1vZHVsZUltcG9ydEZhaWx1cmUpDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpJbXBvcnRFcnJvcjogRmFpbGVk
IHRvIGltcG9ydCB0ZXN0IG1vZHVsZTogdGVzdF9tcg0KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOg0KICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjIuNy91bml0dGVzdC9sb2FkZXIu
cHkiLCBsaW5lIDI1NCwgaW4gICBfZmluZF90ZXN0cw0KICAgIG1vZHVsZSA9IHNlbGYuX2dldF9t
b2R1bGVfZnJvbV9uYW1lKG5hbWUpDQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMi43L3VuaXR0
ZXN0L2xvYWRlci5weSIsIGxpbmUgMjMyLCBpbiBfZ2V0X21vZHVsZV9mcm9tX25hbWUNCiAgICBf
X2ltcG9ydF9fKG5hbWUpDQogIEZpbGUgIi9pbWFnZXMvbGVvbnJvL3NyYy9yZG1hLWNvcmUvdGVz
dHMvdGVzdF9tci5weSIsIGxpbmUgMTAsIGluIDxtb2R1bGU+DQogICAgZnJvbSB0ZXN0cy5iYXNl
IGltcG9ydCBQeXZlcmJzQVBJVGVzdENhc2UNCiAgRmlsZSAiL2ltYWdlcy9sZW9ucm8vc3JjL3Jk
bWEtY29yZS90ZXN0cy9iYXNlLnB5IiwgbGluZSA3LCBpbiA8bW9kdWxlPg0KICAgIGZyb20gcHl2
ZXJicy5xcCBpbXBvcnQgUVBDYXAsIFFQSW5pdEF0dHIsIFFQQXR0ciwgUVANCkltcG9ydEVycm9y
OiBObyBtb2R1bGUgbmFtZWQgcXANCg0KLi4uLi4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUmFuIDcgdGVz
dHMgaW4gMC4wMDBzDQoNCkZBSUxFRCAoZXJyb3JzPTcpDQoNClRoYW5rcw0KDQo+DQo+IFRoYW5r
cywNCj4gTm9hDQo+DQo=
