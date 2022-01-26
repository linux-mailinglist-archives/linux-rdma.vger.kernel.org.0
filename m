Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF749C6C7
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jan 2022 10:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiAZJrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jan 2022 04:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiAZJrW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jan 2022 04:47:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A863C06161C;
        Wed, 26 Jan 2022 01:47:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06E68B81C10;
        Wed, 26 Jan 2022 09:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FBFC340E3;
        Wed, 26 Jan 2022 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643190439;
        bh=qO3B4gK7GA2y/Bvlgz0H7y6fmCCHCCV6zEgHDWBX64o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQo8TtyMVTeigBO1kDBOr8Gxu46gN0OjpckZSef7vAdbpNAZjXmWWrCF0w8o3kRC2
         OcVb87aw5oA+Bw9jAagO8yqj/Fi9Uh7pQBcsewyMBO9FmxtzxQb2e2qNdomDNpdvCs
         ETcJfbPNToqtw9lOXrStl4KFLvjd/KEpNKA5PfyQbbYHJmp2ew+eYgNKTmGbc+K3bS
         BWVmZiUpNeniNGVShxOU/c1ThcW5KlHz0+YyhBj9dOXolK3Wz4Bn6asOCcBIQh/mhe
         kLQnK+3iIxwq8ELZ+Ur+OvY3bLiL3fdAmcWDq9VI4MDqV5WiRl7rS4eXTBDLJvhjPo
         n0Bs1tOcOx3Hw==
Date:   Wed, 26 Jan 2022 11:47:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Upinder Malhi <umalhi@cisco.com>,
        Roland Dreier <roland@purestorage.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/usnic: Fix memory leak in usnic_ib_sysfs_qpn_add
Message-ID: <YfEYo2jDo2Y8P1dL@unreal>
References: <20220126060425.11124-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220126060425.11124-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 26, 2022 at 06:04:25AM +0000, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()：
> 
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
> 
> Fix memory leak by calling kobject_put().

There is no real memory leak here, this kobject will be released in
usnic_ib_sysfs_qpn_remove(). Another possible solution is to delete
"if (err)" completely.

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..11723f54e200 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -271,17 +271,15 @@ void usnic_ib_sysfs_unregister_usdev(struct usnic_ib_dev *us_ibdev)
 void usnic_ib_sysfs_qpn_add(struct usnic_ib_qp_grp *qp_grp)
 {
        struct usnic_ib_dev *us_ibdev;
-       int err;
 
        us_ibdev = qp_grp->vf->pf;
 
-       err = kobject_init_and_add(&qp_grp->kobj, &usnic_ib_qpn_type,
+       kobject_init_and_add(&qp_grp->kobj, &usnic_ib_qpn_type,
                        kobject_get(us_ibdev->qpn_kobj),
                        "%d", qp_grp->grp_id);
-       if (err) {
-               kobject_put(us_ibdev->qpn_kobj);
-               return;
-       }
+       /* We don't care about failure here, the release will be performed in
+        * usnic_ib_sysfs_qpn_remove() anyway.
+        */
 }
 
 void usnic_ib_sysfs_qpn_remove(struct usnic_ib_qp_grp *qp_grp)


> 
> Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> index 7d868f033bbf..69c5854deebc 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
> @@ -280,6 +280,7 @@ void usnic_ib_sysfs_qpn_add(struct usnic_ib_qp_grp *qp_grp)
>  			kobject_get(us_ibdev->qpn_kobj),
>  			"%d", qp_grp->grp_id);
>  	if (err) {
> +		kobject_put(&qp_grp->kobj);
>  		kobject_put(us_ibdev->qpn_kobj);
>  		return;
>  	}
> -- 
> 2.17.1
> 
