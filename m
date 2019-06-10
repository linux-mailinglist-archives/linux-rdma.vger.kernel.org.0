Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7E13AF6B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfFJHTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 03:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387785AbfFJHTU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 03:19:20 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD7620833;
        Mon, 10 Jun 2019 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560151159;
        bh=uU+SaMslbDCeAD62WF5O8kI0LZXer9+TnFKY1aY4OMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIcVTSyJMDEoRE5jL7hgR4azJjWiXQReFuCRnBnw28/vnVN1ztjE4OwfXUX1dFPmH
         NN067BpEdi2/M6fY1ocUohQsc+U+b8OeNL2QPnCt+vgAgfUuhAdusPekl1yjSGH97x
         GIeo5i0+jZHEtE0Kje7gNXnjeFy5cGVaCq3HhfgI=
Date:   Mon, 10 Jun 2019 10:19:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 08/12] SIW transmit path
Message-ID: <20190610071915.GG6369@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-9-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-9-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:52PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 1276 +++++++++++++++++++++++++
>  1 file changed, 1276 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
>

I didn't review this patch at all.

Thanks
