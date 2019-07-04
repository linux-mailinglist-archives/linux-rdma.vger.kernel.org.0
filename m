Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B07235FC84
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGDRaN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 13:30:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36544 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGDRaM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 13:30:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so6061730qkl.3
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5q0dDx33/YE5pj986ibJMOf1Bz5Zjii/LSoueRiS+zE=;
        b=UZL9J5ek2xQLCi0Aoo8g6VcubpXYg0vIA3CwPKQzHhoh/ZEB924XR/Z/jftFwOktag
         hQiQheGWYlThc89gM+0wOfk/P5m/XkIckGeMBQ4VB41EF5/+4sqNWyCz3QBJiJNfndRF
         JwqFMctPsb7gj/t6/yZ0yIyOPiS7qsZDnYWoG9oFd6CsaVc5S22N9bQhJTKBfmfAErYa
         pdKorGi9Fq6/7WYJsbMt1WrKsnuA5OtdJexCpOvlbnYQwusKK4QCOWODM4Mouxo3kuaJ
         AZNmZNujjqGWkNbdgc6YFQIZZuH0dDY+xOAaUSFFXqUy+7SPsHfmQqsWWocvvWDurYDd
         wZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5q0dDx33/YE5pj986ibJMOf1Bz5Zjii/LSoueRiS+zE=;
        b=WN4l+W3NQFm5mKdNKewku4YJ9AXlnpXbHDxFxi2jUqEWKYjUxaaNs9uW9C+Czo8Kl4
         VurAvRENFyGyw8+LpOAnnBv2ypkku+EXPgsK1lvmNJ91phMlFAFUnM260S1F5PS4m/Y9
         Dy9NOTq1BEDndzIVWB0l1vAoa7LGcnAs3qC3v4NDx9kXGKBR1GBbM2Z7QmoqIt/keV0U
         vqv06Sk6csPShwtlKZ7lG5kXOGmQAQt+aVte8aRTMq8fRHcsnz0Qqkd0coJ1MpG6vNWP
         caBKiRtJaJoyYeGlMTcb2JVI0SNelKgnhMDUEzxy07S5gIXAzT5dujqygY9v19AgNKhU
         SpVg==
X-Gm-Message-State: APjAAAUSTE1/KLETF1MLsmn1//iyFJscM4LEDhqNRqStpkmrSFpOk3V9
        Rb9TQ+5GvnC054lMdX15tL5Kxg==
X-Google-Smtp-Source: APXvYqwKGZhPIz5haogDw/7+wXHXKCSTtyhpcNENAM3ALqRWmvkcJj4oSihCuJk86YltAifOEEUz5g==
X-Received: by 2002:a05:620a:16b2:: with SMTP id s18mr35251882qkj.323.1562261412071;
        Thu, 04 Jul 2019 10:30:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 195sm989473qke.90.2019.07.04.10.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 10:30:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj5Yg-0004Pw-VW; Thu, 04 Jul 2019 14:30:10 -0300
Date:   Thu, 4 Jul 2019 14:30:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Feras Daoud <ferasda@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/ipoib: Add child to parent list only if
 device initialized
Message-ID: <20190704173010.GA16955@ziepe.ca>
References: <20190630134841.19413-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630134841.19413-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 30, 2019 at 04:48:41PM +0300, Leon Romanovsky wrote:
> From: Valentine Fatiev <valentinef@mellanox.com>
> 
> Despite failure in ipoib_dev_init() we continue with initialization
> flow and creation of child device. It causes to the situation
> where this child device is added too early to parent device list.
> 
> change the logic, so in case of failure we properly return error
> from ipoib_dev_init() and add child only in success path.
> 
> Fixes: eaeb39842508 ("IB/ipoib: Move init code to ndo_init")
> Signed-off-by: Valentine Fatiev <valentinef@mellanox.com>
> Reviewed-by: Feras Daoud <ferasda@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 34 +++++++++++++----------
>  1 file changed, 20 insertions(+), 14 deletions(-)

Applied to for-next, thanks

Jason
