Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461E5638C55
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Nov 2022 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKYOhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Nov 2022 09:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKYOho (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Nov 2022 09:37:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6D13D01;
        Fri, 25 Nov 2022 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669387063; x=1700923063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=612qLX0Kbo8JHvjWPDFOqyUDqqkxQqt5ls5OtFzNO0w=;
  b=mwe4j6vXvFAShY7oShXwZCMD00PQwddHu1M8knM5DPUVGQ1yzaeObGBl
   8jm7hRMweUcNkELR1dIkRPRo5VdRfAKSgrVqe/OYYnspUQoIo5qcY1sDr
   uqEM6hyVqn73rxvS1ND9pg/oW1bGdAna33lA3eOygLdvSGoNtZd+Ct9xS
   +UrS0Lqvv1HUPRj021YMBbnRLJEL7BnGFvd68VdoPrp/PRbXpgZzmxH5c
   Tk6ft/FSpQcRl3cMBCZylP0OqCyBQ+10iDZftL8BuElzulFSpe1Eybtjj
   whWmEIoEG87sGokwsQQEU4FK8W140USN3UsI4BZta2SXODXgHKTka1Aio
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="297849355"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="297849355"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 06:37:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="731459395"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="731459395"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2022 06:37:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyZpi-00HGTc-06;
        Fri, 25 Nov 2022 16:37:38 +0200
Date:   Fri, 25 Nov 2022 16:37:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, easwar.hariharan@intel.com
Subject: Re: [PATCH 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
Message-ID: <Y4DTMQVenpsEiKHz@smile.fi.intel.com>
References: <1669377831-41386-1-git-send-email-wangyufen@huawei.com>
 <1669377831-41386-2-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669377831-41386-2-git-send-email-wangyufen@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 25, 2022 at 08:03:51PM +0800, Wang Yufen wrote:
> In the previous while loop, "ret" may be assigned zero. Therefore,
> "ret" needs to be assigned -EINVAL at the beginning of each loop.

...

>  	while ((p = strsep(&sep_opt, ",\n")) != NULL) {
> +		ret = -EINVAL;
>  		if (!*p)
>  			continue;

Better option is to investigate each case separately and gather all of them
into a single fix.

For example, this

	case SRP_OPT_MAX_IT_IU_SIZE:
		if (match_int(args, &token) || token < 0) {
			pr_warn("bad maximum initiator to target IU size '%s'\n", p);
			goto out;
		}
		target->max_it_iu_size = token;
		break;

can be rewritten as

	case SRP_OPT_MAX_IT_IU_SIZE:
		ret = match_int(args, &token);
		if (ret)
			goto out;
		if (token < 0) {
			pr_warn("bad maximum initiator to target IU size '%s'\n", p);
			ret = -EINVAL;
			goto out;
		}
		target->max_it_iu_size = token;
		break;

and so on...

-- 
With Best Regards,
Andy Shevchenko


