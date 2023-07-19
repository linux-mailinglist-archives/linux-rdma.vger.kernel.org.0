Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB987591B7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGSJdN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGSJdB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 05:33:01 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73259186
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jul 2023 02:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCpYZDFRQHgsjHJU98APYPeKG/fMdR4u3kuOkwrYfXsoJCIC+U7efqnmpzRFYMqXJ8TvZC88VLIyLtRw2pEbyBdT0SBPaV/q5wyqYKh+D5uWfJFeIK/PpCxCMC9vqSxzGoUIbMcK8uwF4bUlBz0QPhlJAEOv4sCOlj2umC8PQWIF5g8QpZF7Ixl0S0R8sLfN1vU2PoQXlvSNdrgEukmuiqByUN2/1Rw+Kojen3QlORQXZJklmxEEflQwPMvstCmjXi10Hdrn6eYcs8RopJ4DgbHxB9tniA17+Vpw/XiOtFVuZOC9+KfLwVcMw+Sea0/Il1e933fU0n0gGjppdI8/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKcjJ+ehoCAs4hhhDvU77NHRAdqESJYA71Lz2b+hF48=;
 b=Dn/jbctwNcshrgR2zF7k5ajxBYApjuUM8YPJIFIs/MVmk2e4PB8wBA2XwRCdoQMj26e0NGqZOgUk+xN3agK+WlZkgQqXOLYqDQ+QgHuqcC66DwTErJhEj14ZbOhCYPBEIKoIoKrng2OYvBP83RKGe87RtVySVOo3W+XjtfI5yP27p9f8be97O4qXCwMM49VFr+w+QFeW7v/M8bi7dw7y2ED0KP9R1bQQgzl3+R5pNzNCBER/i4fxMfcktr3NooicqutzWehk+wgSA+4kLAMXu81hqS3VHKq60MQKMb7cQSbRtba6bKeVEOZdT4Rph/FnQ5wRv5pD1CzJZOGDFojrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKcjJ+ehoCAs4hhhDvU77NHRAdqESJYA71Lz2b+hF48=;
 b=upkB1JlGsC/RYqmUQj75XTmLp+H2j9PiMSpF/JVVw6SRYQ+vNyZ6lZL6c7685XDOMuwhL/hVKzN/gbQJKpwJ6x69atV6VDgfUyAhLv8n3ARbXhUxbQsYhlTVU8wyvpdUnaOKBUeYGCfgErbo7tw81+GOlw906lHfkgOwsmRgvrMxu2GWHegvNUdH/vWn/PcIPqFTTib9Q/jUIydq14dusTB1RgvBJeSIMWckwrAMmJjmVStdwjvQElaTNS/pdg2bHcecSEBm9jX2ZaO6HACab/m9PGmBGP3JFXJqQCjuCLRTpkgd6IJwWhNTeUMJqIOZ+ivS+VM9TYrpJJdBP02TAA==
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 09:30:54 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::b699:8c3f:cc39:ee6d]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::b699:8c3f:cc39:ee6d%4]) with mapi id 15.20.6609.022; Wed, 19 Jul 2023
 09:30:54 +0000
