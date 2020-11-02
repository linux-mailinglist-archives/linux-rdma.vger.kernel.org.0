Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D682A2C4D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 15:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgKBOKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 09:10:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:2814 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKBOKx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 09:10:53 -0500
IronPort-SDR: 2NsaCwUlfnLYmFuxrX1OdtDRkJauUwUDNiseB7MsVtixRipkvwA2KW/b3ckeL9Up8L2zjqR7SO
 zIcD/EQvAaxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="230520504"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="230520504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 06:10:52 -0800
IronPort-SDR: 0S1orStDjyooRmaiN9spxQgeelh2BbAmB0cCEpmOsgeQH1DfVt4roqetqfHXKz65hv6p4+To2h
 tsR7M7LwoSIA==
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="538034794"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 06:10:48 -0800
Date:   Mon, 2 Nov 2020 22:24:00 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org, "Li, Philip" <philip.li@intel.com>,
        oliver.sang@intel.com
Subject: Re: [LKP] Re: [IB/srpt] c804af2c1d:
 last_state.test.blktests.exit_code.143
Message-ID: <20201102142400.GC20030@xsang-OptiPlex-9020>
References: <20201102140235.GA20030@xsang-OptiPlex-9020>
 <20201102135929.GD2620339@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102135929.GD2620339@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 09:59:29AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 02, 2020 at 10:02:36PM +0800, Sang, Oliver wrote:
> > Hi,
> > 
> > want to consult if all fix merged into mainline?
> > 
> > we found below commit merged rdma updates into mainline
> 
> rc2 probably fixes the error these logs have
> 
> But I think you'll hit a WARN_ON that isn't fixed yet

Thanks a lot for information! we'll check on rc2. and back to you
if need more help. Thanks

> 
> Jason
