Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB5804C175
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfFSTYd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 15:24:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41303 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfFSTYd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 15:24:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so278234qkk.8
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JxOl1aq6JWeothcD+ZipIGRtqh8lasIX4S05bL3bhpc=;
        b=dR87n+26Al6SsJ9Mi0C6kwGLPXb/wLmP1ziQZGpzgkHhn2hgyBz+aBmxsjF+tbK2Gn
         EntWceqS+6QI5Fd9QdAeuOOFc8HPv/15V7L6w17eMO/I3yYn4JIb9WzNIcjGDkAobOFo
         GhJ6C6ZejMGxFSC5artxmvAqmbqXp1t/Sm7PCK8kLwGxyrcJhnZ4+A0MYmki5F4t9wpj
         mxG0PCksI2LC5paZsFiufCMNGRa3oPSPPyNWO3RF6Vqe8Er10C+XeyOc8dtBjyRWz81H
         EksYY7Yaa08rqWVn/nEvDV4BQMbH3Bw+GmMoX9IZxi57AeI1XrtMnggERa1AligX8miI
         vweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JxOl1aq6JWeothcD+ZipIGRtqh8lasIX4S05bL3bhpc=;
        b=p170vAkRfBh5RSwsqulS/Gu0ynznTnNFK7U4DUg8gevU0HgBitnoaIuexV1DKBliXd
         fgUJqbJlvnTKokcvECHCbgt5mHzjLklWOJnD/8HF6Jwsp3pCwzXWvBx4hLJM2XlOayXO
         o4tIXfitvNVvN9n5M2DgOl6GEeBoJZQ/RXrBK37Ryu/2Y1oRgFpOqvb+phFTAdtR8gTp
         rrH7YqbDQLeTZ39N6BKCsSuOm7cegwvIWmKBOCnSSF7kjLpsa1jBMr9vKJKuLr6nonYr
         H/0iIN8OAOweLWmaC3a7BL0hUxV4xLHfMK48yhEortim1nLbvGuOXbihFEafPD03NsSw
         q4Dw==
X-Gm-Message-State: APjAAAVXvgOfF5NvgMxVYj5p3m4Q6TwcBeR5usAykmMDE3Jn2iRUStYn
        4B8bcJWqIPWf2ll0lot9lppSfA==
X-Google-Smtp-Source: APXvYqzHOVhGd8SpcMYhP+BRv8tafCv2rJN2Z2cq+SpU8sspnGIy/WftKQYy5nia15y2X5g/aXrFwg==
X-Received: by 2002:a37:a017:: with SMTP id j23mr100876837qke.258.1560972272381;
        Wed, 19 Jun 2019 12:24:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x205sm2984490qka.56.2019.06.19.12.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 12:24:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdgC7-0003Uf-DY; Wed, 19 Jun 2019 16:24:31 -0300
Date:   Wed, 19 Jun 2019 16:24:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
Message-ID: <20190619192431.GA13262@ziepe.ca>
References: <cover.1560957168.git.dledford@redhat.com>
 <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 11:16:12AM -0400, Doug Ledford wrote:
> For all string attributes for which we don't currently accept the
> element as input, we only use it as output, set the string length to
> RDMA_NLDEV_ATTR_EMPTY_STRING which is defined as 1.  That way we will
> only accept a null string for that element.  This will prevent someone
> from writing a new input routine that uses the element without also
> updating the policy to have a valid value.
> 
> Also while there, make sure the existing entries that are valid have the
> correct policy, if not, correct the policy.  Remove unnecessary checks
> for nla_strlcpy() overflow once the policy has been set correctly.
> 
> Signed-off-by: Doug Ledford <dledford@redhat.com>
>  drivers/infiniband/core/nldev.c  | 24 +++++++++++-------------
>  include/uapi/rdma/rdma_netlink.h |  1 +
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> v0->v1: Remove all whitespace change noise from this patch, this patch
> is now all functional changes
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 6006d23d0410..291d13642fcf 100644
> +++ b/drivers/infiniband/core/nldev.c
> @@ -49,29 +49,29 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_CHARDEV]		= { .type = NLA_U64 },
>  	[RDMA_NLDEV_ATTR_CHARDEV_ABI]		= { .type = NLA_U64 },
>  	[RDMA_NLDEV_ATTR_CHARDEV_NAME]		= { .type = NLA_NUL_STRING,
> -					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
> +					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
>  	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type = NLA_NUL_STRING,
> -					.len = 128 },
> +					.len = IB_DEVICE_NAME_MAX },
>  	[RDMA_NLDEV_ATTR_DEV_INDEX]		= { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_DEV_NAME]		= { .type = NLA_NUL_STRING,
> -					.len = IB_DEVICE_NAME_MAX - 1},
> +					.len = IB_DEVICE_NAME_MAX },
>  	[RDMA_NLDEV_ATTR_DEV_NODE_TYPE]		= { .type = NLA_U8 },
>  	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type = NLA_NUL_STRING,
> -					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
> +					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
>  	[RDMA_NLDEV_ATTR_DRIVER]		= { .type = NLA_NESTED },
>  	[RDMA_NLDEV_ATTR_DRIVER_ENTRY]		= { .type = NLA_NESTED },
>  	[RDMA_NLDEV_ATTR_DRIVER_PRINT_TYPE]	= { .type = NLA_U8 },
>  	[RDMA_NLDEV_ATTR_DRIVER_STRING]		= { .type = NLA_NUL_STRING,
> -					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
> +					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
>  	[RDMA_NLDEV_ATTR_DRIVER_S32]		= { .type = NLA_S32 },
>  	[RDMA_NLDEV_ATTR_DRIVER_S64]		= { .type = NLA_S64 },
>  	[RDMA_NLDEV_ATTR_DRIVER_U32]		= { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_DRIVER_U64]		= { .type = NLA_U64 },
>  	[RDMA_NLDEV_ATTR_FW_VERSION]		= { .type = NLA_NUL_STRING,
> -					.len = IB_FW_VERSION_NAME_MAX - 1},
> +					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
>  	[RDMA_NLDEV_ATTR_LID]			= { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_LINK_TYPE]		= { .type = NLA_NUL_STRING,
> -					.len = RDMA_NLDEV_ATTR_ENTRY_STRLEN },
> +					.len = IFNAMSIZ },
>  	[RDMA_NLDEV_ATTR_LMC]			= { .type = NLA_U8 },
>  	[RDMA_NLDEV_ATTR_NDEV_INDEX]		= { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_NDEV_NAME]		= { .type = NLA_NUL_STRING,
> @@ -92,7 +92,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  			.len = sizeof(struct __kernel_sockaddr_storage) },
>  	[RDMA_NLDEV_ATTR_RES_IOVA]		= { .type = NLA_U64 },
>  	[RDMA_NLDEV_ATTR_RES_KERN_NAME]		= { .type = NLA_NUL_STRING,
> -					.len = TASK_COMM_LEN },
> +					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
>  	[RDMA_NLDEV_ATTR_RES_LKEY]		= { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY]	= { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_RES_LQPN]		= { .type = NLA_U32 },
> @@ -120,7 +120,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY]	= { .type = NLA_NESTED },
>  	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]= { .type = NLA_U64 },
>  	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_NAME]= { .type = NLA_NUL_STRING,
> -					.len = 16 },
> +					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
>  	[RDMA_NLDEV_ATTR_RES_TYPE]		= { .type = NLA_U8 },
>  	[RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY]= { .type = NLA_U32 },
>  	[RDMA_NLDEV_ATTR_RES_USECNT]		= { .type = NLA_U64 },
> @@ -1372,10 +1372,8 @@ static int nldev_get_chardev(struct sk_buff *skb, struct nlmsghdr *nlh,
>  			  extack);
>  	if (err || !tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE])
>  		return -EINVAL;
> -
> -	if (nla_strlcpy(client_name, tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> -			sizeof(client_name)) >= sizeof(client_name))
> -		return -EINVAL;
> +	nla_strlcpy(client_name, tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> +		    sizeof(client_name));

This seems really frail, it should at least have a

BUILD_BUG_ON(sizeof(client_name) == nldev_policy[RDMA_NLDEV_ATTR_CHARDEV_TYPE].len));

But I don't think that can compile.

Are we sure we can't have a 0 length and just skip checking in policy?
It seems like more danger than it is worth.

>  	if (tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
>  		index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> index b27c02185dcc..24ff4ffa30dd 100644
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -285,6 +285,7 @@ enum rdma_nldev_command {
>  };
>  
>  enum {
> +	RDMA_NLDEV_ATTR_EMPTY_STRING = 1,
>  	RDMA_NLDEV_ATTR_ENTRY_STRLEN = 16,

The empty thing is just an internal implementation detail, should not
leak into uapi

Jason
