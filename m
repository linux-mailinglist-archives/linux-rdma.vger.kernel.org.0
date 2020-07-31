Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B361234B70
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGaTHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 15:07:20 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:64672 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGaTHT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 15:07:19 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f246be30001>; Sat, 01 Aug 2020 03:07:15 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 12:07:15 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 31 Jul 2020 12:07:15 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 19:07:15 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 31 Jul 2020 19:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CydMeot5Ldn8y5AM639+nPLGfByK2v2LQztQvJJb2yBF+gzdylZ6ONUPYPpAdCE+Me0R+aIqe57+O1fpY49jIvYJiT+TRNsSbMA3n+A8r0nGt6St505x20BbQRObsj3iGNEhShN+eEzEIPvOtXWlIfxhmQ3su6gqbNEiP6DzrsoFyZx2EzK7w8uY+XsFzbmTFevJo9iJnOBN6nUjD4nrtLbM+2/lMSd5q3K0a6ao2trzzMRhtt5EEfZiVO6Gup4NpO74YkMupqXHU7mgB+WpjbdpD6shRapQGza7rOB7u6MQfx09VcNCwq8WKmqTVmyO1UqTLpndMNqIDB1JcOqpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vohw9Kc6fT8kr96kOmpUwyaa1nCAQ/DhtbMjIvPaRQo=;
 b=aszpW8hbKNoCmB6K85CtrA6O0AeVWL7TzW7Uq+R6D5oykXqzSB6Q19jFV1i412ddh81W9V7cM1jdeP15yHewYpwjbEZ0zPZnj+9D5AdlmUmoys4l0PzIM3Skc33caDweM1EwprEkyJdls9BkkHOu1irNDlRXFj7gAuiZIGF26+2ee8WxTDrX9xfM4yZvaPkBHMdG8KzKdQ8soBRPAouB8czFBB7cjHp/sB8M1IBDL3HEKQ0KZ9J58oc0GVRVYRW9Z2VWMmvazDCbMD4oMhCM3XHWxfHUmiBKr6z2CmsotPE8XAeuJeuHVHNXtPrYUhPVthKSTelrKhjzgMZCy0mF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Fri, 31 Jul
 2020 19:07:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:07:13 +0000
