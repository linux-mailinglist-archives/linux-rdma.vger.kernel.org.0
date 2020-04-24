Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1C31B7E71
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgDXS6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 14:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728943AbgDXS6X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 14:58:23 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E572C09B048
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:58:23 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w29so8831181qtv.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0T4Cqwuz4xhDbYs8Z/ycdAQarYYSp6UDbe7d4Bv2saU=;
        b=dOHOtG7CdT9B6O+O1k1u4zBnDt4BLWB4Rz85podIBmeswBxCCUkpoLKS7Ei8/CsS2C
         B6ItBH54mfLtBEDaAl5pRPF8Dp1NtXv8VL/PqRRFk9yR187VGwnVUX+UCOU4YvcE4VsD
         6L4P4JfB3QKXqHa0uc/KWxA4lcvNm7t0pqZXFnmgOgWDwW0Zi18VLOBve9+UE0EJd5MI
         fQVY9ACMpmfiWZBm/OncB/gI0f6a2PvqyFfSSwCxJlhDbXYzKkF74B3pk7NKjrIkOtLr
         YDf+KfxzR/fkCDoFc38RpYbiGVBSMoA1YXAKGZbjBrPfI9sRgjH35ImTBAPRlHxUX1Rh
         9c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0T4Cqwuz4xhDbYs8Z/ycdAQarYYSp6UDbe7d4Bv2saU=;
        b=ic6vEp2QiS2PpdY2jacMq5rVT6766pAz0/4sPUsD7u0KPqeTmT/gQT9cfs4BPXqjZ/
         TZ3OXDcLev7gpp6rR2FZDxnfycHAHI7AzlHnY0cvm+hmfMy1h5U6NzMhI/QiI1117WKf
         IKlO4eumGprnGniG5a4TaPFxUCZ8+l8SuFKtgyPtQhIGWk8wexnhTRKZBzr4flJj5saD
         KDPkQ2oCDtNCIlfJMfwBmr7GtSo7DJsRMbwY6U7RHXJlH8kBxUDQIWHYrGrTVLq1MryR
         RJwPDW4SZdpdqN20Ncj6Okg6MwCoDum3KwQSJLMS2yPAh7D6CXCMYUxJwo61QrNaRIxx
         +zgA==
X-Gm-Message-State: AGi0PubnwcfSI/Pe8sYVyGdj7atT7zgjnKFXghb2ahCQ/JgzoVB0hGk0
        umGts4pffWvtdLZFHLd7G8XpEHf/ZVzJrQ==
X-Google-Smtp-Source: APiQypLabDrfomCH0QMAWMuImGDDCLWTXAIOG3yBxdQVqwQG16MDU7/8bJgDU+VoezRu4P0sTwCTtw==
X-Received: by 2002:ac8:27ed:: with SMTP id x42mr10956064qtx.231.1587754702661;
        Fri, 24 Apr 2020 11:58:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v23sm4193463qkv.55.2020.04.24.11.58.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 11:58:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS3Wn-0006ZS-2c; Fri, 24 Apr 2020 15:58:21 -0300
Date:   Fri, 24 Apr 2020 15:58:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/core: Fix race between destroy and release
 FD object
Message-ID: <20200424185821.GA25225@ziepe.ca>
References: <20200423060122.6182-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423060122.6182-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 09:01:22AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The call to ->lookup_put() was too early and it caused decrease of kref
> on FD object and call to FD release function, while the object is still
> locked for the write. This caused to the following WARN_ON() to be printed.
> 
> [  268.688470] ------------[ cut here ]------------
> [  268.689460] WARNING: CPU: 4 PID: 6913 at drivers/infiniband/core/rdma_core.c:768 uverbs_uobject_fd_release+0x202/0x230
> [  268.691322] Kernel panic - not syncing: panic_on_warn set ...
> [  268.692273] CPU: 4 PID: 6913 Comm: syz-executor.3 Not tainted 5.7.0-rc2 #22
> [  268.693456] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [  268.695688] Call Trace:
> [  268.696135]  dump_stack+0x94/0xce
> [  268.696784]  panic+0x234/0x56f
> [  268.697384]  ? __warn+0x1e1/0x1e1
> [  268.697942]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
> [  268.698782]  ? printk+0xb2/0xdd
> [  268.699301]  ? __warn+0x1b1/0x1e1
> [  268.699946]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.700829]  __warn+0x1cc/0x1e1
> [  268.701402]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.702227]  report_bug+0x200/0x310
> [  268.702807]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.703618]  fixup_bug.part.11+0x32/0x80
> [  268.704260]  do_error_trap+0xd3/0x100
> [  268.704898]  do_invalid_op+0x31/0x40
> [  268.705581]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.706479]  invalid_op+0x1e/0x30
> [  268.707035] RIP: 0010:uverbs_uobject_fd_release+0x202/0x230
> [  268.708046] Code: fe 4c 89 e7 e8 af 23 fe ff e9 2a ff ff ff e8 c5 fa 61 fe be 03 00 00 00 4c 89 e7 e8 68 eb f5 fe e9 13 ff ff ff e8 ae fa 61 fe <0f> 0b eb ac e8 e5 aa 3c fe e8 50 2b 86 fe e9 6a fe ff ff e8 46 2b
> [  268.711365] RSP: 0018:ffffc90008117d88 EFLAGS: 00010293
> [  268.712218] RAX: ffff88810e146580 RBX: 1ffff92001022fb1 RCX: ffffffff82d5b902
> [  268.713439] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88811951b040
> [  268.714606] RBP: ffff88811951b000 R08: ffffed10232a3609 R09: ffffed10232a3609
> [  268.715805] R10: ffff88811951b043 R11: 0000000000000001 R12: ffff888100a7c600
> [  268.717119] R13: ffff888100a7c650 R14: ffffc90008117da8 R15: ffffffff82d5b700
> [  268.718401]  ? __uverbs_cleanup_ufile+0x270/0x270
> [  268.719181]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.720140]  ? uverbs_uobject_fd_release+0x202/0x230
> [  268.720967]  ? __uverbs_cleanup_ufile+0x270/0x270
> [  268.721758]  ? locks_remove_file+0x282/0x3d0
> [  268.722529]  ? security_file_free+0xaa/0xd0
> [  268.723224]  __fput+0x2be/0x770
> [  268.723743]  task_work_run+0x10e/0x1b0
> [  268.724428]  exit_to_usermode_loop+0x145/0x170
> [  268.725172]  do_syscall_64+0x2d0/0x390
> [  268.725786]  ? prepare_exit_to_usermode+0x17a/0x230
> [  268.726580]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  268.727413] RIP: 0033:0x414da7
> [  268.728029] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 3f f3 c3 0f 1f 44 00 00 53 89 fb 48 83 ec 10 e8 f4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 36 fc ff ff 8b 44 24
> [  268.731055] RSP: 002b:00007fff39d379d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> [  268.732322] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000414da7
> [  268.733587] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
> [  268.734818] RBP: 00007fff39d37a3c R08: 0000000400000000 R09: 0000000400000000
> [  268.736472] R10: 00007fff39d37910 R11: 0000000000000293 R12: 0000000000000001
> [  268.737754] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000003
> [  268.738983] Dumping ftrace buffer:
> [  268.739601]    (ftrace buffer empty)
> [  268.740181] Kernel Offset: disabled
> [  268.740770] Rebooting in 1 seconds..
> 
> Fix the code by changing the order, first unlock and call
> to ->lookup_put() after that.
> 
> Fixes: 3832125624b7 ("IB/core: Add support for idr types")
> Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
