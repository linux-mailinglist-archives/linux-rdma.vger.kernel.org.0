Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE11660401
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jan 2023 17:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjAFQJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Jan 2023 11:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjAFQJE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Jan 2023 11:09:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9881A76200;
        Fri,  6 Jan 2023 08:08:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 342AA61E1E;
        Fri,  6 Jan 2023 16:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA65C433EF;
        Fri,  6 Jan 2023 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673021332;
        bh=hGUsvrDCWTVtI40jiZsfyqGjhc8u0VHGyzAvUobubxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHYk+w1qfEDYWp7DPnNEJ5nM/fZR34TVsVtqFuoGDgzL26W+cQYqECE+7gOAEbY02
         tuAIqSw5LXCrULqe8B1xL01q1ZDliYLxznbvPCN1XVH0EOzmTdnkvo38TFLF77sNKY
         +RZEBxdDbV2dDnhP4IS4wf97EWX/FRidTRtuTtHVLqqSfqqVsm0z749vAfSHL/Rtys
         lgNUC7UD7jpL8Y70kav4OU0uMuFmfHSWTsK3vmVxNa6FfgUL0dQvIwH+7wzAGlcHP0
         u5ORK02hLptO2lUNJ1kTVs2I7JTJgauvXjKZwDEM9FylhAPu+vjXsrcveLc/ssJpej
         Irbh2FFmwAgOw==
Date:   Fri, 6 Jan 2023 10:08:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: Replace 0-length arrays with flexible arrays
Message-ID: <Y7hHmV7xaI/Y1SIg@work>
References: <20230105223225.never.252-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105223225.never.252-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 05, 2023 at 02:32:32PM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace all remaining
> 0-length arrays with flexible arrays. Detected with GCC 13, using
> -fstrict-flex-arrays=3:
> 
> In function 'build_rdma_write',
>     inlined from 'c4iw_post_send' at ../drivers/infiniband/hw/cxgb4/qp.c:1173:10:
> ../drivers/infiniband/hw/cxgb4/qp.c:597:38: warning: array subscript 0 is outside array bounds of 'struct fw_ri_immd[0]' [-Warray-bounds=]
>   597 |                 wqe->write.u.immd_src[0].r2 = 0;
>       |                 ~~~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h: In function 'c4iw_post_send':
> ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:567:35: note: while referencing 'immd_src'
>   567 |                 struct fw_ri_immd immd_src[0];
>       |                                   ^~~~~~~~
> 
> Additionally drop the unused C99_NOT_SUPPORTED ifndef lines.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: Potnuri Bharat Teja <bharat@chelsio.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  drivers/infiniband/hw/cxgb4/t4fw_ri_api.h | 26 ++++++-----------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h b/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
> index a2f5e29ef226..1f79537fc8d1 100644
> --- a/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
> +++ b/drivers/infiniband/hw/cxgb4/t4fw_ri_api.h
> @@ -122,9 +122,7 @@ struct fw_ri_dsgl {
>  	__be16	nsge;
>  	__be32	len0;
>  	__be64	addr0;
> -#ifndef C99_NOT_SUPPORTED
>  	struct fw_ri_dsge_pair sge[];
> -#endif
>  };
>  
>  struct fw_ri_sge {
> @@ -138,9 +136,7 @@ struct fw_ri_isgl {
>  	__u8	r1;
>  	__be16	nsge;
>  	__be32	r2;
> -#ifndef C99_NOT_SUPPORTED
>  	struct fw_ri_sge sge[];
> -#endif
>  };
>  
>  struct fw_ri_immd {
> @@ -148,9 +144,7 @@ struct fw_ri_immd {
>  	__u8	r1;
>  	__be16	r2;
>  	__be32	immdlen;
> -#ifndef C99_NOT_SUPPORTED
>  	__u8	data[];
> -#endif
>  };
>  
>  struct fw_ri_tpte {
> @@ -320,9 +314,7 @@ struct fw_ri_res_wr {
>  	__be32 op_nres;
>  	__be32 len16_pkd;
>  	__u64  cookie;
> -#ifndef C99_NOT_SUPPORTED
>  	struct fw_ri_res res[];
> -#endif
>  };
>  
>  #define FW_RI_RES_WR_NRES_S	0
> @@ -562,12 +554,10 @@ struct fw_ri_rdma_write_wr {
>  	__be32 plen;
>  	__be32 stag_sink;
>  	__be64 to_sink;
> -#ifndef C99_NOT_SUPPORTED
>  	union {
> -		struct fw_ri_immd immd_src[0];
> -		struct fw_ri_isgl isgl_src[0];
> +		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
> +		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
>  	} u;
> -#endif
>  };
>  
>  struct fw_ri_send_wr {
> @@ -581,12 +571,10 @@ struct fw_ri_send_wr {
>  	__be32 plen;
>  	__be32 r3;
>  	__be64 r4;
> -#ifndef C99_NOT_SUPPORTED
>  	union {
> -		struct fw_ri_immd immd_src[0];
> -		struct fw_ri_isgl isgl_src[0];
> +		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
> +		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
>  	} u;
> -#endif
>  };
>  
>  #define FW_RI_SEND_WR_SENDOP_S		0
> @@ -618,12 +606,10 @@ struct fw_ri_rdma_write_cmpl_wr {
>  		struct fw_ri_isgl isgl_src;
>  	} u_cmpl;
>  	__be64 r3;
> -#ifndef C99_NOT_SUPPORTED
>  	union fw_ri_write {
> -		struct fw_ri_immd immd_src[0];
> -		struct fw_ri_isgl isgl_src[0];
> +		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
> +		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
>  	} u;
> -#endif
>  };
>  
>  struct fw_ri_rdma_read_wr {
> -- 
> 2.34.1
> 
