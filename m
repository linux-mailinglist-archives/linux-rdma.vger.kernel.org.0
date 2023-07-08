Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5574BDE4
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jul 2023 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGHOlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jul 2023 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOlG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jul 2023 10:41:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B747E56;
        Sat,  8 Jul 2023 07:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEV2WhcNBxfD8RQBijYQCVhO5Ms+y9FUC8e0EaXtY/WQ+B3+BA7uS+4ApPYDdl3OSZAe7tDtTY54sq/dxAdtgudk/gRkld5mtmPAOXxUUeCCiKKEXvxJ1qVusU/wzCAz4iaRHcTzyamjAZ89aa+0I+cvM/9tfKHOkodWiSOtf+4fmvOzSTLI2LILElPx7DUtba2udYqYOH9eQm0ifxbckYpXfovrVS5HD99YEBJpQEqQkvtlIZYeGVtokJtkEr9RfFBnAQlvU4oIMDbPRsw+9M8KLau3lVqw5nB2WolJEercoT6VP23ztfPYmHIa8HRmM4cL9eyqcTZ5IBCtOTBg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07soXHt3udxMBAbxK4EmxdLa3rwEbwKpp7JnjcF71bc=;
 b=odufn5a/g/ISMXrjuQgFlsCdpG9CR+Q0BCk9F1Pwg3CC2CqHLS0N1EV1mzthi4arrHtVTDdBqQ9bL9I/kbMyBprvllPNBAF2QExlqfuZ5On5Mcp34WV2U/yODTV4XhbcMKa9HK80ut3DC9RoVyCEAtihq3JE+1nmp9liz+ZvNZUPgFv2uvg1Tl7KNZUqf84YPrAT7rGZXsQ6bZG9rdrfIEj6a70Fe7lnm2caB/v5A8aUbASyKAxHNtVUk0Z6iPAWAFh7rPasM7BYkg2Cjle/TuS5rLaeySptXO6aBFnvvuYcP0jI7w+zt0i5i2dh2p2wfD0dTveTWMHjYpEtfkzmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07soXHt3udxMBAbxK4EmxdLa3rwEbwKpp7JnjcF71bc=;
 b=Kc4/ow3JqMewAQfIU84yg+NGYA8WKK+ywlvQR68EWcXyE9+HKhx1awOJbMul0r8GOnDHLcgpkETyT+TpdQ13QodntbpeCgSZU4rRX9Tz6ktatogPdj/Bjk442diiJ3Y5/juyZfrPbjkWbsPZ8JOD+YI21d/SREjOkhh4Y9iMpsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5409.namprd13.prod.outlook.com (2603:10b6:303:181::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 14:40:59 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 14:40:59 +0000
Date:   Sat, 8 Jul 2023 15:40:50 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
        tariqt@nvidia.com, lkayal@nvidia.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH net] net/mlx5: fix potential memory leak in
 mlx5e_init_rep_rx
