Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0145EB6FB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiI0Bip (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 21:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiI0Bio (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 21:38:44 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30A647C6
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 18:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664242722; x=1695778722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i0WkuNy3C2JuFyCQTLzTqudFcc2aE5N6ziOc4Fr+AoM=;
  b=HqNu74uVM4Q8xZLcIpEMCZ9ClL8KZ7mS9/RL2llevPrcWCyBRIdX3YOZ
   NIwcBGUN/Y0mxbpAvwXZBAFR4Jkb3troSkS2oIQjM1lI0jl9Mj7nAGVCX
   0o6v4BppPHLQbDxsXaPD3oSHf8fa+gL3ecM2nxo7SsZuPAm3zK3SX4WDk
   AWkMBcYs63uFZBc8IEdwUKiQAV7PrBRUp1NKlAOQBboeLJeG+3tdzdOlx
   +QPs2zLqB/7C1kH3LkHIsyfCXMgu2gkImxh9mjw8JUzOpnbcy0iOfRpfI
   MgeOqY10cKUAWE3XHG7apwyxoZRacGMEaO41e0LooRGDucqz2btHBUMH8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="66465868"
X-IronPort-AV: E=Sophos;i="5.93,347,1654527600"; 
   d="scan'208";a="66465868"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:38:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn/okxCUX0z5DXIFIe823e9Cs/5OCQzXaNH14AzBeUXMP9et6Frfyl7NdYQbxTm7Fk2EwZLRKtAV1gzCmvZHwkUhRz1ht70JTbTMwJhFLsdl5ldHwN5dAVSMoKr9UR93JS5OoL0hEhrlJOfizQc5wzopOSa/X0XqNKzcJ+R4yh+lDwGObp5E2nxgQmtX5sK6FOeH33Tx9cWHPnCYeKtRCNime7MnivF8IJLd1hvZNLTm9CqHMMRwF9hPOrOgl1/ip+ZGZH/8JjXlKTK9mR9Qmwbb7gtDNin85n1V3Te9hPIKwfVz31I3ijhxkZRAEKbLVtaCwOwdspOZuR1UCuMWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0WkuNy3C2JuFyCQTLzTqudFcc2aE5N6ziOc4Fr+AoM=;
 b=HtjhOVNXe/9gvq7uAx+XLGFcq6RJa1VElEKG53R6/uZ6Y21F0DhJB2QI4YS2yNseAf9RVWlxnO1mdIbQHheVfrTpHJPwG0zfIEvemB9mfuN9Y/1RIFjV5FKu2MyXbUWA8xC2h2TPYo+8DsEJHyydmUoVxYQoi9dcNwfPjzPQrMRzFlQGubCFp8C15kAN0HfhMOR7d/aE0o3q5pcQ6t4h92eL/5dEknkNC3bSlZ42ISYsFtyqvr4mc3ZR7o5RrjlNMDFReb1s4CuCpp8d57WUA9FLG2a7RA1PzBWuLW8GMhXAnyRHKT4HK2X8A35BaOI9z6224FF2g3SGbCDZ7JRxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB10822.jpnprd01.prod.outlook.com (2603:1096:400:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 01:38:35 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d51b:780b:2b6c:9c4a]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d51b:780b:2b6c:9c4a%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 01:38:35 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Jason Gunthorpe' <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next 00/13] Implement the xrc transport
Thread-Topic: [PATCH for-next 00/13] Implement the xrc transport
Thread-Index: AQHYykM9ecjzxQckj0W3lkf079lrYK3yZqwAgAAg4fA=
Date:   Tue, 27 Sep 2022 01:38:35 +0000
Message-ID: <TYCPR01MB84557734DE313F81A10D30B1E5559@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
 <YzIyHsRUy4gNeJL8@nvidia.com>
In-Reply-To: <YzIyHsRUy4gNeJL8@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 64563dc3035e4fd3b48052b8e104e538
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMjdUMDE6Mzg6?=
 =?utf-8?B?MzNaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD05MDZlNmYyMC1jNDk1LTQ1MWMt?=
 =?utf-8?B?YWM4Ni03NWI3N2QwZjA5ZjI7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB10822:EE_
x-ms-office365-filtering-correlation-id: 67c1fe02-fbf6-4619-e3fa-08daa028fe92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzxhftOucXenjfE5pW6FI1/wJpIw6ej/arfJhQuDuxYHj6KKtg0/Vp8PvYtyw+REYHoM0kz/PDh9LMl/K/xgqgit86hQcjgiJ9tcNjeZeI3+v9aae8ViVO2XIN61py8S4jifx4UG83xdmX/0nkBKIXqsVlQk06nOENQS2rNs4Ix356ihOs57w8R42/m8L8K90LEBRWdVAgOKQMKMSlr63gHt1kJjANaxiB931lWK9gGOVXE+NC+3z9JRy78Go+SDxXYEx56zozMcM5+JeIccVzCH3GpaLC0Mf6UpAywceD9IuKohJS4ZVaMEp3xupFEqhVU2o51nrZBH00g+AZXuBofSiWj/5JksVVmo8nkm9308s9dZf0Tib2rS8SfcgruAx2tzr1xKziogQdvp7C2lL5YOSVmBvtpcwXySorMzOtSfzUIhdB0ISKgDsxUMh/qaQg7Jicl2lYv2Wxqmp5SDWWBhumkHGxpepYRksrInK6bAe5QzIF1QkHtKvuz/QaZfDaMWKAAonmwtd8/YHeUv8YojbbUb7ujPy3EQifRpV1CvEt2d+aXiL1z67lDXklF2bUdR2sOLou3EBlCOCUEZWvaDXTYpSXd0tlEaWf2+cJXlib74tIXUoxYhBKd6AHK9P8zLzWEnSowWgxMbtw8TVBae0F7wAS2AEjWraF48OrDeki+aUFo/jzBfv1RgWztNX6R5x9lhi53Q4EaI0dhTNUfcs+OkFAh7ii1ZU1wmlShWaLiMQqPmCgVNL0X834MYEFNbNeJuvkoLPefu8QiuGbylIr2gU8SjkpSmy8t/ReFb7yxO59zLcv2ayruwSX3o7AU21Yb8WsouWK46Jb0Y54n2iivXKkJg1yGlzCc1kmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(1590799012)(41300700001)(66446008)(66476007)(66556008)(64756008)(9686003)(66946007)(26005)(4326008)(76116006)(8676002)(38070700005)(186003)(2906002)(86362001)(85182001)(33656002)(8936002)(52536014)(5660300002)(478600001)(966005)(71200400001)(55016003)(7696005)(83380400001)(82960400001)(316002)(53546011)(38100700002)(6506007)(54906003)(122000001)(110136005)(1580799009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JZOXhpL1lYR2x6b203RUlqMXQyRmFvaW8zODN2OHR1bGRVeHhMTStIYkhj?=
 =?utf-8?B?U285djg1T1RlNkZqeFBMelArT0hkR1JVQkxQQzZBZkJqdytIblRqSDEybWdI?=
 =?utf-8?B?bllGL0FiaDl5TXEzS2RIaVd6c2h3dmhMT2s2dzVOdWRHeU0ySTlVSUp2M3Yx?=
 =?utf-8?B?N3FSVVhNR3BGZmw1UUhuUGVGSWIwb3poMnlNTkQrUytqN1MzYnByWXN0K2Rw?=
 =?utf-8?B?K2Q4M2FKS2NmbDRhNkVhUUVHdGVhejYyR2lEU2pZT2YvNDJkTkVKNklUcUEr?=
 =?utf-8?B?S296NE5QSVNWOXZtOXhCQ0ZKQ284ak9VWUVLcDJFMWRVd0F2WlJjdytMbmpQ?=
 =?utf-8?B?WUtCeHA3TGtkY3Nqb1FPVll5YVFuM1FkM2xtd0doSzJ4ZERCWlRGUTkxMW5z?=
 =?utf-8?B?ZlByeFdLWGg2UStubTE5L2FicFpkMjd0bE92ZUN0QmluODZhSkJRMWhKNHJx?=
 =?utf-8?B?ejdaajFpK0hFRzhuQTlIZTYzMEorQks4TVdvZ1A1U0IwcnhNNlpTNFFrVXQr?=
 =?utf-8?B?aWRSU1FBcVR5UjhQNEpDTG5RVHB2QkVWdE14SldOVlJQdmxmWHFtT3ArbnN6?=
 =?utf-8?B?RkZUd2xjOHRxRDhSUHhseUhKbEk5ZnV2UzhrTTIxTE16Vkh4cld0MXFOU1li?=
 =?utf-8?B?a3RicHRYQW94T0lJUkdWWG4vNHJDUnRXdVdKaDV1Mkt6c2NnTFNmQXJlZ1ow?=
 =?utf-8?B?Tjl1MGI3eWEyNFBRUEhrSUlaUmZXMU1wUFh1SEYvSGp5MFF1RWU0R3ZEckZG?=
 =?utf-8?B?eEFubHlTN1lLbEMwNXNvUEY2V3JhTXVBSnRoK3AzMkRkUzdxQ2ZZUnE4M2tD?=
 =?utf-8?B?Y2k2L05adVhMN0Q4MVpYR1A1NUxnSENua2xQWHpZNG9jZmova0h5eXc3NkJT?=
 =?utf-8?B?TStybVNKWExjc1BMWmlYbTFvY21XN0VwNmlkQVJkZnBZSHZVMkR3dFpCN2cr?=
 =?utf-8?B?TUZ3S0tJWVpXZE03WG1UbGpUUUFnMVBucDhSVFIyaUVpTi82YTRQTDhOcGYv?=
 =?utf-8?B?TkM0Y3lpOTRkNlF4NlpCNnZoVXYycTA5UmlZU2ZHc2c2Z2pCNzkyZnRCNDVU?=
 =?utf-8?B?VS90Um0wVjVlelZSSmxZS2ZJNlZxaTl0cmtHMGczRnNJTmVSd2VTUUIxVWxt?=
 =?utf-8?B?MnZjL1dzVHJvemhKMUZjZVBiemdCWXJlVitjVFBIMmRSQWQ1UWh5T1NsNTZj?=
 =?utf-8?B?aHArL1lZWlJLZFA0dzVvUERablRLZTdNVHVod2FsQlUwT0k5OGFmRkZBMnVt?=
 =?utf-8?B?dGZSaitySFkzYlRmM2V4Vm1nMzJ6OE9vMndkaFA3Uks5bC9qR2ppSGFYWjNM?=
 =?utf-8?B?cTlpeHp6Z25yN0FIckdCQnliWFkrVEM4cFVOTDlrMGFTSGdUbE5aTDZFa20y?=
 =?utf-8?B?SmI3cjZwTXUweUorVXlDSElOaEZNWHRMMmpWb1BtTGM0QVZDcmVnMFp5ai92?=
 =?utf-8?B?TjA5L1hNc0Npc3YrK0JvME04a3lKdkQxOFZJVFFXMDUrWE9SWjMxWjhGd3B4?=
 =?utf-8?B?cjFnU1JhUTNJd09PMi9aUlc2ZlY3T09jQWRpUGY4OFd5VUtlMnArUGpaTDNF?=
 =?utf-8?B?UHFlUXRzbU1zSkJSQld3V1ZsZWZuWStPNHN3Skt6TmNBSEJCNjYzZ09zaDNC?=
 =?utf-8?B?VEV0Q2E1WXg3b0FZOHN0elQzYys0azF6QkdRTEFHRzFqTnpBYURBVEFIeERU?=
 =?utf-8?B?THo1T3hWc21WUWJiWXZOZGZqMlVKSkxsK0U4eWxlaURZQlBYNENZdVVjMmYy?=
 =?utf-8?B?cXBmWk1sNnMzdDc5eU9GVS8xalJ4cTFwVm1FZEoxbkpqY2xVZ0JEOXVZRHo5?=
 =?utf-8?B?Z0lZSENodFQzRnNaQ1d1YXdGRDJ5ajhYT0hxL0J5WEdvN3NwRWZoTXRtR1Bk?=
 =?utf-8?B?VXhDWEhVYWVTdzBnclkrQWFEckxVSGxZRm9MbkV6cWlOQzhnTnFmam9mTE9I?=
 =?utf-8?B?aUNNbUhlMEl2ZHZHb2pqa2IyUzc1emJwYWozR3p5UmNlcCsyY2FUaE9RN01G?=
 =?utf-8?B?KzhYa2F3Z21DT3VJR1IzZ1pzNHhCNlRCV1RFVjNlOHIxbElpT3Y5VmtMQnJD?=
 =?utf-8?B?TUkxbXBhK2tOYkx5bEsyQzduR0NDMUgxNC9oMFVRamd3NmhPVVZvM0k3bzJx?=
 =?utf-8?B?K2JmZ1BNanp3N0pnRjk0YnlnWExVU0xSdmk2VU9tT2tNKzUzUUF4c3lQYmNO?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c1fe02-fbf6-4619-e3fa-08daa028fe92
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 01:38:35.6365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5LzZ1fPjzeIgn9ojuzT1E27dBrBh2bE+UXYRQ0uUjPVH99QXtnkF2HcfW9pB6J8r8e/jL4Zll7A5d33rarEriV1hsMmhz/yh9LjyoNzSB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10822
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBTZXAgMjcsIDIwMjIgODoxNCBBTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBP
biBGcmksIFNlcCAxNiwgMjAyMiBhdCAxMDoxMDo1MVBNIC0wNTAwLCBCb2IgUGVhcnNvbiB3cm90
ZToNCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBpbXBsZW1lbnRzIHRoZSB4cmMgdHJhbnNwb3J0IGZv
ciB0aGUgcmRtYV9yeGUgZHJpdmVyLg0KPiA+IEl0IGlzIGJhc2VkIG9uIHRoZSBjdXJyZW50IGZv
ci1uZXh0IGJyYW5jaCBvZiByZG1hLWxpbnV4Lg0KPiA+IFRoZSBmaXJzdCB0d28gcGF0Y2hlcyBp
biB0aGUgc2VyaWVzIGRvIHNvbWUgY2xlYW51cCB3aGljaCBpcyBoZWxwZnVsDQo+ID4gZm9yIHRo
aXMgZWZmb3J0LiBUaGUgcmVtYWluaW5nIHBhdGNoZXMgaW1wbGVtZW50IHRoZSB4cmMgZnVuY3Rp
b25hbGl0eS4NCj4gPiBUaGVyZSBpcyBhIG1hdGNoaW5nIHBhdGNoIHNldCBmb3IgdGhlIHVzZXIg
c3BhY2UgcnhlIHByb3ZpZGVyIGRyaXZlci4NCj4gPiBUaGUgY29tbXVuaWNhdGlvbnMgYmV0d2Vl
biB0aGVzZSBpcyBhY2NvbXBsaXNoZWQgd2l0aG91dCBtYWtpbmcgYW4NCj4gPiBBQkkgY2hhbmdl
IGJ5IHRha2luZyBhZHZhbnRhZ2Ugb2YgdGhlIHNwYWNlIGZyZWVkIHVwIGJ5IGEgcmVjZW50DQo+
ID4gcGF0Y2ggY2FsbGVkICJSZW1vdmUgcmVkdW5kYW50IG51bV9zZ2UgZmllbGRzIiB3aGljaCBp
cyBhIHJlcHJlcXVpc2l0ZQ0KPiA+IGZvciB0aGlzIHBhdGNoIHNlcmllcy4NCj4gPg0KPiA+IFRo
ZSB0d28gcGF0Y2ggc2V0cyBoYXZlIGJlZW4gdGVzdGVkIHdpdGggdGhlIHB5dmVyYnMgcmVncmVz
c2lvbiB0ZXN0DQo+ID4gc3VpdGUgd2l0aCBhbmQgd2l0aG91dCBlYWNoIHNldCBpbnN0YWxsZWQu
IFRoaXMgc2VyaWVzIGVuYWJsZXMgNSBvZg0KPiA+IHRoZSA2IHhyYyB0ZXN0IGNhc2VzIGluIHB5
dmVyYnMuIFRoZSBPRFAgY2FzZSBkb2VzIGlzIGN1cnJlbnRseSBza2lwcGVkDQo+ID4gYnV0IHNo
b3VsZCB3b3JrIG9uY2UgdGhlIE9EUCBwYXRjaCBzZXJpZXMgaXMgYWNjZXB0ZWQuDQo+IA0KPiBU
aGUgT0RQIHBhdGNoIGlzbid0IGV2ZW4gb24gcGF0Y2h3b3JrcyBhbnkgbW9yZSwgc28gaXQgbmVl
ZHMNCj4gcmVzZW5kaW5nLiBJIGNhbid0IHJlbWVtYmVyIHdoeSBpdCBuZWVkZWQgcmVzcGluIG5v
dy4NCg0KVGhlIE9EUCBwYXRjaCBzZXJpZXMgaXMgdGhlIG9uZSBJIHBvc3RlZCBmb3IgcnhlIHRo
aXMgbW9udGg6DQogIFtSRkMgUEFUQ0ggMC83XSBSRE1BL3J4ZTogT24tRGVtYW5kIFBhZ2luZyBv
biBTb2Z0Um9DRQ0KICBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2NvdmVyLjE2NjI0NjE4
OTcuZ2l0Lm1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbS8NCiAgaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJkbWEvbGlzdC8/c2VyaWVzPTY3NDY5OSZzdGF0ZT0l
MkEmYXJjaGl2ZT1ib3RoDQoNCldlIGhhZCBhbiBhcmd1bWVudCBhYm91dCB0aGUgd2F5IHRvIHVz
ZSB3b3JrcXVldWVzIGluc3RlYWQgb2YgdGFza2xldHMuDQpTb21lIHByZWZlciB0byBnZXQgcmlk
IG9mIHRhc2tsZXRzLCBidXQgb3RoZXJzIHByZWZlciBmaW5kaW5nIGEgd2F5IHRvIHN3aXRjaA0K
YmV0d2VlbiB0aGUgYm90dG9tIGhhbHZlcyBmb3IgcGVyZm9ybWFuY2UgcmVhc29ucy4gSSBhbSBj
dXJyZW50bHkgdGFraW5nDQpzb21lIGRhdGEgdG8gY29udGludWUgdGhlIGRpc2N1c3Npb24gd2hp
bGUgd2FpdGluZyBmb3IgQm9iIHRvIHBvc3QgdGhlaXIoSFBFJ3MpDQppbXBsZW1lbnRhdGlvbiB0
aGF0IGVuYWJsZXMgdGhlIHN3aXRjaGluZy4gSSB0aGluayBJIGNhbiByZXNlbmQgdGhlIE9EUCBw
YXRjaGVzDQp3aXRob3V0IGFuIFJGQyB0YWcgb25jZSB3ZSByZWFjaCBhbiBhZ3JlZW1lbnQgb24g
dGhpcyBwb2ludC4NCg0KVGhhbmtzLA0KRGFpc3VrZSBNYXRzdWRhDQoNCj4gDQo+IEknbSBpbmNs
aW5lZCB0byBhcHBseSB0aGlzIHdpdGhvdXQgcmVhbGx5IGxvb2tpbmcgY2xvc2VseSBhdCB0aGUg
cnhlDQo+IGNvZGUuIElmIHNvbWVvbmUgaGFzIG90aGVyIGlkZWFzIHBsZWFzZSBjaGltZSBpbi4g
SXQgbG9va3MgbGlrZSBpdA0KPiBuZWVkcyByZWJhc2luZywgeWVzPw0KPiANCj4gSmFzb24NCg==
