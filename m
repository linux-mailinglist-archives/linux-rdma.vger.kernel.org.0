Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26002F46EE
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 09:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbhAMIx4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 03:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbhAMIx4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 03:53:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84AB423381;
        Wed, 13 Jan 2021 08:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610527995;
        bh=qpH2XiGe9mWZJ3BENyI/veWoaFTA3ufL0ceH8kbFSfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PF3t5S5HTusRSLefeoZNuHX/PmQdv14iBn68QQRUBse8Pb5VHFBY0NQdsi1AUEqKq
         lm+IfcPf3h0qWXuIFg9ThzbSr1Uv6B6ZTaQAGCOb3FIyEaKePo8zzH17oNfHY6vS2Q
         UFMts5aG9i54erFCWLLfC6GUAKkQaza1Y8CnuV9x2yVeedT+yODn/Ny/KC3fYA/Dd9
         bzwScGE8dkGCOG2ZQzWJZVpAiX9GlemFUj0WQs6A2YWJIwNgCKz6Baw05rlkA4/iQ7
         RS+TFuCamCntCjWlxHSfFVxLAvkQyZukNRCXXgzWLEg30bcPDbrXAahz/ADVdHjfdU
         LNxaL4OFxk/5A==
Date:   Wed, 13 Jan 2021 10:53:11 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [rdma-core PATCH] verbs: Update the type of some variables in
 documents
Message-ID: <20210113085311.GI4678@unreal>
References: <20210111085724.27641-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111085724.27641-1-yangx.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 11, 2021 at 04:57:24PM +0800, Xiao Yang wrote:
> The type of some variables has been changed from int to
> unsigned int thus update the corresponding documents.
>
> Fixes: 8fe7f12f1723 ("verbs: Bitwise flag values should be unsigned")
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  libibverbs/man/ibv_bind_mw.3      | 4 ++--
>  libibverbs/man/ibv_create_cq_ex.3 | 2 +-
>  libibverbs/man/ibv_modify_qp.3    | 2 +-
>  libibverbs/man/ibv_poll_cq.3      | 2 +-
>  libibverbs/man/ibv_post_send.3    | 4 ++--
>  libibverbs/man/ibv_query_qp.3     | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)

Thanks, merged, pending CI results.
https://github.com/linux-rdma/rdma-core/pull/924
