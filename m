Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC2342848
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 22:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCSV6z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 17:58:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:13764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230199AbhCSV6Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 17:58:24 -0400
IronPort-SDR: na0/3ZWNHA/v1crp7XIvxvRi9p2CQ4jcbJhbSbGfFiMBrqyB3NliTxPXPBhio26HwH3qqdbAMD
 JnGY+Ls8zDLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="187627122"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="187627122"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:58:23 -0700
IronPort-SDR: R/w3KvFLen8mTbFHorSm3NdmCEnTSRHTMHIQkgCnzaqwSvtPTqlBnn6fKfYCd68nIBDlbNeqN5
 lDR8tr/gn+7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="406958400"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 19 Mar 2021 14:58:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 14:58:23 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 14:58:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 14:58:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 14:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcvL8Hs8moSYpCFLM/TzWrHnMe/J6KgYcvQvt83T0JwS2g3jey2rMKewKMHbU+LYVTCzk8T2WR1ep7go+gN9gokqUPXGaYnkXYcj7xgZkGWw14NxwGnHLsAfwaKNYiJ4V3GQwEmXkGYQkIrpMH4uUqvo6dN7g6ZaPU9OmGm9wGnLay9JQWEyUD3fe0EhatHc7E17vQC4fN4P2oDmb14mTMD5RIcxxJGubjetklAdZC/wXpOG6tgi6BXx75ChbXjhaRAeX6hV58YP1qkUiLZNf5IaTlm8S8WPTyjVI3+QA+sEdDpEmizy4omZni3ysMhyMLayS3l91gPwKxWbVWDt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qUsCkfeU8bvuW3y9Lur13ylsMfCe1y0RBxkd85GKto=;
 b=J/jSg4y2LGVfj0UdjUV2ravLr8Dg3e5hjzNSQE8g8otI2wgw7nj6rsCajUREENDmVR0Bu4AFQh8Hm3NkgHg0B6QbsCCpJZr0ywDxsnLPckoxNsV040OYmCLO8y6ZYKnlUqzNEdT8T8vvZ90PQOg2riNeqZxo3l/6onD+FyeGfDHlilgOk93SU0r4NYPsGIv7kdFkn+IEXl8kPO25z4VVkMTddtQPSvlqMcbHxpg9otH90nLwmZRWVJsgLziQjJ9fbJQFxtOdTOVTsN0G+ek12NfcHkNP50fTQbwNGsD2vj45tRUmYI2qqT6u7OrPwmivvWCUeY42H7Mma/1UaedfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qUsCkfeU8bvuW3y9Lur13ylsMfCe1y0RBxkd85GKto=;
 b=jQL73gjM/l4wAeAbobfEOebXFOVGIOkEDDSb8TSPjKqJQ4rx73cU6Ymm4WOlNji7oOWIyxD/gBbSsuDZUgMuiGmOW4L84Ha2ZpzvnLdoLoF04nS22tWtyJ3etceUuU0hKnchHJFheuXW7r8DqytNQdFJSDoM3NrxA96jMO4Mqcc=
