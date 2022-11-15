Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4B62A03F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiKOR0M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 12:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKOR0L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 12:26:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E772EF5B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 09:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668533107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MgCElGXG2rRWfA57RmljDKl5xxJFEWYi3oRrsoKJ4dw=;
        b=bEd+cr1zaltwbBxG/1hoqDwLfx64XKDlc/AKZVhbGNCkGvZNN+L7IJfSjsra9Mb17+/P9S
        dYNB2cy3wtNyIeDdLJ1HUu6nm8JAQ2ED4LLAR0v/7CkbGmKrQTi0pY8uVgAYbSVVTQGUvB
        dRmi/NikClZi0R2jqm/3odtUsmS6Z5k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-JBLT4_ZyOn6-hX_RXAC06g-1; Tue, 15 Nov 2022 12:25:05 -0500
X-MC-Unique: JBLT4_ZyOn6-hX_RXAC06g-1
Received: by mail-qv1-f69.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso11208188qvb.23
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 09:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgCElGXG2rRWfA57RmljDKl5xxJFEWYi3oRrsoKJ4dw=;
        b=OdQyKi1zIMmrVeiqqoAk2WFsS9WLr8/5cNnZoqnx7ter1P5zokZ4Bb3g2jz4/ZlCVF
         sEl6b0UeP80+ffzP8YNV8a991BgmQLGtaBgUl4NgqBLk4rLlP/GXKZS3m65rkJ3nk7w1
         cmIKFI/9uk9d5BI2vekVG6vPCxs13EJNQFemvE/hTM9fOqATbGANUbK0vNhzMgMMVRR7
         Kva0ifmy4fQChrjmNW6eMOrArTz5OB2qeDoybzkdPgxV7K3DGQ/RX1tskQgrR8m8b0lz
         QKpoqxVmNuSE4u0jIePtRw/98GXJDNAFfy5as1iEE5+CaVan7Pvp/CMyJRYx9HVgj+z8
         nIxw==
X-Gm-Message-State: ANoB5pm+9z8ntE1SANjHlRk5rbp/r/w5jFNeg6UHolZsAuAMsKB2wNXc
        +zt5HgvxvsnMsGZrjWwAGRG+D34ove1e7MZEexu+gyr+AfRa6WW8inIKettITIYPDEGch3xWrGX
        /CKTPyiCUJ/SzYaLkAh8/DGB7zpmsRrjrBJBn2IiKhmfmSkFVJqOZmaZdJyhxwCnvRgEzis8Vbw
        ==
X-Received: by 2002:a0c:e589:0:b0:4bd:e8ec:263c with SMTP id t9-20020a0ce589000000b004bde8ec263cmr17310874qvm.104.1668533104695;
        Tue, 15 Nov 2022 09:25:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4z07MOGKiqWhjEb89y4p1GaGz5a6bbrNrm6BUrPdtG5V7MKy0l6ujLwU/2zPQXmYTWnfO48A==
X-Received: by 2002:a0c:e589:0:b0:4bd:e8ec:263c with SMTP id t9-20020a0ce589000000b004bde8ec263cmr17310820qvm.104.1668533104327;
        Tue, 15 Nov 2022 09:25:04 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id h21-20020ac846d5000000b003a4f22c6507sm7472090qto.48.2022.11.15.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:25:03 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Barry Song <baohua@kernel.org>,
        Ben Segall <bsegall@google.com>,
        haniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-crypto@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] cpumask: improve on cpumask_local_spread() locality
In-Reply-To: <20221112190946.728270-1-yury.norov@gmail.com>
References: <20221112190946.728270-1-yury.norov@gmail.com>
Date:   Tue, 15 Nov 2022 17:24:56 +0000
Message-ID: <xhsmh7czwyvtj.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 12/11/22 11:09, Yury Norov wrote:
> cpumask_local_spread() currently checks local node for presence of i'th
> CPU, and then if it finds nothing makes a flat search among all non-local
> CPUs. We can do it better by checking CPUs per NUMA hops.
>
> This series is inspired by Tariq Toukan and Valentin Schneider's "net/mlx5e:
> Improve remote NUMA preferences used for the IRQ affinity hints"
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20220728191203.4055-3-tariqt@nvidia.com/
>
> According to their measurements, for mlx5e:
>
>         Bottleneck in RX side is released, reached linerate (~1.8x speedup).
>         ~30% less cpu util on TX.
>
> This patch makes cpumask_local_spread() traversing CPUs based on NUMA
> distance, just as well, and I expect comparabale improvement for its
> users, as in case of mlx5e.
>
> I tested new behavior on my VM with the following NUMA configuration:
>
> root@debian:~# numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3
> node 0 size: 3869 MB
> node 0 free: 3740 MB
> node 1 cpus: 4 5
> node 1 size: 1969 MB
> node 1 free: 1937 MB
> node 2 cpus: 6 7
> node 2 size: 1967 MB
> node 2 free: 1873 MB
> node 3 cpus: 8 9 10 11 12 13 14 15
> node 3 size: 7842 MB
> node 3 free: 7723 MB
> node distances:
> node   0   1   2   3
>   0:  10  50  30  70
>   1:  50  10  70  30
>   2:  30  70  10  50
>   3:  70  30  50  10
>
> And the cpumask_local_spread() for each node and offset traversing looks
> like this:
>
> node 0:   0   1   2   3   6   7   4   5   8   9  10  11  12  13  14  15
> node 1:   4   5   8   9  10  11  12  13  14  15   0   1   2   3   6   7
> node 2:   6   7   0   1   2   3   8   9  10  11  12  13  14  15   4   5
> node 3:   8   9  10  11  12  13  14  15   4   5   6   7   0   1   2   3
>

Is this meant as a replacement for [1]?

I like that this is changing an existing interface so that all current
users directly benefit from the change. Now, about half of the users of
cpumask_local_spread() use it in a loop with incremental @i parameter,
which makes the repeated bsearch a bit of a shame, but then I'm tempted to
say the first point makes it worth it.

[1]: https://lore.kernel.org/all/20221028164959.1367250-1-vschneid@redhat.com/

> v1: https://lore.kernel.org/lkml/20221111040027.621646-5-yury.norov@gmail.com/T/
> v2:
>  - use bsearch() in sched_numa_find_nth_cpu();
>  - fix missing 'static inline' in 3rd patch.
>
> Yury Norov (4):
>   lib/find: introduce find_nth_and_andnot_bit
>   cpumask: introduce cpumask_nth_and_andnot
>   sched: add sched_numa_find_nth_cpu()
>   cpumask: improve on cpumask_local_spread() locality
>
>  include/linux/cpumask.h  | 20 +++++++++++++++
>  include/linux/find.h     | 33 ++++++++++++++++++++++++
>  include/linux/topology.h |  8 ++++++
>  kernel/sched/topology.c  | 55 ++++++++++++++++++++++++++++++++++++++++
>  lib/cpumask.c            | 12 ++-------
>  lib/find_bit.c           |  9 +++++++
>  6 files changed, 127 insertions(+), 10 deletions(-)
>
> --
> 2.34.1

