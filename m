Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037E57E1B92
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 09:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjKFIAM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 03:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFIAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 03:00:11 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69190BF;
        Mon,  6 Nov 2023 00:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699257601; x=1730793601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4gxGPFyhxZD7EJzdnw91xEywTxwar21xRe4Xj3dfJeI=;
  b=s1FsopvnphGX2/cj9mof2Zs4yIyFvjlugN+Rsxc2IDeG6BOsH7j1zLEL
   zgh0tD9DLvzui01H8M+P1bJPo3SZViiPepCqDIaeqzOdu5tYEhN76qT9t
   XHUGjbt9F1eAlarXKWW7o+aD0dIDCBJ8UnzHg0CwUQ5qnWLofY56JQw0n
   opF3jHdMlvs+WEAVtaQVLFM0+KH3Why+p6/ZbQm5D1gc28XZtojoPN6Tp
   XPnJ1xJLJI2G1djPomM52GRcziwJd6GFWzXnNBY9MfeuaQCQHGuPn3QUf
   RiWc7MsKAO333wsSZuqXbJwWwTe8dWKA5JH0k0kw8y3A2pP/zRJSo6GdY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="101119440"
X-IronPort-AV: E=Sophos;i="6.03,280,1694703600"; 
   d="scan'208";a="101119440"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:59:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSKhqGYtDKcmwb42zJSn7QDwjmFivAv0LrgdXzVNgYYVu7acwh9gYduKJBL3iJgQoBE3QKTYnzqVWpFGlQxCs0v34AoM2L1uexhGXA2Io/wIkQboIf1XLQMhzYg9zdGCj4gRIK0t09ye3w3yWJnr76pd0R88e6/rbGPZf8H3hyajZD9wXexFacKWqdsACNf944i53+2XZMxevBMuK98tfjS9y+/OSpxLSPCiGIqvwx++/76mW8nQDw+MIDAjA0B69AV7TGvd8dPzAIvs8+OdnEFqZC1xT7XFo3JC/sQwDjBWTlt6tc/qTExoVCDKa73llZ2DqjQDNALQBlS4uH5J/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gxGPFyhxZD7EJzdnw91xEywTxwar21xRe4Xj3dfJeI=;
 b=jvbzgj7KzwuOR8Mt9Ws17rynDfIWbU1HRQfhK+/fK6apgaB2TXe770lI2pQDZNHcmlkqIPrY2wNZ6V4QHv4JdCIpYM/3hRVBKwl7vXmwMH2sWuMq6j4DyTVTrF6w2xaC4X4LERCmuXgPQR7QxtEZiRNquMKwusFRLyK1sJqEHiGlEYYUYYTRBA0r05+dejLcMXdbvQ52PH9n+7ZULBnApZYUtEzsnBAqEo+XZkTrwq2Uoo+Y/HD3yTRhDwcO49tUVuNf+uwxA1WwsckKeP8lyRSa4Xi7nXGHE6AHa+AFyi5J6XA0IPuB8FLrizpjIFDxyTGhB8LSd/WVnelJjx1U8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OSRPR01MB11660.jpnprd01.prod.outlook.com (2603:1096:604:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 07:59:53 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 07:59:53 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Topic: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Thread-Index: AQHaDjvxgnGsUlf/nk+PthrgEoRwxrBs8fkA
Date:   Mon, 6 Nov 2023 07:59:53 +0000
Message-ID: <27a06d26-4443-4349-801e-c09da0d57884@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OSRPR01MB11660:EE_
x-ms-office365-filtering-correlation-id: 272b14e1-fe75-4a71-afe1-08dbde9e5bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B94nzE19KELVoHAsbGHRflCnKoFKyZvZAY0SlPn2VsmSm1YOvBEcjhv/MixAYAjU8UWvSBa3AZOPpqEs3tZXbsPgMl1ahGvqy62PW9wCQVcV8xy2JT4qtfRy78LGfD+IvACAyhRdsKPSzt/FoaLs37wzr59SVZ6sLLajXYAqLBbM8aSU00WPxXBpso1iW/WwMVwFImUgWLb1JhfFw07haXmmebAxjhJK1K9DP8w8ymqfWVgz7gE5mM7NbMqwkaJ51aYdPTenElfA5pKE4Jps6HRI40VZCRw30lapQ331iTYX23u9jNIOjlk9+6IAP6OeyyXT4hxbazFAw7ebqfPre4bTv5u/HF4ZEqHcXP3jHqf+4b60pQwT1S07qkq0L6syEPQtNIAK7+wkQH1tn6vWNttTpQowPFdagYKUTcuEf7ArgJnl7ZwBbmhrhrjDarYreaicFkpk09ErZCA222XcLNk5kbePdQ9+3wi4UdTkFnnacrFpilOfuQr4BFikgesFrJh0xxYN1TXzBGCn5CSM7z8fsvZVcMUvWjVneVkc4z6kVgz2uKvbrkw/vB0zTNeYEJIyEoRNeCExaocYWS/ScCAXpwYlnjW+uVKPd4TqK2L9pq5jZJFhTg4hCaUverdSMSrR7GOQvpTesg5UoMvE63PDKKsfkPb1yBUeVjMjH3wM0K6Bkuy9I6F4dYNYxkXzeE3wy0P/frRHmCGTeFXhoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(186009)(451199024)(1590799021)(64100799003)(1800799009)(6506007)(86362001)(53546011)(8936002)(8676002)(38100700002)(966005)(6486002)(478600001)(4326008)(71200400001)(5660300002)(36756003)(31696002)(85182001)(6512007)(91956017)(66446008)(64756008)(66476007)(54906003)(110136005)(66946007)(66556008)(316002)(76116006)(2616005)(31686004)(2906002)(26005)(83380400001)(1580799018)(41300700001)(122000001)(82960400001)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWE2MU5oQW1LalFEaDNrZEVzQ2xuVEY1N3ZiNU0vVjNNL292cFI5WFFlc2RP?=
 =?utf-8?B?a3AwZHVGNEo0S0pUNlFrM3lIT2xnU2ZtdlJldHdIMHdlUTZUWURhdGtNQWd5?=
 =?utf-8?B?WmVoMzBQVFpFYTZwVUM5Wk1WTTg1RVlURG9SQ0tFa2cvaTlyWTdKNDdIeTJL?=
 =?utf-8?B?UEM5Vk44VEZyUWNFaGQrOFlHWjYxb1ZLQnlLTTNxUURiTC9TcUpocWF4NEVq?=
 =?utf-8?B?ZXNtd09DYlVCQ3hBRGU5TzRLVzJ3dGtabHFFLzVTOFFoL3YxZ0tyRTJLd2Vo?=
 =?utf-8?B?cHZDb0VlUkxxMFBMblB6TFhBMnp3SlR3TllvMTF1V1ZkRVZMaGdBaUtsdUxH?=
 =?utf-8?B?K1FjbzR6WlBDRW5UNHViV0NBc29Yd1JRQ3hYYklFNmEvUExNWkY1NEgrQ0Ey?=
 =?utf-8?B?UDhVV1VxM3VmKy9qYk5rRW8xa3g5Rk9remt5N2hVYndnSnhpN0x6RGhCMDdi?=
 =?utf-8?B?MXdFYzUzaEZhMUlpaWpzY0JCbnowWjZVcXFEbnMyR3R2aU1vSnQvOU43YUEz?=
 =?utf-8?B?a21qcWp4SktiMFhSSnV2MW1DSFlMSEVUcGhKQ0k0SXMyY2dUV0d3UGNaUVVw?=
 =?utf-8?B?R3NkdFRJa21FZUNrL29laHQwSkFZSmNjN1p2QUpuL2Z3aWtwZ1hpalRQakxi?=
 =?utf-8?B?MW1LNUx2bjFDSDB5NmFBWXpucmhZaW42RU52QzZKd3U5dng1amJTLzN4OXhT?=
 =?utf-8?B?MzU0RTZvK1dOOG9BYzVSL2VYUSs1bXUwWHZFa2xOVGVCcWhIalgrNnUyZUNN?=
 =?utf-8?B?dlFLV0xTUmxKRWE3c3RKcFozbno3c3BaR3ZPcGxCcHNtL1YwaFgwK2ZBeSto?=
 =?utf-8?B?MmVBN1JjZGlaZDduL2NXcjFIak94MmVORDhSbndiR01pQnpzSlE2djl5c3Jj?=
 =?utf-8?B?S2JySlJUVFBQTnIvbkI0NmFPek9sVHFIeTJwOEU2Q0V2dG5uc0dWVEN1OXNO?=
 =?utf-8?B?VXlKcit2SmN0OTlkZEQ1cXJVZ1lGNU13d3QzTG15Tnd4NTdOdmpYK09EdFRF?=
 =?utf-8?B?TE9zQUJ6UFJaTms2bzJ1dWhsNHZuZ1VrckdGNVZDUlBsZER6aGRmMzBvZVZT?=
 =?utf-8?B?NUg4bG9mR25kd3BFRk1DK1QwSTZRUXFjeUpVYTdRUDZTdnhjYzd4OUVobFhu?=
 =?utf-8?B?SCtPWlNkcjBhN29uN1IzSEE0TDN0OGRtL2NxNy9sYlBwNG14eGhhSk1wdU1h?=
 =?utf-8?B?c2oxNTRkQ3NmTjd1OXpWbzZ5L2FBY3BUUE9YMlBVbnRMVXJJNFVLdkNHSFBl?=
 =?utf-8?B?bVExL1hJcHFjUDduckpCdE9mQlhjOEg0QWNBQzU0ck9JWTMyak1EZjZSR25p?=
 =?utf-8?B?ZHU3T1hUSFVjWkVFWTlGeEZXSVBnZnFUVlNTTEVOaWJEbHRIdmJQRlB3VkdC?=
 =?utf-8?B?U29YQmhMSzg0MnNnWVVBajYySVFjeWcxdkpxalpIK05tMk5rUkMzdnF4U3BQ?=
 =?utf-8?B?QTN4UUFSRFZFRUUrSmszeDFhM0tlVUdKREhRRVpLWC9zOUl6QnJOOURzMzhw?=
 =?utf-8?B?YUFERDd0QTUxOUdIWVczNmM4MnpnWTd1d3R6Tm5mSXNmU2srNVYyOTBreHNt?=
 =?utf-8?B?UXVUM1J0QTN6YmJjaDBGVXJ2R3RMTC9hOFhnNkc3MjMwMkw2dGQzcGtGdy9v?=
 =?utf-8?B?MEFGOC9TekhqM1hFQXNLOFc0d0t6TGd6cENPVnVRNUtnRlU5TFhJdTBkQWlw?=
 =?utf-8?B?MGoxcm1HYkdVK3VqbFYyMEdoOVEzcmVzTlQvcWxlOTM2U1NZVEJnNkpvdGNM?=
 =?utf-8?B?WlVtd2Zrck1qdVQrSUltaVMyak13WWUzZkh0cHV6eHd5dHF1b1FzKzEyUS9W?=
 =?utf-8?B?UXdJU0NXQWMwaERuNW9lOGRPU3VERUtRZ04rOTdRYVhxSm9jMmErRWJxZTl3?=
 =?utf-8?B?R3N0bHh2QXdocm83UHJMNnMyU0ovdVN2aG05L0I0ZG5PRE8raHp4SHlJMW1m?=
 =?utf-8?B?bzEvalJ2cnZNeUlIcEJYS3QrOHFNMWI1N2pRaUZjQzJUbEIzb0p4dHJiQ1hF?=
 =?utf-8?B?SjVnaXFpdGhJcGVQd1BpNGNCYzlTRHJIWEtFVWVXTndKZG1OZm1KWWNwQWhR?=
 =?utf-8?B?T0ErZWk2eldSQTR4bkE4NnI0YW5vdk5SRzRGRkIwQmRuNW1VTWVROVpHbEhL?=
 =?utf-8?B?aTIwTnEwN0I5OG84dkVpaXRycUVzUExpbXlnTkNZcXhYUzNvNTl5c0orK3Zn?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F80B41AD3B3CF45B5B8CDA3B05C8BAA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6R2Bm0cMSJdwml0Wfz7fbQlt3U4sZihZnUbUdCj6lUKAdjGaqtAocBrCv8IjApS6zHVOYGFHCiftsqc+nrrPFRCAwr8PCGZUO53+mbPMbASonsJHv+IaUtJtpPbCgQpw2bIo6A+mkmZG6hP6XtHP0776kJVDB+3uEhma/2KVYQG6p6Z3ntl+eqo0isT8iPGnwnSt/b4dfZUrZ/pEASALNUGtjHwz5aFVL2LYxk9y+x7aUAWqoiGJhEpOKb2BwY5QtkgbGLCW3cdPUuFrzB2ilzCw5TYWZ/bKx5O8guu8Vp2H6EGtoWYTdpXQxTnbOeNMEImKsaV09dfwBI6nNoAYc0tgKfiyLWc+cs9mG5oFCrAZFS2Ek4gA2H8sXMH0QEXOuj79O1T4LOGvoYH5FOD14IHQAK/ZoFGDRkr+in/X5a6R+nKMJvlT9M+EBejjhQNPpAW6f3/R1OvUwOECXHnG28Qo06PS/uQIiweB8+/v8rvcFMxPECeTEGAKq9iqbf/H2jKKRLPmHXcO5xz06bLigBzCGz6UXhWSyexAERmEGECkKY3qtK96AWqLe6r5NbpLKQd4yM1XHbRvwiBFqVOrC8X8/8a9G4TTQLhvFbbAa2H8vD5ReLXyyt6pDHJRl90+x70kSkk4GdhgMwVJvPNnMyGpDJxiuQYR55zscrWqpp4XuwDCMMMxJ1UFMJMdKKJc7HSqEJL1WgdL8e0E3rIjlyL7rp3HbK4dLCC2tRfeYWQ1WdzP852Fe8rHT6TTdcU3pRsZFh1BRH3GJeg1v6zHT+NPCUnRrJ5XQP9Lmb6S0Xk14hwtkGjXoK3fR7zsWn8M0mtcQ2BT/uEmcRAVXUtleUdLAxDxWDt1AFs+i+9MQrYd/wT93hMxANsHVv69Maw2zxy+orcgfj1o4k/f4Q1n5A==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272b14e1-fe75-4a71-afe1-08dbde9e5bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 07:59:53.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2whFEra/RhyVlm0U/rlEGs+5nnRukM+uYXisC7QCz0a28S2dVIovaIcMUhtlc/XH/LiRXZR0EDWBgtd/guy/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11660
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNClZlcnkgdGhhbmtzIGZvciBhbGwgeW91ciBmZWVkYmFjay4NCg0KT24gMDMvMTEvMjAyMyAx
Nzo1NSwgTGkgWmhpamlhbiB3cm90ZToNCj4gSSBkb24ndCBjb2xsZWN0IHRoZSBSZXZpZXdlZC1i
eSB0byB0aGUgcGF0Y2gxLTIgdGhpcyB0aW1lLCBzaW5jZSBpDQo+IHRoaW5rIHdlIGNhbiBtYWtl
IGl0IGJldHRlci4NCj4gDQo+IFBhdGNoMS0yOiBGaXgga2VybmVsIHBhbmljWzFdIGFuZCBiZW5p
Zml0IHRvIG1ha2Ugc3JwIHdvcmsgYWdhaW4uDQo+ICAgICAgICAgICAgQWxtb3N0IG5vdGhpbmcg
Y2hhbmdlIGZyb20gVjEuDQoNClF1b3RlIGZyb20gSmFzb246DQoiDQo+IFRoZSBjb25jZXB0IHdh
cyB0aGF0IHRoZSB4YXJyYXkgY291bGQgc3RvcmUgYW55dGhpbmcgbGFyZ2VyIHRoYW4NCj4gUEFH
RV9TSVpFIGFuZCB0aGUgZW50cnkgd291bGQgcG9pbnQgYXQgdGhlIGZpcnN0IHN0cnVjdCBwYWdl
IG9mIHRoZQ0KPiBjb250aWd1b3VzIGNodW5rDQo+IA0KPiBUaGF0IGxvb2tzIGxpa2UgaXQgaXMg
cmlnaHQsIG9yIGF0IGxlYXN0IGNsb3NlIHRvIHJpZ2h0LCBzbyBsZXRzIHRyeQ0KPiB0byBrZWVw
IGl0DQoiDQoNCg0KSXQgc2VlbXMgaXQncyBva2F5IHRvIGFjY2VzcyBhZGRyZXNzL21lbW9yeSBh
Y3Jvc3MgcGFnZXMgb24gUlhFIGV2ZW4gdGhvdWdoDQp3ZSBvbmx5IG1hcCB0aGUgZmlyc3QgcGFn
ZS4NCg0KVGhhdCBhbHNvIG1lYW5zIFBBR0VfU0laRSBhbGlnbmVkIE1SIGlzIGFscmVhZHkgc3Vw
cG9ydGVkLCBzbyBvbmx5IGNoZWNrDQpgaWYgKElTX0FMSUdORUQocGFnZV9zaXplLCBQQUdFX1NJ
WkUpKWAgaXMgc3VmZmljaWVudCwgcmlnaHQ/DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9tci5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIu
Yw0KaW5kZXggZjU0MDQyZTlhZWIyLi4zNzU1ZTUzMGU2ZGMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9tci5jDQpAQCAtMjM0LDYgKzIzNCwxMiBAQCBpbnQgcnhlX21hcF9tcl9zZyhzdHJ1
Y3QgaWJfbXIgKmlibXIsIHN0cnVjdCBzY2F0dGVybGlzdCAqc2dsLA0KICAgICAgICAgc3RydWN0
IHJ4ZV9tciAqbXIgPSB0b19ybXIoaWJtcik7DQogICAgICAgICB1bnNpZ25lZCBpbnQgcGFnZV9z
aXplID0gbXJfcGFnZV9zaXplKG1yKTsNCiAgDQorICAgICAgIGlmICghSVNfQUxJR05FRChwYWdl
X3NpemUsIFBBR0VfU0laRSkpIHsNCisgICAgICAgICAgICAgICByeGVfZXJyX21yKG1yLCAiRklY
TUUuLi5cbiIpDQorICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQorICAgICAgIH0NCisN
CiAgICAgICAgIG1yLT5uYnVmID0gMDsNCiAgICAgICAgIG1yLT5wYWdlX3NoaWZ0ID0gaWxvZzIo
cGFnZV9zaXplKTsNCiAgICAgICAgIG1yLT5wYWdlX21hc2sgPSB+KCh1NjQpcGFnZV9zaXplIC0g
MSk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmgNCmluZGV4IGQyZjU3ZWFkNzhh
ZC4uYjFjZjFlMWMwY2UxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfcGFyYW0uaA0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0K
QEAgLTM4LDcgKzM4LDcgQEAgc3RhdGljIGlubGluZSBlbnVtIGliX210dSBldGhfbXR1X2ludF90
b19lbnVtKGludCBtdHUpDQogIC8qIGRlZmF1bHQvaW5pdGlhbCByeGUgZGV2aWNlIHBhcmFtZXRl
ciBzZXR0aW5ncyAqLw0KICBlbnVtIHJ4ZV9kZXZpY2VfcGFyYW0gew0KICAgICAgICAgUlhFX01B
WF9NUl9TSVpFICAgICAgICAgICAgICAgICA9IC0xdWxsLA0KLSAgICAgICBSWEVfUEFHRV9TSVpF
X0NBUCAgICAgICAgICAgICAgID0gMHhmZmZmZjAwMCwNCisgICAgICAgUlhFX1BBR0VfU0laRV9D
QVAgICAgICAgICAgICAgICA9IDB4ZmZmZmZmZmYgLSAoUEFHRV9TSVpFIC0gMSksDQogICAgICAg
ICBSWEVfTUFYX1FQX1dSICAgICAgICAgICAgICAgICAgID0gREVGQVVMVF9NQVhfVkFMVUUsDQog
ICAgICAgICBSWEVfREVWSUNFX0NBUF9GTEFHUyAgICAgICAgICAgID0gSUJfREVWSUNFX0JBRF9Q
S0VZX0NOVFINCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBJQl9E
RVZJQ0VfQkFEX1FLRVlfQ05UUg0KDQoNCiogbWlub3IgY2xlYW51cCB3aWxsIGJlIGRvbmUgYWZ0
ZXIgdGhpcy4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gUGF0Y2gzLTU6IGNsZWFudXBzICMgbmV3
bHkgYWRkDQo+IFBhdGNoNjogbWFrZSBSWEUgc3VwcG9ydCBQQUdFX1NJWkUgYWxpZ25lZCBtciAj
IG5ld2x5IGFkZCwgYnV0IG5vdCBmdWxseSB0ZXN0ZWQNCj4gDQo+IE15IGJhZCBhcm02NCBtZWNo
aW5lIG9mZnRlbiBoYW5ncyB3aGVuIGRvaW5nIGJsa3Rlc3RzIGV2ZW4gdGhvdWdoIGkgdXNlIHRo
ZQ0KPiBkZWZhdWx0IHNpdyBkcml2ZXIuDQo+IA0KPiAtIG52bWUgYW5kIFVMUHMocnRycywgaXNl
cikgYWx3YXlzIHJlZ2lzdGVycyA0SyBtciBzdGlsbCBkb24ndCBzdXBwb3J0ZWQgeWV0Lg0KPiAN
Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUhqNGNzOVhScUUyNWp5Vnc5cmo5
WXVnZmZMbjUrZj0xem5hQkVudTF1c0xPY2lEK2dAbWFpbC5nbWFpbC5jb20vVC8NCj4gDQo+IExp
IFpoaWppYW4gKDYpOg0KPiAgICBSRE1BL3J4ZTogUkRNQS9yeGU6IGRvbid0IGFsbG93IHJlZ2lz
dGVyaW5nICFQQUdFX1NJWkUgbXINCj4gICAgUkRNQS9yeGU6IHNldCBSWEVfUEFHRV9TSVpFX0NB
UCB0byBQQUdFX1NJWkUNCj4gICAgUkRNQS9yeGU6IHJlbW92ZSB1bnVzZWQgcnhlX21yLnBhZ2Vf
c2hpZnQNCj4gICAgUkRNQS9yeGU6IFVzZSBQQUdFX1NJWkUgYW5kIFBBR0VfU0hJRlQgdG8gZXh0
cmFjdCBhZGRyZXNzIGZyb20NCj4gICAgICBwYWdlX2xpc3QNCj4gICAgUkRNQS9yeGU6IGNsZWFu
dXAgcnhlX21yLntwYWdlX3NpemUscGFnZV9zaGlmdH0NCj4gICAgUkRNQS9yeGU6IFN1cHBvcnQg
UEFHRV9TSVpFIGFsaWduZWQgTVINCj4gDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYyAgICB8IDgwICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmggfCAgMiArLQ0KPiAgIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggfCAgOSAtLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDQ4
IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiA=
