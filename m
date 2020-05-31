Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E61E96C7
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2020 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEaKCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 May 2020 06:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgEaKCF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 31 May 2020 06:02:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6812074A;
        Sun, 31 May 2020 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590919324;
        bh=M4mT3s81ixT/pOHK15KxKYyNSZ2pCkT17YWD2DKh3I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCFtlWfXqHisupUHhbwqjy77iGfwZeEOzoPdSm3/mjPy9MA5EYUvqlKobCwB5qdLV
         m69Ux2OufnD0FXDiO9RPXXxYOAIgNjPTE1M+Yu7kG7L87GzAPrpd+16iWIZbLCG/+a
         dAO4+r2FnVeZ1s6STqEZFnMfUHMTQYi33ELt4FhM=
Date:   Sun, 31 May 2020 13:02:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/core: Move and rename trace_cm_id_create()
Message-ID: <20200531100200.GG66309@unreal>
References: <20200530174934.21362.56754.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530174934.21362.56754.stgit@manet.1015granger.net>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 30, 2020 at 01:52:58PM -0400, Chuck Lever wrote:
> The restrack ID for an rdma_cm_id is not assigned until it is
> associated with a device.
>
> Here's an example I captured while testing NFS/RDMA's support for
> DEVICE_REMOVAL. The new tracepoint name is "cm_id_attach".
>
>            <...>-4261  [001]   366.581299: cm_event_handler:     cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0 ADDR_ERROR (1/-19)
>            <...>-4261  [001]   366.581304: cm_event_done:        cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0 ADDR_ERROR consumer returns 0
>            <...>-1950  [000]   366.581309: cm_id_destroy:        cm.id=0 src=0.0.0.0:45919 dst=192.168.2.55:20049 tos=0
>            <...>-7     [001]   369.589400: cm_event_handler:     cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0 ADDR_ERROR (1/-19)
>            <...>-7     [001]   369.589404: cm_event_done:        cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0 ADDR_ERROR consumer returns 0
>            <...>-1950  [000]   369.589407: cm_id_destroy:        cm.id=0 src=0.0.0.0:49023 dst=192.168.2.55:20049 tos=0
>            <...>-4261  [001]   372.597650: cm_id_attach:         cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 device=mlx4_0
>            <...>-4261  [001]   372.597652: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ADDR_RESOLVED (0/0)
>            <...>-4261  [001]   372.597654: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ADDR_RESOLVED consumer returns 0
>            <...>-4261  [001]   372.597738: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ROUTE_RESOLVED (2/0)
>            <...>-4261  [001]   372.597740: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ROUTE_RESOLVED consumer returns 0
>            <...>-4691  [007]   372.600101: cm_qp_create:         cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 pd.id=2 qp_type=RC send_wr=4091 recv_wr=256 qp_num=530 rc=0
>            <...>-4691  [007]   372.600207: cm_send_req:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 qp_num=530
>            <...>-185   [002]   372.601212: cm_send_mra:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0
>            <...>-185   [002]   372.601362: cm_send_rtu:          cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0
>            <...>-185   [002]   372.601372: cm_event_handler:     cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ESTABLISHED (9/0)
>            <...>-185   [002]   372.601379: cm_event_done:        cm.id=0 src=192.168.2.51:47492 dst=192.168.2.55:20049 tos=0 ESTABLISHED consumer returns 0
>
> Fixes: ed999f820a6c ("RDMA/cma: Add trace points in RDMA Connection Manager")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/infiniband/core/cma.c       |    2 +-
>  drivers/infiniband/core/cma_trace.h |   20 +++++++++++++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)
>
> Changes since v1:
> * Select a better name than "cm_id_resolve"
> * Capture more information about the new ID, including the name of
>   the attached underlying device
> * As Leon has requested in the past, include sample capture output
>   in the patch description
>

Thanks a lot,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
