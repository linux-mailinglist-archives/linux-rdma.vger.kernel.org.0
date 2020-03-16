Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A178E186AA6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 13:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgCPMMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 08:12:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35492 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbgCPMMf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Mar 2020 08:12:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id v15so13878948qto.2
        for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2020 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K04TFJYMitoXI2rakh7lbmc9r3L24l7FRmsR1Ftt4RQ=;
        b=COi9P422P2cyb8hEINvvxJgX5cZRBVtFz7xtslLdYWGO2U75W5gdTnhuhY35GQPl0q
         hq7SFIYt0rwMo2epm6CK+Lry9nnhFzuMilYg76OH2r3DIUuBfJ9+16lhznMljRUisApm
         LfX3nNNaIju7rqpMSl8XIvJ5pCQbka4RlYo7Y3CesnvWKjO+5W6OCOJmFIiUY08iwQ0b
         dj/6XJ4QBfqEE9TXMuOMJMX1jZYO0quOEw521GYGTH/HZug7H8BHQGl+PBgv/X1rosa6
         0eiczY3tLe/8vUGNhwFWh5Opm+OJTEImkI3fwYfk2irL38I2r7awqaaf+vmaCGat8MWJ
         5ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K04TFJYMitoXI2rakh7lbmc9r3L24l7FRmsR1Ftt4RQ=;
        b=E6vsWEarW0Wbu/HA9JqgnxRdsAmuds5Wvx4fwfTjN/FJBmj86h6D24h2Fb6liFd1oW
         6RWQqaEk/6PgzqeOx6CJWl1RtKC+/NzszrTTBnJAUZpUZSU0YNu/McVxlI0zACXhNLTP
         hvjN8bv5RfB8LyejV5d/cpmZBMQxEeaMwetXwdNYfVV7rJRRNN9V4wdMxHjSNM3fj89m
         ZjpTjfeLfk9vV+C1gKdeaurOfOL/wDgw88bsvmckKgjpnbv12HVRvcTMCiIfT1RqvKma
         71BLY4XkBPXyZt3uoGT2bTPvSXcfBVVTBDZ59Cn98eVOqtSFNBimfwbpI8g5sW8VBtgj
         PRfg==
X-Gm-Message-State: ANhLgQ016g59kV1lFILBVJPX0A0dKwK3jNEUMq2tiWpYn660XArWqojC
        Vtgzh6N2lo/ehH0fd5uHqD+GgA==
X-Google-Smtp-Source: ADFU+vvBPPElZUBUaSlS52CEMj3tA9cqGlR2IH5m5zM/PKj6wXMXBWZhgmZ7LZ00LsLy3PChZ0UQAQ==
X-Received: by 2002:ac8:5485:: with SMTP id h5mr24455116qtq.56.1584360753113;
        Mon, 16 Mar 2020 05:12:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d72sm15303627qkc.88.2020.03.16.05.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 05:12:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jDobf-0003IR-Uz; Mon, 16 Mar 2020 09:12:31 -0300
Date:   Mon, 16 Mar 2020 09:12:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     Andrew Boyer <aboyer@pensando.io>,
        Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add interface to support lock free
Message-ID: <20200316121231.GB20941@ziepe.ca>
References: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
 <20200312092640.GA31504@unreal>
 <20200312170237.GS31668@ziepe.ca>
 <42CC9743-9112-4954-807D-2A7A856BC78E@pensando.io>
 <20200312172701.GV31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A0227E188@DGGEML522-MBX.china.huawei.com>
 <20200313121835.GA31668@ziepe.ca>
 <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A02287DC3@DGGEML502-MBS.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 14, 2020 at 03:44:49AM +0000, liweihang wrote:
> On 2020/3/13 20:18, Jason Gunthorpe wrote:
> > On Fri, Mar 13, 2020 at 06:02:20AM +0000, liweihang wrote:
> >> On 2020/3/13 1:27, Jason Gunthorpe wrote:
> >>> On Thu, Mar 12, 2020 at 01:04:05PM -0400, Andrew Boyer wrote:
> >>>>    What would you say to a per-process env variable to disable locking in
> >>>>    a userspace provider?
> >>>
> >>> That is also a no. verbs now has 'thread domain' who's purpose is to
> >>> allow data plane locks to be skipped.
> >>>
> >>> Generally new env vars in verbs are going to face opposition from
> >>> me.
> >>>
> >>> Jason
> >>
> >> Thanks for your comments. Do you have some suggestions on how to
> >> achieve lockless flows in kernel? Are there any similar interfaces
> >> in kernel like the thread domain in userspace?
> > 
> > It has never come up before
> > 
> > Jason
> > 
> 
> Thank you, Jason. Could you please explain why it's not encouraged to
> use module parameters in kernel?

Behavior that effects the operation of a ULP should never be
configured globally. The ULP must self-select this behavior
pragmatically, only when it is safe.

Jason
