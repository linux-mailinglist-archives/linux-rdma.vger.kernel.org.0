Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847056B2D2
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 08:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiGHGdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 02:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiGHGds (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 02:33:48 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE5237EF
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657262026; x=1688798026;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sGDm003z8tF098GRKPo96Zog6PLwI2grtOgloi8+cBw=;
  b=m0xuWSE4w2PaTh6VTw55dBSgKAE+4n8lQVCeNwKF1lD4cq94XHvpBJpO
   kw0xbN9gd8vBBugeSpkt3H8N/3o3S67z9MmdJou/9DYQUjzb4TFVmLfoB
   I4spVtBOcXv1M+NnPYtcFDIYl4c1YjY3bwmMWkgtTW4jXAg2c7c2yC9LG
   d8ptCbArlEbTKqq14aeMkxcEQPncaGS+vuL7+w2KIwmVZ41SqJi/+m8Cm
   r1nFQNCqgJDWUg/ZRxsuHys6AXhIu5zso2UU4DPpQ7Nug8+cgDj0O3d9G
   7JLeXpoiMYYdxdo6vWNx5m8x6gGJ2IH9wgt0qviO4tDPjvzehUA98/4TO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59587214"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="59587214"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 15:33:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQtLrQSZ2e+dN4EX64FUHYNKHjnvIdKixOzOGPkHMfG3rZYaYcYfRwrZO4G4/jipCOzHPW9WXcdoK008aXvncdLzVZco8jgmxCt1VM4MxGAEOMM/V1qFEZLKMbLbOoqq0K8W0x+kQtwqUqygU6Nwhj3yUxGvrBWdo1foLhn68T2vz3x13QJEUhdpEe+JNlv9BYyiJhVW4l+QrzA1PxC848qnRp5blybv+lpZeNf0Ki8uirNjMisZNLE42gN4E9urTtpViEcDEcnK5jTFpOOlxDTvxrYrbDs0Nk4tuOhUh6PqlkZDr8nd9SwCucYHaJ3DvpmH2pYumOIyCxskbltQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGDm003z8tF098GRKPo96Zog6PLwI2grtOgloi8+cBw=;
 b=eLyoWVQzPIMYC+rEo/GhdeWO8EREvgh9yJDbQ6bJGJfmlbks9R31Nve+q2QvDZ9XZPFlBKji8CdNkjoZ+JY3ZXwWFyRn9/s4pqZTq01cZRjyvKyD/DaJ9w/w6ny3leKVuj/wYDAEgOSKME9Ic9yERFta0f2+rOQySSatublA1oJ2wNt881VoFI1gDX8BxVxR40wOZZwlh93ODwV54PnYy8j+IyZEj0eYug8mJEpkM6fQ0qEUzk6Vv+gUeD6VqP5u8+XPc5bex57Md1WM+hLr7P7lrhvq22WaG+H9gVfYBBddE3QhPaoBq7hunaaGylnelKv051lxmr7nHBcXWe+H9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGDm003z8tF098GRKPo96Zog6PLwI2grtOgloi8+cBw=;
 b=kKNG/U2oxB+fex51vM3OxQeTtJq4bcmu878OXU8JMtkG4PsqtxbZiAQk5VS15iBQpNgfmaeza0uw0khT9sAUkGcIfwDzOgnjft8oiHVIOOTVkST4FDA/ixy9j2Lyu+vz35XqF3PTfVixeentHDZFC/TiAUSy01i9u1uSh3JsY2g=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB9925.jpnprd01.prod.outlook.com (2603:1096:400:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 06:33:39 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 06:33:39 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Process received packets in time
Thread-Topic: [PATCH] RDMA/rxe: Process received packets in time
Thread-Index: AQHYjvV3J3G5jMjYaEKK5RDdGO522q1uLNCAgAAYjICABcYIgA==
Date:   Fri, 8 Jul 2022 06:33:39 +0000
Message-ID: <416a459a-2b27-7538-294c-1f2362a2eb2f@fujitsu.com>
References: <20220703155625.14497-1-yangx.jy@fujitsu.com>
 <20220704125541.GB23621@ziepe.ca>
 <fde68be8-d067-f0d3-b2e9-2226e0e45f7a@fujitsu.com>
In-Reply-To: <fde68be8-d067-f0d3-b2e9-2226e0e45f7a@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2f9432b-63c1-4835-6cb4-08da60abcbb0
x-ms-traffictypediagnostic: TYCPR01MB9925:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIvdFOzH94jnnyyLVY4T6bMnisfPZWfjtPijAnnDCdNPmclGxJD2TIgSmdxp1KHLYCOcdnwSvxKx9Do6RU0Bqlrlylq/cwkXDzmmRW8Pvo6UZ2d+Y0icPHOHrFQiqYyGoxyLEHEsze1imriKaJFfozvaioINd7SFmP+wlQWkjKwqsdUWkdyO+arFKuacgnWOPin8/p8DYFcnYj8oM088CwSqBEKzCnLb5gztg6R507r0pAEIdqL3eDobxUDLqH66WyBf2Hz1cL1qUMwbTzwpFMbDwcI7NM+n3umGv45pwTKAGJGq0GTZxGK05lI5nhBEfQtC/dv1D3Do4g+x/wRjpKf7QQ8iEWVqlckuqhvif0HdkQ4EU2i9tzRKxh9sD73tTJC+Q7hZyGCJjb/v3Giy86NhNQDe+tjRIGR3rOpCO8d7c8qWQ3rCpZ+9/ufnWZ7EI8xcxuSZEftB9snK8d2pukBWQrk8OZdV5+ZZcF3N6XebdMgshhtrTVWAyQ0t0IBz9ZreD3y4BcNZmUyV4fN1PjX6PBcB6OkfEgE+DNq4FgJtg9PtRbLcc5tRofRWtpX9v8hZZyqInot7PweZ0XVIdCVUb4/vRBoXQ9Q0cuSJJrJo/ovvoZF1oG9z4BWjt2OpWGrGd00uPi9Fv0eT2aHQjd3Wjb12DKc3vK9WvK9sXobGUhmof7xrO32xj+2pG7vkOLmIyO0GNXdfkWRhP+wC5aa4llEw+F/ZGg82zIVP0oWTi9qkntB6U0rBTT3lab8WA8qRZBX1H/Od/21BmCjDKErz961yGeWMrR69jq4qxAZYvwR/HpWeQShKaHTkRfx5r1jom8crpq/t8HQAzdYiYPwTsccAYL9QXx7sjvK7jYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6512007)(8676002)(86362001)(66476007)(2616005)(5660300002)(66556008)(64756008)(8936002)(31686004)(66946007)(66446008)(91956017)(6506007)(36756003)(478600001)(2906002)(41300700001)(31696002)(26005)(76116006)(6486002)(53546011)(85182001)(4326008)(186003)(38070700005)(83380400001)(122000001)(316002)(54906003)(71200400001)(82960400001)(38100700002)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eENKaHdId2h2RVJxM3YxSGEzMzhPN3ZyV21yZFQ0M0dHSU1GT1NmM3ZhZ1Bv?=
 =?utf-8?B?ckthOWxsRUxWOFJIdHQyeU1kQUQvRlEzRUYvQk45U3B0bDgrOG5pQmlETVhm?=
 =?utf-8?B?dGZRcU51T3FhbVdjVzh3MzVOeGpmeWY1UUdjYTdxeGhLOXBBelZBaU5GajQy?=
 =?utf-8?B?ZVdhcnFhNWhJSUl2VGRydjlXeFRVekwrdmJnRFlYUDNHN0NSR2w5c0JZcXh2?=
 =?utf-8?B?YzB1ZGl4dHpueVRncHdvNWdQL3lEdEZHdGlPWWhXK1lsOVN5ZjB0Q0FvV09h?=
 =?utf-8?B?SkJuVmRlTHJKdFRVbldBUlZOdExnZ2M1NkwvQUV2V1BFUTNDOUkrd0kybkhU?=
 =?utf-8?B?NlZqUmZmSU4wa29SbW5MaVFFVXdQWnZXUGRpdURCcFdYS0lPbUhQN05kVGNm?=
 =?utf-8?B?STFrT3owZEpsVUhaZkNaZnFjMHhiTllEVy9DVHhjYmVPajIwcnF0c1FXd3Rs?=
 =?utf-8?B?dlVSKzNBQ1o5R1FZRnNoZHdCL0ZqY1JwUmMvOEpLa0FhOHdkN0F6Q3RFZERO?=
 =?utf-8?B?UXhWbWRNZzMzd3h3YVhHYkdQR0xkK1IxKzNIQWNQUmJwTm9EeXlEOUliby96?=
 =?utf-8?B?K2RpQkwyVjFkSWZZL2swbVpHQ3BSZnVSNzRvODVjL05Qdmdtd1YxaXU5Wi9w?=
 =?utf-8?B?RFpUSVRZY2tBZ3FVc0lxbllvQ2F4b1oxSG9rWVFyY2NuYU15SG42MVFudXh5?=
 =?utf-8?B?U2crMGd4TE0wZzNpWmx4eTlUOWgyUHV0Qko2a2hDQzhtVXVOZmdiNmNxNGhn?=
 =?utf-8?B?NnZoMVNkczVUcU5lQ3FCSDFhVmNRcnB6bFZtS0h1U3ptb0xwRlVDY0VYeERq?=
 =?utf-8?B?WWZvNmxiZC8zOWRXNVFHZjM2dHB3cEcyd09uOHFvTVBBM1crdm9pVUFMREVG?=
 =?utf-8?B?VytiQkEvRzRWWlA2VGprWGtJa0hMeWYxcTB4ZENTYzAyV3duemxVbWU3azFR?=
 =?utf-8?B?Z0tzUTRHMU9QK0tYRWovWTViOUtpL3JyNGVRcEFoMThaTXNCRDRMYjdYdzVq?=
 =?utf-8?B?VGlscXhjMlBRWHRoWUxkdmxmbitQSUVoVUN6OGNzbTJ2ajdrKzlwYXlmdm9j?=
 =?utf-8?B?TmtIcTZXU0RycjBnb0NXUVdmQUNhMnd1emNWc2wzdUVYYUhoWHpKZ1lnSlJD?=
 =?utf-8?B?Z1hJMUoyOWlkekxoTzdxZWpPSjBreVFVZnI0MGgvRkRJWjFCM2swcmZYdDNL?=
 =?utf-8?B?K1MyYkhmZVpuNnJIMUxBK0xhb2JGbnkzL09yVEx6eFhIQWdqaEQrVzJEVUpo?=
 =?utf-8?B?UHVaaUgwd0FwQjdId0xGSEx2U0xUaTZ4bDlvZkdwZ0hVZWVJYnQ4TmVkbEFx?=
 =?utf-8?B?WFRONEFMS2pRQk92YnJUVmpST1cwSk9OZlBCRnZsTlJDRWk3L3ZaS0VsNXJ4?=
 =?utf-8?B?c3VRNkFTVWdnWklFQmpSREN1NDVnVjRjc3krc2RDTkpPSVhYdWFuUTV5RkEv?=
 =?utf-8?B?STdvRXE2UzFhZU5zcUhGVFJMdFEwR3N6eWY3TTQzNUZYZURMTDJTdTdvM1V5?=
 =?utf-8?B?SmV4QUltSTc1aXlWOXZnTHpYUngySTlmMENadTFzZnJvaXJjZEMrNFRIeEtK?=
 =?utf-8?B?cTZHb3V4ak45VlVIQ3lLWHV4dzZ0SFp4aHlkN0JaNkFkU3Y1UHBtOUluMXIx?=
 =?utf-8?B?MVFvd3VybWRXdi9Oam1pSGFkaEZBSlRGVUlydjdoWGV6VjdlcnVPYXpHampR?=
 =?utf-8?B?WUZaOXJqbklieW1ZbjR6QTJIcFdYUXQwZmY4VDkxSTFNMXRsSC9RcDVKMVY5?=
 =?utf-8?B?MFJlSGdBeGNyTWd3Uk5rQ0lqYlZNb3ZLQTJRMHJoNFFxT3dmZ2lOZ255UTdF?=
 =?utf-8?B?UVBaNklIQVZuQkttRWV3SEx5dnNiaElrTVZXS0VObnBLR3ZBazN2OGo5cUZs?=
 =?utf-8?B?eEJzU3JiQjVBQlM4MkdQemVoUGdkakVvMWx5cDBNdjJadzNBV3Faak4rUll3?=
 =?utf-8?B?NWFpc2FoeGs3d2xjK1JXa1RsWGxkN00zWkJSRG5sSC8xcVExSndPTnFWWjAw?=
 =?utf-8?B?OGM2VFc1V3Zla1Y0WUpOZk0wTW04cHFkZFRMRWZYbWt4TENnbGJ0ZElhNFJD?=
 =?utf-8?B?RzJ0S3BxSkJXQ21mRVl5RmhrMHhLV2RsZnJqVjVQTkdXMEhUWU1oa1Q5RkZD?=
 =?utf-8?B?d2x3KzBRVjhYTFZLZFpVWks5ZEFZc0JBM3IxeGp0OGlzOXZjOHJNazJIWk8z?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D44F48608411E1449C2E28C616F0231D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f9432b-63c1-4835-6cb4-08da60abcbb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 06:33:39.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DzLgn+9nHGSmb68TVtKMRLKioMLQaLhCyz83VoJHQ+wh0S0PIcpk3J7WugYqPPfe+CH7ZV1MZJgrPfhAu9v2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9925
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzQgMjI6MjMsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3RlOg0KPiBPbiAyMDIy
LzcvNCAyMDo1NSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4gT24gU3VuLCBKdWwgMDMsIDIw
MjIgYXQgMTE6NTY6MjVQTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPj4+IElmIHJlY2VpdmVk
IHBhY2tldHMgKGkuZS4gc2tiKSBzdG9yZWQgaW4gcXAtPnJlc3BfcGt0cw0KPj4+IGNhbm5vdCBi
ZSBwcm9jZXNzZWQgaW4gdGltZSwgdGhleSBtYXkgYmUgb3Zld3JpdHRlbi9yZXVzZWQNCj4+PiBh
bmQgdGhlbiBsZWFkIHRvIGFibm9ybWFsIGJlaGF2aW9yLg0KPj4NCj4+IEkganVzdCBtZXJnZWQg
YSBidW5jaCBvZiBmaXhlZCBmcm9tIEJvYiBvbiBhdG9taWNzLCBkbyB0aGV5IHNvbHZlIHRoaXMN
Cj4+IHByb2JsZW0gdG9vIGJ5IGNoYW5jZT8NCj4gSGkgSmFzb24sDQo+IA0KPiBEbyB5b3UgbWVh
biB0aGF0IEkgc2hvdWxkIHVzZSBSRE1BIGZvci1uZXh0IGJyYW5jaCB0byBjb25maXJtIHRoZSBp
c3N1ZT8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgQm9iJ3MgcGF0Y2hlcyBjYW4gc29sdmUgdGhpcyBw
cm9ibGVtIGJ5IGNoYW5jZSwgYnV0IEkgd2lsbA0KPiB1c2UgUkRNQSBmb3ItbmV4dCBicmFuY2gg
dG8gdGVzdCB0aGUgaXNzdWUgb24gbXkgc2xvdyB2bS4NCkhpIEphc29uLA0KDQpJIGNvbmZpcm1l
ZCB0aGF0IHRoZSBmb2xsb3dpbmcgcGF0Y2ggYXZvaWRlZCB0aGlzIGlzc3VlIG9uIG15IHNsb3cg
dm0uDQpjb21taXQgZGMxODQ4Mzg4MTM3ZDIwZTU3ODZiOTc2Y2FhNDlhMjY4ODlmMzZmMw0KQXV0
aG9yOiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KRGF0ZTogICBNb24gSnVu
IDYgMDk6Mzg6MzcgMjAyMiAtMDUwMA0KDQogICAgIFJETUEvcnhlOiBNZXJnZSBub3JtYWwgYW5k
IHJldHJ5IGF0b21pYyBmbG93cw0KDQpJIHRoaW5rIHRoaXMgaXNzdWUgaXMgcmVsYXRlZCB0byBy
ZXMtPmF0b21pYy5za2Igd2hpY2ggaGFzIGJlZW4gcmVtb3ZlZCANCmJ5IHRoZSBwYXRjaC4gSG93
ZXZlciBJIGFtIHN0aWxsIGNvbmZ1c2VkIGFib3V0IHdoeSByZXMtPmF0b21pYy5za2Igd2lsbCAN
CmJlIG92ZXJ3cml0dGVuL3JldXNlZCBhcyBteSBjb21taXQgbWVzc2FnZSBkZXNjcmliZWQuDQoN
CkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBYaWFvIFlh
bmcNCj4+DQo+PiBKYXNvbg==
