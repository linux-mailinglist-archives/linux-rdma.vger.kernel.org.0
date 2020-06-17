Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9B1FC8A4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQIbn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 04:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQIbm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 04:31:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D660D206E2;
        Wed, 17 Jun 2020 08:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592382702;
        bh=Pw0FsBGDI6P7jETFMixgA1q5oMVhz0zOWwQ5JoBouuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaUd0vYKATnTogVMM1OfZGQBPhNkZ2j2sHfYtWUJ1LDZh63s921KPtQ8J2R6538UX
         uFU36SxS7m56Qq8Lh3/OjXs7N7Bcg/uRfs6iz2exNVFDDjt13vGg/7hWKwXe52ubZ2
         noTc51cawWGtINcMyQKFPwUQx8z/4Fu3EIAtPcsA=
Date:   Wed, 17 Jun 2020 11:31:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 0/7] Introduce KABIs to query UCONTEXT, PD and
 MR properties
Message-ID: <20200617083138.GI2383158@unreal>
References: <20200616105531.2428010-1-leon@kernel.org>
 <20200617082916.GA13188@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617082916.GA13188@infradead.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 01:29:16AM -0700, Christoph Hellwig wrote:
> I think you are talking about UABIs (which in linux we actually call
> uapis).

Yes, I used Yishai's cover letter as is.

>
