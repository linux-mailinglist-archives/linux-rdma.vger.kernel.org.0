Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BC68EA18
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBHImX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 03:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHImV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 03:42:21 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 00:42:19 PST
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3191557E
        for <linux-rdma@vger.kernel.org>; Wed,  8 Feb 2023 00:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675845740; x=1707381740;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5gDWXS+pHFVMmT39Wh1wWDQhTV8jGUJiCLzpttGam0U=;
  b=nIzQukB0zQjHb0/8jZmv+W+y4+6LUz/Jng4bpioU1xKx1voVI4zP75MG
   6XTqthc4p5t1FynY8/LAFIChN8BgfNaTwGnoS3JUv6/MkDxJKiXUKrC8K
   cm/DCKe9mSdsrm6JWsD4svPNMneBh50WDDMNfd4kUiDRW1Gjb1j5Qeeh+
   cnzRnoXToO1c2/lqJYYh1K4y76YpF5ipmoB8IZimxBPgf54/AU3Hn9QeV
   uLzICMqvGlqIxZoeiEQMfhbAdpaMsV3xchRHRbnJJqUP9W7f0+PjaktyG
   D8epflYc84bxNkPdceMEs+CgidKsUqcPcjOuOGzQDBBa6NFMpsrbbpuHa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="84541380"
X-IronPort-AV: E=Sophos;i="5.97,280,1669042800"; 
   d="scan'208";a="84541380"
Received: from mail-tyzapc01lp2046.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) ([104.47.110.46])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 17:41:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsOJLByI0qyFYjYiibHOYa8bWy6EsSV+0/gCyWucxv+XkTOQo27QfoWnr/lCA+RNmR6T7Mm7m7Vk8hbVRtEx7NxmwfsQuJ86JJRdJUYLJpzOZ7qVRSXRZzhNDGaepwxjESa3/qqW2Nc28Qyb/HpldIjuPkKew/rSjU/0lEHA4wbrrg9W2bFYZ9XiiIyLBo6MxPseW9WXssanwXORFYkzOVRORYbDJXvWoKlocSVD46Omf4kIaO0GOHZeBEH3iFH+KoKKkpi4fJQZn0+oyd7vACTAmdoX+H9WvEosJ6Rg5IHFn9h4cpyqpLkOI/T7ztlEHoV3Q/JC23NgWdRjUVNVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gDWXS+pHFVMmT39Wh1wWDQhTV8jGUJiCLzpttGam0U=;
 b=dpFLYz0pHeNKkQUR7nJKX+yB9RuC16IQFlVykrQUyFvsTQ8ZqSdTrRYZq19VfFtu8J2kuwLWUUVTNFg2zIR77GIhWUHOD5hJ1SdLiVPEIAePTmHSciAvkO16nfG6Tnd+YEQczC3qH8mQl5txmBpwpUJRLABchOs+urpZcbRB+OSmb/wMNUm72Hc3uXs8Z6j4xpKVNc5sdXjRp5RqmjpRHKqhz0d+bivBqBVLAXFlZ3mRzFJIEmQgNUxkXKeui9k1aZMSQl2qNWHFEatBsA5DzMwzzv0bZmibtboXIUBo9c/v3eOo3bDaRAmXtv+QhuhhvaGtq/+5KM91EvDY+aDf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB8769.jpnprd01.prod.outlook.com
 (2603:1096:400:10f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Wed, 8 Feb
 2023 08:41:09 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58%4]) with mapi id 15.20.6064.035; Wed, 8 Feb 2023
 08:41:09 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Topic: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Index: AQHZNsEkNdUH2jzsHkO/gJEYgdYGpK7ExKoA
