Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6C6C23B9
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCTVc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 17:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCTVc0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 17:32:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F540E2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 14:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo5DFGx3HIH/Z2GVoHA6yJF/QFTsSSJGqqPjORY34mAcw8xTSSe1Ehi7dDB5NvtGjgNEkzshXE/brKpt4PzAQrHui1Q+mmrbqlo4Fhggf5J2qEqTh+v18az9h/rhjOw3qD7U4uxEzuwl29x0J3AKkuW+yhxIruuBKl63QpSwQyhCqkGQq/HYrRBP+OngDO879etuVnTiNduOSVsSURk6kY2qhimBS6XjV2c2cPDQsEu/erlOST3KBmBkwWiwZW3uwMLDjXwpWNWIGkuVeY/GOencWivLXP1RavLlxHM7ZW7KLlzKFUAFvzeefoELF0/E1iwaHTnInYl6QCAyyeVelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqHBHPLduXNI6w918Ae9xpFOrX5mDRbpvzNOPMBnT0s=;
 b=bUAdIOPMQuLm3t5D4tJIW6O2Hpsg46dyugcPfxJFpfwXtIHL4v+Hj7s8WYOzxACLklMfarPKkfGHvCIvUkF36r3pcINRF1Yh2rawRoME2VWhLmucvnUeQzLCazprwYmJX93grP54f+/ssNsHQw9U9P/BSANRb76KW0frjj7u1dEa9gxxHsgcyOomhagRVN/xa0SlCdhqGKWTNcSzy7pLY9riXoCLAEaIS6f1CNXd0fWvbCs8UCIWitC3PDwLFdgNfxukuau+aEHoPYrmKmQy7Z8m0TdfK6V72llCvBempIQRIiMpzozb/ND07XTYx4v07rqFtt0udf0+O4k/rNd0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqHBHPLduXNI6w918Ae9xpFOrX5mDRbpvzNOPMBnT0s=;
 b=h4jKT5aNwiF0W277Lu6PW5xziZ9E1xpfBI7ftSmUh3dPOqb6oNLkMBE+lI0qFzuTYKBO4rcoCSe31sCTKmNv67KsDp+Eaz98AZoL5K+E/RvUXvNgaE3+ZTOXdWEO3n9rnWRr9/cn1C5r+rU2z8SDfAarvKOMlVWWc+y3SXa+F01KlsmeosCaLiuiXZArMI+bckB6zRBDp1E43elifEe0mKzCX27s8HReaewqZroeOXoj/7IvIlchkVIUrBM4KcFDws2l6mX+dUO3I07w2/OAnqs9WHV7WkrH6di0ywAi4KxYjDoWELIxSd+LtZ1urftMBItvAFmA0ocrSNZejQ1Ycw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com (2603:10a6:7:1c::23) by
 AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 21:28:06 +0000
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::7cfa:1753:d425:11fb]) by HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::7cfa:1753:d425:11fb%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 21:28:06 +0000
Message-ID: <38b760d3-1c9c-c92e-243b-9da2a6fdb89b@suse.com>
Date:   Mon, 20 Mar 2023 22:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Nicolas Morey <nmorey@suse.com>
To:     linux-rdma@vger.kernel.org
Content-Language: en-US
Subject: [ANNOUNCE] rdma-core: new stable releases
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To HE1PR04MB2969.eurprd04.prod.outlook.com
 (2603:10a6:7:1c::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB2969:EE_|AS8PR04MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc37829-fb19-454e-a503-08db2989fe25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5x/M13cea71s5MI6jyDHpLLGvgxcIN7ZXhSF6nTOUNJJc2xKL6gAYvSNbHCmMJ1JUU7FGcBvTFBnfYaJsxwieqzh20mN3bN7Xqe3/RMbRgd0Jg1OP9QgLNcKP62uU+1ft2toztFj8oAxj31NUqQ4gLRwJCF3JznFoQ0N0uaIWr2A5AvCnXwGNdEx88vjAfGPTiVEJVIzfIGicdTzbaTXbt7yjlLvzqBU6UhJqCqi0lb9YoPHUsho6CSBFy0A/r4M7aeTWriN6NT2O3MGmaGUMsvOAN5kj1qJRIQwHYE9z5CTDBM0ZkOx/wrgV3aqILXdoESf04AF28UPpMFJDqEW98Zb0iIaxAVaAdC+Tyzd4mOcWLZ3FjrKZDAviP0naOm4ySUCi0Cyxmsug6ciJwgcr+hSVYoWhVDpYzeExev/HEIwF0cQuTExBvkaEkDt20ZmcZblnhhHlqcBoH03Y9rYoIU4jJjtxG17uf+0G82o6KPq+MiAKz1r2C9FXV/vjnNNJyJ9Aql0Iq9iSjFWAadoHysqOUK8YgDksZQvHRzzj/mRbpqGJhPrSD5T2nPX0ir+TdAdW9r9ayE92dshX/pCDDS1X5TZ6bFjrM6C8U29fJVoH7KcjiTWYdxBWZdZ9l2+2pcayv8FN1pUvGLSLrECYFtc7HFNaNvt9EO6grjI0WRYVdp6ZTiXvTvp4oqu7D3uFzbRsQJrBc8Y3eUlLct8rR2Yzv/e5IfAqEkWlRu6oix4c+6HaiAobHhHYA4Ww+JV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2969.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199018)(2616005)(31686004)(6666004)(966005)(6486002)(6512007)(186003)(26005)(38100700002)(6506007)(31696002)(83380400001)(2906002)(478600001)(30864003)(316002)(8676002)(66556008)(5660300002)(41300700001)(6916009)(66476007)(8936002)(66946007)(36756003)(45980500001)(43740500002)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2MxRFlzaG5ScHk3VzZsc3ovS3c0cFo2a2k3MGF4c0Vad1lWeEcrSE1GWHMy?=
 =?utf-8?B?M1k5MmZXdXhpclJiSTR1YXZaYVhCOVdTczhaalVJSW5vcEtpaWkvc3EwaThx?=
 =?utf-8?B?MTRhNkF0Z1RSd1d6b01pYWs2TUxFdjFHTDNtS0MwQTZVM0o2dnFpYjB3QSt2?=
 =?utf-8?B?ak9mZnhzenBFbnVDL0tDK1Rua2c3bS8yUExrYms2TXJiY1JzaCtrMnpoZ1ZK?=
 =?utf-8?B?Z3NVdkY3LzQrYkw2cXhOczNUYk5kV2N3UWZRMEliK3BEODNkTXRjT0N4SHpK?=
 =?utf-8?B?M1p3N3R6YSszMUQ4aWxXSXk3YXlNU1NkRnFkTEFLeDByVTQrbTM5c0E2Q0tY?=
 =?utf-8?B?Z1dtWndhVkZ6eFJDdFZtM2RKalFxazd5aUE4UXZsdjl5WHErbys0MzgvTmtt?=
 =?utf-8?B?UDlQZjN4LzRWY2Vrcnp4UlJZbkNNWGFJN1ZHOUFENmhmdkdIOCs0emt3ZlVD?=
 =?utf-8?B?L1AwZHZ6blpSbTd3T0pBTmgyWmJadG93Q05sMklzdzhheVBhRGNpdFllbkFG?=
 =?utf-8?B?NDJ4RzYrL1NyM0lsR3FFb3A2d2FSWFpxenB3NlNUTkNWVUd6OGI1L2RGRW15?=
 =?utf-8?B?TFRqcDFZZHJCbU5LZTFSN0x2eWN1a1ZudVlzM2RwRTlPeW16RW4rQXlpUFNI?=
 =?utf-8?B?eTR5VzUrNndiRG1oU0NlaDg2OVREajhNanBYeUtvVVRQaW1HU3B0M01ubklC?=
 =?utf-8?B?c25INjJsTHIxcEY5NjhIS25qcDEyaFF4ajkwaXV6dXNTdk1sRDl2TUxXSCt2?=
 =?utf-8?B?cEg2WVNpTGN1QkQ3OStYRyszSGk3QkJlYUZIeHU1ZUhrLzhlM2VYU3VURHVM?=
 =?utf-8?B?am9UTlgrVElkcjZjRnZiakVvRGRvZTFXNnBXMEZRVmJSbkJxTkJuYXFPeEpJ?=
 =?utf-8?B?M2xRR3dLbVNsSHhKeEZXV2JWY3ZYb3d0NmhkcCtXMlQwalZHNWFCTHpqeXBk?=
 =?utf-8?B?SEVWck1PcXd1S1pGbElaMWhUWU1ja2lwcFFwd1RtZ3dPNHhoSFFZR1I1N2k5?=
 =?utf-8?B?RVZub3dmNDJQQkNsU0VOdE1BRDBmRW9jQjBDVElVUGRjSUg5dlluc2xUbGtC?=
 =?utf-8?B?OFdISVJuMzY0NllEZFFRWW9pbWsyZGFBbkU2R0xyT1RHdURuYVNuR3Z5UWQx?=
 =?utf-8?B?VDYxdkxEM2pEL2F2Vml0Ukl1V2cwMDVabmxUWjRDZHpKV3I3SzlGakEwRTQ5?=
 =?utf-8?B?TENWdk9ZZGxCRU14OHJBMFlFYjNqd1dpNndDbFY1UzlIYS85S29HdmNNRmxD?=
 =?utf-8?B?VXlCbitqV2NaK0t6V3VFRXBUdGtvRTk2TFJ2ejRoank2eVBqTWJWWE9mckdX?=
 =?utf-8?B?WXdIUGp5S3BCa0JIZjN4MnVWWWVqeENXcU5MaVBRWnc1REdUWGV1T2hxTnlS?=
 =?utf-8?B?eFJuVjlaLzJseEFaYlZsUGxRTzcwQ2N2bjJ3Rml0ZXBPWEdiK0NpSk5VZFNk?=
 =?utf-8?B?b05ITjloYktWNXpWbVlXeUUwMHRnUXVSRDIwcHFUdkJxOUVVaHFiSWFobWRp?=
 =?utf-8?B?Y3BjNFhMSFdnOG1kcENQMTBiYXNBQkJETDJpZllzR3VSWDlBZTB6TnpTSFZI?=
 =?utf-8?B?bm1jUnFNMWxFK05qV0Y2R0RUMnA1QmplOG02U3dpMnlxa2g1NXRJZUpJTXlx?=
 =?utf-8?B?L083YmZiOERBVFJ1bVpzK2tqUXZ4SXowYmpySVJodlVSR1h1TjhUMzV2bmhN?=
 =?utf-8?B?dUNkNW1sZUNOa0Q3cGFWWExmWE1BQ2ZhVHFKSExzTnpseWdyN01wRzVCK2c2?=
 =?utf-8?B?ZUpxY1BvVTZYN1o4RVhHalFUMzl2cUs1VTl1TE1QbFhyQms4MW5ZRmtzNWxU?=
 =?utf-8?B?RXliZ0xtZ0pxQllGaXhuOWp1V0Q1UXQzRStqWmdweDkwOWNEM05Bc2NreGRE?=
 =?utf-8?B?WFNnNEZuVnQ0eTQ2OE5va0ppb3lWYzF4eEdMU2Y1Mkwwc2c3Vk5tYUR3TFd5?=
 =?utf-8?B?YWdwWkVKSjVyRXYyZ3plaWo1aUh2dmF3MFdJNzRod1pKOW1BT2psL3RoaW1T?=
 =?utf-8?B?TFZsa2NiZmg1Q1c2d1hIZnpHTEVDRExNcFduVFBhTldkb2g0VkhXVVVqY3c4?=
 =?utf-8?B?WWFmdU5lUmpucXh2eUxLY3JzY1dXVUorRkdVbzJMaTF6R25UbVYxOEFrQmo2?=
 =?utf-8?B?TTR0VEU1OVlTUDBLZFkzdTRaeWcwRnBPZzVpb2F4bjVzM2hJWFFnN1JVZHFT?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc37829-fb19-454e-a503-08db2989fe25
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 21:28:05.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqCMjRbO9sGhxH6Ivaz5IJgOVUOIRSw1NLZP2uSd9we6SMAMlONSSYkNlgO5PUCgEiXGOCIQvU2YiP2zH07uUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

