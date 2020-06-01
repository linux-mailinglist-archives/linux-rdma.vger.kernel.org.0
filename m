Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3F1EAD1E
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgFASmp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbgFASmn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jun 2020 14:42:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E955C014D07;
        Mon,  1 Jun 2020 11:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfJLrSyLxNmlceCDPC33A0z38cwgMHV5FW1MZx3Hx6hNCfABV5IRW/IgxykRfoO23vfoNs45embHoQiaADR3DbeVC65owFR4MnPkMo2ihcYxiyn1cae6aBoEX6SPmscaZdNGIkJPzksBeIXJvnLHfg+A+9A1y77gF0p7neDyHOxLD3wJdQ+Hix5Xh0OJ4AV8ZKJPpcMluOoU59V8MMHjyuURFuVwRhp6BHXDXk4Lt0zUsugaSIof5LzY1aH9NVaR65wMu8QDr5lONsSrCzajuAKs7tF+5mTsZXktuXcFVfRVqdnpWTkbgfdtV0SvQVePsRgeWql7ZoOdLss2QTuZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb1Z37JItJ4MxQfRyKXUbHU1AvTcxqAzLq6uQ+8sR/k=;
 b=eb9wf5cE6wOfq5wObh4lJj/Gqdfauym/gwNEE9DQk4zjupl4hAwectxr/2xdFCquBfxf0GzTE6ynkdrCP0eNJrhY1/zKe5V0wgX5oeidIDB/NEdMaVqo68qFCYFXqfTOcNmcZPy+PpOwqY/qwiusqr2PeB6/UXRkbtRyGXU1pmZvpPArBxUwHT5EKvnVe7WmlKXK5vcVZWyCPeDZy75KELRdi7yttK/eAKv4aO1SLOK2V/UmMG8Wk1R7Lv1XxqaqaYygXDK+0YuiSP0Ik75OMZva2QGplRwE0DLGmgwLTLDjT9O6mIVs/z53/8ZAEu8FHSVYo8htg5V6cSSqJZyQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb1Z37JItJ4MxQfRyKXUbHU1AvTcxqAzLq6uQ+8sR/k=;
 b=PjSkyisnvzRNmaQBZz+g+ZvbTVUaBq8PyzijrGbDAWy8tBwUBgHOQY5pKtW/X1jFHzAC/KrzC0401EwZTuwhCWT5zsLHFcXfyMKD+TU535eFbfxqRlCb22Rs9i/u9slYA+h0HyPRWSw2E1dRFXNBS+KiuMH//0VY9LKnb6SS5q8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6734.eurprd05.prod.outlook.com (2603:10a6:800:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 18:25:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 18:25:55 +0000
