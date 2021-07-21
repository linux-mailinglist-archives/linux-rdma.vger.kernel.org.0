Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4295F3D0927
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 08:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhGUGHJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 02:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhGUGFc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 02:05:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D600C061574;
        Tue, 20 Jul 2021 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pyHtN+Xci42zugXAkTf9n9TxewDvmHNLWNT2t946HgU=; b=aeVaTNPESISav9LEVCg5sedbVI
        LpG/b5gousUA1XZBMh5DdRuzJJT1GpqhgkcXVAEensgLNXVOATCLgnUvwEGRXfLDDrrt/a/rgNyTu
        Jhp4JCFNZB+Cx0ei2l6dVdakCkximDNOdd7NB8FL3as59wJFngTHVpL8lzErfGKelO41AAZZjYGNN
        uYwWHvaAr1+5jnN6ELJ79TPPxr74ELaB+Jdjrromp48jmWUs1GrdLxsMYWtXkoy+dd2ccxxM9sRN5
        b2CRKxwlpKSajpSNHkEHM+/JMElL3dgoI9vgjdKHQkHXymj3VV8onUBeWZ8LdUjccn08aFam+h2Sw
        XFCWIEFQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m65zI-008tO6-Gx; Wed, 21 Jul 2021 06:45:52 +0000
Date:   Wed, 21 Jul 2021 07:45:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 4/7] RDMA/core: Reorganize create QP low-level
 functions
Message-ID: <YPfCnIfVmolgfMPF@infradead.org>
References: <cover.1626846795.git.leonro@nvidia.com>
 <328963df8e30bfc040c846d2c7626becd341f3ec.1626846795.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328963df8e30bfc040c846d2c7626becd341f3ec.1626846795.git.leonro@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +/**
> + * ib_create_qp_kernel - Creates a kernel QP associated with the specified

Any reason this function is renamed?  This seems rather unrelated to
the rest of th patch.

> + *   protection domain.
>   * @pd: The protection domain associated with the QP.
>   * @qp_init_attr: A list of initial attributes required to create the
>   *   QP.  If QP creation succeeds, then the attributes are updated to
>   *   the actual capabilities of the created QP.
>   * @caller: caller's build-time module name
> - *
> - * NOTE: for user qp use ib_create_qp_user with valid udata!
>   */

Also a kerneldoc comment for a function that is an implementation
detail is actively harmful.  Please document ib_create_qp instead.