*** IMPORTANT: Due to their age and the lack of significant patches, branches v20-v25 have been retired. ***

These version were tagged/released:
 * v26.10
 * v27.9
 * v28.9
 * v29.8
 * v30.8
 * v31.9
 * v32.8
 * v33.8
 * v34.7
 * v35.6
 * v36.6
 * v37.5
 * v38.4
 * v39.3
 * v40.2
 * v41.2
 * v42.2
 * v43.1
 * v44.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v26.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:03 2023 +0100

rdma-core-26.10:

Updates from version 26.9
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * Fix incorrect string lengths in sscanf
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGy8fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZM9XCACp87H4j537nh0A
+qgtDltzQvC+1LgDtf+uzf/Qb4o4TkphUKX1WWzWS/ZRZzOUhOhg9uyaBxXqIdrP
Dw+kDnHwsVXuiScWUnMO3uMPySPagkyp++k+qLz6vKa0+z9zSuKcBCWwTvGi5ed8
ID6BX3fTwQ/cqYGfAnn8CP0drwGWeNGwgv0t+uAoqsVh33ggL5syC/LfgKrOxvca
RwQO0HJTx9wOnGOii59sJtJxd18P35kycGKJaXTMgMy9zp+dlNmK3kgpipT2fcCh
OqFibXcAqHUeESFny8GGI5O46yjlBd4Zd50bZ1FoEiJGP7ZDeEvYAkT54/MC7IGW
RUatk2ij
=JSgg
-----END PGP SIGNATURE-----

