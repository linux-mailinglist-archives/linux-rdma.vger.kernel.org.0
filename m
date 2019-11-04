Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E5EE96A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 21:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKDUZE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 15:25:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41549 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfKDUZE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 15:25:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id m125so18928110qkd.8
        for <linux-rdma@vger.kernel.org>; Mon, 04 Nov 2019 12:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfX7MWPK2mXvXsnlqpoXJ9gVTBzlydNtygslKz1zYXc=;
        b=a8hSItnOZbtn6sMoihfhZuCetsEimfTI974lkvFhLKCg3HejeAO31tVnnKuLf8OBzG
         4cchusxnrVjItFjaeoTqIrOvpcpNtbGL4HmtHSBYgaxArSbGCtmfHGie9wUvHBWBFCtR
         XDyhVJbgXG8KzNN7ekl9KMw5ZH7nR9fuIHVYFo3h/exFmvg9P24/oLAxyHrpy4Es/45s
         IqMUO7VIWM6EhQ7FH+tMQqucsVqJZJSx1KHeKTBcdhQbCjPwSIYCdzJN/likNaHlaSTx
         mvtuSLMteIPqZ8UG6y1xP8DW5n0eiCDpBRZvheCN9DH/7l9lUG76EBGzGGsVNnXnrdNf
         AnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfX7MWPK2mXvXsnlqpoXJ9gVTBzlydNtygslKz1zYXc=;
        b=PDKxf2l8I0Lb3eXEnUPlk14fr+tm3Ir+YQ+Tc5+KWHHhWVb/CFY1YThh7RN+GQwB6s
         5YBas+kGhWIpbFjyvJ9KX5Pc8KR2+G9RrVYy1yOoQkqxsl11B1j6F64Vbye1kjm/IiDZ
         HZalqhSFw5RAuEiAdVd0dCqCc1cL+BYR/LFx2mnOGociV84KvoBrZREdEqCCHCcAGhnh
         ADds7rn5QgeQcUwdPw+/PA8x/FOqaHc4UGy9hKTD/M/VZa7HeRMrk1HF5ZFgocEqPKwa
         58TEd/qOP1HzG74F6jUA07inypUiEjScvyJALUCSjNlWHgPUJOe8AZOoaRfgiHZRl9OB
         i6BQ==
X-Gm-Message-State: APjAAAWU8zxe9gdXC3eU5cIM+vuxm2ZrItGlqSF9hN1Ki6z0+fRNox29
        K0ik1igoiCIelPFxrDfZFkpvlg==
X-Google-Smtp-Source: APXvYqxgNGF3cXksanX/E/C8HqgGn5+TVBnu52RjRVopu16Kv6kjyL+U9vqqnb2baD1bHGbzMrjKsA==
X-Received: by 2002:a37:94e:: with SMTP id 75mr15364499qkj.49.1572899101609;
        Mon, 04 Nov 2019 12:25:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id d2sm9640372qkg.77.2019.11.04.12.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Nov 2019 12:25:01 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iRiuK-00055e-9y; Mon, 04 Nov 2019 16:25:00 -0400
Date:   Mon, 4 Nov 2019 16:25:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 05/15] RDMA/odp: Use mmu_range_notifier_insert()
Message-ID: <20191104202500.GA19383@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-6-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015181242.8343-6-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:32PM -0300, Jason Gunthorpe wrote:
> @@ -250,26 +85,15 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp)
>  			ret = -ENOMEM;
>  			goto out_page_list;
>  		}
> -	}
>  
> -	mn = mmu_notifier_get(&ib_umem_notifiers, umem_odp->umem.owning_mm);
> -	if (IS_ERR(mn)) {
> -		ret = PTR_ERR(mn);
> -		goto out_dma_list;
> -	}
> -	umem_odp->per_mm = per_mm =
> -		container_of(mn, struct ib_ucontext_per_mm, mn);
> -
> -	mutex_init(&umem_odp->umem_mutex);
> -	init_completion(&umem_odp->notifier_completion);
> +		ret = mmu_range_notifier_insert(&umem_odp->notifier, start,
> +						end - start, current->mm);
> +		if (ret)
> +			goto out_dma_list;

It turns out 'current' can't be used here as this can be called from the
page fault work queue and should be 'umem_odp->umem.owning_mm'

The same problem applies to the tgid a few lines below

It also seems there is a pre-existing problem here as this code
doesn't guarentee to have a mmget() on the mm for the non-current case
when it called mmu_notifier_get() or now
mmu_range_notifier_insert(). 

I'll fix this in a dedicated patch.

This incremental sorts it out, I'll squash it into this patch:

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 6132b8127e8435..0768bb60ce1662 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -87,12 +87,10 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp)
 		}
 
 		ret = mmu_range_notifier_insert(&umem_odp->notifier, start,
-						end - start, current->mm);
+						end - start,
+						umem_odp->umem.owning_mm);
 		if (ret)
 			goto out_dma_list;
-
-		umem_odp->tgid =
-			get_task_pid(current->group_leader, PIDTYPE_PID);
 	}
 
 	return 0;
@@ -140,8 +138,10 @@ ib_umem_odp_alloc_implicit(struct ib_udata *udata, int access)
 	umem_odp->is_implicit_odp = 1;
 	umem_odp->page_shift = PAGE_SHIFT;
 
+	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
 	ret = ib_init_umem_odp(umem_odp);
 	if (ret) {
+		put_pid(umem_odp->tgid);
 		kfree(umem_odp);
 		return ERR_PTR(ret);
 	}
@@ -185,8 +185,10 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
 	odp_data->page_shift = PAGE_SHIFT;
 	odp_data->notifier.ops = ops;
 
+	odp_data->tgid = get_pid(root->tgid);
 	ret = ib_init_umem_odp(odp_data);
 	if (ret) {
+		put_pid(odp_data->tgid);
 		kfree(odp_data);
 		return ERR_PTR(ret);
 	}
@@ -254,11 +256,14 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_udata *udata, unsigned long addr,
 		up_read(&mm->mmap_sem);
 	}
 
+	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
 	ret = ib_init_umem_odp(umem_odp);
 	if (ret)
-		goto err_free;
+		goto err_put_pid;
 	return umem_odp;
 
+err_put_pid:
+	put_pid(umem_odp->tgid);
 err_free:
 	kfree(umem_odp);
 	return ERR_PTR(ret);
