Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65417A205E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 16:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjIOOCp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Sep 2023 10:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjIOOCp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Sep 2023 10:02:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD91FC9;
        Fri, 15 Sep 2023 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694786560; x=1726322560;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vK3PhL5kYdO2VTxiXNSaozjqYR5+kz/gZjFSYDl+0Ec=;
  b=R+zlJ4Yxf+2TJmAU41EDdzherKUJvhgjB8mBtnxr7/ct7n1lJ5+lTHMV
   2dGNQeRjwzhgpH2lPdxyPvm9I4+rF7ySBjwHvOUifk1m/ay9UmCTrpV82
   BRVJDX8h/IRGE5wF+A1dBmL79l/5UtvuJO/uxqzhcRZ7eYaXfQW9cQlp4
   JEyyLQNGRVUOgnXaIWUvXZmm75Fg75NU3DDLXOgECV6Zl1Ug4OCd+18bD
   U0Q/QpJ+EEQWJtNrRJi5co/hgWRe/Vedk8V9M1PHBYWwUnLD96TVRusR0
   bYxhEkjIoDaFRSvoqcuvG1jVSWu67UaPp3U8Z/t4QVivTgVoGNIYXHO7k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="379170403"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="379170403"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="868715600"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="868715600"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:02:34 -0700
Date:   Fri, 15 Sep 2023 17:02:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Dean Luick <dean.luick@cornelisnetworks.com>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 04/10] drm/IB/hfi1: Use RMW accessors for changing
 LNKCTL2
In-Reply-To: <c0e07dbf-e19e-43b7-9c95-8025a12323b8@cornelisnetworks.com>
Message-ID: <5ec088ff-c6fa-57af-117-c78376b9db31@linux.intel.com>
References: <20230915120142.32987-1-ilpo.jarvinen@linux.intel.com> <20230915120142.32987-5-ilpo.jarvinen@linux.intel.com> <c0e07dbf-e19e-43b7-9c95-8025a12323b8@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1332323370-1694786558=:2347"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1332323370-1694786558=:2347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Dean Luick wrote:
> On 9/15/2023 7:01 AM, Ilpo Järvinen wrote:
> > Don't assume that only the driver would be accessing LNKCTL2. In the
> > case of upstream (parent), the driver does not even own the device it's
> > changing the registers for.
> >
> > Use RMW capability accessors which do proper locking to avoid losing
> > concurrent updates to the register value. This change is also useful as
> > a cleanup.
> >
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I believe the subject should begin with "RDMA/hfi1:", the current expectation for all devices in drivers/infiniband.

Thanks, I'll update it. I hadn't realized given the shortlogs of the other 
commits (no idea where I managed to get that "drm" from, but it's also 
gone now).

> > ---
> >  drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++++----------------------
> >  1 file changed, 8 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> > index 08732e1ac966..60a177f52eb5 100644
> > --- a/drivers/infiniband/hw/hfi1/pcie.c
> > +++ b/drivers/infiniband/hw/hfi1/pcie.c
> > @@ -1212,14 +1212,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
> >                   (u32)lnkctl2);
> >       /* only write to parent if target is not as high as ours */
> >       if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
> > -             lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> > -             lnkctl2 |= target_vector;
> > -             dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
> > -                         (u32)lnkctl2);
> > -             ret = pcie_capability_write_word(parent,
> > -                                              PCI_EXP_LNKCTL2, lnkctl2);
> > +             ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
> > +                                                      PCI_EXP_LNKCTL2_TLS,
> > +                                                      target_vector);
> >               if (ret) {
> > -                     dd_dev_err(dd, "Unable to write to PCI config\n");
> > +                     dd_dev_err(dd, "Unable to change PCI target speed\n");
> 
> To differentiate from the dev_err below, add "parent", i.e. "Unable to change parent PCI target speed".
> 
> 
> >                       return_error = 1;
> >                       goto done;
> >               }
> > @@ -1228,22 +1225,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd)
> >       }
> >
> >       dd_dev_info(dd, "%s: setting target link speed\n", __func__);
> > -     ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL2, &lnkctl2);
> > +     ret = pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL2,
> > +                                              PCI_EXP_LNKCTL2_TLS,
> > +                                              target_vector);
> >       if (ret) {
> > -             dd_dev_err(dd, "Unable to read from PCI config\n");
> > -             return_error = 1;
> > -             goto done;
> > -     }
> > -
> > -     dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
> > -                 (u32)lnkctl2);
> > -     lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
> > -     lnkctl2 |= target_vector;
> > -     dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
> > -                 (u32)lnkctl2);
> > -     ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_LNKCTL2, lnkctl2);
> > -     if (ret) {
> > -             dd_dev_err(dd, "Unable to write to PCI config\n");
> > +             dd_dev_err(dd, "Unable to change PCI target speed\n");
> 
> To differentiate from the dev_err above, add "device", i.e. "Unable to change device PCI target speed".

Okay, I'll change those. Thanks for taking a look.

-- 
 i.

--8323329-1332323370-1694786558=:2347--
