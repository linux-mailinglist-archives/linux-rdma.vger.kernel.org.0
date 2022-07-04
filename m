Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31621565890
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 16:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiGDOYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiGDOYq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 10:24:46 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 07:24:44 PDT
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF8262D
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656944684; x=1688480684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GbLx0jHy0Xf32H68qeCLYAiNwb8oCfeAHBVnoZdDhus=;
  b=Md+bDIaGzQrmhiONpA2HWBG2KAW3UfQGWaO/N+UZjTRpAKADBfuyTi45
   PPZgxB4RfmKpfB7jgypCCouyNGSjItI2XlnQs/rvML5n1H64fzLuf06Cm
   2jhoPp8bxkEYO6ntEqWRISiXjihzkRhCvfOgpso/D0RSs4qpxYSPwje4V
   JwAVq5m8wsCJ4SejEJcKYG7h37441qpSQzi4OXzcsuAxeTje/CmrlExzn
   qQ4i7IyWK/KSJXwbSx42iHMqf7EW0/cyU4RYhiGXUMial5xMD9W5QnXCr
   qvaOZ3S3XZ9x1+wpjtwQiFxHM6tbuSEtakYHUJvg0GxwQLsd4nRvrUYC1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="59703800"
X-IronPort-AV: E=Sophos;i="5.92,243,1650898800"; 
   d="scan'208";a="59703800"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 23:23:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3AiAM7eyV5gzM4GF098irVRgFrhN8NxkXLpb4qHOqLH4gjORnhLy5VhCVWhRyxLZvHBaF9PoKbmcMEhQHGcw1E9aYCych5EPWstuqXb4KS8VSoFEN45iflPWKq10MgKbVyIxrfdbOjyUufSIHLBsW3k4a9hSzABUb0sZluBcb8LxxE+ZG47PRzh9BlucUJwG0l2rer4IdBS/5kmK/bq6cI/nSyUhSEOWpAg4h24xgbwx6bZ2AdRTcEfUZaa03DIuY9c7PH02m0Ry6/wESY8q1DyhWl8zlE+b7MFNT6zKMqQ24O//fAFR+3vmnVf+K/PTo0e72egf8F3i5w2Hv3rIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbLx0jHy0Xf32H68qeCLYAiNwb8oCfeAHBVnoZdDhus=;
 b=OTaba8gtMNmaVmfdr52/UlO0z5ZQuny7GQg/4XObwRWA3hpfhsnXLeM077ylI/cGFcgYTrBpy5hhGUSpYFGHvbLlrIEo24un71WORrqu8XtlDF1jPPyoaqSMFJtyK+uw2GbomcBR+w30bTn7KZIXyK6yWcxhbr0mfpOWf+gDgAJu1n4ir29IYssCJq+KAMgtqnXEtpOLsOyyZ4dq4/984yO3ftNm0R8kOwq2zbQJtzh+qbf4lPOpR4LtIXFJRWJaGGKUDPMkrpJVDRmGPTArASMuUGzmvsG7ikz+k37WOPycLAuDXQrmYzP6ON8Houv9JmRCqKqQfPvVSyuk8PEq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbLx0jHy0Xf32H68qeCLYAiNwb8oCfeAHBVnoZdDhus=;
 b=VIy7fH9ic3sdZnWwaCP8RRVOAcNVmyyTO/J1U13RfHABqDo5XC6Aiiw24zMbGK6+kXoEvvShGi+VAliliLnLHxmfOHbBJSaNgrPwkHjPFr6B4U2JDLjpuVuxfGSf25yyHb5SWxdPgo9njbQKz2Kg9XCtVKHyXC2pgJeUnmBWMTg=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB5741.jpnprd01.prod.outlook.com (2603:1096:400:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 14:23:35 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 14:23:34 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Process received packets in time
Thread-Topic: [PATCH] RDMA/rxe: Process received packets in time
Thread-Index: AQHYjvV3J3G5jMjYaEKK5RDdGO522q1uLNCAgAAYjIA=
Date:   Mon, 4 Jul 2022 14:23:34 +0000
Message-ID: <fde68be8-d067-f0d3-b2e9-2226e0e45f7a@fujitsu.com>
References: <20220703155625.14497-1-yangx.jy@fujitsu.com>
 <20220704125541.GB23621@ziepe.ca>
In-Reply-To: <20220704125541.GB23621@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66f27467-6b55-43fb-2c5b-08da5dc8c791
x-ms-traffictypediagnostic: TYCPR01MB5741:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ny64rO61+SY7fpwzzHdKkssLRKbs3dYQ019Q+HmfPueBTBUumVbXM5JOVzxeogMnhLHubqR0mXfIdCtAOi8Hmo6prTNhQGbgrgrufNxvJO1fB4Q9MhbCRY47zEfQDhs6cdwKsVsSuEkuma8+ArPFML86V8l214yiP71yFgZSEZ503vtG56nV15JiPi3JtaIE4OvHtmaUKRufnsNrwoRetUP/pAMbe/+2NRh9N6iMhmsXZJdTmd9Qo5YVqI8x5fu0tjJ1LyBnHBS4i+9FrLlJJI7sWEB11EgHz6JCeU1O7we/T4xCn2+Tojz4HAvRoFmV8uGAWfGkAnFwn4obxPyZeMzHNbPtcsX5Q0sHSwq8ovr9kZjWp593xT+Nn3cOuknPhaiMmU28P05Xsr09ev1gG8zpBa/i4XyTJFKS/OJShllsJTSCDUDoldkWXo25UL+UWBtCX4KkOs2GtM88yXf9oACTTCFeHZ28/dX1WBDev1I5lu2k28Au4zX1G+07o/owaYIgeEvtbSDli9b7Gbk0IAotDI94wsu8mZ00Pmyl1AH65TY5k9vYexgjB0Ja2+66XgEQg81dzn9MJb/50SujAj8wFTYYkrDQubuVWSim+BkIqm9H7sS6BtlRIxFIrPf3J+KghxtTln37XV+9OPtnOk0ToywdA3KChGi+1nZq+ONKz316bUqr+PvhVPS6IkNzN84cknESciQ7Ph7uMg0WdLP78JtFHiEOtpHXYu6DNxhWDjR3XIg8ZK495oaPDMcMHLqPpgvxkh9sN/lC6asQnqFv8RdiKmZZPnBSmXim83euVeRokbdmzCFasqQo0rCsRP2pe4NuMraoguYVoUF49nHnt309nD2r1LHrd/+obUU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(4326008)(6506007)(8676002)(316002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(6486002)(478600001)(41300700001)(8936002)(110136005)(54906003)(71200400001)(91956017)(5660300002)(31686004)(4744005)(2906002)(31696002)(85182001)(36756003)(86362001)(82960400001)(122000001)(38070700005)(2616005)(6512007)(186003)(38100700002)(83380400001)(53546011)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStPdXgxd1dlY0JwMkR0NmQrVkxYOFVRSmR4eC92UGU3NTNodjJDSko2V00w?=
 =?utf-8?B?UjdhcmhGOTA4U0VIMCt4VzEwQ3RsZWRiZmVRUDdOS2phQmkzYmJzRnNOdFVq?=
 =?utf-8?B?cElueDh5TVVEQnlROENTR2ZZUTl5QkQ4UHhsekxrRDJhLzJFK2s3MXNEOTlY?=
 =?utf-8?B?azZQK2l1aGc0QnA5VnVVMElmSFRvbXU4K2RwQ0tGNms2cXliQVd5UHNONzVi?=
 =?utf-8?B?RG8xQ1JiMTBzVUl2WjkyWXp2TENPMXh0SFhRb205WVJNVEwwdXhpK3NTMlVG?=
 =?utf-8?B?dkpXNW0vdFB3U2c1TzVSTHdHbGpaTVpBMjRkdXZFRFdUQzR3SmRGSGlQcmUz?=
 =?utf-8?B?b2VCcjF3UHhBNGZuOEoxZEZUcXdITklTaEkyTEJaaFpJRks2cUt5VHY1OUVt?=
 =?utf-8?B?U29HdDRFaGk2Vlo3Um5HeENGYUc0ckoxR0luQXR0M1UxVHhCVmI4NE5sSTNL?=
 =?utf-8?B?WnhuYk5uWmFQclRQYWptcVJRV0k5Q2NybnMwMVd0Ui9YejM5RWRlYTBBWHhN?=
 =?utf-8?B?SmVoSTVZbUJvekRoSmlzNXMxdmR0a0d3b0NRaHh5SXcxbE9aRUNiR0hkTE9a?=
 =?utf-8?B?QnJZd05WQjNpSGNyQXgvQWRvRTd3L2RaWmZySjNSV3hGaFNZVW4xWVVxWWph?=
 =?utf-8?B?c3lNMkx5TWdqUFhMYjdYTjAyQWlKVS9lNUNadGdiWEVRL1RVL09WRHJhMVly?=
 =?utf-8?B?QkZUSi9ESEQxdXUyWFRZRGZIU0xUYzNyTDRUUnJjM3RUVjk5MVM5NDV2RExa?=
 =?utf-8?B?eGRYdlM4NDYvZFdSQWVLUzNudjlsU2o3aThrWVVGWE9SdlZETmhOQktPU1Ni?=
 =?utf-8?B?enpMY3JUYzU0YnRXR3dLRUxLSTZRTjBzTThlVzZRMUhDRWU3NElicFJUbGdo?=
 =?utf-8?B?Vld3a2ZIa1hCYktzL1lqTjZaRnRtdDk3MjBka1h2STMyYVhUWjRHOG15Y3cx?=
 =?utf-8?B?TlloTFJMcE0xUFhEZGh0WFIxeTFPUTdQQjRGQnZuWEZuZ1czZHN6S2NzWmNv?=
 =?utf-8?B?SkNrbW5HWkdpeExqcmJiUzh2K0JZOE5IUEV0N3JzcithV2FCZUxIaTRyU042?=
 =?utf-8?B?Q3lMT3RpSGhoSTZLeCs4MG45SHJFNXRVVnV1Sm9sZUxsc0dnS29kUDVGNC94?=
 =?utf-8?B?ZkMyU01YZ0ZuYXpqS3VsVzhlOHZFNG5Pdk5MYTlaOXRRVnBXNmdGRWphS1BM?=
 =?utf-8?B?YTFVVlk4OFgxWldzVitJWWFNWUwrVS95aVY0YzJuS3BoZllEQ1ZyVVgrTFdx?=
 =?utf-8?B?R3NZcHlmZTBBWFFuUlRKZmx2MlRYYTdGWGVnZGFZNHlPNmNuT04zWTJjNlM5?=
 =?utf-8?B?cUI5eGw1Qk9GcGRiSW1PNVNwV0dBV3o3Rzl5R2FqMUxZVUFJK1RwZGZjTTBJ?=
 =?utf-8?B?VVJDbkZaTzJxSGpPK3F3ajFDSmpJMGVCZlV2OXVLSnpaUUZVcEJaNDdkR055?=
 =?utf-8?B?YTBQZTl4d1BvZkhUOE55a3d3a3BVQUp6YUJWZVdnV2d0T1ROR1VKR3c5ZWl3?=
 =?utf-8?B?Ujl0cmtIWi9mTU8rRTdoSDVRd2RSWS9NbGpLVWNyOTR3d3kwQmN2dDVnZlV6?=
 =?utf-8?B?M2RJbzBVV3ZkWEFpUHcrNUkzazhXZTZKZGJ6UkVkNDFWdEVZVTgvZWFDRVFO?=
 =?utf-8?B?OEJVbUQ0QmpJTkVndHVxQ2RzSGNET3BhUy8zTkU4V3p1VGt5R1FQYlEwNXNY?=
 =?utf-8?B?dWZCZ2wvWnloSjJvbHhyT1ZTSFYwMGEvczd0MWtuWEZHR0h1aXg0Q2NoMW15?=
 =?utf-8?B?TXJXU0dLaVRNMjYyOVRTSVRZU04zbXdONm1YamwvcytmWnJrTHNNdlFSY2Z1?=
 =?utf-8?B?RG96UWhmVHMzekh1dmpTWGdCMnQwZURlWjFsUmlzeFc4RzZBL1BFaTVXSnI1?=
 =?utf-8?B?ZU5ZTUlQWDFBU051eXVGQ3c1WHh6bE1nSk1EcS9HMXZBVUlrV3R3Zml1dUJx?=
 =?utf-8?B?NEhZbkRmODhMb3lZbDdvcHEzZnNOVFRpM2FBM05FSlJKeDBVNVBmTzVwbWEr?=
 =?utf-8?B?eXEvaFQ2aEpzUFl2WkVjMS9IV253U3diMHVBN0VmaGNHM0VkcnVnY3dZSmtE?=
 =?utf-8?B?WHV4TGZJSTR1aFV2anNWWjJ3dU52TEgrbzZ4TndWdlJJeUtlcnBsa2M1T2Ju?=
 =?utf-8?B?RzVOMXYzMllxNFkvNXgyM2VOQUlrNDhQSi9wZkM2SWFNb21HTE1zeVkyNzd0?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E71E541FDA44754C9B16FBB16E0144E4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f27467-6b55-43fb-2c5b-08da5dc8c791
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 14:23:34.8900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EnG3XFn3LcOwBwH9h19K81Xs2DTOZagMz9UesXEeOICFGc6w2+ftQm91Tl+BU31feD5Cgo53+0DwUzTCW96wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5741
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzQgMjA6NTUsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gU3VuLCBKdWwg
MDMsIDIwMjIgYXQgMTE6NTY6MjVQTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPj4gSWYgcmVj
ZWl2ZWQgcGFja2V0cyAoaS5lLiBza2IpIHN0b3JlZCBpbiBxcC0+cmVzcF9wa3RzDQo+PiBjYW5u
b3QgYmUgcHJvY2Vzc2VkIGluIHRpbWUsIHRoZXkgbWF5IGJlIG92ZXdyaXR0ZW4vcmV1c2VkDQo+
PiBhbmQgdGhlbiBsZWFkIHRvIGFibm9ybWFsIGJlaGF2aW9yLg0KPiANCj4gSSBqdXN0IG1lcmdl
ZCBhIGJ1bmNoIG9mIGZpeGVkIGZyb20gQm9iIG9uIGF0b21pY3MsIGRvIHRoZXkgc29sdmUgdGhp
cw0KPiBwcm9ibGVtIHRvbyBieSBjaGFuY2U/DQpIaSBKYXNvbiwNCg0KRG8geW91IG1lYW4gdGhh
dCBJIHNob3VsZCB1c2UgUkRNQSBmb3ItbmV4dCBicmFuY2ggdG8gY29uZmlybSB0aGUgaXNzdWU/
DQoNCkkgZG9uJ3QgdGhpbmsgQm9iJ3MgcGF0Y2hlcyBjYW4gc29sdmUgdGhpcyBwcm9ibGVtIGJ5
IGNoYW5jZSwgYnV0IEkgd2lsbA0KdXNlIFJETUEgZm9yLW5leHQgYnJhbmNoIHRvIHRlc3QgdGhl
IGlzc3VlIG9uIG15IHNsb3cgdm0uDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiANCj4g
SmFzb24=
