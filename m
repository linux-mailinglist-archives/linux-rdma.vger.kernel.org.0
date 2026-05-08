Return-Path: <linux-rdma+bounces-20249-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCJMB8z9/WkdlgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20249-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:14:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6B14F8751
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1CE303FDF0
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7F3FB07C;
	Fri,  8 May 2026 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwrtcv0L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BD3FA5CA
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252500; cv=none; b=VXH2TVlAXuW3K77pZ7EjlqTCPndv/GT9o5nXEJrs5lWRDbojNh+X1TuvfM1N+EsXZgVysbRpRJzMAylglAuLFfIAJmmQP8pbfJfsi5STctoCjzArfOkRCfrRTDZiK3kvXp31MnlWhGlR0vJF1KW98l6tTBv2I4/NrFd7vfUyCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252500; c=relaxed/simple;
	bh=9/t/hUMZJzNMH4RVbdJbbZH15OTzwSdGifx4D0PefWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WktlVyZzO1r+CyymNhJiSXdYonGsjAAOECcTtu6eRV+5AB1Usvd1iueLMNxHUJbS7vT9CgcrMDcLeq9onHofuyTVU+nTeHd/VYqxDiby+jyAy3jbO8OnmY/XKRxGk/TiPKn75oUuU1qi3cxdqfiviLLZoiboub8ayZw1qDUGKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwrtcv0L; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so924286b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252499; x=1778857299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j5p5DIVFbvgg+WGkwfocupb7aWHhDsZHNXCf6IHkDw=;
        b=qwrtcv0LXEIx8rCCicFAexqLv2BoxrUwNPWaK/3Ygzu4ERWPqmO80wV/OX+t24E3mI
         qtMK1pto0nicCgilFhKxLuLw1lBHY5yOjAFnWENpVmcgiQSbLXMS4LS/vcy7+AIfPXxb
         l+J4sTLrnmODq2yqFRlbvWcw2EoEBUnsw2WcHR1fsHEC3juIHGTgy/6UTwqPGGFE48nE
         cX/87Ob+bCJM3QFUL3BqkDEtE2wteyCnAxIkUGkbf8CrEA9om5Pdd/wH3a7o0kTrjBJg
         R+rFDUzD+kQ0D4DdlQDF9f9YBPo2Q4OWk0Lm5qUHRorREp2tlgqNMqen8FcW4lAUF2bT
         kqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252499; x=1778857299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j5p5DIVFbvgg+WGkwfocupb7aWHhDsZHNXCf6IHkDw=;
        b=Ax/Lq0PWggmNWzeQ90ZeMVaiY5O1/qx+NBoLF6jDODpKGbVyPifTsHF0k5HM1OqYXC
         pwXWEKHsAcilae77teo9PCa20XxiqPh5Xkrgkc1gHZ1XvcsmhHJyMpYyVotESCRx9tnx
         MG0wufkkpefzOJYExYly4nEQhbJFhU+2fGr3Q5FkKpyaWL2TTGJ3/RTZDIAtFi2RX1Q7
         F9Q4Uz/hcHjLm1zUkn1r+0upTbCMvCHa7bXoh+aQ4GeG6v/u3nbCMUekjOa/TD/eOo/I
         ld8IUy4IyaRieho799KbtEFoGn+Qqby5QnjiV3aPTPVFD9ZzAy5cjiinfPd7lYJ42d2d
         K5VA==
X-Forwarded-Encrypted: i=1; AFNElJ8mspB3hFQN6QS4dGLAjkHwXMlb4zbn01PZLEaNwKnzFVNWHMQnG9Xmho0NHbtV1Au/O49ZEbsQHIdA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4o2Atesar63esYO3gDnt21/bJeqiYLCqcILfzM+PVWQkhCtd
	jwvs9jZ1LAHmnK9pI1x5yyJJdyjLD/NsmDSRAP43Z0oyWnirpOcLXp/K
X-Gm-Gg: Acq92OFNjdbII93+uwo8b/r+myQaBKsUyx/04YLLnjWsRm70rlU2V0V9JHWFr5kwy7h
	Eejco8hLHg7NiySIkxjBAtBRXDpwONvS82AiU6JofEtSoSt2LiQM2FkqeGKv3ghYaWLnXjS0oz9
	6e9T1bBUB3U146x4N9JWeB8Ij6vOJmKMpqSt79cD0zAfM8Ixrs+xbflkdVGyOrLX0xmbufeBszS
	Spz63+V+t6+GrFeZ0VAsOGyYoM9B1FnGa6ApmQ8SJ63F71bZxgOJisQBsK/Ugq1FluVPvS6SWYO
	qXYO117MmDUxxJ1j3Gt1wuMO/wvmDX1uSNc7JfwBafdDaGDf9Zp2+2ygbICHsbnNyx0XEaNsIfF
	G8Dn0gizNU++4k7JIMDrajyhazdMAYqxt9THAuQQPYoYXGyK0xUTLHL+lAvu4jUKcdf/CqS0FIh
	bqiXiUQnypJrKuyXnK
X-Received: by 2002:a05:6a00:39a5:b0:82c:2205:507d with SMTP id d2e1a72fcca58-83a5dd5bc34mr12224762b3a.36.1778252496977;
        Fri, 08 May 2026 08:01:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d35b3bsm11676274b3a.24.2026.05.08.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:36 -0700 (PDT)
Date: Fri, 8 May 2026 08:01:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 4/8] selftests: drv-net: ncdevmem: add -n
 flag to skip NIC configuration
Message-ID: <af36xtqCzGOGF2m-@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-4-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-4-52821445867c@meta.com>
X-Rspamd-Queue-Id: 6E6B14F8751
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20249-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add a -n (skip_config) flag that causes ncdevmem to skip NIC
> configuration when operating as an RX server. When -n is passed,
> ncdevmem skips configuring header split, RSS, and flow steering, as well
> as their teardown on exit.
> 
> This allows ksft tests to pre-configure the NIC in the host namespace
> before launching ncdevmem in the guest namespace. This is needed for
> netkit devmem tests where the test harness namespace has direct access
> to the NIC and the ncdevmem namespace does not.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

