Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215CD3F22A1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 00:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhHSWCa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 18:02:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:48545 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhHSWC3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 18:02:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203856566"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="203856566"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 15:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="506245931"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2021 15:01:52 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 19 Aug 2021 15:01:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 19 Aug 2021 15:01:51 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 19 Aug 2021 15:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmhid3WrEVxnxjW6WbTOLhPhX0KX+DsbnOLJq6hf9JF0cvxnO5piQkn6QslzHAW/T278q7NdD94CO7xTGTkBVucVLf7nVxV2rqlDvYTPku2m+XrURAww1N2IE2szMJgJ+/gCIARaxODn3+LmOMpqpRJy0i5UW9nrecUx/r1ophIxNTgLxp9yPX6AnkK2GINPHyRqDxNQeDLQxSR/WOS5w7Bdrn150l05ITTYJfGRq+z/srkpjR4LU9IWd9K4U/dm4PDrFDCOmRh3ZKG8vtBBDaXF475BCBTJtt9YxCjvJ/hSOu3cpJ6mvBN/f2kYy+WbK+yMvvOE+z3zt9fjeYQnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRIvmeIIpxPu7YyDWXnA80hkT0m15H2rBC5pIIu8Si0=;
 b=PcVEMrCr+jeSY2XjZjgo5REO7Z3N10Cy366E017ABwdIMkW+l48SfJW9dGVOSj/J0ZZBtzDowmfh9DgA2LMonOiZkESfnmkTtgg2EqrHAwm2gid9Pjq5JaeP8u9KJ4sXigJz57h52MC1Y4yOFjcJwgAFmLP8CB0m/IuWH3bTPhehnqTcd8tvu+e6VoD6r4xJOUSi9AZormV5lfnpWG8NraX1VW3RZVixTuoW/ZHBxI/9JzL6uD42xrxlXM4PFgdCpb7dRW4hybIvvJRakFcEyyaaZx8lFPSO+h/IhzbcZg3t4FOWJ4sTMePJBl/xN7il/4NHlQby2fWk3Jz6C7qZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRIvmeIIpxPu7YyDWXnA80hkT0m15H2rBC5pIIu8Si0=;
 b=etScXn+QPQQg9SeHYJejMxQRrU7Dp6+DHIngK3ZsBk+5N7Y3FyQl6Mf8s/s7u+/b+xgtlNgQ1gE5pj7taPHohHiJskw1nfwWuti03ikur63zfeclrLmyxwRampki2Xu5b89qInxnSLlyc4oymDPL3DpFt8RwyIBNJDtXRXaqS/A=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM5PR11MB1932.namprd11.prod.outlook.com (2603:10b6:3:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 22:01:50 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::a136:f190:7e89:d7c%3]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 22:01:50 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-core] irdma: Restore full memory barrier for doorbell
 optimization
Thread-Topic: [PATCH rdma-core] irdma: Restore full memory barrier for
 doorbell optimization
Thread-Index: AQHXihS+EJKXfIrCVkG1+TWSsRynBqtlsKuAgAXsBECAAQ2EgIAFZfmAgAd9soCAAeKYkA==
Date:   Thu, 19 Aug 2021 22:01:50 +0000
Message-ID: <DM6PR11MB4692DCA80480234AAD298313CBC09@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210810115933.GB5158@nvidia.com>
 <20210813222549.739-1-tatyana.e.nikolova@intel.com>
 <20210818164931.GC5673@nvidia.com>
