Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A999D534A49
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 08:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiEZGBv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEZGBu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 02:01:50 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F62AFB3F
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 23:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653544908; x=1685080908;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Dd1iH49Tg1I4GaM2FixSUleaFm9fm0lxVgFPGqrQtbg=;
  b=tH75ed+Yi/8y50hlUkGMpcPP6HgISszIY52P+esv7uBHobZ3H7+MRhYX
   jkfM3yxEn7zv+EgT87i7GzLALIzvJySLzF6r7sm8Tf8P1kudPf30J8R6b
   3w6HXpBEzZvYweJ6B0TS2BAPSCiHXzRWBXi0ho4sExCzLdfC+j3veMGNZ
   8fkPwS88Q9mJ/HaNoRdM/rXD+l59FfsY3HU+OXCVd7rr7323XkSgsPsGw
   VG8SFOjt7Z8+ZU+yBjIwA9jHQWnzkZH4khL/pB4kTqypx61cZlttW0A88
   GxGFfZF5HEAr2UL+pdmU8x5HOduHnRPUI+++xBrTgmRXn+fNcFCWaqkDT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="56627880"
X-IronPort-AV: E=Sophos;i="5.91,252,1647270000"; 
   d="scan'208";a="56627880"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 15:01:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5NnJ6ZEvMtmpvb0H40cXXAsM0Oxlx4tAfZVTfV2c0npl6MkMz18+d5dvD4B6QCqBg/wsPkg2sIUCnNsRty/wfIwvDmyexo1qR+RZg6uZZmvwzCPu6CbqPPZVGSVFkN682rEoHy6d1C1/LIuY6xTIPJsEir7wopyjeQ6ULDd1lDo3Ik+ytve4klfg0iiPHsTmXQUsgDkO4V8OgvE1o95gIf9U4oAZItP7oJqmnScRMdFN3fqxVw2PiYkvi3y3i4njasqb6f9wtFnBZqlz12kIYdFSWCBmhRlNFxZcHyai4XwNCEeNdITpNm7dVLRFVsvsoXY0BhScWnIvjjNYVZtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dd1iH49Tg1I4GaM2FixSUleaFm9fm0lxVgFPGqrQtbg=;
 b=AgcWlhQg1X0Cgoe9FdUbcK+FajpRaBQ18SH4jg9AIxkdYofkv/aq/hvM5BdD4BeA/HXmtp14oJhDKgY/XW56zVjRBqehQLSrgMVLYrRW2uSy7sogjbgvNPvAIlN2BB6errWuRUDkEXrLIsb9HTrhmHiPozbyCSEUBD3bU/FIRTf9zQP7uwjMikP5//Q04AGk60qx7VB/VlLfEPeMtJRDkIxEytaqs0M0dSYlCZrdcPKXAEpF7zKCBT3u63LE3Lc8zHsOUPmbYHNBAJjgJI4mb24UHQ9fWYCmOXxRZ7axKC3GuBuWn17U4uTXuCGy8ki3WPB3jf42lEUaUWqfnrmUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd1iH49Tg1I4GaM2FixSUleaFm9fm0lxVgFPGqrQtbg=;
 b=ms5Kq05xeSgt/yhQGem/ISht76Yr217k/mx695vGTYOYUoS56UnZU1NKeZVcdNDH9DZquVXYoAm/nXf0LfLCdftAVavidCBiiWNqrPKna4K1Yu9CrYBdzVzKTdwsdq0p+wHz6YnCMM5Lblc2jxoKfKQGvT/vc5x+nYB8jDv/kCQ=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 26 May
 2022 06:01:35 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91%3]) with mapi id 15.20.5273.023; Thu, 26 May 2022
 06:01:34 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        Frank Zago <frank.zago@hpe.com>
