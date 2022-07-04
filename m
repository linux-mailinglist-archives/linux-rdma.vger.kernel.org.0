Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD1564D7A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGDGBG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 02:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGDGBE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 02:01:04 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD863AE
        for <linux-rdma@vger.kernel.org>; Sun,  3 Jul 2022 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656914464; x=1688450464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zy8xOPZWZB1CbQUP5nX/vKzMxGjIoG2c0up/fy8cRw0=;
  b=loMBOZC6ntZkAmx17kZ+pd0eYnp2bMG4nd3YSAethJtK4ahp1qkqNaAd
   9y6DweZ7lRL48IjzpUopgnCo0E6WFk4bASv+8kaYEGYXPEvPRiEl35gGr
   mO6FO6RtXv+4PpeRJzOpJFbeny4yFMPZWgg9Ld4BDNIe1C1cAS52s56Yo
   ci/GsVXo1FE2xdXP7uBSWm79WHumCubmB104xbXh2zemDriphnKyJl30s
   F7yGLvgGOaQB4Dsv9iFvOa7bZY7NfQiCqTWxrXvAsocbZ2Np6vxVQVM8d
   sN7SD7gwj5U0fal77tk/GM+PyPeHlWIt1AklnvNWN7+0nTSP0zhUwbx5l
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="60952360"
X-IronPort-AV: E=Sophos;i="5.92,243,1650898800"; 
   d="scan'208";a="60952360"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:01:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0wFz4ODIGrVxeEvHzqdH3Bl2S/KGzp/cLZKg+8SepFWlB+GKWv1TlBvItik3g7s8aVYNOsAuDxgrl3eO62rJTo5D0GhxOpBUdEcst44wtzpnsx4v7XOrHqsDovupahoMrAQJroZQuB/cnU4Tpq3NICjiNSUmwyRXdpmjrFvqY4LgSvcZZk8EBbKPt041pZg6WPrMvX8OMUDBaqgrXQeVMftmYXyn3xA7OlwyH2Vi8jSRnK3Vr0xoodNmNt5vGpOOPtHkUBerMUywqtTYeHNMetR2fkIxmPksFPGtINx4SxqV1ZJ99h1Uavh6dxTNM2hpdjkV5YsJlD917dKk9oy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy8xOPZWZB1CbQUP5nX/vKzMxGjIoG2c0up/fy8cRw0=;
 b=Y1logjiJ6cxjNqHPxgIriQuGa+d0Qvpqk+3WKgdCzzhvIjFSWZNQvSb1kXvPAyneuFu71dJ2LK+rk7U7CvOz2JefzuO6ghF0Ni9cftryQvXUtIY/27RjBZ/4om7A1+/j0mAjdyXq4Kw+4s9mjEds2tTMl+HMjmzlsIM/Nevv95EV5VGktj83VVhIGKJp0/laXsagDuBt0RU5GSPN13B1RIFftLyF/8HZZU/wbD/F7RCwUtENyKjuvqrokv0MMPc61GI3r//Lbr7DJAtMlTxnUUAITjeoV6VpI+Yiz7oeVHzWlaIgbfemUoitzerLwr2jYcqr6YDK6enTGDPtror8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy8xOPZWZB1CbQUP5nX/vKzMxGjIoG2c0up/fy8cRw0=;
 b=B9BQKvPz+3EW7F0M2D0+K/NE1JfJewyVoGNtdLksAlx+Qaf/Ynln+YwRewoHFSFD8EintrDJmw0azxsO05z8L3Q0M5zM/io1BPXJXFs3VsC3mnGQXngAvoraquk9D15l1wm4i3vsv4tRq5+4aIFk2nPOEgP28E++pB3wlnzNTtQ=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY1PR01MB1753.jpnprd01.prod.outlook.com (2603:1096:403:1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:00:55 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:00:55 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH v5 1/4] RDMA/rxe: Update wqe_index for each wqe error
 completion
Thread-Topic: [PATCH v5 1/4] RDMA/rxe: Update wqe_index for each wqe error
 completion
