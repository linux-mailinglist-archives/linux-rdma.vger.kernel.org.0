Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7168E50AD10
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 03:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443004AbiDVBLy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 21:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiDVBLx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 21:11:53 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 18:08:58 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E3E496AF;
        Thu, 21 Apr 2022 18:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650589740; x=1682125740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ARdz/GKwyLZm2lGFtSn6y2vOvwKgmk+75H7Q3Tgp3wg=;
  b=Tnp0e2bi+MPzNVeZRsxzqktPiPA1uUri0sCqDFXAlUad1bxxxWs2ulJS
   cKE6J8ly1Tu2uA+Ah4FYvPO6jzRlhj1IZ0QZ62dj4MD3/GLtjYZtWnqL6
   MgEi4ulfnVQqnbNPObwsxTxf76s6yJ8XxZ+vu3dqI0iupcQT/w37Zmw8r
   d6pgJEEnzOcQnKWNB6RgAZGnG+Heda7uwssuDC+JnM+rFZQ8V2yZrjez4
   hOtKc2IxZy49qaun17gAC5s3ms+EBGaT/jBJTGlI61qKKlYR0alIC7i8g
   XfP8+Ofo5ZllWsRD+VqULghQz2JQfrUNuW+dYq93+sYHcPeacE4orNmbl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="62625073"
X-IronPort-AV: E=Sophos;i="5.90,280,1643641200"; 
   d="scan'208";a="62625073"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 10:07:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncWKsll+4jtkFnK2UGCyR5TyXvZwlEs9YsET5EnZWT33CH9GiJ05e2i25DQ1LXQu/hqzBLmPhUv+/FkyIwQUNEOWrOrClwmKZmVBwrbfdIRPthWPbubAwHqX7KzMQ/OWkVhnr1yjpK62jDvQO+x0jc1KaTFOPSWei7MxNZBqnGqOXbFXZ/sPlwgBlHArH85zH1bMCzKe7tXVIdHgzV5ngqBM/I47Lg9Dqem7nkeJGLikvo7C9bDRPSVS9XgpbUwnA+bam8Hc1RZ3NiCvT4vCMXHV+fGGPWMtOTWjtNRNPwwEjRyi1qbe6bvCi8CeupS8Jms7vHV8qTObngJ6aY5hRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARdz/GKwyLZm2lGFtSn6y2vOvwKgmk+75H7Q3Tgp3wg=;
 b=IQizgauU3DgzagU1yw3vGr8QT6Z7eygwWAYy4XkjG2HjsSUosKdA7puXTlUVOZnXGIhkTYbYjucQr1fAGjRinfMoySYumir7x6qrmre+u4gOGCMKyRx29NrxV+z0iiCu6Tsi6UxlLXvwb0LVweK+NmCk6i4LAoTPXB1eltemYauv5yWD8Qadlf+pBeI5JBi9Fzovl6cN2sWRFX9rMLLpBZPbXSpvZgQLZjauGVEfQwy7Ql+9GbwCr8f9wDgoiCpp7NBIhWjDDbOmGV5dscE9+7nM29ClSvWdsHuCTrqtYGRDb2wN53P7U0gOhYqQcdS+8svoRBsSak1FknHW1SsCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARdz/GKwyLZm2lGFtSn6y2vOvwKgmk+75H7Q3Tgp3wg=;
 b=jNz88L3yyPcYXpKE+q674z23sIWfVmyGfoIFbVFTKKzihqz66MSoyvBfGz14/eIGLP722CcgLeeqn95UxyowQAhIuUYaZJcF7WSbsA3zMLavbMNUJjXm4F+LFxCXN1je8zlB6YoDlL6JQEDLfQKbqQ+lS5/C8NOXcHrlwykLozc=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB2108.jpnprd01.prod.outlook.com (2603:1096:404:c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 01:07:46 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::d598:aa14:b8f2:1546]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::d598:aa14:b8f2:1546%8]) with mapi id 15.20.5123.031; Fri, 22 Apr 2022
 01:07:46 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] RDMA/rxe: Remove useless parameters for
 update_state()
Thread-Topic: [PATCH 1/3] RDMA/rxe: Remove useless parameters for
 update_state()
