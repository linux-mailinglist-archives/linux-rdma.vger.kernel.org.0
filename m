Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C41C7DFD2A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 00:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjKBXKB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 19:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKBXKA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 19:10:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1FBE5;
        Thu,  2 Nov 2023 16:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dScIbUkHPOxWL3fc2aVdHNDJu/OwQrM8Pus4pdPfhMCXCv2byRKCulszE+565wCQ/UzUB5Jdv0ekUFj77LMApVvskoDmMK/JXAeAU0FYTlg2GdYe2V2XVrBxkFFXN+/JvXuLDVlveRuNDfFOl+4EZ7n3f1k116WcBtzRS8G+UrTr69gF0FS/XAew6tFRJ42MBgwsnLnIx704NMBgcxMlfTD4RapajcKG4F5uvA1oB4lFEOverDNbHmNkza4SU6HQ4rUCmFpVjQw60xNKcxB2ihDENp1PkpHaA/zRcIRT5owsxVryKEordcPO/Nauq2JTCpXn1sdHa2YJnB/bQJ+gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnDHhgMGUbW+iQUpBzBp39BcsM6VV6YVU5NFNhCrt1A=;
 b=A1h0yrxzHQ6sq0PC+cUgCvpUqEzvQO+fzyfdNo5URYRQXU9El81uI3Y/T9SsBGrmEu88j6zW+g2Nzgu/mNuJYC1jPIGy191J1Tt4sh84JaQm4PZBM1kUvxk+Xj1CRlfzaAP4vgKzdubSm8/uMJO5DxS/hY0kxq1QhoTcawxhwI6nCJcY0dT14WKpZciMuONVfghxMWLZaRXODzObaXGSc0hN7y6zdFZqlbR7+gcpopcsZlXwqH87ktTFjzZtJo+yxX576TETSM/hC2PE+55it8k7XGe+GZpaoT+Ku79rGu26Lksi/ZgrVfjODvH2UCKsCq43jfm2SiRfq858z+4hJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnDHhgMGUbW+iQUpBzBp39BcsM6VV6YVU5NFNhCrt1A=;
 b=B06ptFUPz4/YzwlCXzeHp794iGjXjrSvEg0giSb95Dla8iP8lnJNePbYWQTl19tMof2nYqNcsynKnW+NpbOTNpKIDrXFnUEntV+A7zvtMiNEJvHX8VJTCRJ7oCIioUOonPHrBf+VGSXXh1dJxXJ4VrB8z2cmuowPxcSJvZPGnFSaNUfBZoI2Nz3iUt4tsuWnA3Qh7Sj2olbA23OppFoiSc4yi46NCIkFCxa+20zZR3CQvwvZOAm0F9vtHh/pp7yrbVVAepTr+B9loA2Fp6B3Reu4exw99oeufrnLXYGp1BBUSN3DKa0GwCSFQZ51rCJ5jRlaovjdH7+17ESF3uxoDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 23:09:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Thu, 2 Nov 2023
 23:09:49 +0000