Date:   Wed, 8 Feb 2023 08:41:09 +0000
Message-ID: <dc4f034a-3cc8-fbaf-a5ba-2338c8fc8576@fujitsu.com>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230202044240.6304-1-rpearsonhpe@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB8769:EE_
x-ms-office365-filtering-correlation-id: 75b1f5a7-aa50-4bb8-a53c-08db09b03a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCUl053F0Z+ZnnnCQSypGr36OEIliPmFwT7kp+bYiUlRoR7IncmQex/TkCu4/J+jEQXl9pRM2gixOkK9mKMG8pP2qUHnBwxfQ6TP0YTeiYpXBEZmBixT+Ob79DVJ2dIMo9uZB70Krz8+FqZyelDXmmh61FLsu6N2o9hNV902rAKvlfW3hTdAb2uDDBwdAARucopO3tgKD4xCbyezWzNXtiHi+QJ4GkdoqsLWpoFoyScj3btZjOzfH3i6Bj77nYfsUJtbuMUlZ2mNH5x3gK4En5pbMpABXw9d6VoOoUuCwXyz5wilprXUCezvgDfnoWMx58OJmUHqycj+vPlCpAL7/tp0IWPKKAcgJ9+viEPq+fOvDvsmACZSQvA5ulULPIVYoOK9WBllsnyzgXirq2jN1Cp4I6LaKCDGbWOO13lIYjKBxvD48CcuWRRUDhPsbsWxDU60C7Cs9YqMwzJn+wkiKW9LC3JFIl9iOu7/OhN9XclgpV+CzkeaLBpnfug3Io0BY8ubOioVXbFzmMttQJZIaW/6cDBmxmWH07etZcNjuY4ClGhnvhb/iqjHQH3Kl8wUk0BkzB6Ar8gnevdFLfOZzHgS3ZJ050MU3CPHuE+9WJ4xaMOP5lxDTTkzsvoIJYoH82eIA3/IlbvUbN0X7eUDALmkUx65lank+2dJh0ny6DDGz7NXpIYdLPubdW7+/Ui5yTxjEBp3QxLLTjyEeoN467j3D/8be+Xr3/rr+qmsQwNiOtPoNIkvnAW3zuBs2wjvNzCLqIa/slfR+jSXd6wvWxzcgePrXInmp8hnrmJRxDU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199018)(1590799015)(86362001)(6506007)(5660300002)(53546011)(38070700005)(26005)(6512007)(31686004)(186003)(8936002)(2906002)(82960400001)(1580799012)(66946007)(66446008)(66556008)(66476007)(64756008)(76116006)(91956017)(8676002)(122000001)(38100700002)(41300700001)(316002)(2616005)(31696002)(478600001)(71200400001)(6486002)(110136005)(85182001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1p6SkNpakVldUhBZzhockJZUVFRb3dhWVRRU0MzRjUxbENaNVRRZ2JBeUxp?=
 =?utf-8?B?VHZVTlpuMytvaFZvcnE2bDkvVHFBend6VlNJNmRsLzh5T3Jnbm55U2thdVBr?=
 =?utf-8?B?TGI5YjFnbm0yc1cwT0lSb3YzVElScGFoUlg4eU5WcG5uWTNUdTNuZDRJM0d0?=
 =?utf-8?B?akx1Y1JxcjZWNlliR3YxVmZSaTRwaHkraitvUXVRVTlNdGR1WWxYK3lrc2J3?=
 =?utf-8?B?VnRiMGdVVnhHaHQ1aUtJK0FxZ0lBeGMveUlmMlFEOWhyREdrS2NUbE5kdlFQ?=
 =?utf-8?B?NW13MnVQbFlFSSt0UXhKTDljT1pERzNlbEFLMUxZQ3UzVVVCWDZ2Z0Q3YnZv?=
 =?utf-8?B?RVVGb1dVRjFEb2U5ZHV6aGRLVUVOMzdkcUVIZmhqaVhxOG5OOUVKdHBiTHZw?=
 =?utf-8?B?cnZuQU5XUE81am1CdmZIRHgwdWhQaCt5d25DSmFOQXc4YnFqR2RsYjNyTGV5?=
 =?utf-8?B?Q0RReEgzL01hcm9XWlhsTXVFaWlVaENneTBsVVEwVEdzbEZrQmliK0FNRG9Q?=
 =?utf-8?B?djY3TCtFWUo5aGNBV2kvbXpqSmJCRGFqSHNMUG5YL1JWclB6TlY3eUpmY21z?=
 =?utf-8?B?WjZuK1d2WXdpbjQ4dGI4VWJoM052UlVlcWhzc2tTQnVzcXdoTldKMFZLSG9R?=
 =?utf-8?B?ZWxMbkx2bEduWFR4Tmk3WTZVZTBRc2lxZHZCK0s5VUVxQUFSWnBQa1Nob0JP?=
 =?utf-8?B?Tlkzd2xzekNlVFA5bWE4WVJnVDFodTlMcS9mbnUyVklRVzVpRjYzdmZzeDBJ?=
 =?utf-8?B?Y1lyTDlpZHY3MUJtMWNNbTBxOVdBaDA0MjlaSStrK1N5WVdDRlpoa0w1aG02?=
 =?utf-8?B?YWRBalFtc1VqYXkwUGVlUkhIVWM0dmlKN1c0RjNSWGo3QjdMMmNZdjErVk4z?=
 =?utf-8?B?NGhqTmhLMCtaU2RuOEI0Z3NOZWY0endZaThObGVWWWwxS3pya1JVV0l5bVp6?=
 =?utf-8?B?QjJVbDR5UTRMTkZrQU14MDRMQUh4YWlDdHkyR0VjQllzekF2bXM2MXZWYklo?=
 =?utf-8?B?TWRybFhoMUJtcXMzbStjaUtXT3grT2ljeU1WWklKSzRTQnFaMGpRRWZEdElV?=
 =?utf-8?B?b08yR0lJNWlwOU9ZMC9DK21mUjdnY29CamQ5SnNqVE1Vd3Vta1lqc3l2dFBJ?=
 =?utf-8?B?OG5GbHV1YkNIeE5VWVFBVkZXTGZNNUV0NVdzUVpBN0R5TmY1aGU1OUhML1V3?=
 =?utf-8?B?eUZvTWVudDNyV09kYjVvbWRrRDBWV2tTalVzclBNcklGSUhmVWI0Y0JTZmls?=
 =?utf-8?B?YVZDNW04TEJJZElDZGE2YlVLbjd5VVowRWxhT1hVMnY0R29BVmJsMUZPOVBo?=
 =?utf-8?B?cVoxNW85RVREYzdQdDVOSVVoODFvTWNkbTR0cmZKNEhlNi9UaW0zYVBLalVE?=
 =?utf-8?B?WWF5bzhpenIyckZtMnNwRVczNjlUVXVCRGxMeU1mVU1ZS2dtbm93TDJKaWcy?=
 =?utf-8?B?N3ExdklMUjRZaVdWNFdmV0Z1Z3Z1anhTUFBvU3FONXd0bHVLNC9xUUxrdDN5?=
 =?utf-8?B?K0lxWW05SmZsZ3MyeDFMYW82Z2syRERNVlI0UFlJWStPVVdwT1hTMzM1aW1T?=
 =?utf-8?B?Zy95OTBmR2VhMzVHRFc3VWFBVlBZQk03MEFEMksxSGE3U2grYXVkSkkvMzNa?=
 =?utf-8?B?ZlpLY25jSUFxcEdnTWZkUGFITnhsWTJmUVlkWk44R3ZLVzdMLzRwQ1V6cG04?=
 =?utf-8?B?SkY5ZFplNFZkcUUvMGY0VTdKd2FMeG5xQnZMNlJUWlRMaEdSb2pxTXNEUWxQ?=
 =?utf-8?B?U1NYYnM4ZENseGVPdUVQVVFkdEZHclo3d1cvbDluTEU0MWxiY052VVBOcHZm?=
 =?utf-8?B?NU1NakdrempSQXdraXZ0QWhYWjNuT3hhbmFRTVNxckhzbHNrTGphazdkaFJH?=
 =?utf-8?B?UHZzNy8vMCsxQWJTUEVQOVdUa0QwRndUMXhRZkNjcVE2QUNHemJtbGRnRmZr?=
 =?utf-8?B?aFJzcXViT2VPNjd6V2RWbmRJQThmRXAwYmNDcjhsZk5sR3RCU3ZTeDg2RGF5?=
 =?utf-8?B?YVJhd2N5bjhKOUpFV1dBV2owQ3hRbXh4eTMyRTFRTWFqQXNzLzlsNVRWTlll?=
 =?utf-8?B?K1ZZR1ltWXV4MGdDcDlITERBbkJpUHdGZk5DeWxkVVdHSmdNaGxWYVFwK2ZF?=
 =?utf-8?B?Rkg1TXlvTDFTN0tCOXNYaWxsNFhjcnVjdk50SlNTY25ienJ1UE1MV3ZzNGp3?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0419A860DC21664A87F500F250A615B2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EquDHiYu4EZVK5lD7SKeRqUzWNvbKbcrPl2c8iKZFYStgk9svBMZpAqchZCjv1dkwLxliKRg5a/yUeGMCPWmkuo0h1ucZODG2JCotBPFdE8cgl477R5FawFiSFceV4Q/AxhelrXNOtYIxByKViN3pf70v8Q6LZNmAZWhKlmxGHTBC3sv59JZuwyDFFeQhSH7FuslaClmTlkQ8allydtva4pl/OaHSTBy1+matUAxBBdkmsq+w7GLprSZBF/q5SyNQu2ZFqwbexlJQzT0G/4oAY8xmNs38XlVR3fLscrh7cqGBfs6I6pjBSdYrDfqnNuqsM3xwd4iXgu+Kyyx7dFTyfrJmZi7TIJx4+7yU1RohO8qDYgW6KGuXA6LSI6Jiqns3GXpSL9/pxezbVPZXAHoWXS4cQVYuYBQ9YI6UNMHDJh5alrNTSM+I5AIYgok3CRNCKEVcmpEjjJQRvbaZAx8RP/W5oHNwNZQfMoXxF5FJTXC3L2lV/X+tIcJu15VI5J/Vh/urrJTFat/2MbI6Hgd/LTRh3vcbIABMfcv5jF+XDNCVD9AFz345UAF7I02G0ftIjo6ITKGV62xxuGpi1Mq8OtBEwSP/tJllWby6P6p9R461seO268Rc+1nXPe4GQLLFn38OY9LFcLmgZzyhlI8uhjdNcci6kAAfUgaeQySgKc3j2mlpb+K9WD+x9zjgrmxpfrRHSNhPcp0qKyth4M3BQK+RHF+idrqOxpY19peACGbIOE6Q7E14ZAK07calV9d/1A1qumBId7Hbd6/NwT1GxNIQUyn55AEQHZP+RF+bOD1Qv0JcEGqqXb8afcBVwHQpEIrd3Nup1xZ0fzD+jmkXohL0xpu2FdppuLxsKy5plE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b1f5a7-aa50-4bb8-a53c-08db09b03a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 08:41:09.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jum4LfYw2rGd4aTBTdUcMCH7d+w3yH6c9uIoi2Z4uwVirVopA+HXv0ERLoW0ctLK03Nz/Q9Buu/hUdwA93lZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8769
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMjMgMTI6NDIsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiArLyogcmVzb2x2
ZSB0aGUgcGFja2V0IHJrZXkgdG8gcXAtPnJlc3AubXIgb3Igc2V0IHFwLT5yZXNwLm1yIHRvIE5V
TEwNCj4gKyAqIGlmIGFuIGludmFsaWQgcmtleSBpcyByZWNlaXZlZCBvciB0aGUgcmRtYSBsZW5n
dGggaXMgemVyby4gRm9yIG1pZGRsZQ0KPiArICogb3IgbGFzdCBwYWNrZXRzIHVzZSB0aGUgc3Rv
cmVkIHZhbHVlIG9mIG1yLg0KPiArICovDQo+ICAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hl
Y2tfcmtleShzdHJ1Y3QgcnhlX3FwICpxcCwNCj4gICAJCQkJICAgc3RydWN0IHJ4ZV9wa3RfaW5m
byAqcGt0KQ0KPiAgIHsNCj4gQEAgLTQ3MywxMCArNDg3LDEyIEBAIHN0YXRpYyBlbnVtIHJlc3Bf
c3RhdGVzIGNoZWNrX3JrZXkoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+ICAgCQlyZXR1cm4gUkVTUFNU
X0VYRUNVVEU7DQo+ICAgCX0NCj4gICANCj4gLQkvKiBBIHplcm8tYnl0ZSBvcCBpcyBub3QgcmVx
dWlyZWQgdG8gc2V0IGFuIGFkZHIgb3IgcmtleS4gU2VlIEM5LTg4ICovDQo+ICsJLyogQSB6ZXJv
LWJ5dGUgcmVhZCBvciB3cml0ZSBvcCBpcyBub3QgcmVxdWlyZWQgdG8NCj4gKwkgKiBzZXQgYW4g
YWRkciBvciBya2V5LiBTZWUgQzktODgNCj4gKwkgKi8NCj4gICAJaWYgKChwa3QtPm1hc2sgJiBS
WEVfUkVBRF9PUl9XUklURV9NQVNLKSAmJg0KPiAtCSAgICAocGt0LT5tYXNrICYgUlhFX1JFVEhf
TUFTSykgJiYNCj4gLQkgICAgcmV0aF9sZW4ocGt0KSA9PSAwKSB7DQo+ICsJICAgIChwa3QtPm1h
c2sgJiBSWEVfUkVUSF9NQVNLKSAmJiByZXRoX2xlbihwa3QpID09IDApIHsNCj4gKwkJcXAtPnJl
c3AubXIgPSBOVUxMOw0KDQpZb3UgYXJlIG1ha2luZyBzdXJlICdxcC0+cmVzcC5tciA9IE5VTEwn
LCBidXQgSSBkb3VidCB0aGUgcHJldmlvdXMgcXAtPnJlc3AubXIgd2lsbCBsZWFrIGFmdGVyIHRo
aXMgYXNzaWdubWVudCB3aGVuIGl0cyB2YWx1ZSBpcyBub3QgTlVMTC4NCg0KDQpUaGFua3MNClpo
aWppYW4NCg0KPiAgIAkJcmV0dXJuIFJFU1BTVF9FWEVDVVRFOw0KPiAgIAl9DQo+ICAgDQo+IEBA
IC01NTUsNiArNTcxLDcgQEAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tfcmtleShzdHJ1
Y3QgcnhlX3FwICpxcCwNCj4gICAJcmV0dXJuIFJFU1BTVF9FWEVDVVRFOw0KPiAgIA0KPiAgIGVy
cjoNCj4gKwlxcC0+cmVzcC5tciA9IE5VTEw7DQo+ICAgCWlmIChtcik=
