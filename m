Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B47DB49B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjJ3Hvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjJ3Hvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 03:51:51 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAD2A7;
        Mon, 30 Oct 2023 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698652308; x=1730188308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SDOcyHlV5GjFPQi5a3evHdXtpz3INplAIgDaq6SyQy0=;
  b=uGNo6mJpRbl5Tl06Uy5gy2Yfy6PVO5M7duQARUeizdLb+TI5x4RMDGWP
   yKBREIJ7NPVrzeUzHSa4IDyHKLm7ttuO3sNtWj+f4Eckem/Y4cK08bgWS
   4JPrnmNqun9kDAMPpCP/V/JBA3hWmWJn9IeHxcHnb26XM52GDjtTGaLZX
   tEbQXNWwZRgfAoNVsyrhtdFeZXZevNv+mGTu3nPsapTZtY9Lq61sfA/W5
   KjHTkufsYzrhzF3jQcc4BFFQlQB7x2H6QoS33/1RihU16QMs7iHCq3YF+
   yWVD3MxDJXHtBBgibq9e07mg4sUYJ8E3MgX0ZZ0p38rur2toRQp+G64js
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="104250033"
X-IronPort-AV: E=Sophos;i="6.03,263,1694703600"; 
   d="scan'208";a="104250033"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 16:51:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na9BYbmYB821d86ZLFEa0zyzMpd8ClG4JCV/wsBml1U2bzKJE2EHMjYMgtu/NN4i5LTw38BzTuzQAPmH7hfFsm5lHPx/RH/JsbUlZG+/w16WP1Apse3fqQqzoE4e016JJsNSCiA8OpWL5g4agDMMcgsNl4663juCm1+7yp0eiCXkKmq3JTA3zXywZ17WEqjuK3hLMJp+pbZ5cdvcAi6CV9eXRFPfyoYeEPXPhVH/P++9LcGDFvuvNgScCPu9bEtbcoQ2bpmhqqG+AHp2363BU+nrFEe3Hh5ndihimXneuSbSoQybrqlguAMYGME6qaIMcdVepFyZHJja/mTrZ8GHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDOcyHlV5GjFPQi5a3evHdXtpz3INplAIgDaq6SyQy0=;
 b=k4QIwrLqVnrI1jxvISpHV0FcNIdKPOSlhjPgFYtq9a5MALEoEK7Nf7aRlmkc/EjSN3cplUoyhoSfJ5gicIA3Xwk0NecKTRX0MvOUIxhMmMINdxlBdkv7bcG9EbWhKF6ZmJMiFaNei0g19bFxO4hqlKxUECerx+i6N5ReBf9DbcrDAL0/ki2NhEChZSX9DhE4lm2AyKhMEj4qD9QLeZWNsMm7b30Kc875P83iscbfbxf9K/YtE4yMBhbK94l3NxgcHFLzKdSpew91cXHwUjEcN/NbinWxHalJeZXsb3HWszc0+QsAn+dP5Pf2lmUKbJ/w+NY8T412qsWlONUOjh6WrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13)
 by OS3PR01MB8413.jpnprd01.prod.outlook.com (2603:1096:604:191::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Mon, 30 Oct
 2023 07:51:41 +0000
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::7100:d925:a063:566f]) by OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::7100:d925:a063:566f%6]) with mapi id 15.20.6933.020; Mon, 30 Oct 2023
 07:51:41 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Thread-Topic: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Thread-Index: AQHaCJhTvrj5SCKGZEeB5zGuZXPZvLBh+qQA
