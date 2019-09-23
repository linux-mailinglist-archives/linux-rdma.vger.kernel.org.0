Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF12BACE1
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 05:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405987AbfIWDdm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Sep 2019 23:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404054AbfIWDdm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Sep 2019 23:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1851F300DA6E;
        Mon, 23 Sep 2019 03:33:42 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88C275DA21;
        Mon, 23 Sep 2019 03:33:41 +0000 (UTC)
Date:   Mon, 23 Sep 2019 11:33:39 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [patch v3 2/2] RDMA/srp: calculate max_it_iu_size if remote
 max_it_iu length available
Message-ID: <20190923033339.GB8298@dhcp-128-227.nay.redhat.com>
References: <20190919035032.31373-1-honli@redhat.com>
 <20190919035032.31373-2-honli@redhat.com>
 <c0ab625a-d029-37b4-753f-312e7877a6fc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ab625a-d029-37b4-753f-312e7877a6fc@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 23 Sep 2019 03:33:42 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 20, 2019 at 09:18:49AM -0700, Bart Van Assche wrote:
> On 9/18/19 8:50 PM, Honggang LI wrote:
> > From: Honggang Li <honli@redhat.com>
> > 
> > The default maximum immediate size is too big for old srp clients,
> > which without immediate data support.
>         ^^^^^^^
>         do not?

OK, will fix it.

> > 
> > According to the SRP and SRP-2 specifications, the IOControllerProfile
> > attributes for SRP target ports contains the maximum initiator to target
> > iu length.
> > 
> > The maximum initiator to target iu length can be get from the subnet
>                                                    ^^^
>                                          retrieved? obtained?

OK, will replace it with 'retrieved'.

> > manager, such as opensm and opafm. We should calculate the
>   ^^^^^^^
> 
> Are you sure that information comes from the subnet manager?
> Isn't the LID passed to get_ioc_prof() in the srp_daemon the LID of the SRP
> target?

Yes, you are right. But srp_daemon/get_ioc_prof() send MAD packet
to subnet manager to obtain the maximum initiator to target iu length.

> 
> Anyway, since the code changes look fine to me, feel free to add:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
