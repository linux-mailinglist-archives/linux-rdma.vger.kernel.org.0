Return-Path: <linux-rdma+bounces-22999-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TqsBANPZUGof6QIAu9opvQ
	(envelope-from <linux-rdma+bounces-22999-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 13:38:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4B73A558
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 13:38:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qD2N9F7R;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22999-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22999-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 293CF304BE5F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D24041C31D;
	Fri, 10 Jul 2026 11:31:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A74189B0
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 11:30:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683057; cv=none; b=g7F7shTpiLjrQHVeH3fdTRgOniwa7f/7Ql1B1gT6fWxjJoorYWfHAdheMBSXRb2zQLe4grZ9BQIMumfT898lx6wN0pSjnU67jf/uFIjytWtG96XPs+48GBB0A530vu13EbnFPQXF4tikafLgnt4JJHjTO2eayCtx7+cKT36idQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683057; c=relaxed/simple;
	bh=Qbb46OKsgQnkKpDn9I8rASSB7LcjVPIfL4+YTvrcdy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eryC7u2AdG6Zt6NaUV2mOwLydGuKmiXFKAk8wF/TKyrKpJar1fWdvRDFGDfU8+MB3rF0Qi07YrEr1Zo4R0+QNfqxKJKhkoY0rJ1RG0k5OOyGPJz0+uwin9kcpX9TByVqQ5i58OYRBVfHdFLjiBfz4aYJ3YwVRR3tmHNJQYO0Pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qD2N9F7R; arc=none smtp.client-ip=209.85.161.46
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a38e41d0b5so409973eaf.1
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683046; x=1784287846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRQ5aArdbJpE84yhnAHgkZKWabXQmvRjv8HbEbLKGcY=;
        b=qD2N9F7RqHhyxaatgz0bZQ4FbF6h14bMdXRLhsXXXs5t1c8qmTlwmoU/H86ZptbX4N
         0avVnZt2jAbp2OHtms7i/yTgswKyNBycDOPcCZnYcEiJpZp+tUgvpWOwOszE2VuA2eZu
         siAvaAbHlP3lQT83I9N1/AH8W5qgilinq8UN3QQR7277Fh51F4EE3X2oQ124GeD4QVIZ
         J/T9x3pW/l6wbrFOEsq72A2E/ByFuQCQcI2SpHAuUkjIElQ2FlULEiVJ3llrNkDwlr2n
         bFlast+CIZNJ5n5ZK0SRWJ/6Qy5GkWZ/ZNWz+N5p+TrtuesFBgmhFb7m84X0CbO6ZiuE
         VSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683046; x=1784287846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iRQ5aArdbJpE84yhnAHgkZKWabXQmvRjv8HbEbLKGcY=;
        b=dGbRP1bOwX5F7U5qRXieK20dDHav1BIcAZoUzkYtDc72LfqyrMDUrSmz6w06KujDsT
         qnTjCTHm8dsZe7gCnP0xtcHEhzEteoVdnIQZgai160+hRLPGmFbEfaeFCsBTOyIqXvgi
         P/vIyby9teWs5/CeGUQL+pIMah5OwjhR0riEAvcTvWEiPCU5XCGscW4hmBdhxcTQoTJd
         Dn39d87TXl3Xhans15a845tf9J2y9QVeDecIzYOp2vJYvujvuTf0vHD2XlBe1YBD1ICR
         koZHzHN3MMjaTDpfC4KfWBk+VEs96az4XTFZ4uSqZUKYl9C/0UdckUOivm+9mLveOJbY
         07Qw==
X-Gm-Message-State: AOJu0YwwLyVlT8RjMIlmXA7Y8Q3LbmoekHVNJJHzrjVpKMv7FxSze2yz
	F5Bd2bw4NIEntUR+Ept5qNCDGgltYvEbOwuGuHydoaopLTC+sMXR79WJ
X-Gm-Gg: AfdE7clpWZaT9fdXFz2KP3CZHrxhF7ddWoHFXc3ChudWz7slaeTSiigYjKtQINn4uk0
	XEJW+OqlHPCRewdZpKRwdchKPFuqw3/3cRXr9pli93eADqLym7npd+bISF8jbtsyO7bKaBOgduL
	dOtkqlAekokW7gBrAEZ6jlBOf1JdhdQdrbM4vEqa2F0CRxh2YFLaYVzfP+BxfEIgEp+WfhEqC9o
	lQyYUD0768u5NuCuyu6FeYEGg9F/eiyA4nokUk1e/e0ofAzYBNxgjnLm8JU3ee3HycKCfq8fAqJ
	/tnqKOOh1xr3WcPcPA+/hvMjiHR77fHJggEnvRK0YUXb0+aaSRl/TXpUyxyQ3rhs2ZVrrZDVY/s
	oEVtiHPhpJAhgsCkpkp13/JuLHxb8W6f6Z53ThGRCPsaMP1Bbf7b0uPfIBb2Dhh1W5WgNNaIzaP
	sGJXCa
X-Received: by 2002:a05:6820:3414:10b0:6a1:3d69:1a79 with SMTP id 006d021491bc7-6a38ba52cecmr1022179eaf.0.1783683045668;
        Fri, 10 Jul 2026 04:30:45 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262db2sm6191418a34.16.2026.07.10.04.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:30:44 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:30:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [bug report] net/mlx5: Change TTC rules to match on undecrypted
 ESP packets
Message-ID: <alDX3hoJMMWcasUy@stanley.mountain>
References: <alC-NENMq3PjalQV@stanley.mountain>
 <0104f0d4-060f-4554-ac60-3db4bbb519c5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0104f0d4-060f-4554-ac60-3db4bbb519c5@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jianbol@nvidia.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[error27@gmail.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22999-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49D4B73A558

On Fri, Jul 10, 2026 at 06:04:35PM +0800, Jianbo Liu wrote:
>   Thanks for the report.
> 
>   This appears to be a false positive. On every failure path in
>   mlx5_create_ttc_table_ipsec_groups(), mlx5_create_flow_group() stores an
>   ERR_PTR in:
> 
>       ttc->g[ttc->num_groups]
> 
>   The helper increments ttc->num_groups only after successful group
> creation.
>   Therefore, when the helper returns an error, ttc->num_groups still
> identifies
>   the failed entry and that entry contains the same ERR_PTR. It remains
>   unchanged before the shared error label calls PTR_ERR().
> 

Ah, yes.  Thanks.  I should have checked...  :/

regards,
dan carpenter


