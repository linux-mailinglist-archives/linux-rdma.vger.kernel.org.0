Return-Path: <linux-rdma+bounces-3241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4434490BA8C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 21:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C2C1F21E50
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459C9198E84;
	Mon, 17 Jun 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbfyuHXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C5198843;
	Mon, 17 Jun 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651075; cv=none; b=ObmgxvU+qYHZ/mgPbs26i9e6wltOVKAfN73UMlqfIGrvyyRgGhtHud35RX7PlvfONIlCr8n7evA2IVnuu3ISq/MtkpBrQUTsrNeZr8ZO95X6ZkIu1GBwjiyTvw0G2webCP4Z/67lHOyaKno90FKQjs5uAs1n6NBkGirFinlGtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651075; c=relaxed/simple;
	bh=HD6iO8hWvr/4Q3/xpn2c58NGmdSa4rpuRfGbqAneJkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWNi3AS3q4z4dfleTETnXe1/14WVVwGEu7N4C8t2pcNYasT5lsx4zWgOzRjWYVccdJLDevxdGtgcYMNxxhG1zAhDAS4M9Cdvit3W4b5MmeVUGWgUvGjREFMvM+ng6rWcBRRSuXdff6/1Get3OxwmfNEnWPvQ+vrUAyxYq+yk/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbfyuHXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9F8C2BD10;
	Mon, 17 Jun 2024 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718651074;
	bh=HD6iO8hWvr/4Q3/xpn2c58NGmdSa4rpuRfGbqAneJkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbfyuHXIOLqyw+jyFvf5BHQoFBBkiFyDeVz/0/SzPeTvwrnFH1F0QxMMjNNUkKc4Q
	 7t/2sFp8ASlWWEfcCfJ0Nm/roP8BmWmFhFCO5oJGxRGf+jPP2r1JeYe4iPrLgNr+x2
	 E7yGusmxfXzpML9gMVOermBxQXeBPtF1UOsHj1SsLrNv0ILZYLaOcfbWdQtmO3iHqQ
	 d5g1sDEDPnzm+m3mAQWbUxl8qe1hyUAbdfIJ7Jz0pF4ao83I7c32jqonqKTIO+7eoq
	 y0A+h3yFlLNhxpfb3VEdRNxVQA4eCXDI4Zs8d4hu5JijpAFgK7/UiMSDw7Gv7kKGuj
	 9hKsXETDhyTTQ==
Date: Mon, 17 Jun 2024 22:04:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240617190429.GB4025@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-12-oshpigelman@habana.ai>
 <20240613191828.GJ4966@unreal>
 <fbb34afa-8a38-4124-9384-9b858ce2c4e5@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb34afa-8a38-4124-9384-9b858ce2c4e5@habana.ai>

