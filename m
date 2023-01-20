Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2557567533A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 12:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjATLOH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 06:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjATLOG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 06:14:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017455A810
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 03:13:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F60961F28
        for <linux-rdma@vger.kernel.org>; Fri, 20 Jan 2023 11:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BFDC4339B;
        Fri, 20 Jan 2023 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674213221;
        bh=dglixJzio9rgk5Igce2t5Bh2ArYlNWHEQBUWeNanoNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiKfwzYp+O2O0PCh7gXwqyUgSm6asSMWxMjwhOmZ/5tWdM1R9FJWbtzEETz3pFm7H
         NRT+UBwE2YnSaPPO/eMCwm3CdP+uRxOOSmG7y6TBCQrk85rdRo+GCIqw7NkXMvWnkQ
         xLTuc8oGP4ekx3x9Gi9l7IYAbUVdVJUkdu4UBsLA=
Date:   Fri, 20 Jan 2023 12:13:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] iwpm: crash fix for large connections test
Message-ID: <Y8p3YgLZPXCMjRDq@kroah.com>
References: <Y3ORbHXv5M8X8kqN@kili>
 <Y3X91h5Fla+4mICY@unreal>
 <PH7PR11MB640377FDDE4E242D31DE063E8B099@PH7PR11MB6403.namprd11.prod.outlook.com>
 <Y4RkeS9mlTl9uBnO@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4RkeS9mlTl9uBnO@kadam>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 28, 2022 at 10:34:17AM +0300, Dan Carpenter wrote:
> So the background here is that Smatch sees this:
> 
> 	kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
> 
> and correctly says "if we call iwpm_free_nlmsg_request() then
> dereferencing nlmsg_request is a use after free".  However, the code
> is holding two references at this point so it will never call
> iwpm_free_nlmsg_request().
> 
> Smatch already checks to see if we are holding two references, but it
> doesn't parse this code correctly.  Smatch could be fixed, but there are
> other places with similar warnings that are more difficult to fix.
> 
> What we could do is create a kref_no_release() function that just calls
> WARN().  This would silence the warning and, I think, this would make
> the code more readable.
> 
> What do other people think?

Sure, that looks semi-decent if it helps out with the automated tools.

thanks

greg k-h
