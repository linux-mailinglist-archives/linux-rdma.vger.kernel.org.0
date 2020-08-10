Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221C824119A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 22:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHJUTY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHJUTX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Aug 2020 16:19:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52DC061756
        for <linux-rdma@vger.kernel.org>; Mon, 10 Aug 2020 13:19:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so655899wmd.4
        for <linux-rdma@vger.kernel.org>; Mon, 10 Aug 2020 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pgWR0GkgPslYq7zCwHMGb0vyH0GeGB3zy/Rxr8MLNnM=;
        b=FlhHEc8NNpnTlzbu0qJPJBuTltnvhItD/fFI6MU/J3ivg5EQ41duCSnLcpbN9Lu/ar
         MzkRFKgo2iFXtH48c1q0X+z4dcigCddOYtKW0GxhPeLyggnVq0r+TnwknJUkMR9iQFE/
         AyP+q24j/oOuWlhY6RIyG8rt1K3QNSGJGvvut7BpV02mC3S97wN0DI95xLLO3dgJMLdP
         SXerjlZwfW+g0Q99sPjKjlVLhArbViTtaPCA/J3lPLW5Ig84O+uhJREX6vPG3Ow3HqmP
         FbCX3JnCXzQyze7JvZ5+3f/eZtli4RBLELvkVfSlxqH3ybrQbHx/i0NjpPqL0PLvNAAR
         QzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pgWR0GkgPslYq7zCwHMGb0vyH0GeGB3zy/Rxr8MLNnM=;
        b=DgHFd+s8WDOXS7roEh/buC3+hcBxrA/4k8ESh6A4y/JvXmB9ggDkHdWeDbJGyndnWP
         7jU0hEeHPyKRHJifnhKAf7K+X4oU3isPCImex5yrBtPpijU5nsMm9tAszRvCPjBaZu1Z
         HU8itwdDvRuxX1SH3bOWJZDyVFa//CvQtljBL19NKJ8GhGkumx9lmNHEoQNLVavDBXyM
         fTfuONpK+xBVRPvBZPu9HQc4v/M5xfiH7fuhj2JLmcln1ULnHc+rXiB1AARxMH0Nv5V2
         8C+Zllp9BNmG6KywULjaxNSbvy4O2y8QZBIcGIAXvD9vXJWwxzqeUN9UP//HOHQ3zXrl
         A02w==
X-Gm-Message-State: AOAM530Px8LhKXS2CKt0YtLEnAkcn1W2+fXNlRJrr0lFSaii8Sn+tRUD
        ePWDJmOznRS5LA+YXa4kMgk=
X-Google-Smtp-Source: ABdhPJzxmueiQS30cqDfeV98CkjxAUBNQEPyaQ3wZcFBYUcSrsptmyn4z31AXFPQ2TTyvoQVU+OzbA==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr886630wmg.91.1597090762040;
        Mon, 10 Aug 2020 13:19:22 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.87])
        by smtp.gmail.com with ESMTPSA id t25sm1076226wmj.18.2020.08.10.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 13:19:21 -0700 (PDT)
Date:   Mon, 10 Aug 2020 23:19:18 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-rc] RDMA/usnic: Fix reported max_pkeys attribute
Message-ID: <20200810201918.GA443976@kheib-workstation>
References: <20200805210051.800859-1-kamalheib1@gmail.com>
 <20200805221742.GS24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805221742.GS24045@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 07:17:42PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 06, 2020 at 12:00:51AM +0300, Kamal Heib wrote:
> > Make sure to report the right max_pkeys attribute value to indicate the
> > maximum number of partitions supported by the usnic device.
> 
> Why does usnic support pkeys? This needs more explanation
> 
> Jason

Looks like the usnic provider is acting like the RoCE providers by returning
the default pkey when calling the query_pkey() callback, Do you think that
this needs to removed like what was done for iWarp providers?

int usnic_ib_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
                                u16 *pkey)
{
        if (index > 0)
                return -EINVAL;

        *pkey = 0xffff;
        return 0;
}

Thanks,
Kamal
