Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1F42FE8A
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 01:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhJOXL7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 19:11:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:50967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243451AbhJOXL7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Oct 2021 19:11:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="208803399"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="208803399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="492745586"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2021 16:09:39 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 16:09:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 16:09:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 16:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ecf+CxYVNtL6qgEDU4clvSNIZ9TWmnlrLXDldDndDM21DADwdN/4qxl77qP2gS4jiU91kf2FbKoLHdQ+gJ2xnBVZtgcAc1lN82P1o+bhngLXDOr6bh5uAj9HtcKk+MQ8GxsPPl6IZe3Md+OoD2ROHUHkhF+oLZjfgZVCN5IXYkkpFKv8/Hudf3zg3YgxxegEVUkLA1yel9eKZLms3nblRC7CqSQLaSkE07cR1rksoi5EF5cjRfuH3dxk1sR8lzZvueHTa61pMhMvv/sJNjgSteP/uGh9hghwIsHJw9yw0MX7HjLgRqujnzXMB3hpxxCNBigaA10/2hR3DUJgrXTBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WkkYqSiMMMIIa0uWijZd9+hweUrS2aDtulcd4Zd7ig=;
 b=VEL8YbzJgc8UW2R7kQFlu3/uyk0wExFNQvZuOlmpVgXJj3S3J/DFBKrdWNDpqSprz5hDff5w9154hI5kpiat641t0UOQmrg2cxWYtzakelngevU9rVPIcIX6ycSu30kBofOOPymEbJHRQ+LWT3sPFoJu6yfjzo5Ot7f+a7k9Nubah1lBl4L/LeAE0d/TGausAh1g1vYGSABS4bkx+Dc6Y+8Hj9qNEyl5xMentHlgWL3hJSbwSWfN2IlWhjANe2OUSgNohPPzN0WKacoR8ylHMMrRM9raNAMcO5yBeFjl2/26gIykuBHyLqUA3mfpBVYW3nnqsRVOGbpl/DB8qLx2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WkkYqSiMMMIIa0uWijZd9+hweUrS2aDtulcd4Zd7ig=;
 b=lZIzL2yN+GmRA4uMiboWvsTEnUrqRqsIX8weS7JaG0kszh4QEkMLdqt4SyBLXhd2ijiKMIDT+mz4OaYWeifWK7DfryHADuw6EvAItojqmXrixYgB5C0tI3/uYiK9FHYEqtBG+zTClSsjUbEUdVb5nPR/m3w7KCdL+rXHWsNN+gY=
Received: from SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15)
 by SN6PR11MB2960.namprd11.prod.outlook.com (2603:10b6:805:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 15 Oct
 2021 23:09:37 +0000
Received: from SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::4c59:5b71:1565:c713]) by SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::4c59:5b71:1565:c713%9]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 23:09:37 +0000
From:   "Devale, Sindhu" <sindhu.devale@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: RE: Question on PD validation
Thread-Topic: Question on PD validation
Thread-Index: Ade+81LejqFTfzQERh6UiH7MG/FbmgAkEkqAAKVxekA=
Date:   Fri, 15 Oct 2021 23:09:37 +0000
Message-ID: <SA2PR11MB4953C4290A30F50305F7077EF3B99@SA2PR11MB4953.namprd11.prod.outlook.com>
References: <SA2PR11MB495343C46850C730BA4203C1F3B59@SA2PR11MB4953.namprd11.prod.outlook.com>
 <20211012161001.GK2688930@ziepe.ca>
