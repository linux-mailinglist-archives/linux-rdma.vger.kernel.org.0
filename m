Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E023132F21
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 20:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgAGTOa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 14:14:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44195 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgAGTO3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 14:14:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so369018qkb.11
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nUZQVB8nLDer8w9QqOhrUc9Gvav+jb4LssKiAvBapQw=;
        b=Mg16WX3ZMNup7zQnYDQxcteI03epm0AWP5/xGUqTZKiVyXSbl7eFxsAsZ8zGWQZzTC
         AMAdFZF4YTDdn8Xmu9+m5cxhayu5rhHvEQmHPKhLCiBEJp8q0Lvfy0mVb0sAYnTARMup
         Qh2ROQezQB+KWP0Ceo2QHhCzoH0CkS69duwVDZbror6Hzk2szxkkIpSb55+H1QhnTtYj
         UcBz4cmzzVv2RQd2/Q4bygQkmh1v3DFKTXVe2ioNVEXvPebSJudpdDPnOoDBAI6mE/Ou
         Cu0ZcGv+kzo/6HiWykmoxy+nuwLD28/bAt/m30dWmGmzhq8SmSWfJUlOMRgR0fSNOG4I
         fAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nUZQVB8nLDer8w9QqOhrUc9Gvav+jb4LssKiAvBapQw=;
        b=tIlyyMCDOhgtjGYrMCH517G07PN+w5fHaMjsHZE1vWeN70llWe+xqT/JgoYLH6HgD4
         McsyAxBYlbgVoRBOuZfbs5o4gX2VS4K0QNO6Q+pEozuplAhf+oJ/cABbKX9XYOsjp5f4
         JJdF7ylVi+bqVbknjBe8/2s2D7iFH3yMhCpPZkmAmRoCnEEeEEAI8eZnnExz4UTacFS6
         sp2HQxY0CiJZjLJg7TFXkuKRupXVL2KePIpVxsRWriWCArw255L80Fk82e3UEFZaavJb
         t7B0L5B+kqP1BX55FbjrOtqjtL/dBkxZ+91GGlg1b5WwPJj9z5HUOkYpL16sQVM8tgNO
         yxtQ==
X-Gm-Message-State: APjAAAV+qbu6q/c35FVJXs6zZDghA5wq0gU0LJkpC1XVqQlWQdD8iLqm
        cM3eNNPStw0+DOPJA7ncog8qniK1XvA=
X-Google-Smtp-Source: APXvYqyYojG1oERfkrWOeeb0OEgiyG1tVdbcQCZ2dpQqomczOj1ytm8qJtDi4/xzpnAzqcpdiEBrFw==
X-Received: by 2002:ae9:e910:: with SMTP id x16mr867200qkf.90.1578424468609;
        Tue, 07 Jan 2020 11:14:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k21sm306371qtp.92.2020.01.07.11.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 11:14:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iouJ9-0004QY-9V; Tue, 07 Jan 2020 15:14:27 -0400
Date:   Tue, 7 Jan 2020 15:14:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, mkalderon@marvell.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] i40iw: Remove setting of VMA private data and
 use rdma_user_mmap_io
