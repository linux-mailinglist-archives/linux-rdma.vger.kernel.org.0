Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831A157FC56
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiGYJ0r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jul 2022 05:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiGYJ0n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jul 2022 05:26:43 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 02:26:41 PDT
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6015A33
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jul 2022 02:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658741201; x=1690277201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PnatpFuIpfXUVeMPx9JUkOAq84ZTh3ApMzBi8EQhAlI=;
  b=y+PhJuLbqkfTqB06BENY0ol5mB1SycLoHeS8s4rc600Z0VGUCCIZd8ps
   /9a/j6cFD4RnVY06z9Bk7UNf1t2dy2IxWZT0/5ddi3DnOIL7iNc/iPsEj
   jT+CHkXDoVyFDr62FW503FOqmWuORrES0NT8Fjcr8O7bqt9endHQm/eg8
   TVR7VovKTBKeo5YfibTiFl8QZ0lU9cGYLbxGgZOOkLztNS5Qv94mQ/edo
   HCzPfUr0/vMLgjLfCyPvC0wbsUhKVbwKn8rdc6L64fQgymQpk4JKgDg84
   lezVLzy63OHKW+B2TvT9sYCHn4krSPYV76q7bC8rmEXF5Z/NsDKmT/Ghq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="60984312"
X-IronPort-AV: E=Sophos;i="5.93,192,1654527600"; 
   d="scan'208";a="60984312"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 18:25:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nje0OehtQadA/uAyUd/iuFY8D82YX8yJczpFPazOG9JFTLSI6VXR0dMtYTuZr3EJRXtcL895rdN/MqlB4ohxtn8QWmAeoeuUYturcq5asTJvxsRxrAUTPlLQ2cpGvyRCBLbgrgFnkWa/NTZ3QV8TVtmtDcqW67sryJKsQhEbFeymn2p0P1NymEgCA/w13USabvDmDEr47k+HwcP1fwSpBa7trRd7txo3Wimxh4NQQ5sL+RAtf8JiRcvHwC8BDqmeI3gecc5yjA5KO9pO/F3Qn3WUWsB5aL7vQktiDSOBzEh49qnePiRztaqGNf7pydcyXg6mZKxJr8KrcecsUxH9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnatpFuIpfXUVeMPx9JUkOAq84ZTh3ApMzBi8EQhAlI=;
 b=ewTIY9hdKKpDfy3ofcBGl4YzaygPlmXfKyPhRMXplaW27BF672V7P2gF0zGEKRmqCnsevmUEo2Ru5WAU5Mzst4xGJnFCW9UyHkoW2GV6/0+LIeGnGx+lxuNXVn2Tl2/SXlvTi1MDn16Q5073ZZBR5NnB+Hl2/oIcVRGGYUWeb7MDd33IdRip8wqgVE/7dU8vEZl77+iNzC6BJPMudb6maxWwh1XJe7H0oe9GQuh+AM1IEYwlAtpTFg9BVsZL/IEKbyWCtYAMkslWzb5YEEn59N1FZDCiePHbmO258hC1MrnmOfVLDmjtnDZxXmAlM7y2yyhpkn9w530QJedQEjgegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB6021.jpnprd01.prod.outlook.com (2603:1096:604:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 09:25:30 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 09:25:30 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
CC:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Thread-Topic: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Thread-Index: AQHYnCKksO3/TjsEbUejYY02ELeZ6K2HFOEAgAJSpACABOeUAIAAEb4AgAB31QA=
Date:   Mon, 25 Jul 2022 09:25:30 +0000
Message-ID: <9e887cf3-723e-2676-dc59-821a89863080@fujitsu.com>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
 <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
 <2b9261f7-8ade-1892-5f71-5e4de13927a4@fujitsu.com>
 <34344e02-fb6f-4ddf-547b-bcbfe81c8e84@linux.dev>
In-Reply-To: <34344e02-fb6f-4ddf-547b-bcbfe81c8e84@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d2b8b86-7f83-47b1-1e60-08da6e1f9e82
x-ms-traffictypediagnostic: OS3PR01MB6021:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGgCEyOrcd49jaiPCvnYrg5RYxwCZoPJrxyHCmO/IVGoZlXxGKfq+HCZA92lYVn3WygsD73fwb0G7xzPwhBL52SCyQrWkuPQFVS47DItJTEMZdgoGzcUFemSfR+67yEP9824BK15k8BgJafWdx6xPZ/1TlCUDld6vZtqY2m1WveSR2KvpU1AhYrTqT5E6+D4mTXp+DpmcmQoA5JJcey6BRyQtd3qjKqRcBwH2vLeBOe/IJRANQAng8Ly7173eBfy2AE41d6UxdgZ+pwAMsxUuQXoyKXb0LeB2rAxTZKzHOr2NiXHuAELKh6OUe1jGVmstXf6LPidx7VYUjiyR1l+xe+vYGF/7cTgJ7UkijPu2D8wPKU6GxAMfcIhRjbzRiS2lI0ZlKUOhr6k0S57Dlzmeiuo3H1r1ci/OozCBS5rQyxoX7sljOTdKcvMhazSINpjwxw3cv64L/vxAkbWmXeIPZwKyoivNevFij1D8B1ZuLmwGR3qsnuYMtdDdsG9DHZE/vKPwGt6o8qYTfbEPCJ01sEoQC5ImgYB1B2OIPO8L2E6LCQFOpE4exA8tddT0nczZs8saEr36w/Tc4PlzqsPVfandWC9MJf60dXvQWEptW0J0jhZ8OmVsSsUaeyR2dSlQsCVvfqZLrH0F183iSmlnlpD2ILrKyF4LQeDVBB91WfQ7d6ufW/P6Qmp7ZjFBP/jWL1S5s7gQVWAXXAloxic7OvYYIKSIcF0Fv4tLCYJPU3x1jvcP/JgCwIxroN50TyHZQh35PenyaaMeBo6xCp1woVmdlakEYgw+dYoSAMn/q4A7iyjEvo4058ZbDdiyV8w9T6wsduqImNiPsjYTA9E6DkQS6DUBQidigwtEkzy9fErDoplvhlFyqbWLg8uLutCUDy8Xdp8Z/4XbRGdlr90BneKo1VCTb9zsoyk9waGZdc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(54906003)(110136005)(316002)(41300700001)(53546011)(6506007)(478600001)(71200400001)(6486002)(76116006)(2906002)(91956017)(66946007)(66556008)(64756008)(66446008)(66476007)(5660300002)(4326008)(8676002)(8936002)(122000001)(38070700005)(82960400001)(85182001)(31696002)(86362001)(36756003)(38100700002)(31686004)(186003)(6512007)(2616005)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZQYmR6YksyK1JaUnIrRkZpdy9ZZm0yU2d0T1k3c3RyUlFHcnN0R2xSaUdl?=
 =?utf-8?B?aU5xMmltdU9uNzFvVEFvMXVKbzhadE5COGJRcVlIdzlCZmI2dXorQTJkdU4z?=
 =?utf-8?B?eExObm1DS1pYcERzVE56VlZaT1VnRjc4MkNrMC9HL0ZZa1ZpY3ZWWVZXUUpB?=
 =?utf-8?B?VjlRNFFwK25Gbk10Y1NjQmxLY0ZaVGRiQ2tvd01vOVpET2VEdk9WRndubWxF?=
 =?utf-8?B?OXlGMHhreVlydnlUOVJuRU5adTNxcmY5T1d5SU0wcjdhSjZVaUU1WVQ4d25C?=
 =?utf-8?B?djZNdXFtZlV4OE5wYzVGMFdGZ0ZwVTV6YktCUTAvcU1vREI3bEZDNlB0QUhB?=
 =?utf-8?B?dFZ5Y052MVAyUFhJZkE4SjU1M2I2YlVWdGdvRGJrSzlSM2xJYVoyMCtabDRM?=
 =?utf-8?B?eDB5QURqNXJta2pvYnBxa1NoYTkzRDkzY3VlYXNOSXAwWXdCR3JNZVE1NEVL?=
 =?utf-8?B?c2ZEOStGellsUzI3MjhGN1hBcXQ5QnJISWVvd2FpU2JLZ0xzMGt0TUtLNnZs?=
 =?utf-8?B?MnhiNHA2bWlHNjNGTzF2bGJ1K0JmTU1sK1dBTnN2SzVQdWNEaXR5VlVtM05Y?=
 =?utf-8?B?OUJzUHBwM2NtdzBsRkY3dld6U3FFdllpUm16SUFENlFGQ2RJYmZHcjBEWUJu?=
 =?utf-8?B?WEI0ajJIb09wR1pCYmsyaXdNT1d5ZzNtYU52UE9sRHFsR2NHSm0zckF6aVNM?=
 =?utf-8?B?anFXKysyN3AyNVJRZWdnYVhqdGU3L2RXb3lyYzgvK0dpZ3Vua2hQbEFnb3hx?=
 =?utf-8?B?VlpCLzArbFVhWXhjYVIvcFVDMGU5NTZWVkk5azAxSGtTMXlSWVMwakd0aXdh?=
 =?utf-8?B?TjNCNHZhUVN6UjlDVzZHUlJDU1VkR0xYY1E2enFoZ0R5dDd0bmZTNHYvRFVD?=
 =?utf-8?B?b05YbmczSzlIQ3d0ZjZWais5QjJubkNqT0tZUU5NTFlXTW4xMSs0ZlZpREFH?=
 =?utf-8?B?SlhiT0R6OVNkY21tNjc3VG9NWnNtaGJBM0s5Qy9FMkNhOVdPU1JicXhzdngz?=
 =?utf-8?B?Qy9Pb2FPVThaSytqUVAvSkJBNlowZTA3SmVCSE1jR2Rzdy8zMjIvMUpXQXNX?=
 =?utf-8?B?empqVjR2OVJTK0ZDY0EyRjAzcFpLdm9sdjhYUkI4M1JwZHZFOXVYME5UMGk0?=
 =?utf-8?B?bU9KalArVFI5bEQyTHZIbWMzTGRFcG12VFR0OStmMzJ3U1YvaVd5VFhia1pU?=
 =?utf-8?B?TnlUMUFZdHVIeWpLWm0vQVRFR0ZDeEFJMnJCTXE1MjJZWXV3QzJ1cDdMN3RI?=
 =?utf-8?B?TU5Ya1RTMndsMldIbkt6MEVJRXptZ08ycktBVjErQXJweHZhN1lxL3NDZUEy?=
 =?utf-8?B?NmRXMWxhSm9ESzVFWjQxNGVmNDRQM2YvcDIyTDFBd3djdUQ2WWxWRzVzaHhv?=
 =?utf-8?B?cmg1WVpDVDZ5TWFjZE8zVEVpY0pocEc1eWZhcGc4VlJSTTkrSDZVa2dKQlpF?=
 =?utf-8?B?amFlR3pwYmZkRjh1Y0t6enhyMWEwM21ZQThNb29IT0hzdFQxaEhENFVzenc3?=
 =?utf-8?B?dkdabEFXRXI1THVPejZkeXVBa1JEdmtJNGV3bk5UVmZOTEZUWkNwM3cyUFRy?=
 =?utf-8?B?cTJpdEI1NnhWVVBJUVJaNDB4czlkSy9DQ243QUlpc21TaGFZQ3NYYndGVUNI?=
 =?utf-8?B?Q01yeEUvQlJlVVAxOEM2cnNCVVo0SXAzeGhhTzdXNDBnKzV0cVJBYnBjYXdR?=
 =?utf-8?B?VDRBOER1ZkgwUW9SV0xZVzViSlQrWkoxYVJ2MnBhQTNqUzcxSVIvNCtTMFR6?=
 =?utf-8?B?NFlEYVdpYUtHdmg4OHdxSDMzcnJYYXpwTVE2Y3E4S0NUL1llS01LREwvbHpo?=
 =?utf-8?B?eXhpai9GWTEyZ3N5RDJpc3BRYmF4Umd3emR2andvSGxWU0hyRC8wZTdmOVR3?=
 =?utf-8?B?TU1HazlNZVN4clFnQjlDK2xYem9yZzZTUDIzVEVNbHE3cjRzUGJjcGdGNEpU?=
 =?utf-8?B?aGV1YTJUKzVxQndVVk1ELzdJelJOY21ManZlQmJzTmxMYkRua3g4Z3l3NWh4?=
 =?utf-8?B?Z3Q2TU1zWHBOanFUL3hHS1NqbUFwSU0zZHY5dXZXNVl0dkZ6cUhaV1ExTTNP?=
 =?utf-8?B?VHRKTERPUFkxeHk4UmFYUHY3SDEreG9yOHdoVkpjYlBiUXdzbU9ySDhyb1JR?=
 =?utf-8?B?bTVnWFRhUUhVMStXNzlNdFRYTk5pN1hqMmhzM2RrdC9hYmRTdjlXaHQza0d4?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBB015D846B79F4696B8C6D0E3A0C71D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2b8b86-7f83-47b1-1e60-08da6e1f9e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 09:25:30.8246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxH2Rt1B0oTdgJ6kAy6QJL9lq08qrnnkRTThdcpkScdUwSQ1NjVbNRBEJJVvUp8QqZzP6URa4pJveXgulWgtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6021
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI1LzA3LzIwMjIgMTA6MTYsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+DQo+DQo+IE9u
IDcvMjUvMjIgOToxMyBBTSwgbGl6aGlqaWFuQGZ1aml0c3UuY29tIHdyb3RlOg0KPj4gT24gMjIv
MDcvMjAyMiAwNjoxOSwgQm9iIFBlYXJzb24gd3JvdGU6DQo+Pj4gT24gNy8yMC8yMiAwNTo1MCwg
SGFyaXMgSXFiYWwgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgSnVsIDIwLCAyMDIyIGF0IDEyOjIyIFBN
IExpIFpoaWppYW48bGl6aGlqaWFuQGZ1aml0c3UuY29tPsKgwqAgd3JvdGU6DQo+Pj4+PiBCZWxv
dyAyIGNvbW1pdHMgd2lsbCBiZSByZXZlcnRlZDoNCj4+Pj4+IMKgwqDCoMKgwqDCoCA4ZmY1ZjVk
OWQ4Y2YgKCJSRE1BL3J4ZTogUHJldmVudCBkb3VibGUgZnJlZWluZyByeGVfbWFwX3NldCgpIikN
Cj4+Pj4+IMKgwqDCoMKgwqDCoCA2NDdiZjEzY2U5NDQgKCJSRE1BL3J4ZTogQ3JlYXRlIGR1cGxp
Y2F0ZSBtYXBwaW5nIHRhYmxlcyBmb3IgRk1ScyIpDQo+Pj4+Pg0KPj4+Pj4gVGhlIGNvbW11bml0
eSBoYXMgYSBmZXcgYnVnIHJlcG9ydHMgd2hpY2ggcG9pbnRlZCB0aGlzIGNvbW1pdCBhdCBsYXN0
Lg0KPj4+Pj4gU29tZSBwcm9wb3NhbHMgYXJlIHJhaXNlZCB1cCBpbiB0aGUgbWVhbnRpbWUgYnV0
IGFsbCBvZiB0aGVtIGhhdmUgbm8NCj4+Pj4+IGZvbGxvdy11cCBvcGVyYXRpb24uDQo+Pj4+Pg0K
Pj4+Pj4gVGhlIHByZXZpb3VzIGNvbW1pdCBsZWQgdGhlIG1hcF9zZXQgb2YgRk1SIHRvIGJlIG5v
dCBhdmFsaWFibGUgYW55IG1vcmUgaWYNCj4+Pj4+IHRoZSBNUiBpcyByZWdpc3RlcmVkIGFnYWlu
IGFmdGVyIGludmFsaWRhdGluZy4gQWx0aG91Z2ggdGhlIG1lbnRpb25lZA0KPj4+Pj4gcGF0Y2gg
dHJ5IHRvIGZpeCBhIHBvdGVudGlhbCByYWNlIGluIGJ1aWxkaW5nL2FjY2Vzc2luZyB0aGUgc2Ft
ZSB0YWJsZQ0KPj4+Pj4gZm9yIGZhc3QgbWVtb3J5IHJlZ2lvbnMsIGl0IGJyb2tlIHJuYmQgZXRj
IFVMUHMuIFNpbmNlIHRoZSBsYXR0ZXIgY291bGQNCj4+Pj4+IGJlIHdvcnNlLCByZXZlcnQgdGhp
cyBwYXRjaC4NCj4+Pj4+DQo+Pj4+PiBXaXRoIHByZXZpb3VzIGNvbW1pdCwgaXQncyBvYnNlcnZl
ZCB0aGF0IGEgc2FtZSBNUiBpbiBybmJkIHNlcnZlciB3aWxsDQo+Pj4+PiB0cmlnZ2VyIGJlbG93
IGNvZGUgcGF0aDoNCj4+Pj4gTG9va3MgR29vZC4gSSB0ZXN0ZWQgdGhlIHBhdGNoIGFnYWluc3Qg
cmRtYSBmb3ItbmV4dCBhbmQgaXQgc29sdmVzIHRoZQ0KPj4+PiBwcm9ibGVtIG1lbnRpb25lZCBp
biB0aGUgY29tbWl0Lg0KPj4+PiBPbmUgc21hbGwgbml0cGljay4gSXQgc2hvdWxkIGJlIHJ0cnMs
IGFuZCBub3Qgcm5iZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+Pj4+DQo+Pj4+IEZlZWwgZnJl
ZSB0byBhZGQgbXksDQo+Pj4+DQo+Pj4+IFRlc3RlZC1ieTogTWQgSGFyaXMgSXFiYWw8aGFyaXMu
aXFiYWxAaW9ub3MuY29tPg0KPj4+Pg0KPj4+Pj4gwqDCoCAtPiByeGVfbXJfaW5pdF9mYXN0KCkN
Cj4+Pj4+IMKgwqAgfC0+IGFsbG9jIG1hcF9zZXQoKSAjIG1hcF9zZXQgaXMgdW5pbml0aWFsaXpl
ZA0KPj4+Pj4gwqDCoCB8Li4uLT4gcnhlX21hcF9tcl9zZygpICMgYnVpbGQgdGhlIG1hcF9zZXQN
Cj4+Pj4+IMKgwqDCoMKgwqDCoCB8LT4gcnhlX21yX3NldF9wYWdlKCkNCj4+Pj4+IMKgwqAgfC4u
Li0+IHJ4ZV9yZWdfZmFzdF9tcigpICMgbXItPnN0YXRlIGNoYW5nZSB0byBWQUxJRCBmcm9tIEZS
RUUgdGhhdCBtZWFucw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICMgd2UgY2FuIGFjY2VzcyBob3N0IG1lbW9yeShzdWNoIHJ4ZV9t
cl9jb3B5KQ0KPj4+Pj4gwqDCoCB8Li4uLT4gcnhlX2ludmFsaWRhdGVfbXIoKSAjIG1yLT5zdGF0
ZSBjaGFuZ2UgdG8gRlJFRSBmcm9tIFZBTElEDQo+Pj4+PiDCoMKgIHwuLi4tPiByeGVfcmVnX2Zh
c3RfbXIoKSAjIG1yLT5zdGF0ZSBjaGFuZ2UgdG8gVkFMSUQgZnJvbSBGUkVFLA0KPj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgYnV0
IG1hcF9zZXQgd2FzIG5vdCBidWlsdCBhZ2Fpbg0KPj4+Pj4gwqDCoCB8Li4uLT4gcnhlX21yX2Nv
cHkoKSAjIGtlcm5lbCBjcmFzaCBkdWUgdG8gYWNjZXNzIHdpbGQgYWRkcmVzc2VzDQo+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgdGhhdCBsb29r
dXAgZnJvbSB0aGUgbWFwX3NldA0KPj4+Pj4NCj4+PiBXaGVyZSBpcyB0aGUgdXNlIGNhc2UgZm9y
IHRoaXM/IEFsbCB0aGUgRk1SIGV4YW1wbGVzIEkgYW0gYXdhcmUgb2YgY2FsbCByeGVfbWFwX21y
X3NnKCkNCj4+PiBiZXR3ZWVuIGVhY2ggcmVnX2Zhc3RfbXIvaW52YWxpZGF0ZV9tcigpIHNlcXVl
bmNlLiBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHJ0cnMuDQo+Pj4gV2hhdCBpcyBpdD8NCj4+IGl0
IHdvdWxkIGhhcHBlbiB3aGVuIHdlIGFyZSBjcmVhdGluZyBhIHJuYmQgY29ubmVjdGlvbi4NCj4N
Cj4gVG8gYmUgYWNjdXJhdGUsIGl0IGlzIHJ0cnMgY29ubmVjdGlvbi4NCg0KVGhhbmtzIGZvciB0
aGUgcmVtaW5kZXIgYWdhaW4uDQoNCg0KDQo+DQo+PiBtb2Rwcm9iZSBybmJkX3NlcnZlcg0KPj4g
bW9kcHJvYmUgcm5iZF9jbGllbnQNCj4+DQo+PiBlY2hvICJzZXNzbmFtZT1mb28gcGF0aD1pcDo8
c2VydmVyLWlwPiBkZXZpY2VfcGF0aD0vZGV2L252bWUwbjEiID4gL3N5cy9kZXZpY2VzL3ZpcnR1
YWwvcm5iZC1jbGllbnQvY3RsL21hcF9kZXZpY2UNCj4+DQo+Pg0KPj4gSSBoYXZlIHRlc3RlZCBi
bGt0ZXN0cyBhbmQgYWJvdmUgcm5iZCBjYXNlLCB0aGV5IHdvcmtzIGZpbmUuDQo+PiBGdXJ0aGVy
IG1vcmUsIHlvdXIgIltQQVRDSCBSRkNdIFJETUEvcnhlOiBBbGxvdyByZS1yZWdpc3RyYXRpb24g
b2YgRk1ScyIgZG9lcyduIGZpeCB0aGUgYWJvdmUgcm5iZCB1c2UgY2FzZS4NCj4NCj4gVGhhbmtz
IGZvciB0aGUgZWZmb3J0ISBJIGJlbGlldmUgcm5iZC9ydHJzIG92ZXIgcnhlIGhhZCBiZWVuIGJy
b2tlbiBmb3IgYSB3aGlsZSwgY2FuIHdlIGFncmVlDQo+IHRoZSBwcm9ibGVtIG5lZWQgdG8gYmUg
Zml4ZWQ/DQo+DQoNClN1cmUsIG9idmlvdXNseSBpdCdzIGEgcmVncmVzc2lvbiBmb3Igcm5iZC9y
dHJzLiBCdXQgd2UgZGlkbid0IHBheSBtdWNoIGF0dGVudGlvbiBvbiBpdCBiZWZvcmUuDQoNCg0K
PiBUaGFua3MsDQo+IEd1b3FpbmcNCg==
