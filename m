Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D83017227B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgB0Pqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 10:46:46 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:53289 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgB0Pqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Feb 2020 10:46:46 -0500
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01RFkMbE028085;
        Thu, 27 Feb 2020 07:46:22 -0800
Date:   Thu, 27 Feb 2020 21:16:21 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>, jgg@ziepe.ca
Cc:     linux-nvme@lists.infradead.org, hch@lst.de,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
Message-ID: <20200227154220.GA3153@chelsio.com>
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi & Jason,
	
Thanks for the comments, please see inline.

On Wednesday, February 02/26/20, 2020 at 15:05:59 -0800, Sagi Grimberg wrote:
> 
> >Current nvmet-rdma code allocates MR pool budget based on host's SQ
> >size, assuming both host and target use the same "max_pages_per_mr"
> >count. But if host's max_pages_per_mr is greater than target's, then
> >target can run out of MRs while processing larger IO WRITEs.
> >
> >That is, say host's SQ size is 100, then the MR pool budget allocated
> >currently at target will also be 100 MRs. But 100 IO WRITE Requests
> >with 256 sg_count(IO size above 1MB) require 200 MRs when target's
> >"max_pages_per_mr" is 128.
> 
> The patch doesn't say if this is an actual bug you are seeing or
> theoretical.
	
I've noticed this issue while running the below fio command:
fio --rw=randwrite --name=random --norandommap --ioengine=libaio
--size=16m --group_reporting --exitall --fsync_on_close=1 --invalidate=1
--direct=1 --filename=/dev/nvme2n1 --iodepth=32 --numjobs=16
--unit_base=1 --bs=4m --kb_base=1000

Note: here NVMe Host is on SIW & Target is on iw_cxgb4 and the
max_pages_per_mr supported by SIW and iw_cxgb4 are 255 and 128
respectively.
	
Traces on Target:

#cat /sys/kernel/debug/tracing/trace_pipe|grep -v "status=0x0"
kworker/8:1H-2461  [008] .... 25476.995437: nvmet_req_complete: nvmet1:
disk=/dev/ram0, qid=1, cmdid=3, res=0xffff8b7f2ae534d0, status=0x6
kworker/8:1H-2461  [008] .... 25476.995467: nvmet_req_complete: nvmet1:
disk=/dev/ram0, qid=1, cmdid=4, res=0xffff8b7f2ae53700, status=0x6
kworker/8:1H-2461  [008] .... 25476.995511: nvmet_req_complete: nvmet1:
disk=/dev/ram0, qid=1, cmdid=1, res=0xffff8b7f2ae53980, status=0x6

> 
> >The proposed patch enables host to advertise the max_fr_pages(via
> >nvme_rdma_cm_req) such that target can allocate that many number of
> >RW ctxs(if host's max_fr_pages is higher than target's).
> 
> As mentioned by Jason, this s a non-compatible change, if you want to
> introduce this you need to go through the standard and update the
> cm private_data layout (would mean that the fmt needs to increment as
> well to be backward compatible).

Sure, will initiate a discussion at NVMe TWG about CM private_data format.
Will update the response soon.
> 
> 
> As a stop-gap, nvmet needs to limit the controller mdts to how much
> it can allocate based on the HCA capabilities
> (max_fast_reg_page_list_len).
