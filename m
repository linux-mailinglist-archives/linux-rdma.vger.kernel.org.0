Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603CD497108
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 12:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiAWLES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 06:04:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57564 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiAWLES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 06:04:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7805AB80CA0
        for <linux-rdma@vger.kernel.org>; Sun, 23 Jan 2022 11:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA51C340E2;
        Sun, 23 Jan 2022 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642935856;
        bh=xYOyi0bOqRrGANSSAHUtJdAiBfLjN1DDS8mqr5m5C60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxp/QVJgG+HgfMTkqH6pk62oMp4fRnqIYn6mfVyKgj8dO0UK6McMbGm03/nKxAzpe
         hjhQ5DpwgDi1tDq3AQx/0CtE/jP67ocygeIcRXsdW3yzCE/RfIgZ3G04bqrf1of+d+
         DuUJCkp6npBjra6TIw+6dX32kzQtCBLCLTYB90Tdo1Q5fTIJ9hdOCYg5MWj+XYzexk
         yKobpxoR4mPiM00v60oaV26iyoK3hJSbNFeJdQgJJYvnB5ICtcN66Mje1pV+7JXiLi
         0Rw/xYvItVcZ2HC6Tf78QLTZztdwjYhEBS8HN/vr99NGVJycQ8J6AY/MY8LNJhxmUV
         XlXrqdM4xFg4A==
Date:   Sun, 23 Jan 2022 13:04:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com, jgg@ziepe.ca
Subject: Re: [PATCH rdma-core v2] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Message-ID: <Ye02K3ehx5Zw9aya@unreal>
References: <20220121062222.2914007-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121062222.2914007-1-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 21, 2022 at 02:22:22PM +0800, Xiao Yang wrote:
> The expression "cons == ((qp->cur_index + 1) % q->index_mask)" doesn't
> check the state of queue (full or empty) correctly.  For example:
> If cons and qp->cur_index are 0 and q->index_mask is 1, the queue is actually
> empty but check_qp_queue_full() reports full (ENOSPC).
> 
> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  providers/rxe/rxe_queue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.
