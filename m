Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7071F0D9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjFARdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjFARdh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:33:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E969134
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 10:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqKxaZuHkeMwgJWQY5p6Z/STTwxTHhRuY7yb6bNrbfxLI8EtZXkrr9Ca4GZoByUxfbgQqm6ogukGuM7Ldr8Z0EM4vjl7rPoLWsfEIom1+fZBnoZPN37MPMvf2b9qxQERXBjJnAkyqBk7sjz4GpjnLehIdOJAex89Alqe0rnCsX5gG6byX0TAEbRbCbZHBIdQSol2PE3DKwLl5QOCTw9HgPHvJ7oZdbmFFSZX4/KhSG7Jx8YPRb0BPLXKt7YoCphjJTvj+iIOhaSl8gxqKk0Iq4ySZ/osiAInA1qHZ5ba7Oh8f3Z/Z95HPfWVfl1wYsberxly1QdUQPAtq51pMWbpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej096MZIz7gZm3OgLlLglPArLRAsMYVLik/IatwwbaE=;
 b=H380G2/9pd0o56IpqvfPUt8k7/NUw3M0HFRtWu4O8d2LlN0Vb+gQt24VVl60pJxM9jygzdTbOobKknoYO8Phcm/2TFE2NphEuQGzexYhU5D+Q7cXmcbeX0oNUFTL7CR16f+yB73Ln3uZE6OPamBx/0SH0K94IkrAYgCpZYyVbRta71x6fytQDk3BWUx9QM+jvyKsc1iBv+SG9E1IWjs2QzI70GbIXAHl7dS7KIQHdLQQdYnJyDUKdQDM0lBODM3dn98nSu9uggbTqqLTJZAtYPpSXA9FfnSOiELtpf9nMfUAMJ1D+A7453H5Oe8i1Oddf2Snak1yaNBMKpw+KqYNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej096MZIz7gZm3OgLlLglPArLRAsMYVLik/IatwwbaE=;
 b=Uo96BJLbfEHF5lkhugQsL8JySa2NXfVvrheHDekAMhhW4fzREcyJa8nKC32NJBmCnrYbeiP8xBd9iDcReFVxy5n4CgUMyrzMgsJEs2DTMsyw6r5SRc9ebGnMAPkxP3uXpdyYKtmaBn3bMfhBxLl8sX5p90fGZiM5zznQXQNjQojD8tVx4A61sM4yCQHEQnPagXK0cGhxYq/8KNTz7mRhz0RrP3nJWMx2pB9y5+dBTRNVs5zYaMnb9wG1zlBZWxKFr49pnzgoUJdyiWuMl/c2XqZuXx149aMzVdjY7XcY/zIIdnouSeCtN2192UWd10AoCTK1rEbRUfrBZyceu3QjCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Thu, 1 Jun
 2023 17:33:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 17:33:28 +0000
