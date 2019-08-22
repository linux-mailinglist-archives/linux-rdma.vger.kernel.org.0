Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24489947D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 15:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbfHVNIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 09:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387491AbfHVNIb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 09:08:31 -0400
Received: from localhost (unknown [12.235.16.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C870C2173E;
        Thu, 22 Aug 2019 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566479310;
        bh=4IviL14auycRDJWpnfwLkOCo4p6BfOorEeJOXicEO8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJuAdDRsUjttCTtoVc0SDomhxTIvvN8h+WTZhdu8jzXtMIIYelaWDA0gteB46FHvc
         0yldd3EG1VClT5J8tRVjeWOzp1CXt42pZTZ/uK8VXCZIpwJ+MG1ESx/xSLzym2WEe8
         kwpdhFFyZw57f8jloFbxUOYgKR26GXuBPnaJcC2I=
Date:   Thu, 22 Aug 2019 16:08:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, geert@linux-m68k.org
Subject: Re: [PATCH v2] RDMA/siw: fix 64/32bit pointer inconsistency
Message-ID: <20190822130829.GE29433@mtr-leonro.mtl.com>
References: <20190820172221.6274-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820172221.6274-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 20, 2019 at 07:22:21PM +0200, Bernard Metzler wrote:
> Fixes improper casting between addresses and unsigned types.
> Changes siw_pbl_get_buffer() function to return appropriate
> dma_addr_t, and not u64.
>
> In debug prints, all potentially kernel private variables
> are printed as void * to allow keeping that information
> secret.

It is done by using %pK and not by strange casting.
https://elixir.bootlin.com/linux/v5.3-rc5/source/Documentation/core-api/printk-formats.rst#L113

Thanks
