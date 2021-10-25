Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2843A5E6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhJYVdA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 17:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhJYVdA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 17:33:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC57C061348
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 14:30:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i5so8817456pla.5
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FK0THlev74z2HG9hiuW20xC/9Pj8D+R7FWwR1ghiGKs=;
        b=Zdn6oHYxe9Pa9lxfbqwSXw/T/gKq6fzVXDQTrnzPr7yWFWZnryMU2z0+oOn4E7vZus
         Rv2d0ynReWW3JIsF8pVG5T+Yubl08B6aS0M7O7XaVX3v9DNEo+bRA8aZflV/ulKdawaK
         nS0gSC10hVbPQzLPvT7Pac+GhpTOAKTGc7QWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FK0THlev74z2HG9hiuW20xC/9Pj8D+R7FWwR1ghiGKs=;
        b=nS+Ii13o3t7oWY1/gvqhc/fQg7E4/a+PLjJ5srPt/WgvP99iclNYa6vTdTxZZVxbuM
         ey1NllSo9r5XhaOzsYaBJSGZCL7BSMk4zhnFpqa01vJGVoSSYSowNsQrowOiV8mbY+Ql
         CN2a7FVbxEiSwzA0QJ5/VOuYpIuG+ybBVOtRINdM+Rsix6GqZPb3UgStoBZWyJ1hdKPA
         is+HWu1e3np6dwgWDh+HcwlcDOyWQ5NZcxdmh0Q/jpiD0iHeR7/7TysS8tqk9FcHxLwy
         dFoNctS0AKuzj3lZvdLAVkFYf8h3SYats+0MoYe/O97BXV/eW1iI4w2dI5XkQqU3BDZj
         d+UQ==
X-Gm-Message-State: AOAM533ayYCPpS9AdQGeIkuZ/69TkvIdA1necZRECHX7Gp03OXIwzTDi
        IUVuzQaUiPLtskW6ERwT93QP/Q==
X-Google-Smtp-Source: ABdhPJyREyF7p6DNXX3R64914IG1hoPWbqevVLtu9pASPqHfzmp8e1xFqcMGun6hDF4fkPBfud1ObQ==
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr24280796pjb.173.1635197437104;
        Mon, 25 Oct 2021 14:30:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7sm9734402pfm.28.2021.10.25.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:30:36 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:30:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 11/12] sched.h: extend task comm from 16 to 24
Message-ID: <202110251429.DD44ED7B76@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-12-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-12-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:14AM +0000, Yafang Shao wrote:
> When I was implementing a new per-cpu kthread cfs_migration, I found the
> comm of it "cfs_migration/%u" is truncated due to the limitation of
> TASK_COMM_LEN. For example, the comm of the percpu thread on CPU10~19 are
> all with the same name "cfs_migration/1", which will confuse the user. This
> issue is not critical, because we can get the corresponding CPU from the
> task's Cpus_allowed. But for kthreads correspoinding to other hardware
> devices, it is not easy to get the detailed device info from task comm,
> for example,
> 
>     jbd2/nvme0n1p2-
>     xfs-reclaim/sdf
> 
> We can also shorten the name to work around this problem, but I find
> there are so many truncated kthreads:
> 
>     rcu_tasks_kthre
>     rcu_tasks_rude_
>     rcu_tasks_trace
>     poll_mpt3sas0_s
>     ext4-rsv-conver
>     xfs-reclaim/sd{a, b, c, ...}
>     xfs-blockgc/sd{a, b, c, ...}
>     xfs-inodegc/sd{a, b, c, ...}
>     audit_send_repl
>     ecryptfs-kthrea
>     vfio-irqfd-clea
>     jbd2/nvme0n1p2-
>     ...
> 
> We should improve this problem fundamentally by extending comm size to
> 24 bytes. task_struct is growing rather regularly by 8 bytes.
> 
> After this change, the truncated kthreads listed above will be
> displayed as:
> 
>     rcu_tasks_kthread
>     rcu_tasks_rude_kthread
>     rcu_tasks_trace_kthread
>     poll_mpt3sas0_statu
>     ext4-rsv-conversion
>     xfs-reclaim/sdf1
>     xfs-blockgc/sdf1
>     xfs-inodegc/sdf1
>     audit_send_reply
>     ecryptfs-kthread
>     vfio-irqfd-cleanup
>     jbd2/nvme0n1p2-8
> 
> As we have converted all the unsafe copy of task comm to the safe one,
> this change won't make any trouble to the kernel or the in-tree tools.
> The safe one and unsafe one of comm copy as follows,
> 
>   Unsafe                 Safe
>   strlcpy                strscpy_pad
>   strncpy                strscpy_pad
>   bpf_probe_read_kernel  bpf_probe_read_kernel_str
>                          bpf_core_read_str
>                          bpf_get_current_comm
>                          perf_event__prepare_comm
>                          prctl(2)
> 
> Regarding the possible risk it may take to the out-of-tree user tools, if
> the user tools get the task comm through kernel API like prctl(2),
> bpf_get_current_comm() and etc, the tools still work well after this
> change. While If the user tools get the task comm through direct string
> copy, it must make sure the copied string should be with a nul terminator.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 124538db792c..490d12eabe44 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -279,7 +279,7 @@ struct task_group;
>   * BPF programs.
>   */
>  enum {
> -	TASK_COMM_LEN = 16,
> +	TASK_COMM_LEN = 24,
>  };

I suspect this should be kept in sync with the tools/ copy of sched.h
(i.e. we may need to keep the TASK_COMM_LEN_16 around in the kernel tree
too.)

>  
>  extern void scheduler_tick(void);
> -- 
> 2.17.1
> 

-- 
Kees Cook
