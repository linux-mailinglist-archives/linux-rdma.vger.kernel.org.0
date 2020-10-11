Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCD28A63D
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Oct 2020 10:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgJKIBx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Oct 2020 04:01:53 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8055 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJKIBx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Oct 2020 04:01:53 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f82bb800000>; Sun, 11 Oct 2020 01:00:00 -0700
Received: from [172.27.1.104] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 11 Oct
 2020 08:01:51 +0000
Subject: Re: [PATCH V1 rdma-core 0/8] verbs: Query GID table API
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <maorg@nvidia.com>, <avihaih@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
References: <20200923102702.590008-1-yishaih@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <933be47f-dab2-9d92-d977-c776715f8e06@nvidia.com>
Date:   Sun, 11 Oct 2020 11:01:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923102702.590008-1-yishaih@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602403200; bh=jhv9pdAQAEgehqIEESBC9kkUmAsbnKZiUWwYLoHiQCU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=Dh/VgZZlzwkNQXeVB+wYeq4GqUoPA426j1KE2CZ/+q0vl3QYM+m5sMA9D6ST/5mv2
         OdFGwPQFbte+ZZBCLrjILR+iwKy0aw+KXpu/pJacP0rEEKVehLvQBIAGrzFNwHLJ1b
         ziVanLu+NGYyulpC6hrHA9K4jsCWHw8lvNxPDolwqsHuGbm3Zx3He/AIADvCqozcyU
         Drrwva4IpvY493g1eFexpPp9Nb219FxzL+EdtBV0dhI+PT3RO2mpWUa6oAxhqgbwR5
         v7G2h/4s9wdsjR74bMK9o7+JPqfzrkdvKYZe6Y6syLtRbChLAO9W9n1B2EHIcMnQf2
         Z1tUM4/iMXmGg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/23/2020 1:26 PM, Yishai Hadas wrote:
> When an application is not using RDMA CM and if it is using multiple RDMA
> devices with one or more RoCE ports, finding the right GID table entry is a
> long process.
>
> For example, with two RoCE dual-port devices in a system, when IP failover is
> used between two RoCE ports, searching a suitable GID entry for a given source
> IP, matching netdevice of given RoCEv1/v2 type requires iterating over all 4
> ports * 256 entry GID table.
>
> Even though the best first match GID table for given criteria is used, when the
> matching entry is on the 4th port, it requires reading 3 ports * 256 entries *
> 3 files (GID, netdev, type) = 2304 files.  The GID table needs to be referred
> on every QP creation during IP failover on other netdevice of an RDMA device.
>
> We introduce this series of patches, which introduces an API to query the
> complete GID tables of an RDMA device, that returns all valid GID table
> entries.
>
> This is done through single ioctl, eliminating 2304 read, 2304 open and 2304
> close system calls to just a total of 2 calls (one for each device).
>
> While at it, we also introduce an API to query an individual GID entry over
> ioctl interface, which provides all GID attributes information.
>
> The APIs are based on the below RFC [1], the matching kernel part was sent to
> rdma-next.
>
> PR was sent as well [2].
>
> [1] https://www.spinics.net/lists/linux-rdma/msg91825.html
> [2] https://github.com/linux-rdma/rdma-core/pull/828
>
> Changelog:
> v1:
> * Move some GIDs stuff to cmd_device.c with better function's names.
> * Cleanup in few places.
>
> Avihai Horon (7):
>    verbs: Change the name of enum ibv_gid_type
>    verbs: Introduce a new query GID entry API
>    verbs: Implement ibv_query_gid and ibv_query_gid_type over ioctl
>    verbs: Optimize ibv_query_gid and ibv_query_gid_type
>    verbs: Introduce a new query GID table API
>    pyverbs: Add query_gid_table and query_gid_ex methods
>    tests: Add tests for ibv_query_gid_table and ibv_query_gid_ex
>
> Yishai Hadas (1):
>    Update kernel headers
>
>   debian/libibverbs1.symbols                |   3 +
>   kernel-headers/rdma/ib_user_ioctl_cmds.h  |  16 ++
>   kernel-headers/rdma/ib_user_ioctl_verbs.h |  14 ++
>   kernel-headers/rdma/ib_user_verbs.h       |  11 ++
>   kernel-headers/rdma/rdma_user_rxe.h       |   6 +-
>   libibverbs/CMakeLists.txt                 |   2 +-
>   libibverbs/cmd_device.c                   | 314 ++++++++++++++++++++++++++++++
>   libibverbs/driver.h                       |  19 +-
>   libibverbs/examples/devinfo.c             |  14 +-
>   libibverbs/libibverbs.map.in              |   6 +
>   libibverbs/man/CMakeLists.txt             |   2 +
>   libibverbs/man/ibv_query_gid_ex.3.md      |  93 +++++++++
>   libibverbs/man/ibv_query_gid_table.3.md   |  73 +++++++
>   libibverbs/verbs.c                        | 105 ++++------
>   libibverbs/verbs.h                        |  45 +++++
>   providers/mlx5/verbs.c                    |   2 +-
>   pyverbs/device.pxd                        |   3 +
>   pyverbs/device.pyx                        | 108 +++++++++-
>   pyverbs/libibverbs.pxd                    |  15 +-
>   pyverbs/libibverbs_enums.pxd              |  11 +-
>   tests/base.py                             |   3 +-
>   tests/test_device.py                      |  32 +++
>   22 files changed, 804 insertions(+), 93 deletions(-)
>   create mode 100644 libibverbs/man/ibv_query_gid_ex.3.md
>   create mode 100644 libibverbs/man/ibv_query_gid_table.3.md
>

The PR was merged.

Thanks,
Yishai

