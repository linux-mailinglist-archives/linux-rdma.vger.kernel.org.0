Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6936C567D16
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGFEV0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 00:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiGFEVZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 00:21:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE3167F4;
        Tue,  5 Jul 2022 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657081285; x=1688617285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TYwiYZ0ZNBBmTQZ6MpJbG1wGZesenEs5jSJYL6XhHBE=;
  b=TyNSoi7jdRYfAL0wFBW/hiPNikAPa1WLkYIiFfeTpb9OUtIBHaAI4IAf
   EsN6gS7GkBqY1ceAnwFzsMS8ytIn4aAkH7W1Af+S45G5B3WVLQIBnd5/M
   nVj4oxGH8g6hEhzubqnRvjErw5BJA08LOVOoJSchrozW0hljLC1kTpCjb
   /apm0w4eJXjJIg9rfeELNUvssF3ohIe8QBrhMmTzMLwz+oknB1W80CMGa
   QbPY3ItbvlMfTrdvHWeTR6Pj5vra3mZqn0MI2zrse2q5/s5yyvYnWk1XK
   3SHbY7HIULb1QOqJ2jpib3N7SEQ6f6cghx6yQFgkx3WsMQgAM2wNW5a3s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="264057350"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="264057350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 21:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="735412357"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2022 21:21:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8wXS-000Jz9-2r;
        Wed, 06 Jul 2022 04:21:22 +0000
Date:   Wed, 6 Jul 2022 12:20:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 02/13] tracing/IB/hfi1: Use the new __vstring() helper
Message-ID: <202207061250.oSPdYi3E-lkp@intel.com>
References: <20220705224749.239494531@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705224749.239494531@goodmis.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Steven,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on wireless-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-events-Add-__vstring-and-__assign_vstr-helpers/20220706-065125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207061250.oSPdYi3E-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e742b16f3b984d761db2d898c15e7632e9166d4a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Steven-Rostedt/tracing-events-Add-__vstring-and-__assign_vstr-helpers/20220706-065125
        git checkout e742b16f3b984d761db2d898c15e7632e9166d4a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/infiniband/hw/hfi1/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                    from drivers/infiniband/hw/hfi1/trace.h:15,
                    from drivers/infiniband/hw/hfi1/trace.c:6:
   drivers/infiniband/hw/hfi1/./trace_dbg.h: In function 'trace_event_get_offsets_hfi1_trace_template':
>> include/trace/trace_events.h:261:16: warning: function 'trace_event_get_offsets_hfi1_trace_template' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     261 |         struct trace_event_raw_##call __maybe_unused *entry;            \
         |                ^~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      25 | DECLARE_EVENT_CLASS(hfi1_trace_template,
         | ^~~~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:102,
                    from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                    from drivers/infiniband/hw/hfi1/trace.h:15,
                    from drivers/infiniband/hw/hfi1/trace.c:6:
   drivers/infiniband/hw/hfi1/./trace_dbg.h: In function 'trace_event_raw_event_hfi1_trace_template':
   include/trace/trace_events.h:386:16: warning: function 'trace_event_raw_event_hfi1_trace_template' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     386 |         struct trace_event_raw_##call *entry;                           \
         |                ^~~~~~~~~~~~~~~~
   drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      25 | DECLARE_EVENT_CLASS(hfi1_trace_template,
         | ^~~~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103,
                    from drivers/infiniband/hw/hfi1/trace_dbg.h:111,
                    from drivers/infiniband/hw/hfi1/trace.h:15,
                    from drivers/infiniband/hw/hfi1/trace.c:6:
   drivers/infiniband/hw/hfi1/./trace_dbg.h: In function 'perf_trace_hfi1_trace_template':
   include/trace/perf.h:64:16: warning: function 'perf_trace_hfi1_trace_template' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      64 |         struct hlist_head *head;                                        \
         |                ^~~~~~~~~~
   drivers/infiniband/hw/hfi1/./trace_dbg.h:25:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      25 | DECLARE_EVENT_CLASS(hfi1_trace_template,
         | ^~~~~~~~~~~~~~~~~~~


vim +261 include/trace/trace_events.h

55de2c0b5610cb include/trace/trace_events.h Masami Hiramatsu         2021-11-22  253  
091ad3658e3c76 include/trace/ftrace.h       Ingo Molnar              2009-11-26  254  #undef DECLARE_EVENT_CLASS
091ad3658e3c76 include/trace/ftrace.h       Ingo Molnar              2009-11-26  255  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
d0ee8f4a1f5f3d include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13  256) static inline notrace int trace_event_get_offsets_##call(		\
62323a148fbeb0 include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13  257) 	struct trace_event_data_offsets_##call *__data_offsets, proto)	\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  258  {									\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  259  	int __data_size = 0;						\
114e7b52dee69c include/trace/ftrace.h       Filipe Brandenburger     2014-02-28  260  	int __maybe_unused __item_length;				\
a7237765730a10 include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13 @261) 	struct trace_event_raw_##call __maybe_unused *entry;		\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  262  									\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  263  	tstruct;							\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  264  									\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  265  	return __data_size;						\
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  266  }
7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  267  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
