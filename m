Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCF17A1E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfEHNNU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:13:20 -0400
Received: from verein.lst.de ([213.95.11.211]:39622 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbfEHNNT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 09:13:19 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A2B3E67358; Wed,  8 May 2019 15:13:00 +0200 (CEST)
Date:   Wed, 8 May 2019 15:13:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 21/25] RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI
 handover
Message-ID: <20190508131300.GD27010@lst.de>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com> <1557236319-9986-22-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557236319-9986-22-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> There is a performance degradation when writing big block sizes.
> Degradation is caused by the complexity of combining multiple
> indirections and perform RDMA READ operation from it. This will be
> fixed in the following patches by reducing the indirections if
> possible.

It would be good to figure out if it is posisble, as the regressions
are pretty significant.
