Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71963633D67
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 14:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiKVNTV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 08:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiKVNTU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 08:19:20 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C679140B7
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 05:19:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6l/EdGQJqkPzMcp33vWmkLk35TnzR4kMou71d8tuPt1Hg/ccIoUejDJQ20FY22c/NGj9eAZ9xNcKq4hW8VSJd58f4kElxjIb58DC8LsyheMuOSPcqLUtraeLusU7h3qW6X1jq3AOGwW/ixCiIqF6gFW5fThsFsk68Coz+XrIeKMFDGdAxoD6pF4rWgpEqpOYtpfUNVabUyn0BvkR6pPzNeHz82BJs+7WiHK1c0x5aOc+4aqvOuODfwJVNsYEuicHWnmf5PcnupRJlFkWDAq45tn/dUX+KlKOsfTyny6H2mF543L09uJaE4Rk/SKpd2F/pL8L3ee6Zdys8PBER0CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjCvzP4ChT//qT0JaLAdnbOopNelJghfjknA+1YTwqw=;
 b=mH62TMz8Im8l7BH+35mRdLv3YRxWLirCimlZy438UhdlK6p6fMy339D6Y9LSloGN8/oeShMZShxQXRMrZH49ZLeCatJYXpowQdUmWOsn+2WhhaU7Xa+R7oMdUc0so9ZfsifU20slzVDD+QBfqe0P0ZgueB7luWwKHUyOd3KXSCHixlD+2BkvK5KizH+xnKsNHxSdj6/n98yyiOnv+KPuTlp7AMtfGWeuGC4fKUxOtqaKrvDu9PCAOudAO4FVdEc4HGbePzHBwo9/HladChhw+mkOI6YP+zsnHFZ3bGQxSNcCoTMctHX/HgzmQk6RMcpxFaOA84pojZWxqYzMjWzKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjCvzP4ChT//qT0JaLAdnbOopNelJghfjknA+1YTwqw=;
 b=TNx7MZV6dQkEUBWl7+d9tAx+uoIePmo/6eO4zQY2Sf4T0D7Pbp3pIS+/ZS/BOgP7rp5VAJOCl11KL5r3o1wi5lDEHNgQdH0UM28CnTjieajQnAellV2s0mvVvrsARa0IDeSwEgPOLf8v6krh4tcKy4eZbB2qmWTGlwF8rqlDhniG+OOmM0y/qcN44QtZwdJUZ9rsLzwEyZEAzXPjs/9Oxn+mxlFZV+R3CuLIwdMXNe11Dxc0qOraoL4fO0R6QB+VW2ZLD15/lU6YLdBJF8w2yDB1SV+7svgHw0Dfwl1pc7FVLcyEO2rf3YTPas+wCZ0gy4mXza3rmO/sKd/wXN5EmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 13:19:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 13:19:17 +0000
Date:   Tue, 22 Nov 2022 09:19:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix null-ptr-deref in rxe_qp_do_cleanup when
 socket create failed
