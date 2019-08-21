Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5B97C33
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfHUOM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:12:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38790 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbfHUOM1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:12:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so3177581qts.5
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23kYTP6ULZNTAiPR6VTOlpIkPL5ATfekA0oN6rQYVu0=;
        b=SfHa9R9hDTGZSZDBuv07U1+F0uHytanlIXLewgScfoiEtwwE6ts9Nlb0NqhIOFOjAd
         5DZscNVMUPlmFzZn9OnpY8A6GFz+6Ed+xXZS/P3aahTZLLK8pte82Yo04Il8Toyg1DyL
         tiYx2IVWIRtP+HuuiCWGUFSx6u7/RjbPc8x4wMTWYSoL0+WEZAmTS2AI0Axf8r14T+Gp
         S0+VFYa2liPptoexANHyG5PdKKQb3QB7XzVmxv7De2HDJ6JgEW/sEEJnczv98TTNtO7/
         YRQAKOS7Ebd9sqru/isfBJLmsRhsFHUasbUuGg5oxBtmyyELqKZGZMtOEfFm1WWcbY/s
         g+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23kYTP6ULZNTAiPR6VTOlpIkPL5ATfekA0oN6rQYVu0=;
        b=nUXoIveEbpcF4uX3fOCHVKlUwDcU6xIaLtG1qPsZTYJ1YtDrMQU8Mm0MTLBSPv1Vvj
         gxah02H5qcAemRZWpb3BVBBu4wMdlJS7aQ8s4v4+rBWnN67ppzvfghpEilrjMnQRRDth
         5sUUmaRuHhc0g3c8e6Zbn6Qe3ohnGJ/bRwIna65fn2RJ2ikpk7Ud3je3sPRBZWClJcyR
         lJPCnMaF6T2Q8DsiSyMfr5wKNRffJTTBvp/kcqCenuboE9TcROO0ofPnXgXXA985fJ4M
         vuUnzGiE6x23zJ/mIE/A69GopklHNTGg6xZuKT6iFbsQgXSEkpte1ED1KxdpQpZXgoVT
         IIhQ==
X-Gm-Message-State: APjAAAU7ddwvsEKSUrdGzuqZJjdiUIsyEF1mt6P1amJM0mlGrEqg691s
        Cqyl54FvBNR4NsA58/Dsj5Tc+g==
X-Google-Smtp-Source: APXvYqznfhLaxA8m6jbIo0f2honvPCAF7TM+8aSKfg9a953CMl7wer84sA2VTun9dTN3WkfJar+kGA==
X-Received: by 2002:a0c:aede:: with SMTP id n30mr17975282qvd.152.1566396746122;
        Wed, 21 Aug 2019 07:12:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y67sm10110811qkd.40.2019.08.21.07.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 07:12:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0RLd-0006WN-3c; Wed, 21 Aug 2019 11:12:25 -0300
Date:   Wed, 21 Aug 2019 11:12:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
Message-ID: <20190821141225.GB8653@ziepe.ca>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
 <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
 <20190821125645.GE3964@kadam>
 <adc716f5d2105a3cc7978873cd0f14503ae323d8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc716f5d2105a3cc7978873cd0f14503ae323d8.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 09:39:50AM -0400, Doug Ledford wrote:
> On Wed, 2019-08-21 at 15:56 +0300, Dan Carpenter wrote:
> > On Tue, Aug 20, 2019 at 12:05:33PM -0400, Doug Ledford wrote:
> > > Please take a look (I pushed it out to my wip/dl-for-rc branch) so
> > > you
> > > can see what I mean about how to make both a simple subject line and
> > > a
> > > decent commit message.  Also, no final punctuation on the subject
> > > line,
> > > and try to keep the subject length <= 50 chars total.  If you have
> > > to go
> > > over to have a decent subject, then so be it, but we strive for that
> > > 50
> > > char limit to make a subject stay on one line when displayed using
> > > git
> > > log --oneline.
> > 
> > 50 is really small.
> 
> 50 is the vim syntax highlighting suggested limit.  You can go over,
> which is why I indicated it was a soft limit, but there you are.  It
> leaves room for the displayed hash length to grow as well.

I use 75 for all text in the commit message, as per
Documentation/process/submitting-patches.rst

People using 'git log --oneline' should have terminals wider than 80
:)

The bigger question is if the first character after the subject tag
should be uppper case or lower case <hum>

Jason
