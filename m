Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5D6C6720
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 12:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCWLxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCWLxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 07:53:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05839468B
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 04:53:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 59so8004821qva.11
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679572392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tSPZIo48rZqWd3V52BpAdBhcOazULiwwpjjlcNTtnU=;
        b=J4+88AFLAQ06Wy0Yw7+8OcU+vswBobhIgNClgq2Ggfo10YKOY/48LXZGX84H/uMEQM
         HfjZ3xANTJKkYYu52GOjCCNX9KLSg1ETpYfESEfhfpIZDQt1hpNT9enqIpxV5N3EuijS
         3RF3QltVlKSqxuzgPYty2zHwzUGEFYzGl62AQ7rtNhdk1Mb6r2Ihb+UXIJt4AhHdEBWQ
         aLNbB5JXiuDzlQULxRAZHxdVD5TPuSFpIWaHkFFG+MYdDSUoPPdKdFenO5EsIttfeuoY
         L/peyi0qKuV7GQ4D17Hbxa8gvyxrbxVkJRvv2hNcDYKzXNrzonh/NBLdS4qRs4KGyKc4
         5Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679572392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tSPZIo48rZqWd3V52BpAdBhcOazULiwwpjjlcNTtnU=;
        b=QJQReFw3pkXvcdUfpt836lwrGDFzDZmHoIA0oLa8ypU1agcaxECaT+1ZYVimWhISyI
         aKffvjCktUZQvnurryxHDPKNCYRXkqdUty+wcrt5Wr2XIOp8QaaWh5XNbD737FsD9VVa
         Y3Dk4qsg74WI+k2vPhWbWyMp4A07gH9t+4GKPQYBTBNS6TZwvy3pluvzpAsf5N02mB/5
         wRxEqv5Fbobw8uuT0jvi6pcwwinvjrf4ASeV4Q5XIdXtt4KbQqQsa5uojEpDnj/tDPrJ
         7Fvvt2NDAz63zjEebgvtLBl/iuBJbZzs/YBDJq6HsbbV5r6rukuhPvBFZfopcFF2NUlG
         bacw==
X-Gm-Message-State: AO0yUKWBB/dzrhH30+hnqsYF7KOAg6pRskRJzrnqdH5djZ5q5Z9AZjB3
        xTKH1hjJaSNCPuiNp4+aRX95mA==
X-Google-Smtp-Source: AK7set983/XMvBqqaWiUO3T1LWUrnJ13/wxxMLZXV1x58TLnfrH/b8BulAtkaemZRhwKfJ5brN5H5w==
X-Received: by 2002:a05:6214:29ed:b0:5c8:b343:f749 with SMTP id jv13-20020a05621429ed00b005c8b343f749mr10890822qvb.22.1679572392116;
        Thu, 23 Mar 2023 04:53:12 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f66-20020a37d245000000b00745f3200f54sm12996292qkj.112.2023.03.23.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:53:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pfJVG-001Bcq-H2;
        Thu, 23 Mar 2023 08:53:10 -0300
Date:   Thu, 23 Mar 2023 08:53:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <ZBw9pmTtAlNVffuA@ziepe.ca>
References: <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal>
 <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
 <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
 <ZBsKHBN2NIFA6/YD@ziepe.ca>
 <8c446431-9f86-7267-6051-9c016e23215e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c446431-9f86-7267-6051-9c016e23215e@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 23, 2023 at 02:57:49PM +0800, Cheng Xu wrote:
> 
> 
> On 3/22/23 10:01 PM, Jason Gunthorpe wrote:
> > On Wed, Mar 22, 2023 at 09:30:41PM +0800, Cheng Xu wrote:
> >>
> >>
> >> On 3/22/23 7:54 PM, Jason Gunthorpe wrote:
> >>> On Wed, Mar 22, 2023 at 03:05:29PM +0800, Cheng Xu wrote:
> >>>
> >>>> The current generation of erdma devices do not have this capability due to
> >>>> implementation complexity. Without this HW capability, isolating the MMIO
> >>>> space in software doesn't prevent the attack, because the malicious APPs
> >>>> can map mmio itself, not through verbs interface.
> >>>
> >>> This doesn't meet the security model of Linux, verbs HW is expected to
> >>> protect one process from another process.
> >>
> >> OK, I see.
> >>
> >> So the key point is that HW should restrict each process to use its own doorbell
> >> space. If hardware can do this, share or do not share MMIO pages both will meet
> >> the security requirement. Do I get it right? 
> > 
> > HW can never do that, HW is supposed to rely on the system MMU to
> > isolate doorbell registers
> > 
> > The HW responsibility is to make doorbell MMIO registers safe in the
> > hands of other processes.
> > 
> > Simple doorbells that only 'kick' and don't convey any information are
> > probably safe to share, and don't require HW checks between the
> > doorbell page and the PD/QP/CQ/etc
> > 
> > Doorbells that deliver data - eg a head pointer - are not safe because
> > the wrong head pointer can corrupt the HW state. Process B must not be
> > able to corrupt the head pointer of a QP/CQ owned by Process A under
> > any circumstances. Definitely they cannot have access to the MMIO and
> > also the HW must ensure that writes coming from process B are rejected
> > if they touch resources owned by process a (eg by PD/QPN/CQN checks in
> > HW)
> > 
> > Doorbells that accept entire WQE's are definately not safe as a
> > hostile process could execute a WQE on a QP it does not own.
> > 
> 
> It's much clear, thanks for your explanation and patience.
> 
> Back to erdma context, we have rethought our implementation. For QPs,
> we have a field *wqe_index* in SQE/RQE, which indicates the validity
> of the current WQE. Incorrect doorbell value from other processes can
> not corrupt the QPC in hardware due to PI range and WQE content
> validation in HW.

No, validating the DB content is not acceptable security. The attacker
process can always generate valid content if it tries hard enough.

The only acceptable answer is to do like every other NIC did and link
the DB register to the HW object it is allowed to affect.

Jason
