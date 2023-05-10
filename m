Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA616FE0C9
	for <lists+linux-rdma@lfdr.de>; Wed, 10 May 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbjEJOtQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 May 2023 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbjEJOtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 May 2023 10:49:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC396A68
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683730154; x=1715266154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kD8IgCRzlgsuVptSSvD6RLzF0ZEsSjGFTB1KBM9JAGk=;
  b=Z3KmDBZ2k35POou7HLeE2R2wUKO+KqejaH7UPuwLZBE35swFQvtiuj6z
   ii1/qdDPXS2DN3rTl7cNNc0YES5N18wssUib280uvYgXJOabpCNfvpP2/
   yuNEpy7T8erFekvJFwT2L8XGqtgWQTeWsMRI4dER4q+paVAU5t78SsxSA
   cSRcXus9rvhwKJop5DePqVE+3zXDz8Hq9LHLeA57DaM7FMDofI0SWyshY
   debtjYn3/vuqc8XW2CJ0Av+ik3EnqrklBuL5EwFDwT+mmluI9XCVoBg2r
   OZfZ0AeoAaEe15NVba7dSXh6ee0YCvopjr5LbfUtSvD/bvqsKa60B7jBO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="329847778"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="329847778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 07:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="764318842"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="764318842"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2023 07:48:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 07:48:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 07:48:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 07:48:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 07:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDWrnzQ4BHoomwVwTmCc96XGxgG/B+tz2eWN/idZT/e5Judo34xTZ+nWue5svFRNmbHAFGQS6gYyK1JE9wFMQBgZOmE1N8T8BQiyZvy6oSAoikJguSz9ssATPRxUcPwSAvr50D8H6xy8t+iWMLdwSR3JG23GeDJpLoZvyLV0HdkCMEb+ZsPNWTEpmWPpuLuMXZp+R1yvGmnc6gbdKfMka31Nlcx9kzMe6O5fp2aNY5b9GzaaQ6SKTFhS4Gi+1fBYcgHMKf5OQwP+1ulNGwWtXyqaATrMcCwx2TY7ysK1sJnI8z4i50cUqOG0tn+GX+xD9rHXMVERa5sDoaBe9HEpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPksCt0R1di1IgadcFn+u5gB5E+TPnWDWdL0Cc89N1A=;
 b=SDLo0WdgkKaclfCRKb0dHzYwwmmq48ctnwnZ+LYbPAq050yRC3Ygs7OxJ7b+O3gPjdH+vaHhUcNDea1UvVmxf2EXairpnCArn1Ga+uoeSddoEtHxO6PYeX1GAaafQpcqbdtiya5WDcQn4oNbNWAjH8mcnQKIhDPuEq14Pu3m8+q7cf3Keo0CO8o8VndCYEORw4rpOYE1HrdDsueJcALK361kj9YjlSBq7/30RE6TOV9xFX8p37uutdmm1My1dkULOL8VAlThq29eYEnOkKuAAyZj9rrqKmCZpl1dxBKF0CfbAneLBMYXFtxWU9ntOoAqSmk6uqxkjS/a5q2TDihXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 14:48:40 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a29e:39be:c1a:d73a]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a29e:39be:c1a:d73a%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 14:48:40 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kamal Heib <kheib@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Subject: RE: [PATCH 1/3] RDMA/iRDMA: Return void from irdma_init_iw_device()
Thread-Topic: [PATCH 1/3] RDMA/iRDMA: Return void from irdma_init_iw_device()
Thread-Index: AQHZgoXMFtwOGjUS2UGUorRAzuLUTa9Tl35g
Date:   Wed, 10 May 2023 14:48:39 +0000
Message-ID: <MWHPR11MB0029473794101834A57328A6E9779@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230509145127.33734-1-kheib@redhat.com>
 <20230509145127.33734-2-kheib@redhat.com>
