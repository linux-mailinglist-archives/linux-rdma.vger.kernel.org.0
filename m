Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842924DE0E4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiCRSVQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiCRSVN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 14:21:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B338D2EDC24
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+x4omtuT7GOWp2ZXXvUj0f0bw3Z/lz39STYn2B8NqvpLyH+pcpzgBDPKNrvQ3GhgSZFTmQcB7kI32rvA4jNc9XnbWL+HQdXz2zAp3dobozLrJUPXNt/lKEdVB0ojFlPDFpZsqJhTl3O4pu6eGI7kAOZMWGdhXEVEQDHLe1KrF5accIIA5eFSCPqu4CxQPvpi++h/HJKJN/HsOs7Bw5VVZ+DdSaKj5AOPv15fAT191wvTwUNn+HeTQGC+SoewwKNJlG+lc+yhI8t/d3ioSxyssB1IvTPTcVIR3NFU+W3yYSQXOFjhv42xrUjOrATJb1Bzk0B92r+yBviB5Lz0wIYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F35+Exzr0wzo+Z+MhOseVEv6wZXwZgytQV+Z5Ez+IZo=;
 b=K0I6niEDg3gRVsXMz6uCsehkIDjhjkJ7dmI27I3eilyHNShxRS3TzzkFHOkPHIhrIodEAGlfNjf6UWV4zyNZ4LZ4YdSHzMQtxiYgQCQeZPlQ6Tb1BjqK5IAiWb6Ii2zME7xAHkz+H6DThzw/UNDd2x9hdTxC8WMgMXeUt55GqlAyeoK+6nIFY/3Y63p5oYm2GYdHubDAANQRXxu0OgnF1PVrLmGfDjt05tU70+Q/zW92WxbKSTSz0H+zd1glmF+1HDOMUkbI6d1v1aSxT+F09h3p3dEbGnNfMWeNiGLHJX+lBpRret0tG5nCSCtzhyG0677ftuPFMhOD8nhMQKf0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F35+Exzr0wzo+Z+MhOseVEv6wZXwZgytQV+Z5Ez+IZo=;
 b=rNUXnNMwPpBKKp1oeMUrWruP37n9zi0KETQOjhnVnAsGJqaVGIAOA8Oz/NquKpwgnVXVWEadGAaQsTiAq0vtPAXRQ0MuFy7xbFuccGHTNE4etvgcIJiWCF7918/GhN+ZB3S17lktLFwKtdkFIb6Hjp6aT0YeT8H6qeBnJ+GdH5MJS2RpQN0qgvh9wkakp4tFuUC8iqhP16gsMXXPpyCVT3ECA6HvON+KL5LRFf9ackXBUnIZANMbBINfE95Nnx5dOasHJXZqmtGUaPXaPIZqIMh51Epz3iJh6Ri5beJraxb6+dSqgH/EHXaHhVz9pw1DxjFrpPCnpNAZSs/2fJSLxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB0078.namprd12.prod.outlook.com (2603:10b6:301:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 18:19:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 18:19:49 +0000
Date:   Fri, 18 Mar 2022 15:19:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, sagi@grimberg.me, oren@nvidia.com,
        sergeygo@nvidia.com, israelr@nvidia.com, leonro@nvidia.com
Subject: Re: [PATCH v2 0/4] iSER cleanups and fixes for 5.18
Message-ID: <20220318181948.GA659567@nvidia.com>
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308145546.8372-1-mgurtovoy@nvidia.com>
X-ClientProxiedBy: MN2PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:208:15e::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d30cf6b-c933-459e-c6ce-08da090be3ad
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0078:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00788B30D11DEFDE71D2D82FC2139@MWHPR1201MB0078.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDTvN7f7cKwt945zuYD3De0Q+j/eEmwQfLsWJqhtwiy1uDrXNWjot1Wp5byXTM3ek3SxJHvNhWalsT3KwzIT5iHFUY+tBQ9mDB79cVkb07pUdmfQyVwgj+MNVO0s1vzy8DI5JMXFcr9UynA26dV4zs2suKQx7PhpuO0+1t4D2xYfRgPh9FRtcSA2p3PU8EVd2OwNqxog2bHm48SGz+jw2gRpF5VEXvRXttiNvn6F9oKk8xzAjP/FPCInk3nNNaRh9ILcG8NPbDFTV0xW591T+bAs5H9ZRyt2nktublWSmWEJna2GB5tPN2FvOOAwV2xbq8pECmxMzbzw48P88QiiYjaxAFZ7puF6pBr08dbb2LoZnvsc5XH85Ppq141wpG/XmI6TU8cvSGSBaXfHJ6N1UjuHYHqCG+eWk5faGcQvua8rFB/gtqsnHJz4HJIGeerv9eCoB89sp0Plb0hA6QEAHWmwKLDz56Qxrb2Kts73VmLE8NJ6vqAna3KCn+IT7ES9Glq/NmOwNifHskQHC21/7Hu2LLKTW8pGCw2SmeewXSaPY+hgrMp7w4fA2Jpr7YzPIIwaIK4SGq/7wquPN6CrlZaDwLxicvZwYyN9xXJT95l2IAd8FwBbqx+OzR0VSXA5YKQ5qx+opZcQuJOHMimudw3WLLR5OtgvNYZ1B62thSn9uDKDZTtlamRVNAOpwYa0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66946007)(1076003)(6862004)(8676002)(66476007)(66556008)(6512007)(2616005)(107886003)(2906002)(4326008)(33656002)(6506007)(6486002)(8936002)(38100700002)(83380400001)(26005)(316002)(6636002)(4744005)(37006003)(508600001)(5660300002)(186003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jL32IBre5yznDFYKmVpW+nhrCbpv+zm05ParDgjHSGC8+GJsvf4E1QhhM1h?=
 =?us-ascii?Q?y0Uh4iQ11yiupM0lKNQp1hqSmYNwH1mdL3qiD4TbrksD9+7a4U0+p3wP1Q1N?=
 =?us-ascii?Q?MwAaJxA1vDdHAnCF+kJeHXp2i0KNn2I0TndbJNe7mJ7JTT0hVdq4KX3Qh5rT?=
 =?us-ascii?Q?LnC6tTLjMVbtYeUBAlMysnfc+VGMkzs1DI3UlSBx/WjNVXGbtuEYC/9b6q/L?=
 =?us-ascii?Q?OpKG6RP8/nHUKi/7j/7vay3ii31sGscruadQL7Ff4EELVnt89SQJC90DFfbt?=
 =?us-ascii?Q?HVXhI6L10FsBLN6dnWwCjBHpUWvHXxpppbaYEVzJbM8e8VuthOusugHORCrV?=
 =?us-ascii?Q?t/hkCoi5V0FP9tFRf9hg3qNmoivKhgZZhVFrohctlIG8s6RzYx+X3VAlb/d1?=
 =?us-ascii?Q?kUnYByteA7CZ8XSN6ljHFNFklj3X18gOoDuVCmarI4EOQwhvFsarICa8M81W?=
 =?us-ascii?Q?gJcYJ1f9BrahkbQlL/bupL9MCDUSrQZ9y6eZSv9c9WqiLFmcsZLRme1DdaH3?=
 =?us-ascii?Q?4ABxL7m3rhC/fR6cZhH57LTuSJVNWhiPKqgbQ5OjuiMCSaDfYFUPMV8sqmjU?=
 =?us-ascii?Q?lVfDeelE/g2LlDqw4GAVwNm09u03DoD6NTGX2OYHBXnrXrGBthFsv25kunXA?=
 =?us-ascii?Q?/Fv6l3IcwrfgGuuZD/+ctiVtBYhe4V29zI4q3RAYm0ZvoqT4L9YxpQ1lHp/T?=
 =?us-ascii?Q?VKf6l9j/WMiIi67eV/Ig0pwPcLhSUY7+tbd5BzIxg2KRgJ9CAOP+s05d78JU?=
 =?us-ascii?Q?urA48hYakZY63q+wZVFUATGcyrvEvxFPfz3tAzqWrw1P7wHZkt6wsEDztaGG?=
 =?us-ascii?Q?hXlakVh6h7tjot6QMA4mTNCweE2daxjSDBlNN9rgzBkjZ+5mUdRwP8xVdfhi?=
 =?us-ascii?Q?IdKCr1YsoNtPYrdtePRtDSRnhu6lDlAM9eo3nBS2Jc+KXkWXRdgjHUTE3ZrP?=
 =?us-ascii?Q?14eWMaCBLbZ9wTR4vFFAZ+9M6yYESzsIQhsspPoN/95LWBVNLLlffKZjWbhB?=
 =?us-ascii?Q?FT1ZFVzfxcMXZ0bsG/Cokgg3wVcj/bEDppnVw8jlKxtWoKAAOjVmlpB4lDig?=
 =?us-ascii?Q?HhTTrkkRcncQwv7hC2rP0tJlj78psEeEjKn3FGwry/MW7e8C3cJOmh+B4B+Y?=
 =?us-ascii?Q?THRAvssh8eu5cj4mDlMOrZFtCx1sleFQZHMbVRXKxSXj5whBlumLsZox+p9R?=
 =?us-ascii?Q?gAwFXEuydH0+ZXY3Y5zmgEBV8uwSnvMmOkoL21o6ReFE2p3vXU/BB9RWdEpO?=
 =?us-ascii?Q?QSFIb6x7jju+V22ixFF8ZzQD/QVWKHKAOqQOBzaZrgy+C9KXQ9NizD5PaGlk?=
 =?us-ascii?Q?Z3Iah4vjM1m1jSLcUjtSiCuqpIrlq53IN7CuglrUkzJGGW+DI8NDRLvD133Y?=
 =?us-ascii?Q?bYyql9wMczmw26Y5qAeVpkzOECdBxa62LioROmFjNSvOZEl3JikHZpKcZivr?=
 =?us-ascii?Q?aVd4gAF9IawMdIaUxvo1OS1q+bCRNL7+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d30cf6b-c933-459e-c6ce-08da090be3ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 18:19:49.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHyygZKaCIcXBuAJQW0syiZMPMAewJPsjhGTv+ezxZegirZd40WUVf9dDxVFTiuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0078
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 08, 2022 at 04:55:42PM +0200, Max Gurtovoy wrote:
> Max Gurtovoy (4):
>   IB/iser: remove iser_reg_data_sg helper function
>   IB/iser: use iser_fr_desc as registration context
>   IB/iser: generalize map/unmap dma tasks
>   IB/iser: fix error flow in case of registration failure

Applied to for-next, thanks

Jason
