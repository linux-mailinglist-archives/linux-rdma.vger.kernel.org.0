Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A526558D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgIJXiT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 19:38:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:46671 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgIJXiS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 19:38:18 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5ab8e60000>; Fri, 11 Sep 2020 07:38:14 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 16:38:14 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 10 Sep 2020 16:38:14 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 23:38:14 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Sep 2020 23:38:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+Pm0KYnUGWFGoiMnORnDAIXRM5BfkPwbnzWasEzSIqnV+r4Coh2A8PgkEfkM5RSxbv7vfebCbUTCuiit3UPy/bPiLozyuwZrmSSnea6KcfoQ+D+OywtSAVwZntcuQcBIkF+AIn8awLrSTNpZS48fwwv7qxcPbnNRYllG+wf/8mnO346nrYXMFZGIxGUMBkbXf2O+yRrgIFyo2JCZYbswWJBmqaAMZS6D2WbNxwIaG/rL69WyoZl7p2q0QtjA07W8dGBh2riZ8RZXA2V3Y20X/YS370oh2p5BUBJB6ZLwTksYH+DQCdlQSzig8ygFGlsFjIM2YPs6fkyG+08X+BMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsuT8EL63dGCcf1TOCgKmE6xt/I+nLh3hiG8lQOv2Wc=;
 b=Y/DUwCmR8o3E47pAlXAvL/eLMlsQXFjXrMGbPl1DNH2uOQ2X1cQcfraySsoECRFOMkBKh3VN1Eh4P6gryST0DU1fCLR3rkh/lP1G2BtoiqD9uwvHvFbKzFTd2BkuXJynwEcY0FxtkGoV8tXf14fGhlccSdt68JM6MxA8PugM8VRsosye+udPWiiMEuep7uiszwwLixP3S+NLqyKbqxB/WtRLKnrZK/x4U/fIAWfuBJRHDrc+eFpM7PKMURTvhjFUlCO2osLispAbr2PEhctpK6+eePcb9YnCCpv0uwrnvCATzAxHbdZ4smIA3YjdSt/FB5oLMVvafaL+lZwYpuyUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 23:38:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 23:38:11 +0000
