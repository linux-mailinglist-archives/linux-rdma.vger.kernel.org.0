Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622061C7818
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgEFRh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 13:37:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:61216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgEFRh0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 13:37:26 -0400
IronPort-SDR: vqtQ0CYGLn37agPEgHW8tI5CDhMWw4LHXBqF4n+otR7Cpr5m9oa6yo40anosP1q1ZrO8OHZtTX
 RHDWkJz9yM2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 10:37:23 -0700
IronPort-SDR: eFdftW3Em+G/BfW5Oa/0eIr8D9v9TGYwrWqfdmWSuSPBryQeQ4Mg1If6MKJRMiOlDBQJbp2fbT
 pJqTDbm0qhKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="248989568"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2020 10:37:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 10:37:23 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 May 2020 10:37:22 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 10:37:22 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 6 May 2020 10:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPHrwmL6D992OmYnF7FzHpQn57OHSZ3VB80tukJot+ZkNJCxYpyBT6h0KZTVdmd8kw3HP5Dk0jP28+tGFTj69J1+EkpabijtI9QY28n/cBgjV45QT803pJFOrdoHhdd0LqbCQR0iBBIPq/WZJwHRbVebqDmdytkBekC5txGO6JkQTeA938sjBx3jJWXaq89oRyTjaVUUbeoZTD/0vg/NeyP4gXa/33JSH0s1j+RuMq0hkY1h85ofu7rzTWp2J3XZHeVRLO6iR4tP62hGpsLEK21DWf04rxuYy14I9GEXHdDYQgSo1fpEsqflYO+27aLoi6ds3KYaUEmwQk6ilWz8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjfFadKSXGZSP3VJFgHTdrcnELZtXMvM2zAv/u1DN1I=;
 b=cENxsU7YdBbvgDMdKXc0Kj9lrQkmPuGA8Qt6eI95VUvTb1Sk2ILkHZ+2hB5xSVyt3ZCPAVInSRYcfuomWZouZG2R0/TXneJMQzvTZZK4VRhN3LD+WLDPIMxyXnzSUFzTvFZOZsW2GRsESz07nj8St1Wfci8lNkAQ4ANtHilpqnBeOvwMzH7WbLl6gfjExn3WC+1ugDN/mZirYXn5WcDHKxgk2OtjJtisoXpQ5rK1RpzP3gcssdJ8a8gLHciNu5QoIqYCyK9L9bcoORa6JQ6Zk0/tiTipwWznCa36CaZfibSvfLOaRGDQy+bdPaxWl7NHG/XhGNxQIsD+bJq59eiHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjfFadKSXGZSP3VJFgHTdrcnELZtXMvM2zAv/u1DN1I=;
 b=BEH5422IctTjhMhs2cdpneoy4nOPHAhpsaDGETkphH1HpYkxLXRxITfhCB8TJet8WHKeQCfEHcj6RUrA0AbfBi13RnGqiJVBvPbs17QxZ7Cly8TWuWlghltxJ84rBPyrTyh2nPO9j45Mgx1CxsLYg2SgDfmfrO/d8KoiTpRSk/o=
