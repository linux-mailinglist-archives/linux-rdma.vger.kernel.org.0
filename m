Return-Path: <linux-rdma+bounces-16419-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDaxL/WngWm3IQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16419-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:47:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2533AD5D15
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3F6304652A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DF392C23;
	Tue,  3 Feb 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKlbkT9S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002B2BDC10
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770104811; cv=none; b=s2R8uSU01hJjI29U9fRCWf3WHk9OeV2Evje+2RnZdkmPgnC0Al7k3FBhcVc5W+CMimCaNxD2ANa5AF4+RsVRlTkz6+irtp/5905gKUlnHupvqwN/wlIZ0MYIsZ6MkH5x1B0DFnwiwRiV1tQc0rjMZOMAw9f/a3ynpUS9/AFfKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770104811; c=relaxed/simple;
	bh=YqYAreQX8QOIBsbcGRZYoptlZGtCtOSOjEwtli/peCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qC+NxfAl/DSk29zxALKn9MHhTz8/lkYgmeDXgwd5Oa3WnpBCLGhqe5k4IpKvfH2KwKe0O3/ANqygeJVr2O+xp8jQ1fYQo/5s5mYReJ6ygeQpZCEb5L0mNRwE96eZ03gWJtGkvli8fzuC0l4GV5+REQKFDrQhUreS3F4v+MoUfn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKlbkT9S; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so40121235e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770104809; x=1770709609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BDxwZcaCiPrmsb5H2h19MNPah9MwJIns6XdvcUbLx2o=;
        b=eKlbkT9SrTq35bVEGWaFIqedRcYDWD6pJ191R6v4tvBp1LxoEDMLvXhjVjMLorZyzs
         ai8litmwst9b7vLMk5EB05sUJUMQiltPMnIHWSbUJJ/JEGkT2/6/dX/rYk/8miyrSdgg
         qnqzB44LLP+UeFS+vBWPKYTH+lw1ELMW2xFyGce+hT/yVJ5cR+PRMivUZUkYOsOLIprT
         UjdKtTrPhs1ejlwdt0FcCuQ2bx4XB61zC86Vq1nySIQedJHRr5MdMv53dXGEdpHNIhAR
         xTi7qzsnUyprxIIRrMX+J/6HY6JiWYjW18fcPYuWYQ7Ia4XCLq6S8B732BTAogCxJKv7
         p3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770104809; x=1770709609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDxwZcaCiPrmsb5H2h19MNPah9MwJIns6XdvcUbLx2o=;
        b=B0kqUpnxITWUDZ+DNVAFnyAryklJ9Y7GDoOk57DM+aBHCkTrmNa3Jyz2eW8SmUHzn6
         3M81+Ix/Du7qX4v5JfzhPZ6tkxVoKQGN0yydRRsOaDN1Ezx3oiLl0oGoIfp+RAo9QI2r
         86SUrtaLCywPeGm5xSoNcfKJHm3GYkHsf/QuHRwcGr6RjMJk72wkjNuKTxCwjEmyq197
         RGERKAZsBPeHasQimwWC2Z4DX/jJugecedo9230TcITPz+arKixBRF0qRGFS+WvlfD5e
         H/a+UJagG9XwY5AHvVUEyK3AuidsGKIXl62zV9GbyHB2MSAkDEtO/PKfoxa5xZuw5Rvp
         bwtg==
X-Forwarded-Encrypted: i=1; AJvYcCW2za6zbNQDjTl3nIRnF4xJL93ZHY74SECX9AZzHvaCXS+8DjFxsamJne1/yMcTWJFVDkvWH1PymCzu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjb03/nMUCRe1JIhIhPVs6uBo5MxRVNDG8/G2JL/EjPMNKPLUG
	KG4qqOxWs2iXXwIh55utpjkzdkvwthP005OERdHlOVRuuI2PLwR1GINO
X-Gm-Gg: AZuq6aKYykm/JWKXrEK7lBtogFDOJ1358ERfvdfvKwXUw9dcrqqRg+tRqSP/AAh8jmZ
	QbgeaU8dALd7MIUvwXXUL46o0nK5FTVcspr29QwlXP+izB8C3zcIRuUt08a/IuzhN+Ua4xEmfAe
	JjC22Q8SUofFbuV1W6WfV0o7n0rd2OjUMwYv3Yi7AqQe9f2oCpZaZRi1fQd9JTGyirNY0ixwcPs
	wGrFsTOQmLCxMKtAbKqttm54a4pia8KDsWjHSKamQxdjXp7hvaEsBFD+b19AusII4pWb+2hOd8t
	+wbOVTYDLsPmOXzyb6YhP6ay04J7lrVzCOZjWDtLgWOb57326Ok/Hte8OdTJjdMr3hb2JFw9l9X
	TWgdL3KGw1QRCpRIWrXGkrLLA7VqQrocGQZLnQR/UlpA0rilCIhdRRrfDAci4Oy5c8xbgmZD+Gd
	CQNM/6mDY/1ooT5aiNVC1k3ALn8/+dR0HBH90=
X-Received: by 2002:a05:600c:34c1:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-482db491eecmr184540555e9.33.1770104808423;
        Mon, 02 Feb 2026 23:46:48 -0800 (PST)
Received: from [10.221.207.115] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e25444c0sm110626035e9.8.2026.02.02.23.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 23:46:48 -0800 (PST)
Message-ID: <8df3e409-5e5c-4e11-8618-d7aca640cd33@gmail.com>
Date: Tue, 3 Feb 2026 09:46:47 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Extend TC max ratelimit using
 max_bw_value_msb
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Alexei Lazar <alazar@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260203073021.1710806-1-tariqt@nvidia.com>
 <20260203073021.1710806-2-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260203073021.1710806-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16419-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2533AD5D15
X-Rspamd-Action: no action



On 03/02/2026 9:30, Tariq Toukan wrote:
> From: Alexei Lazar <alazar@nvidia.com>
> 
> The per-TC rate limit was restricted to 255 Gbps due to the 8-bit
> max_bw_value field in the QETC register.
> This limit is insufficient for newer, higher-bandwidth NICs.
> 
> Extend the rate limit by using the full 16-bit max_bw_value field.
> This allows the finer 100Mbps granularity to be used for rates up to
> ~6.5 Tbps, instead of switching to 1Gbps granularity at higher rates.
> 
> The extended range is only used when the device advertises support
> via the qetcr_qshr_max_bw_val_msb capability bit in the QCAM register.
> 
> Signed-off-by: Alexei Lazar <alazar@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Please ignore this one.
Mistakenly sent two similar patches (with a slight subject change).

Find the other one here:
https://lore.kernel.org/all/20260203073021.1710806-1-tariqt@nvidia.com/

