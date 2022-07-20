Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464A57B426
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiGTJsd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 05:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGTJsb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 05:48:31 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B2165598
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658310510; x=1689846510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EgxknF41hbO5WgbC4J+5E4HIptSFKgf0kl1kN083Ufk=;
  b=Jev84u160hQQ+SsE0/ijBqNWZD9iKMD1jcuigmX5oyAWFhwRy5zsdDCB
   bXKGu1mGAaHmZf8LIJhdaToLna2gENBKsbGfTnik26dgd80n3EsdeRK1+
   VMqJLbNJFmNLgujkGDWMZQEtMEQYT6B5xoIYvKUPPYOIPNLMuwzY8sBfj
   VQS2qCq1s780L37WYBFEFRWI2XsRAjjWgIOVXv6h0bPi+dRS1i/bb8etj
   gCokUUEJqSjMppY9q39EdloGj/guD5XZONaZr3ufLlp/3xOhYJLD1Ex+q
   OQMzsBKzmnBtR0Jp/NTODSV7Mvtdxt0L1HKbH5OQv2VWUZNiUcPhEj2uO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="69018631"
X-IronPort-AV: E=Sophos;i="5.92,286,1650898800"; 
   d="scan'208";a="69018631"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 18:48:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/H7myOtErdDpETlpYp6QHqHJ1IE+/QHe32Zpec4YxhBilh5vy1k1ftwX+ElfgdpviPw+3MDtJujeHDB6mxEQVTtkbT/3E+mUf2bphVBMnkT7oGPmYZJfzrwmByzIEJjrDIbuqN/h0n7kl8ZDIVVB+T6NqcRVk7tKg/dhQ46gD6CDSyOukfONN7nS32DVzoCfKbN/CUNncsMeMiEAn61Q4pV5DU3KZze72Jp7U7SMsP3HDDDHLuhpoS6uoml+NX+iRRr0cGFFh4bz++M49Jq9k/PZ1Q0GGTOtPanqz/zbEhK79SBcl+b8t4wKIuIx2oVg/03e8oGKNrUw+SeLO89JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgxknF41hbO5WgbC4J+5E4HIptSFKgf0kl1kN083Ufk=;
 b=IldVfMTWsYTh9XKmaBbnvp4r0hePGAzCcwBffKWdCZdgza18v+HxM+M8yTx6vS7zTQq0KK8zvzdtYr1lvpW0tt1g+UsoECWeJNwWtK6a8Qqkw9yjM6r+y6wGkFeaHyxpdRlLum4vv5PZ5NhKJsudIUKw4yP16lvc230dEZ22zoRc2fJq6M0RSjEFnwdblLg1whCSmwCH0EGPmmFvgBm471+1LO/yzbfgTgpU9eM0n5iFfG1Xl/hRxJs3JlmB6QrCayORccGfcoSr7XzCWiqXevYK4z2liUdpH1d9LZrpGu6IusfUxqe4YrdKp3ERJYwroXtpMebYBSLH00BpHWoGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSAPR01MB3153.jpnprd01.prod.outlook.com (2603:1096:604:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 09:48:23 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 09:48:23 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Haris Iqbal <haris.iqbal@ionos.com>
CC:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate mapping
 tables for FMRs"
Thread-Topic: [RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate mapping
 tables for FMRs"
Thread-Index: AQHYm+vFXb6hLgvMCEih4g+nFO6upq2HAUEAgAACmQA=
Date:   Wed, 20 Jul 2022 09:48:23 +0000
Message-ID: <7090e9f0-1c26-9698-9ff0-0d56468fd07c@fujitsu.com>
References: <20220720035700.2076987-1-lizhijian@fujitsu.com>
 <CAJpMwyjAsU-prCai30wbZZ+LWbjhX6hcsxbd1rmR8m5D6SjiPA@mail.gmail.com>
In-Reply-To: <CAJpMwyjAsU-prCai30wbZZ+LWbjhX6hcsxbd1rmR8m5D6SjiPA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 428781e9-26dd-4413-86d1-08da6a34fc83
x-ms-traffictypediagnostic: OSAPR01MB3153:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zoDf4EyjXYHdGe/k4lPGlmx+fvxBdlxI2MS/cHeW5h9Bt/Vz2fNN0a0KU5eggp05wVSLC9vgYpNlzS/SXIzACoAUJD3rYeT1mscfxoabsqY0ric+sGtc7RL/oh5MUoqiSI0RuMlF9iWKv+uLWN01t19yLGHIJbpi9yvK3F66BQLxTT5SdQsPCuV3+86Cwp0+Hec8/GD1swHjBrl4ZO+T5CqwCfq/cC5NMXPq6R6ukn+99g5p3dxUUa1PtR4NVHdTAdO/3rOWpZMCUGQnyTB9oFpJ+rzXvXnC0BHHuXwrHO8R1irp+xDeIcCSjOpNxCaV7+oDONhjPhmXVJt65BgDb0bAESnXPd4QeucrmKvLduI/9gTiHeefVzFjAkVTFN75cKOYXEQ9GtLqSrjQek6e0rWDosal9CtI8jPBV9P4KpZVAxdJS16g3ELOMJy7brJrDcB5k2R6vAHs0PWdCYESesVEIVvDiZaRXT3SvMQvniyyRqPH7PAV33Grz7uWEr96RLFCMo1IBDNlRVm8vuBwY1Btg11E3baco9Xbos/ya1hhcCijSnJgPI/GpoXxMQAkUw6eIDUMV+Ku2yK+0e8x7g/xVIup2JajJjKp4nEWW7vR4EX7sVIlPcCkmBd+YyugJn3uq/AsHH0ufit7JfgnsqULRygO01ItAPwtVsxpXf6T/O2DI7Tz9lr9C8nF9seGwk8r/Zxi670cFmp0TD0GlfS3AkJ9TmJBh71MBEIPmE8aHAtDCKIn/ICUTFTox7973R21yKqo3gWp2Rgh4gF+kQcoCuqgwTJ1QMm7l6TcVHPuFKhhlcQFQowe/K9zSa4tV5fx4ZbXd/p1cG8ZPjL6ZYwCme8aTlE7T+MC7KvioewLORyb14dgC1W7hh3F8q+yD+meuVE5yQOvqfzar9PCFDJl6Gu/GWnJzqGw/9OtZWdg32+mlrfButgbTgwR2C2P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(2616005)(966005)(45080400002)(71200400001)(6486002)(82960400001)(31696002)(478600001)(38070700005)(6506007)(26005)(6512007)(86362001)(53546011)(91956017)(41300700001)(316002)(54906003)(6916009)(83380400001)(31686004)(186003)(4744005)(66946007)(5660300002)(76116006)(66556008)(4326008)(8936002)(64756008)(66476007)(66446008)(8676002)(122000001)(2906002)(36756003)(85182001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEd3azBjeG9hYVhBRldOQWVQaDBuakF1TGNOalVRSitJSVFGWis1bzBOZXVU?=
 =?utf-8?B?RzJXWG50Tm9HNFFVaHpiTDVSaEpFK3hpYjE0bTl2ZDJYNzhOdm5uYUNIOVF1?=
 =?utf-8?B?dmxvWkpiUXdWQ1cxTndEZHJCR01JN29sZmhkdnlZT1lBZEZSRFNpL0F3L2tI?=
 =?utf-8?B?MmdkbFRHa0ltOTlaRkI0V2Zsa1B3amNBUlB0NVpsWm45UFhYVXlCZjZ5ck9y?=
 =?utf-8?B?MjZ4cnpHaWZsWGtyUFpqc3BRbU1vbjBWaXlLbXVWUU16eEFVdWtJRFNuT0hZ?=
 =?utf-8?B?MUxzSmdxVDVPdnMvTzNzK21icGRDTW1EWk1CTnpKeExRejZOLzdVaFRpTFpK?=
 =?utf-8?B?RTlnRDFTWEx5Y1BhMS9Cd0pKdjZ4SXE4bDJXZVIvMWNUUDZ4dXpvU1BNV0lm?=
 =?utf-8?B?ZDhJLzJGcEI0SHZVYzNHR0lTZXkxOVVoVWdIMkFZNW1WTFE3NGdCcmh1TFMy?=
 =?utf-8?B?OGpRSVVYMjZOaXJRZjNpUXNUVWtiQ3NVRUVEcWNLWXBjQjhlSDBEK2FnWWRP?=
 =?utf-8?B?MG5CZDhvd0thT0pqT2dNdmxxcG1kME0xLzd0MlU1M05zSVIzL0hya0hTYzJz?=
 =?utf-8?B?VllLMVRwTnRwL2Y0UXhybXVDeTZEMCsyM3pOQW9CWjg4YmFibWJLeXRFckZM?=
 =?utf-8?B?UW9qcHFGYUVyM1NpZlNrendHaE80cTd3OEtVUlV0WFA5QjROZEtvZ2FqSCtI?=
 =?utf-8?B?NmpyT0pXTjB1eU01bXBuVUZFRjhyWjdwbXhWWnBaUzRjNFg4UEFpVCs5bmVz?=
 =?utf-8?B?TytKNEhOdWo1Y3prdVNEK01BV1FhMkN5b0tMeGlrczdrOEZaRnhWcnVJQ3Vv?=
 =?utf-8?B?NkFoeUUySDJvc0ZhaWFDaFgxRFN6Q0V2cldDQlQxVVZYK3lKTnRhRThVVExO?=
 =?utf-8?B?Z05Da3N2Q2k5b1psOVkyVzFHR1ZYZTBrY3QxaDlMN0dpL0xhZFBMVlp1cVBJ?=
 =?utf-8?B?VkZzV016L01HTHFlUmxsRlJMMHhmc2xrUW5LMG14Qy9QUkhZUVhBbzk0TXBI?=
 =?utf-8?B?RzBYUzRWQWhFaXM0bUkrSEZONmpkRmNqQ0V3WURHMzMyc3lNNEpCOTk5c1dx?=
 =?utf-8?B?dngzbnM0QTFIaU4rQXEra3Q0Skw1TlpkVWZucXRUb3hEbStkUy9hTnhEQjhr?=
 =?utf-8?B?cjVzSWs1eVNlM3dtRURMK09kSFlnSno0dGp3cWVNRmxYUVduR1RLVStoeXc1?=
 =?utf-8?B?b1lrODNmSUxFcVkzemFyZEllYnNiUjZhUnl2Y3hCa3ZlSU94ei9wc1dzVWJr?=
 =?utf-8?B?VWhMb1ZCV3pXY0szaG5JUy9JYWNidGtpbUlROHMwZmZVWDUxMmtHRDllajhS?=
 =?utf-8?B?V1dkTHV0amdlQVpaU00yTTM2OUVyc01ocmFPTzZ3QjdidWFFdTBjTW8zTmhr?=
 =?utf-8?B?dUY4cVkzbG1FYTVUMHNmUGg1cStMcmJ3aVdZdWtGRVVFNTB1K1ZEL3FPcFpS?=
 =?utf-8?B?UzF5c1ZXakRKdm03Q2krS29QOWRkTXdvY21KNmsvQkI3bEpOdm4zS0Qvamg2?=
 =?utf-8?B?a3RqRHZ2WGRQa0Z1QXlLeFhBSmhhSjF0S01JNDNOU0QxTTdweDNIZ0Zvdkd2?=
 =?utf-8?B?K1l3MFNNTUo1NDBpei96RFRNaUNNTitaN2hQSEVuK0Z0ckVOUG1zNlVTZ0s0?=
 =?utf-8?B?bE04OVhaRlZ4T0d3S2FSaUVPYnFEYXUxemp5SmRtVFlZUFBIa0M0bldNanoy?=
 =?utf-8?B?eFB6ZG5RUkVmZ09ubFdyYkRmM2RXU1dkTmlMeng1RnpDSHBZWkcweFROT0w1?=
 =?utf-8?B?amxyWmYzRWljbzluZ1B2bWllbGNoV1RZWWtMeHlELzkrUGNOQ3RIT2dLandz?=
 =?utf-8?B?WExla0EvWHZBbU85ZkJMdGVacmwyTGY3ZUNkT2lwRllHMUcvTUo1UUp1RkY0?=
 =?utf-8?B?WGI4cmdHSXk2Qlc5YUFCQlRhME5uZFQ5RXBjb3k1MXpoOUIvWmZsdHJCQ09l?=
 =?utf-8?B?cE1jWUJLa1Z5bGpaamZ6MlJzbGV2YWZMRXpyVzIyL1N4UFBFU3VoME9Nc2lr?=
 =?utf-8?B?K2M0MWpoeDhIZW9pUUpMQk9ENkRjN3B6eFhYTjJoeXNNK09jdGowbEVKNWlB?=
 =?utf-8?B?R3BuSFpReFp1QzVSUS9ORExDc0FYUHBuL29vT3FlZ1dwMWNjbnN4TjZnMGth?=
 =?utf-8?B?aGJaNUFLWnp0TVdocXdZRGpQTTNNbFdYTUJvd0dneHlGOTBRcFBaOE9pMTZI?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4FD92ECB296FB448EAE9C59952D7DA6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428781e9-26dd-4413-86d1-08da6a34fc83
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 09:48:23.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgZTgRnN3mcqh05bJOhC2ILXfg30uX1wi2CMD+dDXuCotbOBH7J0Ea72HjKfDS/EoFJc6RBRoeG7IxpH02NlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3153
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIwLzA3LzIwMjIgMTc6MzksIEhhcmlzIElxYmFsIHdyb3RlOg0KPiBUaGVyZSBzZWVt
cyB0byBiZSBzb21lIHByb2JsZW0gd2l0aCB0aGlzIGVtYWlsL3BhdGNoLg0KdGhhbmtzIGZvciBw
b2ludGluZyBvdXQgdGhpcy4gWWVzLCB0aGUgTWljcm9zb2Z0IEV4Y2hhbmdlIHNlcnZpY2UgbWVz
c2VkIHVwIG15IHBhdGNoLiDwn5itDQp5b3UgY2FuIHBpY2sgdGhpcyBwYXRjaCBmcm9tIGdpdGh1
YjogaHR0cHM6Ly9naXRodWIuY29tL3poaWppYW5saTg4L2xpbnV4L3RyZWUvcmV2ZXJ0X2Ztcg0K
DQpJIHdpbGwgcmVzZW5kIHRoaXMgb25lIGFmdGVyIGkgcmVzb2x2ZSB0aGUgc210cCBwcm9ibGVt
Lg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiBEb3dubG9hZGluZyBpdA0KPiBnZW5lcmF0ZXMgYSBm
aWxlIHdpdGhvdXQgY29kZSBidXQgc29tZXRoaW5nIGVsc2UuIFRoZSByYXcgdmVyc2lvbg0KPiBi
ZWxvdyBhbHNvIGxvb2tzIG1hbmdsZWQuDQo+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXJkbWEvMjAyMjA3MjAwMzU3MDAuMjA3Njk4Ny0xLWxpemhpamlhbkBmdWppdHN1LmNvbS9y
YXcNCj4NCg==
