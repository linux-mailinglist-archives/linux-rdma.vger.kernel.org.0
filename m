Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A363A577F
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jun 2021 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhFMKOc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Jun 2021 06:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhFMKOa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Jun 2021 06:14:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FF8E610CD;
        Sun, 13 Jun 2021 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623579149;
        bh=4j0t86xEDqwSgLQ5VJS4QZm5zgU3dxieEF1JQQnyVuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMpaG+3J6O2UFt6D6Q5qHYgU2FCZfizFOXOV74dSijy04/RuMyJIbs6ENrBjqGj/m
         SASejaDtz15HsDWGz7LcgQg7UaNBizVYee6J8FwGjfxKaHPijdpadAIs5LPFwVzQZP
         RfFIYHSBwfOduns6cCChgYyB+hRAMOTGShPpMjI+HEFOpR2G3O9TTLSOuSsJ5eTwqf
         IA+2DMlBrBgBU3n+WFJGm7xgWJrLU8UZvJ3ioCB383zSyIgiV4mh7SPsVOEdWRipaN
         fZlM7jhivPg/0eixvcjstBQVGQNRwOHAbfxd+F39fpkiRBNq2vYR3YUrPAEW8lmM6Y
         BDrhGvsc5sIAQ==
Date:   Sun, 13 Jun 2021 09:23:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, jgg@ziepe.ca, haris.iqbal@ionos.com,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 2/5] RDMA/rtrs-clt: Use minimal max_send_sge
 when create qp
Message-ID: <YMWkULm4ZwZMaRlD@unreal>
References: <20210611121034.48837-1-jinpu.wang@ionos.com>
 <20210611121034.48837-3-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611121034.48837-3-jinpu.wang@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 02:10:31PM +0200, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> We use device limit max_send_sge, which is suboptimal for memory usage.
> We don't need that much for User Con, 1 is enough. And for IO con,
> sess->max_segments + 1 is enough
> 
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++++------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
