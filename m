Return-Path: <linux-rdma+bounces-12423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB4AB0F1D7
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 14:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB051895750
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9382E54DF;
	Wed, 23 Jul 2025 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UllcB1D4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B132AD3E;
	Wed, 23 Jul 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272259; cv=none; b=se/EYmhD0qed0erbyysi5w/JYeHhP6qQrHC4pbFnPMGY9ATWR+r4opQyQrC8SQMEr5m324CRAuZXggJ1IHsN7tFGjiQ7s3BiC5sYOIqolK5O0eaKsxewwL9FSjuYucSIESqRlQKmlSWNYVg4MjOcjslLiv8LlSN9u7OQyj+zm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272259; c=relaxed/simple;
	bh=wwvOed4AiyIpZRV0tXtWm2hLLOZaO65VZ2Oh5cV3zvI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Qxmkk+iYQ/unaUDoDJ8wkEWxEEy0dz8B5DckZR4pE7zKrB+vAKoZSi2EqZ7Mz5k3s73eIpAviuuM0TKuZNjc8OrOIUNgDT97eMP3R0HfA3sBVTJlRoS6Dno/LjRzCrfyttLWmEUOiDja4TDjvALoUCneCYPIVzqbp8kS/0EmbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UllcB1D4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae9c2754a00so1118159166b.2;
        Wed, 23 Jul 2025 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272256; x=1753877056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=velNThWNzCVL50HpO0OOnaoFk16wgTpoe4CXm5vwClc=;
        b=UllcB1D4k3Hlcrc9gEDnyvKx8ZU1NIohqJhUXIZ9E0n3flF2BwKS1k9hWDgQbf206u
         N7TSGM4M9tYyZtU3Yo9C4kj+DEgr4BBKHbL7t4zaRCIKw721EMe4/8vWWtGTkpN1v2P4
         zXfSvBy9sQvgnZ++ZhckAkZUoQtqeIeI+RrELsEoNdr2lx26ObDysyZ6WEx17jC5d0I+
         +4eDDjP+tsn91qV49TujRSoyfO/M7u7u9MxLYFMsE6VRBXc0KkctBOJ79gOT9iYBnbEO
         ToeVg+7eOE+2CJVLJWNr2z/YAiVze8s022/Qw8jHBCEuD9SBDGIF0w1f7/PLr04ZW92t
         3t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272256; x=1753877056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=velNThWNzCVL50HpO0OOnaoFk16wgTpoe4CXm5vwClc=;
        b=eE5tgrs0p+pZGs2gmu335Suevl/OpwQBIkjDoummm9rl4Ajp+Kw8nW2s9GxZxXomDr
         LBA8Z0rVu8lRdEJWcSfvXkKDOLVtLeJb3/kbYfptDTzeI/PozCrKilzEgNgN2F/3iAiI
         1n+UaJlNOL1IXAjy2s65QXJ5dXUq8ez/XHHYU6XMYoGe0LQrFV/kP6SRc3qZ8gdBwmy7
         JhL8ZDm0afNDUbiOgJKjRcooYDfslLJiC1KqQ8PhtJ31DEqLlLGquBTpqUFIwu7PKW1d
         fAVx/ESMZZCY73HIHqLjF0q1NWW62DV+xA43y/f2zek+uhGBLIdhIfI+6YogEa9J3TUj
         urLg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/fcSEt5SPhJasFj+U7KtIQntLz5pFncRaqC9eishiUdX/X52byBZ07gLWpI+y3lovmusY65/v98ORA==@vger.kernel.org, AJvYcCWcNWMzQ0BVLbiJwZoloi+kqfM6pCRy95Y5pVspDQBIA5B+CYbwAtk3c0QnHyD/m32gMR9DIHbdwaj6hgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjmKBN3Q6Z65ivHmRrZyEfG5Zybi3Wjub+qQcxmftK1jY3sGWx
	GlF4bgRhfxk3NxDDvNYLATmNd6akdD208fZZWhcvvQAGqa2XWQT7wO415KrcciuN+tOdTmM3NC/
	a4yIK7sV5AQFS3QV5QjwhoQpitw3Xwjc=
X-Gm-Gg: ASbGncvXwmpBTQjMYkp8QchPbVxTNqX1EHAFj+G+BrafChbme5mwzDJjuY3WUbxNPZU
	G/QTqJPl+WdjLqGt/UMzjGw/Gx1aytTJMzast6U6M1a7IEQtvlXDfaCzTsI28BA9knWNSKSEwSJ
	/eUEi2zgCfKJ3uGFor8t6+N2aiHLZXNE3ddGihhE1b42bjzBi960sHLSooQUXI1cymTtMB4dPxo
	0p9ZGIY
