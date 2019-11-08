Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5341F44E2
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 11:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfKHKpI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 05:45:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42473 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHKpI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 05:45:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so6445468wrf.9
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 02:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vqaw6doOfQTHZm9xSr3ZBQ9b3NLLo/sImivEHBUzvhI=;
        b=t/7/yJMqRKZFKVnuHPbcCnjkQGS/FwsJfGdKbXBP63aYLmmPnXX5ILFYxx1qKCnidb
         X1XDndfI78ekdXB/TuRyurylpwIBylPvulelVZMB4o1gOmzouIIr1TEYZSwdWCIcxVav
         wBPVrB32jIuRr82db1Eiwwbaxj05+y+YoZNInt9jhzW05L78DSMB0Pzjg32vk8Tyoa2h
         YwUH3qkFFIFgXP7lrGoT1AGhkIE4KHQE6Mwokaf4tpv+m9og4wZPIWiuMpwPGRgOrWrN
         +kHd0sgTW/XCGYyGR+L5C6FKUgPcqGPUKOT3IkKyFsfb4MJNGFg/2glZnZ/CXVSW2YNK
         LRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vqaw6doOfQTHZm9xSr3ZBQ9b3NLLo/sImivEHBUzvhI=;
        b=sVIc4fg/QaYcK1wkxtRwZ9zi48fg+bnEcUVjhKS2TE0AiSlPCWHunHIMxKBdR2b9Kd
         sYfgJ5AhFHXx0RVoxvMX+4Nfsm+fv4Hvvos5tXey14NxB1hNrLQlMIDJDT4n45RbY7wj
         23Hnkv/E6khMikQr2vZIJoAUKJHlohBoZGUgYtBa9TTdWwxxhSZQbPnXpkYA3ekESSLb
         /GYw6M/ZWs8RsgbgqeZreWlCsOXN+Daaosyr9DZdabjhjBB2zs7g0HT9doEu70Lmiyvg
         aFwjJphoPYN92ppInyAgm9BZdKu0sQYJqczhq/EYPSPdpYsvr2ktriaHkMNuRKwEUT1G
         3f2A==
X-Gm-Message-State: APjAAAWq+KAZg9TQxEd1q1hg/GGbckZaDxp1c95rMezqltyBs7TMWDlA
        Tt6Ge5DQs4gu4sRaA0KBqJwMjnOoURY=
X-Google-Smtp-Source: APXvYqzWaIAfkts/duy5+ZmqOguvJpjqirZgng0zXJv0i3tpRS4htQhA5lk3+nTkMD8u8K2Cf/Kn1A==
X-Received: by 2002:adf:8527:: with SMTP id 36mr7403692wrh.144.1573209906379;
        Fri, 08 Nov 2019 02:45:06 -0800 (PST)
Received: from localhost (ip-94-113-220-175.net.upcbroadband.cz. [94.113.220.175])
        by smtp.gmail.com with ESMTPSA id 65sm9585091wrs.9.2019.11.08.02.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 02:45:06 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:45:05 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Parav Pandit <parav@mellanox.com>
Cc:     alex.williamson@redhat.com, davem@davemloft.net,
        kvm@vger.kernel.org, netdev@vger.kernel.org, saeedm@mellanox.com,
        kwankhede@nvidia.com, leon@kernel.org, cohuck@redhat.com,
        jiri@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 19/19] mtty: Optionally support mtty alias
Message-ID: <20191108104505.GF6990@nanopsycho>
References: <20191107160448.20962-1-parav@mellanox.com>
 <20191107160834.21087-1-parav@mellanox.com>
 <20191107160834.21087-19-parav@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107160834.21087-19-parav@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thu, Nov 07, 2019 at 05:08:34PM CET, parav@mellanox.com wrote:
>Provide a module parameter to set alias length to optionally generate
>mdev alias.
>
>Example to request mdev alias.
>$ modprobe mtty alias_length=12
>
>Make use of mtty_alias() API when alias_length module parameter is set.
>
>Signed-off-by: Parav Pandit <parav@mellanox.com>

This patch looks kind of unrelated to the rest of the set.
I think that you can either:
1) send this patch as a separate follow-up to this patchset
2) use this patch as a user and push out the mdev alias patches out of
this patchset to a separate one (I fear that this was discussed and
declined before).
