Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1217C25457B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgH0M4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgH0M41 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:56:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62EC06121B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:56:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m7so5689490qki.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xhcckmbK9iypvx3P7enC0MUqdGOSbvc+CYX34X0YgoE=;
        b=CXmoP5nzT8yBQFs9UC74HcUtwr+xjPRE8eOPeDCknUI5LoNYVcvn9LSa/VrhUEhK0V
         HfS49B3nJNv3q4+fh7g1EyUGnZHO3DXfs0Iwec2PrET0T8eKgXT7OrtL3rtJEOk+lTBy
         qJXZyno0aFJADmCj3YH3Ad0K4rJnlrz8zB2Ml0YKUBkA+/NvSlkLh5LEuh9Q1tJVWcSz
         biAJO28vO8bR7CQzpXTiC8/jAEBujj6Xfc097kfcgPT1GZQDAWV0LbSPROCMqOriQw0y
         BWJKD67kH4pylDXzPqRB9L9uLOJ9DyP2iRXzFyusNW8roTVzhHIcJhn1NqIlFnjrzF+u
         lQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xhcckmbK9iypvx3P7enC0MUqdGOSbvc+CYX34X0YgoE=;
        b=OkqKAm489p8Qle78ROVltVFP3DrLg4oEIBxCXZ5AtirihLH2QjnSm3W0nXakyCDvt2
         /Ai1xAnK6aM3LXhCCdw43yuHaZshS2CCDdRJdqs6G/tG4Lf26d/t9+yQrsS2PveEuL+s
         nKbusTO4r/fHeEpy5CxV9B5IL5ztPY+9cN+i9SH/Y2ZPt3Ky+tRxO21c3/NRpVhQPiOA
         6sTrR31YDoNnAFioPekuFvNyuCA2ENiZ0VAcnK8it7dtt+ZZ0WCAd3en2J1fDKUegtkR
         eODb4VF9WsBOEsyJ4MNP4mLfnbxgavofxKElU/yTkq9B0wSuOK4fUE/aXzRB8R4ifa18
         u7dQ==
X-Gm-Message-State: AOAM530TucYJVvUcZfD57/Y43O/09G8uA4uBHtoMo6zmq9y2suHKxGcx
        TG7PUkUqP0gCkCHcEEDVPUjAxg==
X-Google-Smtp-Source: ABdhPJwdXQrz6U8aU2R0FHlSJgSgHXDBVvFHAudTlK6cbVt1fPSWt+09cMY/cy4SnnO+ybCBURLdmg==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr18778138qkk.293.1598532986391;
        Thu, 27 Aug 2020 05:56:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z23sm1615518qkj.118.2020.08.27.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:56:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBHS5-00GtEX-45; Thu, 27 Aug 2020 09:56:25 -0300
Date:   Thu, 27 Aug 2020 09:56:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 05/17] rdma_rxe: Added bind_mw parameters to
 rxe_send_wr
Message-ID: <20200827125625.GQ24045@ziepe.ca>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-6-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820224638.3212-6-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 05:46:26PM -0500, Bob Pearson wrote:
> This is a first prototype version of the user/kernel ABI extension
> to add memory windows functionality to the rxe driver. It evolves
> later.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  include/uapi/rdma/rdma_user_rxe.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index d8f2e0e46dab..dc01e5f3e31a 100644
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -93,6 +93,14 @@ struct rxe_send_wr {
>  			__u32	remote_qkey;
>  			__u16	pkey_index;
>  		} ud;
> +		struct {
> +			__aligned_u64	addr;
> +			__aligned_u64	length;
> +			__u32	mr_index;
> +			__u32	mw_index;
> +			__u32	rkey;
> +			__u32	access;
> +		} bind_mw;
>  		/* reg is only used by the kernel and is not part of the uapi */
>  		struct {
>  			union {

Add to the patch that uses this

Jason
