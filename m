Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6522D474972
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 18:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhLNR3z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 12:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhLNR3y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Dec 2021 12:29:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23413C061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Dec 2021 09:29:54 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m24so14059158pls.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 Dec 2021 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPnKfe2zLJtM0ne1yutGkX0rwY/NUzAu6ufqk4cLfNQ=;
        b=W3nCew0FfyK9BSCfv6skgMVyEcRmpQ2yKeI0NMEVZO+ye43k4YOueW1yjLCEXuVFQA
         upCqkOaFJiIUwdz2pyOVaBxa/paGPyFZdghUsxsISsqnqlhZoPhVWN8KAeqsxV5MW4ag
         GimeCGnAGi2IDNVwgseG1TKjVAaAqcDc67of8KmBdB2Arjx4VKMaLPcZiJUw0E+I4/v5
         hzbHijh7Fhz5rs+qrKJrNgeaAuK3dyByREku3HgjjZj1R2JcByu8kFj2h20t8SY4G/jP
         Pqsy7gCBXItn8N4uHXHETlKVvyCj9nHyJgiEZqW+7PtjZnvLYGTcnA6EezlW03BWgeF0
         8Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPnKfe2zLJtM0ne1yutGkX0rwY/NUzAu6ufqk4cLfNQ=;
        b=AwoOyhuvAfXnYyG7CLPUBDTQkQTIiq14rMK2l3IjowKrnuoWEbOYwZdcrNHbeOZP6N
         PxGH0orqAk5qVNDJdZqEFH6B27rslWtQ99AWBjR5pCGrZ26k9cd/WvC6Anr/vzeoRYXm
         uJwYzpwM4RuUijoEOmSYJCH06ck0FPgBaCIuITmeulVfZd7rwVJDXiRMSt1dvwbPvySK
         BO4Rbm0UJWZLIIXo2QAjhegvLIodHlrH9dxEyuA1qhereMi8qh2rOs0+iZ6iS0DNpSXD
         bjJD5Eb3++R15bYIoGjOOb4sZBe9XUX1ZGYpN2Wk8ZLtV6zwxFjsG36uSJ+HxP9IGvMH
         LsjA==
X-Gm-Message-State: AOAM531zrz2RqJbi7jijFhEDZHUTTiHhZ8F8UhSANXThLuR3ctCHAGrx
        n3fGDy+J4aFKUkE6YANo5pyspw==
X-Google-Smtp-Source: ABdhPJwQfjfgQdmwB4R4AdkrtkEyiU9Uul3yZAEt/bO30TDvOpl2QDStDYTgeWR+SXQG5J3Q1N/RJQ==
X-Received: by 2002:a17:902:e5cd:b0:148:a2e8:2762 with SMTP id u13-20020a170902e5cd00b00148a2e82762mr328249plf.105.1639502993690;
        Tue, 14 Dec 2021 09:29:53 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q8sm423475pfk.152.2021.12.14.09.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:29:53 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mxBcd-003kA7-Bh; Tue, 14 Dec 2021 13:29:51 -0400
Date:   Tue, 14 Dec 2021 13:29:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: Make the source udp port vary
Message-ID: <20211214172951.GI6467@ziepe.ca>
References: <20211214054227.1071338-1-yanjun.zhu@linux.dev>
 <b80a409d-3404-75d2-449e-7b8f41296f26@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80a409d-3404-75d2-449e-7b8f41296f26@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 14, 2021 at 12:27:24PM -0500, Tom Talpey wrote:
> On 12/14/2021 12:42 AM, yanjun.zhu@linux.dev wrote:
> > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > 
> > Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> > get the source udp port number for a QP based on the local QPN. This
> > provides a better spread of traffic across NIC RX queues.  The method in
> > the commit d3c04a3a6870 ("IB/rxe: vary the source udp port for receive
> > scaling") is stable. So it is also adopted in this commit.
> > 
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> >   drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> > index 102dc9342f2a..2697b40a539e 100644
> > +++ b/drivers/infiniband/hw/irdma/verbs.c
> > @@ -690,6 +690,11 @@ static int irdma_cqp_create_qp_cmd(struct irdma_qp *iwqp)
> >   	return status ? -ENOMEM : 0;
> >   }
> > +static inline u16 irdma_get_src_port(struct irdma_qp *iwqp)
> > +{
> > +	return 0xc000 + (hash_32_generic(iwqp->ibqp.qp_num, 14) & 0x3fff);
> > +}
> 
> How do you ensure the resulting port number is not already in use?

It doesn't matter, it is never used by anything, the receiver captures
all data with the roce dport and ignores the sport

Jason
