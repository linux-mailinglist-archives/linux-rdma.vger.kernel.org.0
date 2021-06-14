Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2F3A6789
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jun 2021 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhFNNQ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Jun 2021 09:16:57 -0400
Received: from mail-sn1anam02on2076.outbound.protection.outlook.com ([40.107.96.76]:5991
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233346AbhFNNQ5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Jun 2021 09:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBAFISjmiqzuMIu+AZ/2CZbmjbxsoj39NMBv894Zw3pK9XXVS5hOfG+8eFWZJkoIyKjZ3g8hCQi6Yd4wNhTnjryUn7ZZXJSvvftXEPokRYgp7NhDhQ5vzgASA9EPlKAN+2pv18Xyd3PjhZiO0icN60cXMQmfb/nlgVtVHZQKdMf3q7Jiu+M9PFTpEuL2B8717RHDyd9t1OTP2ZZ1FLr7aHW2TGFtLp0k0rZkKeE5mLU3s6zfll+AsaSRItwNlB51PzHYxKyydrhMeit6iiZYJBW8X4XD9jxB/prTQVXxndfuKfzuwWvBdWUiaSre4DQ/+g18maRB4BJ7Rr6MyaEq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kFjIvICoKjXGmLjSU2HcF0OEwjNJ7BGnVLdrm/DMQ=;
 b=oVnIwq7qiSHuzplvA5duMWpXwGlx2ZD4GyGvBfzBUFh4PPqPQ6BLtaFXAXa1hGjdboxC4OYopbzbls13dUwFXI3owljWp7zOZhsCmCCPf57xMiXIrSsFNenDsFK2QB/vhWc4i4+dcnfriL6fJsR8cZ/80ob7oscEHZoEjjMOsYf6jNGF45gS+RJDa8DW2NBedhoIUkWcqpgEpLInuRSUisOAtfYlfezswOEYJLjC1pRr/xXqQ6ziGQ23jptivYu+cOnHQh3spoqUJwpeZt9HLN0btHX2al0eVxpBBxtACXY5oKiFAQKKqp5nEJrN9xOkNf1WqzO21GmZ/mIaemhMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kFjIvICoKjXGmLjSU2HcF0OEwjNJ7BGnVLdrm/DMQ=;
 b=ZUL5pCRTTAvE3lDFehfxWT1p+5pZS9uUTgswHBvL2QPs0VCigVLchDVp/1gr1qEqVBDBLiQZsm4XSo3b6IaRC4Xqa2OYVfXxlgpu0xuxAP92S3JFQRek8iljWDnMNysch2FKeOmaJVItxGnPvcq18WP1hZkbXVH+9xkj0HxlkJO1nxGtWpCJShks2v+Te1Pp5ANUXFzRYbZXgtuiDLBiwaGXXJ0ybmUow98C/66vCt0B8/J25zAhJjVT1fz5yJvIKPhzCQdTt66drvGMZItV1Nv7IGTABbmTK6uM7P8RdLEe2R9UnHKBscXIyN89BVJpE8rZWEFJVmcYFr8k9BrkHw==
Received: from PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 by PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 13:14:53 +0000
Received: from PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2]) by PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2%8]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 13:14:53 +0000
From:   Tamir Ronen <tamirr@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Subject: [ANNOUNCE] opensm 3.3.24 release
Thread-Topic: [ANNOUNCE] opensm 3.3.24 release
Thread-Index: AddhGf19LEVb8/DeSMaSf2HrqHDfFA==
Date:   Mon, 14 Jun 2021 13:14:53 +0000
Message-ID: <PH0PR12MB5402EEE2EBE0BAA3800DA8B9B9319@PH0PR12MB5402.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2a00:a040:199:82fb:88c4:37d6:7f4c:c75a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dd47b98-18b4-4549-115b-08d92f3665bc
x-ms-traffictypediagnostic: PH0PR12MB5468:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5468AE18E35FCEB20D804E5EB9319@PH0PR12MB5468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L4HeBFye2rftBwWL2gu356l54VirIpYbCQn/RJO4EXpwcQTboKFxh9KC1LxEq6uRwq5t3p6Ht38yRJ31+u6g0tptNb+4wLxxaSCBPoMu8oJzJIyrkBtWxbsFLaiWM6FmIArDqonfR2NtM6DqANgd+e09ZhB3tHVA/hEOGgT5zT9uBPD0OkW3xwksO8SZtU7XmSQuxAgS+tuk8xjalkc5ptNy2ly7MJnQaFkiQMQdF+x0qmGedeVptgncgxEXXW4KBeSaxSLktgBcezPGfQ7ePmYSEZoddk8eBVmx2aFfYDnS97GejTDnfx88yFeLt+wd8MJ6Ct/rMbr6Igvs76fd9s+jky7GGMSIXhcI7olVv//yWeH9iIDXNLc2ERyX/gWpefJF80gk5BrJkdio4sCuDBuF2fPJguamjV3njYaAXqzqQPmBn3EY0fyM7neyZeadBD3We3mtvCe0JYswmSPHgPt8tSKBjhUpBLVMbHobN4BP7GDtuiXDAMedNMgRcj1ERTIR+d+B28lOt7FMGvWe2h8yP1vlCksNztLungDzVDsIH3hFS4VwbVKWqAd3eqfvBrECRaO17sOZMafMx21TcB/fS9RSXRKlefSixv0t2N9buOVr+q7UiKOZOSjB9Pegaj1vzOxnFESXG4jnbPgKftkBzMDwsaYW9BqIoIaf70Na2334Rr/K8cs6qD8jtfOww/PH+LQn2Joia3Ai3fZMhlOZkbQzVjLmnaFUdifke6efIsdclws7j6ZbkN8ltjuZHDoz7A54Hegw5ghDl2fiHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5402.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(316002)(966005)(33656002)(2906002)(478600001)(9686003)(86362001)(83380400001)(186003)(55016002)(52536014)(66476007)(66556008)(71200400001)(66446008)(122000001)(8676002)(64756008)(38100700002)(7696005)(76116006)(5660300002)(110136005)(8936002)(66946007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9CM27LRdaWhazByiucf/sRQ2SUOtbkBai9hHmhpMYmZ+W3VaVWYcMX4vdP2T?=
 =?us-ascii?Q?2ZCbAP/DIyYNjAFMSH012yd7b6oWITMVXy8r2a8QuoAg0XcMQY6qiX276Fof?=
 =?us-ascii?Q?GROjNlFAdai6Wi6u5KkHi7xdh0qBvZYX6lmdHtNq6fp7mrB5yDZIvC0iZLRV?=
 =?us-ascii?Q?+szy+M4Mrls23+MQNHvPhr3UWARR5vBXKmhnQs1u4OuTvFIO8CykSkgorh4Q?=
 =?us-ascii?Q?9YgVyexuenVL1z+8FF4+8rvaLzOEVuL8YM1z15PY2EI1Hz0Xap9t7afQCTVf?=
 =?us-ascii?Q?eUvFRNMMtW/VEHJ/fNj1hw1wEAX5t1VBBXvkJHICdUNRLbiZMpZCdi4S9ael?=
 =?us-ascii?Q?dMCWQidN6ZuzYpGBZSwAOUnKxikkN9YQPVDgE2jT4Qf4ZAu82yCuGGuAbkFT?=
 =?us-ascii?Q?g93BzTSW1NoP9HHHbOzZEC1oQ10NOJ9P6LanZuX0OszsXHiVUGuiiV8+FXSN?=
 =?us-ascii?Q?PLiVSd5ABT+PNySxUi0OcEpk/zipaotAftD8i2XzsIia+oz48Kgeer+pPJ4Q?=
 =?us-ascii?Q?tSs0dB1uIdLLZt7zawBMKn6YwgrrBuOM98G/sfxWg/lwHsYmq6fSX13SdQR1?=
 =?us-ascii?Q?N0LUk5vuG5CQ4NDcPwi8wEO0AOku9q1xApyTTbdHA/XWdxhDysPR6RObWCuh?=
 =?us-ascii?Q?XwShE6Q7Gu5aV1azIYBMSs/A3zECrIOksiYSq4RlkAlbwBps9kCLiAKx6dul?=
 =?us-ascii?Q?WpLHt4DW3j9GG3FIbnkxp882B2Rp9w90Ba9DARgn2DQwsgUISyUWHzavhAXO?=
 =?us-ascii?Q?DsDKeGqAcuuJGgqyjKRez+wjgGbMga0oPIl0/93C1CCM4pgTZnfhdKcLtPZo?=
 =?us-ascii?Q?18LM6jaHmv1eFN5tw4cR6zIC0/iNzgaDzNYI13cv8b8vGdAnsoq1oXyL7z0M?=
 =?us-ascii?Q?en7NuCB4WBpfHUFaHItB+YGoVe459bEUELffSvrU0fQ3PabUXQAIRVPECrWx?=
 =?us-ascii?Q?02slRVo+frtV9M0T8Lkore5351r6HsQmm/zsfHeZZxnHWnOGrdROm+JKmz7p?=
 =?us-ascii?Q?fH2qk6035d5onNVBHdLZa8bkvBui5Ti+WOOkX31N7btt1NqzK3ayuwK9YGpW?=
 =?us-ascii?Q?/Qwa82ATxHYPD66VfAAZMiumgYVHmAOAWsnFMpNttsO4EF14YnK9u5iTHJan?=
 =?us-ascii?Q?/LG6Pj2CO525r2QTANc08ZaY1U/ew3AGb/Npsa1I24/7/DuUQbBVQoFTjGOV?=
 =?us-ascii?Q?NAYnREsnC3DNyfYuWw6Al/lt2cCFrxrUtFMmaVfVzzy06J1/hda4ToPZvPSC?=
 =?us-ascii?Q?T/swsO35QW7+vWQgaN2Qw68l8YNI1i/W0sKr9kwy1sOGmLSXGMwxhJQtgXsB?=
 =?us-ascii?Q?v8GlEh8azYdvFCStbWFaG4+CBZZHFpwP24Ho6r1ZAsP+hC7PX62mkjKsWgoS?=
 =?us-ascii?Q?PWQdx+sXjMrrByfKXeZRdBClIYPr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5402.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd47b98-18b4-4549-115b-08d92f3665bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 13:14:53.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POpejqLUKZhhqbIM+6GXvol4uwHn+jlyWnNqGcIXEyk2o2yEBO4I0x5x+uAvGr30lr7gKURgBUOaR6kP7DaVwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a new 3.3.24 release of opensm.

