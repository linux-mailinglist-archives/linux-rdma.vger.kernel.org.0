Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097103AD5CF
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jun 2021 01:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhFRX1u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 19:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhFRX1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 19:27:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5407C061574
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 16:25:38 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id e3so8892968qte.0
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mUgHdV7nlzH19181B9cmY7xSIwQmJHE1XK4dRdAUxmM=;
        b=YwVlCU9SSoH5nzJMDEOwdxA+VmmO5xofh0hBqn8A/xyveRtFPU1Zf4zdzadimiL8P4
         4pxorjLaZT+rVSqIaa6Qm8PlGaSv0UCX83SjTYg5+DVBzQ5YyKCOlBOr5ZrlWfyMEjyn
         8rnPsYDpyoh6Q+yH1eABuuv6TFwCpdNX9AmvQ6Cfo6zYe7uOl3UGd52PYK7WISlrdAk8
         n2kRBbvJVSVQvZQcFp3+ezub9V8rc/Q0mYUHNlcFEoLrWCBZbJOMiaaJgMuWj3Vt9HT7
         bXouU4uVDwm7af+XLx/GcOKjJryRSwHQPXHPO81YoDqEf91l69JVljmYeDhlmQnT6+Iv
         IstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mUgHdV7nlzH19181B9cmY7xSIwQmJHE1XK4dRdAUxmM=;
        b=nkcZwleBpTEvtORxyYFHYMfgV5dXhGoMquX0onbZZeWCbMA1qd+pp7NPsO4+nya9Dw
         87OOsJqq/6j+rX8lS5MNUN3ParyHZaYFiszq6wS+4Mca0f3GtqEO4h+ZuEbIJSBx89m0
         8VjMVpfHf5yGXCQbSJZ7r7rpKNYSvUQ+9eBiBV6IhPEKOijcQM7l8ubcHgpAthIMyl1W
         V1D6Z/9kMpta47iD0Wwi6lyt8l64sjvVX7h1CQX3AfFslsUPw4CIaEGxRRipKvKzw3zB
         UvcbQN4PsU5gtB6nMiZybErUQL5PUqWjmFOXkR4TM+6YJVs4FdTc1aLRLB3NPg4kvsYR
         2Nhw==
X-Gm-Message-State: AOAM532QJFuagl19f4AryMvxurK5VyXmaiKXvNtx82hrus1I1xJYanV5
        r3cGvfMNR7Kemum4mlhVB+Z7Hg==
X-Google-Smtp-Source: ABdhPJwNO6ixgat/nX1qggnDaQJP+duVZhS9+PkX+T3gfZBX+8Axf4Ycw+AkSAr3fes3dHbks1ruBg==
X-Received: by 2002:ac8:5ec3:: with SMTP id s3mr13135449qtx.312.1624058737311;
        Fri, 18 Jun 2021 16:25:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id y24sm6402371qtn.57.2021.06.18.16.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 16:25:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1luNrj-008if1-V2; Fri, 18 Jun 2021 20:25:35 -0300
Date:   Fri, 18 Jun 2021 20:25:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Shoaib Rao <rao.shoaib@oracle.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
Message-ID: <20210618232535.GB1096940@ziepe.ca>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
 <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
 <20210618163359.GA1096940@ziepe.ca>
 <14e2c2a4-6067-c657-6ea4-91cd3c19d032@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e2c2a4-6067-c657-6ea4-91cd3c19d032@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 01:58:48PM -0500, Bob Pearson wrote:
> On 6/18/21 11:33 AM, Jason Gunthorpe wrote:
> > On Thu, Jun 17, 2021 at 10:56:58PM -0500, Bob Pearson wrote:
> >  
> >> It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson
> > 
> > Can we just delete the concept completely?
> > 
> > Jason
> > 
> Not sure where you are headed here. Do you mean just lift the limits
> all together?

Yes.. The spec doesn't have like a UCONTEXT limit for instance, and
real HW like mlx5 has huge reported limits anyhow. 

Jason
