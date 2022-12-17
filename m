Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45764F6A1
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Dec 2022 02:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLQBGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 20:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLQBGB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 20:06:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663E71D303;
        Fri, 16 Dec 2022 17:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1iorm4HUCNvJreAftdBAmMtc70jtsbqyJT+BI3AtfXYiWlG3xYddtQQXPE2o9FdOxSElMgdDY5cNLyUsBzyGXsZPbHg+p3EBZ7rrkFy4unxxM4yqUmspYmZRi7jd6zeneaQyIa++jw/cir7HCEeGpz+zd6R+i0sBq6w7bpMEhsBn3QK6uMPVJLD0ks4chFVNR6pfnPbfzhfok8oD4rvEub5CwtCRuCCrhbYwzWcbA9jWnx+Cj2lJ2Vj2QCN+b3j/W5lrR0WMonBY7dOVTheI1M8mwo0qvdUVNq/xGkJhB8PLL2OLaM+K0nKBJyrk4EtFSuBoYmDk9wtMoyGBJAEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAGaJs2yR5kY/kFnPhQdLgYNU/VaoCB7gy0dx9+FkAo=;
 b=YTfFebfyof7896o6IIzZRwjRQURT/gfzj68NdYC1VczyMse6gsP3n0eFyzj8FMFXBmbdN4ujzk86Du0IpUiWasnL7EJI4+02FeAeo91BPif44IeImvyoBcGtOJcdJdLCf1eaoL27Zpr10EKr6shXBBa8WkR4UkKMvEwU86T/jTFKw92G6jEyw/4manO+0MmLoH6lE0tCyM+t5l+I3mGPp1vHRWryzjcdCpKX0UEjyhB2Ll5suOScbCKbzPASx3DH8X7VXE03LLahnArsHVY4D8odz5BKkx8QoIdhLlv0+q0RsqG5VL8LbxbARYVQr+JGJoNG0c1NvUzeW2avSKtpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAGaJs2yR5kY/kFnPhQdLgYNU/VaoCB7gy0dx9+FkAo=;
 b=NAS/Y50LLjRF1kM+AFaADwuj/ohzDqQlDCkyPaTKI9cG+JRm+FJU7txDFm4juKKIl1VNL5TJQKBmAyFXWKOEticE4g3imKxMvbT7DnUbO6JGKPKMyvEdtsV9+u6lxATsX3XKYmCerqoSCddvMrtOY/4rtazug9GgkDM0xs93hD68I77cI1gsygkD5TNdaOFkwaySj8DTFg4gNwM+WMl2VmzNDIZ4cc0cZKZYql5sm5Wc/cFRLoaXEMqG4/TXDUwyz6SrxhkzjUle49Vu2ehU95UcgI5pSKy3b0otIbjm3d0hlWNknvSHFYPc9lGYRf4b/PkA4/g/roGmG0UkUXKPUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Sat, 17 Dec
 2022 01:05:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5880.021; Sat, 17 Dec 2022
 01:05:56 +0000