Subject: Re: [RFC] Alternative design for fast register physical memory
Thread-Topic: [RFC] Alternative design for fast register physical memory
Thread-Index: AQHYb72XOVxLfknNHkidJpuDRmgnX60wrEuA
Date:   Thu, 26 May 2022 06:01:34 +0000
Message-ID: <85517938-db53-3044-0993-812510676718@fujitsu.com>
References: <78918262-6060-546b-134d-2d29bbefb349@gmail.com>
In-Reply-To: <78918262-6060-546b-134d-2d29bbefb349@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69f71b72-e7a7-4a2f-0599-08da3edd302c
x-ms-traffictypediagnostic: OSZPR01MB8661:EE_
x-microsoft-antispam-prvs: <OSZPR01MB866182AF1D80A28C3307B882A5D99@OSZPR01MB8661.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NxzRvtLyK+UBtdFPA0MVJvEPKD30bM59fnnY7CZHC+Qbb8J0aY8Lgh8JEl0DSXl/Gj1d2qkXehHgk6ySsag0qQly92T6SecK+x+2z/34lGb21MMUFbumi2Ysh61W/GytApXs2KnNg1+X3+HwB6YJmKiRXrCYDb4XWsNPPFq0aDoQU++NF/W+n88SVMF/1zqKVsW5upmcKJzBknWFCpF4hUiVWM6VOkqWk8d13KRnJW7mbN0YNCc66neQM/Hx9rH017C6W9CqsdFKXw1ogSCmcR3sR784g5YCBpmb+mAT2OttuPHI7DhXPJ+Hwf/h9BcicDHAgAoboMUFk1Ixo1qowXlg9xXwiqoHGgjmbc+Glk5tG2aosp7zmm2BZs/KEiS+z11MRyyzUNoU58Pp6iLLVV308ENUS0uWX8gxdA63Om38ZVhUFSEEpET7/vRt1Rxzjs9h8YLoFrlwnSRLfcqgN8Cs4H04+6Cf2wsr6U2ti0m2aspiNWhzXj7hbX3B9By/gv+b2y8qBZ0T0Fbr8qmwGdQi+grWTph4ZSdn97KSqDYse+gN+m7wdh1tURLTHIwTkwTTJdmqWmjxUtvZaVRiNaH1l+gdr6MORhrBfWyRCrsbsSpQukSRJe+tFLj96zkYRpx/LN3iIJUUeUQDKH8KMHSe4cE0yk5/zITVU+2Qozc6mZucxIUfARnbfG7zPDUO5A/I69v4PJNtjmKPX/FTfRM6MbGUm4NUCQP7fKAz4SMbT/F+qVMmWgU4NmMN1L6m1bmiAKcRReCr/FX50ySX0EKxiDNPuWcwsLE2hDFEcY2oEpSq7OqJJ7e7N1XueB0291X4ajE8v8NmH4tvhuclfzjki2RgbauXRpJxKshL79haUWmOtHvtGqdvexLFW/KI217nWjnxeK5kzC43oZj6xw146d8ig9Wzn5oQONrzCXY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(66476007)(64756008)(76116006)(66946007)(91956017)(6512007)(8676002)(85182001)(82960400001)(66556008)(86362001)(66446008)(26005)(71200400001)(6506007)(31686004)(36756003)(122000001)(53546011)(38100700002)(966005)(316002)(508600001)(6486002)(38070700005)(8936002)(110136005)(83380400001)(186003)(2906002)(5660300002)(2616005)(116466001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhIakY3Y3FsK09SbnRhVGx1czlUelg5M20ranMrWU1HYyt0VFhta0QzVDNj?=
 =?utf-8?B?empEQ0tidE1RVVh4ZDc4M2IzVEMrRXg4dHdPWUwrZU9Dc1NTYVdxZE1mKzlm?=
 =?utf-8?B?WWFobjFJMW42NVJwRHhSR2Z1S1RmeWwvdDBjNUgvSDFSbUpNTjBZS0tCUGh3?=
 =?utf-8?B?NExTUjN3T3JJMXlETUdOZEthcnpYMkd0WjFRTkFvZXc3bUVCcnV2alNxMjRZ?=
 =?utf-8?B?bmZxczdUZTZLWk1ybWlINmgzWTdyRiswNjFuUGh4cDNXaUlPNXhMYTNyUmwr?=
 =?utf-8?B?OW5NZFVNYXpKV0xHS2ZpeHM0NHYwNUZJZDFUcVlqK0hncnpCcHEwZk5QdEx3?=
 =?utf-8?B?TjdMQ3ovZkJDbFBKaDZsdlg1V0JRQ0VzcGNsbko0MXhYRTk3MTI2aUU1RE9j?=
 =?utf-8?B?d2ZEU0E2SnlTK0hQZWV6SU1oVnhPdk5XcVhLT1MrOTRkMm9vcXBVbEtaVlFS?=
 =?utf-8?B?Si95ZVRlM2tYSTdYbnFKYkMrK0tmOERvc2dyTnJjQnhtQVlMTW02bXFyUDVL?=
 =?utf-8?B?bjAvajI2M1RrK1ZvTmxCSFQ4M1FHd2hjSVl3c2JQL0hNQUdJcTRTZnNjbVM2?=
 =?utf-8?B?cEV5RkVkdFdjWjZFMjhtVGVpMWRoWXl4RUpBY0Y3d1lNL0ZRMWpJM0hTZS9T?=
 =?utf-8?B?MlExMEV1TFdmWWtKaGxSbk9mZWhIaWVCajZ0WDV5SDd0MjlLTnk2bEpzY21o?=
 =?utf-8?B?OWJaa3dOMitCUnNYZEkrK090RVNhYWoxYUkwVFF5dFhQSnQrbXAreHB4bnlE?=
 =?utf-8?B?SzZVSS9LbWpCbTdZZlQrcUl5YklleUdqRXBqWStlRTBxYmV6Z2N3TjBWYlRD?=
 =?utf-8?B?WSt5aU5OUmx4Z0Z6Qk9XLy9iV013cDZOak1GRlFjUldqeTZsM2VmaksyMFU2?=
 =?utf-8?B?d0xaRTlQWkZSdVpLdWtZVUpESldua2F3M0FXM0NGVk5tYW9tbGlJeXArNEU2?=
 =?utf-8?B?YzRJcTkrVVIvTWgrZ2dMbVl1a1BGZlVJSWI2UzFhcWtncnN6S1Y4VWdiQlV6?=
 =?utf-8?B?ZE5OREhrRml0cVlBMllPMmJVdjFYb3krdXFHM1RaU3pFdXEyRHd6OEdxcGJl?=
 =?utf-8?B?YnZINkVidWphd1laL1hha2NQMTEya01wNmZJbE1nUnhTZTRpaE1mYUJRZkhV?=
 =?utf-8?B?RTVyN0VvQWxKV3U2YXIyUjNCMG9FQWl3R2hBT3FCLytydnNOSFNLc0dMOVlR?=
 =?utf-8?B?bmtnaURsSzNRcnllTXd6ZHFpblZhY09kUkRuUmYxWEhDSjFTc0gzNnhOV2JL?=
 =?utf-8?B?MXl2ODRjN3AzK0dnbEp1UmYzOFp5TmFvNWQyM2dWb0JBMnRBVzdxbzYvTzhp?=
 =?utf-8?B?ajVPSGkxWEJSS2FVVHppa25jd3dXeWVzSkRzUGpURUIvNWsyRk1yVVArVEN1?=
 =?utf-8?B?SnlaMVpiR3JrVVcrVUwxZWxHSkV4dWtnaHVuT0E0YVZobTJkeWhhQThkWjJG?=
 =?utf-8?B?S3o4Ny85MnIrbUd6Q2FQdHpRWnBvbzROQnloUDA2L3Z5STRuNk9pQUlZWUtC?=
 =?utf-8?B?L0p4QWNkK0VVbmpVR21jVnczczNGbDJnd2o5VWZ5TzMwdElxMnYzcnBpS1M1?=
 =?utf-8?B?VmhxRGJtQkdmRmI3Q2FiQmVSWkdHVTd4RElnMUpmOU5aREhmM0RlVjJJU1VN?=
 =?utf-8?B?cDlNWjFUQnUycjR2QmhWWlhoS1NlZlRaZW5KOXpZMVB4ZjJWSmxYeUw1NVRV?=
 =?utf-8?B?eW9DYjk1L2RTYnQzbDVDQ1pGMGFGK1lqYUUwb2JPTEgwaEJKbmFVN0VDU1BQ?=
 =?utf-8?B?cVZmRVFvSnZjQTRXazAwZXlHSjdXOHIraWlldW1YZlFmSEprdXNsamFyWGVY?=
 =?utf-8?B?djhmS0hRUlg3cjB1dzg2cHpPY2JOcFlvQUZSSnE5ZnM0cDZGbVJHSWZPV1Q2?=
 =?utf-8?B?cUJoMmhxWUIrYUJuelpWekVGazh0Z1JVbndDb0htaDdFcWRIYkIvb1FNSVBw?=
 =?utf-8?B?ZEZMdnY1bVp5c1VRbjFhZFpDc0FkMUNtdUVPYXVCaVBhNCtxREUzVXNRNkdG?=
 =?utf-8?B?ODd6NFo2WkZaa05TdDgralFhVFRremdxZWlJZy9FSE9PdEFrcW5QbXB2cnBo?=
 =?utf-8?B?R3YvUXNRNjk5bXpGc1B5My9uM1RRU1cvUDVHc1BHaHM0NEJ1akJxUXhZV2Ir?=
 =?utf-8?B?Z1JKNmc0ZFJvdVZxLzVIeHNsYmtLZXlFTTJ6TjU4S0dtK1VpbjRHb2NicnRy?=
 =?utf-8?B?c2s3a1ZURVoxcjhvUVR4UERLVlIzeEtEWS9ZMktBKzNrMTNmZUM0WjFZc0Nw?=
 =?utf-8?B?N3J4QWJZUGVzOWptUDdKTXhrR1BnVjd4YWwrWVZLRVBpVzZ3MkJVa0ZYTnYx?=
 =?utf-8?B?SFZRSXVORVpzZGM4a01MVE9XcjJ3Zjg4MEpYVW5vTXNDZmtmUDgzNjl0VklD?=
 =?utf-8?Q?8YoTXZmf7Vg1m43c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DE6A8347A2A7548AF63CCAD267BBEC5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f71b72-e7a7-4a2f-0599-08da3edd302c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 06:01:34.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIqNklWMiNANlnuWKaNRFnAGNZpn7iuQyld6C2QENRJ1Fvvhw64L0s/OW6yUiwr3LTGWR749qq6YKEzdGXDXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI1LzA1LzIwMjIgMDY6MjgsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBKYXNvbiwNCj4N
Cj4gVGhlcmUgaGFzIGJlZW4gYSBsb3Qgb2YgY2hhdHRlciBvbiB0aGUgRk1ScyBpbiByeGUgcmVj
ZW50bHkgYW5kIEkgYW0gYWxzbyB0cnlpbmcgdG8gaGVscCBvdXQgYXQgaG9tZSB3aXRoDQo+IHRo
ZSBmb2xrcyB3aG8gYXJlIHRyeWluZyB0byBydW4gTHVzdHJlIG9uIHJ4ZS4gVGhlIGxhc3QgZml4
IGZvciB0aGlzIHdhcyB0byBzcGxpdCB0aGUgc3RhdGUgaW4gYW4gRk1SIGludG8NCj4gdHdvIHdp
dGggc2VwYXJhdGUgcmtleXMgYW5kIG1lbW9yeSBtYXBzIHNvIHRoYXQgYXBwcyBjYW4gcGlwZWxp
bmUgdGhlIHByZXBhcmF0aW9uIG9mIElPIGFuZCBkb2luZyBJTy4NCj4NCj4gSG93ZXZlciwgSSBh
bSBjb252aW5jZWQgdGhhdCB0aGUgY3VycmVudCBkZXNpZ24gb25seSB3b3JrcyBieSBhY2NpZGVu
dCB3aGVuIGl0IHdvcmtzLiBUaGUgdGhpbmcgdGhhdCByZWFsbHkNCj4gbWFrZXMgYSBoYXNoIG9m
IGl0IGlzIHJldHJpZXMuIFVuZm9ydHVuYXRlbHkgdGhlIGRvY3VtZW50YXRpb24gb24gYWxsIHRo
aXMgaXMgYWxtb3N0IG5vbiBleGlzdGVudC4gTHVzdHJlDQo+IChhY3R1YWxseSBvMmlibG5kKSBt
YWtlcyBoZWF2eSB1c2Ugb2YgRk1ScyBhbmQgdHlwaWNhbGx5IGhhcyBzZXZlcmFsIGRpZmZlcmVu
dCBNUnMgaW4gZmxpZ2h0IGluIHRoZSBzZW5kIHF1ZXVlDQo+IHdpdGggYSBtaXh0dXJlIG9mIGxv
Y2FsIGFuZCByZW1vdGUgd3JpdGVzIGFjY2Vzc2luZyB0aGVzZSBNUnMgaW50ZXJsZWF2ZWQgd2l0
aCBSRUdfTVJzIGFuZCBJTlZBTElEQVRFX01SIGxvY2FsDQo+IHdvcmsgcmVxdWVzdHMuIFdoZW4g
YSBwYWNrZXQgZ2V0cyBkcm9wcGVkIGZyb20gYSBXUUUgZGVlcCBpbiB0aGUgc2VuZCBxdWV1ZSB0
aGUgcmVzdWx0IGlzIG5vdGhpbmcgd29ya3MgYXQgYWxsLg0KPg0KPiBXZSBoYXZlIGEgd29yayBh
cm91bmQgYnkgZmVuY2luZyBhbGwgdGhlIGxvY2FsIG9wZXJhdGlvbnMgd2hpY2ggbW9yZSBvciBs
ZXNzIHdvcmtzIGJ1dCB3aWxsIGhhdmUgYmFkIHBlcmZvcm1hbmNlLg0KPiBUaGUgbWFwcyB1c2Vk
IGluIEZNUnMgaGF2ZSBmYWlybHkgc2hvcnQgbGlmZXRpbWVzIGJ1dCBkZWZpbml0ZWx5IGxvbmdl
ciB0aGFuIHdlIHdlIGNhbiBzdXBwb3J0IHRvZGF5LiBJIGFtDQo+IHRyeWluZyB0byB3b3JrIG91
dCB0aGUgc2VtYW50aWNzIG9mIGV2ZXJ5dGhpbmcuDQo+DQo+IElCQSB2aWV3IG9mIEZNUnM6DQo+
DQo+IHZlcmI6IGliX2FsbG9jX21yKHBkLCBtYXhfbnVtX3NnKQkJCS0gY3JlYXRlcyBlbXB0eSBN
UiBvYmplY3QNCj4gCXJvdWdobHkgQWxsb2NhdGUgTF9LZXkNCj4NCj4gdmVyYjogaWJfZGVyZWdf
bXIobXIpCQkJCQktIGRlc3Ryb3lzIE1SIG9iamVjdA0KPg0KPiB2ZXJiOiBpYl9tYXBfbXJfc2co
bXIsIHNnLCBzZ19uZW50cywgc2dfb2Zmc2V0KQkJLSBidWlsZHMgYSBtYXAgZm9yIE1SDQo+IAly
b3VnaGx5IChSZSlSZWdpc3RlciBQaHlzaWNhbCBNZW1vcnkgUmVnaW9uDQo+DQo+IHZlcmI6IGli
X3VwZGF0ZV9mYXN0X3JlZ19rZXkobXIsIG5ld2tleSkJCS0gdXBkYXRlIGtleSBwb3J0aW9uIG9m
IGwvcmtleQ0KPg0KPiBzZW5kIHdyOiBJQl9XUl9SRUdfTVIobXIsIGtleSkJCQkJLSBtb3ZlcyBN
UiBmcm9tIEZSRUUgdG8gVkFMSUQgYW5kIHVwZGF0ZXMNCj4gCXJvdWdobHkgRmFzdCBSZWdpc3Rl
ciBQaHlzaWNhbCBNZW1vcnkgUmVnaW9uCSAga2V5IHBvcnRpb24gb2YgbC9ya2V5IHRvIGtleQ0K
Pg0KPiBzZW5kX3dyOiBJQl9XUl9MT0NBTF9JTlYoaW52YWxpZGF0ZV9ya2V5KQkJLSBpbnZhbGlk
YXRlIGxvY2FsIE1SIG1vdmVzIE1SIHRvIEZSRUUNCj4NCj4gc2VuZF93cjogSUJfU0VORF9XSVRI
X0lOVihpbnZhbGlkYXRlX3JrZXkpCQktIGludmFsaWRhdGUgcmVtb3RlIE1SIG1vdmVzIE1SIHRv
IEZSRUUNCj4NCj4NCj4gVG8gbWFrZSB0aGlzIGFsbCByZWNvdmVyYWJsZSBpbiB0aGUgZmFjZSBv
ZiBlcnJvcnMgbGV0IHRoZXJlIGJlIG1vcmUgdGhhbiBvbmUgbWFwIHByZXNlbnQgZm9yIGFuDQo+
IEZNUiBpbmRleGVkIGJ5IHRoZSBrZXkgcG9ydGlvbiBvZiB0aGUgbC9ya2V5cy4NCj4NCj4gQWx0
ZXJuYXRpdmUgdmlldyBvZiBGTVJzOg0KPg0KPiB2ZXJiOiBpYl9hbGxvY19tcihwZCwgbWF4X251
bV9zZykJCQktIGNyZWF0ZSBhbiBlbXB0eSBNUiBvYmplY3Qgd2l0aCBubyBtYXBzDQo+IAkJCQkJ
CQkgIHdpdGggbC9ya2V5ID0gW2luZGV4LCBrZXldIHdpdGggaW5kZXgNCj4gCQkJCQkJCSAgZml4
ZWQgYW5kIGtleSBzb21lIGluaXRpYWwgdmFsdWUuDQo+DQo+IHZlcmI6IGliX3VwZGF0ZV9mYXN0
X3JlZ19rZXkobXIsIG5ld2tleSkJCS0gdXBkYXRlIGtleSBwb3J0aW9uIG9mIGwvcmtleQ0KPg0K
PiB2ZXJiOiBpYl9tYXBfbXJfc2cobXIsIHNnLCBzZ19uZW50cywgc2dfb2Zmc2V0KQkJLSBjcmVh
dGUgYSBuZXcgbWFwIGZyb20gYWxsb2NhdGVkIG1lbW9yeQ0KPiAJCQkJCQkJICBvciBieSByZS11
c2luZyBhbiBJTlZBTElEIG1hcC4gTWFwcyBhcmUNCj4gCQkJCQkJCSAgYWxsIHRoZSBzYW1lIHNp
emUgKG1heF9udW1fc2cpLiBUaGUNCj4gCQkJCQkJCSAga2V5IChpbmRleCkgb2YgdGhpcyBtYXAg
aXMgdGhlIGN1cnJlbnQNCj4gCQkJCQkJCSAga2V5IGZyb20gbC9ya2V5LiBUaGUgaW5pdGlhbCBz
dGF0ZSBvZg0KPiAJCQkJCQkJICB0aGUgbWFwIGlzIEZSRUUuIChhbmQgdGh1cyBub3QgdXNhYmxl
DQo+IAkJCQkJCQkgIHVudGlsIGEgUkVHX01SIHdvcmsgcmVxdWVzdCBpcyB1c2VkLikNCj4NCj4g
dmVyYjogaWJfZGVyZWdfbXIobXIpCQkJCQktIGZyZWUgYWxsIG1hcHMgYW5kIHRoZSBNUi4NCj4N
Cj4gc2VuZF93cjogSUJfV1JfUkVHX01SKG1yLCBrZXkpCQkJCS0gRmluZCBtci0+bWFwW2tleV0g
YW5kIGNoYW5nZSBpdHMgc3RhdGUNCj4gCQkJCQkJCSAgdG8gVkFMSUQuIEFzc29jaWF0ZSBRUCB3
aXRoIG1hcCBzaW5jZQ0KPiAJCQkJCQkJICBpdCB3aWxsIGJlIGhhcmQgdG8gbWFuYWdlIG11bHRp
cGxlIFFQcw0KPiAJCQkJCQkJICB0cnlpbmcgdG8gdXNlIHRoZSBzYW1lIE1SIGF0IHRoZSBzYW1l
DQo+IAkJCQkJCQkgIHRpbWUgd2l0aCBkaWZmZXJpbmcgc3RhdGVzLiBGYWlsIGlmIHRoZQ0KPiAJ
CQkJCQkJICBtYXAgaXMgbm90IEZSRUUuIEEgbWFwIHdpdGggdGhhdCBrZXkgbXVzdA0KPiAJCQkJ
CQkJICBoYXZlIGJlZW4gY3JlYXRlZCBieSBpYl9tYXBfbXJfc2cgd2l0aA0KPiAJCQkJCQkJICB0
aGUgc2FtZSBrZXkgcHJldmlvdXNseS4gQ2hlY2sgdGhlIGN1cnJlbnQNCj4gCQkJCQkJCSAgbnVt
YmVyIG9mIFZBTElEIG1hcHMgYW5kIGlmIHRoaXMgZXhjZWVkcw0KPiAJCQkJCQkJICBhIGxpbWl0
IHBhdXNlIHRoZSBzZW5kIHF1ZXVlIHVudGlsIHRoZXJlDQo+IAkJCQkJCQkgIGlzIHJvb20gdG8g
cmVnIGFub3RoZXIgTVIuDQo+DQo+IHNlbmRfd3I6IElCX1dSX0xPQ0FMX0lOViAoZXhlY3V0ZSkJ
CQktIExvb2t1cCBhIG1hcCB3aXRoIHRoZSBzYW1lIGluZGV4IGFuZCBrZXkNCj4gCQkJCQkJCSAg
Q2hhbmdlIGl0cyBzdGF0ZSB0byBGUkVFIGFuZCBkaXNzb2NpYXRlDQo+IAkJCQkJCQkgIGZyb20g
UVAuIExlYXZlIG1hcCBjb250ZW50cyB0aGUgc2FtZS4NCj4gCQkJIChjb21wbGV0ZSkJCQktIFdo
ZW4gdGhlIGxvY2FsIGludmFsaWRhdGUgb3BlcmF0aW9uIGlzDQo+IAkJCQkJCQkgIGNvbXBsZXRl
ZCAoYWZ0ZXIgYWxsIHByZXZpb3VzIHNlbmQgcXVldWUgV1FFcw0KPiAJCQkJCQkJICBoYXZlIGNv
bXBsZXRlZCkgY2hhbmdlIGl0cyBzdGF0ZSB0byBJTlZBTElEDQo+IAkJCQkJCQkgIGFuZCBwbGFj
ZSBtYXAgcmVzb3VyY2VzIG9uIGEgZnJlZSBsaXN0IG9yDQo+IAkJCQkJCQkgIGZyZWUgbWVtb3J5
Lg0KPg0KPiBzZW5kX3dyOiBJQl9TRU5EX1dJVEhfSU5WCQkJCS0gc2FtZSBleGNlcHQgYXQgcmVt
b3RlIGVuZC4NCj4NCj4gcmV0cnk6CQkJCQkJCS0gaWYgYSByZXRyeSBvY2N1cnMgZm9yIGEgc2Vu
ZCBxdWV1ZS4gQmFjayB1cA0KPiAJCQkJCQkJICB0aGUgcmVxdWVzdGVyIHRvIHRoZSBmaXJzdCBp
bmNvbXBsZXRlIFBTTi4NCj4gCQkJCQkJCSAgQ2hhbmdlIHRoZSBzdGF0ZSBvZiBhbGwgbWFwcyB3
aGljaCB3ZXJlDQo+IAkJCQkJCQkgIFZBTElEIGF0IHRoYXQgUFNOIGJhY2sgdG8gVkFMSUQuIFRo
aXMgd2lsbA0KPiAJCQkJCQkJICByZXF1aXJlIG1haW50YWluaW5nIGEgbGlzdCBvZiB2YWxpZCBt
YXBzDQo+IAkJCQkJCQkgIGF0IHRoZSBib3VuZGFyeSBvZiBjb21wbGV0ZWQgYW5kIHVuLWNvbXBs
ZXRlZA0KPiAJCQkJCQkJICBXUUVzLg0KPg0KPiBBcnJpdmFsIG9mIFJETUEgcGFja2V0CQkJCQkg
IExvb2t1cCBNUiBmcm9tIGluZGV4IGFuZCBtYXAgZnJvbSBrZXkgYW5kIGlmDQo+IAkJCQkJCQkg
IHRoZSBzdGF0ZSBpcyBWQUxJRCBjYXJyeSBvdXQgdGhlIG1lbW9yeSBjb3B5Lg0KPg0KPg0KPiBU
aGlzIGlzIGFuIGltcHJvdmVtZW50IG92ZXIgdGhlIGN1cnJlbnQgc3RhdGUuIEF0IHRoZSBtb21l
bnQgd2UgaGF2ZSBvbmx5IHR3byBtYXBzIG9uZSBmb3IgbWFraW5nIG5ldw0KPiBvbmVzIGFuZCBv
bmUgZm9yIGRvaW5nIElPLiBUaGVyZSBpcyBubyByb29tIHRvIGJhY2sgdXAgYnV0IGF0IHRoZSBt
b21lbnQgdGhlIHJldHJ5IGxvZ2ljIGFzc3VtZXMgdGhhdA0KPiB5b3UgY2FuIHdoaWNoIGlzIGZh
bHNlLiBUaGlzIGNhbiBiZSBmaXhlZCBlYXNpbHkgYnkgZm9yY2luZyBhbGwgbG9jYWwgb3BlcmF0
aW9ucyB0byBiZSBmZW5jZWQNCj4gd2hpY2ggaXMgd2hhdCB3ZSBhcmUgZG9pbmcgYXQgdGhlIG1v
bWVudCBhdCBIUEUuIFRoaXMgY2FuIGluc2VydCBsb25nIGRlbGF5cyBiZXR3ZWVuIGV2ZXJ5IG5l
dyBGTVIgaW5zdGFuY2UuDQo+IEJ5IGFsbG93aW5nIHRocmVlIG1hcHMgYW5kIHRoZW4gZmVuY2lu
ZyB3ZSBjYW4gYmFjayB1cCBvbmUgYnJva2VuIElPIG9wZXJhdGlvbiB3aXRob3V0IHRvbyBtdWNo
IG9mIGEgZGVsYXkuDQoNCkhpIEJvYg0KDQpJIHRob3VnaHQgaSBoYXZlIGFsbW9zdCB1bmRlcnN0
b29kIGFsbCB5b3VyIGFwcHJvYWNoIGV4cGVjdCB0aGUgKnJldHJ5L2JhY2sgdXAqIHBhcnQgaW4g
d2hlcmUgaSBoYXZlIG5vdCBoYXZlIGEgZnVsbCBpbWFnaW5hdGlvbi4NCkl0IHNvdW5kcyBnb29k
IHRvIG1lLg0KQnV0IGkgdGhpbmsgdGhlICpyZXRyeSogc2hvdWxkIGJlIGEgbmV3IGZlYXR1cmUg
dG8gb3VyIGV4aXN0aW5nIGJ1ZyByZXBvcnRzIGFib3V0IEZNUnMgd2hlcmUgdGhleSBhbGwgd2Vy
ZSB0cnlpbmcgdG8gZml4Lg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwMjEwMDcz
NjU1LjQyMjgxLTEtZ3VvcWluZy5qaWFuZ0BsaW51eC5kZXYvVC8NCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9kZmJhN2ViNy04NDY3LTU5YjUtMmMyYS0wNzFlZDFlNDk0OWZAZ21haWwuY29t
L1QvDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzk0YTVlYTkzLWI4YmItM2EwMS05NDk3
LWUyMDIxZjI5NTk4YUBsaW51eC5kZXYvdC8NCg0KSSdtIGNvbnZpbmNlZCB0aGF0IHRoaXMgYXBw
cm9hY2ggY2FuIGhlbHAgb24gdGhpcyBidWcsIHNoYWxsIHdlIGZvY3VzIG9uIGZpeGluZyB0aGUg
YWJvdmUga25vd24gRk1ScyBidWcgZmlyc3QsIGFuZCB0aGVuIGltcHJvdmUgdGhlICpyZXRyeSog
ZmVhdHVyZS4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPg0KPiBFdmVuIGlmIHlvdSBoYXZlIGEg
Y2xlYW4gbmV0d29yayB0aGUgY3VycmVudCBkZXNpZ24gb2YgdGhlIHJldHJhbnNtaXQgdGltZXIg
d2hpY2ggaXMgbmV2ZXIgY2xlYXJlZCBhbmQgd2hpY2gNCj4gY2FuIGZpcmUgZnJlcXVlbnRseSBj
YW4gbWFrZSBhIG1lc3Mgb2YgTUIgc2l6ZWQgSU9zIHVzZWQgZm9yIHN0b3JhZ2UuDQo+DQo+IEJv
Yg0K