Date:   Thu, 1 Jun 2023 14:33:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ref count error in check_rkey()
Message-ID: <ZHjWZSWem41svcbM@nvidia.com>
References: <20230517211509.1819998-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517211509.1819998-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e893fd-5ac1-44d7-0ab8-08db62c64fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ri581oLAS/C9PXZhpdpeDfnipd1eLZbG20sdY0YSD5FNtdQwJsNmAhR0G0wxZM9iYqf+wSZ4r6CwIorI6sNGQ1d+tXu7uJLvNlmWeCo11dvqTxTNvRW3LQzJbbGhibBb1tvmHDWeC/lWXZl5EhzzQiOOIZXEQGmqblaMA3Rdt5QOMq1TZxWEx6QEDYLD6GhERBjZ59EGJMCcoiAS204q0fDHe9QL+ymixIUSj30r19jNe4bAlXkintrBO3gGihgu4zP9Y16E+8eZP19Cv99wdNNdUBwuc+Zr5xo3DM/F3G6PzsZq5he8jXKfkKloUTriV3P6tm/4btaf/GUBe4VB8wxNNxouF8hjZwsj61SbvlvVKLdxZ3hIZXTsy44pQMXsj5AAHB745kUxKR2vuAyzm+2AZlr6PpKQCocJj+A4lr2thXkAuBHxgVz3UR8vUXjGm9YaAit600zNWuaft+7cQKPMMiru0BL7RwX9ISV4+yVkiSCI7sqsAz9PU8nomkwOEZAhW7TUHKxVPuPOyBr3Uink1ncP0WdMUQfsnRD2mNUbTVjYLgSSkpldCFIZ7umX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2616005)(36756003)(83380400001)(6486002)(6666004)(6506007)(6512007)(186003)(26005)(2906002)(316002)(41300700001)(5660300002)(86362001)(66946007)(4326008)(6916009)(66556008)(66476007)(8936002)(8676002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RzjkSAt2s0jOXEvsdBhgJoaMih2FxsurRl3Zu9z0vUpMLjNZzLb0fs1UG6Bu?=
 =?us-ascii?Q?tID+/tfZZ8PhpKTGT2BpBb0Bx9pTPtLhhmRShM7GnL7t9xwjViU4LmZosos3?=
 =?us-ascii?Q?n6aj5LY1jKC3IR/DgT4cJ0frpd+FZLxTuxrLxnUDw9nVgMxwDD7aXtTZDyfa?=
 =?us-ascii?Q?LKTegMjqykq8CaRZqIuIMHHo1QOGi5VMKqhs1AqjouyjrpP27BURPeE6NWsr?=
 =?us-ascii?Q?KXJu9pAfjxWi+ZvQV8VZvZyJ0nUN6v34PQmPNu/XF/P7Af4muMzpq6dBN4LU?=
 =?us-ascii?Q?47pyJerJ6/NHFq0T3ML7lEYDkg4SxeMJm3oeKL792qyTmVlDTpZDbO8P1a4+?=
 =?us-ascii?Q?BTBJfQzqjedqWRbhfxysF5Avs2u0QJMVMuWnDyqrnQQljjTu8YDw6p9bdPvr?=
 =?us-ascii?Q?PSfeLBtHv1Q4oCkVlbfv0IPkr6yOWvGipV1mw823ZAdT+kDKIEq6EAzM/rAj?=
 =?us-ascii?Q?oGI3Hk587jRFCbI9BVcpLkZGjtesS8PpTsExQsRN4HUV4avN9Pze/VEBj8m0?=
 =?us-ascii?Q?IBn7ifAwKi3NWyjNqWr9aYOTeioeAB9goDIEmGJmzt5L/d8c4jO1P5x1du2e?=
 =?us-ascii?Q?uiomNkcwm8aAjSYVUTn+4bSKeMALbzEO8QAPzxYoZhbRIY1PMTuZdjHcuXIb?=
 =?us-ascii?Q?jX10KtO774PHcTIFPduv+GEMe8pRmR6vq12qNZrOp5VQ6rjTdfoSxUvckQOL?=
 =?us-ascii?Q?W67vYkJ1+bjcXOqYB0KSJMfW/v3dZvdma0n2cjtl/Igzz47wFT2zsi/wTSos?=
 =?us-ascii?Q?wjywzFhuU71vHCidnJzkjyQ9NQdBpNPUDPvAQeA1h8iSiKhvNNp6vB/9S2l6?=
 =?us-ascii?Q?yooH2vLr37lcJ3p3qTfPQNWyFG5xhAy8JzbJy1dTbhoWc9nAslkqgxQSswt7?=
 =?us-ascii?Q?82UDvTkjX54KIRxB447ekcSXzra5FRjhzLwhrUvziMIjmk6/qlRIS9SfvJo2?=
 =?us-ascii?Q?qxzXeEHgW0XCIDJq9IXxvA6GuSzIg92WqtghdmPrEtVoJy9SfyMqGIk19qdV?=
 =?us-ascii?Q?A92AFs6sKIKE578szeKYlEWFgwpGZy4WwqRiRwaVNtywvBTW0Puc1HLPdW2i?=
 =?us-ascii?Q?cKdoeYUJK9Mqb0OEWqAb/vcM44TImRAetwYJEZ3wnyRMGS98WKKHBhWI3phD?=
 =?us-ascii?Q?oLfXv8tY2z/hmINxMBJ2QY6rcTubw9km28xR/aKZWlLH0+PW0LdZD0bdvIKQ?=
 =?us-ascii?Q?nE2P0Sf1uwxPxfSbnQ2uke+es9q75+4Lse6h9sTEneUxGLoIIKjJP7sM/x7M?=
 =?us-ascii?Q?OJbxBvPfScz064EDZLPAIeN14AmzDFh0xTCOn3KvvPCEYT7xViUB30chxxb5?=
 =?us-ascii?Q?1Z554Jo44DRa0JRXBwG9HNLKZUgvWTWh/pTl/9Akt8TvzYiH0Vz2C7i1m9r/?=
 =?us-ascii?Q?wepANfVKNZA1ge3qYH/TM9xKgdmPG23putZo+O6+8Erawlj7l+SjI54FGe1/?=
 =?us-ascii?Q?rrhDe+9gOoOe30YoIV4l448GI3Nbj0e71m1uqrWsSd1/0Hlk0PRFE4+w8LwB?=
 =?us-ascii?Q?GEDzw1Yi+f4Bx6WMFmVQAWBwIqBHr9tJ18K5MLDNtfTWqp3l/uqbKlL62HEU?=
 =?us-ascii?Q?WLR3tmNhI/+RT0Pn+7Z4vsX6Oa7rftFK/3ok2551?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e893fd-5ac1-44d7-0ab8-08db62c64fad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:33:28.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZhBNHsP2A9aW3roK+Fwck2jCM2tp+v+xyf8Zw7N1fg2qsn8BkEuSzEXWM3xIcwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 17, 2023 at 04:15:10PM -0500, Bob Pearson wrote:
> There is a reference count error in error path code and a
> potential race in check_rkey() in rxe_resp.c. When looking
> up the rkey for a memory window the reference to the mw from
> rxe_lookup_mw() is dropped before a reference is taken on the
> mr referenced by the mw. If the mr is destroyed immediately
> after the call to rxe_put(mw) the mr pointer is unprotected
> and may end up pointing at freed memory. The rxe_get(mr) call
> should take place before the rxe_put(mw) call.
> 
> All errors in check_rkey() call rxe_put(mw) if mw is not NULL
> but it was already called after the above. The mw pointer
> should be set to NULL after the rxe_put(mw) call to prevent
> this from happening.
> 
> This patch corrects these errors.
> 
> Fixes: cdd0b85675ae ("RDMA/rxe: Implement memory access through MWs")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
