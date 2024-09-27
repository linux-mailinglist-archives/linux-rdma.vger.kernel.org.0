Return-Path: <linux-rdma+bounces-5125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A224E987F0B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 09:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC63B224FB
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690917C234;
	Fri, 27 Sep 2024 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlNg3Nes"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445CEAC6
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420422; cv=none; b=j3rc/tLfAAxYN2QGPtOB+MPy0AmNihFsNIcaIkRpCocgqUBIaq2UgZbAZn10kbfypaVxNyLxn983fEEzArK/JfKPJuxeSZC2WQ95ubuuoP85Ow0pbnm+GPIt/mkNP1NCc3Go64lI65gMk+lhrgRDp9BnQyntYrMPVurQhvsPYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420422; c=relaxed/simple;
	bh=YxgMQ0/TScXMRO2281MQ89Iwo53aLIF+9oRBMRR3g+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ijqhc3/EFYQC24h6JbZW5GS/t+nSC9BMvE1B8mTqGWHRaHcJAeB776pSu4sbjU/D5vt7fTwjpAIO6bLinQWeZpDXzdtgr6fWeGzbSswxk4Hgj9XRlhiUdhEZc75Eq6wFCUAbhYrGp2ahguOOSujh/e16j8kCq1uKPEW5itdtUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LlNg3Nes; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccfbbd467so931324f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727420419; x=1728025219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HRWd4DarArFolyZDgIM8zoP76mQj+jdjNY+riGIkrQ=;
        b=LlNg3Nesfko/o18phuQzilwCEnMoQ22IZERZQsXsjekudRuyb4ahDHOvxWt/47Rfby
         gsCX5JFH47IybdPVftvvMQuGLqyIWuQHrzsAwtrODDwxYa5mxp2KsvTiHGiBIc/iGjBs
         TR9O9i+ztV311WgDs2CE5e/vzsufjeYFwMYdWINCviq+xWs3I4i9TPMq9W5DeGdm/5Pi
         T6hAQ1o7/9u9Sj4pRNbX80GC7WhGtgopnfxsj/pZKOQXrWJYefNfwYgsq9YgVFI07/OK
         4t7JjhE2A5xy46kzmOyQolO9MK5rp8kaGKcvEnHuGB51Soq7HtIz5p5lNnT6zG1X2Ree
         ey6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420419; x=1728025219;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HRWd4DarArFolyZDgIM8zoP76mQj+jdjNY+riGIkrQ=;
        b=G6PkG0BRElemLrfabhpPrW0jPvr6zD8c12dMcI4KTDvN78Yj33FqeWnz9m5wVotx1C
         ohnybhlhX0E/gXNzhyhwG1kTu5qfA1XfXHYoGQFAPP39CnNViJT9BYkVeHWTggQZ6XBa
         ScQf3fDfYrMHSx8sQbDQv7+eSpKtth2Qpkge86barTt+6107br/SHW1/bo8nGkPZF+BD
         ieeeAeAQWljjhYLp/OjY5IKMjJOCpmBWvoqBKHrnRQy6sHvGJXhLDXn69ZLVJEebyb3l
         +9uGCkN8MU2zrnmkXWMlSrFbPTdlT1BVjhG0FKQ9rx1SixFPcFCdyC3KoPlf8bT4Hglx
         K7wA==
X-Forwarded-Encrypted: i=1; AJvYcCW+DJbJwDrIZ+RCrAB031bcd7ea+Cq9Qq4bl6syOY7rrAcHMvSH09uDJQkN6YWyqvMKVnyjmvSPsNex@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxfLCRAkJMg8WAduYd9IP4br4KV490OcvOMcmEps82iyIE/ar
	X7yCj8+s8H3AaIjf1KAPSI9jkY+5qbYcoQvcGN/8VzeX4y+Y7DCR8z94Cjj7r9g=
X-Google-Smtp-Source: AGHT+IF88mTkuLf5Z3Obd0ISvCs782AtdeGUkTEKlcbYor9GLPKH7XsOfEc/ucE9hIxTBBO9b5UkSQ==
X-Received: by 2002:a5d:6448:0:b0:37c:d162:8295 with SMTP id ffacd0b85a97d-37cd5aafa24mr1367229f8f.29.1727420418876;
        Fri, 27 Sep 2024 00:00:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm1637628f8f.96.2024.09.27.00.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 00:00:18 -0700 (PDT)
