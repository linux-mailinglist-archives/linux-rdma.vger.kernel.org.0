Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64D56281D
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 03:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiGABYX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 21:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGABYW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 21:24:22 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FA5A44A
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656638661; x=1688174661;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=/5EgeujSMyQ3WDPm/0mwGSZhblPMfiM2mlAky/kJyQM=;
  b=e6GRLF5Kp967ODS/dLnbd6twYtaWnqPKaBz0m4v183dSULoHGC83uuyy
   CfSZdyS/408f8S4qfbw9FNvGEbtYYMxu75puFswCWf+y9TqK5gBBl29mv
   thRYmsh1PsuWnxWOFhd2BwW93aK0RJ8Hnc8iM80CJzDStIZD924K9Eec/
   DdfuuV0S956qqpOk1vTkWKHyPPBSaleykeA3LxtH4pyfP9OIMBv6ZnPIh
   UOlCeWpEvQlcbIwXbrP081eMh/2CNDW7QtoNqys71/TWf4gTxFv7EZHuc
   rFxMBYSETxSFDAiSprVdyPZWK1eTxr+OzA0yEbthAPbar6B8/TNCsgVyF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="59526690"
X-IronPort-AV: E=Sophos;i="5.92,236,1650898800"; 
   d="scan'208";a="59526690"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 10:24:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcBqAC1O8nIfI/rPsuI7x23qMovlmCrL2mw5fj9tHnnykTxvEJ/SkZKJWj0AaMAm2dbboAVAJrp11QRxvUqbJxE2ClTXwu1mfAbgLs3lMV1PrBKJT3CErxGDU0aLTzICK/d1PKFUObKIABsgyGFnbGOA8lKwxg3GvEFZQ3vXnFH0zN5b8/m4b3CU8E95rRXlI6hTP28Blcw232AtKc3mE3vK9hTFXbyVMuRKwtGIlckWV/i8A3MQiof3F7QlBbKPx++I0FHyNFYJ+TWb83+m25XqgwswxpC68bxljPcmXidW2OMw/+raQlDlvKlXVLT/64242lQBrsa47dKBwikuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5EgeujSMyQ3WDPm/0mwGSZhblPMfiM2mlAky/kJyQM=;
 b=kORfaORq9p17hPl4KmP6DAnIarjC07vGkfM/miOSSFBhoE9M9V8bJR7CLZHeD8oyxzv8HNvh7a73jrgr26d2jzvyifRYaEP0ERdbO9OEYkocAesqPx79EgLOlJ3H2FyCskDs1BlyvCTqlZTA5MD/r9HDrx9b+6dYeFfiZFIoSG1nPti8/QxbOpvY5zufXgEKZ0vCwDkUf0YTKwqKO1QL0up6PSBlgr8BZ3uBTj6EMz7yenUNiHk1bQRcDP8tEK6dI9xaVZliYwuvkDRcfAWUYpNE+kVSmtmWZlqEXhLX7I6B3dH/15vlhNeX+BWyiTthH53H0PRNlEs8wKK/l8LsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5EgeujSMyQ3WDPm/0mwGSZhblPMfiM2mlAky/kJyQM=;
 b=nbdE/kw09CTra6p6q4WS5NJbaEBT8XZ0VWmtYELqz1GSN9tXFzrj5TEonWEtRfGwACS35Kl6dm+7OpBLiqZRHVpiMhlNGpu8jKdCoESvNUW50MIrMvt12/AhrU8Ckt93pboFCnr8ZtSt8Bk0qS/IDBbp/wpfEPQsSIz9RpIa/fA=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSZPR01MB8156.jpnprd01.prod.outlook.com (2603:1096:604:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 01:24:14 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 01:24:14 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2 9/9] RDMA/rxe: Replace __rxe_do_task by
 rxe_run_task
Thread-Topic: [PATCH for-next v2 9/9] RDMA/rxe: Replace __rxe_do_task by
 rxe_run_task
Thread-Index: AQHYjLR6aUoXE49xCUKrgxriqKHlga1ouSKA
Date:   Fri, 1 Jul 2022 01:24:14 +0000
Message-ID: <457ec61a-04a6-1132-e65c-6830b43e67f1@fujitsu.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
 <20220630190425.2251-10-rpearsonhpe@gmail.com>
