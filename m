Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC53576C7B
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Jul 2022 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiGPIFj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Jul 2022 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGPIFi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Jul 2022 04:05:38 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE251C904
        for <linux-rdma@vger.kernel.org>; Sat, 16 Jul 2022 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657958736; x=1689494736;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VR29y3WKIOItSc+RsHyXtrZ0NyV31n0LzhE4rAjRleo=;
  b=MRE0AHeL8tHFWLdn9hYhRjtnJFE7/SQYmzD06dwbxXq5cgbjjcKR3i+a
   HQcpmpldAxszK/cNT3YQGyJyivycbYDQeWli2VZe1kD3IxEoqqqRwEiIi
   SF+UWQYVhSYbZmAdu3NPxF02VXMUXt4e0yhgIomBc/T4AhA/9oObMvCzR
   c3PxWI3U6qKi/PAYSaQSMfWSvJTK2OlDhMr/1CPBBfIOWcp2p9u/na86b
   SQxX/gQorvSXPqR8FkmPANLW2zC70Q34jTevj/n08+J5OklNQiYSOFrcs
   Lv3EH07+LZOLXGPR1e4RwHAyRqNqsvNmCbdHOGDDfA7ofy9F4uZzkb6vr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="60545950"
X-IronPort-AV: E=Sophos;i="5.92,276,1650898800"; 
   d="scan'208";a="60545950"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 17:05:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlFJgqG+ZEht9c4LrPCbvV4X9USwwg6hf0dFGsLDESPgJsjwCFE16LZjGOgnRJamIvcCSAjQpHC6cRGKE+z9dQNgM5AdsaFvvaChhAE6MyuAdN9LomO01IAlLDQQ6ldZm6DvRqWixIfnGkout3JN2ZPyaNcggG4BXeUYkyYewCNoznAC3tDIkfMTgRUxlDJlTDA2F5fYEZXSAGe1U2GxYJh7+NgInDlHfgRpDeeWeC8TWtAmlbYhZLObrPfP76iQkjgKpnOEQap6RpqXE9ZXyd0mkDLwW9j4VFwxtJ8JsHNg56Bz2OAAEQNB/5FFbtkjQv3eFEbTslcFGzpjcPf7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR29y3WKIOItSc+RsHyXtrZ0NyV31n0LzhE4rAjRleo=;
 b=fgOvi2IWcgvuwOGPsiZordDQUCZ82l6842Em4HZacv3DQwEC/h41zkdcrZMWeh7AuHwWgjyFGxhVHV4frwYbuN5h8LMnZXZceJ/FciDgFH6EIhMYcVVIsiY6d3GIWGUZGZvgDjEbfF6OmjQvxJ4GvC8+4Yj2EeyYm6eVsTJyPHNry8a3GDoSEcEAmqEcVFIMq97OpjhtgabpWvRe5zhEYNYjl6r60zP9NH+xnyA3QBtpiB/lCoDPkc/yge6VL2QtuilpvrZK4hcMpB7wEVYuWL+YCX8xHWz+p2U3SFY9yZJ9aBvsMmj0pdem7cNS8xyy9MNHchhuQtvCpEOCvRKAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR29y3WKIOItSc+RsHyXtrZ0NyV31n0LzhE4rAjRleo=;
 b=G5SDBL6hfo1GlQEzQ4dCZOkftDfFbVmWC4JvAPBhkbGH1AmhsJOUF/+U4oCH9+yLZPzJOgS7cLbZTp6fF4D4uJfZKpNqSLt5JJt9rZvIyXlNEvvgdzgv3YecmjZocZKWorIXFDqQNU2hv6ZkBy6mXL4sdFvw/nFtHWi2iAHOENU=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS3PR01MB5880.jpnprd01.prod.outlook.com (2603:1096:604:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sat, 16 Jul
 2022 08:05:30 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.020; Sat, 16 Jul 2022
 08:05:30 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Topic: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Index: AQHYkRm6Bw1pQgLwyUy00KjkER3CY61+FxgAgAC/PwCAAPjugIAA5CeA
Date:   Sat, 16 Jul 2022 08:05:30 +0000
Message-ID: <8df53e84-6743-5d48-1550-d214585acc29@fujitsu.com>
References: <20220706092811.1756290-1-lizhijian@fujitsu.com>
 <c82760f8-8774-a90e-7636-1c8954c007f3@gmail.com>
 <11dafa5f-c52d-16c1-fe37-2cd45ab20474@fujitsu.com>
 <545a4df9-4c5d-a74c-5359-2a4f484a8829@gmail.com>
In-Reply-To: <545a4df9-4c5d-a74c-5359-2a4f484a8829@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f989c30-4979-4f66-42b4-08da6701f37f
x-ms-traffictypediagnostic: OS3PR01MB5880:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4O9kTdJbm0N+niSQDiO7eEAtT4x7iVPYl9B4Qt3dM6+MuFK/KCqfejJDRdsBjH3jMNXMlbMSPlVwaWf9EwHHZIsu3vAdl7CkedMbm0DXQz6CF/AaFtDMXGaSzbsai36MqwSdIizwlHTiWFOcgNWsNvz3sBwUP9L3BpcKeRozuC/tkfC391HvyMyuz8hMsHoJjXAQoLsn1HuyHoTwWdL5zrEZ7qLoqxABUJM4nCQI8Hl5RNIi7EGbCdn8uPkCAA/rGdRy/33uwdxVmQ4EOvtqpSNp60ZX8cWNEB+WE7Enqyksnuy6LItMSJfVVtY61etCGg8WPb/V+xB8y++Xs9dxgHMIQd8fa5RRR7uPF0KpNvujEJpaE72jgiEAAdArKaPcWEFArcgiAStTH/qbwMQJEPntsbwEnzpF7w7wVxeuikwjs4TG0P20D94Xg7VxCpsm+MbZF3LednfaHtapevfMY98a+JpxHKRX35iap5bDERR+RUVzu7AFs2H3A7yZQPJ5nQVI/HC0voTsoqH7NP1TGO9Qt3Sxka0X4HsIg7I9xYh5aF01P00NcBBFuRdl3VUqfv9i2uTdwixmIALnsuBESnkZQEid+cxVEkrr6j1P+RPBRO5yrpTsBoBslKOU3BppvQL7qVY9BKQ1QLMvfRwCxK/DNrHizoxySi6GNP0bmhQXkQK+dxKticaK27wIaqI5pql0t747u2zutYVtPZPt1wQTNBPbqkats+MtxmeBBiGXlrNdaQ94nuuPX0iRpYU78QtA4zc2ugP1qpI5a1sq4cF0w7pgqPRrSXCnlajf7u7L3uSGMe3bFw980g7OvPM1QXFsZC2PxuKrFW7dP96/VdE5VyAB8JPTT8tYpyPve+FQH0s2IXQO2j6bq2jxNjH0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(478600001)(38100700002)(6486002)(6512007)(41300700001)(2616005)(31686004)(4744005)(85182001)(6506007)(26005)(36756003)(2906002)(122000001)(31696002)(5660300002)(8936002)(86362001)(71200400001)(110136005)(38070700005)(66476007)(82960400001)(316002)(64756008)(186003)(91956017)(76116006)(66556008)(8676002)(66946007)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0ZPbzdxUXE1U2I4R2lUUHlmVC9GdnMyL01rZXJUWUNrM1grc0h0TWtmTFVw?=
 =?utf-8?B?MWltRVBJRVBVdVlqL28xMjJ4WVg0WFEzT05jTkVSQTEvSUNxdHZnR2F1bFk5?=
 =?utf-8?B?bWlhZkV0dnVHandoR1hUOHNod1RtMUFWZ0JSMHFyblpwWTIwSlNuWGN3ZFVJ?=
 =?utf-8?B?b0cyMm5HMzVkeWY4ajlsQ0gzdlpsQzJ3cTAvK2ZwK1BGNXkza1paV2pBaEdu?=
 =?utf-8?B?TDRTbS9pdUl2cTVpTjhBZkh5dHFaRGQrUWlPSzRhaXd5MkVNUG80MzlYbjZn?=
 =?utf-8?B?T2JjWjBqMWdmWGZjSEVxazhXbXVYbWJ0VStiVzN2TGVVaU1qMnVkaUc0Zjls?=
 =?utf-8?B?bmxEZXJSZGw4VUg4M3BPRTYwTGQxa1oxaDdMQTdpT2I1RnkvbUZCaXZDZVRS?=
 =?utf-8?B?N3JKelZMQitZYTdlQXk5bE05TXY4QkFvWlNIWnFPTmdYYXozVWRhWElpNFdp?=
 =?utf-8?B?Y2ZraHpuTjlwRExaSW5OSU9HWnVmY0lEWnV1Qk4wY3Jpdk5rbXI3dHh6NVBL?=
 =?utf-8?B?YnBFb0xnMFkzQ2s5bW1Ma3VzRzhFNUFFdXMraDNuY1hoaHUzWWYzR05neTUr?=
 =?utf-8?B?Vk1EYWdLdWpFcEhUaEU5WXd6Zmhya0Urc2ZtbWtDbVNGV1l6WEhGVGpKZERt?=
 =?utf-8?B?WTltM29teXA2Qkp2Mmc1R2p6eXR2dnRFOWtUaEdaQTlVSWhCRkNIcFhIL29Y?=
 =?utf-8?B?S0RON3RQWjZLdDg4eXd5dnl3YzJISTFzSVJ6UG9zZm9YYzFaaFZVMkRmeWph?=
 =?utf-8?B?WW9IUFZqOWNPVGhiWnVaTG1nOHoySnhWU0N1ZmZhT1NPblo2ZFVrcW41UjRN?=
 =?utf-8?B?S2kzSE5YZ2J1UzJ0Z2pIanZLME9XTTdIMUUrVTNNSWw1NjdSODYxbXFjczJJ?=
 =?utf-8?B?VzRjV0pERm1JZHR1SllTY1ZFZTFsVTFaZ3M5VTFTZ3FMRVM3TUhvcjNFTWhU?=
 =?utf-8?B?c3RlYmxpOFNRZDVZZTFUYVZ2YitlQUkraHc2cXJYNFlOYUVmYkxHY2dYcm1U?=
 =?utf-8?B?Mm9Na0YxeU5seS9oTWJUc01JWjZwQXpSTzJyLy9RS1Voa1VXUXZVMUpzRnRL?=
 =?utf-8?B?S2dwbTNKKzdtWU5xQ0ZXUXRkMjk4ZTRuWVBGWk5qeFpqMk8zZ052ZEQwN2lt?=
 =?utf-8?B?ZHZDb1ZETXdUWEwrV2ZNWlJLOUw5WHdpNnRyWWZEQVpvN1VhTkxnajVteXhE?=
 =?utf-8?B?R0xxM1lBYkVvVk1LYWtzTEYyY3Z4NzhsWG13THcwbCtORkxqeE1EeVZQMlZj?=
 =?utf-8?B?VG5BdDFXMDZmZTRCb2VqUjVDMnp3dytXblBFTU1idTdZV2MxQnNQYXhScExR?=
 =?utf-8?B?b1BWc3VOdkp4aUxpbzNyTlRTc0FpSm5FMkVoZGthdkRoZ3UxcGRpMU9BWFJG?=
 =?utf-8?B?NTBnMHI5QndwRUlQL25xbHNKdlZSM1BoMmdyRGlMQ2U1VFZNTG11QWNUTWdH?=
 =?utf-8?B?cXR0MjFsMzcwcm1YRDdzUEdEazFITHdUTEoxTDRuYzByMmVrVVcxMjUxVFZq?=
 =?utf-8?B?QVpJb0xNOG1NOXJyN0lyNjhGZWRWTWVGWktsYU94aHY3d1lQc2ZhellJZ1dp?=
 =?utf-8?B?SHM1K09MNzh4K2pnbkpXY3AweWZjSXVCc1BHZUdxYjM1L1RQQU5rSFdxL2k3?=
 =?utf-8?B?K3JGTmdjYUJjSzlDdjFaNnRYQXBHZ1dwdmx3eVdRRW95QzlHYkNXRC9IUGY2?=
 =?utf-8?B?QWROT0NFbi81UlNrWjRDaHNacXdENEp2VUpEdDBJZ2ZKTkkzVUczbm5SeENj?=
 =?utf-8?B?bmFFQlorb3lYMTRPcWlCRHdPVlcraGRrSWp1ekowZS9oK0FMTGsvRStJS2NR?=
 =?utf-8?B?Yk9CT0lUckJ5ZS80elIxUkNLUkVQc2c3WSt5WSt0b3NyNVZCRk5BVXpvMDUv?=
 =?utf-8?B?TTBaKzJ4ZlUwaWVLRndveElaVXF4c05leWhKb1VCeGFNcjVJTENCaEhUWGRx?=
 =?utf-8?B?V2FYVllacXNyK2NtQ1l3VzRTUVkwcHZ6Y2lUeFE1eWxwZEEybE5kcVluNEND?=
 =?utf-8?B?Nkp3YmlmZjlMRTllSmRaQnYwdTQzRmg4WVd3UENMWGxjM0kyRW4waGwzTG83?=
 =?utf-8?B?M0g2dHl1S3hpZkx2L2JST0xtcUlOc1JmeHNLaExxaWFDM3ZSSDJONE1ZTE9n?=
 =?utf-8?B?em9laEVwUnRTdkdYVURMZVBISGhaL1JCSW8zcEdaa3lqSVEwWmdOZ08rcTV0?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <189129B8BB31904E905B0DC99DA1FBF5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f989c30-4979-4f66-42b4-08da6701f37f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 08:05:30.3696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgOZvT6dK2czG4Cg9NEv+pMCWXzReyYZy2oBtscjh/Zha4YrcT0yRRSFcW/nI3CFHLTC//5smrhnc8LI+2i1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5880
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Qm9iDQoNCm9uIDcvMTYvMjAyMiAyOjI4IEFNLCBCb2IgUGVhcnNvbiB3cm90ZToNCj4gTGksDQo+
DQo+IEkganVzdCBzZW50IGluIGFuIGFsdGVybmF0aXZlIHBhdGNoIHRoYXQgZml4ZXMgdXAgdGhl
IGVycm9yIHBhdGhzLg0KDQp0aGFua3MgZm9yIHlvdXIgcGF0Y2gsIGkgd2lsbCB0YWtlIGEgbG9v
ayBsYXRlci4NCg0KDQo+IFdlIG5vdCBvbmx5IGhhdmUgYSBwcm9ibGVtIHdpdGggUEQgYnV0IGFs
c28gdW1lbS4NCg0KSW4gbXkgdW5kZXJzdGFuZGluZywgYWx0aG91Z2ggdGhlIHVtZW0gaXMgYWxz
byBub3Qgc2V0IGluIHRoZSBzYW1lIGNhc2UsIA0KaXQncyBzYWZlIHRvIHBhc3MgTlVMTCB0byBp
Yl91bWVtX3JlbGVhc2UoKcKgIGN1cnJlbnRseS4NCg0KVGhhbmtzDQoNCg0KPiBJIG1vdmVkIHRo
ZSBzZXR0aW5nDQo+IG9mIFBEIHVwIHNvIGl0IHdpbGwgYWx3YXlzIGJlIHNldCBiZWZvcmUgY2xl
YW51cCBnZXRzIGNhbGxlZCBhbmQgYWxzbw0KPiBjaGVja3MgaWYgdW1lbSBpcyBzZXQgYmVmb3Jl
IGZyZWVpbmcgaXQuIFBsZWFzZSB0YWtlIGEgbG9vayBhdCBpdC4=
