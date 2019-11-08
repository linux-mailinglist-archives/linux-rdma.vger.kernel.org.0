Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49867F4579
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 12:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfKHLN0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 06:13:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfKHLNZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 06:13:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id a11so6584251wra.6
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+Eo0glUzjalQHt6xvHUxzQrB7u3vMyGwdCkPxcCzJY=;
        b=u7QLJGpnAhW16VTXD/Gmf8wGHRwCNuydIXbhIRkLruxGqEccaxt4cGg+fjCalmVcOH
         36Vd0JvzO7da+wUXNT3V7+HSK1Ak9QtB8AuiV3bPkf3ku/uVPT+oloU5+jUGD2S2+/P4
         d45RFmwEibq89tq5v02AUDRgfiUy6X0543v0SOq7NsDMKInckdUU+l0VJ7nBrLE8Z0vI
         sNOBy5SfOQ1d6nS9qVKJu5WyGhqxC0uNvi5MMfN1SfJAYUg3rdUO+dLzD/O2DhtpCIzB
         o6Xq6h3x0FdW3fKMLJxO4io6+EZL4HhQkBOOWSHmxWC9IjclTTL88meL/fwkc95abNHq
         QkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+Eo0glUzjalQHt6xvHUxzQrB7u3vMyGwdCkPxcCzJY=;
        b=B63k84iHBxDZVV1Bx3hA1ZrpwJuBUuw9YioEC1c+mkyGQWZMH5hiJNpIcLbtwLGnFw
         9C6JiP8BTALJvnJyYTsajxDE9++N4V0i08bw8wwfqn8KCMpETueclGy7Ih2cQb1rFsI7
         LdO01px3gYgBi5PGpTsm8SfSt7PDvhkcL3cdOqXLgDs9iBlMKYT+NYhpUAh9BiE72eFF
         v2SXAIuaP4DQOUgyTSNlr2D3FikLxrMzKpiC+tBmeySahRwN+54Fd5228CageINr6uss
         OWNdDQn3GBWyuK9EIam+usYeLU9BsMhBrq4uiKMEB5M9onHfTwDqm7S8EziWTRjZbQuT
         uLiw==
X-Gm-Message-State: APjAAAXp8KsNnSr1BCOSAmbf+EOdEPW32qkt6WvomP6ahumQJxGt+QJM
        gTrv7JNj6+72JBbm0Iiv1NfoYT6xFSA=
X-Google-Smtp-Source: APXvYqwnP2QDmQBcfmJLh3FRIv+V4z/O+BIfKcf6B34Ft5wA/wQ3rdOItRHB5FmTkCO/S9Z5vQlKng==
X-Received: by 2002:adf:e346:: with SMTP id n6mr7240613wrj.234.1573211601794;
        Fri, 08 Nov 2019 03:13:21 -0800 (PST)
Received: from localhost (ip-94-113-220-175.net.upcbroadband.cz. [94.113.220.175])
        by smtp.gmail.com with ESMTPSA id 11sm4575378wmi.8.2019.11.08.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 03:13:21 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:13:20 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Parav Pandit <parav@mellanox.com>
Cc:     alex.williamson@redhat.com, davem@davemloft.net,
        kvm@vger.kernel.org, netdev@vger.kernel.org, saeedm@mellanox.com,
        kwankhede@nvidia.com, leon@kernel.org, cohuck@redhat.com,
        jiri@mellanox.com, linux-rdma@vger.kernel.org,
        Vu Pham <vuhuong@mellanox.com>
Subject: Re: [PATCH net-next 15/19] net/mlx5: Add load/unload routines for SF
 driver binding
Message-ID: <20191108111320.GI6990@nanopsycho>
References: <20191107160448.20962-1-parav@mellanox.com>
 <20191107160834.21087-1-parav@mellanox.com>
 <20191107160834.21087-15-parav@mellanox.com>
 <20191108094854.GC6990@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108094854.GC6990@nanopsycho>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Nov 08, 2019 at 10:48:54AM CET, jiri@resnulli.us wrote:
>Thu, Nov 07, 2019 at 05:08:30PM CET, parav@mellanox.com wrote:
>>Add SF load/unload helper routines which will be used during
>>binding/unbinding a SF to mlx5_core driver as mediated device.
>>
>>Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
>>Signed-off-by: Vu Pham <vuhuong@mellanox.com>
>>Signed-off-by: Parav Pandit <parav@mellanox.com>
>>---
>> .../net/ethernet/mellanox/mlx5/core/main.c    | 11 ++-
>> .../ethernet/mellanox/mlx5/core/meddev/sf.c   | 67 +++++++++++++++++++
>
>Nit: Why not s/meddev/mdev/ ? I think that "mdev" is widely recognized term.

I take it back after grepping drivers/net/ethernet/mellanox/mlx5/core/
for mdev :)

>
>[...]
