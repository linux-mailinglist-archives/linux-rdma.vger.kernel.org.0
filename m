Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3711846AF
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCMMSh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:18:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43812 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMMSh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 08:18:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id l13so7222381qtv.10
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jNom0lwzrGrP2XzVLY1qUwajfYzNit56A8xNMQtBhlA=;
        b=SF99icqEANgbTtzKdg0dbRqLbGqX4quHGiTf2uCcC55KKDKkj8z8nAnDLN38vTnGR8
         HaVv4Lj0knUs/DjZca4ML0loSITXZjf3E+b/RR5j6H4qqY3YJe0C2m/XKx4f53DFEugB
         qE/dYBUkyDuQ1EDeQcloK2wObyM22lkVCkSE47SEL7bmTp8rDg3U02A7BjkK/5eP2ubq
         5U5jPqEdjGoWW4LLjMHLUzjQuZiAZZRtWWg9UNm8YSDqlxXPReiX6whRFowUIvfI0wYs
         wB+W44Y0rpiwv3FC4z9aQMkUIvzv0I8sGl6BOz9Pge0eoDiDrqe0paxQW/lbDY7+9KrD
         CirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jNom0lwzrGrP2XzVLY1qUwajfYzNit56A8xNMQtBhlA=;
        b=Bbqut8rMgJH34ZiSfmnmOvHXe4JYq0HFPRoaMO35eqxZ1i7L7qaJ4LYZqDdxMNJQf/
         DlK0a6wC36s5MxaSdD6ehgZoK+noR0J1dT0jvgvb2dQydgSCBusFzwLpnAvz+Y5jCa+x
         FaMtp1yvQoqSsLFxRSNsElAWLFIdWFBgL+vZtsdq7T3aEhd6Kw1o5KoHW7tj0amJk/KL
         Z1sGDssJaGYTqOvyyCosaAcAB8bNwWXA49mIGkWPDybcH1554w3YPEpYG9qGAGsf8ilH
         y6W/kbq0kwdjAHesQvsjIbkbpGKuFBfiFIw3qJhB/mUuHiy81Aod0EjrER0A/3KWk2rI
         Syxg==
X-Gm-Message-State: ANhLgQ1bu6ySkazkaxjZmYV1HZxivf/UqG48aKjFRzBwbM1D6PhQwRoW
        fV4eGUqu5UyciF57zg2FjKzpaw==
X-Google-Smtp-Source: ADFU+vsuvPjVM+NmFx3qAOpaLRwLJu1xoR4dW+B4RmsLAsmNe3Ishrlfn7ScVsn9BMoHJSXynWH4pw==
X-Received: by 2002:ac8:4895:: with SMTP id i21mr4213799qtq.55.1584101916565;
        Fri, 13 Mar 2020 05:18:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x11sm15408485qkf.67.2020.03.13.05.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:18:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCjGt-0001rK-IP; Fri, 13 Mar 2020 09:18:35 -0300
Date:   Fri, 13 Mar 2020 09:18:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     Andrew Boyer <aboyer@pensando.io>,
        Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Message-ID: <20200313121835.GA31668@ziepe.ca>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal>
 <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 06:02:20AM +0000, liweihang wrote:
> On 2020/3/13 1:27, Jason Gunthorpe wrote:
> > On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
> >>    What would you say to a per-process env variable to disable locking in
> >>    a userspace provider?
> > 
> > That is also a no. verbs now has 'thread domain' who's purpose is to
> > allow data plane locks to be skipped.
> > 
> > Generally new env vars in verbs are going to face opposition from
> > me.
> > 
> > Jason
> 
> Thanks for your comments. Do you have some suggestions on how to
> achieve lockless flows in kernel? Are there any similar interfaces
> in kernel like the thread domain in userspace?

It has never come up before

Jason
