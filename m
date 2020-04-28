Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7432F1BCCDA
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgD1T7X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 15:59:23 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:20523
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728559AbgD1T7W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 15:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLKutJGOoejb6Zwwoue8KVopX/vYNzdNk0fOa+qBFq7NvpVkERj+GnJDFbYyvoOj1r5TV64ftocT60WJmrKELn8y3gQ04NP7Eea9dbyV1lOCxKM/CW1aCVepsCuUapgvnz/MAkENxemF9ssTYEy2nKadkP3O3Z3pp2ClOiwuxOrDQaTBvqRoag5NPXnf2YgBiW/9szGy4RGa3TIqgG/HTFkN6T0o3QPGHgQJwFBEXeK47AuuAZqJJ1S/rFjbsKnQPa+Q73v0NJMk0zSKzhJ+vMybQaEg09OX8jp25bAuISP6FoAWIcRm4GnvDPf5hxE6nzvm/9/asr/RRqk5SDBaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffWu9iuM9KiJ4HsgsH/HOZHD2vryWFAKfGpk9tQdCM0=;
 b=U5hRN2+i+mO2GB83eNC/1+HN+euk08ceQIyZKRwnWSgn+nYwyFskbiE/BYmeA5tgBGgbEREwgTGlPnpv0EdnDFtWKAlRKXfMD4Ap14CWqBDP9bhlI5YsUUIeXOfT0iTsyLrPvV/YDzrjz+uPnrlIDHKmUGnNybhCVFA3qUAXlYSq9u4mFAIpCjH8W2im5hC4e7LpKOmppdK0b3mgN5bulvNoaS72pdSOlKNI5hdjXi2z1wuwopPmyqwLNfzGDbnWkk3IeDK+HSFUbuu4ImRqD0vA2k7UMftGMUGu6T8o908sdqzN66UbfsCK8duKVBixuklf0Z5pc+2shn++r4ftcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffWu9iuM9KiJ4HsgsH/HOZHD2vryWFAKfGpk9tQdCM0=;
 b=A435SePrCfR8vivwRqkD5aqa4n2Nz+9t8AJGNUqq2q32sxLiRsfo3pBHH88t07vFEoKUJ71wV7klwAxHfDpCvDcCsMDglFPjBJEve9gSTqzPDteiAiyq8r25MyCr6RGdpjl3pGDcqvl9/7iZmiSknd4QSt5V2JeilFXd1QSNaXo=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB3151.eurprd05.prod.outlook.com (2603:10a6:802:19::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 19:59:18 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2937.020; Tue, 28 Apr 2020
 19:59:17 +0000
Date:   Tue, 28 Apr 2020 16:59:14 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200428195914.GA24418@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0127.namprd02.prod.outlook.com
 (2603:10b6:208:35::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0127.namprd02.prod.outlook.com (2603:10b6:208:35::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 19:59:17 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jTWNu-0006N0-Nx; Tue, 28 Apr 2020 16:59:14 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 822f9b2c-fd21-4de5-a07c-08d7ebaea25d
X-MS-TrafficTypeDiagnostic: VI1PR05MB3151:
X-Microsoft-Antispam-PRVS: <VI1PR05MB315137FB15685AD2DF62E550CFAC0@VI1PR05MB3151.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(5660300002)(1076003)(110136005)(66556008)(36756003)(66476007)(4326008)(66946007)(33656002)(26005)(52116002)(186003)(9686003)(86362001)(44144004)(498600001)(21480400003)(9786002)(8676002)(8936002)(2906002)(9746002)(24400500001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bV3cGbmakr/bSeICOSyVjAZak307sONbHlv+H0oJJAut1gePPE+0ZH9d42epzKHrEMoqVMRTddZyh2/tWOvHcm/PieK8XTneDq0yR2XR9eAOIZ6Cx2bnX/yXkf6AGr8EaoaD2opbYyShajkES1oVDitDztRJz0w0Y9KN5i0x7tE7XM2hd7XZC5/wrUaYDo2WQlGVFVD5MYPXpHsMAwOJgLI7s4Co9rIVPIF/FbXrOdFITj9t3E0JBqIbLR6+7IBt9/D3mGkEPbHlYR7mM2Flc0DbLNMPpGGGFH4ax03Xc730Iw01TrnXybwGuHj+owMr+qykTrywvNg3KXERFxQB1Sw9Xe8FXoToVqaoHlB5kW8CbqQA9Qkh3PX3vl2r8+3v/Uf3G4zDLg5OPGqqkRFIRr60mWnqiFT1X391QOKnsVx2UQr+6vHXeZqkbxCl2uBd5IEQWP0m16EtyhMNSEgZbeYwZpFXA//KtcBecbRWhVL5mKOKEY10y0bDZst7MaDxt0cz1djoqNXWrBdnqwjpLw==
X-MS-Exchange-AntiSpam-MessageData: yXXZdM45QCmVjW2AVH8SW0NuYq2WmEZyEhEHN1Eix7psEAtjo74yXwkiC3xGf/KEGCB0J/bj97NE6dsbTo6Ez2JzYGPfPtSL85f1WPkSOu+WwB/MSube1ieA9KP7yBf9WmW53ty7NEyuC/D6TOlRdR9MRwPVeH3SDAwX/89mnzlJZVUy54lp2oxYSI54/mmN0uuwPGnqOlECssWE0BmyHbPaBhSWV1XC09YSTUPk5S766lBIvrR433VOcIY92i3sWVVk+8uV/bkNQXT24HFHKglGvKTuHS+TCoehcERo7pqw7U7AgQH2kGul0D3sc+vvFx56/ETeXulPgOjzHbVw4LtpBGM77kf6HApCeE580j8MD5clqRSnLBJKtY20xsfhItWtVofBbxudUEj0CywCj8bnRHm2V5me568qJr+94SmDQEFwt3kDlobT0Z+pyqFDa1/UMuUQWYKygbP+niib2sTUDUlqJy1QJkbO8xdFKY5oyEBH8FjdejQbThidesVgJ89xh03zvynyIZ4Bmv98fhraVL6eYyBuMnClvqCgIUUDTNFB5LfuEFat2jTVxt8uHW3dxWhy/3u5SHLz/4xP99847R8AszYAcM1307qQIDbRkAbsFAfJbOMmm24MSicb23czZGWzCVJDFeLkheTBgO1yLx4Tel3gSFo/77hn1W8/1iXom9aPVdl0x1ulDWc47GXV4hdlioVcQVfrjdf8WHSxBcVLd28fCaFoIiViJQ+kdJUPawifB4HxToN54hEbzHTfxn7CZt+rjUpU8h/l+faURr+A7H/SYmQ5YPc0ocE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822f9b2c-fd21-4de5-a07c-08d7ebaea25d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 19:59:17.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW+moOkZjIj9UYv/JVUU447LqJUZdLaobQ2iH9Hj4TuLAD749IisejGiNL0QF8r4SAm+E9vW7gnKSCT+TY8K2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3151
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request

A few regressions and some syzkaller crashers for RDMA.

Thanks,
Jason

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f0abc761bbb9418876cc4d1ebc473e4ea6352e42:

  RDMA/core: Fix race between destroy and release FD object (2020-04-24 15:40:41 -0300)

----------------------------------------------------------------
First RDMA 5.7 rc pull request

A couple of regressions were found in rc1, as well as another set of races
and bugs :

- A regression where RDMA_CM_EVENT_REJECTED was lost in some cases

- Bad error handling in the CM, uverbs, rvt, siw and i40iw

- Kernel stack memory leak to user space in mlx4

- Missing data in a uapi query for mlx5

- Three races found by syzkaller in the ib core code

----------------------------------------------------------------
Aharon Landau (1):
      RDMA/mlx5: Set GRH fields in query QP on RoCE

Alaa Hleihel (1):
      RDMA/mlx4: Initialize ib_spec on the stack

Colin Ian King (1):
      i40iw: fix null pointer dereference on a null wqe pointer

Dan Carpenter (1):
      RDMA/cm: Fix an error check in cm_alloc_id_priv()

Jason Gunthorpe (2):
      RDMA/siw: Fix potential siw_mem refcnt leak in siw_fastreg_mr()
      RDMA/uverbs: Fix a race with disassociate and exit_mmap()

Leon Romanovsky (4):
      RDMA/cm: Fix missing RDMA_CM_EVENT_REJECTED event after receiving REJ message
      RDMA/core: Prevent mixed use of FDs between shared ufiles
      RDMA/core: Fix overwriting of uobj in case of error
      RDMA/core: Fix race between destroy and release FD object

Sudip Mukherjee (1):
      IB/rdmavt: Always return ERR_PTR from rvt_create_mmap_info()

 drivers/infiniband/core/cm.c             | 26 ++++++++++++++------------
 drivers/infiniband/core/rdma_core.c      |  9 ++++-----
 drivers/infiniband/core/uverbs_main.c    |  4 ++++
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c |  2 +-
 drivers/infiniband/hw/mlx4/main.c        |  3 ++-
 drivers/infiniband/hw/mlx5/qp.c          |  4 +++-
 drivers/infiniband/sw/rdmavt/cq.c        |  4 ++--
 drivers/infiniband/sw/rdmavt/mmap.c      |  4 ++--
 drivers/infiniband/sw/rdmavt/qp.c        |  4 ++--
 drivers/infiniband/sw/rdmavt/srq.c       |  4 ++--
 drivers/infiniband/sw/siw/siw_qp_tx.c    | 15 +++++++++++----
 11 files changed, 47 insertions(+), 32 deletions(-)

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl6oixAACgkQOG33FX4g
mxq9oQ/+L8mrioExJZ7oU2u3HMP7EgYIe+I2WWE1ceRDCYr+Ifgd8oKXCHNXOQok
ujzQdMJRW+Z3cGuN/qFrA2ofN9eCZA3BDl1S4wW6NCSDTjQd626u2la3GOx+mUkM
KritWVIzSTnpMhXboVNDlDz3TLqkPzswB70ltmJXXCK8Gxh82nyBIL7yoga3oHoy
zzzeA+AEqJOzhKrLrJ14hWgAjOSH+LBfs0luWmaEpg3utOlikXgjY/8zdetgJVZs
+dyuWfo1ks5UBiTNsKapN1KL7mYx7GvgjJ0DhUpfNC4pZAJGCRam1XZE3PNfXXM/
r0BSSkUFcyJW39aNlfLTKLN8iPZIdznvbMWrEJzEaaN+64bOz/eE+SKNlrQUwPCl
oipQBilNNS2nnWSx01X1C/GKj2codsk7XiDoMOJ3X9QkHFTT9PLWnL2cIFTcHQcn
zrbo5RuTA8ftw8B5c5opSNggbPWlv3MX27bXeg5hSAvPuHPMw7dFnkpr/0brQo0a
0z1dVP22yRKvtBfynFXric48lpnk64CHOuN2PBRzoYQQVoN4JwYxKsc9hfiMVK6k
QgioQrMNvIB62ehLqgl4jSB8IO3FhAkRUviaVWXalFq3v0m2+so3p+Tv8uKdn1St
KIpIr9TF5TQjGb/bKXVTZydXPDRpIpS7qiJXjM8gQRa0cLFsdcE=
=stEt
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
