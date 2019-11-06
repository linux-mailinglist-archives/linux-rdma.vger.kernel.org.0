Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4FF1CB2
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfKFRoo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 12:44:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39969 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfKFRoo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 12:44:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id o49so34554295qta.7
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 09:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHtEVR7lOieUA2c67QI9zbtaeiq11p2oTQRYTqRalmQ=;
        b=LBnr6bjONDE84gvNXE29X94ZL31Raa2jIoN7/3nAIbQ8pjf/CPob0/Ov3amXM8OcZF
         Ue4jrXcWInEPm7Y5se9cbMBhT8uJZaIvYyVC5Oclab2bGqV/ONRal6gtlQJRu65+CHqR
         mpM/5UgEAH8a8qkwtPZ845njfGFJ4u2Edfld3WemqC0a9JWvor0ccNnmWRjmIZEBOTSE
         ppbcHGVk6qlqz1nNXII/XGh/1P9fPSM06HKJ6OGBXqj/L9fEhVWsYIlXpeDvj6ZBvCJz
         P1d4vh8nVci/sZk/xHecck7etY0hkFQU7QRKjxXYiMi7zyPp8F63GEV4oa0UEYxIT88d
         soqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHtEVR7lOieUA2c67QI9zbtaeiq11p2oTQRYTqRalmQ=;
        b=C05pGjWpwdNMfDHgmHpk8UIsLoBkczNxwOrRltd2eb/y2XsSA2huZk1Dip8cgCYH5y
         85aKtyjjZqB8XrxqmKP9sZjUf0uaH8vThxZ2Gw0fOXWaI1JOx2elpetjGqz16wTFDh+x
         IlkXvclgb+PZ8naFLiUnuqCxl8VL7qXw2qpDjtnzPks6MDGNNZhsdH/z30T1vMIlM+sI
         nazyzU1dYfPlbyBFdCB2IzzjN4pKNeqNrhpYuRSCGEP8ch2ME/85cUQ7qHahRiVGpFU7
         t0P5UqpdhECMTNKa1LnkHXVBfemQczyE9T/Kk3fli7v6sKy3GTjIiCPBLg3ezkn8+SMb
         aimQ==
X-Gm-Message-State: APjAAAV5dP17c5b95jLXYWty62PNiBd19jRbjeeZ3sw5G2zhAcwMwYgl
        wMgYKtbLLPoPlrKtF/MT7sNjbQ==
X-Google-Smtp-Source: APXvYqxCo6rg7hTSGPQ7y3+u+gd6rfWAjY/GETi9qY7EzwvW6jthNmojRadMBNS7KwY0+svvst2LcA==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr3743569qtn.49.1573062281892;
        Wed, 06 Nov 2019 09:44:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u27sm15361765qtj.5.2019.11.06.09.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 09:44:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSPMG-0005UP-Mz; Wed, 06 Nov 2019 13:44:40 -0400
Date:   Wed, 6 Nov 2019 13:44:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc 0/2] RDMA/hns: Fix incorrect assignments
Message-ID: <20191106174440.GA20981@ziepe.ca>
References: <1572575610-52530-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572575610-52530-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 10:33:28AM +0800, Weihang Li wrote:
> 1. HNS_ROCE_HEM_CHUNK_LEN in patch 1/2 is used to initialize sg table, its
> current value is larger than needed.
> 2. srq_desc_size in patch 2/2 is used to allocate srq buffer, buffer size
> may be less than expected.
> 
> Sirong Wang (1):
>   RDMA/hns: Correct the value of HNS_ROCE_HEM_CHUNK_LEN
> 
> Wenpeng Liang (1):
>   RDMA/hns: Correct the value of srq_desc_size

Applied to for-next, thanks

Jason
