Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51C371F101
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjFARmt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFARms (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 13:42:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67413D
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 10:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7SggVxGt0NAWIYl65iWnQqgaohcKNdMycSr0Vd5yD2Dh7O2zcN1KX0RBMe2NGODhehGr+uaCPqr1ax30Anew9nrFwBuo2DH8Hg3yNUoroWaCsX0ySURnccPITDUw5s1sFU9bv1Vv0vFURZ5oBa3uhRz0TrfS+M1YoKbYAnUhZrN5cxxaoERfl+Zn0TJZ5mygLlUIulkzgiuT3K6oK2vUxxTd6uDhbOlJV25dQplRqXNrVleSpPtGeFCklGeeGOvWjBp6pMQXSd3G6ejE+QiueQySSt38fDaqGqiB8KrSGJHff1++FCNwide6YB4qK+A63woefzJijkHvyvxY34J0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eaXdK4g2FQ6PGaFg7LPKDJP6EOhn1P+H+qqsR7xozk=;
 b=U8VuPUHyjCHjKBw0vvpFrIoc/QjdNmhwPA4yb7UDB4lpDSNTSTliIZGjgpXGzTZhqCQg//83J/Hu/L6QnGYT66Yqgsb3gU8gf3GpJI4Z5nTW8J0wBdbUe99LF8hlAJJRDXDVDG/fVajyYhDn1bBmkoKExfEr437rf7R0tXfx23bun8Fk9G7rHQi7NaKMskI8dPq8ERo3Vu0lgIKv2icyBHPqJVGkCExO0r4v4AojTWfLcs2UYUEzyQxiLzMwoURQtpE1KhMJYf9h0l1+12Phgsy8uPPi4IRHMKYvQOUYdaXGaAvBHIlii1ZdgKmCFnbPwZg+jb3X+AaW1YdpulUg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eaXdK4g2FQ6PGaFg7LPKDJP6EOhn1P+H+qqsR7xozk=;
 b=c7CnnZoCwFTGDvze3TSRggIMAKrUiTTrVEwvgQ7czH/qJcaddmEddHAoaL9ezGVRX+7gX7q/pS/dM/wrCeuHcvaoX9ydEd5QWa3sy00Kk7dbp0KY4BE774ZKZK8dVKdJrooEHi3w6MVIdzD4Jr2X2fHbubNByQbjoM8qkuF2Yk/q31v97wV33bK8I2SND7lTfc4LLUaQiVohpRhHkoTd5hez0entOrGaIYvdkWzLjT6xG92Kd9QbOsmwGNQK2aTvenxbrXOoSu5ek/wfEGRia6b4sUUGLnKFa1ORhcgQbCD3cIPocxrwqmn02TsZwkrJRSD3zMRg6ayiYxMK9tWZPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 17:42:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 17:42:45 +0000
Date:   Thu, 1 Jun 2023 14:42:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v2] IB/hfi1: Fix wrong mmu_node used for user SDMA
 packet after invalidate
