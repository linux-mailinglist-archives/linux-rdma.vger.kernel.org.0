Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3E3407E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFDHjT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 03:39:19 -0400
Received: from verein.lst.de ([213.95.11.211]:33912 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfFDHjT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 03:39:19 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 15E3368B02; Tue,  4 Jun 2019 09:38:52 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:38:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: Re: [PATCH 06/20] RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
 mlx5_ib_alloc_mr_integrity
Message-ID: <20190604073851.GO15680@lst.de>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com> <1559222731-16715-7-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559222731-16715-7-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>  int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  {
> -	dereg_mr(to_mdev(ibmr->device), to_mmr(ibmr));
> +	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
> +
> +	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
> +		dereg_mr(to_mdev(mmr->pi_mr->ibmr.device), mmr->pi_mr);
> +
> +	dereg_mr(to_mdev(ibmr->device), mmr);

Just curious: how could the device for the PI MR be different?  In other
words, why can't this just be:

	struct mlx5_ib_mr *mmr = to_mmr(ibmr);

	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
		mmr = mmr->pi_mr;
	dereg_mr(to_mdev(ibmr->device), mmr);

