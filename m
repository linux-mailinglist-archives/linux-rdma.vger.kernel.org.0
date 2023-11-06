Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A37E190F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 04:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKFDHM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Nov 2023 22:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFDHL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Nov 2023 22:07:11 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29594BB;
        Sun,  5 Nov 2023 19:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1699240028; x=1730776028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u4ROUcpWz9fe4NpPw1jw8fFvMDZbK9kq8s8A6YqOz/4=;
  b=tUgBZhVhvrbZLxHjotvSqlFqqhASNYiyayGzxsyGskcDAkpsg0iEE5mg
   BgBz4WCVJnGVoZ37wU6TC7x70YLy6WPDwOK+8LFA0PQkUTAysx71z9Wpz
   CkwOjQAFxNlWSBqgD2Lw8lxdrSn/eNQ/Pt6f67HXdQkNNUVSM4Lzz2eEf
   p3Esvo8BVOGYtUIeMgJhEQIr1Mk/Kr3BqfwDXtHYrpttUcWr82TzzpjUJ
   ykoMJvsLtTA+ZH4HkuKP6XTQ5sC6ytc03Vw+puKleDLsANcxmIEQW7T2C
   6NnfBarUawDfT/DTe43V140m7v9lHZxtsusTCBARUN2IZZGryNpJnBpmx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="101453172"
