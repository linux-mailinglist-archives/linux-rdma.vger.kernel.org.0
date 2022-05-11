Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E4522E88
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243776AbiEKIhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 May 2022 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243742AbiEKIhQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 May 2022 04:37:16 -0400
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 01:37:15 PDT
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D64E6830A;
        Wed, 11 May 2022 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652258236; x=1683794236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7QXlO34nyUB0HWrlRz9bF3t/qLQE/+JfxnGLm6u97X0=;
  b=OaiW/mnYG4koyxchi0KelUefqKbUpGYhq1TArjmbAj6FGwllaMAQUtgn
   fhxUFtwB8gJsZEp5thfhqTy1x1Ks74pc6F8/4+GlaoxjWIp3i/cIHCoyw
   JyUe90AEHsqZKKpwWmGQApDWSGaMSHXtnL9/8igycL/Fm8xR6+B9c6bl3
   wdmMYkgtXdHu7qleOf2OqWTosP7wDbUVuM28OMAbQwZqxZteAVKADgNR5
   cIpAdpQ9Tkkt3y1hBvB4FXCPs9yheA5vmy7LsY8PV2AKj/RlvofGyCUjT
   LSbhzyuSaxGDbss1Gzx4a054RzJT6pHMFw/b+DOXwqY0J+6dnSwEOlobL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="55250351"
X-IronPort-AV: E=Sophos;i="5.91,216,1647270000"; 
   d="scan'208";a="55250351"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:36:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEvxGc+O9HfPO2QrNcCndyCASCg/YCa+TZHMIZr2GjNJjGdtd8hjZIblzMu3S8pRNH8I526jmKUM7pEkjYNoKTL8c+Yk6iyZWnwz/xbCH/Na9uV104wIM5EjavdAgGPnyx2WW91NjIpZ8jdfZ1jYbcYN3Bm+YCJRZL3LoUbgo1Ycdd077hZ0cj/itBZItvOkCx16xAvv0UMWzYZoWlDb+Tvh8SY7yriy3k+D8ist9niZCqZKL5tdUxXvS46XTNpf4/Vpyo42nSVWu9vpxT9XZ2anZu42c9el9zMUhubemQV6vG2pJGkx1If+DI9vigSYa+PseNt4P4qI2W9caRhBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QXlO34nyUB0HWrlRz9bF3t/qLQE/+JfxnGLm6u97X0=;
 b=PWmr8KpdAfBQTS26zBOAYIRoevevUaGLi7BJ5SnX07Vgb2l0ZqrcWEl5XaeuBxCwD8mRBRTWWNA9ZANrVvzWB/TVqjEqpA7fI+tUFxEnKXWvd3KAXPX/6AxTiOQ5n4evXD6wJX74/faYwCvzKVSQfJgMG5amlkMJCuU7dNgG5did70/D6uDG3YBMnLY4VBaJyGdzi0kIlVRvaVgR9Gt4fgsHBj9CYJUtV0thr7moDb0l4WgbHIOXorI3H7uObMGnO0NdV0yFGzmAMYrMvXCpQyHv3zjXNDhBk3wUzP8X7vHGHHSZjboG3J8upBTiyX7Iju7iygw0UcMVgvPxx0dp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QXlO34nyUB0HWrlRz9bF3t/qLQE/+JfxnGLm6u97X0=;
 b=TORsfMR4uhhyqrEphBIAnavn124J6LnYVQaaXP7PI0SEhB2DOyWGttVy+/H6m0UVTtSDyasmXxHlBp/kj4ndtpULrBV+4KqE7VwlDAsnF6HB7jXvs7a0fV/bAYL++Zjy/eOHylldilv/pB1iJK6kqJJ67GLYmJST449QEcAja0k=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB1816.jpnprd01.prod.outlook.com (2603:1096:603:1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 08:36:01 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::4d8b:e42e:b970:99f2]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::4d8b:e42e:b970:99f2%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:36:01 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Generate error completion for error
 requester state
Thread-Topic: [PATCH v2 2/2] RDMA/rxe: Generate error completion for error
 requester state
Thread-Index: AQHYZN4aR9/YgOvEMUWoriI9WXlXma0ZCP+AgABRR4A=
Date:   Wed, 11 May 2022 08:36:01 +0000
Message-ID: <0eb4cdcb-4d9b-18a6-a030-59bb2b359c2e@fujitsu.com>
References: <20220511023030.229212-1-lizhijian@fujitsu.com>
 <20220511023030.229212-3-lizhijian@fujitsu.com>
 <b37c53a7-86df-0283-1a77-c31af108d39f@linux.alibaba.com>
