Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1947DC9DE6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfJCL64 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 07:58:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:8861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfJCL64 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 07:58:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 04:58:55 -0700
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="185892227"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.204.65]) ([10.254.204.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 03 Oct 2019 04:58:54 -0700
Subject: Re: [bug report] IB/hfi1: Eliminate allocation while atomic
To:     Dan Carpenter <dan.carpenter@oracle.com>, don.hiatt@intel.com
Cc:     linux-rdma@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Greg KH <greg@kroah.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
References: <20191002121520.GA11064@mwanda>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <3452a307-5f87-4587-b289-63ea8bc594b5@intel.com>
Date:   Thu, 3 Oct 2019 07:58:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191002121520.GA11064@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/2/2019 8:15 AM, Dan Carpenter wrote:
> Hello Don Hiatt,
> 
> The patch f8195f3b14a0: "IB/hfi1: Eliminate allocation while atomic"
> from Oct 9, 2017, leads to the following static checker warning:
> 
> 	drivers/infiniband/hw/hfi1/verbs.c:824 build_verbs_tx_desc()
> 	error: doing dma on the stack (trail_buf)
> 
> drivers/infiniband/hw/hfi1/verbs.c
>     147  /* Length of buffer to create verbs txreq cache name */
>     148  #define TXREQ_NAME_LEN 24
>     149
>     150  /* 16B trailing buffer */
>     151  static const u8 trail_buf[MAX_16B_PADDING];
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This used to be actually allocated on the stack but now it's here.  I
> believe this is still a problem.  It's not a problem for most people at
> runtime, but it's technically a bug.  And I believe that soon we will
> add a check in dma_map_single() which will generate a warning.
> 
>     152
>     153  static uint wss_threshold = 80;
> 
> [ snip ]
> 
>     801          } else {
>     802                  ret = sdma_txinit_ahg(
>     803                          &tx->txreq,
>     804                          ahg_info->tx_flags,
>     805                          length,
>     806                          ahg_info->ahgidx,
>     807                          ahg_info->ahgcount,
>     808                          ahg_info->ahgdesc,
>     809                          hdrbytes,
>     810                          verbs_sdma_complete);
>     811                  if (ret)
>     812                          goto bail_txadd;
>     813          }
>     814          /* add the ulp payload - if any. tx->ss can be NULL for acks */
>     815          if (tx->ss) {
>     816                  ret = build_verbs_ulp_payload(sde, length, tx);
>     817                  if (ret)
>     818                          goto bail_txadd;
>     819          }
>     820
>     821          /* add icrc, lt byte, and padding to flit */
>     822          if (extra_bytes)
>     823                  ret = sdma_txadd_kvaddr(sde->dd, &tx->txreq,
>     824                                          (void *)trail_buf, extra_bytes);
>                                                          ^^^^^^^^^
> This has to be DMAable memory.
> 
>     825
>     826  bail_txadd:
>     827          return ret;
>     828  }
> 
> 
> regards,
> dan carpenter
> 

Thanks Dan, we actually got a separate out-of-band email about this. We 
are working up a fix right now.

-Denny
