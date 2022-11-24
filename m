Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4763E637F5D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 20:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKXTFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 14:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXTFA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 14:05:00 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DFD22BC
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 11:04:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMFQHK0Ht9lelwE8R4sVk2ID0Y3oCquiZrHoBbnv1aBdQMbT4/IpvS/Y/LBbNyaFh2Bu6MD35KfODI/KzklaJeuFilQEN844paM8P8n6tN4nBbka0G5f39DaT86rpaqUW0bUSd90RnuPyXbXh8BuOVbik3PdmbL5uTV1fwCJUlLIn/sao3Opc50BWd7y4TH66iogRA92e06ZH278gVZnNCNuvYyHogBwCym31ZN9SB3XwlP1xnRSlGm1B4wB6pZNWlOeKcMUczy6ywmH8EVbxKXmqwo9alllceoUTkjzbxTSx5YLI4zsXrxgrD57qlkPlwzAu4Fa04oMDkmZnhSV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5eX9ZJIYfW++np72qlyXBuCN0OHzFu6zg9bahDZaoo=;
 b=nGonmSxfB9R/CNPMV1r2fq0zqMx/dTnutdvpHl6CX7quEIsXhB7qnTRj7jn2YmLLbVTK4H11lqfowOTDDbSRk6jEdNXQYYVt2w0R9naGwIt3X33w/CAgdlYSYvPBQtq25egV2bhtiQ+5ux4Hx9ERoub27SWrx4zv95EfdDaenctUL1jawa8/PlIZ29HzQB0MUr8RhW6QqQWBWu66cWkCab6P+jxtBDvRICqFk/jWzgVC11dM7svw16xKdLH19m6oC+/Ut+9Byv7I1fmqCeO9tLvqmBZLaXkLGW5pJD5CzdphYCdKnLKuOHCOsGDNnoZtqcmdLgXYOe8cvDVu6KouqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5eX9ZJIYfW++np72qlyXBuCN0OHzFu6zg9bahDZaoo=;
 b=kzyGwRMePPzti/zAuhRiJ5rvbjwnaBQx5NhUPzuKqJne++rgTQLgupI/+f1lFEoUfpPF5G0rHT30iHAMlxdeg45l17daiQTRey8gTnQarDKXOyTArAFjchJo9hPetwhgtNzSxO5LsgSfRKFWRg2HjY5UxqR6DLnzXVteHjAOEuvgAKzzinBhsd1cYErCap42qAKMzawcgBF/Vm4KzYGP5aJrarUPGETZg/NMjt8R/VtOuvnYvyfSGD61y4x+fbHjGZWLwfdsy8hmAvBPAzYMSY+x2xFAcCRyRDp36qge6yG3nGpQdTwGo1Z3ORW4A3XOZQ5dj5uiBPNuznxTCDeadA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 19:04:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 19:04:58 +0000
Date:   Thu, 24 Nov 2022 15:04:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH for-next v2 00/18] RDMA/rxe: Enable scatter/gather
 support for skbs
