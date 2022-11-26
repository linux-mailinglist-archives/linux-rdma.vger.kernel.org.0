Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8E6395EA
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 13:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKZMDh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 07:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZMDh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 07:03:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A2D1A050;
        Sat, 26 Nov 2022 04:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669464216; x=1701000216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ED3/IyjABUJ+TX8Exyv4zWJigtGgZk0QTi0gbQuEMU=;
  b=liE2094L2CpDG4H6D9zsb9p9voJAcGSMYa/zmBUH9VRg75mtjACOiQim
   66MzrSclm3cW8J5oofj2yHRuHELYmH1tdbMCx9bE0Y0JE7abdplB1gYMJ
   +fTji74rgzyOZtyWz8PMVl/QTlFo/ivYrblLVMgL7aCytb6O8r8EQ4O5E
   uv5c9K/7Ea0X/+ipVDDIqZgdRaXqQJQEw6jVYe2bFZGy6pjD5tm5Q64nf
   ciXx9uZZEIwWkocId1g7OH7c2FYFa6v+adQM74L0QSzNyVDpsCDymrjSa
   zOoJWxJ3njnkT+aAX6bFzQHMJphIXQuhfi9bCD6G8rvhFF0WWa/bIGvaj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="314626811"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="314626811"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 04:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="706281553"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="706281553"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2022 04:03:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oytu8-0007Cn-0f;
        Sat, 26 Nov 2022 14:03:32 +0200
Date:   Sat, 26 Nov 2022 14:03:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, easwar.hariharan@intel.com
Subject: Re: [PATCH v2 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
Message-ID: <Y4IAky87PxC/J7lr@smile.fi.intel.com>
References: <1669433704-2254-1-git-send-email-wangyufen@huawei.com>
 <1669433704-2254-2-git-send-email-wangyufen@huawei.com>
 <Y4IARpGaqfvHtu75@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4IARpGaqfvHtu75@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 26, 2022 at 02:02:14PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 26, 2022 at 11:35:04AM +0800, Wang Yufen wrote:

...

> >  			target->scsi_host->can_queue);
> 
> The below can't be like this, right?
> 
> > +out_with_einval:
> > +	ret = -EINVAL;
> >  out:
> >  	kfree(options);
> >  	return ret;

One option is:

out:
	kfree(options);
	return ret;

out_with_einval:
	ret = -EINVAL;
	goto out;


-- 
With Best Regards,
Andy Shevchenko


