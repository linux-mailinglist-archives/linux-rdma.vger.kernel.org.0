Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1987D67429B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jan 2023 20:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjASTUI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 14:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjASTTq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 14:19:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB859F057
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 11:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzk4n8U99TeoNI5mwBVVR4gyAt2zavdK5DHcGxXQbfaPBvYQ9We0RQ4cLOcNLYz/D6ML1Piy+6/f95bUymcWje+kTw819oRufujLUuC/9SX0T4tWfntgoaDyLmY+syifGDYUWRrAR4xvWNR5rfVDxGXlxdso93sFHqXz1W4Dyi1p2J0hs23jDofZ5VSp6nNoFg0MH9KkdwSJpfL2NzEbjmMAUGfgvlAgSfCGyMq09kgsZgtilSQ+UNyr4HXGcSzVSxOH1w6zAx0S0uBG0zWxKiWIs6YoW2Lj2KJ5OzmVCUppe1zdyZ11sakJZ2mnVmdTY/RiKRU6u+Cz71dV84+asA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQvZHYrXZRDNwfup4I2x4D0VNpOrAYzpcSysoGj9gnM=;
 b=QwM+yH+docUdCORJhbKYRreRtF9IoFtoUMFTuXZQDMjirgh3RHPFqoEf3elyaXnxjpQBZYcnHTuSItutNLQQ0cJSoVNo/N7wwL4lma3etVrAl7puytEdm3X9VQ9GyjbY6E7J+RUM5nZsSAuDz/cKsDTTIXqQOOhsC7pnviFhXrNNXjSqTaqehZDINBfk+ulJIJkJXR13TLqWgVKUP+Yi0A7pAfOMu6idnD+f/y4MRZUwcTaeXMID7R+FhUp59nvJJlX3hcTEdeDzgn3nGSEbNXg8NuZWdeULt5N53oaGz8/QU5d19ef9A3TVdKLeZwLUnhAToFhXn28P5UO/JsfhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQvZHYrXZRDNwfup4I2x4D0VNpOrAYzpcSysoGj9gnM=;
 b=PpkGdBSn4smBsAtlsyL3bgB0kbO6vMGMcUXuI5LgSb1pWp/IkuagB0Ie+5LnhXELwH6lBUGM9lFjtWabNMo3r66sAtJCxHA6J+Qm1YH2vsM4R7riz6zqoVepTA0/z8CMeH3eSKEKCvlk/A7UgiwGgPdBeyFQzFGWnz/4Kw4rmiejBOJ2pEJRsxqWTyrGD/ShqGNaSj6mWyfEy37Ro6R7D0rV7FKQEgD4Z8XET9g/WJ5GUQ3X/z8Hjn1H7uvdWTOIeL+VoJbeSmAV7eguv+h68MhY8ssuL/Xf/C35E/46DbVr3CHEf9+s+WjKOAHvzvJ0sd96ju/gc5uidy5mPpveUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 19:18:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 19:18:23 +0000
Date:   Thu, 19 Jan 2023 15:18:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com,
        linux-rdma@vger.kernel.org, Rao.Shoaib@oracle.com
