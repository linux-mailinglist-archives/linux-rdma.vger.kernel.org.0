Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9325C532D9D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiEXPfS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 11:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiEXPfR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 11:35:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6D59339;
        Tue, 24 May 2022 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653406516; x=1684942516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8VujblFPVmaXw1LpkTcagzjGXR41QzUhrNaZ2V7YSHI=;
  b=n9GGpb5C1BQEhyPI9KPElcW9j03LlZRhcpE8w6yl462QZ66kxCh+RmvF
   b6/l9EavykXdExQgzwQWlf0JJVmQ5++ihGccvFZprd48T5rZhMdBWx3+s
   gRr3/jBbE3tRrcyq1GXGDm74Zt2z/3/GunyjXzkSHJQ2y3tDOf2qTBlDH
   0jBPmJrbMsFjAYbH5RPbMDLpdHtQJCfLTWOgdF1HKNBMF3J84M7HLJiwd
   qvQs/hL3o0UpMNJDJ2DRQP7TUy6zSjllav/lSEOVT4w91+Q7CrsLROaJG
   9DznTELdjx2s9h+jA1t/Sh3C3SJQc4gI2GuHK/X2lt0zm9p09er9jyEqb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261172430"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="261172430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 08:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="526451435"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2022 08:35:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 08:35:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 08:35:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 08:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjw/VokSotGuqIaiC23Qq+ghvRH/oCTL4MASO6NRRMXhOd9tezLxlG4s/db5K19kyMjBeZwx8mHjOohbBV3zd9ZqQhURENC11Jk0FOs6bYlrCpmd55HI9KG5nhikHLVYkHd1taTD8w4/28oou25ESW8T+4dBiAzJQ3r2Pxnka9Aem5R4OQu6UtVAshu54Q+6BR2/0wPh8YX9vcfhQQJs3RNonuLQ9nDyxbMAdHduSqqFzzfW9UxpcTcf46sqCOau9kuKpESCac3uoHPaW7lBcLtotyfIyb/wUvDbzafFcQpEO1amp/ZtaNqVYv+oD1mBRxTMy3PO5bEyBppqlAsvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTJ+jqO2HC7c4vZPqCPMLTGW9MVWYlkVSYU1AnkEThY=;
 b=QGL7oeeYi9XSyISoCgp/25455PQt9Rnx7KC1mV8jlYRZuqKn3tW/RheRVGw22/71ohIDJfr5Nvztnl+PlARJvMUz+NXWcg1dtyvfAcuaM+SbNYIgL+w/c2ah0VusQkzdfjPVF9FvUaDy5aCYmUglIK2R0Q6jT2jygPOtee+/TMCVF82hkEUaUFQ/xlLLUgcK1uPXaurH8V/DU5nEBPw+1AwtZf6xo1QC0EL2jOofHzDKU78bL70p+vbBb/rCp25CyJBzjGrTXewRmlV60b5I1+Dbx+EWSPXtR3RuixOK1QMHjjc57IzYnIz5J/3aSM9baotoSoy0Bq/caEimkA2e3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 15:35:13 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::4c1c:f0a6:2e85:4df2]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::4c1c:f0a6:2e85:4df2%7]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:35:13 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Initialize struct members in
 irdma_reg_user_mr()
Thread-Topic: [PATCH] RDMA/irdma: Initialize struct members in
 irdma_reg_user_mr()
