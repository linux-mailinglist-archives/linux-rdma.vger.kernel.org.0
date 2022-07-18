Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2628D5779CC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 05:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGRDsd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Jul 2022 23:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGRDsc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Jul 2022 23:48:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F012AF8
        for <linux-rdma@vger.kernel.org>; Sun, 17 Jul 2022 20:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658116110; x=1689652110;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oBSpAyTCtGm6z1OrlKw8aHFItAGJUB0HlZ/J+9QBZw0=;
  b=HKM4Ef6LFfq6OK0rNy9rWnZXRZwQPomuwxVUTKwpiqvjihOrEcZJ+Awr
   x5x+9dJKyNlFGVM+Mw077bNBb0mDzzWN7X1cS32jnnGP8C+ByKD7LzkPZ
   GFUWoUjD7JFyRNyZAbsIWNUkdUBXov51rPn1m30N0shYQsK+tI3G6Bzl/
   0WVDk5XDGG/gsdrGXHtpIUY4OVF/SSk78Xlu6iN81zWadaJAbmOENvD+R
   NtwKdcM8MnZGt7Kf9jqkQl95NA0J4RbNNY2h8O1xwRkQTq/8O31cr0vPk
   MKkyuWZT4p0rp9gk/ziqEchkpRM1fQ6xygXRHWBekdZx5hy4luIzzhsjz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269148293"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269148293"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 20:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="723715890"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 17 Jul 2022 20:48:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Jul 2022 20:48:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Jul 2022 20:48:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Jul 2022 20:48:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGNOkYnKwoB6DT7oHMO3ucxF1Pj2wDrF7aDj1IZYEIqPbIUaaILR11qq5cR8o55k4xKmWEW6Hq/vuN71ELv2fqzPSyGQJalzgiMQ/+teUalsTIliM7A6+MbEKQRIxB0KjBiajT+EKj0DkFBvDhFXmTYQcitM65Gdfmx2ZYOesnjHk/HbHuUQnodS5lPyAUVOTW6gK20pRfLg2Es4hQrEet/zAhcbWoxOPU+9aPBSPABKX11UtiHoUhH3aZkGV9RMEinZv0DoZXG4msXZk2GqQvcB+0csmpYPFbt4QoCs9cU4VP2P5n2bZDsPU5n1+tHwITIBITbfRwyJk9thzxwuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSqC/KFA2VmphDmMoicUL6d3FuixN8KW1o/weScFJW0=;
 b=ARDLE2VviJjzxuL6xl6DuiSodO2u7PxU8KIvIYTjbCse05bq75/CLLhk7lM2NWeko2yN9jfgtNU3Grhu4Vz9tWcLoBShR70xGvUsj9GyR3lS3A1mWw3mOBmFfR/GK5U778aTGbpttDuDWUsp698GbD8NPaj8k5Gkl+z56AyOzssbxoIIFWtC3JuDG7Hp7VwfLhvZ6g1U5810JQ0ApyoI2IWeojE8n4wCBjb1IjlMgHSuNuUpxBo+KcQGZs9jalVHInwnckj/nK3zLn2ovJv389oYZ4xCDXz5UDdsNwVSsUiR5nAbh3c/aGfvsNxZVIu0c9dvjuj/2GdfxxmBVZQCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14)
 by BN6PR1101MB2212.namprd11.prod.outlook.com (2603:10b6:405:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 03:48:26 +0000
Received: from CY5PR11MB6534.namprd11.prod.outlook.com
 ([fe80::9cfc:ab05:92fe:c17d]) by CY5PR11MB6534.namprd11.prod.outlook.com
 ([fe80::9cfc:ab05:92fe:c17d%6]) with mapi id 15.20.5438.014; Mon, 18 Jul 2022
 03:48:26 +0000
From:   "Tung, Chien Tin" <chien.tin.tung@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Thread-Topic: Unable to create max_qp QPs on Mellanox ConnectX-4/6
Thread-Index: AdiKb2G3VsMZKUupSkG0ABXCvyvyGwNHT3cAAIdulwAAJ9u4oA==
Date:   Mon, 18 Jul 2022 03:48:26 +0000
Message-ID: <CY5PR11MB6534C428394164059E0BD6DBDD8C9@CY5PR11MB6534.namprd11.prod.outlook.com>
References: <CY5PR11MB65342B7EDE1F12E1012ACC09DDB99@CY5PR11MB6534.namprd11.prod.outlook.com>
 <CY5PR11MB6534B320E6A2794419E843F8DD889@CY5PR11MB6534.namprd11.prod.outlook.com>
 <YtOyotf+cAVqUaJs@unreal>
In-Reply-To: <YtOyotf+cAVqUaJs@unreal>
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
x-ms-office365-filtering-correlation-id: c3e6dff8-0069-449a-82a3-08da68705ec9
x-ms-traffictypediagnostic: BN6PR1101MB2212:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coBzmpIGAe+efg1WBzGyizSoWQhXh/WLjtnrQ2J97FnC7C2AfHQvMqmwGSP8kseP4lBAa0RySLYAY+ytlgKE4yLCfew8KrFbTyvHep9bn3lqiImOSAeZFmeVqzyELg8hi0CY7BZGDGt3DaIZjk3xJWcjjtQtjsKdGZjn34JBjdD12gCVjrJUSFekWZY9xXoMwKqhIcHzCVRBzATaekK/8AanZUTfHBkloTZCrP4kES8ZR0Cb7tl48kP56b5ZNZu6HXFVGwv+vKopo054eqoGo0TpEZfDSUEPbqRO+di3a0c6O/tVc1ixViLTwamWy8b5r+J3GL1uhzmaid/QS3+Dw4Xpj34JHoKs81iiXOrwTHQGLAOmJNmZTVVgfTf02rCTx/Q3FJf4eXDh1w5p38Wy28Yg43Cj8EVdcWwIAtWBkaGiexYKB/AQIkFd5UgycAq7xYZDNoE3PJx7wL3Y3/tUZp9UyGctKZ3hl8g7vAkC0rPtrJfeBpxbjEvUq+vVTr21lgGssfH18eBdM89G5HPvXE+gKLelYBa/fJ555wl0VwsyFckwHB2SUO1HaeR2dpp+XGD/PyySYilI7sSpumj78FJJ+Tx5nNTEqv94wIoP+iUrFzYjU9LNiYDzfGVkIzIubtBIIYF8Pp7zHyEWK4N/y9JLbSii45OrG3Vyf7spJAOF6u1fTHlS8j8s7rHsxIe5oB1DM9AHujk9YUj06OtYsQyQUyXWNyQayAqQ93hCItkuFXBpMtpndDLJLRQPT3MRua7ZU3323WFpUTFwYL/eGU/IHatvx7q8AbIdMx1cq43l5YOYZlg13BdckKME8CnJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6534.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(136003)(346002)(396003)(55016003)(186003)(83380400001)(110136005)(38100700002)(66476007)(66556008)(66446008)(76116006)(316002)(66946007)(8676002)(64756008)(41300700001)(8936002)(6506007)(7696005)(2906002)(5660300002)(86362001)(9686003)(52536014)(82960400001)(30864003)(38070700005)(26005)(33656002)(122000001)(71200400001)(478600001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xiz+bEAHt/D6PaF2QHCA66VJ71soCnSmhikW9NEgGVlwaOHe7poNR4wbTcZb?=
 =?us-ascii?Q?WP3pDB75JJzATxp3CLV+NkeKrYLQovkZojDB4QxylgEgKt57Z5MEAHV8xrJD?=
 =?us-ascii?Q?0MIjH+QBROOC9zEH9r70+Qq+gB4fJlQZscOxsFEy0HoCGWbnA+EjngaRnCRr?=
 =?us-ascii?Q?LJu345Q1Bxn0M1guP8GQSQHZsxnSbwoyz9ukdZAw+YapbdwWDOeAmn5ftCaJ?=
 =?us-ascii?Q?SgCNWIhc01q8zdRu+AbCDvEz6oEO+Xu3QFjCS12JRNd2qAK/WmWwEFegsMfw?=
 =?us-ascii?Q?0HKB9PFJMdWRUaqI7J0J/ATfanE3lmXadLP0ATqXLy+hHQqWL2B1bFOut5b8?=
 =?us-ascii?Q?CnLJUFjpGCIV4jaHH/6q0thhZPH2gks8DnyKpdRWywwI4IP3yKtLUULBorT9?=
 =?us-ascii?Q?9TGz84jjXChBA5jz0TMacEm/lX3Sc0IIEdx2EZ4YHI/xXLv95EvF4iy0XtQO?=
 =?us-ascii?Q?ckCbSHBLa+7YIZaYl+HK2LZjwHWLgg3z4lacZ2CX6aAiVGaeARnyrU//U8/A?=
 =?us-ascii?Q?luNedperPoZmOJOt+qzKzWKKVQuvYYyXDa9sI49ZDbnr+L1crz6TeA0BH0h/?=
 =?us-ascii?Q?4iZN0btZAXq3oGGhBr8uM9sPyDE3SCdrspyW81PEqKVLUi0s0xvxY3j9sVmf?=
 =?us-ascii?Q?cL6MJE4QKePVVUQY0WNCnsdtJRY4GuapbToLGwsHCBXMh9e/wGqSEVqq4wst?=
 =?us-ascii?Q?pmpYOsZJj8Dk/y2jPj8yMgi66Yzq+rmdnDWQ5lOlQmOanrsgzsdKpEcg9Uyt?=
 =?us-ascii?Q?yZDuV2QnHXNhBWy7XN8gEMniPhwusvUqAeC14mEt/3DoR3lecS5Jv6wmHFhn?=
 =?us-ascii?Q?RjzF8lq1CFyfcgvS7K2hUsJnAK9jKYCKe2IwECrYe5gNXivo6iS+fb9uygAh?=
 =?us-ascii?Q?uMF8WAxVWiKTNxKmjYVgOa9bbBaXOSptE8XYQ5Xwmpmffpetr8to6GpFq6EK?=
 =?us-ascii?Q?D/TrK+rNndGgCyd0XL2xwQu1P7AIfPEpJJ4fv/5A4l1vAp3864u4mfePGatC?=
 =?us-ascii?Q?AZaY96WJ70qgEJdmIq2G6EbnKjTmb6W+pCiGcinjA1Y1r8kWDogtaq/Rxn23?=
 =?us-ascii?Q?Boy2lCCUdrRS377cfaEHJD8xN5GD5Gm37D77KJ6Hm3lVed84a9ntzhSoND8/?=
 =?us-ascii?Q?c+jHeLI5UFXyQ/TcVX+YhjrC83GqLGE6wLbb80kCmHuTZojn/QPNONLZyuoA?=
 =?us-ascii?Q?TDWqu+q6K7QrFIDc6aL7fFirGX4/URxaxyrlIdBYVyPMa/UpJPN54MYxiDMO?=
 =?us-ascii?Q?Yz1MUeuORzDZBW61KD+KojiNekI/8QU3CXYGM5hpuce1h2KC/F04PZ5uTgnd?=
 =?us-ascii?Q?0AjyB1cBJxJWA0m3kVGcyCxjmfphBHX6aK2oSLGXpu7LoE6tnaGIerBtHbdB?=
 =?us-ascii?Q?EeAy23o2GAa3aPWADTYJxrTuqRkni0985zX4VcX6d9G5BHw0VH7P6QyOAyI9?=
 =?us-ascii?Q?Je9Y9CZQ9hTWQMJeF1cY6yd8mWnHYJJOvEonhlOlt3vYJ4s7MZOCsrxxdUNj?=
 =?us-ascii?Q?emQJXwgM41K6QBPhrEiS7xzRYjXm9IK+J8ZwLcPS1MtN77Jllfby2TD/IyAk?=
 =?us-ascii?Q?tVTAjVtctzKArrROXOm9n0349gn+nun9z1LIXXWm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6534.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e6dff8-0069-449a-82a3-08da68705ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 03:48:26.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Gr2QbZ5l260jwmeP/NmIxml1wJN4NsnTn57a/TzsPPeoqDABI39zcQk1xhKhdR9pTp7lkfkT5dVAa8U3gtYdl7e0H3IeySWp/2mmbM9R0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> On Thu, Jul 14, 2022 at 02:20:06PM +0000, Tung, Chien Tin wrote:
> > No one is interested in helping with Create QP issue with Mellanox
> controller?
>=20
> 1. Both Jason and I had personal issues that prevented from us to
> participate in linux-rdma ML.
Okay,, I don't know what that means but I won't dwell on it.

> 2. max_qp is set by FW. Please contact NVidia support.
I sent this issue to the mailing list because with different kernel I get d=
ifferent
number with 5.18.5 creating 1/2 of QPs as RHEL 8.5/MOFED.
If you still think this is a FW issue, I can certainly take it up with supp=
ort.

Thanks,

Chien

> > > All tests are performed using the same server, 64G memory, RHEL 8.5,
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> same
> > > ulimit setting and selinux disabled.
> > > ConnectX-4 has firmware-version: 12.28.2006 (MT_2180110032), in
> infiniband
> > > mode and  max_qp:  262144.
> > >
> > > Test 1 SW config - RHEL 8.5, MLNX_OFED_LINUX-5.5-1.0.3.2:,  max qp
> created
> > > - 261935
> > > Test 2 SW config - same as test 1 with MOFED except rdma-core library=
 is
> > > upstream c590cbd51632, max qp created - 261935 (same as test 1)
> > > Test 3 SW config - MOFED uninstalled, 5.18.5 kernel installed, rdma-c=
ore
> > > library is upstream c590cbd51632, max qp created 130863
> > >
> > > Can someone help me understand why Test 3 is half of the number?  Als=
o,
> is it
> > > possible to hit the max_qp number of 262144?
> > > Not to muddle the issue too much, I have observed similar behavior wi=
th
> > > ConnectX-6 (130763 and 261875 QPs) but don't have logs with those run=
s.
> > >
> > > Thanks,
> > >
> > > Chien
> > >
> > > I've interlaced "rdma resource" prints in the dmesg log  by pausing t=
est
> > > program in gdb with breakpoint set to ibv_create_qp.
> > >
> > > <Test 1 log>
> > > [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261933 cm_id 0 mr 0 ctx 1 sr=
q 0
> > >
> > > [  920.711591] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> > > cmd[0]: start dump
> > > [  920.711597] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [  920.711601] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [  920.711604] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [  920.711606] cmd[0]: 020: 00384800 00000015 0003ff5d 04000000
> > > [  920.711608] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [  920.711609] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [  920.711611] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [  920.711613] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [  920.711614] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [  920.711616] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [  920.711617] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> > > [  920.711619] cmd[0]: 0a0: 00000000 00000000 00000300 00000000
> > > [  920.711621] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe7c0
> > > [  920.711622] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [  920.711624] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [  920.711625] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [  920.711627] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [  920.711629] cmd[0]: 100: 00000001 00000000 00000000 00000000
> > > [  920.711630] cmd[0]: 110: 00000006 180c0000 00000005 44200000
> > >
> > > [  920.711634] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> > > cmd[0]: end dump
> > > [  920.712125] mlx5_core 0000:02:00.0: dump_command:844:(pid 0):
> cmd[0]:
> > > start dump
> > > [  920.712129] mlx5_core 0000:02:00.0: dump_command:851:(pid 0):
> cmd[0]:
> > > dump command data CREATE_QP(0x500) OUTPUT
> > > [  920.712131] cmd[0]: 000: 00000000 00000000 00040121 00000000
> > >
> > > [  920.712133] mlx5_core 0000:02:00.0: dump_command:887:(pid 0):
> cmd[0]:
> > > end dump
> > >
> > > [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261934 cm_id 0 mr 0 ctx 1 sr=
q 0
> > >
> > > [  938.006403] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> > > cmd[0]: start dump
> > > [  938.006408] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [  938.006411] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [  938.006414] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [  938.006416] cmd[0]: 020: 00384800 00000015 0003ff5e 00000000
> > > [  938.006418] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [  938.006419] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [  938.006421] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [  938.006422] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [  938.006424] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [  938.006425] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [  938.006427] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> > > [  938.006429] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> > > [  938.006431] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe800
> > > [  938.006433] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [  938.006434] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [  938.006436] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [  938.006438] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [  938.006439] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [  938.006441] cmd[0]: 110: 00000003 5ed0e000 00000003 5ed0f000
> > > [  938.006443] cmd[0]: 120: 00000006 1820a000 00000002 f1f87000
> > > [  938.006444] cmd[0]: 130: 00000002 f1fcf000 00000006 1805f000
> > > [  938.006446] cmd[0]: 140: 00000003 8efe1000 00000006 1805d000
> > > [  938.006448] cmd[0]: 150: 00000004 956b5000 00000000 00000000
> > >
> > > [  938.006451] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> > > cmd[0]: end dump
> > > [  938.006859] mlx5_core 0000:02:00.0: dump_command:844:(pid 0):
> cmd[0]:
> > > start dump
> > > [  938.006864] mlx5_core 0000:02:00.0: dump_command:851:(pid 0):
> cmd[0]:
> > > dump command data CREATE_QP(0x500) OUTPUT
> > > [  938.006866] cmd[0]: 000: 00000000 00000000 00040122 00000000
> > >
> > > [  938.006869] mlx5_core 0000:02:00.0: dump_command:887:(pid 0):
> cmd[0]:
> > > end dump
> > >
> > > [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 sr=
q 0
> > >
> > > [  952.880460] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> > > cmd[0]: start dump
> > > [  952.880465] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [  952.880468] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [  952.880471] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [  952.880473] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> > > [  952.880475] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [  952.880476] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [  952.880478] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [  952.880480] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [  952.880481] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [  952.880483] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [  952.880485] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> > > [  952.880486] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> > > [  952.880488] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe840
> > > [  952.880490] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [  952.880491] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [  952.880493] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [  952.880494] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [  952.880496] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [  952.880498] cmd[0]: 110: 00000001 d3ae6000 00000002 f1ef7000
> > > [  952.880499] cmd[0]: 120: 00000003 ae09f000 00000001 28268000
> > > [  952.880501] cmd[0]: 130: 00000003 ae007000 00000001 b4cf4000
> > > [  952.880503] cmd[0]: 140: 00000006 180fc000 00000002 2a9e6000
> > > [  952.880504] cmd[0]: 150: 00000002 f1ed0000 00000002 88295000
> > >
> > > [  952.880508] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> > > cmd[0]: end dump
> > > [  952.881353] mlx5_core 0000:02:00.0: dump_command:844:(pid 0):
> cmd[0]:
> > > start dump
> > > [  952.881358] mlx5_core 0000:02:00.0: dump_command:851:(pid 0):
> cmd[0]:
> > > dump command data CREATE_QP(0x500) OUTPUT
> > > [  952.881360] cmd[0]: 000: 05000000 0065b500 00000000 00000000
> > >
> > > [  952.881363] mlx5_core 0000:02:00.0: dump_command:887:(pid 0):
> cmd[0]:
> > > end dump
> > > [  952.881401] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 4323):
> > > CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5),
> syndrome
> > > (0x65b500)
> > > [  952.881408] infiniband mlx5_0: create_qp:3192:(pid 4323): Create Q=
P
> type
> > > 2 failed
> > >
> > > [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 sr=
q 0
> > >
> > > [  969.559023] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> > > cmd[0]: start dump
> > > [  969.559027] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [  969.559031] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [  969.559034] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [  969.559036] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> > > [  969.559037] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [  969.559039] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [  969.559041] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [  969.559042] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [  969.559044] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [  969.559045] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [  969.559047] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> > > [  969.559049] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> > > [  969.559051] cmd[0]: 0b0: 00000011 0000010d 00000005 5b6fe840
> > > [  969.559052] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [  969.559054] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [  969.559055] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [  969.559057] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [  969.559058] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [  969.559060] cmd[0]: 110: 00000001 d3ae6000 00000002 f1ef7000
> > > [  969.559062] cmd[0]: 120: 00000003 ae09f000 00000001 28268000
> > > [  969.559063] cmd[0]: 130: 00000003 ae007000 00000001 b4cf4000
> > > [  969.559065] cmd[0]: 140: 00000006 180fc000 00000002 2a9e6000
> > > [  969.559067] cmd[0]: 150: 00000002 f1ed0000 00000001 e54e4000
> > >
> > > [  969.559070] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> > > cmd[0]: end dump
> > > [  969.559508] mlx5_core 0000:02:00.0: dump_command:844:(pid 0):
> cmd[0]:
> > > start dump
> > > [  969.559513] mlx5_core 0000:02:00.0: dump_command:851:(pid 0):
> cmd[0]:
> > > dump command data CREATE_QP(0x500) OUTPUT
> > > [  969.559517] cmd[0]: 000: 05000000 0065b500 00000000 00000000
> > >
> > > [  969.559520] mlx5_core 0000:02:00.0: dump_command:887:(pid 0):
> cmd[0]:
> > > end dump
> > > [  969.559553] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 4323):
> > > CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5),
> syndrome
> > > (0x65b500)
> > > [  969.559562] infiniband mlx5_0: create_qp:3192:(pid 4323): Create Q=
P
> type
> > > 2 failed
> > >
> > >
> > > <Test 2 log>
> > > [rdma resource]0: mlx5_0: pd 3 cq 27 qp 261934 cm_id 0 mr 0 ctx 1 srq=
 0
> > >
> > > [ 3543.619746] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> > > cmd[0]: start dump
> > > [ 3543.619753] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [ 3543.619757] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [ 3543.619759] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [ 3543.619762] cmd[0]: 020: 00384800 00000015 0003ff5e 00000000
> > > [ 3543.619763] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [ 3543.619765] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [ 3543.619796] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [ 3543.619798] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [ 3543.619798] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [ 3543.619799] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [ 3543.619800] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> > > [ 3543.619800] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> > > [ 3543.619801] cmd[0]: 0b0: 00000011 0000010d 00000005 22861800
> > > [ 3543.619801] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [ 3543.619802] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [ 3543.619803] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [ 3543.619803] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [ 3543.619804] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [ 3543.619804] cmd[0]: 110: 00000004 32f72000 00000005 22a11000
> > > [ 3543.619805] cmd[0]: 120: 00000005 229f6000 00000005 22a38000
> > > [ 3543.619806] cmd[0]: 130: 00000001 7244a000 00000002 466aa000
> > > [ 3543.619806] cmd[0]: 140: 00000005 22a19000 00000002 8c046000
> > > [ 3543.619807] cmd[0]: 150: 00000005 8ac7b000 00000002 2c14a000
> > >
> > > [ 3543.619809] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> > > cmd[0]: end dump
> > > [ 3543.620284] mlx5_core 0000:02:00.0: dump_command:844:(pid 0):
> cmd[0]:
> > > start dump
> > > [ 3543.620291] mlx5_core 0000:02:00.0: dump_command:851:(pid 0):
> cmd[0]:
> > > dump command data CREATE_QP(0x500) OUTPUT
> > > [ 3543.620295] cmd[0]: 000: 00000000 00000000 00040122 00000000
> > >
> > > [ 3543.620299] mlx5_core 0000:02:00.0: dump_command:887:(pid 0):
> cmd[0]:
> > > end dump
> > >
> > > [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 sr=
q 0
> > >
> > > [ 3560.087852] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> > > cmd[0]: start dump
> > > [ 3560.087857] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [ 3560.087860] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [ 3560.087863] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [ 3560.087865] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> > > [ 3560.087867] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [ 3560.087869] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [ 3560.087886] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [ 3560.087887] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [ 3560.087887] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [ 3560.087888] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [ 3560.087888] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> > > [ 3560.087889] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> > > [ 3560.087890] cmd[0]: 0b0: 00000011 0000010d 00000005 22861840
> > > [ 3560.087890] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [ 3560.087891] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [ 3560.087891] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [ 3560.087892] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [ 3560.087892] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [ 3560.087893] cmd[0]: 110: 00000005 229e7000 00000004 65ddb000
> > > [ 3560.087894] cmd[0]: 120: 00000005 22a01000 00000005 22a0f000
> > > [ 3560.087894] cmd[0]: 130: 00000005 8ac73000 00000003 a6d42000
> > > [ 3560.087895] cmd[0]: 140: 00000004 05f58000 00000005 22a10000
> > > [ 3560.087896] cmd[0]: 150: 00000005 22a4c000 00000001 fc0da000
> > >
> > > [ 3560.087897] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> > > cmd[0]: end dump
> > > [ 3560.088787] mlx5_core 0000:02:00.0: dump_command:844:(pid 0):
> cmd[0]:
> > > start dump
> > > [ 3560.088793] mlx5_core 0000:02:00.0: dump_command:851:(pid 0):
> cmd[0]:
> > > dump command data CREATE_QP(0x500) OUTPUT
> > > [ 3560.088797] cmd[0]: 000: 05000000 0065b500 00000000 00000000
> > >
> > > [ 3560.088801] mlx5_core 0000:02:00.0: dump_command:887:(pid 0):
> cmd[0]:
> > > end dump
> > > [ 3560.088827] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 9217):
> > > CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5),
> syndrome
> > > (0x65b500)
> > > [ 3560.088837] infiniband mlx5_0: create_qp:3192:(pid 9217): Create Q=
P
> type
> > > 2 failed
> > >
> > > [rdma resource] 0: mlx5_0: pd 3 cq 27 qp 261935 cm_id 0 mr 0 ctx 1 sr=
q 0
> > >
> > > [ 3577.184180] mlx5_core 0000:02:00.0: dump_command:844:(pid 1915):
> > > cmd[0]: start dump
> > > [ 3577.184185] mlx5_core 0000:02:00.0: dump_command:851:(pid 1915):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [ 3577.184189] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [ 3577.184191] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [ 3577.184194] cmd[0]: 020: 00384800 00000016 0003ff5f 00000000
> > > [ 3577.184195] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [ 3577.184197] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [ 3577.184199] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [ 3577.184200] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [ 3577.184202] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [ 3577.184204] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [ 3577.184205] cmd[0]: 090: 00000000 0000010d 00000000 00000000
> > > [ 3577.184207] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> > > [ 3577.184209] cmd[0]: 0b0: 00000011 0000010d 00000005 22861840
> > > [ 3577.184210] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [ 3577.184212] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [ 3577.184214] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [ 3577.184215] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [ 3577.184217] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [ 3577.184219] cmd[0]: 110: 00000005 229e7000 00000004 65ddb000
> > > [ 3577.184221] cmd[0]: 120: 00000005 22a01000 00000005 22a0f000
> > > [ 3577.184222] cmd[0]: 130: 00000005 8ac73000 00000003 a6d42000
> > > [ 3577.184224] cmd[0]: 140: 00000004 05f58000 00000005 22a10000
> > > [ 3577.184226] cmd[0]: 150: 00000005 22a4c000 00000000 00000000
> > >
> > > [ 3577.184229] mlx5_core 0000:02:00.0: dump_command:887:(pid 1915):
> > > cmd[0]: end dump
> > > [ 3577.184619] mlx5_core 0000:02:00.0: dump_command:844:(pid 0):
> cmd[0]:
> > > start dump
> > > [ 3577.184627] mlx5_core 0000:02:00.0: dump_command:851:(pid 0):
> cmd[0]:
> > > dump command data CREATE_QP(0x500) OUTPUT
> > > [ 3577.184630] cmd[0]: 000: 05000000 0065b500 00000000 00000000
> > >
> > > [ 3577.184635] mlx5_core 0000:02:00.0: dump_command:887:(pid 0):
> cmd[0]:
> > > end dump
> > > [ 3577.184665] mlx5_core 0000:02:00.0: mlx5_cmd_check:827:(pid 9217):
> > > CREATE_QP(0x500) op_mod(0x0) failed, status bad resource(0x5),
> syndrome
> > > (0x65b500)
> > > [ 3577.184675] infiniband mlx5_0: create_qp:3192:(pid 9217): Create Q=
P
> type
> > > 2 failed
> > >
> > >
> > >
> > > <Test 3 log>
> > > [rdma resource]0: mlx5_0: pd 5 cq 5 qp 130861 cm_id 0 mr 0 ctx 1 srq =
2
> > >
> > > [354817.776532] mlx5_core 0000:02:00.0: dump_command:852:(pid
> 103730):
> > > cmd[0]: start dump
> > > [354817.776560] mlx5_core 0000:02:00.0: dump_command:859:(pid
> 103730):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [354817.776583] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [354817.776597] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [354817.776611] cmd[0]: 020: 00384800 00000017 0001ff49 03000000
> > > [354817.776623] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [354817.776955] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [354817.777188] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [354817.777446] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [354817.777701] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [354817.777953] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [354817.778150] cmd[0]: 090: 00000000 00000115 00000000 00000000
> > > [354817.778371] cmd[0]: 0a0: 00000000 00000000 00000800 00000000
> > > [354817.778590] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35ac0
> > > [354817.778824] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [354817.779006] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [354817.779179] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [354817.779377] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [354817.779571] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [354817.779766] cmd[0]: 110: 0000000a 67fb0000 0000000a 67e80000
> > >
> > > [354817.780058] mlx5_core 0000:02:00.0: dump_command:895:(pid
> 103730):
> > > cmd[0]: end dump
> > > [354817.780623] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> > > cmd[0]: start dump
> > > [354817.781147] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> > > cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> > > [354817.781478] cmd[0]: 000: 00000000 00000000 00023be6 00000000
> > >
> > > [354817.781893] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> > > cmd[0]: end dump
> > >
> > > [rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130862 cm_id 0 mr 0 ctx 1 srq=
 2
> > >
> > > [354834.277537] mlx5_core 0000:02:00.0: dump_command:852:(pid
> 103730):
> > > cmd[0]: start dump
> > > [354834.277755] mlx5_core 0000:02:00.0: dump_command:859:(pid
> 103730):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [354834.277930] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [354834.278108] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [354834.278288] cmd[0]: 020: 00384800 00000017 0001ff4a 03000000
> > > [354834.278499] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [354834.278710] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [354834.278930] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [354834.279102] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [354834.279274] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [354834.279454] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [354834.279685] cmd[0]: 090: 00000000 00000115 00000000 00000000
> > > [354834.279886] cmd[0]: 0a0: 00000000 00000000 00000000 00000000
> > > [354834.280056] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b00
> > > [354834.280226] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [354834.280419] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [354834.280612] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [354834.280819] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [354834.280974] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [354834.281124] cmd[0]: 110: 0000000a 67f98000 0000000a 5f658000
> > >
> > > [354834.281421] mlx5_core 0000:02:00.0: dump_command:895:(pid
> 103730):
> > > cmd[0]: end dump
> > > [354834.282011] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> > > cmd[0]: start dump
> > > [354834.282327] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> > > cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> > > [354834.282674] cmd[0]: 000: 00000000 00000000 00023be7 00000000
> > >
> > > [354834.283275] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> > > cmd[0]: end dump
> > >
> > > [rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130863 cm_id 0 mr 0 ctx 1 srq=
 2
> > >
> > > [354857.088810] mlx5_core 0000:02:00.0: dump_command:852:(pid
> 103730):
> > > cmd[0]: start dump
> > > [354857.089037] mlx5_core 0000:02:00.0: dump_command:859:(pid
> 103730):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [354857.089216] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [354857.089392] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [354857.089605] cmd[0]: 020: 00384800 00000018 0001ff4b 03000000
> > > [354857.089817] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [354857.090043] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [354857.090221] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [354857.090395] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [354857.090576] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [354857.090809] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [354857.091029] cmd[0]: 090: 00000000 00000115 00000000 00000000
> > > [354857.091206] cmd[0]: 0a0: 00000000 00000000 00000600 00000000
> > > [354857.091382] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b40
> > > [354857.091584] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [354857.091782] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [354857.091993] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [354857.092155] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [354857.092310] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [354857.092469] cmd[0]: 110: 0000000a 5f658000 0000000a 5f788000
> > >
> > > [354857.092829] mlx5_core 0000:02:00.0: dump_command:895:(pid
> 103730):
> > > cmd[0]: end dump
> > > [354857.093900] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> > > cmd[0]: start dump
> > > [354857.094313] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> > > cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> > > [354857.094515] cmd[0]: 000: 05000000 0065b500 00000000 00000000
> > >
> > > [354857.094871] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> > > cmd[0]: end dump
> > > [354857.095093] mlx5_core 0000:02:00.0: cmd_status_print:808:(pid
> 110379):
> > > CREATE_QP(0x500) op_mod(0x0) uid(2) failed, status bad resource(0x5),
> > > syndrome (0x65b500), err(-22)
> > > [354857.095923] infiniband mlx5_0: create_qp:3035:(pid 110379): Creat=
e
> QP
> > > type 2 failed
> > >
> > > [rdma resource] 0: mlx5_0: pd 5 cq 5 qp 130863 cm_id 0 mr 0 ctx 1 srq=
 2
> > >
> > > [354893.848503] mlx5_core 0000:02:00.0: dump_command:852:(pid
> 103730):
> > > cmd[0]: start dump
> > > [354893.848747] mlx5_core 0000:02:00.0: dump_command:859:(pid
> 103730):
> > > cmd[0]: dump command data CREATE_QP(0x500) INPUT
> > > [354893.848949] cmd[0]: 000: 05000002 00000000 00000000 00000000
> > > [354893.849151] cmd[0]: 010: 00000000 00000000 00001800 00000018
> > > [354893.849351] cmd[0]: 020: 00384800 00000018 0001ff4b 03000000
> > > [354893.849562] cmd[0]: 030: 00000000 00000000 00000000 00000000
> > > [354893.849815] cmd[0]: 040: 00000000 00000000 00000000 00000000
> > > [354893.850059] cmd[0]: 050: 00000000 00000000 00000000 00000000
> > > [354893.850258] cmd[0]: 060: 00000000 00000000 00000000 00000000
> > > [354893.850459] cmd[0]: 070: 00000000 00000000 00000000 00000000
> > > [354893.850668] cmd[0]: 080: 00000000 00000000 00000000 00000000
> > > [354893.850939] cmd[0]: 090: 00000000 00000115 00000000 00000000
> > > [354893.851151] cmd[0]: 0a0: 00000000 00000000 00000600 00000000
> > > [354893.851340] cmd[0]: 0b0: 00000011 00000115 0000000a 67c35b40
> > > [354893.851526] cmd[0]: 0c0: 00000000 00000101 00000000 00000000
> > > [354893.851740] cmd[0]: 0d0: 00000000 00000000 00000000 00000001
> > > [354893.851948] cmd[0]: 0e0: 00000000 00000000 00000000 00000000
> > > [354893.852165] cmd[0]: 0f0: 00000000 00000000 00000000 00000000
> > > [354893.852339] cmd[0]: 100: 00000000 00000000 00000000 00000000
> > > [354893.852505] cmd[0]: 110: 0000000a 5f658000 0000000a 5f788000
> > >
> > > [354893.852893] mlx5_core 0000:02:00.0: dump_command:895:(pid
> 103730):
> > > cmd[0]: end dump
> > > [354893.853565] mlx5_core 0000:02:00.0: dump_command:852:(pid 0):
> > > cmd[0]: start dump
> > > [354893.854324] mlx5_core 0000:02:00.0: dump_command:859:(pid 0):
> > > cmd[0]: dump command data CREATE_QP(0x500) OUTPUT
> > > [354893.854683] cmd[0]: 000: 05000000 0065b500 00000000 00000000
> > >
> > > [354893.855182] mlx5_core 0000:02:00.0: dump_command:895:(pid 0):
> > > cmd[0]: end dump
> > > [354893.855474] mlx5_core 0000:02:00.0: cmd_status_print:808:(pid
> 110379):
> > > CREATE_QP(0x500) op_mod(0x0) uid(2) failed, status bad resource(0x5),
> > > syndrome (0x65b500), err(-22)
> > > [354893.856328] infiniband mlx5_0: create_qp:3035:(pid 110379): Creat=
e
> QP
> > > type 2 failed
> >
