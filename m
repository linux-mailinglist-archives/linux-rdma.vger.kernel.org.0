Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD418CE5A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 14:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCTNBT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 09:01:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37926 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgCTNBS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 09:01:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so6666480qke.5
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7TuRXOsRb6VN2k9fT/xXrRf7kwsC1S56wwwyKIf4nJ0=;
        b=KSyB0Abc+yPjygp5KB74BXi/zimVaZDkiP3XhX2q4scuUv9ycfb43bbDcBEUnSJ9GB
         8d2eT6OKAGZxUBl8+tylt2480GyXqPD4yQ5pREMgA8VhQ7rjtd1tsiseAhppA6MEIQQP
         yVIJmGROEo1FeilPTgvqIDPUMANnFnphoE2tCB08ATAgTYikcpnnsdwzx5rEzm85wwT1
         ExHcqSZR3JHNlcMKP4P5lBQBLV1ou8ZdipHWg+dwUZqqapX/c/bsTv5cqbkExalTPzUS
         6NdIx6b8qoCiZGVtNR6OAfzl5DnUYssGTlnWChINnX+gAw53qFZydih07UikqeQsgW4a
         qtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7TuRXOsRb6VN2k9fT/xXrRf7kwsC1S56wwwyKIf4nJ0=;
        b=ehsDy+nYNWXwR3BNWC1H+6v085O/ub4YQwSko8VmTHAG2BP6mpbqsPkqn+/KmxI8sW
         y5xqqz5GpSvw4sJk9xS5RiTbDZSIiZLYIvt3jeRZW7JJpLjK+2rI8K6wwXGvEddO/py3
         HorbLd6NCCKqKm991aesABEneUHX2psl7aRLDEF4z7uKtD8yI9YUpdH1d12pso4VUXYr
         jw+/T+Im+wwQZYj1IXsxXDUi6K1GJPyQLS0hT3ywrzxEHAWctUsOE3Uj0Qcn6IthuoYc
         vW7u3gUavgehVvl7ZSbF0c1PIBaaZwnCX0X65FzaH8I2tBkwLx3OeKv+V43Vx9asDYEC
         W7vQ==
X-Gm-Message-State: ANhLgQ0XHCfYOYa5qNwLHVtpbG0w/4ZIb4X6NHlEgYCG6y3mtnc3P5gj
        GZyxw1BDtLGuSggA7cfrwDN+/g==
X-Google-Smtp-Source: ADFU+vsgFL3N2gBIP1ZkQjStMaw38H11H5bXUTfAzXb2ivjqVG+LYpo5fGcS/MG8QoDUpYoYiLq1ig==
X-Received: by 2002:a37:981:: with SMTP id 123mr7835936qkj.154.1584709277584;
        Fri, 20 Mar 2020 06:01:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id s36sm4571907qtb.28.2020.03.20.06.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Mar 2020 06:01:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jFHH1-0007Fz-Vx; Fri, 20 Mar 2020 10:01:15 -0300
Date:   Fri, 20 Mar 2020 10:01:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Elliott Hughes <enh@google.com>, tglx@linutronix.de,
        linux-spdx@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] uapi/rdma/: add SPDX for remaining OpenIB headers.
Message-ID: <20200320130115.GR20941@ziepe.ca>
References: <20200320004836.49844-1-enh@google.com>
 <20200320071453.GA309332@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320071453.GA309332@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 08:14:53AM +0100, Greg KH wrote:
> On Thu, Mar 19, 2020 at 05:48:36PM -0700, Elliott Hughes wrote:
> > These header files have the same copyright as others in this directory
> > that have this SPDX line.
> 
> No signed-off-by: line?  :(
> 
> Fix that up and I'll be glad to take these, if the rdma developers don't
> want to.

It is no problem, RDMA patches can flow through the RDMA tree

Jason