Date:   Thu, 2 Nov 2023 20:09:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20231102230947.GA104602@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6KUxpPTkEikPdz7F"
Content-Disposition: inline
X-ClientProxiedBy: BLAPR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:208:32f::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 345f7362-d644-4a4f-c359-08dbdbf8d022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eG/tX9ChyFW2jx++YAKB7fT/4zQyA2zNayn1v85aw4C2H7sdjWMAgMBrBrhBbcSzpWXdDv6k8cJHjeZ9wkC1psNrdpEFoRnmV/MgGCnK5uJxNrRCaR1JAkwalVnAJb5BGtzbsgC3NdsqGVvTmR/DPH3o+bax/HZFBz731vdX+cma3Lw155LnstWOBXOmjCSKB7gqvnQZDAdTCWp2qw8/RWEv6MJ9hREGUAfX3bNV+TMgAZhViRLPJcs+vu9PApH/NEgFA7XyHIQ+CC5RxRZ/j0XiSvCHbVaoQvdVOb6FyG54EJzi9WmRtcm2TF+6DC/2UyQrl0DUf76B71gJL+tABNFySi+Pn+1d9G2V+4cMdImX8gP48JIEq0W7l+a6lyFj9cnrgK2ms/d5DvAO7kDcXPXIEnovakfmp5KyZ3HH9s1zxfqtzABIs2sUjRD/VRM3ZuORw1YJsXDzNj1qgZeWHdBinPtj3K9Oqs7NQJ8hDnw6L8VKqE32pv3nGzxN2ptO0vE0R3IjUKrlNmz3AfAotiTtnB/TQZ1LEiXZMilWuptDSL4aR6Yc0PWUWFHKeRYEOLUYB7Gm03vVbccLJj9UIDg2NtFWr4f4r201YwtWiDGHfIcj6pCT0j8xnshmEadkBD5Yi7RHwSHPs0gBUKR7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2616005)(6512007)(1076003)(26005)(478600001)(6916009)(33964004)(4001150100001)(6506007)(44144004)(66574015)(83380400001)(2906002)(107886003)(66476007)(66556008)(21480400003)(41300700001)(316002)(8936002)(5660300002)(8676002)(4326008)(30864003)(66946007)(6486002)(33656002)(38100700002)(86362001)(36756003)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk1BQkh5cDcrbkJKZEZSYnJUSUVnbEZPcmp0WVNVbGlPNVM3Y0FLYlVETnNa?=
 =?utf-8?B?Vk94dHdHY0g5ZUtFamdLVURpQnJIR0poaHNrMzRPVVZPNjdib3dCYkgzS1Mz?=
 =?utf-8?B?amlQbFFBN29jRkhXV2xhaERuRkdZczkyeDVUUXZuOUtKMzVZbDBTTjltMTFS?=
 =?utf-8?B?Vm82c0Z6VUMyRWU1b09QZDlKVlREMDdrOWhyUTBTV1NPWWk0NjhlMUx0U0Z4?=
 =?utf-8?B?dWk2bWdPV3hiMkY5bWRTdjI3VlN5bnFObXdHUmxsVDhjMXBkNUkyUUlaTDk3?=
 =?utf-8?B?bGdzbmZWWHRiM3N6YWFmclBBUldPKytURVZ6TDJKa0JTUVFhL1dtVUkva2dF?=
 =?utf-8?B?ZFVOb1krNE9ORkZlV1d0RGtrMW5rV1BKYkZ6Z1ZBQ3d0TElaSS81dnZrbmNX?=
 =?utf-8?B?cjAySlJ3cEppaGNpYmQ2Y1dkU0U3VHdUMVVWQThDZUM1bkJIamgvYnEzVFBC?=
 =?utf-8?B?RHBnc21WQ1l0c2FXSDFoM1l3RGlodUQ4Y1p2aVdHYXNHd1JCYzRISGlHMTVX?=
 =?utf-8?B?OGhYdWpyS0svd2hOUlNDT1ZBRmp6RUM1WEp3T3pTWHp0bXZLQXRYOTJxT2Mv?=
 =?utf-8?B?ZzVQWmNmWExVZFlQRURoQTB0RTBOdytLTGxsZHZBUElEQjdSRlpaN1ZHQm96?=
 =?utf-8?B?MVJsOGFEdWJaUzQ0dUNwaVpDTDQzSE5IRkdEL0tvUlhOMXFTYU8zVTBLOGhZ?=
 =?utf-8?B?dEdGQXlYVm5LcjYwVEJXZkdrTmtYK1FOTUNXVktaLzZqUXFpN1E4YWxibitE?=
 =?utf-8?B?Q2JZZDBpNUlHQWxYYzhYRHJ5L3E5LythU0NDbXlFTzREL1QyQkkrdVlXYTE3?=
 =?utf-8?B?L3ArTHFyYllCWkNQQnFRK0JZY3h0RmVjR3lNK21hclNqdFhYcCtlVmZCTksw?=
 =?utf-8?B?VmU5UFBhSHBlb0RPRlFRZ2sxSXhvZ2w0Vyt1RHJ1cDdGeDlNOUpLUGxMeEk2?=
 =?utf-8?B?RkRwU2dSRjZPZ29FM0FWajVUY3QzK3d0Q2ZiTmRRNEloNERoVDhsOVptOHJq?=
 =?utf-8?B?UGowS2o1Y280bmhNZVdpa0w3bDJ4c1BTNWd6ODhzTEtmSWF3cnhGRFVSKzlC?=
 =?utf-8?B?Y0pLeWhiQTVFY1JxQVBtK0dKVUxOTkg4WHlYTnExL2N2cmpTUW9Pb2dGZkkz?=
 =?utf-8?B?YTdxN0M0T0VjMmg2cGdtOVVMbzltdFpzS2hscWFTWGNwdGZObnNFWldGVVRO?=
 =?utf-8?B?RnQwWlJwNURyYXl3TUQzWmVVb3IrRkx0MlRrVjJCOWJZOHNKWWdjVmptU3Zj?=
 =?utf-8?B?VndUbUYybkc1dndadzJhZlMzRTJYQ05wMWRlRU16L2d0WXJuUFB5TWRFZkFQ?=
 =?utf-8?B?a0lzcnNSWkZRS0w4dW5WK0VscmxDOUM4OXdaT1BidUdsYVhiRWtHejBGN0NS?=
 =?utf-8?B?c1lON2YrcUFsaUo3S0kzcFVUSUJocDA0ZGlZYThCcDdLZmNHdWI4aDdKUEds?=
 =?utf-8?B?V0NtZWJraFUzYXIyS1JTelh3T2tuRXJZZWxLRVRpYlRyMzY1dS9Qa0F6dHV5?=
 =?utf-8?B?bGR6QnBKRUdmVllYbEJ2SmdRWVpsak5KamlGV2hVaFFiN0JGeCt1MlRrc2tB?=
 =?utf-8?B?M1Q5dHZiNzl6RHQrWkkyUE1oejJSUC9aLzdUbkhPc2gxeDFlL1NxRjdEOWdk?=
 =?utf-8?B?aWw0NUFTM3dUMmszMXNtcWZ4Qkx2akVlUFVGWUJ1UmdHMTk2WWdBckxHWUhM?=
 =?utf-8?B?RElvWXYvNVhZTjV0SVJoOU0zYTg3TTNETHFmZDNvRlRFR0FIMVhNWXppNE5j?=
 =?utf-8?B?aC9tc3pabU40OXhYcG1xZHB4QzFJUXF5eTNkcVBEOHUzTitnUVpjOXlMK3hP?=
 =?utf-8?B?aEJCYTNDRlF6WkIwT1Rid3luNTJZeGZ2ZUZqc3RkSmk5Q250S1BRd3RtMEFQ?=
 =?utf-8?B?QjBNT3pITEhkd01LK2srYzBVMmFiZWNCR0ZzRXVlNkUzcGlOZUFEK2JRbmhk?=
 =?utf-8?B?NTlyNkt4VmZ1YU5CNFRlYVFuYmtkQ2hGckNlRnRteTZmMUpZMDR0cTZ1THZi?=
 =?utf-8?B?NDFMa294TDU2VGM5ckI0MWpjYW4zNnBWdGRBbXkyMTVCbU53bXM2OFY1blRO?=
 =?utf-8?B?eDFHUFphOE1Hd2g0WGhQUldPZ1ZjaVhacmM5RVZLNGZzTFFWM2hOa1pSam11?=
 =?utf-8?Q?Znbc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345f7362-d644-4a4f-c359-08dbdbf8d022
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 23:09:49.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqP1pEDYhi2f6koryiwzOMAadKRL5O7tgMSXhe03fUVJfplLWkvjRzmfAdroMJt8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--6KUxpPTkEikPdz7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Nothing exciting this cycle, most of the diffstat is changing SPDX 'or'
to 'OR'.

