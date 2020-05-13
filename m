Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8D31D03A7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 02:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEMAfL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 20:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgEMAfK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 20:35:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278BC061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 17:35:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s186so13860733qkd.4
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 17:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W0ZQEN7ga0dc2y953RKuwDFvWVmhQkwP4C140g0h9uM=;
        b=TOxWqevyxw3M0QWnWOIOsqppeWkjkLyMF+AVscrFeMUBaHmTzGlwE3IYQMSgbYv/Ed
         DJdfq+6d110SvsA3pceOgF75HPJzGhrqBc9p8KNXNImlaOHS2cbG8mQd1cWNmt+wGiZ3
         5DT8jE8bodoe9o8CLsuvqXzdLXIn+44VoMWCrxikXWmD5yUIQ+MxwMLEFTZR/2Lq+Jh3
         OIs+dTrQbShDSFIB1prGG8a8+K9xkyeK2WSUu0FozX980TOriWzz0Bxch3CzmaLGAsae
         VJYNLPEh/+d78W44RJUNbSW7uAoL7zssbZ6y19uGTnVzrwDPX6oUrkSHn217VSSx+0JN
         InHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W0ZQEN7ga0dc2y953RKuwDFvWVmhQkwP4C140g0h9uM=;
        b=qjmUXJHJLAV9Kq9tBFkKYwDJEOMGGwq56vkZEpIKkGLzEy5vughpuLOfQs61UhRmnp
         hYgRFngTBQr7VFMPpeiYdy9rcf6RK/dWAlLjxO1zdWaKumfmi8/CIv5iVSD2wtxTs7Yk
         VgaMo6l5TsEadw4qxtE9EaAicuVtKEITaD6xn+wUP+9f95N4q5gq9wHISXK5+9btQDPM
         QTU4HKKRQTWhC6zO0GmoWBGm/LMrq6OWNSWa03/7ibDusvFOs24WUPl4QDlJXVKSGUTS
         yMH4y77eAL3qgD6PqTgtlse2LmiUzA81aD7dNuoQ61jgA9JqBan1Om0NEbVQIh2G1gL/
         t4nw==
X-Gm-Message-State: AGi0PuZI+vD+Myi1msLP5bbPOM8sZAhxa87nSS6oZXq/SAWzGAfMROfo
        lGc5fYuXNa2OeT8DPH7IUZRZpA==
X-Google-Smtp-Source: APiQypJlsdFx0FTVDoPPXKE8IY8M+QewagBieVDSzBEMNEqhPQJ64DnQ4+BbfFKl9ULZx10d7hSN7w==
X-Received: by 2002:a37:a2ca:: with SMTP id l193mr21616494qke.23.1589330109720;
        Tue, 12 May 2020 17:35:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t130sm8830732qka.14.2020.05.12.17.35.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 17:35:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYfMa-0005DH-PO; Tue, 12 May 2020 21:35:08 -0300
Date:   Tue, 12 May 2020 21:35:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 00/10] Various clean ups to ib_cm
Message-ID: <20200513003508.GA20001@ziepe.ca>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 10:46:51AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> >From Jason,
> 
> These are intended to be no-functional change edits that tidy up the
> code flow or coding style.
> 
> Thanks
> 
> Danit Goldberg (1):
>   RDMA/cm: Remove unused store to ret in cm_rej_handler
> 
> Jason Gunthorpe (9):
>   RDMA/addr: Mark addr_resolve as might_sleep()
>   RDMA/cm: Remove return code from add_cm_id_to_port_list
>   RDMA/cm: Pull duplicated code into cm_queue_work_unlock()
>   RDMA/cm: Pass the cm_id_private into cm_cleanup_timewait
>   RDMA/cm: Add a note explaining how the timewait is eventually freed
>   RDMA/cm: Make find_remote_id() return a cm_id_private
>   RDMA/cm: Remove the cm_free_id() wrapper function
>   RDMA/cm: Remove needless cm_id variable
>   RDMA/cm: Increment the refcount inside cm_find_listen()

Applied to for-next

Jason
