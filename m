Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7B5A3CF2
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiH1JGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH1JGi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 05:06:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886A548CA0
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 02:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OibUHSb/bIo8csXQiwewPTg2m8t+4BUfNOoRaMLMNNpRYFWY3JiM/wNVfCzvQZm49BSuRB87hxFkTnSjsAgRMemEGcry3ZHUNSnbAtBJwah9LTeSywArqqYP0VT6l4ITRtKhj+d+oToMHlzNb3t4fWZpMjLvWuYfJZTrtEwK/VzHo5zUTgqAJdivja7VRp/U2r+OvF/5lJQixrneaOGXddcOI9j5TlEO1Q9XeAFQfqhkGYi5D+tsvJeDoMllJSYhsCVFkTREtTuJ1dnU828ERF/OPJKdI7kL/etnXZ4zKyJGtLGgR08CJ3GA+Gud1WyhYDNJXMEfiPDxMlcyimzI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAIiTZ7XxSUcMncTBaWcjwCWIJMsUuXk1n7uTs24GBY=;
 b=gm0zry5BnEObh/Kx8FrVjQq60ix0OybcYMq0z6tiHkwj3MnajIy0tRWjSgFBUFxYDgBMJiMYE7AyvCsjagCZeUVTKFMpUtmneJQIPraL2JDTqdT+s/Bfhsc3P02cwAZ5Rx7Kp6JBVhjJiWVxk75kQ9sx5GYGhFb7aAZWZoq94OboP6maj7RKoJJ0corGCoeNt17YTBr4726QDFYgPmFzVY9/N7M6QcoKY6OOf/BgAub8qPfm22ELhf3TFbmFAQJFtnm6LYyO3ZHnjCgJtM7zmYj8CzbROE0saiasEQyj5DgRFYo4CT6WFzCRh/7wCIUXKe/3drEZzSd3Rmn2Kl5cAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAIiTZ7XxSUcMncTBaWcjwCWIJMsUuXk1n7uTs24GBY=;
 b=IxB0OBAVO7Es9M65RiEUxbSLVJpOjtTLlJOsHCfJRXHycYJ10pCHO2ZybFop6p9hJp3qXMaUuX6CGbWdskTO61aHTArhAHgCglbqU8u5Ckbw5VAPzG5O6DcQa98jaSCGhzp3gdgVZ4Yutboeep/osKF2A1LA4oA5mvVhvGQbhThw1GNpsRcughYJzuyur812NqaMTiMfgcGhBv5JKR8IYQTND31fLjXYxXnsrs8WfkXeyZzvlNn8dsnc+ROr+SVnBtGpBds7x3TrI6L5l+vHz8SvVjNC6vZhSEmvm7/NKy/KN955qePbQUoiH3MqYL2XKbtpCTBnQzpEAfIz1DEP/g==
