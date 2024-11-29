Return-Path: <linux-rdma+bounces-6153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C79DBEDD
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 04:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9808C164AC2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 03:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF001527B1;
	Fri, 29 Nov 2024 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gFBuH601"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EE3C3C;
	Fri, 29 Nov 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732850012; cv=none; b=Rfszx8nOqXj/sW7Xhf1/KrFdNbP1fbHRSQI2QXTTADVUscfyxAQ2gqAKBswP+qOpPhcYJJjmlHHSMJlgBMxfvREyJNk587Jcqo1IIhh3PS4NoEkwUd5lpK3Ht5ZPckRDML+Y9UR6/JjoKQtMjKRSSes+G1GC9VPzRlxHvbLRcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732850012; c=relaxed/simple;
	bh=4+VOq2ixpvyl4tzq3jTq1NH0uR907uyPyKXv6pIDRO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXk4EumhWx8c3lhqqS/osdtCOyyKjOLmlqIYKCHoXCLdRyvK/I4+QLf91meeZBmKdt3cr9bTtCuoFfdBwvOcgaewuu63RYDN5d+j7aPfEgy49tlrpfI7GKV8fzHEqzOPjRIMdWa2MXBRw5JJBD7QHroKqW8AsgucXM6OMwmNZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gFBuH601; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732850000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZS2N9Ztg4oqUGmtvXN2lkocM1mP8nrxwbJEZrWU66EI=;
	b=gFBuH601MmL27n8tRPQLgDTCkpWDbI/qZrLBl4rZx3XZN4FJRg1qAoDvzHRg85Jnow7GDf/GkENrjjFBEjRkGFRBr7zWdUfS++x7ZLOua6Dy+yoPbrzqdcHqG0WTAbcfT2ypRZfFU+jIwyAKvdfuZFz1NvGVhmtHqNEBJtzddA8=
Received: from 30.221.101.88(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKSTgss_1732849997 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 29 Nov 2024 11:13:19 +0800
Message-ID: <a863ffe5-b5b9-4ed4-9c1e-472f49214750@linux.alibaba.com>
Date: Fri, 29 Nov 2024 11:13:16 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: kernel test robot <lkp@intel.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>
References: <20241127094533.18459-3-guangguan.wang@linux.alibaba.com>
 <202411282154.DjX7ilwF-lkp@intel.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <202411282154.DjX7ilwF-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Sorry for build error, I will fix it in the next version.

On 2024/11/28 21:52, kernel test robot wrote:
> Hi Guangguan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Guangguan-Wang/net-smc-support-SMC-R-V2-for-rdma-devices-with-max_recv_sge-equals-to-1/20241128-111259
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20241127094533.18459-3-guangguan.wang%40linux.alibaba.com
> patch subject: [PATCH net-next 2/2] net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
> config: arm-randconfig-001-20241128 (https://download.01.org/0day-ci/archive/20241128/202411282154.DjX7ilwF-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411282154.DjX7ilwF-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411282154.DjX7ilwF-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from net/smc/af_smc.c:27:
>    In file included from include/linux/if_vlan.h:10:
>    In file included from include/linux/netdevice.h:38:
>    In file included from include/net/net_namespace.h:43:
>    In file included from include/linux/skbuff.h:17:
>    In file included from include/linux/bvec.h:10:
>    In file included from include/linux/highmem.h:8:
>    In file included from include/linux/cacheflush.h:5:
>    In file included from arch/arm/include/asm/cacheflush.h:10:
>    In file included from include/linux/mm.h:2225:
>    include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>>> net/smc/af_smc.c:1120:46: error: no member named 'skc_v6_rcv_saddr' in 'struct sock_common'; did you mean 'skc_rcv_saddr'?
>     1120 |              !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>          |                                                     ^
>    include/net/sock.h:376:37: note: expanded from macro 'sk_v6_rcv_saddr'
>      376 | #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
>          |                                     ^
>    include/net/sock.h:155:11: note: 'skc_rcv_saddr' declared here
>      155 |                         __be32  skc_rcv_saddr;
>          |                                 ^
>    1 warning and 1 error generated.
> 
> 
> vim +1120 net/smc/af_smc.c
> 
>   1087	
>   1088	static int smc_find_proposal_devices(struct smc_sock *smc,
>   1089					     struct smc_init_info *ini)
>   1090	{
>   1091		int rc = 0;
>   1092	
>   1093		/* check if there is an ism device available */
>   1094		if (!(ini->smcd_version & SMC_V1) ||
>   1095		    smc_find_ism_device(smc, ini) ||
>   1096		    smc_connect_ism_vlan_setup(smc, ini))
>   1097			ini->smcd_version &= ~SMC_V1;
>   1098		/* else ISM V1 is supported for this connection */
>   1099	
>   1100		/* check if there is an rdma device available */
>   1101		if (!(ini->smcr_version & SMC_V1) ||
>   1102		    smc_find_rdma_device(smc, ini))
>   1103			ini->smcr_version &= ~SMC_V1;
>   1104		/* else RDMA is supported for this connection */
>   1105	
>   1106		ini->smc_type_v1 = smc_indicated_type(ini->smcd_version & SMC_V1,
>   1107						      ini->smcr_version & SMC_V1);
>   1108	
>   1109		/* check if there is an ism v2 device available */
>   1110		if (!(ini->smcd_version & SMC_V2) ||
>   1111		    !smc_ism_is_v2_capable() ||
>   1112		    smc_find_ism_v2_device_clnt(smc, ini))
>   1113			ini->smcd_version &= ~SMC_V2;
>   1114	
>   1115		/* check if there is an rdma v2 device available */
>   1116		ini->check_smcrv2 = true;
>   1117		ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
>   1118		if (!(ini->smcr_version & SMC_V2) ||
>   1119		    (smc->clcsock->sk->sk_family != AF_INET &&
>> 1120		     !ipv6_addr_v4mapped(&smc->clcsock->sk->sk_v6_rcv_saddr)) ||
>   1121		    !smc_clc_ueid_count() ||
>   1122		    smc_find_rdma_device(smc, ini))
>   1123			ini->smcr_version &= ~SMC_V2;
>   1124		ini->check_smcrv2 = false;
>   1125	
>   1126		ini->smc_type_v2 = smc_indicated_type(ini->smcd_version & SMC_V2,
>   1127						      ini->smcr_version & SMC_V2);
>   1128	
>   1129		/* if neither ISM nor RDMA are supported, fallback */
>   1130		if (ini->smc_type_v1 == SMC_TYPE_N && ini->smc_type_v2 == SMC_TYPE_N)
>   1131			rc = SMC_CLC_DECL_NOSMCDEV;
>   1132	
>   1133		return rc;
>   1134	}
>   1135	
> 

