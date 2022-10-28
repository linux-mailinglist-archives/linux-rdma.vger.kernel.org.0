Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482636116BE
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJ1QDl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiJ1QDU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:03:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7CA1DC08C
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPgLwA9a3FvnuhkCTHaaEcICpg9v+/s7kMJdIMgD+8TsEcgS0niflDAufOMkbSmjsI1I2LYVEGDZn6IOc/pGXZMGiXz6tl3fjztzgFlMstBOF4OaSJhE5opdeFDTukJh7A0WpQFgGRLBrml5Ygx4LA3/eN7lwAVFIkSIns3wM9Is4bVV4YOTIwBE27QAiq01QtS/wjrvQG7myo4NGEoU3TDpamWzGTtC3pnxe4965QHWms6iq31yE+Fz9XZnmuNpiIIpmaVihLD9KtRymQDbth+IN1X0XhGL2JuBntAxaToBAgOXA4vJxk96T/ZlywRoIq8GfQUznXBsAZisaEix3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK1gk6IUw6ndnHAgtjSm4+YUJ8gLtLd44oSsnLPBLzE=;
 b=knNk2Z9MqAGTJ7JpfIvx89kpdiXrvFcB4ruFwOEWG9Vpys1gvpX38AbrgVdIMeiwa3c7PC9xjMC55KkRDF0d7tnaggdI5DZ7B4NgmyLoeHeTxV3mYI1BiMHFuXN4UtuKDUqaGpGUipbmWa2ZhlCCfP8kCZflPk22t5WFK9PDHHyskd88W5bPRNavZB2aD64FPKkpMLDIWF/F2B6NKDrH0AmqLQzPbiVpqLvdIJJPs6gAddNWsN1GrFF6KlW/JYchkXbvUiEEsVIuTeCpyh61bvXEveYRUBUbvDwzOkAtmuJLh0Rl7SHMf77US/oNPQWwMdhmol5/fezogMPJIfBx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK1gk6IUw6ndnHAgtjSm4+YUJ8gLtLd44oSsnLPBLzE=;
 b=gjvK09hgbO9RkgEE5KDov72atqj2BidNt5qT+Dbp29XaSuXiA317yJH/l1wVXti43kTx94qG+CfomcBjXGM3gT3LgU1jCe+seT2qb88a0dy8YeD1tzU6qhwiYv/lVXJYjVr6am+Xo0qX/V0oyISNvxLPAU1tsMzPKMkzjcN8+rVgFwTXwwyezGmLv0yQY4eAda0eJFOloqAzyT8mhPwwivwwj+EclTTAKpEBuSNgXrwNpk9Hvpx3AT86SNNss1onuKL9lRXZuCDadR3nEWFbzg0DIPO4+gT+p5tRQ2Bb6mp+5wBUTeB+e5GoPpGfVUkWcC/B8dJryuKt15isTD0lzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 16:00:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:00:28 +0000
Date:   Fri, 28 Oct 2022 13:00:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Fix section mismatch warning for
 nldev
