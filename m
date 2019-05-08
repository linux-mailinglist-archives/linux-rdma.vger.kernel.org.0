Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B53179FA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfEHNKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:10:51 -0400
Received: from verein.lst.de ([213.95.11.211]:39604 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHNKv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 09:10:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CEE3D67358; Wed,  8 May 2019 15:10:32 +0200 (CEST)
Date:   Wed, 8 May 2019 15:10:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 20/25] RDMA/rw: Print the correct number of sig MRs
Message-ID: <20190508131032.GC27010@lst.de>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com> <1557236319-9986-21-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557236319-9986-21-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 04:38:34PM +0300, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> A wrong value was printed in case of sig MR pool initialization failure.
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
