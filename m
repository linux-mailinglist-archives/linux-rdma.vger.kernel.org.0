Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C24DBF18
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Mar 2022 07:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiCQGQs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiCQGQf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 02:16:35 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D72235840
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1647496742; x=1679032742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TnyfdF/rIAISp3lpCQro1dFD/fKdO4XeYfz8MW0PVfo=;
  b=GxCuhvbpEPocUZNtI57uU9Kckk6kMLiw8o1XqKMXYxdmaA4gWZPYk2Fa
   bQ18taxnXzeMLcuLO2Qct2D2oyGNeir75hecRHR1Bq5t8s623kvn+mQ0E
   1QEv7dIIYlMdq/culjVng1mZCMINhXs8LcqH7WBZw9LG4oTETtIkhqVqn
   ZhzFLjMbflq7vYSg7J3+QYGiehZZvznXivhHvFKFV6riRwQonfxGLOPpB
   fpgSlwiEopzHGol5JzqIqPydgZC4P9J0TdvJ3N28AtgcLeaz2GbUqy4tY
   ft9wNLQcxGW9TXxQ0seskgV9O4iA8W4Yv1GKlJJ0ztbHNq/oeiImSH8bh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="52075470"
X-IronPort-AV: E=Sophos;i="5.90,188,1643641200"; 
   d="scan'208";a="52075470"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 14:58:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAZH108UszVrwv1BzTGPsNusH5PGktFaoztftxKSziHkiBn65HWGXbgwHxVR7VgWI0qTZTBUX5UHLXZcYZN8cAuDcASEBoDkcLSDdnLwewpgiA4GXp4H8/y85JYz+XidWEsSEAlnrxxuZNADMgo0nl04/z222P/7xC1K1s1vyfnE/xVE07PVhUlp5PEDh2LjTH8d2x3gf38Zs8YQGeCcmv/6/RPQymb4rpl/73EAaGTCxpWl9tF1ZmtfkRhRJIqXbXaC687YKJJ0TQv/4MVvIEhPI08SwPAkhC6Ip1FhSYzxLOlqVAlVjQriY4rdME+Ydi7EF9igYX2jMFId0WsK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnyfdF/rIAISp3lpCQro1dFD/fKdO4XeYfz8MW0PVfo=;
 b=O4yLzYgeS7DMBXtMWbIifdHanzgrRSq50gwyINke3qkanhiyjNkGI/m+6eoAdR5RnkUMNE4plQJfGPzXUsaHoR9W632bXleYtICL7opzf1uHsgu7Tc6z2PRf/v0kTA0FTR0OzU7KSNHzfKEQy++v9pDASXLmok7fATnFM+fe/9VJDPdfq5y8sXse7pjo5e4teUny+liRfWzucwQiJoYygUewdiidfqsh6i7HmNJ2YGwAvD8ijRL2Y0mlCxSpNJhKUQfuKhgpVe2r2zj9neyjkCR+liDK3wuGYAxVMyb9NkHaPjN/FZ3I1Q1dr43TX9hay1oHxVbz7fnvccG3YLfWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnyfdF/rIAISp3lpCQro1dFD/fKdO4XeYfz8MW0PVfo=;
 b=QP/5pdZfpRGdHPXNBRD3oa0+ImhutIGZM2YoEjOrTQCv01rKROifswVdPNmMb58il3UEQSLafa2vXKZ9lajIFkfniKkizCzw9bS8cWV/xBqOAw7sunRwAepqa3m318+9R+6O1l7S+Q6zSklEBIeukAGu9u4jE3NLIWbL8Lx7Y/U=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYAPR01MB2592.jpnprd01.prod.outlook.com (2603:1096:404:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Thu, 17 Mar
 2022 05:58:53 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 05:58:53 +0000
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
Thread-Index: AQHYNT6Zd/sV5d3li0GAOL19eVqOcazA0W8AgAJMOQA=
Date:   Thu, 17 Mar 2022 05:58:53 +0000
Message-ID: <572b94ed-9aef-a096-7dd5-36542ea27d09@fujitsu.com>
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
x-ms-office365-filtering-correlation-id: b3246b3c-002f-49ad-8c9a-08da07db3763
x-ms-traffictypediagnostic: TYAPR01MB2592:EE_
x-microsoft-antispam-prvs: <TYAPR01MB25921D24D8AC48DA8DC0975883129@TYAPR01MB2592.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKJXarBEOcl92M5egF3bt4Y2We1xLr57RpPZlwFq1lBVjkVxy8cwt2OVZCqAc4kUXIcjSQKP6apO4JpbQPDu8ZONjz4INlfVIlRso7jl4Qv7z/THqeGgWdK5TmCyewd1nOH0GWPIh16azxJEPHapT0NyHx4C6u8iWfy8hkN+07gU4XDBTd7SfxWyGKAFb91M64EcqO4PWPNSLLRKnoWB+K8y+xvXN4ah/yHpiJjY5UIp1tncKK7pOieuAWjN2ADDe3IvCh3BKj+733tAnbZO4nEgSyt0cICP43SKSutZP0MV3iIequwVL8KlkTaLKaswXrii5roMLqILbKShG7U5keLnyH2GWGylYohAgzSCD4T7219rpDYAcdmC6V9+yesEPLueERCtB0zmhQugnJk9bUI1CdrS8K4VNEpbPz7Szsz6aCwFynUc199O8exOsbwEg/gH9QttDh1CGq5AOi3LftysyU4oqHdJQFgOhvDjTcNemjfhBeJatoldoS7GxvhTp3jt+dCMzzj/QE0CmWx7bHADYiUCJO/5yjYwqKAKTHmubvtjWpPTogKoTzO4AQjPfRt5unriXq2yhTXS3piceSz4XuBiDc9f0jt1zLBzg9xk6dbS6MZSrgrWZN5Nvap65/xAN6to1jbhWBNdoO1qD2HAdfc90A0+YJtLEpbocDbuIv0Qq0UwuhXeOB1vtHilwnx1XRGybnG3tG9AIXj/QwyOf2TmDrzsB7tFzXgpDNXkglgGmyC+G0QyB/QAEIpU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(66476007)(66446008)(76116006)(66946007)(8676002)(4326008)(64756008)(6486002)(66556008)(53546011)(6506007)(85182001)(4744005)(36756003)(71200400001)(5660300002)(31686004)(83380400001)(2906002)(122000001)(82960400001)(38100700002)(31696002)(86362001)(8936002)(26005)(186003)(2616005)(38070700005)(508600001)(316002)(6512007)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjdoTWJnUjdXVzdQb2lMS0V1cnlUWVY0anhvWVh3MGF4ZlJaTUVkY3BZTzI4?=
 =?utf-8?B?YTQwQ1krVkRmYlhMWWl6NXNDRzZ5UzhLUXVrdkp3QzZXUmY3K1pzN0hxeEQr?=
 =?utf-8?B?L1loMzBtdmlwZURFTzJmNmk0WUhyeGRRNzFkam9GM1MvSVFDWXhuRFp4SGpN?=
 =?utf-8?B?a0FtQVFzZ09kalg1NUNKSEtmZFpHbGpWbHozZm5OY3ZDcHNYSWJRRE1iSU5T?=
 =?utf-8?B?NXdIN09KSHMyeHVHNi93aFFqZFB2cXkzR2hRYk9FY24rQmhrMCtwSDlCdGgr?=
 =?utf-8?B?NzR0UVJMRVcveVAwUm5lRWZiL2t0L1BiYnFUM2NJajloSHdDSzEvNG9NS21I?=
 =?utf-8?B?UUlKZWJxWno4VVIxZHBMQk5IMW5pWEVlRUdxbUtyRHRpcmEwUysxYThnSnZk?=
 =?utf-8?B?bHpxTUkrWGx1MG54VUxzNzkrTlpvV2xlWE5FQXIvdlVnYUZWbTdteit0ZEhh?=
 =?utf-8?B?cGJxaXFQcUlPdDlVZDFPUUVCNnp2YU13bDlidHhVampMVGd5ekNjK1JLZWVh?=
 =?utf-8?B?NXloblBjV0dQeWlCYlJnYXY1a0VRcVdpQkRLM2UvTVljNEh6WXdLdlNYUlhq?=
 =?utf-8?B?ZWszYjRHbTlwT012WVRONEtEZXE4c2FKRGRzZ253MGo4YlVJWUsxYThTV2tt?=
 =?utf-8?B?a0w5U0p6YTZDUXlBL29wWU5NUDJtc0MwQms2Y3YreFB4dUwrSnAwOVBxTWQ1?=
 =?utf-8?B?VW94ZDh0SmxWcFlTdmQ0SElsclpPNnRWYkxoMFZvcEhyMHc1cFArdjBtVnEr?=
 =?utf-8?B?djNYM2QxUFUzL1ltUjl0YlNtUFVKbklUcmtzQzBQcXF1SXU5bTYxaVduUk1D?=
 =?utf-8?B?cnEyVDM2dDY0YkpKMEwwZVdjakRKS2EvQytjWmJZZUZOMjFaTzRiN3QwemU1?=
 =?utf-8?B?T3FFQnJUR2NtZVZMSTdVMFpKYXM5enFIejlyTDhhQ0lISlArdWpWakRKb0wv?=
 =?utf-8?B?NC9JUjFGeVU3V3oyWGFZQy83ZTBHN2E5V2FmTjZQTjVKZ1loY0w4SlhIREM2?=
 =?utf-8?B?SmNFY1BjdC8wdHJKbDEvR0NReG9nK0NFUXZvZEpGUGpPdzUxb3YxTFhZOVdj?=
 =?utf-8?B?SVRMWjFHRHpZcEJicldXWHhPUlRWUnZMZDNEQi9KcWNCQVNEM09ROW5ZTm53?=
 =?utf-8?B?QzF3TXpuNlBHQjRyLzZHZWFvMXBPZitLV1N4NzhTUFZ1UXNNWGxnYzRaSHVj?=
 =?utf-8?B?VmFQWXBZSjh1VGE0UE8rQ1F3TW1MZytyYnRVWSttUEFQMG5JdkE1dXFCRVVv?=
 =?utf-8?B?KzNabCtZci9EaXl6cVM5SVZ1TzdsNmxzZ25VU3NPY0VRZVZpdnVZZmtSS1NW?=
 =?utf-8?B?MThPcGRWWVVaRlB4U1hYYisyRlRSa3NQMjJZekowNndLdlhQVEhkdmtRWHhi?=
 =?utf-8?B?L2FrMjJlQVN3NittcFhNUkR2QXlFKzcrS1pQUVU3eUlRa25LNXF3Q213ekhU?=
 =?utf-8?B?UzJZUmVSY3RqT1Qxc3kvbWhzdk5jZlVtUWE1bDNsTmhzaUFsSVhMVjJINDlE?=
 =?utf-8?B?VVRuY1hhZ0hudGljWTYvY3hYeXFkU2NqUlcyZXBMNGFrVytnWFFxK2JaTmxK?=
 =?utf-8?B?K1phZjkwdWowcDRlRWlpbmZtWnJQSm1HbmVzNTVsZ0M0N1k4eEIwN2Q3OGVx?=
 =?utf-8?B?YlhiYUlQVFYwTlAyUG1lZ0VjbVhxVEovRzNBc1ZVUDRCVE80RDFZd1BxVmMr?=
 =?utf-8?B?TWMzRngxZkx3N3MzYXh6YzVuMmtoY003Q0htMmk1Q3Q4M0JWNmVpRDliL003?=
 =?utf-8?B?VEU3WTQ0WGZUOUk0VS8yYm1GeitGSldEVVljT05FYVg4dm1qUE1udi9ONXRE?=
 =?utf-8?B?amVMcDhndEliRnpHUks3SmJjbDNWTXFTQUNkTkVjS3VhTk9vYktKblVLVWFn?=
 =?utf-8?B?b0tWamJYdWV4dDlxM0VKbGd6TEJIaXQ2R3B6b1p0M3k5UWc1UXlTZ0RNZVZ5?=
 =?utf-8?B?dlI2Ri9YMzNVYnhDWFZFa0ZQYzlSQWoyN3FjM3FzNmp0ZDBTUE41ZVhpN1gr?=
 =?utf-8?B?YTJzT1RGOVJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DFBDE915C5E9E41BB345963C6DDD404@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3246b3c-002f-49ad-8c9a-08da07db3763
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 05:58:53.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6LJFdDTi8iofyjBaMc8jFYEqFRd15OozYPiIkqw/FDVyKLiJO1ctmVHXhq+k6ZP9TD4BGufqt3eU1KV/5QyCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2592
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzE2IDI6NTMsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gQ2FuIHlvdSBtYWtl
IGEgcGF0Y2ggdG8gY2xlYW4gdGhpcyB1cCB0b28/IFRoZSByaWdodCBwYXJ0cyBvZiBpdCBuZWVk
DQo+IHRvIGdldCBtb3ZlZCB0byB0aGUgdWFwaSBoZWFkZXIgYW5kIGl0IHNob3VsZCB3b3JrIHNp
bWlsYXJseSB0byB0aGUNCj4gaWJfdXZlcmJzX3dyX29wY29kZSAvIGliX3dyX29wY29kZSB0aGlu
Zy4NCj4NCj4gWW91J2xsIGFsc28gbmVlZCB0byBkbyBzb21ldGhpbmcgYWJvdXQgdGhlIDMyIGJp
dCBjb21wYXRhYmlsaXR5IHRoYXQNCj4ga2J1aWxkIGRldGVjdGVkIC0gSSBzdXBwb3NlIHRoaXMg
Y2FuJ3Qgd29yayBvbiAzMiBiaXQgcGxhdGZvcm1zPyBTbw0KPiBJU19FTkFCTEVEKCkgaXQgb2Zm
IG9yIHNvbWV0aGluZz8NCg0KSGkgSmFzb24sDQoNClRoYW5rcyBmb3IgeW91ciByZW1pbmRlci4N
Cg0KSSB3aWxsIGRvIHRoZSBjbGVhbnVwIGFuZCBmaXggdGhlIGlzc3VlIGRldGVjdGVkIGJ5IGti
dWlsZC4NCg0KQmVzdCBSZWdhcmRzLA0KDQpYaWFvIFlhbmcNCg==
