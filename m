Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6914E1F62
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Mar 2022 04:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiCUD5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Mar 2022 23:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiCUD5g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Mar 2022 23:57:36 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Mar 2022 20:56:11 PDT
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0345DE4A
        for <linux-rdma@vger.kernel.org>; Sun, 20 Mar 2022 20:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1647834972; x=1679370972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t3KjcaPtOSvS0j0Uw2Gk7pysxlea6xPujLweYGFq6Kg=;
  b=X08w324b5Ykvhz8ULzS/s/zq+rKEfj2EpdSYkYE90eXJe1Ve3SK7ZhH3
   /nB9KmyPOcK7xDvYLC3TAPvZx2PJWmLpVGWdSIdg9Zzc7hK/Tw7jYQYyg
   dFRLPjFRwHmCsVYK3T5F2PTZUSwjGRNWLigaaml6KGSsYTy0AW7b7M6C7
   wSa/2gQclQAfUbEehyO8o+DcaOaAdqaam/FySi6TnKFG3y8+1tKRVmEsm
   vSSyWcXupJ3V2Ldq9s3LIqimQ1DJPMW5DGFCLLrOUUQMMf9y4hfE92I4U
   9nmMXsgPYOmXq0XoM0MEmm7sO4hW4tkji6NzGxnxPp1jBLrwFLEgO17mo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="52085170"