Thread-Index: AQHYThQpjEd1d3mWM0CtWdsgqaC4+Kz7LnyA
Date:   Fri, 22 Apr 2022 01:07:46 +0000
Message-ID: <b3c747ed-1a87-896b-d95e-35fd2a80ccf7@fujitsu.com>
References: <20220412022903.574238-1-lizhijian@fujitsu.com>
In-Reply-To: <20220412022903.574238-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89d8ae68-0050-4503-ad72-08da23fc8356
x-ms-traffictypediagnostic: TY2PR01MB2108:EE_
x-microsoft-antispam-prvs: <TY2PR01MB210831AC627BC386960CF70CA5F79@TY2PR01MB2108.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptEbJoc9hkFKwGlHMnD4TYaOU8CZi9C4oO0Nwa/H7kQpTaNA0pEDe1aFyU/ioli33FtmoN718g7aeiRVkPFbiT9JpFW+aPuRhZ5D0wqx7PdCj7iFFXO55xViCRzeJSzsgBdY0IiUoKfj8RIaIKqG4QgaE5t6LqyvBCrABbtlHhAWiue3eOjrhqJxy0w4NyFX0pBvLHsNwbKitR4yjyiwO0FZFX7HgRjeEVeBaWEAVQIWRP6p/1UGS6BrThet7BWZCr+FjEnkzIgqKuWkTNSvK4RtC8+uTlszsGCmJWewN4vxn4LOixwBRnMe/H1q49VlC9ymp95R+wHATREgv7BfLG7qGDRataiKauyOV1+C2mBYJxZ1BQQKyrO4ZzowtLL9KXF4JDybnSkVeVLBGh3TZdDwnEoEMvXltr2cL61wbe41MjgE0rVhkLIPJbOhnkhgYpPA8VRe9vFCv3V0QZyXxdsU8sHZstJWAhWgIjgYWldxhHLdh+HasNtm5KmcU6YvyetOLIZZd1BbHL/vJctBouSCVCHRhWhJHk1/St+d/qSll5sNYLDopHPkYEA98X2jzr8witvRGlPuXEOgEsbz7KkM6Jf61lcz3SWv2woaoM/SNDKihhnE4FrGmm5vFu/1xuH7AufM+nwZymBRLTIxPZfAgMULrAR5NDkhcpi3Welr2ZMHUqFZ/SvuIWNcPfSIJAo8R5J+v4yH1GZlxWY66w0/uEqdbISz6DMV46fnQW5rpH2ISaZQLaMluDsOc0y9UCtbCmE9rBQxhLzgkRqcsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(6506007)(6512007)(53546011)(91956017)(186003)(2616005)(2906002)(4326008)(38070700005)(38100700002)(85182001)(83380400001)(71200400001)(15650500001)(36756003)(66446008)(66476007)(66946007)(66556008)(31686004)(82960400001)(8676002)(26005)(64756008)(5660300002)(110136005)(31696002)(316002)(86362001)(122000001)(508600001)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG5TbWNZV0lTT05HWFUwVkxFZ0NicGJVUGwwUEtPUm5QMHZUT1Y1WTYzYUFG?=
 =?utf-8?B?OUIrL2F1Ni9oWSsrUk9sWVNtN1U0N3lFamRIdzdiSmJwQlErSU5nRnFxK09X?=
 =?utf-8?B?ZGpTdjZtTU9tZ0pPTDhuNk5ZYmQ2Q3VGZ2FMa25LdjIvZDlSTFh2WDI2bjNX?=
 =?utf-8?B?dmQ3a2pOcFVCRkV1NU1KTmRsb3pvN1E0TFBvMmk3NVU1TzduTkJNMDhVZ015?=
 =?utf-8?B?Tk45Yy93TnBTc2Q3RlA3R1RaTEZYenQycy93V3NXNktmVXZScDkwdnhWdHQ3?=
 =?utf-8?B?VXg4LzVoR0ZPSTkwazFkdHdQUWpCWkl6ckdTQjg3dHJnTmtSUHVhOHZ4TzVv?=
 =?utf-8?B?SCs5bUoxNzhXS0tqTHBJblJNeVVyWjRJVkppYkZxUWRsZmVQUDFhdGxpKzE2?=
 =?utf-8?B?VWRYUmVyL1BmYndqd3B5V1lmWE9QaEdMVkhNY25QMGN6N0FLc09DVWRaY1hp?=
 =?utf-8?B?QytzNG5JUGZIYTEwSm16d3RKLzd2V01PSkVvV0xabnpETmpFSWxleXVvejlT?=
 =?utf-8?B?NWptS1JGbGdTTjk4aldieHFDcUN5dHZGNEVYd29GdndSS0J4UlYrajdUTjdh?=
 =?utf-8?B?cmhNemZITEJ1YUNZZGw4L0hzeVhZZDErc2wyWWNPckoyS3F5dzF6Skl4eWhZ?=
 =?utf-8?B?QTF2SDBrVGFpbldnY2tOaktPdTVXY2hvQ0FtbDZFREhPbzdEdmFQUlA1VUg4?=
 =?utf-8?B?UkM5SkdMendKdHlYV0JjY01pTWwvdU8yenZpdUVJbU5JR2lSYVNmTEJJQnNn?=
 =?utf-8?B?Y1dBSm4yNS9Mdm9jTWs2T0ZWTjloaXJSV2pVcUNvUzdZbzlYSm42d3FaN3ZX?=
 =?utf-8?B?d3B5cXVlQ3IxSk1uazJEdHNZcktYSnhGU3gycWlqQnZkbzFsZVVsWW9zMWkw?=
 =?utf-8?B?Y1cybHdsa0dIWEluSkNZVjM5ZHU0Um0vRUFZQ1h5Nk1mZUxhZktyUHhBcklp?=
 =?utf-8?B?MTJxMk5Md1F6U29RRzB6cE5hQ1BEeW9NQnVqcG1nQjRiZUdxWjZ1L1lKQ3BP?=
 =?utf-8?B?QmZSKzRVWmxpTHNtMHpiRVNWN3NzZVZ1ei8rSjRXbk5Zc2wyZFRkcEV3WVg2?=
 =?utf-8?B?dUg1ak9CM0tYb3pxSzNydHFia05tbXZ3eGpuQjZLNnJvMzhoUTU1OVdxUFRS?=
 =?utf-8?B?WUZZTjUxa3ZDbUxYakYvdElodFRQVUJmcHFuYWZwNjFSWEVMaTJMbEhPdHhQ?=
 =?utf-8?B?SVVSRDdSMTNkTXIrZlBFTENzYW8rVWFhck55ZXdoQVhMK1BHS1V2SDF3NlBK?=
 =?utf-8?B?Umg5aGMwbmFGRUNIU1hBZVVvTkV1K2VtWlZGNjVIVmxXVFdGMWUzSWNxUnBt?=
 =?utf-8?B?b09TenlSVjFnU1dseDlyZ2ZqNk1kbldzMnJqZHlRZTN5SmVKdDRuQkRRSjhM?=
 =?utf-8?B?WndTZ3htQTNETGw3bUIxMHdoYWhrOWRVNjRTSHpFY0JzQW55a0lYSzNQdm83?=
 =?utf-8?B?U0xPQ1phNHlvTExHeHpRTkZwZTBQQmxhOUw2OVd2WnFtdEk1dHRJOXhPc3Az?=
 =?utf-8?B?Y0dZZ1hvWWhXbldqS0J0MDVuSUZLdUUwL3V6M2RQQzlYeUc3cVF2NGNOOGdO?=
 =?utf-8?B?Zm5QR3QrdnBiNEorY2RXNklZMWtFdTkrbDBNV1IxdHUvVENTVHNjc2lFOXRs?=
 =?utf-8?B?V1gxNGVxVFlxMEwyYXE3VHFSV01ick9JNW5tcFJGdFE0dFdkU3JmbFFYTUto?=
 =?utf-8?B?QWVIUjBjUFg1Y2JqdDNDcUthTExNNzdxZDZqMGNGQVBqUTIzTzY3ZWdlUVF0?=
 =?utf-8?B?eXQvRVhLTnN6Z2I4bDRDQy9qL1ViZVdLOHRWdjkzV2NManhxQ0FwV0Z1eVVS?=
 =?utf-8?B?bFZvQmpXMHhUd3E3b1VtbXFRN01QOUU5U1VIbHVKbnBhU1RDTm5SWXh1SDVO?=
 =?utf-8?B?ZUFkNkUzcFI0T0MvemlOcHlaK0RvYkMwZUxNSGlHOWZSZk9hUVVYb24rUTdu?=
 =?utf-8?B?OXEwQnNpbFUvQnBoa1VZd1hLRDkxaFM4VGlVV253MklwS1lWczNORi9qZHpn?=
 =?utf-8?B?ZnBUeVB5MTJyR2tia01UekVTdzQ3MENxMkVQOUtXMzM3UVlHeXF0UlpzbERQ?=
 =?utf-8?B?eEt0THV3UzlBYXdWd3dzMHRTa2xyekNaL2I2Yk9rWVVLTE5NY29pTENqMEdG?=
 =?utf-8?B?TlUwWFpaYkRneTlpSUdiSnpsRk83MTVjM2VaRi9EMXQxMzZKalFBcVNocXF3?=
 =?utf-8?B?cnY2b0RzZGN5SHVpc3o1MGdHa0xjdGh0bUlNbTJ4cDVVMUpHK3BTWWNZRk14?=
 =?utf-8?B?MDY3dmN3Y1F2RHJyWGRtSmFyejJqVzNpTDg1M3Vxd2FyWkN2VTVjR1dJRnR5?=
 =?utf-8?B?M0dLcjdVR2d0ZmFiVkxDdGF5bXdGTzRDRDlmanJXTks5Nk1WTHo2V3FQOU5K?=
 =?utf-8?Q?oDxgEPNFyrKGM/A4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11210FFDD2267D4684A4FBB14D53ED58@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d8ae68-0050-4503-ad72-08da23fc8356
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 01:07:46.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4I3OovZpYd3nVA4JKmbH1kQBivWkRrQ5OPpHvihdJUImrv2nub2Gq5zIYbZqjxfna6GEgRpQKWYpvTNulNlvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2108
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

