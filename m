Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5720DBC3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 22:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgF2UJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 16:09:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:8203 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgF2UJ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jun 2020 16:09:26 -0400
IronPort-SDR: aDaW0t+7lHLm/T6o1YN2QMqnDoZpQHaJs+kop2Xt5YZf6w2z/7uRVwvr2XarJ6uFS6A7S+h6rz
 WEfRPwnnKpwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145126351"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="145126351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 13:09:26 -0700
IronPort-SDR: PoVjz7Y+YLh6hCKpBiPEoY6bNJLo/ocBfnj+22m72VjMoPDZijXwyTfNOwYkLzxZUb6K2ThjD5
 CNfUtTHR8anQ==
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="454315340"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.102]) ([10.254.206.102])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 13:09:23 -0700
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v2 2/8] IB/hfi1: Convert PCIBIOS_* errors to generic -E*
 errors
To:     refactormyself@gmail.com, helgaas@kernel.org
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200615073225.24061-1-refactormyself@gmail.com>
 <20200615073225.24061-3-refactormyself@gmail.com>
Message-ID: <9e2b006e-9a0a-19fb-5dab-52df8c0e8674@intel.com>
Date:   Mon, 29 Jun 2020 16:09:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615073225.24061-3-refactormyself@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/15/2020 3:32 AM, refactormyself@gmail.com wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> pcie_speeds() returns PCIBIOS_ error codes from PCIe capability accessors.
> 
> PCIBIOS_ error codes have positive values. Passing on these values is
> inconsistent with functions which return only a negative value on failure.
> 
> Before passing on the return value of PCIe capability accessors, call
> pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
> negative generic error values.
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> ---
>   drivers/infiniband/hw/hfi1/pcie.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index 1a6268d61977..eb53781d0c6a 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -306,7 +306,7 @@ int pcie_speeds(struct hfi1_devdata *dd)
>   	ret = pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &linkcap);
>   	if (ret) {
>   		dd_dev_err(dd, "Unable to read from PCI config\n");
> -		return ret;
> +		return pcibios_err_to_errno(ret);
>   	}
>   
>   	if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_8_0GB) {
> 

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
