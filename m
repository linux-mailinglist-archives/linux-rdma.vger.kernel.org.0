Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBED6C4CB0
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 15:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCVOBF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCVOBD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 10:01:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6610FB
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 07:01:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r16so22639110qtx.9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679493661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3KY/HrbqIHI6covTINUDODKRsMsL670Uw5rx89vhdI=;
        b=Hz9rBX0NRaSCJ9/b6xjPfjW1+nDjMIxOPB8YXDi80pbnyprJBmvAA9TY8UHO/2yYii
         L7fMo5lXr6S7gXlQP+BfGUh1LoQX8vdLjxu8dKIN1rpySoCTxy88NpdKCe3Q6+2rATkd
         iHNCwxZD9b4aRZnN9UneF0fD5aclEVj5LifYuMxE9ttnQx5OOLEismmYKUd1T4EFeoEr
         Y42NSZx5GWSZU75qCGmCFcTQxKGb01VB6oMQPr/e+Jo33pwbB6UTsGvA4vO28A+mjBRb
         3D1xCqnqOhvBVA0paU1gM4scUW7Eow1d4sHmWKgx4th6I43aZdkbxo4wgRR557uK8e/h
         gU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3KY/HrbqIHI6covTINUDODKRsMsL670Uw5rx89vhdI=;
        b=JNKKVapiwfre60cLFMBYgpbnK46Kmh3W8riq/wYCRTAHQfFrX/3ayUa0TxZgGbEAc2
         B4z4QkA669vy9QAi03yvvl3QPYwdZ6b+WLDdeYz8vj1PgdkOIDJNpTiHqWEqdFZ0W7y6
         yXbU15Nv7EpBx5gqr3uvOGXVCCAHEVyA63AIqF8JDaT0t4BjRWuxfsYWhGS2n9bSdRs+
         wI8KPMFGZT6LKv8P7G10rMUL9jj2arO0owuTr8PN763+8uBwGE1T8atCRJtU2gTNtiH3
         IQpEuC2Hlu7m1cbaPZWVvO36t2S5dRCh4Uznq5QmATCQSRH25k5z91tZiAwa/NcPL2HB
         Bvfw==
X-Gm-Message-State: AO0yUKXmqgRY7iAecHmMsUuRegHz8RN/inh8ih5QxYwuPBKy9Fh1Skpm
        BjkIc9QZqfOnrylFaid7OQ4EDQ==
X-Google-Smtp-Source: AK7set9DkBHRU8d8O8Yb0sTISFchuVNH6fke6J+6hsCW8Oy0aKIDg2XvOiHrLTeqXl3Ymdm3GEWbIQ==
X-Received: by 2002:ac8:4e42:0:b0:3bf:e415:5cc3 with SMTP id e2-20020ac84e42000000b003bfe4155cc3mr7038630qtw.58.1679493661564;
        Wed, 22 Mar 2023 07:01:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id b13-20020ac8540d000000b003d2d815825fsm2958383qtq.40.2023.03.22.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:01:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pez1Q-000ng0-H0;
        Wed, 22 Mar 2023 11:01:00 -0300
Date:   Wed, 22 Mar 2023 11:01:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, Yossi Leybovich <sleybo@amazon.com>,
        Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <ZBsKHBN2NIFA6/YD@ziepe.ca>
References: <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
 <20230315102210.GT36557@unreal>
 <ZBm/deQgMYfdPt/u@ziepe.ca>
 <2c82439c-15d0-d5dd-b1c5-46053d3dd202@linux.alibaba.com>
 <ZBrsexPDqDIej/2/@ziepe.ca>
 <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c982b76-61b2-7317-ab76-8ff0b4fb4471@linux.alibaba.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 22, 2023 at 09:30:41PM +0800, Cheng Xu wrote:
> 
> 
> On 3/22/23 7:54 PM, Jason Gunthorpe wrote:
> > On Wed, Mar 22, 2023 at 03:05:29PM +0800, Cheng Xu wrote:
> > 
> >> The current generation of erdma devices do not have this capability due to
> >> implementation complexity. Without this HW capability, isolating the MMIO
> >> space in software doesn't prevent the attack, because the malicious APPs
> >> can map mmio itself, not through verbs interface.
> > 
> > This doesn't meet the security model of Linux, verbs HW is expected to
> > protect one process from another process.
> 
> OK, I see.
> 
> So the key point is that HW should restrict each process to use its own doorbell
> space. If hardware can do this, share or do not share MMIO pages both will meet
> the security requirement. Do I get it right? 

HW can never do that, HW is supposed to rely on the system MMU to
isolate doorbell registers

The HW responsibility is to make doorbell MMIO registers safe in the
hands of other processes.

Simple doorbells that only 'kick' and don't convey any information are
probably safe to share, and don't require HW checks between the
doorbell page and the PD/QP/CQ/etc

Doorbells that deliver data - eg a head pointer - are not safe because
the wrong head pointer can corrupt the HW state. Process B must not be
able to corrupt the head pointer of a QP/CQ owned by Process A under
any circumstances. Definitely they cannot have access to the MMIO and
also the HW must ensure that writes coming from process B are rejected
if they touch resources owned by process a (eg by PD/QPN/CQN checks in
HW)

Doorbells that accept entire WQE's are definately not safe as a
hostile process could execute a WQE on a QP it does not own.

> It seems that EFA uses shared MMIO pages with hardware security assurance.

I'm not sure how EFA works, it writes this:

        EFA_SET(&db, EFA_IO_REGS_CQ_DB_CONSUMER_INDEX, cq->cc);
        EFA_SET(&db, EFA_IO_REGS_CQ_DB_CMD_SN, cq->cmd_sn & 0x3);
        EFA_SET(&db, EFA_IO_REGS_CQ_DB_ARM, arm);

But interestingly there is no CQN value, so I have no idea how it
associates the doorbell register with the CQ to load the data into.

If it is using a DB register offset to learn the CQN then obviously it
cannot share the same doorbell page (or associated CQNs) across verbs
FD contexts, that would be a security bug. EFA folks?

Jason
