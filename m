Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFC06DFC33
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDLREX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjDLREU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 13:04:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C897AA1;
        Wed, 12 Apr 2023 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681319034; x=1712855034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CCI5vdMDQ32zyybDFo0kYBNffynl+QgA6oXYQgZ7vvE=;
  b=TYC6WT8u7jvr2w46JdnsBqj/pMwVV7gdkBpYkyE49LlJS5VE4KmadxVI
   Nobw13hzmnlIpSJTLxgnu+wxOooeP3SHyerYjgnhR7iEnwvA7/c7QIv/G
   XXc0IRDRqRzqlek6+awIDsYv5WGwsR51zw6RPtQKceDuRFj8lBTKi79M2
   89JxjnQCPHOwpWj1cRqihEXypkhlOGVm2Aqy+gzncG9SwZH+r7g0VGZVl
   STYhG+2HLK2aTzy56zGaMZgqfPkSfMqSH+7kMVZaXcXcMkv/gvlnmn2xq
   e/3GKZYKnLdkkWdvO8OcAb3sXdW0YH445NYAYuz2jypu1NrdA0Apz+54S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324322654"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324322654"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="863380210"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863380210"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2023 10:03:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 10:03:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 10:03:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 10:03:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 10:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBgDmUreFxtu8BjTumyvcl1p/RFjhdOJQQ881ZDS5C14eg3YbHITVgvRQOQWC4An4bZVwsdBFAXObTWlQyPGAMHsdakKocylVWiGQ+k1lVseYt4gL8swsXhkOlrkpdt4Q+l02f6qlKCkab/+Id/dd86UGTwiNnCo+49vvMImeirxv1kXoUy0i0C7RF6EJYY+XRDDSwDP/qFxc6lr+nTOwCy6J+IP3wvQwysREeAFix3zll0U3e1FmOTZv8pQE4S0Ao9BA8RYcE3CfMHOBV6VhTOzrV9l6CHoIbYQlOxttUfLeHQvuRKqDk7dZEBDCzK4usa1toNx2aMFNu8iBXtliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhp288H7DlaVrmJytZ+m5t2n1KtaU5K6SeSz+f10LYo=;
 b=eqvwiFSmpwipp5a8lQKZWZ6EDJGP3BXsmN0RiC3GXX5iU59sv4hVaMUL9WF43pT4Bw4WRwJKPBu5zACBAuCFFiz/SMZHZMwiO3xcL9r7Sxtqbq6/ODu6UFVVP4/ygyTrFwOvSEJQvR/C75pwsdBTuA0LEbnCMbxchOi6yiIF9jzy3mx6zFXAh4P9j1aUEF5WmsISc2cEsuFAThp88l7HyKPUzVYodA4J1nz65KUof14hrcieRTSIeTkb2m/VSWb1LbLTBMY9KnqvweYaQYgPwJoaOjT4HU29AhvEWTBNRJxorD88Ioo5bwcC/JqbPYv8pORX5CXd9kvVhrl9Yghs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM5PR11MB0027.namprd11.prod.outlook.com (2603:10b6:4:6b::33) by
 DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Wed, 12 Apr 2023 17:03:09 +0000
