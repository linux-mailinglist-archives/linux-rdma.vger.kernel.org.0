Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED8520162
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 10:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEPIgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 04:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfEPIgm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 04:36:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF7DC20848;
        Thu, 16 May 2019 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557995801;
        bh=B3uS7FnitJdIoAcoxM7j3f7E0AEsrkLBQKhUfM9PTr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNqoG+7udCtQJlQSXCZRgZT/3xIRie9u5YLhOQGn1y2fTLtCR3Kz0eJ+aRzaqkMEh
         QWkXOHiRSubcIfHhqlPhkLqDaULyYhDfovtq61GjH6TuHP6XKyPgp8KLBk5RPUL+Tl
         hNi19u0Qw4mUjONrPajzQ/fxJuconVtp03ehkCy4=
Date:   Thu, 16 May 2019 11:36:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Nirranjan Kirubaharan <nirranjan@chelsio.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        bharat@chelsio.com
Subject: Re: [PATCH for-next v2] iw_cxgb4: Fix qpid leak
Message-ID: <20190516083638.GW5225@mtr-leonro.mtl.com>
References: <eb1b5ff6b86ee619fa18247ca70aee81f8846038.1557987454.git.nirranjan@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb1b5ff6b86ee619fa18247ca70aee81f8846038.1557987454.git.nirranjan@chelsio.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 01:11:03AM -0700, Nirranjan Kirubaharan wrote:
> In iw_cxgb4, sometimes scheduled freeing of QPs complete after
> completion of dealloc_ucontext(). So in use qpids stored in ucontext
> gets lost, causing qpid leak. Added changes in dealloc_ucontext(),
> to wait until completion of freeing of all QPs.

I would be more than happy to see this part "sometimes scheduled freeing
of QPs complete after .." is fixed, so QP are released after call to
destroy_qp().

Thanks
