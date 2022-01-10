Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BAA4899E7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiAJNZo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 08:25:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:54314 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231574AbiAJNZo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 08:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641821144; x=1673357144;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HQ/3n4S06vvTQHOszr0j6s3WlVgDNpMQOLs0bMdPhlQ=;
  b=O+Hcoqw85JlXfmhxSPc28NRkavNfx6/lAAer0DI1XgId26abMlOCP71i
   ehdD+qoRHSo4YCRRGq8vPwcDV97vD6+7AHcl9cqk/D7AE+Cxaaq0HYHau
   XbZAATWeV9xu/LQFrtm6dTb1WABerZBsvzd81ZZ19qCAw/T9mADmYsjCY
   RCa2TzUKxdp//c6/modMjGXVzXo/T9Zt774d91PZZUQNZN9QS+b4vXcU9
   hxTEmvkv1gaiJHDG1bVeR2yizOaxj+H53qYc/Umga+A3kWq5vm2EpZHE9
   kRFhD3dYyhi6kCwOag6NDp57Ds8SKYrIhSzV67r8QKbllNynFR5evBbol
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="306578249"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="306578249"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 05:25:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="619435009"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2022 05:25:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 05:25:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 05:25:42 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Mon, 10 Jan 2022 05:25:42 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/1] RDMA/irdma: Remove the redundant return
Thread-Topic: [PATCH 1/1] RDMA/irdma: Remove the redundant return
Thread-Index: AQHYBWuoATSDrJNP00SLzql17u0t3KxcQDqQ
Date:   Mon, 10 Jan 2022 13:25:42 +0000
Message-ID: <e6e87cb0b6614218b41016c746fb40fe@intel.com>
References: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 1/1] RDMA/irdma: Remove the redundant return
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> The type of the function i40iw_remove is void. So remove the unnecessary =
return.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
