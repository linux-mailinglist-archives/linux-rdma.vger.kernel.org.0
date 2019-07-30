Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9527A100
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfG3GEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 02:04:44 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:44607 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfG3GEo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 02:04:44 -0400
X-Greylist: delayed 39979 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 02:04:41 EDT
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.146) BY m4a0040g.houston.softwaregrp.com WITH ESMTP;
 Tue, 30 Jul 2019 06:04:40 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 30 Jul 2019 06:04:18 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 30 Jul 2019 06:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZnqmwFBm7MaeI3pULUBxsQK2YYkZanxlsRp46/fIXhAWlvdR5GVcgBnjtL1TQZGlEYjd0WVMNLI9UtEyjD+JfkYWu0tRaGKPUGRwMB/V83tatnFGfxuiDjPTcmioz2fOWMc6cygTI+04e2W1NJ69vDULzifHWgWKCGuv9SoRiW8UcMc6zCb70VqwZBOKWasfMEr6YA2dNkfdpd+qJg9gbCFj+bAyt/VTJSdpsEEqxT0lu3a74uz1db4n6AsATrxHj24+SJ1Yj2JIkCAJBTyAiXCUzfh/K6lm8r3ocwCzAiuaTS7Aojw0HS6bAS1dKLEXgPG5FWrkcoUEP77S1++wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4fgFlx+JaRtU7YwBZmaN558J8ldN2BGoVBHmeGrmQg=;
 b=JOk1LoD/tuBL4QB/g8wLNCYOkLpw+iaL3jalWkXIQqXbP7RltP913W+U979SvH1uJP3ON7yJB1Fx04Xf++JjmG8oNdqmEQiz2B1EgUBFKhQFQPIAdZ4HDHnIjNH+IDxRe5OxXFvd2imI3Ts5PpyrTmY0+oIYc+TC/tSmishd8PotoKcB20QHG8iF2h3Ir6GHsott1jt8wv/c9IZ+p1Z8J4I3QSWlK4nHK4rXWNJyyj9BxujZzDARzvW3CqMMnYdRmqlL0nwvQCPcQicz/zXVz06wDMQ5+Wvhc7MfXkg4V3pEQIAsZHiFOFEgN9xkTJE13LGGW/Yluqye4CJNx7Jidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CY4PR18MB1240.namprd18.prod.outlook.com (10.172.176.10) by
 CY4PR18MB1399.namprd18.prod.outlook.com (10.172.176.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 06:04:17 +0000
Received: from CY4PR18MB1240.namprd18.prod.outlook.com
 ([fe80::e548:277f:9d22:e8f8]) by CY4PR18MB1240.namprd18.prod.outlook.com
 ([fe80::e548:277f:9d22:e8f8%12]) with mapi id 15.20.2094.017; Tue, 30 Jul
 2019 06:04:17 +0000
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
To:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC] mlx5: add parameter to disable enhanced IPoIB
Thread-Topic: [RFC] mlx5: add parameter to disable enhanced IPoIB
Thread-Index: AQHVRj9ohuRLHy8cmUmnUbAt1DZZQKbiEAwmgACcq4A=
Date:   Tue, 30 Jul 2019 06:04:17 +0000
Message-ID: <f1778c16-db19-ced4-3172-aeaab6698b42@suse.com>
References: <42703d01-0496-a4ce-6599-5115e49290af@suse.com>
 <f1e27e28a420e2123242bfbc196796ba250f15e4.camel@redhat.com>
