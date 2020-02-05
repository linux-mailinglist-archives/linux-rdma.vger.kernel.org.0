Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD91538F8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBETW7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 14:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBETW7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Feb 2020 14:22:59 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E8582072B;
        Wed,  5 Feb 2020 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580930579;
        bh=Evt0EDSSw6OwMomJAB6cZdqBW/+iDAZiR03Ckl7UDkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLLkhOU66n1mK7t5MnUNS37BRe1n988IvnjDqHpV7hf4MTRev2j5i7ZRPT2rVdop+
         dPP+//xJHgIuFDlMVKJQFsypMee3oV7nTRmQ3QoJN8tGhhMFrnnLS1BLCRUdroLCAg
         6+j9lnCTB4FrY9X1v1rcmnT+K6QsVehO5OB/fK9U=
Date:   Wed, 5 Feb 2020 21:22:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200205192255.GB414821@unreal>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200205191227.GE28298@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205191227.GE28298@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 03:12:27PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 08:55:20AM -0500, Goldman, Adam wrote:
> > From: "Goldman, Adam" <adam.goldman@intel.com>
> >
> > PSM2 will not run with recent rdma-core releases. Several tools and
> > libraries like PSM2, require the hfi1 name to be present.
> >
> > Recent rdma-core releases added a new feature to rename kernel devices,
> > but the default configuration will not work with hfi1 fabrics.
> >
> > Related opa-psm2 github issue:
> >   https://github.com/intel/opa-psm2/issues/43
> >
> > Fixes: 5b4099d47be3 ("kernel-boot: Perform device rename to make stable names")
> > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> > Signed-off-by: Goldman, Adam <adam.goldman@intel.com>
> >  kernel-boot/rdma-persistent-naming.rules | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel-boot/rdma-persistent-naming.rules b/kernel-boot/rdma-persistent-naming.rules
> > index 9b61e16..95d6851 100644
> > +++ b/kernel-boot/rdma-persistent-naming.rules
> > @@ -25,4 +25,4 @@
> >  #   Device type = RoCE
> >  #   mlx5_0 -> rocex525400c0fe123455
> >  #
> > -ACTION=="add", SUBSYSTEM=="infiniband", PROGRAM="rdma_rename %k NAME_FALLBACK"
> > +ACTION=="add", SUBSYSTEM=="infiniband", KERNEL!="hfi1*", PROGRAM="rdma_rename %k NAME_FALLBACK"
>
> We are moving to the new names by default slowly, when wrong
> assumptions are found in other packages they need to be updated and
> their fixes pushed out.
>
> At some point the major distros will default this to On. People using
> leading edge distros can turn it off with the global switch Leon
> mentioned.
>
> This is the same process netdev went through when they introduced
> persistent names.
>
> If I recall, hfi was one of the reason this work was done. HFI has
> problems generating consistent names for its multi-function devices in
> various cases and I NAK'd the kernel hack to try and 'fix' that.

You remember correctly, it was related to the bug in production where
physical ports were not aligned with their physical location and the
module parameter was supposed to "reverse" the enumeration order.

Something like that.

Thanks

>
> Jason
