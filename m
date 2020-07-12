Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB00C21CAD1
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 19:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgGLRoX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 13:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbgGLRoX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Jul 2020 13:44:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1ED82063A;
        Sun, 12 Jul 2020 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594575863;
        bh=i26qvcGDndSnMi7hMFopLNXVGhJDifEC8I851KD130U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUK1wib1a4nCWtq+DQRo4MFc2dJcI1sfUwsfAlUnxpN62ag81H0ljqLqdBmkrLb0h
         qHpiA/FY3YeDQzEOs4XvB+jZbLPBKLwwPVFw16hz4qT6gwFS4rUfMcg2Sm1hlWQMM0
         6OwOMnYzGYlWfkPf9PeZdlql2wQQRwATtd7yRU2k=
Date:   Sun, 12 Jul 2020 20:44:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] IB/hfi1: Remove unnecessary fall-through
 markings
Message-ID: <20200712174420.GE7287@unreal>
References: <20200709235250.GA26678@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709235250.GA26678@embeddedor>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 09, 2020 at 06:52:50PM -0500, Gustavo A. R. Silva wrote:
> Reorganize the code a bit in a more standard way[1] and remove
> unnecessary fall-through markings.
>
> [1] https://lore.kernel.org/lkml/20200708054703.GR207186@unreal/
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Remove additional overlooked fall-through markings.
>
>  drivers/infiniband/hw/hfi1/chip.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
