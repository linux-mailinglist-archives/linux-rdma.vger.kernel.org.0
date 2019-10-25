Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75F6E5440
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 21:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfJYTVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 15:21:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46427 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYTVR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 15:21:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id e66so2775387qkf.13
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fVPB/e3BQW8Y9NR7n7xSjx+WJob+Yhi1BRW6ZfDKXTM=;
        b=K1ht5PJa9f3QyGx8I+oVWh+Kwg7+dS7Sxt/OWouHExELkSj1bjihe7tiTNl+aoICjQ
         YpjzdPPLqDfvCgzsM4WXhl2tGo6ZHPNMe6MmgQ58JT4J6bPxxUNXay32enKMZ6P05DLS
         YWf+wpNPZSSfXQWEzzsruVhqtAj3PVoqa6IB2nEMNrCvM+ogw8Os3ZdNfDfS0fNFt2Au
         uWQNy+1n+uYSh9QpSlR34Zv3PZx3HOM1b0vVHS0ZVECkEZOy6Kr7ePdWgijbdOMWeWqG
         OUBY5DkFVl/73mKPkyVOxGn8AEVAvhG6el3xktjRe6dj1yseT8l7TtUmcz0Sj4Qvt+pN
         Q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVPB/e3BQW8Y9NR7n7xSjx+WJob+Yhi1BRW6ZfDKXTM=;
        b=G7NKXT3sg7OWOMpbb+efPEw8hse6s3lQ0idvzOXEyVA76qBlcqQkboHtOB9dBEodas
         W8r/tG+FFainoekOY9KfdsFFy0QqhZYcemZCatsa/donvm4Egt+y3B737EK1Dvpg2knv
         X6k6abUqWR61BtrJF0+/uza3a89PycEdYJkHnud8PkvxmotaY1ljeUfGTi0547TyrcV6
         4T4vKQ+za0wJojclykBilJHswb7PEkPPKl19wvTukZGBAWYreZGSQOPn65OsZ/c7vjSp
         P3YyDDVVPHQUvCfV7O6pSWvgTSp08t4xgzC7oMh76B4TqmY9p8xDmDgJHHDf4chxAL2x
         Iucw==
X-Gm-Message-State: APjAAAV9kFsEjrIbRffYlYYrITuAWziMEt1GZgyKPHMgW4DUy5nux25J
        DeHMsbkUlCm5UqpM3FLbs5PBcX7IVm4=
X-Google-Smtp-Source: APXvYqxcsbcVCDxjC6S3eTvQkVmr0Qobeubs+6XuqI+pGE+ePc0Kh6o58WYdTUvOkFAjKdm3ysl9Rw==
X-Received: by 2002:a37:4f88:: with SMTP id d130mr4579295qkb.168.1572031275521;
        Fri, 25 Oct 2019 12:21:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w20sm1471482qkj.58.2019.10.25.12.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2019 12:21:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iO598-00088a-Cx; Fri, 25 Oct 2019 16:21:14 -0300
Date:   Fri, 25 Oct 2019 16:21:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH 01/15] RDMA/mlx5: Use SRCU properly in ODP prefetch
Message-ID: <20191025192114.GA31165@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
 <20191009160934.3143-2-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009160934.3143-2-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 09, 2019 at 01:09:21PM -0300, Jason Gunthorpe wrote:
> -static void mlx5_ib_prefetch_mr_work(struct work_struct *work)
> +static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
> +				    enum ib_uverbs_advise_mr_advice advice,
> +				    u32 pf_flags, struct ib_sge *sg_list,
> +				    u32 num_sge)
>  {
> -	struct prefetch_mr_work *w =
> -		container_of(work, struct prefetch_mr_work, work);
> +	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> +	u32 bytes_mapped = 0;
> +	int srcu_key;
> +	int ret = 0;
> +	u32 i;
>  
> -	if (ib_device_try_get(w->pd->device)) {
> -		mlx5_ib_prefetch_sg_list(w->pd, w->pf_flags, w->sg_list,
> -					 w->num_sge);
> -		ib_device_put(w->pd->device);
> +	srcu_key = srcu_read_lock(&dev->mr_srcu);
> +	for (i = 0; i < num_sge; ++i) {
> +		struct mlx5_ib_mr *mr;
> +
> +		mr = get_prefetchable_mr(pd, advice, sg_list[i].lkey);
> +		if (!mr) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +		ret = pagefault_mr(mr, sg_list[i].addr, sg_list[i].length,
> +				   &bytes_mapped, pf_flags);
> +		if (ret < 0)
> +			goto out;
>  	}

There is a mistake here, 'ret' has to be 0 when this function succeeds
but pagefault_mr returns >0 on success. Needs a 'ret = 0' at this
point

Jason
