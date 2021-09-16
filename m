Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6242A40D5F5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhIPJSy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 05:18:54 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:29159 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236298AbhIPJSe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 05:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1631783835; x=1663319835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OozpDQrQ7VBsE0+zO150BfBFfTJxhCTgVnyTQta61dI=;
  b=EqQrbFXL8UULLj3T6eBwJeS361m0xqQXIejJD2ojOCDub+m6uuZunF82
   PXvRLJ/ue3AWG0ji//MqFgIxgMo22KxC2zx0vhlTpP7hv50OjQpLhxXbZ
   wvwFXoQ2azfaS1TQIPnopJq0wVi29s/bUYAIsvHNHOMEUbs+ITedylJbg
   NekcTNRUawIw5basHRrXv+ZZmEyhVCUumxPjtta98E7JXUk1oYlO5KBP2
   dRLgb1eIEWrsxExL3YIvQehVbTQ9a7qxLEG3L7KrhSXL9rZCkpiPMaKQ2
   Qu2CznLywyLF8H9EOjJ/flRWpA0IO7yO4es3YpdePsCShBYup9co9/j8L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="39264956"
X-IronPort-AV: E=Sophos;i="5.85,298,1624287600"; 
   d="scan'208";a="39264956"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 18:17:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaQV7fwUizXamyCviYigNmb9hm5K00zrf7h3/t15W6XGUCKLKRm8RAJEI50wflP4COpS3fl3lhysEHhxVY8nG2cvkTE264GtMySvrRN0vqeA8QXftRvsb0RkFAA8jnJipdIW+B1tvn/SzSR8wgsa17io2VirXKSFTayA5fFqqIcCE+zwHIevdR/78Oh51AbVfu2I+xqAluUaHb+yiLtj1fBeWLyi1mm24yEqgqewIuKBKa51tJwrKzfLO87PJRe00cJvTltqE2O+xDtgjKsxeiKTvXWJu7M64obWYfbHITi1cqz5C+rC3X9h7sHj4F8PMRgGAmVKfMPnLsHprEyrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OozpDQrQ7VBsE0+zO150BfBFfTJxhCTgVnyTQta61dI=;
 b=OzGXbFTRqee+slK1g/NyD+ExcW07i1sE11zYlzmx8AkvA/AxNZCM5Kj7DgI5TgPXaETfdmpB9zUGeGag0GfUU0A11tO8JwJW/CyuqE6DwAROg3KQ614ENu0iFhDRE5petkVo0MqWuj2pYXHeqgfyJojToUL8/QDlckA/PFPdTH/A6BttnG66ijBpzh4FVzVUbHRTFFpYn0W5fPyJNuhsLHFKC7au/VFssiYwFYjGwvALWUV3uEs4NxGrdEfU+/CIdcBp/z/g1d3AbSs3a/XeFS3h/CVjMu6VQkEqLvr2l3JB/sUXgEh0aRqMV1hd/UY0/ZW9VNe/KKuk9zasRskRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OozpDQrQ7VBsE0+zO150BfBFfTJxhCTgVnyTQta61dI=;
 b=eEbhc4NxArrRaaNKMKsU45dFF9MUKsCtzx4zMODqLpudmadZ9SdJS2zCLc99h2lNmh5AURNsHVq5HAALXE9zfQa8crTJi/uedH2muQxA5aL9+/G4T3Xl//JcLQoGSwqCo0AhG/fCM3vU1KDrfe5lta+ywM3LCo3tD0wilEbP4L8=
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com (2603:1096:400:99::12)
 by TY2PR01MB2793.jpnprd01.prod.outlook.com (2603:1096:404:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 09:17:08 +0000
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::1535:e824:b68a:c23]) by TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::1535:e824:b68a:c23%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 09:17:08 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v2 3/5] RDMA/rxe: Change the is_user member of struct
 rxe_cq to bool
Thread-Topic: [PATCH v2 3/5] RDMA/rxe: Change the is_user member of struct
 rxe_cq to bool
Thread-Index: AQHXn9KnIZ1ycVn0AEeBmz9SyRy2o6uj7oCAgAKI/AA=
Date:   Thu, 16 Sep 2021 09:17:08 +0000
Message-ID: <61430B7C.8000907@fujitsu.com>
References: <20210902084640.679744-1-yangx.jy@fujitsu.com>
 <20210902084640.679744-4-yangx.jy@fujitsu.com>
 <20210914183355.GA136464@nvidia.com>
