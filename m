Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB796E121D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDMQUT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjDMQUO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 12:20:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52B5A275
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 09:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJUSGnrfZw4XlcSf7wLB1xYKTRsz2Ly8jsLpqgCQDbuUGFGcAN2BJ/NNAJ3WWBo86uXsoMaP9/VHylkPwOJHdyQU6URc5UhqPIVfAJrQrBi2BoPy2v4shpFIE7WeKo4fKKNyUUwQkyKB0HkIB3fATFhbBMQsUmRKOTugpZai/uTkR+CM+8pFQCyeDDrFAE5sKuVPdOE4z8eu1S3f70Va7bYyf8FMdXy7OVTZEb7l/pkSR4zeWTQ6ckHGAOQgrRNBRxpGy9iWtBLgsowUSNjWeyPMLloqnT3fW+e0qf7ol8BOwC77H53Svt5nfQs/QpKFasSnD7dhKW/s8MRN8MxD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fwh1bzhQYx27cSn792HHUJ7G68qbTnvZaC2kNC4PYqU=;
 b=ULVG97td4UbypN4m1eAugoNb6RMHSWzYo45ZTP2rEF7ZxfigzmwLG/bb511XRCZXFz/wcZ9txTu3jF1OHQ3FC0gtOOt0+cno37cXybYD6WUsWF+Zs3yw2CUJ4xz+swgwg4FURyQxuJe2GocT7L2hLWDhhjG+5W7DPWqOe/ubsqSFMwdYoKw8AYW4w8c90947DAfXA1Umc//bd4qCDliA2QR2CoaxOrkb9qR5hlAVVAMtFzF/6FO25AtZzQA7bsx1DeVCjVUiUBOW89jMBLIiBUQCCDke+yev2fbRKQlJnxGFcndLmEndnKXzdemZOI+d34WZyOC3zB2Gj5Trlrs9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwh1bzhQYx27cSn792HHUJ7G68qbTnvZaC2kNC4PYqU=;
 b=gy6NL8ziJLH+xNn8eXL5mtux/MzlF+PQcivlz+IwGNAJNPjIcmE5dfkl/Madu3Jda8XaDuyo/TaQiNWkGOqecpy5OBhU0xT7MkWYP5bMvFaHOMte0kGZ+HnAe3p3xwy3nWCEqQrsMVAAljB9uBJYMvyJL/NIPim7zTKQZxaruVdy8OFup8PLRMMtzXlMEjI24Y1HwXc/s+BIzz0NiISNznvoZBZWjf/6AWSLc3W4wDoX0prTq0i3SPDRWXJxWVmSs+/ryYIdBbYX5eXxtcPhkOlK6+Y08CJuy5JbFc8CbkReB+9TX4ZUum+usoIh8UlFdxUociB8va0fpNj2mRW/kg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 16:20:01 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1c51:21c0:c13c:3ed3%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 16:20:01 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Mark Lehrer <lehrer@gmail.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
Thread-Topic: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
Thread-Index: AQHZQDq78euIxrtulEiTJiby3UJy1a8oRlKAgAA9FwCAAK1xAIAAXqEAgAAARcCAACvLAIAAC2Og
Date:   Thu, 13 Apr 2023 16:20:01 +0000
Message-ID: <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
 <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
 <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
