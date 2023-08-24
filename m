Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48A678658C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 04:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbjHXCqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbjHXCq1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 22:46:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659081B0
        for <linux-rdma@vger.kernel.org>; Wed, 23 Aug 2023 19:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692845186; x=1724381186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jg6Oec1DEAkAXH/XC3WCdycYpmdiRZaP5Id3zkuc/LA=;
  b=ZYO2PzIYjhs1ymS9sJGPl8q0tXt/LRHiGcPfK8BVWBztVx7yxBe8r1Nz
   MtmQzqpKrBlcnmDlAak15MJbsOY/aoZeTl2n73NNsexEGxQF3SlASBRVj
   EBVXZXs7Y2Rdg2HVwpJGnt/od2oQwrYGdEQIqPsJpGmK86coGFZG5qY3F
   3Baku+w0wsVbreOCjCeaAvyBdTN8CsvMnI2gAWolTyhYs5JrMQPNu0mWz
   5xPmRduwy6pqqibeElyVedX82W8QEpQts3EhrRl++8pDXmeR0L4/lyl7E
   f/rk6YMe0qsun56sAtOMe9M6YBqFJ1JLfM5DRfeZyUuH4En0JwSMEqsLp
   w==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684771200"; 
   d="scan'208";a="353960933"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2023 10:46:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH6Xpm/MNWA0pgc+Lsal8ctkBbOZA2kiiPJ549/P02LFFWfsDrxw9rDqxAmXAN36mn3Oy8xZ5Xj7vJ1p0U/RiaPu8opjDPnezkrdkazmXtEgVNqTkOcoiuMS1tqdYI0wya8gzO6vgKVBCCoh0jYwJCdQ8/yQj88yA1nCTrhrkR6yay6eOYy4hW4dMJYXtuD04xrBL7PPbvxNsGpRS0ojfY2n/Tiwf71dmxeC43/OoTud3VdtrDfEaW3quvKzTRBHBtCYn3J5T7hNe1CwlGgsbHX4g+V652NsYCk1evraInZFpYuT61wzX8EvFHsJb/7A9VTYChws2rWcNGEstsuigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg6Oec1DEAkAXH/XC3WCdycYpmdiRZaP5Id3zkuc/LA=;
 b=iOFsGhIya/i3eT5xywsFZ1lKnbdpnkxuPpY2weHmrA0yiOpHswsmyzJAoi3H6QlNv6yApvMBvkjAeG7vnppc5T3lpR7qrXa2XcIpvxzbN0Qxu7kiDdScE5tlyl3/of7r2OCYzZNpdryyc40TiKT9NtKU1/cobyeahk3kJOI3OH2Btwr74FdV49x8EzrUdx+kzOidCR4cuUMS43oPC2AAwftX2exb+iZ53UyY87kvq2W5tRxKBRv+bTg3YCgyOEP6q+TuBTMZFWwRqYIhFFLJbhiFxAx1/ll8aFfnFtQFasJCNGk8Tzwrfml9I+e2tH58GIVBRc9+7v8Xa735R8VV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg6Oec1DEAkAXH/XC3WCdycYpmdiRZaP5Id3zkuc/LA=;
 b=Ldai/hQIyr8iPWhWDzkdGXnG8yIUZjP59OP4IWil6sDRn4gGA4rCZZ9+uRwzBz/WfNhwE1TjuDYVSSIRizQVErP2rAa4Jdmbgtf1fa92YZ8FAqAtMUnZNdJ5DYQ3wndDjt09pRV20uaP7kNcTFALNenvW0Oaq7R3d9oX91RY/zI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.11; Thu, 24 Aug
 2023 02:46:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.016; Thu, 24 Aug 2023
 02:46:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()
