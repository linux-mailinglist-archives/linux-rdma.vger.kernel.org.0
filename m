Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6B42C0F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405705AbfFLQVd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 12:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437980AbfFLQVd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 12:21:33 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D5B2082C;
        Wed, 12 Jun 2019 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560356493;
        bh=GD8F+KiqYzp8NgxX5RAv+b3r/ohIPBf7iuTJMcW6xOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opSszXDtpFesO5QL5zgNXH7lNG1e9T3ZhGwiePc0MjcWAbxXo0sEpRR+/lDGof/TN
         pG9FukpUxQ44qXsapdcDS6s/TckBreemGFUJuuv575+GVbWpYkHU0q+sKy6zNX4NMh
         MlTxqI+I20bms5SpMCZ+9jHyH5GkkDybRwqmq860=
Date:   Wed, 12 Jun 2019 19:21:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, jgg@mellanox.com
Subject: Re: [PATCH v5 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190612162127.GT6369@mtr-leonro.mtl.com>
References: <20190611122336.9707-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611122336.9707-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 03:23:36PM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> passed later in post_recv and post_send operations.
>
> On some virtualized environment this is not correct.
>
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
> Since HW cannot access guest virtual address space an extra translation
> is needed to map those addresses to be based on the host virtual address
> that was registered with the HW.
> This datapath interference affects performances.
>
> To avoid this, a logical separation between the address that is
> registered and the address that is used as a offset at datapath phase is
> needed.
> This separation is already implemented in the lower layer part
> (ibv_cmd_reg_mr) but blocked at the API level.
>
> Fix it by introducing a new API function which accepts an address from
> guest virtual address space as well, to be used as offset for later
> datapath operations.
>
> Also update the PABI to v25

It is not "also", it is "must".

>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
