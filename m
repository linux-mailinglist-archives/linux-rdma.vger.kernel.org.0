Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDBC31594
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfEaTqB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 15:46:01 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40329 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfEaTqA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 May 2019 15:46:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so7055213qkg.7
        for <linux-rdma@vger.kernel.org>; Fri, 31 May 2019 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ujUTnfvw/4taFNKx8LK2xbZPcUdGF4SCwE9rhK7tsgs=;
        b=I31i/cTT23QnmCdlrkJ1wNrv+LfG8Kt+dJbrTW34fAfGFaIrRdDF/JxNh04n1uDUpT
         gxRzC8Jssgfq139SagqA+PnXwSe8qvJMbaQnyJOzE1FmtFb7hrbChRGSNXyXlZL8z/Wv
         l8wc4G4s1jOT71I/+CFnmJIXyYbsylqEImVjbO1Cz4qKnB5aAQgVOxEEZM/9UsvGnWbp
         97DtkDb8MzmWVWN+UjjUvTJ+rPVT446+R2Ksp5E2JYk8VHmQZSbKGgMN+PNJRpYRD2ge
         0v4vLPqVV8Eb1Dj4k06Xb08Q/Prq+G3srqvHSoinE4mDpsmhe+SbsqavBesHBoZahweW
         4fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ujUTnfvw/4taFNKx8LK2xbZPcUdGF4SCwE9rhK7tsgs=;
        b=ttjkNGsBL5hbcjSs/g/ruiJwbsObVCmkjjYE3Yr2Wrq4aEJ2wsRXjH+h74bH5haY6i
         PSUZhA35Rt7zwCgzcBW27pBt27Bn1bT3M/2Crf50gdsXmi1TvaYD0ijqqf2Usd1oBaqr
         1/LnKnNbu8MOA5dCAYiuxKzywjzdCSJb7RntzLkiQOaKPlsrIjtGKe8YSN3KzzyJvRzi
         zWUz7kDQRieuHeALosDDaqBdEpRSDH3VBFtmyviJ1HHgVyogkt4t17aiE2rwyuiJHT6o
         DQNBZJ3FBaoKtC+xWH9ECiE48vdw34J0zDgb+5OZc88AQMVOl9LueOjyQSrjLG2J14dq
         iDug==
X-Gm-Message-State: APjAAAXEy5GfbLi4AoSewf1wwGQBnxWZ3q/KSxOXh/Ux8XuqJrOFRtIX
        mTKJL6aCRUfBtLMo47EZlU2n1g==
X-Google-Smtp-Source: APXvYqwu+WbHe4ArUSZjgIPOs75vypfO9KGt+Od4vE6Ds7jCloqcBRlsutRZLFyncHQc0YtOUj1IXw==
X-Received: by 2002:a37:4f8a:: with SMTP id d132mr10457024qkb.272.1559331959898;
        Fri, 31 May 2019 12:45:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m40sm6179807qtm.2.2019.05.31.12.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:45:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWnTS-0007QU-R5; Fri, 31 May 2019 16:45:58 -0300
Date:   Fri, 31 May 2019 16:45:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     Yuval Shaia <yuval.shaia@oracle.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190531194558.GF8258@ziepe.ca>
References: <20190530060539.7136-1-yuval.shaia@oracle.com>
 <MN2PR18MB3182E08DB0E164C6BE6C409FA1180@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190530143452.GA19236@lap1>
 <2e7184db-ac1c-73bd-7e2d-08cd9d578a7d@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7184db-ac1c-73bd-7e2d-08cd9d578a7d@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 09:58:53PM +0000, Adit Ranadive wrote:

> That's interesting. So the guest would still do a ibv_reg_mr and the device
> would re-send the mappings using ibv_reg_mr_iova?
> How would you prevent applications from using/misusing ibv_reg_mr_iova by
> passing arbitrary values to hca_va or is that even a problem? 

It is not a problem, the iova & mkey is the unique identifier for the
memory. There is nothing that says iova has to be anything special.

> What if the underlying device doesn't support zero-based MRs?

All devices have to support iova to handle the existing user
cases. Thus all devices also support a 0 iova. The foolishness was
making zero-based into something special at the driver level. The core
code should have handled it.

Jason
