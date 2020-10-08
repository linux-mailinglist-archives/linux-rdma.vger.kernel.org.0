Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE23286F41
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 09:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgJHHV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 03:21:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14148 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJHHV6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 03:21:58 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ebda80000>; Thu, 08 Oct 2020 00:20:08 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 07:21:58 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 07:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctKSVrj5KdeLT9WlCfrD1Bou2PzhUrQ2bWfu9M0JjrCbJQoL9aoMo81woYW3JxYolyWztxCEfbH6op/EPmASr0psJa4kf4P7+2y3lQcaRA7FQSj60yBGSB5hg9nE+hSOsj776LmjV7kJcT34hfMs+lpVzTXXmnlAq7OzUh7CHalfrxrgLm0tm7XwkSS/jK+a+iXDNeJcm3iZKzmUQE4zAQQCDQMXgMgArsUkMtpGcHHGWMkOD9RnnEiQmJqy61Pv1h+WzDDS0Wca5MTLlBiFdcOtf14EpXnWCJIswkPW9Pbz+tyYvJLQCKx6b70pYQhiYr6o3cQ1tVbeaBEt2TIJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZSWGWAuxklOGU5ZoYVAVT02SyEFQlD/FMwTRp9uOKE=;
 b=bPdPMcpGSvZtCZBClx+JkkLd33uH34qlFHynVdWT5FynfX4FuNr6ztSrmqyk32rhtGjwc9lvWagq7iU1I6b2mi3F6SI/uiIzheYdCDCgV8N4taa/p0G1NP62H4isDmFaYD5kUYyVM8mj88aH/xfMEIeOalvffo4fUOfc5UJKhKGqrL1dbJT7SXX2Aj9L4YGHXtu1z1l/SMAUONaLARjfWlIk+TEq9mqCNVTS/HVqNnfyYfhJfDM3bU7xCwCNT7Txx9Z8yhQpxWxN96wM2Gz72nT+3p7dAUogGM86ZMg1w9RfomPOxV96Zelj1g9OiUEwJGL+qY6PBG3YxKQoF+RqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Thu, 8 Oct
 2020 07:21:57 +0000
