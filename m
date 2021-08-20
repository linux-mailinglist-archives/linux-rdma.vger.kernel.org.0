Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC63F3278
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 19:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhHTRu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 13:50:28 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:21216
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233386AbhHTRu0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 13:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emaGvqZEb/XhStbjdeqqdVpq1yGDyVYkJaqIaY80oF7AbcFasDUlN9Gvas5eI65Jyd7LwtDX0UR97A0HXsCocaUANas8m/s3acziKR9o5lkPW8wUdYH2dJiR4mtrqvCDl90koUw/+wCs7Sp11imqBgUTwRdNLiRbtG4bfWQ0tozrPI4A4rAHflnVedikZOfSE1kKYOGLeTjVVhb6X2kA1fPUyGvhAvgQx0vbdQMDeVdsncHBP70MYpcALEJQFALr0hNFwHCa3vNn7GYxDD1RlDu6yo6eeftP9OmzAAVco13l+QN8bMaQVddd2magVtq9wwmKRQBrN+vjuwJZbnkP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NVrkMbgDuAo8IaDBV2pGrl7iJVRq7eFVmxJRabIeGg=;
 b=O2qyezpYivZxJpVcsOkhMdVexGkUTIaPgdWddj8CmhuMXMA2YsX2/d1excsJmoVLRrH1ZGPqT78PRRY8gZRBT3YaQYq4/yeI47sZUVEX7xE9d8RGfhyTKj0W0NVoxTnQkqoDpS9C+X+9LmI+dy7FsAmBsrymMCyOkaQPNiGoBY6UgorSOr+4sCl+ThY7UhwKJGxCNRzia77kcfIfqb8PEq3j2rdJpd09xA7ToHqedV1df/AEkIZaLB148kkTASG3jsoWy7NcUXOjgSF2uwfOaaEddF672fRjQoTNpYPTv159TpsAnS29S9IwFMSM1QA+QIbtRkh8nt+9YnxU5JIBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NVrkMbgDuAo8IaDBV2pGrl7iJVRq7eFVmxJRabIeGg=;
 b=l0J8OkcnbQWQra4xqNwhPDn4az4W77Nzzn0HHZmCGr00Sy0UsQCjGJBxB82edKTvfrwIGecqhzRWKjMIiSuydUQ643Yp0U6bNrYo86LiGAfI/5rgUFCRLSm/IjYEmd+JJnsiBjN298jTSqUKmhDKwvxG0PjJBHBvGAXj0IyqEI+PgK1tzGZI01KYPGq6mz3H9caZNJQR0Zp4XYiFjON1sMajJaj8mpRhUR9hE5LvQywTTRayQrNcKC8gSoVHc6cgiLjFgLXGpt2+MqN1VUNNSKtj8kTrpayv/VbAZMT0mFWriMj/lz9Hgdco4ePAPDYCfGqhqp2HIAmWdfB4lsBONQ==
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 17:49:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 17:49:47 +0000
Date:   Fri, 20 Aug 2021 14:49:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shai Malin <smalin@marvell.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        mkalderon@marvell.com, davem@davemloft.net, kuba@kernel.org,
        aelior@marvell.com, pkushwaha@marvell.com,
        prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH for-next 0/3][v2] qedr: consider dscp prio for vlan tag
 and update tos
