Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A3D4B2E41
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 21:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbiBKUJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 15:09:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiBKUJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 15:09:44 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1830C55
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 12:09:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4gNiPpoFLreAl0/pNI/l5xsNO5HWBG5PXQQvbnlOrZQQaWf5RfYJlpL9PW2kd26tvXp7t8X/b1zFWvbaJDQZiaDS6mqN11BdTHxZk+59pgogjgvtiNcfn+a/X7yWaIZbGxigFQb25zRubtq85pVyZDLFL/trD4NwLHyVyLwU9T8BU+X8/5hQUJWbVaI9zOimdGq0qszTPdLKZf4BMABL+A7AvCHMh+MMRESsORWngF5vi01YL1IrqySa5eeu9iz3sHEH5GUHO56bXedV77ib7ibRT0T+7Qs8X9sEzFn7q0XsM0Hv4DB2JHQysmQtgfdDQ+My44btVSgcwxlV8lTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDzNHodouYe35ZUeRBwCPESJx6FT+SjxU5wfeiFfDg0=;
 b=QWMMs75EBA7iQTJ65VBT6a2Rt2EhDa22yt1sZPaWlqu+eJlmtRKRh9f+zcRpLxBwj//fYumOHweBkQFXsK6bWtKA8I4QvfkUyEsCagFQ3SpJMaR+zQNhq2xRT5JdtOhvPBUj7Z66EbATdkb20WW7RvluL2+sdoMxlMzWSkt4WklkbKZBDhq6K0Ro8mArIFUgmC+yIUaQV3cU2Mff5SxK56WevZ98GaAZhJLWuQ0wSjY4W+pcrMsx1I1o9J4EszXmJmv3KTxupTSWMFkOW6cxG+YnNhCJ1ZTCIXt9T16QnorW2KEh1InhUhKt5XmILVgVDgdgf005ds9eiM7Am2MR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDzNHodouYe35ZUeRBwCPESJx6FT+SjxU5wfeiFfDg0=;
 b=KaYRoSZpkrbCbedqdNY2ejOp9dBhhx43lFDbIid7vPinZEV3V75t6VVOu295KTZOBiYImpgb5qYQeMFz8fUhnY9mRnfjIDiROUthD+f5s5EQp8RurOZI3x3jxtvmH0RGUqq4z64XDOt/J2G87jQaqbugQyq7R6/KHTwIBuT/bjooiJ0CqLlaj4Sezz1NlvRh13cP2EMXhZP2KMC1nDMUqYZAF0qI5kHzSzYXFmCc/5x3UE71GMui6FPAxWO0gjPTLd10Lg8vptlABoYOjaiSfusdYx2m/4VuJ8kbbwuNfAZUfVtd6hSFaQVeLG+GBL6Cv54BoLEBEIkLyMHDMHseJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1127.namprd12.prod.outlook.com (2603:10b6:903:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 20:09:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 20:09:40 +0000
Date:   Fri, 11 Feb 2022 16:09:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 11/11] RDMA/rxe: Convert mca read locking to
 RCU
