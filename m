Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBC4348E2
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTK3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 06:29:23 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:49889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229639AbhJTK3X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 06:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgwT7VKMjROsheI3Y18o6Paskku5EzeOt/F9YfwKo1sIFm8Vwoq9GszY8ORVh1aMkjOeUe7/sD7Hq1fCKcmoCnl82NmbbAKST0zmxgPmU6VCWgurutSZ/TG5bPCgxRZl7wF9O3fkgkLRzIwbLp7P9B6hkV2KVM52poUnqsme0854DC45COtMJmJbSaD6J3HFi4fGfSIAqOBu8oq2helmMSDj8RASlyW7kq+To9XLf7aqMYQabfN8I09MMagKiVs+1FwayvQFW53A5fRh0q+F7mEmh758urk/WBPRIZ1Gr426JTpDJFDgCXtZlh5xOkVgI7pB8DKBgyQhfVTP3vc69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNdipdyNIETwu51R5ERTKt4Snn2TntXPyPuV2OMD9gA=;
 b=TmBv4tcaV4DfMAK8b9DBav7Aox+MQ0UzeAKoZ0ZTM9TJ8ETsQLRIzHWCgbj5UatJ1MIPWVC418YX5izxVWQZgJU/JaV3zOFZ09j+6lvmpnV7eH1VamcUoY29mVuhcZgAW+0/A2bk98OzQoyA07YgLVDpLyh2kvuWNBFT2W5dFt7y2tYDeawsErINnTODBdNjoIGMDpd6SVx9JQGpmFcvx7Kr1ODzl1m+9guvV2oF2Zwzew2oZDy25fhIaVpwybgVIQq1nECQlNszg2GjkyQHOgPv3mGWvc7QzbXiwk7AtaghAva2zEBTf5Edj8ERAhVX2B75pxoB70ZkQ4S3l9vMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNdipdyNIETwu51R5ERTKt4Snn2TntXPyPuV2OMD9gA=;
 b=a45RPomAVDpmiqB6L8ZcLyx5zv8jWgliPlSCiCSrreSUJ0Xo90Am43B4eLtMukf2TQLcwe8n/Q1AMf6Rz8sX9a7BvwkC7hb0zngMZv8qTN0hxFOU5d1NoWS/FFcTnLsivV5PqpXuKchF5csf/OwVYtDCMJ/iLxjwX4+GVLSAXBN4sv/G7O/z7YNwxkCCnxBQkZPwRThR8qPfaWlhlqwKvS2W3MPzd4is4dJLQjitjqXNiqPyf/gpdzC4wt2fzm59Pfov2l0322w00J/Pfttw9XrpuMNUZ1IxeL/C8S/iljAkdbMBNP0yv63yNPfkGWT5pI9jY3HJ2GcQGfgfsqtodw==