In-Reply-To: <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5287:EE_
x-ms-office365-filtering-correlation-id: bbde9f90-9233-488c-2c7a-08db3c3aeed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZ5WRFI/rzqeKV1cqSUvdeHM2h5PTJE0tDZkfE5gFy94nXoQPEONgIuCBeuW3sZJKGoNy6azSVrxzgP3MwJiVkmMKBjN1t6FjAEGZBmn3hQ1KQOUnTsg6nEKVPLvpnLbClIwKx3I1DmYHo4XAeuJQyd9gBJeLZSSE7OW9xgYuAwXfsGdMVDR6FWcC03xY6uW7ronEojifrK/4nWiJd3celgKQ0vjRO5AXXrEqc8hk35fMRWw4NqPjcvuIXyw/zFXbejB7urd+Mo4CkQREr37X0akHMIzv/kR8BBtrSanNRnT1wo+OxLB/D33h7sD3DYvSofQhdAC1sOVbK+SApGpRPsPx1eeLK+0fcT0sCz+2wKc1ArnAQo7RgVwDkfO4tggPwfFV1cR5yNA87qTTdlN2MSrzQ5d7QK0F0QeqayDlJLkQwiQrHX6Qd1hMKS2PURjARecRrr9oxANGymgAaA4FaD6btnVjhel1+Zw2IycNVLEyXayAgCV2/CvRPMwhwqwczHeIrZ1Az7B3FxvRtKZGhpOA0Y5HxH9bwWzEFymNa106j5aavUb+8BttgpQ8ssP2D+Ms+SkR1R3E8UAHO9TspTG/wK3iIYixzPGemID/bgUBykVMHEZlyVXEUXuBg2fUkUqOJsdDsDpOJ1q6m0cbgsW8kdW0DCij2u3KNPiPmn2SxIGTRwIalXQTbKUkILQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(6916009)(316002)(54906003)(4326008)(66556008)(66476007)(66946007)(966005)(76116006)(66446008)(64756008)(6506007)(71200400001)(7696005)(478600001)(55016003)(5660300002)(8676002)(8936002)(41300700001)(2906002)(52536014)(38070700005)(33656002)(122000001)(86362001)(53546011)(38100700002)(9686003)(186003)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjRMbnV2eHh6U3BVdEFUWjhEQXhrQjNoRHZ3K1RpdjRUZzBQRERCOEkxWnFa?=
 =?utf-8?B?dHF6azhsem9zeTJHb2JveVByVlE0MWJrU0p1emFZWmxLQlNmcnBtbmNmdGg4?=
 =?utf-8?B?Q0gzOTg0YkRmNmFRdUJTVHFJeUFNLzF1M3hjQUVyZTlSTGRWcmt4TW1IbHli?=
 =?utf-8?B?QUNZcTFYcGJ2a013Nm40RlJpbUJDTEQ2Tml3UlFkU05LRXJhZnNDc0Q3Nmd2?=
 =?utf-8?B?YzdHTkJFQlFXbkdsMk1vUnZjRUJzeW1mSnBaRXArZWFSeTZCeGIzNnFYcHF4?=
 =?utf-8?B?eFVBU3FDcU1nTm5EMnRQUU9yK1ZxSlZDb1JQM1VFZnlXU2xkU2VMUzZQYjFw?=
 =?utf-8?B?QWd0RVJmSjhNWWtuQTJTdVRoc2tyTCtnZDhycUxWVGZqazhldW90UEowbFRv?=
 =?utf-8?B?VWRiVDZLUnFpR0JUR3MrTFI3bS9GbHdFTmtZYzBOU1NVc05EdHhLemdZNWUy?=
 =?utf-8?B?RWJPNUpTWkNjY3BXcEpTYjNaa05Oazd5UnNXemRKOWdQdDZRSG5wWUZja0h1?=
 =?utf-8?B?d1M4TEV4RVdPdHlQNTRlTCtGNm9RdlAzNENRUGZLbGZBOWVqQUFscE0xcXlC?=
 =?utf-8?B?RitRVlcrQnNtRlZtd2dtWWp2UzA4NmM3c1JqUjB5MkYxUkNWK3ZkQ0I3Z1dP?=
 =?utf-8?B?TWpCblZzelZlT2VtRlZwajA4ck5HRmlQQzhIQ3BIZnV6YXRqdEVVS3BpVGVk?=
 =?utf-8?B?QmwrSEQvRzQyZXZpTHVOUWJCL3JYY09ZZVgvUDhETDZMZ2k3dmxvUWt3ajRW?=
 =?utf-8?B?dXUxQThlNzlOenNNTzRXR3FVZWIwL0pvS01DQXBmRlR3QWtTbyt6SjRYZ3Y2?=
 =?utf-8?B?NEZJVUJmNFg3MVBxQWJ2dldIdVlzVjhmTkFwTGU0emVhRU1kNFBIR0FhQmVE?=
 =?utf-8?B?T3Q0cWdSK0toenVMdHMzREZCRmxWUnI2cE9tMnJpczlYT2tuV2VpYmsvM0ti?=
 =?utf-8?B?aStic3orT205dzRIcDJNSU5qMGJtcWgyamJLSWNFRWx4MGV3TkxCbGJNR2gx?=
 =?utf-8?B?Kzd0S2pueCtVNUV2QlV0ZHFVSDlQbys2clYwL3AvVUh3YzBKRXBoMmVPUVZ3?=
 =?utf-8?B?MUJpbXVUdzd3YXBkbDMrYllUcTlyUk45MHNxMTk1NWhzZ0xsOGo0TW1ZaUpL?=
 =?utf-8?B?VGN0VmtBVm9RNHBnak1LLzdhUzhpSjQvenY1TmxpdEhnRkdPL2ZJZVRrcHdl?=
 =?utf-8?B?cEIxTDl2MnIxNVpET3VwRU1oSEJ0ZDNyMlA4T3NWemJSNFhFZk5Pa0dPTW5I?=
 =?utf-8?B?N1Z1UXp1Y0pkWnFkb0UxYkpCL3NwSmFjVlIxN2x0VFQvZDFsZHhGc2Y2aERB?=
 =?utf-8?B?a1poMk1kMWM0WUpWRzRJMVRxQURZTUlUejZZUHlmS20zQmFjYW5GTEVqc1pL?=
 =?utf-8?B?dG1KOVdYWVBIR3dyWUpuYXJ5Z0ZXRGZVMGVtR1NBYzZvQ01SbUJvZWFzR1Y3?=
 =?utf-8?B?SDlHV1NRcnpOY2hneTBqN0svdzUvTjNyc0o4cExoZ1piOHFHWnpnNUpBSHlk?=
 =?utf-8?B?MXNXR2psRHdQcmNzaVZEeTdMUjNJazZjOGtNNnM1NmRhbk42aTQ5NXRrcEdO?=
 =?utf-8?B?VUlCUW96UFRCVzI2RE9zVDVYMFUxZERvYzM3QmpOTmhsOUpEWVN1Y0RaQnFE?=
 =?utf-8?B?aUhiWmFQaFczQU43SUtsaEFRMDZzMjZLMk1BTzNNMkRzMThPbDcxSWw4Z1Qy?=
 =?utf-8?B?eFZYYmhIWnpMeVRLdEM2QnkwbHlHbnF6RFBDSmltN2ZtdDRWZE8vdEFRbjM2?=
 =?utf-8?B?UnFGMnpmSytKMlJaTmJsUm5ZQVhQVG5OT3BVWnlnVndCeUtFcG1Yc2dGcUxW?=
 =?utf-8?B?eXhZVks4d3ZKbURBcVgzemI2L1k5Rm04T3JaVUJ5U2JYNyttNHpSemJ3dlJy?=
 =?utf-8?B?M2NOVUQyc3pPaVFuWTh4dCthMVMvM1lCSkpRMHNveVFweWcrbElvMFdUcGRQ?=
 =?utf-8?B?RjE0eW52eGFLQU9ZWFdjaUJzSUxZUHBOakJ0S3lNTGh5dWJ0OHVJcXArU21S?=
 =?utf-8?B?YS9BTTZNN0ZsaDJIanlOVzhkOHorZzNmZmxrWkRKYkpvTmFDYk9WZ3VMTUZB?=
 =?utf-8?B?L2NTUE5xVFpWZ3dmb0MzTDI1REszSEJpWEhEVWJCUkQ4QVppOU9ZUVhtQ2FU?=
 =?utf-8?Q?lEBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbde9f90-9233-488c-2c7a-08db3c3aeed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 16:20:01.5309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/dA6baeqW198HLHJrjTEi6aoPbJbv6A8blARelUHOtgbgA24Xl/2++EHrmw+7z/WQfARAMzKcUavoSFjiGi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogTWFyayBMZWhyZXIgPGxlaHJlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCAxMywgMjAyMyAxMTozOSBBTQ0KPiANCj4gPiBEaWRu4oCZdCBnZXQgYSBjaGFu