Received: from BYAPR12MB3287.namprd12.prod.outlook.com
 ([fe80::ad27:feb3:6b3:787d]) by BYAPR12MB3287.namprd12.prod.outlook.com
 ([fe80::ad27:feb3:6b3:787d%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 07:21:56 +0000
From:   Tamir Ronen <tamirr@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Subject: [ANNOUNCE] ibsim 0.10 release
Thread-Topic: [ANNOUNCE] ibsim 0.10 release
Thread-Index: AdadQwQTQHI98xlMRu2x1MDMGymY3Q==
Date:   Thu, 8 Oct 2020 07:21:56 +0000
Message-ID: <BYAPR12MB328726D6BF34E9D4337C316EB90B0@BYAPR12MB3287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2a00:a040:199:82fb:25ca:80db:396b:b7aa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8625d14-43ee-48f2-6932-08d86b5ad6d0
x-ms-traffictypediagnostic: BY5PR12MB4306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4306E444628E6AC3C1CDDA5DB90B0@BY5PR12MB4306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jSvpQR4mKwOzgRY3XljR7x67/S41jnJfe/yRqqH7VpTHCe1CflPkig1GyhzFHRAsjqGTuAbxaXqr+eAf953jZikXqF/uFm2Be2UB7ORQA2z+BqDxa0PXwBZzbrwlobl+EDxRUuXk4ADK3/oYDczbHB8w5BzlieGx7DDb/V9yha40GVlvKYwdAVpWoXveBqgcPKmIsz9lco/FlTHXL/40MpNWFFPD/g0V6N2oHw8kcj0CrR3ez4qlrj9ul7Sfm6o0o6d4dBjaKMqy2FKGtsVjQZ7MbaH/gDFSMkO6Xf0X6yc0lF7rezMWVqCHFOyL1YCxgZ1RC22XgMZ7RVo/urIgH7rz2xx3OdD1MxCsqfC4JeWCxuC5HNWWUVbTQyoibfg01kBugh9a4lU1OORoFF9R+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3287.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(316002)(186003)(71200400001)(966005)(52536014)(86362001)(110136005)(478600001)(83380400001)(8936002)(7696005)(6506007)(8676002)(9686003)(83080400001)(2906002)(5660300002)(66946007)(33656002)(55016002)(64756008)(66556008)(66446008)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ab7BsvLOTxPfat6wCoieT9bxMMDGr9fw2Ki8pIWHFvVTrH9tbw68GnRUvc5JkIbDlMssG5CxAst5708xsX5NQnyae/iQ403aVt3vJy4WfWNeFuw2SbduO1CX+cYHXRnAFV7bYRtjjbSwwPBU936Sb+JIbjN2SnthQwopTCpqcxBv3ZgLAu5RLbSIaI1vF6t/Yq1AO1beMDO6CBUu+f6tzTahwdCWQmn7DndUCyN0Zwo/fHzul3T73jN9YHrdgN9Osi7l9EIRW7q2O0ArkAczeUq+LuGm5VrYMX/N7lr8FbdNkdTz1ZEYX6sd6Iqulf+TEMDpSZa5Zm88dvm5i61zhDRimwQQQaZ5Nv/yPpJUELvL/eDz5wQuGFyyO8TKGd7IJSljryCbRnAkpTvTV0zP0kYcRbCBbWQwE94LjGdB4aVL9guehmLNBojpaQS8MRbQRkYvaiwmNtaBSWuzFffohtTyoFS6kSr84p/i/3iqLqXAwqSkrlAGK9pmvrGpCvcZ6DS+FwoE5iW6wxeDgew0UM5ZVFiSMxz3z5f7cWyzjoxc+KqzJIIKMMNuGqz25NEe+Dc+15aHYb8GfFPsp5GuchzZNn478/F7mwNKtvAT/t/JrnHIf2GK41hRxBUxteaQxAF0ZJWQqqBgNL27QzOAKXcQJs9pbcUl0W8q1PVIPS+MCldo/JjKHUi8duSQN9YwQN5hDm91qJj7urU2ypwQUA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8625d14-43ee-48f2-6932-08d86b5ad6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 07:21:56.6197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9MNvqQWkl+OjLzMjLft4HvZuX/4n5Zv3IKD5q6bgSW93NxUf5o6n7WxA7zmPMhpBi/Y4UXBULeRLGh/VF6hqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602141608; bh=iZSWGWAuxklOGU5ZoYVAVT02SyEFQlD/FMwTRp9uOKE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
         Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=aWzj9PNjYJZQaNg7VZdVNRfB8YO7TpG7dJlR5RzS3sYeae8yzLSeS1Ktxcoyryr+s
         JnchtENlrfvJr9nPvjMhJ5fOhn3Ks++bwB+1yiXwhPkiPClUIZwd2eg0UTwjgH/uoU
         3tf9Dt9M3WmaGK8ryZCpInkpwTnFtw+IAm1Ohbhe6OY2gZOa/e5smy7nIZktn8ZlvF
         G0gu9bcrnIXtOPgW4VrhihoJD6HKmhcQiQMnR/qvYA8HZ92H1ZUFyxnMrct91GRENS
         /i9IYhfBHBhwYfhQ3a37LqetNYcY7aVG0NYcTY9Cy2FSNmznugMwrxokrWxe6NDE0D
         IVHJgk/J+pQsA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a new 0.10 release of ibsim.

https://github.com/linux-rdma/ibsim/releases/tag/ibsim-0.10

New features since 0.9:
Add Debian packaging
support multiple umad file descriptors
support latest libibumad

All component versions are from recent master branch. Full list of changes =
is below.

Tzafrir Cohen (6):
      Debian packaging
      ibsim-run: a wrapper to run programs under ibsim
      defs.mk: Add standard build variable CPPFLAGS
      run_opensm.sh: /bin/bash, as uses non-posix features
      install: missing ) and ; for the install target
      Makefiles: avoid target override warning

Leon Romanovsky (5):
      Merge pull request #12 from tzafrir-mellanox/deb_packaging
      Merge pull request #14 from tzafrir-mellanox/run-opensm_bashism
      Merge pull request #15 from tzafrir-mellanox/makefile_cppflags
      Merge pull request #13 from tzafrir-mellanox/ibsim-run
      Merge pull request #16 from tzafrir-mellanox/ibsim_run_install_fix

Vladimir Koushnir (5):
      umad2sim: message queue implementation
      umad2sim: umad fd descriptor implementation
      umad2sim: support multiple umad file descriptors
      ibsim: mcast_storm: remove umad_close_port call
      umad2sim: call umad2sim_init in opendir

Tamir Ronen (1):
      ibsim/ibsim.c: Bump version to 0.10
