Return-Path: <linux-rdma+bounces-1290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F5873740
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 14:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD162819DB
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E5312FF91;
	Wed,  6 Mar 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeoYSGEg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50612C53E;
	Wed,  6 Mar 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730270; cv=none; b=UB144iJRizG2P5iTAnkaOyvIueHObv41fHQhRh9Yrl6cIz4Wmd8hDysI+778kdBLifDrCMHXlpVsxQCBCms4usfXWma1cDpTCNKC7SjMjfoIVviSwkwLSNLUPYWTqAg4+GpP6d/1B5LEq+DqdCCYRrqhN/coanYu4nMOdJG7POc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730270; c=relaxed/simple;
	bh=oWbbAKz8OAncLr5FWOMFnVa5VV2/teptQ9RNn8P0D0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KZhcUJmcVkHa05pVuJa+hpmYpVROnURq6H4FP16DZgiXpBO+rGMmt0RRhIWEmpZnlVh8vivm0v+ShV9ih5J0sxwv8pxX0bEvv8Q/qYq0Ig+kyBrytRe7yB10eKDGdqaxltO+VPOfKiDtZVGju2lZnr831aPqrXG2DGZ0QFE9AYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeoYSGEg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc75972f25so57018975ad.1;
        Wed, 06 Mar 2024 05:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730268; x=1710335068; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJjn+W7aRnDwu5CPp1KqUqPbvZzC2jHrQpWLfXT/NpQ=;
        b=QeoYSGEgIlLj+nR34E/LFMg+rHx2zuRFzLv4bD1w/FdIYclhl88YnvrARBdqhwkTmD
         m4epeJInJ1IA9kGAoo/nwoNHj4GRqzJwa8q6MF79nt+GXi4B3J6RbYQ/ZVwDia4WGFki
         V+r8rDhiYxT9flskkYz8Ia2uCv+KlY43DYB7yaxYPwG6ksKqZSp4Mq1TeQOuifAPjzHk
         grmw/0y5VaNO0Hn2E21aaNSz/G0HWCP9hiZSTsrCTtKhbat5pIYybyR7QkV74MCg2clP
         eo24cRIeMmIjfLI01MtG1McRZAXQZQNkMCIlsSUSkeTsCYklkCRZXaP89irb4MnBJgr3
         dBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730268; x=1710335068;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJjn+W7aRnDwu5CPp1KqUqPbvZzC2jHrQpWLfXT/NpQ=;
        b=qfkcx272vRv+5WIQcWAgQo8xiJI6takKhAm4wJijbhiOPATzyoP9I/7kI2ZSbln9eZ
         yl1L6NdUTFv1XI+Pcvw7APmJkhGoLCQjcTUuLATB68KDqD9teHEgUlSSvv4tBV0iI+1D
         FijKNX2VATtBepSCms2JnSPTbeqxz6ocO2om56dYwYwg07UwjWu93Li8p0maqi4GVZga
         3WTfZjrXSIxP3mhdEOMaZhvgErSnkjNeVyQZMpIBhWRlbDuafNcAR9gXX6+e4uXHSxNr
         KXBjwwOfwAYigFC4KPpGw7Fa6Jk7TJgyhrid8X3dib2QoG4Q6Zh4xp5TcRG1ArlOh5vK
         eojw==
X-Forwarded-Encrypted: i=1; AJvYcCUMIMV0TNxTvXzsXRVR/AYz04vSvzkbrMFR1wVUY3aAy6eZGzrq3Fw6yZypfcZ53HL/xn8CJ+AjNqopBM/g6lqDaXJ7VrOyH4fT+atD38A3zljzBZ9u0L4FgHGMcPMXyKIg274RSqp5JZ1UsTjneTdnJmrgSUXSjEK+nUC0v5w+dw==
X-Gm-Message-State: AOJu0YwVXUbZSKv8vg2kMQZZ/Yv+IkMdQR86gr9A+qXeeLWVwuAFG26O
	iEunBB78J5QncBKP/HbLsRQVbsovgyZVfK1/qhY1zSDixHEFunG4
X-Google-Smtp-Source: AGHT+IGH6JUJsGBC7iPQxVJk9IwgBv85RBiowSBrhaQBEF/LB6WLVVP6ng9PPa2ghQPx4xOvvHp0eg==
X-Received: by 2002:a17:903:41c2:b0:1db:e453:da81 with SMTP id u2-20020a17090341c200b001dbe453da81mr5522844ple.29.1709730268265;
        Wed, 06 Mar 2024 05:04:28 -0800 (PST)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id mj16-20020a1709032b9000b001db519cb710sm12534459plb.246.2024.03.06.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:04:27 -0800 (PST)
Date: Wed, 6 Mar 2024 22:04:23 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: net/rds: Improper memory ordering semantic in release_in_xmit()
Message-ID: <Zehp16cKYeGWknJs@libra05>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

It seems to be that clear_bit() in release_in_xmit() doesn't have
release semantic while it works as a bit lock in rds_send_xmit().
Since acquire/release_in_xmit() are used in rds_send_xmit() for the 
serialization between callers of rds_send_xmit(), they should imply 
acquire/release semantics like other locks.

Although smp_mb__after_atomic() is placed after clear_bit(), it cannot
prevent that instructions before clear_bit() (in critical section) are
reordered after clear_bit().
As a result, mutual exclusion may not be guaranteed in specific
HW architectures like Arm.

We tested that this locking implementation doesn't guarantee the atomicity of
critical section in Arm server. Testing was done with Arm Neoverse N1 cores,
and the testing code was generated by litmus testing tool (klitmus7). 

Initial condition:

l = x = y = r0 = r1 = 0

Thread 0:

if (test_and_set_bit(0, l) == 0) {
    WRITE_ONCE(*x, 1);
    WRITE_ONCE(*y, 1);
    clear_bit(0, l);
    smp_mb__after_atomic();
}

Thread 1:

if (test_and_set_bit(0, l) == 0) {
    r0 = READ_ONCE(*x);
    r1 = READ_ONCE(*y);
    clear_bit(0, l);
    smp_mb__after_atomic();
}

If the implementation is correct, the value of r0 and r1 should show
all-or-nothing behavior (both 0 or 1). However, below test result shows 
that atomicity violation is very rare, but exists:

Histogram (4 states)
9673811 :>1:r0=0; 1:r1=0;
5647    :>1:r0=1; 1:r1=0; // Violate atomicity
9605    :>1:r0=0; 1:r1=1; // Violate atomicity
6310937 :>1:r0=1; 1:r1=1;

So, we suggest introducing release semantic using clear_bit_unlock()
instead of clear_bit():

diff --git a/net/rds/send.c b/net/rds/send.c
index 5e57a1581dc6..65b1bb06ca71 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -108,7 +108,7 @@ static int acquire_in_xmit(struct rds_conn_path *cp)
 
 static void release_in_xmit(struct rds_conn_path *cp)
 {
-	clear_bit(RDS_IN_XMIT, &cp->cp_flags);
+	clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
 	smp_mb__after_atomic();
 	/*
 	 * We don't use wait_on_bit()/wake_up_bit() because our waking is in a

Could you check this please? If needed, we will send a patch.

Best Regards,
Yewon Choi

