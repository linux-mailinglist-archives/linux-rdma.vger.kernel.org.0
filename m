Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1BA19572C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0Mgp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 08:36:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37510 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Mgp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 08:36:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id x3so10532550qki.4
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2020 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fuWoohX/XqCbV9IjPWAnshNnLgyLLeXGtate+NUqmTE=;
        b=Tv4z/HTa+q1HhDO9N5rGq+VqYchKqn0WDODY3hVOIBJj84iOrvaNfxy4lOdqnKQbdn
         gYCR6Zey5xdV8qVK55QLzit0ggxH7QsKHWxVRvqvPR3ak3FlOfeQQFM9GonA7vX4wOgU
         JWif+68Y8mCgG1lTYW/yYmWRZEuO2az5xFhhpO8oP2uFLuGfCK1szAEWdjG93vAuISVO
         tUN/ZZXavwQYvQAVWJKkmK1ZS3isYU5h3AA2xo2G+VM48iYmXYoEocLDwk/Ih5K+URYA
         JEd5uudHbprot23Cys+BU1VLmfsz9g3/Qv9ptjWdNnQd1ZeWXvj4Hv+EdUyX4o3/vKsP
         +MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fuWoohX/XqCbV9IjPWAnshNnLgyLLeXGtate+NUqmTE=;
        b=pT5aAhlKDYUKbwKe7NWEI3+6f5cNgQJO/zjGdd2pVQTpQiOyN+3uAmyAABS6J02ND+
         uELpp0SfpzGEiWl+tFK49Jc9MViPUWybxkVx6//2M8js2mU4yDtfoJxIie6MQW/tShcZ
         DDtxr5eA11wPRwWRC6y+hMBHXDtIwMjPaAESY9cAx6SMwvC2byHLParJ86PX4qnGk4Wj
         Yz9NuLSpweCkH3X9Pc28u3Y9k00Jbi5lbfascy+lQG6xZ+JVDbJwdFOj8eFwwzrwUgIP
         xCBcn4AiVko+4sS1D7DnYJEbE9TjE58bDiG1FIwZOy5+PI97fU8GH6q7AVcOODG2QxMM
         6xhQ==
X-Gm-Message-State: ANhLgQ2nya3/bdX2fRnCsEhaRPEiUapTTnIz9U21neTZiW14A8um4hwS
        GQ3KXHCqGAOSsE+pMCzg/oe8xA==
X-Google-Smtp-Source: ADFU+vvBZCMRKDopbcMK7ramBp2OrFhGpAx1qHSbCS8HR5mQ77eJVJeRQ+AkT/se/1MhyIc5gfm+ZQ==
X-Received: by 2002:a37:85c2:: with SMTP id h185mr13529418qkd.446.1585312604142;
        Fri, 27 Mar 2020 05:36:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s188sm3560767qkh.67.2020.03.27.05.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 05:36:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHoE6-0007pk-SB; Fri, 27 Mar 2020 09:36:42 -0300
Date:   Fri, 27 Mar 2020 09:36:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 04/10] RDMA/hns: Optimize
 hns_roce_alloc_vf_resource()
Message-ID: <20200327123642.GT20941@ziepe.ca>
References: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
 <1584674622-52773-5-git-send-email-liweihang@huawei.com>
 <20200326195135.GA27277@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A022B650A@DGGEML502-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A022B650A@DGGEML502-MBS.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 07:09:02AM +0000, liweihang wrote:
> On 2020/3/27 3:51, Jason Gunthorpe wrote:
> > On Fri, Mar 20, 2020 at 11:23:36AM +0800, Weihang Li wrote:
> > 
> >> @@ -2028,6 +2002,13 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
> >>  	if (ret)
> >>  		set_default_caps(hr_dev);
> >>  
> >> +	ret = hns_roce_alloc_vf_resource(hr_dev);
> >> +	if (ret) {
> >> +		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
> >> +			ret);
> >> +		return ret;
> >> +	}
> > 
> > It is unfortunate these have to remain as dev_err()
> > 
> > I've thought about setting the name during ib_alloc_dev, which would
> > avoid this, what do you think?
> > 
> > Jason
> > 
> 
> Hi Jason,
> 
> Thanks for your comments. I agree with you and make a simple test by just
> moving assign_name() into _ib_alloc_device(), and ibdev_*() works fine
> anywhere in hns. But I'm not sure if there are any side effects.

Hmm. It actually looks like it should work now, older versions may
have had problems, but this looks OK.

Jason
