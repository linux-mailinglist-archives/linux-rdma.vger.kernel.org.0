Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A2C0A2D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfI0RSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 13:18:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfI0RSS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Sep 2019 13:18:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAA7330089A1;
        Fri, 27 Sep 2019 17:18:17 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4901561B63;
        Fri, 27 Sep 2019 17:18:17 +0000 (UTC)
Date:   Sat, 28 Sep 2019 01:18:14 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [patch v3 2/2] RDMA/srp: calculate max_it_iu_size if remote
 max_it_iu length available
Message-ID: <20190927171814.GA13717@dhcp-128-227.nay.redhat.com>
References: <20190919035032.31373-1-honli@redhat.com>
 <20190919035032.31373-2-honli@redhat.com>
 <c0ab625a-d029-37b4-753f-312e7877a6fc@acm.org>
 <20190923033339.GB8298@dhcp-128-227.nay.redhat.com>
 <0f2331d1-6a4a-6c30-6e53-9662c2a59708@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f2331d1-6a4a-6c30-6e53-9662c2a59708@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 27 Sep 2019 17:18:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 08:10:48AM -0700, Bart Van Assche wrote:
> On 9/22/19 8:33 PM, Honggang LI wrote:
> > On Fri, Sep 20, 2019 at 09:18:49AM -0700, Bart Van Assche wrote:
> > > On 9/18/19 8:50 PM, Honggang LI wrote:
> > > > The maximum initiator to target iu length can be get from the subnet
> > >                                                     ^^^
> > >                                           retrieved? obtained?
> > 
> > OK, will replace it with 'retrieved'.
> > 
> > > > manager, such as opensm and opafm. We should calculate the
> > >    ^^^^^^^
> > > 
> > > Are you sure that information comes from the subnet manager?
> > > Isn't the LID passed to get_ioc_prof() in the srp_daemon the LID of the SRP
> > > target?
> > 
> > Yes, you are right. But srp_daemon/get_ioc_prof() send MAD packet
> > to subnet manager to obtain the maximum initiator to target iu length.
>  I do not agree that the maximum initiator to target IU length comes from
> the subnet manager. This is how I think the srp_daemon works:
> 1. The srp_daemon process sends a query to the subnet manager and asks
>    the subnet manager to report all IB ports that support device
>    management.
> 2. The subnet manager sends back information about all ports that
>    support device management (struct srp_sa_port_info_rec).
> 3. The srp_daemon sends a query to the SRP target(s) to retrieve the
>    IOUnitInfo (struct srp_dm_iou_info) and IOControllerProfile
>    (struct srp_dm_ioc_prof). The maximum initiator to target IU length
>    is present in that data structure (srp_dm_ioc_prof.send_size).

Yes, your description is more accurate.

[1] "The maximum initiator to target iu length can be retrieved from the subnet
manager, such as opensm and opafm."

[2] "The maximum initiator to target iu length can be obtained by sending
MAD packets to query subnet manager port and SRP target ports."

How about replacing sentence [1] with [2] in commit message?

thanks
