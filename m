Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41A056B136
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 06:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiGHECq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 00:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiGHECp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 00:02:45 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ED974DD6
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 21:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657252965; x=1688788965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6lB+CDAkaqCasiKK+vbPq9uweogB+JwWab64Lbh9yZA=;
  b=N8KOu5sas9N/65Gg0G+3vVZNyIek/7CWk5gB27sGhBGUJ2eQWUxJv6C0
   bv2p5YddSDVR/PHQRhhhq6gVEoY9GXRl/3oMSkND8rz9x21/FCKej6/i3
   mmS+93IC9YAkhCK2LIeUM47xPTAfxQcstHLwaUE7kahyWg3Io1OtZtVdH
   TyC1bEeX81u8pw6Yg/yS83S7WI0+HW7NRh4UvZSwNkqmp+yssqqOdIfs3
   yMPDN73bXaTj3bpgo9ZeXd98N5uS1WTvOFr/PM8YoPORTLiHY/D2SkWny
   YxbmwkgqkioW+7566kXVY78KkhcbbGurr0K4vYm4QRc2yvw4p/8VgZSkw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="59574133"
X-IronPort-AV: E=Sophos;i="5.92,254,1650898800"; 
   d="scan'208";a="59574133"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 13:02:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm+iGDSIeSUJER6tTsJUgO4akBpWLLNvTmbrW2HuF2xJbHnXmpyJHEiCWf77PaZdknU8qaiBYr6afnlEcsRLkJwa7x6Ptc6cj3GDIjlioce/jCPhMwDtmUENPvLxXk1RTNmaf0bik4tx4Lz+EJgFZgwMGuTfyVu/s4sbcb8hy1BluuWNym6QHFaGjBdX3BoxRJKcTUGK4M+YBEJaBUj0LfN0K2hVBL0Md7B/HL2nGTSVfIAkq+Ob8ttiiL+cgLU3YRHrNAOt92G+eLvAR5jtjF1nF7MT6XaanrZSg3fosG0yhEaHouhNjgSwryNAXHCg+FOqO8QLSHIqv+zXxrNvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lB+CDAkaqCasiKK+vbPq9uweogB+JwWab64Lbh9yZA=;
 b=QHXkq0jKcxzc5tudXPRS66rJyUq7N2pOTQl2VajfIqpMqqInFacvRxsFF00R4Cm7RY2xzuyZhfU7VgDgFa8Ge2XoJ/yA1rpxd/rUfW5Ndop5Jzd9Vwjy/CETzSwoj2afqz5I1n32CHiOhA3ZGxEVe+U2VeFIIENfOBS5TYqc57dXDPKcqZsNZPwBrsnKHxdjsTmQTwM86XdNuGmkI6e9fFEamqMSAuUDqAR9Q7wmGuRVaUbMCm3DwylKnq5C5vwUGnbiKBI2wTHHr6WWq6bFz2GEX8GtqrZF3XGcqSfr4o2SuBGuxupgZJsO3x265gibVC19ThyQeMh8+oX5FY0B0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lB+CDAkaqCasiKK+vbPq9uweogB+JwWab64Lbh9yZA=;
 b=akVv8XIdH99+wvp3KTfMPAhfOlgxnMR3N6A6D6wteOzapPm7EpyJ0HiqindGgoxuwvjWNwcbijWaaw2Ws+hctWOhIOygTYbSjAcRqm/mSHjW2sLv78faRbcB2oKJ+LsET8od8aR/4ONl0nJb9MAHyB8MjXgX33hrTFwssFduZTw=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYWPR01MB10346.jpnprd01.prod.outlook.com (2603:1096:400:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 04:02:37 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.022; Fri, 8 Jul 2022
 04:02:37 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [RESEND PATCH v5 2/2] RDMA/rxe: Add RDMA Atomic Write attribute for
 rxe device
Thread-Topic: [RESEND PATCH v5 2/2] RDMA/rxe: Add RDMA Atomic Write attribute
 for rxe device
Thread-Index: AQHYkn+Phr1iqUOipUmEY8beoYYcaA==
Date:   Fri, 8 Jul 2022 04:02:37 +0000
Message-ID: <20220708040228.6703-3-yangx.jy@fujitsu.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220708040228.6703-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec356f3c-1ecf-4e01-3a4d-08da6096b1e2
x-ms-traffictypediagnostic: TYWPR01MB10346:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c6cclMjIOsKhKyo+b4exDy+A/ljVoTmnODWjNiR7MH/aJTNgJSd9n3oH/YlMJywt7O7RgwYi6DyYLcNA0flzoMh8S/gRbo3Ob1Z0m9ROL0X0vNSqzQkUsmt3VtptPYERZWMJ+egl1vOw2cXwxKs4VNY/gsGB+oTGAgj9Xy7Hvw4/FrDxFQwjaYiLXEu0k4MfVleZyubnG99Gyqa4882MoJuylKuQQYg3LwriVgpgghYXorn16PBL9Tv0i8esSqB9R4CgPoG3OAYMcdUPF4E+54wzHez9IwuNhrPceQNS1e5Ggqu4JjqZTqZxQxzJYUnpz4cTxHBWrd436qacwrjoe3JruFJQpnR2vqfBCebYqhGY8iFO2sFR7tpa5Q8x81azQiBLTcKa50THdKjc5UdcOYHYRBtdAq10ks9ASJYXWgFGdxsKPWRDrevbnlhMLN5xURDOSOoyjORQ5ltc0MzWcbqW0pwVXO0M1IAp5qvzCbWBOPqnTfWhpkVxtIPOAvWXfVw2cWG7h7Ed9EAU/O/95Y9UP79WZeZoXTgjvLzveGEpTNAHLv4o0rFct7+9jxLEmjqug+qpQfWsvPSCsm0zsHdZrQlC+r+gKKEUCxeFg0V3HqT9nwlH0CkWskhHn9r60XOgFNf3NNQGwMAIOHXJTj8TmQowJSUMbCtrR4WdCn/ybCmqzcmFdernzCb17aAuF1GNGGgDWb/VgyF4yRdBya+B7Pn3cs93+Ich49Rl5JcXptUp2UwFfB1naVZtLL7Iys0OWYPnmNEmGxNMdd0yw6A1AOnEQRyVVTEOkipeyQztJzv8aC1tYNfl0UTfraqC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(107886003)(38070700005)(6512007)(8676002)(316002)(1076003)(54906003)(186003)(6916009)(4326008)(2616005)(36756003)(5660300002)(41300700001)(6506007)(478600001)(26005)(91956017)(6486002)(82960400001)(66946007)(66556008)(86362001)(2906002)(71200400001)(122000001)(8936002)(66446008)(76116006)(66476007)(64756008)(85182001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VStZVDVjMWNsbnFZYnNiZUtSd2pJT2dqSDh0bVZhTlQ0anRsNHFmcjY0dVJ3?=
 =?gb2312?B?a1g3OWJyZGZibWRBalFwQXIwZmkwK2F0S2Q0eklyVU56eUhrTkFsMmszd1VI?=
 =?gb2312?B?aWNEQW8vUWN3U3JvOVlSZjhnd0NsSURnUHNteE82WEE0bHlaSUF1VzlLNHVw?=
 =?gb2312?B?SFFITDlxY1ZHeE5PVUZBK2tkVDFOREZGcFdQVUdNRjZ6UUVDNHNMUG1JbEQ2?=
 =?gb2312?B?a0FWZDVPaTZQMU4yL0FyN1RxU09CcFZqM1pqb3JnNUhiekR2UEdIYWRWZUZp?=
 =?gb2312?B?Y2VhNERNOGtOZVoyNHdlOHZzUEV4b0ZIR1lONGx2NEZKM3VsenZmYW16VkFY?=
 =?gb2312?B?S3JObFRSRVhnbzU2OG4yUlNmY0RWazFTRnhBNE1SbUxWM0VjeXlhdFNkWWNQ?=
 =?gb2312?B?dW9tU1FkbWlnQngwbEtuWmREKzVTbzN1cnR6d3hoeTBpOUdZdVErSmQ1TXZF?=
 =?gb2312?B?Qmp6cjlRemdXSy9kbWR5azRSY3JtdUNBa0hubGtzTlBSbEpPc3pZMjVESXJh?=
 =?gb2312?B?RU5XZUVzdFhTdEVhNThxSG1LVmY2SDJuSFRTN2ZhOXdGUXprVGwvdmFUL2Rv?=
 =?gb2312?B?SWpyd2NQQUtjYUpiSGl2TzJqNG9rWDNtRElxQmZJWnJGZTdxNUYrOTR4L0F3?=
 =?gb2312?B?WmJUM2FvenhyWlgvM1l2L3I4UXcvUW5PWXQ4SStKcUxiL3NHV1hPUHdGUEFv?=
 =?gb2312?B?SEthYUxOd0xETVQ2YmduSEd6cmJZMUVJbGNJbGYxdC9GMVkrQVdWNUhrYS90?=
 =?gb2312?B?TnFyWGhmMlJNYXdvNHRDSExlU09aTWZKZGVDNHRzRmdUN1VLbG10YVVYSlIx?=
 =?gb2312?B?MXlmemp0UVBtald4dG9CaU9WSm5NRENiM2NhK0JXSWFJQlRnR2xlZXZvZXVC?=
 =?gb2312?B?cGR5Vk5QMDd0OHhUbEV5Q2t5QVNZckQrQWJpMU5ET0ZBdGRCajFEeTFtck1E?=
 =?gb2312?B?eVFCRDQ4M3hSLzBURVdwQWZqWW0zdW9SRzd4dlpmcC93bEFCUXp5b0RMeXMz?=
 =?gb2312?B?b0ZjcnNhRU9jTWl6VE5JNE5mTHo2SFQ4NGJxUVlVMkgyQ25EQ0NGSUNHVkNB?=
 =?gb2312?B?WFZ5cnQyOEladlNKNTE0Z014VERpNFhGeC9ocjd3MVJGM3BiMTVhckYyMERt?=
 =?gb2312?B?NnZqNS82RS9lenhMYi9FY3VRdmRuWHMyU0xoK0lQN05HVzd2bDhodDdSSUtM?=
 =?gb2312?B?dVhwZ01rNjl2NThlcytKblJhUjNJR3l6ZTR3OVlKUnRSZWtMT3VnTEFSWEhw?=
 =?gb2312?B?bFdjQ2owM3k5cXA5SjFGNGQ2dWhKMjZYOFZ3Z3R0RnB1ZCtPbUZCSEF3Y2pH?=
 =?gb2312?B?ZGRtWDBwWG4zNjBJZWxFcGRCSEhlUGFyU1k1YWpxRVRkVUFKQUVZN3lrWDg0?=
 =?gb2312?B?S3JSbWN2bE5wdE55d21Sa3UvVkpNSWk3dzNBOFBYV1p6aytqVnFOU2RKRHQv?=
 =?gb2312?B?N0JVeVIvWEZjQ3AxRDJ0WTlaOHV6azNWc0lUQ3BzSzVPbTYyNWJ5TUd4VGUz?=
 =?gb2312?B?SUFWT2dCUHBVbEpWZHM4Z3VMSnFQa2JWWGVOVW9XcUp4WDQxRjJQa0VpT2VT?=
 =?gb2312?B?MmZVOHpMZXYweFNueWJIQm9Jcy95TkFCUCtrWmdOZWhHaE9qZUEydTl6dFlY?=
 =?gb2312?B?OHVZYUcydDYvMmVrdWpFZGhDU2xoL1pvZ1kxWkdablc3aFNPdzBLN2x2aHpF?=
 =?gb2312?B?SkdXeE9NR2NNV0JSMXFnRkI3KzUrWHF6ZEJCRmE5Rytpcmh4Q2tvQTJyVk4y?=
 =?gb2312?B?TUc4VFpPWG5uUEdrUVNOT3M2d0FEZUt5ekJ3TVpsY0I5bDVmTEZTT1YwL2hI?=
 =?gb2312?B?cy9WN2FBdWY4TjdkRnc4VkRqUWJzc0VNL1lOVXhZa0pDajFNbmFJN05yYk5J?=
 =?gb2312?B?SENZTzF5U0xqdnJHeWNkbEZZaDBaTGFOZ2FhRTNvQnQ5ajVYUWJPMDVLQnMy?=
 =?gb2312?B?cW9YZjNkdnpsMmZLV1o2VkZETnR2Vkowc3JHS2lWaXBYWnRxZ1BoeUZDVkkz?=
 =?gb2312?B?N2dhSExha0QzcERmeGhZS1phMFlWTklxR045ZlRrUlhhQnAzRzJvaXByVWZX?=
 =?gb2312?B?SXJweHJxaEZwZ0pUQUxGNVhNTUFadDNoeFFRUis3VGlCOVdRVG5BS1cvWjJH?=
 =?gb2312?B?enVzL1J1MlFQY3JsRTdRT2kvdndOalZKUUcvOFNSSzR0dDJrcHd0b1VXZC9G?=
 =?gb2312?B?eEE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec356f3c-1ecf-4e01-3a4d-08da6096b1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 04:02:37.1475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8UeMxNj4ryCvnjyb2NvQHFNLIz/xhSvalR6bFJ0OeaQMMiTMl64U8YaI/ATePr05IgZRwhjEy4OL2qCMLfUjg==
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

VGhlIGF0dHJpYnV0ZSBzaG93cyB0aGF0IHJ4ZSBkZXZpY2Ugc3VwcG9ydHMgUkRNQSBBdG9taWMg
V3JpdGUgb3BlcmF0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1
aml0c3UuY29tPg0KLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCB8
IDUgKysrKysNCiBpbmNsdWRlL3JkbWEvaWJfdmVyYnMuaCAgICAgICAgICAgICAgIHwgMSArDQog
aW5jbHVkZS91YXBpL3JkbWEvaWJfdXNlcl92ZXJicy5oICAgICB8IDIgKysNCiAzIGZpbGVzIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfcGFyYW0uaCBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3BhcmFt
LmgNCmluZGV4IDU2OGE3Y2JkMTNkNC4uMDU3OTZmNDAwN2NiIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfcGFyYW0uaA0KQEAgLTUxLDcgKzUxLDEyIEBAIGVudW0gcnhlX2RldmljZV9w
YXJhbSB7DQogCQkJCQl8IElCX0RFVklDRV9TUlFfUkVTSVpFDQogCQkJCQl8IElCX0RFVklDRV9N
RU1fTUdUX0VYVEVOU0lPTlMNCiAJCQkJCXwgSUJfREVWSUNFX01FTV9XSU5ET1cNCisjaWZkZWYg
Q09ORklHXzY0QklUDQorCQkJCQl8IElCX0RFVklDRV9NRU1fV0lORE9XX1RZUEVfMkINCisJCQkJ
CXwgSUJfREVWSUNFX0FUT01JQ19XUklURSwNCisjZWxzZQ0KIAkJCQkJfCBJQl9ERVZJQ0VfTUVN
X1dJTkRPV19UWVBFXzJCLA0KKyNlbmRpZiAvKiBDT05GSUdfNjRCSVQgKi8NCiAJUlhFX01BWF9T
R0UJCQk9IDMyLA0KIAlSWEVfTUFYX1dRRV9TSVpFCQk9IHNpemVvZihzdHJ1Y3QgcnhlX3NlbmRf
d3FlKSArDQogCQkJCQkgIHNpemVvZihzdHJ1Y3QgaWJfc2dlKSAqIFJYRV9NQVhfU0dFLA0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvcmRtYS9pYl92ZXJicy5oIGIvaW5jbHVkZS9yZG1hL2liX3ZlcmJz
LmgNCmluZGV4IDc4MzQyODVjODQ5OC4uYTUxOWMyZmY5NDlmIDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9yZG1hL2liX3ZlcmJzLmgNCisrKyBiL2luY2x1ZGUvcmRtYS9pYl92ZXJicy5oDQpAQCAtMjcw
LDYgKzI3MCw3IEBAIGVudW0gaWJfZGV2aWNlX2NhcF9mbGFncyB7DQogCS8qIFRoZSBkZXZpY2Ug
c3VwcG9ydHMgcGFkZGluZyBpbmNvbWluZyB3cml0ZXMgdG8gY2FjaGVsaW5lLiAqLw0KIAlJQl9E
RVZJQ0VfUENJX1dSSVRFX0VORF9QQURESU5HID0NCiAJCUlCX1VWRVJCU19ERVZJQ0VfUENJX1dS
SVRFX0VORF9QQURESU5HLA0KKwlJQl9ERVZJQ0VfQVRPTUlDX1dSSVRFID0gSUJfVVZFUkJTX0RF
VklDRV9BVE9NSUNfV1JJVEUsDQogfTsNCiANCiBlbnVtIGliX2tlcm5lbF9jYXBfZmxhZ3Mgew0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfdmVyYnMuaCBiL2luY2x1ZGUv
dWFwaS9yZG1hL2liX3VzZXJfdmVyYnMuaA0KaW5kZXggMTc1YWRlNzllMzU4Li40YTdkYmFiZjE3
OTIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3VhcGkvcmRtYS9pYl91c2VyX3ZlcmJzLmgNCisrKyBi
L2luY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfdmVyYnMuaA0KQEAgLTEzMzMsNiArMTMzMyw4IEBA
IGVudW0gaWJfdXZlcmJzX2RldmljZV9jYXBfZmxhZ3Mgew0KIAkvKiBEZXByZWNhdGVkLiBQbGVh
c2UgdXNlIElCX1VWRVJCU19SQVdfUEFDS0VUX0NBUF9TQ0FUVEVSX0ZDUy4gKi8NCiAJSUJfVVZF
UkJTX0RFVklDRV9SQVdfU0NBVFRFUl9GQ1MgPSAxVUxMIDw8IDM0LA0KIAlJQl9VVkVSQlNfREVW
SUNFX1BDSV9XUklURV9FTkRfUEFERElORyA9IDFVTEwgPDwgMzYsDQorCS8qIEF0b21pYyB3cml0
ZSBhdHRyaWJ1dGVzICovDQorCUlCX1VWRVJCU19ERVZJQ0VfQVRPTUlDX1dSSVRFID0gMVVMTCA8
PCA0MCwNCiB9Ow0KIA0KIGVudW0gaWJfdXZlcmJzX3Jhd19wYWNrZXRfY2FwcyB7DQotLSANCjIu
MzQuMQ0K
