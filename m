Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AACC234739
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgGaNz0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 09:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbgGaNz0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 09:55:26 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF0C206DA;
        Fri, 31 Jul 2020 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596203725;
        bh=vYmjK8mMYkxQN9Q5kjSg6X+4qsltfw1XYti+2tjxa/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Mmszk77KtX/XuyJPvUeBF+uSMjC3wMTXVesDiMr1rqTPEibn4GlNI1dHLpdRa7Sl+
         K+gM6afW6Fp5XeCSnC07IMsYqculLdCzaaTRS86Mi/gu9fmp8W75ncG97tp7g1TtvI
         VsUEIYwFaaR3pr2CWtVYygMUe62iVp1ky5BhBHvc=
Date:   Fri, 31 Jul 2020 08:55:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, bjorn@helgaas.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Ian Kumlien <ian.kumlien@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH v4 01/12] IB/hfi1: Check if pcie_capability_read_*()
 reads ~0
Message-ID: <20200731135523.GA3717@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731110240.98326-2-refactormyself@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[+cc Michael, Ashutosh, Ian, Puranjay]

On Fri, Jul 31, 2020 at 01:02:29PM +0200, Saheed O. Bolarinwa wrote:
> On failure pcie_capability_read_dword() sets it's last parameter,
> val to 0. In this case dn and up will be 0, so aspm_hw_l1_supported()
> will return false.
> However, with Patch 12/12, it is possible that val is set to ~0 on
> failure. This would introduce a bug because (x & x) == (~0 & x). So
> with dn and up being 0x02, a true value is return when the read has
> actually failed.
> 
> Since, the value ~0 is invalid here,
> 
> Reset dn and up to 0 when a value of ~0 is read into them, this
> ensures false is returned on failure in this case.
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
> 
>  drivers/infiniband/hw/hfi1/aspm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hfi1/aspm.c
> index a3c53be4072c..9605b2145d19 100644
> --- a/drivers/infiniband/hw/hfi1/aspm.c
> +++ b/drivers/infiniband/hw/hfi1/aspm.c
> @@ -33,13 +33,13 @@ static bool aspm_hw_l1_supported(struct hfi1_devdata *dd)
>  		return false;
>  
>  	pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
> -	dn = ASPM_L1_SUPPORTED(dn);
> +	dn = (dn == (u32)~0) ? 0 : ASPM_L1_SUPPORTED(dn);
>  
>  	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
> -	up = ASPM_L1_SUPPORTED(up);
> +	up = (up == (u32)~0) ? 0 : ASPM_L1_SUPPORTED(up);

I don't want to change this.  The driver shouldn't be mucking with
ASPM at all.  The PCI core should take care of this automatically.  If
it doesn't, we need to fix the core.

If the driver needs to disable ASPM to work around device errata or
something, the core has an interface for that.  But the driver should
not override the system-wide policy for managing ASPM.

Ah, some archaeology finds affa48de8417 ("staging/rdma/hfi1: Add
support for enabling/disabling PCIe ASPM"), which says:

  hfi1 HW has a high PCIe ASPM L1 exit latency and also advertises an
  acceptable latency less than actual ASPM latencies.

That suggests that either there is a device defect, e.g., advertising
incorrect ASPM latencies, or a PCI core defect, e.g., incorrectly
enabling ASPM when the path exit latency exceeds that hfi1 can
tolerate.

Coincidentally, Ian recently debugged a problem in how the PCI core
computes exit latencies over a path [1].

Can anybody supply details about the hfi1 ASPM parameters, e.g., the
output of "sudo lspci -vv"?  Any details about the configuration where
the problem occurs?  Is there a switch in the path?

[1] https://lore.kernel.org/r/20200727213045.2117855-1-ian.kumlien@gmail.com

>  	/* ASPM works on A-step but is reported as not supported */
> -	return (!!dn || is_ax(dd)) && !!up;
> +	return (dn || is_ax(dd)) && up;
>  }
>  
>  /* Set L1 entrance latency for slower entry to L1 */
> -- 
> 2.18.4
> 
