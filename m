Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E784C43A5FD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 23:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhJYViM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhJYViG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 17:38:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E8FC061226
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 14:35:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u12so5246382pjy.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHfgSZESuBtNRWpoQ0O3+KS410Lf4cM3SnOfKO347UQ=;
        b=Reu7Zfhwb2ow26i8wER7gTUYsj+/+vm3SHpVkiU5o03ZeeoZzyL2Vgkqxh4inOpYnO
         sIv6S7DVrUX4hxLj1wywwk4ilQARf94QkoGSKt86yRTCISAioxSgdb+DyznYDGjhuSoo
         ZelV/oR2YAMluKuDU0FY/KCCbUgaliM74RtVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHfgSZESuBtNRWpoQ0O3+KS410Lf4cM3SnOfKO347UQ=;
        b=GUR49+PPsH6YMSv0n1eTeDWkk8xm8zN7l0Zxbi8TUYZiccEPzSFNRdCnEzgJTPEtg9
         McbIsIrJyFrxfX3UuH9N/VxClDcvsOh9BYDyO1uuBltYh/tRY2SwIvlCFd/mqki7q0Lt
         g7iFBo23KniUeMCa6HCGZDBjqBAV17xmGTT0Hdc2D5JCbVFEoFkf+2igYC0mgHodZbAc
         duxyNLQV66OFktTvQBbq+isOtzmGJ6S0B5ZtJWKGF078CmIFU1t1zgp4AsWe4PVZ3JNh
         5HHwHANijHZKWAqotnSPBsXoGxjYDygtRPiRue5TKbXIe+xXKTCB7C9yqZcOegvAHqST
         UmRA==
X-Gm-Message-State: AOAM533kDV29t2fCi6d4M0h8xpatt93cYSnGHGdBqMvXZ99Pq8IpEooz
        SVTwq/Ifj+CGgE40ZU19ZHlR6A==
X-Google-Smtp-Source: ABdhPJwx8sYf8AzkITaCuxfOfNpuYr9vEkvn+zKf5942IhmP91Qr049qj3smEeLELnoSGilSTESh2g==
X-Received: by 2002:a17:902:e5cb:b0:13f:25b7:4d50 with SMTP id u11-20020a170902e5cb00b0013f25b74d50mr18287509plf.38.1635197743615;
        Mon, 25 Oct 2021 14:35:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a20sm19562774pfn.136.2021.10.25.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:35:43 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:35:42 -0700
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
Subject: Re: [PATCH v6 12/12] kernel/kthread: show a warning if kthread's
 comm is truncated
Message-ID: <202110251431.F594652F@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-13-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-13-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:15AM +0000, Yafang Shao wrote:
> Show a warning if task comm is truncated. Below is the result
> of my test case:
> 
> truncated kthread comm:I-am-a-kthread-with-lon, pid:14 by 6 characters
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/kthread.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 5b37a8567168..46b924c92078 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -399,12 +399,17 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  	if (!IS_ERR(task)) {
>  		static const struct sched_param param = { .sched_priority = 0 };
>  		char name[TASK_COMM_LEN];
> +		int len;
>  
>  		/*
>  		 * task is already visible to other tasks, so updating
>  		 * COMM must be protected.
>  		 */
> -		vsnprintf(name, sizeof(name), namefmt, args);
> +		len = vsnprintf(name, sizeof(name), namefmt, args);
> +		if (len >= TASK_COMM_LEN) {

And since this failure case is slow-path, we could improve the warning
as other had kind of suggested earlier with something like this instead:

			char *full_comm;

			full_comm = kvasprintf(GFP_KERNEL, namefmt, args);
			pr_warn("truncated kthread comm '%s' to '%s' (pid:%d)\n",
				full_comm, name);

			kfree(full_comm);
		}
>  		set_task_comm(task, name);
>  		/*
>  		 * root may have changed our (kthreadd's) priority or CPU mask.
> -- 
> 2.17.1
> 

-- 
Kees Cook
