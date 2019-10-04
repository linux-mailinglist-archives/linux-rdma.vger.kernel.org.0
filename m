Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97913CC289
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJDSWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:22:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44536 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDSWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:22:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so9788706qth.11
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mU49j0lfhMFj7hUttZfcX6DylFbtTAIERCNzye+6z38=;
        b=Wzjg9CbnQEzbO80GNOfpmUTz7XCN4X7xb8D7ywz57ginZSgVZGjYNVTj5j9wHxlElC
         Z/Fo/1/6cQ0IcqJDpnlmyayCKIBMXnokWNblPK2n7TbGyof1a4tLdxToT45Cg0MlxPU0
         tNg/YQqka0gN/0RqqpMF+nw04dLkIYMuQTt2UpSVmtCBfx+BXH/yUX+EZLKsrmA7h+DD
         IofvmdcWzHqF9g8w+vB7w3kjLOMmY/6zlRnIAEB1r3+piew+vbxQFf+D8uKf1D1RYtBE
         6R4tioXsbyH1wdH/bbJD8HjEiguYqL7oVm5iGlyly+MI59alIHU18yUoHkz7vlD0zAPV
         0/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mU49j0lfhMFj7hUttZfcX6DylFbtTAIERCNzye+6z38=;
        b=X9AUBJ4HoUicNmQCbG8Feo3gXMxg1KFPyPp7bz+cHdUy7+UXG7t1R6A+DW+qCkFn3S
         PuHNEF7lp1Q7B7iKCzMjWjffUDAw8PRVhCLHt48BvEs/xuYhSVMwfBClaLxWkQLlxbii
         pXEHMCIfGcjmwV0meMnwgbF21hdQGpzMitWeA+z6WS9NzhGGfZfR1/A1Qb3Tm5qAAjH2
         UsACnEx+oo9m90O4X6npHdR1hM158I/mJtORH3kVesZlTBT2N90/ME8UxI/HTC0OvJar
         YPOd1uADw2XYn9FpmKx+9SzfjjcwQJxhcd06NIZVDCvp07ADHhDUH/e/NHS5j2NvrSIO
         6heg==
X-Gm-Message-State: APjAAAXOgMtY/iDO2Yd30uPxocL0KkOVSy77NJiU1fcqynPe59dc1SPo
        DmIYvKWkcZqcRjWFzJo5mMHx2Q==
X-Google-Smtp-Source: APXvYqyqW5xHLjupkFvSb8vnS2s+rtmhM3eThUEIqXxxbojJrKpHv+4FglF7E1T4UVo/LjhgZKnLsw==
X-Received: by 2002:aed:2ae6:: with SMTP id t93mr17322402qtd.384.1570213368219;
        Fri, 04 Oct 2019 11:22:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c18sm2808233qkk.17.2019.10.04.11.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:22:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGSE3-0007SM-9v; Fri, 04 Oct 2019 15:22:47 -0300
Date:   Fri, 4 Oct 2019 15:22:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/2] {topost} RDMA/hns: Deliver net device event
 to ofed
Message-ID: <20191004182247.GA28419@ziepe.ca>
References: <1570184954-21384-1-git-send-email-liweihang@hisilicon.com>
 <1570184954-21384-2-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570184954-21384-2-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 06:29:13PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Driver can notify ULP with IB event when net link down/up.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>  drivers/infiniband/hw/hns/hns_roce_device.h | 12 +++++++++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 40 +++++++++++++++++++++--------
>  2 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 05d375a..47c209f 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -711,6 +711,7 @@ struct hns_roce_ib_iboe {
>  	struct net_device      *netdevs[HNS_ROCE_MAX_PORTS];
>  	struct notifier_block	nb;
>  	u8			phy_port[HNS_ROCE_MAX_PORTS];
> +	enum ib_port_state	port_state[HNS_ROCE_MAX_PORTS];
>  };
>  
>  enum {
> @@ -1135,6 +1136,17 @@ static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
>  		       (offset & (page_size - 1));
>  }
>  
> +static inline u8 to_rdma_port_num(u8 phy_port_num)
> +{
> +	return phy_port_num + 1;
> +}
> +
> +static inline enum ib_port_state get_port_state(struct net_device *net_dev)
> +{
> +	return (netif_running(net_dev) && netif_carrier_ok(net_dev)) ?
> +		IB_PORT_ACTIVE : IB_PORT_DOWN;
> +}
> +
>  int hns_roce_init_uar_table(struct hns_roce_dev *dev);
>  int hns_roce_uar_alloc(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
>  void hns_roce_uar_free(struct hns_roce_dev *dev, struct hns_roce_uar *uar);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 665ce24..742a36e 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -103,10 +103,13 @@ static int hns_roce_del_gid(const struct ib_gid_attr *attr, void **context)
>  }
>  
>  static int handle_en_event(struct hns_roce_dev *hr_dev, u8 port,
> -			   unsigned long event)
> +			   unsigned long dev_event)
>  {
>  	struct device *dev = hr_dev->dev;
> +	enum ib_port_state port_state;
>  	struct net_device *netdev;
> +	struct ib_event event;
> +	unsigned long flags;
>  	int ret = 0;
>  
>  	netdev = hr_dev->iboe.netdevs[port];
> @@ -115,20 +118,38 @@ static int handle_en_event(struct hns_roce_dev *hr_dev, u8 port,
>  		return -ENODEV;
>  	}
>  
> -	switch (event) {
> -	case NETDEV_UP:
> -	case NETDEV_CHANGE:
> +	switch (dev_event) {
>  	case NETDEV_REGISTER:
>  	case NETDEV_CHANGEADDR:
>  		ret = hns_roce_set_mac(hr_dev, port, netdev->dev_addr);
>  		break;
> +	case NETDEV_UP:
> +	case NETDEV_CHANGE:
> +		ret = hns_roce_set_mac(hr_dev, port, netdev->dev_addr);
> +		if (ret)
> +			return ret;
> +		/* port up/down events need send ib events */
>  	case NETDEV_DOWN:
> -		/*
> -		 * In v1 engine, only support all ports closed together.
> -		 */
> +		port_state = get_port_state(netdev);
> +
> +		spin_lock_irqsave(&hr_dev->iboe.lock, flags);
> +		if (hr_dev->iboe.port_state[port] == port_state) {
> +			spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
> +			return NOTIFY_DONE;
> +		}
> +		hr_dev->iboe.port_state[port] = port_state;
> +		spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
> +
> +		event.device = &hr_dev->ib_dev;
> +		event.event = (port_state == IB_PORT_ACTIVE) ?
> +			      IB_EVENT_PORT_ACTIVE : IB_EVENT_PORT_ERR;
> +		event.element.port_num = to_rdma_port_num(port);
> +		ib_dispatch_event(&event);
> +		break;

Every roce driver shouldn't have this kind of stuff, please try to
make a version to add this to the core code. Now that we have the
ib_device_set_netdev() it should be possible

Also, this driver should be using ib_device_set_netdev and the sketchy
code in hns_roce_netdev_event() removed

Jason
