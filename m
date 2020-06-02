Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B142A1EBF07
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFBPaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 11:30:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:16053 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFBPaj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jun 2020 11:30:39 -0400
IronPort-SDR: /IG68SwVwgXGShQyWxhrFQpbSBnjVN+av9WFZ+RYHP0a6IN3X5lkUS0lTxM8rVUo6hagyilDW3
 cFDTYTOXBd8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 08:30:26 -0700
IronPort-SDR: d5EdmYzh9a8PyRQSBpfkNaZ5Zx17bWFjOT8KVeU+Lrb7xj0hvAMCoxRMHpd0lWwK9Zpn3o7iNH
 4LXThYfTl8Qw==
X-IronPort-AV: E=Sophos;i="5.73,464,1583222400"; 
   d="scan'208";a="257661820"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.200.182]) ([10.254.200.182])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 08:30:15 -0700
Subject: Re: [PATCH -next] IB/hfi1: Use free_netdev() in hfi1_netdev_free()
To:     YueHaibing <yuehaibing@huawei.com>, mike.marciniszyn@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, sadanand.warrier@intel.com,
        grzegorz.andrejczuk@intel.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, kernel-janitors@vger.kernel.org
References: <20200601135644.GD4872@ziepe.ca>
 <20200602061635.31224-1-yuehaibing@huawei.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <75257c20-3cf2-7ecc-0d66-e1f4155ba105@intel.com>
Date:   Tue, 2 Jun 2020 11:30:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200602061635.31224-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/2/2020 2:16 AM, YueHaibing wrote:
> dummy_netdev shold be freed by free_netdev() instead of
> kfree(). Also remove unneeded variable 'priv'
> 
> Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/infiniband/hw/hfi1/netdev_rx.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
> index 58af6a454761..63688e85e8da 100644
> --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> @@ -371,12 +371,9 @@ int hfi1_netdev_alloc(struct hfi1_devdata *dd)
>   
>   void hfi1_netdev_free(struct hfi1_devdata *dd)
>   {
> -	struct hfi1_netdev_priv *priv;
> -
>   	if (dd->dummy_netdev) {
> -		priv = hfi1_netdev_priv(dd->dummy_netdev);
>   		dd_dev_info(dd, "hfi1 netdev freed\n");
> -		kfree(dd->dummy_netdev);
> +		free_netdev(dd->dummy_netdev);
>   		dd->dummy_netdev = NULL;
>   	}
>   }
> 

For the kfree->free_netdev, you probably want to add:
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Also can add:
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

Thanks
