Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420F24925CE
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 13:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiARMhm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 07:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiARMhk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 07:37:40 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B69C061574
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 04:37:39 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c19so21915470qtx.3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 04:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZdkbSWC+D7fKJuaNlBr212oV9QGNMu3jqRVNvuPaVJ8=;
        b=LkTF7O39tBaQb3k/8yemYeGOBuUz/xMh5O+zLIOTR25lbvRE3BS/6UhIJ3qHVz1NqI
         3RmHhebR5uNJr7J+bm+KhcW6M0lJCvxgN/7y2NDM/u3gQOUwBH3Hah62i8ex+qJ7LvMX
         Ad1qTjfE7GuEu0UVFT73gszdcbkktzDGGBtuO05uwLy9Jip5fonJceLFW/cREHK2b16N
         H/pkaKJeIKc2pMmXJxuk65eRf6wKM0V9oz++EcR3z9lo4y6V4FjFS9r0U/0ENqZv28nC
         4cL3AFWNMFnYAN8seGD6Jg7lQJE1/xXPihGxYOGnKsdEQxww/RSC+7MpxmxlnJzf9r71
         AdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZdkbSWC+D7fKJuaNlBr212oV9QGNMu3jqRVNvuPaVJ8=;
        b=IJCiX0g7dJ18qINfGDyoYjjgsNzrpJ4tZLR6vX24lSPye8cPVPNbfNaYhgT4YuObS4
         z8BdWa9zaz1rLB/CN5u6z0TjdXTiniwAFCgpCZXXN48/ajvCloMY0Hki3by8UJr87A3s
         MzK29vzuYnSReHhfarwOR3oRS8nQ7Z6+/FLlJZIPMjsCff5eNe3ymVs4CIbTmiRQe8v9
         tw0EvkIik0u3YUKn8qpfpAOUDk87aH4MkvFVuIGQKzeJyPHY0p4fIVK+ps/UrhFIsswi
         qUT/Op2SLg5gpvifEFHyxz/1aAJPWjIzCyfauU+bKt/s5nmJU89gFPHt5/alOZ5mMV6m
         5HkQ==
X-Gm-Message-State: AOAM53210z0WMbiFO+y+ewBqrI/UrEj6EyxL+S+ELA/ust7VWjq8cEY+
        5w7nanTz3I/SLS74zWV+mXr+RsofFYBsgw==
X-Google-Smtp-Source: ABdhPJwhbJtaUK2IqSiW/MPyoBp4I3WPkHvJwx9yLi3gAeEelqKlndZl3pzG9aG2UC2Ht7rzHQPfqQ==
X-Received: by 2002:ac8:5c09:: with SMTP id i9mr7437656qti.583.1642509458462;
        Tue, 18 Jan 2022 04:37:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id y17sm6869602qkp.26.2022.01.18.04.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:37:38 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9nk1-000pVS-3O; Tue, 18 Jan 2022 08:37:37 -0400
Date:   Tue, 18 Jan 2022 08:37:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Message-ID: <20220118123737.GE8034@ziepe.ca>
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-10-chengyou@linux.alibaba.com>
 <20220117152217.GD8034@ziepe.ca>
 <54485395-089d-acdd-7296-d82c8e950599@linux.alibaba.com>
 <YeZ6M4z8amVc7ETT@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeZ6M4z8amVc7ETT@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 10:28:35AM +0200, Leon Romanovsky wrote:
> And for the bnxt_re case, I didn't look too closely on why it is written
> how it is written.

bnxt_re needs to be converted to aux devices to be correct, it is
trying to recreate them using net notifiers.

Jason
