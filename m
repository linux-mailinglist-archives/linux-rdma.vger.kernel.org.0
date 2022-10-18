Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F460297E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJRKj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRKj1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 06:39:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA35AC40;
        Tue, 18 Oct 2022 03:39:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2958692009C; Tue, 18 Oct 2022 12:39:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 231E192009B;
        Tue, 18 Oct 2022 11:39:20 +0100 (BST)
Date:   Tue, 18 Oct 2022 11:39:20 +0100 (BST)
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
In-Reply-To: <alpine.DEB.2.22.394.2210171653540.9136@ramsan.of.borg>
Message-ID: <alpine.DEB.2.21.2210181126040.50489@angie.orcam.me.uk>
References: <20221017145157.1866351-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2210171653540.9136@ramsan.of.borg>
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

On Mon, 17 Oct 2022, Geert Uytterhoeven wrote:

> >  + {standard input}: Error: branch to a symbol in another ISA mode: 1339 =>
> > 2616, 2621
> 
> mips-gcc11/micro32r2_defconfig
> mips-gcc11/micro32r2el_defconfig

 Where can these configs be obtained from?

  Maciej
