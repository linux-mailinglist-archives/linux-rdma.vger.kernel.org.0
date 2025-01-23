Return-Path: <linux-rdma+bounces-7211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18881A19EFE
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 08:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D0B1639AA
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 07:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CA20B20C;
	Thu, 23 Jan 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EFkqSsMM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B9179A7;
	Thu, 23 Jan 2025 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617591; cv=none; b=iKDAnX/oMc8NwoD9jp7Yik+qTMGpwCoPKkECqYH6DlUPTqXTlH6LKNwNt536MWjDNLD1B3q4VbuSXqgMVFVpYVJEoTzvTZYe2q0BAXrZMLWgSHXl0TdMDYw92n82JU2qOMF4U7qHA4HafzCbeba9ZMiz7B4hbYuQFCRp1M7V/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617591; c=relaxed/simple;
	bh=VgZ6NpiJIBnOImn9hg7EpJtXzuG0hqCcxpeAx/83DGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPw1qIGLgj7eJHN2ubCFly561K0z/DIh2aelKvLCmktEqAwPU5UiY9Rd/tXfRw4hlD61Kuq8jVWbRAL9EeELhgMEo3DnsikxpgzKQ+xLfhYW7Sghv2ca0IjlhagwlMNgZQYeWYWwES7htXYHfUvXm1LpFlEFpG6h7TYs09oqu+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EFkqSsMM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737617586; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=VgZ6NpiJIBnOImn9hg7EpJtXzuG0hqCcxpeAx/83DGU=;
	b=EFkqSsMMESJ61Y+71C2oLESm0t9h+WHbiNghTaD/0OU2G3PN7ifrYpYCUB/tTCsuBhccmTKyyHc1cq6SDmmaRkybSrZ08Zao1MHCa8tqIO31ueBumgmv5HpjzEXsJoYQNo6/4gIxHjR0YQfW98Xump2Ff+1BISChQKM1kGgYZSA=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WOAr9.D_1737617584 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 15:33:04 +0800
Date: Thu, 23 Jan 2025 15:33:03 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, sdf@google.com,
	haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/6] net/smc: Introduce smc_ops
Message-ID: <20250123073303.GR89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123015942.94810-1-alibuda@linux.alibaba.com>

On 2025-01-23 09:59:36, D. Wythe wrote:
>This patch aims to introduce BPF injection capabilities for SMC and
>includes a self-test to ensure code stability.
>
>Since the SMC protocol isn't ideal for every situation, especially
>short-lived ones, most applications can't guarantee the absence of
>such scenarios. Consequently, applications may need specific strategies
>to decide whether to use SMC. For example, an application might limit SMC
>usage to certain IP addresses or ports.
>
>To maintain the principle of transparent replacement, we want applications
>to remain unaffected even if they need specific SMC strategies. In other
>words, they should not require recompilation of their code.
>
>Additionally, we need to ensure the scalability of strategy implementation.
>While using socket options or sysctl might be straightforward, it could
>complicate future expansions.
>
>Fortunately, BPF addresses these concerns effectively. Users can write
>their own strategies in eBPF to determine whether to use SMC, and they can
>easily modify those strategies in the future.

The series looks good to me, except the name of smc_ops, we should come
up with a better name.

Best regards,
Dust