Date:   Mon, 1 Jun 2020 15:25:52 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull hmm changes
Message-ID: <20200601182552.GA28020@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:256::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 18:25:55 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jfp8C-0007Ri-G0; Mon, 01 Jun 2020 15:25:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78eceb9d-849f-4e56-428c-08d806593954
X-MS-TrafficTypeDiagnostic: VI1PR05MB6734:
X-Microsoft-Antispam-PRVS: <VI1PR05MB67341A15E6E43FD8C15549A7CF8A0@VI1PR05MB6734.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnDjRkkeP2U6pE7GLjtYRb6zEBjhhLH1Qxg+qS6XWs4ehz0I5MLqPP2uE8GzzNwjTo1way5tP8poD1rkVXJWuvGNb9um2Zwf47kwR52AODej0RP31S83chYAqemRoDssMqVnUPCq3nBgkTnqVnGqYWQBtfbxkOahe7VCYk4rJC/rTdeSo/SUjJvkM329nafpILhFcwbCPyFbeRaZ2E4PUaZVR/fPiu+MtgPlShqwjtAL2dt0xYUA2fYcI9XudycYAchICVLjBeqoZ84bLL5TRVbcf7H9m/9d2CYjcN3xF6lQ0bVYBbB53dU3P/YIqB7wv96d8ljGXsBRgeUUA1QxwAPeb1PfxtPzhgnAQScS88vmlVpN6w6o9MO/Hc6KoalyetJr4NLcJUiYaOdAbMBzb9wtEZQNyXcllXEkkFtAnL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(9686003)(2906002)(36756003)(8676002)(26005)(8936002)(83380400001)(316002)(21480400003)(110136005)(4326008)(66476007)(66556008)(86362001)(66946007)(5660300002)(44144004)(9746002)(9786002)(1076003)(478600001)(186003)(33656002)(24400500001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /c/aKx/bk/GOp0kzOlqRqQ+RhVVxFsCD1A6ctK6nznC9JIirEU+qKunnTyo6T8LoJF1HuwD04mSUwTgU+fJCrMIQRI6bB9oCFRhNUF6I5HkpGCIQ2FQhN22yYY3Hmd3i/6OhvYJscKsxMCQsMcoZYrwafw+FY2jqazhx7shLmm086P+ytFEINjt66H+Wfo5h/0rT1HihIVuPnty8/9dYz/tevxq/IP31LENYfao7IeTaYnBbJcBt8RuPou5XKjqN0wWh4Z6ZdBPEdKfjHiClr+nJu2V9NMkwb1HQOsCwAmiHcgV9y19xfp5YrKu8jqio+UuM0+ySdlJq7jNMk0OWYt0dMG6Vd437vSzD8ZH64n1UHDyGCZ7EyvQdS8KpWx3rifY169MPQiFULJsBmTMTYzmYs8vCpqEMKd/BlRSlEmdhshPIMj99n23vYXT4cRAS3euJA4eu/b3rUKIZstxcZ8XO4aFRqDYvc/seG5SSi0k=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eceb9d-849f-4e56-428c-08d806593954
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:25:55.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: foelGNbfoGVuCSFmhyVQUAUkX9Cwb4cVatuwmzFKrSssPqSABQa/uVwlaOFbUoTNV0NWWc8tPkzhrx4Obwg4ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6734
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This is a small update for 5.8 mainly including the selftest from
Ralph and finishing the hmm_range_fault() simplification started in
the last merge window.

Regards,
Jason

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

for you to fetch changes up to f07e2f6be37a750737b93f5635485171ad459eb9:

  MAINTAINERS: add HMM selftests (2020-05-19 16:48:31 -0300)

----------------------------------------------------------------
hmm related patches for 5.8

This series adds a selftest for hmm_range_fault() and several of the
DEVICE_PRIVATE migration related actions, and another simplification for
hmm_range_fault()'s API.

- Simplify hmm_range_fault() with a simpler return code, no
  HMM_PFN_SPECIAL, and no customizable output PFN format

- Add a selftest for hmm_range_fault() and DEVICE_PRIVATE related
  functionality

----------------------------------------------------------------
Jason Gunthorpe (4):
      mm/hmm: make hmm_range_fault return 0 or -1
      drm/amdgpu: remove dead code after hmm_range_fault()
      mm/hmm: remove HMM_PFN_SPECIAL
      mm/hmm: remove the customizable pfn format from hmm_range_fault

Ralph Campbell (3):
      mm/hmm/test: add selftest driver for HMM
      mm/hmm/test: add selftests for HMM
      MAINTAINERS: add HMM selftests

 Documentation/vm/hmm.rst                |   30 +-
 MAINTAINERS                             |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   56 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c  |   27 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.h  |    3 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |   94 ++-
 include/linux/hmm.h                     |  111 +--
 lib/Kconfig.debug                       |   13 +
 lib/Makefile                            |    1 +
 lib/test_hmm.c                          | 1164 ++++++++++++++++++++++++++
 lib/test_hmm_uapi.h                     |   59 ++
 mm/hmm.c                                |  185 ++---
 tools/testing/selftests/vm/.gitignore   |    1 +
 tools/testing/selftests/vm/Makefile     |    3 +
 tools/testing/selftests/vm/config       |    2 +
 tools/testing/selftests/vm/hmm-tests.c  | 1359 +++++++++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests  |   16 +
 tools/testing/selftests/vm/test_hmm.sh  |   97 +++
 18 files changed, 2934 insertions(+), 289 deletions(-)
 create mode 100644 lib/test_hmm.c
 create mode 100644 lib/test_hmm_uapi.h
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl7VSC0ACgkQOG33FX4g
mxqwxg//QSawkEBetOUnPo6rddLis7J7okzg2YjoUDS+AxQ+ju23YvDFX7c57T3z
FTfwTVYifhwDi99A4hyCrw3jgCKULa0bm7G6yuRZuuDPMd/ZH14ZT+S2C4Q8ge7+
sy6OYbUmebFtG8Vpwb+LfS8ELNyuMKcSaoPGyKPY9RgNCnDaJNcCEev1OORWgyRr
c8XCTMe5GjcByOWRhVD5BPQ98pcH6Aqqk+jFDgst2atsFN8bt+alaVpJUie+pJbi
iIkLU1dcS3BNEH78UA5p9be3hpff34aSvNKUHsJ03EBmM9I4Jls3MHSYEs5qw0YA
xVPQ7loRr433ulkPwaIN6rPQUxvzHMQCXasV64hKmEzBtUrXL9oBhYQrUjQQsfpb
x/uW6brOaCaIbxbIU5OnxYfuCQ/8TZfjeFc6FHmLN2tXzdYstnpYnBeIWvlGGy0a
qDHrExBoKj7qEUdQ2SPJcQkii8bD72E4Szaw+7tBh51otSCS2ACvCQaVUNNiqUyC
9Qf2N0t7IVXLjPxSNQlPAnAxGkUK7JynIOppF77dgi1+xF7FaH3KFoUXiO1hJUVQ
eLXKf2shA5LqjenaUimz67750b30OC6BDJFN5MXL9M5ZB36gqg0ZeNRlGRProdEC
xO/1hFglq1QK3PSxj9frT+f5lAq9C3k1lHevYvqDLtQLRqwBWKE=
=9cfe
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