Thanks,
Jason

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 2ef422f063b74adcc4a4a9004b0a87bb55e0a836:

  IB/mlx5: Fix init stage error handling to avoid double free of same QP an=
d UAF (2023-10-31 11:16:05 -0300)

----------------------------------------------------------------
RDMA for v6.7

The usual collection of patches:

- Bug fixes for hns, mlx5, and hfi1

- Hardening patches for size_*, counted_by, strscpy

- rts fixes from static analysis

- Dump SRQ objects in rdma netlink, with hns support

- Fix a performance regression in mlx5 MR deregistration

- New XDR (200Gb/lane) link speed

- SRQ record doorbell latency optimization for hns

- IPSEC support for mlx5 multi-port mode

- ibv_rereg_mr() support for irdma

- Affiliated event support for bnxt_re

- Opt out for the spec compliant qkey security enforcement as we
  discovered SW that breaks under enforcement

- Comment and trivial updates

----------------------------------------------------------------
Chandramohan Akula (3):
      RDMA/bnxt_re: Update HW interface headers
      RDMA/bnxt_re: Report async events and errors
      RDMA/bnxt_re: Do not report SRQ error in srq notification

Chengchang Tang (3):
      RDMA/hns: Fix printing level of asynchronous events
      RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
      RDMA/hns: Fix signed-unsigned mixed comparisons

