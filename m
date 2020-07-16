Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2397F2222E0
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 14:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGPMvQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 08:51:16 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:14150 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMvO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 08:51:14 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f104d3f0000>; Thu, 16 Jul 2020 20:51:11 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 05:51:11 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 16 Jul 2020 05:51:11 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 12:51:03 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 12:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqXRcbbHVV2chUjXv6ROlBXA5XwEXw958FMBA2JulmciKScqRIGdyECw+4TbhFuQe7rjBIIPD6Qr4GAthl7+h2z35zhGcJJbTSBd/qiFDdDavMdLuLYzoZdY9zyfL89B1i0HP3Mg/uV9xIeI/Hk8rlU2rzmVgMMJRm2nkZRNpRgsqFNs4Cp3kwAYJmYqZcn6l7qHciFkvq0bklR/1k7TeKTgZevlMWeo+yv29aANMfeNJl06w10byXxSU9BDNRSrKBpTZNfiFVkY3m7nyHFjky4g5q0lNJUK+4dniXJ3af6SR5Zc8FTUOIc949HgEtasEDTsDHn41KppJM4dozl0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKyNkY+BWaYKdmEpaMBqYeSjRKSHG7r1Uj6GMNaCziA=;
 b=ciDM5UjcaGhnN3EyMMeRtGEKFWfNHeZGm/vIy0d6KXtyckWMz2xBKZZdvVc90/YfGYcs0u60H/52YQbqsmHkcEvyYkFjPCaK2qxL8UJh9L6nbs+GMa46XDaG5uriQ4YrPFBRo+6EsKtJG3VuLu+hPgvDLJSoyUXKMgtJhELiwv9E4WoRRd3NP38aAMebUrgt9h7ilMjThfRJaGGXomECsb4PFGVD6Or2Umr/OAZWC8Z4GPpXs6UgQGa4jFTaRdJ8vfulFYxD+HrSHbPG0uCaBw6WCCTE1V19cwpyOordC5y/Oo7PFJfXc1keiU+EA3EY4jfQ+xurBb7zxpFdwsFTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 12:51:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 12:51:01 +0000
Date:   Thu, 16 Jul 2020 09:50:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH rdma-rc v2] RDMA/mlx5: Use xa_lock_irq when access to SRQ
 table
