Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497AA1B2ECD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDUSLn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 14:11:43 -0400
Received: from verein.lst.de ([213.95.11.211]:48198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUSLn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 14:11:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4BE2D68C4E; Tue, 21 Apr 2020 20:11:40 +0200 (CEST)
Date:   Tue, 21 Apr 2020 20:11:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>,
        axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
        martin.petersen@oracle.com, shlomin@mellanox.com,
        linux-rdma@vger.kernel.org, israelr@mellanox.com,
        vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
        idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
        kbusch@kernel.org
Subject: Re: [PATCH 01/17] nvme: introduce namespace features flag
Message-ID: <20200421181140.GB21283@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com> <20200327171545.98970-3-maxg@mellanox.com> <20200421115912.GB26432@lst.de> <1ffeee50-9c96-495f-b82b-bf3873e95183@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ffeee50-9c96-495f-b82b-bf3873e95183@broadcom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 21, 2020 at 08:53:18AM -0700, James Smart wrote:
> Care to look at any of the RFC items I posted on 2/24 - which does things a 
> little differently ?   Perhaps find a common ground with Max's patches.
> http://lists.infradead.org/pipermail/linux-nvme/2020-February/029066.html
>
> Granted I've tweaked what I sent a little as there was no need to make 
> nvme_ns_has_pi accessible to the transport.

I've replied to the series.
