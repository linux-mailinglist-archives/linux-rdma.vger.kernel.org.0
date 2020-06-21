Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F802202946
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgFUHMb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 03:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbgFUHMb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 03:12:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379DE24844;
        Sun, 21 Jun 2020 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592723550;
        bh=Z+QJGF0WzCBKj4J91I+6z8NCJI6iL5RWmILWL2hWspQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7NO7dVdORmug87M+76ahS95y3bwUuPiQePyQ259x8Ml46zA5QYz/SwnfMk6PqXj4
         rNgfYA2I1Lw1B3QXoUTCKs8Spos7QL7Q613KU8VllRAYSvcmNrU4NVdYAH2CJHRd3w
         X6ex9YAr5MIaXruiK4v4baawuEgKl4jD0OKs5rRY=
Date:   Sun, 21 Jun 2020 10:12:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Divya Indi <divya.indi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200621071227.GA6698@unreal>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <1591627576-920-2-git-send-email-divya.indi@oracle.com>
 <20200609070026.GJ164174@unreal>
 <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
 <20200614064156.GB2132762@unreal>
 <09bbe749-7eb2-7caa-71a9-3ead4e51e5ed@oracle.com>
 <20200617051739.GH2383158@unreal>
 <20200617182300.GJ6578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617182300.GJ6578@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 03:23:00PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2020 at 08:17:39AM +0300, Leon Romanovsky wrote:
> >
> > My thoughts that everything here hints me that state machine and
> > locking are implemented wrongly. In ideal world, the expectation
> > is that REQ message will have a state in it (PREPARED, SENT, ACK
> > e.t.c.) and list manipulations are done accordingly with proper
> > locks, while rdma_nl_multicast() is done outside of the locks.
>
> It can't be done outside the lock without creating races - once
> rdma_nl_multicast happens it is possible for the other leg of the
> operation to begin processing.

It means that the state machine is wrong, not complete.

>
> The list must be updated before this happens.
>
> What is missing here is refcounting - the lifetime model of this data
> is too implicit, but it is not worth adding I think

I have same feeling for now, but it will flip if new fixes be in this area.

Thanks

>
> Jason
