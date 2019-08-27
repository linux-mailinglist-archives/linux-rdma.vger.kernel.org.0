Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14E59F01F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfH0Q1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 12:27:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42157 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfH0Q1V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 12:27:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id t12so21894923qtp.9
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 09:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lnAKsbXKD7RPlntdvWmMqnSDlV/9SfNV6+qNsMZx1qE=;
        b=FbgrV/dT3r1z1Rc57v9Qf+uj6Yns4EqBXIbLCnGw2bWmIq8rDwdBygEV2vnaYu0kPu
         gfjJuVB87hlqL7AXxQ9lTnxt+WHCCjh+Fcx2Ys6z6roLWd6N8yhxDPMKePNid5e8HLGG
         wBYtUi7fCu2yPOMpuQrWZKjxxhfIJIu/ht1MQGH1GkIwqMNAjAkW5xIESun2SaF3e3oo
         WZI9UbHjUVJT3l4FQWfBXyJGLIfyGy6K8l/rcedBmDY/PHebj023FKWikA6L0zspjfUp
         92uKjwF/iSv2DfwwWX6kguce7dZXL6D3Nmx7vewGCXFNTlAR4t5yAf5tLPeexcBEb1TJ
         cdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lnAKsbXKD7RPlntdvWmMqnSDlV/9SfNV6+qNsMZx1qE=;
        b=Bfu7jGq3wbXVjj3iEl7fIXpW1Ztsuwv5+XBQwaqyyvCjZcvnWUc5nLUD/I8mpvH63O
         3WIdoI4HMH0gkihSS/06HOQkBVyCDk1PP+JyQYNb9Ml1nbaiY0l5w/bIZubVsXp+mTJk
         XaXe2+stemGzFJlJIODxyJE+eTmNRbBoDAgnl/dK2vQtO7+ebN+F1ZI8tRk4Px2cj1us
         g9AgguAlDgKnQV+Z8uIV5A0k1HFruRb976E1kCeqD4jMKNXHMmrwJ7VbFl3oIfhUA3ks
         uAnt2CTC6GPHGKyQP24hZBf9eLXP/xR3ACGan0+WDdGZG60heg9Et1gSa8DFDrYpsKHz
         1pgQ==
X-Gm-Message-State: APjAAAURct3GDB0noI2hUBur0tztPxBYe+QHITsKVnTGvB7BoPWG39Pr
        R+sDtbsrluApEkY+YnaFKWiK2A==
X-Google-Smtp-Source: APXvYqyql8bxQV0/FB90h23PfUVjOUoxcX1fJUbzxMYDmwzWfOkMnMIARbD6dEDr2H7L/c0ocCf7Bg==
X-Received: by 2002:a0c:9bc9:: with SMTP id g9mr20446108qvf.240.1566923241047;
        Tue, 27 Aug 2019 09:27:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id g8sm8649956qti.79.2019.08.27.09.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 09:27:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2eJU-00052e-2w; Tue, 27 Aug 2019 13:27:20 -0300
Date:   Tue, 27 Aug 2019 13:27:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Tatyana Nikolova <Tatyana.E.Nikolova@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/iwpm: Delete =?utf-8?Q?un?=
 =?utf-8?Q?necessary_checks_before_the_macro_call_=E2=80=9Cdev=5Fkfree=5Fs?=
 =?utf-8?B?a2LigJ0=?=
Message-ID: <20190827162720.GA19357@ziepe.ca>
References: <16df4c50-1f61-d7c4-3fc8-3073666d281d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16df4c50-1f61-d7c4-3fc8-3073666d281d@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 07:47:08PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 21 Aug 2019 19:30:09 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/infiniband/core/iwpm_msg.c  | 9 +++------
>  drivers/infiniband/core/iwpm_util.c | 9 +++------
>  2 files changed, 6 insertions(+), 12 deletions(-)

Applied to for-next, thanks

Jason
