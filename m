Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D219A1B1396
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDTRyZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726492AbgDTRyY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Apr 2020 13:54:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EF2C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 10:54:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so532632wmc.2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2020 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1n2LDsKs2ZcCDnsffeY3+kx5gfdzTP7+l7Fl31ryGA=;
        b=P9nYT7kfEgtbNd184oMBgsQqh5u0bO05OS0SKN5dcH39uRgwHkV/sWww5BxY9eFu2Y
         Oj98C9PGJm8wIwItMqbc3ztu78RRapkRvEIn3zOH10L3X/uC2yls733oYGYGxqz1cGYP
         /Aiok3Au7IuyG24FXydggmCg874A2f9HZ3DEP2j5KWgEXgFqPrT6cOSIh+412VMjUf4i
         cbNIgyklkKxSprHG+AA2B+IF0CFky84M/n4lD+lW47dEUtJTLa+n43Pu6G3/We30ow8k
         x63qmRLfB8C8Y2Dqwf/gr61S+a0Xqz5b0XIGmgj3mPzR6+iDenIUupqbHXsc5ih+MPmE
         MSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1n2LDsKs2ZcCDnsffeY3+kx5gfdzTP7+l7Fl31ryGA=;
        b=DHCDoOzaMeH84x3Gn674E4PJFc3qleMj2QN2HvSOb1yD93+hIrcdIFj8MGxALSRegz
         AsgGi1eepG1K+R8IjS2s2kb6yxvHfDzlFnMIJm1VV8B/QTYepv9WSeCXiTxMIFuIUmpO
         ljGi9WRpLowJfBHUzuomjelhVCwNuN6RhL6c8rYrOEgvl85M1atIy7uGKW8e40v6S8su
         gWO6JapUwxQa1IBNBBuPXXgj1bGDm3EubRQPi2/XvpTWFoBXPTtOjopvuW+HSYd6nWi8
         E7y2KIsO3DKOjpyt7RXaWhloOjGCIA/F7qeqBxMqr2vnV2USMV75yftrGLVfMqc71/6Y
         VGwA==
X-Gm-Message-State: AGi0PubmsYAvkcDvwV2iFTPb2nnUETniMQAmV/A/XRA+ozIA5MpuFOHR
        iGvKlyzxb6wG6LX4hnJcG5gCzQ==
X-Google-Smtp-Source: APiQypJHq3mGdKXHjNgPVeEAE9WhACJtkYcVWIVY6yHZUqEQoblDL9SFXNQY0GjOV9iSs/anHV7HVQ==
X-Received: by 2002:a1c:4989:: with SMTP id w131mr517985wma.137.1587405263276;
        Mon, 20 Apr 2020 10:54:23 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id w12sm291943wrk.56.2020.04.20.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:54:22 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:54:21 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Ahern <dsahern@gmail.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, davem@davemloft.net,
        jgg@mellanox.com, dledford@redhat.com, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, kuba@kernel.org,
        leonro@mellanox.com, saeedm@mellanox.com, jiri@mellanox.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        alexr@mellanox.com
Subject: Re: [PATCH V2 mlx5-next 01/10] net/core: Introduce
 master_xmit_slave_get
Message-ID: <20200420175421.GU6581@nanopsycho.orion>
References: <20200420075426.31462-1-maorg@mellanox.com>
 <20200420075426.31462-2-maorg@mellanox.com>
 <20200420140118.GJ6581@nanopsycho.orion>
 <a9e00f31-2f4e-1dfc-2464-d3d25376a4b8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e00f31-2f4e-1dfc-2464-d3d25376a4b8@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mon, Apr 20, 2020 at 07:29:15PM CEST, dsahern@gmail.com wrote:
>On 4/20/20 8:01 AM, Jiri Pirko wrote:
>> Mon, Apr 20, 2020 at 09:54:17AM CEST, maorg@mellanox.com wrote:
>>> Add new ndo to get the xmit slave of master device.
>>> User should release the slave when it's not longer needed.
>>> When slave selection method is based on hash, then the user can ask to
>>> get the xmit slave assume all the slaves can transmit by setting the
>>> LAG_FLAGS_HASH_ALL_SLAVES bit in the flags argument.
>>>
>>> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
>>> ---
>>> include/linux/netdevice.h |  3 +++
>>> include/net/lag.h         | 32 ++++++++++++++++++++++++++++++++
>>> 2 files changed, 35 insertions(+)
>>>
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index 130a668049ab..e8852f3ad0b6 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -1389,6 +1389,9 @@ struct net_device_ops {
>>> 						 struct netlink_ext_ack *extack);
>>> 	int			(*ndo_del_slave)(struct net_device *dev,
>>> 						 struct net_device *slave_dev);
>>> +	struct net_device*	(*ndo_xmit_get_slave)(struct net_device *master_dev,
>>> +						      struct sk_buff *skb,
>>> +						      u16 flags);
>> 
>> Please adjust the name to:
>> ndo_get_lag_xmit_slave
>
>I disagree. There are multiple master devices and no reason to have a
>LAG specific get_slave.

Btw, did you notice that Maor is passing "lag" named values in the flags?
