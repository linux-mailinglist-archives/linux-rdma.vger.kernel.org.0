Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6AB4B9732
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 04:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiBQDuY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 22:50:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiBQDuX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 22:50:23 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A37C0506
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 19:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1645069810; x=1676605810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MLJesffugEytVfkxJ2UfCuElAjgwb4QvxY3wk0uUOwM=;
  b=OK/GgCeSj15P7kKJArmeFiqO+DV9fQgYTJuCKo0KU5OcnM/qCe6E8LJd
   Aol4ayrp6auVqyYqnboRKnO2mLw0BfRnIENTrUdGlvxLYmG/MCuNqIBjp
   9bR5DxPEMNRcDDnfY9QwDQn+fBkVJ4gz44q2V7lKJ+u6H32Mozl+nTb7W
   mWR3HGMNQseuIAwXRD7fuzwMLPWqlmfP4/uVyT4YulPGXxNRUj7F5IsYe
   5w43rwuIp8R5XUvx3zKhoQpEycGeffWxcPAmbeDNkZh95DrIclQ9ebst0
   d2DVx/3l5CefR5Qemb4xeCb/39yxU/Bvc7f6qbJ8R47jrnu5umr79dE3w
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="49975051"
X-IronPort-AV: E=Sophos;i="5.88,374,1635174000"; 
   d="scan'208";a="49975051"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 12:50:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr+t2lnfoMbqkxo9Jzws4Pm9bdMfJjuMYaXfpZikU3BvTJyA2Tjxcfex36VSlVR07sqAVi8Iv4NGrK8GIdiqxSU3vAT99hUyA1KYeXq/SbEF93v4kDM0Upq4v0cFZo+y/Nhq1Yb2+as+brYFNKSrioWbOv4zfD9V+xVYePlFLRJUaHQGuBILY0hM29oh2pplWkiqx0lhT4+Ne3r+fjszx1eeAnwnU6UvOtAt97t3pZaXqWVhIS6uJ4on01z5FXFwp7ZF1XJcTBxgxbTtLz9LCsc3CfsGFyhDqsTCSZ3+yAHTMBhGMv0DqeanruTrlJHglsQkb33AY7mmmSHuy9VnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLJesffugEytVfkxJ2UfCuElAjgwb4QvxY3wk0uUOwM=;
 b=M7r/uw0tEOhB//h59ios4wqsCbmk2t2pRMJE7iJ0Dl+V6jf0r9Cv/hRySy4M1mk4v7QtEn1pKrQIy2jntY1FFe52OCL8ZIWOdodJkfIjRgPPYEZuaqONh+yt2YaZBOII87BMRK/jD/ep5yLXKfJD6TcGflD9yRPuNnLEGHN/84xL894PELgLZ2aZg/mAAGFolmtaycdZ9/XaKQ68WFS+5SX7dqqYrfQ0RSiIyEErpXugoVacz/LBrjIII3acORmJb4/miZuaZDxrx/2pWjmHBSbp4QImWD5HPni8PXQZi/ECFY/3MLAz2yLQSaGqQrsUIfutE/vVb+aaOwrR+CZenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLJesffugEytVfkxJ2UfCuElAjgwb4QvxY3wk0uUOwM=;
 b=hBGUAJEIGC38zgcyD9zOKYUJUEeEgm66qflh1qCHfwGRcbvQngDW8/rpYjz6k1Cpw0oHuAKRQeT93K7fXQ+7wU8GzCaQ524ksnWkSwf1XggUyYdenZnFpLL2timvL2xQ7FvkKwzwNtcbCprCMNkWf0xnS4GEhbBUUbPRg2QdcCg=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS0PR01MB5700.jpnprd01.prod.outlook.com (2603:1096:604:bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Thu, 17 Feb
 2022 03:50:02 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 03:50:02 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbrMyXFTG4iC0uvkiFLA5nCQayXZ/OA
Date:   Thu, 17 Feb 2022 03:50:02 +0000
Message-ID: <e372156a-2859-f43d-6862-96cb4470a614@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
In-Reply-To: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c87a15ce-ef65-4d05-82bc-08d9f1c893ae
x-ms-traffictypediagnostic: OS0PR01MB5700:EE_
x-microsoft-antispam-prvs: <OS0PR01MB57005795D476FC4CD19AC2A883369@OS0PR01MB5700.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gTLCxhqC/6c3p/Hj2sWxPjW+m5QfW6EWXRZg0Vs7tQi8geSOEzLDFwCebMuDv0OFF3h/WW9sxZrgtT09eRqt6qHwaxya3DGViZZKX5SDS/Iw+pJPgrwe/0c/FRkPvvXt6LtVsmjDhq4eZXSwydiEXIXM/YCHGlL63tHMBh4Btp7hSa7jnp2grM/v5BGntuINXHY5/KxTL8YdufP1wqNVXRZRpCTkrYi1EgvTXzArgoNDh9fxtMHRZiaiiQssZ5khNxqhk9NIzBdRZxo/IsZcmF9QX777XuHQcd5aHFUbMvk8qCoQ2DdaUJ9Bi75mZtIPa5Lal4sbK93QA6sPws3nMDUg85U8ZV2e4h2Hvx5wBFXSPmMH7CCfB4R93AnjPzlHsv4rAcbPizi1/FDFkGgpbGq9FLM+4atLU2MvIJR5+d9J0++/lZ1DULKFKnevfE5VyWHCL2dvjPtIS9xzgaIxQWGPuF6YzbCgpKQzaNA3q0fnPc+M6TY+a3kWNJEw6aNgKvbTrrfd2h7LzRKFt7hZjEPhi8yiVc/6Oc6Dyh11DV4R66HBp3WXsVnI2380MhmhdrDjzXIfkFy4rCzOca64xtCIT0tUEzqQ+4B18LJbsaSas1A0qUGSMSReTWhYQeegtm4m3FiXIx7BrAfrSmaugLn8kVcowcaSgDflb7sw+Ka9kFuwhpjiDxKg16upfxnOsKcz2CjjcsvQnQ0rB564DiET0/M7ok3ezu844R/IFlna4QicSYySnhQQoqOKtkEfplfdOYp+us1F5zJRdd5v/S0ZuwfUz4+YRq3DQsbpf/DM8FVJRWH+nCOK+xYH8jCNOA9cAUql5dZbz5QWjItQ3Y1yxNOJrJHfJEeFo2NbFgZfsEr/aq0o01jxC+v9BBoHSm5//7EVrZby3/3h+FwiAgxtuu1qnsoDOrSr/ro8p0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(64756008)(66556008)(66476007)(186003)(26005)(86362001)(71200400001)(316002)(91956017)(76116006)(66446008)(6512007)(6506007)(8936002)(110136005)(508600001)(2616005)(54906003)(966005)(31696002)(6486002)(5660300002)(82960400001)(53546011)(31686004)(83380400001)(85182001)(36756003)(2906002)(8676002)(122000001)(38070700005)(4326008)(38100700002)(43620500001)(15398625002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUV0TUlpOHZGMEZoZlVnOW1TSXJYdzZWTGNBRnppVzBNQ3Z0czRadlJyb0l2?=
 =?utf-8?B?Q0NiQkxaUU9uY1NTNUN5bjNla3NhL1ZKZ2tKaS9tc3dvWHdHc0ZWTkRDbXZz?=
 =?utf-8?B?YThJV09BbXJzMnlhMllxaGtQbXBlS04vekkxMmtEMjY5QzBtendtbGJSTG1M?=
 =?utf-8?B?TG1Jd1o2K1E0QzV3bi9idzYrYUxJVElYeGo1ZjM0YWY4TnpoblZRVnBzUmRy?=
 =?utf-8?B?VzAxNUNnZHZ6NVhNMnh5bVA2YzBYdVd3MWtjYVBJY2J1QnlXNm4vUE9WODF1?=
 =?utf-8?B?Z3I5OHFPM29BbGxyb3NMMURieGpyNVEzdWJ3RmVJbklhVnI0V1doUmxvWk0v?=
 =?utf-8?B?QndZdWtGNXhyZXJndHBnQk1DcmV6VXF1RVo3aGNRenNUS3RGOXRSQzlsclox?=
 =?utf-8?B?emg5cW53VjIrWTJEa25CaTRScjEydVJvNDVxVTJoT1FDWUhTYUdWRDFZeUgw?=
 =?utf-8?B?WE5wMUJDbnJITzdXNGthSTRHMUR3OXhTbEwzRFVJRUNHbFJxTlU2ZWlKT3dy?=
 =?utf-8?B?bVZiLzhrU1QrWVBkaU9NRXRMMk9qS2gxd3FiV0VTTzJHZ2NTWVpCRmJGREV2?=
 =?utf-8?B?dU4zN2xmZlZIOG45bW9NTzc3ZDl3bFp5N2FESXRkM3BRRUJLZzRUYWwwWHF4?=
 =?utf-8?B?TmtSc25xNnBTZEFqS0lpWnkrWkN4bEdEcUFjcnJxeXIxVnV5SDBYQm9zY3pS?=
 =?utf-8?B?SkI5K1VUWldpaFJOdjZla0tLbDZHb1c2Z0VFQkRuNXRSUGk4MjJ0alJrMnJ1?=
 =?utf-8?B?Q2lHVzJCVGZpbmF2YWoyYTZZVDVpd2VJU1ltNmUwWmtwZnlkNCtCZHA0OWk4?=
 =?utf-8?B?d3UyOGRaR2xrVjBwQ0o0OEM1L2ZScGJ6Q0d6Z3lUbFBwM2llSWNDeEhFeURo?=
 =?utf-8?B?SEdmcFk2ZVlDQUFRZ1hEWWhrQXArSXJCVmVDUC9QS2RjZDdBMVBwM2ZqNXRW?=
 =?utf-8?B?R1NQdXdiMVZBYlRQclBROEozcGlENUhWUHBycGs4NzErVHpPWnNpUWE1RzlE?=
 =?utf-8?B?NmtjZmJHTUhHMlJiZmJsZENvdEc5UzRFaUh0MFNQS1p5WklTdjhCNmlGNE1k?=
 =?utf-8?B?VWtmMTR3bXNwUGRiRFozQVljNElsQ2xVNlRVeXdIZ2lRQU42RkRVWFpNS0o0?=
 =?utf-8?B?RVM1V1BVNURGb1daVjc5QW8vc2gzN2hzWm9GdTNkcmlmbHd5eEcrTUpiM0g3?=
 =?utf-8?B?alQ3NUdOWnczdWk5MUVMWDZ6NFFHcGpkR1liZ2tRcXlDOVoxTkxSdGNmcEpa?=
 =?utf-8?B?NVFiRC9oV2lxZjFCeEhIc3phUStYQzlXQmsyS0c2cUIySTZBbzFzMlJldFho?=
 =?utf-8?B?eG0rU2xJQmlxV3lQd01RZ3Ira0V4NVpydDc4dE5PWUpLckJFMHhXZ0daYUVV?=
 =?utf-8?B?N3FSL0dVSHBpUnE2YldCZFJvL3hlcXpkbXpaVEI4TEFna1Q3SXl1c1JRdks0?=
 =?utf-8?B?cDllUjVNYUUwcGMwNmlPalh6dXFqdTVuRHhZKzZRVEF5NHJNaGFQMXRIcEx6?=
 =?utf-8?B?QkNRUkc3UkRNamc3QjNPcVJLdnVtRmNIcngvdzdMdEY4WU91VEt3c3dhcEk0?=
 =?utf-8?B?ME1kY3JYNlljelhFTWR1SWZMbGhzZkZWck9HcEh6S3p4azAzQ0ZaQXQ4b1k4?=
 =?utf-8?B?SzdHdWpmUEdKYnByZHNHQ1FjUWNkNDIrVmFJd2V6NWMrdkUxdE1tSXptamVG?=
 =?utf-8?B?VnMvRndPaVVJWDJFa3M2NEpzNllmTDVleUdVRDhLN1pmVDhBN1pxN0xzemVE?=
 =?utf-8?B?NWE4RTZ4NVZmL3BUY2tmdWxGSjlYekd4Ymw1NnlvbjJ1Mi9FZHBha3NyYjJa?=
 =?utf-8?B?MlBXYXNtOENTbVBhaFJucEpSYVAwbCs4d1puZHhKZ2lzRWI5aXNDa2psdVRx?=
 =?utf-8?B?Yis3WWpSSWJ3RGs2VTNqakQ2eHBPV1N6NjY1RVlaYVhGL2YybURBM1djMG13?=
 =?utf-8?B?Y2VyK1NuM1ZQYXFaY1hNM0RQTHNZTkh6WTI5SHlISXJGYkVuSnllSm1oWUlL?=
 =?utf-8?B?NW5LRHdXV3pTSU9BSFFWS2s3MEhMYlhleFhuWi8yd1JsTm9BWmZYNjUwZ2dm?=
 =?utf-8?B?N3dhWXZFYWxWN0xGczd0WG5Jci9QUzRDL3E5VHFyYXcyVmt6eGpic256czJU?=
 =?utf-8?B?dXE4SW92NFFqL2F2bFJCNGNaOWNRQThSR0hLM01qUzFDNVFXSnNXeEVqWnBD?=
 =?utf-8?Q?QrJiVfACRia6TFy8ZmzfOw4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <458D80783115C9439D7CF8E4D6F40B8A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87a15ce-ef65-4d05-82bc-08d9f1c893ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 03:50:02.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Mqo7fLp2Z7Fp1EMc2rQCsjBZKU0B8ZaQAfPImCp78uyQkJI33okz/9/eSLux2GXnFczN6/ec6dnwOjKWcTP7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5700
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS8xMi8zMCAyMDoxNCwgWGlhbyBZYW5nIHdyb3RlOg0KPiBUaGUgSUIgU1BFQyB2MS41
WzFdWzJdIGFkZGVkIG5ldyBSRE1BIG9wZXJhdGlvbnMgKEF0b21pYyBXcml0ZSBhbmQgRmx1c2gp
Lg0KPiBUaGlzIHBhdGNoc2V0IG1ha2VzIFNvZnRSb0NFIHN1cHBvcnQgbmV3IFJETUEgQXRvbWlj
IFdyaXRlIG9uIFJDIHNlcnZpY2UuDQo+DQo+IEkgYWRkZWQgUkRNQSBBdG9taWMgV3JpdGUgQVBJ
IGFuZCBhIHJkbWFfYXRvbWljX3dyaXRlIGV4YW1wbGUgb24gbXkNCj4gcmRtYS1jb3JlIHJlcG9z
aXRvcnlbM10uICBZb3UgY2FuIHZlcmlmeSB0aGUgcGF0Y2hzZXQgYnkgYnVpbGRpbmcgYW5kDQo+
IHJ1bm5pbmcgdGhlIHJkbWFfYXRvbWljX3dyaXRlIGV4YW1wbGUuDQo+IHNlcnZlcjoNCj4gJCAu
L3JkbWFfYXRvbWljX3dyaXRlX3NlcnZlciAtcyBbc2VydmVyX2FkZHJlc3NdIC1wIFtwb3J0X251
bWJlcl0NCj4gY2xpZW50Og0KPiAkIC4vcmRtYV9hdG9taWNfd3JpdGVfY2xpZW50IC1zIFtzZXJ2
ZXJfYWRkcmVzc10gLXAgW3BvcnRfbnVtYmVyXQ0KDQpIaSBMZW9uLA0KDQpEbyB5b3UgdGhpbmsg
d2hlbiBJIHNob3VsZCBwb3N0IHRoZSB1c2Vyc3BhY2UgcGF0Y2hzZXQgdG8gcmRtYS1jb3JlPw0K
DQpJJ20gbm90IHN1cmUgaWYgSSBzaG91bGQgcG9zdCBpdCB0byByZG1hLWNvcmUgYXMgYSBQUiB1
bnRpbCB0aGUga2VybmVsIA0KcGF0Y2hzZXQgaXMgbWVyZ2VkPw0KDQpCZXN0IFJlZ2FyZHMsDQoN
ClhpYW8gWWFuZw0KDQo+DQo+IFsxXTogaHR0cHM6Ly93d3cuaW5maW5pYmFuZHRhLm9yZy9pYnRh
LXNwZWNpZmljYXRpb24vICMgbG9naW4gcmVxdWlyZWQNCj4gWzJdOiBodHRwczovL3d3dy5pbmZp
bmliYW5kdGEub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDIxLzA4L0lCVEEtT3ZlcnZpZXctb2Yt
SUJUQS1Wb2x1bWUtMS1SZWxlYXNlLTEuNS1hbmQtTVBFLTIwMjEtMDgtMTctU2VjdXJlLnBwdHgN
Cj4gWzNdOiBodHRwczovL2dpdGh1Yi5jb20veWFuZ3gtankvcmRtYS1jb3JlDQo+DQo+IEJUVzog
VGhpcyBwYXRjaHNldCBhbHNvIG5lZWRzIHRoZSBmb2xsb3dpbmcgZml4Lg0KPiBodHRwczovL3d3
dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1yZG1hL21zZzEwNzgzOC5odG1sDQo+DQo+IFhpYW8g
WWFuZyAoMik6DQo+ICAgIFJETUEvcnhlOiBSZW5hbWUgc2VuZF9hdG9taWNfYWNrKCkgYW5kIGF0
b21pYyBtZW1iZXIgb2Ygc3RydWN0DQo+ICAgICAgcmVzcF9yZXMNCj4gICAgUkRNQS9yeGU6IEFk
ZCBSRE1BIEF0b21pYyBXcml0ZSBvcGVyYXRpb24NCj4NCj4gICBkcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9jb21wLmMgICB8ICA0ICsrDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfb3Bjb2RlLmMgfCAxOCArKysrKysrKw0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX29wY29kZS5oIHwgIDMgKysNCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9xcC5jICAgICB8ICA1ICsrLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
cS5jICAgIHwgMTAgKysrLS0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNw
LmMgICB8IDU5ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAgZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfdmVyYnMuaCAgfCAgMiArLQ0KPiAgIGluY2x1ZGUvcmRtYS9pYl9wYWNr
LmggICAgICAgICAgICAgICAgIHwgIDIgKw0KPiAgIGluY2x1ZGUvcmRtYS9pYl92ZXJicy5oICAg
ICAgICAgICAgICAgIHwgIDIgKw0KPiAgIGluY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfdmVyYnMu
aCAgICAgIHwgIDIgKw0KPiAgIDEwIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDE5
IGRlbGV0aW9ucygtKQ0KPg==
