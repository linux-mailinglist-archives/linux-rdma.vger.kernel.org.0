Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114553CC83C
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGRIxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 04:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhGRIxp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 04:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEFA5610A2;
        Sun, 18 Jul 2021 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626598247;
        bh=eMHCSIRazTSSfmzFVF6ADeFJ5ap6gu13mDu6BQebwHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsxQ3gwM7bNDEIod6mX+D7b3N+S16M18Ljfggn1eWtwkaJibWNBKnG2GV4BcA977C
         VUteTWjzOstT7n5z91xkZ0IVcsVmRfCR4OlvVBzYluob/ZUwdZgYhJ6Z0tN6IEjXSx
         lDLKigvkNgg22gGgMB56NdDFCr9Prw4iEI5ZuXsy01Mdd9g7rxy2+HXnhvH4LmpICb
         9sDpvX4H6WJ7GUkC+ys0PTroaNg9jtg9s5kUd4PDQ8YXSBabYk5dKW/QZJik9EGewl
         Fn9HGmvoXSUWWmSJKsYvdb92WMCf1ebVzLf72VXRvEgZ13DkH3g4l+JoZ0D1EuqmP0
         doTftiSDHkrPA==
Date:   Sun, 18 Jul 2021 11:50:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     lanevdenoche@gmail.com
Cc:     linux-rdma@vger.kernel.org, sagi@grimberg.me, dledford@redhat.com,
        jgg@ziepe.ca, Chesnokov Gleb <Chesnokov.G@raidix.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Message-ID: <YPPrY1MW51aFRSVb@unreal>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714182646.112181-1-Chesnokov.G@raidix.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 14, 2021 at 09:26:46PM +0300, lanevdenoche@gmail.com wrote:
> Calling isert_setup_id() from isert_np_cma_handler() is wrong
> since at that time the socket address was still bound to the old cma_id
> which will be destroyed via rdma_destroy_id() only after processing
> the RDMA_CM_EVENT_ADDR_CHANGE event.
> 
>  - isert_np_cma_handler() calls isert_setup_id()
> 
>  - isert_setup_id() calls rdma_bind_addr()
> 
>  - rdma_bind_addr() returns -EADDRINUSE
> 
> Move the creation of the cma_id in workqueue context and delete old
> cma_id directly, not through returning the error code to the upper
> level.

Why do you need workqueue for that?

Is it possible to introduce new function isert_np_reinit_id() and call
it directly?

Thanks
