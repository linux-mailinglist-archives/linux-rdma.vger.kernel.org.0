Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE14C9841
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Mar 2022 23:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiCAWV4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Mar 2022 17:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiCAWV4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Mar 2022 17:21:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CA7087E
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 14:21:13 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so2459352pjb.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Mar 2022 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ElbLMF6oy6wckfqKSQzAjI3zz9O5jqK83/cr/KExsn4=;
        b=k9Kj8DDJ6cZAynYDRq3IL52Nl6M2s2t2U7i/xWCC8K/mCj3CtZlySv8GmKXqpl08EU
         coN6+ehHKtmS7yEjIKah/2nWaQqXHd7eR77sFp3rrSOVx6kbMmw3hookr/LuZBDdf5AC
         NSx6ZNeqg50nR3i0iumuPwsYnqAuW/aJ4pbjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ElbLMF6oy6wckfqKSQzAjI3zz9O5jqK83/cr/KExsn4=;
        b=n3jyHeo4zeh1er6WJeIdFZuSiYQ0mFqbrfb11Pby5jrO3VxLJpi9FRK60hGZbZ77NM
         Zj9HJOmoef+eg6IJqIjdN+cTIIwGIjCCpQhRrswMtRuXyTBeW4mYs+uA6zy/3w/2aaPw
         dhZsyVtPYivvZ1GyQKR/+NfXENPG8Yl6I9i/jDTNJAGWSIua/lkqIyyOS9lvARiMQlcc
         d1Vo0Kn8VO0X79EZH59O7XvSoIJciKPK5MuRiuG6hyJYmm/vo6+LkVIR37ECBTamyuEw
         Xxp2ouvSmEllPj2sG7AoZy5oaIwve6MQopuyG4T+od2QUqHURZ7RCzN8q6IylsXtkjXe
         TMZQ==
X-Gm-Message-State: AOAM533J5WKMsRvYoCuaFkr/lNWIz1M01Th20KhfLLI1d8M54KHoG+AE
        8cn0/vRcyAe8Da4lWzMGXpdlFizPWFjn0Q==
X-Google-Smtp-Source: ABdhPJzgA2nt2Amyw2xS2lOJBAAaO4bahdtEfUURCWGO8bJxhWldJtIVyPWwXsuPccmfHpIg+WsArg==
X-Received: by 2002:a17:90b:ecf:b0:1bc:232d:a87d with SMTP id gz15-20020a17090b0ecf00b001bc232da87dmr23794218pjb.27.1646173273415;
        Tue, 01 Mar 2022 14:21:13 -0800 (PST)
