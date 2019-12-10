Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1449D118F51
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfLJRvY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 12:51:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34623 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfLJRvY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 12:51:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so16313594otf.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLDxXwGsHcXK/4MIow1/s2R5pg50DmOvyjuxK3g9wtU=;
        b=ivsPwB1YTGoIqwpelldM6752S5Z3ZLBx8nEuNVlEjk4B/TTkZmCjast27dQ0FXwecW
         Pen2BRBdXB/75GSmtdEEV+lF9iyqgTBkQSHbj4RyWDUKm/Yhx1YjowNV77BwEhh577t4
         9lKrfi4JhS1rJ33z17ZDtPqWiWntpERSfWLJlVbWgrGJf4Kl+fLQFoTF06fgeYhhQU9U
         piHCWHAD5N3Kjkx/Z065UO6A+0XdHCA+4rPms3NqkVqk+1sjj5s8LgR25lejSsjpkkVh
         dvsCgBGQ2kY11aPyCnDyiI0frsKbejdL/6iP5S/kWfwyPv9ZtXKeMCTJ2ntY4WaM3jWT
         gyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLDxXwGsHcXK/4MIow1/s2R5pg50DmOvyjuxK3g9wtU=;
        b=fCZbbKHcBCHdBPbrwGJkw5lyFMUQlS4OkJplNIT3CuE8Z6FIniaGYMQd1jj/Y2IVUb
         Xe9+ywEiqM6+nrRnkFaIg2FC6SeoI7MMhZnfqaOxAuMGm1JzPl7YEzfhOTWq0itZbOX6
         er4mRQ21hPUpbut1zVjX1KgZd6xDAsio7WTPEvU3w+L2F37Dgw1sHdBauEakpzPCHogh
         dToWbuo1zeD1Cnsdan+gJSehoMgatLmX5NsegMj6sWKXyuH3sSj0V1XVMkCBM26XQ/FP
         8djPE/7XR+qQvDtDNAaiIqATMs1YpUt6QBikMPQ5Dcts1AlYFDPR7uSitRtxkMLod7kV
         tbZw==
X-Gm-Message-State: APjAAAXdOcoWQQxZxauNUxAjlkh3ZdFfDBgxi33hIGpUE+/npeRtQRY/
        oiudZfrFkYJ6HB9sQtGxJL4fsw==
X-Google-Smtp-Source: APXvYqwjZ7m8GoTodEQ8prrcN+kuiLnooUkBMxA02f4sb6i33XAgDNikDdssy6EDIffCBNIuNTjuOA==
X-Received: by 2002:a9d:6b06:: with SMTP id g6mr26746974otp.93.1576000283694;
        Tue, 10 Dec 2019 09:51:23 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id e17sm1628192otq.58.2019.12.10.09.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 09:51:22 -0800 (PST)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iejfN-00001O-El; Tue, 10 Dec 2019 13:51:21 -0400
Date:   Tue, 10 Dec 2019 13:51:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>, davem@davemloft.net,
        gregkh@linuxfoundation.org, Dave Ertman <david.m.ertman@intel.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com, parav@mellanox.com,
        Kiran Patil <kiran.patil@intel.com>
Subject: Re: [PATCH v3 01/20] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191210175121.GC46@ziepe.ca>
References: <20191209224935.1780117-1-jeffrey.t.kirsher@intel.com>
 <20191209224935.1780117-2-jeffrey.t.kirsher@intel.com>
 <20191210064929.GJ67461@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210064929.GJ67461@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 08:49:29AM +0200, Leon Romanovsky wrote:

> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Lightweight Virtual Bus");
> > +MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");
> > +MODULE_AUTHOR("Kiran Patil <kiran.patil@intel.com>");
> > +
> > +static DEFINE_IDA(virtbus_dev_ida);
> 
> I was under impression that usage of IDA interface is discouraged in favor
> of direct calls to XArray.

IDA is OK, idr should be xarray

Jason
