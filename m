Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD9188EFF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 21:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQUcV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 16:32:21 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:14596 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUcV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Mar 2020 16:32:21 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02HKVvAw008625;
        Tue, 17 Mar 2020 13:31:58 -0700
Date:   Wed, 18 Mar 2020 02:01:57 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
Message-ID: <20200317203152.GA14946@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com>
 <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
 <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, March 03/17/20, 2020 at 12:33:44 -0700, Sagi Grimberg wrote:
> 
> >>>>>For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
> >>>>that
> >>>>>is a good idea as pretty much all RDMA block drivers rely on the
> >>>>>DMA behavior above.  The answer is to bounce buffer the data in
> >>>>>SoftiWARP / SoftRoCE.
> >>>>
> >>>>We already do, see nvme_alloc_ns.
> >>>>
> >>>>
> >>>
> >>>Krishna was getting the issue when testing TCP/NVMeF with -G
> >>>during connect. That enables data digest and STABLE_WRITES
> >>>I think. So to me it seems we don't get stable pages, but
> >>>pages which are touched after handover to the provider.
> >>
> >>Non of the transports modifies the data at any point, both will
> >>scan it to compute crc. So surely this is coming from the fs,
> >>Krishna does this happen with xfs as well?
> >Yes, but rare(took ~15min to recreate), whereas with ext3/4
> >its almost immediate. Here is the error log for NVMe/TCP with xfs.
> 
> Thanks Krishna,
> 
> I assume that this makes the issue go away?
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 11e10fe1760f..cc93e1949b2c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -889,7 +889,7 @@ static int nvme_tcp_try_send_data(struct
> nvme_tcp_request *req)
>                         flags |= MSG_MORE;
> 
>                 /* can't zcopy slab pages */
> -               if (unlikely(PageSlab(page))) {
> +               if (unlikely(PageSlab(page)) || queue->data_digest) {
>                         ret = sock_no_sendpage(queue->sock, page,
> offset, len,
>                                         flags);
>                 } else {
> --

Unfortunately, issue is still occuring with this patch also.

Looks like the integrity of the data buffer right after the CRC
computation(data digest) is what causing this issue, despite the
buffer being sent via sendpage or no_sendpage.

Thanks,
Krishna.
