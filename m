Return-Path: <linux-rdma+bounces-18585-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EhJJqDVwmllmgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18585-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 19:19:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D731AA42
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 19:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D81C03141BCA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90B3A1685;
	Tue, 24 Mar 2026 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZX/zuI7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D600390CBF
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376010; cv=none; b=ZhuWdzB/qt20RyAIVRTZjlNzd/roxw9PLIZr82cqJzWNn4/Ng2XQ8/yEB/Ss2e6vBMzliicaxJhkTaTWo8OxSrEK684hVDtsp5FdrNb05pjtBRm5S7Ig5j6ips0JjQVJ1p7wRTSXiEjPxQbfqDzPzkYnA60iT39bC5tNTi5WB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376010; c=relaxed/simple;
	bh=QZcNJB1ipbvlJzwc2mSo4w5C22TYRAQkkpmFKA+dYJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFXirDvlcePk9hx7TpUnJdYJNlriQ997Vu8UCCUV5xObpmikXCrIEq1LpTB5ZHbOo1wKUdDKmLXCUH2m9521VS2TZRSXa2i4J9NU4yradgNl5BNLRVC0v0FiNgxy12tv+V/rD+cNV+FnR+NitSw6zvigYNKuJCf/7TFDItrHOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZX/zuI7; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128b9b7e3edso9779823c88.0
        for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774376009; x=1774980809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4KIbqvhidbLdE2zkNvP4L5iPrMq8r7qV66qKB0JP/0=;
        b=RZX/zuI7n2B/ms6ZPA7cXaGVFuHx5NQkCqA+q4tNzFX0foHv9icwAU6QrHOv/1rHLr
         BqOmb0WuFpKcB6pSSLfYUS019BuZGcDupO6UGhRXn5+sG25BlGXJJYiZb0HpWWpC80SH
         8PE2W9u1YMTSdUvjtcMiwurQ33BS3GYN4Iuz5XsGvQ/bWElwF2TSbLjf+u8XBGK11PT0
         g7fRM3eFogeff1ag+phJz72XmlzFeyAVBCVbKfP+dELQsAN2PRoUauWvBSg5SXPUzCvi
         d8f2VFOtBEtRoRlvHhasIyLaR0L0g5GCyzs90EwO/WREDhvicB+aVv4ZBsBSZ5/f6F2t
         rgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774376009; x=1774980809;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4KIbqvhidbLdE2zkNvP4L5iPrMq8r7qV66qKB0JP/0=;
        b=oxpOYbXtB+CybUniT2f+CmCnWVS0B9Gl0mbBwFk1vNl3cr11pRt3RcZV4+t9f25O2w
         iY0BwscuR0JcBj2ZdLw5x86/JTY3EThxP3kGxneumSCcxtz3UxY2+Fc+wYErGz+qJxD9
         DfKtfmmwEJGAaVtOmYSRn5PMA9fdQ5LDcdro+qYvcnsFxUOn29X4ABYCkWTSu/XvUpOR
         U1DQzg3ub757Zht5RwHpBsEQH6jzk5HH5QrotcILk+lMIOEIvK4MYkL7v/JTyANFJ/Wa
         48SODsd+HJNFAjRqN9zLfxSsm0JIeWZ8stOh8pdma/kwBJus3pveTGq5Y+DkjKW4qLuh
         4/gw==
X-Forwarded-Encrypted: i=1; AJvYcCXkR5wTndxajcEQn3lK87LBX1wMA3Wyoh8Si4IABtCdwET66s9FHP9e1Qypofde3O/5WDsh8N+QZs+O@vger.kernel.org
X-Gm-Message-State: AOJu0YweE3hnR0PWn0lmlPESfIc4JQ5YUaxcn16LPvvMMwBY3leBiTKY
	zoA59cX7Wnod2fBe+CwtN1wOx4pVbQ9F4rbWkz7UFdczd2gRDXRkQNI=
X-Gm-Gg: ATEYQzyuTdBrM2tkgH7zvEhddbXO1z9c/Gy7KvME90mjmtlFBAGTpJshbUmRxoKg8Yl
	LKKE+Df0SHEXOYNurvDYwDIe98C+jjrL+cAG2RajD0C+GDX0tmS8qRt2Lr3XJnDYW2nwE9figTV
	kM5kpsa5mQDK8A7eCGOE1tr/YnCbKoB7ED4NEHz9vu4AxKx2Oj8v4s+9CPDsOtvWChtuaXM62iR
	ljy3Emo5cGOzZk+WVFe7Df5k3mcjMpEBg7dCtQKRXCmgFHVBQQstRgFEJOIE6A+t2fnfPypuHgo
	LLwoAAwW53wBtG8+MCZe8ftrvfyNh6x+4lTHYP6CY5cSUxbhegKcr8DHX/rAB6ggYr8YO5YyOIv
	sCutcZWCFlYWjzK3c4jzP8j93IIYUhWMz5pgyJyG2fDfrnXf6uBmT4J0HhLM/ipWrdorvGPnwVp
	CXdmTX6FDgOtp+tNJiptyWmM7yOfm3XQXgeN9HCcEDCshf5GL2Q6N7YOLbni/p3hkHf89k/PXd4
	jfV1YGpnqgUYmi4ew==
X-Received: by 2002:a05:7022:526:b0:125:be41:db5b with SMTP id a92af1059eb24-12a96f200f8mr243112c88.42.1774376008513;
        Tue, 24 Mar 2026 11:13:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b35116bsm18984900eec.30.2026.03.24.11.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:13:27 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:13:26 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v3 01/13] net: add address list snapshot and
 reconciliation infrastructure
Message-ID: <acLURpj2nttA6De3@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, aleksandr.loktionov@intel.com, kees@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
	leon@kernel.org
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-2-sdf@fomichev.me>
 <20260323162053.62a148c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323162053.62a148c2@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18585-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE2D731AA42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/23, Jakub Kicinski wrote:
> On Thu, 19 Mar 2026 18:24:49 -0700 Stanislav Fomichev wrote:
> > +EXPORT_SYMBOL(__hw_addr_list_snapshot);
> > +EXPORT_SYMBOL(__hw_addr_list_reconcile);
> 
> Why?  For the kunit tests?

Yeah, no good reason, will remove!

