Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D32A46C7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 14:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgKCNqu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 08:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgKCNpY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 08:45:24 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FA4C0617A6
        for <linux-rdma@vger.kernel.org>; Tue,  3 Nov 2020 05:45:24 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id e5so4097267qvr.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Nov 2020 05:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xD2j+fnjVBXZ8FUkzGpuq6ZM6Rk+Sah3F2AKvkh1s5I=;
        b=CM/sC5t2gnERlz7Wf5wolVmL6SgTqtThZ9ED3MoPNajahGLD2Gf48yDMRTQIFoeeS2
         Tkknw7804frEnBLCLdbsgCYOaN8yrM5JpWM9kF06biAdPR2nU6VLVfYI5+KUXFfC+zcv
         2q1R9C1Oj3DFYspXFHcLlkxjifY7oAvrphqQP4e+slzEK+dtG1RrRfWg+4jK/WNJpR3G
         /w9eRnIzaclQDs80+kthr6dpsSkNZmId8LfBesa37kMxIRuUfoz9KmC72+yTkKI/l9oX
         j6fCcvWxTWCdDq0YwMsZBLLI2CjC6C3xCi0LoXjrx+CGRUqB1Jt9GhKPnxil6j0jRoKe
         Q7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xD2j+fnjVBXZ8FUkzGpuq6ZM6Rk+Sah3F2AKvkh1s5I=;
        b=jeAB09JYoEn/pl/uVXg1nmeU47eLgdXHSWqvEZuA00RR/BUHhQuusb8Xl2pnQHw67d
         k+Ya2xiz4/2SsiMUQ0xJy3d/wBHrTMqE55ykeQOpsU0szGIsO3FvXl9rL4reniByaVCz
         2QFdYbGntVBn8jJvQ/utBRFRbujRi+gUU+CBosKLGdW/VGlQmk+a+NhemEaPHvH/VsJ1
         bpb4nqKBjKYXF0xQHk5P57JL+D6M044Sm19MBMVxJ8wOUJwVWEbqk8fDXM1pgsll9WnK
         B+r0rnpgcbWKVjhL9gJ5ZDIgW5JCrmZWg5O1KitJFDZKMcHtfdCC5R4cm766n1cnKc4r
         shVw==
X-Gm-Message-State: AOAM532Nwf9S9zunQaiim95n2LNSfEklKWmGOWWghNYDyrU+L6vZKJ8o
        QW6CVBq5EKQTOC+NrG8uqz30fQ==
X-Google-Smtp-Source: ABdhPJwB8AjQcYArIheCms0p/rpTh6HzbHYjvplKJ7hKHoUDGVNlw/XuRk4lhmOz0FUaAyYGkijVcg==
X-Received: by 2002:ad4:58eb:: with SMTP id di11mr11017816qvb.34.1604411123667;
        Tue, 03 Nov 2020 05:45:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x7sm9866232qtw.76.2020.11.03.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZwck-00FuPD-Af; Tue, 03 Nov 2020 09:45:22 -0400
Date:   Tue, 3 Nov 2020 09:45:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201103134522.GL36674@ziepe.ca>
References: <20201103132627.67642-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103132627.67642-1-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
> Add the ability to query the device's bdf through rdma tool netlink
> command (in addition to the sysfs infra).
> 
> In case of virtual devices (rxe/siw), the netdev bdf will be shown.

Why? What is the use case?

Jason
