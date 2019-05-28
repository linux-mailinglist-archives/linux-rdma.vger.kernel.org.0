Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04FC2C75E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 15:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfE1NJE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 09:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfE1NJE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 09:09:04 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCB9208C3;
        Tue, 28 May 2019 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559048944;
        bh=zetCP8eEiCw3OVgAi1O9s2Z/RNTQWxLHVfW955CY4/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jImWfnVz28iTA/v7qT4gFiGCwclivSDRJDWavoM1bYTgUHVARCHAvIqlO0zHT55Mk
         aQmgfm/0jPWw0w+ur8CcY0SfrtK2AS2aT+XftEsVFk4mgprPsOLY3dbEl88Ye9v7xR
         33DtJpuC8YKVIQDSR3HLC9oVI4lvQ46c7e23E3e8=
Date:   Tue, 28 May 2019 16:09:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 2/3] RDMA: Clean destroy CQ in drivers do
 not return errors
Message-ID: <20190528130901.GL4633@mtr-leonro.mtl.com>
References: <20190528113729.13314-1-leon@kernel.org>
 <20190528113729.13314-3-leon@kernel.org>
 <1934b1ce-d700-2cd1-d4eb-a30d8d13770d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1934b1ce-d700-2cd1-d4eb-a30d8d13770d@amazon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 04:03:42PM +0300, Gal Pressman wrote:
> On 28/05/2019 14:37, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Like all other destroy commands, .destroy_cq() call is not supposed
> > to fail. In all flows, the attempt to return earlier caused to memory
> > leaks.
> >
> > This patch converts .destroy_cq() to do not return any errors.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>
> This patch doesn't apply to my tree for some reason.

I rebased it on top of rdma/wip/jgg-for-next branch.

>
> Other than that, for the EFA part:
> Acked-by: Gal Pressman <galpress@amazon.com>

Thanks

>
> Thanks Leon
