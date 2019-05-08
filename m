Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14817A31
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfEHNR1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:17:27 -0400
Received: from verein.lst.de ([213.95.11.211]:39651 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfEHNR1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 09:17:27 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E8D6568B20; Wed,  8 May 2019 15:17:07 +0200 (CEST)
Date:   Wed, 8 May 2019 15:17:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 25/25] RDMA/mlx5: Use PA mapping for PI handover
Message-ID: <20190508131707.GG27010@lst.de>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com> <1557236319-9986-26-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557236319-9986-26-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 04:38:39PM +0300, Max Gurtovoy wrote:
> Performance results running fio (24 jobs, 128 iodepth) using
> write_generate=1 and read_verify=1 (w/w.o patch):
> 
> bs      IOPS(read)        IOPS(write)
> ----    ----------        ----------
> 512   1266.4K/1262.4K    1720.1K/1732.1K
> 4k    793139/570902      1129.6K/773982
> 32k   72660/72086        97229/96164
> 
> Using write_generate=0 and read_verify=0 (w/w.o patch):
> bs      IOPS(read)        IOPS(write)
> ----    ----------        ----------
> 512   1590.2K/1600.1K    1828.2K/1830.3K
> 4k    1078.1K/937272     1142.1K/815304
> 32k   77012/77369        98125/97435

So this makes almost no difference for 512byte or 32k block sizes,
but a huge difference for 4k, which seems a little odd.  Do you have
a good explanation for that?

>  			case IB_WR_REG_MR_INTEGRITY:
> -				memset(&reg_pi_wr, 0, sizeof(struct ib_reg_wr));

Btw, I think the driver would really benefit from eventually splitting
out each case in this huge switch statement into a helper.  Everytime
I had to stare at it it took me forever to understand it.
