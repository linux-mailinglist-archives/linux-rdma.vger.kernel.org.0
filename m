Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F16526EF3
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiENFJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 May 2022 01:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiENFJi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 14 May 2022 01:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57950DEBA;
        Fri, 13 May 2022 22:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BF360A24;
        Sat, 14 May 2022 05:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F3CC34116;
        Sat, 14 May 2022 05:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652504975;
        bh=RvNHeiqwtSeyUphn9A3Kul7Zvpq+Ly64hYUFjpyel4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HS1QigauKuCUtyWE3I05D8MCfWOQrc410MVvZV7gwHB9p/Wq+uahZoS1e/R9sRJeK
         8+FthfMCtuU7cO5N3w2R2rtRdAvLvqvXl2Hvm0PW3DwEe5ovirXi/GyBQLitEJ7tir
         Yxsdtej3q2c7N16OM35xqnd5UsQR/70wMUUJnrXOHAKbfCoyhLclYj1RGvcX2IEyRV
         r8mWqVDPLd7JZycoAZlQ/z7D3h44D12sFitZoKKbmgzJCNQk1N4WFV1pTiQkwInL8T
         yhsd4CZHD8HNdHLsX5GumVi+BxouxTUNrYB2JK4Qfv6clBEekFxqiMdtY7VLSYTQ7q
         hMrdTeVXBcbMQ==
Date:   Sat, 14 May 2022 08:09:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>
Cc:     "matanb@mellanox.com" <matanb@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "sean.hefty@intel.com" <sean.hefty@intel.com>,
        "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx5: Add sysfs entry for vhca to
 /sys/class/infiniband/mlx5
Message-ID: <Yn85iFNS96yO2ISD@unreal>
References: <1652137257-5614-1-git-send-email-rohit.sajan.kumar@oracle.com>
 <BYAPR10MB2997DF974EF3631A2E69CA3CDCCA9@BYAPR10MB2997.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR10MB2997DF974EF3631A2E69CA3CDCCA9@BYAPR10MB2997.namprd10.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 13, 2022 at 05:46:16PM +0000, Rohit Sajan Kumar wrote:
> Hey,
> 
> Sending this as a gentle reminder to review the patch sent earlier this week which can be found in this email chain.

Patches that sent in HTML format, to wrong addresses and not visible
in patchworks/ML, without target net-next/rdma-next/e.t.c., with wrong
title are generally ignored.

Why vhca_id that returned from MLX5_IB_METHOD_QUERY_PORT is not enough?

Anyway, sysfs file in IB driver for the property of mlx5_core is no-go.

Thanks

> 
> Thank you.
> 
> Best,
> Rohit.
> ________________________________
> From: Rohit Nair <rohit.sajan.kumar@oracle.com>
> Sent: Monday, May 9, 2022 4:00 PM
> To: matanb@mellanox.com <matanb@mellanox.com>; leonro@mellanox.com <leonro@mellanox.com>; dledford@redhat.com <dledford@redhat.com>; sean.hefty@intel.com <sean.hefty@intel.com>; hal.rosenstock@gmail.com <hal.rosenstock@gmail.com>; Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>; Manjunath Patil <manjunath.b.patil@oracle.com>; Rama Nichanamatlu <rama.nichanamatlu@oracle.com>
> Cc: linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: [PATCH] net/mlx5: Add sysfs entry for vhca to /sys/class/infiniband/mlx5
> 
> While collecting diagnostic information (Ex:wqdump) in virtual
> environment, we need vhca id to collect data belonging a particular VF.
> This patch adds a sysfs entry to show the vhca id inside guest.
> 
> Signed-off-by: Rohit Nair <rohit.sajan.kumar@oracle.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 32a0ea8..dd935bc 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2499,12 +2499,24 @@ static ssize_t board_id_show(struct device *device,
>  }
>  static DEVICE_ATTR_RO(board_id);
> 
> +static ssize_t vhca_id_show(struct device *device,
> +                           struct device_attribute *attr, char *buf)
> +{
> +       struct mlx5_ib_dev *dev =
> +               container_of(device, struct mlx5_ib_dev, ib_dev.dev);
> +       return sysfs_emit(buf, "%d [0x%x]\n",
> +                      MLX5_CAP_GEN(dev->mdev, vhca_id),
> +                      MLX5_CAP_GEN(dev->mdev, vhca_id));
> +}
> +static DEVICE_ATTR_RO(vhca_id);
> +
>  static struct attribute *mlx5_class_attributes[] = {
>          &dev_attr_hw_rev.attr,
>          &dev_attr_hca_type.attr,
>          &dev_attr_board_id.attr,
>          &dev_attr_fw_pages.attr,
>          &dev_attr_reg_pages.attr,
> +       &dev_attr_vhca_id.attr,
>          NULL,
>  };
> 
> --
> 1.8.3.1
> 
