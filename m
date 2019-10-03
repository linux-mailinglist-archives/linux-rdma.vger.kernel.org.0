Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69D2CB049
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfJCUlK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:41:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfJCUlK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Oct 2019 16:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IF1FolxTqmDTd/x1Q52V8Xh4wjuT53fQ+vxzesNKzJ0=; b=HPp/6lAlpE0Jvcw0rdXMwN6UV
        Qej28WAocyfIo02LqH1bwMfgUDN7ybvuwl0+oGgQuBeWy0LITlxanB/pj45j45ZRBLdIhq5Pg3136
        Dgcb3313rfrD27i14BwWBF7m0E2O5Iz56LPUEKGa7IS5Ao3+SY6iYysrPd1aML6yWGke+g7yVFR7W
        8lldEDb8wqcvmJstIdsdQIExY2L07IfV2Vkub3RjT+ig/PJeXyMklxJ26Oz80qEbvlXL/yv4eWlx7
        i3zflHLA2zpZsBxy0V6NmrvFwk/5ymQToL5kmZ3jaq66pyYFINebi9urL29q1pHAjUhHvunoGCHbf
        tD2/xhL+w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG7uO-0001rj-Lm; Thu, 03 Oct 2019 20:41:08 +0000
Date:   Thu, 3 Oct 2019 13:41:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 08/11] mm: convert vma_interval_tree to half closed
 intervals
Message-ID: <20191003204108.GF32665@bombadil.infradead.org>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-9-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-9-dave@stgolabs.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:55PM -0700, Davidlohr Bueso wrote:
> +++ b/mm/nommu.c
> @@ -1793,7 +1793,7 @@ int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
>  	size_t r_size, r_top;
>  
>  	low = newsize >> PAGE_SHIFT;
> -	high = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	high = (size + PAGE_SIZE) >> PAGE_SHIFT;

Uhh ... are you sure about this?  size is in bytes here, and we're rounding
up to the next page size.  So if size is [1-4096], then we add on 4095 and get
the answer 1.  With your patch, if size is [0-4095], we get the answer 1.
I think you meant:

	high = ((size + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;

