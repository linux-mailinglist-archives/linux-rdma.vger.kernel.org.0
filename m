Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1E3AFC2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfFJHei (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 03:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbfFJHei (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 03:34:38 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A562082E;
        Mon, 10 Jun 2019 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560152078;
        bh=N6prUBJiVYVMkyuqCzpJKQZ7Gvh30ynS2cKk/RoUUq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zY2nufPCQrMmRgUfJbyiqP1AmTWRkboODm7QSnQEKd4Jr9Nb1tcLZu48YZr18JG/s
         98ox/FPNY15uryDeYqYrWJU7psK4WUcCI/zibj6EN+TS8/GbezdN/MHq13CdGFuCfH
         AMc8iXvrJC8j33GIc8m7J/D9GDt+GGblFKS4Y5xg=
Date:   Mon, 10 Jun 2019 10:34:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 11/12] SIW debugging
Message-ID: <20190610073434.GJ6369@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-12-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-12-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:55PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_debug.c | 102 ++++++++++++++++++++++++++
>  drivers/infiniband/sw/siw/siw_debug.h |  35 +++++++++
>  2 files changed, 137 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.h

1. Use Gal's ibdev_* prints.
2. Remove all your custom siw_print_hdr() thing. It belongs to custom
debug kernel which you can use in-house, but not for upstream and
globally distributed code. Our assumption that code works.

Thanks
