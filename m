Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2651B838AB
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfHFSgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 14:36:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45809 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfHFSgH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 14:36:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id x22so12193196qtp.12
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JtINiPTTaxXs89drKGXiMpthv7Xf3LRZukSbKo8R/Vs=;
        b=NaCiCQSHxFDb4r8ia6jN1dSySpTaDWH0hxU7dWGojqAwyO4Vi0i4fKhIVVC/XM7aON
         6edg9wk+4SBflCPw75uG5f125yoLwujQoBhnJmxT2OI9yk82hvv45lrTqZQlX+xtA3yo
         Z0OXDCLLJSs8VsujMGl3gDEitD8HjX9/u2jz6MMHzYEikkea+dz2lXYbp6+ze3esYNIw
         +IG+ApkkeIGIlMKYpubK2xac5Hkabx9KufnoB9IzsBVoQfe+5U0wD2pHc4DxzXOIXOtb
         oBaGBQAmz5SQHjuspem9LnAErsMZmJ0jgoMlCzdwW7ogd1zXVEibDtdiB1NCvS8a1Gzd
         ew6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JtINiPTTaxXs89drKGXiMpthv7Xf3LRZukSbKo8R/Vs=;
        b=MaU+GMXgmewaMksjj3Lh2x1/8v8AFFJB3b0WYKxoIj0K9ghOhhq/dzTnLtdKzwUKHQ
         FQepvNjCNQR7OP35Uz0/DRM7dh+b8XQFbqs328u22MNocpX0vSNC8Yuk9hrlghapyOPq
         USDN+qwEzH0abUsJ1dDzVePOtN6xQLGd/eNgIqht9d+dmAWMqhxuzq1VSWwuyGqng0Ld
         3bxWbVxPZksPr9zWMqAhBdcOW1VGGg9v30H1hK60/EIsSUEWA7gKGtU2GFxTbUoYLO+m
         46AzlYXgGKSMBJeK75COVcyVnmNEV/YfhclvJzKv8DtH9JnRh5zlZuSgz17hn/ea+SZ3
         jOEA==
X-Gm-Message-State: APjAAAWvrvaNqBLxW1vvFwVjArojNdrRiMZxf7MwGQDqFR0Yuq9N0vu1
        J57O2OAFSTS8OmNORCvEdlOuWA==
X-Google-Smtp-Source: APXvYqwy1L8dEpY8EmVTZsHO6MDZHBCEi1r8Z1tUlIX+of3znd+xvWIZm+zyAOK4Tvk+C14HehfEhA==
X-Received: by 2002:a0c:ffc5:: with SMTP id h5mr4478918qvv.43.1565116566370;
        Tue, 06 Aug 2019 11:36:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r36sm48135303qte.71.2019.08.06.11.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 11:36:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv4JY-0004Lm-Pm; Tue, 06 Aug 2019 15:36:04 -0300
Date:   Tue, 6 Aug 2019 15:36:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Tariq Toukan <tariqt@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net/mlx4_core: Use refcount_t for refcount
Message-ID: <20190806183604.GQ11627@ziepe.ca>
References: <20190802121020.1181-1-hslester96@gmail.com>
 <CANhBUQ1chO0Q6wHJwbKMvp6LkD7qLBRw57xwf1QkBAKaewHs5w@mail.gmail.com>
 <47bb83d0111f1132bbf532c16be483c5efbe839f.camel@mellanox.com>
 <CANhBUQ1wZPinWicu2c_VZjpTtP_9+AxB=7zn+ymPyYVo_rsxZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhBUQ1wZPinWicu2c_VZjpTtP_9+AxB=7zn+ymPyYVo_rsxZQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 03, 2019 at 10:42:31AM +0800, Chuhong Yuan wrote:
> Saeed Mahameed <saeedm@mellanox.com> 于2019年8月3日周六 上午2:38写道：
> >
> > On Sat, 2019-08-03 at 00:10 +0800, Chuhong Yuan wrote:
> > > Chuhong Yuan <hslester96@gmail.com> 于2019年8月2日周五 下午8:10写道：
> > > > refcount_t is better for reference counters since its
> > > > implementation can prevent overflows.
> > > > So convert atomic_t ref counters to refcount_t.
> > > >
> > > > Also convert refcount from 0-based to 1-based.
> > > >
> > >
> > > It seems that directly converting refcount from 0-based
> > > to 1-based is infeasible.
> > > I am sorry for this mistake.
> >
> > Just curious, why not keep it 0 based and use refcout_t ?
> >
> > refcount API should have the same semantics as atomic_t API .. no ?
> 
> refcount API will warn when increase a 0 refcount.
> It regards this as a use-after-free.

If this causes failures then the code is not doing atomic as a
refcount properly anyhow.. 

There are some cases where the atomic refcount is just a imprecise
debugging aide.

Jason
