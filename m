Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6A131D79
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 03:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgAGCIo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 6 Jan 2020 21:08:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:8223 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgAGCIn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 21:08:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 18:08:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="217583466"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2020 18:08:42 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 18:08:42 -0800
Received: from fmsmsx123.amr.corp.intel.com ([169.254.7.87]) by
 fmsmsx158.amr.corp.intel.com ([169.254.15.85]) with mapi id 14.03.0439.000;
 Mon, 6 Jan 2020 18:08:42 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Xiyu Yang <xiyuyang19@fudan.edu.cn>
CC:     "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>, "leon@kernel.org" <leon@kernel.org>,
        "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Shannon Nelson <shannon.nelson@intel.com>,
        "Singhai, Anjali" <anjali.singhai@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer
 dereference
Thread-Topic: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer
 dereference
Thread-Index: AQHVvrhzchRnSKHHyEuZXScGHS/Gk6faLOQAgARUNiA=
Date:   Tue, 7 Jan 2020 02:08:41 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7C1DF97F0@fmsmsx123.amr.corp.intel.com>
References: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200104000128.GA20711@ziepe.ca>
In-Reply-To: <20200104000128.GA20711@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjI0MGQ1YjMtZGMxMS00MGRlLWE1ZTctNGI2ZTdlMDk2ZTkwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibDJqaU1hdDUzbzg3MGVnT2k0a1VDenZhd2FYbnRZTUNCdkFhT2xoQ1o0UkhDTTU0aDk0ZGV1eGk3WGZGOExCaSJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer dereference
> 
> On Mon, Dec 30, 2019 at 10:24:28AM +0800, Xiyu Yang wrote:
> > A NULL pointer can be returned by in_dev_get(). Thus add a
> > corresponding check so that a NULL pointer dereference will be avoided
> > at this place.
> >
> > Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> > Changes in v2:
> > - Release rtnl lock when in_dev_get return NULL Changes in v3:
> > - Continue the next loop when in_dev_get return NULL Changes in v4:
> > - Change commit message
> >
> >  drivers/infiniband/hw/i40iw/i40iw_main.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Applied to for-next
> 
> And Shiraz, Leon is right, that trylock stuff is completely wrong, let's fix it.
> 

Sure.
