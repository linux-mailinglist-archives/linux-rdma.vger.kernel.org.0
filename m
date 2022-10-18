Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2551602CF0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJRN2f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJRN2a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 09:28:30 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38668CA8A1;
        Tue, 18 Oct 2022 06:28:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id DACAD92009D; Tue, 18 Oct 2022 15:28:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D66BA92009C;
        Tue, 18 Oct 2022 14:28:17 +0100 (BST)
Date:   Tue, 18 Oct 2022 14:28:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-kernel@vger.kernel.org,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-um@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1-rc1
In-Reply-To: <CAMuHMdVbo0wMaVVhe4f4tC9-TW2+DsOVAB77TtLdnsG=us8Q2A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2210181349060.50489@angie.orcam.me.uk>
References: <20221017145157.1866351-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2210171653540.9136@ramsan.of.borg> <alpine.DEB.2.21.2210181126040.50489@angie.orcam.me.uk> <CAMuHMdVbo0wMaVVhe4f4tC9-TW2+DsOVAB77TtLdnsG=us8Q2A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Geert,

> > > .> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9abf2313adc1ca1b6180c508c25f22f9395cc780/ (all 149 configs)
> 
> > > >  + {standard input}: Error: branch to a symbol in another ISA mode: 1339 =>
> > > > 2616, 2621
> > >
> > > mips-gcc11/micro32r2_defconfig
> > > mips-gcc11/micro32r2el_defconfig
> >
> >  Where can these configs be obtained from?
> 
> By following the links in the URL above you removed while replying? ;-)
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/14818296/
> http://kisskb.ellerman.id.au/kisskb/buildresult/14818298/

 Thank you.

 The error message is due to the use of MT ASE code in a microMIPS 
compilation, specifically a handwritten machine instruction encoding via 
`.word' in `dmt' from <asm/mipsmtregs.h>.  A similar construct is made 
from `mftc0', but it isn't at a branch target, so no error is triggered.

 A `.insn' pseudo-op ought to precede such handwritten constructs to tell 
the assembler that what follows is really an instruction rather than data, 
which would then cause any preceding label to be correctly annotated.

 Now the MT ASE has been specified for the microMIPS ISA, but the machine 
instruction encodings are different, so merely adding `.insn' won't do any 
good.  Also we've never added support for the microMIPS MT ASE, and it's 
not clear to me if it's ever been used with real silicon.  Perhaps QEMU 
has it, but I suspect not.  Also no support has ever been added to 
binutils.

 So I think we want to just exclude the offending code from microMIPS 
configurations, perhaps by hardcoding `cpu_has_mipsmt' to 0 if 
CPU_MICROMIPS.

 On the other hand support for the MT ASE with the regular MIPS ISA has 
been added with binutils 2.17:

commit 61cc02671150a81ea68f25b8409b8ace18bda9ae
Author: Chao-ying Fu <fu@mips.com>
Date:   Tue Sep 6 18:46:57 2005 +0000

and according to Documentation/process/changes.rst we require version 2.23 
now.  So it looks to me like we want to discard the handwritten hacks and 
use proper assembly instruction mnemonics.  I do believe we did this for 
the DSP ASE already.

  Maciej
