Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01E321C18
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhBVQDI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 11:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhBVQDF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 11:03:05 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE28C06121C
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 08:01:45 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id z190so13007006qka.9
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=flHoT4LEzKs36kNMC+WTngFW26JQKdMWyWk6b8Lc9YI=;
        b=gNpwiTZUF56xIEk3UM1YkSF64ykm9KhtuNitUW4dj8aPnIw0upXvNXfUso7iCLGHK+
         Q0O+r+ffSeofAF3O8cLbmNeSVvvvx7SsqNhgwfqahUeceWx27KrcPx9W5QNIVGvsa9ml
         qdtQhrlPIJAFkA4ptc/gJU1pvS4prxELhJOhpkyojQypjveGZFUdGn5mkwCsQ7CdEIQq
         tx70j5PVptd+g8zaO+eTDyc/ZXA20moFGANCKQw8U4JmGNE4pJpfzSuoBemKOXBJdW4d
         gisrQPiE1/7HCgTEwK8nPNgmXq4IY7X0OlwxBYQ70mnyzFlK9b7DSUTH+8KpwbjpPAs6
         fHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=flHoT4LEzKs36kNMC+WTngFW26JQKdMWyWk6b8Lc9YI=;
        b=GJNYTu136wsAqkXqTh+0e1jfs5bOvIoxHxfWsaLg+kDQZlWc+FRABpBeG63hWgI2Sv
         KZGB3YlG9oZtcfeTP2EaYlbe1hixCgUb+/0P/lVZi4enxFKj7Qi0zDAKHJq3DKh9n5Ez
         EiaGdOi6rTdadFCkHTLCuQk/FG9lK1bSo8ckgsrkwxQzQetEjVyPhSjsXLANnwrKzJel
         /mtAI0JJf6uv0TxXHWc3T8V1Hs8CYr0pwX7N1SYARY8Int8RwFkQa7jKgoTH+6TOyt3H
         cxE0IiVd6a6VZYs2xWMm0rjZ2EVeRjj2Swpk83V89Cllwt4QfxEXf0DWy7lnOrzwWgTg
         3tVg==
X-Gm-Message-State: AOAM532TuX+VHz22dI/QuOXpHuYkhvTY7cRQeyuZL9y5IDHH509y6VFC
        yZfOhv9IvmBMg6V7bFxhdADwb27y9jijcPBS
X-Google-Smtp-Source: ABdhPJxclYCbHIhKIhazuEWwyaFEgpkv+P61/c8pkTWwKAG3rFDFD4sJjdkBx/SuquN+lv5ibnhlfw==
X-Received: by 2002:a37:418d:: with SMTP id o135mr18521393qka.293.1614009704261;
        Mon, 22 Feb 2021 08:01:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id m9sm4425005qth.40.2021.02.22.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:01:43 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEDeZ-00ERKU-8R; Mon, 22 Feb 2021 12:01:43 -0400
Date:   Mon, 22 Feb 2021 12:01:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic
 Context Attachment
Message-ID: <20210222160143.GJ2643399@ziepe.ca>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
 <20210209195359.GT4247@nvidia.com>
 <fa076ca278504bf58da2c1e521be6748@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa076ca278504bf58da2c1e521be6748@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 20, 2021 at 08:40:02AM +0000, liweihang wrote:
> On 2021/2/10 3:54, Jason Gunthorpe wrote:
> > On Sun, Feb 07, 2021 at 11:12:49AM +0800, Weihang Li wrote:
> >> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> >> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> >> enables DCA feature, the WQE's buffer will not be allocated when creating
> >> but when the users start to post WRs. This will reduce the memory
> >> consumption when there are too many QPs are inactive.
> >> One a WQE buffer is allocated it still acts as a normal WQE ring
> > buffer? So this DCA logic is to remap the send queue buffer based on
> > demand for SQEs? How does it interact with the normal max send queue
> > entries reported?
> > 
> 
> Not exactly. If DCA is enabled, we first allocate a memory pool with a
> default size when opening device. Each time we trying to post WR(s) to a
> QP, the driver will check if current QP has WQE buffer.
> 
> If not, the driver will check whether there is enough free memory in the
> DCA memory pool. If there is, the QP will get WQE buffer from the
> pool,

Does that mean the QP can have a non-contiguous list of buffers? Ie it
isn't just a linear ring of memory?

Jason
