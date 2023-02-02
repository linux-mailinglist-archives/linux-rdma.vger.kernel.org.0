Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55013688145
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjBBPIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 10:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjBBPIh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 10:08:37 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8C23672
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 07:08:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZTYH9LppAETvU4qGvxNVSnPbELPWHtdPJy//5+an/SGKVuwpLi5n577dPo693VJz3zMyWOv6e7A+N5Lxxcmv7brXIX53mGFR/K7RuMMs0EOJiTGTsPYgnh6z2X21BJWEB/3ggf2MY0hnrFwunYNXQwjvlbEUtMERaFo8pxVVsTGE4VCA+wuE/RKCV/NaoZN0qc7aP5EeLqr3thw3ThRFwNHhdhCoOPRQgqsRk8vzeIF3nTgJ4gS7WQTDcmIE7xFJIUk4ch37JODuLvpgN0d/5Eff22CtonyTeVI7A086lhMypKx/coIWZT0N+u9UCQQ7etOHXAsvkq0R7ZVVu/83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roR3XatG+QcFACDY+XoCPk44K5PKuu8oC4qcpj1aqM4=;
 b=Lhk4YPoxrkJ01BujkTuvkEFWnsiYsvaGAh8ncku8ZVeK4abS3V96J19O4FwEGXhxISpRqgRSPxH70dnhz7UXQhTpWOiMB6K0SzIB1DaLIAwPDEE75E8fys6qNTJzNQYpJFVTu7aIPSyEb9Q4SdHYWJi2Cvlm7f9GhjBEyswh3HjTd3JImLex34BIM+KmOmJw+Q/ybN1Nryev/zqQCyOarQNKlqr918HNKEWH5+SwumXMCW1dTl4ncThGVsuFbNJ7klY1cMVPIX/hZqmCq60yZf53EIRhlhSRW2KR++Rem2XDL/3m3O9PViGkBM1WaSMRkwwEplkO6PmNrVSdkw0zxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roR3XatG+QcFACDY+XoCPk44K5PKuu8oC4qcpj1aqM4=;
 b=nv4cYFEeDK0t+vtmN08O7k21+ZHJ1DH59ytRAvB7t5/rsThGRc+bbp3sFxHf1GiD3pr6KbZkzYw+JQ8wjtKZsdmwpfuWZt8ZdhlIX8hmBlpEh9Mcc7l6bikcWbDOelkZoAmSVR/l01p269/q0HSLg0MQUA5lw7CQr4psSN8hbgoo+YMDEmgEJWwf8IFHJKr4WPNknWKdTwGLVdZMYmVr3JwMP7aYrziCTbEUcEF1L9ejhyym2AmQrdmNLYt6u0aIkZ5Nr+hK+J80FsECjDPStAOvs783y/FWxGtzIzeCc7/GxqAbQbMlVjUC+iN1BELUb/Gid4rgO/CfK8iydvM/fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 15:07:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 15:07:56 +0000
Date:   Thu, 2 Feb 2023 11:07:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Fix MR cache debugfs in
 switchdev mode
Message-ID: <Y9vRytF3hVU1BH95@nvidia.com>
References: <cover.1675328463.git.leon@kernel.org>
 <482a78c54acbcfa1742a0e06a452546428900ffa.1675328463.git.leon@kernel.org>
 <Y9vBI044qJTsdHZ3@nvidia.com>
 <Y9vDHixeSgYvhVVT@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vDHixeSgYvhVVT@unreal>