In-Reply-To: <20230509145127.33734-2-kheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|CO1PR11MB5138:EE_
x-ms-office365-filtering-correlation-id: 2359708b-23e1-4b14-15d2-08db5165a4b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +DMY+K06gNupqZc6SIri71J7028rgUhKYeh5jl6MasSUn132RaYlSQV+IPnQosN2buPso8hdx8K8EpCgINVKn71idAF7wwpmpZIqwO+JC78Sj6OOVmzuVVjAnFaSQKYaf29pO1szfAPMR1VMW7ieNVGJdPEGBmyqumm3mUO2K2K/q16j/J+6eNZkEI3ILCVhVXTFhzsE1F2iYvvDRtHroeawf1qqtVMJsQQlhb03XgfhNT/1DfjvTdootpd8KjTf2PSlPbSeZp96NW8LXPuG3uWVljN7Iy5Qpvrj5zCh7JpZtzUTn+WDh26JOh+LOofm7sBVciryfpzi/C/8K+VTfbtvwlQbswgGKXt2bfUCNSN+5PpI8e+MpCXPr3K+Z0NIjn8Lv7PBzTOC6wW7IfrCru5yt3Bd7AfkBXhYvIREwnoSNLvQB7rjb0YaVbcdbaIH4wNnWvDSZOLuSxRu/cUBq/W4TLQWc/aTf0D83uUYxFgeemHjo24MsUougjvC5G9k2Yt/f7dny3iYezxon061/qrzoT3rOQPWzKTb2PN99CKVkJhpFO1zw90mNhg/OjkF66YccnVpByJKw60wYjMxpkJGyznmMvD9hN0YpqvBUIlrXi+7Z7pI+DzBQOBYnZOA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(86362001)(83380400001)(55016003)(110136005)(478600001)(8936002)(8676002)(52536014)(41300700001)(5660300002)(2906002)(33656002)(316002)(4326008)(54906003)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(71200400001)(9686003)(6506007)(26005)(186003)(7696005)(82960400001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K0Ed7ZLfe9VKgN1hlPUWVPEApnHR5K3FWovz67RCR7S56guD8mQxmc5KgCaQ?=
 =?us-ascii?Q?qP35sJQFC2zqnoKVn5R0qtrNEFKaZ2efmmhWJcIj8njErEoqYTcnArwFJc7o?=
 =?us-ascii?Q?/p6deP601//Hg3yCpw0hvI7AWe88urpzkLKEnqfdA2ljzJKylDgUb2YNH3Hg?=
 =?us-ascii?Q?ddGk3nXmXC7LNQRPlonBBwZ+6wi+F3tezPK+v/FcBhRfKvbz8iV4VZKJZHCj?=
 =?us-ascii?Q?rOLXEBVEdD/u/CvC7vA146BWIIE3Ltxn+WYb96MogskOYw29EUyZPB4pTQHZ?=
 =?us-ascii?Q?NsdWqmmXRV1E0j5B63UhYJKs29CapOFHfdSKFMmEAemm1qoW1eZsHZcnF3iR?=
 =?us-ascii?Q?15wrDPTyzWdE8hofxQqEweE4rzkoObiYdP0qkKu46pZ2ogFRyo3auuPxkVzE?=
 =?us-ascii?Q?o7mffaFevfHgE0f4ZTnb7Dzewe+MgwJiTP6vGn6DA01XTffGIyAEedfBdjbU?=
 =?us-ascii?Q?btPEGKopiWJ7299M5ooySZVrCGvx+W5QeZRAZkwycAGVsoooibtUGJwBEarb?=
 =?us-ascii?Q?ogtIMhuRKA/GUefiR+AFplElG4fYbVT7L3I2QTRQ/Yu00onPD8Ope8Xwui6v?=
 =?us-ascii?Q?hAu5nSPWm+G5gjtrEkDz/5mcW1hlhCAlCU7LZ/5CzaChMwuoHscWch9uKRXp?=
 =?us-ascii?Q?R11iELg5fT6NrrB7/j1+mcxTQE7Z7VIxUNQGdPEz5aySpwlQCFpmLwxtGMjq?=
 =?us-ascii?Q?y9kUCGtXnxbiKJz0Z8e1IHjXeuTNhuVF70emiTlzNeYBljfeV+Iifaz85bFh?=
 =?us-ascii?Q?ciOEc00VzpNpWa5N1TpL+WI75dpfK8fPBV/2RAqHBtM3FmSR6dEd5ijxoatJ?=
 =?us-ascii?Q?bHBQLu+QFambJFm+Uu12aBSf46PyIvalZLLde4slP4QtmLrR1fId/uNwcH6A?=
 =?us-ascii?Q?9JZWPBzqWS0BeCl1wYgsYZuQrjvK6Tz8PnrValHbQx6zAsKqTMKNbrUix5qw?=
 =?us-ascii?Q?ptE1p+T8rjtZevvFd/VoUR2KgPG6ZdeCivzIioKqg4CrsyPvzzO70yVmWj70?=
 =?us-ascii?Q?uKJtY+L5SLLC9Lg/QGjh0Rg8Y1fZ9MpNyoa/6Vy5uR2MgdmzbQtv6te5Dy3n?=
 =?us-ascii?Q?zBYGT2bUegeKXhoEgCqChyYAZwgrzdKW2OJOhh2cxJ1jPmcse+tTMeK8wqgi?=
 =?us-ascii?Q?Gdo9MQ8kCXVDzV4B/AsVztreEKWUCKNzUzuu9OpWbCzoKsl4kiKlrukyYemw?=
 =?us-ascii?Q?IK6e4RXtPUcRmOTp6Qar15jjL6QAmiMTKOvZDyv1v35BnIblETWRAL2P0SHw?=
 =?us-ascii?Q?zEzltX73E7ZgkEeDbqT3HfFh6jX65llaKTcFodYMyrXybb406G2vFSCqsutR?=
 =?us-ascii?Q?zosHQa33YHY0ETqmPeRhnF1lA7AqGri5WsixAG0WmT6lRqQzOtgC929eLPb2?=
 =?us-ascii?Q?q+4+gMhEKmheY+/7mx6oHZLKcx115BxLQTCF7vz5fZTyVMKwwek+ykCQjpvf?=
 =?us-ascii?Q?eygYkzK7A0D4H0GgpGimismpBU9YmbykxsIhnee5iC6DnTyZXCU3ThOQD277?=
 =?us-ascii?Q?3zK+Ve6/3OZ4KtZq+1v2FRVjKf/iKSVz7n+7Rzb/ZFHz/oTQJcOFuhq/s/9o?=
 =?us-ascii?Q?0bXfxbb+cwvi8ih58p/aKDcdC+S5+KXjBrnZifRG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2359708b-23e1-4b14-15d2-08db5165a4b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 14:48:39.9499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPwXY5s6y8fkdJWYioaF1z3sF+oqodIZ1ieP16qrZrx2l8wM5RkMHzVfXTTAgFggnTofjPYcFCcOj1EQ/CDNsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 1/3] RDMA/iRDMA: Return void from irdma_init_iw_device()
