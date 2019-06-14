Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED44E4591A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 11:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFNJpo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 05:45:44 -0400
Received: from verein.lst.de ([213.95.11.211]:45558 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfFNJpo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 05:45:44 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 123F6227A82; Fri, 14 Jun 2019 11:45:16 +0200 (CEST)
Date:   Fri, 14 Jun 2019 11:45:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 15/21] RDMA/core: Validate integrity handover device cap
Message-ID: <20190614094515.GE17292@lst.de>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com> <1560268377-26560-16-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560268377-26560-16-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 06:52:51PM +0300, Max Gurtovoy wrote:
> Protect the case that a ULP tries to allocate a QP with signature
> enabled flag while the LLD doesn't support this feature.
> While we're here, also move integrity_en attribute from mlx5_qp to
> ib_qp as a preparation for adding new integrity API to the rw-API
> (that is part of ib_core module).
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