Message-ID: <20200107191427.GA16692@ziepe.ca>
References: <20200107162223.1745-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107162223.1745-1-shiraz.saleem@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 07, 2020 at 10:22:23AM -0600, Shiraz Saleem wrote:
> vm_ops is now initialized in ib_uverbs_mmap with the
> recent rdma mmap API changes. Earlier it was done in
> rdma_umap_priv_init which would not be called unless a
> driver called rdma_user_mmap_io in its mmap.
> 
> i40iw does not use the rdma_user_mmap_io API but sets
> the vma's vm_private_data to a driver object.
> This now conflicts with the vm_op rdma_umap_close as
> priv pointer points to the i40iw driver object instead
> of the private data setup by core when rdma_user_mmap_io
> is called. And this leads to a crash in rdma_umap_close
> with a mmap put being called when it should not have.
> 
> Remove the redundant setting of the vma private_data in
> i40iw as it is not used. Also move i40iw over to use the
> rdma_user_mmap_io API. This gives the extra protection of
> having the mappings zapped when the context is detsroyed.
> 
> [  223.523395] BUG: unable to handle page fault for address: 0000000100000001
> [  223.523400] #PF: supervisor write access in kernel mode
> [  223.523401] #PF: error_code(0x0002) - not-present page
> [  223.523403] PGD 0 P4D 0
> [  223.523406] Oops: 0002 [#1] SMP PTI
> [  223.523409] CPU: 6 PID: 9528 Comm: rping Kdump: loaded Not tainted 5.5.0-rc4+ #117
> [  223.523410] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./Q87M-D2H, BIOS F7 01/17/2014
> [  223.523425] RIP: 0010:rdma_user_mmap_entry_put+0xa/0x30 [ib_core]
> [  223.523429] RSP: 0018:ffffb340c04c7c38 EFLAGS: 00010202
> [  223.523431] RAX: 00000000ffffffff RBX: ffff9308e7be2a00 RCX: 000000000000cec0
> [  223.523433] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000100000001
> [  223.523434] RBP: ffff9308dc7641f0 R08: 0000000000000001 R09: 0000000000000000
> [  223.523436] R10: 0000000000000001 R11: ffffffff8d4414d8 R12: ffff93075182c780
> [  223.523438] R13: 0000000000000001 R14: ffff93075182d2a8 R15: ffff9308e2ddc840
> [  223.523440] FS:  0000000000000000(0000) GS:ffff9308fdc00000(0000) knlGS:0000000000000000
> [  223.523442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  223.523443] CR2: 0000000100000001 CR3: 00000002e0412004 CR4: 00000000001606e0
> [  223.523445] Call Trace:
> [  223.523451]  rdma_umap_close+0x40/0x90 [ib_uverbs]
> [  223.523455]  remove_vma+0x43/0x80
> [  223.523458]  exit_mmap+0xfd/0x1b0
> [  223.523465]  mmput+0x6e/0x130
> [  223.523468]  do_exit+0x290/0xcc0
> [  223.523472]  ? get_signal+0x152/0xc40
> [  223.523475]  do_group_exit+0x46/0xc0
> [  223.523478]  get_signal+0x1bd/0xc40
> [  223.523482]  ? prepare_to_wait_event+0x97/0x190
> [  223.523486]  do_signal+0x36/0x630
> [  223.523489]  ? remove_wait_queue+0x60/0x60
> [  223.523493]  ? __audit_syscall_exit+0x1d9/0x290
> [  223.523497]  ? rcu_read_lock_sched_held+0x52/0x90
> [  223.523500]  ? kfree+0x21c/0x2e0
> [  223.523505]  exit_to_usermode_loop+0x4f/0xc3
> [  223.523509]  do_syscall_64+0x1ed/0x270
> [  223.523512]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  223.523514] RIP: 0033:0x7fae715a81fd
> [  223.523517] Code: Bad RIP value.
> [  223.523519] RSP: 002b:00007fae6e163cb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  223.523521] RAX: fffffffffffffe00 RBX: 00007fae6e163d30 RCX: 00007fae715a81fd
> [  223.523523] RDX: 0000000000000010 RSI: 00007fae6e163cf0 RDI: 0000000000000003
> [  223.523525] RBP: 00000000013413a0 R08: 00007fae68000000 R09: 0000000000000017
> [  223.523526] R10: 0000000000000001 R11: 0000000000000293 R12: 00007fae680008c0
> [  223.523528] R13: 00007fae6e163cf0 R14: 00007fae717c9804 R15: 00007fae6e163ed0
> [  223.523569] CR2: 0000000100000001
> [  223.523571] ---[ end trace b33d58d3a06782cb ]---
> [  223.523580] RIP: 0010:rdma_user_mmap_entry_put+0xa/0x30 [ib_core]
> 
> Fixes: b86deba977a9 ("RDMA/core: Move core content from ib_uverbs to ib_core")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Yep, applied to for-rc

> diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> index 8637594..19b65fd 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> @@ -169,8 +169,7 @@ static void i40iw_dealloc_ucontext(struct ib_ucontext *context)
>  static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  {
>  	struct i40iw_ucontext *ucontext;
> -	u64 db_addr_offset;
> -	u64 push_offset;
> +	u64 db_addr_offset, push_offset, pfn;
>  
>  	ucontext = to_ucontext(context);
>  	if (ucontext->iwdev->sc_dev.is_pf) {
> @@ -189,7 +188,6 @@ static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  
>  	if (vma->vm_pgoff == (db_addr_offset >> PAGE_SHIFT)) {
>  		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -		vma->vm_private_data = ucontext;
>  	} else {
>  		if ((vma->vm_pgoff - (push_offset >> PAGE_SHIFT)) % 2)
>  			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> @@ -197,12 +195,11 @@ static int i40iw_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
>  			vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>  	}

This whole thing is not right. This driver should not be manipulating
vma->vm_page_prot or vma->vm_pgoff. 

vm_pgoff is supposed to select the object to access and should not be
altered.

It also doesn't check that the user is only mmaping one page.  It also
doesn't seem to check that vm_pgoff isn't too big.  Those two issues
look like security problems.

This would be better to use the newer mmap API and just define the
pgoffs you want to expose. The new API takes care of all these
correctness things.

Jason



>  
> -	if (io_remap_pfn_range(vma, vma->vm_start,
> -			       vma->vm_pgoff + (pci_resource_start(ucontext->iwdev->ldev->pcidev, 0) >> PAGE_SHIFT),
> -			       PAGE_SIZE, vma->vm_page_prot))
> -		return -EAGAIN;
> +	pfn = vma->vm_pgoff +
> +	      (pci_resource_start(ucontext->iwdev->ldev->pcidev, 0) >> PAGE_SHIFT);
>  
> -	return 0;
> +	return rdma_user_mmap_io(context, vma, pfn, PAGE_SIZE, vma->vm_page_prot,
> +				 NULL);
>  }
>  
>  /**