Chengfeng Ye (1):
      IB/hfi1: Fix potential deadlock on &irq_src_lock and &dd->uctxt_lock

Chuck Lever (1):
      RDMA/core: Fix a couple of obvious typos in comments

Colin Ian King (1):
      RDMA/hfi1: Remove redundant assignment to pointer ppd

David Ahern (1):
      IB/hfi1: Remove open coded reference to skb frag offset

George Kennedy (1):
      IB/mlx5: Fix init stage error handling to avoid double free of same Q=
P and UAF

Gustavo A. R. Silva (1):
      RDMA/core: Use size_{add,sub,mul}() in calls to struct_size()

Ilpo J=C3=A4rvinen (1):
      RDMA/hfi1: Use FIELD_GET() to extract Link Width

Jason Gunthorpe (1):
      Merge tag 'v6.6' into rdma.git for-next

Junxian Huang (2):
      RDMA/hns: Fix unnecessary port_num transition in HW stats allocation
      RDMA/hns: Fix init failure of RoCE VF and HIP08

Justin Stitt (3):
      RDMA/irdma: Replace deprecated strncpy
      IB/hfi1: Replace deprecated strncpy
      IB/qib: Replace deprecated strncpy

Kees Cook (7):
      RDMA: Annotate struct rdma_hw_stats with __counted_by
      RDMA/core: Annotate struct ib_pkey_cache with __counted_by
      RDMA/usnic: Annotate struct usnic_uiom_chunk with __counted_by
      RDMA/siw: Annotate struct siw_pbl with __counted_by
      IB/srp: Annotate struct srp_fr_pool with __counted_by
      IB/mthca: Annotate struct mthca_icm_table with __counted_by
      IB/hfi1: Annotate struct tid_rb_node with __counted_by

Krzysztof Kozlowski (1):
      IB: Use capital "OR" for multiple licenses in SPDX

Leon Romanovsky (2):
      IPsec packet offload support in multiport RoCE devices
      RDMA/hfi1: Workaround truncation compilation error

Luoyouming (2):
      RDMA/hns: Add check for SL
      RDMA/hns: The UD mode can only be configured with DCQCN

