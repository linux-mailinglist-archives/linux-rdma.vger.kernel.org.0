Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F87620BAE
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Nov 2022 10:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiKHJBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Nov 2022 04:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiKHJBo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Nov 2022 04:01:44 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 01:01:43 PST
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C1813D2B
        for <linux-rdma@vger.kernel.org>; Tue,  8 Nov 2022 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667898104; x=1699434104;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4d2sLYiUNs6pP59o7PIKQIx6ypla8DcWcj9Sw0GMVi4=;
  b=CTjg6KZPZUr19x8lPZL4DFjhFuIleYI+D8FKwu5jXXg5RHLQ6cXX02Vj
   W4QUTix8ZrMEdDfZrWqeexKh7FgJRk1O1UGYXoXCsylhbVtPm1IosnYKe
   OaL1ysETVAWe9K7ZvPx0pln2Hg8b1ycs5kfkeSRTDYvkwL5LWpw2/ZT0S
   rjWNXBRnzBgOehh6qrU3Rbt1TlCHPoQkQvK7x+plH3lI18PuwAsBPuBnj
   jNk5hOzyHnLAptNg+h8l0v6iLVp3hQXuoUWtJ/DIGsWzVuZffC2wxpvBO
   flgkmrS4uOREt1bVnJJp+Uy8shG/km4LPsFc0ZGT1hhiMNJzzEgkIUVsV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="69552336"
