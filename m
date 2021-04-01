Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBF351861
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhDARpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbhDARkm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 13:40:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557DC08EC6B
        for <linux-rdma@vger.kernel.org>; Thu,  1 Apr 2021 06:48:16 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id by2so985744qvb.11
        for <linux-rdma@vger.kernel.org>; Thu, 01 Apr 2021 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yv0SD7azmXsvMEplVTG/OMlC1mfamMg+J+KP7hU2E4I=;
        b=gJpFHp8bORZJ159TQvGWDVPWsqfhrWaEKkWnC67F/5gAcANjTJCuJYuSBI2/iQ6TCz
         /9BfV+GVhUSbLYskIhUFmupnlF8Sy6e+1w6ADgpd0NF+A1EDcFJsew8WgZmYrOHTEA2V
         x42c3O/Y725ydSAZARfnzNWgiMC4wNboQiL7zlAu4vJjcId4yEFeNJOaEV+ghSAO5xS7
         Jx4D3fvpP3Akox3rdVaW6u1qhWD2CWs/VWu5YpOCuI0U0PQaV5JULLQxn41UIdsS3OGv
         Bt79bux7mPxIPzeRJ+vB96cWK8HEZwtHoUuQHTA/hHVBNRirI2+OvBMyZbzTHJy9fqMW
         cCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yv0SD7azmXsvMEplVTG/OMlC1mfamMg+J+KP7hU2E4I=;
        b=V7eyq5SR9P4NQvRSGNWWxxbByXt28wlop3Fb16L7EK/ODdn7I+lVkAhkXISew3Sj5b
         lkUe+XpcFJtcWvgjhVRhPHdb6Ea+rOxSPvKuaXPMW6BL8wggcFTvgybjoM6kSXiapHSc
         6PJvG1FA/YGAOpU5VM1MlDM7My6NisvvjbhG9xfXszz24ynkH2MFgUQRYm0eZBKMcgSA
         49ffLwWCAdqu+SW6CyYKF8LjBRJ6gELy1QI9pEPx24HRpybNToBzAclN5iA8N3+xB7tr
         N2Q5YseB7P87paBX155gH7vfITNiHxJtfUSEzhuyT7PWI1905k59wnhHSFTb+/SIQI53
         tE4w==
X-Gm-Message-State: AOAM533r2BAYtUspuagI9IhXoDsztn0Cy2SBuV7lSKg0ETUatC4PX6bK
        kvjX+1I5EZbM/vsNoiDJXjztFw==
X-Google-Smtp-Source: ABdhPJzLNDtRKWNx/3wroMc9KweKg7ulxyAg21Fo2VAIUu0qMvXSzqs37gsflntsxeCSlNSmt1j2RQ==
X-Received: by 2002:a05:6214:326:: with SMTP id j6mr8327576qvu.13.1617284895294;
        Thu, 01 Apr 2021 06:48:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id g21sm3931941qkk.72.2021.04.01.06.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:48:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lRxgE-006lA3-9J; Thu, 01 Apr 2021 10:48:14 -0300
Date:   Thu, 1 Apr 2021 10:48:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH for-rc 1/4] IB/hfi1: Call xa_destroy before freeing
 dummy_netdev
Message-ID: <20210401134814.GG2710221@ziepe.ca>
References: <1617025700-31865-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617025700-31865-2-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <20210329140922.GP2710221@ziepe.ca>
 <7da1174e-97a6-3933-ae35-166a9dcbf38e@cornelisnetworks.com>
 <20210401123317.GC2710221@ziepe.ca>
 <DM6PR11MB330637BAEB1AA8D7FDC56225F47B9@DM6PR11MB3306.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB330637BAEB1AA8D7FDC56225F47B9@DM6PR11MB3306.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 01, 2021 at 01:42:57PM +0000, Wan, Kaike wrote:

> Shouldn't xa_destroy() always be called during cleanup, just in case
> that something is left behind?

No.

> Check the following:

Since I didn't write a WARN_ON(!xa_empty()) it means they were not
made empty.

IIRC there is some special stuff there with XA_ZERO_ENTRY that causes
it.

Jason
