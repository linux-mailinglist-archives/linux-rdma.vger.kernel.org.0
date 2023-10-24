Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE07D551A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjJXPQc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjJXPQ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 11:16:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F93EA;
        Tue, 24 Oct 2023 08:16:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936FDC433CD;
        Tue, 24 Oct 2023 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160586;
        bh=/C6E6tZNLUaoLoiYdGV1pjU5ihBkYuq/xjH5Z7ZWGMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPq9hWlX7HZJM1/Td4WXD6mSoaAVDSCjY0mEfEMvjtc3jYDQcxTEbdxj9mr02UrdW
         NB9pInQWEb6VkuGnBIAQyfIxYQtEIUIadXnp75HUE3Y8tiopfjgF9EIeMXOzGsnaUD
         zE4dcvlV2l4GYHjQ+XhKg6F3pbW6mmb+NcdCnBtEfxaT71Q/kVyoAJ2QL/vQiyCjk+
         nDxy0t8OEKoIQw6wO/cn4spmC+CIgufdmbbcvdgFjF48IuQWYS8MLSnUfFuwvJY/Wi
         8zz4kE1IUU4W8PpGjzgWwx+IH0H/g4ZvEjZiNIL9aHRsBaZjWSHLfHKajrOPxuT8La
         Cxla92Qx+bhZA==
Date:   Tue, 24 Oct 2023 18:16:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/core: Remove NULL check before dev_{put, hold}
Message-ID: <20231024151621.GB1939579@unreal>
References: <20231024003815.89742-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024003815.89742-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 24, 2023 at 08:38:15AM +0800, Yang Li wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/infiniband/core/nldev.c:375:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7047
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/infiniband/core/nldev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I added the following hunk and applied the patch.

diff --git a/drivers/infiniband/core/lag.c b/drivers/infiniband/core/lag.c
index c77d7d2559a1..eca6e37c72ba 100644
--- a/drivers/infiniband/core/lag.c
+++ b/drivers/infiniband/core/lag.c
@@ -102,8 +102,7 @@ static struct net_device *rdma_get_xmit_slave_udp(struct ib_device *device,
 
 void rdma_lag_put_ah_roce_slave(struct net_device *xmit_slave)
 {
-	if (xmit_slave)
-		dev_put(xmit_slave);
+	dev_put(xmit_slave);
 }
 
 struct net_device *rdma_lag_get_ah_roce_slave(struct ib_device *device,
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 343288b02792..a5e88185171f 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -1021,10 +1021,8 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	pvrdma_free_irq(dev);
 	pci_free_irq_vectors(pdev);
 err_free_cq_ring:
-	if (dev->netdev) {
-		dev_put(dev->netdev);
-		dev->netdev = NULL;
-	}
+	dev_put(dev->netdev);
+	dev->netdev = NULL;
 	pvrdma_page_dir_cleanup(dev, &dev->cq_pdir);
 err_free_async_ring:
 	pvrdma_page_dir_cleanup(dev, &dev->async_pdir);
@@ -1064,10 +1062,8 @@ static void pvrdma_pci_remove(struct pci_dev *pdev)
 
 	flush_workqueue(event_wq);
 
-	if (dev->netdev) {
-		dev_put(dev->netdev);
-		dev->netdev = NULL;
-	}
+	dev_put(dev->netdev);
+	dev->netdev = NULL;
 
 	/* Unregister ib device */
 	ib_unregister_device(&dev->ib_dev);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index cf8b0822f5c8..967004ccad98 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2005,8 +2005,7 @@ static void ipoib_ndo_uninit(struct net_device *dev)
 		priv->wq = NULL;
 	}
 
-	if (priv->parent)
-		dev_put(priv->parent);
+	dev_put(priv->parent);
 }
 
 static int ipoib_set_vf_link_state(struct net_device *dev, int vf, int link_state)

> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 87b8cd657fb3..4900a0848124 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -371,8 +371,7 @@ static int fill_port_info(struct sk_buff *msg,
>  	}
>  
>  out:
> -	if (netdev)
> -		dev_put(netdev);
> +	dev_put(netdev);
>  	return ret;
>  }
>  
> -- 
> 2.20.1.7.g153144c
> 