In-Reply-To: <b37c53a7-86df-0283-1a77-c31af108d39f@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a1da617-24d5-4dcd-02c5-08da332947b5
x-ms-traffictypediagnostic: OSBPR01MB1816:EE_
x-microsoft-antispam-prvs: <OSBPR01MB181614DFCA9A7C99F9F816F2A5C89@OSBPR01MB1816.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lpnPdEd7gAqRL6Gme6G8bZ7v0pSzgDk4rM5vZ9h8nHlmvp9Ld+xyB6XPkEEu9VQIGIrxWye8A4SXw8K5XcitRV0lUpALKmVQaHnQBrRH1ylf89J0NAp7QZUrvFXyYR1AwvALqZVqWWeqb5+Wh2wX+gfjwlmzFBSHuIIBsfpZ0YDkyCN2bck1+E5KZ/ME5HSnw1jLZst1kOX6NzVLJewWKnSExmWW85E6990rKY/5TNY69f7l70pM4vo7MxuZtDPasOXV3xaq9MVrNLTcx4GKX6tRjjFl24Z2xPhvYkZ+cmwi/wCLnaatIHTAAAWuLl53N30WVayYXFc6E+u633Ja5fbUr3AGYlubqjCjnA+wS+e12WPYUfvmRXPatQxylIc2/0sRc3MQJl4kLj6uQF11gas0gTCef9qI7PlNscBr5aMFLE7B0oDXzXmPknmI7+isjuFkbiSITvMAneo6b2qGTDhdG4CYyyVonKyNA/Tbb7h5prxlEQj0dhvlfqKVQuCQra/WL2UEqAL3AGI8iSM5fp/8qTi6A0PcUGdAcjzQM8ZgWMWWiQ/l2LC+wxecYRu3aru64THCq9v+py0X9bwqFGU0Ip4TXIUs0XdMVaJVEVrNXkdTMfGxAEGG5JrcEPKMiC7VJtWqDw7ixNeRaN+QeMtvdwJOhAnkkz+oWncjugO6le4Kx8+pSAV0SsRVvHt6vVfMEv9zsGZGpeBkt9h3xPCVbra+ZtQ6TOF+pTOLHDndS9UMUOdQbtzM1yL5cfp7dmvuFHQjDHGoZAC6beVyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2616005)(85182001)(71200400001)(6506007)(86362001)(53546011)(36756003)(38100700002)(38070700005)(64756008)(66476007)(66946007)(76116006)(316002)(110136005)(66446008)(66556008)(91956017)(8676002)(4326008)(31686004)(83380400001)(2906002)(508600001)(82960400001)(122000001)(6486002)(5660300002)(31696002)(6512007)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEhyWmpONHQvOUhranY1cVBKZVdVYlQyN0xDd1Y3OHdXa2kvUThScVNxa1BN?=
 =?utf-8?B?WFNCVytzMzhXT0hxK25WcHh2bnZWdUNteUF5QXJqUnRzcXN3OWpHdVRCQUZm?=
 =?utf-8?B?eU40NTVTWVIzem1aNUc4RFUwREM2cWQ1VGFGSVR0d1FCWTFZeEJabUtEVVli?=
 =?utf-8?B?VDZsOVQxY3NzL1ZJYXd5RzMxNUZQeU9mdjNiaVlxcDNkNjNCQnpUakhFbDJ6?=
 =?utf-8?B?T3d1L1VKUjlSZmRibENjcnlHdURBa095L1hvMXBGWmd2ZzdUdmFoWE9PbmVT?=
 =?utf-8?B?eVZhd0FrQTVoZUtGTjJCZXJ4VGVWWVBjbnBxYXJDSms1N2hwb2tnaEh2UUhv?=
 =?utf-8?B?SlpGZjEvR3Y4QzJvS05EdkRROUdMSCs0Y2VZcmRuaThrQUNVZVMvckJUd0I3?=
 =?utf-8?B?WFQ4Q1doYUlEdnpTVFVHMHJ6TmFpZDRLWGRvcDJUbUJKZHUyeFFBQ09VRGZ4?=
 =?utf-8?B?S1A1YnRjQ1h3d3haaEtmSTE5dWpTSE0rWWVTUGIrdG9xOXJTVitCVkh4QXBy?=
 =?utf-8?B?U0NUSmk2Z1hhanpHOE9nZTVoWmFGZlZtVEFZU3JqajY2aDNEWWNXK1IxL0tw?=
 =?utf-8?B?SHE1LzQ5ajVpdkF4UmVWaEFZemJ3MWFMak04bnB4eE1CM1cyVGl2dzJXSFly?=
 =?utf-8?B?bno3UDhjbVQvQ1Nha29tY2E2YVVjV1dmOEhhSkNxNEg5OUNHOWUwMG5QTXFL?=
 =?utf-8?B?NFhObEM3N3BlbnZaQ1VkeXdaL1hjUFdiUjhCVEVmcys2VUNZNGJ1aTJZelVo?=
 =?utf-8?B?cEJmV2xveTdWZ1FvaVNpYmo1NllMSWsyemZ4WW9xTnVDaW1tNEZtOTY3ZGlL?=
 =?utf-8?B?TGROeHZZMUFvSVJGRlJBVlRyWVFON2xLc1FKWGd2NW5UdlMyY1phb0V1eHYx?=
 =?utf-8?B?akpvWVhaK2M2OUM2RUQ5RHgrcDZQRXUzc1hWdWlVRlVVYzBVRU51TWNvWUp2?=
 =?utf-8?B?K0NOaTFIcWpyejhVWW1GVzVEZjJVaDcyYzlDZTZBWXpGaWxnK3lHV0hMS0Vx?=
 =?utf-8?B?ZUY0MVFXQVZzY0EvMkJPcnlNTk5VczlrV01HNSs5NEt4WHdnSnVGU2lEZk1X?=
 =?utf-8?B?QVVMZStEK1FjU2x5Z0MvYnFtdVBXY3dsVklWdVdSTVpGZzhUdVVqbHFMUHlV?=
 =?utf-8?B?V1BQcG1kVUEvc3h0MkRuVCtvKzFYTGpIVG1mLzFNckxlWDdlWjFmZlUwcjJO?=
 =?utf-8?B?RmpUYmtLZWtFa24wdWlMUzdKYk9PNEJMblBVN21zSjRiQyszbTlSVkcrc3Bn?=
 =?utf-8?B?VXY4cFQrLytndWRKaitMbDZSaW1wUFh4czByNVRaUWZoYWdVTVYrN0pnS01w?=
 =?utf-8?B?VURlcnRrN1NWRzB5WXNPOWt6TFdObFBPWHVFa3o2TmkvVEVCZkpEZGlRWS9S?=
 =?utf-8?B?OFNiZkNUcDRGUTBJV3l6b0dKWVpxQzlWWTNneUFhM0pGd1RVSVdUamU4RVVY?=
 =?utf-8?B?emUzOUplQzhvQjVmcTRJaE9YM3p5MC9rVkk1RWozQUFYTlJjTFJmbXl1eTVD?=
 =?utf-8?B?aVJUQ1k1UyszajFqa0VLbklZNDc4M2psZmlJQnZpQWdBQkM2b3BDOGE3WVFr?=
 =?utf-8?B?c2tVeS9wN3BlNDhUNm9RYWVWL1ZNOEZ2cERNMkQrWkVvVXNUQkF3VUg1QTRQ?=
 =?utf-8?B?cmNqWWt6Mm5sd1M3WDdIYno5S09Lem8xL3pST1piOUY3UDQrMjIxS3c1TGZV?=
 =?utf-8?B?ZTZKZW0vYlc1cS8za3RVc2ZURjBvTWhzSG0wWUxGNHl5cHhtSmxBa2ZUWXNX?=
 =?utf-8?B?NkIwc2Y1cE4wNlZTamFBSThxa0RWQTBXUG9ZWmRGKy8vd3MvL1hhTDUyT2NL?=
 =?utf-8?B?RHl0NG4xODFzMld3MWZqb3Z4aTRTVEZLV3ViZWJtRStGQnNSUVAxSXEyVU83?=
 =?utf-8?B?UHkzeENVY214LzF6T1lkNkVPeTNRVVhWaDdVYVBKM0pIemlIVS9jMDRIZVZs?=
 =?utf-8?B?b1hHQ1lvNEdnd2dtR0JramdOcnNmQXg4b29UYmxLWERmenk4RktpQ0RLMytu?=
 =?utf-8?B?T1AvaDlGZFFPS1Z2N0JOTzRxYjk3S0ZxQXNnWTBZS3M0VnY5Y1VtMml4Wi9q?=
 =?utf-8?B?RGtUZTA4Nm9TNHFiZWJTMkZsVEdBbWUyZVQ3Zi9GYndjUC9keUhoZDlsK2h0?=
 =?utf-8?B?NTQwZ3lxN2hJdFVKVlpEb2Y3K2tNV0VNMWIrbWFpVDlRWXhudlVST1lnM1lP?=
 =?utf-8?B?MlV6eEtmL0lwaWVhNEJsM2UyeS91cTJuWmFPZklOT1BrMTN3d1k0OUJac1M5?=
 =?utf-8?B?TkpRR1M2VU5xNnZKczM4Nmh0NmZZZXJFeE5qUC9FVEhpaUh3c2dpOVN1SGdm?=
 =?utf-8?B?NzBLb0haQVQ5aThWeVV3VGNhVUNNbWNDV29BVVFlczMrd0dCSldMS0pJczdl?=
 =?utf-8?Q?uc4Tas0gleYx10mM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4648949A337E904E93342B86953E69A6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1da617-24d5-4dcd-02c5-08da332947b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 08:36:01.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+NFvXD64BH7oKwJPLi0agFDxiVJONcomIkR8V+uTdwVGMec9+E6k2GjfbieWCIUFLCP5si0rFd4UXaRXmHvbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1816
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzA1LzIwMjIgMTE6NDQsIENoZW5nIFh1IHdyb3RlOg0KPg0KPg0KPiBPbiA1LzEx
LzIyIDEwOjMwIEFNLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gU29mdFJvQ0UgYWx3YXlzIHJldHVy
bnMgc3VjY2VzcyB3aGVuIHVzZXIgc3BhY2UgaXMgcG9zdGluZyBhIG5ldyB3cWUgd2hlcmUNCj4+
IGl0IHVzdWFsbHkganVzdCBlbnF1ZXVlcyBhIHdxZS4NCj4+DQo+PiBPbmNlIHRoZSByZXF1ZXN0
ZXIgc3RhdGUgYmVjb21lcyBRUF9TVEFURV9FUlJPUiwgd2Ugc2hvdWxkIGdlbmVyYXRlIGVycm9y
DQo+PiBjb21wbGV0aW9uIGZvciBhbGwgc3Vic2VxdWVudCB3cWUuIFNvIHRoZSB1c2VyIGlzIGFi
bGUgdG8gcG9sbCB0aGUNCj4+IGNvbXBsZXRpb24gZXZlbnQgdG8gY2hlY2sgaWYgdGhlIGZvcm1l
ciB3cWUgaXMgaGFuZGxlZCBjb3JyZWN0bHkuDQo+Pg0KPj4gSGVyZSB3ZSBjaGVjayBRUF9TVEFU
RV9FUlJPUiBhZnRlciByZXFfbmV4dF93cWUoKSBzbyB0aGF0IHRoZSBjb21wbGV0aW9uDQo+PiBj
YW4gYXNzb2NpYXRlIHdpdGggaXRzIHdxZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwgMTAgKysrKysrKysrLQ0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3JlcS5jDQo+PiBpbmRleCA4YmRkMGI2YjU3OGYuLmVkNmE0ODZjNDM0MyAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQo+PiArKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPj4gQEAgLTYyNCw3ICs2MjQs
NyBAQCBpbnQgcnhlX3JlcXVlc3Rlcih2b2lkICphcmcpDQo+PiDCoMKgwqDCoMKgIHJ4ZV9nZXQo
cXApOw0KPj4gwqAgwqAgbmV4dF93cWU6DQo+PiAtwqDCoMKgIGlmICh1bmxpa2VseSghcXAtPnZh
bGlkIHx8IHFwLT5yZXEuc3RhdGUgPT0gUVBfU1RBVEVfRVJST1IpKQ0KPj4gK8KgwqDCoCBpZiAo
dW5saWtlbHkoIXFwLT52YWxpZCkpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBleGl0Ow0K
Pj4gwqAgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkocXAtPnJlcS5zdGF0ZSA9PSBRUF9TVEFURV9S
RVNFVCkpIHsNCj4+IEBAIC02NDYsNiArNjQ2LDE0IEBAIGludCByeGVfcmVxdWVzdGVyKHZvaWQg
KmFyZykNCj4+IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KCF3cWUpKQ0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGdvdG8gZXhpdDsNCj4+IMKgICvCoMKgwqAgaWYgKHFwLT5yZXEuc3RhdGUgPT0gUVBf
U1RBVEVfRVJST1IpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCAvKg0KPj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBHZW5lcmF0ZSBhbiBlcnJvciBjb21wbGV0aW9uIHNvIHRoYXQgdXNlciBzcGFjZSBpcyBh
YmxlIHRvDQo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHBvbGwgdGhpcyBjb21wbGV0aW9uLg0KPj4g
K8KgwqDCoMKgwqDCoMKgwqAgKi8NCj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4+ICvC
oMKgwqAgfQ0KPj4gKw0KPg0KPiBTaG91bGQgdGhpcyBzdGlsbCB1c2UgdW5saWtlbHkoLi4uKSA/
IEJlY2F1c2UgdGhlIG9yaWdpbmFsIGp1ZGdlbWVudCBoYXMNCj4gYSB1bmxpa2VseSBzdXJyb3Vu
ZGVkLg0KDQpHb29kIGNhdGNoLiBpdCBzb3VuZHMgZ29vZCA6KQ0KDQoNClRoYW5rcw0KWmhpamlh
bg0KDQoNCg0KPg0KPiBDaGVuZyBYdQ0KPg0KPj4gwqDCoMKgwqDCoCBpZiAod3FlLT5tYXNrICYg
V1JfTE9DQUxfT1BfTUFTSykgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHJ4ZV9kb19s
b2NhbF9vcHMocXAsIHdxZSk7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KHJl
dCkpDQo=
