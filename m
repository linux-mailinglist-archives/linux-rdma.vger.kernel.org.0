Return-Path: <linux-rdma+bounces-1448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966B87CAB1
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CF61C223EA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078118027;
	Fri, 15 Mar 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA6i7aap"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452217C6F;
	Fri, 15 Mar 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494925; cv=none; b=q+d8mZ1zi+xs5Tx8vC9aeB8kzrMeOu7/4zA28v8OtD38Ng+n82Qa+J7mXB6I6clpZ03jUjebzUqgY4YBhBepo1L3KwhrvzKcLu6/3Ueg+w8rtBbdJOGh/1RGWWS/yjev0blVXqEbvkv60nJZasBsTE7nCrolIW09w74Ziog1YkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494925; c=relaxed/simple;
	bh=0M+s6FikwHhrPesVLy1FInqzB+lvAfTTtTj2bJfLm5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qe2NB8R5X45E53rcmBmnaLqrHF/Z/OKLWw+6hAv1AfTFmniXdADpXhs4MTXujCrJZTo4TpJuphsnZn4pDn9yWm2gliR+C56uDL+pOTbJt4XMCyF+tFZeBPTTV7nPa7MUaTYRXGmuh+WlPIr8CeQwsCOMtvkG7zu8jnrplQESbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA6i7aap; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6ca3fc613so1738323b3a.3;
        Fri, 15 Mar 2024 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710494923; x=1711099723; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iUpnvg2lJInUyXSwQRwOqYpvq0Q7ZeBFhxpnTWBCyk=;
        b=WA6i7aaplKL/fvIc4g+Hf68jjpeykHGFqgV1f9yvZ5bUGJgJ12/pSyEjBoKuLEaqk6
         nddOEfNGlvlVOkXZ9bzTEteZEj3Oadn2o2ESdu3zKAACYQTMyChWiNxGgSIngs7ymMS8
         8+WkghRDvR/VHslXXTjSz0ckoHDNku+YeevcLCzwNKLUe4e3UWYeZFBaVuoJDzCL7/1X
         yaio9T5YwLlU3dmF+gNxtWxxWhpbtoP7gCI68+ptnEneag45tteysbaieGXnWA1A4LdD
         14hOd6BpIwnGYOPepwdZDLWyBv8gGmlbjiGkGJkEDU2bOieHQE5YQ3011/UhpeW5dKQp
         PxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710494923; x=1711099723;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iUpnvg2lJInUyXSwQRwOqYpvq0Q7ZeBFhxpnTWBCyk=;
        b=HITg7ZMZwuFGB8bEhK0lMQfO73mNZXhVRV7xsKQgZBns09rFgGe39eAv0Cv6cLn6JX
         nERbLQxmsSzc8jStiSuRuDPeLGKd/g1ZqfXjfxQXbZCsbUvKsttcGIzoWtKk209weQsk
         5rmXA8RNmIpZgjC4vz54kFUP+I/ijFrcTBP96z5+HoxNLLw0ZIC7JyHIawhD78b8nuZp
         JAIH2Y+gEnNALioJHizChgD3jjhJ/YOVDnTo0JaKlM5VRU7HTo4sKmyzDS8mS0nh4k7G
         IV8gfKUAnb9PP7YdPgVCpzCl8k5rOxI928nbPWbEq31Qi1xBEN6y6KjA3NJRiVvUsXjQ
         viQA==
X-Forwarded-Encrypted: i=1; AJvYcCVmNI+1psvaAXRrFMcxNLbGM2x8gT6+AbZ/ixyL3/zLzS6zl/VLlwOEO0tBHA9vIQVkF8Ib8EwtA17xt0of4TZEzXM4F3pwn5sDwj8XiNtUf2OxerqxfckQMPlyGJxQf68Vw9C/ASpSr4LVwN6xGzhBbaCqepOpdQEtrT+HTY6BxQ==
X-Gm-Message-State: AOJu0Yy3ppKbBrLAtTxZE9rdP6hhtXqnk2TIQ3uZvXy8MKh9cjjdUTzg
	dcHt3QSaDCc0Wg6tAp7BHg8YMcUvm9HEyo/Dkg85Ya1KSfxrEZNd
X-Google-Smtp-Source: AGHT+IEbZiJivklD5Du4nOd9Fchv3Tn+hjYAhIiufc1/ErBMEyBY7PktqGyChTs4nu/q7ti60Xacmg==
X-Received: by 2002:a05:6a20:4327:b0:1a1:8ba0:2845 with SMTP id h39-20020a056a20432700b001a18ba02845mr3047631pzk.29.1710494923132;
        Fri, 15 Mar 2024 02:28:43 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id nt10-20020a17090b248a00b0029c7236637dsm2490885pjb.5.2024.03.15.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:28:42 -0700 (PDT)
Date: Fri, 15 Mar 2024 18:28:38 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: [PATCH net v2] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
Message-ID: <ZfQUxnNTO9AJmzwc@libra05>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

acquire/release_in_xmit() work as bit lock in rds_send_xmit(), so they
are expected to ensure acquire/release memory ordering semantics.
However, test_and_set_bit/clear_bit() don't imply such semantics, on
top of this, following smp_mb__after_atomic() does not guarantee release
ordering (memory barrier actually should be placed before clear_bit()).

Instead, we use clear_bit_unlock/test_and_set_bit_lock() here.

Fixes: 0f4b1c7e89e6 ("rds: fix rds_send_xmit() serialization")
Fixes: 1f9ecd7eacfd ("RDS: Pass rds_conn_path to rds_send_xmit()")
Signed-off-by: Yewon Choi <woni9911@gmail.com>
---
Changes in v1 -> v2:
- Added missing Fixes tags

 net/rds/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 5e57a1581dc6..8f38009721b7 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(rds_send_path_reset);
 
 static int acquire_in_xmit(struct rds_conn_path *cp)
 {
-	return test_and_set_bit(RDS_IN_XMIT, &cp->cp_flags) == 0;
+	return test_and_set_bit_lock(RDS_IN_XMIT, &cp->cp_flags) == 0;
 }
 
 static void release_in_xmit(struct rds_conn_path *cp)
 {
-	clear_bit(RDS_IN_XMIT, &cp->cp_flags);
-	smp_mb__after_atomic();
+	clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
 	/*
 	 * We don't use wait_on_bit()/wake_up_bit() because our waking is in a
 	 * hot path and finding waiters is very rare.  We don't want to walk
-- 
2.43.0


