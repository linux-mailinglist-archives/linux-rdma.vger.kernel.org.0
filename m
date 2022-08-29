Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169B95A4273
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 07:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiH2FmE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 01:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2FmD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 01:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36FB2CE16
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 22:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC0F61025
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 05:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CECC433D6;
        Mon, 29 Aug 2022 05:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661751721;
        bh=vMySWFAysGpe9V0NE4VLT7MgDJ27Vi5WjA5yZA8kRvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5OuXdTzkMsA4KZGAce9ZlhW+xRSJJuPlXin6EQMeT3NQbhdHuxgxHtH2t/RrzR8/
         KLJR2L/PNS/hag4qRiPgPb91Bf76VNppIlfH/hws5mpCSDngDdeFt0Oy12EKKD2tzW
         0IgJKYDLLyej2dTWacdWmdOve4QcdNvCDWR4qQJsSz5Skz+8ONXOfVnze+Exp05W6Z
         A8C9CxdFnVZjFR7YJwKuh35xthlsw5dydzuMmU6jGCiyHBJBEFCMrRLAqVAUKQRej6
         sbsEOKhwH1Tz4ym8A0AI2bCmVSK9sfojw+F0/mjaMF+6yz5aOmLXpFCn9cVw/3iA5v
         QFMGsJ+UvglNw==
Date:   Mon, 29 Aug 2022 08:41:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/4] RDMA/srp: Handle dev_set_name() failure
Message-ID: <YwxRpeDB9fpw6j58@unreal>
References: <20220825213900.864587-1-bvanassche@acm.org>
 <Yws9t6Xj/08izIdR@unreal>
 <f98c7a98-21e5-817b-df6c-04df777307c2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f98c7a98-21e5-817b-df6c-04df777307c2@acm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 28, 2022 at 12:50:28PM -0700, Bart Van Assche wrote:
> On 8/28/22 03:04, Leon Romanovsky wrote:
> > On Thu, Aug 25, 2022 at 02:38:56PM -0700, Bart Van Assche wrote:
> > > This patch series includes one patch that handles dev_set_name() failure and
> > > three refactoring patches. Please consider these patches for the next merge
> > > window.
> > 
> > You confuse me. "next merge window" means that patches are targeted to
> > -next, but you added stable@... tag and didn't add any Fixes lines.
> > 
> > I applied everything to rdma-next and removed stable@ tag.
> 
> Hi Leon,
> 
> Although it's not a big deal for this patch series, please do not modify patches
> without agreement from the patch author.

I didn't promote the series from my WIP branch to for-next yet and can drop
them, if you want.

> 
> As far as I know adding a Fixes: tag if a Cc: stable tag is present is not required
> by any document in the Documentation/ directory?
> 
> I had not added a Fixes: tag because the issue fixed by patch 3/3 was introduced
> by the commit that added the ib_srp driver to the kernel tree. So it would be fine
> to backport the first three patches of this series to all older kernel versions to
> which the patches can be backported.

You wanted third patch in stable@, but didn't add tag to it or any
indication that it must be there. Instead of it, you added stable@
to some cleanup that would be backported anyway if third patch would
be stable material.

Let's me cite Documentation/process/stable-kernel-rules.rst with items
that make this series is not suitable for stable:
...
   12  - It must fix a real bug that bothers people (not a, "This could be a
   13    problem..." type thing).
   14  - It must fix a problem that causes a build error (but not for things
   15    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   16    security issue, or some "oh, that's not good" issue.  In short, something
   17    critical.
   18  - Serious issues as reported by a user of a distribution kernel may also
   19    be considered if they fix a notable performance or interactivity issue.
   20    As these fixes are not as obvious and have a higher risk of a subtle
   21    regression they should only be submitted by a distribution kernel
   22    maintainer and include an addendum linking to a bugzilla entry if it
   23    exists and additional information on the user-visible impact.
   24  - New device IDs and quirks are also accepted.
...
   25  - No "theoretical race condition" issues, unless an explanation of how the
   26    race can be exploited is also provided.
   29  - It must follow the 
   30    :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
   31    rules.

Documentation/process/submitting-patches.rst:
...
  137 If your patch fixes a bug in a specific commit, e.g. you found an issue using
  138 ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
  139 the SHA-1 ID, and the one line summary. 
...

Also I hope that you looked when dev_set_name() can fail. Hint, when it
failed to allocate enough room for short string "srp-%s-%d". If it is
happened, you have much more serious problems than not-checked
dev_set_name().

Why is it so urgent to be part of stable? Can you present me the case
where user had OOM during dev_set_name at the beginning of srp initialization
routine and passed device_register() later?

Thanks

> 
> Thanks,
> 
> Bart.
