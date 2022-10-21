Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687C6076C2
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 14:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJUMTq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUMTm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 08:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F1264B2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666354779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z4zs9DcE+EGj5FW34Ff1HzR3Ff8P/pBL+yrwgJmUEeQ=;
        b=DyxA9kVggiJdM9FkE76Gw7nTaxAJe6wCbJVjia/k9trA9QrLgYT22jx+FGdOUqMtZH43ar
        ILs7D0SvVr7t7X7iN98Q17D7pW9qEvKVOD49wZtnYOJ28qoLJB1QIuWZ5a749BUHmuktfT
        kPuIhYHw/L8mMf3K44rQhSmM47701M4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-GxPMaseoNmuKQOi0Thyp3A-1; Fri, 21 Oct 2022 08:19:38 -0400
X-MC-Unique: GxPMaseoNmuKQOi0Thyp3A-1
Received: by mail-qv1-f70.google.com with SMTP id em2-20020ad44f82000000b004af5338777cso2228106qvb.4
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 05:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4zs9DcE+EGj5FW34Ff1HzR3Ff8P/pBL+yrwgJmUEeQ=;
        b=b3YIyoSQFMIGLx9uqVm9687zjxMe1vheAtfJ7zLPG5XIpPx+ahP0MNrnZ/CAUsLFbB
         1O4OBJu9atyIXZ7zmQq0bIlcqkMx3oWvqQR4sEyHoqAYq5vzpov0eAeN948Yc4xY1rBk
         vr7Ur97slTrM5kjSteupoUkG3TUPv6CjAv/19bfpA60CipoOP6kPTtF174TRrS1QT7Ao
         jabhXdSE/eYKXrT+ad8s+/Fv4mKy4PjxZGco+cOz35+pWqB4AAUapFUh0+eWg58pUqQk
         wWRiyHEkDdPFPK6ez3xH1/ks7SGKPdUIJbCJ5uVRaeoOPBu2gcejdPYhBbQ2Je80diU9
         OQ5g==
X-Gm-Message-State: ACrzQf23Jczq5SQnPXnEsBu4zZK09CxEbRnlTbHONK2z7KmJuZ4z8GTQ
        +Prl665N0ikr/E0s8/FFaYhFR8A6UoSPU1021/XZHqxp+spudSOFInreDdNhqEZnZANRC8WL7s9
        jUmSl3/LWa3y0jT+i4wszvw==
X-Received: by 2002:a05:6214:629:b0:4b1:bfde:b8f3 with SMTP id a9-20020a056214062900b004b1bfdeb8f3mr15577323qvx.116.1666354777758;
        Fri, 21 Oct 2022 05:19:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JNLV8Cp8NzGabj6XA2TTqc02X6MRbq/KQTzRjlRnPGjQGyBoE7y8s7EiRYDxspFq0SMBMkg==
X-Received: by 2002:a05:6214:629:b0:4b1:bfde:b8f3 with SMTP id a9-20020a056214062900b004b1bfdeb8f3mr15577292qvx.116.1666354777512;
        Fri, 21 Oct 2022 05:19:37 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id i9-20020ac85c09000000b0039a610a04b1sm8043410qti.37.2022.10.21.05.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 05:19:36 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v5 0/3] sched, net: NUMA-aware CPU spreading interface
Date:   Fri, 21 Oct 2022 13:19:24 +0100
Message-Id: <20221021121927.2893692-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi folks,

Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
it).

The proposed interface involved an array of CPUs and a temporary cpumask, and
being my difficult self what I'm proposing here is an interface that doesn't
require any temporary storage other than some stack variables (at the cost of
one wild macro).

[1]: https://lore.kernel.org/all/20220728191203.4055-1-tariqt@nvidia.com/

Revisions
=========

v4 -> v5
++++++++
o Rebased onto 6.1-rc1
o Ditched the CPU iterator, moved to a cpumask iterator (Yury)

v3 -> v4
++++++++

o Rebased on top of Yury's bitmap-for-next
o Added Tariq's mlx5e patch
o Made sched_numa_hop_mask() return cpu_online_mask for the NUMA_NO_NODE &&
  hops=0 case

v2 -> v3
++++++++

o Added for_each_cpu_and() and for_each_cpu_andnot() tests (Yury)
o New patches to fix issues raised by running the above

o New patch to use for_each_cpu_andnot() in sched/core.c (Yury)

v1 -> v2
++++++++

o Split _find_next_bit() @invert into @invert1 and @invert2 (Yury)
o Rebase onto v6.0-rc1

Cheers,
Valentin

Tariq Toukan (1):
  net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity
    hints

Valentin Schneider (2):
  sched/topology: Introduce sched_numa_hop_mask()
  sched/topology: Introduce for_each_numa_hop_mask()

 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 18 +++++++++--
 include/linux/topology.h                     | 32 ++++++++++++++++++++
 kernel/sched/topology.c                      | 31 +++++++++++++++++++
 3 files changed, 79 insertions(+), 2 deletions(-)

--
2.31.1