Date: Fri, 27 Sep 2024 10:00:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Anumula Murali Mohan Reddy <anumula@chelsio.com>, jgg@nvidia.com,
	leonro@nvidia.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	Anumula Murali Mohan Reddy <anumula@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-next] RDMA/core: fix ENODEV error for iwarp test over
 vlan
Message-ID: <d9ac9d0c-f3d7-4fbc-8c14-5603de5e0035@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926060708.82018-1-anumula@chelsio.com>

Hi Anumula,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anumula-Murali-Mohan-Reddy/RDMA-core-fix-ENODEV-error-for-iwarp-test-over-vlan/20240926-140515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20240926060708.82018-1-anumula%40chelsio.com
patch subject: [PATCH for-next] RDMA/core: fix ENODEV error for iwarp test over vlan
config: x86_64-randconfig-161-20240926 (https://download.01.org/0day-ci/archive/20240927/202409270901.6bDFVhkz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409270901.6bDFVhkz-lkp@intel.com/

smatch warnings:
drivers/infiniband/core/addr.c:272 rdma_find_ndev_for_src_ip_rcu() error: we previously assumed 'dev' could be null (see line 256)

vim +/dev +272 drivers/infiniband/core/addr.c

caf1e3ae9fa648 Parav Pandit               2018-09-05  245  static struct net_device *
caf1e3ae9fa648 Parav Pandit               2018-09-05  246  rdma_find_ndev_for_src_ip_rcu(struct net *net, const struct sockaddr *src_in)
caf1e3ae9fa648 Parav Pandit               2018-09-05  247  {
caf1e3ae9fa648 Parav Pandit               2018-09-05  248  	struct net_device *dev = NULL;
caf1e3ae9fa648 Parav Pandit               2018-09-05  249  	int ret = -EADDRNOTAVAIL;
caf1e3ae9fa648 Parav Pandit               2018-09-05  250  
caf1e3ae9fa648 Parav Pandit               2018-09-05  251  	switch (src_in->sa_family) {
caf1e3ae9fa648 Parav Pandit               2018-09-05  252  	case AF_INET:
caf1e3ae9fa648 Parav Pandit               2018-09-05  253  		dev = __ip_dev_find(net,
caf1e3ae9fa648 Parav Pandit               2018-09-05  254  				    ((const struct sockaddr_in *)src_in)->sin_addr.s_addr,
caf1e3ae9fa648 Parav Pandit               2018-09-05  255  				    false);
caf1e3ae9fa648 Parav Pandit               2018-09-05 @256  		if (dev)

dev can be NULL

caf1e3ae9fa648 Parav Pandit               2018-09-05  257  			ret = 0;
caf1e3ae9fa648 Parav Pandit               2018-09-05  258  		break;
caf1e3ae9fa648 Parav Pandit               2018-09-05  259  #if IS_ENABLED(CONFIG_IPV6)
caf1e3ae9fa648 Parav Pandit               2018-09-05  260  	case AF_INET6:
caf1e3ae9fa648 Parav Pandit               2018-09-05  261  		for_each_netdev_rcu(net, dev) {
caf1e3ae9fa648 Parav Pandit               2018-09-05  262  			if (ipv6_chk_addr(net,
caf1e3ae9fa648 Parav Pandit               2018-09-05  263  					  &((const struct sockaddr_in6 *)src_in)->sin6_addr,
caf1e3ae9fa648 Parav Pandit               2018-09-05  264  					  dev, 1)) {
caf1e3ae9fa648 Parav Pandit               2018-09-05  265  				ret = 0;
caf1e3ae9fa648 Parav Pandit               2018-09-05  266  				break;
caf1e3ae9fa648 Parav Pandit               2018-09-05  267  			}
caf1e3ae9fa648 Parav Pandit               2018-09-05  268  		}
caf1e3ae9fa648 Parav Pandit               2018-09-05  269  		break;
caf1e3ae9fa648 Parav Pandit               2018-09-05  270  #endif
caf1e3ae9fa648 Parav Pandit               2018-09-05  271  	}
b1d29f42e02d0c Anumula Murali Mohan Reddy 2024-09-26 @272  	if (is_vlan_dev(dev))
                                                                                ^^^
Dereferenced inside function.

b1d29f42e02d0c Anumula Murali Mohan Reddy 2024-09-26  273  		dev = vlan_dev_real_dev(dev);
caf1e3ae9fa648 Parav Pandit               2018-09-05  274  	return ret ? ERR_PTR(ret) : dev;
caf1e3ae9fa648 Parav Pandit               2018-09-05  275  }
caf1e3ae9fa648 Parav Pandit               2018-09-05  276  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


