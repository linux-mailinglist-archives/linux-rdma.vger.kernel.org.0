Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF577723351
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFEWqw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFEWqv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 18:46:51 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437EC5
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 15:46:47 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f60924944aso829415e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jun 2023 15:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005205; x=1688597205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUo0D2smsP6sXzDY6ETe0HbeL5W4VuSWNSyhpmFhunk=;
        b=S33gFPSze1Tti/AUtvEXHd8TlT0HhLM3L+QPeePfJxVDRCUKxlFzqN2KzcNTBfgjPa
         cB2kslXEr7Ab1wDOTiZ9CyCbj9KBA+Kg0t5qMTuuPVlRa/Gel4eFnmo9uWuPUiQ1MmO5
         ngibthMwMsUilBLIWb/mxc5H6gCxdwbZKUhUJpTUIP1zZTfbdCHVSEf5AFYSuTTRGnrt
         O3+7BUDSrFBRbNy4tXU38l77GLoy5STDZG5Ihs9ggREkbslmyDMKZr8Ln29dehCKSoCW
         s03L1bHyNG9fqZUOPP15y/PYwkvkFfPwaVO2YAZ8pcWuatnmCyeCfdjzbyeR8tpGTmkC
         ycgw==
X-Gm-Message-State: AC+VfDzS5Hj/VOJii802RYGQZ2bT5MLi0Fz7BF9vCl59WpElSeJUUlnx
        6DiSmHngZOTSlH+hd5L8LnNdWt/W+t4=
X-Google-Smtp-Source: ACHHUZ4tRFh8kIvz9FeBFkTI8HoOmEPsHaBEuprRPPooVvi/7d5WDzd3tt6WSmIzTuM70S4SXD6VgA==
X-Received: by 2002:ac2:5626:0:b0:4e9:c792:c950 with SMTP id b6-20020ac25626000000b004e9c792c950mr157425lff.1.1686005205352;
        Mon, 05 Jun 2023 15:46:45 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id u4-20020a056512040400b004f262997496sm1257413lfk.76.2023.06.05.15.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:46:45 -0700 (PDT)
Message-ID: <45806f5e-08d7-9507-c5fa-2bc388870321@grimberg.me>
Date:   Tue, 6 Jun 2023 01:46:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-rc 1/3] IB/isert: Fix dead lock in ib_isert
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org
References: <20230601094220.64810-2-saravanan.vajravel@broadcom.com>
 <202306021057.prO0j0bN-lkp@intel.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202306021057.prO0j0bN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi Saravanan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on rdma/for-next]
> [also build test ERROR on linus/master v6.4-rc4 next-20230601]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Saravanan-Vajravel/IB-isert-Fix-dead-lock-in-ib_isert/20230601-225628
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20230601094220.64810-2-saravanan.vajravel%40broadcom.com
> patch subject: [PATCH for-rc 1/3] IB/isert: Fix dead lock in ib_isert
> config: x86_64-buildonly-randconfig-r005-20230602 (https://download.01.org/0day-ci/archive/20230602/202306021057.prO0j0bN-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/c7031144a2a9b6f14201977b35600ab80ee30e09
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Saravanan-Vajravel/IB-isert-Fix-dead-lock-in-ib_isert/20230601-225628
>          git checkout c7031144a2a9b6f14201977b35600ab80ee30e09
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 olddefconfig
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/infiniband/ulp/isert/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306021057.prO0j0bN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/infiniband/ulp/isert/ib_isert.c: In function 'isert_free_np':
>>> drivers/infiniband/ulp/isert/ib_isert.c:2454:75: error: expected ';' before '}' token
>      2454 |                         list_move_tail(&isert_conn->node, &drop_conn_list)
>           |                                                                           ^
>           |                                                                           ;
>      2455 |                 }
>           |                 ~
> 

Obviously this would have been even better properly compiling..
