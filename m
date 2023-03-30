Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D26D0E3F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjC3TCM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 15:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjC3TCL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 15:02:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B47D8C
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680202929; x=1711738929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+M0LgPW+uMJUK/8KTR6a577r/YdVbpCQCw2Jwh+8vF4=;
  b=ar5pApmzJhA1ukRkZlQ9tZEVKVkt9KLjLRU+BneS+4XxSjsqKXOCRJ9m
   nSZLSIEeGhzoIQGW6EU0F+OcKXlvvShTOV/Sj6+JO9aViViSj+MqgcJ2d
   63hLn6T6NkG1zd2oKaHGg/B/zCx4lwq9YLAPjSKV+O/vCBZvKJorO/RJg
   xm0HKNvwvD25N/5/zlHAYso91qOhKVjJ3wDl7dQzQm9u4J6DqdQ702P/y
   CH858ZVfmGGkwbxyJxrclzGi8ie40Mx88lxBFs0C5VXwAVQf3qwUuBi/K
   mvK10LSi5MQuVNZUU+XJ1oRiPUumJHfuhFb6s/WlmJYlKYPrz6qS4CJ16
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="341277490"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="341277490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 12:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715122368"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="715122368"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2023 12:02:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phxXB-000L7e-3A;
        Thu, 30 Mar 2023 19:02:05 +0000
