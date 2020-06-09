Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71BB1F3FE8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgFIPyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 11:54:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:21322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbgFIPyV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jun 2020 11:54:21 -0400
IronPort-SDR: Rb48gSd4VxpWqSHLiCeVb5fQLFKkSuZsibJgTrTwtMeAxr9fYeav4YbrIDFLDKchBMVumdzeJz
 tdDVupmXUZww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 08:54:20 -0700
IronPort-SDR: j8fdzh4VNZ0jOMdN2zYA77cv2ZUKwrru2DIshZDAPt3L15vhQUYCg8ErHoLyNQPDQorgKGnBha
 YOm09I3+pteQ==
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="447168961"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.203.173]) ([10.254.203.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 08:54:19 -0700
Subject: Re: [PATCH 11/17] drivers: infiniband: Fix trivial spelling
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
 <20200609124610.3445662-12-kieran.bingham+renesas@ideasonboard.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <80843bf3-25a3-37b0-f687-9a5e01546c72@intel.com>
Date:   Tue, 9 Jun 2020 11:54:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609124610.3445662-12-kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/9/2020 8:46 AM, Kieran Bingham wrote:
> The word 'descriptor' is misspelled throughout the tree.
> 
> Fix it up accordingly:
>      decriptors -> descriptors
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>   drivers/infiniband/hw/hfi1/ipoib_tx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> index 883cb9d48022..175290c56db9 100644
> --- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
> +++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> @@ -364,7 +364,7 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
>   	if (unlikely(!tx))
>   		return ERR_PTR(-ENOMEM);
>   
> -	/* so that we can test if the sdma decriptors are there */
> +	/* so that we can test if the sdma descriptors are there */
>   	tx->txreq.num_desc = 0;
>   	tx->priv = priv;
>   	tx->txq = txp->txq;
> 

Thanks

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