X-Google-Smtp-Source: AGHT+IHhEPs4iHRKYQeRICabXf1ERltK6sNXU1YXjcCDKLZbj6UWTz4u+Q4+yp8vBgqsfjexE+MQ2oL4zJ/tIO6zVO0=
X-Received: by 2002:a17:907:1c92:b0:ade:433c:6412 with SMTP id
 a640c23a62f3a-af2f66c05f0mr231926066b.3.1753272255076; Wed, 23 Jul 2025
 05:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hc Zheng <zhenghc00@gmail.com>
Date: Wed, 23 Jul 2025 20:04:02 +0800
X-Gm-Features: Ac12FXzg_F6i03IIPmSBMY0-i-b566lIJkbYl7GaJn_czywc_aaIzeZMqWl60Xw
Message-ID: <CAHCEFEwToeQe_Ey8e=sf8fOmoobvrDCPsxw+hfUSoRawPX03+Q@mail.gmail.com>
Subject: [RFC] problems with RFS on bRPC applications
To: andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, laoar.shao@gmail.com, yc1082463@gmail.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I have tried to enable ARFS on the Mellanox CX-6 Ethernet card. It
works fine for simple workloads and benchmarks, but when running a
BRPC (https://github.com/apache/brpc) workload on a 2 NUMA-node
machine, the performance degrades significantly. After some tracing, I
identified the following workload patterns that ARFS/RFS failed to
handle efficiently:

- The workload has multiple threads that use epoll and read from the
same socket, which may cause the flow to be frequently updated in
sock_flow_table.

- The threads reading from the socket also migrate frequently between CPUs.

With these patterns, the flow is being updated very frequently, which
causes severe lock contention on arfs->arfs_lock in
mlx5e_rx_flow_steer. As a result, network packets are not being
handled in a timely manner.

Here are the case we want to enable ARFS/RFS:

- We want to ensure that flows belonging to different containers do
not interfere with each other. Our goal is for the flows to be steered
to the appropriate container=E2=80=99s CPUs.

- In the case of BRPC, the original RFS/ARFS logic does not help, so
we aim to steer the flow to CPUs running the container, as close as
possible and as balance as possible.

One simple solution I came up with is to have another mode in addition
to RFS, eg: like rps_record_sock_flow with a fix interval to avoid
frequently updated, or add an interface to allow usespace to dynamicly
steer the flows. This mode would steer flows to cpu within the target
container=E2=80=99s CPU set, providing some load balancing and locality

I have written some simple PoC code for this. After applying it in
production, we noticed the following performance changes:

- Cross NUMA memory bandwidth: 13GB =E2=86=92 9GB

- Pod system busy: 7.2% =E2=86=92 6.8%

- CPU PSI: 14ms =E2=86=92 12ms

However, we also noticed that some RX queue receives more flows than
others, since this code does not implement load balancing.

I am writing this email to request suggestions from netdev developers.

Additionally, for Mellanox forks, is there any plans to refine
arfs->arfs_lock in mlx5e_rx_flow_steer?

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5a04fbf72476..1df7e125c61f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -30,6 +30,7 @@
 #include <asm/byteorder.h>
 #include <asm/local.h>

+#include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/rculist.h>
 #include <linux/workqueue.h>
@@ -753,15 +754,21 @@ static inline void rps_record_sock_flow(struct
rps_sock_flow_table *table,
        if (table && hash) {
                unsigned int index =3D hash & table->mask;
                u32 val =3D hash & ~rps_cpu_mask;
+               u32 old =3D READ_ONCE(table->ents[index]);

+
+               if (likely((old & ~rps_cpu_mask) =3D=3D val &&
cpumask_test_cpu(old & rps_cpu_mask, current->cpus_ptr))) {
+                   return;
+               }
                /* We only give a hint, preemption can change CPU under us =
*/
                val |=3D raw_smp_processor_id();

                /* The following WRITE_ONCE() is paired with the READ_ONCE(=
)
                 * here, and another one in get_rps_cpu().
                 */
-               if (READ_ONCE(table->ents[index]) !=3D val)
+               if (old !=3D val) {
                        WRITE_ONCE(table->ents[index], val);
+               }
        }
 }



Best Regards
Huaicheng Zheng

