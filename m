Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1055B5DF
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jun 2022 05:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiF0DmK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 23:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiF0DmI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 23:42:08 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581FE55A1;
        Sun, 26 Jun 2022 20:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656301327; x=1687837327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BzsuMR0+VQJ4OecAw/ph3hxIO4v3zA/KkLQDzua/Xdw=;
  b=ApI7GmjgS9TQ+5oFpLlas2DL317WrUUeP/hAkbFnTl1utp+KvuGacFDA
   4wA5NwyjhDYja05HV6XLdc7l0XdV/9t9DbFrApUKq9CREEylZkinekjXy
   DBGKENrwXBRBKDz83craCEwxHHcqKXRnxe1uSm9f7YljEmvpEG//g+Goe
   CjXXmy3OKYnEwhaI0Ag8txSa4WG37BxWKH1VfqAobEdp5ud0ed5CT+97e
   fQ3MUCuMuCjqhkL/8QG9VGTJ75JSxYBdgeOd5kH/s+mb76IjTvD3BrV1K
   CDrssqC9vRo6UD3otcRJBDHvIt5o3MDbhh7blMM4jWd6srp8TYUjzVFYt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="60377437"
X-IronPort-AV: E=Sophos;i="5.92,225,1650898800"; 
   d="scan'208";a="60377437"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 12:42:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbEil53SnVN1n4cQN6dxBuXq8eyXqjqBxTcjeHynfT6ao+7F1zJ5ZCLRutKnv8NZcnu+R7Bm4m0haTX6nS/m0IVQS0duSgDM/EOgXfQe4b9JIlT/IX3SvR30xW/krbwxw23SRsTYF5PDmJah0zfaHGhW7CiFhSwBCHbuKBmhb1fwYxSe24kaPJq+hYQ4KXDwZo2mSqUvQnmnE1oSi+6/n7gMjDM2OXx7gxUfUQKm1XyPNzO2yZ4DJEBrDwjF0TkK9pKxSsXqSxx/+vNpiuoqlB+6VXomYqCGtlwq2sYExBrE70RRR2VwAq9sDZxhymYLZLf46h59dqvoS7zNHTjyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzsuMR0+VQJ4OecAw/ph3hxIO4v3zA/KkLQDzua/Xdw=;
 b=Y9zl+W/ezSe33WHqaN+PtoHM++XDTRyihZ81pCPVKHg38H771+Dlk8XgVpNjAGxDRYDSMGsfCSUFFAbcuL3mOFoLhIpjxa+Zw3pF760P/M/bTift1p6KSJnY4EMgGmWsmLE+e7g52cU6jQP3+fy24w4l/7wNpKTm/7I2H4Tucda3ZaIo6G0fivOp+Ihi8YoFxOM5iH21U0SiMOB6PpGX/TysUuX8uT2oxMga/cdcJ2uAoo2Abuiy70u6tVtL7S3wg130eTq2oaXvd+AvqYJktqQq/gJxNk+hZnYMloPuMVqqB1Kdr8WKXWzHY1um8yqaV3W3ZW5IASSLuDSfRaVn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzsuMR0+VQJ4OecAw/ph3hxIO4v3zA/KkLQDzua/Xdw=;
 b=JNXZmYdUzlK9dhY5qIVct9/ajYddxpuW9qYyTbnN/bXy8W2s6K5LoeE6lBHk7MspTCDUDvIUd9Ek3CZAmpNsDwsA+SfaazZqB2n0t8IO4dxZHsxAkyFeXp2gHl+AJP1ghZRfpFjX2Bv75DO3mdOJ9NynLMBUq5Jt7oHwvpzUlyw=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB3189.jpnprd01.prod.outlook.com (2603:1096:604:1f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 03:41:57 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::416:8e9b:ee26:d5c8]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::416:8e9b:ee26:d5c8%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 03:41:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] RDMA/rxe: Update wqe_index for each wqe error
 completion
Thread-Topic: [PATCH v3 1/2] RDMA/rxe: Update wqe_index for each wqe error
 completion
