Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEC269260
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 19:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgINRBm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 13:01:42 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:43519 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgINRBa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Sep 2020 13:01:30 -0400
Received: from localhost ([10.193.186.242])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 08EH1HRB032165;
        Mon, 14 Sep 2020 10:01:18 -0700
Date:   Mon, 14 Sep 2020 22:31:17 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
Message-ID: <20200914170116.GA14572@chelsio.com>
References: <20200909134726.10348-1-bharat@chelsio.com>
 <CY4PR1201MB02327F3093F7DD29E08CCF32CE260@CY4PR1201MB0232.namprd12.prod.outlook.com>
 <20200910122739.GJ421756@unreal>
 <CY4PR1201MB0232802345D9A7BC05F1B88DCE270@CY4PR1201MB0232.namprd12.prod.outlook.com>
 <20200911131152.GM421756@unreal>
 <20200911160951.GA20264@chelsio.com>
 <20200913071325.GC35718@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913071325.GC35718@unreal>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sunday, September 09/13/20, 2020 at 12:43:25 +0530, Leon Romanovsky wrote:
> On Fri, Sep 11, 2020 at 09:39:57PM +0530, Potnuri Bharat Teja wrote:
> > On Friday, September 09/11/20, 2020 at 18:41:52 +0530, Leon Romanovsky wrote:
> > > On Thu, Sep 10, 2020 at 07:14:50PM +0000, Potnuri Bharat Teja wrote:
> > > > >> Subject: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
> > > > >>
> > > > >> Receive side delayed ack mode is needed only for certain area networks/ connections. Therefore disable it by default.
> > > > >>
> > > > >> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > > > >> ---
> > > > >>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
> > > > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> > > > >> index 1f288c73ccfc..8769e7aa097f 100644
> > > > >> --- a/drivers/infiniband/hw/cxgb4/cm.c
> > > > >> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > > > >> @@ -77,9 +77,9 @@ static int enable_ecn;  module_param(enable_ecn, int, 0644);  MODULE_PARM_DESC(enable_ecn, "Enable ECN (default=0/disabled)");
> > > > >>
> > > > >> -static int dack_mode = 1;
> > > > >> +static int dack_mode;
> > > > >>  module_param(dack_mode, int, 0644);
> > > > >> -MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=1)");
> > > > >> +MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=0)");
> > > > >
> > > > >Are you sure that this doesn't break user scripts?
> > > > Yes, I am sure. This does not interfere with user/kernel RDMA functionalities.
> > >
> > > How is it possible?
> > > Before this change user that did "modprobe iw_cxgb4" had delayed mode
> > > enabled, after this he will need to issue "modprobe iw_cxgb4 dack_mode=1"
> > >
> > Sorry I didnt get it right earlier. Yes now if user wants delayed ack mode,
> > user can issue "modprobe iw_cxgb4 dack_mode=1" or change it dynamically via
> > /sys/module/<>/paramters.
> > Chelsio adapters for better performance in most cases needs delayed ack mode to
> > be disabled. This change somehow got missed upstream all this while.
> > In fewer explicit cases, user can enable delayed ack mode where it is needed.
> 
> So why doesn't rdma-core have dack_mode=0 in kernel-boot scripts?
> 
Do you mean why dont I simply change rdma-hw-modules.rules instead?
I could do that if this is a user mode only setting. But this is needed for kernel 
mode too where in some cases rdma-core may not be installed.

Thanks.

