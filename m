Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2581207BCD
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 20:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406192AbgFXSxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406033AbgFXSxo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 14:53:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E55C061573
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 11:53:44 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m9so1554055qvx.5
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+WyMtpdyscjj7YI8N5KNeHwNsKq4xkorxnacKw4Knu4=;
        b=W4WrF+xQQXaqe3ydBML9Q3bbRoQx1x97Rd0cn5B1Ioo+lSeI0muY6XVGg7HPsyBS1m
         n7eBB+SfdcggglQ5kib0SOJwDw4fyJqKX6kUiszTbR8jm9eRC0M1G58NVWC5LYd+sdNA
         hDdPuBMGlb/TAWvcuniMlBHXeia86WEkRc4d/hCsFiIAQwNDjjCNYWUo/I+uT8ZIMzuk
         ZMTT0rBcN2BpHW3IjnrCq5JTSv3zlsazQHqYzLfpeCmcfpQwWpy5hx3pWH3RRt16ocPX
         E49TcB/A8Hw7YYDx09rg8NElHibz9kidMdGLfU6l0BTpG67V7LMGNVfw2IF3/HnSAOlt
         XRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+WyMtpdyscjj7YI8N5KNeHwNsKq4xkorxnacKw4Knu4=;
        b=IU+ls3CBDZ4rqzoXdh4v1NSPAHeGomUBc9k5k3la6smKgEXJF6m6c+848lBYnXFZfF
         q2wmlGEe3hjHMCD9atikTkIqgVw5hNLjGZebE2J+n3dOLd9UYaO1W6+LC/BppK0xMP6H
         0Fp+QMptLID1XQOHJX5Rogh35pGID5agsdc+dZxOZfhgamLM4X3HsZx7oLlIGbuH+DBq
         RCOCis0XKNc1/aQFYJI1NKT8WWGUABvXVdhJoxpXpk8kJKnbZnUFkN/mUnxOI/1EgFjT
         pdgCq9MWrF4I/lTODQrbtDpc/NgEOJjMjSx+qtOYeEErcmkND+zaL6/jK8t53qcQpcYV
         Hfuw==
X-Gm-Message-State: AOAM5303hgLAvrJckkRJtvwEI/TLKe2ftMHk3l9k5j9eXiScbaJYHpNN
        7oSMocAi1h/ejaQnX22X6fqP8w==
X-Google-Smtp-Source: ABdhPJwz6nY6fLkTGaPREgcb7CMM/2pYyUU9XS4Y9WFaYyqJ6D8c+0IVjGqa6l17nWxZNq//WNopBA==
X-Received: by 2002:ad4:4869:: with SMTP id u9mr12898835qvy.98.1593024823795;
        Wed, 24 Jun 2020 11:53:43 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x4sm4681893qtj.50.2020.06.24.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:53:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joAWk-00DgVA-BH; Wed, 24 Jun 2020 15:53:42 -0300
Date:   Wed, 24 Jun 2020 15:53:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-rc 1/2] IB/hfi1: Restore kfree in dummy_netdev cleanup
Message-ID: <20200624185342.GM6578@ziepe.ca>
References: <20200623202519.106975.94246.stgit@awfm-01.aw.intel.com>
 <20200623203224.106975.16926.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623203224.106975.16926.stgit@awfm-01.aw.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 04:32:24PM -0400, Dennis Dalessandro wrote:
> We need to do some rework on the dummy netdev. Calling the free_netdev() would
> normally make sense, and that will be addressed in an upcoming patch. For now
> just revert the behavior to what it was before keeping the unused variable
> removal part of the patch.
> 
> The dd->dumm_netdev is mainly used for packet receiving through
> NAPI. Consequently, it is allocated with kcalloc_node instead of
> alloc_netdev_mqs for typical net devices.

Gross - make sure your rework allocates netdevs using alloc_netdev.

Jason
