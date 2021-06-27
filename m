Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296383B5395
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhF0OIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 10:08:35 -0400
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:18273
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230386AbhF0OIe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 10:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIEC7HHdQGqNDz7G2o4e2PEYX/JnAolKMXBBXqV4vWzPRgQNpOQZTOe8zD2HP24Ou9hMPJm+aVncEHJwznGLErYe4CKROl6B8nBJq8/eIQFFPuXRBrF/sYD3ryWHBkhRgF0E0s/ZS8ML+GbsveQTGqCK8dcIRpYlG1dX8M0JoIVAxVDuNJVgu+drOTHtcLvyyisSOFQMiq/mjGz4ih6MZvKD3LQrsrK1XxIlN/vAK3C+CURgPVo5WxlJd8XqB6bgEfhUy1Gvhg6trKf5F5YfLk+p6p5W6l+EivImgslWQMN09IQkTB+hSAZU+1K8ZaFBgXUOHm6IHCSBUpJLjg9Jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kFjIvICoKjXGmLjSU2HcF0OEwjNJ7BGnVLdrm/DMQ=;
 b=hqTC9cKBmeyenjRQp7GBI2tJOvBj1UkZn/b7mR8UjApHNORtTDscq93r3/yd5wz6bIqHvIz/Cus6wMmci8PD8imG2ubhjPDs6aV8Rx2ud7Wwv6wguR7yFy9lgNrIERCKE6NhMx4sqfCdFmpXZnRQ86pMNXXjytIkGvUlZxsbfR0d0UA97LoPU+0wmtAq9OIUDE8d1mMHLtO7VeSdfGoFwCAim/dKy7/tiVo++h757vpMp7/UJ/R442fdv2yrJn22KfH1zZkG/7BXI2+1KI52Oy69Q4LMeAQsbaEqoWmpFYu5bXaSIpasIqNcUhYBpVg2py6mM2qr81vRG4k6zY6eOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6kFjIvICoKjXGmLjSU2HcF0OEwjNJ7BGnVLdrm/DMQ=;
 b=USa314DodBQK0Fi5W7fernPjRpvwKofdEAF/ZoLJa80Q2bi74hNLfnNLP2StLSZ6W2+PDXY9ngh0W8TUOEntD9s3F06sN9ElqzebLBLMLrSVCMmdUZ2Lk9mRVi6jf8VflaVWp1YKp86k+0V+lBE2FMXjDQFfylWDdyIw8xlR6C3JfggziSkgHlVqpcUMRvI1bhXRU/itw09Lw9anuQ1A3CTP49L2l7L4bq0f5f+VcBJkXFEJNTAkNoyXk4P2V+Vx64F43pV6ZaVMfVEYogAibfashnCP1csVVOt6Mil/Bqou80bxyzCiaTKvJ6efHvOfXVJp3yWDp9bp4YiJabAroQ==
Received: from PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Sun, 27 Jun
 2021 14:06:09 +0000
Received: from PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2]) by PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2%8]) with mapi id 15.20.4264.026; Sun, 27 Jun 2021
 14:06:09 +0000
