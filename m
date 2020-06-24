Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F48207B68
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 20:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405694AbgFXSWO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 14:22:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:42498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405469AbgFXSWN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 14:22:13 -0400
IronPort-SDR: 5EdNen1urGx3xu520/d0V13OdQNSuormqmpCAnH+RRs05c5kHmogwHFiL1BBr4i+8cGB0vppo7
 wdszPcnHzebw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="146085111"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="146085111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 11:22:12 -0700
IronPort-SDR: y8XjN9L8Jlc0bMzZwbEmAZINkkyOuX0uT/0lYOcJzyHC8FVKJZtmplyNK7NDePdZVcRGZMyjKv
 pR9tQrlvVliw==
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="452733692"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.202.60]) ([10.254.202.60])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 11:22:11 -0700
Subject: Re: [PATCH] IB/hfi1: Add explicit cast OPA_MTU_8192 to 'enum ib_mtu'
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20200623005224.492239-1-natechancellor@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <5f98c547-1bac-bb05-1c75-cefb8616964a@intel.com>
Date:   Wed, 24 Jun 2020 14:22:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623005224.492239-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/22/2020 8:52 PM, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/infiniband/hw/hfi1/qp.c:198:9: warning: implicit conversion from
> enumeration type 'enum opa_mtu' to different enumeration type 'enum
> ib_mtu' [-Wenum-conversion]
>                  mtu = OPA_MTU_8192;
>                      ~ ^~~~~~~~~~~~
> 1 warning generated.
> 
> enum opa_mtu extends enum ib_mtu. There are typically two ways to deal
> with this:
> 
> * Remove the expected types and just use 'int' for all parameters and
>    types.
> 
> * Explicitly cast the enums between each other.
> 
> This driver chooses to do the later so do the same thing here.
> 
> Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1062
> Link: https://lore.kernel.org/linux-rdma/20200527040350.GA3118979@ubuntu-s3-xlarge-x86/
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

