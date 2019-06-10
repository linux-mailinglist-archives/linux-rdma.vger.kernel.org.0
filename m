Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB23AF72
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 09:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbfFJHVe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 03:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387541AbfFJHVe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 03:21:34 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F5720833;
        Mon, 10 Jun 2019 07:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560151293;
        bh=BUWN9R/X2Xv1WpghOJBXiUD/3cJKELpPeri/3hKudcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opjZ0wewYPDiP1hjIcR5MwLf7uWKHzJnC6D7qgAF/Iql9v4+kHDMfYAKbliqaMi7w
         42vb+WV8KsBi9KjnmL5zj5JI8sXfweMuZZ7sRqXo1eJPbi44dYwoYRKIdBK7hrFfp5
         MoAhcxrb1l/azOEiqQx0nJV71HIpEdsehwqvUgJ8=
Date:   Mon, 10 Jun 2019 10:21:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 09/12] SIW receive path
Message-ID: <20190610072130.GH6369@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-10-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-10-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:53PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 1537 +++++++++++++++++++++++++
>  1 file changed, 1537 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
>

I didn't look on this patch either, except extra amount of
likely/unlikely statements.

Thanks
