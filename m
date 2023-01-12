Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E17A667C2E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jan 2023 18:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjALRDG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 12:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbjALRCm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 12:02:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9DC718A7
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 08:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541842; x=1705077842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZJaOXltmEBNPw7Unr+hsvw/MA8gxeyNjN+7tqIwRUM=;
  b=ivoPBtIoxlD5pHddsCeBuBbXXCgp3fuVWwLb3QYU7zYlFR9YM4iTx0Yv
   oTLX0tZat0bMJiJqFiK2i0+JPdYna1viNCid1ZK5FBQm+BVaA6i/UjRBv
   UCUBaDHvo6ustOBJSGF9gjPg67mncI3/mXFxfT0PQedXSkAsHBngISCN0
   +cv2BJW74NnhWYvvyM7iuNOCJF5VAWbjfgbk5DPu4NLmjdppzIxAqdeXA
   jOn96FE5y3qLzKb+HWp4ZGnuj+R41Jdb+SzklbtFe5qeJ35dTZBcKfJ8i
   NlqV3nQJALhZK9ouEXgYyAQ6gZIGTlg9fEcSJe1fKRqxLd8sdsGNMu3i0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="386093295"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="386093295"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690193938"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="690193938"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 12 Jan 2023 08:42:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 08:42:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 08:42:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 08:42:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEd5XQYWIKBP54tFQH3JadfN/6bMHg7+wam5WmYqsz9jxZNAAdEhiPV/eF+xF5BczxkWgbZPEtqmSM8L2NtTtkVEe3ideiyE/jJYb7sE52TLde53nV5+YaW80DdQzUsXJRIQYnX1xHvinVzaQUDq8oyetOrBdZMKvfVRaiBFQ7Ck3nbLKwRSfAlFZzose8D7WXqmEYEZJhvZjpBBGsgPnO2nmWUSmYsGD1uQzH/jLndACORS6JLdmq9kBWqM8tMNzHjTGzxGnO2vbUzCJwZI0ZxHC2LDFQ0xcjRwpGDMj7Y951V9PoZwIGRZQzogZjsUvtIYQ8dJ9k4RSILLFYRedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40zJ8AdQMnuxemtn5B7oiyu1WkVz5gYYLVU3CjG3s+s=;
 b=PVOR7jaNqoChPzdG3gDJY7AoMWOsgNu9myiYbORQDUTU/3SDUYWuCzwlL8WUXGsQ/a8SFZXiAbfMfhEpIuBCuVpCyBx4pkt5hkexn1bKxuZMdf/mFVtVYSTeNHHoe4IjGHdxGyShg1UP0t19WwOoTwciNmvUSYyNjiivjZi68ULyYSe1VK3THPhZvUnaXcucfXSFBHfU31GuJL2bG3qx/nmzLRZ4EYSr1Gpd3oWP3W7M8xlov8xiJjTHBoTFIr4H+OA2oMMtEoJaWTPFxK3c8ngqiv28WMCumutENZCOiQKd42jV/P3a4NONvo6olqQQOiCmNghfu7a3QbOqNGuA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 16:42:20 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 16:42:20 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCHv2 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
 function