Moshe Shemesh (1):
      RDMA/mlx5: Fix mkey cache WQ flush

Nathan Chancellor (1):
      RDMA/bnxt_re: Fix clang -Wimplicit-fallthrough in bnxt_re_handle_cq_a=
sync_error()

Or Har-Toov (2):
      IB/core: Add support for XDR link speed
      IB/mlx5: Expose XDR speed through MAD

Patrisious Haddad (7):
      IB/mlx5: Add support for 800G_8X lane speed
      IB/mlx5: Rename 400G_8X speed to comply to naming convention
      IB/mlx5: Adjust mlx5 rate mapping to support 800Gb
      RDMA/ipoib: Add support for XDR speed in ethtool
      IB/mlx5: Fix rdma counter binding for RAW QP
      RDMA/core: Add support to set privileged QKEY parameter
      RDMA/mlx5: Change the key being sent for MPV device affiliation

Rohit Chavan (1):
      RDMA/core: Fix repeated words in comments

Shay Drory (1):
      RDMA/mlx5: Implement mkeys management via LIFO queue

Sindhu Devale (1):
      RDMA/irdma: Add support to re-register a memory region

Yang Li (1):
      RDMA/core: Remove NULL check before dev_{put, hold}

Yangyang Li (1):
      RDMA/hns: Support SRQ record doorbell

Zhu Yanjun (2):
      RDMA/rtrs: Require holding rcu_read_lock explicitly
      RDMA/rtrs: Fix the problem of variable not initialized fully