Subject: Re: [PATCH] RDMA/rxe: Fix parameter errors
Message-ID: <Y8mXfmju8W+3FdDp@nvidia.com>
References: <20230119180506.5197-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119180506.5197-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: e34c7d89-2485-49b7-b577-08dafa51eef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeWBb87SAh3ShMIEnnB7y3ON7kgd4Kv/wIIVj2rrkhjK2JpwFrf6D7EwgwYfRFGep2nd/popFKzctjbCFDUpQDfu/H92aV59oAn+NaAShyBMyUTm7fO/oTh7hoZtQsbEKlCozKI5Im5pTjz1aQvmjuPxnh/WJ0v5EzuKNXq44mZRpcw/5q/UDOR8ZRSx9fmAp2ltwyXZY4bWpcYBvenlxi7FZC+C9NOhxd6GjE9gjr5GTHf6E7zvr/KcmFnIVgqxYKh7bgDHlevOAlZ8zZUYQJMvJLEUruoa16xJs9tM03uPsssDqGcNVffhEKh66LgyFtiW4stkP6x4LzVb2xMM0ErO/Rr8sxPV2ebc465pvVLPLvx4TXj1HgfL4XZnpb4il/XoF77MYfqdMRaCBy74k+BmmYGaayhZoXLuPZoTBo01uZrbT1P9X1dXcd3Vkl+gRZeFvpKFMRHXpE2cix/Nehql0UU1CzAIe/4ZrMU63r9fogqjzWgx8gaF71KHgp62XWNKvZX+8Zv3Ppf9t891SgpY8hcXKNtpH1KPc7eDzAG9X6DLnx+PYvy2m19ZbcR+ZHHLmAFXVCnxdZbnmu7Qf5wNV+8vJrkWI0TeKBUZmF1YNBFR7th/rUgWu7WqmwBAT+ryi4zwZqTAh9yvXTIcYoYYLorGjP6r0rAToHAzieCAgQWwsPWpoliAZeDQ/XPgXdsN0oDwoCidYrz05DGg+56kkXNJ7W3GUxCC1fxo61Qc+zm3sfN35C5Os9eQv+W90aAcB8URd/Yr22tIIodW0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(2616005)(6916009)(66946007)(66556008)(66476007)(6512007)(41300700001)(86362001)(186003)(4326008)(8676002)(36756003)(26005)(5660300002)(2906002)(8936002)(83380400001)(478600001)(316002)(6506007)(6486002)(966005)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?umCEtHFBpGPZjBvuweJuqMnLIEy5lUCOeKgatD7LI+G92eciX5jLCIRldz9G?=
 =?us-ascii?Q?/sdlQQfKYyMocUNQNnpPmrV+0GTGTj8Qffrk4OU7+Y9KK6XViKtdOSPyMFR0?=
 =?us-ascii?Q?8RQISY4C1HSAS1EYqByGu4+OMB4VPHe89S6nH4YLDrpdhDw2jilte6bnOmvr?=
 =?us-ascii?Q?Eb8Cz9bpOBt5to3PVMJc1NU2LGFZ6fNNLK/xDQkQ5I40JzBITh/nMqbqFL1i?=
 =?us-ascii?Q?/AwneM00TQVFBddO2UD8a5UyGZnarNLkvdmVSEAgsaaeuuP9H2aqotEbiStP?=
 =?us-ascii?Q?OZv/IBwhhlNziyyhc+6WNAUoDKwf7cvWmOzf/BKKFf2S/ix3wxPqOl+/RHUT?=
 =?us-ascii?Q?Tozwuz5Qk7nysY0QTLt6y1+8jNYxVkd9RrJZYN9xp92eKxin6hEoUbQtOyUH?=
 =?us-ascii?Q?YiMrVRbECZUmQRBfXiJcuSuCpVjR5rZLSTfTq/Fqy+Xak8q6OLrgoSJtOZHc?=
 =?us-ascii?Q?rbcMm2Nl92Kx4RhyJeAYff/dIsUu1D9SVpQyZT9PNy0a92vlx2ECN/bbb3tU?=
 =?us-ascii?Q?LSabYUHcpc+cdudmAGfKl9IRtryKQUxafhnMGsrf3GyEKdFBkB6uOKwh4DEH?=
 =?us-ascii?Q?3Eacr/glITBrzfBmxjyXHP2coY2VaBU6Xc5prvuwJGB9OBdkrPBEmfj3HLDz?=
 =?us-ascii?Q?TLSjq2L4S4eBj0fgB9GOGfQkl73K+L0ZhFT4vkyz5Nl+Z5aUMsSCXDsfWO0S?=
 =?us-ascii?Q?5qKiqmOCCxvYjd2W/GNnrDy9ZvLduESsCyZd/UBm99VPYQ5wyj0H8wdU0dCH?=
 =?us-ascii?Q?E6045qBVw3gz9ovz6fvM56d67nZEZyRrmY3gkeDpx39LxE7M80es0+8ZieAl?=
 =?us-ascii?Q?UcYMo/H9wlXUYYTU2NCVNh6IGJv7z190M4DWSPGSxsL/+LRSdbzjqfy/va1A?=
 =?us-ascii?Q?lts6IKonGiZmfogP8AWGUSJYlmdYO1RB5YghBB9j5+7G8GfdQshVXm9Z7xsE?=
 =?us-ascii?Q?ADyIHGyNJQq9ld32tDzAAFB+Ss5jrVYtoDGp23E4RBDW+GOjsh1WgeMBpRNP?=
 =?us-ascii?Q?0jAMMYg042DmmThbtE+6hfYQo3fF9waWYkUfvwFx+LyMJWLzdd6GKEuC4cd1?=
 =?us-ascii?Q?UVQNPgmasdPFJgerIkn8sYJ2Q/XS2l+WqzvCdUYtOV1Hkw/yww/syK1/1Rf2?=
 =?us-ascii?Q?rgawPFpg97Sgu8mUm5HafjVuuXh+Q2OsZ4YH5s27iOWU1lm3yFmZSNxFCq9B?=
 =?us-ascii?Q?p5RbNPyRYrzM8bUAMdXAbO03jswNlVdWcIh+kES9alfOZmxNzP3BEEWtf72V?=
 =?us-ascii?Q?0qEsv0gLgYAHlbI+MhsMIvT2qf+miXGWrtCm3fRt2JUIeMMO94NesXc8GOYL?=
 =?us-ascii?Q?G6kw89h8vX9N1gHeK0EChvFx1PMGhcmrMRPV/M4FIog/IWeVl88nJ/MPJbWX?=
 =?us-ascii?Q?ijBFUXit6+HAu+N3eU970ctnz67SDigR+kF6FZGwbsaVYoBEJkxFK1h8QrMq?=
 =?us-ascii?Q?9b+jg02gJIBj2x63xX9YHbJMAzbZXG7C2puHwJWpmJansiO7SrPRk+ABioxq?=
 =?us-ascii?Q?iWdAXQyD5rRghdUi2KAJpB8KMEg4WQdPD0eGitUD5mRby0W+fRt0GRFaqGVt?=
 =?us-ascii?Q?X5ojHBhYkXi2ADWt0ksHzf7bG6tIneYdPOw2R3aG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34c7d89-2485-49b7-b577-08dafa51eef1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:18:23.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTrD/XqvhanpeJrqX4ImgOQGoMcIMhCgnpZUbOgh0LrKH3iBpFu2XuDq8xVSnl4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 19, 2023 at 12:05:07PM -0600, Bob Pearson wrote:
