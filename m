Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBB5EB34
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfGCSIE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 14:08:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36202 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGCSIE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 14:08:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so3557032qkl.3
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OYaxpn48U3skDTAdtQfXdHDeoqepuheTmkb2SxvtSV4=;
        b=gLYuktienQrDuUAp1WFjQf9xfPah11Dw6buUfEY1JFPCj3dCv2lZStTxOFPD00D+bF
         1PN46v1fKJLgrylUoqtrYdD5ziCfLs9KUieOM3uuNZ3RwDnYjbsqJt5teuV/9fTNqmcG
         6Hr9dGTWjxzYNS6rrKnwjJufd35xKzDiYyinjag153AXL6v1aXApKnruH2HQN5+u0oAD
         BHzF7u+HHQjP7y+c2ROEhyex2qPr+7U7r/R8IhkOkGNR8oc9GMEjO+bwNKYKHqfi2Xas
         6huoBd3fhDoT3jhOzUP3FY6Q/MRanmQflSwOkzE0r2uFxbTgEjRgffik6V6IqB1FXs5e
         AUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYaxpn48U3skDTAdtQfXdHDeoqepuheTmkb2SxvtSV4=;
        b=eAzZHKER+l80UeIixWPzAJBpFXp9sI9qQVbWEgpFKGrdRQF5/qJypZgzneiKvC21RM
         6JqDXqZmclBEoFIt6+ofBayZ4gJUvfRaYUtFiv8VtDd9pmzxFxkT5qpoG6UUrIHC92zr
         Zd2zVqrYK5C2UFAKoMPAVZPsCNazFBezKoHgS43nfV3ABNQh0gGuCKRdmC8UIfhz++6r
         S+ok/vh4Trzcx9caOcm9d2MfX+2HovUlUtijAq7oN1XRGFXCxctskFb86yt/Ag646iK1
         ePF+/SdEYRTtxYqx5uL4vllIZLGi00yiZNsktigzG5Ws+/Jlti9fBMWWYl1FnUTTQfxZ
         eE+g==
X-Gm-Message-State: APjAAAUxQbZrOUyvCXz9t+vC9PNc/KIFwospj7tPdvmq/qI+AiBUAKXD
        DmPwSJo1Lz4kbMiKZ/XYkcUt9Q==
X-Google-Smtp-Source: APXvYqyPj+RA7zrPQrkcrn6bqzjUH/COcT3yrysSoSj0d+OXpkzq9JwddxUbZ+DeNDguNB5M7a3aCQ==
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr32281639qkk.82.1562177282977;
        Wed, 03 Jul 2019 11:08:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o54sm1450159qtb.63.2019.07.03.11.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:08:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijfm-0006ur-5o; Wed, 03 Jul 2019 15:08:02 -0300
Date:   Wed, 3 Jul 2019 15:08:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 35/39] docs: infiniband: add it to the driver-api bookset
Message-ID: <20190703180802.GA26557@ziepe.ca>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <12743088687a9b0b305c05b62a5093056a4190b8.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12743088687a9b0b305c05b62a5093056a4190b8.1561724493.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 09:30:28AM -0300, Mauro Carvalho Chehab wrote:
> While this contains some uAPI stuff, it was intended to be
> read by a kernel doc. So, let's not move it to a different
> dir, but, instead, just add it to the driver-api bookset.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>  Documentation/index.rst            | 1 +
>  Documentation/infiniband/index.rst | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index ea33cbbccd9d..e69d2fde7735 100644
> +++ b/Documentation/index.rst
> @@ -96,6 +96,7 @@ needed).
>     block/index
>     hid/index
>     iio/index
> +   infiniband/index
>     leds/index
>     media/index
>     networking/index
> diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
> index 22eea64de722..9cd7615438b9 100644
> +++ b/Documentation/infiniband/index.rst
> @@ -1,4 +1,4 @@
> -:orphan:
> +.. SPDX-License-Identifier: GPL-2.0
>  
>  ==========
>  InfiniBand

Should this one go to the rdma.git as well? It looks like yes

Thanks,
Jason
