Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862AE379793
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 21:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhEJTXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 15:23:39 -0400
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:30945
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230466AbhEJTXh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 15:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULPEzv0P1qIthdrokChXQeN4t8brFwZfHvXDNhU/XJeBpkTfMNhB1J3jwPyGXvXgeet66NMjnktZJZEz1BCQ2wQWfVS/s9chX6kTcrJ5ie1d5Doxy0hc5g6FCmhFeZju6HSZiO3n4BoGwotu9u+H7YheuOVwIXCAV5IPGWKYriPwlE+l/9BAAuWm1cG7fcfEGM/eUj7lNzAVWbvWbIobWtDMcD8J/m1N8vteo9UVktsLtQkywf6sa08G0d5KqpBdASdV+9GPjtai5b9L9/OP1VxJlOyZrCHQCjkBZ4owKzgyndO2lMEmjklubD3pyIhnTVLnyJMI/WsiX1pFY4akYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OsQ0O5bqIOL5GtgffY5x7e/UIRTUtr+D8gtQrbphUw=;
 b=mvGoN/lEkZyzMbanX0ylWMZfmMjUgUy3jTSGloQX8ZgjpbDrNvX+m0EBHPI5SE9856pBldJtqM+CBME/hluY9UdB6426a6sUEuIqplpbmm1TIJffXVVUrJvtn8UFc0ROhW+Uj+mszTDACrtzryufPTQlmvi+DWktlsuMgGCH2FhtTqwCkF3om8u2fq4EYRFVP0fpJ4Uq1afw7wicfw83ikhbUXgiNGevl0bA6DfK1KF4lCLh8lsQYw79+iDK9dIL/brhNbSXdNJCvrMYfwCXML14SypjpgBsyULehooBqv4PACwhHW4g4kuI3lKrah5N+lETWrsVrlAEJQ8HbMexFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OsQ0O5bqIOL5GtgffY5x7e/UIRTUtr+D8gtQrbphUw=;
 b=V14Nd/8cLhU3VupjAqQgW4hLiXISA8t5FKprsPKFS3eeBo4dJh38oiHPZ5wKoQot00wm6gzvCCOIq0P5BrhSTigeBfaIOIG9rQ+naNmkJGDk85j3r4w5QqWS/HXcUwo6mhyAjfb3Fuhc6Cw5SmgMVNf0J81GQRWrCkQgYC5oGXcmFTr1vhN7Xw0heg/q0n5OyRCoc/fHNO3xu+0dkcSD1Lznp9+2PvEjYF+9Tn0AAA+1a1PCrQyHA2a+lTfTH559KPPSTqWAI2AhOQYefTggLpoqnCD3damrvSwH6N7JQg79ybHcqC6oO7imgDN0GmOKbhVX4s5c0426WD2x1ULk7A==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 19:22:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:22:31 +0000
Date:   Mon, 10 May 2021 16:22:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/core: Prevent divide-by-zero error
 triggered by the user
