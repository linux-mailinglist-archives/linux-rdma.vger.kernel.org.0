Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFF651AA6
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Dec 2022 07:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLTG1y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 01:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTG1w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 01:27:52 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4451028
        for <linux-rdma@vger.kernel.org>; Mon, 19 Dec 2022 22:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1671517670; x=1703053670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1JEm4vLRTdgq8XUl0hTvnLoupg4y9YS+WXnOeDfc4cg=;
  b=L2H6Z0NC6OkyH9esMomhU1vVG6o6P3U0p8ZIVS248TmEQiYDnpfQxUSA
   SFOvGAgdJ2s3IURAuTsIJNo0pJM35KhKUesO3o2uLAcOh+vGcUMrdnZsE
   /zg4lxHDbVrNJfEsnuLqop5LgTb2dO4aXTlVFHBT7x2fSADqVA29tnGKa
   v9iv4pV/1pjcuX9nd6JGGpuO5fVO2HFoi4g54CRvq2zSKzuEAsGQAXk9u
   CQuUj1WaKx5UnB1sJdxCZbboKnNbD1WndneBPD6lvaFsQ8NQnW4bz7dRQ
   nItJKFJoTUSeTYkSyGyyz/J0UmkTlt9PBQ/HK+FleIP3B5riwE7fOs1L8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="72960714"
