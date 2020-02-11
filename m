Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2135D1596F7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 18:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgBKRwY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 12:52:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45394 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbgBKRwY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 12:52:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id a2so10444149qko.12
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Zt3htpuMrbctYY+SoxkZbwlXTt3IwbV75s2CcycSs4=;
        b=cK/vFCa46jcLOihJ0aLGSf/sN1OGwROPm7+fxgq1PjUMjzNhbgK3+pruOVRujjA6Wc
         b6ur1D+nlTJeHWRJDrBmUj6QFI2me/yYllvVUmFOBWEu93TyPG7xIqfeKD/pc5BioXm6
         pGjl/T2XjOgHsQ4EJiH1HtgPXSUoMrN5RJ8cukKbJTDR7KkF8fZO+7lZ5b7AODUpnJZw
         q7ZyN3MxeMw2MDSi+fJRNIaGyyzn9xcFe0Ijd7YE1GIBpBc1nkoU2lM5+ZQ8hygcsRR3
         Kvi8otdlE4nu169edn8sdhiCVZIyeVQTJz4pABEPU2+NyPK+JKHjy+5fKIeeug4ePc0N
         z9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Zt3htpuMrbctYY+SoxkZbwlXTt3IwbV75s2CcycSs4=;
        b=kTaoNBKkd3lP17M9nzsQYQJ6nMcRSc6SiPICo4i8CQsNL9HJtUOb717Ncih+WyiRI+
         DCnGt5uBPMaMxEhGxrQFWeyY8nsV6VeuJM/9gg869xVgLppwSU39BFL31+VE33XMdlKr
         vcHN6b5/hFdGH9dt1J7M1rYr4BjAaosBIuhHMetgSwmtoDGQX1x0AEQlLJnT7fnl/q0C
         jyhBk8rZRCEtFMi4jbKVCV+S2xzYTHvyfEdHSFGBhpW5TeA9kr16jkbjvroHMerfuaWI
         onz3E0HOAQplgXoEQfX/13xVaSq/mA3aCeObSZNnmrU7k11qSxRx7zMxqAlnn8aat5Hn
         oZUQ==
X-Gm-Message-State: APjAAAXj9A26RysdYrJHcwcbodxQN/LKXyotiaCLiUV+42GcWk0OyoIY
        Fb9Crx/ed0dbswBv/fD8Lpos94MlhiOz9A==
X-Google-Smtp-Source: APXvYqyPyhFt9HtRsCHeStWD2dPmWPqN+8MXWTcBkniSmwqL271u5m5lkbhbmsvpqGbhjT5oDzxrGQ==
X-Received: by 2002:a05:620a:20d4:: with SMTP id f20mr6723918qka.343.1581443542917;
        Tue, 11 Feb 2020 09:52:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w41sm2598631qtj.49.2020.02.11.09.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 09:52:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1Zht-0004RS-Vn; Tue, 11 Feb 2020 13:52:21 -0400
Date:   Tue, 11 Feb 2020 13:52:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc] RDMA/hfi1: Fix memory leak in
 _dev_comp_vect_mappings_create
Message-ID: <20200211175221.GB17005@ziepe.ca>
References: <20200205110530.12129-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205110530.12129-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 01:05:30PM +0200, Kamal Heib wrote:
> Make sure to free the allocated cpumask_var_t's to avoid the following
> reported memory leak by kmemleak:
> 
> $ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8897f812d6a8 (size 8):
>   comm "kworker/1:1", pid 347, jiffies 4294751400 (age 101.703s)
>   hex dump (first 8 bytes):
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<00000000bff49664>] alloc_cpumask_var_node+0x4c/0xb0
>     [<0000000075d3ca81>] hfi1_comp_vectors_set_up+0x20f/0x800 [hfi1]
>     [<0000000098d420df>] hfi1_init_dd+0x3311/0x4960 [hfi1]
>     [<0000000071be7e52>] init_one+0x25e/0xf10 [hfi1]
>     [<000000005483d4c2>] local_pci_probe+0xd4/0x180
>     [<000000007c3cbc6e>] work_for_cpu_fn+0x51/0xa0
>     [<000000001d626905>] process_one_work+0x8f0/0x17b0
>     [<000000007e569e7e>] worker_thread+0x536/0xb50
>     [<00000000fd39a4a5>] kthread+0x30c/0x3d0
>     [<0000000056f2edb3>] ret_from_fork+0x3a/0x50
> 
> Fixes: 5d18ee67d4c1 ("IB/{hfi1, rdmavt, qib}: Implement CQ completion vector support")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc, thanks

Jason
