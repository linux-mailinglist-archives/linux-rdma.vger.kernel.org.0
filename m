Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49B1634506
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 20:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiKVT5T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiKVT4w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 14:56:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9FCB2238
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 11:56:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmW6B84FaAi4p9knpHMyB77AR8GetHQ2F98tXDxl7REzkL2AZeU2Clq67oNG6o/M+UaTC3dR+nLbp8cQSkdHOztlo8PI1dUUhzwf2VZD2gDUuOyAaA7MxyFh9Ee7YjoHGDyOe/MFXElKD2uPDqqySCkwbStxvoyzYWudBogfmng+aRm/hx/0FQ6E944l5h0Luyv+vNYbYsUi4NCUcEDnxDiicjYoT+zeO6yskVSjoFqltv/tdXNkZ6Fok0Ii3CBXDYU4wAWAyQ3mNDr6+zUtWNWIp2cLXw5mMEFzJZt37hfDsREMBgwXPrPsibCXJxHFL1dCqiFOyUKV0MCGjKfPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtjjbzV1DQ8NEVd67EdIS75h/JbDRcqKf3Gy2kn7Dcc=;
 b=bAw3UK+HWvxdhadhzI586j8QHCyC6sv+4hq2zlrVlnnmkezaN8gMSKtYd05CBzESwErVx7ini7bFKOtk4bHtRZSFazO4UBYGI28+sB3dRSwLGrLopqxocS4r8rbB35Hb0DG+Ye29RmOgnO4cnyfT63oJ9gG6vpHTIs1OCnNk2I8PnQtO9y0ITJQLqIggWGNhd1Ogm0r5G0CnhJh6BxEAmt2DKG1lsxXfSnIiaO2h9LeFZ4bLt0LTuvsaLlQLT3saNQO2iU13G9qG+8QTjABJZzvxfShP8uoSAabcSnxgXZFTqJyE2id8lijdtabKepsubEHLGLNxEiqQXv35lOMR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtjjbzV1DQ8NEVd67EdIS75h/JbDRcqKf3Gy2kn7Dcc=;
 b=dcEzLdc2+LR5+RaMfzz8Bzr6dieQ1X+51fNgqxQd10tRMS/mxYj2XHAu4n5HZoV/4LCUtL2Y1QDyH3/U28wXetpITY3j7FstOeJPH3LbOZcEkcePxHOB8+7PdLfXV1k3sc4KpOw+8fP27z37gcsvGEEfqBLWD/55+6aU0mEUZmED7o4lYM8nGC+mT9Dl9LUvgVR63KPNrFxjPWjjJ+gabfA1g4ZZ7E3f41nbECTCHJVJ1WTb1g3EgkAKadPs8Kegs9xAQvLnwKKjxYE8ZKPKI3IOsfoVjj5YhHSUCpWTINTPUDe67GrXUCAq2DbLI40uHaxkiEmLpSWh3ZDc+IHWLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 19:56:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 19:56:45 +0000
Date:   Tue, 22 Nov 2022 15:56:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH v2] RDMA/rxe: Fix null-ptr-deref in rxe_qp_do_cleanup
 when socket create failed
