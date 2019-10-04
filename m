Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857B0CC318
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJDSze (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:55:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37990 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJDSze (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:55:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id u186so6778078qkc.5
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ZIbtkgjYP1u8VQgXJ7nU6iGRJTyapHT58TO3gEkFCc=;
        b=Q7gMe65nT5IffXPiXIBhgH4DxXUcCbMKsNXzZMJpvyPtXkEZP6cE7oO3Qc1zP9Rq6m
         wACZ63/l6yDe7mQkssyOJoCSzyYMxmE/gjqHQGKn4mv30VWU4h+5gwxi/2J467ehxbv+
         vxQSaS402SnsThQl7QFqi30mjYm8GNNEJRtJdQ8kXP27+X8XMjX5rU7lecSJ5mt8kC3O
         rSuCGOy/tBHbqE28tnaikFxksiVgMBignCT9b3OBaR2ieEcCjc0gl5o+JcQGiVqn1MvU
         kSnX2w4voIgf4cxYFRkYvRVBtmam7QAOMkvF4x9ZoCDMvjm6WofMAqFvGdXtTGZCGYJa
         rRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ZIbtkgjYP1u8VQgXJ7nU6iGRJTyapHT58TO3gEkFCc=;
        b=f/RhtHs9sAhywn/LUb9M5YITbVeiIIo1QbgLw1TGGBMjc+ZKWG2oNc2bFb3xWwPTXf
         dUZtCc+mlrZra8Yii9sK8uUFXcvtf76kC84AQqJkomiYFh5mqhrh2twXcUBo50Nrm5V5
         i1opsrI4zzmnjzRF1v9AX7cT3XY4SoK/sQBRu06jK47CKmwGtwAaM0MQZ12vUw+N25t+
         76aK8iq2/3mfWt8xEIX81X27dEtgSBoiF2Ks+ZHHQRV7g6AeOV05F6M122N1DorV2YH7
         z0ojicadCzbwn7r472/fy/Pepgp9GLGyybmwO9obNzFR3cKpIGes6udSitWsNzpZZL8M
         THWg==
X-Gm-Message-State: APjAAAWKzOUzV6i7btGhJXyHId6MB5Pr+JoNUTGA2/7vaa3cI+IPaoRZ
        PwUBOTpTCsns0CEKIF/hhulMq9yVEhQ=
X-Google-Smtp-Source: APXvYqxJZNwmhqWY919/t0TiiGhAN+pW+EhDw7Pgl6EJzhS1spcePygpvblr4qDo5eszvzZLv01F6A==
X-Received: by 2002:ae9:eb46:: with SMTP id b67mr11762465qkg.401.1570215333415;
        Fri, 04 Oct 2019 11:55:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u132sm3412679qka.50.2019.10.04.11.55.32
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:55:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGSjk-0005Po-Es
        for linux-rdma@vger.kernel.org; Fri, 04 Oct 2019 15:55:32 -0300
Date:   Fri, 4 Oct 2019 15:55:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH -rc 0/6] Bug fixes for odp
Message-ID: <20191004185532.GA20755@ziepe.ca>
References: <20191001153821.23621-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001153821.23621-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 01, 2019 at 12:38:15PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Various assorted bug fixes for the ODP feature closing races and other bad
> locking things we be seeing in the field.
> 
> Jason Gunthorpe (6):
>   RDMA/mlx5: Do not allow rereg of a ODP MR
>   RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an implicit MR
>   RDMA/odp: Lift umem_mutex out of ib_umem_odp_unmap_dma_pages()
>   RDMA/mlx5: Order num_pending_prefetch properly with synchronize_srcu
>   RDMA/mlx5: Put live in the correct place for ODP MRs
>   RDMA/mlx5: Add missing synchronize_srcu() for MW cases

Applied to for-rc

Jason