In-Reply-To: <f1e27e28a420e2123242bfbc196796ba250f15e4.camel@redhat.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0200.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::20) To CY4PR18MB1240.namprd18.prod.outlook.com
 (2603:10b6:903:108::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=NMoreyChaisemartin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.220.97.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a874d02d-f53a-4652-2655-08d714b3c120
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR18MB1399;
x-ms-traffictypediagnostic: CY4PR18MB1399:
x-microsoft-antispam-prvs: <CY4PR18MB13996C5E2F3293FF94465703BFDC0@CY4PR18MB1399.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(189003)(199004)(54524002)(76176011)(316002)(102836004)(52116002)(386003)(53546011)(66556008)(31696002)(8676002)(3846002)(186003)(6506007)(66476007)(26005)(6512007)(2501003)(66446008)(64756008)(53936002)(5660300002)(446003)(66946007)(6436002)(229853002)(6486002)(2616005)(71200400001)(476003)(7736002)(11346002)(86362001)(80792005)(8936002)(486006)(81166006)(81156014)(71190400001)(2906002)(68736007)(66066001)(36756003)(478600001)(99286004)(6116002)(25786009)(305945005)(256004)(31686004)(14454004)(110136005)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR18MB1399;H:CY4PR18MB1240.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cRaK+tHYkq9vcOXzfmKuvLn37s7QMu6WyD0tp+qt3jdTzmvAeR94+LSmNqJoCss3N4nZuYEocBEJQb0dUS3fZ7wnmaFwAYNPHbRhA0X/wN7/Gnp4faO72gdYUJISjiHnYA0mw6mSRzEXigjF1X9oTSdZ0dHm34jBZ71jDvgBOSWA2WBtY84kSjP46rbF8FUaq+WoXGDAOr0abHmlEZK3kF/ouz9BJsK39+pEml0NdzQcaWWVBbctUX3mC8bMdrMYQPZTpi1w8s6J5j63pt6yfPepH1O0MMqpQfRdaFtBEs9fdYLMZn+h2BKrWmUD99S17Zc0xWWPNtKoUTDfFQcBFkoun9FxVdOWYypZdlqQBzg/krZqzs2uP+rdo1+d9+EQJ1pijDY54FR9Lww8TBNI08SlSqcUE33se8ANrzvYGkQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F6D08AE1B269441B5F6A9A2B184047D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a874d02d-f53a-4652-2655-08d714b3c120
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 06:04:17.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMoreyChaisemartin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1399
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCk9uIDcv
MjkvMTkgMTA6NDIgUE0sIERvdWcgTGVkZm9yZCB3cm90ZToNCj4gT24gTW9uLCAyMDE5LTA3LTI5
IGF0IDE4OjU3ICswMDAwLCBOaWNvbGFzIE1vcmV5LUNoYWlzZW1hcnRpbiB3cm90ZToNCj4+IFJl
Y2VudCBDb25uZXh0WC1bNDVdIEhDQSBoYXZlIGVuaGFuY2VkIElQb0lCIGVuYWJsZWQgd2hpY2gg
cHJldmVudHMNCj4+IHRoZSB1c2Ugb2YgdGhlIGNvbm5lY3RlZCBtb2RlLg0KPj4gQWx0aG91Z2gg
bm90IGFuIGlzc3VlIGluIGEgZnVsbHkgY29tcGF0aWJsZSBzZXR1cCwgaXQgY2FuIGJlIGFuIGlz
c3VlDQo+PiBpbiBhIG1peGVkIEhXIG9uZS4NCj4+DQo+PiBNZWxsYW5veCBPRkVEIHVzZXMgYSBp
cG9pYl9lbmhhbmNlZCBmbGFnIG9uIHRoZSBpYl9pcG9pYiBtb2R1bGUgdG8NCj4+IHdvcmsgYXJv
dW5kIHRoZSBpc3N1ZS4NCj4+IFRoaXMgcGF0Y2ggYWRkcyBhIHNpbWlsYXJseSBuYW1lIGZsYWcg
dG8gdGhlIG1seDVfaWIgbW9kdWxlIHRvIGRpc2FibGUNCj4+IGVuaGFuY2VkIElQb0lCIGZvcg0K
Pj4gYWxsIG1seDUgSENBIGFuZCBhbGxvdyB1c2VycyB0byBwaWNrIGRhdGFncmFtL2Nvbm5lY3Rl
ZCB0aGUgdXN1YWwgd2F5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgTW9yZXktQ2hh
aXNlbWFydGluIDxubW9yZXljaGFpc2VtYXJ0aW5Ac3VzZS5jb20NCj4+Pg0KPj4gLS0tDQo+PiAg
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWFpbi5jIHwgNSArKysrKw0KPj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21seDUvbWFpbi5jDQo+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L21h
aW4uYw0KPj4gaW5kZXggYzJhNTc4MGNiMzk0Li43NzlhMzU4ODM0OTQgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tYWluLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tbHg1L21haW4uYw0KPj4gQEAgLTc4LDYgKzc4LDEwIEBAIE1PRFVMRV9BVVRI
T1IoIkVsaSBDb2hlbiA8ZWxpQG1lbGxhbm94LmNvbT4iKTsNCj4+ICBNT0RVTEVfREVTQ1JJUFRJ
T04oIk1lbGxhbm94IENvbm5lY3QtSUIgSENBIElCIGRyaXZlciIpOw0KPj4gIE1PRFVMRV9MSUNF
TlNFKCJEdWFsIEJTRC9HUEwiKTsNCj4+ICANCj4+ICtzdGF0aWMgaW50IGlwb2liX2VuaGFuY2Vk
ID0gMTsNCj4+ICttb2R1bGVfcGFyYW0oaXBvaWJfZW5oYW5jZWQsIGludCwgMDQ0NCk7DQo+PiAr
TU9EVUxFX1BBUk1fREVTQyhpcG9pYl9lbmhhbmNlZCwgIkVuYWJsZSBJUG9JQiBlbmhhbmNlZCBm
b3IgY2FwYWJsZQ0KPj4gZGV2aWNlcyAoZGVmYXVsdCA9IDEpICgwLTEpIik7DQo+PiArDQo+PiAg
c3RhdGljIGNoYXIgbWx4NV92ZXJzaW9uW10gPQ0KPj4gIAlEUklWRVJfTkFNRSAiOiBNZWxsYW5v
eCBDb25uZWN0LUlCIEluZmluaWJhbmQgZHJpdmVyIHYiDQo+PiAgCURSSVZFUl9WRVJTSU9OICJc
biI7DQo+PiBAQCAtNjM4Myw2ICs2Mzg3LDcgQEAgc3RhdGljIGludCBtbHg1X2liX3N0YWdlX2Nh
cHNfaW5pdChzdHJ1Y3QNCj4+IG1seDVfaWJfZGV2ICpkZXYpDQo+PiAgCQkoMXVsbCA8PCBJQl9V
U0VSX1ZFUkJTX0VYX0NNRF9ERVNUUk9ZX0ZMT1cpOw0KPj4gIA0KPj4gIAlpZiAoTUxYNV9DQVBf
R0VOKG1kZXYsIGlwb2liX2VuaGFuY2VkX29mZmxvYWRzKSAmJg0KPj4gKwkgICAgaXBvaWJfZW5o
YW5jZWQgJiYNCj4+ICAJICAgIElTX0VOQUJMRUQoQ09ORklHX01MWDVfQ09SRV9JUE9JQikpDQo+
PiAgCQlpYl9zZXRfZGV2aWNlX29wcygmZGV2LT5pYl9kZXYsDQo+PiAgCQkJCSAgJm1seDVfaWJf
ZGV2X2lwb2liX2VuaGFuY2VkX29wcyk7DQo+IA0KPiBNb2R1bGUgcGFyYW1ldGVycyBhcmUgaGln
aGx5IGZyb3duZWQgdXBvbiBpbiBnZW5lcmFsLCBhbmQgaW4gdGhpcw0KPiBwYXJ0aWN1bGFyIGlu
c3RhbmNlLCBJIGNvdWxkIGVhc2lseSBzZWUgd2hlcmUgaWYgeW91IGhhZCBhIGR1YWwgcG9ydCBJ
Qg0KPiBjYXJkLCB3aXRoIG9uZSBwb3J0IHBsdWdnZWQgaW50byBhIGZ1bGx5IGNvbXBhdGlibGUg
c2V0dXAsIGFuZCB0aGUgb3RoZXINCj4gcG9ydCBwbHVnZ2VkIGludG8gYSBtb3JlIGhldGVyb2dl
bmVvdXMgc2V0dXAgKHNheSBhIEx1c3RyZSBiYWNrZW5kIG9yDQo+IHNvbWV0aGluZyksIHRoYXQg
eW91IHJlYWxseSB3YW50IHRoaXMgdG8gYmUgb24gYSBwZXItcG9ydCBiYXNpcy4gIFNvLA0KPiBJ
J20gZ29ubmEgc2F5IHRoaXMgaXMgYSBuYWsgdW5sZXNzIE1lbGxhbm94IGNvbWVzIGJhY2sgYW5k
IHNheXMgZG9pbmcNCj4gdGhpcyBwZXItcG9ydCBpcyBzdHJpY3RseSBub3QgcG9zc2libGUgKGFu
ZCBldmVuIGlmIGl0IG11c3QgYmUgcGVyLWNhcmQNCj4gb3IgZHJpdmVyIHdpZGUsIEkgd291bGQg
c3RpbGwgcHJlZmVyIG1heWJlIGEgbmV0bGluayBjb250cm9sIHRvIGEgbW9kdWxlDQo+IG9wdGlv
biwgaWYgZm9yIG5vIG90aGVyIHJlYXNvbiB0aGFuIEkgZG9uJ3Qgd2FudCB0byBoZWFyIHRoZSBn
cm9hbnMgZnJvbQ0KPiBvdGhlciBrZXJuZWwgZm9sayBpZiBJIHRha2UgYSBtb2R1bGUgb3B0aW9u
IG5vdyBhIGRheXMpLg0KPiANCg0KSSBmZWFyZWQgYXMgbXVjaCBidXQgZmlndXJlZCBpdCB3b3Vs
ZCBuZSB3b3J0aCBhIHNob3QuDQpJJ2xsIGhhdmUgYSBsb29rIGF0IGhvdyB3ZSBjYW4gZGVhbCB3
aXRoIHRoaXMgbmljZWx5LiBCdXQgaXQgbWlnaHQgbm90IGJlIHRoYXQgZWFzeSB0byBjaGFuZ2Ug
dGhhdCBzZXR0aW5ncyBsYXRlciBvbiBhcyB0aGUgSVBvSUIgaW50ZXJmYWNlIGlzIHVzdWFsbHkg
Y3JlYXRlZCB2ZXJ5IGVhcmx5IHNvIHdlIHdvdWxkIGhhdmUgdG8gZGVzdHJveSB0aGUgZXhpc3Rp
bmcgbmV0ZGV2IGFuZCByZWNyZWF0ZSBhIG5ldyBvbmUuDQpUaGUgZWFzaWVzdCBzb2x1dGlvbiB3
b3VsZCBiZSB0aGF0IG1zdGNvbmZpZyBhbGxvdyB0byBzZXQvY2xlYXIgdGhpcyBmbGFnIHNvIHdl
IGNhbiBkZWFsIHdpdGggdGhpcyBpbiB0aGUgRlcgYW5kIGJlIGZ1bGx5IHRyYW5zcGFyZW50IGRy
aXZlciB3aXNlIGJ1dCBkb24ndCBrbm93IGlmIHRoZXJlIGlzIGhvcGUgZm9yIHRoYXQuLi4NCg0K
Tmljb2xhcw0KDQotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQ0KDQppUUV6QkFFQkNBQWRG
aUVFUXRKVGhjR2h3Q3VMR3h4dmdCdmR1Q1dZajJRRkFsMC8zZGdBQ2drUWdCdmR1Q1dZDQpqMlJ0
NVFnQWlmTitKNCs4cE85VUF0NnBIelRHamh3eFBTSkJPRXJzYjFwRDBMTGlNdFBnaHQ2ZG5LcWd4
dURtDQpRNnI4Tml4bUtucUNCUmM4NjdOZUxXaGdwaG1sMHYxUFI1OVlaMmZNS3BLMHdOd0NSd3Az
YVZFUEN3OTdtaDA2DQo4NE9qSUU2VVhCcHZlaHlrZDU1cnNLUDJjcTFkblVtY0plakZKVGhyNTFJ
TlRUYlMyOExUZERhdUtya2NsL2djDQpNNWVqMDRPNzZMM3hOWVV1YkF1THZqM1pTY2hlZ01hYkd6
cTd3RWVBcHRLMEFmYmp2WVVDdmk0MldMUXVOY1psDQpQZFBNRkxWc3hBVnNjNmdhQkdYRHpYaDR6
Z3BMNHgzTnpQTVlLMGZIUnVlK3BhRWxLcGlyZFJBcjM5bUlocDZEDQpLOStwSVFLTE1CN09ud1Bi
enhCMGwvWUoyaHJUU1E9PQ0KPStWazINCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0K
