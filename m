Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02863D0932
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhGUGJa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhGUGIb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 02:08:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE952C061762;
        Tue, 20 Jul 2021 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C2FarTYNvA1qUZhf+FlQcfSBhf5aztfYWSW31p415yQ=; b=aTxk7GDqctKlM/nDPBx4it64IF
        ITMxHV9QLblGHVJoAqfBhrGZk8Oa6OwjLd57+vnRjGrHT3vcEHwwB9sSVmTQDqK0rqzM9b0y4ib2w
        kbk4t4H1XAFvRk0HKXcwWYCHGO9CeNVbl5EulYOJzfVLEePdwvpSUJULOhmtFzwyslxgkHFiAq5Rj
        OHXCrbJ/cKe1L7KEXp6PdTlkrpDLNkZVu1V57bXTnafDZSv1bg80LaN1WfdZc59SZLnRJu9D14uH0
        P3lKV5dvsh4iv6NzKRQJ5D1q2tT7O6sL5pf1sBJKWUFstunshOGpRZ+Yj42shc1y4sWKckW6oXpwX
        rlWHWwvQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m662C-008tXx-LD; Wed, 21 Jul 2021 06:48:49 +0000
Date:   Wed, 21 Jul 2021 07:48:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 7/7] RDMA/core: Create clean QP creations
 interface for uverbs
Message-ID: <YPfDUN6CaOdGZLPS@infradead.org>
References: <cover.1626846795.git.leonro@nvidia.com>
 <8eaf125d3bfb463e1641b6f2794203cc93d76c90.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eaf125d3bfb463e1641b6f2794203cc93d76c90.1626846795.git.leonro@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +struct ib_qp *ib_create_qp_user(struct ib_device *dev, struct ib_pd *pd,
> +				struct ib_qp_init_attr *attr,
> +				struct ib_udata *udata,
> +				struct ib_uqp_object *uobj, const char *caller);
> +static inline struct ib_qp *ib_create_qp_uverbs(struct ib_device *dev,
> +						struct ib_pd *pd,
> +						struct ib_qp_init_attr *attr,
> +						struct ib_udata *udata,
> +						struct ib_uqp_object *uobj)
> +{
> +	if (attr->qp_type == IB_QPT_XRC_TGT)
> +		return ib_create_qp_user(dev, pd, attr, NULL, uobj,
> +					 KBUILD_MODNAME);
> +
> +	return ib_create_qp_user(dev, pd, attr, udata, uobj, NULL);

Why not always pass along the udata and caller and just not use them
in the low-level code?
