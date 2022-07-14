Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A9B5750A3
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 16:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiGNOUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbiGNOUS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 10:20:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C36050E
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657808416; x=1689344416;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+429Z+64l1y86Lu5S1IENAwMyrenfAnTr/PznuvltKs=;
  b=ktTyVksIYTGRjZqBisLOwDSVSIqERm05H4BCNoNjc55Vweg4eSkw40Nx
   XYl4W5Ty6SFVT9U+28fblvIcaV0gsj+ap/2fdzUyX1PeI6uW5qgh1AmmE
   87qaQP9SS4Z4n/W+veuu0Jql4xC2O5llx+vJih2ebpGO2qKOH2WTD60ZM
   59FLgt6vQ8KlrLSj9tOYeh/h9tQtZNaLv1ZFDhbTfjubLva0R6Qc8jDoc
   ao4rsq+uThBZN9G/25Qv4Srilq0HBkDS4YgNuPxfvkr8cJxb4JErkn/09
   CkECiWa0E3C0ArDoPj3MCM7Z5u+/kLQKRH5tGfaVfFkFVxw7SaPaBBPgc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285546104"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="285546104"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 07:20:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="546283224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2022 07:20:10 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 07:20:09 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 07:20:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 07:20:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 07:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXdxeXCxbVN7Graf6x1WicR3Qm4WR7TJEUZikylPTOKWR6iux61PjG5aH88/LJvy60nUWFdpytZmLCF+IffvRlnqAioGwRf0RWtPG6d/ifIlbbQsgynbXhTKI2+qpJVlETz3+LInWsxxkcAzE9M67BKqGU51s+MOlGgohhTADXN5NWvWHaCLB6bS4vsG/2OOUVQG9CGKma/57gGXWY/qYeVue5Bo3rGqF/CjTrncmz8u21g4DnG4MzKWZTVNMFHqZcWT0vTXCdW1mHme7Urym1O4RlrXlDyqvU8RPc7JLlxxMrFu5zU1Ntemei6hJotM56uSAQRrjOnhVNvhzrq2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIQnGtjptIaLgMIOnd7jarzahuR4JBrRlFbHM2Jmcjg=;
 b=V6XiK5adXAJZtdHIJ8SyxZgO2DxZO8AuTfg7k3GLYAOnPQUYNYmWR/jdiietfCedI4ZR7va4Cw2ef+Q5Cb7LedURdWAwFWch2ovGkdZzoroPD+028GVmWMdJYye0FEUzBst+MVYKy5xGK+D2rePkmEG87CGliyO3JH36tMV9JBvhhextS1uSDu2GDyuIFn3jPpRDGYXcu1vGSVWgu2/axXOkMEZ9+dhW5rEBXbJB3r14a8XVgng6vn8PctAw0CNL443QbHpaTfXclUQn16S1Ed02bpfMNFrT08NHfYfXrD4gIfF4LGoFqHbUR+obHV8rQ59K1Ns6xJn2zsFgZf2crA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14)
 by DM4PR11MB5229.namprd11.prod.outlook.com (2603:10b6:5:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 14:20:07 +0000
Received: from CY5PR11MB6534.namprd11.prod.outlook.com
 ([fe80::9cfc:ab05:92fe:c17d]) by CY5PR11MB6534.namprd11.prod.outlook.com
 ([fe80::9cfc:ab05:92fe:c17d%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 14:20:06 +0000
From:   "Tung, Chien Tin" <chien.tin.tung@intel.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Thread-Topic: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Thread-Index: AdiKb2G3VsMZKUupSkG0ABXCvyvyGwNHT3cA
Date:   Thu, 14 Jul 2022 14:20:06 +0000
Message-ID: <CY5PR11MB6534B320E6A2794419E843F8DD889@CY5PR11MB6534.namprd11.prod.outlook.com>
References: <CY5PR11MB65342B7EDE1F12E1012ACC09DDB99@CY5PR11MB6534.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB65342B7EDE1F12E1012ACC09DDB99@CY5PR11MB6534.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8c10bed-439e-4b83-cdff-08da65a3f3b2
x-ms-traffictypediagnostic: DM4PR11MB5229:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YipMzERBkVlR/s9gaAcrUuwjs5yn9R008zN7PWu6PKoJqJpJSWDi5mMMx25kbCBwJd0oj4xgyZ2BNe1MrLsAJnfNb/SIOHywZpAcMwzGajV5Nffhzjs9ylymDbEaM3X5tnaDkV/3WtHgf4HjVuPVJtyl/b6N4lC0Z/c8JDHNv23iA+xzBsrYLXX/QX8xxAnXZ26kFpZ22oqtr1vupnPdr1i7RUB7b8hH9a0QuEgoq93w6koWHTXrwO64Oh/cvMZjEc14zA6tZkDMqOOPHA/8CzDBnM1oQ9txe2KiswGpZNsU2ZKpywF88DiBL2H6ToQofHx6TqTL7P4jls3akulrypj9klDmWv5Y8nj5VSiT7YfSjQG+ue26Fo8d8hXCiYEDd3cQsf5jzF/53hd/1I3mG/+tGapXjhQIUov5NUHeauk+MuDW0OmxUpvVfmEY0HnOyYenfjGNtY/6mBpBSkSHuSm6IZksH15DfpJsAgd3FMQ4yGkyg4Ga+Jz4cxDZHEIxucOvd340UD4/xCh4XDZkFCWAp8Y2QeUN6mlNxELwjeGGWbL507fzDhNnyP8b1FrYK/RG3ru7VTHSx/oQd8kKQtxSVED1zJ5jJYtFa/Dxt19TIIhAfTfybmwX2VbiSKUa6F5dd4K8ga3ucM+9b0kMv2Wk6OYGBgrFp4XzbkGqjGDZlcHuatLdVaclOIsS2VovmcjFgAR0qtJ/8DoaSZO1xz1/CAnx6AKex5B/+fagUwc7H86hqziXa4hea3cmoGlGYSYSWbp+Bo2/dtrVMsJuWY/gKKDbPU1vESjUOOmM332Ya2FwZ0BfizqasfdtVLNy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6534.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(346002)(136003)(66946007)(66446008)(478600001)(76116006)(9686003)(41300700001)(66556008)(71200400001)(66476007)(6506007)(8676002)(26005)(7696005)(86362001)(53546011)(64756008)(6916009)(316002)(122000001)(83380400001)(38070700005)(30864003)(82960400001)(186003)(38100700002)(52536014)(8936002)(33656002)(5660300002)(55016003)(2906002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVxGhmwTPT82vJ9UE69DmqTZ0oJq5nKJQ0yAdNusmvwRLl6ym/4EwhAuPMNQ?=
 =?us-ascii?Q?0GmkWHwdWtJc1VWhMDB97O36FXoiYRYj4NKzgLq4Qi5ysp3nfxrHMLAkxfd2?=
 =?us-ascii?Q?2IV06U8T22lqI6HcTwfuCP75CzlAzwIu8noDqw5pHwbPq8jC5WRnxw8Bu1/U?=
 =?us-ascii?Q?Dp4Le2DLW/Xa4kBaHnEYXqNRccGV3w08Mki59z+N1yhdIXtmdz6LgI7gbKfa?=
 =?us-ascii?Q?nqJ09YEcWwmTDdnl4V7+H00Kz4xUMsMm3CNg8vGjfdg2nk+yvncB3yStKYrR?=
 =?us-ascii?Q?h0zMQGOCQZmcvaTpYMuM7+a9/6l+ZcZNJpQDP0KkuPssM1VhYXUaRXc49fzY?=
 =?us-ascii?Q?rOQ8onBoWXtphffap7nRYgmps/r9fpOUSvNdGBUV1sahmojz3zSAU9zzw60t?=
 =?us-ascii?Q?CZN6YJQSyLErC7ht/4Mh1hJDSyh8KIp40FxWai/Lm3y/uI7DOTR/rbZUfpUa?=
 =?us-ascii?Q?88jj9N8gVuKylFoTtu+edl2SYnL+S+7nOaf6XoOLYxVw8oJ9SHChag7faOmH?=
 =?us-ascii?Q?V4MOxHIDXtm44fAVGqea9uP4VOn7iFXl9EqLGWhjLpkGJM8xml7U6NMghrh0?=
 =?us-ascii?Q?2bRPLzh0/yQnF6y34FJgMVQcZW7QQzUADykMgRk2Wa8qfVvxFo5EEasmNmNO?=
 =?us-ascii?Q?9JwCP8GqyYtQ7ZY4QnRE6lqAk1HwyimcXh4gdjLZpMZSE1VR/plzmAOm3HmS?=
 =?us-ascii?Q?Dxc8rNCuyoakg9T5Pvpz2Fs5h2/EnqlIeS5FeqPGiFBAMeaQMSu2JMbWPU+W?=
 =?us-ascii?Q?4cyxUZng/7vh3r8Olvm58szDGhQryLq2akHqYmQFvrSEyYq+DlXjmw5lLJhu?=
 =?us-ascii?Q?IOGCNqwSjUPemTkn17JWtpoZ9CCd92X198PMIoaWiIZLaQ8i1f7rnInDaGe3?=
 =?us-ascii?Q?xk1KCFnJpx/GxEoyM9DX7JUmpJWwhjfArLCbgTBAk0/mGyACOTiBkIYiMm/d?=
 =?us-ascii?Q?xCi/ZPovAvksbMfw8HnlrJN4jn529Lpmlacdegbyk4IA24tGFj/QUAPSFv24?=
 =?us-ascii?Q?fBMPfFOdWS6A96FiqqDd4Cnwx2NVYlXq/QSc+r8nk8mYthEqCn8ByXvTsmcu?=
 =?us-ascii?Q?Z9Xor3nYdHgkGEUa8PB16mjo+sJGUl2P7oI1AhnCKSlmPfRSWJQ4VvdSYgr6?=
 =?us-ascii?Q?avKjPfkxyFU4TY7sPcMqhcsjL3IAuJZVXUAvXEjyeplgWiG0xC0MIQVoK6KI?=
 =?us-ascii?Q?1SpbRAotxCQ3nx3HHW/fzmAAimiyTxH+2nZrFQ0/Jjmu3bT5PIMtQXVEth1O?=
 =?us-ascii?Q?vu4H0nNXOTfeCRoL/TJesOqCtfMY+vlJCPS6ANlug2htpWrBLgmXOhPmdTFx?=
 =?us-ascii?Q?Pi9UOIRSvJg+dn3pXsj4TRJiwf8NjLc2e3/w4UhzimK06MxJTHPMdSWqJqj5?=
 =?us-ascii?Q?xdcwZ2Y/DziRv6K+hEZw+Rj7kc4y6QG9pstPkmB9Hvea1lwy8KVeg5jajjks?=
 =?us-ascii?Q?qaQ6u+WnCNZ3ORSHz3aEdRtQIzoDjZAKmWtS8xKJqBfoWyqnAOMRFWLf1GDQ?=
 =?us-ascii?Q?ciI/1rXvucij7B4lOwgZ9vG0bVYTUrYh3MAaxYHeDIMqz5aPowN3/xpyzC00?=
 =?us-ascii?Q?JW9tZS1ZjYNB6vahVrb8nynwcxDIikkI5WCqVV7w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6534.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c10bed-439e-4b83-cdff-08da65a3f3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 14:20:06.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PP1F1dAZwOvdgMBFrXsbbwt56hQrIq+HDNc5BKVhhTcbcY1j0/J+NygqifG/K0Mt9CsNFNiX/fIb/Wx+/gzbpt2puzh0jnrG0me0h1dAgVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No one is interested in helping with Create QP issue with Mellanox controll=
er?

> -----Original Message-----
> From: Tung, Chien Tin <chien.tin.tung@intel.com>
> Sent: Monday, June 27, 2022 6:05 PM
> To: linux-rdma@vger.kernel.org
> Subject: Unable to create max_qp QPs on Mellanox ConnectX-4/6
>=20
> A customer is getting an error creating QPs during scale up testing on
> Mellanox adapter.
> I am able to reproduce the issue locally using a test program calling int=
o
> ibv_create_qp in a loop.
> The problem does not appear to be related to rdma-core as with different
> mlx5* drivers, I can either create 260,000+ QPs or 130,000+ QPs.
>=20
> Logs with command buffers and error messages are at the end of this email=
.
> All tests are performed using the same server, 64G memory, RHEL 8.5, same
> ulimit setting and selinux disabled.
> ConnectX-4 has firmware-version: 12.28.2006 (MT_2180110032), in infiniban=
d
> mode and  max_qp:  262144.
>=20
> Test 1 SW config - RHEL 8.5, MLNX_OFED_LINUX-5.5-1.0.3.2:,  max qp create=
d
> - 261935
> Test 2 SW config - same as test 1 with MOFED except rdma-core library is
> upstream c590cbd51632, max qp created - 261935 (same as test 1)
> Test 3 SW config - MOFED uninstalled, 5.18.5 kernel installed, rdma-core
> library is upstream c590cbd51632, max qp created 130863
>=20
> Can someone help me understand why Test 3 is half of the number?  Also, i=
s it
> possible to hit the max_qp number of 262144?
> Not to muddle the issue too much, I have observed similar behavior with
> ConnectX-6 (130763 and 261875 QPs) but don't have logs with those runs.
>=20
> Thanks,
>=20
> Chien
>=20
> I've interlaced "rdma resource" prints in the dmesg log  by pausing test
> program in gdb with breakpoint set to ibv_create_qp.
>=20
> <Test 1 log>
> [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261933 cm_id 0 mr 0 ctx 1 srq 0
>=20
> [  920.711591] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> cmd[0]: start dump
> [  920.711597] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [  920.711601] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [  920.711604] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [  920.711606] cmd[0]: 020: 00384800 00000015 0003ff5d 04000000
> [  920.711608] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [  920.711609] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [  920.711611] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [  920.711613] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [  920.711614] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [  920.711616] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [  920.711617] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> [  920.711619] cmd[0]: 0a0: 00000000 00000000 00000300 00000000
> [  920.711621] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe7c0
> [  920.711622] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [  920.711624] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [  920.711625] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [  920.711627] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [  920.711629] cmd[0]: 100: 00000001 00000000 00000000 00000000
> [  920.711630] cmd[0]: 110: 00000006 180c0000 00000005 44200000
>=20
> [  920.711634] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> cmd[0]: end dump
> [  920.712125] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]:
> start dump
> [  920.712129] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]:
> dump command data CREATE_QP(0x500) OUTPUT
> [  920.712131] cmd[0]: 000: 00000000 00000000 00040121 00000000
>=20
> [  920.712133] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]:
> end dump
>=20
> [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261934 cm_id 0 mr 0 ctx 1 srq 0
>=20
> [  938.006403] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> cmd[0]: start dump
> [  938.006408] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [  938.006411] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [  938.006414] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [  938.006416] cmd[0]: 020: 00384800 00000015 0003ff5e 00000000
> [  938.006418] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [  938.006419] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [  938.006421] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [  938.006422] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [  938.006424] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [  938.006425] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [  938.006427] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> [  938.006429] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> [  938.006431] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe800
> [  938.006433] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [  938.006434] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [  938.006436] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [  938.006438] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [  938.006439] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [  938.006441] cmd[0]: 110: 00000003 5ed0e000 00000003 5ed0f000
> [  938.006443] cmd[0]: 120: 00000006 1820a000 00000002 f1f87000
> [  938.006444] cmd[0]: 130: 00000002 f1fcf000 00000006 1805f000
> [  938.006446] cmd[0]: 140: 00000003 8efe1000 00000006 1805d000
> [  938.006448] cmd[0]: 150: 00000004 956b5000 00000000 00000000
>=20
> [  938.006451] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> cmd[0]: end dump
> [  938.006859] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]:
> start dump
> [  938.006864] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]:
> dump command data CREATE_QP(0x500) OUTPUT
> [  938.006866] cmd[0]: 000: 00000000 00000000 00040122 00000000
>=20
> [  938.006869] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]:
> end dump
>=20
> [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0
>=20
> [  952.880460] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> cmd[0]: start dump
> [  952.880465] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [  952.880468] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [  952.880471] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [  952.880473] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> [  952.880475] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [  952.880476] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [  952.880478] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [  952.880480] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [  952.880481] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [  952.880483] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [  952.880485] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> [  952.880486] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> [  952.880488] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe840
> [  952.880490] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [  952.880491] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [  952.880493] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [  952.880494] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [  952.880496] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [  952.880498] cmd[0]: 110: 00000001 d3ae6000 00000002 f1ef7000
> [  952.880499] cmd[0]: 120: 00000003 ae09f000 00000001 28268000
> [  952.880501] cmd[0]: 130: 00000003 ae007000 00000001 b4cf4000
> [  952.880503] cmd[0]: 140: 00000006 180fc000 00000002 2a9e6000
> [  952.880504] cmd[0]: 150: 00000002 f1ed0000 00000002 88295000
>=20
> [  952.880508] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> cmd[0]: end dump
> [  952.881353] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]:
> start dump
> [  952.881358] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]:
> dump command data CREATE_QP(0x500) OUTPUT
> [  952.881360] cmd[0]: 000: 05000000 0065b500 00000000 00000000
>=20
> [  952.881363] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]:
> end dump
> [  952.881401] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 4323):
> CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome
> (0x65b500)
> [  952.881408] infiniband mlx5_0: create_qp:3192:(pid 4323): Create QP ty=
pe
> 2 failed
>=20
> [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0
>=20
> [  969.559023] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> cmd[0]: start dump
> [  969.559027] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [  969.559031] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [  969.559034] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [  969.559036] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> [  969.559037] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [  969.559039] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [  969.559041] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [  969.559042] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [  969.559044] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [  969.559045] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [  969.559047] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> [  969.559049] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> [  969.559051] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe840
> [  969.559052] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [  969.559054] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [  969.559055] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [  969.559057] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [  969.559058] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [  969.559060] cmd[0]: 110: 00000001 d3ae6000 00000002 f1ef7000
> [  969.559062] cmd[0]: 120: 00000003 ae09f000 00000001 28268000
> [  969.559063] cmd[0]: 130: 00000003 ae007000 00000001 b4cf4000
> [  969.559065] cmd[0]: 140: 00000006 180fc000 00000002 2a9e6000
> [  969.559067] cmd[0]: 150: 00000002 f1ed0000 00000001 e54e4000
>=20
> [  969.559070] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> cmd[0]: end dump
> [  969.559508] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]:
> start dump
> [  969.559513] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]:
> dump command data CREATE_QP(0x500) OUTPUT
> [  969.559517] cmd[0]: 000: 05000000 0065b500 00000000 00000000
>=20
> [  969.559520] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]:
> end dump
> [  969.559553] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 4323):
> CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome
> (0x65b500)
> [  969.559562] infiniband mlx5_0: create_qp:3192:(pid 4323): Create QP ty=
pe
> 2 failed
>=20
>=20
> <Test 2 log>
> [rdma resource]0: mlx5_0: pd 3 cq 27 qp 261934 cm_id 0 mr 0 ctx 1 srq 0
>=20
> [ 3543.619746] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> cmd[0]: start dump
> [ 3543.619753] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [ 3543.619757] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [ 3543.619759] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [ 3543.619762] cmd[0]: 020: 00384800 00000015 0003ff5e 00000000
> [ 3543.619763] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [ 3543.619765] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [ 3543.619796] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [ 3543.619798] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [ 3543.619798] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [ 3543.619799] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [ 3543.619800] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> [ 3543.619800] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> [ 3543.619801] cmd[0]: 0b0: 00000011 0000010d 00000005 22861800
> [ 3543.619801] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [ 3543.619802] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [ 3543.619803] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [ 3543.619803] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [ 3543.619804] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [ 3543.619804] cmd[0]: 110: 00000004 32f72000 00000005 22a11000
> [ 3543.619805] cmd[0]: 120: 00000005 229f6000 00000005 22a38000
> [ 3543.619806] cmd[0]: 130: 00000001 7244a000 00000002 466aa000
> [ 3543.619806] cmd[0]: 140: 00000005 22a19000 00000002 8c046000
> [ 3543.619807] cmd[0]: 150: 00000005 8ac7b000 00000002 2c14a000
>=20
> [ 3543.619809] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> cmd[0]: end dump
> [ 3543.620284] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]:
> start dump
> [ 3543.620291] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]:
> dump command data CREATE_QP(0x500) OUTPUT
> [ 3543.620295] cmd[0]: 000: 00000000 00000000 00040122 00000000
>=20
> [ 3543.620299] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]:
> end dump
>=20
> [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0
>=20
> [ 3560.087852] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> cmd[0]: start dump
> [ 3560.087857] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [ 3560.087860] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [ 3560.087863] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [ 3560.087865] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> [ 3560.087867] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [ 3560.087869] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [ 3560.087886] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [ 3560.087887] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [ 3560.087887] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [ 3560.087888] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [ 3560.087888] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> [ 3560.087889] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> [ 3560.087890] cmd[0]: 0b0: 00000011 0000010d 00000005 22861840
> [ 3560.087890] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [ 3560.087891] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [ 3560.087891] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [ 3560.087892] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [ 3560.087892] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [ 3560.087893] cmd[0]: 110: 00000005 229e7000 00000004 65ddb000
> [ 3560.087894] cmd[0]: 120: 00000005 22a01000 00000005 22a0f000
> [ 3560.087894] cmd[0]: 130: 00000005 8ac73000 00000003 a6d42000
> [ 3560.087895] cmd[0]: 140: 00000004 05f58000 00000005 22a10000
> [ 3560.087896] cmd[0]: 150: 00000005 22a4c000 00000001 fc0da000
>=20
> [ 3560.087897] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> cmd[0]: end dump
> [ 3560.088787] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]:
> start dump
> [ 3560.088793] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]:
> dump command data CREATE_QP(0x500) OUTPUT
> [ 3560.088797] cmd[0]: 000: 05000000 0065b500 00000000 00000000
>=20
> [ 3560.088801] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]:
> end dump
> [ 3560.088827] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 9217):
> CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome
> (0x65b500)
> [ 3560.088837] infiniband mlx5_0: create_qp:3192:(pid 9217): Create QP ty=
pe
> 2 failed
>=20
> [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 srq 0
>=20
> [ 3577.184180] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> cmd[0]: start dump
> [ 3577.184185] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [ 3577.184189] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [ 3577.184191] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [ 3577.184194] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> [ 3577.184195] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [ 3577.184197] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [ 3577.184199] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [ 3577.184200] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [ 3577.184202] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [ 3577.184204] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [ 3577.184205] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> [ 3577.184207] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> [ 3577.184209] cmd[0]: 0b0: 00000011 0000010d 00000005 22861840
> [ 3577.184210] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [ 3577.184212] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [ 3577.184214] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [ 3577.184215] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [ 3577.184217] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [ 3577.184219] cmd[0]: 110: 00000005 229e7000 00000004 65ddb000
> [ 3577.184221] cmd[0]: 120: 00000005 22a01000 00000005 22a0f000
> [ 3577.184222] cmd[0]: 130: 00000005 8ac73000 00000003 a6d42000
> [ 3577.184224] cmd[0]: 140: 00000004 05f58000 00000005 22a10000
> [ 3577.184226] cmd[0]: 150: 00000005 22a4c000 00000000 00000000
>=20
> [ 3577.184229] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> cmd[0]: end dump
> [ 3577.184619] mlx5_core 0000:02:00.0: dump_command:844:(pid 0): cmd[0]:
> start dump
> [ 3577.184627] mlx5_core 0000:02:00.0: dump_command:851:(pid 0): cmd[0]:
> dump command data CREATE_QP(0x500) OUTPUT
> [ 3577.184630] cmd[0]: 000: 05000000 0065b500 00000000 00000000
>=20
> [ 3577.184635] mlx5_core 0000:02:00.0: dump_command:887:(pid 0): cmd[0]:
> end dump
> [ 3577.184665] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 9217):
> CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5), syndrome
> (0x65b500)
> [ 3577.184675] infiniband mlx5_0: create_qp:3192:(pid 9217): Create QP ty=
pe
> 2 failed
>=20
>=20
>=20
> <Test 3 log>
> [rdma resource]0: mlx5_0: pd 5 cq 5 qp 130861 cm_id 0 mr 0 ctx 1 srq 2
>=20
> [354817.776532] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730):
> cmd[0]: start dump
> [354817.776560] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [354817.776583] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [354817.776597] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [354817.776611] cmd[0]: 020: 00384800 00000017 0001ff49 03000000
> [354817.776623] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [354817.776955] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [354817.777188] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [354817.777446] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [354817.777701] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [354817.777953] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [354817.778150] cmd[0]: 090: 00000000 00000115 00000000 00000000
> [354817.778371] cmd[0]: 0a0: 00000000 00000000 00000800 00000000
> [354817.778590] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35ac0
> [354817.778824] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [354817.779006] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [354817.779179] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [354817.779377] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [354817.779571] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [354817.779766] cmd[0]: 110: 0000000a 67fb0000 0000000a 67e80000
>=20
> [354817.780058] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730):
> cmd[0]: end dump
> [354817.780623] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> cmd[0]: start dump
> [354817.781147] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> [354817.781478] cmd[0]: 000: 00000000 00000000 00023be6 00000000
>=20
> [354817.781893] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> cmd[0]: end dump
>=20
> [rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130862 cm_id 0 mr 0 ctx 1 srq 2
>=20
> [354834.277537] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730):
> cmd[0]: start dump
> [354834.277755] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [354834.277930] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [354834.278108] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [354834.278288] cmd[0]: 020: 00384800 00000017 0001ff4a 03000000
> [354834.278499] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [354834.278710] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [354834.278930] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [354834.279102] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [354834.279274] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [354834.279454] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [354834.279685] cmd[0]: 090: 00000000 00000115 00000000 00000000
> [354834.279886] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> [354834.280056] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b00
> [354834.280226] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [354834.280419] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [354834.280612] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [354834.280819] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [354834.280974] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [354834.281124] cmd[0]: 110: 0000000a 67f98000 0000000a 5f658000
>=20
> [354834.281421] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730):
> cmd[0]: end dump
> [354834.282011] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> cmd[0]: start dump
> [354834.282327] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> [354834.282674] cmd[0]: 000: 00000000 00000000 00023be7 00000000
>=20
> [354834.283275] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> cmd[0]: end dump
>=20
> [rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130863 cm_id 0 mr 0 ctx 1 srq 2
>=20
> [354857.088810] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730):
> cmd[0]: start dump
> [354857.089037] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [354857.089216] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [354857.089392] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [354857.089605] cmd[0]: 020: 00384800 00000018 0001ff4b 03000000
> [354857.089817] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [354857.090043] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [354857.090221] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [354857.090395] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [354857.090576] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [354857.090809] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [354857.091029] cmd[0]: 090: 00000000 00000115 00000000 00000000
> [354857.091206] cmd[0]: 0a0: 00000000 00000000 00000600 00000000
> [354857.091382] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b40
> [354857.091584] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [354857.091782] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [354857.091993] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [354857.092155] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [354857.092310] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [354857.092469] cmd[0]: 110: 0000000a 5f658000 0000000a 5f788000
>=20
> [354857.092829] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730):
> cmd[0]: end dump
> [354857.093900] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> cmd[0]: start dump
> [354857.094313] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> [354857.094515] cmd[0]: 000: 05000000 0065b500 00000000 00000000
>=20
> [354857.094871] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> cmd[0]: end dump
> [354857.095093] mlx5_core 0000:02:00.0: cmd_status_print:808:(pid 110379)=
:
> CREATE_QP(0x500) op_mod(0x0) uid(2) failed, status bad resource(0x5),
> syndrome (0x65b500), err(-22)
> [354857.095923] infiniband mlx5_0: create_qp:3035:(pid 110379): Create QP
> type 2 failed
>=20
> [rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130863 cm_id 0 mr 0 ctx 1 srq 2
>=20
> [354893.848503] mlx5_core 0000:02:00.0: dump_command:852:(pid 103730):
> cmd[0]: start dump
> [354893.848747] mlx5_core 0000:02:00.0: dump_command:859:(pid 103730):
> cmd[0]: dump command data CREATE_QP(0x500) INPUT
> [354893.848949] cmd[0]: 000: 05000002 00000000 00000000 00000000
> [354893.849151] cmd[0]: 010: 00000000 00000000 00001800 00000018
> [354893.849351] cmd[0]: 020: 00384800 00000018 0001ff4b 03000000
> [354893.849562] cmd[0]: 030: 00000000 00000000 00000000 00000000
> [354893.849815] cmd[0]: 040: 00000000 00000000 00000000 00000000
> [354893.850059] cmd[0]: 050: 00000000 00000000 00000000 00000000
> [354893.850258] cmd[0]: 060: 00000000 00000000 00000000 00000000
> [354893.850459] cmd[0]: 070: 00000000 00000000 00000000 00000000
> [354893.850668] cmd[0]: 080: 00000000 00000000 00000000 00000000
> [354893.850939] cmd[0]: 090: 00000000 00000115 00000000 00000000
> [354893.851151] cmd[0]: 0a0: 00000000 00000000 00000600 00000000
> [354893.851340] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b40
> [354893.851526] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> [354893.851740] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> [354893.851948] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> [354893.852165] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> [354893.852339] cmd[0]: 100: 00000000 00000000 00000000 00000000
> [354893.852505] cmd[0]: 110: 0000000a 5f658000 0000000a 5f788000
>=20
> [354893.852893] mlx5_core 0000:02:00.0: dump_command:895:(pid 103730):
> cmd[0]: end dump
> [354893.853565] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> cmd[0]: start dump
> [354893.854324] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> [354893.854683] cmd[0]: 000: 05000000 0065b500 00000000 00000000
>=20
> [354893.855182] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> cmd[0]: end dump
> [354893.855474] mlx5_core 0000:02:00.0: cmd_status_print:808:(pid 110379)=
:
> CREATE_QP(0x500) op_mod(0x0) uid(2) failed, status bad resource(0x5),
> syndrome (0x65b500), err(-22)
> [354893.856328] infiniband mlx5_0: create_qp:3035:(pid 110379): Create QP
> type 2 failed