Date:   Fri, 31 Jul 2020 16:07:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] IB CM tracepoints
Message-ID: <20200731190710.GA520925@nvidia.com>
References: <159526519212.1543.15414933891659731269.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <159526519212.1543.15414933891659731269.stgit@klimt.1015granger.net>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 19:07:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k1aN4-002BXb-Rx; Fri, 31 Jul 2020 16:07:10 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e66bc10d-b6f7-4f92-e8fc-08d83584ee21
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2602463F3562B3684DC319A5C24E0@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sb3I7NMCW9uabvXnSHNfbFUx4Kpgharpv5KzKcb1g25XxnrySeyNeS0bakIj9HO166uXFe9a65MwTHYKnRFrCrpLrjVEs8hkQJqIuqLMteJcHk3RvAkNzCEzYlJe/cxOyI68movh0Vts6qm9Ni5eCGb+CaXWtOuyKnDfFO2WAgwkyf0iur5F0Ya0CVzTKsQslpBkM+4w2JmA1wc8uZnpZUlaoKy6xNXIsBUP61HAXd0aAzQLi7Bo6zjyK0DfU9gMvnsVEk3YwaW2pYjZ6AQu1zcRRmgY0UOw9ufvE/Yd+2e2l9gl2kEzwVP//EJzUDL2xPDgJkW6wFbBRJV3jpPmGVZmUbkGA4g5jIqaBnAs48KfSZlrwYUlLpn57NkuJs58
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(66556008)(66946007)(86362001)(26005)(4326008)(478600001)(33656002)(186003)(8676002)(83380400001)(1076003)(66476007)(2906002)(316002)(8936002)(36756003)(5660300002)(2616005)(9786002)(6916009)(9746002)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RU9o8FwSvYlpErR0ewlt31m4fZy9szy+4e62giXPxNUj8nsREVrpKdfDaiuaYds0tS82TOGCJ8NPk9ZkGvQiKKG3PqMSWMPkFyeSM6oy2Esm41f0h2lkXP4JGxEf128ztyFAGiBtS6IgmQfyK4wsJPQGYREJ7ajnO/UUDcyR0wFmReoL30FdSbVG3xS0lZrd9V+yrLphsRDoHxlf/ga+zjIqAjf9JoSrkmucPRrdzZ+3UJwRM07Vl1jZsDpMgjBSu4XuZO5QidBOgknjGITCwC5j1bi+zZVSxpbEsR3Mzjy2V5QFzeV6g+ICtUqPVHJmSBKw375wZpImpTwzF1C9EUbTwuoFacHuiPZUEej485k9NQN7eu3X2fUtjNni7mo4vl18tWSFZujR2/aTjL2TbJ0lk8Dp9DxXmr3wuo0JGEiHJ7yrceHfrIZY0fFbx66nvd5akxyEWby+CD27dSzdVpqsB4TlsmB7WNwx4GbMsL0=
X-MS-Exchange-CrossTenant-Network-Message-Id: e66bc10d-b6f7-4f92-e8fc-08d83584ee21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 19:07:13.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AzHG2RNADsRpJYEG5F0OsIhHPO6ZdV+K+koCz9FGlMmNA73CnIFHS+1RDGuYx4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596222435; bh=Vohw9Kc6fT8kr96kOmpUwyaa1nCAQ/DhtbMjIvPaRQo=;
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
        b=dGASICWlDYCmE1L8gD4Cr6A21iOQ7j8L9o3SY+ioyr3q1+v7owi8vQchjELku21Q2
         doLjBF7PmxTXsQ6gMbJOD/e0ultELFtpAfzQHdxJTplUpfZeEQpz3awm+L191OMWn7
         f79hjPd7hZcwlBL/93hYkZuK/nyi4M235eRpYNA4zZlIiOTZh8TlVm9BeDkldE8qoK
         xUcSyMM4uEaAAIs2KrE8cn/l/hn1Pe89wTKULm+c1wYbkzeY0TSi0d3ZHEX1mVLJ10
         8pDAxuK/NAbkzdXg0hO21t0m0H309apNXmd+XNWjBZcQDiuiiJ+367ELyErdvmfYq+
         nq+XBIMW2+L4g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 20, 2020 at 01:16:28PM -0400, Chuck Lever wrote:
> Oracle has an interest in a common observability infrastructure in
> the RDMA core and ULPs. Introduce static tracepoints that can also
> be used as hooks for eBPF scripts, replacing infrastructure that
> is based on printk. This takes the same approach as tracepoints
> added recently in the RDMA CM.
> 
> Changes since RFC:
> * Correct spelling of example tracepoint in patch description
> * Newer tool chains don't care for tracepoints with the same name
>   in different subsystems
> * Display ib_cm_events, not ib_events
> 
> 
> Chuck Lever (3):
>       RDMA/core: Move the rdma_show_ib_cm_event() macro
>       RDMA/cm: Replace pr_debug() call sites with tracepoints
>       RDMA/cm: Add tracepoints to track MAD send operations
> 
> 
>  drivers/infiniband/core/Makefile   |   2 +-
>  drivers/infiniband/core/cm.c       | 102 ++++---
>  drivers/infiniband/core/cm_trace.c |  15 ++
>  drivers/infiniband/core/cm_trace.h | 414 +++++++++++++++++++++++++++++
>  4 files changed, 476 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/infiniband/core/cm_trace.c
>  create mode 100644 drivers/infiniband/core/cm_trace.h

This doesn't apply, can you resend it?

Applying: RDMA/core: Move the rdma_show_ib_cm_event() macro
error: sha1 information is lacking or useless (include/trace/events/rpcrdma.h).
error: could not build fake ancestor
Patch failed at 0001 RDMA/core: Move the rdma_show_ib_cm_event() macro
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
 
I guess in two weeks after the merge window

Thanks,
Jason
