Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF74C1FFA01
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgFRRRq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 13:17:46 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:46599 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgFRRRo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 13:17:44 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeba1b40000>; Fri, 19 Jun 2020 01:17:40 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 10:17:40 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 18 Jun 2020 10:17:40 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 17:17:34 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 17:17:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWYw8YfoVvvebnFr3iJh6rI2oT7C3VShrNTNE5CO9WlSMFHEqJjp32gJlJzR7pUy/Oa8TbwargLTBY8mhFEka6+8iNS9w9pyto9zLENF4Pi3fRbKUKL5ZPavV2eUmj+hCTa7rT4PabW5JsbhwAap5TvDAE852hkJNOWFLf9K9ximXzxOKjqZOqM8zG173YiL73m+srD49R1Q1mgFcbdK6XgBq7Fwf0Ytk1rKk1i/kF6Th4ZV+kwwxtQnLx2qD7T5MB3tEGsM5yN10byH8j73jjfndupXKMVV4ycFvTaEbuyuITTbMvGye3c6lFeQT1F8caSpusiH9x+jJXH3hetVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhtOK1ykxCXUH+WLZhKmx5uY3Na7jCUJk+U5vOSoNbQ=;
 b=CZLbYHvlTrBZaiCLDM9mASxx1L+pAjE9PVlvZxTvJdjExeqw+V6q2UsULed2TeZCkDnlPbOs0VEcW/fF2uqRT/3u4KLkajgGjTeVN9v5ZaXOHbn7Y2PzJRj0gCokHGmG63qqcQ9icjVOddvm8laT1ACRHhbIKyir8vUykGU2hZTaObRJa/RXNaav3BhqU9PrYM+eyOE+NrunLCN2c/NNL9rlMI+3Ii0wsuu6Fg/xMuDhO2UjAKagUtNl0JwvABWBFnWofSR6a4SjJ14HXuMNB5qUb1vUnhIx2qgyj49oFAVAxbqX4j060S6CkvMFHlWNc/KmIhq7e8RX0sN63tj1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 17:17:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 17:17:32 +0000
Date:   Thu, 18 Jun 2020 14:17:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1] RDMA/core: Check that type_attrs is not
 NULL prior access
