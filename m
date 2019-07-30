Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1127AC2E
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbfG3PWU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 11:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729905AbfG3PWU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 11:22:20 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 480C1206E0;
        Tue, 30 Jul 2019 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564500140;
        bh=ck3U7mve6X2aVYvYLXG+YCm8yZsK1ud3yvrmDzy2+jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsaLHu5Yytli3AmrBuEVCulhfvSLhUuLuPIRxZta1NTJWmzuwWEPfxPd8sm7w5aFS
         dJvXHpJ+BhNrZnCgQ9vL+aiGo5VNKafE+XpRNSwNeTVzXOgfj3iYgB47+I8iMb9afy
         rNfiMlztnGDoTtS/m7PrR0QLfttdYcbtmboJpZhM=
Date:   Tue, 30 Jul 2019 18:22:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v2] RDMA/restrack: Track driver QP types in
 resource tracker
Message-ID: <20190730152216.GF4878@mtr-leonro.mtl.com>
References: <20190730133720.62548-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730133720.62548-1-galpress@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 04:37:20PM +0300, Gal Pressman wrote:
> The check for QP type different than XRC has wrongly excluded driver QP
> types from the resource tracker.
> As a result, "rdma resource show" user command would not show opened
> driver QPs which does not reflect the real state of the system.
>
> Check QP type explicitly instead of improperly assuming enum
> values/ordering.
>
> Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create and destroy QPs")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> v2:
> * Improve commit message

Please finish review of v0 and give enough time for reviewers to see
patch and post their notes before resending.

Thanks
