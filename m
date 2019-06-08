Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4425339BDF
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFHIgU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 04:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfFHIgU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Jun 2019 04:36:20 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC1F2146E;
        Sat,  8 Jun 2019 08:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559982979;
        bh=DR3Imu2pdcXUcLA0AZhlR1Bbz8BAQ3ky/hvcqB6JmhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSBtsVcOaQvi0kGuhVmgun/pJTRmShnVe1+Zdpw1DFgQikqC6uYGLyL/PhxrUrcKK
         6zu3ilhYEMl3XlUDyeYKhKqT18DX/gFU1I/nqd/8lIIspXCiVySMY/Gkc6T+C1RwHG
         i6U3FzkjfIf8gNUqDcUBWvGcumr229Eguzwb8Irk=
Date:   Sat, 8 Jun 2019 11:36:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 01/12] iWarp wire packet format
Message-ID: <20190608083609.GT5261@mtr-leonro.mtl.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-2-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-2-bmt@zurich.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:45PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/iwarp.h | 380 ++++++++++++++++++++++++++++++
>  1 file changed, 380 insertions(+)
>  create mode 100644 drivers/infiniband/sw/siw/iwarp.h
>

I can't say that I liked everything in this patch,
but ok, we can fix it later.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
