Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE6322AAD
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 13:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhBWMjO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 07:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhBWMjO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Feb 2021 07:39:14 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FDC061574
        for <linux-rdma@vger.kernel.org>; Tue, 23 Feb 2021 04:38:33 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id v64so157906qtd.5
        for <linux-rdma@vger.kernel.org>; Tue, 23 Feb 2021 04:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pmQQlKLlZszK4+7R8XJNShIFqVlQjRcSkOrOfXwNwMk=;
        b=BumIWXFaj3DReVR9lg9J71X0M6WrH1wLGZ/5Dm61yKqAPk8YJG9J3FnU4XASe6gY5B
         7dqEI5pxcW/u5el0OOO79Nr3rZK3N3uclJIiHgCaqjpfS1MnsGNG80N0Hvi3TVHvWfqt
         IOIpVqCDdSOFjZ3lmx20GRxdkf2q616LMfi1E5OG6Alcv+tVrtyhK3y+Sb1Ov6o1o5S9
         nzhVvmCIKSPUkUR+A3BZItphIIhiawhhrsg1DSBd1LW5wwUaLJB6ZfUg94qfUrt74ZOw
         blbA++Ry6aeagRjm/htrhenaBHpauxwFEZfoBKb11DwH+jm5bD+uL+j63Y04sYR1aypE
         jOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pmQQlKLlZszK4+7R8XJNShIFqVlQjRcSkOrOfXwNwMk=;
        b=Iwi1b7NH3LAVLGjVz63FP+p1pvquNYQ/idnrHRgpaXlHW74Eih4kWg8sT5Y4LcNEJo
         Uz46Y+7ImN8GarT1vXHyFsl/sCmWtt0LYCVJaEVh4sMyDw0swf6bWDlJFfRoE/DwSJYv
         uB8BXREGitpcuux/WWRN1Q5w6a9EuGo/rizwQZfAFjZEk2BNF7WuBQAtK1+OUnVvhGBG
         PVg4otF1TUk0RYE01dtfuEwM3PqBnpffHRZ50fsQUjlKEW+E6qQ7VbXBT8gqs2rciHaJ
         l3uY6KLZwIhODMvJG/fIPxD14O/v3Jw8R7vPxGySwrUBkZTx53dyohS2DCJf3bScgjvW
         5OBw==
X-Gm-Message-State: AOAM533/VS99wbISp0IkA+3Gm110jQ4VKnRzS7QBPiSkoE2pbjTdXUiy
        Bhz4bR2M6BV+adnHS5+HchBDibqlh4fn0g==
X-Google-Smtp-Source: ABdhPJx+qyoKFNLH151FGnf/yw6Lu/wIabdNiRg67U2BVuIKXJNveE6kicMqUA52pHJeyIWiiiVHOw==
X-Received: by 2002:ac8:5881:: with SMTP id t1mr14985166qta.386.1614083912438;
        Tue, 23 Feb 2021 04:38:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p126sm4350443qkf.110.2021.02.23.04.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 04:38:31 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEWxT-00FMq7-74; Tue, 23 Feb 2021 08:38:31 -0400
Date:   Tue, 23 Feb 2021 08:38:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210223123831.GN2643399@ziepe.ca>
References: <20210218125339.GY4718@ziepe.ca>
 <5287c059-3d8c-93f4-6be4-a6da07ccdb8a@amazon.com>
 <20210218162329.GZ4718@ziepe.ca>
 <51a8fa8c-7529-9ef9-bb52-eccaaef3a666@amazon.com>
 <20210222134642.GG2643399@ziepe.ca>
 <e26a3e90-cc8b-d681-5d6b-4e363aa1933c@amazon.com>
 <20210222155559.GH2643399@ziepe.ca>
 <8277bebb-8994-af0f-52fc-972c7f8260dd@amazon.com>
 <20210222193746.GM2643399@ziepe.ca>
 <2fa24ddf-1add-a306-003d-0737b2b9cbba@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa24ddf-1add-a306-003d-0737b2b9cbba@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 23, 2021 at 02:18:31PM +0200, Gal Pressman wrote:
> > Does look like a documentation update is in-order though!
> 
> Looking at libibverbs examples, pyverbs tests and perftest, they all act roughly
> the same:
> 
> 1. arm CQ
> 2. post send/recv
> 3. get event
> 4. arm CQ
> 5. poll
> 6. goto step 2
> 
> All of these apps always use the same construct of get event followed by an
> immediate arm. Did all of these apps get it wrong?

Sean is right, this is OK, so long as step 5 polls to empty, it is
just unwound differently and will take suprious wakeups more often

Jason
