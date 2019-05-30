Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D530220
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE3Snc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:43:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42321 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfE3Snc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:43:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so4556268qkc.9
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUie64/qC+90Uz/gKolRXnUiAy4nHqngEGJ4fSt7KR8=;
        b=DaZtLdpScPYOOF/BjxCxP3yGwR9TR5PeBbqHHquAFF79GiEXdykaOA1nAEk1QxqUYY
         3KZGTVPojYgQlSQ5Gv3C+gId0iQBm7z0qKiQ8SJrtxHFqNDmmMQDiZ5lZWqWC0Jz4dtf
         Rc+k9fHE98G8sueQYP0tWzZGODkOO5GFgkeIJ5kQhjt1Jd/CKDSaOfs4erhVpNWMEKUQ
         OV8CPaUjCHIzblfU6Uuoj3XSHO3nSvjN0w3gqZPNT6fUVnOeUze7kqdzPmM3nn3A79+e
         ENs8NXSyuFFopnP+cct7CRx0SFtGRSkRqXk9OumLDpbJJ1p+2LBmFAMUN7RWFq1Cc9KE
         XQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUie64/qC+90Uz/gKolRXnUiAy4nHqngEGJ4fSt7KR8=;
        b=E0C/WwNo88NiFgcogbZliKAbBs+1YpllM/LzbhieDkxs1WQlX5eAthB6bdfIfsX/1q
         st9bd1HMYitAUKMrtCveXnXVBavsFVmp8RoNLXllG1v6O5YA4gZFb4EhTmWQJlG+vQlC
         3fLD4bO2JJXMJKLHyoNZsoMPil6Um2wWerpV66YYVKaRcq1P/LTLT1tYrEgsY35GHcU2
         8F9OSDec2kVim/HKS8bD2Wlv1MfZgIxgfWFoMzPU5hqLibRvfo1oMa/en7HbtKl40YPq
         DdCh4/iMqB9dhYb/W0Vm4k/WNtDad+GdqE3xezAqdnc9GllVUbdS7Yzv2pmlEFE7Uoxy
         Tu7A==
X-Gm-Message-State: APjAAAUIhCA6o0FUeFHkaUBAffy/jyqcu8BJiVydzSgIaw4p1wmySh23
        Nib7rb31zZTpRFgwfR9ZH6+NfQ==
X-Google-Smtp-Source: APXvYqxLbqSRX5R4cR9BBYQXTcp54f3lB3QkcHo6jQRSMrdnMZAsFM01QpFSNz+egvbe8hz1F2Y7cw==
X-Received: by 2002:a05:620a:12d9:: with SMTP id e25mr4647750qkl.279.1559241811722;
        Thu, 30 May 2019 11:43:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p1sm307063qti.83.2019.05.30.11.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:43:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQ1S-0007kH-Up; Thu, 30 May 2019 15:43:30 -0300
Date:   Thu, 30 May 2019 15:43:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/hfi1: Use struct_size() helper
Message-ID: <20190530184330.GC29724@ziepe.ca>
References: <20190529151528.GA24148@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529151528.GA24148@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 10:15:28AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(struct opa_port_status_rsp) + num_vls * sizeof(struct _vls_pctrs)
> 
> with:
> 
> struct_size(rsp, vls, num_vls)
> 
> and so on...
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/mad.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