Message-ID: <20220211200938.GA669898@nvidia.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-12-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208211644.123457-12-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f1af66-506e-4535-0b22-08d9ed9a6f5d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1127:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1127F3C65497161D55BE1FA6C2309@CY4PR12MB1127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqtYJE5KVf6+xs3GfPGzaePNSElRjKDq4kPzUuCR6BQelww/Tf/n/YtKDHvhEogWygUXaEz+K/GCwq6xo61O/k9zKxPJGIVHlNXM1Ugp70TjCEFL3QrABgDADywN/Mz/QmvYs01/fvGayefdWGFMngQei/w0qysCXigwLgeVRmLr4i/1tEgcsrPoeqZILdEOXLHFLJCSZAYMkZzLjhCc2wg9gUkv7SaWcZPQmStUEU4grkL+liyOL94dcHScbmO/XBe18/4e3wzQQ00eJxZ+OAgwA3RNBZdYgfz5cryQ+JxEkqGitQXMqTwJGbGfJVJUPjiGtsfAoZms1+ww9CykNXdV/yDL9wHmnnVZj48p/dpTsxvgQOlqVXRp5iULK8SkdWYX3yYoy3VZcpYAs99m3xASZVietWfiXm56DdtSEoekm0b6V/EOgRJhxz5dz+T9TYGx9QUmLgGqjl88LoOx/Mu/V2jkrKhcm3v1zoGSV/nnNqxLz2QUBjD6DZVNf6Z2R6mD4eO2acQMKB/LPItBZ3MqYoIH3YEzV/ThZizopwZI4bVGf3hLrWU5zxrDAdMhMR0iu7U8hyO3XD4T3fgRueLDLGUk0aSsEMRHLGU19xMyjKPJAa3c58GpSQyGy3I/YSOQ9/R34GhIsUsn2IG9XmkT3NU8gEW6Uau89BKqmjqlYZnZF9xtJDEBuPeiUhtE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(4326008)(66946007)(8676002)(186003)(26005)(5660300002)(6512007)(66476007)(8936002)(33656002)(2616005)(1076003)(2906002)(6486002)(508600001)(86362001)(316002)(36756003)(6916009)(66556008)(83380400001)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JqYfDPfG7mR9nJ2UCVmjNNC05iyO8Zo5r15ccd+/uk6eq3H/YeanMVnOUYV3?=
 =?us-ascii?Q?08QnxgsEhC+UZe7b0dUgx9QDwcNQYhoR8Yb41gvLBRF0OLy3n526YsgaDVTO?=
 =?us-ascii?Q?CloOWUdfgPPGD0+j6D+Uxigv/vLnAXa9sHN75g9bANOIxuqUsgzTm8FYtMKX?=
 =?us-ascii?Q?S9j+gSYwj5HGNIQ/3fXsCPnQ/nz6dqOYcNQwR35egtMFJL0mix6gkxDUi0Zv?=
 =?us-ascii?Q?v2DV83T5Dy3w3cHIulJ+eGwdtwLxINaP/sOC1uT39uDiiHJenJmazX9lei2K?=
 =?us-ascii?Q?RRDxnilRA6x9OEn23Q4lkLtlqGAeOhWfN0Toc1CL1IvN77CKyNj893UJcLJW?=
 =?us-ascii?Q?Aw/R9Gc/pF5PdMdJTryVNHa0f4XFd9CdzaHxPKZoTKGh/hIRZjUMCzIA9Yss?=
 =?us-ascii?Q?JHnD/XBIdP0Nv+QZ+Tp3EkqQ110jm36ritj0TrfsfGprlQFLSQwVqGzwG5M7?=
 =?us-ascii?Q?BjRdZIuslRhcqWkbBRnLmV//RPy3lnplFQcHJ2HiwVMTf6T/ftRa0YpZ8R8+?=
 =?us-ascii?Q?DXJ5KvSNcgP2KA9yydu5n1ZxHdrsvaxDed08mM1r95W4tRT4lVQCaFX0zNnk?=
 =?us-ascii?Q?ozZlAkiOQAhnROcayzHk3j7EumIF+E2xtkz1QFE3/HwGvhtdGGrnbRKnWwKB?=
 =?us-ascii?Q?2S7TSvY8nPEHpBaEEy6/p94HMGlugqlAR9Eva/CFacouYtREumjYIHuXDjod?=
 =?us-ascii?Q?9zOMo8JV3zD7HL0x+OuORxFuyBIq3Ls3LMTrgYrCcWhG8CxoYU4sb03GsPE2?=
 =?us-ascii?Q?QvrOwC7WRxKLWHCem0cWVaTFH2JDf5UCoezzzRl261uGYwRs7DF9wgUo1QzC?=
 =?us-ascii?Q?A4Nipj+hkMbh5dH5eNGuBC+ZRCCxxf+96sQaLvB6DRfaHmeskWFfH/xBjC6L?=
 =?us-ascii?Q?RYG3uKF7bETX3AQ5bDGB4pzd+cuctvNLsQUtZezQj2VEawfFyPJiuNc1IboM?=
 =?us-ascii?Q?R6B6U+lbl9yn5Md4HdAJLFK4qn2YJJaTS8Z0ST5vzwGS7laNd8YS2Wf2/iZY?=
 =?us-ascii?Q?+efM3XXY4L45hMDnjuPQ9b7o90WNsfo3yCsUWEHJLaFsNbnwvoIg3YkybmzJ?=
 =?us-ascii?Q?j9hNI1VL4wM38Ln3xIY7fLUCDYku8CUFiEKo6bCfRZIEe8pAjwUusXz4Ghg/?=
 =?us-ascii?Q?hBVO6CluShNfsZfM0z0Q8mU3uYlQxAsvf3YrOFRfjljqOKYdCc/sjqOIR8TT?=
 =?us-ascii?Q?x+1vUL+lkfqYoWw2eRKVKqNvXnF+pq4pvGvduImNVc9TH4rOhEZ4TqFNHq5P?=
 =?us-ascii?Q?JQtnctd2vXzHVCy6cGlvEJhwXXnJPg92qIURnoSkqS5p0O3VMwmknGTPJDOg?=
 =?us-ascii?Q?LHNrWkPhxRjfCXrb91U2HR4c8EsC+TYHtm0Kb+fC49PLgsuhpFhd7dDd25i/?=
 =?us-ascii?Q?KCR2pmJHE1pc1NXCIo3KPAVUld/wTHM7Y8ORGsecXBcT2HKQ+Rr6SdxDnsIE?=
 =?us-ascii?Q?Xc1zGcov1nnocvioG3D8cQRzLKfqeJLXzcquP8HZWFnSalIdnUluOhjR6ISa?=
 =?us-ascii?Q?dc1DOkCSynfn8H/Le48eSqEgqaROsgSVg9lWLvDpxefRMpKZE7knJhgMYGq2?=
 =?us-ascii?Q?0gLjFyOzUjkLUlowQqs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f1af66-506e-4535-0b22-08d9ed9a6f5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 20:09:39.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATTwyhX4Yl7JvSz1yg0c/1X0ga3XiU5cVUqk2vkwYKqDDAcwY5ETW/8mbGBCzX3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1127
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 08, 2022 at 03:16:45PM -0600, Bob Pearson wrote:
>  	/* check to see if the qp is already a member of the group */
> -	spin_lock_bh(&rxe->mcg_lock);
> -	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>  		if (mca->qp == qp) {

The use of mca->qp protected by RCU isn't Ok..

Look at the free path:

> +static void __rxe_cleanup_mca_rcu(struct rxe_mca *mca, struct rxe_mcg *mcg)
>  {
> +	list_del_rcu(&mca->qp_list);
>  
>  	atomic_dec(&mcg->qp_num);
>  	atomic_dec(&mcg->rxe->mcg_attach);
>  	atomic_dec(&mca->qp->mcg_num);
>  	rxe_drop_ref(mca->qp);
>  
> +	kfree_rcu(mca);

So the mca deref won't segfault but mca->qp is garbage now since it
might have been freed and reallocated due to the rxe_drop_ref()

It looks easy enough to fix, just use a call_rcu to free the thing
instead of kfree_rcu and do the rxe_drop_ref, and maybe others, inside
the call_rcu function.

> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index 9b21cbb22602..c2cab85c6576 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -265,15 +265,15 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>  	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
>  	n = 0;
>  
> -	spin_lock_bh(&rxe->mcg_lock);
> -	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
>  		/* protect the qp pointers in the list */
>  		rxe_add_ref(mca->qp);

And this one could use after free qp

If the mca->qp is guarenteed to have a valid refcount as above then it
is OK.

Jason
