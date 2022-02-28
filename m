Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB74C718C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 17:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiB1QQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 11:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiB1QQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 11:16:24 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F6D47066
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 08:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVSfyUU0ZwFBHNgr/qF68OP4eYEukOAfYWWvPs1Ap3dycwYd/zNC9uXSOVAp93vDRZmgl0B3I2EdiOhnhZJM+j2L7rJPGNuQAmXTmhx7f/AZ+1GTGFYwpLnJ+DLFStbQCrbgIStcaaSdNmmZF6i2iU7bPzT1rXyLG7m3r6o1dm0ytUEyZZ+w/tTQ0J6pmqYTtcHpUgPnaaIRN9DIz+TZIyxeRoAvMRBOmo/KaZmS/uyYkQkrLNdy1ob4pznUqDJ+kOTgrYUF/u8ajLY8tO80vaBibVh2VTUXmWOyGglUXFk3f2jsy9aOt2gANW7gSG99DhVGzeoiil8pArqj2vXnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xdAfWlPydtG38VAfuB1gyyp7W7Rwx/AJzSs7wLuGro=;
 b=jgiu4TV/V8ap9sbxQAgihwpTQqy0tD9yfCIILywS3tuduzR05dhpK6O0w6z2Cn8SgLmgf9zKQQAFSPGZswXdnC7DI2OV8rcixqk2p4cgKOCLXmw/SCAeuwcYAqepKL/g2Gp3ycJh3gG0A72AdlSw17ItuxbPyaGMiHQ8cYrHwrmL7VjMDVGU1qUvQRQpS9L6Ye92WVcosJ3jzreFkALY3R2yCJNmQFojWyH5fs9dUpRcZeEaBofFgxbZogFIYki1rStYlX82GDWDonQHMQI6PYgFQRh9kH/nwu+1usLGkmIIfJQkhl0rMOnt6d4WgfJib68xm0UAtusqVVp69cXvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xdAfWlPydtG38VAfuB1gyyp7W7Rwx/AJzSs7wLuGro=;
 b=bnpnjmNtFWPMtuhyeB7Lekfw75n8pdlc0ZPYNfwVvInuNktdBnPLjPrUhtLvChIXQY5aTS0C+K1e2Xb4XqxA9VYiHSRaOebwXr88Q46SUv146UFPQI8lB4zlJQMGTzICkzMbmjr4/wOdLPlsqgDfuYus3SAHlpWK316idjb6pUJtV4BBatpZvblhsWAOx3uE/uxJyB89wAQaZc/2n21u4cwo/GUZsAE1gYOhCPrah4LGpNZ1hMythcLXwm/aDaQS8iz5KSwr9Al44GQ1irGDtyKcwHTWEgvNkLcYA/ygRcE9U+1sDGuPZWj7hG6t7p181nV3DWgPn0oJlzpKUAEPBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 16:15:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 16:15:43 +0000
