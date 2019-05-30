Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8919D2FC68
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE3NeE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:34:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:32148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfE3NeE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 09:34:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 06:34:03 -0700
X-ExtLoop1: 1
Received: from unknown (HELO [10.228.129.69]) ([10.228.129.69])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2019 06:34:02 -0700
Subject: Re: [PATCH rdma-next v1 3/3] RDMA: Convert CQ allocations to be under
 core responsibility
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20190528113729.13314-1-leon@kernel.org>
 <20190528113729.13314-4-leon@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <2e54b6d8-b012-2c6a-25fd-86afb79c9810@intel.com>
Date:   Thu, 30 May 2019 09:34:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528113729.13314-4-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/28/2019 7:37 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Ensure that CQ is allocated and freed by IB/core and not by drivers.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   drivers/infiniband/core/cq.c                  | 28 +++++----
>   drivers/infiniband/core/device.c              |  1 +
>   drivers/infiniband/core/uverbs_cmd.c          | 15 +++--
>   drivers/infiniband/core/uverbs_std_types_cq.c | 19 ++++--
>   drivers/infiniband/core/verbs.c               | 32 ++++++----
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 20 +++----
>   drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  7 +--
>   drivers/infiniband/hw/bnxt_re/main.c          |  1 +
>   drivers/infiniband/hw/cxgb3/iwch_provider.c   | 43 ++++++-------
>   drivers/infiniband/hw/cxgb4/cq.c              | 27 ++++-----
>   drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  5 +-
>   drivers/infiniband/hw/cxgb4/provider.c        |  1 +
>   drivers/infiniband/hw/efa/efa.h               |  5 +-
>   drivers/infiniband/hw/efa/efa_main.c          |  1 +
>   drivers/infiniband/hw/efa/efa_verbs.c         | 50 +++++-----------
>   drivers/infiniband/hw/hns/hns_roce_cq.c       | 23 +++----
>   drivers/infiniband/hw/hns/hns_roce_device.h   |  6 +-
>   drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 21 ++++---
>   drivers/infiniband/hw/hns/hns_roce_main.c     |  1 +
>   drivers/infiniband/hw/i40iw/i40iw_verbs.c     | 33 ++++------
>   drivers/infiniband/hw/mlx4/cq.c               | 25 +++-----
>   drivers/infiniband/hw/mlx4/main.c             |  1 +
>   drivers/infiniband/hw/mlx4/mlx4_ib.h          |  5 +-
>   drivers/infiniband/hw/mlx5/cq.c               | 32 ++++------
>   drivers/infiniband/hw/mlx5/main.c             | 21 ++++---
>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  5 +-
>   drivers/infiniband/hw/mthca/mthca_provider.c  | 36 +++++------
>   drivers/infiniband/hw/nes/nes_verbs.c         | 60 +++++++------------
>   drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  1 +
>   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 29 ++++-----
>   drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  5 +-
>   drivers/infiniband/hw/qedr/main.c             |  1 +
>   drivers/infiniband/hw/qedr/verbs.c            | 28 +++------
>   drivers/infiniband/hw/qedr/verbs.h            |  5 +-
>   drivers/infiniband/hw/usnic/usnic_ib.h        |  4 ++
>   drivers/infiniband/hw/usnic/usnic_ib_main.c   |  1 +
>   drivers/infiniband/hw/usnic/usnic_ib_verbs.c  | 18 ++----
>   drivers/infiniband/hw/usnic/usnic_ib_verbs.h  |  5 +-
>   drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  | 34 ++++-------
>   .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  1 +
>   .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  5 +-
>   drivers/infiniband/sw/rdmavt/cq.c             | 51 +++++-----------
>   drivers/infiniband/sw/rdmavt/cq.h             |  5 +-
>   drivers/infiniband/sw/rdmavt/vt.c             |  1 +
>   drivers/infiniband/sw/rxe/rxe_pool.c          |  1 +
>   drivers/infiniband/sw/rxe/rxe_verbs.c         | 30 ++++------
>   drivers/infiniband/sw/rxe/rxe_verbs.h         |  2 +-
>   include/rdma/ib_verbs.h                       |  6 +-
>   48 files changed, 319 insertions(+), 438 deletions(-)
> 

For the rdmavt parts:

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Tested-by: Dennis Dalessandro <dennis.dalessandro@intel.com>


