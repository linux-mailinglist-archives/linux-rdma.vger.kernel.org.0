Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8F638255
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Nov 2022 03:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKYCWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 21:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKYCWg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 21:22:36 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7162DE6;
        Thu, 24 Nov 2022 18:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669342954; x=1700878954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MlMO49XFkH0qSEXaYMx0mlhoosTrNU431gMcLvlo2Rs=;
  b=Hvoq8OhHSpVdrTiPmPHyR+iEWGTRgckrzPZ+I6jAzZPZyGtJ7n3HEZXG
   SS1ifcspJCxbgIcpYn2+6kumjHTRNaL2UVCqvGnO4fDuPobapmFdh5RGo
   CJzN2V3pw0UPwJxxqjTi3TRIT3ldgAKSixftE1so+UFH+MeAyTm5URbzZ
   bTsSYFK+eRu0/8x6xwn7UN5zLqMKP9wgHs35YmME54KY/n+/CSOwcDxVO
   s6aMepsKehGCgjdxcCj2gjCKA3pMA/7gf3m+r//FXfR4Qd+2ZNQBEuVqU
   HGieOl1WrlbJTm8rwPmpK06jheHUKh1+DWa3tCBynpvABSdOxeZacZhqQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="71069375"
X-IronPort-AV: E=Sophos;i="5.96,192,1665414000"; 
   d="scan'208";a="71069375"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 11:22:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgdqBXRVjrC9CLZEgvN/BzeXGH3dSyhaDENeUTGuaz645ZeOWvImqdq4i3tNGCeJjZnIPJ+ZddQ+D/KrfDKjZQDwPZr+DKy7ZpxPcIqSL4w2kZNeI8GAZl9FyTB4a52jR/IjIRA9SfnlqYkXKHKHhDnJ8WbtYcBLFvLM3TAYJOhHAFsyNFn/kbGl4mtXwcxDKD5ER13vwh+TctMw4ertRqfEfL1dpW3bwIuoAvM/q3zXNsKcdTLd/KW2k2PT5pz+hxWC9UQkrjstFT+jBszwB2O+b4dv5I0kDdMjtSbsVwR0xBa62GeHzmPNdsXYQiJXwihl+MkxzWidftuxeSGVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlMO49XFkH0qSEXaYMx0mlhoosTrNU431gMcLvlo2Rs=;
 b=Tf1FRUHiZInY5xlBvVjjyBiIKUZuLrjfwzxMwkJkfJ/71Q3XP35RnpqAQUjypbBhxb6PtU2SpEMCBmuQUaMcXaEZaI03T4yYg0407Ene7WZNxB7gpMahQGEMeGAa2FsRhB7whdyvfZGj64zmzj6+PAsPfXf9vNQR4VMeqUI8uFqEUCAPJQ9oXP05VXKt/tnOon7vO1OVa/YjX9QwX9Mn9ZVP2SWzOM4qUCjzUQDGJpanlszVri/VfEAmIz+YKZDhq+8gH5P20W3QSk2GSxthefvEVir9vBTZHl+/5jP/J+2U3fu6R7uMmucu7hmIrU+W/LmlUkE5OxdZTE1I5Ve3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYWPR01MB9954.jpnprd01.prod.outlook.com
 (2603:1096:400:1e2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 02:22:24 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 02:22:24 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Thread-Topic: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Thread-Index: AQHY+ZRI1TH8j3pp4UKX3oA91Nseoa5LEO4AgAD/qYCAAlPMgIAAkfOA
Date:   Fri, 25 Nov 2022 02:22:24 +0000
Message-ID: <a3a10e6e-c75e-853b-06d3-ce2f67424afc@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com> <Y3ziLoRuXFIOpnnl@nvidia.com>
 <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
 <Y3+sb3RZkEO3ISpW@nvidia.com>
In-Reply-To: <Y3+sb3RZkEO3ISpW@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYWPR01MB9954:EE_
x-ms-office365-filtering-correlation-id: 3b3268a2-2d67-428e-131d-08dace8be3fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2s8aBzbeiXHaAYqsA4VnjWZpOApzPb+0Q2R53HSNFBZDnTZgJB1r2gdXcrmK5P35j2S2w0pmxshPaSa5uHiWqOPJD3nlMfEikegNWvspFSmlb2+zDmivJsNLoEy7yrFs7IZiOqSQNJeZsDVlZPUXOQlXVNJt4gKKbu79yFy4tOHJg8cGOKPoDbf2IGWzzHx32AD0/1UMoyFVHYInt4yCc3ssBRSADlOizFnYtXhD8gFDHXGesgIDyiSej62O+xeeGqX8xa3pWFSUtr9oLnPKk9SiryVJfk9x7BPnQ9KHNufLA62ZxKPluBVs8zlec4uXOY/VG0Tn6cI8GvNOVdCZRhV0TewuGAxkImr5AxZGXt5bG6F5aB3TEC9gY4GSf1bvqj+ECRvSTaH3QWy7IfTctAQeaKNf8LpWsyEOZPXvL/uo2goRo2L7zc9VcIxSx0ANFVW2SHvNpQPRoaPR0i4zBAcVdVru0CHx5fUnwHvQ3t8AV3TRpdagxIpwAioRbVUbICwgyU2kBIWyf2SnMrFA2+H0nFuDWzZetlJ0cKMThhES+L81MABYkIs8aRVSCwFYwhdDjIPHupllRfo/6lKaDJWPg/Ub5vUq1FSZSqtp8D8394iNrck6CsZ8XU+EiQMYj+dqkiV+61qLhBpFrIrNbDKBgYHl8RHQkugxiAZETUGc8japtMJe3DAsNy0QRmCJ/RJLBVtAOzvnoKbJ9tFyP0PLMUxn9HhxOy2S2FEHfU+JLIUnemZUs3iJZBCtH385gikW6iwwIl/Cs9ir2MXgFKj/5S+Bc+cn4Ej/83uC5tY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(1590799012)(451199015)(31686004)(38100700002)(122000001)(6486002)(82960400001)(1580799009)(38070700005)(76116006)(66556008)(66946007)(83380400001)(53546011)(64756008)(71200400001)(8936002)(5660300002)(2906002)(7416002)(8676002)(6506007)(186003)(85182001)(36756003)(478600001)(26005)(54906003)(316002)(4326008)(66446008)(66476007)(91956017)(86362001)(6916009)(31696002)(2616005)(41300700001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTMxbzlwc2JMSjlwQkd5bVZSVHJ3UlBIRHBrOGIrZUF5K0l4YUJ4RHdtdDE3?=
 =?utf-8?B?dEUzc3FkMHFBa2xtMjkzeXlNcVQ1WDBFeXR2TTNmZGt4RDNuSk9zai81dUR2?=
 =?utf-8?B?d01EbHliUnVJWkYxQmx0UXM3ckE2cEVvQ0xZR2tINCtkWkR3NkNmRzd4aTFn?=
 =?utf-8?B?U3FYTjlJSldPeVYzMTRmREZJRmEyRDJmNkRTb1hMNlFuTndkQmNIR1BZOXZP?=
 =?utf-8?B?SEJIeTJXQWVqSjI3ekJIS1BVdzAzc0RFWjRvREY2N216Q2VOZXZuNmQzV2di?=
 =?utf-8?B?cUxSSG4zZkFEb0xSTlk0T2ZpOUh3L21MLzRCWEJETzREWmxXMm1qNUo3K0NU?=
 =?utf-8?B?bkM4SlZrUUlwSFRpc21lNGxaN0MrZ0RuekdJQXNFd0ZocGN5Rm1FeEQ3SXUw?=
 =?utf-8?B?SmRrWWgxM0JYSTNXRzM2NVFrcUZFcmhUdFp1ZHFDT1Z2RW5VRkErQk0rTkRP?=
 =?utf-8?B?dkYyU0xRT3pmRG56M1YzdzdrUEJRd3BwbnpiTlZWMHloRzA2bXczcWRIQ3N2?=
 =?utf-8?B?STgwRTdlOVkyNkJBSmw2V09pbUhuaU5kRjNyVDNaVDVKbDFXVTVkRXFFS0k0?=
 =?utf-8?B?YXVjR2t6SkQ0c3ZnQlNDcmg2QXBjT1NqNVBCZVlBOXdsZExnNnVVRHdwMW5M?=
 =?utf-8?B?ZGcrVU1ZRk5LUkZTNVZoNHRIcDUwL3IxQjJSaE4reWxpMzk1d29haEVMWkF5?=
 =?utf-8?B?REdxdVNMRmljTldoS1hTdHhGclIxbVQ2UC9VVmlraVZFY3pHTkJmY0pPbk4y?=
 =?utf-8?B?a3VMT1VwOVpsd2lxa24raDNYbWI2T3FBcWx6TDF6YlNOdkhpV2dXRmpkTjdl?=
 =?utf-8?B?Y0FWamc4dG9tY1RvWjhURldVTFlVK0ZqbERheFNKSnlvSVlMODZkSVJLTlZ3?=
 =?utf-8?B?M1RiZEEzOW44VTQ4TVhrVHl0RXFnV3I5MzVSbmJ0aE01R0ovV251ck1Idms0?=
 =?utf-8?B?Qy8vNTByRDRZQW4zSmwwL29OOU8xN3hNWEVBdCtrMHFlWG5jYlJPVjhORXh0?=
 =?utf-8?B?Z0Rnd1g4cHp2TkhjVzlRUisrNExqRlVkYjJsaGdEVTBiU0tKMmhoVGlvUm1U?=
 =?utf-8?B?YmQxV0pxZHhVZzhjOHk1V2hGdHcyUDVLT3ZJenZNNGlNV3h4VlZsYXAvVmpI?=
 =?utf-8?B?M3o0UHBhZ2xITlhXMDZwU2NucUNLS2RSbnFKdHpjTWh6ZGQwOVd3YmdtRWc0?=
 =?utf-8?B?b1hNME1ZNWlGZXNvb2ZheUJLeUJBNEJadzhFZ3BuNUU4bEtwSlYxMWt2OHRL?=
 =?utf-8?B?UVd1ZFRQcTZkUjhHSm9vbWtkTkV4TmYycGsyZmU3Unc0dExyZGdhazJ2WkZu?=
 =?utf-8?B?M0ZnQjB0UVRLWmtQRGZNUlYrT3dwS0xkR0tsWVo4SHFESjJZQW0vUjdwa1Ew?=
 =?utf-8?B?TkdIZjF0aGpuYTQvdzgvZWJKTDgyUDU2NmhtT3JNRFAxY2JjUkNpUUovbkpE?=
 =?utf-8?B?SXRSd2lONHpPRUhUSGNGTE53UE9CM01uZEZHYmxFaVo3bWJvYzZud256Z0Z6?=
 =?utf-8?B?QkxVWkp4azRLa0JoM2E3U3c1YVhwd2NKNVV0bGRkamI0bTRIZHRielllMlhE?=
 =?utf-8?B?RTFmeVl4UUFhUGJJYndKb1ZmU09PRG1pNGlaRkU2YnlBa1V5d0RsNUg0WTZE?=
 =?utf-8?B?bGJWQ1BnelR4WWE2Mkd5UmtuZTZVSHZhL3ZUeWJ6bTlXT3dzOGxNeWh1OUdJ?=
 =?utf-8?B?YTNqdmtFRXZ4eXhtMjlpQ29JcUx3V3lCRU93alBNQXNhWnJ6a2wraCtoTjYr?=
 =?utf-8?B?R21PZWhzc1pWZXNjSENDTExMakVIeXZJUWRDaytVUFF3V3A3angzWk40U0tY?=
 =?utf-8?B?MXdWN2VpQ3JNaGcwOG5zK05HZUZWMEVZUjByVVMwUUM2TUc4Vi9qcStEcG5x?=
 =?utf-8?B?WDBjcVplRjFsa3dQdExDUFpxcWdMZDNwY0cyWWFPSWFBS3k0U0kwMUtiSHFh?=
 =?utf-8?B?VEtuQlV3WXFnRnA1VjFHVXZNZUx5Qld2SDcrYUpwcmFWTFMrWVJpT29DVjJs?=
 =?utf-8?B?S29mT09KYis5Q2ttYXhzUWVkd3EweUJ0eUI4TTJLenpncXZqVUVYNnhxeE5i?=
 =?utf-8?B?amRVK1RzZzR4dEt6d1JvMnNoaVd6WFhiSGgrMm9BSGtyQk5VczRSNXpZbUJR?=
 =?utf-8?B?MXZ1eldMS1BOaFV3N3BPVG9DMTBKTTFjZEhwMU1EOUc5RWQ3R2hqQlNCcDdm?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EE8DACA87D3454197EFD3D0099B5513@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?em03WnNPd0VvZXB1NlZNdHpQSjlHSHZVN2p5a2FYRGhGMVE3Rk5YZzE5cmV3?=
 =?utf-8?B?Qk0xUmE3YVRyMDkvblJwa0E3L21CeE9LK28yb2tWcjlyTE5rU0FvTTBYYS82?=
 =?utf-8?B?V20vL0gxN2h0NnVGTzExYXFPV2ZRckhVdkQ5aTg1VGVOaWRZYmkydjJMT2Ft?=
 =?utf-8?B?N1Jjc3J0cURyRjk0TU9KZlR0MU45SHRjbmR3NVdVU3NqRXFhWm54dTNnZno4?=
 =?utf-8?B?WVNjUnRQZTIxVWZOZ1g1OGEvL1V5K2IvSzViMEdlbE9IZFNuZ2Nzd3dDYU1h?=
 =?utf-8?B?dWZMWFI5akZseGNyVmN6VGVEWEd1RXhsOVA5Q0ZDOEo3cUVDemcxaHZJN2Iv?=
 =?utf-8?B?TG0yTU02TndlWDl1VjJBMFZ5cWxoZXFzS2t6ZFRkYlQ4RDhJTm1tVU1mMk9C?=
 =?utf-8?B?S3JzakhsUW5MZzBUMFE5WldyKzI1ODQra2pXeE1hc09hR2x2VFRsSklPRyta?=
 =?utf-8?B?eW83bEYrRDhJK2xtUjlSTHNTU3EyS3dxRTQzTXFWYU5ONlJjckkwSTR4Q3RJ?=
 =?utf-8?B?ZXF5R1ZGeG9yanVRMzhVaGgxNDZjbGgvazRPbmJNWkJUN0RxK0szeXgxV0VW?=
 =?utf-8?B?cUM5MEQ2V0tlciszQUtwZ0l4SjJ1YkFibGhFYzR0NUl6a2lVclpCVnA2YnRs?=
 =?utf-8?B?V2xkY21IVTF2bmVKdmJ5RldpS3BCa2xRSjk5OXZKTFVobEpGa3FnaTROS0xv?=
 =?utf-8?B?U1J3U3BZZjZ0Q1hicGpBb1dweVNzdkRLZmk5VW5kak9lUUdhb3BDeDRuZkN5?=
 =?utf-8?B?KzB2dUlDTHhQZUFzSXBjempVVi9ndFJycEN4RkU5YTRLVit0TnlJdi95TUJW?=
 =?utf-8?B?YVhCVU5ncGJCTEdkcEt2cStBamUzY2pFUnB4ME9yTDJNMGJPVkt0WnJZZHEx?=
 =?utf-8?B?RzFBODZaN1JPcU0veEVCWlphTDlwT3hNMStqWVU0WEdWMVBtdG9TM1ZGSUtF?=
 =?utf-8?B?NW95M3o5YkVPcWdOL0RaYmcrdkxyNzE3VnM5UVM3bFU3SHNUOGV2TjlZTGNY?=
 =?utf-8?B?RnY2cDFPTlk4cHlYUGJYS1JydEVUM0lMdmV3ZU1PM3FWL3JqMmo2STkzYXFs?=
 =?utf-8?B?K3ZqMTRUUkNrcTlTclpteVRFTWNvR0dyT0JTYjgxdWNIeHpISGNjWktGOXF1?=
 =?utf-8?B?ajI3NUtkQ2Q5aGJxaC9iajRmc1Fjc0hDVXo2ZTZzZjFPaSttUXBWWmhrR1RP?=
 =?utf-8?B?RXZYN0tuQnY1TFZXT1djZWlRYlpYVXlrMkdpMUVkL3ZDQXpGUlZ4TG1tQTJl?=
 =?utf-8?B?WTZKTVVCaUFUemkxNU5DT3d3bGlYamJJZWFDeDdPeDNEMTRlNGJEejB4RndZ?=
 =?utf-8?B?NklVbGhDSXYxN3gyNG1QYXRDVzVqdlMyWTJ5WGRySS9qWksvYXpRRmhIOWhU?=
 =?utf-8?Q?vpiSZWE2nqWSFH1dnfOkDSUQzquxx5F4=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3268a2-2d67-428e-131d-08dace8be3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 02:22:24.6366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSFkQw+TObPbWs22kQvx6ayM2d1BT55CmA7iXTaV9Lm/JHYHHEbwtcuVkfkM/PMQdvliRkSqW/6zLKx3hfzH/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9954
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI1LzExLzIwMjIgMDE6MzksIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2Vk
LCBOb3YgMjMsIDIwMjIgYXQgMDY6MDc6MzdBTSArMDAwMCwgbGl6aGlqaWFuQGZ1aml0c3UuY29t
IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAyMi8xMS8yMDIyIDIyOjUyLCBKYXNvbiBHdW50aG9ycGUg
d3JvdGU6DQo+Pj4gT24gV2VkLCBOb3YgMTYsIDIwMjIgYXQgMDQ6MTk6NTBQTSArMDgwMCwgTGkg
WmhpamlhbiB3cm90ZToNCj4+Pj4gSXQgZW5hYmxlcyBmbHVzaGFibGUgYWNjZXNzIGZsYWcgZm9y
IHFwDQo+Pj4+DQo+Pj4+IFJldmlld2VkLWJ5OiBaaHUgWWFuanVuIDx6eWp6eWoyMDAwQGdtYWls
LmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPg0KPj4+PiAtLS0NCj4+Pj4gVjU6IG5ldyBwYXRjaCwgaW5zcGlyZWQgYnkgQm9iDQo+Pj4+
IC0tLQ0KPj4+PiAgICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jIHwgMyArKy0NCj4+Pj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL2NtLmMNCj4+Pj4gaW5kZXggMWY5OTM4YTJjNDc1Li41ODgzN2FhYzk4
MGIgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMNCj4+Pj4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KPj4+PiBAQCAtNDA5Niw3ICs0MDk2
LDggQEAgc3RhdGljIGludCBjbV9pbml0X3FwX2luaXRfYXR0cihzdHJ1Y3QgY21faWRfcHJpdmF0
ZSAqY21faWRfcHJpdiwNCj4+Pj4gICAgCQlxcF9hdHRyLT5xcF9hY2Nlc3NfZmxhZ3MgPSBJQl9B
Q0NFU1NfUkVNT1RFX1dSSVRFOw0KPj4+PiAgICAJCWlmIChjbV9pZF9wcml2LT5yZXNwb25kZXJf
cmVzb3VyY2VzKQ0KPj4+PiAgICAJCQlxcF9hdHRyLT5xcF9hY2Nlc3NfZmxhZ3MgfD0gSUJfQUND
RVNTX1JFTU9URV9SRUFEIHwNCj4+Pj4gLQkJCQkJCSAgICBJQl9BQ0NFU1NfUkVNT1RFX0FUT01J
QzsNCj4+Pj4gKwkJCQkJCSAgICBJQl9BQ0NFU1NfUkVNT1RFX0FUT01JQyB8DQo+Pj4+ICsJCQkJ
CQkgICAgSUJfQUNDRVNTX0ZMVVNIQUJMRTsNCj4+Pg0KPj4+IFdoYXQgaXMgdGhlIHBvaW50IG9m
IHRoaXM/IE5vdGhpbmcgY2hlY2tzIElCX0FDQ0VTU19GTFVTSEFCTEUgPw0KPj4NCj4+IFByZXZp
b3VzLCByZXNwb25kZXIgb2YgUlhFIHdpbGwgY2hlY2sgcXBfYWNjZXNzX2ZsYWdzIGluIGNoZWNr
X29wX3ZhbGlkKCk6DQo+PiAgICAyNTYgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tfb3Bf
dmFsaWQoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+Pg0KPj4gICAgMjU3ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCByeGVfcGt0X2luZm8gKnBrdCkNCj4+DQo+PiAg
ICAyNTggew0KPj4NCj4+ICAgIDI1OSAgICAgICAgIHN3aXRjaCAocXBfdHlwZShxcCkpIHsNCj4+
DQo+PiAgICAyNjAgICAgICAgICBjYXNlIElCX1FQVF9SQzoNCj4+DQo+PiAgICAyNjEgICAgICAg
ICAgICAgICAgIGlmICgoKHBrdC0+bWFzayAmIFJYRV9SRUFEX01BU0spICYmDQo+Pg0KPj4gICAg
MjYyICAgICAgICAgICAgICAgICAgICAgICEocXAtPmF0dHIucXBfYWNjZXNzX2ZsYWdzICYNCj4+
IElCX0FDQ0VTU19SRU1PVEVfUkVBRCkpIHx8DQo+PiAgIA0KPj4NCj4+ICAgIDI2MyAgICAgICAg
ICAgICAgICAgICAgICgocGt0LT5tYXNrICYgUlhFX1dSSVRFX01BU0spICYmDQo+Pg0KPj4gICAg
MjY0ICAgICAgICAgICAgICAgICAgICAgICEocXAtPmF0dHIucXBfYWNjZXNzX2ZsYWdzICYNCj4+
IElCX0FDQ0VTU19SRU1PVEVfV1JJVEUpKSB8fA0KPj4gICAgMjY1ICAgICAgICAgICAgICAgICAg
ICAgKChwa3QtPm1hc2sgJiBSWEVfQVRPTUlDX01BU0spICYmDQo+Pg0KPj4gICAgMjY2ICAgICAg
ICAgICAgICAgICAgICAgICEocXAtPmF0dHIucXBfYWNjZXNzX2ZsYWdzICYNCj4+IElCX0FDQ0VT
U19SRU1PVEVfQVRPTUlDKSkpIHsNCj4+ICAgIDI2NyAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gUkVTUFNUX0VSUl9VTlNVUFBPUlRFRF9PUENPREU7DQo+Pg0KPj4gICAgMjY4ICAgICAg
ICAgICAgICAgICB9DQo+Pg0KPj4gYmFzZWQgb24gdGhpcywgYWRkaXRpb25hbCBJQl9GTFVTSF9Q
RVJTSVNURU5UIGFuZCBJQl9BQ0NFU1NfRkxVU0hfR0xPQkFMDQo+PiB3ZXJlIGFkZGVkIGluIHBh
dGNoNyBzaW5jZSBWNSBzdWdnZXN0ZWQgYnkgQm9iLg0KPj4gQmVjYXVzZSBvZiB0aGlzIGNoYW5n
ZSwgUVAgc2hvdWxkIGJlY29tZSBGTFVTSEFCTEUgY29ycmVzcG9uZGluZ2x5Lg0KPiANCj4gQnV0
IG5vdGhpbmcgZXZlciByZWFkcyBJQl9BQ0NFU1NfRkxVU0hBQkxFLCBzbyB3aHkgaXMgaXQgYWRk
ZWQ/DQoNCmluY2x1ZGUvcmRtYS9pYl92ZXJicy5oOg0KKwlJQl9BQ0NFU1NfRkxVU0hfR0xPQkFM
ID0gSUJfVVZFUkJTX0FDQ0VTU19GTFVTSF9HTE9CQUwsDQorCUlCX0FDQ0VTU19GTFVTSF9QRVJT
SVNURU5UID0gSUJfVVZFUkJTX0FDQ0VTU19GTFVTSF9QRVJTSVNURU5ULA0KKwlJQl9BQ0NFU1Nf
RkxVU0hBQkxFID0gSUJfQUNDRVNTX0ZMVVNIX0dMT0JBTCB8DQorCQkJICAgICAgSUJfQUNDRVNT
X0ZMVVNIX1BFUlNJU1RFTlQsDQoNCklCX0FDQ0VTU19GTFVTSEFCTEUgaXMgYSB3cmFwcGVyIG9m
IElCX0FDQ0VTU19GTFVTSF9HTE9CQUwgfCANCklCX0FDQ0VTU19GTFVTSF9QRVJTSVNURU5ULiBX
aXRoIHRoaXMgd3JhcHBlciwgaSB3aWxsIHdyaXRlIG9uZSBsZXNzIA0KbGluZSBvZiBjb2RlIDop
DQoNCkknbSBmaW5lIHRvIGV4cGFuZCBpdCBpbiBuZXh0IHZlcnNpb24uDQoNCg0KPiANCj4gSmFz
b24=
