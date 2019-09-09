Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51BAD644
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfIIKDi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 06:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfIIKDi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 06:03:38 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FA721920;
        Mon,  9 Sep 2019 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568023418;
        bh=IE5JRl4yxFbVwF7S4yqglmS8VMfPYhJ14zsudJ0XWh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUVMhTtOYEaDhnIdapX4C/HXGQQmrw5W2IteDpYPzsqbuCpOqDMWpEPROxQJdfTe1
         G/htsjqu3OeHgqX7fO4apVeVBjibEjv7lwr739YNSPx2akKsYON2oor0LW83YbuUzW
         8DOjaqpX0M76WIlzlGilPTE7P5y3hFWYoVp7dyg4=
Date:   Mon, 9 Sep 2019 13:03:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, krishna2@chelsio.com,
        dledford@redhat.com
Subject: Re: [PATCH] RDMA/siw: Fix page address mapping in TX path
Message-ID: <20190909100334.GE6601@unreal>
References: <20190906142149.15674-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906142149.15674-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 06, 2019 at 04:21:49PM +0200, Bernard Metzler wrote:
> Use the correct kmap()/kunmap() flow to determine page
> address used for CRC computation. Using page_address()
> is wrong, since page might be in highmem.
>
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Bernard,

You need to write version and target in your title [PATCH v100 rdma-next] ...
And changelog.

Thanks
