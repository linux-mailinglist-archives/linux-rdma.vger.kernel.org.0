Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FCF2A5B18
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 01:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgKDAku (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 19:40:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:50120 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgKDAku (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 19:40:50 -0500
IronPort-SDR: HZRQyym2hDqWuf6Br/vnSjn3Psill6Msuq5OXbwsGyWkJJ0nz+rrdacJZGMzz4gWlR7S+R4BfB
 JEtrXtPBilhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="187003076"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="187003076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 16:40:49 -0800
IronPort-SDR: Btell1bh6sf4GhO56aaZucqN5ZxK1OP6K0D3qvvLZNMjLIiPyna8lm4RFU0hjj3xXYODgzAnmN
 +xHz/8adXQ/Q==
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="538694882"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 16:40:49 -0800
Date:   Tue, 3 Nov 2020 16:40:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Changming Liu <liu.changm@northeastern.edu>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        yaohway <yaohway@gmail.com>
Subject: Re: How to fuzz testing infiniband/uverb driver
Message-ID: <20201104004048.GA1538856@iweiny-DESK2.sc.intel.com>
References: <BN6PR06MB2532A875B6C3AC57072570B6E5130@BN6PR06MB2532.namprd06.prod.outlook.com>
 <20201102161617.GE971338@iweiny-DESK2.sc.intel.com>
 <BN6PR06MB2532A64BB4D75A9D8D02E310E5100@BN6PR06MB2532.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR06MB2532A64BB4D75A9D8D02E310E5100@BN6PR06MB2532.namprd06.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 10:26:22PM +0000, Changming Liu wrote:
> 
> 
> > -----Original Message-----
> > From: Ira Weiny <ira.weiny@intel.com>
> > Sent: Monday, November 2, 2020 11:16 AM
> > To: Changming Liu <liu.changm@northeastern.edu>
> > Cc: jgg@ziepe.ca; linux-rdma@vger.kernel.org; yaohway
> > <yaohway@gmail.com>
> > Subject: Re: How to fuzz testing infiniband/uverb driver
> > 
> > On Sun, Nov 01, 2020 at 09:00:13PM +0000, Changming Liu wrote:
> > >
> > > there is no 'uverbs0' file created under /sys/class/infiniband or
> > > /dev/infiniband/. So may I ask how to properly set up my testing
> > > environment so that I can fuzzi testing this driver? Is a physical
> > > device required?
> > 
> > A physical device is not required.  Look at one of the software drivers like rxe.
> > 
> 
> Thank you so much for your guidance, 
> now uverb0 has appeared and syzkaller works!

Awesome!  More testing is never a bad thing!  :-D

Ira