Message-ID: <Y30pfMe8hCQhy53+@nvidia.com>
References: <20221122151437.1057671-1-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122151437.1057671-1-zhangxiaoxu5@huawei.com>
X-ClientProxiedBy: MN2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: ff750a18-2ad7-40f7-720a-08daccc3af12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRKe6U3gSANo0IdI7URLelXqNnRlr9XuprjmXadH2WlZ6RCbEG9xo0W117pGHzniP8df3/CMHv8jDHlFmgtLAjSJSwC9AxMJeJnVHAzjVg/nQkJQDXmOXoi004N5WJQ5PdZQuMZRQjQHOdpNv4dWkRGSGJQlsNOHmnuVx791Sghye7C/blrVuje4NUfZsa4PkNXIO8/POGiFxduNcS5BjqKmCCyPl9p3ZVSxw8BVw9Ou09sjJ1IaqoF2jZ/RL51U2Bcn5HRrfEZY8SIbpK7/Rr/5xqyNMDW9NsiayFYcRItAhHbTFyAtZIXH53Dl6VS+J+DTmxuhpqIKu5W13jR65nvfLdxAUR0DvDfcfMYqmWQSGMMGikJJeLjl6boYED+XJmmKDUdfyHoiwFq5xmwYhEeFYVYFol+s84fYFWvYqXJTCl2xpBbyu4XcJgyCC545kctiyMI90Dwo1uL/OMXpsY9JY8FhOEupvR7pN/blebuiRcnHNehmbTpFvOj/PiS+2igjymgAU11e0tLt+zuesH6QmSLD1VVA6aDYCSk7ig6vVfZU5bJgZMbwrhIvW7NFFtD+OL0C5sLYCkbz1CcDRhbKCxUcaHyBNRcjN1WjmLBM0mlmfGjCIftLGPJQDcEs/En5DzGKA1XZ49jeL2w684KEEs6W4Dyb9CPPqsYnhRe8aISB5YxPvJYBb0k410PlQkyaSxhOeLlcXHUqpcOv4eIqwoRlUJpAMTFNXUUz4E4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(38100700002)(83380400001)(41300700001)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(5660300002)(8936002)(2616005)(6506007)(26005)(6512007)(186003)(6916009)(6486002)(478600001)(86362001)(84970400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXklqObythlHTCwlQQLm5ximDS7b+HQM3OcS0wpI8TkNo6DKcAvpF2O0jF1Z?=
 =?us-ascii?Q?+5JhD3zlIX6A9gzxkBDaQEPAw6H24NYaEkQQCObRGPXSRX7OcSiv36PPmQow?=
 =?us-ascii?Q?U8U+63xhh5KTDI3kLTl5Ng53uV3UU7jGncQrWvsRr412GYfno7DpEaXfubVi?=
 =?us-ascii?Q?XnYBS79oMenRBofhO0eqc7Imb+BoA2VlSnqjVDMIYZLpnKJzzN5rSTg0H7R6?=
 =?us-ascii?Q?N2vZJCHM0AIIBlQu1EzIRXOCqTnm8Qhv24tJfUztPhKxg6M1jRWix+f3gm2c?=
 =?us-ascii?Q?ZBxSRS/0G4ryRltHjRvuBQC48nIFA4zG+M/Bi3IJbnigIVhO/UGCEvHNZejQ?=
 =?us-ascii?Q?EOFoWXkx2sb7RfetADGLAZZy+qVc0eT2v1DJMKsgYsCeM//iwjVUYkw8Ksx2?=
 =?us-ascii?Q?wqjs39SDVvvFtp4IApMDNJRuQwekloP7QeZ4ZfW+S91zfP7c1abWv2pceePb?=
 =?us-ascii?Q?eWkAXKKWm0CvOx4WoNjU4VEsAO3gnZqd1d+BhKQsM0byZImdNFapTY379hyd?=
 =?us-ascii?Q?NPvg/hO7QXdPYUdPtnQy5kHPc/ln6GBpkOEQkpgAqHfKuW5TKfo8PwL/Rsy9?=
 =?us-ascii?Q?wsAArg977pr1+aPy/BmpMNzvdpIr6FdpBFCPxNP6H2QT6r1IzWXjiXLX5Adv?=
 =?us-ascii?Q?O+KA3DdtV8q2OQp0JiU+kncK6B2gD2rrIAj7JiLZgkaAAP/LlvuRtj7T+5VO?=
 =?us-ascii?Q?7atHFMmCU8L8iCfq3+2Zjsgq6+PcFoJGCi0bO9zUtxACqqkhqTuBH4PpiVck?=
 =?us-ascii?Q?C9kIqCLsn2Bkmfx52bWXxww5G6pM/DZabq0JOAM619p6Fvh6Lt5OyQiltTby?=
 =?us-ascii?Q?1Ok8VszWtfxD06E1yQXww3331yWOcY+QI+GJqjgPmyRa1OoJpkT+ZeWgFAaw?=
 =?us-ascii?Q?oXHBVT32O4vqTN2ESGlEnLKx9fp5UxUcq4Hgd2kK2y5aegdTTB0DOmIuD1Y9?=
 =?us-ascii?Q?K8UcVc+Zx1CmWdUm3+KmOWJ/fLvVv84/X/nrDcAwzxEMXLvcIRSKaiO5bE5d?=
 =?us-ascii?Q?9W22LuQLxkCxKiGgF2MlCbSTClo0T85HUrPmOxO3Ut5yDBlc1lcdHhXAju+g?=
 =?us-ascii?Q?FCzWE1scANxeYLsSc9EFIpOxvOexz1XLy/puUuQltO/CF8+Y59Yd8qqjqAnk?=
 =?us-ascii?Q?a6LP9rnpLZepURDZEwVdOA6Qay7p/Gc7BriRgcZD6to6YAIBuuHXy/4jrrbl?=
 =?us-ascii?Q?1S0/arTuOJ2hBaVHBfJboMYjFOiOGJnM+OqsyQAt0Nw+xtm2TXwctV4qPDtA?=
 =?us-ascii?Q?YgOXJHFZAzheBhg44DgYr3PFOJVJb53B7kHo7XE26nEumFCNBRp9yYwYfxKh?=
 =?us-ascii?Q?OLK62F8WSx9zO1BngsGg8UF4busSicuuh/YqNJ8oqwCJHvofUNZVmtAP/2Dq?=
 =?us-ascii?Q?30JAY6/tzcvTqtobCyqRMewbX/4KGoUIcU6yyyOGhloG6h4sS6kU3HK/GE/S?=
 =?us-ascii?Q?oyfW2qREomgrREZMBvC8BOrAlZ3W7HFELK2yoryw9QIERXfDPvEA27UJfYeb?=
 =?us-ascii?Q?FdhH2Gc7zfdhaFR8Ibi1EXK3pMIErSVhl9gPjHOP5bUf60aWjIky2Xw/bP0i?=
 =?us-ascii?Q?3b6qg1PLcHns/RTlECM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff750a18-2ad7-40f7-720a-08daccc3af12
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 19:56:45.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjFiPeWVjCbb7tJjOoUlWw30IVjVXJjaPD6ZtYPOhy1KOG7hsXuu6p+4761vGEGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 22, 2022 at 11:14:37PM +0800, Zhang Xiaoxu wrote:
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
> So move the reset rxe_qp_do_cleanup() after the null ptr check.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
> v2: Move the rxe_qp_do_cleanup() after the null ptr check
>  drivers/infiniband/sw/rxe/rxe_qp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next

Thanks,
Jason
