Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B0458233D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiG0JhE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiG0JhE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 05:37:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5959E394
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 02:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06655B81FE4
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48456C433D7;
        Wed, 27 Jul 2022 09:37:00 +0000 (UTC)
Date:   Wed, 27 Jul 2022 12:36:56 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] RDMA/srpt: Fix a use-after-free
Message-ID: <YuEHOM/iGFEtaGde@unreal>
References: <20220726212156.1318010-1-bvanassche@acm.org>
 <20220726212156.1318010-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726212156.1318010-4-bvanassche@acm.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 26, 2022 at 02:21:56PM -0700, Bart Van Assche wrote:
> Change the LIO port members inside struct srpt_port from regular members
> into pointers. Allocate the LIO port data structures from inside
> srpt_make_tport() and free these from inside srpt_make_tport(). Keep struct
> srpt_device as long as either an RDMA port or a LIO target port is
> associated with it. This patch decouples the lifetime of struct srpt_port
> (controlled by the RDMA core) and struct srpt_port_id (controlled by LIO).
> This patch fixes the following KASAN complaint:
> 
> BUG: KASAN: use-after-free in srpt_enable_tpg+0x31/0x70 [ib_srpt]
> Read of size 8 at addr ffff888141cc34b8 by task check/5093
> 
> Call Trace:
>  <TASK>
>  show_stack+0x4e/0x53
>  dump_stack_lvl+0x51/0x66
>  print_address_description.constprop.0.cold+0xea/0x41e
>  print_report.cold+0x90/0x205
>  kasan_report+0xb9/0xf0
>  __asan_load8+0x69/0x90
>  srpt_enable_tpg+0x31/0x70 [ib_srpt]
>  target_fabric_tpg_base_enable_store+0xe2/0x140 [target_core_mod]
>  configfs_write_iter+0x18b/0x210
>  new_sync_write+0x1f2/0x2f0
>  vfs_write+0x3e3/0x540
>  ksys_write+0xbb/0x140
>  __x64_sys_write+0x42/0x50
>  do_syscall_64+0x34/0x80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  </TASK>
> 
> Reported-by: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Mike Christie <michael.christie@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 133 ++++++++++++++++++--------
>  drivers/infiniband/ulp/srpt/ib_srpt.h |  10 +-
>  2 files changed, 96 insertions(+), 47 deletions(-)

Bart,

Please no BUG_ON() in new code.

Thanks
