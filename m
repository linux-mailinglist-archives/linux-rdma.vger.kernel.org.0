Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9025C828
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 19:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgICRjS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgICRjN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 13:39:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572ABC061244
        for <linux-rdma@vger.kernel.org>; Thu,  3 Sep 2020 10:39:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t20so2542225qtr.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+XiidM5l1ZClMPOnF5Lw1+36i1wrYfsvX/Kt/On8Qk=;
        b=Sa/5besnZwcMuYbFi+AapDeSqnG8hyjSmuFB/zpFR/ZE3h83nDzsv65iIYE7qL3FIC
         aBeuZdZzK4NfxXuNcekWpYRvVhqK3skvH6wNsDWslNgMrmd+qgMKndxDXFMX4dnXnEX3
         t7n/H3WJeonjQpmN/M30bgt/RSAgAPTtdebJPI4G3pTA9JKA82wKp7uBtmI61WM/cwID
         n6hKDr5xWX9Z/cMMwJN3YYCq1oj/TrGyIEbOK8p1hxa4f95YHy933FiMTRyt0fk1ZwwD
         Iiw1NoHsyBu7xAUY0zXdgl8Qon3R/B/4yDKZP8mwIHuQDm1CIpIncYdQiInwnrNd2If1
         JDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+XiidM5l1ZClMPOnF5Lw1+36i1wrYfsvX/Kt/On8Qk=;
        b=cAPTtW3FPCa1wpp0pIinhhjAlT2bYtmq331X2gaQsO+Z67KCeBe/NZkBCTNks67JlM
         cWzk5Q6zh8PU4DdN+jqt+z2HZQy51BAJO8j5DYITADwd32AAko4b6LEbYxsH8mSm25F+
         +qI3HzqCXXfzTlX0W/ulS0QBjQAj6jUM0KYSJRm5qChh80S4+xurhd7P0AZ09j3R3Igx
         mQWm3A3hrtNU1Iat7QtTrgSpZRFgMMbLGSUaGSdblvLqtV8/IkJLuwzDomr+ob2k9R7T
         hr1qBg1riMPJ0VMYSrY5w8sexOZon628okQ7P9PP90FJ5LlPHyQpNBOk01Pjp6suR9G7
         O+Rg==
X-Gm-Message-State: AOAM533ZBpZu7GQ9jxN6lYyxr9xF/m16ogz+oCNDsbecdRfa0GghzgY4
        +1bF/lNRJU+pe/sYApypX2WPy3PRpm/uwg==
X-Google-Smtp-Source: ABdhPJzLhHk9TbLjlyG7vQi3YtIXuOH4zXvm5+xBOl4WqcwzNhLzWZpXKnMDasDA6i4S4Zqv0lnPOA==
X-Received: by 2002:ac8:e89:: with SMTP id v9mr4739863qti.100.1599154751316;
        Thu, 03 Sep 2020 10:39:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l5sm2637585qkk.134.2020.09.03.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 10:39:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDtCY-006doX-2y; Thu, 03 Sep 2020 14:39:10 -0300
Date:   Thu, 3 Sep 2020 14:39:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Finding the namespace of a struct ib_device
Message-ID: <20200903173910.GO24045@ziepe.ca>
References: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
> When a struct ib_client's add() function is called. is there a
> supported method to find out the namespace of the passed in
> struct ib_device?  There is rdma_dev_access_netns() but it does
> not return the namespace.  It seems that it needs to have
> something like the following.
> 
> struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
> {
>        return read_pnet(&ib_dev->coredev.rdma_net);
> }
> 
> Comments?

I suppose, but why would something need this?

Jason