Message-ID: <Y3zMVDXMUwtlHAWy@nvidia.com>
References: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117123347.2576350-1-zhangxiaoxu5@huawei.com>
X-ClientProxiedBy: BL1PR13CA0318.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 0386407a-3383-49f3-0dd4-08dacc8c28a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: er5oPh28KpugNpT18zecC00FnINVscsftnxFlRtAcu5DVVY5GuaINyqvqN+9rIAF5GfqaGIvXwfpHtwWK2GqpFwRQd7Df4anb8cT4H2jYxwyWWm8hPa+k29BmEMqURVO+sE8VVdc1AuBDebHXbXArNBEpxTLRS5oQsQhUTTDwcBdSRR88FSM8V33seMnuf2w+Ttq5j9rW9ilt9ZYVHH6571/xhaiG4RRmPQIXnX6UcN0hlQ9jpqO7BNARGHWaYeeb2HDv8SFX6DrQYYYgLhf6H8Ij0gQUsw+/nL14sZthXoWSzsor57mPkgZtCNn46WeXarRNt3dUin6DfwxFNlEIX4tqHRQS7aeEtD3rM+cHk4vxRgpvd7Nvwyh6Zi0d1AMeGcXaSE5hRWWdMHiFbYVqyHW/joAtXdxcU2O5GujKdpX/1i811MUAA3DVQki1Xvs/Hd3UwCAeifzO5FMkiJWu2tA9XHn7rP0K8BU1xSiCGx8wjlKqJXVa3FxgMRdqbHpDC8UlkzGYXJZt5Kv62I3oAG2+lk/Vs+nK+2UfS6kDmmSzDYc3FQ55O+x1BMQVDKWUJMEM6Kh3fNiMvB6YBsMcJgwNGXlxL+nsObq2APfKYHdyLRR0n25STKEgXXHXEqO48Ji7EF1QUYZtgP6drb3sgY5tyz3VqLLoeH+rOpPeOSentq3lyec5ofn2rpIkeduD3r4XRLfaWADTdYajIOa5Jwvkt/YRwHuor3cb/BcWlg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(41300700001)(8936002)(4326008)(316002)(6916009)(84970400001)(5660300002)(66556008)(66946007)(66476007)(8676002)(2616005)(2906002)(478600001)(36756003)(6486002)(6512007)(6506007)(186003)(26005)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZtEml9eqNa32MoPfI9SdZGgNvhl5OFzZJjIrm5GukwAuZbLvsR4D01ZTFfIY?=
 =?us-ascii?Q?XK6yhwcrH/0fUXvHXi0sL5UL/Z6Rp0HxEsh2LAEv+MmbkDhQKKgAgqZZ3FhI?=
 =?us-ascii?Q?7+Y8PWsAV6Uf3qTJ9veTS0Rb+I11a6LwDWakvaCUaCWSvCPwS4Prju6ab5Oe?=
 =?us-ascii?Q?40qgVTm3tiAtwbnEJu/KxIoR09R3kaPqYNMToHZWvNe+qs4Cdu7HPFBMq+Pq?=
 =?us-ascii?Q?6uvuDdAczML1dYP2B6lfnVH40YvNoobfWMy3YqK1THS0X5inc76H5GIihTQV?=
 =?us-ascii?Q?2y8aZ+YshQZiG6M31iCuq0n3tUtmsamgYYD5H/6EnxJ/e9zfi5eyn9Sw7PVU?=
 =?us-ascii?Q?IKfeHiTEaXbTl5lX1O3aJefwBJhWc/n19CfCQqANKu40F+K0D5IKSe/1X1Ft?=
 =?us-ascii?Q?vB5B7ItWcDSerUq0pmaHq8UlMJaI2RRORkWevnDIwdlSOkn+UaMKR5UGM48y?=
 =?us-ascii?Q?KFPx5iKrRtMRB+Fx09QlFlA9hdNciya7apYCVqdnWMBzwId6Ab/ns8FJoCu2?=
 =?us-ascii?Q?vPuMi1hkpcbOirpqHnParzuXrdqlPG4olJvfIAf4JPb6LoXxZngHsAD9R18I?=
 =?us-ascii?Q?F88Drl8qjXr95mb4E/f7FdHF7HXLbBCOok/GIdAGmCbglpOShsgmzsUcYErO?=
 =?us-ascii?Q?9085oAJCCqL2XjQaOGKCdtHYOtMh+vyrGj6+gUElL1JQVoYCqVqYp9WXLg9q?=
 =?us-ascii?Q?aTqKa7pwyAEJYGY2MO5Jy/222nKa3W3CDBhZYbVg0RIoDWhg7gfi+/wc67Zi?=
 =?us-ascii?Q?bgwcsgCWzwE8DaRpVyvUWjDrqje6G/E5l6p9YIajZT/C3AWebYH4cp6nzkLJ?=
 =?us-ascii?Q?TnOz73rqpW2tZHDu76UnTcWys4Uryk4qgqhA4Ofb1aR6+yhoKve3TNjQC+fH?=
 =?us-ascii?Q?StPF92xnrWAmFPG5ykTbUurQM5kHYmEuyAIb1Sxq4vbABeXywpJUQi+oYySh?=
 =?us-ascii?Q?rLu3BxmgyTynSevxi4DiYnNIvyb8r2h8zuZuRaQ9//Wa7btzaPe3ELaCYpKR?=
 =?us-ascii?Q?vLS3EkeNQdBqzk5gFrSxTkgEd0ouhXWrCZJDjVuR1RHXGd19+s9Z3gScoBzE?=
 =?us-ascii?Q?OGO+lU2vdjlvLemNnlJnFNnGhz3NWg43+fVn5QhoJs1cTpQKJ7RN9dFYry70?=
 =?us-ascii?Q?fbi76p4RhO6MExW6blZvHryMYVN9YR2bwyDg/IRriQpC5JeWwi7J2EuItCAD?=
 =?us-ascii?Q?db3htXmxRa3OVu+7e3+GYyBIhDkMddC20q+NRZLvDTBMdXZX2uFtd5qhbwcW?=
 =?us-ascii?Q?lGYtzZ/HKnBdK1ClkCtUhpKRxe4PHmqiyEZOpjRjq/97kA6QxxkU63lvEyHN?=
 =?us-ascii?Q?YIIFxiDsLuKQDXx4v3XnfojM5cLKewqf2iKeLCJx/Qm3zMxbjyO1tTXAvGOG?=
 =?us-ascii?Q?A5+INJcLXP4Mk0QaD70Ej12Ws1xt8/GsSTcj6/hS5YN6z58PGUL4Z+y9ywv0?=
 =?us-ascii?Q?FKcPB5KOSTU6AXv9WFZUIX5/L/JRwFiifF0QTAfwzEs/iLxycBjODk+YIw0S?=
 =?us-ascii?Q?IoSktJ/7zdvOI9sjxzhzOzIcze4k9yL179iGx5AREUTy0LbCeFPrRDcYIl8n?=
 =?us-ascii?Q?+AUzjuGTbsdgKKXA9Jg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0386407a-3383-49f3-0dd4-08dacc8c28a6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 13:19:17.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRkNDE+jkoTcJYiVnQ6tHGGV6DUm7VBMapa0w07VNYOkw06161hqpx7KFfOInQpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 17, 2022 at 08:33:47PM +0800, Zhang Xiaoxu wrote:
