Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F257F7E0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 03:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiGYBNQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Jul 2022 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiGYBNP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Jul 2022 21:13:15 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F21116E
        for <linux-rdma@vger.kernel.org>; Sun, 24 Jul 2022 18:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658711593; x=1690247593;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YzjvU5TU13qBnCVNsGOTxLTr0z/Wvdqf8OE/5/gmcpM=;
  b=MNlJCsGeadOtCQXBuaaykHlSeTqBtLBCDNe/pBpY4IxpswElFrDJmB8a
   JfkRsUWZ4Vxs6tGrD8W0zduyFyjH356W81fc8/e1OL95qnsAt6vaS6puh
   uimZ3nfjjIe0y/LEjrO56b2bPsNNXzspU5UX7rGSf79Qfj3ClJPR4oW4f
   wB0n6Oq4B7X4FHvGpxnvOgAMVsiP2+IpczB32d4uUvOYbKBy4ZmMokJjI
   Jc4Clmlr96lXoxOPFaiEr7QaSu8OiEwhYYMqdlpXeBN0zjzj4/mVod/5Q
   8M/6b/IMoUHd7nDqT7Amxzb5QjWHUNfsKoiOwLqGJth52SrsyZNNtr2Zy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="69248542"
X-IronPort-AV: E=Sophos;i="5.93,191,1654527600"; 
   d="scan'208";a="69248542"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:13:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L75HpGqAcbNp+B4LZMe+iAobeHCr0SXgirVekG2p/asPfoEB/XZoJm3TCSKzJH1IDN8kZUSaMFWlU4yoWIeg4JeLGTCxgX+5DO47z6mn92rkKM52sUJ4QNY8eJjWeRVHhqMpSc4ej7wrJwnKYgMHAWlPuDT7PpgTnnfqeZBidzD3yiu01USy27dCcYc4TDfdZD6D5rUTOxziWB2ePk03y4bqOG8QBvP5GqASc5XRPwVe4uS20W2x0V/ZqQ8QNiH88ovIi6WcntgcXxptGN3SF61/EVmzC5Mv3UoqVceI+QlkYWe46RWQVjy0mu+u5ziMOJZvMJ6Jsy3/1Gk1I635pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzjvU5TU13qBnCVNsGOTxLTr0z/Wvdqf8OE/5/gmcpM=;
 b=Zk1USvNlmVFfLaR2sjQIwUiNQXt7W12nheB43UYJnkQraKl3XO2KZZEvqydb0kuliG6NQQ6jODPBJDJTokP1MlFB7WG3ia/afT4u6L8O4Z8JWl4XNlNGWnZEPQj5FvEHRWUlUcao3K62FxNMVIOxafD1XUeMy7vOcjacmVOwQUp/eRmIR7eoteYvlHrnnyPOhJp6wtEw6aL6KqNMrSkU4xThvMqioNTN8CfbOR+rv+G/fP2bMNdmtyhU7pzn6ilOUq60XV2E1u0nfaiMWQ434CNYZIWF85+SXk48jxhJwN1jiIVSa5c/RmNW6EnSai/rn/wWpLrpZNZNqB7eHa/UEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSAPR01MB2692.jpnprd01.prod.outlook.com (2603:1096:604:2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 01:13:07 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 01:13:07 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
CC:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Thread-Topic: [RESEND RFC PATCH for-next] Revert "RDMA/rxe: Create duplicate
 mapping tables for FMRs"
Thread-Index: AQHYnCKksO3/TjsEbUejYY02ELeZ6K2HFOEAgAJSpACABOeUAA==
Date:   Mon, 25 Jul 2022 01:13:06 +0000
Message-ID: <2b9261f7-8ade-1892-5f71-5e4de13927a4@fujitsu.com>
References: <1658312958-13-1-git-send-email-lizhijian@fujitsu.com>
 <CAJpMwyier2gtHoMhkrFeNXmqjUo9ab2Ba4Ef_YZoCwv__9cz=Q@mail.gmail.com>
 <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
In-Reply-To: <318d02a4-8028-551c-5cda-e7934153e03d@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 410707c9-c84c-4a2f-aaf8-08da6ddad4ff
x-ms-traffictypediagnostic: OSAPR01MB2692:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfpjUJf1e4slYUagKbbLbJ7zG9A+L73RpZctFk+1vQGAA5GbBt+dNEUuw9wHmLKTul/glGX1E5J006BK17QKDLxUsnk4NgwwKbnTT5U6pJGPKx8FrHjoDm4dSRVSiw45e4wdLWZMMAanMUkCfJlkm5+NN6gFrptkG40SSDOmMi1NTiUyO7UCTsC6T2/dv02M3E7mIhEHEuyZUfj8m/Tp0XCOwuGUoAoowCuwjYsF2FnXPVMnsw8lRkvcenUuRFNoHNmbPTTlr/6byp/tx/SGhloMcInoJu71qWAoL1CLN02o7/HWmmULX+IkU+ihDKr7WKg7SdjbCmmxkxWWHI/MpGwwNMIMcV5Vq7E4Do9m5l7cFRZOsGYwSacoOJEf2XpeJIjdL8QkQdadlB9t4gV5MoPusAzd3tIO8aES8m71/4k94JtFnAvJL543K2l9X8Ywys7G/NuSm1NwuUYe3PLGjZPBIOqKYmfI2N+DjnPBTq58M2qmAWPh4Ht9DMZGfNzQcuRhadrKYfTMhIRrNuckvJGgzhO4BDEZIPCVPtvmAPcu+fDXe0ZkM5SZHsQQIyrhr99VOnAld9eVjzvxitODaH4AtO/elWnTor4KiXsIxovq0UqMmKzPdOkqN0QXNWLNP/l+zn2JG7l/bBkggbhFjawKVVDUN3TXCDMnfGuPqHTMa8hQq3UJfFr6pTzYCwCZgvhfuWJlRjfiqDyQM5z6+otbYxiqwtXfaEz32NvGO5Wei7JnV5o6ec5VXmN/uaoZLCr5hvargb+ADLlFDE3UQnQTt0zEzRUipQkRFQjWI3EnbyIHP0LC5AQTmmLgRAvqywxI8Xm7rpMpI3fV00DNjEHSXVUMfHfK8dr5PAvSpkOlD+XBd9FvD7Zym0fpZGub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(26005)(478600001)(6486002)(8936002)(5660300002)(64756008)(66446008)(66476007)(66946007)(76116006)(53546011)(4326008)(2906002)(91956017)(86362001)(6512007)(71200400001)(8676002)(31696002)(41300700001)(85182001)(66556008)(6506007)(82960400001)(110136005)(54906003)(316002)(122000001)(38100700002)(2616005)(186003)(83380400001)(36756003)(38070700005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3ZqdDJYRTNweWsrcVd3SmVVbHExMURvZjI3dzhnWDdxclZISy9ySG0xWmxJ?=
 =?utf-8?B?Vm5vbDNFNEF2R0NHcmlJN2h3MmRReUlnTEk2d2pWV2tibG1vRVplY253TUw3?=
 =?utf-8?B?RFRiV1NWTUE3RGxNQ3VZVnQwZGJZMGtjcHRxaDlQcGhHbC9JTHNRcm1WVitP?=
 =?utf-8?B?cnB6RzhHeWp0MlM0UTdhYXc0L3ZPbHp0OVFRbnJhTkt6b25GZjd3aDVZUXlU?=
 =?utf-8?B?MVFRQndJYWlOVXI3SEZ1ZnZpemcrRW9ocUVYNDZ5RGEvRFFKUHV2RGRZbDB0?=
 =?utf-8?B?alhlTGpBQmdmWXJnWCtMR3NkZkd2RFBFcFM1QmZ2K3ZUVytyaURFVXZqMTVE?=
 =?utf-8?B?Yng4dzkrVlZZVDl2QTFkcEliSmtkSERQbGQ1MTc4a2VycmRGdkpLcFR4c2Y2?=
 =?utf-8?B?RDVFUFpOSkNaaWlSK1NpZk1YUU9ONTdtbmc0cXFnbzl2Z0ZTMGhtR08wcDRV?=
 =?utf-8?B?K2xkYlp2YVVKTEZLL0tSUHdhNjhrWk1Ld2N6Q0Z0cmwzMzU4Z2E5SlgycTgy?=
 =?utf-8?B?SjlMSCtJUFp4TDcwUE1qUW4zay9JSUdFWDQ2bk53VVZKSTNLUUFBVVozbi9T?=
 =?utf-8?B?RnFYN29uY3BibE5YdXkrY2ZOcHpvelVGUGpvcXVPdmdIVE41QUV2T212RGxO?=
 =?utf-8?B?OUlHdlAzUURVYW9zdG9NVnAreE9PS016dlUwY2cvV2JGRUVYazRwbWNVbHV0?=
 =?utf-8?B?a1lOK24zRUp6Zk1tbFZaQU5ZUnBhYm9IZDRMdlg1ZGFhVmVzUFkvYW5mMmhB?=
 =?utf-8?B?bzFqY0lPVkJvNjNXdVhOaFZlVVVpYmROWURoUEJQU0FNd3dwZ3YrbHlFTnM4?=
 =?utf-8?B?STc2WVlJNHc2c2NES0l2ZTMwTUJLdWdSbVM4cFF5bnB1TlFKWDlOcWJkL0Yv?=
 =?utf-8?B?NC85R3VkQXloNjhkRnU5dHVtTFk5dSttM0dFbjNMYkpBNTZOSFJJU0tCc1Vh?=
 =?utf-8?B?S3dZL3pkL2diTUxHYjU1MlAyeldiTmw3b0hHUmU4eEVua1daNElCa2E5T3hH?=
 =?utf-8?B?MkQwYklWZ3F1UmFFK0hrUXU3Y2dXZkx2RFlNVnVoL1Rac250VzZudi8zVy92?=
 =?utf-8?B?WDFueEFrMkY5bldVY3VTakZqemlWS0J6czFKN2lreThxT2RBditpOXQrRm9a?=
 =?utf-8?B?MS91VkEwbXZoSHVVaFI1eGNnM0lmZ1J3b1daM2laT1lkZzJVejZCVnhuYnZo?=
 =?utf-8?B?WmlaUG0wLzlHeU5tZWdGMkdIWXVBTHhpUTRXeFhlUEdFa09EMGNITXNTaDFw?=
 =?utf-8?B?UFU4RUlrZGh3NGI1UUp4UG1UR1RTOVplYVFmaVdwU0daVGxJYzRiRVZBK1FR?=
 =?utf-8?B?Qmxva1M0Y2J0ckdBMmo3ZnhzQ0c4VjBvUjRVU3ZGTXVXZTFJVkNoWjJPaUdF?=
 =?utf-8?B?VjRsTjdWZm1PYUxMazE4eFhQRHJac05kb1hTZ0Vid2M0WUlEaGlkSVRGK1N4?=
 =?utf-8?B?Z09xQ0Q1dnU1cDRPYkJnejJuNU8yWDBzMFNRZHlZdStLZ3QrMHJlQU1LVFNH?=
 =?utf-8?B?L1dvQ3VnRXZlSkVkb0pvYmRQbS80QnNDVWJTSXcxZHpiMjU2dWlsRUlZZGlL?=
 =?utf-8?B?WHVpeEZDV3JHdGtBdjE3QlJya0YzVytJUkg1MkpBZEVMSFVKNDBidi9CYWEv?=
 =?utf-8?B?VkF0VUM3Q3ZnU1E5UkNGOEZ4eGVERWxYaGs2ZFFlbUpjQkZ5VGRaWEg2dGdR?=
 =?utf-8?B?dVQwS29Vc2U1QVdOZnVmL2pYM3VwS29yT05MMWFYTFRZZWRpZHE4VjJkcnNr?=
 =?utf-8?B?VGxSR2ZsSHdjYmI1WXV6VVpuc3Erc2NNYXVQRG40QTRVZGVIS2hBRmtNbXRa?=
 =?utf-8?B?YzZCK2dKbzBvUlp4Z0U4ZVRheG9zNzIyVVFkUVdFcFFOT280ZXBlUStMZEJl?=
 =?utf-8?B?R0JlWitVV2ZTOTNrb1draGUrQ2c1dkpLbHZvaTRQUm1uUXdDdWJuelZGWG1O?=
 =?utf-8?B?bk0zaHhYbm84NE5lNkRkek5rUG5xNFZFRU11WW9TNDZ2eXNIT2oxUnkvZDYz?=
 =?utf-8?B?WXNoUE13Q2h0VlpvMHhsVmU4b3RLN3R1SVdwSWNDNXVWUGc5U002VGRLU3lp?=
 =?utf-8?B?NE1XRm1pclc2NnlnZ0ZqSG02bDNCM1AwdmJGc1hhbTNSWFU1ZGJzRFFMZ3A4?=
 =?utf-8?B?b05yaFlUc01vTGVCcTQvRjBRNXZIRXl6aVNDYmErYWM4M24zdnNKOTlTT29S?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8FA88987879D24789EDC5FBDE5EE55A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410707c9-c84c-4a2f-aaf8-08da6ddad4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 01:13:06.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aZ2RD/rRIK+BDzjbwzI1Bwu5nFXHUk/OyfNLVOfdffc3RZlMOTFUeRDM0zTC7Jb7MZWB6rotGbXQ/Y2PszDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2692
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIyLzA3LzIwMjIgMDY6MTksIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA3LzIwLzIy
IDA1OjUwLCBIYXJpcyBJcWJhbCB3cm90ZToNCj4+IE9uIFdlZCwgSnVsIDIwLCAyMDIyIGF0IDEy
OjIyIFBNIExpIFpoaWppYW48bGl6aGlqaWFuQGZ1aml0c3UuY29tPiAgd3JvdGU6DQo+Pj4gQmVs
b3cgMiBjb21taXRzIHdpbGwgYmUgcmV2ZXJ0ZWQ6DQo+Pj4gICAgICAgOGZmNWY1ZDlkOGNmICgi
UkRNQS9yeGU6IFByZXZlbnQgZG91YmxlIGZyZWVpbmcgcnhlX21hcF9zZXQoKSIpDQo+Pj4gICAg
ICAgNjQ3YmYxM2NlOTQ0ICgiUkRNQS9yeGU6IENyZWF0ZSBkdXBsaWNhdGUgbWFwcGluZyB0YWJs
ZXMgZm9yIEZNUnMiKQ0KPj4+DQo+Pj4gVGhlIGNvbW11bml0eSBoYXMgYSBmZXcgYnVnIHJlcG9y
dHMgd2hpY2ggcG9pbnRlZCB0aGlzIGNvbW1pdCBhdCBsYXN0Lg0KPj4+IFNvbWUgcHJvcG9zYWxz
IGFyZSByYWlzZWQgdXAgaW4gdGhlIG1lYW50aW1lIGJ1dCBhbGwgb2YgdGhlbSBoYXZlIG5vDQo+
Pj4gZm9sbG93LXVwIG9wZXJhdGlvbi4NCj4+Pg0KPj4+IFRoZSBwcmV2aW91cyBjb21taXQgbGVk
IHRoZSBtYXBfc2V0IG9mIEZNUiB0byBiZSBub3QgYXZhbGlhYmxlIGFueSBtb3JlIGlmDQo+Pj4g
dGhlIE1SIGlzIHJlZ2lzdGVyZWQgYWdhaW4gYWZ0ZXIgaW52YWxpZGF0aW5nLiBBbHRob3VnaCB0
aGUgbWVudGlvbmVkDQo+Pj4gcGF0Y2ggdHJ5IHRvIGZpeCBhIHBvdGVudGlhbCByYWNlIGluIGJ1
aWxkaW5nL2FjY2Vzc2luZyB0aGUgc2FtZSB0YWJsZQ0KPj4+IGZvciBmYXN0IG1lbW9yeSByZWdp
b25zLCBpdCBicm9rZSBybmJkIGV0YyBVTFBzLiBTaW5jZSB0aGUgbGF0dGVyIGNvdWxkDQo+Pj4g
YmUgd29yc2UsIHJldmVydCB0aGlzIHBhdGNoLg0KPj4+DQo+Pj4gV2l0aCBwcmV2aW91cyBjb21t
aXQsIGl0J3Mgb2JzZXJ2ZWQgdGhhdCBhIHNhbWUgTVIgaW4gcm5iZCBzZXJ2ZXIgd2lsbA0KPj4+
IHRyaWdnZXIgYmVsb3cgY29kZSBwYXRoOg0KPj4gTG9va3MgR29vZC4gSSB0ZXN0ZWQgdGhlIHBh
dGNoIGFnYWluc3QgcmRtYSBmb3ItbmV4dCBhbmQgaXQgc29sdmVzIHRoZQ0KPj4gcHJvYmxlbSBt
ZW50aW9uZWQgaW4gdGhlIGNvbW1pdC4NCj4+IE9uZSBzbWFsbCBuaXRwaWNrLiBJdCBzaG91bGQg
YmUgcnRycywgYW5kIG5vdCBybmJkIGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4+DQo+PiBGZWVs
IGZyZWUgdG8gYWRkIG15LA0KPj4NCj4+IFRlc3RlZC1ieTogTWQgSGFyaXMgSXFiYWw8aGFyaXMu
aXFiYWxAaW9ub3MuY29tPg0KPj4NCj4+PiAgIC0+IHJ4ZV9tcl9pbml0X2Zhc3QoKQ0KPj4+ICAg
fC0+IGFsbG9jIG1hcF9zZXQoKSAjIG1hcF9zZXQgaXMgdW5pbml0aWFsaXplZA0KPj4+ICAgfC4u
Li0+IHJ4ZV9tYXBfbXJfc2coKSAjIGJ1aWxkIHRoZSBtYXBfc2V0DQo+Pj4gICAgICAgfC0+IHJ4
ZV9tcl9zZXRfcGFnZSgpDQo+Pj4gICB8Li4uLT4gcnhlX3JlZ19mYXN0X21yKCkgIyBtci0+c3Rh
dGUgY2hhbmdlIHRvIFZBTElEIGZyb20gRlJFRSB0aGF0IG1lYW5zDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIyB3ZSBjYW4gYWNjZXNzIGhvc3QgbWVtb3J5KHN1Y2ggcnhlX21yX2Nv
cHkpDQo+Pj4gICB8Li4uLT4gcnhlX2ludmFsaWRhdGVfbXIoKSAjIG1yLT5zdGF0ZSBjaGFuZ2Ug
dG8gRlJFRSBmcm9tIFZBTElEDQo+Pj4gICB8Li4uLT4gcnhlX3JlZ19mYXN0X21yKCkgIyBtci0+
c3RhdGUgY2hhbmdlIHRvIFZBTElEIGZyb20gRlJFRSwNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjIGJ1dCBtYXBfc2V0IHdhcyBub3QgYnVpbHQgYWdhaW4NCj4+PiAgIHwuLi4tPiBy
eGVfbXJfY29weSgpICMga2VybmVsIGNyYXNoIGR1ZSB0byBhY2Nlc3Mgd2lsZCBhZGRyZXNzZXMN
Cj4+PiAgICAgICAgICAgICAgICAgICAgICAgICMgdGhhdCBsb29rdXAgZnJvbSB0aGUgbWFwX3Nl
dA0KPj4+DQo+IFdoZXJlIGlzIHRoZSB1c2UgY2FzZSBmb3IgdGhpcz8gQWxsIHRoZSBGTVIgZXhh
bXBsZXMgSSBhbSBhd2FyZSBvZiBjYWxsIHJ4ZV9tYXBfbXJfc2coKQ0KPiBiZXR3ZWVuIGVhY2gg
cmVnX2Zhc3RfbXIvaW52YWxpZGF0ZV9tcigpIHNlcXVlbmNlLiBJIGFtIG5vdCBmYW1pbGlhciB3
aXRoIHJ0cnMuDQo+IFdoYXQgaXMgaXQ/DQoNCml0IHdvdWxkIGhhcHBlbiB3aGVuIHdlIGFyZSBj
cmVhdGluZyBhIHJuYmQgY29ubmVjdGlvbi4NCg0KbW9kcHJvYmUgcm5iZF9zZXJ2ZXINCm1vZHBy
b2JlIHJuYmRfY2xpZW50DQoNCmVjaG8gInNlc3NuYW1lPWZvbyBwYXRoPWlwOjxzZXJ2ZXItaXA+
IGRldmljZV9wYXRoPS9kZXYvbnZtZTBuMSIgPiAvc3lzL2RldmljZXMvdmlydHVhbC9ybmJkLWNs
aWVudC9jdGwvbWFwX2RldmljZQ0KDQoNCkkgaGF2ZSB0ZXN0ZWQgYmxrdGVzdHMgYW5kIGFib3Zl
IHJuYmQgY2FzZSwgdGhleSB3b3JrcyBmaW5lLg0KRnVydGhlciBtb3JlLCB5b3VyICJbUEFUQ0gg
UkZDXSBSRE1BL3J4ZTogQWxsb3cgcmUtcmVnaXN0cmF0aW9uIG9mIEZNUnMiIGRvZXMnbiBmaXgg
dGhlIGFib3ZlIHJuYmQgdXNlIGNhc2UuDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4gQm9iDQo=
