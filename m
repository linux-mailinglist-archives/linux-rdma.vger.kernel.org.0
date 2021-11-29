Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222F2461AA3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhK2POM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 10:14:12 -0500
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:20992
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234614AbhK2PMM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 10:12:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6ppFk1X1GjpJxgMm4qC0XGifhIonn3t6q1lR+zMpqABOSIKSqq9A6oY/dG6t3Og4UcS6DZIhptl3/dxAND2xNwkvMtlwSnUlYLJ3sVinwDfprlkH3wsixlE29nvoUN6j7KzUjP4txrS+7lMPDHTTjE5+uGVaM3xhl7w/nGsyAt/tjO2WSoCZFa1gFlyYG46qu2rbfK9GRaLikd1R1KdMWw3dsYyTTh/fZ4fOM8KFFT3oG2pmSQenpH8CIRAmC4WnV+aNdPOo3dp8AyGJCFfW0xqx+XoqN6rLK77nGJ07dDkOeCKkg2ht3mhjzhQLnEJF8oATENWmTjLz+B3AcKyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwhveEXdo7VtSvkfTgSj48sN7V8vwzW0wrHwDJQjBrM=;
 b=mCPg1SAVHFIryZeK8nwLqeLnFNP6009mWX7Ol3UdwWxiEiWH5nMSEZaN3djotSy3TjboU8PmuTMSxP0028FFIRz9cPlqrnJIQKBpwUOBQ077gPaN444XL5EIJkoFo1x1SxNKUgxoMo2gPgROaANwVAclasmJdl839dBSOmhAkFfk0E+QimajIHphwovsvaUqyZgwWKB30agMZAaZNCJYxxyhPnYKxqf/UGJ05201xSEhvTpgi0cnIcxAsLOeu8Ve4zO09hVO3M7AR1k646ncF1mK77gKzphQw3D8wiYV+pM48w5bhAoJRbzePrknf/4HW2OuHzOgcw7diG+jOm+FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwhveEXdo7VtSvkfTgSj48sN7V8vwzW0wrHwDJQjBrM=;
 b=Fl9yr1qnyICYmDFygWIQhB+xaBX3aQQVPbndqhUTvnJ/CnOeSxTz3hzOi+OqsNANef75eVqLBPzecxT4JkoHp+Nda8WnSnzhb6OKAYcycsaahF7YQSoCwzR0CNLA8qeinydQ/5bdN+VDDkBIjTxxKFkXEHlYD8iBsZQwt8VD8wY0oFmf8o8G0uAQ9bXR+upwwWjPtdyFaQZGpUdyrPAx1G3cgNTKC8+b/4EXkdmCw6Y2RaMJ5VSlFyQU+BlEw3KTWE++rgDVz0pSns1jWt4fNizUcPkfqv0mNvrELIBUIPYR3PdbGHWf27FVbRkfLrJhSW4nTBgvsCjuLaoTz9rX6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 15:08:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 15:08:53 +0000
Date:   Mon, 29 Nov 2021 11:08:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, haris.iqbal@ionos.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2] RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug
 kernel warning
