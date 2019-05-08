Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB017A7B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfEHNWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 09:22:32 -0400
Received: from verein.lst.de ([213.95.11.211]:39687 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfEHNWb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 09:22:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2D68367358; Wed,  8 May 2019 15:22:12 +0200 (CEST)
Date:   Wed, 8 May 2019 15:22:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 12/25] IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI
 handover
Message-ID: <20190508132211.GI27010@lst.de>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com> <1557236319-9986-13-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557236319-9986-13-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> @@ -325,20 +296,12 @@ iser_create_fastreg_desc(struct iser_device *device,
>  	if (!desc)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = iser_alloc_reg_res(device, pd, &desc->rsc, size);
> +	ret = iser_alloc_reg_res(device, pd, &desc->rsc, size, pi_enable);
>  	if (ret)
>  		goto reg_res_alloc_failure;
>  
> -	if (pi_enable) {
> -		ret = iser_alloc_pi_ctx(device, pd, desc, size);
> -		if (ret)
> -			goto pi_ctx_alloc_failure;
> -	}
> -

Is there any reason to keep iser_create_fastreg_desc and
iser_alloc_reg_res separate after this?
