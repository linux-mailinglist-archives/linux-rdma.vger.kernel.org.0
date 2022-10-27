Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A060EE7B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 05:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ0DWE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 23:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJ0DWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 23:22:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32884419B9
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 20:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hulK3VRVTZSHPva2mAdt8q0ibM9nh8A46xJXuG2SMRv6+IMPU/3nAoVr0zdra+qNNGuD/bBSy4FOSvTv9hvoWzTyUp+zER5BFytb2q6Ew4bao1kuAkg2IjHmkobIx7IysSJayfAyaTqe3jPOmGkYWWsHBCNd+OTEEv/LBEqmwkmqErPEy0hG93AGeD0vjDq+Jef2X+DG1ZkV0GSjnq5uO+3vtaKMRINFTokrB+Efo++rDnevA9KfxbwO5ZDTYvGyFB6SUW9gwj3RrnqrHPtWDIdmJu3VRZkdGrCMQSH8NE+sd2I2+NHB7q472XrlAxyc3UFmLKQnMESduolqvixwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZNl2Quv3jDp0dWGplDrH1FB6AlwxiFdljEQUW4IohU=;
 b=JUdg4tIxJCw6Gaqa2BgmZQmBp1C2fFKzo27UWpetAp140q9N4widKxiFLfoYjpLYTzupf+ilHqSpGXrINPTkKiv61d40s8kkKL/srcrDvhuRWgDZ9Xm57Ttm18V7kJfSqJjV6IS1cMigJmF1u8tUJFSSAi4SioMzvICWkOCcZrcufYkAriPK+l3ESumUevOfG9y3xiL59LL8Kdwxc2n0iNszq0TjDxaOlQJT0A5c6XHldxYhrDsPHoSBV1I3/OkGt3+FfJAFfbWaMba6N6oClAuwGhGqWskUns1nu0mmvjUf8GlY3P/ZYS1OrOYxHEd/XpXCJQ0cTqYRNcbDIQhP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZNl2Quv3jDp0dWGplDrH1FB6AlwxiFdljEQUW4IohU=;
 b=mAR8I9U0TmNvkVm6AGW30BiRneQugO50+nYNDjJsq3zwocoFofUMHLPOWxcorc1fiUkFcZuDJTrEGplu+uvDmvAyXfznIOMmc+WNFK7XHZErZcKW8/0dPxvqbXrk0ExdL1tnu3JQYsT+t8qcL0hKeTzK93j5zOFwMgxfP11rOu/+n2Sqe5kKLyIIkb4rx86rcJnPd/99/5kCFs1h9QZ/17Pqv0NwUD7ACroZxDOT6jV/PHeaoJm1a6YKcI5pAoFuO0tiMyf6P0V7Mn2yRdWuF8CcH5BXzw+6t0svz2xDnAq3yJ/VUnWexvCrY2jXJp19fIfQc/YuaxICGzbrTkYZWA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 03:21:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 03:21:58 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/3] RDMA net namespace
Thread-Topic: [PATCH 0/3] RDMA net namespace
Thread-Index: AQHY5qHU4bwCU56Yj0mBzA3dKbf6464gylCAgADAs4CAAAgm4IAAAiCAgAAAI1CAAAKNAIAAAC4A
Date:   Thu, 27 Oct 2022 03:21:58 +0000
Message-ID: <PH0PR12MB54819EFE62D489FD489A307DDC339@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB5481D39B0CD65746C9808046DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481F98B1941FA63985D13E0DC339@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <20221026150113.GG56517@linux.alibaba.com>
 <20221027023055.GH56517@linux.alibaba.com>
 <5314ed2c09c1336f5c21cf7c944937e4@linux.dev>
 <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