Received: from DM5PR11MB0027.namprd11.prod.outlook.com
 ([fe80::ca98:df63:a871:ce2e]) by DM5PR11MB0027.namprd11.prod.outlook.com
 ([fe80::ca98:df63:a871:ce2e%3]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 17:03:08 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Slightly optimize irdma_form_ah_cm_frame()
Thread-Topic: [PATCH] RDMA/irdma: Slightly optimize irdma_form_ah_cm_frame()
Thread-Index: AQHZN0RBkLZHJagV8kuFFqdb+F1IBK8oQeeAgAAOINA=
Date:   Wed, 12 Apr 2023 17:03:08 +0000
Message-ID: <DM5PR11MB002716440E31D3806A9658A2E99B9@DM5PR11MB0027.namprd11.prod.outlook.com>
References: <098e3c397be0436f1867899245ecfe656c472110.1675369386.git.christophe.jaillet@wanadoo.fr>
 <ZDbWJcqTbCducrUO@nvidia.com>
In-Reply-To: <ZDbWJcqTbCducrUO@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0027:EE_|DM4PR11MB6552:EE_
x-ms-office365-filtering-correlation-id: fe1ec942-b714-49d9-bc6a-08db3b77ca62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HaYcvcJ9j+M7puPfHV25DO5mp27SlTKsW/YRF6yEU4TRsbx7kmucTXv5QdpiCn3s3D0y4NXYCLGM4H1ZnDWOCNTOGUzd4/Lo8JLtW8DdCw3rzukHByAcUpS9KfC28mnnI3LqyQHVO4Sy+lchVvN/ntfVpMWLjJzgclfPK5/XbD+3y8uLznQ6lwchXQ1Oboqlo1cIRQlaCCtWjDqS7Y059HvS+HPFVTyxMfPtGdzH8R0vfHSb8gI/e2+rQSY0ZcW/aKXPjEr+pHFtfFX0jcZ4iPqOaYQtcHGrBEA++cINHJSy6Hecvfy2+cV67Z/yVkMfZmDWP4fnLg3GZN3wNsy9zWXPjwy5gOMf1Tq44lHGvPngl5R6OJeXiNmyng/0zSA1FlkQOdGUeAnzst8zT9oowc7fDIbetLyfjUTJPKK3NokNTHx+B5Udm+N7aDBvZ65KIc2Tzhj8vVUkOmn9UZKmERbpq42krUDuRWgmGvJPzjonKv7pyP6LJPodkN/S50EiRTXz9gnKHB/SbpNLg67NBGTJyQaP/5sEuAJBfTSIf5tHy9GD4jtiFBZfFMlSCRPmbFyp7ot7eWqAQ2D5UBbsf8RhBc6qbrpvHGyA7bByXevdHD43oOjQeIsSXuDWoF3p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0027.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(478600001)(5660300002)(66556008)(4326008)(82960400001)(66446008)(8676002)(38070700005)(66946007)(66476007)(55016003)(83380400001)(2906002)(122000001)(41300700001)(76116006)(52536014)(8936002)(64756008)(6506007)(186003)(33656002)(9686003)(54906003)(110136005)(26005)(38100700002)(86362001)(316002)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YRL7cdEOu3b+fJ/vejW1BR/rub3A0u2sncOdPZ6JNmhPLgUZEELV+XXfv9SU?=
 =?us-ascii?Q?hB4Xof8YAMMhiMKSvfITkd8vEAxyEfCxcgdT8k8xaD7dzQs2OTUPkL70RU8S?=
 =?us-ascii?Q?++bF/FDY1RuwHTbka1cNtoY01KYLv9jCNfIb9yYGuyB+ZWCZHQBgZWZvFwzx?=
 =?us-ascii?Q?Y0Uzc0fKjMqTMPvV/vXB9B/gnB+w1aeUgWpPgPG+mKdYFXLwVqXQZCY2+OPU?=
 =?us-ascii?Q?BwQO3LP5oNpcJyYFyMJTNTE/xs5swDgldVXdImFGIGthZM7i34qYHf9tlL6G?=
 =?us-ascii?Q?GbGAVQae1Qwt1wOfgIDNxYs7xj4joxhKYEXBjcNK6UGQK197AkjGZ1rmHv29?=
 =?us-ascii?Q?yMdYQGwoQbGgVRS9F/a+ogkPjaepLLnGm34jbqIiW0TXeIBJKtD4rPmlxNlP?=
 =?us-ascii?Q?LeCNbWHcTF7VPhQNMajfD27HzyTVwOkLiGd6XV6rM9eidHNppu3lklfUTUHj?=
 =?us-ascii?Q?eBIxYGNtKj3KULaJrf1YLTHZCvFwAp92SGTD1AKxEC7gmF62pT5tMwrN6a4G?=
 =?us-ascii?Q?kWGGh7zf8tWCR0VXlrJVwG8eHJAfEfU1sFzo/C827Xi3HsyGfLQg0BB4THw2?=
 =?us-ascii?Q?F1iopaxFXbekY/g1v3MgUwTXCCdG3UAriQ9OTDySbKRS7mymwzj5YeviOplE?=
 =?us-ascii?Q?gtnfXft4qtlkUrmE4T28a30Jjri/0oDs41Y4mHOHNYybiyx50O4nOD52OSEs?=
 =?us-ascii?Q?jgiQmjQTT1mxMrDTkC5hb5e73viC12441CML3pO+MfOEQvj5Nc51Qq9EIITu?=
 =?us-ascii?Q?K2ufXcckoWQAq50mHO41JUQSNLP+Oq9IDVo2NKk0u/EW1qzNgGy67whkq0UO?=
 =?us-ascii?Q?U94AjtGxc1ooALYMM9+1ivTWHQLtWmJz1HPgvDLSgHDqLkIFuX2dQthxg9Xi?=
 =?us-ascii?Q?vN3wEw5nqO5qZyCbG2FvfUIK9lLnlXRGbk1dadGa7fN80w6rBNdE+ylzn2Ax?=
 =?us-ascii?Q?ydHG9T0Q8WiETo69VVgTJirlqsMzQGIoU3dH7Fbd+gO5919dpBJmJDVpPz02?=
 =?us-ascii?Q?dU55HEmQaAsWznZmm3SQpVHWe4GGtwlhhdF58SLlnZ52JvDegrFdlybUzH0M?=
 =?us-ascii?Q?A8LPgCJccbCyoIymEUUphlfaeGEsuIM7YgXmj4779kvkcfB+W5eovbmgvkrV?=
 =?us-ascii?Q?z4/egtYXFN4JOrQKWswsPL6DRwQS7y7/mSjQ3Gc+5C6PmI5Nm3Wry6CmjX8H?=
 =?us-ascii?Q?YEVhQ2QQEKAI2IUngSK6JOfUn5RmPEDDYPgQocJksg8IVxxFPpHr62Wi9YIP?=
 =?us-ascii?Q?fTKpYq2OokI7U116wmWsLz78Kr7tmY8U80/UTCJW0MaHosVWezq7IEj17bCR?=
 =?us-ascii?Q?bqWTUjym0l7BiDtNBShpcm5R7uu/l4QEtqK9Q9aGfBJkRMo2OhbGGxxcOV4k?=
 =?us-ascii?Q?+CjUX0POUzupdbTRB5xK1WfnFeerQRk6hj0oJxHLjaMlXFgBYGembi/J3r4t?=
 =?us-ascii?Q?21JQNBb9IUYEYrfzdC0PDmRAV7eVvQOoEeflPoUwd8m2OKA2HaI30Hiwn6Im?=
 =?us-ascii?Q?yYa8Qjq5+ns2Tt33CB62Ege5FsaAAWHC9+0gy3U0Xi5yp2Z6Q2/mOfq5Oqo4?=
 =?us-ascii?Q?ChG+lflvrVpNd5pv4YMN5iTwhPlCoExIMDPir2ji?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0027.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1ec942-b714-49d9-bc6a-08db3b77ca62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 17:03:08.5280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCXwQEhZ7QEY7CLGN4SsllS925S4NtT1ZSjkXJZZCPtDViwBAFbR4RCZnU203XL2T67Qy8hYT1yTWUpDwlFdkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH] RDMA/irdma: Slightly optimize