cGluZw0KDQoNCk9uIDEyLzA0LzIwMjIgMTA6MjksIExpIFpoaWppYW4gd3JvdGU6DQo+IHdxZSB3
YXMgbm90IHVzZWQgYnkgdXBkYXRlX3N0YXRlKCkgc28gZmFyLg0KPg0KPiBhYWFmNjJlMDY2MjMg
KCJSRE1BL3J4ZTogUmVtb3ZlIHVzZWxlc3MgYXJndW1lbnQgZm9yIHVwZGF0ZV9zdGF0ZSgpIikN
Cj4ganVzdCBkaWQgYSBwYXJ0aWFsIGZpeGVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3JlcS5jIHwgNSArKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
cS5jDQo+IGluZGV4IDVmNzM0OGIxMTI2OC4uYmY3NDkzYmFiOWI5IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPiBAQCAtNTI1LDggKzUyNSw3IEBAIHN0YXRpYyB2b2lk
IHJvbGxiYWNrX3N0YXRlKHN0cnVjdCByeGVfc2VuZF93cWUgKndxZSwNCj4gICAJcXAtPnJlcS5w
c24gICAgPSByb2xsYmFja19wc247DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIHZvaWQgdXBkYXRl
X3N0YXRlKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3NlbmRfd3FlICp3cWUsDQo+IC0J
CQkgc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KPiArc3RhdGljIHZvaWQgdXBkYXRlX3N0YXRl
KHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3QpDQo+ICAgew0KPiAg
IAlxcC0+cmVxLm9wY29kZSA9IHBrdC0+b3Bjb2RlOw0KPiAgIA0KPiBAQCAtNzUzLDcgKzc1Miw3
IEBAIGludCByeGVfcmVxdWVzdGVyKHZvaWQgKmFyZykNCj4gICAJCWdvdG8gZXJyOw0KPiAgIAl9
DQo+ICAgDQo+IC0JdXBkYXRlX3N0YXRlKHFwLCB3cWUsICZwa3QpOw0KPiArCXVwZGF0ZV9zdGF0
ZShxcCwgJnBrdCk7DQo+ICAgDQo+ICAgCWdvdG8gbmV4dF93cWU7DQo+ICAgDQo=
