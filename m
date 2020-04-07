Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB73B1A1252
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 18:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDGQ7t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 12:59:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDGQ7t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Apr 2020 12:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tt8y8o6P3HWiSTvJT8G3s8QKGTM9yaoI1wGFzYbnFL4=; b=dQfJ/cp/4gOmhJjCnAwMfeGvxU
        G/wjvspdGJ5Ozs9LQ6l2JpT5jUIJLrg0EVM+n3HwMbcLUCb+A4vdMElhDScVi2R4GSIv4Z+7hJmO0
        CbYXsSG0Owl6wDBW/V5+tw0B3YaxcKtaD4YdQ2B98vDw3gY1qCPva5X8KJfhdtr8uwuJiFVTb/tMc
        e6Mi+FSR72k+Tu2xSYlEEC5bT4GP21jKNIqw+5P/jlp8DYNi+mvU/kFUTD1RyROEDdjMduBQbEVFj
        TBf6nxSI1km50g/fvjZFaQT86WfPKUwWzKy2t6RyqXnVVAVVLZvkPUnbjzXVY5ZauVIwmxFxSgiLR
        KJEOdO9Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrZi-00036R-0S; Tue, 07 Apr 2020 16:59:46 +0000
Date:   Tue, 7 Apr 2020 09:59:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/cm: Fix an error check in cm_alloc_id_priv()
Message-ID: <20200407165945.GK21484@bombadil.infradead.org>
References: <20200406145109.GQ20941@ziepe.ca>
 <20200407093714.GA80285@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407093714.GA80285@mwanda>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 07, 2020 at 12:37:14PM +0300, Dan Carpenter wrote:
> The xa_alloc_cyclic_irq() function returns either 0 or 1 on success and
> negatives on error.  This code treats 1 as an error and returns
> ERR_PTR(1) which will cause an Oops in the caller.
> 
> Fixes: ae78ff3a0f0c ("RDMA/cm: Convert local_id_table to XArray")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
