Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09F3188DDE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQTUj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:20:39 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:24632 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCQTUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 15:20:39 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02HJHjfG008485;
        Tue, 17 Mar 2020 12:17:46 -0700
Date:   Wed, 18 Mar 2020 00:47:44 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
Message-ID: <20200317191743.GA22065@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com>
 <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, March 03/17/20, 2020 at 09:39:39 -0700, Sagi Grimberg wrote:
> 
> >>>For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
> >>that
> >>>is a good idea as pretty much all RDMA block drivers rely on the
> >>>DMA behavior above.  The answer is to bounce buffer the data in
> >>>SoftiWARP / SoftRoCE.
> >>
> >>We already do, see nvme_alloc_ns.
> >>
> >>
> >
> >Krishna was getting the issue when testing TCP/NVMeF with -G
> >during connect. That enables data digest and STABLE_WRITES
> >I think. So to me it seems we don't get stable pages, but
> >pages which are touched after handover to the provider.
> 
> Non of the transports modifies the data at any point, both will
> scan it to compute crc. So surely this is coming from the fs,
> Krishna does this happen with xfs as well?
Yes, but rare(took ~15min to recreate), whereas with ext3/4
its almost immediate. Here is the error log for NVMe/TCP with xfs.

dmesg at Host:
[  +0.000323] nvme nvme2: creating 12 I/O queues.
[  +0.008991] nvme nvme2: Successfully reconnected (1 attempt)
[ +25.277733] blk_update_request: I/O error, dev nvme2n1, sector 0 op
0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0
[  +6.043879] XFS (nvme2n1): Mounting V5 Filesystem
[  +0.017745] XFS (nvme2n1): Ending clean mount
[  +0.000174] xfs filesystem being mounted at /mnt supports timestamps
until 2038 (0x7fffffff)
[Mar18 00:14] nvme nvme2: Reconnecting in 10 seconds...
[  +0.000453] nvme nvme2: creating 12 I/O queues.
[  +0.009216] nvme nvme2: Successfully reconnected (1 attempt)
[Mar18 00:43] nvme nvme2: Reconnecting in 10 seconds...
[  +0.000383] nvme nvme2: creating 12 I/O queues.
[  +0.009239] nvme nvme2: Successfully reconnected (1 attempt)


dmesg at Target:
[Mar18 00:14] nvmet_tcp: queue 9: cmd 17 pdu (4) data digest error: recv
0x8e85d882 expected 0x9a46fac3
[  +0.000011] nvmet: ctrl 1 fatal error occurred!
[ +10.240266] nvmet: creating controller 1 for subsystem nvme-ram0 for
NQN nqn.2014-08.org.nvmexpress.chelsio.
[Mar18 00:42] nvmet_tcp: queue 7: cmd 89 pdu (4) data digest error: recv
0xc0ce3dfd expected 0x7ee136b5
[  +0.000012] nvmet: ctrl 1 fatal error occurred!
[Mar18 00:43] nvmet: creating controller 1 for subsystem nvme-ram0 for
NQN nqn.2014-08.org.nvmexpress.chelsio.