> Correct errors in rxe_param.h caused by extending the range of
> indices for MRs allowing it to overlap the range for MWs. Since
> the driver determines whether an rkey is for an MR or MW by comparing
> the index part of the rkey with these ranges this can cause an
> MR to be incorrectly determined to be an MW.
> 
> Additionally the parameters which determine the size of the index
> ranges for MR, MW, QP and SRQ are incorrect since the actual
> number of integers in the range [min, max] is (max - min + 1) not
> (max - min).
> 
> This patch corrects these errors.
> 
> Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)

This

commit 1aefe5c177c1922119afb4ee443ddd6ac3140b37
Author: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Date:   Tue Dec 20 17:08:48 2022 +0900

    RDMA/rxe: Prevent faulty rkey generation
    
    If you create MRs more than 0x10000 times after loading the module,
    responder starts to reply NAKs for RDMA/Atomic operations because of rkey
    violation detected in check_rkey(). The root cause is that rkeys are
    incremented each time a new MR is created and the value overflows into the
    range reserved for MWs.
    
    This commit also increases the value of RXE_MAX_MW that has been limited
    unlike other parameters.
    
    Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
    Link: https://lore.kernel.org/r/20221220080848.253785-2-matsuda-daisuke@fujitsu.com
    Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
    Tested-by: Li Zhijian <lizhijian@fujitsu.com>
    Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


Is already in v6.2-rc and conflicts with this patch, it looks like it
is doing the same thing, can you sort it out please?

Thanks,
Jason
