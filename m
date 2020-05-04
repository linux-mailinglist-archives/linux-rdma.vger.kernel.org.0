Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91131C37B9
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgEDLJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 07:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgEDLJe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 May 2020 07:09:34 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F1020735;
        Mon,  4 May 2020 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588590573;
        bh=awsPAXx/sEBihhuDo3iyrTx3W/NWCal5Y1iwgMjVhbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G88n0Z10uAfy3Tds0HF6n1zTkZi2LqPCvTjtOY0v74W6eVz/uY42lxQVFijWZmm+b
         4lZdddMPl38Et0G5yCenymfIeC9q8k+oOaxNZH+WXh0BmAQXxO3x6A2kCKu3VoxA3T
         ceFrYvTe5GhxnKHfr8y5XhSSS0puQfFrVRxQTYRQ=
Date:   Mon, 4 May 2020 14:09:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/ucma: Return stable IB device index as
 identifier
Message-ID: <20200504110929.GD111287@unreal>
References: <20200430152939.77967-1-leon@kernel.org>
 <694f5565-acdd-0863-092c-b78409f1b9c3@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694f5565-acdd-0863-092c-b78409f1b9c3@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 04, 2020 at 02:01:23PM +0300, Gal Pressman wrote:
> On 30/04/2020 18:29, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The librdmacm uses node_guid as identifier to correlate between
> > IB devices and CMA devices. However FW resets cause to such
> > "connection" to be lost and require from the user to restart
> > its application.
> >
> > Extend UCMA to return IB device index, which is stable identifier.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> > diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
> > index e545f2de1e13..14d48b462d91 100644
> > --- a/include/uapi/rdma/rdma_user_cm.h
> > +++ b/include/uapi/rdma/rdma_user_cm.h
> > @@ -168,6 +168,7 @@ struct rdma_ucm_query_route_resp {
> >  	__u32 num_paths;
> >  	__u8 port_num;
> >  	__u8 reserved[3];
> > +	__u32 ibdev_index;
> >  };
> >
> >  struct rdma_ucm_query_addr_resp {
> > @@ -179,6 +180,7 @@ struct rdma_ucm_query_addr_resp {
> >  	__u16 dst_size;
> >  	struct __kernel_sockaddr_storage src_addr;
> >  	struct __kernel_sockaddr_storage dst_addr;
> > +	__u32 ibdev_index;
> >  };
>
> Should both these structs size be aligned to 8 bytes?

Are you asking about 8 bytes or 64 bytes?
Because u32 is aligned to 8 bytes.

Thanks