Message-ID: <20210510192229.GC1121391@nvidia.com>
References: <b971cc70a8b240a8b5eda33c99fa0558a0071be2.1620657876.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b971cc70a8b240a8b5eda33c99fa0558a0071be2.1620657876.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0122.namprd02.prod.outlook.com
 (2603:10b6:208:35::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 19:22:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgBU5-004hqw-Jq; Mon, 10 May 2021 16:22:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb61705d-8988-47c6-7523-08d913e8f4de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB449946185E9E7572A9F05A9DC2549@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcFN+xlFmNe2/mVaGT8nXxAKcPZMa79ExnX8HoQuE0BJbLgoMAYcMZClg0Lh/SdIr/otVjTkxOdP8vFz0cefyZtP97jo3ohBxJvg7PbWFRoDzymt0c1UkO4Bse8/rfrnDtQfdbxRgoFxm1DR2jArQUeDoVsA4EwhYHHu/RFa568l6DlDK6Jco1Aaw/koDpTzrrhCYtjBUyjzASBz9wxKuXsfSJykCA+36KOxW8cKJkUksya4voJG+tVrVUQ0H3KqcZiVgb6bGYQQVLyVNt6pS760l7lTRjuJaZqPY/U/I5dZMcfkU7Sh/hz+tgpAzXutuWxuoNtZzEsDaAh5g0QNdatlAF4L40vyPrjLt6KbonA6bdInTEpBY45LZWYPr25ucv11zB39EmN83jAkcv8jyOLQSMLEXnZFGO1UJwKwaxmoCgGzj67wS3bLzvCIFhcPX17yE3WrAHhiAhtKnYgOiQ6vUiskEx1x0tphZU1Y4vdNxAL2l8Y7RGkLEXriIe/cXKTO7UK2HalFgd2tFVSNyeD7usd7Y4EsnDFplZAw47ea4Q4a7TtrbfC4PGW0lllmTh4zySA3dOWV4eWaFdlonKLDZY+SOyvtKqePoqP8pn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(83380400001)(9746002)(2616005)(8936002)(498600001)(66476007)(38100700002)(86362001)(66556008)(8676002)(2906002)(1076003)(33656002)(186003)(5660300002)(26005)(36756003)(426003)(66946007)(4326008)(45080400002)(9786002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6w5xTAL6oYq2S/m6ldPpu7JlPYZ6sCqQfE62lpXkLcnSXzcaLvJdsyEQLmhK?=
 =?us-ascii?Q?1rHl72pO9CvET/V/uU+35frndF1kOv6rrNidjrmDPJWeDXf5C4OaCcMV2SZK?=
 =?us-ascii?Q?RCwXT72FcXd+iwGH6/WMuJZh4tOTDfoEwAD9Wh7D7XFQxfbaB1XxcgwK9C3c?=
 =?us-ascii?Q?7izQB52jShJbuoRMa53HcNbX4+QGa2tLN3w23IAvsAm87NYnxM1YMBgJ3Lz3?=
 =?us-ascii?Q?hpwF5mFQCMS9gSvT6wIH9CQOHfB2H4MmizW5JTTjPuibXReZ0ENQ4Iv7JzZ9?=
 =?us-ascii?Q?nPFj9HSqPwrGsGS08GpAx3miBrS1c6FoKmvmfQ7Jmw4/rx4bX/P6VyYFO0di?=
 =?us-ascii?Q?UgY22kRWeZdGN+Ae+jpfEPAv+snzryLM3lotWwaRpkgGrnkvC03DufLm+AZw?=
 =?us-ascii?Q?80tUIS4uyuvZX8c/P8vwGVPMs7Hw2keA2bjzqWsw/uP0qLVWGN13HbLV0vF3?=
 =?us-ascii?Q?VilY8UI6U2HCnLeNjA26XCj3AGFFanAzs0mqlcoI9C5bH8OpglQ7ql1oZHEa?=
 =?us-ascii?Q?nDpoZ2KoAh3jyBR3ocgcRYtCorw4rrJWMVCeeoLXJG3aU5noCXZNnRANFviP?=
 =?us-ascii?Q?DKodR0XPgZmeBRyIDxwkQnk8oZr6SuuCTcOKB+vKHTVEaZWKGWx0UrU2ZJWc?=
 =?us-ascii?Q?Zd3H07nKlLpHZxxPLOaYRm47bGpVtTZrK43WEb+1SsF0pZS07r51HeIeX2rQ?=
 =?us-ascii?Q?Dw2IRaKB4G8W0mp8MPGQid5VEy+H09V4Rmm3Ob+OpXib5WzJbDGY1ChZ85Wi?=
 =?us-ascii?Q?mnjdHBdvjuNKViTk81ZmS7rWnIOYoQlrYVfHnTIDx5zNR2d68SF7WHHuG5TD?=
 =?us-ascii?Q?jEcFM2UafPkVAJOdXTvRnaIClAkDMsq4JvAiAeHvsh47p7DshtFF2LVJBcwp?=
 =?us-ascii?Q?/NIDOxUuVtna+eiCDGYe5Rumi9jF2y9RpQK+SiWRkUPwPl9ynHAkiND0QBQS?=
 =?us-ascii?Q?j2gu1Mb2o9dGgJLk9znBwQqRjMT4VzyzVQvTLl0so4KjAYNcpwSK4jx516f2?=
 =?us-ascii?Q?4kEforvCfxYneVoNwt7LOzRPAzCHNlA5N2bwn52RprMAB9adxg3g76mxd1ZF?=
 =?us-ascii?Q?QYsaBLZiNAGz1tquupkRhwhmYEsAy2CEEoEg1JuHtfYd4Y5iARkblZdfGkvp?=
 =?us-ascii?Q?jiMMGmIwlfaraVfekGQye25dNkOFeN9+JS9Q0uGRpmRkhcd2GJZe1LnkOB/b?=
 =?us-ascii?Q?OzyMi+WOOZElXTWnI4QwX77HsyDeAw+N8SQ8rVBUgd9G+NEJp6xYqBvLPWxZ?=
 =?us-ascii?Q?me+EscN2+NDSffm1wIUkOEqnM5m2TGgrzwMc+/VNg0MzhD46tyLkw0sr11pS?=
 =?us-ascii?Q?wR1xTj/ArebJubjDE8I898JX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb61705d-8988-47c6-7523-08d913e8f4de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 19:22:31.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0dGhd6Td/GbZf/qpPV8J2/zNOE51+vwJQhct7Hmi4I++zut06hQEH2adaLsdJUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 05:46:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The user_entry_size is supplied by the user and later used as a
> denominator to calculate number of entries. The zero supplied by
> the user will trigger the following divide-by-zero error:
> 
>  divide error: 0000 [#1] SMP KASAN PTI
>  CPU: 4 PID: 497 Comm: c_repro Not tainted 5.13.0-rc1+ #281
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:ib_uverbs_handler_UVERBS_METHOD_QUERY_GID_TABLE+0x1b1/0x510
>  Code: 87 59 03 00 00 e8 9f ab 1e ff 48 8d bd a8 00 00 00 e8 d3 70 41 ff 44 0f b7 b5 a8 00 00 00 e8 86 ab 1e ff 31 d2 4c 89 f0 31 ff <49> f7 f5 48 89 d6 48 89 54 24 10 48 89 04 24 e8 1b ad 1e ff 48 8b
>  RSP: 0018:ffff88810416f828 EFLAGS: 00010246
>  RAX: 0000000000000008 RBX: 1ffff1102082df09 RCX: ffffffff82183f3d
>  RDX: 0000000000000000 RSI: ffff888105f2da00 RDI: 0000000000000000
>  RBP: ffff88810416fa98 R08: 0000000000000001 R09: ffffed102082df5f
>  R10: ffff88810416faf7 R11: ffffed102082df5e R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000008 R15: ffff88810416faf0
>  FS:  00007f5715efa740(0000) GS:ffff88811a700000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000020000840 CR3: 000000010c2e0001 CR4: 0000000000370ea0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   ? ib_uverbs_handler_UVERBS_METHOD_INFO_HANDLES+0x4b0/0x4b0
>   ? __radix_tree_lookup+0x190/0x190
>   ? write_comp_data+0x2a/0x80
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   ? __bitmap_subset+0x9a/0x130
>   ib_uverbs_cmd_verbs+0x1546/0x1940
>   ? __kernel_text_address+0xe/0x30
>   ? ib_uverbs_handler_UVERBS_METHOD_INFO_HANDLES+0x4b0/0x4b0
>   ? uverbs_fill_udata+0x510/0x510
>   ? putname+0xa8/0xc0
>   ? kasan_set_free_info+0x20/0x30
>   ? __kasan_slab_free+0xed/0x130
>   ? kmem_cache_free+0x94/0x410
>   ? putname+0xa8/0xc0
>   ? do_sys_openat2+0x477/0x780
>   ? do_sys_open+0xc8/0x150
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   ? restore_nameidata+0x8a/0xb0
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   ? do_filp_open+0x166/0x1f0
>   ? should_fail+0x78/0x2a0
>   ? may_open_dev+0x80/0x80
>   ? write_comp_data+0x2a/0x80
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   ib_uverbs_ioctl+0x186/0x240
>   ? ib_uverbs_cmd_verbs+0x1940/0x1940
>   ? fsnotify+0xba0/0xba0
>   ? write_comp_data+0x2a/0x80
>   ? write_comp_data+0x2a/0x80
>   ? ib_uverbs_cmd_verbs+0x1940/0x1940
>   __x64_sys_ioctl+0x38a/0x1220
>   ? generic_block_fiemap+0x60/0x60
>   ? putname+0xa8/0xc0
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   ? do_sys_openat2+0x47c/0x780
>   ? file_open_root+0x420/0x420
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   ? cgroup_rstat_updated+0x66/0x1a0
>   ? do_sys_open+0xc8/0x150
>   ? filp_open+0x80/0x80
>   ? write_comp_data+0x2a/0x80
>   ? fpregs_assert_state_consistent+0x90/0xa0
>   ? __sanitizer_cov_trace_pc+0x1d/0x50
>   ? exit_to_user_mode_prepare+0x35/0x160
>   do_syscall_64+0x3f/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7f5715ff0f59
>  Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffd33031858 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5715ff0f59
>  RDX: 0000000020000180 RSI: 00000000c0181b01 RDI: 0000000000000003
>  RBP: 00007ffd33031870 R08: 00007ffd33031950 R09: 00007ffd33031950
>  R10: 0000000000000000 R11: 0000000000000213 R12: 0000558a0989b060
>  R13: 00007ffd33031950 R14: 0000000000000000 R15: 0000000000000000
>  Modules linked in:
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  ---[ end trace 7776f38b0b269133 ]---
>  RIP: 0010:ib_uverbs_handler_UVERBS_METHOD_QUERY_GID_TABLE+0x1b1/0x510
>  Code: 87 59 03 00 00 e8 9f ab 1e ff 48 8d bd a8 00 00 00 e8 d3 70 41 ff 44 0f b7 b5 a8 00 00 00 e8 86 ab 1e ff 31 d2 4c 89 f0 31 ff <49> f7 f5 48 89 d6 48 89 54 24 10 48 89 04 24 e8 1b ad 1e ff 48 8b
>  RSP: 0018:ffff88810416f828 EFLAGS: 00010246
>  RAX: 0000000000000008 RBX: 1ffff1102082df09 RCX: ffffffff82183f3d
>  RDX: 0000000000000000 RSI: ffff888105f2da00 RDI: 0000000000000000
>  RBP: ffff88810416fa98 R08: 0000000000000001 R09: ffffed102082df5f
>  R10: ffff88810416faf7 R11: ffffed102082df5e R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000008 R15: ffff88810416faf0
>  FS:  00007f5715efa740(0000) GS:ffff88811a700000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000020000840 CR3: 000000010c2e0001 CR4: 0000000000370ea0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Kernel panic - not syncing: Fatal exception
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Kernel Offset: disabled
>  Rebooting in 1 seconds..
> 
> Fixes: 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query API to user space")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_device.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc, thanks

Jason
