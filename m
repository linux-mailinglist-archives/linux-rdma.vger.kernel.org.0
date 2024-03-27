Return-Path: <linux-rdma+bounces-1619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7544B88ED60
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA82A8828
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9C1514DE;
	Wed, 27 Mar 2024 17:55:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EC4AE1514CE
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562115; cv=none; b=YMkUAxt1KoCWjfrFktgZ9Ti5DWjeMp174OsUVtQGAMNrs86uWZAggE7MJu9wl7a92yJmMMPzUTSersvH/c7ycA2dubQrTQ7n4WsKd6VBgGcsJemVckSuGv7nxmjb5tVN2ObjhEKwazUTnzkJ9McaLu0JshIc+muecD1OdZHEPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562115; c=relaxed/simple;
	bh=2em/62sKNa2uOySIrx3SPAGa+oAkz9sarrrAbR/FclA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipn/3Jkxzwc5oc8eIGxx2mebb7at2TWXT+4Y7mdzHKhN3fupUHhy6Y6tk7hX0yjLaqeaoDgoz136qfpruR4psBvU3N3GctL49Vk5cZPA4/WK98w+kIzR8fbKZ41P5XQvzQO/OD6g7w0+2m8Y60KfRr1+kHjHpIz8pcQLUQW2Kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 935614 invoked by uid 1000); 27 Mar 2024 13:55:00 -0400
Date: Wed, 27 Mar 2024 13:55:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
  vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev,
  florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com,
  paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
  manivannan.sadhasivam@linaro.org, vireshk@kernel.org, Frank.Li@nxp.com,
  leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com,
  haijie1@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
  sean.wang@mediatek.com, matthias.bgg@gmail.com,
  angelogioacchino.delregno@collabora.com, afaerber@suse.de,
  logang@deltatee.com, daniel@zonque.org, haojian.zhuang@gmail.com,
  robert.jarzmik@free.fr, andersson@kernel.org, konrad.dybcio@linaro.org,
  orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
  patrice.chotard@foss.st.com, linus.walleij@linaro.org, wens@csie.org,
  jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com, kys@microsoft.com,
  haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
  jassisinghbrar@gmail.com, mchehab@kernel.org, maintainers@bluecherrydvr.com,
  aubin.constans@microchip.com, ulf.hansson@linaro.org,
  manuel.lauss@gmail.com, mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com,
  oakad@yahoo.com, hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
  brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu,
  duncan.sands@free.fr, oneukum@suse.com,
  openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
  asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
  linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
  imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
  linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org,
  linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
  linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
  linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
  linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
  linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
  linux-s390@vger.kernel.org, netdev@vger.kernel.org,
  linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/9] USB: Convert from tasklet to BH workqueue
Message-ID: <42c445b4-a156-4c43-bf98-bd2a9ac7a4fa@rowland.harvard.edu>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-5-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327160314.9982-5-apais@linux.microsoft.com>

On Wed, Mar 27, 2024 at 04:03:09PM +0000, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.
> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---

> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index c0e005670d67..88d8e1c366cd 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c

> @@ -1662,10 +1663,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>  	usb_put_urb(urb);
>  }
>  
> -static void usb_giveback_urb_bh(struct work_struct *work)
> +static void usb_giveback_urb_bh(struct work_struct *t)
>  {
> -	struct giveback_urb_bh *bh =
> -		container_of(work, struct giveback_urb_bh, bh);
> +	struct giveback_urb_bh *bh = from_work(bh, t, bh);
>  	struct list_head local_list;
>  
>  	spin_lock_irq(&bh->lock);

Is there any reason for this apparently pointless change of a local
variable's name?

Alan Stern

