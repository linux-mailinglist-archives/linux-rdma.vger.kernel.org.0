Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5437BDF86
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377084AbjJINaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377074AbjJINau (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 09:30:50 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [IPv6:2001:41d0:1004:224b::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689209C
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 06:30:48 -0700 (PDT)
Message-ID: <c7ab6705-f00b-4357-f07c-ba3fc974380f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696858246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16/uUAhGpahyzbx7+ZzmRX3dC81/2ojrWsHiDspyJtU=;
        b=vPHpxv+8/2vQYM1X8YVDyMqrcU7xhZ+oFy3ejUuV2xGVN4p5NEPwb9XKuk4WBUyc83TmNP
        cgfixIJgsbPOaUx8OcXu8im+HBoGTMincou7Moz9fddyiLadcgTF+Q32pWAd/TDhlhYsIc
        hCPiX35eJnBgCFkPC4cIEgFe8l96fz4=
Date:   Mon, 9 Oct 2023 21:30:36 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 19/19] RDMA/siw: Introduce siw_destroy_cep_sock
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, bmt@zurich.ibm.com,
        jgg@ziepe.ca, leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org
References: <20231009071801.10210-20-guoqing.jiang@linux.dev>
 <202310091735.oG7bTvLR-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <202310091735.oG7bTvLR-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 10/9/23 17:54, kernel test robot wrote:
> Hi Guoqing,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on linus/master v6.6-rc5 next-20231009]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Guoqing-Jiang/RDMA-siw-Introduce-siw_get_page/20231009-152705
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20231009071801.10210-20-guoqing.jiang%40linux.dev
> patch subject: [PATCH 19/19] RDMA/siw: Introduce siw_destroy_cep_sock
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231009/202310091735.oG7bTvLR-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310091735.oG7bTvLR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310091735.oG7bTvLR-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     drivers/infiniband/sw/siw/siw_cm.c:360:6: warning: no previous prototype for 'siw_free_cm_id' [-Wmissing-prototypes]
>       360 | void siw_free_cm_id(struct siw_cep *cep, bool put_cep)
>           |      ^~~~~~~~~~~~~~
>>> drivers/infiniband/sw/siw/siw_cm.c:371:6: warning: no previous prototype for 'siw_destroy_cep_sock' [-Wmissing-prototypes]
>       371 | void siw_destroy_cep_sock(struct siw_cep *cep)
>           |      ^~~~~~~~~~~~~~~~~~~~
>
>
> vim +/siw_destroy_cep_sock +371 drivers/infiniband/sw/siw/siw_cm.c

Thanks for the test, I suppose add "static" at the beginning of the two 
lines will resolve the warnings.

Thanks,
Guoqing