Message-ID: <20210820174944.GA539584@nvidia.com>
References: <20210730065001.805-1-smalin@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730065001.805-1-smalin@marvell.com>
X-ClientProxiedBy: YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTBPR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 17:49:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH8eG-002GPo-Ux; Fri, 20 Aug 2021 14:49:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9502b61f-c2c4-445d-9773-08d96402e6c9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5303:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53032A2E9682A6E8AC1AE863C2C19@BL1PR12MB5303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyoWvHolxsfeJvEUPGb65oDUWrc0ZBkCN2RX96dyrbFkKmlCwh3+3QzDm6Sv4PgkziZG/UBNjvfBsjq7UBURE1qfRUqH13JMaFziwOEoXVIvFnRKR37R5w0OM+8mHFwneobjFHMri3Q2lNFwJJ7dWyKlTBSWJOmkvoq4dc5Ga4Eta1tpFCneZ9xisyMD8biUxgE3fig47SmLpYrjcUJBLyreGp30pvDblDZ3S79srAkHgrE2Vius8GudhK3m43hPKNOEYctkJz9nUS42Xs+WTh7uObZ+jevlOfOW/AF+bZGK/VUhOBuAXZU9GEMi2X96mNkUiW+PxQZdy6Y5nDfLN+8kpYm1/c1jaHfju5nxVUO7X9nyr5YVZ2bI7oqSnZG+BYxnlYEZe7VoiqGz43O/hHy/c1g53312zEP3KUTMyZHp1GaefN8L8yOMEhBv9hisl7Ypx0600tZ0IZWBVP22uQUE+93M6Kl2mlhtQ4o4dchdVxC2uzXzyNWM6HiYJH9n+HmAcdFs38swzu4DrAiwsbAthHpcI1+Qi6iNgwcWCicSeR+W4jWlMXVB7gc3wop156y0hm2Rptj6t6y3UTjfWq1UBrr9IEs2E3r+Az8R1nQd2c0aKWqqblzT6fbyXsM2lY9lI2k9ks9iR+6e5wTJgKJU9e/W5lsjI+ygXeVUOzvw8olQyJ88+oFI7/ioEWV1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(36756003)(9746002)(1076003)(8936002)(83380400001)(186003)(15650500001)(4326008)(6916009)(26005)(9786002)(5660300002)(33656002)(316002)(2616005)(478600001)(66476007)(2906002)(426003)(86362001)(7416002)(66946007)(66556008)(38100700002)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GDLHN6rVfnJw9HZ+1yd5ujjlFclQ0fqgI4lT/Yc6cin505G05ZAHBSez1Qdg?=
 =?us-ascii?Q?l4rxNVS96/gQkyX8yHtXtT1qdtY5eADcoNe6WkJRpG4gmS7N+FNyEwcUf+ae?=
 =?us-ascii?Q?1piQ6ffDW9elJmlaHOO9hfAFc4TfrWeklZMwJU4JTH7G5CBkKpJJwAtdFb1Q?=
 =?us-ascii?Q?wfggzoFx+bQ3h4r8jX8lhCHB62/+1rMgosY3uZ5rXwdYQ2SAFprO2Dpi46UR?=
 =?us-ascii?Q?895zaRzmm/wwtIRMllT7dm2jyHGE9GW637Ca/Rt6lrm+2ykBLvXlGBHVmqGp?=
 =?us-ascii?Q?zOJZ9YHJ9hUiLIYYEUdXOduoo0itQEw4yNA+4dvRBX/6ZebdNEWLZ282MGDE?=
 =?us-ascii?Q?IxEtGvxR9shCA0r6sGB/ENCvQ2v5D50n/L+7bW+fYKPUO3fhwNplyWKgbDhh?=
 =?us-ascii?Q?iTC/IEULWbDDMEAlJJCoS5KYEWdaQayrAprrRLNjBLP2UczDaOQD3qzOb3/w?=
 =?us-ascii?Q?2OQE/ZE0CEwuoqxskhrEkoP0zf9StubGKbjfkm7R0zVAhAfaK1d90koUuEN7?=
 =?us-ascii?Q?A5NVUYUSVpXve5BvyNT+Ryh7lYN1G7f/rA9R1j3/+rahY8MBoi+cIRDft0AZ?=
 =?us-ascii?Q?TJ/GbLxmJMRDWl3QyZ3fIfzdVT/jDPLBjovBuL8O+BOLJiDdTAxXSO7hT76l?=
 =?us-ascii?Q?N94NZ75vyXmW4gY5puumi49cmV2jsMSGaQ4M6bayL2LWjNC+gFGap8Pcoz5e?=
 =?us-ascii?Q?pXaee/GnFnLNBa/wU1z6mkbnBOH4cQEVQsEO+cbYczCdukQA9ODdOLYf4fk9?=
 =?us-ascii?Q?cI5c4RPv++PzAZAYVEkwI0eA9ti1CU1mlvrxTrdnL2dyoaXveQ8Fsih29ZdM?=
 =?us-ascii?Q?fPgynl9YSG9enpvQcioyrHhXFuanQfI7LiEsFjk2NP2RiR0SY7oNUOXX9w0h?=
 =?us-ascii?Q?vyfDtA0ukBd7S27ykow3jxJT2mGOowHitDjeSBtJIDCSRjF3yRli4i7vB4V6?=
 =?us-ascii?Q?oXji6+5BI3vLPkrBvESXLClui18mRY0igZyVqBQC9k38jmYa5oJzynf+sBl/?=
 =?us-ascii?Q?yhrcNjOTIHtjpWT7qrDpmmHq3bP3LTFBxWFvoHFEw81ff7dBu2BD1ZRZ80OL?=
 =?us-ascii?Q?t9IiLarQ6BOS5KhkilnQ4D2RUneidq/TWd+4rix7zh+veyHWdBcDWjz3r23N?=
 =?us-ascii?Q?+S0KeE+N6fXZFVEdIfSvwl0yNOI0t/ARmazPjtOEelF1AMflhJToeF2wvXQh?=
 =?us-ascii?Q?ZCXNPxSbwlQxPo02zGecbFB20sTgjRbUaSywMYM1VxhTOvqf2s0m4KrcTogE?=
 =?us-ascii?Q?hd1O6O2Bk0RTpkWWMXzfasRUQTtuZssqScN5MIL5v1APpj6P8adDRtob4cQW?=
 =?us-ascii?Q?EWOAHmPG/YPnWfMmO8C0G0XX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9502b61f-c2c4-445d-9773-08d96402e6c9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 17:49:47.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPsAe8llUhGrAjiIXyL26YWom6yAvtKFaLJCfR9czQoBDaEkD0R2yGseU0wUhgFh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 09:49:58AM +0300, Shai Malin wrote:
> From: Prabhakar Kushwaha <pkushwaha@marvell.com>
> 
> Add functions to check get/set dscp priority in qed and these functions
> are further used in deciding vlan priority based on dscp state.
> 
> Also update RDMA CM TOS.
> 
> Changes for v2:
> 	- incorporated Leon Romanovsky's comments
> 
> Prabhakar Kushwaha (3):
>   qed: add get and set support for dscp priority
>   qedr: Consider dscp priority for vlan priority
>   qedr: Use grh layer traffic_class as RDMA CM TOS
> 
>  drivers/infiniband/hw/qedr/qedr_roce_cm.c  | 13 +++-
>  drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 71 ++++++++++++++++++++++
>  drivers/net/ethernet/qlogic/qed/qed_dcbx.h | 10 +++
>  drivers/net/ethernet/qlogic/qed/qed_rdma.c | 25 ++++++++
>  include/linux/qed/qed_if.h                 |  6 ++
>  include/linux/qed/qed_rdma_if.h            |  7 +++
>  6 files changed, 130 insertions(+), 2 deletions(-)

Since this is mostly netdev stuff can someone from netdev ack this if
you want it to go through the rdma tree?

Have you checked that there are no conflicts with things in net-next?

Thanks,
Jason
