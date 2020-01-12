Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2FFE1388D2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 00:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgALXy4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jan 2020 18:54:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40042 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgALXy4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jan 2020 18:54:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so7656928qto.7
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jan 2020 15:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QECIxvXldhkMJFt0djz6qtJ/uPYPO1s9x56W6TJ6wzo=;
        b=SpLegbzOveTbs+ZOtT+k6RWf2vdDMJuG3gB5bR8kFxxQdenmqVPhSDBN9SvMhuA62K
         F6D1CPtyMpVMDV89mgv9eQsutM0RHdE04KAEBzkh6q7pdoyK638sBTLxQHFga5MsKuYU
         B/UNe+ziZlxnKPic7vK1qcgU/Yul1zMlxqTsgyZz4f03Wk8JV3wWtm6PBbXEfhS22fKK
         Yn7R4FCKp6lTZXMmprhQUGkMgbCniLoVTEYuNQWjtD3+5rixwfeIP5x9fYCPfbRVAwMt
         +GnbCRtm+qecsJSsBx0sGZoQ6HdO8gOignRD6rJjG7m3PTGOee02y0x827zvmSN5SrCh
         NVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QECIxvXldhkMJFt0djz6qtJ/uPYPO1s9x56W6TJ6wzo=;
        b=NFHos+bIP75yWvAl+tAjDSp4yxUl++48DcCU6wybZZfQFBE4B9Z4IvKtBjEIesIDAI
         GTiZlk/TxhCY8jB5f8tNnEtkGo4X1Oiik5Fl5CbP/1w7Y3ZOUedIgQVQ26e8Z/VFg14D
         JRpix11QNZhnhQk2bTDbBKrpurGJGo5z+Ga0pBLzMSeDbyuse0Pp4IEkgU39q4AxJWAS
         vVz2NzdHhby0UTBjbrrxhD8z/4KzVpkFdB/ZxiGddxpqiktcQt6bPdMAJbE+DKPavr56
         ma/r3z0yHyuZWQ/EqTTj+5f41YdwOcYJ1qXY4XR+Vdk80GO2MueQ3ryY2E+0V1RvD8Hs
         Jm3g==
X-Gm-Message-State: APjAAAWAzT7Z5zzn3bcc9Fzdx1WptvH3wyn10ZWundSh5tzRpfcVsdoK
        oiPlqGZqjMprWIQvY8k3hpk0Ng==
X-Google-Smtp-Source: APXvYqw0HF3THv3cEhFsjUx4gokaXgXA4wvGXQ/CnZgRdvb3tRdwInZCk1qTVjtITXmqbxoLhnkEIg==
X-Received: by 2002:ac8:1aeb:: with SMTP id h40mr8262135qtk.269.1578873295622;
        Sun, 12 Jan 2020 15:54:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f5sm4192976qke.109.2020.01.12.15.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jan 2020 15:54:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iqn4I-0008Ht-8U; Sun, 12 Jan 2020 19:54:54 -0400
Date:   Sun, 12 Jan 2020 19:54:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shahaf Shuler <shahafs@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/5] VIRTIO_NET Emulation Offload
Message-ID: <20200112235454.GA20866@ziepe.ca>
References: <20191212110928.334995-1-leon@kernel.org>
 <20200107193744.GB18256@ziepe.ca>
 <20200110183041.GA6871@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110183041.GA6871@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 10, 2020 at 08:30:41PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 07, 2020 at 03:37:44PM -0400, Jason Gunthorpe wrote:
> > On Thu, Dec 12, 2019 at 01:09:23PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > Hi,
> > >
> > > In this series, we introduce VIRTIO_NET_Q HW offload capability, so SW will
> > > be able to create special general object with relevant virtqueue properties.
> > >
> > > This series is based on -rc patches:
> > > https://lore.kernel.org/linux-rdma/20191212100237.330654-1-leon@kernel.org
> > >
> > > Thanks
> > >
> > > Yishai Hadas (5):
> > >   net/mlx5: Add Virtio Emulation related device capabilities
> > >   net/mlx5: Expose vDPA emulation device capabilities
> >
> > This series looks OK enough to me. Saeed can you update the share
> > branch with the two patches?
> 
> Merged, thanks,
> 
> ca1992c62cad net/mlx5: Expose vDPA emulation device capabilities
> 90fbca595243 net/mlx5: Add Virtio Emulation related device capabilities

Done, thanks

Jason
