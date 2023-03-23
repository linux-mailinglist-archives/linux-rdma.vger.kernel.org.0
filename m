Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C06C690D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 14:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCWNDg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 09:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjCWNDe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 09:03:34 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F411B324
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 06:03:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r5so26365349qtp.4
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679576607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JT5kxqVOLNs1cddye30QvhqujBIE6P8vkXfghBDUxrs=;
        b=fsnlSj1wYC+oyegO1q1yDBhN8AGGfS4B+/UJULqMDG1jdL9i5Fbq8O1r0UzJVbgZ5N
         CurbRDFSblDK9jc415qglfplweQjxGgBmqJhkAyt51A78hYTvBHd5fNCjBUuHTPn12EM
         Y1zKMRG6J4vTDaSNZyUJtcdDE+Bc4WCdEGj2SxETTQC9dX65jzYjndPxJagfadtzcHCH
         KucPqK8M85ho9lf87J55E+JMepmXIqa3pD+e1u9JzACYKTlMkED7tsKMjIDWBNd1fGTF
         U3Y7TJ6KcgnjkwfOD17f24lPxk4X4kA8SUtwmE3gF+qqh2vrzBTq+F7nq338bAMfL5EK
         qakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT5kxqVOLNs1cddye30QvhqujBIE6P8vkXfghBDUxrs=;
        b=e9aAQsDK0MBerl04HqXWxGfqTsWJc8/a+JDkHoxTy20GdVAxKQitxQS5kxtDNUTLBa
         ty2gHj6fZrpvsaeTNvlBqJnMrS2sDt5tgMn5VB/X3KaYJY4/CYta5MKDjwk8rVmoTO03
         7MFkwQXZUnSIgqR1nrFj7Pco5puPGSmyfkupYmxpxEcZXQ5r05dRL2kJbacSLjddlm4C
         gRg9dngFmfWO75awZv+rOTuR7QpDDGSK9GwEeJuWxywUOZit57ssasNlMXT4ZvxJd3NS
         PQqsPDiZ5s+1NxIjqQ0lnaGzl0bVy6LH7QYFPIuYFo+rqckMmCa5W6iBD5UhWW+t4hS0
         9rjw==
X-Gm-Message-State: AO0yUKUPAu3jXS+9b9+NkxDExXgn/WVqrcdJDoNgAUSfwt1/UX+hDgPU
        iHASso0HmDgGFs4I0SUF18alnQ==
X-Google-Smtp-Source: AK7set9Nd0IROYibAsNWzp2/wBVMkNxgJf3eiBJQdDWBUctTuOee3WY/j00WoSi5pcTukOCIoBjA4w==
X-Received: by 2002:ac8:7dd1:0:b0:3e2:7a9e:a04e with SMTP id c17-20020ac87dd1000000b003e27a9ea04emr9731248qte.18.1679576606971;
        Thu, 23 Mar 2023 06:03:26 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c9-20020ac80549000000b003d8d1ec2672sm11612362qth.89.2023.03.23.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:03:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pfKbF-001D0h-LK;
        Thu, 23 Mar 2023 10:03:25 -0300
Date:   Thu, 23 Mar 2023 10:03:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBxOHZwre3x8DkWN@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
 <20230323120515.GE36557@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323120515.GE36557@unreal>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 23, 2023 at 02:05:15PM +0200, Leon Romanovsky wrote:
> On Wed, Mar 22, 2023 at 10:50:22AM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 22, 2023 at 03:00:08PM +0200, Sagi Grimberg wrote:
> > > 
> > > > > No rdma device exposes its irq vectors affinity today. So the only
> > > > > mapping that we have left, is the default blk_mq_map_queues, which
> > > > > we fallback to anyways. Also fixup the only consumer of this helper
> > > > > (nvme-rdma).
> > > > 
> > > > This was the only caller of ib_get_vector_affinity() so please delete
> > > > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> > > 
> > > Yep, no problem.
> > > 
> > > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > > the nvme tree?
> > 
> > Sure, it is probably fine
> 
> I tried to do it two+ years ago:
> https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org

Christoph's points make sense, but I think we should still purge this
code.

If we want to do proper managed affinity the right RDMA API is to
directly ask for the desired CPU binding when creating the CQ, and
optionally a way to change the CPU binding of the CQ at runtime.

This obfuscated 'comp vector number' thing is nonsensical for a kAPI -
creating a CQ on a random CPU then trying to backwards figure out what
CPU it was created on is silly.

Jason