Received: from localhost.localdomain (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id h22-20020a056a00231600b004e1784925e5sm18819108pfh.97.2022.03.01.14.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2022 14:21:12 -0800 (PST)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, kuba@kernel.org,
        ilias.apalodimas@linaro.org, davem@davemloft.net, hawk@kernel.org,
        saeed@kernel.org, ttoukan.linux@gmail.com, brouer@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org, saeedm@nvidia.com
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [net-next v8 0/4] page_pool: Add stats counters
Date:   Tue,  1 Mar 2022 14:10:06 -0800
Message-Id: <1646172610-129397-1-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Greetings:

Welcome to v8.

This revision updates the ethtool name strings of page pool stats in the 
mlx5 driver to be more user friendly.

I've included Jesper's ACK tag and Ilias' Reviewed-by tags to the first 3
commits, but otherwise no other changes have been made.

Benchmark output from the v7 cover [1] is pasted below, as it is still
relevant since no functional changes have been made in this revision:

Benchmarks have been re-run. As always, results between runs are highly
variable; you'll find results showing that stats disabled are both faster
and slower than stats enabled in back to back benchmark runs.

Raw benchmark output with stats off [2] and stats on [3] are available for
examination.

Test system:
	- 2x Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz
	- 2 NUMA zones, with 18 cores per zone and 2 threads per core

bench_page_pool_simple results, loops=200000000
test name			stats enabled		stats disabled
				cycles	nanosec		cycles	nanosec

for_loop			0	0.335		0	0.336
atomic_inc 			14	6.106		13	6.022
lock				30	13.365		32	13.968

no-softirq-page_pool01		75	32.884		74	32.308
no-softirq-page_pool02		79	34.696		74	32.302
no-softirq-page_pool03		110	48.005		105	46.073

tasklet_page_pool01_fast_path	14	6.156		14	6.211
tasklet_page_pool02_ptr_ring	41	18.028		39	17.391
tasklet_page_pool03_slow	107	46.646		105	46.123

bench_page_pool_cross_cpu results, loops=20000000 returning_cpus=4:
test name			stats enabled		stats disabled
				cycles	nanosec		cycles	nanosec

page_pool_cross_cpu CPU(0)	3973	1731.596	4015	1750.015
page_pool_cross_cpu CPU(1)	3976	1733.217	4022	1752.864
page_pool_cross_cpu CPU(2)	3973	1731.615	4016	1750.433
page_pool_cross_cpu CPU(3)	3976	1733.218	4021	1752.806
page_pool_cross_cpu CPU(4)	994	433.305		1005	438.217

page_pool_cross_cpu average	3378	-		3415	-

bench_page_pool_cross_cpu results, loops=20000000 returning_cpus=8:
test name			stats enabled		stats disabled
				cycles	nanosec		cycles	nanosec

page_pool_cross_cpu CPU(0)	6969	3037.488	6909	3011.463
page_pool_cross_cpu CPU(1)	6974	3039.469	6913	3012.961
page_pool_cross_cpu CPU(2)	6969	3037.575	6910	3011.585
page_pool_cross_cpu CPU(3)	6974	3039.415	6913	3012.961
page_pool_cross_cpu CPU(4)	6969	3037.288	6909	3011.368
page_pool_cross_cpu CPU(5)	6972	3038.732	6913	3012.920
page_pool_cross_cpu CPU(6)	6969	3037.350	6909	3011.386
page_pool_cross_cpu CPU(7)	6973	3039.356	6913	3012.921
page_pool_cross_cpu CPU(8)	871	379.934		864	376.620

page_pool_cross_cpu average	6293	-		6239	-

Thanks.

[1]: https://lore.kernel.org/all/1645810914-35485-1-git-send-email-jdamato@fastly.com/
[2]: https://gist.githubusercontent.com/jdamato-fsly/d7c34b9fa7be1ce132a266b0f2b92aea/raw/327dcd71d11ece10238fbf19e0472afbcbf22fd4/v7_stats_disabled
[3]: https://gist.githubusercontent.com/jdamato-fsly/d7c34b9fa7be1ce132a266b0f2b92aea/raw/327dcd71d11ece10238fbf19e0472afbcbf22fd4/v7_stats_enabled

v7 -> v8:
	- Rename mlx5 ethtool stats so that users have a better idea of
	  their meaning.

v6 -> v7:
	- stats split out into two structs one single per-page pool struct
	  for allocation path stats and one per-cpu pointer for recycle
	  path stats.
	- page_pool_get_stats updated to use a wrapper struct to gather
	  stats for allocation and recycle stats with a single argument.
	- placement of structs adjusted
	- mlx5 driver modified to use page_pool_get_stats API

v5 -> v6:
	- Per cpu page_pool_stats struct pointer is now marked as
	  ____cacheline_aligned_in_smp. Placement of the field in the
	  struct is unchanged; it is the last field.

v4 -> v5:
	- Fixed the description of the kernel option in Kconfig.
	- Squashed commits 1-10 from v4 into a single commit for easier
	  review.
	- Changed the comment style of the comment for
	  the this_cpu_inc_alloc_stat macro.
	- Changed the return type of page_pool_get_stats from struct
	  page_pool_stat * to bool.

v3 -> v4:
	- Restructured stats to be per-cpu per-pool.
	- Global stats and proc file were removed.
	- Exposed an API (page_pool_get_stats) for batching the pool stats.

v2 -> v3:
	- patch 8/10 ("Add stat tracking cache refill") fixed placement of
	  counter increment.
	- patch 10/10 ("net-procfs: Show page pool stats in proc") updated:
		- fix unused label warning from kernel test robot,
		- fixed page_pool_seq_show to only display the refill stat
		  once,
		- added a remove_proc_entry for page_pool_stat to
		  dev_proc_net_exit.

v1 -> v2:
	- A new kernel config option has been added, which defaults to N,
	   preventing this code from being compiled in by default
	- The stats structure has been converted to a per-cpu structure
	- The stats are now exported via proc (/proc/net/page_pool_stat)

Joe Damato (4):
  page_pool: Add allocation stats
  page_pool: Add recycle stats
  page_pool: Add function to batch and return stats
  mlx5: add support for page_pool_get_stats

 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 75 +++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h | 27 +++++++-
 include/net/page_pool.h                            | 51 ++++++++++++++
 net/Kconfig                                        | 13 ++++
 net/core/page_pool.c                               | 77 ++++++++++++++++++++--
 5 files changed, 237 insertions(+), 6 deletions(-)

-- 
2.7.4

