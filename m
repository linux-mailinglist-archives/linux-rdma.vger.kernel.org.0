Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D54485A0C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiAEUd1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 15:33:27 -0500
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:64737
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244036AbiAEUd1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 15:33:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4B1S2U54Tv0snl/gdTNy+PInvMQsrgkS4r+Kgu2TXEkDhODR8r34bgYsUSPSFFBlm2bZPB1WsIxoswEh7/tZGKeWBUt0VkEV+oXimfLPX/HuNh2olzkWfMT+HR/cDh4PFgdPgfNXJmJtzfhVQZYpbmSi2F0nq+mK90UDkrrtBl/gVEyDl+V8Ja76JXc2pkfNKV9MZOGANiWb7dHZaiHl3Xa99Yeo1Qljvc5s0qHRz1xFMO8BoTHcW9I8buTodqK2augiagnef2wOLxI43yVZWFsqwDPhz9aFglvYitZOOHXj3LGGz3FMQIx7SKgKffT0MA/ojHvS2eZsCNEi7+4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOEq3pD9jJRLIKnHjRiUtefP+yUmVPpXfXMoZyg1rvI=;
 b=fOmm47q8oEVST7wvVrICn1NcpPKyhjyfRUfi06nAPMmZbRrD7aJ1NbYLindxgqTmd9NTpVIpzlQdITDsqzVvSDxStZWD28E0AyB+h/PH1fEGH5aQwd1kPMld+vQZiL0Dk5lE574fPZBn25C2rhTs3mFz9YTZin7g6PA+cZoJUUXQU3BcuJv3Klad6kNQgyqAb3RyhVyzpZft+DPBLoA/03ubs7CJwpFQRr5vHE37OU344Ra9YF3ytdvEKLMGt/OpkiFRhbWb/y8MVNfFv1htmIk479lEOXdMaYQFbw/queCjJV7i6Zresu8scebY7Xb+leQFv5Dr6vielG864HDemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOEq3pD9jJRLIKnHjRiUtefP+yUmVPpXfXMoZyg1rvI=;
 b=aiymJzVbye55/lesiCpn6M1z6/c4XqLDSQOqQtM115xOMmsw+Dowlmt4WZvN8lVBZrk6/8THVcUHnYe9UMBZWGt/22T8Vvtr15ITiC/U9UJzRFIZ2TmAK753HDWuJbnTW7UKlmMU+r2oRinMZK2N4GI5/bVmUv768uYfHtX9D2tP0ypk7Vwk+egGmuHCBG/34QndFoQLqLhuIM6lfcRX+uVVRjnV+Lo/vyUTX0L3GUTqkLZUjcCTVWYqdi6zb2nl4ER2vinyrJZz+lBrhtZiXnud60eHKUtqZgSrn1qjUu91jPFumWv2mZ7IFrzM0g1dd+5Yq9RyK64Ujv58rVi2Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 20:33:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 20:33:25 +0000