In-Reply-To: <e2e3bc30862d0f6b2fc8296624527e0c@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6815:EE_
x-ms-office365-filtering-correlation-id: bd99d77d-3f7c-4a36-ba55-08dab7ca6800
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+n8j5t+zE9tEwev3ZVdF1AL3/7EkR3ks9ptZoIgu3GLasWPV2GaMvPv5Z+Yk2J3VJsXFna1WzGqz/OA8CXAAeknmj7ZP/UxrxwSrusBqVKhh5n6SjKPj6dgpyAwhWpG3aPe9eNwn4vADZnCeMF7P91DvG0lQw1GjOtG1Xw4m/ZpZA+E0YyQS56NRhP0xfoXq0ThzYclPIwUKkppenrscHbEmTmNvCzsFA/M3PTF5/KrPiKpyKDcCBZkKj6ljSz1DzHCEoiN4R4CFEBspGYg9AESkJAobNBTn5jVhUrBTlKG6hpdhOK7GixI4/a0tB/lk7hY2Am3VFs1GTMm1ti9B8GPFHEi3p7NCYeHjIwzrOAPN5U2Si/AS7tMeE/fIc6UecUxCFgAbUsHYUsnCMpALnwlg984067Np/KoC1hjmWhqjgFsOfhXBcFTvwhgMYoFVHDhBYDIEZKNHab5NSFTguwQ3h6Qmzl/p4T1mLC/5vF0RPjd2M2IAWAZ27ga62m1yBkZJxu4aRE1X0n/CkbwneApZsrC2e1b+iD4aTVJPgRaJosTNNopwwLg7eP1l/ljpJtE6pacIJxpudBRxOYie9/MMUr+KZSUV1M+766vpMj1rZJsghDeMn00bB6MLueKVOE7D0f3t+aEbkqRF72eV7pMoMSJJVJDoZNBT8wsfUfd0L1IZfKyODjuKRirXikNniKBZDIcitvdBcuGWqzodzLIF9s4A2MvoE1I5cijYqfRuhmuRrfaI4jQPLQDAjJRATv5NDs9fnPLh2VenVJh+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(6506007)(9686003)(186003)(7696005)(26005)(478600001)(2906002)(55016003)(66556008)(110136005)(8676002)(316002)(66476007)(66946007)(8936002)(66446008)(52536014)(5660300002)(64756008)(41300700001)(76116006)(71200400001)(33656002)(86362001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHR6S2NJU3cvWjdCbjh5OUNXK1BKSFExQ2VJNzkvWVNIbUFrYm90V1VoUHBQ?=
 =?utf-8?B?WFB6REZEbUtiUDIrSHJkcmxnaElyRXh1VjNDeFlJSkpxQlV1WHQzN2hYZWlp?=
 =?utf-8?B?K0pMS1FCT1Z1Q0oydjVSeFVTK1lUTkdBZS9JUGZVQUhSZUJkTFd5OC9HNWVH?=
 =?utf-8?B?MG5FcE94a2d4NjZmVDVGTGs1K2loUXVZY3ZvZzJFcEhscXlPNU1DeHBZSXUw?=
 =?utf-8?B?aWtjMjl6c3orNUZCVDJLbWxEeEJ3ZFRwNHpEUndIeDNCU3VxZFZNV3A0eWo4?=
 =?utf-8?B?VCsvSnFjVURTYzVjeE5PazVadU0rcHRNTEVqdk93RkhaeDZyblJLcHRwUUMv?=
 =?utf-8?B?MXUyT3p4TlZMMnd4NFhzWHRVaVZqM2JHQUNmWlpsNFdzNlQzNEhUb05hWFBC?=
 =?utf-8?B?VGpObzM4alZoYy8rMWRFQzZlTzQwdEpWNmRXRGZuZTVnT0dSTTZGUXJibjk4?=
 =?utf-8?B?QjZjZTVHbDErU1RHenN6MDlDTmg2YjN5WHRUL3hldGtyRXNEOFZQVnBMUFJP?=
 =?utf-8?B?YytrSTlaTFhBRjB3NUJ4dTZaRmViZHNzWXFYNFNpUmp1RnJTVWkyVjBIUkVY?=
 =?utf-8?B?V0E3SkowRXBpaU9meUlVbXNGcVR3R1cyckFiS3cra1ZjbkpINDd1WjBPTmdP?=
 =?utf-8?B?Ykp0RXlBbjd0QjRrV3RxZER3eWwvdHk0N3JzMHdJWW92ZjNxSTVONUlqQlJ4?=
 =?utf-8?B?bkJla3hTS0paRzFlN1JDSlFQZGdLWExkSnhTaUkzNzhENDYvY3ZESzc0OHNO?=
 =?utf-8?B?TExlOE42b3VUQzF5VXhkQWtNZ3RVcmFONFpubU5EWlJyeml0eDRoOTJhY3hn?=
 =?utf-8?B?SUdjd0ZCbVA2UTVBcCs4VWV3RUFXNXFaSFQrVUw2eUJaZDhFRGp6S0ltaG9V?=
 =?utf-8?B?VDMxVXJZVWlGNGVvdDdRdU9xZEx2dy9QcEE0R2ZycVdYbnBjRDJaWnpsTk54?=
 =?utf-8?B?TE03REdSR1lGQWlIQUpMUVB3ZzhZdFNEQ3F3cXRPUnZmS3I0OW9wZDlQcGRC?=
 =?utf-8?B?Ly9mYlJLalJCN09oSUxEMzBaeXNHL2srNUd3U0x3UUNsL0RaRDUrM01ub0lT?=
 =?utf-8?B?SElQbzBSaW9qVm8vQTZ5WFc5OWg0MEtwbks3emg0a2QxaHFSbCtaR011VG8z?=
 =?utf-8?B?eVJIelJ5ZFVnQ1JPSkdMbWNoUzJJQTh1TzdRM3VocTh2eWVXMkxDa3Npbitv?=
 =?utf-8?B?OVg0Z2p6WW9nYW1rRkx2Wi9GNnFocFp2SUU4eElzREpUL21IVjhiSFRjNlZS?=
 =?utf-8?B?N1V6QVpTYmo2RlA5dG9va2VBWHNBaUVUM3JlR0pRVUlQd2ZjeS9US21NVjVC?=
 =?utf-8?B?Vm9oU2tzL1RLM0dvNVQ2S3FMQkV2RUo5WXlRaFRkTU8rU1BoQjltclhoc2dF?=
 =?utf-8?B?Y2lwS0F5dXc3bTF2VEY3WWJ4Vm1jN2RXU2x5ODJvUUV2YzVUWmhRVlhRa3VK?=
 =?utf-8?B?NVE5MmJHV3FwaW0wZTZQL1VhM3NQYXg3YkFuRjZhUlNWUGRvZHc4aXV5aURs?=
 =?utf-8?B?SEhVenVqeEhla0ZhSWZMa2Nmc1UxQjdzRjcxVGNFcXdiWXYzN0o0c05Dcmpq?=
 =?utf-8?B?Yi90Y2VaSHZHYWdabXZ4c04yaS8yLzNVRUYzK2JhSDg1bk1OU2FTTW5XTzZB?=
 =?utf-8?B?a3UxenJ3ckVwdWNjdVNicDVkYzdkalJ5UTA3TTBkcVd2dmhIUzBqam51ejZM?=
 =?utf-8?B?OHo0V3dFWlZYMTFna1dpeFJ3WG5uVWF3d1R5aUdlc21FUWxYb2ZrQmd0MTVR?=
 =?utf-8?B?VlkxaDQ2Qk9neHpnTkNkWXJiYzNRSFg2NGNmUFJYdE94VlZjZWoxbmZaUlRN?=
 =?utf-8?B?NXEvYnRxa2t2bUswdGp3MzFoUWp3aW9Ka0JHUmUvN05rRVVIVXBwTzBaYlFp?=
 =?utf-8?B?TjcxM0ZRQ05sR1BpTjVtdHdrM0NlRTlzbUVUWlVtYmVaOWJ4TGxTS21YZzA5?=
 =?utf-8?B?V09nSmpNOHFkUU5GVzQ0V0pEZ0dNZHdjZTF0YnJvYUdKRWFHbEFOQ1ErOWpx?=
 =?utf-8?B?R2o0Z0NUZ3llOG40U3YweTdsSTBJYnFnZCtranJUTlZ0RWRybm1Od3ZWZVNL?=
 =?utf-8?B?NFNib3orTURqenkxakdHK0dseW5UT0VUL01ueDdLVmRXemVmRVoxeUk2OFJo?=
 =?utf-8?Q?/Fm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd99d77d-3f7c-4a36-ba55-08dab7ca6800
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 03:21:58.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7MsFqaG0OgCj+M1Jgfj0WyEjZDWAwwyN7XUP1XJf2jkghu5jYIFYIs+Uq4DECI4v/ipdajmzTpl7SoBdv/RPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiB5YW5qdW4uemh1QGxpbnV4LmRldiA8eWFuanVuLnpodUBsaW51eC5kZXY+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNiwgMjAyMiAxMToxNyBQTQ0KPiANCj4gT2N0b2JlciAy
NywgMjAyMiAxMToxMCBBTSwgIlBhcmF2IFBhbmRpdCIgPHBhcmF2QG52aWRpYS5jb20+IHdyb3Rl
Og0KPiANCj4gPj4gRnJvbTogeWFuanVuLnpodUBsaW51eC5kZXYgPHlhbmp1bi56aHVAbGludXgu
ZGV2Pg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjYsIDIwMjIgMTE6MDggUE0NCj4g
Pj4NCj4gPj4gT2N0b2JlciAyNywgMjAyMiAxMTowMSBBTSwgIlBhcmF2IFBhbmRpdCIgPHBhcmF2
QG52aWRpYS5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBGcm9tOiBEdXN0IExpIDxkdXN0LmxpQGxp
bnV4LmFsaWJhYmEuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjYsIDIwMjIg
MTA6MzEgUE0NCj4gPj4NCj4gPj4gMi4gZWxzZSB3ZSBhcmUgaW4NCj4gPj4gZXhjbHVzaXZlIG1v
ZGUuIFdoZW4gdGhlIGNvcnJlc3BvbmRpbmcgbmV0ZGV2aWNlIG9mIHRoZSBSb0NFIG9yIGlXYXJw
DQo+ID4+IGRldmljZSBpcyBtb3ZlZCBmcm9tIG9uZSBuZXQgbmFtZXNwYWNlIHRvIGFub3RoZXIs
IHdlIG1vdmUgdGhlIFJETUENCj4gPj4gZGV2aWNlIGludG8gdGhhdCBuZXQgbmFtZXNwYWNlDQo+
ID4+DQo+ID4+IFdoYXQgZG8geW91IHRoaW5rID8NCj4gPj4NCj4gPj4gTm8uIG9uZSBkZXZpY2Ug
aXMgbm90IHN1cHBvc2VkIHRvIG1vdmUgb3RoZXIgZGV2aWNlcy4NCj4gPj4gRXZlcnkgZGV2aWNl
IGlzIGluZGVwZW5kZW50IHRoYXQgc2hvdWxkIGJlIG1vdmVkIGJ5IGV4cGxpY2l0IGNvbW1hbmQu
DQo+ID4+DQo+ID4+IENhbiB5b3Ugc2hvdyB1cyB3aGVyZSB3ZSBjYW4gZmluZCB0aGlzIHJ1bGUg
IkV2ZXJ5IGRldmljZSBpcw0KPiA+PiBpbmRlcGVuZGVudCB0aGF0IHNob3VsZCBiZSBtb3ZlZCBi
eSBleHBsaWNpdCBjb21tYW5kLiI/DQo+ID4+DQo+ID4+IEFsc28gY2hhbmdlcyBsaWtlIGFib3Zl
IGJyZWFrcyB0aGUgZXhpc3Rpbmcgb3JjaGVzdHJhdGlvbiwgaXQgbm8tZ28uDQo+ID4+DQo+ID4+
IEluIGEgUm9DRSBkZXZpY2UsIGliIGRldmljZSBpcyByZWxhdGVkIHdpdGggdGhlIG5ldCBkZXZp
Y2UuIFdoZW4gYQ0KPiA+PiBuZXQgZGV2aWNlIGlzIG1vdmVkIHRvIGEgbmV3IG5ldCBuYW1lc3Bh
Y2UsIGlmIHRoZSBpYiBkZXZpY2UgaXMgbm90DQo+ID4+IGluIHRoZSBzYW1lIG5ldCBkZXZpY2Us
IGhvdyB0byBtYWtlIGliIGRldmljZSB3b3JrPw0KPiA+DQo+ID4gUkRNQSBkZXZpY2Ugc2hvdWxk
IGFsc28gYmUgbW92ZWQgdG8gdGhlIHNhbWUgbmV0IG5hbWVzcGFjZSBhcyB0aGF0IG9mDQo+IG5l
dGRldi4NCj4gDQo+IHN1cmUuIEkga25vdyB0aGUgZm9sbG93aW5nIGNvbW1hbmRzLg0KPiANCj4g
SW4gbXkgY29tbWl0cywgdGhlIHByb2Nlc3Mgb2YgbW92aW5nIElCIGRldmljZXMgdG8gdGhlIHNh
bWUgbmV0IG5hbWVzcGFjZQ0KPiB3aXRoIG5ldCBkZXZpY2VzIGlzIGF1dG9tYXRpY2FsbHkgZmlu
aXNoZWQuDQo+IA0KPiBJcyBpdCBPSz8NCj4gDQpOby4gDQpDaGFuZ2UgbGlrZSB0aGlzIGJyZWFr
cyB0aGUgdXNlciBzcGFjZSB3aG8gZXhwZWN0IHRvIG1vdmUgdGhlIHJkbWEgZGV2aWNlIHRvIHRo
ZSBuZXQgbmFtZXNwYWNlIGV4cGxpY2l0bHkuDQpJdCB3b250IGZpbmQgdGhlIGRldmljZSB3aGlj
aCBnb3QgbW92ZWQgYXMgcGFydCBvZiBzb21lIG90aGVyIGRldmljZSBtb3ZlbWVudC4NCkN1cnJl
bnRseSBkZWZpbmUgc2NoZW1lIGNvdmVycyBhdCBsZWFzdCAzIGRpZmZlcmVudCB0eXBlcyBvZiBS
RE1BIGRldmljZXMuDQoxLiBJQiBhbmQgSVBvSUINCjIuIFJvQ0UNCjMuIGlXYXJwDQoNCkVhY2gg
aGFzIHNvbWV3aGF0IGRpZmZlcmVudCByZWxhdGlvbiB0byB0aGVpciBuZXQgZGV2aWNlLg0K