X-IronPort-AV: E=Sophos;i="6.03,280,1694703600"; 
   d="scan'208";a="101453172"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 12:07:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrjQqDIKx263oBMs/ghucC+Hc2iBVH6Irg7BasS3P3GFn7vChskpuhPrB9kLAwZeJMWNIgkTuLVG6w46MMTBTE1pVE8iJNzMpHFYeihpJSfhjYmlI6EuWSaBXhLywX8eJCaTQCBN/Y+p+dfBSV9xYrsm8XErTstFtrQjIovA7xr4BqoRmteUUnwC5hOH/N5f+S3WCqtVs5KtS+cr+u2DD/N3HPfaAsOTZ4gcFgza4682s8jij8K7cW9WSBQqHwxUoO+4vyRTAc01v7N+ZxL6cTAnAQ0OElRfvISiQmWpk4smyZUtq47fQk/eGz3SAuDVGCUjwwtMWzTh+kIpkUwakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4ROUcpWz9fe4NpPw1jw8fFvMDZbK9kq8s8A6YqOz/4=;
 b=Fv3MrRXBkWhagV0N9tQAOyGZoRDgLlw4r5mZMua+OGKB1SbjHeiml+O2FEn1FazcYRTiZJzJWF9d6AsN4vndDn12i5PU4xOXbhXKCjQpWQWI3pUxBHeHrqQ6q8lxsuy5qRar70FBibO36A/G1UjLsNOA8HWV9kLNXhVyOi+PXqFU3fnv9/7I9VbBvlZqEmB/aYJs32qb4BBbGecKJ1i7SYC12eRmQ9cOUVfbXMIoZcmpBM5jqCpkd4uunqy+EWpk85gSpxI8pGjNyXyoKE1oSynWbx40wcWaepLJgavZekHF3cJo2GPe84YgyQRcA25/MOVWMecZat+o6pw23+/2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS0PR01MB5540.jpnprd01.prod.outlook.com (2603:1096:604:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 03:07:01 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::5eb9:637a:8d54:59a0%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 03:07:01 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
Subject: Re: [PATCH RFC V2 6/6] RDMA/rxe: Support PAGE_SIZE aligned MR
Thread-Topic: [PATCH RFC V2 6/6] RDMA/rxe: Support PAGE_SIZE aligned MR
Thread-Index: AQHaDjvznCX5xYIUD0yfFJ9rbPb06bBosY2AgAPumIA=
Date:   Mon, 6 Nov 2023 03:07:01 +0000
Message-ID: <97ebb19c-3df4-4402-9761-edefcfcfa4f7@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <20231103095549.490744-7-lizhijian@fujitsu.com>
 <d2ccef1e-2bea-4596-8787-8d2491ce0278@acm.org>
In-Reply-To: <d2ccef1e-2bea-4596-8787-8d2491ce0278@acm.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS0PR01MB5540:EE_
x-ms-office365-filtering-correlation-id: c4c64c99-3965-4e8e-cd6b-08dbde757241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1y+OSqxKu0CQUZT2vjIWeIswPegrfFHz34TcQRtIcaVtM4ld3jBsJWC6DwPNR6HoqczplGC6HI0LMhqZTD1i7mQabc3jcEmCHQMEa0cnd0jpnyAsHAZ+ncR2kIR/BFUXy1UbfLjMaGRDPrnAT6XkIaivSIDtI0elEBlCh6sRRmvEzNkIYJszzSriHuTFNZ8TtksyZzOJb2hegpnEd/xFfxmyXlxMMmlBL3n4IJ0Xtik5Nr74GiN9MB+odtzPwkLmjbD2NltfA+jTsdWfpOU/fV7XytnjeCvkyVBqeL2GC0EomM8FfHIXXzOqD5gaBBF1uZBQgY+JcGQoDmpuSTDCYP+9+Uc3df6Xru4QtEBOIaQU+hr1VMRw4MiKM4J1XWGWWlmvoObmzT0OuGrxEdHL3SixW341S8fzD8uFL+2a+2yLjdyaeGHdW/6lLR7+Cw3KlXqZKHPnZ0iYWcOLzqQ/sI3cdk/bIXgbkJ1c36n+hpGm+P8J1hR6UORyOVoInjt/QiHn3j+eunUgXqRqsNCVNoAqFfJmgb087RzeuhEkR1j3/xS6HgIx4/7CQc0JfQH3f1HYilJVNK4/ciOAraFIdutsKnbWfAD1EdSCTG4cuAh2OmJ0WB0Jg5kpXT1mHotMYSaP7Rn5pP7QOsMu9YLb34efN2p5rf//2WSAS5xxoNmLhAKl1CVWRW/cd9KyjRm+t1fGYDX+t85l5brlCQzug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1590799021)(1800799009)(186009)(2906002)(1580799018)(83380400001)(2616005)(71200400001)(26005)(36756003)(122000001)(85182001)(31696002)(31686004)(86362001)(82960400001)(38070700009)(38100700002)(5660300002)(66476007)(76116006)(66946007)(66446008)(66556008)(64756008)(54906003)(110136005)(91956017)(316002)(41300700001)(8676002)(8936002)(4326008)(53546011)(6512007)(6506007)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWt3RjNFNkw1cGZweG5ScXdWN3ZzMFUvVk1XUnNnVk9OSk10OVJiY2M4TGFv?=
 =?utf-8?B?RU1jVHM5U04yek5ydVp4enk2cjg3M2xvREpBNDhQSlZMK09ud21qOFROWGRX?=
 =?utf-8?B?UU1GYWIzNXB1U1E2VVcxOSsyM2NpVkwwNU41QzJHUExlMHBHSTJMcTErbDdW?=
 =?utf-8?B?K1pFVmJnS01xaXlWSStxK25GSDRzQWwxb3FpRWJET2lWVUNIZG0vWUdLYmlJ?=
 =?utf-8?B?NkRHMm1MYXFva1V5WldOTEU3bEs2NWU0ZTJTd2NjRXA0dk1pbGRBOUVFVEY2?=
 =?utf-8?B?RHJmRXZrRC9zWGIrd08zclBxMkdzSVVmS3AvaVdLcDg0amFkd283N1RucFht?=
 =?utf-8?B?ZlJZUUdybXRXTzA4ZU4rOFlaZVNTNDVLdmJ4clJpOWhMb0NvRUpnbWkwWUhI?=
 =?utf-8?B?U1NaN1MybGN6cUE1YTVPOWorT00vaFQ1SVNPSTdwTFZGczRoa3J1Z01lL1V3?=
 =?utf-8?B?UjEwR3hHU0krZmNKQmExRWxoWVZCK2FoYTBLRzhhNk56dWNKQVY4QnFSQW95?=
 =?utf-8?B?bXdBRURybFRrUmJqYXg3M3JqTFJ3OWYyQ3Z3RWkxNWtBanVWYVFlTWhTR2dw?=
 =?utf-8?B?Z05QZXZ4TGsvSWNscnM3bVY3QTJId0E4czRoQjZleUh2WG1kbG0wMFZnWUhG?=
 =?utf-8?B?VXU3eU0wSDdTT2tqS2oxcWlxN2plMWtsVTl1M1RYeHRsMTAycEM1VkRGaEFh?=
 =?utf-8?B?S3crQ3Z6c2xYR1kzakdnYS9zREIvMUhDV3lQZHhlOUNVSHlxVWIyclJiZmVJ?=
 =?utf-8?B?TCtsNEpFeUEvdCtMMUFNVTMxTlI3VjZxeEZDTDh0Mk5RN3hQRjdUSjEyb3FB?=
 =?utf-8?B?VjVRWVFyd0l1aDFmUlB4Q1ZmWFZaaXBadHBLanVPd2h0Mi9ReXBPamJwQTJ1?=
 =?utf-8?B?NWt1TG9IL1lrZjh3U21RRnNURWNhOFhMV09EQTYwTlpld3B2QXF1bjBJaE9u?=
 =?utf-8?B?NlBVT2EwVWR1TzBWRGlJV0NVT0tBQWE2OFpXMnpWR2FTcUs3RG1uK1FjVkh3?=
 =?utf-8?B?eFkzWE8wRk5qN1NqTm8wTlZxT2VjWW5ML2VlTWE2Ykw1eDRZRnJFS2RKVjQ3?=
 =?utf-8?B?NFRiUUpFSjhRWkx0YlFiaUMwdnVqeXhiRXlNaGhnZU1oZDhLelY4ZGxiU0Nx?=
 =?utf-8?B?UEhCUHQ2WVRrK0tnSFhRdFVZUlFGcjE0cmJWdmY3NktFOFhCNGVqMytMQlBl?=
 =?utf-8?B?RktTdlJHMC9VT2V2U3hHNkhWYko5a0hkVFdDamdwTFFvZTlxcS9VSCtUSVVk?=
 =?utf-8?B?OGZhVHVUcjViK0FwTlNUVCtoU2ZwdHBINUFDQ2RKQjdJbGY3emZGYWRyZGVp?=
 =?utf-8?B?aFl3a0ZzbktWZlBVdzBRUi9zQ0I5RVFJT3hWZGk3Rm9qU2s5dUtydlo5c1hm?=
 =?utf-8?B?a0FvaFJIKzBIQ0pkcFFhblh5ZHBBdDgrdWxWQ3dwVnhjNVlkWVU0U3BwRmta?=
 =?utf-8?B?ZkV3cDhGUWltNjVxYlE2YmJQc2ZBWmpaRnplNHhzYzJNN1BLMThhUEx2bDVv?=
 =?utf-8?B?WVA5bTE3anNMUEJUUW5Uc2E4Y1B1OVFRSFhqejl2ZnQzdmlScDBFcCtpbVdV?=
 =?utf-8?B?VlloWFluZVdMOElUNVdsb2JOUTNUR2cyLzNpZ3d4eXlzV1pPNFhJREhiUnlm?=
 =?utf-8?B?OFVDWlA2WDNiRVpYNm9WcWhLbENZZ21Uc2RKZjhySlRaWVk3K0M3ekd1SWEw?=
 =?utf-8?B?bVRyeG1EZVBBeGZRanNyaU5SSXZFTUxPbXBrZTF4bnpxUXg5dXZtNkNwMjJU?=
 =?utf-8?B?b2wyaWZqQnpTRGdHM3lXcnJQTkJNZVRERmxGazlyNGZwVVNUYUVHV1pVRmo4?=
 =?utf-8?B?dkJrV0NEOFp2MEphUlNqUUtzV0UxU3dKVXRGeVBNVytvejdDUEFPcjdiOGZv?=
 =?utf-8?B?SjNDZXFjTUlyRGp2cjZCQnErWEkzTnlRUUZCSGVHejZBcVg5RXNiUXBTdk05?=
 =?utf-8?B?eEM5bGh3b0JXRkNTUjNjbUxZdEJmWVJSYXFZNXdnZDVqRUwzd3hzN09OV1Yv?=
 =?utf-8?B?NUVZN3hCQzJSZC9KTmpUTzVlYk9OcittTStZeWZ2QXBaZ0FDb3liSG51WWdt?=
 =?utf-8?B?M0lsazRFRmtjVSsvNnN3SXVtVmhwUTBFVzVUUU9xWW9ubVdSbzFscGR3R2tz?=
 =?utf-8?B?UGZCandBYjR6WjFqTDA3a2k2OUNKbVBzd0p0NDZ5azFYMEh2djl3QmlodkdT?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6054FE6583F5B46B87686B9546C4240@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sv711DDUBs5IaIZRXNd3NzbZfkfuG4A6nBhFcWzu67gMMIyyWswpfNKAKGfcQ9BoH0IaBEZgpOBHJzvRob9G3MlJPuhytZWTUYxwDBtARdLA6RExLiaiY16rD4wqfuxHMGZLHek22ltKs/nSIAVyi8e5/p5gQQ5idqbZj1jvNXBSWyMIDLR2sGKs8yUtuARfYvKMhfIsRhhjxYI2lQWHEJzBjFIGEwIFAOGJgGl7Ia1sVzclcGx/3f4a9YYL9/bHNwn50ea9adbev2jcBGV5XnQBbBtt8b0o82lvwspdr/vW2nkBUDmFMNAQev4TvkoUsMHSkwIWrOMdndY0Yj6q6ThNEy1noi0EdIKVV89BJ3VRN//ORbaYVMFw4na1uvgSOfIKPX7FJ6MiEpzcwgGc8rv5zOhYMTPSKaeTdQRabuRuLRUKx6At1DfXv3S/heRSIU/1BM2x5qzBE3pO/atRIuKG0o0c0sAoEZl9t3+rGtYF/GN2qSE4kmmAJ4n2RMU1WSuwaCk52p0ixblr0n4UR7TZe0xs19nScLmlFlACQTIY3qJcAsri+jMfHcYrgh/l8fcVOHxluNKccbjXOqqlzZ5fI77DD0gVOZp4r/5FhsrdZcDNltOg2l4lkBj69bCDLJSnOHsQ2P1/UKvg0paQi7Hucw6ZlV2iDavR2HSmyoET00aXnFzUyXKvJsIkq4TqhGS+B8cWI8qB0thN5O5CiVcIdMVrVlTK3yTzhOnv3qTO73GLjPOfORi1rmkwHkodxKb6FIZomhgaz9wJ5MADbi/vppx9nPY5ypK/eylpVivDjAf/jA8+uDkdC/K6gAC+n4IVpJhBBY/eelEUHmXBdyaI0VcAp95S86pTJp3lFRdL7+Wwln23IjlG29CA8QgDR+nCmcQJ/oaU6aGvy4aT+Q==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c64c99-3965-4e8e-cd6b-08dbde757241
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 03:07:01.1977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8r9NYOWsvfdKDthnEHz2m3Ax8AgNv6Eo5/Wl4phFcuXYGQkMTI1r6KKBKR8cEx/88Hzbu24LAB2zUzFQTPUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDAzLzExLzIwMjMgMjM6MDQsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gDQo+IE9u
IDExLzMvMjMgMDI6NTUsIExpIFpoaWppYW4gd3JvdGU6DQo+PiAtwqDCoMKgIHJldHVybiBpYl9z
Z190b19wYWdlcyhpYm1yLCBzZ2wsIHNnX25lbnRzLCBzZ19vZmZzZXQsIHJ4ZV9zZXRfcGFnZSk7
DQo+PiArwqDCoMKgIGZvcl9lYWNoX3NnKHNnbCwgc2csIHNnX25lbnRzLCBpKSB7DQo+PiArwqDC
oMKgwqDCoMKgwqAgdTY0IGRtYV9hZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpICsgc2dfb2Zmc2V0
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBkbWFfbGVuID0gc2dfZG1hX2xlbihz
ZykgLSBzZ19vZmZzZXQ7DQo+PiArwqDCoMKgwqDCoMKgwqAgdTY0IGVuZF9kbWFfYWRkciA9IGRt
YV9hZGRyICsgZG1hX2xlbjsNCj4+ICvCoMKgwqDCoMKgwqDCoCB1NjQgcGFnZV9hZGRyID0gZG1h
X2FkZHIgJiBQQUdFX01BU0s7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHNnX2RtYV9s
ZW4oc2cpID09IDApIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJ4ZV9kYmdfbXIobXIs
ICJlbXB0eSBTR0VcbiIpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5W
QUw7DQo+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGRvIHsNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCByZXQgPSByeGVfc3RvcmVfcGFnZShtciwgcGFnZV9h
ZGRyKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwYWdlX2FkZHIgKz0gUEFHRV9TSVpFOw0KPj4gK8KgwqDCoMKgwqDCoMKgIH0g
d2hpbGUgKHBhZ2VfYWRkciA8IGVuZF9kbWFfYWRkcik7DQo+PiArwqDCoMKgwqDCoMKgwqAgc2df
b2Zmc2V0ID0gMDsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4gaWJfc2df
dG9fcGFnZXMoaWJtciwgc2dsLCBzZ19uZW50cywgc2dfb2Zmc2V0X3AsIHJ4ZV9zZXRfcGFnZSk7
DQo+PiDCoCB9DQo+IA0KPiBJcyB0aGlzIGNoYW5nZSBuZWNlc3Nhcnk/IA0KDQpUaGVyZSBpcyBh
bHJlYWR5IGEgbG9vcCBpbiBpYl9zZ190b19wYWdlcygpDQo+IHRoYXQgc3BsaXRzIFNHIGVudHJp
ZXMgdGhhdCBhcmUgbGFyZ2VyIHRoYW4gbXItPnBhZ2Vfc2l6ZSBpbnRvIGVudHJpZXMNCj4gd2l0
aCBzaXplIG1yLT5wYWdlX3NpemUuDQoNCkkgc2VlLg0KDQpNeSB0aG91Z2h0IHdhcyB0aGF0IHdl
IGFyZSBvbmx5IGFibGUgdG8gc2FmZWx5IGFjY2VzcyBQQUdFX1NJWkUgbWVtb3J5IHNjb3BlIFtw
YWdlX3ZhLCBwYWdlX3ZhICsgUEFHRV9TSVpFKQ0KZnJvbSB0aGUgcmV0dXJuIG9mIGttYXBfbG9j
YWxfcGFnZShwYWdlKS4NCkhvd2V2ZXIgd2hlbiBtci0+cGFnZV9zaXplIGlzIGxhcmdlciB0aGFu
IFBBR0VfU0laRSwgd2UgbWF5IGFjY2VzcyB0aGUgbmV4dCBwYWdlcyB3aXRob3V0IG1hcHBpbmcg
aXQuDQoNClRoYW5rcw0KWmhpamlhbg==