Date:   Wed, 5 Jan 2022 16:33:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-rc] RDMA/core: Don't infoleak GRH fields
Message-ID: <20220105203323.GA2887765@nvidia.com>
References: <0e9dd51f93410b7b2f4f5562f52befc878b71afa.1641298868.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9dd51f93410b7b2f4f5562f52befc878b71afa.1641298868.git.leonro@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89555365-e668-41f1-39ff-08d9d08a9f9a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51927CFD3BA95E7E19DE49A1C24B9@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvD8tZGaP/COBdd8ECSln8Aw8pYRi0eH2zhQmfsWkJiz0P6ej8pFNnoPldqsHtPXaa+wSIooNV9Ig9nhzICna46cjPgTVkKTws6DVL+iT5l0JJ1wRKMB919BLplj3AVz8qyVdHXXIh917nveMLMUw1LRahlXqcM8JiN5mytm+dFIkwegwM2aWhfm7p49Yben6A7gI5/PPGTJht/RSSYQHq8To4pp6wsatCfbnPgWU0/umIZ5yBaHUSak/B2rV8Q4Hadijfkwp+SNvVrZsl4xDQPgFyikULTBQnQ/6NI6QzgBXr/WWp4FGEg9kZleN2K1WChRYgC4RhzaOAIq/zQPEd/kG7Dc3aSE/kHJq28oXACtymVQHZC5ar1C2VSc2QIHUZmvV17W8sqYKfrKehjDQlxYnlwpZMf8ai4UUDZC6WGteiRy++yyFU4jJrf4W6Rct+oCVx0j2O783CLCoxHjO5QAKrRQ2HwS3y/cgS+JIXEBCLW2yx0SFVd7nhzgsQXH6A7H68Ku/1BUeVFp1wmzdJ3+QFxe8C5veCxV0/faUKepyNoreiXr4cW1HgYLcG2qeaqN4WwpQfoXZ28R5XaI4TzUiL3TbhR1qjJJje50m0lbL35PaEDqMnU9vELonmEoJiDDgtPPb97wxH2XuVsFRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(38100700002)(4326008)(6512007)(2906002)(5660300002)(1076003)(316002)(186003)(33656002)(26005)(83380400001)(36756003)(8936002)(6506007)(8676002)(6916009)(86362001)(2616005)(66476007)(6486002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5i+Fr53LRMRc6A+1GrCHL7rxB+307qptZLNp7aFIwlPdWbfjvC4ebatjuWTA?=
 =?us-ascii?Q?p7jan9vlu5p8OR0FcNiD3LIIF0wfDSwxFghCHDt0hqNWQ+1ZuT5ZHZrVpyrP?=
 =?us-ascii?Q?R+6imxxgP2zo8NTcH6HYDq8zzGrjQITILLd+5/nVjm894U6mWCn0iRiP5E8f?=
 =?us-ascii?Q?jOxd/kUZBgS3QdBicSgx+0P8zDA63xclrOGgrPRbrnDg6K9huHpp68b/QuP7?=
 =?us-ascii?Q?/3rcvnFpIekMY9D101T1r+anC5K0VyWzZPGSnxQAGIQc4rowsk6cz5JpeW8J?=
 =?us-ascii?Q?DqV+46JYv0b0VtRbPx5TtELnocOzb1lzWyuYZRz5f+ws1dDVt+xNzjok6htb?=
 =?us-ascii?Q?13JtaKlsun+HTC9PDCpfZHiemCR/B0C/VWUXT/vcn1kkx14P1L0F5gQGoHqa?=
 =?us-ascii?Q?DyqbY1dd+pUWNR6DOehbfDu8L5WAfb6Pn9K2JO6mKoI+ahS6pSvRGXongkee?=
 =?us-ascii?Q?a7WHlfI2o8aoLX4JZ8VNg2uylKPNLv3p78+UBApE3E1wGRvLLe9WY+o/e1ZP?=
 =?us-ascii?Q?FsKBNCEHrq9aAORLobWYxJu1tKo/MvXoR6mzk2pQY3wf5DedpchQHvZQyMAi?=
 =?us-ascii?Q?CXDINMrfBW0wgcnCtpqwBBFrbRVE9gG/vU4rrWb5mhvgKbDrJzRdbDaHFAaX?=
 =?us-ascii?Q?Kypr79ypHB9ZqWhM0Vulq25J5fC8SoPyIWj+ynyynK/U1Ss1mye06uPT4cwM?=
 =?us-ascii?Q?OGDOReWFDwwtCf4AYGmoehLSWvZ2rMc6AM4v781PtWoX9hu8xIvlAeEyZ0uc?=
 =?us-ascii?Q?CsD0BnbBaX6vEGArXVvJqkFJmf0dI4r8xqxLltj/sSboVPS9pbH82sXzVRrn?=
 =?us-ascii?Q?BxIORofcdPuSsrtZgXIUesEytnXKWIBPCcw7ihh30/h9CBi59Ve/70e6jEQg?=
 =?us-ascii?Q?185NDSGkLaQ/MX5cOQ4sLHYWOhbudgIAExoS1BTaNTaMhKVg4QzR4h/2BnBJ?=
 =?us-ascii?Q?IAkOeU9VE/9zY4nEV0pcbb16tyDkAaOgMNxYd+5rVc/g3D5oELzTCK1pQLsn?=
 =?us-ascii?Q?GESZ5PLEFwriXo15epLAFRhvkOL83dyJnL45Tn4/suuqqEueJ5ZlLQa7dDkc?=
 =?us-ascii?Q?auMxtJkmFbliVx+etG0vy+e5w0GEulFNk/uxjEa4D8eieznk2b9NlsSvqw/G?=
 =?us-ascii?Q?r02yFx7cPzpVLLHiinOimyCoRTnzvD9EdyTB6qVDCzQDhXFVAQPR5VhZ2LM5?=
 =?us-ascii?Q?MqLv47ZE0+Xqt2Hdq0hkCPkHioaGN5dFslDnh0z/GgjbAFRvhN5t63ShKKR7?=
 =?us-ascii?Q?MMEh7hTVOi1VU0RLm5f7J2l4v9YtxPRDN08Kncd0MiGmNe4BfY1Oef+Wi5Wr?=
 =?us-ascii?Q?YzYyE42H7ch7odgGlfqz9VlgrsjrHWpUexoinMxcVWXCF1QuanXs74ZMnU/r?=
 =?us-ascii?Q?s2LMXj+dILJOpmOQMB7XBa+4I8zMCS/2rcLfxhLQEIZrrVDAW3waxc77F3vy?=
 =?us-ascii?Q?l/8ry2cM+XLo6mG4sCV7eHsaFxNTEYRwHUa52YqXuYf6UyP8yJAardUIr6oN?=
 =?us-ascii?Q?eqGirsz1f+784z0VYNV+6AjRq+jrnwqFKihkFdRdFxGZgtvYarRJusqWl7RI?=
 =?us-ascii?Q?7vUmQqyyo37m/UxlHzk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89555365-e668-41f1-39ff-08d9d08a9f9a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 20:33:25.3248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCNmj8+/XFWx+swVkN34TrjchfRyYEJ3gfTrqaA93UzklyKU5OU6Sfa98F9R+wEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 04, 2022 at 02:21:52PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> If dst->is_global field is not set, the GRH fields are not cleared
> and the following infoleak is reported.
> 
> =====================================================
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
>  instrument_copy_to_user include/linux/instrumented.h:121 [inline]
>  _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
>  copy_to_user include/linux/uaccess.h:209 [inline]
>  ucma_init_qp_attr+0x8c7/0xb10 drivers/infiniband/core/ucma.c:1242
>  ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732
>  vfs_write+0x8ce/0x2030 fs/read_write.c:588
>  ksys_write+0x28b/0x510 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
>  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
>  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
>  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
>  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> 
> Local variable resp created at:
>  ucma_init_qp_attr+0xa4/0xb10 drivers/infiniband/core/ucma.c:1214
>  ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732
> 
> Bytes 40-59 of 144 are uninitialized
> Memory access of size 144 starts at ffff888167523b00
> Data copied to user address 0000000020000100
> 
> CPU: 1 PID: 25910 Comm: syz-executor.1 Not tainted 5.16.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> =====================================================
> 
> Fixes: 4ba66093bdc6 ("IB/core: Check for global flag when using ah_attr")
> Reported-by: syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_marshall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
