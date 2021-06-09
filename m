Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8D23A18A0
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhFIPLa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 11:11:30 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:59584
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235531AbhFIPLT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 11:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqy0+/VcJd6PSbyUvCwiGgikg71nYZsyE0OU5khLYEIWbJbl5wkCfnSLXje0Lfg7iL2KYzJ1zZhKePqQVrSSNl/FpWeyvLOhFcfOvcWCYUPabZezGv4nQ8xBLj4+9BM+WIGAfaz40TNd51n7KxoJ0+a4awA8ydAQoQcZ+IAJ6mnaZkaXTGTNRRXj+5gHPwTRNHgi/OJ80wbwcmxVITiezFlL7zhwnhb8QK+M00VPbTGekmJXukcZnYS04AIG40ua18YXRiiz0RCj+lJ+84QBlr5noy98CJ56K1LAfZzfA/R8ZxZU0F+ueDRgPo/KeDvDsiVApALFMzmItT4HJ4PS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o+qB/t8GKg4KQo/SNNk/vVFQL6md4FJeQcNHGZYAn8=;
 b=kFQZyk+sVXQ3FwC+yaL7fHPMkzdOD1cV2RDPhPc88rD0DBc4L2YtZw3/vGaZHHGOhxcPKMlSRchScS36V0OySPpVBtAiwD0gYSn2D0MAQLweLnlacjwUUor3NnhqqZMHtu/obJfgdSGaEhLwQwW1Yg6Hizt4UxgPfBcfDgFLSVrSzRvvcGNWtVOZXOo2Uv79BQNxjhorfe4P5o+BlxbV2wvymFT2+A6RIq89jNXA0o/HFAFoR2DRrhx3jy8Cbv0fvHeUKPTeBDHKWFeQwAWOh9uI69198B5rqs6ZNPKzkGa+HL+8yCmA67Pm/ANN7lkxKrHpUbs+GWK035O7W0clWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o+qB/t8GKg4KQo/SNNk/vVFQL6md4FJeQcNHGZYAn8=;
 b=cjGr7s9Brhkro2vaSHO4+2KbLgZV6yF87K2if1OKrbLZBdME9fP5rPTQBeOkt0t9uoVtUsSBw4ctbhCSPOvwlJifkhjBEbLEUQIXRcY8TpjNB1hgmIknNe9Hb6qk1NgKi5HAt7WiJWlrCK6XUa4J4rh2QJqO2/nfVhbLQuMOJoft9ucOzs9L6ChnZD9eGtk/Wbgtt/8Va/vToPxuzP/XM4YYbcuX2SeGtKsQa+RiJC+ORZppALLmR+dlgxGl+nwWZPxqAP3pXsQeaUk82WyBvYY8dK7sxgUYoPFqiikioU25QMrws3vaLRWFnBrJTqglFclD4v0U3MkefAY9tZvcJw==
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 9 Jun
 2021 15:09:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 15:09:23 +0000
