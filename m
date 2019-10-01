Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81097C381E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfJAO4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:56:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40277 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJAO4B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:56:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so11480568qkb.7
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pBQv23hZyZ6zoGOkzSsO/ikJVaXpbPeJtv7cQxbZIGQ=;
        b=Ll8JMkg09ehQWORnPJbMrxswIuL9cJcniw6hJWPU/jps2gLuAzGuM1OKXy20m2e44n
         Us5io/9/PhUB6FupUf4ip9xBR1GnbtWGRk2UzNcOIoliKIOTyA6BG7hzT6+rDeOOtr65
         dVq9qKHNaVIN6SyOchzZx9Kqd55+/65ZZropnS0VJQcHfXqIQ5XBawMctkJ7+GqtOOo0
         mOZ1uDLXOxrklvIjY0sIaJedJaibjl8dINLB+p+mADPFbOOCRhDgEaxmrBINHhmnSu1a
         xG8VF4sMkvXNRkTok7IUj0ypv4rDlo1G35ErHPgNCHAyjA957UatrSxUsmW+6SHoql7H
         AKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pBQv23hZyZ6zoGOkzSsO/ikJVaXpbPeJtv7cQxbZIGQ=;
        b=Vta776ZPHYcvAvezIspWjlEDHf33P0XLj73PAUl/r/o1gJagSBlbjHYtV0BmAlUg4d
         h37KDBaZeXA2ynICTHPS+77oR4IYt/LkF4ocp3+Ce+mYdhb5FKF8R1T15y+100gHgK9q
         OozCJ70MtbvTmQ3wRhbaBITFY3FUDhfjU1Ey3YWewLDD++dHZzYcQvL+FVvW6v2pOEX/
         72808S9pyuIPl2KAw954lqHMWKWSvDghVpzwNLeoZ13rj0zZTKQL+IQaGapJBoteGlgH
         60t97xr4MkXqFcv5x5Lne0WeVyOT0NpKx0Dv9CvMVVp2klw7ms6me+Kvip2nGihDOpG1
         f2zg==
X-Gm-Message-State: APjAAAWsxvIFxnZMPvt7S1H8IbRhcrgtvL8pIKwJCkVH2v0DeoEhHJUi
        mkzeZm2WA9pJ9aiywsrPWeS8BQ==
X-Google-Smtp-Source: APXvYqz5jC1Z58EAOH2fAr8EZ6RSDGSYnDixd5U0fsPkBvShqkP+k2/NjKu/LWS30ner1IRv5yNBRQ==
X-Received: by 2002:a37:9dd2:: with SMTP id g201mr6361818qke.55.1569941760023;
        Tue, 01 Oct 2019 07:56:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k54sm13026242qtf.28.2019.10.01.07.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:55:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJZH-0008Sb-5y; Tue, 01 Oct 2019 11:55:59 -0300
Date:   Tue, 1 Oct 2019 11:55:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com, Rahul Kundu <rahul.kundu@chelsio.com>
Subject: Re: [PATCH for-rc] iw_cxgb4: fix SRQ access from dump_qp()
Message-ID: <20191001145559.GA32498@ziepe.ca>
References: <20190930074119.20046-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930074119.20046-1-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 01:11:19PM +0530, Potnuri Bharat Teja wrote:
> dump_qp() is wrongly trying to dump SRQ structures as QP when SRQ is used
> by the application. This patch matches the QPID before dumpig them.
> Also removes unwanted SRQ id addition to QP id xarray.
> 
> Fixes: 2f43129127 ("cxgb4: Convert qpidr to XArray")
> Signed-off-by: Rahul Kundu <rahul.kundu@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/device.c |  7 +++++--
>  drivers/infiniband/hw/cxgb4/qp.c     | 10 +---------
>  2 files changed, 6 insertions(+), 11 deletions(-)

Applied to for-rc

Thanks,
Jason
