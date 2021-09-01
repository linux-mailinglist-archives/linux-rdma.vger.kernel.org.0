Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49C63FE651
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhIAXnB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 19:43:01 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:36737
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229776AbhIAXnB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Sep 2021 19:43:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCFpsurK9iQBzVPd9XcjFGewM3Wg+I9BVk8064jNBcgpVR9uPlQw+1TUQT7U6turfSN849hJPE9qWb+Hdi+ccx+LIt7B3ARPZdFd/XUBRaDRarf971vxgymnARlb8Zj5Bn50kxELUiq9DxxxWKNJNnqRU542GuigN6V869N7Mpvh1uHj9qu8YhFKyqhBzOAxFE4sZoMUxUpQBQm9A4stzhy6HGHW6w4OZ0sNiZsQKEixCSDASmeZ8SnU2eE0L9XEbKRJmWIiiiHE8bOMdROYCLZJ5sFtq8VhP/JeF+sfqkU2JrMM9JSWuoTOMVFVdiqqHytjQ4JO5DTXhEMpUVsYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gqF5VTWAbo9WSbF2Pw7zaJZtctiG4FpJBxAODFf8ObY=;
 b=ZSXU+Juu8HqgW00JlpCXwSYrHegG9KWTj3H1UQudWU889/kx5AfaL/RRxOTwAcM8HrvBqgDCcvAQw5/q0MznUzsaUBfCdXA5mzbtj98FZCInVBtYXwI3/frAJkb5krtmGZWaklpgzJrrXEBZKuESgRzayfRXu3lmcPqrM9uMYAlLf+jBLKr5raIc+84HAM4ajEYtFO/arGTyAmrEJiLdpWdkaB/I1GOUivPeLtjCjd4zFhNYrnvvI/HcSBoZq5B4mZYyHQz27SbldAlxsyGQ5BJ6UyZWWNyppNqZ2W0Aw1Wkifh6lCvflEN2WGfXuGy12QYljluogWmNnBhOKCmEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqF5VTWAbo9WSbF2Pw7zaJZtctiG4FpJBxAODFf8ObY=;
 b=PWVDXJhTDFtEfHt3Zqdl1YhONf9DfradCwSRRgLQEsFCga3Bk66n6Si9knvYdZOXRa9YfwudgY8+bZkU6lMctUCZZW6/jLAD79Cm4L53UYV95wKU70yHET4S8swPX2RKsiP6zD7LmBiYvAdKi+/T1V0/SWfXyTvFMZwrWR7zpg20IV2pBLmNN1chOzk3dwxxYMloOFmmJLXNdyvzZ6g6qT5WQ58WNYdzbjHh7HlNWWA1YIhoqcURS8ooo9/cWtfO0+q2wALlo6AOF/PL7DCO3LcTtSpQIMGfnWip/RE9xoYA2+CU8Czeh08ysENm16VJjzXuDlVAdOgAGvuxh4qh9g==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 23:42:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 23:42:01 +0000
