Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3914CFB42
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Mar 2022 11:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiCGKd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Mar 2022 05:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiCGKcU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Mar 2022 05:32:20 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FCC9399C
        for <linux-rdma@vger.kernel.org>; Mon,  7 Mar 2022 02:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1646647441; x=1678183441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9XlYQgyARNiNoTKOAIeZuB1gRCg6KuOMy6FtaKQ63Ic=;
  b=MDWxJrR3N/jXZ9WKCwY5KUN4Q37Az9arKJulMBiUP4K+0YJJ4eDQ2Hon
   hdXhVCF4xXZMoCM/H+yRcOlqBOIhL2oRAKjWi/Da9gG8aXKBXVcsOFygn
   g1hEiF7nodxHAr3NQBDfvSJLg6CYnviTtxQGXY+0DYWCBhbZTXMCWkS8/
   X4IxiM+gY8Xw/7jSMzbjXKiIKbIth3gS0Ns2/f9UGC0MD+mRikpdueM2F
   XwNrhvJ9aqZ50ccTJUMJeIxGg1pPHB3hsKcPkFUAyiEVGVLhgNtEcXpOR
   glqw1DGVhXmrAlEgtL+jgi6TAOe14KhUpCtmHyBUr8PS7vG13noXqAWrF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="51245849"
X-IronPort-AV: E=Sophos;i="5.90,161,1643641200"; 
   d="scan'208";a="51245849"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 19:03:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBzC+6+rgEAWjNHHS9Et+iOBNf/DYxjfc0h6Xu6KUMEfDSNrmZ4F/f0jmvByR9skuxktlTrNdkfoWbtshGoKfKyQij1u7KYjzrGzU6I/Stq0Yf1FvoCx95mF/IvcUx2xIX5MRqKLdfOufU7qYj1gw9nEfiQxFhOA7Z0Zf1YJMfzT7tCROEnaWrLM/x7t8fJmN0VHbvi8kS9B7LleBy6j7rhNPbc4mXjVNQdPq+s/iIIgZmS5Hnzz/UW1Vz5i4O9TpL6YiMX2zLXxYL4FgH6GdH+/6hquEEWvlYkPcE+tA7OL6rI3J/AMpwE/dXKXB3pO3jcDITopGgApWppG8spiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XlYQgyARNiNoTKOAIeZuB1gRCg6KuOMy6FtaKQ63Ic=;
 b=eWzvHn5jdlXX0KlsKr3zwxhYJRfq6R3I49A40N1kpYZJL1iRX0oy5PE/ZDKgmV09wcm13QvPJr/uharpzdncI+5V9ieqObd15docono1IUZ0RZ3ASmqs7ADe2zUjYgSKM+gaLpsLDsWTW2Bn3Dy/DZeEGFHr4CKJZMJmMs3YdLMWfoltCzU/af/reMQN+otppzvYLqEThuCddo5IZE+aqOM9JChgZ/86M1+j5au38q3mWt60FKRxM422GDZ6r6wtVEK4F0hD/X4UGXexUk1ODS97i7LFkJq8At/nq1YvS6OFj68tBTzppjkCNsdMs2BwNheFlrUd7Xc1aDzk0KgcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XlYQgyARNiNoTKOAIeZuB1gRCg6KuOMy6FtaKQ63Ic=;
 b=ZnHzc0fu9LRSICMdySY+aDPqAZ7j2TFTMfuSm9mwVtidW0BNUzn2lVIv0/laUq7o/hrWaHZvff8c4MEqsA5q+DTsIhGLKJ1Q9i8XlyqZxgcMgANn5fDzUGsKNnCDazl+UI7JlDuF+poC5WT2CeI8KZMr7oPO+RAcFNunrSLsNek=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS3PR01MB8764.jpnprd01.prod.outlook.com (2603:1096:604:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 10:03:26 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 10:03:26 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] libibverbs/examples: Add missing device
 attributes
Thread-Topic: [PATCH rdma-core] libibverbs/examples: Add missing device
 attributes
