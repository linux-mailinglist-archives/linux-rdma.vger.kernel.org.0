Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB0E904C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfJ2Tom (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 15:44:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45307 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfJ2Tol (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 15:44:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id x21so4822343qto.12
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zMETJKIvIboVGm2P7t1vR897oQeA2KsEXow4IhA6tDY=;
        b=G15gO09VEbgVxfxcgxg+EGe3P/yFdb6u3W8sQA/Z4fHDnXqv3bEhrYXD7joM6y0o+I
         2yNF/BBu8E6+YyMk38XuUv0U1lYeoipBbcaf3PPQu1wsTMUTywWHNKDS6tAvGxexijD1
         44vymQQhZJiYKymmBCXnNfxuw6aQODppZqMJlhMOfqUdYcUnWX6mAHi8Gp1NZFgolVtD
         CDfcmUdDlLKwDqwVSfPWnBcwnNjz+Q5HcH26X9WX3GAZPheZi/9jPlItuwUWMpbst837
         lp2yBdwfu9lNzNRkYqirEq7x2L9XDK/pdnndCrRK338+6cAToxk6zlIjglJcGXc1FFRZ
         VFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMETJKIvIboVGm2P7t1vR897oQeA2KsEXow4IhA6tDY=;
        b=i9o8IPu5R2YWZYoC59g0vLAIVmtz4aWtiMKORFi6hKbJvkBelCqOh37B7rBLjtbv+W
         vev51tkA1U5BbKn0W05JrNW8xz7qWp3yPGewuTn6fSm0HJV7hwVxdtchHEfpHUztBbJL
         vvo8RmC5fxGjyb6wo5ZxzrY1kLv+/3CNR3bMWjZkqYrj0jeDB5K9GtdcF586GsIHKNlp
         FY3Gwwh+GSF/MvHp2XfVUqg3YFfhuHyc7nqisHshKt3YjZtO673wPVF6bTt8rZr1XZ6z
         NbMWVfCHYdjEpqX9MqWDN++3iq4YCN7KRRb8riex0B7epC+VuY9Bi4siFLsUTrfnaTxf
         JtsA==
X-Gm-Message-State: APjAAAX7G0q1AnpU0wyfmFDEds1lCWi4NziMVTQfVN3YzRXRZ/mBFI4M
        Ws1chUN7hCtNbjxMNtUfq9ZqIQ==
X-Google-Smtp-Source: APXvYqxeX6JoBanf1EyukpbdN26pAyp9JKWCOrO/+46M2g7+KtjjgAwYCV6NR7ptw8zPTIqgz9+UNQ==
X-Received: by 2002:ac8:80f:: with SMTP id u15mr858075qth.193.1572378279025;
        Tue, 29 Oct 2019 12:44:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id b54sm7377636qta.38.2019.10.29.12.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 12:44:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPXPy-0000JI-0q; Tue, 29 Oct 2019 16:44:38 -0300
Date:   Tue, 29 Oct 2019 16:44:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] rxe: calculate inline data size based on
 requested values
Message-ID: <20191029194437.GI6128@ziepe.ca>
References: <1571851957-3524-1-git-send-email-rao.shoaib@oracle.com>
 <1571851957-3524-2-git-send-email-rao.shoaib@oracle.com>
 <20191029191155.GA10841@ziepe.ca>
 <4c23244e-44bf-2927-6b9d-17c4d279ebe3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c23244e-44bf-2927-6b9d-17c4d279ebe3@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 12:31:03PM -0700, Rao Shoaib wrote:

> > > @@ -81,6 +80,7 @@ enum rxe_device_param {
> > >   					| IB_DEVICE_MEM_MGT_EXTENSIONS,
> > >   	RXE_MAX_SGE			= 32,
> > >   	RXE_MAX_SGE_RD			= 32,
> > > +	RXE_MAX_INLINE_DATA		= RXE_MAX_SGE * sizeof(struct ib_sge),
> > >   	RXE_MAX_CQ			= 16384,
> > >   	RXE_MAX_LOG_CQE			= 15,
> > >   	RXE_MAX_MR			= 2 * 1024,
> > Increasing RXE_MAX_INLINE_DATA to match the WQE size limited the
> > MAX_SGE. IMHO this is done in a hacky way, instead we should define a
> > maximim WQE size and from there derive the MAX_INLINE_DATA and MAX_SGE
> > limitations.
> There was already RXE_MAX_SGE defined so I did not define MAX_WQE. If that
> is what is preference I can submit a patch with that. What is a good value
> for MAX_WQE?

I would arrange it so that RXE_MAX_SGE doesn't change

> > Also don't double initialize qp->sq.max_inline in the same function,
> > and there is no need for the temporary 'inline_size'
> 
> I used a separate variable as I would have to repeat the calculation twice.
> I do not understand your comment about double initialization, can you please
> clarify that for me.

Assign it to qp->sq.max_inline and then read it to get the init

Look above in the function, there is already an assignment to
qp->sq.max_inline

Jason
