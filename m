Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0338675F7F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 22:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjATVNh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 16:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjATVNg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 16:13:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE15C9B12E;
        Fri, 20 Jan 2023 13:13:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZsbgI4ozIJ7rH1yPTIer5GlgFFATBCr2LAWjqe3eRNGEwTsq7KDwAeCocx/qXh7kdzQz3Ofah0UJGs+8+pPjtecCnObkZPm4MZ0IKKJoqqO2Rm6+cH0GlsAzDvLyF/Dm/hwpZA0eG3102DCSbXRxot/f95+0TSlClYLGdYehX9AJ68XuHcJEKdu6sJrX+YPL8w48/KDmaPxtO33XeaxZZ/ETiP4GjUPy8x6uZwkbnmT9Ek2yqTuk6V1cOW060wCbFeeFVrcLApOb9zkhuKnqKJvQft8JCTc43VR0lYOCujOIPqUbfrPaRO2pgOw0Vwhqr/2iMXzowNkbkeBYmkO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bq60pyJiKn8pxLX8dSZ5FnItHCV6qffWoBaOjXHSW0=;
 b=Oorl0whXv1u7RQJK1DPkgOvqpkyhw2jbWPJ0GAIJ3iJdkdSeRx0Rkv1pEk9ppcf+cZFyaE9soNUHnQLVkmkEviWW+Jkm+H2fPmPZx+TTp9A0h88yUOSqz+alUiE7+sdCp7RXijnmMmmOFVX5f272v9yWHq7qmfu6Fhic/RzeLai++BkIYz9+eircgogN2rT90nVYZ91xf3CffMYgV1yp1scjvbeh24H0z/wZxnLfU1AcsKJ6mr5qF/ZZ8Fwt7j4HBmJQ6cCWYhNbt4CAkgIY+cn9AV/T/CjpdKcq86faWSEX4ib1pK86gBoCAa+EMk4T+KDfNy7MKyPQAG8y0Q4v0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bq60pyJiKn8pxLX8dSZ5FnItHCV6qffWoBaOjXHSW0=;
 b=Km+RIu3Qpz1kmrp9CYVy9Lh/Ky91Wat60R4pL5sPu5rnE9YtVYP6PaOo0AerNXCXx1u/ZNeAxZGLCoiJ74l1FLhiFmB9ooVPVUg62QqvZKGmY7DuIW3Cp1ROIx4cMQ5tKmwwQZdTV4d6sJ5WFyMQrttQXX/ck13l3zUu3CWwZnk+htHDzoSf14mjohIQBgRYk/gC7jD4KK5tDWDwZUys30qb6xbUxxpryK1r+J7EzOjgUlmbjbTX8qLUCXEQs9B4b++NBgFx0J1SosmeDhw3Mog12OuhoYbNW64mULkYKR344M6w8rjkZ/0TmrCaAZoHMPZzcXi+glAFbYSkEQHW+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 21:13:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 21:13:32 +0000
