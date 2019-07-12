Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688C966BFF
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGLMDb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 08:03:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36802 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfGLMDa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 08:03:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so7772441qtc.3
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ya3olqXbNYZ2YSMN5Vo2GEPYRI+CuBxMvSFn7d2uS84=;
        b=aotkFJFqvusMX1OerhuocXFj7/j+XMydcgBWATpaSaQpjePlEHXuw1+eLA3XqgzVgo
         3Uk1mq1uWIcjr/P13VqQNxLGQbZ9Le18lGea64pNkkEoS62ag3YJpvCUAZLxtXsOF2KI
         wLVUSJX9QkQNLAYnKTThOtDh2/xxmx0ryuFqTeqTP3jTt6PVz5h9isko1yzVEv6CeJWf
         PJ53HLvamfbEldE0osqQWh+20am5UjiuwTrt+NFhIr9CmjgssvNA72uAe9CbQs3OwFoa
         ksfLHaCMpnjAnzf8bCmJRSNRE1X7pAtY8pNvZbMuhFYTs6kN6ijHpb3bOnz9ru+2gwkM
         sB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ya3olqXbNYZ2YSMN5Vo2GEPYRI+CuBxMvSFn7d2uS84=;
        b=go+lih9F1PgRkwCNVUrMiEughCwQqKGzFbIpXk0pLlWekHaYjRnfx76cIYNgCv+xnP
         yBDlsWH0kAMUKz/gFrALxDFJ6lXag6UKRARk8/lVgzukumLbIrq/IH7kItrQ8DSQLUVO
         K/jKUGRR67zXCH3GnFdVI3x69V5Ij3v1u1ceA3YxRyJCkyTrNZdF6eJCgiKhzX1DxGrr
         F8LQGsPBy8kunBTiViauBvWLwlNLoYfaOn/ldMpxTFCQtQ5HgLh8yw71eIXHoGgmc/V5
         w2oo/+xe0k6D44B1ayb5UOmd3fV9wbq2Z5NmSgFUFvBl+1lQzMD9hiO6MqG2Mqorp232
         oLAg==
X-Gm-Message-State: APjAAAXb+Zu4N9ow57QFI/I/BbJv7pqZyqrLrGSbwGdzNAnaMeH5Mrby
        G+nufS+nh42ZJmZthd/yhoGLLA==
X-Google-Smtp-Source: APXvYqxudGKXGX8PVBjgTwtRs3qNjn2Q+HrcLltih4h0otrVbHxru0sA/MmXmqlsVAjzxXP/MEWGrg==
X-Received: by 2002:ac8:7349:: with SMTP id q9mr5963086qtp.151.1562933009442;
        Fri, 12 Jul 2019 05:03:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 2sm4189831qtz.73.2019.07.12.05.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 05:03:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hluGu-0007MM-MT; Fri, 12 Jul 2019 09:03:28 -0300
Date:   Fri, 12 Jul 2019 09:03:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712120328.GB27512@ziepe.ca>
References: <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 11:33:46AM +0000, Bernard Metzler wrote:
> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> >b/drivers/infiniband/sw/siw/siw_verbs.c
> >index 32dc79d0e898..41c5ab293fe1 100644
> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >@@ -1142,10 +1142,11 @@ int siw_req_notify_cq(struct ib_cq *base_cq,
> >enum ib_cq_notify_flags flags)
> > 
> > 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> > 		/* CQ event for next solicited completion */
> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_SOLICITED);
> > 	else
> > 		/* CQ event for any signalled completion */
> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_ALL);
> >+	smp_wmb();
> > 
> > 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
> > 		return cq->cq_put - cq->cq_get;
> 
> 
> Hi Arnd,
> Many thanks for pointing that out! Indeed, this CQ notification
> mechanism does not take 32 bit architectures into account.
> Since we have only three flags to hold here, it's probably better
> to make it a 32bit value. That would remove the issue w/o
> introducing extra smp_wmb(). 

I also prefer not to see smp_wmb() in drivers..

> I'd prefer smp_store_mb(), since on some architectures it shall be
> more efficient.  That would also make it sufficient to use
> READ_ONCE.

The READ_ONCE is confusing to me too, if you need store_release
semantics then the reader also needs to pair with load_acquite -
otherwise it doesn't work.

Still, we need to do something rapidly to fix the i386 build, please
revise right away..

Jason
