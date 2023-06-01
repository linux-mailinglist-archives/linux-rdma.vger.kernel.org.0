Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00B671F64B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjFAWyN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 18:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFAWyM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 18:54:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD2138
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 15:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ/6CsTf6kcV3sGHAPKTYDogD+ss9PK7SHWg4B/g0gGgyXUcjNSxvUToAt5/nKgTXgRQb7iQpc3FRm3Ofode3EwNUeRK9fm0IhKsARgNlNl65O5BKFLsB5kgZtkd8P1QFX9jhdrtMOMEpP7PLlKmRziuoWlzqr8x9mQEltd6hRmmYQe7ScCxOyZ5OXpO8Y4r37deH5E+XOM+M75O2LhLk1tRi/RQVTzmI8UwA6E1r2OH60CHWjdCAcCzRRG7NbiOtkM8z8jDaLX0Z1eZ+g7JWx9/LywBVl/Ci67v05cZOGVdwPSR30rU0T8qIBXpicIwVxb7JWXZtwVP8HlCqxyffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxJIAkwhGnGv0sk3ODG5nR7Ru8DX+LfGzcna9eXijmc=;
 b=UDfg78H6NvZggRRtIddTZsWqI/5F28nYkuIhml92XVF4J5ncVq7LaGviyriD4cVJR+Ka42KJUEShdKpCkG8rFmUNr54o/CVgU9nDTepsyCLvxROXMnu9bOyEU5zmDCHAsvSRaw63Fe6Fxc633wyGkISY4n6a5ahH7p+WuWhaxCqPbFmxrLXaOcr0kSNEjQT8YdkuydPdLBE08Z6w6OE3ZDLT6pGw1X6W7y8uy5w534rpti5ulFIF41KB+y9F9JGzdSy8Xmbak2ospKKIBiz7jSUd9e17SBupSclaamOHQxXQHiWz/5U1JsS7cLHu8yrjplYOPU2mwWTwcfOk6zx9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxJIAkwhGnGv0sk3ODG5nR7Ru8DX+LfGzcna9eXijmc=;
 b=hOO95Nr8JRIW65NIdn/jne+rm+hBtsOqvpjnDFVbbT3h+5Dkjt0fbFLh0fuAPIEc3NUTPD3iG0euFlSy3KisvzUQOyGzqMRGtDM5B4NOF0XT9PhENVXUGrSXTV5xfAEWsrjk59dtfwoZkKqK57MX5GLXXJ2Q3tuhOgCchemi9/YVWcnXY+M/K/mjT1m2CNFeiSw84p1HztjcBSLH6RXo1a+615aGwaBBpFg6DF7fhws3lmBI/oQfRnRIAYKoPAUA74KFYJdqYM3H7OLRfia8O4oDgjwWPvUos993ykmGYU8myRk7LOc3uCCl55eIaCUDtg0u4Y4xMtjCWSJ/vTIzFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 22:54:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 22:54:08 +0000
