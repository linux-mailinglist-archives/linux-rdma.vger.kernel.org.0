Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD77CB0F
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 19:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfGaRyT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 13:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfGaRyT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 13:54:19 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACCD206B8;
        Wed, 31 Jul 2019 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564595657;
        bh=s2h83pBh+ZHPlHhxxApkwnd0zZLThDU6ineKKEiM2X0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aImgbSTVaIvCnXNMTu+ozxQxRSYA2cQu2f5SCfowXfZBpLm7XGk+TQ4uhCju3cuwq
         h38TXgTeT7YiaQlkhbde7pNBdc0wIO7DJMVJzQm9hYCizUCc2IZgIwnlUyMpWFPkHl
         ofC7dgALUwkWygT30yAOYM9IDZY/T2bzIjFYh+as=
Date:   Wed, 31 Jul 2019 20:54:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/2] RDMA/core: Introduce ratelimited ibdev
 printk functions
Message-ID: <20190731175411.GD4832@mtr-leonro.mtl.com>
References: <20190730154148.GG4878@mtr-leonro.mtl.com>
 <dd2c23a3-1d92-56d4-933e-68ec37aebb65@amazon.com>
 <20190731074109.GL4878@mtr-leonro.mtl.com>
 <dfffaa13-3b1a-81ef-1922-68aacf085616@amazon.com>
 <20190731114609.GS4878@mtr-leonro.mtl.com>
 <df557f2a-24c2-1b7d-abc9-81c62b1cdf11@amazon.com>
 <20190731133309.GW4878@mtr-leonro.mtl.com>
 <4a767c0c-f1cb-3edf-3ad0-7adc07fd2c78@amazon.com>
 <20190731145022.GB4832@mtr-leonro.mtl.com>
 <69346585-d3ff-94ed-21a8-8cbfdfe6bac3@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69346585-d3ff-94ed-21a8-8cbfdfe6bac3@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 06:26:16PM +0300, Gal Pressman wrote:
