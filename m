Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09C63594
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfGIMZ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 08:25:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35031 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfGIMZ0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 08:25:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so15561239qke.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2019 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJjNNCU9GdFA4B3H2oDhyurpBwEfhrCJe1aFyFTQ/8U=;
        b=SlC4VgiZYFEb1bkbL8OAiriQM6bjMa+tZnxEpwHMDJ2AsZYo1T8Phud1tTNIaQxyr1
         CJIqFXnC74DNem2GjtN3mEUpiryHQrdT4DNiRaNw5D7S7C7Yqb9XWpoTgLAy73EzHqiA
         Xzr/AUFDbf56bph1GtftkCyK2ddxZRB8BxwFrxDhpiziUAIb40fyDb11LBSHDzFP8f55
         u8sho3MO4tZKU4NkkfTmIjRE9l+kbr/CfBYbCWmwbnwSXuZ91+m4OkQ9xa1ux24FUijr
         CqOGjMp9TU2FBeUXQPFQDSov1qwd2mI+AtHXOGsJHJkFGG1HDy3rwetTltz2+YSX8tkZ
         zHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJjNNCU9GdFA4B3H2oDhyurpBwEfhrCJe1aFyFTQ/8U=;
        b=JcpfzxTRRUdoUCIhQzywH5n4NVTHyPI4sFmBa8g2fODRmAm9gN0aMONVv11NVXnl8n
         KY8ZhXTAh6sLPjHUADnecFAOpBoHi1XZUeLhEPeZfvsQL1X4jZc9WkIlUuVXCjbtOB29
         YSXIm522R3/T4LlS+YiO2yDLU3hzVKvZFmJtg3H6oNjbmpUbhIsvH7OHAfW+vtDDkt1Z
         wEueoInddPD9LVs2659xlL0Gfsxdp3C9T4fhAbtIs9ljEb2ztd5p7Zf+/Zza3VxZxWVM
         66q9eVSwoeqryjK+1H2pbIzdvzSR2FKGrAD6hQECNlMoBab0UnZKu4pN20tnP2jsuFrO
         griQ==
X-Gm-Message-State: APjAAAUGT05P1upaiDcdyr6i2Khllj0b1quK5HRVkUAL0CB0r8e6ibzm
        vRFJWdc/cDqNCBLHwknd824uEw==
X-Google-Smtp-Source: APXvYqyi/ACW3d5L0U2G16mwHHS7xrMTEtufzNOS/uwRAcsJnkVBVfCYCjfrnyJBXqQcK0iLrJ39Bw==
X-Received: by 2002:a37:c449:: with SMTP id h9mr17491414qkm.187.1562675125620;
        Tue, 09 Jul 2019 05:25:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w16sm8400412qki.36.2019.07.09.05.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 05:25:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkpBU-0001Fj-8T; Tue, 09 Jul 2019 09:25:24 -0300
Date:   Tue, 9 Jul 2019 09:25:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 2/2] IB: Support netlink commands in non
 init_net net namespaces
Message-ID: <20190709122524.GA3422@ziepe.ca>
References: <20190704130402.8431-1-leon@kernel.org>
 <20190704130402.8431-3-leon@kernel.org>
 <20190708202023.GA8020@ziepe.ca>
 <20190709063842.GE7034@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709063842.GE7034@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 09:38:42AM +0300, Leon Romanovsky wrote:
> On Mon, Jul 08, 2019 at 05:20:23PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 04, 2019 at 04:04:02PM +0300, Leon Romanovsky wrote:
> > > -int rdma_nl_unicast(struct sk_buff *skb, u32 pid)
> > > +int rdma_nl_unicast(struct net *net, struct sk_buff *skb, u32 pid)
> > >  {
> > > +	struct rdma_dev_net *rnet = net_generic(net, rdma_dev_net_id);
> >
> > This should be a proper type safe accessor in all places
> 
> "const struct net *net" and not "struct net *net"?

No, 

  static inline struct rdma_dev_net *rdma_get_net(struct net *net);

> >
> > > -void rdma_nl_exit(void)
> > > +void rdma_nl_net_exit(struct rdma_dev_net *rnet)
> > >  {
> > > -	int idx;
> > > -
> > > -	for (idx = 0; idx < RDMA_NL_NUM_CLIENTS; idx++)
> > > -		rdma_nl_unregister(idx);
> >
> > There should be a WARN_ON during the module unload that no NL clients
> > are still registered
> 
> IMHO, the usage of WARN_ON is overrated.

If there is to be any code at all I want to see WARN_ON's for things
that can't happen. Not pr_debug, not nonsense loops like the above.

Jason
