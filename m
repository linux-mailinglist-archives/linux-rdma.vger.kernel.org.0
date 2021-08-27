Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2B3F990A
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbhH0Mci (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 08:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245117AbhH0Mch (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Aug 2021 08:32:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B274C061757
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 05:31:49 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bk29so6910027qkb.8
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+W+DD6N7vUecnu0EkPfPyepSPtuNuGQQnfv/zR6Rbic=;
        b=FOqnzK2OfCg1k/2z/u33KFi5tDSKYyUF86hxUL5CIvOZvlgyN0bQSJdNIQh3EehPNb
         zmyf/urK78vBP8oCITIqGOYChJqTzZhtyiKO/v5l7joC2sCluhSBpyzeUgXoFfAZ9zKl
         +6yUQNkgXY74Wh1MpVvc1qNSKm5v/HtN0Z+7kv97wqZCNyRIgdWc/+4pEwu866TzBxnd
         1oQBUbEqCFaRXjOYUE1n6X8ZDfz1gn1FsFR0OgwMeExAYcYPTYkhYNZ9pw2C0bszL/au
         XrnNQdmn7i+g6nEHScQIcmn5gvM7/BvyVxh8KxgDClho2ifk9mW3NN25o33PI1ASy01H
         NMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+W+DD6N7vUecnu0EkPfPyepSPtuNuGQQnfv/zR6Rbic=;
        b=Q+cSPbXWczpoXWJNyOZiXjTF3ZDvmV4pvwdfw5j9gTdEx2W5DXzV8qAUTPRUeowFxK
         Uy8LGCFRE+JsasEi31Jfy0HDdG5102LUJnyaluURLLs0/kQrwUFbxPQ1cKand/xFZg65
         kXYvmXNeMTH+OSt7Bbu2CmfUM3YNwDotLE+7UWLDLfVVvgmkXWoxKaXUlzpV7pzZfgJN
         OPonnN+XDdZrrlLrBXJb/7FJxPZojOmSo3PSYvMXaf2dzgNI3wnV/1jjcePPO66hYjYE
         GTHX4RaKniny2Vc+y/DCt1dtiVmV/djmDZEQWHoFe4DSCoxCloFhnu57F6nBdEhGuKi1
         G51w==
X-Gm-Message-State: AOAM533gaGDOO8JbEwK7TBwROIHYV50KYm5hLCnVl4GsH0DsC8FE03Aw
        8nRGHAmHtR6vRII0mKojZSrS+w==
X-Google-Smtp-Source: ABdhPJzuvYx5lUrjt/bMH95YjY2qknbl2PBLlFGNGKWsQckkd0MlzwhuK7uDk1wDvr6KFvh/+YcyvQ==
X-Received: by 2002:a05:620a:bce:: with SMTP id s14mr8814642qki.48.1630067508257;
        Fri, 27 Aug 2021 05:31:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b13sm1290731qtp.26.2021.08.27.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 05:31:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mJb1O-005foH-KT; Fri, 27 Aug 2021 09:31:46 -0300
Date:   Fri, 27 Aug 2021 09:31:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Disable atomic support on VFs
Message-ID: <20210827123146.GH1200268@ziepe.ca>
References: <1630037738-20276-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630037738-20276-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 26, 2021 at 09:15:38PM -0700, Selvin Xavier wrote:
> Following Host crash is observed when pci_enable_atomic_ops_to_root
> is called with VF PCI device.
> 
> PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
>  #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
>  #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
>  #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
>  #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
>  #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
>  #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
>  #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
>     [exception RIP: pcie_capability_read_dword+28]
>     RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
>     RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
>     RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
>     RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
>     R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
>     R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
>  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at ffffffffc08c1a33 [bnxt_re]
>  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
>     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
>     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
>     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
>     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
>     R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
>     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

This feels like a bug in pci_enable_atomic_ops_to_root()? I assume it
hit a case where bus->self == NULL?

Why not fix it there?

Jason
