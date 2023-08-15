Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369B277CBC8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbjHOLcm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 07:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjHOLcV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 07:32:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B519B5;
        Tue, 15 Aug 2023 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692099140; x=1723635140;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=X/Zl8lNEOMUjBo2HEP/9UjIEWgeFJBCrEJY1o8E1UTU=;
  b=hpqBwTRQHV5rKex0sUE/vGHV0J8p0rIrPTrIcgDZmj7F2Hg9+fH++DVo
   4zups1ySdFMdm5r6Fg8Glt9uVUD6fp34RWxDjZY4cDklW6Z9kYuJJPQtq
   2cGbcvEP2c240TjRIzc3f9jCX/gPGDgG+6PP5yPJIGMHFQLDTve4bcYdn
   EBgsrXPLSCNRx7/wg27o3kxkKVs7q01nLLZIzPJGXhh6qNT+pBlQ5lQtC
   tgV0C6dtOPHeQp77a6zA4m0ShI23JodzhTRh9Bs2BCLSK8i9F00DIKolr
   yJu9SFAEcbU3fKqwGZZxI38uUVf64O5ShtMMbgduRKBi6XgJbtUvJfJvS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357223073"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="357223073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683624911"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="683624911"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:31:07 -0700
Date:   Tue, 15 Aug 2023 14:31:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic
 errnos
In-Reply-To: <20230814223232.GA195681@bhelgaas>
Message-ID: <91ccdd4-797-5d8b-d5c9-5fef5742575@linux.intel.com>
References: <20230814223232.GA195681@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1196577994-1692084854=:1736"
Content-ID: <84212c7-179e-c114-6b3a-246baa8988f2@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1196577994-1692084854=:1736
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ab37c490-8a70-1af8-bf3f-c082c34ed047@linux.intel.com>

On Mon, 14 Aug 2023, Bjorn Helgaas wrote:

> On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
> > mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
> > errnos.
> > 
> > Convert the PCI specific error values to generic errno using
> > pcibios_err_to_errno() before returning them.
> > 
> > Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
> > Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > ---
> > 
> > Maintainers beware, this will conflict with read+write -> set/clear_word
> > fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
> > take it instead of net people.
> 
> I provisionally rebased and applied it on pci/pcie-rmw.  Take a look
> and make sure I didn't botch it --

Looks okay.

> I also found a case in
> mlx5_check_dev_ids() that looks like it needs the same conversion.

Ah, that where the one of them went (my first version had that fixed 
inside link_toggle but then when rebasing I didn't realize it had moved 
into another function).
 
> The commit as applied is below.
> 
> If networking folks would prefer to take this, let me know and I can
> drop it.
> 
> > I wonder if these PCIBIOS_* error codes are useful at all? There's 1:1
> > mapping into errno values so no information loss if the functions would just
> > return errnos directly. Perhaps this is just legacy nobody has bothered to
> > remove? If nobody opposes, I could take a look at getting rid of them.
> 
> I don't think the PCIBIOS error codes are very useful outside of
> arch/x86.  They're returned by x86 PCIBIOS functions, and I think we
> still use those calls, but I don't think there's value in exposing the
> x86 error codes outside arch/x86.  Looks like a big job to clean it up
> though ;)

Hmm... Do you mean pci_bios_read/write() in arch/x86/pci/pcbios.c?
...Because those functions are already inconsistent even with themselves, 
returning either -EINVAL or the PCI BIOS error code (or what I assume that 
masking of result to yield).

And unfortunately, that's far from the only inconsistency within arch PCI
read/write func return values...


-- 
 i.
--8323329-1196577994-1692084854=:1736--
