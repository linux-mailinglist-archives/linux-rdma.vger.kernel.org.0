Return-Path: <linux-rdma+bounces-1643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A518906EE
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32FE29FBFF
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A19535CA;
	Thu, 28 Mar 2024 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nbt7lRk2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5B39FFE;
	Thu, 28 Mar 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645703; cv=none; b=Sjqw0MoHpHI1A2V7z9Fm17ZLjUYTJ/8tzKsB+duatJXQkXeCjA+8oMkRUG+V9Jv3P/vjvoBBkAe9glSl/XWaD3746j8f12Adsaw3gvsYeDaOikixrc0F+e9mtcatU/ZB9ZbTaRJkUrMKRYVb3Lf2fhWgkrE+N+oJ+9xNvLcCcXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645703; c=relaxed/simple;
	bh=UCnU67HeXYoqYdj4S5dBKZ2Q4xHzdK3/OCAHu2KUfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQOzDEg/Tbylz/gXhPcSgQ1Fc87Khc172Hn2d75d6TZ1y02ih2Lxe6teguUnZjlj2ZvkxxTlQwVtI5Bwevx4WrHmkNLUuxI2N/zwo61Dteb9iGcOUZzVcxanFK+PfeTNBAxGWGXupj1z0f4KJ9KRoc2VITfA9RRsNqIKRflJmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nbt7lRk2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711645701; x=1743181701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UCnU67HeXYoqYdj4S5dBKZ2Q4xHzdK3/OCAHu2KUfBI=;
  b=Nbt7lRk294+zepCU7jnY/4BlzLmzfQHNIYoCDoTfUUzx5pwidfcPzH64
   9KODxFPwn3hLHcZBVXDEDIZDeNVTfNld/N+km4ANtBDHVM/Ayk/8aTXU7
   mQW5ImjZ6IXzFthZ6elqRhGWcON9S78u9P0rjhVdDttTcgWdluvJCrene
   duMO5fhorj3qpt6gS2y4d/BKyK4ZNx+gMLPdTf4m4xEJ/kn2ZqxtdrBHa
   gprL7BFiGpUOjURsusQdTSFnyYxofzPEK5sKab0qdxMXn8zMrlOAjbh3K
   2Adrlsjom26hxu87Yn92k2xGLz/kIT55HTPbF7TsVD8clH0/lfv9MOv3W
   Q==;
X-CSE-ConnectionGUID: 1ye/Oi/jQsCv30UPnsNRpw==
X-CSE-MsgGUID: WXpS8vqAQ8ic/wwBB9Z6aQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7417542"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="7417542"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39865448"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Mar 2024 10:08:17 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rptEc-0002NC-2v;
	Thu, 28 Mar 2024 17:08:14 +0000
Date: Fri, 29 Mar 2024 01:07:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mina Almasry <almasrymina@google.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mirko Lindner <mlindner@marvell.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 2/3] net: mirror skb frag ref/unref helpers
Message-ID: <202403290006.WfusvToB-lkp@intel.com>
References: <20240327214523.2182174-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327214523.2182174-3-almasrymina@google.com>

Hi Mina,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mina-Almasry/net-make-napi_frag_unref-reuse-skb_page_unref/20240328-054816
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240327214523.2182174-3-almasrymina%40google.com
patch subject: [PATCH net-next v2 2/3] net: mirror skb frag ref/unref helpers
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240329/202403290006.WfusvToB-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403290006.WfusvToB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290006.WfusvToB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/tls/tls_device_fallback.c:280:22: error: too few arguments to function call, expected 2, have 1
     280 |                 __skb_frag_ref(frag);
         |                 ~~~~~~~~~~~~~~     ^
   include/linux/skbuff.h:3517:20: note: '__skb_frag_ref' declared here
    3517 | static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
         |                    ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +280 net/tls/tls_device_fallback.c