Message-ID: <Y3/AWaw7a9x7l48B@nvidia.com>
References: <20221031202403.19062-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031202403.19062-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 1418867f-92a9-42fd-010d-08dace4ec7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37sDI9rkXCDMkkpdYyWiw9dCWng7d0HtVSMjoGUvPwR5HhuwjrGoDOowKsmKVboQ4EXLk6nzJIHqqwrP6SBRW+hZVgU1MNut8dUvoxMYpRWzJiQ0CejLpR5j3YpCqaeqTZiU7NBmkt2jQhb8xKd1fmrwY/spsswJIBC3XOqRcEcefQlqCuTDrr1yaBXD6kDTrs4kDevbkp3NAn0uitHpm/i4LfClrU67wNe0xK7UuiiOTgVJ2WMzz05EXiDdorA51/YLY1G2B23h8T5QgBZUY3kdVhwSsJWiKOdIYwCjK+HymnJKayJj7rgQbT04kmmisH3VyI3UTBFHL3vBbSrVobN/nTX0/N9goBEhLMA3+fGHix9CAIWVVQvbJzvCqS8C2LFtfk6Zjgn5mVkqQv1rzIttVd66y7b78S/pEotkGcF2E2Vnn8aPCyXN0rmZEzTYd89T6vtriB6DX+y9VE/bjWPwLyRyvBc9/Ql7QPpdTIZ+5mnSpKeXY5m3931+WDvJK8MExqQ4imB0SXmS5tUqUMiqdoBo+W2FnjB+K+HirvgsDbwGq7uGpNCE+g4FWwDQCUb9j3nGNNmkN1pWxKHyxNPZ0wc/LrD/kpJ7dzZPSjdBnDF2S935SzP/kBdOsm1DD+XrymVvMfmHc6CVbd0xhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(41300700001)(5660300002)(4744005)(66556008)(4326008)(66476007)(8936002)(66946007)(8676002)(2906002)(36756003)(6916009)(6486002)(83380400001)(478600001)(316002)(26005)(86362001)(186003)(2616005)(38100700002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9WQmd8k409oUb3BTiYTeA1JCISvPiFFBwjL0kQR6BBVdaZXIa2LW9kWcubw?=
 =?us-ascii?Q?Xe5LPIMO0cc+h5Z/5kgh2Z60KjMwdlK8/BYCZq9yMnRVFlxv3FAcN8Z8UGgx?=
 =?us-ascii?Q?SNf4Yqmjoz9CrnkJnuztypQswl6Xt6AYIW4PXopFY6xVfx2cOnfGANTjn9nQ?=
 =?us-ascii?Q?n8xJQZfZMtoCa+vJvULRe790FbpU3M6bFNjOBwAkBSYR2KZjTTLV0yOrHwWf?=
 =?us-ascii?Q?BXXJXaZA3dfyYEn5Y6UG4NkGtPp9zjMeEUk6DvzsCs33mvgWAE2dBjZZGu1g?=
 =?us-ascii?Q?cUCd0bKjsZE958oKPF0Ay0lMPp2p/N6SwlNshZWJhntrzZN4h6iNmp1ygZT3?=
 =?us-ascii?Q?aE/Pzl37/+IipUha+Ix5mXfQHct1F2DYMOA+gYBuveKqmSygbR6UD80PQ6zk?=
 =?us-ascii?Q?QOq2lwa8TGeqPuSVop/KkxahWSa+u7KMxhVtLbj2YKaf8Kwl9/44MtLd589w?=
 =?us-ascii?Q?PpXWFH0W2SqjmXdn2lfRJb921mKgCiL3LWm2fxRUjl03CstM9NN+bo8inZ8z?=
 =?us-ascii?Q?hB3B79O5Mg8mmciitj2OLKbEyZXymoA6tOH2aKQu8WsOD1GdKooRoPHI82o7?=
 =?us-ascii?Q?guEMOGO5jhntS0qkiQo0H2noUY+YsKIZWadx2AoQs8+1+fLZF3Hr84hyer+4?=
 =?us-ascii?Q?Cgq4eP/MLALhnBKdBntzsHeq9r4MceVxeW2VozdjRCricE1a/KGki2401Np4?=
 =?us-ascii?Q?fCXmZRHiZAsmg25jC1sPNUXStDCK/LqZ2I17NkTzrxS92EeHBCitH2OyNTa8?=
 =?us-ascii?Q?L3MxNSSFLr4PvVr3sYd0xa3+C2wLkWy9IUsAABbCs3yuXftDiUlNZurrzLSR?=
 =?us-ascii?Q?Yw/o+v7nDw/3/W971JZKfk7ahG5+GL5VlIQ3UTjuohJGOSXR+UyxFmVa+AON?=
 =?us-ascii?Q?4ieVGAU0nbj+2fid6hHqbs3ilmGrUsnDsyFljYzVOdLl4ie8021vHMUA/Fkh?=
 =?us-ascii?Q?wY5qUnCs4O8hpbzgqEEhfZ2loH1T+koxGaSyTiK7JW6iK56JjYDb80TKcANn?=
 =?us-ascii?Q?7/8CEUNvfO3qYrKv/nB0szrPxVrKsC3a0PDpNw251l6WFePAUSIoSvrMxLQU?=
 =?us-ascii?Q?oaRv4gRW8lZG7VPoBdV77yVW7SqWgzZHhHoVyApc6V0ZId8TFThkKaz27s67?=
 =?us-ascii?Q?x045cPpX1jVvXdgwMNz/B/oXRVRa8PhKaUi9Usci27D7o9qld8BrXsc1Cxsi?=
 =?us-ascii?Q?cBeaV8mxfnLyc/PntMlLt0k9P/SWO3bWvz/5wTqBBu4kbbEYPXoLnz92CekE?=
 =?us-ascii?Q?3ZvTbe4ucIMm6teQKtVoQnIHxzHfc9HORRQe92ybowI/HPiQG+odE2rZzpRq?=
 =?us-ascii?Q?G+1NfOZGm9X43qL0a6DmOv2DaFDCKR08qDfNGQdsGjtqii9oMBfXr3porkar?=
 =?us-ascii?Q?0rpM0mnDt9YopKfutyLdetdpS+yWajRr1k/KCtIePaDnIrI1rOuaXtoIAkyM?=
 =?us-ascii?Q?0w7yvghEIjHcsEu32EmCmv6LbQpj2p48VCaCREztZsQ8d9lFS242FSfQaiVV?=
 =?us-ascii?Q?mZEkO28ji7EmGhVk8fElWn0qXHB0lZLHZb3tB7xQikXJhI8kCJ9pbAMK+Srl?=
 =?us-ascii?Q?FOG7pLTQCiqMjsG/Y5c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1418867f-92a9-42fd-010d-08dace4ec7c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 19:04:58.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wulsl4TgL+7OzhgEfumzFa1whv1yDxPC32v6QmSWUu8WtTNuaB3BAhDNCau26o1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 31, 2022 at 03:23:46PM -0500, Bob Pearson wrote:
> This patch series implements support for network devices that can
> handle or produce fragmented packets. This has the performance
> advantage of reducing the number of copies of payloads for large
> packets.

This doesn't apply, it will need to be rebased/resent

> On the send side packets are created with the network and
> roce headers in the linear portion of the skb and the payload in
> skb fragments. The pad and icrc are appended in an additional fragment
> pointing at data stored in free space in the tail of the linear
> buffer. Only RC messages are supported.
> 
> On the receive side any fragmented skb is supported.
> 
> This patch series is based on the current for-next branch. It also can
> be applied to current for-next after the workqueue patch series is
> applied without change.

The concept seems good

Jason