Thread-Index: AQHYHWAteOQiB9Pn9EmC2UkH9sRJJayK69cAgANi1YCAJYuugA==
Date:   Mon, 7 Mar 2022 10:03:25 +0000
Message-ID: <4043a417-4cd8-1868-9085-65e0b61a6a74@fujitsu.com>
References: <20220209025308.20743-1-yangx.jy@fujitsu.com>
 <YgOCXCXWyCTxvva8@unreal> <20220211124139.GL4160@nvidia.com>
In-Reply-To: <20220211124139.GL4160@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feb6754a-ec33-4b92-c442-08da0021b926
x-ms-traffictypediagnostic: OS3PR01MB8764:EE_
x-microsoft-antispam-prvs: <OS3PR01MB87649E07E64BD2F03E0F091083089@OS3PR01MB8764.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPz5brxGIDgeXsoXiSM3bMM2GErMAIb7N+UDUCu4Fx6fPVSA+9g5z0oiukp78xzecdWBbHlgOv89C0f7Xxb+ogdXpbMz+uVjsoe7YaXAJqR+qH1fuiXTAVshcPhEfxYaYnuUfaED1TYLN/qDwKAV+MIHaItM87hmpBLZWoNQqwUKQn/ZMlcz/WW/di2+F3gwtiDHmx1x6UysJHhRseX+ELxwTwCY8Uh3Bzy87PNQoyZTmM7T/Qi/sKV/XbVNW+YIRzqC5yq8IcXKfdlg+nywB8REBTYzqd0VU5djs4nY+dKImSRcQ6bvmgkQ4i5gZMoSgvBi+rGvVdPkzH9a1/Ut711boBYGllHqxNefStKSh7O4GqJzCBnXSK5gKRwZ2Pll+a4AuvWHLQmSCGf9jriRBPoEJ5xDVmYT8fscCRKUfnvRJ/eX5XxFFXLNAW/aZ16/grCsnIHFGV5DJ44K1zCeu/nwAXXZ66kOV/xaODAij3oSAXtxZwYXqHT8tkLJA0giXIpiaw7iI3SnOrKrU+1VPB4q6VFLj/FPb7pseK+n3gaEzzZUBB+AzXvmvWSyV3OpGNO0dgrmQBYNzDcLMtpF3NuAXMwrd5F3PgXS5Fj6E9jp/Te0sv8VHqKcjVOjGaknlQXGFOCMrZ2MOmVssLCdNndUP+ouRNhGNUKzL0uACvUPfqxS8E1vxJGvCGuyf3oUHttj8sdZFgfyORdeXTVI1C1JwUlKRIMnpmVY2hpSbPA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(76116006)(91956017)(66946007)(66446008)(64756008)(66476007)(8676002)(66556008)(316002)(4326008)(2616005)(31686004)(6486002)(508600001)(36756003)(71200400001)(8936002)(6512007)(85182001)(6506007)(2906002)(53546011)(83380400001)(82960400001)(186003)(26005)(38070700005)(38100700002)(122000001)(86362001)(5660300002)(31696002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ay92NWgxbUVkcUhPdi9yK3ErYStpNGVIbGZTVjhDVzdubWtqYmREL3NmKzJC?=
 =?utf-8?B?OVdFcTNVaDNGbGRtdWN4S0NxTFpGVysweEVzSVg2QTlnaDVKQ2d6UDh1dzlG?=
 =?utf-8?B?R2tNejZuZCt3ekxRdlJ4V0MzUG5WQ0RxY3ZiUnhLbGlhKzd6WHhMRW0xaE9k?=
 =?utf-8?B?eTFIYytrVmc2ZVhlLzZEVTNnbjZlZFBrVlM3TG4xNmFJYjlDTURGZU1ON1NF?=
 =?utf-8?B?UTNiWDJmcjk0ZzY3MHFTL3dmY1F3b0s5WGFSUElQK3V3endUd0g4S0hXMXBX?=
 =?utf-8?B?eHRQZmZINi96cCtlY1ZqWFMyR1NCb0JXTEtxRmxNdVg1djkxSzJLMDRiZnVY?=
 =?utf-8?B?bXNSWkVIbk1PQjhSaGNhTDJ2NDJuemVLWTNnRGNPN2NVbjIzNnBtVFlBWHcr?=
 =?utf-8?B?NDBnUC9DVGU2N211d0Q4SFdONktrdnBkeXJGQ0VOZXR6U2R4THc2RFp6ZXFx?=
 =?utf-8?B?VWwxRlU5cy8zcUtoUFVPK1phWGlxT1F5SG8wajRRdEs1U1RFb0RSaE9OSnJL?=
 =?utf-8?B?WGxiUGd3UllJa250a3dGZUpJU0RKK1dQUFFwMVVhSGpvVDlEalZEZUVSTHVJ?=
 =?utf-8?B?ODRReWZ5ck9nVkZMQWZKYkJQZTRvTFUyVUZTUkxDcGUwd1p4cHdWa0dyMEVK?=
 =?utf-8?B?Ti9ndkR5d0tiN0ZpbjJmejZRVHhxMmI0Y0VJSC9wSVFxcnhNcnJyblVlOWJM?=
 =?utf-8?B?M1M3czdFQ0tCbHZlS1REMkhXV255aVhtTmpnc2Q0SkJQUGp2SW5wdTBTaDA5?=
 =?utf-8?B?YzNMcnNYSlpJajhQa0J3YU9zaXh6QXpHa2ZZNEhlZGFWQVp1cnpudkliTHZi?=
 =?utf-8?B?M1hKamF4QWY0SUlwOTJJNlNmK0FkVWk3VEFlTmNlZzhrWmZuMm5TTllYOUx2?=
 =?utf-8?B?TDNkZHVxOXlweHZVZk1PR1UvVEtVSWFMMkVmdkIzMkowbFdQc2RtTFpYclhF?=
 =?utf-8?B?K0Nwd1dQQkFtYWo4ZUtGZG9XcmJ3azFXRS9oeDBQdG1zckY2aUoyZTlMQ2Fi?=
 =?utf-8?B?SUhHRW1JV0tSakp1dmdTaUl3WW1TUGR1OXlMdU1acTNOc281UTRra0NXdmZM?=
 =?utf-8?B?V2g5RFdXSWRvY1U0bXFXbmJUaHBENDNxaDgxdUxmeGxPNjVvR01tdml4ZmZW?=
 =?utf-8?B?K3o3UHBya2ZuVkZwZDNJbUFDTUdJeFozbWhNSVZMb2ZCNDlQTFRjYUEvaU5l?=
 =?utf-8?B?RHgrSXZ6TGRnc3pMWDBuVHRCN1ByZDN5aDZZWFFEcW9hd1hsU0dSRDNCeHhZ?=
 =?utf-8?B?YWJZUkpwa0UvcHNtbm9NcGVnUUVCV0kvVzhycGxWUXNnYm1OQUJkN25xS1g4?=
 =?utf-8?B?UnRnVkFqWXgxRkEvNU12WHcxU3AyWHdRSWRIcWJ0dVVXa0szd2w5UGxpajZF?=
 =?utf-8?B?cGtLRk83WXZHUHVaSVhZN3p6OUZ1aHorS0E5d1FBMG1RK1RCRXRmSS80NEU2?=
 =?utf-8?B?UTgrbEhEb2ZOcHZuTVdpTkdoa2ZvM1YrcWE3WVhhM2ZUWTA0OENHenNZa3hY?=
 =?utf-8?B?RGhwRWJPWjNJWjJhL0pHSnQrejhkYTNuTDlwVkZYVWErMlFYUFBhVVNKK0F4?=
 =?utf-8?B?WWMxVzRtLzhXWHR6ejJ6bXAxZXZjZFpKZjZCMmFhTHNSWHlSeHZpc0c4dzQr?=
 =?utf-8?B?YnJrYjNWL0JNaEFDZUYvQUdSUEY3MDErQ044UTQvMXJDKytaUFo2QUdyMFFR?=
 =?utf-8?B?MEVrcDRnU1g1RDl0Y0Q4R0tlNzhxRUtwMUVXYlJPd3k1MWVDb05WUU1ST1lN?=
 =?utf-8?B?MTdMcDY3cEpPRWJPOWdVRkt0OEhZS2lmMUJ5WnJvSUFMUXhPQ0crazUwSFUz?=
 =?utf-8?B?dWI1QnlqbUIzanFFcHNlMHhlNy8vMHJ6dzhWTUN0QklJVHpuc212Qk9tNWVO?=
 =?utf-8?B?T0hpenFiVlZBemR4TzlHL0lERHpkb2djUFdKL0dqdXlDMnlzMHlQMmJ1M0JL?=
 =?utf-8?B?amtMM2tBR2FNdWMwcTdDRTRSVzJZcEo3b1RheDF6RHVhd3NlejJZOVI1eWRR?=
 =?utf-8?B?VU13OUZFMkk4S3hQQzRJKzdSYTh1TlcxUFIrWEtYKysyYWVidFViNk1iZFZk?=
 =?utf-8?B?TGYrK0ZTTWh0Z1BjNHJBdlB5eVlSZmVLMW9LTTJySzQ2bmhpR2QvK3YvbDlZ?=
 =?utf-8?B?TW1FNGtEQjZQaUl0SWRLeElQaW1vS3J1Vk1TWStXNTk3SDYwZnQrbGljYTQ3?=
 =?utf-8?Q?CSl89wJggRq2Mtey3hPM43Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1E89C32A3FB14BBFB2B92226DCF026@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb6754a-ec33-4b92-c442-08da0021b926
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 10:03:26.5655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocKAm4jXVP8ftEvMUh9zYPA64xyPed81A24YfAV+/KrU1Et57Nf49gqaEALY5FCvBzN/RwdEUTyk4jYQ/t4wGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8764
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8yLzExIDIwOjQxLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFdlZCwgRmVi
IDA5LCAyMDIyIGF0IDEwOjU5OjA4QU0gKzAyMDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+
IE9uIFdlZCwgRmViIDA5LCAyMDIyIGF0IDEwOjUzOjA4QU0gKzA4MDAsIFhpYW8gWWFuZyB3cm90
ZToNCj4+PiBtYWtlIGlidl9kZXZpbmZvIGNvbW1hbmQgc2hvdyBtb3JlIGRldmljZSBhdHRyaWJ1
dGVzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1
LmNvbT4NCj4+PiAgIGxpYmlidmVyYnMvZXhhbXBsZXMvZGV2aW5mby5jIHwgMjkgKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0NCj4+PiAgIGxpYmlidmVyYnMvdmVyYnMuaCAgICAgICAgICAg
IHwgMTMgKysrKysrKysrKy0tLQ0KPj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPj4gSSBoYXZlIGEgZmVlbGluZyB0aGF0IGEgbG9uZyB0aW1l
IGFnbywgd2UgaGFkIGEgZGlzY3Vzc2lvbiBpZiBhbmQgaG93DQo+PiBleHBvc2UgZGV2aWNlIGNh
cGFiaWxpdGllcyBhbmQgdGhlIGRlY2lzaW9uIHdhcyB0aGF0IHdlIGRvbid0IHJlcG9ydA0KPj4g
aW4ta2VybmVsIHNwZWNpZmljIGRldmljZSBjYXBzLg0KPiBSaWdodCwgaXQgaXMga2VybmVsIGJ1
ZyB0aGV5IGxlYWsgb3V0IGluIHRoZSBmaXJzdCBwbGFjZS4NCj4NCj4+PiBkaWZmIC0tZ2l0IGEv
bGliaWJ2ZXJicy92ZXJicy5oIGIvbGliaWJ2ZXJicy92ZXJicy5oDQo+Pj4gaW5kZXggYTlmMTgy
ZmYuLjY4NTkxYzdiIDEwMDY0NA0KPj4+ICsrKyBiL2xpYmlidmVyYnMvdmVyYnMuaA0KPj4+IEBA
IC0xMzYsNyArMTM2LDkgQEAgZW51bSBpYnZfZGV2aWNlX2NhcF9mbGFncyB7DQo+Pj4gICAJSUJW
X0RFVklDRV9NRU1fV0lORE9XX1RZUEVfMkIJPSAxIDw8IDI0LA0KPj4+ICAgCUlCVl9ERVZJQ0Vf
UkNfSVBfQ1NVTQkJPSAxIDw8IDI1LA0KPj4+ICAgCUlCVl9ERVZJQ0VfUkFXX0lQX0NTVU0JCT0g
MSA8PCAyNiwNCj4+PiAtCUlCVl9ERVZJQ0VfTUFOQUdFRF9GTE9XX1NURUVSSU5HID0gMSA8PCAy
OQ0KPj4+ICsJSUJWX0RFVklDRV9DUk9TU19DSEFOTkVMCT0gMSA8PCAyNywNCj4+PiArCUlCVl9E
RVZJQ0VfTUFOQUdFRF9GTE9XX1NURUVSSU5HID0gMSA8PCAyOSwNCj4+PiArCUlCVl9ERVZJQ0Vf
SU5URUdSSVRZX0hBTkRPVkVSCT0gMSA8PCAzMA0KPj4+ICAgfTsNCj4+PiAgIA0KPj4+ICAgZW51
bSBpYnZfZm9ya19zdGF0dXMgew0KPj4+IEBAIC0xNDksOCArMTUxLDEzIEBAIGVudW0gaWJ2X2Zv
cmtfc3RhdHVzIHsNCj4+PiAgICAqIENhbid0IGV4dGVuZGVkIGFib3ZlIGlidl9kZXZpY2VfY2Fw
X2ZsYWdzIGVudW0gYXMgaW4gc29tZSBzeXN0ZW1zL2NvbXBpbGVycw0KPj4+ICAgICogZW51bSBy
YW5nZSBpcyBsaW1pdGVkIHRvIDQgYnl0ZXMuDQo+Pj4gICAgKi8NCj4+PiAtI2RlZmluZSBJQlZf
REVWSUNFX1JBV19TQ0FUVEVSX0ZDUyAoMVVMTCA8PCAzNCkNCj4+PiAtI2RlZmluZSBJQlZfREVW
SUNFX1BDSV9XUklURV9FTkRfUEFERElORyAoMVVMTCA8PCAzNikNCj4+PiArI2RlZmluZSBJQlZf
REVWSUNFX09OX0RFTUFORF9QQUdJTkcJCSgxVUxMIDw8IDMxKQ0KPj4+ICsjZGVmaW5lIElCVl9E
RVZJQ0VfU0dfR0FQU19SRUcJCQkoMVVMTCA8PCAzMikNCj4+PiArI2RlZmluZSBJQlZfREVWSUNF
X1ZJUlRVQUxfRlVOQ1RJT04JCSgxVUxMIDw8IDMzKQ0KPj4+ICsjZGVmaW5lIElCVl9ERVZJQ0Vf
UkFXX1NDQVRURVJfRkNTCQkoMVVMTCA8PCAzNCkNCj4+PiArI2RlZmluZSBJQlZfREVWSUNFX1JE
TUFfTkVUREVWX09QQQkJKDFVTEwgPDwgMzUpDQo+Pj4gKyNkZWZpbmUgSUJWX0RFVklDRV9QQ0lf
V1JJVEVfRU5EX1BBRERJTkcJKDFVTEwgPDwgMzYpDQo+Pj4gKyNkZWZpbmUgSUJWX0RFVklDRV9B
TExPV19VU0VSX1VOUkVHCQkoMVVMTCA8PCAzNykNCj4gQW5kIGRvbid0IGNvcHkgQUJJIGludG8g
aGVhZGVyIGxpa2UgdGhpcywgdGhlIGtlcm5lbCBwYXJ0cyBuZWVkIHRvIGJlDQo+IG1vdmVkIHRv
IHRoZSBrZXJuZWwgdWFiaSBoZWFkZXIgYW5kIGNsZWFuZWQNCg0KSGkgSmFzb24sIExlb24NCg0K
U29ycnksIGl0J3Mgbm90IGNsZWFyIHRvIG1lLg0KDQoxKSBJcyBpdCBuZWNlc3NhcnkgdG8gYWRk
IHRoZXNlIG1pc3NpbmcgYXR0cmlidXRlcz8NCg0KMikgSWYgbmVjZXNzYXJ5LCBkbyB5b3UgdGhp
bmsgdGhleSBuZWVkIHRvIGJlIG1vdmVkIGludG8gDQprZXJuZWwtaGVhZGVycy9yZG1hPw0KDQpC
ZXN0IFJlZ2FyZHMsDQoNClhpYW8gWWFuZw0KDQo+DQo+IEphc29u
