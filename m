Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B277D14FC3C
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Feb 2020 09:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgBBIHB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Feb 2020 03:07:01 -0500
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:6787
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgBBIHA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 Feb 2020 03:07:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjcoQawLBw2Dur9zO17sowOaq+6MXNbYWos8shEK+z8jaTeIJyr+ndyTWF3eDRHPIdHmCmpvMJ7JMSohRxADWjp562HWhCxjQNDwEzh4XMncclj2gC8XXlH40BrZKO+PV6QdQm8JWiOdwonU3W7mdFz3vFpFibk+VHStGBhz3Sem3tzeZSpHA6rtjbhruZdabCRJYIoG5s42j2HFIxf5TPWm9cYoUZwH5qdWLqMxWmts6l5wlPgHMMwfjsjStp+0Gm9ktMHmQfrreoi1QWM9WzN2iYCKxQFdzljASVrOcqf4Ox1/5OJ2kBOSk2XOctQu5OyOxt3uMsIVLEyLFpuEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB4b8q2vg558whzH2W0IzqFaRTKLpLegenllt7/U45E=;
 b=nLoTGwEJynjaSvv2XdO+KCBm6XvRFbUoqVzzB5QhEs+rvjLBx3QSm9vj93tBUr1pq2WAIsn0YXwB5NT8zGzp5QkQfn4HcvfvCMmeMPS7gADCRNojGnf/A1frScedri9+ifdiAHdsSVCCXQgLMkQpwWp1ztAoHu01dlNUNGh4It9vqksIsZ6YV5V9Aj7dtxgdolpw4qvwEMMDthl+lInp88LelfclbJk6z2morjyddG1jCrRU+UaoiKTNE0cRMFi7lJLRzIR0XVdfo+0/Um0GDyQdmoZolclJZoi8jtpJ5JiQVgre3MqI/coMxzAWcYWQ6Hjhn3eREV7RBAayF/TeqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB4b8q2vg558whzH2W0IzqFaRTKLpLegenllt7/U45E=;
 b=KAuHvVRXp4GXgdBG4747pN+tpojsUp8EQrWphm9duUVK7F+M3K/2VVwoKv3/9OBhEBc3Vr33QZVlXfTZZy6zliko/LM84qQlmav0iYJn9lYGPxEVSPOKC6YoRgJqB/RRrz46FtajoDxoFAp7TLBBFEpos2aqKeTDf+5Pk2VQBdM=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6772.eurprd05.prod.outlook.com (10.186.174.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sun, 2 Feb 2020 08:06:57 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.031; Sun, 2 Feb 2020
 08:06:57 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: RDMA without rdma_create_event_channel()
Thread-Topic: RDMA without rdma_create_event_channel()
Thread-Index: AQHV2LyMcnUOPMkllUmX4yFVPngic6gGBI6AgAEN3ICAAHopwA==
Date:   Sun, 2 Feb 2020 08:06:57 +0000
Message-ID: <AM0PR05MB4866A0705E7F48EB316F544DD1010@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <CAOc41xEmgiw_xekLuhi6uYZ+rKdMrv=5wOJWKisbpYPpBJsdkA@mail.gmail.com>
 <20200201083845.GF414821@unreal>
 <CAOc41xEvwbr5RUMgD2HqEyiX4N6jB0-6mA8btiDbf-moh60oKw@mail.gmail.com>
In-Reply-To: <CAOc41xEvwbr5RUMgD2HqEyiX4N6jB0-6mA8btiDbf-moh60oKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82682321-f26f-4284-a529-08d7a7b6dfad
x-ms-traffictypediagnostic: AM0PR05MB6772:
x-microsoft-antispam-prvs: <AM0PR05MB67726B013555CF9A5A69A4A1D1010@AM0PR05MB6772.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0301360BF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(136003)(366004)(346002)(396003)(199004)(189003)(26005)(5660300002)(186003)(316002)(33656002)(7116003)(8936002)(52536014)(110136005)(9686003)(55016002)(66476007)(2906002)(66446008)(64756008)(66556008)(76116006)(55236004)(478600001)(66946007)(7696005)(81156014)(81166006)(71200400001)(8676002)(86362001)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6772;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BaNiy9WBqOevyVmwqyyN2VCEZIBy8EnZtdXZjzwejnKx5P7YV/RT30Z7/6yP1CbAG2MOI3O2G0E9jNLkQQFZnzXFrKSbpXThqQf78sy4DPQoipK5T+bCqmc5C3LXBpgEfBw+53yBtCLSlXS1fBR+285lUeXujMQzHNt1vCr5lw5EZt22wg2UnGFfoi00chxysHlRKJasKZ7WpouQwySkTB45nCdENm9gehPKffvhq22//WZdn4AqDVo6UVUOShVRAEelsN6v6McOSA++26NcrmeYrUJVleeC7t7bWgY2Jo4xrkQRh5F6fbRrffXT483TuKhLt29quZv2qhMXrajsktJuJgE3PdipVCfnM9KyroY8OZyoD+9Tdcen5Ldf0hNVleW31gWhJLA9c8/MlywOnpQughjzBCzeewKyLEGUD49aWNaYgxBUgUe3Irw/0XPj
x-ms-exchange-antispam-messagedata: zVHcy8HRIXKDRR2lf4PsW5XjK6oe+5upC5eH6S8g+UG718JDbKgOCOsDO9qogpIhM6zi5QyGXx6zuyS0fLRezUXULVqTSB6mVntK4oiMSvKXmD8+nDoCi910bTIOgED/0Z0Hv4w5fhoVrtglb9AB5Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82682321-f26f-4284-a529-08d7a7b6dfad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2020 08:06:57.3011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgF3pt3nDF/GyygRv3auV481PuxGg39/O/7kWKDdtnAdPxAowCl8L3r/hIih8Ug5DByWL26aBjH8vkbKH4Taiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6772
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgRGltdHJpcywNCg0KPiANCj4gSXQgc2VlbXMgUkRNQSBSQyBpcyBjb21wbGV0ZWx5IG9wdGlv
bmFsLCBvbmx5IHRoZSBkZWZhdWx0L3N0YW5kYXJkaXplZCB3YXkgb2YNCj4gZXhjaGFuZ2luZyBw
YXJhbWV0ZXJzIGFuZCBhbnkgY3VzdG9tIHdheSB3aWxsIGRvLg0KPiANCj4gTW9zdCBoZWxwZnVs
LCB0aGFuayB5b3UuDQoNCk1heSBJIGFzayB0aGUgbGltaXRhdGlvbiB0aGF0IHlvdSBhcmUgZmFj
aW5nIHdpdGggcmRtYWNtIGR1ZSB0byB3aGljaCANCihhKSB5b3Ugd2FudCB0byBhdm9pZCBpdCBh
bmQgcmVhZHkgdG8gZG8gZXh0cmEgY29kZSBmb3IgSVAgdG8gcmlnaHQgR0lEIG1hcHBpbmcgZm9y
IFJvQ0V2Mi4NCihiKSBpbXBsZW1lbnQgbmV3IGNvbm5lY3Rpb24gbWFuYWdlbWVudA0KDQpXaXRo
IHRoYXQgc29tZSBob3cgeW91IGFyZSBhbHNvIGVuc3VyaW5nIHRoYXQgYm90aCBwYWNrZXRzIChj
b25uZWN0aW9uIG1hbmFnZW1lbnQgdmlhIHNvbWUgc29ja2V0KSBhbmQgcmRtYV92MiBmb2xsb3cg
dGhlIHNhbWUgcGF0aCBpbiBuZXR3b3JrPw0KSSBhbSBjdXJpb3VzIHRvIGtub3cgaG93IGFyZSB5
b3UgZ29pbmcgdG8gZW5zdXJlIHRoaXMgYXQgY2x1c3RlciBzY2FsZT8NCklmIHlvdSBjYW4gcGxl
YXNlIHNoYXJlIGl0LCBpdCB3aWxsIGJlIHVzZWZ1bCB0byBtZS4NCg0KUGFyYXYNCg0KPiANCj4g
RGltaXRyaXMNCj4gDQo+IE9uIFNhdCwgRmViIDEsIDIwMjAgYXQgMTI6MzkgQU0gTGVvbiBSb21h
bm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCBKYW4gMzEs
IDIwMjAgYXQgMDk6MDA6MjRQTSAtMDgwMCwgRGltaXRyaW9zIERpbWl0cm9wb3Vsb3Mgd3JvdGU6
DQo+ID4gPiBIaSwNCj4gPiA+DQo+ID4gPiBJJ20gbG9va2luZyB0byBjb25uZWN0IGFuIFJETUEg
aGFyZHdhcmUgYWNjZWxlcmF0b3IgdG8gYSBDZW50b3MgOC4wDQo+ID4gPiBzZXJ2ZXIgd2l0aCBS
b0NFX1YyIGNhcGFiaWxpdHkuDQo+ID4gPg0KPiA+ID4gSXMgdGhlcmUgYSB3YXkgdG8gaW1wbGVt
ZW50IFJETUEgUkMgZnVuY3Rpb25hbGl0eSB3aXRob3V0IGludm9raW5nDQo+ID4gPiB0aGUgQ29u
bmVjdGlvbiBNYW5hZ2VyIChza2lwcGluZyB0aGUgcmRtYV9jcmVhdGVfZXZlbnRfY2hhbm5lbCgp
KSA/DQo+ID4gPiBQZXJoYXBzIHdpdGggYSBzaW1wbGUgZXhjaGFuZ2Ugb2YgdGhlIG5lY2Vzc2Fy
eSBpbmZvcm1hdGlvbiB0aHJvdWdoDQo+ID4gPiBhbiBleHRlcm5hbCBwcm90b2NvbCwgc2F5IFVE
UCBwYWNrZXRzID8gQW5kIHRoZW4gaW5pdGlhbGl6ZSB0aGUgUVBzDQo+ID4gPiB3aXRoIHRoZSBy
ZWNlaXZlZCBwYXJhbWV0ZXJzLg0KPiA+DQo+ID4NCj4gPiBZb3UgY2FuIGRvIGl0IHdpdGhvdXQg
UkRNQS1DTSwgc2VlIGxpYmlidmVyYnMvL2V4YW1wbGVzL3JjX3Bpbmdwb25nLmMNCj4gPiBmb3Ig
ZXhhY3RseSB0aGF0Lg0KPiA+DQo+ID4gVGhhbmtzDQo=
