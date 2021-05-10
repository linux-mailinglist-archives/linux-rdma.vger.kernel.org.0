Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE9377CB8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhEJHBT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 03:01:19 -0400
Received: from verein.lst.de ([213.95.11.211]:57323 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhEJHBP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 03:01:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE55C67373; Mon, 10 May 2021 09:00:08 +0200 (CEST)
Date:   Mon, 10 May 2021 09:00:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, hch@lst.de,
        sagi@grimberg.me, yaminf@mellanox.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Shai Malin <smalin@marvell.com>
Subject: Re: [PATCH] nvmet-rdma: Fix NULL deref when SEND is completed with
 error
Message-ID: <20210510070007.GB30907@lst.de>
References: <20210506070819.12502-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506070819.12502-1-michal.kalderon@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks,

applied to nvme-5.13.
