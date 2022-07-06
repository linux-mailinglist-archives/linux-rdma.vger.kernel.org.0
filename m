Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF46568362
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiGFJVW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiGFJVR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 05:21:17 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CF17A86
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657099275; x=1688635275;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=yOSPZbobAFl3EauTs+CILNxsTSr7kQG3ShWwVNwUydc=;
  b=tsOUDDPmIIF8tuovBeErwsUOpLUWw85MTT5wTsxKi2W7TVldpjxLDaqL
   LNTo+s/ctzVPKB9im3NoqJEiWN+IDSmFGKjLZ2ynsntRCbNJSIZpFp4aY
   MQ9Niuu+H2HHFs+yQu4PzDuulfbsATUbpD+nrr6pDWY7TWW4fYJ0BnAac
   pwPF2v1gQCdwi5RYccsznN8O5GOg5sp0DYng/zDbltkjp5sKP75x2NBD8
   jUSSRyeggzhb79ajUOeIJ9NzZgQffIcZfyHZW1w01W+rYnZN6gcEEieOE
   FGRf3BTOoKA1bEmfo/gGwnZqWZULxs6A/NY01VLlOO9mEi9sNvD/9cxRH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="59913363"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; 
   d="scan'208";a="59913363"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:21:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnviKKwOfN3T4IPQ1qp1Vy2lK1StUMoHfubiI3vRBi6h6VyHXFYCuKkKZMtQnfRtRSyNSrCAVQInMf7vc0advsA0xFQOGmz6U2to0q55zgSNcmC5g7MbcLDHCBFAHsjdyAscgLtdj9X6p1VwjOUpgk1W4l8jIX97h8QTa0njOzNw1yOQIZZ9rr2lWHTStP0HfWchK/dh1GWaLZJEqDUl0I2iNl6nrysww7w4/+aR+g/SN2HtzQ2DKbnmHKZEjbUWB/sH4j+Pp/z6I+Tp4TdFkREuFj8Aeu+pzUYEVMGh0iXXKkRRLUDVyWCYmt8LyBFSSazcq3Gq3qfOGzw3qedA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOSPZbobAFl3EauTs+CILNxsTSr7kQG3ShWwVNwUydc=;
 b=YM0KhhyKh5q0zL0lt/U8rqCz6Ux783rR7XiStYO7n/L1AoK9z1EFKi7XTvG8fNNaQHKL3dfgeS8kWt8YzocIElQLKvUlAhGRLIbZhA6Pxwg/SolyYGARZP46bT/ldZQ63+XmdN3DELah2dWqz6huJ7qOFI9JYMXfHJQagIMJ7zj2FircQzKHBNeVkI3m7VyLFljn5xkVBYARrir/k6uQz1lrpEAtaoHRT6amRSXmVU7/ey1VOjJfk6sZrEj9ivPHo6nhryUHVEZB23GT49bnzol8r3S+Bv6C9vVn+IYXs9A7hUk8nRwKkCfU+OnlFqJolrhVDm3ZmiE6qZTTGaSx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOSPZbobAFl3EauTs+CILNxsTSr7kQG3ShWwVNwUydc=;
 b=pflF8/aNElJpJg29net5nIfdxA/1YAxd5b5UCYccwe4BYaEOaXQAEczMRGuJrD96pbOUsFPsYFKEYI6+RetDnFXzNbc/CqTD8mga5oio3gPY/CJtygK4gwjDmdyjZusKE8/omvmEOmGjNbBk5KLnzMrhIlBgXKEeBTcaSNkb9hw=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYAPR01MB6009.jpnprd01.prod.outlook.com (2603:1096:402:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 09:21:09 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 09:21:09 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Topic: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Index: AQHYkRm6Bw1pQgLwyUy00KjkER3CYw==
Date:   Wed, 6 Jul 2022 09:21:09 +0000
Message-ID: <20220706092811.1756290-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be83ab2d-fa53-4a9d-0801-08da5f30dcbc
x-ms-traffictypediagnostic: TYAPR01MB6009:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6rENP0pAfOpj8H3WxjM5AP+3lESQY3rAtHUQ4lODqMKtGKpGp08mMUV6taCtxGYX4AomzZ/Edx/G9mPUvWsberjs3UK0aAYrO+gfAFakrWwKvSBKf+yL1qe5krykjsTgx/HUVvn3SQCSSHgo7vlxlp4CQbE1xgFw0+a6OL39P1HFw/r+ROjmMAOfBAsReOh1LfCkxhwSJnethr+tWBGNrlj5XwyBFE7HJbJec43CbWllCHu1Cf+WdrsYpf89vZQIxCaepusRDhax1Wj2V0/CqvF30iqHzPEON6f0JMedyfdDrcRhHctgphdXuqlx2TROdA3C88IaFWhcTgm4zeMQgDfrrxZyJnt8VKwEyjQlpYNej0e6+Nb1MmIdEBWYnqH68dpGuosxbqnuOxasjD79DWBfn7rGLCqDpu3G4svTtgkpCXn/2EjatldEGkUqnsOqCxTSvEAkv/JezOX+mnrOP6cUQ0QDJT3L+7tfB2tXHwKjNTkLfYBCxVJFNGaSA3OxMcuM55Bo4bngHosnF3G4SPsxpAXgIltbKRU+0VvAdLxJ7yn/eYjdkXwYGe9C9CxYaIDz2VNoLqKZUDf5p40r+I7v/6IFRCtRH0DSedreTUnatQhjMajjFfgruQd4U8GpEzRGRtTJHRgNwjK7oOfUbDGfL/JJBO3OX0q/CmLgpv7vRS4X+YUmBKFYfn4kOi/aec3Meq5O08NgqRSUjupf8NBxJxH8RxYBr2PhBz5ls39IkkNa2jGuVjnFk6XQd/SmfCxcgR6N/6I1ZFJ6AYgbPSr+GKqh9YbAbl44ifL/+o8tK6zlig0jayK0eNHJ4OpS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(2906002)(41300700001)(2616005)(107886003)(1076003)(38100700002)(316002)(36756003)(85182001)(110136005)(6506007)(6512007)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(71200400001)(86362001)(478600001)(186003)(83380400001)(91956017)(82960400001)(122000001)(38070700005)(26005)(6486002)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z2NsZnJyZWhBL2ZtNXQxbXpPQzd6N1FOUUl1RlVWalV5NEdKdHVVUnRTV2Zs?=
 =?gb2312?B?MVFUTTMxU3R4dGQ1WFhuSTl6U0JGa0gwSjN1V2N5NDArLzUvRmFtbHVDa3No?=
 =?gb2312?B?RDBYZEhUdFZpaXh3TnJkcGVoSmhtdDlMMDJ2cXNmbWJycExYQ3FlQVZ6dmgx?=
 =?gb2312?B?R2czVjRkeGJ3NFh0Q21zVk1jRTFDSTRvUjh6MzNCaC9Ldnphc0hXaUVOV0hq?=
 =?gb2312?B?bEN2ZXYwTWxKSVFEbll0QXZmMzFTWnZtMlhjeFNOZit0cFlubzNvK2xrU0V6?=
 =?gb2312?B?QUVUbEc1RkJIUlA3blhLVTkvenIrclN1dy9NYlY1eUp0UGdLMVNvclB0YTBS?=
 =?gb2312?B?WTQ2a1dJVWFMeXRhcDNicFc5QWlKNmh2Mm9qWTNaTWIzTVVNK3AzQWgyNHZT?=
 =?gb2312?B?T1phekl6Um5NQm5hbThwQ1diZUJ0RklleGE5VENjVVZxWlBqTnMzNXoyaXBH?=
 =?gb2312?B?ZTNLOVJKSWpNWkoyb2ZWZ2ZaenNmelorbFhMYkFTS0JsNnQ3ZW5RZmpYUUx3?=
 =?gb2312?B?UHd6bk5iUlFsV0ZQUW5ZclNzK2xYZmNZUzRiT3o2T21FeGNZN0FXNm9hd0Vk?=
 =?gb2312?B?cXBoem5Ua2lPcVdYbk9WRWV6MEg4enVzSWVMSFBKMmI3bDRtakFTRzJMTmc1?=
 =?gb2312?B?VUt5aklxd0dZMThvNlZWT2c5dFZWbXF0MHpyd3ZYcEVjYzFkVTRMdE02RWtY?=
 =?gb2312?B?bkR4cDdNUURkVlN5Y2lqbGFEeUE1NVF0NlVYYkpQNWVEb1VRaW5JaTZXaVJX?=
 =?gb2312?B?bHBNVnd0QTNXclVZdi9DdkNxRVdtMFVvMjZLT2hFMnA1dFlpM3NIcVgvbXZy?=
 =?gb2312?B?VFp2dHc3dEdjWVFOVHdNb0tGbmxkT0szbDMwcWIzR2VXRnBMdElXSGpVTXVt?=
 =?gb2312?B?SHl5STNDa3NpenYzS09BVzFHOHplbEs0djJnczBrQjA3dHVFS3EwS1NhcjJo?=
 =?gb2312?B?T1RxWUZLMGdTTUVuMEVqdVVldkpBVWRtWnJJTnAvYVBhclZ6RzFnbEtKUThv?=
 =?gb2312?B?VkVvZUlQSkc3OFRMZURQcFFVdlRvTzRqSW9ONGoxdFdZcXZVNWtzdXVrMkYz?=
 =?gb2312?B?T01JWnk4NWNKWVVJaHhZd09sN1A4c2h3NVBvL2hNeWxWcDU2Mi9ndVRzdHBq?=
 =?gb2312?B?SkRqL3RCaE9OL3NsU1gzV1hlQUtGamFGclNDZGdUR05ucDkzQXVTNklUbFhF?=
 =?gb2312?B?UlRzNExIcWF5VzBra0pSUDFTZWd1bGVZREJkK1V2UVY5VXB3aDFEeEpzalVr?=
 =?gb2312?B?bW9uTjNVMHNaUG8wcGp0TWpOYVJVYVVWSjBMQU8zZytLN2sxY285WVNXVkNz?=
 =?gb2312?B?d3p6QTVXaHB5VzN2aUh1eHpMTk5nVENad2tqK05FSjFHakxqU1pKRkJsdHNP?=
 =?gb2312?B?WmNKLzI0cUFNSzQxSDQ1Y2ZtaHlUK0E5bnF6djJvUWdPZWpMZ09oS0ZFRVpy?=
 =?gb2312?B?WGlIQkZQajJjWnBJU1J0dW5FVUh4b280ZGxncmIralVNNTZZVit3a1ZvSnA2?=
 =?gb2312?B?bFlmTHNTVG9EMENCZDhwM0dDNWxhLzhEL2NMSWtPY2wyek5HZDdJSEVlN1FY?=
 =?gb2312?B?RkFKaTEwakhsdk1zQ045MUk4NUtXL3dvR1VZMURQSi9yRjk2WDBON0hkaXdJ?=
 =?gb2312?B?MC9hQUk4RlBKalNiTGZ4cWhxK25GelB1aVROK0lxTzB1Zms1NzN3RzhzRm9Y?=
 =?gb2312?B?ZGlZRjFLQkR2SkQwcDBOdFdqbEcvNE8vNzNqL1BDK2lIbW0ybUNXQlFWRUhI?=
 =?gb2312?B?YVhWSm1OOGpJYW5pWXVlT0VXc0xwWnFFRWN0UDlYUTZ5ajhmN09kTjRUTGpB?=
 =?gb2312?B?NW5IbTNWMk5NY1FEdi9jUWNPNEc5ZGYyK2ZKYzJldkYxc1N6ZkV5VVJrdER6?=
 =?gb2312?B?T3F1QVpxTVIyOEtvQ0xrYyttMEhBRkh3ZWdlakxOVk9KekM2N0JSRHptUklK?=
 =?gb2312?B?WU5Bc0hVMTJMdFVoeXBsWnhPNFdaRFllU1lFQjNYNzZkZENUOHhLZHNVdGRq?=
 =?gb2312?B?RHhNVFpLQ1BLUTJyZ3BEUjdSUTZRaHZob0VxK3lpbU1PSEsybW1RMjZvdjRz?=
 =?gb2312?B?K0JOc0p0Uy9WVFZMT3pnN2hGbFdqVzlXYTVFOU13YUtyOTFwSlBpUXhIblZC?=
 =?gb2312?B?R0xjYjQxbVlUWVBodi9kMWFWZ2wzeDNCdjlCVHFXUFA4bU12VWxCL3ZjWHls?=
 =?gb2312?B?T2c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be83ab2d-fa53-4a9d-0801-08da5f30dcbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 09:21:09.2569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwN/5I6Y+ZmD7OscAYJ5cxPDi/hKy0uD0O+8LKpHzwF/WD0gmXyFib22E3Wfmx2oI6Bg2G1xeZ9rieHmBfF91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6009
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SXQncyBwb3NzaWJsZSBtcl9wZChtcikgcmV0dXJucyBOVUxMIGlmIHJ4ZV9tcl9hbGxvYygpIGZh
aWxzLg0KDQppdCBmaXhlcyBiZWxvdyBwYW5pYzoNClsgIDExNC4xNjM5NDVdIFJQQzogUmVnaXN0
ZXJlZCByZG1hIGJhY2tjaGFubmVsIHRyYW5zcG9ydCBtb2R1bGUuDQpbICAxMTYuODY4MDAzXSBl
dGgwIHNwZWVkIGlzIHVua25vd24sIGRlZmF1bHRpbmcgdG8gMTAwMA0KWyAgMTIwLjE3MzExNF0g
cmRtYV9yeGU6IHJ4ZV9tcl9pbml0X3VzZXI6IFVuYWJsZSB0byBhbGxvY2F0ZSBtZW1vcnkgZm9y
IG1hcA0KWyAgMTIwLjE3MzE1OV0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpbICAxMjAuMTczMTYxXSBCVUc6IEtBU0FO
OiBudWxsLXB0ci1kZXJlZiBpbiBfX3J4ZV9wdXQrMHgxOC8weDYwIFtyZG1hX3J4ZV0NClsgIDEy
MC4xNzMxOTRdIFdyaXRlIG9mIHNpemUgNCBhdCBhZGRyIDAwMDAwMDAwMDAwMDAwODAgYnkgdGFz
ayByZG1hX2ZsdXNoX3NlcnYvNjg1DQpbICAxMjAuMTczMTk3XQ0KWyAgMTIwLjE3MzE5OV0gQ1BV
OiAwIFBJRDogNjg1IENvbW06IHJkbWFfZmx1c2hfc2VydiBOb3QgdGFpbnRlZCA1LjE5LjAtcmMx
LXJvY2UtZmx1c2grICM5MA0KWyAgMTIwLjE3MzIwM10gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFu
ZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEuMTQuMC0yNy1nNjRmMzdj
YzUzMGYxLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNClsgIDEyMC4xNzMyMDhdIENhbGwg
VHJhY2U6DQpbICAxMjAuMTczMjE2XSAgPFRBU0s+DQpbICAxMjAuMTczMjE3XSAgZHVtcF9zdGFj
a19sdmwrMHgzNC8weDQ0DQpbICAxMjAuMTczMjUwXSAga2FzYW5fcmVwb3J0KzB4YWIvMHgxMjAN
ClsgIDEyMC4xNzMyNjFdICA/IF9fcnhlX3B1dCsweDE4LzB4NjAgW3JkbWFfcnhlXQ0KWyAgMTIw
LjE3MzI3N10gIGthc2FuX2NoZWNrX3JhbmdlKzB4ZjkvMHgxZTANClsgIDEyMC4xNzMyODJdICBf
X3J4ZV9wdXQrMHgxOC8weDYwIFtyZG1hX3J4ZV0NClsgIDEyMC4xNzMzMTFdICByeGVfbXJfY2xl
YW51cCsweDIxLzB4MTQwIFtyZG1hX3J4ZV0NClsgIDEyMC4xNzMzMjhdICBfX3J4ZV9jbGVhbnVw
KzB4ZmYvMHgxZDAgW3JkbWFfcnhlXQ0KWyAgMTIwLjE3MzM0NF0gIHJ4ZV9yZWdfdXNlcl9tcisw
eGE3LzB4YzAgW3JkbWFfcnhlXQ0KWyAgMTIwLjE3MzM2MF0gIGliX3V2ZXJic19yZWdfbXIrMHgy
NjUvMHg0NjAgW2liX3V2ZXJic10NClsgIDEyMC4xNzMzODddICA/IGliX3V2ZXJic19tb2RpZnlf
cXArMHg4Yi8weGQwIFtpYl91dmVyYnNdDQpbICAxMjAuMTczNDMzXSAgPyBpYl91dmVyYnNfY3Jl
YXRlX2NxKzB4MTAwLzB4MTAwIFtpYl91dmVyYnNdDQpbICAxMjAuMTczNDYxXSAgPyB1dmVyYnNf
ZmlsbF91ZGF0YSsweDFkOC8weDMzMCBbaWJfdXZlcmJzXQ0KWyAgMTIwLjE3MzQ4OF0gIGliX3V2
ZXJic19oYW5kbGVyX1VWRVJCU19NRVRIT0RfSU5WT0tFX1dSSVRFKzB4MTlkLzB4MjUwIFtpYl91
dmVyYnNdDQpbICAxMjAuMTczNTE3XSAgPyBpYl91dmVyYnNfaGFuZGxlcl9VVkVSQlNfTUVUSE9E
X1FVRVJZX0NPTlRFWFQrMHgxOTAvMHgxOTAgW2liX3V2ZXJic10NClsgIDEyMC4xNzM1NDddICA/
IHJhZGl4X3RyZWVfbmV4dF9jaHVuaysweDMxZS8weDQxMA0KWyAgMTIwLjE3MzU1OV0gID8gdXZl
cmJzX2ZpbGxfdWRhdGErMHgyNTUvMHgzMzAgW2liX3V2ZXJic10NClsgIDEyMC4xNzM1ODddICBp
Yl91dmVyYnNfY21kX3ZlcmJzKzB4MTFjMi8weDE0NTAgW2liX3V2ZXJic10NClsgIDEyMC4xNzM2
MTZdICA/IHVjbWFfcHV0X2N0eCsweDE2LzB4NTAgW3JkbWFfdWNtXQ0KWyAgMTIwLjE3MzYyM10g
ID8gX19yY3VfcmVhZF91bmxvY2srMHg0My8weDYwDQpbICAxMjAuMTczNjMzXSAgPyBpYl91dmVy
YnNfaGFuZGxlcl9VVkVSQlNfTUVUSE9EX1FVRVJZX0NPTlRFWFQrMHgxOTAvMHgxOTAgW2liX3V2
ZXJic10NClsgIDEyMC4xNzM2NjFdICA/IHV2ZXJic19maWxsX3VkYXRhKzB4MzMwLzB4MzMwIFtp
Yl91dmVyYnNdDQpbICAxMjAuMTczNzExXSAgPyBhdmNfc3NfcmVzZXQrMHhiMC8weGIwDQpbICAx
MjAuMTczNzIyXSAgPyB2ZnNfZmlsZWF0dHJfc2V0KzB4NDUwLzB4NDUwDQpbICAxMjAuMTczNzQy
XSAgPyBzaG91bGRfZmFpbCsweDc4LzB4MmIwDQpbICAxMjAuMTczNzQ1XSAgPyBfX2Zzbm90aWZ5
X3BhcmVudCsweDM4YS8weDRlMA0KWyAgMTIwLjE3Mzc2NF0gID8gaW9jdGxfaGFzX3Blcm0uY29u
c3Rwcm9wLjAuaXNyYS4wKzB4MTk4LzB4MjEwDQpbICAxMjAuMTczNzg0XSAgPyBzaG91bGRfZmFp
bCsweDc4LzB4MmIwDQpbICAxMjAuMTczNzg3XSAgPyBzZWxpbnV4X2Jwcm1fY3JlZHNfZm9yX2V4
ZWMrMHg1NTAvMHg1NTANClsgIDEyMC4xNzM3OTJdICBpYl91dmVyYnNfaW9jdGwrMHgxMTQvMHgx
YjAgW2liX3V2ZXJic10NClsgIDEyMC4xNzM4MjBdICA/IGliX3V2ZXJic19jbWRfdmVyYnMrMHgx
NDUwLzB4MTQ1MCBbaWJfdXZlcmJzXQ0KWyAgMTIwLjE3Mzg2MV0gIF9feDY0X3N5c19pb2N0bCsw
eGI0LzB4ZjANClsgIDEyMC4xNzM4NjddICBkb19zeXNjYWxsXzY0KzB4M2IvMHg5MA0KWyAgMTIw
LjE3Mzg3N10gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ2LzB4YjANClsgIDEy
MC4xNzM4ODRdIFJJUDogMDAzMzoweDdmNGI1NjNjMTRlYg0KWyAgMTIwLjE3Mzg4OV0gQ29kZTog
ZmYgZmYgZmYgODUgYzAgNzkgOWIgNDkgYzcgYzQgZmYgZmYgZmYgZmYgNWIgNWQgNGMgODkgZTAg
NDEgNWMgYzMgNjYgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgZjMgMGYgMWUgZmEgYjggMTAgMDAg
MDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCA1NSBiOSAw
YyAwMCBmNyBkOCA2NCA4OSAwMSA0OA0KWyAgMTIwLjE3Mzg5Ml0gUlNQOiAwMDJiOjAwMDA3ZmZl
MGU0YTZmZTggRUZMQUdTOiAwMDAwMDIwNiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAxMA0KDQpT
aWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQotLS0NCiBk
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jIHwgNCArKystDQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX21yLmMNCmluZGV4IDlhNWMyYWY2YTU2Zi4uY2VjNTc3NWE3MmYyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfbXIuYw0KQEAgLTY5NSw4ICs2OTUsMTAgQEAgaW50IHJ4ZV9kZXJlZ19t
cihzdHJ1Y3QgaWJfbXIgKmlibXIsIHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEpDQogdm9pZCByeGVf
bXJfY2xlYW51cChzdHJ1Y3QgcnhlX3Bvb2xfZWxlbSAqZWxlbSkNCiB7DQogCXN0cnVjdCByeGVf
bXIgKm1yID0gY29udGFpbmVyX29mKGVsZW0sIHR5cGVvZigqbXIpLCBlbGVtKTsNCisJc3RydWN0
IHJ4ZV9wZCAqcGQgPSBtcl9wZChtcik7DQogDQotCXJ4ZV9wdXQobXJfcGQobXIpKTsNCisJaWYg
KHBkKQ0KKwkJcnhlX3B1dChwZCk7DQogDQogCWliX3VtZW1fcmVsZWFzZShtci0+dW1lbSk7DQog
DQotLSANCjIuMzEuMQ0K