Message-ID: <20200618171731.GA2437577@mellanox.com>
References: <20200617061826.2625359-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200617061826.2625359-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:208:134::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:208:134::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 17:17:32 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jlyAN-00AE8U-GN; Thu, 18 Jun 2020 14:17:31 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 361a2d37-e6f1-4369-4208-08d813ab7cb6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3833AE2D524895AF82D2E2F5C29B0@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGDVas+jIO6OthK9jmNmHOJNXh4nB5g3w/QsPm3vAl8HzU74jI5mK49D2qGTlTrvwE0i1nTAKGCg4wjWgBgcX1rWBhjH+F+amG0b7ohFhNxvyVhVGs62vmcKHnHxGqcUN9Thwetf8dvQZ/oFUkrUEpi5JoVc4i6cICS/AgsKYniZusyNtJ64/OqoHRvTIpV8zwlX0yPNbBDeVF0M9Y8HpAevrkjq669sDt5Gv/8hRSUCMLi+DpmrtxU4Nf0Fh2R0wg7Bt2OtR8pOE2hv/aNEr4n9QBd4SZIT+GA/gAZBt3lVV7a3ZSdQTezrznCi/uPdaZ3uxxQcpXdV0ks6n3PAOYP3+kjRU4mtgRW+8h1C9/KoP8XApvYFMSgHOPHs79zY5kCjMjA5WGEYvTP6Xnr88A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(136003)(376002)(396003)(39860400002)(8676002)(1076003)(36756003)(5660300002)(2906002)(478600001)(9746002)(9786002)(6916009)(966005)(8936002)(4326008)(9686003)(316002)(54906003)(426003)(66946007)(66476007)(66556008)(26005)(33656002)(186003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sX0gZXzfnPV9MdynQ+hErvFZaWt58+SauOoiupCuse0ivhWYbUPdcO4tesyRbxH67kVfqEd/R50Od91fKWmhCWqlZ04osdXgsZyDWY1uxqdNhRNchj4i9ezBiC50MQ6OWun4TQi1in2sp/eTM55WUT9kK7gzbG/xd0xWhLfbNPwzzR8zOiTk/O8eEvYIBDLBmjKtP9om7i3sXzyHixnOoO9utMIdsOd+6+hJc1Nmw+edpQ+fIRROPlr0nNtp5QLd/WR9sk4Kro+8vlhUy5Y/qoANfhheNYDh+ly6TMC7kHMX1FVfYoXBcyVbVWD6nZj0MR49nXkbXN6SbdWfbhO81nAoZNRKviwDn9M24mUwtQlj8y92DKFrMpXg5LGeuO3k6vFFLt9081w0QQKguhc3e7ZqCssiiRXr50tmtHoGQLkDhtnx/pVjlxomT36YrYYm9kk+/KIhno4HRX+KjA1Y6K9JR1YNkvAWEWsHm/e6ds4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 361a2d37-e6f1-4369-4208-08d813ab7cb6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 17:17:32.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vViCCkOnY2kS83MPDYQSWiOfsRAAF24TPFfswJruQfgMym2UQEQwPyqsSTIJ2Ejh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592500660; bh=DhtOK1ykxCXUH+WLZhKmx5uY3Na7jCUJk+U5vOSoNbQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=dPCNpscCnNVRIEZdZcohrPhbTALagriVln26ndpKuhqMhMXEeJZmmYt6rEl3JybgV
         N8KOX94FmXxvxSfHpR2eykTmR75le3prjk6lDz2gfsBQRZGen8W0b7pT057KnShUR9
         U7p4wvm5qSUSUmtxw6MG0mIkIj5z6k6EOUqIlO+USdVLzXCkf4NHE8rbIVnchE7nVq
         zwsj5UFYjKB4OGhwDNyq6My53ce9PW+N91VrgwMBHVj9hqaV7WT6AS3o5zM6D/SDeR
         ZYR5S/hPuS898/RlwnMsC5ya6X5TPglqfyQK06lVEzOJjxD3AipJ9iyPULHe6XMVGR
         cJVocbOeSShvg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 09:18:26AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> In disassociate flow, the type_attrs is set to be NULL, which is in
> implicit way is checked in alloc_uobj() in "if (!attrs->context)" flow.
> Change the logic to rely on that check, that will fix the following kernel
> splat.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000018
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 3 PID: 2743 Comm: python3 Not tainted 5.7.0-rc6-for-upstream-perf-2020-05-23_19-04-38-5 #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:alloc_begin_fd_uobject+0x18/0xf0 [ib_uverbs]
>  Code: 89 43 48 eb 97 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 55 49 89 f5 41 54 55 48 89 fd 53 48 83 ec 08 48 8b 1f <48> 8b 43 18 48 8b 80 80 00 00 00 48 3d 20 10 33 a0 74 1c 48 3d 30
>  RSP: 0018:ffffc90001127b70 EFLAGS: 00010282
>  RAX: ffffffffa0339fe0 RBX: 0000000000000000 RCX: 8000000000000007
>  RDX: fffffffffffffffb RSI: ffffc90001127d28 RDI: ffff88843fe1f600
>  RBP: ffff88843fe1f600 R08: ffff888461eb06d8 R09: ffff888461eb06f8
>  R10: ffff888461eb0700 R11: 0000000000000000 R12: ffff88846a5f6450
>  R13: ffffc90001127d28 R14: ffff88845d7d6ea0 R15: ffffc90001127cb8
>  FS: 00007f469bff1540(0000) GS:ffff88846f980000(0000) knlGS:0000000000000000
>  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000018 CR3: 0000000450018003 CR4: 0000000000760ee0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>  ? xa_store+0x28/0x40
>  rdma_alloc_begin_uobject+0x4f/0x90 [ib_uverbs]
>  ib_uverbs_create_comp_channel+0x87/0xf0 [ib_uverbs]
>  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xb1/0xf0 [ib_uverbs]
>  ib_uverbs_cmd_verbs.isra.8+0x96d/0xae0 [ib_uverbs]
>  ? get_page_from_freelist+0x3bb/0xf70
>  ? _copy_to_user+0x22/0x30
>  ? uverbs_disassociate_api+0xd0/0xd0 [ib_uverbs]
>  ? __wake_up_common_lock+0x87/0xc0
>  ib_uverbs_ioctl+0xbc/0x130 [ib_uverbs]
>  ksys_ioctl+0x83/0xc0
>  ? ksys_write+0x55/0xd0
>  __x64_sys_ioctl+0x16/0x20
>  do_syscall_64+0x48/0x130
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f469ac43267
> 
> Fixes: 849e149063bd ("RDMA/core: Do not allow alloc_commit to fail")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changelog:
> v1:
>  * Write with error unwind flow instead of direct return
> v0:
> https://lore.kernel.org/linux-rdma/20200616105813.2428412-1-leon@kernel.org
> ---
>  drivers/infiniband/core/rdma_core.c | 36 +++++++++++++++++------------
>  1 file changed, 21 insertions(+), 15 deletions(-)

Applied to for-rc, thanks

Jason