tag v27.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:09 2023 +0100

rdma-core-27.9:

Updates from version 27.8
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * Fix incorrect string lengths in sscanf
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzUfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZFJFCACXnV5wkOkSutg3
do6qyxpvgxAzdPeyxC/CB6hPtNBJxhhSHgPlD1JMyaZfBPIjQ4agFuhPf506gJpq
wOnv+fJ3E+vHBH3E/8TDgyg6Y6i6Kk1xG2w5P2DN9PSamP6DPIEFAyntb1gYGGrd
NsB12IG01tjxb+FMROod/iFEXY67R7SOszcTeNZuqFsSlq6YJ0Fs/Wzpb/6l9PQv
XAaJl7tEsfDm7pfBl8vqxEOSm+r1m8t8tAobG9HV35qjV1hxDVrq23WbHfmVkQuo
fLjElT/L2z1fmyjvE5u/pLC9TfWM2mPFvx3FBUgHbmODf7Nuf9R+gIV6a8+1aH4r
TgKrtHjT
=24H7
-----END PGP SIGNATURE-----

tag v28.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:10 2023 +0100

rdma-core-28.9:

Updates from version 28.8
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * libhns: Fix immediately error sign type in data path.
   * Fix incorrect string lengths in sscanf
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzYfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZENkCACkDCI+rNTcxCiw
DdeUMFXdx4HXdRbWwSzwZrBrQu3XySiy56WKaYi+1+UoSrSXa3aWgWP+Cq9fPc/Q
t/f0pS0zH4Nd/Ins9G6XxVgjB7ezGNI+9kDp2Eus4nAEGj9X6sJ8tFERnVG2Thbh
g1clwN/6+i2EIhfNDbc12Pna58F5CpVxS7+lzf1NCedr4DN03BFA5dTgfguG06xB
oeLiwkL/YJR5IiQtkQeay5/RpGJnoKV4/NeRYODi/DAW46zhjht4r0zWzCmAsz4x
sHIHKkGZMQW0Ih1UK/VGsdQX1rxLoQAhMq5wMbNfyCdRzjMk6fT+/utzJUsqSUqJ
F060ln5k
=9H30
-----END PGP SIGNATURE-----

