Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F565FE706
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Oct 2022 04:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJNCfx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 22:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJNCfg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 22:35:36 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB3686FB7
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 19:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665714931; x=1697250931;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aRybgvnmRQSRbDeKwMw2y25uNcUjb7B5DPua6sIRGfU=;
  b=iC7KfeJJhZrYHzsNRKEESnG4De+L3xRai31shQhGxpe2O41TUMmAMAcW
   R6d8ZGgbtjz6jAolyh9TaeZVigL9wai5Z7qZ0PdSNAAQwkRo8L5xFtjgZ
   anjWDscAhB+Z+DL2rAfx8feqokeCAf/YEd7oQEfhvSG/pfYtc3tvGTOoT
   s/lcwQHlXQ+Q1ia2vBw1b7xoZj8lxAh5c4THZko58wWwUAugXwP1QLnkq
   urbPprX4JuB/O1OQMqC4OivsOu5FWc+GuLp/wPzqcXXKxP6aL9DrK65v9
   0O5n17LZgnGrGC/obuuqQ5hsShXu89IC+AYCEdaUhUUL9kyRbXjNDV64t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="67541094"
X-IronPort-AV: E=Sophos;i="5.95,182,1661785200"; 
   d="scan'208";a="67541094"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 11:35:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CevlVW+t/6WnXV5Wygaox6GC7kSMbPBe/nChgN9r/gDnWqQEu0llnO4ca0MWyj7LwqQSYtUiM2DXVws5hnecGSSRPaN7OeTYVb0Me3I3yEOYeXMxdlqcXSH4EK9AsebOv6hn/I7GUcerJrAO6da6VO2Hudz1tbmfUlehPw7QdPGHqbC2X7PxLbHHUOQshPtnZGugtFPTMtzO0bqdYY8lEZgonpLnojHlzwFZ8AaatxN3USy781M4nfjfrnX91oIfFOf1q5DGNWURpPd7mLYilAfv81KOR/VC5NpVmyiNuT/dzWYFtYLZ7jOgd/JOaFW327Tjq2EqIEvYxVyWeu0ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRybgvnmRQSRbDeKwMw2y25uNcUjb7B5DPua6sIRGfU=;
 b=TThPJtUx9y+OVpsyoJzVu+fxzMsCNfSiUrSkEXWIcS8iv2Z9p+j+60N+cZNnv07IOjzXUlvvErtjxiV5JBIOceraHBpwAExF1tsmewHL9k/wry4ZUIXSoJQ02XkeHaWc2P5Wl/pKjo8ojapEO8rtJ2akiC54o8+9rMNosqHVhOKgg0Xs9AgDrzwnAdK3+MJmoG1x/Lfn71cb6Sztz1OuuM1arsU2uy40Ohrl2m92R5YT8rTT4DiHK/6nkOYXjAKiy/tpUJ9ZEhXPzj2obMGyGmstRJs9EbkXHM4C08sjOkWB8oiiachBWB/+xhtd0zSMr///d9v1XiCl9nHc53PIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB8913.jpnprd01.prod.outlook.com (2603:1096:400:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 02:35:08 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272%2]) with mapi id 15.20.5723.022; Fri, 14 Oct 2022
 02:35:08 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [PATCH 2/2] RDMA/rxe: Handle remote errors in the midst of a Read
 reply sequence
Thread-Topic: [PATCH 2/2] RDMA/rxe: Handle remote errors in the midst of a
 Read reply sequence
Thread-Index: AQHY3qXec7yYAb2jwkmEqwjesoq8RK4LziKAgAAPqhA=
Date:   Fri, 14 Oct 2022 02:35:08 +0000
Message-ID: <TYCPR01MB8455D4422E8BC3D53ADE32C3E5249@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221013014724.3786212-1-matsuda-daisuke@fujitsu.com>
 <20221013014724.3786212-2-matsuda-daisuke@fujitsu.com>
 <bd695f2f-b2d2-02ef-bc4d-ba64e5cc59f9@fujitsu.com>
