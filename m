Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC57C4B3E8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfFSITB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 04:19:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731300AbfFSITB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 04:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gJX7HuiaCgGHU1tdXgWOcBNZy61GCc1VlLrp6/M8Mfw=; b=F790NaadzLyX7kysrjoApfm8RL
        4B1qNTBJfA0dl3N2JFg7SkdFf/LV7qaQII9PBdIa20bkjqtxcmGUwf+IuWcV2ibWAgsqDFtgZ10h3
        RmDk6y3Jz8+Gq/K8bwcRJ82kfshQD98z9+21iRI1lhYdvFPXMWHI2KrNHEW9Zp4fz+eddphLaeKmK
        7YKDKbdhA2jVqdoHJ2IwfWMe8r3oyhcU8AeQcHnGgGUETxIzdZ41ILhG+33dgEOu49ViOMsWHeo8G
        IUy9pHZKLxnzdOSeyWXtSPzsK7Po1H4f4mu7rgQNltggATnslxmZYgJ4TgX6agsLnNAyjvYsFfIno
        WBSAPrTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdVo2-0000Z1-N3; Wed, 19 Jun 2019 08:18:58 +0000
Date:   Wed, 19 Jun 2019 01:18:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 06/12] mm/hmm: Hold on to the mmget for the
 lifetime of the range
Message-ID: <20190619081858.GB24900@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-7-jgg@ziepe.ca>
 <20190615141435.GF17724@infradead.org>
 <20190618151100.GI6961@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190618151100.GI6961@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>  	mutex_lock(&hmm->lock);
> -	list_del(&range->list);
> +	list_del_init(&range->list);
>  	mutex_unlock(&hmm->lock);

I don't see the point why this is a list_del_init - that just
reinitializeѕ range->list, but doesn't change anything for the list
head it was removed from.  (and if the list_del_init was intended
a later patch in your branch reverts it to plain list_del..)