Thread-Index: AQHYj2ts7pOi9bWXrkiEg2X7//pIyg==
Date:   Mon, 4 Jul 2022 06:00:55 +0000
Message-ID: <20220704060806.1622849-2-lizhijian@fujitsu.com>
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
x-ms-office365-filtering-correlation-id: 69b35b6e-0898-434e-8684-08da5d828f02
x-ms-traffictypediagnostic: TY1PR01MB1753:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVqwKzvZd7Pj0rgyIcOBHCbbpNxfHn4k5cqQlQgq1W+nQb5UEDdyTMy7uVhd5jjIQKtlRqzzjOQRHU4c4rpnguYEArmF6OD3g+xebhAOW8sOcwMIZaYIeWsQtqB8coDuqSbZspCiqd9pUX0uDB+CRJM0fpb/K/la8rVdPvzlrSRF29/r+UcUefHFStiwNDOfbxCQJlwZeIZBhTD0m5hFjRbmsQ7fXT/ORjNT5wSdvYUT62AgYiiJNkBYSbyDptjRotk/SpdFFtsXKr1zlw3hu5uqGLM8I51EVPV27LG3Ho7qWySBagJQoMhwCuOJ9ltsRKJWfvuAMkMtRM8AEOoDqkFkcF2xnSS3IQksaKOd8eKePablNz7f7TAolatpAUdAc4Hvm2BsvxssSgFbxIbf2obRHWJ/weTuX7ltzStKcA5eX3PCEy6I/7kI0o/fOQYhTjtHchu6w5OiYgpE50tIJM9SYlZ0RS+CMTa2WbYG0HOU1ZaGwc0qf7pfYps/s+QuavK0R9M+EgEd0Drfy+hH1eNYWpnuJUew/0EWJNcmiiiTbuyMzE2HbMMEkt2wKP8q8cuYXo3++sAEWaQz/2tH1YRmxX22OVMO/+erIfTuCIz21mho5VieG5nsPnu4sZfdG3wFp5YGCxk7w4joSNmfTHbJaRsAjyM7cs0wmRtMwhxuHtDqjXjR+H03kcNcFmYnISagwHrnEzI9oHUD4LYN1044TByqkBNTsINh91+e+8LzcQN9J25O0Z9le4DV0geeQDyec75Lre1OP43nLcoaXeGZo7cmaNdj5ROS3MpHebeqzwrdOGFHIK0rtkr4LlIO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(2616005)(107886003)(186003)(1076003)(38070700005)(38100700002)(64756008)(36756003)(71200400001)(8676002)(66446008)(316002)(66476007)(66946007)(76116006)(110136005)(66556008)(83380400001)(85182001)(91956017)(54906003)(4326008)(15650500001)(5660300002)(6512007)(6506007)(4744005)(478600001)(6486002)(8936002)(82960400001)(122000001)(86362001)(41300700001)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SUVLa1dGMUJVUEZCUGVZeGtHKzE2N056MlJKK21NMkFoSDRrYmJPM2NpSC9o?=
 =?gb2312?B?RWtOTmdlcE5HV0UwTUM1eTJ5Ty9xV2s3R0FrdnN5RUgzM2RDcWt6NlZ6d01u?=
 =?gb2312?B?bzlzMDUrazgreUx0UmdwOTBsbzlVVXN2b2ZKd09ZTFllWGRnbmFUb3ZiTlZh?=
 =?gb2312?B?alUrZktNQy8zc1JkalpiQ1pUV0hQTUptLy9kS0ZqaHNUWWNBbUFMMDlCUjdK?=
 =?gb2312?B?Mlk1MmJ4NElxckNjQnF6VmE4elhzWVhhTStEV1ZRaXRkZmg0aXBlOWgxNmFO?=
 =?gb2312?B?SzNQRWJSSVpnQU9jSlRIVHQrMXdWS0FzUTdkNnFPVm1FWk9sT3FUWkdpbE5o?=
 =?gb2312?B?WWI3RzJ6cVlETkZyWktTL2ROTW02VmQ0UkdrNW5icjJ6YnFVK2cvM2lMalh6?=
 =?gb2312?B?WEVOd3ZsbnFBUmszTUpmUjYzZTdFZGV4SFFlcmZOQUU1OE9NNlRGcnh4bUJH?=
 =?gb2312?B?NUoyR0htTTdsNHlPZnQwWlpEMzk0RmlyT0dhM1pGMTZXTTN2THVjMzc0VlIr?=
 =?gb2312?B?K1dkaE9jRjgrRDdZWGFoWkVYdVU4clV0bjNlODZ2M0g5ZFZvQ2grTTR4Ulgz?=
 =?gb2312?B?N0NHd2d3ZFhtU2dSQmwxNmh3R1gweEhLemQ3cG9MMGtya1NxaEFSUUhsVEI2?=
 =?gb2312?B?TmZzbkJOaHJhS0tpOHR1R21BTmx4S0p4b0gzZUs3U3R4SUNOMnhNK1YvVHUr?=
 =?gb2312?B?angxUTRyK0x3djlaczNHejVQTVdDZTl5WDJRK1JvM0NGcG5HVTg5QnhrTThw?=
 =?gb2312?B?amxVbEJyUjBDTU1rOXFFUnZiVVdpS2dWdUsyOHZUYjBhVDBscHFXZ0FLdXRG?=
 =?gb2312?B?YUo2VUJoOXpWSTNqS09ZOWdTL3ZuaHZMczA5SnFaREVoM1hKU1dvVWlMcTZM?=
 =?gb2312?B?cHBYcUZMMDcvNVJPTk9sam9EVVBydWJ3Ni9HckhvRUJDRGh2c3BUdGs5MDR5?=
 =?gb2312?B?bWdJb0ZQa1BtaEZhOG5OcE4xWFcyV3luUHNCdVdHTnFaZFNhKzlhQ0loNmZM?=
 =?gb2312?B?cHpMWVZmU0VTZzFIUEJIMmdVcDB2M01NNmlteDBNc01wbHo1WkZZWXZJYmJt?=
 =?gb2312?B?UVBhSGNQNjlKOXExWURocVYvTm9Ca3VEREFOdWlyZjJFRk5yRkdqZy9STkxK?=
 =?gb2312?B?NmljYWFLWjJvR1lCSE5DYlhxNzJOY2NEV3gwYmgzaVExdTh2UjZCOWdRekxF?=
 =?gb2312?B?cVRuQklqMEdLTWJ1MWxLOHI2WG9GQmY3cmZxTWxFTVFqVllyTUxPT09iNXBF?=
 =?gb2312?B?YndTdloweFEvNWF0aVhTalBJZ2xJWjA5ejhEUEtNVEpaREZmVlZGZTNvdkxM?=
 =?gb2312?B?ZEJXdEcxVitxeGdZcGthZnNKU3BBWGJ0SEdBM2F5TVJOaUpkNUxMcFJPZVEr?=
 =?gb2312?B?VnNlWWRPeXdtUHh4cEx6bFE5YUs3bGJab0JwNzRqNFFhMzJiMVNDY0JoRGJX?=
 =?gb2312?B?V2Z2VTA5Z2x4dEROaUI3RVhaaGFjQU1INlJvVmFDVlUxWDRvOW1EZVExdm5E?=
 =?gb2312?B?dnNPY0JWK0VweWIrbFlpUlBtd2dpNGZOQ29Cand3b3ZlclN6OGREOXBXTERQ?=
 =?gb2312?B?Z2xZTmNFWGpiRm40dUdLblorc21rbDR5UnVCRVV2aUJGUzFvVERwaks5bXBs?=
 =?gb2312?B?OWUxQ3lkblNPRk9sazRjcDl2dGRFc2huaGZlWE1hQWV0QTI4M25LeGE2Sitt?=
 =?gb2312?B?UklWNmc2V0M5K085N0ZkQUxZZ05taHhFZjZwWjk1dU1kNU1xM2NlWStMd1ZB?=
 =?gb2312?B?RjFxN3pCSVc5SGhHOXI0eWZRS2xxNGFuYkQwcHEwU3ZNNTNJWnR1ZzRUMkp6?=
 =?gb2312?B?KytJcHBjSTVXYkVjN29XTlV2L21MVFRnRTNRLzVYOW9jN2R2VkhPRy9QT0Y0?=
 =?gb2312?B?VWlaVVhYS1RLWmduaUcyV1k2dWY5S09RWGhHS0Y2dEx3UUQ1b2Rpd3FpOGdq?=
 =?gb2312?B?ZFFLVmFwRDRZS2RIZDd0ZEdvRWhrbFplcGptSW0yMmthK3Q0WitFRzhkMEZ2?=
 =?gb2312?B?eThCZ08zRzlDUXJvNEQwcnAzV2FMMi8zWjQ1U0YvYkwxd2RiN2RCM3BPUkNs?=
 =?gb2312?B?MStoNFJjZG5keGpneFVzVHRpbWJaak4zUUhaMG1iUCtpajEwV2Q0ZE8wQ0Z1?=
 =?gb2312?B?b3Q1TXFTalBYeTMzL1V5bUk4WVluZkFQQjROL0ZhMXAvbXFyNkdoSzlOLzlF?=
 =?gb2312?B?Nmc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b35b6e-0898-434e-8684-08da5d828f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:00:55.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHAYH8TYIQ+XxfNNd5LHOhx2phRDCk608Vo6Lf1E9AJK08/jiCU2AxIACNGFzFgVXtGSCqZb5d1g25RsFtoMrA==
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

