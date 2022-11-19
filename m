Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB0630E18
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 11:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiKSKbC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Nov 2022 05:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiKSKbB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Nov 2022 05:31:01 -0500
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40AE6E56E
        for <linux-rdma@vger.kernel.org>; Sat, 19 Nov 2022 02:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668853858; x=1700389858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zq6eOEqgZyyvACL9rWVY5952gCx7CFnn4UaQc3XNGqc=;
  b=t5iJHlnZ4ur7yHtmuUlNzp1yRHpBnCGnJ4djaH536NMY5sRfWs3GGIKl
   EnE49uqAC2SLLWIGxXv1H0PRA5G1sIuLHPVMYMUZ2z2XVTPJU79ncqkix
   2nu2Oqw6LzOoCMZXfG7pFwBhxlPs3ue1MtMmV+azGhx1rydSOtIVEOQSs
   EBGTPhU+H0MD5LZXXLWneNX+VTxeWMUPpd0XTTF/5LJVEGxOiXMwN7LIn
   EVCxV1Fu7V+XH7zg0l5BRSrFjpoEnLtRxXr0RZESQV1wyo1J366oamXe6
   dt4FfUw+UEQ0Qr4tOnlNaSVyBGdK/VVDBP1YGnbUi7QNbyxGRFC29113c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="70515375"
