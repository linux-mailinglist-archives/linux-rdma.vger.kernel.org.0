Return-Path: <linux-rdma+bounces-3360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0190FF90
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B1B2821AB
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1919F49A;
	Thu, 20 Jun 2024 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e62eO2wS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7A19DFB4
	for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873440; cv=none; b=Z+0nnnBwRP9djbmv9BzLO50EqOogFcVCpcP9+ZqK89OcaHwusd1eFCHzfIUxSbcRr0Arr76TmDmMdzrTNL2jBCIyPaJtMHulRmXah6eTs/3cj6G0rd8zI3vx1eBst2BJuz2zg9HgTg6z3MjbM3QANDX/rlt8CDyDeEdh+LWjsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873440; c=relaxed/simple;
	bh=VulQHEs65tf65CzuYJcVfJOkIehYs9N/s9FN9lgO/DM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NlSwfgrU6hE3W0a97bHKw27JvRpuuNmFh/Kdn19BM/ta65Nk34a+cdWZ9mMglncqecUvTS6zW3mVzEOjoyVZjYbt05G8Qjb36C2w6OMGcmwWfEsQUICB02hpdKrnoW1JR4Vu24MEHGEkFJoBBotydzJvUYr7OcPefwns8gQqCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e62eO2wS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a63359aaacaso79928166b.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718873437; x=1719478237; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nV4oQSHDMhtGV5YD3g+WGCVhVZtTpBFjfeRKuMKFWs8=;
        b=e62eO2wSc5RQbpUfFM9Rmohk3KGgkHSNgYODu7iQscGyZaMqjsHEz50Gsjn4vYTCHZ
         5u+6phWmTm06dgz6aw03Y/bFnyiLFuXDZY+Aq9EfPVBRENl9AL4u2QKKdS/i75+CjYJx
         v2ajYL/25/vwLbqetcL8krKJacWs3RfzaeVoGvSzbr1/ky4mqyTITxBX3NXiIHuv1LLc
         ICK1cilVbB/GyNWaXF9PBD9T9N7gY62hdWFQmBk2sXpQ1+0AwwBIicfe17TjC+wPeG77
         J8Prn/u/YehijvFjXWP48jDhiUVqWRJPl68dDNawHc/XQ1dm36GKhKfHSvL6OrfddADz
         wB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873437; x=1719478237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nV4oQSHDMhtGV5YD3g+WGCVhVZtTpBFjfeRKuMKFWs8=;
        b=KONkqTBgF7GWi1+G8bnm7FOFZd7dGN6aRctyQc++DPL5WZo6UdfD/UU7x13eO7LOAp
         KpRrsz2pDJiqwN8uSfdN6yPS+ANfpwgX7eesoaP5ZwTZOmKv74uuTQkRNrF5XtNCj0zT
         iMXMTqTjHkHwjJir15cRq0kVhyJH7qJOx2tHFiqubFQMvSfc7CsEmuI7R1NpT4/ff+DS
         p10CNugCparbxeNYZ2Eoho5B53qXfeqyxXMO6QlBPjfXa8MrQvpVNQ2hnUxOJrFUSZgj
         N6wb20YD2EXgCGqc2qTKiMRJoW7Iz4Y6KfJTNO+TYsCIXv9u4Uzojk7c/I1pXwfuTyIL
         lMJw==
X-Gm-Message-State: AOJu0YxdIIpiiyYZZOpJiOFR8gN92ytQJ9j5YQb5MCqkxtLOj6oNpVh3
	iWMrFCLQiTaBF6FEeslBYMtz7ET+yCiweH6jv8N9AAgunK27Vl2V/zBz228IfyedA4PnZv4soz8
	8
X-Google-Smtp-Source: AGHT+IFYQJj9DDXRrmYeZlAut878Z4V5ELqYgn0kedSaaqZ6gNWrJVL+n5t8caM1HN1cjHuKcl8N4g==
X-Received: by 2002:a17:907:9717:b0:a6f:51d5:ef0d with SMTP id a640c23a62f3a-a6fab775691mr315556466b.60.1718873436999;
        Thu, 20 Jun 2024 01:50:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5c3dsm745580566b.55.2024.06.20.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:50:36 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:50:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Implement CT entry update
Message-ID: <74076270-8658-4773-aeac-e99d11acea7b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vlad Buslov,

Commit 94ceffb48eac ("net/mlx5e: Implement CT entry update") from Dec
1, 2022 (linux-next), leads to the following Smatch static checker
warning:

	drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c:1163 mlx5_tc_ct_entry_replace_rules()
	error: uninitialized symbol 'err'.

drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
    1142 static int
    1143 mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
    1144                                struct flow_rule *flow_rule,
    1145                                struct mlx5_ct_entry *entry,
    1146                                u8 zone_restore_id)
    1147 {
    1148         int err;
    1149 
    1150         if (mlx5_tc_ct_entry_in_ct_table(entry)) {
    1151                 err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, false,
    1152                                                     zone_restore_id);
    1153                 if (err)
    1154                         return err;
    1155         }
    1156 
    1157         if (mlx5_tc_ct_entry_in_ct_nat_table(entry)) {
    1158                 err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, true,
    1159                                                     zone_restore_id);
    1160                 if (err && mlx5_tc_ct_entry_in_ct_table(entry))
    1161                         mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
    1162         }

Can the entry not be in either table?

--> 1163         return err;

If so then err is uninitialized.

    1164 }

regards,
dan carpenter

