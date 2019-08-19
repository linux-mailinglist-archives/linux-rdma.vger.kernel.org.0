Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552BE91FAB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 11:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfHSJIC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 05:08:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43515 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJIC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 05:08:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id y8so758311oih.10;
        Mon, 19 Aug 2019 02:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlNd5QIaasTzooIZdKPDO/egnQKum+L5EICvSM4gXDg=;
        b=pPUFE4nUsiEPnL3yFx+c+Pv7q+I5Xu/UuG4CkLEaesiiez1GJbzg9mmlpH968yS9Dy
         JRYVoRexuqmuXLMUnZPGXEIz4ZeUO19YxPkj/ayxaEg64jbQ0XUCs4NdIyg9sPh58bZ6
         0ZADUt6p0wWbKv1nbpByMCp/zdTAXWtlRLx3p/b/okhzHq5F+v6cfe3fIXy1lsoNE13O
         rHrc36R3/wGWh9JDB9rgMtab5ykQG8754TiX3WKH+OfoXFGlPPpPuaTjmaZyelusVDkF
         zk6sCjc2Xn6cwN0c8cNy6z6DDUi9SHkhjYNyrdBM5qdsDnFvSAcz//3BsBqZyiWnJTbG
         XQrw==
X-Gm-Message-State: APjAAAVMzZ0xKRag97NH1OvpX8V1RwZVNF5iH0XG2XmvFoRWjddnE8zq
        Sts/Pj/TYQJ5sC0w/HkXjGIgCjzUm0laeOW2MXkvnbjt
X-Google-Smtp-Source: APXvYqzWb95AtpQSIeBNfrhnrtrJhNjoaZx9V6GMU64y3Loy7mY29zoYhILdfjZb57Gv7aBFuDIVXb+hdDpJmtuDWas=
X-Received: by 2002:a54:478d:: with SMTP id o13mr12733701oic.54.1566205681155;
 Mon, 19 Aug 2019 02:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190819081157.9736-1-geert@linux-m68k.org>
In-Reply-To: <20190819081157.9736-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 11:07:49 +0200
Message-ID: <CAMuHMdV11Km7yF3gk5uTrPS1mVhjMdkbg28QRymcYyBPiAMBMw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.3-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 10:47 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.3-rc5[1] to v5.3-rc4[3], the summaries are:
>   - build errors: +7/-0

  + /kisskb/src/include/asm-generic/5level-fixup.h: error: unknown
type name 'pgd_t'; did you mean 'pid_t'?:  => 14:18
  + /kisskb/src/include/asm-generic/pgtable.h: error: implicit
declaration of function 'p4d_bad'; did you mean 'pgd_bad'?
[-Werror=implicit-function-declaration]:  => 580:15
  + /kisskb/src/include/asm-generic/pgtable.h: error: implicit
declaration of function 'p4d_bad'; did you mean 'pud_bad'?
[-Werror=implicit-function-declaration]:  => 580:15
  + /kisskb/src/include/asm-generic/pgtable.h: error: implicit
declaration of function 'p4d_none'; did you mean 'pgd_none'?
[-Werror=implicit-function-declaration]:  => 578:6
  + /kisskb/src/include/asm-generic/pgtable.h: error: implicit
declaration of function 'p4d_none'; did you mean 'pud_none'?
[-Werror=implicit-function-declaration]:  => 578:6

parisc-defconfig
parisc-allmodconfig
parisc-allnoconfig
a500_defconfig

  + error: "can_do_mlock" [drivers/infiniband/sw/siw/siw.ko] undefined!:  => N/A

sh-allmodconfig
sh-allyesconfig

Note that these are NOMMU!

  + error: rk3399_gru_sound.c: relocation truncated to fit:
R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x624)

nds32-allyesconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1/ (all 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d45331b00ddb179e291766617259261c112db872/ (all 242 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
