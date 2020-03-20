Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701AB18D103
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCTOgA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 10:36:00 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:3720 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCTOf7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 10:35:59 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02KEZljh018015;
        Fri, 20 Mar 2020 07:35:48 -0700
Date:   Fri, 20 Mar 2020 20:05:47 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
Message-ID: <20200320143544.GA5539@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com>
 <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
 <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
 <20200317203152.GA14946@chelsio.com>
 <3f42f881-0309-b86a-4b70-af23c58960fc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f42f881-0309-b86a-4b70-af23c58960fc@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wednesday, March 03/18/20, 2020 at 09:49:07 -0700, Sagi Grimberg wrote:
> 
> >>Thanks Krishna,
> >>
> >>I assume that this makes the issue go away?
> >>--
> >>diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> >>index 11e10fe1760f..cc93e1949b2c 100644
> >>--- a/drivers/nvme/host/tcp.c
> >>+++ b/drivers/nvme/host/tcp.c
> >>@@ -889,7 +889,7 @@ static int nvme_tcp_try_send_data(struct
> >>nvme_tcp_request *req)
> >>                         flags |= MSG_MORE;
> >>
> >>                 /* can't zcopy slab pages */
> >>-               if (unlikely(PageSlab(page))) {
> >>+               if (unlikely(PageSlab(page)) || queue->data_digest) {
> >>                         ret = sock_no_sendpage(queue->sock, page,
> >>offset, len,
> >>                                         flags);
> >>                 } else {
> >>--
> >
> >Unfortunately, issue is still occuring with this patch also.
> >
> >Looks like the integrity of the data buffer right after the CRC
> >computation(data digest) is what causing this issue, despite the
> >buffer being sent via sendpage or no_sendpage.
> 
> I assume this happens with iSCSI as well? There is nothing special
> we are doing with respect to digest.

I don't see this issue with iscsi-tcp.

May be blk-mq is causing this issue? I assume iscsi-tcp does not have
blk_mq support yet upstream to verify with blk_mq enabled.
I tried on Ubuntu 19.10(which is based on Linux kernel 5.3), note that
RHEL does not support DataDigest.

The reason that I'm seeing this issue only with NVMe(tcp/softiwarp) &
iSER(softiwarp) is becuase of NVMeF&ISER using blk-mq? 

Anyhow, I see the content of the page is being updated by upper layers
while the tranport driver is computing CRC on that page content and
this needs a fix.

one could very easily recreate this issue running the below simple program over
NVMe/TCP.
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main() {
	int i;
	char* line1 = "123";
	FILE* fp;
	while(1) {
		fp = fopen("/mnt/tmp.txt", "w");
		setvbuf(fp, NULL, _IONBF, 0);
		for (i=0; i<100000; i++)
		     if ((fwrite(line1, 1, strlen(line1), fp) !=
strlen(line1)))
			exit(1);

		if (fclose(fp) != 0)
			exit(1);
	}
return 0;
}
