Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028252F383F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jan 2021 19:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406109AbhALSOd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 13:14:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:31401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406097AbhALSMY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:24 -0500
IronPort-SDR: IsJYrpzj1q02P+/Im89ZnJfqZkDdNys8aMeNOOpITtmTeagy+hDiUYyWJeRf6xhIV+xKFOk86M
 kU/wjiWX45zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="196712166"
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="196712166"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 10:11:43 -0800
IronPort-SDR: yMmiz3SPsTZXxBYnLA1tAc53oYZjvTXwzTbyUvYXIZX1iq4yHMGTThdNlfRZLtITt4aDPR900Z
 DnIR0P/+BOiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,342,1602572400"; 
   d="scan'208";a="498997892"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2021 10:11:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 10:11:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 10:11:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Jan 2021 10:11:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 12 Jan 2021 10:11:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyaN2iW35X0hbvL5pPTS4IShxLZLv4Kj1cUUa6ScbPOoo3i8vzlglFVvkZyu1Q0AlT7VtQ9pUKwH8/PmF4L+nceN1v48XWIh44j7HZVHO1rdABHFuCYqDAbhvLNYTzbydyvQJAOy96tuCCRQFBF7UgxRGAUEV7Tm4tvvgrM9lH0hUV+aOuXTcXFhU7/JXU9fNiAatu04t7A7Gy5i0yyAe4xKY/RTY/gO80qnZ1BUxHGZErJNaHA1Se1hGsfCRBz6v1fM7drjMfdaFCHFKN2rZYdfyoEB+/aQzKnrsRRfjeet+4OoBIKFcE8iXQq89srk7vdzyD1r/RhlxGpIptpcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLC6KpBZq/O0WWEtxxdojYQ/aesXTCWnSXjtt/4Dx3Q=;
 b=encM64U1L94LXClJjzYPRTasoQidLxN91/8KmdoXHMSczCxEvApxekf9jK5yG7Tr8SjxH+avjO/cQZ3XVFkmizurt1CNrJ6mQjCI3TKvNq7Ynp2734CLVriNdjpVNp8q8+fRNpmBE33na0dlFvQLZjYrUKYQrMzv8teFrjAHfUsFObPzR5+XZ1RciwlniGrGtKtjugbvrFTy5eNkRrTJqeZCJv9zzwHQJ2MXtn8mt3qEBKEDPHaenKwBMLNqsvV8JJjEHgMWABHBcSZcoSH+tjIvaILLcxlWrRDR1KZUdg1AQMvRWJFdobheE4k4PJmA1wLlmuj8cbUzC7d9jgR1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLC6KpBZq/O0WWEtxxdojYQ/aesXTCWnSXjtt/4Dx3Q=;
 b=LbUCMhUc8VWhGQY7BOumgLu1AiOjJxhEs7oSjDdJPWfCHuM5DjVRiPG4qJ4KlAu1RyG5xBy0ZuMahn+LyLNQOupYlPK3jZ8IUM2trHbroRSFq2qxaeh5IEfJyk4M523r2cHaPKKGQogdWh6mnG6Cb7fLrCI5XpwkHC81yzm3g38=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR11MB1984.namprd11.prod.outlook.com (2603:10b6:300:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 18:11:27 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::4476:930f:5109:9c28%5]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 18:11:27 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Yishai Hadas <yishaih@nvidia.com>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: RE: [PATCH v16 0/4] RDMA: Add dma-buf support
Thread-Topic: [PATCH v16 0/4] RDMA: Add dma-buf support
Thread-Index: AQHW0ybv5Bnk7Ef2+EKwhnBRO9bgTqoitKeQgAAF2oCAACAzkIAAApoAgAABi2CAAT2EAIAAVZ8Q
Date:   Tue, 12 Jan 2021 18:11:27 +0000
Message-ID: <MW3PR11MB4555CBDC7BB290C39FE61DEAE5AA0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com>
 <MW3PR11MB4555CCCDD42F1ADEC61F7ACAE5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20210111154245.GL504133@ziepe.ca>
 <MW3PR11MB4555953F638E8EDCD9F2CA90E5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <CADnq5_NTwynVt=ZPF-hiNFaWfEWiDnoTQCS0k1zx421=UAFSNA@mail.gmail.com>
 <MW3PR11MB455518915ED5AE1F2FF0CAB1E5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <8aa96c52-f31f-b8d8-bf16-897775bd9c78@nvidia.com>
