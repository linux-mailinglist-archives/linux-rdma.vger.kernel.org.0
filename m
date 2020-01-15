Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3913BCB9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgAOJsn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 04:48:43 -0500
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:42688
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729494AbgAOJsm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 04:48:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv5YgUljnyOgU2WS5/r16kRMh9ouExqyuBSmRviXEMDGdnIr4N0QR9mA2CVd3xVS/4Fc/OQliGQlaLLkEyE9Pe+Jn8te/KZU9pt+lsZE1aEsp02fvDSiy6sdgoYuWEFimgkD0/x2qbv9Vv9JxtfGYKsFljBE0zzJcp+/9rfDKR5hZefCQbXptYMVE74uyH27lfWI8qu2TwlxK6NgVn+1qseNwYLQ1Amh1dP6PVxqvgem4uUGFKqKz3uX2QsUILdZC/NZnbsgXPRRqW0Atc8geuboICQry6fZbS05/PCTySe4Z9BkTL2WKk/aZwanxkI+g0WOv0sv1XxIbWY8mj6LaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zzol5UD82l1PMIXOtzGOheTtJxDhgf/tGr1Krt18d4=;
 b=BfGITeoyi5wOsTmrhb9hwv9dvrDK6WqoTtFJBjgGvakchInbya54EhRIfAnzelW/bo6rL0LDTwWW9oj4Nxdhr1AjWz9DMCuqiSB+g/nsl4nxkH6OHzTzvUiocyP6JDwgy0y4S9HoVuEI0h7YXjWmG/eu4l7AgcbkNuJ7lQHl2EWUWEfZFkKgD197FFdSaoQlFQrvO2mq3xs0FFIhrg4pT2xdNW0svQB0q+bM0wr0Vc/99XKD2kEWgzlWRA9yAx1gmC+tqV7Xr+NJg0fx5DU0x6X4WVHVRXyrRzq7Vr949o6pHV8gZoYpul7uwEOMm7i3V76jKJYZUj7ZZnekQZtqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zzol5UD82l1PMIXOtzGOheTtJxDhgf/tGr1Krt18d4=;
 b=p8vnSWMfh3xQTDKy1ZTW+WON0Z8+R7xwieW+XIXLWmZdFNBpd5ctyUcFHqv1Ki1RQgg1KiVGgsgTme6TddPKTNu6tpeARTuv09wt2Gb8wAsFsxrWI/Hl3Zg1pqIzLcPDAKxZzoGaGAzH2/3tV6Gddn/yZ2Nss9Yr8yozH2UIyyo=
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com (52.135.162.157) by
 AM6PR05MB4903.eurprd05.prod.outlook.com (20.177.36.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 09:48:38 +0000
Received: from AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::b410:229f:2e92:38af]) by AM6PR05MB4472.eurprd05.prod.outlook.com
 ([fe80::b410:229f:2e92:38af%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 09:48:38 +0000
Received: from [192.168.0.109] (115.196.36.95) by SG2PR04CA0149.apcprd04.prod.outlook.com (2603:1096:3:16::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 09:48:35 +0000
From:   Mark Zhang <markz@mellanox.com>
To:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Thread-Topic: [RFC v2] RoCE v2.0 Entropy - IPv6 Flow Label and UDP Source Port
Thread-Index: AQHVxi+sI3U58iyGGkK67hYzlpOeV6frhYGA
Date:   Wed, 15 Jan 2020 09:48:38 +0000
Message-ID: <ed4c97ae-5bf6-20a9-8292-ead9ee356585@mellanox.com>
References: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
In-Reply-To: <CAFgAxU8ArpoL9fMpJY5v-UZS5AMXom+TJ8HS57XeEOsCFFov8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To AM6PR05MB4472.eurprd05.prod.outlook.com
 (2603:10a6:209:43::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [115.196.36.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a24297c5-d988-4994-ab1c-08d799a01852
x-ms-traffictypediagnostic: AM6PR05MB4903:|AM6PR05MB4903:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB49034FBCE139E632CFCE7E91CA370@AM6PR05MB4903.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(8676002)(52116002)(8936002)(53546011)(16576012)(81156014)(36756003)(31696002)(956004)(31686004)(86362001)(6486002)(110136005)(2906002)(54906003)(2616005)(71200400001)(316002)(81166006)(66556008)(5660300002)(186003)(26005)(66946007)(478600001)(107886003)(4326008)(64756008)(66446008)(966005)(66476007)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4903;H:AM6PR05MB4472.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DM5NS4hapUJIhtN7GVFt9vxTXs2caHYA7va9SDYe6m1FUA+UXzH8a8vRW4hDf4gIz4StJcrUE1R4aiENl7TfIJ8vN4o8jU5pw6QmfFMfDUSrmVzLCeVzc5Se4fRt8sJciRvuK3T8RpP1q3R8dl2YwaElUDHbQOBSaPzX1U0Th9aZYRVScntTPvTM2E4YMksSN7gQwMvg7E5U7n3l01KUBf60J6GCBBRZ5e99QX9kMrZXwareXXDKzRN4OLi9Z0qtuux4dkHhGlxz9ZEIXbZJvkgdFcPtjUrwp/e1I10OyeoXlpyjfxbg7j9YMaQo8Me+jid/mCYQMV+yHkx9NiJ/guEIUhTsy5znpyqPIFltK/ofY6a79t3DKM2K1445a0d/1IgjDblJfU67GYMYfkP46sBclf2IZle6jjzIVcm51LH/jKUKiYnLde9yRRcBVAQOfxkWXy3LX81ylhSrh9iCYqq9s5ebtg/mdSnUufG3iPQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <033FCC27F5C4BD4A9414559852EC2BE7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24297c5-d988-4994-ab1c-08d799a01852
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 09:48:38.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDsy6OMVQofuHgxRGOMVYgHMuEMiflUpqfEeSjdgJakkLXhzy0Ubf2euRa0AXZV/2HhZPddK/m/O7R1ZRNJYAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4903
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMS84LzIwMjAgMTA6MjYgUE0sIEFsZXggUm9zZW5iYXVtIHdyb3RlOg0KPiBBIGNvbWJpbmF0
aW9uIG9mIHRoZSBmbG93X2xhYmVsIGZpZWxkIGluIHRoZSBJUHY2IGhlYWRlciBhbmQgVURQIHNv
dXJjZSBwb3J0DQo+IGZpZWxkIGluIFJvQ0UgdjIuMCBhcmUgdXNlZCB0byBpZGVudGlmeSBhIGdy
b3VwIG9mIHBhY2tldHMgdGhhdCBtdXN0IGJlDQo+IGRlbGl2ZXJlZCBpbiBvcmRlciBieSB0aGUg
bmV0d29yaywgZW5kLXRvLWVuZC4NCj4gVGhlc2UgZmllbGRzIGFyZSB1c2VkIHRvIGNyZWF0ZSBl
bnRyb3B5IGZvciBuZXR3b3JrIHJvdXRlcnMgKEVDTVApLCBsb2FkDQo+IGJhbGFuY2VycyBhbmQg
ODAyLjNhZCBsaW5rIGFnZ3JlZ2F0aW9uIHN3aXRjaGluZyB0aGF0IGFyZSBub3QgYXdhcmUgb2Yg
Um9DRSBJQg0KPiBoZWFkZXJzLg0KPiANCj4gVGhlIGZsb3dfbGFiZWwgZmllbGQgaXMgZGVmaW5l
ZCBieSBhIDIwIGJpdCBoYXNoIHZhbHVlLiBDTSBiYXNlZCBjb25uZWN0aW9ucw0KPiB3aWxsIHVz
ZSBhIGhhc2ggZnVuY3Rpb24gZGVmaW5pdGlvbiBiYXNlZCBvbiB0aGUgc2VydmljZSB0eXBlIChR
UCBUeXBlKSBhbmQNCj4gU2VydmljZSBJRCAoU0lEKS4gV2hlcmUgQ00gc2VydmljZXMgYXJlIG5v
dCB1c2VkLCB0aGUgMjAgYml0IGhhc2ggd2lsbCBiZQ0KPiBhY2NvcmRpbmcgdG8gdGhlIHNvdXJj
ZSBhbmQgZGVzdGluYXRpb24gUVBOIHZhbHVlcy4NCj4gRHJpdmVycyB3aWxsIGRlcml2ZSB0aGUg
Um9DRSB2Mi4wIFVEUCBzcmNfcG9ydCBmcm9tIHRoZSBmbG93X2xhYmVsIHJlc3VsdC4NCj4gDQo+
IFVEUCBzb3VyY2UgcG9ydCBzZWxlY3Rpb24gbXVzdCBhZGhlcmUgSUFOQSBwb3J0IGFsbG9jYXRp
b24gcmFuZ2VzLiBUaHVzIHdlIHdpbGwNCj4gYmUgdXNpbmcgSUFOQSByZWNvbW1lbmRhdGlvbiBm
b3IgRXBoZW1lcmFsIHBvcnQgcmFuZ2Ugb2Y6IDQ5MTUyLTY1NTM1LCBvciBpbg0KPiBoZXg6IDB4
QzAwMC0weEZGRkYuDQo+IA0KPiBUaGUgYmVsb3cgY2FsY3VsYXRpb25zIHRha2UgaW50byBhY2Nv
dW50IHRoZSBpbXBvcnRhbmNlIG9mIHByb2R1Y2luZyBhIHN5bW1ldHJpYw0KPiBoYXNoIHJlc3Vs
dCBzbyB3ZSBjYW4gc3VwcG9ydCBzeW1tZXRyaWMgaGFzaCBjYWxjdWxhdGlvbiBvZiBuZXR3b3Jr
IGVsZW1lbnRzLg0KPiANCj4gSGFzaCBDYWxjdWxhdGlvbiBmb3IgUkRNQSBJUCBDTSBTZXJ2aWNl
DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBGb3IgUkRNQSBJ
UCBDTSBTZXJ2aWNlcywgYmFzZWQgb24gUVAxIGlNQUQgdXNhZ2UgYW5kIGNvbm5lY3RlZCBSQyBR
UHMgdXNpbmcgdGhlDQo+IFJETUEgSVAgQ00gU2VydmljZSBJRCwgdGhlIGZsb3cgbGFiZWwgd2ls
bCBiZSBjYWxjdWxhdGVkIGFjY29yZGluZyB0byBJQlRBIENNDQo+IFJFUSBwcml2YXRlIGRhdGEg
aW5mbyBhbmQgU2VydmljZSBJRC4NCj4gDQo+IEZsb3cgbGFiZWwgaGFzaCBmdW5jdGlvbiBjYWxj
dWxhdGlvbnMgZGVmaW5pdGlvbiB3aWxsIGJlIGRlZmluZWQgYXM6DQo+IEV4dHJhY3QgdGhlIGZv
bGxvd2luZyBmaWVsZHMgZnJvbSB0aGUgQ00gSVAgUkVROg0KPiAgICBDTV9SRVEuU2VydmljZUlE
LkRzdFBvcnQgWzIgQnl0ZXNdDQo+ICAgIENNX1JFUS5Qcml2YXRlRGF0YS5TcmNQb3J0IFsyIEJ5
dGVzXQ0KPiAgICB1MzIgaGFzaCA9IERzdFBvcnQgKiBTcmNQb3J0Ow0KPiAgICBoYXNoIF49ICho
YXNoID4+IDE2KTsNCj4gICAgaGFzaCBePSAoaGFzaCA+PiA4KTsNCj4gICAgQUhfQVRUUi5HUkgu
Zmxvd19sYWJlbCA9IGhhc2ggQU5EIElCX0dSSF9GTE9XTEFCRUxfTUFTSzsNCj4gDQo+ICAgICNk
ZWZpbmUgSUJfR1JIX0ZMT1dMQUJFTF9NQVNLICAweDAwMEZGRkZGDQo+IA0KPiBSZXN1bHQgb2Yg
dGhlIGFib3ZlIGhhc2ggd2lsbCBiZSBrZXB0IGluIHRoZSBDTSdzIHJvdXRlIHBhdGggcmVjb3Jk
IGNvbm5lY3Rpb24NCj4gY29udGV4dCBhbmQgd2lsbCBiZSB1c2VkIGFsbCBhY3Jvc3MgaXRzIHZp
dGFsaXR5IGZvciBhbGwgcHJlY2VkaW5nIENNIG1lc3NhZ2VzDQo+IG9uIGJvdGggZW5kcyBvZiB0
aGUgY29ubmVjdGlvbiAoaW5jbHVkaW5nIFJFUCwgUkVKLCBEUkVRLCBEUkVQLCAuLikuDQo+IE9u
Y2UgY29ubmVjdGlvbiBpcyBlc3RhYmxpc2hlZCwgdGhlIGNvcnJlc3BvbmRpbmcgQ29ubmVjdGVk
IFJDIFFQcywgb24gYm90aA0KPiBlbmRzIG9mIHRoZSBjb25uZWN0aW9uLCB3aWxsIHVwZGF0ZSB0
aGVpciBjb250ZXh0IHdpdGggdGhlIGNhbGN1bGF0ZWQgUkRNQSBJUA0KPiBDTSBTZXJ2aWNlIGJh
c2VkIGZsb3dfbGFiZWwgYW5kIFVEUCBzcmNfcG9ydCB2YWx1ZXMgYXQgdGhlIENvbm5lY3QgcGhh
c2Ugb2YNCj4gdGhlIGFjdGl2ZSBzaWRlIGFuZCBBY2NlcHQgcGhhc2Ugb2YgdGhlIHBhc3NpdmUg
c2lkZSBvZiB0aGUgY29ubmVjdGlvbi4NCj4gDQo+IENNIHdpbGwgcHJvdmlkZSB0byB0aGUgY2Fs
Y3VsYXRlZCB2YWx1ZSBvZiB0aGUgZmxvd19sYWJlbCBoYXNoICgyMCBiaXQpIHJlc3VsdA0KPiBp
biB0aGUgJ3VpbnQzMl90IGZsb3dfbGFiZWwnIGZpZWxkIG9mICdzdHJ1Y3QgaWJ2X2dsb2JhbF9y
b3V0ZScgaW4gJ3N0cnVjdA0KPiBpYnZfYWhfYXR0cicuDQo+IFRoZSAnc3RydWN0IGlidl9haF9h
dHRyJyBpcyBwYXNzZWQgYnkgdGhlIENNIHRvIHRoZSBwcm92aWRlciBsaWJyYXJ5IHdoZW4NCj4g
bW9kaWZ5aW5nIGEgY29ubmVjdGVkIFFQJ3MgKGUuZy46IFJDKSBzdGF0ZSBieSBjYWxsaW5nICdp
YnZfbW9kaWZ5X3FwKHFwLA0KPiBhaF9hdHRyLCBhdHRyX21hc2sgfD0gSUJWX1FQX0FWKScgb3Ig
d2hlbiBjcmVhdGUgYSBBSCBmb3Igd29ya2luZyB3aXRoDQo+IGRhdGFncmFtIFFQJ3MgKGUuZy46
IFVEKSBieSBjYWxsaW5nIGlidl9jcmVhdGVfYWgoYWhfYXR0cikuDQo+IA0KPiBIYXNoIENhbGN1
bGF0aW9uIGZvciBub24tUkRNQSBDTSBTZXJ2aWNlIElEDQo+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCj4gRm9yIG5vbiBDTSBRUCdzLCB0aGUgYXBwbGljYXRp
b24gY2FuIGRlZmluZSB0aGUgZmxvd19sYWJlbCB2YWx1ZSBpbiB0aGUNCj4gJ3N0cnVjdCBpYnZf
YWhfYXR0cicgd2hlbiBtb2RpZnlpbmcgdGhlIGNvbm5lY3RlZCBRUCdzIChlLmcuOiBSQykgb3Ig
Y3JlYXRpbmcNCj4gYSBBSCBmb3IgdGhlIGRhdGFncmFtIFFQJ3MgKGUuZy46IFVEKS4NCj4gDQoN
CkhpIEFsZXgsIHdoZW4gY3JlYXRpbmcgYW4gQUggZm9yIHRoZSBkYXRhZ3JhbSBRUCwgSSB0aGlu
ayB3ZSBkb24ndCBoYXZlIA0KdGhlIHNyYy5RUCBhbmQgZHN0LlFQLCBzbyB3ZSBjYW4ndCBzZXQg
dGhlIGZsb3dfbGFiZWwgaGVyZT8NCg0KDQo+IElmIHRoZSBwcm92aWRlZCBmbG93X2xhYmVsIHZh
bHVlIGlzIHplcm8sIG5vdCBzZXQgYnkgdGhlIGFwcGxpY2F0aW9uIChlLmcuOg0KPiBsZWdhY3kg
Y2FzZXMpLCB0aGVuIHZlcmJzIHByb3ZpZGVycyBzaG91bGQgdXNlIHRoZSBzcmMuUVBbMjRiaXRd
IGFuZA0KPiBkc3QuUVBbMjRiaXRdIGFzIGlucHV0IGFyZ3VtZW50cyBmb3IgZmxvd19sYWJlbCBj
YWxjdWxhdGlvbi4NCj4gQXMgUVBOJ3MgYXJlIGFuIGFycmF5IG9mIDMgYnl0ZXMsIHRoZSBtdWx0
aXBsaWNhdGlvbiB3aWxsIHJlc3VsdCBpbiA2IGJ5dGVzDQo+IHZhbHVlLiBXZSdsbCBkZWZpbmUg
YSBmbG93X2xhYmVsIHZhbHVlIGFzOg0KPiAgICBEc3RRUG4gWzMgQnl0ZXNdDQo+ICAgIFNyY1FQ
biBbMyBCeXRlc10NCj4gICAgdTY0IGhhc2ggPSBEc3RRUG4gKiBTcmNRUG47DQo+ICAgIGhhc2gg
Xj0gKGhhc2ggPj4gMjApOw0KPiAgICBoYXNoIF49IChoYXNoID4+IDQwKTsNCj4gICAgQUhfQVRU
Ui5HUkguZmxvd19sYWJlbCA9IGhhc2ggQU5EIElCX0dSSF9GTE9XTEFCRUxfTUFTSzsNCj4gDQo+
IEhhc2ggQ2FsY3VsYXRpb24gZm9yIFVEUCBzcmNfcG9ydA0KPiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gUHJvdmlkZXJzIHN1cHBvcnRpbmcgUm9DRXYyIHdpbGwgdXNlIHRo
ZSAnZmxvd19sYWJlbCcgdmFsdWUgYXMgaW5wdXQgdG8NCj4gY2FsY3VsYXRlIHRoZSBSb0NFdjIg
VURQIHNyY19wb3J0LCB3aGljaCB3aWxsIGJlIHVzZWQgaW4gdGhlIFFQIGNvbnRleHQgb3IgdGhl
DQo+IEFIIGNvbnRleHQuDQo+IA0KPiBVRFAgc3JjX3BvcnQgY2FsY3VsYXRpb25zIGZyb20gZmxv
dyBsYWJlbDoNCj4gW3doaWxlIGNvbnNpZGVyaW5nIHRoZSAxNCBiaXRzIFVEUCBwb3J0IHJhbmdl
IGFjY29yZGluZyB0byBJQU5BIHJlY29tbWVuZGF0aW9uXQ0KPiAgICBBSF9BVFRSLkdSSC5mbG93
X2xhYmVsIFsyMCBiaXRzXQ0KPiAgICB1MzIgZmxfbG93ICA9IGZsICYgMHgwM0ZGRjsNCj4gICAg
dTMyIGZsX2hpZ2ggPSBmbCAmIDB4RkMwMDA7DQo+ICAgIHUxNiB1ZHBfc3BvcnQgPSBmbF9sb3cg
WE9SIChmbF9oaWdoID4+IDE0KTsNCj4gICAgUm9DRS5VRFAuc3JjX3BvcnQgPSB1ZHBfc3BvcnQg
T1IgSUJfUk9DRV9VRFBfRU5DQVBfVkFMSURfUE9SVA0KPiANCj4gICAgI2RlZmluZSBJQl9ST0NF
X1VEUF9FTkNBUF9WQUxJRF9QT1JUIDB4QzAwMA0KPiANCj4gVGhpcyBpcyBhIHYyIGZvbGxvdy11
cCBvbiAiW1JGQ10gUm9DRSB2Mi4wIFVEUCBTb3VyY2UgUG9ydCBFbnRyb3B5IiBbMV0NCj4gDQo+
IFsxXSBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1yZG1hL21zZzczNzM1Lmh0
bWwNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggUm9zZW5iYXVtIDxhbGV4ckBtZWxsYW5veC5j
b20+DQo+IA0KDQo=
