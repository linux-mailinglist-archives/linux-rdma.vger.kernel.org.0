Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50C2395A48
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 14:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEaMTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhEaMTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 08:19:09 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27663C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:17:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id h20so10962048qko.11
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dgNT90eNSG1wBt4tIaS2Vs12DhN1M5IN2OPueQvLpUg=;
        b=iWnUCg71DYYI56zgZu1dORF+mVzCFoU/aVu9/OK0nsfl61j4xqcgu3u//uGlUF63a8
         AWh+Lm3D4ch2JHmKImDXa81UMHKHOixG4SQ+yA1jNoyqI0hjXyWNxlA2PrkAQfEo/aSE
         Z82BYY95bePuVpwA+sb9wB/0Qt0Z0hjU0EiDwNncaoqEE8IsXIYZ5mXViEN+zNBDYmj8
         QYl/d4AFyhyQXYganLM6n+rcSozSr5fB8ZaKQ2P0ROjNKj4xC34rqZi6gfuJ7j1qe3k8
         tV+EbaarVA8oiwuTYIkNmA5EmfN2Dr9pni5AVB+ZMyU5hIDqvvNB/4GWnursNm2xDsV4
         86Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgNT90eNSG1wBt4tIaS2Vs12DhN1M5IN2OPueQvLpUg=;
        b=KIRxC7XYIDp0I0FQw1ONdqsd87203J/8V3giNxyrK4OJLmDGVkxy3hhaEAi+BJ8MIk
         2p3Wb6akUyLpFtqJc0C2UuVdMnrkc5VXNW8VXDAv5dpD8GL5AU8VoF8LlSLiP/npUeFc
         r3QuLPlvzEl5Fc/kgX/PpMnoCNzDp9hEm/P4Cv+k2EGuU4631hfg9D96iflOfbHkIPZt
         is1Cf3TyeuTSolm582BUic/LFfs8DMhSAVqRivA8B/326MenhIKByX2vcNrKO1ZDFdO7
         zrgma3oW7eDO9IwehspYtCim6yCdfxdcUDO2UOeMvovxCEd2x83OwuAVN+TuXR5Mf4HW
         tzfw==
X-Gm-Message-State: AOAM533FwlMjpaUykjCy3bn8fSq2yo1H1yOfFtt6SPzz9ebDH1Q0Aioq
        7idW/y//t2wwO1eBe76S+yTrug==
X-Google-Smtp-Source: ABdhPJxbL+/eaBP51qsUqduUF6sCdmsioQDdamWpffjE6EJ5SeKCyXWEOHtnzGDCFiVE/V2P0msaHQ==
X-Received: by 2002:a37:aa58:: with SMTP id t85mr9883705qke.387.1622463447356;
        Mon, 31 May 2021 05:17:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id v17sm7967714qta.77.2021.05.31.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 05:17:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lngrF-00H5Ro-OZ; Mon, 31 May 2021 09:17:25 -0300
Date:   Mon, 31 May 2021 09:17:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     kernel test robot <lkp@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCHv3 for-next 05/20] RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
Message-ID: <20210531121725.GK1096940@ziepe.ca>
References: <20210528113018.52290-6-jinpu.wang@ionos.com>
 <202105290002.LSBHvezM-lkp@intel.com>
 <CAMGffEnoYGoNwXe75KcP8WCTXAYBKkhJ=cx3aC=4mm77stWzUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEnoYGoNwXe75KcP8WCTXAYBKkhJ=cx3aC=4mm77stWzUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 01:44:22PM +0200, Jinpu Wang wrote:
> On Fri, May 28, 2021 at 6:20 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Jack,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on rdma/for-next]
> > [also build test WARNING on v5.13-rc3 next-20210528]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Jack-Wang/RTRS-update-for-5-14/20210528-193313
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> > config: x86_64-randconfig-a012-20210526 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 6505c630407c5feec818f0bb1c284f9eeebf2071)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # https://github.com/0day-ci/linux/commit/66f95f659060028d1f0f91473ad1c16a6595fcac
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Jack-Wang/RTRS-update-for-5-14/20210528-193313
> >         git checkout 66f95f659060028d1f0f91473ad1c16a6595fcac
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/infiniband/ulp/rtrs/rtrs-clt.c:1786:19: warning: result of comparison of constant 'MAX_SESS_QUEUE_DEPTH' (65536) with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
> >                    if (queue_depth > MAX_SESS_QUEUE_DEPTH) {
> >                        ~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~
>  Thanks for the reporting.
> 
> As the check is checking against u16 max,I think we should reduce
> MAX_SESS_QUEUE_DEPTH to 65535, and drop the check in line rtrs-clt:
> 1786
> 
> Jason, you mentioned v3 is applied in for-next, I guess I'll wait when
> you push it out, and send the patch to fix this. is it ok?

Send me a fix right away and I'll fix the original patch

Jason
