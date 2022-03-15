Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC44D9105
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 01:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiCOAPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 20:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiCOAPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 20:15:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCE338BF6;
        Mon, 14 Mar 2022 17:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c712xNsUS6VVvdKtaFCnh83XNa1obu5CzkQq+T5gNvwZuLQ+2gpSJ6uqmZklE4FgBs814d+1KL2/aVzuRGPdUUiyG2kCioef5Tg0L5fHODdG+wWDiyKOSwa/UIiTFsaVMzufZKUgfd9EVDCk8wZSqKyGMqYczhXAuQZXqWja2k4OulAxxtm9Rx7drP7O7//Jh+GH3JejkDHwCz0GSUTOh5MVNz2WnZqrZl2yrRZSZH+GngIVx92AzuRGfzhuxNrS7/hS6Ywno90Vu5HDkKxKHzv0dHWwNH6URiZiv5+0BkXIUviPkhKAmsdjvoZ5FUqE3V0H+KWHHCc3lp4mfsXJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zUDBSegMOe2hKxVmlcEYwoOnOHFklUabhba28gZg9I=;
 b=TI9ZOqlFn11PAyiZvem1qfHeBZWv+oRdEz8YibbdKuYRaWLBlSHy+bY9ADL+xFC5kOMD3xycPqrIpiHEsoLRzgXqIInJYyiRqohajvmG1263e70mX6lzUA8JQJKxfln7PVcjoRU5redTZCK5X19LhFiEQZg1d1n1QqqBfvn9j032VFmqgrKofhlOM0kuGVAJIBwHKzzGwF6jacZzOeLrqKqng0ELiMi3Xe1+6EDh3rtmYPSWAo6mjCVudDzyu6qkFbek80+pdiWOwbqqjXQSPn5LJc9WArQMYzefNiP09hmaBrJkg2wTtjogR8+TO9+Y9s1B8GL3EpVNq4dbShIaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zUDBSegMOe2hKxVmlcEYwoOnOHFklUabhba28gZg9I=;
 b=uMBadZ6Ud5ICxhhMu4Kn1pUVIFRKHw5bj05TebOU607vtGpT6YZVyrT9JlwgA1EnTZWG4RPFhY+kvUl4eXjPnsHumKWOOYRhWB7Slpg704F5ZwLrQU7sRIUqz3dcRvI/e28LAu1zAWKbTuUYiBmbF01KXIg7hj+H3P4Th7J4Ypynoydgw9zqFwx3fVsOCdBhqeFBAVpO3THpG4Q5KQG5eEblG8s02xpo00donskwrBMIQyhuwPp1zPedvszsIyd2DpFZr7Rqi0VZ0pDTm6oaEJ12KQfdLKNA2doETKKdW/I1vm+QalH5Bxqj/LVr5yt6Kxsc18YGHcNVUgVFtT8chA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4796.namprd12.prod.outlook.com (2603:10b6:5:16a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 00:14:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 00:14:05 +0000
Date:   Mon, 14 Mar 2022 21:14:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        kernel-janitors@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/30] RDMA/hw/qib/qib_iba7220: fix typos in comments
Message-ID: <20220315001403.GA182180@nvidia.com>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
 <20220314115354.144023-23-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314115354.144023-23-Julia.Lawall@inria.fr>
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427e79e8-ede3-4443-51e8-08da0618b72a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4796:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4796DD40409A7292B2B7BCCFC2109@DM6PR12MB4796.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y925x4FWV8+fzlxygE+HioJcwn2bk9clE2C2Wrw2Qq/jeSNLD4EUkT1tbsFeKIirmoTtJS/gD1GGXzcJQUzq6NSmhFP5i/b6bsSmSqCyerwi5VVMnDclHEFstik1Ouc+tdODY7jy+YcLdEB+3D9WKOthUy2Lncqw7sL4gWS1tea3Vy238syDXY8L8tsPYnUKUn9mWdWx2Ohf1kiCClpfiLKwMXtoH4ssNLxBelNkUbAk7Yhg1rom+V5nfhFYnjqd8juI/mBrEm0Q03L8RdGD3viJKDnDsgl2yUNpY6SPGaT5H47S08f0rkjkKJ6zP7SW8WcNfxtGY/9fNfq9C3egiXM2nyzSgQOkav/2HGj1Y0yGYsm7mSaWHBBefpnnry0qDVNgCc+TrH8+c15nkDL8a2o0v99i98ZQsCLx1XWNHLqJVf5QY2VI358+9M2rXsV1tRQRGlpeVqG7qu7Bg724CJMAcG0BFT/2d3A/oKTPtjz//hgEVAxnyDJBt4RNY51o74BNsIOdtkvRoa6VL1ZHeXkM3Yz88ifgBV9BWFGUbbB0IN17osk9G/+dx0QzWFuWX//JXYAFiFB1cjsycqOHUxS6YP95+ZktXwHJ7UNvUarDDiZc4wZ1qw9m7JE9cn1z1qswfsJY1xl1muyT42ERxFlHRDecznktdOaC99sd51q15Ts7rA7h6PMeDIgiHVC7iMYTqBricpLYFZlF0R4dmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(2616005)(6512007)(5660300002)(2906002)(4744005)(33656002)(8936002)(36756003)(86362001)(66556008)(66946007)(66476007)(38100700002)(508600001)(6486002)(4326008)(186003)(1076003)(26005)(316002)(54906003)(6916009)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pM2CUEUCbSQkP7IHY9E98FRCZLJmmvcTweYckca0sl3Wk+6kbQ7DugyVc1DR?=
 =?us-ascii?Q?kmL2F+cuJarQNo7tp+/lQg4bzAONieDXceW7dkMnlfbVES/NLOR9edaq8IVS?=
 =?us-ascii?Q?MXNxP8fJQltJgFeF5ezVSms+gcO3ffOPHW1cKw0FPVv97voRCMZSg98HNh05?=
 =?us-ascii?Q?gZXAASG4/od3SoXyjuyEHvFVMmk7jIyb8ENoW9MVdPh0uEkICCmJF1HDPF/p?=
 =?us-ascii?Q?G6xgvaDD7Q+o9N6JRKT84QRTTFgG+Umncej2XzCR4vu0YFZdt0q3f6bv9Q0v?=
 =?us-ascii?Q?Yj4w26VB1YvHpw9/x59EABxoakY47Pa4x1DfOVwJ1LOL7Tlkec5dp34ahZFK?=
 =?us-ascii?Q?FITwz4sDtA3cvGmjBJrVWU3DrzWPpr+gfNuMJAnVuw1KhAoEsxZwTFFnx3/o?=
 =?us-ascii?Q?KSV926dPR1/1v2LMBp4fyvQaRFJaBsXCYvH+ZpacFt2zQDlzEkqGtp50jvIh?=
 =?us-ascii?Q?aR1HIhLOA1h1JtbLnInt0olSUutyx7F2x0K5Uq3Hc77qXLDcK1o0ezRTsUm3?=
 =?us-ascii?Q?7E0RlpjFaL9IwDxchYB0kSD+DutthqlkM1Qp940omp9QieCRmNn2kgu7SNTS?=
 =?us-ascii?Q?8B22RxE4gOf7HUtddEyRMX+hDInJ6qjZcYufoLZ+81BZKtpZ/AeDFwriZHR1?=
 =?us-ascii?Q?eKpMS2N99mTsAlHKjdRVPIIincTlEsoyn8StxCZkHDPw3LmYzjQqP4/bFIr6?=
 =?us-ascii?Q?OAnKsZa4gFaI3DwnE5wl+1D+Ey+zdyWWh26hQ4KH+ql6EGLaByXINECR+aoU?=
 =?us-ascii?Q?9ZUDy5Nr1GL+KosDxloDKbogUh8RZeiZSA5VQ2CTXlNU7aaSXqVhPPQ5QmmV?=
 =?us-ascii?Q?boodXQ4NApGpvjFBRyeFJORczwGcU6nHpTCihyyBxsgRau73ikR6m4Vy9fjp?=
 =?us-ascii?Q?mCoQKeSUSLQ3l5qNI86ZBni2+mwU4sIlH7x5QJG+3u0K3/l1ZLSKB+JomNFc?=
 =?us-ascii?Q?OslzSxTU3MR7AD2nSoAdfJ/ciOLTR7lNorxW+uAkf/BA/B9/A4ni+zNjJcBt?=
 =?us-ascii?Q?AgrA0+Vvz8SFchoHJDMc6bLFW/QKlSHaG+Sd70whzs3Ok7NR2evoWP0KN9Je?=
 =?us-ascii?Q?w+92A4ijI+aSZnVJNzhrXMECVzp87o6Uw0LOOZjD3Fbef3cpLW74NZeVwJIA?=
 =?us-ascii?Q?Or2hMevyG74N8K9XmRuw6iArpeW/bBN3omLt6GFv5hZTFYAHwshsK1KcO2YO?=
 =?us-ascii?Q?72xS3Od2SBYbFH6mnn9V6hm5nH5yKteulEprVOuV7Qsv4DsQ/Uj5QuJMAz8Q?=
 =?us-ascii?Q?I6Dq1Vl9jzg9igpenb2ZvLz5Rr9e51aqfv6Bq9WCYqPwnK9lPZZ7nzlzypgL?=
 =?us-ascii?Q?hfeTVbjoJAQSwwIYKxQmlytn17AV/ZpGZDmImU5CYCzqI2IknY9IqK4bHaY+?=
 =?us-ascii?Q?+PcwOAdki7PKvirEaSuQWQvipI66i2Ei+FslhSLVaWxAkH5JlstrEBoUWiR9?=
 =?us-ascii?Q?WWArJsPs3ZEU+ls4f7L8NcHvaqfLsvrN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e79e8-ede3-4443-51e8-08da0618b72a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 00:14:05.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4kFfWA+6nOaIlTWy8x8/+/oPEmCQeBseLYuNNlZ8J6DI+foCaT8QxQKg93UQU/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4796
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 14, 2022 at 12:53:46PM +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---
>  drivers/infiniband/hw/qib/qib_iba7220.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to rdma for-next, thanks

Jason
