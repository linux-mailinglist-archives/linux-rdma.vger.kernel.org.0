Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8691CF32C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 13:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELLPW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 07:15:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:23464 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgELLPW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 07:15:22 -0400
IronPort-SDR: BGp1vqoBLtPi4I2FRF6EJvzzhR9QaDhNWjg6scvg9UMcEPcZnYbkGA2CWHh2Deo+e/zyhjU8kK
 ftp/3MqN9BEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 04:15:14 -0700
IronPort-SDR: VK4VX56bOOZGEc+vMhFb5W9G88vYhBK9ZLIQvjy4bnXXudIPVe1sS8krxtC6n3NFxBtQWuYAtV
 Zc2iHs4aLNrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="463509076"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 12 May 2020 04:15:14 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 May 2020 04:15:14 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 May 2020 04:15:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 12 May 2020 04:15:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3kSY8dvuYYVAOuxFbIV1R8rmip9wvp6F5pdCxDDrkr0Oztf4T4dnNA8RI1fTh5gWlqKe2VoqVVped6mIUKlX1jYqrsbfuuNjZeIYSXWrmsjtq245t0uOkNwnzruunqMyO0JqtWJP0SVY659j0+9C0r8y76loie3Tnz4eZ2TSIY+Vz8AJTwbaxHcnNHN0Ihnuz2tdculicA3PBsIOnFnD4iYzXKbSyPXp2iSh/T5s4zwpLgP+RzrEn1xE3bfm9aOl23V4XUUhy1k09cOb3I8KIhmPhBH62QdTgVHLGS3/a4w1QZnC0tW5rLDcyAYifjkJ2rQ247JECmrqxYb1kFTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3wMt2IlyjmYCePF1E4csfPGE2eyKsRIF++N/uWDhqU=;
 b=APhsqWxMAq5reeL4kk/7qBRLuUgq4ef21/JDDstzu/JshYT+7UQF8bJ9iDLDrC8ICRNWd2yM+sSVX7F76wobtAapO5idonsYHGVhLr3Gy/CsQoxS+uFo6G+gMrrfvbGWCTbO6uzQAwQkjMeWJIndFu+LpMSIB5a3F6mq885OR28vPvx/1Fu2U+nycJl9n2wwmdDtCQ4i3KjNSViRhKrMUO1CIbgVjlp5nNaDPp0M+ZpntJCLr8xWP0iC6as0FVZV7LfBWVglJNAxO3kxDIJjsDzHZI4PD1ecjzHzW24kx9iI/BAIfGd277TaM9fgUdv+R5VFw71n1UxkfMpaqRRM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3wMt2IlyjmYCePF1E4csfPGE2eyKsRIF++N/uWDhqU=;
 b=c4aru+HE8QxkgqcNofoAhH804zKPL/eDuoez79bVnE0oMwSHqyukHzQ9y3Gjoj4KhDVqOy7k0ZGeEpSJOn3pXq0KKmupW9yEpb11DaY6uL6Ajecgg0IYm4ykBxDHTGVeIffrKPKg1be9v2e2uezULZXS1Bv2kqLEFpv+px93HaY=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4668.namprd11.prod.outlook.com (2603:10b6:303:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 11:15:12 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::29b3:892:eed1:2d0c]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::29b3:892:eed1:2d0c%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 11:15:12 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Divya Indi <divya.indi@oracle.com>,
        Mark Bloch <markb@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        "Rama Nichanamatlu" <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: RE: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Thread-Topic: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Thread-Index: AQHWJJ6aQXXg3h4LAUmKqWczCauzqqidBF6AgAAHXHCABlsYgIAA7K4Q
Date:   Tue, 12 May 2020 11:15:12 +0000
Message-ID: <MW3PR11MB4665C1835C792ADC4DFB9017F4BE0@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <7572e503-312c-26a8-c8c2-05515f1c4f84@mellanox.com>
 <MW3PR11MB4665120FE43314C22A862324F4A50@MW3PR11MB4665.namprd11.prod.outlook.com>
 <54a2c84e-1745-cae5-e0b5-4d63013aef32@oracle.com>
