Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815D872992C
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbjFIMLQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbjFIMLJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 08:11:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AD3AB2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 05:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs0FoihvR0cjM4vnq2cjV1RpWXSAV52aCbUHyShY1N0aYuA3gpMNWQG7p7ZiK3oymKgjkW5Oma1PkpUh74LNhWvKW9VBO5TzyJzG2Jzh+uRfyRvh1HXKg8LDdb5lWPQx8KRygjLhgUqMywiKNHSyRe3d++EKvXUNHTmED40PBGo3X/O4tKf6GMToyznuBl3N34dRSSiomFGNj3uXrJr/EerS1s21YvDHn8vKPg+M0wlNNCHmnL2lBA+9ZZuOrLeaPsMe2nPxMZaB1NARnUXkrHcWqIvu9pEYy09NbIWiopfCVrJ1/UxDBwngicZmrkAYP/E0HZP0/9qkkAGUH5P9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehbsy19ks6Dju2/W31npWW5u+kREZhh0Nn1zh5Kt7DU=;
 b=OxuXgfvKmviJxWmyDEPTYbueQTC9BN04WVEnh6U7OjjcT9RoOnHr2MV/WRoF8gwE2YezxbZfXElfmv7suGpxlnyaz6ljy63oXXUjhRxF1tzs1mCMykKRsdC8MSPRhc7IVNZz4oP1xRUUmx1c4MTbvU6t0C4VOHWQqK64fj4M5j2Ea0XgWmo3vGlQe8b2tcuKq3YF/r8EDYrewhWBcxPAIFpAyHhUkTgOgIL2IYdOI1jShxQxR+D7n5smlncudV7ii6g27o4vWfkB2Z5x6EGQbXDVgMaUx4Ajk6Od5KApD/FYN2BK7nLP3xbrNZ4Xh/mG0lLrhHTpgWe+WojI6scKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehbsy19ks6Dju2/W31npWW5u+kREZhh0Nn1zh5Kt7DU=;
 b=XkK7fQ6ekwFR3iioXozE/UrKrdaUGTKBTPUhb3gS1rDmNhdNHnuA/Fh+baVNWcSN0lu/0DTnmHaWGRUibFKiFV1OPmGI67KGxL+W5ciG/GO5DaFsqgBRWytLX8TbGXSxJwpi0OGVmzBUnD0Zm4NbwdWrX320uY7DrWZTBzYJq6ZFKZkdcNat4ttfepgWMGRWTECXx6J2eYVhR64DsDjJSuJLazfKKCp2UnYJOf633gHw7yKcQmESfYVfDyXLw5NYHpTmY8sBprR0UVvePmIeFebMkTBiHTZxYWzYd8lZtkiBr/fcC/dcyrsZvRPH7aqFlYaoUcTh1LYfgiOCEU8VYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com (2603:10a6:7:1c::23) by
 VE1PR04MB7357.eurprd04.prod.outlook.com (2603:10a6:800:1ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 12:10:44 +0000
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::bf77:7f01:b0e0:55f4]) by HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::bf77:7f01:b0e0:55f4%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 12:10:44 +0000
Message-ID: <82fd6801-722e-a21a-fafd-33f3deecf5d6@suse.com>
Date:   Fri, 9 Jun 2023 14:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Nicolas Morey <nmorey@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     linux-rdma@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0184.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::6) To HE1PR04MB2969.eurprd04.prod.outlook.com
 (2603:10a6:7:1c::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB2969:EE_|VE1PR04MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e812249-a216-4b35-cc71-08db68e28ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arRFi9FLjzNCmH0FA99HCGiNxCErZSjtKuocedP0jdqIvKCDMTMLub0xerMHjpHRKfBoG5mKELmYHlva5yk9CX8sIdLMffnosSOixJU3SPdpvrAVBQ48Fh75H0r5k4ehPsMw8H2uQt/Tp9EHEgwG2c08c8XMsZK8Rc2xzFcrUFTMECsnkCM+9VxiUsweoD8DvGDZhIUPzKyOV7tuzlt9dQdVC3G/O2Fk2ZX+ymjasT8Y/c2SXh6DWUV4xMrqxVO/YhlaZdj87mhraTdClP0iAVIHdyBLdF6p101lCxX3UoSyfv+lHJpznyXsiApHA7AZLqzmixR5807P4zYuqS09aKQbRgpgH3sqoqnp35SOFxDTNdaQ+l81Fr1YLKcO1E8FovZK0qXG0oba0m5LZMRBt8o29s/Wv7R8obAWGV05u3deY+BgKC1+I3qPHtCmS779iawrU/PhNmvHkGqXmusU3XQRxwJpap20BLttwQnn1J70xSKmJPvEA7wfwrPcqQsVlImxBUvsBWntmsU+KKRIHyRsWXuMKrk8347HLoua0l4JZ2v2Czq2z1acp+XfekCQuZbvP3ORNLgaaNCLPtU2sDrTgPMgbwZGqviFRMFh60TkrRorq6LzadYHiO3u+54PrzdW6n5256+HlgEPPEXt9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2969.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39850400004)(136003)(366004)(376002)(346002)(451199021)(478600001)(8676002)(2906002)(8936002)(5660300002)(31696002)(36756003)(30864003)(6916009)(66556008)(66476007)(66946007)(316002)(6506007)(41300700001)(2616005)(38100700002)(45954011)(6512007)(26005)(966005)(83380400001)(6486002)(31686004)(186003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNSZmI5Y1NnTmlnNW1sOEVzdm8vZktuUFhJVEhqVk5MazBuY1FyTUJKRjZx?=
 =?utf-8?B?eTlRZWcwUmJFMGRmSi9SK1pvU3BKOW5MZmhtWGhkd1pmR25EZ1pyNHVtOVpH?=
 =?utf-8?B?YjNKKzlUUS94aW40VEZzOXNCUUtpV29tZWRNS29LTmpGTXY0a1VMV1B0emJY?=
 =?utf-8?B?VDN2dUU4eURSZnlKR3lJaXlVQitsOUdNdUZBTHBIdGxJLzNxKzBvRGZxcFNT?=
 =?utf-8?B?cWMydnJPRUY2cmxIVEUzQlhibSt1NFFxY1NrZ3doWGVoVGU0bitUV2MvQ2g4?=
 =?utf-8?B?b1JZdCtYYmZrTmxSUHQxd0psbTlZeENXdUFxMFNDdUpPM3phK011QVlvakRG?=
 =?utf-8?B?elJNTXBNN3p2clVtTlV6Y0dQekxpcjh6cXBEb0FkblVuY0JpS09Tdkxudkps?=
 =?utf-8?B?cmQvWHlZWEhRUTNzN1BQVHhrNHJnQ3laWjBjQVRIcjRBcUt3VDAyaGpwMUxO?=
 =?utf-8?B?L0pkMllFNExvVmVUVG96M1I1aGV3d2h3MlBmODlEVWM1a0lHekUwS1MwQ3Mx?=
 =?utf-8?B?cjhzSGs1amhHVTV4UlNpTHZvMW9vaGhJYksxWG8yOFA2dG95U0NWR0k5Q2kz?=
 =?utf-8?B?ZXFydmFTTUJTQVhka1c3a2xqQjZ2VUNJMmRIMTB4aFFqb3BxcTNTQTFuN2Fv?=
 =?utf-8?B?ckJDTWFPb1F3cTM5VWIxSmhxeE9kM1BkY3U1V1d2VHBsQzQ1b0RhbjNkWWFT?=
 =?utf-8?B?dTFrcUdhTW9BSDd3b1NoTy9PaVBtUGpXU3NoME9XWGkzdExXamw2b3BLSCta?=
 =?utf-8?B?aTJDbTNVOHZMeHZRdDdsYWZwN1Mxc1p2RGE0aTFVeW0rTmxsR1pVOHQ2ZXA2?=
 =?utf-8?B?M3lGMDUyU1RlUVNpMFh3TkRxSk01SmxBTmhNa3JVdzA4c1dLYWt0ZHh2OHBP?=
 =?utf-8?B?TDkwazFzemkrNHZiUkFuTnBKL0kvQ1A4WG9zNTkrQWZvOTR3Wk55Sy9yYktK?=
 =?utf-8?B?c21waHpaQjRzZlFXSUMzNWNjS1hTTTlScnVuVENrb2lBaWtYd1QxQTdFSkFN?=
 =?utf-8?B?U29qeklDQ1FEUVNJSzliSDA0blpCaEU1eDRNMGZ0TTFyZFpBeWhGbHVoTVZE?=
 =?utf-8?B?VXhjeW9DYzZYNU1LZk5rSmluY2dZQm9IYjVINTZSMFYvUnUzRmRlZjZNc091?=
 =?utf-8?B?aDZOczJLUXZKYktmbzBzY2lIMzhORGtCUk1XY2UzZml0Vy9MU3B5bDl3RUFp?=
 =?utf-8?B?azAvTGVCMlFTMWkvc1BweHFjZjFDcmFqMzQ2WTIyenQrekY4alE0aHhmekRX?=
 =?utf-8?B?Q2loYy9aOGhJNk4xSkhGL2xPUFNoM3Fjbkk0WGxleTBZNVJ3WTZOSEFxTXY3?=
 =?utf-8?B?aVdvbEFNTGJrdnMrSGd6cmIvMEMrL1VMMURwL2REeVlobFdRTll3UVNZc1Zw?=
 =?utf-8?B?ZiswbndRSHVOU25RUVpNWU1MOVp3YlUvUWVOcWtCNk9pSVMvZkF4dFhOaDFh?=
 =?utf-8?B?TEs2aFVaOURPUm50R3VwTjlNd1dhblVuNHh1TXB2SmxtOUhJRFVoay9BczJ5?=
 =?utf-8?B?WmVFMVNtRzR6ODhRTk11dy83c3dCUWxoUURCcEEvblFTdGJ0UFZEd0JFbTN5?=
 =?utf-8?B?d3REYnJVK3kxTzZUaXZBT0VNakhsOTcxYnZtZWhERVc1SUVHTHdFNnVabjJh?=
 =?utf-8?B?NTU0bGh0NWJIcjZNblFLdVVSdkZxZG0ya1o0YTZKYmltT29IN3ErRlg0YjU0?=
 =?utf-8?B?TlliUTRjSFVHQ3QwUXd1QVpteklNazhsVElVS1BTS3FBWVpJL0wzaHhYVGk0?=
 =?utf-8?B?akQ1RTR4QkZwMU1qQTdDSnI5WHN0eVBjWDFRZSt0U2JneGNyb0pFTTlpZ056?=
 =?utf-8?B?WW9lSE1UOWNGVmQrZm00emwraTNicWNaZWlpclIrNEpiR3VCd2pyQzBva2R0?=
 =?utf-8?B?RkFuS2tPZ1NsMVVIRW1Wa1lJdHA2MGZPb2hHTThiUVFOTHJsMlVEazkzc3ov?=
 =?utf-8?B?Z2NCTDhBRFZXN0l5NkhDTW51TWUvZlpHS1VrcVBlbE45U0VPM09nd1hXQ0hI?=
 =?utf-8?B?a3hmeDBCT001cXFtQWphc3Z4cFROQXNYajlJWUhMbSs3WFhkZm9PVUxxK3R6?=
 =?utf-8?B?TjE0VUVBZXJwbU03T3JydHFCWVZYUVpidkZnbVNBV0xiQWtaWGhocDVxQko0?=
 =?utf-8?Q?GhjAmJqv44hfwxwvbtYKu30dh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e812249-a216-4b35-cc71-08db68e28ce4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 12:10:44.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57DAC6djsmSKWm/mfzj1k1EdMMVMHuRgEJfrj/Eryhls7+VBDFdmoXxt9SkHVoiwab7JAJgUZEThcxMHEGT6ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7357
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

*** IMPORTANT: Due to their age and the lack of significant patches, branches v26-v27 have been retired. ***

These version were tagged/released:
 * v26.11
 * v27.10
 * v28.10
 * v29.9
 * v30.9
 * v31.10
 * v32.9
 * v33.9
 * v34.8
 * v35.7
 * v36.7
 * v37.6
 * v38.5
 * v39.4
 * v40.3
 * v41.3
 * v42.3
 * v43.2
 * v44.2
 * v45.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v26.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:03 2023 +0200

rdma-core-26.11:

Updates from version 26.10
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kMfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJDbCACvQXziPEXf0aG1
T/lzErt7VXqaPahijg6zdOWLB5TJC0lvMSjCo+lpdG/CFAJsrAS3lBXEsAI7Zb80
IQ3oteLovEWNVEzRgFh4BAKWykmf/bq1pRUusLP454JR+K286z+4jJ3YF6joNI7v
5ccgeiDiV9My/xuTqQggwXu7auXyicm+77EenjimVwYrP6Tq7aS5/DTTfRj+EDwP
96TNyomjbyvqYsOkzsq8LkCSXYOyAbMsYevv1lZtvELQyhXA/hJFde8iB2mUYMFE
IIv7ELFOUdTkOedu8zgbT7qHQZ/oyoemM8jnhc1VPYWZbshONZsJD+9dz4VTu+Ie
muvHtpt7
=Ufvg
-----END PGP SIGNATURE-----

tag v27.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:04 2023 +0200

rdma-core-27.10:

Updates from version 27.9
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kQfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEtwB/9aq1voDENns8N5
loWY83SErfwBBAqCoraHC5b5bE5YwSgap60iWjj0/f9a3DV0PYoqZdaG1xMDZw5b
vIIFmwimP3ZXaGyJOOxezPqrlSYjxayINFWPxQPIfsUTtbVhQqxsuqUd1uTDkj9c
gvYuc1dMSfGtSn86HV4ALjbqG1qXIxgwP+Ej+5a3kpE+eAdpTxwYKueYkvD/9GBe
mB4qnD0G1bnkj3VblDiOCLBfKrASFcVldp56557pN0+5y7lljBq9j4iWgWJ1QTN0
QoJRB1UaJxeGJ/EGkGW08m6OemPJhSV+f5HSd2uZA8BE6jLNftnpEDXwaFI2L5iU
5u6rj3dD
=MkJu
-----END PGP SIGNATURE-----

tag v28.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:04 2023 +0200

rdma-core-28.10:

Updates from version 28.9
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kQfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKesB/4x4Y9X7b8J2D8h
LVIKwT5TEKpEl9Uj/WRe0z+EOEIlco5SbyZnMUBtwh2YDwMtPKJ+GP79VEg6/7vN
/dh43AZUREhYyCHlIne9Dkbpet7RMnpXKABVZaAtDb6hYZEDDengZDU7bjHqrIwi
xefM0g8H9SCAH4K6L39NLhhEeE4hHAFhlTMAjdNHu6F1gYhZuqdrRQGTdAg99lsW
8B1jcYPROxEGYVi0lcHuQbtB+A5qdbuHqw+xsH8u0UucV9dVwGr0jtPySsNjIxHf
yYODM33Ycrt2DyOCMMHhEedrNfj05Ln6pANqyEmiRHh3lfUTlLD6YCKbsVtBG9pL
9IwkEmni
=jxQ7
-----END PGP SIGNATURE-----

tag v29.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:04 2023 +0200

rdma-core-29.9:

Updates from version 29.8
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kQfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZAgFB/9Q/Vdp+oMHWp8D
KzIqbNUUT2O7vfgk1gOF8Q4Z1qgu/fDhcpE4hRUa8VLQNYtVFLz4wgwvlMy9lZ9x
cdra8Iu6GDGeiDzjzoSBy4DzYRfmZcXe+wVO/E+isPHXgto04n5LkJfrajYQKW3Z
Orvfq3Yi7v43f33dpKSEMUY1LooljZ17vlZarX+mwX9PkQOoXR9MMaPRCH+Xj4WT
v9wSmp2vQeCnZTUrkkn1JDKtLqUuo17kwCky8VJWnX/Q2328vA50Wzpj4F+/9K3r
q/KeBYtAoj+U4NmXd4XYK6PAkNPrgjg949cif3ehz3WGpoEAvjKthW6yY04fjeUw
tIcV29v6
=LlI9
-----END PGP SIGNATURE-----

tag v30.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:05 2023 +0200

rdma-core-30.9:

Updates from version 30.8
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kUfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZNcSB/sEd64aunfJtWL4
N0LccfpFBidXa/N/7Nx21dZDqBdrRFJVI751gGdpBpz2efo48hWOLPVgLailqotz
BdNRWj4jQcq9pYXGUjHwOSIEQw9TZJvt7DkWt3DjbJwS5sc/R/xaIxxHtCUzvSQN
b5ML52Qam6WRPhMQwo7D9dz6ONRJyz/GuhR/yu/34g3fJsIGCj6s9US5M7tajlL+
KcyQ5dp6hJdkxqOV5tbV+0aTJmnY5kD1/AykjIsPCUUMXCHfDhCGAS4VCZNRsaAQ
iS8CPd6Badri17qAlzu8BIQSZt5pAEyeA6A5TD7Is9bm4XndQuMZFXWb7UxRHsJR
M+RURsdi
=M2Bg
-----END PGP SIGNATURE-----

tag v31.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:05 2023 +0200

rdma-core-31.10:

Updates from version 31.9
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kUfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZFAPB/4ttJM4e6XQJYrw
7/lS1NAVmd9STciO5QBZ4lAjSDxzxJniGw64kNbMwDorVoHgshGqiBhgyxf9l0vG
J52Wb4qTbRUMjHOsUrb4PGr1UiLP97bH4obBGJC8Rp7SaQmWB5EhQbK8df3llsTL
4F50J2jIZ0Wcht9EMobd7Tb7qTbRQ/ZNKMX78yKZHo994dTEz6gf3slUBxhB4j9t
OltJgqvEDjIZozuPA9UO9e/j0mfqdWVj7tP0YiKf0juvniOlc2IM1Cgj+7pIjAc3
xm9BsTaTCn8x8reMGPxn6lwSJjkAZm/UCZDtAh5/wROM4MlyD0bj/SDRVdFgCwFG
mHVZAq5P
=pT/a
-----END PGP SIGNATURE-----

tag v32.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:05 2023 +0200

rdma-core-32.9:

Updates from version 32.8
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kUfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZCBEB/43leQ8bZWZS4wA
GKjfQLVZcYFV4fPp6DPA43i3Oo/8Xwuamj3QFiwBHVOo8vSw8oT+Zyz3CXjYbmIL
x8RbjLKITWYoUHvmUBCOp7MbB/DYFyL56y3kNMVbKHu7o7tLMyyR+SWa40CN9UAY
c8C1Wr1miGnCP0EzSm0ogeg+FswgFbFWU8oVii/Xo7fJyY9adG9bsbLzz29X/HXv
fOAxHuVnflO37hRN4ecDhvYkk7Uco9Thr5owqF/7mAwnJzUQu7pf7ggMlALYyfFp
tq2YjgTMCp0omEAKMK1JSFMf4UDdQ+owB1xuk2/HcBw2grXPLT8orq+nF4Lf+891
b7NF1mfT
=hr03
-----END PGP SIGNATURE-----

tag v33.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:05 2023 +0200

rdma-core-33.9:

Updates from version 33.8
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kUfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMD1CADBYo1kKJ3tjzFw
q7T/r7MoPJuo2PXsrD7JZCZkPNJrxUvDqePYcrH4x9gxnd8O4kQnV4HtbvCDUTF9
Y1uuk/BzFjOyprk/lXy1nvpFVFQkmxnR1K+XZGrdWX92ADvxaD1yfV6L/Cr9preD
6neZtKzzFl2TSxDilF173rFaEL781zwCiBBxmbKXRCQIrxhHHsOkwH6DFeAer5aJ
Itd1/TNjDVq2hz2dtALUAPcRo40L2KYbOV47NDZgBv1LVY7zG7iCB5br6/tH57Nz
ab+aigG/r36qQSOzP86cr4JdepBwaW7xyEBIQOG+5zzGDVZXvmBgFza8UVO1q2lf
1BQYxtUB
=/TUs
-----END PGP SIGNATURE-----

tag v34.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:06 2023 +0200

rdma-core-34.8:

Updates from version 34.7
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kYfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZBTXCADB4s33U+boDFuB
hg5yZC6HyZV9x/rT01++LUt8Oplk3KcMbLkOGtehvslqPQXuWfQ1eEZikXrhP9B3
37gr4pA/ZnJZnRjdfzZWLfgjQEgZ4oSr6PQAgdGg2gheQxo+dYSWMrouUfuIpKiX
nlsHLW4DZkgCqsMGla2zXcT4oh7v3F6ecEyxr0tUxOrCr+c/OVb26f7x3tXP7S9i
trDrQYVRjJiRzOhPCh+TfF4aneP2QoYX0I9kUGbjI5wUwhNk/2Urtv2t7V6Plsqr
V/K3nEi1chUQ/ZMYl7MxZ9M3VzCqX2Cw9EC3XxTFaRdcFAKd9yyWx4prNm8RMupv
nRTitzsL
=NBuZ
-----END PGP SIGNATURE-----

tag v35.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:06 2023 +0200

rdma-core-35.7:

Updates from version 35.6
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kYfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKz2CACahidc3TVdYV+g
t8xa791mBs+Z4lSORu3Rx+GQU8QNO8xMa7IfYRqlr3ZUD8TMqSONa3LQZ/kxwKFa
aPZjx0DofgDllU9v9atpyH9QMIR+RMPRAk8iN8cvmvNcYpl+gOfxsMzfZroxaUBW
QLY6EyQmYwKDpoaiyvwvmEVNqsOf/hbVoq5r59aRGlIRfgDk5b6iMVduVhUUXDZC
6wZh+d/Kjp5QkJOFD/Unid/sh+7JtXpp9M6GWPXQ60QK6e8GAtXtNeJQbkQAxVwW
pDEOgowQPC8jRclsPYPcLqVpV1shrnojRGnLVQ9R5C/3MhfeU0hUpJsGG8MlK169
4iuLqg0k
=JuU4
-----END PGP SIGNATURE-----

tag v36.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:06 2023 +0200

rdma-core-36.7:

Updates from version 36.6
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kYfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZCLNCAC5wlvLZE6Ycwll
F8GTpRQI5eX/vbwX7VT8UbepZV0cvavDWCs7OZgcVnFNsl4fqU0ozWVoyBia0ThN
qquom1SARVw4YOzAR/+GTwKXgC+mY1KHvhv+AUKmbOkXslJ53Le6vBV5y9RRRRJg
fcMCbY4ctp06RAg2LhBe2WsWOXcaQ5eyvXlaJIRyFu6nXYYX/uIqCpCqz5jloyAR
tTybD5fV30xuprLzywAV8dbcErupk0IYf3ElrUPlf8nh9vHUov7Ku7MWJzcImk9e
k4BdL6PrfJoyzb/9oyrlXFBO4alimnYYwGSmAhsukFizxAk7OyHwwQcYmV+BNb5A
U7kerM0e
=xmCn
-----END PGP SIGNATURE-----

tag v37.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:07 2023 +0200

rdma-core-37.6:

Updates from version 37.5
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kcfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZF7eB/wNE33lOJ0uDW+P
kKHfljbQn+On2mhfVq9A7VQvV/symsE1WFMjJAgLe30miXXyDgkxOShLsSwUtvcX
e6Un02nOSNpw0+LXOKGJNnZslzAIQTLuI+tSIu2Z3IHrKHuBPm8EBT3lWy5twmnb
kEnl6LbdxTnhL5dTlMx0UEp+ZGrR9fjBea7sBU8cd2sBOf95TZ8NFb3bHnNnGA7O
JpO4z9JmjOQszk7m1z8hkCErcouBQwZsw7rJsoZjqaG9sjdwJq9LphI061ydripy
3Tg52SymN1BI3ZTaL/Ykkgsj+JnZQdx1SlYvuQVhBliJumDl5hZDf4T22RkCoRoK
Uw6SQpEU
=FLbB
-----END PGP SIGNATURE-----

tag v38.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:07 2023 +0200

rdma-core-38.5:

Updates from version 38.4
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kcfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZOgRCADBjJBvzCBGEt2y
ADT12BKsJAOYfF/RJ7ifs+EZDQYZ+MWLNqpudqzc8TAQHgN1euIhR7/6Oj9dfMKG
V6ulJJk5JheuXL1y6sqGGzt2HPxGHx6INc50KUrRJl5ncJlVuIURn65cUN8tai+9
2sEzXecCj8DxErnI4BbrgP3f9SgU+F6o4k6Dhza9IZ5bCB0/8l5Vz1l9HhOvugUP
EyLqiWj/g4dy5GxsdSBjiDZZr6wF4RYGql2p8qB1z7FC5tt0yZflWIY9q3sVFEkV
w6/2/eiqEPRtq7MtByOgpuhcqt2xNiRiz2hk3wgD1aZfMhBxeeR183TRf8E9MjsF
pyOArlEE
=gtE+
-----END PGP SIGNATURE-----

tag v39.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:07 2023 +0200

rdma-core-39.4:

Updates from version 39.3
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kcfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMYBB/9Tq9CLCKqHNqU8
rm0sET4t6RqYbgtrg1x7hjPe2TEedS99S00g0KJ//ExF/JTeo28ZuhjmToVnH+XC
USzWEDK6wbjRiPUzPC6FSnHiX7b/v5+8qGhHky4bJCRirvh63/8DkJx7X0sRP0H9
9t0jne3Jyk6M0pH4c5GK6IU5TXFYB8D1p1JQcWlLUktz/lENGHWZbiIrI2r5KGsi
5/vBWl25O0Ch9L6Q8QI9wwhZ66KBtz/QrxDU4xaYfYJd9bGuOWMUBS0IfnndtnUS
nVusZwdQQh/VNtTU25V2Lm4UiJi5GrX5v8oTfBm36cJg93/FQ2c3dDr0GU12VSCr
Yvt41F6j
=JqTy
-----END PGP SIGNATURE-----

tag v40.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:07 2023 +0200

rdma-core-40.3:

Updates from version 40.2
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * libhns: Disable local invalidate operation
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix the sge num problem of atomic op
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kcfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZM0hCACd6bXGH3z9jD52
187Np+OdswYnNklAx7f8hqUS6Slk91jPt7MuUyLrgkV1WsI1xkvjXnnSm4KMnaD1
KziZCM3i9h4fMnbpXCW6XJ4A+DmSCP5FwKc5ws9tlaZ6CPHuZ9/r6JiQOAKSkcLC
DPOB8F8uE9/TGuYJ50Tcx9LBNcerufgdXBTpXHjjHM3tcLlIlLVHZYlQTGd7h4p1
wZ1c5ZEB34VzsoptXu6jekS3EITk+EcvteO14SBR1MDWa5z2ZuTOI17W/CpQ1wDg
uKPJZMwd9GqxNsBdbHhKhkbyxlrBFra7uojPCgcDcCLJTZZzJ4CjnAd4tLC+Hkp7
1q0m4S/S
=T//i
-----END PGP SIGNATURE-----

tag v41.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:08 2023 +0200

rdma-core-41.3:

Updates from version 41.2
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * libhns: Disable local invalidate operation
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix the sge num problem of atomic op
   * libhns: Fix the problem of sge nums
   * Update kernel headers
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZGVEB/4v1oiUdaB2ivDq
GD+cxmn3a/apiipjII4+7rtNs4ertjhubNsQmPhZHA7nq2NAXWC7xPm+Lsj+Cpi4
7FyBQBptjussNRwo1RrCgCif3vL8aq1Q5zfQLsJBtOyTAxirgl/OEqHBBMFM4O5G
XotcDBZcCShxt7Ghdj6Xn2Fo81kQ7NcW/WtXlysxyucvYn9g+BiiYBBmsXDFgHov
q4q6pAqPU9kGc9mzDK/YafL2mSYWALHe2pbqX6VMyqGqDeMCN1sgdDIWnRFht4Y4
xgtBmZhP9tzv+RBi1iUoLVwM4G92Yyx+pYqJrMlZ2NlLdN2l5yHw3qF6o2ckMx/y
d1GC49Fb
=EwYp
-----END PGP SIGNATURE-----

tag v42.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:08 2023 +0200

rdma-core-42.3:

Updates from version 42.2
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * libhns: Disable local invalidate operation
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix the sge num problem of atomic op
   * mlx5: DR, Fix error flow in creating modify header pattern
   * libhns: Fix the problem of sge nums
   * Update kernel headers
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZCL3B/9MIgV8OqhaS2ag
k1M2wPnT6N/e0VKaeJTY8Egjo8yfBR4s7IXwN15RH4DPLsz6ngjIcpJaJ9zaOfY7
thz2s6FMdiyF6dFaxc6eNYSOIUeqiZUIg4A/0RVO4zJHG8Z8BjmDtCkFH5o173ZS
Y82CR9TgAnvbW+KQ5pKp/cwjCp7keASzKFQyOs8InN4PqAvXeEKjvbbt/YrCcvj9
DPk6u4hul4UlzuaLSQCLDP7+z65BPXKK9wz5XlXpvE1j1vN59v95vqNBjCz4bAJ8
p0urlMby/a8e3Ixz1iw3QbdX0NGnWOVwQQ+aMJb815MMKDi7J/ctWxmhBRm6PWA6
K2P8I1Nx
=p8r7
-----END PGP SIGNATURE-----

tag v43.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:08 2023 +0200

rdma-core-43.2:

Updates from version 43.1
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * libhns: Disable local invalidate operation
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix the sge num problem of atomic op
   * mlx5: DR, Fix error flow in creating modify header pattern
   * libhns: Fix the problem of sge nums
   * Update kernel headers
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZIzoCAChdggFfwjDIToa
a4taGx3BOwOP3oJb/RqJi0IXQ4ANZSZIMlLTDq0BgyGByZsLw06caqsYI5xuVii9
341cRudwDZC5ihptEwGB8xsYgQsdhge3LH/Jsque1CvobKCwLCC93n8nMRJKThI9
dMWqGN8yzVTgK4dxmkfr3TJ97ZhimDdZCS0COFm0nnLFXrv6leA1gzNMgSuIAcsV
eJcB6f4/hvI+dRj1NQ2TEfItMqIuoD1CnWRgakaKCxcJKnYertv7kzrDgucx6q7l
Adiz9wo8IaUmHNMkCAVnjgNc/CfWY06IYQNdm7iiHO6x738+6Z4zcrhCDiSe5bOy
mbbQl/HK
=7GZI
-----END PGP SIGNATURE-----

tag v44.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:08 2023 +0200

rdma-core-44.2:

Updates from version 44.1
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * libhns: Disable local invalidate operation
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix the sge num problem of atomic op
   * suse: fix package name for libmana
   * mlx5: DR, Fix error flow in creating modify header pattern
   * debian: Exclude libmana.so from ibverbs-providers
   * libhns: Fix the problem of sge nums
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZC24B/9WU2vmxc4VeOSV
Xab4cLXqJO1OGgvyzkYeKJHzKK9/J3bmBAWO20SZhd9XBrlPl7grmxeSnJwRrX+2
sJ4i+zFvVHwQ65J8w798Ak8QabkribRR2jwvcEGpQ5qlUl/jKo2/zkyr9nmVeOYi
VQTZiRYHFhw067GObHlBeB/9aj/L6o+THa/EpcTBbvOrZXfL6pdxAORsyW8B3StE
2b5+cRE+hEu+ftAl4fEEYH4kKFx01mtDK92O0RYAZJUOlo5dS1Uvj2BhvJoF1s7R
m/zK4Se0BR3xXyGLs2/io+OpYncfpPw5D5ULEDIhDxECek2dDbMI5xUMJiXc4G+n
2s3XmANn
=151p
-----END PGP SIGNATURE-----

tag v45.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Fri Jun 9 11:52:09 2023 +0200

rdma-core-45.1:

Updates from version 45.0
 * Backport fixes:
   * man page: correct IBV_ZERO_BASED to IBV_ACCESS_ZERO_BASED
   * mlx5: DR, Add missing action state for FDB push vlan states
   * mlx5: DR, Enable QP retransmission
   * libhns: Disable local invalidate operation
   * bnxt_re/lib: Fix the UD completion reported
   * libhns: Fix sge tail_len overflow
   * libhns: Fix the sge num problem of atomic op
   * suse: fix package name for libmana
   * mlx5: DR, Fix error flow in creating modify header pattern
   * libhns: Fix the problem of sge nums
   * libhns: Fix ext_sge num error when post send
   * libhns: Use a constant instead of sizeof operation
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmSC9kkfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZIVyB/9CiDsvnuTtro2Z
KQkc09g5tyWMS16OdFRO2QVU4iiEgNhfIEFa5blVoAwOTGXGEgm/ryEjA439VxU1
abzztfr1TtvGUW9+W1Sa+USF+HGavB7xd2GxFd/07zds0M43XjTjgiWtvwTvYYPT
Wf1owS78MzCApC9AnWDGW1mYWVgn+v8fGk5TIokKM751ERBMZoL2XLWWUbAVY9kS
u1aK6Pzck1idXWYfryQikglOxa5YgPzwTHrHNztjySaB427faKEwDCN5IB4VVfun
E0kqbBByXPoV+T0mYZ6DqdWxYYa4xO1eFT6S2FykAcIsqxqyQbHn5ETqRL6qdEFs
p3iN2B4P
=kHt5
-----END PGP SIGNATURE-----

