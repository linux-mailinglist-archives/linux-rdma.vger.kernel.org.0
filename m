Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF8488FE9
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 06:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbiAJFxH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 00:53:07 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:16501 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233436AbiAJFxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 00:53:04 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jan 2022 00:53:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641793984; x=1673329984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d690KY5TpgTvfWh+HZXFOQ+zs+9Swv233tHKJg9Yr6g=;
  b=yUgerOLPmhgyYqQef9l14NTKH5yeSM5BaGc9sWIy78j/mdt7iEeegZbp
   hYq0GOxCBgmvZXf7QLFp0E/1RTEAY1zlqUPjSswzD3dFhkuNRgnhkLpFQ
   fMxpB7itDj+HSQ6FzP+MUhkI9e3jNRNh7MFV/HU7S+bauvf8PRC6BHXB1
   wx9MwdmDUPNekXGS7xDNoUxk6ztkCKR1lKTwqIM8FI4JeMXC+oR5tBk//
   270PFRUXsOasO2ejsmru888TVhmCmWKtQoB35qlr19v+hZbq857InpMZE
   +BRRPdWwDkBMWy2aE1/1v4cDSj36ZIvT1qgypoDA632ryLAAxhTH10ZhR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="47260953"
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; 
   d="scan'208";a="47260953"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:45:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WThQHXAv+Jeep/ahg388+Kl0DgC8xmp6tmYH5Bvd/8SjVnmxRmd2klrLthqE7xWiuETInWnL7+u5pNKukTFCEs1EcpXZF3W4u+0rPDe5yxUgvv6qwnJtP6nUmbtj1o77B7EgIx0GJlskjWPTxsUV4HiYPTtOhuTApZSCWi9mpstcrKFZViFDOmFA9U9r0LJ5yRwfzP7DLHNtq2bGd8vrdVicmyU6rzkWV6wWr/FlR5tJpNBHibfuukF8cebB+oY5yVFYKSIPK1VOvfTxRlBEevJsOrIo08sutLxfaZE3G3Er9Y5Bp2g6iE+agWKlSgi3rpwSfhvi9TFAZZr1MvEKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d690KY5TpgTvfWh+HZXFOQ+zs+9Swv233tHKJg9Yr6g=;
 b=cMox1/uFMh0wjtR3IrzBofh/ezyMuRxOKBilL4i4CVkRRfOc6RhI8Wyx99QoNLR9AC6iJ5oJmsIZNDBOQ/FzxRSix/yldurApW9f28/ZtcZsLrKIMb0ku7AhvQpPH8Sm2ik74kSP+Lf8T7ZDa64D8hFGVBwmiO2+agXbi7WQ9OJrqTAACSCCG7J1/lhK9nv2a0wPsNQLusQopo4W+govrCX83QPCbcCY2CwZ4PFgjQAUaBs1IcweBm8DdJ6NDUc4UaACZcYEsWI0/WJ3FsYTTZr0EWeg2F8WNye6SkvC3GZr6CjJYHdUsFa9g367JfYcjFrppRDr95PGxXaouMBGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d690KY5TpgTvfWh+HZXFOQ+zs+9Swv233tHKJg9Yr6g=;
 b=QHTP/JaVO6PQptJKkRciTdUiNVRiRhkhaEPOmUhqTjXBprFL6txXhqD4t7Yj24EHbdR2QoJtH3PuMc8GV6RyumJMx6l1ALsWZAtK9XLQntJjK4CI59cT6uR1k/whxAGzqPYZ34bEWneJPdb2nnXfHgdZpiQaddVnX5+tLDmndb0=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB8421.jpnprd01.prod.outlook.com (2603:1096:400:13b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 05:45:48 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8110:65ae:1467:2141%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 05:45:48 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Topic: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Thread-Index: AQHX+8ExNgnDPI7BNEiFy0xj9MaxG6xVMQcAgABoxYCAALXOAIAFg4eA
Date:   Mon, 10 Jan 2022 05:45:47 +0000
Message-ID: <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
In-Reply-To: <20220106173346.GU6467@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99a8db24-3713-4b92-59d5-08d9d3fc7471
x-ms-traffictypediagnostic: TYCPR01MB8421:EE_
x-microsoft-antispam-prvs: <TYCPR01MB8421AB81A1AB00147408D801A5509@TYCPR01MB8421.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6oUL5YcvWH1dAUuneH4jsfnLlTkkoTW5/7rzG4rx4Yh11wk1jqk65qfC5bQ7uHFO2gupKVIZzwpGcroUFNFzdxZ4ZytcV619AetvqnriOH/hpLWzevqd6jPTwd3NoQPug9E8lWxMjsTG+Qpf/5tSYOMgl6meun+1jNCf8RgBXELUsZXpzdeyyiAdQf4OK0SlX8b6j+IWEwoDJcdbRldqmVoVct7rke9QfSlOOWiYT7sr+fNeyyGbpABPgyMOX5Ubprc/+17fElisVyNafWr45RBR5CgMBWBZB7WBuwvRE+8iz8xVm1e2sUIwyXiDmVTPt5tS4RKqkfEbmkwpcYfGaidSZLWP9C0l5nouxkkTIj2KtJ5wSbXkCiLp8LIQEb4goLGVApkfI8rfa9QhJkNJIFDwscQu8sSzpLlZIfKqRcLjWdkxzzPiSKuh9HiifH1Y/631yT66CRIEsC7zjte88x5WapggRFAn3u58cGY69bKJPGn5I+YxbXqbUJzn4qwJwADVh7ikopRC6LOM5yxNQH81ngRGAadPp8KlsW3CKbJwbzAGqmfllUTw4uMl802zW7vL/nFqNkFzcsQ46pA8PvTr8wKOfw9+/AaM/Z4UlP7DHWl4gU0tBqdsgx1Z80GXzES8KdLtDUKktFzANzHXiEBREl/XTWIzjafPCiNU0FKfnsBMFZLwPhaNwxqiDCq5YJDM+mKzeehDjdumuyUNMmVpUKGzjKHlNO4YKJ+rtEMpuyfJbJqfOKgZkbesiPuQF3QqhCTBLWf6K4EX3XLvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(66556008)(71200400001)(85182001)(2616005)(64756008)(122000001)(5660300002)(66946007)(66446008)(31686004)(38070700005)(66476007)(31696002)(82960400001)(107886003)(2906002)(6486002)(83380400001)(53546011)(6916009)(76116006)(36756003)(8936002)(91956017)(26005)(4326008)(186003)(316002)(8676002)(6512007)(6506007)(54906003)(508600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlJSTStnNGM1MlhhTW1YTHF5UGhGeXdPazhGclYrLysycFZVU2VQK2xIbi9U?=
 =?utf-8?B?RnU4UzdwQnYwTWphZ0x6UHd0S2hRRGxUMnBtYTdTSSsyOS9aSmJsNGNITmxw?=
 =?utf-8?B?MWZCYVBFdkxVQkpBbGtYNm1EdVI3QUZzTFFieVpBMGxULzhmaEFQa1BabjMx?=
 =?utf-8?B?cU1MOUVJZm5TVHB0Q0VST29oRWxrY0hySjlyUExweUJNM1d0VDVGSVhOb0Nq?=
 =?utf-8?B?dHBUcE15MS96VXJVKzJnWTV2TXVIa1JNeGV0V2FaSnpjSVFON0h0TitSU2Nv?=
 =?utf-8?B?WjFmRVZPYUljSjJhVW1FRlptMU9VemVBWitvd3RkQnhlanNpUVNuRW9EQ0U0?=
 =?utf-8?B?ZUlSNmNuMVJybnBjWVh1dDZKSzNhVVoyekdXbk9KaFhLMDdpVnhrVUtKU2M4?=
 =?utf-8?B?aU5oeGdNL0l1dXorNEV6dEJ6TkVpbzVHYjdnVE9paXUwTmRHZE9JUGNtVzll?=
 =?utf-8?B?ZkFZNDBKSmh6T042OGE3ODZjMTV2b1NrZ2FWeWxQVkozL0Q4dkRNd2ZhWUpC?=
 =?utf-8?B?VFNXTjZsL3I1VjlLR21HdlBhbEpSSW5GdFFJWk1ZVWE0dWdjVmx0bWZXbEdD?=
 =?utf-8?B?bEx6Kzh1WVBMOGZSSTlqeE5BSkJoOUhZdmFNcllVUHVnRHJvT2lyWHIrdTZk?=
 =?utf-8?B?OHZiZldtMGlaQlFUcnVKQ3F6b2ROYWtNYWRZUEZremtwWDd0ajIxZVQ2aXpy?=
 =?utf-8?B?eDBaeEdlUm5YaVVKaEllbGszZU5IcHVwNjZRTTNoYllYK1BFSmk0eFB2UWs5?=
 =?utf-8?B?eHlzc2dmNWc3c1craVVaUnZUQjhoQ0IzUnhnUVJnRE1wcXFhUnpkemdjaHdB?=
 =?utf-8?B?S1ZiK2xBRmFkYmc4eTNNS1oyVzBYOWw2K0dvWVdteUMzYW5OK1MyTFFPd0wv?=
 =?utf-8?B?WnJxcTRDSmpkdkIwNGZjRG0vWkdlOGlhWFFUWHZ3eVJ5WldhTTlLUWtaT1Az?=
 =?utf-8?B?eXJIUkNVdEE0dm43ZlM3L1ZsdkswYkFVUE90NzRhSDV6eFp1dGZzNC96Z1g2?=
 =?utf-8?B?NlYxTWV2UG9tMGJwWFpJQ3pHakt2RjgwS2ozUlhlQ1pYNFEzUzVLOVJNUFhu?=
 =?utf-8?B?S2tMZnNvOFppZGpQWllTVjVNd05sRkttc3M1OU9ucnBJYkRzL1UxSHZ6Mm1q?=
 =?utf-8?B?c0h0Q1IzeGdsd3VHbVFITjJZU2hnRE0wNWlITWJESFcvVjhHVE1OVHVoeVZ5?=
 =?utf-8?B?NHY5cnd1WmhlVzh5YnBWcldFbnloSEE3QUFaWkRZcjRNZlZXWG9BMk9SVzJ5?=
 =?utf-8?B?eTczSzdtZUFzQTljdm9aR1V5MUtnREkwMkFDL25KVU1paTMzNGZ6VmhOUUtM?=
 =?utf-8?B?U2RNQ1ZEZzZCV1ZXdmk5dWVRUTVrYWJwN043Z1RKbkFlSXVUbHRSUHFYT1lo?=
 =?utf-8?B?TG9hZjAwcVQ2UElSUmtOOXRXVHE2ZlRMaU40UlFxRlpaQjlTZitid3ZmakZK?=
 =?utf-8?B?eUNQQ0Nkak1oOHR1RWpKaUZBdmU5WlBvVGxNQWJVL3NJNHl0M3dyc1Fldkoy?=
 =?utf-8?B?RjAvQVNXcTgzd0ZXUkNUSVpKNTVQRmFkOE9Wd2VoY3JhUFFnUzJyMVAzd2s0?=
 =?utf-8?B?aktmbUFZY0wyQThiOUZ4N2lmSmJORWJ2TnZ3cldFbFVmTmF0akVBSTdNUU4v?=
 =?utf-8?B?djhXcXlRdVRpNGp1TDNBSTNua0wyS3IwanFkdjAzTUFDZW1zbmxWZ1g5WlhJ?=
 =?utf-8?B?T3cyU2MzU3Y2YWtJYXFBb1I5QVBma1RSTUVWTnh5QjBiNXlFUC9DamI3bnFO?=
 =?utf-8?B?UnNxWG5GWW5RVEVVREE5bm9BVzE4akNvVytNd0lHZmpsbUNDTUFjcFNtUGJQ?=
 =?utf-8?B?Z0RrMnJCUEw5RHBTT2EvelBBdGFPcmxmQnF3bGRBWkM1QmNGS25oajJHM1hp?=
 =?utf-8?B?MmpHRFRNdHM4eHdBUnkxVmk2R0UwV2NuRER3ZkxpcEFLMmFMUUgzc1h4MURj?=
 =?utf-8?B?cHdvV1hyQmNVR3pDQXN2dkQwUm96cEp2VFVmQ2Z0YmNFbFliL000WFBFZjlF?=
 =?utf-8?B?VEU2WERrcitUT0xPbXVkZ2drRG02a2R1NFVmU01vaEpCVDNOem8zM0NHTk42?=
 =?utf-8?B?OVVTbmgxaGJleEdBMjJ3TTNKNUdGbkZzcVl5THo2QUxOek12WlRvNnFhSEVn?=
 =?utf-8?B?citweEt2OHEvWDRIQUpkaWVlbTMvQzUybjJ0K0VnaC9lYjZyZjdjUHA3QXlB?=
 =?utf-8?Q?vIMErAhP3Kfm/02a2PyTzqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F34763ADCDEA9949AB9617AE63C0EC95@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a8db24-3713-4b92-59d5-08d9d3fc7471
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 05:45:48.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zB3HUofp6vtHA6JN7Ai7hFNe95/kMPIusc+wMVEo5Cmu2U5uwZoSghItXR9Yq+n6gLe6AgDQwjbLounUIhP9+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8421
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgSmFzb24NCg0KDQpPbiAwNy8wMS8yMDIyIDAxOjMzLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIFRodSwgSmFuIDA2LCAyMDIyIGF0IDA2OjQyOjU3QU0gKzAwMDAsIGxpemhpamlhbkBm
dWppdHN1LmNvbSB3cm90ZToNCj4+DQo+PiBPbiAwNi8wMS8yMDIyIDA4OjI4LCBKYXNvbiBHdW50
aG9ycGUgd3JvdGU6DQo+Pj4gT24gVHVlLCBEZWMgMjgsIDIwMjEgYXQgMDQ6MDc6MTVQTSArMDgw
MCwgTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4gKwl3aGlsZSAobGVuZ3RoID4gMCkgew0KPj4+PiAr
CQl2YQk9ICh1OCAqKSh1aW50cHRyX3QpYnVmLT5hZGRyICsgb2Zmc2V0Ow0KPj4+PiArCQlieXRl
cwk9IGJ1Zi0+c2l6ZSAtIG9mZnNldDsNCj4+Pj4gKw0KPj4+PiArCQlpZiAoYnl0ZXMgPiBsZW5n
dGgpDQo+Pj4+ICsJCQlieXRlcyA9IGxlbmd0aDsNCj4+Pj4gKw0KPj4+PiArCQlhcmNoX3diX2Nh
Y2hlX3BtZW0odmEsIGJ5dGVzKTsNCj4+PiBTbyB3aHkgZGlkIHdlIG5lZWQgdG8gY2hlY2sgdGhh
dCB0aGUgdmEgd2FzIHBtZW0gdG8gY2FsbCB0aGlzPw0KPj4gU29ycnksIGkgZGlkbid0IGdldCB5
b3UuDQo+Pg0KPj4gSSBkaWRuJ3QgY2hlY2sgd2hldGhlciB2YSBpcyBwbWVtLCBzaW5jZSBvbmx5
IE1SIHJlZ2lzdGVyZWQgd2l0aCBQRVJTSVNURU5DRShvbmx5IHBtZW0gY2FuDQo+PiByZWdpc3Rl
ciB0aGlzIGFjY2VzcyBmbGFnKSBjYW4gcmVhY2ggaGVyZS4NCj4gWWVzLCB0aGF0IGlzIHdoYXQg
SSBtZWFuLA0KDQpJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSAqY2hlY2sqIHlvdSBtZW50
aW9uZWQgYWJvdmUuDQoNCkN1cnJlbnQgY29kZSBqdXN0IGRvc2Ugc29tZXRoaW5nIGxpa2U6DQoN
CmlmICghc2FuaXR5X2NoZWNrKCkpDQogwqDCoMKgIHJldHVybjsNCmlmIChyZXF1ZXN0ZWRfcGx0
ID09IFBFUlNJU1RFTkNFKQ0KIMKgwqDCoCB2YSA9IGlvdmFfdG9fdmEoaW92YSk7DQogwqDCoMKg
IGFyY2hfd2JfY2FjaGVfcG1lbSh2YSwgYnl0ZXMpOw0KIMKgwqDCoCB3bWI7DQplbHNlIGlmIChy
ZXF1ZXN0ZWRfcGx0ID09IEdMT0JBTF9WSVNJQklMSVRZKQ0KIMKgwqDCoCB3bWIoKTsNCg0KDQo+
IHdoeSBkaWQgd2UgbmVlZCB0byBjaGVjayBhbnl0aGluZyB0byBjYWxsDQo+IHRoaXMgQVBJDQpB
cyBhYm92ZSBwc2V1ZG8gY29kZSzCoCBpdCBkaWRuJ3QgKmNoZWNrKiBhbnl0aGluZyBhcyB3aGF0
IHlvdSBzYWlkIGkgdGhpbmsuDQoNCg0KPiAtIGl0IHNob3VsZCB3b3JrIG9uIGFueSBDUFUgbWFw
cGVkIGFkZHJlc3MuDQpPZiBjb3Vyc2UsIGFyY2hfd2JfY2FjaGVfcG1lbSh2YSwgYnl0ZXMpIHdv
cmtzIG9uIENQVSBtYXBwZWQgYWRkcmVzcyBiYWNraW5nIHRvIGJvdGggZGltbSBhbmQgbnZkaW1t
LA0KYnV0IG5vdCBhIGlvdmEgdGhhdCBjb3VsZCByZWZlcnMgdG8gdXNlciBzcGFjZSBhZGRyZXNz
Lg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KPg0KPiBKYXNvbg0K