Date:   Mon, 28 Feb 2022 12:15:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1 0/3] irdma driver updates
Message-ID: <20220228161542.GA601173@nvidia.com>
References: <20220225163211.127-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225163211.127-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42af6c88-a135-40ad-3bfa-08d9fad59224
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157E507D73C6997601442ADC2019@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjTPNCUOU6iCG3sUDuIOnDroFQx5/dNPjy8CCXmtZTrn2hNpuYz+PXBdViaqZEX6j8gfWiEW3+s/guvkkiuyk8ZPr/FyX65MOtbyBlj3WUJjWqqLaGJjfuMBzqbhmtmiptlJbGEwcMbmpWMzlkRe4OFCyDiZpAZduG6pFj7cbONnSwTW6qlca1PPh1G7qv2vtZeN21xeKh6H3FDt3WLf58KB18UE3KYxaegHmUfvS6G8Li/cmzCzWq9XwXV+midWXBLwKJL9wZOFoYcdy8Z9KobBMDuYJgkmnF0KTnrRmRxCOCI+xCZNM15U2HtN6maGAVbbq3ayfTaxa57pgO9LVY9yZyWrvyGU3bUH0y0xs+cX7N0q05c8UNEM71bfRv1saAkzBmh86R4CBbRffmcyhgvbPGuFEZLx+wz10w5cTAqKvJWzBGFwBVwZ3l/nUv0Oc04eNFFs8/BKpQ73OXQp6VQD6FEANGkQ3+yDqhlZWz7M8yi3yf0UOw93Y3H63GDZg5FZVwzWnFUUVftY6MY/eNoxww9jKG77+hLTlCubRsf2489D5oOEU6ydinkEHZqSSDtac2snsMyicnygWy5eCzPuBnzt4GUhtrMzkd1VHcXh3QGT0jbhn9gl78dL9oMauD1ONbIXS/xWX/rk3DLB7kICddZ9GeqP49aYaLzEgKDBGeRyrkqFNcm8FctTrbA2kcr23/otQ+BqO6rfDAdPhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(66946007)(6916009)(15650500001)(33656002)(186003)(4744005)(66556008)(38100700002)(8676002)(4326008)(5660300002)(8936002)(2906002)(86362001)(66476007)(6512007)(6506007)(1076003)(2616005)(83380400001)(26005)(6486002)(36756003)(508600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPg4hkDdDSaLV+MkVXu+AUEr4M65Q84ch02YfKNbiNrqWEJzFdDXyiho+Opl?=
 =?us-ascii?Q?+G4vmvl+6fxpctwHJ5VvqHzjiLAxfIHqZlMH83jd+aGKntoD8ultiYnVFVO0?=
 =?us-ascii?Q?wvD8P169kEJTm/acV/SBG9cV5KOCjYM/3Q/AEhzfa7dV7Uan8bQJRRLkeAlr?=
 =?us-ascii?Q?phMbhVR8y/PiAonoAelaECHGkc7MQnJ6/C8Mx5t78Rn7hJotqooF2NqA09ND?=
 =?us-ascii?Q?6i6AAuExFNKn53kHwETklodUt1PO9qGuZu7VidmqaBYiB3oclF5E3WuZUIdN?=
 =?us-ascii?Q?p7ekOLGLQHCaKt+Tn8rdgbSfuxrjtxOPNT7juguirwj8ff+V1vMS881om4F6?=
 =?us-ascii?Q?TBwYg5Xss0uNymgjgwZWNhFex/jDeySFYW9mARG1gKScG9zylvqnEhDOezku?=
 =?us-ascii?Q?NShw6ang5VNV1qZ9MPan2O8It6AAQvuQizvB47gcdgRV2vfTJGVQ567O6nyv?=
 =?us-ascii?Q?UXS+a4HgOqzyOus4r521ToKPNKSVeExxaxYwRZwAsyAIk7WxNiIqzE5tGnJH?=
 =?us-ascii?Q?kIXR5s/aAyQqoTnTSCah1tptT3LSeepE8fAUhUjUZjPIrjZeXKTaGG6BNl5n?=
 =?us-ascii?Q?9LUki2ZanhA83tSCragJRlTTzuC3DYFsVLpaoNjqDNu9eL8IU+ZUciCLt2Wt?=
 =?us-ascii?Q?nU0T/uk/168PU2Vku36cgVmwQtHeV7MPQYAz6Mtb/DuJXxleEiy3VP2XN+oj?=
 =?us-ascii?Q?WieoocQuMIWEzU1Jx1C6ZI+B4fDUAAvfFV2pSsJSlLyjHiyBTEUhOyAx/cv4?=
 =?us-ascii?Q?gbn+P0SBC2Z0rulsvaHkCSAhcAiRs4lxR2YQurxldoXaE3DyPalrMQ2Ge+5p?=
 =?us-ascii?Q?ZbXoyUTzZCfDinXJXvVeE4danDPCpXxQd/UAVSO6TWtxHCLQZmXbcZY/PM6j?=
 =?us-ascii?Q?7w1yX1q1qfPb4CsKdAIQ6tNL6Adz58jRx6nFEirWqmrojtagvJTChrO4OrLL?=
 =?us-ascii?Q?dkV7NSj/zZePHR7a+oMhLsc1HMtOEzxcf9CoMcLvrMk+IlqgzB0aYLPrjYAj?=
 =?us-ascii?Q?ke1DvAtFfznA6np4sSYKUvHSrtWAdDUhCDcCSCYCkk8bqiaKFsYpwRE8ZBeC?=
 =?us-ascii?Q?r6JmoX3uDITLI3cf8pmdoSv4arzWFfOBEaM2PT+swqLfan51MAcPKn/a9+Vx?=
 =?us-ascii?Q?12xBB/r8oRAyrzSs2hTWf6TDzg5wr7sdyI8I/ex/S/OGHHlvZdWUVE7HyCtj?=
 =?us-ascii?Q?J7taUNnvHrabe22atV3SXJBbQMLMDr5uzYEohAtl1hBwL8p3UgUHLtT8Xc75?=
 =?us-ascii?Q?Oq+6/zDutEYoQgKYI5bW9w4yaCEwz/R1GrLAGzH3fcfDVE6PRCSt2wetKaHu?=
 =?us-ascii?Q?pY8FDSCUa2fcdHoOOpsahfMj5dR+qxjSfRdtctnN0KiZBeWclXpSi5v1dGJK?=
 =?us-ascii?Q?M0MLTE1WskVWfNFpgj4FIZu9pcCoJEZJnOUaAs8DRVsa7w0fJUhhqdTnGM8m?=
 =?us-ascii?Q?r1IqhWCragxQSVExtZwHDwDWlc61f9bv51A63mzWVyg3z800ryQRX9rCrLOq?=
 =?us-ascii?Q?XNaOWQ01iEX4/Ve4g75ykpxyCHEJH+yqGVQlnbIv4g+4gSR7FcBxv/16vuI4?=
 =?us-ascii?Q?NGd4by66DMcIPSh7p9w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42af6c88-a135-40ad-3bfa-08d9fad59224
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:15:43.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAi9Q9hVfK7U6OWxubXzhmXu+27sG1O20wxx/zy1pZDcmpYJZ60kurYnrOEL1cUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 10:32:08AM -0600, Shiraz Saleem wrote:
> This series contains a set of irdma bug fixes for 5.17 cycle.
> 
> v0-->v1: Use rdma_vlan_dev_real_dev in Patch #1
> 
> Mustafa Ismail (3):
>   RDMA/irdma: Fix netdev notifications for vlan's
>   RDMA/irdma: Fix Passthrough mode in VM
>   RDMA/irdma: Remove incorrect masking of PD

Applied to for-next 

There probably won't be another -rc, and these commit messages are not
detailed enough for this late in the rc cycle.

Thanks,
Jason
