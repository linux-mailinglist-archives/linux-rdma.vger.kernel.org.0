Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F225C5D5
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgICPz7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 11:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgICPzz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 11:55:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7114820639;
        Thu,  3 Sep 2020 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599148555;
        bh=FHALxW756C48xQGSGjeLpDkO9PfNrHnFzQ23hqC9M4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1j5nDL/1AszZbJmEh1G+Dsrd1QW6JRAoVJA9yRSMS0FiKMlzJ84j+wB61jitlc3j4
         WbfmXK+md7LQKinPldN/sVKlg3HryuFPEWNyRuRcRsmNXNS56H6+aT/04o+7sPFu5D
         mfbWr8xijZgCZg/b+balfcp1OlPAllXbvzA/AcYY=
Date:   Thu, 3 Sep 2020 18:55:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next 0/4] scatterlist: add sg_alloc_table_append
 function
Message-ID: <20200903155551.GC1137836@unreal>
References: <20200903121853.1145976-1-leon@kernel.org>
 <20200903153217.GA21689@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903153217.GA21689@lst.de>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 05:32:17PM +0200, Christoph Hellwig wrote:
> Patch 1 never made it through.

Thanks, I sent it now and the patch is seen in ML.

https://lore.kernel.org/linux-rdma/20200903153217.GA21689@lst.de/T/#t