Message-ID: <ZHjYkX1P8MSlFt7m@nvidia.com>
References: <168451393605.3700681.13493776139032178861.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168451393605.3700681.13493776139032178861.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 93eb84ef-4e00-4ecf-8d5d-08db62c79b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTLnUjuy2DOFBHo5rbMlHcjf6tFdiMEZFetqHnk8uDnkBJb8pXKKhjs12r+RrbQlzt8uRCxP8kGPRlpuf/t2tXnU6r/uT5FwWbMWQ0xsNB5Usi6d6iHAfoMrQUrrRQjWH5nF4eosdx765rdfnrcxcdQ6VJuRxpT7giKi826XzKW2ZlK1qD36IUNuc0ScVp06BfwYTmYeZQCBc/d8tzxFF5BwP2c3Osz9vjDyCG5BxdB4D1APZ5ouBRqWUqZN5aYNPmYGAhM7C8Ofb+l/GN8A6uRb6J+H4qEajSW5qcKUTsLfpRCZZiZSHZMakk+vT+cJySQtkcAIhQruXr/pB2VsstZ5Nyd2QK1z1TTzIV6R1G5XroIEGo38xhtr8v8moTm5cvFg6Yep0Gdmh/WN3g1yo2fvQUqDoFazkxtpcB9oRLNfJ1bHpyhpsdQ2X/c4qR5xo1Db6DdkEFQxfzJNTovaA5NRFvB5sipjDT4nJFfx+XBWpCaB9wFB8FLvFn/T/66iqZaMacwRBjXSWNu3lVd7QwAksdFMMymBgfGrgffl/1NmAYeMkPI3A4mk5yY7H+3r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(36756003)(6506007)(186003)(6512007)(2906002)(2616005)(4326008)(83380400001)(6916009)(316002)(6666004)(66556008)(66476007)(66946007)(38100700002)(6486002)(41300700001)(54906003)(478600001)(86362001)(26005)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqAm6lo2Jba6uwdkT6gX6/7Me34vOXaAJ48YiOtSA1SZ8PurbSqR0i+G9ofa?=
 =?us-ascii?Q?wCnVWgRBz97xVwN9ia6y+RB1RpL124S/76/7GAlYT7AiyqeEK2Kwp8PyoJMq?=
 =?us-ascii?Q?Koro6G+iboXautGXfGCaZXiwSXopyGOuiDlW53x9EI16iiPbOSrga6h12glu?=
 =?us-ascii?Q?DrqYZT3IdWKXmi9/tuKwGptOo9Xo01gVxQ3NtPKhjysKlL0pIoCfhqlVYssh?=
 =?us-ascii?Q?GryV4uTndiray1b4L6stYk5Wr2gvdFzVrF2gQBaG/188BzDNSp45zjuVVofI?=
 =?us-ascii?Q?ApyiF7nBoQPKDuA02ygUpQo+QM1lynttcSmYqvMle/tTWuy1HgW5M7xi+DWj?=
 =?us-ascii?Q?JuL0lABG4FI7AEVZypfflnp9fXQ4jI8cCi4JspdMsuPpZfzFVQM5HmppY1Dn?=
 =?us-ascii?Q?YinDgF8R71ORUVWsGWKkKkhI43P02SFbHYmuCHQ/+GrNN6RTmkztlCaisKz7?=
 =?us-ascii?Q?1/BXczMIrSz3h2T8AZcC3ePxiKOulwrskADuhAEsTiurxpa8/73eDdvN93Ex?=
 =?us-ascii?Q?I6DfemJV2xrbVF+Q1dUp8XNOym2crgr56WV9amDCXQudAp8bpjtvBg5G0PT2?=
 =?us-ascii?Q?ohJ4FllYSktJA+tG/j/rsHKXWaklY8oJf44TZikE49JFFl7jukZpPAUmVJyK?=
 =?us-ascii?Q?5wh55s4gw61LbjbLL3wz746quL35k004QK6HLcSecMDlkzHfoLBPbheva1dc?=
 =?us-ascii?Q?rbeEaCLh2qcIodtbizTOpx6H8qZ1DojUPCNUCs1NUjwlBcAcvaVSIsJNkEXZ?=
 =?us-ascii?Q?LfCD0zJGHugOmLJ09Uu/77tPnUbFYPDYo05P9i7sBOrfGjGMoc2qlS60dczI?=
 =?us-ascii?Q?OIdGBjCOSsZrc8nT/hnJyJGMBN9KJVUc9A1eXqEFwFI9YlnlQsTt/WtLZcfw?=
 =?us-ascii?Q?JpPClPbKvG27CTjE2SFdI17sbIvBaTqTfvDULQJQHhd5RSpLvHvSdsOdqTvp?=
 =?us-ascii?Q?u6UzYMULljBdKmGBYd6t1XfkJ7BzOPFbuZq6976/djY2bLcXQMHZ21DJJkWh?=
 =?us-ascii?Q?3d/fQDqnB9VqqKMopA25bm6gGZy+lEDsuBHB/dcT3NKr4Erx3wsjfEy6J62J?=
 =?us-ascii?Q?8Lxej0flT5o+y03R+BG9ZApZMKQNBaAecRuDwm4oW5kY15xmmioIVtazfhmU?=
 =?us-ascii?Q?tGAjrGr4mUsQO4w1YkCzyOJh0QKpRP/XixfNeGOoYOxuG1edxkxLHlNJDy0T?=
 =?us-ascii?Q?+GJAj+uQYellRVO3l+IM3VS3I7PmIHZGb2S6C6MA+6TZzVP3DsjtJt0jjRxI?=
 =?us-ascii?Q?CxWGPJxqol/O7K4Lm233VyWRD5paY6N4neYG9yj5z5VLM87GbNg3HtrHbK3o?=
 =?us-ascii?Q?SVSdCuzZeF7/7CbYSPW2bGxHfB2jrYL+Nitnex8gKLczRCee6cMplmFtX8pT?=
 =?us-ascii?Q?zT/ReeRPTPmDgUqM+hP9hBJFBcj0oDuMkxmuzsoa02TZoXwOzZrMyuHymUiu?=
 =?us-ascii?Q?88bIGAxvI7EaoVlp6C0XWVcCDyBnDhjmDYtf6Y0yzUU8huH4UZuBIW1pd50o?=
 =?us-ascii?Q?ufMCGHp9WjQhhueAxsstnWFGJPm06x8B993Ha+ViR3QHJutxAmZ/9t5eEeXa?=
 =?us-ascii?Q?U3DYxLteAPKZK2urDCDQuSSvWExO+XveXbbOsQhN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93eb84ef-4e00-4ecf-8d5d-08db62c79b5e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:42:45.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 155hyPPc26RjzFalpvuUoKdPs8BbTZXvlc1SRAVDGyvnowqhoHZKsn0JoVlEgTQI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 19, 2023 at 12:32:16PM -0400, Dennis Dalessandro wrote:
> From: Brendan Cunningham <bcunningham@cornelisnetworks.com>
> 
> The hfi1 user SDMA pinned-page cache will leave a stale cache entry when
> the cache-entry's virtual address range is invalidated but that cache
> entry is in-use by an outstanding SDMA request.
> 
> Subsequent user SDMA requests with buffers in or spanning the virtual
> address range of the stale cache entry will result in packets
> constructed from the wrong memory, the physical pages pointed to by the
> stale cache entry.
> 
> To fix this, remove mmu_rb_node cache entries from the mmu_rb_handler
> cache independent of the cache entry's refcount. Add 'struct kref
> refcount' to struct mmu_rb_node and manage mmu_rb_node lifetime with
> kref_get() and kref_put().
> 
> mmu_rb_node.refcount makes sdma_mmu_node.refcount redundant. Remove
> 'atomic_t refcount' from struct sdma_mmu_node and change sdma_mmu_node
> code to use mmu_rb_node.refcount.
> 
> Move the mmu_rb_handler destructor call after a
> wait-for-SDMA-request-completion call so mmu_rb_nodes that need
> mmu_rb_handler's workqueue to queue themselves up for destruction from
> an interrupt context may do so.
> 
> Fixes: f48ad614c100 ("IB/hfi1: Move driver out of staging")
> Fixes: 00cbce5cbf88 ("IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec user SDMA requests")
> 
> Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> Signed-off-by: Brendan Cunningham <bcunningham@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
> changes since v1: Update Fixes SHA
> ---
>  drivers/infiniband/hw/hfi1/ipoib_tx.c   |    4 -
>  drivers/infiniband/hw/hfi1/mmu_rb.c     |  101 ++++++++++++++---------
>  drivers/infiniband/hw/hfi1/mmu_rb.h     |    3 +
>  drivers/infiniband/hw/hfi1/sdma.c       |   23 ++++-
>  drivers/infiniband/hw/hfi1/sdma.h       |   47 +++++++----
>  drivers/infiniband/hw/hfi1/sdma_txreq.h |    2 
>  drivers/infiniband/hw/hfi1/user_sdma.c  |  137 ++++++++++++-------------------
>  drivers/infiniband/hw/hfi1/user_sdma.h  |    1 
>  drivers/infiniband/hw/hfi1/vnic_sdma.c  |    4 -
>  9 files changed, 177 insertions(+), 145 deletions(-)

This is too big for -rc, but I took it to for-next

Thanks,
Jason
