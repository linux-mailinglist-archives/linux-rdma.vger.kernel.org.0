Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAC4455B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 18:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392796AbfFMQng (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 12:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbfFMGdU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 02:33:20 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394962084D;
        Thu, 13 Jun 2019 06:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560407599;
        bh=lBafE/WUiaQP+p4uGlW9CCyAoC1xD93nsWP7lin/vlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=16ot2Qa2RWd59Su8TV7ClZFaz73CEcH+Bp4B3Zkpn4InH4AOjCuEAPk7y1MnM3fBi
         ptNstOMqp+8wqYOP6km14Pq1MCoxuleGbidd/EnRwNaotE7z0bHrlZaGSi0R0j/Gec
         joFk81/MenfLTVxp4j4Za01dkKrIAUTNRPEinT7w=
Date:   Thu, 13 Jun 2019 09:33:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_set_user_sq_size()
Message-ID: <20190613063316.GW6369@mtr-leonro.mtl.com>
References: <20190608092714.GE28890@mwanda>
 <20190612172316.GU6369@mtr-leonro.mtl.com>
 <20190613060517.GF1915@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613060517.GF1915@kadam>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 11:05:17PM -0700, Dan Carpenter wrote:
> On Wed, Jun 12, 2019 at 08:23:16PM +0300, Leon Romanovsky wrote:
> > On Sat, Jun 08, 2019 at 12:27:14PM +0300, Dan Carpenter wrote:
> > > This function is supposed to return negative kernel error codes but here
> > > it returns CMD_RST_PRC_EBUSY (2).  The error code eventually gets passed
> > > to IS_ERR() and since it's not an error pointer it leads to an Oops in
> > > hns_roce_v1_rsv_lp_qp()
> > >
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > Static analysis.  Not tested.
> > >
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > index ac017c24b200..018ff302ab9e 100644
> > > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > @@ -1098,7 +1098,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
> > >  	if (ret == CMD_RST_PRC_SUCCESS)
> > >  		return 0;
> > >  	if (ret == CMD_RST_PRC_EBUSY)
> >
> > The better fix will be to remove CMD_RST_PRC_* definitions in favor of
> > normal errno.
> >
>
> Yes.
>
> I've looked at that idea and I would almost feel like it's easy enough
> to send a patch like that without testing it at all.  But it would be
> better if the people with the hardware sent it.  I reported this bug
> months ago...

Feel free to send, we will give time to respond.

thanks

>
> regards,
> dan carpenter
