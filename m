Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494C1195ACE
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 17:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0QOo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 12:14:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36235 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0QOo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 12:14:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id m33so9010505qtb.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2020 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCMfmYa0MwvjJaO8/+hZCxz5ubVIh6qICrlOPYX9FgQ=;
        b=BJavhh/W8bd4c4lRdGs1fHb6pPanFC/ytX1QGroDr+gWWGePgTEu7En3iMMXy6CqT/
         j/NBJ3Jj+Fr2zQmsnM7zr7rTQ3ZCbNZG0haI0yO215AlV3xsicdn41fQzVtPXCscG7NX
         hgoTs8twRXFpJOfKIOH7XzxuXiIvVwcyJcOyq0ew7yLsm5MyP+NVNJaB/jf8Ym/Xe5bJ
         AqsCX3zmM8JnCKJ5pGQ31Ej4d8ewHa9Ln48qvIFvLJo2X/YcRN6mTbZck9bjAP8RWWQK
         p9RgK5yf7Au4+JFJCADg6Id0nnxJqrkIcrqWGMiD9D/o5Ck0ty3fn10u1cWQxyS2Ia3d
         N4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCMfmYa0MwvjJaO8/+hZCxz5ubVIh6qICrlOPYX9FgQ=;
        b=RTNNuq07GXJb33QXJmTTY8BiKYGxFj+RDP6B6P5xtW1S23gJM1kAFqVcS5RlTQHv3/
         OWGrEmj9q4mDhrm+NfENIrMBSC+XHnYXNqfjrYKNm20n1VPW9jXUU8YaKyJf6AfgCFuE
         gQ9THm0E8rLVmlQ1ylYvV42m1t1aHdKdRGE8ruTp6E6aarBD9MLLnflpUUrnmBFScu3r
         lXHWPSQbmPb9d8O/0mMMHGfX1Ny9H83/hNDUB1+fcJPE7FtYoyIz5rKSvN0KUtNLhHG5
         vIqT4ZjQqL6nQA1JGzTb4W25xQ+KTT1p5rUCATqMx4Co4MKnYopXm1ZpIDvrTY2ZB0tU
         ndyw==
X-Gm-Message-State: ANhLgQ2lKOH92PtqdRZwrcTB2CzGr3q5EuYX4/ohGieq6JDK5SLdGU2u
        D7n69IGmUmzjALAb1TxPavm0dw==
X-Google-Smtp-Source: ADFU+vvxTZpE7Qyik+fGqGcC/9kGLFpBvR4D49VFsRbR0cB6nXoe+AupyyO2l2F7TrTwuPbbOEcbtA==
X-Received: by 2002:aed:34a3:: with SMTP id x32mr14855991qtd.306.1585325683153;
        Fri, 27 Mar 2020 09:14:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 31sm4126416qta.56.2020.03.27.09.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:14:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHrd3-0007ov-Rz; Fri, 27 Mar 2020 13:14:41 -0300
Date:   Fri, 27 Mar 2020 13:14:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/2] Pre-req for hfi1 cdev rework
Message-ID: <20200327161441.GA30032@ziepe.ca>
References: <20200326163619.21129.13002.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326163619.21129.13002.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 26, 2020 at 12:37:59PM -0400, Dennis Dalessandro wrote:
> Kaike found a couple issues while working on the cdev stuff. Here are two fixes
> that should probably precede those patches (which are yet to be posted)
> 
> ---
> 
> Kaike Wan (2):
>       IB/hfi1: Fix memory leaks in sysfs registration and unregistration
>       IB/hfi1: Call kobject_put() when kobject_init_and_add() fails

Applied to for-next, for-rc is done now.

Thanks,
Jason
