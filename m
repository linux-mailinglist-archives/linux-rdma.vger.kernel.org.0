Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01F117A25
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfEHNOy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:14:54 -0400
Received: from verein.lst.de ([213.95.11.211]:39632 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfEHNOy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 09:14:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CA38E67358; Wed,  8 May 2019 15:14:35 +0200 (CEST)
Date:   Wed, 8 May 2019 15:14:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 24/25] RDMA/rw: Add info regarding SG count failure
Message-ID: <20190508131435.GF27010@lst.de>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com> <1557236319-9986-25-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557236319-9986-25-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 04:38:38PM +0300, Max Gurtovoy wrote:
> Print the supported and wanted values for SG count during signature
> operation.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
