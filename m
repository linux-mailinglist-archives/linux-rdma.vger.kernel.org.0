Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC4394B2
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfFGSxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 14:53:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36204 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfFGSxX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 14:53:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id u12so3499919qth.3
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IAXIMhx1Ho1tXX3yuNbQZpR3mjT7EcoUiV4uQJ7InL0=;
        b=B669GZRM0M2HSoj+v41D1wzucYrSc6axCbaT1bYaqvkQVupdxZRucQ2q/zPmSqMJeR
         bTD6z6iVSdfqNaNF7aXfbBANEeTdV404s/wHkylcRKZwtJVEzL63TKuMy9tvM402DGm0
         BKjAJSh/CNa6oNxhQBZtxvUNzd32RKujYEoWxPUxM5DiLot1SWxTi4QpAfKIygFXkevD
         56e9lnlf/dt5CpT3KhiIJVazv41G/lpfPdpspPIAeDoAVCVGfh5ua4gDLElychuWJCBo
         wnqAN77q+7Mkuh7hPd1S2hy1bwpypsd0VvO0FEAV0Ht8hwaGfRH5IciD3ckaXv6xAPpp
         d/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAXIMhx1Ho1tXX3yuNbQZpR3mjT7EcoUiV4uQJ7InL0=;
        b=qkF7SdUxfywO7nQ+c/ngOM94f7fs2NawEBJFz2B2i8xWs6SYmjIxTySB0QbrUzX4E+
         w3456JktcBIGm/ROha0ytKhMes58D+Lxr7SdawAuD3YRHET61yEFSV67UwyOYOWixhd0
         q9CtJJx/sqFE7o0jKoxbxrPBgHvg1ioh34BSIbKOaFAY0C66XYaoJN8KhRAqQH9ePfel
         nM3FetZ4EC6edNNJiIsyzUW24kbTyAFoR2eBTzWHafCci6r0BFiwfmj1u4ngGk+JDEeG
         wZqlYQWVUq8LvwawLFcvln5VZbfaEdrwomxMoc2TKEqcblwJz8o3az2gWc2aKDKcfQHk
         KZ2A==
X-Gm-Message-State: APjAAAVpxZrRKXM34Wgm1h+QsBbYt7n7uBej/1e2xrlszU4O3pGk4Vz7
        YVu8ibHOnDbh2JVBJd+3vgkIF5PPqA7xuQ==
X-Google-Smtp-Source: APXvYqxscbTtyyXc7LbdaRoq5kG+cakPFrYmV3e5Kq9rj/4hgjgCaRmcJmkc1hfhPb2cftoXV2vKtA==
X-Received: by 2002:ac8:35c2:: with SMTP id l2mr47461659qtb.123.1559933601899;
        Fri, 07 Jun 2019 11:53:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h128sm1605350qkc.27.2019.06.07.11.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:53:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJzN-0007yy-5d; Fri, 07 Jun 2019 15:53:21 -0300
Date:   Fri, 7 Jun 2019 15:53:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <andrew.boyer@dell.com>
Cc:     shiraz.saleem@intel.com, linux-rdma@vger.kernel.org,
        aboyer@tobark.org
Subject: Re: [PATCH] rdma/i40iw: Add a reference when accepting a connection
 to avoid panic
Message-ID: <20190607185321.GA30601@ziepe.ca>
References: <20190327134254.1740-1-andrew.boyer@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327134254.1740-1-andrew.boyer@dell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 27, 2019 at 09:42:54AM -0400, Andrew Boyer wrote:
> When a CONNECT_REQUEST is received on the listening side, a
> new cm_node is created. A pointer to the cm_node is put into an iw_cm
> event message, which is put on a workqueue and then sent to i40iw_accept().
> 
> The driver needs to add a reference to go with the iw_cm event so that the
> cm_node cannot be destroyed before the workqueue item is processed.
> 
> Note that i40iw_accept() already releases a reference in two error paths;
> these appear to be incorrect since there was no associated reference taken.
> 
> Backtrace:
> [436732.936866] general protection fault: 0000 [#1] SMP NOPTI
> [436732.937891] Modules linked in: ...
> [436732.966395] CPU: 0 PID: 14062 Comm: CMIB Tainted: P           OE   4.14.19-coreos-r9999.1533000047-442 #1
> [436732.970042] task: ffff8bd589113c80 task.stack: ffff99c047710000
> [436732.971123] RIP: 0010:i40iw_accept+0x2d0/0x4c0 [i40iw]
> [436732.972065] RSP: 0018:ffff99c047713b28 EFLAGS: 00010046
> [436732.973022] RAX: 0000000000000296 RBX: ffff8bcf356a1800 RCX: ffff8bcf356a34c0
> [436732.974314] RDX: dead000000000200 RSI: ffff8bd53818b1c0 RDI: dead000000000100
> [436732.975607] RBP: ffff99c047713c68 R08: 0000000000000000 R09: ffff8bd53818dc40
> [436732.976902] R10: ffff99c047713a08 R11: 0000000000000004 R12: ffff8bd538188018
> [436732.978192] R13: ffff8bd53818b220 R14: ffff8bd648826800 R15: ffff8bcf356a3400
> [436732.979480] FS:  00007fc6ceba2700(0000) GS:ffff8bd674400000(0000) knlGS:0000000000000000
> [436732.980937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [436732.981983] CR2: 00007faa0ea26270 CR3: 00000016fa6ce003 CR4: 00000000003606f0
> [436732.983312] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [436732.984602] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [436732.985893] Call Trace:
> [436732.986368]  iw_cm_accept+0x8d/0x550 [iw_cm]
> [436732.987159]  rdma_accept+0x1e8/0x260 [rdma_cm]
> [436732.987982]  0xffffffffc0ad1141
> [436732.988574]  0xffffffffc0ad14cd
> [436732.989168]  __vfs_write+0x33/0x150
> [436732.989824]  ? __inode_security_revalidate+0x4a/0x70
> [436732.990734]  ? selinux_file_permission+0xdd/0x130
> [436732.991600]  ? security_file_permission+0x36/0xb0
> [436732.992466]  vfs_write+0xb3/0x1a0
> [436732.993088]  SyS_write+0x52/0xc0
> [436732.993698]  do_syscall_64+0x66/0x1d0
> [436732.994384]  entry_SYSCALL_64_after_hwframe+0x21/0x86
> [436732.995311] RIP: 0033:0x7fc79f7676ad
> [436732.995981] RSP: 002b:00007fc76d371040 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [436732.997355] RAX: ffffffffffffffda RBX: 0000000028c80950 RCX: 00007fc79f7676ad
> [436732.998646] RDX: 0000000000000128 RSI: 00007fc76d371050 RDI: 000000000000005c
> [436732.999934] RBP: 00007fc76d371050 R08: 0000000000000000 R09: 0000000028cc2400
> [436733.001221] R10: 0000000000000009 R11: 0000000000000293 R12: 00007fc76d3711d0
> [436733.002508] R13: 0000000028c80950 R14: 0000000028cc0950 R15: 000000002796b010
> [436733.003798] Code: ...
> [436733.007166] RIP: i40iw_accept+0x2d0/0x4c0 [i40iw] RSP: ffff99c047713b28
> 
> Fixes: f27b4746f378e ("i40iw: add connection management code"
> Signed-off-by: Andrew Boyer <andrew.boyer@dell.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

This has been quite for a while, it needs Shiraz's approval to move
ahead, so I'm dropping it off patchworks, please work with Shriaz.

Jason
