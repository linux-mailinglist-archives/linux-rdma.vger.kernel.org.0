Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D335564D7D
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 08:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiGDGBN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 02:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGDGBM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 02:01:12 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B765AB
        for <linux-rdma@vger.kernel.org>; Sun,  3 Jul 2022 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656914472; x=1688450472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pgx26XhWVX/1szP8P3up81NTZQEpH4ZmyViVtqfQ8eY=;
  b=wh6S7Bks5nv9wtWHejfG87Q1tc3Ml9H0QJc2KTTCwADZBuf38XOlZEFI
   VNDNqOh6L/ggkvN33H8LjLNRtcKcOwKkkJ6sUF0qEttlR/7LzIRkBQYAt
   UVGMYCK4hU1Oezc6AEku2lj+FXIcnQN8E+LW5xp2MVThWPztDVonFPfUR
   gKNpNicSbSzQRIKoAkAAX+zpBaM9jR1mYXlc1P51SH2H/IRoKzzptsngP
   iRDDgFHNIfVfhCMfUxjbvjqmWlJaoHXgTdakRsdLVFCkA/NHDlBZZj0wQ
   Pg6e6YXM6tpCM6Nheo5PEvZINHNrLDtSccCEphlmMjP7aejHBU/3xmfrs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="59469711"
