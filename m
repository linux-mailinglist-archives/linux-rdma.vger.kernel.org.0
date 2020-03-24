Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0D191D65
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 00:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCXXTb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 19:19:31 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41690 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCXXTa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Mar 2020 19:19:30 -0400
Received: by mail-qv1-f68.google.com with SMTP id o7so37445qvq.8
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2020 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iwuK+V+bSMY7skEQ9KSdoZ+/XCGhWcT7PycmSb6h+EM=;
        b=m4KFu0f39xN8B7TMeDg/ON9LHIi3Q9W+vqFmKYaY52YlQDcXO5WwwoFIrVNOJTOSu4
         An/qBFxQHQuPVUP1zdR5huUtA4gZBVS3edKJuJPwbwlKxdo06A2gxAB9SYmJHKCVGHCG
         iQYiYSXHFWYoerIv539b32LvLPNug3b8enF8JwfH+dL6a9kauXUNpgAYU7+Ns+0E/jEt
         A9gHD6uW1odDIurfBI+REP0GjMrkC9u1vfpunaFBb/EOX792bCdkcJG+n7oPRN80ccxt
         +V2QxZpPFq9u/pdTQetosLt2ZD77+UFq1jQxF/kPi5yd67gOq8lcZJLheEgXOx9oB6qm
         3VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iwuK+V+bSMY7skEQ9KSdoZ+/XCGhWcT7PycmSb6h+EM=;
        b=IoGnq4aW4u+Rul6rWnboVPclDgdM9M3GjAyse6UG63n9DjsZRWXOdnKgyp3HR8XApS
         3cStx0ZdgM9joiITo/f6trEzMypKZZmI35xtbB5enLMfrOhV32L3xg6QKFtmauLLSSdQ
         dOQljAfDoFSRcIT3O0s+BnvEUUYUigUO2lzXDkLDyeKILeZbq3y0jRXAuzK44FMVb8R1
         gpnJHkxAKCSueG0DbLfkq3NwbPs/mK3WkhUrAM5jaUhwqZKHHwEl7XaEhwUrJUGeZinF
         QOALf1i7b29DdFSJ+6l/JpO/Pv5xrgFOzK1WSuys8RbZQLhWxu2bHQ7EIfD7ecCof6jj
         tgyA==
X-Gm-Message-State: ANhLgQ1YyocFRH/I0cQrd8VDyTd1lSPFn5owNwDHjRcyU1UYUTEgBbqt
        4pJu8IrmRfZSLrXc5t+qMzfxZA==
X-Google-Smtp-Source: ADFU+vtfkpYfxRLWtubKE0aZ+6HgCsog6VpQZq5hSVvEdJecWXIcThaIsF1AOs9Srh0LPF6bd8gzDw==
X-Received: by 2002:a05:6214:16d1:: with SMTP id d17mr622140qvz.56.1585091968199;
        Tue, 24 Mar 2020 16:19:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 65sm14733066qtc.4.2020.03.24.16.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 16:19:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGspS-0002on-P6; Tue, 24 Mar 2020 20:19:26 -0300
Date:   Tue, 24 Mar 2020 20:19:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Optimize codes related to
 multi-hop addressing
Message-ID: <20200324231926.GA10804@ziepe.ca>
References: <1584417324-2255-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584417324-2255-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 11:55:22AM +0800, Weihang Li wrote:
> Codes about getting/putting HEM(Hardware Entry Memory) in multi-hop
> addressing are not clear enough, so optimize by spliting and encapsulating
> them into new functions.
> 
> Xi Wang (2):
>   RDMA/hns: Optimize mhop get flow for multi-hop addressing
>   RDMA/hns: Optimize mhop put flow for multi-hop addressing

Applied to for-next, thanks

Jason
