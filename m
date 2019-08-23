Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3833B9B26F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbfHWOut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 10:50:49 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:43898 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733205AbfHWOus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Aug 2019 10:50:48 -0400
Received: by mail-qt1-f179.google.com with SMTP id b11so11404207qtp.10
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t+Adv64mOEta+0jmq2bSI+3hsAd8/gvNw1DQ8aXp5rM=;
        b=Eo68j0weDpcDuXeM2CEMZb0SgVfrHziA6b7kV4mbtHfbBhMjIF/zQaLPrOnt6mcRv9
         gt1Avas6giFsBeqw+OMtvgAn3+uezZuukVJOYQvWgWCw2sapWGSp1lsIPoo+HXWwA1Qm
         bQ1yW3Vmvdg9j8CF0jY7mmr3Bg7ENM0zWzHXqTchdeaJPdVfg6X7Vug5mPfDnAHm/+Aa
         BfyfUnBPSs7rvvQnD+iltakzA3Ev3HGaNDw0bQ+1XZCuhGth/aigUWEhoNqwjcqdy0jj
         N9ghSRRH81h0ORJHZsgU5i+EmJG+Fi4k+kJEIUWtfdnyy4gNpHisWDuAmTAcTpUusGrs
         +R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t+Adv64mOEta+0jmq2bSI+3hsAd8/gvNw1DQ8aXp5rM=;
        b=rDsHaYuMPmVYgjViCGwExZI0gWf2WfFBQrjcKK5aulf7x5CF1qApt03cWxQCeocG7i
         PZ9LkqskPn6/AptnFUHUZSRw3D3p2WQk8jd6dCG21suYMt9NRaC7QhGSG/mJkRq8wNtv
         ivPfj/8gG2V+hL66QPE1pSmMgqKz5AtHZhGXDGnUwK61n2pLosVpujyhehD5jM7fpe/D
         aSWh+khXKeZogx8dsBoEJC+tVbw2Q2Y3KjWr9Gx7zCqdlCZSKNbGWx0bcbW23yMwzlXx
         bmPADpRvMLN4CahshsjCmADaM1OrbXRuAG1fwSKSlHS6IkMexRtl28VY9CtrcqfPLs6Z
         /DVA==
X-Gm-Message-State: APjAAAVzL81Am8YOaLUentvk2SJrGEJEd51FxtnPf16IGCcE54MtB1Gi
        YeS4nxhz+3yRdmQtef8eoF9wCNhANRk=
X-Google-Smtp-Source: APXvYqy/Q+GVMYftrzAJyMCNte4VvZ6zueLTE1DODWjTFbgP9CS0zRw7d03lcLztFFjFaWDYkw9dVg==
X-Received: by 2002:a05:6214:32f:: with SMTP id j15mr4218422qvu.42.1566571847799;
        Fri, 23 Aug 2019 07:50:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r189sm1564386qkc.60.2019.08.23.07.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 07:50:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1Atq-0007sQ-Na; Fri, 23 Aug 2019 11:50:46 -0300
Date:   Fri, 23 Aug 2019 11:50:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Marcin Mielniczuk <marcin@golem.network>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Setting up siw devices
Message-ID: <20190823145046.GG12968@ziepe.ca>
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
 <20190822154323.GA19899@chelsio.com>
 <20190822155228.GH29433@mtr-leonro.mtl.com>
 <b4bf4bc2-8dc7-a2c2-6bd2-ab41d9fbadc9@golem.network>
 <945643c8-198e-f8bf-1e8f-536f77612db0@golem.network>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <945643c8-198e-f8bf-1e8f-536f77612db0@golem.network>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 23, 2019 at 04:17:50PM +0200, Marcin Mielniczuk wrote:
> While the device is detected by ibv_devices and rping works, I can't get
> ibv_rc_pingpong working
> (and as far as I understand, RC should be supported by the iWARP driver)
> 
> rping works:
> 
>     server$  rping -s -a 10.30.10.211 -v
>     server ping data: rdma-ping-0:
> ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
>     server ping data: rdma-ping-1:
> BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrs
>     server DISCONNECT EVENT...
>     wait for RDMA_READ_ADV state 10
> 
>     client$ rping -c -a 10.30.10.211 -C 2 -v
>     (output omitted)
> 
> 
> But ibv_rc_pingpong doesn't
> 
>     server$ ibv_rc_pingpong -d iwp____
>       local address:  LID 0x0000, QPN 0x000001, PSN 0xb8aafc, GID ::
>     Failed to modify QP to RTS
>     Couldn't connect to remote QP
>     client$ ibv_rc_pingpong  -d iwp____ 10.30.10.211
>       local address:  LID 0x0000, QPN 0x000001, PSN 0x71abc5, GID ::
>     client read/write: Protocol not supported
>     Couldn't read/write remote address

iwarp does not work with the pingpong examples as iwarp requires RDMA
CM and the examples don't use it.

Jason
