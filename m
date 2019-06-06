Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2536CCE
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfFFHEb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 03:04:31 -0400
Received: from verein.lst.de ([213.95.11.211]:47589 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFHEa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 03:04:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DC19968B20; Thu,  6 Jun 2019 09:04:03 +0200 (CEST)
Date:   Thu, 6 Jun 2019 09:04:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] IB/iser: explicitly set shost max_segment_size
Message-ID: <20190606070403.GA27627@lst.de>
References: <20190606000209.26086-1-sagi@grimberg.me> <20190606063600.GB27033@lst.de> <ae65c220-193c-e526-57da-17b50820b015@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae65c220-193c-e526-57da-17b50820b015@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 11:47:23PM -0700, Sagi Grimberg wrote:
> Not sure I understand.
>
> max_segment_size and virt_boundary_mask are related how?

virt_boundary_devices has hardware segment size of a single page (device
page as identified by the boundary, not necessarily linux PAGE_SIZE).
So we don't need a max_segment_size in the Linux size, as any amount of
hardware segments fitting the virt boundary can be merged into a 'Linux
segment'.  Because of the accouting for the merges is hard and was
partially broken anyway we've now dropped the accounting and force the
max_segment_size to be unlimited in the block layer if a device sets
the virt_boundary_mask.
