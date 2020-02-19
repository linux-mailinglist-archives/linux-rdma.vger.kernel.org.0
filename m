Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF299165139
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 22:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBSVDT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 16:03:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43863 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbgBSVDS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 16:03:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id g21so1291474qtq.10
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 13:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkAvIv9voUozui7Cl2Isi3jhnpjuOa5mtx2YnUoNWHg=;
        b=K2Ka/YLmqbncQy5+9hplvo26ik5IC7UCQQ9Felh629aJLI0cc6P4twrsg/vaY/xMwn
         i2uNfZrWWQddQKkRiLChgO/FurGoMdEL3i4+rZsvWwQkMyJULAQhHFkBni/xo38R9Uzo
         /7jQPBizMlBk8MtFGfJDI79bMXbSNFWc0PZsHPIEd72JBzRuS3eru22vxYb0JeEFuNes
         D+cYg2sQsjseN001FAsv5sw6OBpM2zeBlQiXXYhIcA15oku01EPmvs2C8mG8APNigbk/
         HoodA+TieQrd+DlYjaXbD6Nto+ka8WJEuuO27j+V7LMdI6dtvIqVoK01tt5dLdtPtTTg
         dk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkAvIv9voUozui7Cl2Isi3jhnpjuOa5mtx2YnUoNWHg=;
        b=KwHoKX2RkLq82sY2f2Sr0EUOZdfI65DImjDMIApf3kGMTV+035FVfvPC3DJnSRtH6Z
         6kVDOJ38GLQ5zpy6m+jhFf7J1lMbLbDmaTIN307AQnanhIY86ms4f2a6SK50koumX+wu
         9dRAFwOnLiYBhLXM0XWIKuT5QAtymq1wzkYZkf/QZny4BYQgeDhUtpZfWiUCh9Lhx943
         pWkt4lI6+hoED++Jqq6r2QtTRf5MgPJgCXuSqhTCR5EFSLcfLKYFismX08x4P47fEq2s
         TQqHDAM2Ebr1UtMnZL0XzsaP/+wCXsO7kOY5HaFk8nIGi6g5+X77DbXzVYKHCYd7VBT2
         XaiQ==
X-Gm-Message-State: APjAAAVQVJv8z9kbMv0j0FFwIqJ/clqwISeCcnUkkmCQxU0I15uOknqe
        OoA02YxFm+rOHg/zWP0I9mmpRA==
X-Google-Smtp-Source: APXvYqwTSZQSFPMGsN+P3XSPVhVJloGUcenVaEUqZpI21uNkRTwN6F7d4MC22cOzWHnQhhqdznG11A==
X-Received: by 2002:ac8:4b70:: with SMTP id g16mr23511529qts.296.1582146197000;
        Wed, 19 Feb 2020 13:03:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u12sm481284qke.67.2020.02.19.13.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 13:03:16 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WV2-00071A-5n; Wed, 19 Feb 2020 17:03:16 -0400
Date:   Wed, 19 Feb 2020 17:03:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH RFC v2 for-next 2/7] RDMA/mlx5: remove deliver net device
 event
Message-ID: <20200219210316.GZ31668@ziepe.ca>
References: <20200204082408.18728-1-liweihang@huawei.com>
 <20200204082408.18728-3-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204082408.18728-3-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:24:03PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The code that handles the link event of the net device has been moved into
> the core, and the related processing should been removed from the provider
> driver.

It has? How?

> @@ -219,52 +177,10 @@ static int mlx5_netdev_event(struct notifier_block *this,
>  		write_unlock(&roce->netdev_lock);
>  		break;
>  
> -	case NETDEV_CHANGE:
> -	case NETDEV_UP:
> -	case NETDEV_DOWN: {
> -		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
> -		struct net_device *upper = NULL;
> -
> -		if (lag_ndev) {
> -			upper = netdev_master_upper_dev_get(lag_ndev);
> -			dev_put(lag_ndev);
> -		}
> -
> -		if (ibdev->is_rep)
> -			roce = mlx5_get_rep_roce(ibdev, ndev, &port_num);
> -		if (!roce)
> -			return NOTIFY_DONE;
> -		if ((upper == ndev || (!upper && ndev == roce->netdev))
> -		    && ibdev->ib_active) {
> -			struct ib_event ibev = { };
> -			enum ib_port_state port_state;
> -
> -			if (get_port_state(&ibdev->ib_dev, port_num,
> -					   &port_state))
> -				goto done;
> -
> -			if (roce->last_port_state == port_state)
> -				goto done;
> -
> -			roce->last_port_state = port_state;
> -			ibev.device = &ibdev->ib_dev;
> -			if (port_state == IB_PORT_DOWN)
> -				ibev.event = IB_EVENT_PORT_ERR;
> -			else if (port_state == IB_PORT_ACTIVE)
> -				ibev.event = IB_EVENT_PORT_ACTIVE;
> -			else
> -				goto done;
> -
> -			ibev.element.port_num = port_num;
> -			ib_dispatch_event(&ibev);

Where does the core code do this?

Jason
