Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791FD1FA54D
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 02:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFPA4y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jun 2020 20:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPA4y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jun 2020 20:56:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F9C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2020 17:56:53 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id p70so17702460oic.12
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2020 17:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YBAYGVNwFLAtJovJwPQQxR/FNjBi+WCwuPp0hE7j3eM=;
        b=G/CjCMCraUd2z9q4ldIt7JPEy3FDtqC7LxmJ1AUNbqcTZlO4jiC1XA83KMI2nzj/FO
         wOJ0vE+qQIJtkSO1kQTseFYY3e+iZiCHy0JVRszVyYyB3NKzcEcTOqKcgrdCLcjWy+cH
         rvVII6kqyU0MZaBdRq/9DG4e7KvIViBZd+diufu2eHoO6sSSGcO9nTCH/chVWy5uScaa
         eow4kORgLjg5WprxZNqmkTux2M7twijh6gXWC9dAh0Z0RCFlAxSe3oSpQ2t4GN9yIDww
         GokdVXD9j4deesJT2qMPDJAb1oe5a4LAVgHG9bI4r2N8WQ6b96ZyCvColo0bheT+hSap
         I2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YBAYGVNwFLAtJovJwPQQxR/FNjBi+WCwuPp0hE7j3eM=;
        b=SGC8H6GyFH07Xgqes3ImEtPL30WX5a0SjjDlHqkAGRMvy/X6EHpUNWt2jXEpZgBAQL
         bLnQ12YGpAgVAlDJ38xrT2mRU46FI4JxD7B8bEZKrzChmRSKd6zl2bBLfsHQsyCSs7cl
         yGwB7EkGhGPx2G/lmGSrm9k68Jb+zhjW+OHsCucJZxTTzh0MahLvFU/nN4icv6vIB17S
         +wfC40P2ntpkcQCKYWiSIGq0+RfF5Equ9qm+2ZBMxyv0rfvesYncFBTxXxgjRXju86h8
         ePjszwWfo9wIm7pDq3iwhnxd2Oip/6496oINt8kbT1ECeWsCPFuolFa5EpYpA1gxGIPK
         sBlg==
X-Gm-Message-State: AOAM530rELM4xHB8wVdReSM+csD6dIxvRS9sIwMW1+92CfzE/WOt/Xfb
        XoX+S/gYa925e+eXYJFLx/Cs92C3
X-Google-Smtp-Source: ABdhPJxgA6tOti2P6fxJ2CMNKZ/0Ght5yKu2fOiYsdeP3HdHcVGxT2UAtFOl47UNiuu5N+/ixbSqjg==
X-Received: by 2002:aca:fd88:: with SMTP id b130mr1623212oii.49.1592269011886;
        Mon, 15 Jun 2020 17:56:51 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id 6sm3857951ooy.18.2020.06.15.17.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:56:51 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:56:50 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v3 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200616005650.GA1347657@ubuntu-n2-xlarge-x86>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
 <20200511160618.173205.23053.stgit@awfm-01.aw.intel.com>
 <20200527040350.GA3118979@ubuntu-s3-xlarge-x86>
 <9e9147ad-6d7c-9381-72f3-dc2f3d0723fd@intel.com>
 <20200601135722.GE4872@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601135722.GE4872@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 01, 2020 at 10:57:22AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 01, 2020 at 09:48:47AM -0400, Dennis Dalessandro wrote:
> 
> > They should probably all be in "enum ib_mtu". Jason any issues with us donig
> > that? I can't for certain recall the real reason they were kept separate in
> > the first place.
> 
> It is probably OK
> 
> Jason

I don't mind taking a wack at this if you guys are too busy (I'm rather
tired of seeing the warning across all of my builds). However, I am
wondering how far should this be unwound? Should 'enum opa_mtu' be
collapsed into 'enum ib_mtu' and then all of the opa conversion
functions be eliminated in favor of the ib ones? It looks like
OPA_MTU_8192 and OPA_MTU_10240 are used in a few places within
drivers/infiniband/hw/hfi1, should all of those instances be converted
over to IB_MTU_* and the defines at the top of
drivers/infiniband/hw/hfi1/hfi.h be eliminated?

Cheers,
Nathan
