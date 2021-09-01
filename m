Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA13FD903
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 13:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhIALvP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhIALvP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 07:51:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38BEC061575
        for <linux-rdma@vger.kernel.org>; Wed,  1 Sep 2021 04:50:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t190so2609634qke.7
        for <linux-rdma@vger.kernel.org>; Wed, 01 Sep 2021 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ew8T5wzYhdtlWduTTppuPK80qK7RN5D5PmB1YwmpjSk=;
        b=AxdJEX5Q5W6bA/yyZYdSIN5Ku3ujmFmb8tOYiZaMgoIiTj0N3NWZXVm1RDnVwOoqmT
         OQkbu0b0SiRBh0JI9D1/hDvCHy/KOZ+Ftj4bKs/lYyzgjyLH13CPAdbka8XbCATwB8Nz
         xi0vZitQiCtnV7TzyQS7E/zjfabN4G/h42raZrD0PK+SYsLF5Vuv1wr0ujXtsesusltq
         a4NM6jDdAA6OKFAJUvx/eqE6IO+YUmq+immFRNVFMz26KZCyO2a8WgX3wdDwpquSZ49L
         Y3vt2lpoKWM7UtEJu7AjAylhWhOfpkASLffUpPluE1xh3f6i6s9wfITnB3PgF0If2Npj
         +wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ew8T5wzYhdtlWduTTppuPK80qK7RN5D5PmB1YwmpjSk=;
        b=Ygy7s/L6kSvqR1D378IkYU8C7rsZR3CR0bBxhfghAgFBw4uqB8gjrM5B3r7XNnxREm
         QuuUGM/ZE4zT5PfcaKpPFijix0eydQKaTd5quFO7lChvv4oVaZiIAef1HQ+riHaOA9sx
         LFeHsYWRwRZQuks1KKVB7y2CKMxA56usV0OcycZR1QZNOC068xQZIBkZUQj3r2u2JCrK
         EWrgvh4T7LJkmDQdPoFAGMbZBL7soRpH+X4Co+A2UGI+29M3FRbAXABJN1W+yhu1xCB5
         8KxCIebrj2Ej/8anCFInMeHwq0kh+DpjKhNyFhinfNKEXHhy15mxsz9mt3RcCq7o/KlE
         /O0A==
X-Gm-Message-State: AOAM530R0v9G9pq1xKxvSdgAAVJvrE1qxi4KTUjE+5xIaCt7o4kI/OTJ
        /JKxGL8MHrK0TArqGfJJ08kkeg==
X-Google-Smtp-Source: ABdhPJz7KGkD/ZowvQAah+A6VRzTv3p7LfNHTBx5hFAnBVsMQilqCXufzAw+16U6RK1cnDvJ6MCgyg==
X-Received: by 2002:a37:b385:: with SMTP id c127mr7613794qkf.206.1630497017588;
        Wed, 01 Sep 2021 04:50:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b13sm11974487qtb.13.2021.09.01.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:50:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mLOky-007lxu-Fn; Wed, 01 Sep 2021 08:50:16 -0300
Date:   Wed, 1 Sep 2021 08:50:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Disable atomic support on VFs
Message-ID: <20210901115016.GQ1200268@ziepe.ca>
References: <1630037738-20276-1-git-send-email-selvin.xavier@broadcom.com>
 <20210827123146.GH1200268@ziepe.ca>
 <CA+sbYW1GoGu_U1c_zKEbXyqgK-t+Mwe1aaFY1vsH1T0QCj6KAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW1GoGu_U1c_zKEbXyqgK-t+Mwe1aaFY1vsH1T0QCj6KAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 31, 2021 at 09:27:14PM +0530, Selvin Xavier wrote:
> On Fri, Aug 27, 2021 at 6:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Aug 26, 2021 at 09:15:38PM -0700, Selvin Xavier wrote:
> > > Following Host crash is observed when pci_enable_atomic_ops_to_root
> > > is called with VF PCI device.
> > >
> > > PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
> > >  #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
> > >  #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
> > >  #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
> > >  #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
> > >  #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
> > >  #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
> > >  #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
> > >     [exception RIP: pcie_capability_read_dword+28]
> > >     RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
> > >     RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
> > >     RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
> > >     RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
> > >     R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
> > >     R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
> > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > >  #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
> > >  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at ffffffffc08c1a33 [bnxt_re]
> > >  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
> > >     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
> > >     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
> > >     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
> > >     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
> > >     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
> > >     R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
> > >     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> >
> Apologies for the delay in my response.  I was exploring internally to
> see if it is a specific issue
> with the adapter/host. I see the problem in multiple systems.
> 
> > This feels like a bug in pci_enable_atomic_ops_to_root()? I assume it
> > hit a case where bus->self == NULL?
> yes. This crashes because of bus->self is NULL. Is it expected for VF?

I'm not sure, you should ask the PCI lists

> > Why not fix it there?
> Since its a functional breakage in 5.14, I posted a quick fix for
> 5.14. Also, we haven't done any testing on VF for this
> feature. So I wanted to avoid claiming support for VF anyway.
> 
> I see that other drivers also use pci_enable_atomic_ops_to_root
> without vf/pf check. Anyone seeing this issue?

Which is why I suspect the core code should be fixed not the driver..

Jason
