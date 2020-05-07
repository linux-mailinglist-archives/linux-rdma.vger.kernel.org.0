Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD21C9BFF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgEGUQ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 16:16:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:55559 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbgEGUQ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 16:16:26 -0400
IronPort-SDR: vhjMU9/JQaHfZ4G3Uz8hgbA4Z0wvua8EbX90AEbfPWgT8rgyoQB6I3D8sHVubkIr9ln2sPVIEd
 sVYvAqP2tlqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 13:16:23 -0700
IronPort-SDR: /9mykpfpBqWgZSRZBFMUfJVJFmvNDveC2NnUtJGC9jqkgGcMR7m6M38iwREO+kwLHqcVW99sAK
 7iqPtrIx+Y5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,365,1583222400"; 
   d="scan'208";a="305220411"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2020 13:16:23 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 13:16:22 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 13:16:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 7 May 2020 13:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMd+L2sh81yP/yuxmwdkrXw9Rx/EsY1t20YjZ2cWETYCGQzv9O36eZuco+RBHQ+YajVmOaN+Xwh8PsyhhwA1D0cmCRp3niRnWfg8HeNymVuejEEbSk6A5x5MJElpuKl1XiD1K4DI8vZ1oJ7LrMQc0Oi7iZmiPGUI1EgWPwqRULG+us3k4pexQ4LHGynD3ZlOkd23JjBx/aJWJ78SC8Ap/eUpuUZaRXaPTnU89Si18Etw2F194EVWZEm1alGIqsSc+7XSPfaVD/K9xDDAFjp906asKAdN21hen+5cWt+W/lcYKpyddBQz5Tq6bhz++PFzAaVZ9B/3VPkFdiv4xs7Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFfiKNWY+Gnw/Wg2kwRlTqgPDp3oxBzL0gT8lKdjx/I=;
 b=gQypyfYhSB6XDoyhN4gzY6DPPAi71y06irS+R5Dy/j0/6uVcoYI1qfVAP5dgEIgDq8Vp6ATklSAqTSdWQ+IwSI9WvCarjOmc5CdCbSNoJntHAtCO90vG5MCEjpuUlFc/RfT+PKbQTTk/CYPgnd+2rbWHBggMe++dnK0T479+ibc0CF+ADPz3w0JxU86CsZvgGhXO7PfbLI7ISaSmmb3ZP3og81reL4Q2tluLooB5BhA48LDwFVxD6CeIWKWNmuAtFDu4Hpu9tgtoiMXz/gwlJ2k/aHZ7c/a4Q4UnfZ6rhD+DC6zau9IHEq+LfssUKzEUsnq6+FTwCIg6l8z4GeCLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFfiKNWY+Gnw/Wg2kwRlTqgPDp3oxBzL0gT8lKdjx/I=;
 b=v9mzEghvTJ+KTNRbResNmbwqjYxenGw31pUjFhUQOZZLWqEoFSUTPntQJD1NS7e26fadRaqIuwKd2EdeQGLnHsvAo460506Cp+rJMCP0q79yNT2qosf/Mzmts2Eh7fj67ImemKtfmFhPM5hP4v9uYjCImSLuD7yFu16tgYF70i8=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 20:16:21 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 20:16:20 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Mark Bloch <markb@mellanox.com>,
        Divya Indi <divya.indi@oracle.com>,
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
Thread-Index: AQHWJJ6aQXXg3h4LAUmKqWczCauzqqidBF6AgAAHXHA=
Date:   Thu, 7 May 2020 20:16:20 +0000
Message-ID: <MW3PR11MB4665120FE43314C22A862324F4A50@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <7572e503-312c-26a8-c8c2-05515f1c4f84@mellanox.com>
In-Reply-To: <7572e503-312c-26a8-c8c2-05515f1c4f84@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [72.94.197.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0be56e00-98ab-4772-0324-08d7f2c381f9
x-ms-traffictypediagnostic: MW3PR11MB4715:
x-microsoft-antispam-prvs: <MW3PR11MB47159DA30DC682E155FC1AB2F4A50@MW3PR11MB4715.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eC5nJm6ib1dSMOvOEn0gqVJxuRjY61ftkx6WYLydPWOH4fv8M8TP4YeydrZxFfuKSz0XF/4CoCF6L5YHD4gkGZ6XzEThcodBsgA5KpXQyIr/wUifT34jezfMbfDTnPQ6/5oBIbE1p45OCRECM81GCGYhdcuF/oiglGZbXSpGUUW9rmkDslgF9+wGqvngm95+szdoQ4iblxWZi6SZyTCVZ+FagscTW+NNUAEnnPKYF+Yd4HssBql9rBQC8eowODE+eRytC5bKNziG+LjEd2R4OpR5uwd4LhakL9SQMH06TNnd6t6lCQBHVmBgbNYlzSbJaj/VRr77YTRM1okpD8eS5jzsEF1e/O8SlJbmcRSNt/00iVLric88ePUwMPgGr3JkmIFJ68aakX/woC67NqEzo+sSZ+7ADGXm1SZsLsTcTRI3vQuk4HhBlr3ae331unpLZPqlBv69J8ehuyaIn8VX7OXjZfwVZN2xlFCBwmWO9tecwvGXt0wIAq+MTzhnNG5N/LxeioPLGwYm6rPBlSNk3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(33430700001)(6506007)(5660300002)(478600001)(53546011)(66446008)(316002)(71200400001)(66556008)(55016002)(66476007)(2906002)(9686003)(66946007)(4326008)(64756008)(7696005)(52536014)(54906003)(76116006)(186003)(7416002)(26005)(8936002)(33440700001)(110136005)(33656002)(83280400001)(83320400001)(83290400001)(83310400001)(86362001)(66574014)(83300400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pyYMe4PlmPuKu1bRBvGq4zJQvzaUo7UML2ZuP1dxw8Z2MF+/aVyE6DE7s1ZWXeUS2t/UCVDU5CG6dSJnktL9a46sAKx2MvgRBBrHzqvqBNKJocMhjOLit2Ct2lm27MRDYqjSlwuPrmbhRp3scRddnoksLLbCTMQkWEZWa+zdWVZtr7hDPa0GEtJUsbyZcaO4iq9H9mov0CzG1mkdd0aQGmJKh3VXiyFXSJwp2eW6vaOaN6Ahq16RSa0mQBXH3mc0zWPfdb2I7w/g8+47MqchiOk1ExAz4Wn65gEm1g4q52Uz6csSq+yKKGlYRPITokaVCqaxCyMOZlsBIWc3f/+0cl2VKn2xwoQ6NUlHUERYoSAC8b71B8aZyN8hNOPbapwbSYQT9glvCiJg1yU9zmFkGIXH0k7kedR11ZcFuWKdTWMy1PQ8kTil15PqRmpKzEHgUc1+9lKPAr0e+BZNz+41UO9Gf+w7NMWmqwJFH/krWZ9qmzFjxhtxLwYZXtmIHFSJfIoT6R2U2zYQ5Qu05+ARIwJvYZaO/MIDUs8ebRwBDejNeqN7Je/uWoYJUCssj97nbG8y68qPbC8TR/g3Iw6a17mIv/AO7WKhy3LR1FJq+Md/t2z8N/ofJ3dGu6zO/GZE6ScpzklmkpfECA8Q2KCIMug84XlfQU9XmSyM7ay3EZ2a8VPzNTqxflaUR1BlHJf3NVk1gCBAt3nzOCfoxy7PXa5++mH6otRsZTA2t1FLuvqPXOvM5bRHWJZ+YGzXv7ua9491ISWmg1wMB85PAukjI4wUqAyIGoppHzqeRmN79Oc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be56e00-98ab-4772-0324-08d7f2c381f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 20:16:20.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZtX8+D7TtGM9Bul2o+IELsniTwoGbTUQX/JUVq4dl3Df45PtfwY0IxaTyhTnuG3MbusExWkwi9K89ymWvDMaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBCbG9jaCA8bWFy
a2JAbWVsbGFub3guY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDA3LCAyMDIwIDM6MzYgUE0N
Cj4gVG86IERpdnlhIEluZGkgPGRpdnlhLmluZGlAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByZG1hQHZnZXIua2VybmVsLm9yZzsgSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAemllcGUuY2E+OyBXYW4sIEthaWtlDQo+IDxrYWlrZS53YW5AaW50ZWwuY29t
Pg0KPiBDYzogR2VyZCBSYXVzY2ggPGdlcmQucmF1c2NoQG9yYWNsZS5jb20+OyBIw6Vrb24gQnVn
Z2UNCj4gPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPjsgU3Jpbml2YXMgRWVkYSA8c3Jpbml2YXMu
ZWVkYUBvcmFjbGUuY29tPjsNCj4gUmFtYSBOaWNoYW5hbWF0bHUgPHJhbWEubmljaGFuYW1hdGx1
QG9yYWNsZS5jb20+OyBEb3VnIExlZGZvcmQNCj4gPGRsZWRmb3JkQHJlZGhhdC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBJQi9zYTogUmVzb2x2aW5nIHVzZS1hZnRlci1mcmVlIGlu
IGliX25sX3NlbmRfbXNnLg0KPiANCj4gDQo+ID4gQEAgLTExMjMsNiArMTE1NiwxOCBAQCBpbnQg
aWJfbmxfaGFuZGxlX3Jlc29sdmVfcmVzcChzdHJ1Y3Qgc2tfYnVmZg0KPiA+ICpza2IsDQo+ID4N
Cj4gPiAgCXNlbmRfYnVmID0gcXVlcnktPm1hZF9idWY7DQo+ID4NCj4gPiArCS8qDQo+ID4gKwkg
KiBNYWtlIHN1cmUgdGhlIElCX1NBX05MX1FVRVJZX1NFTlQgZmxhZyBpcyBzZXQgYmVmb3JlDQo+
ID4gKwkgKiBwcm9jZXNzaW5nIHRoaXMgcXVlcnkuIElmIGZsYWcgaXMgbm90IHNldCwgcXVlcnkg
Y2FuIGJlIGFjY2Vzc2VkIGluDQo+ID4gKwkgKiBhbm90aGVyIGNvbnRleHQgd2hpbGUgc2V0dGlu
ZyB0aGUgZmxhZyBhbmQgcHJvY2Vzc2luZyB0aGUgcXVlcnkNCj4gd2lsbA0KPiA+ICsJICogZXZl
bnR1YWxseSByZWxlYXNlIGl0IGNhdXNpbmcgYSBwb3NzaWJsZSB1c2UtYWZ0ZXItZnJlZS4NCj4g
PiArCSAqLw0KPiA+ICsJaWYgKHVubGlrZWx5KCFpYl9zYV9ubF9xdWVyeV9zZW50KHF1ZXJ5KSkp
IHsNCj4gDQo+IENhbid0IHRoZXJlIGJlIGEgcmFjZSBoZXJlIHdoZXJlIHlvdSBjaGVjayB0aGUg
ZmxhZyAoaXQgaXNuJ3Qgc2V0KSBhbmQgYmVmb3JlDQo+IHlvdSBjYWxsIHdhaXRfZXZlbnQoKSB0
aGUgZmxhZyBpcyBzZXQgYW5kIHdha2VfdXAoKSBpcyBjYWxsZWQgd2hpY2ggbWVhbnMgeW91DQo+
IHdpbGwgd2FpdCBoZXJlIGZvcmV2ZXI/DQoNClNob3VsZCB3YWl0X2V2ZW50KCkgY2F0Y2ggdGhh
dD8gVGhhdCBpcywgIGlmIHRoZSBmbGFnIGlzIG5vdCBzZXQsIHdhaXRfZXZlbnQoKSB3aWxsIHNs
ZWVwIHVudGlsIHRoZSBmbGFnIGlzIHNldC4NCg0KIG9yIHdvcnNlLCBhIHRpbWVvdXQgd2lsbCBo
YXBwZW4gdGhlIHF1ZXJ5IHdpbGwgYmUNCj4gZnJlZWQgYW5kIHRoZW0gc29tZSBvdGhlciBxdWVy
eSB3aWxsIGNhbGwgd2FrZV91cCgpIGFuZCB3ZSBoYXZlIGFnYWluIGENCj4gdXNlLWFmdGVyLWZy
ZWUuDQoNClRoZSByZXF1ZXN0IGhhcyBiZWVuIGRlbGV0ZWQgZnJvbSB0aGUgcmVxdWVzdCBsaXN0
IGJ5IHRoaXMgdGltZSBhbmQgdGhlcmVmb3JlIHRoZSB0aW1lb3V0IHNob3VsZCBoYXZlIG5vIGlt
cGFjdCBoZXJlLg0KDQoNCj4gDQo+ID4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaWJfbmxf
cmVxdWVzdF9sb2NrLCBmbGFncyk7DQo+ID4gKwkJd2FpdF9ldmVudCh3YWl0X3F1ZXVlLCBpYl9z
YV9ubF9xdWVyeV9zZW50KHF1ZXJ5KSk7DQo+IA0KPiBXaGF0IGlmIHRoZXJlIGFyZSB0d28gcXVl
cmllcyBzZW50IHRvIHVzZXJzcGFjZSwgc2hvdWxkbid0IHlvdSBjaGVjayBhbmQNCj4gbWFrZSBz
dXJlIHlvdSBnb3Qgd29rZW4gdXAgYnkgdGhlIHJpZ2h0IG9uZSBzZXR0aW5nIHRoZSBmbGFnPw0K
DQpUaGUgd2FpdF9ldmVudCgpIGlzIGNvbmRpdGlvbmVkIG9uIHRoZSBzcGVjaWZpYyBxdWVyeSAo
aWJfc2FfbmxfcXVlcnlfc2VudChxdWVyeSkpLCBub3Qgb24gdGhlIHdhaXRfcXVldWUgaXRzZWxm
Lg0KDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQsIHRoZSBlbnRpcmUgc29sdXRpb24gbWFrZXMgaXQg
dmVyeSBjb21wbGljYXRlZCB0byByZWFzb24gd2l0aA0KPiAoZmxhZ3Mgc2V0L2NoZWNrZWQgd2l0
aG91dCBsb2NraW5nIGV0YykgbWF5YmUgd2Ugc2hvdWxkIGp1c3QgcmV2ZXJ0IGFuZCBmaXggaXQN
Cj4gdGhlIG90aGVyIHdheT8NCg0KVGhlIGZsYWcgY291bGQgY2VydGFpbmx5IGJlIHNldCB1bmRl
ciB0aGUgbG9jaywgd2hpY2ggbWF5IHJlZHVjZSBjb21wbGljYXRpb25zLiANCg0KS2Fpa2UNCg0K
