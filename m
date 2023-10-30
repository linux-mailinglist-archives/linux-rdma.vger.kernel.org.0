Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9D57DB4E9
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 09:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjJ3INi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjJ3INh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 04:13:37 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E80891;
        Mon, 30 Oct 2023 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698653615; x=1730189615;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+28kgO0IYfol9ryLCUBLtOvlL8x2PUHJo8t03C0ErYs=;
  b=tx/GxS6P43deCatkn2YmIloksm09yhmYrYSDWIjrXN5G31cTXXcClddR
   nmdjz73KA3gPRt367EOssxksmqth337rYs4wKx48gCsUPjtCC71wwLlSd
   yZajQxmw7gEA1zwvluIRuaoM5vN36iBdZ7ncaMfJaqzKh53FULHjrMlnM
   afyy6kbAleQJR890DBtP8lAWPhnnIWG2zl6b7L53+baJIIaVaPRYy1wA/
   sSzY/5JV3PVLOnL4zCv8+/S3LxMkqzlO1a+2ACU5rOjCRB9TSpqC56nA3
   9CJbXatqus2HHrAv0r/l7gE4PDNi3CV71GW6j8rLt8bKBMTNbEE0vLKOV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="100789415"
X-IronPort-AV: E=Sophos;i="6.03,263,1694703600"; 
   d="scan'208";a="100789415"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 17:13:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TREkHCfOZSpP0ObmCvG3wjKILEZWUjM9V0FHCfmAAEUqn7KE3gN0ytb3DTlJe3j12O2b7MGaqEA8tFzt+xFh2oaquUUwhBNISg/5yzX1GUASw30G2Jn41BzHLGwxcRrKjk77Xe1DwCm+h3M68V4Fej+mIOdN/m5eMPTFGKC1u4J58BoC9z6RMuHJqiQvyO+B1VTM69GDPauV1toMj+T9fqAhmesplqfnhfFTLKtLXAInj3MG9wNJJT7GsN+7PxROJSg8JkPijjp8TaFjsC9nmarbkb1dK33PjlHLobQsBn4OT68791TizslrTV5nqI1+5IuK0H9Zu6mJMupwKEJn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+28kgO0IYfol9ryLCUBLtOvlL8x2PUHJo8t03C0ErYs=;
 b=UQro/YLY8RggkJ6Xj/9agC6nvC8GlNSHBCMMR+5Av8vLIBFmlCzKiEOFeaNWKjwZ8+U7ecTXz5giJbcoeeceII4DJip8VNF1YCHNlVydCe8ZtNFKQvngdPSbEJHGETvuga8oCbxKpPdH1YqNUGv2ick3NnA6Lg/uW1tRG+ULSH+6Ghtns1DGdxW2FXwPr4GhyMU8afFvoCPBHRoHZL3VCIbht5HHvWNMbZYICcsCmVBI/5IgBqTRfLuIvGA6DH5jlEej44i/9mGBlKpC1CDPPja2yiVfNvXdUVG/lbiztndqEECXAtbE0LWCuAYNSI3RiR6IhfvY1SjNvxeaYhHuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13)
 by TYCPR01MB7702.jpnprd01.prod.outlook.com (2603:1096:400:17b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 08:13:27 +0000
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::7100:d925:a063:566f]) by OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::7100:d925:a063:566f%6]) with mapi id 15.20.6933.020; Mon, 30 Oct 2023
 08:13:27 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Thread-Topic: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Thread-Index: AQHaCJhTvrj5SCKGZEeB5zGuZXPZvLBdSuwAgAS1zIA=