Thread-Topic: [PATCH] RDMA/srp: Do not call scsi_done() from srp_abort()
Thread-Index: AQHZ1gRzHi/k5w+wmU2RlWkdavOUQa/4vi0A
Date:   Thu, 24 Aug 2023 02:46:18 +0000
Message-ID: <a57g4ywpwsldusg3ow2ci5nviikma3p3fcoqeatp7pt63fe2tk@xgisoxtde3tp>
References: <20230823205727.505681-1-bvanassche@acm.org>
In-Reply-To: <20230823205727.505681-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6472:EE_
x-ms-office365-filtering-correlation-id: 6c482eca-7666-4710-9ef1-08dba44c4b0a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0I1ZkOhViniVXJzauJwNELcczvzl1AnOytZxLkyo3pzvhKsgCUn34Uig3DkwwL+/QPsjX3/y9cYblwKlMC0BLg6Lu1u2D206d0oNC+CGPp7Ag2La3p14enMqA91aieIKNmSDjAYJ2lCpyq/7JxSIaMOa9hrsrYn0gObU4lTcXu5gqn6OuUZRLKLKS+h1AKisjR9fkFQvW63sNGyGBDi9Ipv/dOwlQ2idXStDEFzC+Hl3sAtRzQuksD8sXbuQHfUX1j9gRBjFzSbJQlv51d3inovxlRLZaSphXDk1xMo8QBzXG0zoxd2OsQ/izJEoTXE24/G9XvqbTLnCqkYbh3Mpuh+h8ef2+jyO5G4oV/JaFTnpoe9xyTZVB3a1MpiGMUm2uxGxSnNsEgoCLf82cTiQJ38Jibbstb4GNzLu/gvZ8Xh/FCgMjzc0Tt+Df26UcROl6mZuwOa8mlJzNwYGF+W4X+lMhGyxV1IIzr08h7ZK9oPclAn2wIOU7OpsPOyuKMRJTGRKcypnUlU19iU7o9FAvXxIS1ytLDNFY1bY9Vtz+zCXkBPDsVtiMwWOfdm8Lj/7zRlays0J52TYh1elEYOP6VLBUtUeTwRFJmSrOnOtt02gpVDPuNGHAtvhP32adUI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(1800799009)(186009)(451199024)(54906003)(76116006)(66476007)(6916009)(66446008)(66946007)(64756008)(9686003)(6512007)(66556008)(316002)(82960400001)(91956017)(8676002)(8936002)(4326008)(33716001)(41300700001)(478600001)(122000001)(71200400001)(38100700002)(6506007)(38070700005)(6486002)(83380400001)(4744005)(2906002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JVzIpizAU+rVaoFu8Nc7r8/dCO6Dn+lGfKriZCmcuCMFoizTMEEcKxAaFCqF?=
 =?us-ascii?Q?pNwGDX7yUbD4q1K/FpL95/pzMd6wMrvJNSuP3lxCfsflPQgIeoIxH5Vq+hl5?=
 =?us-ascii?Q?3wEvmq3J2JHClx27VorgjItDbFNBYhzhXmqO1WsrfPU4F3BN708tNe+Zx1tw?=
 =?us-ascii?Q?OqXLv+X0W6FH0NR7KEIvoxep2bX2Mj9xPTWqieE/cfdUBiVmwCAcC6AEV7TV?=
 =?us-ascii?Q?nV6DYeID1hvcNW125qX7d5Q/7I/jquBjIl6dZyK+iQYMA9oOOP5F3tMvzTXQ?=
 =?us-ascii?Q?YawpD/kjmFg1zJBy9tu/jjfoUsXB7peZz8nTRRhTvptXlozG+L9v4kF2g4t1?=
 =?us-ascii?Q?f2B/PvwcQ1+z+gEgabxEl8rULF6xO3mDx6sxmai2A1MFhxZ3ITYsZuV0Y2xg?=
 =?us-ascii?Q?yTvPvGY96FyQQn0E/xXfe/Vr7pgrNM+v7uL5stv9l61x5NgpYLU4aDnxSQnC?=
 =?us-ascii?Q?RhMEK/kDwYtozQzphcr65XpaIWFY9i/YkqY5nWpfifCp+pAbZiVT/JUdq+jY?=
 =?us-ascii?Q?YCWTx5BVK21Z3Ter01CLztDOQRzNLb/l/Oytxz5opVF5jdVRXppzdSolxHID?=
 =?us-ascii?Q?CO1GlAe1A+E7HpCREjdeYUnjIOcb5cpwgcsn2MqYrPPInazr590mfHcuHa9s?=
 =?us-ascii?Q?JxTP1xCamIHEDSuZCjOd1Jt2kNRRrucSZ2nvUeQ+NGOr2FBmh4vbkbMRlUri?=
 =?us-ascii?Q?pwDdUycdz1p1x5nWa/5O7GU/2IcxBkXpr3oGYVu9TbB7KqczhvSFyPrvLIl8?=
 =?us-ascii?Q?fTYQq9fWdu96SDQhBq2Eln5oEN14Qo2ivUMfbmUaVHgF0m8CZfeWyqvxikce?=
 =?us-ascii?Q?sRb5x3k8lOC2wLEIJHG7mtr3EXcLjlVR+5Bo+aJ8uUN9p30OLU76sCD6oUQQ?=
 =?us-ascii?Q?F/LplrxOvgWkLoUb1rEpGymmGKh1oDh4ihiJO9LxJfYHFYGB42RwjYwoImYN?=
 =?us-ascii?Q?lYagSLL1NiH2Gl5mlDmzl9sO/Fy5LCHuXQvOmiFaNUi3SEG9YiFin0ICOUyz?=
 =?us-ascii?Q?tgIoDSGsswFreFQlLNNSvt1bP73BG76X3bPQIrdBq1ecwP3p1ksYMCrBCvWZ?=
 =?us-ascii?Q?4STcLHDupSzuu1QwP6cSS+s15zhTylqXgJRVLEQzgbiab5xUdEOP6siXFdEO?=
 =?us-ascii?Q?P6JAyGP6qOoB8QGWslUyHwqwjUPsC3MGPKU2J5S9cGMT/vSwFjGa3xo4Lm1d?=
 =?us-ascii?Q?7sPWYYOc+qsiWe3V3RwExIEmkc9TktxzBREWjaV33t/2iGvkjn9RAiWWo/8V?=
 =?us-ascii?Q?++sdwm2yLuaBk3GNBpyFP3ojzXXNnvxvJS+934/KcSTVSpzIZqy6XIlGPCPS?=
 =?us-ascii?Q?Lg49l+EK1kjX4Riv5CsQ2L4ZF/tq0futtyehoa+yo/jVE0J614O6g86+YnMF?=
 =?us-ascii?Q?qAbZWqcxF0ur5MMVSrdS4f3A8yEkLVCcfqtBXtF5fEXBdY9eRWoV1YciqzzY?=
 =?us-ascii?Q?o5wPz+gy6KP+yjCmdk9/tM5JjxtjhL7draKYbwqdMA/5U5jK6ErvtHkFSFzz?=
 =?us-ascii?Q?PMhjxKsTpeL4HDuC6gOjfFxHnrYEMCfQNQNgbSpIuw3zfYY2YSA+eTv4H/SG?=
 =?us-ascii?Q?sxUBYtAgsBCSl/Zn3MMWVc08/eXdtWyyIQ7v4RXuny4G8+sePHhIFWPIYGcA?=
 =?us-ascii?Q?J3TaERYeItPaVFyT+Jpdtk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEDA9294D787984293B665D6A1DBF2B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Br+yhNooEEJHQGXBHHaJRVG6+lWtMvn9Q9hyoQMOlxlefOGtetEqx8mxdAQCGcSvgEeeIBVVBMRJ3m1iTJXY2EyukxpTZqHQ2+bTFc358iZZsn6r18i5raAcxwIZFJekL8zU2v0l/Ea6Lc2v1FeEqTle2F+uG84uyHZAxaqbJuwJaPugUOYObllNSdZ+ZTSsevNyExmJccQEIPd+8XOOuUscJL4JToKAaMh7ecFl7fAJggwHIIjSG4xOuBCSXk5WzlEl4kNboCKpijycINfBfvjFpEeXYOVZABJ7ToX++8jC6lZ4r6Gh8qLgx6oDvtsl2v6eqFmEt5GG3zo9Ah5WjVehLo6rqEh+GYQl6EAVjKo2F0BFV37dxNbPGpgnR8b2aznurcZkPHs0Gd2ZoveaS0LyEJzQeDUuFnYUZJcwEwob/mUIayB2spW46/4MBWjmcXnlNPcjIKuczMbULwc2CgginGyDaSMp4l3Ybid8bgVSfUlQDgjBGgQEmFQXy3oiIHpUU6RlGvLVzojDjUtudd16qOiDchWLDtKtjz4SBWdREtG1nAToVKQqH5JrqmkOCFEgY5q1pxzCgrZxOG2y/+5ovmvLhVDtfgUPoGTOU5aGcql7T0RF7cPqIoPvIfuHDuJSYNfW6wJrzjZdgYkDf/lk9LRzImbAn4UYLvLbmaA7emvaL1zVCt1n/O47vWNZxcGodcAOF8SX/GWvO5QIHXi8tOYWyL2vI3j9BHiKh0/rV/4RHiAnYfB0p1CbzzToFC8xHzws66Mj7QvZ6oz1Hm8J2QwHS8G3FbScrqbMz92kS3FtJ7qnxgGbk7ife9kJ2vRe7zFjk9stII7LdxI8Jimz4W96sGmPB8ZHxAFYGmc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c482eca-7666-4710-9ef1-08dba44c4b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 02:46:18.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXzUS0Cef73DXctaIgt9pSJ5VhZCOcP9PJRqN+dkxhhdRI1sltIdtM4m+Z8I3m6u2CB9q8oE0WuA4jp7uLsiMNMJqZsBsyDATnTvOCVpNvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Aug 23, 2023 / 13:57, Bart Van Assche wrote:
> After scmd_eh_abort_handler() has called the SCSI LLD eh_abort_handler
> callback, it performs one of the following actions:
> * Call scsi_queue_insert().
> * Call scsi_finish_command().
> * Call scsi_eh_scmd_add().
> Hence, SCSI abort handlers must not call scsi_done(). Otherwise all
> the above actions would trigger a use-after-free. Hence remove the
> scsi_done() call from srp_abort(). Keep the srp_free_req() call
> before returning SUCCESS because we may not see the command again if
> SUCCESS is returned.
>=20
> Cc: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: d8536670916a ("IB/srp: Avoid having aborted requests hang")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thanks Bart. Do you think this patch fixes the hangs at blktests srp/002 an=
d
srp/011? I tried this patch and still see the hang at srp/002, but the hang=
 at
srp/011 looks disappearing.=
