Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB641D0C9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 03:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347215AbhI3BEU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 21:04:20 -0400
Received: from mail-dm3nam07on2058.outbound.protection.outlook.com ([40.107.95.58]:54203
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346416AbhI3BEU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 21:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHNiKi+FGRlk9mFCJeg5cz6d4FCLbtBwCdb3IRPjPFIVIbtqTiyxWxDn4mP9ZoPD2/Q7Ipr7C9FvmR6HiRU6WLDNL4XrVspe3fycdGxr1b0gQSCdlcp7tBVSZm5R2aEHEsJOliFoukhmHy6SyVMAmGdXf43ONojuqD0Wy2xwjuQjuL8LdrwgXoQivUWkiOJhwnKczzorKAuUaus5Q6rIN5Im3baK0FVFeCGhzhxAZP1Kqqb/E+UmsrPrMEfBbR9hoB6/KRL3NAoYuaQ4DsgFD3sN2sanjHrKg5HxUv2fgsCrtfV1fg7WyIuB4PCztU3HQKNNZtH5hbUeN2GIGMgfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yfR99soM3VImsdg9E/mr/UiwQmpXvTFFz8B7NzPZn7M=;
 b=hdH0g4vAMsShGeV02sd/5VaUfbBdqxN+iTePRmDfAYJQQ613cMmhRiMtORVw2n/g++zH2mwR0ktli337z54F/CfSDMrccJtX+9hlLReIa9S4v24AABPX34CEi4QMyDpcaGa3awmWtgrZarIrvEurbg5ip27PvNg2ff+yxjTGDzTevKZDp0TEdQS9eg0AhLEpfJUNbh2v2iGNeY76CQLdI35DTWEzbJJCT8s5ThQuEw4WUiM1KLr9+R/ej6/BOwq95VRt4wngv1mbIpnZ7HCNozKQMVewiDEhpnAq+19MRFytHhfzF+7qmevzOkdxX05OMgy9o3/nGaJOvyIbcrIaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfR99soM3VImsdg9E/mr/UiwQmpXvTFFz8B7NzPZn7M=;
 b=OyURV1B1t6QBfg6Zv/WqyPYiqytRAucPwvfsTxCHqVbAh/CPGcRjURL/nAedMxI2mcX9Mhl2gym9S36TvJjBuIsXW3fm1feWAbTLndoYC0bF/IBsZSfEPSS7cuWGGnVCQ9KEAsICGlOB+LQGUkG7hlm/SVIICPrYuvA5F0lX2mrKIAsb/JlH7DKQuctKbCDQxOgZ5zmYY58IQwnl//I8hfoVIn/vbmD51fe9+eCjdq/U49deIn5D8m7SH0+frhNcekCZq2W1GqDYMWbuofV0+DscTqKmlxMRphXnSIQdiv6mgGV+KhookAqCzmLp6hwKY7SdSTB8VdgWQ/VfZfcYmQ==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 01:02:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 01:02:37 +0000
Date:   Wed, 29 Sep 2021 22:02:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210930010235.GA1888324@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
X-ClientProxiedBy: BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 30 Sep 2021 01:02:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mVkT5-007vGP-JB; Wed, 29 Sep 2021 22:02:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e5ca3e-f670-4c75-08fa-08d983adfe3e
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538B7AB4F9269A33324B261C2AA9@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fq1qn/hNNOU9qAIxaqST77XcQLF1FGYI7p+ONgUXu5aASLtIcBXqRguLA8rXVKjAhIXexQmHAJEs+THwE71DKe3/Ph0nSlYehHrl6qtpKT2Wxc5Pdsc2bf+IKbl/42akeAQf38tTiUrSiS4DgauuKE2rjRgmgT66Fgb2Ho8DaGWmjhb+pZGe2nu2VYJlA+N5wZKxT83rzTcA+Y5kAPRIqFu1q6/Ib/eXMKsNEqxIAtMF5+lli9A7de8EhUXhowFwnB5YjaN82YA0ZlYL5BEI/6gZ0HrPKCNSnVVa6rMw3HJCDLYTBf00xi6vEyZ4RqiHOgwHtFIvKUocIiuFt690lqMxRAMtiLAIH4DytUZKsd4M5+ozT/G6/yw/WBCRfIIRwKxJVB52XzgwjXR50zLaRz+3e5mROn69Q+plQmrvFnBr0GxBATnNg2IcKcySt7ss5WWet4skoSZK+GBN+9FS7RgCLv1NLVOUUHpCOiHJY+qpZHq9ZfFrAiISWqNIEJ3465zQZacc7phCaRkJ7upnrsnAo9i1bLfdHp1vVnmTeMQUVcTLC3krvejGZbNA0H7r5VFAFUpMQ0mgpTwlttHrKi+oUC61eyNm+i9sLtylEoqm98jl7VIcbc4yAfTOOmArmaTr59f8x46jEYaLLRJnaSAtFBsG7HO1EoBpjD8jjX3blSjLV9ihLyMqL30S3k/oF+9ivD6/uG0zFIbHA45DuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(9786002)(508600001)(83380400001)(5660300002)(9746002)(36756003)(2906002)(426003)(38100700002)(1076003)(8676002)(21480400003)(86362001)(186003)(26005)(66946007)(66476007)(66556008)(2616005)(8936002)(316002)(4326008)(110136005)(44144004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NslL6UYM5ClvPJ2jSMeC6d39T8iw0jOF6w3IDMfp/DVnbPmShskStsir0JQw?=
 =?us-ascii?Q?ShBYo903uQnP1fWZUuZgloPRG7eAKJIFcKBzZrI2GZR1ZuK2/heZkQDlGeee?=
 =?us-ascii?Q?6RP8ElhZCcrr/z6pCkp7D0IgsIoDRJO3CSDz70pzAX5WQmnGa/rZbbsD3nko?=
 =?us-ascii?Q?QjurlvcyZoNkc0KRSs0NX2fVmv4QBKMgCv47xstaUqC/jql6/AJo/HOmFqsI?=
 =?us-ascii?Q?Se1Q3NEJaDq5AmGk3bRXhKL/kECrUL93kZU5+i9lzbjL4jB5QuCQPyKbqNuc?=
 =?us-ascii?Q?jMeDPiqCMHC0/N3vBbJD1c11pU0lYLAo50bUaUhTQ86W/ypdtNi96m3P4SYk?=
 =?us-ascii?Q?v73k7c79VZEhZSfXo8VwUOyaS+QUye32XCvmrsq/Ym3vS+v0Q9urAx2yx1I9?=
 =?us-ascii?Q?0jPUq3ahUnESfD9E1Q5O8WtfZXkF7+07Eg4onDFkQlpr2N6g2+FtugAKU1XK?=
 =?us-ascii?Q?8sTPVATzXB1bRP5zS19BdcApAeq7t/gM7BhpBKb8Mu84mvSBDKsXswXfo77Y?=
 =?us-ascii?Q?WKoYgmpQSMVxyHZ3AVbj250MkSDjtykelFce7vAR5kJnTT50PniBsHznRsKE?=
 =?us-ascii?Q?9yuYIrYJanrKcOOYaoW5i3Fysd1YvuPgV2uolQ4bRz+nuOLzvLaGSeqxyj2v?=
 =?us-ascii?Q?nuVQhuWyNVHxzXph3cSXfKr1/bbZgxACbyRNiXC7apuzBZldVaQNHLjohpTA?=
 =?us-ascii?Q?2APzkKZeZiSCR/qbJalWc7CnOxQOA5O0J08SyHVV9KgU8o+5aXX5nuvqwsnp?=
 =?us-ascii?Q?AyJQ4ZveJ1EsERvL08WfLFHqJFmnSjCxR5PrfDg2vkFoOsIDUJjC+oVrB0qv?=
 =?us-ascii?Q?XojTsdzYgYrgPpOveKso2F7b1Iw2XHrxTdAHRhYSUY1PJGQdH1/uuDCz+TMi?=
 =?us-ascii?Q?mp2jMgkuZMPvzkF/x5VUOm9gp3yF3Zf7Kgpwx+Jnsssr5pVojA3r3OWzMmCq?=
 =?us-ascii?Q?6ztN/0pxl/f36aKA+tWG2lHggg0L/Ypsz3AOMtTXX9ldCIo6Yg+mreUNn/n5?=
 =?us-ascii?Q?WGA2tnDGZ/LdESD8otabKrBrGkD3dyYDXLUGGKEyvukI3W5zjYE4/lrMHW6j?=
 =?us-ascii?Q?0zPFVa++MeCppsVjV2FO1P3XhBgzuLh/jZUzbmsFGgIqMYd7f4oaB5M4XIHD?=
 =?us-ascii?Q?BM056OQosvMoQIAZK5hIc+GxmtRQmO/ayfEJIa4y9Y8qqmPJN8rtTyuXoP4W?=
 =?us-ascii?Q?kkamzX++0JgOUTDBvF/is+oCcPnEWNUW9dMtuomCHpv1gFz2z0WohDaUo60G?=
 =?us-ascii?Q?LlsKKdj9TyhflYNk/c5SQONc8yviLN253c4xQEab1w30/XOSaGToAxQSWGMr?=
 =?us-ascii?Q?HkqG7vcz3KmAi+ZRmIPCM3mX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e5ca3e-f670-4c75-08fa-08d983adfe3e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 01:02:36.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbpzmtqM4mzGemNzWP7m6RPuA2hf5haK9tMyaStDztOV37Sju9AIsPoXq7PFUazA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not much too exciting here, although two syzkaller bugs that seem to
have 9 lives may have finally been squashed.

Thanks,
Jason

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to e671f0ecfece14940a9bb81981098910ea278cf7:

  RDMA/hns: Add the check of the CQE size of the user space (2021-09-27 14:49:49 -0300)

----------------------------------------------------------------
RDMA v5.15 first rc pull request

Several core bugs and a batch of driver bug fixes:

- Fix compilation problems in qib and hfi1

- Do not corrupt the joined multicast group state when using SEND_ONLY

- Several CMA bugs, a reference leak for listening and two syzkaller
  crashers

- Various bug fixes for irdma

- Fix a Sleeping while atomic bug in usnic

- Properly sanitize kernel pointers in dmesg

- Two bugs in the 64b CQE support for hns

----------------------------------------------------------------
Christoph Lameter (1):
      IB/cma: Do not send IGMP leaves for sendonly Multicast groups

Guo Zhi (1):
      RDMA/hfi1: Fix kernel pointer leak

Jason Gunthorpe (4):
      IB/qib: Fix clang confusion of NULL pointer comparison
      RDMA/cma: Do not change route.addr.src_addr.ss_family
      RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more requests
      RDMA/hns: Work around broken constant propagation in gcc 8

Leon Romanovsky (1):
      RDMA/usnic: Lock VF with mutex instead of spinlock

Selvin Xavier (1):
      MAINTAINERS: Update Broadcom RDMA maintainers

Sindhu Devale (4):
      RDMA/irdma: Skip CQP ring during a reset
      RDMA/irdma: Validate number of CQ entries on create CQ
      RDMA/irdma: Report correct WC error when transport retry counter is exceeded
      RDMA/irdma: Report correct WC error when there are MW bind errors

Tao Liu (1):
      RDMA/cma: Fix listener leak in rdma_cma_listen_on_all() failure

Wenpeng Liang (2):
      RDMA/hns: Fix the size setting error when copying CQE in clean_cq()
      RDMA/hns: Add the check of the CQE size of the user space

 MAINTAINERS                                  |  1 -
 drivers/infiniband/core/cma.c                | 51 ++++++++++++++++++++++++----
 drivers/infiniband/core/cma_priv.h           |  1 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c        |  8 ++---
 drivers/infiniband/hw/hns/hns_roce_cq.c      | 31 ++++++++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 13 +++----
 drivers/infiniband/hw/irdma/cm.c             |  4 +--
 drivers/infiniband/hw/irdma/hw.c             | 14 ++++++--
 drivers/infiniband/hw/irdma/i40iw_if.c       |  2 +-
 drivers/infiniband/hw/irdma/main.h           |  1 -
 drivers/infiniband/hw/irdma/user.h           |  2 ++
 drivers/infiniband/hw/irdma/utils.c          |  2 +-
 drivers/infiniband/hw/irdma/verbs.c          |  9 +++--
 drivers/infiniband/hw/qib/qib_sysfs.c        |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib.h       |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c  |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 16 ++++-----
 17 files changed, 113 insertions(+), 48 deletions(-)

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmFVDKkACgkQOG33FX4g
mxr9kA/+Kl74rRviiJSg+u3qZwB/GjLDcQiV6BsGeDDI0qCl5W1nRr9QJMdwH0iN
n6yKN+ySmuFe0j+wnpBfPB3jLsV3djvOe+8VLqf096W8gfwY1bHIwPI9aeS8J0Se
0i7qzT5fTToAOibavQC0oR6Tv6H17XGGX2lyMTP5YfGTSZXq+n3bSWJSl52w/Gpp
N1P337pg0jhpZ2RcDFZ/Cc7HwtG054zMgHpGX+XAle15XhYypp4Ks+2b7awck2ss
QxWegT/AnpIjj8dbGlKqNaAa0iJWtbAGTDvjaAPVNazdWoWY1HTB8ip0DsGPl48P
8gnsdcBpwCFYx/Ho1YWUgMvn/qRfT6cWLcedf9TlCgGXajq12d5/tKaMxF2+ukAc
stjxOrGyxfEwcJ9wyhaBzvVxdgaFfJVld2WDL/BlT42oGdjtx10A3rqETm9ApN/f
PF4jnEzOLU25xlKCTjPx+SZkOae/7Z1NanB9M41P9s0iXZg87iyeNF5CGkHrd7z2
JBO9sO9agp8QUso/i/4eSiJ9FCAxl8EaPDOwV5P6FxbS/fyy/Py+JXxmJL0YdQjo
RGe/eIPXdCRonsO0GcX3szlOEZuLDpxw7hZ7S07Mof2ZHBsOJwK1XmeL04GkJ1nM
6iAlPbIgqRJq6B77AErqc86ba8wyou6DTH434zzGUdy30oJkxe8=
=W16Q
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
