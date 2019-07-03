Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1195EDEB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCUzI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 16:55:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45055 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfGCUzI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 16:55:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so3779380otl.11
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 13:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LAqcKetmVJkHlyzw0Yg03PnxEAS+R1PpYvL0//WJ3Dw=;
        b=OXYerhk/4KiBXlK4WZQE/1636M01ZKas5W1G6WY6kpKYxMaUGZPgv+Ng3ZWLxRdpdg
         uqk7LnN8m3ESh4LniI5x0iA7j9je4JmXChvYwRMaQK+m/pYiQrSdJM/SjcubeygHQUBB
         /STZPkENk+UDS8eJhXU/lHmMQtpYmg4oD3L+tRgZpGwcYN2mS2ImivBRyXHsC23lJaDp
         D5ySxJ+iG/WJxhVqo7VTbl3VeP+QkTCddvDgeMzaOXN1uubm8SAMe2xKUOG7e5jFw9gz
         vp0JSR6fddoVMVbbeTCPSIe6ohCE4lBId+M9TXviSVzf07p1gN4SMGxF2Urn3ZDIjeuK
         Kl/Q==
X-Gm-Message-State: APjAAAWZGqwq+x27cEyrA1wriujoA7ETpftbPazQX3dVHjG4dDPWaSbP
        nrA0JvFj5mobjnby97+muIc=
X-Google-Smtp-Source: APXvYqxmffx/SMwYfgda0+NH6kegAlJecyYB+/Ig2FuYT3AS6zS9PpXjWRDEEAZrpLNbZvJBFa8Big==
X-Received: by 2002:a9d:a76:: with SMTP id 109mr28893479otg.252.1562187307564;
        Wed, 03 Jul 2019 13:55:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id c64sm1265737otb.79.2019.07.03.13.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:55:06 -0700 (PDT)
Subject: Re: [PATCH rdma-next v3 2/3] RDMA/core: Provide RDMA DIM support for
 ULPs
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
References: <20190630091057.11507-1-leon@kernel.org>
 <20190630091057.11507-3-leon@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bb69524a-d90c-e456-b07d-720cf11e617c@grimberg.me>
Date:   Wed, 3 Jul 2019 13:55:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190630091057.11507-3-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Can you please split the mlx5 to its own patch?

> +static void ib_cq_rdma_dim_work(struct work_struct *w)
> +{
> +	struct dim *dim = container_of(w, struct dim, work);
> +	struct ib_cq *cq = (struct ib_cq *)dim->dim_owner;

No need to cast a void pointer

>   static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
>   			   int batch)
>   {
> @@ -78,6 +112,7 @@ static void ib_cq_completion_direct(struct ib_cq *cq, void *private)
>   static int ib_poll_handler(struct irq_poll *iop, int budget)
>   {
>   	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
> +	struct dim *dim = cq->dim;
>   	int completed;

Is there really a need for this local variable? I'd say you can safely
drop it.

The rest looks fine.
