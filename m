Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9410344B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 07:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfKTG3j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 01:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfKTG3j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Nov 2019 01:29:39 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099B92245B;
        Wed, 20 Nov 2019 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574231378;
        bh=GaHkYRAChvW9cg+edJISXgJWxvX1BqSnKg+czQMDK2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cocvET+b5QHr3McFg9835OuagXVQ6OFHEzKCYOAXp5s06cmkTib8a8XaH17XTntkm
         OVUfcEi3biuxgjJvohi40OBS6d6z53E/WvrsTKcmVLFZs4rjoy9jgXiZI03edMhquf
         qRFESv7sqO89lFK05+/bjC9yoj4ViRVhkqEEwlPw=
Date:   Wed, 20 Nov 2019 08:29:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 2/2] RDMA/cma: Add trace points in RDMA Connection
 Manager
Message-ID: <20191120062935.GL52766@unreal>
References: <20191120004308.5860.40857.stgit@manet.1015granger.net>
 <20191120004606.5860.87252.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120004606.5860.87252.stgit@manet.1015granger.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 07:46:06PM -0500, Chuck Lever wrote:
> Record state transitions as each connection is established. The IP
> address of both peers and the Type of Service is reported. These
> trace points are not in performance hot paths.
>
> Also, record each cm_event_handler call to ULPs. This eliminates the
> need for each ULP to add its own similar trace point in its CM event
> handler function.
>
> These new trace points appear in a new trace subsystem called
> "rdma_cma".
>
> Sample events:
>
>    kworker/u24:2-2127  [011]   696.746254: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 ADDR_RESOLVED (0/0)
>    kworker/u24:2-2127  [011]   696.746880: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 ROUTE_RESOLVED (2/0)
>    kworker/u28:2-2214  [001]   696.776316: cm_send_req:          cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 qp_num=526
>      kworker/1:3-972   [001]   696.777603: cm_send_mra:          cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
>      kworker/1:3-972   [001]   696.778062: cm_send_rtu:          cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
>      kworker/1:3-972   [001]   696.778198: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 ESTABLISHED (9/0)
>      kworker/1:3-972   [001]   700.621750: cm_disconnect:        cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
>      kworker/1:3-972   [001]   700.621881: cm_sent_dreq:         cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0
>      kworker/3:2-512   [003]   700.622354: cm_event_handler:     cm_id.id=1 src: 192.168.2.51:57696 dst: 192.168.2.55:20049 tos=0 DISCONNECTED (10/0)
>
> Some features to note:
> - restracker ID of the rdma_cm_id is tagged on each trace event
> - The source and destination IP addresses and TOS are reported
> - CM event upcalls are shown with decoded event and status
> - CM state transitions are reported
>
> This patch is based on previous work by:
>
> Saeed Mahameed <saeedm@mellanox.com>
> Mukesh Kacker <mukesh.kacker@oracle.com>
> Ajaykumar Hotchandani <ajaykumar.hotchandani@oracle.com>
> Aron Silverton <aron.silverton@oracle.com>
> Avinash Repaka <avinash.repaka@oracle.com>
> Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/Makefile    |    2
>  drivers/infiniband/core/cma.c       |   59 +++++++--
>  drivers/infiniband/core/cma_trace.c |   16 +++
>  drivers/infiniband/core/cma_trace.h |  219 +++++++++++++++++++++++++++++++++++
>  4 files changed, 279 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/infiniband/core/cma_trace.c
>  create mode 100644 drivers/infiniband/core/cma_trace.h

Chuck, thanks for the updated commit message, the patches look very good.
Unfortunately, I wasn't able to compile latest series as well.

_  kernel git:(24005116b337) mkt build
Start kernel compilation in silent mode
In file included from drivers/infiniband/core/cma_trace.h:219,
                 from drivers/infiniband/core/cma_trace.c:16:
./include/trace/define_trace.h:95:42: fatal error: ./cma_trace.h: No such file or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.
make[3]: *** [scripts/Makefile.build:265: drivers/infiniband/core/cma_trace.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:509: drivers/infiniband/core] Error 2
make[1]: *** [scripts/Makefile.build:509: drivers/infiniband] Error 2
make: *** [Makefile:1649: drivers] Error 2

_  kernel git:(173822da8f6f) git l -n 3
173822da8f6f (HEAD) RDMA/cma: Add trace points in RDMA Connection Manager
24005116b337 RDMA/core: Trace points for diagnosing completion queue issues
a25984f3baaa (rdma/wip/jgg-for-next) RDMA/qedr: Fix null-pointer dereference when calling rdma_user_mmap_get_offset

Thanks