X-IronPort-AV: E=Sophos;i="5.96,176,1665414000"; 
   d="scan'208";a="70515375"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 19:30:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL7NmiE4mmScArmzeGpuvh3Rw1crBqUDZ71UJo8QNmeZe/cOVSRWT4SxCYEGKBpFiH5lY0K4xXheFp9J8LR6/jSehs29xyvFLpPAjaXnzZLrPIwV25VS5MZujdVRsyVnSHafwyQj87EA1E49aXcH+RFWo8pYjzJalp/gEj0dSrx/hrVzQR0PaTR8FIwi/Kxb2uyoZuyp7T3FJ4eEJzI8lx3WAe/UtN1nXU397UwaTkLKdxLoKotSiS4d8gWkROtZE+NbwzmSL9swnkyWVU2TCRs62KAIBGUxG0azKG9UpaTZbAHP8Sp5N23ObzBr+LroCMEdN2e85OKOSR0zpQMAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq6eOEqgZyyvACL9rWVY5952gCx7CFnn4UaQc3XNGqc=;
 b=UGxLQ9kPsJVoM/axKXhLSIAH0v1ttHT4VKspoSfYAOJkm6+sRgY5TQ+2tZHk3UyOjpxyQ3buDC6NXENTgtFBak/gd8CYAZBJWnWpzVcthIHKI0HVZtp6HlRd42rgTbhx/g7B8enLpNz4D6qgAKo8n4RBbLuFuy3dc5FS9gkowHOPfPrfuB/THWPCWJkLotr1SggMc09gqnVy45WBVYB5VIDJvx7Zv+zusHNUZ+NxFr2oG/9wcTqauYDlKJ89CHlmopOjhx84j+WKTQPSUtywdl3wgSm47hGpXVIWaJJ1HKW6AR4llaKQUhSmkqbVGfAUuUKAfUYtfB/nyDaxhWE9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OSZPR01MB9426.jpnprd01.prod.outlook.com
 (2603:1096:604:1d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 10:30:50 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 10:30:50 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is not
 highmem
Thread-Topic: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is
 not highmem
Thread-Index: AQHY+/WkoV4EhbKyWE2b0o/MXgaFq65GDA2A
Date:   Sat, 19 Nov 2022 10:30:50 +0000
Message-ID: <4a9748a0-59d9-4094-8895-6f2194eeb521@fujitsu.com>
References: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
 <20221120012939.539953-1-yanjun.zhu@intel.com>
In-Reply-To: <20221120012939.539953-1-yanjun.zhu@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OSZPR01MB9426:EE_
x-ms-office365-filtering-correlation-id: b9a8aac4-c0c6-4dd1-0c6c-08daca1920ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZoS02Vz9PSscxzR2jl760Uq1S5UXMINBPFw6JrxtfC6nT8EGFGLwufhDdNSRWSEuhJ0mVnDFNVKnJ1MupPzaTgFoWr2Ew1WKRPdA8WG9OZkf8s6mEcN708Mgzn/qXOSWiCv7WpTvqfTsmM3zIPw92JlKWr5KyRutQEhaEUCuAjn6quSQMHhk/DnyEPXYl8+FTkKH9ihKRF7x7fecTsAk+u63uXSNZ+Z4f2pREYzB4IRXtJCVIA3p2N9nIrRUkBRC2c2xdh3zc2maukI9LFLdKoaQHSlRbp1ZKjVomjtREMJXKoYDcHTW8L7uXeGym9ojXa45KBzhrBYkbTsvVrrKugqoK3MoQ5F+SDn0491H4S07HRr8Q0G7h6Qvd0DxMXsUE7+8RTmbXq12/Y7aAkJdkXS7HS15/ZLJSzyLjNqyXStM40WmzUiIi6JE4pU6M7TZxFOZzWz4RZcjCmFfmMIfsgYni+pYfu5RW2shtsY+j3+K4mLF37cTwjnrgATSPep1Av0l2d8D8UFoK2mtk+7HI6tE6nb6io1DZi+mUNgfqNto4Asg/JHWb+diGd/l8m1ZBmidqiRk/FqTxcBqECAidyOz8s+60znXK1dOGW/ul9JDIHFlwd1NcON8IWqZBjayJWgMnvIuVjw8CZwXH0CTy89qNu+UoyobZnbIwgnLrz4lgByubLFZ0gwGDiacQEmNlD1s+fbZRMO5AXCMtSyWHEY/51V0QZERoSMCzJIeJGenLBEA3NWcWQ6tCGN6HTIivt8Qc4M5WV/LasnOx39WVXyVbi1/kusvqCA+qQDXfUREa7LCeEV9qm/goRHudxfBQzrPhdP61Dj1b2E2/YdO/TJj2ysyxwK/2rrbPE3mb2iHbbG6yelEgeBZP4oNE6t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199015)(1590799012)(1580799009)(31686004)(85182001)(36756003)(31696002)(86362001)(38100700002)(82960400001)(38070700005)(5660300002)(8936002)(2906002)(83380400001)(186003)(2616005)(122000001)(91956017)(316002)(41300700001)(110136005)(66946007)(478600001)(76116006)(66556008)(66446008)(6512007)(66476007)(6506007)(4326008)(26005)(8676002)(53546011)(64756008)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGt1N1FYNkFZYlJUNktnR2dMZEhMWHByVmFZZXR6aFNiZndKcVJUMUw5THds?=
 =?utf-8?B?ZFJ3a0ZQTklhWkc2UUkrRzYrRzMwNE9TcXByRklNald0K3Z5QkJVY3hRTUJX?=
 =?utf-8?B?a0YrU0IvWjUzM0ptaTVtdVFYZVBvR1A0dDJTNVNoa2EwQmVLMndpY1NnN2NJ?=
 =?utf-8?B?YmdETTNDOTZBcS9ZbEcxS3QzbnBwM1Q5dVNqc2JJdjJ0UjNRUzhkSFovVnpQ?=
 =?utf-8?B?YXQ3QWptMnZ6bFpwaEdzMzZaeDR0bVdUU28xQi9tcVlEWkFHaXVSc1RKSFI3?=
 =?utf-8?B?dlc3VTBER1A2RE4vSkFocElocksxaWtzNi9STjhaMWFnWFQvcy9sZTJRU2JZ?=
 =?utf-8?B?by83WkxuUElzSDJwczZUT25ZakpSdHU2U2RlcTIzMThvZ0J5RVJEbUgvR1JX?=
 =?utf-8?B?VXJjeURYMzJmZ0l6YXVEZU93STRQU3V5dk83eStPcy9TUmI5aitVSjNWYTQz?=
 =?utf-8?B?UjlQWkYxc2E3dWdMemFoQ2FnM0JJb29mSjJCYldXWW1ITFR4KzNDSnFmaHN1?=
 =?utf-8?B?d09RTi9yRVp1WEd4ZStSNFlHUy9jSUZ6bld0OVF5U3RnUHVsNk5nK0JuU0tl?=
 =?utf-8?B?SVBRWkhaOFhJb1g4akRPMzRML2lZTEJzS1VIdStBRTFGR0JLSUFmUzFQZlp6?=
 =?utf-8?B?REJ4YnZwRkl1OFh4S2J5NGthQVpwczlOUVJ3NGRYODc5SWNXMi9EN25sK1hk?=
 =?utf-8?B?M3ZCTXNqRGJBWjhraEJWTUFocC9UNUsyWjFSU0lkeWI2TmkwRkJ0WHM5blFZ?=
 =?utf-8?B?dnRCNHQ3UGdYMG45T29mR1Zobm5MZHdmSzJvcVJ5UWVaRkx4WmNlbS9iSTFn?=
 =?utf-8?B?dnlKTFpVV3J1MXFKTDRmR2pmeHpxL3A5UHhDMXdoZXZNYm0rZ2NuOW4rK3Zl?=
 =?utf-8?B?S0ZrWjh6dzFFaWRGakdhZm5wTzdHWityRVdYRmRCczYrSXM3c0FNSndZU2Z6?=
 =?utf-8?B?Q0dnK2pCMk9NbVVqRnhxbVpxa01sUHVDZnF0dzVIbCszQlRoSVJ1MFJuT2dU?=
 =?utf-8?B?QnlPZm5Ra1pTVVY5RTh3UEJTSnloVWFrdVhXTWh3ck9OcVhobjlyYjNMREFW?=
 =?utf-8?B?V0puV2RrUnYwdHpGTzE4NGQ0ZVJXa3BhSXIzQ0VmMnYrVGFTSGdvNE0rWmJT?=
 =?utf-8?B?U0NYVzlXVmZGMW1FSGZWMWtRZDVEdTFpUUE0UWNDbGtaRjQxRVpEUStOZEdy?=
 =?utf-8?B?d2ZPL3JqNndFVWRLNG9qK2lCRGtlSUptRWYyblhoMlNhT2FzWEg2eWNianhF?=
 =?utf-8?B?dUNma3hEaEYrUzdFY2taUEkwOFpvd2I4Vk1mNTFKRFg0VUZtMDU5SVFUL0xh?=
 =?utf-8?B?TkVXWlVwcGNlOHhwYUp0ZUxDR0M1TEdFNHE5cEo1L1p3MDBqS2xEWFlENHh2?=
 =?utf-8?B?Z3lHZGUrdENCalV0WlVBTUhCbGdzTlpDVkhmMGxmR1d1UXVldEptOTkyUWVB?=
 =?utf-8?B?OTFTV2txQU1IZG41eUNZQ1UvZmtXMU9GWVd5NDN0b1Q0UytidHJ2TjhWcHR2?=
 =?utf-8?B?ZTV2dDB4cXNwdUNwUGNpcWdESnJMYlB5OEd1a014czhnYzVEbHljWFZON0FU?=
 =?utf-8?B?anRQNDNJOFhXcThZVTN1bkZCSmY1cG5pdFNSSlUycUFMaTk2dVVuOXlHYzFa?=
 =?utf-8?B?Vmx3K3JiWUdPQUo1RkZ3OTkrKzhodFlmMkpBSjNyKzBNQXd1c1hNaUxOVWEw?=
 =?utf-8?B?UWxKbjlMYlBTdXlkdkJnRkptM3lkRkx3eVhobEpRUmd0cy9ESFZvVDNnVHZs?=
 =?utf-8?B?cHNIejB2c2FCSzExZ0dEM0Y1d0pMU0VObTlPZXE0L2FhV2p4Z2tZR1hRL29H?=
 =?utf-8?B?NWhMU2dJc3ltV2dTWklOeXFGYzNId3BKZkNQdTRNc2dRclhiNzN6ZzJXemxE?=
 =?utf-8?B?WU4yYXdZTW02anF0YkY2eDZaMkZlMFhpZUFOT2RGT3dxNnZXRVFyVnJVRnI5?=
 =?utf-8?B?b1BRRFlEM0FvcGZSb2NrRzJUbWYwaDcvWE5sZUh5aUJsRVhCWUFXVkdlN25L?=
 =?utf-8?B?b0hCcXUwRG9qOVhHamhiamlaN2toKzBMajRsdWdlbjc1KzUvRzY5ZW44bHZj?=
 =?utf-8?B?NFlPNjhaSjYwT2Q2MWxzR0ZMQmkrYi9MSlp4ZDBTUDVVT0lQUklBb3drRGVl?=
 =?utf-8?B?Qit2UXVnRDZkUFRERXBaUkt3am4vVmh3WnNaWXJhd3poaUtOejFHaFBGa3Bi?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6E37A75994944293B647DCDD712130@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dYnyEC4irU9mOFsXQ/K8lGs3dA3qYJnDaCHzJKKZdigZE2Kz+FicsQ0IzG+QPRUw6qcNOgB68vVL5bkqFbmazBNWGq2Ck89DM9dl5m9DKzP417DhxAp8qjXy8MNs/Eq0l4dJr9annQA9Bt0NmWyBjmQ7NjJxdtMVEPVBvuL4j/T32OiQHkpRmTa6XXZygCrrBnVKZug24Ke2LTP6xN4rnVOmdBg0B/NXmd+d5NYl86T8Ke3LtXYYkugP+1+2H4ndXif2g44obm7kl/+Pn6NM1uSXm5/NdHT+tUD8soNIuh0zLhdaWy0O4r0kPDTYzGrzLMf8TBNwD+e5U0h1uVxZs7O+YPn75QrvOpGGg+HFE480jrJBYygCoYwBAbltCJuJ/+QefzV2BfF6DmjGAhbnAJdiQSQ54hbLmdrlH7akp2U3+PjZLEarbt41cgVCZcYgAQ5YChXsHospyj0TRYcveN/rmmTJUC8jcJ/R5OMF4714tpFDMiVyHnSm1klGMxwGVSruWmhfYgmyhhrXuDsZ3Db9aNuf9c3W8xnT1NO5JsENKIiAqPBlI6UVCw9b2YjKYc4fToTZOS7hAEiESLoUE8SSLDEpmfI7wtznAwPTFHdp5LmaoSV/bO9tF5z2zkIAqgAqt8y5aQIu7+JRujbicmH5ytrn4Rtd5nnrUvZl+hue6mHk/MzqfnwuISCGj7kao2E89HqmvCz/FC+CHndHxr2FbapqNv5TBEUF7Uqn3KDIi6C/dZpLmIEDr1dadMh92uOl//OjqOg0rpR8LPrAUc9TKz9NdgCfg/Coc7R886bKVsCKMeGyAfZAr44V/75WdDsdwL5VMhKNy5mWIAndXbJcBEnY1ETDuOXWzjnwC70ytSXj9pDuMFD3t9m74Ksg34dQHswkv7Q/HPxiaMQbmtIo+2/mFcTllGTTPi9x6EM=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a8aac4-c0c6-4dd1-0c6c-08daca1920ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 10:30:50.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVz2WnyqyTiUsubUL5hRNwhWS+l6FYhe0TdPFkIJm+iBK7s9OSw3Ck+qE96EIVxBWsZ+fWpIOKtueKEsCbseoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9426
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNClRoZXJlIHdhcyBhIHRocmVhZCB0aGF0IHRyaWVzIHRvIHJlZmFjdG9yIGlvdmFfdG9fdmFk
ZHJbMV1bMl0sIHdoZXJlIA0KcGFnZV9hZGRyZXNzIHdpbGwgYmUgZHJvcC4gaWYgc28sIHlvdXIg
Y2hhbmdlcyB3aWxsIGJlIG5vIGxvbmdlciBuZWVkZWQuDQoNClsxXWh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvYTdkZWNlYzItNzdkOS1kYjRjLWZmNjYtZmY1OTdkYThiYzcxQGZ1aml0c3Uu
Y29tL1QvDQpbMl1odHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1yZG1hL21zZzEx
NDA1My5odG1sDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCk9uIDIwLzExLzIwMjIgMDk6MjksIFpo
dSBZYW5qdW4gd3JvdGU6DQo+IEZyb206IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2
Pg0KPiANCj4gSW4gaWJfdW1lbV9nZXQsIHNndF9hcHBlbmQgaXMgYWxsb2NhdGVkIGZyb20gdGhl
IGZ1bmN0aW9uDQo+IHNnX2FsbG9jX2FwcGVuZF90YWJsZV9mcm9tX3BhZ2VzLiBBbmQgaXQgaXMg
bm90IGZyb20gaGlnaG1lbS4NCj4gDQo+IEFzIHN1Y2gsIHRoZSByZXR1cm4gdmFsdWUgb2YgcGFn
ZV9hZGRyZXNzIHdpbGwgbm90IGJlIE5VTEwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgWWFu
anVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfbXIuYyB8IDkgKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYw0KPiBpbmRleCBiMTQyMzAwMGU0YmMuLjNmMzNhNGNkZWYyNCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IEBAIC0xMTksNyArMTE5LDYgQEAgaW50IHJ4ZV9tcl9p
bml0X3VzZXIoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1NjQg
aW92YSwNCj4gICAJc3RydWN0IGliX3VtZW0JCSp1bWVtOw0KPiAgIAlzdHJ1Y3Qgc2dfcGFnZV9p
dGVyCXNnX2l0ZXI7DQo+ICAgCWludAkJCW51bV9idWY7DQo+IC0Jdm9pZAkJCSp2YWRkcjsNCj4g
ICAJaW50IGVycjsNCj4gICANCj4gICAJdW1lbSA9IGliX3VtZW1fZ2V0KCZyeGUtPmliX2Rldiwg
c3RhcnQsIGxlbmd0aCwgYWNjZXNzKTsNCj4gQEAgLTE0OSw2ICsxNDgsOCBAQCBpbnQgcnhlX21y
X2luaXRfdXNlcihzdHJ1Y3QgcnhlX2RldiAqcnhlLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsIHU2
NCBpb3ZhLA0KPiAgIAkJYnVmID0gbWFwWzBdLT5idWY7DQo+ICAgDQo+ICAgCQlmb3JfZWFjaF9z
Z3RhYmxlX3BhZ2UgKCZ1bWVtLT5zZ3RfYXBwZW5kLnNndCwgJnNnX2l0ZXIsIDApIHsNCj4gKwkJ
CXZvaWQgKnZhZGRyOw0KPiArDQo+ICAgCQkJaWYgKG51bV9idWYgPj0gUlhFX0JVRl9QRVJfTUFQ
KSB7DQo+ICAgCQkJCW1hcCsrOw0KPiAgIAkJCQlidWYgPSBtYXBbMF0tPmJ1ZjsNCj4gQEAgLTE1
NiwxNiArMTU3LDEwIEBAIGludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVfZGV2ICpyeGUs
IHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlvdmEsDQo+ICAgCQkJfQ0KPiAgIA0KPiAgIAkJ
CXZhZGRyID0gcGFnZV9hZGRyZXNzKHNnX3BhZ2VfaXRlcl9wYWdlKCZzZ19pdGVyKSk7DQo+IC0J
CQlpZiAoIXZhZGRyKSB7DQo+IC0JCQkJcnhlX2RiZ19tcihtciwgIlVuYWJsZSB0byBnZXQgdmly
dHVhbCBhZGRyZXNzXG4iKTsNCj4gLQkJCQllcnIgPSAtRU5PTUVNOw0KPiAtCQkJCWdvdG8gZXJy
X3JlbGVhc2VfdW1lbTsNCj4gLQkJCX0NCj4gICAJCQlidWYtPmFkZHIgPSAodWludHB0cl90KXZh
ZGRyOw0KPiAgIAkJCWJ1Zi0+c2l6ZSA9IFBBR0VfU0laRTsNCj4gICAJCQludW1fYnVmKys7DQo+
ICAgCQkJYnVmKys7DQo+IC0NCj4gICAJCX0NCj4gICAJfQ0KPiAgIA==
