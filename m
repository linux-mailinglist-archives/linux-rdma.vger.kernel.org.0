Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB35D415F53
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbhIWNQz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhIWNQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Sep 2021 09:16:54 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C95C061574
        for <linux-rdma@vger.kernel.org>; Thu, 23 Sep 2021 06:15:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t13so185735qtc.7
        for <linux-rdma@vger.kernel.org>; Thu, 23 Sep 2021 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/qBGTJ94J1mVUaKqjzNfrmv22QiJeX2c01+ZG5N5Dug=;
        b=nIK/43rfkMS55xMT6HEck5klqGQaWuQAs5hQCn0cBILgOPXazmLQSduge3zd+fy0xm
         ie+Yys8USJlUF7KPKscqJU5cEAPz4wIqws+OwGe5R4RN78Yp/813GM7br6Rr38n1D4mN
         5Xbp6A6xRTIt+A6Ct9MnH2r782Ueh4Dbyu6XfGGXtoASC4KN6xRL6Gj6c1i7HQb2QrWZ
         HWeCGTP4dVC4jDBkxjmvEtGqjflTU6xCvoqaQImsUOLj1UwPAMfQpTr3lSIQncJG8+52
         HAIqMFQ3Ukbg2pq0TkuE4jbe2oCc1vOba5x0GshDMOVW9Q6mzPv74TYGgKlpe0AQ8V/g
         3G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/qBGTJ94J1mVUaKqjzNfrmv22QiJeX2c01+ZG5N5Dug=;
        b=I8eZJRac9+IMJjrCPGj3KQvkloJNOZBbN5PqdTG23AEe1PBmZN2kLD0fFt2Iiivhzw
         3zsAbMRM7pe82Yn85xdrzDcb1qan0P/UdU/RkYmP6cuFzAmMZIsyx2KHhGcSQuW4k0tj
         ixqO7XhnBIsgFRzyczXruppNZGckFmWI0fMIConi+FmKnldFRx78gghhQCWQiXkycwcH
         2Gsbc4rLzzICFsiUQuFqesZk4cXNIHMMk1nSs8HZu1oak/gEplsZq0YoEUEk+VTzOiP8
         2d05DFf8pVNAedvmSxfVNWJoSdNHEnQA9DR8raLzQnk2kbiwEGdVCb6nI294wYWmqgxo
         iSuQ==
X-Gm-Message-State: AOAM531Ii0FfBliLmLORGNeDxnH69RrCDp/wDVM9R4bcVmii/3go4D6l
        CO9fzqu9D+CxRcZ2TpjhywHD5A==
X-Google-Smtp-Source: ABdhPJyN7vkSS1Pa+Tln15YulpLlFsVxYMb7d1gGthyuSGhnPwjOs1ySYLoiJSd9J//5qQ0tBPG7Sg==
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr4752542qtb.162.1632402920265;
        Thu, 23 Sep 2021 06:15:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id y6sm579990qkj.26.2021.09.23.06.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 06:15:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mTOZK-004Ps6-NZ; Thu, 23 Sep 2021 10:15:18 -0300
Date:   Thu, 23 Sep 2021 10:15:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Message-ID: <20210923131518.GW3544071@ziepe.ca>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org>
 <CH0PR01MB71532C0E55A47C6910F47B79F2A39@CH0PR01MB7153.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB71532C0E55A47C6910F47B79F2A39@CH0PR01MB7153.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 11:03:06AM +0000, Marciniszyn, Mike wrote:
> > How about applying Guo's patch and adding a configuration option to the
> > kernel for disabling pointer hashing for %p and related format specifiers?
> > Pointer hashing is useful on production systems but not on development
> > systems.
>
> The prints and traces are leave-behind and intended once in a distro
> for field support.

It doesn't matter, our security model is that drivers do not get to
subvert the kASLR by unilaterally leaking memory layout information,
so you have to get this fixed.

Do not defeat the mechanisms to obscure kernel pointers in trace or
print.

Jason
