Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFD5250580
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHXRQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:16:43 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13669 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgHXQgo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 12:36:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43ec5c0000>; Mon, 24 Aug 2020 09:35:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 09:36:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 09:36:41 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 16:36:41 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 16:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBR3li7QF5AMY7D3tOKDxryDr2BGSIchGTAWmhLxkHE+ylbRYm9UuOUwrqr60qAB7dS4ioKa5gRVTm7byzHJiDvvoCrMxqJH2mkcnS0jXuhCg8K3W5rd8DR+TlqQmQac+MAxAjk6jqIwhBnHDckkGCbtlYhoLE9uE222WWWXoKHIJPtBAbGy5hMKVNZaqGM4HqyX/ypLr05N3gaV9EpIZY4PVZD6OrtmQv/KS+yYU1+9Tg1V/62Z+b3+ydB7sJDZ4go7BPt3XrhZiEOQcGb0KhDLMxnFBimBEB5uKT9fETIKip8CHuXie2O22q0e8a/6lWJvFI1VmGOQ7YQvjERQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/+9xHHrEwFL7cdJKA9sW5yjCCspixwrNbNycHWVPXY=;
 b=Hgkela0Ry8htUXUMfpQzGg/CfdqGn9L6S/RUGUV713X2m0MgqWyx+49nPT47OQmDatPxQtDrTK11qNvooMQsMA9Ej+3x+yaukDYmfypywSsl2Jnjz5Q6cfpAPOXk1kJ0mEg6vShAF3qTUaCVcclFXANcpGmuBctY45UOuR9FWXChfCHCoZoherR29DqycITV4ydtHleSs2fk1eDooASuPgUq6q+lnIy67NJgoe6PawL64KfD0pDlz3h5LZ+HAUUdFgBagg5Dlo58IQ3pE8/3fYJQKEhOEdfF4DpAWJkYRNO9adYaEhwXhX1eTPCcqnaNZBIbGlihDzIVMi6XI8IGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 16:36:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 16:36:40 +0000
Date:   Mon, 24 Aug 2020 13:36:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <yishaih@mellanox.com>, <jackm@dev.mellanox.co.il>,
        <ranro@mellanox.com>
Subject: Re: [PATCH for-rc v2 0/6] Add CM packets missing and harden the
 proxying
Message-ID: <20200824163638.GA3179735@nvidia.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200803061941.1139994-1-haakon.bugge@oracle.com>
X-ClientProxiedBy: MN2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:208:134::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:208:134::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:36:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAFSY-00DLD4-Fw; Mon, 24 Aug 2020 13:36:38 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39327be7-6fcd-4d33-fed0-08d8484be05e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2488:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24882526044FA4366E7F1AE9C2560@DM5PR12MB2488.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKqpkD6CF5zFKAMn7/T7XVZmSruontiEACIs/L0vEnUTRIS3h93ZvWU16NW4yhB17ZjZuBSGqDo8XdNcM6+egPq0y4cRhU/PUSOvCPyufnMzfX2m/c8krQC4zTG2s6jPMG8YPreqo0MwBY+VSIfbR8rxn3jp/k9k46STu8e15Fm0TD12y4wNw5HeuLylkzFcG3s7Ky4W/dxScNCHS8ph4eSPbu6W7+nOcw/YzO8s1HGA9HUKL3s109zpnaKuZ8aFJYWpzUQdO29pgzsJse5Gcl0Bg74ye76nqhkMZlAr+mDGjyIqNd0OoRqzlzGc9t+qVKz2//ONDx3dZxOY6Vfg5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(4744005)(9746002)(9786002)(2906002)(2616005)(478600001)(186003)(8676002)(5660300002)(86362001)(1076003)(66476007)(66556008)(426003)(316002)(26005)(66946007)(33656002)(4326008)(107886003)(8936002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0J7huWu1cClVPyB4pPW2jmeWOT1KBUn56ghYOBxXx2yDfIM6TuWps4bYOHhvTF3y2EEQ7I4Nug7STUXDJROpM6IVQuklRlD5eYXoRVhVDjet7eAAlLea1MYJRkbm1vnT2hUfvjEPaE0LtCQUnIjUmo9KXsVPGJLkKzo9bvm5ThT36eW7QKJojEnqjgW2P6y/wtQ2ucqCg91QsNlB0Q9SaAfh4OofUPgNaZniM01oxgU5NXnwFuA7wXMi5fQbgv1AtAzUZbPnXN/WlK8+FGQEFVMIVWi5i3ke/v65H8wIhffA/o1qcWpb1vTgT206q4TbVlV/J+t2Kj12v57K4pG2aajt2Z5YOdVEq8GBE6f5dgU2n1TIkKqWhwrFxiTb/mb7Pd3jL/ICq2KkHEf9TVd0fHYEkL9jomwfsbSY2XqXOvdIlrLYhkLtePNSf9iIMcopZO/WJIm3IS3bkWiEzrgXjbf+axtr8Z8RrEZ/o3lAwx/cZiy9OoijVaAbf/gik/YZC4UFSqJlDMSsEMwYWooVVW8Lak7tiDFp5mFsf87Bnu39m6MpEV2TUlk1vGF42rL1D2EBh6eLn8jaZWIs6Iap07qc3nPQsmK85pAWq3JlypIKizcolD+XwinH5XnuHpTuMMTB8/yV9aSdxfiY08SGQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39327be7-6fcd-4d33-fed0-08d8484be05e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:36:40.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG56mj9D2Gm2NaiYeF1mkUKNPFVgrXxsExBhE+ILylrnpb9syWqbKBED2AXFkzdm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598286940; bh=9pVsSan8tLwo4rVR94hsi3rJsUEnnvPDSXioQgfJbAs=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Exchange-Transport-Forked:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=fmTs/DZRqUn6xpoXOWe5qeSbisTCE6UlNg/LjE1gQMJwW2jjhv1RIk7LSry8xtQgY
         vaPdfXfCKveRQARJ2gvB7uiWYPepV3JOcHDf/+irtt4elsPOBBf/LLt/Birwh+M/HK
         1HesjuxoY3vCO2ZqRddhG29EjGokuxgMzLnOEN2rY/YB4lMX4ZJ49auuLziyPvvHsa
         ASAWGWQ1TE3tb4hgFyVVqGgDmcNcdw1LmgvZuTl71DhU2uPOEMRacqQhak17mEH/9e
         vXFhimt3ANg6XU7Z/o1KUruB79F36cJGbPGHBn5RdjPLDkEAk8jfU3y6iT8fNhJyh0
         sAKCk9xmIHhiw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 03, 2020 at 08:19:35AM +0200, H=C3=A5kon Bugge wrote:
> A high number of MAD packet drops are observed in the mlx4 MAD proxy
> system. These are fixed by separating the parameters for the tunnel
> vs. wire QPs and by introducing a separate worker-thread for the wire
> QPs.
>=20
> Support for MRA and REJ with its reason being timeout is also added.
>=20
> Dynamic debug prints adjusted and amended.
>=20
>     v1->v2:
> 	* Added commit ("Adjust delayed work when a dup is observed")
> 	* Minor adjustments in some of the commits
>=20
> H=C3=A5kon Bugge (6):
>   IB/mlx4: Add and improve logging
>   IB/mlx4: Add support for MRA
>   IB/mlx4: Separate tunnel and wire bufs parameters
>   IB/mlx4: Fix starvation in paravirt mux/demux
>   IB/mlx4: Add support for REJ due to timeout
>   IB/mlx4: Adjust delayed work when a dup is observed

Applied to for-next, this does not look like -rc material

Thanks,
Jason