Date:   Wed, 9 Jun 2021 12:09:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Chuck Lever III' <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <20210609150922.GA1109697@nvidia.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210609125241.GA1347@lst.de>
 <6b370a8fde1e406192d37c748b79ad01@AcuMS.aculab.com>
 <ACCBE9AD-9A59-4300-A872-69EDBB4D4203@oracle.com>
 <25c32f2a147a4dff8b7d6577286d7954@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c32f2a147a4dff8b7d6577286d7954@AcuMS.aculab.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 15:09:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqzpa-004eif-LJ; Wed, 09 Jun 2021 12:09:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e86ad112-bcf5-4316-e98a-08d92b5890cc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB538094DD0FADD3ACDAB7E5B3C2369@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pObALKW4XoxldCn9lb9hg92Ai+ZdLmu042X5+L0GoSMeg6i/GzRIbS/v24nzonxmhErY99UvAf5JfRSPFArXFEx6DiRv2O2SnUyE7GihjiqtiL891SeFHAvgrdgC+XKnArfBKSCSc7A58tfllgfrFk5zDk5Cvd9gd9ZJ7enlK+F3w2CxYDuMdu7ZDIswnEuOr6S4OQtRM/xWWeHzXx8CTTSWRGFnh5zxv/fXME22TZAFMjkNfDuaSUc+jHPU7m3WQYIjYBauLPc6SOQEWmGBj/qnDqGqx8yFmM6p7A6hbM+uqL7o4aa9+f/EqdJTZbfD3LkLiu9iK68i3dZyVTNcxuFgYyEAEbAbtA1bgUvRr/QcStzqjMsZh7JzM1Y5FaSy6i7NFXo9+XWJiWyWvyUyTpnbiiicUt2rhIDdHGyfTF5jaUJAwUvxRDN1AbsQerKQQDyXObm/4sLcxrVxw+0iY4uMNOFQpUkGHeLhN9lrfu0n6qB+I6zE1RS4sveoN3WwK1YJ5nJi1rn/VEBEVXulMvmlzz4rF/3f7PW5gmlKR702I8XBsrntjdj5HtREFgeaz7Jx+DlNRfMEfese35e2YnxoiGB1MUJQ1pPY5Yivmoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(9746002)(4744005)(2906002)(33656002)(6916009)(38100700002)(66476007)(66556008)(186003)(1076003)(86362001)(7416002)(54906003)(4326008)(8676002)(8936002)(5660300002)(2616005)(426003)(9786002)(66946007)(316002)(478600001)(26005)(83380400001)(107886003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HljDmU9mh4hNFErqLyxMG6Yh6oqYLLr2ZeGLm2QnSLpKEHJPjpwpEwWHSSI5?=
 =?us-ascii?Q?/FEOka6WlUOwO0RrvoA2JmAtsemc70OlmfdD74YHF+SjFexDbkaDTsgQkXhv?=
 =?us-ascii?Q?C+9bRJJQHVPPwF8W4LrtxyhYxzv98UjQz3SUkn9Rc++AeJN3ND9oV3yIHYP8?=
 =?us-ascii?Q?Ahwo7hi69S7P99luKNwJt8D+GX+wfWWIYbWPjkv/pv6fY1Sr5IDjD3oLxKuR?=
 =?us-ascii?Q?jQxnazAkgUiKW+VPLVovC6lDb1vywyb7uMGaZHlGJFOtWfenWp2zcDtYJVOH?=
 =?us-ascii?Q?RORFAIYN8DbOsk0E+EuYzkal39tlZCUtAxmqmUnv5ZNl9ZjlvjPUTrLRJqlc?=
 =?us-ascii?Q?871N3BNNMqdRONk3ppnC8FvYBlU0VIP5Y03TAbHdB2TQhwLK8zH1jzHzeAM1?=
 =?us-ascii?Q?xdV0N6Q4ZsHpx2X6QVJviMfiieFO8lXDmq/aARjVtzxS04P+63v0c32veOCQ?=
 =?us-ascii?Q?T/yqZT7EMI3nRtXU4Z0VYq4T73aBkTyyz7EBSIPKMLj/+Irz1DvSTSqI9bRA?=
 =?us-ascii?Q?twJ/dEjSiCkk+iqiFtQTOM+Wa7/VNFLBghh4IkPiNzX+jDZemqZfh1TM8Qpk?=
 =?us-ascii?Q?B5soKZ82jG72drC2lEEjBjqQEyLVLpijZ37AmYdfxqyUXQfgwmRYyNs63mkY?=
 =?us-ascii?Q?VS42YegYq0gH4oSB7phkfwJeYabqVyZLs0sXpGaZsdqODgWcaYswPNLG+5Yd?=
 =?us-ascii?Q?DMKFtxXgG2JsM0iOF14cu5RBPFPUA4GDewT5tvuBRfYX2rZxyTA/m/i9+KMx?=
 =?us-ascii?Q?Gxv+J1zWWwRCBpOry7CsXayknD24ZnzkFsBtXlr6/in2ai7tTRsgnRqRyWB0?=
 =?us-ascii?Q?CHh8yQq+mErrveQb+Joy7f+wrbUVDHlNl5K8zNWLkjL1uzhqLnxGPgScgPpy?=
 =?us-ascii?Q?y6m+cqaQckFjuBq1/PgGo5uraNTPlL7YLwCIgZJV4+OUSik3CZfeuP5EzX1v?=
 =?us-ascii?Q?WbzXXyiIXj8aiSRpsB3RHlnTOwll4kwW8tcz+3eoIWRx3qgMe7KQ9N6A2eYB?=
 =?us-ascii?Q?Bnmday+ST+d0g2rzQ9cje0ImMAtFULY+dRnZFZCDSB6r4qtzcvdJ7z7wLju1?=
 =?us-ascii?Q?3LA5HVMWi8/DrUe35wo8vnqdeIw8QvHbkCa0v584ea5HjhaHDB+NxjzpyrOa?=
 =?us-ascii?Q?vM66tNtlFX0QibuQFziGv5v9KSa3Go4/+szVB2fD5dBtpB/EjvmgVMKcVqdc?=
 =?us-ascii?Q?UPkNklX/4eQAAVyGP2TmcCMHYtVYfAz3dM4e7A5wwiU5WSzB2AC9cbe7DQbX?=
 =?us-ascii?Q?bygh7ArIwpzDZdYJLVpXtVzZm8d+v6QHCl1J5iknVPyfOcGnGXSD8+ATvv3j?=
 =?us-ascii?Q?5fQlQMJr605nsqx5AAVxJ43R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86ad112-bcf5-4316-e98a-08d92b5890cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:09:23.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxtXqR6xNt+6+wv4ntblf2IXfI2aKQwLLrZKq1zCP4KXcbnMpnp8CM+PWlUhRGCZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 03:05:52PM +0000, David Laight wrote:

> In principle some writel() could generate PCIe write TLP (going
> to the target) that have the 'relaxed ordering' bit set.

In Linux we call this writel_relaxed(), though I know of no
implementation that sets the RO bit in the TLP based on this, it would
be semantically correct to do so.

writel() has strong order requirements and must not generate a RO TLP.

Jason