tag v29.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:11 2023 +0100

rdma-core-29.8:

Updates from version 29.7
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * Fix incorrect string lengths in sscanf
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzcfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMhgB/9uKSOnf/29LviH
Y4q7U85qZ43crMj9CZ+Upxql6u1+LlSN+ERbVgAP4YzmSEPGs7iTAOGlryexb+Zl
syIzi9YrsXLcDy33u/p9tJFLK2KXMmVZthAivzqt5hUgEwLZmUV36QpDhIk03f1l
9MzH1CvDm4KlbnLZ4IkBmEYdMdIQS+1aadRouY+bpP8Z/Nj6/YfAamePXPCtTvWG
InHgl1wlP40/NwqD/8MSJMUqfKH1Q3FbjCbO5tkBlcdZbyk1rkcmpeOpucnbpaTQ
3nwwYQxiDwh/+DHXkHqqd22Qet8KLJ/hP6dfjZuZTPg4Rrc0PsccUHzmZv04xaHq
gaeYSxjH
=ooWm
-----END PGP SIGNATURE-----

tag v30.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:12 2023 +0100

rdma-core-30.8:

Updates from version 30.7
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * libhns: Fix immediately error sign type in data path.
   * Fix incorrect string lengths in sscanf
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJt0B/4zS0OhvI8p906A
RIaiX22E9urd4mvcOmayNfW8DWnivhVNgi2ezFRsrmcZNd3xAqTA9x3Pukqqc6QN
qxMgVhaTxT8CRkjRKs/9CTX/zb9dynakkDOqZ0YDil4tlz9OmnwiKzjpc1MqVBDb
Gx8ueCurFGTuXmoO8J+Gov+MzgeCAazobCyh+OTbSST8TCHv4cukL2iOFtAM3+SE
GnvI3a9v1PSrDzLFIcIi8SScuFnRZju1UMCEpuQZqaBZuRDDiUcRogzLbHC9S/68
MUu9HRHhF0L/BW8cmkcK8pTIasqgmo4+5CdrWC2hMSmWC3aUVOG1Fs2RHZNpSaSe
G1J3VE2w
=rk1r
-----END PGP SIGNATURE-----

tag v31.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:12 2023 +0100

rdma-core-31.9:

Updates from version 31.8
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * libhns: Fix immediately error sign type in data path.
   * Fix incorrect string lengths in sscanf
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMIPCACYuyUTl21Ktc3X
TYuiqE3IoAuk6neWaFLBfIOOw8Aj9PfvZeu/FBsBRH9n726Qgpkxy433Bo8oGoGE
QXUmzfiRvEuO3stsuw+B14Z3g5bwgJCHGYGM3dSV3ggwuwxRmQsPTcwbs9VyUVyv
e5PkHvOUl0ZNkpcbep8QsMvSKr+hCTW9XX2Cb81JJ78Aoo1tDIK1y2v3nDqF7bvl
pnrgt4pcioIdBIPedweAonFOWdsMiSYl9noZBOoIBYgyI/FZxkcG2vW1j+sTlNM9
Crva5kpMFqIM7kYx2alev2vKIeK54nuiAGMvC2Ty4cJQZTKZOc6Ah7CP3PSqqpFw
sKWaFJeG
=nxSt
-----END PGP SIGNATURE-----

tag v32.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:13 2023 +0100

rdma-core-32.8:

Updates from version 32.7
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * libhns: Fix immediately error sign type in data path.
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Use the same STE for cvlan and svlan match
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzkfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZF86B/9z6q6ncOLVBJ1C
IPxvEKEcg7OY7JvLCQDqA0nMb5XiXlX6GuBwvNvUiW2TwKxM2WGWyQtXpG6GzOcE
pt4noqgsYNsqadWn0cK4+45JE8n1u0SyoLcLoWyOx2jE3eq7vEJ5jyW2O0wn7LwC
DBju8iGEhBRu/F/j3KNMorJDq4zKHAmLgW/CMtrjhIbZJZ4u7oM36+3qhTFtMXfA
ydP3haDQNPVWK28b2EeBvOmL/Cwe3ThRXgsO1WO/N1MlynNh1mfFg/n4Rh2Yh8/m
LrSSt3nFJN6JLNucrGQ6w7lchc8ngWrNhUT92AXhuRkry5PVq5VkGkcckI5rAnRU
DfIY1/jl
=WsQM
-----END PGP SIGNATURE-----

