Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4191C7C7729
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 21:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442222AbjJLTrQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442211AbjJLTrQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 15:47:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD72C0;
        Thu, 12 Oct 2023 12:47:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BF2C433C8;
        Thu, 12 Oct 2023 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697140034;
        bh=7n2CxZhl+eoS8X8gkxaqlmbFhLFf2ISZBlRCSOTo8i0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t98Na4Tqm6qoMJQAufLVj6nJ6iFLbGgx2eGh14SC1P6FLTqHA5bE5KPc0esQLMsP5
         hEVhvOuw51n1fIopmRchWfoYWkn+QswLVoT8Ben4KBJ7S0DKgKpTEZb7b3ee1fkDXG
         HagesHhRuMHkIL7C95Gg9EYg1hAHkRjqpfzrVbe6snwhh6Y06IQ3TLswu7+svqA39l
         iiAjwir8z5gk2n5VfliHc4OVXOuLnBKQwAtAJyyo3y6G2G9aDlD5LUM+UK78evnqhX
         PesFF3sm+22h+QRjvQNoPkacmpudmd4srs/8hyIdEqhLkM3poYDFXNN+Lk6socaVxT
         9qw/byiPHhc9w==
Date:   Thu, 12 Oct 2023 12:47:14 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: replace deprecated strncpy with strscpy
Message-ID: <ZShNQuRWSDiw2bF7@x130>
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11 Oct 21:04, Justin Stitt wrote:
>`strncpy` is deprecated for use on NUL-terminated destination strings
>[1] and as such we should prefer more robust and less ambiguous string
>interfaces.
>
>We expect `dst` to be NUL-terminated based on its use with format
>strings:
>|       mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
>
>Moreover, NUL-padding is not required.
>
>Considering the above, a suitable replacement is `strscpy` [2] due to
>the fact that it guarantees NUL-termination on the destination buffer
>without unnecessarily NUL-padding.
>
>Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>Link: https://github.com/KSPP/linux/issues/90
>Cc: linux-hardening@vger.kernel.org
>Signed-off-by: Justin Stitt <justinstitt@google.com>
>---
>Note: build-tested only.
>
>Found with: $ rg "strncpy\("
>---
> drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
>index fe48d20d6118..0005d9e2c2d6 100644
>--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
>+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
>@@ -1967,7 +1967,7 @@ int mlx4_INIT_HCA(struct mlx4_dev *dev, struct mlx4_init_hca_param *param)
> 	if (dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_DRIVER_VERSION_TO_FW) {
> 		u8 *dst = (u8 *)(inbox + INIT_HCA_DRIVER_VERSION_OFFSET / 4);
>
>-		strncpy(dst, DRV_NAME_FOR_FW, INIT_HCA_DRIVER_VERSION_SZ - 1);
>+		strscpy(dst, DRV_NAME_FOR_FW, INIT_HCA_DRIVER_VERSION_SZ);
> 		mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
> 	}
>
>
>---
>base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
>change-id: 20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-67809559dd1a
>
>Best regards,
>--
>Justin Stitt <justinstitt@google.com>
>

Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>

