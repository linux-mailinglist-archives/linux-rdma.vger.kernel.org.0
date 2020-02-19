Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5A165149
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 22:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgBSVE1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 16:04:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36603 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgBSVE1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 16:04:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so1318397qto.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 13:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlQ1DdZVtOQ79Ly4B2P2CVldcz+qpusmxVLQ4O7DD+E=;
        b=e3Zh5BVUbCKm5uWgiTwjg3NxMnB7wufhpNbFaA007F2xmgut+wQ8sUDPZDEQL2t3b4
         vOvKP6F0H3CW3eMOMLATOlkzgI1GVHgbGregPOD90Ufh0R3TM0fNXfBzw1vwVuvcSWbM
         47iZNz0Osq0E19OJYB516CAXHgRkbndulIsrnQWTj51DdZp9RTw+wEOv+N6clMSU5Eap
         W0VdnoCi21Gem7gat123fizIKdlWEYCfEuONgfHvE6qATBSRuNxl9D6V4MsQAGO+dxEh
         x7bYBwifTFsH9tL0nq+ov9dpBp5taq7cGWQUCr1RhhmU/u1xGCR9ppBmmE0FOIZB+YFt
         w1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlQ1DdZVtOQ79Ly4B2P2CVldcz+qpusmxVLQ4O7DD+E=;
        b=KBVR5wPjlfRzNxyWqJMEqKYCZoFNTRYLlC8Y59Vb6ZzjrlRveEm/LRK+7OzeHZtkfP
         gh1GNjLLfZLiEj1k3suLp2Db0g2cIgnYybf1m/anT45PWZFdgEKn1l0SBRbmaP1P2cde
         +FFHZ0uQWyc+N3GngwLVotaz6UyvbYjfNP+8FodRDRpGHoegUAdCIbdrTQcvCz8cRza2
         ls0096Ijh1ZUhGl96p26Y16WxLcpCGhSwBv0y15DQKDWW26oy8svZBM5N8tcY/ftAWPF
         loVZ1zKYDWIliQ5Hzmdgoh6qoHbUskocFl+kCKRWcRVyw5zyEi2fXkeQKQnWv0eXGa94
         9a2Q==
X-Gm-Message-State: APjAAAWlkJySx5ES3EYZGyMroD/l5lq6mJtwJVspY5+Wyhz4/nic/ybi
        oGmr9i7vpOiOmSABI0vIzTUbLB5H+VQXkQ==
X-Google-Smtp-Source: APXvYqweJLb5yO/8QlJjeBPe1CqC0eRhchn5ATOE+e0crFBDgLbfVT/ncwz2XktaQboqzmz/dMhz0Q==
X-Received: by 2002:ac8:461a:: with SMTP id p26mr22856945qtn.317.1582146266244;
        Wed, 19 Feb 2020 13:04:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k50sm630504qtc.90.2020.02.19.13.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 13:04:25 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WW9-00072Q-Cw; Wed, 19 Feb 2020 17:04:25 -0400
Date:   Wed, 19 Feb 2020 17:04:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH RFC v2 for-next 3/7] qede: remove invalid notify operation
Message-ID: <20200219210425.GA31668@ziepe.ca>
References: <20200204082408.18728-1-liweihang@huawei.com>
 <20200204082408.18728-4-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204082408.18728-4-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:24:04PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The qedr notify() will remove the processing of QEDE_UP and QEDE_DOWN,
> so qede no more needs to notify rdma of these two events.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>  drivers/net/ethernet/qlogic/qede/qede_rdma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qede/qede_rdma.c b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
> index ffabc2d..0493279 100644
> +++ b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
> @@ -145,8 +145,6 @@ void qede_rdma_dev_remove(struct qede_dev *edev, bool recovery)
>  
>  static void _qede_rdma_dev_open(struct qede_dev *edev)
>  {
> -	if (qedr_drv && edev->rdma_info.qedr_dev && qedr_drv->notify)
> -		qedr_drv->notify(edev->rdma_info.qedr_dev, QEDE_UP);
>  }
>  
>  static void qede_rdma_dev_open(struct qede_dev *edev)
> @@ -161,8 +159,6 @@ static void qede_rdma_dev_open(struct qede_dev *edev)
>  
>  static void _qede_rdma_dev_close(struct qede_dev *edev)
>  {
> -	if (qedr_drv && edev->rdma_info.qedr_dev && qedr_drv->notify)
> -		qedr_drv->notify(edev->rdma_info.qedr_dev, QEDE_DOWN);
>  }

Leaving empty functions behind? Why?

I'm getting the feeling that this series is inside out or
backwards something. This change should not happen until the rdma
driver stops consuming these events

Jason