In-Reply-To: <20210818164931.GC5673@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8327719-1e32-4184-9ee5-08d9635cf23d
x-ms-traffictypediagnostic: DM5PR11MB1932:
x-microsoft-antispam-prvs: <DM5PR11MB1932BA55E5E959FF8CD90B51CBC09@DM5PR11MB1932.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFnLt2u6ExeUhNOKj5VZa3gQqoHIE/ZckX8bXs1siinNB2MLzbHqnGMejiFZcbWzRuKF+8VpyKiaZfunySAL1LUNANE/PIZVtghcCjXmNZav6jvCjFDbylz8vxdInx+cdb++8kPugQZNcUCSv5Od7IfrrRGA3hJrUn3AnBsNuVxxvmRl82AZlh6KAiZUN4BBESS0uJzHERGbQKfGRCnNlaCuqtNvMgA+UeGi0pyy7rhuPCK4Cp1mGgjPNqC7RgjKkjnZatuLQRrtQlGPT/KmmIpsZGYkMGVxcM4FzqrL+CnOVn6qK7aqE2RkuRf5IpSWADpWkhjCcicKv1aInGxPe2j82xj8TlHNdmf+2Z+a0UghRwY4NJbRuca46QZnYc/rtQeahJLA+Pz9L0hp0Ovr3DKvFlUwoeJGyv7w57yCqfKwOuP3bAQhXA4lXTlH4odMR50erjvMl+FunI5P0ZfhxVt+HtZczcLzDN1S1TRkFiSAFz4Y7wF6GLMCGVX6PhOMOczLhvyXJmHAF0YJ9BlkD46Iz5Dlk8vCvDiAHCYp2CZ44Ss/t6fRkTx54Kwh7NDLEegMeie9rl7roLnjeCM4aSfZmG1SPki/r9dxFykgKp+QjhFeZYXVyeRi6CpMSbbdCYV+K9x3gM03Mt7tPfZJp9IK52/Us7faoQDiMZui3JWanUsqCRdYYMsSaSNVKNt7JwDWYevBzE6DD3TxIGlzng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(8936002)(76116006)(66946007)(71200400001)(52536014)(64756008)(66446008)(38070700005)(53546011)(66556008)(66476007)(7696005)(6506007)(186003)(316002)(5660300002)(54906003)(6916009)(26005)(86362001)(122000001)(4326008)(38100700002)(9686003)(55016002)(83380400001)(8676002)(2906002)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5HEYwGblNPEd4ejKhX5Dh+hcxs8rnr+JUmPTfG/lgmOtH1Tq1+vu1J3wrkm6?=
 =?us-ascii?Q?KOhh1usE67VJxusoNJdT6wYSoBu6IaYlYLV/X16NNAR3Y2ogHzJEDuOGWoP9?=
 =?us-ascii?Q?zhTEFqeqfah4grzwR1oGLBi9mzqDRLzg9r7Te5QSNmbZ4OrnEviJMHh6zJdT?=
 =?us-ascii?Q?qrUQ2xtlIwGqHJPjhbHLejtqkQD7M9vGQUcde86RpdOURFZxjAcUWneFCiXq?=
 =?us-ascii?Q?cEmYyX4til5Ww3DNQLfDputqlWffpUOXlmypDnUAc88wNCwxbwoPPYMeGIQB?=
 =?us-ascii?Q?QG3MhsDdzRd8VgdpCmzPKYfuZlI704K2l6hkJq3cQ5X5/gHs3XMmFc2OAA6K?=
 =?us-ascii?Q?Uwbo3y1QZde8GTFkJJIt345dMwhwio3Iynfu8GGs0ur5J+/1W+XJaNvbsZ+9?=
 =?us-ascii?Q?fPaX3wBwsrzwiM6kIFxLCh4srkjuTBNMLHaltGbM3bIu4/3qoUcZRfRISiet?=
 =?us-ascii?Q?AeTmcVYcsbSubG99/3tW+XXuxOWj/wxyqr6wYBbUxboGGEmYKsgrG+arWQY6?=
 =?us-ascii?Q?AbKZhTGmX6ytWK7KwVKOooiwIbkLtFqUuIr0Xt9LKyZGGC1684RP/UqCoRMQ?=
 =?us-ascii?Q?G/iX23bkjO8fLTg8Nf+zMY7k9i4o/sdFQhxtoGNzr2fsB383Q+tEqckECyP3?=
 =?us-ascii?Q?7BXWEkYALbK/D8rxEy/Cb+26kH+C8POr+qFNf8ZtYwhvlTxygBUvAigpD0ks?=
 =?us-ascii?Q?14q16NYn8nTTKUbzCSGQ3sVRBAVHw1awkaDQD7XHFssaqhN0HFClOqIxjNj2?=
 =?us-ascii?Q?NEk2leuD/njjV+Zz4rZdCBW6xvzHs22ltWLxJGMfOkVv2YF63gdRrP3xOW9P?=
 =?us-ascii?Q?zpYXmzLUBeJzHaSkwBrqIiFmvyeb1ra8FLtWBRhdepgeie3CnoHewWSMztaf?=
 =?us-ascii?Q?OmxT67A5V2BmR0DCSFpryt2xL7828jSmYy8nz333v/88/nAwd89dGY2Mm9ts?=
 =?us-ascii?Q?nAAhynL10QtWcM+/5bfsbk6T1HgzcnnUbFn0fThq19cCd8OXstA3CIiPGdlP?=
 =?us-ascii?Q?0thrzeuLQcpvKbzvenzvOIVOgFni1MabfX9lvCaEA9rENO64B/INSH5yiE6j?=
 =?us-ascii?Q?zC3Jj7Q5Q6L1iPfYH/4o/iwCRF2JND24djiMKHP5JDl9YMzoRHUMnCgCu2n+?=
 =?us-ascii?Q?uCrHBcRqSbGiPwMr28HJOrcWEdiBXuRy6P3m+uGEWOwVWLzegWBE2cx/Eyy8?=
 =?us-ascii?Q?cCkdLf2ouQEbPSVvudWbJaJTDgz7ye7a2cJhggvO2vwvl33sQ+duYXCNJCbf?=
 =?us-ascii?Q?x6vo0pnBrFdmM3/s/g817ddLFlnwpcx1S1lQT00F18zimKg36JOuQmaXwQvh?=
 =?us-ascii?Q?rn4Fz4MjydtV3fwNeJ6zDrIu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8327719-1e32-4184-9ee5-08d9635cf23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 22:01:50.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iA57VIWIcetlRa6t7zEO74kiKm1USL0cowstwPJyR/kXta2fJzr3tCdma/h3P9lZrhJ0ALJj/GW6JTysKSQmDrTBvITTUHOANW2UM6xkG7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1932
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, August 18, 2021 11:50 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> Subject: Re: [PATCH rdma-core] irdma: Restore full memory barrier for
> doorbell optimization
>=20
> On Fri, Aug 13, 2021 at 05:25:49PM -0500, Tatyana Nikolova wrote:
> > >> 1.	Software writing the valid bit in the WQE.
> > >> 2.	Software reading shadow memory (hw_tail) value.
> >
> > > You are missing an ordered atomic on this read it looks like
> >
> > Hi Jason,
> >
> > Why do you think we need atomic ops in this case? We aren't trying to
> > protect from multiple threads but CPU re-ordering of a write and a
> > read.
>=20
> Which is what the atomics will do.
>=20
> Barriers are only appropriate when you can't add atomic markers to the
> actual data that needs ordering.

Hi Jason,

We aren't sure what you mean by atomic markers. We ran a few experiments wi=
th atomics, but none of the barriers we tried smp_mb__{before,after}_atomic=
(), smp_load_acquire() and smp_store_release() translates to a full memory =
barrier on X86.=20

Could you give us an example?

Thank you,
Tatyana
