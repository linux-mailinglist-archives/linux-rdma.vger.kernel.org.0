Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A965FC3F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfGDRHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 13:07:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36551 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfGDRHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 13:07:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so5161403qtc.3
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XqfKYWKGSYLgbJr6fPQ+lFHdBqt7mzzp7w7+/NgGtDk=;
        b=X6NiXeAMF1OwtlTW4QqugOJ53ZeaHYD/sLo9k8HcbCwSQByg/XZqvCY4YZ+NYEl7+p
         iNzSMGDWZ5tSIXvWCBaZgIICKztGnisde/lW/EA7/5qeHQu+15yWvVUsJRLIZmnz8wha
         FFQqyPZ2lh/7vbQ1YNZqInN11zwc/aPBlJbKnEheIYIs5DRlEPuNf2j32b7lU2Cr/rcQ
         96vKhTR4yz256EpG20zwOf0ABEaIZ5Hm7+BC+Ly7ve2P51vGNgxR6r8d9luBnVSDGfnC
         hecuC40wXSVrpqNgLK4oewKcZuEQsgqJRuOyJclwZzjzgTs41CxzCm22YgsyxzVDu9Bi
         dJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XqfKYWKGSYLgbJr6fPQ+lFHdBqt7mzzp7w7+/NgGtDk=;
        b=k3DA87n9kpaOtKEtKpAti8BTHFhiRQRqWkOVOO40MFwwNfs3pDdvmpaKvmdyNYrxNA
         67n+Ejnk75as/6ZW7hJOK1vtr0ESjn9QjJ5Hwhr/WXn+xTD72ppVrErTNX3Co6YMq8tt
         Xmo1xcanOhrhY84Hh1v9amaVgMq8kvgavRAieC6MwWRks8964Fl1QVE+IXiHGlSvPcg7
         W9ZqqbuQxMqAsJJhrNJbvPXQZsgipDDpEiDSdMmt+2aiO5CCXwM+jf4h+UQZ4tBCSI5S
         gG9fdh5dnaUzbNL26WJ4IFkfHQhEhr90JCnHI2xy+5DoIEG75nqioT/IsuugqZ+ZUHRf
         JyaQ==
X-Gm-Message-State: APjAAAUMIi6mhVtTo3pd/mMiDFuKa5bzFfJN/CS5082vDaTfIYElKGnF
        OFV5oFVucabJfazYRqarOT/WjQ==
X-Google-Smtp-Source: APXvYqxtr+v0L2/2WEquOomQKVdBZ8+LLKmCnbiOU43dpww5W7vo+SURvHo2eSQslH/YdnPX0elgpQ==
X-Received: by 2002:aed:36c5:: with SMTP id f63mr36872490qtb.239.1562260073519;
        Thu, 04 Jul 2019 10:07:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b67sm2660401qkd.82.2019.07.04.10.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 10:07:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj5D6-000348-Ib; Thu, 04 Jul 2019 14:07:52 -0300
Date:   Thu, 4 Jul 2019 14:07:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: remove redundant assignment to variable ret
Message-ID: <20190704170752.GA11760@ziepe.ca>
References: <20190704125027.4514-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704125027.4514-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 04, 2019 at 01:50:27PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
