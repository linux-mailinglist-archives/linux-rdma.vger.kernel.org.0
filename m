Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A583264B28
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfGJRDZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 13:03:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:17215 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbfGJRDY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 13:03:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 10:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,475,1557212400"; 
   d="scan'208";a="176899411"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2019 10:03:23 -0700
Date:   Wed, 10 Jul 2019 10:03:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in
 rvt_create_cq
Message-ID: <20190710170322.GA5072@iweiny-DESK2.sc.intel.com>
References: <20190709221312.7089-1-natechancellor@gmail.com>
 <20190709230552.61842-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709230552.61842-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 04:05:53PM -0700, Nathan Chancellor wrote:
> clang warns:
> 
> drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (err)
>                     ^~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:260:3: note: remove the 'if' if its
> condition is always false
>                 if (err)
>                 ^~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:253:7: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (!cq->ip) {
>                     ^~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:253:3: note: remove the 'if' if its
> condition is always false
>                 if (!cq->ip) {
>                 ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:211:9: note: initialize the variable
> 'err' to silence this warning
>         int err;
>                ^
>                 = 0
> 2 warnings generated.

What version of the kernel was this found on?

I don't see the problem with 5.2.  AFAICS there is no 'err' in the function
scope and the if scoped 'err' is initialized properly on line 239.

Ira

> 
> The function scoped err variable is uninitialized when the flow jumps
> into the if statement. The if scoped err variable shadows the function
> scoped err variable, preventing the err assignments within the if
> statement to be reflected at the function level, which will cause
> uninitialized use when the goto statements are taken.
> 
> Just remove the if scoped err declaration so that there is only one
> copy of the err variable for this function.
> 
> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
> Link: https://github.com/ClangBuiltLinux/linux/issues/594
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> * Updated the wording of the commit message to use proper terms like
>   scoping and shadowing, thanks to review from Nick (let me know if the
>   wording isn't up to snuff).
> 
>  drivers/infiniband/sw/rdmavt/cq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
> index fac87b13329d..a85571a4cf57 100644
> --- a/drivers/infiniband/sw/rdmavt/cq.c
> +++ b/drivers/infiniband/sw/rdmavt/cq.c
> @@ -247,8 +247,6 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	 * See rvt_mmap() for details.
>  	 */
>  	if (udata && udata->outlen >= sizeof(__u64)) {
> -		int err;
> -
>  		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
>  		if (!cq->ip) {
>  			err = -ENOMEM;
> -- 
> 2.22.0
> 