Thread-Topic: [PATCHv2 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
 function
Thread-Index: AQHZJY/bt1SHky1C8EC73g2PZhqZlK6a/lkg
Date:   Thu, 12 Jan 2023 16:42:20 +0000
Message-ID: <MWHPR11MB0029015EEF450E9C8D2E1EE5E9FD9@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230112000617.1659337-1-yanjun.zhu@intel.com>
In-Reply-To: <20230112000617.1659337-1-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|CH0PR11MB5297:EE_
x-ms-office365-filtering-correlation-id: ab8325e4-c207-4797-7474-08daf4bbf973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGrPxWWZYpPr03E/fHbL8ZFhAvQRE/zQ7gl8TGEDwKxrHesq4VUY3JB8ExCyteOUytwnAbEtD1o/rQWp9F1UQjujoDFrp1w3xzOA0RS0KW2Tnvd/Nf1gKqCXOo8pJaUWp0j72f2tY88/APueO2WgWgqVh+Q8x7+orfo9oBs5JoQ29P0y6d911m54yh7pDWdw8jfCkukNgDi9enqOfRuHGwI6hc9T7te9bfJmvZ6lptWPOrwY908/XAb3MeNcAtLL34s8fGnOzLusqxbeSL7PTdOEnvvRikSwvgh30aXi/S1Vj/rd7oZUI31XM1U+wHlnJuzHRxjKLs6tAJ5WRwIQkiNUOrfI++V7fezb2ojuTWd0BGa4Y8SuhzfqCmTBS9VHWLzJY8kCndmdyHo1sPOYW0Q9eipA6+rtHS4AED6Jkj8TmsUeX6rQvwCUT4JQ6z4OYjQ+o3u2tnyKBgzleP3zKvpBavRD4XrOSE/w3F4KAaMOAhAcA5FS4loTjIG5aifRgiZseZunkcGz54oiXoTAj/FlIIlFZG79eESQE7i4fXoVV9E6WzJlmKLRPJM7/gksAbxyuxc/jawNZozDxN5eExDtQpWY7wiPTq2DWaGZGrGvBqgg7KBjLGfKIViQucM/L6fcqe4XRPO1AjvEhFYGAba3UqtrxGVdopWCQJ2X0YIuIPMWImtE/xVUb6oqy4LXfGldnOw5qyxmn/T6I+SkWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(186003)(8676002)(26005)(5660300002)(71200400001)(9686003)(33656002)(316002)(7696005)(86362001)(478600001)(52536014)(41300700001)(66446008)(4326008)(76116006)(110136005)(66476007)(64756008)(66946007)(66556008)(83380400001)(8936002)(38070700005)(55016003)(6506007)(122000001)(82960400001)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e8ux06TC434ASAT83MVCxozmmn8za60Uhd/hC1LHDn0ggcDk1bq2N83l+iru?=
 =?us-ascii?Q?T4rYUG16Gt05V6Kt/l/hPrzIi+qPhnGbJMqRhtEeFYsu+u5atn1xOeVIsB0I?=
 =?us-ascii?Q?o1Duj2V9F986LU2nWojIILf+3GJLtQVOQn8aeBDz/aXVoMN2ts59XSVaWCpn?=
 =?us-ascii?Q?A/QFJM4YUJ3agvzFHwFhRnicn81DmVPauEL5/fIX90teVR2RAhTq2O2V0i2z?=
 =?us-ascii?Q?9heeAdA0W23/pciJbSEoCsjtYXNwkS+gWsnwsRxHmfftNRiKPmzAotTBOspF?=
 =?us-ascii?Q?tw8d0nv9ZxI9MWeLFvxPvWsAaXmrf+4oYUPPlT8x/i7y+Lgzn9FYof/FM578?=
 =?us-ascii?Q?7F6SJAl+lo5Sw3Iv/l8VgfXqLGzzpKVPRdhITlKKi+MzgW2OHMFQL5cbsMFz?=
 =?us-ascii?Q?6CTjv4TkfrCOpqLtd6BxRVC38AZs4Q+KhUtPObzQiZATJpeNI3SHMKx1O9PI?=
 =?us-ascii?Q?p01g5O2z1Sj8IUD+Ji5yt3x/IKUXXRCXvMehfPUEZOfoveuUsU/TXBS6Dkoj?=
 =?us-ascii?Q?E0/XL+dRQfxQhvWpz8PfaIdkqUaTzNoanr6lb9/Au6C2FVJnnMybzPFSEFpg?=
 =?us-ascii?Q?tEmuqNLNy7BB8X1odi5VIwvPeQzmZTHs3IA3BFlB+JhFeBDJbTcaXdAx3d6q?=
 =?us-ascii?Q?EFm47Xzwiy0ByAdHfvq7B+IEs0+r6PsmZmqZ9NprsLzlQp7d9l/6krthIu4K?=
 =?us-ascii?Q?24uTJrTf8vxWXkZuSDtEvyO0wEqMkVXMokJNy88ez/O+1Ep8e1HMHISdycaY?=
 =?us-ascii?Q?+teXoH0rwHeyD35eoCQ0jPd4JH+hzUIz3gEHN5Gk9N1iVOm8AwvZdoUbQGj2?=
 =?us-ascii?Q?NyyIYvLNOFjY2SoQ5zcSFvATg3eXtPTmzeLJ5bEqe+LeJlrAH/ehwswyj2Km?=
 =?us-ascii?Q?OcwyC5le3XiEBpL/P/jrl1XzGKg4MBDgPvHgb9UXrtuchfZWN+sfXTXfpPog?=
 =?us-ascii?Q?CeAlDjwUU50E/m8ETBoWaYhdryd3pHMjXP0M9yNNmudtORDHMiRx/nkW0SOa?=
 =?us-ascii?Q?N3amYuaAyuuSoV876gEBVK1RT07dDOFzEDu4kwV2QJPPM+CKz9bq3B69ulHf?=
 =?us-ascii?Q?QkkMxyZP/ni3Z8BfAjIfIV0htzn1lHaOEBKKtskbSqGERi7/XFgsQ0cy0kAh?=
 =?us-ascii?Q?PVcwZqMZlBWSjOYGN8xeJMa50sbeBt6V2u116grmdYL+ohCb2kVRSYgYIC/U?=
 =?us-ascii?Q?BKUBkQ4U3nkmT48X/MTZvTG+6GMcMAnOPFZ1Y6rTe5DAvjP+mFJSN2ezqyYb?=
 =?us-ascii?Q?IbR0IuacWcKaA3J0baPVTjDT3BRWt3OuZhCOtoDU2dos7ZGpGdrY1johJirn?=
 =?us-ascii?Q?HntdRR/zMjdO7uM6hmBKTsDi8GiYVAdvuM4zXTuMofBoCGnuYpVric2vdmEK?=
 =?us-ascii?Q?1jaRCdJrvAnfKd9g93etm/lZrse7n+Lwk/pZRCTlsfgYcGt9Y3/Sj/Z5hjwd?=
 =?us-ascii?Q?CzPFdeAWIHEos8tiiA9/VmzmYxBwR+08UHvZIARo2U4Yr+qwecJ9A4hd2sgA?=
 =?us-ascii?Q?2disAefu73IVLzwbmBHYrgctMsKbURGkTOHb+VocRUCHnC8HIOMlCDk6q5vD?=
 =?us-ascii?Q?TXet36zwmdwIMW39G/3VQU1JgSM79SlvKY6EHsHA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8325e4-c207-4797-7474-08daf4bbf973
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 16:42:20.7345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSN9o7JjsqF0L2NPEVLLRNxmd7kVmBs+aYbJY02ltA+2CV4hw0Tl2Dc67me+gLmDlebvS7WRtBwrmvLIRcCYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCHv2 for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
> function
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> V1->V2: Thanks Saleem, Shiraz.
>         1) Remove the unnecessary variable initializations;
>         2) Get iwdev by to_iwdev;
> 	3) Use the label free_pble to handle errors;
> 	4) Validate the page size before rdma_umem_for_each_dma_block
>=20
> Split the shared source codes into several new functions for future use.
> No bug fix and new feature in this commit series.
>=20
> The new functions are as below:
>=20
> irdma_reg_user_mr_type_mem
> irdma_alloc_iwmr
> irdma_free_iwmr
> irdma_reg_user_mr_type_qp
> irdma_reg_user_mr_type_cq
>=20
> These functions will be used in the dmabuf feature.
>=20
> Zhu Yanjun (4):
>   RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
>   RDMA/irdma: Split mr alloc and free into new functions
>   RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
>   RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
>=20
>  drivers/infiniband/hw/irdma/verbs.c | 264 +++++++++++++++++-----------
>  1 file changed, 165 insertions(+), 99 deletions(-)
>=20
> --

Thanks!

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
