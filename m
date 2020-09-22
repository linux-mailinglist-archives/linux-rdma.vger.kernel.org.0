Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27409274D0E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIVXE4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 22 Sep 2020 19:04:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:58473 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVXE4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 19:04:56 -0400
IronPort-SDR: yZKaHg8nZGDVe3JGww8LVWjUjKwCcpzNy8J0y1ASKi9A1PmPZ26AtxB2hfr60x9oycnrO7EO7i
 qTwsr4ENz4UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="222322283"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="222322283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 16:04:55 -0700
IronPort-SDR: PB5aubxtEwGLUfXuho276dZEs5GFxhXvldV/WeDZbW1/snDpiZK03rKWXGCTHlangTdNyKDFNO
 J18wFvhQ+ERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="335226919"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2020 16:04:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 16:04:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 16:04:54 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Tue, 22 Sep 2020 16:04:54 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        Kamal Heib <kheib@redhat.com>
Subject: RE: [PATCH for-next] i40iw: Add support to make destroy QP
 synchronous
Thread-Topic: [PATCH for-next] i40iw: Add support to make destroy QP
 synchronous
Thread-Index: AQHWjEH47jGDlHQww0qVUjA3jPNtkKlwJ5WAgASv39A=
Date:   Tue, 22 Sep 2020 23:04:54 +0000
Message-ID: <391f35828d9949f392129362b234055b@intel.com>
References: <20200916131811.2077-1-shiraz.saleem@intel.com>
 <20200919091511.GD869610@unreal>
In-Reply-To: <20200919091511.GD869610@unreal>
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

> Subject: Re: [PATCH for-next] i40iw: Add support to make destroy QP
> synchronous
> 

[...]

> 
> I always wanted to ask, why do iWARP devices have this gp_get_ref/qp_put_ref
> logic? Does it come from iw_cm in-kernel implementation of from some iWARP
> specification?
> 

I think these are just implementation details and how iwcm is designed.
And nothing to do with spec.

Shiraz
