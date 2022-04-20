Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80261508180
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358891AbiDTG54 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345638AbiDTG51 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 02:57:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98E329BD
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 23:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21A6EB818F9
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 06:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB5C385A1;
        Wed, 20 Apr 2022 06:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650437678;
        bh=BZKwC2HNhpAOXKzU5m+Y9iMOqonMmtP1HLww7/wrKAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rG4uKvYRb1BtkzKJInCyCaxsfnCRfN/EbKwNVWOLBQFeV6Y4mYHdySYxquMzD58M4
         fdx1veo8Ao0Uso/8w+rwwai2CwqKTxkMl0xdX7hn0P/NmpUeo9rNz7+C6FnZow51OT
         qz50fjzZYtQbnUf+p11a8OztQYnlOk+1ib4zugHTSjkL0QHCmBhueQHgAoO9tKcvfc
         XALkE7/40dTmTCpPUEsSTLlLEyEcgipzd0SNbTp4lqOSh0Da3bLXow2c7Z3n5VjIqw
         Ehd2SPfYXm1c+7DICy/hx4Luv5NPfQPvm0tkntj8jBj7WQuE61ciiTQXu03w9TJteA
         2ZMkhtHNn8LHQ==
Date:   Wed, 20 Apr 2022 09:54:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev,
        rpearsonhpe@gmail.com, jgg@nvidia.com, y-goto@fujitsu.com,
        lizhijian@fujitsu.com, tomasz.gromadzki@intel.com,
        ira.weiny@intel.com
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <Yl+uKqWp1pj2doGt@unreal>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418061244.89025-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 18, 2022 at 02:12:41PM +0800, Xiao Yang wrote:
> The IB SPEC v1.5[1] defined new RDMA Atomic Write operation. This
> patchset makes SoftRoCE support new RDMA Atomic Write on RC service.
> 
> I add ibv_wr_rdma_atomic_write() and a rdma_atomic_write example on my
> rdma-core repository[2].  You can verify the patchset by building and
> running the rdma_atomic_write example.
> server:
> $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
> client:
> $ ./rdma_atomic_write_client -s [server_address] -p [port_number]

We need PR to official rdma-core repo with pyverbs test to consider this
code for merge.

Thanks

> 
> [1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
> [2]: https://github.com/yangx-jy/rdma-core/tree/new_api_with_point
> 
> v3->v4:
> 1) Rebase on current wip/jgg-for-next
> 2) Fix a compiler error on 32-bit arch (e.g. parisc) by disabling RDMA Atomic Write
> 3) Replace 64-bit value with 8-byte array for RDMA Atomic Write
> 
> V2->V3:
> 1) Rebase
> 2) Add RDMA Atomic Write attribute for rxe device
> 
> V1->V2:
> 1) Set IB_OPCODE_RDMA_ATOMIC_WRITE to 0x1D
> 2) Add rdma.atomic_wr in struct rxe_send_wr and use it to pass the atomic write value
> 3) Use smp_store_release() to ensure that all prior operations have completed
> 
> Xiao Yang (3):
>   RDMA/rxe: Rename send_atomic_ack() and atomic member of struct
>     resp_res
>   RDMA/rxe: Support RDMA Atomic Write operation
>   RDMA/rxe: Add RDMA Atomic Write attribute for rxe device
> 
>  drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
>  drivers/infiniband/sw/rxe/rxe_opcode.c | 19 ++++++++
>  drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
>  drivers/infiniband/sw/rxe/rxe_param.h  |  5 +++
>  drivers/infiniband/sw/rxe/rxe_qp.c     |  4 +-
>  drivers/infiniband/sw/rxe/rxe_req.c    | 13 +++++-
>  drivers/infiniband/sw/rxe/rxe_resp.c   | 61 ++++++++++++++++++++------
>  drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
>  include/rdma/ib_pack.h                 |  2 +
>  include/rdma/ib_verbs.h                |  3 ++
>  include/uapi/rdma/ib_user_verbs.h      |  4 ++
>  include/uapi/rdma/rdma_user_rxe.h      |  1 +
>  12 files changed, 103 insertions(+), 18 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
> 