UHJldmlvdXNseSwgaWYgdXNlciBzcGFjZSBrZWVwcyBzZW5kaW5nIGFibm9ybWFsIHdxZSwgcXVl
dWUuaW5kZXggd2lsbA0Ka2VlcCBpbmNyZWFzaW5nIHdoaWxlIHFwLT5yZXEud3FlX2luZGV4IGRv
ZXNuJ3QuIE9uY2UNCnFwLT5yZXEud3FlX2luZGV4PT1xdWV1ZS5pbmRleCBpbiBuZXh0IHJvdW5k
LCByZXFfbmV4dF93cWUoKSB3aWxsIHRyZWF0IHF1ZXVlDQphcyBlbXB0eS4gSW4gc3VjaCBjYXNl
LCBubyBuZXcgY29tcGxldGlvbiB3b3VsZCBiZSBnZW5lcmF0ZWQuDQoNClVwZGF0ZSB3cWVfaW5k
ZXggZm9yIGVhY2ggd3FlIGNvbXBsZXRpb24gc28gdGhhdCByZXFfbmV4dF93cWUoKSBjYW4gZ2V0
DQpuZXh0IHdxZSBwcm9wZXJseS4NCg0KU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0KLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVx
LmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9yZXEuYw0KaW5kZXggOWQ5ODIzNzM4OWNmLi40ZmZjNGViZDZlMjggMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KKysrIGIvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCkBAIC03NTksNiArNzU5LDggQEAgaW50
IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KIAlpZiAoYWgpDQogCQlyeGVfcHV0KGFoKTsNCiBl
cnI6DQorCS8qIHVwZGF0ZSB3cWVfaW5kZXggZm9yIGVhY2ggd3FlIGNvbXBsZXRpb24gKi8NCisJ
cXAtPnJlcS53cWVfaW5kZXggPSBxdWV1ZV9uZXh0X2luZGV4KHFwLT5zcS5xdWV1ZSwgcXAtPnJl
cS53cWVfaW5kZXgpOw0KIAl3cWUtPnN0YXRlID0gd3FlX3N0YXRlX2Vycm9yOw0KIAlfX3J4ZV9k
b190YXNrKCZxcC0+Y29tcC50YXNrKTsNCiANCi0tIA0KMi4zMS4xDQo=
