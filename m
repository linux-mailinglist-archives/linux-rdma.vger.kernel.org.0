Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3677D163
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjHORxf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbjHORxZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 13:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4493;
        Tue, 15 Aug 2023 10:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E80A625F9;
        Tue, 15 Aug 2023 17:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68793C433C8;
        Tue, 15 Aug 2023 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122003;
        bh=GOak072BFC7ziggrFR1E9dx0zzdh0OfsZQfwC1s5c9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n7VD8FzJIQvGoiOXutzUdDlv6E+U+upfkoDYtfe90NjhVLE/feuYSIKR107g7/L7w
         QYN9ItihXlExBQZBS4JVhXyuUJIk8eLARFON1c3CP5i+AOSXeQJbHGxG61yTHhy/R7
         iTghugWl7Gxdsl00KMiw7pKo1LrsYLD3UhLA1qCEBj/UGypYhEQGwC3WtnwKElWzRi
         dhDAGIN3//aW5QYslnkkmrCXTlWc5oexK3IVrwr9f0vqYlwTYjdjTTVtZp/VuAOry7
         KOUYLdT/vSstR9tx9lNWYqg3WjfrIxoc0LKEz/S1XD9MOmYQIFhc0+4DbhdjdQdcJE
         LDldZfzSTFgxg==
Date:   Tue, 15 Aug 2023 12:53:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <20230815175321.GA232277@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91ccdd4-797-5d8b-d5c9-5fef5742575@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 15, 2023 at 02:31:05PM +0300, Ilpo Järvinen wrote:
> On Mon, 14 Aug 2023, Bjorn Helgaas wrote:
> > On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
> > > mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
> > > errnos.
> > > ...

> > > I wonder if these PCIBIOS_* error codes are useful at all?
> > > There's 1:1 mapping into errno values so no information loss if
> > > the functions would just return errnos directly. Perhaps this is
> > > just legacy nobody has bothered to remove? If nobody opposes, I
> > > could take a look at getting rid of them.
> > 
> > I don't think the PCIBIOS error codes are very useful outside of
> > arch/x86.  They're returned by x86 PCIBIOS functions, and I think we
> > still use those calls, but I don't think there's value in exposing the
> > x86 error codes outside arch/x86.  Looks like a big job to clean it up
> > though ;)
> 
> Hmm... Do you mean pci_bios_read/write() in arch/x86/pci/pcbios.c?
> ...Because those functions are already inconsistent even with themselves, 
> returning either -EINVAL or the PCI BIOS error code (or what I assume that 
> masking of result to yield).

I didn't look up the code; I just think we still use those PCIBIOS
calls in some cases, so we need to know how to interpret the error
values returned by the BIOS.  IMHO it would be ideal if those PCIBIOS
errors got converted to Linux errnos before generic code saw them.

Bjorn
