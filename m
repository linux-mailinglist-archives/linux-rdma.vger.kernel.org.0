Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60C775AE0
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 13:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjHILM2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjHILM1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 07:12:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F6F1FD7;
        Wed,  9 Aug 2023 04:12:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe5eb84dceso23478625e9.1;
        Wed, 09 Aug 2023 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691579541; x=1692184341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2u9xybsbUOSRAB2M9cpPBdGgS/COFb/KNUNOjet7l4I=;
        b=j5vxLd3JusR2Fryuq/92gPcvkUHdMNsD1Yue0P8ajNw2dWEycci0mvf6KZiRYF8LZc
         P/+7ZyFD1CNSQgYr8imdxdyFJL7J7kdyOsOOie5uX3IW6TVGsOFudIjd8i7Ii9MlUBQi
         Eb0k5M3HvgL7B7lS4+SkIqWWT52+EBZOKP4LNm+VPfvlTvGr4GiOcQ1ELWYXiR9J0zsT
         E58I6OhYyNY7W7tJ73VDWoSU0TRuJP+S00SsGRocIFui2zlOF9jssFzGA1h0SF/KIAfv
         DsVtNoyP1ETYwqKyn6v51DqTjEG1SfeyjH4kBpmaDuvcseTqrp+zLk33YAN4NV7ZxFrG
         YG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691579541; x=1692184341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2u9xybsbUOSRAB2M9cpPBdGgS/COFb/KNUNOjet7l4I=;
        b=RXsTDpW1c9f2JC+BTAY31lX29y7Ol9BeAnJgGbNN/axVCLCA7ZG/GaVsaWxdWU6kCV
         6GwD16juGRKrOAPDFfYnqEwVsWSX79WpTtZAM+BW8g4UZDW1Bbydx9UpTr4uF8tKGlM7
         QumjMvvkRchxlc98cvnmwgYH4M0biQ6zr9dNExH8++Gemo4H0DK5ftGGdALuobgXsuTp
         6Am4GZwCuLPfdChjP6cBIE3acPJxiYyJgZDjh5nVi0jncT9M8x161BQtL+9g0GZFZ+YQ
         2YV+oBdwfmRsy5MT9gZK0b8AHnXQXm68ksFlSBuD/cHWakD7PgYseE0uhFxksn+f8EQr
         Qzlg==
X-Gm-Message-State: AOJu0Yx5ULR2mbhN9UDqoQWerNwyW6QGO52mimjOxrxYHckIhavSfp4z
        m+jUD2TY4mE/YhrbnAeytio=
X-Google-Smtp-Source: AGHT+IGbYVbwvxlmviv/YVXhuwz8atUZzkdpGmnlOLVcSWdw4XpCtgPNxAFeMbZ+MmQ4bsd0/SBuUw==
X-Received: by 2002:a05:600c:2811:b0:3f7:4961:52ad with SMTP id m17-20020a05600c281100b003f7496152admr1945488wmb.3.1691579541026;
        Wed, 09 Aug 2023 04:12:21 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id y9-20020a1c4b09000000b003fe215e4492sm1659169wma.4.2023.08.09.04.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 04:12:20 -0700 (PDT)
Message-ID: <a81b9b4a-d2c3-3136-9113-4568f2a87e97@gmail.com>
Date:   Wed, 9 Aug 2023 14:12:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 00/10] Convert mlx4 to use auxiliary bus
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, tariqt@nvidia.com,
        yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804150527.6117-1-petr.pavlu@suse.com>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230804150527.6117-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 04/08/2023 18:05, Petr Pavlu wrote:
> This series converts the mlx4 drivers to use auxiliary bus, similarly to
> how mlx5 was converted [1]. The first 6 patches are preparatory changes,
> the remaining 4 are the final conversion.
> 
> Initial motivation for this change was to address a problem related to
> loading mlx4_en/mlx4_ib by mlx4_core using request_module_nowait(). When
> doing such a load in initrd, the operation is asynchronous to any init
> control and can get unexpectedly affected/interrupted by an eventual
> root switch. Using an auxiliary bus leaves these module loads to udevd
> which better integrates with systemd processing. [2]
> 
> General benefit is to get rid of custom interface logic and instead use
> a common facility available for this task. An obvious risk is that some
> new bug is introduced by the conversion.
> 
> Leon Romanovsky was kind enough to check for me that the series passes
> their verification tests.
> 
> [1] https://lore.kernel.org/netdev/20201101201542.2027568-1-leon@kernel.org/
> [2] https://lore.kernel.org/netdev/0a361ac2-c6bd-2b18-4841-b1b991f0635e@suse.com/
> 
> Petr Pavlu (10):
>    mlx4: Get rid of the mlx4_interface.get_dev callback
>    mlx4: Rename member mlx4_en_dev.nb to netdev_nb
>    mlx4: Replace the mlx4_interface.event callback with a notifier
>    mlx4: Get rid of the mlx4_interface.activate callback
>    mlx4: Move the bond work to the core driver
>    mlx4: Avoid resetting MLX4_INTFF_BONDING per driver
>    mlx4: Register mlx4 devices to an auxiliary virtual bus
>    mlx4: Connect the ethernet part to the auxiliary bus
>    mlx4: Connect the infiniband part to the auxiliary bus
>    mlx4: Delete custom device management logic
> 
>   drivers/infiniband/hw/mlx4/main.c             | 207 ++++++----
>   drivers/infiniband/hw/mlx4/mlx4_ib.h          |   2 +
>   drivers/net/ethernet/mellanox/mlx4/Kconfig    |   1 +
>   drivers/net/ethernet/mellanox/mlx4/en_main.c  | 141 ++++---
>   .../net/ethernet/mellanox/mlx4/en_netdev.c    |  64 +---
>   drivers/net/ethernet/mellanox/mlx4/intf.c     | 361 ++++++++++++------
>   drivers/net/ethernet/mellanox/mlx4/main.c     | 110 ++++--
>   drivers/net/ethernet/mellanox/mlx4/mlx4.h     |  16 +-
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
>   include/linux/mlx4/device.h                   |  20 +
>   include/linux/mlx4/driver.h                   |  42 +-
>   11 files changed, 572 insertions(+), 396 deletions(-)
> 
> 
> base-commit: 86b7e033d684a9d4ca20ad8e6f8b9300cf99668f

For the series:
Acked-by: Tariq Toukan <tariqt@nvidia.com>

