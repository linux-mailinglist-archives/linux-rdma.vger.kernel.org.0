Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126AB4B0BDD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 12:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbiBJLIF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 06:08:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiBJLIE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 06:08:04 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 03:08:04 PST
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31BB61
        for <linux-rdma@vger.kernel.org>; Thu, 10 Feb 2022 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1644491284; x=1676027284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/gNaAAIF+pOCqda3i7BqD4+QHVo1KzyACKtEMEPXZFE=;
  b=oI4lN5WhhpwhfzjfiebyeQ1G4Xhgfkcvut4mOfo8ECqjDk0S0aC7dMda
   VcKFvRKreSY8bxRLssmwPz5jYUHFZuShXEyD3zFGat280IFwwpVAgGSoK
   LyQpRXFLmHLUeNNoUvzK1CTAvGnXNpTh+b7b1af8h8gPNf6dT7Npi6/e+
   jSDQTEoDSXDmIxqmulEIVSGyiqJwCMSGtyPLkiLOwgcHici9XAJBvBGBv
   SLnO3XPwHuBZQVHlzX8YzXOidohwN91V6jFcb1B3SPkkzsV6cKfqce4me
   w0gwks38hJiEKAq1BwJH1oj8cu7INLKk90Y5mFxJDnAM8X7J85kgTPwNN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="49582747"
X-IronPort-AV: E=Sophos;i="5.88,358,1635174000"; 
   d="scan'208";a="49582747"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 20:06:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f467AhdVlQ0wUq/mvEYaYzt27CZFNBzldTKtK+X6sbeEHpLKK8n0+M9o//Kfqp5HbMQBWuS71x3YVDFcK+6SHIEYlY5a0ddvJNccCVs4TkNuycM2lWIfQCMNSp0YU5F8WjJBRRNkZ2lvZCjpk3MTx5XU9sZZKC74rzmdbrJp/ZSv1s8E8eAkm6tKN0yQ2mwHN2aOEWzJpUbIQPHnAUg0njF6Ey7GR8IcHYnZ/n7QMpxPsKOq4hjh77j+VHCUByCw8QTtTJ2gjxTkgqBrpAHJiL/Ax3zKSBQxaHJ2MYGpK1szVR+EC11Ua8+sNyqAM+eFmDB6L15CGoofNIHx1SSZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gNaAAIF+pOCqda3i7BqD4+QHVo1KzyACKtEMEPXZFE=;
 b=ePFjuX7D01U4uSuvCvSpInhSfZFVW7oj4OQ3/I810lkCnqd1DnsJGxX3Hm+xiAgW2F20EdnkBkmDv6phbU/Q4m3AlZAq9VF8bF4v6glo8eNNsZor1BR7gCr+69On/WYeyYe2/QxcB68S9rwAtvcAUWwtsbnAkp4D7rXMNTeEE/Sju/jxwlcbglrQq84e8YYgZavo/9ijJ+bjbmZ4tOGfuxE1GQlG8ILpiXQpgds8z4x56ETcxG5SpdKjhYPLuDfzwh0q/6cstLLZ1PH8akW1yJlWQCiRyXHANpHg4AqWv3RIzvOFozT25TeEWDmH4dvUlNPzmrqlZTrD4omBEEbwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gNaAAIF+pOCqda3i7BqD4+QHVo1KzyACKtEMEPXZFE=;
 b=c96qWH5o7ryAdv8XCSXKZhqN3vNtQ5Ji05+07DvEIlmwKfGFbgrEiGL3rSfnuhJjfPIYfbQKWogJmThRRL+j8/ATg6J6DxNwUkDcGKRgwIUYp3T1LYCBx2LhaXU0M9olmuH7PuBe3mBrFst3bg7kxNuvTzjy6LaxSmjeCWkhWek=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB7144.jpnprd01.prod.outlook.com (2603:1096:604:128::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 11:06:56 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%6]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 11:06:56 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Ira Weiny <ira.weiny@intel.com>, "hch@lst.de" <hch@lst.de>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUccBUAPZcPEOP46lbsjIBJKxnOIUAgAE6bACAAExegIAA310AgACzY4CAAYo8AIABoJWAgAA0mwCACQFEAIAABYQAgACJMoCAAMtVAIAA2bGAgBPlzwA=