Received: from DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 10:27:08 +0000
Received: from DM4PR12MB5216.namprd12.prod.outlook.com
 ([fe80::c84a:e839:6831:515e]) by DM4PR12MB5216.namprd12.prod.outlook.com
 ([fe80::c84a:e839:6831:515e%9]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 10:27:08 +0000
From:   Edward Srouji <edwards@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: 10 more python test cases for rxe
Thread-Topic: 10 more python test cases for rxe
Thread-Index: AQHXwECy+hgtVjP9yUGD+JPjhAYwlqvRBbGAgAFqGACACUjswA==
Date:   Wed, 20 Oct 2021 10:27:08 +0000
Message-ID: <DM4PR12MB5216785DF4827AF953E2AC04DABE9@DM4PR12MB5216.namprd12.prod.outlook.com>
References: <34a9a53f-1f1f-bddb-0c8e-63ec5fbcd28e@gmail.com>
 <20211013150045.GG2744544@nvidia.com>
 <CAD=hENcvfUbbhJ_fZ58A7KeyY74mGP2v4Q7D84nCnwJnBVmzBQ@mail.gmail.com>
In-Reply-To: <CAD=hENcvfUbbhJ_fZ58A7KeyY74mGP2v4Q7D84nCnwJnBVmzBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 998131f1-fbd3-4f2c-67c0-08d993b42b80
x-ms-traffictypediagnostic: DM4PR12MB5357:
x-microsoft-antispam-prvs: <DM4PR12MB53576EF33C6EA7C746C2E9C0DABE9@DM4PR12MB5357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFvMZ6SXnKYuKZ6wurC9s03Rh0cNyeq4yPCmKOGs5NBPUoXO1Zd3liILl7imZSx9A3GPZorT2tDRZ3G6PvHzQS+DjSUEDrXEDXu5I87Nhk3cdF1dwDCAaSiX6CfXoYBZahlFe7Rl6HLusOHLsdBBQGFb98uTJzGaGOZ6r6FFOt5BaM9I4IneP1zLtNLClgKFKPazRs3a0wi9cqEj3ZSL/WWr7PPFVRxcYIadjoE/LhZ2h6g3XbpG9LFddJNgdezH7I51dGITEn3yJOWFeh5yRmaZ0CBePK6d6xXFyoI2aO/MnMVkNUOR0mXow0Q4GrYndVi3XxJKvw6nmvO6nBADEjYklJXq8vv+JJYLPSEekd8jzPu477onJHniZBvwd7hP+Yg/vabYmkjqXEbnlF5XLFXTm6zDo1hqsspvHTpz9GigbQfkE6EYoXqTHYg3pobK7SoD1ttgo4bucwbSqDUgcJyAaFze7PBfaFNdK/gG3wAc/OgQu/kaqBaORFHnJmNyI4pGgtp71jhCk6Av1U3O9iLHCNWUPeorgPAuAjlWMgEgM5PMQ/ctpck9vO9REcCy4m8erjJGU/DlGwc3Mx+zTOvdd7nNtYv+zIGXiQ23C2iOB1vZGPZsTZmyS6532TB36hwCHbXoPeJru1GU51yeqdWjU2UYyU7xMdTDS7z4oG2nI4q3OojJJo1bZSvctM7IC3EkWeMyaEdPOQowaV7PiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5216.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(2906002)(86362001)(508600001)(66476007)(6636002)(55016002)(4326008)(26005)(52536014)(38070700005)(83380400001)(66446008)(66556008)(64756008)(71200400001)(66946007)(38100700002)(110136005)(54906003)(8936002)(7696005)(53546011)(6506007)(316002)(33656002)(76116006)(122000001)(186003)(8676002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cURtTXdzWWhlYUN1d2VYL1daOXhJQy93UGxRZlFFNnBKSUZoOVVUcXRsalZw?=
 =?utf-8?B?RmZqeGpYSmdoeUprMEc5OXdDQjZxM0lkNDdGYVpvRTZxY0E4WEVLS2c1SnBt?=
 =?utf-8?B?bUJWb3lXcjZMcjBOM1RqMzNrbmdCSUZiZFlqQ1FIazdKQzNwbXhKSDlsNVlF?=
 =?utf-8?B?YllVNDNQalovdkIzbVZvZ2NNS0dVcFFXSlJCSUZVSEh4Tmx2aEpPTjBpK3p1?=
 =?utf-8?B?c2JZK1dNRTYvOGFESjVpVCtoUkwxQmRTY1JVOWNyMkdqV0dYbSthVjhCWk9y?=
 =?utf-8?B?WUFlS0hxZlJtNnpFbEI2d3hBOHJ3UUdYTWh3alBnV1A4Uk5WV0NLNmh3WDly?=
 =?utf-8?B?SkM2b2U5OEo4blZWS0hKMndSQ3o4TDVoZmM3bXF4RFMxQ1dITXhTUmNaMytY?=
 =?utf-8?B?SEp6aHlkQ3dQRU5ZVjhqcDRKUDFZMEVRSlF5Kzh5eDdLMnJJRzMrZ0I4TndI?=
 =?utf-8?B?bGlUa3VyUW9CTEhRVUtJVm1KN1NPM0IzRjR4K0x5RjJpTXZvSk5MTGFvQmJR?=
 =?utf-8?B?NmpRL28yZ2VNaUpsakFQVDcwSTJQTHRyWjgwMlNNTU1YL2VRTisxS2RhMFA2?=
 =?utf-8?B?bFNoSDRLb2hIaW5qZ3A4cmpvY3prRm9jK1RERW1VTmxlQ1RiaGFxS2hhT2p1?=
 =?utf-8?B?ZFByMEthaGtnSEltRjdUV290UFRkSWgraFVoQ2R6Zk9YWVVuaVIrU3VSU1Zs?=
 =?utf-8?B?d3NheitUWEtFY2s5WXh4TTBMNk1PeWMvNU1iUGFDWUZxYmRaaEJDdEdIMS9X?=
 =?utf-8?B?Skcwb2xDWXFtOVpDV1FxZzBRRkJka243VHNxNnVGYnBZVS9CclozdVJtOWg4?=
 =?utf-8?B?b1l4K1lwaXlsV25RNitnK3FsTkJkd1B5eHZmRFZjQTdjQ3BIYURjcVpRQmxt?=
 =?utf-8?B?UnArME90ak8xT2VjT2VCYytDUlh2VDRDVmgxQzA1ek9ZemJ0ZXFobjhxeExj?=
 =?utf-8?B?RWFpVmQ4ZWZHOVNxNEhmTTRFQ0tEcjZNZHptZEVrQlFKdUhCZTlZS1hPNzNk?=
 =?utf-8?B?Mmd3QTR3V1dQM0hlT3g2dGJhd2tNMlZmOVVKYTJMdzNaUHpNazlrL1k0STRo?=
 =?utf-8?B?SCtIdCtRVis4bFJQSmtRR1cxTjljS0N4alNycHQ1SnM1QWFieTVaSCtjMWIw?=
 =?utf-8?B?YU9Cd0s4Q2lvMlpQZXlhTm5uUDR6ZmFISzVGMVhXUDVURGtCRGE1Skhya0tx?=
 =?utf-8?B?djU1RFZxOEtuUnRWV1k1a0RpTlU4MXVQV2RxcG9HK05HemtvMjcrRW1yT2pv?=
 =?utf-8?B?Y29USE5FOExvZFppZTF5YkE5WGpLTGQ1ZFRtK0xFUGc3bEltVW9LMGNaOElq?=
 =?utf-8?B?WExzZVZJT2Nvc01SYUNkOHFsU2R2ejhnb1lRMUN6aUJxa2lDQ0JqcE1GTk1l?=
 =?utf-8?B?WWdWcitPdE1DME9HYXU5Y3ZHVytRRFRSc25uYjhRaWNuaVNuQ3FxeG5WQThF?=
 =?utf-8?B?U2tsOUZleFpjOE1BMGM1eXNBTmdMZGw4UG9wK254VlZuVVNtdDhnbktUSlp2?=
 =?utf-8?B?bHlxS0MwU1o5UUlZazNOelVQZ1Zpa1F0cHV5WWlDZjI2SzFUbTlvRkVuSm5Q?=
 =?utf-8?B?SWp6VkdHR1hUQTFGMkRvcXRiVlF2Z21wSGNSczQ4UThCbnNUVVRTdXk2bnVN?=
 =?utf-8?B?MENKRHNmK2dsYi9jVDIzTWxpSEdiME90eHcxeWRqQnp6LzRuL1d1ODdDZmpP?=
 =?utf-8?B?SldJSUhPQUsxTXlyUW04eElZSlEzZEtiaFJXbFNOZVNBSm9IZm1QUGh2ZnBV?=
 =?utf-8?B?SFdKWllYUVJ2VXpieHJsY0N3Y1dvV0EyK1E1ZndDNkZXNFJpMTdzN0p4cW40?=
 =?utf-8?B?YlFLWXRYbjl6QVpTYU9talk0dFQrUU56Rk9PVDlkMzJGeXR1QkR0aDVFTDlr?=
 =?utf-8?B?cy9HWlFqc3RZc0tlYjlzZTBuWWZ3dU9aNFVQcDBySVhuTEY0NFArNnBoUW1W?=
 =?utf-8?B?bXlPWWgxNVcxQXBOZjhmY1JFUDhVbXdLNzR0SDE2NVRad2V1R1ZSTCtoTUhC?=
 =?utf-8?B?VnpHbVZqOElHYTVkUmZEcnBIMWZyelIxa3ZwNkRJdTZaTVJycGtHTWdST2ZZ?=
 =?utf-8?B?OUZMT3dRSllnb2JWd0hVbS8xelFpSHd3UHhVd2NaSXR0NHFlZzBHT1BVend5?=
 =?utf-8?B?VmQ5ZndieExYblFObTFodUIxb2g0VXNNNWdwZVhTRTIyTFlJV3ludDF4MnNW?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5216.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998131f1-fbd3-4f2c-67c0-08d993b42b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 10:27:08.1782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51blqF+Jk0MJu+VOPr8MKTvqc9iLODTm6342NSNWd2OgUSnb963SyAPuqOaayEd4rTxcftZqhH3ZmdIHpbktfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBPbiBXZWQsIE9jdCAxMywgMjAyMSBhdCAxMTowMCBQTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0Bu
dmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgT2N0IDEzLCAyMDIxIGF0IDA5OjQz
OjI4QU0gLTA1MDAsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiA+ID4gWmh1LA0KPiA+ID4NCj4gPiA+
IFRoZXJlIGFyZSBhYm91dCAxMCB0ZXN0IGNhc2VzIGluIHRoZSBweXRob24gc3VpdGUgdGhhdCBk
byBub3QgcnVuDQo+ID4gPiBmb3IgcnhlIGJlY2F1c2UNCj4gPiA+DQo+ID4gPiAgICAgICAuLi4g
c2tpcHBlZCAiRGV2aWNlIHJ4ZTAgZG9lc24ndCBoYXZlIG5ldCBpbnRlcmZhY2UiDQo+ID4gPg0K
PiA+ID4gQ2xlYXJseSB0aGlzIGlzIHdyb25nIGFuZCBJIGRvbid0IGtub3cgaG93IHRvIGFkZHJl
c3MgdGhlIHJvb3QgY2F1c2UNCj4gPiA+IHlldCBidXQgdGhlIGZvbGxvd2luZyBoYWNrIHdoZXJl
IGVucDBzMyBpcyB0aGUgYWN0dWFsIG5ldCBkZXZpY2UNCj4gPiA+IHRoYXQgcnhlMCBpcyBiYXNl
ZCBvbiBpbiBteSBjYXNlIGVuYWJsZXMgdGhlc2UgdGVzdCBjYXNlcyB0byBydW4gYW5kIGl0DQo+
IGFwcGVhcnMgdGhleSBhbGwgZG8uDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Jh
c2UucHkgYi90ZXN0cy9iYXNlLnB5DQo+ID4gPg0KPiA+ID4gaW5kZXggMzQ2MGM1NDYuLmQ2ZmQy
OWI4IDEwMDY0NA0KPiA+ID4NCj4gPiA+DQo+ID4gPiArKysgYi90ZXN0cy9iYXNlLnB5DQo+ID4g
Pg0KPiA+ID4gQEAgLTI0MCwxMCArMjQwLDExIEBAIGNsYXNzIFJETUFUZXN0Q2FzZSh1bml0dGVz
dC5UZXN0Q2FzZSk6DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAgIGlmIHNlbGYuZ2lkX3R5cGUg
aXMgbm90IE5vbmUgYW5kDQo+ID4gPiBjdHgucXVlcnlfZ2lkX3R5cGUocG9ydCwgaWR4KSAhPSBc
DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgc2VsZi5naWRfdHlwZToNCj4gPiA+
DQo+ID4gPiAgICAgICAgICAgICAgICAgIGNvbnRpbnVlDQo+ID4gPg0KPiA+ID4gLSAgICAgICAg
ICAgIGlmIG5vdA0KPiBvcy5wYXRoLmV4aXN0cygnL3N5cy9jbGFzcy9pbmZpbmliYW5kL3t9L2Rl
dmljZS9uZXQvJy5mb3JtYXQoZGV2KSk6DQo+ID4gPg0KPiA+ID4gLSAgICAgICAgICAgICAgICBz
ZWxmLmFyZ3MuYXBwZW5kKFtkZXYsIHBvcnQsIGlkeCwgTm9uZSwgTm9uZV0pDQo+ID4gPg0KPiA+
ID4gLSAgICAgICAgICAgICAgICBjb250aW51ZQ0KPiA+ID4NCj4gPiA+IC0gICAgICAgICAgICBu
ZXRfbmFtZSA9IHNlbGYuZ2V0X25ldF9uYW1lKGRldikNCj4gPiA+DQo+ID4gPiArICAgICAgICAg
ICAgI2lmIG5vdA0KPiBvcy5wYXRoLmV4aXN0cygnL3N5cy9jbGFzcy9pbmZpbmliYW5kL3t9L2Rl
dmljZS9uZXQvJy5mb3JtYXQoZGV2KSk6DQo+ID4NCj4gPiBUaGUgcHl0ZXN0cyBjb2RlIGlzIHdy
b25nIC0gaXQgc2hvdWxkIGJlIHF1ZXJ5aW5nIHRoZSBuZXRkZXYgdGhyb3VnaA0KPiA+IHRoZSB2
ZXJicyBBUElzLCBub3QgaGFja2luZyBpbiBzeXNmcyBsaWtlIHRoaXMuDQo+IA0KPiBHb3QgaXQu
IFRoYW5rcw0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4gPg0KPiA+IEphc29uDQoNCkkgd2lsbCBt
b2RpZnkgdGhlIGJhc2UgdGVzdCBmaWxlIHRvIHVzZSB2ZXJicyBBUEkgaW5zdGVhZCBvZiBhY2Nl
c3NpbmcgdGhlIHN5c2ZzIGRpcmVjdGx5Lg0KSSB3YW50ZWQgdG8gZG8gdGhhdCB1c2luZyBpYnZf
cXVlcnlfZ2lkX2V4IHRvIGdldCB0aGUgbmV0ZGV2IGlmaW5kZXgsIGJ1dCBpbiBjYXNlIG9mIElC
IChJUG9JQikgdGhlIG5ldGRleCBpcyBqdXN0IDAgYW5kIG5vdCB1cGRhdGVkIGFjY29yZGluZ2x5
Lg0KTm90IHN1cmUgaWYgaXQncyBhIGJ1ZyBvciBieSBkZXNpZ24gKGxvb2tzIGxpa2UgYSBidWcg
Zm9yIG1lKS4NCkknbGwgY2hlY2sgdGhhdCBhbmQgdXBkYXRlIGFjY29yZGluZ2x5Lg0KDQpUaGFu
a3MsDQpFZHdhcmQuDQo=