Thread-Index: AQHYb4Jn++uEhOvAVkqr/YS58HKDLK0uJw+Q
Date:   Tue, 24 May 2022 15:35:13 +0000
Message-ID: <MWHPR11MB002957BA07AE65E7AD732AE2E9D79@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <Yoz4iXtRJ8jw6IeD@kili>
In-Reply-To: <Yoz4iXtRJ8jw6IeD@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3eca7a3-a77e-483f-335a-08da3d9afede
x-ms-traffictypediagnostic: SJ0PR11MB5677:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5677C9B6012BC735BE29E9F8E9D79@SJ0PR11MB5677.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMTlI99QvXV3lG94S90u7wfUDtdUdnzr+GscL+urB+gbj5dF9Za0RG3lzdwjm9RZSNxGD90TJXKQ5M8cpZS1aXEPM5ch1w43hFnXJFZKkHsNN//4y3bLN3sYB5lPlEOPLsnvUEU75d0ssG3sp6OkrzO/WV3RQUaqNbgnn6VEt9+0lgPbEGLQDf+sAghrt2zFTCqtyQvMxeUAKqQiAC89Necp79X4qD5TGFJDHYjvRLkDC88NC7fP8zxYPccwjuhqFKC6VG+krMvmAjSxOT3kX8EcwdsJLm98lXGh3cZWq1DGiqKF4TzUkW65uDfnD10ZDP5Xwge3cYIOmM5/F/qQMytA9II6Kges/pWQIbtpwKGGvyEIUWx5va1gS/1CYMmiwf+nU9u/33dPz7D3bniUJ/nnVk0ArfS73QN3QCfLrKQVdCOPVFoxYSNA7UbG71kSR9Wn5e+hk+WBJRgBV9PqWLejtE1Al4PgfOsDKIaZ4u3sEtp+imMVjZUkosHQarA2/2P2RlkR13biZsUOGVZjKyENc8Aa6Kp4qsYLTijo9khHrZV1Uml/0lt4cDaeeLLZGfelQQlcgoZ+XrYPPO7ZCiJS4UH1aZ+1I2HK6nMBG39rrsJMhOrywvWk46SHL1/6kbvrVSKYvxCAOz9noUccrslHu4F1jpbEJ0MSvSz2hdrXEJztYUkqmNdRPtiBzxDzwRe9Fvofb9IJgV/RxKDckw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66446008)(55016003)(86362001)(4744005)(8676002)(66556008)(38100700002)(122000001)(64756008)(6506007)(66476007)(82960400001)(76116006)(26005)(9686003)(38070700005)(186003)(71200400001)(52536014)(8936002)(5660300002)(2906002)(7696005)(110136005)(316002)(54906003)(6636002)(33656002)(508600001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5hey4vaQj/BaHleqkDwLU923x2w2GyKtNtallqX4O+7DiEk7Op9UzBVFUY7m?=
 =?us-ascii?Q?xSP80136OrnKP6DdCS7Fy3lRUvtDZ4JlxgKOrf6++s+brXvg27WL1UnpG1Hi?=
 =?us-ascii?Q?YpQCp4tBU5G/a+4WpxZ5hUifW7dqaHLSLKMFpLq+yeKdZ8VTSr1ZDVcg6efA?=
 =?us-ascii?Q?Ks8WAfEuNGHFzmYZL5iEQ3bQkQh6clf6JpdvmiVIxpjgo1Vr21E0ubRHZrB/?=
 =?us-ascii?Q?f3xJmEa+5jnX0amDK3gWe5E37yf+0DLhgdolFmYN6z3my7rFAmVYAc+/ZsVY?=
 =?us-ascii?Q?NzL+5RScUc3TmDosU8XOT7pwsEgFG7w26Mlo9emRq4QApa5QSe0rnr/bvZui?=
 =?us-ascii?Q?FqFAMoC7E50WzxQxgXbDoAoaZeZ1o+iisurbuHK8z5G11aV0e7auYQNGJV3U?=
 =?us-ascii?Q?yXBx0lgPN9hWGsstdpv5u8NvQHX8asATdJJKmKrXedGUHqEpXQhcsM5dwXJp?=
 =?us-ascii?Q?6NmFkP8v4iCmcIiAQnup49W14YXegHaFu50kfZ1mcRGzVYNxKvOE+igohbOr?=
 =?us-ascii?Q?1eQQHyLa8G4RE2WUpO9QdVPxHL+hHcP2zpkBGGVcnBed0kt2tsN9yWo1R8s1?=
 =?us-ascii?Q?bHZ6htdGF5Jr0PaIKky3BLcBr0mGbPNfOYQvNyHwFTmTWG/bmVelGgvFJqAB?=
 =?us-ascii?Q?4rJeWCIm2hGazszK+oqx4t/Yo9tH9K0+Vah9z9b0qJUvvjYXQi7K7FKSGLTV?=
 =?us-ascii?Q?by7OVM623j5bz1muC21a/TLpNSHOLvgGPV7Yz65SMrylGORUcJY88m5Y4Kxt?=
 =?us-ascii?Q?f46+hKYYDlZFdPMIQhMybRNEEmejHJYlCaXrfL9TgDqS6pzsOrTUbA5esrKH?=
 =?us-ascii?Q?7Nnep/CspWlCAGg/DhegUdBpt9tWNE/im1owbfsHp1b2Vu3rtYOHlYYWzeYa?=
 =?us-ascii?Q?rZQeicrsF0VhOZ3bQTBRvggWvDzTuS1U/FdrOQK71/JicP7I0GBwZ1SylO29?=
 =?us-ascii?Q?dMdLmhbLsW32oG31t/gmKT0RHVA2NSCtAWdpFn0S89bF1SgDU78iD22F6jVB?=
 =?us-ascii?Q?6RihA99sSyEK26mtU8IqD3r6L+qa8vzNVn6a9hbLEvc3v+ifIbkpwFqmNBdS?=
 =?us-ascii?Q?TtzNW2Yt0LlP2ziKG+BBoFq/2+LwTdN0wXoLSS652l880c8YErT9wWTP3aCz?=
 =?us-ascii?Q?jseziJs7yLO8VhALoeoJG/bWUIuIqpVMJwv0KVufqfR9jFLeHTuuc8cyjSuu?=
 =?us-ascii?Q?iuBLdQev5Rfaw10k9WEqoPimjjJvIRmtKjeo5IfAJM40ZGUMgx/jnU3aGOtx?=
 =?us-ascii?Q?XqDmeLC91fpLyNsLagqKFwaHZsEVMVAMOl4qcXjDnIOwizbVWGRSCYpq3pzj?=
 =?us-ascii?Q?M9jOcL/2HDzy13jVQf7k0vLznOTQsW0OOqBXV4WBJYsF0GEQ+hkksbhDxvjY?=
 =?us-ascii?Q?A1vpo7Lheud0E1jrzywcxVM4Dkg7ly7Z7r3Ux7m0puXx5sSQsUL2sZPXJSLh?=
 =?us-ascii?Q?fypiNIFJoI2BN1xPz7ofcNRI7mlFYlaisKKGS3tBlqpPcqIWINJwOJoEJXWe?=
 =?us-ascii?Q?c9Cfu21FG3bdBtKYdC/uF4TOCTSpDFIxF/3c6RHm5yPYJ57nyrL9vEdjpopo?=
 =?us-ascii?Q?0lblfJUx8r62wg9SNSgpS6B0p/YfOQSyJs691EsDyRX+og1Xsi7QaUe2AM/r?=
 =?us-ascii?Q?u0WPdtxte9vR6bY9s5kKahk87iG6tsbaAVTztJvW9ir9TegmZsvbQsX3ZHgm?=
 =?us-ascii?Q?dlPJys//abhbQKYZG86WFhfNXjySH974b5+aq52zRU3JVb/rHykUxHpphYNd?=
 =?us-ascii?Q?C1+MLNeqNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3eca7a3-a77e-483f-335a-08da3d9afede
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 15:35:13.6266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c89Z4f3c+DDJkTG3985AVV1PaHlyA3MF4r6BuBUfhiUhZwJBzPWS+ep+ymPlkcbFUkB0AJ8DMzY90MnaFoiVEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/irdma: Initialize struct members in irdma_reg_user_=
mr()
>=20
> The ib_copy_from_udata() function does not always initialize the whole st=
ruct.  It
> depends on the value of udata->inlen.  So initialize it to zero at the st=
art.
>=20
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
