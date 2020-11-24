Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705FA2C220F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgKXJtv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 04:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgKXJtv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 04:49:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504BC0613D6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Nov 2020 01:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d6ZuqYkbfOHusqc3y6DFnVipQtCEDx53GAmDcDagbPM=; b=VTdTNc0GpSplKkomTER4QyuFFr
        bxU4sF0OZU6JaWR/9wry/HxDWOCvDkRn1eYr9Ky77Sgs1w7HTWZXl+ZgyZUd6ta85PcFlMeIGX6DK
        Zn/wltLfEt8ncXFAlydWJgOz+m4oAcKvqHZxTBWfGksTJ889GZKrCj5Qz43ILgUY/s/HfSHZT+8dt
        yaQuci3OCIlMFAZJwhN8XV5tDTmABSi5IhFaskyiy54HqoOXx0kccRX38JHK4WhTyNiVAE3x//2AQ
        9Yy6bKBwZNft2qrsDIFayzvikXNwA5v9Pxcl/6kfHSjxb4acn/at2uyuYZ1uFazz9+1BP38DHMys6
        ko5JNXKA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khUxG-0000pb-FP; Tue, 24 Nov 2020 09:49:46 +0000
Date:   Tue, 24 Nov 2020 09:49:46 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/mlx5: Use ib_dma APIs instead of open
 access to parent device
Message-ID: <20201124094946.GA3106@infradead.org>
References: <20201123082400.351371-1-leon@kernel.org>
 <20201124093154.GA29715@infradead.org>
 <20201124094628.GI3159@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124094628.GI3159@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 11:46:28AM +0200, Leon Romanovsky wrote:
> No problem, I will reduce checkpatch limit from its default.

checkpatch unfortunately does not match what is documented in the
codingstyle document and leads to these kinds of problems :(