Y2UgdG8gcmV2aWV3IHRoZSB0aHJlYWQgZGlzY3Vzc2lvbi4NCj4gPiBUaGUgd2F5IHRvIHVzZSBW
RiBpczoNCj4gDQo+IFZpcnR1YWwgZnVuY3Rpb25zIHdlcmUganVzdCBhIGRlYnVnZ2luZyBhaWQu
ICBXZSByZWFsbHkganVzdCB3YW50IHRvIHVzZSBhIHNpbmdsZQ0KPiBwaHlzaWNhbCBmdW5jdGlv
biBhbmQgcHV0IGl0IGludG8gdGhlIG5ldG5zLiAgSG93ZXZlciwgd2Ugd2lsbCBkbyBhZGRpdGlv
bmFsIFZGDQo+IHRlc3RzIGFzIGl0IHN0aWxsIG1heSBiZSBhIHZpYWJsZSB3b3JrYXJvdW5kLg0K
PiANCj4gV2hlbiB1c2luZyB0aGUgcGh5c2ljYWwgZnVuY3Rpb24sIHdlIGFyZSBzdGlsbCBoYXZp
bmcgbm8gam95IHVzaW5nIGV4Y2x1c2l2ZQ0KPiBtb2RlIHdpdGggbWx4NToNCj4gDQoNCnN0YXRp
YyBpbnQgbnZtZXRfcmRtYV9lbmFibGVfcG9ydChzdHJ1Y3QgbnZtZXRfcmRtYV9wb3J0ICpwb3J0
KQ0Kew0KICAgICAgICBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIgPSAoc3RydWN0IHNvY2thZGRyICop
JnBvcnQtPmFkZHI7DQogICAgICAgIHN0cnVjdCByZG1hX2NtX2lkICpjbV9pZDsNCiAgICAgICAg
aW50IHJldDsNCg0KICAgICAgICBjbV9pZCA9IHJkbWFfY3JlYXRlX2lkKCZpbml0X25ldCwgbnZt
ZXRfcmRtYV9jbV9oYW5kbGVyLCBwb3J0LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eDQpOdm1lIHRhcmdldCBpcyBub3QgbmV0IG5z
IGF3YXJlLg0KDQogICAgICAgICAgICAgICAgICAgICAgICBSRE1BX1BTX1RDUCwgSUJfUVBUX1JD
KTsNCiAgICAgICAgaWYgKElTX0VSUihjbV9pZCkpIHsNCiAgICAgICAgICAgICAgICBwcl9lcnIo
IkNNIElEIGNyZWF0aW9uIGZhaWxlZFxuIik7DQogICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9F
UlIoY21faWQpOw0KICAgICAgICB9DQoNCj4gDQo+ICMgbnZtZSBkaXNjb3ZlciAtdCByZG1hIC1h
IDE5Mi4xNjguNDIuMTEgLXMgNDQyMCBEaXNjb3ZlcnkgTG9nIE51bWJlciBvZg0KPiBSZWNvcmRz
IDIsIEdlbmVyYXRpb24gY291bnRlciAyID09PT09RGlzY292ZXJ5IExvZyBFbnRyeSAwPT09PT09
IC4uLiAod29ya3MNCj4gYXMgZXhwZWN0ZWQpDQo+IA0KPiAjIHJkbWEgc3lzdGVtIHNldCBuZXRu
cyBleGNsdXNpdmUNCj4gIyBpcCBuZXRucyBhZGQgbmV0bnN0ZXN0DQo+ICMgaXAgbGluayBzZXQg
ZXRoMSBuZXRucyBuZXRuc3Rlc3QNCj4gIyByZG1hIGRldiBzZXQgbWx4NV8wIG5ldG5zIG5ldG5z
dGVzdA0KPiAjIG5zZW50ZXIgLS1uZXQ9L3Zhci9ydW4vbmV0bnMvbmV0bnN0ZXN0IC9iaW4vYmFz
aCAjIGlwIGxpbmsgc2V0IGV0aDEgdXAgIyBpcA0KPiBhZGRyIGFkZCAxOTIuMTY4LjQyLjEyLzI0
IGRldiBldGgxICh0ZXN0ZWQgaWJfc2VuZF9idyBoZXJlLCB3b3JrcyBwZXJmZWN0bHkpDQo+IA0K
PiAjIG52bWUgZGlzY292ZXIgLXQgcmRtYSAtYSAxOTIuMTY4LjQyLjExIC1zIDQ0MjAgRmFpbGVk
IHRvIHdyaXRlIHRvIC9kZXYvbnZtZS0NCj4gZmFicmljczogQ29ubmVjdGlvbiByZXNldCBieSBw
ZWVyIGZhaWxlZCB0byBhZGQgY29udHJvbGxlciwgZXJyb3IgVW5rbm93biBlcnJvcg0KPiAtMQ0K
PiANCj4gIyBkbWVzZyB8IHRhaWwgLTMNCj4gWyAgMjQwLjM2MTY0N10gbWx4NV9jb3JlIDAwMDA6
MDU6MDAuMCBldGgxOiBMaW5rIHVwIFsgIDI0MC4zNzE3NzJdIElQdjY6DQo+IEFERFJDT05GKE5F
VERFVl9DSEFOR0UpOiBldGgxOiBsaW5rIGJlY29tZXMgcmVhZHkgWyAgMjU5Ljk2NDU0Ml0gbnZt
ZQ0KPiBudm1lMDogcmRtYSBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQgZmFpbGVkICgtMTA0KQ0K
PiANCj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlPw0KPiANCj4gVGhhbmtzLA0KPiBNYXJr
DQo+IA0KPiANCj4gT24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgNzowNeKAr0FNIFBhcmF2IFBhbmRp
dCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiBGcm9tOiBN
YXJrIExlaHJlciA8bGVocmVyQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJp
bCAxMywgMjAyMyA5OjAxIEFNDQo+ID4gPg0KPiA+ID4gPiBEbyB5b3UgbWFrZSB0ZXN0cyBudm1l
ICsgbWx4NSArIG5ldCBucyBpbiB5b3VyIGhvc3Q/IENhbiBpdCB3b3JrPw0KPiA+ID4NCj4gPiA+
IFNvcnQgb2YsIGJ1dCBub3QgcmVhbGx5LiAgSW4gb3VyIGxhc3QgdGVzdCwgd2UgY29uZmlndXJl
ZCBhIHZpcnR1YWwNCj4gPiA+IGZ1bmN0aW9uIGFuZCBwdXQgaXQgaW4gdGhlIG5ldG5zIGNvbnRl
eHQsIGJ1dCBhbHNvIGNvbmZpZ3VyZWQgYQ0KPiA+ID4gcGh5c2ljYWwgZnVuY3Rpb24gb3V0c2lk
ZSB0aGUgbmV0bnMgY29udGV4dC4gIFRDUCBOVk1lIGNvbm5lY3Rpb25zIGFsd2F5cw0KPiB1c2Vk
IHRoZSBjb3JyZWN0IGludGVyZmFjZS4NCj4gPiA+DQo+ID4gRGlkbuKAmXQgZ2V0IGEgY2hhbmNl
IHRvIHJldmlldyB0aGUgdGhyZWFkIGRpc2N1c3Npb24uDQo+ID4gVGhlIHdheSB0byB1c2UgVkYg
aXM6DQo+ID4NCj4gPiAxLiByZG1hIHN5c3RlbSBpbiBleGNsdXNpdmUgbW9kZQ0KPiA+ICQgcmRt
YSBzeXN0ZW0gc2V0IG5ldG5zIGV4Y2x1c2l2ZQ0KPiA+DQo+ID4gMi4gTW92ZSBuZXRkZXZpY2Ug
b2YgdGhlIFZGIHRvIHRoZSBuZXQgbnMgJCBpcCBsaW5rIHNldCBbIERFViBdIG5ldG5zDQo+ID4g
TlNOQU1FDQo+ID4NCj4gPiAzLiBNb3ZlIFJETUEgZGV2aWNlIG9mIHRoZSBWRiB0byB0aGUgbmV0
IG5zICQgcmRtYSBkZXYgc2V0IFsgREVWIF0NCj4gPiBuZXRucyBOU05BTUUNCj4gPg0KPiA+IFlv
dSBhcmUgcHJvYmFibHkgbWlzc2luZyAjMSBhbmQgIzMgY29uZmlndXJhdGlvbi4NCj4gPiAjMSBz
aG91bGQgYmUgZG9uZSBiZWZvcmUgY3JlYXRpbmcgYW55IG5hbWVzcGFjZXMuDQo+ID4NCj4gPiBN
YW4gcGFnZXMgZm9yICMxIGFuZCAjMzoNCj4gPiBbYV0gaHR0cHM6Ly9tYW43Lm9yZy9saW51eC9t
YW4tcGFnZXMvbWFuOC9yZG1hLXN5c3RlbS44Lmh0bWwNCj4gPiBbYl0gaHR0cHM6Ly9tYW43Lm9y
Zy9saW51eC9tYW4tcGFnZXMvbWFuOC9yZG1hLWRldi44Lmh0bWwNCj4gPg0KPiA+ID4gSG93ZXZl
ciwgdGhlIFJvQ0V2MiBOVk1lIGNvbm5lY3Rpb24gYWx3YXlzIHVzZWQgdGhlIHBoeXNpY2FsDQo+
ID4gPiBmdW5jdGlvbiwgcmVnYXJkbGVzcyBvZiB0aGUgdXNlciBzcGFjZSBuZXRucyBjb250ZXh0
IG9mIHRoZSBudm1lLWNsaSBwcm9jZXNzLg0KPiA+ID4gV2hlbiB3ZSByYW4gImlwIGxpbmsgc2V0
IDxwaHlzaWNhbCBmdW5jdGlvbj4gZG93biIgdGhlIFJvQ0V2MiBOVk1lDQo+ID4gPiBjb25uZWN0
aW9ucyBzdG9wcGVkIHdvcmtpbmcsIGJ1dCBUQ1AgTlZNZSBjb25uZWN0aW9ucyB3ZXJlIGZpbmUu
DQo+ID4gPiBXZSdsbCBiZSBkb2luZyBtb3JlIHRlc3RzIHRvZGF5IHRvIG1ha2Ugc3VyZSB3ZSdy
ZSBub3QgZG9pbmcNCj4gPiA+IHNvbWV0aGluZyB3cm9uZy4NCj4gPiA+DQo+ID4gPiBUaGFua3Ms
DQo+ID4gPiBNYXJrDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gVGh1LCBB
cHIgMTMsIDIwMjMgYXQgNzoyMuKAr0FNIFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2
Pg0KPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4g5ZyoIDIwMjMvNC8xMyA1OjAx
LCBNYXJrIExlaHJlciDlhpnpgZM6DQo+ID4gPiA+ID4+IHRoZSBmYWJyaWNzIGRldmljZSBhbmQg
d3JpdGluZyB0aGUgaG9zdCBOUU4gZXRjLiAgSXMgdGhlcmUgYW4NCj4gPiA+ID4gPj4gZWFzeSB3
YXkgdG8gcHJvdmUgdGhhdCByZG1hX3Jlc29sdmVfYWRkciBpcyB3b3JraW5nIGZyb20gdXNlcmxh
bmQ/DQo+ID4gPiA+ID4gQWN0dWFsbHkgSSBtZWFudCAiaXMgdGhlcmUgYSB3YXkgdG8gcHJvdmUg
dGhhdCB0aGUga2VybmVsDQo+ID4gPiA+ID4gcmRtYV9yZXNvbHZlX2FkZHIoKSB3b3JrcyB3aXRo
IG5ldG5zPyINCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayByZG1hX3Jlc29sdmVfYWRkciBjYW4g
d29yayB3aXRoIG5ldG5zIGJlY2F1c2UgcmRtYSBvbiBtbHg1DQo+ID4gPiA+IGNhbiB3b3JrIHdl
bGwgd2l0aCBuZXRucy4NCj4gPiA+ID4NCj4gPiA+ID4gSSBkbyBub3QgZGVsdmUgaW50byB0aGUg
c291cmNlIGNvZGUuIEJ1dCBJTU8sIHRoaXMgZnVuY3Rpb24gc2hvdWxkDQo+ID4gPiA+IGJlIHVz
ZWQgaW4gcmRtYSBvbiBtbHg1Lg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXQgc2Vl
bXMgbGlrZSB0aGlzIGlzIHRoZSByZWFsIHByb2JsZW0uICBJZiB3ZSBydW4gY29tbWFuZHMgbGlr
ZQ0KPiA+ID4gPiA+IG52bWUgZGlzY292ZXIgJiBudm1lIGNvbm5lY3Qgd2l0aGluIHRoZSBuZXRu
cyBjb250ZXh0LCB0aGUNCj4gPiA+ID4gPiBzeXN0ZW0gd2lsbCB1c2UgdGhlIG5vbi1uZXRucyBJ
UCAmIFJETUEgc3RhY2tzIHRvIGNvbm5lY3QuICBBcw0KPiA+ID4gPiA+IGFuIGFzaWRlIC0gdGhp
cyBzZWVtcyBsaWtlIGl0IHdvdWxkIGJlIGEgbWFqb3Igc2VjdXJpdHkgaXNzdWUNCj4gPiA+ID4g
PiBmb3IgY29udGFpbmVyIHN5c3RlbXMsIGRvZXNuJ3QgaXQ/DQo+ID4gPiA+DQo+ID4gPiA+IERv
IHlvdSBtYWtlIHRlc3RzIG52bWUgKyBtbHg1ICsgbmV0IG5zIGluIHlvdXIgaG9zdD8gQ2FuIGl0
IHdvcms/DQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5rcw0KPiA+ID4gPg0KPiA+ID4gPiBaaHUgWWFu
anVuDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJJ2xsIGludmVzdGlnYXRlIHRvIHNl
ZSBpZiB0aGUgZmFicmljcyBtb2R1bGUgJiBudm1lLWNsaSBoYXZlIGENCj4gPiA+ID4gPiB3YXkg
dG8gc2V0IGFuZCB1c2UgdGhlIHByb3BlciBuZXRucyBjb250ZXh0Lg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+IE1hcmsNCg==
