Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261D4BFBB4
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 16:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiBVPCU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 10:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiBVPCM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 10:02:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD715DB16
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 07:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645542044; x=1677078044;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IXEIDUpXv+U9Dlhfh33dZVe3bKnrojbKumN5u50KbCE=;
  b=Up3xyO1Wz53PxwwNFihTbfxU9qK+soYIIJGmad0s6aHBGJmIoFabM2nL
   R7dBnaMPhn4QVAmWn41rA7mOKE5qXFI2X4vNaqGh6HhcvpRrhMUiLHiYP
   q4mv2q+MNlDHT0Cz54Jjw2mXfKQWsfx+pHkvOQucE1OQX7AKngQMUviHY
   odm7u4kZeHrSk76gSYIGCXP0xUHvftx7k30ZJbQfdKRFnuYa3c8GLs6tB
   hOZI4StFaPkmalggZgE6ctZksy/ENL4LOpAR7/uYE++g0/doDybg7UQR2
   mkh/Pu5jMIoxUePX3dKqE9Vy+i1hi8fTkkZ5hGF1qq6WlGt01nlCbJERF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276323297"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="276323297"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 07:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532254886"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 22 Feb 2022 07:00:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 07:00:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 22 Feb 2022 07:00:42 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Tue, 22 Feb 2022 07:00:42 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCHv2 0/3] Use net_type to check network type
Thread-Topic: [PATCHv2 0/3] Use net_type to check network type
Thread-Index: AQHYJ9YTGv8HylwCbE2T8c45G+kUB6yfqe8g
Date:   Tue, 22 Feb 2022 15:00:42 +0000
Message-ID: <3e74ccf5d34145dda26a9f3e869c974d@intel.com>
References: <20220223024252.3873736-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220223024252.3873736-1-yanjun.zhu@linux.dev>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCHv2 0/3] Use net_type to check network type
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> The member variable net_type already exists. Now it is used to check netw=
ork
> type. As such, the variable saddr is redundant.
> So it is removed.
>=20
> The union irdma_sockaddr is used in several functions. So it is moved int=
o header
> file.
>=20
> Zhu Yanjun (3):
>   RDMA/irdma: Use net_type to check network type
>   RDMA/irdma: Remove the unnecessary variable saddr
>   RDMA/irdma: Move union irdma_sockaddr to header file
>=20
>  drivers/infiniband/hw/irdma/verbs.c | 26 ++++++--------------------
> drivers/infiniband/hw/irdma/verbs.h | 12 +++++++-----
>  2 files changed, 13 insertions(+), 25 deletions(-)
>=20
> --
> V1-->V2: Modify the commit log.

Thanks for the clean up.

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>


