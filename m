Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0F169281
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2020 01:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgBWAoS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Feb 2020 19:44:18 -0500
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:5440
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbgBWAoS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 Feb 2020 19:44:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mclff3GUa0VaEsRQVoS9DORKso34y6Ay76ichAKQohvwe6buYk8NidQbiCjrcRZPeSjeXAb1SgC34r9mQvqaJ/YkP/nKwX/LsqiygartNLIaoRrM2iI8qAg+UZ9rSH8pwnfsD5uCgB/el53hlT4x4AhdwbT+odJHvaGsyFdod/17dQDSTUmBrrayEMPlr6LNbWlh6mWrFv01B58uFpZe2vWbn37ffX/odfI7jsKjaisY9DRsXIVSOPGLsihEU8EkIikoIFf/KyS2/iprVbV66syiqs0CV4f+CanPDyv0uQvT8r2/ntpMCfYropzl/N04nULR3+QmMPbk9jfMDNyGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atqw30KUkceML31NPv4wfL+rHjxCWoVrH85//VcB1sw=;
 b=gmtg+8am1/jp+PIQo6CV/gQfTZCcz8OwQIi8nQLX8zG62H53/Ce9wuNB5AZ7GgE7FRg7746EzsuZiLiT5egCjQ/b/FiRY9ROXBlMLuOscy7Ls7lhbZRPf3zDlJiW0woiDjnCyvvGeHmPHkeBZAnVNt5FYNecJ66GE0adOntesIVqy6pw1PZa2knhU1HIGU/q4HUDWfUNKv8SYCxrW3BWoQ76Ho9XfWOOB2THE4hWMjyhs9E8AGPuHyfREz3br0xfRq9zxG9BsscG4Bk8nNytL4rtheXXcpVTH5BbBLliqJvS71cyI5E5xxEuf0Wq0GLbDhqIRz+giPAC7aa/V13/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atqw30KUkceML31NPv4wfL+rHjxCWoVrH85//VcB1sw=;
 b=kmy/uoyOGP0em7slhtaWPsJdAXOk9IFQOqqkCvnTy4FMYbA1PtjIanErbiBCJD26z8kj5QqKtecrxlldz8zW2uJLDgdEo+40OlLPFC+xw0rB1IsRnGkRT4/n7JhnedwbtHUm25ijDvdgqyR+/btH6OU/n6Hji932GWcNW5zYMSI=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6372.eurprd05.prod.outlook.com (20.179.33.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Sun, 23 Feb 2020 00:44:13 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2750.021; Sun, 23 Feb 2020
 00:44:13 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Thread-Topic: Is anyone working on implementing LAG in ib core?
Thread-Index: AQHV6TLqRqVlI00f7kyTjr5i8r/fvKgn4IQAgAARzwA=
Date:   Sun, 23 Feb 2020 00:44:12 +0000
Message-ID: <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
In-Reply-To: <20200222234026.GO31668@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97c91fa3-2f23-4f86-8695-08d7b7f980be
x-ms-traffictypediagnostic: AM0PR05MB6372:
x-microsoft-antispam-prvs: <AM0PR05MB6372743C18059B58289E6732D1EF0@AM0PR05MB6372.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0322B4EDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(396003)(376002)(136003)(366004)(199004)(189003)(478600001)(5660300002)(186003)(31686004)(26005)(53546011)(6506007)(2616005)(71200400001)(86362001)(6512007)(4326008)(31696002)(6486002)(64756008)(91956017)(8676002)(8936002)(66476007)(54906003)(66556008)(66446008)(110136005)(66946007)(81156014)(81166006)(316002)(36756003)(76116006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6372;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUz2OfQrkBMRngNy9QfkdjyvTqpTOYQKhYB1Vw0u5HTmq4+DYqxjBqJD7EYsj1SkK9JQKDLi0JM3/ITMJbtInnIvta0daN7qR+X+AEpLVhl8Ntn/1EGBotIh9gQViIv7Np9ODGyGQUk03b/FbZoQCPFQIG/heCnq2tFQT1FHLI5zdFhWurGY3g22jeflD6tdbNBowUJWDDZzDzTXA1eirga7LM9p+VKOF/DO+ktNtu+N+BKYFr6EAyIhdv5MP7Dy69Bk6CS86upcpV0U2mZ3TQdwZaIbgLx2MmanLsAKk+AOIOnpLHLPdrlPgzOwgdQeTrDUhLoECKQY8rIvrT9NiegPhYegvT2pfXwgobrF6HHAYXhemeh2NIUue3eja/nwHQJgkfdLTvvCtKwFvs+Q4En4iQV/+AuEoqGP3uMqR19y76Zcw4IA3mSPd3VBQsjo
x-ms-exchange-antispam-messagedata: 4wam7g9NEc7U32uqcf7QNX8Rx7cRltxq50qpB3U1nqtIodaQtjdkg2mdJXFOJWFm73+N5QH9Wx5U2wkOHQfUOE9YQC3rlj0zGm0rxjT+alzZI4YTJ2KbsKZuSwnfamjJGPjzCwSI2/rkIYYz1OORug==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FBA41C9CC68A04A8EA9F41A4928C9C2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c91fa3-2f23-4f86-8695-08d7b7f980be
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2020 00:44:12.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAP/3QUT/Nv0vch59V6YdHUtZEwmL8BNWnbGhN296fj+a/Qd7jL1UgnVwPbfNbOAk09vdSvP6KQB7pkizYdI8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6372
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgSmFzb24sIFdlaWhhbmcsDQoNCk9uIDIvMjIvMjAyMCA1OjQwIFBNLCBKYXNvbiBHdW50aG9y
cGUgd3JvdGU6DQo+IE9uIFNhdCwgRmViIDIyLCAyMDIwIGF0IDExOjQ4OjA0QU0gKzA4MDAsIFdl
aWhhbmcgTGkgd3JvdGU6DQo+PiBIaSBhbGwsDQo+Pg0KPj4gV2UgcGxhbiB0byBpbXBsZW1lbnQg
TEFHIGluIGhucyBkcml2ZXJzIHJlY2VudGx5LCBhbmQgYXMgd2Uga25vdywgdGhlcmUgaXMNCj4+
IGFscmVhZHkgYSBtYXR1cmUgYW5kIHN0YWJsZSBzb2x1dGlvbiBpbiB0aGUgbWx4NSBkcml2ZXIu
IENvbnNpZGVyaW5nIHRoYXQNCj4+IHRoZSBuZXQgc3Vic3lzdGVtIGluIGtlcm5lbCBhZG9wdCB0
aGUgc3RyYXRlZ3kgdGhhdCB0aGUgZnJhbWV3b3JrIGltcGxlbWVudA0KPj4gYm9uZGluZywgd2Ug
dGhpbmsgaXQncyByZWFzb25hYmxlIHRvIGFkZCBMQUcgZmVhdHVyZSB0byB0aGUgaWIgY29yZSBi
YXNlZA0KPj4gb24gbWx4NSdzIGltcGxlbWVudGF0aW9uLiBTbyB0aGF0IGFsbCBkcml2ZXJzIGlu
Y2x1ZGluZyBobnMgYW5kIG1seDUgY2FuDQo+PiBiZW5lZml0IGZyb20gaXQuDQo+Pg0KPj4gSW4g
cHJldmlvdXMgZGlzY3Vzc2lvbnMgd2l0aCBMZW9uIGFib3V0IGFjaGlldmluZyByZXBvcnRpbmcg
b2YgaWIgcG9ydCBsaW5rDQo+PiBldmVudCBpbiBpYiBjb3JlLCBMZW9uIG1lbnRpb25lZCB0aGF0
IHRoZXJlIG1pZ2h0IGJlIHNvbWVvbmUgdHJ5aW5nIHRvIGRvDQo+PiB0aGlzLg0KPj4NCj4+IFNv
IG1heSBJIGFzayBpZiB0aGVyZSBpcyBhbnlvbmUgd29ya2luZyBvbiBMQUcgaW4gaWIgY29yZSBv
ciBwbGFubmluZyB0bw0KPj4gaW1wbGVtZW50IGl0IGluIG5lYXIgZnV0dXJlPyBJIHdpbGwgYXBw
cmVjaWF0ZSBpdCBpZiB5b3UgY2FuIHNoYXJlIHlvdXINCj4+IHByb2dyZXNzIHdpdGggbWUgYW5k
IG1heWJlIHdlIGNhbiBmaW5pc2ggaXQgdG9nZXRoZXIuDQo+Pg0KPj4gSWYgbm9ib2R5IGlzIHdv
cmtpbmcgb24gdGhpcywgb3VyIHRlYW0gbWF5IHRha2UgYSB0cnkgdG8gaW1wbGVtZW50IExBRyBp
bg0KPj4gdGhlIGNvcmUuIEFueSBjb21tZW50cyBhbmQgc3VnZ2VzdGlvbiBhcmUgd2VsY29tZS4N
Cj4gDQo+IFRoaXMgaXMgc29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgZG9uZSwgSSB1bmRlcnN0
YW5kIHNldmVyYWwgb2YgdGhlDQo+IG90aGVyIGRyaXZlcnMgYXJlIGdvaW5nIHRvIHdhbnQgdG8g
dXNlIExBRyBhbmQgd2UgY2VydGFpbmx5IGNhbid0IGhhdmUNCj4gZXZlcnl0aGluZyBjb3BpZWQg
aW50byBlYWNoIGRyaXZlci4NCj4gDQo+IEphc29uDQo+IA0KSSBhbSBub3Qgc3VyZSBtbHg1IGlz
IHJpZ2h0IG1vZGVsIGZvciBuZXcgcmRtYSBib25kIGRldmljZSBzdXBwb3J0IHdoaWNoDQpJIHRy
aWVkIHRvIGhpZ2hsaWdodCBpbiBRJkEtMSBiZWxvdy4NCg0KSSBoYXZlIGJlbG93IG5vdC1zby1y
ZWZpbmVkIHByb3Bvc2FsIGZvciByZG1hIGJvbmQgZGV2aWNlLg0KDQotIENyZWF0ZSBhIHJkbWEg
Ym9uZCBkZXZpY2UgbmFtZWQgcmJvbmQwIHVzaW5nIHR3byBzbGF2ZSByZG1hIGRldmljZXMNCm1s
eDVfMCBtbHg1XzEgd2hpY2ggaXMgY29ubmVjdGVkIHRvIG5ldGRldmljZSBib25kMSBhbmQgdW5k
ZXJseWluZyBkbWENCmRldmljZSBvZiBtbHg1XzAgcmRtYSBkZXZpY2UuDQoNCiQgcmRtYSBkZXYg
YWRkIHR5cGUgYm9uZCBuYW1lIHJib25kMCBuZXRkZXYgYm9uZDEgc2xhdmUgbWx4NV8wIHNsYXZl
DQptbHg1XzEgZG1hZGV2aWNlIG1seDVfMA0KDQokIHJkbWEgZGV2IHNob3cNCjA6IG1seDVfMDog
bm9kZV90eXBlIGNhIGZ3IDEyLjI1LjEwMjAgbm9kZV9ndWlkIDI0OGE6MDcwMzowMDU1OjQ2NjAN
CnN5c19pbWFnZV9ndWlkIDI0OGE6MDcwMzowMDU1OjQ2NjANCjE6IG1seDVfMTogbm9kZV90eXBl
IGNhIGZ3IDEyLjI1LjEwMjAgbm9kZV9ndWlkIDI0OGE6MDcwMzowMDU1OjQ2NjENCnN5c19pbWFn
ZV9ndWlkIDI0OGE6MDcwMzowMDU1OjQ2NjANCjI6IHJib25kMDogbm9kZV90eXBlIGNhIG5vZGVf
Z3VpZCAyNDhhOjA3MDM6MDA1NTo0NjYwIHN5c19pbWFnZV9ndWlkDQoyNDhhOjA3MDM6MDA1NTo0
NjYwDQoNCi0gVGhpcyBzaG91bGQgYmUgZG9uZSB2aWEgcmRtYSBib25kIGRyaXZlciBpbg0KZHJp
dmVycy9pbmZpbmliYW5kL3VscC9yZG1hX2JvbmQNCg0KRmV3IG9idmlvdXMgcXVlc3Rpb25zIGFy
aXNlIGZyb20gYWJvdmUgcHJvcG9zYWw6DQoxLiBCdXQgd2h5IGNhbid0IEkgZG8gdGhlIHRyaWNr
IHRvIHJlbW92ZSB0d28gb3IgbW9yZSByZG1hIGRldmljZShzKSBhbmQNCmNyZWF0ZSBvbmUgZGV2
aWNlIHdoZW4gYm9uZDAgbmV0ZGV2aWNlIGlzIGNyZWF0ZWQ/DQpBbnM6DQooYSkgQmVjYXVzZSBp
dCBsZWFkcyB0byBjb21wbGV4IGRyaXZlciBjb2RlIGluIHZlbmRvciBkcml2ZXIgdG8gaGFuZGxl
DQpuZXRkZXYgZXZlbnRzIHVuZGVyIHJ0bmwgbG9jay4NCkdpdmVuIEdJRCB0YWJsZSBuZWVkcyB0
byBob2xkIHJ0bmwgbG9jayBmb3Igc2hvcnQgZHVyYXRpb24gaW4NCmliX3JlZ2lzdGVyX2Rldmlj
ZSgpLCB0aGluZ3MgbmVlZCB0byBkaWZmZXIgdG8gd29yayBxdWV1ZSBhbmQgcGVyZm9ybQ0Kc3lu
Y2hyb25pemF0aW9uLg0KKGIpIFVzZXIgY2Fubm90IHByZWRpY3Qgd2hlbiB0aGlzIG5ldyByZG1h
IGJvbmQgZGV2aWNlIHdpbGwgYmUgY3JlYXRlZA0KYXV0b21hdGljYWxseSwgYWZ0ZXIgaG93IGxv
bmc/DQooYykgV2hhdCBpZiBzb21lIGZhaWx1cmUgb2NjdXJyZWQsIHNob3VsZCBJIHBhcnNlIC92
YXIvbG9nL21lc3NhZ2VzIHRvDQpmaWd1cmUgb3V0IHRoZSBlcnJvcj8gV2hhdCBzdGVwcyB0byBy
b2xsIGJhY2sgYW5kIHJldHJ5Pw0KKGQpIFdoYXQgaWYgZHJpdmVyIGludGVybmFsbHkgYXR0ZW1w
dCByZXRyeT8uLg0KYW5kIHNvbWUgbW9yZS4uDQoNCjIuIFdoeSBkbyB3ZSBuZWVkIHRvIGdpdmUg
bmV0ZGV2aWNlIGluIGFib3ZlIHByb3Bvc2FsPw0KQW5zOg0KQmVjYXVzZSBmb3IgUm9DRSBkZXZp
Y2UgeW91IHdhbnQgdG8gYnVpbGQgcmlnaHQgR0lEIHRhYmxlIGZvciBpdHMNCm1hdGNoaW5nIG5l
dGRldmljZS4gTm8gZ3Vlc3Mgd29yay4NCg0KMy4gQnV0IHdpdGggdGhhdCB0aGVyZSB3aWxsIGJl
IG11bHRpcGxlIGRldmljZXMgcmJvbmQwLCBtbHg1XzAgd2l0aCBzYW1lDQpHSUQgdGFibGUgZW50
cmllcy4NCkFuZCB0aGF0IHdpbGwgY29uZnVzZSB0aGUgdXNlci4NCldoYXQgZG8gd2UgZG8gYWJv
dXQgaXQ/DQpBbnM6DQpOby4gVGhhdCB3b24ndCBoYXBwZW4sIGJlY2F1c2UgdGhpcyBib25kIGRy
aXZlciBhY2NlcHQgc2xhdmUgcmRtYSBkZXZpY2VzLg0KYm9uZCBkcml2ZXIgd2lsbCByZXF1ZXN0
IElCIGNvcmUgdG8gZGlzYWJsZSBHSUQgdGFibGUgb2Ygc2xhdmUgcmRtYSBkZXZpY2VzLg0KT3Ig
d2UgY2FuIGhhdmUgY29tbWFuZHMgdG8gZGlzYWJsZS9lbmFibGUgc3BlY2lmaWMgR0lEIHR5cGVz
IG9mIHNsYXZlDQpyZG1hIGRldmljZXMsIHdoaWNoIHVzZXIgY2FuIGludm9rZSBiZWZvcmUgY3Jl
YXRpbmcgcmRtYSBib25kIGRldmljZS4NCg0KU3VjaCBhcw0KJCByZG1hIGxpbmsgbWx4NV8wIGRp
c2FibGUgcm9jZXYxDQokIHJkbWEgbGluayBtbHg1XzAgZW5hYmxlIHJvY2V2Mg0KDQpUaGlzIHdh
eSBpdHMgZWFzeSB0byBjb21wb3NlIGFuZCBhZGRyZXNzZWQgd2lkZXIgdXNlIGNhc2Ugd2hlcmUg
Um9DRXYxDQpHSUQgdGFibGUgZW50cmllcyBjYW4gYmUgZGlzYWJsZWQgYW5kIG1ha2UgZWZmaWNp
ZW50IHVzZSBvZiBHSUQgdGFibGUuDQoNCjQuIEJ1dCBpZiB3ZSBhcmUgZ29pbmcgdG8gZGlzYWJs
ZSB0aGUgR0lEIHRhYmxlLCB3aHkgZG8gd2UgZXZlbiBuZWVkDQp0aG9zZSBSRE1BIGRldmljZXM/
DQpBbnM6DQpCZWNhdXNlIHdoZW4geW91IGRlbGV0ZSB0aGUgYm9uZCByZG1hIGRldmljZSwgeW91
IGNhbiByZXZlcnQgYmFjayB0bw0KdGhvc2UgbWx4NV8wLzEgZGV2aWNlcy4NCkZvbGx3byBtaXJy
b3Igb2YgYWRkIGluIGRlbGV0ZS4NCg0KNS4gV2h5IGRvIHdlIG5lZWQgdG8gZ2l2ZSBETUEgZGV2
aWNlPw0KQW5zOg0KQmVjYXVzZSB3ZSB3YW50IHRvIGF2b2lkIGRvaW5nIGd1ZXNzIHdvcmsgaW4g
cmRtYV9ib25kIGRyaXZlciBvbiB3aGljaA0KRE1BIGRldmljZSB0byB1c2UuDQpVc2VyIGtub3dz
IHRoZSBjb25maWd1cmF0aW9uIG9mIGhvdyBoZSB3YW50cyB0byB1c2UgaXQgYmFzZWQgb24gdGhl
DQpzeXN0ZW0uIChpcnFzIGV0YykuDQoNCjYuIFdoYXQgaGFwcGVucyBpZiBzbGF2ZSBwY2kgZGV2
aWNlcyBhcmUgaG90IHJlbW92ZWQ/DQpBbnM6DQpJZiBzbGF2ZSBkbWEgZGV2aWNlIGlzIHJlbW92
ZWQsIGl0IGRpc2Fzc29jaWF0ZXMgdGhlIHVjb250ZXh0IGFuZCByYm9uZDANCmJlY29tZXMgdW51
c2FibGUgZm9yIGFwcGxpY2F0aW9ucy4NCg0KNy4gSG93IGlzIHRoZSBmYWlsb3ZlciBkb25lPw0K
QW5zOiBTaW5jZSBmYWlsb3ZlciBuZXRkZXZpY2UgaXMgcHJvdmlkZWQsIGl0cyBmYWlsb3ZlciBz
ZXR0aW5ncyBhcmUNCmluaGVyaXRlZCBieSByYm9uZDAgcmRtYSBkZXZpY2UgYW5kIHBhc3NlZCBv
biB0byBpdHMgc2xhdmUgZGV2aWNlLg0K
