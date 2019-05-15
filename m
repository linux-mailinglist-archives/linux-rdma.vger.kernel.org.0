Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D531E7F3
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 07:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOFfO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 01:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOFfO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 01:35:14 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492572084A;
        Wed, 15 May 2019 05:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557898513;
        bh=eQFOULB91KYtJjyQyuFsy1LNdj3blon4wF8Lt67uJuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMdcX8eapcefREYfY2SMxrS0Bnial+J6qfmoFkWCR4Z1a/f1W9A/c2jZyJ6QSA+3v
         71Cnp/Ve2PTMjwndzXy87oOkCSEeiiiE+KdWxM00HVjPyCf15mTT0Bn7UP7bgLot4T
         vJ55UJ3RC4KksFnAdHy3o6WccIIFrcHxQbeeHhfY=
Date:   Wed, 15 May 2019 08:35:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH rdma-core 5/5] build: Enable more warnings
Message-ID: <20190515053510.GI5225@mtr-leonro.mtl.com>
References: <20190514233028.3905-1-jgg@ziepe.ca>
 <20190514233028.3905-6-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514233028.3905-6-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 14, 2019 at 08:30:28PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> The format-nonliteral option makes sure that the input to a formatting
> function is actually a format string and not something else.
>
> date-time helps ensure reproducible builds
>
> redundant-decls, nested-externs are just general cleanlyness other
> projects tend to turn on.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  CMakeLists.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
