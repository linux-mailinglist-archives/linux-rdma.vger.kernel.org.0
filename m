Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C6FE6124
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 07:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJ0Gdl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 02:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfJ0Gdl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 02:33:41 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10861205C9;
        Sun, 27 Oct 2019 06:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572158020;
        bh=lfdEP5MSA6RMB+RZBlTfj+pfTgkiPwFsFIn3oqhAoWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdvhRKCTUil6zD9wDzUur6zXp6uGaOdU0i4ycrjRRlumYLdQ0Fu6RfC8L+WtZ92zQ
         q1yH2YrsET3O//ktbrhYA9rwXdIc49paMPOBXDijnUJPAk6LHhsBQbRXMTXis2aV3M
         PJIcGc2h+GQfbU6O6CqMoj43+5WphLU5jFlCVzhE=
Date:   Sun, 27 Oct 2019 08:33:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH for-next] RDMA/siw: Fix post_recv QP state locking
Message-ID: <20191027063336.GX4853@unreal>
References: <20191025142903.20625-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025142903.20625-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 25, 2019 at 04:29:03PM +0200, Bernard Metzler wrote:
> Do not release qp state lock if not previously acquired.
>
> Fixes: cf049bb31f71 ("RDMA/siw: Fix SQ/RQ drain logic")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 1 -
>  1 file changed, 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
