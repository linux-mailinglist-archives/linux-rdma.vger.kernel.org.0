Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608A51009DF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 18:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRRCc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 12:02:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35358 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 12:02:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id n4so21054852qte.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z79zwwsgji4SFMXHEfSp1PS5lpwQeTqxylnYvnO5YvQ=;
        b=G4gmT8u/dhtRz502SOpELmvfKZaDH0xdZDUeQ3PzvM+F/8TPFINhW9XiVilxcKlccr
         woeNITS+ALb3RzpArVrTV0TjJs6o7oaZ813EI+MVSgBI3vvBZw2iQdRphXw0Sf8PQFpN
         6SPSmfSD18ohdgcdzEU7xp83HpPclbv4ALFywYKr399DR5Ti1m7VRwsVT/KVFELzQyfy
         OtZfk45caXF/V08az/efd3DkKUlsEb3BDkOidcV/gBfBznIS81r3DB7wwmIevHRtm/5a
         bUL7bmjaBkEdaLi2T9dz8scfwDdC2+RipbT11lU7ZT3TdT5S0P/pyItqwVRBXIEPHMOr
         Qd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z79zwwsgji4SFMXHEfSp1PS5lpwQeTqxylnYvnO5YvQ=;
        b=ouMFw3tfvFaJbGBLfIF+OiqnH/cxcVblfrkVnP4o8auss4EMtaDNwD68p6ZuthCVRh
         ALgTDmc8pya4c4JPU42WYPlfxsaLMg4C3ZicIQtcizhUZnu1MsLQr9cs1gy1k7yZ3fo4
         LGJakmnHzCG5bJ3/5lHGr2yYCB59JB1WTNgTJTLJICPHtYNNwWzbfOu1kvsgZfV1q9vh
         vgPkfsxhyirIMYtLZJl4rsqMcFmttuZP0jxJa6ICNs2jWXSoKWoLGA05iHj7AwxLNYIk
         Yw8aSjemoAueLUC5H+R+lV2S+AXw8iSIrJQtCprqmI67VupYWaMeRbFeS4f9D991mpBd
         OGsw==
X-Gm-Message-State: APjAAAXSev+e+7YGJtjnBbSdX5P6BlmYU69kP4O7pMU+bPb56tZOCYTO
        gaZHTlMaW4iSwFR1weSq7f66K3EMoZA=
X-Google-Smtp-Source: APXvYqy78ipw8tY78yi3KhGGIw8CBROg3VW67rKwZaFwFBJfha5aNvI+jhL+u11bty10GiyzfCqdTA==
X-Received: by 2002:ac8:539a:: with SMTP id x26mr2616351qtp.390.1574096551102;
        Mon, 18 Nov 2019 09:02:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j7sm8710039qkd.46.2019.11.18.09.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 09:02:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iWkQ1-00016I-Mj; Mon, 18 Nov 2019 13:02:29 -0400
Date:   Mon, 18 Nov 2019 13:02:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 1/2] RDMA/hns: Add the workqueue framework
 for flush cqe handler
Message-ID: <20191118170229.GC2149@ziepe.ca>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
 <1573563124-12579-2-git-send-email-liuyixian@huawei.com>
 <20191115210621.GE4055@ziepe.ca>
 <523cf93d-a849-ab24-36f0-903fb1afe7ff@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523cf93d-a849-ab24-36f0-903fb1afe7ff@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 18, 2019 at 09:50:24PM +0800, Liuyixian (Eason) wrote:
> > It kind of looks like this can be called multiple times? It won't work
> > right unless it is called exactly once
> > 
> > Jason
> 
> Yes, you are right.
> 
> So I think the reasonable solution is to allocate it dynamically, and I think
> it is a very very little chance that the allocation will be failed. If this happened,
> I think the application also needs to be over.

Why do you need more than one work in parallel for this? Once you
start to move the HW to error that only has to happen once, surely?

Jason