In-Reply-To: <20220630190425.2251-10-rpearsonhpe@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2ff328f-d4b1-4aee-e5e0-08da5b0068fc
x-ms-traffictypediagnostic: OSZPR01MB8156:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0YfuxtR2ltxiekOat4PMmjnuPXxyQkQwOTGE3LaGC3QxLcodXyJ+XLC/DtEpMRXPDaSLhW0dEHmaRMb4aCCTm9KmOmdnZQNrsabexEIWg3Ub1OhfJ2mysqoJ0f+sy7UTGl6QlOeEK6rvquQs0Cc20sd+PQeDB68HGOtqIS3WdTvHd8XmbZ0duy15/Xw2uIj/uL9YpZ7vhA+di+bmqAU67BBUXIZwDBc8h9cQAvuAg+JKyc7TMzjGA2Xaos8tPQJb70iISNFlrhpnHAA0QNDcam0//lGaIKwMJKZ4aRMz/lhiOFmyrdvC5Zktzb/oWKTg9Sz3n7sxekw2QRE3wkSGB+nBGdb9ewc/hMzAS7OqDRzbMi0lk9Wlr6A8lMdvACojL2YsKrkzpZYjDV6gOsnPGpDYpT8Fup77VEL2oLSR3mhhB9+38TU+bERJxZ3kk7dr9RJsDzV+GDyV3Wkj1GWUerFGW7egvpbbNEM1fKR5J7WnSMMK9nlPOEd/rW98hD9Plfn6VTucs366xNHR8nZSMGebxplIjh/ntexZ9UtiNWGCQnR/xOhoPWWlH5OfZiZbgTR/bfqNR4ImsdWLThN3LaT5F61X2INs2z65eXB1yRv3WAeaymnmch+fYdJ4WbEXZpnC0C3L+WCoT96qNgnAFXuXk8CcdjSVBn1RjnwhBgsjI62EOjYNa8znM2yDaqUT+R5+TYEe65l49gl4vDhvi3UfDXpIfaw6t7YvB6SqgU8STgoYJC1Wqv6YIwR7dFazR5aEswIO+RcZSuMjvb69y0o5dbtTy36ur0h5mHYggZZhBl2dx4IrxeuTEjGYUTDd5RjxV4Jg4OvakgqrGIDvk0oW1LJIm8Svlh0SUv0HK/T6fdk4QAWqePz/Z/ii9dV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(2616005)(71200400001)(26005)(8676002)(6512007)(66476007)(66446008)(38070700005)(36756003)(53546011)(41300700001)(64756008)(31696002)(86362001)(31686004)(82960400001)(85182001)(66556008)(478600001)(122000001)(6486002)(8936002)(6506007)(66946007)(83380400001)(38100700002)(186003)(2906002)(316002)(110136005)(5660300002)(76116006)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUUwS1Vlb2pSdjhaVUNLVzBIVENzZ0FvWENEeFNuWUpSaTFMTWZUVEhOWkVH?=
 =?utf-8?B?Wmp4eGhzUVpJYnZnbkNONnpqQXBEUDZHdGxsdjF6Y0pocytjelVkeEl2KzNW?=
 =?utf-8?B?MkZpMkxGYnpLTitMU2NyU0NGMWZFREFlb1NQM2U1bzNNOGhucFFJclVPU1g5?=
 =?utf-8?B?UVVUVnRlSktLcUx3M1M2b0hXY3p0bGw1eTlxQWJ2eiszK1o1N1FFZWhleTA1?=
 =?utf-8?B?RkFRbHdCOENSOEYxZ2RyN1FsalF0Yjl2UGVSRVdQR2h6cWlST1JaZ0YwU1Jl?=
 =?utf-8?B?NXNiYWxkR0NPaHA5b2w3VjZpT213YmVIUDlIamNaMVI3N3BwUjJ5Umc5WXZB?=
 =?utf-8?B?VFVTYWRTZ25tSVBYeDhJRWNMN2FpNUxrbFZuNXB1c0k2Y0g4L0NxWlc5bkZV?=
 =?utf-8?B?MnMzbTZNQ2kvaE82ODZEaGZ0Z0Y2cHpOVEhNdFhUbjREbjRlSGx1YytaaGVt?=
 =?utf-8?B?WWNWdXM3ZkYvcWdTSzZkVXIwWEJzQXhDTUt4MUQ4eDJGUGcrL0d0U3NhUTcv?=
 =?utf-8?B?MzhmWUVmMTBtVkZNVDdlWXZCVzlSOC9tZHR4OEllb0pXMlZvRTFXR1ZQTW9P?=
 =?utf-8?B?cXR3TzJrUWVnQWMycnNFeW1WRnpHR3M1MVlRSjhOaW1pZUxHeDFKd1ZUVyt2?=
 =?utf-8?B?Qm01ZXJrZkZuazNhelJ5cy9laFhoTkE0Qk5aYnJUTHZETDR4eVUrbU14eVl0?=
 =?utf-8?B?dGRiSS8xNWxocDJRem02amZwYjI4UHYzS2prOWV3dHk5OTUxL2wzWVJHSXdV?=
 =?utf-8?B?eFpOWVpwWGliUGtMTmFpM2VWellhcndha2tCUG1GUVUzb1Y4b1FIb014V0tG?=
 =?utf-8?B?TVpwOTRSVjJjUHpqa0xReXB5Z0tkcndFU1NkWGN0QzlUdGFhTDBhZzdhdXlm?=
 =?utf-8?B?aSszY0hKUWoxbU9qU3cvNDBKb1RkYXhwejZFU3FVQWNoV0c0WE8rTlJJZ1JT?=
 =?utf-8?B?d0Q2SjgyZFJzMCtPN1F5WFppemxWMzB5Yk04V1Z5blk2b0ZNU3FqNE5jajNV?=
 =?utf-8?B?ZEk3THNsRlpnVWhGclhwWlY3eHBROHBkcDZLa0E3RE16T3Z6eHBScy9TbUdN?=
 =?utf-8?B?MUxLU0NnaU1NZFRRcHlQUnplcGUreGpJQmpuM1BiQ3V6MW9HeG5OTVVyK25v?=
 =?utf-8?B?SkxWQU5Dc045OHJhd2JhZE1tVDI3WEpsaGUyMWpCaVVQQkszUkd6RFFqUVJW?=
 =?utf-8?B?Nmp4L2NyYTRpWm9jOWVseFVlNFNMeHVmOXV2TlBRWWpYcEVIaEZHTWx6c2hF?=
 =?utf-8?B?KytaV1ZJSWNTMUorUjIwdFgzZ2JrdW5EU0FwNEdJbFlhbERBWEFabmNiQjBW?=
 =?utf-8?B?RGVTQ2UxaFpBTU9LRFRVcHBGTkFDa1gvMkt2dlArdjMrZjhVWlpLdVdJdTFW?=
 =?utf-8?B?aGs1cC9Ja0k4MjI4a1R5ZWRTZytHNlU1eWtQUmpvenlpT3pxZjd0d3N2WjF5?=
 =?utf-8?B?YmlSZ1pSdHg2c3N1dzNJRnJjNGJUQzNrYUR4UUFJeC9qSnpNc3BLTjZ3RmI0?=
 =?utf-8?B?QXNZZTVDSUNvdERiNzhkTDVSaHJBMTR2R0lMaWZDdEZ0OCtmZExNVHdFbkVP?=
 =?utf-8?B?bmpEeVpKdTZjTUduei9EN0YwY3puRkxHY04yUm9aRW1ZRzVqL2NobUFBdkhX?=
 =?utf-8?B?SnR3V3RDOWhQYWF4cHBvZnNRT2crNmI4VTI4Ri9wY3BVZjlBN0VtNExLRGMy?=
 =?utf-8?B?TitITUVmeFc4Nmo3SFZ2NU0wdm1MMXJMcytuS1FHbHRiOEtJZWV2dDFIa0dI?=
 =?utf-8?B?SS9RYnByckZBK05jMTRSWjRuaVVwblJtVGlnYkduQ1hhdkhPTVp4aTBjRitJ?=
 =?utf-8?B?ejYzMHhsaDhmejdJYVUxM0dPTmROckwxVGdOREJ4cFp6MFNlcTBLYUgrZ0JB?=
 =?utf-8?B?U2VDNzVvMU9aSWNZQXZoVTdyMXNCNzR6bFJmdTdiWXZ2TlR0NFpGTUN1NmVl?=
 =?utf-8?B?TjE1Umg3UThFRGxYV0RHSU5XcjJiWDBjc2tqa25icW95T0dtNm1GRkFpbVdC?=
 =?utf-8?B?YjNFZHFNcHdRczlCUzR0U3JoOGZweDI0RGRiLzdFZ3dIZnB5bTlPajkxTWk1?=
 =?utf-8?B?czVnT1dTUW9SWmNOSm4xNGZxQzBhVEROMkYxRUFLcW9iM210SnNzdzNSTzBs?=
 =?utf-8?B?L3l3VStrN2JwMzlXUDY5TVM3ZSt0bTZPdGVna3lmeklTcmZZYmZHTXJSamZl?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <309E6E7BE2014A4B8A7BF02405A6FA6F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ff328f-d4b1-4aee-e5e0-08da5b0068fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 01:24:14.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dU3mbBSp4Tz388tVFCs1JjJjDPAqwnZ5bpi4oI9rWM7JBxKxVv3SL0Z8gip8DgzQ2NtW3oKsaCCnBgL6s5uSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8156
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAxLzA3LzIwMjIgMDM6MDQsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBJbiByeGVfcmVx
LmMgcmVwbGFjZSBjYWxscyB0byBfX3J4ZV9kb190YXNrKCkgYnkgY2FsbHMgdG8NCj4gcnhlX3J1
bl90YXNrKC4uLCAwKS4gVXNpbmcgX19yeGVfZG9fdGFzayBpcyBhbiBlcnJvciBiZWNhdXNlDQo+
IHRoZSBjb21wbGV0ZXIgdGFza2xldCBpcyBub3QgZGVzaWduZWQgdG8gYmUgcmUtZW50cmFudCBh
bmQNCj4gX19yeGVfZG9fdGFzaygpIHNob3VsZCBvbmx5IGJlIGNhbGxlZCB3aGVuIGl0IGlzIGNs
ZWFyIHRoYXQNCj4gbm8gb25lIGVsc2UgY291bGQgYmUgY2FsbGluZyB0aGUgY29tcGxldGVyIHRh
c2tsZXQgYXMgaXMgdGhlDQo+IGNhc2UgaW4gcnhlX3FwLmMgd2hlcmUgdGhpcyBjYWxsIGlzIHVz
ZWQgaW4gc2FmZSBlbnZpcm9ubWVudHMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJvYiBQZWFyc29u
IDxycGVhcnNvbmhwZUBnbWFpbC5jb20+DQpMR1RN77yMDQoNClJldmlld2VkLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfcmVxLmMgfCA0ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9y
ZXEuYw0KPiBpbmRleCAwMDhhZTUxYzc1NjAuLjU4YjlmMTcwYjE4YiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gQEAgLTcyMyw3ICs3MjMsNyBAQCBpbnQgcnhlX3Jl
cXVlc3Rlcih2b2lkICphcmcpDQo+ICAgCQkJCQkJICAgICAgIHFwLT5yZXEud3FlX2luZGV4KTsN
Cj4gICAJCQl3cWUtPnN0YXRlID0gd3FlX3N0YXRlX2RvbmU7DQo+ICAgCQkJd3FlLT5zdGF0dXMg
PSBJQl9XQ19TVUNDRVNTOw0KPiAtCQkJX19yeGVfZG9fdGFzaygmcXAtPmNvbXAudGFzayk7DQo+
ICsJCQlyeGVfcnVuX3Rhc2soJnFwLT5jb21wLnRhc2ssIDApOw0KPiAgIAkJCWdvdG8gZG9uZTsN
Cj4gICAJCX0NCj4gICAJCXBheWxvYWQgPSBtdHU7DQo+IEBAIC04MDQsNyArODA0LDcgQEAgaW50
IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KPiAgIAlnb3RvIG91dDsNCj4gICBlcnI6DQo+ICAg
CXdxZS0+c3RhdGUgPSB3cWVfc3RhdGVfZXJyb3I7DQo+IC0JX19yeGVfZG9fdGFzaygmcXAtPmNv
bXAudGFzayk7DQo+ICsJcnhlX3J1bl90YXNrKCZxcC0+Y29tcC50YXNrLCAwKTsNCj4gICBleGl0
Og0KPiAgIAlyZXQgPSAtRUFHQUlOOw0KPiAgIG91dDoNCg==
