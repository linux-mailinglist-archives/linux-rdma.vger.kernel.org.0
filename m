Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8850A66B580
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 03:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjAPCLj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 21:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAPCLh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 21:11:37 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C4527A
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 18:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1673835097; x=1705371097;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5TA1GxNGZPUzvJUmiQtNL8rbSCd6Venu2meZPjgzW/A=;
  b=qRn9vf7WPer2I18VAru16fxUdCZfI3p0eeWLL317Bc6d0ATNbxu5mUnw
   fquNhfpuvO83Sc0oJWf88HKK6QG6kr6706VkP2n03z95kGAMsqbGHK357
   83a76UFJQo8l32GE3E0q3QOuDjY1lceQ7RjO5xjET2aOrzvJLmFaNUQfM
   IVnSDayy+Qnrz9QG23BIIs3to/JA88m3PWqJWnei362kj3WbghjXNGNy0
   e8Nkv2VEq8ihfIbKO+Q1mFkppAa1qzZdJwaQzYyacnfXwPA38vYBEOQhw
   UnRx99C7Y8FPKrqVIXFM9IXeMXF9FnkCK7LdikG2M3Qbl3i58Dy7yb1Nt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="74269960"
X-IronPort-AV: E=Sophos;i="5.97,219,1669042800"; 
   d="scan'208";a="74269960"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 11:11:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6QEBciZI7A0WOjO6zDK+qjvrKxoB9s/OhyrObBwm8Dr7I43dxJ/FgYt/5i4lDgesWZrlpGR4ds7PWe4xUXHkWT5Wg5iZloA6DOrMTT9qmwIiNydEU0DNOXOOnGmjfMtaBaM/YsslLZmpzf9CPVnCX27A2YWMRxMgMixQe/fJ4gF0m/CzNA8ORFFi5kfSUGG3dGX7WhbjI2t3LNY3DuFjmX1Kaj0v7KWJ1/vrGYM0Sp03J+ialtaTjgO8IC6q1k2WXs9hWbXBns0zJ3K3wZutDwKQOJKTtjbv88Z4EjtroVtErMLSZJ91RbpT/LfY/5253gmCxYBOucw57yYl8pCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TA1GxNGZPUzvJUmiQtNL8rbSCd6Venu2meZPjgzW/A=;
 b=V0tg2oDAGwLQhKKioCsdWd+zazJtmIPY0rrsauaBfGwg1UaviJvPjbqTN0Y5+3MWVD+UXiJNCsf/1rRuMWcY1NB8xNx+0Unit3tWkKNW0AoDrX07MH8uxuKQTGIDfpo0BBfPJAPtoLTfXeRfUHhJ4n0Vqwf95gwIzwgIThKAlu5X7F6MnGl4Nh1PMwtuR3PglwjuuhPIcugWO9fHC1kiW0OvHPph3FPU76N8ovGO+W49xlDfvbUeHjLvrJo3KSOrgp0dc8UKOFUoXmBhPXeGiCEky622HOH8EoKjfAsQjoaeqR52vO40tjz/fSUEdZgkDVYy8wNGLx9wgF8sm+8ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TY3PR01MB9667.jpnprd01.prod.outlook.com
 (2603:1096:400:22a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 02:11:29 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 02:11:29 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Thread-Topic: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Thread-Index: AQHZJ6azguyncb4X/0aMxhRLqzBBca6gUGEA
Date:   Mon, 16 Jan 2023 02:11:29 +0000
Message-ID: <7ab5a35c-7909-7302-8ce0-79d24a3f6592@fujitsu.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
 <20230113232704.20072-5-rpearsonhpe@gmail.com>
In-Reply-To: <20230113232704.20072-5-rpearsonhpe@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TY3PR01MB9667:EE_
x-ms-office365-filtering-correlation-id: e213bc8a-b799-4242-50b4-08daf766fad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dae9u6rV/DyWnZ3c2IaouepkF/psRYerP81S2zjsHAiFZDAqV0Xjuh2vXx7NcXEf7KiVe9U9bXt9jSiLxNXM/ZAf5JGtjVB+wsFbl0y3I7dLxUTFnqnTOgZ955sXIjIR0/7gKl25SuN9Ec6rKzu6csK3worJx3x3BrVyEJ8jt6aMkv70oyhmwGG0oQN8/h1UpUdzHEjhZGAMmzr+fdmmKpqxf6ol1qE21OhlNZmB59wGqH3qOTmbgQKHBxCjXH/ThOeWZLYqQFb1/CD80fZye+wvFIwZX/8mfahsYss6rJwQX8vSAljySTUFqNWU/FsaiWbpY+c25cbRxQedjMenRaCIKYi4zVilOZVKruZ2ROO6JwXjheJGhVTdRMO+U15+VLwGGCJYI7Fk9gx02tcN9XVx2cxlXDm56AxYEpQuWrL7Y8G7Bf9XfZ5ob9uZxAKUFy60OxxoEuTpwYqp3s3RP8mm3n9ICzujN0oIxg35VKwG87Ny32r2NQ5KPWn6Khwar+D0sGYjxV42czoF6iGeRLmHjDyqYygFQ9Jowbo1eIe+nbcU9HYlEcDHtv8Cm+U+gzaPczrEdwgvJvwGJAo53KroSngcXPWBfMagyRLeZ5TpHgTfMe9TGQr0UcyEjNzArRH0Rczy83sJGlPHpzMWq9v051Lc2DmlQ8B0Ni2n7AZGGG5ocq5EamcImK9WdM7HVDcRgyN01Ww+QWTDBbhq5OzgE8h9GfOhABtTk1KAdD0n25rHNv8ptnmJCkoj+lUsmUM5UKKa3ne0/Bby5t6o8udc3w5KE3LDix3NCPW3M/3mTg0ODNLfsTvmyCp7rrRt0ifzmHBmsY4mEeNSGuAQag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(1590799012)(83380400001)(31696002)(82960400001)(86362001)(122000001)(38070700005)(2906002)(38100700002)(41300700001)(8936002)(5660300002)(6506007)(478600001)(2616005)(6486002)(26005)(186003)(66556008)(6512007)(66446008)(316002)(91956017)(8676002)(64756008)(966005)(76116006)(66946007)(71200400001)(66476007)(53546011)(110136005)(36756003)(85182001)(1580799009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWlUUmJEVmpLVS96RURNcDF6RFNQNGUvREFmU1VqNjc2eDNyTWR5TEZUTW5G?=
 =?utf-8?B?TS9QVG1aSTF5c0NmYzZJWk5YSG9mc2Z3MFNQZFQzeStLdjZZRU1yRnAxVkR5?=
 =?utf-8?B?a01Wd1lFMzRZWktIVnFRMms4UHBqMGxpek9OYWpnYzlQb3B0UTR1S2dZK2xI?=
 =?utf-8?B?MnJvaGwxUUswYjAyQ0dFcXFqNEtWeGR5VzB5T1lhcEdBa0V5MkdIcDdTZ2Zv?=
 =?utf-8?B?aVVNQy9uVWdkZ0hiYjF3aGlOYVJ4WnNKQjNKaGE5bmswcmVybStwdi9IQmN4?=
 =?utf-8?B?cVFaUnhrcmVPbTNpSStOZlpRM1VSNlB1bE5MNDNVUUVIQ2ZPenIvYjNvZGJk?=
 =?utf-8?B?SEg0ZVV4WUdjSzFSN3dtdXNzOFBZaVkxbS81ZExNNFVjTGtSd3B4c1R6TWdB?=
 =?utf-8?B?bEtJOHQvYS9RaGRDaWw2MTNHOVZZeWFMYm5KbUhrMS9ldC9wVDA5Z2t1UnhS?=
 =?utf-8?B?ZzJodGNUTnFWcFVHQ3k0b2x3SUF5OXMvZnNkMDRHTzkyNFBhSkt2NmppUVhj?=
 =?utf-8?B?azIyRkNrZC9GdXI4TEhIeDY5c3FFMkN1NUZVN1lCTSt4TlcwNG13VFRVYkx5?=
 =?utf-8?B?NGFhVEh3cWZPY3lNK1lXTmdWZkdtV1c1S0tSaEtBaFFWVnFvTllWcGo2TUh5?=
 =?utf-8?B?RXZxdStCUit6R0lPYXJTUFdPSjdPdEJQTDgzMFkrNHJCVkc1aVBVNjBMSzJa?=
 =?utf-8?B?dmhDMEVrMXNlNjNjTDU3c2VZOEZTaGpDWHVpN2JuMmFpWlhobjJ2Uy9JcGoz?=
 =?utf-8?B?eVFNeWw1UWhKSmdkbTliVXR5RGZQMTBDTm9iTWwyakl6TjZkSTRubTN6UzBo?=
 =?utf-8?B?dW1DNVdSU0NucnM1eXlaV1A0d1EreGsxWXo3NlFkTU1hc2VOOTdzeVJuMVg0?=
 =?utf-8?B?UWdWRkpZcVJxR040eUxtOEJiSGF2UHBQSVVLK0pGNDVZS1h5Y1prSlI1L2pM?=
 =?utf-8?B?eUd1ek4xUWRKZEwyN2cyWUo3T0lPNWt1S3kvS1pZSXV2V0Z3c0RqYzNZOGZ0?=
 =?utf-8?B?VkxJQUYyRWp5YmNYWGdFdjdMT1dvb1lidElUbE9IS0hBUlg3WlJWRW9ISk5y?=
 =?utf-8?B?WGs2QjE0aVNKMkV6R1pzQVI2LzFXcmRnbzdVcjNzbDJpTyt4cFBreUZRZ3pQ?=
 =?utf-8?B?Vzg3QnV2cjcxYW0wNHZGYmFsMjRaRFVCaVV4SUMvd2d2OEpTTElLbDM2Ri9Y?=
 =?utf-8?B?eUJBOWErdHZsN0FUbXJrUnlOVXV3SVl2TENlWnkrVlpROVlZOFRWZW4xTlU4?=
 =?utf-8?B?b0t6dFd3cGs4ano1Qy9tZ3poUlUzVWUwUDk0UlUrN1lRcFdZV21zUWtnZGx2?=
 =?utf-8?B?NzAzRUp0V2x5MzYrWDJtTGtCYVlmZE1XK2xWUEV0S1FHS25uV3FkTjE3T3Rp?=
 =?utf-8?B?bE4rMDNBaG9xYmd3QzRWYXZLVWo4d0NaQTZvajN2ZHFzMytwUzVKOGU3VVJN?=
 =?utf-8?B?dmh0d2ZnUnZBMXJncythU1d5Q0R5emNJRUxPMGdZTGV0VnJFOVA3NnROU25H?=
 =?utf-8?B?QmlIY2JvRUxqSUdCUkhTZXhmMnVDN0x1aER5aVV3bVM2Z21QTmVRRFYxTUhp?=
 =?utf-8?B?cjlSN24xTUk0eUM4WTlXWUo0L0hBWTkwR29oVTNRODhMYlFBcmwva0xVdHN3?=
 =?utf-8?B?NWNDT2NkZHJva05sR1k3T1FTaVdHL3FZMXYzaVJyUmJ0dFk4NmFodXlteDNV?=
 =?utf-8?B?RnNrbEJUQzdraW9aeFljRzJBcTUrN29kb1RXZlRsNTM3eTJPdFZJeVRGZGZX?=
 =?utf-8?B?aUZ0RUVReEthRFFxaFVmYmJjSkh1VGd3NFBPbkFYeTN3NG0wMVdVdFVBMkpI?=
 =?utf-8?B?R0xtRkRuQVl2QUl6K3lKWnBBR2E3ZXVONkY5SWhBcjl1RnlRSEJXZk5rWHQ5?=
 =?utf-8?B?cXVIWDRLL3crOXJkM25uRFBvWjJla1lKNVU5em5td1Z2Q2xsMi9HR05HOW1M?=
 =?utf-8?B?V3VhdGpBbWNpOUVWdDVwY2pLeGFwK0hpWm9KQVVMMnVEVE0yZ1F5WlV5cEE2?=
 =?utf-8?B?ZklwSExTZEViZlpIMHZGL1FaaUZjUmQwYWhraGVhLzRNb2xLcWFjR0R1RGNu?=
 =?utf-8?B?dTZWNHJwMjBPVE10Z3JJM2RXd2N0eXg3QlpVM2pNYlY0MUh0OVJYeVRtcHc1?=
 =?utf-8?B?WDQ1TkNvQlB6NXBDbEhjTXl0ZG9jWEFqTzBzQ0JrRTRGYnlsSXFFN2JxVnRM?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A63219B8DE4A942B8BBBE1B32FF70EA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jMMinORzDlSBQRcgauPPwfudlvXgeIxdf4RfIArhT3G2Xzn+h9ju5qp5ukcSL6Jak6hssiwayOPYKCFUwVPfj3bBk+qwMdDb32I52uBnY7dGhTb6621tkVtBnFuYiGkIp3eb1qhjmD4N6x77sxsxMnfSkiVL+9kyiCrhup6L2XuhEJLQnRWM3wbVCf1AZ5MolXsiAW34rrF68sRH4lkVpmpvuIKzUvzQd6/v0+qMsJZqSXBh1g5Us6uGJkuym80lHqkDTj5709u4Q8NxZJO+5IhxExy7nyqLfLelyedepqwYCzbKrWByb6jf+PUVJ+XxkKDTKSztYRE7wpsfg4vQtJrcvXDNcDhzxKYA2XRm6I+gsL3lMK2zjMOXOixoBZwyUNBbT3pNSGpzvI1vFaqgQvFjvo+yLYlsfOQwWBJwq+bqvZ1mDrkvc4icPp/qtA5E2YlgULkMsgyGl+7xYed/Nf8xsfMASZys3wt4MRiFtkaofUXWbAFpISktF5vqyrUK+GL9TqSENSk921eKX0+OecMAawqVb9a+YAdqkBGcPkxv4/v6qAadOW/wiBlyDckbwDGD4bEhgZNVbhOa0kNS+/4pOok6Wx6Zf03Cf3GIIL9eOixs4VtgzhEpSy3QoaOozcm+HBxC5iyjg00+BRrrm/cBRtBDlH40Nqqz2I4SArZbE6osSugxn/cP0MuY/MHfky9OEdegLWDHsvITyp/XTT3r0YA5iGZiQ8mH4jP8oWCyeZJ92jcGa0xn0R74M8I9hF8SzpO9XVo0nRCLeUPPKudCqUgKUWyFU6vLYA8r1HHQnAPzGpM/ks1TqE72mt0nu/QgX+tz8BNye3oaJMQMaA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e213bc8a-b799-4242-50b4-08daf766fad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 02:11:29.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPQR7q7dVdEREef3HoVi6vIJkJUp9nHYQUUBQtvNlUSw5BLEjxHdjWHIwhP/9QU5WLRIBn0gglVtEPLwi6XgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9667
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE0LzAxLzIwMjMgMDc6MjcsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBJc29sYXRlIG1y
IHNwZWNpZmljIGNvZGUgZnJvbSBhdG9taWNfd3JpdGVfcmVwbHkoKSBpbiByeGVfcmVzcC5jIGlu
dG8NCj4gYSBzdWJyb3V0aW5lIHJ4ZV9tcl9kb19hdG9taWNfd3JpdGUoKSBpbiByeGVfbXIuYy4N
Cj4gQ2hlY2sgbGVuZ3RoIGZvciBhdG9taWMgd3JpdGUgb3BlcmF0aW9uLg0KPiBNYWtlIGlvdmFf
dG9fdmFkZHIoKSBzdGF0aWMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVhcnNvbiA8cnBl
YXJzb25ocGVAZ21haWwuY29tPg0KPiAtLS0NCj4gdjM6DQo+ICAgIEZpeGVkIGJ1ZyByZXBvcnRl
ZCBieSBrZXJuZWwgdGVzdCByb2JvdC4gSWZkZWYnZWQgb3V0IGF0b21pYyA4IGJ5dGUNCj4gICAg
d3JpdGUgaWYgQ09ORklHXzY0QklUIGlzIG5vdCBkZWZpbmVkIGFzIG9yaWduYWxseSBpbnRlbmRl
ZCBieSB0aGUNCj4gICAgZGV2ZWxvcGVycyBvZiB0aGUgYXRvbWljIHdyaXRlIGltcGxlbWVudGF0
aW9uLg0KPiBsaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yZG1hLzIwMjMwMTEz
MTE0My5DbW95VmN1bC1sa3BAaW50ZWwuY29tLw0KPiANCj4gICBkcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9sb2MuaCAgfCAgMSArDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYyAgIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIHwgNTggKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmgg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaA0KPiBpbmRleCBiY2IxYmJjZjUw
ZGYuLmZkNzBjNzFhOWU0ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfbG9jLmgNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmgN
Cj4gQEAgLTc0LDYgKzc0LDcgQEAgaW50IHJ4ZV9tYXBfbXJfc2coc3RydWN0IGliX21yICppYm1y
LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLA0KPiAgIHZvaWQgKmlvdmFfdG9fdmFkZHIoc3RydWN0
IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLCBpbnQgbGVuZ3RoKTsNCj4gICBpbnQgcnhlX21yX2RvX2F0
b21pY19vcChzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIGludCBvcGNvZGUsDQo+ICAgCQkJ
dTY0IGNvbXBhcmUsIHU2NCBzd2FwX2FkZCwgdTY0ICpvcmlnX3ZhbCk7DQo+ICtpbnQgcnhlX21y
X2RvX2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlvdmEsIHZvaWQgKmFkZHIp
Ow0KPiAgIHN0cnVjdCByeGVfbXIgKmxvb2t1cF9tcihzdHJ1Y3QgcnhlX3BkICpwZCwgaW50IGFj
Y2VzcywgdTMyIGtleSwNCj4gICAJCQkgZW51bSByeGVfbXJfbG9va3VwX3R5cGUgdHlwZSk7DQo+
ICAgaW50IG1yX2NoZWNrX3JhbmdlKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgc2l6ZV90
IGxlbmd0aCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9t
ci5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiBpbmRleCA3OTE3MzFi
ZTYwNjcuLjFlNzRmNWU4ZTEwYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfbXIuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5j
DQo+IEBAIC01NjgsNiArNTY4LDU2IEBAIGludCByeGVfbXJfZG9fYXRvbWljX29wKHN0cnVjdCBy
eGVfbXIgKm1yLCB1NjQgaW92YSwgaW50IG9wY29kZSwNCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0K
PiAgIA0KPiArLyoqDQo+ICsgKiByeGVfbXJfZG9fYXRvbWljX3dyaXRlKCkgLSB3cml0ZSA2NGJp
dCB2YWx1ZSB0byBpb3ZhIGZyb20gYWRkcg0KPiArICogQG1yOiBtZW1vcnkgcmVnaW9uDQo+ICsg
KiBAaW92YTogaW92YSBpbiBtcg0KPiArICogQGFkZHI6IHNvdXJjZSBvZiBkYXRhIHRvIHdyaXRl
DQo+ICsgKg0KPiArICogUmV0dXJuczoNCj4gKyAqCSAwIG9uIHN1Y2Nlc3MNCj4gKyAqCS0xIGZv
ciBtaXNhbGlnbmVkIGFkZHJlc3MNCj4gKyAqCS0yIGZvciBhY2Nlc3MgZXJyb3JzDQo+ICsgKgkt
MyBmb3IgY3B1IHdpdGhvdXQgbmF0aXZlIDY0IGJpdCBzdXBwb3J0DQoNCldlbGwsIGknbSBub3Qg
ZmF2b3Igb2Ygc3VjaCBlcnJvciBjb2RlLiBlc3BlY2lhbHkgd2hlbiBpdCdzIG5vdCBhIHN0YWlj
IHN1YnJvdXRpbmUuDQpBbnkgY29tbWVudHMgZnJvbSBvdGhlciBtYWludGFpbmVycyA/DQoNCg0K
PiArICovDQo+ICtpbnQgcnhlX21yX2RvX2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX21yICptciwg
dTY0IGlvdmEsIHZvaWQgKmFkZHIpDQo+ICt7DQo+ICsjaWYgZGVmaW5lZCBDT05GSUdfNjRCSVQN
Cj4gKwl1NjQgKnZhZGRyOw0KPiArCXU2NCB2YWx1ZTsNCj4gKwl1bnNpZ25lZCBpbnQgbGVuZ3Ro
ID0gODsNCj4gKw0KPiArCS8qIFNlZSBJQkEgb0ExOS0yOCAqLw0KPiArCWlmICh1bmxpa2VseSht
ci0+c3RhdGUgIT0gUlhFX01SX1NUQVRFX1ZBTElEKSkgew0KPiArCQlyeGVfZGJnX21yKG1yLCAi
bXIgbm90IHZhbGlkIik7DQo+ICsJCXJldHVybiAtMjsNCj4gKwl9DQo+ICsNCj4gKwkvKiBTZWUg
SUJBIEExOS40LjIgKi8NCj4gKwlpZiAodW5saWtlbHkoKHVpbnRwdHJfdCl2YWRkciAmIDB4NyB8
fCBpb3ZhICYgMHg3KSkgew0KDQp2YWRkciB1c2VkIGJlZm9yZSBiZWluZyBpbml0aWFsaXplZA0K
DQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4gKwkJcnhlX2RiZ19tcihtciwgIm1pc2FsaWduZWQg
YWRkcmVzcyIpOw0KPiArCQlyZXR1cm4gLTE7DQo+ICsJfQ0KPiArDQo+ICsJdmFkZHIgPSBpb3Zh
X3RvX3ZhZGRyKG1yLCBpb3ZhLCBsZW5ndGgpOw0KPiArCWlmICh1bmxpa2VseSghdmFkZHIpKSB7
DQo+ICsJCXJ4ZV9kYmdfbXIobXIsICJpb3ZhIG91dCBvZiByYW5nZSIpOw0KPiArCQlyZXR1cm4g
LTI7DQo+ICsJfQ0KPiArDQo+ICsJLyogdGhpcyBtYWtlcyBubyBzZW5zZS4gV2hhdCBvZiBwYXls
b2FkIGlzIG5vdCA4PyAqLw0KPiArCW1lbWNweSgmdmFsdWUsIGFkZHIsIGxlbmd0aCk7DQo+ICsN
Cj4gKwkvKiBEbyBhdG9taWMgd3JpdGUgYWZ0ZXIgYWxsIHByaW9yIG9wZXJhdGlvbnMgaGF2ZSBj
b21wbGV0ZWQgKi8NCj4gKwlzbXBfc3RvcmVfcmVsZWFzZSh2YWRkciwgdmFsdWUpOw0KPiArDQo+
ICsJcmV0dXJuIDA7DQo+ICsjZWxzZQ0KPiArCXJ4ZV9kYmdfbXIobXIsICI2NCBiaXQgaW50ZWdl
cnMgbm90IGF0b21pYyIpOw0KPiArCXJldHVybiAtMzsNCj4gKyNlbmRpZg0KPiArfQ0KPiArDQo+
ICAgaW50IGFkdmFuY2VfZG1hX2RhdGEoc3RydWN0IHJ4ZV9kbWFfaW5mbyAqZG1hLCB1bnNpZ25l
ZCBpbnQgbGVuZ3RoKQ0KPiAgIHsNCj4gICAJc3RydWN0IHJ4ZV9zZ2UJCSpzZ2UJPSAmZG1hLT5z
Z2VbZG1hLT5jdXJfc2dlXTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3Jlc3AuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiBp
bmRleCAwMjMwMWUzZjM0M2MuLjEwODNjZGEyMmM2NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3Jlc3AuYw0KPiBAQCAtNzYyLDI2ICs3NjIsMzMgQEAgc3RhdGljIGVudW0gcmVz
cF9zdGF0ZXMgYXRvbWljX3JlcGx5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiAgIAlyZXR1cm4gUkVT
UFNUX0FDS05PV0xFREdFOw0KPiAgIH0NCj4gICANCj4gLSNpZmRlZiBDT05GSUdfNjRCSVQNCj4g
LXN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGRvX2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX3FwICpx
cCwNCj4gLQkJCQkJc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KPiArc3RhdGljIGVudW0gcmVz
cF9zdGF0ZXMgYXRvbWljX3dyaXRlX3JlcGx5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiArCQkJCQkg
ICBzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QpDQo+ICAgew0KPiArCXU2NCBpb3ZhID0gcXAtPnJl
c3AudmEgKyBxcC0+cmVzcC5vZmZzZXQ7DQo+ICsJc3RydWN0IHJlc3BfcmVzICpyZXMgPSBxcC0+
cmVzcC5yZXM7DQo+ICAgCXN0cnVjdCByeGVfbXIgKm1yID0gcXAtPnJlc3AubXI7DQo+ICsJdm9p
ZCAqYWRkciA9IHBheWxvYWRfYWRkcihwa3QpOw0KPiAgIAlpbnQgcGF5bG9hZCA9IHBheWxvYWRf
c2l6ZShwa3QpOw0KPiAtCXU2NCBzcmMsICpkc3Q7DQo+IC0NCj4gLQlpZiAobXItPnN0YXRlICE9
IFJYRV9NUl9TVEFURV9WQUxJRCkNCj4gLQkJcmV0dXJuIFJFU1BTVF9FUlJfUktFWV9WSU9MQVRJ
T047DQo+ICsJaW50IGVycjsNCj4gICANCj4gLQltZW1jcHkoJnNyYywgcGF5bG9hZF9hZGRyKHBr
dCksIHBheWxvYWQpOw0KPiArCWlmICghcmVzKSB7DQo+ICsJCXJlcyA9IHJ4ZV9wcmVwYXJlX3Jl
cyhxcCwgcGt0LCBSWEVfQVRPTUlDX1dSSVRFX01BU0spOw0KPiArCQlxcC0+cmVzcC5yZXMgPSBy
ZXM7DQo+ICsJfQ0KPiAgIA0KPiAtCWRzdCA9IGlvdmFfdG9fdmFkZHIobXIsIHFwLT5yZXNwLnZh
ICsgcXAtPnJlc3Aub2Zmc2V0LCBwYXlsb2FkKTsNCj4gLQkvKiBjaGVjayB2YWRkciBpcyA4IGJ5
dGVzIGFsaWduZWQuICovDQo+IC0JaWYgKCFkc3QgfHwgKHVpbnRwdHJfdClkc3QgJiA3KQ0KPiAt
CQlyZXR1cm4gUkVTUFNUX0VSUl9NSVNBTElHTkVEX0FUT01JQzsNCj4gKwlpZiAocmVzLT5yZXBs
YXkpDQo+ICsJCXJldHVybiBSRVNQU1RfQUNLTk9XTEVER0U7DQo+ICAgDQo+IC0JLyogRG8gYXRv
bWljIHdyaXRlIGFmdGVyIGFsbCBwcmlvciBvcGVyYXRpb25zIGhhdmUgY29tcGxldGVkICovDQo+
IC0Jc21wX3N0b3JlX3JlbGVhc2UoZHN0LCBzcmMpOw0KPiArCWVyciA9IHJ4ZV9tcl9kb19hdG9t
aWNfd3JpdGUobXIsIGlvdmEsIGFkZHIpOw0KPiArCWlmICh1bmxpa2VseShlcnIpKSB7DQo+ICsJ
CWlmIChlcnIgPT0gLTMpDQo+ICsJCQlyZXR1cm4gUkVTUFNUX0VSUl9VTlNVUFBPUlRFRF9PUENP
REU7DQo+ICsJCWVsc2UgaWYgKGVyciA9PSAtMikNCj4gKwkJCXJldHVybiBSRVNQU1RfRVJSX1JL
RVlfVklPTEFUSU9OOw0KPiArCQllbHNlDQo+ICsJCQlyZXR1cm4gUkVTUFNUX0VSUl9NSVNBTElH
TkVEX0FUT01JQzsNCj4gKwl9DQo+ICAgDQo+ICAgCS8qIGRlY3JlYXNlIHJlc3AucmVzaWQgdG8g
emVybyAqLw0KPiAgIAlxcC0+cmVzcC5yZXNpZCAtPSBzaXplb2YocGF5bG9hZCk7DQo+IEBAIC03
OTQsMjkgKzgwMSw4IEBAIHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGRvX2F0b21pY193cml0ZShz
dHJ1Y3QgcnhlX3FwICpxcCwNCj4gICANCj4gICAJcXAtPnJlc3Aub3Bjb2RlID0gcGt0LT5vcGNv
ZGU7DQo+ICAgCXFwLT5yZXNwLnN0YXR1cyA9IElCX1dDX1NVQ0NFU1M7DQo+IC0JcmV0dXJuIFJF
U1BTVF9BQ0tOT1dMRURHRTsNCj4gLX0NCj4gLSNlbHNlDQo+IC1zdGF0aWMgZW51bSByZXNwX3N0
YXRlcyBkb19hdG9taWNfd3JpdGUoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+IC0JCQkJCXN0cnVjdCBy
eGVfcGt0X2luZm8gKnBrdCkNCj4gLXsNCj4gLQlyZXR1cm4gUkVTUFNUX0VSUl9VTlNVUFBPUlRF
RF9PUENPREU7DQo+IC19DQo+IC0jZW5kaWYgLyogQ09ORklHXzY0QklUICovDQo+IC0NCj4gLXN0
YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGF0b21pY193cml0ZV9yZXBseShzdHJ1Y3QgcnhlX3FwICpx
cCwNCj4gLQkJCQkJICAgc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KPiAtew0KPiAtCXN0cnVj
dCByZXNwX3JlcyAqcmVzID0gcXAtPnJlc3AucmVzOw0KPiAgIA0KPiAtCWlmICghcmVzKSB7DQo+
IC0JCXJlcyA9IHJ4ZV9wcmVwYXJlX3JlcyhxcCwgcGt0LCBSWEVfQVRPTUlDX1dSSVRFX01BU0sp
Ow0KPiAtCQlxcC0+cmVzcC5yZXMgPSByZXM7DQo+IC0JfQ0KPiAtDQo+IC0JaWYgKHJlcy0+cmVw
bGF5KQ0KPiAtCQlyZXR1cm4gUkVTUFNUX0FDS05PV0xFREdFOw0KPiAtCXJldHVybiBkb19hdG9t
aWNfd3JpdGUocXAsIHBrdCk7DQo+ICsJcmV0dXJuIFJFU1BTVF9BQ0tOT1dMRURHRTsNCj4gICB9
DQo+ICAgDQo+ICAgc3RhdGljIHN0cnVjdCBza19idWZmICpwcmVwYXJlX2Fja19wYWNrZXQoc3Ry
dWN0IHJ4ZV9xcCAqcXAs