Date:   Mon, 30 Oct 2023 07:51:41 +0000
Message-ID: <4da48f85-a72f-4f6b-900f-fc293d63b5ae@fujitsu.com>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
In-Reply-To: <20231027054154.2935054-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5445:EE_|OS3PR01MB8413:EE_
x-ms-office365-filtering-correlation-id: bbcb58f8-9e90-41f8-7f13-08dbd91d0de8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnIMA9mVMor4EUVQKa96yAg+eMBIHx1RaenQq28JDPvn0ttnoncl13pBNhRsJN2KIycW8tQA+iCawekXEIvW5v0mXjacylDDgY3TEP73mWkJefo8ZTgnPgpg7/VWuXPgUatH8zwiVUJ3olAYrzn/D7gMW1NKP07GQcsTGetjxmtSDS8j5xO6mwGQn5U4mygtH8GikHByh9vhlGK0kxVGUtg+hyVOrevkKuGZfjOcmUkQO+QITjLTuS4Zw5Mlrd5vk8OPIGRXgmjNh5iX4R+aQNJ2rAfJ9hqkSDN+CnsLwtqwLndTLC8kpZwLc8piYgLE2f6C/Py6SARZiMkoNZIekm4neWJwIam+7z/P5azYxfKB7fq2HlYxZTB8WhS0w3nQFddRAiUoRu4pzCI6wqmgE6WAbA4KtVvGVRSJxf9fNY1ZtyCceI0JJrH9GC6Jb8KoW7fUigq2tVB0QAmxKOMoMduK4Y6974Ei38JVt/M8LTDB8E+KkJX7xeMS6A+cLaMB/mBQshre09n/36Rn+p7y25YrqhRbmRqkMbLpO9ASIw8t12ONSbfNud+Mh7tIjxKQHxTUnXumlrWF2o4un4zlWk0+PKflKqANXpCOfw5d6EZLLC+WkZj+q71IC8FwIFU9am5ZbRka0w8urY7pivrAPxB/w8P8X6MY23LhW/27w9jHfb4w0e1NhtB34HZCjzwyOOqaabEGMI9WINMkqa4+Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5445.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799009)(1590799021)(186009)(64100799003)(451199024)(2616005)(85182001)(31686004)(26005)(6512007)(38100700002)(5660300002)(8676002)(8936002)(4326008)(53546011)(36756003)(54906003)(91956017)(110136005)(66556008)(76116006)(38070700009)(66946007)(66476007)(6506007)(66446008)(41300700001)(2906002)(64756008)(82960400001)(316002)(122000001)(6486002)(478600001)(1580799018)(86362001)(31696002)(83380400001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2hyWEJYUkFWZTBWTDJjTStuWThvYzl3TVRPSXM0VWxQSXJIL09KdFV4TVZm?=
 =?utf-8?B?cGd3ZW50RlRXZzQ2RW5ydHBLOXpXUHo0aVhxUUdvYWFKN3BhVllGWHZ2d0ZX?=
 =?utf-8?B?elFnQnlBOHpUUlhNOUZxZHpJdFg0M0RWeVgvZzBSbG44eTU1b2ZFcm1pOHlq?=
 =?utf-8?B?T3VnQ3NOSGRLU3BWc0RIbDJ0aVpsYlJGK3hMZEdOcUFsVlYrbjhZbkdpc3ZQ?=
 =?utf-8?B?UzdocHJMdkk2MXVLa25iWlNvWjBRc3QvMVBSWG1tMmZZSnZ6L3Z2cXY3SkJO?=
 =?utf-8?B?WWJDVHFUOEhrSS9MblQ2QXNublhjTTBoWWsyT1d4S3Y2OHM3UFZZYVRRRVQz?=
 =?utf-8?B?d2Z3QklQNFdnWlJGK1NDRVlMNHVUQUNNZEZ4c0kvR0IvNE1rdTFGR0N4MDV3?=
 =?utf-8?B?QjlCaW9FMndsdWFVUFpla1JEa0FlUzJ1UW5CWmZ5NGRxc1VMTkVucnRQd1F2?=
 =?utf-8?B?VFE2VU1sSW5NcVVuNjYxMEY5UHRvUHByRWY4UGMvUTUycnNWR1paWlpLVzBR?=
 =?utf-8?B?a1ZTeUt5VGRaZkYrQjJnU1FoNUF6ZjU0NFdISHJBSFNLczZ5WENCMWdHK3Vj?=
 =?utf-8?B?YW9EaGM5TFE3MGVEM0tpZWdydDJBVEErZXJGV1h5MnJnanl5MEJpVVQ3THpR?=
 =?utf-8?B?eVNTYWJ6MTM3K3U2bTRUa2lWd2N2dEFWVHhaeTJRL3lZY0RKNS9VakFBVU1T?=
 =?utf-8?B?cmFEZUlad2pucGVyZDJSdUZrY1lVNExIUzgxN01uSWNGVkFKSCt5UlhlSmEz?=
 =?utf-8?B?aTRSQkx0MDJsNnBvWGQ1MmRybm90SzhZWlpDelp5ZndhcFNWdGFhdVRWMjg5?=
 =?utf-8?B?RWVtTlJoazdGNTZWVzY4S1l0RkVveFEwaWhySlcwRkQ5VnZOVmUxdHd0NWxr?=
 =?utf-8?B?YkFXcFREM3o4NlBsVkd3Rk4yckNjLzd2NmYvTy8rNi9OdGF6RnlLemZRTWhK?=
 =?utf-8?B?YVNla0UxRUFHdVBoRmF0cmRhSnZqWFJJbTU0YVp3MjBsYWZUMStCU2VuRVpM?=
 =?utf-8?B?a24zTTdmNnZhY2pseWFUd045cVpGU2VXMVNUbnBrTkpTbGc5bkcxSjNBbGNW?=
 =?utf-8?B?RlN6WnNkVDF2S0ZIZTZadmJDcjBiVVllYm4xamN1SitTNWdROFdzakd1QUta?=
 =?utf-8?B?UEF3bm11Qk5ONG53cVk0UFdQdVVyUm1NV00rNTNMcUppRlFzSmJ6TENZQ1lr?=
 =?utf-8?B?bTZ3WU9UTW1CdURVcTJYcE0rdGdWQzRyUGdLT2psZmdTNVhXRXI3VDBnbGgy?=
 =?utf-8?B?UkVYMVE3eC8yWjV5Ym4zZGVybjZpNklxaTFxMko1dHVSYkNvMWp3QXo1eEJJ?=
 =?utf-8?B?SDV0dEVzU1FuL1o1RkVMNmNFWFZMRzMvMjk0eVl0SFoyQWV5ckZuRlhXSmNa?=
 =?utf-8?B?MGRlNWdiai9tdzlRSUYrWVlGYmtxeTZaRENSb2tlOHRCOEY5TW1UNkxRcnZH?=
 =?utf-8?B?bGJ5RE9PTDh1WmxlS0M0ZFpXV2dHWTdQWEJuM2Y4SlpFU1FzMVJ4T1ZPMG01?=
 =?utf-8?B?bjRxSjNGeitoM2V5b2N5QTkrZFVqVHBWODBub3F1UE82TC9hVzVQV0lxbEVD?=
 =?utf-8?B?WmNWUlJGQ3VrNVRwMlFLRjBPN2hVUXYwL1ZEK3NSeTRMck10dGZhU0UzTDZ3?=
 =?utf-8?B?YksyQVNHOTh0dmw5UlRjdGVFZjVMUHZLcGVtQTIvSWxNUVVqUWRWeGcyTWor?=
 =?utf-8?B?T2ZaYU1KOXFITFZpa1dVbUFJTUdrM0ljcUxYRWxGQkJvYlFveFgyUmJhR3Jk?=
 =?utf-8?B?NERNSGYxWVBtMUxKeWFrNDVpTWRoMjRHUjd5R2RuUkxocVE0UjQ5bktmamVx?=
 =?utf-8?B?aGY0WkVTcmYxc1VyVm0zRlM5K05obUgrQ241U3AybzRXQm51b3ZDbXRtUFhD?=
 =?utf-8?B?REk4T2hLanU5SjdvOWtqRUx4NmRRYmxQTHNqcTZIR3RsOGxaYWFHRHhxTjVn?=
 =?utf-8?B?RHdhbndoOFBHdGlJZHd6am4rYlRidUZ0NjhuKysraXF6K2g5SStlVkFYTHFu?=
 =?utf-8?B?cFo0b3BRaWdwbEVXOS9tQTgrTzQrY2hYdExkMXFOOTJGSmwzZis0NzhES2Qw?=
 =?utf-8?B?T1l5RE1Lc2I1UFI3bnpRdjZ6dFd4Ym1IVW9RT1laakpqY3E1UXdyeTd4UnJL?=
 =?utf-8?B?bWJLM0pMQkY3dXUxVU5KMnJhQXNXL0Y2ZmxkeVB2MWN3UGUwRE5McDdoL2Vs?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A64CC9462201104BAEAFF8445ACD056E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /KQBQTEOTc9/e0M+r6N55Eiu7Fe8getO5kX6NqmmsInyWgdclhVTK5BIObzCDPU/FoBTInoeORUwIHEl3185/h2rTdbrGNkxfryd0gkg6DURwe7N+a8DilYYProVyX0uYZS6xJD82/E7rgmUUWIHhrnvv1b/vtf8/8yi98CsmX6AcMUDGHdBtCMOp8nyzdyc1bgRq7KLccSdA3/soOccIYIjQ8eL52UEd0XG4ExpdWPQeE4dDGMESDd4kb506dbl1UrH3Yp/dqU3AOZZRssO9Rk+opsRxRjMDXqiLzP0ANYqCf99BjImoee6WIjMJjIdZYl9VPboHEx/53AiiouyGG0Bv6tPdhOu5OzTn2QuQQQeAA2mwB7bvME/WRUfpQTdxe/b1GvN22l27Z6KDfgaowwLw+P+P5FBRKLSw3/yZkm7lhHozu4hylYSF5JrrJ7645ePlZhBna3YrX3zFqPIqIIavwOFMyUJWD/JVaGnBZF8jfkdr9E2R7EMi8mWQ3gHfZRmQ/WaAL3mOdwyM+VNDgjJVlWqtFz+XudUCP9a7iXgh5aluJIprCXgHAfIIM9zPPdj0Ht0ZJ3rZof8bqO9cee7djaS/2cslWwykZfE07tjANIhHE+zSdT1rEMg85YEaaoWQelpirMO8+KcKLytPELZSLeQb2rnlhZasYG3VuqR2M7eQZLU3sFSQKOOSX039APW9kO76mm+UdTbeuJu7fLZh5BGRYbRgFJzCYsOO8kYA6C102vFmddlsxHaqtP9T1Bev4tIEci1nqVDSZ2hbNMasxyGq07Xh3yNzRW6aEz55ohcEuCdchSmS4HXlYA0+Cx4YscYsEBx/RY6+rU9kuHvVbLjiiGTSt/tQIpeLiO+UkA2+1nKXAcehsSpjAkA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5445.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcb58f8-9e90-41f8-7f13-08dbd91d0de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:51:41.3500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nckWLv3NXXxhbZyGNqDR/Hfn6w1NItK60EfSLDbj4EQsfolUkOArqk/nZn2A4wPaeufAlo18s/5KJ+/h8p+YEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8413
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI3LzEwLzIwMjMgMTM6NDEsIExpIFpoaWppYW4gd3JvdGU6DQo+IG1yLT5wYWdlX2xp
c3Qgb25seSBlbmNvZGVzICpwYWdlIHdpdGhvdXQgcGFnZSBvZmZzZXQsIHdoZW4NCj4gcGFnZV9z
aXplICE9IFBBR0VfU0laRSwgd2UgY2Fubm90IHJlc3RvcmUgdGhlIGFkZHJlc3Mgd2l0aCBhIHdy
b25nDQo+IHBhZ2Vfb2Zmc2V0Lg0KPiANCj4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggd2lsbCBicmVh
ayBzb21lIFVMUHMgdGhhdCB0cnkgdG8gcmVnaXN0ZXIgNEsNCj4gTVIgd2hlbiBQQUdFX1NJWkUg
aXMgbm90IDRLLg0KPiBTUlAgYW5kIG52bWUgb3ZlciBSWEUgaXMga25vd24gdG8gYmUgaW1wYWN0
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5j
b20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgfCA2ICsr
KysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiBpbmRleCBmNTQwNDJlOWFlYjIuLjYxYTEzNmVhMWQ5MSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiArKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IEBAIC0yMzQsNiArMjM0LDEy
IEBAIGludCByeGVfbWFwX21yX3NnKHN0cnVjdCBpYl9tciAqaWJtciwgc3RydWN0IHNjYXR0ZXJs
aXN0ICpzZ2wsDQo+ICAgCXN0cnVjdCByeGVfbXIgKm1yID0gdG9fcm1yKGlibXIpOw0KPiAgIAl1
bnNpZ25lZCBpbnQgcGFnZV9zaXplID0gbXJfcGFnZV9zaXplKG1yKTsNCj4gICANCj4gKwlpZiAo
cGFnZV9zaXplICE9IFBBR0VfU0laRSkgew0KDQpJdCBzZWVtcyB0aGlzIGNvbmRpdGlvbiBpcyB0
b28gc3RyaWN0LCBpdCBzaG91bGQgYmU6DQoJaWYgKCFJU19BTElHTkVEKHBhZ2Vfc2l6ZSwgUEFH
RV9TSVpFKSkNCg0KU28gdGhhdCwgcGFnZV9zaXplIHdpdGggKE4gKiBQQUdFX1NJWkUpIGNhbiB3
b3JrIGFzIHByZXZpb3VzbHkuDQpCZWNhdXNlIHRoZSBvZmZzZXQobXIuaW92YSAmIHBhZ2VfbWFz
aykgd2lsbCBnZXQgbG9zdCBvbmx5IHdoZW4gIUlTX0FMSUdORUQocGFnZV9zaXplLCBQQUdFX1NJ
WkUpDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KPiArCQlyeGVfaW5mb19tcihtciwgIlVuc3Vw
cG9ydGVkIE1SIHdpdGggcGFnZV9zaXplICV1LCBleHBlY3QgJWx1XG4iLA0KPiArCQkJICAgcGFn
ZV9zaXplLCBQQUdFX1NJWkUpOw0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsJfQ0KPiAr
DQo+ICAgCW1yLT5uYnVmID0gMDsNCj4gICAJbXItPnBhZ2Vfc2hpZnQgPSBpbG9nMihwYWdlX3Np
emUpOw0KPiAgIAltci0+cGFnZV9tYXNrID0gfigodTY0KXBhZ2Vfc2l6ZSAtIDEpOw==
