Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4748607A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 07:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiAFGMm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 01:12:42 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:21770 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbiAFGMm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 01:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641449562; x=1672985562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=alK0ahdZ68fmzQ+grT9DP8z1HpV8lBgote+H/h9xtzI=;
  b=YaRrz/k9jz67Cf2NDLZ54cqh2EWIjAbA8Ga/Hf+vz5UGrzVr9Qs49qvw
   EkHwEk8iAy75H9mfzFwRCoqH3d3yN+Sj2a330I/Nuk65Zn7C8220+DAvg
   BJI1nyDjapvVQ6aybGS0DL8khoJmw5q1kPVIkdHRiJ9d1+M6dnMJjmOe0
   4GGD61EHtmaxgdEGmv8oaZFtlgzW/pJFESHhYeTfy3CbjFLuOrqcf6S9y
   8sJnlxFQCE/YEbgq48C0md3umYqiS5brcHFYqHba416iw2vg2x5px87RF
   qnawrg83Ga4CZMXSr1LyHc5Mql8kxviYm9vgTVD6SVmQV489h+QrQ7zQB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47244227"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; 
   d="scan'208";a="47244227"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 15:12:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgxNdfkZZjOH6zdmZSxj9zuuHHMmijJm65haplv2FJ3n6etdhEXAogAbz5Qp23XxRTC1lkySww5DXv5FOZqZftyBh64NTm0pV3Pgcw1ob9ZPtoYlwwfTVg6Z89tKf+hrpE9yJLxXcvHjPPsduXjt98yKjKnJbwWmVlUafOqH6wUUj9yzB9Ars4ozuimETYEhi1s77wNuGXK7JSwJwS/0aZ9iANZT26DmQrjcVQD63iouMzn2GPzpnoBuwPNSp5uYqIv6an176PVClDDpOiB2GKEHy0xCWS31T2ylPzF2G+MApk6Ts7/v4k7PyNGebN2yRs3jvqMhCA7lJ5MolcRHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alK0ahdZ68fmzQ+grT9DP8z1HpV8lBgote+H/h9xtzI=;
 b=YTHZvraMynbUCKuQL8WxgEEQt2osEZMxzoR+QSLtRiJIhoTch7Q1U9dDQMPMqI4ZhAD2lH63ZqYctB0UEASeGIKwIzKyG1dQ1SG8v2fjmlYgYTC0QXWO9NmjsBxBiNTaDZVwpT1t/f4Rw0rIgpTiHu3+g3BrJlrmxGeKSnqcGQzTOa09F/A7sMKYpyIA2XV08WVUERYb+32XVjNV8JWp8aa/FccvDYteCNhN4yXbl90bIgb+Xn73bHXdDIEoYmDzaomaZ87oXltHjZfrJP1TOLgJ931EBl9AclHW2WwvsBZJq1ByTsZImPowSQz4BZP4so0e6rcRWiAZ6ZKJa8sVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alK0ahdZ68fmzQ+grT9DP8z1HpV8lBgote+H/h9xtzI=;
 b=OzRuHIer1JYBvXHeqeAQF51w/iq13M9/cyA9sRo9p8A6M6w0YhGJDIOW44uSxWwaFKYY5TAFGkHFpt8RGiWIqrv/pFBDtzx1Ms98xevIl1B/tBCzGiMCThfdAFi7qjHUS4qKcK3m2X/nSPM/juFwqSEDL3jW1QMBFIfoLK6v5ZA=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB7917.jpnprd01.prod.outlook.com (2603:1096:400:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 06:12:35 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8c58:9fce:97f2:ce35%9]) with mapi id 15.20.4844.014; Thu, 6 Jan 2022
 06:12:35 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Thread-Topic: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
Thread-Index: AQHX+8Eq2ywj9xVE/k2ZPCJONlAra6xVLzEAgABiHQA=
Date:   Thu, 6 Jan 2022 06:12:35 +0000
Message-ID: <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-2-lizhijian@cn.fujitsu.com>
 <20220106002130.GP6467@ziepe.ca>