tag v33.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:14 2023 +0100

rdma-core-33.8:

Updates from version 33.7
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * libhns: Fix immediately error sign type in data path.
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Use the same STE for cvlan and svlan match
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzofHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZH4dB/9gGbLRw0Uz8XTs
qyFbAoKwi3P1saDNps7aRy7Xki38qOoyZZ0uf+zsLHvzPuV/X2KaH2xGdP+osSAz
bhQrzGpqMMmyWRZFylH8ciLYJCNQXBGz5MNPYNBbV7NSiLJJ5QpuECheS33P9dwP
WqKHY7utTlkdWoHoXM9R3hHPyzAW/7vO89htCgJEzIp31dIOv9RAY+W+cEQjrZU5
NSaMNBMavyI0q8yF/3LCyU5ZWNT8l1WIwaL5fYgJXgxRa/T+406ePymsnuFqdxpe
X7WGvNIiRa8ah8JeSGpV7FDxDGRtXNs4XLcdMO/qraWq4QFWSp01mByD83H+qjOt
p2DvLEbT
=6s06
-----END PGP SIGNATURE-----

tag v34.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:14 2023 +0100

rdma-core-34.7:

Updates from version 34.6
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Use the same STE for cvlan and svlan match
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzofHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZICJB/9q/PhdfYqSRPpD
K7AKXI5kuWmIvNBBpNYX2U/9c3PmuNJiKuhHU8R7pZ9UrFr4nWhpcO3Qqc4qpxuv
tdj0qvzCRHWzcVdviA2PizSmq5JImtVIENwi+oSxHvMME7sZHxyrNUnfQ+IMrSBO
kJzMiSTRAp3Xq49Kcqm1ovUh51vFK6bTuAlSFvWiMAgmriNWGNF9CdacXzhSIob5
Uk9d4VBrvY2+uAlQFjpU4ERhE0JzgjyydkWD19OblDbUYtrZiK2iv9BOnxnuBVIf
VLCbuX0rMs8LyVkwKXZuJt1Dn/VBzA0n+F0arMfLf6Sz9mav+04v2WXEWfFRjBw/
bUIvlXz/
=hZut
-----END PGP SIGNATURE-----

tag v35.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:15 2023 +0100

rdma-core-35.6:

Updates from version 35.5
 * Backport fixes:
   * buildlib: Remove centos6 era distros
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * libhns: Fix return value when creating unsupported QP types
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Use the same STE for cvlan and svlan match
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzsfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZNx+B/0aePB7s3ZrwEXe
LBzjrFeWdk+kIGoljCai+QfXHQTWulrgVIKhGqtwElIjM9G3y3FEbo1468tXa3Jh
66F5rTntUQPyJxbBYJ1skHL2aMLrudSxEAI8SxxcSqE75DBLchyTfFr1zonDhqv5
e5PidXG60944v2avk05hPAq14k5b3JCwTM1xz54Aqm5U82/lMnw3BVmzWazCgh2h
Epk2IkoVNvoo4hmyH0dKxnTQkeI2w8YjfvaSsL/DstayA2wHms8xbTQLQjcknE4t
A/RY3GWLWbWpPkMRonhQM5pyEGsf+BOvyJSyca1MvZMyrJ4c9+N6/Qnyvl9CBlSn
8PMvngVI
=vFOG
-----END PGP SIGNATURE-----

tag v36.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:16 2023 +0100

rdma-core-36.6:

Updates from version 36.5
 * Backport fixes:
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * libhns: Fix return value when creating unsupported QP types
   * mlx5: DR, Fix partial definer2 ip_version match
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * tests: Fix the error message in check_mkey function
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzwfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZLiLB/9gjkL1Q0IT6hq+
Q2ZpE9R7g7EBqX4mdWuy3yaai1zOFrgYB8LFZ8CUH1l3gZ7wpqrP7qYcVcs3JMrO
CCs0m1XLFrVQKMnmbM9yO9lzSLrd+PNoZZKVmupov0c/9Oug847e/bqSsvZavpss
6tqC9Z+6qU9/SCqbkNxPqPXw7oPDg9YsVpmxW7dfWaZckT8mZfhuJ3rtNkmBAKjn
xRVIMcJ4VsiNdjwboj3zJq/U85FdwQ0RyL/BkU2qqQjX6W/0zBH5HmaAgg96nk+d
A84+GAi9drvomYjmd2JIloqNsF/vl6qAs5pJ1Ys247gIxWRwlPi/AoiCqKn9U/iO
xtkqSOl6
=apvZ
-----END PGP SIGNATURE-----

tag v37.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:16 2023 +0100

rdma-core-37.5:

