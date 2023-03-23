Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DE6C6CBF
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 16:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjCWP56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 11:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCWP55 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 11:57:57 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CF241C1
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 08:57:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t19so13003942qta.12
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679587074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGyjbK25A5fLzkX+hIsW9kQZpkrTVOcdb2FDSKVkFPQ=;
        b=E0rgqX50pLyXP+81+1VFu1+NvLWajW6EaC3lQOvlQNz/J96UCIafgWL1SnIW6Z3a6b
         nX+J4CA4xizxiSkXAXeSTQRXfD6uANpHRDaDuMJN95SzmcBLSE3pZo0fGsFzTjFlrRDu
         5xaxx0qu0JhEPzo6krnUO7av0rJslRwPNXE+c9dOKobwZhqu4d7arwob0WlS2MiPrHzN
         LiQNBbizMO9hdSZLEJyCjyyfq/99Byf9WYTWxHP4Wgvjq4Dm73jKUR590EKwZZKl3u1S
         3oNI0bP5sc6q01/oh46moJXIW/BeQcwlyp0vJWZx4PTw7H+UDl51LHzn8FSZIxYFWmwU
         3UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGyjbK25A5fLzkX+hIsW9kQZpkrTVOcdb2FDSKVkFPQ=;
        b=gcfALu6slC2d9WDID1z7sgez284GFdx5WxAoG9nT9z8rZnHaDuqcRZ+Ke57qBLudBq
         RZ2dY7IelmE0zeFy3uAl3PadM3rCoSGO4HjaHydGBvYOcvVgi8Tw/HOcuwgRSSCcwtlv
         8qSaWaJ+7UH/gDBNRzLLK2S5YAKGNH+SSczjPhc0Fg5w7OskL+V+YQvc/suske3yIf4/
         l7adIdbRjM6iYnNSbtATwx1AxtmeMqYkhXR1QA3dZpVdbWVv5wacBgvXE70f1OhTHCAK
         QXabhkKUn1uDHe0HFWxulnbo2B4vrD1jr5Zn1XZKVKQ3YlEdm/qB+3bH2TyasqzCZh4A
         ZoyA==
X-Gm-Message-State: AO0yUKXGuTpGUh2dnQSSqd76AZ5MTYzKkQ9orzqpDValCAsfShEsB3EN
        V7GKK9Xkv7XMAXJPr6rJHBpM+g==
X-Google-Smtp-Source: AK7set+C0r03cEybZ+1MOP3W3s0zXKghh6HbhSu+aoQAuNc5b+ZpVQmRxxUfyLjMcNbp/TYds5SVyw==
X-Received: by 2002:a05:622a:18f:b0:3bf:e13e:438f with SMTP id s15-20020a05622a018f00b003bfe13e438fmr9905893qtw.36.1679587074059;
        Thu, 23 Mar 2023 08:57:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n69-20020a374048000000b00743a0096e8csm13480280qka.39.2023.03.23.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:57:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pfNK4-001UO9-Ei;
        Thu, 23 Mar 2023 12:57:52 -0300
Date:   Thu, 23 Mar 2023 12:57:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBx3AI5pothCuvTx@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
 <20230323120515.GE36557@unreal>
 <ZBxOHZwre3x8DkWN@ziepe.ca>
 <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b00740-3c75-8b90-4d68-76a5f341a117@grimberg.me>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 23, 2023 at 05:07:24PM +0200, Sagi Grimberg wrote:
> 
> > > > > > > No rdma device exposes its irq vectors affinity today. So the only
> > > > > > > mapping that we have left, is the default blk_mq_map_queues, which
> > > > > > > we fallback to anyways. Also fixup the only consumer of this helper
> > > > > > > (nvme-rdma).
> > > > > > 
> > > > > > This was the only caller of ib_get_vector_affinity() so please delete
> > > > > > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> > > > > 
> > > > > Yep, no problem.
> > > > > 
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
> > 
> > If we want to do proper managed affinity the right RDMA API is to
> > directly ask for the desired CPU binding when creating the CQ, and
> > optionally a way to change the CPU binding of the CQ at runtime.
> 
> I think the affinity management is referring to IRQD_AFFINITY_MANAGED
> which IIRC is the case when the device passes `struct irq_affinity` to
> pci_alloc_irq_vectors_affinity.
> 
> Not sure what that has to do with passing a cpu to create_cq.

I took Christoph's remarks to be that the system should auto configure
interrupts sensibly and not rely on userspace messing around in proc.

For instance, I would expect that the NVMe driver work the same way on
RDMA and PCI. For PCI it calls pci_alloc_irq_vectors_affinity(), RDMA
should call some ib_alloc_cq_affinity() and generate the affinity in
exactly the same way.

So, I have no problem to delete these things as the
get_vector_affinity API is not part of solving the affinity problem,
and it seems NVMe PCI doesn't need blk_mq_rdma_map_queues() either.

Jason
