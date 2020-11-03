Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA142A483B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 15:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgKCOcU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 09:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgKCObC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 09:31:02 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1FC0613D1
        for <linux-rdma@vger.kernel.org>; Tue,  3 Nov 2020 06:31:02 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id h62so16086542oth.9
        for <linux-rdma@vger.kernel.org>; Tue, 03 Nov 2020 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOdlWJ1oNG7pwLSlPTvrE+evGjXgbQRF919mtWqwhsE=;
        b=e/KrQtTkxaHwXubdmxhiuuxPfE9ZFq06ZpNJAsdxbh7htZr4OV8BIEJjiY/cM7hCke
         wvApRuy1YmMVEWS2jPe3ap85uN9OIDP8yltt9RPoXk2blDItpY2pVVBJgN+3e9HLm7Pu
         zGMEFPgyIpesx+e9O45NLkD9ssbNCi23YYsb69///uZ17/XXZt3IgYmaHclDd6kUzkf8
         y3kZYwEWigmbGvIP0VZedVG4RriWoHRlxUOAaoNWbouDLZhjdA3YBZH0gNVxgAuSTmNn
         QMzWiktOwR8xtc2AZufVUDEBCe6INRaNEjtlUb1+UT+EePUKcgDlhB7wQXdKNd9h9UcX
         PWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOdlWJ1oNG7pwLSlPTvrE+evGjXgbQRF919mtWqwhsE=;
        b=VTsok7sCRJCgnGHL5xTIN9InprmonRB0kQI/JECuwLzhZyUaswmSqHX/xYRDZi7NaF
         9L3jsoCgn1EA3h0GO8z6cz1CF6dtxDsS4jHcp5uRX2JDEshbrk/JlJ+uWZBszsHktirQ
         lddr7RHGofgtLdyHTRuaMVRi/dWqaFQB0l4Sw5i9ajtXnbYYnur/Cv+Bf5ibnEpHY3An
         hCu3nDbaaCN1CPtaqgtDi4F94/Y0nryVs0h+lW2lzzbUR3GM1ECI7xtBKJC2Fir6Yqg8
         iFaVzWFN2CsPx4B26P1h8kjF6HyZGN3j0km190OGF/rAY8di19XgGpni4X3Ys3sSWdmr
         d2Dw==
X-Gm-Message-State: AOAM533TlJvTKLfkE8419ypPssgH40JtfQK+4wQDT+iuB7+gAtbezwYe
        uL/pojcJtzgW5HlqipfrKl2sXtdWjkzByC8/KV0vgvSbdsA=
X-Google-Smtp-Source: ABdhPJxTnTxwMAFrcfAMtN0Nn761SmfCDdAK+HC4zfob6QP6sInF+feDtDi20ksEZ1TULQDgMViqGZJmtUvaFXwhEz0=
X-Received: by 2002:a05:6830:2018:: with SMTP id e24mr16294716otp.278.1604413862083;
 Tue, 03 Nov 2020 06:31:02 -0800 (PST)
MIME-Version: 1.0
References: <bug-210021-11804@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210021-11804@https.bugzilla.kernel.org/>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 3 Nov 2020 22:30:50 +0800
Message-ID: <CAD=hENcffzhy5ACO2TqH0t57uJQ3fG7B5e2few++niB9Xd9M-Q@mail.gmail.com>
Subject: Re: [Bug 210021] New: IB/rxe: build error due to unmet dependency for
 CRYPTO_CRC32 by RDMA_RXE