Message-ID: <20211129150852.GA1024373@nvidia.com>
References: <20211128133501.38710-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128133501.38710-1-guoqing.jiang@linux.dev>
X-ClientProxiedBy: BL1PR13CA0295.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0295.namprd13.prod.outlook.com (2603:10b6:208:2bc::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Mon, 29 Nov 2021 15:08:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mriGy-004IV6-7e; Mon, 29 Nov 2021 11:08:52 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 655d8a8e-0ee7-4577-5c38-08d9b34a280a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50455E3855762422B4C3D8C2C2669@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMchBtpEiWNqV3SrPe5VFLeDZNdz47HGO9ITPJvYp1hOllBPGGAp4H8qAuvE5l2RFbtVSRDIHioWj4hlGSbd0E3hkHZzsDyF8Yw1aqUR4XFGJpltJI+c8blyBWapEIgH7aIJYNezxSTKJm7uwrAZUgyg9ncIQ2zgOlZsHhxcwSsAXDqUyqW8yOR5jeW2R7moVwDd1XaKuIsltcqKw0zkwz5crYoi7Ii5Yz6biemmY1PIEg7DVE/k+LOHKeBblBwgPNoutp1NYg6YSMRT+izfcRo/BraTgzmVfKXABlj+vsFUhmOqrut2tduaJ6XNO6IfcnuNvjdulZG5uN5LODCJiT+UqlRA1y4m0Uh8994joNrL2upAVzSPqtD/i3p5C/5919qFPUg/qF83bGyHuJYPfX5Is2+P3sW4Ec7+zXQWhsacBueIpSWFh0wVqrYcifPzmpWFFDa1Jh3D2niNneQT47cxUtXVCTWVJlDxxvQQLG3kmR0qEWzZdwEYrAbPhoeqjIk9k8v2CvAI1/SHogsZSQkE5GBXPk4Hi0DwqcX1iGKbHMB+h761rPRY5dAM44+iNlOLci1sxQ4TNspfNCXq4je1xpeCMLSU/ZWRMs5qt/CVGMH7ZBR13QveV7LArFlHDEf+uiGe7Q+gkh3RhskoJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(9746002)(66556008)(1076003)(83380400001)(316002)(38100700002)(2906002)(33656002)(9786002)(5660300002)(186003)(4326008)(426003)(508600001)(8676002)(6916009)(36756003)(8936002)(86362001)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3j5erG8mCP54O0DkNQQ5KaYUm1Us/MNjEF6EtkarWxE0fBxqfY8gr2iJAfGK?=
 =?us-ascii?Q?hCP5LMl90rO6U75zyAZzPkXNknATOr/76IOmkwOX0RG5b4hblKAEvCpwR7FI?=
 =?us-ascii?Q?zoit5TRj9+w/IxHaLMSaCTGzkMW0u1MFGpgQlypt8xWTOOfNpP+Cy098CK1H?=
 =?us-ascii?Q?3uJ+EHcahfZ92853xePwp++OqfNG1WmMy3njSpWJt07cNZpuY/wFwfi3meEA?=
 =?us-ascii?Q?0aCC8nY1fnVEfADK0l407XPpo7NXClitiyS5BnRRl634mkZj85/TwEpo89dc?=
 =?us-ascii?Q?+Ah3U+cQuvOR8tWcLP0Pr6JZ5elCfDJChEBJeldTWBsVBV9dAP0ZzQaZJeH5?=
 =?us-ascii?Q?2LRmt8EdOLs0tIvNgnSS7cC2qlBMm8vMSlF5TuhRpDxPeuk44hkrhWT7ZQlR?=
 =?us-ascii?Q?lbTwDhXM+D3Oc4npOi5Azp4wame/zr55ukJu6pWwA7iyFzeyuSe+n0n42uSv?=
 =?us-ascii?Q?6/Ez++3QARz0hRb6b5yc9iY1q7zJ7CQsXmOPplD7pFlERYB+IGWjq5+lo8vZ?=
 =?us-ascii?Q?/QAzggVeeq5pcQ8vewx76f2rCGdx24BLH2E+/GBwE4VR1ENjX4WuRutBOTIt?=
 =?us-ascii?Q?djuEH7x/G7qdfpX6hsWmMcdMDnst9fp80Zc8tYau0VFjC9HjQhGrR4u+cO+B?=
 =?us-ascii?Q?NfAg+vcLUKUKNeLV+JwsarMtjSyigjnm0/HCFB6q6/sHQAbJQ+3wN7vyyuTj?=
 =?us-ascii?Q?qneIQVNDiDChR+fb1Fqz7HnRCfWzYX1LNd3ollLi0NzVpOAVrokMwSa7Nf+o?=
 =?us-ascii?Q?LjXEog3qw4Pet0Ulz3wcjodLskRYZ5IdQUrJG4FVCTRp+pmCIfwkhY5HMX4Z?=
 =?us-ascii?Q?BUiuhdgJZV504040eTg9lF97s6SAyl0X7SH66GhIYuvM4J3VGQTXhM1V1sMG?=
 =?us-ascii?Q?Rkxf4r+8O5PLIopUuXHbv+7mOESHLbnOwHPXypOy4x7avusaI2IUXqyPz2Cl?=
 =?us-ascii?Q?PcQb9UKpcSq7LmfuhQcAckiJuht6PnypC5gOufy7gxfjGj23lMHHHkxsB/yT?=
 =?us-ascii?Q?e8JoWmK9gko0V9fKAT2jvcI8iVxb78gMv6v5gC5Q31XxO6uC573KHWWF/9ZF?=
 =?us-ascii?Q?KLZmmqWHg00PO4cISVC9uqKr5DuvoKJavoM4xMHDQTtAYGAHYLY65dX58IpL?=
 =?us-ascii?Q?ESaqsW8eYVxtn0QwTRQbynxQoX57YCnVN3d9VEeEJsQGQ8v1/I4adCv6Hjo5?=
 =?us-ascii?Q?FqX8B7ZXVWg9Lg/5qDwiGuerFMHCGculI9cCEK/UWY+L6jj66f0eDgdV8UvX?=
 =?us-ascii?Q?bV7z0lVMrmzuqWvduouhVyPvjo51x05x4EB/nvcNYYwZxQDI2JoNAbDtAEZK?=
 =?us-ascii?Q?x/bmQnkvlmHX+OIkjjRpKYbZmy2ELyEygsEMctU0ZQO41poQ1ucMpfumk4KR?=
 =?us-ascii?Q?kSzZ+qXo7MQoyvAKaBRZiIKCjvZhQw1+sNVyZgVGOaw/OTZqW1TfkENTfZlR?=
 =?us-ascii?Q?zXnuEK4R0+wb78qcFc2zjTzrfPgk7lV3dH81eMvr8Id/KhzNENd+MhP00sTz?=
 =?us-ascii?Q?hUzjHmJ801aDFtJJjN/439/CVE1Kbo+2muQeMtWGvbQ4AFWElPAjwjnF0+0R?=
 =?us-ascii?Q?xcZWsfeeXkmZQiLHIOs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655d8a8e-0ee7-4577-5c38-08d9b34a280a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 15:08:53.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5RnLbcm3Eccc8Ebcnr5FW2o+K/M75YFfcBsfx5e5f8R38PNHtg9DhsaOJjkqeM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 28, 2021 at 09:35:01PM +0800, Guoqing Jiang wrote:
> With preemption enabled (CONFIG_DEBUG_PREEMPT=y), the following appeared
> when rnbd client tries to map remote block device.
> 
> [ 2123.221071] BUG: using smp_processor_id() in preemptible [00000000] code: bash/1733
> [ 2123.221175] caller is debug_smp_processor_id+0x17/0x20
> [ 2123.221214] CPU: 0 PID: 1733 Comm: bash Not tainted 5.16.0-rc1 #5
> [ 2123.221218] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [ 2123.221229] Call Trace:
> [ 2123.221231]  <TASK>
> [ 2123.221235]  dump_stack_lvl+0x5d/0x78
> [ 2123.221252]  dump_stack+0x10/0x12
> [ 2123.221257]  check_preemption_disabled+0xe4/0xf0
> [ 2123.221266]  debug_smp_processor_id+0x17/0x20
> [ 2123.221271]  rtrs_clt_update_all_stats+0x3b/0x70 [rtrs_client]
> [ 2123.221285]  rtrs_clt_read_req+0xc3/0x380 [rtrs_client]
> [ 2123.221298]  ? rtrs_clt_init_req+0xe3/0x120 [rtrs_client]
> [ 2123.221321]  rtrs_clt_request+0x1a7/0x320 [rtrs_client]
> [ 2123.221340]  ? 0xffffffffc0ab1000
> [ 2123.221357]  send_usr_msg+0xbf/0x160 [rnbd_client]
> [ 2123.221370]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
> [ 2123.221377]  ? send_usr_msg+0x160/0x160 [rnbd_client]
> [ 2123.221386]  ? sg_alloc_table+0x27/0xb0
> [ 2123.221395]  ? sg_zero_buffer+0xd0/0xd0
> [ 2123.221407]  send_msg_sess_info+0xe9/0x180 [rnbd_client]
> [ 2123.221413]  ? rnbd_clt_put_sess+0x60/0x60 [rnbd_client]
> [ 2123.221429]  ? blk_mq_alloc_tag_set+0x2ef/0x370
> [ 2123.221447]  rnbd_clt_map_device+0xba8/0xcd0 [rnbd_client]
> [ 2123.221462]  ? send_msg_open+0x200/0x200 [rnbd_client]
> [ 2123.221479]  rnbd_clt_map_device_store+0x3e5/0x620 [rnbd_client
> 
> To supress the calltrace, let's call get_cpu_ptr/put_cpu_ptr pair in
> rtrs_clt_update_rdma_stats to disable preemption when accessing per-cpu
> variable.
> 
> While at it, let's make the similar change in rtrs_clt_update_wc_stats.
> And for rtrs_clt_inc_failover_cnt, though it was only called inside rcu
> section, but it still can be preempted in case CONFIG_PREEMPT_RCU is
> enabled, so change it to {get,put}_cpu_ptr pair either.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> V2: also make the change in rtrs_clt_update_wc_stats and rtrs_clt_inc_failover_cnt
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
