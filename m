Return-Path: <linux-rdma+bounces-4933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4214977AAF
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366581F26FE2
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A61D589D;
	Fri, 13 Sep 2024 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGnWTNde"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6D13BC35
	for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214931; cv=none; b=nC5a5g+j4TCdP5akCk3XJBi53yygYTumBER8tyagrrBFdE2kac8W0gidhBYOPHT7uv7clg9uk2pOQCCtMa8V6iv/rmUBfIqklm5+YAI+Elg6mx8jazXrJ0301B5bQ315TSB0UZ4kHFRR0xYzRv6sYBNQ0PFm7uQsW861EVPy/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214931; c=relaxed/simple;
	bh=Kb1pdCDBc1ztrK0C9ktnpi5ehDB1wcFepzBGqMqmlAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BiqinDBQKrfo6GFbpWY3Fzh5tLsPzeNisIE11LXpGFQqrIopUoPb/wwZ+5uZtsRuzJGFXwR9ge40yjgquFYuWSkMg4nfvPJCwct9jAV+Asw6Yqrgmp6hQ5Ck0984R9/kKCtE1RnjN/1O2jOnzOsZ+VlxNy3LhqRLckR3onRDmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGnWTNde; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so482521466b.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726214928; x=1726819728; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpYKZqGPnYRm+/CvALmF/DXxnu7KajYpKH3FK3s8lUc=;
        b=TGnWTNdeh4vODfj/n63N9juR4Lq7+eoCkT+k4w3u24XhQ0inr6FcNF6/OQlbngScG2
         FBmkmYAtjMzLb9+L3YmZ++5lP9MS2oH/gRSBfrgzh6C7NYcR5ZE/kyNo4E/tozzzKVKQ
         2ObQuZUVoECHgca3tHz326ST4xpk/BPd0/T2w+DqkTUYHoNednQbpytbqgpHX3Bh8Wth
         fanWKEYVY4iR/U73x+G/YG8ig6khDqbQEgVHf0DmtnicTxrEg4u8sj5izXE60PH1QTMQ
         LWSxq4SsQWte5AGXn0plVsZEtpiNqgQjBZYnBUCrPvZ4v17cuGIz3NkwVa1JaRbqEx7/
         ogLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214928; x=1726819728;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpYKZqGPnYRm+/CvALmF/DXxnu7KajYpKH3FK3s8lUc=;
        b=bk2bZ79ytqhlOb7Va45dkXHRRw9nPA5EqNKD0HjkqjUmISmC8Ba69Xddc8HMGtgcC7
         kLEFOjOkucc1aQNnurXyj8aBrEOc598QMMPPQUDAI5g7IXruehhUjla3vO3LPdT5EiFR
         2SuoqJCGTaqNcRM7xGQOT40dPrNuS3ME23F2Onz7dSpNEEv2XohfiptSh9cLfBFReZq7
         7MpKgx45Nmd/4NNaBwn76AcV1QMFPqgRNjX2eMxFDyOz39IK17RZwZ+bD9lAANryZIak
         sN2xmIna4Bz+iRG8P7eYbpAyzfCLxoYOJxsb7s0O9HWsHYA8UjmWDjWvbmKhj7aOoHAu
         cQ8A==
X-Gm-Message-State: AOJu0YyRnYVILvrjtR6L1q4txD4/hBXTr1Sz8lgvS+V0SkGNlLL5CaO/
	NnywYrB0ShEH00kSbqRLMXszWKYfeFoBnQEIORJsRsQgGuoQJDo4tUXJaSdybec=
X-Google-Smtp-Source: AGHT+IFd2jAJNjS7c1WbY9wX0XfFjdN7D7kayPITVA6PcfX2yOBwHyf3gDlh1YI+TJXijn/OyEoYag==
X-Received: by 2002:a17:907:1ca7:b0:a7a:8284:c8d6 with SMTP id a640c23a62f3a-a902a8c4dc0mr565369966b.24.1726214927656;
        Fri, 13 Sep 2024 01:08:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65396sm840640666b.217.2024.09.13.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:08:46 -0700 (PDT)
Date: Fri, 13 Sep 2024 11:08:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: HWS, added matchers functionality
Message-ID: <f8c77688-7d83-4937-baba-ac844dfe2e0b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Yevgeny Kliteynik,

Commit 472dd792348f ("net/mlx5: HWS, added matchers functionality")
from Jun 20, 2024 (linux-next), leads to the following Smatch static
checker warnings:

drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c:970 mlx5hws_matcher_attach_at() warn: should this return really be negated?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c:492 mlx5hws_table_set_default_miss() warn: should this return really be negated?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:754 mlx5hws_rule_destroy() warn: should this return really be negated?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:758 mlx5hws_rule_destroy() warn: should this return really be negated?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:770 mlx5hws_rule_action_update() warn: should this return really be negated?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:779 mlx5hws_rule_action_update() warn: should this return really be negated?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c:36 mlx5hws_bwc_match_params_is_complex() warn: was negative '-E2BIG' intended?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1848 hws_definer_find_best_match_fit() warn: was negative '-E2BIG' intended?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1934 mlx5hws_definer_calc_layout() warn: was negative '-E2BIG' intended?
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c:678 hws_matcher_bind_mt() warn: was negative '-E2BIG' intended?

drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
    954 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
    955                               struct mlx5hws_action_template *at)
    956 {
    957         bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
    958         struct mlx5hws_context *ctx = matcher->tbl->ctx;
    959         u32 required_stes;
    960         int ret;
    961 
    962         if (!matcher->attr.max_num_of_at_attach) {
    963                 mlx5hws_dbg(ctx, "Num of current at (%d) exceed allowed value\n",
    964                             matcher->num_of_at);
    965                 return -EOPNOTSUPP;
    966         }
    967 
    968         ret = hws_matcher_check_and_process_at(matcher, at);
    969         if (ret)
--> 970                 return -ret;

The hws_matcher_check_and_process_at() function returns negative error codes.
The caller doesn't care if we return negative or positive.

The function doesn't return E2BIG but it feels like these warnings might be
related.  The hws_definer_find_best_match_fit() function returns positive E2BIG
and it's used in mlx5hws_bwc_match_params_is_complex().  I guess the worry here
was that something else would return negative -E2BIG and the error codes would
get mixed up.  The E2BIG error code is not super common and I would not worry
about this personally.

None of the other callers use the E2BIG error code except for debugging.  The
possitive error code gets mixed with negative error codes and all non-zero
values are treated as errors and eventually it results in a NULL return.

In terms of future proofing the code, I think mixing positive and negative error
codes is risky.  Eventually someone will write an error check like if (ret < 0)
and it will be treated as success or someone will pass the positive value to
ERR_PTR() and it will cause an error pointer dereference.

    971 
    972         required_stes = at->num_of_action_stes - (!is_jumbo || at->only_term);
    973         if (matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes < required_stes) {
    974                 mlx5hws_dbg(ctx, "Required STEs [%d] exceeds initial action template STE [%d]\n",
    975                             required_stes,
    976                             matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes);
    977                 return -ENOMEM;
    978         }
    979 
    980         matcher->at[matcher->num_of_at] = *at;
    981         matcher->num_of_at += 1;
    982         matcher->attr.max_num_of_at_attach -= 1;
    983 
    984         if (matcher->col_matcher)
    985                 matcher->col_matcher->num_of_at = matcher->num_of_at;
    986 
    987         return 0;
    988 }

regards,
dan carpenter

