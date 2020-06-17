Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACC91FC585
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 07:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgFQFDp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 01:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgFQFDp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 01:03:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3374D207DD;
        Wed, 17 Jun 2020 05:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592370224;
        bh=j2mChnzVAozPxDoxg+UJPLPumPKiTztEOwPALiLc8ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+rvTVFLkeQa4Vq8B0mLqPkACSobwNgZKI2UEOI/svwOOcIdmPrqACEyAws7KaBX7
         Dc8h+N8Jl3qnKWeAWtVsGnIooWcC8FngiRPVrEnilW5n9NvwQW+6cOadKzs0KT0M7V
         kWSILOCId8Yoejzi2PDyPK2IxwvGcPFiP4yUlV78=
Date:   Wed, 17 Jun 2020 08:03:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2.6.26-4.14] IB/ipoib: Arm "send_cq" to process
 completions in due time
Message-ID: <20200617050341.GG2383158@unreal>
References: <322533b0-17de-b6b2-7da4-f99c7dfce3a8@oracle.com>
 <20200612195511.GA6578@ziepe.ca>
 <631c9e79-34e8-cc89-99bc-11fd6bc929e4@oracle.com>
 <20200616120847.GB3542686@kroah.com>
 <16760723-e9ac-88b7-0b95-170e43abee2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16760723-e9ac-88b7-0b95-170e43abee2b@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 09:35:38AM -0700, Gerd Rausch wrote:
> Hi,
>
> On 16/06/2020 05.08, Greg Kroah-Hartman wrote:
> >> I considered backporting commit 8966e28d2e40c ("IB/ipoib: Use NAPI in UD/TX flows")
> >> with all the dependencies it may have a considerably higher risk
> >> than just arming the TX CQ.
> >
> > 90% of the time when we apply a patch that does NOT match the upstream
> > tree, it has a bug in it and needs to have another fix or something
> > else.
> >
> > So please, if at all possible, stick to the upstream tree, so
> > backporting the current patches are the best thing to do.
> >
>
> Jason,
>
> With Mellanox writing and fixing the vast majority of the code found
> in IB/IPoIB, do you or one of your colleagues want to look into this?
>
> It would be considerably less error-prone if the authors of that code
> did that more risky work of backporting.
>
> AFAIK, Mellanox also has the regression tests to ensure that everything
> still works after this re-write as it did before.

Please approach your Mellanox FAE representatives, they will know how to
handle it internally.

Thanks

>
> Thanks,
>
>  Gerd
>