X-IronPort-AV: E=Sophos;i="5.96,147,1665414000"; 
   d="scan'208";a="69552336"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 18:00:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7SYNKxbAV+Oj8TzY744kjgLq5HC0ku7/0CrJPBjKFdXaTCvQMSwCsAc8oAm8Q5Ex+jdkTYJe2aBEv7A6+y11p8ZgtNYWeCiCAwLPq+On+fiF8RVzIZ0oHaQb5dIHyci/DU1hrZopJOhuviAW1Ao5/6Zms8aZeohqbRPRbt6RZHM+Wqp4stn+XraNGHyPhYAFJFmgC+bGsMmRjvVq9y+pfqzn4GYgxJFOCwin5QDtM0T8T5/dhl6irxwyTComuINalvOTVY2IFS+dbY743wYRE2B8Wva1jbimRbtAb9OZUZBVlUbioSFR/waKAuZ7vWBK9EvIBNDpMUkjjAzj9dSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d2sLYiUNs6pP59o7PIKQIx6ypla8DcWcj9Sw0GMVi4=;
 b=crWNBAdfvmlT1iGrF1u5sO6+YnwfJZT38jzvD7TvopbJyR3YOt5Fon5Fv2kF+xB9Ny2zm9c6B6oW63EVChfjbvHPda//2BkPO0SHDzNECjStgJaVsfTd1oG/UHjVGfyZvoEmzlykpi0SiPnRRKS+bwTw+N3ALdSGGhDcdgNy351GNeE3sqxMLTz13zBgMD1NMNB60+mwX1wCjRYWgn/oL1wOKh7zCECNzEeYYMhxNrr/urCbf7O2p0Wj2mGtbqpiyG0QSutOC+7fancpGPqupDaRHRkt3v3WewL9KU+hUtZbn2wyEbIKzmMY7vjrXmhilE3Ap/+BvibtfIcMNJjcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS3PR01MB8228.jpnprd01.prod.outlook.com
 (2603:1096:604:176::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 09:00:32 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 09:00:32 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/rxe: Implement packet length validation on
 responder
Thread-Topic: [PATCH v2] RDMA/rxe: Implement packet length validation on
 responder
Thread-Index: AQHY8m115hZ9vOmGWEqlTv73BfmHua40vECA
Date:   Tue, 8 Nov 2022 09:00:32 +0000
Message-ID: <b4dfa189-7b07-ad97-05c2-cd81aa1bbede@fujitsu.com>
References: <20221107055338.357184-1-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20221107055338.357184-1-matsuda-daisuke@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS3PR01MB8228:EE_
x-ms-office365-filtering-correlation-id: f7047ca1-d23d-4af5-3920-08dac167b162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95fGdLEafzmDHZbC4jXJZLub+zVna1CuOuYS5OPbxY8swEZsbFVyIz6B0p26I2VytzZGjz1Lv0s4BkPPfcY2AYJhUxhCjg/Qn2Y4TZpKP23VFF9qRIj0VDTWS/31nVIZznGUhCX2uuxWYogk9n4Wss+7/IUe+5JDEJH6hmB3BPwG3+q590VfLk1tb0rBtZ4NK4FdQos4x1+Zo6AkW37yaYRnhk7y8y04Am/16mJgnkgFel3zsEv1Tjq/rfsgT8MlgDSbBoHRkEg/9QIYNXvbwPtthfMfzV+qoNK0BX+7q8DugSPADKqd2rCP+i5brmB2cYSVpgfo3p/+KQRjcvriSMHjoTh20nk+aN4QpFszpcXHr9RqF/LrK8UMFJww/5o6dr9SjPlKs7GiuErIAq2KaRLeI5ENXa8kbLqBxeO36XQ8ex0Jrd4/txU/OPa5v1HA8pUsTIGeZkOBszgxpW2QatrW9A9/kCvH64O0v51/wRgBtUZuOe0K9gAertzKdeGRdRPeCqcnY4sBkMuAAK8A6yHCZOB6jQsFtCP8i73e8ocnN4WScOjKfFTaDEvcJBJxDbBJQsztqH6hCFKxuOSQKVUkctrrh2WJgcIw9JREaXTEI3NKk4cKNNZOP0LeFw1fgga75F2YbFWh26kfTFjnMqryzVIizpE6jK2EwT5w7xmjZW6IPEI6dyiAbi2LrJqZn6fwvhr5JzWSiwbr0lumofpW3CK6N87uBiWlvpj7mxAgYcR3CB6txdJTgsTLc8kc2TTtP5fpJ1iN9Sa8kJhwgU4egwri9rjvkIbj0wKTtLrM6+48q7G8rYbJ6lIMb1d7fgA3hkfn9zuQwn0lJPPtj+E7LTQX67FTwIwnx4fpNUQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(1590799012)(451199015)(6486002)(186003)(6512007)(26005)(478600001)(6506007)(2616005)(2906002)(5660300002)(83380400001)(53546011)(38070700005)(31696002)(31686004)(86362001)(316002)(82960400001)(38100700002)(122000001)(1580799009)(8936002)(71200400001)(41300700001)(110136005)(36756003)(85182001)(64756008)(66556008)(8676002)(76116006)(66946007)(66446008)(91956017)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmhOaXhObHR5WW1VNDM3dGZzMmFtdXMvQlNwWC9rdzBMRmJEWXYyUW9TRVBB?=
 =?utf-8?B?ZE9TNVVmTjk4bEFEUXM4UnFWREo5YzdRa211emN2ejZBVFVkbG8xaWpsWG9Y?=
 =?utf-8?B?c1p6d1NvNjVhakpka2I2Z09ndytEMHNZS0ptTUxVK0NQQkVXOU5aV2lOM0dC?=
 =?utf-8?B?cnZIZGptcDVnNW9ubWZJR3U0OHVQV1ZhSTJ5YUVoUHlSYnM3SHFxRitnYlZE?=
 =?utf-8?B?SUxHUHNjOGJFd25sMUVEUWIyRUszTkJMU3Y2WFgxd3h5NGZ4TXZVcVhFbUc2?=
 =?utf-8?B?azdZSzZHS2pTK0xLaU5UNVRRRVcrUS80OGl6ai9IeVA1SVovanVRYno2OURv?=
 =?utf-8?B?YzRLdkdXNUFheGpDQk02RnF2aFdyOVU3V0F3SUR2TS9PUnBVWWdVUjBsK25o?=
 =?utf-8?B?UG1BWldLamZpRnRrTXUzWWdMYmFickhmK2tRbHRzMVRSUEtrL2EwWkl3VmZM?=
 =?utf-8?B?R1FpckI1SmFSK3ptSUQzTjc5WUR2WFg4TWZlQWZqd3FwL0J1dGdkMDZ5dmZy?=
 =?utf-8?B?ZFR6R0Eya3NCRFp3bUhvczZKdXZzN3lTQm01MTRjUDdYcm40L2RmWWZoOWlr?=
 =?utf-8?B?dzZKUHNpOGtmUlpJRktKWEMxcDFnUTRETW5TTUtlYzZ2ZjNVQzR1YnRocVRS?=
 =?utf-8?B?UzAzNHVWUkxyV1JyKzlhcjZuaTY0TFV2UnNQWXVPRXpzbFNLU0JJOFZtellp?=
 =?utf-8?B?cktiOWRpaHZqN1ZhVHBITXdPa0ZyV3h4T1Ywa3dRVUd1TTE1U3ZKRTcxa0Ru?=
 =?utf-8?B?SW5UQ0YxZy9EMDIvV2FPS3N0SmplL1JqTS9VNWlnekRRQmhaWHNWSW1tS2lL?=
 =?utf-8?B?elB0MUFnWlV3czFUSUxFbjV1eDJ6SjdSY2ZuekdOOEJyM3Z2elYyY3c2dnR3?=
 =?utf-8?B?d2x1L0VUSlRwYzN2V1JBOWFCU3JtWWZQTFNva3JtaWpHVlhEclRzaEZUR1A2?=
 =?utf-8?B?dnJhdTcvZUlmdjJCTnpYRmlJSzl0Mi9TMXFjNHFSNWFaZzNYTHBobmhHeWdv?=
 =?utf-8?B?Nk5jU2ZqYW5veHczVmp1SWl5QkdTaTVFcHdzOXFBTDErTlI2elVpamFyQlgx?=
 =?utf-8?B?djFCcG5VZFFqZzE3eCs0UC8zRFNTTVhQYmNjQUR4QVhHSGhpa2ovbGFweW15?=
 =?utf-8?B?VFdNa2JlZkxXb2lva25JV3dnS2tOdzRJUVluWC8wZytOTnRwUHZwYi9HTGZR?=
 =?utf-8?B?UmlnaHZvZkNCblhDWWdtTGttU29YQmEySGpMYUthby9zUDVhaUpnNHpFM01z?=
 =?utf-8?B?c0t6cmJzOFh0TUNCNHZ0LzhjZ1JwVzhCUStQSHE2QitRdlg3WnhTY0dXd2hE?=
 =?utf-8?B?dnY1eE9LZlhxb3VNRCtFYnp0MytnYzFXeHhlWmhKbE1idnRtYXp3T3kva09S?=
 =?utf-8?B?RW1hY0RsN0tYR1d2MlR0czNiNjRRZ3NNMTc1a0VjeXpTWlpFS0VoWExCREFM?=
 =?utf-8?B?RUpuUzcwc2dobHliU1dpOTUyck5YT1QrdWdrWUlKTHFCK1pSZFU1THJ6QjRZ?=
 =?utf-8?B?UEZVVyszT2lPUG5ObzVtUm5RcmpHejlXUjNTZjYxK1NpWnZrNGpiSlpmZlpu?=
 =?utf-8?B?TW9iRzFRY2lCeWNsR29GZkcrbEZuUGYxcUZWVGdtaGtlaTM2dzdnTVBIM3d4?=
 =?utf-8?B?OHcxcCtMak1pTlZkRGZiMlRMM1cvYUVxaU44VU5neUJwb1k2OWg1SkdGSkUw?=
 =?utf-8?B?VXBGQVhjUnBkdXF1aXJITDIyUysvTDJUZUgzcFN3YStvaFdMOGxkVjhUKzNP?=
 =?utf-8?B?RlNVL2hONDRRdFVVWmN0enRMTDZYNERySVZSUEwwK0ZZWUZFOVR6QTVBazlS?=
 =?utf-8?B?UmdhT0R6TmM2MDRac210UXpsR2ptMnR4M0Q4N2E5cUI2eFRRV2pzMUVnR1Ja?=
 =?utf-8?B?aFlQNDBDQ1doSllHOTBTSGliQStOVDI1NDNlUlZXVGVUWUNXVnp6SkdlVnVO?=
 =?utf-8?B?cEluQUxZLy9KbHh2NkdJVmRMZ3hybUZocGtHcDQxKzk3ZU1kVnZjM2NQRVNt?=
 =?utf-8?B?TDg0SXMxRlFjdnNOd013UTRrdmlGT1l1UmhYL2ZKK2Z6cisrdXRhcGg0Mi9l?=
 =?utf-8?B?MnRCZjE0N1FDcEp1VElFRlREaGFWdFd5b0FJM1B4K25UQXBxKzlNdStKR01k?=
 =?utf-8?B?eTFaS3ZkckpBVDZ2aFhlNC9RZmpHaGEwQ2k2VlpNVjZYTks5ZWlVRGZsUVF1?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B07097F6610AC48B852DA40AA83707B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7047ca1-d23d-4af5-3920-08dac167b162
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 09:00:32.7674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMdYGiTR+vNGnXL0axkkN30VApcBHQ99kTp+fY2UlVykP2dVCSTgTHSNHUkeyPMScROzkye77M3P7RFKgH642w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8228
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA3LzExLzIwMjIgMTM6NTMsIERhaXN1a2UgTWF0c3VkYSB3cm90ZToNCj4gVGhlIGZ1
bmN0aW9uIGNoZWNrX2xlbmd0aCgpIGlzIHN1cHBvc2VkIHRvIGNoZWNrIHRoZSBsZW5ndGggb2Yg
aW5ib3VuZA0KPiBwYWNrZXRzIG9uIHJlc3BvbmRlciwgYnV0IGl0IGFjdHVhbGx5IGhhcyBiZWVu
IGEgc3R1YiBzaW5jZSB0aGUgZHJpdmVyIHdhcw0KPiBib3JuLiBMZXQgaXQgY2hlY2sgdGhlIHBh
eWxvYWQgbGVuZ3RoIGFuZCB0aGUgRE1BIGxlbmd0aC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERh
aXN1a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KDQpMb29rcyBnb29k
IHRvIG1lDQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+
DQoNCg0KDQoNCj4gLS0tDQo+IEZPUiBSRVZJRVdFUlMNCj4gICAgSSByZWZlcnJlZCB0byBJQiBT
cGVjaWZpY2F0aW9uIFZvbCAxLVJldmlzaW9uLTEuNSB0byBjcmVhdGUgdGhpcyBwYXRjaC4NCj4g
ICAgUGxlYXNlIHNlZSA5LjcuNC4xLjYgKHBhZ2UuMzMwKS4NCj4gDQo+IHYyOiBGaXhlZCB0aGUg
Y29uZGl0aW9uYWwgZm9yICdsYXN0JyBwYWNrZXRzLiBUaGFua3MsIFpoaWppYW4uDQo+IA0KPiAg
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDM0ICsrKysrKysrKysrKysr
KysrKysrKystLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9yZXNwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMNCj4gaW5k
ZXggYzMyYmMxMmNjODJmLi4zODJkMjA1M2RiNDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9yZXNwLmMNCj4gQEAgLTM5MywxNiArMzkzLDM2IEBAIHN0YXRpYyBlbnVtIHJlc3Bf
c3RhdGVzIGNoZWNrX3Jlc291cmNlKHN0cnVjdCByeGVfcXAgKnFwLA0KPiAgIHN0YXRpYyBlbnVt
IHJlc3Bfc3RhdGVzIGNoZWNrX2xlbmd0aChzdHJ1Y3QgcnhlX3FwICpxcCwNCj4gICAJCQkJICAg
ICBzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QpDQo+ICAgew0KPiAtCXN3aXRjaCAocXBfdHlwZShx
cCkpIHsNCj4gLQljYXNlIElCX1FQVF9SQzoNCj4gLQkJcmV0dXJuIFJFU1BTVF9DSEtfUktFWTsN
Cj4gKwlpbnQgbXR1ID0gcXAtPm10dTsNCj4gKwl1MzIgcGF5bG9hZCA9IHBheWxvYWRfc2l6ZShw
a3QpOw0KPiArCXUzMiBkbWFsZW4gPSByZXRoX2xlbihwa3QpOw0KPiAgIA0KPiAtCWNhc2UgSUJf
UVBUX1VDOg0KPiAtCQlyZXR1cm4gUkVTUFNUX0NIS19SS0VZOw0KPiArCS8qIFJvQ0V2MiBwYWNr
ZXRzIGRvIG5vdCBoYXZlIExSSC4NCj4gKwkgKiBMZXQncyBza2lwIGNoZWNraW5nIGl0Lg0KPiAr
CSAqLw0KPiAgIA0KPiAtCWRlZmF1bHQ6DQo+IC0JCXJldHVybiBSRVNQU1RfQ0hLX1JLRVk7DQo+
ICsJaWYgKChwa3QtPm9wY29kZSAmIFJYRV9TVEFSVF9NQVNLKSAmJg0KPiArCSAgICAocGt0LT5v
cGNvZGUgJiBSWEVfRU5EX01BU0spKSB7DQo+ICsJCS8qICJvbmx5IiBwYWNrZXRzICovDQo+ICsJ
CWlmIChwYXlsb2FkID4gbXR1KQ0KPiArCQkJcmV0dXJuIFJFU1BTVF9FUlJfTEVOR1RIOw0KPiAr
CX0gZWxzZSBpZiAoKHBrdC0+b3Bjb2RlICYgUlhFX1NUQVJUX01BU0spIHx8DQo+ICsJCSAgIChw
a3QtPm9wY29kZSAmIFJYRV9NSURETEVfTUFTSykpIHsNCj4gKwkJLyogImZpcnN0IiBvciAibWlk
ZGxlIiBwYWNrZXRzICovDQo+ICsJCWlmIChwYXlsb2FkICE9IG10dSkNCj4gKwkJCXJldHVybiBS
RVNQU1RfRVJSX0xFTkdUSDsNCj4gKwl9IGVsc2UgaWYgKHBrdC0+b3Bjb2RlICYgUlhFX0VORF9N
QVNLKSB7DQo+ICsJCS8qICJsYXN0IiBwYWNrZXRzICovDQo+ICsJCWlmICgocGF5bG9hZCA9PSAw
KSB8fCAocGF5bG9hZCA+IG10dSkpDQo+ICsJCQlyZXR1cm4gUkVTUFNUX0VSUl9MRU5HVEg7DQo+
ICsJfQ0KPiArDQo+ICsJaWYgKHBrdC0+b3Bjb2RlICYgKFJYRV9XUklURV9NQVNLIHwgUlhFX1JF
QURfTUFTSykpIHsNCj4gKwkJaWYgKGRtYWxlbiA+ICgxIDw8IDMxKSkNCj4gKwkJCXJldHVybiBS
RVNQU1RfRVJSX0xFTkdUSDsNCj4gICAJfQ0KPiArDQo+ICsJcmV0dXJuIFJFU1BTVF9DSEtfUktF
WTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tfcmtleShz
dHJ1Y3QgcnhlX3FwICpxcCw=
