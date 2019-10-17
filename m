Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE06DA76B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 10:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391461AbfJQI3V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 04:29:21 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:14432 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbfJQI3V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Oct 2019 04:29:21 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x9H8TG9X010091;
        Thu, 17 Oct 2019 01:29:16 -0700
Date:   Thu, 17 Oct 2019 13:59:15 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Message-ID: <20191017082914.GA31610@chelsio.com>
References: <20190930074252.20133-1-bharat@chelsio.com>
 <20191004181154.GA20868@ziepe.ca>
 <D4D8B4CD-CDA7-4587-BA10-E41A2DE89978@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4D8B4CD-CDA7-4587-BA10-E41A2DE89978@vmware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thursday, October 10/17/19, 2019 at 12:11:16 +0530, Adit Ranadive wrote:
> On 10/4/19, 11:12 AM, "Jason Gunthorpe" <jgg@ziepe.ca> wrote:
> > 
> > On Mon, Sep 30, 2019 at 01:12:52PM +0530, Potnuri Bharat Teja wrote:
> > > remove iw_cxgb3 module from kernel as the corresponding HW Chelsio T3 has
> > > reached EOL.
> > > 
> > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > 
> > Applied to for-next
> > 
> > Please also send a PR to delete cxgb3 from rdma-core
> > 
> 
> Is Chelsio going to send a PR for the deletion? It looks like otherwise
> rdma-core is broken for other providers when running with the for-next branch.
Hi All,
My bad I couldnt check for this failure during my tests before submitting 
upstream. Shall send a PR for deleting cxgb3 from rdma-core this week.

-Bharat.
> 
> Also, it looks like the kernel-headers/update script in rdma-core needs to be
> updated to remove a header if required from the rdma_kernel_provider_abi
> section. Or is that expected to be manual?
> 
