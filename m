Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436C217A24
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfEHNO0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:14:26 -0400
Received: from verein.lst.de ([213.95.11.211]:39627 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbfEHNO0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 09:14:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 25E4A67358; Wed,  8 May 2019 15:14:08 +0200 (CEST)
Date:   Wed, 8 May 2019 15:14:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 23/25] RDMA/mlx5: Improve PI handover performance
Message-ID: <20190508131407.GE27010@lst.de>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com> <1557236319-9986-24-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557236319-9986-24-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 04:38:37PM +0300, Max Gurtovoy wrote:
> Performance results running fio (24 jobs, 128 iodepth) using
> write_generate=1 and read_verify=1 (w/w.o patch):
> 
> bs      IOPS(read)        IOPS(write)
> ----    ----------        ----------
> 512   1262.4K/1243.3K    1732.1K/1725.1K
> 4k    570902/571233      773982/743293
> 32k   72086/72388        96164/71789
> 
> Using write_generate=0 and read_verify=0 (w/w.o patch):
> bs      IOPS(read)        IOPS(write)
> ----    ----------        ----------
> 512   1600.1K/1572.1K    1830.3K/1823.5K
> 4k    937272/921992      815304/753772
> 32k   77369/75052        97435/73180

This seems to roughtly get us back to the previous performance levels.
Maybe it would be better to compare against the baseline without the
whole series?
