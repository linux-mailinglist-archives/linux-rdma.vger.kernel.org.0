Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C948E4DAD94
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354914AbiCPJfo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354912AbiCPJfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 05:35:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2252AC78
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647423267; x=1678959267;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=3knxs9EvSpWDGfi0oO26grbT3j6sj6IYGZU7U1S8ouM=;
  b=aFuBIYU3eOJqoZsWApN0+N++b+XfbbFhUgvHbKjCtR7bhb0Es6Iv4dGR
   Su0pqr7VVaBn0cnslp6bsVS+hGPizvXrih9EK7nYLR7/cPj1WC5CuQrGq
   dzgXbAye0uiG1pqe4DiNgP8IOinWuGlkEl8SZ5pGOlusjgnqok9OMimby
   Za32hZdWM74CQqr4ihRrLna00toZgZyaG17omx8ftmbLT62DsbcQsLaF1
   Ge1905z2EpoKMOhlFpvOaxip8xInfHXJY3NNyZjjceFeCp2bUny0rOedF
   y4hcpQcpGoLXIfyYZpYMDs3wBl5hzD/znF++1E05X59gBVQP6AMD6jSnV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="254093992"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="254093992"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 02:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="783400889"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2022 02:34:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 02:34:26 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 02:34:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 02:34:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 02:34:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqjgV+3EQ0xN+RT23PwhwygF3yfSA2pvKNdMej1/BqY2kQTqn4iDmhati7GJrjMyIMPY3RnMaN+rKK7exuTtYZLOw/YZEgJUFSyg58Z5MswKrIwzyFM7ztaSWkMe4hz7FQO+/f75ag7L3bmwg/Bwh+sa/YG65JxJFPpHfT9gpBybM7bU/v/Emgg8PYDdtJWHpLWErhWYKBcNU+cbMmCyI9QrRLGw5FrlJACcYkgCAqA7UBHKBwKSqa3UX8OvnnoRJon5iXycycgRK1MscMuQ8TSDO5lyFqbYdaMZjZOQ1B9x3CDpK2/Gt6CYtfPsk+8urqLTYo7+VdqYruNmNUYQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3knxs9EvSpWDGfi0oO26grbT3j6sj6IYGZU7U1S8ouM=;
 b=f2IRYnM57V9/Nd1AuTiVultjD8qb9tt5qzEd6YK70+TgYllFsvtiZChyR5KvS1U+vRkVxb4DMPoI4HeCkRENwpdTZRRuQ0TLawyKu06PqqkApiav+wkkdRONePmoPYaBW6l7wV8xtNbi6ArHbNum7TPRd5dib62lLkVV8NuL1HB0v4nimJAW8hBL3whKOvVaMBw9THhehWCQv8LyQS4sMTcC1jr46/59imvOwB5H76W84rcPKoCUxQArGbbQ2N8D6eq/It52jJ8GMarE4DSVUgOm3EyT+XYLTGwR2uxdgF53gl6pBPo4Xq3EfbNItO60Qc2raZ+XCm/NB4U6nM205Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 BN8PR11MB3636.namprd11.prod.outlook.com (2603:10b6:408:8c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Wed, 16 Mar 2022 09:34:20 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::d4c9:5841:3761:6945%4]) with mapi id 15.20.5061.030; Wed, 16 Mar 2022
 09:34:19 +0000
From:   "Latecki, Karol" <karol.latecki@intel.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Question about v37 and v38 minor releases
Thread-Topic: Question about v37 and v38 minor releases
Thread-Index: Adg5F68NSHLb2hrfRe6Z3CoHloywpwAAMkjwAAAdRuA=
Date:   Wed, 16 Mar 2022 09:34:19 +0000
Message-ID: <DM4PR11MB55494BCEA81DCEB6FED81834E7119@DM4PR11MB5549.namprd11.prod.outlook.com>
References: <DM4PR11MB5549E169E3C06766D347A936E7119@DM4PR11MB5549.namprd11.prod.outlook.com>
 <DM4PR11MB55492CF07DCC8105204D39AFE7119@DM4PR11MB5549.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB55492CF07DCC8105204D39AFE7119@DM4PR11MB5549.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa1db160-630d-460d-f1af-08da0730256d
