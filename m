Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50C4DA40
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfFTTe7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 15:34:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38429 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTTe6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 15:34:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so4415682qtl.5
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 12:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jPIjUEL5I8rcfuVAL1CCQrb3ict55koQe3YtFVmqSyA=;
        b=cbUbFm84noEiYcrG3avU5qCIILujcvmIvvv9IZxcSz/kq5ViK/YulNwajXDvOZPOXR
         uS3qcL+SCM89JMmoHVh5NvpODz1ZqEK4dEuOpNATimfWFu13jAWyuXh2kAUYR6Hchf4R
         8SJ2t05yLQJU4I2wFG8jBjbDO9TSTlE2UQprDjnFUi2gHYQW4F1ysOEvHSAIbCz76hpi
         4+4ljFEyoo6cnneoyhIFVzIHSZrYtWHOaFo+xp3cUkTB0U8zemSZcqwDfNc6R+zHNdp1
         LnW0npBZE9htYBdrCDhdNH/AnOWdiZ2xu0scvZ6C6PgLklav1iAVuhIY/OUwDT/+fIuw
         0jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jPIjUEL5I8rcfuVAL1CCQrb3ict55koQe3YtFVmqSyA=;
        b=SAnT2/YE9NwoHdXuj229ExmDryozN58HEs2y85SDZ6PKFmsihz9kzLd9ja8C3OrQ4C
         QSUP/IKm5cOFfTpGkMXipqhfFGeIMEDuy7slsYE0hgmJp9vknXHR5p/uoNBdb664071r
         s6aC5kcHuvFyECV3xKA6Fl8pZMT6F5d6G2+h+VTEe3ELElgjW0dtWxOFGTPVk3mBIiyu
         tiBTInVKpMvPgcZ+qXmCGJxQ4gU4oz3CqF2lpvWkuCSb2uVDEhh+kdDZpmaQNvtpBqQH
         vVMVmlq9Lu0pVQRAONeKGg9/bTumnzxtgS3z5opMpJ0aOylyltHMegqgK/q6nO31A8NG
         L3cQ==
X-Gm-Message-State: APjAAAVgDe9V0SK2PdeyQBQ0QYiCC489v2hJDzO6QvMRO1RexHiUWejE
        By6f7lPWw5IgO72anwadtM8bDA==
X-Google-Smtp-Source: APXvYqyvpuKDBGC3x0fWi0kGEWJPY3BVqNgfplqjzXqRUCmpRIlURVdDTd/UzV4Yboe7G6GIE9t4kg==
X-Received: by 2002:ac8:2baa:: with SMTP id m39mr52796869qtm.242.1561059298042;
        Thu, 20 Jun 2019 12:34:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g35sm263832qtg.92.2019.06.20.12.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:34:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he2pl-0006et-8q; Thu, 20 Jun 2019 16:34:57 -0300
Date:   Thu, 20 Jun 2019 16:34:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Lijun Ou <oulijun@huawei.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V3 for-next] RDMA/hns: reset function when removing module
Message-ID: <20190620193457.GG19891@ziepe.ca>
References: <1560524163-94676-1-git-send-email-oulijun@huawei.com>
 <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ba310e1cb50abd3810032fc468797edd917c08.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 03:09:37PM -0400, Doug Ledford wrote:
> On Fri, 2019-06-14 at 22:56 +0800, Lijun Ou wrote:
> > From: Lang Cheng <chenglang@huawei.com>
> > 
> > During removing the driver, we needs to notify the roce engine to
> > stop working immediately,and symmetrically recycle the hardware
> > resources requested during initialization.
> > 
> > The hardware provides a command called function clear that can package
> > these operations,so that the driver can only focus on releasing
> > resources that applied from the operating system.
> > This patch implements the call of this command.
> > 
> > Signed-off-by: Lang Cheng <chenglang@huawei.com>
> > Signed-off-by: Lijun Ou <oulijun@huawei.com>
> > V2->V3:
> > 1. Remove other reset state operations that are not related to
> >    function clear
> 
> 
> 
> > +	msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL);
> > +	end = HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS;
> > +	while (end) {
> > +		msleep(HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT);
> > +		end -= HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT;
> 
> 
> 
> > +#define HNS_ROCE_V2_FUNC_CLEAR_TIMEOUT_MSECS	(249 * 2 * 100)
> > +#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
> > +#define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT	20
> 
> I absolutely despise code that does a possible *50* second blocking
> delay using msleep.  However, because I suspect that this is something
> that should *rarely* ever happen, and instead the common case is that
> the reset will proceed much faster, and because this is in the
> teardown/shutdown path of the device where it is a little more
> acceptable to have a blocking delay, I've taken this to for-next.

I've been telling hns they have to do proper locking and wouldn't
accept these stupid msleep loops. No kernel code should ever do that,
it just shows the locking and concurrency model is wrong.

Jason