Date:   Mon, 30 Oct 2023 08:13:27 +0000
Message-ID: <784a65e3-5438-4700-b3e4-1d72d144ec2a@fujitsu.com>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
In-Reply-To: <53c18b2a-c3b2-4936-b654-12cb5f914622@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5445:EE_|TYCPR01MB7702:EE_
x-ms-office365-filtering-correlation-id: f5362077-69cb-4e89-fcd0-08dbd920182d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WVS+QXk116e9WpDZJW/EQOpU7M0k9eL9f3NRH4b7qqaLlJcpCaABVU+zhHNrsozwKEKDmhs17OEY50RVdDWr7y3clwdkB2cgpkI6ZEmnnlIdjA/YfupQgG1J3WnaICeqC/p1H2SOmMuzukmSBshmp+F28r2SFZ61QREDjaBktqMRAxFwcEdbuRY6SwIcEV7/1qi5OKZ7gv4Nk1Sw7kMGVTyPdq+fLP8A2Ja39KfZ9xncG8mtH1a8nUYvtb24h0qUCVJyACh3h16rmMZEKx2wVZeHGuShtKA01jDrF0EYI9MI32SueuIOY59d9hgf0nzOBPfDM8ITYLt1PClzp48lX4Y5mJcURYzHgCmMtfHl1AVEe/1OgEOyzwmvIUBA2/xJiiLeIfTYnOEYXs9wOrnhLXIEtOR2RWnWQq/MeS6CQ2vnkZ06N4VwWfbI+dcc2WMp3PetZA31KrwBvT19AFeawKbsNuk3zEXbf/jiA+hKG/hkZBwBYcti4Q5FTO8+JmhEaqv/4ZqAlXIDACRxgcGyDGf3d6sUcO2ePVWPtMx+B6dK6FJY69GMppXPyZsOstMjT9YAEuTbh5KVnM3WgyJTBQCj7k7lH7c1BrDNeNqqeP51rb0plOFtflxFjU8vmv3Or9H1El1iYLLCPc5EADbhtb0KpWS8i1Qb494wHH+yWp9no/6cnl9/h4wSCaWx9N73BECdYfZQ4JNrK8wqWIwIog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5445.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(1590799021)(451199024)(186009)(1800799009)(64100799003)(6512007)(71200400001)(122000001)(6506007)(38100700002)(478600001)(31686004)(85182001)(6486002)(36756003)(76116006)(66946007)(26005)(91956017)(110136005)(2616005)(83380400001)(82960400001)(53546011)(66476007)(66556008)(64756008)(66446008)(54906003)(316002)(8936002)(4326008)(8676002)(5660300002)(31696002)(86362001)(2906002)(41300700001)(1580799018)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzNGdnlvdkFSM01wTEdzQnU4Q1UvSTRpdFJ3ZlVCOSsvazVDUlREOXpvbWxZ?=
 =?utf-8?B?YnVRcVptTzBrU2pOVC9hL2VId24vb0JMYkR2R0EyWEF2YUFIdGJHN29mYnJZ?=
 =?utf-8?B?SWR3ZzZXaFduZXBtMW9Ub1h5Zzl4Y0hreU1HMWpWOWtHejRRSWhGSWxqeTZW?=
 =?utf-8?B?bGJ3RU9uNWR4SFdrbWpaNC9FamNhY0dQdjA0UVF3a202V1pMdjhreUFpcVJP?=
 =?utf-8?B?Q3lrV1NyTkJEOFlVRU5Wc2NCNWpqYWhHb0J3MEoyQ29rZ2hVNTVQWXRBeXRj?=
 =?utf-8?B?MjU1VW85YjNyK09hSG1KR05oRHVSam0rdllkS0dCRy9vL2JzYm0yVjdBZjJx?=
 =?utf-8?B?bG55TTAwdFoyUUt3K1V6Ym9acWVjazFZSTdBaWtiQXlKZjlZV3hUWm1BUTNn?=
 =?utf-8?B?RVUyQmljNWFJajFVc0hXWndOYUQrc25sVUgwVnZhcXAxbkhJNHZDU29QQjFM?=
 =?utf-8?B?ZFY4R2hlcVk1Z0RDTkFwWGRUekR6L1h0MWlEbS9tVXl6V2ZyMW15NXAveDl2?=
 =?utf-8?B?K1AvVkJhL2JNSXBMRFUweVlwU09RajR4ZHFiaksraXFJMUtsM2xoMzJKY2Vu?=
 =?utf-8?B?cXczdjB4WC9QL2ZWNUdIcmlEdElJN29pdm04OE81dW9rTHh2SWY0UzF2aExC?=
 =?utf-8?B?dnVlME9sM25BMmZTS3hOM25ubk9aekljVkxXV3JkNVFyOUVnY2JBNmhBVjI5?=
 =?utf-8?B?enZGS0E3NDVlaUxWc241Tm9XWFVMUWFjQ1ZTSldncDlHZXV2WGFnVkRmOWFU?=
 =?utf-8?B?ZlVMcW9aSSt1S1BTSTBhenZnMTNKdzk0RFhoWVpHSXY4THozb2x0a0pOdTRJ?=
 =?utf-8?B?TE9yekxaN0M2NGpYVldjaGxJTGI4YlFxdy9rT1VQaXNaL1lqSzFjT2xZVS9r?=
 =?utf-8?B?NCtUZXdsdDQrcTZKbXdCTlUzN29rUStydUkvQnFkbVRCQVV4QlVMaDhKSENC?=
 =?utf-8?B?WEREVzlLbDZ2NzJHQVBPeVd4NXZqMm84Z0R3U1pCSFJSQzEvQTVRWW1Td0lv?=
 =?utf-8?B?TnM4UUlQbXAwcWt3d3NGUFdoRXo1eVFBVkNQQmhFZElQY3ZTQUxudUVGWS9l?=
 =?utf-8?B?MzZZU3FZb2IxZEZ1alhDVkFpM05QWVZ0ZUk3VllKZlcyWjR0TG0rcFRCQ1lp?=
 =?utf-8?B?NW5JQzZUeWFIbmgxd2ZnU2JuVGhmTHRaLzlCaTVHem4rdVFzM25PVHdScTZ3?=
 =?utf-8?B?U2psRDM2amdPZWcvQzVtemVNQTg5VzlLeW9HMHVBcS9mcUFJODhXYzJJWVVK?=
 =?utf-8?B?NlhiTURjc3Q1VGVtMmpnelBJRE10TFptSWdHSjZXR0JzMHJpWHVLVllQaHM0?=
 =?utf-8?B?QjRobmlmbEg3dk1PTVNmNGF0VFhwbHFURTFySUVLSDFaQytORDZrVG1wUzdY?=
 =?utf-8?B?K1VEVGloTW1JSmV1bWJvc25VN2dwWkMwT1FCYVZZUzZ0TDZUWld1b3NEMlRM?=
 =?utf-8?B?aUdqbUNsT1dBZnAySXJNYm9GVitJN29LVm94dkdxbFpyM3dvTSs4eC9MSUxE?=
 =?utf-8?B?ZHNTeEg5SHREd2xKRU5wbjh3aE8wTUpWbkFOWTdqTjEvZXg5a0g3RU01NEJy?=
 =?utf-8?B?QnNxQ1RzeFVJS2lIZmxQQ0VsRjZFcHZFSTR1TDg4Mjc2SlYreGg0cktOZ1Nz?=
 =?utf-8?B?WCszcnFCVkY3YUhKaSsrS29uSkc0TnMxREFBVVE0RWc2UnY1alIySmllZS9o?=
 =?utf-8?B?U01uS1N1MVd5NkRFNHVhNmdvem41bUQydzdzUlBLWnJFbW9tTlVVSHIrQmlx?=
 =?utf-8?B?YlBZNTJZL0hvNlcrZjlaT0tIbU1RenFaOTkxZlVEZlFLNktGQktrN3diZjFo?=
 =?utf-8?B?b2JQTVU5czBLMzRqU2NKbTZnYWZ2ZEl2L3JLWHdmRXp1ZDlVczgrVUF2anlm?=
 =?utf-8?B?MkJjV1FGT0x6UFd6bjdSanVJTndZOGcxRThpOEZqdDF5T1V0QzFkcGFjU25R?=
 =?utf-8?B?cjk5dXVJTnNlb2FvMmozQmN1WVpxL2JXeVBMbXlrcVdwdDFBeUMvdjA1dGFX?=
 =?utf-8?B?cVV3OUdybTJTL241ckUyWVRQc3pTYXRLd09GVmsrSVNBb0RQRTBsUC9oS1pM?=
 =?utf-8?B?NVZibE9EL2YwME10VHVTOE1YV0VJUjNObXEzVGVnaHUvRjNWaGhVUkNhVEc0?=
 =?utf-8?B?cEduTk44ajJUV3pKVTd3cTR1dmlTekFwcWE2NnhRdnlCN1ZjVmhRTkd5WW5w?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C6C11420C6437458F52B6609D8D9BBA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RY5IOwHXcZvCV3Yq7BFHpkYraRUTjr8bPusI062C1GZJAeXDOK8K4nWxMl1MIIiBbJIi8jdrhPuMaGxr62rhdwnVB+2CcyZQ6yfwr5CnrgrcvlRpjcma7kSsWN0emd20l3BdSC6zTNga9QwO5lpvjiN6/qWMhbZZQZ8Udih8uHnPD7WX9F1H/B9hOBRkebJR/naJgnLWNEAB6oL5Rjn1UypHbj8oG8kipDXLCa1H5ZTZsOzpJSmQmVDgWYMdhc0qwTdM6iHHigX/35RO9ay12XphoydT8VHMTaltMVNB4a7Te3y5Ye8MWvYIJut19qDTKewOHAYVAVP3jBANqFKzlXAhwzB47G5BTL8E6pTthRJgw0nzcfXLpbtcUXRkQh4TRvzNZ/QVElPwqkp3gRsifPqIpBj2nR+oy7i9YgfKKza+O+jQJxhexxoimSDbxhfSu2GqAeMxsMlm6ev2uXKg1Mvq2A1mH8Q+1N72xPDJzK6YaIIC+T7w22Ww+vpWKlZuurSpCoaPfM5iG0l8cdvNA0++Jntnwir2raQuq3nPBjE8vPTZkDccoMnGMKhYlBLGFHU9nL0CPjBctjg5PEBV4L/MQXrCNmtEVtl0gcIvdUntnzxd5TuPARd/HT0obdX/kfbHcpYJ/mx3xI7R9mCO6wE6IXDQw1Qn0zGOCi8pndBtCiGuYGlOhiwIuf4Yu2RE9PMb8BVIMbC5upxkrkZPgukyhTyLjmD7M3TixjD8kVi77GohkV/N6UQNqLQVGf/xHIhTT5N1XCBqIBj+YAZWJc7adkEYrTlVsDrv6pwlB5K2iZOpKwBhhWQ9mxSUA/4b4zZpT95bYJElBOgN9PAxVEaYXIrg90itphWqqpH7xDzQYaUCxRhfIJqpISPQM1i5yKArD/15Vk8+A3al9H0CTg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5445.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5362077-69cb-4e89-fcd0-08dbd920182d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 08:13:27.0703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgtoER6ItbGdIgKKHDgUT2TwikMg/CL1IRU1gL9zTnaXIcCkx2kD5nRdzs7g5BAuHb4nk24iwO2dd2s/qeK8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7702
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI3LzEwLzIwMjMgMTY6MTcsIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWcqCAyMDIzLzEw
LzI3IDEzOjQxLCBMaSBaaGlqaWFuIOWGmemBkzoNCj4+IG1yLT5wYWdlX2xpc3Qgb25seSBlbmNv
ZGVzICpwYWdlIHdpdGhvdXQgcGFnZSBvZmZzZXQsIHdoZW4NCj4+IHBhZ2Vfc2l6ZSAhPSBQQUdF
X1NJWkUsIHdlIGNhbm5vdCByZXN0b3JlIHRoZSBhZGRyZXNzIHdpdGggYSB3cm9uZw0KPj4gcGFn
ZV9vZmZzZXQuDQo+Pg0KPj4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggd2lsbCBicmVhayBzb21lIFVM
UHMgdGhhdCB0cnkgdG8gcmVnaXN0ZXIgNEsNCj4+IE1SIHdoZW4gUEFHRV9TSVpFIGlzIG5vdCA0
Sy4NCj4+IFNSUCBhbmQgbnZtZSBvdmVyIFJYRSBpcyBrbm93biB0byBiZSBpbXBhY3RlZC4NCj4g
DQo+IFdoZW4gVUxQIHVzZXMgZm9saW8gb3IgY29tcG91bmQgcGFnZSwgVUxQIGNhbiBub3Qgd29y
ayB3ZWxsIHdpdGggUlhFIGFmdGVyIHRoaXMgY29tbWl0IGlzIGFwcGxpZWQuDQo+IA0KPiBQZXJo
YXBzIHJlbW92aW5nIHBhZ2Vfc2l6ZSBzZXQgaW4gUlhFIGlzIGEgZ29vZCBzb2x1dGlvbiBiZWNh
dXNlIHBhZ2Vfc2l6ZSBpcyBzZXQgdHdpY2UsIGZpcnN0bHkgcGFnZV9zaXplIGlzIHNldCBpbiBp
bmZpbmliYW5kL2NvcmUsIHNlY29uZGx5IGl0IGlzIHNldCBpbiBSWEUuDQoNCkRvZXMgVGhlIFJY
RSBvbmUgbWVhbiByeGVfbXJfaW5pdCgpLCBJIHRoaW5rIHJ4ZV9yZWdfdXNlcl9tcigpIHJlcXVp
cmVzIHRoaXMuDQoNCiAgNDggc3RhdGljIHZvaWQgcnhlX21yX2luaXQoaW50IGFjY2Vzcywgc3Ry
dWN0IHJ4ZV9tciAqbXIpDQogIDQ5IHsNCiAgNTAgICAgICAgICB1MzIga2V5ID0gbXItPmVsZW0u
aW5kZXggPDwgOCB8IHJ4ZV9nZXRfbmV4dF9rZXkoLTEpOw0KICA1MQ0KICA1MiAgICAgICAgIC8q
IHNldCBpYm1yLT5sL3JrZXkgYW5kIGFsc28gY29weSBpbnRvIHByaXZhdGUgbC9ya2V5DQogIDUz
ICAgICAgICAgICogZm9yIHVzZXIgTVJzIHRoZXNlIHdpbGwgYWx3YXlzIGJlIHRoZSBzYW1lDQog
IDU0ICAgICAgICAgICogZm9yIGNhc2VzIHdoZXJlIGNhbGxlciAnb3ducycgdGhlIGtleSBwb3J0
aW9uDQogIDU1ICAgICAgICAgICogdGhleSBtYXkgYmUgZGlmZmVyZW50IHVudGlsIFJFR19NUiBX
UUUgaXMgZXhlY3V0ZWQuDQogIDU2ICAgICAgICAgICovDQogIDU3ICAgICAgICAgbXItPmxrZXkg
PSBtci0+aWJtci5sa2V5ID0ga2V5Ow0KICA1OCAgICAgICAgIG1yLT5ya2V5ID0gbXItPmlibXIu
cmtleSA9IGtleTsNCiAgNTkNCiAgNjAgICAgICAgICBtci0+YWNjZXNzID0gYWNjZXNzOw0KICA2
MSAgICAgICAgIG1yLT5pYm1yLnBhZ2Vfc2l6ZSA9IFBBR0VfU0laRTsNCiAgNjIgICAgICAgICBt
ci0+cGFnZV9tYXNrID0gUEFHRV9NQVNLOw0KICA2MyAgICAgICAgIG1yLT5wYWdlX3NoaWZ0ID0g
UEFHRV9TSElGVDsNCiAgNjQgICAgICAgICBtci0+c3RhdGUgPSBSWEVfTVJfU1RBVEVfSU5WQUxJ
RDsNCiAgNjUgfQ0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiBXaGVuIGZvbGlvIG9yIGNv
bXBvdW5kIHBhZ2UgaXMgdXNlZCBpbiBVTFAsIGl0IGlzIHZlcnkgcG9zc2libGUgdGhhdCBwYWdl
X3NpemUgaW4gaW5maW5pYmFuZC9jb3JlIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBwYWdlX3NpemUg
aW4gUlhFDQo+IA0KPiBOb3Qgc3VyZSB3aGF0IHByb2JsZW0gdGhpcyBkaWZmZXJlbmNlIHdpbGwg
Y2F1c2UuDQo+IA0KPiBaaHUgWWFuanVuDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpo
aWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfbXIuYyB8IDYgKysrKysrDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+PiBp
bmRleCBmNTQwNDJlOWFlYjIuLjYxYTEzNmVhMWQ5MSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX21yLmMNCj4+IEBAIC0yMzQsNiArMjM0LDEyIEBAIGludCByeGVfbWFwX21yX3Nn
KHN0cnVjdCBpYl9tciAqaWJtciwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZ2wsDQo+PiDCoMKgwqDC
oMKgIHN0cnVjdCByeGVfbXIgKm1yID0gdG9fcm1yKGlibXIpOw0KPj4gwqDCoMKgwqDCoCB1bnNp
Z25lZCBpbnQgcGFnZV9zaXplID0gbXJfcGFnZV9zaXplKG1yKTsNCj4+ICvCoMKgwqAgaWYgKHBh
Z2Vfc2l6ZSAhPSBQQUdFX1NJWkUpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCByeGVfaW5mb19tciht
ciwgIlVuc3VwcG9ydGVkIE1SIHdpdGggcGFnZV9zaXplICV1LCBleHBlY3QgJWx1XG4iLA0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZV9zaXplLCBQQUdFX1NJWkUpOw0KPj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0K
Pj4gwqDCoMKgwqDCoCBtci0+bmJ1ZiA9IDA7DQo+PiDCoMKgwqDCoMKgIG1yLT5wYWdlX3NoaWZ0
ID0gaWxvZzIocGFnZV9zaXplKTsNCj4+IMKgwqDCoMKgwqAgbXItPnBhZ2VfbWFzayA9IH4oKHU2
NClwYWdlX3NpemUgLSAxKTsNCj4g
