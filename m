Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5324E707C6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGVRnX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 13:43:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45532 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfGVRnX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 13:43:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id h28so26758580vsl.12
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WGiYXAML3juzJ6cmDjuA/zNldcENeSwVhV5S53qiteI=;
        b=EiNHzBm6sdlxeOUMGiAX+m2trBU9lrRx9pgwIlve3Lj+9usyNzEyFz9xUjj4GP1cLn
         R60+gnrQsEgFey8LwscIreZ2cNuegD458Zlk43FthFjwCkWScJPHQq3TUzM8BhuGEkCo
         kM6FmyiVZRP0Ry89te+QD2kEY77MDNl3axZlA78/L21HhzNro/5YVKCxyBOztaL0TsFv
         zbcYDbk+kxOEexSnVIaYMA1QSwvDJyqRLfNyFYInq5IbHCi6/oaj6FNsHbRJU0tGdzfg
         AbfzAsin7tV9XQeZ5pNb+Sfv9gJc2aoDRi9hkqfh5udHKv39V5Y1KbGbc8HkDqvEn18C
         5P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGiYXAML3juzJ6cmDjuA/zNldcENeSwVhV5S53qiteI=;
        b=ahuvJjg49MP3vCNr3NGaofar1cbO66Z/k1Ut5iewaDcNGh30Wl1yJAaM4VcrgNKrzw
         nOXsBzA/Nl8GAmAU6MOsSDtFgi+kTZKAsx+CvRQIdBOq+dEAt/iumeWAk34y6enEfMzI
         TefdJnPpIYNdKXo+5GktRAdZXItdRZUzEIRFbnn2Lru31h3wmOu6x1ccRrrt5iSZR0x8
         2l3LHTyoY/5ebM1YF+yObN1JISJYZh4etJ31dkQrVYejlojBgE/Mh3TguPffccGzp7Xe
         1Wa6cigDp5c4VS4xG1uOcyF3XMS8BAmKaIngia9sZtMVsBSXsB8fxBbUQeP+aQAJbH1B
         vnVg==
X-Gm-Message-State: APjAAAUUqPGLqrM/zDd5lPlphImBeV94vgxY5mDxAHYSRJpXdp1ryLF1
        l58EplzdrlAFjT50Hdnr1Nihxw==
X-Google-Smtp-Source: APXvYqxYolf5TUUcg56GC1HJsZ1RyN88VxHGMudq6qG/SjwIQz7IR8mwZQ8soNR4Zhot1KZMcTkPOA==
X-Received: by 2002:a67:eed3:: with SMTP id o19mr38968800vsp.225.1563817402202;
        Mon, 22 Jul 2019 10:43:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t190sm14356934vkt.31.2019.07.22.10.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 10:43:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpcLH-00089P-Sb; Mon, 22 Jul 2019 14:43:19 -0300
Date:   Mon, 22 Jul 2019 14:43:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: fix error return code in siw_init_module()
Message-ID: <20190722174319.GA31295@ziepe.ca>
References: <20190718092710.85709-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718092710.85709-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 18, 2019 at 09:27:10AM +0000, Wei Yongjun wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>  drivers/infiniband/sw/siw/siw_main.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