From:   Tamir Ronen <tamirr@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [ANNOUNCE] opensm 3.3.24 release
Thread-Topic: [ANNOUNCE] opensm 3.3.24 release
Thread-Index: AddrXWqRvy5v3jV/T/Gw8X6jo8dz8Q==
Date:   Sun, 27 Jun 2021 14:06:09 +0000
Message-ID: <PH0PR12MB54026DA9DBA483F210C359F0B9049@PH0PR12MB5402.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2a00:a040:199:82fb:64a3:35c4:319b:b80a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29c2634b-c49e-4856-0c06-08d93974b6b3
x-ms-traffictypediagnostic: PH0PR12MB5450:
x-microsoft-antispam-prvs: <PH0PR12MB5450D7F2E0182A793A452BC5B9049@PH0PR12MB5450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BMTlWQIVR0uMYbQtKeaDkz77rhQDb5f6yrW46OFrWTYpDC1JIfgELBzw76BrCTfvccR9hGcyugdsxGq6yQOB2UeiRb+ZyAA3jRNKZD+H8m3gNGeFTXzncUvEXMrqJmssUz4gHs6VvTdxkhvqO56h74vUrS0+Ruem6zInHse7Fbra5gN6SyhbAnpGf2DQrW9BueUy5g7djBaS08p5WAYdTIr1QQJXh7UQt4BIVd2kowb+5x4qoJf3GEtNTYFM24VgXR/E22pIkD0kPjEtlYqWz9HufE/nlnmDNHpUbPOHtQKoqYDCqC/YPJSRfKwuPw6mhUk9mnx6xyxPGb7Zd1Onf3VRRHpyIDEJy6tFraz3ROfobegUW3UIpDcN5D27w8acYUHs1ILQoEfxuU6y0S13dLlyjSN9qZOGYc8SLXXKw4ECv4ldaQOXuIX2CC/8q9k5r2u87nEn63s7diI8gsXCMT859I4i1xpQSOnLmyowvc5BSClWO/GD+S8jxFWLPX8YIWsbfEIT82w4LZGpONJ6vtXdnNF+/nZQRimsGO7mo8L1PCqVBL6hcSbfuhAJVG0WH+tGRu8rmZ56tmoApZAymUffITLfi8eDmzQsVwtDeTQMDkEvHzqa1CI4ybjdr1WTgrruQNX8Tg7RMjZTBGd9P4yFffqLigtYQxi5v3ama3t9snAtTXTQ+lUG3tKPPYvrAEJcaS/bSbzJWZl6xZ+USZvmALyV2gC391U/le0aL+BzD1bAW7TtEjfzTt/sEcZxDki0ng8P2D5Zf7siWBk3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5402.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(33656002)(122000001)(71200400001)(478600001)(966005)(55016002)(38100700002)(86362001)(52536014)(83380400001)(2906002)(316002)(9686003)(66556008)(186003)(66946007)(8676002)(76116006)(66476007)(5660300002)(66446008)(7696005)(64756008)(6916009)(6506007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pw7Az/G2Gsui6T9nlrOtz7OZrBb50f4A9sJALYJGjFvL3tI1/IXxxJv+UtWo?=
 =?us-ascii?Q?W+eF3x7eB+nDcyCd+4f8gnJma30yBhZuN4lkRUnFybahhjIbHbGOYnFgsmBv?=
 =?us-ascii?Q?Lqlhx2RPDwhb7tYNTAhg9AHR6oAbRrJCq8rJp/zvMb6zCFu5Nl6g6b37cqDp?=
 =?us-ascii?Q?VrHQTkwBhgsj/v1hnxd89Cym0ozNdPSpohF9RMb6P33r3YRIj7m4Ui9Fw2Gd?=
 =?us-ascii?Q?BSUfFQQu7AxM5T/uoAgzCfBgYCZ0cjuW8+INmzpcDoeSHLzcevgAemVFWS6b?=
 =?us-ascii?Q?pcap94jNMtNiRNV50az1CwKR3JDtfs8+SdmaBPOjOd/3qYDFXFErInqqorS1?=
 =?us-ascii?Q?FB8pQ4qZTAvKZCp3I13xJjhfDIOnyHvHj8MnUdoxkjSRDyIlBJ+Qg/oVmUsv?=
 =?us-ascii?Q?uHrNSlpFPqlifgEW7QdahEdQ2vCmUk/gacwIn6VgwaFerLaikHFNBjHYHos3?=
 =?us-ascii?Q?FuIC6YKt5Y1iNEhqnw3UUO+fj+CnlJqQTCCg3S1iQLOFbGubDeN4IVV9kmXm?=
 =?us-ascii?Q?zeKiWHdKaqSW1dzGOXrN9QyrdgbzNnf6ywWvJSI/8lgFtCakEt3RnFDP+C4p?=
 =?us-ascii?Q?ixvXAiWRnG72hVeaN79OJBiJgLZp2K//xXP+ppUcTQeiHSzyFsghlG5m8YE5?=
 =?us-ascii?Q?iiqL1mVa43oxinyqFysucNaeLz+omyPFFzOGjZT3EeRCzienC5pX69J4/fyd?=
 =?us-ascii?Q?veoxS5KL+LOYMzV48LfCHR+ykWTLINJFIuJRK6BGjgGHr+LO2VZ39kUzPNjs?=
 =?us-ascii?Q?vbj4GjC6qNTuHJXVVC03rmZBwK2li4xKvqU+wwoveJmp21pRjk3O5zw4IGn8?=
 =?us-ascii?Q?XLy7dQCzaHEzT96PSW8KaQqsvW5S4ts5dmCvkvil07uSFm1/VNkVpepGOdi/?=
 =?us-ascii?Q?y35W5JIoAkMOeqfiizFO/2hmpon4TKNGXTkoWggbW4jks4PVannf7TsObCMK?=
 =?us-ascii?Q?CFtcGW47loWhRKsvj+I171eMCaPcbW8/FcdOGGUigbCfkBcTZg6b4YRazyxh?=
 =?us-ascii?Q?wzv/LhgYUYGSXGjnyER3vuJz4dO9EOHBWM50JmKbpOQayi925YWsfziYrK/u?=
 =?us-ascii?Q?yOdrSgnvatF+gaJs2bqAry8o/9i8oe7wi5cdJMzr1ocerpTYoiHdEo/jVa11?=
 =?us-ascii?Q?EDaqoQmnKUiZU16z4SztGN92E8yYTeUIQgPEokS6xgs5Z4xRIxbIZLlcRtpl?=
 =?us-ascii?Q?VzIWDM22DDR+Eapv7FNH0H8sFSN86aOfBeW/CCRMH7gWgelVmbNh7fETjXV2?=
 =?us-ascii?Q?PUpCKiuJdADIhqU2kiDW0JUpi8tjEVUk/xVprEgCRJgcYULeptEJmrYv7Sjp?=
 =?us-ascii?Q?SwpDe9hxks8sdaw7/6GFU0HiKrH9dVV402paZ3ZVNSuNzg35lVjwTBGSmY/2?=
 =?us-ascii?Q?mPu13H3AkCxnBcPA7mKEOCZGkl6j?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5402.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c2634b-c49e-4856-0c06-08d93974b6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2021 14:06:09.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjtTvfBWHoQ1zaXegmJMeHZFyxSPkffb8isN/JUpevWN47CxQNUjZzeqP+/pOp20UUWplyMyYUt9tLpoxgdHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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