In-Reply-To: <20211012161001.GK2688930@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a84323e3-2399-4340-c76b-08d99030dc36
x-ms-traffictypediagnostic: SN6PR11MB2960:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2960EBE69F7805D266885CE9F3B99@SN6PR11MB2960.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xMLapjwAVHgL+k6qQEu/F+yh5Nl/tX+wmcMbVWN89RGzLb2dfdkYr5QEasEJILJLeC3CdrSEMtx5pEgUbVaTl5JMsII2PQ7BJDgEouku2a4TqB/JRcvsGJlBRx3u69bzsRUdJUNjguNwxt9X1NV9y4JuCrQTUxigiw9DlKvYVGYrmyXHQR5NAORqLW9rQyJRvqjPZjQfAHG/3IVKpVZCcJVdNFxh/MLRBAiNvMRoUshZHO0iHKHdwFhibAfSOsmmRkPiGVdYTwAtCT+76R4ft09UhmAVPcr5701+N53N5qVMvq+Uh6ewuqFARPwOddB2BZDACUh0uYRsqB79j+fQiuf8Yig34T6hmoinP3Hxr3VTuqb3q7Jrhm7gfGzCI5/RpoVW3DZgArZb36M0AmnmQk0yaHozwZtAxT7QcuyblVowxZSrIyBz9SpHqHz85Qd+pEmp6m92xjiqNkHK1Sb6eK3CrU0elzig/IrGxZDzCVW3Z/dXL7I0ihVFz9BgJzgaoGW2//jwRxRzKnrWrGGQG43tAoJjCCWiThtVsuJIx8UrPvVde7t8HqlkMGfRGwuse+sxvhYYug1r9UNynUZN+UOlc/k+eyLaSj5+sXGzXlq5R853yvqhnNnTlXB0tF0/Y1Vy9dsPN0V2yODXpDAv7kiJtjgo9I9w2Ipw/lpId/Z8cnsPF8n6TlDnyR3VIVstcviZBJh0H28+e/+zQ5vx+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(54906003)(6916009)(66946007)(83380400001)(508600001)(2906002)(33656002)(7696005)(66476007)(66446008)(71200400001)(316002)(66556008)(64756008)(107886003)(86362001)(53546011)(6506007)(8936002)(122000001)(26005)(9686003)(82960400001)(5660300002)(55016002)(38070700005)(4326008)(52536014)(186003)(8676002)(38100700002)(3480700007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TCOH2ojHpOzWMozbj5xEiHsBf03zCrOWA2YCt4GrAucs+m1H6NwbGLrEV0JZ?=
 =?us-ascii?Q?ZTU4b4CR0Ia3WIOfHwesKzHIUm4rJgM7hfOntZaBrKS59uZIN+xRU88pMR2u?=
 =?us-ascii?Q?/gF+IiBE3cB0WK/xSxi3HzEsHrKQf65bUmHW3W4vrxIxnRdaIwrO1hU4qQVk?=
 =?us-ascii?Q?WvwDNaJIjfuTUrbnPuij3ovMbZdTDQFK5hHrTPJEJNFOx2V2Dr27JTspFUaz?=
 =?us-ascii?Q?Bep22tpegZoN7VQrTh+IXEZb0fSCQfOqm2LwGy9rRSV+4KsfskLdNJKMN8jW?=
 =?us-ascii?Q?/qsCZxi7vEvekG4dZ77rh3M5sGXT6WELmHhZO01JXdgehElsi6R1niUE9ijx?=
 =?us-ascii?Q?gk+xk1nEzTMdvCRslu47VGnZWJ1RzrizgNJm3B8PGA6knYll0c+fwLPS3Pea?=
 =?us-ascii?Q?hEfXWQCcZdxHuqwB6Y6F43MugeObMTqADaD8asXPDro9ptBumQuKPbiUPunO?=
 =?us-ascii?Q?F2ggJHf6YCiSXKLqekV/0qyP3xOFNLIFv0UFrPxtQohhnUnuADiilCbHQ4NG?=
 =?us-ascii?Q?fOCHO84UgHA8EsIQQhl/6kK68TuPHBhWNvXjLS3srTkqHVtYV1Njw5VY0/dA?=
 =?us-ascii?Q?Ul4moH7W0bMOVED/y3gAr9DrcL1AJk0L/iUFCQxvOao/gFusJbLTwCjB5G4O?=
 =?us-ascii?Q?EUFZfSfswh/rkoOw9gan/Sb5L8EyP3yMB8JBmdryZ66TzlJn+Z8oUkEpagZK?=
 =?us-ascii?Q?VWFgHvWhJygcvBPcJ1uA3QhvjsvwbuHoYMDFLRDoIAuyI62SRVteqKXWfc/W?=
 =?us-ascii?Q?8b0MGxDqgky+78RCSLAB25f6F8PW8g27L5QwOtYK24sC1oXCMOzvzIx2afbw?=
 =?us-ascii?Q?2UhgNpUkg4Cdpdn8icSirG0vyZJHgvzmETeUGPo+LEO6a33tapgx9veYedps?=
 =?us-ascii?Q?jT4pf8Nvd3Y+12IxnNTgCBniBMGPj4jkF2/5FQnAtibSVJWk+XZIORg0BYL+?=
 =?us-ascii?Q?OSVlL4J+KXLw+dEPtY1m1nhCMcwaFSZMQ3zamor1Xyde+pg3iI03oXWtqaF0?=
 =?us-ascii?Q?YDK3+rq1Cw5Z4b4QSacNOql/YJU4y0T8lUaOOa6NWOLDtAPUorw4OaDfx7BF?=
 =?us-ascii?Q?t4V76qdIRjZ6Hui3nfoRoLYlzHkqbmNoYPRTNTuZ2ArySgDxBNqfWx5SSRR7?=
 =?us-ascii?Q?gJUrxqALbR3ckxYbm6mEz+l5FrrP6qhEgImwI55px0EEqVfD4F4h1tkAMC7b?=
 =?us-ascii?Q?JNxlrqnTawZWQab3RWEH/MtiMFlb3BzqvF677T+uf5PjdfKq3sRexqr8KcLE?=
 =?us-ascii?Q?oTbCqih+5c75mbNhNsQuitWBTut34zwrr4zt3nQdehx/Kb5DhNVOggbezpyT?=
 =?us-ascii?Q?edg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84323e3-2399-4340-c76b-08d99030dc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 23:09:37.6077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpFdjxc/O65P3covnwgApfqrEJMwpssUlab7z0INXZQlQrrrJTSQB3D1WFqxUIZmmqXno2QhzucfQaDZmYFdGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2960
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 12, 2021 11:10 AM
> To: Devale, Sindhu <sindhu.devale@intel.com>
> Cc: linux-rdma@vger.kernel.org; Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: Re: Question on PD validation
>=20
> On Mon, Oct 11, 2021 at 11:05:02PM +0000, Devale, Sindhu wrote:
> > Hi all,
> >
> > Currently, when an application creates a PD, the ib uverbs creates a PD
> uobj resource and tracks it through the xarray which is looked up using a=
n
> uobj id/pd_handle.
> >
> > If a user application were to create a verb resource, example QP, with
> some random ibv_pd object  [i.e. one not allocated by user process], whos=
e
> pd_handle happens to match the id of created PDs, the QP creation would
> succeed though one would expect it to fail For example:
> > During an alloc PD:
> > irdma_ualloc_pd, 122], pd_id: 44, ibv_pd: 0x8887c0, pd_handle: 0
> >
> > During create QP:
> > [irdma_ucreate_qp, 1480], ibv_pd: 0x8889f0, pd_handle: 0
> >
> >
> > Clearly, the ibv_pd that the application wants the QP to be associated
> > with is not the same as the ibv_pd created during the allocation of
> > PD. Yet, the creation of the QP is successful as the pd handle of 0
> > matches.
>=20
> Most likely handle 0 is a PD, generally all uobj's require a PD to be cre=
ated so
> PD is usually the thing in slot 0.
>=20
> The validation that the index type matches is done here:
>=20
> 	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_PD_HANDLE,
> 			UVERBS_OBJECT_PD,
> 			UVERBS_ACCESS_READ,
> 			UA_OPTIONAL),
> Which is passed into this:
>=20
> static int uverbs_process_attr(struct bundle_priv *pbundle,
> 			       const struct uverbs_api_attr *attr_uapi,
> 			       struct ib_uverbs_attr *uattr, u32 attr_bkey) {
> 	case UVERBS_ATTR_TYPE_IDR:
> 		o_attr->uobject =3D uverbs_get_uobject_from_file(
> 			spec->u.obj.obj_type, spec->u.obj.access,
> 			uattr->data_s64, &pbundle->bundle);
>=20
> Which eventually goes down into this check:
>=20
>=20
> struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object
> *obj,
> 					   struct ib_uverbs_file *ufile, s64 id,
> 					   enum rdma_lookup_mode mode,
> 					   struct uverbs_attr_bundle *attrs) {
>=20
> 		if (uobj->uapi_object !=3D obj) {
> 			ret =3D -EINVAL;
> 			goto free;
> 		}
>=20
> Which check the uobj the user provided is the same type as the schema
> requires.
>=20
> The legacy path is similar, we start here:
>=20
> 		pd =3D uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd-
> >pd_handle,
> 				       attrs);
>=20
> Which also calls rdma_lookup_get_uobject() and does the same check.
>=20
> Jason