Received: from CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 09:06:36 +0000
Received: from CH0PR12MB5330.namprd12.prod.outlook.com
 ([fe80::e034:e0b9:a75e:3478]) by CH0PR12MB5330.namprd12.prod.outlook.com
 ([fe80::e034:e0b9:a75e:3478%8]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 09:06:36 +0000
From:   Roi Dayan <roid@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: RE: [bug report] net/mlx5: E-Switch, Move send to vport meta rule
 creation
Thread-Topic: [bug report] net/mlx5: E-Switch, Move send to vport meta rule
 creation
Thread-Index: AQHYuRz6OmWu0pSkEEeYCTkkNltaMq3ECDJw
Date:   Sun, 28 Aug 2022 09:06:36 +0000
Message-ID: <CH0PR12MB533080411DE1A0E08AA17283B8779@CH0PR12MB5330.namprd12.prod.outlook.com>
References: <Ywh1Qe1EH3+B4/ON@kili>
In-Reply-To: <Ywh1Qe1EH3+B4/ON@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87be2e86-0a00-4c68-f674-08da88d49c3e
x-ms-traffictypediagnostic: BL1PR12MB5175:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pioG5majanKzqJ2Ay4QU3EWzCLXjDHLXIpsqo47t2wUSFkn2IQ6pXZ+WlN35v8NoEUgkkVP7itZ7EhaVrF2ea+reYBZQ8+fMSdLRv89YcKrIdlbVTwbwPYREvDxBg3l2zgqIZk71Tu5WGwWjxt0qdI1DHWHeYDpvkGM9WMn6tCTZVuXvfyRIgYvyNxMZK3AYPeDkIXygzzTGu2QqLfXfK3Ro9C3ng6LZi1gyPPUtt+BrngPzPCgSCg+R87GuYuudR7LYJvvsAQQPqAUBTtmtxrq7hghiIhyhb09bhQq5Fu5OVt3+OHtA4aqZS30BkwXMC5IU70JY4kZPFquCfehdw99EcLSpLcKXVHa0NFnysn0h9oTzBvc/R1zRDPepwcmDyqrynmC2/9bmz8IL+DpXtpFc68ZEm8rx1rVAJ3IUUQUYS/80N5ODfFZtjVx4MsvBIEVa8pqMX1awu/M8jgTDU/cDUUcU6SsDwgEoofie/dMuYCLrU7A+3fAWtpSBx3Dw90AJfaTELgiqmQIU9vi7JqLMhtw1Cf2BLH7siHsF7BTwuT1RSHTzKKWg7XMnoIZVF45suQXk2yFu8if782L2S+OwwaJl0O1UgpRs6W6leHS+OxvSz/cgnvhPXxZLeObBQaq6lsThzZoop93i6m/i7rmHoSI3lRWwGYLve34pnVx51LjFIuLnpUHYYVSmW/CLioHMzlLnAHvXmW6kzsawqOZfvj7Fy62h7Rrtv4Q5X8qV+C3TFxTtsJJBDW8VHH1m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5330.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(8676002)(76116006)(64756008)(66556008)(66476007)(4326008)(66946007)(66446008)(38100700002)(122000001)(38070700005)(86362001)(2906002)(52536014)(8936002)(5660300002)(41300700001)(7696005)(6506007)(107886003)(53546011)(26005)(9686003)(55016003)(478600001)(71200400001)(316002)(6916009)(54906003)(186003)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oNlyCeRG4QgEQH6cPH/XedXzkXA6g5EgnqZewQVjg3VWOpd2nQ9Rq+Rp9nXq?=
 =?us-ascii?Q?SxUx+iYxp3ha1Fv5beIDfuZ5NODk3UMPZbAp0GHWMfHNDEmxRQUdXT7+IZec?=
 =?us-ascii?Q?Vune9HG4iv9I+waWNoLtOUFPMFQOQ7luSXv23JbA0ZFUisdmz2Wut6dm6F/B?=
 =?us-ascii?Q?LBhf5b+UI9lNJi6J/HayqLidJAf+Gh7SzoihRScKOSpE0sQvfgz+u3fxdRje?=
 =?us-ascii?Q?tWFqjqa88NBGiG70fXE2l86ypHBPpIWNqmOxRBpiYBQjM3dBMudcsJtRKnGf?=
 =?us-ascii?Q?O+5KIbbMT7F+E4LQBZs66UheMDsCyvRXcO1DtItNNY0XB8uVRnmjLeE+jdsb?=
 =?us-ascii?Q?+0FZJPWuhUsSfxICNSgZF2+qwBiRW3MRUZ7TeUiT6YtFKftg6WdELNrDhDSl?=
 =?us-ascii?Q?gxCniTEPeiTtLCVoj0XlIk+mWb6+ikxlK/kNuGzszCfXIu5+gBQ2C3J+TMg6?=
 =?us-ascii?Q?0Zt1A5e4hQu12s3sLExWnIE/+QYryPnoLkTfHGpFrJR4zC4/FpLhPsJWud6N?=
 =?us-ascii?Q?URYWnIf65Tgs5SN5aCNMg5/D6SdQ++yPknkOjTiS8mufvhRViH4WV+++8Ewa?=
 =?us-ascii?Q?CdUKdbtfEheuQTxXyEUgQy2FtcQyz5e+H2C/34OVBaJFZmvqp7c7edErgzHP?=
 =?us-ascii?Q?eISmnhXMvv7ri295naj3yzQTT+JyNcYpxrpA+a2Y9g5AbsYSOQB2MaFTmkt8?=
 =?us-ascii?Q?3trn6CaFBUAWtmJrJZgLwsJ0s0209ENNcDqSlBRSRwrWPGwxhHLJS9UXHk2A?=
 =?us-ascii?Q?lMxRJJ++azHSiVCNhGm9q6OdRlPI8xIpBDb+kwmw+m/ffwdP1AHW+HBXN+/w?=
 =?us-ascii?Q?jcG1mF2ulLnlEIlpVmULg/4QAPwReiRerhyHasO9CX+4/ERvJRJD4NmQdSBX?=
 =?us-ascii?Q?7XbIXXCMHVVjC2UMVZ217i1brxEmtP9+hmzxZWxWAkpQ6S4Aw8mtDujAAT0M?=
 =?us-ascii?Q?P7mHvb4nGF5S9HyU0Cm7A+YTa40BKuTEvXc1YT1jm5SMObPtTsQew14GLqTk?=
 =?us-ascii?Q?PuvnGK6CyVQNVK7sjWdSCmof7FSmL5KogJcz6NOpnj0wzSET3MqCFC0QgyED?=
 =?us-ascii?Q?f7bpbSjc3XzcddbMFyDwr3iiXqxFz0L0zfFPFacMJ7lQcjvi/yykNy6TyykL?=
 =?us-ascii?Q?Tn1UiYKDXX4Eme3DASC0YA7ahOb12JAA4dEnYQgahhSEEwR+3e/pUjId6j0g?=
 =?us-ascii?Q?wa52MNPhmT1Gv/NQ9q73P0BDQdtonHF4L1XlzmEbRCyv4ooYD6tm9K8y+Sfp?=
 =?us-ascii?Q?otjaXJ8Ig7HeIdkIo/TxPp9K1utj57gIJ2s4hhs8eH4SQoNCxxdftl/V+A9S?=
 =?us-ascii?Q?u5lTKrFHknJJM37zetfyttaXYOK+fr2EOxFF/N/uyta7GdQST/y0wVa+Ql36?=
 =?us-ascii?Q?0pK3xV9ZWVcGayLRT3vON34qmCtpbnJJNLj/kac6GmJfaizyuzJfGOwUnYvx?=
 =?us-ascii?Q?DnVMDVm3eNJn8SWLuq09PU5yaA4QE8V/47LLo6fa+N+H5KE6QSJRNaCoRb/e?=
 =?us-ascii?Q?5+rOa7E8Ee5Gf7VZTEPI5BTS8P1bJxaqfBJQEX25R2Ra3BZAMPS8596cV0XZ?=
 =?us-ascii?Q?ydKL+E57UpTjVgoK4wc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5330.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87be2e86-0a00-4c68-f674-08da88d49c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2022 09:06:36.1850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iope2Q1MJhgr1pVgcKWdy189+H7MM0y/vkZ6SZIQ8g8ywhb2lG6/SSP60CEKhGEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks. Missed it. I also got a report from netdev. I'll send a fix to netd=
ev (as the original commit) and I'll ping you when its there.


-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Friday, August 26, 2022 10:25 AM
To: Roi Dayan <roid@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: E-Switch, Move send to vport meta rule crea=
tion

Hello Roi Dayan,

The patch 430e2d5e2a98: "net/mlx5: E-Switch, Move send to vport meta
rule creation" from Jul 18, 2022, leads to the following Smatch
static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/en_rep.c:489 mlx5e_rep_add_meta_tu=
nnel_rule()
	error: uninitialized symbol 'err'.

drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
    466 static int
    467 mlx5e_rep_add_meta_tunnel_rule(struct mlx5e_priv *priv)
    468 {
    469         struct mlx5_eswitch *esw =3D priv->mdev->priv.eswitch;
    470         struct mlx5e_rep_priv *rpriv =3D priv->ppriv;
    471         struct mlx5_eswitch_rep *rep =3D rpriv->rep;
    472         struct mlx5_flow_handle *flow_rule;
    473         struct mlx5_flow_group *g;
    474         int err;
    475=20
    476         g =3D esw->fdb_table.offloads.send_to_vport_meta_grp;
    477         if (!g)
    478                 return 0;
    479=20
    480         flow_rule =3D mlx5_eswitch_add_send_to_vport_meta_rule(esw,=
 rep->vport);
    481         if (IS_ERR(flow_rule)) {
    482                 err =3D PTR_ERR(flow_rule);
    483                 goto out;
    484         }
    485=20
    486         rpriv->send_to_vport_meta_rule =3D flow_rule;
    487=20
    488 out:
--> 489         return err;

"err" not initialized on success path.  "goto out;" is 100% suck.
Forgot to set the error code is the canonical bug for do-nothing gotos.

    490 }

regards,
dan carpenter
