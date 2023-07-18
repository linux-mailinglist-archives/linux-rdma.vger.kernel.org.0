Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5347579B1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGRKzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 06:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGRKzV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 06:55:21 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEAFCF
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 03:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG2v+t90VxuRH7CHO2rFRSqmP8opRCnvkLPNsYU4he/DQ3KS76+Hqnks5LyNwDN9Ztsu7zgB1UesTK6q4ZF5sXMLaiJS4R8OwE27w8TvubFYyeBBBvW1N6lWkvSFzyBNVKgf6Z+8VygmqzoCQTVVS54WlSaZwxd3x0mSWQp5XMPp0hPzaE9tqKhqMIJAl3yaqFaCupwDXvqBfyOPbe+LG0qA6/IpXWNrRcVFmT56SQR1THojV4lD46Uswyqn6KIa/XvxW2pXXOi5SF3kcbHINbU3CvChFWaarvodfET3zXAAt7Kt117j/DW5s0wQksxltA/CzQSiJS8mZVLIP8WeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Sb/o3+Mg4wndR87cJju+vHsATFFG+aoxia318P9DIk=;
 b=E7bF2xAeicvo0+BDq6yea0mnDAwJ869D3DFgPAtX4AUWWU96/l9utF6kHy/6nH1AFu2WS0ldnU8Eeff5zQDliNkV/0pb8evLAaMVnac430gI4V0wq9Z45NWxvBWdkuUA3B9jyT3/gnhy5jN/g1OwUf3+Yi8iwsLzpbNa2V/Biur/bN/DSNzV4BxC9y4BY6b6dRN7YyTc426W+agShLF4Cj24Oi9HD464brjWQIelRCR50tTXKPPWFX7VfOmcaLfpKkMzmNxHyBNNv3lb5qPZQE8CH8cHxKwUvjvPu9QYbKPHUO5THnB25k/wfjefJNkaIAAbwCDXYMPiV7ZllXlRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Sb/o3+Mg4wndR87cJju+vHsATFFG+aoxia318P9DIk=;
 b=E8AWjmw3/XB8CwKNV1u/UknJO/FRI9jfhjvHnIlieGcJSmWyECfREJXJKEr+TiqhmBTs2ITQHfJGsmUI5xUXZK0wcfVkk0lzFjtoo7VFJf235IsPEUMmFNK1V1zBeYgc607OsGWn16dUnA9rdmV0U+vhJXCbjryq3SpR88zGRt0NWLR8G7O44/D/3dsk29rXZ6v9vauarMwjgOfrahYbCeCuCLOga/OyZCImKZDqpd54MhQo2ty+Hi/5lGrVB9g6AD/3/KeuxwCCRCrnaXiOSicnHS7Vx5cmo+M+glvYxNZibZM7/ErWd79DJIzQ+uenvpp6evSPOpN6PWxMcFnyjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com (2603:10a6:7:1c::23) by
 DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Tue, 18 Jul 2023 10:55:15 +0000
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::5187:347a:88b6:5741]) by HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::5187:347a:88b6:5741%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:55:14 +0000
Message-ID: <a722da40-f514-157e-2309-e700ec59c6dc@suse.com>
Date:   Tue, 18 Jul 2023 12:55:12 +0200
User-Agent: Mozilla Thunderbird
From:   Nicolas Morey <nmorey@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     linux-rdma@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=nmorey@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNH05pY29sYXMgTW9yZXkgPG5tb3JleUBzdXNlLmNvbT7CwI4EEwEIADgWIQRC0lOFwaHA
 K4sbHG+AG924JZiPZAUCY5G8SAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCAG924
 JZiPZMZiB/9QkcGfH248qvFUWZig3jssK5IgijfOFDKB0YK4e844M5C8LVSuWpu7Z+lM+cql
 3mbrikW6mlZjPEusrQ/KGvT6TdfOM9VCQWjlshMzt7uiRDdzufHGtE5hhk/67UnkEVjmplpD
 k8cb1O0VsBfGym7e0nySHTlDWqr++9EcwgV3uo4psYYEqm6Aon1yKqjbmj+vfl/C5iW3V4lq
 DhBk8w21AvNS+tdEqJzhruxuXkEDZZ07wYFS7m8OxLNb4sMzn/Nz9x/NXeweBWx2ujIERtAq
 1e/hh0ZAcoPVR3CfO2QTmfTfrzVdpZrZ8F54337ze3+BUNnrFGObQhlNe26NqNYWzsBNBFjZ
 ETwBCAC9zAzCRlTgzyO9siVLQYwbRUhcL1TUJU/FiOQWQTmL3uDdBc6MgVBs+hp82RwPbbXT
 v4W4rghBYPKdmFXvRN+jvGDLq1f2hsuCSiE1ckTMzFV+sKoWRIEC12tEpw5ncEFGm+1k/rJR
 Lk9eHxuqn+yRjPryN8CK6tK4+b4tZ2urKlP29XG+T3l/mbUSoqfjqvyeKaW6xw7ku89EX2Xo
 QWP/pm92RxUd6VDU9vpVW/T7qPZRl0wtUnDnO2wePoZmvUfEr5Osh3MNvm1myG+v4EV2Hgva
 NT6pa27IptrUq06cA6dDsIKwPtMuThJQp8/xumgl5Q9A/ErQoJTrB9rclIm7ABEBAAHCwF8E
 GAECAAkFAljZETwCGwwACgkQgBvduCWYj2QwNwf/eOIpFB67cKoUJvcm3JWcvnagZOuyasCw
 xwH9a0o9jORcq+nsJoynS/DpjUKGyZagy7+F7sBrF7Xx0cXF2f5Bo42XNNiQDE5P/VLwvgn9
 62AJ3q0dp4O7oQI8UgNmdsocQhNaBHHCoOabLGrgNobDTaLBeb9zaOZqz8CBuAiZ0bVABEpg
 50hDEYTHp4jCgWpadhAsp/eCgm93Tc+Y+e1fqtE3FmoOLxyhFa6evhn0Q1iX0kCasMZwlzse
 zqLZjTM1Koqn6+UIHXE3QaULyFKD1GDhisXxyolOB6P2TXsyfvitYdIZ3CCtI7PVDxzmX2Xk
 kvEz9bMtStoMpse9qAsmHQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To HE1PR04MB2969.eurprd04.prod.outlook.com
 (2603:10a6:7:1c::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB2969:EE_|DB9PR04MB9377:EE_
X-MS-Office365-Filtering-Correlation-Id: 017eabeb-9887-4cb7-2ee0-08db877d7711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWVcG2f5o9/mPxk0pZjxUGGdxRF1mQVEGZT/TcFw3cjRCAY0ZGnBDxBBDt3hfz8W0tFLHqFk46c6zTVKACxqa40UzCPLdqma/PkEMwBhA/zVXkI1uZ6x0Fg09TYv2oyZ+YQALJaJLjQUkvDaQk2zZLJLlQ/cNYTfFiqfNnoRRF5+4xHfgUJA5msMrHxCa29j1e2uuNYQfZ1BONci93/oe6PaHWhk5MvENG84Nr+HqU7zcbGRi30WC3YHItpqt/6r3ZRKYtk7/mPQQw6cY6yL4MtjCEULSd0NVt9zxs5k1ZinG/LUVRb0SPwnYb7afDH9Bz1b24zEwGeWoqpwuMbsPEBvUbmgbGC/QXU9ulRrSTBR098BBUrDOdCW1nybhWFkoiRDE/YDYzBtBjuDLQNs06yiwwseH70FHYfpJjvtmLKQY0X1rRWvDGJGpS1t7ZlrcEXn9BaRQmIc4CQ9IcNX4WERL9IibmidCZlcnw4BrPi4f2uh5Ws0/eeXm3+ho+4g4nYpAJbWTEloXN6rR5FIeXR5zz5ZgBYvCxtUkplTIX9ilVCA7R4SQkBORgYhUoARhletVEYazB/tmXtIHnmLp+c8EC7Fm9xW7Z558dC+0TlRtLCLJMBdyVyjy7YfnqhL6FQorqo7nMxC7jc3YMHVSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2969.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(316002)(41300700001)(66556008)(66476007)(6916009)(66946007)(5660300002)(8676002)(8936002)(2616005)(83380400001)(31696002)(38100700002)(186003)(966005)(6512007)(36756003)(6486002)(26005)(6506007)(478600001)(31686004)(2906002)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBSTGRwSkZKM25pM1VONHpZclozY00wSytjcm95TllLRnk4cGJsUjF2L0hx?=
 =?utf-8?B?QWlzdlYyQ3JYZjl6SkVIdThTMmdRN0ZvUmN2VDhMK2k4NGg1Q3J6WGdGWGJv?=
 =?utf-8?B?L043aEIyMFQrdVhzRy8yMXJlVldVWThKbGRhcENnK3FvdlNYaWg1dEtXbnR0?=
 =?utf-8?B?b25QZEpVYXFseEx0ZDN0VVJ1cFIrWFREUVMwSWRMS1J0c0hucmZjalB1Snh4?=
 =?utf-8?B?a01QYi9kWkFTR0FWa3RuRVRkd1c0WXBRMXBJeC9tSzZxdXZqQkxFNW1jVWpF?=
 =?utf-8?B?VU42TllsTFA4alNDdHFVUzBNMlJHczB6Y0VhVCtKa3BwSGFJeDhQc245QmZL?=
 =?utf-8?B?YUJ4OU1Cb0NSVU1VT1QyeWZnNHlLUGNMeEVSbFJLVVdld1ZFZFJPd2hKeU85?=
 =?utf-8?B?dEFpK1VKYTJ1Szdxb284QXExc2svUVltUURPTHp4WmJKRHllTkdkV213cmkw?=
 =?utf-8?B?QlpXYXVjVU0yY3ZzYzJieksyRTQyOGdQNDBQNHlRdmFGMm41c2h0ZXFReXQr?=
 =?utf-8?B?c3Bab2d1dTE5VlVUWGxHMVhySWsyRDhrb3JzYTlVWTJpT0tGM3N6bWZiVkJh?=
 =?utf-8?B?UFVBdGNncmtkYkdQaVk3cUVwVnhEVXZybXlEd1c3MTVUa2Rtelp6YmlXdU1q?=
 =?utf-8?B?MGxZMTBKSUdMK2ZsSk05MkpEK0tCVU5xb0xtTkZJYjY5SnAvL2RYc2FUeDA5?=
 =?utf-8?B?c1FqYXpETDhFMWd5WWVCcjRLL1BOc0RsTzkrTzZNM3RnaE1aUmhIeVBuc1A1?=
 =?utf-8?B?L1lyckNlT1orbnRwbEozRTFGZG9NaU1SMENDdDUxS1MvaE9qWDRNNW1wSFFs?=
 =?utf-8?B?S2U5VzFodUFhRWxaTXFXaUZ3YVc0cnZyTnlUWUhyU3R4L0tYdnEwT1gyZkw0?=
 =?utf-8?B?OHRDOG1wa3ppcTQ2MGtRZEZzN25TcGJielEvZkxiRUgycVRLbUtGWVJLNklS?=
 =?utf-8?B?VDJPZG1GUHNBait3eVU2dnJ1ZCtRRGx2b2FUckx0Yy9WSTU2bnprbHJTak85?=
 =?utf-8?B?OVVVYWNwbVlROTRFSnRqYnU4RWVRQWZOQXo0NGhlVlYzcUhxdy9DVy8wTHlt?=
 =?utf-8?B?R2tvQTlCdjNNYXZtOVR4MEJtTERjNVBhVkR3UWx4T1RYMEUzaWUyUVYvRTky?=
 =?utf-8?B?YlJSK3c3OXFCZy9nNWVDUHNrbkZuMjZwUndPajNtcWJsQ3RnYyt4UVZVb1Zk?=
 =?utf-8?B?Ty8xSWwvSERKcDVVZGpIZVVKb2tneVFwblVDdnBUdFhQQWYvaEdBa3NyRllH?=
 =?utf-8?B?SHI0NlNVNXg1V3JuajFNZW4zVmpIVzZBYjB4SmJCRnNreFhGclo2RjJrS2Ew?=
 =?utf-8?B?cGJWbjFqWit1UU5aeE91NGpEUUpDdGc2VnhmeUtadnYyeHJRZkdmRXFPdnR3?=
 =?utf-8?B?akgyZjBxSVFOSG0yZEplc1MwQWxWbThrOG9LcXBZK0ZtTGRpSE9pL05hak1X?=
 =?utf-8?B?TGlsMHQ5VVVjNFhYNHBLMmtaYUFYKzhraUVadnBobjJRQTFiVHlzN1Rhd0d0?=
 =?utf-8?B?OGtBNDlYS2t6a3M3K3R2ZGtzY21tb0N0VUJ3VkVYRk8vMTJVRFkxQVFSSzgz?=
 =?utf-8?B?R21IZFN5OGVVak1kZU5NWmZYYkR2c1htTlI5WmZJQ2RlL2ZQMit3OXk2cW9I?=
 =?utf-8?B?VzZ5YS9sb3V4dFBsNnNPNWNjb2ZKR2ppcWRIMTJSeEZENzE4U0kzRUZ1OE83?=
 =?utf-8?B?YVJxVnR2ZEM4RWJPSmZEVXpSOGw1Uk5INDdpTWZQU29MWm91dGxaNWJSdHBs?=
 =?utf-8?B?bHBHRUpqdzc3UEFwYmpjODBGY1RXVG1SK1VwdzY4OVZNd1VGcFg4TktEWk55?=
 =?utf-8?B?UERjVmk1b3RqaEE4bVFkSGd3b1lGK3NrTGJHRElXUEpPeVFSWCswMDVmZWQ3?=
 =?utf-8?B?b1hrWkF4SWw3TStqRkUxZHdHV0UvT2prQWZBZ01QVEtzUFg0aW5BWnhqaDdD?=
 =?utf-8?B?cklBRk42ZEVGakdlYUNGNlMwM2o1bkZIaFZSTWhZeEpmQ3NDdEJhVmNzRmZr?=
 =?utf-8?B?RWFyVExkUzBlMnhlTjBOK05xQmFLbHpna0xCN2RvYmNjTUZ0Z0FNQlVvWlRX?=
 =?utf-8?B?ckFXdTFsNnpkdUM5Z0lrUkhrTjZqQklMcVpoZHhKK0JvRHVhNTY3VEF1d0VS?=
 =?utf-8?Q?1exFMJlIh/mhh2V1N7tQsPSiN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017eabeb-9887-4cb7-2ee0-08db877d7711
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:55:14.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2M+aFvZuBiCRgLdmlUS3tQlZmcGprTtLAvnKFDU7358b9pW61Qxs6N9lk1jH/v8ZY4g8C8qBAIgERchEWk3VIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
 * v28.11
 * v29.10
 * v30.10
 * v31.11
 * v32.10
 * v33.10
 * v34.9
 * v35.8
 * v36.8
 * v37.7
 * v38.6
 * v39.5
 * v40.4
 * v41.4
 * v42.4
 * v43.3
 * v44.3
 * v45.2
 * v46.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v28.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:35 2023 +0200

rdma-core-28.11:

Updates from version 28.10
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SAsfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZNNaB/9e01hQcVNQQuHP
+UvB6F0p628bA78952BKaBMPTkSoxRipL6Bhrniyt+B4BT+Zom9Wg3+Q19T+DNT4
j1bU5AP+HUIFUraMyTvcJUszmP65xlAId1Jopc5kvjN8QhUu54aD8+wARDwY4KUE
TdcXocBXOruNNChxPAX3bk/kUBBzotcG+G1wyIExTYZbpDflzzO8Px5FKOxwe0Bg
l+NKP3bEr62/HKl6odiaWYSzPxAklo2gt0+aTusoIb+HLOAToPQZMWDd2FRi3goZ
a2faYZRTlXn7luz2ZXn3x0TTPoIH9I72CbiboHognNsh5PIBKUIEBvhYjLdZ5exX
a9GZZi92
=GhWW
-----END PGP SIGNATURE-----

tag v29.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:42 2023 +0200

rdma-core-29.10:

Updates from version 29.9
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBIfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJc2B/wMTSMzWFs1IGaS
gdBNejVsGfsFH1wyh0RgA7SI412/5Q675oefBF+cK8gG3Pu16AgEoEqio6Z5MXns
B618V8IFAuQq4cp7yZfkaeo+1szd9nVMwkkCY5n8a3rQoEQl8A6Hzbbpi5f7M0tZ
SoAMBnyfCKtGtMcoL9Yesv2sORIs2ZyaNiAsyMdU0O6gcDyrh/bZIYBMEg8ZqKDp
YF5CEy/CepNTj2NMviCC8i/8m4iIYGHR0RKmYqg1+RSAtETwUuXpWkJMsQo/iz/B
1pG8UuyxD0CiSAmcfZ6DsTR3UWeZnZMdsHMAjCA8EWEpoXsr40TBXSz/LxrxHSTL
zyWj6xAh
=mF4I
-----END PGP SIGNATURE-----

tag v30.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:43 2023 +0200

rdma-core-30.10:

Updates from version 30.9
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBMfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMJfB/4labN90fn//TOv
+BwZ2ezrgQ2IkiG1Dg6lShX0XzC+TQonLiaon3IiXMraYFcMxJOgXZJ3jTgvRycI
qf/NYJzUmpDJmgklOEanmwYQB122YB6GNphez3IYW0a2HP0gJh/CJb6JjG3kVGyJ
4NMcGiEJZFytpdZKowcjzJ6E3qnSEoxCk18GqlYL8BkFBtf/GplHttKGAZOqLkC2
5hW8Q9Hg3c7HO72QdVTpwI+eCXyGCZFYsnihPTx+9NBxUdJadSnmNZ/aoZxj7rit
oXo9bhHy8u/uAw1InyvnTUMTk304rM+nbeAvPQwQSaBGqWsCgYZW7/Ga9+TiDfKY
YWVIGxv2
=glXb
-----END PGP SIGNATURE-----

tag v31.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:44 2023 +0200

rdma-core-31.11:

Updates from version 31.10
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBQfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZCa3B/0XHTXP6HT8Tiky
8Z0GtBJ+UJZ8wN+GZLPaosQoRXB39SOTPa/sVqA6Hx4LnUpY48nJ4mNCvpylTv/M
otR6o2iqeF9VmE+b7EG4PUmCNSox5twTrq2mJ79mCj4EXuKlqOIAaX14BECnv79C
Yv99deM1Y/PHWJIs0YVuou/GKa3vItdr54RuWy7N4z/cmT3NaAmvk5Y+5VJntiFQ
QvJt80rrI2W8OoJfZHDQ9Me0J5k77LF2ZmYDWjvx8k/Q5cJFxa2VA97iFNqNEh8x
Cl0+Is0hOz4gschSduuoU3Zs5/RX61XCNxHqKgz1x3zZoK8NUVK2N7T92aOWufPf
6Y+lp78T
=ZXfG
-----END PGP SIGNATURE-----

tag v32.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:45 2023 +0200

rdma-core-32.10:

Updates from version 32.9
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBUfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEgbB/4tpw8IYH+gQKhu
l5hv2MY139YsAJkUl9BjFqEOMfW4j8sZb1+eXddxLYnVOB2xABsps2O9hqDkw4Qm
0j+r9N/GA0jYiifqiRCr7m0gLHll6C/sEz4IfAby9uON4U3mpFkS9dMRpPXstk4X
L/tTT/IQo/OhGYPy4EVBX2lHDurcQ6VEkflJmMLCMQkt6pI6jCF8EWCf/8jMjljq
kLF2FfRtfM4S4QdzXZM6uRzODR0mBqg0xmYmzKQSTVJ9DxVuKLbW1Nm9sab7XCaS
SQjnxc7UfvbtB/5yd7+oBsSYkl217UkeGpsntgTynfQey873KrjkE8JLyIt5yVW9
VoP1G79F
=f9Yc
-----END PGP SIGNATURE-----

tag v33.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:46 2023 +0200

rdma-core-33.10:

Updates from version 33.9
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBYfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJ1CB/9D+KDEIvGsBNUj
kaUfkplfRTkbOEu177qCnY4yoYVc06Omh+u8SiQg2y22AovZOXvRTB5PTuUCb64P
UXS8S5hs5amIivhntwL5dSS1Wz377uNZC0RKBO69NGG9Mpx2t6exuqJe7LUGYlJh
4ogUSM790TRkELz+KmOe5Ou3eZIj4OGbFxHe8Pu7DLphWqMQ9kHfijN4qEN8pceX
BSgBcmgozrp1dS0zb3TzWHfE9EbBxVEu/VtSYZ/72VhX+PxJu5zb6XrwQ9pf1GH7
VnyLlRfIuQfND3EHSpQ6mKO/hXLfV/ua4XdSxbUx+F6QbByA+X4vhAsK31W2s8aH
SysAUnuY
=zjfM
-----END PGP SIGNATURE-----

tag v34.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:47 2023 +0200

rdma-core-34.9:

Updates from version 34.8
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBcfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJFmCACC97DIUXnuTPUm
laoXHzg4Z7WdbP71RNSQgdbjo8GXnanUll2MZEw5VT1tUQnL+aUBoPekFjkGdt+t
94fTKbxhcvEUt5n7KM0sN+K4yregIs3vtp/mum2jtOg4+laSFKHThPt84XhUAfD1
v8q/KtGaQGhx7tSrYOtMZcQILm5xcx5BgHCa9I5PPOnBHBa0GjmOT7uD6BprY0wq
znY0IcbrkvyrLOjtRlsVnqRxzud6rz3EvyrJyyubBSsyJ84MHsOYgfmC4JP7Ib9U
kM1LR0VYyGcnqiMkuHew6pDfBcb5f9hpZAHouNZZoFOQQpgNyEhADlgOB932Q4qm
AvkbJ2Ix
=sBjM
-----END PGP SIGNATURE-----

tag v35.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:48 2023 +0200

rdma-core-35.8:

Updates from version 35.7
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMFzB/4kDnUeY1C7B4Xs
ZTHwQXZcDWNKtgTbdulJWFCPv3iP/GVclVBs5yyg6iF2QKD7auV4SrrvR5FEU6Ua
7lOffCp9ci1QJJO3VjrtAdD3+3swlA4hsLJ0AoNIs+Xyow4woLx3/2x1LEG98QUL
kFC1R4VwFFlK6NRGw7CH4j9i4V+PZ9z2reyJzwVsEpEZFbv2frwgnRqfRXBjz32e
kHBaOkTgI/IUFNqVQx9GY3bpXmWGBwjucU/Q6omotwbCeQrhXHvmnVLCNvgm5k1r
IEsYSpINlthPsWjnkL603VxycijMMDcvrZoGjB4BGrO67ocLuR9aObAdyFK9eqx/
MJGvAv84
=F+7C
-----END PGP SIGNATURE-----

tag v36.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:48 2023 +0200

rdma-core-36.8:

Updates from version 36.7
 * Backport fixes:
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZIBoB/0Z/NwHBgVGcDue
PjZvuN/x2h3/8A3Wkug1cIIpO13MQNzDlgbfSoJU4752f+N+6G8hE2P6zJAYZgtD
RteLQViFOTpmFVIGQ6BIqz53/Qw7umytiMAIgg1h4yMSmcd5QoSeZoWfRt83NLA1
am7EYTscqPvM3E9/xovE2aJEK4LqKcuzauhAep+ZQZcbvOOV8WpHXqsR/ptS3gNi
V8qkWr77fvDNAB5BGjSb8u7XmoDWWnpR5BkRshT6rAjRzVxffui+0bM+hjh+oY5w
7mRSvJvUs/h8OpXmOY7A2FFVYDhpUwyFyA2N2t2Td7ssUlae/8mEZltlGGG3LR8L
SDfPyaMS
=DzDH
-----END PGP SIGNATURE-----

tag v37.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:49 2023 +0200

rdma-core-37.7:

Updates from version 37.6
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBkfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZF4IB/4rk4E1I8zwlzkc
tJnZuFepFyHDqbzSXsm8md1DNNdDRgxNJmW9JQM59ObUXhqSItItodDjwr0gQQ8A
hvLerBXIXAVSfes3YGRTB3sY9HYHD8r7st+YjBQwy3+JCw90GRts/dHiSYktPGWs
CcGFUBzLrYmYO4XbyDhtoq097lU4qlOdpfpixaW+MHxfpNdB4+PK4qRBmgosXuJz
L4CXPea4ALJkTrcuTlu7D/1uMWnFeyHOdGssCuRHJ7u4tEB2S37XjOApo6YBY4YF
Xm/iq5bWePjmC7uTrsiO8y4Qkk1EB6hBhRzKwKtYZMMWPQ0OrZZcMJpwas+8EagX
6K12RVXu
=DpVp
-----END PGP SIGNATURE-----

tag v38.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:50 2023 +0200

rdma-core-38.6:

Updates from version 38.5
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBofHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMFmB/9xoUfi00Yd9xgm
PwbvHMO2bnc6Jdua4TvUMxLXhLd3Qm2ZaH5IjcOf6iEptOavm8E/s84iBU+5OnU6
vaLLkZ9mXHMXrLWGjpgWKswyXm93qM7qRUDZ3pjwFl75k90FIVNa3TWlby9ddxk2
AqRQUmyJZEY1L3JU3Bvl3/xP9OMFVVQ6Y71vbLry4+HPXwdtFYSw136IIRnQxwwl
mSZA2wQZGQImdoCI65aGJwSSY41rTBu9vGS4bAWJgJVCOuXAZ4OAjdP2sUu9Dhdo
6z8JpsEy3dY6hG2A97PUrKhsObAqQzUzk4snFREUM6asvwlWsZLFEN2rK2kxfKcg
xk3tohCl
=nMmz
-----END PGP SIGNATURE-----

tag v39.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:51 2023 +0200

rdma-core-39.5:

Updates from version 39.4
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBsfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZIXWB/wIQlXjWRBIZGUQ
hNY1oL5Dv06FqX85ZI4ZRNdESUQJwdJMJdnM6jRi9VjMV0hQcSiIRRK5wPRAIH6O
v1xh/oT/pulWwZwy24L13AB+lEbBCbIMHQgFLFijGxqV8zYm/nZB2EI+DOF/7Rpm
2RMxBCKn2QviIGnXyWJi648OSIIYX23uy6Jp+oEgvsF4Q4BD/Rh5hjQjMfpKhR8W
A7ZKHEPg+H6fw02akNkF7e8+SME49AJarA+rPxdM9Y6Oo5htcabCFeiJU+xI47aA
JHspNul7+4SoN6A2neb/W3VWpYYXcL4Ih+nHXC2NY0k4Z9erECzclm8CJ2X1PnOb
yNnKH4DX
=LbRj
-----END PGP SIGNATURE-----

tag v40.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:52 2023 +0200

rdma-core-40.4:

Updates from version 40.3
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix the owner bit error of sq in new io
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SBwfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZOm4B/9br2O6bKbFpXDT
lQMcv3Jg4Px8YiIhlMv/UX42eFcy058ZKtIBhe8NIuGtoLhmQa+n2JgtXFNO/U8H
d3fUwwSVSSMKQK+NAO+dd2+wY3nl7lqKum6tHuKdHrRTHDgB9onPaLYFZ6ffOJOy
pAJedkvWWTVWgu4/9Xpg48kHyvsMDNyq0Q322MS2cq75DOFs3iZQOVM9b8fEGEXn
NfZrR54TCwQekJPzotu95nWHt6xH3gPgJu7rdpQM4Q3McWbpO+qxSJRHcTstqKMx
CddsMxDJlrCwl3KmrJEBC/Tw3CGDS0QY+MHVdZviqyleWCWJ5FBoifXuPUiLb0aQ
HKFJCDMQ
=43AG
-----END PGP SIGNATURE-----

tag v41.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:53 2023 +0200

rdma-core-41.4:

Updates from version 41.3
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix the owner bit error of sq in new io
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SB0fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEVkB/9MziZb5IgUn2NS
tgYWW3HP2Z/nOfregRsfvN75fF5VOHRpT7pdT5j1raSC1tto917OCx9/1SlM6ai0
Ib8aOCSL03b8Oe4kMtzRuROjak5wVHx53PdmdBWgAu/UStU+lZLYALdxtGM8usRv
BrZiSt+h2hq0UP2+gUOryCvfebCKAYecaNOfs/a9RibE5uH32Ol4EBuF40L1yawq
WVJ37Cz83W2arf8B2irV4NWadbUdMd9VuwNbbTSybHriTf04aGWirSTcZ9BRbfq6
t6XnkPXghbxb6RIRtUqU43UW3DireYmFTuZ+s0yDYTTBte1S0NK7O1qQdgOi0DU7
/jQrHBf4
=J27o
-----END PGP SIGNATURE-----

tag v42.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:54 2023 +0200

rdma-core-42.4:

Updates from version 42.3
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix the owner bit error of sq in new io
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SB4fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJ9YB/9KdBvlqGfdQR1g
PFeMxGz5z3x+CUgKgvQtU5Zx+C8UDmPX3xcdhT9L0U+SAY8c83StDGTndToyRlKi
LVpZe+eULdmbgf/9lom7EoYGsWtlGMz184Wnvg54VpUophki+GvGzpsOWLueEdxh
Yb28X+GKyzIkhLIUi69EscTBVQwG1hK9O4f2Mg6QHVAR0EyFB4UvJ5JvXR/fjRsI
sZF6PAdshwY3vMKDsVFYwTkvCJ9774uPJa/7HDoLfcdYQ8K2Vm6tpC3VhtpA8oQg
Hfti5wXxNZuaby+k83h5scqg9T1kmUSePbKo7E6D7hEi1PEhRNewsOqZR218fYWS
06khyRD9
=BAER
-----END PGP SIGNATURE-----

tag v43.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:55 2023 +0200

rdma-core-43.3:

Updates from version 43.2
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix the owner bit error of sq in new io
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SB8fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMY4CAC7SCtDM4m4Trju
pRLW6yPhnws0/iVfoUS7DAEONTnVT6T67lAEtIziOBiHpcSLb2LqFPOgvWfm7VeD
WMEAGVFbZwfo7cXQIzq3NNh9dr/DlVSll0A/eUAs6WzYiQQgq2vU4kHFrYYTWDqP
+g8jH2KphYMM1zTvcpZzeQVQUFiJ2erKEklg1lrvkDJRMl5caWNHmFTgYEVEbddd
k2djkBID5/7XcAh0M+fG6VneoifiwpRpkoqh+sC5bmp+RNiSxufp3IV4zyQC00E3
IXLSVEzhjohgTqticIpxFHt7IZesnq3osV5bUzhPzLs+m5rjJtlFyRczwMGe2jDi
oRqLl8N2
=aXiU
-----END PGP SIGNATURE-----

tag v44.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:56 2023 +0200

rdma-core-44.3:

Updates from version 44.2
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix the owner bit error of sq in new io
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SCAfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKfGCACnJXN9sqb4+D3c
Mv3ldUW3inXzWexsoozXU7/XS0tXuB9hOFnNGbxT1uvfCCGv+tDtg37DK+1zQYYY
ibYuaQm37S6a0glDeKpSfc9qzIju06Wb7u7M6jDhvVLlLcafGYdP6FZ+Mg0Po8nU
iN0lr1dmq7lK11d/c4JFrrnr01cH+gHB0NlJ+Putd/VkthP4dHx7xkIOXT0UPdKW
K5WZ3c8lgMYMamXbr6pPkirsbWZQ0dSZFkbOaoX2Mfhci/TdJfHxPQujVvqtaCjO
rsCo+EZiuXhM6HLoRPQnHYGoKe15LKPLAqKysvvVTJWXfYpN5/gh8kU7n8FIrDUm
llufG309
=jISG
-----END PGP SIGNATURE-----

tag v45.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:57 2023 +0200

rdma-core-45.2:

Updates from version 45.1
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix the owner bit error of sq in new io
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SCEfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKSEB/9wDJsNXPo2U6Cr
qP/3wU5E2pRwyvX+bAx/0WlyHRFb7Z6Uob9gHxnFhAe7kSKaXc3RqtQwYkbtVBNa
opSvgqc9pFh+ChwuFfQlwL0JZhkivfdWqPiQw1GC0ewrJIfg4jcShekL1im54VDy
8gMj1ViI8T6V3gJ8ZNbPpo6xqBxVl1xGFHovJYvrEv+t9/HEPIAp/bqwB61agzMw
+S0M90+ifACXPwySdwXDrwQixDj8wKvhXMsb4/cL/ggBlpZJB1N94mvTSR6O5fdA
HfTs36USSqm4UntmvNqE9H00YWgrhGFZJOUhCV4tF1A4f9t9ebEM3OF/tYlh68rM
lo02FVFh
=u6Lm
-----END PGP SIGNATURE-----

tag v46.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Jul 18 10:06:58 2023 +0200

rdma-core-46.1:

Updates from version 46.0
 * Backport fixes:
   * providers/irdma: Fix CQ size validation
   * libibverbs: Fix ibv_devinfo help message
   * Fixed typo in ibv_alloc_parent_domain.3
   * verbs: fix compilation warning with C++20
   * libhns: Fix the owner bit error of sq in new io
   * libhns: Fix incorrect post-send with direct wqe of wr-list
   * bnxt_re/lib: Fix fetch and add verification failure
   * buildlib: azure: fix changelog generation for releases
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * pyverbs: Remove include of bits/mman-linux.h
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmS2SCIfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZFDbB/4ibsBiV7pEq6+L
nE0UupHM0TOwz9hKeQ6NQtbr2yRG/zQkKl9UPwRtNs8kh5JIS9ItTVNxZN/LlHT3
eW2vg6MRf8n8w1Lxglicq/aCCsEQqcDlu9XpBlQdFSiRBlVTkLs08IO/bqtvSM4d
DObN/yqkh1yTtWWTLLaMmSqxG/c4DuQViIg1nWWMrLa3RUUP34fnwc0BUPElmZlW
Bn8aduYuGiF2U6a5fqqFP6kMHePWwWbPLZArGqEXgKHCQm8e6E9LdbFcOS0Go5Jb
kc+oWxBdwOd0hMZnA4k/Tnk1wy92EgQ5LSMnWWd6xpYuQEaY6xTaxeP/jCtvmF8c
EzwH3BOu
=bOwE
-----END PGP SIGNATURE-----

