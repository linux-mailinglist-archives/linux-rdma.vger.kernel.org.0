Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5EB3EF7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfIPQ2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 12:28:32 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39864 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfIPQ2b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Sep 2019 12:28:31 -0400
Received: by mail-qt1-f169.google.com with SMTP id n7so534886qtb.6
        for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2019 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vftTdeyyPMP6ofviu+1siXoLyVzqbLDXEdAlSQ4iJIs=;
        b=XUBc6ghQG2OqYNh7hKkdIMVs5pnRd4PgzKZ83QmpXsE1xmaApbJhBRa9UE5HY8J5g9
         JqTaPKexstmGWix4orNjDBdovBFfR261yeD07Me+nW5p3frVAvROjYq9Tx5buL9O+7Y0
         k8coApRfxZNczvPr0lgx2obLxw9nNJHFIOPy/z+WB8E5quA+0Wl8gmyqLNXNwoTEmQnv
         tC0rGrkNtAA0vSs4sPT1V8VxymYM5ENzh65AkaF0xYQp1UiqhlfyHNHNBlEdBeCB4AsH
         DGz5t5ZUxNt7IVo2r1DAV0jogZtGyWu03iHWc/BXIJOBpCqlJxn7dz2d0tyU0ZH8uN5F
         tUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vftTdeyyPMP6ofviu+1siXoLyVzqbLDXEdAlSQ4iJIs=;
        b=RZDfOlyX8tRm19PLKwHFwD2E9pAxkrQQ9IKG2zQx/mp0bpIQCLf3lc5PUYNKT9e2+5
         jo9IabejdcoSDnl/3LbG/WyyR16F6BcdIKQMOMfobnxZR9V71qXE1R8QT770R4/oak7h
         /nn6w7E47DA/DWj4ERUZ+EyyyPJ/CJh11jv+a+WTiPftzLT61BP6EuUvTT5u64HAzsrO
         MdgE3D+MJ3EOsb6GZCjiYYY9gytDFLhlz3CB6YcCyb+hN0kNOs4ASnmBb1Yi1vQ6B4Ji
         9H2OkbZYDkCCOB/9QhRXfBPaT9TQBPz33SfMXNQYLsY1gd//2bMKjUj8Ws8N4hdcLrSo
         2ogA==
X-Gm-Message-State: APjAAAW/a7zUbwSNi/eCujH//eOKqyoebs1258CJ+ZOr6It9h5pXQLpG
        f9AQSNAe+pkLN98/wSqgaOPTbg==
X-Google-Smtp-Source: APXvYqxs/fkFgFQVBcGV3Z7tX7mLIOPnssv6iwOMwyS7KC13Ply0LXlbcBx7fcsIhHYOBeBGdxVvCA==
X-Received: by 2002:ac8:6684:: with SMTP id d4mr464860qtp.286.1568651311043;
        Mon, 16 Sep 2019 09:28:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id f11sm623952qkk.76.2019.09.16.09.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 09:28:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i9trZ-0005qG-TN; Mon, 16 Sep 2019 13:28:29 -0300
Date:   Mon, 16 Sep 2019 13:28:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     Steve Wise <larrystevenwise@gmail.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on
 iw_rem_ref
Message-ID: <20190916162829.GA22329@ziepe.ca>
References: <20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
 <20190911155814.GA12639@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911155814.GA12639@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 11, 2019 at 09:28:16PM +0530, Krishnamraju Eraparaju wrote:
> Hi Steve & Bernard,
> 
> Thanks for the review comments.
> I will do those formating changes.

I don't see anything in patchworks, but the consensus is to drop
Sagi's patch pending this future patch?

Jason
