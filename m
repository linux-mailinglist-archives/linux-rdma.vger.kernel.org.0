Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10B56C9932
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Mar 2023 02:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjC0A4y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Mar 2023 20:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjC0A4x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Mar 2023 20:56:53 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C52F421B
        for <linux-rdma@vger.kernel.org>; Sun, 26 Mar 2023 17:56:52 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id m6so5856313qvq.0
        for <linux-rdma@vger.kernel.org>; Sun, 26 Mar 2023 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679878611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6c8EcA67/S2qUg1ylvkcnzxRXO2auUwwxHe6t0lyUpg=;
        b=WD5XGuT7uCVYEGy0C0xMQ1Nj4WoTvL/v60cTXOMlXSWO0TwsQE1Yg7umnx02zeCDFv
         5PcbBwdIkHvQLUS2W9CJTgMyViV7B8KYYw+NA3qDjFZ0w2Ot90/SicpLBSEVqRrNUMao
         /VVCy/Ztmki/R+RwKmF4LgY5AKWYStRW4kpGrbNUYzQKfeH5pobXVJQvfgi1a+9feIc8
         H4Z5IDl4YjgMWo+mv1u8nPBh1p7pycbT0HJMkIEMRlrZcc/G8crau+2R+Dfe+1PNNKzI
         P8DJeyAOAWWR5y7B64Ko59XHVlhgpz8Wif1amlumiGeBanlXQa8gGdlZOmxBN6YhivIW
         G0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679878611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c8EcA67/S2qUg1ylvkcnzxRXO2auUwwxHe6t0lyUpg=;
        b=J4+tgHJ58SJnnzsykqows74yaIJlABcQBRSUm5fL7e79NhWeiCvMADW42tyJUJjrDu
         ok6iUQcKEkwn5xYF0Zsv1+K0W7WEFmEaAM7U0R/Co9z+FGGmZV7h2YBXm2truSblYEEW
         zrdFUTRMapzLrhbpG1ACbPLJAJN/KTXLC3/BY6SHxJlnKof9bk+M2c7cN54z9JgxSji+
         P7xkzoA4Np4K2G6JpKWfKvxAC7kMJvIJ1+iLTqU84KU7k5RP/0J9qFgZWzTvFHCozxPu
         E4VQRoQv5IFSOFJ0VSH8zsImhtb+NH8xPcKJztN8EJNQgdCqaWbRErpusYYEheh554nD
         wMCg==
X-Gm-Message-State: AAQBX9fWZDFHF2pRtsLWCVrev6FfBefQX5Cdh/SUaxh7c9qY0X9UrqbX
        1w8KXv7EBfIiq9BKraU3LJ6XbA==
X-Google-Smtp-Source: AKy350ZSW4GGJpu0nyB0zgkdE01qZ8JhGdtbBHh7FPN5tpU8Bd6OgR2/BVwePnUtzIa5LwLwByAKjw==
X-Received: by 2002:ad4:5745:0:b0:56e:a2cb:5732 with SMTP id q5-20020ad45745000000b0056ea2cb5732mr18916591qvx.9.1679878611309;
        Sun, 26 Mar 2023 17:56:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id mk16-20020a056214581000b005dd8b9345a9sm2519159qvb.65.2023.03.26.17.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 17:56:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pgbAG-002qvz-W1;
        Sun, 26 Mar 2023 21:56:48 -0300
Date:   Sun, 26 Mar 2023 21:56:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZCDp0KY9ISj9haV8@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
 <20230323120515.GE36557@unreal>
 <ZBxOHZwre3x8DkWN@ziepe.ca>
 <20230326231622.GA19436@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326231622.GA19436@lst.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 27, 2023 at 01:16:22AM +0200, Christoph Hellwig wrote:
> On Thu, Mar 23, 2023 at 10:03:25AM -0300, Jason Gunthorpe wrote:
> > > > > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > > > > the nvme tree?
> > > > 
> > > > Sure, it is probably fine
> > > 
> > > I tried to do it two+ years ago:
> > > https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
> > 
> > Christoph's points make sense, but I think we should still purge this
> > code.
> 
> Given that we don't keep dead code around in the kernel as policy
> we should probably remove it.  That being said, I'm really sad about
> this, as I think what the RDMA code does here right now is pretty
> broken.

I don't know nvme well, but any affinity scheme that relies on using
/proc/interrupts to set the affinity of queues is incompatible with
RDMA HW and more broadly incompatible with mlx5 HW.

The fundamental issue is that this class of HW can have more queues
than the CPUs can have interrupts. To make this work it has to mux
each MSI interrupt to N queues.

So, I think the only way it can really make sense is if the MSI
interrupt is per-cpu and the muxing is adjusted according to affinity
and hotplug needs.

Thus, we'd need to see a scheme where something like nvme-cli directs
the affinity on the queue so it can flow down that way, as there is no
other obvious API that can manipulate a queue multiplexed on a MSI.

IIRC netdev sort of has this in that you can set the number of queues
and the queues layout according to CPU number by default. So
requesting N-4 queues will reserve the last 4 CPUs for isolation sort
of thinking.

> > If we want to do proper managed affinity the right RDMA API is to
> > directly ask for the desired CPU binding when creating the CQ, and
> > optionally a way to change the CPU binding of the CQ at runtime.
> 
> Chanigng the bindings causes a lot of nasty interactions with CPU
> hotplug.  The managed affinity and the way blk-mq interacts with it
> is designed around the hotunplug notifier quiescing the queues,
> and I'm not sure we can get everything right without a strict
> binding to a set of CPUs.

Yeah, I think the netdev version is that the queues can't change until
the netdev is brought down and the queues destroyed. So from that view
what you want is a tunable to provide a CPU mask that you'd like the
logical device to occupy provided at creation/startup time.

I can imagine people isolating containers to certain CPU cores and
then having netdevs and nvmef devices that were created only for that
container wanting them to follow the same CPU assignment.

So affinity at creation time does get a good wack of the use cases..

Jason