Updates from version 37.4
 * Backport fixes:
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * libhns: Fix return value when creating unsupported QP types
   * mlx5: DR, Fix partial definer2 ip_version match
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Free vport ib_ports on domain caps uninitialization
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * mlx5: Fix bugs when registering a MR in vfio context
   * mlx5: Allocate one more pointer in mlx5dv_get_vfio_device_list
   * mlx5: Fix memory corruption at writing UMR WQE
   * providers/irdma: Fix RQ completion opcode
   * providers/irdma: Fix inline handling of multiple SGE's
   * tests: Fix the error message in check_mkey function
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGzwfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZCOJCACm3kUF0Q1fJ19q
4RAnFdusmuw1dz0VKNHd8PXtefMqbg6lq/Cr7ZrwSkJo4O39/Les+naIjh7fJp8c
JTbkAyjaso5TD8zwQUyPjUlNHq68SwnYlEDg6/oDvyMF0bVX8JX7AMU5ZlwVcfel
t5WlZyqnvkGVgoy/CiS8pM1f3b0vL2wfi//JdbPxqVXT75+BSK1xClAMhqBf7nNO
bvgAHOlkxEBQ//B/9AFX2Nbz0IM+4OG2XBIiJFTWKfgpDZwORkIRrOGX/nm3B+Ti
TCfdXqluRGzby3x+E+rs7B8HKlWRB11jz49CmXkIHB6GLaODUEG1DonFnv7kr38o
q0jOCe1O
=y8s1
-----END PGP SIGNATURE-----

tag v38.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:17 2023 +0100

rdma-core-38.4:

Updates from version 38.3
 * Backport fixes:
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * libhns: Fix return value when creating unsupported QP types
   * mlx5: DR, Fix partial definer2 ip_version match
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Free vport ib_ports on domain caps uninitialization
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * mlx5: Fix bugs when registering a MR in vfio context
   * mlx5: Allocate one more pointer in mlx5dv_get_vfio_device_list
   * mlx5: Fix memory corruption at writing UMR WQE
   * providers/irdma: Fix RQ completion opcode
   * providers/irdma: Fix inline handling of multiple SGE's
   * tests: Fix the error message in check_mkey function
   * tests: Skip dest port action tests if unsupported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGz0fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZFftB/0Vn5kkmzTXo6xb
TrG1twrTg8rlWOB1C9AfRWiT5Dia0mOqEzRP1f7lpZUBUbS0pkdfmBvgVKIVBw4f
yeGhSNFNaZz6QeU3wiXEqVycBCly4TTdnuQBHwkkpgo8XHUtc3n5JZK8Ul7wRl+Y
eF+LtvK0b/YlcPDgUX0ybtlT75JeKbj1xMmJ3DB658EssDIFCnzKCFFJDxf6q/yE
+72ixsMMk1jt+9Z7YMReGHcMxh0F5IbqQxQgivtj/g9djbjfVjy1rtbcQOd7Haky
FaQBSs5AlbkQ6KtylUt55mORzWBJP915wo6FaiqXmhxidJFetZQEtXAn3MaNHFPM
CajWBQeA
=COsn
-----END PGP SIGNATURE-----

tag v39.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:18 2023 +0100

rdma-core-39.3:

Updates from version 39.2
 * Backport fixes:
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix return value when creating unsupported QP types
   * libhns: Fix multiple assignment of WC status
   * libhns: Fix immediately error sign type in data path.
   * mlx5: DR, Fix partial definer2 ip_version match
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Free vport ib_ports on domain caps uninitialization
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * mlx5: Fix bugs when registering a MR in vfio context
   * mlx5: Allocate one more pointer in mlx5dv_get_vfio_device_list
   * mlx5: Fix memory corruption at writing UMR WQE
   * providers/irdma: Fix RQ completion opcode
   * providers/irdma: Fix inline handling of multiple SGE's
   * tests: Fix the error message in check_mkey function
   * tests: Skip dest port action tests if unsupported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGz4fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZPdBCACc6hkvGlA9i10W
k4gP9voYxtLl0Kk7fxtm4GWwkhDIQ207nGiv5qTXFo6GpimysFuik8pkyDy/gk2Y
JDhp8LxkCpR9U4xQpjXps89NpEvczoripA/aJejVJtlDYY2C0bT26rOtaloZDUk5
1D5TPuJ8HUJtqY26OLnceL4kGIkh8HP0e/nMwUqI/+mhL7JlInUbTWgIGY4MfngW
ER6vuuqqZu3cnSCbQAvLiCClq3FqdHevJKmcb0xwkJClR3ZatiwCHv4f77ZZVTvL
XcSkt69m80tI2k1pMQCaXIZX2KUqk/55ZVZYkgwNEcSuZxSU4GpxY5V+iegWD4eQ
rZW8qwN8
=aIIf
-----END PGP SIGNATURE-----

tag v40.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:18 2023 +0100

rdma-core-40.2:

