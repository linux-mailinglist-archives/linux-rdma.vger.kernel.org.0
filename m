Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBC1F3FE4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgFIPyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 11:54:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:4236 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbgFIPyB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jun 2020 11:54:01 -0400
IronPort-SDR: gBmHGsHiu4t0KZjjxRmGC9mk1B6ysSkZe0OctVOX0qX01fKX0KhQ/1Dy5qJf0YQNGMizcUKRkM
 DmL3V/84xjLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 08:54:00 -0700
IronPort-SDR: geHkTrUZMj15qOc12rlaH2e0SMypdb98/seukcAPFvrRVbaK2xehJqdF8spQYw3AZkNENu0UOS
 BL6dIwvL++hQ==
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="447168863"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.203.173]) ([10.254.203.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 08:53:58 -0700
Subject: Re: [PATCH 02/17] drivers: infiniband: Fix trivial spelling
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
 <20200609124610.3445662-3-kieran.bingham+renesas@ideasonboard.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <8909aaf3-027d-17ed-d887-6bffe5c04366@intel.com>
Date:   Tue, 9 Jun 2020 11:53:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609124610.3445662-3-kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/9/2020 8:45 AM, Kieran Bingham wrote:
> The word 'descriptor' is misspelled throughout the tree.
> 
> Fix it up accordingly:
>      decriptors -> descriptors
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>   drivers/infiniband/hw/hfi1/iowait.h      | 2 +-
>   drivers/infiniband/hw/hfi1/verbs_txreq.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/iowait.h b/drivers/infiniband/hw/hfi1/iowait.h
> index 07847cb72169..d580aa17ae37 100644
> --- a/drivers/infiniband/hw/hfi1/iowait.h
> +++ b/drivers/infiniband/hw/hfi1/iowait.h
> @@ -399,7 +399,7 @@ static inline void iowait_get_priority(struct iowait *w)
>    * @wait_head: the wait queue
>    *
>    * This function is called to insert an iowait struct into a
> - * wait queue after a resource (eg, sdma decriptor or pio
> + * wait queue after a resource (eg, sdma descriptor or pio
>    * buffer) is run out.
>    */
>   static inline void iowait_queue(bool pkts_sent, struct iowait *w,
> diff --git a/drivers/infiniband/hw/hfi1/verbs_txreq.h b/drivers/infiniband/hw/hfi1/verbs_txreq.h
> index bfa6e081cb56..d2d526c5a756 100644
> --- a/drivers/infiniband/hw/hfi1/verbs_txreq.h
> +++ b/drivers/infiniband/hw/hfi1/verbs_txreq.h
> @@ -91,7 +91,7 @@ static inline struct verbs_txreq *get_txreq(struct hfi1_ibdev *dev,
>   	tx->mr = NULL;
>   	tx->sde = priv->s_sde;
>   	tx->psc = priv->s_sendcontext;
> -	/* so that we can test if the sdma decriptors are there */
> +	/* so that we can test if the sdma descriptors are there */
>   	tx->txreq.num_desc = 0;
>   	/* Set the header type */
>   	tx->phdr.hdr.hdr_type = priv->hdr_type;
> 

Thanks

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