Received: from SN6PR11MB3311.namprd11.prod.outlook.com (2603:10b6:805:c1::20)
 by SA0PR11MB4765.namprd11.prod.outlook.com (2603:10b6:806:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 21:58:21 +0000
Received: from SN6PR11MB3311.namprd11.prod.outlook.com
 ([fe80::4505:558b:8f6e:4263]) by SN6PR11MB3311.namprd11.prod.outlook.com
 ([fe80::4505:558b:8f6e:4263%3]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 21:58:21 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9OhYUmp6U+V0qfjE0DBnim76qLVNwAgAAMHVCAABQIgIAAO/qAgAAGJwCAAAexAIAAA/SAgAAFugCAAAIfAIAAAPRwgAAIdwCAAAeKwA==
Date:   Fri, 19 Mar 2021 21:58:21 +0000
Message-ID: <SN6PR11MB3311140D3CC934C5AF334E0CF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
In-Reply-To: <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [96.227.240.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cf771e3-cd51-41bd-38dc-08d8eb221cbe
x-ms-traffictypediagnostic: SA0PR11MB4765:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4765473E3F7FD2AFCC25772FF4689@SA0PR11MB4765.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8abxX7yK83KkCAic2i1aGBM+G3fmGQObbSsFGIFtNSEH1XsgXuOSWQcJbNYvo/dFWzkr6Lu5XNFCGHBVeUYnu06pIEDGl0XczMrpixS4DwblIsDHAjyMazf8vBy6KEl2PB1KNg0S8p4KLYSXb9thoY5QrX3J1EathHI/p5sdlx9DIpsJsztrfDJM2BIb5XeZDmRzSPUE4LOr2/da3zCN+cbV4Nml+hJh5r+GhpBc8Z+gZk40Jhw8ffnUsKhZIiGxGXCyqF2mxpEkt7SiKnMFZ8hiM2wGZP+swUUXF1MTbzenuNNSzELgW/0H8sxuogYDft+xLa/Sw/LB9NOHt9pXLOZh0wvdAoy5bW5uP21dobt2YF+dBQ/XeupATIOoklCX4a9E4OO5clbLbSTqf+U4g9L01iN8skeJJ2cF0EoJIstdvLvpCyisAJHmsJvOJtPF9VfWF3k5opM1C58iFv2TJ+JcZYXPKk9uj1DqZadZE0G0efocythWwTtNRCl2yaTCsoQday1zmD6h/3hofwaH1KeQjGAa5HjrxPUHC/jwNcznJ2U0PxafI83SFi82LSs06WGmyf0AGUT+W3Z/kxle4+8USwI6jYSfDATq+uiy51dRWowMuI/hAtr8hzWR+5XhXsxckvgOUcttggLS4eYuxXCPrmH02TGgmbpM0bSZdtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(38100700001)(5660300002)(9686003)(8676002)(53546011)(110136005)(8936002)(54906003)(83380400001)(33656002)(6506007)(478600001)(71200400001)(2906002)(55016002)(4326008)(6636002)(26005)(7696005)(186003)(66476007)(52536014)(64756008)(86362001)(76116006)(66946007)(66556008)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ckx0U3JnYTExNXI4ekUyZFIrTmhUMG9mWXRhbU9tWG9oS2RNOTlQZmVJN0hO?=
 =?utf-8?B?b1ZrZVFlenpSQ3RJTTFlRnI1MWJRZjJjSldWMjhpdHNiWjFoT0tvdnUrTTdC?=
 =?utf-8?B?UjFmWkM1bndkQkRxNE92MkNlRldENy9aTnNlVFRvMlNVQ3VCRGc4UmtXZ0Zy?=
 =?utf-8?B?QzBvMkJMZitKcFRWamFKMVAvRHZaYnJKRVhpZ1NHakZhdmlRQ1FKVCtxRkJL?=
 =?utf-8?B?alpHaXUrZ3BNNEhkaysrNGhvN05HVHkzRWRxMGVuS0xSbmFvb0tYOTN4Rm9a?=
 =?utf-8?B?alFlNEtGSzhFWDQyVFNJUWU1YTRhYjYxQWdTeXdIZU15L3Q2d1JnVkUwZTVz?=
 =?utf-8?B?dElkWjIzWkhKUHJvWHBIMW9JQkxlbktrcUZsWUx4a3B6SVBWTmd5Vjk0L25D?=
 =?utf-8?B?bURYa0FpT21GbDNVbzBqcmcxZmZiL2ZubHhBM2NhSXNCdzF5VFJibkJOVWkw?=
 =?utf-8?B?UjNlZ2tXTFlPQUs4WDUwS2hVS0IxbFAxQWxmTklRYmVzcS9pMk0zL0tGejRJ?=
 =?utf-8?B?N3dkRjMxSHQrbnVXYW9PdEhYR1NWbk5KWkxLM09zUzNYZ3FyOStsMjJJdnJW?=
 =?utf-8?B?WEtKU0loV1Iwd3V2L1h4NlBlSDV5eWJMV1ZaSzVOVys1RjRSOE5jNTVxS0sw?=
 =?utf-8?B?UTdydWY5N3RDT3U1UlJLb2hDTFFRUkd1QXYrdHhid2RUYmdLRmpYZW9UR0Mr?=
 =?utf-8?B?VnFzOFdHRWc4UDZEY1NhMDd2RGhBNzFBTXdBQmFjM1lMU3dVQTJFWCtyT2dS?=
 =?utf-8?B?cXB2bU01bk5MVzVaRjBTbUxYMUpSTGszQUdGa2N0d1lGZmlrb0xCZEhhNmh3?=
 =?utf-8?B?eUI4UXRCbTZmM0hQbmhjbDgxNE94RGxRUHM2b3g5MjI0UDlZTlVrUExkM0Qv?=
 =?utf-8?B?NG9VYnJpVUFDQ242UGVsOGV0aHNHSHNLWDNuUWl5NmNlOWF2SWFiQ2szNCtn?=
 =?utf-8?B?RklSUE4xNVFFMm1ZNi9IUWdtNXd4NkF0a0tTSkhaWTBUZ3dSaTdHVmlSUXpY?=
 =?utf-8?B?THliYmI2RGd6T255Szl6RjhJSlE3cUQrRit1R1NiVXd4RFNLemJIRWpTaFhP?=
 =?utf-8?B?SHFiNmVBWmFnUG9GdllpbUt0em1kVk1sSzcvQ08zOHVYakhlaWVwNEJLQTNU?=
 =?utf-8?B?Tm5rZWk0ZE1TR0ZqRGFyejVtanNNb3R2UDhZekNjWXJGRkVZenlOWEFrTUEx?=
 =?utf-8?B?R25qK2pkMyt2MjkzSU9oaXArZmlSRGxWcHppbDUrSTdWSldqTVRtRUhqVHY4?=
 =?utf-8?B?eUVoSHVtbEVuZlZIenVEeFBEMWxTdG5FM1ZmdHNLZU5xaVV1T1d5dmxrTGFu?=
 =?utf-8?B?dDdBRUsvQ0JTUFZnT0NMdS9HQkdCRUcvN1lSMmhGN3IzSHJTdis1bVQ2aENo?=
 =?utf-8?B?QlcrbzNVUFdxNUVDK0lXMXBORUw2bDJrQTM4MGVpSEVpTzVUdm5UTXF1NlRx?=
 =?utf-8?B?UThrYStFczBwL1BYQUluVDBQNExUb2YyQWtsVG01L29GcjF3Mm1XU2Vub083?=
 =?utf-8?B?WkFXUjFtb3Y0dmRXWU5IZXFhUlJ0Y2tOckZOYzNUNTQrMUlLYXFYbnFxeDhO?=
 =?utf-8?B?Ym81Y1NlNzEzQmxTMjhlMC96RU1UVmt1YmordTllYWYzYmdleVdKeGdWS29Q?=
 =?utf-8?B?VU54c1hIcHNzcGxvZk1Eb21nRVptaWZTNWhqemp1VU4rdXR1NkRFNEJCSm1I?=
 =?utf-8?B?dXUyWThyRkd1dWZpbnVINUVqNVVSbnl0NHJRWExGZWRkM3hhQ1N2aVpjcVZh?=
 =?utf-8?Q?VmK6g0ICo/zGfm04+mom70rofqrlVr/xLCFDhqJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf771e3-cd51-41bd-38dc-08d8eb221cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 21:58:21.5041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vjh7gw26AOe0PwWdnYko5NyBiLG4qqMlIyjaXnGS1QccaFXo/lg+u1RAif1TGqYo1F3uptu4sZleJhE1fnVSWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4765
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IEZyb206IERlbm5pcyBEYWxlc3NhbmRybyA8ZGVubmlzLmRhbGVzc2FuZHJvQGNvcm5lbGlz
bmV0d29ya3MuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE5LCAyMDIxIDU6MjggUE0NCj4g
VG86IFdhbiwgS2Fpa2UgPGthaWtlLndhbkBpbnRlbC5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpn
Z0BudmlkaWEuY29tPjsNCj4gUmltbWVyLCBUb2RkIDx0b2RkLnJpbW1lckBpbnRlbC5jb20+DQo+
IENjOiBkbGVkZm9yZEByZWRoYXQuY29tOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIFJGQyAwLzldIEEgcmVuZGV6dm91cyBtb2R1bGUNCj4gDQo+IE9u
IDMvMTkvMjAyMSA0OjU5IFBNLCBXYW4sIEthaWtlIHdyb3RlOg0KPiA+PiBGcm9tOiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIE1hcmNoIDE5LCAy
MDIxIDQ6NTUgUE0NCj4gPj4gVG86IFJpbW1lciwgVG9kZCA8dG9kZC5yaW1tZXJAaW50ZWwuY29t
Pg0KPiA+PiBDYzogRGVubmlzIERhbGVzc2FuZHJvIDxkZW5uaXMuZGFsZXNzYW5kcm9AY29ybmVs
aXNuZXR3b3Jrcy5jb20+Ow0KPiA+PiBXYW4sIE9oLCB0aGVyZSBpcyBsb3RzIG9mIHN0dWZmIGlu
IFVDWCwgSSdtIG5vdCBzdXJwcmlzZWQgeW91DQo+ID4+IHNpbWlsYXJpdGllcyB0byB3aGF0IFBT
TSBkaWQgc2luY2UgcHNtL2xpYmZhYnJpYy91Y3ggYXJlIGFsbCBzb2x2aW5nIHRoZQ0KPiBzYW1l
IHByb2JsZW1zLg0KPiA+Pg0KPiA+Pj4+IHJ2IHNlZW1zIHRvIGNvbXBsZXRlbHkgZGVzdHJveSBh
bG90IG9mIHRoZSBIUEMgcGVyZm9ybWFuY2Ugb2ZmbG9hZHMNCj4gPj4+PiB0aGF0IHZlbmRvcnMg
YXJlIGxheWVyaW5nIG9uIFJDIFFQcw0KPiA+Pg0KPiA+Pj4gRGlmZmVyZW50IHZlbmRvcnMgaGF2
ZSBkaWZmZXJlbnQgYXBwcm9hY2hlcyB0byBwZXJmb3JtYW5jZSBhbmQgY2hvc2UNCj4gPj4+IGRp
ZmZlcmVudCBkZXNpZ24gdHJhZGUtb2Zmcy4NCj4gPj4NCj4gPj4gVGhhdCBpc24ndCBteSBwb2lu
dCwgYnkgbGltaXRpbmcgdGhlIHVzYWJpbGl0eSB5b3UgYWxzbyByZXN0cmljdCB0aGUNCj4gPj4g
ZHJpdmVycyB3aGVyZSB0aGlzIHdvdWxkIG1lYW5pbmdmdWxseSBiZSB1c2VmdWwuDQo+ID4+DQo+
ID4+IFNvIGZhciB3ZSBub3cga25vdyB0aGF0IGl0IGlzIG5vdCB1c2VmdWwgZm9yIG1seDUgb3Ig
aGZpMSwgdGhhdA0KPiA+PiBsZWF2ZXMgb25seSBobnMgdW5rbm93biBhbmQgc3RpbGwgaW4gdGhl
IEhQQyBhcmVuYS4NCj4gPiBbV2FuLCBLYWlrZV0gSW5jb3JyZWN0LiBUaGUgcnYgbW9kdWxlIHdv
cmtzIHdpdGggaGZpMS4NCj4gDQo+IEludGVyZXN0aW5nLiBJIHdhcyB0aGlua2luZyB0aGUgb3Bw
b3NpdGUuIFNvIHdoYXQncyB0aGUgYmVuZWZpdD8gV2hlbiB3b3VsZA0KPiBzb21lb25lIHdhbnQg
dG8gZG8gdGhhdD8NCltXYW4sIEthaWtlXSBUaGlzIGlzIG9ubHkgYmVjYXVzZSBydiB3b3JrcyB3
aXRoIHRoZSBnZW5lcmljIFZlcmJzIGludGVyZmFjZSBhbmQgaGZpMSBoYXBwZW5zIHRvIGJlIG9u
ZSBvZiB0aGUgZGV2aWNlcyB0aGF0IGltcGxlbWVudHMgdGhlIFZlcmJzIGludGVyZmFjZS4NCj4g
DQo+IC1EZW5ueQ0K