Received: from MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 17:36:53 +0000
Received: from MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9]) by MW3PR11MB4665.namprd11.prod.outlook.com
 ([fe80::c008:bca9:22e9:4dc9%4]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 17:36:52 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     =?utf-8?B?5Lq/5LiA?= <teroincn@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
CC:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [BUG] is there a memleak in function qib_create_port_files
Thread-Topic: [BUG] is there a memleak in function qib_create_port_files
Thread-Index: AQHWI6wXIuoDH8hG3UetdOLgA5+bm6ibUlgw
Date:   Wed, 6 May 2020 17:36:52 +0000
Message-ID: <MW3PR11MB46655872A8453009764B5F20F4A40@MW3PR11MB4665.namprd11.prod.outlook.com>
References: <CANTwqXDmq4OdHT=Pk7Xm6JXBp_7kwEBK7JGd=kT9pOE5gx=iLg@mail.gmail.com>
In-Reply-To: <CANTwqXDmq4OdHT=Pk7Xm6JXBp_7kwEBK7JGd=kT9pOE5gx=iLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [72.94.197.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34ef0e66-4c00-4e14-c6d6-08d7f1e4109c
x-ms-traffictypediagnostic: MW3PR11MB4635:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB46350EC4D6D87BBE0410DB2BF4A40@MW3PR11MB4635.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ZEn1OZ9EVdBuQZTUZL94ujwfxdobKEUrddUT0KDzMP49PZT1RjNuzDFStdH9zLiK5G8K84L5HqMKX5KpVkmVx/sECzyfXfs3CLKpbz/xr0EWtmWuZbuYi3bCoe4lJsIz/skQSdzQQpI9NEjW9HCxJORUlcmnf+ZXx6D/bQ1A258CdKMY9EQUBkAHPTzWdEGll4aq+j9llQE6wHjcDVJlxdllQdX0Ki4zXulSM+vAO5OrqzBhcCx5Zsr04aWiZVCY7JIivsKpgSBAdILfa/c4ziW6cvRKDrwHFjt+pD77Yg3fMKu1vZ5RdtNWMOFjUsV3Jr3+J7ah766ifhfD41K1YNti4FfZ77CDd0CVVt1nfKWMMCyEtDYI8AQKw8/xi/EV+QnwjSqX9mnjcc6eCi5I8Dzxouk17RvoYX3UtM2EWxLrzL4gAd+0CktZlXZ74NwBP0iErzmlCordIISXzsI91g95jsX7x3MWrOvB3HBYaZR6SRe5bcuQTPMxvdEnQYjHMnF2YDfjfQSTq2c2xYh51JnUVCtespkt85SFI8j+DdtbjPmQKz99sO+hV/qQOXsNa8MOLtXefYVS+UhK2cBJ6TQEEijumxQB6rFBiftijo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(33430700001)(8936002)(66446008)(66476007)(66946007)(64756008)(2906002)(76116006)(5660300002)(478600001)(66556008)(8676002)(186003)(26005)(71200400001)(9686003)(53546011)(6506007)(52536014)(6636002)(33656002)(86362001)(4326008)(33440700001)(7696005)(110136005)(54906003)(55016002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Rl1kIlyQzhhIEyfzIha2rgErha2MqasIm+u5GF8xuo+aCn5JicaRQUFX3tO3KAO2Yz3C82z/8Y6dfj6skYFDfdRN6xRuPPvqO6T+PBU+ZSFBCk6lutUno1vR+rCXR0oS1PRzZASFbgmZk/R1C4aoCLN3EjMjOE1+HYx2LPYvQO0VA0tfR0MCObCFiLAzdLOm4sMS5X3AmsRJrOBAg8ZpZ9V9+6VDW1r5IJNuLllBmIZLA3vIYJvDcVOWDZWMy+k7xnaiQ4hd1cKtxDa/Iat3lWvpU6Oa/4W0uelfpvSZEZ4EAh4f8rWb/IKYgNM0GUVlER+j0Uauw/gWouR3xk3TjL8+OQPqRCVcM0UC9CrDidTV2DgztCvuLGrhhpeO7kes8i70JcJQa/3JxpK2FORrw6GiE/rCNKohVWkkcWcchn28CcGnp0zV7admBTqCt7Umg7jaYgQjK9b3UbivtTL6iecr7CEy7iIzQtUbYuVgCLyS8pXgi1/6ZUxitLveNSU3uLCJuDiuzl8enB2O5XOyqu2BCEMYyFwsrV1IgkhRPWdCcR5jNDRCljRqF/LxyWirn72y0wTW+WrE9OsxNwvkkMlkQJBlORWnQBz1kL/d1RIgfChRRkVlKGCBzXyxNq6N7HYHnSLzpPieZQqAIZAdyo+yH1VuwcwqeV0xHnmtVH8NzHX19YfTL4H+sbP8AmWDw9DTpwn5iSlOykcJvFTOZpJNOjgBjU2Cg/+dTYZJPrGUKrpSBeXunLAs5Efuf0R+9dBJvFilt3wyENdmssIfvQW6NBxaNMaVSBxQN+9eWHE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ef0e66-4c00-4e14-c6d6-08d7f1e4109c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 17:36:52.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gFw0/xukvJUI/eSuKcp/vTLNiAPlwUCSkAH2N0V20urGGARSvqbce0I5HobqhaRjiUwZEpTVOW2CAq7q3VpQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V2lsbCBwb3N0IGEgcGF0Y2ggc29vbi4NCg0KS2Fpa2UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgt
cmRtYS0NCj4gb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgPz8NCj4gU2VudDog
V2VkbmVzZGF5LCBNYXkgMDYsIDIwMjAgOTo0MSBBTQ0KPiBUbzogRGFsZXNzYW5kcm8sIERlbm5p
cyA8ZGVubmlzLmRhbGVzc2FuZHJvQGludGVsLmNvbT4NCj4gQ2M6IE1hcmNpbmlzenluLCBNaWtl
IDxtaWtlLm1hcmNpbmlzenluQGludGVsLmNvbT47IGxpbnV4LQ0KPiByZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbQlVHXSBpcyB0aGVyZSBhIG1lbWxlYWsgaW4gZnVuY3Rpb24gcWli
X2NyZWF0ZV9wb3J0X2ZpbGVzDQo+IA0KPiBIaSBhbGwsDQo+IEkgbm90aWNlIHRoYXQgbW9zdCBv
ZiB0aGUgdXNhZ2Ugb2Yga29iamVjdF9pbml0X2FuZF9hZGQgaW4gZHJpdmVycyBhcmUgd3Jvbmcs
DQo+IGFuZCBub3cgc29tZSBkcml2ZXJzIGNvZGUgaGFzIG1ha2VuIGl0IHJpZ2h0LCBwbGVhc2Ug
c2VlIGNvbW1pdA0KPiBkZmI1Mzk0ZjgwNGUgKGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzQv
MTEvMjgyKS4NCj4gDQo+IGZ1bmN0aW9uIHFpYl9jcmVhdGVfcG9ydF9maWxlcygpIGluIC9kcml2
ZXJzL2luZmluaWJhbmQvaHcvcWliL3FpYl9zeXNmcy5jDQo+IG1heSBoYXZlIHRoZSBzaW1pbGFy
IGlzc3VlIGFuZCBsZWFrIGtvYmplY3QuDQo+IGlmIGtvYmplY3RfaW5pdF9hbmRfYWRkKCkgZmFp
bGVkLCB0aGUgcHBkLT5wcG9ydF9rb2JqLT5rb2JqIG1heSBhbHJlYWR5DQo+IGluY3JlYXNlZCBp
dCdzIHJlZmNudCBhbmQgYWxsb2NhdGVkIG1lbW9yeSB0byBzdG9yZSBpdCdzIG5hbWUsIHNvIGEN
Cj4ga29iamVjdF9wdXQgaXMgbmVlZCBiZWZvcmUgcmV0dXJuLg0KPiANCj4gaW50IHFpYl9jcmVh
dGVfcG9ydF9maWxlcyhzdHJ1Y3QgaWJfZGV2aWNlICppYmRldiwgdTggcG9ydF9udW0sICBzdHJ1
Y3QNCj4ga29iamVjdCAqa29iaikgeyBzdHJ1Y3QgcWliX3Bwb3J0ZGF0YSAqcHBkOyBzdHJ1Y3Qg
cWliX2RldmRhdGEgKmRkID0NCj4gZGRfZnJvbV9pYmRldihpYmRldik7IGludCByZXQ7DQo+IA0K
PiBpZiAoIXBvcnRfbnVtIHx8IHBvcnRfbnVtID4gZGQtPm51bV9wcG9ydHMpIHsNCj4gICAgIHFp
Yl9kZXZfZXJyKGRkLCAiU2tpcHBpbmcgaW5maW5pYmFuZCBjbGFzcyB3aXRoIGludmFsaWQgcG9y
dCAldVxuIiwNCj4gcG9ydF9udW0pOw0KPiAgICAgcmV0ID0gLUVOT0RFVjsNCj4gICAgIGdvdG8g
YmFpbDsNCj4gfQ0KPiBwcGQgPSAmZGQtPnBwb3J0W3BvcnRfbnVtIC0gMV07DQo+IA0KPiByZXQg
PSBrb2JqZWN0X2luaXRfYW5kX2FkZCgmcHBkLT5wcG9ydF9rb2JqLCAmcWliX3BvcnRfa3R5cGUs
IGtvYmosDQo+ICJsaW5rY29udHJvbCIpOyBpZiAocmV0KSB7DQo+ICAgICBxaWJfZGV2X2Vycihk
ZCwgIlNraXBwaW5nIGxpbmtjb250cm9sIHN5c2ZzIGluZm8sIChlcnIgJWQpIHBvcnQgJXVcbiIs
IHJldCwNCj4gcG9ydF9udW0pOw0KPiAgICAgZ290byBiYWlsOw0KPiB9DQo+IC4uLg0KPiANCj4g
YmFpbDoNCj4gICAgIHJldHVybiByZXQ7DQo+IH0NCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBMaW4gWWkNCg==
