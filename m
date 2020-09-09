Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1612632B9
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgIIQtj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbgIIQHN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 12:07:13 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81886C061756
        for <linux-rdma@vger.kernel.org>; Wed,  9 Sep 2020 09:07:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j10so1762259qvk.11
        for <linux-rdma@vger.kernel.org>; Wed, 09 Sep 2020 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xHcTQ4FMhCwmsgG5IrO6hE0lqhjghaqgY4HCLZqX9g=;
        b=DlHd26ToPLHqkMpPffoH7N3XyrrEj6pKQMY18F9NQ4uMdvZCLYyY0OJQjsu5i52OXn
         JtigTrS4ypVl/Ngh+0gi7BJJXzMCG7ZtBad2aboW+JGhpia7LjpKs9mEJK3PHAr5eATr
         SDFZ8N/9FqMz4grnOWqZrAeEZvsneQbhq5WeNzQhg9ng1MwJGppmCr5S+5aIq+W1FpUP
         Sccl3wgl3mEJrv1dEqXlcUvk5Fq/FyBWbE5ZD6CR7fIqvu3o9dh0zAJ0pJ2ydWYDtZOR
         m9Z1PMxLnaf/vEKOXqbqlXn7Abx+cxK0oC7Z5GvfNCZQvdMxMEEmezAG20V4EzskPmpU
         p6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xHcTQ4FMhCwmsgG5IrO6hE0lqhjghaqgY4HCLZqX9g=;
        b=MXhxdo3UP9xwJkkY5I2I4iQjmwJCoQcsGI4UrEqAel7NqcT+JXmDXvsXLBF1FDPXQV
         3CM0eZpZdGkPrcAvSR+DWY2Qg5zj4SnVrzqdeZ1BBZ959754x0Tcsj7at6HfwI/udV2C
         7vQ2U8kzLHVx98xp4+FkbAcUTFzkze3FnQNIAkgSMC6A98D2HyHsN9CjKiDE6jUdj0cE
         LfxxWGtlDTLqPTFRMt3N9uxPONzhDetErk8puX5OuHdaXkpIcQxaUTmyEXpq8LhDPZTi
         xhyetVqq2DKPY9fJyVgikmmQlPfF1Dc7lP4blHNrpz2upMaOCxFFamnLOSdFK3YvTpJW
         L3bw==
X-Gm-Message-State: AOAM532lhp6dYEJ9jkXQN3Q36sbr0zcnq9W61weAg7QzdI/FQr19/geW
        Vxs6KOxqNdhq1AhaV26oP8p4aLzSaz2aPw==
X-Google-Smtp-Source: ABdhPJz6TxEPxMNhWS4A/lwpsbXcpf3VP0RaGIhPkTjT2gUAioQmqvYkdool0nZIwa7KNLwZHc3gsA==
X-Received: by 2002:a05:6214:1452:: with SMTP id b18mr4829538qvy.5.1599667621222;
        Wed, 09 Sep 2020 09:07:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q142sm2838584qke.48.2020.09.09.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:07:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kG2cd-003NRv-L2; Wed, 09 Sep 2020 13:06:59 -0300
Date:   Wed, 9 Sep 2020 13:06:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bruce Merry <bmerry@ska.ac.za>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Bug report: in-place build exposes fixup headers, breaking
 static_assert
Message-ID: <20200909160659.GH87483@ziepe.ca>
References: <CAOm-9apwANddPcn4BYZwjV9Rd=f+Y6WRuwBwBxMM+aapOAwbXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOm-9apwANddPcn4BYZwjV9Rd=f+Y6WRuwBwBxMM+aapOAwbXw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 11:47:24AM +0200, Bruce Merry wrote:
> When building with the recommended build.sh script, it seems that some
> header files that override system headers get installed into the
> build/include directory. I'm guessing these are intended to be used
> while building rdma-core itself, but have the effect of interfering
> with other software that is specifying this include directory to build
> against rdma-core libraries.

Hm, yes that seems to be the case

> When I changed my build process to do an out-of-place install the
> problem went away.

I'm not sure the inplace mode is intended to be an exact replacement
for install - it works in lots of commonly useful cases. If you want
it to work in your case then use a newer version of devtoolset

devtoolset-9 has a new enough gcc to avoid this fixup

Jason
