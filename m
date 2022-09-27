Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D675EBD0E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiI0ITO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 04:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiI0ITO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 04:19:14 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A106585
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 01:19:12 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="89605594"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="89605594"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 17:18:56 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2ABF2D63BA
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 17:18:55 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 46FF8D9480
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 17:18:54 +0900 (JST)
Received: from [10.167.226.45] (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 004122340BA0;
        Tue, 27 Sep 2022 17:18:52 +0900 (JST)
Message-ID: <fb02de6c-a32b-654a-62b9-55f44ffaec30@fujitsu.com>
Date:   Tue, 27 Sep 2022 16:18:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
Content-Language: en-US
To:     =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20220708040228.6703-2-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.006
X-TMASE-Result: 10--5.625300-10.000000
X-TMASE-MatchedRID: mafpUJSAc1CPvrMjLFD6eBmiTJb38WRejkDrBOJwwnQsTMNBTJAZWd6u
        rnXKpk/cjD2u30TwDij61UvMFtWiXZcLewwAa76fRcGHEV0WBxBSuvtBzlaEqBdHX2eZFfZf61Z
        Tb66Rn1/z9uaZMbg8RbRG09j8+VbNDtBt+r/CzCpO5y1KmK5bJRSLgSFq3TnjnG8msLIkY3ejxY
        yRBa/qJc5onykCyp/7dB0ntd9Tzp7iRhduhvElsvJT+hf62k2Y+gsSeW2jNCcShK+JS/A9Ps39T
        6RyE6VdOLtUGtrhfw4bB+cs/nEfnkuFvzEYSdV+
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Yang

I wonder if you need to do something if a user register MR with ATOMIC_WRITE to non-rxe device, something like in my flush:

Thanks
Zhijian

  static inline int ib_check_mr_access(struct ib_device *ib_dev,
  				     unsigned int flags)
  {
+	u64 device_cap = ib_dev->attrs.device_cap_flags;
+
  	/*
  	 * Local write permission is required if remote write or
  	 * remote atomic permission is also requested.
@@ -4335,6 +4346,13 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
  	if (flags & IB_ACCESS_ON_DEMAND &&
  	    !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
  		return -EINVAL;
+
+	if ((flags & IB_ACCESS_FLUSH_GLOBAL &&
+	    !(device_cap & IB_DEVICE_FLUSH_GLOBAL)) ||
+	    (flags & IB_ACCESS_FLUSH_PERSISTENT &&
+	    !(device_cap & IB_DEVICE_FLUSH_PERSISTENT)))
+		return -EINVAL;
+
  	return 0;
  }
  

On 08/07/2022 12:02, Yang, Xiao/杨 晓 wrote:
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 9c6317cf80d5..7834285c8498 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h