In-Reply-To: <54a2c84e-1745-cae5-e0b5-4d63013aef32@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [72.94.197.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7118d1c1-e2b3-41c8-d1cb-08d7f665bd97
x-ms-traffictypediagnostic: MW3PR11MB4668:
x-microsoft-antispam-prvs: <MW3PR11MB466850F365428406FC48D8EFF4BE0@MW3PR11MB4668.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plQfZwkVVaEhbQ7Jp8riDiGd12mKKz6Ltu/Cg2ggdxfKy4i7X2Kl4ZQBShIHYD61hsyQbdzt7RMjoc032KyiiUeJmdBQqOUeT9UyL4lFoU/5S5UNq2FI2iGZMfHTkKSHQ7xdP/5bJg6A86CNAhrEmnvtXaB19gW8w4Zf4qxUoR5dYDyciI3vIULkziJw3yNWcFHCsDoXE/R/zhAwy/KI8d7eIRoeYJiAlv7/0Nzh1Bbv4yBeAxPk2XxC0llQvypajeCQbu39kewpflFHRg7jFiLEGDI7APl96/8rneOEhRym6rVpn36kDNebkTCN341aXfp8mwv2ufeKdbdPq9g8/BOrKTKMxEssGQ1cmEPzR6j2cRgXSxp36sxZdP4kWMTY9VCgv8iH/xie/Gn9kb8gjodO10sMpdbKbzWklz4k449Sclqk8slI+CE/qrE5Rfv5lisTcGfD6TwTybRkaRoZxa35pZt8H0UrKYd2oDKPkvHkrZ2yMkHCctFz03m7yQNXekimz3yu5L7Bp2yhTh5o+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(33430700001)(71200400001)(186003)(7416002)(66574014)(8936002)(52536014)(26005)(7696005)(55016002)(33656002)(86362001)(6506007)(33440700001)(9686003)(66476007)(66556008)(2906002)(53546011)(8676002)(66946007)(4326008)(66446008)(76116006)(478600001)(64756008)(5660300002)(54906003)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mXLaxb0mZeHBEQ+K0F/8yn9cA4KtE7ECKZVASZJUZgyB501JKzAGXoG48UgCZ/adbcIff0Lewo2jN1j/+Iz1K2QOgTpegj1SxjdqT6MHV7LPPdGMEQCSzzGK4sraP2GFbwk+mTOsVsC9IFhtC2f3McZJ+F7KujzNGhBU1vPKaNmfOeDESBCl2udvlIa+i6WjFuosrPRgsfWxifW26mqbCUu7scz0UBtxMmxFylL/ohx0b5kSaLNT0OW+ueIUSfLUnezq1xam/ID9cXjLK9BTP/V1CT16Kmoamb/U0d52QS0qOnoY3D2e7c3M28EN784LuP7BpqpxaR0S1FLO1C2Fri/Yz8IY+nkp66ssd/xFbgfGc9jRRcbZt7dDRbgbcGtCme4haYAbskbO7Rg5qQbbRzs8xuwK0WcypZON9jw5FKuKhcJcnoWkfCtNwYKT3scirVOeG0Z3dSvXILoJJHv763tQwgknihG0YTVk+DTQMSc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7118d1c1-e2b3-41c8-d1cb-08d7f665bd97
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 11:15:12.8212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94opufFZy4qJzwzWKoCBBGViYnZlq5re+Fq3UOMuidtEQrLBb9eHS1KFcvt8ayTS9jUMTDMSbegzoOYYHn62tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGl2eWEgSW5kaSA8ZGl2
eWEuaW5kaUBvcmFjbGUuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSAxMSwgMjAyMCA1OjA2IFBN
DQo+IFRvOiBXYW4sIEthaWtlIDxrYWlrZS53YW5AaW50ZWwuY29tPjsgTWFyayBCbG9jaA0KPiA8
bWFya2JAbWVsbGFub3guY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IHJkbWFAdmdlci5rZXJuZWwub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4N
Cj4gQ2M6IEdlcmQgUmF1c2NoIDxnZXJkLnJhdXNjaEBvcmFjbGUuY29tPjsgSMOla29uIEJ1Z2dl
DQo+IDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT47IFNyaW5pdmFzIEVlZGEgPHNyaW5pdmFzLmVl
ZGFAb3JhY2xlLmNvbT47DQo+IFJhbWEgTmljaGFuYW1hdGx1IDxyYW1hLm5pY2hhbmFtYXRsdUBv
cmFjbGUuY29tPjsgRG91ZyBMZWRmb3JkDQo+IDxkbGVkZm9yZEByZWRoYXQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDEvMl0gSUIvc2E6IFJlc29sdmluZyB1c2UtYWZ0ZXItZnJlZSBpbiBp
Yl9ubF9zZW5kX21zZy4NCj4gDQo+IEhpLA0KPiANCj4gVGhhbmtzIGZvciB0YWtpbmcgdGhlIHRp
bWUgdG8gcmV2aWV3LiBQbGVhc2UgZmluZCBteSBjb21tZW50cyBpbmxpbmUgLQ0KPiANCj4gT24g
NS83LzIwIDE6MTYgUE0sIFdhbiwgS2Fpa2Ugd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTWFyayBCbG9jaCA8bWFya2JAbWVsbGFub3guY29t
Pg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTWF5IDA3LCAyMDIwIDM6MzYgUE0NCj4gPj4gVG86IERp
dnlhIEluZGkgPGRpdnlhLmluZGlAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4+IGxpbnV4LSByZG1hQHZnZXIua2VybmVsLm9yZzsgSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+OyBXYW4sDQo+ID4+IEthaWtlIDxrYWlrZS53YW5AaW50ZWwuY29tPg0K
PiA+PiBDYzogR2VyZCBSYXVzY2ggPGdlcmQucmF1c2NoQG9yYWNsZS5jb20+OyBIw6Vrb24gQnVn
Z2UNCj4gPj4gPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPjsgU3Jpbml2YXMgRWVkYSA8c3Jpbml2
YXMuZWVkYUBvcmFjbGUuY29tPjsNCj4gPj4gUmFtYSBOaWNoYW5hbWF0bHUgPHJhbWEubmljaGFu
YW1hdGx1QG9yYWNsZS5jb20+OyBEb3VnIExlZGZvcmQNCj4gPj4gPGRsZWRmb3JkQHJlZGhhdC5j
b20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBJQi9zYTogUmVzb2x2aW5nIHVzZS1h
ZnRlci1mcmVlIGluDQo+IGliX25sX3NlbmRfbXNnLg0KPiA+Pg0KPiA+Pg0KPiA+Pj4gQEAgLTEx
MjMsNiArMTE1NiwxOCBAQCBpbnQgaWJfbmxfaGFuZGxlX3Jlc29sdmVfcmVzcChzdHJ1Y3Qgc2tf
YnVmZg0KPiA+Pj4gKnNrYiwNCj4gPj4+DQo+ID4+PiAgCXNlbmRfYnVmID0gcXVlcnktPm1hZF9i
dWY7DQo+ID4+Pg0KPiA+Pj4gKwkvKg0KPiA+Pj4gKwkgKiBNYWtlIHN1cmUgdGhlIElCX1NBX05M
X1FVRVJZX1NFTlQgZmxhZyBpcyBzZXQgYmVmb3JlDQo+ID4+PiArCSAqIHByb2Nlc3NpbmcgdGhp
cyBxdWVyeS4gSWYgZmxhZyBpcyBub3Qgc2V0LCBxdWVyeSBjYW4gYmUgYWNjZXNzZWQgaW4NCj4g
Pj4+ICsJICogYW5vdGhlciBjb250ZXh0IHdoaWxlIHNldHRpbmcgdGhlIGZsYWcgYW5kIHByb2Nl
c3NpbmcgdGhlIHF1ZXJ5DQo+ID4+IHdpbGwNCj4gPj4+ICsJICogZXZlbnR1YWxseSByZWxlYXNl
IGl0IGNhdXNpbmcgYSBwb3NzaWJsZSB1c2UtYWZ0ZXItZnJlZS4NCj4gPj4+ICsJICovDQo+ID4+
PiArCWlmICh1bmxpa2VseSghaWJfc2FfbmxfcXVlcnlfc2VudChxdWVyeSkpKSB7DQo+ID4+IENh
bid0IHRoZXJlIGJlIGEgcmFjZSBoZXJlIHdoZXJlIHlvdSBjaGVjayB0aGUgZmxhZyAoaXQgaXNu
J3Qgc2V0KQ0KPiA+PiBhbmQgYmVmb3JlIHlvdSBjYWxsIHdhaXRfZXZlbnQoKSB0aGUgZmxhZyBp
cyBzZXQgYW5kIHdha2VfdXAoKSBpcw0KPiA+PiBjYWxsZWQgd2hpY2ggbWVhbnMgeW91IHdpbGwg
d2FpdCBoZXJlIGZvcmV2ZXI/DQo+ID4gU2hvdWxkIHdhaXRfZXZlbnQoKSBjYXRjaCB0aGF0PyBU
aGF0IGlzLCAgaWYgdGhlIGZsYWcgaXMgbm90IHNldCwgd2FpdF9ldmVudCgpDQo+IHdpbGwgc2xl
ZXAgdW50aWwgdGhlIGZsYWcgaXMgc2V0Lg0KPiA+DQo+ID4gIG9yIHdvcnNlLCBhIHRpbWVvdXQg
d2lsbCBoYXBwZW4gdGhlIHF1ZXJ5IHdpbGwgYmUNCj4gPj4gZnJlZWQgYW5kIHRoZW0gc29tZSBv
dGhlciBxdWVyeSB3aWxsIGNhbGwgd2FrZV91cCgpIGFuZCB3ZSBoYXZlIGFnYWluDQo+ID4+IGEg
dXNlLWFmdGVyLWZyZWUuDQo+ID4gVGhlIHJlcXVlc3QgaGFzIGJlZW4gZGVsZXRlZCBmcm9tIHRo
ZSByZXF1ZXN0IGxpc3QgYnkgdGhpcyB0aW1lIGFuZA0KPiB0aGVyZWZvcmUgdGhlIHRpbWVvdXQg
c2hvdWxkIGhhdmUgbm8gaW1wYWN0IGhlcmUuDQo+ID4NCj4gPg0KPiA+Pj4gKwkJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmaWJfbmxfcmVxdWVzdF9sb2NrLCBmbGFncyk7DQo+ID4+PiArCQl3YWl0
X2V2ZW50KHdhaXRfcXVldWUsIGliX3NhX25sX3F1ZXJ5X3NlbnQocXVlcnkpKTsNCj4gPj4gV2hh
dCBpZiB0aGVyZSBhcmUgdHdvIHF1ZXJpZXMgc2VudCB0byB1c2Vyc3BhY2UsIHNob3VsZG4ndCB5
b3UgY2hlY2sNCj4gPj4gYW5kIG1ha2Ugc3VyZSB5b3UgZ290IHdva2VuIHVwIGJ5IHRoZSByaWdo
dCBvbmUgc2V0dGluZyB0aGUgZmxhZz8NCj4gPiBUaGUgd2FpdF9ldmVudCgpIGlzIGNvbmRpdGlv
bmVkIG9uIHRoZSBzcGVjaWZpYyBxdWVyeQ0KPiAoaWJfc2FfbmxfcXVlcnlfc2VudChxdWVyeSkp
LCBub3Qgb24gdGhlIHdhaXRfcXVldWUgaXRzZWxmLg0KPiA+DQo+ID4+IE90aGVyIHRoYW4gdGhh
dCwgdGhlIGVudGlyZSBzb2x1dGlvbiBtYWtlcyBpdCB2ZXJ5IGNvbXBsaWNhdGVkIHRvDQo+ID4+
IHJlYXNvbiB3aXRoIChmbGFncyBzZXQvY2hlY2tlZCB3aXRob3V0IGxvY2tpbmcgZXRjKSBtYXli
ZSB3ZSBzaG91bGQNCj4gPj4ganVzdCByZXZlcnQgYW5kIGZpeCBpdCB0aGUgb3RoZXIgd2F5Pw0K
PiA+IFRoZSBmbGFnIGNvdWxkIGNlcnRhaW5seSBiZSBzZXQgdW5kZXIgdGhlIGxvY2ssIHdoaWNo
IG1heSByZWR1Y2UNCj4gY29tcGxpY2F0aW9ucy4NCj4gDQo+IFdlIGNvdWxkIHVzZSBhIGxvY2sg
b3IgdXNlIGF0b21pYyBvcGVyYXRpb25zLiBIb3dldmVyLCB0aGUgcmVhc29uIGZvciBub3QNCj4g
ZG9pbmcgc28gd2FzIHRoYXQgd2UgaGF2ZSAxIHdyaXRlciBhbmQgbXVsdGlwbGUgcmVhZGVycyBv
ZiB0aGUNCj4gSUJfU0FfTkxfUVVFUllfU0VOVCBmbGFnIGFuZCB0aGUgcmVhZGVycyB3b3VsZG50
IG1pbmQgcmVhZGluZyBhIHN0YWxlDQo+IHZhbHVlLg0KPiANCj4gV291bGQgaXQgc3RpbGwgYmUg
YmV0dGVyIHRvIGhhdmUgYSBsb2NrIGZvciB0aGlzIGZsYWc/DQo+IA0KDQpZZXMuIEl0IHdpbGwg
bWFrZSB0aGUgY29kZSBsZXNzIGNvbXBsaWNhdGVkIGFuZCBlYXNpZXIgdG8gbWFpbnRhaW4uDQoN
CkthaWtlDQo=
