Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 849411E7EB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 07:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfEOFaV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 01:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOFaV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 01:30:21 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740DA2084A;
        Wed, 15 May 2019 05:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557898221;
        bh=PoFHxZTSuJ8dbXzh8iq2YBlHW77B1GAOA1kaUuPOwew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T84jOWb2ghVGZ1J3GIIxSGx6kv4FsMBDN2SJ9oBBvZesi0TM6JcG1Ol00Yzhxmr9Q
         frFadxS1vNyZEny9jJCpYGIm/sxBr1mBFsLZO17KYRRL1J1XXs2JOWy3bjw32zt88A
         WrwrSbhuuDx6GSbp5X09paHiXK/X9AjhpK/0tI7M=
Date:   Wed, 15 May 2019 08:30:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 3/5] cbuild: Use gcc-9 for debian experimental
Message-ID: <20190515053017.GG5225@mtr-leonro.mtl.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-4-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514233028.3905-4-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:30:26PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> It is available now.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  buildlib/cbuild | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
