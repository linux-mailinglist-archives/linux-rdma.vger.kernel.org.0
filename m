Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412EA1B4562
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgDVMuS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 08:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726686AbgDVMuQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Apr 2020 08:50:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07CC03C1A9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 05:50:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so2253399wrx.4
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2020 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sYKwJ7+IoprBPdU6iUBgXZMoI3xaAISOSE08tbY6BWI=;
        b=xuKO93oVyfEFk12aVmBbHSbioP6bw5QVoGPmsMMRSKfvkvhSY0N3fMjgfnJwQadOqi
         ovsQp92qkU3saQ/T+uXRFfDs08EYeCYw4Zt8t39uNwiJKBbjOiSE3Sp520BLvbA49sAn
         oV6AICnvsYTpmThg+bCutTVw2MP7aD87dUZqN5d7arDTmaQtRlm3bhRpEB74nn2nU/ed
         1hSIF+Pmvns9oWcPJm10fKXhUOMeEdWZeq6g910HwTrE0B0eAwA/MnXtntwFVSjTiWoP
         3cBr3wHJy1fd+CR6A01NltfT5bmbmkwVS01IgOw/cPPOJKm92skkym+yMahLj7bP1nDv
         mOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sYKwJ7+IoprBPdU6iUBgXZMoI3xaAISOSE08tbY6BWI=;
        b=rvmJnWUrbZEf7p9mbHxienc28K2xZFziTg0q6p9U74Xz6eSJPcTju6bbpMvXRghebk
         fp1D5Ld3eEPtOF8RwSLh8+ykDT4k/qlDZq6BtRasBROYMQya6leLS6yS1h1xTNv1jZ5a
         VcZCkyiZBLRSdb1me+l+wOpKNBMUjtv5SlkbnxvAV2e48san2yln2tHXHVjF6vTL9APK
         SSgxuOP8IUk12s+Ns6NgT50DTYO101zxBbNX3w/GkFqnzWLOVLjjOZGHZzdYGnqmEF6l
         eZxlxsG3R2m275QtgVMikKkcd6ruJj0gnlKO0iZGBCmzCPEarY9LUq+fXsNjO+c/wDVC
         a45A==
X-Gm-Message-State: AGi0PuY0np4nOTZvnZz6iqnzYUCEDKAKkKOTLzfsc/2gyL16h1MnbkxS
        +irYXmmQFaPa+kMmEFlys1rg/A==
X-Google-Smtp-Source: APiQypIsQIVN9ZkfL9Bjg9ZIvKF/a0D36oFt4ABQ8hE82QXsIWaXfczCNACt3niNZ4KMhflFERfniw==
X-Received: by 2002:adf:e791:: with SMTP id n17mr31600594wrm.217.1587559814607;
        Wed, 22 Apr 2020 05:50:14 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id v19sm8356168wra.57.2020.04.22.05.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 05:50:14 -0700 (PDT)
Date:   Wed, 22 Apr 2020 14:50:13 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, jgg@mellanox.com, dledford@redhat.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        kuba@kernel.org, jiri@mellanox.com, dsahern@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V4 mlx5-next 01/15] net/core: Introduce
 netdev_get_xmit_slave
Message-ID: <20200422125013.GL6581@nanopsycho.orion>
References: <20200422083951.17424-1-maorg@mellanox.com>
 <20200422083951.17424-2-maorg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422083951.17424-2-maorg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wed, Apr 22, 2020 at 10:39:37AM CEST, maorg@mellanox.com wrote:
>Add new ndo to get the xmit slave of master device.
>Caller should call dev_put() when it no longer works with
>slave netdevice.
>User can ask to get the xmit slave assume all the slaves can
>transmit by set all_slaves arg to true.
>
>Signed-off-by: Maor Gottlieb <maorg@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