X-IronPort-AV: E=Sophos;i="5.92,243,1650898800"; 
   d="scan'208";a="59469711"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:01:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF4Dq+u3LN9gA6DhDfCUSHMHoHpdwCtRqJD0vRTDeKoWJ7DUX/YsFp27L3A5rWd23dxkVoXwAe+0uJNolJ9EwwwPCYXASkUY/fZEQDIevbr/rYXaluaLdo0KCt/tmgxZtm18pDxVFtcRepFSWakSJCXWqwesyxSL0qdI+yRWPBg+NXeTRqXeJ4VqtTZkfNFA+9xk/WyhjtEDd47TOZhkAdj5aYMtPUdGaAEm0Jh7ndqw1ijQeLxA+GYUyvU1l2jsNQbhtUGfX3iNe3R+roF7DOiNeAMgIusEFhr76r26aE6WNbjnA+ek/KhfXhaCjZQ8ZowvyzmC8wLDvFytoYeC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgx26XhWVX/1szP8P3up81NTZQEpH4ZmyViVtqfQ8eY=;
 b=KHt2W23XJ2G0gnWPP9PD77KORtAtB/xdw7ehs0j+x5Sw+u5SeKrXgkdegYQYJ3DxScUWAOhLd1wgFlZkJRDRd+Pq59du+71Yn3k8EcQyzjQqx3IjZAVzXxwwR1iSDq7tqWyoNgSgpIaJoNSI8/BfHOiGtuZM2FAhZgEGmvg+itXqfJY8bkQVcy4mK/R12cvPyI6sB+KunHbhHQ7vDAL4+fFFJT+PfirB9fS7AbgtVh2QnTGGbwMLqhZXh/ZqOS84X6lfqvPAajhgPdP41LqXGLWrAN3o6gDYaDclynhUMj7M1CFDgQNJJN3/Yh6pSlgBoCzcoo/Sn+PDH98zBGCJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgx26XhWVX/1szP8P3up81NTZQEpH4ZmyViVtqfQ8eY=;
 b=Kfizh63dk3fTx4PsBoDI7lQaj2kTNWv0ZuDiGugPvFVOP3kBcyzoHeMyIs89iKbLIQJnXM7eP+kpzhr9JOqlreFfgAtOLC5tiOFRRsEpM0OSynlcoY2bEJlu6MOJh4nyXxsdiB7TgxArfYiId8bYQaZl3i2gYrlhg/YTcpqgY1k=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY1PR01MB1753.jpnprd01.prod.outlook.com (2603:1096:403:1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:00:57 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:00:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Cheng Xu <chengyou@linux.alibaba.com>
Subject: [PATCH v5 3/4] RDMA/rxe: Split qp state for requester and completer
Thread-Topic: [PATCH v5 3/4] RDMA/rxe: Split qp state for requester and
 completer
Thread-Index: AQHYj2tt9y4n+Wr7F0eaR79jUYL1uQ==
Date:   Mon, 4 Jul 2022 06:00:56 +0000
Message-ID: <20220704060806.1622849-4-lizhijian@fujitsu.com>
References: <20220704060806.1622849-1-lizhijian@fujitsu.com>
In-Reply-To: <20220704060806.1622849-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f4077a-6cd2-48e1-041f-08da5d828ffd
x-ms-traffictypediagnostic: TY1PR01MB1753:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtYyxYdVoU2WJGh6qFUsa7a+lA+WfuaROFlYlS5QCy72yoZIQqUixEfo+7Tpg9j9FWbWGZES8YjR/3O8nAXJgDrsrmqlEv+7wRWFB5Ly/SrUdOustTaoFUPkqr3DAlGE6EBVg+Y1hfPzvjgRO1Byr+N/q9YlU0nYDsp90r7IVJtMFDYmcqtEeyoD+dQWLtbSg2OPNncdbJjdUHeBfS/8D1l75RHQ0lq2+n/k5y4nMWF4IvQzVVKqJlzAdCs1+duHqRQ7XBzi16SSMKgfpX6OpUQrASQwc//qFF75wpKOiYV9B267cvNtSJHR1zNfEf5yvZpo5A1FNVjahUdYrtUIICbMl5x+RNj6VIvjqZOn1c9DEkeDiql92jUZXs5Jkcc3T/7baRlf0a9RF6W1yi7w1vuJhTql54kyDclz5DNEu+MtavRZJZrjZsXd6PSan66qsznjYGWZ8ekbBQ8BRK34w00yiYmF3fnGFUfj0QQQhEHPiPZPc7Hi5x5GG9vRRTzcd/6d44qykaJfroLRtqhJgv02B6xRS8V4xUsZSZt1J6NB++qIwHlkUybFsBESVkKiSIQppmN03vy+VFnU9NWMHurEOkOurEeO8wmt8XraVZv8txWMO0ptc+dWYa+e1S4ATWz5NoJKjwegg3GOZ3ZTbmzwiVXSdUR5S2pHl1x6c1zKwapRkIOd1hOt5sk1eoFXoAIl88iQkok5dB0G1ylZL8mcfC09ivnW8S0syscNAyeKxov/h0dn/HW/8oEeDIGtvibiP1y/Y3kNJFATPRy6/GtD1POdbJuR+5+vySNscLrXte5ST687gcML9QsDy8wY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(2616005)(186003)(1076003)(38070700005)(38100700002)(64756008)(36756003)(71200400001)(8676002)(66446008)(316002)(66476007)(66946007)(76116006)(110136005)(66556008)(83380400001)(85182001)(91956017)(4326008)(5660300002)(6512007)(6506007)(478600001)(6486002)(8936002)(82960400001)(122000001)(86362001)(41300700001)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MTdSUXZHd1ZXM2ZsRGxCMnlkNFV0dVBDUzViNWRRS0VmUWVnRGRsZWNCUi80?=
 =?gb2312?B?YzFBbmhpNml1T3RxVERia3o3QVZtSGFsVDhTWGFrQ1Y1SS93ZGVSMGRxSVlz?=
 =?gb2312?B?WHdIYm10aUZ4K0RWeVQxVjE1NHJDaHhMSU1vSjV4NGpJUnBzYTE1NVRST3Ry?=
 =?gb2312?B?c0kycXpycWdKZjZiNUM4UFNzSXEvNGZjL21HZjlSMCtUZG51R09CNDNjNi90?=
 =?gb2312?B?YjlobHRrMTNrWkZtZ1VBdXRFN0tUN0VydG5XNGZJVUFHZlJOT3RBWjVabGtr?=
 =?gb2312?B?NTZhMzRmTTlqZjZEM1gwdmVLZXdtL1IzY1hhb3RhSUJEdzY1dEZzRmpONEV5?=
 =?gb2312?B?TUpWeHFMQkNQV01UV1lXbVNpbW1kUXczMmtHckFFdUhkcmZmK3VPazFkS2h2?=
 =?gb2312?B?QWw1WXdaaWlrVDg2OXl1WlQ1UTZoQldXZ1crcFVBNGRNaXlZZ3NoZ3BjdFRS?=
 =?gb2312?B?MWpXaDVENStxVkxRTG9XVkR1eGY3TTYxdzR6MEt6cmFwVDlvNnNMOHROY3Y1?=
 =?gb2312?B?WG5xc1phbEtRQTRHcEduSDlaSHlwQmxPeCsvZ1VKVkRnTktMUG9XN2hRaHlO?=
 =?gb2312?B?dWVhRDhYQzhidkY1TnpoMDVsQTRraXNXa1libTc4TU1TSUJZMmROYzhQVWRw?=
 =?gb2312?B?Vlo2Y0VEMVdVd3h2NUEzcmVjanNiZFMvQkhwVG81ZFFPQ1l6K0F6TE83Y3lY?=
 =?gb2312?B?eXUvVG1RK3NyZUZOTjZwYjd4V3FwWkNHM0I3Uy9TSWhpWXhyTDROYTBLbTRo?=
 =?gb2312?B?dGN3MEtuc053aGNhUGw1YnJIYWc0dW9jZUlaM2tXM3pzOEN3NkZKSjc1OEFy?=
 =?gb2312?B?WDdCVmc1eThGb0xXcHRONEZQMktPK3ROckYxT0IvNzVCR2tTdUIrSkhjWUhj?=
 =?gb2312?B?bk9DdWxzNkcwekdkbXBlUTYxWFg0dXZCeDVXRXY4SHlJSXBmZGdKdkErNGFO?=
 =?gb2312?B?cmFLU2szWVBqckViSUlnbDVRZm5YVzcyUjJiRFVoemhFTU80aFBJSm5VUW4w?=
 =?gb2312?B?eVRqRTQvNUdLM1pqZFNPRlNtVXFCRk1nM21TYjkxSW1vRytxVExuNnhLREJa?=
 =?gb2312?B?TVFCUm9rZHI0bm5LRlRYbkpXbXNkNjFFRFF4aHhHODRYNThLTTBiSkdEbHNJ?=
 =?gb2312?B?NW5QbXVqU0czR3dnWHlaTmtVZzVPMXJJZkxpN3ppYUF6aWFuUDV2bStnMlRt?=
 =?gb2312?B?bjBWUHcySTlLNHFacTBKOTBBS0Y4TVdkdzE1dFpPdzA0a1U0TDludFB3Y3lZ?=
 =?gb2312?B?UUhmbndHK01tNzZnaXNRNHVLVVFpZ09QWDZRU1p0UTZJQWhXanZSVk1FcVh1?=
 =?gb2312?B?UGpUaHBTaWh1S2dkWllRaFdzVFRVNDRaUU5TVFhGQk5vZDM4YXllQzN0VUd2?=
 =?gb2312?B?dVliR1dDY3Y5UXZ4NGxieVB1Yy81MGNtc0lZc3N0RU5YTC9aL0pWRzdpZ05J?=
 =?gb2312?B?TVN0VHhuMGVobXJpblAwb1FxU24vekZDY2tzWU1oRzVTcTdvdVFLTkxsNVVk?=
 =?gb2312?B?NmZBRnFmZkN0YzNOanBTN0RzRTlWUG5pL2JpMTlQT2dXRmExQ2pPNWhYSHNs?=
 =?gb2312?B?bFZlWVBQMnRjVldmdHdvMzJiZDZYVTdCazZwS1RTay9HZHVKWndRdThkTFg2?=
 =?gb2312?B?a043cXgvanZaNkcvYnY5MngvUHRnNVlrY2xHOTNLRElDWk9PTGt6L2hia3dB?=
 =?gb2312?B?WDlvWGRkTGVURFEzY1J4eE1JMEU2VGlIVlVlQ2VYRnhSNGFYU1pNTm5qd01E?=
 =?gb2312?B?MU5wMWFEWlhWak1ocFNQVElkRlpHZEZYRGUwVENWK1E0bDQ3TmpQT2lLTW9S?=
 =?gb2312?B?dTd4bEdIVHowNmRmYlhhSzJhM2xnMkRPejNLSE9PcDkyK1lmZVFGVU45bVc3?=
 =?gb2312?B?Y3JWcHdHa1UwZllDbGZJWWV1Ym9rR0JuZUJoSGQzdm9PSG4zandkM1ZSU3Fp?=
 =?gb2312?B?UnROaWpVU2tQT1lUeFRRUkhmUUFJMmhDVTdGME1hZ2VnZ3BzOSt3eW1OTGk3?=
 =?gb2312?B?SUxYTHBMRk03bnQyTGF3SnhtOUdZckdxVnQxODRpMGxmYkd6bCtwZkY4SE5s?=
 =?gb2312?B?bnhtWUhmcjVjemUwZnI2eHYwb0xjZXRTMUczQlZEMElwZklDTHVUSTJCaFhD?=
 =?gb2312?B?VDhTck5mT044MnJRV0V4WG8rT0FqQVpmS01zWklqNE50bStNMlJENTFONUhk?=
 =?gb2312?B?eHc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f4077a-6cd2-48e1-041f-08da5d828ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:00:56.8889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UO5DAOx729DHw0tBmKb6HBe6yjZ96i1pPuWpI4q0PLK3cxR+nW8MKXoDbLrxDlzKYkcmMBwwbGfGGJ5U79mdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RnJvbTogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCg0KQ3VycmVudGx5IHRo
ZSByZXF1ZXN0ZXIgY2FuIGNvbnRpbnVlIHRvIHByb2Nlc3Mgc2VuZCB3cWVzIGFmdGVyDQphbiBs
b2NhbCBxcCBvcGVyYXRpb24gZXJyb3IgaXMgZGV0ZWN0ZWQgYmVjYXVzZSB0aGUgc2V0dGluZyBv
Zg0KdGhlIHFwIHN0YXRlIHRvIHRoZSBlcnJvciBzdGF0ZSBpcyBkZWZlcnJlZCB1bnRpbCBsYXRl
ci4gVGhpcw0KcGF0Y2ggc3BsaXRzIHRoZSBxcCBzdGF0ZSBmb3IgdGhlIGNvbXBsZXRlciBhbmQg
cmVxdWVzdGVyIGludG8NCnR3byBzZXBhcmF0ZSBzdGF0ZXMgYW5kIHNldHMgcXAtPnJlcS5zdGF0
ZSA9IFFQX1NUQVRFX0VSUk9SIGFzDQpzb29uIGFzIHRoZSBlcnJvciBpcyBkZXRlY3RlZCBiZWZv
cmUgYW5vdGhlciB3cWUgY2FuIGJlIGV4ZWN1dGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBCb2IgUGVh
cnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0KLS0tDQpWNDogbmV3IHBhdGNoDQotLS0NCiBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9jb21wLmMgIHwgNiArKystLS0NCiBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jICAgIHwgNSArKysrKw0KIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3JlcS5jICAgfCAxICsNCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV92ZXJicy5oIHwgMSArDQogNCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfY29tcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jDQppbmRleCBk
YTNhMzk4MDUzYjguLjBiNjg2MzBhM2U0OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX2NvbXAuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
Y29tcC5jDQpAQCAtNTY1LDEwICs1NjUsMTAgQEAgaW50IHJ4ZV9jb21wbGV0ZXIodm9pZCAqYXJn
KQ0KIAlpZiAoIXJ4ZV9nZXQocXApKQ0KIAkJcmV0dXJuIC1FQUdBSU47DQogDQotCWlmICghcXAt
PnZhbGlkIHx8IHFwLT5yZXEuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IgfHwNCi0JICAgIHFwLT5y
ZXEuc3RhdGUgPT0gUVBfU1RBVEVfUkVTRVQpIHsNCisJaWYgKCFxcC0+dmFsaWQgfHwgcXAtPmNv
bXAuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IgfHwNCisJICAgIHFwLT5jb21wLnN0YXRlID09IFFQ
X1NUQVRFX1JFU0VUKSB7DQogCQlyeGVfZHJhaW5fcmVzcF9wa3RzKHFwLCBxcC0+dmFsaWQgJiYN
Ci0JCQkJICAgIHFwLT5yZXEuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IpOw0KKwkJCQkgICAgcXAt
PmNvbXAuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IpOw0KIAkJcmV0ID0gLUVBR0FJTjsNCiAJCWdv
dG8gZG9uZTsNCiAJfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3FwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jDQppbmRleCAyMmU5Yjg1
MzQ0YzMuLmE5NWQzYjQ5YWUyMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3FwLmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMNCkBA
IC0yMzAsNiArMjMwLDcgQEAgc3RhdGljIGludCByeGVfcXBfaW5pdF9yZXEoc3RydWN0IHJ4ZV9k
ZXYgKnJ4ZSwgc3RydWN0IHJ4ZV9xcCAqcXAsDQogCQkJCQkgICAgICAgUVVFVUVfVFlQRV9GUk9N
X0NMSUVOVCk7DQogDQogCXFwLT5yZXEuc3RhdGUJCT0gUVBfU1RBVEVfUkVTRVQ7DQorCXFwLT5j
b21wLnN0YXRlCQk9IFFQX1NUQVRFX1JFU0VUOw0KIAlxcC0+cmVxLm9wY29kZQkJPSAtMTsNCiAJ
cXAtPmNvbXAub3Bjb2RlCQk9IC0xOw0KIA0KQEAgLTQ5MCw2ICs0OTEsNyBAQCBzdGF0aWMgdm9p
ZCByeGVfcXBfcmVzZXQoc3RydWN0IHJ4ZV9xcCAqcXApDQogDQogCS8qIG1vdmUgcXAgdG8gdGhl
IHJlc2V0IHN0YXRlICovDQogCXFwLT5yZXEuc3RhdGUgPSBRUF9TVEFURV9SRVNFVDsNCisJcXAt
PmNvbXAuc3RhdGUgPSBRUF9TVEFURV9SRVNFVDsNCiAJcXAtPnJlc3Auc3RhdGUgPSBRUF9TVEFU
RV9SRVNFVDsNCiANCiAJLyogbGV0IHN0YXRlIG1hY2hpbmVzIHJlc2V0IHRoZW1zZWx2ZXMgZHJh
aW4gd29yayBhbmQgcGFja2V0IHF1ZXVlcw0KQEAgLTU1Miw2ICs1NTQsNyBAQCB2b2lkIHJ4ZV9x
cF9lcnJvcihzdHJ1Y3QgcnhlX3FwICpxcCkNCiB7DQogCXFwLT5yZXEuc3RhdGUgPSBRUF9TVEFU
RV9FUlJPUjsNCiAJcXAtPnJlc3Auc3RhdGUgPSBRUF9TVEFURV9FUlJPUjsNCisJcXAtPmNvbXAu
c3RhdGUgPSBRUF9TVEFURV9FUlJPUjsNCiAJcXAtPmF0dHIucXBfc3RhdGUgPSBJQl9RUFNfRVJS
Ow0KIA0KIAkvKiBkcmFpbiB3b3JrIGFuZCBwYWNrZXQgcXVldWVzICovDQpAQCAtNjg5LDYgKzY5
Miw3IEBAIGludCByeGVfcXBfZnJvbV9hdHRyKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgaWJf
cXBfYXR0ciAqYXR0ciwgaW50IG1hc2ssDQogCQkJcHJfZGVidWcoInFwIyVkIHN0YXRlIC0+IElO
SVRcbiIsIHFwX251bShxcCkpOw0KIAkJCXFwLT5yZXEuc3RhdGUgPSBRUF9TVEFURV9JTklUOw0K
IAkJCXFwLT5yZXNwLnN0YXRlID0gUVBfU1RBVEVfSU5JVDsNCisJCQlxcC0+Y29tcC5zdGF0ZSA9
IFFQX1NUQVRFX0lOSVQ7DQogCQkJYnJlYWs7DQogDQogCQljYXNlIElCX1FQU19SVFI6DQpAQCAt
Njk5LDYgKzcwMyw3IEBAIGludCByeGVfcXBfZnJvbV9hdHRyKHN0cnVjdCByeGVfcXAgKnFwLCBz
dHJ1Y3QgaWJfcXBfYXR0ciAqYXR0ciwgaW50IG1hc2ssDQogCQljYXNlIElCX1FQU19SVFM6DQog
CQkJcHJfZGVidWcoInFwIyVkIHN0YXRlIC0+IFJUU1xuIiwgcXBfbnVtKHFwKSk7DQogCQkJcXAt
PnJlcS5zdGF0ZSA9IFFQX1NUQVRFX1JFQURZOw0KKwkJCXFwLT5jb21wLnN0YXRlID0gUVBfU1RB
VEVfUkVBRFk7DQogCQkJYnJlYWs7DQogDQogCQljYXNlIElCX1FQU19TUUQ6DQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9yZXEuYw0KaW5kZXggNmQyNzQyOTk3ZTFiLi5hZDI1MjkwZTM5M2QgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCkBAIC03NzMsNiArNzczLDcgQEAgaW50
IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KIAkvKiB1cGRhdGUgd3FlX2luZGV4IGZvciBlYWNo
IHdxZSBjb21wbGV0aW9uICovDQogCXFwLT5yZXEud3FlX2luZGV4ID0gcXVldWVfbmV4dF9pbmRl
eChxcC0+c3EucXVldWUsIHFwLT5yZXEud3FlX2luZGV4KTsNCiAJd3FlLT5zdGF0ZSA9IHdxZV9z
dGF0ZV9lcnJvcjsNCisJcXAtPnJlcS5zdGF0ZSA9IFFQX1NUQVRFX0VSUk9SOw0KIAlfX3J4ZV9k
b190YXNrKCZxcC0+Y29tcC50YXNrKTsNCiANCiBleGl0Og0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV92ZXJicy5oDQppbmRleCBhYzQ2NGU2OGM5MjMuLmJiZmZmZTI0M2ZkNiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgNCisrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmgNCkBAIC0xMjksNiArMTI5LDcgQEAgc3RydWN0
IHJ4ZV9yZXFfaW5mbyB7DQogfTsNCiANCiBzdHJ1Y3QgcnhlX2NvbXBfaW5mbyB7DQorCWVudW0g
cnhlX3FwX3N0YXRlCXN0YXRlOw0KIAl1MzIJCQlwc247DQogCWludAkJCW9wY29kZTsNCiAJaW50
CQkJdGltZW91dDsNCi0tIA0KMi4zMS4xDQo=