In-Reply-To: <8aa96c52-f31f-b8d8-bf16-897775bd9c78@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 358decc7-db0e-499a-4cf4-08d8b7257aa5
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB19845266657C472C9BC3D5F3E5AA0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y9Bs4wHuHqRXfP/uCLh7GAq9ivZVGEaoDrbbp9Ezn1/iCxskQJiLf1+99rRqSrk+CVuAZuzhXBlZ9gUVTpyqV+H2fH4CeE8aEm86Z04pHBHEMOTR9ygJtAwHx7AFjCuUJiaJjTaG3nH0IUk2DVuCQE/Q7KSiNjc6fKWHlGdTV/ikWh7hl5GLkzb2qE5J7GKoSs3f0De3+NwBaf7brT1qR/cRObD7/hsp9W/akGDVYhemuALQ8qr2m1vfSE60AHaCkEo62OuOLrUSD3ZKZLP4jV/v+smQiKfxvbl9mlohQ/wyWs9OMXJ/L7KrRUfZ2EKQo1aC7T7IdPNDGVFk540qfvltMBP8QkQ0ATOfUclIjX6rftsWf0hf9sgdUx3L9SZaktnB4vnlw9PcnbCA6Gxt5sxwP4V2SueIEzPECzpo07KMI3+VrzQTPRI+32d1HAZxOvhxr42bMdFUNCArms7Ebw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(66946007)(110136005)(76116006)(26005)(4326008)(5660300002)(316002)(66476007)(86362001)(186003)(6506007)(8676002)(64756008)(966005)(66556008)(2906002)(33656002)(66446008)(9686003)(7696005)(55016002)(71200400001)(478600001)(83380400001)(8936002)(53546011)(52536014)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R0xyK1ovTk4vd201QlZaOGc2L1kxMzBaSUMvN09QR0FZNnBLYlBNWmh6L0Jv?=
 =?utf-8?B?MHpoUk5xQlgzOHNOei95aWJwQ29yRU14UkF0OFpIdVgydjlodTBGSng5M2cz?=
 =?utf-8?B?cWVPdEJ6YVcwUzlpbE5hNnBMM0RWZjErS1RsZ3VzZmVuU2VEQzgvZjg3L2F1?=
 =?utf-8?B?NGZNenhKMTF4UWVRZUtXcHEzRkI0NHFuTHhPNE9yZ2tONnlRVjhCSGRMOWxj?=
 =?utf-8?B?QU10b28rVmQ0VXRKU0tCS2RCQUVITjRHRFRoNVl0azh6NUc2YVA0azB3a2pC?=
 =?utf-8?B?RWJpVmEvemxzZkR5a1lLL3RWekFXVzNjaENqdHgreE43WHl0RDJiWnlUekQ0?=
 =?utf-8?B?RjlNQ0lIbDc1dmZhdTFOVFl5Q01YUHd6M0JXWkZrS3djZG5qWXp4MHlQM2xv?=
 =?utf-8?B?T1hlMUUrRVUycDJJYVRScHNIcHV6cFpNdlkwSTZUbEdhWU02cm9RTnM0WkYx?=
 =?utf-8?B?cHZFNGZHSWRXMkFrTmxoRW9QM1hkN3pPSnY4UDNrUlMyNGRmYVJuWVVJNWRH?=
 =?utf-8?B?OWg0d003c2Jab29wcFBxMU45c2NwWnh6TkVzaitYWis4aFArUzYzL0g3V215?=
 =?utf-8?B?NWRZN3JuY3hKVDBPNnUxQzNaYlBaRGFsSEptZkVaT2IxM1YyaEpOWCtuQStm?=
 =?utf-8?B?M0EvMzRzVDB2emZLTm93YW9vNVZkVWVhbGlIakRBS21EbUF2RXNmSm43R05U?=
 =?utf-8?B?djBLZlc1ZDNJWG5lWjVZUnRkcUJwMjgzSlJLZEdmd1JjMEd4c1orQXQ5MFFV?=
 =?utf-8?B?bndnM3FYSE5IcmtZeThaZ3pMWWRoaFEwaXJGQ3BOR2dHV2xFYThLUnBQUHZN?=
 =?utf-8?B?TG5FYjQ2bFZNMTBUWkJiM3JBRVY4djl6R3JEWjNwYUIvclNGelYzeVRFUVJZ?=
 =?utf-8?B?MlB2Ylp3dFlsRERiZ0ZNTWRCZzVOeTQySXZGYzF2Zzk3ejNvcFltQWdNZTdq?=
 =?utf-8?B?ajhRL1czaC9QZTEzMHdXeUpNQlA3UUNhODZaRkZ4eFpPRDV6SkQ2VUd4NFhU?=
 =?utf-8?B?Tm01U0lsZklHRHRQQVN6b3BOM2pWOFhXSXVDWVZOOEtnMERBK3pCRkhwbHB3?=
 =?utf-8?B?WkNvVkxaZnNxMGhwRmI0bThYTDhXVzA2RUZKUTlPd081WUl6bzdlNGYzS3pa?=
 =?utf-8?B?V1NJZndqRmNGYXpDbVRxMDdRSUVQQ29ZSmxsdE5nN1F4ZFQ5Nk5DWGt3d3Ji?=
 =?utf-8?B?S1JGR1BVMGxqNWNiRDRVazI4am1sUUhzWkxqbmpGcEp2WmlxeWNZeHRyUzdC?=
 =?utf-8?B?QkswSnlBR1lVaUg5djM3Rk5KZlJCaGpuOWF2dlgrQ25Jbk81aUthM0t4R0pw?=
 =?utf-8?Q?hDpoDpN2N2GHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358decc7-db0e-499a-4cf4-08d8b7257aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 18:11:27.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRduaxV15nOdtn/iImvUW0L+gbH+I754Oyr+qRpTWXuivJlpqbcPcmZO10DhPvuO3Nv8izQ6hHpWOwHKxCaOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlpc2hhaSBIYWRhcyA8eWlzaGFp
aEBudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDEyLCAyMDIxIDQ6NDkgQU0N
Cj4gVG86IFhpb25nLCBKaWFueGluIDxqaWFueGluLnhpb25nQGludGVsLmNvbT47IEFsZXggRGV1
Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dA
emllcGUuY2E+OyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47IGxpbnV4LXJkbWFA
dmdlci5rZXJuZWwub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBEb3Vn
IExlZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+OyBWZXR0ZXIsIERhbmllbCA8ZGFuaWVsLnZl
dHRlckBpbnRlbC5jb20+OyBDaHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+OyBZaXNoYWkNCj4gSGFkYXMgPHlpc2hhaWhAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MTYgMC80XSBSRE1BOiBBZGQgZG1hLWJ1ZiBzdXBwb3J0DQo+IA0KPiBPbiAxLzEx
LzIwMjEgNzo1NSBQTSwgWGlvbmcsIEppYW54aW4gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPg0KPiA+PiBTZW50OiBNb25kYXksIEphbnVhcnkgMTEsIDIwMjEgOTo0NyBBTQ0KPiA+PiBU
bzogWGlvbmcsIEppYW54aW4gPGppYW54aW4ueGlvbmdAaW50ZWwuY29tPg0KPiA+PiBDYzogSmFz
b24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBMZW9uIFJvbWFub3Zza3kNCj4gPj4gPGxlb25A
a2VybmVsLm9yZz47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEb3VnIExlZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+
Ow0KPiA+PiBWZXR0ZXIsIERhbmllbCA8ZGFuaWVsLnZldHRlckBpbnRlbC5jb20+OyBDaHJpc3Rp
YW4gS29lbmlnDQo+ID4+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjE2IDAvNF0gUkRNQTogQWRkIGRtYS1idWYgc3VwcG9ydA0KPiA+Pg0KPiA+
PiBPbiBNb24sIEphbiAxMSwgMjAyMSBhdCAxMjo0NCBQTSBYaW9uZywgSmlhbnhpbiA8amlhbnhp
bi54aW9uZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+Pj4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+ID4+Pj4g
U2VudDogTW9uZGF5LCBKYW51YXJ5IDExLCAyMDIxIDc6NDMgQU0NCj4gPj4+PiBUbzogWGlvbmcs
IEppYW54aW4gPGppYW54aW4ueGlvbmdAaW50ZWwuY29tPg0KPiA+Pj4+IENjOiBsaW51eC1yZG1h
QHZnZXIua2VybmVsLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj4gPj4+
PiBEb3VnIExlZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+OyBMZW9uIFJvbWFub3Zza3kNCj4g
Pj4+PiA8bGVvbkBrZXJuZWwub3JnPjsgU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJv
Lm9yZz47DQo+ID4+Pj4gQ2hyaXN0aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PjsgVmV0dGVyLCBEYW5pZWwNCj4gPj4+PiA8ZGFuaWVsLnZldHRlckBpbnRlbC5jb20+DQo+ID4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTYgMC80XSBSRE1BOiBBZGQgZG1hLWJ1ZiBzdXBwb3J0
DQo+ID4+Pj4NCj4gPj4+PiBPbiBNb24sIEphbiAxMSwgMjAyMSBhdCAwMzoyNDoxOFBNICswMDAw
LCBYaW9uZywgSmlhbnhpbiB3cm90ZToNCj4gPj4+Pj4gSmFzb24sIHdpbGwgdGhpcyBzZXJpZXMg
YmUgYWJsZSB0byBnZXQgaW50byA1LjEyPw0KPiA+Pj4+IEkgd2FzIGdvaW5nIHRvIGFzayB5b3Ug
d2hlcmUgdGhpbmdzIGFyZSBhZnRlciB0aGUgYnJlYWs/DQo+ID4+Pj4NCj4gPj4+PiBEaWQgZXZl
cnlvbmUgYWdyZWUgdGhlIHVzZXJzcGFjZSBzdHVmZiBpcyBPSyBub3c/IElzIEVkd2FyZCBPSyB3
aXRoDQo+ID4+Pj4gdGhlIHB5dmVyYnMgY2hhbmdlcywgZXRjDQo+ID4+Pj4NCj4gPj4+IFRoZXJl
IGlzIG5vIG5ldyBjb21tZW50IG9uIHRoZSBib3RoIHRoZSBrZXJuZWwgYW5kIHVzZXJzcGFjZSBz
ZXJpZXMuDQo+ID4+PiBJIGFzc3VtZSBzaWxlbmNlIG1lYW5zIG5vIG9iamVjdGlvbi4gSSB3aWxs
IGFzayBmb3Igb3BpbmlvbnMgb24gdGhlIHVzZXJzcGFjZSB0aHJlYWQuDQo+ID4+IERvIHlvdSBo
YXZlIGEgbGluayB0byB0aGUgdXNlcnNwYWNlIHRocmVhZD8NCj4gPj4NCj4gPiBodHRwczovL3d3
dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1yZG1hL21zZzk4MTM1Lmh0bWwNCj4gPg0KPiBBbnkg
cmVhc29uIHdoeSB0aGUgJ2ZvcmsnIGNvbW1lbnQgdGhhdCB3YXMgZ2l2ZW4gZmV3IHRpbWVzIHdh
c24ndCBub3QgaGFuZGxlZCAvIGFuc3dlcmVkID8NCj4gDQo+IFNwZWNpZmljYWxseSwNCj4gDQo+
IGlidl9yZWdfZG1hYnVmX21yKCkgZG9lc24ndCBjYWxsIGlidl9kb250Zm9ya19yYW5nZSgpIGJ1
dCBpYnZfZGVyZWdfbXIgZG9lcyBjYWxsIGl0cyBvcHBvc2l0ZSBBUEkgKGkuZS4gaWJ2X2RvZm9y
a19yYW5nZSgpKQ0KPiANCg0KU29ycnksIHRoYXQgcGFydCB3YXMgbWlzc2VkLiBTdHJhbmdlbHkg
ZW5vdWdoLCBhIGZldyBvZiB5b3VyIHJlcGxpZXMgZGlkbid0IHJlYWNoIG15IGluYm94IGFuZCBJ
IGp1c3QgZm91bmQgdGhlbSBpbiB0aGUgd2ViIGFyY2hpdmVzOiAgaHR0cHM6Ly93d3cuc3Bpbmlj
cy5uZXQvbGlzdHMvbGludXgtcmRtYS9tc2c5Nzk3My5odG1sLCBhbmQgaHR0cHM6Ly93d3cuc3Bp
bmljcy5uZXQvbGlzdHMvbGludXgtcmRtYS9tc2c5ODEzMy5odG1sDQoNCkkgd2lsbCBhZGQgY2hl
Y2sgdG8gaWJ2X2RlcmVnX21yKCkgdG8gYXZvaWQgY2FsbGluZyBpYnZfaWJ2X2RvZm9ya19yYW5n
ZSgpIGZvciBkbWFidWYgY2FzZS4NCg0KVGhhbmtzIGEgbG90IGZvciBicmluZyB0aGlzIHVwIGFn
YWluLg0KDQpKaWFueGluDQogIA0KDQoNCg==
