Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3D1EA56C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFAN5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAN5Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jun 2020 09:57:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3028C05BD43
        for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2020 06:57:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so9063938qke.7
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2020 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n54U2lwa0cvcl+i8m+i2vrVzdhJrXQ5YxgiDnXtT9Fg=;
        b=OIHcqRFX3lbedwvIvP1dT4hBezYEDSz1+QQUsDgkB60EPV+Rt1I5zgE4ghfuQ3Vkti
         IEf+y4xU5Q3CvdEmtvvW0jqX5gT+VFwx3+5jVoppx7N6gQi1LY2hAHBaf/FXnZnPIh0p
         nEOPvXMj6VVM5KqrHXU50NCLBRJLo7N3tPmbd2Si/nuD0siwTNWJgVfU1w2pRfydGc2a
         +vh5pvoa3P38eou/a4K+5v/xS2K6VlQ1NeyAGvOm6jb/DPm2TVcEiXz5Ws7cHR5YdHYN
         TpPN3EVqCoIHwkUva6FXCkk4LGhP2QEvT2pX+kGhyjtB3MpIf7heQ1y/+RaiEGcNFVAu
         c6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n54U2lwa0cvcl+i8m+i2vrVzdhJrXQ5YxgiDnXtT9Fg=;
        b=jo5pdJq1fJPqXTZKTpFb0pjoVnnfThWeTqzA+SQYmlmyoA5uITkihcTrRrzl3uQS4F
         alDr1jy7OKGKPwPO2QrgbIHVJSgXtpe8Mag/mOtQuxbg/C9aVIfNdu8sEY0qUfoyig3L
         8LaVYyfGPHVR8KMaxkacwpGOwhN7yIz3BfDKz6pqVKSS+ukrdUWy209kE3BP7dH5np9B
         Osisd3OTGpphKn16ZOr+IFuhzlQ8/SDHxfxh2pVRwHyDkOntG6oWUzxXfHPcOWvLu+UF
         ABl0KnWNPaheOyfagz+6OcbaQrsy4yXwK6N+puJxDHdydfjG/1ePaUlppn1XLddnQ2uW
         z4/w==
X-Gm-Message-State: AOAM532FQaDiG+y3PnAvR/GNkhU05b3VgG449lALMHp9+sWmKgma+Ur5
        0Vi0ZTzqo52npnV1LHplBtw9xQ==
X-Google-Smtp-Source: ABdhPJwskiAqvnZjYEPWiNtrbmxDMErZBOfD4F6Y8Oc1vXFvTbDIR11Iq3JNWynIgdxVYZrEAIIRYQ==
X-Received: by 2002:a05:620a:8da:: with SMTP id z26mr5615486qkz.461.1591019844160;
        Mon, 01 Jun 2020 06:57:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v2sm15426016qtq.8.2020.06.01.06.57.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 06:57:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jfkwM-0004V5-UW; Mon, 01 Jun 2020 10:57:22 -0300
Date:   Mon, 1 Jun 2020 10:57:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200601135722.GE4872@ziepe.ca>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 01, 2020 at 09:48:47AM -0400, Dennis Dalessandro wrote:

> They should probably all be in "enum ib_mtu". Jason any issues with us donig
> that? I can't for certain recall the real reason they were kept separate in
> the first place.

It is probably OK

Jason
