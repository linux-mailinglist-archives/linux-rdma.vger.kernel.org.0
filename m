Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA01EEB55
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 21:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgFDTvs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 15:51:48 -0400
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:42683
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgFDTvr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jun 2020 15:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFx46DhM+L4EukZWFSSJlYa2iP6lKQhPOlOAf1w3RWb71OU54CFiiBjO6ZmZ29qQdOUry863NSM4zrg/fBJ0+wN1v21PrV1TM5wSN7t1DiFvooFI9QOUR4+L/ETrx8pkKVTHaRNS+8q56rJGxR6zTJTQZ7FdGcyIf7kFCmF/ygGIiIBsyxICj60NKWXc/7VzyTxFJtthLHyWHl3QglFznzGV+1JtXbJ6vbDIUcw2HNHaRWhTDx7S9JzaUboJaUM6ADsW5HVyV7MoiNZg+av86MWobaTCbVwgouLPbNbZnVdMNWWsH9rft4rkZtRcxAtPkDBqi7uPPEr/tJiHOXVixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI0yhrO85ZpBSD8URnVlgHY0jVbwHVSnwBoXulw+dN8=;
 b=WhL6hh1lVmLdQKtI3q78dR3CGec+Gwk4axuCxxVu14wM0QH3lYTtxrdDs51RInfX84aHML27FDYTRWeOdj1/2aaj3yk8H5Q8GNNOHIBn59XnSHhCignUorSK0aGTcwfRxxwxMVGXA3szPfICpo3liX8q0b1+FRj6nDdzAjXLFGvvoM7fr1NfBf75kFk3mk91xOyvPUd/F8bQoqsn5CLTe4Gyjt5+KPxp8yOWKGUfnNjOz94AjMWgREnfXJGBkxmdddv+gjlw4p9WYnUVq0ykYtuWzpfWqKQnkJOl7cU2wnFig09FRUJkLzUomnbOAHsoq3N5YchOE3IQGkmO60yN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI0yhrO85ZpBSD8URnVlgHY0jVbwHVSnwBoXulw+dN8=;
 b=p6iXTdchzdznjTRrAxBUy0pixA2/EcHDg6HBOjQNAPMOqGEhH4Ngkzmy440jc/bH/ky57MSIVS89rgZxnlUYTg+yAtr/imHNTXWjsq3BNGY5qZbRoO503U9PDJmDVBHZv6rzVcNR+Z+IrvYIZyGuFcmtNCnOJ8knhK31F1gYGL4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6941.eurprd05.prod.outlook.com (2603:10a6:800:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 19:51:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 19:51:35 +0000
Date:   Thu, 4 Jun 2020 16:51:31 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200604195131.GA362249@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR20CA0052.namprd20.prod.outlook.com
 (2603:10b6:208:235::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0052.namprd20.prod.outlook.com (2603:10b6:208:235::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend Transport; Thu, 4 Jun 2020 19:51:35 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jgvtj-001WKb-Qb; Thu, 04 Jun 2020 16:51:31 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09511b77-55af-4105-6f05-08d808c0afe2
X-MS-TrafficTypeDiagnostic: VI1PR05MB6941:
X-Microsoft-Antispam-PRVS: <VI1PR05MB69411A59C2E762A41593FE7FCF890@VI1PR05MB6941.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UebZ/gVN+I7ofpIQotrOkpX3hw5zhqrQ0cl+VqlelXYHwL08sHSSjK7+CYfiGqBmi66nmHA87GqlsswZt5n/rB7Bc3HePHmj+n7N7D2vHCH0xtwMerN70qagzw1pFFJRIFa6VqyqzDhzIHV/ndPa471w2XecBfhJhZPQzHo6Rv5Jt/dWXgW/BDFOpqjtps5RdG0A2jkwXLiiSjCH05T/6rzSQOdLGNl58lA44wm1temlMRbztJT4VP75HKpqhEDCBIwIXJE1FDCH20kc87VOji/1XSrkApbNoAkyxxo1mjSOIzgoieCuxZtqRFJFTttBe/RVsiNZvnD7A/lWYbMSiQh7+VkqZ9fZX/iYbIjybJapo2IvhEdkZR7Q6XahTs6SWHk6oP0fuTmMhhEqyswHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(83380400001)(33656002)(44144004)(8936002)(86362001)(66946007)(9686003)(66476007)(9746002)(8676002)(21480400003)(66556008)(9786002)(478600001)(26005)(186003)(5660300002)(110136005)(36756003)(4326008)(426003)(1076003)(30864003)(316002)(2906002)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: O8SyJz0WWWtVfjqZi80XLO7hq/N6trvk/mfnWJp+XfWClpjkSzm77XpA/IazT5GmyjPJ/laTqQpe5hwWcEKNVO5L+jCfVFdMymB0g+gSDH80dUBf1/WHP73j6nZ1FDDhx2gSq7qXdE0+FzInqDHhbsms60juR1AczzlGR/T8JMmGIjZ0YHzMOIz8zRFrliUicUUKGuAR+NhT28ZQapYk11o0EsAwR0JkHjcp+tMJcMbqiXK3NODCKcpVC+QtTEaHbZcI5kQ61viFb/7nBn+IXdKtpVpFdaC/9iVlqNspl2M7pd1P368HT4vYdou6GqpZAnGWEIsesxG7YosGxCqcCQg/qZRJ4RFbnzdBwLCHoPSN2PXKpCkwSM1aqrGsj++Amp8yNyBnIo/2Qqsco9NRw+udOcWA1KtqPfn1NuNY0lO2YWEBX5anwmLyfuhRX1tBUtLYW01UpeyYxSeQ2uPwjl/f08DbFbzqDa4N5ItjuY4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09511b77-55af-4105-6f05-08d808c0afe2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 19:51:35.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0GexDexK9sDMY/Fq4RTvGaaaGonh9MnRC/KKXFicronw+0DeImGlhKhFbJxT2qxYHuauCo+wve0rly/OOVRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6941
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.8.

A more active cycle than most of the recent past. In particular the new RNBD
block driver was Ack'd by Jens and is flowing through RDMA due to it also
introducing a new ULP.

Also a heads up, Mellanox has been acquired by NVIDIA and you'll probably see
a new email address from me and others this next cycle.

Thanks,
Jason

The following changes since commit 6b646a7e4af69814dd1a3340fca0f02d4977420d:

  net/mlx5: Add ability to read and write ECE options (2020-05-27 14:08:28 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to fba97dc7fc76b2c9a909fa0b3786d30a9899f5cf:

  RDMA/cm: Spurious WARNING triggered in cm_destroy_id() (2020-06-03 15:48:18 -0300)

----------------------------------------------------------------
RDMA 5.8 merge window pull request

A few large, long discussed works this time. The RNBD block driver has
been posted for nearly two years now, and the removal of FMR has been a
recurring discussion theme for a long time. The usual smattering of
features and bug fixes.

- Various small driver bugs fixes in rxe, mlx5, hfi1, and efa

- Continuing driver cleanups in bnxt_re, hns

- Big cleanup of mlx5 QP creation flows

- More consistent use of src port and flow label when LAG is used and a
  mlx5 implementation

- Additional set of cleanups for IB CM

- 'RNBD' network block driver and target. This is a network block RDMA
  device specific to ionos's cloud environment. It brings strong multipath
  and resiliency capabilities.

- Accelerated IPoIB for HFI1

- QP/WQ/SRQ ioctl migration for uverbs, and support for multiple async fds

- Support for exchanging the new IBTA defiend ECE data during RDMA CM
  exchanges

- Removal of the very old and insecure FMR interface from all ULPs and
  drivers. FRWR should be preferred for at least a decade now.

----------------------------------------------------------------
Aharon Landau (2):
      RDMA/mlx5: Verify that QP is created with RQ or SQ
      RDMA/mlx5: Add init2init as a modify command

Bart Van Assche (4):
      RDMA/srp: Make the channel count configurable per target
      RDMA/srpt: Make debug output more detailed
      RDMA/srpt: Reduce max_recv_sge to 1
      RDMA/srpt: Increase max_send_sge

Chuck Lever (1):
      RDMA/core: Move and rename trace_cm_id_create()

Colin Ian King (3):
      RDMA/mlx5: Remove duplicated assignment to variable rcqe_sz
      RDMA/hns: remove duplicate assignment to pointer raq
      IB/hfi1: Fix spelling mistake "enought" -> "enough"

Dan Carpenter (5):
      RDMA/rtrs: Fix some signedness bugs in error handling
      RDMA/rtrs: Fix a couple off by one bugs in rtrs_srv_rdma_done()
      block/rnbd: Fix an IS_ERR() vs NULL check in find_or_create_sess()
      IB/hfi1: Fix hfi1_netdev_rx_init() error handling
      RDMA/hns: Uninitialized variable in modify_qp_init_to_rtr()

Danil Kipnis (3):
      rnbd/rtrs: Pass max segment size from blk user to the rdma library
      RDMA/rnbd: Fix compilation error when CONFIG_MODULES is disabled
      RDMA/rtrs: Get rid of the do_next_path while_next_path macros

Danit Goldberg (1):
      RDMA/cm: Remove unused store to ret in cm_rej_handler

Daria Velikovsky (1):
      RDMA/mlx5: Add support for drop action in DV steering

Devesh Sharma (4):
      RDMA/bnxt_re: Reduce device page size detection code
      RDMA/bnxt_re: Update missing hsi data structures
      RDMA/bnxt_re: Simplify obtaining queue entry from hw ring
      RDMA/bnxt_re: Remove dead code from rcfw

Gal Pressman (6):
      RDMA/efa: Report create CQ error counter
      RDMA/efa: Count mmap failures
      RDMA/efa: Count admin commands errors
      RDMA/efa: Fix setting of wrong bit in get/set_feature commands
      RDMA/efa: Report host information to the device
      RDMA/mlx5: Remove FMR leftovers

Gary Leshner (6):
      IB/hfi1: Add functions to transmit datagram ipoib packets
      IB/hfi1: Add the transmit side of a datagram ipoib RDMA netdev
      IB/hfi1: Remove module parameter for KDETH qpns
      IB/{rdmavt, hfi1}: Implement creation of accelerated UD QPs
      IB/{hfi1, ipoib, rdma}: Broadcast ping sent packets which exceeded mtu size
      IB/ipoib: Add capability to switch between datagram and connected mode

Grzegorz Andrejczuk (6):
      IB/hfi1: RSM rules for AIP
      IB/hfi1: Rename num_vnic_contexts as num_netdev_contexts
      IB/hfi1: Add interrupt handler functions for accelerated ipoib
      IB/hfi1: Add rx functions for dummy netdev
      IB/hfi1: Activate the dummy netdev
      IB/hfi1: Add packet histogram trace event

Gustavo A. R. Silva (4):
      IB/rdmavt: Replace zero-length array with flexible-array
      RDMA/rtrs: client: Fix function return on success
      RDMA/siw: Replace one-element array and use struct_size() helper
      RDMA/core: Use sizeof_field() helper

Israel Rukshin (1):
      RDMA/iser: Remove support for FMR memory registration

Jack Wang (25):
      sysfs: export sysfs_remove_file_self()
      RDMA/rtrs: public interface header to establish RDMA connections
      RDMA/rtrs: private headers with rtrs protocol structs and helpers
      RDMA/rtrs: core: lib functions shared between client and server modules
      RDMA/rtrs: client: private header with client structs and functions
      RDMA/rtrs: client: main functionality
      RDMA/rtrs: client: statistics functions
      RDMA/rtrs: client: sysfs interface functions
      RDMA/rtrs: server: private header with server structs and functions
      RDMA/rtrs: server: main functionality
      RDMA/rtrs: server: statistics functions
      RDMA/rtrs: server: sysfs interface functions
      RDMA/rtrs: include client and server modules into kernel compilation
      RDMA/rtrs: a bit of documentation
      block/rnbd: private headers with rnbd protocol structs and helpers
      block/rnbd: client: private header with client structs and functions
      block/rnbd: client: main functionality
      block/rnbd: client: sysfs interface functions
      block/rnbd: server: private header with server structs and functions
      block/rnbd: server: main functionality
      block/rnbd: server: functionality for IO submitting to block dev
      block/rnbd: server: sysfs interface functions
      block/rnbd: include client and server modules into kernel compilation
      block/rnbd: a bit of documentation
      MAINTAINERS: Add maintainers for RNBD/RTRS modules

Jason Gunthorpe (24):
      RDMA/uverbs: Make the event_queue fds return POLLERR when disassociated
      RDMA: Remove a few extra calls to ib_get_client_data()
      Merge branch 'mlx5_ib_qp_refactor_1' into rdma.git for-next
      Merge branch 'mellanox/mlx5-next' into rdma.git for-next
      RDMA: Allow ib_client's to fail when add() is called
      RDMA/addr: Mark addr_resolve as might_sleep()
      RDMA/cm: Remove return code from add_cm_id_to_port_list
      RDMA/cm: Pull duplicated code into cm_queue_work_unlock()
      RDMA/cm: Pass the cm_id_private into cm_cleanup_timewait
      RDMA/cm: Add a note explaining how the timewait is eventually freed
      RDMA/cm: Make find_remote_id() return a cm_id_private
      RDMA/cm: Remove the cm_free_id() wrapper function
      RDMA/cm: Remove needless cm_id variable
      RDMA/cm: Increment the refcount inside cm_find_listen()
      Merge branch 'mellanox/mlx5-next' into rdma.git for/next
      RDMA/core: Consolidate ib_create_srq flows
      Merge tag 'v5.7-rc6' into rdma.git for-next
      RDMA/core: Allow the ioctl layer to abort a fully created uobject
      Merge branch 'mellanox/mlx5-next' into rdma.git for/next
      RDMA/core: Use offsetofend() instead of open coding
      RDMA/bnxt_re: Remove FMR leftovers
      RDMA/i40iw: Remove FMR leftovers
      RDMA: Remove 'max_fmr'
      RDMA: Remove 'max_map_per_fmr'

Ka-Cheong Poon (1):
      RDMA/cm: Spurious WARNING triggered in cm_destroy_id()

Kaike Wan (3):
      IB/hfi1: Add accelerated IP capability bit
      IB/ipoib: Increase ipoib Datagram mode MTU's upper limit
      IB/hfi1: Add functions to receive accelerated ipoib packets

Kamal Heib (2):
      RDMA/srpt: Fix disabling device management
      RDMA/ipoib: Remove can_sleep parameter from iboib_mcast_alloc

Lang Cheng (11):
      RDMA/hns: Simplify the qp state convert code
      RDMA/hns: Simplify the cqe code of poll cq
      RDMA/hns: Simplify the state judgment code of qp
      RDMA/hns: Simplify the status judgment code of hns_roce_v1_m_qp()
      RDMA/hns: Combine enable flags of qp
      RDMA/hns: Fix cmdq parameter of querying pf timer resource
      RDMA/hns: Store mr len information into mr obj
      RDMA/hns: Let software PI/CI grow naturally
      RDMA/hns: Add CQ flag instead of independent enable flag
      RDMA/hns: Optimize post and poll process
      RDMA/hns: Simplify process related to poll cq

Leon Romanovsky (57):
      RDMA/cma: Limit the scope of rdma_is_consumer_reject function
      RDMA/bnxt: Delete 'nq_ptr' variable which is not used
      RDMA/mlx5: Organize QP types checks in one place
      RDMA/mlx5: Delete impossible GSI port check
      RDMA/mlx5: Perform check if QP creation flow is valid
      RDMA/mlx5: Prepare QP allocation for future removal
      RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
      RDMA/mlx5: Set QP subtype immediately when it is known
      RDMA/mlx5: Separate create QP flows to be based on type
      RDMA/mlx5: Split scatter CQE configuration for DCT QP
      RDMA/mlx5: Update all DRIVER QP places to use QP subtype
      RDMA/mlx5: Move DRIVER QP flags check into separate function
      RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
      RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
      RDMA/mlx5: Delete create QP flags obfuscation
      RDMA/mlx5: Process create QP flags in one place
      RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE signature
      RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
      RDMA/mlx5: Return all configured create flags through query QP
      RDMA/mlx5: Process all vendor flags in one place
      RDMA/mlx5: Delete unsupported QP types
      RDMA/mlx5: Store QP type in the vendor QP structure
      RDMA/mlx5: Promote RSS RAW QP attribute check in higher level
      RDMA/mlx5: Combine copy of create QP command in RSS RAW QP
      RDMA/mlx5: Remove second user copy in create_user_qp
      RDMA/mlx5: Rely on existence of udata to separate kernel/user flows
      RDMA/mlx5: Delete impossible inlen check
      RDMA/mlx5: Globally parse DEVX UID
      RDMA/mlx5: Separate XRC_TGT QP creation from common flow
      RDMA/mlx5: Separate to user/kernel create QP flows
      RDMA/mlx5: Reduce amount of duplication in QP destroy
      RDMA/mlx5: Group all create QP parameters to simplify in-kernel interfaces
      RDMA/mlx5: Promote RSS RAW QP flags check to higher level
      RDMA/mlx5: Handle udate outlen checks in one place
      RDMA/mlx5: Copy response to the user in one place
      RDMA/mlx5: Remove redundant destroy QP call
      RDMA/mlx5: Consolidate into special function all create QP calls
      RDMA/mlx5: Update mlx5_ib to use new cmd interface
      RDMA/mlx5: Move all WR logic from qp.c to separate file
      RDMA/ucma: Return stable IB device index as identifier
      RDMA/mlx5: Fix query_srq_cmd() function
      RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
      RDMA/ucma: Extend ucma_connect to receive ECE parameters
      RDMA/ucma: Deliver ECE parameters through UCMA events
      RDMA/cm: Send and receive ECE parameter over the wire
      RDMA/cma: Connect ECE to rdma_accept
      RDMA/cma: Provide ECE reject reason
      RDMA/mlx5: Get ECE options from FW during create QP
      RDMA/mlx5: Set ECE options during QP create
      RDMA/mlx5: Use direct modify QP implementation
      RDMA/mlx5: Remove manually crafted QP context the query call
      RDMA/mlx5: Convert modify QP to use MLX5_SET macros
      RDMA/mlx5: Set ECE options during modify QP
      RDMA/mlx5: Return ECE data after modify QP
      RDMA/mlx5: Return an error if copy_to_user fails
      RDMA/mlx5: Don't rely on FW to set zeros in ECE response
      RDMA/mlx5: Return ECE DC support

Lijun Ou (4):
      RDMA/hns: Optimize hns_roce_config_link_table()
      RDMA/hns: Optimize hns_roce_v2_set_mac()
      RDMA/hns: Bugfix for querying qkey
      RDMA/hns: Reserve one sge in order to avoid local length error

Maor Gottlieb (10):
      RDMA: Group create AH arguments in struct
      RDMA/core: Add LAG functionality
      RDMA/core: Get xmit slave for LAG
      RDMA/mlx5: Refactor affinity related code
      RDMA/mlx5: Set lag tx affinity according to slave
      RDMA/mad: Remove snoop interface
      RDMA/core: Consider flow label when building skb
      RDMA/mlx5: Refactor DV create flow
      RDMA/mlx5: Add support in steering default miss
      IB/cma: Fix ports memory leak in cma_configfs

Mark Bloch (2):
      RDMA/mlx5: Assign profile before calling stages
      RDMA/mlx5: Allow only raw Ethernet QPs when RoCE isn't enabled

Mark Zhang (6):
      RDMA/core: Add hash functions to calculate RoCEv2 flowlabel and UDP source port
      RDMA/mlx5: Define RoCEv2 udp source port when set path
      RDMA/cma: Initialize the flow label of CM's route path record
      RDMA/mlx5: Set UDP source port based on the grh.flow_label
      IB/mlx5: Fix DEVX support for MLX5_CMD_OP_INIT2INIT_QP command
      RDMA/mlx5: Support TX port affinity for VF drivers in LAG mode

Mauro Carvalho Chehab (1):
      IB: Fix some documentation warnings

Max Gurtovoy (9):
      RDMA/rw: use DIV_ROUND_UP to calculate nr_ops
      RDMA/mlx5: Refactor mlx5_post_send() to improve readability
      RDMA/srp: Remove support for FMR memory registration
      RDMA/rds: Remove FMR support for memory registration
      RDMA/core: Remove FMR pool API
      RDMA/mlx4: Remove FMR support for memory registration
      RDMA/mthca: Remove FMR support for memory registration
      RDMA/rdmavt: Remove FMR memory registration
      RDMA/core: Remove FMR device ops

Md Haris Iqbal (1):
      RDMA/rtrs: server: Use already dereferenced rtrs_sess structure

Piotr Stankiewicz (1):
      IB/hfi1: Enable the transmit side of the datagram ipoib netdev

Potnuri Bharat Teja (1):
      RDMA/iw_cxgb4: cleanup device debugfs entries on ULD remove

Qiushi Wu (1):
      RDMA/core: Fix several reference count leaks.

Shay Drory (1):
      RDMA/mlx5: Update mlx5_ib driver name

Wei Yongjun (1):
      RDMA/rtrs: server: Fix some error return code

Weihang Li (9):
      RDMA/hns: Fix comments with non-English symbols
      RDMA/hns: Adjust lp_pktn_ini dynamically
      RDMA/hns: Extend capability flags for HIP08_C
      RDMA/hns: Fix wrong assignment of SRQ's max_wr
      RDMA/hns: Fix error with to_hr_hem_entries_count()
      RDMA/hns: Remove redundant memcpy()
      RDMA/hns: Change all page_shift to unsigned
      RDMA/hns: Change variables representing quantity to unsigned
      RDMA/hns: Remove redundant type cast for general pointers

Wenpeng Liang (3):
      RDMA/hns: Remove redundant assignment of caps
      RDMA/hns: Fix assignment to ba_pg_sz of eqe
      RDMA/hns: Remove redundant parameters from free_srq/qp_wrid()

Xi Wang (14):
      RDMA/hns: Add support for addressing when hopnum is 0
      RDMA/hns: Optimize hns buffer allocation flow
      RDMA/hns: Optimize 0 hop addressing for EQE buffer
      RDMA/hns: Support 0 hop addressing for WQE buffer
      RDMA/hns: Support 0 hop addressing for SRQ buffer
      RDMA/hns: Support 0 hop addressing for CQE buffer
      RDMA/hns: Optimize PBL buffer allocation process
      RDMA/hns: Remove unused MTT functions
      RDMA/hns: Optimize WQE buffer size calculating process
      RDMA/hns: Optimize SRQ buffer size calculating process
      RDMA/hns: Rename macro for defining hns hardware page size
      RDMA/hns: Rename QP buffer related function
      RDMA/hns: Refactor the QP context filling process related to WQE buffer configure
      RDMA/hns: Optimize the usage of MTR

Xiongfeng Wang (1):
      RDMA/srpt: Add a newline when printing parameter 'srpt_service_guid' by sysfs

Yamin Friedman (2):
      RDMA/core: Add protection for shared CQs used by ULPs
      RDMA/core: Introduce shared CQ pool API

Yangyang Li (1):
      RDMA/hns: Remove unused code about assert

Yishai Hadas (9):
      RDMA/mlx5: Fix udata response upon SRQ creation
      RDMA/uverbs: Cleanup wq/srq context usage from uverbs layer
      RDMA/uverbs: Fix create WQ to use the given user handle
      IB/uverbs: Refactor related objects to use their own asynchronous event FD
      IB/uverbs: Extend CQ to get its own asynchronous event FD
      IB/uverbs: Move QP, SRQ, WQ type and flags to UAPI
      IB/uverbs: Introduce create/destroy SRQ commands over ioctl
      IB/uverbs: Introduce create/destroy WQ commands over ioctl
      IB/uverbs: Introduce create/destroy QP commands over ioctl

Yixian Liu (2):
      RDMA/hns: Move SRQ code to the reasonable place
      RDMA/hns: Make the end of sge process more clear

YueHaibing (1):
      IB/hfi1: Use free_netdev() in hfi1_netdev_free()

Zhu Yanjun (1):
      RDMA/rxe: Set default vendor ID

Zou Wei (1):
      IB/qib: Remove unused variable ret

 Documentation/ABI/testing/sysfs-block-rnbd        |   46 +
 Documentation/ABI/testing/sysfs-class-rnbd-client |  111 +
 Documentation/ABI/testing/sysfs-class-rnbd-server |   50 +
 Documentation/ABI/testing/sysfs-class-rtrs-client |  131 +
 Documentation/ABI/testing/sysfs-class-rtrs-server |   53 +
 Documentation/driver-api/infiniband.rst           |    3 -
 Documentation/infiniband/core_locking.rst         |    2 -
 MAINTAINERS                                       |   14 +
 drivers/block/Kconfig                             |    2 +
 drivers/block/Makefile                            |    1 +
 drivers/block/rnbd/Kconfig                        |   28 +
 drivers/block/rnbd/Makefile                       |   15 +
 drivers/block/rnbd/README                         |   92 +
 drivers/block/rnbd/rnbd-clt-sysfs.c               |  639 ++++
 drivers/block/rnbd/rnbd-clt.c                     | 1729 +++++++++
 drivers/block/rnbd/rnbd-clt.h                     |  156 +
 drivers/block/rnbd/rnbd-common.c                  |   23 +
 drivers/block/rnbd/rnbd-log.h                     |   41 +
 drivers/block/rnbd/rnbd-proto.h                   |  303 ++
 drivers/block/rnbd/rnbd-srv-dev.c                 |  134 +
 drivers/block/rnbd/rnbd-srv-dev.h                 |   92 +
 drivers/block/rnbd/rnbd-srv-sysfs.c               |  215 ++
 drivers/block/rnbd/rnbd-srv.c                     |  844 +++++
 drivers/block/rnbd/rnbd-srv.h                     |   78 +
 drivers/infiniband/Kconfig                        |    1 +
 drivers/infiniband/core/Makefile                  |    9 +-
 drivers/infiniband/core/addr.c                    |    4 +
 drivers/infiniband/core/cm.c                      |  306 +-
 drivers/infiniband/core/cma.c                     |  114 +-
 drivers/infiniband/core/cma_configfs.c            |   13 +
 drivers/infiniband/core/cma_priv.h                |    1 +
 drivers/infiniband/core/cma_trace.h               |   20 +-
 drivers/infiniband/core/core_priv.h               |    3 +
 drivers/infiniband/core/cq.c                      |  173 +
 drivers/infiniband/core/device.c                  |   22 +-
 drivers/infiniband/core/fmr_pool.c                |  494 ---
 drivers/infiniband/core/lag.c                     |  138 +
 drivers/infiniband/core/mad.c                     |  255 +-
 drivers/infiniband/core/multicast.c               |   12 +-
 drivers/infiniband/core/rdma_core.c               |   25 +-
 drivers/infiniband/core/rdma_core.h               |    7 +-
 drivers/infiniband/core/rw.c                      |    2 +-
 drivers/infiniband/core/sa_query.c                |   51 +-
 drivers/infiniband/core/sysfs.c                   |   10 +-
 drivers/infiniband/core/ucma.c                    |   65 +-
 drivers/infiniband/core/ud_header.c               |    2 +-
 drivers/infiniband/core/user_mad.c                |   22 +-
 drivers/infiniband/core/uverbs.h                  |   21 +-
 drivers/infiniband/core/uverbs_cmd.c              |   76 +-
 drivers/infiniband/core/uverbs_ioctl.c            |   24 +-
 drivers/infiniband/core/uverbs_main.c             |   40 +-
 drivers/infiniband/core/uverbs_std_types.c        |   95 -
 drivers/infiniband/core/uverbs_std_types_cq.c     |   17 +-
 drivers/infiniband/core/uverbs_std_types_mr.c     |   12 +-
 drivers/infiniband/core/uverbs_std_types_qp.c     |  401 ++
 drivers/infiniband/core/uverbs_std_types_srq.c    |  234 ++
 drivers/infiniband/core/uverbs_std_types_wq.c     |  194 +
 drivers/infiniband/core/uverbs_uapi.c             |    3 +
 drivers/infiniband/core/verbs.c                   |  159 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          |   76 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h          |   18 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c          |  357 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h          |   42 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c        |   88 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h        |   91 -
 drivers/infiniband/hw/bnxt_re/qplib_res.c         |    1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h         |   53 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c          |    3 -
 drivers/infiniband/hw/bnxt_re/qplib_sp.h          |    2 -
 drivers/infiniband/hw/bnxt_re/roce_hsi.h          |  106 +
 drivers/infiniband/hw/cxgb4/device.c              |    1 +
 drivers/infiniband/hw/efa/efa.h                   |    6 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h   |   63 +-
 drivers/infiniband/hw/efa/efa_com.c               |    5 +-
 drivers/infiniband/hw/efa/efa_com.h               |    3 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c           |   18 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h           |   11 +-
 drivers/infiniband/hw/efa/efa_main.c              |   52 +-
 drivers/infiniband/hw/efa/efa_verbs.c             |   19 +-
 drivers/infiniband/hw/hfi1/Makefile               |    4 +
 drivers/infiniband/hw/hfi1/affinity.c             |   12 +-
 drivers/infiniband/hw/hfi1/affinity.h             |    3 +-
 drivers/infiniband/hw/hfi1/chip.c                 |  303 +-
 drivers/infiniband/hw/hfi1/chip.h                 |    5 +-
 drivers/infiniband/hw/hfi1/common.h               |   13 +-
 drivers/infiniband/hw/hfi1/driver.c               |  231 +-
 drivers/infiniband/hw/hfi1/file_ops.c             |    4 +-
 drivers/infiniband/hw/hfi1/hfi.h                  |   38 +-
 drivers/infiniband/hw/hfi1/init.c                 |   13 +-
 drivers/infiniband/hw/hfi1/ipoib.h                |  171 +
 drivers/infiniband/hw/hfi1/ipoib_main.c           |  309 ++
 drivers/infiniband/hw/hfi1/ipoib_rx.c             |   95 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c             |  828 +++++
 drivers/infiniband/hw/hfi1/msix.c                 |   36 +-
 drivers/infiniband/hw/hfi1/msix.h                 |    7 +-
 drivers/infiniband/hw/hfi1/netdev.h               |  118 +
 drivers/infiniband/hw/hfi1/netdev_rx.c            |  481 +++
 drivers/infiniband/hw/hfi1/qp.c                   |   18 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c             |    4 +-
 drivers/infiniband/hw/hfi1/trace.c                |   42 +-
 drivers/infiniband/hw/hfi1/trace_ctxts.h          |   11 +-
 drivers/infiniband/hw/hfi1/verbs.c                |   14 +-
 drivers/infiniband/hw/hfi1/vnic.h                 |    5 +-
 drivers/infiniband/hw/hfi1/vnic_main.c            |  325 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c           |    5 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c        |  148 +-
 drivers/infiniband/hw/hns/hns_roce_common.h       |    4 -
 drivers/infiniband/hw/hns/hns_roce_cq.c           |  351 +-
 drivers/infiniband/hw/hns/hns_roce_device.h       |  246 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c          |  114 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h          |   11 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c        |  360 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c        | 1713 ++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h        |   15 +-
 drivers/infiniband/hw/hns/hns_roce_main.c         |   71 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c           | 1644 +++------
 drivers/infiniband/hw/hns/hns_roce_qp.c           |  509 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c          |  378 +-
 drivers/infiniband/hw/i40iw/i40iw.h               |    9 -
 drivers/infiniband/hw/i40iw/i40iw_verbs.c         |    1 -
 drivers/infiniband/hw/i40iw/i40iw_verbs.h         |    1 -
 drivers/infiniband/hw/mlx4/ah.c                   |   11 +-
 drivers/infiniband/hw/mlx4/main.c                 |   11 -
 drivers/infiniband/hw/mlx4/mlx4_ib.h              |   18 +-
 drivers/infiniband/hw/mlx4/mr.c                   |   93 -
 drivers/infiniband/hw/mlx5/Makefile               |    3 +-
 drivers/infiniband/hw/mlx5/ah.c                   |   35 +-
 drivers/infiniband/hw/mlx5/cmd.c                  |  114 +-
 drivers/infiniband/hw/mlx5/cmd.h                  |    4 +-
 drivers/infiniband/hw/mlx5/cong.c                 |    4 +-
 drivers/infiniband/hw/mlx5/devx.c                 |   17 +-
 drivers/infiniband/hw/mlx5/flow.c                 |  147 +-
 drivers/infiniband/hw/mlx5/gsi.c                  |   38 +-
 drivers/infiniband/hw/mlx5/ib_rep.h               |    2 +-
 drivers/infiniband/hw/mlx5/main.c                 |   73 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h              |   72 +-
 drivers/infiniband/hw/mlx5/odp.c                  |   10 +-
 drivers/infiniband/hw/mlx5/qos.c                  |   13 +-
 drivers/infiniband/hw/mlx5/qp.c                   | 4098 ++++++++-------------
 drivers/infiniband/hw/mlx5/qp.h                   |    6 +-
 drivers/infiniband/hw/mlx5/qpc.c                  |   44 +-
 drivers/infiniband/hw/mlx5/srq.c                  |   10 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c              |  111 +-
 drivers/infiniband/hw/mlx5/wr.c                   | 1504 ++++++++
 drivers/infiniband/hw/mlx5/wr.h                   |   76 +
 drivers/infiniband/hw/mthca/mthca_dev.h           |   10 -
 drivers/infiniband/hw/mthca/mthca_mr.c            |  262 +-
 drivers/infiniband/hw/mthca/mthca_provider.c      |  105 +-
 drivers/infiniband/hw/mthca/mthca_provider.h      |   23 -
 drivers/infiniband/hw/ocrdma/ocrdma.h             |    1 -
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c          |    3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h          |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c          |    1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       |    2 -
 drivers/infiniband/hw/qedr/main.c                 |    1 -
 drivers/infiniband/hw/qedr/qedr.h                 |    1 -
 drivers/infiniband/hw/qedr/verbs.c                |    6 +-
 drivers/infiniband/hw/qedr/verbs.h                |    2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c           |    7 +-
 drivers/infiniband/hw/qib/qib_verbs.c             |    1 -
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c      |    1 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   |    5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |    2 +-
 drivers/infiniband/sw/rdmavt/ah.c                 |   11 +-
 drivers/infiniband/sw/rdmavt/ah.h                 |    4 +-
 drivers/infiniband/sw/rdmavt/mr.c                 |  155 -
 drivers/infiniband/sw/rdmavt/mr.h                 |   15 -
 drivers/infiniband/sw/rdmavt/qp.c                 |   24 +-
 drivers/infiniband/sw/rdmavt/vt.c                 |    4 -
 drivers/infiniband/sw/rxe/rxe.c                   |    1 +
 drivers/infiniband/sw/rxe/rxe_param.h             |    3 +
 drivers/infiniband/sw/rxe/rxe_verbs.c             |    9 +-
 drivers/infiniband/sw/siw/siw.h                   |    4 +-
 drivers/infiniband/sw/siw/siw_main.c              |    1 -
 drivers/infiniband/sw/siw/siw_mem.c               |    5 +-
 drivers/infiniband/sw/siw/siw_verbs.c             |    1 -
 drivers/infiniband/ulp/Makefile                   |    1 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c         |   37 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c    |   23 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c        |    3 +
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c         |    3 +
 drivers/infiniband/ulp/iser/iscsi_iser.h          |   79 +-
 drivers/infiniband/ulp/iser/iser_initiator.c      |   19 +-
 drivers/infiniband/ulp/iser/iser_memory.c         |  188 +-
 drivers/infiniband/ulp/iser/iser_verbs.c          |  126 +-
 drivers/infiniband/ulp/isert/ib_isert.c           |    5 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c   |   12 +-
 drivers/infiniband/ulp/rtrs/Kconfig               |   27 +
 drivers/infiniband/ulp/rtrs/Makefile              |   15 +
 drivers/infiniband/ulp/rtrs/README                |  213 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c      |  200 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c      |  483 +++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c            | 2992 +++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h            |  252 ++
 drivers/infiniband/ulp/rtrs/rtrs-log.h            |   28 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h            |  399 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c      |   38 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c      |  321 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c            | 2178 +++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.h            |  148 +
 drivers/infiniband/ulp/rtrs/rtrs.c                |  612 +++
 drivers/infiniband/ulp/rtrs/rtrs.h                |  196 +
 drivers/infiniband/ulp/srp/ib_srp.c               |  265 +-
 drivers/infiniband/ulp/srp/ib_srp.h               |   27 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c             |   67 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h             |    5 -
 drivers/net/ethernet/mellanox/mlx4/main.c         |    2 -
 drivers/net/ethernet/mellanox/mlx4/mr.c           |  183 -
 drivers/net/ethernet/qlogic/qed/qed_rdma.c        |    1 -
 drivers/net/ethernet/qlogic/qed/qed_rdma.h        |    1 -
 drivers/nvme/target/rdma.c                        |    4 +-
 fs/sysfs/file.c                                   |    1 +
 include/linux/mlx4/device.h                       |   22 +-
 include/linux/mlx5/mlx5_ifc.h                     |    9 +-
 include/linux/mlx5/qp.h                           |   68 +-
 include/linux/qed/qed_rdma_if.h                   |    1 -
 include/rdma/ib_cm.h                              |    9 +-
 include/rdma/ib_fmr_pool.h                        |   93 -
 include/rdma/ib_mad.h                             |   49 +-
 include/rdma/ib_verbs.h                           |  298 +-
 include/rdma/ibta_vol1_c12.h                      |    6 +
 include/rdma/lag.h                                |   23 +
 include/rdma/opa_port_info.h                      |   10 +-
 include/rdma/opa_vnic.h                           |    4 +-
 include/rdma/rdma_cm.h                            |   17 +-
 include/rdma/rdmavt_qp.h                          |   31 +-
 include/rdma/uverbs_ioctl.h                       |   18 +-
 include/rdma/uverbs_std_types.h                   |    2 +-
 include/rdma/uverbs_types.h                       |    3 +-
 include/uapi/rdma/hfi/hfi1_user.h                 |    3 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h            |   81 +
 include/uapi/rdma/ib_user_ioctl_verbs.h           |   43 +
 include/uapi/rdma/mlx5-abi.h                      |    9 +-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h          |    6 +
 include/uapi/rdma/rdma_user_cm.h                  |   15 +-
 net/rds/Makefile                                  |    2 +-
 net/rds/ib.c                                      |   43 +-
 net/rds/ib.h                                      |    2 -
 net/rds/ib_cm.c                                   |    8 +-
 net/rds/ib_fmr.c                                  |  269 --
 net/rds/ib_frmr.c                                 |    4 +-
 net/rds/ib_mr.h                                   |   14 +-
 net/rds/ib_rdma.c                                 |   28 +-
 net/smc/smc_ib.c                                  |   13 +-
 244 files changed, 24030 insertions(+), 11025 deletions(-)
(diffstat from tag for-linus-merged)

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl7ZUL8ACgkQOG33FX4g
mxqMZhAAlJ6xSbzZrcwoeIFMDaT1Ueyh7HPIuTPhnmV1L3e7xwEC3Bdn6kUvch0J
xBpShfPMkOonBdVI3Wfo82zyQ9JJqhRQA136OXMSzjot+s2eIAGRx8M/LXkvYtW9
VmzYM+YEom+ounA9S5bSTbAS/O7neWv04sBQTZEsJzjh6K8QsyVQ3agJ9Pu7NXaK
Fe5Zte5ZQHBJ4AAm4FPzKaRwPgWJ54y/P+WESx9ir0aSWdw7AqQTI/PIIfWnyE1B
xqJ0UwiicTvPqiVYd7O6cviL6r6a3qjfTfZ6dOP8ZEjRTlLQd9TVRoF8pBsE8vN4
bpMF08DLXVLTEUH4TjlwKIHjItLJDgaVC65ukLzMoMj3fMPmPCkmGfYDaFHoU2SG
eSqYaKqj+ozhItjmTs5AE1SkQpSub+zbvoYNBsxl8FT0twoi4vHMKwKRPztmsFAU
4JlY/6COTYDLiJZLOjMz0x9QEpp0omoRNpSfl2BBSelEEf9Urg7K/UkR9L0nZCxS
/gKmOuf2NvE/ppWhxBUwujL2HSDy0ytmdJvQNhTbKF95VZyamupLRBG/++OcpjAL
0jXWkUTR2iU+PkxHmMw6WeIr70z2A7Ti2H/UIQJEHvsuKUOLstJp5gp8wS1R3UAg
tYWZCOxHRFnYQw528pLxmiKh7IzCGdcgcYnJ9PpjYVkbxPxqUn0=
=n4SC
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
