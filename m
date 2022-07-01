Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F8D562B42
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 08:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiGAGK3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Jul 2022 02:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiGAGK2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Jul 2022 02:10:28 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F4A1A83D
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656655827; x=1688191827;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=xLIpJZxZHpDAPGCWRK2e/Tzy5c7Q5EzbcG7vF1Yi2y0=;
  b=WpUBfWfjpyr4Z6qZJoLlLIPMQszSwRHr40g7vmImK7kUgIPmcIdVWSF0
   WyW5BQkbtXsz5jUS54lOZYkl7jRz9e/YHLXwr6ukL8h2+MH1OO93fSbeP
   2Y4HWPIqn+QWY18Fyf/v/YQcM6gKVDEiHJw39zGaPHQ0UhUGEdGE+2bTG
   kO0LRvXfNd1F42qYfbOkmP6Uf+4ZAQrnsX4IIEn03ZQepm9mdP1CjA/Xk
   aMf3fg3S4CKZ65WfMgDgfWyULV2BC91jwX32N/bm1AEYEF7/gPgwkGiVj
   PtqGRE80HRwVvBQxe46aR8knQnXRP9Y5VA1uL4+7yHLAaaqwpNX0NYEzJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="59519661"
X-IronPort-AV: E=Sophos;i="5.92,236,1650898800"; 
   d="scan'208";a="59519661"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 15:10:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkExqr0YTG7jEhrh9ezZYRjUSyvqzu7vwoB3oI6pMnKziMva+ZWNqb2PmOM5ceYOWJZ49ddDv4RzumFu/mNExsNvUA3mhk9MJ3F9LgUYmX+hlHgHPwFeEoUWXcyHySo7SeWWzvsJif+Lr0EKAoH74DP7uvx5XzJU+zMw8eOZ8aPaosMn77lNzffasmE45ZCFgNk0aUmqhLXETHPL0brrfeAI4p9UdNRunZlKukNpx5UuxNjpAH32vmCUsyNDkzRg80UffpwO4547skfOhPi9oPCx1obEVU/0D6czforxZEHnCGY1fFUJWFbu6NqxhEN+1I27XepZiMi+R/ddt3VJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLIpJZxZHpDAPGCWRK2e/Tzy5c7Q5EzbcG7vF1Yi2y0=;
 b=YbFNBjcy8UfrowqW70xmIHOLTLpweKwqiG92/Ju9NXa8fxW+o5ve7MPIoXclJpzSBZ3WeM0kiWBgmNtOqA9RQ1WdrpVrdhdIyCjDu95eUJmMLtc6SK3XYdtNRRUlgTtfxG3EJx2pm25wHRx5YHZ9sUPixDPdFYs2s44qzkHto1IwkDFjBXDKsAlH8RXBo/d4n1Z1zrhrkJq4BiTxMajymdvqeIwhD00G9QUDDD1C6n1ElGqCXB1n/C3p78iqiENzc9WpY4G9QjtovjfXp2ANPm4gE3ACycc2vHQsyN0a5/X1VTKKKFv4OpYkMqKRNkFGVlKz05/Cbxih135DyLxOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLIpJZxZHpDAPGCWRK2e/Tzy5c7Q5EzbcG7vF1Yi2y0=;
 b=o7abGmws+lWkiD2wMTo2mPJxxlk8VR/dZJzuUsutwws8MjapU3z4PYQapYQKyM9ukCbyjE4hNfxQcTlijMdpWEXekYQdBpFy4rafX0cDzITIUnnBkc0OLV51Ezj6ymKpV210MJj6RyKtAH9VqYVo2zQ1FrjRwtazXDvGlL76j60=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB6626.jpnprd01.prod.outlook.com (2603:1096:604:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 06:10:20 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 06:10:20 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH v4 0/3] RDMA/rxe: Fix no completion event issue
