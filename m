Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44863BECA6
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhGGRAX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 13:00:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:22339 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhGGRAW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Jul 2021 13:00:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209162647"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="209162647"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 09:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="491778855"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2021 09:57:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 7 Jul 2021 09:57:41 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 7 Jul 2021 09:57:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 7 Jul 2021 09:57:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 7 Jul 2021 09:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC7zC3do6VU6L7WQVFIK/Yplmlf+ZHTMIkiPG8e1Fc+n5iL9gxA6enNkPGdf+9NK2TpR008g6g/qadv9A6DVnSiECNfpmf6622mCNNwrMERcrr96Hl/gYL5EWCBOxwoL32fUmPzyIwKi4I/wGKjgftpPbsJ7rns1yb3Qcx9Hj55XpaZ9b9nfyAt3s8sP7GmT2UXpaz1AuMZrdEmyALbFpkk2uq+bUVSV8Bx5vLu98Ln4ZRYSC03tYxRjLXPp9EmpyrnPSDbF8FxQCjiR2sN5MVOTuuHXQwKyZm4VjH4jiK+p+aWZmoljy/ji+3w/VJIhJl9Cei2J4RTjwTTiISr3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT1She40AHvcsGDGybuL4r28O616CmSo+a1EV0yKmds=;
 b=DkZFC4HeEYo32GT0jywx4MYS+Iv8GhV7FuJUwcBa9L40np5tmF9WNr+/qwMZszP30RQWvnu7C6D4SyklzskAeRfkRxQ0WIaOq8b+mMHv8DlUobuzwTeLHN8tdWjOzPnAijfyWjhC5yyDIm6Q1rKqKwEnooVydRg0ASFmv8Ph/pXKJlTjcHRxafABLeo7friY+nU4uHHXunjhKXdwwWWk0qfF/Irq0rmKdkQg28rhFxnhWF5GUgdxRrlB80koJ815FpedK7CxnFSRoqPnINDxPNR5rt2WU0Dx56Ang3u9pEOj7/ShUs8ucPIAN6nxz6X2g9OObH22gbsiJXPc0UjFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT1She40AHvcsGDGybuL4r28O616CmSo+a1EV0yKmds=;
 b=zvfTHQPrLqlfNDWmxcGz7nkyBiRqOCCqq+H2acBOtDmg5FjNy++H8csPmE7h+C3xZhn8SxxlkkUSnudt3558psrscp4duWckS7hvVQUXEyiib0SiKcc71cayHZz4CH9XF/O8yQ6hGn+PELsxa0L0FS6nCCbySzK/6eLpevc7kxE=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (20.180.254.139) by
 DM6PR11MB3996.namprd11.prod.outlook.com (20.176.125.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Wed, 7 Jul 2021 16:57:40 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b528:9dc5:64b6:d69]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::b528:9dc5:64b6:d69%6]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 16:57:40 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Majd Dibbiny <majd@nvidia.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/1] RDMA/irdma: change the returned type to void
Thread-Topic: [PATCH 1/1] RDMA/irdma: change the returned type to void
Thread-Index: AQHXczv6xljTqudpoESIEGfKvxmIJas3k4AAgAAoNkA=
Date:   Wed, 7 Jul 2021 16:57:40 +0000
Message-ID: <DM6PR11MB4692BE37ABF89C46E819AD7DCB1A9@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210708064752.797520-1-yanjun.zhu@linux.dev>
 <AA895EB3-CA70-4907-83CB-ACFB56CF58CB@nvidia.com>