Updates from version 40.1
 * Backport fixes:
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix return value when creating unsupported QP types
   * libhns: Fix multiple assignment of WC status
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * mlx5: DR, Fix partial definer2 ip_version match
   * util: fix invalid memory access in bitmap functions
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Free vport ib_ports on domain caps uninitialization
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * mlx5: Fix bugs when registering a MR in vfio context
   * mlx5: Allocate one more pointer in mlx5dv_get_vfio_device_list
   * mlx5: Fix memory corruption at writing UMR WQE
   * providers/irdma: Fix RQ completion opcode
   * providers/irdma: Fix inline handling of multiple SGE's
   * tests: Fix the error message in check_mkey function
   * tests: Skip dest port action tests if unsupported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGz4fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJ2NB/0STONDPsBbvMWi
pZh3OS6bHauTaSiNz8efVhwamu7T0oIW6LLq4ecE0VZmjLTVy9jKKOSNUIKzy8ED
M/vOo/WV7ezFc9uhHryeHDCeK2OaaeYazlNt8Tn7QkSJqVxD5S2dsXQB2aBmxLir
TGmlkTuXnaAId6unV20rS6MOIrnsXx6eM23kYpGRlkQLauIkr0fcQzR8LR8gGd5f
cEOYDI7lCCB21axaiv6b3u3mk+o+yg3uC5SqJSpslS2txS+SwpFWMe6JU+J2uSNs
SU01ImKwTVatmy5GaiQZyZZYmdnDdp5soomfPO7sJFElqlW4tv9MYkWqhAtt13jF
HgeE0tH6
=wgFv
-----END PGP SIGNATURE-----

tag v41.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:19 2023 +0100

rdma-core-41.2:

Updates from version 41.1
 * Backport fixes:
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix multiple assignment of WC status
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * libhns: Fix return value when creating unsupported QP types
   * mlx5: DR, Fix partial definer2 ip_version match
   * util: fix invalid memory access in bitmap functions
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Free vport ib_ports on domain caps uninitialization
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * mlx5: Fix bugs when registering a MR in vfio context
   * mlx5: Allocate one more pointer in mlx5dv_get_vfio_device_list
   * mlx5: Fix memory corruption at writing UMR WQE
   * providers/irdma: Fix RQ completion opcode
   * providers/irdma: Fix inline handling of multiple SGE's
   * tests: Fix the error message in check_mkey function
   * tests: Skip dest port action tests if unsupported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYGz8fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKuSB/94SFCmUeGmllQ8
6GRZ1MTYfmXwIrofxWNUcMqeZpjFc1yL+nxpT6ubOq7rHh3WsZxS+iHbArM7mR1J
GhEGHTc3jv32DT5/OTUijM359ne4F6fgjGuDk/G37JU6sMLrr3U0cZGyFxcL6eW+
lDUG0/AhwgmL1tqXqO+o+gQDjuOsWXNg7SYDS4/2AvJ3s8/xmON+Ux8xQ0VJsHaV
YbWLaoJuMFX8bMlqIeCQaMSoKBve+ZqxOc7Sda9cFbX+BrNjPs4ekyeshdrswIJP
WXncN2kgKPn1ooh8Pgj0iMU9bVtmy+i/BzY4GSjDC/XUtGGHTh8163Q2cU+RPNb6
uSmOVy9V
=kgn0
-----END PGP SIGNATURE-----

tag v42.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:21 2023 +0100

rdma-core-42.2:

Updates from version 42.1
 * Backport fixes:
   * mlx5: fix inline send bug for DR
   * mlx5: DR, Sync pattern icm area on SYNC-MEM command
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix multiple assignment of WC status
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * libhns: Fix return value when creating unsupported QP types
   * mlx5: DR, Fix partial definer2 ip_version match
   * mlx5: DR, Fix error flow in dr_arg_mngr_create
   * mlx5: DR, Removed unused member of args
   * util: fix invalid memory access in bitmap functions
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Free vport ib_ports on domain caps uninitialization
   * mlx5: DR, Fix argument put list access
   * mlx5: DR, Clear args send flags
   * mlx5: DR, Fix a memory leak upon destroying the arguments' pools
   * mlx5: DR, Enable up to 64 modifications in modify-header action
   * mlx5: DR, Enable pattern and arguments for devices above ConnectX-6 DX
   * mlx5: DR, Fix issue in writing pattern for accelerate modify list
   * mlx5: DR, Apply modify action and decapl3 correctly
   * mlx5: DR, Initialize pd_num before pattern/args initialization
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * mlx5: Fix bugs when registering a MR in vfio context
   * mlx5: Allocate one more pointer in mlx5dv_get_vfio_device_list
   * mlx5: Fix memory corruption at writing UMR WQE
   * providers/irdma: Fix RQ completion opcode
   * providers/irdma: Fix inline handling of multiple SGE's
   * tests: Fix the error message in check_mkey function
   * tests: Skip dest port action tests if unsupported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYG0EfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZILfB/42qRlYx2CojvaA