In-Reply-To: <20220106002130.GP6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6a05835-ffda-4b8e-72a6-08d9d0db8866
x-ms-traffictypediagnostic: TYCPR01MB7917:EE_
x-microsoft-antispam-prvs: <TYCPR01MB791713DD8718C3036DD47332A54C9@TYCPR01MB7917.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdeIuY8HAm3h0+jI3o4NEM0byTXCPB5XFNzNOFYMgHZcmRzvggn3U3cHCRlDZCT1EjCDd/HNkO28FtJ1dpH/Bqv9ChKpK/GN3WGgb9kGyQj6J16yPNuxPFq2L0LlHB3TSMi5avmRf2ubMbh1QSIwB8HgpR9i0mwngBazhCv+yq5mbiRVQHnVW8GgENXrEdPeAy8GyljNaJc6LOgm/wNG2HTtdHOas53xwokuE99jKCNu3d+IqfZ/yTpFOXJICxMYG+P6VLlGYd8JjvjcnSG+Q80u5lsjhIaWf7fbcPuz6ZmGrY/tMd0Cslu+jdz2ebxHnzAqjLqA46CiyYGPf2d0PgxQpaHfWBoyWyWaxi1T5uzAY+QvZDwXZ4woHlfy6JdXwzEKh4UalYvqHZ/Nc6NvsfpsDvG2vqvypatlngSSIIHCxxlM3EqgFXJWD9nIn2nhegDQxz4u2sM/YoLlm75N/LYF+CEKGC5S5UiHSbQBKjwGFpcfTeCmvdFgdg+PomsJTrUmJFWbchEktYbfLwHoO2RHfAG3CrSZKJ2gqHFI+qxKTRHXaptYDaeliEDHaWDz/FAS7TjjQI8NYEOuQEgytpwtnL5kI2EuDxdKvB90+QM21qr9WDiPq5aohRhLKKD4vlk58S3pCiqfHTrx0G+AdobTQgN8EwHS0tsIvFxo2XMGdfslE+WAqXR375/rUShJTBPXHcpxjgP5uFThGljUvfi55S7wO8d8EfwhJwsQP1jW37JTdKp02WVwesPobqrN6v5W9bJwmzUq3ro1QXn3GBorZdbtcEr5vxRgE4FTzx78PO0UtB9gyNdzYGUVXE86RR6n2CVBhLVyegKtJw7mGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4326008)(7416002)(31696002)(2616005)(31686004)(85182001)(86362001)(122000001)(64756008)(2906002)(38100700002)(66476007)(91956017)(66556008)(26005)(38070700005)(66946007)(66446008)(316002)(5660300002)(82960400001)(83380400001)(6486002)(8676002)(76116006)(6512007)(6506007)(53546011)(71200400001)(186003)(8936002)(110136005)(54906003)(36756003)(21314003)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnpORWpnU3hZYzNpWUM5RlgxRTJZaGlvaUdJRmRCMWMzM3FGV2JUdk5rMTRG?=
 =?utf-8?B?cnlhVHVqWllXekU0UE5YS05peEhTeDdnZ1dWeWczV0oyZEJFOGlKS2xuaFNn?=
 =?utf-8?B?cUM4S1A5bXlqYlBPNXp2blRSVVNucXVvYWlFWG5BQy9XMWFOaWtaazg1Zkhm?=
 =?utf-8?B?dHBUQmpiU0YxZmwzbWZUNng3SmNsMnVTeDFNamR2THJkcDBxVERKWFlYZ0x6?=
 =?utf-8?B?SGh5K0t4L1JOOTlnekNFQlAxcENBZEFiZ1Z4ekUvMThHdWR0NHZWOEFHNVdU?=
 =?utf-8?B?Yzl0K1ZsMGgxTm1scFNWclVWL3B3aldyZDFXZEV0Vk1scG1TQk9POG1idUcz?=
 =?utf-8?B?b2l5Ky8wNU90elI4em5mRDZhcnBxUDJsbWtJZ3l1RWFpUndmV0VpVjhXS3BS?=
 =?utf-8?B?Vkd2WW5WNlNyQjdoVXl4TjRJMEFsQzNOZXJhY0dzWng2djkxK2RZa0NPaWxz?=
 =?utf-8?B?aWkwd2NNQUdVTk1OUWoxYVlJblNCeEVxRkZrN0Zlb1N0T2hncWdNa05DcWhk?=
 =?utf-8?B?QkRVbkxhUDdnKzdoSXFhWlh1WWlXenlBUWdXOW1La3RsQUxRVVdQVFZjR1Vi?=
 =?utf-8?B?dzJ4L09SUUpQV3U1R2pBVTF4dzJvMnIzNmVPNitvcHJ1YnNQakt1bWVlcm5Q?=
 =?utf-8?B?VTV3UXVPTVZabGVsN0FTVDVmeWVaZXRldTU2RHRzdlY2QlVkWjFTSXZGTFYx?=
 =?utf-8?B?bWRWN1F1cFRLQVFsb2kvOVhtaCt3YzlOM3ZDcXZZdldjNFhtci9yMy9kMmRF?=
 =?utf-8?B?ZmU1Yyt3dXh6cm5QUTNIa2Q5S1lFaXF3OTFTNHFmVHQrWnpkZmlSU0VMeGFK?=
 =?utf-8?B?Mzk0U1dBZm9hbE5abjE4UDZnK09oditjaVd1MVNHMTFOWHE1aU0vRk5mbXF2?=
 =?utf-8?B?Q2paM2RGOW41OUxKc2VtdDloWUxnNktkQlYzQlB5MlhERE85MmkwK2s2THoz?=
 =?utf-8?B?cldvTTFwMWVSYmlCbStTUFJBblRZR2ptdytnV1hYcnVVdGE5OWEvR0JZdTVn?=
 =?utf-8?B?SkxUWlBhNXBlMCtKSjVid2NIcmw1bEVEaVFoTzNGdkExVTUyQzJlZERvQkZC?=
 =?utf-8?B?SG04enM5NzF2ZllxU0FWNXBKZ1NzM09aK0FTdHdWWDZtZ2ZwSy9JN3l0RXFB?=
 =?utf-8?B?ZE5EblJLRlhDL1NxQWs4T3V5VzJSVmJ3LzQ0Wld5Ri80ZFAwM3U4bnBQdmR4?=
 =?utf-8?B?Wm9PeFVMU2dLb0NFSWFkUFBHakJUMm5OaGYyQ1hVcDg4UHVmTXlsRmFRQTBM?=
 =?utf-8?B?enFRaEQ1dm9PbGM2cmhZNU0vSUZVVWc3aHBHeUI5c0F2YzhIQ3BhVDRKbGlt?=
 =?utf-8?B?S1RBRlhiZ0pERk9xSXg1SCtEWVF1V0swRTR0T25GTmVSdWIveURpcU9ITkRR?=
 =?utf-8?B?enlRVFZZOG5wZDRVNHFLaHViREs3N283MHFITExCT1V1SG40NWtnakxwd1pn?=
 =?utf-8?B?YTdrZ051YTZnS2psSVRTSVRKQU02dGtwRWVJSjAzTmhwK2hDRTJKdVdxODA0?=
 =?utf-8?B?R0VWcVlsUTZaSE84b05GeTB1VWVoT2hyQU1Ycjg1ZjB6bGQzTXU1RHpDN3o0?=
 =?utf-8?B?VDY2TWRDYkVnNlViWW9iSzErNUIwYUJKV1NOdWc0LzVpa3A5TkRQZC80N1lT?=
 =?utf-8?B?RW4yZGdpeDdWZ0xFTmFnZ1N5Zy9DVDZXVE1xUEpyS0d2bStNbnplQXFvd09E?=
 =?utf-8?B?aURzbDJ1Mng0SzM3clR1aHd0dUtvUmVpbzAvMHByYnFnZXFHaXRaSGYrSlQ2?=
 =?utf-8?B?ejF5UkJsaTlxWVYxQlBEVFRBOVFnNEJ1REtvcU5pcmJQV3FtdGprckFydEhN?=
 =?utf-8?B?L3Q1VllGQ0hpS2ZTZ0ZiY0FYMDFDbXIydUVOYy9Eemc0U1hMSG83N21WNjRX?=
 =?utf-8?B?Wm5EeG03WGtYRkRnM3J0QXBhTldZOTh0b3NSZW5mb0JsenZGU1g5ZVdlNDJ0?=
 =?utf-8?B?RVBNRjJ4SXorUHVrS0RJTkowcWhaTUtJRlpXWm1SelhUeEcrTGFTaWlPYW84?=
 =?utf-8?B?dkhqM1VMcUE1WDRzT3JLKzhpYXMrN3R3empJT3BZK2loekN3Y1pWZmE1Tmpi?=
 =?utf-8?B?MXA2eFY5bmVwS0NHL0NobEhKQVNZZitWdHhqSVEyU290N3lobjZwbGJVWW5Q?=
 =?utf-8?B?UTYwRUhFQmdoTURWTllneEEzN1VNcnZMUVN1aGVidllqVU5oNnVnd0tyV3lS?=
 =?utf-8?Q?rkFmzQvYMrsHjj0iMsK8xII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBCC5FA8E816BC4CB7E75E645F8DA93C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a05835-ffda-4b8e-72a6-08d9d0db8866
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 06:12:35.3528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnWfD4qoy9irzeF+0ktvRRCrRE8V3cR/mgfHeiK8LNSTzdhHVs9+8YOy65e7wiwfRzsValDNCWaLZC5Fm6inwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7917
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpBZGQgRGFuIHRvIHRoZSBwYXJ0eSA6KQ0KDQpNYXkgaSBrbm93IHdoZXRoZXIgdGhlcmUgaXMg
YW55IGV4aXN0aW5nIEFQSXMgdG8gY2hlY2sgd2hldGhlcg0KYSB2YS9wYWdlIGJhY2tzIHRvIGEg
bnZkaW1tL3BtZW0gPw0KDQoNCg0KT24gMDYvMDEvMjAyMiAwODoyMSwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOg0KPiBPbiBUdWUsIERlYyAyOCwgMjAyMSBhdCAwNDowNzowOFBNICswODAwLCBMaSBa
aGlqaWFuIHdyb3RlOg0KPj4gV2UgY2FuIHVzZSBpdCB0byBpbmRpY2F0ZSB3aGV0aGVyIHRoZSBy
ZWdpc3RlcmluZyBtciBpcyBhc3NvY2lhdGVkIHdpdGgNCj4+IGEgcG1lbS9udmRpbW0gb3Igbm90
Lg0KPj4NCj4+IEN1cnJlbnRseSwgd2Ugb25seSBhc3NpZ24gaXQgaW4gcnhlIGRyaXZlciwgZm9y
IG90aGVyIGRldmljZS9kcml2ZXJzLA0KPj4gdGhleSBzaG91bGQgaW1wbGVtZW50IGl0IGlmIG5l
ZWRlZC4NCj4+DQo+PiBSRE1BIEZMVVNIIHdpbGwgc3VwcG9ydCB0aGUgcGVyc2lzdGVuY2UgZmVh
dHVyZSBmb3IgYSBwbWVtL252ZGltbS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQo+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX21yLmMgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgaW5j
bHVkZS9yZG1hL2liX3ZlcmJzLmggICAgICAgICAgICB8ICAxICsNCj4+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA0OCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5j
DQo+PiBpbmRleCA3YzRjZDE5YTlkYjIuLmJjZDVlN2FmYTQ3NSAxMDA2NDQNCj4+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+IEBAIC0xNjIsNiArMTYyLDUwIEBA
IHZvaWQgcnhlX21yX2luaXRfZG1hKHN0cnVjdCByeGVfcGQgKnBkLCBpbnQgYWNjZXNzLCBzdHJ1
Y3QgcnhlX21yICptcikNCj4+ICAgCW1yLT50eXBlID0gSUJfTVJfVFlQRV9ETUE7DQo+PiAgIH0N
Cj4+ICAgDQo+PiArLy8gWFhYOiB0aGUgbG9naWMgaXMgc2ltaWxhciB3aXRoIG1tL21lbW9yeS1m
YWlsdXJlLmMNCj4+ICtzdGF0aWMgYm9vbCBwYWdlX2luX2Rldl9wYWdlbWFwKHN0cnVjdCBwYWdl
ICpwYWdlKQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgbG9uZyBwZm47DQo+PiArCXN0cnVjdCBwYWdl
ICpwOw0KPj4gKwlzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwID0gTlVMTDsNCj4+ICsNCj4+ICsJ
cGZuID0gcGFnZV90b19wZm4ocGFnZSk7DQo+PiArCWlmICghcGZuKSB7DQo+PiArCQlwcl9lcnIo
Im5vIHN1Y2ggcGZuIGZvciBwYWdlICVwXG4iLCBwYWdlKTsNCj4+ICsJCXJldHVybiBmYWxzZTsN
Cj4+ICsJfQ0KPj4gKw0KPj4gKwlwID0gcGZuX3RvX29ubGluZV9wYWdlKHBmbik7DQo+PiArCWlm
ICghcCkgew0KPj4gKwkJaWYgKHBmbl92YWxpZChwZm4pKSB7DQo+PiArCQkJcGdtYXAgPSBnZXRf
ZGV2X3BhZ2VtYXAocGZuLCBOVUxMKTsNCj4+ICsJCQlpZiAocGdtYXApDQo+PiArCQkJCXB1dF9k
ZXZfcGFnZW1hcChwZ21hcCk7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsNCj4+ICsJcmV0dXJuICEh
cGdtYXA7DQo+IFlvdSBuZWVkIHRvIGdldCBEYW4gdG8gY2hlY2sgdGhpcyBvdXQsIGJ1dCBJJ20g
cHJldHR5IHN1cmUgdGhpcyBzaG91bGQNCj4gYmUgbW9yZSBsaWtlIHRoaXM6DQo+DQo+IGlmIChp
c196b25lX2RldmljZV9wYWdlKHBhZ2UpICYmIHBhZ2UtPnBnbWFwLT50eXBlID09IE1FTU9SWV9E
RVZJQ0VfRlNfREFYKQ0KDQpHcmVhdCwgaSBoYXZlIGFkZGVkIGhpbS4NCg0KDQoNCj4NCj4NCj4+
ICtzdGF0aWMgYm9vbCBpb3ZhX2luX3BtZW0oc3RydWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3ZhLCBp
bnQgbGVuZ3RoKQ0KPj4gK3sNCj4+ICsJc3RydWN0IHBhZ2UgKnBhZ2UgPSBOVUxMOw0KPj4gKwlj
aGFyICp2YWRkciA9IGlvdmFfdG9fdmFkZHIobXIsIGlvdmEsIGxlbmd0aCk7DQo+PiArDQo+PiAr
CWlmICghdmFkZHIpIHsNCj4+ICsJCXByX2Vycigibm90IGEgdmFsaWQgaW92YSAlbGx1XG4iLCBp
b3ZhKTsNCj4+ICsJCXJldHVybiBmYWxzZTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlwYWdlID0gdmly
dF90b19wYWdlKHZhZGRyKTsNCj4gQW5kIG9idmlvdXNseSB0aGlzIGlzbid0IHVuaWZvcm0gZm9y
IHRoZSBlbnRpcmUgdW1lbSwgc28gSSBkb24ndCBldmVuDQo+IGtub3cgd2hhdCB0aGlzIGlzIHN1
cHBvc2VkIHRvIG1lYW4uDQoNCk15IGludGVudGlvbiBpcyB0byBjaGVjayBpZiBhIG1lbW9yeSBy
ZWdpb24gYmVsb25ncyB0byBhIG52ZGltbS9wbWVtLg0KVGhlIGFwcHJvYWNoIGlzIGxpa2UgdGhh
dDoNCmlvdmEodXNlciBzcGFjZSktKyAgICAgICAgICAgICAgICAgICAgICstPiBwYWdlIC0+IHBh
Z2VfaW5fZGV2X3BhZ2VtYXAoKQ0KICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgIHwNCiAgICAgICAgICAgICAgICAgICstPiB2YShrZXJuZWwgc3BhY2UpIC0rDQpTaW5jZSBj
dXJyZW50IE1SJ3MgdmEgaXMgYXNzb2NpYXRlZCB3aXRoIG1hcF9zZXQgd2hlcmUgaXQgcmVjb3Jk
IHRoZSByZWxhdGlvbnMNCmJldHdlZW4gaW92YSBhbmQgdmEgYW5kIHBhZ2UuIERvIGRvIHlvdSBt
ZWFuIHdlIHNob3VsZCB0cmF2ZWwgbWFwX3NldCB0bw0KZ2V0IGl0cyBwYWdlID8gb3IgYnkgYW55
IG90aGVyIHdheXMuDQoNCiAgDQoNCg0KDQoNCg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcmRt
YS9pYl92ZXJicy5oIGIvaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmgNCj4+IGluZGV4IDZlOWFkNjU2
ZWNiNy4uODIyZWJiMzQyNWRjIDEwMDY0NA0KPj4gKysrIGIvaW5jbHVkZS9yZG1hL2liX3ZlcmJz
LmgNCj4+IEBAIC0xODA3LDYgKzE4MDcsNyBAQCBzdHJ1Y3QgaWJfbXIgew0KPj4gICAJdW5zaWdu
ZWQgaW50CSAgIHBhZ2Vfc2l6ZTsNCj4+ICAgCWVudW0gaWJfbXJfdHlwZQkgICB0eXBlOw0KPj4g
ICAJYm9vbAkJICAgbmVlZF9pbnZhbDsNCj4+ICsJYm9vbAkJICAgaXNfcG1lbTsNCj4gT3Igd2h5
IGl0IGlzIGJlaW5nIHN0b3JlZCBpbiB0aGUgZ2xvYmFsIHN0cnVjdD8NCg0KSW5kZWVkLCBpdCdz
IG5vdCBzdHJvbmcgbmVjZXNzYXJ5LiBidXQgaSB0aGluayBpc19wbWVtIHNob3VsZCBiZWxvbmdz
IHRvIGEgaWJfbXINCnNvIHRoYXQgaXQgY2FuIGJlIGNoZWNrZWQgYnkgb3RoZXIgZ2VuZXJhbCBj
b2RlIHdoZW4gdGhleSBuZWVkZWQgZXZlbiB0aG91Z2ggbm8NCm9uZSBkb2VzIHN1Y2ggY2hlY2tp
bmcgc28gZmFyLg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KPg0KPiBKYXNvbg0K