Date:   Wed, 1 Sep 2021 20:41:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210901234159.GA2421971@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR22CA0026.namprd22.prod.outlook.com
 (2603:10b6:208:238::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR22CA0026.namprd22.prod.outlook.com (2603:10b6:208:238::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 23:42:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLZrj-00AA7n-Kd; Wed, 01 Sep 2021 20:41:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7e0d2c-0499-4f40-7c32-08d96da2184d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5159602194B59628D455D151C2CD9@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hYSxCzu6vXpLyzmZ6ptJcAGGn6lXmfnGRMYMGiGJaTbKx4zMyr40sO31LdCs74kSnZ6x15MJLcnvMrsDJfVcAd60LxxK1bJv2o41pDhGQWKc3LQMKKvNxo8K1aJVudYcSfHxXyXZIPBmLBnVvA4Sfd16kGKyRzKkZPpMuJZfpRx45L9DssWwLf+WLuJwyqOwnV6NT7TktTlzwQ6SuYNpCoFUNY3HMsyDOsRlzvIZ3bKUguqDzIsEJobK3Q4TQy7dv1vVLuKtQKXEzhg3De4lRoub1hrSSderjFHimkUY7XAOXpRU4ssjWCFvKQN0jSIhTBHmaE2LVo9ZJO2bU44Sl9nHJP/g8zD+PZ6wsztMY+oE40YlufektCp4ax1V9ncb1syiAPx5tak2VjveHitFHfCaqOxHDx218HGLwE9eFIHlWavoQco90sEEtYtQi890+T7kUzLnsz2RAgsL1y/5iEoPbU/hsCYivEDbZcYMYfRGOzTo9YkpR2GAIKNnTGs1jRXEDdEHAPa9Xf2jrYF32SCxHDDx3Qw1l5yCl3/pOWLOBtkVqOwRnbOHJ6z/RPyI4NUplX8WpWm3vx0U3fxay/tooqn/I/IAO5rxgqRlpYdZpw1yD6kzoSRrN53kNbOVkDG0jbe5EGeoeDKrOJX+4RZDwwKY1CV5Gws9wieYyCc15mWKlTotrokZUVqaJYqg4WfR00gw1BM1MOmOE6t0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(8936002)(5660300002)(38100700002)(8676002)(36756003)(4326008)(110136005)(66946007)(2906002)(66556008)(426003)(66476007)(26005)(478600001)(44144004)(1076003)(86362001)(9786002)(30864003)(33656002)(83380400001)(2616005)(9746002)(21480400003)(66574015)(33964004)(186003)(316002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWZzcU84ME9CQUhKQW9EUmt6dWoxazY4RVE3STFpdHFYZnAweEhkeXZjK1Qy?=
 =?utf-8?B?YmZLVHRLRzQ0Q1NLaVZPWUh1UmVocmtBSXlTamZRNWJSMmw5YXI5RTRmRTZi?=
 =?utf-8?B?VUZZYnMweTFIcmhjVEpvMy9Jd1JpN1JvSkhFeTI2ZFJlbkk0TENkMDFUZkkv?=
 =?utf-8?B?NWt1SHYxU1BPejNWak5JUXN6dDM2UlNzVFVYRUFBNElIMDRaVHJYUk13aHZR?=
 =?utf-8?B?TDFOOE5QVEEwMytiR0J2bkFzOXE2dkp5bVlnaHJZVnNTeXdNWHVlemtNcGJp?=
 =?utf-8?B?SDFoSk5IRll4WUcvamxFa2VqRkQ3UGZhaXFtTnZkbzhPWkJsbEsyNmJobUNu?=
 =?utf-8?B?STROKzRLZ2Rvck5QdFBiQUF2dERkTUw4ZGJCc3VYQ3hScnBCWVFOMVhkeGZh?=
 =?utf-8?B?ZGJGRmhVRUxmcUJ0NnM1UENpdU84ZjBhUFVsZGp3bUI0dDkwcG96R3NsZ0tM?=
 =?utf-8?B?Vkl3aUwwaUlhbkhJdGU1UVo3cFNUOTRybnhrei9jSE5xeC9waHNZcTIxUEtE?=
 =?utf-8?B?bUhYTXNON20xbnNWTTJKRjdaTkhvbWlEUUFMejVGMmpFWDhsOW9NWUdGM3BP?=
 =?utf-8?B?MXNOTk9CV3M1d2g4cm9OekM2VWlLSUkrOXh6ck1WY253YUVUMjFMVEd1WUZ1?=
 =?utf-8?B?cE4vc3NrSlI2NnRKTy9ITTR5alZtL1NIa3Z6QWhmTmJNTGdCc056Ylo1dUVE?=
 =?utf-8?B?aEZhRXJHU0I2aTNWbm1JSWxxdjVqKytRN1BCdElXVkRoTUJnc2Njb0hUWWli?=
 =?utf-8?B?OUtqNEFQc0FyajFtUk81akJ1SkI4c0tqRkthVmgvUjVvRUdWc0EzMS8xV2dI?=
 =?utf-8?B?NGtTVDU3ZUFJbXJUT0xoWFpPbzFwQmxjMzhtWFk2OUNKYmIzYTBLUk5EQlQx?=
 =?utf-8?B?U3NnTkllVWNBZCtUclhpV1dLR0FtVk9uL0IzK29iRnpOcXdLN1Qzd0xmRmh0?=
 =?utf-8?B?em9vTkE1ZmV0bkx4cWtnYm00eEdUc1VITnNub252MU5mSXQ5U3d6MFJmY1RH?=
 =?utf-8?B?cWtpRGNleTJTejBJa0tXblJLbytDZlgwZ1JCamxaQmdkRmcxS0RHYXBDZE5X?=
 =?utf-8?B?QVJXcUoyeHlWSytqV0RRS1RyWTRkWTFHKzZtODl5akVVd01YSHhBNldsR1Br?=
 =?utf-8?B?clZqSmIyRlBiNGFYQ21GZFpENEV6VDg4c3NyNDlPdDdIL1NpMVpGS3J4V0Nv?=
 =?utf-8?B?TVBWRGdMTEJVTEZmSU1uQjBZMFI0WDRHRVdySmxoY0hsM0o3ZzhqcnRvcjdo?=
 =?utf-8?B?MWl3V3NnWFdZQVMrWW9JSFFVOWc2bXltaUdFc2lFMEZCRjJrY1Z6bE1neHRv?=
 =?utf-8?B?RnBraTQ0SDdXMzBsZWZqOXNxU0xuMGVpcy93S0JKQXk4M0ZVS3FGSzlrb0Z4?=
 =?utf-8?B?ZzJFS0Q4b1AvOFJmeVhlRGFZT3VrV0VSS2YvYmxsYXlwTHJ0eld2ZWh1QVB5?=
 =?utf-8?B?ZGVoOHd2UkY3RVYzZGJRZENIeXdJQ1JldFYrb25wV2pBYllzdWViemxqVUJa?=
 =?utf-8?B?eHVqOHNxV0RaK1ZtRzBTNTE0V09XdWNyMitVTE9PRnQ3c2V4OFRETE9wTnIx?=
 =?utf-8?B?YUJQajBkQ0NFZVlZYnBjbkVBNStIb0RHeEtjeDlzRUJGSXA5Z1pmV1NpR09J?=
 =?utf-8?B?Tlpyc0VScFRRT2Y1Vk10c2s4SGZwR0VFNWppTmNteStDM1NNc0loYnNNeEZv?=
 =?utf-8?B?MElNZWo5bXRGRm1hcWtCQXJVRnE0aUtIdmhmUE96UlJrcnpiVEhONGdGVGxk?=
 =?utf-8?Q?D/ImrLhuCGb1WCkkX/1QstkKjiyi0i+416s81ND?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7e0d2c-0499-4f40-7c32-08d96da2184d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 23:42:01.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBdyhCnxlZo41nk7E4AaT73tHGYgQlcCABvj6KNLDeaJUgwGTtoJewcLoE+drp87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the proposed RDMA patches for 5.15.

This is quite a small cycle, no major series stands out. The HNS and
rxe drivers saw the most activity this cycle, with rxe being broken
for a good chunk of time. The significant deleted line count is due to
a SPDX cleanup series.

There is a merge conflict related to the scatterlist fixup which
changed a function name while DRM added a new users. You'll need to
apply this hunk from Stephen into the merge to make it compile:

diff --git b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c a/drivers/gpu/drm/i915=
/gem/i915_gem_ttm.c
index 771eb2963123ff..d3d95934a0473f 100644
--- b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -382,7 +382,6 @@ i915_ttm_region(struct ttm_device *bdev, int ttm_mem_ty=
pe)
 static struct sg_table *i915_ttm_tt_get_st(struct ttm_tt *ttm)
 {
 	struct i915_ttm_tt *i915_tt =3D container_of(ttm, typeof(*i915_tt), ttm);
-	struct scatterlist *sg;
 	struct sg_table *st;
 	int ret;
=20
@@ -393,13 +392,13 @@ static struct sg_table *i915_ttm_tt_get_st(struct ttm=
_tt *ttm)
 	if (!st)
 		return ERR_PTR(-ENOMEM);
=20
-	sg =3D __sg_alloc_table_from_pages
+	ret =3D sg_alloc_table_from_pages_segment
 		(st, ttm->pages, ttm->num_pages, 0,
 		 (unsigned long)ttm->num_pages << PAGE_SHIFT,
-		 i915_sg_segment_size(), NULL, 0, GFP_KERNEL);
-	if (IS_ERR(sg)) {
+		 i915_sg_segment_size(), GFP_KERNEL);
+	if (ret) {
 		kfree(st);
-		return ERR_CAST(sg);
+		return ERR_PTR(ret);
 	}
=20
 	ret =3D dma_map_sgtable(i915_tt->dev, st, DMA_BIDIRECTIONAL, 0);

The tag for-linus-merged with my merge resolution to your tree is also
available to pull.

Thanks,
Jason

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac:

  Merge branch 'sg_nents' into rdma.git for-next (2021-08-30 09:49:59 -0300)

----------------------------------------------------------------
RDMA v5.15 merge window Pull Request

- Various cleanup and small features for rtrs

- kmap_local_page() conversions

- Driver updates and fixes for: efa, rxe, mlx5, hfi1, qed, hns

- Cache the IB subnet prefix

- Rework how CRC is calcuated in rxe

- Clean reference counting in iwpm's netlink

- Pull object allocation and lifecycle for user QPs to the uverbs core
  code

- Several small hns features and continued general code cleanups

- Fix the scatterlist confusion of orig_nents/nents introduced in an
  earlier patch creating the append operation

----------------------------------------------------------------
Anand Khoje (3):
      IB/core: Updating cache for subnet_prefix in config_non_roce_gid_cach=
e()
      IB/core: Shifting initialization of device->cache_lock
      IB/core: Read subnet_prefix in ib_query_port via cache.

Bob Pearson (9):
      RDMA/rxe: Move ICRC checking to a subroutine
      RDMA/rxe: Move rxe_xmit_packet to a subroutine
      RDMA/rxe: Fixup rxe_send and rxe_loopback
      RDMA/rxe: Move ICRC generation to a subroutine
      RDMA/rxe: Move rxe_crc32 to a subroutine
      RDMA/rxe: Fixup rxe_icrc_hdr
      RDMA/rxe: Move crc32 init code to rxe_icrc.c
      RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
      RDMA/rxe: Fix types in rxe_icrc.c

Cai Huoqing (3):
      RDMA/hfi1: Fix typo in comments
      IB/rdmavt: Convert to SPDX identifier
      RDMA/hfi1: Convert to SPDX identifier

Christoph Hellwig (1):
      RDMA/hfi1: Stop using seq_get_buf in _driver_stats_seq_show

Christophe JAILLET (2):
      RDMA/rtrs: Remove a useless kfree()
      RDMA: switch from 'pci_' to 'dma_' API

Gal Pressman (3):
      RDMA/efa: Split hardware stats to device and port stats
      RDMA/efa: Remove unused cpu field from irq struct
      RDMA/efa: Rename vector field in efa_irq struct to irqn

Gioh Kim (3):
      RDMA/rtrs: Remove all likely and unlikely
      RDMA/rtrs-clt: Fix counting inflight IO
      RDMA/rtrs: Remove (void) casting for functions

H=C3=A5kon Bugge (2):
      RDMA/core/sa_query: Remove unused function
      RDMA/core/sa_query: Retry SA queries

Ira Weiny (2):
      RDMA/siw: Remove kmap()
      RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()

Jack Wang (7):
      RDMA/rtrs: Add error messages for failed operations.
      RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
      RDMA/rtrs: Enable the same selective signal for heartbeat and IO
      RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
      RDMA/rtrs: Remove unused flags parameter
      RDMA/rtrs: Move sq_wr_avail to rtrs_con
      RDMA/rtrs: Remove unused functions

Jason Gunthorpe (3):
      Merge branch 'mlx5_dcs' into rdma.git for-next
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel=
/git/mellanox/linux
      Merge branch 'sg_nents' into rdma.git for-next

Junxian Huang (3):
      RDMA/hns: Bugfix for data type of dip_idx
      RDMA/hns: Bugfix for the missing assignment for dip_idx
      RDMA/hns: Bugfix for incorrect association between dip_idx and dgid

Lang Cheng (2):
      RDMA/hns: Remove unsupport cmdq mode
      RDMA/hns: Ownerbit mode add control field

Leon Romanovsky (20):
      RDMA/iwcm: Release resources if iw_cm module initialization fails
      RDMA/iwpm: Remove not-needed reference counting
      RDMA/iwpm: Rely on the rdma_nl_[un]register() to ensure that requests=
 are valid
      docs: Fix infiniband uverbs minor number
      RDMA/hns: Don't skip IB creation flow for regular RC QP
      RDMA/hns: Don't overwrite supplied QP attributes
      RDMA/efa: Remove double QP type assignment
      RDMA/mlx5: Cancel pkey work before destroying device resources
      RDMA/mlx5: Delete device resource mutex that didn't protect anything
      RDMA/mlx5: Rework custom driver QP type creation
      RDMA/rdmavt: Decouple QP and SGE lists allocations
      RDMA: Globally allocate and release QP memory
      RDMA/mlx5: Drop in-driver verbs object creations
      RDMA/mlx5: Delete not-available udata check
      RDMA/core: Delete duplicated and unreachable code
      RDMA/core: Remove protection from wrong in-kernel API usage
      RDMA/core: Reorganize create QP low-level functions
      RDMA/core: Configure selinux QP during creation
      RDMA/core: Properly increment and decrement QP usecnts
      RDMA/core: Create clean QP creations interface for uverbs

Li Zhijian (1):
      IB/core: Remove deprecated current_seq comments

Lior Nahmanson (3):
      RDMA/mlx5: Separate DCI QP creation logic
      RDMA/mlx5: Add DCS offload support
      RDMA/mlx5: Relax DCS QP creation checks

Maor Gottlieb (3):
      lib/scatterlist: Provide a dedicated function to support table append
      lib/scatterlist: Fix wrong update of orig_nents
      RDMA: Use the sg_table directly and remove the opencoded version from=
 umem

Md Haris Iqbal (1):
      RDMA/rtrs-clt: During add_path change for_new_clt according to path_n=
um

Mike Marciniszyn (2):
      IB/hfi1: Indicate DMA wait when txq is queued for wakeup
      IB/hfi1: Adjust pkey entry in index 0

Prabhakar Kushwaha (3):
      RDMA/qed: Use accurate error num in qed_cxt_dynamic_ilt_alloc
      RDMA/qedr: Improve error logs for rdma_alloc_tid error return
      RDMA/qedr: Move variables reset to qedr_set_common_qp_params()

Shaokun Zhang (1):
      RDMA/irdma: Remove the repeated declaration

Weihang Li (2):
      MAINTAINERS: Update maintainers of HiSilicon RoCE
      RDMA/hns: Remove RST2RST error prints for hw v1

Wenpeng Liang (4):
      RDMA/hns: Fix query destination qpn
      RDMA/hns: Fix QP's resp incomplete assignment
      RDMA/hns: Remove dqpn filling when modify qp from Init to Init
      RDMA/hns: Adjust the order in which irq are requested and enabled

Xiao Yang (1):
      RDMA/rxe: Remove the repeated 'mr->umem =3D umem'

Xinhao Liu (1):
      RDMA/hns: Delete unnecessary blank lines.

Xiyu Yang (1):
      RDMA/hfi1: Convert from atomic_t to refcount_t on hfi1_devdata->user_=
refcount

Yangyang Li (3):
      RDMA/hns: Use IDA interface to manage uar index
      RDMA/hns: Use IDA interface to manage srq index
      RDMA/hns: Delete unused hns bitmap interface

Yixing Liu (3):
      RDMA/hns: Enable stash feature of HIP09
      RDMA/hns: Fix incorrect lsn field
      RDMA/hns: Encapsulate the qp db as a function

YueHaibing (1):
      RDMA/hns: Fix return in hns_roce_rereg_user_mr()

 Documentation/admin-guide/devices.txt           |   6 +-
 MAINTAINERS                                     |   2 +-
 drivers/gpu/drm/drm_prime.c                     |  13 +-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c         |   9 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c     |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c      |  14 +-
 drivers/infiniband/core/cache.c                 |  10 +-
 drivers/infiniband/core/cma.c                   |   3 +
 drivers/infiniband/core/core_priv.h             |  44 +----
 drivers/infiniband/core/device.c                |  12 +-
 drivers/infiniband/core/iwcm.c                  |  19 +-
 drivers/infiniband/core/iwpm_msg.c              |  34 +---
 drivers/infiniband/core/iwpm_util.c             |  78 ++------
 drivers/infiniband/core/iwpm_util.h             |  18 --
 drivers/infiniband/core/restrack.c              |   2 +-
 drivers/infiniband/core/sa_query.c              | 186 +-----------------
 drivers/infiniband/core/umem.c                  |  56 +++---
 drivers/infiniband/core/umem_dmabuf.c           |   5 +-
 drivers/infiniband/core/umem_odp.c              |   3 -
 drivers/infiniband/core/uverbs_cmd.c            |  31 +--
 drivers/infiniband/core/uverbs_std_types_qp.c   |  29 +--
 drivers/infiniband/core/verbs.c                 | 244 +++++++++++++++-----=
----
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  26 +--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h        |   7 +-
 drivers/infiniband/hw/bnxt_re/main.c            |   1 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h          |   5 +-
 drivers/infiniband/hw/cxgb4/provider.c          |   1 +
 drivers/infiniband/hw/cxgb4/qp.c                |  37 ++--
 drivers/infiniband/hw/efa/efa.h                 |  10 +-
 drivers/infiniband/hw/efa/efa_main.c            |  20 +-
 drivers/infiniband/hw/efa/efa_verbs.c           | 149 ++++++++-------
 drivers/infiniband/hw/hfi1/affinity.c           |  45 +----
 drivers/infiniband/hw/hfi1/affinity.h           |  45 +----
 drivers/infiniband/hw/hfi1/aspm.h               |  45 +----
 drivers/infiniband/hw/hfi1/chip.c               |  50 +----
 drivers/infiniband/hw/hfi1/chip.h               |  48 +----
 drivers/infiniband/hw/hfi1/chip_registers.h     |  50 +----
 drivers/infiniband/hw/hfi1/common.h             |  44 +----
 drivers/infiniband/hw/hfi1/debugfs.c            |  58 +-----
 drivers/infiniband/hw/hfi1/debugfs.h            |  49 +----
 drivers/infiniband/hw/hfi1/device.c             |  44 +----
 drivers/infiniband/hw/hfi1/device.h             |  49 +----
 drivers/infiniband/hw/hfi1/driver.c             |  44 +----
 drivers/infiniband/hw/hfi1/efivar.c             |  44 +----
 drivers/infiniband/hw/hfi1/efivar.h             |  45 +----
 drivers/infiniband/hw/hfi1/eprom.c              |  45 +----
 drivers/infiniband/hw/hfi1/eprom.h              |  44 +----
 drivers/infiniband/hw/hfi1/exp_rcv.c            |  44 +----
 drivers/infiniband/hw/hfi1/exp_rcv.h            |  48 +----
 drivers/infiniband/hw/hfi1/fault.c              |  45 +----
 drivers/infiniband/hw/hfi1/fault.h              |  50 +----
 drivers/infiniband/hw/hfi1/file_ops.c           |  51 +----
 drivers/infiniband/hw/hfi1/firmware.c           |  44 +----
 drivers/infiniband/hw/hfi1/hfi.h                |  54 +-----
 drivers/infiniband/hw/hfi1/init.c               |  53 +----
 drivers/infiniband/hw/hfi1/intr.c               |  44 +----
 drivers/infiniband/hw/hfi1/iowait.h             |  49 +----
 drivers/infiniband/hw/hfi1/ipoib_tx.c           |   3 +
 drivers/infiniband/hw/hfi1/mad.c                |  44 +----
 drivers/infiniband/hw/hfi1/mad.h                |  45 +----
 drivers/infiniband/hw/hfi1/mmu_rb.c             |  45 +----
 drivers/infiniband/hw/hfi1/mmu_rb.h             |  45 +----
 drivers/infiniband/hw/hfi1/msix.c               |  43 -----
 drivers/infiniband/hw/hfi1/msix.h               |  44 +----
 drivers/infiniband/hw/hfi1/opa_compat.h         |  48 +----
 drivers/infiniband/hw/hfi1/pcie.c               |  55 +-----
 drivers/infiniband/hw/hfi1/pio.c                |  44 +----
 drivers/infiniband/hw/hfi1/pio.h                |  48 +----
 drivers/infiniband/hw/hfi1/pio_copy.c           |  44 +----
 drivers/infiniband/hw/hfi1/platform.c           |  44 +----
 drivers/infiniband/hw/hfi1/platform.h           |  45 +----
 drivers/infiniband/hw/hfi1/qp.c                 |  44 +----
 drivers/infiniband/hw/hfi1/qp.h                 |  48 +----
 drivers/infiniband/hw/hfi1/qsfp.c               |  44 +----
 drivers/infiniband/hw/hfi1/qsfp.h               |  44 +----
 drivers/infiniband/hw/hfi1/rc.c                 |  44 +----
 drivers/infiniband/hw/hfi1/ruc.c                |  46 +----
 drivers/infiniband/hw/hfi1/sdma.c               |  46 +----
 drivers/infiniband/hw/hfi1/sdma.h               |  49 +----
 drivers/infiniband/hw/hfi1/sdma_txreq.h         |  44 +----
 drivers/infiniband/hw/hfi1/sysfs.c              |  45 +----
 drivers/infiniband/hw/hfi1/tid_rdma.c           |   4 +-
 drivers/infiniband/hw/hfi1/trace.c              |  44 +----
 drivers/infiniband/hw/hfi1/trace.h              |  44 +----
 drivers/infiniband/hw/hfi1/trace_ctxts.h        |  45 +----
 drivers/infiniband/hw/hfi1/trace_dbg.h          |  45 +----
 drivers/infiniband/hw/hfi1/trace_ibhdrs.h       |  45 +----
 drivers/infiniband/hw/hfi1/trace_misc.h         |  45 +----
 drivers/infiniband/hw/hfi1/trace_mmu.h          |  45 +----
 drivers/infiniband/hw/hfi1/trace_rc.h           |  45 +----
 drivers/infiniband/hw/hfi1/trace_rx.h           |  45 +----
 drivers/infiniband/hw/hfi1/trace_tx.h           |  44 +----
 drivers/infiniband/hw/hfi1/uc.c                 |  44 +----
 drivers/infiniband/hw/hfi1/ud.c                 |  44 +----
 drivers/infiniband/hw/hfi1/user_exp_rcv.c       |  57 +-----
 drivers/infiniband/hw/hfi1/user_exp_rcv.h       |  49 +----
 drivers/infiniband/hw/hfi1/user_pages.c         |  44 +----
 drivers/infiniband/hw/hfi1/user_sdma.c          |  45 +----
 drivers/infiniband/hw/hfi1/user_sdma.h          |  49 +----
 drivers/infiniband/hw/hfi1/verbs.c              |  44 +----
 drivers/infiniband/hw/hfi1/verbs.h              |  44 +----
 drivers/infiniband/hw/hfi1/verbs_txreq.c        |  44 +----
 drivers/infiniband/hw/hfi1/verbs_txreq.h        |  44 +----
 drivers/infiniband/hw/hfi1/vnic.h               |  48 +----
 drivers/infiniband/hw/hfi1/vnic_main.c          |  44 +----
 drivers/infiniband/hw/hfi1/vnic_sdma.c          |  44 +----
 drivers/infiniband/hw/hns/hns_roce_alloc.c      |  74 +------
 drivers/infiniband/hw/hns/hns_roce_db.c         |   4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h     |  30 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c      |   6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c      |  87 ++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h      |  23 +--
 drivers/infiniband/hw/hns/hns_roce_main.c       |  40 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c         |   4 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c         |  31 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c         | 196 ++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_srq.c        |  28 +--
 drivers/infiniband/hw/irdma/protos.h            |   2 -
 drivers/infiniband/hw/irdma/utils.c             |   3 -
 drivers/infiniband/hw/irdma/verbs.c             |  33 ++--
 drivers/infiniband/hw/mlx4/doorbell.c           |   3 +-
 drivers/infiniband/hw/mlx4/main.c               |   1 +
 drivers/infiniband/hw/mlx4/mlx4_ib.h            |   5 +-
 drivers/infiniband/hw/mlx4/mr.c                 |   4 +-
 drivers/infiniband/hw/mlx4/qp.c                 |  25 +--
 drivers/infiniband/hw/mlx5/doorbell.c           |   3 +-
 drivers/infiniband/hw/mlx5/gsi.c                |  51 ++---
 drivers/infiniband/hw/mlx5/main.c               | 145 ++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h            |   7 +-
 drivers/infiniband/hw/mlx5/mr.c                 |   3 +-
 drivers/infiniband/hw/mlx5/qp.c                 | 232 +++++++++++++++++---=
--
 drivers/infiniband/hw/mthca/mthca_eq.c          |  21 +-
 drivers/infiniband/hw/mthca/mthca_main.c        |  15 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c     |  25 +--
 drivers/infiniband/hw/mthca/mthca_provider.c    |  77 +++-----
 drivers/infiniband/hw/ocrdma/ocrdma_main.c      |   1 +
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  25 +--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     |   5 +-
 drivers/infiniband/hw/qedr/main.c               |   1 +
 drivers/infiniband/hw/qedr/qedr_roce_cm.c       |  13 +-
 drivers/infiniband/hw/qedr/qedr_roce_cm.h       |   5 +-
 drivers/infiniband/hw/qedr/verbs.c              | 101 +++++-----
 drivers/infiniband/hw/qedr/verbs.h              |   4 +-
 drivers/infiniband/hw/qib/qib_file_ops.c        |  12 +-
 drivers/infiniband/hw/qib/qib_init.c            |   4 +-
 drivers/infiniband/hw/qib/qib_user_pages.c      |  12 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c     |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c   |  34 ++--
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.h   |  10 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  69 ++++---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h    |   5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c  |  15 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c    |  53 ++---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |   5 +-
 drivers/infiniband/sw/rdmavt/ah.c               |  44 +----
 drivers/infiniband/sw/rdmavt/ah.h               |  50 +----
 drivers/infiniband/sw/rdmavt/cq.c               |  44 +----
 drivers/infiniband/sw/rdmavt/cq.h               |  50 +----
 drivers/infiniband/sw/rdmavt/mad.c              |  44 +----
 drivers/infiniband/sw/rdmavt/mad.h              |  50 +----
 drivers/infiniband/sw/rdmavt/mcast.c            |  44 +----
 drivers/infiniband/sw/rdmavt/mcast.h            |  50 +----
 drivers/infiniband/sw/rdmavt/mmap.c             |  44 +----
 drivers/infiniband/sw/rdmavt/mmap.h             |  50 +----
 drivers/infiniband/sw/rdmavt/mr.c               |  46 +----
 drivers/infiniband/sw/rdmavt/mr.h               |  50 +----
 drivers/infiniband/sw/rdmavt/pd.c               |  44 +----
 drivers/infiniband/sw/rdmavt/pd.h               |  50 +----
 drivers/infiniband/sw/rdmavt/qp.c               | 146 ++++----------
 drivers/infiniband/sw/rdmavt/qp.h               |  55 +-----
 drivers/infiniband/sw/rdmavt/rc.c               |  44 +----
 drivers/infiniband/sw/rdmavt/srq.c              |  44 +----
 drivers/infiniband/sw/rdmavt/srq.h              |  50 +----
 drivers/infiniband/sw/rdmavt/trace.c            |  44 +----
 drivers/infiniband/sw/rdmavt/trace.h            |  44 +----
 drivers/infiniband/sw/rdmavt/trace_cq.h         |  44 +----
 drivers/infiniband/sw/rdmavt/trace_mr.h         |  44 +----
 drivers/infiniband/sw/rdmavt/trace_qp.h         |  44 +----
 drivers/infiniband/sw/rdmavt/trace_rc.h         |  44 +----
 drivers/infiniband/sw/rdmavt/trace_rvt.h        |  44 +----
 drivers/infiniband/sw/rdmavt/trace_tx.h         |  44 +----
 drivers/infiniband/sw/rdmavt/vt.c               |  53 +----
 drivers/infiniband/sw/rdmavt/vt.h               |  50 +----
 drivers/infiniband/sw/rxe/rxe.h                 |  22 ---
 drivers/infiniband/sw/rxe/rxe_comp.c            |   4 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c            | 124 +++++++++++-
 drivers/infiniband/sw/rxe/rxe_loc.h             |  61 +-----
 drivers/infiniband/sw/rxe/rxe_mr.c              |  25 +--
 drivers/infiniband/sw/rxe/rxe_net.c             |  59 +++++-
 drivers/infiniband/sw/rxe/rxe_pool.c            |   2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c            |  23 +--
 drivers/infiniband/sw/rxe/rxe_req.c             |  13 +-
 drivers/infiniband/sw/rxe/rxe_resp.c            |  33 +---
 drivers/infiniband/sw/rxe/rxe_verbs.c           |  61 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.h           |   2 +-
 drivers/infiniband/sw/siw/siw_main.c            |   1 +
 drivers/infiniband/sw/siw/siw_qp.c              |   2 -
 drivers/infiniband/sw/siw/siw_qp_tx.c           |  44 +++--
 drivers/infiniband/sw/siw/siw_verbs.c           |  54 +++---
 drivers/infiniband/sw/siw/siw_verbs.h           |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c    |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c          | 157 ++++++++-------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h          |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h          |   6 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c          |  95 +++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h          |   6 -
 drivers/infiniband/ulp/rtrs/rtrs.c              |  23 ++-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c       |   4 +-
 include/linux/scatterlist.h                     |  56 +++++-
 include/rdma/ib_sa.h                            |  24 ---
 include/rdma/ib_umem.h                          |  11 +-
 include/rdma/ib_verbs.h                         |  74 ++++++-
 include/rdma/rdmavt_qp.h                        |   2 +-
 include/uapi/rdma/mlx5-abi.h                    |  17 +-
 lib/scatterlist.c                               | 155 +++++++++------
 lib/sg_pool.c                                   |   3 +-
 tools/testing/scatterlist/main.c                |  36 ++--
 217 files changed, 2075 insertions(+), 6609 deletions(-)
(diffstat from tag for-linus-merged)

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmEwD8QACgkQOG33FX4g
mxr9Bw/5AZEg6k/HraqJwiq5t4kq5vVRsUpKDsCFNbdhScOfkP+iLcTOPb/cM38M
KDTBEI0AS2jcfOk5eFIZ3XW7wpyAlW6nWLa/ZwVZKIFnhIr2vPo34Jpy383HmbMN
dKNkP/BQV/M2eD7gnNE8GXyOULB8YcHLbrVfh+e6qDsJt7TmB0yXHqkufpF22xRD
M6vD/78P/c+mIuMzqA6WpNFJdQeflvSIYr1KvvEafUvUvowQsOpURY2AvspDaW3m
nOo/xa7yvgTFtS16F07/QQuIIWrIjFGw7MVbFne/wHVBvJZ8ZJppS5RefHevRp1i
fPJnMIPHRTy0ZTe5Y2hXypsj0K+T98dlLAfV/kugNY8nRJ/gEyFq1aJC7DDSGCb4
+j9PYCERbsQdxPEDiT0Wp/klTmCnHOFF6y7IX98IljdJJ6aIkszW4Uw0ghAl7aSM
yYLAEWneIkLUvkieEhPyvLqxyYriae5FXVMbVfRbZifDHZm8/4anGAG0YIVtNZb6
TjcW3NMgdGQqm7OvaKHp5vcHVPzhVH5TtBcjA9CcMD2Ssr/DcTGTFZ/CljPiaARX
ppXZKQHPIwM+B3D9HDPck3h8vHyfQXH/EWRJD+3ZC9oWvd9xSsps1o4JhxxzjRXI
X8i9yNd+Wgpj62yJF1Z5yZuNDuj2j0VlEibmpJ/pM5aKNnbX4tY=
=MfMY
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
