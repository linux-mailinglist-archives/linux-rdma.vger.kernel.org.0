Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BABE3A25B5
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 09:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFJHqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 03:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJHqy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 03:46:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1269F61285;
        Thu, 10 Jun 2021 07:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623311098;
        bh=uVaVAXezmcKR672TdMVYwDUSC9AEQ2C0Kp/upa9s9Tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zuh7wUq3K25jW9uvEs7TexQSpUpd5koG1M3KhyuPJYYSyxAkeA3I9hbWcPARiI2tf
         IEFvzSoWZhb+BJf8tHgB3/sDmDDXSDZ6om1fsqjG1T8eXEn/370DmQT0/W1X2jNIp6
         2qxE/33IrfPTTwqTb/qAkD/+oO49wj/ZtX08nvv+f7ouHERNgVY53H5aSuAnq3d+PO
         hUH/2Xp2eN3vPLKbbNoG9NHVtdNmG6RaSSfPHIDEXrJzeXImHpFP+CVzsccBTE0lFn
         m6FmLcLWYhI6t33mSM1f0zAQUanzjBgjInxu1p5nmcbjFZ5A3DjraYv6x3eZTCOvaG
         1ASjecj0+rTzQ==
Date:   Thu, 10 Jun 2021 10:44:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <YMHC93U12rgLlQCx@unreal>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210609125241.GA1347@lst.de>
 <YMDH05/yTtSIk9kI@unreal>
 <20210609135924.GA6510@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609135924.GA6510@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 03:59:24PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 09, 2021 at 04:53:23PM +0300, Leon Romanovsky wrote:
> > Sure, did you have in mind some concrete place? Or will new file in the
> > Documentation/infiniband/ folder be good enough too?
> 
> Maybe add a kerneldoc comment for the map_mr_sg() ib_device_ops method?

I hope that this hunk from the previous cover letter is good enough.

Jason, do you want v3? or you can fold this into v2?

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9423e70a881c..aaf63a6643d6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2468,6 +2468,13 @@ struct ib_device_ops {
                         enum ib_uverbs_advise_mr_advice advice, u32 flags,
                         struct ib_sge *sg_list, u32 num_sge,
                         struct uverbs_attr_bundle *attrs);
+       /*
+        * Kernel users should universally support relaxed ordering (RO),
+        * as they are designed to read data only after observing the CQE
+        * and use the DMA API correctly.
+        *
+        * Some drivers implicitly enable RO if platform supports it.
+        */
        int (*map_mr_sg)(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
                         unsigned int *sg_offset);
        int (*check_mr_status)(struct ib_mr *mr, u32 check_mask,

