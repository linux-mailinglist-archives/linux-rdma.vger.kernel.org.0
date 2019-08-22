Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280F8992C9
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfHVMCO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 08:02:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41888 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388173AbfHVMCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 08:02:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so7255744qtj.8
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SZYRiB5UNNsuh7siRqUTpPzIk+00t3Ho85yWWXDEnlk=;
        b=ouliwZjnSQCXbUtIzBIH6NY7u8rYbUZjI4YVDeuNtBMPL6J9Tk6NuM3X7TIH7uRs/B
         kWioMmnsP+5nzc56gkpzE1QSHj4I1u6KIjpPu5V4FF/SEzUXk91nYVf74PXXqPjrfDqC
         rwwo5SSeXMydtUK7qdp6V98vx/WnBGlcj6OU2ufU7Ymqbcq84C1Is+xUket9q1G4dFkc
         H5ZvdJKeY5SW6ziKJSfRNHWX1dUhsQA65P9v0S07F2wVf4z362O4G2KOiDfOjJIlMrLq
         lPSGNqBZbd2ecuop2GvOtoo9L0nlBq1rDqsB1kn85sL+O5FC8J0ssjd3FTOsQe60Lr4p
         B5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SZYRiB5UNNsuh7siRqUTpPzIk+00t3Ho85yWWXDEnlk=;
        b=sRRnR3YIemoQuOiKI+yA/w1PZya2CRMlY53waiynJcgI8ZhFBsT4Q1Z+cl5848gstd
         xfS+urBdjMuMmEvaG5OClBcu7Ai4TvBcr3233XTg/T4TEWLeR61OhCFZpauBGKiHadp8
         cwYoHo+XT5qafPUgw023mUsqRFdQQInjtOAWUxX3t/LG3j4L9O5z6cI8kloWKN72Sv6Z
         9krQQMaQ4BrDo513jIrIdh213UDI2AIm2CLnPjRbEYMAnD3dPYBC/w9ymYDCyqGqbmyb
         U6s6uBuf6loD4Xhrv4od+4vsMjGPOHfWJjzA/6PrQF3kheKVrEr0ALW9NtegOvw2Mlri
         ByHg==
X-Gm-Message-State: APjAAAVpxFZo1mqK5Dxw1VSrebdbWzQtBMERo2evviP7KaBU7JzdLTod
        fTk/xir4Cj32PeUbI+uon2sGDA==
X-Google-Smtp-Source: APXvYqyUeJQLcBFKgDxZMyIgVmkbCKS1JeTSzMgqG2k/c22I5gLq0TDkUw9oQPbnhkpAFXMBnHZImg==
X-Received: by 2002:ac8:540d:: with SMTP id b13mr35623826qtq.288.1566475333260;
        Thu, 22 Aug 2019 05:02:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z7sm5886911qtu.47.2019.08.22.05.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 05:02:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0ln9-0002BY-FJ; Thu, 22 Aug 2019 09:02:11 -0300
Date:   Thu, 22 Aug 2019 09:02:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
Message-ID: <20190822120211.GA8339@ziepe.ca>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
 <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
 <20190821125645.GE3964@kadam>
 <adc716f5d2105a3cc7978873cd0f14503ae323d8.camel@redhat.com>
 <20190821141225.GB8653@ziepe.ca>
 <20190822071023.GF3964@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822071023.GF3964@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 10:10:23AM +0300, Dan Carpenter wrote:

> > People using 'git log --oneline' should have terminals wider than 80
> > :)
> > 
> > The bigger question is if the first character after the subject tag
> > should be uppper case or lower case <hum>
> 
> I feel like more and more people are moving to upper case.  There are
> some people who insist on upper case and no one who insists on lower
> case so it's easier to just make everything upper case.

I've noticed Andrew lower cases everything going through his
tree. I've always used upper case for no prarticular reason

Jason
