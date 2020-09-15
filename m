Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7E269ECA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgIOGrU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 02:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIOGrL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 02:47:11 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D8320756;
        Tue, 15 Sep 2020 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600152431;
        bh=J2gGX0W986d07fCa9jDomUHS5snz31+q+op39aTGiqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBGtG3MEztBHo/D50/Vhad6nR8jDOl0gDwZUSQIN4PCkktRvhx1ma+U2j2N9qGps/
         sRaqMx7qSh7N01wJH3EtWW9VcyIEJ51fd4Lzy7IQ1gHP7fxCd2rIFAUPaeCfu/AQPc
         v/hr1ptOZFmzt0Flzneavg/iHJQi8EXJTEq5kM+I=
Date:   Tue, 15 Sep 2020 09:47:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
Message-ID: <20200915064706.GH35718@unreal>
References: <20200909134726.10348-1-bharat@chelsio.com>
 <CY4PR1201MB02327F3093F7DD29E08CCF32CE260@CY4PR1201MB0232.namprd12.prod.outlook.com>
 <20200910122739.GJ421756@unreal>
 <CY4PR1201MB0232802345D9A7BC05F1B88DCE270@CY4PR1201MB0232.namprd12.prod.outlook.com>
 <20200911131152.GM421756@unreal>
 <20200911160951.GA20264@chelsio.com>
 <20200913071325.GC35718@unreal>
 <20200914170116.GA14572@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914170116.GA14572@chelsio.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 14, 2020 at 10:31:17PM +0530, Potnuri Bharat Teja wrote:
> On Sunday, September 09/13/20, 2020 at 12:43:25 +0530, Leon Romanovsky wrote:
> > On Fri, Sep 11, 2020 at 09:39:57PM +0530, Potnuri Bharat Teja wrote:
> > > On Friday, September 09/11/20, 2020 at 18:41:52 +0530, Leon Romanovsky wrote:
> > > > On Thu, Sep 10, 2020 at 07:14:50PM +0000, Potnuri Bharat Teja wrote:
> > > > > >> Subject: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
> > > > > >>
> > > > > >> Receive side delayed ack mode is needed only for certain area networks/ connections. Therefore disable it by default.
> > > > > >>
> > > > > >> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > > > > >> ---
> > > > > >>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
> > > > > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >>
> > > > > >> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > > > > >> index 1f288c73ccfc..8769e7aa097f 100644
> > > > > >> --- a/drivers/infiniband/hw/cxgb4/cm.c
> > > > > >> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > > > > >> @@ -77,9 +77,9 @@ static int enable_ecn;  module_param(enable_ecn, int, 0644);  MODULE_PARM_DESC(enable_ecn, "Enable ECN (default=0/disabled)");
> > > > > >>
> > > > > >> -static int dack_mode = 1;
> > > > > >> +static int dack_mode;
> > > > > >>  module_param(dack_mode, int, 0644);
> > > > > >> -MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=1)");
> > > > > >> +MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=0)");
> > > > > >
> > > > > >Are you sure that this doesn't break user scripts?
> > > > > Yes, I am sure. This does not interfere with user/kernel RDMA functionalities.
> > > >
> > > > How is it possible?
> > > > Before this change user that did "modprobe iw_cxgb4" had delayed mode
> > > > enabled, after this he will need to issue "modprobe iw_cxgb4 dack_mode=1"
> > > >
> > > Sorry I didnt get it right earlier. Yes now if user wants delayed ack mode,
> > > user can issue "modprobe iw_cxgb4 dack_mode=1" or change it dynamically via
> > > /sys/module/<>/paramters.
> > > Chelsio adapters for better performance in most cases needs delayed ack mode to
> > > be disabled. This change somehow got missed upstream all this while.
> > > In fewer explicit cases, user can enable delayed ack mode where it is needed.
> >
> > So why doesn't rdma-core have dack_mode=0 in kernel-boot scripts?
> >
> Do you mean why dont I simply change rdma-hw-modules.rules instead?
> I could do that if this is a user mode only setting. But this is needed for kernel
> mode too where in some cases rdma-core may not be installed.

No, I'm asking why if "dack_mode=0" is better and preferable way to
operate, it was never set in rdma-core.

I'm not saying that your kernel patch is wrong, just trying to get sense
on implications for the rdma-core.

Thanks

>
> Thanks.
>