In-Reply-To: <20210914183355.GA136464@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67b6d0a6-547f-4542-196c-08d978f2c26e
x-ms-traffictypediagnostic: TY2PR01MB2793:
x-microsoft-antispam-prvs: <TY2PR01MB2793B30A76BA400B257CD3EE83DC9@TY2PR01MB2793.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fWoMamLgO9oQ4A1b6z2fX16tmEmZDN6UQCKlRaSS5CdidJa04amrQnRjsxFw5SweT+ZHb0DmNHJHRMYFsoZ1CSrp+g1ARjZNFghFyUknzJ2Mgu48wS2FNVQnpXTRj/mro7BuEHkayuloyP0xRsVuhUisigOyKBO9ZF2Y/BeLHObiJrhXOcIv7O8MLPgOm3IgaYOWRY4ewT8z5xw+TZ25Q7Q4fT5Nn237RMk2D4uOcRkZGENSSRrTaWg4ZNIyuNCaCxg54FSDilzwoXuSN5ygVDGSb/TezYMPR9B6pDzj5hekbPi3LwRMq1/y4/98gHupTWSIkyqbqVl4rRse13CrPDYMg+OtnlE30Hh5BPJdbkIQ1dUqDYlL0sQiVcjV19QGhrhlo63F9+nETceL/j0VOUVfPVRTQZr/Tl/VND/fPZ9BF3LV2nAS26tJL6b8PYr7VojJ3jvHVaxy2p+MknaLB5LmFKaEx+XyzLpVpzOs6ot0BYyOoS3AIHraUhYjuRvf6Jb0ZLt6pRrsqdvmkYn80ng+Vijk7uA6e10A+oSnMAVq1/DgsmK4UJQHFZc+hoGzuqaFtpE2cNwIKbTK1VGLz5c7ya9aFXfqf6YDbVJjpCd3tIQX02UG/ZBHN2saz42j2RCotIH7RDk2b0oVlJEAlNrrq158pPcVNsuGhREo+ROsw50hVLi2yfSZybCl1H6Z8Fw5YN9BZYdKUQ824VbJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6382.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(26005)(38100700002)(33656002)(71200400001)(6916009)(4326008)(186003)(66476007)(86362001)(54906003)(122000001)(2906002)(36756003)(5660300002)(53546011)(64756008)(6486002)(6506007)(478600001)(83380400001)(91956017)(76116006)(85182001)(66946007)(6512007)(87266011)(316002)(8936002)(8676002)(66556008)(66446008)(2616005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TmRvQTZ4V0hFY3lrSFYvSmdIYno3NFpxZ3RMbTE5YWljOTB2ajdyT1BDU09i?=
 =?gb2312?B?a0t3Ymd0QmFycFAvRGZTLzBmaUZZL1ByaitGVTNoMk9HT1pZUGhQaHhEcE1E?=
 =?gb2312?B?b0NaazU3UFBOYWRHNS9OYU1tZUdDWjN1eGl1cm56SExBSUFJWndUbFN4azdK?=
 =?gb2312?B?Y2RpM2N0aHNXNnpuRWxaNXEyNXE5NUw3bG12WFRVT3lPenhtZ0RxS0FQVmhQ?=
 =?gb2312?B?MVlMd05xWDdhdmZmZzRGL1JDSlY2aWRJVEh5dmEyQytIQkJKUmJEdldBaWlN?=
 =?gb2312?B?Rk9LYk81dGd4WFoxeVhpdWhpWk9Hd2VmbHArT1lyanNBMEVqSG4zYVRXd0Ra?=
 =?gb2312?B?UXpEN2FYb2R4amc0OTVlT3VLdEsvM0l4OWtSeUVERnFiTHgvN2RXb212dG9V?=
 =?gb2312?B?STVHQ3J3bmhiRHFUVmlWT1pRZjkwdUFmTVppY0xlNkpOMzZtM0NzdWFBQUls?=
 =?gb2312?B?Wk5oOVl6L3dSQzVSSTlkb3d6MzRjUXZqZTg4eWhhQ21ieTBveEZ3S29BMjhn?=
 =?gb2312?B?b1V2TEUzL3VTNkxMR3JQRFRiTnNCRmhLSzAxSDRIazd6YVpjQXZsbGtueHh6?=
 =?gb2312?B?c2xSVXM3VGExNmRqeUdXanpCdnQ4OUE4SjNmM29URm13WnkxSEloOGUrN2lT?=
 =?gb2312?B?QWo4RWx5OUIyTFBNc0ZZUEJJRjNCUGRrbDZCa2hWQ2U0eUxqRE1YK1d1WldO?=
 =?gb2312?B?WjhiWmYra0ZXVk1SNXNXMjNseEdJaC9GSCt5UXBwWTZXbUtad2VkWEJRL245?=
 =?gb2312?B?M2pMdmFDZlEwSnFnQjB1U3RaY0tmREUreEw0OW1NTWZ5d2FtZmlHRlEzKy84?=
 =?gb2312?B?VDdHZUdKYU1CaW15V0hrSlY4dm5Ydnl2QlJKZDk0YWl6ejVBeDdYMjBCNnpk?=
 =?gb2312?B?M3dwc09qemhLZklzbEVmZDMxcU9vd3dYQ1FhNTJNTGxWWXQvMU0wdFcvd0d5?=
 =?gb2312?B?UzZid3lRYXhxNmJhSXNVeGRmM1pOY3RXMU5uZHFVY1crVFRVbVVlYnpDVFZB?=
 =?gb2312?B?K21lRkNHSEdPTC9nbElwWWJTZjFDQlhVZWY0bU5neGU3RS9vaVBZWlJrWlh5?=
 =?gb2312?B?UUhTTGxISzBRTDQwR3dSRmRJa1Y4T0JPQWxRNXFOOFlkakdmWG5YQ3ViWTh1?=
 =?gb2312?B?SHp4MjM3dHRWTnZJeURrRFRQaWhxeTgzUldRYWJSQ0VROGNGeDZSaTZzTWxR?=
 =?gb2312?B?Z1RZeU9PMHJ2NVFITkM1NjRLOWtNSC93ZDBKMVBMaTBEcjhxQysvVk9PUFFl?=
 =?gb2312?B?QXBvQ0swd1Y2SE5kME90dHJqWEIyMmx6cjRXaWZyTkowOXhicWpZcnVOZVZZ?=
 =?gb2312?B?L1V6WThUQXdBWEtHTEVwT21vZG9SZmt6TnhqalNVV2Q2RjVraWdoaXRraUZN?=
 =?gb2312?B?VE9SY0QwYWlPYjdsdEJMYlJWMUhPOHFZTzhvUmszdE1hZVBtYUdkbUhFem9m?=
 =?gb2312?B?TzJ2UXRBeHQ5RHFGRXRSNnhDMnNhbVRRNTU1MWZ0aTdQL1RtRTMrVDE4QXp3?=
 =?gb2312?B?SGxpa2FiRi9KcFlwaWY2eVZ5SjIzWnFhTENNKzhSMFZQempHVU5DNGpNT0FX?=
 =?gb2312?B?enZWTUFQSWZ2TW1lVDh0Q3pSL1ZEcEUzQUpNSk90UFRBbXlGUVRMNjE2Z2p1?=
 =?gb2312?B?cVE0djk3QWw0b1V0RVp3RkZxVG9LaVJrODNhdUhUckF0ZVZLZDR6Sld6SzMz?=
 =?gb2312?B?MWxkV3J3S1h5OW9VNDFIUWZDWisyeEFqN1lyZzdJcGN5MzYxcWZ2d2lRdWF6?=
 =?gb2312?B?aGlqQkMrUXZJNG1JZTIxYlpLUm9XenNGcGNBVndaSGM4ZkQwMDFDN3RPT1RP?=
 =?gb2312?B?WFcvc1p1RkN6MlVCV0FOUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <0FEA887047B39E47BF4F992ADF7D7B13@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6382.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b6d0a6-547f-4542-196c-08d978f2c26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 09:17:08.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJC2QvXA+M7Uw7nDqPqJyn4JM1z7sbezQOKVTR8hsIqvFEQ1/TbAEn2XXRf/jpimz+wG+c1olD/tls2L6fNxiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2793
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS85LzE1IDI6MzMsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVGh1LCBTZXAg
MDIsIDIwMjEgYXQgMDQ6NDY6MzhQTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPj4gTWFrZSBh
bGwgaXNfdXNlciBtZW1iZXJzIG9mIHN0cnVjdCByeGVfc3EvcnhlX2NxL3J4ZV9zcnEvcnhlX2Nx
DQo+PiBoYXMgdGhlIHNhbWUgdHlwZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmc8
eWFuZ3guanlAZnVqaXRzdS5jb20+DQo+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X2NxLmMgICAgfCAzICstLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJi
cy5oIHwgMiArLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfY3EuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2NxLmMNCj4+IGluZGV4IGFl
ZjI4OGYxNjRmZC4uZmQ2NTVlNDFkNjIxIDEwMDY0NA0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfY3EuYw0KPj4gQEAgLTgxLDggKzgxLDcgQEAgaW50IHJ4ZV9jcV9mcm9t
X2luaXQoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgc3RydWN0IHJ4ZV9jcSAqY3EsIGludCBjcWUsDQo+
PiAgIAkJcmV0dXJuIGVycjsNCj4+ICAgCX0NCj4+DQo+PiAtCWlmICh1cmVzcCkNCj4+IC0JCWNx
LT5pc191c2VyID0gMTsNCj4+ICsJY3EtPmlzX3VzZXIgPSB1cmVzcCA/IHRydWUgOiBmYWxzZTsN
Cj4gV2hlbiB5b3UgcmVzZW5kIHRoaXMgc2VyaWVzIHdlIGRvbid0IG5lZWQgYW55IG9mIHRoZSB0
ZXJuYXJ5DQo+IGV4cHJlc3Npb25zLCB3aGVuIHRoaW5ncyBpbXBsaWNpdGx5IGNhc3QgdG8gYm9v
bCB0aGV5IGFyZSBjb252ZXJ0ZWQgdG8NCj4gMS8wIHVzaW5nIHRoZSBzYW1lIGxvZ2ljIGFzIGFu
eSBvdGhlciBib29sZWFuIGV4cHJlc3Npb24uIFNvIGp1c3QNCj4gd3JpdGUNCj4NCj4gY3EtPmlz
X3VzZXIgPSB1cmVzcDsNCkhpIEphc29uLA0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4N
Ckkgd2lsbCB1cGRhdGUgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzLA0K
WGlhbyBZYW5nDQo+IEphc29uDQo=
