Return-Path: <linux-rdma+bounces-2130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDB88B4BF5
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Apr 2024 15:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16261C20DFC
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Apr 2024 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1196CDB1;
	Sun, 28 Apr 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYUDiD57"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1E57319;
	Sun, 28 Apr 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310486; cv=none; b=KPGvIqCR55Fvi/GR6o5ROQqLocV0A8yQK1XW4LjIouJUl4JkI6j0fYsgCCL6Tu8MuLpoLOnZk3t2hXTtwK+z7FBiOrM2bgYiiDcm6JJqXtEyGzjyu0OjxdnBgWJ38npt9/JPynmL20V6jRbPwFJLoAHXaqyHFrpJc+d+NRXqYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310486; c=relaxed/simple;
	bh=T9UgbFIxtuGRTh7RRAwb/tlZK9lL8ZDCIfTZ0QDRj90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQdiMH5b0/8LiAMDg9x8dO0aTexIXyMvXyg82GQDMWwyLvQCNIv+A1XsIisewsHs1fd2K3D2K5rKj3aCbINSOS6xrfRyOHr/3VU0Fpah3CCMpgTqGsAJsbYCmWz5JB9hFgmZ2/tPg1Cim9gPryP04Dap7EpMOCNcZKMktD/GY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYUDiD57; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba5592so12756775e9.1;
        Sun, 28 Apr 2024 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714310483; x=1714915283; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mk0xAJRKGdf3mnaL/xD5z7vnwhZQd/fRzuvJDhr3cTE=;
        b=MYUDiD57zjrTQqeIIIGa5KpTldgFZJ1zs5S6TDqcQQ92cAsYGjhOfsqMWEpTwJmRzS
         zY6xNVLF+qK2EJszmFkZLWl3dNhbzYX87pERQkUVKVjZF0hb8f0naN1ESOxrIh3RPzrc
         Owkt6pKHa/iel7M6fObqqj9G14ZARN/5QYnr03f6vv2Bsk9WtWsZ9hxPjLTBd5NmGSK6
         7y94OVe3jEEAe1jEMw7M8hhlvKVV3HO2svqvUsYrq/9hLRksWX8WAYmoUxXAlWzTb2Ek
         EUgcexIvi7VfC5t0OozIH06Nd7f0q6vOYkBSfVhqDlYvpgqSSLz4NfXpiTvB0Qp8tj1h
         9drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714310483; x=1714915283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mk0xAJRKGdf3mnaL/xD5z7vnwhZQd/fRzuvJDhr3cTE=;
        b=LeVxanAcCqfQKl6b51l1exCbmBKJTM6vlYbiY0sM1rbaQnHNknmEd9D+SjmvRCKMql
         pCpF2SP04lLBoOt1vxOGNc9xs+2vzhoQw3fty5xO00KbVV+JX+96qS7ZsBOsOZHjCA3/
         yZ18tM5xo/6CpgZh+jRXtKHRWRclQUPsvPnjQ+BLfoCQbue2sRJ8SJcdQrD6zoTCev2g
         cXY8EvSSK9dZXTDwOAFI64zHfwpNVOkZjm9ixG8KoEge1aLrAZIK4urX7dzw/QDkUeH+
         cfkyp7jx4dsDW2DgzpCWL78zgYmXkF27aWBKzTIYyARi0fVnuLK8w1CmdHQVVE6lLo2y
         wCDg==
X-Forwarded-Encrypted: i=1; AJvYcCVTydLLRGiXqcpQ5htbpbVfanWzmnEV7oeOZQ3O2K+E32nywWlv1F6Llqc9Oq9fdCRCM45vD+WT7YKOhDE0QzKTxNPoV0pwbkDC0cMG80VVblnCQVo9+2atWPWm7UGjy/jONv16JXIjAw==
X-Gm-Message-State: AOJu0YxwXBYuW9Ad0NAkkDb6ZEOLXYX4Z8hRC7pDP2necwsPOM1Q2Kji
	cC4X/7jTuR0pl0n6Vr4Jtubgp1eldIE6LMz6l8vDmVqBQjqIednrmuf0wqs=
X-Google-Smtp-Source: AGHT+IEk1ATaZjPyaMywv/5ElADAWElQfPo4Sf6yJYKqRfzoIKdFxQfiPvwTUfpqHq8pjo9cUwWHCg==
X-Received: by 2002:a05:600c:4fce:b0:41b:7c07:cfeb with SMTP id o14-20020a05600c4fce00b0041b7c07cfebmr6442322wmq.40.1714310482768;
        Sun, 28 Apr 2024 06:21:22 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id bh18-20020a05600c3d1200b0041bd920d41csm5493628wmb.1.2024.04.28.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 06:21:22 -0700 (PDT)
Date: Sun, 28 Apr 2024 14:21:20 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: edumazet@google.com
Cc: kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5e: Remove NULL check before dev_{put, hold}
Message-ID: <Zi5NUDItYAyDGdwV@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Coccinelle reports a warning

WARNING: NULL check before dev_{put, hold} functions is not needed

The reason is the call netdev_{put, hold} of dev_{put,hold} will check NULL
There is no need to check before using dev_{put, hold}

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 8dfb57f712b0..f23d7116e6d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -68,16 +68,14 @@ static int get_route_and_out_devs(struct mlx5e_priv *priv,
 	 * while holding rcu read lock. Take the net_device for correctness
 	 * sake.
 	 */
-	if (uplink_upper)
-		dev_hold(uplink_upper);
+	dev_hold(uplink_upper);
 	rcu_read_unlock();
 
 	dst_is_lag_dev = (uplink_upper &&
 			  netif_is_lag_master(uplink_upper) &&
 			  real_dev == uplink_upper &&
 			  mlx5_lag_is_sriov(priv->mdev));
-	if (uplink_upper)
-		dev_put(uplink_upper);
+	dev_put(uplink_upper);
 
 	/* if the egress device isn't on the same HW e-switch or
 	 * it's a LAG device, use the uplink
-- 
2.43.2


