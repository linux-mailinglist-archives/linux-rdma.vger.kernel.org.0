Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0F56604B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 02:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiGEAsR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGEAsQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 20:48:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E20DF8D;
        Mon,  4 Jul 2022 17:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656982095; x=1688518095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lEyz/pojfObJOHHLNplLDJTVCsb9c9oC+vrCLEklQZI=;
  b=N9h5yvIrY1+jcwF6ccp1be1M3tgvk5NIK20xkMFGfKGoqbHak6EofH6a
   FNgMOGELwPmx3M5S+ksRGffXtsiH6A35flwwZI7q06/SWzLEMSGTH82p4
   iXkp6SivJf/3ixqEcamTwX5QepTRs9cWZL5TP0tQkcvLdx5+ZHXeMnAxH
   MntzNzLUYs0X2m+uDIbqL0EjCCTdzJdoZ1VlNBRsiQXRaIrCwAjdEZUS8
   Uh3+sL3gjopLiFIenCdJCdqN73MpeNzSCxibVMTWJr6KoLtgpkjfTnH5g
   FHsYaDLqwFQ9BUXTTVbskeYoKilaYC47mQqnUVCmpTnR+Pr37GauK1nZU
   g==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="309121983"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 08:48:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmY5mZyArbm7pHZEm+TrJvOkYBgBvJahgj0UU23lhIllofQDUfxkGOTwaasw3iAJPTnqCie99WzhZN7mDoErxWZzgrolz+bxtGJ5pi8QZ5Ey2YTBHWYFjZcY5wDQAPkShbvvF0aHsvN/+4M/TgqFZkFFwlgvB9JY8MN/0rh/Cr9ItExYZuhHW7NUom+8tVFiFfr8jH8ujRnuL6hT3nGC4N6RfLwIRyWqAxeYYAHzS0ySFO5cJbtbQFvX7LbdVh/Q/Jb2uFPokpdTU/E7bOGfDhJ+sI0zW82+lF3A1B67ykopBSnkGpcVOFAUrNpCgfl9oRzYvMrIJBisJoq3HT8hHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1nDpyQoWq2zdPpZPlypWE7QuCy/iOKtrCDxH/lqne4=;
 b=dQB0LWifeK9cWhFZwH22i8ZuRwnK49pjNKyrcanIGsbK+4kLoXHieKIlKWryWRVYkLYX/rtdGPEIJKuT8q5kT/FqlOBSetZwdCC7LuZ7h0pWXLcAUThXuCKUh0UwO2IKPygopTx8uIGQOzZTqZhgOypE0plLdx9hZFs+9cZBI9JV5RauwZs35nzQJQL/3p7XPqvekkV0BYf1zMCgAKuUgTwEZIHn3UT3axBcfBuEmmQAy0tTl62llIhhpTyaQhZUyd1Q+J58A6UghwEulvEMEefuIQ8IE9+yG/vze9Ief9Y+0vAcbSdKH25xO2lY8ghCIqx5TZmcDssrBYKWk/I8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1nDpyQoWq2zdPpZPlypWE7QuCy/iOKtrCDxH/lqne4=;
 b=PV3HAYpXc20q5XrzZZ5Ef/1d46aUdugr2P2YwvP0i5SV5JEWC8sJFMXRF4zUJtlcPcqAVHMESCtawh0eo79o/CLHauaHqLPuAg/POz6AcZwr0/Hd4SSWuKViOvf6L4rrS+1cCAIpRimuJ94xAlN/am1zi44kD0gSa0rLxvOcPq8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN6PR04MB0629.namprd04.prod.outlook.com (2603:10b6:404:cd::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.17; Tue, 5 Jul 2022 00:48:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 00:48:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Thread-Topic: [bug report from blktests nvme/032] WARNING: possible circular
 locking dependency detected
Thread-Index: AQHYkAjmw6XcqQ1UdE+2h2wJPET+mA==
Date:   Tue, 5 Jul 2022 00:48:10 +0000
Message-ID: <20220705004809.6guf43xwjpq33smo@shindev>
References: <4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com>
 <YrqauCHdcieF5+C7@kroah.com> <YrqbNfF9uYMSwZ4V@infradead.org>
 <Yrqb47ozk5IWTnWp@kroah.com> <YrqdUpLVbLF7WNGs@infradead.org>
In-Reply-To: <YrqdUpLVbLF7WNGs@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9f200a6-6eb2-4649-2a54-08da5e2008ed
x-ms-traffictypediagnostic: BN6PR04MB0629:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDRXllS8DgqB2tVo/KLfRtCVOgYywla6xoUF2VBx2FW0gdKMM5EtRsn4xxodvEK9jPMzOjCeXpfDLJSWSQITfo++2gFNPvSlOt/nuJPiG6sCr6Rvc4BJtf/XQvqdVeZkTk0J6JvPn5Zf9xKnCF0MYIpq1lasdTPYMy5eBk0FuONQ+my9zHzvGmKpKlmDGLSLG3vOGPwD8i3Ib+ylQAy1SUhVcLk2MOjFSd9X/ri1ft1BcsC5RoMFckj5RIpKrYDDsNqx5kim6dTCct1TtOvI5t5TnEQ7ISroCM59cv6IuJygBKtkl/Wqc3Oq1M1GwY056KeC4hX5R32tsCSnOPoSwHTfv2m3D8FzQ3Hu0W2sSWVAV9iw1C+Ru6OW5OiUy78of7YdXmRh/dLljeAFkSWs6eFllUrEVPd0wb6DQbUOtC8GPRO7YdZnutfmpgj2AfbYrRKMwWIPnt9A0iQ6/YHw3SoLjddXlVO8Eszv6ZPCCsnlIM5l5KDThMvB98aRFSIbB61leSdkCsYV3W1gSvyoMrS1tVoM5u4/ctMNbb/Vx1cWQlbWMTXJIAsPUjSYn3nw7qI4qBmuKmFC2l249CGDwMGwzLyOTYqDjqID+AKhq6xFDyQm7t4ky/QAiDe1x7JWYPM3atPk6T3PEK+tgLEMdUCTrX5FTx4eshtnlQd530i4xskTX9EVdFVK3FYPm4grXulIVG/2x5W2+//o4UnTT0vhxPmI8cM4oIQjUpUdg8B5P94Y92vDxt65nwxBA6G2StUcQuqVVsG4NHBzpeBo4ZESjCRvnnRiM3WYIgltg2TLIEeHHSAI8ee/ygCglahzpWShLTUW5BD1W8JbrYuWtpGvdlPligI14PP7bu1sPDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(186003)(26005)(71200400001)(1076003)(5660300002)(4744005)(44832011)(9686003)(6512007)(7416002)(122000001)(64756008)(66446008)(54906003)(478600001)(316002)(66476007)(66556008)(66946007)(4326008)(91956017)(76116006)(6916009)(86362001)(8936002)(41300700001)(33716001)(82960400001)(38100700002)(966005)(38070700005)(6506007)(6486002)(2906002)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q8W9Gt67qF7z9AUnr53kxlCnQCEskiMV3xwd3bmbe651s3C0V0OsDR29s/68?=
 =?us-ascii?Q?Plj21yx4MmF97ldnmkfeS5H6tIVP+bvCLcCFTuMkbsMrclSVXtjuKmkLvKzC?=
 =?us-ascii?Q?aobOwemvPgxP4tB6Dxm5mrXIqTjqTTt9/e+peVBCoLSvFBFJq3mAbV77Aarr?=
 =?us-ascii?Q?clc9h8MZlbbHwzmLaTEaX4HXRRog6trc5m91Ruli0L6UdZ0OxMr2Uag0w2Fv?=
 =?us-ascii?Q?/6XxuUHvAOODMhtivQrsH/PoqAUyN99YY8NTendcgvV+zHSa6UrrcLscjoqf?=
 =?us-ascii?Q?ti66EwukM1fog7mYqXe5fZSPmI0eYXejTAXVmmHBTyUq06zZR1H1bLeTZCZQ?=
 =?us-ascii?Q?xLDK+VaZQSLODmsC3RLUUWFqmenQPUZ/xL2GemyZhbCYCBaG9gaGArIU9Z6O?=
 =?us-ascii?Q?wiNbVLXeVR2WH6bcBtcRF3jv6kV2NFPwob5FiWNRksmy5LEH3IPkl3WCWXTp?=
 =?us-ascii?Q?NP9e+7atD0ux6DobSkTyUgQjb9ZSZuehdHza7Ktm/XHQ92m9cSiYdxVf30AA?=
 =?us-ascii?Q?BfybBLcT8qNlsLxe8MFaIA69NGB4JSEqYkNmr1TFiuHVzeXLtyFO35lXmKCD?=
 =?us-ascii?Q?f7re3Y2Rgw6baqCzqIdDzotvZM0Z8CyoEvop2gRwiQh9HoFn0R76q3/QP4W5?=
 =?us-ascii?Q?NxOBgRQup68N/911xQh1C7SGj+CSfyio5D9XypWgeRswMnZDkSDXaWm0VLdQ?=
 =?us-ascii?Q?k7/TpeN/cdcgVuL07jd6KhSYLjoulLV/jP8esMww8OW5oKOmebMkdHGMHwb3?=
 =?us-ascii?Q?rH2e1f/i7Uo3/WbbMd/IWWhtbQX363JgNJT75QEwNR0BUsVbH8anFG0ExKZR?=
 =?us-ascii?Q?69bPrWcw/DnFrBLADavfaq4vLwFDK6Tyo/Xk7oJ0MU0YikynlzPCQRTevC2m?=
 =?us-ascii?Q?Pg/MPLu8A3QCn7ZqMHyRlp1eTpohjJVBUWkpmR6Z8f41MCJBz9tezl71JUHs?=
 =?us-ascii?Q?Vk0sfmAQrwcwV9scyWerCxhFxvftDyrGbIfzu0Vsg9NTKbmYWY+R8sDAc84/?=
 =?us-ascii?Q?ZPV/gaA51rlEOm8FQbXsJdg0kr4Eihu8qnhwpEZ4OnNSvajrZ6lGDR2fRT8w?=
 =?us-ascii?Q?ilxioFO+G13urjJT27kJngUTl6XtpHfdz6WjvzFmvOKR9ne0pw/m4+T79pyu?=
 =?us-ascii?Q?tekmcF+PMCaNgButj0L3BmFavn3i9v5+lrc+Dmu/polTOcq0MwYNsnNqZJ/0?=
 =?us-ascii?Q?vzCDoL6F6hPK45FaXotGZW/A5jk0Ve2wZFnmAOi+FEkRkFY9ecxmXzSbBt0O?=
 =?us-ascii?Q?eilVpPdu2aJdP2W2faFwShTlbrblcy8sMtUpTzrzqDXmIr2Nu/TefNB9pRy+?=
 =?us-ascii?Q?mvB3TC48DVdoAMQIcMp671d2kO51GMt66i4i2q7ziEjyGldjqMtmW6xL3pNU?=
 =?us-ascii?Q?qFDDaclcjym/8us0uyfy3TKozHUYBbmZjiAraMXGbKa+8yW2FV6jdMJv+G2x?=
 =?us-ascii?Q?X9DJL0l77FkVcqLTKFoxuGw7ZP65h+dxviwhF9uGUXsQU7U72T7hY16wv4ZI?=
 =?us-ascii?Q?KHQW7K+/eQs+jmdlI5IaEQK0vUHEZA9gQfpkwmc1V5DzDHmXK3iBUfthYi4W?=
 =?us-ascii?Q?PPNrgyJ63Qmi953AyxD7aOoZog2hSnt14Jnj7F1Lgn8LJAIckEem8L6EXRh2?=
 =?us-ascii?Q?pr+TDDRK6NtCRAocVBeKOBg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F65E97AF99EAC4A8A798C16325EC90C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f200a6-6eb2-4649-2a54-08da5e2008ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 00:48:10.7914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpHGP0jP92HGZ3zN3C9yAGWT+aFjJsPerV+hDZbjkeZ6iJa82WQjimflY69rgF/vPJJLpOYoxKb0k4QtpArUaAD7YwuErQWcjzGOfPOTz14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0629
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Jun 27, 2022 / 23:18, Christoph Hellwig wrote:
> On Tue, Jun 28, 2022 at 08:12:51AM +0200, Greg Kroah-Hartman wrote:
> > Ah, so it's a fake PCI device, or is it a real one?
>=20
> Whatever the blktests configuration points to.  But even if it is
> "fake" that fake would come from the hypervisor.

FYI, the WARN was observed with real PCI NVMe device also. I observed the W=
ARN
with v5.19-rc1 and still observe with v5.19-rc5. I'm not sure which version
introduced the WARN.

I once reported this failure, and shared with linux-pci list.

https://lore.kernel.org/linux-block/20220614010907.bvbrgbz7nnvpnw5w@shindev=
/

--=20
Shin'ichiro Kawasaki=
