Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB220DE25
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 23:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbgF2UXD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 16:23:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:4368 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732276AbgF2UXD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jun 2020 16:23:03 -0400
IronPort-SDR: Nn3KdIzXxBH3AmDRtRC7fh1FFQdezP5pCeuPJFw4KjdAurYFbLy+GkxQBR6s8eRqBJ7j8cABx8
 3yLkor0UAaKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126197047"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="126197047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 13:23:02 -0700
IronPort-SDR: yftIs/JWOAhBU81sWmB9VyvJd86EmAa3JTtUEhlxTGsJKLkXr8QWZCECgVuYq4/IJBy0Kt7W0R
 +Q5DN6Lilc/w==
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="454319084"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.206.102]) ([10.254.206.102])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 13:23:00 -0700
Subject: Re: [PATCH v2 3/8] IB/hfi1: Convert PCIBIOS_* errors to generic -E*
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
 <20200615073225.24061-4-refactormyself@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <5cf6a566-fded-6e98-f7ad-ff1c2a7608ad@intel.com>
Date:   Mon, 29 Jun 2020 16:22:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615073225.24061-4-refactormyself@gmail.com>
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
> restore_pci_variables() and save_pci_variables() return PCIBIOS_ error
> codes from PCIe capability accessors.
> 
> PCIBIOS_ error codes have positive values. Passing on these values is
> inconsistent with functions which return only a negative value on failure.
> 
> Before passing on the return value of PCIe capability accessors, call
> pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
> negative generic error values.
> 
> Fix redundant initialisation.
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Looks like we may have had a problem when calling 
pci_read_config_dword() from the init dd path and doing a check for < 0 
to bail. So this looks like goodness to me.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
