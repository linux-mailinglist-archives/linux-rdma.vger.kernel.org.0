Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800454D1DA7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiCHQq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 11:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiCHQqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 11:46:21 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B646517EB;
        Tue,  8 Mar 2022 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646757924; x=1678293924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HyZRbGzpHUnX+YRNPig+HFSAnUpT4TU+rGtpaM03kAM=;
  b=n5ZpWKMlkQCVCAAxEi2gPk6pP+Q5eqX0QTfFvTct3I1nhChjC6mXyUFB
   leKQWj1RztlwGdaw5oTdu4auwccZV/3sxOmpaqoxPm5ELkKfipXacyxNy
   WvkRqKv7CDB19giUzN+1BTSxDr2g7m1toP8yk3efRogYyge1B25EDY8nr
   /PhX8C4CoeAeo2vlUKZhitAa784usj8OFsal5cDa0OK3KEQOLxSx+mTm8
   YIVykuVeMNohfzhZ4NkDOkUC/dPy2lAbGrDM5TtQ+D8eaOP942IC7hGvB
   f4JxcXw+k74Q0cuMVPgapAzvQgEO5tnGF7SPkMdc5C4QVBJIskkS//6oa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="315452594"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="315452594"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643715338"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 08:45:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 08:45:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 08:45:21 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.021;
 Tue, 8 Mar 2022 08:45:21 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: prevent some integer underflows
Thread-Topic: [PATCH] RDMA/irdma: prevent some integer underflows
Thread-Index: AQHYMiM6QKDgQOKRRUCRcYiXtLkR6ay1kq8w
Date:   Tue, 8 Mar 2022 16:45:21 +0000
Message-ID: <ef3d0d8dfbc54f3fa4addda8e131c909@intel.com>
References: <20220307125928.GE16710@kili>
In-Reply-To: <20220307125928.GE16710@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/irdma: prevent some integer underflows
>=20
> My static checker complains that:
>=20
>     drivers/infiniband/hw/irdma/ctrl.c:3605 irdma_sc_ceq_init()
>     warn: can subtract underflow 'info->dev->hmc_fpm_misc.max_ceqs'?
>=20
> It appears that "info->dev->hmc_fpm_misc.max_ceqs" comes from the firmwar=
e
> in irdma_sc_parse_fpm_query_buf() so, yes, there is a chance that it coul=
d be
> zero.  Even if we trust the firmware, it's easy enough to change the cond=
ition just
> as a hardenning measure.
>=20
> Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20

Seems reasonable.

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>