Date:   Fri, 20 Jan 2023 17:13:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y8sD+xH7fohazCtu@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Yqk9/plX+V6ZlpR"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: a360953d-d1eb-4e60-8004-08dafb2b2f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZooyT2/vYTYQ8tu6x/n8cG/2YolYK21CoYllIAoFdJEPkxJuBXgqszERFHM4lHDAkSVCvNdZkdrLPvzE/j0GrVqrFYsn7m4fI9bndI8CrZ/ORqg7CY2eMAskvQcHYE3Y/q7ZAobs0gWeS8RDmMb/68I3+Hu3Q+Tnkpp9Zwdl35HW4rtSERRL+hCA1xR59DPPs0kuLqy2syYFgFlzV/6BfoJEysf3pG/OhLSp/4WL/ceHQKCsxT3Ius8EQT3DUkh3XQFYE9OfkZljl/MxiJPvAP2IABiARAx8Qf9yc3ExBIcoZjdtY0it/Sb9eoyTk9/qGRrq+r+TFOStMqf8eWlz9s2Fq1jCJLsdqqfTIHxRQGVpfUFDWHt3e6J1ajdiR7n9EgwnpLYqRv7lNL0yBCHpmdTGoi2rJQ3BbSGYiZ2jJl8IjqSapTTxpa9zP/DBVXNv7tG9qy+m3L15uvE3o0wuLq7S8V4wchAm/2aVCuin5Df0ddrls1ynRKg6B9zieMXlPvePXN7MgimEe6w9lZyoDhHcmw7oK10NU+xa+pANUNeOqS+DYzrYD4Gn4/qfkRmUUzOMav9dPVVklKXcgMyHg64qgGQvcXazrJEKLsoCuGMrwvNS7IQsBBFP+7mZaGfcNoiZVyXWPGaNbX/ZDQcUZdCPtXccvns/l/01Wi2IXubZjcgTSWcgIquC67PANeKV2bHtuXxpf4SQifX1YldeAvlE8gBJhBcuAhuFupTfrZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(26005)(2906002)(21480400003)(6512007)(186003)(316002)(2616005)(6506007)(44144004)(36756003)(478600001)(38100700002)(6486002)(107886003)(86362001)(83380400001)(41300700001)(4326008)(5660300002)(8936002)(6916009)(66476007)(8676002)(66556008)(66946007)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?84xiBO7W5mwiUO1uzc5YfRTdtv6+9OiTAONCXsxmZ+nxKUv0HiCGVYJhvGkt?=
 =?us-ascii?Q?02tlOshp10zKgzGVa6zidnyoe8kKKZ/3s6dq2hQmkgsOvrahs7o7YWqov3Nz?=
 =?us-ascii?Q?FHRWQqBUt3zVoVHFP8Rz7WcNrH9ueE004eoy46yWKUw2hPs30UkFJPfgVxWH?=
 =?us-ascii?Q?uX+Za6N9dzphNheDLLm96WYi3SOf2j0X3EWdmIVyUfwGPQBEwwW6H6t3QXA5?=
 =?us-ascii?Q?DhXui8c5KPHEnbuaItnVTahMfmnLDS2gx1esA4JFYtCGuv/HeLv8Q9HKOTM8?=
 =?us-ascii?Q?5dtRk3tbug6DqBca7eflgqfAVyFp3hyDok+7KcPT9JPXsbBTiASGebtTSTVv?=
 =?us-ascii?Q?msptTevasty2YI9tZ2UvYPVGjmKckRhGORo3SRwhemJvGquQFh2wZUbVc6Ws?=
 =?us-ascii?Q?R1tGagcqmib82S+toApvnXo5vddB0dMFY2yjuBf6qvjvGpj5SkuPUQO+ssH8?=
 =?us-ascii?Q?JlvdXOafUp4PzCAJ6sW9yrFK11lXnFtvE3rhImbSOVNyN6pXnY2IrVSCBN6y?=
 =?us-ascii?Q?fs6eCD/rIPxcOBTu+gt3UM6kuFXnAIJrYoQHHv2TnvGPx72etfqH9EgguXT3?=
 =?us-ascii?Q?lyXH7bn73/npzSxNXJ47TfRBCaclRtLDURE82dvw8ftnvWKuE/D0mg1sKNzH?=
 =?us-ascii?Q?qmv3B90qVVZZUMojzMQoMhrkaFsXxYqkSwezmeoJSeXJJLMBMHA6pqBBHX1s?=
 =?us-ascii?Q?f0gxv3d4hBtpnWqbcTFLXzbdTEfu8IXJgWf53G/6Cbqx+kT+xT74V3eNS3RC?=
 =?us-ascii?Q?eSmQxyyMo7woTU5o1A+qDxDft5Q9DAymQ04bFwRYGVOFGzfsqO8nBC9fy/Eu?=
 =?us-ascii?Q?NjRnspwFUh0+WN+VT83Z/iSS5Ctoghlrb3Bmu7PnohCZXrGzqSmLSVEx7Jwh?=
 =?us-ascii?Q?8KjGhNBTBZywBYKpTBtKe46NRDpkfG/Np8gNLPwk0v8lAZMQjZruLWMcj2SR?=
 =?us-ascii?Q?0kmp16g/YpT8gkOydyPSbmsd6+2ZpfijgS6iK/rxdgRpWevXCbRPqY08RORp?=
 =?us-ascii?Q?7EQdY9G3G/BXXRrrDVSwmDCLuwEnQS1j6TrW7bfGqcbg4JhXub+fgYStiQkx?=
 =?us-ascii?Q?j4/vTE7q0kPvlCdFJvZmcAdetfQkbWS/1U1LUEOSCk8pTCJeTbM0gCJR6wMA?=
 =?us-ascii?Q?ZNGJX/dKGcloeygodBDftwnOuy0cIHm7LIJMq/VcrOdUnqyeHpbLgauvAhIP?=
 =?us-ascii?Q?d+Ttqv78BEcbIkcS/1FavksJDx5p6Vf82/jsq9aP3NkWT5KpWiN3dyF/3UYX?=
 =?us-ascii?Q?zbHIXlZT0JxM+gPIBfE9tJ/4y82iDNGnVx4OFL6okZP5x+0lj9ZZEtxQ8IiY?=
 =?us-ascii?Q?SyCJgW1u58ythndJs99lgNprE/+NMriOXI7wgZ7xob8INc5BhjDWDzkFKtFC?=
 =?us-ascii?Q?LVM8LwqEQr+bChQokuffRKC2S/w7rsxmo0k54wpCw3WsCIBVqWH5oWDoHSXn?=
 =?us-ascii?Q?3MTll7qK82WugBih8ZIG2ZlcnnAQOV8NAzxtcSl6WyCZpN54ONh+RbRj2k1e?=
 =?us-ascii?Q?CW3+IdOcE6WUGUCStNi1GLPj6LihIXnK0ioSRG5lQYPfhyNcpwqElUNuc4C+?=
 =?us-ascii?Q?QQddg3wRdOAAjrHoGlHfNOoMqUg4PCBnHVf5drQU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a360953d-d1eb-4e60-8004-08dafb2b2f81
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 21:13:32.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6dVLNXwmWikxY/oM91lsCe/e+mro7jDROq74u94jpv1r1117OcQCovchD3j81Yf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--/Yqk9/plX+V6ZlpR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small PR for the rc cycle.

