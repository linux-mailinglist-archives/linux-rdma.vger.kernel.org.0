Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9E56B135
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 06:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiGHECo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 00:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiGHECn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 00:02:43 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A674DD6
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 21:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657252963; x=1688788963;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=XZjDyJW2sYfgkPGOnaGu+0Ztu5m7VuZr7SPlasGWH90=;
  b=LTO+SHkR7mP+nHRU/f6WbRVNVLbG633TZ6F7GPOnq9+HDZXNDCvWI1ZZ
   6BrLm761fNrK+J8Rz1Sn2bK6YBBZ5qAFj6nveALDn/DpPoBtXMaFJHJbm
   YDGeVorQGGRHN237NtMAwteo08C9v06yNmsLbic2nO1x/bGsAVOunIhVu
   mnfhie7d3uJrwtOgAG3e+63UiJKBuqJCvs3DIWAnwbdXhH6TpeyDgXFTv
   Q12NkWnRpBAiNppex3tJs/rO/UMlOMfAGergvwRFMwlUN815BcjGWS13S
   y0Zk6Le5xMObTCKbLSh1VKijZYBLDuZ6EFHCtB3ZOGZ57b204n6ddrWj2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59574128"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="59574128"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 13:02:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEaJ1MANsLtXtGpBGn/y+JfCasSGe8wSJYB65j+mjO9Wj0Jog/k3L0auoHHe2PjersRuZNo9k9pkp2XP49j0YeMmL1HOAa0Dhx7d+tzjYGUgMvp5DG+4xs8/9kUp5e77Z89qCbgdjXzWfRYsJ1feu41cLAY527jQr7Xw5JqEaseqG7WGYlJ12B2QUbLFkrfWXB4D+4NCNPE+39bqccogcSTeO7JCpCuqyBAzYt6VFtk62ZnR4dwjodt7s3RG7PvI2UqkuZ+gGbn5Duxa8JAV9hs4OQKVjPG1YWVPqTEXjcJOOeiaHhqFUOHEQWxiyTFe1NrYMgfDtjTRIToR+/Ce3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZjDyJW2sYfgkPGOnaGu+0Ztu5m7VuZr7SPlasGWH90=;
 b=YHebnfzWfS8T/9gZtXeVHlw3kNVtj0/RRRBPDaiR8+OJq8VIpRy4Y2FeCvfomq9g8vWxrNrak71jsBeuBROLbf9DWQl7INv8a9OUa21mD4FpJknnCbEUO0qnGyY5YOfeF/aCWzwdgsp8CNbs3/iXVZ7GzqoPuHAflD2MK6wN90F7djwBEprBDA8gNpwUtZLYOEeEhi1r4Dz0gpsHJnIb17VDnv5nlQzx9yc9QGkeO+ZoAhICTZdqyAbH7est0s5M9k0bXHw8Duo6XPCvbVVkZhFpOde9uGXkCjqX/FVxqdmX+2Zl80NdwlXzMLftsdYPDmn78o0CgBh91ctUdfupZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZjDyJW2sYfgkPGOnaGu+0Ztu5m7VuZr7SPlasGWH90=;
 b=PBjmD0e68lJLkl4Ft/8KCrNJamr6u63uYItTxOc8KWcMSA6mQXCsWRnjuqJhJ1u2zmLPPieGh4/Hh1eNewuuy2mZD/EdTu1pBU9L3lK6ZfkRYfygFgA0UWLBGnrSIqCUOXO9kKIjvKECLpsMQA3TY2uOd4jgWQ5FAkJvzLJgauk=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYWPR01MB10346.jpnprd01.prod.outlook.com (2603:1096:400:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 04:02:35 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 04:02:35 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [RESEND PATCH v5 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RESEND PATCH v5 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHYkn+OvgSlKAPHREqgV/9WP2Vh0g==
Date:   Fri, 8 Jul 2022 04:02:35 +0000
Message-ID: <20220708040228.6703-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36807fab-efe0-4040-249a-08da6096b0cb
x-ms-traffictypediagnostic: TYWPR01MB10346:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ijsDgz7qBCUkozVNPhqrneC2NfEAiC/ML2mcYSZiLKUepOXXmOgQEP8r1UKBoXHt9MWAp/ETE97dmaKcIBtG6E6p2OFddesW0yz9sFIUtSjl8uvyKd/8IJMyksPReVjrbRwpfCNRKpEjX4CJzyr7RI9S4wGexUYbk+pL5QrfwYDwMMXr56J8eiY5nd0a9LhiMD3yvQedWNzkwJ/nnLaBgEAMaBsZsYTV4hniq82PJfeLPu9rreaNp6ts6tRz5DAlhwcAnA7mGcnRJeiOFPPyn4ZXvrOHynIcLXbIf0T7vkAX2hxESsmD1DB01q/OzWQl3T8CTSiMGuJd7/zp+JSjWPEdosErRxpOiheQFKSsuxleFi/tGz8eJhnHTYqUjlDHeUmMiHnNd9b1/t41Y34kzFlr+Bu4RdQKiPWUgYdHsYmg88I+N1GHRnRwmKEqectsYnd2/m6U28H2bOb/uNOLFZ6RmY01Efaln882e5FEKRJ+Qdl6m+7yc2XemKAmq2FJtq9/tCy2PZFKcGt7CofvsyXcKqNFwIJ/K13PcDrZjyihh+MT505uI/lG3GH3EkDOuJ2FjlHezKRmozfcLB3rv32gqmAM3xiO8lG+a2fZD4wjsP9sHPYAfR7LZX4aCCuOOA6aIiCHvzNwQWr3LLEcP0Yo2tp8Zbsmr7f3Ce6GCncbmOx1FHRV4SbrH8qhs81qrFxpYySl+4AS3XRwbU8gQ4Hbl3NuxEMzB1ONzesiya5ESFKHwKUCxiNZGuZeZ96PbNz0amoDD0g8eLurV6xWWGQW9fpGAErlHWl/Wu3wZYcDIlA6zHkQuhC4G8Q54SOKDmSDpFoU4hJQYXy9uptxJ2azCc4rfnr/o1yZQ6dYOdSa543hHWkcm5I6m2TtsvdzNZ8zAdejw5+DO0NB543jpJ2PT97hZhCSKcDJKLGW1q7rkzbDGKA8ycjNBMoS6I9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(107886003)(38070700005)(6512007)(8676002)(83380400001)(316002)(1076003)(54906003)(186003)(6916009)(4326008)(2616005)(36756003)(5660300002)(41300700001)(6506007)(478600001)(26005)(91956017)(6486002)(82960400001)(66946007)(66556008)(86362001)(2906002)(71200400001)(122000001)(966005)(8936002)(66446008)(76116006)(66476007)(64756008)(85182001)(38100700002)(15398625002)(43620500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NUdPNlprQnlDbEVQQVBPMkFJTGd1S2wreElCZWtTNkpORDlBS2JsVlhMcjJB?=
 =?gb2312?B?bXlpRHY5b3k3bkZFTWl4T0tCUlZzZU1tclZDTjdiSjhQUzR1aEhHa1F4NDJM?=
 =?gb2312?B?bkxmb1g4dzhnc1FSMHdpVHB4Z2JpbHZUOXgrb092cW5mZWtBdTF2MG9nSXZI?=
 =?gb2312?B?UHlkSmJkZ1FmcmRxQkJVSWhHZFdkaEl1aTlEZGJlSkY3UXhuaHVVbFJhL2tX?=
 =?gb2312?B?akxCaG1yU2pRdy9GNVBZTjhJUXBMWFBEU1VKRnVHV2ZESUN4eGNQdGtvQnBV?=
 =?gb2312?B?bHA0dXMyeE9UTjBERHA3cTJyVFVMOFk0R2hJaEpwYkw4NmFscDhCVXpucTBh?=
 =?gb2312?B?ckV5Y3JIRkpEZ2JpWlFCdjdFbDk1Yk01dHplNWYraE5rcW5YUGRvTnd0R25B?=
 =?gb2312?B?bFpmV1Vzd3A0UmpOd0YrbDBXSkIrMDU3UEtIMmFGb3JLa3BYMzV4M1RTSGhH?=
 =?gb2312?B?S0Njb0tlcUdaaTlTNUkxbVVhVmRhUU5tbTJGVW5uQnRYdXhyMVVHcXJ4WWp5?=
 =?gb2312?B?LzlaSWwrMFF0RmNCVVBIdXhDbjdrM0FXeFAvdnVnbjZnUmlUVDlSa2VBdC9p?=
 =?gb2312?B?TTN4YURhY3cvMHlHaytzZ1c3UGJPWExjUjBCdFBZS24wVFc0MUpJRnFwa1Ez?=
 =?gb2312?B?L1gxcFNxWFhqanl0Z1NiNkM2TUdjMGZsUjNuRktnYUIzODZvOHA0NGJqRllM?=
 =?gb2312?B?WkRFdUk2QTEwT2xEZjQ5MUpyZ1hOZHh3djNhVURSTnNwTDNzZEcvVTJ5SjBY?=
 =?gb2312?B?anZocWR6T0xuNERESGp3VWpZaUlVNWVtNEJwUHRFWEJ6ZnNLckpvQ0loTDA0?=
 =?gb2312?B?RkVaNGVzdXNHTzBDcXI3MUNUTFBvbVRLakdocklqTkVUU0FQTmgyVTlaajFm?=
 =?gb2312?B?UTBmWmd0eFQ1Y2pMaUZUZ2ljaGNLeVRHN0t1a3lxRTAyTUt2S1JkNU9MTTJp?=
 =?gb2312?B?SEtZL1FxSmh6M0dSMFdkSzB0YVA1WHphQnZ6WVdKRHo4NkhFY0JpbGxUeUVR?=
 =?gb2312?B?aTE1dEdnZ2d3d2luY3lwTGJIR3I5S3JDaFZCU0M4UDZFV2hkUVVVaHliZUpC?=
 =?gb2312?B?RnQ4UUhLZWlQNVVIeVJTUlJZaVdYVXdSanhGWlFZSmhJekFIUkpHbjQrdlpN?=
 =?gb2312?B?SGM3aWUvbFVUQmtVL09yZlo3TkRsTUhEVUwraFhOTzBtUXBGS3laeUFqREUw?=
 =?gb2312?B?Q2ZWS2tFVGYvMW4xaURHQjVWeDUyNzRzazZyMlIyUW8zcFdlMGE5MmNqVmE2?=
 =?gb2312?B?dmhUNW5PL01QakNPU2g2WnIzWmVvd290SkJsSnhUWkswOW9udXZ1Tnpud05h?=
 =?gb2312?B?NlJTMm50ZjRuRlJLZUlka0o4N1ZzNjR0ZFlNaUwxZElIVmkyYVhIZS9Delh3?=
 =?gb2312?B?OFM2WHgwNmREbitDenZtWW9UNUR5bEs5dk5HL0NKODdYZmUwV0plZUZTQVd6?=
 =?gb2312?B?d2twY2tXd2ZodUZtL2gyazRaYkFCeGhWNWJZT1lrMFV5aE1HbXFkM1NtK2I4?=
 =?gb2312?B?RzhuK25xTjlzVzhtMFBja05NeTZKNm5XSTRNbWlVUGFOKzE3MHptQnF3ZElD?=
 =?gb2312?B?dlluWWlHNFZtUGQ3OXFnb0hQWlQ4b0t3V2xjN0FDWkZJTkc5VFA4Q3NrNEVz?=
 =?gb2312?B?N2VFclhzbTlyeWprZGMreVZ4UHVvQmZNUUdZRjRKbVFmR2ZqU2REbGZIdkw5?=
 =?gb2312?B?Q3BETXBsb3g1dUI5VjhiQlh2UHlURFFzQU5LQmMvN3FIVWYxTHpXTXlSdDRI?=
 =?gb2312?B?OHpFRXRmWUQ4b0tVbmN3WGViOEs1QzlXV2gvOVMrL3dkM2NWNUVLODZRSVdh?=
 =?gb2312?B?L2dqQ2FOcDV6UnJFSWNxYllEMzEzc3pKdzZ3RjRSMWpoTkpDQlE0NlNwUlVQ?=
 =?gb2312?B?Ly9Dc2VwNUdqK0YvZDlSTDJYSDE1bmxTRSt0aEU3dmJ1c2p3dkNHbXA4Wis3?=
 =?gb2312?B?QzVXTSs1T2hlSWtmNHRFcFpVTnJnbmxrWW5remh2MjRMaHhnNFY1andiazQ2?=
 =?gb2312?B?T1V6a0xjNkFLTzBsQnhIdWVuSFd1Q3F3R3ArMGJjK1N0TXpFUERYT2xnSzEx?=
 =?gb2312?B?RitIQzNKQ2JJcnNjTTBINm1aUW85UHpOK2pVbGhXbU00NVpLYUpiQXFtTVNy?=
 =?gb2312?B?cWZUaURhNGg5cStVZGpFNkFSUFp0MG5zSW1QVGlrSjVjYVQ2UFNKM29Yb2Vs?=
 =?gb2312?B?c1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36807fab-efe0-4040-249a-08da6096b0cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 04:02:35.3654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvtGFQdJ/vnrHuqP7Vefn7ElCISnPSaxxUBaHqLo2L/rqCrXQsaTq86cf8a1W+WqMosKSVN39SwJkWJKROx0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10346
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlIElCIFNQRUMgdjEuNVsxXSBkZWZpbmVkIG5ldyBSRE1BIEF0b21pYyBXcml0ZSBvcGVyYXRp
b24uIFRoaXMNCnBhdGNoc2V0IG1ha2VzIFNvZnRSb0NFIHN1cHBvcnQgbmV3IFJETUEgQXRvbWlj
IFdyaXRlIG9uIFJDIHNlcnZpY2UuDQoNCk9uIG15IHJkbWEtY29yZSByZXBvc2l0b3J5WzJdLCBJ
IGhhdmUgaW50cm9kdWNlZCBSRE1BIEF0b21pYyBXcml0ZSBBUEkNCmZvciBsaWJpYnZlcmJzIGFu
ZCBQeXZlcmJzLiBJIGFsc28gaGF2ZSBwcm92aWRlZCBhIHJkbWFfYXRvbWljX3dyaXRlDQpleGFt
cGxlIGFuZCB0ZXN0X3FwX2V4X3JjX3JkbWFfYXRvbWljX3dyaXRlIHB5dGhvbiB0ZXN0IHRvIHZl
cmlmeQ0KdGhlIHBhdGNoc2V0Lg0KDQpUaGUgc3RlcHMgdG8gcnVuIHRoZSByZG1hX2F0b21pY193
cml0ZSBleGFtcGxlOg0Kc2VydmVyOg0KJCAuL3JkbWFfYXRvbWljX3dyaXRlX3NlcnZlciAtcyBb
c2VydmVyX2FkZHJlc3NdIC1wIFtwb3J0X251bWJlcl0NCmNsaWVudDoNCiQgLi9yZG1hX2F0b21p
Y193cml0ZV9jbGllbnQgLXMgW3NlcnZlcl9hZGRyZXNzXSAtcCBbcG9ydF9udW1iZXJdDQoNClRo
ZSBzdGVwcyB0byBydW4gdGVzdF9xcF9leF9yY19yZG1hX2F0b21pY193cml0ZSB0ZXN0Og0KcnVu
X3Rlc3RzLnB5IC0tZGV2IHJ4ZV9lbnAwczMgLS1naWQgMSAtdiB0ZXN0X3FwZXguUXBFeFRlc3RD
YXNlLnRlc3RfcXBfZXhfcmNfcmRtYV9hdG9taWNfd3JpdGUNCnRlc3RfcXBfZXhfcmNfcmRtYV9h
dG9taWNfd3JpdGUgKHRlc3RzLnRlc3RfcXBleC5RcEV4VGVzdENhc2UpIC4uLiBvaw0KDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpSYW4gMSB0ZXN0IGluIDAuMDA4cw0KDQpPSw0KDQpbMV06IGh0dHBzOi8vd3d3
LmluZmluaWJhbmR0YS5vcmcvd3AtY29udGVudC91cGxvYWRzLzIwMjEvMDgvSUJUQS1PdmVydmll
dy1vZi1JQlRBLVZvbHVtZS0xLVJlbGVhc2UtMS41LWFuZC1NUEUtMjAyMS0wOC0xNy1TZWN1cmUu
cHB0eA0KWzJdOiBodHRwczovL2dpdGh1Yi5jb20veWFuZ3gtankvcmRtYS1jb3JlL3RyZWUvbmV3
X2FwaV93aXRoX3BvaW50DQoNCk5vdGU6DQpUaGlzIHBhdGNoIHNldCBkZXBlbmRzIG9uIHRoZSBm
b2xsb3dpbmcgcGF0Y2ggc2V0Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmRtYS8y
MDIyMDcwNTE0NTIxMi4xMjAxNC0xLXlhbmd4Lmp5QGZ1aml0c3UuY29tL1QvI3QNCg0KdjQtPnY1
Og0KMSkgUmViYXNlIG9uIGN1cnJlbnQgd2lwL2pnZy1mb3ItbmV4dA0KMikgUmV3cml0ZSB0aGUg
aW1wbGVtZW50YXRpb24gb24gcmVzcG9uZGVyDQoNCnYzLT52NDoNCjEpIFJlYmFzZSBvbiBjdXJy
ZW50IHdpcC9qZ2ctZm9yLW5leHQNCjIpIEZpeCBhIGNvbXBpbGVyIGVycm9yIG9uIDMyLWJpdCBh
cmNoIChlLmcuIHBhcmlzYykgYnkgZGlzYWJsaW5nIFJETUEgQXRvbWljIFdyaXRlDQozKSBSZXBs
YWNlIDY0LWJpdCB2YWx1ZSB3aXRoIDgtYnl0ZSBhcnJheSBmb3IgUkRNQSBBdG9taWMgV3JpdGUN
Cg0KVjItPlYzOg0KMSkgUmViYXNlDQoyKSBBZGQgUkRNQSBBdG9taWMgV3JpdGUgYXR0cmlidXRl
IGZvciByeGUgZGV2aWNlDQoNClYxLT5WMjoNCjEpIFNldCBJQl9PUENPREVfUkRNQV9BVE9NSUNf
V1JJVEUgdG8gMHgxRA0KMikgQWRkIHJkbWEuYXRvbWljX3dyIGluIHN0cnVjdCByeGVfc2VuZF93
ciBhbmQgdXNlIGl0IHRvIHBhc3MgdGhlIGF0b21pYyB3cml0ZSB2YWx1ZQ0KMykgVXNlIHNtcF9z
dG9yZV9yZWxlYXNlKCkgdG8gZW5zdXJlIHRoYXQgYWxsIHByaW9yIG9wZXJhdGlvbnMgaGF2ZSBj
b21wbGV0ZWQNCg0KWGlhbyBZYW5nICgyKToNCiAgUkRNQS9yeGU6IFN1cHBvcnQgUkRNQSBBdG9t
aWMgV3JpdGUgb3BlcmF0aW9uDQogIFJETUEvcnhlOiBBZGQgUkRNQSBBdG9taWMgV3JpdGUgYXR0
cmlidXRlIGZvciByeGUgZGV2aWNlDQoNCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9j
b21wLmMgICB8ICA0ICsrDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfb3Bjb2RlLmMg
fCAxOCArKysrKw0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29wY29kZS5oIHwgIDMg
Kw0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFtLmggIHwgIDUgKysNCiBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAgICB8IDE1ICsrKy0NCiBkcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgICB8IDk0ICsrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQogaW5jbHVkZS9yZG1hL2liX3BhY2suaCAgICAgICAgICAgICAgICAgfCAgMiArDQogaW5j
bHVkZS9yZG1hL2liX3ZlcmJzLmggICAgICAgICAgICAgICAgfCAgMyArDQogaW5jbHVkZS91YXBp
L3JkbWEvaWJfdXNlcl92ZXJicy5oICAgICAgfCAgNCArKw0KIGluY2x1ZGUvdWFwaS9yZG1hL3Jk
bWFfdXNlcl9yeGUuaCAgICAgIHwgIDEgKw0KIDEwIGZpbGVzIGNoYW5nZWQsIDE0MiBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMzQuMQ0K