1iy9pQRnwP/fo+Q+GfHm5pzHJucMYHgauzirdeO35EozKHKo2db1xQF2OjW8iRT8
y3LvGhZNokmQtiyeBLTZFddaaYKmnaW0ulbhME/whOROiECvhOtWy6vqA9XKFyfB
Nv2tqYFzOprcEaE8Co3DOMBxEmoMCFTBpCZYOm+Mu3QXXsQhdLNqSMRNP0gOmowZ
HT6TAyPCbwvbBTmi0+1k6A6P8/AkabWyS/b6blDXNKihmhTu0WZKKzIdbjTIP6kl
8tDDnB1tD/EBXV+xbNB5dEqdo7WF55zJdu0ipcKBoJdvRtof/yxHwcOaKsSLtgdf
B3JMWVnq
=cRFe
-----END PGP SIGNATURE-----

tag v43.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:22 2023 +0100

rdma-core-43.1:

Updates from version 43.0
 * Backport fixes:
   * mlx5: fix inline send bug for DR
   * libibnetdisc: fix printing a possibly non-NUL-terminated string
   * util: fix overflow in remap_node_name()
   * mlx5: DR, Sync pattern icm area on SYNC-MEM command
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * libhns: Fix multiple assignment of WC status
   * libhns: Fix return value when creating unsupported CQ flags
   * libhns: Fix immediately error sign type in data path.
   * libhns: Fix return value when creating unsupported QP types
   * mlx5: DR, Fix partial definer2 ip_version match
   * mlx5: DR, Fix error flow in dr_arg_mngr_create
   * mlx5: DR, Removed unused member of args
   * util: fix invalid memory access in bitmap functions
   * Fix incorrect string lengths in sscanf
   * mlx5: DR, Free vport ib_ports on domain caps uninitialization
   * mlx5: DR, Fix argument put list access
   * mlx5: DR, Clear args send flags
   * mlx5: DR, Fix a memory leak upon destroying the arguments' pools
   * mlx5: DR, Enable up to 64 modifications in modify-header action
   * mlx5: DR, Enable pattern and arguments for devices above ConnectX-6 DX
   * mlx5: DR, Fix issue in writing pattern for accelerate modify list
   * mlx5: DR, Apply modify action and decapl3 correctly
   * mlx5: DR, Initialize pd_num before pattern/args initialization
   * mlx5: DR, Use the same STE for cvlan and svlan match
   * mlx5: Fix bugs when registering a MR in vfio context
   * mlx5: Allocate one more pointer in mlx5dv_get_vfio_device_list
   * mlx5: Fix memory corruption at writing UMR WQE
   * providers/irdma: Fix RQ completion opcode
   * providers/irdma: Fix inline handling of multiple SGE's
   * tests: Fix condition of bad_flow_handling
   * tests: Fix the error message in check_mkey function
   * tests: Skip dest port action tests if unsupported
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYG0IfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEQWB/4mexJdYcY6VFOv
y0AbxVRKlVx0vrwXtzdbZ8tX5VqMbXy7jyZ3Oin4m6bGzCBgItMi5YCHSJxnVSq/
Auk+WjxTuwTcJk4X7rN8RE0LvuamgMwomFMIS7QbuW9zTL4w3yKNkOc4HLE+FKIk
Wcfo60kLpFZgiwcE022Z5jzv9QF534E0hODS0BUULLv57Teqr9Do4UVKB1nfKhW4
bNkOHz5RRxbr4+JNSXGS0+6axT1hMfkszs3KhkqKxWlE8yAiduVQbjSE8KQghxrG
WZyP9/uGUEkKQe6CzHjKBe1GBACT9QejCP24bHm9uMDUX2O0V7YFpf0/RtKlQK89
L6QnsEvr
=K9d8
-----END PGP SIGNATURE-----

tag v44.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Mon Mar 20 09:37:24 2023 +0100

rdma-core-44.1:

Updates from version 44.0
 * Backport fixes:
   * tests: Skip CUDA tests if there is no CUDA device
   * mlx5: fix inline send bug for DR
   * libibnetdisc: fix printing a possibly non-NUL-terminated string
   * util: fix overflow in remap_node_name()
   * mlx5: DR, Sync pattern icm area on SYNC-MEM command
   * mlx5: Calculate SQ size correctly for a QP with MKEY configure support
   * buildlib: Remove centos6 era distros
   * debian: Update debhelper to 10
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmQYG0QfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKCTB/9xPl1By0tgEDoL
NLSdrN52zMWC4FGto5Sa+foR2HTCv+Y2vD+SGHFUVzw7PylpsV1GDKaAW2gfeIhD
sW2q5Pe8LI2HAYSaDCNR5U+Viieov7EH/9DY/qa+IS9R+0BiNr3IlY9jKEOnYesO
g6g6uO8kIqIv5VKyCikmr2B9xP+IipxU2VkVPMYjRxiIsjqS7QEwE/JtqbTClWLW
QS0PI0cIbaCFGDIfcTpjuyiUvj5/XS2u0+ep9aBZo0XyzYIskmRoj0N4og/8u90H
W/QlIyFfYJW3VtCCdIWdYWevWFhtSuGzY55ibLokGBW9Ngu0jaPS84H5BYzYMuKJ
y1nuI6I3
=XSzZ
-----END PGP SIGNATURE-----

