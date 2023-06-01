Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6205671F114
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjFARpw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjFARpu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:45:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432119B
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 10:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmbiA0YbAyLkGgzUkjfKbAql+GzEQNfUSrEXrBnZCmHRgfaxLvrsvL0Wd/79WZ4cllsKnIzM3a8R5e8bfgaUeai6+JXkfgz8Rb7VTZRXwpYgAWYIrSlZnOnLt8WH1OUdpNmIftGnRAATrbLeNk/wRGcqlOQyi8M/8L/1swzHD+IHIHlXrUVZFe8En8aL4BbH73mmEhKXyoT16haCTXY0Ue7yZW30KWMe8f3gbY8mrFdGdXfFIITe7t3kxCqYnFCQFtlw6sGImteeVQV7sB6LOgRpZnUzYSc9LCzoCQj523nut+wNUaotyx/Sc+AY03XBxfkUwZaZDQrINZNC/WL8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIZXwH/Lhk3kHZvb0Ef5nu2xH8NCPHB8nIHeIxG7TtM=;
 b=W2nhAWILUombpN9PYSvTruTALJbvir0SA5PnZEEol6USDzCD1xqhgGCjCSRcUsA/nQx1eDrgfpfrVDYErzHsoSjMTYX2+BlkcFSPEncTdMiiQEUcB5xTXvsqu6qbv6+nAOxPASpy12qLwmQFzuLrqMUEMYPDeX4Bzgt4GwUJc/9iyKBxjQl6QS08M8bNNknupTsqzK0xFTWVeuLN/8+LUYCVgH+o5VLLvxx6Jr7WUV6C5yLCJKM05+dQaJjLc76Gytb3E5bWhMDRr1KwRPBsZMnKnJgW8z1+v9npgokYgD8Hw80SJKDG8Dbyx5aP4bWpL7dWF5j/ICRldm4+YatgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIZXwH/Lhk3kHZvb0Ef5nu2xH8NCPHB8nIHeIxG7TtM=;
 b=HdJOeD7Oneu9nTfSZKzWBXgOh7gmmuSom9R4ey4frqVnI1xrLhYT9femOhTe0s1y1VKUu/vNXL/cyeOILh/Ib+6NNk435jYqy9JA4apTEb2sWrJgmGG1BFRQjordlRvtuXg2+Sk8WcZu0aMdrdqz7jMYpz9H/faRxV7TU8fc4Q0WvmhX6WBA/LADJBSRxt6QefDgiW/MdiSR/kJBhygHdISyy0WGulWKNigdcqU21emRJR+0GF2b9FbqfpRTBxVf2KbGO6b9kU3hLLFloVQOdRdfvuD790UD91F0QafHxNyKb/EjKYQnP7rgwaRGEVBQdQBxf0A3qRojkLWokzUDzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 17:45:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 17:45:40 +0000
Date:   Thu, 1 Jun 2023 14:45:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Separate user SDMA page-pinning
 from memory type
