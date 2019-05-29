Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6352E1D2
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfE2QCu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 12:02:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41466 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2QCt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 12:02:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id s57so3229727qte.8
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nnwqXimdxIbAYK5ILe5DRVjxup9dZCjYZ0GmHygxbiw=;
        b=T05oUsCt7uF+2nlPy6A4NaEliaVvS5Ek0cWw4KuK/EuF5CB5b6gjL5/R+TNLMUZwJ0
         uHJZNQ9UIoWMZoCPueiextNX+bfvQ56f+RWjqOeKjt22UDZTNjJZBCgr4i7JAZuoCfCc
         6QlyhoRSCbLznZtAEv/wUYiQ/mWL1wZTj7R7KLj9TSv4UlRnPwgO4VhdVmO3uInfVdTB
         8ehfvvS7pz/QpCLEDK7vkdLyT/TRuMvWhamJTdIvIERjX6tYb/OjT6TNc7xFK0EafvL7
         QE0eLM7PazeSI55Xi1YO+xCkeASMs0e5iiStuTRqRW44f27y6FJ3VaWjVtElgYSfgPXa
         6Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnwqXimdxIbAYK5ILe5DRVjxup9dZCjYZ0GmHygxbiw=;
        b=L1DcXARL7+89fnthMDOCnzWM4cBHpKW6JJEgft0LHOieq7Ys9CzEd/L7YMS58N7aS2
         YK8mQDFQjgCfMDpygTWjacDUP5G9+fVRKlF6Z0bgyxaLPwJx0NBfGikbURDD8Ax6A+Um
         1Ix5njizYCyQA5lMQAX7AY9xH88PeSB7g8VtPgdyDW6CGwGnhDnHVv4fBhjt10h72rXB
         rMdzBq5Uho71/jUgyZQoD241mVnq7kpFww/P2A1lleA3M31nkFKX+jGdsOLO2t0+s7Jf
         2la/MEJUIJyjK0RD1ejsYnJvrE2cpS3BTLb/Lgj1DZjoS++xo/cyqeMWUlTi6EjLdA1x
         37vg==
X-Gm-Message-State: APjAAAV5ZjYjlDtyAsqjBK0cMKT4KlmnQgC5GDQe8WwPK+o4Arb9t8pr
        r9QEu81mFLhb5um7T34sGp64tGMvCtQ=
X-Google-Smtp-Source: APXvYqx/k6fE7zpcqmYEpJ6LYnJ3RXJAO9beisp/gPQHScAjaXYiuPt61bvqurj6ArR/m+UnJmm+pA==
X-Received: by 2002:aed:254c:: with SMTP id w12mr7498642qtc.127.1559145768459;
        Wed, 29 May 2019 09:02:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v2sm3390553qtf.24.2019.05.29.09.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 09:02:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hW12N-0000fY-HV; Wed, 29 May 2019 13:02:47 -0300
Date:   Wed, 29 May 2019 13:02:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/5] Patches for 5.2 rc cycle
Message-ID: <20190529160247.GA2472@ziepe.ca>
References: <20190524154320.10588.44693.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524154320.10588.44693.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 11:44:32AM -0400, Dennis Dalessandro wrote:
> Fix a couple bugs. One with pinning unaligned virtual addresses, rturn correct
> value when user asks for it via verbs call and a day one issue with freeze
> work. Also fix-up a checkpatch violation that resulted from another patch
> removing lines.
> 
> 
> Dennis Dalessandro (1):
>       IB/hfi1: Fix checkpatch single line if

This went to for-next

> Kamenee Arumugam (1):
>       IB/hfi1: Validate page aligned for a given virtual address
> 
> Mike Marciniszyn (3):
>       IB/rdmavt: Fix alloc_qpn() WARN_ON()
>       IB/hfi1: Insure freeze_work work_struct is canceled on shutdown
>       IB/{qib, hfi1, rdmavt}: Correct ibv_devinfo max_mr value

Otherwise applied to for-rc, thanks

Jason
