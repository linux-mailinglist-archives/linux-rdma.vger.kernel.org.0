Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9235C16AF1A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 19:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBXS3G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 13:29:06 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:39424 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBXS3G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 13:29:06 -0500
Received: by mail-qt1-f181.google.com with SMTP id p34so7218045qtb.6
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 10:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6N4J5ihP4PhGzO1eaHpRcqfn54QHo/qwBYnxwUAJN1s=;
        b=oana4eHPjP0QNo0fedM+QChQlnRGMnKDPZF+G4PdIf1YT/6Wk0LcpYFrMAC3+eaUpm
         xxLke9LKctoQMS5MNzfVCo1/r0s6fi0fi2oEvLuAJIbobn00133+Cis3I6do6OT85mZu
         hNuYJs3RRBWiJm+oh+MxU6oIJ6jadgjaPDHZfq1DnSpVly2BzfaAy0DIw6HGchv2IeOO
         MIRHiGIvk/KwsJr3DuBryXEz+3Rvx+1dYSCur1wl1B/jX06SxJg1E37HPGiyn5GkMQw5
         0szJCXsD4AqNV5gxqDbLQcmDj3idcGRlBns6Ym+R82XgiqClzKNRxi2cDbEC2BSL8IO/
         5zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6N4J5ihP4PhGzO1eaHpRcqfn54QHo/qwBYnxwUAJN1s=;
        b=nLj1tr9Gd5lR1KZzJNf9cHyYCod88thzfBRn9qckr1C0iRx8YTi/L/eQcWarGTqR6c
         MJlWHD1hie4TGnmwWRoyURLD0yUFpql0B7uIWBUDa5MjOHf9giet+sexZVtkAVCrRRQ9
         rpDBYwzAsefDWMXVgj/GZEaDV6NyUibqZBl4fOhIPTf5Kvv6MmwcOy8HNTvifJTt7+kG
         r3VhKmvM4JiO5qadTj8eWw2my152LC1gRKqcnpTat5vHhLFMfpxyLuMp41iujJpL1rjr
         pkyk06TCQDfgCaHNKsm4otIX2FJ+fagMHaEaiPvm9vpj0NCkUb056sVpd5uaFE+Bsut1
         4eHA==
X-Gm-Message-State: APjAAAV4s5zwlNrCWtm7dNNUh+6oxMHqWqzcSmoF5hbJ5wEIIAV7lJUx
        +PoOdbhF5d1R0PmRXXE+qJyJlA==
X-Google-Smtp-Source: APXvYqzMZzGUUS7l5yjX4DqxX1ZBRZNlgyR4122L4py43aiK/1lv7xP4V7nP+QjyYxgUKUd1N7ftDA==
X-Received: by 2002:ac8:5154:: with SMTP id h20mr50511158qtn.43.1582568943955;
        Mon, 24 Feb 2020 10:29:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j18sm363113qka.95.2020.02.24.10.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 10:29:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j6ITW-0004hh-Sy; Mon, 24 Feb 2020 14:29:02 -0400
Date:   Mon, 24 Feb 2020 14:29:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Parav Pandit <parav@mellanox.com>,
        Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Message-ID: <20200224182902.GS31668@ziepe.ca>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
 <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
 <20200224105206.GA468372@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224105206.GA468372@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 12:52:06PM +0200, Leon Romanovsky wrote:
> > Are you asking why bonding should be implemented as dedicated
> > ulp/driver, and not as an extension by the vendor driver?
> 
> No, I meant something different. You are proposing to combine IB
> devices, while keeping netdev devices separated. I'm asking if it is
> possible to combine netdev devices with already existing bond driver
> and simply create new ib device with bond netdev as an underlying
> provider.

Isn't that basically what we do now in mlx5?

Logically the ib_device is attached to the bond, it uses the bond for
IP addressing, etc.

I'm not sure trying to have 3 ib_devices like netdev does is sane,
that is very, very complicated to get everything to work. The ib stuff
just isn't designed to be stacked like that.

Jason