x-ms-traffictypediagnostic: BN8PR11MB3636:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3636F24DB1BDD264826E99C0E7119@BN8PR11MB3636.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kv6NHnygNJPfiedvQy1ZQUGBtvmtLNWCXaNfLejXahf1BnvVuL5n8uIW4R0TNAmh/is0IHDz17dV8SlZKzMBkeos0lIDHbQUdaH96Xnw1mjGixVdu4Wuom4q3dPabIaCrNYa4KnR/BdvX8fWPNtRSEK+izDhNcE+GnFy2E06JMKnDpeMElq4Eu3eGw8RbDNDHDBfxaWcRERD1JbwjDbWdSLPwBAF51jl/64py5Vzz4Tkyt58F/90NhNW9s646wmx8GzfxjswPekfW/iDuSf50ZVyagVp7jECbZ/wZoonBTNnsaNr5N+9LyzG8WeGuuOVxTXcWlhZjyjHyP2rGEkKsGj8vrpK3KMzuLcQYTSmKF6JDfUdlbwJseqFcBGK0eT7MB+TCDeWl0ZDqG3j1ZF9am+sBiTvcZlHLAdmkRPqwxJNxzzRooBxsVdSvdu4Z3zB9oj2z5ILZXYHxs3CxbfgWYEl+dAwUHTgMJvvif1GBS2Ooj857OJGXbTCCdW7KpkzNa+7efs6YhJ59e3De6VG9jH1QJGDNnIXA5fgAOhubd2Swi26qBk6toDIZxK/m2Fak0T8FyKMumTvw6Qb1JcKtEraYJ2wypPWxet3KzkLK5WmvDa/7i/rVVbiQdv5WRHcPug0tJgvxVQ58sonz/kTKwRjCc1Zu2Fts/r823ClFSmw3cOtCjVEhc5nChdGQwKrF/Tg8mB0sqCI4LrN491jdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(7696005)(64756008)(66446008)(66476007)(8676002)(186003)(6916009)(26005)(508600001)(71200400001)(33656002)(66946007)(8936002)(76116006)(52536014)(66556008)(5660300002)(83380400001)(55016003)(316002)(4744005)(2906002)(82960400001)(38100700002)(2940100002)(9686003)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1OmA2/N5PV1dyLr9kWi/OQwR3XeYQuoD5Yn/g5hcYIFGSHpT1MrVjPd1G9l9?=
 =?us-ascii?Q?8JZZ8KhDcpeIUgAUjzzIu/+of70ca9RCqYJkJ1uGDVluaxkPaVyY8JL67mtY?=
 =?us-ascii?Q?Z/cJLgqs2PTFhMtzlLAlgCyq4m7JRundJzqxCFqXjae2mpzi/fFueZgw5Y4G?=
 =?us-ascii?Q?lDqdDKHCkMMEADfhO6hfen7vwkvcjKmKvthFR/u7kID/5cKbLSQapEF+K3Bn?=
 =?us-ascii?Q?aBW2NLvvlCCYzRrzAG6NLxmF54guhyBcSUHjPu0P3OMClCPIvX2dsWxKZGLP?=
 =?us-ascii?Q?SKATK5lIy+vss3upjOI9WuGH6C/I88nn8XgibSnDiJZmkO05BQsnv2c7iDYk?=
 =?us-ascii?Q?TxYNpR1WFyGXXb6tKvKWc9uC2WnsKRpqxsb9m4wp+81flm/PZgAgZr+U9zjZ?=
 =?us-ascii?Q?F1VpM16s3x+dUV0/HjkeX8ntGXLb6SlOeYbkX5UyALab3IfduKXHlaifR1Tw?=
 =?us-ascii?Q?2A5PF9NMcnrP7lbixGfAyPZkfwKr+U4/1O4ZxnpemltIaRkItXwj/nplQ2w3?=
 =?us-ascii?Q?7j81kTQXz2fcS3FPQmGVDBKkHY9+JeRzMs3cfeBFH4SHx98wBpo6m811I2/d?=
 =?us-ascii?Q?QxlvkV5hKexuVsmQNOyXrQu6ioa95vY3b45K8NNBuEnkyIH3VoMsCHLnF8sM?=
 =?us-ascii?Q?D1t+plmjTDer/CvNZb/gM4dDIQ5Sorrv7er3mkIR7+t5CcOllDLxIOFL9Hpr?=
 =?us-ascii?Q?ZaIb32hiLeRF9s/u4Dy32xfx+1yg4H5fXp+g6SphexbPPrdwjVphMZunp8O9?=
 =?us-ascii?Q?XDWXoJmd4UX3/KuKJQ7FA5EKsBk9g/frhYbk2E+rqiw2RhvFL7gl5mhkl8wt?=
 =?us-ascii?Q?Hn6lx3423K2YIzOgJ/PCbkyQ06LXMG6F08t34MPLUCPRLarpav2yaj5PjdW0?=
 =?us-ascii?Q?wTtFd6hI04L0mVM+pOQdXM/fG2QII9+qH2hCzPouKNldRkckUUsyhz6s1ncF?=
 =?us-ascii?Q?xSJ4WJGQ3EE5ongzFXSzXu3nqEpfVp0jGsNyBG6Mf/StUY2ytM2Zu1KrLOSz?=
 =?us-ascii?Q?Ew/qDcwZ3NcSAZNj6jGE+mZzHrYWjyo2akOUuVok24zGDgi9tS68ynJWptN2?=
 =?us-ascii?Q?d58DoYi9Zqik2pJSZJze5aZLTVhsv67lFik2mKTBZDXniTJgm2cuRVPx4eIv?=
 =?us-ascii?Q?BKKQmbHuo/cicDG9ZKfc51r8oKyN9WCmdATRTUABLTdnl/FULHt6iIgv77Ka?=
 =?us-ascii?Q?yOIY5A8WqfTAyCiEFQSJmsS/qqWze9wNBGHsLzvKYxUr/Nzwg9soC5QchQke?=
 =?us-ascii?Q?z28LpwjnZbFo66gZr3VeezgYD+fmOmOLk2tBGswQlYjOrymMQwchPF1YySB/?=
 =?us-ascii?Q?D9gqFaIAl7ApCNkhEU21m/aQYBuLONZIpymAdaAuu9HEluCxBL4DRS/WpbTp?=
 =?us-ascii?Q?cMfBXnyS5pqSOfbpai5WSRuoH1QSlKPK00yenZ6CiHCqLISbhZYBCRdEgo7p?=
 =?us-ascii?Q?tcwn0l//TRy2v9cvCmnw0GuAFMsDm9M8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1db160-630d-460d-f1af-08da0730256d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 09:34:19.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdhPHhbzmfUec0lJucZpwpDweV8PH9/bQvvh3+2kNz2zzGc4C2yUtaOo/11iMt3sOgQsdtRzlMxtLW0YKIy99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3636
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello!

I would like to ask if there are any plans or ETAs for rdma-core v37 and v3=
8 minor release? Our team is waiting for 4c905646de3e75bdccada4abe9f0d273d7=
6eaf50 "mlx5: Initialize wr_data when post a work request" to be upstreamed=
 to package repositories like yum or dnf.
Apologies for low-importance question, but I did not find any road map or o=
ther communication channel on rdma-core github site.

Thank you!
Karol Latecki