Hi Jason,

Thank you for responding.=20

>struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object =
*obj,
					   struct ib_uverbs_file *ufile, s64 id,
					   enum rdma_lookup_mode mode,
					   struct uverbs_attr_bundle *attrs) {
				=09
The lookup for a uobj in the above function happens based on the uobj id.

When an application creates a PD, ib_uverbs_alloc_pd() creates a uobj for t=
he corresponding and assigns id of the uobj to the response pd_handle:

resp.pd_handle =3D uobj->id;

For example, I am creating two PDs:

ibv_pd: 0x21a4d00, pd_handle: 0
[ib_uverbs_alloc_pd, 458], allocated: 00000000d8facf77, uobject: 0000000015=
84c2c2, pd_handle: 0

ibv_pd: 0x21b7a70, pd_handle: 1
[ib_uverbs_alloc_pd, 458], allocated: 0000000048001c84, uobject: 00000000a9=
cacf67, pd_handle: 1


Now, if a rogue application tries to create a QP using a different PD other=
 than the above two but it's pd_handle "HAPPENS" to match one of the above:

What's going into create_qp:

ibv_pd: 0x21b3c90, pd_handle: 0
[create_qp, 1392], cmd->pd_handle: 0
[rdma_lookup_get_uobject, 381], id to lookup: 0
[rdma_lookup_get_uobject, 396], uobj retrieved: 000000001584c2c2
[create_qp, 1399], pd: 00000000d8facf77

It creates the QP with this invalid PD as the core retrieves the PD uobj ba=
sed on pd_handle 0.=20

Is this the correct behavior?=20

Can we do the lookup of uobj based on the object itself instead of the uobj=
 id?

Thank you,
Sindhu   =20