Date:   Thu, 10 Sep 2020 20:38:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200910233810.GA1105033@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:208:e8::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:208:e8::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 23:38:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kGW8o-004dUo-30; Thu, 10 Sep 2020 20:38:10 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9882b7-cc61-4f3d-b539-08d855e2945c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30195A620591E6A3014CB9F7C2270@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHjOEekgsKZtev74MPLbJGuKBiB+SDcJv21ho9r5M9KaEUR7h82Ve6m8O+nhgNE7a8fxBfK44TSeyJfNQ3NDelXWtGdQ4tV7ygdEIAh1/OWtqVVVlV4XlPvJoiCXP2h9S/ooLD8YYJMPnq/qtFnH9MO9CJ1FywxzqDlvUXQS66JzFgbaOa4sjOnMprX2XOiTh78u6C6NHz+IFzDInkWAZeFKHSlsinAH5HwX1VYgWVZhwMfFaOdeevRAMvDpJvO9ZHNx83nfM/B03lWtDaMqptBetrhJMBSi40TPyMsKhhyvfxlKong56TVC7cC0mvjKKfmfWHdW+SkbCPnFizwJduueMuE+gNVFmWFOwBPpE9lvC8BWlR8XELnxpQRmNj+g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(2616005)(66946007)(66476007)(66556008)(1076003)(426003)(5660300002)(2906002)(316002)(83380400001)(4326008)(36756003)(478600001)(8676002)(9746002)(110136005)(8936002)(26005)(33656002)(186003)(21480400003)(9786002)(44144004)(86362001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NMXoCt9qy/hfKMQ+pXeiy81nTPk+sLPqZweV1bjv72rJsKOiZebwMDA4q4m7EK/qMcqvZ6ZqSY4wsckv2eqNJAsydi7JzPc2zSIUNOFbaj9MdSbzAj8ER8znrsrNSFfQhwrXR4Xvgb97rKDB0GvFUi9H+SCWhV85OB8bYf5aEnd6v8JtCmInh6KTclrmo+pnazPQKzJhnb2XaiusrKHS/eGZyOR+k/xDUDMdMiO7vIulflABlP9yZUFs3nx7em7xMwwGGn/XgG140DJA8PNDSDcLis7joKXwWiTSgb0ECX8RC38CNIC/hUdh0hLeRNOXoBFyWXdPxewIGSFfBjPkjz9pn47sjxMn6avysblY0wqrgOMth+fIfaMnbhwWF8UIEZ+U3Bp9S2+To3cvfCvFhiqGtZ1hYmVp9+8D8ugHUVy6tSK7RgNM8fgiQLukNa0YHvAtRMXeizN/LIvIiVt8jEdTf5oU5WU1My7yl+LU4vzXJv8XNxjMOUNjMB5US6Kl/SypOV2CTo7lGyLE+PEkQtQjs6DlCPS4k7RtJQS9Qp11X22nfWKeGblTMB6Ep1nQAktc3TaaJiLm6CvnmYOiqo3qw+NPbHUrMMUrR0pn8HYQ/5HkJgmSGI0PXgk1mDZDQeT65Y1PfYBfDWQ8LGHdYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9882b7-cc61-4f3d-b539-08d855e2945c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 23:38:11.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9R3S+klL1LQIB0gjs9Om7j8WGgKTkx5VIpUpwog3JGrcXfsINB1ZT4Gn4Ityv9Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599781094; bh=QsuT8EL63dGCcf1TOCgKmE6xt/I+nLh3hiG8lQOv2Wc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=bY/7odTXGtA5GBrvaU3T+KQapMhn+cjNTjjYaiZlWbfFKQCv42GuLsnU6+2LaoOQy
         5AbrOT3BN0N+zz/XMZUmGu4DISN1k3Lj/2Qf+r6KbFb+/qKTDulRE52GTRQjfnCqiq
         XJhnigAdwuH7ctr9vJdagbxzfruy/TawvxjQM2DpjKKtwHNEODxo1Nt3YvM5gQoMIR
         AJQWX829pjl64CMk4JmsbxxHPHtrEJhM+Csc6ZGqdiJOTO81On4D44v95oTdjG8A9j
         AFzJxIikwtRoqhGdWIJpfmdeKIhsxjfA9u1c3ZKEf0j3YR9dFus1VoLDt+4TBFbiE7
         ai835uk3UWDbA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Another small RC update, nothing too interesting, 5.9 is looking good
so far.

Thanks,
Jason

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0b089c1ef7047652b13b4cdfdb1e0e7dbdb8c9ab:

  IB/isert: Fix unaligned immediate-data handling (2020-09-09 13:46:03 -0300)

----------------------------------------------------------------
RDMA second 5.9-rc pull request

A number of driver bug fixes and a few recent regressions:

- Several bug fixes for bnxt_re. Crashing, incorrect data reported,
  and corruption on new HW

- Memory leak and crash in rxe

- Fix sysfs corruption in rxe if the netdev name is too long

- Fix a crash on error unwind in the new cq_pool code

- Fix kobject panics in rtrs by working device lifetime properly

- Fix a data corruption bug in iser target related to misaligned buffers

----------------------------------------------------------------
Dinghao Liu (1):
      RDMA/rxe: Fix memleak in rxe_mem_init_user

Kamal Heib (2):
      RDMA/rxe: Fix panic when calling kmem_cache_create()
      RDMA/core: Fix reported speed and width

Mark Bloch (1):
      RDMA/mlx4: Read pkey table length instead of hardcoded value

Md Haris Iqbal (2):
      RDMA/rtrs-srv: Replace device_register with device_initialize and device_add
      RDMA/rtrs-srv: Set .release function for rtrs srv device during device init

Naresh Kumar PBS (3):
      RDMA/bnxt_re: Static NQ depth allocation
      RDMA/bnxt_re: Restrict the max_gids to 256
      RDMA/bnxt_re: Fix driver crash on unaligned PSN entry address

Sagi Grimberg (1):
      IB/isert: Fix unaligned immediate-data handling

Selvin Xavier (3):
      RDMA/bnxt_re: Do not report transparent vlan from QP1
      RDMA/bnxt_re: Fix the qp table indexing
      RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds

Xi Wang (1):
      RDMA/core: Fix unsafe linked list traversal after failing to allocate CQ

Yi Zhang (1):
      RDMA/rxe: Fix the parent sysfs read when the interface has 15 chars

YueHaibing (1):
      RDMA/bnxt_re: Remove set but not used variable 'qplib_ctx'

 drivers/infiniband/core/cq.c                 |  4 +-
 drivers/infiniband/core/verbs.c              |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 43 ++++++++-----
 drivers/infiniband/hw/bnxt_re/main.c         |  5 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c     | 26 +++++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c   | 10 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h   |  5 ++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c     |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h     |  1 +
 drivers/infiniband/hw/mlx4/main.c            |  3 +-
 drivers/infiniband/sw/rxe/rxe.c              |  4 ++
 drivers/infiniband/sw/rxe/rxe.h              |  2 +
 drivers/infiniband/sw/rxe/rxe_mr.c           |  1 +
 drivers/infiniband/sw/rxe/rxe_sysfs.c        |  5 ++
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  2 +-
 drivers/infiniband/ulp/isert/ib_isert.c      | 93 ++++++++++++++--------------
 drivers/infiniband/ulp/isert/ib_isert.h      | 41 +++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 16 ++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  9 +++
 19 files changed, 168 insertions(+), 106 deletions(-)

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl9auN8ACgkQOG33FX4g
mxpDSA//ZA30+8Uw3fG37eTox7/ecWAgkV5YADHzur0KNcqRZub/IGxq+7K1zqZG
zNYMLqcB0Qvd64yC/n+NPDOyHD5is2i9XUBTypKzP0OOsNV+E7+2W9LdHLgUbDcp
OxJQQ0YJadnXOeRqffRXlEHc+itqApYgcfPviXarDzDzChpj7DMHceNqWHgEnUV6
Y77HA117Gv6st9mN3HcV60ivbkSvrBmx9Bae5m24fGSq07QvfjMXvtUjmCDkqVMo
hMN6hzTTwgzSmuZmZ1CfUwwyhtfI8EOOzNYmzUKJoWsOp3kLK4I7qutmYf76znfD
Yf+2ZUhK0BNHdGPfow6DjfRiQDAlfBaq2AF2h/FQ6tLpXdcDdrENXwsFkrp8T7+b
lU1l8uoJSscjbE+GVZaYO3YEl2g1b6Y8MkDv4VxIcHzIHSbVUYiabU3uW1vsWuzO
nFNUdcasByCsX2ll8yimDwkrepWzrAGw480AVvivdZMhNDWsTM8tj647pYL295Q/
+Dw88yWpwIsqrlZ9XI/UKDVLkNV9D7xDaufKd0U7owtP2O/gwdylKRLCcBH1Lree
Ck5A8MCeDvUid4Ldzp8PjgFIdOWi2ODtyG4DVPwrppSi8cCmnd97REEvO+nSVD/r
LO64OOlcjQcPyNKvDAZgVekClGQimeKpsqNib/RsHX6xUae2x/0=
=OavR
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