From:   Mark Zhang <markzhang@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Shetu Ayalew <shetu@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Add HW counter called rx_dct_connect
Thread-Topic: [PATCH rdma-next] IB/mlx5: Add HW counter called rx_dct_connect
Thread-Index: Adm6I7a+zDEJVriKi0uodCB4HURgBg==
Date:   Wed, 19 Jul 2023 09:30:53 +0000
Message-ID: <555e4ba0-410a-b9b5-eee8-dfacebae38e7@nvidia.com>
References: <6d2313eedc567fc29f5ba53c197d5678962bb43a.1689757404.git.leon@kernel.org>
In-Reply-To: <6d2313eedc567fc29f5ba53c197d5678962bb43a.1689757404.git.leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7495:EE_|SA1PR12MB7342:EE_
x-ms-office365-filtering-correlation-id: 2cd44ff4-8aac-43b5-df64-08db883ad93c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uU23dudb1JnaSiqtCEiNYVO9NXx8gI/rKagZzPVK7b+rQ69Ur8xJsrFUYAAJS+xh7RXFl5yCBRu0qaJteKvh0sw2r056c8Mg7dpVxzbv77RR3269O/JuOCGJw/biWnTE3DoH5rLD3MnQgfXcEog124ysHLN6wbU56RM2jQ5Z08PC6AlNWUJV6RJgblDf5HJ11nnuSbzCjonBI7KrpOyo1HeSIwN2TiiGXBVW9Z/gdPOs4sejIKL59aLZn/SIcor0xvVZA+AitRuaz5c5X3nQMWlajH7CaztC4/ZSCYx4J4FaSmZVJH1TuYPwk6mSfDI4zj9wVuDqrKvJjfbspoalygQmk7hYOWQivEyIBmxzrgNWEOrHuTZiXZXI1MURtDxcwJNBQ7JC50R4DGuhypBuV+AozYTNkgU0jocgYjbY3Xe7vjkkxVTroXAHGI4HlNRWriK3R10X6Ve654gQceDV5gZXATLC6bPW5F57pZlRntHaSQ881eDMUW+N12qzCmDWTHywFGX6x75TY5zj+Y9fdTJ7Rw3wLpkt7nt120OKlVIuF9jzugTjBv1yYlw23OQiXkqo3bTV+tgg6tUqExRBiXsk/FIvHVtXFazCakTsqmeu3Jqs1jYLLAPxYdVH4Tspv0AufPPWiUWC48RPLE3VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(31686004)(4326008)(6486002)(54906003)(71200400001)(478600001)(110136005)(2616005)(83380400001)(86362001)(31696002)(2906002)(6506007)(186003)(6512007)(53546011)(107886003)(26005)(316002)(38100700002)(122000001)(66476007)(64756008)(6636002)(41300700001)(66556008)(66946007)(66446008)(36756003)(8676002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVhHQXBDc3FrNnlEbk5iNitMRC9rTjZTaFFieWplVDFKOWE3a3VDTVZ1YVRq?=
 =?utf-8?B?UkUraXB5VG5UUy9wWTM2dCsvaTRqbnloWUs0YzRDQ1Q5V3RKcGtvOWlHU2x3?=
 =?utf-8?B?emRqQjRzcXRhTXh1Q1N2cjhJd1VYVE1vaGFucDkyd01GZjFtbU4vMzJ0RFdR?=
 =?utf-8?B?OFl3d1ZxQXpjYkZQUkxabCtlREd2VzZvQ0tEd3UrOHllc2F0TE0zTTF5M1p5?=
 =?utf-8?B?cndvVUMrUkRvZ2NnY1FWODhONldBZHQxeXNNenhsZGNPdFpPQTl2eG1MMXFu?=
 =?utf-8?B?WTd4Wk5BaVQ5a0tHSnRsWU44VCtBZlpEekw3U3loT25QTFFpMTRWQ0RZZkJu?=
 =?utf-8?B?c2JadlFrZW5vYU9jOEJYdElFMHNQRER0Z1VIaGVHZy9haVlTQ3hhWWx2cUZB?=
 =?utf-8?B?a08zQW5wZ3hMZjdTOVpPYUpRVEtOUE16bFBrZmE0VnBhRFhORHRGSnpFMDJE?=
 =?utf-8?B?S1JEb21xak9jZ3hWUHg0VnNmVE1teDNSV0dtK2U2NHNtTDRMWGRSNW5rV1dq?=
 =?utf-8?B?Y3VWYWRPcnZZQnBnQ3VaK1FIMUY4VTBwVHBiODN0eFJGVUw0bEJtWkVrQ0hp?=
 =?utf-8?B?eUlzTTVRU2M1SkxPaTJGM3dUK2QzQVgzdCtYL1c3MEhsMzk3YmE5bWVyTTRa?=
 =?utf-8?B?R29pd1dNeXNNT2F0aHZOUGtsMVpTaE9GMlZVMmhlcEhuS2o4VmExZTBKWlFv?=
 =?utf-8?B?T3VEcURIOERhc2RVM0c3dE9tcEZqU2w5ZFlMUDAxT2VCOEZOREM5aExrZEJB?=
 =?utf-8?B?QmFGMW9SbTB5QjVtaHFxeExNeFkvOXY1dVhJdGl4WXV4Nkx0SnBGOE5tTU1O?=
 =?utf-8?B?NWpPS3grTjZvYTJwejBXM1ZhU2lxNk5oZjNjOUdXUDEyVXA1c2R5d2dpeVdt?=
 =?utf-8?B?WUxpZWZndm10NnBxNEovTlVqUFZucStmZDFBRTI1Z3BnSklCTmVWSjdDcGlC?=
 =?utf-8?B?VVlSWTYwdlE3akNQaFdMM2dFZklnMWd6ai9IUFg5L0V0NThCWkhJUm9ZS000?=
 =?utf-8?B?NmQwNE1TdkIzZHQxM3hwdldFSmhmSy9UOWJkcDZRVHFXYldjVER4VkRtdExH?=
 =?utf-8?B?bU0vc3JqYUhQOXdKai9oNFFka0piTmo1S0pSWitac3lMckdjZjloNWM0bGFE?=
 =?utf-8?B?bnVOV2FUM2doQnh2VmRBNmVDVElEY0hObjg0VzZFZmc2NGM0QldIZ2p4ZDZP?=
 =?utf-8?B?aFlvSFY3U2ptbjZNV1FtU2xlNzlhWHlSUy8wT3ViRVRjbEZ6UU1PbDBqbnVK?=
 =?utf-8?B?WjZ1eks0Nm1NVFZld1hrMjlQVy85ak5IM0hOOUFpQkY5Q1pYTVNJTUNVN2Vu?=
 =?utf-8?B?YVM0VFh1NFlld3hqZWROQXlFUWtQZFFiWlBJK2F1QjYza3dQRmJ2L3FkLzU1?=
 =?utf-8?B?ajFrZThiSmNTMVRBVUorOVFmZm5TNStvMExCd01RSHFHUHY4bXh5R1QvWnZL?=
 =?utf-8?B?N1N4bVFzTG81eTl3OXdySlFlaFErQnJ4aFpwbHhnQm9YUlZyRkcyOWtsRWtJ?=
 =?utf-8?B?QVZsc21uaWtCSTRpUElIdFppU2Rwd3hHdUxBaHJ1Ti9qWCswMDdJa1ZQQ0lQ?=
 =?utf-8?B?a2tnSzZ4a3o2Y1RiSEhnKzZuVkJJNDVJaC81UndVMmU5WTA1SitJbFJFWDFk?=
 =?utf-8?B?VTF2djJEUjZCS1lNSHVtTExYLzAzNjhQRjNoNEcwS3lVQWdEM0kwd3JQdzdE?=
 =?utf-8?B?NHdLRVppSXByam9md1FoOVJkSlN5NDVoZ0J1WnZZMGJKa0hoL2JtQ285N09X?=
 =?utf-8?B?ejFkTitoODJscGxIelVjRTVXWk5reTQ1ZU1UR1FOQmtraEFzVzFiWmZyQ0FX?=
 =?utf-8?B?cXRWLy9vdU9teUkvUnB2QXR0bmJHMTZkVlRKQi9CWStOL2JUSkVLcVVCbGNs?=
 =?utf-8?B?NzhEcVowc1Z0Tkh2N3ZSME5BVS9VdkxuZ3J4NzlCTmE1b3J0UmMrYndLUzgx?=
 =?utf-8?B?S3hWSm4vd1BUTHZMYWdBMU5pNllHSWhaY3Jqb3J2VXhUOE0wUzZLYkI3cG5P?=
 =?utf-8?B?bjJnR2tMNXNCd3BoSFhDdzNmdTd2U2ZacUdZV1puS2poNUlQcmYyYnlXUnhz?=
 =?utf-8?B?Rkc0VnJ4czUvT245cEhUenMrM0RGL2piYzRpUzZPV04wV0ZLdWNDdUVyaDJK?=
 =?utf-8?Q?T1NJisNdxJos3gvXRGLDUpJDR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6777F5CF950DE942B4D1A93AACD3F2F1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd44ff4-8aac-43b5-df64-08db883ad93c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 09:30:53.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu/b4gykHZtjgG/RkV4k/XXMoK5qNjPEIBf8QrFSgVBMpOcj4mb5t7G7+0A3oQWzfJe1AIQKRtVFY9t04DIwPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNy8xOS8yMDIzIDU6MDMgUE0sIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBGcm9tOiBTaGV0dSBBeWFsZXcgPHNoZXR1QG52aWRpYS5jb20+DQo+IA0KPiBUaGUgcnhfZGN0
X2Nvbm5lY3QgY291bnRlciBzaG93cyB0aGUgbnVtYmVyIG9mIHJlY2VpdmVkIGNvbm5lY3Rpb24N
Cj4gcmVxdWVzdHMgZm9yIHRoZSBhc3NvY2lhdGVkIERDVHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTaGV0dSBBeWFsZXcgPHNoZXR1QG52aWRpYS5jb20+DQo+IFJldmlld2VkLWJ5OiBNYW9yIEdv
dHRsaWViIDxtYW9yZ0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFJvbWFub3Zz
a3kgPGxlb25yb0BudmlkaWEuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvaHcv
bWx4NS9jb3VudGVycy5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvY291bnRlcnMu
YyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L2NvdW50ZXJzLmMNCj4gaW5kZXggOTMyNTdm
YTVhYWU4Li4xNGFmNmZmOTFkZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy9tbHg1L2NvdW50ZXJzLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvY291
bnRlcnMuYw0KPiBAQCAtNDAsNiArNDAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1seDVfaWJf
Y291bnRlciByZXRyYW5zX3FfY250c1tdID0gew0KPiAgICAgICAgICBJTklUX1FfQ09VTlRFUihw
YWNrZXRfc2VxX2VyciksDQo+ICAgICAgICAgIElOSVRfUV9DT1VOVEVSKGltcGxpZWRfbmFrX3Nl
cV9lcnIpLA0KPiAgICAgICAgICBJTklUX1FfQ09VTlRFUihsb2NhbF9hY2tfdGltZW91dF9lcnIp
LA0KPiArICAgICAgIElOSVRfUV9DT1VOVEVSKHJ4X2RjdF9jb25uZWN0KSwNCj4gICB9Ow0KPiAN
Cj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG1seDVfaWJfY291bnRlciB2cG9ydF9iYXNpY19xX2Nu
dHNbXSA9IHsNCj4gLS0NCj4gMi40MS4wDQo+IA0KDQpKdXN0IGN1cmlvdXMgd2h5IGl0J3MgaW4g
cmV0cmFuc19xX2NudHNbXSwgaW5zdGVhZCBvZiBiYXNpY19xX2NudHNbXToNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L2NvdW50ZXJzLmMgDQpiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tbHg1L2NvdW50ZXJzLmMNCmluZGV4IDkzMjU3ZmE1YWFlOC4uODMwMGNlNjIy
ODM1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvY291bnRlcnMuYw0K
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvY291bnRlcnMuYw0KQEAgLTI3LDYgKzI3
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtbHg1X2liX2NvdW50ZXIgYmFzaWNfcV9jbnRzW10g
PSB7DQogICAgICAgICBJTklUX1FfQ09VTlRFUihyeF93cml0ZV9yZXF1ZXN0cyksDQogICAgICAg
ICBJTklUX1FfQ09VTlRFUihyeF9yZWFkX3JlcXVlc3RzKSwNCiAgICAgICAgIElOSVRfUV9DT1VO
VEVSKHJ4X2F0b21pY19yZXF1ZXN0cyksDQorICAgICAgIElOSVRfUV9DT1VOVEVSKHJ4X2RjdF9j
b25uZWN0KSwNCiAgICAgICAgIElOSVRfUV9DT1VOVEVSKG91dF9vZl9idWZmZXIpLA0KICB9Ow0K
DQpAQCAtNDYsNiArNDcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1seDVfaWJfY291bnRlciAN
CnZwb3J0X2Jhc2ljX3FfY250c1tdID0gew0KICAgICAgICAgSU5JVF9WUE9SVF9RX0NPVU5URVIo
cnhfd3JpdGVfcmVxdWVzdHMpLA0KICAgICAgICAgSU5JVF9WUE9SVF9RX0NPVU5URVIocnhfcmVh
ZF9yZXF1ZXN0cyksDQogICAgICAgICBJTklUX1ZQT1JUX1FfQ09VTlRFUihyeF9hdG9taWNfcmVx
dWVzdHMpLA0KKyAgICAgICBJTklUX1ZQT1JUX1FfQ09VTlRFUihyeF9kY3RfY29ubmVjdCksDQog
ICAgICAgICBJTklUX1ZQT1JUX1FfQ09VTlRFUihvdXRfb2ZfYnVmZmVyKSwNCiAgfTsNCg==
