Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97CE1E6A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbfJWOl1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 10:41:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34862 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390195AbfJWOl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 10:41:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so19975646qkf.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3hNTRFeteFQOa45dMI+PPZBZOw2ZRTZ5e9vz6V3Zo28=;
        b=VrZVU90WxCM9A4UNAiLPy1pncGyOCclJFbQrIUojTEp9XZkpRRQi8RLqIglQXYRhkC
         3iar66YBp4FJ2RNm/163loejbH7AQqs2+V5BbAq3blTiaNWW8yeV/wTt5qILsZdk5He2
         4jpi3tcAsW0Ev6StdybfWsYuB/pejkvsxLSJ8vW8cxjxxGryJQwcIHnmwL3dCiBN4ZVm
         j8NerFtJg+pJC00uL+Q546dUxDUacAEQssD64zMg7inoYlTj1oYXQr41+lyhpf1qiPCQ
         gvepUAW7zSp6JOCt/5th+8QYW/HO8HlkdGdT/ZwM63fMl7VWeKhNH9WKWW2gYfD7dMVH
         HTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3hNTRFeteFQOa45dMI+PPZBZOw2ZRTZ5e9vz6V3Zo28=;
        b=uYfnrvovaV/I4GkxoX+CxBkfDGbPGAPEwaZ76BYSHZdwTNwKLA3mQO9lE2SSYIzTKh
         ICJrwLT5psUtUMJiRycrUlEmae29xOpQUGKE0ndZIn5n/UoX6Z99Yvdcfn67SIew6lHc
         VLQX50cgW5608AOVboH4G8BnhlVA4V6vhMWpLnJvz4OAKq+V/9whHDsy9I8iQJ/9qxa/
         eon0kEHGUo+8ADvhcFJn7ux+aI/rSbeIqFyMwv93jegEGTCYkY2pxME8PW5SmlTf7kn5
         JM1LxoVhkciwZLcAhUVXf0ugmAXA8UH6zOK00mkwV1WFblBelwB1UOsE2bbmLrc3PLAL
         6apg==
X-Gm-Message-State: APjAAAXmgsuCHTA9/48QxMfYB5G5bUK8udsbjHdgHZH0eAeD88W6jqH0
        Vix4/+RXGeR+Ofp+sMP9+9O60Q==
X-Google-Smtp-Source: APXvYqzp6hkVB4BPnZYh9RquhtlxFTSMLkKC/yt9E23iUYYmuCiEGB8I9Q+acv/oELmsHneBDtWQGg==
X-Received: by 2002:a37:8146:: with SMTP id c67mr8500301qkd.380.1571841686750;
        Wed, 23 Oct 2019 07:41:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g10sm10955840qki.41.2019.10.23.07.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 07:41:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNHpE-0003NV-JG; Wed, 23 Oct 2019 11:41:24 -0300
Date:   Wed, 23 Oct 2019 11:41:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Message-ID: <20191023144124.GM23952@ziepe.ca>
References: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
 <MN2PR18MB3182999F3ACFC93455B887C8A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
 <f7f91641-6a80-2c06-2d4a-9045b876daff@amazon.com>
 <20191021173349.GH25178@ziepe.ca>
 <215079fa-03bc-1b5b-dfbe-561f6072de94@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215079fa-03bc-1b5b-dfbe-561f6072de94@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 09:40:44AM +0300, Gal Pressman wrote:
> > In the mlx drivers this was done during destruction of the ucontext,
> > but with this new mmap stuff it could be moved to the mmap_free..
> 
> Dealloc UAR is currently being called during dealloc_ucontext.
> The mmap_free callback is per entry, how can dealloc_uar be moved there?

If it is some global per context uar then sure, it should live till
dealloc ucontext

If it is a dynamicly created uar then it should have a shorter
lifetime.

Jason
