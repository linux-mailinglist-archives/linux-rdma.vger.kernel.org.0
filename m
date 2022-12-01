Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE663F059
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 13:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiLAMV2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 07:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiLAMV0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 07:21:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED3AC189;
        Thu,  1 Dec 2022 04:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669897285; x=1701433285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zMT5OnVdYotGUP7XVWx30OX44Un4xEXQdRgd2cwwH6U=;
  b=ex7VdoTZOeHqQEOkUYmnv8LQa4ja67MIg+qfpcACEdbKIznwOLTIv03+
   eJcIYL/AMcAj4feEV1EDy2NPkk93MST2tynb71hTR/En0YLUSljdB/TVn
   ks8RuQLfJdPPdgl+1NZrV3Aj5Bi6VBZ+m+ivbOGDlVd8RSBGHLbL6khZR
   PSF2LlxYrdiLWthpeuQFDRwIkLuoLqInfDytCx4lVIfKWsZZnWQSKY7eH
   moLJHwQPC6T+U/WIagx+x70Iyuz53Pj2v8F1o3Kx1tZveGWMRltVcUZsU
   LRYK0hhWXrdQ1y9NiWD/LLuRGvWwN3KOUTBfIX+Ejq0+o9vDjVq+lRSbA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="313300634"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="313300634"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:21:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622283223"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="622283223"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2022 04:21:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0iZ5-002mOr-2O;
        Thu, 01 Dec 2022 14:21:19 +0200
Date:   Thu, 1 Dec 2022 14:21:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     wangyufen <wangyufen@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, jgg@ziepe.ca,
        leon@kernel.org, dennis.dalessandro@cornelisnetworks.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, easwar.hariharan@intel.com
Subject: Re: [PATCH v4 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
Message-ID: <Y4icP1qyB+bLK+ya@smile.fi.intel.com>
References: <1669687459-14180-1-git-send-email-wangyufen@huawei.com>
 <1669687459-14180-2-git-send-email-wangyufen@huawei.com>
 <b4d78eb0-4492-ac7f-d500-3d49b0dc7aa1@acm.org>
 <65604aae-b722-4caf-3373-d0f1e4492faa@huawei.com>
 <1d27a774-cf83-6e36-4fa1-c0635ebfd79e@acm.org>
 <0b726968-bfb8-ab9a-8d03-4d072d410597@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b726968-bfb8-ab9a-8d03-4d072d410597@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 09:49:51AM +0800, wangyufen wrote:
> 在 2022/12/1 2:00, Bart Van Assche 写道:
> > On 11/29/22 19:31, wangyufen wrote:

...

>                 case SRP_OPT_CMD_SG_ENTRIES:
> -                       if (match_int(args, &token) || token < 1 || token >
> 255) {
> +                       ret = match_int(args, &token);
> +                       if (ret) {
> +                               pr_warn("bad max cmd_sg_entries parameter
> '%s'\n",

It's misleading message here. The problem is that parser failed by some reason.
Otherwise this variant seems good one.

> +                                       p);
> +                               goto out;
> +                       }
> +                       if (token < 1 || token > 255) {
>                                 pr_warn("bad max cmd_sg_entries parameter
> '%s'\n",
>                                         p);
> +                               ret = -EINVAL;
>                                 goto out;
>                         }
>                         target->cmd_sg_cnt = token;
>                         break;

...

> Or the following is better?

Why do you want to shadow actual error code?

-- 
With Best Regards,
Andy Shevchenko


