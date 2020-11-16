Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB03C2B5243
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgKPUQV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:16:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11998 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgKPUQV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:16:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2de1f0000>; Mon, 16 Nov 2020 12:16:31 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:16:20 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BL5yl1JTpqUkrPqD1M3U9wrlnCLhF2k18VZrqHXPH4XwF+HA1aJwz63yEZ+hJBzVltcXARk7P8TClY++78CkJ/AuBk4Pqo7uln1z9u2dEzpU7982zHi3dvvvO1b1p8nc1ccUTAE88BvEq9HbynxqmWRHaBC/m3k+Z7BAhnybMkoz35j7XmfSrJSJ3/E6IhsxXk8fNc2jSLXhjaHnY6PJaGXL+GOKFAHHuHPCjLrOrL3XYfw3P4hcv5Dwxwzb6v1fptFbbYvi/iX3oipSqeqCf35TNKnXT9I7rJ1N9Sa4PyK/rus/I5Y1tg2zA9k3tmTNsbBBN6ALndSnnru1/r/s8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp7/T4gYI7eUrbuBdjhrqlZ/yeh1ubDB4+EDh7HX3/0=;
 b=OSJA4uMqGkql15oBykX+/JrYle/+HItXnOTEBegf0OOTTQxxbr+sq+92coIWj18rtNh64oKV0oDS/2RXFcr2rWLpC2jy2arqbqqTn/4fdh44euL75vaH0I/1i2Ye4/ARMvMe5v33PY0vWECpbeSPjtwBDBasvXW6+DMJeZs2PjUHJ9X/RXsxqlXbuZfHa8oj+AoF6PGMeVWc6MppJLa4DyR9lHfFPYqyi5Sezkr1kRkzL4lG1G4BlH4k+jMkRZJ2IM2jfVg9qRANuX1H860pCimm7ax6YN67ca/YutH/8m7BvY40GNKObM8tQZdGh9wk8igmrWyAt8/T6o5ITX+ftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 20:16:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:16:20 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: [PATCH 0/4] Enable LTO support for rdma-core
Date:   Mon, 16 Nov 2020 16:16:12 -0400
Message-ID: <0-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:16:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kekvA-006km4-Kl     for linux-rdma@vger.kernel.org; Mon, 16 Nov 2020 16:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605557791; bh=9u8pQwrJwgJ91LLnxdvIA8OIGEv5VktYbD1nUqwpFOg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=o4+uY5BiSmMZklYASvkYtpiPI2iWZ+nlw2jrMYb/8Ld4zFYAg+/Ty090N0scyzV/a
         oZFthXvh/lEthltyZ5quqtJ9TCZJjsQ9OmAhtSBI5RP342BHSlRTeKCFoov/nExohN
         6AuDwsbi+tO1fwMANbfwDE3xia8InEi/f4N6eC54NehQTdSqiTQOaBjhzIpdIfUF29
         tHzzTViSjFeT4fuGmyM0bj3qh3Ri0OnfDrQSOjHa+GL6Mj0u+REiYIPnx2z7Ge0JXP
         gw4kRLikyd4+k8kuLTx5ZI2ODJDBE0V7GH4QFvLysoWF1l115M7Ho2PsNEUbcu95nh
         JB1JHNGRafQYA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

GCC 10 finally has the function attribute to allow LTO to be mixed with
symbol versions. Use the function attribute instead of the top level
inline asm and have cmake deal with all this. Remove the LTO disablement
in the packaging files. Distros with GCC 10 will be compatible.

Fix several warnings GCC 10 LTO spits out so AZP remains warning free.

This is a PR:

https://github.com/linux-rdma/rdma-core/pull/880

Jason Gunthorpe (4):
  libibumad: Check for error returns in get_port()
  verbs: Simplify the logic assigning vid in
    ibv_resolve_eth_l2_from_gid()
  iwpmd: Always copy the ss_family in copy_iwpm_sockaddr()
  util: Use GCC 10's attribute symver to define compat symbol versions

 CMakeLists.txt              | 13 ++++++++++
 buildlib/FindLDSymVer.cmake | 28 ++++++++++++++-------
 buildlib/config.h.in        |  2 ++
 iwpmd/iwarp_pm_common.c     |  4 +++
 libibumad/umad.c            | 49 +++++++++++++++++++------------------
 libibverbs/verbs.c          |  7 ++----
 redhat/rdma-core.spec       |  7 ------
 suse/rdma-core.spec         |  2 --
 util/symver.h               |  9 +++++--
 9 files changed, 72 insertions(+), 49 deletions(-)

--=20
2.29.2

