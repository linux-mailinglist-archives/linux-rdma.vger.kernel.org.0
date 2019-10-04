Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796B4CC1F5
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbfJDRsG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 13:48:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43268 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388281AbfJDRsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 13:48:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id c3so9638562qtv.10
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BjSzKuSHFfqBWu4h27aRuvSexcHce2KUfD5rtFhLW2E=;
        b=OQUcixgC4ildWy7phj/dXpGKTYlXb8qXor2PNZn9hvheQN6ZprabgtY0VdY87W1R5u
         OxMIiAqLrmhhZ5HKHZWha64EPoBREzn4+r3vir/wRDSA/JEE3Yqp8vAPO50z8eh+HqPw
         EKbQyjP0kL9u/6DI6OP6UqSBorrxjf29Pt3Aod3MBQgOY30T7nUpf0H5sifvrlLQdfO1
         qX68qJLZ9BLI5w8QOIDDHhAIdDSshwt95ptVtmDyzu8Skm0Ayr4f6ERD6J1ezk+GLjLL
         eXQ+qTvjFj6HFLEOjuTSX/gU2eZd7/A6Z+H3F/MAu03FAIp672m0WYB8W7pyKPIe21CA
         QWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjSzKuSHFfqBWu4h27aRuvSexcHce2KUfD5rtFhLW2E=;
        b=HcT/49PuAbtH088XxeTwjVVg2UcSe7a8Vuu3xbBzTKBYGLkPeGG5C4hO0l9ysa84UZ
         0AXK+WUnhbbOpiJ6TIZToOM5w0T78WOJWI+mKMxLwWLwepzoMm2TZnOqKkqEKvMsi3j2
         3yDapG2K3WzJKhXua5Mpg8B8ykDCJZE6jrmN1u3NQw6E+BV/xvDCwMX0sb2zhX3UXiYf
         jfroXhqPQ/SK0/NJE3I2js5kA8EGaQg2zkPACHA9T8oMTS+4kDukzJ98hH/KNB4AIJ98
         0cUDqekiq8tr4sjfrcfRI7KBBL8PCDMwYIOmqp/KqKg/gKut1wQ2RkQWDGrH6+BXQjq5
         8qDQ==
X-Gm-Message-State: APjAAAUvdQDUDk1l8hEErhPdyfDqhs5zmkUiuL/1j3surPhXCY5i7nW6
        L80bbHASxL7wu/rL3ExtGNNGuw==
X-Google-Smtp-Source: APXvYqz2UjEpyWchB2Q87FWceHQm5tBs5qCrh4CUNg2I0CndLJ3fIq/JW4inZrf2pKByvUQmSohxXA==
X-Received: by 2002:ac8:1c34:: with SMTP id a49mr18017806qtk.182.1570211285633;
        Fri, 04 Oct 2019 10:48:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q25sm2692418qtr.25.2019.10.04.10.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:48:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRgS-0005vU-Nl; Fri, 04 Oct 2019 14:48:04 -0300
Date:   Fri, 4 Oct 2019 14:48:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
        bvanassche@acm.org
Subject: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191004174804.GF13988@ziepe.ca>
References: <20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler wrote:
> <...>
> 
> >>   *
> >> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp, const
> >struct ib_send_wr *wr,
> >>  	unsigned long flags;
> >>  	int rv = 0;
> >>
> >> +	if (wr && !qp->kernel_verbs) {
> >
> >It is not related to this specific patch, but all siw "kernel_verbs"
> >should go, we have standard way to distinguish between kernel and
> >user
> >verbs.
> >
> >Thanks
> >
> Understood. I think we touched on that already.
> rdma core objects have a uobject pointer which
> is valid only if it belongs to a user land
> application. We might better use that. 

No, the uobject pointer is not to be touched by drivers

Jason
