Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D4F12E87A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 17:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgABQJo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 2 Jan 2020 11:09:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:58327 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgABQJk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jan 2020 11:09:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 08:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,387,1571727600"; 
   d="scan'208";a="231850442"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2020 08:09:39 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 08:09:39 -0800
Received: from fmsmsx123.amr.corp.intel.com ([169.254.7.87]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.70]) with mapi id 14.03.0439.000;
 Thu, 2 Jan 2020 08:09:39 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
CC:     "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>,
        "kjlu@umn.edu" <kjlu@umn.edu>, "leon@kernel.org" <leon@kernel.org>,
        "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Shannon Nelson <shannon.nelson@intel.com>,
        "Singhai, Anjali" <anjali.singhai@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer
 dereference
Thread-Topic: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer
 dereference
Thread-Index: AQHVvrhzchRnSKHHyEuZXScGHS/Gk6fXj3Rw
Date:   Thu, 2 Jan 2020 16:09:38 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7C1DEF336@fmsmsx123.amr.corp.intel.com>
References: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
In-Reply-To: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODBhY2NjNWQtN2Q4NS00OTg4LTkyNWEtNTgxZDJiNjk1Y2M5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV0RweXNBWjVvdDBIQU9MbTBieTk0WFFnSUUwOVo5Ykw0NkpzckVpVDBNbHNpZ0lpS09mazVSMk5yKzh1cUo3TiJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer dereference
> 
> A NULL pointer can be returned by in_dev_get(). Thus add a corresponding check
> so that a NULL pointer dereference will be avoided at this place.
> 
> Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changes in v2:
> - Release rtnl lock when in_dev_get return NULL Changes in v3:
> - Continue the next loop when in_dev_get return NULL Changes in v4:
> - Change commit message
> 

Thanks! Looks ok.

I believe Leon caught another issue in how rtnl locking scheme is done in this function.
Will fix.

Shiraz
