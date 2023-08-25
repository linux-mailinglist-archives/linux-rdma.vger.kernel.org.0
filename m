Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA2787CCE
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Aug 2023 03:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjHYBLv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjHYBLm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 21:11:42 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECC19BB;
        Thu, 24 Aug 2023 18:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692925900; x=1724461900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sDlOqNDHfeMrHnG/c7k/IyOsFYvz57BznSY8jSbB8Cs=;
  b=iUh2V+tblK1wKwjper9PSu7XeX+gAcDSIoDBXKhieSDLV4HGXupOIyZN
   nqKpOHwKGgyvMEiP0kRZzGZAIAlVKfKwUOmpbZbEFxBBPhF0f7pCU1dCq
   sv6AF3ILy+9WZk8tjzscuYcgNolTeC06n2TP2CNYn8ZeD2+5kC0Bhy9BE
   AIXHsK3C3ndjajPnCxf+DYU6FrSqwhMdjqJ+kuO0mjZ+ErjbchemJP1I2
   ks5KOegELUl5daVAhioikf+vJGO6g+Jlw3VdDAzeqiQVu2xZQK2BKuuH/
   RnFJ1aVx9A+eeQlfzhR2vpvBmhhNKH55NTcpAvQ2BUI4xXIMVNFn7w1m4
   A==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688400000"; 
   d="scan'208";a="354055857"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2023 09:11:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3fwvhshRpQBFoCAfIn80OXoCkBilPwWV/B/HWyIQpCPY1wjLji+UJze62/6OCzahhGKRCtfLLqI6EXJlUALuQIDoxKqzRUGQGRK0CXZuMWvjHJn/FR8X+oo1yNDAFApYlxhpYGsD+x6QkYfQNJr7W4QuEIcYcv/wQORjcLcwJoM+VZD4JMtToIVktAhb68ecAaxRIxGmpdHDAPq8l6DeE3eFAXJssixAVOK7vS0wi9Ama4LpfZRxnMKRJb4olslXAiXTgOAqAAx8xhqWIVnloMwlaOy3vJYUesQe7aA+ggbyUYI0HLcg3T/7Pgi2TB6VujqsH9vHzy6qhoyU3dkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDlOqNDHfeMrHnG/c7k/IyOsFYvz57BznSY8jSbB8Cs=;
 b=brPzfbX82NnVruFHa2FBunO4lm4Ur6dbAj78SYSYdbrhkCAaY7q4nwz5nBPJ3fXQqcLjmgOFxA9s72ToVDMm8fJYjrvjak0jLaWizG36XPzhEUnCQZaq/GubDoicVKe6EE7ocbYAGaVmrbVE7I7NPGHrX+JyyZuXMvvq6ioRGh0DqkK6AraLK+5mNd2kwngyal2n9mXZQsFC4/vtc+sVmFWp/asO6a9sx7tdDzCKvyq3VFKmY0m6I4zbZGSKbREpq7tXBMmDrH1pxRsxoB0QVj4LQiGKjPzi7sTZs2cIy3hgVUiuWPHQzlX3Us5jt0trri7vlm2jEsWFTelLuYM/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDlOqNDHfeMrHnG/c7k/IyOsFYvz57BznSY8jSbB8Cs=;
 b=vqkvaXh60wWlbyhRcHax+KOKQneS+9+3/mlTHloVtTNq62ZZZsZwmaqflxWRTbpak7In+DWfoSWbSg3ZX9x9zC0nK4r5Ho86WeY9vyYW4QH0+rjCPgnQFu2sVMgH+See0o1wKGYg70isqp+iRUmFTgTsHp/EVMGv21ROH5FU/oI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7430.namprd04.prod.outlook.com (2603:10b6:510:18::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17; Fri, 25 Aug 2023 01:11:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.017; Fri, 25 Aug 2023
 01:11:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOA
Date:   Fri, 25 Aug 2023 01:11:37 +0000
Message-ID: <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
In-Reply-To: <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7430:EE_
x-ms-office365-filtering-correlation-id: 7be6f9da-5538-4da3-4bc9-08dba5083b89
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQtqYAcXVkXuSVdNc78RYbX9+QmHYR4iVRKa9XSlBPNuTMd02CnBudm9EVepFa1TkXInkBlZ7PEZOxBTvyyeDTYQOG7zoXS2yj8e+zSnPQSh0phqwK5etqhbs/OoyH0UtGwc0EEC9Jn8EnRtW9tB9mtoWSlXEkTIGBntp42RpsGHvW+tjaDKa86U22J/camlJSx4l2+00hbSGeCKAMKiQeJXOJ362nySRSRTmXa4l1XK8G4lZ//kiTXw1B+l3dmxrBfCrSfu/1qv7/nutZmajp+xUu+LPbdv4gthuk7zUFozNxDHE1JnqN90pgF3N0tx5Dp9/4esUAkOCw041Vv515gaAGC9qvdUPO7jKoYhlOlCTN+TX2nPAtISiCHwJ+X08GtZjvthoQJ3O8hnT4XH2997nT/1Av8WOdfR2uYthjoTQIchMOMHWHxE+bPFeuF+6roGBls9KMabAq59qr8zKGFZQlxuLH2etJj7Qs9pu1FVMHW13NdfPnAvf7GaSK4K5o7pIOW9Xfxn0swn+rAmJMYLo/eNhhA9qvvN8LYsbZy6FtL56TUtj3ipwmWnfvPHr5BEQsDzlAN+FtuCDpPpBQgsjjqT/IVJKUV8zou8Ft+UI/iqSQCs4dFSqR2uhG4i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(33716001)(54906003)(66946007)(76116006)(66556008)(316002)(6916009)(82960400001)(122000001)(478600001)(91956017)(26005)(38070700005)(38100700002)(71200400001)(41300700001)(53546011)(6506007)(6486002)(86362001)(2906002)(6512007)(9686003)(4326008)(8676002)(8936002)(83380400001)(5660300002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aej7y0/r8Xk9K68TL4aMXebXYI7Cvc+Ev0wREPwd82PEvAYfrWfCZwzNwdZY?=
 =?us-ascii?Q?YdE3mYrrBbfliws4+Im2be5sioVV0JqJVwjolgCl0mUR6WFmeAREKKEqWjvp?=
 =?us-ascii?Q?/T2uZ3Of8IzTabfcnOkav09/gARrz4rdYg8WkPzT3uH+YbBl86CZGs9fz9BF?=
 =?us-ascii?Q?hn6JpO0GpxSXS8/4W5oTKLmTlrrtEp3kRum7PUNrI5F3FzTdRbNclGqIPfvZ?=
 =?us-ascii?Q?a1ACgCqlBZ1MAPOG04XVN3F3hh8bwJENsbD8JsLL49sJt/o9iV1KYFP9r6Ow?=
 =?us-ascii?Q?RJLU/DRlnh0DGh3xmhWV8fdktb2Y/3ZsiDyuGzV9avBMhgSonBOs+sXVsvzK?=
 =?us-ascii?Q?yZyod3EsY0eWjdNwep+pekJCEH1U5NipMCzxI9W5bAWawaMpusnYYTb/ISxm?=
 =?us-ascii?Q?Q2CEZ3wo+sFojXVh2rHDlkJ5p8zR7eQ6pDy++fztkJ92RVlbjFCnKbRWZtF3?=
 =?us-ascii?Q?/wcM9POG32ei1o1sGmzJsSs4K+tk6AD+t4M9Hud5GhUYRSh2EGJMa4XnKuSs?=
 =?us-ascii?Q?CR3m0N+Vg9PfEioMgZjnyA+uEAd3ClEu+MVuFyDTRb3Xd01b5iF0aT0zHdXx?=
 =?us-ascii?Q?F968izKktp3KA3cIYeTDqxZp8EtKdlkzJlUXaS+fVdsdraHvDMSLXNHjoE2z?=
 =?us-ascii?Q?8ImN/FgWR6VCSXMpJhZFDmo1n0zihEilZKI+4B5vKSZIYUDtXwfWsBv7IlrH?=
 =?us-ascii?Q?W3x9SRcxua889DKkBVjz/JtZl77B1pWQ9Jg9PqsP5CNSJzKHEi1FNLSLCPtr?=
 =?us-ascii?Q?H5s+9iBOL5cvDW9sDp13CNoLkgwaAFCOpd5vXdNJ6V5Dwoki9n4TFi/ucIhD?=
 =?us-ascii?Q?QrpuL1GXwd+jpfu7SeGqpGuXXOi67YjwKGUqbOMoAaaYGu8/SwIOAEr0DP/m?=
 =?us-ascii?Q?4dyTu3JAzFhAgLswPBgM33J22C3zy8d3jCaxejP1qwv1w/WM6xEtI6S+d4OS?=
 =?us-ascii?Q?hznPT6rC67+lNHyhh4Sudk73724KQhUk4UyDIjon6Kr0xKKjEDUYGZrZK+5t?=
 =?us-ascii?Q?nKrfv/QmhdZ71qhuqrcdwHx01VlsOSd1RT+bEhw8Oo7PKMj470/0iWw7f5NL?=
 =?us-ascii?Q?ZrtZgIUJp3HVYZt4F+DOB78KTn8PIvdwF83ELu/kxqQV+hmX/ra8v/ABfrZ3?=
 =?us-ascii?Q?QoTox28LcxvNxljhGRKcafNo5Zx+UjD5rzBNpubw8IEvPbaNOPy7EkqaYPYX?=
 =?us-ascii?Q?MYGYObNad0CsOEdp+H6hKeiCBqgA5o39iFjH3fEVZdbF5Ccy3K76udPHRqnr?=
 =?us-ascii?Q?5Pfsp8+RAugujK3pM9Najl16DmqbSfFTxflkdSt39ham3EYbZ8LkDbg0tPkw?=
 =?us-ascii?Q?3h3XmRd2hvByecKgsMh9QvD5PsQ9mVUgYjFaie0xvgTxOoC0D2LgF4etydub?=
 =?us-ascii?Q?efGht2/GlqJ8L82dqsSFz2ZOalMfRtqUbudbjFpHm1QTLKR/HSO1RxqWObMe?=
 =?us-ascii?Q?aXZA9nX+sHOzAWZy1yUmRrQNqDuFcYcLp+k3HPJkeKDdYztN5GQ8TkVhNXT8?=
 =?us-ascii?Q?09bMdeclc+8b04qtLM6fjT86dY6pL+E+B9aLGIfyb863n7qFrh3dZtqS31MP?=
 =?us-ascii?Q?EOvmCF2ZKOIof2ZxJeZEfj/18NWgZEHnNaRvpU0+OfE0PDUHWyJ0qqVR/HTA?=
 =?us-ascii?Q?ExEGCw3ASEExqy3HxvRXL6w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0527A2BA91B814ABB017D477A07C81D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EKZHVPHvqzxGWKbGIUta2lXhsIj0tDfIMv6QfRokF1PFiqdojAzOa6JojtvisTtRxQLZ6QiQDHAhtLCMvlnD1c4penl/GV4x4tpHRXvTaCOuL1g8lHBx2aCaGESc1KBP2EqeuTO2jOrkc4KphXF27jqXEhmRJeQRdUWC+qyY3mFeJXfScNjfKZBZQMgi4HbQCmlJ9MSE5Wsd+F90cELNN2DTEiU07lJl5EXysUqITu7RPQYmgK6T5EA1dbjMu3WRx7sCtsIPbwtlT2aocuMdwrvClvpho1RuPemYqfZkCSy8WlMYe1qeIw4iKWqRDuEprqbnz1wttZOWqTqAx4q/ZvtxfG56+CorpCeBkCUpcVnOMJ4/IylB5Ku6RgjOqO7JKIDeIVsDjB75owGbg3d+3ZOeMbBny26Z/bdRKyLClQp/3GRhjNPVJumqjya0D6dpa4KKuVQ5vfxNNe1gKo0M9c/PkX0wbJUosbZkvzXY1lttDpB37IIkPqSEWFZ4Ip8PCUHqCi2seahC+Wg+iQ5WnzNapsGCyxjm9It+3HWj/vByrVaMUWYBtx4dKRdeK1EyjKvGRU6P3IbTa+5jqm3cSgyCphI6PTzw/8FuIzVLLbJ51p9WJ/+eOybT1Pvj62dkRFvsT7vcaBt8IP/2xs63CZxa71hpLQsroUEejsiFJ4Yhlp6ovaC6cqxslgV9xENxWjuT8POqOy9iqHEvdJcKF9qw0upAsjgD704iheSGTM8zGyHT/9CJH9d/Fq9FHYHLo9suaBKt7VEFTBQnd+x6ic8vzIqelKcnGGBG+xNAMt6IYERU85g/OQOd9Ao8ec6ktqUNsxqn0RJ2p++j1f6bEg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be6f9da-5538-4da3-4bc9-08dba5083b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 01:11:37.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYIrGNuZirgLoXiw7o4caxGmqbMv71ZYI12sxorkHot3vDDy8on/x0bTr/NTWVv2ae6KWN6JR4qvvADviCd1dqaBkzYny8l70TBle+wRH04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Aug 22, 2023 / 08:20, Bart Van Assche wrote:
> On 8/22/23 03:18, Shinichiro Kawasaki wrote:
> > CC+: Bart,
> >=20
> > On Aug 21, 2023 / 20:46, Bob Pearson wrote:
> > [...]
> > > Shinichiro,
> >=20
> > Hello Bob, thanks for the response.
> >=20
> > >=20
> > > I have been aware for a long time that there is a problem with blktes=
ts/srp. I see hangs in
> > > 002 and 011 fairly often.
> >=20
> > I repeated the test case srp/011, and observed it hangs. This hang at s=
rp/011
> > also can be recreated in stable manner. I reverted the commit 9b4b7c1f9=
f54
> > then observed the srp/011 hang disappeared. So, I guess these two hangs=
 have
> > same root cause.
> >=20
> > > I have not been able to figure out the root cause but suspect that
> > > there is a timing issue in the srp drivers which cannot handle the sl=
owness of the software
> > > RoCE implemtation. If you can give me any clues about what you are se=
eing I am happy to help
> > > try to figure this out.
> >=20
> > Thanks for sharing your thoughts. I myself do not have srp driver knowl=
edge, and
> > not sure what clue I should provide. If you have any idea of the action=
 I can
> > take, please let me know.
>=20
> Hi Shinichiro and Bob,
>=20
> When I initially developed the SRP tests these were working reliably in
> combination with the rdma_rxe driver. Since 2017 I frequently see issues =
when
> running the SRP tests on top of the rdma_rxe driver, issues that I do not=
 see
> if I run the SRP tests on top of the soft-iWARP driver (siw). How about
> changing the default for the SRP tests from rdma_rxe to siw and to let th=
e
> RDMA community resolve the rdma_rxe issues?

If it takes time to resolve the issues, it sounds a good idea to make siw d=
river
default, since it will make the hangs less painful for blktests users. Anot=
her
idea to reduce the pain is to improve srp/002 and srp/011 to detect the han=
gs
and report them as failures.

Having said that, some discussion started on this thread for resolution
(thanks!) I would wait for a while and see how long it will take for soluti=
on,
and if the actions on blktests side are valuable or not.=