X-IronPort-AV: E=Sophos;i="5.96,258,1665414000"; 
   d="scan'208";a="72960714"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 15:27:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3grSBC0R7KqOTtJd2zt8ctENzXBndS7E+Wf0/t6vJ2a6ie+CkL8AdQsC/LYVIybqtxv8xzGWrrkp0Xugh5Ra9jSgj7CW6afpsv/NpHGj6oFac3NEJi1MZXzZQTqbcdboMfGtpaX/T81gHhwi0VO+355nkCx1DFkj9bS8OMed9dyWL6satNivnLe84oWK7m37KcmsfY+Djy2C9MOaSRcyodJ5W+QyA1Ie0HpbgQZAtP/40ZON34Wn+9JSQwk0DI0/7xRJbpAudbyaOvP8PXWam7tFFt+1nVrpbLKnD2RjbuUbShajUXhmdTvdhT5tnfd+yezkHgSQMPxvMZhKO8NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JEm4vLRTdgq8XUl0hTvnLoupg4y9YS+WXnOeDfc4cg=;
 b=GCGDDfBidmcu0rR1xAd2tkh9FTkSCg6jqbAkKKadW4RCXCkvk87BbGHaWo8ufAHEomC1MGyv/OUEpgoTymLHKGLsXan9467YSwVGtGUBk2NsUyEXm0SKtog13aIOOyLKFkKuFu48VwKdxtthims/E6g4XMvm+ayC5QB7nIZMrSqqEKDve+dz1JeXVB/mLwvPuiXnt29GomZF4+HJb4qOaZQ4ViW42q0og4uyMlVfQb4X8LGVXU5Ptk5CeWjMgqxevxx7pIV/2ovAOXPGkvy3wR76oM0C05bPzBcJGQ9jX+rqHlt2t5Ar7Yz4lHkxQlkYGnNCdv2YRIK3aiPb1uKHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB10632.jpnprd01.prod.outlook.com
 (2603:1096:400:290::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:27:44 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:27:44 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Rao.Shoaib@oracle.com" <Rao.Shoaib@oracle.com>
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Prevent faulty rkey generation
Thread-Topic: [PATCH v2 2/2] RDMA/rxe: Prevent faulty rkey generation
Thread-Index: AQHZE21M7MZ7sp5VyUi79FXOxsdf7a52UXkA
Date:   Tue, 20 Dec 2022 06:27:44 +0000
Message-ID: <b35e7a9f-3977-0daf-237e-f1919ca3fabd@fujitsu.com>
References: <20221219054644.4530-1-matsuda-daisuke@fujitsu.com>
 <20221219054644.4530-2-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20221219054644.4530-2-matsuda-daisuke@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB10632:EE_
x-ms-office365-filtering-correlation-id: 90484526-8978-458f-e524-08dae2534ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Yfqb/bsQMR3gAFc+/oolMF3jYiWt/aoNmL7UJaa/W6nzPEsuIIh/PwJ3Dw/jAVnyuhBLy4SJlXqDsz5egf3g1Zbaz9Esu9VmZ7Z2x2OZ/RjzGo+V2Ym1fgNCIFZE5YtkRJ5Po9jUOgfk/FGGXB5T/KmtK8uqaAJfADCFY1ROURhpLR2f+1xThrQQArj6z9lY7DNKfkoGOn5g3qYII7jZ3MxKeCBr3NH5YRTs9woGnTZK1h7nyIALAiUz1WKSJJqcokj+huF5Jtf4XHD2lKgsJNMZupDpSi5enfTK55bPWKwog4ZReMXl2lhBj9Hfcl8qKC7L9SlK1bv+eZS+gsCjC1roqc0gAah/Teyb+28EwGdnKv9QqLwQNUGgET4iD6VOaRuIWWJX8+kTbB8FHQPYNKaGdeFa2X3mZPWNDoaANfKCJSCVtJND9w44leLynuKVvvXzXYMaHjTN8OMlYqpI+cJfrg4dwu+b7uQK30aV7bbn1T97C+B6Ir4d1Rxi8kt9k5KtrwalISNrkdU56eliv1KxeMX35iX+DIsymYwFVUgAFpwhR5drViFIngRi7ms9yANJUoaHoq//3HzfRepzrZk5nbm4dp2lXqPN2mcdd4QfHCYpD+5FQJAtwjHUBmeSzA3FdOeqICmnNWnWdgT4LcTC28wlOcDLwwtr1w5b9mqUyp/m3kJmmIAu5Wv278ZLlD0tV3cKTuZYkORIPr1VvkZ0QY+m7TG6h9bkFU1Dz9f+qXKhhb1SwaZHTXlQCSe721HH1EkRUIgVHGF6dK5JUqCl8F22qvNurjsb7b6iUrX1PTAJ/OwzQh3gpBiXjhmlvygaTHknH85Y8qVCOHC5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(1590799012)(451199015)(38100700002)(122000001)(82960400001)(83380400001)(38070700005)(66476007)(31696002)(86362001)(66946007)(66556008)(66446008)(8676002)(76116006)(5660300002)(2906002)(4326008)(64756008)(8936002)(41300700001)(6512007)(26005)(186003)(2616005)(53546011)(6506007)(110136005)(54906003)(316002)(478600001)(71200400001)(91956017)(6486002)(1580799009)(31686004)(36756003)(85182001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU9jRU9NekY3NnJOUGs3aDBkV1l5TkpJbC83Q2dkVVlmUGZjM3hmdmhIRXlu?=
 =?utf-8?B?bkJ5Sy94eTVQbllnTm0zM0NCWHNRYUZGWjZjTXZ5Um5aQ1BSOW5uSElrUVh0?=
 =?utf-8?B?UUhrRnZqeXRvRkRTRHJsZHJ3djlKU1diVGFvbUM2YjIrMFcrRHorZXFocGUw?=
 =?utf-8?B?ZENLckZ3NnJwOVo4aDAzakpxbVR1TTBtR2Vsbmc2aVhpL1o4WldRUEE3QnFv?=
 =?utf-8?B?M0RqTlJkNVIvWUxMMXFJWmlTTnZpbXFxSGptVUgwM2dWR20wTVZSdDZuWmFr?=
 =?utf-8?B?ZVdaT2VBV0lZNkVGWVBkYW5mcjZLVHl0N0kxMkVhanJNZmdlRm5IZVBuMkJH?=
 =?utf-8?B?dWlFckYweUh0S3VGNnV3SVhiS2ZTL3l3MXU0blRmT3F0UE5pSWdEMWZRbmI4?=
 =?utf-8?B?N21GNytyUUVEdHNkK3VSY0tQa055ek81aW93bFNFU055TDUzbVpxTFhBZVhh?=
 =?utf-8?B?bXVVSnY2d1FyK1drOEhFM0hMeWJ0bHh3cE03c2FvY0V6TUlPTXlkd3VQT2JX?=
 =?utf-8?B?THFidUozZmU4elFDSzhGMHpoWCt4SUNCeUtRcnFMNlNWU0NsT2h0dTNUaDQz?=
 =?utf-8?B?SlJDclJoWS9nNU1UTGtFdDBrSHJNMDYzRTBaRjN3Mzh5N2JCUFY1aVFPTnN4?=
 =?utf-8?B?Ym9vMUtDcjkrbDJoZi9KS0ZaOXBGN212YkhjOFVDR2FUOGg3L1kxanZkK3lL?=
 =?utf-8?B?S1dTWWE0QUkwWHF4SjM2K3RvZ2l4ZmlWUWplenZhamZZOE9pZkNlTUNsK1RF?=
 =?utf-8?B?emRzLzFsK2dEanBFVDNZVENkTERuMTdoNm5DQW1XVk15aG8vYlJsaDJ3ek5z?=
 =?utf-8?B?dHlnRm5sWDFoS0JMNGhucHlIVS9ITWpHcTFmNjY0TWoyakNmdXgyZlVySURu?=
 =?utf-8?B?UXZ4OXVRc0pBYUYxK3B4RFVCWGNnNFozaFJBNXVDRnJHTXU4QW9XTFBkNlFo?=
 =?utf-8?B?VHNmLzFPczdFY003ZUllTFZTNTNZbU0rRGErMk9hNkVTb1BTQ2ZCMUt5OXJn?=
 =?utf-8?B?NFhnL09SYWpCS2E0MmVMekQxb3J2RXc4QW9iVG9JT3h0aXJ4ZUpYdTd6ZS9E?=
 =?utf-8?B?MGgrL3BKSm5PVCtjM0hZdDJyaTFNNVY5T1ZmZjFDcUFXdWFJVURuRG16VFZa?=
 =?utf-8?B?WTRIakpUNndTU3BMd0NpWkpTUkQrekVPYXlTZzhBVHd6MDR6VWpxcnF5R0ph?=
 =?utf-8?B?NVNhNW1iV0lUVGFTNkVnSExuSDNMSjdJT3Zmbzlwb3MrUU5HV3BWajBrNkcr?=
 =?utf-8?B?akJ4MnJxM3RnazcvMlJ3ZmtYa2hEcWRzQ1JWRjNPdER2MkxON2dISkNDd3Zn?=
 =?utf-8?B?WHkxQWFRYml2aEVJMU9YcmdrSVcvUGk2Qks0UmE2RVh6U2crS0dZejZ3cHdM?=
 =?utf-8?B?MndFeVZjbWpEOEh3aTA3TU00UFhlNE9ra3lHdjI0RHRCN0pIczZQblpDbDlu?=
 =?utf-8?B?TkpMZkVNVERZUi8rVjE1N2JrRXQxYzNaa1RkaE5CSEtkdzZBZzA0SWJtcUpu?=
 =?utf-8?B?aS9FQ2NuSzRVeWpLbVZSOU1rNzFNQWZyLysxWHBlZGNrWHIvSXNNR0ZuZGpL?=
 =?utf-8?B?cE12algxR3dJekluSG5oekVaQ0NqdVN5SUZEMDFLYWd6MUVGSUlmTDhoeVgz?=
 =?utf-8?B?bVg2b0ViKzV4QmN6aUR4VjZRNGxKVVFBRXFPOHFEM004aFJHNmVuajBIZW90?=
 =?utf-8?B?VllmdEFWQXRKRVl6MStMbjRPZGY3SkdqOFVtaEZlTDFKYTl0blFIdWJmWXVi?=
 =?utf-8?B?TzNvMmtCQTQ4UjBFaDFQbzFWWnJjWklaRzNVaHZIcStLbVVTWnFwcmNNbk81?=
 =?utf-8?B?M0lyZ2lYZlB5L2grbXNhY2VqUEM3Ynk1aWtPNGVPdlpueUZmc1Y2M2RVY2VF?=
 =?utf-8?B?ait6bUJBQmRtaEJVbm5LOXU4cnhSWnZIbnJraENGbmVrWVhOTXNqRFFVOU1D?=
 =?utf-8?B?dUxBQjRlZkJzZnI5SWtNNG1zWE5NYVFwN1RINHBQc1d6bzhrZ3l3RkczKzAz?=
 =?utf-8?B?MzRWcW5zRnh5UVBRa3pORFUxOVBlOGwrVThDUFVYeUxDWEg2NjVXTDJ3N2Vj?=
 =?utf-8?B?aFdDRndTeTZDNFFrU2llTjdINHdUQnNmdmpkbDBoY0thSGdHODdUMldqQlJh?=
 =?utf-8?B?WVJ0cVIrazYyNHZUSkJQT3JRVldHcVNFSEw2ZTE4cStHZ2QvbkdTWmJGSVY0?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17D7199D3D3C3C48B27B9052FAF6D6E6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90484526-8978-458f-e524-08dae2534ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 06:27:44.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwEcHtggZ6m42q+RoZ6usAHrleAShEVoDzuV+IShL8awzOPfl9SNGbEmeMx6Vkr+dBhsD66rHLgoxnAvqTz82g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10632
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE5LzEyLzIwMjIgMTM6NDYsIERhaXN1a2UgTWF0c3VkYSB3cm90ZToNCj4gSWYgeW91
IGNyZWF0ZSBNUnMgbW9yZSB0aGFuIDB4MTAwMDAgdGltZXMgYWZ0ZXIgbG9hZGluZyB0aGUgbW9k
dWxlLA0KPiByZXNwb25kZXIgc3RhcnRzIHRvIHJlcGx5IE5BS3MgZm9yIFJETUEvQXRvbWljIG9w
ZXJhdGlvbnMgYmVjYXVzZSBvZiBya2V5DQo+IHZpb2xhdGlvbiBkZXRlY3RlZCBpbiBjaGVja19y
a2V5KCkuIFRoZSByb290IGNhdXNlIGlzIHRoYXQgcmtleXMgYXJlDQo+IGluY3JlbWVudGVkIGVh
Y2ggdGltZSBhIG5ldyBNUiBpcyBjcmVhdGVkIGFuZCB0aGUgdmFsdWUgb3ZlcmZsb3dzIGludG8g
dGhlDQo+IHJhbmdlIHJlc2VydmVkIGZvciBNV3MuDQo+IA0KPiBUaGlzIGNvbW1pdCBhbHNvIGlu
Y3JlYXNlcyB0aGUgdmFsdWUgb2YgUlhFX01BWF9NVyB0aGF0IGhhcyBiZWVuIGxpbWl0ZWQNCj4g
dW5saWtlIG90aGVyIHBhcmFtZXRlcnMuDQo+IA0KPiBGaXhlczogMDk5NGExYmNkNWY3ICgiUkRN
QS9yeGU6IEJ1bXAgdXAgZGVmYXVsdCBtYXhpbXVtIHZhbHVlcyB1c2VkIHZpYSB1dmVyYnMiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1
LmNvbT4NCj4gLS0tDQo+IHYxLT52MjoNCj4gICBGaXhlZCB0aGUgdmFsdWUgb2YgUlhFX01BWF9N
UiBhcyBzdWdnZXN0ZWQgYnkgTGkuDQo+ICAgSW5jcmVhc2VkIHRoZSB2YWx1ZSBvZiBSWEVfTUFY
X01XLg0KPiANCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJhbS5oIHwgMTAg
KysrKystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
cGFyYW0uaCBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmgNCj4gaW5kZXgg
YTc1NGZjOTAyZTNkLi45YzliNWYwZDkyOWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3BhcmFtLmgNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfcGFyYW0uaA0KPiBAQCAtOTgsMTEgKzk4LDExIEBAIGVudW0gcnhlX2RldmljZV9wYXJh
bSB7DQo+ICAgCVJYRV9NQVhfU1JRCQkJPSBERUZBVUxUX01BWF9WQUxVRSAtIFJYRV9NSU5fU1JR
X0lOREVYLA0KPiAgIA0KPiAgIAlSWEVfTUlOX01SX0lOREVYCQk9IDB4MDAwMDAwMDEsDQo+IC0J
UlhFX01BWF9NUl9JTkRFWAkJPSBERUZBVUxUX01BWF9WQUxVRSwNCj4gLQlSWEVfTUFYX01SCQkJ
PSBERUZBVUxUX01BWF9WQUxVRSAtIFJYRV9NSU5fTVJfSU5ERVgsDQo+IC0JUlhFX01JTl9NV19J
TkRFWAkJPSAweDAwMDEwMDAxLA0KPiAtCVJYRV9NQVhfTVdfSU5ERVgJCT0gMHgwMDAyMDAwMCwN
Cj4gLQlSWEVfTUFYX01XCQkJPSAweDAwMDAxMDAwLA0KPiArCVJYRV9NQVhfTVJfSU5ERVgJCT0g
REVGQVVMVF9NQVhfVkFMVUUgPj4gMSwNCj4gKwlSWEVfTUFYX01SCQkJPSBSWEVfTUFYX01SX0lO
REVYIC0gUlhFX01JTl9NUl9JTkRFWCwNCj4gKwlSWEVfTUlOX01XX0lOREVYCQk9IChERUZBVUxU
X01BWF9WQUxVRSA+PiAxKSArIDEsDQoNClBsZWFzZSBjaGFuZ2UgdG86DQpSWEVfTUlOX01XX0lO
REVYID0gUlhFX01BWF9NUl9JTkRFWCArIDENCg0KT3RoZXJ3aXNlLCBMR1RNDQoNClRlc3RlZC1i
eTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KUmV2aWV3ZWQtYnk6IExpIFpo
aWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQoNCj4gKwlSWEVfTUFYX01XX0lOREVY
CQk9IERFRkFVTFRfTUFYX1ZBTFVFLA0KPiArCVJYRV9NQVhfTVcJCQk9IFJYRV9NQVhfTVdfSU5E
RVggLSBSWEVfTUlOX01XX0lOREVYLA0KPiAgIA0KPiAgIAlSWEVfTUFYX1BLVF9QRVJfQUNLCQk9
IDY0LA0KPiAgIA==