To:     bugzilla-daemon@bugzilla.kernel.org
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 3, 2020 at 7:33 PM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=210021
>
>             Bug ID: 210021
>            Summary: IB/rxe: build error due to unmet dependency for
>                     CRYPTO_CRC32 by RDMA_RXE
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.4.4
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Infiniband/RDMA
>           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
>           Reporter: fazilyildiran@gmail.com
>                 CC: dledford@redhat.com, fazilyildiran@gmail.com,
>                     leon@leon.nu, paul@pgazz.com
>         Regression: No
>
> Created attachment 293417
>   --> https://bugzilla.kernel.org/attachment.cgi?id=293417&action=edit
> reproduce.tar.gz
>
> Attachment (reproduce.tar.gz) content:
>  - sample.config: Config file to reproduce the bug.
>  - build_out.txt: Output of Kbuild including the error messages.
>
> When RDMA_RXE is enabled and CRYPTO is disabled, it results in the
> following Kbuild warning:
>
> WARNING: unmet direct dependencies detected for CRYPTO_CRC32

https://lkml.org/lkml/2020/9/15/360

Please check this mail thread.

The discussion is in the above link.

Zhu Yanjun

>   Depends on [n]: CRYPTO [=n]
>   Selected by [y]:
>   - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS
> [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && (!64BIT [=y] ||
> ARCH_DMA_ADDR_T_64BIT [=y])
>
> Building the kernel fails due to this unmet direct dependency issue as follows:
>
> [...]
>   LD      .tmp_vmlinux1
> crypto/crc32_generic.o: In function `crc32_mod_fini':
> crc32_generic.c:(.exit.text+0x8): undefined reference to
> `crypto_unregister_shash'
> crypto/crc32_generic.o: In function `crc32_mod_init':
> crc32_generic.c:(.init.text+0x8): undefined reference to
> `crypto_register_shash'
> drivers/infiniband/sw/rxe/rxe.o: In function `rxe_dealloc':
> rxe.c:(.text+0x102): undefined reference to `crypto_destroy_tfm'
> drivers/infiniband/sw/rxe/rxe_req.o: In function `rxe_crc32.isra.17':
> rxe_req.c:(.text+0x219): undefined reference to `crypto_shash_update'
> drivers/infiniband/sw/rxe/rxe_recv.o: In function `rxe_crc32.isra.7':
> rxe_recv.c:(.text+0xeb): undefined reference to `crypto_shash_update'
> drivers/infiniband/sw/rxe/rxe_verbs.o: In function `rxe_register_device':
> rxe_verbs.c:(.text+0x117d): undefined reference to `crypto_alloc_shash'
> drivers/infiniband/sw/rxe/rxe_mr.o: In function `rxe_crc32.isra.3':
> rxe_mr.c:(.text+0x13b): undefined reference to `crypto_shash_update'
> drivers/infiniband/sw/rxe/rxe_icrc.o: In function `rxe_crc32.isra.0':
> rxe_icrc.c:(.text+0x26): undefined reference to `crypto_shash_update'
> Makefile:1077: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> Steps to reproduce the bug for v5.4.4:
>   1. wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross
>   2. chmod +x ~/bin/make.cross
>   3. tar -xvf reproduce.tar.gz # sample.config and build_out.txt
>   4. cp sample.config path/to/linux-source-v5.4.4/.config
>   5. cd path/to/linux-source-v5.4.4/
>   6. ~/bin/make.cross ARCH=x86_64 clean
>   7. ~/bin/make.cross ARCH=x86_64 olddefconfig # unmet direct dependency
> warning
>   8. ~/bin/make.cross ARCH=x86_64 # should have a build error
>
> The output for the steps [6-8] can be found in build_out.txt.
>
> The build error happens as follows: RDMA_RXE selects CRYPTO_CRC32.
> CRYPTO_CRC32 selects CRYPTO_HASH, and CRYPTO_HASH selects CRYPTO_HASH2.
> When RDMA_RXE selects CRYPTO_CRC32 without accounting for its direct
> dependency (CRYPTO), CRYPTO_CRC32 gets enabled but it does not select
> CRYPTO_HASH thus CRYPTO_HASH2. Consequently, the required functions
> such crypto_unregister_shash are left undefined, causing the build error.
>
> Thanks,
> Necip
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
