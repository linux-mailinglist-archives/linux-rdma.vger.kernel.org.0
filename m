Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52802338310
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 02:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCLBOD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Mar 2021 20:14:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:54312 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhCLBNn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 20:13:43 -0500
IronPort-SDR: D4qYg7KlaiOdsva5cU0EkVM/h4kn4dq+cVQwPT9GGsv1ES3Xc+t174UCQcsxTdn1MGgpM+EP25
 myIqCDFIan6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="273806413"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="273806413"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 17:13:41 -0800
IronPort-SDR: y5dFWgPnOW8K/nJpDOwNpO7r+81l3PahGImtvbYutxCacgLZ7Y5c2knvpnBr/3kPG7B8Jmnjzy
 YrsRIzLkerdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="589412542"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2021 17:13:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 17:13:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Mar 2021 17:13:40 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2106.013;
 Thu, 11 Mar 2021 17:13:40 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
CC:     "Latif, Faisal" <faisal.latif@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband/i40iw: Fix a use after free in
 i40iw_cm_event_handler
Thread-Topic: [PATCH] infiniband/i40iw: Fix a use after free in
 i40iw_cm_event_handler
Thread-Index: AQHXFiSqLozaSAmrJEO2QxUkby8zNKp/oHYA//+kHnA=
Date:   Fri, 12 Mar 2021 01:13:39 +0000
Message-ID: <1fc386d78c044d3da723fe38446edb75@intel.com>
References: <20210311031414.5011-1-lyl2019@mail.ustc.edu.cn>
 <20210311182114.GA2733907@nvidia.com>
In-Reply-To: <20210311182114.GA2733907@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH] infiniband/i40iw: Fix a use after free in
> i40iw_cm_event_handler
> 
> On Wed, Mar 10, 2021 at 07:14:14PM -0800, Lv Yunlong wrote:
> > In the case of I40IW_CM_EVENT_ABORTED, i40iw_event_connect_error()
> > could be called to free the event->cm_node. However, event->cm_node
> > will be used after and cause use after free. It needs to add flags to
> > inform that event->cm_node has been freed.
> >
> > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > ---
> >  drivers/infiniband/hw/i40iw/i40iw_cm.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> This might be OK (though I don't like the free variable), Shiraz??
> 

How was this reproduced? Do you have some call trace leading up to use after free?

The cm_node refcnt is bumped at creation time and once in i40iw_receive_ilq before packet is processed.
That should protect the cm_node from disappearing in the event handler in the abort event case.
The dec at end of i40iw_receive ilq should be point where the cm_node is freed specifically in the abort case.

Shiraz