Thread-Index: AQHYaMbN9CU2XNcxA0OEgIaLl+n2SK1ifDIAgABh8gA=
Date:   Mon, 27 Jun 2022 03:41:57 +0000
Message-ID: <dc2efb0b-68be-102b-a041-47c799361d35@fujitsu.com>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <20220516015329.445474-2-lizhijian@fujitsu.com>
 <1e9a8c0f-b4c3-3edf-33f1-33a2b7ca245a@gmail.com>
In-Reply-To: <1e9a8c0f-b4c3-3edf-33f1-33a2b7ca245a@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f00a8f-9436-45c8-2a39-08da57eefc53
x-ms-traffictypediagnostic: OSBPR01MB3189:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWmC6QrUtmtfn+4mChrP4nuHn7rNQFmtB6aNq5Pu+Z4D0axuWwBJk4aQit2/UocKyCHBYAl867Sq6ok0RvOjypOMqP4izfLqh06a6d1dULpdzOdil/Xkx9F9WeeRQHfAixgXo7XMY190V6v7J9QgyLwfuBdWQj1nGFlJLRheA0Zw8qzDTcR4BW8x4249ijz9ioexR5mLomVcFjgafjk/pwC+Jz3BYvwH8+nn+7OrK96UWLejCWIDPJcsvPInXSutFamk+WIJMYJ0zADXGRW3QVDDLIb9earOEW3LQrt8/Acvb3WwiW2u0+1Kg4X41xLrpglTfUlY6GkX/IEpsla60SUrNAUY+fyhAQ3kWkctki5wlkwQRYaWahD+tQPw3jDOPho7/LFWoMWHqUV9Y2juOij/3rY3tnRvWlgMRC0dz6QQoAQfMeGnPi0oz7dcLw7UvbMrOU1xBqEGAI7r2oFsEDQZYVAQADrA/iIhQt3sqE7rPJWpjGq9bIVMYyQYIe1WiA2Dz3MKRIrGCCMibNR7D/x6DWwJhZ/UvdwnMWxc2AX17iHr7phGqQBkaizBSMb59giK/DaoGHCNcW7xtecAJFXqpci5ATrnG0bkXqpTgjqZVMCpgPruNbvRPqRK5Z3UNhCdAiuTUWZazQ1VvMd6xsIYkeSb01nQwBVttHvMvepQt1kjBSJCjIf6q1QXKmwfzCVD8Q9eq+KBD8DbWCKvFWjlKfVe9Vox0RCr05aEELEDPgswjGMzbT6KiUA4vVXMzyE7zobXB/Il80QwDL7fRWGq4VGfEgfYjYwOXNgvQplM+YhyCCt+JOnTYGnC3rq8GN/7Czo70DjQI0f6NPQcxuKOjXRQDLnGNM24PoVcufM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(6506007)(53546011)(71200400001)(41300700001)(6512007)(478600001)(82960400001)(26005)(83380400001)(8936002)(31696002)(4326008)(91956017)(110136005)(6486002)(8676002)(186003)(66946007)(316002)(122000001)(86362001)(38070700005)(66556008)(2616005)(85182001)(66446008)(2906002)(66476007)(64756008)(31686004)(38100700002)(15650500001)(36756003)(5660300002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEJpRzgxNTdKdlFoL2h4Z3FnektzUGh3VUcvL0YzZlFFUWoxeVVOSC91ZHdp?=
 =?utf-8?B?emZmQml6ZEVSaTUzVm9CS3QyRk9SR2JwZUNneUJMTVdMVUNXNk5vOXFkUkkz?=
 =?utf-8?B?d1hlS1BDT0FCU2dJY1habUJTdkZkbnBHNE5lLzZYTE0wR3UwOTlVRUlRVkV0?=
 =?utf-8?B?aUt3WTA1NnFvTWJ3elBDdnk1SHJBbkRRNjNvZmE0L1BHWnBvYTJ2QktMYUc0?=
 =?utf-8?B?NjNwN0RPcmJKbmc0OXpGc1pFUlZGWUFYbFdKVEUyUis4eEZZRkUxeG5vcjlH?=
 =?utf-8?B?alFzWWQvcDhGT3ZrYkJ3MUlXMjBma2pHRlFkY2ROdStCeDg0cW1GUFIvNHpm?=
 =?utf-8?B?UlFNQVl1QVhaaVhoeHU0V1p0SHYxZVFQbCs2NFFvZUthcGRwYWFxRktuc09V?=
 =?utf-8?B?cS9ycE92ZzBacGxiMkdJTHJtSjM5SHhJL0Y0dU9MS24zUmh6aUJLa2Q3NVNT?=
 =?utf-8?B?VkVwNnltTjYvSG9rWVQyOXBYUmF6NWFnT0xnSEk2MzNQMVpXQWFqcjdxcVVh?=
 =?utf-8?B?aW4ySFpKS29yVmV2ZS9xQUtMZUV5N0V0OVh4eDdRRTg4ekgvbmNycEgza2Er?=
 =?utf-8?B?blYzeEVoTXlsTEt2ZzZDTzhqNG1rWmFnb0NvYVpVdDIvRjkxS050VWo5bVQ3?=
 =?utf-8?B?dnMzdWdjUFpwcWpld213NG1mY2JGNjBENnVUeTFUZHNXSFFIRjY2RFBsVWtP?=
 =?utf-8?B?WEJ6d2ZJczcwQ0Ruais5QUR6TmVvR2JVRVk3VHhBREEzMnRKblhQM3lDWk1W?=
 =?utf-8?B?KzdkN2xKb2xxOWlITS9xZHpQVXUyZ2s2NldjWWZyZzVEYUFhc1pvekwvcUpE?=
 =?utf-8?B?NzZLblFDUEE3VFg0TVFFaHpkYS9RM3djZmtkMmxDR3l1L3lnWlZyVk1wWnda?=
 =?utf-8?B?VVVRRjFWbVliM2gzN3JWZWEvSkhoYWFDTWhYQS9iQjBJMmoycExtbTREYmQ1?=
 =?utf-8?B?YWNZWDZpQUxVb090bU16UjBrakdwWHo2UTdLUFBWS01BVTMvNU5wajh4QVFB?=
 =?utf-8?B?eFhjYzVmZWFrUWVETk1PdmQ3MFora2NwOGtPUWh1Wm5rOWdNWm9VcHozNzFm?=
 =?utf-8?B?UEZBWlBJM1Z4MHQrWTJHUnpSa1FyeXJDdFEvczBVNWVRZlFYZXp5OC9JaE9W?=
 =?utf-8?B?SlJZTE02V2FtV0JteStXTEVoUXhwTWJrL21zS1FFN3RzVFIyMGc3L3R6U1Fa?=
 =?utf-8?B?dXhwZCs0b1lyR21PSzNXQXhUVlZFcjlGb0VaNUROWERuQnliWDNXMnVjdDFQ?=
 =?utf-8?B?SFkyQnAvVWpUdjI4bHdLVXgyZzJIanNmN3MrN2IxOU5jbG5vbnR0QktRUVRr?=
 =?utf-8?B?M1FIUUtiRE1yckFBTjI5UzB2Q0ttQWY0V0hmRXlabHZCMFUrT0ROM2xlbnRw?=
 =?utf-8?B?REtibllwSnF5amR3QWQ5dXJwZm5uWExyeVVaZVBsYm12NWFiVENEK0tubTRs?=
 =?utf-8?B?cVRFd3VWVTg4QTZiZ0wzeHB1UnpsTUFtV0NVbG5qN0x2Z3c5UDNJRGVYKy9F?=
 =?utf-8?B?bnZtTFpWbTFJTlRGRkRwY1dyQm5DcmZ2RWRmbWZYSUNBYkYwa1YyblA1Mmhm?=
 =?utf-8?B?WjBtbDZYUU1JQ1hiOXIvWkR0WnJYWXNQZmxuSTFCUjMyTnJYaU5RM0VvTytu?=
 =?utf-8?B?WU9HYnFZa2laWWJvTGVaQ053cDhyay8xTzMrMEJRcWZjV0F0Z2t6SDJNVFZl?=
 =?utf-8?B?cFBiMjc4WVltUlpRb3FHc21TaVZuUnU5SUJmczVhbXBLVzZOUUFQMVZ2SWl4?=
 =?utf-8?B?bTNadThVMXdHZUZZMFljZ052ZGpxdysyRW0zVWVVZVdPUWhiVVpJQW85VlNQ?=
 =?utf-8?B?NDBZTVhBdkQyUWtRZmVmcjYxVzZHWXRQN3FtMGZxeVJpOVB2dE5jdTNaR3c1?=
 =?utf-8?B?Y3hFQ1FXcjNnclp2NkhZd2taNzhyeUZNMUlWaGY3WjJRR1hXUVFPVjRHQW4w?=
 =?utf-8?B?azRqSWtiaEVmTy9mUjA0Zjl0UkNodXYvQ2FXOFJxUkV0cDFUV3ZYakZPS0Rs?=
 =?utf-8?B?L0ZyTkFpcFh0b0I5NjhGbE9zM1ZBcmY0aTFMd0RWV0orY2pyWjJNb2p2SXdF?=
 =?utf-8?B?OG5mTVVOTlJuZ1pocXdPMEUzeW9QMDlwdHdQd0g4U0xjM0hzUHV3STBiM2Nt?=
 =?utf-8?B?SDRKWXFqb3E1dnByL0ZFajZFSVJmeWJDcFRUckRiemRXNk5QWVhXb3FWNW82?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AC5FA1AAE5C16468F52A76C17DBAF1B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f00a8f-9436-45c8-2a39-08da57eefc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 03:41:57.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMfyt3TvRYNoz4TBNfD9KloG9yggb2sLgDrB7zyDjxWYBVsE/k3zZyjT/CWVEwYCGqVGaNym9iM9HkHV1Rqerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3189
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI3LzA2LzIwMjIgMDU6NTEsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA1LzE1LzIy
IDIwOjUzLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gUHJldmlvdXNseSwgaWYgdXNlciBzcGFjZSBr
ZWVwcyBzZW5kaW5nIGFibm9ybWFsIHdxZSwgcXVldWUucHJvZCB3aWxsDQo+PiBrZWVwIGluY3Jl
YXNpbmcgd2hpbGUgcXVldWUuaW5kZXggZG9lc24ndC4gT25jZQ0KPj4gcXVldWUuaW5kZXg9PXF1
ZXVlLnByb2QgaW4gbmV4dCByb3VuZCwgcmVxX25leHRfd3FlKCkgd2lsbCB0cmVhdCBxdWV1ZQ0K
Pj4gYXMgZW1wdHkuIEluIHN1Y2ggY2FzZSwgbm8gbmV3IGNvbXBsZXRpb24gd291bGQgYmUgZ2Vu
ZXJhdGVkLg0KPj4NCj4+IFVwZGF0ZSB3cWVfaW5kZXggZm9yIGVhY2ggd3FlIGNvbXBsZXRpb24g
c28gdGhhdCByZXFfbmV4dF93cWUoKSBjYW4gZ2V0DQo+PiBuZXh0IHdxZSBwcm9wZXJseS4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+
PiAtLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgfCAyICsrDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9yZXEuYw0KPj4gaW5kZXggYTBkNWU1N2Y3M2MxLi44YmRkMGI2YjU3OGYgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPj4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4+IEBAIC03NzMsNiArNzcz
LDggQEAgaW50IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KPj4gICAJaWYgKGFoKQ0KPj4gICAJ
CXJ4ZV9wdXQoYWgpOw0KPj4gICBlcnI6DQo+PiArCS8qIHVwZGF0ZSB3cWVfaW5kZXggZm9yIGVh
Y2ggd3FlIGNvbXBsZXRpb24gKi8NCj4+ICsJcXAtPnJlcS53cWVfaW5kZXggPSBxdWV1ZV9uZXh0
X2luZGV4KHFwLT5zcS5xdWV1ZSwgcXAtPnJlcS53cWVfaW5kZXgpOw0KPj4gICAJd3FlLT5zdGF0
ZSA9IHdxZV9zdGF0ZV9lcnINCj4+ICAgCV9fcnhlX2RvX3Rhc2soJnFwLT5jb21wLnRhc2spOw0K
Pj4gICANCj4gVGhpcyBjaGFuZ2UgbG9va3MgcGxhdXNpYmxlLCBidXQgSSBhbSBub3Qgc3VyZSBp
ZiBpdCB3aWxsIG1ha2UgYSBkaWZmZXJlbmNlIHNpbmNlIHRoZSBxcA0KPiB3aWxsIGdldCB0cmFu
c2l0aW9uZWQgdG8gdGhlIGVycm9yIHN0YXRlIHZlcnkgc2hvcnRseS4NCj4NCj4gSW4gb3JkZXIg
Zm9yIGl0IHRvIG1hdHRlciB0aGUgcmVxdWVzdGVyIG11c3QgYmUgYSB3YXlzIGFoZWFkIG9mIHRo
ZSBjb21wbGV0ZXIgaW4gdGhlIHNlbmQgcXVldWUNCj4gYW5kIHNvbWVvbmUgYmUgYWN0aXZlbHkg
cG9zdGluZyBuZXcgd3FlcyB3aGljaCB3aWxsIHJlc2NoZWR1bGUgdGhlIHJlcXVlc3Rlci4gQ3Vy
cmVudGx5IGl0DQo+IHdpbGwgZmFpbCBvbiB0aGUgc2FtZSB3cWUgYWdhaW4gdW5sZXNzIHRoZSBl
cnJvciBkZXNjcmliZWQgYWJvdmUgb2NjdXJzIGJ1dCBpZiB3ZSBwb3N0IGEgbmV3IHZhbGlkDQo+
IHdxZSBpdCB3aWxsIGdldCBleGVjdXRlZCBldmVuIHRob3VnaCB3ZSBoYXZlIGRldGVjdGVkIGFu
IGVycm9yIHRoYXQgc2hvdWxkIGhhdmUgc3RvcHBlZCB0aGUgcXAuDQo+DQo+IEl0IGxvb2tzIGxp
a2UgdGhlIGludGVudCB3YXMgdG8ga2VlcCB0aGUgcXAgaW4gdGhlIG5vbiBlcnJvciBzdGF0ZSB1
bnRpbCBhbGwgdGhlIG9sZA0KPiB3cWVzIGdldCBjb21wbGV0ZWQgYmVmb3JlIG1ha2luZyB0aGUg
dHJhbnNpdGlvbi4NCk5vdCByZWFsbHksIE15IGZpcnN0IGludGVudCB3YXMganVzdCBsZXQgcmVx
X25leHRfd3FlKCkgcmV0dXJuIHdxZSBpZiB0aGUgcXVldWUgaXMgbm90IGVtcHR5Lg0KU2luY2Us
IGN1cnJlbnRseSBpZsKgIHJ4ZV9yZXF1ZXN0ZXIoKSBhbHdheXMgZ29lcyB0byB0aGUgZXJyb3Ig
cGF0aCBmb3Igc29tZSByZWFzb25zLCByZXFfbmV4dF93cWUoKQ0Kd2lsbCBiZWNvbWVzIGZhbHNl
IGVtcHR5IGF0IG5leHQgcm91bmQgdGhvdWdoIHRoZSBxdWV1ZSBpcyBhbG1vc3QgZnVsbC4NCg0K
QlRXLCBpIHdpbGwgcmV2aWV3IHlvdXIgbmV3bHkgcHJpdmF0ZSBwYXRjaGVzDQoNClRoYW5rcw0K
Wmhpamlhbg0KDQo+IEJ1dCB3ZSBzaG91bGQgZGlzYWJsZSB0aGUgcmVxdWVzdGVyDQo+IGZyb20g
cHJvY2Vzc2luZyBuZXcgd3FlcyBpbiB0aGlzIGNhc2UuIFRoYXQgc2VlbXMgbGlrZSBhIHNhZmVy
IHNvbHV0aW9uIHRvIHRoZSBwcm9ibGVtLg0KPg0KPiBCb2INCj4NCg==