In-Reply-To: <AA895EB3-CA70-4907-83CB-ACFB56CF58CB@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49cd1d04-f39c-4f2e-8b2b-08d9416854b6
x-ms-traffictypediagnostic: DM6PR11MB3996:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB39964F37F97362BD8E35CC88CB1A9@DM6PR11MB3996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:312;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5+XJ/AJmylX8FjPHzAmvyLfQ6oTCiab3lHP1AZIfyLR33IpO3ahHMM/aFElfnkJiV14K+jjXKwWwLKdK8la/gm+nFDzGolbK1TJwJk8DXVOMqsUwF/piKyXnlFQzFkx3nabimpzpI54XXhuqP5YLvBar4BmeHCbwkf83LtO6Aor1BlKqzEfdNVFyBs5eFAWOAPyKDxL2O1M0LREAS3/9LSjZ3RZ/0XnqgpJM/+lwKS9cE2nQ21I5p52B/YeYE3ceXmr7rr/tJA3PMmbjwImUXxAKnoyfN4DXTlJc3eHOywiKfhrfMLAxMvOHHySlSIA2KR0ra9S6G+oKvqF8D7514/1h3qrLK/K4ln1cXOwCviImS5GNKDvM0ovl27n2kcsvieSx5lhBYdPRf0jVI5VPR6XNrS1xalruasy4b+/sOdZl+AfReoP2OCCzUUH2vL+YWXU3zJZ+L4BnTwDQVsgO0tLC8R4dNhMxD4wDcVMW+9AlZXwFuaXA/C2rW+aZCYHeZ9wn7sjouvEDSV/Mx+XpqW/hENmLT6oRjmi7caaek3KFX3gxWJ576O9eSip2PEjs7xrwaf7hNXPDdRKgl2UZi7uBLQBfaPCS9XR/I+kdluHoUarBh+EBSer2J4RBPvLVebuoOXl2mj7IQfBbJv5mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(346002)(366004)(136003)(396003)(33656002)(316002)(52536014)(54906003)(110136005)(5660300002)(7696005)(86362001)(8676002)(8936002)(2906002)(122000001)(83380400001)(38100700002)(186003)(4326008)(76116006)(6506007)(53546011)(66556008)(66946007)(66476007)(64756008)(66446008)(9686003)(55016002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVRBTm9PZW5FbnlPbWg2OE11dUFGTVdOT1lDQjl0YUFNSllSOXREQllOb0dz?=
 =?utf-8?B?L1BBQzV4bVc4YzVEUUZXckRXR0VCN0kzNDd5elBONVZJNVhDWDhMQ0huUkVD?=
 =?utf-8?B?U0xkcU1KSUVOQlFNaXFTSThjS25LakdhbmovcXYwQVZuSEFlMm5Zc0JMM3NZ?=
 =?utf-8?B?aW55cndWazdvdW1saER4aW9YMzRQUnNvMTJuaG9TNmxsdzVWN2FKaFZEeUFM?=
 =?utf-8?B?aDR4OEFydE0wcTBzYVZhOEF5Q0ZKT0VqQVRuZzBTSFZKZUVLaC9OTjlNSU41?=
 =?utf-8?B?c1IxZER6MlMwbDBSTzF1T3BaOEVtSWI1aWNxYnZXR1BEOWZxbHVQVTd6QjRz?=
 =?utf-8?B?Y0JrVTd0eGFBK1VDVE9QLzd0amY5UDdFaVhWbDRvZlM4YmIwYTFpK00zdEtO?=
 =?utf-8?B?d0lLYUpiVmJzSE1IWm51QWd5bjZXNWxSbjd5bGtPQ1pzeGs1ekFKdTk0NXQ2?=
 =?utf-8?B?Y1p2VGExRjY4NEhrNEVSN01JaDdPdHMxTEU3Z2VmMmtBby84c05ETkZDNXdp?=
 =?utf-8?B?ZGt4UDZNU2ZjOFVCamlJWUwxQndvUUY2c2E2UmQxZytScGdiVjZWdCs5ZmVN?=
 =?utf-8?B?d0dRNWxjbC9CeUlvTGRsb0hGWjR4bkdxU24vaWowcWI3bDhQR3ZQamRiaE5P?=
 =?utf-8?B?NmVWaHpXZVIwbmphUTVhOFJyRFlJUTBOTFh6L1A5Um10d2RQbmJaakFrSDV5?=
 =?utf-8?B?cWdxcHoxaVVZdXFodkRDNTh1QWtiVVo4cFhqM3RsbGZ6b3JIR1VhNWdOTGpy?=
 =?utf-8?B?cE1aWjJ5dEJCSnVyY0hWYzlNSmxVaitOTzlhekczaHluQnNDMHRlcXIxb2Zs?=
 =?utf-8?B?Nml5NHptT3h0RUtxdkVTV2I3QkVBamtvZmVxc0sycFg2Q1UrcjlRelNNT0p2?=
 =?utf-8?B?c2lKNEJwb1c0c0RrSXJsOUdKRlc4amhIMXBKdDdNdU5UbEtNdWpJN0IzT1V3?=
 =?utf-8?B?V1pHUENwYzVKYW9hK2ExN1B3enZXNVRWbXhreU1xQkhEL05GOGxON3RqdlBt?=
 =?utf-8?B?S3FMSVZYYUx1bTNJREZWOGJPZjBPSzg3VlY0S3p5RXY1c3JUdHRuTks5NDNz?=
 =?utf-8?B?ZkJUdlRwcjQ0T2RxeWdZcjhEVUsrcEtoQTZzVnVpa0NBN2NyQnV4WEg0azFO?=
 =?utf-8?B?WFZPaE1FdEUzU1FyUW1qQVZEUzQ2c2hrUTE2bVZxSmpFcTFraUZSOTJRSDA0?=
 =?utf-8?B?N2prUUdNVjlrWmkwNTNKYzFUZ0JteUthWDl4OVBIOW42K2dSbWpzcWJxUFBz?=
 =?utf-8?B?TDJaMnlXMGZUQUtBb3llM29xRW5sVWxPUzNIaG5UakpJaTZTZzRLNVJxLzQ5?=
 =?utf-8?B?U2kzc0hZVEw1TjNQaXFkck1VZjR2M2t3Q05ELzBVR0VMaTdzRngwOWtPaXBm?=
 =?utf-8?B?THRGczUrWlQ2TW5ZQVZUV3IrL3hiRmh2MDVha3I2clVMVmsvcFUrZ0J5R2pL?=
 =?utf-8?B?K0RnSytra25IaGZmVXpzNDFoTCtNMjNRS3ByMHh6MlBzN0ZzMGR0d1dLRmNZ?=
 =?utf-8?B?RHo4QkIxMVJadDc0OHlNOTE0VFoyaTVkbm92VHU3a253aER3RnFwVkhScTF3?=
 =?utf-8?B?UGFlMytKdzFUaTZRZWZnSmlDazhRcVFwYStVZE53QnFlSE01anB4NmpLSU16?=
 =?utf-8?B?MGw4ek0wbnNZb296K004c1ptMTMzZVZvZEJaSVB4N3h2ZjE0UEtNN2ZsWHVB?=
 =?utf-8?B?MCtiRnpXTElLTFcvZk1JRjhhNzZPK01EVFFtckdEZWUrbEVOV1BWUmVCSVBN?=
 =?utf-8?B?ZzBVNVprd090bUV2MkdodzdqRXNTbW1JZU40OWg2eHZKaTZEemdQYXhQS0hG?=
 =?utf-8?Q?JturSeJTuYZSFm+vl4D9gAafRZpN8glma9vow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cd1d04-f39c-4f2e-8b2b-08d9416854b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 16:57:40.2014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWh0sSX93r5kl688z+in6FvoU0cYDbbVIgQJ5Hojshz5G9mAaXU+2r93u8Ds/IOTfoukr3mKEsMo7iJQEkmv0/FuLHZ3Dg/FBkm/bJ2WSO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3996
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFqZCBEaWJiaW55IDxt
YWpkQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA3LCAyMDIxIDc6MzMgQU0N
Cj4gVG86IHlhbmp1bi56aHVAbGludXguZGV2DQo+IENjOiB6eWp6eWoyMDAwQGdtYWlsLmNvbTsg
SXNtYWlsLCBNdXN0YWZhIDxtdXN0YWZhLmlzbWFpbEBpbnRlbC5jb20+Ow0KPiBTYWxlZW0sIFNo
aXJheiA8c2hpcmF6LnNhbGVlbUBpbnRlbC5jb20+OyBkbGVkZm9yZEByZWRoYXQuY29tOw0KPiBq
Z2dAemllcGUuY2E7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8xXSBSRE1BL2lyZG1hOiBjaGFuZ2UgdGhlIHJldHVybmVkIHR5cGUgdG8gdm9pZA0K
PiANCj4gDQo+ID4gT24gNyBKdWwgMjAyMSwgYXQgMTc6MjQsIHlhbmp1bi56aHVAbGludXguZGV2
IHdyb3RlOg0KPiA+DQo+ID4g77u/RnJvbTogWmh1IFlhbmp1biA8eWFuanVuLnpodUBsaW51eC5k
ZXY+DQo+ID4NCj4gPiBTaW5jZSB0aGUgZnVuY3Rpb24gaXJkbWFfc2NfcGFyc2VfZnBtX2NvbW1p
dF9idWYgYWx3YXlzIHJldHVybnMgMCwNCj4gPiByZW1vdmUgdGhlIHJldHVybmVkIHZhbHVlIGNo
ZWNrIGFuZCBjaGFuZ2UgdGhlIHJldHVybmVkIHR5cGUgdG8gdm9pZC4NCj4gPg0KPiA+IEZpeGVz
OiAzZjQ5ZDY4NDI1NjkgKCJSRE1BL2lyZG1hOiBJbXBsZW1lbnQgSFcgQWRtaW4gUXVldWUgT1Bz
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4N
Cj4gUmV2aWV3ZWQtYnk6IE1hamQgRGliYmlueSA8bWFqZEBudmlkaWEuY29tPg0KPiA+IC0tLQ0K
PiA+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9jdHJsLmMgfCA5ICsrKystLS0tLQ0KPiA+
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL2N0cmwuYw0KPiA+IGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL2N0cmwuYw0KPiA+IGluZGV4IGIxMDIzYTdkMGJk
MS4uYzM4ODBhODVlMjU1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9p
cmRtYS9jdHJsLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY3RybC5j
DQo+ID4gQEAgLTI4NDUsNyArMjg0NSw3IEBAIHN0YXRpYyB1NjQgaXJkbWFfc2NfZGVjb2RlX2Zw
bV9jb21taXQoc3RydWN0DQo+ID4gaXJkbWFfc2NfZGV2ICpkZXYsIF9fbGU2NCAqYnVmLA0KPiA+
ICAqIHBhcnNlcyBmcG0gY29tbWl0IGluZm8gYW5kIGNvcHkgYmFzZSB2YWx1ZQ0KPiA+ICAqIG9m
IGhtYyBvYmplY3RzIGluIGhtY19pbmZvDQo+ID4gICovDQo+ID4gLXN0YXRpYyBlbnVtIGlyZG1h
X3N0YXR1c19jb2RlDQo+ID4gK3N0YXRpYyB2b2lkDQo+ID4gaXJkbWFfc2NfcGFyc2VfZnBtX2Nv
bW1pdF9idWYoc3RydWN0IGlyZG1hX3NjX2RldiAqZGV2LCBfX2xlNjQNCj4gKmJ1ZiwNCj4gPiAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBpcmRtYV9obWNfb2JqX2luZm8gKmluZm8sIHUzMiAqc2Qp
IHsgQEANCj4gPiAtMjkxNSw3ICsyOTE1LDYgQEAgaXJkbWFfc2NfcGFyc2VfZnBtX2NvbW1pdF9i
dWYoc3RydWN0DQo+IGlyZG1hX3NjX2RldiAqZGV2LCBfX2xlNjQgKmJ1ZiwNCj4gPiAgICBlbHNl
DQo+ID4gICAgICAgICpzZCA9ICh1MzIpKHNpemUgPj4gMjEpOw0KPiA+DQo+ID4gLSAgICByZXR1
cm4gMDsNCj4gPiB9DQo+ID4NCj4gPiAvKioNCj4gPiBAQCAtNDQzNCw5ICs0NDMzLDkgQEAgc3Rh
dGljIGVudW0gaXJkbWFfc3RhdHVzX2NvZGUNCj4gaXJkbWFfc2NfY2ZnX2l3X2ZwbShzdHJ1Y3Qg
aXJkbWFfc2NfZGV2ICpkZXYsDQo+ID4gICAgcmV0X2NvZGUgPSBpcmRtYV9zY19jb21taXRfZnBt
X3ZhbChkZXYtPmNxcCwgMCwgaG1jX2luZm8tDQo+ID5obWNfZm5faWQsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICZjb21taXRfZnBtX21lbSwgdHJ1ZSwgd2FpdF90eXBlKTsNCj4gPiAgICBp
ZiAoIXJldF9jb2RlKQ0KPiA+IC0gICAgICAgIHJldF9jb2RlID0gaXJkbWFfc2NfcGFyc2VfZnBt
X2NvbW1pdF9idWYoZGV2LCBkZXYtDQo+ID5mcG1fY29tbWl0X2J1ZiwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBobWNfaW5mby0+aG1jX29iaiwNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmaG1jX2luZm8tPnNkX3RhYmxlLnNkX2NudCk7DQo+ID4gKyAgICAg
ICAgaXJkbWFfc2NfcGFyc2VfZnBtX2NvbW1pdF9idWYoZGV2LCBkZXYtPmZwbV9jb21taXRfYnVm
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIGhtY19pbmZvLT5obWNfb2JqLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICZobWNfaW5mby0+c2RfdGFibGUuc2RfY250KTsN
Cj4gPiAgICBwcmludF9oZXhfZHVtcF9kZWJ1ZygiSE1DOiBDT01NSVQgRlBNIEJVRkZFUiIsDQo+
IERVTVBfUFJFRklYX09GRlNFVCwgMTYsDQo+ID4gICAgICAgICAgICAgICAgIDgsIGNvbW1pdF9m
cG1fbWVtLnZhLCBJUkRNQV9DT01NSVRfRlBNX0JVRl9TSVpFLA0KPiA+ICAgICAgICAgICAgICAg
ICBmYWxzZSk7DQo+ID4gLS0NCj4gPiAyLjI3LjANCj4gPg0KIA0KQWNrZWQtYnk6IFRhdHlhbmEg
Tmlrb2xvdmEgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRlbC5jb20+DQo=
