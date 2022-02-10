Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DADE4B17F2
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 23:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbiBJWJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 17:09:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241875AbiBJWJn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 17:09:43 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0FE7B;
        Thu, 10 Feb 2022 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644530982; x=1676066982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XyOoywc4THLPzW+PmVQhClugtwQHmT6Xsd0BZq1fpE4=;
  b=CIEZ5lokxaYl7LA+gppQ+CyMiZ7XODF2t6MBTQSIhWvl7xULsI9sqmHs
   IGL/ql10MJJ9sSsXydVmSYOAo/rWlyrrtuk8uAVh8TwTc9KIYcDTazzii
   VBd19i/BkxkmQN5uNnzp4F0Xm1P5PPOY8OlyuIiLKH2Bn5YdVXTb+FD91
   soS1Heyh/tC6g1HlL9x9M5/OStDpNkhpHYKkjKWKGMPKcfkfC2ud3du8k
   ic06BjNrTJ+9PZxuuVMOGm0llpRv+4mmD4WowohTkhH2b1zjIG/v+h0TZ
   RT4AbTkYKCihpVjnbsc01MS6PGw1ulc1bb65ro7FtfFyHst+JI82ueoNz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248435960"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="248435960"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 14:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701862618"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 14:09:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 14:09:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 14:09:18 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Thu, 10 Feb 2022 14:09:18 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Victor Erminpour <victor.erminpour@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Fix GCC 12 warning
Thread-Topic: [PATCH] RDMA/irdma: Fix GCC 12 warning
Thread-Index: AQHYHhXpIKGNtR9Qu0Cesy+E4ixcfayNV7Tw
Date:   Thu, 10 Feb 2022 22:09:18 +0000
Message-ID: <35240f17968242409a39427c303370df@intel.com>
References: <1644453235-1437-1-git-send-email-victor.erminpour@oracle.com>
In-Reply-To: <1644453235-1437-1-git-send-email-victor.erminpour@oracle.com>
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

> Subject: [PATCH] RDMA/irdma: Fix GCC 12 warning
>=20
> When building with automatic stack variable initialization, GCC 12 compla=
ins about
> variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
>=20
> ./drivers/infiniband/hw/irdma/hw.c:270:47: error: statement will never be=
 executed [-
> Werror=3Dswitch-unreachable]
>   270 |                         struct irdma_cm_node *cm_node;
>       |
>=20
> ./drivers/infiniband/hw/irdma/utils.c:1215:50: error: statement will neve=
r be executed
> [-Werror=3Dswitch-unreachable]
>   1215 |                         struct irdma_gen_ae_info ae_info;
>        |
>=20
> Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c    | 2 +-
>  drivers/infiniband/hw/irdma/utils.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/ird=
ma/hw.c
> index 89234d04cc65..a41a3b128d0d 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -267,8 +267,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
>  		}
>=20
>  		switch (info->ae_id) {
> -			struct irdma_cm_node *cm_node;
>  		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED:
> +			struct irdma_cm_node *cm_node;
>  			cm_node =3D iwqp->cm_node;
>  			if (cm_node->accept_pend) {
>  				atomic_dec(&cm_node->listener-

This doesn't compile.

drivers/infiniband/hw/irdma/hw.c: In function \u2018irdma_process_aeq\u2019=
:
drivers/infiniband/hw/irdma/hw.c:271:4: error: a label can only be part of =
a statement and a declaration is not a statement
  271 |    struct irdma_cm_node *cm_node;

Seems like we are accommodating for gcc12 bug since this C code is legit?=20

Shiraz

