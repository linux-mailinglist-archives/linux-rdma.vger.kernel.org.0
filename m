Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91003EE17D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Aug 2021 02:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhHQAz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Aug 2021 20:55:27 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:52633 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232974AbhHQAz0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Aug 2021 20:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629161694; x=1660697694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XqotLTvxXW/AKRQv4p06QShMatKL5VDadD1h49uUi4k=;
  b=UyLYLfpR3NCXcFkDSbZ4644iQ5xDSJYmcYwG3hkjpPce5lBLfZ/oISf4
   z8tV6o0BAOllkziws/Kz2J4acguHOVM12PlEMhF2mfc9PvfahNJP4iINl
   IqofhEyzEcCJBOuLikfbscZB982QoOElabbSgLJM9HD3a2iY2FqQcXl3I
   sfn3bIthLLzktstXs6h8FSXVnU4Pe7V63yviMlk0Duwof9TzKOrExSHv8
   rnExOoBQV7SBl9iDgKu/c51lae5qYZs2CfQCrtl8P7VoyMLYgrJOgTVf1
   Vj83aSIbVHUVLRnY654ykIWlnZLBEh/SczcwZd6+xXXxRHZ9kqZvkx1l2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="36813205"
X-IronPort-AV: E=Sophos;i="5.84,327,1620658800"; 
   d="scan'208";a="36813205"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:54:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9NNL6belpbS/z07d6If4oi+lvaRn7FXSnZADIitP2Wxko44dM38pmqiA82/znjNdqHcGtwO/XUG91kOgJIb7Uy1Zxdi/16xiGvXjS0191m+otqMiVkNBvGFCSAZXN0AfLyw/zm2DZHV/yAHRuZvims2klta24+rm0+T9MTQvBvf2RB3ZBILrwN85mg9tvmg7apC6EHmztgOcLc5gyuALSoUrpClFJaMOcw46/ABFEcEnNw9IngD2cNAt4JOSP8xbrGkJD6KTwgJCreYHKh6v24Xj5nYY4DrB+ZBmL3cznDYW2zOSaZJmU6bZC1eBvzjoRAdnsQuO5yk4FAnXQcYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqotLTvxXW/AKRQv4p06QShMatKL5VDadD1h49uUi4k=;
 b=dZyy5y+ygs1wSXJTabvSk4WPly+jwxwmxOxR1yZSzIdKwreEHIOlMSVgOmT6cuj+OAQ5phwjzvXEO/H828UD2Dp3v3eqlsqRzi1Bi7B/4ZjbNgu/67AMOYLxn5eQl6Ip/c5kfCTYDaYq2s6i9XjiWdXeEAZHckfbv/carvs9/h8LJ7MksgVXyKvpetFsi0mbak93nzrcFERBehVchysV5TKhn/vpqtov+yF3qM7QGh0HRLg3eJG7ngaPlRB5eBtJAa9jGFye2RRu7CyFdB7nasTK1xsULHT/2SuxRNeDBqGtB8PzzS4JaDfC05NoMNqX9ev5nlLJivHaMy0AHa5gJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqotLTvxXW/AKRQv4p06QShMatKL5VDadD1h49uUi4k=;
 b=N1Y1TVujI+DP/8hyS4dt70FoY+gxsPevvGTEnMXhr702fuX1n/N+iyskrutU+Nq5nc9AqbUoddsY4sMr3D+iz7+HPoQrCsji58PPVqxOZbGbdyLBwU2ZRz7drQCfpZB1Dw/4Tw0sH+wh6rZul+FMmYXwXFZ0s8h6Ymt7temzPDQ=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB6021.jpnprd01.prod.outlook.com (2603:1096:604:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 00:54:49 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 00:54:49 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Topic: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Thread-Index: AQHXjSu/7XTFLNlnDk+JDe1qihCp9qtsGJsAgADXggCACNuAAIABHv8A
Date:   Tue, 17 Aug 2021 00:54:49 +0000
Message-ID: <611B08D8.90605@fujitsu.com>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <CAD=hENd6StySon04rW1CPeJbN1KFPDDP1JFsYNBxXNYYegtF5A@mail.gmail.com>
 <6112A9FA.2050300@fujitsu.com>
 <CAD=hENdB6chvVtzgcYunhTNuHDGbYi8=ePnGKhOwuF83HY8O1w@mail.gmail.com>
In-Reply-To: <CAD=hENdB6chvVtzgcYunhTNuHDGbYi8=ePnGKhOwuF83HY8O1w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0d57c09-84b1-43f9-f072-08d961199d73
x-ms-traffictypediagnostic: OS3PR01MB6021:
x-microsoft-antispam-prvs: <OS3PR01MB6021B8B463FD2AE20406A1F483FE9@OS3PR01MB6021.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdq+29NYKnlIjNeJBz6OFY1iFLvIxMlywsIWQ3JLQ25ZtHaK2ydD55GPD4fBcHfC5eZScqtDgMeiI75/NPKkzpXY9iKZHG8A1vVDOqYPyt42IRlxLInzpWZcGmLhVXURpDZ1UM243dmvpBETUQsb8KnixUhSFfGxD9HoKMa7PNOZPJsf9h51J9rPSe2Gv57qg6GR+Kl/X04nqqJKuE5h4HI4Ax9iu0yOTcaJ4NjjiikDr1tz5ryjzWsb9yA16sKCmFt9LrkmFAydFx0Jzu0LctitysvAQL2WDamq1I/PU17FfHnvZ14Pn3w52Ap0o1+xqNn/LLA2oxiLagUUXs155yXULpaVh8rEYYoleGjXOQMgDHlh4SlDzvlEmrulEYM3gxOt/SwmXwVSi7ChsSOD/0LZoCG9TCRV497uL6uc7ukMX1gtUWqNnHwes+z3zc5ZEQ2YWvy/PhnCNs6r3vNrCnFmxMhBlNSDrv/w+MflS+myXeoiCrBa4kp0lsj1xaHaTfTAq8orOT704WWjX7JgthyeuE+7ooHiboNrWQcs/SAEoQdzirOl+cmwCPiG7OK5YlJEDmAESfTg+rLWzG0JPNm76/Hq5mwf6UAD6mczJIzABDcfnsVXJZbQVfOfr5G/ob+QbQv1XLFpDMmm4uohBSs0bU/yfPpPuK47S83PuwafPUCnpy7aUKSiasjMWkj1h+xdlFV3anNb1Hc11gMkMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(76116006)(53546011)(6506007)(83380400001)(66946007)(91956017)(66446008)(64756008)(66556008)(38070700005)(66476007)(36756003)(86362001)(186003)(8936002)(316002)(71200400001)(33656002)(2906002)(8676002)(2616005)(4326008)(122000001)(6512007)(38100700002)(85182001)(26005)(54906003)(508600001)(6916009)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3duZG1LalVHYjhkTjdDYXZtQkRhLzZSdWQyWU9sZVBubzlzLzkrZW80NTE2?=
 =?utf-8?B?WEMvNk0zYWROMDBoTE8ya2E1MjZQMU1taUtYU0xxS2dNUXdGVjQ1aDBTMVFY?=
 =?utf-8?B?NVZPNG1GS3V1ZFBlUDJ0UStndFovMjdZWjlMNE05dEo1Q1FMYlI4Y0hxUXlX?=
 =?utf-8?B?VEhQd1JQYjAwWThpeG9pekIwWXYxcjlyODA2WmpQdnE4R1lEbXB1cXBVTG5i?=
 =?utf-8?B?dlRLZ2JKTXgyQ1dPOTdBdW41TlFXWGZWT01FNnpEemVLcmN2eEt4L1I4Q2hl?=
 =?utf-8?B?WGRyOGxYSFg4Wkh0cHZRcnpKdldWZTFjUTY5ajhNdURIdE1FdWNscStYc2lq?=
 =?utf-8?B?Y2d5SVpzWWJkSzVLbDRuMmZWaVZNWXJIQ1c0S2xveXVadXkrS25aQ2RodENC?=
 =?utf-8?B?R2VDRGxhSmZXWVBMaU5qaVVOckJSb0F6V0MrODd1Q0FWc2VvMU1SYXhPLzAx?=
 =?utf-8?B?OFQxSVB2alNUYUkzTDBFMWl4THdIMll5NkdJdDgxanpRcThsVWRhTnJlallL?=
 =?utf-8?B?bUgxUkJNS1BkZmVmT1JwTTcrUXFCSURXcUxhUndIU1JKaWgva1REWXJkZ3Np?=
 =?utf-8?B?VWtvek9wWC9URExmUGNHSXlvOXlQaHI4MW8zT2dQRXAzSUl6ZEVqTXp3NmJG?=
 =?utf-8?B?ZVZ6OUN3cldUY2pRUWVzSnFmRFpBSnNFM0tTN0RGckZLOFA2OHltUUFIYThk?=
 =?utf-8?B?UjNUQW9LL2tSWkJVYmh5bDRUOXFKZHVKelh3Z054V0lJQTBjTExjYjF6TjhP?=
 =?utf-8?B?UDVQWnozL0pTNG9PWE9RMy8vV3F5LzMzcGZ2TXRpSGx0L1FxRnIvWG9UaXRO?=
 =?utf-8?B?aEdzTUdzK0pORWNkWmNpdzAwbzhCcjQ1SXRGUVpScTZncFMxNWdnNitEdmxi?=
 =?utf-8?B?dUhsSWs4RjFOcmV6bmlKMUYzaG54N1E1M1laY04rQ1E5Qlk3Q05SaDZkelZR?=
 =?utf-8?B?ZVNtcFRrbjVEdHpnRDZ4ZUo1eUVUd1JyU3VkZHg1UDVPVkVuUm5NT1ZrWWJQ?=
 =?utf-8?B?RzVieGtsc2k0aWFoUkdxSnhSeWVNMG1LSkNNbE9NTnpLTVhvMlhwZ2pQMHh1?=
 =?utf-8?B?YTRLK0lTNmx1VkhQMVJwOVZnMGtrcHk0UlZPdXpzNXFYQkRjUGhEMTk1OUpD?=
 =?utf-8?B?OFB4UkV6VzhRMVR6VnI5c0xyVENVekpHMFI1akZrRnpBeGVjZVIzR2ttcDV3?=
 =?utf-8?B?Q2dkQlkzZHhqYjU1Rjcxc2o3S0FjRFM1eG5saWNxK0ZEVlZZYy8zVkpKWUZa?=
 =?utf-8?B?NC91TkgvYVM2UE1BSUtiMmY1ZVhqQ2k5cHVLWXJRQ09Wd01vUTBGMDRrT3o2?=
 =?utf-8?B?SnJJcGlCSVQ3eXlheXRDdlZTNXBwcnd1RENEenJMTGhUTUVNV3c1QU5ZM0Zl?=
 =?utf-8?B?SGRyV1ROSW12dE1IMzNQSFZSeXZ6SzR3Q1UzNm5rL1Nuc09IZE1mU1hFN0ZW?=
 =?utf-8?B?eHB5YTdXTDAwMVA0YWQzUVhVOWNFTlc5MEN2NVNIUjJTaWMvS2pYQkk4Mjcr?=
 =?utf-8?B?T2tKWlRLZnJDZFVjRTd5bjkxSFVRT2xEZEU3Zmo1dmNOYXI0REEwTy82QWFN?=
 =?utf-8?B?aEFIVXlqTWtQbmo4ZkNvclU5YTNSVlA5bXlnNExiR2tpUDNrbURDbVZhRmph?=
 =?utf-8?B?K2psZlkzcXBwMHBNeUwyeDlWQW5jNUg5RVYwTk1rVHQyTkt6amRZSjdUK3ln?=
 =?utf-8?B?RzRhY3FlbE9JUVZrc0VpTTdwak9JcGpNbndxdGExaEFUNHZ0bHNvemxrVnBQ?=
 =?utf-8?B?eUQ5MEsyZzM3M212M2VBWmhlamlYblB0RlhtcTFlZTJFeWY4K3FSWUZIT2tE?=
 =?utf-8?B?VTdVZlFKQW4vaUwxS2FDQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB7A2C48EDD9744BC9FE82998CE3BB2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d57c09-84b1-43f9-f072-08d961199d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 00:54:49.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ay3isRyb8t/pnuWb4tpQ3JDlcb/Wz04JIZ4e2A5TtNkv+sjiWwaBMEn79toEnTYYY0NRasST7QjtOE+S9tw9VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6021
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzE2IDE1OjQ3LCBaaHUgWWFuanVuIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAxMSwg
MjAyMSBhdCAxMjozMyBBTSB5YW5neC5qeUBmdWppdHN1LmNvbQ0KPiA8eWFuZ3guanlAZnVqaXRz
dS5jb20+ICB3cm90ZToNCj4+IE9uIDIwMjEvOC8xMCAxMTo0MCwgWmh1IFlhbmp1biB3cm90ZToN
Cj4+PiBPbiBNb24sIEF1ZyA5LCAyMDIxIGF0IDEwOjQzIFBNIFhpYW8gWWFuZzx5YW5neC5qeUBm
dWppdHN1LmNvbT4gIHdyb3RlOg0KPj4+PiBSZXNpZCBpbmRpY2F0ZXMgdGhlIHJlc2lkdWFsIGxl
bmd0aCBvZiB0cmFuc21pdHRlZCBieXRlcyBidXQgY3VycmVudA0KPj4+PiByeGUgc2V0cyBpdCB0
byB6ZXJvIGZvciBpbmxpbmUgZGF0YSBhdCB0aGUgYmVnaW5uaW5nLiAgSW4gdGhpcyBjYXNlLA0K
Pj4+PiByZXF1ZXN0IHdpbGwgdHJhbnNtaXQgemVybyBieXRlIHRvIHJlc3BvbmRlciB3cm9uZ2x5
Lg0KPj4+IFdoYXQgYXJlIHRoZSBzeW1wdG9tcyBpZiByZXNpZCBpcyBzZXQgdG8gemVybz8NCj4+
IEhpIFlhbmp1biwNCj4+DQo+PiBZb3UgY2FuIGNvbnN0cnVjdCBjb2RlIGJ5IHRoZSBhdHRhY2hl
ZCBwYXRjaCBhbmQgdGhlbiBydW4NCj4+IHJkbWFfY2xpZW50L3NlcnZlciB0byByZXByb2R1Y2Ug
dGhlIGlzc3VlLg0KPj4NCj4+IElmIHJlc2lkIGlzIHNldCB0byB6ZXJvLCBydW5uaW5nIHJkbWFf
Y2xpZW50L3NlcnZlcjoNCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAj
IC4vcmRtYV9jbGllbnQgLXMgMTAuMTY3LjIyMC45OSAtcCA4NzY1DQo+PiByZG1hX2NsaWVudDog
c3RhcnQNCj4+IHJkbWFfY2xpZW50OiBlbmQgMA0KPj4NCj4+ICMgLi9yZG1hX3NlcnZlciAtcyAx
MC4xNjcuMjIwLjk5IC1wIDg3NjUNCj4+IHJkbWFfc2VydmVyOiBzdGFydA0KPj4gd2MuYnl0ZV9s
ZW4gMCByZWN2X21zZyBiYmJiYmJiYmJiYmJiYmJiDQo+PiByZG1hX3NlcnZlcjogZW5kIDANCj4+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pg0KPj4gcmRtYV9jbGllbnQgc2Vu
ZHMgemVybyBieXRlIGluc3RlYWQgb2YgMTYgYnR5ZXMgdG8gcmRtYV9zZXJ2ZXIuDQo+PiByZG1h
X3NlcnZlciByZWNlaXZlcyB6ZXJvIGJ5dGUgaW5zdGVhZCBvZiAxNiBidHllcyBmcm9tIHJkbWFf
Y2xpZW50Lg0KPj4NCj4+IFBsZWFzZSBhbHNvIHNlZSB0aGUgbG9naWMgYWJvdXQgcmVzaWQgaW4g
a2VybmVsLCBmb3IgZXhhbXBsZToNCj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+PiBpbnQgcnhlX3JlcXVlc3Rlcih2b2lkICphcmcpDQo+PiB7DQo+PiAuLi4NCj4+IHBheWxv
YWQgPSAobWFzayYgIFJYRV9XUklURV9PUl9TRU5EKSA/IHdxZS0+ZG1hLnJlc2lkIDogMDsNCj4+
IC4uLg0KPj4gc2tiID0gaW5pdF9yZXFfcGFja2V0KHFwLCB3cWUsIG9wY29kZSwgcGF5bG9hZCwm
cGt0KTsNCj4+IC4uLg0KPj4gfQ0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+DQo+PiBCZXN0IFJlZ2FyZHMsDQo+PiBYaWFvIFlhbmcNCj4gRm9sbG93IHlvdXIgc3RlcHMg
b24gdGhlIGxhdGVzdCByZG1hLWNvcmUgYW5kIGxpbnV4IHVwc3RyZWFtLA0KPiBtYWtlIHRlc3Rz
IHdpdGggdGhlIGZvbGxvd2luZ3M6DQo+ICINCj4gZGlmZiAtLWdpdCBhL2xpYnJkbWFjbS9leGFt
cGxlcy9yZG1hX2NsaWVudC5jIGIvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFfY2xpZW50LmMNCj4g
aW5kZXggYzI3MDQ3YzUuLjY3MzQ3NTdiIDEwMDY0NA0KPiAtLS0gYS9saWJyZG1hY20vZXhhbXBs
ZXMvcmRtYV9jbGllbnQuYw0KPiArKysgYi9saWJyZG1hY20vZXhhbXBsZXMvcmRtYV9jbGllbnQu
Yw0KPiBAQCAtNTIsNiArNTIsNyBAQCBzdGF0aWMgaW50IHJ1bih2b2lkKQ0KPiAgICAgICAgICBz
dHJ1Y3QgaWJ2X3djIHdjOw0KPiAgICAgICAgICBpbnQgcmV0Ow0KPg0KPiArICAgICAgIG1lbXNl
dChzZW5kX21zZywgJ2EnLCAxNik7DQo+ICAgICAgICAgIG1lbXNldCgmaGludHMsIDAsIHNpemVv
ZiBoaW50cyk7DQo+ICAgICAgICAgIGhpbnRzLmFpX3BvcnRfc3BhY2UgPSBSRE1BX1BTX1RDUDsN
Cj4gICAgICAgICAgcmV0ID0gcmRtYV9nZXRhZGRyaW5mbyhzZXJ2ZXIsIHBvcnQsJmhpbnRzLCZy
ZXMpOw0KPiBkaWZmIC0tZ2l0IGEvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFfc2VydmVyLmMgYi9s
aWJyZG1hY20vZXhhbXBsZXMvcmRtYV9zZXJ2ZXIuYw0KPiBpbmRleCBmOWM3NjZiMi4uYWZhMjA5
OTYgMTAwNjQ0DQo+IC0tLSBhL2xpYnJkbWFjbS9leGFtcGxlcy9yZG1hX3NlcnZlci5jDQo+ICsr
KyBiL2xpYnJkbWFjbS9leGFtcGxlcy9yZG1hX3NlcnZlci5jDQo+IEBAIC0xMzIsNiArMTMyLDcg
QEAgc3RhdGljIGludCBydW4odm9pZCkNCj4gICAgICAgICAgICAgICAgICBnb3RvIG91dF9kaXNj
b25uZWN0Ow0KPiAgICAgICAgICB9DQo+DQo+ICsgICAgICAgcHJpbnRmKCJ3Yy5ieXRlX2xlbiAl
dSByZWN2X21zZyAlc1xuIiwgd2MuYnl0ZV9sZW4sIHJlY3ZfbXNnKTsNCj4gICAgICAgICAgcmV0
ID0gcmRtYV9wb3N0X3NlbmQoaWQsIE5VTEwsIHNlbmRfbXNnLCAxNiwgc2VuZF9tciwgc2VuZF9m
bGFncyk7DQo+ICAgICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgICBwZXJyb3Io
InJkbWFfcG9zdF9zZW5kIik7DQo+ICINCj4gVGhlIGZvbGxvd2luZ3MgYXJlIHJlc3VsdHM6DQo+
DQo+ICMgLi9idWlsZC9iaW4vcmRtYV9zZXJ2ZXIgLXMgMTAuMjM4LjE1NC42MSAtcCA1NDg2Jg0K
PiBbMV0gMTA4MTINCj4gIyByZG1hX3NlcnZlcjogc3RhcnQNCj4NCj4gIyAuL2J1aWxkL2Jpbi9y
ZG1hX2NsaWVudCAtcyAxMC4yMzguMTU0LjYxIC1wIDU0ODYmDQo+IFsyXSAxMDgxNQ0KPiAjIHJk
bWFfY2xpZW50OiBzdGFydA0KPiB3Yy5ieXRlX2xlbiAxNiByZWN2X21zZyBhYWFhYWFhYWFhYWFh
YWFhPC0tLS0tLS0tLS0tLS0taXQgc2VlbXMNCj4gdGhhdCBpbmxpbmUgaXMgMTY/DQo+IHJkbWFf
c2VydmVyOiBlbmQgMA0KPiByZG1hX2NsaWVudDogZW5kIDANCj4gWzFdLSAgRG9uZSAgICAgICAg
ICAgICAgICAgICAgLi9idWlsZC9iaW4vcmRtYV9zZXJ2ZXIgLXMgMTAuMjM4LjE1NC42MSAtcCA1
NDg2DQo+IFsyXSsgIERvbmUgICAgICAgICAgICAgICAgICAgIC4vYnVpbGQvYmluL3JkbWFfY2xp
ZW50IC1zIDEwLjIzOC4xNTQuNjEgLXAgNTQ4Ng0KPg0KPiBXaGF0IGRvZXMgeW91ciBjb21taXQg
Zml4Pw0KSGkgWWFuanVuLA0KDQpZb3UgbWlzc2VkIHRoZSBjaGFuZ2UgdGhhdCBzZXRzIHJlc2lk
IHRvIHplcm8gb24gcHVycG9zZToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KZGlmZiAtLWdpdCBhL3Byb3ZpZGVycy9yeGUv
cnhlLmMgYi9wcm92aWRlcnMvcnhlL3J4ZS5jDQppbmRleCAzYzNlYThiYi4uZWQ1NDc5ZmUgMTAw
NjQ0DQotLS0gYS9wcm92aWRlcnMvcnhlL3J4ZS5jDQorKysgYi9wcm92aWRlcnMvcnhlL3J4ZS5j
DQpAQCAtMTQ5Miw3ICsxNDkyLDcgQEAgc3RhdGljIGludCBpbml0X3NlbmRfd3FlKHN0cnVjdCBy
eGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3dxICpzcSwNCiAgCQl3cWUtPmlvdmEJPSBpYndyLT53ci5y
ZG1hLnJlbW90ZV9hZGRyOw0KDQogIAl3cWUtPmRtYS5sZW5ndGgJCT0gbGVuZ3RoOw0KLQl3cWUt
PmRtYS5yZXNpZAkJPSBsZW5ndGg7DQorCXdxZS0+ZG1hLnJlc2lkCQk9IDA7DQogIAl3cWUtPmRt
YS5udW1fc2dlCT0gbnVtX3NnZTsNCiAgCXdxZS0+ZG1hLmN1cl9zZ2UJPSAwOw0KICAJd3FlLT5k
bWEuc2dlX29mZnNldAk9IDA7DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk5vdGU6DQpJdCBpcyBhbHNvIG9rIHRvIHJlbW92
ZSAid3FlLT5kbWEucmVzaWQgPSBsZW5ndGgiIGhlcmUgYmVjYXVzZSByZXNpZCBoYXMgDQpiZWVu
IHNldCB0byB6ZXJvIGJlZm9yZS4NCg0KV2l0aCB0aGUgY2hhbmdlLCBydW5uaW5nIHJkbWFfY2xp
ZW50L3NlcnZlciB3aWxsIHNob3cgdGhlIGltcGFjdC4NCg0KSSBkaWRuJ3QgdXNlIG5ldyBBUEko
ZS5nLiBpYnZfd3Jfc2V0X2lubGluZV9kYXRhLCBpYnZfd3Jfc2VuZCkgdG8gY3JlYXRlIA0KYSBu
ZXcgdGVzdA0KYnV0IGl0IGlzIGVub3VnaCB0byBzaG93IHRoZSBpbXBhY3Qgb2YgcmVzaWQgPT0g
MCBieSBkb2luZyBzb21lIGNoYW5nZXMgDQpvbiByeGUgYW5kDQpyZG1hX2NsaWVudC9zZXJ2ZXIu
DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBaaHUgWWFuanVuDQo+DQo+Pj4gVGhhbmtz
DQo+Pj4gWmh1IFlhbmp1bg0KPj4+DQo+Pj4+IFJlc2lkIHNob3VsZCBiZSBzZXQgdG8gdGhlIHRv
dGFsIGxlbmd0aCBvZiB0cmFuc21pdHRlZCBieXRlcyBhdCB0aGUNCj4+Pj4gYmVnaW5uaW5nLg0K
Pj4+Pg0KPj4+PiBOb3RlOg0KPj4+PiBKdXN0IHJlbW92ZSB0aGUgdXNlbGVzcyBzZXR0aW5nIG9m
IHJlc2lkIGluIGluaXRfc2VuZF93cWUoKS4NCj4+Pj4NCj4+Pj4gRml4ZXM6IDFhODk0Y2ExMDEw
NSAoIlByb3ZpZGVycy9yeGU6IEltcGxlbWVudCBpYnZfY3JlYXRlX3FwX2V4IHZlcmIiKQ0KPj4+
PiBGaXhlczogODMzN2RiNWRmMTI1ICgiUHJvdmlkZXJzL3J4ZTogSW1wbGVtZW50IG1lbW9yeSB3
aW5kb3dzIikNCj4+Pj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nPHlhbmd4Lmp5QGZ1aml0c3Uu
Y29tPg0KPj4+PiAtLS0NCj4+Pj4gICBwcm92aWRlcnMvcnhlL3J4ZS5jIHwgNSArKy0tLQ0KPj4+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9wcm92aWRlcnMvcnhlL3J4ZS5jIGIvcHJvdmlkZXJzL3J4ZS9y
eGUuYw0KPj4+PiBpbmRleCAzYzNlYThiYi4uMzUzM2EzMjUgMTAwNjQ0DQo+Pj4+IC0tLSBhL3By
b3ZpZGVycy9yeGUvcnhlLmMNCj4+Pj4gKysrIGIvcHJvdmlkZXJzL3J4ZS9yeGUuYw0KPj4+PiBA
QCAtMTAwNCw3ICsxMDA0LDcgQEAgc3RhdGljIHZvaWQgd3Jfc2V0X2lubGluZV9kYXRhKHN0cnVj
dCBpYnZfcXBfZXggKmlicXAsIHZvaWQgKmFkZHIsDQo+Pj4+DQo+Pj4+ICAgICAgICAgIG1lbWNw
eSh3cWUtPmRtYS5pbmxpbmVfZGF0YSwgYWRkciwgbGVuZ3RoKTsNCj4+Pj4gICAgICAgICAgd3Fl
LT5kbWEubGVuZ3RoID0gbGVuZ3RoOw0KPj4+PiAtICAgICAgIHdxZS0+ZG1hLnJlc2lkID0gMDsN
Cj4+Pj4gKyAgICAgICB3cWUtPmRtYS5yZXNpZCA9IGxlbmd0aDsNCj4+Pj4gICB9DQo+Pj4+DQo+
Pj4+ICAgc3RhdGljIHZvaWQgd3Jfc2V0X2lubGluZV9kYXRhX2xpc3Qoc3RydWN0IGlidl9xcF9l
eCAqaWJxcCwgc2l6ZV90IG51bV9idWYsDQo+Pj4+IEBAIC0xMDM1LDYgKzEwMzUsNyBAQCBzdGF0
aWMgdm9pZCB3cl9zZXRfaW5saW5lX2RhdGFfbGlzdChzdHJ1Y3QgaWJ2X3FwX2V4ICppYnFwLCBz
aXplX3QgbnVtX2J1ZiwNCj4+Pj4gICAgICAgICAgfQ0KPj4+Pg0KPj4+PiAgICAgICAgICB3cWUt
PmRtYS5sZW5ndGggPSB0b3RfbGVuZ3RoOw0KPj4+PiArICAgICAgIHdxZS0+ZG1hLnJlc2lkID0g
dG90X2xlbmd0aDsNCj4+Pj4gICB9DQo+Pj4+DQo+Pj4+ICAgc3RhdGljIHZvaWQgd3Jfc2V0X3Nn
ZShzdHJ1Y3QgaWJ2X3FwX2V4ICppYnFwLCB1aW50MzJfdCBsa2V5LCB1aW50NjRfdCBhZGRyLA0K
Pj4+PiBAQCAtMTQ3Myw4ICsxNDc0LDYgQEAgc3RhdGljIGludCBpbml0X3NlbmRfd3FlKHN0cnVj
dCByeGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3dxICpzcSwNCj4+Pj4gICAgICAgICAgaWYgKGlid3It
PnNlbmRfZmxhZ3MmICBJQlZfU0VORF9JTkxJTkUpIHsNCj4+Pj4gICAgICAgICAgICAgICAgICB1
aW50OF90ICppbmxpbmVfZGF0YSA9IHdxZS0+ZG1hLmlubGluZV9kYXRhOw0KPj4+Pg0KPj4+PiAt
ICAgICAgICAgICAgICAgd3FlLT5kbWEucmVzaWQgPSAwOw0KPj4+PiAtDQo+Pj4+ICAgICAgICAg
ICAgICAgICAgZm9yIChpID0gMDsgaTwgIG51bV9zZ2U7IGkrKykgew0KPj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgbWVtY3B5KGlubGluZV9kYXRhLA0KPj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICh1aW50OF90ICopKGxvbmcpaWJ3ci0+c2dfbGlzdFtpXS5hZGRyLA0K
Pj4+PiAtLQ0KPj4+PiAyLjI1LjENCj4+Pj4NCj4+Pj4NCj4+Pj4NCg==