> irdma_form_ah_cm_frame()
>=20
> On Thu, Feb 02, 2023 at 09:23:24PM +0100, Christophe JAILLET wrote:
> > There is no need to zero 'pktsize' bytes of 'buf', only the header
> > needs to be cleared, to be safe.
> > All the other bytes are already written with some memcpy() at the end
> > of the function.
> >
> > Doing so also gives the opportunity to the compiler to avoid the
> > memset() call. It can be inlined now that the length is known as compil=
e time.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Just in case, here is the diff of what is generated by gcc 11.3.0
> > before and after the patch.
> >
> >  .L736:
> > -# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, pktsize);
> > +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph))=
;
> >  	call	__sanitizer_cov_trace_pc	#
> > -	xorl	%esi, %esi	#
> > -	movzwl	%r13w, %edx	# _194, __fortify_size
> > -	movq	%rbp, %rdi	# buf,
> > -	call	memset	#
> > -	leaq	104(%r12), %rax	#, _259
> > +	movl	$0, 16(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> > +	leaq	104(%r12), %rax	#, _295
> > +# drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen =3D pktsize;
> > +	movzwl	%r13w, %r13d	# _192, _192
> > +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph))=
;
> > +	movq	$0, 0(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> > +# drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen =3D pktsize;
> > +	movq	%rax, %rdi	# _295,
> > +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph))=
;
> > +	movq	$0, 8(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> > +	movq	%rax, 64(%rsp)	# _295, %sfp
> >  # drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen =3D pktsize;
> > ---
> >  drivers/infiniband/hw/irdma/cm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Shiraz??
>=20

Sorry for the delay as I didn't see this earlier.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>


