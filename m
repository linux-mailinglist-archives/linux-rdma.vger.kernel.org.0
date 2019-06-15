Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA254705B
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFOOMR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 10:12:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFOOMR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 10:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xeia7Y2H20qxvC8T957Brc8A65sMgIu+4oNZeZROWY8=; b=dNgRTy1VE+B9PBH6hwZ144/wJ
        hPJ6HGzKtH5KFgLTt3v3DzpcFqBEl0IyH4qot6+xc/fHoQLRWtTYKcvLodHmCCN46/wHpw9o1LC+d
        nsupPfh3zYNfmm6O8UQibHe4FMPlCLRsrs6+iyIHs0QZrxD56KndDvsC847sZcv6SIrm6GQgUprWL
        dLf+9pS7RKXZVIxFmz9AdlM5H70IdanFowU889RfB3jQkG9MqEaLpup3QiULxuk0eU94Wk5oziV5R
        nPOTz5pupFoa5pc3bHOanYkNsZ9BGWIx7d1wmp4/iHlZ+xYvhlfjsKxuQQnPCPdSq4GwKA3+eNie/
        GNiDvfjrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9Pf-000272-29; Sat, 15 Jun 2019 14:12:11 +0000
Date:   Sat, 15 Jun 2019 07:12:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 04/12] mm/hmm: Simplify hmm_get_or_create and make
 it reliable
Message-ID: <20190615141211.GD17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-5-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-5-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +	spin_lock(&mm->page_table_lock);
> +	if (mm->hmm) {
> +		if (kref_get_unless_zero(&mm->hmm->kref)) {
> +			spin_unlock(&mm->page_table_lock);
> +			return mm->hmm;
> +		}
> +	}
> +	spin_unlock(&mm->page_table_lock);

This could become:

	spin_lock(&mm->page_table_lock);
	hmm = mm->hmm
	if (hmm && kref_get_unless_zero(&hmm->kref))
		goto out_unlock;
	spin_unlock(&mm->page_table_lock);

as the last two lines of the function already drop the page_table_lock
and then return hmm.  Or drop the "hmm = mm->hmm" asignment above and
return mm->hmm as that should be always identical to hmm at the end
to save another line.

> +	/*
> +	 * The mm->hmm pointer is kept valid while notifier ops can be running
> +	 * so they don't have to deal with a NULL mm->hmm value
> +	 */

The comment confuses me.  How does the page_table_lock relate to
possibly running notifiers, as I can't find that we take
page_table_lock?  Or is it just about the fact that we only clear
mm->hmm in the free callback, and not in hmm_free?
