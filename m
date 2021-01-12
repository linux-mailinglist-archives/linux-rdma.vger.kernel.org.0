Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE55D2F39C2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jan 2021 20:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391784AbhALTNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 14:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391614AbhALTNw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jan 2021 14:13:52 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9FEC061786
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jan 2021 11:13:12 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b64so2868117qkc.12
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jan 2021 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOW3YBKV/dU2/TWUguOM49FKZbR+M3nXVm8t7DxX6wk=;
        b=hzSAlh/8BpkCaPMpzwhCf6YxMNz9lF2cbnQbAWLD/Mew6UzjXpbHe9++GWFb4YDH8F
         5dCsJZAMS9eYVhtCoYfoXNZ4+3nc8npBuArU+npEshEWOaUTUlFo4KxVB6JPKUw/sWRf
         zL8EX7KfkZ6QGIN4vgCxAHttaYJPLlqIPwdnsZXiUbhui3sycP+FzzPOtAOeptUVTsob
         OooRyrDs90Gl3ZTFAXJhO0W0Uz79R4+jU9N6ed00wR5t07uWvJibp5PTv/fiUsY6KGRI
         Cbn/w7bknJnXD/ioS1V+h+XH2sOKz3CsLnlE8Ux2JV3Z6h4l0qqZ7xDztcnc136DrWpC
         MlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOW3YBKV/dU2/TWUguOM49FKZbR+M3nXVm8t7DxX6wk=;
        b=j3zXjTYwV1AkouXw6dyWZU1wrG0pS058c67tXOnjq4j3nmCYx3E63YOx8BNl3cdlXG
         VpXhtuhWPVzRNtd062HtY6lLeM4+JGJemrRClU9ISRLwZA5z7I+8Z6i2uE5dDo9aBRYF
         CubUUZOZqU23uA+mjGK3QsbTIVQ6ylIImSYS3y7A6dVDoelgCx+EBVib5s8jfdfE4c06
         +r6ezVNtmBL03wmfMW7ogqLEKDXZjaxTTnnnLACa9FFq5eUaB/1kbWOn9E5IPdUFcbts
         UdQSIDSA9gFw5lwWp/rb1ggh3QPiK6fglZhV/7yQYABx2BzChO2Y9wsVEe9Mp6f9KmrI
         f0gA==
X-Gm-Message-State: AOAM530JkqFdQM/khlDW40iMiuqTFqkXLkaBJj9M4b/5uvpJcZa7hocT
        LmgX8XCtsDVwVl+xK6htG5xzJQ==
X-Google-Smtp-Source: ABdhPJycxsoW2y0fU4CSjTX3z8xAuKkMOhNs7xOOhN4qvHT6wQqOjTrR/U+RgzJZCrloyIcXD96UaQ==
X-Received: by 2002:a05:620a:46:: with SMTP id t6mr899928qkt.108.1610478791602;
        Tue, 12 Jan 2021 11:13:11 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f10sm1649110qtg.27.2021.01.12.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:13:10 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kzP6L-0004H0-K5; Tue, 12 Jan 2021 15:13:09 -0400
Date:   Tue, 12 Jan 2021 15:13:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 02/19] RMDA/rtrs-srv: Occasionally flush
 ongoing session closing
Message-ID: <20210112191309.GC4605@ziepe.ca>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
 <20201217141915.56989-3-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217141915.56989-3-jinpu.wang@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 17, 2020 at 03:18:58PM +0100, Jack Wang wrote:
> If there are many establishments/teardowns, we need to make sure
> we do not consume too much system memory. Thus let on going
> session closing to finish before accepting new connection.

Then just limit it, why this scheme?

> In cma_ib_req_handler, the conn_id is newly created holding
> handler_mutex when call this function, and flush_workqueue
> wait for close_work to finish, in close_work rdma_destroy_id
> will be called, which will hold the handler_mutex, but they
> are mutex for different rdma_cm_id.

No, there are multiple handler locks held here, and the new one is
already marked nested, so isn't even the thing triggering lockdep.

The locking for CM is already bonkers, I don't want to see drivers
turning off lockdep. How are you sure that work queue doesn't become
(and won't ever in the future) become entangled with the listening
handler_mutex?

Jason
