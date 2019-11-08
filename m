Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0ADF4F15
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 16:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKHPPk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 10:15:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54321 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKHPPj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 10:15:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so6539958wmi.4
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VADyXkmyEZwfz7UJm4aPW0AfoCAr6udjM9RfkA0/AnM=;
        b=NndXX4Geris7hE8V/Ztnx+9bbxzvSDFEhdn26kChY8owv7CATc2cz9mhRKtGY4nwSL
         Oyb43cBXpw93oZfh+ia9K8r3NlRuke95gm4KhOQMSuA3WUiKNaIUunHFUzmG7dCLmzUY
         ccYtg9tPwXvJew37XZ9GriStnVOfCN9yoA+KaQFXB5xT2sVc3xn6tsAaK8WvV0lnxCwJ
         4fo+I6EwSiImHP4gyJjvq0ZTmEfJG3HlksfGCE3u5tmPctQXeGCPWWi4JItZQ8rbu3MP
         nP0m2i2YjP42HW6R3f3xJvJFYaxu4OuZjEU3ueIPhd6B5ZpDl0JZe434fpEfDpFF7VxU
         ypOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VADyXkmyEZwfz7UJm4aPW0AfoCAr6udjM9RfkA0/AnM=;
        b=bJ+gw3k6ik4YlgRGr9SOb+UctaLrBT2Hu3fPAQTmZKJEUbyemYifytLvZjB5LtkQwK
         JBqIHOm3Hw7XS7QEH0N0wcS3H1Ma3fyk0OYNZ/lO33cVmjgGw5ZqyG+csTV4COundTW+
         XI/ZGZ6Kc60voXPnCQlL1nBdqCjSaQmc8e08g/ploMsypQ5br5jCaUKo952bti8mo6Rk
         sHREI9fOGOs2AOlcLIyVvNf4K9Hx1wIWUYrzVwbxcN9VvVP/jojm/AeK5w8gmM1ndoNa
         4j/ePSAn/HaiST/RtgPu5LDvuD30u1270TpdTW/USuarsqtYI5iZpmDsRpnPk+HFcz47
         T3CA==
X-Gm-Message-State: APjAAAVTrSJqH8YlrFv93tl2nNc7cMwmSPRXVYgrBYmgMQ2Tp5jJbqpB
        bRfwdJJObc+e91eacCIz364thg==
X-Google-Smtp-Source: APXvYqzINYRoUuFX5NaF77jpHF+D0eryv4W23kT3xH8z73wcQ98F4Yz0rU59bhdkqSPWnxEUfSRslQ==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr8682539wma.75.1573226136346;
        Fri, 08 Nov 2019 07:15:36 -0800 (PST)
Received: from localhost (ip-94-113-220-175.net.upcbroadband.cz. [94.113.220.175])
        by smtp.gmail.com with ESMTPSA id d202sm5462271wmd.47.2019.11.08.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:15:36 -0800 (PST)
Date:   Fri, 8 Nov 2019 16:15:35 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 19/19] mtty: Optionally support mtty alias
Message-ID: <20191108151535.GL6990@nanopsycho>
References: <20191107160448.20962-1-parav@mellanox.com>
 <20191107160834.21087-1-parav@mellanox.com>
 <20191107160834.21087-19-parav@mellanox.com>
 <20191108104505.GF6990@nanopsycho>
 <AM0PR05MB486674869FD72D1FCE3C7B53D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB486674869FD72D1FCE3C7B53D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Nov 08, 2019 at 04:08:22PM CET, parav@mellanox.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Friday, November 8, 2019 4:45 AM
>> To: Parav Pandit <parav@mellanox.com>
>> Cc: alex.williamson@redhat.com; davem@davemloft.net;
>> kvm@vger.kernel.org; netdev@vger.kernel.org; Saeed Mahameed
>> <saeedm@mellanox.com>; kwankhede@nvidia.com; leon@kernel.org;
>> cohuck@redhat.com; Jiri Pirko <jiri@mellanox.com>; linux-
>> rdma@vger.kernel.org
>> Subject: Re: [PATCH net-next 19/19] mtty: Optionally support mtty alias
>> 
>> Thu, Nov 07, 2019 at 05:08:34PM CET, parav@mellanox.com wrote:
>> >Provide a module parameter to set alias length to optionally generate
>> >mdev alias.
>> >
>> >Example to request mdev alias.
>> >$ modprobe mtty alias_length=12
>> >
>> >Make use of mtty_alias() API when alias_length module parameter is set.
>> >
>> >Signed-off-by: Parav Pandit <parav@mellanox.com>
>> 
>> This patch looks kind of unrelated to the rest of the set.
>> I think that you can either:
>> 1) send this patch as a separate follow-up to this patchset
>> 2) use this patch as a user and push out the mdev alias patches out of this
>> patchset to a separate one (I fear that this was discussed and declined
>> before).
>Yes, we already discussed to run mdev 5-6 patches as pre-patch before this series when reviewed on kvm mailing list.
>Alex was suggesting to package with this series as mlx5_core being the first user.
>Series will have conflict (not this patch) if Jason Wang's series [9] is merged first.
>So please let me know how shall we do it.

Just remove this patch from the set and push it later on individually
(if ever).

>
>[9] https://patchwork.ozlabs.org/patch/1190425
>
>