Message-ID: <ZKl1cgLB5mLXB/R7@corigine.com>
References: <20230708071307.149100-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708071307.149100-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: LO4P123CA0666.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: f1afbc8a-8e5f-411e-5141-08db7fc15875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHFRUbPpVahh8jmylnvytwQykADw0I1v7w4cpR0flMkMH0+g/eXIdqT8ELfxyl8b78CmZWP3Y0ZiqweX8ahSHsJwUpf3qoeRHFQ1c2KdMTyspF6nvJn2vOjEbMUvRCP3/r9bFCObpT9OYC/5nOQhep6NwwT2gkKnHZ9aBEo9e9IMuvTVKPZzz+iGLIl0N8GgV5Gz3W3w63QYlfUWP+HV+PsEViBOLnHVM7pXwTrMjy0fVrXhnm+ZkdbZ15gS16Ia9oFlmn8bLkO/gkcNmOz2NM0NKTDk3TJPVXGyL6TGbKHc4xM9q2HknCpkw6Z5aOEal2WZA0MgpmUBk99wzu2IXi+41N7QgbGNrOjnOTAPcSp+J0sCVApLh3dcYMztaWmr+2kkbNLMh83oVpIZSRBKiWjzfyC10UUsTQGCYuVBTWYxweYXKC3DaYddtL1Qi5ViQT2cB54vstT0qt2D6c7m6v6HWCRV/4TYNcHcSigq3ij81lKxmfWc56w55NSWI4i5XXc1yoda+c+8D49n+O1Vl59esCamxmKSFRj8FX0Wl/Uebe+VGARJzxW7QvWlqWsDskHs9q1xhAn+/yhvVuvYMSFEVbI2ixjI0vadFj/pzdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(396003)(346002)(366004)(376002)(136003)(451199021)(2906002)(6666004)(478600001)(6486002)(44832011)(8676002)(4744005)(36756003)(7416002)(6916009)(316002)(41300700001)(66556008)(66946007)(66476007)(8936002)(4326008)(6512007)(38100700002)(5660300002)(6506007)(86362001)(186003)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHq+XhK3CpoKqbFQLubECrNxXVZ3h8cLNEFF9vVzzzojpJpAdTdPzgCLolM8?=
 =?us-ascii?Q?U7y4ESizzxfzBdbaj9rzSQEfwyNwLDYTWMmAoSQBVB5z4+FQgVH03oLigJND?=
 =?us-ascii?Q?iiaXFdCc2VGmRk6RFI7pJKlunkHh34zNG5225mcmuB7GhGI0EG1VTRQ7BGl/?=
 =?us-ascii?Q?Yo83sN9DhCCN82y1gnETGizQhqUfI26TgGMPv3tdR+BlWTxyyQQHZFbIpxdk?=
 =?us-ascii?Q?Y7zQrSsuxLmtrwZiGVi7LQQ8ghANvZlD8bJamHseAR9ko9PXfBVViBMxvmk/?=
 =?us-ascii?Q?0bAm1Cz0BQHw70f3Cx2KVnXOzacraFduboNd4FlX2ES9etgCS3DoL4+eGGxz?=
 =?us-ascii?Q?+EaKe8D/yXQOTYLVnxsy1qkwRx3DQe2e4+k7hscTHkglgCRlrYfl8pY77/+7?=
 =?us-ascii?Q?iFaU7kK3HgxiWvyR/IE9vhKm8bEZK22HKeNXwE7ZiEZ28scqSf2iqNOybWZg?=
 =?us-ascii?Q?5qonAIZxEWaSkdAGh6HhaAEP7hqeAriEfg6LGGG5ohx0O7ieTpBIM4DI8BrH?=
 =?us-ascii?Q?ma5+K++wpJENEwKUmjgsxmgKEpwgDy8SUwj1Q6THMXiRKnODorsQHB3Q93hS?=
 =?us-ascii?Q?f367ACgPlWM2rVqtLPE1sTFlJq45kdrXbi1aODv2G5+xPPD050i4WSgcMuCH?=
 =?us-ascii?Q?z6moy3Kadb37LgZWibcaejD1jKRSlXWJhGScuzoTSkbs4nTYOG21zdatnsR+?=
 =?us-ascii?Q?2TXZ849wlvZegBL0keLTs1Ekx9bl+BqbyTHCtdG2aE61Ouq2ohaCzQ0ziTvz?=
 =?us-ascii?Q?wmp4lQXrVemS/TGKErX7HeweN9i4PcuOyGjPiQByjCBPd1eavSP9kzXVGU2o?=
 =?us-ascii?Q?Lvxgnbcx7EmrffVmgR0ziGEytDEFUbmdJ9a1ooIwgpH8s70jM2TM9CKk3ySk?=
 =?us-ascii?Q?L3AONWpkT8LNCvnMMVNNsj4e4aCMg8nDnUK+y0oGhoRGlJOHeBx9snaXAJIc?=
 =?us-ascii?Q?xobGREu6kTlyk1vrDXhj0ONX5ACbGcHKjmW5QVpVWp+4RUUcd8DWmNXNhtqS?=
 =?us-ascii?Q?nGJnYrr3vFOjlmkknS9/ii5nQ83GSgfXZcOW8HO9n8xEc4cQDskNhb55EVgJ?=
 =?us-ascii?Q?NE1GSBycPCe+MwN4lsPcYKVpIRbl5ZxmgvmSKboYDQLJeNAkWffVWJnkjx2V?=
 =?us-ascii?Q?pzriUFGWnPhtQ/mLhfzK4FJFK7QAwTwlXPYfTDwjHGS/SpLi9k+MG1fZ/aKa?=
 =?us-ascii?Q?lexw1+E/mcNUcr5s1UlZqsf3xk3dZp96d0nk/Zqesrg7HRxFFCqu+quvsnqz?=
 =?us-ascii?Q?0VWqVik4+pdMeDk8fLdl9zXsi79XCy5GNYbJaZUw04k3H78DLEnuTJ+zPfCa?=
 =?us-ascii?Q?1eSm7XDg93lcE+5tmgMQidAGmVs22ZcYvpUaLpjfrPPM0zhLkDKOfR4VG9ed?=
 =?us-ascii?Q?1FKxtBXPr5xY2TVU6txLnYsAAaLbXIAOq/7SZvK4fWw0P9OiV1LBCe+AQlqd?=
 =?us-ascii?Q?5RXwBYZQnYWsurvWNhd0tysrip01oqPrMmQLSbjzLvpuvhUm2HpehlyTAzwa?=
 =?us-ascii?Q?aRiMYKDumckc8xHK26l+E/lGBnJqOofhvFexAwHMaCkz+VdZUJeL5oe0QxhP?=
 =?us-ascii?Q?mPyBWszkFz/Mjg43tJOW2ZQHRlQsnhK8ZUOPpAGR2t37V3IO4tC2Vv2/Tki9?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1afbc8a-8e5f-411e-5141-08db7fc15875
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 14:40:59.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTn4bXOt5tWC6TNKJllx23fG59W4kdrIg+YGsJvRMWmsRfrX3fD9iVT90o3NXV/lWR7/NcT38jodznjCFXgoyMVSRwlE/kALlb9FeExJ06M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5409
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[Correct lkayal@nvidia.com email address]

On Sat, Jul 08, 2023 at 03:13:07PM +0800, Zhengchao Shao wrote:
> The memory pointed to by the priv->rx_res pointer is not freed in the error
> path of mlx5e_init_rep_rx, which can lead to a memory leak. Fix by freeing
> the memory in the error path, thereby making the error path identical to
> mlx5e_cleanup_rep_rx().
> 
> Fixes: af8bbf730068 ("net/mlx5e: Convert mlx5e_flow_steering member of mlx5e_priv to pointer")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

