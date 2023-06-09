Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75572A109
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 19:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjFIROd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 13:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjFIROb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 13:14:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D711FFE
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 10:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mePJdtxAlDhIkZlfdFpLpRftrJfLP+n4VkIPhwW4hCooK01xDcmYFflABW2WZ3ZCmywNyeQy4Gbt9yqV9DOOLG9AvJFLwUDD4pTQS1fibE3qIBZfU08eR3B1E5mY6SEA2MMbVDmNaGGX/NEyCPQ5FnA/GdCnoarPjPvG8yi5l8wLMLNsAa7gZX3PJxfwashiJ4mf7m/qYfT3m/mnqCqfY4dr+a0D1O5TT0KG2T6RFhXQvNfr9qOR0jIS6fvB8G1cKl6Vt/oXPxJzpniwCsmNwNyQWvGBnM7r8y9YsUcPljSlh2UGiu03ZavqOzXwcZ9mB2+z/UwKJ162dbObsWhyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsd3cnslJsQVfHRwGJD9ZLGMleGunqGNPTJ5772Y+S4=;
 b=ff5/cuorWvC8adVW8jwUFnHJjqwlwgdeQaYejICgBGbW4tt/hAD+TrsG39650UAB5hpScbn2q5ccmYVYs1vsaW2qiDNB1rI69fP+XnWl01TaY6S53XAxGeJXpKE69GXpZnBWfzjDe/K5C5wEZvjHSptq/vQCXMzEzlgj9aNkxrChCQrq7awV1TRJlGjwIecKP4zg82M1mSYk3825Q20cq8dQq5WW0N5sIhOKMymioClEnB6FkQ8+GHKeYvbG2cmNgptk0nNOMbEK0gqS5NbrdI5JxtA7QIGmbEec4WON+dcZ6Zsq3A6ff0HWJOEkj7m4OhX0LXbs+MCNMM/DDTT4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsd3cnslJsQVfHRwGJD9ZLGMleGunqGNPTJ5772Y+S4=;
 b=tH3Ml+/cvsr7vLfCK1IOB9Z3Uv4d9nR952FxQ2wRwFlWlIrutU3stJWQZmWsZkFy2iOvhUN4jknbUdFY1fl7piXjWuk0LKcaTfysRL98Kq9l8Hua0bKw9gZm43z0ShNi1xQdNoyavHD4KAh1OTy/uisoS86A4cteg0WZOzxthNtG+0VQTUqJ9lQabNgBzt+iWWrCMGNYcPKvEya+WmXPXvAeDIxdIc1pY0+ZbKjSCQcH4W4Fs9o8RPRuUxM+ejaCw/1oWqHczCHx2i2CfThSLFO9m2Jf+mUGhP7aex7im5qK8A/JrldESGTppZmn2udKxZViFCBkzPoe2OEDx27ZaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Fri, 9 Jun
 2023 17:14:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:14:26 +0000