Message-ID: <20200716125059.GA2615054@nvidia.com>
References: <20200712102641.15210-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200712102641.15210-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:208:23b::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 12:51:00 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw3Ln-00AyIw-A9; Thu, 16 Jul 2020 09:50:59 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84668150-f3d5-4788-ba44-08d82986e46c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-Microsoft-Antispam-PRVS: <DM6PR12MB423579A41F2DEACC3260CE21C27F0@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaN2wR0mZMQhUHQTPMq72jDVEsbgiN28DhBuE9a7kzVtS9wQFdghL0QKS7O5WeV4o+kuYGlR14OLqiYSP0fXyWX53UzHZNxJARfiSQT1p7zTa0SEIaKx31WVvzBc7AOBHqA2/19Rtl5C9CwpA8hZaS58OQ37coTP22QZ8mlKDFf91YUkxd/Tr2xTJNaMu1U5nt4sDwojOTfGbDgUUzW7g0cDjKvaIIJNFphiFz+h/64WvRG+7/hQHRUxpLnpKqaf+qvnQY5TUAIXQVtQ9W8e5ckJRWejM5padO/JYH8hyM6ShUkwVp8F5v/2Hi1WbRdQ4nIy5yzxiwJupDcCgbjw/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(6916009)(36756003)(8936002)(9786002)(8676002)(2906002)(316002)(54906003)(9746002)(26005)(186003)(66476007)(66556008)(478600001)(66946007)(1076003)(2616005)(5660300002)(426003)(86362001)(4326008)(83380400001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4Xscym2IJt1MySgbJXFzL9nEbQ+NIDQi2Kk4AwGiQFg/uGA8uIC21dnGf2JP6p2KfAJyq0Tt57Al7OTkPBUnSB32MbrkgE3sSvn/ZDIpUp0Bsd1WzSiCC9mL1ZBMd5bsuLbo70OM9RPV+M5HsVVEcmOSEHimMd7Mx5GgTeR6he2gdIZCGjB86pxm3Q2J/o+h35oX0gkGLLtqYioTtq3PPlIBQiY62EHnhUSNM9HSSqdreFGcjafveGx58+OoO2IQ0Hu7iQnLH4QIrFLJaQ7nOSkD9V1KtQ/c1E5R98vHbROxaJv6AQ6ZyIhS4bXiRocb+xD+RjXLb2amGBtIZwTg+Q0P6ZhSkGDPpNRAKworX7hiuXAmR8EsZvSZ+keMjzhvS79IY9K4Qx7Yskntw8fHFFDl2KplQb8k/+rqnPwSA/weT0/suk63GYyilSvz9x+fJJUsgtbwSa8UiRIlaAdAxulmfDQeBOrZaq+nTA/St7jWCjDxXSFNf9noOOGXBUs+
X-MS-Exchange-CrossTenant-Network-Message-Id: 84668150-f3d5-4788-ba44-08d82986e46c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 12:51:01.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ti3Rdx4Hyy03dRHh4x56rE1XwFltfENU4B4t/Y01opdciq+e7/eGSu2vQ1d4fMP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594903871; bh=dKyNkY+BWaYKdmEpaMBqYeSjRKSHG7r1Uj6GMNaCziA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=KXFVud8wYR2pdihwBdM0/RfD4f3tiOxAhPuGgWnFxkjM5ZGIaQjrHfIPxn3BNZ6f5
         cuZcSkbAORZHD3O0ykuRUDxfIqkpQh1+imtb1EhtCgDK+rjFYzd+rlD6TA/LVxJ1Ek
         v/e1cPx9Idm079spNbqsgZYRDbEsSvT2lWn/7X133Yu4t2Df3f6n82TNzB5kZVrjGT
         EEbaf82vtHhcPBNcNMuPvIVASXn1X9ktuIEAuCv8qbU6XVNKVOEUPa0I9A1mQdD8YF
         pLhFMve0TFPA4SLcmCcRm/2Tt1lTc1UVNcCDV3K2LHxQNsAtmG4Kbb9xiidZhx54/t
         pC0XbDuRtFVWg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 12, 2020 at 01:26:41PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> SRQ table is accessed both from interrupt and process context,
> therefore we must use xa_lock_irq.
> 
>  [ 9878.321379] --------------------------------
>  [ 9878.322349] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>  [ 9878.323667] kworker/u17:9/8573 [HC0[0]:SC0[0]:HE1:SE1] takes:
>  [ 9878.324894] ffff8883e3503d30 (&xa->xa_lock#13){?...}-{2:2}, at:
> mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
>  [ 9878.326816] {IN-HARDIRQ-W} state was registered at:
>  [ 9878.327905]   lock_acquire+0xb9/0x3a0
>  [ 9878.328720]   _raw_spin_lock+0x25/0x30
>  [ 9878.329475]   srq_event_notifier+0x2b/0xc0 [mlx5_ib]
>  [ 9878.330433]   notifier_call_chain+0x45/0x70
>  [ 9878.331393]   __atomic_notifier_call_chain+0x69/0x100
>  [ 9878.332530]   forward_event+0x36/0xc0 [mlx5_core]
>  [ 9878.333558]   notifier_call_chain+0x45/0x70
>  [ 9878.334418]   __atomic_notifier_call_chain+0x69/0x100
>  [ 9878.335498]   mlx5_eq_async_int+0xc5/0x160 [mlx5_core]
>  [ 9878.336543]   notifier_call_chain+0x45/0x70
>  [ 9878.337354]   __atomic_notifier_call_chain+0x69/0x100
>  [ 9878.338337]   mlx5_irq_int_handler+0x19/0x30 [mlx5_core]
>  [ 9878.339369]   __handle_irq_event_percpu+0x43/0x2a0
>  [ 9878.340382]   handle_irq_event_percpu+0x30/0x70
>  [ 9878.341252]   handle_irq_event+0x34/0x60
>  [ 9878.342020]   handle_edge_irq+0x7c/0x1b0
>  [ 9878.342788]   do_IRQ+0x60/0x110
>  [ 9878.343482]   ret_from_intr+0x0/0x2a
>  [ 9878.344251]   default_idle+0x34/0x160
>  [ 9878.344996]   do_idle+0x1ec/0x220
>  [ 9878.345682]   cpu_startup_entry+0x19/0x20
>  [ 9878.346511]   start_secondary+0x153/0x1a0
>  [ 9878.347328]   secondary_startup_64+0xa4/0xb0
>  [ 9878.348226] irq event stamp: 20907
>  [ 9878.348953] hardirqs last  enabled at (20907): [<ffffffff819f0eb4>]
> _raw_spin_unlock_irq+0x24/0x30
>  [ 9878.350599] hardirqs last disabled at (20906): [<ffffffff819f0cbf>]
> _raw_spin_lock_irq+0xf/0x40
>  [ 9878.352300] softirqs last  enabled at (20746): [<ffffffff81c002c9>]
> __do_softirq+0x2c9/0x436
>  [ 9878.353859] softirqs last disabled at (20681): [<ffffffff81139543>]
> irq_exit+0xb3/0xc0
>  [ 9878.355365]
>  [ 9878.355365] other info that might help us debug this:
>  [ 9878.356703]  Possible unsafe locking scenario:
>  [ 9878.356703]
>  [ 9878.357941]        CPU0
>  [ 9878.358522]        ----
>  [ 9878.359109]   lock(&xa->xa_lock#13);
>  [ 9878.359875]   <Interrupt>
>  [ 9878.360504]     lock(&xa->xa_lock#13);
>  [ 9878.361315]
>  [ 9878.361315]  *** DEADLOCK ***
>  [ 9878.361315]
>  [ 9878.362632] 2 locks held by kworker/u17:9/8573:
>  [ 9878.374883]  #0: ffff888295218d38
> ((wq_completion)mlx5_ib_page_fault){+.+.}-{0:0}, at:
> process_one_work+0x1f1/0x5f0
>  [ 9878.376728]  #1: ffff888401647e78
> ((work_completion)(&pfault->work)){+.+.}-{0:0}, at:
> process_one_work+0x1f1/0x5f0
>  [ 9878.378550]
>  [ 9878.378550] stack backtrace:
>  [ 9878.379489] CPU: 0 PID: 8573 Comm: kworker/u17:9 Tainted: G
> O      5.7.0_for_upstream_min_debug_2020_06_14_11_31_46_41 #1
>  [ 9878.381730] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>  [ 9878.383940] Workqueue: mlx5_ib_page_fault mlx5_ib_eqe_pf_action
> [mlx5_ib]
>  [ 9878.385239] Call Trace:
>  [ 9878.385822]  dump_stack+0x71/0x9b
>  [ 9878.386519]  mark_lock+0x4f2/0x590
>  [ 9878.387263]  ? print_shortest_lock_dependencies+0x200/0x200
>  [ 9878.388362]  __lock_acquire+0xa00/0x1eb0
>  [ 9878.389133]  lock_acquire+0xb9/0x3a0
>  [ 9878.389854]  ? mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
>  [ 9878.390796]  _raw_spin_lock+0x25/0x30
>  [ 9878.391533]  ? mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
>  [ 9878.392455]  mlx5_cmd_get_srq+0x18/0x70 [mlx5_ib]
>  [ 9878.393351]  mlx5_ib_eqe_pf_action+0x257/0xa30 [mlx5_ib]
>  [ 9878.394337]  ? process_one_work+0x209/0x5f0
>  [ 9878.395150]  process_one_work+0x27b/0x5f0
>  [ 9878.395939]  ? __schedule+0x280/0x7e0
>  [ 9878.396683]  worker_thread+0x2d/0x3c0
>  [ 9878.397424]  ? process_one_work+0x5f0/0x5f0
>  [ 9878.398249]  kthread+0x111/0x130
>  [ 9878.398926]  ? kthread_park+0x90/0x90
>  [ 9878.399709]  ret_from_fork+0x24/0x30
> 
> Fixes: b02a29eb8841 ("mlx5: Convert mlx5_srq_table to XArray")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Applied to for-rc, I updated the fixes line, this bug has been present
since day 1 apparently.

Jason