Message-ID: <ZHjZQOYgNW9tllNx@nvidia.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e56b286-7b11-4f6b-1dfa-08db62c803df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 462qApKqzmzm3V28xzTQxJfRCB9X4ng62F3M+3PncBYyA+RAwjZig7H6CXI75P8GgY/KGqYXxA4Z6gZy0yTFwgKe5OPgdYgmUi0dTDaRu5gf29VBxPEA0MT8ZYGbFDqIu8iF+VzMvEWA4GSAfto2w8SuNzSn9uCp//H5fLQrbPTqC0Cxn2d9/ZdJl2wpJDMgH5Zi1Fz4qThCldscg51aFud+eI0A9qEjIdT3z5y0Qapc46EVBzTt3I7rwJ3Wxa50NzX2rSUyFUazY6/Ae8mQG3EDkayTx15Fp0f8+42DKR/gMCRuH4AKGZCYGW2jLdn8XprMp7fps/fBRs9hH18/O4+QAQRbnD9IS4wD0eT6JFBF6cHsN7lJX3LW5LLdCB2y9SFdS/Xq7C55KuV0PfR4lTmgGCChIu3ORzoj8Ric3vKAeugGKgjqNEI7Wb6JizPX5Jmz5HSBhhXJ6iPhliQDGyi+vtNHeGN6o7Ouq9zx6m8kcUg74zd2B4KZhsVESwEaO5oRhM0ZYjmNAuigyDQdC6m+kX1Tk8jFP4hTk7BKy8VCeJBEenlM1zGwMDq2sj3O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(8936002)(83380400001)(2616005)(6666004)(186003)(66476007)(4744005)(4326008)(6916009)(316002)(6486002)(54906003)(66946007)(478600001)(66556008)(6512007)(26005)(5660300002)(6506007)(8676002)(41300700001)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYMhhqTqZeowYiYc0u9nYPRATxp7k60Z7iWpqIvrSBTdikeg7eeHg/m68O5b?=
 =?us-ascii?Q?wZxp8xjl4HEAPt3jSfBnMpXg16nJPT7vKJl7ccej8LsDahz9/i2BWoTo+315?=
 =?us-ascii?Q?uHT6FBIZoIJ9/XRpWBEhw9E7wAfS7p1fS9WbY5wYimIipRcU4Hodxu6Wnw7R?=
 =?us-ascii?Q?I7PvXHTBKKywJYWl1iQqIWM1Wpc1wqOnMK5QFFdiuvarY5ksRa/I3pgz79QF?=
 =?us-ascii?Q?o6b7yvHAkGTlggbqyFPfWFmd3VD08T41OAIHKl921M7mbFQockMV2GJcXj2c?=
 =?us-ascii?Q?OLPCUYI3k1UoRPf66m7daKNBMxqLdovb7NUbwDGn+/UVvxs2RR7TupCF7Tbq?=
 =?us-ascii?Q?V5NTp6LYHJpIlgYdfvKmnj+Eycwi6e5Aa3idGkyPcHR04kJsKY/OhkSNlGBL?=
 =?us-ascii?Q?nQYLsivJobtxDtFC5tLm7fTJgo3C+Q0Vn+I12wVAqcj1xT4OWh39WrBvIZq1?=
 =?us-ascii?Q?gvQK65CbvYbmRW1neJewa+2M/Vsft3FZhMmMY1/BVaEyXgFGBMuMftRcs5dh?=
 =?us-ascii?Q?Jfw3TtUVqOSBEa0dvbBecmSlcO8F9DGhly7vZ6SnnbGlLb+pc5a9EG7JT1k2?=
 =?us-ascii?Q?qB+rX0f+UjNgxvHtGspd1zWPXXO1CrwmoZFPMhC24UXFfXG+QfJJub9XYhTX?=
 =?us-ascii?Q?rOKZ7K9LpCjAaxEMACWN+ciaNBoHMw5wFdaR7uFoQSjraILb9Il2CI+eSpZO?=
 =?us-ascii?Q?Hd6v/DaLsNYW8j4vwNqZbszxVF+VHFQYs383ohTI5KV3VW+nPnK1dYYfFUvS?=
 =?us-ascii?Q?WEm3k1gOOIdHweKETH6Lif+iBvlTtLGxVQoPNQTGcvXEORyLuIVcGJGNKcNj?=
 =?us-ascii?Q?auhrweCgGWZdFHTIYF/52OO5ajkE/YxAomrBbbypGJ5B6zIgFXpZfbbD0YwY?=
 =?us-ascii?Q?9QRN3YcxXyfE9ToAy671XOnU9K5zYAnE2kLzZI+TAc5TSBaZncn01IaoVlFe?=
 =?us-ascii?Q?WmGCqhBXuZ611p8ZDY3nPxVxnwd0w3eUGmnICfLQYmFXwEDRvnPh50D4cIph?=
 =?us-ascii?Q?p/uWWyT26AMFnccvbrsbt/zFGTKDtsYPWP55qUy9QYqTGSfsBP+oj5EMeJhf?=
 =?us-ascii?Q?31pk4IO9WJUr4jL3HsX6R+P+4urbrmbPaoca2+C19oqto81dqFIsB/5gAfp/?=
 =?us-ascii?Q?2g8HvTwnAxmsWPKs2X5khrRTYV9K+Q5nHWY0EzlZ4e+1kNAQCvI5xBDbPUt+?=
 =?us-ascii?Q?j8Y/SPwP8ILpEyDPRJzrshZ7xTeLZIIEvOGExCCB374PsMqkw66iGz+Y3FBv?=
 =?us-ascii?Q?xSNnyhAGYIHiarMp4WVukzvOual4/L80fxA+zYQ4FIuMBvg/+2L9vP5jNZ30?=
 =?us-ascii?Q?Z4Ley3qldSPoE0ilQT9sWAHHsDl6sYXYgzviOCcs1ijkFxAiVUqnhLsq5pXI?=
 =?us-ascii?Q?DODHSoSl5ap0+mrx6HpqVMxLS+ulp5m3AdzmO4UP5cKIywLLmipsgUsGZGn7?=
 =?us-ascii?Q?gt4InVOzP5+ita5ixokO9Ih1TOopvE4XXZXIIqBH1dYYXFxb/hveGtb/J1Bp?=
 =?us-ascii?Q?WlQPcVFsg1BHivf+ikkbJ1nenUhGzv9y7LKIBHZQqd1iygScTZMhHB6sRTkD?=
 =?us-ascii?Q?iwmXj89FKty0LIpcFZWz3BzQcH9yGpxZx25snzBI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e56b286-7b11-4f6b-1dfa-08db62c803df
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:45:40.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h3ozBPQf+KypW9l7SaUMOhsboTiwoUXUzlEnjRQ1bxL5B2/HiCb+eQIBmNKL+/l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 19, 2023 at 12:54:30PM -0400, Dennis Dalessandro wrote:
> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
> 
> In order to handle user SDMA requests where the packet payload is to be
> constructed from memory other than system memory, do user SDMA
> page-pinning through the page-pinning interface. The page-pinning
> interface lets the user SDMA code operate on user_sdma_iovec objects
> without caring which type of memory that iovec's iov.iov_base points to.

What is "other than system memory" memory??

Jason
