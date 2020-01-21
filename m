Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988AD143D3D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2020 13:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgAUMr6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jan 2020 07:47:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:43890 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgAUMr6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jan 2020 07:47:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 04:47:57 -0800
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="215526871"
Received: from mdemarse-mobl.amr.corp.intel.com (HELO [10.254.201.205]) ([10.254.201.205])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Jan 2020 04:47:56 -0800
Subject: Re: [PATCH] IB/opa_vnic: Spelling correction of 'erorr' to 'error'
To:     Dillon Brock <dab9861@gmail.com>
Cc:     Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200118162542.15188-1-dab9861@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <961cb826-e173-ff44-ee23-06012138a185@intel.com>
Date:   Tue, 21 Jan 2020 07:47:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200118162542.15188-1-dab9861@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/18/2020 11:25 AM, Dillon Brock wrote:
> Correcting a minor spelling mistake in the comments.
> 
> Signed-off-by: Dillon Brock <dab9861@gmail.com>
> ---
>   drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
> index e4c9bf2ef7e2..4480092c68e0 100644
> --- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
> +++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
> @@ -358,7 +358,7 @@ struct opa_veswport_summary_counters {
>    * @rx_drop_state: received packets in non-forwarding port state
>    * @rx_logic: other receive errors
>    *
> - * All the above are counters of corresponding erorr conditions.
> + * All the above are counters of corresponding error conditions.
>    */
>   struct opa_veswport_error_counters {
>   	__be16  vp_instance;
> 

Thanks for the touch up.

Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
