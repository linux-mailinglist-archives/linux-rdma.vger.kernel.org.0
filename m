Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45D3717C22
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjEaJjB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjEaJix (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 05:38:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DDE10B
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685525887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGxc4eRfK6pbwqqh2NtDpBVJvcM3fuyjggZTA4cPMnI=;
        b=WG0mMi/DxzWJI2byMwwr7rqtQdX+WnE9CjnuqDVSlpo2Vhpz18rUps7c+b79cbyjqT+cuu
        6bvYa6ZwprX21RGP3o2h9FKSSIBWddwuGLCHKg5PIP66Dq1VWUUA/s+iDzh73rXY+JGPHP
        iCziwD+RRQvXgUXpn1jCZ9c7C9d45bc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-EI8kBKwOOTqlXzaZIXkZsA-1; Wed, 31 May 2023 05:38:05 -0400
X-MC-Unique: EI8kBKwOOTqlXzaZIXkZsA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f517b5309cso874269e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 02:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685525884; x=1688117884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGxc4eRfK6pbwqqh2NtDpBVJvcM3fuyjggZTA4cPMnI=;
        b=NViONQZMOhaYcu6nsTO0QME8eIokwH1KGBWr/KhHACIYouRGxjm8f6d9TZYoIl7tY6
         sH7zlL7dXYeqgKcnfgMIW1fjrOR+AMUdc28vwuf14aLxT2SeMhOI4XLrSB4+7/kVQSIr
         UPm3RF4Y5/dARwkZ5R3K3P3Na1gd/fYdn1Hsa2WeTnd/RevxIk8XCYrUYMPPUmlEhYL4
         kzMl073iV02tndyTxO8OsF/fwroz5N1g6bsYA2sK11/MB1K8nxp+1rF+synaxqCsvhH7
         jXKl7F188tsJaRhDG42VE2Z9LMKxGKBzdYze15bwrQQrElRElDyr50WFlqDrZswCAU7q
         zF0g==
X-Gm-Message-State: AC+VfDwtb8XRbjaDkksLiK1vLF4+Qq/3Kbnj29wYcSFDwrySpvUQEB+P
        eWRHzb6iesSTDYeEyVpG4dwVnQ7A5sal5R0kAcXH7HN6PjEgK5cY7PCO8wBd104Y6smR9j+5jZ5
        vAqhwVI3GpLrtua/kuPKxtw==
X-Received: by 2002:ac2:43dc:0:b0:4f1:3bd7:e53a with SMTP id u28-20020ac243dc000000b004f13bd7e53amr2255700lfl.49.1685525884431;
        Wed, 31 May 2023 02:38:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZhKAnRMcKLkCdLj+6eqisJiHpOFurOIspfewhQhx3pSYMQ1GSECzcGpZqw6YxX6XDmQp2hQ==
X-Received: by 2002:ac2:43dc:0:b0:4f1:3bd7:e53a with SMTP id u28-20020ac243dc000000b004f13bd7e53amr2255690lfl.49.1685525884068;
        Wed, 31 May 2023 02:38:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0? ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d54cd000000b003063db8f45bsm6157419wrv.23.2023.05.31.02.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:38:03 -0700 (PDT)
Message-ID: <cdd8953e-2187-32f7-bb3c-aaf54581775d@redhat.com>
Date:   Wed, 31 May 2023 11:38:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net v2] net/mlx5: Fix setting of irq->map.index for static
 IRQ case
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Shay Drory <shayd@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Eli Cohen <elic@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        linux-rdma@vger.kernel.org
References: <20230531084856.2091666-1-schnelle@linux.ibm.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230531084856.2091666-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/31/23 10:48, Niklas Schnelle wrote:
> When dynamic IRQ allocation is not supported all IRQs are allocated up
> front in mlx5_irq_table_create() instead of dynamically as part of
> mlx5_irq_alloc(). In the latter dynamic case irq->map.index is set
> via the mapping returned by pci_msix_alloc_irq_at(). In the static case
> and prior to commit 1da438c0ae02 ("net/mlx5: Fix indexing of mlx5_irq")
> irq->map.index was set in mlx5_irq_alloc() twice once initially to 0 and
> then to the requested index before storing in the xarray. After this
> commit it is only set to 0 which breaks all other IRQ mappings.
> 
> Fix this by setting irq->map.index to the requested index together with
> irq->map.virq and improve the related comment to make it clearer which
> cases it deals with.
> 
> Tested-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Fixes: 1da438c0ae02 ("net/mlx5: Fix indexing of mlx5_irq")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

I was seeing the issue on a zLPAR with a mlx5 VF device. The patch fixes it.

Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
> v1 -> v2:
> - Added R-bs/Acks
> - Fixed typos in commit message
> 
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index db5687d9fec9..fd5b43e8f3bb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -232,12 +232,13 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
>   	if (!irq)
>   		return ERR_PTR(-ENOMEM);
>   	if (!i || !pci_msix_can_alloc_dyn(dev->pdev)) {
> -		/* The vector at index 0 was already allocated.
> -		 * Just get the irq number. If dynamic irq is not supported
> -		 * vectors have also been allocated.
> +		/* The vector at index 0 is always statically allocated. If
> +		 * dynamic irq is not supported all vectors are statically
> +		 * allocated. In both cases just get the irq number and set
> +		 * the index.
>   		 */
>   		irq->map.virq = pci_irq_vector(dev->pdev, i);
> -		irq->map.index = 0;
> +		irq->map.index = i;
>   	} else {
>   		irq->map = pci_msix_alloc_irq_at(dev->pdev, MSI_ANY_INDEX, af_desc);
>   		if (!irq->map.virq) {

