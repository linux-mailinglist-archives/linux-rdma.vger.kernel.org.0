Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABA617547A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 08:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCBHdW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 02:33:22 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:54559 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHdV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 02:33:21 -0500
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0227WgY0012818;
        Sun, 1 Mar 2020 23:32:42 -0800
Date:   Mon, 2 Mar 2020 13:02:41 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Max Gurtovoy <maxg@mellanox.com>, sagi@grimberg.me
Cc:     Sagi Grimberg <sagi@grimberg.me>, jgg@ziepe.ca,
        linux-nvme@lists.infradead.org, hch@lst.de,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
Message-ID: <20200302073240.GA14097@chelsio.com>
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
 <20200227154220.GA3153@chelsio.com>
 <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
 <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Sagi & Max Gurtovoy,

Thanks for your pointers regarding mdts.

Looks like fixing this issue through mdts is more natural than fixing
through RDMA private data.

Issue is not occuring after appling the below patch(inspired by Max's
patch "nvmet-rdma: Implement set_mdts controller op").

So any consensus about merging the fix upstream, to fix this specific
issue?

diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index 56c21b50..0d468ab 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -346,8 +346,12 @@ static void nvmet_execute_identify_ctrl(struct
nvmet_req *req)
        /* we support multiple ports, multiples hosts and ANA: */
        id->cmic = (1 << 0) | (1 << 1) | (1 << 3);

-       /* no limit on data transfer sizes for now */
-       id->mdts = 0;
+       /* Limit MDTS according to transport capability */
+       if (ctrl->ops->set_mdts)
+               id->mdts = ctrl->ops->set_mdts(ctrl);
+       else
+               id->mdts = 0;
+
        id->cntlid = cpu_to_le16(ctrl->cntlid);
        id->ver = cpu_to_le32(ctrl->subsys->ver);

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e..851f8ed 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -279,6 +279,7 @@ struct nvmet_fabrics_ops {
                        struct nvmet_port *port, char *traddr);
        u16 (*install_queue)(struct nvmet_sq *nvme_sq);
        void (*discovery_chg)(struct nvmet_port *port);
+       u8 (*set_mdts)(struct nvmet_ctrl *ctrl);
 };

 #define NVMET_MAX_INLINE_BIOVEC        8
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a..62363be 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1602,6 +1602,17 @@ static void nvmet_rdma_disc_port_addr(struct
nvmet_req *req,
        }
 }

+static u8 nvmet_rdma_set_mdts(struct nvmet_ctrl *ctrl)
+{
+       struct nvmet_port *port = ctrl->port;
+       struct rdma_cm_id *cm_id = port->priv;
+       u32 max_pages;
+
+       max_pages = cm_id->device->attrs.max_fast_reg_page_list_len;
+       /* Assume mpsmin == device_page_size == 4KB */
+       return ilog2(max_pages);
+}
+
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
        .owner                  = THIS_MODULE,
        .type                   = NVMF_TRTYPE_RDMA,
@@ -1612,6 +1623,7 @@ static void nvmet_rdma_disc_port_addr(struct
nvmet_req *req,
        .queue_response         = nvmet_rdma_queue_response,
        .delete_ctrl            = nvmet_rdma_delete_ctrl,
        .disc_traddr            = nvmet_rdma_disc_port_addr,
+       .set_mdts               = nvmet_rdma_set_mdts,
 };

 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void
*client_data)


Thanks,
Krishna.

On Sunday, March 03/01/20, 2020 at 16:05:53 +0200, Max Gurtovoy wrote:
> 
> On 2/28/2020 1:14 AM, Sagi Grimberg wrote:
> >
> >>>The patch doesn't say if this is an actual bug you are seeing or
> >>>theoretical.
> >>
> >>I've noticed this issue while running the below fio command:
> >>fio --rw=randwrite --name=random --norandommap --ioengine=libaio
> >>--size=16m --group_reporting --exitall --fsync_on_close=1 --invalidate=1
> >>--direct=1 --filename=/dev/nvme2n1 --iodepth=32 --numjobs=16
> >>--unit_base=1 --bs=4m --kb_base=1000
> >>
> >>Note: here NVMe Host is on SIW & Target is on iw_cxgb4 and the
> >>max_pages_per_mr supported by SIW and iw_cxgb4 are 255 and 128
> >>respectively.
> >
> >This needs to be documented in the change log.
> >
> >>>>The proposed patch enables host to advertise the max_fr_pages(via
> >>>>nvme_rdma_cm_req) such that target can allocate that many number of
> >>>>RW ctxs(if host's max_fr_pages is higher than target's).
> >>>
> >>>As mentioned by Jason, this s a non-compatible change, if you want to
> >>>introduce this you need to go through the standard and update the
> >>>cm private_data layout (would mean that the fmt needs to increment as
> >>>well to be backward compatible).
> >>
> >>Sure, will initiate a discussion at NVMe TWG about CM
> >>private_data format.
> >>Will update the response soon.
> >>>
> >>>
> >>>As a stop-gap, nvmet needs to limit the controller mdts to how much
> >>>it can allocate based on the HCA capabilities
> >>>(max_fast_reg_page_list_len).
> >
> >Sounds good, please look at capping mdts in the mean time.
> 
> guys, see my patches from adding MD support.
> 
> I'm setting mdts per ctrl there.
> 
> we can merge it meantime for this issue.
> 
> 