>=20
> The return value from irdma_init_iw_device() is always 0 - change it to b=
e void.
>=20
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index ab5cdf782785..b405cc961187 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -4515,7 +4515,7 @@ static void irdma_init_roce_device(struct irdma_dev=
ice
> *iwdev)
>   * irdma_init_iw_device - initialization of iwarp rdma device
>   * @iwdev: irdma device
>   */
> -static int irdma_init_iw_device(struct irdma_device *iwdev)
> +static void irdma_init_iw_device(struct irdma_device *iwdev)
>  {
>  	struct net_device *netdev =3D iwdev->netdev;
>=20
> @@ -4533,8 +4533,6 @@ static int irdma_init_iw_device(struct irdma_device
> *iwdev)
>  	memcpy(iwdev->ibdev.iw_ifname, netdev->name,
>  	       sizeof(iwdev->ibdev.iw_ifname));
>  	ib_set_device_ops(&iwdev->ibdev, &irdma_iw_dev_ops);
> -
> -	return 0;
>  }
>=20
>  /**
> @@ -4544,14 +4542,11 @@ static int irdma_init_iw_device(struct irdma_devi=
ce
> *iwdev)  static int irdma_init_rdma_device(struct irdma_device *iwdev)  {
>  	struct pci_dev *pcidev =3D iwdev->rf->pcidev;
> -	int ret;
>=20
>  	if (iwdev->roce_mode) {
>  		irdma_init_roce_device(iwdev);
>  	} else {
> -		ret =3D irdma_init_iw_device(iwdev);
> -		if (ret)
> -			return ret;
> +		irdma_init_iw_device(iwdev);
>  	}

checkpatch doesn't complain here? This becomes a single statement if/else n=
ow. No {} required.

>  	iwdev->ibdev.phys_port_cnt =3D 1;
>  	iwdev->ibdev.num_comp_vectors =3D iwdev->rf->ceqs_count;
> --
> 2.40.1

