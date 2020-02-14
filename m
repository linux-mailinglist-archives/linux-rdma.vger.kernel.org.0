Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD97A15EC55
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 18:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbgBNR0i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 12:26:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:40382 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390996AbgBNR0i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Feb 2020 12:26:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 09:26:37 -0800
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="223081578"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.146]) ([10.254.204.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2020 09:26:35 -0800
Subject: Re: [PATCH 3/3] infiniband: sw: rdmavt: mcast.c: Use built-in RCU
 list checking
To:     madhuparnabhowmik04@gmail.com, mike.marciniszyn@intel.com,
        jgg@ziepe.ca, paulmck@kernel.org
Cc:     joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200114162536.20388-1-madhuparnabhowmik04@gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <b9a48945-7fc7-2463-2b56-61ad43e54754@intel.com>
Date:   Fri, 14 Feb 2020 12:26:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200114162536.20388-1-madhuparnabhowmik04@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/14/2020 11:25 AM, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> Use built-in RCU and lock-checking for list_for_each_entry_rcu()
> by passing the cond argument.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---
>   drivers/infiniband/sw/rdmavt/mcast.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
> index dd11c6fcd060..31c7f12c7665 100644
> --- a/drivers/infiniband/sw/rdmavt/mcast.c
> +++ b/drivers/infiniband/sw/rdmavt/mcast.c
> @@ -224,7 +224,7 @@ static int rvt_mcast_add(struct rvt_dev_info *rdi, struct rvt_ibport *ibp,
>   		}
>   
>   		/* Search the QP list to see if this is already there. */
> -		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {
> +		list_for_each_entry_rcu(p, &tmcast->qp_list, list, lockdep_is_held(&(ibp->lock))) {
>   			if (p->qp == mqp->qp) {
>   				ret = ESRCH;
>   				goto bail;
> 

This one is OK. The lock is held and it is the correct one to use when 
updating the list.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