X-IronPort-AV: E=Sophos;i="5.90,197,1643641200"; 
   d="scan'208";a="52085170"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 12:55:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esUdNgv4pRzNDlIRBu7FbVksDKdqO6Na1Z7/ddpbj72OmMGkbDpDxNA9LEV4LANDvM+meIqKXEjfpUBq3wbE4Tw2gFf9EMEplrEJ4JKBQXoFoahVJ7sH9BcN8q4CRD/dixjJRk0W9IpXCplJ8YPKVJrZq7oO4QWzQXFakLe9snkAByTAsYRn4+UljLWe2b6B6Dk1wcFxKywt4GGuJOPoFb6VEAUt98xdaIWKgdJcoisC5eI8mxRQ9JotZHyAQ/5czP2fPqb73Jd7AK5sUB+zZWWfr5ZQYt47lBE2RVFgCl87zN5ucfMENMErxslK2SfT47XhLCmmWKazu6Z/CVDcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3KjcaPtOSvS0j0Uw2Gk7pysxlea6xPujLweYGFq6Kg=;
 b=CEkS1nK/1qZYyZ53qjKrpBkqmokFnXYFggRoJg43l/Dv8ucaNRzQFH5q1qf4hut/09fm3BvRsQQzlsIVVB5wVFPm5t+QRTCBo98j768gV9WCARKtODBAa966BTNq/RLARjPud/YUh9EhRk9tCjqkKnZjs8vsiVknXFZblvQWJmaGWLSi++ReDzhuD6x8xoTPKW3lE14LhHADa6L7b/XPGrPp8lfmOowcfiYQQR1lyXV1PVHwCxk40ecL675V4otwRAmNUTpo/MJ6mXsYnVKS8fXmtmhtJPzp9E+V73qBKu7ZqtIO1W2vkar12HNXX/JTs9fJsH1URkAkEqrO3+6zAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3KjcaPtOSvS0j0Uw2Gk7pysxlea6xPujLweYGFq6Kg=;
 b=S36Z6F3q2kiOi2xfnxEBe828YnFkHVQQHlX0bA+/VoNoH6WgceWqtBT7BL+ysDIpWmOppJ2AL97+aSSSolhIa/yJSeuIAiV/XxORwFS5ThvSgNLrJqsaPWrRDzI27diSgNneOpYd+IiqtKIPULJE59zBekzsATaCjGAhyO0IUPM=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYAPR01MB4253.jpnprd01.prod.outlook.com (2603:1096:404:c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Mon, 21 Mar
 2022 03:55:00 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 03:55:01 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Topic: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Index: AQHYNT6Zd/sV5d3li0GAOL19eVqOcazA0W8AgAhy8oA=
Date:   Mon, 21 Mar 2022 03:55:01 +0000
Message-ID: <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
In-Reply-To: <20220315185330.GA241071@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddda03f1-53c3-49eb-6237-08da0aee9320
x-ms-traffictypediagnostic: TYAPR01MB4253:EE_
x-microsoft-antispam-prvs: <TYAPR01MB42536BB3E460BF4AF3BCDD4683169@TYAPR01MB4253.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8zT4TM3EQP44jPZIRCi5U3N9jzkysOmT3pqUdZDgZTNj9G48mzUcy7b9eyNpDAeoNKu3FANyyqciEZu4YnUEh9JuAdavcG78pAhFeoAEJvpZLs8/Z2/mpDfMnpRGBeVqPTY1TKcc6daEwBU1HZ5AreU4mnI1cmDrzmvM/AL3buT8l4wJ7l5lV7+TrsMvLLqTss73x8Dj/SDoCkqoT/PnfNlBiq84MGzVH2zZoO/i7TqmlznsCkbddlakuvZJ76TYiuFaynlocGES4/0XslUmp/NFauxXQsr1jzHJcJbnSVWobMta4YO+pXCfmQ+abqaJ0G1/T5XggDlCwQPcPMUnKUZdEK9sUBG4KaU1c8Xn7df6onhZ/RWhKq1Pr5AZIFzin/vUeQOVXo89d7/bf96zvVKFFvjesHH7VQN+KMU1w/12pd2krFU5Hqf6Ah1dFVaOSk8q3x+i8n1u9MS8fIDyz2EnQvyyH7Xdru0u2lGOBEwZSAdAk1jqgmfOe8cjk9G34+C1hvJTKx6Ads9n8J4vp9rvBYnORAxc7Edtv1YaCEJwMkK9WDbJZKQC+P6wqwUppKxxBHpbOQVYqLb2DGSwtwxP6EFRXmEKVp1DK+9EvDymlMJxEvW98x7pnBtf2BAobYHBSmm+hCh4VQglXZyMy6mCwNqVH2JQ3QpAWMp99Ekq5C+Pc++PnH1x39N8eoAHtAmevysuaGfBTZ0gwYzTr9N0Mj+Vn2do/dowQa3Q/+mJ991m23pg1LsD7IAlyoA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(8936002)(85182001)(6916009)(54906003)(316002)(5660300002)(86362001)(36756003)(31686004)(38070700005)(2616005)(38100700002)(4744005)(31696002)(91956017)(122000001)(6486002)(53546011)(83380400001)(71200400001)(6512007)(4326008)(66556008)(66946007)(66476007)(64756008)(8676002)(66446008)(76116006)(82960400001)(2906002)(508600001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzdBUlVCL29FRGc2Tk5HOHNJWC9EUllrd202VzVqQnNmczhkdFFTZnhiWGEx?=
 =?utf-8?B?bVo3L1dHN1hRMG52d2IySXJpZGlUQ1dZTEVWK3ZBZ1JoenpZQnRpWmdLKzh1?=
 =?utf-8?B?VnJFMUI1cFFuWjRaK21zM3lCRWVYM2hqUy9iczhIUUloajh5UlJINW5jSzR3?=
 =?utf-8?B?TUFxMlQzckZqaEpZcERrU1NySUE3WE9xTWsrVVA4NGZ0S2hLdkJidkNLY0VE?=
 =?utf-8?B?YW43VHBXVlYxTWg0SFUzRjVSc1VUaEs0YTQyWW1iQU1Xa21ick5KNzFLaXpv?=
 =?utf-8?B?UE5LMERiZ0FCVXVpdTMraFlHdDh0eHR2YTlLNVl6c2l3ZnQ5YXZmZExDODRs?=
 =?utf-8?B?ZjFRYWxBM1hKMW1SYklieEQ5Nkx4bHJhbXA2M1E1dGlxcjhXNGtPR3JxTzhU?=
 =?utf-8?B?L1RNVjZ4MU5jVUVuM2hQVEpodmlONUkzbzI1eUJGakFqRUE2ZGhKVVM5WWxr?=
 =?utf-8?B?TGVMOVN4NWtuVkdXb0YzRjV1SWM5UFV3elVObjFNQ0JzSnVNa1VIV3ZWWWJZ?=
 =?utf-8?B?bnIzdGlLdnIremExZ0lxb203NDhPQ1NaL2N5YVlOcXl2aW91N3hoMDFsemFV?=
 =?utf-8?B?aXloY3RHSnNUc3VXQnloSmVnVVFEVlNvamdGS1V3aXdwcDYzQjlFSGlLeXFm?=
 =?utf-8?B?RmZlMjNXWm9kbHN3MHhlMXhPRUVNbXp2M0hZSGlpOXhNSW9MYm1kUXN2Q3dO?=
 =?utf-8?B?SGtKTFlmM0tiSFM4dnk5VXNCL3hTUUNFYTMrTzQrS21NbEdBTWI5Z2NQdDZ5?=
 =?utf-8?B?L2xyN2laQUlwVUpWa0hUL3NUT0RBT1BuSUFVWHk2b1l5QUxBYU5SVjMydTFS?=
 =?utf-8?B?c0N1UTdvM2l2ejRxejVVYXlNY0M3Z2UvdlU3UXlJWWt1Q1lhWFlISkljczFq?=
 =?utf-8?B?TzNtSEJ4U1Nmd2N4c3NEdjZGU0FkNnlLZUpsdU85MmdxTHlyc3ZkaDFuZWNx?=
 =?utf-8?B?Z0hRYXpYb2cwUkFLQnczSDJnbVZLTUwyZE1sREJRbWJLWjUxYlVYYTQvNmc3?=
 =?utf-8?B?VUkrdUhhaVVBa0xhTVR6cHlSemRHazQ2eVQxVktWemRWckhRQW8rbXJ1a3FJ?=
 =?utf-8?B?TE5SRSt1SHIvaldlWlkyNExRMmJIZmIxeU1QbFlNa2c1WmJ0UDJodmNzZXF5?=
 =?utf-8?B?U09SaVV1dXFCSUFaSDUxTXpiSXFLdlFZdEYxL2Z6ZnlOTVB0QWpydFl2RVVF?=
 =?utf-8?B?aWJOcDZjTkhaYTUxTG1Tb3MvVzg3aWlIMmVMR3ZpOEJsc055cVBUbkhnbys5?=
 =?utf-8?B?d1BiUzdiU28zaFlGRVEwS25Xdk1xVGNENVlOTnNZelBJV1ZlaEk1QlBjdG1I?=
 =?utf-8?B?cTBWS2VSYVk5R0NjWXlHaEtvKzN2K3JReUZqMmkwa0xlb21paHVsYmN0Y3A4?=
 =?utf-8?B?bTVZQTJVUHcrN0NaY2QrSHZqMVZQRnFRQmsxN1pNOEdlWEkxV2E1V29pZ1pp?=
 =?utf-8?B?aFJqa01VY0MrbWNPR2tKVk5KaXdkSlppZ2JaVFdOR09sY0R1R0lKWHZkSTZm?=
 =?utf-8?B?TzRoNTgrK0Q1UWZQaDdXOWR3bDhDSFNmUnBiWC9FUEdlcjA2aWFLamhrYURt?=
 =?utf-8?B?Mk85RUtKdmxjZXU0SVlZU2JzQU5icEJSa3BzNDQwSWxZakYwQWJpdGlyK3cr?=
 =?utf-8?B?YjcrL1B5K3pEckpGNnZDMDE2UFd4VWRzOVI1UjdlYzQ1ZDNKWE12Wm5JSERi?=
 =?utf-8?B?dEtoRHhIQVJUY0xGcnMySEJjNGRTOXp6VnBrRkJHcTZCeG1pUW5NZEhBTWtQ?=
 =?utf-8?B?bzB4RDU2VUt2V3NsQ1pTdWRDNE5MK1lXdWxUdkhxR2grMSswdGQ3dWRtclg2?=
 =?utf-8?B?ZzhXMi93ckRIVzJ5NTZ3cmQvV0t5SXFHTlNKbk1QMkRCN2plcWhKamVsWDZ4?=
 =?utf-8?B?VDl1TE9YVldOaXVoM0d6SkZ4eWtkaW9QWjBIOW1LSHZZN0lVTG0rS2VZZVZy?=
 =?utf-8?B?aFk3WUoxWWFEUnZXSnB5VHN5cjlpNXgxRWtCalNpVk42akFiNTk5aVgvREVj?=
 =?utf-8?B?cUpKWDc2b2VRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6985D2E3B4F3E45B3C9F8DE7A77ED04@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda03f1-53c3-49eb-6237-08da0aee9320
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 03:55:01.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmpkbjRXSuubZD4+6rMq7v1dtP0xzxwuLhJNZT19hNxIOsh/9dGhKleghUf5KUGdnwU1+ADYcR1wOvFp6D7EUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4253
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzE2IDI6NTMsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gWW91J2xsIGFsc28g
bmVlZCB0byBkbyBzb21ldGhpbmcgYWJvdXQgdGhlIDMyIGJpdCBjb21wYXRhYmlsaXR5IHRoYXQN
Cj4ga2J1aWxkIGRldGVjdGVkIC0gSSBzdXBwb3NlIHRoaXMgY2FuJ3Qgd29yayBvbiAzMiBiaXQg
cGxhdGZvcm1zPyBTbw0KPiBJU19FTkFCTEVEKCkgaXQgb2ZmIG9yIHNvbWV0aGluZz8NCkhpIEph
c29uLA0KDQpJcyBpdCBwb3NzaWJsZSB0byBmaXggdGhlIGlzc3VlIGJ5IGF0b21pYzY0X3NldF9y
ZWxlYXNlKCk/DQoNCklmIG5vdCwgd2UgbWF5IG5lZWQgdG8gYWRkIGEgY2hlY2sgZm9yIF9fbmF0
aXZlX3dvcmQoKmRzdCkgYW5kIHJldHVybiBhbiANCnVuc3VwcG9ydGVkIGVycm9yIHdoZW4gX19u
YXRpdmVfd29yZCgqZHN0KSBpcyBmYWxzZS4NCg0KQmVzdCBSZWdhcmRzLA0KDQpYaWFvIFlhbmcN
Cg==
