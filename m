Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9A22B5E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 07:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfETFnl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 01:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbfETFnl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 01:43:41 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC9C206B6;
        Mon, 20 May 2019 05:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558331020;
        bh=citXfIALYTKM2/0a/PQoCzE9WDUDmaXoIhc2x2/4qc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0EPg/A39TgFbnue2aecE+hrztcQy3XDnb+D3uQpgJ6F07EiUo/+b947l2zpwOngYW
         0Ev6udk75rERuFf+rLezug/i2KMbWBe/I4W2EnU2B4lKdLCQ0TS8gmBnsavXcPdfUI
         Iz5/lNv3nFZN1UBOEWqHlFjzL0dvwbyVKD+Fq4c8=
Date:   Mon, 20 May 2019 08:43:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/core: Rename ib_device_check_mandatory
Message-ID: <20190520054336.GA4573@mtr-leonro.mtl.com>
References: <20190519201627.17188-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519201627.17188-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 19, 2019 at 11:16:27PM +0300, Kamal Heib wrote:
> The return value from ib_device_check_mandatory() is always 0 - change
> it to be void and rename the function to emphasize the use of it, which
> is setting the kverbs_provider flag.

Actually check_mandatory is the real usage of that function and
kverbs_provider is extra granularity.

So yes to "void", no to function name change.

Thanks
