Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20F39FC7B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhFHQ1z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Jun 2021 12:27:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:41885 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232790AbhFHQ1z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 12:27:55 -0400
IronPort-SDR: MWL3QvJgXPdxlBc7n2z5kKoyf24lY2XZ6GdgVnJMQ/934lXg+MziK6WMAeZxBFx9gAcsh6JtFr
 cSEqbGhgtonA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204846205"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="204846205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 09:25:58 -0700
IronPort-SDR: gNrDCuDq6P5kUMM0H/fvtT4SZTOhS+go+38GOIK6LBYXyf3Hu4VN66TqFRUyF0YaK5jkDyuheh
 kcOzf3KGDgIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619361419"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 09:25:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 09:25:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 09:25:57 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Tue, 8 Jun 2021 09:25:57 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Baokun Li <libaokun1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "yangjihong1@huawei.com" <yangjihong1@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: RE: [PATCH -next] RDMA/irdma: Use list_move instead of
 list_del/list_add
Thread-Topic: [PATCH -next] RDMA/irdma: Use list_move instead of
 list_del/list_add
Thread-Index: AQHXXBKZNDyHXK5C9ESBNIPEsoqujKsKTV3g
Date:   Tue, 8 Jun 2021 16:25:57 +0000
Message-ID: <3d6c5848d9a445398a6acd084ee9d3a6@intel.com>
References: <20210608031041.2820429-1-libaokun1@huawei.com>
In-Reply-To: <20210608031041.2820429-1-libaokun1@huawei.com>
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

> Subject: [PATCH -next] RDMA/irdma: Use list_move instead of list_del/list_add
> 
> Using list_move() instead of list_del() + list_add().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
