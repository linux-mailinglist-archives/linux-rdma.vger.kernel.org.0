Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954202D7AF6
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395146AbgLKQaB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 11:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406751AbgLKQ3n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 11:29:43 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E54C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 11 Dec 2020 08:29:03 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id y15so6809177qtv.5
        for <linux-rdma@vger.kernel.org>; Fri, 11 Dec 2020 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pg6occ+XDGUtKScupx65iGAg2VYQ8ZDvmjdHkQMZn5c=;
        b=QuUZJcV8a89j8JgDWhHcI3UFbQIlD0itsbq54D+BNt62zmFHML7sv2G56bbyu3gud+
         hyfNtZFOxLkz8HjZXzx0cjcRp2RgLdI6vcWT3WC+9C2lABXPjS+x3BnGkhtis+F0pqi5
         NGRIN6PvYDKJQS5f5YmTdHM31e1l4wLSGIK++ayk+9cRGLacuFqox+W9I56o80VlU3Ds
         u2qaiA95Oh4CsfTizzbiMS5+6rIroZH46iy2S6T/cRXIQA3GTz0bkyX63U3Z6iGpOM8g
         1h5y1Ds/bq3yhy8HfB2wsSsY69lHwZC9P/VnTea3woP2jODvp4LZQrH3vYrLzIYbYdQD
         u5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pg6occ+XDGUtKScupx65iGAg2VYQ8ZDvmjdHkQMZn5c=;
        b=Zv4H9rm0WR+4l2SvZKOiWqkNaRd6tIC4jy9k+u90BS0oCHnjaxLwsPnuHgVUKViyQv
         RDs/aXm5pv7nPfoKygwBs4sGEw6Q+yy9qHnVw+6w/oOVo7oFU5EWeflRqMWKDxGn+nXO
         bguT1oc9Jj5/70b8st1xzqR+2bqLcXh6kkrbC32l07HAYVx9ahnm5L1QELMGAMhkMM3h
         Z8rJPV23Y+eBA2Nujs0wpG5dvS9ZnyTb/fyT8IT7P6kif2dSt+oXRIBMCfTfu6g8VIpe
         5xRdGwLVtkjyfKCm3aBCoiOPb1vnhb8B3FKiCpEtVbBWMcWvR27ukeJKcuzDPEJh2Hgk
         ZUeg==
X-Gm-Message-State: AOAM530CqGNlbqDoJ3EMW1Gf5qpQaCoxJG66C3Nk1A4v5mxsTjIkTU30
        9/zF3f6kfy+Bh74q8JzZnPNSyA==
X-Google-Smtp-Source: ABdhPJyV9TPpNRrYTvyw22Ur2oi24U94ls2YwyQHkyXhuL/1p6qdaM0HiclC1FtM3XN8vWj3iHJXFw==
X-Received: by 2002:ac8:d0a:: with SMTP id q10mr16523207qti.25.1607704142308;
        Fri, 11 Dec 2020 08:29:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id z26sm7371107qki.40.2020.12.11.08.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 08:29:01 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1knlHw-009Fmm-VS; Fri, 11 Dec 2020 12:29:00 -0400
Date:   Fri, 11 Dec 2020 12:29:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 02/18] RMDA/rtrs-srv: Occasionally flush ongoing
 session closing
Message-ID: <20201211162900.GC5487@ziepe.ca>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
 <20201209164542.61387-3-jinpu.wang@cloud.ionos.com>
 <CAMGffE=_axtHU=pAV3qx5FVY2pB786z3kffQwDzinOaH=yS5Ag@mail.gmail.com>
 <e841a2c3-2774-ca8f-302a-cd43c3b3161e@cloud.ionos.com>
 <CAMGffEmKAzy3dXVKhoZDAqLpZ6DiQiaYNQn8_0Fd+MQUXbn_eA@mail.gmail.com>
 <20201211072600.GA192848@unreal>
 <CAMGffEn4fbTud3qrrwnrS6bqxcpF6sueKb=Qke8N9yLvDeEWpA@mail.gmail.com>
 <CAMGffEnuNHacxqqdZsF0JMk3kTUqT9KdzNK_QzBF_FWjPWLN8Q@mail.gmail.com>
 <20201211134543.GB5487@ziepe.ca>
 <CAD+HZHXso=S5c=MqgrmDMZpWi10FbPTinWPfLMTkMCCiosihCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+HZHXso=S5c=MqgrmDMZpWi10FbPTinWPfLMTkMCCiosihCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 11, 2020 at 05:17:36PM +0100, Jack Wang wrote:
>    En, the lockdep was complaining about the new conn_id, I will
>    post the full log if needed next week.  let’s skip this patch for
>    now, will double check!

That is even more worrysome as the new conn_id already has a different
lock class.

Jason