In-Reply-To: <bd695f2f-b2d2-02ef-bc4d-ba64e5cc59f9@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 2c8bfc30b381472faf7cc8239b6ff72e
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTAtMTNUMDc6MDk6?=
 =?utf-8?B?MDlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD04NmZiYzY1NS00NTEzLTQ4YjYt?=
 =?utf-8?B?YThkYy0yYmI4Y2JmMTgwZDY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB8913:EE_
x-ms-office365-filtering-correlation-id: 588c09d5-8349-4162-9650-08daad8cb600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: quUDPz738jK6d/UlASPh2e476FnBUNBnhIuBCWZ4Tx4z1bfFpZ74NzMjYxKYPPsZdad6waqveFMJ8N3j9+1GcyQxDAn7iOJ0ZJArTE+DX8ppIdQvp+tHiJV8TsGvLfXNy04PmWbJfuygguTMO/NSBBFspUJiHSNFsJPKhpNQNMVDUQx0t76F2ynErVeH+wslZRFpFoM+T85ld2tCBDy69K4jyFFoc+DWPkedtQRkifk4suKixTJkWPol7dbat1LCLDn5r0cDmfB93kh9XMyg8oz73MXzat6iIouYEv8IhDMvkVwjPBQUv6EuYwG3gvYquR+6Vj26JcVIYBGDLxaJKOdOrFSFjDKVriIheBVgKEcaAnk6v7WsfvkNgwyHxL/6QV46s2J3BSzRe+jLUmR21S/CTo3UR6rjx4w43JA5Wey2NB+SBrSUbc5FLUn3ER6MmJmgagzkDAzjb1qmqak5XK/QB22yuW58Gl513huTMs+UdsFG8NXR7izA2qIDpwo3wsabwjDvjef774My/sPgrOv0xlJ2zulhg/xlgRHpifNSSKE+kdkrIaP9pJGzQ9VsIdnXnAZuctGFIpNkYexhow9CDyp3p7OGB/gDyMpXek88gjmVhtP6YzNwYcdehq4uN1I5w9VRRsX5ODykNNTzn+R5Nf00K/KWm/88anPETJF9aRzAiIAxpL2+i0KSImBXnLxK7F2qhxBgnZrkNLabekyn2AztVUgQZINdAy5A+Je+Mje84ba6gANsHUNxcYzaEL8/dgkedLhbe6t15vNakSOyFpEpuvkmrB5O/1zwdSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199015)(1590799012)(53546011)(26005)(85182001)(66556008)(83380400001)(86362001)(38100700002)(110136005)(7696005)(64756008)(8676002)(66476007)(66446008)(66946007)(6506007)(76116006)(82960400001)(2906002)(33656002)(5660300002)(9686003)(8936002)(41300700001)(52536014)(55016003)(316002)(186003)(71200400001)(478600001)(122000001)(1580799009)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1NhTndoMXhycXcxc09uOXA1WU1IbWdyVlVXSGtNbE9QMHJOUCt6dFJoZGgr?=
 =?utf-8?B?ZjgzYzhOckd4L0ZEUGlDVFRiQ29ncnVJejZvSStXNEl1ay9XdXZJOTd6dG8w?=
 =?utf-8?B?K1VVQ2xSQ3A0L2JRR3hRZzM3TmhVaXFYa0FxMzBWd3VpNUxyZzljZWQ0azNZ?=
 =?utf-8?B?bG1tdFpWOGtwRS83dTBHUVprcm83WnFFMHdnazhlU0Q0bjNVanhGR2RxcGpJ?=
 =?utf-8?B?VkpNaE1qK1hXZDZESUVhSzM2QUozQ3VEejdQTTNScE0yYlRScmk3ZnhTdDUw?=
 =?utf-8?B?dEZqWmpEbzRpOHY2bjNnVHZ4ZTUrVlV4QmV0MWlmVU5RbFdheCtBbVJ2MjYx?=
 =?utf-8?B?Y3d4QXhoSVlxZHlSQVBEUCsyZk5oZkdGc0thSHpDT0tMODJaaXlmRlc2KzFM?=
 =?utf-8?B?a1hlM05pTGdzVTdnd2ZMK0tsZGtGdk40elUvRWpDYUFrMXA2cEFzN00vOS84?=
 =?utf-8?B?dzhkY2JaeXlvR3YyQzhxRXp1aEFrWGxPTktXMmQ3SmlZM0k1dk9Rc3BKUmhr?=
 =?utf-8?B?QnVncStDeU9ybXdUZWhTK3RWY0VBcDcwM0hZeVpwK2M2dU5mNGE1S1RoQlgz?=
 =?utf-8?B?d256Z2NoNnlwMU5ZM0VWdUlkRUViaWlvdzdBbGRpUS93L2VrSFNzMXk2Yjd5?=
 =?utf-8?B?bkQxVW1zRVNGelp6d1JPQU1zZzZCS2xkY0VYbXV6bVlLWVBhSzY2dzVMd29D?=
 =?utf-8?B?TlE0dHo4bGhWMTVJOWxjSjh5ZDltZWxieDcra1lDcTE1R25iUW8wMThuOVVP?=
 =?utf-8?B?alk2djNoQUVXT0trb1lldlVJTGg5RWdRcVZqWDB4OUprQVJoSlpISFV4S3BN?=
 =?utf-8?B?NkFya3Z6YmpXSTJYeEdyakF0RUNVeFR6L051S0F4Sms4NXYyS3pkbmVockth?=
 =?utf-8?B?dVJwR0E2NXhCdXNpQkEwNkNpQWUvZmorblYycXp5NStZMzlZWUNvcWlucHgy?=
 =?utf-8?B?Q3FYOXhoNkJteG8zNUF0dThtcG5MZDB2MklQcVNLY2ZVVGVOZUdDd2p5dEk4?=
 =?utf-8?B?dnlXTTRXRS90ZGx3UVF1T3Z0ZmU4Z2FPbitOMEExWW1QUVN0cytOem1YSmRz?=
 =?utf-8?B?SGUxUVhKSGtCOWZTc0V6K0x0V3p0ZGd0RVZhM2RBV254d2lkUUhxcEdvTTlw?=
 =?utf-8?B?bUY1ZXAvcTkyVi95dEtNNzFiZDNrVkM5V1pLMSs2Q1FDa1h5cEJmUWRrR0xp?=
 =?utf-8?B?VU1FeWhzZkhpZUVvbnBzd09LMEttblVyV0dXbStTVFBqZWN4ZUFFVTEzc0kx?=
 =?utf-8?B?SVRKdEtmU1FnL3Z0TnUwZFBkQjJSOWM4RkNRaVRRaCt3aXZwWFBDMFBZdEU3?=
 =?utf-8?B?ZC9yNy8xUXR2YWJ0a2QrbVlhY09mdktreW4rRDZRYXFjZTFDbVRYcFZlNkNw?=
 =?utf-8?B?R0V1WkRMaTB3eDdTY3IwS0pnRXRxdGpRc1FjdVNpamVua3hQSzVKWHE0bmNt?=
 =?utf-8?B?ZVQyRXBKc3RTUEtXZktWVGZsUmFBS2pQaUcyNkZPQjBOdnNBaFhTUTNZZlps?=
 =?utf-8?B?SmM5UHQ3MkdlTGc3SmdSaVh2N2pITkNGbWFLYTFJNUR0ZEF1aDgydyt2clM0?=
 =?utf-8?B?eUQ0WER5VGxLK25IT1ZaR0F5MkpPMkExd09qNEJZTjF1c01JQ1FLL0dmWUti?=
 =?utf-8?B?NU1EUWh2T0JRUFZ2RVMwQUUyMzdmTkFmLy9OT3AwOEIycFc5cXVSeWJqUU5V?=
 =?utf-8?B?M3VXSG9WZ1A3WmxxQkFPeHRWN0hveEZqMS9HOEt3WlFpellyaEV2ZWwyaEp6?=
 =?utf-8?B?U1lONW5SWkFTUFZrSFVJVkxPVzYzZW4zM0tMeUh5eWVBcjRIRXBmdk5SRHVU?=
 =?utf-8?B?VUNXekptWHBKaFVxcjFXVnVXdXUvL0F0L0VXWER4QzU2RW94Qkw3WlFRVmFU?=
 =?utf-8?B?bWlldjlKYnk5Y3pzUmsxcHRyckdzKzZNMVVhSHZBNnRNTXd3WjVxckN2SGd2?=
 =?utf-8?B?aHRtOFpjTXQzbEZOUUtCWFNuMU1Yekdvb2RUZWZVWk9NSHFGUVFZSzlySFM5?=
 =?utf-8?B?Um1ScHVLTWhtRlNWNGsvWWpaWEZoc21peHFiOC8yTmcvOHlKMGp3c244dGhq?=
 =?utf-8?B?RWdPK2xDbmdrR1NkcG9HVjBGTllZWGYxM05OYjNBOGZKTXJQUUtKajBIclVP?=
 =?utf-8?B?Nnh2UHo1RUtUVVI0U0EwT0NyS2JzSThvMUtkZ1dRQWJCa3BkcWJtMnY2UnU2?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588c09d5-8349-4162-9650-08daad8cb600
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 02:35:08.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7SLZVzsExs/NN4dn5c+b6yzgL6STfUAetuLqyYjbNtpljdKubCMyBvnhgbqo4mB+AhqVXTh3iMG4w5AVPXvzZg2zRKqBxuTGRts9G9Hb7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8913
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBPY3QgMTMsIDIwMjIgMjozNiBQTSBMaSBaaGlqaWFuIHdyb3RlOg0KPiBPbiAxMy8x
MC8yMDIyIDA5OjQ3LCBEYWlzdWtlIE1hdHN1ZGEgd3JvdGU6DQo+ID4gUmVxdWVzdGluZyBub2Rl
cyBkbyBub3QgaGFuZGxlIGEgcmVwb3J0ZWQgZXJyb3IgY29ycmVjdGx5IGlmIGl0IGlzDQo+ID4g
Z2VuZXJhdGVkIGluIHRoZSBtaWRkbGUgb2YgbXVsdGktcGFja2V0IFJlYWQgcmVzcG9uc2VzLCBh
bmQgdGhlIG5vZGUgdHJpZXMNCj4gPiB0byByZXNlbmQgdGhlIHJlcXVlc3QgZW5kbGVzc2x5LiBM
ZXQgY29tcGxldGVyIHRlcm1pbmF0ZSB0aGUgY29ubmVjdGlvbiBpbg0KPiA+IHRoYXQgY2FzZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERhaXN1a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtl
QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+IEZPUiBSRVZJRVdFUlM6DQo+ID4gICAgSSByZWZl
cnJlZCB0byBJQiBTcGVjaWZpY2F0aW9uIFZvbCAxLVJldmlzaW9uLTEuNSB0byBtYWtlIHRoaXMg
cGF0Y2guDQo+ID4gICAgUGxlYXNlIHNlZSBDaC45LjkuMi4yLCBDaC45LjkuMi40LjIgYW5kIFRh
YmxlIDU5Lg0KPiA+DQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9jb21wLmMg
fCA4ICsrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jDQo+ID4gaW5kZXggZmIwYzAwOGFm
NzhjLi5jOTE3MGRkOTlmM2EgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfY29tcC5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
Y29tcC5jDQo+ID4gQEAgLTIwMCw2ICsyMDAsMTAgQEAgc3RhdGljIGlubGluZSBlbnVtIGNvbXBf
c3RhdGUgY2hlY2tfcHNuKHN0cnVjdCByeGVfcXAgKnFwLA0KPiA+ICAgCQkgKi8NCj4gPiAgIAkJ
aWYgKHBrdC0+cHNuID09IHdxZS0+bGFzdF9wc24pDQo+ID4gICAJCQlyZXR1cm4gQ09NUFNUX0NP
TVBfQUNLOw0KPiA+ICsJCWVsc2UgaWYgKHBrdC0+b3Bjb2RlID09IElCX09QQ09ERV9SQ19BQ0tO
T1dMRURHRSAmJg0KPiA+ICsJCQkgKHFwLT5jb21wLm9wY29kZSA9PSBJQl9PUENPREVfUkNfUkRN
QV9SRUFEX1JFU1BPTlNFX0ZJUlNUIHx8DQo+ID4gKwkJCSAgcXAtPmNvbXAub3Bjb2RlID09IElC
X09QQ09ERV9SQ19SRE1BX1JFQURfUkVTUE9OU0VfTUlERExFKSkNCg0KSGkgWmhpamlhbiwNClRo
YW5rIHlvdSBmb3IgdGFraW5nIGEgbG9vay4NCg0KPiBXaGVuIElCX09QQ09ERV9SQ19SRE1BX1JF
QURfUkVTUE9OU0VfRklSU1Qgb3IgSUJfT1BDT0RFX1JDX1JETUFfUkVBRF9SRVNQT05TRV9NSURE
TEUgd2lsbA0KPiBiZSBhc3NpZ25lZCB0byBxcC0+Y29tcC5vcGNvZGUgPw0KVGhpcyBoYXBwZW5z
IGluIHJ4ZV9jb21wbGV0ZXIoKS4gVXBvbiByZWNlaXZpbmcgYSBSZWFkIHJlcGx5LCAnc3RhdGUn
IGlzIGNoYW5nZWQgaW4gdGhlIGZvbGxvd2luZyBvcmRlcjogDQpbICAxMDEuMjE1NTkzXSByZG1h
X3J4ZTogcXAjMTcgc3RhdGUgPSBHRVQgQUNLDQpbICAxMDEuMjE2MTc0XSByZG1hX3J4ZTogcXAj
MTcgc3RhdGUgPSBHRVQgV1FFDQpbICAxMDEuMjE2Nzc2XSByZG1hX3J4ZTogcXAjMTcgc3RhdGUg
PSBDSEVDSyBQU04NClsgIDEwMS4yMTczODRdIHJkbWFfcnhlOiBxcCMxNyBzdGF0ZSA9IENIRUNL
IEFDSw0KWyAgMTAxLjIxODAwOF0gcmRtYV9yeGU6IHFwIzE3IHN0YXRlID0gUkVBRA0KWyAgMTAx
LjIxODU1Nl0gcmRtYV9yeGU6IHFwIzE3IHN0YXRlID0gVVBEQVRFIENPTVANClsgIDEwMS4yMTkx
ODhdIHJkbWFfcnhlOiBxcCMxNyBzdGF0ZSA9IERPTkUNCidxcC0+Y29tcC5vcGNvZGUnIGlzIGZp
bGxlZCBhdCBDT01QU1RfVVBEQVRFX0NPTVAsIGFuZCB0aGUgdmFsdWUgaXMgcmV0YWluZWQNCnVu
dGlsIGl0IGlzIG92ZXJyaWRkZW4gYnkgdGhlIG5leHQgaW5jb21pbmcgcmVwbHkuDQoNCj4gSSB3
b25kZXIgaWYgIihwa3QtPm9wY29kZSA9PSBJQl9PUENPREVfUkNfQUNLTk9XTEVER0UpICLCoCBp
cyBlbm91Z2ggPw0KSSBhbSBub3QgdmVyeSBzdXJlIGlmIGl0IGlzIGJldHRlci4gSSBhZ3JlZSB5
b3VyIHN1Z2dlc3Rpb24gaXMgY29ycmVjdCB3aXRoaW4gdGhlDQpJQiB0cmFuc3BvcnQgbGF5ZXIs
IGJ1dCBSb0NFdjIgdHJhZmZpYyBpcyBlbmNhcHN1bGF0ZWQgaW4gVURQL0lQIGhlYWRlcnMuDQpX
ZSBtYXkgbmVlZCB0byB0YWtlIGl0IGludG8gY29uc2lkZXJhdGlvbiB0aGF0IFVEUCBkb2VzIG5v
dCBndWFyYW50ZWUgb3JkZXJlZA0KZGVsaXZlcnkgb2YgcGFja2V0cy4NCg0KRm9yIGV4YW1wbGUs
IHJlc3BvbmRlciBjYW4gcmV0dXJuIGNvYWxlc2NlZCBBQ0tzIGZvciBSRE1BIFdyaXRlIHJlcXVl
c3RzLg0KSWYgQUNLIHBhY2tldHMgYXJlIHN3YXBwZWQgaW4gdGhlIGNvdXJzZSBvZiBkZWxpdmVy
eSwgYSBwYWNrZXQgd2l0aCBvbGRlciBwc24gY2FuDQphcnJpdmUgbGF0ZXIsIGFuZCBwcm9iYWJs
eSBpdCBpcyB0byBiZSBkaXNjYXJkZWQgYnkgcmV0dXJuaW5nIENPTVBTVF9ET05FIGhlcmUuDQoN
CklmIHdlIGp1c3QgcHV0ICIocGt0LT5vcGNvZGUgPT0gSUJfT1BDT0RFX1JDX0FDS05PV0xFREdF
KSAiLA0KSSBhbSBhZnJhaWQgdGhlIHN3YXBwZWQgQUNLcyBtYXkgZ28gaW50byB3cm9uZyBwYXRo
LiBUaGlzIGlzIGJhc2VkIG9uIG15DQpzcGVjdWxhdGlvbiwgc28gcGxlYXNlIGxldCBtZSBrbm93
IGlmIGl0IGlzIHdyb25nLg0KDQpUaGFua3MsDQpEYWlzdWtlDQoNCj4gDQo+IFRoYW5rcw0KPiBa
aGlqaWFuDQo+IA0KPiANCj4gPiArCQkJcmV0dXJuIENPTVBTVF9DSEVDS19BQ0s7DQo+ID4gICAJ
CWVsc2UNCj4gPiAgIAkJCXJldHVybiBDT01QU1RfRE9ORTsNCj4gPiAgIAl9IGVsc2UgaWYgKChk
aWZmID4gMCkgJiYgKHdxZS0+bWFzayAmIFdSX0FUT01JQ19PUl9SRUFEX01BU0spKSB7DQo+ID4g
QEAgLTIyOCw2ICsyMzIsMTAgQEAgc3RhdGljIGlubGluZSBlbnVtIGNvbXBfc3RhdGUgY2hlY2tf
YWNrKHN0cnVjdCByeGVfcXAgKnFwLA0KPiA+DQo+ID4gICAJY2FzZSBJQl9PUENPREVfUkNfUkRN
QV9SRUFEX1JFU1BPTlNFX0ZJUlNUOg0KPiA+ICAgCWNhc2UgSUJfT1BDT0RFX1JDX1JETUFfUkVB
RF9SRVNQT05TRV9NSURETEU6DQo+ID4gKwkJLyogQ2hlY2sgTkFLIGNvZGUgdG8gaGFuZGxlIGEg
cmVtb3RlIGVycm9yICovDQo+ID4gKwkJaWYgKHBrdC0+b3Bjb2RlID09IElCX09QQ09ERV9SQ19B
Q0tOT1dMRURHRSkNCj4gPiArCQkJYnJlYWs7DQo+ID4gKw0KPiA+ICAgCQlpZiAocGt0LT5vcGNv
ZGUgIT0gSUJfT1BDT0RFX1JDX1JETUFfUkVBRF9SRVNQT05TRV9NSURETEUgJiYNCj4gPiAgIAkJ
ICAgIHBrdC0+b3Bjb2RlICE9IElCX09QQ09ERV9SQ19SRE1BX1JFQURfUkVTUE9OU0VfTEFTVCkg
ew0KPiA+ICAgCQkJLyogcmVhZCByZXRyaWVzIG9mIHBhcnRpYWwgZGF0YSBtYXkgcmVzdGFydCBm
cm9tDQoNCg==
