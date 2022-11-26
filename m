Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62406395E8
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 13:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKZMCV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 07:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZMCU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 07:02:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365ED1A216;
        Sat, 26 Nov 2022 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669464140; x=1701000140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pIHXm0XiOEXn6DY73lyMwaeCnl5t7Zzcag/hrkCPHbQ=;
  b=Sr67k45baYf1v1kT2A+a4qJR1UqBmIAJ4RFYs2AtJ+RmdfJOgK9DAEBF
   Ag84HbfLaFEtKT7kdoJxFtxP0BA1jrla57nYnNCUpLo352oACwFZY3ZI0
   G/kCU4D1/xuN227J+2BPWswfhUso1m9Ynz4OP0/+jEd+u/9BWwrKvocio
   XfQjNHADhmJLNk0O7MLJdbncmi3cwKU7S9/9BoT5dClLQunBH0pmIHrQY
   LM1jXLvpu5bbiBHVMiac1O+rwNo1XTsj98PuUCbGZPlDzXUc2NvS4EDhX
   8LF/5cZ8gl57gNmYjybja4wriQlwx3PQKDwoh1m6AnRxo1P2upxMzSqiP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="315748595"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="315748595"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 04:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="645010696"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="645010696"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 26 Nov 2022 04:02:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oytss-00079r-2Z;
        Sat, 26 Nov 2022 14:02:14 +0200
Date:   Sat, 26 Nov 2022 14:02:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, easwar.hariharan@intel.com
Subject: Re: [PATCH v2 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
Message-ID: <Y4IARpGaqfvHtu75@smile.fi.intel.com>
References: <1669433704-2254-1-git-send-email-wangyufen@huawei.com>
 <1669433704-2254-2-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669433704-2254-2-git-send-email-wangyufen@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 26, 2022 at 11:35:04AM +0800, Wang Yufen wrote:
> In the previous while loop, "ret" may be assigned zero, , so the error
> return code may be incorrectly set to 0 instead of -EINVAL.
> Add out_with_einval goto label and covert all "goto out;" to "goto
> out_with_einval:" where it's appropriate, alse investigate each case
> separately as Andy suggessted.

It's better now, though you missed something...

...

>  		case SRP_OPT_TARGET_CAN_QUEUE:
> -			if (match_int(args, &token) || token < 1) {
> +			ret = match_int(args, &token);

Check for ret?

> +			if (token < 1) {
>  				pr_warn("bad max target_can_queue parameter '%s'\n",
>  					p);
> -				goto out;
> +				goto out_with_einval;
>  			}
>  			target->target_can_queue = token;
>  			break;

...

>  			target->scsi_host->can_queue);

The below can't be like this, right?

> +out_with_einval:
> +	ret = -EINVAL;
>  out:
>  	kfree(options);
>  	return ret;

-- 
With Best Regards,
Andy Shevchenko


