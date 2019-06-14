Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6997945915
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfFNJoz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 05:44:55 -0400
Received: from verein.lst.de ([213.95.11.211]:45549 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfFNJoz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 05:44:55 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0594D227A82; Fri, 14 Jun 2019 11:44:26 +0200 (CEST)
Date:   Fri, 14 Jun 2019 11:44:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 07/21] RDMA/mlx5: Add attr for max number page list
 length for PI operation
Message-ID: <20190614094425.GC17292@lst.de>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com> <1560268377-26560-8-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560268377-26560-8-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 06:52:43PM +0300, Max Gurtovoy wrote:
> PI offload (protection information) is a feature that each RDMA provider
> can implement differently. Thus, introduce new device attribute to define
> the maximal length of the page list for PI fast registration operation. For
> example, mlx5 driver uses a single internal MR to map both data and
> protection SGL's, so it's equal to max_fast_reg_page_list_len / 2.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
