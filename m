Return-Path: <linux-rdma+bounces-3042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933F90294A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 21:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D7428279D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F6815A8;
	Mon, 10 Jun 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCCPr8mr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC712F38B;
	Mon, 10 Jun 2024 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047874; cv=none; b=Ks+mB4s/JCWBBEG2Knr1sgWbaP3qXuQDpIIe63yZ6nHosRyieeQxt1vhayBaPlyheOOvlB232p3tulrmLumzLNHKCK6tnYYRVLINSToQ69GIL5JewZ7uT5A4xHEQIk2qiBDh6ehsGWUVo+19wkh1Gt615FF2h36pQEGE86A58Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047874; c=relaxed/simple;
	bh=Q50+pzgA+aFaIIfbZrZ43KROpRk6pC4JGOrEdAtzXP4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rIeTH90cVNcquD3Hbr7BCkUlleOUUF+0e+KQ2rVh7QPZsIy5nXYmsDra6xeevqhs48AYU2iJw4ctPR5iejwvegEacFDNnmw5RnfWfzdcYBSuIhuJl6XQmG5NByekcThBJYP4qHPU9XK60RZ3NQcDBKP0kSPowUtr1YxOIwVxGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCCPr8mr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4218008c613so2754575e9.2;
        Mon, 10 Jun 2024 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718047871; x=1718652671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3xFH4RZCQiRLi4fnYYMNNhnFMEw94k73e6T/LCGxBo=;
        b=hCCPr8mrp9kEbgam6ov8E4UCJfOlZHScnt8FJQhRLGbQ9PhKG0wxwX8h3EJ4FjZ1N2
         CETgCZg7mONYc9XLrsrHeu20aczVM5Y018PtIuQk+qw8rdzZ8+4Sy7bPwFMwi7LX/IW8
         DkDno9xWSiWCvv77QWVvhdKaYtaz3N5pYDybTSPB/aO7Lr90YhxvlaNKFRNRLKYYsBg0
         t8lnc7ZD7sfrCj8bVAORSgHBDRkM7uZMAWOcm8b1mIKYBhAxXtQJBYCLRzzqRSojTlu3
         VN+1h3aHjnH1lkDGuKHznmVgYAQCDZNK8F34rckdZrWhhlDzoZ98/+mUsTEzCo0KFWw1
         a/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047871; x=1718652671;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3xFH4RZCQiRLi4fnYYMNNhnFMEw94k73e6T/LCGxBo=;
        b=u7rryJVfh99AuaC7vZ2L57IiQiJo/qzipXavFYtF0ZA5Nlm2CyIVRa6rLT2woCoLdb
         cQwkaQJlni2kIIHqxvrvDAMwwND10jJ5P+sNpFKEwM/b6bDkUAmh+2jzOkknEpYlgCGe
         4evuRfNQB1ejuQ/5QuFoMGkLMJdzUjRe53J2WZmZQg+fXR1CZsQY0I5HySs5D0SpIgAP
         Li9WXou/jpDs2+kMaqYNDcO+XvGFOAt+J5tCKPMxHYwfuBUpN723iCWOGOh3PYK0NrvM
         XIaKlaB/umOl1VWlL1ltj0Q+UMOeFM+sbuFdLzhQPNcrBLedUMBYv6JGUtuXnVU+c0II
         rbFw==
X-Forwarded-Encrypted: i=1; AJvYcCVb69pSOTEm11za0i3X8onWj74fWvqomw6DwlLGKso0sZKrDsxB4Vimawk5vJ75PBLwT8UTH1QPaAsaEga0EUJSk6i7VJzXGuPDeW8PNAFVLJUPzm58tx1tWx2FxX5HHk1yMuUZEsK2sY/0ONmA7hSTcdLPhDWdD1r9/M8X3/B28w==
X-Gm-Message-State: AOJu0YweWRrLtXd2PRL62P92pWTcM9k/JMQnd4XBhokenkO4+QyNYuXj
	mpVGevvUN7c34jnzqMibb9dW51IhJcDt40QHTgR2UzEQcBXuDp7i
X-Google-Smtp-Source: AGHT+IHepfrYpaX65+ik4OEnU45itbvufBQzHVsM6FY/Wg3C/APHbovBLqE+i03qVnVLFuRjB/dd/w==
X-Received: by 2002:a05:600c:46cb:b0:422:1609:a7db with SMTP id 5b1f17b1804b1-4221609abf4mr14442965e9.8.1718047870691;
        Mon, 10 Jun 2024 12:31:10 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421c20e9f51sm49262825e9.17.2024.06.10.12.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:31:10 -0700 (PDT)
Subject: Re: [PATCH net-next 2/5] sfc: use
 flow_rule_is_supp_enc_control_flags()
To: =?UTF-8?Q?Asbj=c3=b8rn_Sloth_T=c3=b8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 linux-net-drivers@amd.com, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 linux-rdma@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Louis Peens <louis.peens@corigine.com>, oss-drivers@corigine.com,
 linux-kernel@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
 i.maximets@ovn.org
References: <20240609173358.193178-1-ast@fiberby.net>
 <20240609173358.193178-3-ast@fiberby.net>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <07b7f432-bb9a-1285-2431-0f5d2232b0eb@gmail.com>
Date: Mon, 10 Jun 2024 20:31:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240609173358.193178-3-ast@fiberby.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 09/06/2024 18:33, Asbjørn Sloth Tønnesen wrote:
> Change the existing check for unsupported encapsulation control flags,
> to use the new helper flow_rule_is_supp_enc_control_flags().
> 
> No functional change, only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/tc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
> index 9d140203e273a..0d93164988fc6 100644
> --- a/drivers/net/ethernet/sfc/tc.c
> +++ b/drivers/net/ethernet/sfc/tc.c
> @@ -387,11 +387,8 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
>  		struct flow_match_control fm;
>  
>  		flow_rule_match_enc_control(rule, &fm);
> -		if (fm.mask->flags) {
> -			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported match on enc_control.flags %#x",
> -					       fm.mask->flags);
> +		if (flow_rule_has_enc_control_flags(fm.mask->flags, extack))
>  			return -EOPNOTSUPP;
> -		}
>  		if (!IS_ALL_ONES(fm.mask->addr_type)) {
>  			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported enc addr_type mask %u (key %u)",
>  					       fm.mask->addr_type,
> 


