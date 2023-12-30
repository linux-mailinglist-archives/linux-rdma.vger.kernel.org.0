Return-Path: <linux-rdma+bounces-509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7318206EB
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Dec 2023 16:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287671C20EB7
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Dec 2023 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1396945A;
	Sat, 30 Dec 2023 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdlySp1m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BAB8F65;
	Sat, 30 Dec 2023 15:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F18C433C7;
	Sat, 30 Dec 2023 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703951066;
	bh=rIx5TWsTspDkYObnDFFupr7if4KBR6HUkks9+m80IkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdlySp1mmmuB1ozWiZ5zXIVcjQhC2vI9Nkrv7uL2LgzrFEGQs+sfsHAqUspX33DmE
	 A38qTbwB7eSMlaY4buhlSh8SYnGQ3+0Ak02ebfjnp5EDQdoovTgT9kdr/7GgOHXIw/
	 oALvm9dgTqvlhFADgkqGekzKUqSMYq7quqB4gR7KW6N01US7gJvd0X/snD9syo1kS2
	 rRWbAkBnT5wNeks3Xx7XJzn9h63wR26hz55Myz7bxlKIsT7ow1k/TZx1PjnkTp04CX
	 PCEvFVqPQR/fhW2FIgctDGfx3cOZg2W8vlqtqkYIdn3U4bzr79LoDRM14VA7CnqYzo
	 Wyynm7YJJqhgA==
Date: Sat, 30 Dec 2023 17:44:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jgg@ziepe.ca, gustavoars@kernel.org, bvanassche@acm.org,
	markzhang@nvidia.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/sa_query: use validate not parser in
 ib_nl_is_good_resolve_resp
Message-ID: <20231230154422.GB6849@unreal>
References: <20231230051956.82499-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230051956.82499-1-linma@zju.edu.cn>

On Sat, Dec 30, 2023 at 01:19:56PM +0800, Lin Ma wrote:
> The attributes array `tb` in ib_nl_is_good_resolve_resp is never used
> after the parsing. Therefore use nla_validate_deprecated function here
> for improvement.

What did this change improve?

> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  drivers/infiniband/core/sa_query.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index 8175dde60b0a..c7407a53fcda 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -1047,14 +1047,13 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
>  
>  static inline int ib_nl_is_good_resolve_resp(const struct nlmsghdr *nlh)
>  {
> -	struct nlattr *tb[LS_NLA_TYPE_MAX];
>  	int ret;
>  
>  	if (nlh->nlmsg_flags & RDMA_NL_LS_F_ERR)
>  		return 0;
>  
> -	ret = nla_parse_deprecated(tb, LS_NLA_TYPE_MAX - 1, nlmsg_data(nlh),
> -				   nlmsg_len(nlh), ib_nl_policy, NULL);
> +	ret = nla_validate_deprecated(nlmsg_data(nlh), nlmsg_len(nlh),
> +				      LS_NLA_TYPE_MAX - 1, ib_nl_policy, NULL);
>  	if (ret)
>  		return 0;
>  
> -- 
> 2.17.1
> 