Thread-Topic: [PATCH v4 0/3] RDMA/rxe: Fix no completion event issue
Thread-Index: AQHYjRE9+VFNFEqc1ka0ZuIEnP5w+w==
Date:   Fri, 1 Jul 2022 06:10:19 +0000
Message-ID: <20220701061731.1582399-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a40ca21-8e9b-4aa0-3f2b-08da5b2860d5
x-ms-traffictypediagnostic: OS3PR01MB6626:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfKXV2arAYQ2hmLJeCiBhoSUsTt2JSpk6IIRbcAwK1IsX+V1Owq0zNbQYCoEs26Rn+rXeUh6+QzErJsyym+CunW9NUzxT4kRrl1nr/Ynfv1RA8PXQ9XEwIucZGyJ4ODcShRYD88dtjwy+xwPqysTWmgmAUA4wBiug0sLx4WZ+Vt5dWlZi2DqHmADO5jI/phz4y2oxnn84rvhjkBrs660DcCn1CM1eQCnJPSj+9Wv97x30qnuixV1VGttq8F2CqAeICzvaPEynwu1l+bFMyxvonsgGKgza3RLlMEpk4Lhj0IiYcS22NqeEUrN1t0OKahy5+GuKZAKP/wW7YStq7Ccdu3ssOTYElvWsMdOZ50ihUhZprS+Qxw5j+EjUaZRw2YUl20ASLmwgV26TzT73qfoDYef/vGBu0wAEwZR1y9GpjNZOaq+DqsvxjaOEoSHlpj/WuUJ++ikvRu7/457nLlRatUmZOOccE9yGh5u6vpUMwx1UiPBF/4gCggPKdYBvX0SbL21f+VPPS+iBCc+ugDtVSR0VJvdo8Ajs2j2HaD2u60l22yCAIj3v2lZOye/2X3MmG+XAc4XM2IMhyosqZP3NBDohjGzNH4wZMBqTy6T258wufHz2059NQB7O/ZKM9FmrwA+R3mDTyM2sSYUGU3IXG6Lw0L1AXSkPaHuQlXfIOQbamYTSpERO/1ghsKjejXtK+3tZsjwzFn9uUIT0Polrl4iDy0X6Bb3atS3Ivqpf62oEJsvgVWV81IhvGx0g7WBg9jgIDh/Vmqk2dRZUOEmtrJnVr4lM4SjmrafXEgzvsUc/erC8GTuDbWwcdWJJ4aD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(5660300002)(36756003)(4326008)(64756008)(110136005)(8676002)(122000001)(8936002)(2906002)(38070700005)(66446008)(91956017)(186003)(41300700001)(83380400001)(85182001)(66476007)(316002)(76116006)(66946007)(6486002)(71200400001)(66556008)(82960400001)(38100700002)(478600001)(107886003)(86362001)(4744005)(1076003)(6512007)(26005)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SVJtbHVNMmdUR2pQdHFuQXB0bUo2Z0RETTVtbHMwbTBWTFFYRG5nK1J5OC9p?=
 =?gb2312?B?dzZwZGRCS2FvdTdXbEJoTFNCLzB3eUI4RWh2WTN1MkdqbjJ1TWtMNDEzVnYw?=
 =?gb2312?B?MEpZTDN4cDBLUXo3QWx5WmkvWmNYWndVdSsxL09Qa01LWUppOU9PbmpnRnJq?=
 =?gb2312?B?WHJWUW5SVzRHZmFaeXlWclpIL0gyYUx3WFlUREZucmtrVnZPN2VmTzBFd3B6?=
 =?gb2312?B?Z3J4Y0RFWkx3d3RUR1lvSXAvaW9Kd240dlhJeFM4QitoaWdOUTVma2g3cENW?=
 =?gb2312?B?R3RSWWg3Rm0yVldlUWZNbHBqSVZpUFE5YWMrUm9ncTdYSzMyd0dkOTVrQ3Mx?=
 =?gb2312?B?UkdiZ2lPVmQ3aEFtbHFiRTUzV3M2WmhlTUVJOHEwbHczYWx5eFgxa1dpKy9H?=
 =?gb2312?B?dmVELzhYeEJSVTZ0WnArWUVtNC9sQ044Z1ZIUXhESXVtT1VvQ0psVDZiampv?=
 =?gb2312?B?b1U4UDVHckNsNTFSYVU4R2JpRnMrblRnMDIwTUpkMHZpSTZWbVlvcU9HeFV2?=
 =?gb2312?B?M3Fxd1J0M3lYNVA1dGNPVDFpd3plZUhVdElDNmQ4M3dCTlFndmdnR29CSVMz?=
 =?gb2312?B?bXM3M21MZGhoS1lkZTJ4aEcybmNROUlsTFBqQ0xmTVo2dmgvQzRNcDBEQmk3?=
 =?gb2312?B?clhDUEZXcVBYK3I1ZzBpSUMyRkhsbmUrUGYwR0lWcjRrMm1mbWlaQkYxbC9p?=
 =?gb2312?B?dFZEckpjeTlkOEw3ZTVhazd2T1JWYjZrdW5BZkRMVUxoVk9oVWtjTFltNE04?=
 =?gb2312?B?aU1kSTFiSi9qOW5zYlBGUTBvTHN0dFBEVHpBRW5mRnkzemIrVnhpT3Z6OHNU?=
 =?gb2312?B?WVVOVEJPd0lUTWxzL0p2c25pMm1mQllQVkJGSzI0UXhwdDlUbzUvRWtBL3Vz?=
 =?gb2312?B?SmRxNGxCT25XLy9JL1R0ZnJQZndDZWlMQWdES1VDVEk0bzZCcjljWi9iTE1w?=
 =?gb2312?B?cDBFWDFHd2xQV3VOYVViZXJDakw4ckhIYlZaNWp3TWJrbi9tSmRzU2xuYXF6?=
 =?gb2312?B?Y2dnQUF5Yi9RYkFnempqQnVrRGtlYmtneWpOYncvSjZMcDAyVHFRQW5ZaUd4?=
 =?gb2312?B?NytWWnJXYnVQWjc0dFkzRlVlR2xVOW9oSEZVajc2SXpDcEZPMXhkOXZJazBm?=
 =?gb2312?B?U1pTRVo3WTYrUURiU3lFN2FkSGVKZEFjcE5xZ29PaFY4Yk1iNFA1Mnp5SHZR?=
 =?gb2312?B?ZGhIR01HeHUwc1g2bE1nOWsrYVNwSzRLT1FIWVk0MFZpR2syZTViM2NRL2hl?=
 =?gb2312?B?YmV1d2xTSzBZS2QvUWd5R29jV0dGWTNtSitlS01odGNiazNBQ1EwUjN0aVZL?=
 =?gb2312?B?bXNyNGwydFhCNU9NNURyYzhQVmNDQjk1WlRaWnQrZWUveXU0ejhjQnRSaUU0?=
 =?gb2312?B?RmhBdlhyN2FaUWNFN2U5N1BHQ3dyNndCRnh6WXFiMHJCMldHNCtkcXF3ZUJu?=
 =?gb2312?B?YkJFUjJocWVZOEUyK216MkJzdUQzNGI1K041TGNWdkk0WjFhaVI4QnhSOVR6?=
 =?gb2312?B?M0lCZ1pGZUpFS3ZkaFAxZjJRS3ZjcGRpQml6RXJUT1M0QVVjdi9WcmlWWHRD?=
 =?gb2312?B?WHNsa2pRQUVRUnJXeElybG1POWFncVZURmsrdm5URXhGZkZ3eVlTc2V4MDBZ?=
 =?gb2312?B?U2hNUUdKYUxkdG02TEw5QU9WMmJRb1oyenZDRVRaazFwT1F0Ri9JamtZVU1R?=
 =?gb2312?B?MU0zV2hvL1UxVGpMS2dJMnpKZ0F6dWlOTnkwbEF3NFU3MXdtS3ROMFpYZkdh?=
 =?gb2312?B?UXk2L0J6NmRGMTMyYW95YTlVeUtRZWNhcTc0VS82QkRPWXZTa3pBbFh5OFVh?=
 =?gb2312?B?R0tjdy8vOWxVbm5hNXBQZyt3WmtIQnF3QWpQUVJmT09QQW5jQlpsMXJJeG1G?=
 =?gb2312?B?TVdPTDRyd05lQmJYNmorMG8yMjdNRE1uSkpvOGFXZjc3azNLN2pIZjRaZGhy?=
 =?gb2312?B?M2hXL1d6Vjk0eFJEaUNmMDNJNDVqdTB3SXNLdDVuT0FoY21JVGVvZFpEbUxr?=
 =?gb2312?B?SW1RTEZhQjFqUFp4dlRPN3BZOUdMcFlaWGt4ek5YSjM3djBWSTVqbFBIRHJB?=
 =?gb2312?B?TU1HVFFUYWJSUWxUeDhNT2toSXRiWnpiVm5PY3VxVVdWNllOcHcrdmpOY2VW?=
 =?gb2312?B?Q05qcVc4SEhRU0xHVXdldjFqVDZkQkVVSWFEUm9DSnVvRzNZSmJzZGYxWFRj?=
 =?gb2312?B?cWc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a40ca21-8e9b-4aa0-3f2b-08da5b2860d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 06:10:20.7129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09m/+k+IL5BLFsUPYnHzCG6neHKlPbRipNYxbYQ50V5fv5gPFyTyjqerkhl2Vo2KU3pRnzWIOGXVqsayRa/WBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6626
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SXQncyBvYnNlcnZlZCB0aGF0IG5vIG1vcmUgY29tcGxldGlvbiBvY2N1cnMgYWZ0ZXIgYSBmZXcg
aW5jb3JyZWN0IHBvc3RzLg0KQWN0dWFsbHksIGl0IHdpbGwgYmxvY2sgdGhlIHBvbGxpbmcuIHdl
IGNhbiBlYXNpbHkgcmVwcm9kdWNlIGl0IGJ5IHRoZSBiZWxvdw0KcGF0dGVybi4NCg0KYS4gcG9z
dCBjb3JyZWN0IFJETUFfV1JJVEUNCmIuIHBvbGwgY29tcGxldGlvbiBldmVudA0Kd2hpbGUgdHJ1
ZSB7DQogIGMuIHBvc3QgaW5jb3JyZWN0IFJETUFfV1JJVEUod3JvbmcgcmtleSBmb3IgZXhhbXBs
ZSkNCiAgZC4gcG9sbCBjb21wbGV0aW9uIGV2ZW50IDw8PDwgYmxvY2sgYWZ0ZXIgMiBpbmNvcnJl
Y3QgUkRNQV9XUklURSBwb3N0cw0KfQ0KDQpWNCBhZGQgbmV3IHBhdGNoIGZyb20gQm9iIHdoZXJl
IGl0IG1ha2UgcmVxdWVzdGVyIHN0b3AgZXhlY3V0aW5nIHFwDQpvcGVyYXRpb24gYXMgc29vbiBh
cyBwb3NzaWJsZS4NCg0KQm90aCBibGt0ZXN0cyBhbmQgcHl2ZXJicyB0ZXN0cyBhcmUgcGFzc2Vk
IGZpbmUuDQoNCkJvYiBQZWFyc29uICgxKToNCiAgUkRNQS9yeGU6IFNwbGl0IHFwIHN0YXRlIGZv
ciByZXF1ZXN0ZXIgYW5kIGNvbXBsZXRlcg0KDQpMaSBaaGlqaWFuICgyKToNCiAgUkRNQS9yeGU6
IFVwZGF0ZSB3cWVfaW5kZXggZm9yIGVhY2ggd3FlIGVycm9yIGNvbXBsZXRpb24NCiAgUkRNQS9y
eGU6IEdlbmVyYXRlIGVycm9yIGNvbXBsZXRpb24gZm9yIGVycm9yIHJlcXVlc3RlciBRUCBzdGF0
ZQ0KDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jICB8ICA2ICsrKy0tLQ0K
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMgICAgfCAgNSArKysrKw0KIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jICAgfCAxOCArKysrKysrKysrKysrKysrKy0N
CiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oIHwgIDEgKw0KIDQgZmlsZXMg
Y2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjMxLjEN
Cg==