> There is a null-ptr-deref when mount.cifs over rdma:
> 
>   BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
>   Read of size 8 at addr 0000000000000018 by task mount.cifs/3046
> 
>   CPU: 2 PID: 3046 Comm: mount.cifs Not tainted 6.1.0-rc5+ #62
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc3
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x34/0x44
>    kasan_report+0xad/0x130
>    rxe_qp_do_cleanup+0x2f3/0x360 [rdma_rxe]
>    execute_in_process_context+0x25/0x90
>    __rxe_cleanup+0x101/0x1d0 [rdma_rxe]
>    rxe_create_qp+0x16a/0x180 [rdma_rxe]
>    create_qp.part.0+0x27d/0x340
>    ib_create_qp_kernel+0x73/0x160
>    rdma_create_qp+0x100/0x230
>    _smbd_get_connection+0x752/0x20f0
>    smbd_get_connection+0x21/0x40
>    cifs_get_tcp_session+0x8ef/0xda0
>    mount_get_conns+0x60/0x750
>    cifs_mount+0x103/0xd00
>    cifs_smb3_do_mount+0x1dd/0xcb0
>    smb3_get_tree+0x1d5/0x300
>    vfs_get_tree+0x41/0xf0
>    path_mount+0x9b3/0xdd0
>    __x64_sys_mount+0x190/0x1d0
>    do_syscall_64+0x35/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> The root cause of the issue is the socket create failed in
> rxe_qp_init_req().
> 
> So add a null ptr check about the sk before reset the dst socket.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index a62bab88415c..4bab641fdd42 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -829,7 +829,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>  	if (qp->resp.mr)
>  		rxe_put(qp->resp.mr);
>  
> -	if (qp_type(qp) == IB_QPT_RC)
> +	if (qp_type(qp) == IB_QPT_RC && qp->sk)
>  		sk_dst_reset(qp->sk->sk);
>  
>  	free_rd_atomic_resources(qp);

Please just move this down into the existing if

Jason

