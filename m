Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745696FFAFA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbjEKUCZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbjEKUCY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 16:02:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A20D1993;
        Thu, 11 May 2023 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683835343; x=1715371343;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4QWXIMyuHZYaqyYjU5d8Hz2Xi/48qqDvh3RaVHzyOAc=;
  b=LtZWI2qpudIRCgmegCDCZh2fZjz6DLQKfc/C0pZVCy4OVKg9gYdOMne8
   UEa8XjenMIVma+mMLx4KRrh2g3lQfjrZiB+1OphaBH9ZtH8t87av4jHKI
   a26q/0TIMd6kcYsptWHyLFM2N88wtQlAahKmtL9S98RSsUS5eSDbjsT30
   +o+VQ5I7TqN1DmAgMflGrrmq6seLdczKDZr3lhpO8cava8GPSmJJLqspD
   DbLW3jSI+QBwB1rbO13Qsf0dalB0RYORyH170gr4m2a68JzrmsZPiK2tT
   7MmfNf6nhJZnKqTD5pEBQF1sdYn1H5I/zO5ynsuyeb8+fiked3Pecxc0y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="330979945"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="330979945"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 13:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="844119899"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="844119899"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.252.39.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 13:02:19 -0700
Date:   Thu, 11 May 2023 23:02:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Dean Luick <dean.luick@cornelisnetworks.com>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/17] IB/hfi1: Use pcie_lnkctl{,2}_clear_and_set() for
 changing LNKCTL{,2}
In-Reply-To: <b2202998-b67b-ee45-b6de-1da5d30cefd0@cornelisnetworks.com>
Message-ID: <1b4ebce-1fcb-90e0-6396-967a5b6d563e@linux.intel.com>
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com> <20230511131441.45704-7-ilpo.jarvinen@linux.intel.com> <b2202998-b67b-ee45-b6de-1da5d30cefd0@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1333249942-1683835342=:1900"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1333249942-1683835342=:1900
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 May 2023, Dean Luick wrote:

> On 5/11/2023 8:14 AM, Ilpo Järvinen wrote:
> > Don't assume that only the driver would be accessing LNKCTL/LNKCTL2.
> > ASPM policy changes can trigger write to LNKCTL outside of driver's
> > control. And in the case of upstream (parent), the driver does not even
> > own the device it's changing the registers for.
> >
> > Use pcie_lnkctl_clear_and_set() and pcie_lnkctl2_clear_and_set() which
> > do proper locking to avoid losing concurrent updates to the register
> > value.
> >
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---

> > diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> > index 08732e1ac966..fe7324d38d64 100644
> > --- a/drivers/infiniband/hw/hfi1/pcie.c
> > +++ b/drivers/infiniband/hw/hfi1/pcie.c
> > @@ -1212,14 +1212,10 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
> >                   (u32)lnkctl2);
> >       /* only write to parent if target is not as high as ours */
> >       if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
> > -             lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> > -             lnkctl2 |= target_vector;
> > -             dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
> > -                         (u32)lnkctl2);
> > -             ret = pcie_capability_write_word(parent,
> > -                                              PCI_EXP_LNKCTL2, lnkctl2);
> > +             pcie_lnkctl2_clear_and_set(parent, PCI_EXP_LNKCTL2_TLS,
> > +                                        target_vector);
> 
> You are missing an assignment to "ret" above.

Thanks for noticing, I'll fix it in the next version.

-- 
 i.

--8323329-1333249942-1683835342=:1900--