https://github.com/linux-rdma/opensm/releases/tag/3.3.24

Changes since 3.3.23:
Add support for NDR link speed, improvements and bug fixes as noted below a=
nd in release notes

See https://github.com/linux-rdma/opensm/tree/master/doc/opensm_release_not=
es-3.3.txt

Full list of changes is below:

Or Nechemia (3):
      Support NDR devices
      Backward compatibility for old drivers
      Remove redundant negativity check of size_t type, which is unsigned  =
   thus non negative.

Tamir Ronen (3):
      Update shared (internal) library versions in accordance with changes =
since OpenSM 3.3.23
      configure.ac: Update package number for OpenSM to 3.3.24 for release
      Update opensm_release_notes-3.3.txt

tamirronen (3):
      Merge pull request #21 from kleindaniel7/allow_mcmr_with_default_pref=
ix
      Merge pull request #23 from kleindaniel7/fix_2x_width_check
      Merge pull request #25 from ornechemia/ndr_support

Aleksandr Minchiu (2):
      libopensm/osm_helper.c: Fix printing trap 259 details
      libopensm/osm_helper.c: Fix printing trap 256 details

Daniel Klein (2):
      osm_sa_mcmember_record.c: Allow MCMR requests with default subnet pre=
fix
      osm_link_mgr.c: Fix checking if port support link width 2x
