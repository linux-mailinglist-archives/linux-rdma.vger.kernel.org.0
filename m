Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4F4C1E77
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 23:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiBWWbZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 17:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBWWbZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 17:31:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2570240A16;
        Wed, 23 Feb 2022 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645655457; x=1677191457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xiuVkpU2Aoy7KyoYrr+wL4tziSAElrqPACskTUdyFZY=;
  b=TwsmLqbvRIoiTKwvLFabgwug2cYybLnmZlOmsEzW/NAsxj7B8Rwx2+vW
   ItLxufe1xnqhCsVRbw+CJzoDq9yGAK2BeUTExaCc70A9UxNYrqVGSvyIn
   xKNRV4KixYOrrqyo0tGK8ZrX5IdCIrDYnyahnchQJUEP5qC1HBrVysNKo
   LJugWBiVsJjdzz7czOtfk1q8xIA2dkuFtuaDEAi/k0nnTe51X5HIlavsM
   45915LDRrdNdY2csU8LGLHpMTQ0Slj/7d0BRYyl4ATNA20Swi6RDQ1z8X
   3tUISuH6XLhfSQ0acxc1j2B0fUWS0lQ8kWiiRYMX6exjvWpnss2fS4lMn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249675361"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="249675361"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:30:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="628251199"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:30:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nN096-007az1-Vh;
        Thu, 24 Feb 2022 00:30:04 +0200
Date:   Thu, 24 Feb 2022 00:30:04 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Message-ID: <Yha1bIYZpCWZIowl@smile.fi.intel.com>
References: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
 <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 09:44:32PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 23 February 2022 18:54
> > 
> > While in this particular case it would not be a (critical) issue,
> > the pattern itself is bad and error prone in case somebody blindly
> > copies to their code.
> 
> It is horribly wrong on BE systems.

You mean the pattern? Yes, it has three issues regarding to endianess and
potential out of boundary access.

...

> > -	return handled;
> > +	return IRQ_RETVAL(!bitmap_empty(pending, CCE_NUM_INT_CSRS * 64));

> You really don't want to scan the bitmap again.

Either way it wastes cycles, the outcome depends on the actual distribution of
the interrupts across the bitmap. If it gathered closer to the beginning of the
bitmap, my code wins, otherwise the original ones.

> Actually, of the face of it, you could merge the two loops.
> Provided you clear the status bit before calling the relevant
> handler I expect it will all work.

True. I will consider that for v2.

-- 
With Best Regards,
Andy Shevchenko