Date:   Thu, 1 Jun 2023 19:54:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Updates for 6.5
Message-ID: <ZHkhjTvi8vNAmmEC@nvidia.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdbf949-b083-4a50-1170-08db62f31bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+OrIPv8xjfzxIsHKYMu2t2z5XWSlM9I0pM5+trUlO/iz3MJJ/0qMdBKlJj6VIKOStWMx/Nzi/MczDThwaLP0l2pooReyGAIdy2USfRc4UKn5Janrsp5WE3ykbR9L6+1sZ6qImudPRzxB3EwEQ5OvqIspg5pwxLZ5YdXVhqeeQGjfbcOO4Umg2Se/2yGz+JfHQQt//hODBAKfqpbF/dcNFeaDB5xQ9FcC8FgfSvegtKDXQIYO213Xa1YxvXIaYyEuzXRViCiDGgGhD9XdVOMYvNk347KWFfVUqwKUK46tWf3Ed7kA6aCijn1TcbKs7tLLKpcjDcZ1y73Hwu0in1pnfJcGweSJt8H3Co7mmn4URHLLbij4bhk59qtbN9Zxn3bMuPOtTBjAO3zm5rx9KS1v9tvRr0WUjPKQvWjYdogNFqBJDeNHxGYMBahQq45Myf8SC2crTKddwVI4CdmUnxIeH+Nymav9Izy448oI+A/n2xDR5V4qnxMv5OPIdtTC7XWLFEqIRTInXif0zdnECFKkQ2eSxDzNfWOO7eaasB6yS/GwXI70gHokxyepLzs/l2Tgq3c6iWXsPn2foDgDqvV2VZTQ3VIyiGBGe2JOsBarEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(36756003)(38100700002)(86362001)(66946007)(8936002)(41300700001)(966005)(6512007)(5660300002)(26005)(6506007)(2906002)(186003)(4744005)(2616005)(83380400001)(6666004)(66556008)(6486002)(66476007)(8676002)(478600001)(54906003)(316002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1pWcIJyMZfuTy1aEsHo5KERPWB6L0uruKpxtct9aK4f/43/cnwGjWxVOKqE?=
 =?us-ascii?Q?7g0Z+qNuG6V8qEmgsgQ/Ji/UUhK6JQqHCzjicosqycIXa48QJebTViiSm15l?=
 =?us-ascii?Q?3xzWtrtvvg1t42iGHtgx/M/6/rq9KVdftjaVj+hHNNTysgABIfMv8D3Zt0v/?=
 =?us-ascii?Q?IaWhMRq5M5GCCMQAMJGLvcH4U98q0fEI4NaLoQcX1jMjI++QUqkgZpGNE6GY?=
 =?us-ascii?Q?F3bZR4xaHwbzAiRntqypW3on/cnBLPj8sqSF7YbQzDMpWhrGz+B9E2laaZQq?=
 =?us-ascii?Q?oix+cPFMuJmbymNa/1PyLEOUYAw4Zo6S5+Ub9/tidRyPhnVrIwNyz5jJC8xz?=
 =?us-ascii?Q?YNCYE4uhAbyesc0j2T96OrASNdIq66DzrG3sv9SgjSv1NhCYtzaA65Q/fS14?=
 =?us-ascii?Q?e884KMjMUff3EEKdaEtBXbgecGPhulkCv4wxCJBWOYf5AixypgJO5XxYzntg?=
 =?us-ascii?Q?vnz8k+I5Gb+TQS+mVi1YcIj3aFhUA1ivf2HEt5gWJm4NhiRSc9gpENAgiegs?=
 =?us-ascii?Q?PUk7GXMywa1f1jl+5iRqlF1FnIZbgisBsgHriJhIy3JkxM6TOtSOuVjPx3lF?=
 =?us-ascii?Q?s4t3MtxiwRgXNyASfg/5QoBTKjMm3NTOM1W983XdppON/Oi+1wXfc1gIoaFM?=
 =?us-ascii?Q?oEZ25svXsp2gKD4B6nk7R/8hvPumFsE8AmnE7Fhg9FPwE+zu9yGiFKjsKHhj?=
 =?us-ascii?Q?603ZtWEIxPquwvMO0PH18RaEF869izALA1S8OBdBNYWyUW/IjOaSi/kNC7c9?=
 =?us-ascii?Q?QPkmPTY7OnDZIIOO7p6LeJsVCaRS/DxS0LNVHgLmk7y+RiE3NcPRelgjw5LU?=
 =?us-ascii?Q?JRHGmNYD5Abon+O8Ga0FpCFHRAvT68ReJ547PTZoM7tdkZHjsM9KRkPmaDSb?=
 =?us-ascii?Q?SjJ0iI/cvlhKwmPM8j99rgCsFVdn2l/vzaWgwz5TDAnqTC5u588QcYurpigy?=
 =?us-ascii?Q?oUawOIebN7CjZqKERm9fR8GPJ4g2qUDiHM/IQHnK6412k/6hODWHGh3FKPpR?=
 =?us-ascii?Q?dF7UEimTWzyd2Qqlm4C3EDomutrQ4RkNhU2/40gwYPUSNyRddPr9RcEZVlbo?=
 =?us-ascii?Q?Ktxo/mvPrM2TZXvZ3oVneHLZZNCD2IWRRvmMTWu4cnhQYT9kO3Cymk64OmqD?=
 =?us-ascii?Q?ar+5uZPv/lmtlDf7eViesMkP6aChPG9eUmGcYSXw602gKRKkLnoYNk3eahqf?=
 =?us-ascii?Q?eExZ9Koi3SdNjAQk5W3LuAVffmU0r+pnWFojl6GueaWNoX+IrV5cfmWfc4DR?=
 =?us-ascii?Q?ivo937NZbc52dll3KSsPBNeHYnUuWffRBs7hvvF7z0T5JXqj6tEVgNL/xww3?=
 =?us-ascii?Q?o3S5RSi5nwVX+HeHq2ROfOlbooR6WMr0ZdcIWMwCM369s8z92zsIlETVKj5Y?=
 =?us-ascii?Q?zHbPT2s9LK1QkIqdqMSwGoILzKDHPWLI/zH5G2Nv9E9gGlOcwa7ciaIb/2r7?=
 =?us-ascii?Q?TYTwAu0C+DaIfwQZIFGBKQ7odHx5KTFI7CMkXfmexiDafaUVO0RhmTTtBNlX?=
 =?us-ascii?Q?MlCayCrZkMzwPdR1wt8OiNiI2zr2gKx7Eje2iSCL49N2/LkjvHsvZOVR0Gfy?=
 =?us-ascii?Q?BUPHtDGpe55yumC06NeHDFNp0NrKIWAu+qO0IwIM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdbf949-b083-4a50-1170-08db62f31bc6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:54:08.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVWfPK//Wwx6/gmcy+BRBo5EQE0h77aKcR3n5A0fmJXdfQlZqwbkS+Qpt0crG2j9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 19, 2023 at 12:54:14PM -0400, Dennis Dalessandro wrote:
> Here are 3 more patches related/spawned out of the work to scale back the
> page pinning re-work. This series depends on [1] which was submitted for RC
> recently.
> 
> [1] https://patchwork.kernel.org/project/linux-rdma/patch/168451393605.3700681.13493776139032178861.stgit@awfm-02.cornelisnetworks.com/
> 
> ---
> 
> Brendan Cunningham (2):
>       IB/hfi1: Add mmu_rb_node refcount to hfi1_mmu_rb_template tracepoints
>       IB/hfi1: Remove unused struct mmu_rb_ops fields .insert, .invalidate

I took these two

> Patrick Kelsey (1):
>       IB/hfi1: Separate user SDMA page-pinning from memory type

Don't know what to do with this one

Maybe send a complete feature.

Jason
