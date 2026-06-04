Return-Path: <linux-rdma+bounces-21743-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XurrJM9UIWpHDwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21743-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 12:34:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354063F14A
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 12:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=exDGPqj0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21743-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21743-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769FB3086DE5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923E63FDBFB;
	Thu,  4 Jun 2026 10:28:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A643DBD7F
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 10:28:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568887; cv=none; b=ePwTeu9v+NbXGI0/DaAhhnonRzhNOMRi2l6noWRV4l/H/NtStf5eIEOhlkZjhn4PgpjGYDoG+E8FfoTjh2xDKlU27x3Mw5zzjHn5Z/G3ugt7Co95ccSRlCSBIHMkXF6t54x0vzoYblFPmp4QOaaBmYvxg2OaLDzwHkH+RI3isAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568887; c=relaxed/simple;
	bh=oMtqOQxNjkcERZglMs7zo0ZlH33zEOOZ2kexP+TnDpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQFTlgAC42Yzrg2hrLM9VQLwcbWI+aSkveJgBpgCPGi7JgbgG4OZmJSecjikEg+QH6kJNvrRJqego/hxvw7LlWEE959uGRaq1TFvF7KJeUsNLpnG3jPsLrCiDpKCI+ZbaKsvupPKPO40oNRpJyqstUG9Ws+/ikP0e+J5A3QK1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exDGPqj0; arc=none smtp.client-ip=209.85.208.170
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39664fe2dd8so4244341fa.3
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2026 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780568882; x=1781173682; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mpuJtba9gSbXD74y6+nVmAeSa/BqOkgQ1Q5Z08hTxo=;
        b=exDGPqj00pjDF8iJiSmjpWuooEicD57M7pqsXR2K6yDp80sbwyNIwIS2NZpj2ozPhx
         pK2JQyFljAMtihQXr6UOSOGH7IcKknPg3tm4zPGhXjF1JaA9sTIoifS0oR7bfhFJK59f
         g6IkKHOjEREvZlKMXhVX2yc42gCv/FJrIMSJJ1DmP7gIxMhZZS16CktgiDAtUsiNiw4s
         MIdUdwj+h9OBuAWrLLgwGIh0y34lhXQhgTPk3XXkGQOisneD7K5rh/L6nm+ep8HDLMXI
         9ZG42BYBUMNpwS85jC4uJNzJV2tXo/OqnHmq4M6GUTlb8g1v4oLL2I8OJOhT3z0r+NNY
         1y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780568882; x=1781173682;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mpuJtba9gSbXD74y6+nVmAeSa/BqOkgQ1Q5Z08hTxo=;
        b=l4V63/VaIg6v0+KSemsFkdHVrRM3Jx4lMvETZLYdEJkbpIv99opO3SWxqmjiKqEXcK
         JNh6sqRS++mOXmyJVXKoT7hGhU6SWU2NHNKYkOzkqjUf7U6jcNHS5JYSzzzviVHM/9j4
         2J5hcn0anwPOa5IitVukZQLf32I370n1AdTSjq8vnlHaZ8GarFlluDRk/yDT0T1J14jO
         UboUDbZGL6D5FYns7WWbYQ0qxrkdSZ2OOybvNhcDCiLMKdVuADV8oHztxwCTivFjZZod
         VjL8k94P6MD0BTvJbhNgx8devbjAR/uxp3TS137pmYclZMMKhHcKYYaUbU5gMSGVSTEZ
         Kz6Q==
X-Gm-Message-State: AOJu0YzZlbNFbG2rqBDdRMMTnhabxt50VIi4iZJl9j1frzYfrZcYaNUi
	f4kYNxMvF+bxccjq8QhiyeRX0PJwUN9Wj7vbVo1P2V1EKJzuWtcqGSe7
X-Gm-Gg: Acq92OGcndeXeRDLZ3kDp/hG+Nzmzh5sb1AzN8U0s0w0q3g7XVTwVfZs+qepGvQlKiN
	KZmYoE7Q0Apibu4SqHcwj3fuE6ZOSJk10VhHDx4Sy1lgcGhCSldOV308ANhhRA0b5BxUf1i87H1
	KNFVCDjMzyy/6SU+fi0FdQAPxs06pmTFzyjrnKAKKpoGrR4tJRi+GCnvXR+N5k0MpmBu1ZeEzid
	LTC0cJAU6YDPixPukaZEplv1ARayl4WWTxZkk9pmniJlFBxPEgnLHc7AKDwqTUTulxUqfxVGvdj
	lb9a/CG1kP1aZ/pBdWIE0qxrzDBMZdLOgrdSrukXqdHyp6jDS8Bi1mY6ozC1YkcK5daY/Fq4iXZ
	TzFfbU3PRiqcIvc+Ur1QycXxeiD9qC+F2LBnJEuEOYfB8pvTlyuGjmC4PumZ0eQF9Z8Q7MMC/BB
	903tXXkPisq0q/i1VZRJ3J57jIt3xURH/TyNQ=
X-Received: by 2002:a2e:a9a4:0:b0:394:3e27:53d4 with SMTP id 38308e7fff4ca-396af1ee15amr24953911fa.7.1780568881782;
        Thu, 04 Jun 2026 03:28:01 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2be2absm15157121fa.23.2026.06.04.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:28:01 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 9A5965A004A; Thu, 04 Jun 2026 13:28:00 +0300 (MSK)
Date: Thu, 4 Jun 2026 13:28:00 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>,
	Jacob Moroni <jmoroni@google.com>
Subject: Re: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
Message-ID: <aiFTMNYnDiUuoBmq@grain>
References: <ahjB87k54bYdFbft@grain>
 <20260603181636.GB1568873@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603181636.GB1568873@nvidia.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21743-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.czurylo@intel.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,m:horms@kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1354063F14A

On Wed, Jun 03, 2026 at 03:16:36PM -0300, Jason Gunthorpe wrote:
> On Fri, May 29, 2026 at 01:30:11AM +0300, Cyrill Gorcunov wrote:
> > When we generate completion for SQ the opcode while being properly read
> > from ring buffer is ignored when written back to completion. Seems
> > to be a simple typo.
> > 
> > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > Reviewed-by: Jacob Moroni <jmoroni@google.com>
> > ---
> > Hopefully I didn't miss something obvious here, found it while been
> > fighting with unrelated issue.
> 
> Applied to for-next, thanks

Thanks a huge, Jason! What about the series https://lore.kernel.org/netdev/20260522142239.628965142@gmail.com/ ?
Guys, could you take a glance please?

	Cyrill