Date:   Fri, 16 Dec 2022 21:05:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y50V8+TQA7wsipC5@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ivoi46aytpv332lZ"
Content-Disposition: inline
X-ClientProxiedBy: BLAPR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:208:32f::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bbc1f8-9873-47bb-b56d-08dadfcada30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLlLfo+AmXt8fb4vTtB0vzndC64fXP7EBW9mVXqSZsbv5gJKP6UOLGUWBPUfjrEl9WIPNIreSbZaQYY1T872IDS4EOkIrv8pruXvSX2aJeNsaUnaYUG/jF2CekJ9SNOeHNF6ODM3MtWve/OeA8vrhBSbr2Vf1FP2szcC9MOXOFGQBAOJYaHHUEuih8NR2yOCK+W1Q0lc/C7G2HzEbRGfj1a6y5o/g7aAWbbxFCLPaj8GEIPhC1tJgSwKCgbS35H0y8srGrNS9Og4IuDS8E1paMDySfufxeZtps03IpN61OVgw4YcjKNfZRqLdDbY8aFHeblh4fxe/QfvwhDQwbaT0x1jU9MWgCOAmsGeJXcXusrUrTiL+mdT736uIqzpu1GPoHYuOQLTWocaONQSJos75jrIQCovdEkQ+lS1CjcQpkBVNbGP+VXyN/kFtN+M+NaD9ZV3eI5Dzc+DSxYll23CNp87fBd1gHIjYPrxJBwqbXNpmOKxYX5nt7sFCdFSk1Kjx4WIUCNQCKnJkseL74Ow+aaot7ZMnJsiLVdTJ+X07qBtgfJHW9KLVuCZFr88wh1Z5V7T0rRRyXwPGJif0tvuDnX/Zn3I/CgVUqiBW5Zi67iJxa7fjgSLPHueYof2MJVlOJOz2weDHihWxYo9/LpQj4AAAO0ltePkWT4XPnZIvM+nyf9KfAdvCCAD3GKBfPvPv8gUHixz6jhywMPMdiAQQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(36756003)(6916009)(2906002)(41300700001)(8936002)(4001150100001)(5660300002)(83380400001)(38100700002)(86362001)(6486002)(478600001)(107886003)(26005)(44144004)(4326008)(316002)(66946007)(66556008)(2616005)(21480400003)(66476007)(6506007)(8676002)(186003)(6512007)(2700100001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DsLodqsRILXcj54BWUk5XaGVyeOTgZOQ4fZG6h2t5l9o4jc3Ilmvx3YdvQhG?=
 =?us-ascii?Q?mY7R9I32MxTO2s2ntyuwIBKXwGSgKvVFn73ZePhejcrR7TADJlfDr11+VUxT?=
 =?us-ascii?Q?2fpCP2sS+pAmNitUZ4b+y1yt2D22dxCXftyiT8DM3yKgcN5bjFwipBmPCTil?=
 =?us-ascii?Q?VpKy/3LJF1UVQXhRkU8r34y6A6tBUJ96a4ZimVgu35mxyO1c2b0H52cXsFBd?=
 =?us-ascii?Q?K7vQj5+4yjr7P+R1NCi274UNiBABK82SF71keTMtLzsh0gHt9+Ao2zvvVZE9?=
 =?us-ascii?Q?IojtPO8zyGNzg+UHX82xwo2eOouxhZVhYpCGPQS+kVnExVXqFDKQpmrI35uK?=
 =?us-ascii?Q?YBHuQyKTdk+r1pqw5Z7XYsWT8YUQoczRkcGqmIIQHSnWiCO52HFkkWCed+Jd?=
 =?us-ascii?Q?6o5ph9YXGouP7sQ8KIUCfgX+8XWoLvhOG9uwYIsqkUCdlRFual4my6h0EZAM?=
 =?us-ascii?Q?NjeKwbmLCBFXs4+MtCY4xI6HGtVkZAiALpLkIbRvb4K7nxC2V55Zd+TGBzkv?=
 =?us-ascii?Q?YYRgu5RnkR3yEGWZ6lAN6jTwYcf8oGe2r1D6ilaARE0NVaRv8a6qth9LSEZs?=
 =?us-ascii?Q?IIjyVT43xblJtzltDFU0FUdqg2L0Q01YHnNkWCRLm2P303v54pDUAqNaToi2?=
 =?us-ascii?Q?90GWEifEBT6zGhjDFVZxmznz5PEklqt23e0Ec9UeBA3IeLhuQlhGMnXDjgr6?=
 =?us-ascii?Q?VyOzOVlSZ+Ksk7OTHjBxLnV/Go5R0AMpdkLcaEEDsTWE8Bv7wpfCZ8xHy37x?=
 =?us-ascii?Q?UZCWSZzhvid9lceUd76o/S+B8C+Ufb+l+/ehKRSaVsrSJ5obs+hqrcGzL5eq?=
 =?us-ascii?Q?iWYWlHI0lhdGbWbKrhOBlXUJkmy+oK7EavWaIoaPZwGDcaVWpnfQNpB/U6p8?=
 =?us-ascii?Q?neNCf298QOkNd8yN2UGCXPc/7gUcR4tPmC7td3JpNkFsHnG3HlMFL9AfGUWj?=
 =?us-ascii?Q?qFMEBv1Nx22qksPiv1sWjC4PfKkEABhCdulVFtul6ziiwAwQWQB4DQsyNan8?=
 =?us-ascii?Q?uw8OPBfRMMr8PQacRDXZlpEuDoOukGHCT/GgJq25evA6+RfMjqd1MHhUllMd?=
 =?us-ascii?Q?4+zB5Moi2Cg90af3QMGmirUbJaCtRvgim6Iz/dAi01D+rDkwB1MOKsff5FOR?=
 =?us-ascii?Q?UUGk3gE6IRLLNCOW52LaccEKXrxB7LM+FG7m20VeWGhZkii+gesK45XF4XAP?=
 =?us-ascii?Q?XWR0RdqChrEc3SDdjm+0VJnR4h/mn5GcaPHLwR2npaoE6wpJGcHl6zUP1g3U?=
 =?us-ascii?Q?udJpUPMGZe4baXq/b1ni5IBcsiDTjnDMA51w0eLAItmL0BIRWcB7XDLED59j?=
 =?us-ascii?Q?Qtbut96P+UHYSj6/x2fKGd+CiknU/UzwE0B05yB541/6Bf6mu2IIwmQcgyZl?=
 =?us-ascii?Q?vE58uhigu2umkdxgJXaRmkmyoDKrwOBpbfsih/dWdr8pjP+xoDUKPSr63Q4N?=
 =?us-ascii?Q?fmPucuiF6KSgQm2fn549Iyz3ZhbYhrQH6cLT2STYdcUCcho0UAp9ozY+ckbc?=
 =?us-ascii?Q?m4w+5hf/aqvr0KNHYlkQNsJYRUtHXgiBdFYZUtJArBpQSvN7E8MULWU9/eMQ?=
 =?us-ascii?Q?4M5nrbxfWFSc8iYIgYlnPxe1uYV94Nx3vOa+iks4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bbc1f8-9873-47bb-b56d-08dadfcada30
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 01:05:56.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro0UeMKl8WvYx5dd+JD0hJ/KXIqK6zfPIcgFLIEXAy1U46+TOPcdRnxQRbgdBP9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--Ivoi46aytpv332lZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

It seems the linux-next CI and 0-day bot are not testing enough 32 bit
configurations, as soon as you merged the PR there were two instant
reports of warnings on these sytems that I would have thought should
have been covered by time in linux-next

Anyhow, here are the fixes so people don't hit problems with -Werror

Thanks,
Jason

The following changes since commit dbc94a0fb81771a38733c0e8f2ea8c4fa6934dc1:

  IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces (2022-12-11 11:04:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 5244ca88671a1981ceec09c5c8809f003e6a62aa:

  RDMA/siw: Fix pointer cast warning (2022-12-16 16:07:38 -0400)

----------------------------------------------------------------
v6.2 merge window 2nd pull request

Fix two build warnings on 32 bit platforms

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/siw: Fix pointer cast warning

Jason Gunthorpe (1):
      RDMA/rxe: Fix compile warnings on 32-bit

 drivers/infiniband/sw/rxe/rxe_resp.c  | 72 +++++++++++++++++++----------------
 drivers/infiniband/sw/siw/siw_qp_tx.c |  2 +-
 2 files changed, 41 insertions(+), 33 deletions(-)

--Ivoi46aytpv332lZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY50V8QAKCRCFwuHvBreF
YW54AQCU3XfZNBkw0QzSOBZsyh2qMYfHLCLuTAG288D/aKkMlQD/b/B2rAuOLm1+
J8RA/vIK91tZGKN0u48rvk+IMK3dIwo=
=b/Hl
-----END PGP SIGNATURE-----

--Ivoi46aytpv332lZ--