Date:   Thu, 10 Feb 2022 11:06:55 +0000
Message-ID: <bf21680a-1df5-b464-fcc4-a1a67cd03024@fujitsu.com>
References: <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
 <20220121125837.GV84788@nvidia.com>
 <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
 <b3b322be-a718-5fb8-11e2-05ee783f1086@fujitsu.com>
 <20220127095730.GA14946@lst.de>
 <20220127180833.GF785175@iweiny-DESK2.sc.intel.com>
 <20220128061618.GA1551@lst.de>
 <20220128191527.GG785175@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220128191527.GG785175@iweiny-DESK2.sc.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d609057-ed16-4a64-b3c0-08d9ec85736e
x-ms-traffictypediagnostic: OS3PR01MB7144:EE_
x-microsoft-antispam-prvs: <OS3PR01MB7144470304D62A42D4309401832F9@OS3PR01MB7144.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dDL4L5gja560UW0yuVuxxg69mtR9PnkvqnjKj4pjj/VSq0N0Ir7wsxtbqjpnYyqzUV74CYk5uau90xxhwWl4VB3RntcDpV67qC2Sdsdn7JYapAijcscX+AQXrkSdL+0P5Ok3LBAT8Gv0kT4fBfNLnbZLug2OSGzbFu4+LjnXiDFkFPcuKxuIkRSRHUjWimKvZjTvPYMBSl5Jd4jGan9/TNTvUF/bMpY3XFaAoVNeO+m5fts6s2Glwk80Nakib7SEE12h1XuQS7sVUfYQv5lHTAIRKAmPNfqib9SIaxVc0CsBdxo84dRePb4xmbME4E5PFB3ByCp0Q1muWgbcwOzEqrjefmfgr5TT1JvJUCskiJ/sIw9V6id8DsqIGO6KKAIGCa0G3U9gEgv+GS2X6BlScjQTKkttgRRsuUV+C8ID/oYaHA2CjxlaFANjGrEXK6ckv3ZlqUGrHMbKtd4++jBIdevZiqX/5/wWhfcoQef0q1jNLFGXPhFuIaa/vfKhilP6edLW/BcVXArhIly3Ft9sNurQ8ebGMOb9r0qy+lzSEUkfkn/3hEwxMsR7KlXj9qMwGpS0a1z0ms8i9NSONHKinS12rA5F9bbHOSmzBN6Y6mnPAqN+oZNxV1o9TlMK7P6CVtSVOEyEIsOS6kqBE7RETPY0gk1xJ3x+Bbnzx6m1dbXJhivpQcQ5EiAN+lqnpAXRvxofU+IxRWS/pLyiSw+R6Qo4dKPIDHAMIMyJcKLyq8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(31686004)(38070700005)(6512007)(54906003)(86362001)(110136005)(316002)(5660300002)(2616005)(36756003)(6486002)(38100700002)(508600001)(31696002)(6506007)(2906002)(8936002)(91956017)(83380400001)(71200400001)(26005)(66446008)(8676002)(64756008)(122000001)(76116006)(53546011)(82960400001)(186003)(4744005)(66556008)(4326008)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlJFNmJqamFNVm9UVG1EeUJnV3NBb2hyWXhmcFFZVkIvMkN5RjJGVGVCYTNI?=
 =?utf-8?B?VUdobGxCUG52Z2VUbVkyYytYN1pTVjNjWkZubjlQY0FYOElac09pOHJiRE1V?=
 =?utf-8?B?QU1RUERNT1NxQjArRDJ1SkY4aFZML08ySDJ2blo4WnVDc0hWeSt2NmtFZlRh?=
 =?utf-8?B?SXZaSXdSY0IvakgydG1IUWNXOUYyaFh1TVprTTNBV1psYW40NG1sMXZvTW1z?=
 =?utf-8?B?aUhVc3lBRlp4cGdFL0RxSlN1S3YyU0JUNGdRNW5aUzRiK3k2RVBLbWx3Y0dB?=
 =?utf-8?B?K3BtOEZFMGRMeFJBYkM3bjAzcXRrLzNKdDVQNmpkOXNhb3RabzRXK3pZYWZR?=
 =?utf-8?B?VHFKYUsrU3N4aklSOHdYSEFCLzVJSll6bTFOc0VjT1lZVldnQ1EzeEVyMUEw?=
 =?utf-8?B?WHRPemNqMzFtd29RTmd0QjlsT3lVbXdIWDZudmdzdm00U3dqTHdDN0JJbVN5?=
 =?utf-8?B?VzZhUVgzSUhaL1dGUzNWVEVNOTBnVVRjVUljUzBCM1FYZjI0dkZFWWdDZFBN?=
 =?utf-8?B?UU9mdFhOUWk0UGdlUDBLUGQ2KzVmclFUUWZTa0pxdmVPYzF3UmpkbmdHQVo0?=
 =?utf-8?B?Nis3c1c5akk0TVFuTVdheEVjdkczNTlSbXVJS0dyMTZ5UDZYcTUxaVZ2aEYz?=
 =?utf-8?B?Ym9YaUhEbHFhWEs4MmFzSU5aK1c5M2JKVkFyZHRNUHZGcU1idzZxMk5VdVo5?=
 =?utf-8?B?Q254Z1pRVmVqV0hrUkNGVjJpYTEvRmsva1c5MzUvaE8zTllSeWtsUjg0UGlw?=
 =?utf-8?B?cEttd3NuY1BlVkp5SSt0TGRSRE9NbU5INXMzbEo3STdubm1nSSt4eitPREZP?=
 =?utf-8?B?aVZ5aHNnYzJPeGw3U3ZPUFdvcVY1THJFVlhTMHJyNnl0d2V6SFNYMElCMEF0?=
 =?utf-8?B?cStwVUtoQ0xJM09hUkZxYmNUNnNPa2tOd2Q1eEVBRUQ5ajVOc2JyNUI4TERU?=
 =?utf-8?B?WlAwREJjeTUyUWl4MUZ0WlRqalpBdWkwOTV3S0x6Yk15eWRwejRWT2RtQTN6?=
 =?utf-8?B?WUlWSFBPbGFVQlFRZG1sU0N5NEFyNjdGNnVDcTdRc2xoSUxKKzVYYzd5VENM?=
 =?utf-8?B?eG5ydGd0U2dzNmZiMmRldWQ4Vml1TkI4bm9Fek94TWhqNUN6K2UyazNBbkRT?=
 =?utf-8?B?TWNJK29TVlh6SEJBVy9sOWM2bm5HSmc4QVdXQTlxdzlzdUNHZzZ1MmwyeHdw?=
 =?utf-8?B?N21vdlJHT2tucFZOVDgrNzZTNWdaeW1jL2YrWFVWc2gvNVA3U3BlMkY2RVRj?=
 =?utf-8?B?ZTdNVzNONkdXQnlNVnJFWjdwQzh2cmIxd0JIT3lJZHJyTTh3OTlpd2NLYTUv?=
 =?utf-8?B?NFVqdWZWcHlsK0RSanhKdWF2Ky9ueFpJRDA2ZDM2WWxzSDcxMWNHMFhEUEN1?=
 =?utf-8?B?Y3p3bitaOXlEeklkbVZjQWVJbmMvVG1LVDFwVGswYU1NY2pUSElLV2ZZbFVa?=
 =?utf-8?B?MjhaVllyVGs0SUJFTm5WZU9CQkJ2WTZ6Tkk1Qjd4TTMxZVM5YVBmNVFkV01O?=
 =?utf-8?B?ditNN2E2Z3NQNUo4ZDhiVWpvbkdOWmszL0QvdU96MTZlamlIUG9kNExCVHNy?=
 =?utf-8?B?ZjQ1ZEVkVHk4K3dFRnR4L0JOekdZUWpkRFU0OGpoa3h0Zmp3dnJIbWZ3MXZp?=
 =?utf-8?B?NS91OXlpVFRpMnh4Q0g1c2o1N2J0WEg5aWk2eko5ajZtVno0ZHIzSnhIRW1X?=
 =?utf-8?B?ZVg1em10SWk1Y2NnMTh4Zll6L2xsSDFtcm1IY29kVWQ1dWFYUzhSL2liR2Y1?=
 =?utf-8?B?Yis2dU9rU21sSXZJT1Fta1hGaFhZdGlFdkt4T0RTcWt3RzI4UXZFWHQvZ3Ju?=
 =?utf-8?B?SGtDemwxS1FIVUFMZW56bmxvQXkwWEc2SXdxVURFWTRmSkowUmI2ZW9oYXNU?=
 =?utf-8?B?YkdMbE9jR1FHZGxRN2NtR1BBVXJXVitpRmFpSFpHN2p3ZFJzMlVaaTVSVW1O?=
 =?utf-8?B?VXBXU1BSZ2R1blhQNStHSlZtYkVNS1dSdVk2VXJNSUVWajh3alJ2TDd2OUlK?=
 =?utf-8?B?RVpVaVhtUmpTYUcybUNtYTNSd0xmRjd5TmVRNTdWY2Q4bnJBMm9ESkJNZ1dw?=
 =?utf-8?B?ZHNKK29FN1NIWVNTWWQ3b0NQWkp1OXZsYnFaS2VTWTV2WWNkRVA4SWVxZ2dk?=
 =?utf-8?B?ZXI2bU9TQ0krMXZKaGI4TWw4Rjd1UlFyMmVKaEM1bXNBeXNxNnoyNTZhNmMw?=
 =?utf-8?Q?qgjo9mnuG1SABCRt+ZCtUoA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DB5F63B82EF9144B884338C1E1D3E92@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d609057-ed16-4a64-b3c0-08d9ec85736e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 11:06:56.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+jL5H6iyA1jx416myeH6BuAh9g3WkUblgSmiMzj8i7K7U7tGP2rtcmtptJAGk5ZEz4miZjsEG8dcvRaneMtWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7144
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzI5IDM6MTUsIElyYSBXZWlueSB3cm90ZToNCg0KPiBBaC4uLiAgb2suLi4NCj4N
Cj4gT2J2aW91c2x5IEkndmUgbm90IGtlcHQgdXAgd2l0aCB0aGUgc29mdHdhcmUgcHJvdmlkZXJz
Li4uDQo+DQo+IEZvciB0aGlzIHVzZSBjYXNlLCBjYW4ga21hcF9sb2NhbF9wYWdlKCkgd29yaz8N
Cj4NCj4gSXJhDQoNCkhpIElyYSwNCg0KSSBhcHBsaWVkIHlvdXIgcGF0Y2ggc2V0IG9uIG15IGJy
YW5jaCBidXQgaWJ2X3JlZ19tcigpIHdpdGggL2Rldi9kYXgwLjAgDQpkaWRuJ3QgdHJpZ2dlciBh
bnkgd2FybmluZyBvciBwYW5pYyBhZnRlciBlbmFibGluZyBERVZNQVBfQUNDRVNTX1BST1RFQ1RJ
T04uDQoNClBTOiBpYnZfcmVnX21yKCkgY2FsbHMgcGFnZV9hZGRyZXNzKCkgaW4ga2VybmVsLg0K
DQpEbyB5b3Uga25vdyBpZiBzb21lIGhhcmR3YXJlcyhlLmcuIENQVSkgbmVlZCB0byBzdXBwb3J0
IFBLUyBmZWF0dXJlPyBob3cgDQp0byBjaGVjayB0aGUgZmVhdHVyZSBvbiBoYXJkd2FyZXM/IG9y
IGRvIEkgbmVlZCBtb3JlIHN0ZXBzPw0KDQpCZXN0IFJlZ2FyZHMsDQoNClhpYW8gWWFuZw0K