e8f69799810c32 Ilya Lesokhin  2018-04-30  228  
e8f69799810c32 Ilya Lesokhin  2018-04-30  229  /* This function may be called after the user socket is already
e8f69799810c32 Ilya Lesokhin  2018-04-30  230   * closed so make sure we don't use anything freed during
e8f69799810c32 Ilya Lesokhin  2018-04-30  231   * tls_sk_proto_close here
e8f69799810c32 Ilya Lesokhin  2018-04-30  232   */
e8f69799810c32 Ilya Lesokhin  2018-04-30  233  
e8f69799810c32 Ilya Lesokhin  2018-04-30  234  static int fill_sg_in(struct scatterlist *sg_in,
e8f69799810c32 Ilya Lesokhin  2018-04-30  235  		      struct sk_buff *skb,
d80a1b9d186057 Boris Pismenny 2018-07-13  236  		      struct tls_offload_context_tx *ctx,
e8f69799810c32 Ilya Lesokhin  2018-04-30  237  		      u64 *rcd_sn,
e8f69799810c32 Ilya Lesokhin  2018-04-30  238  		      s32 *sync_size,
e8f69799810c32 Ilya Lesokhin  2018-04-30  239  		      int *resync_sgs)
e8f69799810c32 Ilya Lesokhin  2018-04-30  240  {
504148fedb8542 Eric Dumazet   2022-06-30  241  	int tcp_payload_offset = skb_tcp_all_headers(skb);
e8f69799810c32 Ilya Lesokhin  2018-04-30  242  	int payload_len = skb->len - tcp_payload_offset;
e8f69799810c32 Ilya Lesokhin  2018-04-30  243  	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
e8f69799810c32 Ilya Lesokhin  2018-04-30  244  	struct tls_record_info *record;
e8f69799810c32 Ilya Lesokhin  2018-04-30  245  	unsigned long flags;
e8f69799810c32 Ilya Lesokhin  2018-04-30  246  	int remaining;
e8f69799810c32 Ilya Lesokhin  2018-04-30  247  	int i;
e8f69799810c32 Ilya Lesokhin  2018-04-30  248  
e8f69799810c32 Ilya Lesokhin  2018-04-30  249  	spin_lock_irqsave(&ctx->lock, flags);
e8f69799810c32 Ilya Lesokhin  2018-04-30  250  	record = tls_get_record(ctx, tcp_seq, rcd_sn);
e8f69799810c32 Ilya Lesokhin  2018-04-30  251  	if (!record) {
e8f69799810c32 Ilya Lesokhin  2018-04-30  252  		spin_unlock_irqrestore(&ctx->lock, flags);
e8f69799810c32 Ilya Lesokhin  2018-04-30  253  		return -EINVAL;
e8f69799810c32 Ilya Lesokhin  2018-04-30  254  	}
e8f69799810c32 Ilya Lesokhin  2018-04-30  255  
e8f69799810c32 Ilya Lesokhin  2018-04-30  256  	*sync_size = tcp_seq - tls_record_start_seq(record);
e8f69799810c32 Ilya Lesokhin  2018-04-30  257  	if (*sync_size < 0) {
e8f69799810c32 Ilya Lesokhin  2018-04-30  258  		int is_start_marker = tls_record_is_start_marker(record);
e8f69799810c32 Ilya Lesokhin  2018-04-30  259  
e8f69799810c32 Ilya Lesokhin  2018-04-30  260  		spin_unlock_irqrestore(&ctx->lock, flags);
e8f69799810c32 Ilya Lesokhin  2018-04-30  261  		/* This should only occur if the relevant record was
e8f69799810c32 Ilya Lesokhin  2018-04-30  262  		 * already acked. In that case it should be ok
e8f69799810c32 Ilya Lesokhin  2018-04-30  263  		 * to drop the packet and avoid retransmission.
e8f69799810c32 Ilya Lesokhin  2018-04-30  264  		 *
e8f69799810c32 Ilya Lesokhin  2018-04-30  265  		 * There is a corner case where the packet contains
e8f69799810c32 Ilya Lesokhin  2018-04-30  266  		 * both an acked and a non-acked record.
e8f69799810c32 Ilya Lesokhin  2018-04-30  267  		 * We currently don't handle that case and rely
a0e128ef88e4a0 Yueh-Shun Li   2023-06-22  268  		 * on TCP to retransmit a packet that doesn't contain
e8f69799810c32 Ilya Lesokhin  2018-04-30  269  		 * already acked payload.
e8f69799810c32 Ilya Lesokhin  2018-04-30  270  		 */
e8f69799810c32 Ilya Lesokhin  2018-04-30  271  		if (!is_start_marker)
e8f69799810c32 Ilya Lesokhin  2018-04-30  272  			*sync_size = 0;
e8f69799810c32 Ilya Lesokhin  2018-04-30  273  		return -EINVAL;
e8f69799810c32 Ilya Lesokhin  2018-04-30  274  	}
e8f69799810c32 Ilya Lesokhin  2018-04-30  275  
e8f69799810c32 Ilya Lesokhin  2018-04-30  276  	remaining = *sync_size;
e8f69799810c32 Ilya Lesokhin  2018-04-30  277  	for (i = 0; remaining > 0; i++) {
e8f69799810c32 Ilya Lesokhin  2018-04-30  278  		skb_frag_t *frag = &record->frags[i];
e8f69799810c32 Ilya Lesokhin  2018-04-30  279  
e8f69799810c32 Ilya Lesokhin  2018-04-30 @280  		__skb_frag_ref(frag);
e8f69799810c32 Ilya Lesokhin  2018-04-30  281  		sg_set_page(sg_in + i, skb_frag_page(frag),
b54c9d5bd6e38e Jonathan Lemon 2019-07-30  282  			    skb_frag_size(frag), skb_frag_off(frag));
e8f69799810c32 Ilya Lesokhin  2018-04-30  283  
e8f69799810c32 Ilya Lesokhin  2018-04-30  284  		remaining -= skb_frag_size(frag);
e8f69799810c32 Ilya Lesokhin  2018-04-30  285  
e8f69799810c32 Ilya Lesokhin  2018-04-30  286  		if (remaining < 0)
e8f69799810c32 Ilya Lesokhin  2018-04-30  287  			sg_in[i].length += remaining;
e8f69799810c32 Ilya Lesokhin  2018-04-30  288  	}
e8f69799810c32 Ilya Lesokhin  2018-04-30  289  	*resync_sgs = i;
e8f69799810c32 Ilya Lesokhin  2018-04-30  290  
e8f69799810c32 Ilya Lesokhin  2018-04-30  291  	spin_unlock_irqrestore(&ctx->lock, flags);
e8f69799810c32 Ilya Lesokhin  2018-04-30  292  	if (skb_to_sgvec(skb, &sg_in[i], tcp_payload_offset, payload_len) < 0)
e8f69799810c32 Ilya Lesokhin  2018-04-30  293  		return -EINVAL;
e8f69799810c32 Ilya Lesokhin  2018-04-30  294  
e8f69799810c32 Ilya Lesokhin  2018-04-30  295  	return 0;
e8f69799810c32 Ilya Lesokhin  2018-04-30  296  }
e8f69799810c32 Ilya Lesokhin  2018-04-30  297  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