> On 31/07/2019 17:50, Leon Romanovsky wrote:
> > On Wed, Jul 31, 2019 at 05:19:41PM +0300, Gal Pressman wrote:
> >> On 31/07/2019 16:33, Leon Romanovsky wrote:
> >>> On Wed, Jul 31, 2019 at 03:56:55PM +0300, Gal Pressman wrote:
> >>>> On 31/07/2019 14:46, Leon Romanovsky wrote:
> >>>>> On Wed, Jul 31, 2019 at 01:51:05PM +0300, Gal Pressman wrote:
> >>>>>> On 31/07/2019 10:41, Leon Romanovsky wrote:
> >>>>>>> On Wed, Jul 31, 2019 at 10:22:42AM +0300, Gal Pressman wrote:
> >>>>>>>> On 30/07/2019 18:41, Leon Romanovsky wrote:
> >>>>>>>>> On Tue, Jul 30, 2019 at 06:18:33PM +0300, Gal Pressman wrote:
> >>>>>>>>>> Add ratelimited helpers to the ibdev_* printk functions.
> >>>>>>>>>> Implementation inspired by counterpart dev_*_ratelimited functions.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>>>>>>>>> ---
> >>>>>>>>>>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++
> >>>>>>>>>>  1 file changed, 51 insertions(+)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> >>>>>>>>>> index c5f8a9f17063..356e6a105366 100644
> >>>>>>>>>> --- a/include/rdma/ib_verbs.h
> >>>>>>>>>> +++ b/include/rdma/ib_verbs.h
> >>>>>>>>>> @@ -107,6 +107,57 @@ static inline
> >>>>>>>>>>  void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
> >>>>>>>>>>  #endif
> >>>>>>>>>>
> >>>>>>>>>> +#define ibdev_level_ratelimited(ibdev_level, ibdev, fmt, ...)           \
> >>>>>>>>>> +do {                                                                    \
> >>>>>>>>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
> >>>>>>>>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
> >>>>>>>>>> +				      DEFAULT_RATELIMIT_BURST);         \
> >>>>>>>>>> +	if (__ratelimit(&_rs))                                          \
> >>>>>>>>>> +		ibdev_level(ibdev, fmt, ##__VA_ARGS__);                 \
> >>>>>>>>>> +} while (0)
> >>>>>>>>>> +
> >>>>>>>>>> +#define ibdev_emerg_ratelimited(ibdev, fmt, ...) \
> >>>>>>>>>> +	ibdev_level_ratelimited(ibdev_emerg, ibdev, fmt, ##__VA_ARGS__)
> >>>>>>>>>> +#define ibdev_alert_ratelimited(ibdev, fmt, ...) \
> >>>>>>>>>> +	ibdev_level_ratelimited(ibdev_alert, ibdev, fmt, ##__VA_ARGS__)
> >>>>>>>>>> +#define ibdev_crit_ratelimited(ibdev, fmt, ...) \
> >>>>>>>>>> +	ibdev_level_ratelimited(ibdev_crit, ibdev, fmt, ##__VA_ARGS__)
> >>>>>>>>>> +#define ibdev_err_ratelimited(ibdev, fmt, ...) \
> >>>>>>>>>> +	ibdev_level_ratelimited(ibdev_err, ibdev, fmt, ##__VA_ARGS__)
> >>>>>>>>>> +#define ibdev_warn_ratelimited(ibdev, fmt, ...) \
> >>>>>>>>>> +	ibdev_level_ratelimited(ibdev_warn, ibdev, fmt, ##__VA_ARGS__)
> >>>>>>>>>> +#define ibdev_notice_ratelimited(ibdev, fmt, ...) \
> >>>>>>>>>> +	ibdev_level_ratelimited(ibdev_notice, ibdev, fmt, ##__VA_ARGS__)
> >>>>>>>>>> +#define ibdev_info_ratelimited(ibdev, fmt, ...) \
> >>>>>>>>>> +	ibdev_level_ratelimited(ibdev_info, ibdev, fmt, ##__VA_ARGS__)
> >>>>>>>>>> +
> >>>>>>>>>> +#if defined(CONFIG_DYNAMIC_DEBUG)
> >>>>>>>>>> +/* descriptor check is first to prevent flooding with "callbacks suppressed" */
> >>>>>>>>>> +#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
> >>>>>>>>>> +do {                                                                    \
> >>>>>>>>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
> >>>>>>>>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
> >>>>>>>>>> +				      DEFAULT_RATELIMIT_BURST);         \
> >>>>>>>>>> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
> >>>>>>>>>> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs))      \
> >>>>>>>>>> +		__dynamic_ibdev_dbg(&descriptor, ibdev, fmt,            \
> >>>>>>>>>> +				    ##__VA_ARGS__);                     \
> >>>>>>>>>> +} while (0)
> >>>>>>>>>> +#elif defined(DEBUG)
> >>>>>>>>>
> >>>>>>>>> When will you see this CONFIG_DEBUG set? I suspect only in private
> >>>>>>>>> out-of-tree builds which we are not really care. Also I can't imagine
> >>>>>>>>> system with this CONFIG_DEBUG and without CONFIG_DYNAMIC_DEBUG.
> >>>>>>>>
> >>>>>>>> This is the common way to handle debug prints, see:
> >>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/printk.h#L331
> >>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/device.h#L1493
> >>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/netdevice.h#L4743
> >>>>>>>> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/net.h#L266
> >>>>>>>
> >>>>>>> I'm more interested to know the real usage of this copy/paste and
> >>>>>>> understand if it makes sense for drivers/infiniband/* or not.
> >>>>>>>
> >>>>>>> Not everything in netdev is great and worth to borrow.
> >>>>>>
> >>>>>> DEBUG exists since the first commit in the tree, and is used in various parts of
> >>>>>> the kernel (mlx5 as well). Do you think it should be removed from the kernel?
> >>>>>
> >>>>> It is gradually removed when it is spotted, I'll send a patch for mlx5 now.
> >>>>
> >>>> Was there an on-list discussion regarding removal of DEBUG usage? Can you please
> >>>> share a link?
> >>>
> >>> Sorry, but no, I didn't know that I need to save all discussions I see
> >>> in the mailing lists.
> >>
> >> Trying to understand whether "It is gradually removed when it is spotted" is a
> >> well known guideline by the community, should checkpatch produce a warning for this?
> >
> > I didn't see checks in checkpatch about tabs<->spaces mix either which you
> > pointed for hns guys.
>
> Ofcourse there are, this patch was full of checkpatch warnings.
> But that's not the point, you're avoiding answering a simple question: is DEBUG
> usage discouraged by the community?

Yes, I said it a couple of times, "community" is not excited to see
debug code in final code. The expectation that submitted code works
and doesn't need extra debug. If it is not true, such code is not ready
to be merged.

Anyway, simple grep in our subsystem shows that this "DEBUG" in use in one
place only (fmr) and it predates git era.
_  kernel git:(rdma-next) git grep DEBUG drivers/infiniband/ include/rdma/ | grep ifdef

There is no new code with this "DEBUG" flag.

>
> >
> >>
> >>>
> >>>> If so, I agree the DEBUG part should be removed.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Regarding combination of both, I don't think DEBUG is related to
> >>>>>> CONFIG_DYNAMIC_DEBUG. DEBUG is a generic debug flag (not necessarily to prints)
> >>>>>> while CONFIG_DYNAMIC_DEBUG is specific to the dynamic debug prints infrastructure.
> >>>>>
> >>>>> I know exactly what DEBUG and CONFIG_DYNAMIC_DEBUG mean, but I'm
> >>>>> asking YOU to provide us real and in-tree scenario where DEBUG will
> >>>>> exists and CONFIG_DYNAMIC_DEBUG won't.
> >>>>
> >>>> What's any of this has to do with in-tree? This code and defines are part of the
> >>>> tree.
> >>>>
> >>>> The use case doesn't matter, it's a valid permutation. Is there anything that
> >>>> stops a user from building the kernel this way?
> >>>
> >>> Like everything else, nothing stops from you to do any modifications to
> >>> the source code, before you will build. We are talking about in-tree
> >>> builds and distro kernels.
> >>
> >> Last I checked turning on DEBUG doesn't require source code changes?
> >
> > Exciting, how did you enable DEBUG without recompiling source code?
>
> Recompiling source code != changing source code.

I'm as a kernel developer don't see the difference.

> You can turn on DEBUG when compiling the kernel (i.e running make) with no
> source code changes (again, last I checked, did this change lately?).
>
> > Maybe you find a way to enable DEBUG on running kernel?
> >
> > And how did it come that v5.3 kernel was compiled with DEBUG but
> > without DYNAMIC_DEBUG?
>
> Change CONFIG_DYNAMIC_DEBUG=n in your .config and pass DEBUG to make.

I asked for a real example and not for allnoconfig compilation.
