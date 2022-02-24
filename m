Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7F4C216B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 02:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiBXB5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 20:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiBXB5l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 20:57:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE0FEB24;
        Wed, 23 Feb 2022 17:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645667829; x=1677203829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d3w1+5OFGFVTtbNZejTZ3o12Tnm69aZayQDmW4rtE6M=;
  b=Sdt9mEy6nq8f4K5L3U4juL7LTVPfMAGlQlOXQbWc4jqw/oZ88G+aV/EV
   xFM8HZZhjuluRR5d2in/4xhXh4iLwvg/NuZW2JXMyiKnoZEmlELtnG6II
   jRC5Qdn/u0b5J7EHDP69ZFgcbqTnO+uf7SW0/ACkFj4ypYqpTzG8iB266
   KVEkLR9v58hvT4sHeezBDcPEthz9qgjlRxmG5k+UdpomMi7lPPseGS/lm
   ZfN+BYHkWgvrxDXut4ZG7q1UpIE3aIy4ESwPzxJxs3duPaL9OgfPu+l1a
   bzAvMjXEM/NERaf4xk+ixd7NPg0dMinNTIL+CIoKLRpmjRffvNNiVWIq0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249700067"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="249700067"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:01:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="707259145"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:01:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nN2VE-007dta-JA;
        Thu, 24 Feb 2022 03:01:04 +0200
Date:   Thu, 24 Feb 2022 03:00:59 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Message-ID: <YhbYy7BRAw59V1It@smile.fi.intel.com>
References: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
 <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
 <Yha1bIYZpCWZIowl@smile.fi.intel.com>
 <efb8c82c626a4c7d8a9f781d63289343@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb8c82c626a4c7d8a9f781d63289343@AcuMS.aculab.com>
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

On Wed, Feb 23, 2022 at 10:50:19PM +0000, David Laight wrote:
> From: 'Andy Shevchenko'
> > Sent: 23 February 2022 22:30
> > On Wed, Feb 23, 2022 at 09:44:32PM +0000, David Laight wrote:
> > > From: Andy Shevchenko
> > > > Sent: 23 February 2022 18:54

...

> > Either way it wastes cycles, the outcome depends on the actual distribution of
> > the interrupts across the bitmap. If it gathered closer to the beginning of the
> > bitmap, my code wins, otherwise the original ones.
> 
> The loop in bitmap_empty() will kill you - even if the first word in non-zero.

What loop? Did you really look into implementation of bitmap_empty()?

-- 
With Best Regards,
Andy Shevchenko


