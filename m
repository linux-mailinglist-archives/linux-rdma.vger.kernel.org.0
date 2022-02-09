Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F584AF88C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 18:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiBIRbr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 12:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiBIRbr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 12:31:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E4C0613C9
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 09:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644427909; x=1675963909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0TFVWuK/nCFVuQzk5A302vjbCRhkOLom4WjH12OTgbE=;
  b=TTHWDpZjxyv4TGRvOVO4NMd1iOFrj96wkOXAfd0HkNLYHwTan9KnXpwr
   QD3emJj2eQmw4Uoct5nmJjZCaF9hvpuaMTdP8j30PRujnsGLDXe7UsX2e
   hvT1/UWMSbp9Fj8Ugf++Kg/Zunho8oAxmvSUGlmhb0ZLxv9K6sIGk6SjW
   i7uGu6FkwxXUmkVI3QQLxVvvZhE+O1nHciw7bwaZ+rh6YuSvQ1bj0cxwB
   CG5068Q6ekqPp+uPijcybBubk0H/UnY9sdlk+uvpKcDS3P9v1yWZci7w5
   XcrjeeX9Xq89OZJTiPOF7VsrNcVNhLpVvClgKi6RW5OaXlJpsg5Majua2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249473249"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249473249"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 09 Feb 2022 09:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="678723316"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 09:31:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 09:31:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 9 Feb 2022 09:30:54 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Wed, 9 Feb 2022 09:30:54 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Subject: RE: [PATCH rdma-next] RDMA/irdma: Add support for address handle
 re-use
Thread-Topic: [PATCH rdma-next] RDMA/irdma: Add support for address handle
 re-use
Thread-Index: AQHYDiTqTTnNFr1aS0aoakInNZNS8qyKcMQAgAEnmwA=
Date:   Wed, 9 Feb 2022 17:30:54 +0000
Message-ID: <57929d88b4cd43e7b284e0debe4d4db7@intel.com>
References: <20220120174041.1714-1-shiraz.saleem@intel.com>
 <20220208154936.GA171050@nvidia.com>
In-Reply-To: <20220208154936.GA171050@nvidia.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH rdma-next] RDMA/irdma: Add support for address handle=
 re-
> use
>=20
> On Thu, Jan 20, 2022 at 11:40:41AM -0600, Shiraz Saleem wrote:
> > +/**
> > + * irdma_ah_exists - Check for existing identical AH
> > + * @iwdev: irdma device
> > + * @new_ah: AH to check for
> > + *
> > + * returns true if AH is found, false if not found.
> > + */
> > +static bool irdma_ah_exists(struct irdma_device *iwdev,
> > +			    struct irdma_ah *new_ah)
> > +{
> > +	struct irdma_ah *ah;
> >
> > -		if (!cnt) {
> > -			ibdev_dbg(&iwdev->ibdev,
> > -				  "VERBS: CQP create AH timed out");
> > -			err =3D -ETIMEDOUT;
> > -			goto error;
> > +	list_for_each_entry (ah, &iwdev->ah_list, list) {
> > +		/* Set ah_valid and ah_id the same so memcmp can work */
> > +		new_ah->sc_ah.ah_info.ah_idx =3D ah->sc_ah.ah_info.ah_idx;
> > +		new_ah->sc_ah.ah_info.ah_valid =3D ah->sc_ah.ah_info.ah_valid;
> > +		if (!memcmp(&ah->sc_ah.ah_info, &new_ah->sc_ah.ah_info,
> > +			    sizeof(ah->sc_ah.ah_info))) {
> > +			refcount_inc(&ah->refcnt);
> > +			new_ah->parent_ah =3D ah;
> > +			return true;
> >  		}
> >  	}
>=20
> So, the number of AHs is so large the HW has problems but you propose to =
use a
> linear search to de-dup them?

We will look into optimizing this search.=20

>=20
> > +static int irdma_create_user_ah(struct ib_ah *ibah,
> > +				struct rdma_ah_init_attr *attr,
> > +				struct ib_udata *udata)
> > +{
> > +	struct irdma_ah *ah =3D container_of(ibah, struct irdma_ah, ibah);
> > +	struct irdma_device *iwdev =3D to_iwdev(ibah->pd->device);
> > +	struct irdma_create_ah_resp uresp;
> > +	struct irdma_ah *parent_ah;
> > +	int err;
> > +
> > +	err =3D irdma_setup_ah(ibah, attr);
> > +	if (err)
> > +		return err;
> > +	if (attr->flags & RDMA_CREATE_AH_SLEEPABLE) {
> > +		mutex_lock(&iwdev->ah_list_lock);
>=20
> User AH's are always sleepable, no need for these extra paths.
>

Ok.

Thanks a lot for the feedback.

Shiraz