Thanks,
Jason

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0f097f08c9b3c1fdb6cc9f2dd423abc17d13f1a2:

  lib/scatterlist: Fix to calculate the last_pg properly (2023-01-16 12:08:31 -0400)

----------------------------------------------------------------
v6.2 second rc pull request

- Several hfi1 patches fixing some long standing driver bugs

- Overflow when working with sg lists with elements greater than 4G

- An rxe regression with object numbering after the mrs reach their limit

- A theoretical problem with the scatterlist merging code

----------------------------------------------------------------
Daisuke Matsuda (2):
      RDMA/rxe: Fix inaccurate constants in rxe_type_info
      RDMA/rxe: Prevent faulty rkey generation

Dean Luick (5):
      IB/hfi1: Reject a zero-length user expected buffer
      IB/hfi1: Reserve user expected TIDs
      IB/hfi1: Fix expected receive setup error exit issues
      IB/hfi1: Immediately remove invalid memory from hardware
      IB/hfi1: Remove user expected buffer invalidate race

Yishai Hadas (1):
      lib/scatterlist: Fix to calculate the last_pg properly

Yonatan Nachum (1):
      RDMA/core: Fix ib block iterator counter overflow

 drivers/infiniband/core/verbs.c           |   7 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 200 +++++++++++++++++++++---------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h |   3 +
 drivers/infiniband/sw/rxe/rxe_param.h     |  10 +-
 drivers/infiniband/sw/rxe/rxe_pool.c      |  22 ++--
 lib/scatterlist.c                         |  25 ++--
 6 files changed, 179 insertions(+), 88 deletions(-)

--/Yqk9/plX+V6ZlpR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY8sD+QAKCRCFwuHvBreF
YbqpAP9DbLDpDMzcelw98Rp5QL5gC1CYo7lSDVjlxwfcCnbgrQEAnIiHwjxwBoDF
Al6QJ7Oo+E7A8ZG2tEQuw6fLqI/p7A0=
=YLrn
-----END PGP SIGNATURE-----

--/Yqk9/plX+V6ZlpR--
