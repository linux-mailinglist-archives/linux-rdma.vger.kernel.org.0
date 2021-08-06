Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B03E2BEB
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhHFNt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhHFNt5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 09:49:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D520C0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 06:49:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id js7so4899820qvb.4
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jbiC7cFEWti1YXy9WPyVT65ZcgBTUeGUO+V0/R7zwWg=;
        b=YctemMllS/qVRPBFP0/vcEbUHAwMkXV1S7hWpLT2qbtJrRoZpBRSWLrkRokwTjylEf
         m5ZVqezvANUixXCCMW6Ibckr9phe4Kob2fCyVwlBIRXZvfCxxl8VXQehkhU8R+0JiaHS
         nGmvTVnaKIUk4QZBC0/iImG2iCQ6xKvXHUBrD22K3SG65PGsgFSv8ah/BXUmqk83zEkN
         ArNFMumuvbZ0mdTOsKL//XFwdBc5qHkaipz81trPvSu14Y5f1kxCZX8HcKH6tcWV1QfL
         GqGA0eLUdQ9GfvTrMtyMTC7K6LEDT+E58PZuRGqza7wie042UUGR0i+M/GK/+zxYBisZ
         6W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jbiC7cFEWti1YXy9WPyVT65ZcgBTUeGUO+V0/R7zwWg=;
        b=DOOsO7vgNH92AZjVsLvZfJOVf3TnTS+AeF6QxqnKyqM8tEWj250ah1Gnvj1yRzlXyF
         //WkvCC7YLyIX8oOmw5I7WivB19kKvk89aZ/v8h51Qan0fxsA5PbBtQik9Ng/A5Z1hyI
         +n2DxvjVUzvv3h0/GyiWhPdg7+ybn0qC6gBov93HaBgepV5l9qPuowL7UPIDzSreDLWb
         PsMTWnXGvRqHZpjLodctvGJiMppm5i5v0BCFceX24ZAgNLRn6nLP53FGRRLodOCfHOd8
         6PnOH+5RSNfy7aNzGscsTSWzbKvHQrPG12A9Jj2r/NC83eXxBvmnPHOtqacCpy2YShWt
         YPIw==
X-Gm-Message-State: AOAM532l/WE4TQ2BdoFNj7CexjCiVq+t+fV60U9U3XfxJbAXh6J6i99Y
        GJbdidGOJt7wxUFtHHLfByLEqA==
X-Google-Smtp-Source: ABdhPJzwtSENkf6wm7ul2O9rirC7wEEF/Z0EXO8Jf+f2kj2giKmxE4DmqrIBlVCwQNeI9eYwwH184Q==
X-Received: by 2002:a05:6214:19e9:: with SMTP id q9mr24172qvc.28.1628257780343;
        Fri, 06 Aug 2021 06:49:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o63sm4672932qkf.4.2021.08.06.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 06:49:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mC0EF-00EGD5-1f; Fri, 06 Aug 2021 10:49:39 -0300
Date:   Fri, 6 Aug 2021 10:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Message-ID: <20210806134939.GN543798@ziepe.ca>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
 <d89b2a2d-e72b-4942-28d6-c2a528053416@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89b2a2d-e72b-4942-28d6-c2a528053416@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 11:11:15PM -0700, Shoaib Rao wrote:
> Bob,
> 
> Your third patch has an issue.
> 
> In rxe_cq_post()
> 
> 
> addr = producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
> 
> It should be
> 
> addr = producer_addr(cq->queue, QUEUE_TYPE_FROM_CLIENT);
> 
> After making this change, I have tested my patch and rping works.
> 
> Bob can you please point me to the discussion which lead to the current
> changes, particularly the need for user barrier.
> 
> Zhu can you apply Bob's 3 patches + the change above + my patch and report
> back. In my testing it works.

I'll expect Bob to resend

	[for-next,v2,3/3] RDMA/rxe: Add memory barriers to kernel queues

Jason