Message-ID: <Y1v8m0HliWscL6bT@nvidia.com>
References: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
X-ClientProxiedBy: BL1P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a7a9d4-b1a8-4692-05fa-08dab8fd8886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhHP6c7BZEUWih2HBCk8sy+HatRhrBjfP4Fr3lMN47rd3RboWfROEELz2Lg2eTk41tlHrFIL/2yw+mAv/rUlYR/l3RRqmlQcyy1+hvfH8Ox9Ln/knm9aG2L47b4JobCm3ywLsaDUnoxFFqPSLRByZpqMvLdNflhXwhR/prb3Sh1cK7XHmeOH6Da3j5+OyaNqUz4pbb+mPuoUOpXM1z/S/HWp4bUD/sCqRE+2+rYHrMCG62NH+s6D7ct/zKpIP4LG9t89SXB9IUDVeKdQSHuTahVAECRa5rs/aAyFuAEvSs6h4SvpnqBds7DJWrZJ10zGzLUIZRB8frV6iuIsO7v+0wiKNEe23ADbCU/ICCT4lMSQaG4xP1xe4OKB4oQekhfE8NGyZ1JId3cCYH4GfmHIHG/pwkqc2O13q2oJOuI+4zEGDwsBwFjvRdQJ59CBsHbZ4XjoHD7X5g9hPSWHqn9JHVZIYauA8DSe8iKqU5m7cxRGfBJqBAmNrqpkri8z9626jMGDuv61LR1CeniKUIiCIspOptXzKyRWvDETrxY3FwUTBMHjDNRFJsUGtK6mDGLSN11yAhYGGSM6uJUqEz3tvyiSnDw1x/vXRgHgAAzu4Jwp/BNPZ31pGZq6fKK1KRmJ/dptTuxDhVJByhsJi3JAQSnlHy7iKwxsPCqrvFZ1rrjGyYX+Rvp0SVAF4lB92TTEOvsHPg6YjT85+7eFSZp4Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(316002)(6916009)(8936002)(5660300002)(4326008)(2616005)(186003)(8676002)(36756003)(6506007)(66476007)(66946007)(66556008)(6512007)(26005)(41300700001)(83380400001)(86362001)(38100700002)(2906002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lULLRHR3g9T5/F3JWmDjUpFd89XBss6reod8eqj3fcbBZptA4GGep2r1XsdB?=
 =?us-ascii?Q?FvzoT2Qm4VjwJ6+D1yBYL5yiroGuUBWE0jgypSXJ8o3mVA1brt9Hf5ombyk9?=
 =?us-ascii?Q?1Y+H255uvywZaRstDhn45k5dsIIxTxKdDe8PfHoFMa4fth8JH2wlb3OuYYJQ?=
 =?us-ascii?Q?IhG6enQctP5kLpGBogwKbcAHOsdPcCpAYErgi6XlsYps98yRRfY//2L8wlxV?=
 =?us-ascii?Q?TuXjQf1DPi/Nd5jW6h+etoR0UtdCIZ6l5xWSs9C5W/dsOabjd8P3zm32IQ8Q?=
 =?us-ascii?Q?dQO84pWNq4NFtFdcienEroFKoeyYz9Wq8I3Kw4mvPoHaAVzBsEfnf3bGoQv2?=
 =?us-ascii?Q?meQiCLht/6SA8lvI0xxoPX7BLw6vYF0jet2HiWddToAnjhzAZ7465MOXH7Ix?=
 =?us-ascii?Q?McMNxDH7XCRqNUlQ3JnIZJCpv8FaFVF/Po5mfmwfl5PVYOwissC8cNHRUT/a?=
 =?us-ascii?Q?q7bH72f4RXEb53nsitPSv6gYzy79lKBjBiobJKf0vRNlsuVNzBmF3O2GrIeI?=
 =?us-ascii?Q?YcTKwlXNXx6WqmkTVQtbHeuqJrEziO/2bDoaw7iJFNUA7m6PRJOPc3J4GF/a?=
 =?us-ascii?Q?hQy40DdyU/PbERmbivFjRXZexJwHjKeo1csYGZ5AZ3EyuPnpHjSZF+JGaNnV?=
 =?us-ascii?Q?QmcFM0RiQ2sbWZrFg9AjfDv8+Hq5eZ8gt5McKarfUYzGsx+Qf3FeQGoZQWLV?=
 =?us-ascii?Q?HR3aiX+m31/hminUtrkqdareIFLeW3SdKimYv9j3Nnoxk2toyqYn9uuKu11O?=
 =?us-ascii?Q?jqOsAynI5hgR/lsrJngoKdKwEvRhi7cdYIwE+TUNwxhd5YniHsz+Zei7bnwN?=
 =?us-ascii?Q?9fmFryhFEo5BXmh+nB3SofIxipuRHjdOzgkgUIC0Sf76TzoHkXlyPtSBw83x?=
 =?us-ascii?Q?hehM4zU5MyDqU0RerWCd8S9/+/bzd8utKmMjXJTxFlWV2eNaT5vLJRGq6+Kb?=
 =?us-ascii?Q?Ew2k9noHLVLVcQy8upCITUk0MOVzk28xGkBR5uhWyYSV1T7o7H8f9arYWsC5?=
 =?us-ascii?Q?0BA6MW1vHQJR0k89ckWUQgpP5dH2Cb4vbmQYhdZ2+JzGXNtymrlqxpVYGFsO?=
 =?us-ascii?Q?OQcS+7Zmhsh0Q5Y9HdduOg8XivAlNMuxJj4VUfyjpFEJt251Jk1G+Az8WiTJ?=
 =?us-ascii?Q?BpOTsSj7rO5eCSVvJ5PSKYVYXwsLLFepAYDQakPMs7TRaLvh/QQ8IoXvWwvt?=
 =?us-ascii?Q?XXsQGNNxXrmrkSFH87ebsD48S1AmyYAzWWY5G0NlmDOjeKkDUuoS0shMHo0D?=
 =?us-ascii?Q?UHmUzuFFQxnYhmpGtUnlFuc89fbqYsTZ/0iJ7ABqZtAc0UyZ0x0EqvK5JTC1?=
 =?us-ascii?Q?aNl3+HCpZklPCVGxJQl+xJSKQoR6yvc3iPRaJMl9LGTahxlihtkEQIXeZitR?=
 =?us-ascii?Q?1QNoQtpdeddeIt6neA8EstimzjsX3kgx2Nrl8vroy5X8IfVLGy97xDuML5xC?=
 =?us-ascii?Q?d3F2sHt/qWu5wDCQNNMCFNSitoC1In6sliT5HqfbCy9HomxZpHX6HZqSMduM?=
 =?us-ascii?Q?CHHrAH1KPcNH6uzht1+rKzg5zBoEk1MKJjwgsTEs9Z3IyI3d2mi6fTyg1io6?=
 =?us-ascii?Q?l3OWIbjP26QbBRPIH1c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a7a9d4-b1a8-4692-05fa-08dab8fd8886
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:00:28.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7XkQaz3CntgF9hqOVPpxhwgpTNyl/LraJpdC4vuSwQ4jVXRoBInH/VNgL1Ea27h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 09:58:56AM +0300, Leon Romanovsky wrote:
> ppc64_defconfig) produced this warning:
> 
> WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)
> 
> Fix it by removing __init/__exit markers as nldev is part of ib_core.ko
> and as such doesn't require any special notations for entry/exit functions.

This isn't what the problem is, the patch Stephen reported:

commit ad9394a3da33995dff828dbfd4540421e535bec9 (ko-rdma/for-rc)
Author: Chen Zhongjin <chenzhongjin@huawei.com>
Date:   Tue Oct 25 10:41:46 2022 +0800

    RDMA/core: Fix null-ptr-deref in ib_core_cleanup()

Adds a call to an __exit function from an __init function:

@@ -2815,10 +2815,18 @@ static int __init ib_core_init(void)

+err_parent:
+       rdma_nl_unregister(RDMA_NL_LS);
+       nldev_exit();
+       unregister_pernet_device(&rdma_dev_net_ops);

Which is not allowed

All that is required is to drop the __exit from nldev_exit, I'm going
to squash it in since I had to rebase it anyhow.

Jason
