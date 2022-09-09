Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603325B3431
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiIIJkg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 05:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiIIJka (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 05:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E39C525;
        Fri,  9 Sep 2022 02:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9845261F6A;
        Fri,  9 Sep 2022 09:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A696C433C1;
        Fri,  9 Sep 2022 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662716425;
        bh=HsfqPASjnakS+xsqfPpAn2Do0sUbq2U9xY/KUbbjIP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Np7qYKPDxkWRV3AzIEX0EEInSZkDu8nyjOKt/thmwV20qBJ/XehbSQ6RAFNU59mRz
         uIaN745OjFy8eeLD3llQbNIMMzzk93bzsvg8Ls+StIWbB0lsbujcMsfeQW0xO/odEb
         cVASnbjfzCf/mnDTH+NxBLvJcU0ZCdtWyY2YmnwPRZ8Mypx2gzn2xFFcncu/YIY7X5
         F5faa52aFffAWRL/lOvU/lbc0yTJY3ZVrocrHLme32ptHBRTzjBfoOrBJYk8SC40mx
         gTzi+PGBo/WpCGibrG3zzCmh8Al0eTOlddTf3OG55JThKJUSZlkx4pnphVospe5Yhk
         cwxQVw9xK0u8A==
Date:   Fri, 9 Sep 2022 10:40:10 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     bvanassche@acm.org, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: ulp: srpt: Use flex array destination for
 memcpy()
Message-ID: <YxsJ+n8RjpBIpGKo@work>
References: <20220909022943.8896-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909022943.8896-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 09, 2022 at 10:29:43AM +0800, Hangyu Hua wrote:
> In preparation for FORTIFY_SOURCE performing run-time destination buffer
> bounds checking for memcpy(), specify the destination output buffer
> explicitly, instead of asking memcpy() to write past the end of what looked
> like a fixed-size object.
> 
> Notice that srp_rsp[] is a pointer to a structure that contains
> flexible-array member data[]:
> 
> struct srp_rsp {
> 	...
> 	__be32	sense_data_len;
> 	__be32	resp_data_len;
> 	u8	data[];
> };
> 
> link: https://github.com/KSPP/linux/issues/201
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 21cbe30d526f..8c29e14150d3 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -1421,7 +1421,7 @@ static int srpt_build_cmd_rsp(struct srpt_rdma_ch *ch,
>  
>  		srp_rsp->flags |= SRP_RSP_FLAG_SNSVALID;
>  		srp_rsp->sense_data_len = cpu_to_be32(sense_data_len);
> -		memcpy(srp_rsp + 1, sense_data, sense_data_len);
> +		memcpy(srp_rsp->data, sense_data, sense_data_len);
>  	}
>  
>  	return sizeof(*srp_rsp) + sense_data_len;
> -- 
> 2.34.1
> 
