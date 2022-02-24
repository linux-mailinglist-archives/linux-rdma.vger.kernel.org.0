Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605B64C30C0
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 17:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiBXQCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiBXQCH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 11:02:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4E180207
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718488; x=1677254488;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=H6BSzvvx/6bYGd47+x8bHH2j6Wxx4xIYPxGTsZnBJSY=;
  b=Hse7CwlHYR5UahQLYslzZetdiOO3QoxjGwRvdfNb+v9m8mxhJpgNYiv4
   7CwBe3+9Dj+yOMHaU0SeaHVAaMwj4HX8VkDLHMHYyI8abMAJFoc91jTyt
   /pIBHyK7dAEu/VS9iJQz7iDjj4cByY40GsHNCtvTQkGRZpdsremLoot8t
   tdOZq1QXr7hrP7aEzJlCLBKoaTt+sAfI76wZK5k/5h/ZT50fV2zs82OK7
   hHBejFNmgwuhSkiBSiO92qAIrnW7fqsQYt7FDYeIdvO/to2kMKEPP2EuR
   81jWTthcMW07dniI+fm2X4UpoN/zAJF+Q8RmAsc2W1QHhP1jbwFV/dWo0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315488505"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315488505"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 08:00:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="684316837"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 08:00:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 08:00:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 24 Feb 2022 08:00:13 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Thu, 24 Feb 2022 08:00:13 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCHv2 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
Thread-Topic: [PATCHv2 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
Thread-Index: AQHYKSNcy1D/f5MAfke8rnqlun0XKKyi3Ldg
Date:   Thu, 24 Feb 2022 16:00:12 +0000
Message-ID: <4cefbef7f3b14726b20f4f7c37163d69@intel.com>
References: <20220224182832.3896686-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220224182832.3896686-1-yanjun.zhu@linux.dev>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Subject: [PATCHv2 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> The function irdma_create_mg_ctx always returns 0, so make it void and de=
lete the
> return value check.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Remove the unused ret_code and rebase to the commit 2322d17abf0a
>         ("RDMA/irdma: Remove excess error variables")
> ---
>  drivers/infiniband/hw/irdma/uda.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
