Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D71B2CAA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2020 18:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgDUQaN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgDUQaK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Apr 2020 12:30:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B4AC061A10
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 09:30:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h2so4242068wmb.4
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2020 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v8+pxq397WAymJF71eEzN5xHc3V+xeTUqDd6TCi+hVg=;
        b=rcaKNA30yleoup8CLN6olWyy7SI3pVB65Yl9zcGUKqqvVzOIVh0zw87aKM8sQj1tn/
         nT3x76F9+YCxGnIk9N7gWTQ/dNIoq3LrufS8Bh/hqgZaEd+OGyOE5Z1ALQwqRg3dVqDp
         fYez9joH5zhaOx+Eh1QyrUbnlFO5vbqY1IgZJIHoyqIb8pJiMWcTwy48a3gUsqnQR/4O
         yO/KnqkquK6497BHDX3TRWku2zyWu0/zyvspyBaU/siFhnC8t7PZxihjYFBH6WZEo/U3
         o5BJhyt2M5YuzAfAuAbIwcZKpnDo/FE4gUDcnHGYWzxwnoshypu2D9/jcBnyMpSkfbCF
         GKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v8+pxq397WAymJF71eEzN5xHc3V+xeTUqDd6TCi+hVg=;
        b=Eq09cLed9aTLFKHj2cVG+5kroZEni+kSazvKbX2WA3XRdxKeUdTh0JY/9Pr5Wyf2IB
         e+8/h+i8WsqkphLdLLXdJ6dJo24ujW1rUFPNRK2rjcyBnY1tmtIllvWEgAaiBXeZp2MU
         cj0L/Z2dgfP9d80qHYAawzebxFcUNazpHRlk8OC0J18de72dThVGxLGScazg/y2JZsFG
         32bggfsnNu2uNMGFH6ZUS1y2oEC/BZs+/FB/Fa8olByrfuAkxvPwsbnZZE/g/2ZxR+xx
         sdmc0sgjOHVISJAulp1f3I38BYqbM4uGRvjlJjBygUggYLSyJHoFdnrETSx6n29Xj2Hc
         wmbA==
X-Gm-Message-State: AGi0PuZQ8NozyxBwJcDiL4060tkG0l3QWAWoX0PbBh/Q+4WBYYX02NvS
        c8BN5BJHlyhPhJJ8vmlNueujpg==
X-Google-Smtp-Source: APiQypIYEku2izw6uQ1GaSP3LQ2YOJePtUOCbePUinogMI1uzMNy1qhF7u70QH92F9JQf18IEhWpSg==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr5379819wmh.141.1587486607188;
        Tue, 21 Apr 2020 09:30:07 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id j17sm4734411wrb.46.2020.04.21.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:30:06 -0700 (PDT)
Date:   Tue, 21 Apr 2020 18:30:04 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, jgg@mellanox.com, dledford@redhat.com,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        kuba@kernel.org, jiri@mellanox.com, dsahern@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V3 mlx5-next 06/15] bonding: Add helper function to get
 the xmit slave in rr mode
Message-ID: <20200421163004.GE6581@nanopsycho.orion>
References: <20200421102844.23640-1-maorg@mellanox.com>
 <20200421102844.23640-7-maorg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421102844.23640-7-maorg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Tue, Apr 21, 2020 at 12:28:35PM CEST, maorg@mellanox.com wrote:
>Add helper function to get the xmit slave when bond is in round
>robin mode. Change bond_xmit_slave_id to bond_get_slave_by_id, then
>the logic for find the next slave for transmit could be used
>both by the xmit flow and the .ndo to get the xmit slave.
>
>Signed-off-by: Maor Gottlieb <maorg@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
