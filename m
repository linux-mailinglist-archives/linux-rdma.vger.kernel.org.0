Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3946E18C2A2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 22:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCSV6s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 17:58:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54346 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgCSV6r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 17:58:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id f130so3288948wmf.4
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DB3YYIIUIJs2/T8ItUVmTy2bglm16clHCLna3e3Z/lM=;
        b=Zoh+9qjnRHoNgsfCd7D5XU1zfR302FMUQQB1Wn1fqY3N/9KlDRLWTxLGYrwTE9/opY
         B366klEBpJPqjX5Z6m8GDjjdT4Tp3xLMn98UnndiRQaFdpRFjBnc3XlBS5gKE6OsPrEV
         kbT4bow0NwcgwrH8gG0kbR+PVZuW7fUV3F4W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DB3YYIIUIJs2/T8ItUVmTy2bglm16clHCLna3e3Z/lM=;
        b=rBpfvGj6GAqgigdrxJSUWlbNaf8igwc/1CH9A9JSGPT4Dwy3fC94S153n3ocYPGeVr
         pRGUSktXrx0jnpsMYWNNj/+ECe0NxArDcukEVTK+be6boeI2a2aNAM6rbr+bWNSqn7v0
         HVLD77PmpPKKdYzpPfRb5YeF81xiE9dRQDXakd8R4N+5hW5wWt3Xb1SdcJ0ozNxQBhX1
         XgFNB0HA0bf4kGQZ6ARgv8UNe1LvQfK0R4ryViK8nAh8mSbxMnmp3ZZVHfhZxc2XZ+fx
         1L5UlECoz1T3eyXXglt+qe8btfg262Fvgn/eoDIHLOYsplM1hGYmiX3Qb/EGgFPCsUD3
         Im/w==
X-Gm-Message-State: ANhLgQ3LgCrIHfPSOBjiDQBmA8Fq+mVG4jyO0awzD4EAI2gn7PFZEet8
        eh1UeO6rht8qEWB54SIOlad3BA==
X-Google-Smtp-Source: ADFU+vt/GtwStWc2HQ/XEuUayBLVnS5q98IvgRtLPgHTy5VC5y+I28Nm3aQgMRf3X5zmjtNIYbLD1w==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr6273842wmj.170.1584655124891;
        Thu, 19 Mar 2020 14:58:44 -0700 (PDT)
Received: from chatter.i7.local ([185.220.101.11])
        by smtp.gmail.com with ESMTPSA id o9sm5489305wrw.20.2020.03.19.14.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 14:58:44 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:58:38 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, loberman@redhat.com,
        bvanassche@acm.org, linux-rdma@vger.kernel.org, kbusch@kernel.org,
        leonro@mellanox.com, dledford@redhat.com, idanb@mellanox.com,
        shlomin@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        rgirase@redhat.com
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
Message-ID: <20200319215838.bwxu3esvu26q2fje@chatter.i7.local>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
 <20200318233258.GR13183@mellanox.com>
 <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
 <20200319115431.GU13183@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319115431.GU13183@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 08:54:31AM -0300, Jason Gunthorpe wrote:
> > I'm using "git send-email".
> > 
> > Should I use some special flags or CC another email for it ?
> > 
> > How do you suggest sending patches so we'll see it on patchworks ?
> 
> I looked at these mails and they seem properly threaded/etc.
> 
> I've added Konstantin, perhaps he knows why patchworks is acting
> weird here?

Looks like it's hitting a race condition in patchwork that will be fixed 
in the next release.

Until then, you can grab these patches from lore.kernel.org (e.g. with 
b4), though it won't help with git-patchwork-bot integration.

-K
