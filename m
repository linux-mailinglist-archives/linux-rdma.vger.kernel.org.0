Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586A70F17A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 May 2023 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbjEXIw3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 May 2023 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjEXIw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 May 2023 04:52:28 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963E97
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 01:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnuNXBjPU6O/r2eMb93tafvj/6WOTmGRfwInjI21sr1f3yQbOO1EgVlTT5B0A61NQx/za7cGQR0GfecQUcshVx5eFk0Z5/K4jMgBjzf+ZUPEvFkfg7aqBHiOx4YedkFuU4YPqqzvBaVUd7wvCnEJhoTi1M3djDoFa9g3C8VdAPAnTDU7fcHgVZweVX+uIf41CI9Jl529wR5w4WyBmQGF3iczrPFk87aYytHMxQHJRoW54B3k5xl2DhK/tyKLwgpj73s95lbehxsp3elb/mLgzoCqJXQ1Wh/OozsAFPCFarWDgpL178jBMQsHQX6cNaLxRoYZjSGT6WMy74Eb8A4oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySYFKefOmJo7rzkN8O0Ne2PHkv5y9AbEXvTy+M/CI0E=;
 b=JsmhccOU/9vDt78Lm93Dwz8gpb61425Hf1cP1h9yfdfgz5t994f53Rz1GVUQMpzRhIS4FLDq5eQPK0HAbfXcPdn34Ped8BsH1lQBAcCxxyte8S9JkIiCYbTl9mM0RKAWPO5ppXy7NmoD0Ma/XsqvaLWWdOvOe2D1nnotuqRYpahPTm6Uxwohkyvdc8K0zXEzWtGlzWMo1GCO0HFhp3xk1dlkHLAR6IMjJ82ssfpekPSDHg1diWVMJjHcW0CcZzvQqBVX0DCWUmLQQ8hjXuBPPW5KMrYRaY+X1DiS8yiCGPBadjK69uFf3rhAH55aDJhcrxo3qeRVOGrgiBGumOOoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySYFKefOmJo7rzkN8O0Ne2PHkv5y9AbEXvTy+M/CI0E=;
 b=4z+JlPLcf3T46cCDQSL6ukZS3MRmG/Qx89p7Trv6LHs7XFxEOqQL274gpRHTlYQdU3sNfibsCrL3hVf6ZzlA4czj7NtoYJmVcRwTRJki+ZQq46DfZPKNaplxTI+IawtC1S2MnFoBcEuohPYGfMM/513TIKLxNCcXls0P2+K6WwIizuNjoJYKhZKLdMGW+Fbqipo7nGCWBZYVTjY0T5GgXQqcHlQiguXC1OZqBCXJbSYSk9yM72qfFuFgUrCmrzx8hxuSTxX0LnWJD1zcA7MDx2jUvMU33iYcfQtCfg7EeBrj1mV1iEVWWmLPtgosTAkRuktOdy3fc8+HPj2q9hy1GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com (2603:10a6:7:1c::23) by
 AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:346::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29; Wed, 24 May 2023 08:52:24 +0000
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::4e41:e70b:875d:2d5a]) by HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::4e41:e70b:875d:2d5a%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:52:23 +0000
Message-ID: <4f20ffc5-b2c4-0c11-2883-a835caf01a94@suse.com>
Date:   Wed, 24 May 2023 10:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Nicolas Morey <nmorey@suse.com>
Subject: [PATCH 1/1] RDMA/rxe: remove dangling declaration of rxe_cq_disable
Content-Language: en-US
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        zyjzyj2000@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0043.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::31)
 To HE1PR04MB2969.eurprd04.prod.outlook.com (2603:10a6:7:1c::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB2969:EE_|AS8PR04MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bb7ebe-3fdb-4e09-c8b5-08db5c343108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USeg0d2XcnucYuy6ges14c8BvmmRNf9pP4uPDBew2ADfAsbKo5syq+JPUMIBHpJ9dXKVrMbqkjzyg+LLhlBnr6+PLtkIhq2eHgb9BTj1HCYX0tsSKbMZDEuHNXgnNpN8vfYpKaKUMVj4qYPrKpMUNH5YtsHRstxdAvt+0PfSKSuWGQ8Jtu9kID/yOdAFf3noysHV7K2YeZJjNRhBsyVSNmZ1wi4kjFGfSzDWCzMt+eUl8Zy438Mu1jBFf7eob585pPgr5HEhabavERFWZAQZNiChNSIJ2/fA1rs6BU4bOpU7zcqq2PbSDN1bB18Upg9EUkwhto3ToYwDA2JIUMpa+ar1bgQb/bVrogqgex1cI5ptCsubUyrk4jVhnArejVE2NFqXtxVmhomYP7UJ2COGW3uGnM7eipeb+qKHznt4dHLyyvFBGu9JhVvCdnwr/1tS2xAdINdNZICu6/IiokaAB1a5Kka8SO3g2hTL/SRDgA8QrU2jgF26oRQo7j4uIzDZbzo6xsdjurNsAjUQa0UC5gyMTj3oNHZYsFip1MgmJdkGNIsiDCkFdBXF2FF5ya6xfEUBitN9uqL+6SpE27/DwFV+2sqBC8G5YBvyguoFiNBXIjOZbfAP0EwkspTjMpuD5dAvAf4mvcPR/X1gJXhLuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2969.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(66946007)(31686004)(2906002)(4744005)(83380400001)(8936002)(66556008)(5660300002)(8676002)(36756003)(316002)(41300700001)(478600001)(6486002)(66476007)(26005)(186003)(6506007)(31696002)(6512007)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0pqQ2tXK2ZUNE4yczVNWklzbE1IUW5WSG5Sb0FwRG1PRWoxZHdOTE1PamxP?=
 =?utf-8?B?b1huM2txeko5YlpiVG53TXI4YThYZTBJb2NPV0F6NzFSMXJYaFpXSUlHQ1di?=
 =?utf-8?B?ckFoZ0M1VlJmT0ZIYURGakpnZW1VNHp4Mm9xUzJMZ0dUaUxqZmJqT2lGSXZm?=
 =?utf-8?B?dHlaZG9XQ1MxTGRaL2EzcXRGMUxKbi80anNzYkt1UkFieDlUOUZLejRQRUM1?=
 =?utf-8?B?THBTdFY1YmNReTZCR2N0cldaejN1STJ0WDQ1RUlBTld0dEVHWkYrTW91amRt?=
 =?utf-8?B?Q2U3SHJmUzU3alN2enZneldiRFVBVjViT2ZkcEhFQnFDSHlTOC9udHBjakt5?=
 =?utf-8?B?M2s1QlVYeGFEbHNHMUs4TVArbUltZ3JzU215bHUyRkZQSDFhRkxlb3RPaCt6?=
 =?utf-8?B?aGFPem1PNUFla2ROZDZRb0x1OWJadngwamhXSm0rVmhPOVNxYlprTGJqM2g3?=
 =?utf-8?B?bm9jYUs3OEhIQU9CSzBDNWtmcXBBUEYyVUFsWnpUSFdDbWZlQ1A2ZFAzOFJN?=
 =?utf-8?B?OWhCcUFldHVqQlMvYnB2V0V1cUVPanRRSGRoaXRmeGxGblF6MDUydzNPc3pU?=
 =?utf-8?B?cGV1M2ZBT1VLbVU0OVZvMU1PV2NZNGsrRWdmcjNvM1JXQVFRVUhKRUJJYUNu?=
 =?utf-8?B?Tk14c0pKSnRHQUpQM1RoMU9Yb1kvakFiUWpMVmM1N0hyRUttQ05KOFl0dlU2?=
 =?utf-8?B?dkpRWG1VM3dSYnRSVEJKT1NNYXl5WjViUTlwNU02Q3lwMElRNnlaUmcxdzBZ?=
 =?utf-8?B?aHFtQXhldkNPVjA4QmpzUjc2cVRXK2ZTZ0I2ZG9Jc1RIQ2g0TVZDR01hWnRE?=
 =?utf-8?B?K3JGdURZbVdmbUQvS0FUa2RtcFk1b3NMYVpQZVJmSlQ0MnhGVFAzOC9qQVNt?=
 =?utf-8?B?elBCSi9kS0h2VnNKTlpTSXFHOGlxWm9EdU5MUDhWcS9PaTh1WXBRcTZQUkUr?=
 =?utf-8?B?TUxuUjRDdVNiK0N5aGxrMUZwOUdoMm5SbG1HNG5GVFc2RmZjY0FUYVNlbGJq?=
 =?utf-8?B?SzlnWW14cHltOXlkRURzWFh6T0wvVlJ4a3ExVkFhRmdQTmY4UXlDNGpxbGl4?=
 =?utf-8?B?TVd2aWtUQjlEa3FNMXRBTFk3TCtDZmg4MlhGVGxlRDN0VTBFQi9xSlNad2hC?=
 =?utf-8?B?TURSWVIrcHNjMXNqbjJ3R2toeDJwdlRlK3VsajRwNWR6emE3VW5oTUJWaUJo?=
 =?utf-8?B?STVWb2Y2VDYvWGlkM09GU3lYMHo5MXdkb1doZW5zbHNvNmVPaWJNYzNKTzgv?=
 =?utf-8?B?WWtnVVhyWCtKQTNJZzhiQ3RZOWloeHlyTWFac1pWS1ZXKzZ6NlNrazZIQnNq?=
 =?utf-8?B?MkZVdHdoaElheUJ5WGJ1cmcrUFdOMldDSENySFFpRkJiU1dUSFVwM0tLTjlh?=
 =?utf-8?B?cWRDekFLUS9jMy84NUhneUU3aUZUNVg0MmNONnJ4bG9NT01XSldMcXZnd211?=
 =?utf-8?B?b0RMQVdIRlMyRGJWTWI5bUFHSkx3QkhkT0RaMmRxOXFMN0xDSVlNelhiYWUy?=
 =?utf-8?B?TWV1L3ljMGQ1SGVLa2pya29RWU1VWCsxeHFzV0wzcXJUR2QzUzdid2s4ZHlT?=
 =?utf-8?B?VExpRnFqN3hUTVh3dHlUYlc4b0pMRXpKNXE1c204WHVKRHE4dUZHdkpnY1ZW?=
 =?utf-8?B?ZG51MXd2L2FLYUN6MHJYcUZBK0R1cjZUL2tVbFlzMXBzNGFsN1lSdWxOa20z?=
 =?utf-8?B?WFI0VWZpMDR5aUU5U21US0VwQ3hYV3JVY01pNkZSQkI0VVRTRmZIbFRRMkRj?=
 =?utf-8?B?SURnaVdoWmpiRkR5cDdieEZNN2liK01LQVNVZjdONVFBcWFiTEttdTAxUXhR?=
 =?utf-8?B?bEFuOThoWWVpNE42d2VKQWE5ei9YM0c5eWV3Rkwyay9TeEE0OU1DV3E1aVRq?=
 =?utf-8?B?eFRkdXg5WFZERzhzMHdvWkNsNUcwQ2xWbng5Uy9mSE9jRFVjcmVUTHdoRHJl?=
 =?utf-8?B?anNnSS8xU244QXQ4VFJzM0ZlY1FxaWFpS2tsWGxTSWppRjYySm9vdkh3TERu?=
 =?utf-8?B?QzlIcGV6MS82YUd1OUwzRTlwdTdiZGpHUmpiZzRKdE5OOEp3OEVRREU0Nkg4?=
 =?utf-8?B?eGR4SlBCM29hQ2N6Q2pZWVE0WWMwbUVRdENCVGVLeGtYcm94WlNkMGNtOWtB?=
 =?utf-8?Q?LGDxL943tGfmWSKR+Ll/4n0Su?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bb7ebe-3fdb-4e09-c8b5-08db5c343108
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:52:23.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJGng8W9LMrqFYj5J1kxl/q70ewrqdReTta18OvzlZfQ71NNrRj+WpHCY0tN1VMdnN5HgxouGaoW5n+TYIM/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_cq_disable has been removed but not its declaration.
Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")

Signed-off-by: Nicolas Morey <nmorey@suse.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 804b15e929dd..666e06a82bc9 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -31,8 +31,6 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int new_cqe,
 
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
 
-void rxe_cq_disable(struct rxe_cq *cq);
-
 void rxe_cq_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_mcast.c */
-- 
2.39.1.1.gbe015eda0162