Date:   Fri, 9 Jun 2023 14:14:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bryantan@vmware.com
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] RDMA/vmw_pvrdma: Remove unnecessary check on wr->opcode
Message-ID: <ZINd73haYFG3fPmz@nvidia.com>
References: <20230605183728.47021-1-bryantan@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605183728.47021-1-bryantan@vmware.com>
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: fae9d5b0-1af4-46dd-5f69-08db690cfa33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqP2mjTT8cAtIGcWrxi3fVeRwSxrUS7tF3+Q5Dhs3iWlEjCMZDxWmlLpRmT840yajUrWRvQPENtVLQXZLsrwGT4INaNYCsZOsst2bAeflbnQHmh6ZQo0i+Go/qFs28HeDrDAswNBqbeXx15968bFU3+E1AzkrYUdKOKd8k+6V85Wiszpm6gKlZi2/1dHZsuL7x0PChAln/WtBqHkkwO6pwDa+p9ff+G/aUu7At0DtUjqEK/xWj+8R4u+uv//yjroI+MVv0GXwgwooleipUxA+acgWn7o3ImH9CBJWoOScieNMID5B/t/AWJZnKArnaxcM3RlrrM39o9l8Ec9GsVs24k6Ni7CYeuVlhMynOPyEhZUNXHEv61k8WWmBL58uj1UM6iFEoKXZG2vFCXTVSNHczcFMleTTzGkELUj4MhR1bNwjqn8y0CRSmTSOBlCr/sUnQvhPu/7kaut7ThAvqeiinJzxx0rzaTokQ+je0lgwQHNiiP5PBPUCBKHLRfV9q5rFBQ9miinjBWfZ4JTi1AsWViMSEcdBViAgCqOVU0ynbJ/k3FzDZnSmgeQ3rJkudTH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(478600001)(38100700002)(36756003)(4326008)(6916009)(66556008)(6666004)(66476007)(66946007)(86362001)(6486002)(316002)(4744005)(2906002)(41300700001)(186003)(2616005)(8936002)(8676002)(26005)(6506007)(6512007)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BtKNNAuQoFGEC5aDmM/4RcPpF5sLzILNudvbb+fRCtUL9VrfrdoQ7fI/RNA3?=
 =?us-ascii?Q?e787DzFQHO9ytmTSnDykf7QhH4ZRvQkeEUjXocgtIGDI4ZQX35VeP+EZst5z?=
 =?us-ascii?Q?mGmdDiHG46lPsZHlebtSeYLl+6R4hxojx+ocJVMK1MaXvxDpEejHMkk+AIVK?=
 =?us-ascii?Q?SZ+TBQD2qz/w93RDlIe5/FZfFxHZkcbWfqWrLO0SUqTNMY6maEbpAK45i268?=
 =?us-ascii?Q?/CEcgonTnTAvD4of7B6Af+RhnLaq+1Z5dVUIrdxEgO9/C7NDPm+U9p1c/i+V?=
 =?us-ascii?Q?p74qMO/WVOInvC6cXktJccOhydDlgqg5TqwAvwILHN1+DdwzExhmPq8IodgN?=
 =?us-ascii?Q?HkztVN3SY5WdlHRa4dd3tKTMcq7jtMhS6YzoLKoN9UU3t2rvroqHQBlMPyrd?=
 =?us-ascii?Q?N0L3Kpcc52RQL787nL4jq/fvXBanWCPU21Du+9VR1gMmKwWAQfuAblAMS4WF?=
 =?us-ascii?Q?54DjLp4ZpVdZKrC4/46pneoVJNSqpsiym5k6TJLf9huKFXjG2KV63XFp1i0I?=
 =?us-ascii?Q?lfvAiKFt77UVPhUl6Ad0ASbuhwK5VNpaABaIVJdDSu1E8kSIlxgoDaO0gD7N?=
 =?us-ascii?Q?HdEYYUIjz3i+wMAtk9QrnzU0tCWvRpHdaHj94ZD3KF6atVXSs+lqe1JB2QA2?=
 =?us-ascii?Q?NxvaokKA+7RtxYlKF1XujcMXmh0KdqqTe4kA15nURKJsLkdflBazUqFrPbRI?=
 =?us-ascii?Q?yrHNrsVIjY0I0IG1mz05UHM7R8GpJPhY2+vlhCkXxceCLoNYsT2NOzZ3n8GB?=
 =?us-ascii?Q?U/a8svwerTWE0Xu1gxFZmZ/f+nCJ7pcc9SbCtRd83bnSGXctKUPumuJC3mjn?=
 =?us-ascii?Q?PEF6yAJd8uyXbEXlaXtE09xJBmZYj9k9rzNOR8tsfXC9q2kdmsJOe4S4Q/AU?=
 =?us-ascii?Q?PXlJC4XCwo07WfIG153R6rnklXfTdIVG2LkDyvWKhlHr+Z3IK3wb/KeOcZMu?=
 =?us-ascii?Q?Dad+IPB7PdJubTG87ETKn5p6bWb3TEtVg5xIAk/FsbO6UFXUJ2bt2rQ1obwY?=
 =?us-ascii?Q?OpznyjyXelMphwbJmTAuW6ztZQhpnLGZxkvsACGSrBuPRSArrakQ+UPJG+vk?=
 =?us-ascii?Q?pn0BSnfCDVyBqm6IGkfDp5PxEfbimp8fAFjibeFYOA3qWmEJPW32Fv+tlWBW?=
 =?us-ascii?Q?lJrpSaAEnTuT+MuEqbPfRtG/XYc8i97iZilQzYb/7qpeg0FNNp9BSVqb+Ym0?=
 =?us-ascii?Q?8hywF8OR1S2Trw11ShTsmqE0FDk/qga2E26FBSenoGPbZJNeJJKGGj2L0OoU?=
 =?us-ascii?Q?6eWgKipQ0dq+7aQiFWorNXZbkbcn71kU7G9yUFplU9ZxYj6JH0WRfzUbrL2J?=
 =?us-ascii?Q?JDJuPSsFJyL0UVnlpzqkg04D3JxR7qrhPTMMNKgz2rCzY8RHt+SEKLY3fcBf?=
 =?us-ascii?Q?DvRMCYOl3Hlf0ZkRoPX2xprSz+eMqetOq05u//9z7L6NUoulknzJGrT3Zw10?=
 =?us-ascii?Q?vNEQKHULKy2WqupJq5anB4aZTifnPjhmCPHSBnktMVm/GnPRE9wMOXEr0E3j?=
 =?us-ascii?Q?6iUUYRwSoOKK5XmjWnryX3CGEH93cIjmwy9gggzqT0oaYMmPDVsF/LyFWmSg?=
 =?us-ascii?Q?q5+ShLrSRBCd/mULPHmECerSFEQtJxGnpEyFAiyz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae9d5b0-1af4-46dd-5f69-08db690cfa33
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 17:14:26.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BNqM+WGp3ngAPXXYlMRwYrf/YTMYpSslycY0EOAG7RFMT2ARJXs7RR+ecNOD8iY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 05, 2023 at 11:37:28AM -0700, bryantan@vmware.com wrote:
> From: Bryan Tan <bryantan@vmware.com>
> 
> wr->opcode is unsigned; checking if it is negative is unnecessary.
> Fix this issue by removing the check.
> 
> Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Bryan Tan <bryantan@vmware.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to for-next, thanks

Jason
