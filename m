Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE01188622
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCQNpF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 09:45:05 -0400
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:21928
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgCQNpF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 09:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0XoIdXcGgWnGQpscvaycb8vmZq7g6mGfdYd0Jho01YwHSPNeXIEDEhXh5/7MOlG77xNHX+Pgk1Y8OiCWHNR7ZQBphICCXBKyvVNM3n3e3S/npSDDSHBz06C0jC65WJJJNB4z6/zuZYI2tJOPMqFDLyNckYHnBLRGIKY8SHRsvMv9hDfHh0VPFoS9vutkGyKvjDwARlvaj0d1HmWSTaAhAtak8F2o8KW5yaRBzpl4xeWdFkQm+wGdgTfk+4tl7EPly2z2O4cw/nlIep7bfgbMlOHf2yQ3X5JjRpGtfKtYUB9UqVzzlzzrY73E3sXxPTc0FzUBI2CyAk1S6pGx9/gJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQMp1FEzfNF1JAmFx2wikueJVZ2diRklOb985XcJoJg=;
 b=XCEPrynQdi9rVMjainHVMBo42y5YAbCa+z6D0c5m6pW6inaUFMBoVCLy9T4Qkspko+rVELROjdcwC6h+ys+Rl+bKZ7I5sicvGyDNjiOGKSBsTsvOj6i4ym3tIk/VbsCwkCWeDVrWu0t14yydaV7DWU0DklAgCJ+R2G8MPNSf68xWXBQH/v2zIub+irB/2j3H+cgn6yBfXfbC8NiLZ7SQwLiaLJPBcZPT1cnU3d8pbIWqGb0pviYjPx9TyW8bIzwuJK9Bu1eyHQbU9fpd3j+ucCdaEyg85g7qd9mtu25DxNdRg0S653N/+xUDy2594bBfeQ5JSi3oZCuBJW0ge3ZvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQMp1FEzfNF1JAmFx2wikueJVZ2diRklOb985XcJoJg=;
 b=cKYDHklwv9mfe4Y8U4K/hhBMepRVVMYvK446CUg8+GwS9t926ALBGzvCOXL2TWmMRbm0VWt1hJPA1/9BCdWctSCx4VO0ZZxnDMoMyhnYILdZMtD5JC96P/AqO7bCoIzirCV2ct2uNSDm9Eh42ZVOwu8bRYdVKXSoM/t7EySWMgc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB5254.eurprd05.prod.outlook.com (20.177.197.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 13:45:00 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 13:45:00 +0000
Date:   Tue, 17 Mar 2020 15:44:57 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Laurence Oberman <loberman@redhat.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        rdmadev <rdma-dev-team@redhat.com>, linux-rdma@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Van Assche, Bart" <bvanassche@acm.org>,
        Rupesh Girase <rgirase@redhat.com>
Subject: Re: commit ab118da4c10a70b8437f5c90ab77adae1835963e causes ib_srpt
 to fail connections served by target LIO
Message-ID: <20200317134457.GF3351@unreal>
References: <0bef0089-0c46-8fb7-9e44-61654c641cbd@mellanox.com>
 <e57c1763dd99ea958c9834a53ae5688a775c9444.camel@redhat.com>
 <6d5415e3-9314-331a-fade-7593c6a27290@mellanox.com>
 <8695fb0f34588616aded629127cc3fa2799fa7cb.camel@redhat.com>
 <918bc803-41d6-6eea-34e2-9e40f959a982@mellanox.com>
 <2a04cd1d66e6bc2edb96231b47499f4c1450e592.camel@redhat.com>
 <327df8af71afab4a2f9b6da804218d5a94cf6020.camel@redhat.com>
 <20200316072140.GD8510@unreal>
 <20200316073002.GE8510@unreal>
 <2e0bf1fb747a41ea817aaaa141e3410ced078548.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0bf1fb747a41ea817aaaa141e3410ced078548.camel@redhat.com>
X-ClientProxiedBy: AM0PR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::44) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by AM0PR01CA0067.eurprd01.prod.exchangelabs.com (2603:10a6:208:e6::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Tue, 17 Mar 2020 13:45:00 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab2be9d1-e9b6-43d9-bf8c-08d7ca79635b
X-MS-TrafficTypeDiagnostic: AM6PR05MB5254:|AM6PR05MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB52543C139999C36E583D1C08B0F60@AM6PR05MB5254.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(366004)(346002)(39860400002)(396003)(199004)(16526019)(53546011)(186003)(316002)(33656002)(6916009)(52116002)(86362001)(478600001)(66556008)(66476007)(54906003)(5660300002)(30864003)(6486002)(33716001)(66946007)(6496006)(1076003)(4326008)(8676002)(81166006)(2906002)(6666004)(9686003)(8936002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5254;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWabulo6uVdcKaeYBAGH237sNUgZqfGK3oHAQP+LkjYpJi6E3oPvJnyT4INazzvVGRigcrzjjgVrYaTj+PVcQGwNJ9xtO6AdFdwDYzPbtqnjpASzCZoKEQimyIU4pegSDeBmM28G4UoSpaugkDHnNwg12LyIC47ndzHClCUnTFJMZ3qvf8thrzonXMKEXWd48PkTB7EIY2cfkIwT6X2dZbO2Jsgbmfgc7JnfL722V4WaRVnebYhAtqK8ARWNOypa1T1GgFDXUhGolG/c/7FU3rpi15L5cIMwztbZokKMAqV/xjpRwEjaXSdzUi/tEANxMsSyTIPqtXvyr6z8sZVOgugsGHpp6PTiHheiJSZChaLdV3nPu+Y3TuZICL9Ao6MKPiJczaEF8h9hhnoZ2NsPsRmkzV8daU+BUbU1BNiROm+IoW21hExCKQUQaYVqt+SN
X-MS-Exchange-AntiSpam-MessageData: /hERvB/sUDa/SS6sjXxj69WT9QCSZkOeCpJixDdJvKkShQ5hFgLmiZ5glJkx/pJ431d1MMkVhOQqL3lKzeCMrOAIjtIj+mx/QKhvIBbHanhZF2gqHlmEhDKP0OEZQR9P/0ruD7GlC3QLKZbAzOsJo9iiCOTMg8X45Te0AcmpEPo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2be9d1-e9b6-43d9-bf8c-08d7ca79635b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:45:00.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFecZPHMnNQd0JOeU+7qiJ6j2h+gt+MR9LTD6vSpesiRasZI8t5/SjQ1zcVDkK3eIBRZDsk+Cef9EQTSqZo9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5254
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 16, 2020 at 03:18:28PM -0400, Laurence Oberman wrote:
> On Mon, 2020-03-16 at 09:30 +0200, Leon Romanovsky wrote:
> > On Mon, Mar 16, 2020 at 09:21:40AM +0200, Leon Romanovsky wrote:
> > > On Sun, Mar 15, 2020 at 05:56:17PM -0400, Laurence Oberman wrote:
> > > > On Sun, 2020-03-15 at 17:01 -0400, Laurence Oberman wrote:
> > > > > On Sun, 2020-03-15 at 22:40 +0200, Max Gurtovoy wrote:
> > > > > > On 3/15/2020 8:36 PM, Laurence Oberman wrote:
> > > > > > > On Sun, 2020-03-15 at 20:20 +0200, Max Gurtovoy wrote:
> > > > > > > > On 3/15/2020 7:59 PM, Laurence Oberman wrote:
> > > > > > > > > On Sun, 2020-03-15 at 18:47 +0200, Max Gurtovoy wrote:
> > > > > > > > > > On 3/14/2020 11:30 PM, Laurence Oberman wrote:
> > > > > > > > > > > Hello Bart, Leon and Max
> > > > > > > > > >
> > > > > > > > > > Hi Laurence,
> > > > > > > > > >
> > > > > > > > > > thanks for the great analysis and the fast response
> > > > > > > > > > !!
> > > > > > > > > >
> > > > > > > > > > > Max had reached out to me to test a new set of
> > > > > > > > > > > patches
> > > > > > > > > > > for
> > > > > > > > > > > SRQ.
> > > > > > > > > > > I had not tested upstream ib_srpt on an LIO target
> > > > > > > > > > > for
> > > > > > > > > > > quite a
> > > > > > > > > > > while,
> > > > > > > > > > > only ib_srp client tests had been run of late.
> > > > > > > > > > > During a baseline test before applying Max's
> > > > > > > > > > > patches it
> > > > > > > > > > > was
> > > > > > > > > > > apparent
> > > > > > > > > > > that something had broken ib_srpt connections
> > > > > > > > > > > within LIO
> > > > > > > > > > > target
> > > > > > > > > > > since
> > > > > > > > > > > 5.5.
> > > > > > > > > > >
> > > > > > > > > > > Note thet ib_srp client connectivity with the
> > > > > > > > > > > commit
> > > > > > > > > > > functions
> > > > > > > > > > > fine,
> > > > > > > > > > > it's just the target that breaks with this commit.
> > > > > > > > > > >
> > > > > > > > > > > After a long bisect this is the commit that seems
> > > > > > > > > > > to
> > > > > > > > > > > break
> > > > > > > > > > > it.
> > > > > > > > > > > While it's not directly code in ib_srpt, its code
> > > > > > > > > > > in mlx5
> > > > > > > > > > > vport
> > > > > > > > > > > ethernet connectivity that then breaks ib_srpt
> > > > > > > > > > > connectivity
> > > > > > > > > > > over
> > > > > > > > > > > mlx5
> > > > > > > > > > > IB RDMA with LIO.
> > > > > > > > > >
> > > > > > > > > > I was able to connect in loopback and also from
> > > > > > > > > > remote
> > > > > > > > > > initiator
> > > > > > > > > > with
> > > > > > > > > > this commit.
> > > > > > > > > >
> > > > > > > > > > So I'm not sure that this commit is broken.
> > > > > > > > > >
> > > > > > > > > > I used Bart's scripts to configure the target and to
> > > > > > > > > > connect
> > > > > > > > > > to
> > > > > > > > > > it
> > > > > > > > > > in
> > > > > > > > > > loopback (after some modifications for the updated
> > > > > > > > > > kernel/sysfs/configfs
> > > > > > > > > > interface).
> > > > > > > > > >
> > > > > > > > > > I did see an issue to connect from remote initiator,
> > > > > > > > > > but
> > > > > > > > > > after
> > > > > > > > > > reloading
> > > > > > > > > > openibd in the initiator side I was able to connect.
> > > > > > > > > >
> > > > > > > > > > So I suspect you had the same issue - that also
> > > > > > > > > > should be
> > > > > > > > > > debugged.
> > > > > > > > > >
> > > > > > > > > > > I will let Leon and others decide but reverting the
> > > > > > > > > > > below
> > > > > > > > > > > commit
> > > > > > > > > > > allows
> > > > > > > > > > > SRP connectivity to an LIO target to work again.
> > > > > > > > > >
> > > > > > > > > > I added prints to
> > > > > > > > > > "mlx5_core_modify_hca_vport_context"
> > > > > > > > > > function
> > > > > > > > > > and
> > > > > > > > > > found that we don't call it in "pure" mlx5 mode with
> > > > > > > > > > PFs.
> > > > > > > > > >
> > > > > > > > > > Maybe you can try it too...
> > > > > > > > > >
> > > > > > > > > > I was able to check my patches on my system and I'll
> > > > > > > > > > send
> > > > > > > > > > them
> > > > > > > > > > soon.
> > > > > > > > > >
> > > > > > > > > > Thanks again Laurence and Bart.
> > > > > > > > > >
> > > > > > > > > > > Max, I will test your new patches once we have a
> > > > > > > > > > > decision
> > > > > > > > > > > on
> > > > > > > > > > > this.
> > > > > > > > > > >
> > > > > > > > > > > Client
> > > > > > > > > > > Linux ibclient.lab.eng.bos.redhat.com 5.6.0-rc5+ #1
> > > > > > > > > > > SMP
> > > > > > > > > > > Thu
> > > > > > > > > > > Mar
> > > > > > > > > > > 12
> > > > > > > > > > > 16:58:19 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > > > > > > > > >
> > > > > > > > > > > Server with reverted commit
> > > > > > > > > > > Linux fedstorage.bos.redhat.com 5.6.0-rc5+ #1 SMP
> > > > > > > > > > > Sat Mar
> > > > > > > > > > > 14
> > > > > > > > > > > 16:39:35
> > > > > > > > > > > EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > > > > > > > > >
> > > > > > > > > > > commit ab118da4c10a70b8437f5c90ab77adae1835963e
> > > > > > > > > > > Author: Leon Romanovsky <leonro@mellanox.com>
> > > > > > > > > > > Date:   Wed Nov 13 12:03:47 2019 +0200
> > > > > > > > > > >
> > > > > > > > > > >        net/mlx5: Don't write read-only fields in
> > > > > > > > > > > MODIFY_HCA_VPORT_CONTEXT
> > > > > > > > > > > command
> > > > > > > > > > >
> > > > > > > > > > >        The MODIFY_HCA_VPORT_CONTEXT uses
> > > > > > > > > > > field_selector
> > > > > > > > > > > to
> > > > > > > > > > > mask
> > > > > > > > > > > fields
> > > > > > > > > > > needed
> > > > > > > > > > >        to be written, other fields are required to
> > > > > > > > > > > be
> > > > > > > > > > > zero
> > > > > > > > > > > according
> > > > > > > > > > > to
> > > > > > > > > > > the
> > > > > > > > > > >        HW specification. The supported fields are
> > > > > > > > > > > controlled by
> > > > > > > > > > > bitfield
> > > > > > > > > > >        and limited to vport state, node and port
> > > > > > > > > > > GUIDs.
> > > > > > > > > > >
> > > > > > > > > > >        Signed-off-by: Leon Romanovsky <
> > > > > > > > > > > leonro@mellanox.com>
> > > > > > > > > > >        Signed-off-by: Saeed Mahameed <
> > > > > > > > > > > saeedm@mellanox.com
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > diff --git
> > > > > > > > > > > a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > > > > > > > > > > b/drivers/net/ethernet/mellanox/mlx5
> > > > > > > > > > > index 30f7848..1faac31f 100644
> > > > > > > > > > > ---
> > > > > > > > > > > a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > > > > > > > > > > +++
> > > > > > > > > > > b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > > > > > > > > > > @@ -1064,26 +1064,13 @@ int
> > > > > > > > > > > mlx5_core_modify_hca_vport_context(struct
> > > > > > > > > > > mlx5_core_dev *dev,
> > > > > > > > > > >
> > > > > > > > > > >            ctx =
> > > > > > > > > > > MLX5_ADDR_OF(modify_hca_vport_context_in,
> > > > > > > > > > > in,
> > > > > > > > > > > hca_vport_context);
> > > > > > > > > > >            MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > field_select,
> > > > > > > > > > > req-
> > > > > > > > > > > > field_select);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > sm_virt_aware,
> > > > > > > > > > > req-
> > > > > > > > > > > > sm_virt_aware);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, has_smi,
> > > > > > > > > > > req-
> > > > > > > > > > > > has_smi);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, has_raw,
> > > > > > > > > > > req-
> > > > > > > > > > > > has_raw);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > vport_state_policy,
> > > > > > > > > > > req-
> > > > > > > > > > > > policy);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > port_physical_state,
> > > > > > > > > > > req-
> > > > > > > > > > > > phys_state);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > vport_state,
> > > > > > > > > > > req-
> > > > > > > > > > > > vport_state);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > > port_guid,
> > > > > > > > > > > req-
> > > > > > > > > > > > port_guid);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > > node_guid,
> > > > > > > > > > > req-
> > > > > > > > > > > > node_guid);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, cap_mask1,
> > > > > > > > > > > req-
> > > > > > > > > > > > cap_mask1);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > cap_mask1_field_select,
> > > > > > > > > > > req-
> > > > > > > > > > > > cap_mask1_perm);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, cap_mask2,
> > > > > > > > > > > req-
> > > > > > > > > > > > cap_mask2);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > cap_mask2_field_select,
> > > > > > > > > > > req-
> > > > > > > > > > > > cap_mask2_perm);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, lid, req-
> > > > > > > > > > > >lid);
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > init_type_reply,
> > > > > > > > > > > req-
> > > > > > > > > > > > init_type_reply);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, lmc, req-
> > > > > > > > > > > >lmc);
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > subnet_timeout,
> > > > > > > > > > > req-
> > > > > > > > > > > > subnet_timeout);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, sm_lid,
> > > > > > > > > > > req-
> > > > > > > > > > > > sm_lid);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx, sm_sl,
> > > > > > > > > > > req-
> > > > > > > > > > > > sm_sl);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > qkey_violation_counter,
> > > > > > > > > > > req-
> > > > > > > > > > > > qkey_violation_counter);
> > > > > > > > > > >
> > > > > > > > > > > -       MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > pkey_violation_counter,
> > > > > > > > > > > req-
> > > > > > > > > > > > pkey_violation_counter);
> > > > > > > > > > >
> > > > > > > > > > > +       if (req->field_select &
> > > > > > > > > > > MLX5_HCA_VPORT_SEL_STATE_POLICY)
> > > > > > > > > > > +               MLX5_SET(hca_vport_context, ctx,
> > > > > > > > > > > vport_state_policy,
> > > > > > > > > > > +                        req->policy);
> > > > > > > > > > > +       if (req->field_select &
> > > > > > > > > > > MLX5_HCA_VPORT_SEL_PORT_GUID)
> > > > > > > > > > > +               MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > > port_guid,
> > > > > > > > > > > req-
> > > > > > > > > > > > port_guid);
> > > > > > > > > > >
> > > > > > > > > > > +       if (req->field_select &
> > > > > > > > > > > MLX5_HCA_VPORT_SEL_NODE_GUID)
> > > > > > > > > > > +               MLX5_SET64(hca_vport_context, ctx,
> > > > > > > > > > > node_guid,
> > > > > > > > > > > req-
> > > > > > > > > > > > node_guid);
> > > > > > > > > > >
> > > > > > > > > > >            err = mlx5_cmd_exec(dev, in, in_sz, out,
> > > > > > > > > > > sizeof(out));
> > > > > > > > > > >     ex:
> > > > > > > > > > >            kfree(in);
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Hi Max
> > > > > > > > > Re:
> > > > > > > > >
> > > > > > > > > "
> > > > > > > > > So I'm not sure that this commit is broken.
> > > > > > > > > ..
> > > > > > > > > ..
> > > > > > > > > I added prints to "mlx5_core_modify_hca_vport_context"
> > > > > > > > > function
> > > > > > > > > and
> > > > > > > > > found that we don't call it in "pure" mlx5 mode with
> > > > > > > > > PFs.
> > > > > > > > >
> > > > > > > > > Maybe you can try it too...
> > > > > > > > > "
> > > > > > > > >
> > > > > > > > > The thing is without this commit we connect
> > > > > > > > > immediately, no
> > > > > > > > > delay
> > > > > > > > > no
> > > > > > > > > issue and I am changing nothing else other than
> > > > > > > > > reverting
> > > > > > > > > here.
> > > > > > > > >
> > > > > > > > > So this clearly has a bearing directly on the
> > > > > > > > > functionality.
> > > > > > > > >
> > > > > > > > > I will look at adding more debug, but with this commit
> > > > > > > > > in
> > > > > > > > > there
> > > > > > > > > is
> > > > > > > > > nor
> > > > > > > > > evidence even of an attempt to connect and fail.
> > > > > > > > >
> > > > > > > > > Its silently faling.
> > > > > > > >
> > > > > > > > please send me all the configuration steps you run after
> > > > > > > > booting
> > > > > > > > the
> > > > > > > > target + steps in the initiator (can be also in attached
> > > > > > > > file).
> > > > > > > >
> > > > > > > > I'll try to follow this.
> > > > > > > >
> > > > > > > > Btw, did you try loopback initiator ?
> > > > > > > >
> > > > > > > > -Max.
> > > > > > > >
> > > > > > > >
> > > > > > > > > Regards
> > > > > > > > > Laurence
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > > > > Hi Max
> > > > > > >
> > > > > > > Did not try loopback because here we have actual physical
> > > > > > > connectity as
> > > > > > > that is what our customers use.
> > > > > > >
> > > > > > > Connected back to back with MLX5 cx4 HCA dual ports at EDR
> > > > > > > 100
> > > > > > > Thi sis my standard configuration used for all upstream and
> > > > > > > Red
> > > > > > > Hat
> > > > > > > kernel testing.
> > > > > > >
> > > > > > > Reboot server and client and then first prepare server
> > > > > > >
> > > > > > > Server
> > > > > > > ----------
> > > > > > >
> > > > > > > the prepare.sh script run is after boot on the server
> > > > > > >
> > > > > > >
> > > > > > > #!/bin/bash
> > > > > > > ./load_modules.sh
> > > > > > > ./create_ramdisk.sh
> > > > > > > targetcli restoreconfig
> > > > > > > # Set the srp_sq_size
> > > > > > > for i in
> > > > > > > /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300
> > > > > > > 726e4e
> > > > > > > /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300
> > > > > > > 726e4f
> > > > > > > do
> > > > > > > 	echo 16384 > $i/tpgt_1/attrib/srp_sq_size
> > > > > > > done
> > > > > > >
> > > > > > > [root@fedstorage ~]# cat load_modules.sh
> > > > > > > #!/bin/bash
> > > > > > > modprobe mlx5_ib
> > > > > > > modprobe ib_srpt
> > > > > > > modprobe ib_srp
> > > > > > > modprobe ib_umad
> > > > > > >
> > > > > > > [root@fedstorage ~]# cat ./create_ramdisk.sh
> > > > > > > #!/bin/bash
> > > > > > > mount -t tmpfs -o size=130g tmpfs /mnt
> > > > > > > cd /mnt
> > > > > > > for i in `seq 1 30`; do dd if=/dev/zero of=block-$i
> > > > > > > bs=1024k
> > > > > > > count=4000
> > > > > > > ; done
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Client
> > > > > > > --------
> > > > > > >
> > > > > > > Once server is ready
> > > > > > >
> > > > > > > Run ./start_opensm.sh on client (I sont use the SM on a
> > > > > > > switch as
> > > > > > > we
> > > > > > > are back to back)
> > > > > > >
> > > > > > > [root@ibclient ~]# cat ./start_opensm.sh
> > > > > > > #!/bin/bash
> > > > > > > rmmod ib_srpt
> > > > > > > opensm -F opensm.1.conf &
> > > > > > > opensm -F opensm.2.conf &
> > > > > > >
> > > > > > > I will semail the conf only to you as well as the targecli
> > > > > > > config
> > > > > > > as th
> > > > > > > eout is long.
> > > > > > >
> > > > > > >
> > > > > > > Then run start_srp.sh
> > > > > > >
> > > > > > > [root@ibclient ~]# cat ./start_srp.sh
> > > > > > > run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10
> > > > > > > -t
> > > > > > > 7000
> > > > > > > -ance -i mlx5_0 -p 1 1>/root/srp1.log 2>&1 &
> > > > > > > run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10
> > > > > > > -t
> > > > > > > 7000
> > > > > > > -ance -i mlx5_1 -p 1 1>/root/srp2.log 2>&1 &
> > > > > > >
> > > > > > > [root@ibclient ~]# cat /etc/ddn/srp_daemon.conf
> > > > > > > a      queue_size=128,max_cmd_per_lun=32,max_sect=32768
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > I see that you're link is IB.
> > > > > >
> > > > > > I was working on RoCE link layer with rdma_cm.
> > > > > >
> > > > > > I'll try to find some free IB setup tomorrow in my lab..
> > > > > >
> > > > > > Can you try login using rdma_cm ? need to load ib_ipoib for
> > > > > > that in
> > > > > > IB
> > > > > > network.
> > > > > >
> > > > > > I'm trying to understand whether it's related to the link
> > > > > > layer.
> > > > > >
> > > > > > p.s. I think the target configuration file didn't arrive.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > > Max,
> > > > >
> > > > > Yes, I am, working primarily with SCSI over RDMA Protocol with
> > > > > Infiniband HCA's in IB mode.
> > > > > I am not using ROCE.
> > > > >
> > > > > Also lets not forget this is a target only issue, the latest
> > > > > 5.6
> > > > > kernel
> > > > > runs untouched with no issues on the initiator when the target
> > > > > runs
> > > > > either 5.4 or 5.6 with the revert.
> > > > > It would run fine with the target on 5.5 as well if I reverted
> > > > > the
> > > > > commit on 5.5 too.
> > > > >
> > > > > I am not able at this time to switch these adapters to Ethernet
> > > > > mode
> > > > > and ROCE
> > > > >
> > > > > The weird thing is the failure is completely silent so
> > > > > something in
> > > > > the
> > > > > Link layer with IB has to failing early.
> > > > > Thje other strange observation is that the IB interfaces come
> > > > > up with
> > > > > no issue.
> > > > > I will try add some debug after reboot into the failing kernel.
> > > > >
> > > > > Regards
> > > > > Laurence
> > > > >
> > > > >
> > > > >
> > > >
> > > > Max,
> > > > Rupesh in cc here will be testing latest upstream on a
> > > > client/server
> > > > configuration with ROCE and report back here on if he sees a
> > > > similar
> > > > issue with the LIO target with that commit.
> > > >
> > > > I will continue working on the IB srpt issue by adding some
> > > > debug.
> > > >
> > > > If you think about anything related to the commit let me know.
> > >
> > > Laurence,
> > >
> > > As I said above, the most chances are that I removed some RW
> > > initialization that wasn't protected by field_select and wasn't
> > > marked in our PRM as RW field.
> > >
> > > The question is which one.
> >
> > I think that I know what is missing.
> > Can you please try this patch?
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > index 1faac31f74d0..23f879da9104 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> > @@ -1071,6 +1071,9 @@ int mlx5_core_modify_hca_vport_context(struct
> > mlx5_core_dev *dev,
> >                 MLX5_SET64(hca_vport_context, ctx, port_guid, req-
> > >port_guid);
> >         if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
> >                 MLX5_SET64(hca_vport_context, ctx, node_guid, req-
> > >node_guid);
> > +       MLX5_SET(hca_vport_context, ctx, cap_mask1, req->cap_mask1);
> > +       MLX5_SET(hca_vport_context, ctx, cap_mask1_field_select,
> > +                req->cap_mask1_perm);
> >         err = mlx5_cmd_exec(dev, in, in_sz, out, sizeof(out));
> >  ex:
> >         kfree(in);
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Regards
> > > > Laurence
> > > >
> >
> >
>
> Leon,
>
> That patch does resolve the issue.
> Tested with CX4 with mlx5 with SRP over IB to LIO target.
> Please add a fixes to that commit tag with this one when you send it.
>
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
> Tested-by:   Laurence Oberman <loberman@redhat.com>

Thanks Laurence,

Saeed will send the patch to the netdev very soon.

>
> Thanks very much
> Laurence
>
>