X-ClientProxiedBy: MN2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:208:134::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ef2f5a-438c-4f5d-c991-08db052f43b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tspE9kWZXKb/c7J+AfI2TTjUBBVpHKvNtC6+9BC91tL1eG22IlS5teFw7mzTwmgdQfrNqdw8hHA7o6QCa/OTZFGrudbceyRoykvZxnsVySAQRb5frpzh739JKv6WQ93PYbHOwEaARjwJ8LgcTnYVUGnMbbphGnIFcb7qfIFqYXDVGt+Rext4a6/PnH4nqxosjdYb8Sc+wJ62Z+EytMKA8YcMD38Qrs3/WJZcdKNBB3ryPM+TnzeW42qn024qt+6NzmAiEBhumALRZXT1u2aIZCLR44CdzDYOJUftHi5TMH2u7piQgiHZrJxZmcG8U0vv2aMIzXhxGsLbJe55aWefoyJuDfXCZsLbvFge2xzLn7D36VgNioWGZwfpoj8fQyMCa+oytLUdjWavLst4DiQ01eOo88gxJK4pw1KiVMLTo2Su4vluLfHGOTfyoOLGLCh4gZZuxed3P2gGpLDgRtid1GVePkmOhggN39tVqGWqsdxChNz3X09Wui/jWvUUZTZa0HBKGVUJ3rnM8rKoaQz5RVyGHaaKUQ/ebe3C9qobjE+iAWJ3IvuIwt6MvXqgNr8ryBP02/sHlGiF2ZN++KSXobvnzMNnIkTdlH/yauEe3rZWrKRJ+YZVInthLjsDYM7GD1Zy+AJ7ci3lZVmG92uQKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199018)(36756003)(4744005)(2906002)(83380400001)(26005)(6512007)(186003)(38100700002)(6506007)(86362001)(66946007)(5660300002)(316002)(6916009)(66476007)(41300700001)(2616005)(8936002)(8676002)(66556008)(4326008)(107886003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ra3SJENxYYke9G1VPHgsWFfAT/vgGpvLc3igWkc1fdGgmb6rvEn2BZvrr6aY?=
 =?us-ascii?Q?VYLY3tnBEyYdZMN7YvczlebIs3DK5rNr3QhSrIfv6lB7f/8Ww3B7vzgO/Xej?=
 =?us-ascii?Q?l3Rqln8tchus42R/NrLzPX0Gv9tPlOvHjDgUuCFYGrwCguafKXGBsb/lSkmk?=
 =?us-ascii?Q?cmK+ejgk3tXx61s5nIQWZMtdtFWNH4zK3gM7aIlF4gBGz3fVsZdV1LJdxgRh?=
 =?us-ascii?Q?TjPjy0Vf/Po2OjaPdX75HoiVUqtjSMzx04nyn1ye5UGHvr+QLrUG/tEs8AYI?=
 =?us-ascii?Q?qQdBFbELcpRNdAShFbIcdugmHmdx73ZEaYL4FCFsB2KqreFcWjs2F2oIxRb/?=
 =?us-ascii?Q?/tKFPTL/I6EgEMu/GdVHF4PCgy8lNwI+VSzeOQTO+ffC+iIdm1a+TmY9pWKn?=
 =?us-ascii?Q?PdTiChUx5MRFS0Fo5c7sUtKOIUeESBGwGa/+tsIy2KydmQ/+m18+ckhFdH3N?=
 =?us-ascii?Q?DvGNkI4o+UdJGu46v/MsaERgXdajXfOApZFxPb7TTMw+eGINFg6SNald9iLu?=
 =?us-ascii?Q?Ar2v5xE8mFc+qyZ3JZlOZBoE10Fs15HJH+PjQA9ZTUQERL2tLxAXDbPuo4Dd?=
 =?us-ascii?Q?gWq5G/37ymq7w839wwRtuYZ8QOpYGm8fZ9vtiOPaAe2mODGb1IbUFnXsBtGv?=
 =?us-ascii?Q?dHnOIwp5rkaMuA7/GGJXh5KDytY4zp+SbN0q3vONb5nCXpXmLFBDkRQV1iu3?=
 =?us-ascii?Q?195IYgNM71k7WHAyuVlnBP4mq9sF1/tjmC1LAiuV+Z945jneX96HubYkgvNO?=
 =?us-ascii?Q?8VEXZPHuNzkLLpXyYRxvrcJjZJ+dEpgxEaU2WHN7HvFqcrYyoFpW/eeG+HuY?=
 =?us-ascii?Q?pxoxNvjYZ5Zk+PVNS758eXsLgr3tRT3k2rbdxutfB4mln71Rpg2AyTFE2n5r?=
 =?us-ascii?Q?H+P64bz/1acI+hLa9teHc11WaPyg0xWvepql/KZXUoxONnjgkkAbk3fsb/XY?=
 =?us-ascii?Q?YQjCZBdY8JBf5Y4qCLc5fGCAULsjoR0R+ptuKuqRsrVpfzpmmRbmOwjvtfEC?=
 =?us-ascii?Q?wDuPHRm1Xu4yd9YdLACu0CksREg3wPd5gmRd1VQpKnS+6Xs20WpciOGbWKlG?=
 =?us-ascii?Q?OddzrtPfPLRkz/GdvCX37nMUv6s1oooWyqcZN7H9961Xkmk3y08JOAKxws9i?=
 =?us-ascii?Q?bdkviq5nPpQmTCrKne3wLYeuSEr0kFA37VgFOiQVnnLZskDXZBPRQz6OaQH2?=
 =?us-ascii?Q?TxlHdcZnf2nUmsj4B9L7ZRGEEhP4bmgRcBsLaMx7c0GFJji8wFQAJ5p7Ada2?=
 =?us-ascii?Q?FqLCghAACHyr6zvOwmThKaGxoQK15rqEK0bcaPngIlSxEG4zjZ/OcxXy/F+H?=
 =?us-ascii?Q?nUVYkpl1MawFcmEbH+sKjadftGkYilpOs7+ibLbrAUeVnqU1L4TqXZkSedOv?=
 =?us-ascii?Q?smLOZnCkMMvvsMktQR/jTkt404yIZZouBdtaLQk0VFrhejGQhL4auwASFL28?=
 =?us-ascii?Q?2deE3ikkqiwHyvZA+foyzvZwWhFH27krdQAnynqvwX/zz5tuDUjlwshNVDgF?=
 =?us-ascii?Q?PrayvaYh5GwSK3TMLx9wc8lOttcRTdkeKApf2Xjp5RwG4v2f0CKGyjU1Zn3t?=
 =?us-ascii?Q?zC7tYK1JlIMRvI5HaQclTnUzPyAypUW5f11z0iDj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ef2f5a-438c-4f5d-c991-08db052f43b2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 15:07:56.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nqSKs7hR+IHXg6i8Eq5YMlCrfKrrXQ1fREYd3A+5uQSjV3IUe6EIQ6F7ssmfcdL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 04:05:18PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 02, 2023 at 09:56:51AM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 02, 2023 at 11:03:06AM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Block MR cache debugfs creation while in switchdev mode and add missing
> > > debugfs cleanup in error path.
> > 
> > Why does switchdev have anything to do with this?
> > 
> 
> Because we always had the following code in cleanup:
>    697 static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
>    698 {
>    699         if (!mlx5_debugfs_root || dev->is_rep)
>    700                 return;
>    701
> 
> MR cache shouldn't be used at all for IB representors, and more
> comprehensive patch will take more work than this simple solution.

That make sense, the commit message should explain it..

Jason