Date:   Fri, 31 Mar 2023 03:01:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RDMA: Add ib_virt_dma_to_page()
Message-ID: <202303310254.tmWyQaZG-lkp@intel.com>
References: <0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-789ba72d2950+2e-ib_virt_page_jgg@nvidia.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 78b26a335310a097d6b22581b706050db42f196c]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Gunthorpe/RDMA-Add-ib_virt_dma_to_page/20230330-222848
base:   78b26a335310a097d6b22581b706050db42f196c
patch link:    https://lore.kernel.org/r/0-v1-789ba72d2950%2B2e-ib_virt_page_jgg%40nvidia.com
patch subject: [PATCH] RDMA: Add ib_virt_dma_to_page()
config: m68k-randconfig-r014-20230329 (https://download.01.org/0day-ci/archive/20230331/202303310254.tmWyQaZG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a10308d393288ba62a1aa7c24a7f6df484c2892a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jason-Gunthorpe/RDMA-Add-ib_virt_dma_to_page/20230330-222848
        git checkout a10308d393288ba62a1aa7c24a7f6df484c2892a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/infiniband/sw/siw/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303310254.tmWyQaZG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_tx_hdt':
>> drivers/infiniband/sw/siw/siw_qp_tx.c:546:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     546 |                                                 (void *)va,
         |                                                 ^


vim +546 drivers/infiniband/sw/siw/siw_qp_tx.c

b9be6f18cf9ed0 Bernard Metzler 2019-06-20  426  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  427  /*
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  428   * Write out iov referencing hdr, data and trailer of current FPDU.
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  429   * Update transmit state dependent on write return status
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  430   */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  431  static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  432  {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  433  	struct siw_wqe *wqe = &c_tx->wqe_active;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  434  	struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  435  	struct kvec iov[MAX_ARRAY];
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  436  	struct page *page_array[MAX_ARRAY];
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  437  	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  438  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  439  	int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  440  	unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len = 0,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  441  		     sge_off = c_tx->sge_off, sge_idx = c_tx->sge_idx,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  442  		     pbl_idx = c_tx->pbl_idx;
fab4f97e1fe33c Bernard Metzler 2019-08-22  443  	unsigned long kmap_mask = 0L;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  444  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  445  	if (c_tx->state == SIW_SEND_HDR) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  446  		if (c_tx->use_sendpage) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  447  			rv = siw_tx_ctrl(c_tx, s, MSG_DONTWAIT | MSG_MORE);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  448  			if (rv)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  449  				goto done;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  450  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  451  			c_tx->state = SIW_SEND_DATA;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  452  		} else {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  453  			iov[0].iov_base =
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  454  				(char *)&c_tx->pkt.ctrl + c_tx->ctrl_sent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  455  			iov[0].iov_len = hdr_len =
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  456  				c_tx->ctrl_len - c_tx->ctrl_sent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  457  			seg = 1;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  458  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  459  	}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  460  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  461  	wqe->processed += data_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  462  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  463  	while (data_len) { /* walk the list of SGE's */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  464  		unsigned int sge_len = min(sge->length - sge_off, data_len);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  465  		unsigned int fp_off = (sge->laddr + sge_off) & ~PAGE_MASK;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  466  		struct siw_mem *mem;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  467  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  468  		if (!(tx_flags(wqe) & SIW_WQE_INLINE)) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  469  			mem = wqe->mem[sge_idx];
fab4f97e1fe33c Bernard Metzler 2019-08-22  470  			is_kva = mem->mem_obj == NULL ? 1 : 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  471  		} else {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  472  			is_kva = 1;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  473  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  474  		if (is_kva && !c_tx->use_sendpage) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  475  			/*
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  476  			 * tx from kernel virtual address: either inline data
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  477  			 * or memory region with assigned kernel buffer
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  478  			 */
c536277e0db1ad Bernard Metzler 2019-08-22  479  			iov[seg].iov_base =
c536277e0db1ad Bernard Metzler 2019-08-22  480  				(void *)(uintptr_t)(sge->laddr + sge_off);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  481  			iov[seg].iov_len = sge_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  482  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  483  			if (do_crc)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  484  				crypto_shash_update(c_tx->mpa_crc_hd,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  485  						    iov[seg].iov_base,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  486  						    sge_len);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  487  			sge_off += sge_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  488  			data_len -= sge_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  489  			seg++;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  490  			goto sge_done;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  491  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  492  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  493  		while (sge_len) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  494  			size_t plen = min((int)PAGE_SIZE - fp_off, sge_len);
1ec50dd12a4347 Ira Weiny       2021-06-21  495  			void *kaddr;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  496  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  497  			if (!is_kva) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  498  				struct page *p;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  499  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  500  				if (mem->is_pbl)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  501  					p = siw_get_pblpage(
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  502  						mem, sge->laddr + sge_off,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  503  						&pbl_idx);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  504  				else
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  505  					p = siw_get_upage(mem->umem,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  506  							  sge->laddr + sge_off);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  507  				if (unlikely(!p)) {
9d649d594f3965 Ira Weiny       2021-06-24  508  					siw_unmap_pages(iov, kmap_mask, seg);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  509  					wqe->processed -= c_tx->bytes_unsent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  510  					rv = -EFAULT;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  511  					goto done_crc;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  512  				}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  513  				page_array[seg] = p;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  514  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  515  				if (!c_tx->use_sendpage) {
9d649d594f3965 Ira Weiny       2021-06-24  516  					void *kaddr = kmap_local_page(p);
fab4f97e1fe33c Bernard Metzler 2019-08-22  517  
fab4f97e1fe33c Bernard Metzler 2019-08-22  518  					/* Remember for later kunmap() */
fab4f97e1fe33c Bernard Metzler 2019-08-22  519  					kmap_mask |= BIT(seg);
9d649d594f3965 Ira Weiny       2021-06-24  520  					iov[seg].iov_base = kaddr + fp_off;
9d649d594f3965 Ira Weiny       2021-06-24  521  					iov[seg].iov_len = plen;
fab4f97e1fe33c Bernard Metzler 2019-08-22  522  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  523  					if (do_crc)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  524  						crypto_shash_update(
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  525  							c_tx->mpa_crc_hd,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  526  							iov[seg].iov_base,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  527  							plen);
0404bd629fd4d0 Bernard Metzler 2019-09-09  528  				} else if (do_crc) {
1ec50dd12a4347 Ira Weiny       2021-06-21  529  					kaddr = kmap_local_page(p);
0404bd629fd4d0 Bernard Metzler 2019-09-09  530  					crypto_shash_update(c_tx->mpa_crc_hd,
1ec50dd12a4347 Ira Weiny       2021-06-21  531  							    kaddr + fp_off,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  532  							    plen);
1ec50dd12a4347 Ira Weiny       2021-06-21  533  					kunmap_local(kaddr);
0404bd629fd4d0 Bernard Metzler 2019-09-09  534  				}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  535  			} else {
0d1b756acf60da Linus Walleij   2022-09-02  536  				/*
0d1b756acf60da Linus Walleij   2022-09-02  537  				 * Cast to an uintptr_t to preserve all 64 bits
0d1b756acf60da Linus Walleij   2022-09-02  538  				 * in sge->laddr.
0d1b756acf60da Linus Walleij   2022-09-02  539  				 */
a10308d393288b Jason Gunthorpe 2023-03-30  540  				u64 va = (uintptr_t)(sge->laddr + sge_off);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  541  
a10308d393288b Jason Gunthorpe 2023-03-30  542  				page_array[seg] = ib_virt_dma_to_page(va);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  543  				if (do_crc)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  544  					crypto_shash_update(
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  545  						c_tx->mpa_crc_hd,
0d1b756acf60da Linus Walleij   2022-09-02 @546  						(void *)va,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  547  						plen);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  548  			}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  549  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  550  			sge_len -= plen;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  551  			sge_off += plen;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  552  			data_len -= plen;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  553  			fp_off = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  554  
271bfcfb83a9f7 Daniil Dulov    2023-02-27  555  			if (++seg >= (int)MAX_ARRAY) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  556  				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
9d649d594f3965 Ira Weiny       2021-06-24  557  				siw_unmap_pages(iov, kmap_mask, seg-1);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  558  				wqe->processed -= c_tx->bytes_unsent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  559  				rv = -EMSGSIZE;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  560  				goto done_crc;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  561  			}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  562  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  563  sge_done:
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  564  		/* Update SGE variables at end of SGE */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  565  		if (sge_off == sge->length &&
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  566  		    (data_len != 0 || wqe->processed < wqe->bytes)) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  567  			sge_idx++;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  568  			sge++;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  569  			sge_off = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  570  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  571  	}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  572  	/* trailer */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  573  	if (likely(c_tx->state != SIW_SEND_TRAILER)) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  574  		iov[seg].iov_base = &c_tx->trailer.pad[4 - c_tx->pad];
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  575  		iov[seg].iov_len = trl_len = MAX_TRAILER - (4 - c_tx->pad);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  576  	} else {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  577  		iov[seg].iov_base = &c_tx->trailer.pad[c_tx->ctrl_sent];
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  578  		iov[seg].iov_len = trl_len = MAX_TRAILER - c_tx->ctrl_sent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  579  	}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  580  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  581  	if (c_tx->pad) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  582  		*(u32 *)c_tx->trailer.pad = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  583  		if (do_crc)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  584  			crypto_shash_update(c_tx->mpa_crc_hd,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  585  				(u8 *)&c_tx->trailer.crc - c_tx->pad,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  586  				c_tx->pad);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  587  	}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  588  	if (!c_tx->mpa_crc_hd)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  589  		c_tx->trailer.crc = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  590  	else if (do_crc)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  591  		crypto_shash_final(c_tx->mpa_crc_hd, (u8 *)&c_tx->trailer.crc);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  592  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  593  	data_len = c_tx->bytes_unsent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  594  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  595  	if (c_tx->use_sendpage) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  596  		rv = siw_0copy_tx(s, page_array, &wqe->sqe.sge[c_tx->sge_idx],
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  597  				  c_tx->sge_off, data_len);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  598  		if (rv == data_len) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  599  			rv = kernel_sendmsg(s, &msg, &iov[seg], 1, trl_len);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  600  			if (rv > 0)
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  601  				rv += data_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  602  			else
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  603  				rv = data_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  604  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  605  	} else {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  606  		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  607  				    hdr_len + data_len + trl_len);
9d649d594f3965 Ira Weiny       2021-06-24  608  		siw_unmap_pages(iov, kmap_mask, seg);
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  609  	}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  610  	if (rv < (int)hdr_len) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  611  		/* Not even complete hdr pushed or negative rv */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  612  		wqe->processed -= data_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  613  		if (rv >= 0) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  614  			c_tx->ctrl_sent += rv;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  615  			rv = -EAGAIN;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  616  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  617  		goto done_crc;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  618  	}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  619  	rv -= hdr_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  620  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  621  	if (rv >= (int)data_len) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  622  		/* all user data pushed to TCP or no data to push */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  623  		if (data_len > 0 && wqe->processed < wqe->bytes) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  624  			/* Save the current state for next tx */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  625  			c_tx->sge_idx = sge_idx;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  626  			c_tx->sge_off = sge_off;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  627  			c_tx->pbl_idx = pbl_idx;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  628  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  629  		rv -= data_len;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  630  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  631  		if (rv == trl_len) /* all pushed */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  632  			rv = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  633  		else {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  634  			c_tx->state = SIW_SEND_TRAILER;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  635  			c_tx->ctrl_len = MAX_TRAILER;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  636  			c_tx->ctrl_sent = rv + 4 - c_tx->pad;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  637  			c_tx->bytes_unsent = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  638  			rv = -EAGAIN;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  639  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  640  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  641  	} else if (data_len > 0) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  642  		/* Maybe some user data pushed to TCP */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  643  		c_tx->state = SIW_SEND_DATA;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  644  		wqe->processed -= data_len - rv;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  645  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  646  		if (rv) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  647  			/*
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  648  			 * Some bytes out. Recompute tx state based
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  649  			 * on old state and bytes pushed
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  650  			 */
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  651  			unsigned int sge_unsent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  652  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  653  			c_tx->bytes_unsent -= rv;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  654  			sge = &wqe->sqe.sge[c_tx->sge_idx];
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  655  			sge_unsent = sge->length - c_tx->sge_off;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  656  
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  657  			while (sge_unsent <= rv) {
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  658  				rv -= sge_unsent;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  659  				c_tx->sge_idx++;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  660  				c_tx->sge_off = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  661  				sge++;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  662  				sge_unsent = sge->length;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  663  			}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  664  			c_tx->sge_off += rv;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  665  		}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  666  		rv = -EAGAIN;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  667  	}
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  668  done_crc:
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  669  	c_tx->do_crc = 0;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  670  done:
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  671  	return rv;
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  672  }
b9be6f18cf9ed0 Bernard Metzler 2019-06-20  673  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
