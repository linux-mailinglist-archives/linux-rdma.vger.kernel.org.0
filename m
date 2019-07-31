Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0379A7C054
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfGaLqO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 07:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfGaLqO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 07:46:14 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61E02089E;
        Wed, 31 Jul 2019 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564573573;
        bh=v5MEBAeGlBwTr+/V8qBkRz08MH6jE8WcYIKV++/hrHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zeoQBFmvYF333x817Ul9id+xKe24cNHvvg8NqaFxSv8Kd3dImiDzpiX5PgM5d8Jrc
         Dr7HZDv/qsNF/ERQIzrogf3Z0hZa9Krvahs5S39306NL88pcxBi5Z3a3CxyhQ9Fd5Q
         ZmsVpF1aBtspoSFk7sArJS6G0LQTu1xpCpEl+EuQ=
Date:   Wed, 31 Jul 2019 14:46:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/2] RDMA/core: Introduce ratelimited ibdev
 printk functions
Message-ID: <20190731114609.GS4878@mtr-leonro.mtl.com>
References: <20190730151834.70993-1-galpress@amazon.com>
 <20190730151834.70993-2-galpress@amazon.com>
 <20190730154148.GG4878@mtr-leonro.mtl.com>
 <dd2c23a3-1d92-56d4-933e-68ec37aebb65@amazon.com>
 <20190731074109.GL4878@mtr-leonro.mtl.com>
 <dfffaa13-3b1a-81ef-1922-68aacf085616@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfffaa13-3b1a-81ef-1922-68aacf085616@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 01:51:05PM +0300, Gal Pressman wrote:
> On 31/07/2019 10:41, Leon Romanovsky wrote:
> > On Wed, Jul 31, 2019 at 10:22:42AM +0300, Gal Pressman wrote:
> >> On 30/07/2019 18:41, Leon Romanovsky wrote:
> >>> On Tue, Jul 30, 2019 at 06:18:33PM +0300, Gal Pressman wrote:
> >>>> Add ratelimited helpers to the ibdev_* printk functions.
> >>>> Implementation inspired by counterpart dev_*_ratelimited functions.
> >>>>
> >>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>>> ---
> >>>>  include/rdma/ib_verbs.h | 51 +++++++++++++++++++++++++++++++++++++++++
> >>>>  1 file changed, 51 insertions(+)
> >>>>
> >>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> >>>> index c5f8a9f17063..356e6a105366 100644
> >>>> --- a/include/rdma/ib_verbs.h
> >>>> +++ b/include/rdma/ib_verbs.h
> >>>> @@ -107,6 +107,57 @@ static inline
> >>>>  void ibdev_dbg(const struct ib_device *ibdev, const char *format, ...) {}
> >>>>  #endif
> >>>>
> >>>> +#define ibdev_level_ratelimited(ibdev_level, ibdev, fmt, ...)           \
> >>>> +do {                                                                    \
> >>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
> >>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
> >>>> +				      DEFAULT_RATELIMIT_BURST);         \
> >>>> +	if (__ratelimit(&_rs))                                          \
> >>>> +		ibdev_level(ibdev, fmt, ##__VA_ARGS__);                 \
> >>>> +} while (0)
> >>>> +
> >>>> +#define ibdev_emerg_ratelimited(ibdev, fmt, ...) \
> >>>> +	ibdev_level_ratelimited(ibdev_emerg, ibdev, fmt, ##__VA_ARGS__)
> >>>> +#define ibdev_alert_ratelimited(ibdev, fmt, ...) \
> >>>> +	ibdev_level_ratelimited(ibdev_alert, ibdev, fmt, ##__VA_ARGS__)
> >>>> +#define ibdev_crit_ratelimited(ibdev, fmt, ...) \
> >>>> +	ibdev_level_ratelimited(ibdev_crit, ibdev, fmt, ##__VA_ARGS__)
> >>>> +#define ibdev_err_ratelimited(ibdev, fmt, ...) \
> >>>> +	ibdev_level_ratelimited(ibdev_err, ibdev, fmt, ##__VA_ARGS__)
> >>>> +#define ibdev_warn_ratelimited(ibdev, fmt, ...) \
> >>>> +	ibdev_level_ratelimited(ibdev_warn, ibdev, fmt, ##__VA_ARGS__)
> >>>> +#define ibdev_notice_ratelimited(ibdev, fmt, ...) \
> >>>> +	ibdev_level_ratelimited(ibdev_notice, ibdev, fmt, ##__VA_ARGS__)
> >>>> +#define ibdev_info_ratelimited(ibdev, fmt, ...) \
> >>>> +	ibdev_level_ratelimited(ibdev_info, ibdev, fmt, ##__VA_ARGS__)
> >>>> +
> >>>> +#if defined(CONFIG_DYNAMIC_DEBUG)
> >>>> +/* descriptor check is first to prevent flooding with "callbacks suppressed" */
> >>>> +#define ibdev_dbg_ratelimited(ibdev, fmt, ...)                          \
> >>>> +do {                                                                    \
> >>>> +	static DEFINE_RATELIMIT_STATE(_rs,                              \
> >>>> +				      DEFAULT_RATELIMIT_INTERVAL,       \
> >>>> +				      DEFAULT_RATELIMIT_BURST);         \
> >>>> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);                 \
> >>>> +	if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs))      \
> >>>> +		__dynamic_ibdev_dbg(&descriptor, ibdev, fmt,            \
> >>>> +				    ##__VA_ARGS__);                     \
> >>>> +} while (0)
> >>>> +#elif defined(DEBUG)
> >>>
> >>> When will you see this CONFIG_DEBUG set? I suspect only in private
> >>> out-of-tree builds which we are not really care. Also I can't imagine
> >>> system with this CONFIG_DEBUG and without CONFIG_DYNAMIC_DEBUG.
> >>
> >> This is the common way to handle debug prints, see:
> >> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/printk.h#L331
> >> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/device.h#L1493
> >> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/netdevice.h#L4743
> >> https://elixir.bootlin.com/linux/v5.2.1/source/include/linux/net.h#L266
> >
> > I'm more interested to know the real usage of this copy/paste and
> > understand if it makes sense for drivers/infiniband/* or not.
> >
> > Not everything in netdev is great and worth to borrow.
>
> DEBUG exists since the first commit in the tree, and is used in various parts of
> the kernel (mlx5 as well). Do you think it should be removed from the kernel?

It is gradually removed when it is spotted, I'll send a patch for mlx5 now.

>
> Regarding combination of both, I don't think DEBUG is related to
> CONFIG_DYNAMIC_DEBUG. DEBUG is a generic debug flag (not necessarily to prints)
> while CONFIG_DYNAMIC_DEBUG is specific to the dynamic debug prints infrastructure.

I know exactly what DEBUG and CONFIG_DYNAMIC_DEBUG mean, but I'm
asking YOU to provide us real and in-tree scenario where DEBUG will
exists and CONFIG_DYNAMIC_DEBUG won't.

Thanks
