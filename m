Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1783A119A6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEBNDH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 09:03:07 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46862 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEBNDH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 May 2019 09:03:07 -0400
Received: by mail-yw1-f65.google.com with SMTP id v15so1445521ywe.13
        for <linux-rdma@vger.kernel.org>; Thu, 02 May 2019 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hI4WW6CI9V9ZOJkFi1WbTAkXzplbag8K/GeOrZJaEB4=;
        b=i/DytB2TDY7JRpkMm6eNFbZWgh4u9AHkYc83pe28M6IUwICSPCq6FRSv+9oXcOtLSX
         U0oi3uvVCF9vM4p5S1steJNWPd8to1C5THYYh3ia1FmS/G1PC85i0sjCJSbEXAkExu0g
         ZiiH5EEgAcu6y8iNhCfZaBDN3TOERlpEmGAsV5GTLmfmPWx0fItGZ9i3TKP4z1JZs1dD
         4Hz/gfHbKEPvOUXKOPm11JET80fX+DBn0QB5uYuo8hhXsOZ/pgXSacz5aoMeP4m5xvFF
         FTinUnwN0I8hAmfReaYdBtIBq4E2Yl5Mr3qAlPIkwbZe4lq8Xd7w3KDwPSn98TZEdEqW
         TFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hI4WW6CI9V9ZOJkFi1WbTAkXzplbag8K/GeOrZJaEB4=;
        b=hzJqZw98/cK/6GPTH4P2D/xFZMCUxADD0F3mrlBQtX9nBlWWsPyywggTeQ+Exhncgl
         QFMFEdD5748PkJ+4PrjjGTcyMpnZEp3WRIXvNK6rKBELGfVB2j8gE8t7nNddz0C5FNXx
         az16v0PTHYJNTgmmTRtP/kIP4vlLuQlytJZyIlPfo+YcMofuJAk6xtWCUMdjB9nOrakw
         C9H9yVTBPayZcYr/XNvB15/g0UnNPEdyjbaRcB4L+4xoj+C4yB6HDsHlliXBrBs5XL/d
         8y6038SSoHPvUwIZwtcp6FERr32q2pXIk4gXBfjhGLH9vBv9uhycxEWlTfaJMs2HpREv
         bzPQ==
X-Gm-Message-State: APjAAAU6LE4VzLRWelRhpt+/I0cQyrbG5qvTGxFXtTxj7W7yb170u99S
        gpQQFS+5tsOW0N9wTiHnoGbiiCKTJmQ=
X-Google-Smtp-Source: APXvYqzFLghJWeB+ktgA4jqUBHrJW6rUMjpc7MAC1LzZ7g0fDocCTyylqQbLiiHYQY92jdf3p0xI6g==
X-Received: by 2002:a25:7c3:: with SMTP id 186mr2761298ybh.97.1556802186870;
        Thu, 02 May 2019 06:03:06 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id m62sm3264211ywm.105.2019.05.02.06.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 06:03:05 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hMBMe-0004yo-Jz; Thu, 02 May 2019 10:03:04 -0300
Date:   Thu, 2 May 2019 10:03:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     Leon Romanovsky <leon@kernel.org>, oulijun <oulijun@huawei.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add support function clear when
 removing module
Message-ID: <20190502130304.GB18518@ziepe.ca>
References: <1555154941-55510-1-git-send-email-oulijun@huawei.com>
 <20190416121634.GA12981@mtr-leonro.mtl.com>
 <4d3613c7-1c68-9f9b-d185-ab015049e6cf@huawei.com>
 <20190422122209.GD27901@mtr-leonro.mtl.com>
 <add43d02-b3d5-35d9-a74d-8254c1fb472c@huawei.com>
 <20190423152339.GE27901@mtr-leonro.mtl.com>
 <90a91e1f-91fc-bc4e-067c-7bc788c62ab6@huawei.com>
 <20190426143656.GA2278@ziepe.ca>
 <20190426210520.GA6705@mtr-leonro.mtl.com>
 <99195660-be8d-555f-01fc-efd9e680fdf3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99195660-be8d-555f-01fc-efd9e680fdf3@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 04:27:41PM +0800, Liuyixian (Eason) wrote:
> 
> 
> On 2019/4/27 5:05, Leon Romanovsky wrote:
> > On Fri, Apr 26, 2019 at 11:36:56AM -0300, Jason Gunthorpe wrote:
> >> On Fri, Apr 26, 2019 at 06:12:11PM +0800, Liuyixian (Eason) wrote:
> >>
> >>>     However, I have talked with our chip team about function clear
> >>>     functionality. We think it is necessary to inform the chip to
> >>>     perform the outstanding task and some cleanup work and restore
> >>>     hardware resources in time when rmmod ko. Otherwise, it is
> >>>     dangerous to reuse the hardware as it can not guarantee those
> >>>     work can be done well without the notification from our driver.
> >>
> >> If it is dangerous to reuse the hardware then you have to do this
> >> cleanup on device startup, not on device removal.
> > 
> > Right, I can think about gazillion ways to brick such HW.
> > The simplest way will be to call SysRq during RDMA traffic
> > and no cleanup function will be called in such case.
> > 
> > Thanks
> 
> Hi Jason and Leon,
> 
> 	As hip08 is a fake pcie device, we could not disassociate and stop the hardware access
> 	through the chain break mechanism as a real pcie device. Alternatively, function clear
> 	is used as a notification to the hardware to stop accessing and ensure to not read or
> 	write DDR later. That is, the role of function clear to hip08 is similar as the chain
> 	break to pcie device.

What? This hardware is broken and doesn't respond to the bus master
enable bit in the PCI config space??

Jason