wenglianfa (3):
      RDMA/core: Add dedicated SRQ resource tracker function
      RDMA/core: Add support to dump SRQ resource in RAW format
      RDMA/hns: Support SRQ restrack ops for hns driver

 drivers/infiniband/core/cache.c                   |   2 +-
 drivers/infiniband/core/core_priv.h               |   1 +
 drivers/infiniband/core/device.c                  |   4 +-
 drivers/infiniband/core/lag.c                     |   3 +-
 drivers/infiniband/core/nldev.c                   |  92 +++++-
 drivers/infiniband/core/rw.c                      |   2 +-
 drivers/infiniband/core/sa_query.c                |   4 +-
 drivers/infiniband/core/sysfs.c                   |  14 +-
 drivers/infiniband/core/user_mad.c                |   4 +-
 drivers/infiniband/core/uverbs_cmd.c              |   3 +-
 drivers/infiniband/core/uverbs_std_types_device.c |   3 +-
 drivers/infiniband/core/verbs.c                   |   7 +-
 drivers/infiniband/hw/bnxt_re/main.c              | 173 +++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_tlv.h         |   2 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h          |  58 ++++
 drivers/infiniband/hw/hfi1/affinity.c             |   2 +-
 drivers/infiniband/hw/hfi1/affinity.h             |   2 +-
 drivers/infiniband/hw/hfi1/aspm.h                 |   2 +-
 drivers/infiniband/hw/hfi1/chip.c                 |  11 +-
 drivers/infiniband/hw/hfi1/chip.h                 |   2 +-
 drivers/infiniband/hw/hfi1/chip_registers.h       |   2 +-
 drivers/infiniband/hw/hfi1/common.h               |   2 +-
 drivers/infiniband/hw/hfi1/debugfs.c              |   2 +-
 drivers/infiniband/hw/hfi1/debugfs.h              |   2 +-
 drivers/infiniband/hw/hfi1/device.c               |   2 +-
 drivers/infiniband/hw/hfi1/device.h               |   2 +-
 drivers/infiniband/hw/hfi1/driver.c               |   2 +-
 drivers/infiniband/hw/hfi1/efivar.c               |   4 +-
 drivers/infiniband/hw/hfi1/efivar.h               |   2 +-
 drivers/infiniband/hw/hfi1/eprom.c                |   2 +-
 drivers/infiniband/hw/hfi1/eprom.h                |   2 +-
 drivers/infiniband/hw/hfi1/exp_rcv.c              |   2 +-
 drivers/infiniband/hw/hfi1/exp_rcv.h              |   2 +-
 drivers/infiniband/hw/hfi1/fault.c                |   2 +-
 drivers/infiniband/hw/hfi1/fault.h                |   2 +-
 drivers/infiniband/hw/hfi1/file_ops.c             |   2 +-
 drivers/infiniband/hw/hfi1/firmware.c             |   2 +-
 drivers/infiniband/hw/hfi1/hfi.h                  |   2 +-
 drivers/infiniband/hw/hfi1/init.c                 |   3 +-
 drivers/infiniband/hw/hfi1/intr.c                 |   2 +-
 drivers/infiniband/hw/hfi1/iowait.h               |   2 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c             |   2 +-
 drivers/infiniband/hw/hfi1/mad.c                  |   2 +-
 drivers/infiniband/hw/hfi1/mad.h                  |   2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c               |   2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h               |   2 +-
 drivers/infiniband/hw/hfi1/opa_compat.h           |   2 +-
 drivers/infiniband/hw/hfi1/pcie.c                 |  11 +-
 drivers/infiniband/hw/hfi1/pio.c                  |   2 +-
 drivers/infiniband/hw/hfi1/pio.h                  |   2 +-
 drivers/infiniband/hw/hfi1/pio_copy.c             |   2 +-
 drivers/infiniband/hw/hfi1/platform.c             |   2 +-
 drivers/infiniband/hw/hfi1/platform.h             |   2 +-
 drivers/infiniband/hw/hfi1/qp.c                   |   2 +-
 drivers/infiniband/hw/hfi1/qp.h                   |   2 +-
 drivers/infiniband/hw/hfi1/qsfp.c                 |   2 +-
 drivers/infiniband/hw/hfi1/qsfp.h                 |   2 +-
 drivers/infiniband/hw/hfi1/rc.c                   |   2 +-
 drivers/infiniband/hw/hfi1/ruc.c                  |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c                 |   2 +-
 drivers/infiniband/hw/hfi1/sdma.h                 |   2 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h           |   2 +-
 drivers/infiniband/hw/hfi1/sysfs.c                |   2 +-
 drivers/infiniband/hw/hfi1/trace.c                |   2 +-
 drivers/infiniband/hw/hfi1/trace.h                |   2 +-
 drivers/infiniband/hw/hfi1/trace_ctxts.h          |   2 +-
 drivers/infiniband/hw/hfi1/trace_dbg.h            |   2 +-
 drivers/infiniband/hw/hfi1/trace_ibhdrs.h         |   2 +-
 drivers/infiniband/hw/hfi1/trace_misc.h           |   2 +-
 drivers/infiniband/hw/hfi1/trace_mmu.h            |   2 +-
 drivers/infiniband/hw/hfi1/trace_rc.h             |   2 +-
 drivers/infiniband/hw/hfi1/trace_rx.h             |   2 +-
 drivers/infiniband/hw/hfi1/trace_tx.h             |   2 +-
 drivers/infiniband/hw/hfi1/uc.c                   |   2 +-
 drivers/infiniband/hw/hfi1/ud.c                   |   2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c         |   2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.h         |   4 +-
 drivers/infiniband/hw/hfi1/user_pages.c           |   2 +-
 drivers/infiniband/hw/hfi1/user_sdma.c            |   2 +-
 drivers/infiniband/hw/hfi1/user_sdma.h            |   2 +-
 drivers/infiniband/hw/hfi1/verbs.c                |   2 +-
 drivers/infiniband/hw/hfi1/verbs.h                |   2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.c          |   2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h          |   2 +-
 drivers/infiniband/hw/hfi1/vnic.h                 |   2 +-
 drivers/infiniband/hw/hfi1/vnic_main.c            |   2 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c           |  13 +-
 drivers/infiniband/hw/hns/hns_roce_device.h       |   6 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c        |  90 ++++--
 drivers/infiniband/hw/hns/hns_roce_main.c         |  24 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c           |   2 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c     |  49 ++++
 drivers/infiniband/hw/hns/hns_roce_srq.c          |  85 +++++-
 drivers/infiniband/hw/irdma/cm.c                  |   2 +-
 drivers/infiniband/hw/irdma/cm.h                  |   2 +-
 drivers/infiniband/hw/irdma/ctrl.c                |   2 +-
 drivers/infiniband/hw/irdma/defs.h                |   2 +-
 drivers/infiniband/hw/irdma/hmc.c                 |   2 +-
 drivers/infiniband/hw/irdma/hmc.h                 |   2 +-
 drivers/infiniband/hw/irdma/hw.c                  |   2 +-
 drivers/infiniband/hw/irdma/i40iw_hw.c            |   2 +-
 drivers/infiniband/hw/irdma/i40iw_hw.h            |   2 +-
 drivers/infiniband/hw/irdma/i40iw_if.c            |   4 +-
 drivers/infiniband/hw/irdma/icrdma_hw.c           |   2 +-
 drivers/infiniband/hw/irdma/icrdma_hw.h           |   2 +-
 drivers/infiniband/hw/irdma/irdma.h               |   2 +-
 drivers/infiniband/hw/irdma/main.c                |   2 +-
 drivers/infiniband/hw/irdma/main.h                |   2 +-
 drivers/infiniband/hw/irdma/osdep.h               |   2 +-
 drivers/infiniband/hw/irdma/pble.c                |   2 +-
 drivers/infiniband/hw/irdma/pble.h                |   2 +-
 drivers/infiniband/hw/irdma/protos.h              |   2 +-
 drivers/infiniband/hw/irdma/puda.c                |   2 +-
 drivers/infiniband/hw/irdma/puda.h                |   2 +-
 drivers/infiniband/hw/irdma/trace.c               |   2 +-
 drivers/infiniband/hw/irdma/trace.h               |   2 +-
 drivers/infiniband/hw/irdma/trace_cm.h            |   2 +-
 drivers/infiniband/hw/irdma/type.h                |   2 +-
 drivers/infiniband/hw/irdma/uda.c                 |   2 +-
 drivers/infiniband/hw/irdma/uda.h                 |   2 +-
 drivers/infiniband/hw/irdma/uda_d.h               |   2 +-
 drivers/infiniband/hw/irdma/uk.c                  |   2 +-
 drivers/infiniband/hw/irdma/user.h                |   2 +-
 drivers/infiniband/hw/irdma/utils.c               |   2 +-
 drivers/infiniband/hw/irdma/verbs.c               | 234 +++++++++++++---
 drivers/infiniband/hw/irdma/verbs.h               |   4 +-
 drivers/infiniband/hw/irdma/ws.c                  |   2 +-
 drivers/infiniband/hw/irdma/ws.h                  |   2 +-
 drivers/infiniband/hw/mlx5/mad.c                  |  13 +
 drivers/infiniband/hw/mlx5/main.c                 |  12 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h              |  21 +-
 drivers/infiniband/hw/mlx5/mr.c                   | 326 ++++++++++--------=
