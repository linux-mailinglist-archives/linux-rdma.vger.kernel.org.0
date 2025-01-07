Return-Path: <linux-rdma+bounces-6862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012BEA03749
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 06:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15C1164AA2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 05:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43441D8E12;
	Tue,  7 Jan 2025 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LqhmNJoW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8911C3BFE;
	Tue,  7 Jan 2025 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736227206; cv=none; b=NaP+g38z+RqOGneTFKJ/Vuvp6NdYdti2sDM5BXPISC9PF/HSRgOZdlRhhIkUMyEx0S2kVWbS5b9xGmEPjVVmtgHgv5ne+GUUcoseGCeHtCPldrMmhvFW11g8r9dKcKuL1a3dU97/Zt3uSZkwEtM8qsRa4CwbV0WVEWB7ohBEo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736227206; c=relaxed/simple;
	bh=l9LRCPd6kPZxYnV8C8VofIGcdHCR+APRO/kEn3n+f+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RknoFcvBvdcDG+GZJ5UWhv9tdByvjOt2SYMW/63TN1gTxENyRWuOswcyvlowaKXOdswAFtKyctp6Op1zjeg6wVve2bnrGnpB/hr7ZYOcMia+cX6MRRbxTbPoWtZAVozdTh9QqBZvjJ5zGJJLz9+bFqe/kUYlr3t5nPtdqmmte58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LqhmNJoW; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736227195; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=yuJBriVJi0KuqVFuWsnWI+gEzoILkUqMe/INho+uiro=;
	b=LqhmNJoWMJMaOZrY239ZDPEcFY27bHEgr5B+VbcS20q4TpuKkr3oodUMOvw0LBlY8YkLEjk+78AcYSC0/vjlhURwLQgEIqHpvvYnxE46Z9XWzAS3aZFz2TWcw3fpv8vPyydkC4hcABpLhOTRdklKY+5enCEzCknKN/yoW/mlhBc=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WN9SaAf_1736227192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 13:19:53 +0800
Date: Tue, 7 Jan 2025 13:19:52 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: "D. Wythe" <alibuda@linux.alibaba.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	sdf@google.com, haoluo@google.com, yhs@fb.com, edumazet@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 0/5] net/smc: Introduce smc_ops
Message-ID: <20250107051952.GA16826@j66a10360.sqa.eu95>
References: <20250107041715.98342-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107041715.98342-1-alibuda@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 07, 2025 at 12:17:10PM +0800, D. Wythe wrote:

Hi smc folks,

Given that there are almost no more serious issues blocking the progress
of this series in the BPF community regarding the BPF part, your input on
the SMC part of this series are very valuable.

Additionally, I encountered some errors during CI testing on the S390x architecture.
These errors seem to be related to adding ueid via netlink, and I suspect they
might be connected to seid. However, since I have no s390x machine, I am unable to
further pinpoint the exact cause of the problem. If IBM could help confirm this,
it would be greatly appreciated. If there is no time to address this issue, I plan
to temporarily skip the BPF CI testing of my case in S390x.

Best wishes,
D. Wythe

> This patch aims to introduce BPF injection capabilities for SMC and
> includes a self-test to ensure code stability.
> 
> Since the SMC protocol isn't ideal for every situation, especially
> short-lived ones, most applications can't guarantee the absence of
> such scenarios. Consequently, applications may need specific strategies
> to decide whether to use SMC. For example, an application might limit SMC
> usage to certain IP addresses or ports.
> 
> To maintain the principle of transparent replacement, we want applications
> to remain unaffected even if they need specific SMC strategies. In other
> words, they should not require recompilation of their code.
> 
> Additionally, we need to ensure the scalability of strategy implementation.
> While using socket options or sysctl might be straightforward, it could
> complicate future expansions.
> 
> Fortunately, BPF addresses these concerns effectively. Users can write
> their own strategies in eBPF to determine whether to use SMC, and they can
> easily modify those strategies in the future.
> 
> v2:
>   1. Rename smc_bpf_ops to smc_ops.
>   2. Change the scope of smc_ops from global to per netns.
>   3. Directly pass parameters to ops instead of smc_ops_ctx.
>   4. Remove struct smc_ops_ctx.
>   5. Remove exports that are no longer needed.
> 
> v3:
>   1. Remove find_ksym_btf_id_by_prefix_kind.
>   2. Enhance selftest, introduce a complete ops for filtering smc
>      connections based on ip pairs and a realistic topology test
>      to verify it.
> 
> v4:
>   1. Remove unless func: smc_bpf_ops_check_member()
>   2. Remove unless inline func: smc_ops_find_by_name()
>   3. Change CONFIG_SMC=y to complete CI testing
>   4. Change smc_sock to smc_sock___local in test to avoid
>      compiling failed with CONFIG_SMC=y
>   5. Improve test cases, remove unnecessary timeouts and multi-thread
>      test, using network_helpers to start testing between server and
>      client.
>   6. Fix issues when the return value of the ops function is neither 0
>      nor 1.
> 
> v5:
>   1. Fix incorrect CI config from CONFIG_SMC=Y to CONFIG_SMC=y.
> 
> D. Wythe (5):
>   bpf: export necessary sympols for modules with struct_ops
>   net/smc: Introduce generic hook smc_ops
>   net/smc: bpf: register smc_ops info struct_ops
>   libbpf: fix error when st-prefix_ops and ops from differ btf
>   bpf/selftests: add selftest for bpf_smc_ops
> 
>  include/net/netns/smc.h                       |   3 +
>  include/net/smc.h                             |  51 +++
>  kernel/bpf/bpf_struct_ops.c                   |   2 +
>  kernel/bpf/syscall.c                          |   1 +
>  net/ipv4/tcp_output.c                         |  15 +-
>  net/smc/Kconfig                               |  12 +
>  net/smc/Makefile                              |   1 +
>  net/smc/af_smc.c                              |  10 +
>  net/smc/smc_ops.c                             | 130 ++++++
>  net/smc/smc_ops.h                             |  30 ++
>  net/smc/smc_sysctl.c                          |  95 +++++
>  tools/lib/bpf/libbpf.c                        |  25 +-
>  tools/testing/selftests/bpf/config            |   4 +
>  .../selftests/bpf/prog_tests/test_bpf_smc.c   | 390 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_smc.c   | 116 ++++++
>  15 files changed, 873 insertions(+), 12 deletions(-)
>  create mode 100644 net/smc/smc_ops.c
>  create mode 100644 net/smc/smc_ops.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_smc.c
> 
> -- 
> 2.45.0
> 