On Mon, Jun 17, 2024 at 05:43:49PM +0000, Omer Shpigelman wrote:
> On 6/13/24 22:18, Leon Romanovsky wrote:
> > [Some people who received this message don't often get email from leon@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Thu, Jun 13, 2024 at 11:22:04AM +0300, Omer Shpigelman wrote:
> >> Add an RDMA driver of Gaudi ASICs family for AI scaling.
> >> The driver itself is agnostic to the ASIC in action, it operates according
> >> to the capabilities that were passed on device initialization.
> >> The device is initialized by the hbl_cn driver via auxiliary bus.
> >> The driver also supports QP resource tracking and port/device HW counters.
> >>
> >> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> >> Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> >> Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> >> Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> >> Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> >> Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> >> Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> >> Co-developed-by: David Meriin <dmeriin@habana.ai>
> >> Signed-off-by: David Meriin <dmeriin@habana.ai>
> >> Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> >> Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> >> Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> >> Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> > 
> > I afraid that you misinterpreted the "Co-developed-by" tag. All these
> > people are probably touch the code and not actually sit together at
> > the same room and write the code together. So, please remove the
> > extensive "Co-developed-by" tags.
> > 
> > It is not full review yet, but simple pass-by-comments.
> > 
> 
> Actually except of two, all of the mentioned persons sat in the same room
> and developed the code together.
> The remaining two are located on a different site (but also together).
> Isn't that what "Co-developed-by" tag for?
> I wanted to give them credit for writing the code but I can remove if it's
> not common.

Signed-off-by will be enough to give them credit. 

> 
> >> ---
> >>  MAINTAINERS                              |   10 +
> >>  drivers/infiniband/Kconfig               |    1 +
> >>  drivers/infiniband/hw/Makefile           |    1 +
> >>  drivers/infiniband/hw/hbl/Kconfig        |   17 +
> >>  drivers/infiniband/hw/hbl/Makefile       |    8 +
> >>  drivers/infiniband/hw/hbl/hbl.h          |  326 +++
> >>  drivers/infiniband/hw/hbl/hbl_main.c     |  478 ++++
> >>  drivers/infiniband/hw/hbl/hbl_verbs.c    | 2686 ++++++++++++++++++++++
> >>  include/uapi/rdma/hbl-abi.h              |  204 ++
> >>  include/uapi/rdma/hbl_user_ioctl_cmds.h  |   66 +
> >>  include/uapi/rdma/hbl_user_ioctl_verbs.h |  106 +
> >>  include/uapi/rdma/ib_user_ioctl_verbs.h  |    1 +
> >>  12 files changed, 3904 insertions(+)
> >>  create mode 100644 drivers/infiniband/hw/hbl/Kconfig
> >>  create mode 100644 drivers/infiniband/hw/hbl/Makefile
> >>  create mode 100644 drivers/infiniband/hw/hbl/hbl.h
> >>  create mode 100644 drivers/infiniband/hw/hbl/hbl_main.c
> >>  create mode 100644 drivers/infiniband/hw/hbl/hbl_verbs.c
> >>  create mode 100644 include/uapi/rdma/hbl-abi.h
> >>  create mode 100644 include/uapi/rdma/hbl_user_ioctl_cmds.h
> >>  create mode 100644 include/uapi/rdma/hbl_user_ioctl_verbs.h
> > 
> > <...>
> > 
> >> +#define hbl_ibdev_emerg(ibdev, format, ...)  ibdev_emerg(ibdev, format, ##__VA_ARGS__)
> >> +#define hbl_ibdev_alert(ibdev, format, ...)  ibdev_alert(ibdev, format, ##__VA_ARGS__)
> >> +#define hbl_ibdev_crit(ibdev, format, ...)   ibdev_crit(ibdev, format, ##__VA_ARGS__)
> >> +#define hbl_ibdev_err(ibdev, format, ...)    ibdev_err(ibdev, format, ##__VA_ARGS__)
> >> +#define hbl_ibdev_warn(ibdev, format, ...)   ibdev_warn(ibdev, format, ##__VA_ARGS__)
> >> +#define hbl_ibdev_notice(ibdev, format, ...) ibdev_notice(ibdev, format, ##__VA_ARGS__)
> >> +#define hbl_ibdev_info(ibdev, format, ...)   ibdev_info(ibdev, format, ##__VA_ARGS__)
> >> +#define hbl_ibdev_dbg(ibdev, format, ...)    ibdev_dbg(ibdev, format, ##__VA_ARGS__)
> >> +
> >> +#define hbl_ibdev_emerg_ratelimited(ibdev, fmt, ...)         \
> >> +     ibdev_emerg_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +#define hbl_ibdev_alert_ratelimited(ibdev, fmt, ...)         \
> >> +     ibdev_alert_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +#define hbl_ibdev_crit_ratelimited(ibdev, fmt, ...)          \
> >> +     ibdev_crit_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +#define hbl_ibdev_err_ratelimited(ibdev, fmt, ...)           \
> >> +     ibdev_err_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +#define hbl_ibdev_warn_ratelimited(ibdev, fmt, ...)          \
> >> +     ibdev_warn_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +#define hbl_ibdev_notice_ratelimited(ibdev, fmt, ...)                \
> >> +     ibdev_notice_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +#define hbl_ibdev_info_ratelimited(ibdev, fmt, ...)          \
> >> +     ibdev_info_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +#define hbl_ibdev_dbg_ratelimited(ibdev, fmt, ...)           \
> >> +     ibdev_dbg_ratelimited(ibdev, fmt, ##__VA_ARGS__)
> >> +
> > 
> > Please don't redefine the existing macros. Just use the existing ones.
> > 
> > 
> > <...>
> > 
> 
> That's a leftover from some debug code. I'll remove.
> 
> >> +     if (hbl_ib_match_netdev(ibdev, netdev))
> >> +             ib_port = hbl_to_ib_port_num(hdev, netdev->dev_port);
> >> +     else
> >> +             return NOTIFY_DONE;
> > 
> > It is not kernel coding style. Please write:
> > if (!hbl_ib_match_netdev(ibdev, netdev))
> >     return NOTIFY_DONE;
> > 
> > ib_port = hbl_to_ib_port_num(hdev, netdev->dev_port);
> > 
> 
> I'll fix the code, thanks.
> 
> >> +
> > 
> > <...>
> > 
> >> +static int hbl_ib_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
> >> +{
> >> +     struct hbl_aux_dev *aux_dev = container_of(adev, struct hbl_aux_dev, adev);
> >> +     struct hbl_ib_aux_ops *aux_ops = aux_dev->aux_ops;
> >> +     struct hbl_ib_device *hdev;
> >> +     ktime_t timeout;
> >> +     int rc;
> >> +
> >> +     rc = hdev_init(aux_dev);
> >> +     if (rc) {
> >> +             dev_err(&aux_dev->adev.dev, "Failed to init hdev\n");
> >> +             return -EIO;
> >> +     }
> >> +
> >> +     hdev = aux_dev->priv;
> >> +
> >> +     /* don't allow module unloading while it is attached */
> >> +     if (!try_module_get(THIS_MODULE)) {
> > 
> > This part makes wonder, what are you trying to do here? What doesn't work for you
> > in standard driver core and module load mechanism?
> > 
> 
> Before auxiliary bus was introduced, we used EXPORT_SYMBOLs for inter
> driver communication. That incremented the refcount of the used module so
> it couldn't be removed while it is in use.
> Auxiliary bus usage doesn't increment the used module refcount and hence
> the used module can be removed while it is in use and that's something
> we don't want to allow.
> We could solve it by some global locking or in_use atomic but the most
> simple and clean way is just to increment the used module refcount on
> auxiliary device probe and decrement it on auxiliary device removal.

No, you was supposed to continue to use EXPORT_SYMBOLs and don't
invent auxiliary ops structure (this is why you lost module
reference counting).

> 
> >> +             dev_err(hdev->dev, "Failed to increment %s module refcount\n",
> >> +                     module_name(THIS_MODULE));
> >> +             rc = -EIO;
> >> +             goto module_get_err;
> >> +     }
> >> +
> >> +     timeout = ktime_add_ms(ktime_get(), hdev->pending_reset_long_timeout * MSEC_PER_SEC);
> >> +     while (1) {
> >> +             aux_ops->hw_access_lock(aux_dev);
> >> +
> >> +             /* if the device is operational, proceed to actual init while holding the lock in
> >> +              * order to prevent concurrent hard reset
> >> +              */
> >> +             if (aux_ops->device_operational(aux_dev))
> >> +                     break;
> >> +
> >> +             aux_ops->hw_access_unlock(aux_dev);
> >> +
> >> +             if (ktime_compare(ktime_get(), timeout) > 0) {
> >> +                     dev_err(hdev->dev, "Timeout while waiting for hard reset to finish\n");
> >> +                     rc = -EBUSY;
> >> +                     goto timeout_err;
> >> +             }
> >> +
> >> +             dev_notice_once(hdev->dev, "Waiting for hard reset to finish before probing IB\n");
> >> +
> >> +             msleep_interruptible(MSEC_PER_SEC);
> >> +     }
> > 
> > The code above is unexpected.
> > 
> 
> We have no control on when the user insmod the IB driver. 

It is not true, this is controlled through module dependencies
mechanism.

> As a result it is possible that the IB auxiliary device will be probed
> while the compute device is under reset (due to some HW error).

No, it is not possible. If you structure your driver right.

Thanks