----
 drivers/infiniband/hw/mlx5/qp.c                   |  29 +-
 drivers/infiniband/hw/mlx5/umr.c                  |   4 +-
 drivers/infiniband/hw/mthca/mthca_memfree.h       |   2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c           |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.h          |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  12 +-
 drivers/infiniband/sw/rdmavt/ah.c                 |   2 +-
 drivers/infiniband/sw/rdmavt/ah.h                 |   2 +-
 drivers/infiniband/sw/rdmavt/cq.c                 |   2 +-
 drivers/infiniband/sw/rdmavt/cq.h                 |   2 +-
 drivers/infiniband/sw/rdmavt/mad.c                |   2 +-
 drivers/infiniband/sw/rdmavt/mad.h                |   2 +-
 drivers/infiniband/sw/rdmavt/mcast.c              |   2 +-
 drivers/infiniband/sw/rdmavt/mcast.h              |   2 +-
 drivers/infiniband/sw/rdmavt/mmap.c               |   2 +-
 drivers/infiniband/sw/rdmavt/mmap.h               |   2 +-
 drivers/infiniband/sw/rdmavt/mr.c                 |   2 +-
 drivers/infiniband/sw/rdmavt/mr.h                 |   2 +-
 drivers/infiniband/sw/rdmavt/pd.c                 |   2 +-
 drivers/infiniband/sw/rdmavt/pd.h                 |   2 +-
 drivers/infiniband/sw/rdmavt/qp.c                 |   2 +-
 drivers/infiniband/sw/rdmavt/qp.h                 |   2 +-
 drivers/infiniband/sw/rdmavt/rc.c                 |   2 +-
 drivers/infiniband/sw/rdmavt/srq.c                |   2 +-
 drivers/infiniband/sw/rdmavt/srq.h                |   2 +-
 drivers/infiniband/sw/rdmavt/trace.c              |   2 +-
 drivers/infiniband/sw/rdmavt/trace.h              |   2 +-
 drivers/infiniband/sw/rdmavt/trace_cq.h           |   2 +-
 drivers/infiniband/sw/rdmavt/trace_mr.h           |   2 +-
 drivers/infiniband/sw/rdmavt/trace_qp.h           |   2 +-
 drivers/infiniband/sw/rdmavt/trace_rc.h           |   2 +-
 drivers/infiniband/sw/rdmavt/trace_rvt.h          |   2 +-
 drivers/infiniband/sw/rdmavt/trace_tx.h           |   2 +-
 drivers/infiniband/sw/rdmavt/vt.c                 |   2 +-
 drivers/infiniband/sw/rdmavt/vt.h                 |   2 +-
 drivers/infiniband/sw/siw/iwarp.h                 |   2 +-
 drivers/infiniband/sw/siw/siw.h                   |   4 +-
 drivers/infiniband/sw/siw/siw_cm.c                |   2 +-
 drivers/infiniband/sw/siw/siw_cm.h                |   2 +-
 drivers/infiniband/sw/siw/siw_cq.c                |   2 +-
 drivers/infiniband/sw/siw/siw_main.c              |   2 +-
 drivers/infiniband/sw/siw/siw_mem.c               |   2 +-
 drivers/infiniband/sw/siw/siw_mem.h               |   2 +-
 drivers/infiniband/sw/siw/siw_qp.c                |   2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c             |   2 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c             |   2 +-
 drivers/infiniband/sw/siw/siw_verbs.c             |   2 +-
 drivers/infiniband/sw/siw/siw_verbs.h             |   2 +-
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c      |   2 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c         |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c            |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.h               |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c    |   3 +-
 include/linux/mlx5/port.h                         |   3 +-
 include/rdma/ib_mad.h                             |   2 +
 include/rdma/ib_verbs.h                           |   8 +-
 include/uapi/rdma/hns-abi.h                       |  12 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h           |   3 +-
 include/uapi/rdma/rdma_netlink.h                  |   4 +
 include/uapi/rdma/siw-abi.h                       |   2 +-
 194 files changed, 1178 insertions(+), 498 deletions(-)
(diffstat after merge)

--6KUxpPTkEikPdz7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZUQsOQAKCRCFwuHvBreF
YVy8AP9+e5/OwxcO6Lmt5DWt/pZx1ICxsNHGkclk/geYJVEMzgEAuW2zyGyPTwyL
yrn3rpgbGkG9/fCHrp4Y/9195023Vww=
=9hmv
-----END PGP SIGNATURE-----

--6KUxpPTkEikPdz7F--
