Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76604B2CFA
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352686AbiBKSaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 13:30:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351978AbiBKSaQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 13:30:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855C82C9
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644604214; x=1676140214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQZ7AMo0eWqNzBulG+i40R45E4khts5GnwopPz6hCAM=;
  b=iNgTe3WP8OmYBRB2Jx+9zrNUaoaFN1lJOUKCA3ZNWPkmY5xkICj6u3U8
   OjsTiRCL+gQ+Lx/bvIiFljGI2G/AGWTgIai9vNxEPSb968KZcY4p3q3nJ
   ul1I/4ENOXLPq3nd8nCUWwLCiim7IubCRqWpBiRDH5N+Zt9R1J6Yo/NNC
   CYqOrwaAp0VTSAnefq796hE3CaZoJGbm/JWh977cDEgkkQ0vxbwlvVB8y
   MSzYIwdbWE1DobEUZZh69jFVWdrm8aOSM14xIwHJ3JlqwP61KJqSK8slm
   TttohRppGECBBBlCKD5xjenl6Q+HhYJru4PKdBcKh3GTKTRxdChpBJB5p
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="247376292"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="247376292"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:30:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="527047351"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:30:13 -0800
Date:   Fri, 11 Feb 2022 10:30:13 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "hch@lst.de" <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220211183013.GR785175@iweiny-DESK2.sc.intel.com>
References: <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
 <20220121125837.GV84788@nvidia.com>
 <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
 <b3b322be-a718-5fb8-11e2-05ee783f1086@fujitsu.com>
 <20220127095730.GA14946@lst.de>
 <20220127180833.GF785175@iweiny-DESK2.sc.intel.com>
 <20220128061618.GA1551@lst.de>
 <20220128191527.GG785175@iweiny-DESK2.sc.intel.com>
 <bf21680a-1df5-b464-fcc4-a1a67cd03024@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf21680a-1df5-b464-fcc4-a1a67cd03024@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 10, 2022 at 11:06:55AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/1/29 3:15, Ira Weiny wrote:
> 
> > Ah...  ok...
> >
> > Obviously I've not kept up with the software providers...
> >
> > For this use case, can kmap_local_page() work?
> >
> > Ira
> 
> Hi Ira,
> 
> I applied your patch set on my branch but ibv_reg_mr() with /dev/dax0.0 
> didn't trigger any warning or panic after enabling DEVMAP_ACCESS_PROTECTION.
> 
> PS: ibv_reg_mr() calls page_address() in kernel.
> 
> Do you know if some hardwares(e.g. CPU) need to support PKS feature?

Yes you will need Sapphire rapids hardware or newer, or qemu 6.0 which also
supports PKS.

>
> how 
> to check the feature on hardwares? or do I need more steps?

My lscpu on qemu reports pks.  I suspect you don't have PKS on the hardware so
it is working.

Ira
