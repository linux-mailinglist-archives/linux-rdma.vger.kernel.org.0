Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C429F751
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 23:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJ2WB2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 18:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WB2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 18:01:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A7C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 15:01:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id u19so5381073ion.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DMdC8cz9DDLMqfxjw7XHa9QhUgpqziCmqbcRAF1P/Ig=;
        b=iQmNsZoHETca7QBOZO3WFlZlP+EhtRm+zwDiPln5oRXXgfHErrebpUG+10Dx/cnq/l
         xhjaaEp+uaFYyZEB4ofLuZ7CxUYptWIC/ZuLm57/USOuMuAcWMoNX9XmwyDzInhyKBP/
         uLE8v6KViOoGC69Tlgzm5ql2WX2zA5tChJb/XKtr5HHkX9hKfQINR4FdSMeF5KDPqbrU
         uKb8LwYLMmObnj4pN/Z2ARTXdmSSH+GUw/WJRDMx9wEg7FzVwtSU5THVuJkoyrht3IFb
         UVdb1ZN3BS/bd6WTk+gx53xrOlfjcIlaPBcREVdTVfcS3DHkumyt31g6nOpIS7czT7bA
         KWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DMdC8cz9DDLMqfxjw7XHa9QhUgpqziCmqbcRAF1P/Ig=;
        b=AKNnSf4hnw1AO7wsKCBvdLwH7OKbX06EqoS7QZLB/Z5vGLbHSHTHfEfrE/ZHk8hXHg
         CWSX77R4w+wFvAQFUPUqu8fOoT1T42jJT7Ex1FhMQc/v4Y0O1aynpeuYLu2DY5qH9yjW
         5Odrc86S0/RQOwuR0+Q5hPj2WKdhz86eqskZqV+aunmCH1c1KGiBN2coHkxCbU9L14cI
         QkBa75LY+dkaiOriW60Zy9aXR2fVTyuiCzWkd895jtQKMN4baVqHp8J3LYM6pxhPbryA
         TsRs3q2B0XwewvlEXQuQ263aXJNygsUyEj1LkAPhHa7l2nQ33kswM3YlQoJuJzr2mwen
         /YHA==
X-Gm-Message-State: AOAM531ILdSJ6b/aNl6zZLPolDseCCdH6VND1c+d3p+asyxP//3woE4f
        YAw/J3EKsTRc+4SawClN2rX2Iw==
X-Google-Smtp-Source: ABdhPJz3YBzBPsFZ5xhQnPjXjYt/w+XIpCRDqLmco2j6KprFbLH1L2JMsjFjEJUrZ+2pnHVazG+aNA==
X-Received: by 2002:a5e:a613:: with SMTP id q19mr121744ioi.110.1604008887822;
        Thu, 29 Oct 2020 15:01:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 192sm4007239ilc.31.2020.10.29.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:01:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kYFz3-00Cgl8-W5; Thu, 29 Oct 2020 19:01:26 -0300
Date:   Thu, 29 Oct 2020 19:01:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: hfi1 broken due to dma_device changes in ib_register
Message-ID: <20201029220125.GZ36674@ziepe.ca>
References: <ad690c34-4260-91a1-d64a-2954a8ae1c54@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad690c34-4260-91a1-d64a-2954a8ae1c54@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 29, 2020 at 05:54:22PM -0400, Dennis Dalessandro wrote:
> Just a heads up, 5.10-rc1 is broken for rdmavt/hfi1 after:
> 
> e0477b34d9d11 "(RDMA: Explicitly pass in the dma_device to
> ib_register_device)"
> 
> Running with that change causes the call trace below. Reverting the patch
> works around the problem.  I haven't yet had a chance to look at what the
> actual cause is, but will and follow up with a proposed patch hopefully
> soon.

Test this:

https://lore.kernel.org/linux-rdma/20201028173108.GA10135@lst.de/T/#mde105a810fb9d2bf734554f3a9875468184dd96c

Jason
